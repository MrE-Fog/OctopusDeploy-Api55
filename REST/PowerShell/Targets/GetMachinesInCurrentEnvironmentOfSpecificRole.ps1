﻿##CONFIG##
$APIKey = "" #Octopus API
$Role = "" #Role you are looking for

##PROCESS##
$OctopusURL = $OctopusParameters['Octopus.Web.BaseUrl']
$EnvironmentID = $OctopusParameters['Octopus.Environment.Id']
$header = @{ "X-Octopus-ApiKey" = $APIKey }

$environment = (Invoke-WebRequest "$OctopusURL/api/environments/$EnvironmentID" -Headers $header).content | ConvertFrom-Json

$machines = ((Invoke-WebRequest ($OctopusURL + $environment.Links.Machines) -Headers $header).content | ConvertFrom-Json).items

$MachinesInRole = $machines | ?{$Role -in $_.Roles}

##OUTPUT##

#Name of machines in Octopus
$MachinesInRole.Name

#URI of machines
$MachinesInRole.URI