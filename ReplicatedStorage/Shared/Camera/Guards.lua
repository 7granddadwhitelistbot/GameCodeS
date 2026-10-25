local GuiService_upv_1 = game:GetService("GuiService")
local Players_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_upv_1 = {}
local u1 = nil
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u2 = 0
local u3 = nil
local u4 = nil
local tbl_upv_4 = {}
local tbl_upv_5 = {}
setmetatable(tbl_upv_5, {__mode = "k"})
local u5 = nil
local UserInputType_upv_1 = nil
local u6 = 0
local u7 = false
local u8 = true
local function note(a1)
    --[[
      name: note
      line: 64
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    tbl_upv_4[a1] = (tbl_upv_4[a1] or 0) + 1
end
local function onScreen(a1)
    --[[
      name: onScreen
      line: 82
    ]]
    local success_1, v1 = pcall(function() end)
    if success_1 then
        return v1 == true
    end
    return true
end
local function clearTouches(a1)
    --[[
      name: clearTouches
      line: 99
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    if not u1 then
        return
    end
    if next(u1.touches) ~= nil then
        table.clear(u1.touches)
        local v2 = "touches:" .. a1
        tbl_upv_4[v2] = (tbl_upv_4[v2] or 0) + 1
    end
end
function tbl_upv_1.PruneTouches(a1)
    --[[
      name: PruneTouches
      line: 108
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local v3 = 0
    for key_1 in a1 do
        local UserInputState_1 = key_1.UserInputState
        if UserInputState_1 == Enum.UserInputState.End then
            a1[key_1] = nil
            tbl_upv_4["touches:ended"] = (tbl_upv_4["touches:ended"] or 0) + 1
            continue
        end
        if UserInputState_1 ~= Enum.UserInputState.Cancel then
            v3 = v3 + 1
        else
            a1[key_1] = nil
            tbl_upv_4["touches:ended"] = (tbl_upv_4["touches:ended"] or 0) + 1
        end
    end
    return v3
end
function tbl_upv_1.LockPushed(a1, a2)
    --[[
      name: LockPushed
      line: 123
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    tbl_upv_2[a1] = os.clock()
    local v4
    if typeof(a2) ~= "number" then
        v4 = 10
    else
        v4 = a2
    end
    tbl_upv_3[a1] = math.clamp(v4, 0.1, 10)
end
function tbl_upv_1.LockPopped(a1)
    --[[
      name: LockPopped
      line: 128
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    tbl_upv_2[a1] = nil
    tbl_upv_3[a1] = nil
end
function tbl_upv_1.SetChatConfig(a1)
    --[[
      name: SetChatConfig
      line: 133
      upvalues:
        u4 (ref, index: 1)
    ]]
    u4 = a1
end
function tbl_upv_1.FreeKeyDown(a1)
    --[[
      name: FreeKeyDown
      line: 138
      upvalues:
        u5 (ref, index: 1)
        UserInputType_upv_1 (ref, index: 2)
        u6 (ref, index: 3)
        u7 (ref, index: 4)
        u8 (ref, index: 5)
    ]]
    local v5 = os.clock()
    local v6 = u8
    u5 = a1.KeyCode
    UserInputType_upv_1 = a1.UserInputType
    u6 = v5
    u7 = v6
end
function tbl_upv_1.FreeKeyUp()
    --[[
      name: FreeKeyUp
      line: 142
      upvalues:
        u5 (ref, index: 1)
        u7 (ref, index: 2)
        u8 (ref, index: 3)
        u6 (ref, index: 4)
    ]]
    local v7 = (u5 ~= nil) and (u7 and (u8 and (os.clock() - u6 <= 1)))
    u5 = nil
    return v7
end
function tbl_upv_1.FreeKeyCancel()
    --[[
      name: FreeKeyCancel
      line: 148
      upvalues:
        u5 (ref, index: 1)
    ]]
    u5 = nil
end
function tbl_upv_1.Blockers()
    --[[
      name: Blockers
      line: 153
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 then
        return (u1.blockers())
    end
    return {}
end
local function matchPhase()
    --[[
      name: matchPhase
      line: 69
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
    ]]
    if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" then
        return "none"
    end
    local v8 = LocalPlayer_upv_1:GetAttribute("MatchId")
    local Arenas_1 = Workspace_upv_1:FindFirstChild("Arenas")
    local v9
    if Arenas_1 then
        if type(v8) ~= "string" or v8 == "" then
            v9 = nil
        else
            v9 = Arenas_1:FindFirstChild(v8)
        end
    else
        v9 = nil
    end
    local v10 = v9 and (v9:GetAttribute("Phase"))
    if type(v10) ~= "string" then
        return nil
    end
    return v10
end
local function pass(a1)
    --[[
      name: pass
      line: 158
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        matchPhase (copy, index: 6)
        UserInputService_upv_1 (copy, index: 7)
        tbl_upv_5 (copy, index: 8)
        u4 (ref,  index: 9)
        u3 (ref,  index: 10)
        LocalPlayer_upv_1 (copy, index: 11)
    ]]
    local v11 = nil
    local u9 = false
    local v12 = nil
    for key_2 in u1.lookLocks do
        v12 = tbl_upv_2[key_2]
        if v12 == nil then
            tbl_upv_1.LockPushed(key_2)
            v12 = tbl_upv_2[key_2]
        end
        local v13 = a1 - v12
        if (tbl_upv_3[key_2] or 10) < v13 then
            local v14 = "lock:" .. key_2 .. ":timeout"
            tbl_upv_4[v14] = (tbl_upv_4[v14] or 0) + 1
            u1.popLookLock(key_2)
            continue
        end
        if key_2 ~= "Intro" or not (v13 > 0.5) then
            continue
        end
        if not u9 then
            v11, u9 = matchPhase(), true
        end
        if v11 == nil or v11 == "Intro" then
            continue
        end
        if v11 ~= "Loading" then
            local v15 = "lock:Intro:" .. tostring(v11)
            tbl_upv_4[v15] = (tbl_upv_4[v15] or 0) + 1
            u1.popLookLock(key_2)
        end
    end
    if u1.unlockReasons.TextBox then
        u9 = UserInputService_upv_1:GetFocusedTextBox()
        if u9 then
            local success_2, v16 = pcall(
                function()
                    --[[
                      line: 83
                      upvalues:
                        u9 (copy, index: 1)
                    ]]
                    while u9 do
                        if not (u9:IsA("GuiObject")) or u9.Visible then
                            if not (u9:IsA("LayerCollector")) then
                                continue
                            end
                            return u9.Enabled and (u9.Parent ~= nil)
                        end
                        return false
                    end
                    return false
                end
            )
            local v17
            if success_2 then
                v17 = v16 == true
            else
                v17 = true
            end
            if not (v17) then
                if a1 - (tbl_upv_5[u9] or -math.huge) >= 1 then
                    tbl_upv_5[u9] = a1
                    pcall(
                        function()
                            --[[
                              line: 192
                              upvalues:
                                u9 (copy, index: 1)
                            ]]
                            u9:ReleaseFocus()
                        end
                    )
                end
                tbl_upv_4["unlock:TextBox:hidden"] = (tbl_upv_4["unlock:TextBox:hidden"] or 0) + 1
                u1.popUnlock("TextBox")
            end
        else
            tbl_upv_4["unlock:TextBox:none"] = (tbl_upv_4["unlock:TextBox:none"] or 0) + 1
            u1.popUnlock("TextBox")
        end
    end
    if u1.unlockReasons.ChatFocus then
        v11 = u4
        if v11 and v11.Parent and not (v11.IsFocused) then
            tbl_upv_4["unlock:ChatFocus"] = (tbl_upv_4["unlock:ChatFocus"] or 0) + 1
            u1.popUnlock("ChatFocus")
        end
    end
    tbl_upv_1.PruneTouches(u1.touches)
    local v18 = table.concat(u1.blockers(), " ")
    if v18 == u3 then
        return
    end
    u3 = v18
    LocalPlayer_upv_1:SetAttribute("CameraLookBlock", v18)
end
function tbl_upv_1.Step()
    --[[
      name: Step
      line: 219
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        pass (copy, index: 3)
    ]]
    if not u1 then
        return
    end
    local v19 = os.clock()
    if (v19 - u2 < 0.25) then
        return
    end
    u2 = v19
    pass(v19)
end
function tbl_upv_1.Stats()
    --[[
      name: Stats
      line: 232
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    return table.clone(tbl_upv_4)
end
local u10 = false
function tbl_upv_1.Start(a1)
    --[[
      name: Start
      line: 237
      upvalues:
        u1 (ref,  index: 1)
        u10 (ref,  index: 2)
        UserInputService_upv_1 (copy, index: 3)
        u5 (ref,  index: 4)
        UserInputType_upv_1 (ref,  index: 5)
        u7 (ref,  index: 6)
        u8 (ref,  index: 7)
        tbl_upv_4 (copy, index: 8)
        GuiService_upv_1 (copy, index: 9)
    ]]
    u1 = a1
    if u10 then
        return
    end
    u10 = true
    UserInputService_upv_1.InputBegan:Connect(
        function(a2)
            --[[
              line: 244
              upvalues:
                u5 (ref, index: 1)
                UserInputType_upv_1 (ref, index: 2)
                u7 (ref, index: 3)
            ]]
            if u5 == nil then
                return
            end
            local UserInputType_2 = a2.UserInputType
            if UserInputType_2 == UserInputType_upv_1 and (UserInputType_2 ~= Enum.UserInputType.Keyboard or a2.KeyCode == u5) or UserInputType_2 ~= Enum.UserInputType.Keyboard and UserInputType_2 ~= Enum.UserInputType.MouseButton1 and UserInputType_2 ~= Enum.UserInputType.MouseButton2 and UserInputType_2 ~= Enum.UserInputType.MouseButton3 then
                return
            end
            u7 = false
        end
    )
    UserInputService_upv_1.WindowFocusReleased:Connect(
        function()
            --[[
              line: 257
              upvalues:
                u8 (ref,  index: 1)
                u5 (ref,  index: 2)
                u1 (ref,  index: 3)
                tbl_upv_4 (copy, index: 4)
            ]]
            u8 = false
            u5 = nil
            if u1 and next(u1.touches) ~= nil then
                table.clear(u1.touches)
                tbl_upv_4["touches:focus"] = (tbl_upv_4["touches:focus"] or 0) + 1
            end
            if not u1 or not u1.unlockReasons.FreeCursor then
                return
            end
            tbl_upv_4["unlock:FreeCursor:focus"] = (tbl_upv_4["unlock:FreeCursor:focus"] or 0) + 1
            u1.popUnlock("FreeCursor")
        end
    )
    UserInputService_upv_1.WindowFocused:Connect(
        function()
            --[[
              line: 267
              upvalues:
                u8 (ref, index: 1)
            ]]
            u8 = true
        end
    )
    GuiService_upv_1.MenuOpened:Connect(
        function()
            --[[
              line: 270
              upvalues:
                u5 (ref,  index: 1)
                u1 (ref,  index: 2)
                tbl_upv_4 (copy, index: 3)
            ]]
            u5 = nil
            if not u1 or next(u1.touches) == nil then
                return
            end
            table.clear(u1.touches)
            tbl_upv_4["touches:menu"] = (tbl_upv_4["touches:menu"] or 0) + 1
        end
    )
end
return tbl_upv_1