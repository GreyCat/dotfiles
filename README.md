## Installation

This dotfiles repo is supposed to be used with [chezmoi](https://www.chezmoi.io/).

### Full-featured Ubuntu

```shell
sudo snap install chezmoi --classic
chezmoi init GreyCat --apply
```

### Full-featured RedHat

```shell
wget https://github.com/twpayne/chezmoi/releases/download/v2.48.2/chezmoi-2.48.2-x86_64.rpm
sudo rpm -U chezmoi-2.48.2-x86_64.rpm
chezmoi init GreyCat --apply
```

### Bare Linux

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply GreyCat
```

### Short-lived machines

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot GreyCat
```

### Windows devbox

```powershell
choco install -y chezmoi
chezmoi init GreyCat --apply
```

## Updates

```shell
chezmoi update
```
