# WSL Setup

This repository provides a set of configuration files and an installation script to quickly set up a customized development environment in WSL (Windows Subsystem for Linux), primarily for Arch Linux.

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

- An Arch-based Linux distribution running on WSL.
 
- **A Nerd Font installed on your system:**

> [!NOTE]
> This is crucial for displaying the various icons used by `Neo-tree`, `nvim-web-devicons`, and your shell prompt (Starship). Without it, you'll see corrupted characters instead of icons.
>
> **Recommendation:** **JetBrains Mono Nerd Font** is an excellent choice for its readability and comprehensive glyph support. You can download it from [Nerd Fonts](https://www.nerdfonts.com/font-downloads), install it on your Windows system, and then configure your terminal emulator (e.g., Windows Terminal) to use it.

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

| Keybinding | Description |
| :--- | :--- |
| `<leader>w` | Save current file |
| `jk` | Exit insert mode |
| `<leader>q` | Quit Neovim |
| `+` / `-` | Increment/decrement numbers |
| `<C-a>` | Select all text in the file |
| `>` / `<` | Indent selected lines |
| `te` | Open a new tab |
| `<leader>f` | Format file |

### Window and Buffer Management

| Keybinding | Description |
| :--- | :--- |
| `<leader>sh` | Split window horizontally |
| `<leader>sv` | Split window vertically |
| `<C-h/j/k/l>` | Navigate between window splits |
| `<C-Up/Down>` | Resize split vertically |
| `<C-Left/Right>` | Resize split horizontally |
| `<Tab>` | Go to the next buffer |
| `<S-Tab>` | Go to the previous buffer |
| `<leader>c` | Close the current buffer |
| `<C-\>` | Toggle floating terminal |

### File Explorer and Navigation

| Keybinding | Description |
| :--- | :--- |
| `<leader>e` | Toggle file explorer (`neo-tree`) |
| `<leader>/` | Search in current buffer |
| `<leader>*` | Search word under cursor in current buffer |
| `<leader>ff` | Find files |
| `<leader>fg` | Grep project |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |

### Git Integration

| Keybinding | Description |
| :--- | :--- |
| `<leader>gs` | View Git status |
| `<leader>gl` | View Git log |
| `<leader>gL` | View Git log for current line |
| `<leader>gb` | List Git branches |
| `<leader>gS` | List Git stash |
| `<leader>gd` | View Git diff (hunks) |
| `<leader>gg` | Open LazyGit |

### LSP and Diagnostics

| Keybinding | Description |
| :--- | :--- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `<leader>ss` | List LSP symbols in document |
| `<leader>sS` | List LSP symbols in workspace |
| `<leader>xx` | Toggle diagnostics list (Trouble) |
| `<leader>xw` | Toggle diagnostics for current file |
| `<leader>xl` | Toggle location list (Trouble) |
| `<leader>xq` | Toggle quickfix list (Trouble) |

### Tailwind CSS

| Keybinding | Description |
| :--- | :--- |
| `<leader>cv` | Show Tailwind CSS values |
| `<leader>cS` | Toggle Tailwind CSS classes sort on save |
