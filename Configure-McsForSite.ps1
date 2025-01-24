param (
    [Parameter(Mandatory=$true)]
    [string]$siteUrl,

    [Parameter(Mandatory=$true)]
    [string]$botUrl,

    [Parameter(Mandatory=$true)]
    [string]$botName,

    [Parameter(Mandatory=$true)]
    [string]$customScope,

    [Parameter(Mandatory=$true)]
    [string]$clientId,

    [Parameter(Mandatory=$true)]
    [switch]$greet,

    [Parameter(Mandatory=$true)]
    [string]$authority
)

Connect-PnPOnline -Url $siteUrl -Interactive -ClientID "db858e58-1204-4de2-96bf-2db867f60da6"
$action = (Get-PnPCustomAction | Where-Object { $_.Title -eq "PvaSso" })[0]

$action.ClientSideComponentProperties = @{
    "botURL" = $botUrl
    "customScope" = $customScope
    "clientID" = $clientId
    "authority" = $authority
    "greet" = $greet.isPresent
    "botName" = $botName
} | ConvertTo-Json -Compress

$action.Update()
Invoke-PnPQuery