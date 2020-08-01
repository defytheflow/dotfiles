
# File:     profile.ps1
# Created:  27.07.2020
# Author:   Artyom Danilov (@defytheflow)


# dirs
function api { cd ~/Dev/Repos/Work/api }
function web { cd ~/Dev/Repos/Work/web }
function cfg { cd ~/Dev/Repos/Work/cfg }

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
function Git-Add { & git add }
function Git-Add-All { & git add --all }
function Git-Branch { & git branch }
function Git-Commit-Amend { & git commit --amend }
function Git-Commit { & git commit }
function Git-Clone { & git clone }
function Git-Checkout { & git checkout }
function Git-Diff { & git diff }
function Git-Log { & git log }
function Git-Merge { & git merge }
function Git-Move { & git mv }
function Git-Push { & git push }
function Git-Push-Force { & git push --force }
function Git-Pull { & git pull }
function Git-Rebase { & git rebase -i }
function Git-Rev-List { & git rev-list --count HEAD }
function Git-Reset { & git reset }
function Git-Revert { & git revert }
function Git-Status { & git status }
function Git-Show { & git show }

New-Alias -Name 'ga'  -Value 'Git-Add'
New-Alias -Name 'gaa' -Value 'Git-Add-All'
New-Alias -Name 'gb'  -Value 'Git-Branch'
New-Alias -Name 'gca' -Value 'Git-Commit-Amend'
New-Alias -Name 'gco' -Value 'Git-Commit'
New-Alias -Name 'gcl' -Value 'Git-Clone'
New-Alias -Name 'gch' -Value 'Git-Checkout'
New-Alias -Name 'gd'  -Value 'Git-Diff'
New-Alias -Name 'glo'  -Value 'Git-Log'
New-Alias -Name 'gme'  -Value 'Git-Merge'
New-Alias -Name 'gmv' -Value 'Git-Move'
New-Alias -Name 'gpu'  -Value 'Git-Push'
New-Alias -Name 'gpf' -Value 'Git-Push-Force'
New-Alias -Name 'gpl' -Value 'Git-Pull'
New-Alias -Name 'grb' -Value 'Git-Rebase'
New-Alias -Name 'grl' -Value 'Git-Rev-List'
New-Alias -Name 'grs' -Value 'Git-Reset'
New-Alias -Name 'grv' -Value 'Git-Revert'
New-Alias -Name 'gs'  -Value 'Git-Status'
New-Alias -Name 'gsh' -Value 'Git-Show'

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

