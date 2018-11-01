powershell -Command Set-ExecutionPolicy RemoteSigned

$HTTP_Request = [System.Net.WebRequest]::Create('https://localhost:10933')
$HTTP_Response = $HTTP_Request.GetResponse()
$HTTP_Status = [int]$HTTP_Response.StatusCode

If ($HTTP_Status -eq 200) {
    Write-Host "Site is OK!"
....Stop-Process Start-Process -PassThru -FilePath $OctopusParameters["Octopus.Action[Deploy 1].Output.Package.InstallationDirectoryPath"] \musicstore.exe
}
Else {
    Write-Host "The Site may be down, please check!"
    
}

$HTTP_Response.Close()
Stop-Process Start-Process -PassThru -FilePath $OctopusParameters["Octopus.Action[Deploy 1].Output.Package.InstallationDirectoryPath"] \musicstore.exe

ping www.google.com -t
