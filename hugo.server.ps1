<#PSScriptInfo
.VERSION      0.1.0
.GUID         efe4b366-f480-4c24-b5ac-4c0ac8073ecb
.AUTHOR       Kai Kimera
.AUTHOREMAIL  mail@kaikim.ru
.LICENSEURI   https://choosealicense.com/licenses/mit/
.PROJECTURI   https://kaikim.ru/
#>

#Requires -Version 7.2

<#
.SYNOPSIS
Starting the Hugo server.

.DESCRIPTION
The script starts the Hugo server with specific parameters.

.EXAMPLE

.LINK
#>

# -------------------------------------------------------------------------------------------------------------------- #
# CONFIGURATION
# -------------------------------------------------------------------------------------------------------------------- #

param(
  [string]$Hugo = -join ((Get-Item -Path "${PSScriptRoot}"), '\', 'hugo.exe'),
  [string]$Src = ((Get-Item -Path "${PSScriptRoot}").Parent),
  [string]$Env = ((Get-Item -Path "${PSScriptRoot}").Parent.Name),
  [int]$Port = 1313
)

# -------------------------------------------------------------------------------------------------------------------- #
# -----------------------------------------------------< SCRIPT >----------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

function Start-HugoServer() {
  $CMD = @(
    'server',
    '--environment', "${Env}",
    '--port', "${Port}",
    '--buildDrafts',
    '--printI18nWarnings',
    '--source', "${Src}"
    '--cacheDir', "${Src}\cache",
    '--gc'
  )

  & "${Hugo}" $CMD
}

function Start-Script() {
  Start-HugoServer
}; Start-Script
