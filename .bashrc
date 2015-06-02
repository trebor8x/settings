# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

HISTSIZE=40000

# User specific aliases and functions
export PATH="~/.living-in-a-box/bin:$PATH"

# Aliasing hub as git
eval "$(hub alias -s)"
