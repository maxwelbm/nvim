# nvim
My Config Neovim

### Dependences
  - ripgrep, gopls, xclip

### Install dependences:
```sh
# archlinux
sudo pacman -S git neovim ripgrep gopls xclip

# ubuntu
sudo apt-get install git neovim ripgrep gopls xclip

# fedora
sudo dnf install git neovim ripgrep gopls xclip

# macos
brew install git neovim ripgrep gopls xclip
```

### Install configs - Linux / Macos / Windows
```sh
# install Linux / Macos
git clone https://github.com/maxwelbm/nvim ~/.config/nvim --depth 1 && nvim

# install Windows
git clone https://github.com/maxwelbm/nvim $HOME\AppData\Local\nvim --depth 1
nvim
```

### Uninstall configs - Linux / Macos / Windows
```sh
# Linux / Macos (unix)
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

# Windows
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data
```


### For testing rune this code sh in your bash:
```sh
docker run -w /root -it --rm alpine:latest sh -uelic '
  apk add git nodejs neovim ripgrep build-base wget --update
  git clone https://github.com/maxwelbm/nvim ~/.config/nvim
  nvim
  '
```

## License

This project is licensed under the terms of the [MIT](LICENSE) license.
