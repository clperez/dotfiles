# dotfiles

https://www.atlassian.com/git/tutorials/dotfiles

git init --bare $HOME/.cfg
function fn_config { &"$env:PROGRAMFILES\Git\cmd\git.exe" --git-dir=$home\.cfg\ --work-tree=$home $args }
Set-Alias -Name config -Value fn_config -Option Private
