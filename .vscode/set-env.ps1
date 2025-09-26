# set-env.ps1

try {
    $pwd = op read "op://Labs-Sandboxes/SnowflakeDemo/password" 2>$null
    if (-not $pwd) { throw "Failed to fetch Snowflake password from 1Password" }
    $env:SNOWFLAKE_PASSWORD = $pwd
    Write-Host "SET SNOWFLAKE_PASSWORD from 1Password"

    $account = op read "op://Labs-Sandboxes/SnowflakeDemo/add more/AccountId" 2>$null
    if (-not $account) { throw "Failed to fetch Snowflake account from 1Password" }
    $env:SNOWFLAKE_ACCOUNT = $account
    Write-Host "SET SNOWFLAKE_ACCOUNT from 1Password"

    $user = op read "op://Labs-Sandboxes/SnowflakeDemo/username" 2>$null
    if (-not $user) { throw "Failed to fetch Snowflake username from 1Password" }
    $env:SNOWFLAKE_USER = $user
    Write-Host "SET SNOWFLAKE_USER from 1Password"

} catch {
    Write-Error $_
    exit 1
}
