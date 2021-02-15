<# 
    Rename this file to register.ps1 or it will get overwritten by the future updates.
    For the list of all environment vars run `gitlab-runner register --help`.
    
    After registration, config.toml is generated and subsequent configuration changes should
    be set in that file. Gitlab-Runner automatically picks up config.toml changes while executing.
#>

$Env:RUNNER_NAME                = $env:COMPUTERNAME
$Env:REGISTRATION_TOKEN         = (Get-SSMParameter -Name /gitlab/runner/token).Value
$Env:CI_SERVER_URL              = 'https://gitlab.com/'
$Env:RUNNER_TAG_LIST            = 'aws,scooby'        #comma separated list of tags

$Env:CONFIG_FILE                = "$PSScriptRoot\config.toml"
$Env:REGISTER_RUN_UNTAGGED      = 'false'
$Env:REGISTER_LOCKED            = 'true'    #lock runner to current project 
$Env:RUNNER_EXECUTOR            = 'docker-windows'
$Env:RUNNER_SHELL               = 'powershell'

$Env:RUNNER_REQUEST_CONCURRENCY = 1
$Env:RUNNER_BUILDS_DIR          = 'c:\builds\'
$Env:RUNNER_CACHE_DIR           = 'c:\cache\'
$Env:DOCKER_IMAGE               = "mcr.microsoft.com/windows/servercore:1809_amd64"

gitlab-runner register --non-interactive

docker pull gitlab/gitlab-runner-helper:x86_64-775dd39d-servercore1809
docker pull mcr.microsoft.com/windows/servercore:1809_amd64

