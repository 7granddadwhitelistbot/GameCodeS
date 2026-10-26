local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local TweenService_upv_1 = game:GetService("TweenService")
local RunService_1 = game:GetService("RunService")
local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local Signal_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds_upv_1 = require(ReplicatedStorage_upv_1.Shared:WaitForChild("Keybinds"))
local UI_upv_1 = require(script.Parent:WaitForChild("UI"))
local tbl_upv_1 = {}
local tbl_upv_2 = {}
local u1 = nil
local tbl_upv_3 = {}
local u2 = false
local u3 = nil
local u4 = 0
tbl_upv_1.Changed = Signal_1.new()
function tbl_upv_1.Camera()
    --[[
      name: Camera
      line: 45
      upvalues:
        u3 (ref,  index: 1)
        u4 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    if u3 then
        return u3
    end
    if os.clock() - u4 < 3 then
        return nil
    end
    u4 = os.clock()
    local Shared_1 = ReplicatedStorage_upv_1:FindFirstChild("Shared")
    local v1 = Shared_1 and (Shared_1:FindFirstChild("Camera"))
    if v1 and v1:IsA("ModuleScript") then
        local success_1, v2 = pcall(require, v1)
        if success_1 and type(v2) == "table" then
            u3 = v2
        end
    end
    return u3
end
local function applyMouse()
    --[[
      name: applyMouse
      line: 64
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u2 (ref,  index: 2)
        tbl_upv_1 (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
    ]]
    local v3 = next(tbl_upv_3) ~= nil
    if v3 == u2 then
        return
    end
    u2 = v3
    local v4 = tbl_upv_1.Camera()
    if v4 then
        local v5
        if v3 then
            v5 = v4.PushMouseUnlock
        else
            v5 = v4.PopMouseUnlock
        end
        if type(v5) == "function" then
            pcall(v5, "UI")
        end
    end
    if not v3 then
        return
    end
    UserInputService_upv_1.MouseIconEnabled = true
end
function tbl_upv_1.PushMouse(a1)
    --[[
      name: PushMouse
      line: 83
      upvalues:
        tbl_upv_3 (copy, index: 1)
        applyMouse (copy, index: 2)
    ]]
    tbl_upv_3[a1] = true
    applyMouse()
end
function tbl_upv_1.PopMouse(a1)
    --[[
      name: PopMouse
      line: 87
      upvalues:
        tbl_upv_3 (copy, index: 1)
        applyMouse (copy, index: 2)
    ]]
    tbl_upv_3[a1] = nil
    applyMouse()
end
local u5 = nil
local function setBlur(a1)
    --[[
      name: setBlur
      line: 93
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        u5 (ref,  index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    if not CurrentCamera_1 then
        return
    end
    if not (u5) or u5.Parent ~= CurrentCamera_1 then
        if u5 then
            u5:Destroy()
        end
        local v6 = Instance.new("BlurEffect")
        v6.Name = "TribesMenuBlur"
        v6.Size = 0
        v6.Parent = CurrentCamera_1
        u5 = v6
    end
    local v7 = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
    local tbl_4 = {Size = 0}
    tbl_4.Size = (a1 and 12) or 0
    TweenService_upv_1:Create(u5, v7, tbl_4):Play()
end
local u6 = nil
local function hideChat()
    --[[
      name: hideChat
      line: 117
      upvalues:
        u6 (ref, index: 1)
    ]]
    if u6 then
        return
    end
    local tbl_upv_5 = {}
    u6 = tbl_upv_5
    pcall(
        function()
            --[[
              line: 123
              upvalues:
                tbl_upv_5 (copy, index: 1)
            ]]
            local TextChatService_1 = game:GetService("TextChatService")
            local v8 = TextChatService_1:FindFirstChildOfClass("ChatWindowConfiguration")
            local v9 = TextChatService_1:FindFirstChildOfClass("ChatInputBarConfiguration")
            if v8 then
                tbl_upv_5.window = v8.Enabled
                v8.Enabled = false
            end
            if not v9 then
                return
            end
            tbl_upv_5.bar = v9.Enabled
            v9.Enabled = false
        end
    )
    pcall(
        function()
            --[[
              line: 136
              upvalues:
                tbl_upv_5 (copy, index: 1)
            ]]
            local StarterGui_1 = game:GetService("StarterGui")
            tbl_upv_5.core = StarterGui_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
            StarterGui_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end
    )
end
local function restoreChat()
    --[[
      name: restoreChat
      line: 142
      upvalues:
        u6 (ref, index: 1)
    ]]
    local u7 = u6
    if not u7 then
        return
    end
    u6 = nil
    pcall(
        function()
            --[[
              line: 148
              upvalues:
                u7 (copy, index: 1)
            ]]
            local TextChatService_2 = game:GetService("TextChatService")
            local v10 = TextChatService_2:FindFirstChildOfClass("ChatWindowConfiguration")
            local v11 = TextChatService_2:FindFirstChildOfClass("ChatInputBarConfiguration")
            if v10 and u7.window ~= nil then
                v10.Enabled = u7.window
            end
            if not v11 or u7.bar == nil then
                return
            end
            v11.Enabled = u7.bar
        end
    )
    pcall(
        function()
            --[[
              line: 159
              upvalues:
                u7 (copy, index: 1)
            ]]
            if u7.core == nil then
                return
            end
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, u7.core)
        end
    )
end
local tbl_upv_6 = {}
function tbl_upv_1.HoldChat(a1, a2)
    --[[
      name: HoldChat
      line: 170
      upvalues:
        tbl_upv_6 (copy, index: 1)
        hideChat (copy, index: 2)
        restoreChat (copy, index: 3)
    ]]
    if a2 then
        tbl_upv_6[a1] = true
        hideChat()
    else
        tbl_upv_6[a1] = nil
        if next(tbl_upv_6) == nil then
            restoreChat()
        end
    end
end
local tbl_upv_7 = {}
local u8 = false
tbl_upv_1.FocusChanged = Signal_1.new()
local function topFocus()
    --[[
      name: topFocus
      line: 190
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    return tbl_upv_7[#tbl_upv_7]
end
local function usable(a1)
    --[[
      name: usable
      line: 195
    ]]
    if typeof(a1) ~= "Instance" or not a1:IsA("GuiObject") or not a1:IsDescendantOf(game) or not a1.Selectable then
        return false
    end
    local v12 = a1
    while v12 and v12 ~= game do
        if (v12:IsA("GuiObject")) and not v12.Visible then
            return false
        elseif not (v12:IsA("ScreenGui")) or v12.Enabled then
            v12 = v12.Parent
        end
    end
    return true
end
local function selectOwner(a1)
    --[[
      name: selectOwner
      line: 210
      upvalues:
        UI_upv_1 (copy, index: 1)
        usable (copy, index: 2)
        GuiService_upv_1 (copy, index: 3)
        u1 (ref,  index: 4)
        tbl_upv_2 (copy, index: 5)
        tbl_upv_7 (copy, index: 6)
    ]]
    if not UI_upv_1.Gamepad or a1 and usable(GuiService_upv_1.SelectedObject) then
        return
    end
    local v13
    if u1 then
        local _ = tbl_upv_2[u1]
        v13 = tbl_upv_2[u1] and tbl_upv_2[u1].select
    else
        local _ = tbl_upv_7[#tbl_upv_7]
        v13 = tbl_upv_7[#tbl_upv_7] and tbl_upv_7[#tbl_upv_7].select
    end
    if not v13 then
        return
    end
    local success_2, v16 = pcall(v13)
    if not success_2 then
        return
    end
    if usable(v16) then
        GuiService_upv_1.SelectedObject = v16
    end
end
local u9 = false
local u10 = 0
local tbl_upv_8 = {}
local tbl_upv_9 = {}
local function characterContexts()
    --[[
      name: characterContexts
      line: 243
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local tbl_10 = {}
    local tbl_11 = {Players_upv_1.LocalPlayer, game:GetService("StarterPlayer"):FindFirstChild("PlayerModule")}
    for _, value_1 in tbl_11 do
        local v17 = value_1 and (value_1:FindFirstChild("InputContexts"))
        local v18 = v17 and (v17:FindFirstChild("CharacterContext"))
        if not (v18) then
            continue
        end
        if v18:IsA("InputContext") then
            table.insert(tbl_10, v18)
        end
    end
    return tbl_10
end
local function setWalk(a1)
    --[[
      name: setWalk
      line: 255
      upvalues:
        tbl_upv_9 (copy, index: 1)
        characterContexts (copy, index: 2)
    ]]
    if a1 then
        for key_1 in tbl_upv_9 do
            if key_1.Parent then
                key_1.Enabled = true
            end
        end
        table.clear(tbl_upv_9)
    else
        for _, value_2 in characterContexts() do
            if value_2.Enabled then
                value_2.Enabled = false
                tbl_upv_9[value_2] = true
            end
        end
    end
end
local function applyPadBlock(a1)
    --[[
      name: applyPadBlock
      line: 272
      upvalues:
        u9 (ref,  index: 1)
        Keybinds_upv_1 (copy, index: 2)
        setWalk (copy, index: 3)
        Players_upv_1 (copy, index: 4)
    ]]
    if a1 == u9 then
        return
    end
    u9 = a1
    Keybinds_upv_1.SetPadBlocked(a1)
    setWalk(not a1)
    Players_upv_1.LocalPlayer:SetAttribute("PadMenu", a1)
end
local function refreshPadBlock()
    --[[
      name: refreshPadBlock
      line: 281
      upvalues:
        UI_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        tbl_upv_7 (copy, index: 3)
        u8 (ref,  index: 4)
        u10 (ref,  index: 5)
        u9 (ref,  index: 6)
        Keybinds_upv_1 (copy, index: 7)
        characterContexts (copy, index: 8)
        tbl_upv_9 (copy, index: 9)
        Players_upv_1 (copy, index: 10)
        tbl_upv_8 (copy, index: 11)
    ]]
    local u11 = UI_upv_1.Gamepad
    if u11 then
        local v19 = true
        if u1 ~= nil then
            u11 = v19
        else
            local v20 = true
            if tbl_upv_7[#tbl_upv_7] ~= nil then
                u11 = v20
            else
                local v21 = u8
                u11 = v21
            end
        end
    end
    u10 = u10 + 1
    if u11 then
        if u9 == true then
            return
        end
        u9 = true
        Keybinds_upv_1.SetPadBlocked(true)
        for _, value_3 in characterContexts() do
            if value_3.Enabled then
                value_3.Enabled = false
                tbl_upv_9[value_3] = true
            end
        end
        Players_upv_1.LocalPlayer:SetAttribute("PadMenu", true)
    elseif u9 then
        u11 = u10
        task.spawn(
            function()
                --[[
                  line: 292
                  upvalues:
                    tbl_upv_8 (copy, index: 1)
                    u11 (copy, index: 2)
                    u10 (ref,  index: 3)
                    u9 (ref,  index: 4)
                    Keybinds_upv_1 (copy, index: 5)
                    tbl_upv_9 (copy, index: 6)
                    Players_upv_1 (copy, index: 7)
                ]]
                local v22 = os.clock()
                while true do
                    if not (tbl_upv_8[Enum.KeyCode.ButtonA]) and not (tbl_upv_8[Enum.KeyCode.ButtonB]) or not (os.clock() - v22 < 3) then
                        break
                    end
                    task.wait()
                end
                task.wait(0.05)
                if u11 ~= u10 or u9 == false then
                    return
                end
                u9 = false
                Keybinds_upv_1.SetPadBlocked(false)
                for key_2 in tbl_upv_9 do
                    if key_2.Parent then
                        key_2.Enabled = true
                    end
                end
                table.clear(tbl_upv_9)
                Players_upv_1.LocalPlayer:SetAttribute("PadMenu", false)
            end
        )
        return
    end
end
function tbl_upv_1.PadBlocked()
    --[[
      name: PadBlocked
      line: 303
      upvalues:
        u9 (ref, index: 1)
    ]]
    return u9
end
local function endHudFocus(a1)
    --[[
      name: endHudFocus
      line: 307
      upvalues:
        u8 (ref,  index: 1)
        GuiService_upv_1 (copy, index: 2)
        refreshPadBlock (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if not u8 then
        return
    end
    u8 = false
    if a1 then
        GuiService_upv_1.SelectedObject = nil
    end
    refreshPadBlock()
    tbl_upv_1.FocusChanged:Fire()
end
function tbl_upv_1.PushFocus(a1, a2, a3)
    --[[
      name: PushFocus
      line: 321
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_7 (copy, index: 2)
        u8 (ref,  index: 3)
        refreshPadBlock (copy, index: 4)
        u1 (ref,  index: 5)
        selectOwner (copy, index: 6)
    ]]
    tbl_upv_1.PopFocus(a1, true)
    table.insert(tbl_upv_7, {key = a1, select = a2, back = a3, at = os.clock()})
    if u8 then
        u8 = false
        refreshPadBlock()
        tbl_upv_1.FocusChanged:Fire()
    end
    if not (u1) then
        selectOwner()
    end
    refreshPadBlock()
    tbl_upv_1.FocusChanged:Fire()
end
function tbl_upv_1.PopFocus(a1, a2)
    --[[
      name: PopFocus
      line: 331
      upvalues:
        tbl_upv_7 (copy, index: 1)
        u1 (ref,  index: 2)
        GuiService_upv_1 (copy, index: 3)
        selectOwner (copy, index: 4)
        refreshPadBlock (copy, index: 5)
        tbl_upv_1 (copy, index: 6)
    ]]
    for key_3, value_4 in tbl_upv_7 do
        if value_4.key == a1 then
            table.remove(tbl_upv_7, key_3)
            if not (a2) then
                if not (u1) then
                    GuiService_upv_1.SelectedObject = nil
                    selectOwner()
                end
                refreshPadBlock()
                tbl_upv_1.FocusChanged:Fire()
            end
            return
        end
    end
end
function tbl_upv_1.HasFocus(a1)
    --[[
      name: HasFocus
      line: 347
      upvalues:
        tbl_upv_7 (copy, index: 1)
    ]]
    if a1 ~= nil then
        for _, value_5 in tbl_upv_7 do
            if value_5.key ~= a1 then
                continue
            end
            return true
        end
        return false
    end
    return tbl_upv_7[#tbl_upv_7] ~= nil
end
function tbl_upv_1.Reselect()
    --[[
      name: Reselect
      line: 359
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_7 (copy, index: 2)
        selectOwner (copy, index: 3)
    ]]
    if not u1 and not tbl_upv_7[#tbl_upv_7] then
        return
    end
    selectOwner(true)
end
function tbl_upv_1.HudFocus(a1)
    --[[
      name: HudFocus
      line: 366
      upvalues:
        UI_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
        tbl_upv_7 (copy, index: 3)
        usable (copy, index: 4)
        u8 (ref,  index: 5)
        GuiService_upv_1 (copy, index: 6)
        refreshPadBlock (copy, index: 7)
        tbl_upv_1 (copy, index: 8)
    ]]
    if UI_upv_1.Gamepad and not (u1) and not (tbl_upv_7[#tbl_upv_7]) and usable(a1) then
        u8 = true
        GuiService_upv_1.SelectedObject = a1
        refreshPadBlock()
        tbl_upv_1.FocusChanged:Fire()
        return true
    end
    return false
end
function tbl_upv_1.EndHudFocus()
    --[[
      name: EndHudFocus
      line: 376
      upvalues:
        u8 (ref,  index: 1)
        GuiService_upv_1 (copy, index: 2)
        refreshPadBlock (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if not u8 then
        return
    end
    u8 = false
    GuiService_upv_1.SelectedObject = nil
    refreshPadBlock()
    tbl_upv_1.FocusChanged:Fire()
end
function tbl_upv_1.HudFocused()
    --[[
      name: HudFocused
      line: 379
      upvalues:
        u8 (ref, index: 1)
    ]]
    return u8
end
function tbl_upv_1.Register(a1, a2)
    --[[
      name: Register
      line: 383
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    tbl_upv_2[a1] = a2
end
local u12 = nil
function tbl_upv_1.SetLoader(a1)
    --[[
      name: SetLoader
      line: 388
      upvalues:
        u12 (ref, index: 1)
    ]]
    u12 = a1
end
function tbl_upv_1.IsOpen(a1)
    --[[
      name: IsOpen
      line: 392
      upvalues:
        u1 (ref, index: 1)
    ]]
    if a1 ~= nil then
        local v23 = u1 == a1
        return v23
    else
        local v24 = u1 ~= nil
        return v24
    end
end
function tbl_upv_1.Current()
    --[[
      name: Current
      line: 399
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
local u13 = -math.huge
function tbl_upv_1.RecentlyOpen(a1)
    --[[
      name: RecentlyOpen
      line: 405
      upvalues:
        u1 (ref, index: 1)
        u13 (ref, index: 2)
    ]]
    local v25 = true
    if u1 == nil then
        v25 = os.clock() - u13 < (a1 or 0.2)
    end
    return v25
end
function tbl_upv_1.Close(a1, a2)
    --[[
      name: Close
      line: 409
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        u13 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        setBlur (copy, index: 5)
        tbl_upv_3 (copy, index: 6)
        applyMouse (copy, index: 7)
        GuiService_upv_1 (copy, index: 8)
        selectOwner (copy, index: 9)
        refreshPadBlock (copy, index: 10)
    ]]
    local v26 = a1 or u1
    if not v26 then
        return
    end
    if v26 == u1 then
        local v27 = tbl_upv_2[v26]
        u1 = nil
        u13 = os.clock()
        if v27 then
            local success_3, v28 = pcall(v27.close, a2)
            if not (success_3) then
                warn("[UI] menu " .. v26 .. " failed to close: " .. tostring(v28))
            end
        end
        tbl_upv_1.HoldChat("menu", false)
        setBlur(false)
        tbl_upv_3.Menu = nil
        applyMouse()
        GuiService_upv_1.SelectedObject = nil
        selectOwner()
        refreshPadBlock()
        tbl_upv_1.Changed:Fire(nil)
    end
end
function tbl_upv_1.Open(a1, ...)
    --[[
      name: Open
      line: 436
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u12 (ref,  index: 2)
        u1 (ref,  index: 3)
        tbl_upv_1 (copy, index: 4)
        u8 (ref,  index: 5)
        refreshPadBlock (copy, index: 6)
        GuiService_upv_1 (copy, index: 7)
        setBlur (copy, index: 8)
        tbl_upv_3 (copy, index: 9)
        applyMouse (copy, index: 10)
        selectOwner (copy, index: 11)
    ]]
    local v29 = tbl_upv_2[a1]
    if not (v29) and u12 then
        u12(a1)
        v29 = tbl_upv_2[a1]
    end
    if v29 then
        if u1 ~= a1 then
            tbl_upv_1.HoldChat("menu", true)
            if u1 then
                local v30 = tbl_upv_2[u1]
                u1 = nil
                if v30 then
                    v30.close(true)
                end
            end
            u1 = a1
            if u8 then
                u8 = false
                refreshPadBlock()
                tbl_upv_1.FocusChanged:Fire()
            end
            GuiService_upv_1.SelectedObject = nil
            v29.open(...)
            local v31
            if v29.blur ~= false then
                v31 = true
            else
                v31 = false
            end
            setBlur(v31)
            tbl_upv_3.Menu = true
            applyMouse()
            selectOwner(true)
            refreshPadBlock()
            tbl_upv_1.Changed:Fire(a1)
        else
            v29.open(...)
        end
    else
        warn("[UI] unknown menu " .. a1)
    end
end
function tbl_upv_1.Toggle(a1, ...)
    --[[
      name: Toggle
      line: 471
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if u1 ~= a1 then
        tbl_upv_1.Open(a1, ...)
    else
        tbl_upv_1.Close(a1)
    end
end
function tbl_upv_1.CloseAll(a1)
    --[[
      name: CloseAll
      line: 479
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if not u1 then
        return
    end
    tbl_upv_1.Close(u1, a1)
end
function tbl_upv_1.Back()
    --[[
      name: Back
      line: 487
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        tbl_upv_7 (copy, index: 4)
        u8 (ref,  index: 5)
        GuiService_upv_1 (copy, index: 6)
        refreshPadBlock (copy, index: 7)
    ]]
    local v32, v33 = nil, nil
    if u1 then
        v32 = tbl_upv_2[u1]
        if v32 and v32.back then
            local success_4, v34 = pcall(v32.back)
            if success_4 and v34 then
                return true
            end
        end
        tbl_upv_1.Close(u1)
        return true
    end
    v33 = tbl_upv_7[#tbl_upv_7]
    if v33 then
        if not v33.back then
            return false
        end
        local success_5, v35 = pcall(v33.back)
        return success_5 and (v35 == true)
    elseif u8 then
        if u8 then
            u8 = false
            GuiService_upv_1.SelectedObject = nil
            refreshPadBlock()
            tbl_upv_1.FocusChanged:Fire()
        end
        return true
    else
        return false
    end
end
Keybinds_upv_1.OnInput(
    "Began",
    function(a1)
        --[[
          line: 514
          upvalues:
            tbl_upv_8 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        local KeyCode_1 = a1.KeyCode
        if KeyCode_1 == Enum.KeyCode.ButtonA or KeyCode_1 == Enum.KeyCode.ButtonB then
            tbl_upv_8[KeyCode_1] = true
        end
        if KeyCode_1 ~= Enum.KeyCode.ButtonB then
            return
        end
        tbl_upv_1.Back()
    end
)
Keybinds_upv_1.OnInput(
    "Ended",
    function(a1)
        --[[
          line: 523
          upvalues:
            tbl_upv_8 (copy, index: 1)
        ]]
        local KeyCode_2 = a1.KeyCode
        if KeyCode_2 ~= Enum.KeyCode.ButtonA and KeyCode_2 ~= Enum.KeyCode.ButtonB then
            return
        end
        tbl_upv_8[KeyCode_2] = nil
    end
)
Keybinds_upv_1.OnInput(
    "Changed",
    function(a1)
        --[[
          line: 530
          upvalues:
            u8 (ref,  index: 1)
            GuiService_upv_1 (copy, index: 2)
            refreshPadBlock (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
        ]]
        if not u8 or a1.KeyCode ~= Enum.KeyCode.Thumbstick1 or not (a1.Position.Magnitude > 0.6) or not u8 then
            return
        end
        u8 = false
        GuiService_upv_1.SelectedObject = nil
        refreshPadBlock()
        tbl_upv_1.FocusChanged:Fire()
    end
)
GuiService_upv_1:GetPropertyChangedSignal("SelectedObject"):Connect(
    function()
        --[[
          line: 536
          upvalues:
            GuiService_upv_1 (copy, index: 1)
            u8 (ref,  index: 2)
            refreshPadBlock (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u1 (ref,  index: 6)
            tbl_upv_7 (copy, index: 7)
        ]]
        if GuiService_upv_1.SelectedObject ~= nil then
            return
        end
        if u8 then
            if not u8 then
                return
            end
            u8 = false
            refreshPadBlock()
            tbl_upv_1.FocusChanged:Fire()
        elseif UI_upv_1.Gamepad and (u1 or tbl_upv_7[#tbl_upv_7]) then
            task.defer(tbl_upv_1.Reselect)
        end
    end
)
local u14 = 0
task.spawn(
    function()
        --[[
          line: 550
          upvalues:
            u8 (ref,  index: 1)
            usable (copy, index: 2)
            GuiService_upv_1 (copy, index: 3)
            Players_upv_1 (copy, index: 4)
            refreshPadBlock (copy, index: 5)
            tbl_upv_1 (copy, index: 6)
            u1 (ref,  index: 7)
            tbl_upv_7 (copy, index: 8)
            u14 (ref,  index: 9)
        ]]
        task.wait(0.5)
        local v36 = nil
        if u8 then
            if usable(GuiService_upv_1.SelectedObject) then
                if Players_upv_1.LocalPlayer:GetAttribute("State") == "Match" and u8 then
                    u8 = false
                    GuiService_upv_1.SelectedObject = nil
                    refreshPadBlock()
                    tbl_upv_1.FocusChanged:Fire()
                    v36 = u1 or tbl_upv_7[#tbl_upv_7]
                    if v36 then
                        local success_6, v37 = pcall(v36.select)
                        if success_6 and usable(v37) then
                            u14 = 0
                        else
                            u14 = u14 + 1
                            if not (u14 >= 4) then
                                return
                            end
                            u14 = 0
                            tbl_upv_1.PopFocus(v36.key)
                        end
                    else
                        u14 = 0
                    end
                else
                    v36 = u1 or tbl_upv_7[#tbl_upv_7]
                    if v36 then
                        local success_6, v37 = pcall(v36.select)
                        if success_6 and usable(v37) then
                            u14 = 0
                        else
                            u14 = u14 + 1
                            if not (u14 >= 4) then
                                return
                            end
                            u14 = 0
                            tbl_upv_1.PopFocus(v36.key)
                        end
                    else
                        u14 = 0
                    end
                end
            elseif u8 then
                u8 = false
                GuiService_upv_1.SelectedObject = nil
                refreshPadBlock()
                tbl_upv_1.FocusChanged:Fire()
                v36 = u1 or tbl_upv_7[#tbl_upv_7]
                if v36 then
                    local success_6, v37 = pcall(v36.select)
                    if success_6 and usable(v37) then
                        u14 = 0
                    else
                        u14 = u14 + 1
                        if not (u14 >= 4) then
                            return
                        end
                        u14 = 0
                        tbl_upv_1.PopFocus(v36.key)
                    end
                else
                    u14 = 0
                end
            else
                v36 = u1 or tbl_upv_7[#tbl_upv_7]
                if v36 then
                    local success_6, v37 = pcall(v36.select)
                    if success_6 and usable(v37) then
                        u14 = 0
                    else
                        u14 = u14 + 1
                        if not (u14 >= 4) then
                            return
                        end
                        u14 = 0
                        tbl_upv_1.PopFocus(v36.key)
                    end
                else
                    u14 = 0
                end
            end
        else
            v36 = u1 or tbl_upv_7[#tbl_upv_7]
            if v36 then
                local success_6, v37 = pcall(v36.select)
                if success_6 and usable(v37) then
                    u14 = 0
                else
                    u14 = u14 + 1
                    if not (u14 >= 4) then
                        return
                    end
                    u14 = 0
                    tbl_upv_1.PopFocus(v36.key)
                end
            else
                u14 = 0
            end
        end
    end
)
UI_upv_1.GamepadChanged:Connect(
    function(a1)
        --[[
          line: 575
          upvalues:
            selectOwner (copy, index: 1)
            u8 (ref,  index: 2)
            GuiService_upv_1 (copy, index: 3)
            refreshPadBlock (copy, index: 4)
        ]]
        if a1 then
            selectOwner(true)
        else
            u8 = false
            GuiService_upv_1.SelectedObject = nil
        end
        refreshPadBlock()
    end
)
function tbl_upv_1.Reasons()
    --[[
      name: Reasons
      line: 586
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local tbl_12 = {}
    for key_4 in tbl_upv_3 do
        table.insert(tbl_12, key_4)
    end
    table.sort(tbl_12)
    return tbl_12
end
RunService_1:BindToRenderStep(
    "TribesUIMouse",
    Enum.RenderPriority.Camera.Value + 5,
    function()
        --[[
          line: 597
          upvalues:
            tbl_upv_3 (copy, index: 1)
            u1 (ref,  index: 2)
            applyMouse (copy, index: 3)
            u2 (ref,  index: 4)
            tbl_upv_1 (copy, index: 5)
            UserInputService_upv_1 (copy, index: 6)
        ]]
        if tbl_upv_3.Menu and u1 == nil then
            tbl_upv_3.Menu = nil
            applyMouse()
        end
        if u2 then
            local v38 = tbl_upv_1.Camera()
            if not (v38) then
                UserInputService_upv_1.MouseBehavior = Enum.MouseBehavior.Default
            end
            UserInputService_upv_1.MouseIconEnabled = true
        end
    end
)
return tbl_upv_1