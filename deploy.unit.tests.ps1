
#Requires -Modules Pester
<#
.SYNOPSIS
    Tests a specific ARM template
.EXAMPLE
    Invoke-Pester 
.NOTES
    This file has been created as an example of using Pester to evaluate ARM templates
#>

$ResourceGroupName="vfRegression_rg"

$scriptPath = $env:BUILD_SOURCESDIRECTORY

$templateFileName = "azuredeploy.json"
$templateFileLocation = "$scriptPath\$templateFileName"

Describe "vfRegression Deployment Tests" {
  BeforeAll {
    $DebugPreference = "Continue"
  }

  AfterAll {
    $DebugPreference = "SilentlyContinue"
  }

  Context "When vfRegression template is deployed" {
    $output = Test-AzureRmResourceGroupDeployment `
              -ResourceGroupName $ResourceGroupName `
              -TemplateFile $TemplateFileLocation `
              -ErrorAction Stop `
               5>&1
    $result = (($output[32] -split "Body:")[1] | ConvertFrom-Json).properties

   # $output | out-file "rawtestresult.json"
   # write-host $result.validatedResources

    It 'Has a JSON template' {        
        $templateFileLocation | Should Exist
    }

    It 'Converts from JSON and has the expected properties' {
      $expectedProperties = '$schema',
                            'contentVersion',
                            'outputs',
                            'parameters',
                            'resources',                                
                            'variables'
      $templateProperties = (get-content $templateFileLocation | ConvertFrom-Json -ErrorAction SilentlyContinue) | Get-Member -MemberType NoteProperty | % Name
      $templateProperties | Should Be $expectedProperties
    }


    It "Should be deployed successfully" {
      $result.provisioningState | Should -Be "Succeeded"
    }

   }
}