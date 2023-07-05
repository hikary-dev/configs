function fish_user_key_bindings
    switch $TERM
        case rxvt-unicode-256color
            bind \cH backward-kill-path-component
        case xterm-256color
            bind \c? backward-kill-path-component
    end
end

