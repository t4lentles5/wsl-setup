#!/usr/bin/env bash

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

backup_folder=~/.WSLSetupBackup
date=$(date +%Y%m%d-%H%M%S)

logo() {
  local text="${1:?}"

  printf '%s[%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
}

########## ---------- You must not run this as root ---------- ##########

if [ "$(id -u)" = 0 ]; then
  echo "This script MUST NOT be run as root user."
  exit 1
fi

home_dir=$HOME
current_dir=$(pwd)

if [ "$current_dir" != "$home_dir" ]; then
  printf "%s%sThe script must be executed from the HOME directory.%s\n" "${BLD}" "${CYE}" "${CNC}"
  exit 1
fi

########## ---------- Welcome ---------- ##########

logo "Welcome!"
printf '%s%sThis script will check if you have the necessary dependencies, and if not, it will install them\n. After that, it will create a backup of your files, and then copy the new files to your computer.\n\nYou will be prompted for your root password to install missing dependencies and/or to switch to zsh shell if its not your default.\n\nThis script doesnt have the potential power to break your system, it only copies files from my repository to your HOME directory.%s\n\n' "${BLD}" "${CRE}" "${CNC}"

while true; do
  read -rp " Do you wish to continue? [y/N]: " yn
  case $yn in
    [Yy]* ) break ;;
    [Nn]* ) exit ;;
    * ) printf " Error: just write 'y' or 'n'\n\n" ;;
  esac
done
clear

########## ---------- Install packages ---------- ##########

logo "Installing needed packages.."

dependencies=(bat eza ranger zsh highlight python3-pygments w3m w3m-img atool unrar p7zip-full ffmpegthumbnailer libimage-exiftool-perl mediainfo poppler-utils imagemagick odt2txt libarchive-tools transmission-cli lynx elinks)

is_installed() {
  apt list --installed 2>/dev/null | grep "^$1$" >/dev/null
}

printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for package in "${dependencies[@]}"; do
  if ! is_installed "$package"; then
    if sudo apt install "$package" -y >/dev/null 2>> WSLSetupError.log; then
      printf "%s%s%s %shas been installed succesfully.%s\n" "${BLD}" "${CYE}" "$package" "${CBL}" "${CNC}"
      sleep 1
    else
      printf "%s%s%s %shas not been installed correctly. See %sWSLSetupError.log %sfor more details.%s\n" "${BLD}" "${CYE}" "$package" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
      sleep 1
    fi
  else
    printf '%s%s%s %sis already installed on your system!%s\n' "${BLD}" "${CYE}" "$package" "${CGR}" "${CNC}"
    sleep 1
  fi
done
sleep 5
clear

########## ---------- Backup files ---------- ##########

logo "Backup files"

printf "If you already have a powerful and super Pro NEOVIM configuration, write 'n' in the next question. If you answer 'y' your neovim configuration will be moved to the backup directory.\n\n"

while true; do
  read -rp "Do you want to try my nvim config? (y/n): " try_nvim
  if [[ "$try_nvim" == "y" || "$try_nvim" == "n" ]]; then
    break
  else
    echo "Invalid input. Please enter 'y' or 'n'."
  fi
done

printf "\nBackup files will be stored in %s%s%s/.WSLSetupBackup%s \n\n" "${BLD}" "${CRE}" "$HOME" "${CNC}"
sleep 10

[ ! -d "$backup_folder" ] && mkdir -p "$backup_folder"

for folder in ranger zsh; do
  if [ -d "$HOME/.config/$folder" ]; then
    if mv "$HOME/.config/$folder" "$backup_folder/${folder}_$date" 2>> WSLSetupError.log; then
      printf "%s%s%s folder backed up successfully at %s%s/%s_%s%s\n" "${BLD}" "${CGR}" "$folder" "${CBL}" "$backup_folder" "$folder" "$date" "${CNC}"
      sleep 1
    else
      printf "%s%sFailed to backup %s folder. See %sWSLSetupError.log%s\n" "${BLD}" "${CRE}" "$folder" "${CBL}" "${CNC}"
      sleep 1
    fi
  else
    printf "%s%s%s folder does not exist, %sno backup needed%s\n" "${BLD}" "${CGR}" "$folder" "${CYE}" "${CNC}"
    sleep 1
  fi
done

if [[ $try_nvim == "y" ]]; then
  # Backup nvim
  if [ -d "$HOME/.config/nvim" ]; then
    if mv "$HOME/.config/nvim" "$backup_folder/nvim_$date" 2>> WSLSetupError.log; then
      printf "%s%snvim folder backed up successfully at %s%s/nvim_%s%s\n" "${BLD}" "${CGR}" "${CBL}" "$backup_folder" "$date" "${CNC}"
      sleep 1
    else
      printf "%s%sFailed to backup nvim folder. See %sWSLSetupError.log%s\n" "${BLD}" "${CRE}" "${CBL}" "${CNC}"
      sleep 1
    fi
  else
    printf "%s%snvim folder does not exist, %sno backup needed%s\n" "${BLD}" "${CGR}" "${CYE}" "${CNC}"
    sleep 1
  fi
fi

if [ -f ~/.zshrc ]; then
  if mv ~/.zshrc "$backup_folder"/.zshrc_"$date" 2>> WSLSetupError.log; then
    printf "%s%s.zshrc file backed up successfully at %s%s/.zshrc_%s%s\n" "${BLD}" "${CGR}" "${CBL}" "$backup_folder" "${date}" "${CNC}"
  else
    printf "%s%sFailed to backup .zshrc file. See %sWSLSetupError.log%s\n" "${BLD}" "${CRE}" "${CBL}" "${CNC}"
  fi
else
  printf "%s%sThe file .zshrc does not exist, %sno backup needed%s\n" "${BLD}" "${CGR}" "${CYE}" "${CNC}"
fi

########## ---------- Copy folders ---------- ##########

logo "Copy folders.."
printf "Copying files to respective directories..\n"

[ ! -d ~/.config ] && mkdir -p ~/.config

for dirs in ~/wsl-setup/config/*; do
  dir_name=$(basename "$dirs")
# If the directory is nvim and the user doesn't want to try it, skip this loop
  if [[ $dir_name == "nvim" && $try_nvim != "y" ]]; then
    continue
  fi
  if cp -R "${dirs}" ~/.config/ 2>> WSLSetupError.log; then
    printf "%s%s%s %sconfiguration installed succesfully%s\n" "${BLD}" "${CYE}" "${dir_name}" "${CGR}" "${CNC}"
    sleep 1
  else
    printf "%s%s%s %sconfiguration failed to been installed, see %sWSLSetupError.log %sfor more details.%s\n" "${BLD}" "${CYE}" "${dir_name}" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
    sleep 1
  fi
done

cp -f "$HOME"/wsl-setup/config/starship.toml "$HOME"/.config
cp -f "$HOME"/wsl-setup/home/.zshrc "$HOME"

printf "
%s%sAdding execution permissions to scope.sh...%s
" "${BLD}" "${CBL}" "${CNC}"
if chmod +x "$HOME"/.config/ranger/scope.sh 2>> WSLSetupError.log; then
  printf "%s%sPermissions added succesfully!%s
" "${BLD}" "${CGR}" "${CNC}"
else
  printf "%s%sFailed to add permissions. See %sWSLSetupError.log%s
" "${BLD}" "${CRE}" "${CBL}" "${CNC}"
fi

printf "

%s%sFiles copied succesfully!!%s
" "${BLD}" "${CGR}" "${CNC}"
sleep 5

########## ---------- Cloning the zsh plugins! ---------- ##########

logo "Download zsh plugins"

plugins_dir="$HOME/.config/zsh/plugins/"

mkdir -p "$plugins_dir"

repo_url="https://github.com/zsh-users/zsh-autosuggestions"

printf "Cloning plugin from %s\n" "$repo_url"
git clone "$repo_url" "$plugins_dir/zsh-autosuggestions"
sleep 2

repo_url="https://github.com/zsh-users/zsh-syntax-highlighting"

printf "Cloning plugin from %s\n" "$repo_url"
git clone "$repo_url" "$plugins_dir/zsh-syntax-highlighting"
sleep 2

repo_url="https://github.com/zsh-users/zsh-history-substring-search"

printf "Cloning plugin from %s\n" "$repo_url"
git clone "$repo_url" "$plugins_dir/zsh-history-substring-search"
sleep 2

clear

########## ---------- Download pokemon-colorscripts! ---------- ##########

logo "Download pokemon-colorscripts"

repo_url="https://gitlab.com/phoneybadger/pokemon-colorscripts.git"

git clone "$repo_url" "$HOME/.config/pokemon-colorscripts"
sleep 2

cd "$HOME/.config/pokemon-colorscripts"
sudo ./install.sh

cd

clear

########## --------- Changing shell to zsh ---------- ##########

logo "Changing default shell to zsh"

if [[ $SHELL != "/usr/bin/zsh" ]]; then
  printf "\n%s%sChanging your shell to zsh. Your root password is needed.%s\n\n" "${BLD}" "${CYE}" "${CNC}"
  chsh -s /usr/bin/zsh
  printf "%s%sShell changed to zsh. Please reboot.%s\n\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "%s%sYour shell is already zsh\nGood bye! installation finished, now reboot%s\n" "${BLD}" "${CGR}" "${CNC}"
fi
zsh