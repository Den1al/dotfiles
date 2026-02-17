# Hammerspoon Configuration

Language: Lua. Runtime: Hammerspoon (macOS automation framework).

## Setup

Config path is `~/.config/hammerspoon/init.lua`, set via:
```
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
```

Hammerspoon is a GUI app and does not inherit shell environment variables. Use `launchctl setenv` to propagate env vars.

## Structure

- `init.lua` — Entry point. App-switching hotkeys, config reload, and spoon loading.
- `Spoons/` — Hammerspoon plugin packages (each is a `.spoon` directory with `init.lua`).

## Hotkeys

| Binding | Action |
|---------|--------|
| `cmd+alt+T` | Focus Ghostty |
| `cmd+alt+B` | Focus Arc |
| `cmd+alt+S` | Focus Slack |
| `cmd+alt+M` | Focus Spotify |
| `cmd+alt+Z` | Focus Zoom |
| `cmd+alt+,` | Focus System Settings |
| `alt+R` | Reload Hammerspoon config |
| `alt+C` | Rewrite selected text in place (ClaudeRewriter) |
| `alt+shift+C` | Show rewrite menu on selected text (ClaudeRewriter) |

## ClaudeRewriter Spoon

Path: `Spoons/ClaudeRewriter.spoon/`

Rewrites selected text using the Anthropic Messages API. Reads the API key from `~/.config/gitlab-duo/a-key`.

### Hotkey actions

- `rewrite` — Sends selected text to Claude with the default system prompt, replaces selection with result.
- `clipboard` — Same as rewrite but copies result to clipboard instead of pasting.
- `menu` — Shows a popup context menu with prompt options loaded from disk. Selecting one rewrites the text in place.

### Configurable properties

- `apiKey` — Anthropic API key (required).
- `model` — Model ID (default: `claude-sonnet-4-5`).
- `systemPrompt` — Default system prompt used by the `rewrite` action.
- `promptsPath` — Directory for menu prompts (default: `Spoons/ClaudeRewriter.spoon/prompts/`).
- `alertDuration` — How long alerts display in seconds (default: 1.5).

### Menu prompts

Prompt files live in `Spoons/ClaudeRewriter.spoon/prompts/` as markdown files with YAML front matter. Menu order is determined by filename sort order (use numeric prefixes like `01-`, `02-`).

Format:
```markdown
---
title: Menu Item Title
---
The system prompt text sent to Claude.
```

Required front matter field: `title` (displayed in the menu). The markdown body is the system prompt.

To add a new menu item, create a new `.md` file in the prompts directory.

## Code style

- Tabs for indentation.
- Hammerspoon APIs are available via the global `hs` namespace.
- Spoons follow Hammerspoon conventions: `init()`, `bindHotkeys()`, `start()`, `stop()`.
