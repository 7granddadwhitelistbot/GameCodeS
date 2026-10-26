local Players_upv_1 = game:GetService("Players")
local tbl_upv_1 = {"/team ", "/t ", "% "}
function IsTeamCommand(a1)
    --[[
      name: IsTeamCommand
      line: 10
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    for n_1 = 1, #tbl_upv_1 do
        local v1 = tbl_upv_1[n_1]
        if string.sub(a1, 1, v1:len()):lower() ~= v1 then
            continue
        end
        return true
    end
    return false
end
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
local Util_1 = require(script.Parent:WaitForChild("Util"))
local tbl_upv_3 = {}
function tbl_upv_2.EnterTeamChat(a1)
    --[[
      name: EnterTeamChat
      line: 27
    ]]
    a1.TeamChatEntered = true
    a1.MessageModeButton.Size = UDim2.new(0, 1000, 1, 0)
    a1.MessageModeButton.Text = "[Team]"
    a1.MessageModeButton.TextColor3 = a1:GetTeamChatColor()
    local X_1 = a1.MessageModeButton.TextBounds.X
    a1.MessageModeButton.Size = UDim2.new(0, X_1, 1, 0)
    a1.TextBox.Size = UDim2.new(1, -X_1, 1, 0)
    a1.TextBox.Position = UDim2.new(0, X_1, 0, 0)
    a1.OriginalTeamText = a1.TextBox.Text
    a1.TextBox.Text = " "
end
function tbl_upv_2.TextUpdated(a1)
    --[[
      name: TextUpdated
      line: 41
    ]]
    local Text_1 = a1.TextBox.Text
    if a1.TeamChatEntered then
        if Text_1 ~= "" then
            return
        end
        a1.MessageModeButton.Text = ""
        a1.MessageModeButton.Size = UDim2.new(0, 0, 0, 0)
        a1.TextBox.Size = UDim2.new(1, 0, 1, 0)
        a1.TextBox.Position = UDim2.new(0, 0, 0, 0)
        a1.TextBox.Text = ""
        a1.TeamChatEntered = false
        a1.ChatBar:ResetCustomState()
        a1.ChatBar:CaptureFocus()
    elseif IsTeamCommand(Text_1) then
        a1:EnterTeamChat()
    end
end
function tbl_upv_2.GetMessage(a1)
    --[[
      name: GetMessage
      line: 64
    ]]
    if a1.TeamChatEntered then
        return "/t " .. a1.TextBox.Text
    end
    return a1.TextBox.Text
end
function tbl_upv_2.ProcessCompletedMessage(a1)
    --[[
      name: ProcessCompletedMessage
      line: 71
    ]]
    return false
end
function tbl_upv_2.Destroy(a1)
    --[[
      name: Destroy
      line: 75
    ]]
    a1.MessageModeConnection:disconnect()
    a1.Destroyed = true
end
function tbl_upv_2.GetTeamChatColor(a1)
    --[[
      name: GetTeamChatColor
      line: 80
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    if LocalPlayer_1.Team then
        return LocalPlayer_1.Team.TeamColor.Color
    elseif a1.ChatSettings.DefaultChannelNameColor then
        return a1.ChatSettings.DefaultChannelNameColor
    else
        return Color3.fromRGB(35, 76, 142)
    end
end
function tbl_upv_3.new(a1, a2, a3)
    --[[
      name: new
      line: 91
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local u1 = setmetatable({}, tbl_upv_2)
    u1.Destroyed = false
    u1.ChatWindow = a1
    u1.ChatBar = a2
    u1.ChatSettings = a3
    u1.TextBox = a2:GetTextBox()
    u1.MessageModeButton = a2:GetMessageModeTextButton()
    u1.OriginalTeamText = ""
    u1.TeamChatEntered = false
    u1.MessageModeConnection = u1.MessageModeButton.MouseButton1Click:connect(
        function()
            --[[
              line: 102
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
    u1:EnterTeamChat()
    return u1
end
function ProcessMessage(a1, a2, a3, a4)
    --[[
      name: ProcessMessage
      line: 117
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    if a3.TargetChannel ~= "Team" then
        if IsTeamCommand(a1) then
            return tbl_upv_3.new(a2, a3, a4)
        end
        return nil
    end
end
local tbl_4 = {}
tbl_4[Util_1.KEY_COMMAND_PROCESSOR_TYPE] = Util_1.IN_PROGRESS_MESSAGE_PROCESSOR
tbl_4[Util_1.KEY_PROCESSOR_FUNCTION] = ProcessMessage
return tbl_4