local obj = {}
obj.__index = obj

obj.name = "ClaudeRewriter"
obj.version = "1.0"
obj.author = "Daniel Abeles"
obj.homepage = "https://github.com/Den1al/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Note: Hammerspoon is a GUI app and won't see shell env vars by default.
-- Use `launchctl setenv ANTHROPIC_API_KEY <value>` in your shell config
-- to propagate it to launchd so os.getenv() works here.
obj.apiKey = nil
obj.model = "claude-sonnet-4-5"
obj.systemPrompt =
	"Rewrite the following text for clarity and correct grammar. Preserve the original tone, intent, and meaning. Return ONLY the rewritten text with no preamble or explanation. DONT use emdashes. Use emojies to express gratitude, but avoid face emojies, only symbols."
obj.alertDuration = 1.5
obj.promptsPath = nil -- set externally; defaults to spoon's prompts/ dir

local API_URL = "https://api.anthropic.com/v1/messages"

local hotkeys = {}
local rewriting = false

local function getSelectedText()
	local systemElement = hs.axuielement.systemWideElement()
	local focusedElement = systemElement:attributeValue("AXFocusedUIElement")
	if not focusedElement then
		return nil
	end
	return focusedElement:attributeValue("AXSelectedText")
end

local function parseFrontMatter(content)
	local frontMatter, body = content:match("^%-%-%-\n(.-)\n%-%-%-\n(.*)$")
	if not frontMatter then
		return nil, content
	end
	local meta = {}
	for line in frontMatter:gmatch("[^\n]+") do
		local key, value = line:match("^(%w+):%s*(.+)$")
		if key then
			if tonumber(value) then
				meta[key] = tonumber(value)
			else
				meta[key] = value
			end
		end
	end
	return meta, body:gsub("^%s+", ""):gsub("%s+$", "")
end

local function loadPrompts(dir)
	local prompts = {}
	local files = {}
	local iter, dirObj = hs.fs.dir(dir)
	if not iter then
		return prompts
	end
	for file in iter, dirObj do
		if file:match("%.md$") then
			files[#files + 1] = file
		end
	end
	table.sort(files)
	for _, file in ipairs(files) do
		local path = dir .. "/" .. file
		local f = io.open(path, "r")
		if f then
			local content = f:read("*a")
			f:close()
			local meta, body = parseFrontMatter(content)
			if meta and meta.title and body ~= "" then
				prompts[#prompts + 1] = {
					title = meta.title,
					prompt = body,
				}
			end
		end
	end
	return prompts
end

function obj:init()
	return self
end

function obj:bindHotkeys(mapping)
	for action, bind in pairs(mapping) do
		local mods, key = bind[1], bind[2]
		if action == "rewrite" then
			hotkeys[#hotkeys + 1] = hs.hotkey.new(mods, key, function()
				self:rewrite(true)
			end)
		elseif action == "clipboard" then
			hotkeys[#hotkeys + 1] = hs.hotkey.new(mods, key, function()
				self:rewrite(false)
			end)
		elseif action == "menu" then
			hotkeys[#hotkeys + 1] = hs.hotkey.new(mods, key, function()
				self:showMenu()
			end)
		end
	end
	return self
end

function obj:start()
	for _, hk in ipairs(hotkeys) do
		hk:enable()
	end
	return self
end

function obj:stop()
	for _, hk in ipairs(hotkeys) do
		hk:disable()
	end
	return self
end

function obj:showMenu()
	local selected = getSelectedText()
	if not selected or selected == "" then
		hs.alert.show("No text selected", self.alertDuration)
		return
	end

	local dir = self.promptsPath or (hs.spoons.scriptPath() .. "/prompts")
	local prompts = loadPrompts(dir)
	if #prompts == 0 then
		hs.alert.show("No prompts found in " .. dir, self.alertDuration)
		return
	end

	local menuItems = {}
	for _, p in ipairs(prompts) do
		menuItems[#menuItems + 1] = {
			title = p.title,
			fn = function()
				self:rewrite(true, p.prompt)
			end,
		}
	end

	local menu = hs.menubar.new(false)
	menu:setMenu(menuItems)
	menu:popupMenu(hs.mouse.absolutePosition())
end

function obj:rewrite(pasteInPlace, promptOverride)
	if rewriting then
		hs.alert.show("Rewrite in progress", self.alertDuration)
		return
	end

	local selected = getSelectedText()
	if not selected or selected == "" then
		hs.alert.show("No text selected", self.alertDuration)
		return
	end

	if not self.apiKey or self.apiKey == "" then
		hs.alert.show("API key not set", self.alertDuration)
		return
	end

	rewriting = true
	local savedClipboard = hs.pasteboard.readAllData()
	local progressAlert = hs.alert.show("Rewriting...", 30)

	local headers = {
		["x-api-key"] = self.apiKey,
		["anthropic-version"] = "2023-06-01",
		["content-type"] = "application/json",
	}

	local body = hs.json.encode({
		model = self.model,
		max_tokens = 4096,
		system = promptOverride or self.systemPrompt,
		messages = {
			{ role = "user", content = selected },
		},
	})

	hs.http.asyncPost(API_URL, body, headers, function(status, responseBody)
		hs.alert.closeSpecific(progressAlert)
		rewriting = false

		if status ~= 200 then
			hs.alert.show("Rewrite failed (HTTP " .. tostring(status) .. ")", self.alertDuration)
			return
		end

		local ok, response = pcall(hs.json.decode, responseBody)
		if not ok or not response or not response.content or #response.content == 0 then
			hs.alert.show("Failed to parse response", self.alertDuration)
			return
		end

		local result = (response.content[1].text or ""):gsub("^%s+", ""):gsub("%s+$", "")
		if result == "" then
			hs.alert.show("Empty response", self.alertDuration)
			return
		end

		hs.pasteboard.setContents(result)

		if pasteInPlace then
			hs.eventtap.keyStroke({ "cmd" }, "v")
			hs.timer.doAfter(0.2, function()
				hs.pasteboard.writeAllData(savedClipboard)
				hs.alert.show("Rewritten", self.alertDuration)
			end)
		else
			hs.alert.show("Copied to clipboard", self.alertDuration)
		end
	end)
end

return obj
