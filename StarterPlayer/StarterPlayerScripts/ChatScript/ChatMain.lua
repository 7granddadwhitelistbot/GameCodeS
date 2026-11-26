local v1
local localPlayer

local v3 = function(a4)
    --[[
      line: 945
    ]]
    DoSwitchCurrentChannel(a4)
end

local v5 = function(a6)
    --[[
      line: 941
    ]]
end

local v7 = function(a8)
    --[[
      line: 935
    ]]
end

local v9 = function(a10, a11, a12, a13)
    --[[
      line: 925
    ]]
    HandleChannelJoined(a10, a11, a12, a13, false, true)
end

local function Signal()
    --[[
      name: Signal
      line: 431
    ]]
    local v15 = {}
    local bindableEvent = Instance.new("BindableEvent")
    local v17 = nil
    local v18 = nil

    function v15.fire(a19, ...)
        --[[
          name: fire
          line: 439
          upvalues:
            v17 (ref,  index: 1)
            v18 (ref,  index: 2)
            bindableEvent (copy, index: 3)
        ]]
        v17 = {...}
        v18 = select("#", ...)
        bindableEvent:Fire()
    end

    function v15.connect(a20, callback)
        --[[
          name: connect
          line: 445
          upvalues:
            bindableEvent (copy, index: 1)
            v17 (ref,  index: 2)
            v18 (ref,  index: 3)
        ]]
        if not callback then
            error("connect(nil)", 2)
        end

        return bindableEvent.Event:connect(
            function()
                --[[
                  line: 447
                  upvalues:
                    callback (copy, index: 1)
                    v17 (ref,  index: 2)
                    v18 (ref,  index: 3)
                ]]
                callback(unpack(v17, 1, v18))
            end
        )
    end

    function v15.wait(a22)
        --[[
          name: wait
          line: 452
          upvalues:
            bindableEvent (copy, index: 1)
            v17 (ref,  index: 2)
            v18 (ref,  index: 3)
        ]]
        bindableEvent.Event:wait()
        assert(v17, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")

        return unpack(v17, 1, v18)
    end

    return v15
end

local function Get(a24, a25, a26)
    --[[
      name: Get
      line: 64
    ]]
    return a26
end

local v27 = {Visible = nil, IsCoreGuiEnabled = nil, TopbarEnabled = nil, VisibilityStateChanged = nil}
local isUserFeatureEnabled = false
local success, isUserFeatureEnabled2 = pcall(
    function()
        --[[
          line: 22
        ]]
        return UserSettings():IsUserFeatureEnabled("UserHandleFriendJoinNotifierOnClient")
    end
)
if success then
    isUserFeatureEnabled = isUserFeatureEnabled2
end

local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 32
        ]]
        return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local success3, v35 = pcall(
    function()
        --[[
          line: 39
        ]]
        return UserSettings():IsUserFeatureEnabled("UserAddBetterConsoleCheckForLegacyChat")
    end
)
game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
v35 = game:GetService("Chat")
local starterGui = game:GetService("StarterGui")
game:GetService("ContextActionService")
local defaultChatSystemChatEvents = replicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local defaultChatSystemChatEvents2 = replicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local clientChatModules = v35:WaitForChild("ClientChatModules")
local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
local v42 = "ChatSettings"
local Module = require(clientChatModules:WaitForChild(v42))
local messageCreatorModules = clientChatModules:WaitForChild("MessageCreatorModules")
local v45 = "Util"
local Module2 = require(messageCreatorModules:WaitForChild(v45))
local v47 = nil
pcall(
    function()
        --[[
          line: 63
          upvalues:
            v47 (ref, index: 1)
        ]]
        v47 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
    end
)

if v47 == nil then
    v47 = {}
    v47.Get = Get
end

v42 = nil

if isUserFeatureEnabled4 then
    local instance = script:FindFirstChild("ChatTranslationEnabled")

    if instance ~= nil then
        v1 = instance
    else
        local childAddedConnection = nil

        childAddedConnection = script.ChildAdded:Connect(
            function(child: Instance)
                --[[
                  line: 71
                  upvalues:
                    instance (ref, index: 1)
                    childAddedConnection (ref, index: 2)
                ]]
                if child.Name == "ChatTranslationEnabled" then
                    instance = child
                    childAddedConnection:Disconnect()
                end
            end
        )

        v1 = instance
    end
else
    v1 = v42
end

local v51 = 10
local v52 = {OnNewMessage = "RemoteEvent", OnMessageDoneFiltering = "RemoteEvent", OnNewSystemMessage = "RemoteEvent", OnChannelJoined = "RemoteEvent", OnChannelLeft = "RemoteEvent", OnMuted = "RemoteEvent", OnUnmuted = "RemoteEvent", OnMainChannelSet = "RemoteEvent", SayMessageRequest = "RemoteEvent", GetInitDataRequest = "RemoteFunction"}
local v53 = {}
local bindableEvent = Instance.new("BindableEvent")

function TryRemoveChildWithVerifyingIsCorrectType(a55)
    --[[
      name: TryRemoveChildWithVerifyingIsCorrectType
      line: 104
      upvalues:
        v52 (copy, index: 1)
        v53 (copy, index: 2)
        v51 (ref,  index: 3)
    ]]
    if v52[a55.Name] and a55:IsA(v52[a55.Name]) then
        v52[a55.Name] = nil
        v53[a55.Name] = a55
        v51 -= 1
    end
end

for _, child in pairs(defaultChatSystemChatEvents2:GetChildren()) do
    local child2 = child
    TryRemoveChildWithVerifyingIsCorrectType(child2)
end

if 0 < v51 then
    local childAddedConnection = defaultChatSystemChatEvents2.ChildAdded:connect(
        function(child: Instance)
            --[[
              line: 117
              upvalues:
                v51 (ref,  index: 1)
                bindableEvent (copy, index: 2)
            ]]
            TryRemoveChildWithVerifyingIsCorrectType(child)

            if v51 < 1 then
                bindableEvent:Fire()
            end
        end
    )

    bindableEvent.Event:wait()
    childAddedConnection:disconnect()
    bindableEvent:Destroy()
end

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
localPlayer = players.LocalPlayer

while not localPlayer do
    players.ChildAdded:wait()
    localPlayer = players.LocalPlayer
end

local v64 = true
local screenGuiDisplayOrder = 6

if Module.ScreenGuiDisplayOrder ~= nil then
    screenGuiDisplayOrder = Module.ScreenGuiDisplayOrder
end

local playerGui = localPlayer:WaitForChild("PlayerGui")
local chat = Instance.new("ScreenGui")
chat.Name = "Chat"
chat.ResetOnSpawn = false
chat.DisplayOrder = screenGuiDisplayOrder
chat.Parent = playerGui

if success3 and v35 and game:GetService("GuiService"):IsTenFootInterface() then
    chat.Enabled = false
end

local v68 = false
local script = script
local ChatWindow = require(script:WaitForChild("ChatWindow"))
local ChatBar = require(script:WaitForChild("ChatBar"))
local ChannelsBar = require(script:WaitForChild("ChannelsBar"))
require(script:WaitForChild("MessageLabelCreator"))
local childName = "MessageLogDisplay"
local child = require(script:WaitForChild(childName))
require(script:WaitForChild("ChatChannel"))
local CommandProcessor = require(script:WaitForChild("CommandProcessor"))
local chatWindow = ChatWindow.new()
local channelsBar = ChannelsBar.new()
local child4 = child.new()
local commandProcessor = CommandProcessor.new()
local chatBar = ChatBar.new(commandProcessor, chatWindow)
chatWindow:CreateGuiObjects(chat)
chatWindow:RegisterChatBar(chatBar)
chatWindow:RegisterChannelsBar(channelsBar)
chatWindow:RegisterMessageLogDisplay(child4)
Module2:RegisterChatWindow(chatWindow)
local childName2 = "MessageSender"
local child3 = require(script:WaitForChild(childName2))
child3:RegisterSayMessageFunction(v53.SayMessageRequest)

if userInputService.TouchEnabled then
    chatBar:SetTextLabelText(v47:Get("GameChat_ChatMain_ChatBarTextTouch", "Tap here to chat"))
else
    chatBar:SetTextLabelText(v47:Get("GameChat_ChatMain_ChatBarText", "To chat click here or press \"/\" key"))
end

spawn(
    function()
        --[[
          line: 204
          upvalues:
            script (copy, index: 1)
            Module (copy, index: 2)
            chatWindow (copy, index: 3)
        ]]
        local CurveUtil = require(script:WaitForChild("CurveUtil"))
        local v84 = 1 / (Module.ChatAnimationFPS or 20)
        local time = tick()

        while true do
            local time2 = tick()
            local v87 = CurveUtil:DeltaTimeToTimescale(time2 - time)

            if v87 ~= 0 then
                chatWindow:Update(v87)
            end

            wait(v84)
            time = time2
        end
    end
)

function CheckIfPointIsInSquare(a88, a89, a90)
    --[[
      name: CheckIfPointIsInSquare
      line: 230
    ]]
    return a89.X <= a88.X and a88.X <= a90.X and a89.Y <= a88.Y and (a88.Y <= a90.Y)
end

local v91 = false
local v92 = false
local time = 0
local time2 = 0
local bindableEvent2 = Instance.new("BindableEvent")
local bindableEvent3 = Instance.new("BindableEvent")
local bindableEvent4 = Instance.new("BindableEvent")

function DoBackgroundFadeIn(a98)
    --[[
      name: DoBackgroundFadeIn
      line: 244
      upvalues:
        time2 (ref,  index: 1)
        v91 (ref,  index: 2)
        bindableEvent2 (copy, index: 3)
        chatWindow (copy, index: 4)
        Module (copy, index: 5)
        child4 (copy, index: 6)
        child (copy, index: 7)
    ]]
    time2 = tick()
    v91 = false
    bindableEvent2:Fire()
    local v99 = a98 or Module.ChatDefaultFadeDuration
    chatWindow:FadeInBackground(v99)

    if chatWindow:GetCurrentChannel() then
        local scroller = child4.Scroller
        scroller.ScrollingEnabled = true
        scroller.ScrollBarThickness = child.ScrollBarThickness
    end
end

function DoBackgroundFadeOut(a101)
    --[[
      name: DoBackgroundFadeOut
      line: 259
      upvalues:
        time2 (ref,  index: 1)
        v91 (ref,  index: 2)
        bindableEvent2 (copy, index: 3)
        chatWindow (copy, index: 4)
        Module (copy, index: 5)
        child4 (copy, index: 6)
    ]]
    time2 = tick()
    v91 = true
    bindableEvent2:Fire()
    local v102 = a101 or Module.ChatDefaultFadeDuration
    chatWindow:FadeOutBackground(v102)

    if chatWindow:GetCurrentChannel() then
        local scroller = child4.Scroller
        scroller.ScrollingEnabled = false
        scroller.ScrollBarThickness = 0
    end
end

function DoTextFadeIn(a104)
    --[[
      name: DoTextFadeIn
      line: 274
      upvalues:
        time (ref,  index: 1)
        v92 (ref,  index: 2)
        bindableEvent2 (copy, index: 3)
        chatWindow (copy, index: 4)
        Module (copy, index: 5)
    ]]
    time = tick()
    v92 = false
    bindableEvent2:Fire()
    local v105 = a104 or Module.ChatDefaultFadeDuration
    chatWindow:FadeInText(v105 * 0)
end

function DoTextFadeOut(a106)
    --[[
      name: DoTextFadeOut
      line: 281
      upvalues:
        time (ref,  index: 1)
        v92 (ref,  index: 2)
        bindableEvent2 (copy, index: 3)
        chatWindow (copy, index: 4)
        Module (copy, index: 5)
    ]]
    time = tick()
    v92 = true
    bindableEvent2:Fire()
    local v107 = a106 or Module.ChatDefaultFadeDuration
    chatWindow:FadeOutText(v107)
end

function DoFadeInFromNewInformation()
    --[[
      name: DoFadeInFromNewInformation
      line: 288
      upvalues:
        Module (copy, index: 1)
    ]]
    DoTextFadeIn()

    if Module.ChatShouldFadeInFromNewInformation then
        DoBackgroundFadeIn()
    end
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

local v108 = nil

function UpdateFadingForMouseState(a109)
    --[[
      name: UpdateFadingForMouseState
      line: 306
      upvalues:
        v108 (ref,  index: 1)
        bindableEvent3 (copy, index: 2)
        chatBar (copy, index: 3)
    ]]
    v108 = a109
    bindableEvent3:Fire()

    if chatBar:IsFocused() then
        return
    end

    if a109 then
        DoBackgroundFadeIn()
        DoTextFadeIn()

        return
    end

    DoBackgroundFadeIn()
end

spawn(
    function()
        --[[
          line: 322
          upvalues:
            runService (copy, index: 1)
            v108 (ref,  index: 2)
            chatBar (copy, index: 3)
            bindableEvent3 (copy, index: 4)
            bindableEvent4 (copy, index: 5)
            v91 (ref,  index: 6)
            time2 (ref,  index: 7)
            Module (copy, index: 8)
            v92 (ref,  index: 9)
            time (ref,  index: 10)
            bindableEvent2 (copy, index: 11)
        ]]
        while true do
            runService.RenderStepped:wait()

            while v108 or chatBar:IsFocused() do
                if v108 then
                    bindableEvent3.Event:wait()
                end

                if chatBar:IsFocused() then
                    bindableEvent4.Event:wait()
                end
            end

            if v91 then
                if v92 then
                    bindableEvent2.Event:wait()
                else
                    local v110 = tick() - time

                    if Module.ChatWindowTextFadeOutTime < v110 then
                        DoTextFadeOut()
                    end
                end
            else
                local v111 = tick() - time2

                if Module.ChatWindowBackgroundFadeOutTime < v111 then
                    DoBackgroundFadeOut()
                end
            end
        end
    end
)

function getClassicChatEnabled()
    --[[
      name: getClassicChatEnabled
      line: 355
      upvalues:
        Module (copy, index: 1)
        players (copy, index: 2)
    ]]
    if Module.ClassicChatEnabled ~= nil then
        return Module.ClassicChatEnabled
    end

    return players.ClassicChat
end

function getBubbleChatEnabled()
    --[[
      name: getBubbleChatEnabled
      line: 362
      upvalues:
        Module (copy, index: 1)
        players (copy, index: 2)
    ]]
    if Module.BubbleChatEnabled ~= nil then
        return Module.BubbleChatEnabled
    end

    return players.BubbleChat
end

function bubbleChatOnly()
    --[[
      name: bubbleChatOnly
      line: 369
    ]]
    return not getClassicChatEnabled() and getBubbleChatEnabled()
end

function UpdateMousePosition(a112)
    --[[
      name: UpdateMousePosition
      line: 373
      upvalues:
        v27 (copy, index: 1)
        Module (copy, index: 2)
        chatWindow (copy, index: 3)
        v108 (ref,  index: 4)
    ]]
    if not v27.Visible
        or not v27.IsCoreGuiEnabled
        or not v27.TopbarEnabled and not Module.ChatOnWithTopBarOff
    then
        return
    end
    if bubbleChatOnly() then
        return
    end

    local absolutePosition = chatWindow.GuiObject.AbsolutePosition
    local v114 = CheckIfPointIsInSquare(a112, absolutePosition, absolutePosition + chatWindow.GuiObject.AbsoluteSize)

    if v114 ~= v108 then
        UpdateFadingForMouseState(v114)
    end
end

userInputService.InputChanged:connect(
    function(input: InputObject, gameProcessedEvent: boolean)
        --[[
          line: 390
        ]]
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local vector2 = Vector2.new(input.Position.X, input.Position.Y)
            UpdateMousePosition(vector2)
        end
    end
)

userInputService.TouchTap:connect(
    function(touchPositions, gameProcessedEvent: boolean)
        --[[
          line: 397
        ]]
        UpdateMousePosition(touchPositions[1])
    end
)

userInputService.TouchMoved:connect(
    function(touch: InputObject, gameProcessedEvent: boolean)
        --[[
          line: 401
        ]]
        local vector2 = Vector2.new(touch.Position.X, touch.Position.Y)
        UpdateMousePosition(vector2)
    end
)

userInputService.Changed:connect(
    function(property: string)
        --[[
          line: 406
          upvalues:
            userInputService (copy, index: 1)
            chatWindow (copy, index: 2)
            chat (copy, index: 3)
        ]]
        if property == "MouseBehavior" and userInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local absolutePosition = chatWindow.GuiObject.AbsolutePosition
            local absoluteSize = chatWindow.GuiObject.AbsoluteSize

            if CheckIfPointIsInSquare(chat.AbsoluteSize / 2, absolutePosition, absolutePosition + absoluteSize) then
                userInputService.MouseBehavior = Enum.MouseBehavior.Default
            end
        end
    end
)

UpdateFadingForMouseState(true)
UpdateFadingForMouseState(false)
local v126 = {Signal = Signal}

function SetVisibility(a127)
    --[[
      name: SetVisibility
      line: 463
      upvalues:
        chatWindow (copy, index: 1)
        v27 (copy, index: 2)
    ]]
    chatWindow:SetVisible(a127)
    v27.VisibilityStateChanged:fire(a127)
    v27.Visible = a127

    if v27.IsCoreGuiEnabled then
        if a127 then
            InstantFadeIn()
        else
            InstantFadeOut()
        end
    end
end

local doChatBarFocus = nil
v27.TopbarEnabled = true
v27.MessageCount = 0
v27.Visible = true
v27.IsCoreGuiEnabled = true

function v27.ToggleVisibility(a129)
    --[[
      name: ToggleVisibility
      line: 485
      upvalues:
        chatWindow (copy, index: 1)
    ]]
    SetVisibility(not chatWindow:GetVisible())
end

function v27.SetVisible(a130, a131)
    --[[
      name: SetVisible
      line: 489
      upvalues:
        chatWindow (copy, index: 1)
    ]]
    if chatWindow:GetVisible() ~= a131 then
        SetVisibility(a131)
    end
end

function v27.FocusChatBar(a132)
    --[[
      name: FocusChatBar
      line: 495
      upvalues:
        chatBar (copy, index: 1)
    ]]
    chatBar:CaptureFocus()
end

function v27.EnterWhisperState(a133, a134)
    --[[
      name: EnterWhisperState
      line: 499
      upvalues:
        chatBar (copy, index: 1)
    ]]
    chatBar:EnterWhisperState(a134)
end

function v27.GetVisibility(a135)
    --[[
      name: GetVisibility
      line: 503
      upvalues:
        chatWindow (copy, index: 1)
    ]]
    return chatWindow:GetVisible()
end

function v27.GetMessageCount(a136)
    --[[
      name: GetMessageCount
      line: 507
    ]]
    return a136.MessageCount
end

function v27.TopbarEnabledChanged(a137, topbarEnabled)
    --[[
      name: TopbarEnabledChanged
      line: 511
    ]]
    a137.TopbarEnabled = topbarEnabled
    a137.CoreGuiEnabled:fire(game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat))
end

function v27.IsFocused(a139, a140)
    --[[
      name: IsFocused
      line: 516
      upvalues:
        chatBar (copy, index: 1)
    ]]
    return chatBar:IsFocused()
end

v27.ChatBarFocusChanged = v126.Signal()
v27.VisibilityStateChanged = v126.Signal()
v27.MessagesChanged = v126.Signal()
v27.MessagePosted = v126.Signal()
v27.CoreGuiEnabled = v126.Signal()
v27.ChatMakeSystemMessageEvent = v126.Signal()
v27.ChatWindowPositionEvent = v126.Signal()
v27.ChatWindowSizeEvent = v126.Signal()
v27.ChatBarDisabledEvent = v126.Signal()

function v27.fChatWindowPosition(a141)
    --[[
      name: fChatWindowPosition
      line: 534
      upvalues:
        chatWindow (copy, index: 1)
    ]]
    return chatWindow.GuiObject.Position
end

function v27.fChatWindowSize(a142)
    --[[
      name: fChatWindowSize
      line: 538
      upvalues:
        chatWindow (copy, index: 1)
    ]]
    return chatWindow.GuiObject.Size
end

function v27.fChatBarDisabled(a143)
    --[[
      name: fChatBarDisabled
      line: 542
      upvalues:
        chatBar (copy, index: 1)
    ]]
    return not chatBar:GetEnabled()
end

function v27.SpecialKeyPressed(a144, a145, a146)
    --[[
      name: SpecialKeyPressed
      line: 546
      upvalues:
        v64 (ref, index: 1)
        doChatBarFocus (ref, index: 2)
    ]]
    if a145 == Enum.SpecialKey.ChatHotkey and v64 then
        doChatBarFocus()
    end
end

v27.CoreGuiEnabled:connect(
    function(a147)
        --[[
          line: 555
          upvalues:
            v27 (copy, index: 1)
            Module (copy, index: 2)
            chatWindow (copy, index: 3)
            chatBar (copy, index: 4)
        ]]
        v27.IsCoreGuiEnabled = a147
        a147 = a147 and (v27.TopbarEnabled or Module.ChatOnWithTopBarOff)
        chatWindow:SetCoreGuiEnabled(a147)

        if not a147 then
            chatBar:ReleaseFocus()
            InstantFadeOut()

            return
        end

        InstantFadeIn()
    end
)

function trimTrailingSpaces(a148)
    --[[
      name: trimTrailingSpaces
      line: 570
    ]]
    local v149 = #a148

    while 0 < v149 do
        if not a148:find("^%s", v149) then
            break
        end

        v149 -= 1
    end

    return a148:sub(1, v149)
end

v27.ChatMakeSystemMessageEvent:connect(
    function(extraData)
        --[[
          line: 583
          upvalues:
            v68 (ref,  index: 1)
            Module (copy, index: 2)
            chatWindow (copy, index: 3)
            ChatConstants (copy, index: 4)
            channelsBar (copy, index: 5)
            v27 (copy, index: 6)
        ]]
        if extraData.Text then
            local generalChannelName, channel

            if type(extraData.Text) == "string" then
                while not v68 do
                    wait()
                end

                generalChannelName = Module.GeneralChannelName
                channel = chatWindow:GetChannel(generalChannelName)

                if channel then
                    channel:AddMessageToChannel({ID = -1, FromSpeaker = nil, SpeakerUserId = 0, IsFiltered = true, OriginalChannel = generalChannelName, MessageLength = string.len(extraData.Text), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(extraData.Text)), Message = trimTrailingSpaces(extraData.Text), MessageType = ChatConstants.MessageTypeSetCore, Time = os.time(), ExtraData = extraData})
                    channelsBar:UpdateMessagePostedInChannel(generalChannelName)
                    v27.MessageCount += 1
                    v27.MessagesChanged:fire(v27.MessageCount)
                end
            end
        end
    end
)

v27.ChatBarDisabledEvent:connect(
    function(a153)
        --[[
          line: 613
          upvalues:
            v64 (ref,  index: 1)
            chatBar (copy, index: 2)
        ]]
        if v64 then
            chatBar:SetEnabled(not a153)

            if a153 then
                chatBar:ReleaseFocus()
            end
        end
    end
)

v27.ChatWindowSizeEvent:connect(
    function(size)
        --[[
          line: 622
          upvalues:
            chatWindow (copy, index: 1)
        ]]
        chatWindow.GuiObject.Size = size
    end
)
v27.ChatWindowPositionEvent:connect(
    function(position)
        --[[
          line: 626
          upvalues:
            chatWindow (copy, index: 1)
        ]]
        chatWindow.GuiObject.Position = position
    end
)

doChatBarFocus = function()
    --[[
      name: DoChatBarFocus
      line: 634
      upvalues:
        chatWindow (copy, index: 1)
        chatBar (copy, index: 2)
        v27 (copy, index: 3)
    ]]
    if not chatWindow:GetCoreGuiEnabled() then
        return
    end
    if not chatBar:GetEnabled() then
        return
    end

    if not chatBar:IsFocused() and chatBar:GetVisible() then
        v27:SetVisible(true)
        InstantFadeIn()
        chatBar:CaptureFocus()
        v27.ChatBarFocusChanged:fire(true)
    end
end

bindableEvent4.Event:connect(
    function(a156)
        --[[
          line: 646
          upvalues:
            v27 (copy, index: 1)
        ]]
        v27.ChatBarFocusChanged:fire(a156)
    end
)

function DoSwitchCurrentChannel(a157)
    --[[
      name: DoSwitchCurrentChannel
      line: 650
      upvalues:
        chatWindow (copy, index: 1)
    ]]
    if chatWindow:GetChannel(a157) then
        chatWindow:SwitchCurrentChannel(a157)
    end
end

function SendMessageToSelfInTargetChannel(text: string, originalChannel, extraData)
    --[[
      name: SendMessageToSelfInTargetChannel
      line: 656
      upvalues:
        chatWindow (copy, index: 1)
        ChatConstants (copy, index: 2)
    ]]
    if const channel = chatWindow:GetChannel(originalChannel) then
        channel:AddMessageToChannel({ID = -1, FromSpeaker = nil, SpeakerUserId = 0, IsFiltered = true, OriginalChannel = originalChannel, MessageLength = string.len(text), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(text)), Message = trimTrailingSpaces(text), MessageType = ChatConstants.MessageTypeSystem, Time = os.time(), ExtraData = extraData})
    end
end

function chatBarFocused()
    --[[
      name: chatBarFocused
      line: 677
      upvalues:
        v108 (ref,  index: 1)
        v92 (ref,  index: 2)
        bindableEvent4 (copy, index: 3)
    ]]
    if not v108 then
        DoBackgroundFadeIn()

        if v92 then
            DoTextFadeIn()
        end
    end

    bindableEvent4:Fire(true)
end

function chatBarFocusLost(a162, a163)
    --[[
      name: chatBarFocusLost
      line: 689
      upvalues:
        bindableEvent4 (copy, index: 1)
        chatBar (copy, index: 2)
        v27 (copy, index: 3)
        commandProcessor (copy, index: 4)
        chatWindow (copy, index: 5)
        Module (copy, index: 6)
        child3 (copy, index: 7)
    ]]
    DoBackgroundFadeIn()
    bindableEvent4:Fire(false)

    if a162 then
        local v164 = chatBar:GetTextBox().Text

        if chatBar:IsInCustomState() then
            if const customMessage = chatBar:GetCustomMessage() then
                v164 = customMessage
            end

            local v166 = chatBar:CustomStateProcessCompletedMessage(v164)
            chatBar:ResetCustomState()

            if v166 then
                return
            end
        end

        chatBar:GetTextBox().Text = ""

        if v164 ~= "" then
            v27.MessagePosted:fire(v164)

            if not commandProcessor:ProcessCompletedChatMessage(v164, chatWindow) then
                if Module.DisallowedWhiteSpace then
                    for index = 1, #Module.DisallowedWhiteSpace do
                        v164 = if Module.DisallowedWhiteSpace[index] == "\t" then string.gsub(v164, Module.DisallowedWhiteSpace[index], " ") else string.gsub(v164, Module.DisallowedWhiteSpace[index], "")
                    end
                end

                local text = string.gsub(v164, "\n", "")
                local text2 = string.gsub(text, "[ ]+", " ")

                if const targetMessageChannel = chatWindow:GetTargetMessageChannel() then
                    child3:SendMessage(text2, targetMessageChannel)
                    return
                end

                child3:SendMessage(text2, nil)
            end
        end
    end
end

local v171 = {}

function setupChatBarConnections()
    --[[
      name: setupChatBarConnections
      line: 740
      upvalues:
        v171 (ref,  index: 1)
        chatBar (copy, index: 2)
    ]]
    for index = 1, #v171 do
        v171[index]:Disconnect()
    end

    v171 = {}
    local v173 = chatBar:GetTextBox().FocusLost:connect(chatBarFocusLost)
    table.insert(v171, v173)
    v173 = chatBar:GetTextBox().Focused:connect(chatBarFocused)
    table.insert(v171, v173)
end

setupChatBarConnections()
chatBar.GuiObjectsChanged:connect(setupChatBarConnections)

function getEchoMessagesInGeneral()
    --[[
      name: getEchoMessagesInGeneral
      line: 756
      upvalues:
        Module (copy, index: 1)
    ]]
    if Module.EchoMessagesInGeneralChannel == nil then
        return true
    end

    return Module.EchoMessagesInGeneralChannel
end

v53.OnMessageDoneFiltering.OnClientEvent:connect(
    function(a174)
        --[[
          line: 763
          upvalues:
            Module (copy, index: 1)
            localPlayer (ref,  index: 2)
            chatWindow (copy, index: 3)
        ]]
        if not Module.ShowUserOwnFilteredMessage and a174.FromSpeaker == localPlayer.Name then
            return
        end

        local originalChannel = a174.OriginalChannel

        if const channel = chatWindow:GetChannel(originalChannel) then
            channel:UpdateMessageFiltered(a174)
        end

        if getEchoMessagesInGeneral()
            and Module.GeneralChannelName
            and originalChannel ~= Module.GeneralChannelName
        then
            if const channel2 = chatWindow:GetChannel(Module.GeneralChannelName) then
                channel2:UpdateMessageFiltered(a174)
            end
        end
    end
)

v53.OnNewMessage.OnClientEvent:connect(
    function(a178, a179)
        --[[
          line: 784
          upvalues:
            chatWindow (copy, index: 1)
            localPlayer (ref,  index: 2)
            channelsBar (copy, index: 3)
            Module (copy, index: 4)
            v27 (copy, index: 5)
        ]]
        if const channel = chatWindow:GetChannel(a179) then
            channel:AddMessageToChannel(a178)

            if a178.FromSpeaker ~= localPlayer.Name then
                channelsBar:UpdateMessagePostedInChannel(a179)
            end

            if getEchoMessagesInGeneral() and Module.GeneralChannelName and a179 ~= Module.GeneralChannelName then
                if const channel2 = chatWindow:GetChannel(Module.GeneralChannelName) then
                    channel2:AddMessageToChannel(a178)
                end
            end

            v27.MessageCount += 1
            v27.MessagesChanged:fire(v27.MessageCount)
            DoFadeInFromNewInformation()
        end
    end
)

v53.OnNewSystemMessage.OnClientEvent:connect(
    function(a182, a183)
        --[[
          line: 807
          upvalues:
            chatWindow (copy, index: 1)
            channelsBar (copy, index: 2)
            v27 (copy, index: 3)
            Module (copy, index: 4)
        ]]
        a183 = a183 or "System"

        if const channel = chatWindow:GetChannel(a183) then
            channel:AddMessageToChannel(a182)
            channelsBar:UpdateMessagePostedInChannel(a183)
            v27.MessageCount += 1
            v27.MessagesChanged:fire(v27.MessageCount)
            DoFadeInFromNewInformation()

            if getEchoMessagesInGeneral() and Module.GeneralChannelName and a183 ~= Module.GeneralChannelName then
                if const channel2 = chatWindow:GetChannel(Module.GeneralChannelName) then
                    channel2:AddMessageToChannel(a182)
                end
            end
        else
            warn(string.format("Just received system message for channel I'm not in [%s]", a183))
        end
    end
)

function HandleChannelJoined(originalChannel, text, a188, a189, a190, a191)
    --[[
      name: HandleChannelJoined
      line: 833
      upvalues:
        chatWindow (copy, index: 1)
        Module (copy, index: 2)
        v68 (ref,  index: 3)
        chatBar (copy, index: 4)
        ChatConstants (copy, index: 5)
        v47 (ref,  index: 6)
        isUserFeatureEnabled4 (ref,  index: 7)
        v1 (ref,  index: 8)
    ]]
    if chatWindow:GetChannel(originalChannel) then
        chatWindow:RemoveChannel(originalChannel)
    end

    if originalChannel == Module.GeneralChannelName then
        v68 = true
    end

    if a189 then
        chatBar:SetChannelNameColor(originalChannel, a189)
    end

    if const v192 = chatWindow:AddChannel(originalChannel) then
        if originalChannel == Module.GeneralChannelName then
            DoSwitchCurrentChannel(originalChannel)
        end

        if a188 then
            local v193 = 1
            local length = #a188

            if Module.MessageHistoryLengthPerChannel < length then
                v193 = #a188 - Module.MessageHistoryLengthPerChannel
            end

            for index = v193, #a188 do
                v192:AddMessageToChannel(a188[index])
            end

            if getEchoMessagesInGeneral()
                and a190
                and Module.GeneralChannelName
                and originalChannel ~= Module.GeneralChannelName
            then
                if const channel = chatWindow:GetChannel(Module.GeneralChannelName) then
                    channel:AddMessagesToChannelByTimeStamp(a188, v193)
                end
            end
        end

        if text ~= "" then
            local v197 = {ID = -1, FromSpeaker = nil, SpeakerUserId = 0, IsFiltered = true, ExtraData = nil, OriginalChannel = originalChannel, MessageLength = string.len(text), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(text)), Message = trimTrailingSpaces(text), MessageType = ChatConstants.MessageTypeWelcome, Time = os.time()}
            v192:AddMessageToChannel(v197)

            if getEchoMessagesInGeneral()
                and a191
                and not Module.ShowChannelsBar
                and originalChannel ~= Module.GeneralChannelName
            then
                if const channel = chatWindow:GetChannel(Module.GeneralChannelName) then
                    channel:AddMessageToChannel(v197)
                end
            end
        end

        local text2 = v47:Get("GameChat_ChatMain_ChatTranslationOnboarding", "Text chat will be translated into your language. Tap the symbol in front of the message to see the original. You can turn off translations in the Settings menu.")

        if isUserFeatureEnabled4
            and text2 ~= ""
            and originalChannel == Module.GeneralChannelName
            and v1 ~= nil
            and v1.Value
        then
            v192:AddMessageToChannel({ID = -2, FromSpeaker = nil, SpeakerUserId = 0, IsFiltered = true, ExtraData = nil, OriginalChannel = originalChannel, MessageLength = string.len(text2), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(text2)), Message = trimTrailingSpaces(text2), MessageType = ChatConstants.MessageTypeWelcome, Time = os.time()})
        end

        DoFadeInFromNewInformation()
    end
end

v53.OnChannelJoined.OnClientEvent:connect(v9)

v53.OnChannelLeft.OnClientEvent:connect(
    function(a200)
        --[[
          line: 929
          upvalues:
            chatWindow (copy, index: 1)
        ]]
        chatWindow:RemoveChannel(a200)
        DoFadeInFromNewInformation()
    end
)

v53.OnMuted.OnClientEvent:connect(v7)
v53.OnUnmuted.OnClientEvent:connect(v5)
v53.OnMainChannelSet.OnClientEvent:connect(v3)

coroutine.wrap(
    function()
        --[[
          line: 949
          upvalues:
            defaultChatSystemChatEvents (copy, index: 1)
            chatBar (copy, index: 2)
        ]]
        if const channelNameColorUpdated = defaultChatSystemChatEvents:WaitForChild("ChannelNameColorUpdated", 5) then
            channelNameColorUpdated.OnClientEvent:connect(
                function(a202, a203)
                    --[[
                      line: 953
                      upvalues:
                        chatBar (copy, index: 1)
                    ]]
                    chatBar:SetChannelNameColor(a202, a203)
                end
            )
        end
    end
)()

local core = nil
local core2 = nil
local core3 = nil
local core4 = nil

pcall(
    function()
        --[[
          line: 969
          upvalues:
            core (ref,  index: 1)
            starterGui (copy, index: 2)
            core2 (ref,  index: 3)
            core3 (ref,  index: 4)
            core4 (ref,  index: 5)
        ]]
        core = starterGui:GetCore("PlayerBlockedEvent")
        core2 = starterGui:GetCore("PlayerMutedEvent")
        core3 = starterGui:GetCore("PlayerUnblockedEvent")
        core4 = starterGui:GetCore("PlayerUnmutedEvent")
    end
)

function SendSystemMessageToSelf(text)
    --[[
      name: SendSystemMessageToSelf
      line: 976
      upvalues:
        chatWindow (copy, index: 1)
        ChatConstants (copy, index: 2)
    ]]
    if const currentChannel = chatWindow:GetCurrentChannel() then
        currentChannel:AddMessageToChannel({ID = -1, FromSpeaker = nil, SpeakerUserId = 0, IsFiltered = true, ExtraData = nil, OriginalChannel = currentChannel.Name, MessageLength = string.len(text), MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(text)), Message = trimTrailingSpaces(text), MessageType = ChatConstants.MessageTypeSystem, Time = os.time()})
    end
end

function MutePlayer(a210)
    --[[
      name: MutePlayer
      line: 998
      upvalues:
        defaultChatSystemChatEvents (copy, index: 1)
    ]]
    if const mutePlayerRequest = defaultChatSystemChatEvents:FindFirstChild("MutePlayerRequest") then
        return mutePlayerRequest:InvokeServer(a210.Name)
    end

    return false
end

if core then
    core.Event:connect(
        function(a212)
            --[[
              line: 1007
              upvalues:
                Module (copy, index: 1)
                v47 (ref,  index: 2)
            ]]
            if MutePlayer(a212) then
                local v213 = if Module.PlayerDisplayNamesEnabled then a212.DisplayName else a212.Name
                SendSystemMessageToSelf(v47:Get("GameChat_ChatMain_SpeakerHasBeenBlocked", string.format("Speaker '%s' has been blocked.", v213), {RBX_NAME = v213}))
            end
        end
    )
end

if isUserFeatureEnabled then
    local function ShowFriendJoinNotification()
        --[[
          name: ShowFriendJoinNotification
          line: 1029
          upvalues:
            Module (copy, index: 1)
        ]]
        if Module.ShowFriendJoinNotification ~= nil then
            return Module.ShowFriendJoinNotification
        end

        return false
    end

    local v215 = if Module.ShowFriendJoinNotification == nil then false else Module.ShowFriendJoinNotification
    if v215 then
        players.PlayerAdded:Connect(
            function(player: Player)
                --[[
                  line: 1037
                  upvalues:
                    localPlayer (ref,  index: 1)
                    Module (copy, index: 2)
                    v47 (ref,  index: 3)
                ]]
                local success, isFriendsWith = pcall(
                    function()
                        --[[
                          line: 1038
                          upvalues:
                            player (copy, index: 1)
                            localPlayer (ref,  index: 2)
                        ]]
                        return player:IsFriendsWith(localPlayer.UserId)
                    end
                )

                if success and isFriendsWith then
                    local v219 = player.Name

                    if Module.PlayerDisplayNamesEnabled then
                        v219 = player.DisplayName
                    end

                    local v220 = v47
                    local v221 = v220:FormatMessageToSend("GameChat_FriendChatNotifier_JoinMessage", string.format("Your friend %s has joined the game.", v219), "RBX_NAME", v219)
                    SendSystemMessageToSelf(v221)
                end
            end
        )
    end
end

if core2 then
    core2.Event:connect(
        function(a222)
            --[[
              line: 1060
              upvalues:
                Module (copy, index: 1)
                v47 (ref,  index: 2)
            ]]
            if MutePlayer(a222) then
                local v223 = if Module.PlayerDisplayNamesEnabled then a222.DisplayName else a222.Name
                SendSystemMessageToSelf(v47:Get("GameChat_ChatMain_SpeakerHasBeenMuted", string.format("Speaker '%s' has been muted.", v223), {RBX_NAME = v223}))
            end
        end
    )
end

function UnmutePlayer(a224)
    --[[
      name: UnmutePlayer
      line: 1081
      upvalues:
        defaultChatSystemChatEvents (copy, index: 1)
    ]]
    if const unMutePlayerRequest = defaultChatSystemChatEvents:FindFirstChild("UnMutePlayerRequest") then
        return unMutePlayerRequest:InvokeServer(a224.Name)
    end

    return false
end

if core3 then
    core3.Event:connect(
        function(a226)
            --[[
              line: 1090
              upvalues:
                Module (copy, index: 1)
                v47 (ref,  index: 2)
            ]]
            if UnmutePlayer(a226) then
                local v227 = if Module.PlayerDisplayNamesEnabled then a226.DisplayName else a226.Name
                SendSystemMessageToSelf(v47:Get("GameChat_ChatMain_SpeakerHasBeenUnBlocked", string.format("Speaker '%s' has been unblocked.", v227), {RBX_NAME = v227}))
            end
        end
    )
end

if core4 then
    core4.Event:connect(
        function(a228)
            --[[
              line: 1112
              upvalues:
                Module (copy, index: 1)
                v47 (ref,  index: 2)
            ]]
            if UnmutePlayer(a228) then
                local v229 = if Module.PlayerDisplayNamesEnabled then a228.DisplayName else a228.Name
                SendSystemMessageToSelf(v47:Get("GameChat_ChatMain_SpeakerHasBeenUnMuted", string.format("Speaker '%s' has been unmuted.", v229), {RBX_NAME = v229}))
            end
        end
    )
end

spawn(
    function()
        --[[
          line: 1135
          upvalues:
            localPlayer (ref,  index: 1)
            starterGui (copy, index: 2)
            defaultChatSystemChatEvents (copy, index: 3)
        ]]
        if 0 < localPlayer.UserId then
            pcall(
                function()
                    --[[
                      line: 1138
                      upvalues:
                        starterGui (copy, index: 1)
                        defaultChatSystemChatEvents (copy, index: 2)
                    ]]
                    local core = starterGui:GetCore("GetBlockedUserIds")

                    if 0 < #core then
                        if const setBlockedUserIdsRequest = defaultChatSystemChatEvents:FindFirstChild("SetBlockedUserIdsRequest") then
                            setBlockedUserIdsRequest:FireServer(core)
                        end
                    end
                end
            )
        end
    end
)

spawn(
    function()
        --[[
          line: 1150
          upvalues:
            v35 (copy, index: 1)
            localPlayer (ref,  index: 2)
            v64 (ref,  index: 3)
            runService (copy, index: 4)
        ]]
        local success, canUserChatAsync = pcall(
            function()
                --[[
                  line: 1151
                  upvalues:
                    v35 (copy, index: 1)
                    localPlayer (ref,  index: 2)
                ]]
                return v35:CanUserChatAsync(localPlayer.UserId)
            end
        )
        if success then
            v64 = runService:IsStudio() or canUserChatAsync
        end
    end
)

local v234 = v53.GetInitDataRequest:InvokeServer()

for _, channel in pairs(v234.Channels) do
    if channel[1] == Module.GeneralChannelName then
        HandleChannelJoined(channel[1], channel[2], channel[3], channel[4], true, false)
    end
end

for _, channel in pairs(v234.Channels) do
    if channel[1] ~= Module.GeneralChannelName then
        HandleChannelJoined(channel[1], channel[2], channel[3], channel[4], true, false)
    end
end

return v27