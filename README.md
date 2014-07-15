settings
========

My dotfiles.

To checkout in the (non-empty!) home directory execute:

    cd
    git init
    git remote add origin git@github.com:trebor8x/settings.git
    git pull origin master
    git branch --set-upstream-to=origin/master master
    # checkout submodules:
    git submodule init
    git submodule update
