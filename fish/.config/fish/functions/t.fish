function t -w cd -d "Jump around" -a key
    switch $key
        case pro
            cd ~/Projects
        case dot
            cd ~/Dotfiles

        case uni
            cd ~/University
        case doc
            cd ~/Documents
        case des
            cd ~/Desktop

        case fish
            cd ~/Dotfiles/fish/.config/fish
        case vim
            cd ~/Dotfiles/nvim/.config/nvim

        case qmk
            cd ~/Projects/qmk_firmware/keyboards/atreis/keymaps/rphln

        case '*'
            cd $argv
    end
end
