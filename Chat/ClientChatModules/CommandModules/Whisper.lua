local Util_1 = require(script.Parent:WaitForChild("Util"))
local ChatSettings_upv_1 = require(script.Parent.Parent:WaitForChild("ChatSettings"))
local Players_upv_1 = game:GetService("Players")
local ChatLocalization_upv_1 = nil
pcall(
    function()
        --[[
          line: 13
          upvalues:
            ChatLocalization_upv_1 (ref, index: 1)
        ]]
        ChatLocalization_upv_1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
while LocalPlayer_upv_1 == nil do
    Players_upv_1.ChildAdded:wait()
    LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
end
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local tbl_upv_2 = {}
function tbl_upv_1.TrimWhisperCommand(a1, a2)
    --[[
      name: TrimWhisperCommand
      line: 26
    ]]
    if string.sub(a2, 1, 3):lower() ~= "/w " then
        if string.sub(a2, 1, 9):lower() ~= "/whisper " then
            return nil
        end
        return (string.sub(a2, 10))
    end
    return (string.sub(a2, 4))
end
function tbl_upv_1.TrimWhiteSpace(a1, a2)
    --[[
      name: TrimWhiteSpace
      line: 35
    ]]
    local v1 = string.gsub(a2, "%s+", "")
    return v1, a2[#a2] == " "
end
function tbl_upv_1.ShouldAutoCompleteNames(a1)
    --[[
      name: ShouldAutoCompleteNames
      line: 41
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if ChatSettings_upv_1.WhisperCommandAutoCompletePlayerNames == nil then
        return true
    end
    return ChatSettings_upv_1.WhisperCommandAutoCompletePlayerNames
end
function tbl_upv_1.GetWhisperingPlayer(a1, a2)
    --[[
      name: GetWhisperingPlayer
      line: 48
      upvalues:
        Players_upv_1 (copy, index: 1)
        LocalPlayer_upv_1 (ref,  index: 2)
        ChatSettings_upv_1 (copy, index: 3)
    ]]
    local v2 = a1:TrimWhisperCommand(a2:lower())
    if not v2 then
        return nil
    end
    local v3, v4 = a1:TrimWhiteSpace(v2)
    local tbl_3 = {}
    local tbl_4 = {}
    local v5 = Players_upv_1:GetPlayers()
    for n_1 = 1, #v5 do
        if v5[n_1] == LocalPlayer_upv_1 then
            continue
        end
        if string.sub(v5[n_1].Name:lower(), 1, string.len(v3)) == v3 then
            tbl_3[v5[n_1]] = v5[n_1].Name:lower()
        end
        if not (ChatSettings_upv_1.WhisperByDisplayName) then
            continue
        end
        local v6 = v5[n_1].DisplayName:lower()
        if string.sub(v6, 1, string.len(v3)) == v3 then
            tbl_4[v5[n_1]] = v6
        end
    end
    v5 = 0
    local v7 = nil
    local v8 = nil
    local v9, v10
    v9, v10 = v7, v8
    for key_1, value_1 in pairs(tbl_3) do
        v5 = v5 + 1
        if value_1 ~= v3 or not (v4) then
            v10 = value_1
            continue
        end
        return key_1
    end
    if ChatSettings_upv_1.WhisperByDisplayName then
        for key_2, value_2 in pairs(tbl_4) do
            if v9 ~= key_2 then
                v5 = v5 + 1
                v9, v10 = key_2, value_2
            end
        end
    end
    if v5 ~= 1 or not a1:ShouldAutoCompleteNames() and v10 ~= v3 then
        return nil
    end
    return v9
end
function tbl_upv_1.GetWhisperChanneNameColor(a1)
    --[[
      name: GetWhisperChanneNameColor
      line: 106
    ]]
    if a1.ChatSettings.WhisperChannelNameColor then
        return a1.ChatSettings.WhisperChannelNameColor
    end
    return Color3.fromRGB(102, 14, 102)
end
function tbl_upv_1.EnterWhisperState(a1, a2)
    --[[
      name: EnterWhisperState
      line: 113
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        ChatLocalization_upv_1 (ref,  index: 2)
    ]]
    a1.PlayerNameEntered = true
    a1.PlayerName = a2.Name
    a1.PlayerDisplayName = a2.DisplayName
    a1.MessageModeButton.Size = UDim2.new(0, 1000, 1, 0)
    local v11
    if (ChatSettings_upv_1.PlayerDisplayNamesEnabled) and (ChatSettings_upv_1.WhisperByDisplayName) then
        v11 = string.format("[To %s]", a2.DisplayName)
    else
        v11 = string.format("[To %s]", a2.Name)
    end
    if ChatLocalization_upv_1.tryLocalize then
        v11 = ChatLocalization_upv_1:tryLocalize(v11)
    end
    a1.MessageModeButton.Text = v11
    a1.MessageModeButton.TextColor3 = a1:GetWhisperChanneNameColor()
    v11 = math.ceil(a1.MessageModeButton.TextBounds.X)
    a1.MessageModeButton.Size = UDim2.new(0, v11, 1, 0)
    a1.TextBox.Size = UDim2.new(1, -v11, 1, 0)
    a1.TextBox.Position = UDim2.new(0, v11, 0, 0)
    a1.TextBox.Text = " "
end
function tbl_upv_1.TextUpdated(a1)
    --[[
      name: TextUpdated
      line: 142
    ]]
    local Text_1 = a1.TextBox.Text
    local v12 = nil
    if a1.PlayerNameEntered then
        if Text_1 ~= "" then
            return
        end
        a1.MessageModeButton.Text = ""
        a1.MessageModeButton.Size = UDim2.new(0, 0, 0, 0)
        a1.TextBox.Size = UDim2.new(1, 0, 1, 0)
        a1.TextBox.Position = UDim2.new(0, 0, 0, 0)
        a1.TextBox.Text = ""
        a1.PlayerNameEntered = false
        a1.ChatBar:ResetCustomState()
        a1.ChatBar:CaptureFocus()
    else
        v12 = a1:GetWhisperingPlayer(Text_1)
        if not v12 then
            return
        end
        a1:EnterWhisperState(v12)
    end
end
function tbl_upv_1.GetMessage(a1)
    --[[
      name: GetMessage
      line: 166
    ]]
    if a1.PlayerNameEntered then
        return "/w " .. a1.PlayerName .. " " .. a1.TextBox.Text
    end
    return a1.TextBox.Text
end
function tbl_upv_1.ProcessCompletedMessage(a1)
    --[[
      name: ProcessCompletedMessage
      line: 173
    ]]
    return false
end
function tbl_upv_1.Destroy(a1)
    --[[
      name: Destroy
      line: 177
    ]]
    a1.MessageModeConnection:disconnect()
    a1.Destroyed = true
end
function tbl_upv_2.new(a1, a2, a3, a4)
    --[[
      name: new
      line: 182
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local u1 = setmetatable({}, tbl_upv_1)
    u1.Destroyed = false
    u1.ChatWindow = a1
    u1.ChatBar = a2
    u1.ChatSettings = a3
    u1.TextBox = a2:GetTextBox()
    u1.MessageModeButton = a2:GetMessageModeTextButton()
    u1.OriginalWhisperText = ""
    u1.PlayerNameEntered = false
    u1.MessageModeConnection = u1.MessageModeButton.MouseButton1Click:connect(
        function()
            --[[
              line: 193
              upvalues:
                u1 (copy, index: 1)
            ]]
            local Text_2 = u1.TextBox.Text
            if string.sub(Text_2, 1, 1) == " " then
                Text_2 = string.sub(Text_2, 2)
            end
            u1.ChatBar:ResetCustomState()
            u1.ChatBar:SetTextBoxText(Text_2)
            u1.ChatBar:CaptureFocus()
        end
    )
    if a4 then
        u1:EnterWhisperState(a4)
    else
        u1:TextUpdated()
    end
    return u1
end
function ProcessMessage(a1, a2, a3, a4)
    --[[
      name: ProcessMessage
      line: 212
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if string.sub(a1, 1, 3):lower() ~= "/w " and string.sub(a1, 1, 9):lower() ~= "/whisper " then
        return nil
    end
    return tbl_upv_2.new(a2, a3, a4)
end
function CreateCustomState(a1, a2, a3, a4)
    --[[
      name: CreateCustomState
      line: 219
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2.new(a2, a3, a4, a1)
end
local tbl_5 = {}
tbl_5[Util_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_1.IN_PROGRESS_MESSAGE_PROCESSOR
tbl_5[Util_1.KEY_PROCESSOR_FUNCTION] = ProcessMessage
tbl_5.CustomStateCreator = CreateCustomState
return tbl_5