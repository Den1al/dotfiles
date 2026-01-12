# NeoVim Configuration Guide

A modern, feature-rich NeoVim configuration with LSP support, AI-powered coding assistance, debugging capabilities, and extensive plugin ecosystem. Designed for productivity with sensible defaults and easy customization.

**Current Version**: NeoVim 0.11.0+
**Configuration Root**: `~/.config/nvim/` (or your NVIM config directory)
**Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)

---

## Quick Navigation

- [Overview](#overview)
- [Features](#features)
- [Directory Structure](#directory-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Environment Variables](#environment-variables)
- [Troubleshooting](#troubleshooting)
- [Additional Documentation](#additional-documentation)

---

## Overview

This is a carefully curated NeoVim configuration that transforms NeoVim into a powerful IDE with:

- **Language Server Protocol (LSP)** integration for intelligent code completion and navigation
- **AI-powered coding assistance** using Claude with CodeCompanion and Avante
- **Advanced debugging** capabilities with DAP support
- **Git integration** for seamless version control workflows
- **Beautiful UI** with Catppuccin theme and status line customization
- **Efficient navigation** with Telescope, Harpoon, and Tmux integration
- **Code editing tools** including comments, surround, folding, and more

The configuration is organized into logical categories for easy maintenance and customization.

---

## Features

### Core Editing
- **Syntax Highlighting**: Tree-sitter based with auto-language detection
- **Code Completion**: LSP-driven with snippet support
- **Smart Comments**: Toggle line/block comments with intuitive keymaps
- **Surround Operations**: Add, change, or delete surrounding characters
- **Code Folding**: LSP-based folding with peek functionality

### Language Support
Configured LSP servers for:
- Lua, JavaScript/TypeScript, Python, Go, OCaml, Markdown, Bash, Java, Jinja2, Docker

Auto-detection and formatting for each language via None-LS

### Navigation & Search
- **Fuzzy Finder**: Telescope with file/buffer/help searching
- **File Marks**: Harpoon for quick navigation to favorite files
- **Git Integration**: View git changes, blame, and stage hunks
- **Diagnostics Display**: Trouble for organized error/warning viewing
- **Terminal Navigation**: Seamless Tmux/Vim pane switching

### AI & Coding Assistance
- **CodeCompanion**: AI chat and inline code editing with Claude
- **Avante**: Advanced code generation with Claude 3.7 Sonnet
- **Auto-suggestions**: Real-time coding suggestions while you type
- **Vision Support**: Image pasting and analysis in AI chats

### Debugging
- **DAP Support**: Full debugging for Go (extensible to other languages)
- **Breakpoints**: Toggle, conditional breakpoints, and variable inspection
- **Step Control**: Step into, over, out, back with F-keys
- **Visual Debugging**: DAP UI opens/closes automatically

### Git Workflow
- **Gitsigns**: Inline git changes with stage/reset hunks
- **LazyGit**: Full-featured Git UI integration
- **Blame Line**: View git blame for current line
- **Diff Viewing**: Quick diffs with parent/previous commits

### UI Enhancements
- **Catppuccin Theme**: Beautiful, soothing color scheme (Frappe flavor)
- **Status Line**: Lualine with git info, diagnostics, and file metadata
- **Dashboard**: Alpha startup dashboard with quick actions
- **Notifications**: Noice for improved UI messages and command palette
- **Keymap Helper**: Which-key for discovering available keymaps

---

## Directory Structure

```
nvim/
├── init.lua                          # Entry point - loads config and plugins
├── lazy-lock.json                    # Plugin version locks (auto-managed)
│
├── lua/
│   ├── config/                       # Core configuration
│   │   ├── options.lua               # Vim options (tabs, search, etc.)
│   │   ├── keymaps.lua               # Global keymaps
│   │   └── utils/
│   │       ├── window-resize.lua     # Window resizing utilities
│   │       └── telescope-multigrep.lua # Multi-grep for Telescope
│   │
│   └── plugins/                      # Plugin specifications (lazy.nvim format)
│       ├── lsp/                      # Language Server Protocol
│       │   ├── lsp-config.lua        # Mason and LSP server setup
│       │   ├── autocompletions.lua   # nvim-cmp with LuaSnip
│       │   └── none-ls.lua           # Formatting and diagnostics
│       │
│       ├── ui/                       # User Interface
│       │   ├── theme.lua             # Catppuccin theme configuration
│       │   ├── lualine.lua           # Status line
│       │   ├── noice.lua             # Message UI improvements
│       │   ├── alpha.lua             # Dashboard
│       │   ├── whichkey.lua          # Keymap helper
│       │   └── css-color-picker.lua  # Color highlighting
│       │
│       ├── editor/                   # Text Editing
│       │   ├── treesitter.lua        # Syntax parsing and highlighting
│       │   ├── surround.lua          # Surround operations
│       │   ├── comments.lua          # Comment toggling
│       │   └── ufo.lua               # Code folding
│       │
│       ├── navigation/               # File and Code Navigation
│       │   ├── telescope.lua         # Fuzzy finder
│       │   ├── trouble.lua           # Diagnostics display
│       │   └── harpoon.lua           # File marks
│       │
│       ├── git/                      # Git Integration
│       │   └── git.lua               # LazyGit and Gitsigns
│       │
│       ├── ai/                       # AI Features
│       │   └── ai.lua                # CodeCompanion and Avante
│       │
│       ├── debug/                    # Debugging
│       │   └── debug.lua             # DAP configuration
│       │
│       ├── tools/                    # Miscellaneous Tools
│       │   ├── filesystem.lua        # Oil file manager
│       │   ├── floaterm.lua          # Floating terminal
│       │   ├── markdown.lua          # Markdown rendering
│       │   ├── sql.lua               # Dadbod SQL UI
│       │   ├── tmux-navigator.lua    # Tmux integration
│       │   └── present.lua           # Presentation plugin
│       │
│       └── terminal/                 # Terminal Integration
│           ├── ghostty.lua           # Ghostty terminal support
│           └── kitty.lua             # Kitty terminal support
│
├── docs/                             # Documentation
│   ├── README.md                     # This file
│   ├── KEYMAPS.md                    # Comprehensive keymap reference
│   └── PLUGINS.md                    # Detailed plugin documentation
│
└── examples/                         # Example configurations
    └── (custom overrides and examples)
```

### File Organization Tips

- **lua/config/**: Core Vim options, global keymaps, and utilities
- **lua/plugins/**: Organized by feature category for easy browsing
- **docs/**: Complete documentation for reference
- **Each plugin file**: Self-contained with dependencies and configuration

---

## Requirements

### Minimum Requirements

- **NeoVim**: 0.11.0 or later
  - Check: `nvim --version`
  - Install: [NeoVim Installation](https://github.com/neovim/neovim/wiki/Installing-Neovim)

- **Git**: For plugin management and git integrations
  - Check: `git --version`

- **npm/Node.js**: For some LSP servers
  - Check: `node --version`

- **Python 3**: For Python LSP and some tools
  - Check: `python3 --version`

### Recommended Tools

For full functionality, install these optional dependencies:

| Tool | Purpose | Install |
|------|---------|---------|
| **Ripgrep** | Fast file searching | `brew install ripgrep` or `cargo install ripgrep` |
| **fd** | Fast directory finding | `brew install fd` or `cargo install fd-find` |
| **fzf** | Fuzzy finding (Telescope backup) | `brew install fzf` |
| **Tmux** | Terminal multiplexer (for pane navigation) | `brew install tmux` |
| **LazyGit** | Git UI (highly recommended) | `brew install lazygit` |
| **Lua** | For Lua LSP development | `brew install lua` |
| **Go** | For Go development | `brew install go` |
| **stylua** | Lua formatter | `cargo install stylua` |
| **prettier** | JavaScript/JSON formatter | `npm install -g prettier` |
| **black** | Python formatter | `pip install black` |

### AI Features (Optional)

For CodeCompanion and Avante AI features:
- **ANTHROPIC_TOKEN**: Environment variable with Claude API key
- **Internet connection**: For API calls to Anthropic

---

## Installation

### Step 1: Install/Update NeoVim

**macOS (Homebrew)**:
```bash
brew install neovim
```

**Linux**:
```bash
# Ubuntu/Debian
sudo apt install neovim

# Fedora
sudo dnf install neovim
```

**From Source**:
```bash
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

### Step 2: Clone Configuration

If this is your `~/.config/nvim/`:

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone the configuration
git clone https://github.com/Den1al/dotfiles ~/.dotfiles
ln -s ~/.dotfiles/nvim ~/.config/nvim
```

Or directly in the dotfiles location:
```bash
# Navigate to nvim directory
cd ~/.config/nvim  # or wherever you keep your dotfiles
```

### Step 3: Install lazy.nvim (Automatic)

lazy.nvim is automatically installed when you first run NeoVim:

```bash
nvim
```

You'll see plugins being installed. Wait for the installation to complete.

### Step 4: Install LSP Servers & Tools

Open NeoVim and install the language servers:

```vim
:Mason
```

This opens the Mason UI where you can:
1. Navigate with arrow keys
2. Press `i` to install servers listed in `lua/plugins/lsp/lsp-config.lua`
3. Common servers are auto-installed on first run

**Or install via CLI**:
```bash
nvim +Mason +MasonInstallAll +q
```

### Step 5: Install Formatters (Optional)

For code formatting, install formatters:

```bash
# Python
pip install black isort

# JavaScript/JSON
npm install -g prettier

# Lua
cargo install stylua

# Go (usually included with Go installation)
```

---

## Quick Start

### Essential Keymaps

The **leader key is `<Space>`** (configured in `lua/config/options.lua`)

#### Navigation
- `<leader>ff` - Find files
- `<leader>fb` - Find buffers
- `<leader>fg` - Live grep (search text)
- `<leader>a` - Add file to harpoon
- `<leader>1-4` - Jump to harpooned file

#### LSP (Language Intelligence)
- `gd` - Go to definition
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions (auto-fixes)

#### Editing
- `gcc` - Toggle comment on line
- `cs"'` - Change double quotes to single
- `ds"` - Delete surrounding quotes
- `zR` / `zM` - Open/close all folds

#### Git
- `<leader>lg` - Open LazyGit
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `]c` / `[c` - Next/previous hunk

#### AI Coding
- `<leader>c` - Toggle CodeCompanion chat
- `<C-c>` - CodeCompanion actions menu
- `ga` - Add selected code to chat (visual mode)

#### Debugging (Go)
- `<space>b` - Toggle breakpoint
- `<F1>` - Continue execution
- `<F2>` - Step into
- `<F3>` - Step over
- `<F4>` - Step out

#### UI
- `<leader>?` - Show available keymaps
- `<leader>xx` - Show diagnostics
- `-` - Open file manager
- `<leader>ft` - Open floating terminal

**For comprehensive keymap reference**: See `KEYMAPS.md`

### Your First Session

1. **Open NeoVim**:
   ```bash
   nvim
   ```

2. **Create a test file**:
   ```vim
   :edit test.lua
   ```

3. **Start coding**: LSP completions (Tab/Ctrl-c), diagnostics appear automatically

4. **Try commands**:
   - `:Format` - Format the current buffer
   - `:Mason` - Open package manager
   - `:LazyGit` - Open git UI
   - `:Trouble` - Show diagnostics

5. **Explore keymaps**:
   - `<leader>?` - See available bindings
   - `<leader>ff` - Search files
   - `gd` - Go to definition

---

## Configuration

### Adding LSP Servers

Edit `lua/plugins/lsp/lsp-config.lua`:

```lua
local servers = {
  "lua_ls",
  "ts_ls",
  "gopls",
  "new_server",  -- Add here
}

-- Then configure the server:
lspconfig.new_server.setup({
  -- server-specific settings
})
```

Or use Mason UI:
```vim
:Mason  " Install from UI
```

### Changing the Theme

Edit `lua/plugins/ui/theme.lua`:

```lua
require("catppuccin").setup({
  flavour = "mocha",  -- Options: frappe, mocha, macchiato, latte
  transparent_background = true,  -- For transparent background
})
```

Available flavours:
- `frappe` - Warm, current default
- `mocha` - Dark, sleek
- `macchiato` - Cool tones
- `latte` - Light theme

### Adding Formatters

Edit `lua/plugins/lsp/none-ls.lua`:

```lua
formatting = {
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.new_formatter,  -- Add here
},
```

Then install the formatter (via Mason or system package manager).

### Customizing Keymaps

Edit `lua/config/keymaps.lua` to add or modify keymaps:

```lua
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { noremap = true })
```

**Common options**:
- `noremap = true` - Disable recursive mapping
- `silent = true` - Don't echo command
- `desc = "Description"` - For which-key

### Adjusting Vim Options

Edit `lua/config/options.lua`:

```lua
vim.opt.tabstop = 4        -- Tab width
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.clipboard = "unnamed"  -- System clipboard
```

### Plugin Management

Install new plugins by creating files in `lua/plugins/<category>/`:

```lua
-- lua/plugins/tools/my-plugin.lua
return {
  "author/my-plugin",
  event = "VeryLazy",  -- or cmd = "MyCommand"
  config = function()
    require("my-plugin").setup({
      -- options
    })
  end,
}
```

Then sync plugins:
```vim
:Lazy sync
```

---

## Environment Variables

### AI Features (Required for CodeCompanion/Avante)

Set your Anthropic API key:

```bash
# Add to ~/.zshrc or ~/.bashrc
export ANTHROPIC_TOKEN="sk-ant-..."

# Or in your shell session
export ANTHROPIC_TOKEN="your-api-key-here"
```

**Get your API key**:
1. Visit [Anthropic Console](https://console.anthropic.com/)
2. Sign in or create account
3. Navigate to API keys
4. Copy your API key
5. Add to your shell configuration file

Verify it's set:
```bash
echo $ANTHROPIC_TOKEN
```

### Other Useful Environment Variables

```bash
# Python virtual environment (auto-detected if named: .venv, venv, .env)
export VIRTUAL_ENV="path/to/venv"

# Go workspace
export GOPATH="$HOME/go"

# Custom config path
export NVIM_CONFIG="~/.config/nvim"
```

---

## Troubleshooting

### Common Issues & Solutions

#### LSP Not Working

**Problem**: No completions or diagnostics appearing

**Solution**:
```vim
:LspInfo                    " Check LSP status
:Mason                      " Install missing servers
:checkhealth nvim.lsp       " Diagnose issues
```

**Verify**:
- File type detected: `:set filetype?`
- LSP attached to buffer: `:LspInfo`
- Server running: `:Mason` (check for ✓ mark)

#### Completions Not Showing

**Checklist**:
```vim
:Lazy show nvim-cmp         " Check if loaded
:Lazy show mason            " Check if loaded
:Lazy show nvim-lsp         " Check if loaded
```

**Manual trigger**: `<C-c>` in insert mode

#### Formatting Not Working

**Check formatter is installed**:
```vim
:Mason                      " Install formatter
:set filetype?              " Verify file type
```

**Verify None-LS has formatter**:
```vim
:Lazy show none-ls.nvim
```

**Manual format**: `:Format` command

#### Python LSP Issues

**Problem**: LSP not detecting virtual environment

**Solution**: Ensure venv is named one of:
- `.venv/`
- `venv/`
- `.env/`

In project root. Then reload:
```vim
:LspRestart
```

#### Treesitter Parser Not Found

**Problem**: Syntax highlighting broken for a language

**Solution**:
```vim
:TSInstall <language>       " Install parser
:TSUpdate                   " Update all parsers
:TSModuleInfo               " Check status
```

#### Plugins Not Loading

**Solution**:
```vim
:Lazy sync                  " Sync all plugins
:Lazy update                " Update all plugins
:Lazy clean                 " Remove unused
:Lazy profile               " Check load times
```

**Check specific plugin**:
```vim
:Lazy show plugin-name
```

#### AI Features Not Working

**Problem**: CodeCompanion/Avante not responding

**Checklist**:
```bash
# 1. Check API key is set
echo $ANTHROPIC_TOKEN

# 2. Test API connection
curl -H "x-api-key: $ANTHROPIC_TOKEN" \
  https://api.anthropic.com/v1/messages

# 3. Check plugins loaded
nvim
:Lazy show codecompanion
:Lazy show avante
```

**Try**:
- Restart NeoVim
- Check internet connection
- Verify API key is valid (not expired)
- Check error messages: `:messages`

#### Performance Issues

**Check plugin load times**:
```vim
:Lazy profile
```

Look for slow plugins. Common solutions:
- Add `event = "VeryLazy"` to defer loading
- Use `cmd = "CommandName"` for command-only plugins
- Check for blocking operations in config

### General Diagnostics

**View all messages**:
```vim
:messages
```

**Check NeoVim health**:
```vim
:checkhealth
```

**Full diagnostic**:
```vim
:checkhealth nvim.lsp
:checkhealth nvim.treesitter
:checkhealth nvim.diagnostic
```

### Useful Debug Commands

```vim
:Lazy                       " Plugin manager UI
:Mason                      " LSP/Tool manager UI
:LspInfo                    " LSP status
:LspLog                     " LSP debug log
:Trouble                    " Diagnostics panel
:Telescope diagnostics      " Search diagnostics
:TSModuleInfo               " Treesitter status
:Lazy profile               " Plugin load times
:messages                   " Recent messages
```

---

## Additional Documentation

### Complete References

- **[KEYMAPS.md](./KEYMAPS.md)** - Comprehensive keymap reference organized by feature
  - Navigation, LSP, Git, AI, Debugging, Editing commands
  - Detailed examples and usage patterns
  - Key modifier reference

- **[PLUGINS.md](./PLUGINS.md)** - Detailed plugin documentation
  - Plugin organization and categories
  - Dependencies and configuration
  - Maintenance guide
  - Troubleshooting specific plugins

### External Resources

- **[NeoVim Documentation](https://neovim.io/doc/user/)** - Official docs
- **[lazy.nvim Guide](https://github.com/folke/lazy.nvim)** - Plugin manager
- **[LSP Configuration](https://github.com/neovim/nvim-lspconfig)** - Language servers
- **[Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax parsing
- **[DAP Documentation](https://github.com/mfussenegger/nvim-dap/wiki)** - Debugging
- **[Anthropic Docs](https://docs.anthropic.com)** - AI API reference

### Configuration Files to Explore

| File | Purpose |
|------|---------|
| `init.lua` | Entry point, bootstraps lazy.nvim |
| `lua/config/options.lua` | Vim options and settings |
| `lua/config/keymaps.lua` | Global keymaps |
| `lua/plugins/lsp/lsp-config.lua` | LSP server configuration |
| `lua/plugins/ui/theme.lua` | Color scheme setup |
| `lazy-lock.json` | Plugin version locks (auto-managed) |

### Tips for Customization

1. **Start small**: Modify one file at a time
2. **Test changes**: Reload with `:Lazy sync` or restart NeoVim
3. **Use which-key**: `<leader>?` to discover keymaps
4. **Check docs**: Reference KEYMAPS.md and PLUGINS.md
5. **Read plugin code**: Well-commented configuration files in `lua/plugins/`

### Getting Help

**In NeoVim**:
```vim
:help <topic>               " Built-in help
:Telescope help_tags        " Searchable help
<leader>?                   " Show keymaps (which-key)
```

**Debugging**:
- `:messages` - View recent messages
- `:checkhealth` - Check system/plugin health
- `:LspLog` - View LSP logs
- `:Lazy profile` - Check plugin load times

---

## Summary

You now have a powerful, customizable NeoVim setup! Here's what you can do:

- **Code immediately**: Full LSP support, completions, diagnostics
- **Explore features**: Try AI chat (`<leader>c`), debugging (`<space>b`), git UI (`<leader>lg`)
- **Customize easily**: Modify Lua files in `lua/` directory, reload with `:Lazy sync`
- **Reference docs**: Check KEYMAPS.md for commands, PLUGINS.md for features
- **Ask for help**: Use `<leader>?` in NeoVim, or `:help` for built-in docs

Happy editing!

---

**Last Updated**: 2026-01-12
**Configuration Version**: Based on NeoVim 0.11.0+
**Theme**: Catppuccin (Frappe)
**Plugin Manager**: lazy.nvim
**Default Leader Key**: `<Space>`
