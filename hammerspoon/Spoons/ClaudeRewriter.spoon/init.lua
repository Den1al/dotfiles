local obj = {}
obj.__index = obj

obj.name = "ClaudeRewriter"
obj.version = "1.0"
obj.author = "Daniel Abeles"
obj.homepage = "https://github.com/Den1al/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.claudePath = os.getenv("HOME") .. "/.local/bin/claude"
obj.model = "sonnet"
obj.systemPrompt =
	"Rewrite the following text for clarity and correct grammar. Preserve the original tone, intent, and meaning. Return ONLY the rewritten text with no preamble or explanation. Don't use emdashes."
obj.alertDuration = 1.5

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

	if not hs.fs.attributes(self.claudePath) then
		hs.alert.show("Claude CLI not found", self.alertDuration)
		return
	end

	rewriting = true
	local savedClipboard = hs.pasteboard.readAllData()
	local progressAlert = hs.alert.show("Rewriting...", 30)

	local args = {
		"-p",
		selected,
		"--model",
		self.model,
		"--output-format",
		"text",
		"--system-prompt",
		self.systemPrompt,
	}

	local task = hs.task.new(self.claudePath, function(exitCode, stdout, stderr)
		hs.alert.closeSpecific(progressAlert)
		rewriting = false

		if exitCode ~= 0 then
			hs.alert.show("Rewrite failed", self.alertDuration)
			return
		end

		local result = stdout and stdout:gsub("^%s+", ""):gsub("%s+$", "") or ""
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
	end, args)

	task:start()
end

return obj
