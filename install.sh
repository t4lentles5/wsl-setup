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
  echo -en "
	               %%%
	        %%%%%//%%%%%
	      %%************%%%
	  (%%//############*****%%
	%%%%%**###&&&&&&&&&###**//
	%%(**##&&&#########&&&##**
	%%(**##*****#####*****##**%%%
	%%(**##     *****     ##**
	   //##   @@**   @@   ##//
	     ##     **###     ##
	     #######     #####//
	       ###**&&&&&**###
	       &&&         &&&
	       &&&////   &&
	          &&//@@@**
	            ..***
  WSL Setup\n\n"
  printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
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

dependences=(bat eza neovim ranger zsh)

is_installed() {
  apt list --installed 2>/dev/null | grep "^$1$" >/dev/null
}

printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for package in "${dependences[@]}"; do
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

for folder in nvim ranger zsh; do
  if [ -d "$HOME/.config/$folder" ]; then
    if mv "$HOME/.config/$folder" "$backup_folder/${folder}_$date" 2>> RiceError.log; then
      printf "%s%s%s folder backed up successfully at %s%s/%s_%s%s\n" "${BLD}" "${CGR}" "$folder" "${CBL}" "$backup_folder" "$folder" "$date" "${CNC}"
      sleep 1
    else
      printf "%s%sFailed to backup %s folder. See %sRiceError.log%s\n" "${BLD}" "${CRE}" "$folder" "${CBL}" "${CNC}"
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

cp -f "$HOME"/dotfiles/config/starship.toml "$HOME"/.config
cp -f "$HOME"/dotfiles/home/.zshrc "$HOME"

printf "\n\n%s%sFiles copied succesfully!!%s\n" "${BLD}" "${CGR}" "${CNC}"
sleep 5
