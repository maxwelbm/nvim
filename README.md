# nvim
My Config Neovim

### For testing rune this code sh in your bash:
```sh
docker run -w /root -it --rm alpine:latest sh -uelic '
  apk add git nodejs neovim ripgrep build-base wget --update
  git clone https://github.com/maxwelbm/nvim ~/.config/nvim
  nvim
  '
```
