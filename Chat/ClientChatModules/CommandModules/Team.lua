local players = game:GetService("Players")
local texts = {"/team ", "/t ", "% "}

function IsTeamCommand(text)
    --[[
      name: IsTeamCommand
      line: 10
      upvalues:
        texts (copy, index: 1)
    ]]
    for index = 1, #texts do
        local text2 = texts[index]

        if string.sub(text, 1, text2:len()):lower() == text2 then
            return true
        end
    end

    return false
end

local Class = {}
Class.__index = Class
local Util = require(script.Parent:WaitForChild("Util"))
local v8 = {}

function Class.EnterTeamChat(self)
    --[[
      name: EnterTeamChat
      line: 27
    ]]
    self.TeamChatEntered = true
    self.MessageModeButton.Size = UDim2.new(0, 1000, 1, 0)
    self.MessageModeButton.Text = "[Team]"
    self.MessageModeButton.TextColor3 = self:GetTeamChatColor()
    local x = self.MessageModeButton.TextBounds.X
    self.MessageModeButton.Size = UDim2.new(0, x, 1, 0)
    self.TextBox.Size = UDim2.new(1, -x, 1, 0)
    self.TextBox.Position = UDim2.new(0, x, 0, 0)
    self.OriginalTeamText = self.TextBox.Text
    self.TextBox.Text = " "
end

function Class.TextUpdated(self)
    --[[
      name: TextUpdated
      line: 41
    ]]
    local text = self.TextBox.Text

    if self.TeamChatEntered then
        if text == "" then
            self.MessageModeButton.Text = ""
            self.MessageModeButton.Size = UDim2.new(0, 0, 0, 0)
            self.TextBox.Size = UDim2.new(1, 0, 1, 0)
            self.TextBox.Position = UDim2.new(0, 0, 0, 0)
            self.TextBox.Text = ""
            self.TeamChatEntered = false
            self.ChatBar:ResetCustomState()
            self.ChatBar:CaptureFocus()
        end
    elseif IsTeamCommand(text) then
        self:EnterTeamChat()
    end
end

function Class.GetMessage(self)
    --[[
      name: GetMessage
      line: 64
    ]]
    if self.TeamChatEntered then
        return "/t " .. self.TextBox.Text
    end

    return self.TextBox.Text
end

function Class.ProcessCompletedMessage(a14)
    --[[
      name: ProcessCompletedMessage
      line: 71
    ]]
    return false
end

function Class.Destroy(self)
    --[[
      name: Destroy
      line: 75
    ]]
    self.MessageModeConnection:disconnect()
    self.Destroyed = true
end

function Class.GetTeamChatColor(self)
    --[[
      name: GetTeamChatColor
      line: 80
      upvalues:
        players (copy, index: 1)
    ]]
    local localPlayer = players.LocalPlayer

    if localPlayer.Team then
        return localPlayer.Team.TeamColor.Color
    end
    if self.ChatSettings.DefaultChannelNameColor then
        return self.ChatSettings.DefaultChannelNameColor
    end

    return Color3.fromRGB(35, 76, 142)
end

function v8.new(chatWindow, chatBar, chatSettings)
    --[[
      name: new
      line: 91
      upvalues:
        Class (copy, index: 1)
    ]]
    local v21 = setmetatable({}, Class)
    v21.Destroyed = false
    v21.ChatWindow = chatWindow
    v21.ChatBar = chatBar
    v21.ChatSettings = chatSettings
    v21.TextBox = chatBar:GetTextBox()
    v21.MessageModeButton = chatBar:GetMessageModeTextButton()
    v21.OriginalTeamText = ""
    v21.TeamChatEntered = false

    v21.MessageModeConnection = v21.MessageModeButton.MouseButton1Click:connect(
        function()
            --[[
              line: 102
              upvalues:
                v21 (copy, index: 1)
            ]]
            local v22 = v21.TextBox.Text

            if string.sub(v22, 1, 1) == " " then
                v22 = string.sub(v22, 2)
            end

            v21.ChatBar:ResetCustomState()
            v21.ChatBar:SetTextBoxText(v22)
            v21.ChatBar:CaptureFocus()
        end
    )

    v21:EnterTeamChat()

    return v21
end

function ProcessMessage(a23: string, chatWindow, chatBar, chatSettings)
    --[[
      name: ProcessMessage
      line: 117
      upvalues:
        v8 (copy, index: 1)
    ]]
    if chatBar.TargetChannel == "Team" then
        return
    end
    if IsTeamCommand(a23) then
        return v8.new(chatWindow, chatBar, chatSettings)
    end

    return nil
end

local v27 = {}
v27[Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.IN_PROGRESS_MESSAGE_PROCESSOR
v27[Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage

return v27