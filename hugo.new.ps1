<#PSScriptInfo
.VERSION      0.1.0
.GUID         ce5647fc-1e70-4205-be4e-57586095eedf
.AUTHOR       Kai Kimera
.AUTHOREMAIL  mail@kaikim.ru
.LICENSEURI   https://choosealicense.com/licenses/mit/
.PROJECTURI   https://kaikim.ru/
#>

#Requires -Version 7.2

<#
.SYNOPSIS
Creating new content for Hugo.

.DESCRIPTION
The script allows you to create new content for Hugo.

.EXAMPLE

.LINK
#>

# -------------------------------------------------------------------------------------------------------------------- #
# CONFIGURATION
# -------------------------------------------------------------------------------------------------------------------- #

param(
  [string]$Src = ((Get-Item -Path "${PSScriptRoot}").Parent),
  [string]$Hugo = -join ((Get-Item -Path "${PSScriptRoot}"), '\', 'hugo.exe'),
  [ValidateSet('articles', 'faq', 'commands')][string]$Type = 'articles'
)

# -------------------------------------------------------------------------------------------------------------------- #
# -----------------------------------------------------< SCRIPT >----------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

function Get-HugoYear() {
  $Year = (Get-Date -Format 'yyyy')
  return $Year
}

function Get-HugoMonth() {
  $Month = (Get-Date -Format 'MM')
  return $Month
}

function Get-HugoTimestamp() {
  $Timestamp = ([DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds())
  return $Timestamp
}

function Get-HugoRandom() {
  $Random = (Get-Random -Minimum 1000 -Maximum 9999)
  return $Random
}

function Start-HugoPost() {
  $Path = "$(Get-HugoYear)/$(Get-HugoMonth)/$(Get-HugoTimestamp)_$(Get-HugoRandom)"
  $CMD = @(
    'new', 'content',
    '-k', "${Type}",
    '--source', "${Src}"
    "${Type}/${Path}"
  )

  Write-Host "${Hugo}" $CMD
}

function Start-Script() {
  Start-HugoPost
}; Start-Script
