# Development Environment Setup Guide

## Table of Contents
- [Prerequisites](#prerequisites)
- [Shell Setup](#shell-setup)
- [Development Tools](#development-tools)
- [Neovim Setup](#neovim-setup)
- [Dotfiles Management](#dotfiles-management)
- [Configuration Files](#configuration-files)
- [Post-Installation Steps](#post-installation-steps)

## Prerequisites

Update system and install basic tools:
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install basic tools
sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    unzip \
    python3 \
    python3-pip \
    software-properties-common \
    cmake \
    pkg-config \
    ninja-build \
    gettext \
    ripgrep \
    fd-find \
    fzf \
    gpg
```

## Shell Setup

### Fish Shell Installation
```bash
# Install Fish
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt install -y fish

# Set as default shell
chsh -s $(which fish)

# Install Fisher (package manager for fish)
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install Fisher plugins
fisher install jethrokuan/z
fisher install PatrickF1/fzf.fish
fisher install jorgebucaran/autopair.fish
fisher install jorgebucaran/nvm.fish
```

### Install Eza (modern ls replacement)
```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

## Development Tools

### Node.js Setup
```bash
nvm install latest  # or specific version
npm install -g typescript typescript-language-server prettier
```

### Python Development Tools
```bash
pip install pyright black isort ruff ruff-lsp
```

### Lazygit Installation
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

## Neovim Setup

### Build Neovim from Source
```bash
# Clone and build Neovim (nightly)
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

### Install JetBrains Mono Nerd Font
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

## Dotfiles Management

### Initial Setup
```bash
# Create dotfiles structure
mkdir -p ~/dotfiles/{nvim/.config/nvim,fish/.config/fish,tmux}

# Clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/dotfiles/nvim/.config/nvim
rm -rf ~/dotfiles/nvim/.config/nvim/.git

# Install stow
sudo apt install stow

# Backup existing configs
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.config/fish ~/.config/fish.backup
mv ~/.tmux.conf ~/.tmux.conf.backup

# Create symlinks using stow
cd ~/dotfiles
stow nvim fish tmux
```

## Configuration Files

### Tmux Configuration
File: `~/dotfiles/tmux/.tmux.conf`
```bash
set -sg escape-time 11
set-option -g focus-events on
set -g mouse on
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set-option -g status-style bg=default
set-option -g status-fg white 
run '~/.tmux/plugins/tpm/tpm'
```

### Neovim Configurations

#### TypeScript Configuration
File: `~/dotfiles/nvim/.config/nvim/lua/plugins/typescript.lua`
```lua
return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },

  -- Enhanced TypeScript support
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim-lspconfig" },
    opts = {
      settings = {
        -- Enable inlay hints
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
}
```

#### Python Configuration
File: `~/dotfiles/nvim/.config/nvim/lua/plugins/python.lua`
```lua
return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
    },
  },

  -- Configure formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
      },
    },
  },
}
```

#### Keymaps Configuration
File: `~/dotfiles/nvim/.config/nvim/lua/config/keymaps.lua`
```lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move text up and down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste
map("v", "p", '"_dP', { desc = "Better paste" })

-- Center cursor when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })
```

#### Options Configuration
File: `~/dotfiles/nvim/.config/nvim/lua/config/options.lua`
```lua
local opt = vim.opt

-- Line numbers and indentation
opt.relativenumber = true  -- Relative line numbers
opt.scrolloff = 8         -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor
opt.expandtab = true      -- Use spaces instead of tabs
opt.tabstop = 2          -- Number of spaces tabs count for
opt.shiftwidth = 2       -- Size of an indent
opt.smartindent = true   -- Insert indents automatically

-- Search
opt.ignorecase = true    -- Ignore case in search patterns
opt.smartcase = true     -- Override ignorecase if search contains uppercase

-- Behavior
opt.undofile = true      -- Persistent undo history
opt.updatetime = 250     -- Faster completion
opt.timeoutlen = 300     -- Time to wait for mapped sequence
opt.clipboard = "unnamedplus"  -- Use system clipboard
```

## Post-Installation Steps

1. Terminal Setup
   - Set font to "JetBrainsMono Nerd Font"
   - Set font size to 13
   - Set line height to 1.2

2. Tmux Setup
   - Start tmux
   - Install plugins with `prefix + I`

3. Neovim Setup
   - Open neovim and let it install plugins
   - Verify LSP installations with `:Mason`
   - Test TypeScript configuration
   - Test Python configuration

4. Shell Setup
   - Start fish shell
   - Verify fisher plugins are working
   - Test fzf functionality
   - Verify eza aliases

## Troubleshooting

### Common Issues

1. If symlinks are not working correctly:
```bash
# Remove existing symlink
rm ~/.config/nvim
# Create new symlink with absolute path
ln -s ~/dotfiles/nvim/.config/nvim ~/.config/nvim
```

2. If Mason fails to install some packages:
```bash
# Install packages manually
npm install -g typescript-language-server
pip install ruff-lsp
```

3. If font is not detected:
```bash
# Rebuild font cache
fc-cache -fv
```

### Verification Commands

```bash
# Check installed packages
apt list --installed | grep -E "fish|neovim|stow"

# Verify symlinks
ls -la ~/.config/nvim
ls -la ~/.config/fish
ls -la ~/.tmux.conf

# Check shell version
fish --version

# Check Neovim version
nvim --version
```
