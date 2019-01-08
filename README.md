# vfRegression

To run the tests on this code locally on machine, login-azurermaccount, set-azurermcontext to the correct subscription and then 

```powershell
 .\invokePester.ps1 -SourceDir C:\Source\github\vfRegression -local $true
```

Change this to 

```powershell
 .\invokePester.ps1 -SourceDir .\ -local $false
```

...when running in AzureDevOps
(Running a deployment locally on your machine)

```powershell
new-azurermresourcegroupdeployment -ResourceGroupName vfregression_rg -DeploymentName vfregressionDeploy -TemplateFile .\azuredeploy.json -TemplateParameterFile .\parameters.json
```
