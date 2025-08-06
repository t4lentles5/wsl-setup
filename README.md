# WSL Setup

This repository provides a set of configuration files and an installation script to quickly set up a customized development environment in WSL (Windows Subsystem for Linux), primarily for Debian-based distributions like Ubuntu.

The setup includes configurations for:

- **Zsh** as the default shell, with plugins for a better experience.
- **Neovim** as a powerful and customized text editor.
- **Ranger** as a terminal file manager with icons.
- **Starship** for a minimal and informative shell prompt.
- Other useful tools like `eza` (a modern `ls` replacement) and `bat` (a `cat` clone with syntax highlighting).

---

## Prerequisites

To ensure all features and visual elements of this setup work correctly, especially with Neovim and the custom shell prompt, you'll need the following:

- A Debian-based Linux distribution running on WSL (e.g., Ubuntu).
- `git` installed to clone the repository.
- **Neovim v0.10.0 or newer:** Many of the Neovim plugins used in this configuration, like `blink.cmp` and `Noice.nvim`, rely on features available only in Neovim version 0.10.0 or later.

> [!TIP]
> If your distribution's package manager provides an older version, consider installing Neovim via its official [AppImage](https://github.com/neovim/neovim/releases) or a specific PPA for newer versions. On WSL, you might also need to install `libfuse2` (`sudo apt install libfuse2` or `libfuse2t64` for newer distributions) to run AppImages.

- **A Nerd Font installed on your system:**

> [!NOTE]
> This is crucial for displaying the various icons used by `Neo-tree`, `nvim-web-devicons`, and your shell prompt (Starship). Without it, you'll see corrupted characters instead of icons.
>
> **Recommendation:** **JetBrains Mono Nerd Font** is an excellent choice for its readability and comprehensive glyph support. You can download it from [Nerd Fonts](https://www.nerdfonts.com/font-downloads), install it on your Windows system, and then configure your terminal emulator (e.g., Windows Terminal) to use it.

- **Starship (optional, but recommended):** While the setup helps configure Starship, you'll benefit most if you've already had it installed on your system, as it's the core component for your shell prompt.

---

## Installation

1.  **Clone the repository:**

    ```bash
    git clone [https://github.com/Obrn544/wsl-setup.git](https://github.com/Obrn544/wsl-setup.git)
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

---

## Uninstallation / Reverting

The script creates a timestamped backup of your original configuration files in the `~/.WSLSetupBackup` directory. To revert the changes, you can manually restore your files from that directory.
