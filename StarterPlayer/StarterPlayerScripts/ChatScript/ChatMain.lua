local tbl_upv_1 = {}
tbl_upv_1.Visible = nil
tbl_upv_1.IsCoreGuiEnabled = nil
tbl_upv_1.TopbarEnabled = nil
tbl_upv_1.VisibilityStateChanged = nil
local success_1, v1 = pcall(
    function()
        --[[
          line: 32
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local u1 = success_1 and v1
local success_2, v2 = pcall(
    function()
        --[[
          line: 39
        ]]
        return UserSettings():IsUserFeatureEnabled("UserAddBetterConsoleCheckForLegacyChat")
    end
)
local _ = game:GetService("RunService")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Chat_upv_1 = game:GetService("Chat")
local StarterGui_upv_1 = game:GetService("StarterGui")
local v45 = game:GetService("ContextActionService")
local DefaultChatSystemChatEvents_upv_1 = ReplicatedStorage_1:WaitForChild("DefaultChatSystemChatEvents")
local DefaultChatSystemChatEvents_2 = ReplicatedStorage_1:WaitForChild("DefaultChatSystemChatEvents")
local ClientChatModules_1 = Chat_upv_1:WaitForChild("ClientChatModules")
local ChatConstants_upv_1 = require(ClientChatModules_1:WaitForChild("ChatConstants"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
local Util_1 = require(ClientChatModules_1:WaitForChild("MessageCreatorModules"):WaitForChild("Util"))
local u2 = nil
pcall(
    function()
        --[[
          line: 63
          upvalues:
            u2 (ref, index: 1)
        ]]
        u2 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)
if u2 == nil then
    u2 = {}
    function u2.Get(a1, a2, a3)
        --[[
          name: Get
          line: 64
        ]]
        return a3
    end
end
local u3 = nil
if u1 then
    local ChatTranslationEnabled_1 = script:FindFirstChild("ChatTranslationEnabled")
    local u4 = ChatTranslationEnabled_1
    if u4 == nil then
        local u5 = nil
        local v3 = script.ChildAdded:Connect(
            function(a1)
                --[[
                  line: 71
                  upvalues:
                    u4 (ref, index: 1)
                    u5 (ref, index: 2)
                ]]
                if a1.Name ~= "ChatTranslationEnabled" then
                    return
                end
                u4 = a1
                u5:Disconnect()
            end
        )
        u5 = v3
    end
end
local u6 = 10
local tbl_upv_2 = {OnMessageDoneFiltering = "RemoteEvent", OnChannelJoined = "RemoteEvent", OnNewSystemMessage = "RemoteEvent", SayMessageRequest = "RemoteEvent", OnNewMessage = "RemoteEvent", OnChannelLeft = "RemoteEvent", OnMuted = "RemoteEvent", GetInitDataRequest = "RemoteFunction", OnMainChannelSet = "RemoteEvent", OnUnmuted = "RemoteEvent"}
local tbl_upv_3 = {}
local u7 = Instance.new("BindableEvent")
function TryRemoveChildWithVerifyingIsCorrectType(a1)
    --[[
      name: TryRemoveChildWithVerifyingIsCorrectType
      line: 104
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        u6 (ref,  index: 3)
    ]]
    if not tbl_upv_2[a1.Name] or not a1:IsA(tbl_upv_2[a1.Name]) then
        return
    end
    tbl_upv_2[a1.Name] = nil
    tbl_upv_3[a1.Name] = a1
    u6 = u6 - 1
end
for u8, value_1 in pairs(DefaultChatSystemChatEvents_2:GetChildren()) do
    TryRemoveChildWithVerifyingIsCorrectType(value_1)
end
if u6 > 0 then
    local v4 = DefaultChatSystemChatEvents_2.ChildAdded:connect(
        function(a1)
            --[[
              line: 117
              upvalues:
                u6 (ref,  index: 1)
                u7 (copy, index: 2)
            ]]
            TryRemoveChildWithVerifyingIsCorrectType(a1)
            if not (u6 < 1) then
                return
            end
            u7:Fire()
        end
    )
    u7.Event:wait()
    v4:disconnect()
    u7:Destroy()
end
local UserInputService_upv_1 = game:GetService("UserInputService")
local RunService_upv_1 = game:GetService("RunService")
local Players_upv_1 = game:GetService("Players")
local u8 = Players_upv_1.LocalPlayer
while not (u8) do
    Players_upv_1.ChildAdded:wait()
    u8 = Players_upv_1.LocalPlayer
end
local u9 = true
local u10 = 6
if ChatSettings_upv_1.ScreenGuiDisplayOrder ~= nil then
    u10 = ChatSettings_upv_1.ScreenGuiDisplayOrder
end
local PlayerGui_1 = u8:WaitForChild("PlayerGui")
local u11 = Instance.new("ScreenGui")
u11.Name = "Chat"
u11.ResetOnSpawn = false
u11.DisplayOrder = u10
u11.Parent = PlayerGui_1
if success_2 and v2 and game:GetService("GuiService"):IsTenFootInterface() then
    u11.Enabled = false
end
local u12 = false
local script_upv_1 = script
u10 = require(script_upv_1:WaitForChild("ChatWindow"))
local ChatBar_1 = require(script_upv_1:WaitForChild("ChatBar"))
local ChannelsBar_1 = require(script_upv_1:WaitForChild("ChannelsBar"))
local v46 = require(script_upv_1:WaitForChild("MessageLabelCreator"))
local MessageLogDisplay_upv_1 = require(script_upv_1:WaitForChild("MessageLogDisplay"))
local v47 = require(script_upv_1:WaitForChild("ChatChannel"))
local CommandProcessor_1 = require(script_upv_1:WaitForChild("CommandProcessor"))
local u13 = u10.new()
u10 = ChannelsBar_1.new()
local u14 = MessageLogDisplay_upv_1.new()
local u15 = CommandProcessor_1.new()
local u16 = ChatBar_1.new(u15, u13)
u13:CreateGuiObjects(u11)
u13:RegisterChatBar(u16)
u13:RegisterChannelsBar(u10)
u13:RegisterMessageLogDisplay(u14)
Util_1:RegisterChatWindow(u13)
local MessageSender_upv_1 = require(script_upv_1:WaitForChild("MessageSender"))
MessageSender_upv_1:RegisterSayMessageFunction(tbl_upv_3.SayMessageRequest)
if UserInputService_upv_1.TouchEnabled then
    u16:SetTextLabelText(u2:Get("GameChat_ChatMain_ChatBarTextTouch", "Tap here to chat"))
else
    u16:SetTextLabelText(u2:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"))
end
spawn(
    function()
        --[[
          line: 204
          upvalues:
            script_upv_1 (copy, index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u13 (copy, index: 3)
        ]]
        local CurveUtil_1 = require(script_upv_1:WaitForChild("CurveUtil"))
        local v5 = tick()
        local time_1 = tick()
        local v6 = CurveUtil_1:DeltaTimeToTimescale(time_1 - v5)
        if v6 ~= 0 then
            u13:Update(v6)
        end
        wait(1 / (ChatSettings_upv_1.ChatAnimationFPS or 20))
        v5 = time_1
    end
)
function CheckIfPointIsInSquare(a1, a2, a3)
    --[[
      name: CheckIfPointIsInSquare
      line: 230
    ]]
    return (a2.X <= a1.X) and ((a1.X <= a3.X) and ((a2.Y <= a1.Y) and (a1.Y <= a3.Y)))
end
local u17 = false
local u18 = false
local u19 = 0
local u20 = 0
local u21 = Instance.new("BindableEvent")
local u22 = Instance.new("BindableEvent")
local u23 = Instance.new("BindableEvent")
function DoBackgroundFadeIn(a1)
    --[[
      name: DoBackgroundFadeIn
      line: 244
      upvalues:
        u20 (ref,  index: 1)
        u17 (ref,  index: 2)
        u21 (copy, index: 3)
        u13 (copy, index: 4)
        ChatSettings_upv_1 (copy, index: 5)
        u14 (copy, index: 6)
        MessageLogDisplay_upv_1 (copy, index: 7)
    ]]
    u20 = tick()
    u17 = false
    u21:Fire()
    u13:FadeInBackground(a1 or (ChatSettings_upv_1.ChatDefaultFadeDuration))
    if u13:GetCurrentChannel() then
        local Scroller_1 = u14.Scroller
        Scroller_1.ScrollingEnabled = true
        Scroller_1.ScrollBarThickness = MessageLogDisplay_upv_1.ScrollBarThickness
    end
end
function DoBackgroundFadeOut(a1)
    --[[
      name: DoBackgroundFadeOut
      line: 259
      upvalues:
        u20 (ref,  index: 1)
        u17 (ref,  index: 2)
        u21 (copy, index: 3)
        u13 (copy, index: 4)
        ChatSettings_upv_1 (copy, index: 5)
        u14 (copy, index: 6)
    ]]
    u20 = tick()
    u17 = true
    u21:Fire()
    u13:FadeOutBackground(a1 or (ChatSettings_upv_1.ChatDefaultFadeDuration))
    if u13:GetCurrentChannel() then
        local Scroller_2 = u14.Scroller
        Scroller_2.ScrollingEnabled = false
        Scroller_2.ScrollBarThickness = 0
    end
end
function DoTextFadeIn(a1)
    --[[
      name: DoTextFadeIn
      line: 274
      upvalues:
        u19 (ref,  index: 1)
        u18 (ref,  index: 2)
        u21 (copy, index: 3)
        u13 (copy, index: 4)
        ChatSettings_upv_1 (copy, index: 5)
    ]]
    u19 = tick()
    u18 = false
    u21:Fire()
    u13:FadeInText((a1 or (ChatSettings_upv_1.ChatDefaultFadeDuration)) * 0)
end
function DoTextFadeOut(a1)
    --[[
      name: DoTextFadeOut
      line: 281
      upvalues:
        u19 (ref,  index: 1)
        u18 (ref,  index: 2)
        u21 (copy, index: 3)
        u13 (copy, index: 4)
        ChatSettings_upv_1 (copy, index: 5)
    ]]
    u19 = tick()
    u18 = true
    u21:Fire()
    u13:FadeOutText(a1 or (ChatSettings_upv_1.ChatDefaultFadeDuration))
end
function DoFadeInFromNewInformation()
    --[[
      name: DoFadeInFromNewInformation
      line: 288
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    DoTextFadeIn()
    if not ChatSettings_upv_1.ChatShouldFadeInFromNewInformation then
        return
    end
    DoBackgroundFadeIn()
end
function InstantFadeIn()
    --[[
      name: InstantFadeIn
      line: 295
    ]]
    DoBackgroundFadeIn(0)
    DoTextFadeIn(0)
end
function InstantFadeOut()
    --[[
      name: InstantFadeOut
      line: 300
    ]]
    DoBackgroundFadeOut(0)
    DoTextFadeOut(0)
end
local u24 = nil
function UpdateFadingForMouseState(a1)
    --[[
      name: UpdateFadingForMouseState
      line: 306
      upvalues:
        u24 (ref,  index: 1)
        u22 (copy, index: 2)
        u16 (copy, index: 3)
    ]]
    u24 = a1
    u22:Fire()
    if u16:IsFocused() then
        return
    end
    if a1 then
        DoBackgroundFadeIn()
        DoTextFadeIn()
    else
        DoBackgroundFadeIn()
    end
end
spawn(
    function()
        --[[
          line: 322
          upvalues:
            RunService_upv_1 (copy, index: 1)
            u24 (ref,  index: 2)
            u16 (copy, index: 3)
            u22 (copy, index: 4)
            u23 (copy, index: 5)
            u17 (ref,  index: 6)
            u20 (ref,  index: 7)
            ChatSettings_upv_1 (copy, index: 8)
            u18 (ref,  index: 9)
            u19 (ref,  index: 10)
            u21 (copy, index: 11)
        ]]
        RunService_upv_1.RenderStepped:wait()
        while true do
            if not u24 and not (u16:IsFocused()) then
                break
            end
            if u24 then
                u22.Event:wait()
            end
            if u16:IsFocused() then
                u23.Event:wait()
            end
        end
        if u17 then
            if u18 then
                u21.Event:wait()
            elseif (ChatSettings_upv_1.ChatWindowTextFadeOutTime < tick() - u19) then
                DoTextFadeOut()
            end
        elseif (ChatSettings_upv_1.ChatWindowBackgroundFadeOutTime < tick() - u20) then
            DoBackgroundFadeOut()
        end
    end
)
function getClassicChatEnabled()
    --[[
      name: getClassicChatEnabled
      line: 355
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if ChatSettings_upv_1.ClassicChatEnabled == nil then
        return Players_upv_1.ClassicChat
    end
    return ChatSettings_upv_1.ClassicChatEnabled
end
function getBubbleChatEnabled()
    --[[
      name: getBubbleChatEnabled
      line: 362
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if ChatSettings_upv_1.BubbleChatEnabled == nil then
        return Players_upv_1.BubbleChat
    end
    return ChatSettings_upv_1.BubbleChatEnabled
end
function bubbleChatOnly()
    --[[
      name: bubbleChatOnly
      line: 369
    ]]
    local v7 = not getClassicChatEnabled() and (getBubbleChatEnabled())
    return v7
end
function UpdateMousePosition(a1)
    --[[
      name: UpdateMousePosition
      line: 373
      upvalues:
        tbl_upv_1 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
        u13 (copy, index: 3)
        u24 (ref,  index: 4)
    ]]
    if not tbl_upv_1.Visible then
        return
    end
    if tbl_upv_1.IsCoreGuiEnabled and ((tbl_upv_1.TopbarEnabled) or (ChatSettings_upv_1.ChatOnWithTopBarOff)) and not bubbleChatOnly() then
        local AbsolutePosition_1 = u13.GuiObject.AbsolutePosition
        local v8 = CheckIfPointIsInSquare(a1, AbsolutePosition_1, AbsolutePosition_1 + u13.GuiObject.AbsoluteSize)
        if v8 ~= u24 then
            UpdateFadingForMouseState(v8)
        end
    end
end
UserInputService_upv_1.InputChanged:connect(
    function(a1, a2)
        --[[
          line: 390
        ]]
        if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end
        UpdateMousePosition((Vector2.new(a1.Position.X, a1.Position.Y)))
    end
)
UserInputService_upv_1.TouchTap:connect(
    function(a1, a2)
        --[[
          line: 397
        ]]
        UpdateMousePosition(a1[1])
    end
)
UserInputService_upv_1.TouchMoved:connect(
    function(a1, a2)
        --[[
          line: 401
        ]]
        UpdateMousePosition((Vector2.new(a1.Position.X, a1.Position.Y)))
    end
)
UserInputService_upv_1.Changed:connect(
    function(a1)
        --[[
          line: 406
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
            u13 (copy, index: 2)
            u11 (copy, index: 3)
        ]]
        if a1 ~= "MouseBehavior" then
            return
        end
        if UserInputService_upv_1.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local AbsolutePosition_2 = u13.GuiObject.AbsolutePosition
            if not CheckIfPointIsInSquare(u11.AbsoluteSize / 2, AbsolutePosition_2, AbsolutePosition_2 + u13.GuiObject.AbsoluteSize) then
                return
            end
            UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.Default
        end
    end
)
UpdateFadingForMouseState(true)
UpdateFadingForMouseState(false)
local tbl_4 = {}
function tbl_4.Signal()
    --[[
      name: Signal
      line: 431
    ]]
    local tbl_5 = {}
    local u25 = Instance.new("BindableEvent")
    local tbl_upv_6 = nil
    local u26 = nil
    function tbl_5.fire(a1, ...)
        --[[
          name: fire
          line: 439
          upvalues:
            tbl_upv_6 (ref,  index: 1)
            u26 (ref,  index: 2)
            u25 (copy, index: 3)
        ]]
        tbl_upv_6 = {...}
        local v9 = select("#", ...)
        u26 = v9
        u25:Fire()
    end
    function tbl_5.connect(a2, a3)
        --[[
          name: connect
          line: 445
          upvalues:
            u25 (copy, index: 1)
            tbl_upv_6 (ref,  index: 2)
            u26 (ref,  index: 3)
        ]]
        if not (a3) then
            error("connect(nil)", 2)
        end
        return u25.Event:connect(
            function()
                --[[
                  line: 447
                  upvalues:
                    a3 (copy, index: 1)
                    tbl_upv_6 (ref,  index: 2)
                    u26 (ref,  index: 3)
                ]]
                a3(unpack(tbl_upv_6, 1, u26))
            end
        )
    end
    function tbl_5.wait(a4)
        --[[
          name: wait
          line: 452
          upvalues:
            u25 (copy, index: 1)
            tbl_upv_6 (ref,  index: 2)
            u26 (ref,  index: 3)
        ]]
        u25.Event:wait()
        assert(tbl_upv_6, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        return unpack(tbl_upv_6, 1, u26)
    end
    return tbl_5
end
function SetVisibility(a1)
    --[[
      name: SetVisibility
      line: 463
      upvalues:
        u13 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    u13:SetVisible(a1)
    tbl_upv_1.VisibilityStateChanged:fire(a1)
    tbl_upv_1.Visible = a1
    if not tbl_upv_1.IsCoreGuiEnabled then
        return
    end
    if a1 then
        InstantFadeIn()
    else
        InstantFadeOut()
    end
end
local DoChatBarFocus = nil
tbl_upv_1.TopbarEnabled = true
tbl_upv_1.MessageCount = 0
tbl_upv_1.Visible = true
tbl_upv_1.IsCoreGuiEnabled = true
function tbl_upv_1.ToggleVisibility(a1)
    --[[
      name: ToggleVisibility
      line: 485
      upvalues:
        u13 (copy, index: 1)
    ]]
    SetVisibility(not u13:GetVisible())
end
function tbl_upv_1.SetVisible(a1, a2)
    --[[
      name: SetVisible
      line: 489
      upvalues:
        u13 (copy, index: 1)
    ]]
    if u13:GetVisible() == a2 then
        return
    end
    SetVisibility(a2)
end
function tbl_upv_1.FocusChatBar(a1)
    --[[
      name: FocusChatBar
      line: 495
      upvalues:
        u16 (copy, index: 1)
    ]]
    u16:CaptureFocus()
end
function tbl_upv_1.EnterWhisperState(a1, a2)
    --[[
      name: EnterWhisperState
      line: 499
      upvalues:
        u16 (copy, index: 1)
    ]]
    u16:EnterWhisperState(a2)
end
function tbl_upv_1.GetVisibility(a1)
    --[[
      name: GetVisibility
      line: 503
      upvalues:
        u13 (copy, index: 1)
    ]]
    return u13:GetVisible()
end
function tbl_upv_1.GetMessageCount(a1)
    --[[
      name: GetMessageCount
      line: 507
    ]]
    return a1.MessageCount
end
function tbl_upv_1.TopbarEnabledChanged(a1, a2)
    --[[
      name: TopbarEnabledChanged
      line: 511
    ]]
    a1.TopbarEnabled = a2
    a1.CoreGuiEnabled:fire(game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat))
end
function tbl_upv_1.IsFocused(a1, a2)
    --[[
      name: IsFocused
      line: 516
      upvalues:
        u16 (copy, index: 1)
    ]]
    return u16:IsFocused()
end
tbl_upv_1.ChatBarFocusChanged = tbl_4.Signal()
tbl_upv_1.VisibilityStateChanged = tbl_4.Signal()
tbl_upv_1.MessagesChanged = tbl_4.Signal()
tbl_upv_1.MessagePosted = tbl_4.Signal()
tbl_upv_1.CoreGuiEnabled = tbl_4.Signal()
tbl_upv_1.ChatMakeSystemMessageEvent = tbl_4.Signal()
tbl_upv_1.ChatWindowPositionEvent = tbl_4.Signal()
tbl_upv_1.ChatWindowSizeEvent = tbl_4.Signal()
tbl_upv_1.ChatBarDisabledEvent = tbl_4.Signal()
function tbl_upv_1.fChatWindowPosition(a1)
    --[[
      name: fChatWindowPosition
      line: 534
      upvalues:
        u13 (copy, index: 1)
    ]]
    return u13.GuiObject.Position
end
function tbl_upv_1.fChatWindowSize(a1)
    --[[
      name: fChatWindowSize
      line: 538
      upvalues:
        u13 (copy, index: 1)
    ]]
    return u13.GuiObject.Size
end
function tbl_upv_1.fChatBarDisabled(a1)
    --[[
      name: fChatBarDisabled
      line: 542
      upvalues:
        u16 (copy, index: 1)
    ]]
    return not u16:GetEnabled()
end
function tbl_upv_1.SpecialKeyPressed(a1, a2, a3)
    --[[
      name: SpecialKeyPressed
      line: 546
      upvalues:
        u9 (ref, index: 1)
        DoChatBarFocus (ref, index: 2)
    ]]
    if a2 ~= Enum.SpecialKey.ChatHotkey or not u9 then
        return
    end
    DoChatBarFocus()
end
tbl_upv_1.CoreGuiEnabled:connect(
    function(a1)
        --[[
          line: 555
          upvalues:
            tbl_upv_1 (copy, index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u13 (copy, index: 3)
            u16 (copy, index: 4)
        ]]
        tbl_upv_1.IsCoreGuiEnabled = a1
        a1 = a1 and (tbl_upv_1.TopbarEnabled or (ChatSettings_upv_1.ChatOnWithTopBarOff))
        u13:SetCoreGuiEnabled(a1)
        if a1 then
            InstantFadeIn()
        else
            u16:ReleaseFocus()
            InstantFadeOut()
        end
    end
)
function trimTrailingSpaces(a1)
    --[[
      name: trimTrailingSpaces
      line: 570
    ]]
    local v10 = #a1
    while v10 > 0 do
        local v11 = a1:find("^%s", v10)
        if v11 then
            v10 = v10 - 1
            continue
        else
            break
        end
    end
    return a1:sub(1, v10)
end
tbl_upv_1.ChatMakeSystemMessageEvent:connect(
    function(a1)
        --[[
          line: 583
          upvalues:
            u12 (ref,  index: 1)
            ChatSettings_upv_1 (copy, index: 2)
            u13 (copy, index: 3)
            ChatConstants_upv_1 (copy, index: 4)
            u10 (copy, index: 5)
            tbl_upv_1 (copy, index: 6)
        ]]
        if not a1.Text then
            return
        end
        if type(a1.Text) == "string" then
            while not (u12) do
                wait()
            end
            local GeneralChannelName_1 = ChatSettings_upv_1.GeneralChannelName
            local v12 = u13:GetChannel(GeneralChannelName_1)
            if not v12 then
                return
            end
            v12:AddMessageToChannel({SpeakerUserId = 0, ID = -1, IsFiltered = true, OriginalChannel = GeneralChannelName_1, MessageLength = string.len(a1.Text), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(a1.Text)), Message = trimTrailingSpaces(a1.Text), MessageType = ChatConstants_upv_1.MessageTypeSetCore, Time = os.time(), ExtraData = a1})
            u10:UpdateMessagePostedInChannel(GeneralChannelName_1)
            tbl_upv_1.MessageCount = tbl_upv_1.MessageCount + 1
            tbl_upv_1.MessagesChanged:fire(tbl_upv_1.MessageCount)
        end
    end
)
tbl_upv_1.ChatBarDisabledEvent:connect(
    function(a1)
        --[[
          line: 613
          upvalues:
            u9 (ref,  index: 1)
            u16 (copy, index: 2)
        ]]
        if not u9 then
            return
        end
        u16:SetEnabled(not a1)
        if not a1 then
            return
        end
        u16:ReleaseFocus()
    end
)
tbl_upv_1.ChatWindowSizeEvent:connect(
    function(a1)
        --[[
          line: 622
          upvalues:
            u13 (copy, index: 1)
        ]]
        u13.GuiObject.Size = a1
    end
)
tbl_upv_1.ChatWindowPositionEvent:connect(
    function(a1)
        --[[
          line: 626
          upvalues:
            u13 (copy, index: 1)
        ]]
        u13.GuiObject.Position = a1
    end
)
DoChatBarFocus = function()
    --[[
      name: DoChatBarFocus
      line: 634
      upvalues:
        u13 (copy, index: 1)
        u16 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not u13:GetCoreGuiEnabled() or not u16:GetEnabled() then
        return
    end
    if not (u16:IsFocused()) and u16:GetVisible() then
        tbl_upv_1:SetVisible(true)
        InstantFadeIn()
        u16:CaptureFocus()
        tbl_upv_1.ChatBarFocusChanged:fire(true)
    end
end
u23.Event:connect(
    function(a1)
        --[[
          line: 646
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        tbl_upv_1.ChatBarFocusChanged:fire(a1)
    end
)
function DoSwitchCurrentChannel(a1)
    --[[
      name: DoSwitchCurrentChannel
      line: 650
      upvalues:
        u13 (copy, index: 1)
    ]]
    if not u13:GetChannel(a1) then
        return
    end
    u13:SwitchCurrentChannel(a1)
end
function SendMessageToSelfInTargetChannel(a1, a2, a3)
    --[[
      name: SendMessageToSelfInTargetChannel
      line: 656
      upvalues:
        u13 (copy, index: 1)
        ChatConstants_upv_1 (copy, index: 2)
    ]]
    local v13 = u13:GetChannel(a2)
    if not v13 then
        return
    end
    v13:AddMessageToChannel({SpeakerUserId = 0, ID = -1, IsFiltered = true, OriginalChannel = a2, MessageLength = string.len(a1), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(a1)), Message = trimTrailingSpaces(a1), MessageType = ChatConstants_upv_1.MessageTypeSystem, Time = os.time(), ExtraData = a3})
end
function chatBarFocused()
    --[[
      name: chatBarFocused
      line: 677
      upvalues:
        u24 (ref,  index: 1)
        u18 (ref,  index: 2)
        u23 (copy, index: 3)
    ]]
    if not (u24) then
        DoBackgroundFadeIn()
        if u18 then
            DoTextFadeIn()
        end
    end
    u23:Fire(true)
end
function chatBarFocusLost(a1, a2)
    --[[
      name: chatBarFocusLost
      line: 689
      upvalues:
        u23 (copy, index: 1)
        u16 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        u15 (copy, index: 4)
        u13 (copy, index: 5)
        ChatSettings_upv_1 (copy, index: 6)
        MessageSender_upv_1 (copy, index: 7)
    ]]
    DoBackgroundFadeIn()
    u23:Fire(false)
    if not a1 then
        return
    end
    local v14 = u16:GetTextBox().Text
    local v15 = u16:IsInCustomState()
    local v16 = nil
    if v15 then
        v16 = u16:GetCustomMessage()
        if v16 then
            v14 = v16
        end
        local v17 = u16:CustomStateProcessCompletedMessage(v14)
        u16:ResetCustomState()
        if v17 then
            return
        end
    end
    u16:GetTextBox().Text = ""
    if v14 == "" then
        return
    end
    tbl_upv_1.MessagePosted:fire(v14)
    if u15:ProcessCompletedChatMessage(v14, u13) then
        return
    end
    if ChatSettings_upv_1.DisallowedWhiteSpace then
        for n_1 = 1, #ChatSettings_upv_1.DisallowedWhiteSpace do
            if ChatSettings_upv_1.DisallowedWhiteSpace[n_1] ~= "\t" then
                v14 = string.gsub(v14, ChatSettings_upv_1.DisallowedWhiteSpace[n_1], "")
            else
                v14 = string.gsub(v14, ChatSettings_upv_1.DisallowedWhiteSpace[n_1], " ")
            end
        end
    end
    local v18 = string.gsub(string.gsub(v14, "\n", ""), "[ ]+", " ")
    local v19 = u13:GetTargetMessageChannel()
    if v19 then
        MessageSender_upv_1:SendMessage(v18, v19)
    else
        MessageSender_upv_1:SendMessage(v18, nil)
    end
end
local tbl_upv_7 = {}
function setupChatBarConnections()
    --[[
      name: setupChatBarConnections
      line: 740
      upvalues:
        tbl_upv_7 (ref,  index: 1)
        u16 (copy, index: 2)
    ]]
    for n_2 = 1, #tbl_upv_7 do
        tbl_upv_7[n_2]:Disconnect()
    end
    tbl_upv_7 = {}
    local v20 = u16:GetTextBox().FocusLost:connect(chatBarFocusLost)
    table.insert(tbl_upv_7, v20)
    v20 = u16:GetTextBox().Focused:connect(chatBarFocused)
    table.insert(tbl_upv_7, v20)
end
setupChatBarConnections()
u16.GuiObjectsChanged:connect(setupChatBarConnections)
function getEchoMessagesInGeneral()
    --[[
      name: getEchoMessagesInGeneral
      line: 756
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if ChatSettings_upv_1.EchoMessagesInGeneralChannel ~= nil then
        return ChatSettings_upv_1.EchoMessagesInGeneralChannel
    end
    return true
end
tbl_upv_3.OnMessageDoneFiltering.OnClientEvent:connect(
    function(a1)
        --[[
          line: 763
          upvalues:
            ChatSettings_upv_1 (copy, index: 1)
            u8 (ref,  index: 2)
            u13 (copy, index: 3)
        ]]
        if not (ChatSettings_upv_1.ShowUserOwnFilteredMessage) and a1.FromSpeaker == u8.Name then
            return
        end
        local OriginalChannel_1 = a1.OriginalChannel
        local v21 = u13:GetChannel(OriginalChannel_1)
        if v21 then
            v21:UpdateMessageFiltered(a1)
        end
        if not getEchoMessagesInGeneral() then
            return
        end
        if ChatSettings_upv_1.GeneralChannelName and OriginalChannel_1 ~= ChatSettings_upv_1.GeneralChannelName then
            local v22 = u13:GetChannel(ChatSettings_upv_1.GeneralChannelName)
            if v22 then
                v22:UpdateMessageFiltered(a1)
            end
        end
    end
)
tbl_upv_3.OnNewMessage.OnClientEvent:connect(
    function(a1, a2)
        --[[
          line: 784
          upvalues:
            u13 (copy, index: 1)
            u8 (ref,  index: 2)
            u10 (copy, index: 3)
            ChatSettings_upv_1 (copy, index: 4)
            tbl_upv_1 (copy, index: 5)
        ]]
        local v23 = u13:GetChannel(a2)
        if v23 then
            v23:AddMessageToChannel(a1)
            if a1.FromSpeaker ~= u8.Name then
                u10:UpdateMessagePostedInChannel(a2)
            end
            local v24 = getEchoMessagesInGeneral()
            if v24 and ChatSettings_upv_1.GeneralChannelName then
                local v25 = nil
                if a2 ~= ChatSettings_upv_1.GeneralChannelName then
                    v25 = u13:GetChannel(ChatSettings_upv_1.GeneralChannelName)
                    if v25 then
                        v25:AddMessageToChannel(a1)
                    end
                end
            end
            tbl_upv_1.MessageCount = tbl_upv_1.MessageCount + 1
            tbl_upv_1.MessagesChanged:fire(tbl_upv_1.MessageCount)
            DoFadeInFromNewInformation()
        end
    end
)
tbl_upv_3.OnNewSystemMessage.OnClientEvent:connect(
    function(a1, a2)
        --[[
          line: 807
          upvalues:
            u13 (copy, index: 1)
            u10 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            ChatSettings_upv_1 (copy, index: 4)
        ]]
        a2 = a2 or "System"
        local v26 = u13:GetChannel(a2)
        if v26 then
            v26:AddMessageToChannel(a1)
            u10:UpdateMessagePostedInChannel(a2)
            tbl_upv_1.MessageCount = tbl_upv_1.MessageCount + 1
            tbl_upv_1.MessagesChanged:fire(tbl_upv_1.MessageCount)
            DoFadeInFromNewInformation()
            if not getEchoMessagesInGeneral() or not ChatSettings_upv_1.GeneralChannelName then
                return
            end
            if a2 ~= ChatSettings_upv_1.GeneralChannelName then
                local v27 = u13:GetChannel(ChatSettings_upv_1.GeneralChannelName)
                if not v27 then
                    return
                end
                v27:AddMessageToChannel(a1)
            end
        else
            warn(string.format("Just received system message for channel I'm not in [%s]", a2))
        end
    end
)
function HandleChannelJoined(a1, a2, a3, a4, a5, a6)
    --[[
      name: HandleChannelJoined
      line: 833
      upvalues:
        u13 (copy, index: 1)
        ChatSettings_upv_1 (copy, index: 2)
        u12 (ref,  index: 3)
        u16 (copy, index: 4)
        ChatConstants_upv_1 (copy, index: 5)
        u2 (ref,  index: 6)
        u1 (ref,  index: 7)
        u3 (ref,  index: 8)
    ]]
    if u13:GetChannel(a1) then
        u13:RemoveChannel(a1)
    end
    if a1 == ChatSettings_upv_1.GeneralChannelName then
        u12 = true
    end
    if a4 then
        u16:SetChannelNameColor(a1, a4)
    end
    local v28 = u13:AddChannel(a1)
    if v28 then
        if a1 == ChatSettings_upv_1.GeneralChannelName then
            DoSwitchCurrentChannel(a1)
        end
        if a3 then
            local v29 = ((ChatSettings_upv_1.MessageHistoryLengthPerChannel < #a3) and (#a3 - ChatSettings_upv_1.MessageHistoryLengthPerChannel)) or 1
            for n_3 = v29, #a3 do
                v28:AddMessageToChannel(a3[n_3])
            end
            if getEchoMessagesInGeneral() and a5 and ChatSettings_upv_1.GeneralChannelName and a1 ~= ChatSettings_upv_1.GeneralChannelName then
                local v30 = u13:GetChannel(ChatSettings_upv_1.GeneralChannelName)
                if v30 then
                    v30:AddMessagesToChannelByTimeStamp(a3, v29)
                end
            end
        end
        if a2 ~= "" then
            local tbl_8 = {SpeakerUserId = 0, ID = -1, IsFiltered = true}
            tbl_8.OriginalChannel = a1
            tbl_8.MessageLength = string.len(a2)
            tbl_8.MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(a2))
            tbl_8.Message = trimTrailingSpaces(a2)
            tbl_8.MessageType = ChatConstants_upv_1.MessageTypeWelcome
            tbl_8.Time = os.time()
            v28:AddMessageToChannel(tbl_8)
            if getEchoMessagesInGeneral() and a6 and not (ChatSettings_upv_1.ShowChannelsBar) and a1 ~= ChatSettings_upv_1.GeneralChannelName then
                local v31 = u13:GetChannel(ChatSettings_upv_1.GeneralChannelName)
                if v31 then
                    v31:AddMessageToChannel(tbl_8)
                end
            end
        end
        local v32 = u2:Get("GameChat_ChatMain_ChatTranslationOnboarding", "Text chat will be translated into your language. Tap the symbol in front of the message to see the original. You can turn off translations in the Settings menu.")
        if u1 and v32 ~= "" and a1 == ChatSettings_upv_1.GeneralChannelName and u3 ~= nil and u3.Value then
            v28:AddMessageToChannel({SpeakerUserId = 0, ID = -2, IsFiltered = true, OriginalChannel = a1, MessageLength = string.len(v32), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(v32)), Message = trimTrailingSpaces(v32), MessageType = ChatConstants_upv_1.MessageTypeWelcome, Time = os.time()})
        end
        DoFadeInFromNewInformation()
    end
end
tbl_upv_3.OnChannelJoined.OnClientEvent:connect(
    function(a1, a2, a3, a4)
        --[[
          line: 925
        ]]
        HandleChannelJoined(a1, a2, a3, a4, false, true)
    end
)
tbl_upv_3.OnChannelLeft.OnClientEvent:connect(
    function(a1)
        --[[
          line: 929
          upvalues:
            u13 (copy, index: 1)
        ]]
        u13:RemoveChannel(a1)
        DoFadeInFromNewInformation()
    end
)
tbl_upv_3.OnMuted.OnClientEvent:connect(function(a1)
    --[[
      line: 935
    ]]
end)
tbl_upv_3.OnUnmuted.OnClientEvent:connect(function(a1)
    --[[
      line: 941
    ]]
end)
tbl_upv_3.OnMainChannelSet.OnClientEvent:connect(
    function(a1)
        --[[
          line: 945
        ]]
        DoSwitchCurrentChannel(a1)
    end
)
coroutine.wrap(
    function()
        --[[
          line: 949
          upvalues:
            DefaultChatSystemChatEvents_upv_1 (copy, index: 1)
            u16 (copy, index: 2)
        ]]
        local v33 = DefaultChatSystemChatEvents_upv_1:WaitForChild("ChannelNameColorUpdated", 5)
        if not v33 then
            return
        end
        v33.OnClientEvent:connect(
            function(a1, a2)
                --[[
                  line: 953
                  upvalues:
                    u16 (copy, index: 1)
                ]]
                u16:SetChannelNameColor(a1, a2)
            end
        )
    end
)()
local u27 = nil
local u28 = nil
local u29 = nil
local u30 = nil
pcall(
    function()
        --[[
          line: 969
          upvalues:
            u27 (ref,  index: 1)
            StarterGui_upv_1 (copy, index: 2)
            u28 (ref,  index: 3)
            u29 (ref,  index: 4)
            u30 (ref,  index: 5)
        ]]
        u27 = StarterGui_upv_1:GetCore("PlayerBlockedEvent")
        u28 = StarterGui_upv_1:GetCore("PlayerMutedEvent")
        u29 = StarterGui_upv_1:GetCore("PlayerUnblockedEvent")
        u30 = StarterGui_upv_1:GetCore("PlayerUnmutedEvent")
    end
)
function SendSystemMessageToSelf(a1)
    --[[
      name: SendSystemMessageToSelf
      line: 976
      upvalues:
        u13 (copy, index: 1)
        ChatConstants_upv_1 (copy, index: 2)
    ]]
    local v34 = u13:GetCurrentChannel()
    if not v34 then
        return
    end
    v34:AddMessageToChannel({SpeakerUserId = 0, ID = -1, IsFiltered = true, OriginalChannel = v34.Name, MessageLength = string.len(a1), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(a1)), Message = trimTrailingSpaces(a1), MessageType = ChatConstants_upv_1.MessageTypeSystem, Time = os.time()})
end
function MutePlayer(a1)
    --[[
      name: MutePlayer
      line: 998
      upvalues:
        DefaultChatSystemChatEvents_upv_1 (copy, index: 1)
    ]]
    local MutePlayerRequest_1 = DefaultChatSystemChatEvents_upv_1:FindFirstChild("MutePlayerRequest")
    if MutePlayerRequest_1 then
        return MutePlayerRequest_1:InvokeServer(a1.Name)
    end
    return false
end
if u27 then
    u27.Event:connect(
        function(a1)
            --[[
              line: 1007
              upvalues:
                ChatSettings_upv_1 (copy, index: 1)
                u2 (ref,  index: 2)
            ]]
            if MutePlayer(a1) then
                local v35
                if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                    v35 = a1.DisplayName
                else
                    v35 = a1.Name
                end
                SendSystemMessageToSelf(u2:Get("GameChat_ChatMain_SpeakerHasBeenBlocked", string.format("Speaker '%s' has been blocked.", v35), {RBX_NAME = v35}))
            end
        end
    )
end
if false then
    local function ShowFriendJoinNotification()
        --[[
          name: ShowFriendJoinNotification
          line: 1029
          upvalues:
            ChatSettings_upv_1 (copy, index: 1)
        ]]
        if ChatSettings_upv_1.ShowFriendJoinNotification == nil then
            return false
        end
        return ChatSettings_upv_1.ShowFriendJoinNotification
    end
    local v36
    if ChatSettings_upv_1.ShowFriendJoinNotification == nil then
        v36 = false
    else
        v36 = ChatSettings_upv_1.ShowFriendJoinNotification
    end
    if v36 then
        Players_upv_1.PlayerAdded:Connect(
            function(a1)
                --[[
                  line: 1037
                  upvalues:
                    u8 (ref,  index: 1)
                    ChatSettings_upv_1 (copy, index: 2)
                    u2 (ref,  index: 3)
                ]]
                local success_3, v37 = pcall(
                    function()
                        --[[
                          line: 1038
                          upvalues:
                            a1 (copy, index: 1)
                            u8 (ref,  index: 2)
                        ]]
                        return a1:IsFriendsWith(u8.UserId)
                    end
                )
                if not success_3 then
                    return
                end
                if v37 then
                    local v38 = a1.Name
                    if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                        v38 = a1.DisplayName
                    end
                    SendSystemMessageToSelf((u2:FormatMessageToSend("GameChat_FriendChatNotifier_JoinMessage", string.format("Your friend %s has joined the game.", v38), "RBX_NAME", v38)))
                end
            end
        )
    end
end
if u28 then
    u28.Event:connect(
        function(a1)
            --[[
              line: 1060
              upvalues:
                ChatSettings_upv_1 (copy, index: 1)
                u2 (ref,  index: 2)
            ]]
            if MutePlayer(a1) then
                local v39
                if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                    v39 = a1.DisplayName
                else
                    v39 = a1.Name
                end
                SendSystemMessageToSelf(u2:Get("GameChat_ChatMain_SpeakerHasBeenMuted", string.format("Speaker '%s' has been muted.", v39), {RBX_NAME = v39}))
            end
        end
    )
end
function UnmutePlayer(a1)
    --[[
      name: UnmutePlayer
      line: 1081
      upvalues:
        DefaultChatSystemChatEvents_upv_1 (copy, index: 1)
    ]]
    local UnMutePlayerRequest_1 = DefaultChatSystemChatEvents_upv_1:FindFirstChild("UnMutePlayerRequest")
    if UnMutePlayerRequest_1 then
        return UnMutePlayerRequest_1:InvokeServer(a1.Name)
    end
    return false
end
if u29 then
    u29.Event:connect(
        function(a1)
            --[[
              line: 1090
              upvalues:
                ChatSettings_upv_1 (copy, index: 1)
                u2 (ref,  index: 2)
            ]]
            if UnmutePlayer(a1) then
                local v40
                if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                    v40 = a1.DisplayName
                else
                    v40 = a1.Name
                end
                SendSystemMessageToSelf(u2:Get("GameChat_ChatMain_SpeakerHasBeenUnBlocked", string.format("Speaker '%s' has been unblocked.", v40), {RBX_NAME = v40}))
            end
        end
    )
end
if u30 then
    u30.Event:connect(
        function(a1)
            --[[
              line: 1112
              upvalues:
                ChatSettings_upv_1 (copy, index: 1)
                u2 (ref,  index: 2)
            ]]
            if UnmutePlayer(a1) then
                local v41
                if ChatSettings_upv_1.PlayerDisplayNamesEnabled then
                    v41 = a1.DisplayName
                else
                    v41 = a1.Name
                end
                SendSystemMessageToSelf(u2:Get("GameChat_ChatMain_SpeakerHasBeenUnMuted", string.format("Speaker '%s' has been unmuted.", v41), {RBX_NAME = v41}))
            end
        end
    )
end
spawn(
    function()
        --[[
          line: 1135
          upvalues:
            u8 (ref,  index: 1)
            StarterGui_upv_1 (copy, index: 2)
            DefaultChatSystemChatEvents_upv_1 (copy, index: 3)
        ]]
        if not (u8.UserId > 0) then
            return
        end
        pcall(
            function()
                --[[
                  line: 1138
                  upvalues:
                    StarterGui_upv_1 (copy, index: 1)
                    DefaultChatSystemChatEvents_upv_1 (copy, index: 2)
                ]]
                local v42 = StarterGui_upv_1:GetCore("GetBlockedUserIds")
                if #v42 > 0 then
                    local SetBlockedUserIdsRequest_1 = DefaultChatSystemChatEvents_upv_1:FindFirstChild("SetBlockedUserIdsRequest")
                    if not SetBlockedUserIdsRequest_1 then
                        return
                    end
                    SetBlockedUserIdsRequest_1:FireServer(v42)
                end
            end
        )
    end
)
spawn(
    function()
        --[[
          line: 1150
          upvalues:
            Chat_upv_1 (copy, index: 1)
            u8 (ref,  index: 2)
            u9 (ref,  index: 3)
            RunService_upv_1 (copy, index: 4)
        ]]
        local success_4, v43 = pcall(
            function()
                --[[
                  line: 1151
                  upvalues:
                    Chat_upv_1 (copy, index: 1)
                    u8 (ref,  index: 2)
                ]]
                return Chat_upv_1:CanUserChatAsync(u8.UserId)
            end
        )
        if not success_4 then
            return
        end
        u9 = RunService_upv_1:IsStudio() or v43
    end
)
local v44 = tbl_upv_3.GetInitDataRequest:InvokeServer()
for v48, value_2 in pairs(v44.Channels) do
    if value_2[1] == ChatSettings_upv_1.GeneralChannelName then
        HandleChannelJoined(value_2[1], value_2[2], value_2[3], value_2[4], true, false)
    end
end
for v49, value_3 in pairs(v44.Channels) do
    if value_3[1] ~= ChatSettings_upv_1.GeneralChannelName then
        HandleChannelJoined(value_3[1], value_3[2], value_3[3], value_3[4], true, false)
    end
end
return tbl_upv_1