# History configuration
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

eval "$(fzf --bash)"
eval "$(zoxide init --cmd cd bash)"
eval "$(starship init bash)"

source "$(blesh-share)"/ble.sh --attach=none # does not work currently

bleopt prompt_ps1_transient=trim
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

EDITOR=nvim

alias ls="eza --all --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

tree() {
    local level="$1"
    if [[ -z "$level" ]]; then
        level=1  # Nivel predeterminado si no se proporciona uno
    fi
    eza -T --icons=always -L="$level"
}

alias ff="fastfetch"

# alias to nix shell/flakes
alias pyshell="nix-shell ~/tedius-os/Shells/python/"
alias pyflake="nix develop ~/tedius-os/Shells/python/"
alias jsshell="nix-shell ~/tedius-os/Shells/js-ts/"
alias jsflake="nix develop ~/tedius-os/Shells/js-ts/"
alias hsshell="nix-shell ~/tedius-os/Shells/haskell/"
alias hsflake="nix develop ~/tedius-os/Shells/haskell/"

run-typ() {
  # Verificar que se haya proporcionado un argumento
  if [ "$#" -ne 1 ]; then
    echo "Uso: run-typ <archivo-sin-extension>"
    return 1
  fi

  # Nombre del archivo Typst (sin extensión)
  local DOCUMENT="$1"

  # Ejecutar Typst en modo watch y abrir el PDF
  typst watch "${DOCUMENT}.typ" &  # Corre el modo watch en segundo plano
  local PID=$!  # Guarda el PID del proceso

  # Asegurarse de que el PDF existe antes de abrirlo
  while [ ! -f "${DOCUMENT}.pdf" ]; do
    sleep 1
  done

  # Abrir el archivo PDF
  xdg-open "${DOCUMENT}.pdf"

  # Esperar a que termine el proceso watch
  wait $PID
}

[[ ! ${BLE_VERSION-} ]] || ble-attach
