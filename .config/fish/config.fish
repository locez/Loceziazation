if status is-interactive
    starship init fish | source
    zoxide init --cmd cd fish | source
    atuin init fish | source
    # Commands to run in interactive sessions can go here
end

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
set -gx MAMBA_EXE "/usr/bin/mamba"
set -gx MAMBA_ROOT_PREFIX "/home/locez/.local/share/mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
~/.local/bin/mise activate fish | source
