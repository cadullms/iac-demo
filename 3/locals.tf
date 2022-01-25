locals {
  resourceGroupName = "${var.resourceGroupName!=null?var.resourceGroupName:var.namePrefix}-rg"
  planName          = "${var.planName!=null?var.planName:var.namePrefix}-plan"
  webAppName        = "${var.webAppName!=null?var.webAppName:var.namePrefix}"
}
