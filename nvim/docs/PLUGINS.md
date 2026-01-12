# NeoVim Plugin Documentation

This document provides comprehensive information about all plugins installed in this NeoVim configuration. Plugins are organized by category and managed using [lazy.nvim](https://github.com/folke/lazy.nvim).

## Table of Contents

1. [Plugin Categories Overview](#plugin-categories-overview)
2. [LSP Plugins](#lsp-plugins)
3. [UI Plugins](#ui-plugins)
4. [Editor Plugins](#editor-plugins)
5. [Navigation Plugins](#navigation-plugins)
6. [Git Plugins](#git-plugins)
7. [AI Plugins](#ai-plugins)
8. [Debug Plugins](#debug-plugins)
9. [Tools Plugins](#tools-plugins)
10. [Terminal Plugins](#terminal-plugins)
11. [Plugin Loading Order](#plugin-loading-order)
12. [Dependency Graph](#dependency-graph)
13. [Maintenance Guide](#maintenance-guide)

---

## Plugin Categories Overview

The plugin configuration is organized into 9 categories, each located in subdirectories under `lua/plugins/`:

| Category | Purpose | File Count |
|----------|---------|-----------|
| **lsp** | Language Server Protocol, completion, diagnostics | 3 |
| **ui** | User interface, themes, status line | 6 |
| **editor** | Text editing, transformations, folding | 4 |
| **navigation** | File navigation, searching, quickfix | 3 |
| **git** | Version control integration | 2 |
| **ai** | AI-assisted coding | 2 |
| **debug** | Debugging support | 1 |
| **tools** | Miscellaneous tools and utilities | 6 |
| **terminal** | Terminal and shell integration | 2 |

---

## LSP Plugins

### 1. **Mason** (`lua/plugins/lsp/lsp-config.lua`)
**Purpose**: Package manager for LSP servers, linters, and formatters

**Features**:
- Automatic installation and management of LSP servers
- Version management for installed tools
- Easy updates and cleanup

**Dependencies**: None (base dependency)

**Configuration**:
```lua
require("mason").setup()
```

**Key Bindings**: None (configuration plugin)

**LSP Servers Configured**:
- `lua_ls` - Lua language support
- `ts_ls` - TypeScript/JavaScript
- `gopls` - Go language
- `golangci_lint_ls` - Go linting
- `ocamllsp` - OCaml language
- `marksman` - Markdown language
- `pylsp` - Python language (with venv auto-detection)
- `bashls` - Bash shell
- `java_language_server` - Java
- `jinja_lsp` - Jinja templating
- `dockerls` - Docker files

---

### 2. **Mason LSP Config** (`lua/plugins/lsp/lsp-config.lua`)
**Purpose**: Bridges Mason and LSP Config for seamless setup

**Features**:
- Automatic LSP server initialization
- Custom configuration per language server
- Workspace symbol support

**Dependencies**:
- `williamboman/mason.nvim`

**Key Keymaps**:

| Keymap | Action | Description |
|--------|--------|-------------|
| `<leader>rn` | `vim.lsp.buf.rename` | Rename symbol |
| `<leader>ca` | `vim.lsp.buf.code_action` | Code action |
| `gd` | `vim.lsp.buf.definition` | Go to definition |
| `gr` | `telescope.lsp_references` | Go to references |
| `gI` | `vim.lsp.buf.implementation` | Go to implementation |
| `<leader>D` | `vim.lsp.buf.type_definition` | Type definition |
| `<leader>ds` | `telescope.lsp_document_symbols` | Document symbols |
| `<leader>ws` | `telescope.lsp_dynamic_workspace_symbols` | Workspace symbols |
| `K` | `vim.lsp.buf.hover` | Show hover documentation |
| `gD` | `vim.lsp.buf.declaration` | Go to declaration |

**Language-Specific Setup**:
- **Python**: Auto-detects virtual environments (checks `.venv`, `venv`, `.env`)
- **Go**: Includes `completeUnimported` and placeholder settings
- **OCaml**: Full support with Dune integration
- **Lua**: Recognizes `vim` as a global variable

---

### 3. **Autocompletions** (`lua/plugins/lsp/autocompletions.lua`)
**Purpose**: Advanced completion engine with snippet support

**Features**:
- LSP-driven completions
- Snippet expansion (LuaSnip)
- Path completion
- Friendly snippets library

**Dependencies**:
- `L3MON4D3/LuaSnip` (snippet engine)
- `rafamadriz/friendly-snippets` (snippet library)
- `hrsh7th/cmp-nvim-lsp` (LSP source)
- `hrsh7th/cmp-path` (path source)
- `saadparwaiz1/cmp_luasnip` (snippet source)

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<CR>` | Confirm completion |
| `<Tab>` | Select next item |
| `<S-Tab>` | Select previous item |
| `<C-b>` | Scroll docs back |
| `<C-f>` | Scroll docs forward |
| `<C-c>` | Manually trigger completion |

**Configuration**:
- Completion triggered on `InsertEnter`
- Completions from: LSP, LuaSnip, path

---

### 4. **None-LS (Null-LS)** (`lua/plugins/lsp/none-ls.lua`)
**Purpose**: Non-LSP source for linting and formatting

**Features**:
- Code formatting on save
- Language diagnostics
- Multi-language support

**Dependencies**: None

**Event Trigger**: `BufReadPre`, `BufNewFile`

**Formatters Configured**:
- `gofmt` - Go code formatting
- `goimports` - Go import management
- `stylua` - Lua formatting
- `prettier` - JavaScript/TypeScript/JSON/CSS
- `black` - Python formatting
- `isort` - Python import sorting
- `ocamlformat` - OCaml formatting
- `rubocop` - Ruby formatting and linting

**Linters Configured**:
- `golangci_lint` - Go diagnostics
- `rubocop` - Ruby diagnostics

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>gf` | Format buffer |

**Note**: Formatting is triggered automatically on buffer save.

---

## UI Plugins

### 1. **Catppuccin Theme** (`lua/plugins/ui/theme.lua`)
**Purpose**: Beautiful, soothing color scheme

**Features**:
- Frappe flavor (warm, cool-toned)
- Transparent background option
- Wide plugin integration
- LSP semantic highlighting

**Dependencies**: None

**Priority**: 1000 (highest - loads before other UI plugins)

**Configuration**:
```lua
require("catppuccin").setup({
  flavour = "frappe",
  transparent_background = false,
})
vim.cmd.colorscheme("catppuccin")
```

**Available Flavours**:
- `frappe` (currently used)
- `mocha`
- `macchiato`
- `latte`

---

### 2. **Lualine** (`lua/plugins/ui/lualine.lua`)
**Purpose**: Fast and customizable status line

**Features**:
- Git integration (branch, diff, diagnostics)
- LSP document symbols display
- File info (encoding, format, type)
- Integration with multiple plugins (Trouble, Fugitive, etc.)

**Dependencies**:
- `nvim-tree/nvim-web-devicons`
- `folke/trouble.nvim`

**Event Trigger**: `VeryLazy`

**Status Line Sections**:
- `lualine_a` - Mode
- `lualine_b` - Branch, diff, diagnostics
- `lualine_c` - Filename, LSP symbols
- `lualine_x` - Encoding, fileformat, filetype
- `lualine_y` - Progress
- `lualine_z` - Location (line:column)

**Theme**: `modus-vivendi`

**Plugin Extensions**:
- `fugitive` - Git integration
- `quickfix` - Quickfix list
- `neo-tree` - File explorer
- `lazy` - Plugin manager
- `mason` - LSP manager
- `nvim-dap-ui` - Debugger UI
- `oil` - File manager
- `trouble` - Diagnostics

---

### 3. **Noice** (`lua/plugins/ui/noice.lua`)
**Purpose**: Replaces default UI with enhanced command/search interface

**Features**:
- Improved command palette
- Better search UI
- Notification management
- LSP message handling

**Dependencies**:
- `MunifTanjim/nui.nvim`

**Event Trigger**: `VeryLazy`

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>nl` | Show last notification |
| `<leader>nh` | Open Noice telescope |

**Presets Enabled**:
- `bottom_search` - Classic bottom command line
- `command_palette` - Grouped cmdline and popupmenu
- `long_message_to_split` - Long messages to split window
- `lsp_doc_border` - LSP doc borders (disabled for Neovim 0.11)

---

### 4. **Alpha** (`lua/plugins/ui/alpha.lua`)
**Purpose**: Customizable startup dashboard

**Features**:
- Dashboard with quick actions
- Recent files
- Custom greeting
- Session management

**Dependencies**:
- `nvim-tree/nvim-web-devicons`

**Configuration**: Uses `alpha.themes.startify` preset

---

### 5. **Which-Key** (`lua/plugins/ui/whichkey.lua`)
**Purpose**: Interactive keymap helper

**Features**:
- Shows available keymaps after pressing prefix
- Groups and categorizes commands
- Helps discover shortcuts
- Buffer-local and global keymaps

**Event Trigger**: `VeryLazy`

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>?` | Show buffer local keymaps |

---

### 6. **CSS Color Picker** (`lua/plugins/ui/css-color-picker.lua`)
**Purpose**: Inline color highlighting and picker

**Features**:
- Automatic color highlighting
- LSP integration for color detection
- Color picker for editing values

**Dependencies**: None

**Configuration**:
```lua
require("ccc").setup({
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})
```

---

## Editor Plugins

### 1. **Treesitter** (`lua/plugins/editor/treesitter.lua`)
**Purpose**: Syntax highlighting and code parsing using Tree-sitter

**Features**:
- Enhanced syntax highlighting
- Semantic understanding of code structure
- Automatic language detection
- Incremental parsing

**Dependencies**:
- `nvim-treesitter/playground` (for development/debugging)

**Build Step**: `:TSUpdate` (auto-executed on updates)

**Event Trigger**: `BufReadPost`, `BufNewFile`

**Configuration**:
```lua
config.setup({
  auto_install = true,      -- Auto-install missing parsers
  highlight = { enable = true },
  indent = { enable = true },
})
```

**Supported Languages**:
Automatically installed on demand. Use `:TSInstall <lang>` to manually add support.

---

### 2. **Surround** (`lua/plugins/editor/surround.lua`)
**Purpose**: Efficiently change, add, or delete surrounding characters

**Features**:
- Surround objects with any character pair
- Change surrounding characters
- Text objects for selections
- Works with all bracket types

**Dependencies**: None

**Event Trigger**: `VeryLazy`

**Common Operations**:
- `cs"'` - Change double quotes to single
- `ds"` - Delete double quotes
- `ys<motion><char>` - Add surround
- `S<char>` - Surround in visual mode

**Supported Pairs**:
- `()`, `[]`, `{}`, `<>`
- Quotes: `"`, `'`, `` ` ``
- Custom pairs (XML tags, etc.)

---

### 3. **Comments** (`lua/plugins/editor/comments.lua`)
**Purpose**: Fast and easy code commenting

**Features**:
- Line commenting
- Block commenting
- Smart detection of comment style
- Visual mode support

**Dependencies**: None

**Key Keymaps**:

| Keymap | Mode | Action |
|--------|------|--------|
| `gcc` | normal | Toggle comment current line |
| `gc` | normal, operator | Toggle linewise comment |
| `gc` | visual | Toggle linewise comment (visual) |
| `gbc` | normal | Toggle block comment current |
| `gb` | normal, operator | Toggle blockwise comment |
| `gb` | visual | Toggle blockwise comment (visual) |

**Configuration**: Default setup with no customization

---

### 4. **UFO** (`lua/plugins/editor/ufo.lua`)
**Purpose**: Modern code folding with enhanced folding capabilities

**Features**:
- LSP-based folding
- Indent-based fallback folding
- Peek at folded content
- Visual fold indicators

**Dependencies**:
- `kevinhwang91/promise-async`

**Event Trigger**: `BufReadPost`, `BufNewFile`

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zK` | Peek folded lines under cursor |

**Configuration**:
```lua
vim.o.foldcolumn = "1"        -- Show fold indicator
vim.o.foldlevel = 99          -- Start with all folds open
vim.o.foldlevelstart = 99      -- New files: all folds open
vim.o.foldenable = true        -- Enable folding

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "lsp", "indent" }  -- Use LSP first, indent as fallback
  end,
})
```

---

## Navigation Plugins

### 1. **Telescope** (`lua/plugins/navigation/telescope.lua`)
**Purpose**: Highly extensible fuzzy finder

**Features**:
- Find files with preview
- Search buffers
- Live grep (custom multi-grep)
- Help tag search
- LSP integration
- UI select extension

**Dependencies**:
- `nvim-lua/plenary.nvim` (utility library)

**Tag**: `0.1.6` (stable version)

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help tags |
| `<leader>fg` | Live grep (from telescope-multigrep) |

**Features**:
- Find files ignores `.git` directory
- Respects `.gitignore`
- Hidden files support
- Ripgrep integration for fast searching

**Extensions**:
- `telescope-ui-select` - Telescope UI for `vim.ui.select()`

---

### 2. **Trouble** (`lua/plugins/navigation/trouble.lua`)
**Purpose**: Pretty list for showing diagnostics, references, quickfix, location list

**Features**:
- Organized diagnostic display
- LSP references/definitions
- Quickfix and location list
- Document and workspace symbols
- Integrated with Lualine

**Dependencies**: None (optional integration with Lualine)

**Trigger**: `cmd = "Trouble"` (command-based)

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xr` | LSP definitions/references (right pane) |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |

**Views**:
- `diagnostics` - LSP diagnostics
- `lsp` - LSP references and definitions
- `loclist` - Location list
- `qflist` - Quickfix list

---

### 3. **Harpoon** (`lua/plugins/navigation/harpoon.lua`)
**Purpose**: Quick file navigation with indexed marks

**Features**:
- Mark favorite files
- Quick jump to marked files
- Telescope integration
- Fast project navigation

**Dependencies**:
- `nvim-lua/plenary.nvim`
- `nvim-telescope/telescope.nvim`

**Branch**: `harpoon2` (latest version)

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>a` | Add current file to harpoon |
| `<leader>1` | Jump to harpoon file 1 |
| `<leader>2` | Jump to harpoon file 2 |
| `<leader>3` | Jump to harpoon file 3 |
| `<leader>4` | Jump to harpoon file 4 |
| `<leader>fh` | Open harpoon files in telescope |

**Features**:
- Custom Telescope picker
- Delete files with `<c-d>` in picker
- Centered layout
- Visual feedback

---

## Git Plugins

### 1. **LazyGit** (`lua/plugins/git/git.lua`)
**Purpose**: Git UI from within NeoVim

**Features**:
- Full Git GUI
- Interactive commits
- Branch management
- Stash management
- File history

**Dependencies**:
- `nvim-lua/plenary.nvim`

**Trigger**: `cmd` (command-based, lazy loaded)

**Commands**:
- `:LazyGit` - Open LazyGit
- `:LazyGitConfig` - LazyGit config
- `:LazyGitCurrentFile` - LazyGit for current file
- `:LazyGitFilter` - Filter commits
- `:LazyGitFilterCurrentFile` - Filter current file

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<leader>lg` | Open LazyGit |

---

### 2. **Gitsigns** (`lua/plugins/git/git.lua`)
**Purpose**: Git signs in gutter with utilities

**Features**:
- Visual change indicators (+, ~, _)
- Git blame on demand
- Stage/reset hunks
- Diff highlighting
- Text objects for hunks

**Dependencies**: None

**Key Keymaps**:

| Keymap | Mode | Action |
|--------|------|--------|
| `]c` | normal | Next hunk |
| `[c` | normal | Previous hunk |
| `<leader>hs` | normal, visual | Stage hunk |
| `<leader>hr` | normal, visual | Reset hunk |
| `<leader>hS` | normal | Stage entire buffer |
| `<leader>hu` | normal | Undo stage hunk |
| `<leader>hR` | normal | Reset entire buffer |
| `<leader>hp` | normal | Preview hunk |
| `<leader>hb` | normal | Blame line (full) |
| `<leader>tb` | normal | Toggle line blame |
| `<leader>hd` | normal | Diff this |
| `<leader>hD` | normal | Diff this against parent |
| `<leader>td` | normal | Toggle deleted indicators |
| `ih` | visual, operator | Select hunk (text object) |

**Git Sign Symbols**:
- `+` - Added lines
- `~` - Changed lines
- `_` - Deleted lines
- `‾` - Top deleted
- `~` - Changed deleted

---

## AI Plugins

### 1. **CodeCompanion** (`lua/plugins/ai/ai.lua`)
**Purpose**: AI-powered coding assistant (Claude, etc.)

**Features**:
- Chat interface
- Inline code editing
- Code analysis
- Anthropic Claude integration
- Multiple strategies (chat, inline, agent)

**Dependencies**:
- `nvim-lua/plenary.nvim`
- `nvim-treesitter/nvim-treesitter`
- `nvim-telescope/telescope.nvim`
- `stevearc/dressing.nvim` (improved UI)

**Configuration**:
```lua
adapters = {
  anthropic = require("codecompanion.adapters").extend("anthropic", {
    env = {
      api_key = "ANTHROPIC_TOKEN",
    },
  }),
},
strategies = {
  chat = { adapter = "anthropic" },
  inline = { adapter = "anthropic" },
  agent = { adapter = "anthropic" },
}
```

**Key Keymaps**:

| Keymap | Mode | Action |
|--------|------|--------|
| `<C-c>` | normal, visual | CodeCompanion actions |
| `<leader>c` | normal, visual | Toggle CodeCompanion |
| `ga` | visual | Add selection to CodeCompanion |
| `:cc` | command | Shorthand for CodeCompanion |

**Environment Setup**:
- Requires `ANTHROPIC_TOKEN` environment variable
- See [Anthropic API Documentation](https://docs.anthropic.com)

---

### 2. **Avante** (`lua/plugins/ai/ai.lua`)
**Purpose**: Advanced AI-powered code generation and editing

**Features**:
- Multi-model support (Claude 3.7 Sonnet)
- Auto-suggestions
- Cursor planning mode
- Code generation
- Vision capabilities (image support)
- Markdown rendering

**Dependencies**:
- `stevearc/dressing.nvim` (UI improvements)
- `nvim-lua/plenary.nvim`
- `MunifTanjim/nui.nvim`
- `hrsh7th/nvim-cmp` (completion)
- `nvim-tree/nvim-web-devicons`
- `HakonHarnes/img-clip.nvim` (image support)
- `MeanderingProgrammer/render-markdown.nvim` (markdown)

**Configuration**:
```lua
opts = {
  provider = "claude",
  auto_suggestion_provider = "claude",
  behaviour = {
    auto_suggestions = true,
    enable_cursor_planning_mode = true,
    auto_set_keymaps = true,
  },
  providers = {
    claude = {
      model = "claude-3-7-sonnet-20250219",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 32768,
      },
    },
  },
}
```

**Features**:
- Auto-suggestions while coding
- Temperature set to 0 for deterministic responses
- Up to 32K tokens per response
- 30-second timeout

**Build**: `make` (requires build step)

**Event Trigger**: `VeryLazy`

---

## Debug Plugins

### 1. **DAP** (`lua/plugins/debug/debug.lua`)
**Purpose**: Debug Adapter Protocol implementation for debugging

**Features**:
- Breakpoint management
- Step through code
- Variable inspection
- DAP UI integration
- Go debugging support
- Multi-language support

**Dependencies**:
- `leoluz/nvim-dap-go` (Go support)
- `rcarriga/nvim-dap-ui` (UI)
- `nvim-neotest/nvim-nio` (async support)
- `williamboman/mason.nvim` (debugger management)

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<space>b` | Toggle breakpoint |
| `<space>B` | Set conditional breakpoint |
| `<space>gb` | Run to cursor |
| `<space>?` | Evaluate variable under cursor |
| `<F1>` | Continue execution |
| `<F2>` | Step into |
| `<F3>` | Step over |
| `<F4>` | Step out |
| `<F5>` | Step back |
| `<F13>` | Restart debugging |

**Features**:
- Auto-opens DAP UI on start
- Auto-closes on exit
- Go debugging with DAP Go
- Supports conditional breakpoints
- Variable evaluation

---

## Tools Plugins

### 1. **Oil** (`lua/plugins/tools/filesystem.lua`)
**Purpose**: File manager for editing directory hierarchies

**Features**:
- Edit directories like regular files
- Move/copy/delete files
- Float window support
- Git integration
- Hidden file support

**Dependencies**:
- `nvim-tree/nvim-web-devicons`

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `-` | Toggle float file manager |

**Configuration**:
```lua
require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
  },
  float = {
    padding = 2,
    max_width = 90,
  },
})
```

**Features**:
- Hidden files visible by default
- Natural sorting
- `.git` directory hidden
- Float window with padding
- Line wrapping

---

### 2. **FloatTerm** (`lua/plugins/tools/floaterm.lua`)
**Purpose**: Floating terminal within NeoVim

**Features**:
- Floating terminal window
- Customizable size and position
- Auto-close after command
- Multiple terminal support

**Dependencies**: None

**Key Keymaps**:

| Keymap | Mode | Action |
|--------|------|--------|
| `<leader>ft` | normal | Open new floating terminal |
| `<leader>flt` | normal, terminal | Toggle floating terminal |

**Configuration**:
- Height: 90% of viewport
- Width: 90% of viewport
- Position: Center
- Auto-close: After 2 commands
- Window type: Float

---

### 3. **Markdown Rendering** (`lua/plugins/tools/markdown.lua`)
**Purpose**: Enhanced markdown rendering and preview

**Features**:
- Markdown-aware rendering
- Code block highlighting
- List rendering
- Table rendering
- Checkbox support

**Dependencies**:
- `nvim-treesitter/nvim-treesitter`
- `echasnovski/mini.nvim`

**Configuration**: Default options

**Supported Filetypes**:
- `markdown`
- `Avante` (for AI plugin)

---

### 4. **Dadbod UI** (`lua/plugins/tools/sql.lua`)
**Purpose**: SQL UI for database interaction

**Features**:
- Database connection management
- SQL execution
- Query results display
- Connection caching
- Multiple database support

**Dependencies**:
- `tpope/vim-dadbod` (database interface)
- `kristijanhusak/vim-dadbod-completion` (SQL completion)

**Trigger**: `cmd` (command-based)

**Commands**:
- `:DBUI` - Open database UI
- `:DBUIToggle` - Toggle database UI
- `:DBUIAddConnection` - Add connection
- `:DBUIFindBuffer` - Find database buffer

**Supported Databases**:
- PostgreSQL
- MySQL
- SQLite
- MongoDB
- And more (via vim-dadbod)

**Configuration**:
```lua
vim.g.db_ui_use_nerd_fonts = 1  -- Use nerd font icons
```

---

### 5. **Tmux Navigator** (`lua/plugins/tools/tmux-navigator.lua`)
**Purpose**: Seamless navigation between NeoVim and Tmux panes

**Features**:
- Navigate between Tmux panes and NeoVim windows
- Transparent pane switching
- Vim-like movements

**Dependencies**: None (requires tmux configuration)

**Commands**:
- `TmuxNavigateLeft`
- `TmuxNavigateDown`
- `TmuxNavigateUp`
- `TmuxNavigateRight`
- `TmuxNavigatePrevious`

**Key Keymaps**:

| Keymap | Action |
|--------|--------|
| `<C-h>` | Navigate left |
| `<C-j>` | Navigate down |
| `<C-k>` | Navigate up |
| `<C-l>` | Navigate right |
| `<C-\>` | Navigate previous |

**External Requirements**: Tmux plugin (see installation guide)

---

### 6. **Present** (`lua/plugins/tools/present.lua`)
**Purpose**: Create presentations from Markdown

**Features**:
- Slideshow from Markdown
- Built-in themes
- Speaker notes
- Live preview

**Dependencies**: None

**Configuration**: Default setup

---

## Terminal Plugins

### 1. **Ghostty** (`lua/plugins/terminal/ghostty.lua`)
**Purpose**: Ghostty terminal configuration validation

**Features**:
- Configuration syntax checking
- Auto-validation on save
- Error reporting

**Dependencies**: None

**Configuration**:
```lua
require("ghostty").setup({
  file_pattern = "**/ghostty/config",
  ghostty_cmd = "ghostty",
  check_timeout = 1000,  -- 1 second timeout
})
```

**Triggers**:
- Auto-runs on save for ghostty config files
- Pattern matching against `$HOME/.config/ghostty/config`

---

### 2. **Kitty Scrollback** (`lua/plugins/terminal/kitty.lua`)
**Purpose**: Enhanced scrollback buffer for Kitty terminal

**Features**:
- Interactive scrollback navigation
- Text filtering and search
- Integration with NeoVim
- Custom keybindings

**Dependencies**: None (requires Kitty terminal)

**Trigger**:
- `cmd = ["KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth"]`
- `event = "User KittyScrollbackLaunch"`

**Configuration**:
```lua
status_window = {
  autoclose = true,
},
ksb_builtin_get_text_all = {
  kitty_get_text = {
    ansi = true,
  },
},
```

**Commands**:
- `:KittyScrollbackGenerateKittens` - Generate kittens
- `:KittyScrollbackCheckHealth` - Check health status

---

## Plugin Loading Order

Plugins are loaded by lazy.nvim in the following order:

### Phase 1: Bootstrap (Always Loaded)
1. **Lazy.nvim** itself
2. Configuration modules (options, keymaps)

### Phase 2: High Priority UI (Pre-loading)
1. **Catppuccin Theme** (priority: 1000) - Sets color scheme first
2. **Treesitter** (event: BufReadPost) - Core parser

### Phase 3: Core LSP Stack
1. **Mason** - Package manager
2. **Mason LSP Config** - LSP initialization
3. **LSP Config** - Language server setup
4. **Autocompletions** - Completion engine (event: InsertEnter)
5. **None-LS** - Formatters/linters (event: BufReadPre)

### Phase 4: Navigation & Editing
1. **Telescope** - Fuzzy finder
2. **Telescope UI Select** - Extension
3. **Trouble** - Diagnostics display
4. **Harpoon** - File marks
5. **Surround** - Text surround (VeryLazy)
6. **Comments** - Code comments (VeryLazy)
7. **UFO** - Code folding (BufReadPost)

### Phase 5: Git Integration
1. **LazyGit** - Git UI (cmd)
2. **Gitsigns** - Git signs (VeryLazy)

### Phase 6: Enhanced UI
1. **Lualine** - Status line (VeryLazy)
2. **Noice** - Message UI (VeryLazy)
3. **Alpha** - Dashboard
4. **Which-Key** - Keymap helper (VeryLazy)
5. **CSS Color Picker** - Color highlighting

### Phase 7: AI & Advanced Features
1. **CodeCompanion** - AI chat
2. **Avante** - AI generation (VeryLazy)

### Phase 8: Debugging
1. **DAP** - Debugger (VeryLazy)
2. **DAP UI** - Debug interface
3. **DAP Go** - Go debugging

### Phase 9: Tools & Terminal
1. **Oil** - File manager
2. **FloatTerm** - Floating terminal
3. **Markdown Rendering** - Markdown display
4. **Dadbod UI** - SQL management (cmd)
5. **Tmux Navigator** - Terminal nav (cmd)
6. **Present** - Presentations
7. **Ghostty** - Terminal config
8. **Kitty Scrollback** - Kitty integration (cmd/event)

### VeryLazy Plugins
These are deferred until after UI is ready:
- Surround, Comments, UFO
- Lualine, Noice, Which-Key
- Gitsigns
- Avante
- DAP (with listeners)

---

## Dependency Graph

```
CORE
├── lazy.nvim
├── nvim.options
├── nvim.keymaps
└── nvim.utils

THEME
└── Catppuccin (priority: 1000)

SYNTAX & PARSING
└── Treesitter
    └── Playground (dev)

LSP STACK
├── Mason
│   └── Mason LSP Config
│       └── LSP Config
│           ├── Lua
│           ├── Python (with venv detection)
│           ├── Go (gopls)
│           ├── OCaml
│           ├── TypeScript
│           ├── Bash
│           ├── Java
│           ├── Jinja
│           ├── Docker
│           └── Go Linter
└── Autocompletions (event: InsertEnter)
    ├── nvim-cmp
    ├── LuaSnip
    │   └── friendly-snippets
    ├── cmp-nvim-lsp
    ├── cmp-path
    └── cmp_luasnip

DIAGNOSTICS & FORMATTING
└── None-LS (event: BufReadPre)
    ├── gofmt
    ├── goimports
    ├── stylua
    ├── prettier
    ├── black
    ├── isort
    ├── ocamlformat
    ├── rubocop (format)
    ├── golangci_lint (diagnostics)
    └── rubocop (diagnostics)

NAVIGATION
├── Telescope (base)
│   ├── plenary.nvim
│   └── Telescope UI Select
│       └── dressing.nvim
├── Trouble
│   └── (integrated with Lualine)
└── Harpoon (harpoon2)
    ├── plenary.nvim
    └── Telescope

EDITING
├── Surround (VeryLazy)
├── Comments (VeryLazy)
├── UFO (event: BufReadPost)
│   └── promise-async
└── Treesitter (already listed)

GIT
├── LazyGit (cmd)
│   └── plenary.nvim
└── Gitsigns (VeryLazy)

UI STATUS LINE
└── Lualine (VeryLazy)
    ├── nvim-web-devicons
    └── Trouble

UI MESSAGES
└── Noice (VeryLazy)
    └── nui.nvim

UI DASHBOARD
└── Alpha
    └── nvim-web-devicons

UI HELPERS
├── Which-Key (VeryLazy)
└── CSS Color Picker

AI ASSISTANTS
├── CodeCompanion
│   ├── plenary.nvim
│   ├── Treesitter
│   ├── Telescope
│   └── dressing.nvim
└── Avante (VeryLazy)
    ├── dressing.nvim
    ├── plenary.nvim
    ├── nui.nvim
    ├── nvim-cmp
    ├── nvim-web-devicons
    ├── img-clip.nvim
    │   └── (build step)
    └── render-markdown.nvim

DEBUGGING
└── DAP (VeryLazy)
    ├── nvim-dap-go
    ├── nvim-dap-ui
    ├── nvim-nio
    └── Mason

TOOLS
├── Oil
│   └── nvim-web-devicons
├── FloatTerm
├── Markdown Rendering
│   ├── Treesitter
│   └── mini.nvim
├── Dadbod UI (cmd)
│   ├── vim-dadbod
│   └── vim-dadbod-completion
├── Tmux Navigator (cmd)
├── Present
├── Ghostty
└── Kitty Scrollback (cmd/event)
```

---

## Maintenance Guide

### Adding a New Plugin

1. **Create plugin file**: Add `.lua` file to appropriate `lua/plugins/<category>/` directory
2. **Define plugin spec**: Use lazy.nvim format
3. **Add dependencies**: List required plugins
4. **Set event/cmd triggers**: For lazy loading optimization
5. **Test loading**: Run `:Lazy sync` to install

Example:
```lua
return {
  "github-user/plugin-name",
  dependencies = { "other-plugin/required" },
  event = "VeryLazy",  -- or cmd = "PluginCommand"
  config = function()
    require("plugin-name").setup({})
  end,
}
```

### Updating LSP Servers

**Manual Installation**:
```lua
-- Edit lua/plugins/lsp/lsp-config.lua
-- Add to ensure_installed list:
ensure_installed = {
  "new_lsp_server",
  -- existing servers...
}

-- Then configure the server:
lspconfig.new_lsp_server.setup({
  -- configuration
})
```

**Using Mason UI**:
```vim
:Mason  " Opens Mason UI
" Navigate and install/update servers
```

### Adding New Formatters

1. **Install via Mason** or system package manager
2. **Add to None-LS** configuration:
```lua
-- lua/plugins/lsp/none-ls.lua
null_ls.builtins.formatting.new_formatter,
null_ls.builtins.diagnostics.new_linter,
```
3. **Sync lazy.nvim**: `:Lazy sync`

### Troubleshooting LSP

**No completions appearing**:
- Verify LSP server is installed: `:Mason`
- Check LSP is attached: `:LspInfo`
- Verify nvim-cmp is loaded: `:Lazy show nvim-cmp`

**Formatting not working**:
- Check None-LS formatters: `:Lazy show none-ls.nvim`
- Verify formatter is installed
- Check file type is supported
- Use `:set filetype?` to confirm detected type

**Treesitter issues**:
- Update parsers: `:TSUpdate`
- Check parser status: `:TSModuleInfo`
- Install missing parser: `:TSInstall <language>`

**Python venv not detected**:
- Verify venv location (`.venv`, `venv`, or `.env`)
- Check Python version: `python --version`
- Reinstall pylsp in venv: `pip install python-lsp-server`

### Managing Plugin Versions

Plugins use lazy.nvim's version pinning:
- `version = "*"` - Latest release
- `version = "^1.0.0"` - Semver compatible
- `tag = "0.1.6"` - Specific release
- `branch = "main"` - Development branch

### Performance Optimization

**Check loading times**:
```vim
:Lazy profile  " Shows plugin load times
```

**Lazy load optimization**:
- Set appropriate `event` triggers
- Use `cmd` for command-only plugins
- Defer VeryLazy until UI is ready

Current events used:
- `VeryLazy` - After UI setup
- `InsertEnter` - When entering insert mode
- `BufReadPost` - After file load
- `BufReadPre` - Before file load
- `BufNewFile` - New file creation
- `cmd` - Specific command

### Configuring AI Plugins

**CodeCompanion Setup**:
1. Set `ANTHROPIC_TOKEN`: `export ANTHROPIC_TOKEN=your_token`
2. Verify in config: Check adapters use environment variable
3. Test: `<C-c>` to open actions

**Avante Setup**:
1. Set `ANTHROPIC_TOKEN` environment variable
2. Install build dependencies: `make` command
3. Configure model: Currently using Claude 3.7 Sonnet
4. Test auto-suggestions while coding

### Git Integration Setup

**LazyGit requires**:
- Git installed
- Tmux (optional but recommended)
- Terminal with proper color support

**Gitsigns**:
- Works with any git repository
- Auto-initializes on file open
- No external dependencies

### Debugging Setup

**Go debugging**:
1. Install delve: `go install github.com/go-delve/delve/cmd/dlv@latest`
2. Mason should auto-install or use `:Mason` to install `delve`
3. Use F-keys to control debugger

**Other languages**:
- DAP is Go-focused
- Extend with additional adapters as needed
- Check `:help dap` for configuration

### Terminal Integration

**Tmux**:
- Requires tmux installed
- Works with standard vim-tmux-navigator config
- See tmux configuration for full setup

**Kitty Terminal**:
- Specific to Kitty terminal emulator
- Check Kitty documentation for scrollback integration
- May require Kitty plugin installation

**Ghostty**:
- Configuration validation on save
- Requires Ghostty terminal installed
- Check Ghostty config format with `:check_timeout`

---

## Quick Reference: Common Keymaps

### LSP Operations
- `gd` - Go to definition
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>ca` - Code action
- `<leader>rn` - Rename symbol
- `<leader>ds` - Document symbols

### Editing
- `gcc` - Toggle line comment
- `cs"'` - Change surround (surround to single quote)
- `ds"` - Delete surround
- `zR` / `zM` - Open/close all folds

### Navigation
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>a` - Add to harpoon
- `<leader>1-4` - Jump to harpoon file

### Git
- `<leader>lg` - Open LazyGit
- `<leader>hs` / `<leader>hr` - Stage/reset hunk
- `<leader>hp` - Preview hunk
- `]c` / `[c` - Next/previous hunk

### Debugging
- `<space>b` - Toggle breakpoint
- `<F1>` - Continue
- `<F2-4>` - Step into/over/out

### UI
- `-` - Open file manager
- `<leader>?` - Show keymaps (which-key)
- `<leader>xx` - Show diagnostics (Trouble)

---

## Resources

- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Neovim LSP Documentation](https://neovim.io/doc/user/lsp.html)
- [Treesitter Documentation](https://github.com/nvim-treesitter/nvim-treesitter)
- [DAP Documentation](https://github.com/mfussenegger/nvim-dap/wiki)
- [Anthropic API Docs](https://docs.anthropic.com)

---

**Last Updated**: 2026-01-12
**NeoVim Version**: 0.11.0+
**Configuration Root**: `/Users/danielabeles/dotfiles/nvim/`
