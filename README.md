# nvim
My Config Neovim

### Dependences
  - ripgrep, gopls, xclip

### Install dependences:
```sh
# archlinux
sudo pacman -S neovim ripgrep gopls xclip

# ubuntu
sudo apt-get install neovim ripgrep gopls xclip

# fedora
sudo dnf install neovim ripgrep gopls xclip
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
