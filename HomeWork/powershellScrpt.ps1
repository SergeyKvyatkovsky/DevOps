powershell -Command Set-ExecutionPolicy RemoteSigned

$HTTP_Request = [System.Net.WebRequest]::Create('https://localhost:10933')
$HTTP_Response = $HTTP_Request.GetResponse()
$HTTP_Status = [int]$HTTP_Response.StatusCode

If ($HTTP_Status -eq 200) {
    Write-Host "Site is OK!"
}
Else {
    Write-Host "The Site may be down, please check!"
}

# Finally, we clean up the http request by closing it.
$HTTP_Response.Close()

ping www.google.com -t
