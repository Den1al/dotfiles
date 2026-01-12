-- According to https://github.com/omerxx/dotfiles/blob/master/hammerspoon/README
-- In order for the configuration of hammerspoont to be properly picked up
-- we neeed to run the following command:
--  > defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

-- hotkey is cmd+alt
local hk_leader = { "cmd", "alt" }
local hk_mapping = {
  ["Ghostty"] = "T",        -- terminal
  ["Arc"] = "B",            -- browser
  ["Slack"] = "S",          -- slack
  ["Spotify"] = "M",        -- music
  ["zoom.us"] = "Z",        -- zoom
  ["Docker Desktop"] = "C", -- container client
  ["System Settings"] = ",", -- settings
}

-- bind each hotkey to its' app
for appName, hotKey in pairs(hk_mapping) do
  hs.hotkey.bind(hk_leader, hotKey, function()
    hs.application.launchOrFocus(appName)
  end)
end

-- this will reload the config on alt+R
hs.hotkey.bind({ "alt" }, "R", function()
  hs.reload()
end)

hs.alert.show("🔮 Config loaded")
