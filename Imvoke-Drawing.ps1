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
$result
