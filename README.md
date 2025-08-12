# WSL Setup

This repository provides a set of configuration files and an installation script to quickly set up a customized development environment in WSL (Windows Subsystem for Linux), primarily for Debian-based distributions like Ubuntu.

The setup includes configurations for:

|                                                                         Ranger                                                                         |
| :----------------------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="https://res.cloudinary.com/diu2godjy/image/upload/v1754523320/Captura_de_pantalla_2025-08-06_183512_agudwp.png" alt="Ranger" align="center"> |

|                                                                         Neovim                                                                         |
| :----------------------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="https://res.cloudinary.com/diu2godjy/image/upload/v1754522954/Captura_de_pantalla_2025-08-06_182857_fd2jmr.png" alt="Neovim" align="center"> |

|                                                                         ZSH + Starship                                                                         |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="https://res.cloudinary.com/diu2godjy/image/upload/v1754523205/Captura_de_pantalla_2025-08-06_183314_b6mqlv.png" alt="ZSH + Starship" align="center"> |

---

## Prerequisites

To ensure all features and visual elements of this setup work correctly, especially with Neovim and the custom shell prompt, you'll need the following:

- A Debian-based Linux distribution running on WSL (e.g., Ubuntu).
- **Neovim v0.10.0 or newer:** Many of the Neovim plugins used in this configuration, like `blink.cmp` and `Noice.nvim`, rely on features available only in Neovim version 0.10.0 or later.

> [!TIP]
> If your distribution's package manager provides an older version, consider installing Neovim via its official [AppImage](https://github.com/neovim/neovim/releases) or a specific PPA for newer versions. On WSL, you might also need to install `libfuse2` (`sudo apt install libfuse2` or `libfuse2t64` for newer distributions) to run AppImages.

    ```bash
    curl -LO https://github.com/neovim/neovim/releases/download/v0.10.2/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    ```
    
- **A Nerd Font installed on your system:**

> [!NOTE]
> This is crucial for displaying the various icons used by `Neo-tree`, `nvim-web-devicons`, and your shell prompt (Starship). Without it, you'll see corrupted characters instead of icons.
>
> **Recommendation:** **JetBrains Mono Nerd Font** is an excellent choice for its readability and comprehensive glyph support. You can download it from [Nerd Fonts](https://www.nerdfonts.com/font-downloads), install it on your Windows system, and then configure your terminal emulator (e.g., Windows Terminal) to use it.

- **Starship:** This is a minimal, blazing-fast, and extremely customizable prompt for any shell.
    ```bash
    curl -sS https://starship.rs/install.sh | sh
    ```

---

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/t4lentles5/wsl-setup.git
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

---

## Keyboard Shortcuts

This section provides a summary of the keybindings configured for Neovim in this setup. The `<leader>` key is set to `Space`.

### General

| Keybinding        | Description                     |
| :---------------- | :------------------------------ |
| `<leader>w`       | Save current file               |
| `jk`              | Exit insert mode                |
| `<leader>q`       | Quit Neovim                     |
| `+` / `-`         | Increment/decrement numbers     |
| `<C-a>`           | Select all text in the file     |
| `>` / `<`         | Indent selected lines           |
| `te`              | Open a new tab                  |
| `<C-b>` / `<C-f>` | Scroll up/down in documentation |
| `<C-Space>`       | Trigger code completion         |
| `<C-e>`           | Abort completion                |
| `<CR>`            | Confirm completion              |

### Window and Buffer Management

| Keybinding       | Description                    |
| :--------------- | :----------------------------- |
| `<leader>sh`     | Split window horizontally      |
| `<leader>sv`     | Split window vertically        |
| `<C-h/j/k/l>`    | Navigate between window splits |
| `<C-Up/Down>`    | Resize split horizontally      |
| `<C-Left/Right>` | Resize split vertically        |
| `<Tab>`          | Go to the next buffer          |
| `<S-Tab>`        | Go to the previous buffer      |
| `<leader>c`      | Close the current buffer       |
| `<c-\>`          | Toggle floating terminal       |

### File Explorer and Navigation

| Keybinding        | Description                       |
| :---------------- | :-------------------------------- |
| `<leader>e`       | Toggle file explorer (`neo-tree`) |
| `<leader><space>` | Smart find files                  |
| `<leader>,`       | List open buffers                 |
| `<leader>/`       | Search for text in files (Grep)   |
| `<leader>:`       | Show command history              |
| `<leader>ff`      | Find files within the project     |
| `<leader>fr`      | List recent files                 |
| `<leader>fc`      | Find configuration files          |

### Git Integration

| Keybinding   | Description                   |
| :----------- | :---------------------------- |
| `<leader>gs` | View Git status               |
| `<leader>gl` | View Git log                  |
| `<leader>gL` | View Git log for current line |
| `<leader>gb` | List Git branches             |
| `<leader>gS` | List Git stash                |
| `<leader>gd` | View Git diff (hunks)         |

### LSP and Diagnostics

| Keybinding   | Description                         |
| :----------- | :---------------------------------- |
| `gd`         | Go to definition                    |
| `gD`         | Go to declaration                   |
| `gr`         | Find references                     |
| `gI`         | Go to implementation                |
| `gy`         | Go to type definition               |
| `<leader>ss` | List LSP symbols in document        |
| `<leader>sS` | List LSP symbols in workspace       |
| `<leader>xx` | Toggle diagnostics list (Trouble)   |
| `<leader>xw` | Toggle diagnostics for current file |
| `<leader>xl` | Toggle location list (Trouble)      |
| `<leader>xq` | Toggle quickfix list (Trouble)      |
