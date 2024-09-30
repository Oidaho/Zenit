$theme_name = "zenit.omp.json"
$theme_path = "$env:POSH_THEMES_PATH\$theme_name"

function OutputSep {
    Write-Output "-------------------------------------------------"
}

function CopyThemeFile {
    Write-Output "Copying a theme to a directory: $env:POSH_THEMES_PATH"

    $script_path = $PSScriptRoot
    Copy-Item -Path "$script_path/../theme/$theme_name" -Destination "$theme_path" -Force
}

function OverwriteThemeFile {
    Write-Output "The theme file was found: $theme_path"
    Write-Output "It was probably installed earlier."

    $userInput = Read-Host "Would you like to continue? This will overwrite the existing 'Zenit' theme file. (y/N)"
    if ($userInput -eq "y" -or $userInput -eq "Y") {
        CopyThemeFile

    } else {
        Exit 128
    }
}

function SetAsDefault {
    $userInput = Read-Host "Do you want to set 'Zenit' as default theme?. This will overwrite the existing powershell profile. (y/N)"
    if ($userInput -eq "y" -or $userInput -eq "Y") {
        $profile_path = $PROFILE

        $init_theme = "oh-my-posh init pwsh --config '$theme_path' | Invoke-Expression"
        $disable_venv_prompt = '$env:VIRTUAL_ENV_DISABLE_PROMPT = 1'

        Set-Content -Path $profile_path -Value $init_theme
        Add-Content -Path $profile_path -Value $disable_venv_prompt
    } 
}


$exists = Test-Path -Path $theme_path -PathType Leaf
if (!$exists) {
    CopyThemeFile
    OutputSep

} else {
    OverwriteThemeFile
    OutputSep

}

Write-Output "'Zenit' theme has been successfully installed!"
SetAsDefault
OutputSep

Write-Output "Success! Restart your PowerShell."
