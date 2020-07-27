
# File:     profile.ps1
# Created:  27.07.2020
# Author:   Artyom Danilov


# vim
New-Alias -Name 'v'   -Value 'nvim'
New-Alias -Name 'vi'  -Value 'nvim'
New-Alias -Name 'vim' -Value 'nvim'

# touch
New-Alias -Name 'tc'    -Value 'New-Item'
New-Alias -Name 'touch' -Value 'New-Item'

# cd
function ..    { cd .. }
function ...   { cd ../../ }
function ....  { cd ../../../ }
function ..... { cd ../../../../ }

# ls
New-Alias -Name 'l'  -Value 'ls'
New-Alias -Name 'la' -Value 'ls'
New-Alias -Name 'll' -Value 'ls'

function ld { ls -Directory }
function lf { ls -File }
function lh { ls -Hidden }
function lr { ls -Recurse }

# git
function GitAdd         { & git add }
function GitAddAll      { & git add --all }
function GitBranch      { & git branch }
function GitCommit      { & git commit }
function GitCommitAmend { & git commit --amend }
function GitClone       { & git clone }
function GitCheckout    { & git checkout }
function GitDiff        { & git diff }
function GitLog         { & git log }
function GitMerge       { & git merge }
function GitMove        { & git mv }
function GitPush        { & git push }
function GitPushForce   { & git push --force }
function GitPull        { & git pull }
function GitRebase      { & git rebase -i }
function GitRevList     { & git rev-list --count HEAD }
function GitReset       { & git reset }
function GitRevert      { & git revert }
function GitStatus      { & git status }
function GitShow        { & git show }

New-Alias -Name 'gia'  -Value 'GitAdd'
New-Alias -Name 'giaa' -Value 'GitAddAll'
New-Alias -Name 'gib'  -Value 'GitBranch'
New-Alias -Name 'gic'  -Value 'GitCommit'
New-Alias -Name 'gica' -Value 'GitCommitAmend'
New-Alias -Name 'gicl' -Value 'GitClone'
New-Alias -Name 'gico' -Value 'GitCheckout'
New-Alias -Name 'gid'  -Value 'GitDiff'
New-Alias -Name 'gil'  -Value 'GitLog'
New-Alias -Name 'gim'  -Value 'GitMerge'
New-Alias -Name 'gimv' -Value 'Gitmove'
New-Alias -Name 'gip'  -Value 'GitPush'
New-Alias -Name 'gipf' -Value 'GitPushForce'
New-Alias -Name 'gipl' -Value 'GitPull'
New-Alias -Name 'girb' -Value 'GitRebase'
New-Alias -Name 'girl' -Value 'GitRevList'
New-Alias -Name 'girs' -Value 'GitReset'
New-Alias -Name 'girv' -Value 'GitRevert'
New-Alias -Name 'gis'  -Value 'GitStatus'
New-Alias -Name 'gish' -Value 'GitShow'

# pip
# Set-Alias pip='pip3'
# Set-Alias pif='pip freeze'
# Set-Alias pin='pip install'
# Set-Alias pun='pip uninstall'

# django
# Set-Alias djsa='django-admin startapp'
# Set-Alias djch='django-admin check'
# Set-Alias djdb='django-admin dbshell'
# Set-Alias djm='django-admin migrate'
# Set-Alias djmm='django-admin makemigrations'
# Set-Alias djr='django-admin runserver'
# Set-Alias djsh='django-admin shell'
# Set-Alias djsu='django-admin createsuperuser'
# Set-Alias djt='django-admin test'

# python
# Set-Alias py='python3'
# Set-Alias ipy='ipython'
# Set-Alias ipython='ipython3'
# Set-Alias python='python3'

# # dirs
# Set-Alias api='cd ~/dev/repos/work/api'
# Set-Alias web='cd ~/dev/repos/work/web'
# Set-Alias cfg='cd ~/dev/repos/work/cfg'
