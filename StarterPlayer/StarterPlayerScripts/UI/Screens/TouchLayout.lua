local GuiService_upv_1 = game:GetService("GuiService")
local _ = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local StarterGui_upv_1 = game:GetService("StarterGui")
local TextChatService_upv_1 = game:GetService("TextChatService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local tbl_1 = {}
local u1 = nil
local function hideChat()
    --[[
      name: hideChat
      line: 33
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 then
        return
    end
    local tbl_2 = {}
    pcall(function() end)
    u1 = tbl_2
end
local function restoreChat()
    --[[
      name: restoreChat
      line: 54
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v1 = u1
    if not v1 then
        return
    end
    u1 = nil
    pcall(function() end)
end
local tbl_upv_3 = {{root = "Root", label = "ATTACK", name = "Attack", gui = "CombatTouch"}, {root = "Root", label = "ALT", name = "Secondary", gui = "CombatTouch"}, {root = "Root", label = "RELOAD", name = "Reload", gui = "CombatTouch"}, {root = "Buttons", label = "JUMP", name = "Jump", gui = "CharacterTouch"}, {root = "Buttons", label = "SLIDE", name = "Slide", gui = "CharacterTouch"}, {root = "Buttons", label = "1P / 3P", name = "View", gui = "CharacterTouch"}}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 89
      upvalues:
        tbl_upv_3 (copy, index: 2)
        GuiService_upv_1 (copy, index: 3)
        u1 (ref,  index: 4)
        TextChatService_upv_1 (copy, index: 5)
        StarterGui_upv_1 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
        UserInputService_upv_1 (copy, index: 8)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local PlayerGui_upv_1 = a1.PlayerGui
    local function guiOf(a2)
        --[[
          name: guiOf
          line: 95
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
        ]]
        local v2 = PlayerGui_upv_1:FindFirstChild(a2.gui)
        if v2 and v2:IsA("ScreenGui") then
            return v2
        end
        return nil
    end
    local function buttonOf(a3)
        --[[
          name: buttonOf
          line: 99
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
        ]]
        local v3 = PlayerGui_upv_1:FindFirstChild(a3.gui)
        local v4 = not (v3) or not (v3:IsA("ScreenGui")) or v3
        local v5 = v4 and (v4:FindFirstChild(a3.root))
        v4 = v5 and (v5:FindFirstChild(a3.name))
        if v4 and v4:IsA("GuiObject") then
            return v4
        end
        return nil
    end
    local u2 = false
    local function savedValue(a4)
        --[[
          name: savedValue
          line: 108
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v6 = State_upv_1.Profile and (State_upv_1.Profile.settings)
        local v7 = false
        if type(v6) == "table" then
            v7 = v6["touch_" .. a4]
        end
        if type(v7) ~= "string" then
            return ""
        end
        return v7
    end
    local function applySaved()
        --[[
          name: applySaved
          line: 113
          upvalues:
            u2 (ref,  index: 1)
            tbl_upv_3 (copy, index: 2)
            PlayerGui_upv_1 (copy, index: 3)
            State_upv_1 (copy, index: 4)
        ]]
        if u2 then
            return
        end
        local v8, v9, v10 = nil, nil, nil
        local v11 = nil
        for _, value_1 in tbl_upv_3 do
            v11 = PlayerGui_upv_1:FindFirstChild(value_1.gui)
            if not (v11) or not (v11:IsA("ScreenGui")) then
                v8 = nil
                if not (v8) then
                    continue
                end
                v10 = value_1.name
                local v12 = State_upv_1.Profile and (State_upv_1.Profile.settings)
                v9 = false
                if type(v12) == "table" then
                    v9 = v12["touch_" .. v10]
                end
                if type(v9) ~= "string" then
                    v11 = ""
                else
                    v11 = v9
                end
                if v11 == "" then
                    v10 = nil
                else
                    v10 = v11
                end
                if v8:GetAttribute("Override_" .. value_1.name) ~= v10 then
                    v8:SetAttribute("Override_" .. value_1.name, v10)
                    continue
                end
            end
            v8 = v11
            if not (v8) then
                continue
            end
            v10 = value_1.name
            local v12 = State_upv_1.Profile and (State_upv_1.Profile.settings)
            v9 = false
            if type(v12) == "table" then
                v9 = v12["touch_" .. v10]
            end
            if type(v9) ~= "string" then
                v11 = ""
            else
                v11 = v9
            end
            if v11 == "" then
                v10 = nil
            else
                v10 = v11
            end
            if v8:GetAttribute("Override_" .. value_1.name) ~= v10 then
                v8:SetAttribute("Override_" .. value_1.name, v10)
            end
        end
    end
    State_upv_1.ProfileChanged:Connect(applySaved)
    PlayerGui_upv_1.ChildAdded:Connect(
        function(a5)
            --[[
              line: 129
              upvalues:
                applySaved (copy, index: 1)
            ]]
            if a5.Name ~= "CombatTouch" and a5.Name ~= "CharacterTouch" then
                return
            end
            task.defer(applySaved)
        end
    )
    task.defer(applySaved)
    local u3 = nil
    local u4 = nil
    local tbl_upv_4 = {}
    local tbl_upv_5 = {}
    local tbl_upv_6 = {}
    local u5 = nil
    local u6 = nil
    local u7 = ""
    local u8 = 0
    local function rootSize()
        --[[
          name: rootSize
          line: 148
          upvalues:
            u4 (ref, index: 1)
        ]]
        return u4.AbsoluteSize
    end
    local function encode(a6, a7)
        --[[
          name: encode
          line: 154
          upvalues:
            u4 (ref, index: 1)
        ]]
        local AbsoluteSize_1 = u4.AbsoluteSize
        return string.format("%d,%d,%d", math.floor(((a6.x / AbsoluteSize_1.X) * 1000) + 0.5), math.floor(((a6.y / AbsoluteSize_1.Y) * 1000) + 0.5), math.floor(((a6.d / math.max(a7, 1)) * 1000) + 0.5))
    end
    local function readLive()
        --[[
          name: readLive
          line: 172
          upvalues:
            u4 (ref,  index: 1)
            tbl_upv_3 (copy, index: 2)
            PlayerGui_upv_1 (copy, index: 3)
            tbl_upv_5 (copy, index: 4)
        ]]
        local v13, v14 = nil, nil
        for _, value_2 in tbl_upv_3 do
            local v15 = PlayerGui_upv_1:FindFirstChild(value_2.gui)
            if not (v15) or not (v15:IsA("ScreenGui")) then
                v13 = nil
                v15 = v13 and (v13:FindFirstChild(value_2.root))
                v13 = v15 and (v15:FindFirstChild(value_2.name))
                if not (v13) or not (v13:IsA("GuiObject")) then
                    v14 = nil
                    if not (v14) then
                        continue
                    end
                    if v14.AbsoluteSize.X > 4 then
                        v13 = v14.AbsolutePosition + (v14.AbsoluteSize / 2) - u4.AbsolutePosition
                        tbl_upv_5[value_2.name] = {x = v13.X, y = v13.Y, d = v14.AbsoluteSize.X}
                        continue
                    end
                end
                v14 = v13
                if not (v14) then
                    continue
                end
                if v14.AbsoluteSize.X > 4 then
                    v13 = v14.AbsolutePosition + (v14.AbsoluteSize / 2) - u4.AbsolutePosition
                    tbl_upv_5[value_2.name] = {x = v13.X, y = v13.Y, d = v14.AbsoluteSize.X}
                    continue
                end
            end
            v13 = v15
            v15 = v13 and (v13:FindFirstChild(value_2.root))
            v13 = v15 and (v15:FindFirstChild(value_2.name))
            if not (v13) or not (v13:IsA("GuiObject")) then
                v14 = nil
                if not (v14) then
                    continue
                end
                if v14.AbsoluteSize.X > 4 then
                    v13 = v14.AbsolutePosition + (v14.AbsoluteSize / 2) - u4.AbsolutePosition
                    tbl_upv_5[value_2.name] = {x = v13.X, y = v13.Y, d = v14.AbsoluteSize.X}
                    continue
                end
            end
            v14 = v13
            if not (v14) then
                continue
            end
            if v14.AbsoluteSize.X > 4 then
                v13 = v14.AbsolutePosition + (v14.AbsoluteSize / 2) - u4.AbsolutePosition
                tbl_upv_5[value_2.name] = {x = v13.X, y = v13.Y, d = v14.AbsoluteSize.X}
            end
        end
    end
    local u9 = nil
    local X_upv_1 = 0
    local function hotbarRect()
        --[[
          name: hotbarRect
          line: 185
          upvalues:
            u4 (ref,  index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        local AbsoluteSize_2 = u4.AbsoluteSize
        local v16 = ((not (a1.HotbarWidth)) and 404) or (a1.HotbarWidth())
        local v17 = v16 * UI_upv_1.Scale + 16
        local v18 = ((not (a1.HotbarTop)) and 84) or (a1.HotbarTop())
        local v19 = (v18 + 58) * UI_upv_1.Scale
        return Vector2.new((AbsoluteSize_2.X / 2) - (v17 / 2), AbsoluteSize_2.Y - v19), Vector2.new(v17, v19)
    end
    local function hitsBox(a8, a9, a10)
        --[[
          name: hitsBox
          line: 191
        ]]
        local v20 = (Vector2.new(math.clamp(a8.x, a9.X, a9.X + a10.X), math.clamp(a8.y, a9.Y, a9.Y + a10.Y)) - Vector2.new(a8.x, a8.y)).Magnitude < a8.d / 2
        return v20
    end
    local function valid(a11, a12)
        --[[
          name: valid
          line: 196
          upvalues:
            u4 (ref,  index: 1)
            u9 (ref,  index: 2)
            hitsBox (copy, index: 3)
            hotbarRect (copy, index: 4)
            GuiService_upv_1 (copy, index: 5)
            X_upv_1 (ref,  index: 6)
            tbl_upv_5 (copy, index: 7)
            tbl_upv_4 (copy, index: 8)
        ]]
        local AbsoluteSize_3 = u4.AbsoluteSize
        local v21 = a12.d / 2
        if a12.x - v21 < 0 or a12.y - v21 < 0 or AbsoluteSize_3.X < a12.x + v21 or AbsoluteSize_3.Y < a12.y + v21 or u9 and u4 and hitsBox(a12, u9.AbsolutePosition - u4.AbsolutePosition, u9.AbsoluteSize) then
            return false
        end
        local v22, v23 = hotbarRect()
        if hitsBox(a12, v22, v23) then
            return false
        end
        local TopbarInset_1 = GuiService_upv_1.TopbarInset
        X_upv_1 = math.max(X_upv_1, TopbarInset_1.Min.X)
        if TopbarInset_1.Height > 0 and hitsBox(a12, Vector2.zero, Vector2.new(X_upv_1, TopbarInset_1.Max.Y)) then
            return false
        end
        for key_1, value_3 in tbl_upv_5 do
            if key_1 == a11 or not (tbl_upv_4[key_1]) or not (tbl_upv_4[key_1].frame.Visible) or not ((Vector2.new(a12.x, a12.y) - Vector2.new(value_3.x, value_3.y)).Magnitude < (v21 + (value_3.d / 2)) + 6) then
                continue
            end
            return false
        end
        return true
    end
    local function clampInside(a13)
        --[[
          name: clampInside
          line: 228
          upvalues:
            u4 (ref, index: 1)
        ]]
        local AbsoluteSize_4 = u4.AbsoluteSize
        local v24 = a13.d / 2
        local tbl_7 = {}
        tbl_7.x = math.clamp(a13.x, v24, AbsoluteSize_4.X - v24)
        tbl_7.y = math.clamp(a13.y, v24, AbsoluteSize_4.Y - v24)
        tbl_7.d = a13.d
        return tbl_7
    end
    local function snap(a14)
        --[[
          name: snap
          line: 233
        ]]
        return math.floor((a14 / 8) + 0.5) * 8
    end
    local function paintHandles()
        --[[
          name: paintHandles
          line: 237
          upvalues:
            tbl_upv_4 (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
            u5 (ref,  index: 3)
            Colors_upv_1 (copy, index: 4)
            u6 (ref,  index: 5)
            u8 (ref,  index: 6)
            u7 (ref,  index: 7)
        ]]
        local v25 = nil
        for key_2, value_4 in tbl_upv_4 do
            local v26 = tbl_upv_5[key_2]
            value_4.frame.Visible = v26 ~= nil
            if v26 then
                value_4.frame.Position = UDim2.fromOffset(v26.x, v26.y)
                value_4.frame.Size = UDim2.fromOffset(v26.d, v26.d)
            end
            v26 = key_2 == u5
            local stroke_1 = value_4.stroke
            if v26 then
                v25 = Colors_upv_1.Accent
            else
                v25 = Colors_upv_1.Text
            end
            stroke_1.Color = v25
            value_4.stroke.Transparency = (v26 and 0) or 0.35
            value_4.stroke.Thickness = (v26 and 3) or 2
            value_4.knob.Visible = v26
            value_4.frame.BackgroundTransparency = (v26 and 0.8) or 0.9
        end
        if u6 then
            local v27 = u5 and (tbl_upv_5[u5])
            if os.clock() < u8 then
                u6.Text = u7
                u6.TextColor3 = Colors_upv_1.Danger
            else
                u6.Text = not v27 and "TAP A BUTTON" or string.format("%s  \194\183  %d", tbl_upv_4[u5].spec.label, math.floor(v27.d))
                local v29 = u6
                local v30
                if v27 then
                    v30 = Colors_upv_1.Text
                else
                    v30 = Colors_upv_1.TextDim
                end
                v29.TextColor3 = v30
            end
        end
    end
    local function flash(a15)
        --[[
          name: flash
          line: 264
          upvalues:
            u7 (ref,  index: 1)
            u8 (ref,  index: 2)
            paintHandles (copy, index: 3)
        ]]
        local v31 = os.clock() + 1.2
        u7 = a15
        u8 = v31
        paintHandles()
    end
    local function push(a16)
        --[[
          name: push
          line: 158
          upvalues:
            tbl_upv_5 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            PlayerGui_upv_1 (copy, index: 3)
            encode (copy, index: 4)
        ]]
        local v32 = tbl_upv_5[a16]
        local v33, v34, v35, v36 = nil, nil, nil, nil
        for _, value_5 in tbl_upv_3 do
            if value_5.name ~= a16 then
                continue
            end
            v35 = PlayerGui_upv_1:FindFirstChild(value_5.gui)
            if not (v35) or not (v35:IsA("ScreenGui")) then
                v33 = nil
                local v37 = PlayerGui_upv_1:FindFirstChild(value_5.gui)
                if not (v37) or not (v37:IsA("ScreenGui")) then
                    v34 = nil
                    v37 = v34 and (v34:FindFirstChild(value_5.root))
                    v34 = v37 and (v37:FindFirstChild(value_5.name))
                    if not (v34) or not (v34:IsA("GuiObject")) then
                        v35 = nil
                        if not (v33) or not (v35) or not (v32) then
                            continue
                        end
                        v34 = v35:GetAttribute("DefaultSize")
                        local v38 = "Override_" .. a16
                        if type(v34) ~= "number" then
                            v36 = v32.d
                        else
                            v36 = v34
                        end
                        v33:SetAttribute(v38, encode(v32, v36))
                    end
                    v35 = v34
                    if not (v33) or not (v35) or not (v32) then
                        continue
                    end
                    v34 = v35:GetAttribute("DefaultSize")
                    local v38 = "Override_" .. a16
                    if type(v34) ~= "number" then
                        v36 = v32.d
                    else
                        v36 = v34
                    end
                    v33:SetAttribute(v38, encode(v32, v36))
                end
                v34 = v37
                v37 = v34 and (v34:FindFirstChild(value_5.root))
                v34 = v37 and (v37:FindFirstChild(value_5.name))
                if not (v34) or not (v34:IsA("GuiObject")) then
                    v35 = nil
                    if not (v33) or not (v35) or not (v32) then
                        continue
                    end
                    v34 = v35:GetAttribute("DefaultSize")
                    local v38 = "Override_" .. a16
                    if type(v34) ~= "number" then
                        v36 = v32.d
                    else
                        v36 = v34
                    end
                    v33:SetAttribute(v38, encode(v32, v36))
                end
                v35 = v34
                if not (v33) or not (v35) or not (v32) then
                    continue
                end
                v34 = v35:GetAttribute("DefaultSize")
                local v38 = "Override_" .. a16
                if type(v34) ~= "number" then
                    v36 = v32.d
                else
                    v36 = v34
                end
                v33:SetAttribute(v38, encode(v32, v36))
            end
            v33 = v35
            local v37 = PlayerGui_upv_1:FindFirstChild(value_5.gui)
            if not (v37) or not (v37:IsA("ScreenGui")) then
                v34 = nil
                v37 = v34 and (v34:FindFirstChild(value_5.root))
                v34 = v37 and (v37:FindFirstChild(value_5.name))
                if not (v34) or not (v34:IsA("GuiObject")) then
                    v35 = nil
                    if not (v33) or not (v35) or not (v32) then
                        continue
                    end
                    v34 = v35:GetAttribute("DefaultSize")
                    local v38 = "Override_" .. a16
                    if type(v34) ~= "number" then
                        v36 = v32.d
                    else
                        v36 = v34
                    end
                    v33:SetAttribute(v38, encode(v32, v36))
                end
                v35 = v34
                if not (v33) or not (v35) or not (v32) then
                    continue
                end
                v34 = v35:GetAttribute("DefaultSize")
                local v38 = "Override_" .. a16
                if type(v34) ~= "number" then
                    v36 = v32.d
                else
                    v36 = v34
                end
                v33:SetAttribute(v38, encode(v32, v36))
            end
            v34 = v37
            v37 = v34 and (v34:FindFirstChild(value_5.root))
            v34 = v37 and (v37:FindFirstChild(value_5.name))
            if not (v34) or not (v34:IsA("GuiObject")) then
                v35 = nil
                if not (v33) or not (v35) or not (v32) then
                    continue
                end
                v34 = v35:GetAttribute("DefaultSize")
                local v38 = "Override_" .. a16
                if type(v34) ~= "number" then
                    v36 = v32.d
                else
                    v36 = v34
                end
                v33:SetAttribute(v38, encode(v32, v36))
            end
            v35 = v34
            if not (v33) or not (v35) or not (v32) then
                continue
            end
            v34 = v35:GetAttribute("DefaultSize")
            local v38 = "Override_" .. a16
            if type(v34) ~= "number" then
                v36 = v32.d
            else
                v36 = v34
            end
            v33:SetAttribute(v38, encode(v32, v36))
        end
    end
    local function tryMove(a17, a18)
        --[[
          name: tryMove
          line: 269
          upvalues:
            clampInside (copy, index: 1)
            valid (copy, index: 2)
            u7 (ref,  index: 3)
            u8 (ref,  index: 4)
            paintHandles (copy, index: 5)
            tbl_upv_5 (copy, index: 6)
            push (copy, index: 7)
        ]]
        a18 = clampInside({x = math.floor((a18.x / 8) + 0.5) * 8, y = math.floor((a18.y / 8) + 0.5) * 8, d = a18.d})
        if valid(a17, a18) then
            tbl_upv_5[a17] = a18
            push(a17)
            u8 = 0
            paintHandles()
            return true
        else
            local v39 = os.clock() + 1.2
            u7 = "TOO CLOSE"
            u8 = v39
            paintHandles()
            return false
        end
    end
    local function tryResize(a19, a20)
        --[[
          name: tryResize
          line: 281
          upvalues:
            tbl_upv_5 (copy, index: 1)
            clampInside (copy, index: 2)
            valid (copy, index: 3)
            u7 (ref,  index: 4)
            u8 (ref,  index: 5)
            paintHandles (copy, index: 6)
            push (copy, index: 7)
        ]]
        local v40 = tbl_upv_5[a19]
        if not v40 then
            return false
        end
        local v41 = clampInside({x = v40.x, y = v40.y, d = math.clamp(math.floor((a20 / 4) + 0.5) * 4, 52, 170)})
        if valid(a19, v41) then
            tbl_upv_5[a19] = v41
            push(a19)
            paintHandles()
            return true
        else
            local v42 = os.clock() + 1.2
            u7 = "NO ROOM"
            u8 = v42
            paintHandles()
            return false
        end
    end
    local u10 = nil
    local function pointerOf(a21)
        --[[
          name: pointerOf
          line: 300
          upvalues:
            u4 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        if a21.UserInputType ~= Enum.UserInputType.Touch then
            return UI_upv_1.PointerAbs() - u4.AbsolutePosition
        end
        return Vector2.new(a21.Position.X, a21.Position.Y) - u4.AbsolutePosition
    end
    local function hideOthers(a22)
        --[[
          name: hideOthers
          line: 309
          upvalues:
            a1 (copy, index: 1)
            u1 (ref,  index: 2)
        ]]
        a1.SetHudHidden("TouchEditor", a22)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("TouchEditor", a22)
        end
        if a22 then
            if u1 then
                return
            end
            local tbl_8 = {}
            pcall(function() end)
            u1 = tbl_8
        else
            local v43 = u1
            if not v43 then
                return
            end
            u1 = nil
            pcall(function() end)
        end
    end
    local u11 = nil
    local function build()
        --[[
          name: build
          line: 322
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u4 (ref,  index: 5)
            u5 (ref,  index: 6)
            paintHandles (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            RunService_upv_1 (copy, index: 9)
            u2 (ref,  index: 10)
            hotbarRect (copy, index: 11)
            tbl_upv_3 (copy, index: 12)
            Theme_upv_1 (copy, index: 13)
            tbl_upv_4 (copy, index: 14)
            u10 (ref,  index: 15)
            tbl_upv_5 (copy, index: 16)
            a1 (copy, index: 17)
            u9 (ref,  index: 18)
            GuiService_upv_1 (copy, index: 19)
            u6 (ref,  index: 20)
            tryResize (copy, index: 21)
            readLive (copy, index: 22)
            u11 (ref,  index: 23)
            UserInputService_upv_1 (copy, index: 24)
            tryMove (copy, index: 25)
        ]]
        local v44 = Instance.new("ScreenGui")
        v44.Name = "TR_TouchEditor"
        v44.ResetOnSpawn = false
        v44.IgnoreGuiInset = true
        v44.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        v44.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        v44.DisplayOrder = 60
        v44.Enabled = false
        v44.Parent = PlayerGui_upv_1
        u3 = v44
        local u12 = UI_upv_1.new("TextButton", {BackgroundTransparency = 0.72, Name = "Root", AutoButtonColor = false, Text = "", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = v44})
        u4 = u12
        local v45 = UI_upv_1.new("Frame", {ClipsDescendants = true, Name = "Grid", Size = UDim2.fromScale(1, 1), Parent = u12})
        for n_1 = 1, 60 do
            UI_upv_1.new("Frame", {BackgroundTransparency = 0.94, BorderSizePixel = 0, Position = UDim2.fromOffset((n_1 * 8) * 4, 0), Size = UDim2.new(0, 1, 1, 0), BackgroundColor3 = Colors_upv_1.Text, Parent = v45})
            UI_upv_1.new("Frame", {BackgroundTransparency = 0.94, BorderSizePixel = 0, Position = UDim2.fromOffset(0, (n_1 * 8) * 4), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Colors_upv_1.Text, Parent = v45})
        end
        u12.Activated:Connect(
            function()
                --[[
                  line: 349
                  upvalues:
                    u5 (ref,  index: 1)
                    paintHandles (copy, index: 2)
                ]]
                u5 = nil
                paintHandles()
            end
        )
        local tbl_9 = {}
        tbl_9.Name = "HotbarZone"
        tbl_9.BackgroundColor3 = Colors_upv_1.Text
        tbl_9.BackgroundTransparency = 0.9
        tbl_9.ZIndex = 2
        tbl_9[1], tbl_9[2] = UI_upv_1.Corner(10), UI_upv_1.Stroke(Colors_upv_1.Text, 1, 0.7)
        tbl_9.Parent = u12
        local u13 = UI_upv_1.new("Frame", tbl_9)
        UI_upv_1.new("TextLabel", {ZIndex = 2, Text = "HOTBAR", TextSize = 13, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u13})
        RunService_upv_1.Heartbeat:Connect(
            function()
                --[[
                  line: 371
                  upvalues:
                    u2 (ref,  index: 1)
                    hotbarRect (copy, index: 2)
                    u13 (copy, index: 3)
                ]]
                if u2 then
                    local v46, v47 = hotbarRect()
                    u13.Position = UDim2.fromOffset(v46.X, v46.Y)
                    u13.Size = UDim2.fromOffset(v47.X, v47.Y)
                end
            end
        )
        for _, value_upv_6 in tbl_upv_3 do
            local v48 = UI_upv_1.new("TextButton", {Name = value_upv_6.name, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 0.9, Text = "", AutoButtonColor = false, ZIndex = 5, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u12})
            local v49 = UI_upv_1.Stroke(Colors_upv_1.Text, 2, 0.35)
            v49.Parent = v48
            local v50 = UI_upv_1.new("TextLabel", {ZIndex = 5, TextSize = 12, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 4), Size = UDim2.fromOffset(120, 16), Text = value_upv_6.label, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v48})
            UI_upv_1.TextStroke(Colors_upv_1.Void, 1, 0.3).Parent = v50
            local tbl_10 = {}
            tbl_10.Name = "Resize"
            tbl_10.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_10.Position = UDim2.fromScale(0.854, 0.854)
            tbl_10.Size = UDim2.fromOffset(30, 30)
            tbl_10.BackgroundColor3 = Colors_upv_1.Accent
            tbl_10.Text = ""
            tbl_10.AutoButtonColor = false
            tbl_10.Visible = false
            tbl_10.ZIndex = 7
            tbl_10[1], tbl_10[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Text, 2, 0)
            tbl_10.Parent = v48
            local v51 = UI_upv_1.new("TextButton", tbl_10)
            tbl_upv_4[value_upv_6.name] = {spec = value_upv_6, frame = v48, stroke = v49, label = v50, knob = v51}
            local function begin_upv_1(a23, a24)
                --[[
                  name: begin
                  line: 420
                  upvalues:
                    u10 (ref,  index: 1)
                    tbl_upv_5 (copy, index: 2)
                    value_upv_6 (copy, index: 3)
                    u5 (ref,  index: 4)
                    u4 (ref,  index: 5)
                    UI_upv_1 (copy, index: 6)
                    paintHandles (copy, index: 7)
                    a1 (copy, index: 8)
                ]]
                local UserInputType_1 = a23.UserInputType
                if UserInputType_1 ~= Enum.UserInputType.Touch and UserInputType_1 ~= Enum.UserInputType.MouseButton1 or a23.UserInputState ~= Enum.UserInputState.Begin or u10 then
                    return
                end
                local v52 = tbl_upv_5[value_upv_6.name]
                if not v52 then
                    return
                end
                u5 = value_upv_6.name
                local v53 = ((a23.UserInputType ~= Enum.UserInputType.Touch) and (UI_upv_1.PointerAbs() - u4.AbsolutePosition)) or (Vector2.new(a23.Position.X, a23.Position.Y) - u4.AbsolutePosition)
                local v54 = v53 - Vector2.new(v52.x, v52.y)
                local tbl_11 = {}
                tbl_11.input = a23
                tbl_11.name = value_upv_6.name
                tbl_11.mode = a24
                tbl_11.offset = v54
                tbl_11.d0 = v52.d
                tbl_11.dist0 = math.max(v54.Magnitude, 8)
                u10 = tbl_11
                paintHandles()
                a1.Sounds.Play("Select")
            end
            v48.InputBegan:Connect(
                function(a25)
                    --[[
                      line: 436
                      upvalues:
                        begin_upv_1 (copy, index: 1)
                    ]]
                    begin_upv_1(a25, "move")
                end
            )
            v51.InputBegan:Connect(
                function(a26)
                    --[[
                      line: 439
                      upvalues:
                        begin_upv_1 (copy, index: 1)
                    ]]
                    begin_upv_1(a26, "resize")
                end
            )
        end
        local tbl_12 = {}
        tbl_12.Name = "Toolbar"
        tbl_12.AnchorPoint = Vector2.new(0, 0.5)
        tbl_12.Size = UDim2.fromOffset(476, 44)
        tbl_12.BackgroundColor3 = Colors_upv_1.Panel
        tbl_12.BackgroundTransparency = 0.08
        tbl_12.ZIndex = 10
        tbl_12[1], tbl_12[2], tbl_12[3], tbl_12[4] = UI_upv_1.Corner(14), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88), UI_upv_1.Padding(0, 4), UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
        tbl_12.Parent = u12
        local u14 = UI_upv_1.new("Frame", tbl_12)
        u9 = u14
        local u15 = UI_upv_1.new("UIScale", {Parent = u14})
        local function placeBar_1()
            --[[
              name: placeBar
              line: 461
              upvalues:
                u12 (copy, index: 1)
                GuiService_upv_1 (copy, index: 2)
                u15 (copy, index: 3)
                u14 (copy, index: 4)
            ]]
            local AbsoluteSize_5 = u12.AbsoluteSize
            local TopbarInset_2 = GuiService_upv_1.TopbarInset
            local v55 = ((AbsoluteSize_5.X >= 1000) and 1.15) or 1
            local v56 = 12
            local v57 = (v55 * 44) / 2 + 8
            local v58 = AbsoluteSize_5.X - 12
            if TopbarInset_2.Height > 0 then
                v56 = TopbarInset_2.Min.X + 8
                v57 = TopbarInset_2.Min.Y + TopbarInset_2.Height / 2
                v58 = math.min(v58, TopbarInset_2.Max.X - 8)
            end
            local v59 = math.min(v55, (v58 - v56) / 476)
            if v59 >= 0.8 then
                u15.Scale = v59
                u14.Position = UDim2.fromOffset(v56, v57)
            else
                local v60 = math.min(v55, (AbsoluteSize_5.X - 24) / 476)
                u15.Scale = v60
                u14.Position = UDim2.fromOffset((AbsoluteSize_5.X - (v60 * 476)) / 2, (math.max(v57 + 22, 44) + 6) + ((v60 * 44) / 2))
            end
        end
        placeBar_1()
        u12:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeBar_1)
        GuiService_upv_1:GetPropertyChangedSignal("TopbarInset"):Connect(placeBar_1)
        local v61 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Text = "", Name = "Selected", ZIndex = 10, TextSize = 14, Size = UDim2.fromOffset(116, 36), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u14})
        u6 = v61
        local function stepBtn_1(a27, a28, a29, a30)
            --[[
              name: stepBtn
              line: 496
              upvalues:
                UI_upv_1 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
                u14 (copy, index: 3)
                u5 (ref,  index: 4)
                tbl_upv_5 (copy, index: 5)
                tryResize (copy, index: 6)
                a1 (copy, index: 7)
            ]]
            local tbl_13 = {IconScale = 0.42, Transparency = 0.1, ZIndex = 10}
            tbl_13.Name = a27
            tbl_13.IconName = a28
            tbl_13.Size = UDim2.fromOffset(36, 36)
            tbl_13.Color = Colors_upv_1.Raised
            tbl_13.LayoutOrder = a29
            tbl_13.Parent = u14
            UI_upv_1.IconButton(tbl_13).Activated:Connect(
                function()
                    --[[
                      line: 508
                      upvalues:
                        u5 (ref,  index: 1)
                        tbl_upv_5 (copy, index: 2)
                        tryResize (copy, index: 3)
                        a30 (copy, index: 4)
                        a1 (copy, index: 5)
                    ]]
                    if not u5 or not tbl_upv_5[u5] then
                        return
                    end
                    if tryResize(u5, tbl_upv_5[u5].d + a30) then
                        local Play_1 = a1.Sounds.Play
                        local tbl_14 = {pitch = 0}
                        tbl_14.pitch = ((a30 > 0) and 1.15) or 0.9
                        Play_1("Tick", tbl_14)
                    else
                        a1.Sounds.Play("Error")
                    end
                end
            )
        end
        stepBtn_1("Smaller", "minus", 2, -8)
        stepBtn_1("Bigger", "plus", 3, 8)
        UI_upv_1.new("Frame", {LayoutOrder = 4, Name = "Gap", Size = UDim2.fromOffset(6, 1), Parent = u14})
        local function action_1(a31, a32, a33, a34, a35, a36)
            --[[
              name: action
              line: 521
              upvalues:
                UI_upv_1 (copy, index: 1)
                u14 (copy, index: 2)
            ]]
            local tbl_15 = {Radius = 10, ZIndex = 10, TextSize = 15}
            tbl_15.Name = a31
            tbl_15.Text = a32
            tbl_15.Style = a33
            tbl_15.Size = UDim2.fromOffset(a34, 36)
            tbl_15.LayoutOrder = a35
            tbl_15.Parent = u14
            UI_upv_1.Button(tbl_15).Activated:Connect(a36)
        end
        action_1(
            "Reset",
            "RESET",
            "Dark",
            80,
            5,
            function()
                --[[
                  line: 525
                  upvalues:
                    tbl_upv_3 (copy, index: 1)
                    PlayerGui_upv_1 (copy, index: 2)
                    readLive (copy, index: 3)
                    tbl_upv_5 (copy, index: 4)
                    paintHandles (copy, index: 5)
                ]]
                local v62 = nil
                for _, value_7 in tbl_upv_3 do
                    local v63 = PlayerGui_upv_1:FindFirstChild(value_7.gui)
                    if not (v63) or not (v63:IsA("ScreenGui")) then
                        v62 = nil
                        if v62 then
                            v62:SetAttribute("Override_" .. value_7.name, nil)
                            continue
                        end
                    end
                    v62 = v63
                    if v62 then
                        v62:SetAttribute("Override_" .. value_7.name, nil)
                    end
                end
                task.wait()
                task.wait()
                readLive()
                for key_3 in tbl_upv_5 do
                    tbl_upv_5[key_3].x = math.floor((tbl_upv_5[key_3].x / 8) + 0.5) * 8
                    tbl_upv_5[key_3].y = math.floor((tbl_upv_5[key_3].y / 8) + 0.5) * 8
                end
                paintHandles()
            end
        )
        action_1(
            "Cancel",
            "CANCEL",
            "Dark",
            90,
            6,
            function()
                --[[
                  line: 541
                  upvalues:
                    u11 (ref, index: 1)
                ]]
                u11(false)
            end
        )
        action_1(
            "Save",
            "SAVE",
            "Primary",
            80,
            7,
            function()
                --[[
                  line: 544
                  upvalues:
                    u11 (ref, index: 1)
                ]]
                u11(true)
            end
        )
        UserInputService_upv_1.InputChanged:Connect(
            function(a37)
                --[[
                  line: 549
                  upvalues:
                    u10 (ref,  index: 1)
                    u4 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    tbl_upv_5 (copy, index: 4)
                    tryMove (copy, index: 5)
                    tryResize (copy, index: 6)
                ]]
                if not u10 then
                    return
                end
                if u10.input.UserInputType ~= Enum.UserInputType.Touch then
                    if a37.UserInputType ~= Enum.UserInputType.MouseMovement then
                        return
                    end
                elseif a37 ~= u10.input then
                    return
                end
                local input_1 = u10.input
                local v64 = ((input_1.UserInputType ~= Enum.UserInputType.Touch) and (UI_upv_1.PointerAbs() - u4.AbsolutePosition)) or (Vector2.new(input_1.Position.X, input_1.Position.Y) - u4.AbsolutePosition)
                local v65 = tbl_upv_5[u10.name]
                if not v65 then
                    return
                end
                if u10.mode ~= "move" then
                    tryResize(u10.name, (u10.d0 * (v64 - Vector2.new(v65.x, v65.y)).Magnitude) / u10.dist0)
                else
                    tryMove(u10.name, {x = v64.X - u10.offset.X, y = v64.Y - u10.offset.Y, d = v65.d})
                end
            end
        )
        local function ended_1(a38)
            --[[
              name: ended
              line: 574
              upvalues:
                u10 (ref, index: 1)
            ]]
            if not u10 then
                return
            end
            if u10.input.UserInputType ~= Enum.UserInputType.Touch then
                if a38.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    return
                end
            elseif a38 ~= u10.input then
                return
            end
            u10 = nil
        end
        UserInputService_upv_1.InputEnded:Connect(ended_1)
        UserInputService_upv_1.TouchEnded:Connect(ended_1)
        RunService_upv_1.Heartbeat:Connect(
            function()
                --[[
                  line: 593
                  upvalues:
                    u2 (ref,  index: 1)
                    u10 (ref,  index: 2)
                    tbl_upv_5 (copy, index: 3)
                    readLive (copy, index: 4)
                    paintHandles (copy, index: 5)
                ]]
                if not u2 then
                    return
                end
                local v66 = u10 and (u10.name)
                local v67 = v66 and (tbl_upv_5[v66])
                readLive()
                if v66 and v67 then
                    tbl_upv_5[v66] = v67
                end
                paintHandles()
            end
        )
    end
    local function open()
        --[[
          name: open
          line: 607
          upvalues:
            u2 (ref,  index: 1)
            u3 (ref,  index: 2)
            build (copy, index: 3)
            X_upv_1 (ref,  index: 4)
            GuiService_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            u1 (ref,  index: 7)
            TextChatService_upv_1 (copy, index: 8)
            StarterGui_upv_1 (copy, index: 9)
            tbl_upv_6 (copy, index: 10)
            tbl_upv_3 (copy, index: 11)
            PlayerGui_upv_1 (copy, index: 12)
            u5 (ref,  index: 13)
            u8 (ref,  index: 14)
            tbl_upv_5 (copy, index: 15)
            readLive (copy, index: 16)
            paintHandles (copy, index: 17)
        ]]
        if not u2 then
            if not (u3) then
                build()
            end
            u2 = true
            X_upv_1 = GuiService_upv_1.TopbarInset.Min.X
            a1.MenuManager.CloseAll(true)
            a1.MenuManager.PushMouse("TouchEditor")
            a1.SetHudHidden("TouchEditor", true)
            if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
                a1.TopbarSettings.SetHidden("TouchEditor", true)
            end
            if not (u1) then
                local tbl_upv_16 = {}
                pcall(
                    function()
                        --[[
                          line: 38
                          upvalues:
                            TextChatService_upv_1 (copy, index: 1)
                            tbl_upv_16 (copy, index: 2)
                            StarterGui_upv_1 (copy, index: 3)
                        ]]
                        local v68 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                        local v69 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                        if v68 then
                            tbl_upv_16.window = v68.Enabled
                            v68.Enabled = false
                        end
                        if v69 then
                            tbl_upv_16.bar = v69.Enabled
                            v69.Enabled = false
                        end
                        tbl_upv_16.core = StarterGui_upv_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                        StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                    end
                )
                u1 = tbl_upv_16
            end
            table.clear(tbl_upv_6)
            local v70 = nil
            for _, value_8 in tbl_upv_3 do
                local v71 = PlayerGui_upv_1:FindFirstChild(value_8.gui)
                if not (v71) or not (v71:IsA("ScreenGui")) then
                    v70 = nil
                    if v70 then
                        tbl_upv_6[value_8.name] = v70:GetAttribute("Override_" .. value_8.name)
                        v70:SetAttribute("EditPreview", true)
                        continue
                    end
                end
                v70 = v71
                if v70 then
                    tbl_upv_6[value_8.name] = v70:GetAttribute("Override_" .. value_8.name)
                    v70:SetAttribute("EditPreview", true)
                end
            end
            u5 = nil
            u8 = 0
            u3.Enabled = true
            task.wait()
            task.wait()
            table.clear(tbl_upv_5)
            readLive()
            paintHandles()
            a1.Sounds.Play("Open")
        end
    end
    u11 = function(a39)
        --[[
          line: 638
          upvalues:
            u2 (ref,  index: 1)
            u10 (ref,  index: 2)
            tbl_upv_3 (copy, index: 3)
            PlayerGui_upv_1 (copy, index: 4)
            tbl_upv_6 (copy, index: 5)
            u3 (ref,  index: 6)
            a1 (copy, index: 7)
            u1 (ref,  index: 8)
            TextChatService_upv_1 (copy, index: 9)
            StarterGui_upv_1 (copy, index: 10)
            State_upv_1 (copy, index: 11)
            applySaved (copy, index: 12)
        ]]
        if not u2 then
            return
        end
        u10 = nil
        local tbl_upv_17 = {}
        local v72, v73 = nil, nil
        for _, value_9 in tbl_upv_3 do
            local v74 = PlayerGui_upv_1:FindFirstChild(value_9.gui)
            if not (v74) or not (v74:IsA("ScreenGui")) then
                v72 = nil
                if not (v72) then
                    continue
                end
                v74 = v72:GetAttribute("Override_" .. value_9.name)
                local name_1 = value_9.name
                if type(v74) ~= "string" then
                    v73 = ""
                else
                    v73 = v74
                end
                tbl_upv_17[name_1] = v73
                if not (a39) then
                    v72:SetAttribute("Override_" .. value_9.name, tbl_upv_6[value_9.name])
                end
                v72:SetAttribute("EditPreview", nil)
            end
            v72 = v74
            if not (v72) then
                continue
            end
            v74 = v72:GetAttribute("Override_" .. value_9.name)
            local name_1 = value_9.name
            if type(v74) ~= "string" then
                v73 = ""
            else
                v73 = v74
            end
            tbl_upv_17[name_1] = v73
            if not (a39) then
                v72:SetAttribute("Override_" .. value_9.name, tbl_upv_6[value_9.name])
            end
            v72:SetAttribute("EditPreview", nil)
        end
        u3.Enabled = false
        u2 = false
        a1.MenuManager.PopMouse("TouchEditor")
        a1.SetHudHidden("TouchEditor", false)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("TouchEditor", false)
        end
        local u16 = u1
        if u16 then
            u1 = nil
            pcall(
                function()
                    --[[
                      line: 60
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        u16 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v75 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v76 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v75 and u16.window ~= nil then
                        v75.Enabled = u16.window
                    end
                    if v76 and u16.bar ~= nil then
                        v76.Enabled = u16.bar
                    end
                    if u16.core == nil then
                        return
                    end
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, u16.core)
                end
            )
        end
        if a39 then
            a1.Sounds.Play("Equip")
            local u17 = State_upv_1.Profile.settings
            if type(u17) ~= "table" then
                local tbl_18 = {}
                State_upv_1.Profile.settings = tbl_18
                u17 = tbl_18
            end
            task.spawn(
                function()
                    --[[
                      line: 666
                      upvalues:
                        tbl_upv_3 (copy, index: 1)
                        tbl_upv_17 (copy, index: 2)
                        State_upv_1 (copy, index: 3)
                        a1 (copy, index: 4)
                        u17 (ref,  index: 5)
                        applySaved (copy, index: 6)
                    ]]
                    local v77 = true
                    local v78, v79 = nil, nil
                    for _, value_10 in tbl_upv_3 do
                        local v80 = tbl_upv_17[value_10.name] or ""
                        local name_2 = value_10.name
                        local v81 = State_upv_1.Profile and (State_upv_1.Profile.settings)
                        v78 = false
                        if type(v81) == "table" then
                            v78 = v81["touch_" .. name_2]
                        end
                        if type(v78) ~= "string" then
                            v79 = ""
                        else
                            v79 = v78
                        end
                        if v79 == v80 then
                            continue
                        end
                        if a1.ProfileAction("SetSetting", "touch_" .. value_10.name, v80) then
                            u17["touch_" .. value_10.name] = v80
                        else
                            v77 = false
                        end
                    end
                    local Toast_1 = a1.Toast
                    local v82 = (v77 and "Controls saved") or "Couldn't save every button"
                    Toast_1(v82, (v77 and "info") or "error")
                    applySaved()
                end
            )
        else
            a1.Sounds.Play("Close")
        end
    end
    State_upv_1.PlayerStateChanged:Connect(
        function()
            --[[
              line: 688
              upvalues:
                u2 (ref, index: 1)
                u11 (ref, index: 2)
            ]]
            if not u2 then
                return
            end
            u11(false)
        end
    )
    a1.OpenTouchEditor = function()
        --[[
          line: 694
          upvalues:
            open (copy, index: 1)
        ]]
        task.spawn(open)
    end
    a1.Debug.touchEditor = function(a40, a41, a42, a43)
        --[[
          line: 697
          upvalues:
            open (copy, index: 1)
            u11 (ref,  index: 2)
            tbl_upv_5 (copy, index: 3)
            tryMove (copy, index: 4)
            tryResize (copy, index: 5)
            u9 (ref,  index: 6)
            GuiService_upv_1 (copy, index: 7)
            u2 (ref,  index: 8)
            u5 (ref,  index: 9)
            u6 (ref,  index: 10)
        ]]
        local v85 = nil
        if a40 == "open" then
            task.spawn(open)
        elseif a40 == "save" then
            u11(true)
        elseif a40 == "cancel" then
            u11(false)
        elseif a40 == "move" and type(a41) == "string" and tbl_upv_5[a41] then
            v85 = {y = 0, x = 0, d = 0}
            v85.x = tonumber(a42) or tbl_upv_5[a41].x
            v85.y = tonumber(a43) or tbl_upv_5[a41].y
            v85.d = tbl_upv_5[a41].d
            tryMove(a41, v85)
        elseif a40 == "size" and type(a41) == "string" then
            tryResize(a41, tonumber(a42) or 80)
        end
        local tbl_20 = {}
        for key_4, value_11 in tbl_upv_5 do
            tbl_20[key_4] = string.format("%d,%d,%d", value_11.x, value_11.y, value_11.d)
        end
        if u9 then
            v85 = {}
            v85.x = u9.AbsolutePosition.X
            v85.y = u9.AbsolutePosition.Y
            v85.w = u9.AbsoluteSize.X
            v85.h = u9.AbsoluteSize.Y
        else
            v85 = nil
        end
        local TopbarInset_3 = GuiService_upv_1.TopbarInset
        local tbl_21 = {label = 0}
        tbl_21.editing = u2
        tbl_21.rects = tbl_20
        tbl_21.selected = u5
        tbl_21.bar = v85
        tbl_21.inset = {TopbarInset_3.Min.X, TopbarInset_3.Min.Y, TopbarInset_3.Max.X, TopbarInset_3.Max.Y}
        tbl_21.label = u6 and (u6.Text)
        return tbl_21
    end
end
return tbl_1