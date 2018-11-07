# setup dotfiles for Linux
## Summary
This is a utility for deploying dotfiles.
If you execute install shell, symbolic links of dotfiles are expanded to home directory.

## How to use
### Standard
```
git clone https://github.com/gimKondo/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

### Operated by another user
The tilde is expanded to home path of current user.
If you want to expand another directory, pass the target path.
ex) deploying to vagrant user by root user operation

```
git clone https://github.com/gimKondo/dotfiles /home/vagrant/dotfiles
chown -R /home/vagrant/dotfiles
/home/vagrant/dotfiles/install.sh /home/vagrant
```

## Extra
### local gitconfig
You can add and override setting on .gitconfig.
If you hope, add .local.gitconfig at home directory.

Typically, user name mail address are written on .local.gitconfig.

### local zshrc
You can add and override setting on .zshrc.
If you hope, add .zshrc_local at home directory.

## Limitation
- .tmux.conf expect tmux2.1 or later
