# vfRegression

To run the tests on this code locally on machine, login-azurermaccount, set-azurermcontext to the correct subscription and then 

~~~~
 .\invokePester.ps1 -SourceDir C:\Source\github\vfRegression -local $true
~~~~

Change this to 

~~~~
 .\invokePester.ps1 -SourceDir .\ -local $false
~~~~
...when running in AzureDevOps