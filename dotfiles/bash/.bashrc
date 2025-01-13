# Exit if not an interactive shell
case $- in
    *i*) ;;  # Continue if interactive
      *) return;;
esac

# History configuration
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Automatically adjust LINES and COLUMNS when the window size changes
shopt -s checkwinsize

# Identify chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

# Initialize zoxide
unset -f cd
eval "$(zoxide init bash)"
eval "$(starship init bash)"

alias ls='exa -a --color=always --long --git --no-filesize --icons --no-time --no-user --no-permissions'
alias cd='z'
alias cdi='zi'
alias bat='batcat'

# Programmable completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/fzf-git.sh/fzf-git.sh
. "$HOME/.cargo/env"

# Created by `pipx` on 2025-01-05 15:41:46
export PATH="$PATH:/home/tedius/.local/bin"
