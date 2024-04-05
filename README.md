# helm-diff

A shell script to perform diff between two Helm releases. **This is WORK IN PROGRESS,Use at your own risk!**

## use cases 
- You made changes to *cluster* override and would like to compare the result against a previous commit or the default branch.
- You're upgrading a dependency chart and would liked to compare/see new changes


## house keeping 

Add [vim-plug](https://github.com/junegunn/vim-plug)
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Add [vim-dirdiff](https://github.com/will133/vim-dirdiff) plug-in in your `~/.vimrc`.
```vim
call plug#begin()

Plug 'will133/vim-dirdiff'

call plug#end()
```

install vim plugin 

## required packages
- helm
- vim 
- vim-plug
- git 

## Usage
Add `helm-diff.sh` to your `$PATH` variable.
```sh
helm-diff.sh <branch/commit> <helm options>
helm-diff.sh HEAD~ -f values.yaml -f d-west2-01.yaml
```

## TODO
- [ ] use Nix somehow
- [ ] word wrapping
- [ ] clean detached branch before switching to main