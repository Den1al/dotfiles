# Key Bindings

## Harpoon

```bash
<leader>ft - harpoon telescope (c-d to delete)
<leader>a - harpoon add

<leader>1 - harpoon#1
<leader>2 - harpoon#2
<leader>3 - harpoon#3
<leader>4 - harpoon#4

```

## Git

### LazyGit

```bash
<leader> lg - show lazygit
```

### GitSigns

```bash
]c - next hunk
[c - prev hunk

<leader>hs - stage hunk
<leader>hr - reset hunk
<leader>hu - undo stage hunk

<leader>hS - stage buffer
<leader>hR - reset buffer
<leader>hp - preview hunk

<leader>hb - blame line
<leader>tb - toggle current line blame
<leader>hD - diff this
<leader>td - toggle deleted

ih - select hunk
```

## LSP

```bash
<leader>rn - rename
<leader>ca - code action
gd - go to definition
gr - go to references
gI - go to implementation

<leader>D - type definition
<leader>ds - LSP document symbols
<leader>ws - LSP workspace symbols

K - hover on buffer
gd - go to definition
<leader>gf - format document
```

## File System

### Oil

> use `-` to open oil

```bash

<C-s> - open in new vsplit
<C-h> - open in new hsplit
<C-p> - toggle preview
<C-l> - refresh view

gx - open external

"-" - parent
"_" - open cwd
"`" - cwd
```

### NeoTree

```bash
<C-n> - show filesystem
```

## Telescope

```bash
<leader>ff - find files
<leader>fg - live grep
<leader>fb - buffers
<leader>fh - help tags
```

## Surround

> The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively.

```bash

ys - add
ds - delete
cs - change
```

## Tmux Navigator

```bash
<C-h> - navigate left
<C-j> - navigate down
<C-k> - navigate up
<C-l> - navigate right
<C-\> - navigate previous
```

## Trouble

```bash
<leader>xx - trouble toggle
<leader>xq - quickfix
<leader>xl - trouble loclist
<leader>xr - trouble lsp refs
```

## Noice

```bash
<leader>nl - noice last message
<leader>nh - noice history (telescope)
```

## Window Resize

```bash
<S-h> - change width left
<S-l> - change width right
<+>   - change width up
<->   - change width down

```

## AI Companion

> cc is expanded to CodeCompanion

```bash
# <C-c> - code completions actions
<leader>c - code completions toggle
ga - add to code completion

```
