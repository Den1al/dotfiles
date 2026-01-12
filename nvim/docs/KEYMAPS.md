# NeoVim Keymaps Reference

This document provides a comprehensive reference for all keymaps configured in this NeoVim setup. The leader key is `<Space>`.

## Table of Contents

- [Navigation](#navigation)
- [LSP (Language Server Protocol)](#lsp-language-server-protocol)
- [Formatting](#formatting)
- [Git](#git)
- [AI Tools](#ai-tools)
- [Debugging](#debugging)
- [Tools](#tools)
- [Editing](#editing)

---

## Navigation

### Core Vim Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `B` | Normal | Jump to beginning of line |
| `E` | Normal | Jump to end of line |

### Window Management

| Keymap | Mode | Description |
|--------|------|-------------|
| `<Shift-h>` | Normal | Resize window left |
| `<Shift-l>` | Normal | Resize window right |
| `+` | Normal | Resize window up |
| `_` | Normal | Resize window down |

### Tmux Navigation

Integration with tmux for seamless navigation between Neovim and tmux panes.

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-h>` | Normal | Navigate/Move to left pane (Tmux/Vim) |
| `<C-j>` | Normal | Navigate/Move to down pane (Tmux/Vim) |
| `<C-k>` | Normal | Navigate/Move to up pane (Tmux/Vim) |
| `<C-l>` | Normal | Navigate/Move to right pane (Tmux/Vim) |
| `<C-\>` | Normal | Navigate to previous pane (Tmux/Vim) |

### Telescope - Fuzzy Finder

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>ff` | Normal | Find files (rg hidden files support) |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Find help tags |
| `<leader>fg` | Normal | Live grep with multi-grep support |

#### Telescope Multi-Grep
- Type search pattern followed by `  ` (double space) and file glob patterns
- Example: `error  *.lua *.py` searches for "error" in Lua and Python files

### Harpoon - Quick Navigation

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>a` | Normal | Add current file to harpoon |
| `<leader>1` | Normal | Navigate to harpoon file #1 |
| `<leader>2` | Normal | Navigate to harpoon file #2 |
| `<leader>3` | Normal | Navigate to harpoon file #3 |
| `<leader>4` | Normal | Navigate to harpoon file #4 |
| `<leader>fh` | Normal | Harpoon telescope view (also used by find help) |

#### Harpoon Telescope View
- `<C-d>` in insert mode: Delete selected file from harpoon list

### Trouble - Diagnostics & References

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>xx` | Normal | Toggle diagnostics (Trouble) |
| `<leader>xr` | Normal | Toggle LSP references/definitions (Trouble) |
| `<leader>xl` | Normal | Toggle location list (Trouble) |
| `<leader>xq` | Normal | Toggle quickfix list (Trouble) |

### Search

| Keymap | Mode | Description |
|--------|------|-------------|
| `ss` | Normal | Clear search highlights |

---

## LSP (Language Server Protocol)

### Navigation & References

| Keymap | Mode | Description |
|--------|------|-------------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references (Telescope) |
| `gI` | Normal | Go to implementation |
| `gD` | Normal | Go to declaration |
| `<leader>D` | Normal | Go to type definition |

### Code Intelligence

| Keymap | Mode | Description |
|--------|------|-------------|
| `K` | Normal | Hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code actions |
| `<leader>ds` | Normal | Document symbols (Telescope) |
| `<leader>ws` | Normal | Workspace symbols (Telescope) |

---

## Formatting

Formatting is handled by None-ls integrations with various formatters. No direct keymaps configured. Use `:Format` command or configure in lsp-config.

---

## Git

### Gitsigns - Inline Git Changes

| Keymap | Mode | Description |
|--------|------|-------------|
| `]c` | Normal | Navigate to next hunk |
| `[c` | Normal | Navigate to previous hunk |
| `<leader>hs` | Normal, Visual | Stage hunk |
| `<leader>hr` | Normal, Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |
| `<leader>tb` | Normal | Toggle current line blame |
| `<leader>hd` | Normal | Diff this buffer |
| `<leader>hD` | Normal | Diff this (~) |
| `<leader>td` | Normal | Toggle deleted |
| `ih` | Operator, Visual | Select hunk (text object) |

### LazyGit - Git UI

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>lg` | Normal | Open LazyGit |

---

## AI Tools

### CodeCompanion - AI Chat & Actions

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-c>` | Normal, Visual | Open CodeCompanion actions menu |
| `<leader>c` | Normal, Visual | Toggle CodeCompanion chat |
| `ga` | Visual | Add selected code to CodeCompanion chat |

#### Command Abbreviation
- `:cc` → Expands to `:CodeCompanion`

### Avante - Claude AI Assistant

| Keymap | Mode | Description |
|--------|------|-------------|
| Configured via opts | Normal, Visual | Auto-keymaps enabled (check plugin config) |

#### Features
- Provider: Claude 3.7 Sonnet
- Auto-suggestions enabled
- Image pasting support
- Markdown rendering

---

## Debugging

### DAP (Debug Adapter Protocol)

#### Breakpoints & Control

| Keymap | Mode | Description |
|--------|------|-------------|
| `<space>b` | Normal | Toggle breakpoint |
| `<space>B` | Normal | Set conditional breakpoint |
| `<space>gb` | Normal | Run to cursor |
| `<space>?` | Normal | Evaluate variable under cursor |

#### Execution

| Keymap | Mode | Description |
|--------|------|-------------|
| `<F1>` | Normal | Continue execution |
| `<F2>` | Normal | Step into |
| `<F3>` | Normal | Step over |
| `<F4>` | Normal | Step out |
| `<F5>` | Normal | Step back |
| `<F13>` | Normal | Restart debugging |

#### Supported Languages
- Go (dap-go)
- DAP UI opens/closes automatically on attach/launch/terminate events

---

## Tools

### FloatTerm - Floating Terminal

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>ft` | Normal | Open floating terminal |
| `<leader>flt` | Normal, Terminal | Toggle floating terminal |

#### Configuration
- Size: 90% height × 90% width
- Position: Center
- Auto-close: After 2 seconds

### Oil - File Explorer

| Keymap | Mode | Description |
|--------|------|-------------|
| `-` | Normal | Toggle file explorer (parent directory) |

#### In Oil Buffer
- `q` | Close file explorer |
- `<C-c>` | Disabled (prevented conflict) |

### UFO - Code Folding

| Keymap | Mode | Description |
|--------|------|-------------|
| `zR` | Normal | Open all folds |
| `zM` | Normal | Close all folds |
| `zK` | Normal | Peek folded lines under cursor (or show hover) |

#### Features
- Uses LSP and indent providers for folding
- Fold column: 1 character wide
- Initial fold level: 99 (all folds open)

### Noice - UI Enhancement

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>nl` | Normal | Show last Noice message |
| `<leader>nh` | Normal | Show Noice messages in Telescope |

#### Features
- Bottom search bar enabled
- Command palette enabled
- Long messages sent to split

### Which-Key - Keymap Helper

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>?` | Normal | Show buffer local keymaps |

---

## Editing

### Comments - Toggle Comments

| Keymap | Mode | Description |
|--------|------|-------------|
| `gcc` | Normal | Toggle comment (current line) |
| `gc` | Normal, Operator | Toggle comment (linewise) |
| `gc` | Visual | Toggle comment (visual selection, linewise) |
| `gbc` | Normal | Toggle comment (current block) |
| `gb` | Normal, Operator | Toggle comment (blockwise) |
| `gb` | Visual | Toggle comment (visual selection, blockwise) |

### Surround - Surround Operations

Uses `nvim-surround` plugin. Keymaps are plugin defaults:
- `ys{motion}{char}` - Surround motion with character
- `yss{char}` - Surround entire line with character
- `ds{char}` - Delete surrounding character
- `cs{old}{new}` - Change surrounding character

#### Example
- `ysiw"` - Surround inner word with double quotes
- `ds"` - Delete surrounding double quotes
- `cs"'` - Change double quotes to single quotes

### Autocompletion - nvim-cmp

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-b>` | Insert | Scroll documentation up |
| `<C-f>` | Insert | Scroll documentation down |
| `<CR>` | Insert | Confirm completion |
| `<Tab>` | Insert | Select next completion item |
| `<S-Tab>` | Insert | Select previous completion item |
| `<C-c>` | Insert | Manually trigger completion |

#### Snippet Navigation
Commented out but available:
- `<C-l>` - Move to right of expansion location (Luasnip)
- `<C-h>` - Move to left of expansion location (Luasnip)

---

## Key Modifiers Reference

| Symbol | Name |
|--------|------|
| `<leader>` | Leader key (mapped to `<Space>`) |
| `<C-x>` | Control + x |
| `<S-x>` | Shift + x |
| `<M-x>` | Alt/Meta + x |
| `<A-x>` | Alt + x (same as `<M-x>`) |

## Vim Modes

| Code | Name | Usage |
|------|------|-------|
| `n` | Normal | Default mode |
| `i` | Insert | Editing text |
| `v` | Visual | Character selection |
| `V` | Visual Line | Line selection |
| `x` | Visual Block | Block selection |
| `o` | Operator | With operators like `d`, `c`, `y` |
| `t` | Terminal | Terminal mode |

---

## LSP Servers Configured

- **Lua**: lua_ls
- **TypeScript/JavaScript**: ts_ls
- **Go**: gopls
- **Python**: pylsp (with venv auto-detection)
- **OCaml**: ocamllsp
- **Markdown**: marksman
- **Bash**: bashls
- **Java**: java_language_server
- **Jinja2**: jinja_lsp
- **Docker**: dockerls
- **Go Linting**: golangci_lint_ls

---

## Tips & Tricks

### Multi-Grep Usage
In Telescope multi-grep (`<leader>fg`):
```
error  *.lua *.py
```
This searches for "error" in `.lua` and `.py` files.

### Harpoon Workflow
1. `<leader>a` to add files to harpoon
2. `<leader>1-4` to jump between harpooned files
3. `<leader>fh` to view all harpooned files in Telescope

### Window Resizing
- `Shift-h` / `Shift-l` for horizontal resizing (left/right)
- `+` / `_` for vertical resizing (up/down)

### Git Workflow with Gitsigns
1. `]c` / `[c` to navigate hunks
2. `<leader>hs` to stage hunks
3. `<leader>hp` to preview changes
4. `<leader>lg` to open LazyGit for commits

### LSP Refactoring
1. `gd` to go to definition
2. `<leader>rn` to rename across the codebase
3. `<leader>ca` for code actions (auto-fixes)

### Code Folding
- `zR` to expand all folds in a file
- `zK` to peek at folded content
- `zM` to fold everything

---

Generated: 2026-01-12
NeoVim Configuration Version: 0.11+
Leader Key: `<Space>`
