local obj = {}
obj.__index = obj

obj.name = "ClaudeRewriter"
obj.version = "1.0"
obj.author = "Daniel Abeles"
obj.homepage = "https://github.com/Den1al/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.apiKey = nil
obj.model = "claude-sonnet-4-5"
obj.systemPrompt =
	"Rewrite the following text for clarity and correct grammar. Preserve the original tone, intent, and meaning. Return ONLY the rewritten text with no preamble or explanation. DONT use emdashes."
obj.alertDuration = 1.5

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

function obj:init()
	return self
end

function obj:bindHotkeys(mapping)
	for action, bind in pairs(mapping) do
		local mods, key = bind[1], bind[2]
		local paste = action == "rewrite"
		hotkeys[#hotkeys + 1] = hs.hotkey.new(mods, key, function()
			self:rewrite(paste)
		end)
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

function obj:rewrite(pasteInPlace)
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
		system = self.systemPrompt,
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
