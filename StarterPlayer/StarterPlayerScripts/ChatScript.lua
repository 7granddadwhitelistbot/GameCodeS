local starterGui = game:GetService("StarterGui")
local guiService = game:GetService("GuiService")
local chat = game:GetService("Chat")
local replicatedStorage = game:GetService("ReplicatedStorage")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))

function SetCoreGuiChatConnections(value)
    --[[
      name: SetCoreGuiChatConnections
      line: 107
      upvalues:
        starterGui (copy, index: 1)
    ]]
    local count = 0

    while count < 10 do
        count += 1
        local success, result = pcall(
            function()
                --[[
                  line: 111
                  upvalues:
                    starterGui (copy, index: 1)
                    value (copy, index: 2)
                ]]
                starterGui:SetCore("CoreGuiChatConnections", value)
            end
        )
        if success then
            break
        end

        if success or count ~= 10 then
            wait()
        else
            error("Error calling SetCore CoreGuiChatConnections: " .. result)
            wait()
        end
    end
end

function checkBothChatTypesDisabled()
    --[[
      name: checkBothChatTypesDisabled
      line: 122
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    if ChatSettings.BubbleChatEnabled == nil or ChatSettings.ClassicChatEnabled == nil then
        return false
    end

    local v11 = ChatSettings.BubbleChatEnabled or ChatSettings.ClassicChatEnabled

    return not v11
end

if guiService:IsTenFootInterface() then
    local defaultChatSystemChatEvents = replicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
    defaultChatSystemChatEvents.GetInitDataRequest:InvokeServer()

    return
end

if not checkBothChatTypesDisabled() then
    (function()
        --[[
          name: DoEverything
          line: 16
          upvalues:
            ChatSettings (copy, index: 1)
        ]]
        local ChatMain = require(script:WaitForChild("ChatMain"))
        local v14 = {ChatWindow = {}, SetCore = {}, GetCore = {}}
        v14.ChatWindow.ChatTypes = {}
        v14.ChatWindow.ChatTypes.BubbleChatEnabled = ChatSettings.BubbleChatEnabled
        v14.ChatWindow.ChatTypes.ClassicChatEnabled = ChatSettings.ClassicChatEnabled

        local function ConnectEvent(name: string)
            --[[
              name: ConnectEvent
              line: 29
              upvalues:
                v14 (copy, index: 1)
                ChatMain (copy, index: 2)
            ]]
            local bindableEvent = Instance.new("BindableEvent")
            bindableEvent.Name = name
            v14.ChatWindow[name] = bindableEvent
            bindableEvent.Event:connect(
                function(...)
                    --[[
                      line: 34
                      upvalues:
                        ChatMain (copy, index: 1)
                        name (copy, index: 2)
                    ]]
                    ChatMain[name](ChatMain, ...)
                end
            )
        end

        local function ConnectFunction(name: string)
            --[[
              name: ConnectFunction
              line: 37
              upvalues:
                v14 (copy, index: 1)
                ChatMain (copy, index: 2)
            ]]
            local bindableFunction = Instance.new("BindableFunction")
            bindableFunction.Name = name
            v14.ChatWindow[name] = bindableFunction

            bindableFunction.OnInvoke = function(...)
                --[[
                  line: 42
                  upvalues:
                    ChatMain (copy, index: 1)
                    name (copy, index: 2)
                ]]
                return ChatMain[name](ChatMain, ...)
            end
        end

        local function ReverseConnectEvent(name: string)
            --[[
              name: ReverseConnectEvent
              line: 45
              upvalues:
                v14 (copy, index: 1)
                ChatMain (copy, index: 2)
            ]]
            local bindableEvent = Instance.new("BindableEvent")
            bindableEvent.Name = name
            v14.ChatWindow[name] = bindableEvent
            ChatMain[name]:connect(
                function(...)
                    --[[
                      line: 50
                      upvalues:
                        bindableEvent (copy, index: 1)
                    ]]
                    bindableEvent:Fire(...)
                end
            )
        end

        local function ConnectSignal(name: string)
            --[[
              name: ConnectSignal
              line: 53
              upvalues:
                v14 (copy, index: 1)
                ChatMain (copy, index: 2)
            ]]
            local bindableEvent = Instance.new("BindableEvent")
            bindableEvent.Name = name
            v14.ChatWindow[name] = bindableEvent
            bindableEvent.Event:connect(
                function(...)
                    --[[
                      line: 58
                      upvalues:
                        ChatMain (copy, index: 1)
                        name (copy, index: 2)
                    ]]
                    ChatMain[name]:fire(...)
                end
            )
        end

        local function ConnectSetCore(name: string)
            --[[
              name: ConnectSetCore
              line: 61
              upvalues:
                v14 (copy, index: 1)
                ChatMain (copy, index: 2)
            ]]
            local bindableEvent = Instance.new("BindableEvent")
            bindableEvent.Name = name
            v14.SetCore[name] = bindableEvent
            bindableEvent.Event:connect(
                function(...)
                    --[[
                      line: 66
                      upvalues:
                        ChatMain (copy, index: 1)
                        name (copy, index: 2)
                    ]]
                    ChatMain[name .. "Event"]:fire(...)
                end
            )
        end

        local function ConnectGetCore(name: string)
            --[[
              name: ConnectGetCore
              line: 69
              upvalues:
                v14 (copy, index: 1)
                ChatMain (copy, index: 2)
            ]]
            local bindableFunction = Instance.new("BindableFunction")
            bindableFunction.Name = name
            v14.GetCore[name] = bindableFunction

            bindableFunction.OnInvoke = function(...)
                --[[
                  line: 74
                  upvalues:
                    ChatMain (copy, index: 1)
                    name (copy, index: 2)
                ]]
                return ChatMain["f" .. name](...)
            end
        end

        local toggleVisibility = Instance.new("BindableEvent")
        toggleVisibility.Name = "ToggleVisibility"
        v14.ChatWindow.ToggleVisibility = toggleVisibility
        local v34 = "ToggleVisibility"
        toggleVisibility.Event:connect(
            function(...)
                --[[
                  line: 34
                  upvalues:
                    ChatMain (copy, index: 1)
                    v34 (copy, index: 2)
                ]]
                ChatMain[v34](ChatMain, ...)
            end
        )
        local setVisible = Instance.new("BindableEvent")
        setVisible.Name = "SetVisible"
        v14.ChatWindow.SetVisible = setVisible
        local v36 = "SetVisible"
        setVisible.Event:connect(
            function(...)
                --[[
                  line: 34
                  upvalues:
                    ChatMain (copy, index: 1)
                    v36 (copy, index: 2)
                ]]
                ChatMain[v36](ChatMain, ...)
            end
        )
        local focusChatBar = Instance.new("BindableEvent")
        focusChatBar.Name = "FocusChatBar"
        v14.ChatWindow.FocusChatBar = focusChatBar
        local v38 = "FocusChatBar"
        focusChatBar.Event:connect(
            function(...)
                --[[
                  line: 34
                  upvalues:
                    ChatMain (copy, index: 1)
                    v38 (copy, index: 2)
                ]]
                ChatMain[v38](ChatMain, ...)
            end
        )
        local enterWhisperState = Instance.new("BindableEvent")
        enterWhisperState.Name = "EnterWhisperState"
        v14.ChatWindow.EnterWhisperState = enterWhisperState
        local v40 = "EnterWhisperState"
        enterWhisperState.Event:connect(
            function(...)
                --[[
                  line: 34
                  upvalues:
                    ChatMain (copy, index: 1)
                    v40 (copy, index: 2)
                ]]
                ChatMain[v40](ChatMain, ...)
            end
        )
        local getVisibility = Instance.new("BindableFunction")
        getVisibility.Name = "GetVisibility"
        v14.ChatWindow.GetVisibility = getVisibility
        local v42 = "GetVisibility"

        getVisibility.OnInvoke = function(...)
            --[[
              line: 42
              upvalues:
                ChatMain (copy, index: 1)
                v42 (copy, index: 2)
            ]]
            return ChatMain[v42](ChatMain, ...)
        end

        local getMessageCount = Instance.new("BindableFunction")
        getMessageCount.Name = "GetMessageCount"
        v14.ChatWindow.GetMessageCount = getMessageCount
        local v44 = "GetMessageCount"

        getMessageCount.OnInvoke = function(...)
            --[[
              line: 42
              upvalues:
                ChatMain (copy, index: 1)
                v44 (copy, index: 2)
            ]]
            return ChatMain[v44](ChatMain, ...)
        end

        local topbarEnabledChanged = Instance.new("BindableEvent")
        topbarEnabledChanged.Name = "TopbarEnabledChanged"
        v14.ChatWindow.TopbarEnabledChanged = topbarEnabledChanged
        local v46 = "TopbarEnabledChanged"
        topbarEnabledChanged.Event:connect(
            function(...)
                --[[
                  line: 34
                  upvalues:
                    ChatMain (copy, index: 1)
                    v46 (copy, index: 2)
                ]]
                ChatMain[v46](ChatMain, ...)
            end
        )
        local isFocused = Instance.new("BindableFunction")
        isFocused.Name = "IsFocused"
        v14.ChatWindow.IsFocused = isFocused
        local v48 = "IsFocused"

        isFocused.OnInvoke = function(...)
            --[[
              line: 42
              upvalues:
                ChatMain (copy, index: 1)
                v48 (copy, index: 2)
            ]]
            return ChatMain[v48](ChatMain, ...)
        end

        local chatBarFocusChanged = Instance.new("BindableEvent")
        chatBarFocusChanged.Name = "ChatBarFocusChanged"
        v14.ChatWindow.ChatBarFocusChanged = chatBarFocusChanged
        ChatMain.ChatBarFocusChanged:connect(
            function(...)
                --[[
                  line: 50
                  upvalues:
                    chatBarFocusChanged (copy, index: 1)
                ]]
                chatBarFocusChanged:Fire(...)
            end
        )
        local visibilityStateChanged = Instance.new("BindableEvent")
        visibilityStateChanged.Name = "VisibilityStateChanged"
        v14.ChatWindow.VisibilityStateChanged = visibilityStateChanged
        ChatMain.VisibilityStateChanged:connect(
            function(...)
                --[[
                  line: 50
                  upvalues:
                    visibilityStateChanged (copy, index: 1)
                ]]
                visibilityStateChanged:Fire(...)
            end
        )
        local messagesChanged = Instance.new("BindableEvent")
        messagesChanged.Name = "MessagesChanged"
        v14.ChatWindow.MessagesChanged = messagesChanged
        ChatMain.MessagesChanged:connect(
            function(...)
                --[[
                  line: 50
                  upvalues:
                    messagesChanged (copy, index: 1)
                ]]
                messagesChanged:Fire(...)
            end
        )
        local messagePosted = Instance.new("BindableEvent")
        messagePosted.Name = "MessagePosted"
        v14.ChatWindow.MessagePosted = messagePosted
        ChatMain.MessagePosted:connect(
            function(...)
                --[[
                  line: 50
                  upvalues:
                    messagePosted (copy, index: 1)
                ]]
                messagePosted:Fire(...)
            end
        )
        local coreGuiEnabled = Instance.new("BindableEvent")
        coreGuiEnabled.Name = "CoreGuiEnabled"
        v14.ChatWindow.CoreGuiEnabled = coreGuiEnabled
        local v54 = "CoreGuiEnabled"
        coreGuiEnabled.Event:connect(
            function(...)
                --[[
                  line: 58
                  upvalues:
                    ChatMain (copy, index: 1)
                    v54 (copy, index: 2)
                ]]
                ChatMain[v54]:fire(...)
            end
        )
        local chatMakeSystemMessage = Instance.new("BindableEvent")
        chatMakeSystemMessage.Name = "ChatMakeSystemMessage"
        v14.SetCore.ChatMakeSystemMessage = chatMakeSystemMessage
        local v56 = "ChatMakeSystemMessage"
        chatMakeSystemMessage.Event:connect(
            function(...)
                --[[
                  line: 66
                  upvalues:
                    ChatMain (copy, index: 1)
                    v56 (copy, index: 2)
                ]]
                ChatMain[v56 .. "Event"]:fire(...)
            end
        )
        local chatWindowPosition = Instance.new("BindableEvent")
        chatWindowPosition.Name = "ChatWindowPosition"
        v14.SetCore.ChatWindowPosition = chatWindowPosition
        local v58 = "ChatWindowPosition"
        chatWindowPosition.Event:connect(
            function(...)
                --[[
                  line: 66
                  upvalues:
                    ChatMain (copy, index: 1)
                    v58 (copy, index: 2)
                ]]
                ChatMain[v58 .. "Event"]:fire(...)
            end
        )
        local chatWindowSize = Instance.new("BindableEvent")
        chatWindowSize.Name = "ChatWindowSize"
        v14.SetCore.ChatWindowSize = chatWindowSize
        local v60 = "ChatWindowSize"
        chatWindowSize.Event:connect(
            function(...)
                --[[
                  line: 66
                  upvalues:
                    ChatMain (copy, index: 1)
                    v60 (copy, index: 2)
                ]]
                ChatMain[v60 .. "Event"]:fire(...)
            end
        )
        local chatWindowPosition2 = Instance.new("BindableFunction")
        chatWindowPosition2.Name = "ChatWindowPosition"
        v14.GetCore.ChatWindowPosition = chatWindowPosition2
        local v62 = "ChatWindowPosition"

        chatWindowPosition2.OnInvoke = function(...)
            --[[
              line: 74
              upvalues:
                ChatMain (copy, index: 1)
                v62 (copy, index: 2)
            ]]
            return ChatMain["f" .. v62](...)
        end

        local chatWindowSize2 = Instance.new("BindableFunction")
        chatWindowSize2.Name = "ChatWindowSize"
        v14.GetCore.ChatWindowSize = chatWindowSize2
        local v64 = "ChatWindowSize"

        chatWindowSize2.OnInvoke = function(...)
            --[[
              line: 74
              upvalues:
                ChatMain (copy, index: 1)
                v64 (copy, index: 2)
            ]]
            return ChatMain["f" .. v64](...)
        end

        local chatBarDisabled = Instance.new("BindableEvent")
        chatBarDisabled.Name = "ChatBarDisabled"
        v14.SetCore.ChatBarDisabled = chatBarDisabled
        local v66 = "ChatBarDisabled"
        chatBarDisabled.Event:connect(
            function(...)
                --[[
                  line: 66
                  upvalues:
                    ChatMain (copy, index: 1)
                    v66 (copy, index: 2)
                ]]
                ChatMain[v66 .. "Event"]:fire(...)
            end
        )
        local chatBarDisabled2 = Instance.new("BindableFunction")
        chatBarDisabled2.Name = "ChatBarDisabled"
        v14.GetCore.ChatBarDisabled = chatBarDisabled2
        local v68 = "ChatBarDisabled"

        chatBarDisabled2.OnInvoke = function(...)
            --[[
              line: 74
              upvalues:
                ChatMain (copy, index: 1)
                v68 (copy, index: 2)
            ]]
            return ChatMain["f" .. v68](...)
        end

        local specialKeyPressed = Instance.new("BindableEvent")
        specialKeyPressed.Name = "SpecialKeyPressed"
        v14.ChatWindow.SpecialKeyPressed = specialKeyPressed
        local v70 = "SpecialKeyPressed"
        specialKeyPressed.Event:connect(
            function(...)
                --[[
                  line: 34
                  upvalues:
                    ChatMain (copy, index: 1)
                    v70 (copy, index: 2)
                ]]
                ChatMain[v70](ChatMain, ...)
            end
        )
        SetCoreGuiChatConnections(v14)
    end)()
    return
end

local v71 = {ChatWindow = {}}
v71.ChatWindow.ChatTypes = {}
v71.ChatWindow.ChatTypes.BubbleChatEnabled = false
v71.ChatWindow.ChatTypes.ClassicChatEnabled = false
SetCoreGuiChatConnections(v71)