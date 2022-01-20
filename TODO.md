the plan
========

1. Create repo with devcontainer for bicep, terraform, az cli, put this plan in

2. finish outline
- intro story:
    - who has not seen that thing fail in prod for some config/infra issue?
    - We can address this by using code
    - On-prem that was difficult
    - But now with the cloud it is mandatory
- Overview of IaC Options in the cloud with logos
- demo: first thing az
- story: but what happens if we run this a second time to apply a change? idempotency needed, as well we will end up with script bugs
- story: declarative/describe desired state
- demo: arm template generated from the portal in vs code
- story: how difficult this was, even after we had good integration in vs code
- story: so now guess how delighted i was when i found this terraform thing
- demo: terraform locally, show in portal that it does not create a deployment
- story: terraform works for all clouds, kubernetes and so much more.
- story: I was asked often how terraform could be efficiently used to abstract all that away to simply make a switch? it doesn't. 
- story: to be able to track all the things and know when it can should delete resources, it needs to track state
- story: state adds another layer of complexity. often we will run into situations where state and real world don't match. a lot of errrors.
- story: now, but we are only using Azure anyway. Isn't there an easier way, without terraform's complexity but more readable than ARM templates?
- story: Yes, there is! Bicep to the rescue!
- demo: convert our template into bicep with az bicep decompile
- demo: show that thing in a pipeline
- story: now how should this come together with our app code?
- demo: show how third factor can be used with our connection string coming from an app setting that was preconfigured via the infra pipeline
- story: show overview slide of pipeline that shows infra and app pipelines with stages/envs to support third factor
- story: show overview of IaC Options again with taglines:
  - imperative script: simple to start for small things, can often be copied from getting-started articles on docs.microsoft.com
  - arm template: Low level Azure native option for declarative IaC
  - terraform: Multicloud declarative IaC plattform, easy syntax, powerful but complex
  - bicep: ARM Templates with easy syntax but without added complexity
- story: if you want to use a programming language you already know, then you can check out pulumi and terraform cdk as well
- story: example code slides, one for pulumi, one for tf cdk

3. Create outline slides
4. Create demos