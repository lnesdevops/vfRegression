
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
              -TemplateParameterFile "$scriptPath\parameters.json" `
              -ErrorAction Stop `
               5>&1
    $result = (($output[32] -split "Body:")[1] | ConvertFrom-Json).properties

   $output | out-file "rawtestresult.json"
   write-host $result.validatedResources

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

    $arrayOfServers = "lnvfregsql01", "lnvfregsql02", "lnvfregsql03", "lnvfregsql04"


    #generic server tests

    # It "lnvfregrds01 should exist"
    # {}

    # It "lnvfregrds01 should be located in westeurope"
    # {}
    
    # It "lnvregrds01 should report into main storage account"
    # {}

    # It "lnvregrds01 should have a NIC"
    # {}

    # It "lnvregrds01 should be added to correct adSubnet"
    # {}

    # It "lnvregrds01 should be added to correct vNET"
    # {}

    # It "lnvregrds01 should attempt to Join Domain"
    # {}

    # It "lnvregrds01 should be a 2016 server"
    # {}

    # It "lnvregrds01 should run InstallStandardApps"
    # {}

    # It "lnvregrds01 should auto shutdown"
    # {}

    #specific server tests

   }
}