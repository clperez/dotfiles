
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine

    # PsRead improved command history (g + arrow keys)
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd

    # Menu autocompletion
    #Set-PSReadLineKeyHandler -Key Tab -Function Complete # Bash like mode
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete # zsh mode

    # Command prediction based on history
    Set-PSReadLineOption -PredictionSource History

    # Programmable shortcuts
    ## Copy current full path to the clipboard
    Set-PSReadlineKeyHandler -Key Ctrl+Shift+C `
        -BriefDescription CopyPathToClipboard `
        -LongDescription "Copies the current path to the clipboard" `
        -ScriptBlock { (Resolve-Path -LiteralPath $pwd).ProviderPath.Trim() | clip }
}

# Import previously installed modules (with Install-Module)

Import-Module posh-git
Import-Module oh-my-posh
Set-Prompt

# jump to frequently used directories with z
Import-Module z

# DISABLED FOR NOW
## use the coreutils ls instead of Get-ChildItem
# function ls_alias { & 'C:\Program Files\Git\usr\bin\ls' --color=auto -hF $args }
# Set-Alias -Name ls -Value ls_alias -Option Private

function fn_config { &"$env:PROGRAMFILES\Git\cmd\git.exe" --git-dir=$home\.cfg\ --work-tree=$home $args }
Set-Alias -Name config -Value fn_config -Option Private

function fn_ryder { &"$env:LOCALAPPDATA\JetBrains\Toolbox\apps\Rider\ch-0\213.6775.4\bin\rider64.exe" $args }
Set-Alias -Name ryder -Value fn_ryder -Option Private

function fn_nano { &"$env:PROGRAMFILES\Git\usr\bin\nano.exe" $args }
Set-Alias -Name nano -Value fn_nano -Option Private