using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
<#
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    $body = "Hello, $name. This HTTP triggered function executed successfully."
}
#>

function SelectNumber {
    param(
        [int32] $Max = 71
    )
    Get-Random -Minimum 1 -Maximum $Max
}

$selectedNumbers = New-Object -TypeName System.Collections.ArrayList

#Draw White Balls
for($i=0;$i -lt 5;$i++){
    if($i -gt 0){
        do{
            $randomNumber = SelectNumber
        }while($selectedNumbers -contains $randomNumber)
        $selectedNumbers.Add($randomNumber) | Out-Null
    }
    else {
        $selectedNumbers.Add((SelectNumber)) | Out-Null
    }
}

#Draw Mega Ball
$selectedNumbers.Add((SelectNumber -Max 26)) | Out-Null

#Print Numbers
$result = "{0} {1} {2} {3} {4} {5}" -f $selectedNumbers[0], $selectedNumbers[1], $selectedNumbers[2], $selectedNumbers[3], $selectedNumbers[4], $selectedNumbers[5]
Write-Host "Result of the drawing:  $result"

$body = $result

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
