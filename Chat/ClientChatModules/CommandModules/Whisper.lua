local localPlayer
local Util = require(script.Parent:WaitForChild("Util"))
local ChatSettings = require(script.Parent.Parent:WaitForChild("ChatSettings"))
local players = game:GetService("Players")
local ChatLocalization = nil
pcall(
    function()
        --[[
          line: 13
          upvalues:
            ChatLocalization (ref, index: 1)
        ]]
        ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
localPlayer = players.LocalPlayer

while localPlayer == nil do
    players.ChildAdded:wait()
    localPlayer = players.LocalPlayer
end

local Class = {}
Class.__index = Class
local v7 = {}

function Class.TrimWhisperCommand(self, text: string)
    --[[
      name: TrimWhisperCommand
      line: 26
    ]]
    if string.sub(text, 1, 3):lower() == "/w " then
        return (string.sub(text, 4))
    end

    return if string.sub(text, 1, 9):lower() ~= "/whisper " then nil else (string.sub(text, 10))
end

function Class.TrimWhiteSpace(self, text: string)
    --[[
      name: TrimWhiteSpace
      line: 35
    ]]
    return string.gsub(text, "%s+", ""), text[#text] == " "
end

function Class.ShouldAutoCompleteNames(self)
    --[[
      name: ShouldAutoCompleteNames
      line: 41
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if ChatSettings.WhisperCommandAutoCompletePlayerNames ~= nil then
        return ChatSettings.WhisperCommandAutoCompletePlayerNames
    end

    return true
end

function Class.GetWhisperingPlayer(self, a14)
    --[[
      name: GetWhisperingPlayer
      line: 48
      upvalues:
        players (copy, index: 1)
        localPlayer (ref,  index: 2)
        ChatSettings (copy, index: 3)
    ]]
    if const v15 = self:TrimWhisperCommand((a14:lower())) then
        local key
        local v17
        local text, v19 = self:TrimWhiteSpace(v15)
        local v20 = {}
        local v21 = {}
        local players2 = players:GetPlayers()

        for playerKey = 1, #players2 do
            if players2[playerKey] ~= localPlayer then
                if string.sub(players2[playerKey].Name:lower(), 1, (string.len(text))) == text then
                    v20[players2[playerKey]] = players2[playerKey].Name:lower()
                end

                if ChatSettings.WhisperByDisplayName then
                    local text2 = players2[playerKey].DisplayName:lower()

                    if string.sub(text2, 1, (string.len(text))) == text then
                        v21[players2[playerKey]] = text2
                    end
                end
            end
        end

        local v25 = 0
        local v26
        key, v17 = nil, nil

        for key2, v28 in pairs(v20) do
            v26 = v25 + 1

            if v28 == text and v19 then
                return key2
            end

            v25, key, v17 = v26, key2, v28
        end

        if ChatSettings.WhisperByDisplayName then
            for key3, v30 in pairs(v21) do
                if key ~= key3 then
                    v25 += 1
                    key, v17 = key3, v30
                end
            end
        end

        if v25 == 1 then
            if self:ShouldAutoCompleteNames() then
                return key
            end
            if v17 == text then
                return key
            end
        end
    end

    return nil
end

function Class.GetWhisperChanneNameColor(self)
    --[[
      name: GetWhisperChanneNameColor
      line: 106
    ]]
    if self.ChatSettings.WhisperChannelNameColor then
        return self.ChatSettings.WhisperChannelNameColor
    end

    return Color3.fromRGB(102, 14, 102)
end

function Class.EnterWhisperState(self, a33)
    --[[
      name: EnterWhisperState
      line: 113
      upvalues:
        ChatSettings (copy, index: 1)
        ChatLocalization (ref,  index: 2)
    ]]
    self.PlayerNameEntered = true
    self.PlayerName = a33.Name
    self.PlayerDisplayName = a33.DisplayName
    self.MessageModeButton.Size = UDim2.new(0, 1000, 1, 0)
    local text = if ChatSettings.PlayerDisplayNamesEnabled and ChatSettings.WhisperByDisplayName then string.format("[To %s]", a33.DisplayName) else string.format("[To %s]", a33.Name)

    if ChatLocalization.tryLocalize then
        text = ChatLocalization:tryLocalize(text)
    end

    self.MessageModeButton.Text = text
    self.MessageModeButton.TextColor3 = self:GetWhisperChanneNameColor()
    local ceilingValue = math.ceil(self.MessageModeButton.TextBounds.X)
    self.MessageModeButton.Size = UDim2.new(0, ceilingValue, 1, 0)
    self.TextBox.Size = UDim2.new(1, -ceilingValue, 1, 0)
    self.TextBox.Position = UDim2.new(0, ceilingValue, 0, 0)
    self.TextBox.Text = " "
end

function Class.TextUpdated(self)
    --[[
      name: TextUpdated
      line: 142
    ]]
    local text = self.TextBox.Text

    if self.PlayerNameEntered then
        if text == "" then
            self.MessageModeButton.Text = ""
            self.MessageModeButton.Size = UDim2.new(0, 0, 0, 0)
            self.TextBox.Size = UDim2.new(1, 0, 1, 0)
            self.TextBox.Position = UDim2.new(0, 0, 0, 0)
            self.TextBox.Text = ""
            self.PlayerNameEntered = false
            self.ChatBar:ResetCustomState()
            self.ChatBar:CaptureFocus()
        end
    elseif const whisperingPlayer = self:GetWhisperingPlayer(text) then
        self:EnterWhisperState(whisperingPlayer)
    end
end

function Class.GetMessage(self)
    --[[
      name: GetMessage
      line: 166
    ]]
    if self.PlayerNameEntered then
        return "/w " .. self.PlayerName .. " " .. self.TextBox.Text
    end

    return self.TextBox.Text
end

function Class.ProcessCompletedMessage(a40)
    --[[
      name: ProcessCompletedMessage
      line: 173
    ]]
    return false
end

function Class.Destroy(self)
    --[[
      name: Destroy
      line: 177
    ]]
    self.MessageModeConnection:disconnect()
    self.Destroyed = true
end

function v7.new(chatWindow, chatBar, chatSettings, a45)
    --[[
      name: new
      line: 182
      upvalues:
        Class (copy, index: 1)
    ]]
    local v46 = setmetatable({}, Class)
    v46.Destroyed = false
    v46.ChatWindow = chatWindow
    v46.ChatBar = chatBar
    v46.ChatSettings = chatSettings
    v46.TextBox = chatBar:GetTextBox()
    v46.MessageModeButton = chatBar:GetMessageModeTextButton()
    v46.OriginalWhisperText = ""
    v46.PlayerNameEntered = false

    v46.MessageModeConnection = v46.MessageModeButton.MouseButton1Click:connect(
        function()
            --[[
              line: 193
              upvalues:
                v46 (copy, index: 1)
            ]]
            local v47 = v46.TextBox.Text

            if string.sub(v47, 1, 1) == " " then
                v47 = string.sub(v47, 2)
            end

            v46.ChatBar:ResetCustomState()
            v46.ChatBar:SetTextBoxText(v47)
            v46.ChatBar:CaptureFocus()
        end
    )

    if a45 then
        v46:EnterWhisperState(a45)
        return v46
    end

    v46:TextUpdated()

    return v46
end

function ProcessMessage(text: string, chatWindow, chatBar, chatSettings)
    --[[
      name: ProcessMessage
      line: 212
      upvalues:
        v7 (copy, index: 1)
    ]]
    if string.sub(text, 1, 3):lower() ~= "/w " and string.sub(text, 1, 9):lower() ~= "/whisper " then
        return nil
    end

    return v7.new(chatWindow, chatBar, chatSettings)
end

function CreateCustomState(a52, chatWindow, chatBar, chatSettings)
    --[[
      name: CreateCustomState
      line: 219
      upvalues:
        v7 (copy, index: 1)
    ]]
    return v7.new(chatWindow, chatBar, chatSettings, a52)
end

local v56 = {}
v56[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.IN_PROGRESS_MESSAGE_PROCESSOR
v56[Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
v56.CustomStateCreator = CreateCustomState

return v56