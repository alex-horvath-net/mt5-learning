param(
    [string]$MetaEditorPath = (Join-Path $env:ProgramFiles 'MetaTrader 5\metaeditor64.exe')
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
. "$projectRoot\config\local.ps1"

if (-not (Test-Path -LiteralPath $MetaEditorPath -PathType Leaf)) {
    throw 'MetaEditor was not found. Supply its location with -MetaEditorPath.'
}

& "$PSScriptRoot\deploy.ps1"

$mql5Root = Join-Path $Mt5DataPath 'MQL5'
$eaPath = Join-Path $mql5Root 'Experts\LearningEA\LearningEA.mq5'
$ex5Path = [System.IO.Path]::ChangeExtension($eaPath, '.ex5')
$compileLog = Join-Path $env:TEMP ('LearningEA-compile-' + [guid]::NewGuid().ToString('N') + '.log')
$previousWriteTime = if (Test-Path -LiteralPath $ex5Path) {
    (Get-Item -LiteralPath $ex5Path).LastWriteTimeUtc
} else {
    [datetime]::MinValue
}
$compileStarted = [datetime]::UtcNow

Write-Output "Compile log: $compileLog"
Start-Process -FilePath $MetaEditorPath -ArgumentList @(
    '/compile:"' + $eaPath + '"'
    '/inc:"' + $mql5Root + '"'
    '/log:"' + $compileLog + '"'
) -WindowStyle Hidden -Wait

# MetaEditor can return exit code 1 on success; verify its log and output.
$log = Get-Content -LiteralPath $compileLog -Raw
Write-Output $log
if ($log -notmatch '(?m)^Result: 0 errors, 0 warnings(?:,|\s|$)') {
    throw "Compilation did not report zero errors and zero warnings. See $compileLog"
}

$compiledFile = Get-Item -LiteralPath $ex5Path
if ($compiledFile.Length -eq 0 -or
    $compiledFile.LastWriteTimeUtc -lt $compileStarted -or
    $compiledFile.LastWriteTimeUtc -le $previousWriteTime) {
    throw "Compilation did not produce a fresh, non-empty .ex5 file: $ex5Path"
}

Write-Output 'LearningEA deployed and compiled: 0 errors, 0 warnings.'
Write-Output "Fresh output: $($compiledFile.FullName)"
Write-Output "Size: $($compiledFile.Length) bytes; modified (UTC): $($compiledFile.LastWriteTimeUtc.ToString('o'))"
