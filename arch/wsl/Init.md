# Install and setup of Arch in WSL

- Basic commands in wsl 
https://learn.microsoft.com/en-us/windows/wsl/basic-commands

```powershell
wsl --list --online // to list all avaliable official distro
wsl --install archlinux // downloads and installs the arch
```
Upgrade to latest 
```bash
pacman -Syu
```

### Upgrades
The base arch has bare minimum lets upgrade it 

- Adding new user [ref](https://wiki.archlinux.org/title/Users_and_groups#Example_adding_a_user)

```bash
useradd -m <username> # creats new user
passwd <username> # protect user with password
```

- install vi

```bash
pacman -S vi
```

- Install sudo and add newly created user to it

For sudo [config](https://wiki.archlinux.org/title/Sudo#Configuration)

```bash
pacman -S sudo

# sudo file is always opened in visudo and open with editor

EDITOR=vi visudo

# enable wheel group uncomment or add 
#%wheel      ALL=(ALL:ALL) ALL

# add new user to wheel group

sudo usermod -aG wheel <username>

```

- install and setup git

```bash
sudo pacman -S git
```

- install ssh for sigining 
```bash
sudo pacman -S openssh
```

- git setup

```bash
ssh-keygen -t ed25519 -C "your_email"
```

```bash
eval "$(ssh-agent -s)"
```

```bash
ssh-add ~/.ssh/id_ed25519
```

- clone mkos 
```bash
git clone git@github.com:midhunuk/mkos.git
```
- Install wget for vscode in windows
```bash
sudo pacman -S wget
```

- installing stow
```bash
sudo pacman -S stow
```

- zsh and omyzsh setup
```bash
sudo pacman -S zsh
```
```bash
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

- stow zsh config
```bash
stow -d ~/mkos -t ~ zsh
```

- Install yay
```bash
sudo pacman -S yay
```
- Installing jetbrains mono nerd font

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Download JetBrainsMono Nerd Font (latest release)
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

# Unzip it
unzip JetBrainsMono.zip

```
```bash
sudo pacman -S unzip
```

```bash
# Refresh cache
fc-cache -fv
```

- Install bat 
```bash
sudo pacman -S bat
```