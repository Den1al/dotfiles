-- Custom health checks
local M = {}

function M.check()
  local health = vim.health or require("health")

  health.start("Custom Configuration")

  -- Check ripgrep
  if vim.fn.executable("rg") == 1 then
    health.ok("ripgrep is installed")
  else
    health.warn("ripgrep not found", "Install ripgrep for better search: https://github.com/BurntSushi/ripgrep")
  end

  -- Check lazygit
  if vim.fn.executable("lazygit") == 1 then
    health.ok("lazygit is installed")
  else
    health.info("lazygit not found", "Optional: Install lazygit for git UI: https://github.com/jesseduffield/lazygit")
  end

  -- Check AI environment
  if vim.env.ANTHROPIC_TOKEN then
    health.ok("ANTHROPIC_TOKEN is set")
  else
    health.warn("ANTHROPIC_TOKEN not set", "Set environment variable for AI features")
  end

  -- Check Neovim version
  local version = vim.version()
  if version.major == 0 and version.minor >= 10 then
    health.ok(string.format("Neovim version: %d.%d.%d", version.major, version.minor, version.patch))
  else
    health.error("Neovim version too old", "Requires Neovim >= 0.10.0")
  end
end

return M
