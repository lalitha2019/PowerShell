#Get the html file from the web
curl.exe -s "https://wordfinder.yourdictionary.com/wordle/answers/"  > t.html


#Extract the answers part of the html
(Select-String -Pattern "pastData(.*?)revealAnswer" t.html).Matches.Value > finally.html

#replace any occurrence of a comma, square bracket (open / close), curly brace (open / close) with a carriage return and new line
(Get-Content "finally.html" ) -replace ',|\[|\]|\{|\}',  "`r`n" > answers1.txt

#remove quotes around the answer
(Get-Content "answers1.txt" ) -replace '\"',  "" > answers2.txt

#write the answer parts only
$line = Get-Content -Path "C:\Users\lalit\Documents\Learning\OutputFiles\answers2.txt" | Select-String -Pattern "answer:" 
Write-Host "Begin For Loop"
foreach( $value in $line) {
    $s = $value -split ":"
    Add-Content -Path answersOnly.txt -Value $($s[1]) 
}
Write-Host "End For Loop"