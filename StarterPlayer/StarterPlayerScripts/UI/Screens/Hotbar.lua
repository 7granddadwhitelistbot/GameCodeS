local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local RunService_upv_1 = game:GetService("RunService")
local tbl_upv_1 = {}
local Keybinds_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local tbl_upv_2 = {Item2 = 2, Item5 = 5, Item6 = 6, Item4 = 4, Item3 = 3, Item1 = 1}
local tbl_upv_3 = {utility = 4, primary = 1, melee = 3, secondary = 2}
function tbl_upv_1.Init(a1)
    --[[
      name: Init
      line: 23
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        UserInputService_upv_1 (copy, index: 5)
        Keybinds_upv_1 (copy, index: 6)
        tbl_upv_2 (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local Colors_upv_1 = Theme_upv_1.Colors
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = UI_upv_1.new("Frame", {Name = "Hotbar", Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(566, 98), Parent = a1.Canvas.HUD})
    local u2 = UI_upv_1.DisplayText({StrokeThickness = 2, TextTransparency = 1, Text = "", Name = "Equipped", TextSize = 24, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0, -4), Size = UDim2.fromOffset(420, 28), TextColor3 = Colors_upv_1.Text, Parent = u1})
    local u3 = u2:FindFirstChildOfClass("UIStroke")
    u3.Transparency = 1
    local tbl_upv_4 = {}
    local u4 = 0
    local u5 = nil
    local u6 = 0
    local u7 = 4
    a1.HotbarChanged = a1.HotbarChanged or Instance.new("BindableEvent")
    local u8 = UI_upv_1.PadActionCap("PrevItem", {Height = 24, ZIndex = 3, Position = UDim2.fromOffset(4, 4)})
    local u9 = UI_upv_1.PadActionCap("NextItem", {Height = 24, ZIndex = 3, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 4)})
    u8.Name = "PadPrev"
    u9.Name = "PadNext"
    local function layout()
        --[[
          name: layout
          line: 86
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            u7 (ref,  index: 3)
            tbl_upv_4 (copy, index: 4)
            u4 (ref,  index: 5)
            u8 (copy, index: 6)
            u9 (copy, index: 7)
        ]]
        local v2 = ((UI_upv_1.Compact) and 76) or 86
        local v3 = ((UI_upv_1.Compact) and 6) or 10
        u1.Size = UDim2.fromOffset((u7 * v2) + ((u7 - 1) * v3), v2 + 12)
        u1.Position = UDim2.new(0.5, 0, 1, ((UI_upv_1.Compact) and -8) or -18)
        for key_1, value_1 in tbl_upv_4 do
            value_1.holder.Visible = key_1 <= u7
            value_1.holder.Size = UDim2.fromOffset(v2, v2)
            local holder_1 = value_1.holder
            holder_1.Position = UDim2.fromOffset((key_1 - 1) * (v2 + v3), ((key_1 ~= u4) and 12) or 0)
        end
        local v4 = tbl_upv_4[1]
        local v5 = tbl_upv_4[math.clamp(u7, 1, 6)]
        if not v4 or not v5 then
            return
        end
        u8.Parent = v4.face
        u9.Parent = v5.face
    end
    function a1.HotbarTop()
        --[[
          name: HotbarTop
          line: 101
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        local v6 = ((UI_upv_1.Compact) and 76) or 86
        return v6 + 12 + (((UI_upv_1.Compact) and 8) or 18)
    end
    function a1.HotbarWidth()
        --[[
          name: HotbarWidth
          line: 108
          upvalues:
            UI_upv_1 (copy, index: 1)
            u7 (ref,  index: 2)
        ]]
        local v7 = ((UI_upv_1.Compact) and 76) or 86
        local v8 = ((UI_upv_1.Compact) and 6) or 10
        return (math.max((u7 * v7) + ((u7 - 1) * v8), (v7 * 4) + (v8 * 3)))
    end
    local u10 = nil
    for n_upv_1 = 1, 6 do
        local v9 = UI_upv_1.new("TextButton", {Selectable = false, Name = "Slot" .. n_upv_1, Size = UDim2.fromOffset(86, 86), Position = UDim2.fromOffset((n_upv_1 - 1) * 96, 12), Parent = u1})
        local tbl_5 = {}
        tbl_5.Name = "Face"
        tbl_5.Size = UDim2.fromScale(1, 1)
        tbl_5.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_5.BackgroundTransparency = 0.2
        tbl_5[1], tbl_5[2] = UI_upv_1.Corner(12), UI_upv_1.Gradient(Colors_upv_1.PanelHi, Colors_upv_1.PanelLo, 90)
        tbl_5.Parent = v9
        local v10 = UI_upv_1.new("Frame", tbl_5)
        local u11 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 2, 0.7)
        u11.Parent = v10
        tbl_5 = UI_upv_1.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -14, 1, -14), Parent = v10})
        local v11 = UI_upv_1.ActionCap("Item" .. n_upv_1, {Height = 22, ZIndex = 3, Position = UDim2.fromOffset(5, 5), Parent = v10})
        local v12 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "", Name = "Ammo", ZIndex = 4, TextSize = 22, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -6, 1, -3), Size = UDim2.fromOffset(60, 24), TextXAlignment = Enum.TextXAlignment.Right, Parent = v10})
        local v13 = UI_upv_1.new("Frame", {Name = "Pips", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -12, 0, 8), Visible = false, ZIndex = 4, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v10})
        local v14 = UI_upv_1.new("Frame", {Name = "Reload", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.4, Visible = false, ZIndex = 5, ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = v10})
        local v15 = UI_upv_1.new("Frame", {BackgroundTransparency = 0.55, Name = "Fill", ZIndex = 5, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0), BackgroundColor3 = Colors_upv_1.Accent, Parent = v14})
        local tbl_6 = {StrokeThickness = 1.5, Text = "RELOAD", ZIndex = 6, TextSize = 16}
        tbl_6.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_6.Position = UDim2.fromScale(0.5, 0.5)
        tbl_6.Size = UDim2.new(1, 0, 0, 20)
        tbl_6.TextColor3 = Colors_upv_1.Accent
        tbl_6.Parent = v14
        UI_upv_1.DisplayText(tbl_6).Name = "Label"
        local v16 = UI_upv_1.new("Frame", {Visible = false, Name = "Cooldown", ClipsDescendants = true, ZIndex = 5, Size = UDim2.fromScale(1, 1), Parent = v10})
        local v17 = UI_upv_1.new("Frame", {AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, ZIndex = 5, [1] = UI_upv_1.Corner(12), Parent = v16})
        local v18 = UI_upv_1.new("Frame", {Name = "Regen", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -2), Size = UDim2.new(1, -20, 0, 3), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, Visible = false, ZIndex = 4, [1] = UI_upv_1.Corner(2), Parent = v10})
        local tbl_upv_7 = {}
        tbl_upv_7.holder = v9
        tbl_upv_7.face = v10
        tbl_upv_7.stroke = u11
        tbl_upv_7.icon = tbl_5
        tbl_upv_7.key = v11
        tbl_upv_7.ammo = v12
        tbl_upv_7.pips = v13
        tbl_upv_7.reload = v14
        tbl_upv_7.reloadFill = v15
        tbl_upv_7.cool = v16
        tbl_upv_7.coolFill = v17
        tbl_upv_7.regen = v18
        tbl_upv_7.regenFill = UI_upv_1.new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = Colors_upv_1.Bone, ZIndex = 4, [1] = UI_upv_1.Corner(2), Parent = v18})
        tbl_upv_7.timers = {}
        tbl_upv_4[n_upv_1] = tbl_upv_7
        v9.Activated:Connect(
            function()
                --[[
                  line: 261
                  upvalues:
                    u10 (ref,  index: 1)
                    n_upv_1 (copy, index: 2)
                ]]
                u10(n_upv_1)
            end
        )
        v9.MouseEnter:Connect(
            function()
                --[[
                  line: 264
                  upvalues:
                    tbl_upv_7 (copy, index: 1)
                    u4 (ref,  index: 2)
                    n_upv_1 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u11 (copy, index: 5)
                    Theme_upv_1 (copy, index: 6)
                ]]
                if not tbl_upv_7.tool or u4 == n_upv_1 then
                    return
                end
                UI_upv_1.Tween(u11, Theme_upv_1.Tween.Fast, {Transparency = 0.35})
            end
        )
        v9.MouseLeave:Connect(
            function()
                --[[
                  line: 269
                  upvalues:
                    u4 (ref,  index: 1)
                    n_upv_1 (copy, index: 2)
                    UI_upv_1 (copy, index: 3)
                    u11 (copy, index: 4)
                    Theme_upv_1 (copy, index: 5)
                ]]
                if u4 == n_upv_1 then
                    return
                end
                UI_upv_1.Tween(u11, Theme_upv_1.Tween.Fast, {Transparency = 0.7})
            end
        )
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    local function slotOfTool(a2)
        --[[
          name: slotOfTool
          line: 279
          upvalues:
            tbl_upv_3 (copy, index: 1)
        ]]
        local v19 = a2:GetAttribute("SlotIndex")
        if type(v19) == "number" and v19 >= 1 and v19 <= 6 then
            return v19
        end
        local v20 = a2:GetAttribute("Slot")
        if type(v20) ~= "string" then
            return nil
        end
        return tbl_upv_3[v20]
    end
    local u12 = nil
    local function srcBackpack()
        --[[
          name: srcBackpack
          line: 292
          upvalues:
            u12 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        if u12 then
            return u12.backpack
        end
        return (LocalPlayer_upv_1:FindFirstChildOfClass("Backpack"))
    end
    local function srcCharacter()
        --[[
          name: srcCharacter
          line: 295
          upvalues:
            u12 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        if u12 then
            return u12.character
        end
        return LocalPlayer_upv_1.Character
    end
    local function toolsBySlot()
        --[[
          name: toolsBySlot
          line: 299
          upvalues:
            tbl_upv_3 (copy, index: 1)
            u12 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
        ]]
        local tbl_upv_8 = {}
        local v21
        if u12 then
            v21 = u12.backpack
        else
            v21 = LocalPlayer_upv_1:FindFirstChildOfClass("Backpack")
        end
        local function scan_1(a3)
            --[[
              name: scan
              line: 301
              upvalues:
                tbl_upv_3 (copy, index: 1)
                tbl_upv_8 (copy, index: 2)
            ]]
            if a3 then
                local v22 = nil
                for _, value_2 in a3:GetChildren() do
                    if not (value_2:IsA("Tool")) then
                        continue
                    end
                    local v23 = value_2:GetAttribute("SlotIndex")
                    if type(v23) == "number" and v23 >= 1 and v23 <= 6 then
                        v22 = v23
                    else
                        local v24 = value_2:GetAttribute("Slot")
                        if type(v24) ~= "string" then
                            v22 = nil
                        else
                            v22 = tbl_upv_3[v24]
                        end
                    end
                    if v22 then
                        tbl_upv_8[v22] = value_2
                    end
                end
            end
        end
        scan_1(v21)
        local v25
        if u12 then
            v25 = u12.character
        else
            v25 = LocalPlayer_upv_1.Character
        end
        scan_1(v25)
        return tbl_upv_8
    end
    local function heldSlot()
        --[[
          name: heldSlot
          line: 319
          upvalues:
            u12 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
        ]]
        local v26
        if u12 then
            v26 = u12.character
        else
            v26 = LocalPlayer_upv_1.Character
        end
        local v27 = v26 and (v26:FindFirstChildOfClass("Tool"))
        if not v27 then
            return 0
        end
        local v28 = v27:GetAttribute("SlotIndex")
        local v29
        if type(v28) == "number" and v28 >= 1 and v28 <= 6 then
            v29 = v28
        else
            local v30 = v27:GetAttribute("Slot")
            if type(v30) ~= "string" then
                v29 = nil
            else
                v29 = tbl_upv_3[v30]
            end
        end
        return v29 or 0
    end
    local u13 = nil
    local function stepTimers()
        --[[
          name: stepTimers
          line: 352
          upvalues:
            State_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u13 (ref,  index: 3)
        ]]
        local v31 = State_upv_1.Now()
        local v32 = false
        for _, value_3 in tbl_upv_4 do
            for key_2, value_4 in value_3.timers do
                local v33 = value_4.endsAt - v31
                local v34 = ((value_4.total > 0) and (1 - math.clamp(v33 / value_4.total, 0, 1))) or 1
                if key_2 == "reload" then
                    value_3.reloadFill.Size = UDim2.fromScale(1, v34)
                elseif key_2 == "cooldown" then
                    value_3.coolFill.Size = UDim2.fromScale(1, 1 - v34)
                elseif key_2 == "regen" then
                    value_3.regenFill.Size = UDim2.fromScale(v34, 1)
                end
                if not (v33 <= 0) then
                    v32 = true
                    continue
                end
                value_3.timers[key_2] = nil
                if key_2 == "cooldown" then
                    value_3.cool.Visible = false
                    continue
                end
                if key_2 == "regen" then
                    value_3.regen.Visible = false
                end
            end
        end
        if (v32) or not u13 then
            return
        end
        u13:Disconnect()
        u13 = nil
    end
    local u14 = function(a4, a5, a6)
        --[[
          line: 383
          upvalues:
            State_upv_1 (copy, index: 1)
            u13 (ref,  index: 2)
            RunService_upv_1 (copy, index: 3)
            stepTimers (copy, index: 4)
        ]]
        local v35 = State_upv_1.Now()
        local v36 = (type(a6) == "number") and (v35 < a6)
        local v37 = a4.timers[a5]
        if v36 then
            if not (v37) or math.abs(v37.endsAt - a6) > 0.01 then
                a4.timers[a5] = {endsAt = a6, total = math.max(0.1, a6 - v35)}
            end
        else
            a4.timers[a5] = nil
        end
        if a5 == "cooldown" then
            a4.cool.Visible = v36
        elseif a5 == "regen" then
            a4.regen.Visible = v36
        elseif a5 == "reload" and not (v36) then
            local reloadFill_1 = a4.reloadFill
            reloadFill_1.Size = UDim2.fromScale(1, ((a4.reload.Visible) and 1) or 0)
        end
        if not v36 or (u13) then
            return
        end
        u13 = RunService_upv_1.RenderStepped:Connect(stepTimers)
    end
    local AltAmmo = function()
        --[[
          line: 411
        ]]
        return {}
    end
    local success_1, v38 = pcall(
        function()
            --[[
              line: 415
            ]]
            return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Weapons")))
        end
    )
    if success_1 and type(v38) == "table" and type(v38.AltAmmo) == "function" then
        AltAmmo = v38.AltAmmo
    end
    local function reserveOf(a7)
        --[[
          name: reserveOf
          line: 422
          upvalues:
            u12 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            AltAmmo (ref,  index: 3)
        ]]
        if not a7 then
            return nil
        end
        local u15
        if u12 then
            u15 = u12.model
        else
            u15 = LocalPlayer_upv_1.Character
        end
        local function pool_1(a8)
            --[[
              name: pool
              line: 427
              upvalues:
                u15 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
            ]]
            local v39
            if u15 then
                v39 = u15:GetAttribute("Ammo_" .. a8)
            else
                v39 = u15
            end
            if type(v39) ~= "number" then
                v39 = LocalPlayer_upv_1:GetAttribute("Ammo_" .. a8)
            end
            if type(v39) ~= "number" then
                return nil
            end
            return v39
        end
        local v40 = u15 and (u15:GetAttribute("Ammo_" .. a7))
        if type(v40) ~= "number" then
            v40 = LocalPlayer_upv_1:GetAttribute("Ammo_" .. a7)
        end
        if type(v40) ~= "number" then
            local v41 = nil
        else
            local v41 = v40
        end
        local v42, v43, v41 = nil, nil, nil
        for _, value_5 in AltAmmo(a7) do
            v42 = u15
            v42 = v42 and (u15:GetAttribute("Ammo_" .. value_5))
            if type(v42) ~= "number" then
                v42 = LocalPlayer_upv_1:GetAttribute("Ammo_" .. value_5)
            end
            if type(v42) ~= "number" then
                v43 = nil
            else
                v43 = v42
            end
            if v43 then
                v41 = (v41 or 0) + v43
            end
        end
        return v41
    end
    tbl_upv_1.ReserveOf = reserveOf
    local function setPips(a9, a10, a11)
        --[[
          name: setPips
          line: 325
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        local tbl_9 = {}
        for _, value_6 in a9.pips:GetChildren() do
            if value_6:IsA("Frame") then
                table.insert(tbl_9, value_6)
            end
        end
        for n_2 = #tbl_9 + 1, a11 do
            local tbl_10 = {}
            tbl_10.Size = UDim2.fromOffset(12, 6)
            tbl_10.BackgroundColor3 = Colors_upv_1.Accent
            tbl_10.LayoutOrder = n_2
            tbl_10.ZIndex = 4
            tbl_10[1], tbl_10[2] = UI_upv_1.Corner(3), UI_upv_1.Stroke(Colors_upv_1.Void, 1, 0.4)
            tbl_10.Parent = a9.pips
            table.insert(tbl_9, UI_upv_1.new("Frame", tbl_10))
        end
        local v44 = nil
        for key_3, value_7 in tbl_9 do
            value_7.Visible = key_3 <= a11
            if key_3 <= a10 then
                v44 = Colors_upv_1.Accent
            else
                v44 = Color3.fromRGB(60, 64, 78)
            end
            value_7.BackgroundColor3 = v44
        end
    end
    local function refreshState(a12)
        --[[
          name: refreshState
          line: 445
          upvalues:
            tbl_upv_4 (copy, index: 1)
            u14 (ref,  index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            reserveOf (copy, index: 4)
            setPips (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
        ]]
        local v45 = tbl_upv_4[a12]
        local tool_1 = v45.tool
        local v46, v47 = nil, nil
        if tool_1 then
            v46 = tool_1:GetAttribute("Ammo")
            local v48 = tool_1:GetAttribute("MaxAmmo")
            local v49 = tool_1:GetAttribute("Charges")
            local v50 = tool_1:GetAttribute("MaxCharges")
            local v51
            if type(v46) == "number" then
                v51 = v46
            elseif type(v49) ~= "number" then
                v51 = nil
            else
                v51 = v49
            end
            local v52
            if type(v46) ~= "number" then
                if type(v50) ~= "number" then
                    v52 = nil
                else
                    v52 = v50
                end
            elseif type(v48) ~= "number" then
                v52 = nil
            else
                v52 = v48
            end
            v47 = reserveOf(WeaponInfo_upv_1.AmmoOf(v45.weaponId))
            if v47 then
                v51, v52 = v47, nil
            end
            local v54 = nil
            if v51 then
                if v52 and v52 <= 6 and v52 > 1 then
                    v45.pips.Visible = true
                    v45.ammo.Text = ""
                    setPips(v45, v51, v52)
                else
                    v45.pips.Visible = false
                    v45.ammo.Text = tostring(v51)
                end
                local ammo_1 = v45.ammo
                if v51 <= 0 then
                    v54 = Colors_upv_1.Danger
                else
                    v54 = Colors_upv_1.Text
                end
                ammo_1.TextColor3 = v54
                if v45.lastAmmo and v51 < v45.lastAmmo then
                    UI_upv_1.Bump(v45.ammo, 0.2)
                end
                v45.lastAmmo = v51
            else
                v45.ammo.Text = ""
                v45.pips.Visible = false
                v45.lastAmmo = nil
            end
            v52 = tool_1:GetAttribute("Reloading") == true
            if v52 ~= v45.reload.Visible then
                v45.reload.Visible = v52
                if not (v52) and v51 and v51 > 0 then
                    UI_upv_1.Pop(v45.ammo, 1.4)
                end
            end
            if v52 then
                v54 = tool_1:GetAttribute("ReloadEndsAt")
                local v55 = v49
            else
                local v55
                v54, v55 = nil, v49
            end
            u14(v45, "reload", v54)
            u14(v45, "cooldown", tool_1:GetAttribute("Cooldown"))
            local v55 = nil
            v52 = (type(v49) == "number") and ((type(v50) == "number") and (v50 <= v55))
            v54 = v52 or tool_1:GetAttribute("NextCharge")
            u14(v45, "regen", v54)
        else
            v45.ammo.Text = ""
            v45.pips.Visible = false
            v45.reload.Visible = false
            for key_4 in v45.timers do
                u14(v45, key_4, nil)
            end
        end
    end
    local function paintSelection(a13)
        --[[
          name: paintSelection
          line: 503
          upvalues:
            tbl_upv_4 (copy, index: 1)
            u4 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            WeaponIcon_upv_1 (copy, index: 6)
        ]]
        local v56 = nil
        for key_5, value_8 in tbl_upv_4 do
            local v57 = key_5 == u4
            local v58 = value_8.tool ~= nil
            local v59 = UDim2.fromOffset(value_8.holder.Position.X.Offset, (v57 and 0) or 12)
            if a13 then
                UI_upv_1.Tween(value_8.holder, Theme_upv_1.Tween.PopSmall, {Position = v59})
            else
                value_8.holder.Position = v59
            end
            local stroke_1 = value_8.stroke
            if v57 then
                v56 = Colors_upv_1.Accent
            else
                v56 = Colors_upv_1.Stroke
            end
            stroke_1.Color = v56
            value_8.stroke.Thickness = (v57 and 3) or 2
            value_8.stroke.Transparency = (v57 and 0) or 0.7
            value_8.face.BackgroundTransparency = (v57 and 0.05) or ((v58 and 0.2) or 0.5)
            WeaponIcon_upv_1.SetDim(value_8.icon, not v58)
        end
    end
    local function rebuild()
        --[[
          name: rebuild
          line: 521
          upvalues:
            toolsBySlot (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            refreshState (copy, index: 3)
            u4 (ref,  index: 4)
            tbl_upv_1 (copy, index: 5)
            WeaponIcon_upv_1 (copy, index: 6)
            u12 (ref,  index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
            tbl_upv_3 (copy, index: 9)
            u5 (ref,  index: 10)
            u6 (ref,  index: 11)
            paintSelection (copy, index: 12)
            a1 (copy, index: 13)
            UI_upv_1 (copy, index: 14)
            u2 (copy, index: 15)
            State_upv_1 (copy, index: 16)
            WeaponInfo_upv_1 (copy, index: 17)
            u3 (copy, index: 18)
            Theme_upv_1 (copy, index: 19)
            u7 (ref,  index: 20)
            layout (copy, index: 21)
        ]]
        local u16 = toolsBySlot()
        local v60 = false
        local v61 = nil
        for key_upv_6, value_9 in tbl_upv_4 do
            local v62 = u16[key_upv_6]
            if v62 ~= value_9.tool then
                if value_9.conn then
                    value_9.conn:Disconnect()
                    value_9.conn = nil
                end
                value_9.reload.Visible = false
                value_9.lastAmmo = nil
                value_9.tool = v62
                if v62 then
                    value_9.conn = v62.AttributeChanged:Connect(
                        function()
                            --[[
                              line: 535
                              upvalues:
                                refreshState (copy, index: 1)
                                key_upv_6 (copy, index: 2)
                                u4 (ref,  index: 3)
                                tbl_upv_1 (copy, index: 4)
                            ]]
                            refreshState(key_upv_6)
                            if key_upv_6 ~= u4 or not tbl_upv_1.RefreshCrosshairAmmo then
                                return
                            end
                            tbl_upv_1.RefreshCrosshairAmmo()
                        end
                    )
                end
            end
            v61 = v62
            v61 = v61 and (v62:GetAttribute("WeaponId"))
            if type(v61) ~= "string" then
                if v62 then
                    v61 = v62.Name
                else
                    v61 = nil
                end
            end
            if v61 ~= value_9.weaponId then
                value_9.weaponId = v61
                WeaponIcon_upv_1.Set(value_9.icon, v61)
            end
            refreshState(key_upv_6)
            if v62 then
                v60 = true
            end
        end
        local v63 = nil
        if u12 then
            local _ = u12.character
        else
            v63 = LocalPlayer_upv_1.Character
        end
        local v64 = v63 and (v63:FindFirstChildOfClass("Tool"))
        local v65, v66 = nil, nil
        if v64 then
            v65 = v64:GetAttribute("SlotIndex")
            local v67
            if type(v65) == "number" and v65 >= 1 and v65 <= 6 then
                v67 = v65
            else
                v66 = v64:GetAttribute("Slot")
                if type(v66) ~= "string" then
                    v67 = nil
                else
                    v67 = tbl_upv_3[v66]
                end
            end
            u16 = v67 or 0
        else
            u16 = 0
        end
        if u16 == 0 then
            v63 = nil
        else
            v63 = tbl_upv_4[u16].weaponId
        end
        if u16 == u4 and v63 == u5 then
            paintSelection(false)
        else
            if u4 ~= 0 and u16 ~= u4 then
                u6 = u4
            end
            u4 = u16
            u5 = v63
            paintSelection(true)
            a1.HeldWeaponChanged:Fire(v63)
            if u16 ~= 0 and tbl_upv_4[u16].tool then
                local v68 = tbl_upv_4[u16]
                UI_upv_1.Pop(v68.icon, 0.8)
                local v69 = ((State_upv_1.InMatch()) and -70) or -4
                u2.Position = UDim2.new(0.5, 0, 0, v69)
                u2.Text = string.upper(WeaponInfo_upv_1.Name(v68.weaponId))
                u2.TextTransparency = 0
                u3.Transparency = 0.1
                task.delay(
                    1.1,
                    function()
                        --[[
                          line: 573
                          upvalues:
                            u4 (ref,  index: 1)
                            u16 (copy, index: 2)
                            UI_upv_1 (copy, index: 3)
                            u2 (copy, index: 4)
                            Theme_upv_1 (copy, index: 5)
                            u3 (copy, index: 6)
                        ]]
                        if u4 ~= u16 then
                            return
                        end
                        UI_upv_1.Tween(u2, Theme_upv_1.Tween.Slow, {TextTransparency = 1})
                        UI_upv_1.Tween(u3, Theme_upv_1.Tween.Slow, {Transparency = 1})
                    end
                )
            end
        end
        tbl_upv_1.HasTools = v60
        v63 = 0
        for key_7, value_10 in tbl_upv_4 do
            if value_10.tool then
                v63 = key_7
            end
        end
        local v71 = math.max(v63, 1)
        if v71 ~= u7 then
            u7 = v71
            layout()
            a1.HotbarChanged:Fire()
        end
        tbl_upv_1.RefreshVisible()
    end
    local u17 = false
    local function queueRebuild()
        --[[
          name: queueRebuild
          line: 600
          upvalues:
            u17 (ref, index: 1)
        ]]
        if u17 then
            return
        end
        u17 = true
        task.defer(function() end)
    end
    local tbl_upv_11 = {}
    local function watch(a14)
        --[[
          name: watch
          line: 612
          upvalues:
            tbl_upv_11 (copy, index: 1)
            queueRebuild (copy, index: 2)
        ]]
        if not a14 then
            return
        end
        table.insert(tbl_upv_11, a14.ChildAdded:Connect(queueRebuild))
        table.insert(tbl_upv_11, a14.ChildRemoved:Connect(queueRebuild))
    end
    local function rewatch()
        --[[
          name: rewatch
          line: 619
          upvalues:
            tbl_upv_11 (copy, index: 1)
            u12 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            queueRebuild (copy, index: 4)
            u17 (ref,  index: 5)
        ]]
        for _, value_11 in tbl_upv_11 do
            value_11:Disconnect()
        end
        table.clear(tbl_upv_11)
        local v72
        if u12 then
            v72 = u12.backpack
        else
            v72 = LocalPlayer_upv_1:FindFirstChildOfClass("Backpack")
        end
        if v72 then
            table.insert(tbl_upv_11, v72.ChildAdded:Connect(queueRebuild))
            table.insert(tbl_upv_11, v72.ChildRemoved:Connect(queueRebuild))
        end
        local v73
        if u12 then
            v73 = u12.character
        else
            v73 = LocalPlayer_upv_1.Character
        end
        if v73 then
            table.insert(tbl_upv_11, v73.ChildAdded:Connect(queueRebuild))
            table.insert(tbl_upv_11, v73.ChildRemoved:Connect(queueRebuild))
        end
        if u17 then
            return
        end
        u17 = true
        task.defer(function() end)
    end
    LocalPlayer_upv_1.ChildAdded:Connect(
        function(a15)
            --[[
              line: 628
              upvalues:
                rewatch (copy, index: 1)
            ]]
            if not a15:IsA("Backpack") then
                return
            end
            rewatch()
        end
    )
    local u18 = UI_upv_1.new("Frame", {Name = "CrosshairAmmo", Visible = false, AnchorPoint = Vector2.new(0, 0), Position = UDim2.new(0.5, 34, 0.5, 26), Size = UDim2.fromOffset(240, 26), Parent = a1.Canvas.HUD})
    local u19 = UI_upv_1.DisplayText({StrokeThickness = 1.5, Name = "Count", Text = "12", TextSize = 22, Size = UDim2.fromOffset(60, 26), TextXAlignment = Enum.TextXAlignment.Left, Parent = u18})
    local u20 = UI_upv_1.DisplayText({StrokeThickness = 1.5, Text = "OUT OF ARROWS", Name = "Out", Visible = false, TextSize = 18, Size = UDim2.fromOffset(240, 26), TextColor3 = Colors_upv_1.Danger, TextXAlignment = Enum.TextXAlignment.Left, Parent = u18})
    local u21 = -1
    local function refreshCrosshairAmmo()
        --[[
          name: refreshCrosshairAmmo
          line: 665
          upvalues:
            u4 (ref,  index: 1)
            tbl_upv_4 (copy, index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            reserveOf (copy, index: 4)
            a1 (copy, index: 5)
            u1 (copy, index: 6)
            u18 (copy, index: 7)
            u21 (ref,  index: 8)
            u20 (copy, index: 9)
            u19 (copy, index: 10)
            Colors_upv_1 (copy, index: 11)
            UI_upv_1 (copy, index: 12)
        ]]
        local v74
        if u4 == 0 then
            v74 = nil
        else
            v74 = tbl_upv_4[u4]
        end
        local v75 = v74 and (WeaponInfo_upv_1.AmmoOf(v74.weaponId))
        local v76 = reserveOf(v75)
        local v77 = a1.PlayerGui:FindFirstChild("CombatHUD") ~= nil
        local v78 = u1.Visible and ((v76 ~= nil) and (not v77))
        u18.Visible = v78
        if v78 and v74 then
            local tool_2 = v74.tool
            local v79 = tool_2 and (tool_2:GetAttribute("Ammo"))
            local v80
            if type(v79) ~= "number" then
                v80 = 0
            else
                v80 = v79
            end
            local v81 = v76 + v80
            local v82 = WeaponInfo_upv_1.AmmoDef(v75)
            u20.Text = "OUT OF " .. string.upper((v82 and (v82.name)) or "AMMO")
            u20.Visible = v81 <= 0
            u19.Visible = v81 > 0
            u19.Text = tostring(v81)
            local v83
            if v81 <= 3 then
                v83 = Colors_upv_1.Warning
            else
                v83 = Colors_upv_1.Text
            end
            u19.TextColor3 = v83
            if v81 ~= u21 then
                if (v81 < u21) and (v81 > 0) then
                    UI_upv_1.Bump(u19, 0.15)
                elseif v81 <= 0 and u21 > 0 then
                    UI_upv_1.Pop(u20, 1.3)
                end
                u21 = v81
            end
            return
        end
        u21 = -1
    end
    tbl_upv_1.RefreshCrosshairAmmo = refreshCrosshairAmmo
    a1.HeldWeaponChanged:Connect(refreshCrosshairAmmo)
    local tbl_upv_12 = {}
    local function hookAmmoAttrs(a16)
        --[[
          name: hookAmmoAttrs
          line: 698
          upvalues:
            tbl_upv_12 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            refreshState (copy, index: 3)
            refreshCrosshairAmmo (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
        ]]
        for _, value_12 in tbl_upv_12 do
            value_12:Disconnect()
        end
        table.clear(tbl_upv_12)
        local function onAttr_1(a17)
            --[[
              name: onAttr
              line: 703
              upvalues:
                tbl_upv_4 (copy, index: 1)
                refreshState (copy, index: 2)
                refreshCrosshairAmmo (copy, index: 3)
            ]]
            if string.sub(a17, 1, 5) ~= "Ammo_" then
                return
            end
            for key_8 in tbl_upv_4 do
                refreshState(key_8)
            end
            refreshCrosshairAmmo()
        end
        if a16 then
            table.insert(tbl_upv_12, a16.AttributeChanged:Connect(onAttr_1))
        end
        table.insert(tbl_upv_12, LocalPlayer_upv_1.AttributeChanged:Connect(onAttr_1))
    end
    hookAmmoAttrs(LocalPlayer_upv_1.Character)
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function(a18)
            --[[
              line: 718
              upvalues:
                rewatch (copy, index: 1)
                hookAmmoAttrs (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
            ]]
            task.defer(rewatch)
            hookAmmoAttrs(a18)
            local v84 = a18:WaitForChild("Humanoid", 10)
            if not v84 or not v84:IsA("Humanoid") then
                return
            end
            v84.Died:Connect(
                function()
                    --[[
                      line: 723
                      upvalues:
                        tbl_upv_1 (copy, index: 1)
                    ]]
                    tbl_upv_1.RefreshVisible()
                end
            )
        end
    )
    rewatch()
    local function humanoid()
        --[[
          name: humanoid
          line: 731
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
        ]]
        local Character_1 = LocalPlayer_upv_1.Character
        local v85 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
        return v85
    end
    local u22 = nil
    local function combat()
        --[[
          name: combat
          line: 739
          upvalues:
            u22 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        if u22 == nil then
            local v86 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerScripts")
            local v87 = v86 and (v86:FindFirstChild("Combat"))
            local v88 = v87 and (v87:FindFirstChild("Controller"))
            if v88 and v88:IsA("ModuleScript") then
                local success_2, v89 = pcall(require, v88)
                local v90
                if success_2 and type(v89) == "table" and type(v89.Equip) == "function" then
                    v90 = v89
                else
                    v90 = false
                end
                u22 = v90
            end
        end
        return u22 or nil
    end
    local u23 = function(a19)
        --[[
          line: 752
          upvalues:
            tbl_upv_4 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            u12 (ref,  index: 4)
            combat (copy, index: 5)
            u17 (ref,  index: 6)
            rebuild (copy, index: 7)
        ]]
        local v91 = tbl_upv_4[a19]
        if v91 and v91.tool then
            local Character_2 = LocalPlayer_upv_1.Character
            local v92 = Character_2 and (Character_2:FindFirstChildOfClass("Humanoid"))
            if v92 and not (v92.Health <= 0) and not (u12) then
                local v93 = combat()
                local v94 = v91.tool.Parent == LocalPlayer_upv_1.Character
                if v93 and type(v93.Wanted) == "function" then
                    v94 = v94 and v93.Wanted() == v91.tool
                end
                if v94 then
                    UI_upv_1.Bump(v91.icon, 0.1)
                else
                    if v93 then
                        v93.Equip(v91.tool)
                    else
                        Character_2:EquipTool(v91.tool)
                    end
                    if not u17 then
                        u17 = true
                        task.defer(
                            function()
                                --[[
                                  line: 605
                                  upvalues:
                                    u17 (ref,  index: 1)
                                    rebuild (copy, index: 2)
                                ]]
                                u17 = false
                                rebuild()
                            end
                        )
                    end
                end
                return
            end
            return
        end
        if not v91 then
            return
        end
        UI_upv_1.Shake(v91.holder, 4)
    end
    tbl_upv_1.Equip = u23
    a1.Debug.equip = function(a20)
        --[[
          line: 781
          upvalues:
            u23 (ref,  index: 1)
            u12 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            tbl_upv_3 (copy, index: 4)
        ]]
        u23(a20)
        local v96
        if u12 then
            v96 = u12.character
        else
            v96 = LocalPlayer_upv_1.Character
        end
        local v97 = v96 and (v96:FindFirstChildOfClass("Tool"))
        if not v97 then
            return 0
        end
        local v98 = v97:GetAttribute("SlotIndex")
        local v99
        if type(v98) == "number" and v98 >= 1 and v98 <= 6 then
            v99 = v98
        else
            local v100 = v97:GetAttribute("Slot")
            if type(v100) ~= "string" then
                v99 = nil
            else
                v99 = tbl_upv_3[v100]
            end
        end
        return v99 or 0
    end
    local function cycle(a21)
        --[[
          name: cycle
          line: 786
          upvalues:
            u4 (ref,  index: 1)
            tbl_upv_4 (copy, index: 2)
            u23 (ref,  index: 3)
        ]]
        local v101
        if u4 ~= 0 then
            v101 = u4
        else
            v101 = ((0 < a21) and 0) or 7
        end
        local v102 = nil
        for n_3 = 1, 6 do
            v102 = ((v101 - 1) + (a21 * n_3)) % 6 + 1
            if not (tbl_upv_4[v102].tool) then
                continue
            end
            u23(v102)
            return
        end
    end
    local function inputBlocked(a22)
        --[[
          name: inputBlocked
          line: 797
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            u1 (copy, index: 3)
        ]]
        if not (a22) and not (UserInputService_upv_1:GetFocusedTextBox()) then
            if not (a1.MenuManager.RecentlyOpen(0.2)) and not (a1.HudHidden) then
                return not u1.Visible
            end
            return true
        end
        return true
    end
    local function equipLast()
        --[[
          name: equipLast
          line: 807
          upvalues:
            u6 (ref,  index: 1)
            u4 (ref,  index: 2)
            tbl_upv_4 (copy, index: 3)
            u23 (ref,  index: 4)
        ]]
        if u6 == 0 or u6 == u4 or not tbl_upv_4[u6].tool then
            return
        end
        u23(u6)
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a23, a24)
            --[[
              line: 812
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
                UserInputService_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                u1 (copy, index: 4)
                u6 (ref,  index: 5)
                u4 (ref,  index: 6)
                tbl_upv_4 (copy, index: 7)
                u23 (ref,  index: 8)
                cycle (copy, index: 9)
                tbl_upv_2 (copy, index: 10)
            ]]
            local v103 = Keybinds_upv_1.IsPad(a23, "PrevItem")
            local v104 = Keybinds_upv_1.IsPad(a23, "NextItem")
            local v105 = Keybinds_upv_1.IsPad(a23, "LastItem")
            local v107 = nil
            if not (v103) and not (v104) then
                if not (v105) then
                    v107 = Keybinds_upv_1.ActionOf(a23)
                    if v107 then
                        if a24 or UserInputService_upv_1:GetFocusedTextBox() or a1.MenuManager.RecentlyOpen(0.2) or a1.HudHidden then
                            v107 = true
                        else
                            v107 = not u1.Visible
                        end
                        if not (v107) then
                            local v108 = tbl_upv_2[v107]
                            if v108 then
                                u23(v108)
                            elseif v107 == "LastItem" and u6 ~= 0 and u6 ~= u4 and tbl_upv_4[u6].tool then
                                u23(u6)
                            end
                            return
                        end
                    end
                    return
                end
            end
            if UserInputService_upv_1:GetFocusedTextBox() or a1.MenuManager.RecentlyOpen(0.2) or a1.HudHidden then
                v107 = true
            else
                v107 = not u1.Visible
            end
            if (v107) or (a1.MenuManager.PadBlocked()) then
                return
            end
            if v105 then
                if u6 ~= 0 and u6 ~= u4 and tbl_upv_4[u6].tool then
                    u23(u6)
                    return
                end
            else
                cycle((v103 and -1) or 1)
            end
        end
    )
    UserInputService_upv_1.InputChanged:Connect(
        function(a25, a26)
            --[[
              line: 839
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u1 (copy, index: 3)
                cycle (copy, index: 4)
            ]]
            if a25.UserInputType == Enum.UserInputType.MouseWheel then
                local v109
                if a26 or UserInputService_upv_1:GetFocusedTextBox() or a1.MenuManager.RecentlyOpen(0.2) or a1.HudHidden then
                    v109 = true
                else
                    v109 = not u1.Visible
                end
                if (v109) then
                    return
                end
                cycle(((a25.Position.Z > 0) and -1) or 1)
            end
        end
    )
    function tbl_upv_1.RefreshVisible()
        --[[
          name: RefreshVisible
          line: 846
          upvalues:
            tbl_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            u12 (ref,  index: 4)
            u1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
        ]]
        local v110 = (tbl_upv_1.HasTools == true) and (not a1.HudHidden and (State_upv_1.IsAlive() and ((State_upv_1.Get("CombatMode") ~= false) and (not State_upv_1.Watching()))))
        if u12 then
            v110 = tbl_upv_1.HasTools == true
        end
        if tbl_upv_1.RefreshCrosshairAmmo then
            task.defer(tbl_upv_1.RefreshCrosshairAmmo)
        end
        if v110 == u1.Visible then
            return
        end
        u1.Visible = v110
        if not v110 then
            return
        end
        UI_upv_1.SlideIn(u1, Vector2.new(0, 30), Theme_upv_1.Tween.PopSmall)
    end
    a1.HudHiddenChanged:Connect(tbl_upv_1.RefreshVisible)
    State_upv_1.AttrChanged:Connect(
        function(a27)
            --[[
              line: 864
              upvalues:
                tbl_upv_1 (copy, index: 1)
            ]]
            if a27 ~= "Alive" and a27 ~= "State" and a27 ~= "CombatMode" and a27 ~= "Spectating" then
                return
            end
            tbl_upv_1.RefreshVisible()
        end
    )
    function tbl_upv_1.SetReplaySource(a28)
        --[[
          name: SetReplaySource
          line: 870
          upvalues:
            u12 (ref,  index: 1)
            rewatch (copy, index: 2)
            hookAmmoAttrs (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            tbl_upv_1 (copy, index: 5)
        ]]
        u12 = a28
        rewatch()
        local v111
        if a28 then
            v111 = a28.model
        else
            v111 = LocalPlayer_upv_1.Character
        end
        hookAmmoAttrs(v111)
        tbl_upv_1.RefreshVisible()
    end
    a1.Hotbar = tbl_upv_1
    a1.HotbarRoot = u1
end
return tbl_upv_1