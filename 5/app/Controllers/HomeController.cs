using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using app.Models;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace app.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IConfiguration _configuration;

        public HomeController(ILogger<HomeController> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public IActionResult Index()
        {
            var versionString = "";
            // For brevity, we are directly accessing the database here...
            // ==== Don't do this at home!!! ====
            try
            {
                using (SqlConnection connection = new SqlConnection(_configuration.GetValue<string>("connectionString")))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("select @@version", connection))
                    {
                        versionString = (string)command.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error connecting to database");
                versionString = "n/a";
            }
            ViewData["Version"] = versionString;
            ViewData["environment-label"] = _configuration.GetValue<string>("environmentLabel", "n/a");
            ViewData["welcome-message"] = _configuration.GetValue<string>("welecome-message", "Welcome");
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
