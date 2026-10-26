local StarterGui_upv_1 = game:GetService("StarterGui")
local GuiService_1 = game:GetService("GuiService")
local Chat_1 = game:GetService("Chat")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local ChatSettings_upv_1 = require(Chat_1:WaitForChild("ClientChatModules"):WaitForChild("ChatSettings"))
function SetCoreGuiChatConnections(a1)
    --[[
      name: SetCoreGuiChatConnections
      line: 107
      upvalues:
        StarterGui_upv_1 (copy, index: 1)
    ]]
    local v1 = 0
    while v1 < 10 do
        v1 = v1 + 1
        local success_1, v2 = pcall(
            function()
                --[[
                  line: 111
                  upvalues:
                    StarterGui_upv_1 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                StarterGui_upv_1:SetCore("CoreGuiChatConnections", a1)
            end
        )
        if success_1 then
            break
        end
        if not success_1 and v1 == 10 then
            error("Error calling SetCore CoreGuiChatConnections: " .. v2)
        end
        wait()
    end
end
function checkBothChatTypesDisabled()
    --[[
      name: checkBothChatTypesDisabled
      line: 122
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    if ChatSettings_upv_1.BubbleChatEnabled ~= nil and ChatSettings_upv_1.ClassicChatEnabled ~= nil then
        return not ChatSettings_upv_1.BubbleChatEnabled and not ChatSettings_upv_1.ClassicChatEnabled
    end
    return false
end
local function DoEverything()
    --[[
      name: DoEverything
      line: 16
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    local ChatMain_upv_1 = require(script:WaitForChild("ChatMain"))
    local tbl_upv_1 = {}
    tbl_upv_1.ChatWindow = {}
    tbl_upv_1.SetCore = {}
    tbl_upv_1.GetCore = {}
    tbl_upv_1.ChatWindow.ChatTypes = {}
    tbl_upv_1.ChatWindow.ChatTypes.BubbleChatEnabled = ChatSettings_upv_1.BubbleChatEnabled
    tbl_upv_1.ChatWindow.ChatTypes.ClassicChatEnabled = ChatSettings_upv_1.ClassicChatEnabled
    local function ConnectEvent_1(a1)
        --[[
          name: ConnectEvent
          line: 29
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        local v3 = Instance.new("BindableEvent")
        v3.Name = a1
        tbl_upv_1.ChatWindow[a1] = v3
        v3.Event:connect(function() end)
    end
    local function ConnectFunction_1(a2)
        --[[
          name: ConnectFunction
          line: 37
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        local v4 = Instance.new("BindableFunction")
        v4.Name = a2
        tbl_upv_1.ChatWindow[a2] = v4
        v4.OnInvoke = function() end
    end
    local function ReverseConnectEvent_1(a3)
        --[[
          name: ReverseConnectEvent
          line: 45
          upvalues:
            tbl_upv_1 (copy, index: 1)
            ChatMain_upv_1 (copy, index: 2)
        ]]
        local v5 = Instance.new("BindableEvent")
        v5.Name = a3
        tbl_upv_1.ChatWindow[a3] = v5
        ChatMain_upv_1[a3]:connect(function() end)
    end
    local function ConnectSignal_1(a4)
        --[[
          name: ConnectSignal
          line: 53
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        local v6 = Instance.new("BindableEvent")
        v6.Name = a4
        tbl_upv_1.ChatWindow[a4] = v6
        v6.Event:connect(function() end)
    end
    local function ConnectSetCore_1(a5)
        --[[
          name: ConnectSetCore
          line: 61
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        local v7 = Instance.new("BindableEvent")
        v7.Name = a5
        tbl_upv_1.SetCore[a5] = v7
        v7.Event:connect(function() end)
    end
    local function ConnectGetCore_1(a6)
        --[[
          name: ConnectGetCore
          line: 69
          upvalues:
            tbl_upv_1 (copy, index: 1)
        ]]
        local v8 = Instance.new("BindableFunction")
        v8.Name = a6
        tbl_upv_1.GetCore[a6] = v8
        v8.OnInvoke = function() end
    end
    local v9 = Instance.new("BindableEvent")
    v9.Name = "ToggleVisibility"
    tbl_upv_1.ChatWindow.ToggleVisibility = v9
    local _ = "ToggleVisibility"
    v9.Event:connect(function() end)
    local v10 = Instance.new("BindableEvent")
    v10.Name = "SetVisible"
    tbl_upv_1.ChatWindow.SetVisible = v10
    local v29 = "SetVisible"
    v10.Event:connect(function() end)
    local v11 = Instance.new("BindableEvent")
    v11.Name = "FocusChatBar"
    tbl_upv_1.ChatWindow.FocusChatBar = v11
    local v30 = "FocusChatBar"
    v11.Event:connect(function() end)
    local v12 = Instance.new("BindableEvent")
    v12.Name = "EnterWhisperState"
    tbl_upv_1.ChatWindow.EnterWhisperState = v12
    local v31 = "EnterWhisperState"
    v12.Event:connect(function() end)
    local v13 = Instance.new("BindableFunction")
    v13.Name = "GetVisibility"
    tbl_upv_1.ChatWindow.GetVisibility = v13
    local v32 = "GetVisibility"
    v13.OnInvoke = function() end
    local v14 = Instance.new("BindableFunction")
    v14.Name = "GetMessageCount"
    tbl_upv_1.ChatWindow.GetMessageCount = v14
    local v33 = "GetMessageCount"
    v14.OnInvoke = function() end
    local v15 = Instance.new("BindableEvent")
    v15.Name = "TopbarEnabledChanged"
    tbl_upv_1.ChatWindow.TopbarEnabledChanged = v15
    local v34 = "TopbarEnabledChanged"
    v15.Event:connect(function() end)
    local v16 = Instance.new("BindableFunction")
    v16.Name = "IsFocused"
    tbl_upv_1.ChatWindow.IsFocused = v16
    local u1 = "IsFocused"
    v16.OnInvoke = function(...)
        --[[
          line: 42
          upvalues:
            ChatMain_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
        ]]
        return ChatMain_upv_1[u1](ChatMain_upv_1, ...)
    end
    local v17 = Instance.new("BindableEvent")
    v17.Name = "ChatBarFocusChanged"
    tbl_upv_1.ChatWindow.ChatBarFocusChanged = v17
    ChatMain_upv_1.ChatBarFocusChanged:connect(function() end)
    local v18 = Instance.new("BindableEvent")
    v18.Name = "VisibilityStateChanged"
    tbl_upv_1.ChatWindow.VisibilityStateChanged = v18
    ChatMain_upv_1.VisibilityStateChanged:connect(function() end)
    local v19 = Instance.new("BindableEvent")
    v19.Name = "MessagesChanged"
    tbl_upv_1.ChatWindow.MessagesChanged = v19
    ChatMain_upv_1.MessagesChanged:connect(function() end)
    local u2 = Instance.new("BindableEvent")
    u2.Name = "MessagePosted"
    tbl_upv_1.ChatWindow.MessagePosted = u2
    ChatMain_upv_1.MessagePosted:connect(
        function(...)
            --[[
              line: 50
              upvalues:
                u2 (copy, index: 1)
            ]]
            u2:Fire(...)
        end
    )
    local v20 = Instance.new("BindableEvent")
    v20.Name = "CoreGuiEnabled"
    tbl_upv_1.ChatWindow.CoreGuiEnabled = v20
    local u3 = "CoreGuiEnabled"
    v20.Event:connect(
        function(...)
            --[[
              line: 58
              upvalues:
                ChatMain_upv_1 (copy, index: 1)
                u3 (copy, index: 2)
            ]]
            ChatMain_upv_1[u3]:fire(...)
        end
    )
    local v21 = Instance.new("BindableEvent")
    v21.Name = "ChatMakeSystemMessage"
    tbl_upv_1.SetCore.ChatMakeSystemMessage = v21
    local v35 = "ChatMakeSystemMessage"
    v21.Event:connect(function() end)
    local v22 = Instance.new("BindableEvent")
    v22.Name = "ChatWindowPosition"
    tbl_upv_1.SetCore.ChatWindowPosition = v22
    local v36 = "ChatWindowPosition"
    v22.Event:connect(function() end)
    local v23 = Instance.new("BindableEvent")
    v23.Name = "ChatWindowSize"
    tbl_upv_1.SetCore.ChatWindowSize = v23
    local v37 = "ChatWindowSize"
    v23.Event:connect(function() end)
    local v24 = Instance.new("BindableFunction")
    v24.Name = "ChatWindowPosition"
    tbl_upv_1.GetCore.ChatWindowPosition = v24
    local v38 = "ChatWindowPosition"
    v24.OnInvoke = function() end
    local v25 = Instance.new("BindableFunction")
    v25.Name = "ChatWindowSize"
    tbl_upv_1.GetCore.ChatWindowSize = v25
    local v39 = "ChatWindowSize"
    v25.OnInvoke = function() end
    local v26 = Instance.new("BindableEvent")
    v26.Name = "ChatBarDisabled"
    tbl_upv_1.SetCore.ChatBarDisabled = v26
    local u4 = "ChatBarDisabled"
    v26.Event:connect(
        function(...)
            --[[
              line: 66
              upvalues:
                ChatMain_upv_1 (copy, index: 1)
                u4 (copy, index: 2)
            ]]
            ChatMain_upv_1[u4 .. "Event"]:fire(...)
        end
    )
    local v27 = Instance.new("BindableFunction")
    v27.Name = "ChatBarDisabled"
    tbl_upv_1.GetCore.ChatBarDisabled = v27
    local u5 = "ChatBarDisabled"
    v27.OnInvoke = function(...)
        --[[
          line: 74
          upvalues:
            ChatMain_upv_1 (copy, index: 1)
            u5 (copy, index: 2)
        ]]
        return ChatMain_upv_1["f" .. u5](...)
    end
    local v28 = Instance.new("BindableEvent")
    v28.Name = "SpecialKeyPressed"
    tbl_upv_1.ChatWindow.SpecialKeyPressed = v28
    local u6 = "SpecialKeyPressed"
    v28.Event:connect(
        function(...)
            --[[
              line: 34
              upvalues:
                ChatMain_upv_1 (copy, index: 1)
                u6 (copy, index: 2)
            ]]
            ChatMain_upv_1[u6](ChatMain_upv_1, ...)
        end
    )
    SetCoreGuiChatConnections(tbl_upv_1)
end
if GuiService_1:IsTenFootInterface() then
    ReplicatedStorage_1:WaitForChild("DefaultChatSystemChatEvents").GetInitDataRequest:InvokeServer()
elseif checkBothChatTypesDisabled() then
    local tbl_2 = {}
    tbl_2.ChatWindow = {}
    tbl_2.ChatWindow.ChatTypes = {}
    tbl_2.ChatWindow.ChatTypes.BubbleChatEnabled = false
    tbl_2.ChatWindow.ChatTypes.ClassicChatEnabled = false
    SetCoreGuiChatConnections(tbl_2)
else
    DoEverything()
end