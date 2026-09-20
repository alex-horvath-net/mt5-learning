$projectRoot = Split-Path $PSScriptRoot -Parent

. "$projectRoot\config\local.ps1"

Copy-Item `
  "$projectRoot\src\Experts\LearningEA\*" `
  "$Mt5DataPath\MQL5\Experts\LearningEA\" `
  -Recurse -Force

New-Item `
  "$Mt5DataPath\MQL5\Include\LearningEA" `
  -ItemType Directory `
  -Force | Out-Null

Copy-Item `
  "$projectRoot\src\Include\LearningEA\*" `
  "$Mt5DataPath\MQL5\Include\LearningEA\" `
  -Recurse -Force