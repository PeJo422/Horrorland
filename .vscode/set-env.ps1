# set-env.ps1
$env:SNOWFLAKE_PWD = op read "op://Labs-Sandboxes/SnowflakeDemo/password"
Write-Host "SNOWFLAKE_PWD satt med 1Password"  -Encoding UTF8