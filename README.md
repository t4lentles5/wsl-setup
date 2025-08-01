# WSL Setup

This repository provides a set of configuration files and an installation script to quickly set up a customized development environment in WSL (Windows Subsystem for Linux), primarily for Debian-based distributions like Ubuntu.

The setup includes configurations for:

- **Zsh** as the default shell, with plugins for a better experience.
- **Neovim** as a powerful and customized text editor.
- **Ranger** as a terminal file manager with icons.
- **Starship** for a minimal and informative shell prompt.
- Other useful tools like `eza` (a modern `ls` replacement) and `bat` (a `cat` clone with syntax highlighting).

## Prerequisites

- A Debian-based Linux distribution running on WSL (e.g., Ubuntu).
- `git` installed to clone the repository.

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Obrn544/wsl-setup.git
    ```

2.  **Navigate to the repository directory:**

    ```bash
    cd wsl-setup
    ```

3.  **Copy the script to your home directory and make it executable:**

    ```bash
    cp install.sh ~/
    chmod +x ~/install.sh
    ```

4.  **Run the installation script from your HOME directory:**
    ```bash
    cd ~
    ./install.sh
    ```

### What the script does:

- **Checks for dependencies:** It verifies if `bat`, `eza`, `neovim`, `ranger`, and `zsh` are installed. If not, it will attempt to install them using `apt`.
- **Backs up existing files:** It creates a backup of your existing configurations for `nvim`, `ranger`, `zsh`, and your `.zshrc` file. Backups are stored in `~/.WSLSetupBackup`.
- **Copies new configurations:** It copies the configuration files from this repository to their respective locations in `~/.config/` and your home directory.
- **Installs Zsh plugins:** It clones necessary plugins like `zsh-autosuggestions` and `zsh-syntax-highlighting`.
- **Installs Pokemon Colorscripts:** For a bit of fun in your terminal.
- **Changes the default shell:** It will set `zsh` as your default shell.

5.  **Reboot WSL:**
    After the script finishes, you need to restart your WSL instance for all changes, especially the new default shell, to take effect. You can do this by closing the terminal and opening it again, or by running `wsl --shutdown` in PowerShell/CMD and then starting a new WSL terminal.

## Uninstallation / Reverting

The script creates a timestamped backup of your original configuration files in the `~/.WSLSetupBackup` directory. To revert the changes, you can manually restore your files from that directory.
