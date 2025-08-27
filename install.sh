#!/usr/bin/env bash

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

backup_folder=~/.WSLSetupBackup
error_log=WSLSetupError.log
date=$(date +%Y%m%d-%H%M%S)

logo() {
  local text="${1:?}"
  local len=${#text}
  local border=$(printf '═%.0s' $(seq 1 $((len + 4))))

  printf "\n${CRE}╔${border}╗${CNC}\n"
  printf "${CRE}║${CNC}  ${CYE}${text}${CNC}  ${CRE}║${CNC}\n"
  printf "${CRE}╚${border}╝${CNC}\n\n"
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
printf '%s%sThis script will check if you have the necessary dependencies, and if not, it will install them.\nAfter that, it will create a backup of your files, and then copy the new files to your computer.\n\nYou will be prompted for your root password to install missing dependencies and/or to switch to zsh shell if it is not your default.\n\nThis script only copies files from my repository to your HOME directory.%s\n\n' "${BLD}" "${CRE}" "${CNC}"

while true; do
  read -rp " Do you wish to continue? [y/N]: " yn
  case $yn in
  [Yy]*) break ;;
  [Nn]*) exit ;;
  *) printf " Error: just write 'y' or 'n'\n\n" ;;
  esac
done
clear

########## ---------- Update system ---------- ##########

logo "Updating system..."
sudo pacman -Syu --noconfirm

########## ---------- Install packages ---------- ##########

logo "Installing needed packages.."

dependencies=(bat eza fzf highlight lazygit nvm openssl python-pygments ranger ripgrep starship ttf-jetbrains-mono-nerd xclip zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

is_installed() {
  pacman -Qi "$1" &>/dev/null
}

printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for package in "${dependencies[@]}"; do
  if ! is_installed "$package"; then
    if sudo pacman -S --noconfirm "$package" >/dev/null 2>>"$error_log"; then
      printf "%s%s%s %shas been installed successfully.%s\n" "${BLD}" "${CYE}" "$package" "${CGR}" "${CNC}"
    else
      printf "%s%s%s %shas not been installed correctly. See %s$error_log %sfor more details.%s\n" "${BLD}" "${CYE}" "$package" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
    fi
  else
    printf '%s%s%s %sis already installed on your system!%s\n' "${BLD}" "${CYE}" "$package" "${CGR}" "${CNC}"
  fi
done

yay -S --noconfirm fzf-tab-git

sleep 3
clear

########## ---------- Backup files ---------- ##########

logo "Backup files"

printf "\nBackup files will be stored in %s%s%s/.WSLSetupBackup%s \n\n" "${BLD}" "${CRE}" "$HOME" "${CNC}"
sleep 5

[ ! -d "$backup_folder" ] && mkdir -p "$backup_folder"

for folder in nvim ranger zsh; do
  if [ -d "$HOME/.config/$folder" ]; then
    mv "$HOME/.config/$folder" "$backup_folder/${folder}_$date" 2>>"$error_log" &&
      printf "%s%s%s folder backed up successfully at %s%s/%s_%s%s\n" "${BLD}" "${CGR}" "$folder" "${CBL}" "$backup_folder" "$folder" "$date" "${CNC}" ||
      printf "%s%sFailed to backup %s folder. See %s$error_log%s\n" "${BLD}" "${CRE}" "$folder" "${CBL}" "${CNC}"
  else
    printf "%s%s%s folder does not exist, %sno backup needed%s\n" "${BLD}" "${CGR}" "$folder" "${CYE}" "${CNC}"
  fi
done

for file in starship.toml .zshrc; do
  if [ -f "$HOME/.config/$file" ]; then
    mv "$HOME/.config/$file" "$backup_folder/${file}_$date" 2>>"$error_log" &&
      printf "%s%s$file file backed up successfully at %s%s/$file_%s%s\n" "${BLD}" "${CGR}" "${CBL}" "$backup_folder" "${date}" "${CNC}" ||
      printf "%s%sFailed to backup $file file. See %s$error_log%s\n" "${BLD}" "${CRE}" "${CBL}" "${CNC}"

  elif [ -f "$HOME/$file" ]; then
    mv "$HOME/$file" "$backup_folder/${file}_$date" 2>>"$error_log" &&
      printf "%s%s$file file backed up successfully at %s%s/$file_%s%s\n" "${BLD}" "${CGR}" "${CBL}" "$backup_folder" "${date}" "${CNC}" ||
      printf "%s%sFailed to backup $file file. See %s$error_log%s\n" "${BLD}" "${CRE}" "${CBL}" "${CNC}"

  else
    printf "%s%sThe file $file does not exist, %sno backup needed%s\n" "${BLD}" "${CGR}" "${CYE}" "${CNC}"
  fi
done

########## ---------- Copy folders ---------- ##########

logo "Copy folders.."
printf "Copying files to respective directories..\n"

[ ! -d ~/.config ] && mkdir -p ~/.config

for dirs in ~/wsl-setup/config/*; do
  dir_name=$(basename "$dirs")
  cp -R "${dirs}" ~/.config/ 2>>"$error_log" &&
    printf "%s%s%s %sconfiguration installed successfully%s\n" "${BLD}" "${CYE}" "${dir_name}" "${CGR}" "${CNC}" ||
    printf "%s%s%s %sconfiguration failed, see %s$error_log %sfor more details.%s\n" "${BLD}" "${CYE}" "${dir_name}" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
done

cp -f "$HOME"/wsl-setup/config/starship.toml "$HOME"/.config
cp -f "$HOME"/wsl-setup/home/.zshrc "$HOME"

chmod +x "$HOME"/.config/ranger/scope.sh 2>>"$error_log" &&
  printf "%s%sExecution permissions added to scope.sh%s\n" "${BLD}" "${CGR}" "${CNC}" ||
  printf "%s%sFailed to add permissions to scope.sh. See %s$error_log%s\n" "${BLD}" "${CRE}" "${CBL}" "${CNC}"

########## ---------- Download pokemon-colorscripts ---------- ##########

logo "Download pokemon-colorscripts"

repo_url="https://gitlab.com/phoneybadger/pokemon-colorscripts.git"
if [ ! -d "$HOME/.config/pokemon-colorscripts" ]; then
  git clone "$repo_url" "$HOME/.config/pokemon-colorscripts"
  cd "$HOME/.config/pokemon-colorscripts" || exit
  if ! sudo ./install.sh >>"$error_log" 2>&1; then
    echo "Error installing pokemon-colorscripts. See $error_log."
  fi
  cd
else
  echo "pokemon-colorscripts already installed, skipping."
fi

########## ---------- Changing shell to zsh ---------- ##########

logo "Changing default shell to zsh"

ZSH_PATH=$(command -v zsh)
if [[ $SHELL != "$ZSH_PATH" ]]; then
  printf "\n%s%sChanging your shell to zsh...%s\n\n" "${BLD}" "${CYE}" "${CNC}"
  chsh -s "$ZSH_PATH"
  printf "%s%sShell changed to zsh. Please restart WSL.%s\n\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "%s%sYour shell is already zsh.%s\n" "${BLD}" "${CGR}" "${CNC}"
fi

echo -e "\n${CYE}To apply changes, run in PowerShell: ${CGR}wsl --shutdown${CYE} and reopen WSL.${CNC}\n"
