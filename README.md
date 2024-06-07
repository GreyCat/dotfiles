## Installation

This dotfiles repo is supposed to be used with [chezmoi](https://www.chezmoi.io/).

### Full-featured Ubuntu

```shell
sudo snap install chezmoi --classic
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
