if status is-interactive
    if type -q starship
        starship init fish | source
    end

    if type -q zoxide
        zoxide init --cmd cd fish | source
    end

    if type -q atuin
        atuin init fish | source
    end

    # Commands to run in interactive sessions can go here
end

if type -q mise
    mise activate fish | source
end
