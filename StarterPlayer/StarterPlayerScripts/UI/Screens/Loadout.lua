local UserInputService_upv_1 = game:GetService("UserInputService")
local RunService_upv_1 = game:GetService("RunService")
local TextService_upv_1 = game:GetService("TextService")
local TextChatService_upv_1 = game:GetService("TextChatService")
local StarterGui_upv_1 = game:GetService("StarterGui")
local u1 = nil
local function hideChat()
    --[[
      name: hideChat
      line: 41
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 then
        return
    end
    local tbl_1 = {}
    pcall(function() end)
    u1 = tbl_1
end
local function restoreChat()
    --[[
      name: restoreChat
      line: 65
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
local tbl_upv_2 = {}
local fromRGB_1 = Color3.fromRGB
local tbl_upv_3 = {}
tbl_upv_3.bow = fromRGB_1(56, 189, 248)
tbl_upv_3.gun = fromRGB_1(251, 146, 60)
tbl_upv_3.melee = fromRGB_1(248, 113, 113)
tbl_upv_3.throwable = fromRGB_1(167, 139, 250)
tbl_upv_3.utility = fromRGB_1(250, 204, 21)
tbl_upv_3.healing = fromRGB_1(74, 222, 128)
tbl_upv_3.armor = fromRGB_1(148, 197, 255)
function tbl_upv_2.Init(a1)
    --[[
      name: Init
      line: 106
      upvalues:
        tbl_upv_3 (copy, index: 1)
        TextService_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        RunService_upv_1 (copy, index: 4)
        UserInputService_upv_1 (copy, index: 5)
        u1 (ref,  index: 6)
        TextChatService_upv_1 (copy, index: 7)
        StarterGui_upv_1 (copy, index: 8)
        restoreChat (copy, index: 9)
    ]]
    local layoutRows
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Economy_upv_1 = a1.Economy
    local function catOf(a2)
        --[[
          name: catOf
          line: 111
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v2 = WeaponInfo_upv_1.Get(a2)
        return (v2 and (tbl_upv_3[v2.category])) or (Colors_upv_1.Accent)
    end
    local function tintGradient(a3, a4, a5)
        --[[
          name: tintGradient
          line: 115
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        local v3 = UI_upv_1.Gradient(a4:Lerp(Colors_upv_1.Panel, 1 - a5), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115)
        v3.Parent = a3
        return v3
    end
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 138
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Close("Loadout")
    end
    local u2 = UI_upv_1.Window({HeaderHeight = 80, Subtitle = "Pick any gear up to 12 points.", Name = "Loadout", OpenSound = "Armory_Open", Title = "LOADOUT", Size = UDim2.fromOffset(1280, 720), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local Content_1 = u2.Content
    local u3 = {items = 0, ammo = 0, armor = false}
    u3.items = {}
    u3.ammo = {}
    local u4 = nil
    local u5 = nil
    local u6 = "all"
    local u7 = false
    local u8 = 0
    local u9 = 1
    local u10 = 1
    local u11 = nil
    local tbl_upv_4 = {}
    local u12 = nil
    local u13 = nil
    local u14 = nil
    local function cost()
        --[[
          name: cost
          line: 165
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        return WeaponInfo_upv_1.Cost(u3)
    end
    local function has(a6)
        --[[
          name: has
          line: 168
          upvalues:
            u3 (ref, index: 1)
        ]]
        local v4 = true
        if table.find(u3.items, a6) == nil then
            v4 = u3.armor == a6
        end
        return v4
    end
    local function missingAmmo(a7)
        --[[
          name: missingAmmo
          line: 180
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v5 = WeaponInfo_upv_1.AmmoNeeded(a7)
        local tbl_5 = {}
        local v6 = nil
        for _, value_1 in WeaponInfo_upv_1.AmmoTypes() do
            if value_1.optional or not (v5[value_1.id]) or not ((a7.ammo[value_1.id] or 0) < 1) then
                continue
            end
            v6 = false
            for v8, value_2 in WeaponInfo_upv_1.AmmoTypes() do
                v6 = v6 or value_2.as == value_1.id and (a7.ammo[value_2.id] or 0) >= 1
            end
            if not (v6) then
                table.insert(tbl_5, value_1.id)
            end
        end
        return tbl_5
    end
    local function ammoExtra(a8)
        --[[
          name: ammoExtra
          line: 197
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            missingAmmo (copy, index: 3)
        ]]
        local v8 = WeaponInfo_upv_1.IsArmor(a8) or WeaponInfo_upv_1.AmmoOf(a8)
        local v9 = v8 and (WeaponInfo_upv_1.AmmoDef(v8))
        if not v9 then
            return 0, nil
        end
        local tbl_6 = {}
        tbl_6.items = table.clone(u3.items)
        tbl_6.armor = u3.armor
        tbl_6.ammo = u3.ammo
        table.insert(tbl_6.items, a8)
        local v10 = ((not (table.find(missingAmmo(tbl_6), v9.id))) and 0) or (v9.points)
        return v10, v8
    end
    local function ammoUser(a9)
        --[[
          name: ammoUser
          line: 208
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v11 = WeaponInfo_upv_1.AmmoDef(a9)
        for _, value_3 in u3.items do
            local v12 = WeaponInfo_upv_1.AmmoOf(value_3)
            if not (v12) or v12 ~= a9 and (not (v11) or v11.as ~= v12) then
                continue
            end
            return value_3
        end
        return nil
    end
    local function ammoFloor(a10)
        --[[
          name: ammoFloor
          line: 219
          upvalues:
            u3 (ref,  index: 1)
            missingAmmo (copy, index: 2)
        ]]
        if (u3.ammo[a10] or 0) ~= 1 then
            return false
        end
        local tbl_7 = {}
        tbl_7.items = u3.items
        tbl_7.armor = u3.armor
        tbl_7.ammo = table.clone(u3.ammo)
        tbl_7.ammo[a10] = nil
        local v13 = #missingAmmo(tbl_7)
        local v14 = #missingAmmo(u3) < v13
        return v14
    end
    local function canAdd(a11)
        --[[
          name: canAdd
          line: 228
          upvalues:
            u3 (ref,  index: 1)
            Economy_upv_1 (copy, index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            ammoExtra (copy, index: 4)
        ]]
        local v15 = true
        if table.find(u3.items, a11) == nil then
            v15 = u3.armor == a11
        end
        if v15 then
            return false, "in", 0
        end
        if Economy_upv_1.IsLocked(a11) then
            return false, "locked", 0
        end
        v15 = WeaponInfo_upv_1.Points(a11)
        local v16 = WeaponInfo_upv_1.Cost(u3)
        if WeaponInfo_upv_1.IsArmor(a11) and u3.armor then
            v16 = v16 - WeaponInfo_upv_1.Points(u3.armor)
            local v17 = (v16 + v15) + ammoExtra(a11) - WeaponInfo_upv_1.Budget()
            if not (v17 > 0) then
                return true, nil, 0
            end
            local v18 = ((v16 + v15 <= WeaponInfo_upv_1.Budget()) and "ammo") or "points"
            return false, v18, v17
        end
        local v19 = WeaponInfo_upv_1.IsArmor(a11)
        if v19 then
            local v17 = (v16 + v15) + ammoExtra(a11) - WeaponInfo_upv_1.Budget()
            if not (v17 > 0) then
                return true, nil, 0
            end
            local v18 = ((v16 + v15 <= WeaponInfo_upv_1.Budget()) and "ammo") or "points"
            return false, v18, v17
        else
            local v20 = #u3.items
            if WeaponInfo_upv_1.MaxItems() <= v20 then
                return false, "full", 0
            end
            local v17 = (v16 + v15) + ammoExtra(a11) - WeaponInfo_upv_1.Budget()
            if not (v17 > 0) then
                return true, nil, 0
            end
            local v18 = ((v16 + v15 <= WeaponInfo_upv_1.Budget()) and "ammo") or "points"
            return false, v18, v17
        end
    end
    local u15 = UI_upv_1.new("Frame", {Name = "Slots", Position = UDim2.fromOffset(300, 12), Size = UDim2.new(0, 700, 0, 56), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u2.Header})
    local tbl_upv_8 = {}
    local u16 = nil
    local u17 = nil
    for n_upv_1 = 1, 5 do
        local u18 = UI_upv_1.new("TextButton", {Name = "Slot" .. n_upv_1, Size = UDim2.fromOffset(140, 56), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.35, LayoutOrder = n_upv_1, [1] = UI_upv_1.Corner(12), Parent = u15})
        local v21 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9)
        v21.Parent = u18
        local v22 = UI_upv_1.new("Frame", {Name = "Tile", Position = UDim2.fromOffset(6, 6), Size = UDim2.fromOffset(44, 44), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(9), Parent = u18})
        local v23 = UI_upv_1.Gradient(Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.7), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115)
        v23.Parent = v22
        local v24 = UI_upv_1.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95), Parent = v22})
        local u19 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "SlotName", TextSize = 15, Position = UDim2.fromOffset(58, 8), Size = UDim2.new(1, -86, 0, 20), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u18})
        local v25 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", TextSize = 12, Position = UDim2.fromOffset(58, 30), Size = UDim2.new(1, -62, 0, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u18})
        local u20 = UI_upv_1.new("TextButton", {Name = "Rename", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -4, 1, -4), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.6, Visible = false, ZIndex = 3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u18})
        UI_upv_1.Icon("pencil", 16, Colors_upv_1.Text, {ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u20})
        local tbl_9 = {}
        tbl_9.Name = "NameBox"
        tbl_9.AutoLocalize = false
        tbl_9.Position = UDim2.fromOffset(54, 5)
        tbl_9.Size = UDim2.new(1, -58, 0, 26)
        tbl_9.Text = ""
        tbl_9.PlaceholderText = a1.Loc.T("LOADOUT " .. n_upv_1)
        tbl_9.PlaceholderColor3 = Colors_upv_1.TextMuted
        tbl_9.ClearTextOnFocus = false
        tbl_9.FontFace = Fonts_upv_1.Bold
        tbl_9.TextSize = 15
        tbl_9.TextColor3 = Colors_upv_1.Text
        tbl_9.TextXAlignment = Enum.TextXAlignment.Left
        tbl_9.BackgroundColor3 = Colors_upv_1.Inset
        tbl_9.BackgroundTransparency = 0.05
        tbl_9.Visible = false
        tbl_9.ZIndex = 4
        tbl_9[1], tbl_9[2] = UI_upv_1.Corner(6), UI_upv_1.Padding(0, 6, 0, 6)
        tbl_9.Parent = u18
        local u21 = UI_upv_1.new("TextBox", tbl_9)
        v24.Visible = false
        tbl_upv_8[n_upv_1] = {btn = u18, stroke = v21, tile = v22, tileGrad = v23, icon = v24, name = u19, sub = v25, pencil = u20, box = u21, numL = UI_upv_1.new("TextLabel", {ZIndex = 2, Name = "Num", TextSize = 22, Size = UDim2.fromScale(1, 1), Text = tostring(n_upv_1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextDim, Parent = v22})}
        u18.MouseEnter:Connect(
            function()
                --[[
                  line: 357
                  upvalues:
                    n_upv_1 (copy, index: 1)
                    u9 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    u18 (copy, index: 4)
                    a1 (copy, index: 5)
                ]]
                if n_upv_1 == u9 or (UI_upv_1.Touch) then
                    return
                end
                u18.BackgroundTransparency = 0.15
                a1.Sounds.Play("Hover")
            end
        )
        u18.MouseLeave:Connect(
            function()
                --[[
                  line: 363
                  upvalues:
                    u12 (ref, index: 1)
                ]]
                u12()
            end
        )
        u18.Activated:Connect(
            function()
                --[[
                  line: 366
                  upvalues:
                    u16 (ref,  index: 1)
                    n_upv_1 (copy, index: 2)
                    u9 (ref,  index: 3)
                    UI_upv_1 (copy, index: 4)
                    u18 (copy, index: 5)
                    u13 (ref,  index: 6)
                ]]
                if u16 == n_upv_1 then
                    return
                end
                if n_upv_1 ~= u9 then
                    u13(n_upv_1)
                else
                    UI_upv_1.Bump(u18, 0.04)
                end
            end
        )
        u20.Activated:Connect(
            function()
                --[[
                  line: 376
                  upvalues:
                    u16 (ref,  index: 1)
                    n_upv_1 (copy, index: 2)
                    u21 (copy, index: 3)
                    tbl_upv_4 (copy, index: 4)
                    State_upv_1 (copy, index: 5)
                    u19 (copy, index: 6)
                    u20 (copy, index: 7)
                    a1 (copy, index: 8)
                ]]
                if u16 then
                    return
                end
                u16 = n_upv_1
                u21.Text = tbl_upv_4[n_upv_1] or State_upv_1.LoadoutCustomName(n_upv_1)
                u21.Visible = true
                u19.Visible = false
                u20.Visible = false
                u21:CaptureFocus()
                a1.Sounds.Play("Click")
            end
        )
        u21:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 388
                  upvalues:
                    u21 (copy, index: 1)
                ]]
                if not utf8.len(u21.Text) or not (utf8.len(u21.Text) > 16) then
                    return
                end
                u21.Text = string.sub(u21.Text, 1, (utf8.offset(u21.Text, 17) or 17) - 1)
            end
        )
        u21.FocusLost:Connect(
            function()
                --[[
                  line: 393
                  upvalues:
                    u17 (ref,  index: 1)
                    n_upv_1 (copy, index: 2)
                ]]
                u17(n_upv_1)
            end
        )
        local u22 = n_upv_1
    end
    local function layoutSlots()
        --[[
          name: layoutSlots
          line: 434
          upvalues:
            State_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u15 (copy, index: 4)
            tbl_upv_8 (copy, index: 5)
            u9 (ref,  index: 6)
        ]]
        local v27 = State_upv_1.LoadoutSlotCount()
        local Offset_1 = u2.Holder.Size.X.Offset
        local v28 = ((UI_upv_1.Compact) and 250) or 290
        local v29 = ((UI_upv_1.Compact) and 66) or 56
        local v30 = ((UI_upv_1.Compact) and 7) or 12
        local CloseButton_1 = u2.CloseButton
        if CloseButton_1 then
            CloseButton_1.Size = UDim2.fromOffset(v29, v29)
            CloseButton_1.Position = UDim2.new(1, -14, 0, v30)
        end
        local v31 = Offset_1 - v28 - ((v29 + 26) + 16)
        local v32 = ((v27 > 1) and 34) or 0
        local v33 = math.clamp(math.floor(((v31 - v32) - (6 * (v27 - 1))) / v27), 92, 260)
        u15.Position = UDim2.fromOffset(v28, v30)
        u15.Size = UDim2.fromOffset(v31, v29)
        local v34 = nil
        local v35 = nil
        for key_1, value_4 in tbl_upv_8 do
            local btn_1 = value_4.btn
            if key_1 <= v27 then
                v34 = true
            else
                v34 = false
            end
            btn_1.Visible = v34
            local btn_2 = value_4.btn
            if key_1 ~= u9 then
                v35 = v33
            else
                v35 = v33 + v32
            end
            btn_2.Size = UDim2.fromOffset(v35, v29)
            local v36 = v29 - 20
            value_4.tile.Size = UDim2.fromOffset(v36, v36)
            value_4.tile.Position = UDim2.fromOffset(8, 10)
            value_4.name.Position = UDim2.fromOffset(v36 + 16, (v29 / 2) - 20)
            value_4.sub.Position = UDim2.fromOffset(v36 + 16, (v29 / 2) + 2)
            value_4.box.Position = UDim2.fromOffset(v36 + 12, (v29 / 2) - 23)
        end
        u2.Subtitle.Visible = not UI_upv_1.Compact
    end
    UI_upv_1.TouchChanged:Connect(
        function()
            --[[
              line: 469
              upvalues:
                layoutSlots (copy, index: 1)
            ]]
            task.defer(layoutSlots)
        end
    )
    u12 = function()
        --[[
          line: 472
          upvalues:
            layoutSlots (copy, index: 1)
            State_upv_1 (copy, index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            tbl_upv_8 (copy, index: 4)
            u9 (ref,  index: 5)
            u3 (ref,  index: 6)
            Colors_upv_1 (copy, index: 7)
            u16 (ref,  index: 8)
            tbl_upv_4 (copy, index: 9)
            a1 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
            u14 (ref,  index: 12)
            UI_upv_1 (copy, index: 13)
        ]]
        layoutSlots()
        local v37 = State_upv_1.LoadoutSlotCount()
        local v38 = State_upv_1.HasLoadoutSlots()
        local v39 = math.max(WeaponInfo_upv_1.Budget(), 1)
        local v40 = nil
        local v41 = nil
        local _ = nil
        local v42 = nil
        local v48 = nil
        local v49 = nil
        local v50 = nil
        local v43 = nil
        local v51 = nil
        for key_2, value_5 in tbl_upv_8 do
            if v37 < key_2 then
                continue
            end
            local v44 = key_2 == u9
            if v44 then
                v40 = u3
            else
                v40 = State_upv_1.LoadoutSlot(key_2)
            end
            local tileGrad_1 = value_5.tileGrad
            if v44 then
                v41 = ColorSequence.new(Colors_upv_1.AccentDark, Colors_upv_1.AccentDark)
            else
                v41 = ColorSequence.new(Colors_upv_1.Panel, Colors_upv_1.Panel)
            end
            tileGrad_1.Color = v41
            local numL_1 = value_5.numL
            if v44 then
                v41 = Colors_upv_1.Text
            else
                v41 = Colors_upv_1.TextDim
            end
            numL_1.TextColor3 = v41
            if u16 ~= key_2 then
                local v45 = tbl_upv_4[key_2]
                v41 = value_5.name
                if not (v45) or v45 == "" then
                    if v45 ~= "" then
                        v42 = a1.Loc.T(State_upv_1.LoadoutName(key_2))
                    else
                        v42 = a1.Loc.T("LOADOUT " .. key_2)
                    end
                    v41.Text = v42
                    local v46 = WeaponInfo_upv_1.Cost(v40)
                    v41 = value_5.btn
                    if v44 then
                        v42 = Colors_upv_1.Accent
                    else
                        v42 = Colors_upv_1.Raised
                    end
                    v41.BackgroundColor3 = v42
                    value_5.btn.BackgroundTransparency = (v44 and 0) or 0.35
                    local stroke_1 = value_5.stroke
                    if v44 then
                        v42 = Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.35)
                    else
                        v42 = Colors_upv_1.Stroke
                    end
                    stroke_1.Color = v42
                    value_5.stroke.Transparency = (v44 and 0.2) or 0.9
                    local name_1 = value_5.name
                    if v44 then
                        v42 = Colors_upv_1.Text
                    else
                        v42 = Colors_upv_1.TextDim
                    end
                    name_1.TextColor3 = v42
                    local sub_1 = value_5.sub
                    v42 = (v44 and "\226\156\147 EQUIPPED") or (string.format("%d / %d PTS", v46, v39))
                    sub_1.Text = v42
                    local sub_2 = value_5.sub
                    if v44 then
                        v42 = Colors_upv_1.Text
                    else
                        v42 = Colors_upv_1.TextMuted
                    end
                    sub_2.TextColor3 = v42
                    value_5.pencil.Visible = v44 and v38 and u16 ~= key_2
                    local v47 = value_5.tile.Size.X.Offset + 18
                    value_5.name.Size = UDim2.new(1, -v47, 0, 20)
                    v41 = value_5.sub
                    local v42 = UDim2.new
                    if not (v44) then
                        v43 = -v47
                        v41.Size = v42(1, v43, 0, 16)
                        continue
                    end
                    if v38 then
                        v43 = -(v47 + 30)
                    else
                        v43 = -v47
                    end
                    v41.Size = v42(1, v43, 0, 16)
                end
                v42 = v45
                v41.Text = v42
            end
            local v46 = WeaponInfo_upv_1.Cost(v40)
            v41 = value_5.btn
            if v44 then
                v48 = Colors_upv_1.Accent
            else
                v48 = Colors_upv_1.Raised
            end
            v41.BackgroundColor3 = v42
            value_5.btn.BackgroundTransparency = (v44 and 0) or 0.35
            local stroke_1 = value_5.stroke
            if v44 then
                v48 = Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.35)
            else
                v48 = Colors_upv_1.Stroke
            end
            stroke_1.Color = v42
            value_5.stroke.Transparency = (v44 and 0.2) or 0.9
            local name_1 = value_5.name
            if v44 then
                v48 = Colors_upv_1.Text
            else
                v48 = Colors_upv_1.TextDim
            end
            name_1.TextColor3 = v42
            local sub_1 = value_5.sub
            v42 = (v44 and "\226\156\147 EQUIPPED") or (string.format("%d / %d PTS", v46, v39))
            sub_1.Text = v42
            local sub_2 = value_5.sub
            if v44 then
                v48 = Colors_upv_1.Text
            else
                v48 = Colors_upv_1.TextMuted
            end
            sub_2.TextColor3 = v42
            v42 = v44 and v38 and u16 ~= key_2
            value_5.pencil.Visible = v44 and v38 and u16 ~= key_2
            local v47 = value_5.tile.Size.X.Offset + 18
            value_5.name.Size = UDim2.new(1, -v47, 0, 20)
            v41 = value_5.sub
            local v42 = UDim2.new
            if not (v44) then
                v43 = -v47
                v41.Size = v42(1, v43, 0, 16)
                continue
            end
            if v38 then
                v43 = -(v47 + 30)
            else
                v43 = -v47
            end
            v41.Size = v42(1, v43, 0, 16)
        end
        u14.Text = ((UI_upv_1.Gamepad) and "YOUR ITEMS  \194\183  HOTBAR ORDER") or "YOUR ITEMS  \194\183  HOTBAR KEYS 1\226\128\1476"
    end
    local u23 = UI_upv_1.new("Frame", {Name = "Left", Size = UDim2.new(0, 400, 1, 0), Parent = Content_1})
    local u22 = UI_upv_1.new("TextLabel", {Name = "Heading", Text = "YOUR ITEMS  \194\183  HOTBAR KEYS 1\226\128\1476", TextSize = 14, Size = UDim2.new(1, -120, 0, 18), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u23})
    u14 = u22
    u22 = UI_upv_1.new("TextLabel", {Text = "", Name = "Save", TextSize = 13, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(120, 18), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = u23})
    local u24 = UI_upv_1.new("Frame", {Name = "Points", Position = UDim2.fromOffset(0, 22), Size = UDim2.new(1, 0, 0, 58), Parent = u23})
    local u25 = UI_upv_1.new("Frame", {Name = "Line", Size = UDim2.new(1, -110, 0, 36), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Bottom), Parent = u24})
    local u26 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Number", Text = "", TextSize = 34, Size = UDim2.fromOffset(112, 36), TextXAlignment = Enum.TextXAlignment.Left, FontFace = Fonts_upv_1.Display, Parent = u25})
    local u27 = 0
    local function measureNum()
        --[[
          name: measureNum
          line: 556
          upvalues:
            u27 (ref,  index: 1)
            u26 (copy, index: 2)
        ]]
        u27 = u27 + 1
        local _ = u27
        local v1 = u26.Text
        local v2 = u26.TextSize
        task.spawn(function() end)
    end
    u26:GetPropertyChangedSignal("Text"):Connect(measureNum)
    local u28 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "POINTS", Name = "Word", TextSize = 15, Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u25})
    local u29 = UI_upv_1.new("TextLabel", {Text = "", Name = "Left", TextSize = 15, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 12), Size = UDim2.fromOffset(110, 22), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u24})
    local u30 = UI_upv_1.new("TextLabel", {Text = "", Name = "Helper", TextSize = 14, Position = UDim2.fromOffset(0, 60), Size = UDim2.new(1, 0, 0, 18), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u24})
    local tbl_upv_10 = {}
    tbl_upv_10.Name = "Bar"
    tbl_upv_10.Position = UDim2.fromOffset(0, 44)
    tbl_upv_10.Size = UDim2.new(1, 0, 0, 10)
    tbl_upv_10.BackgroundColor3 = Colors_upv_1.Inset
    tbl_upv_10.ClipsDescendants = true
    tbl_upv_10[1], tbl_upv_10[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
    tbl_upv_10.Parent = u24
    local u31 = UI_upv_1.new("Frame", tbl_upv_10)
    local u32 = UI_upv_1.new("Frame", {Name = "Ghost", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 0.6, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u31})
    tbl_upv_10 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u31})
    local u33 = UI_upv_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.15), Colors_upv_1.Accent, 0)
    u33.Parent = tbl_upv_10
    local u34 = UI_upv_1.new("Frame", {ZIndex = 3, Name = "Ticks", Size = UDim2.fromScale(1, 1), Parent = u31})
    local u35 = 0
    local function buildTicks(a12)
        --[[
          name: buildTicks
          line: 624
          upvalues:
            u35 (ref,  index: 1)
            u34 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        if a12 == u35 then
            return
        end
        u35 = a12
        u34:ClearAllChildren()
        for n_2 = 1, a12 - 1 do
            UI_upv_1.new("Frame", {BackgroundTransparency = 0.35, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(n_2 / a12, 0), Size = UDim2.new(0, 2, 1, 0), BackgroundColor3 = Colors_upv_1.Void, Parent = u34})
        end
    end
    local u36 = UI_upv_1.new("Frame", {Name = "Rows", Position = UDim2.fromOffset(0, 88), Size = UDim2.new(1, 0, 1, -88), Parent = u23})
    local tbl_upv_11 = {}
    local u37 = 48
    local u38 = 6
    local u39 = nil
    local function makeRow(a13)
        --[[
          name: makeRow
          line: 666
          upvalues:
            UI_upv_1 (copy, index: 1)
            u37 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            u36 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            u39 (ref,  index: 7)
        ]]
        local v48 = a13 == "armor"
        local new_1 = UI_upv_1.new
        local tbl_12 = {}
        local v49
        if v48 then
            v49 = "Armor"
        else
            v49 = "Row" .. a13
        end
        tbl_12.Name = v49
        tbl_12.Size = UDim2.new(1, 0, 0, u37)
        tbl_12.BackgroundColor3 = Colors_upv_1.Raised
        tbl_12.BackgroundTransparency = 0.5
        tbl_12[1] = UI_upv_1.Corner(12)
        tbl_12.Parent = u36
        local v50 = new_1("Frame", tbl_12)
        UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.93).Parent = v50
        local v51 = UI_upv_1.new("Frame", {Name = "Tile", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(u37 - 8, u37 - 8), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, [1] = UI_upv_1.Corner(9), Parent = v50})
        local v52 = UI_upv_1.Gradient(Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.7), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115)
        v52.Parent = v51
        local v53 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
        v53.Parent = v51
        local v54 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.92, 0.92), Parent = v51})
        local v55 = nil
        local v56 = nil
        local v57 = nil
        if v48 then
            v57 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Shield, {Name = "Shield", ImageTransparency = 0.3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.45, 0.45), ImageColor3 = Colors_upv_1.TextMuted, Parent = v51})
        else
            v55 = UI_upv_1.new("TextLabel", {Name = "Num", ZIndex = 3, TextSize = 12, Position = UDim2.fromOffset(4, 2), Size = UDim2.fromOffset(14, 14), Text = tostring(a13), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = v51})
            UI_upv_1.TextStroke(Colors_upv_1.Void, 1, 0.4).Parent = v55
            v56 = UI_upv_1.Icon("plus", 16, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v51})
        end
        local v58 = UI_upv_1.new("TextLabel", {Text = "", Name = "ItemName", TextSize = 17, Position = UDim2.fromOffset(u37 + 8, 0), Size = UDim2.new(1, -(u37 + 130), 1, 0), FontFace = Fonts_upv_1.Bold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v50})
        local v59 = UI_upv_1.new("Frame", {Name = "Cost", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -52, 0.5, 0), Size = UDim2.fromOffset(52, 24), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v50})
        local v60 = UI_upv_1.new("TextLabel", {Text = "", TextSize = 13, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v59})
        local v61 = UI_upv_1.IconButton({IconName = "cross", IconScale = 0.4, Transparency = 0.5, Name = "RemoveButton", Sound = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromOffset(36, 32), Color = Colors_upv_1.Raised, HoverColor = Colors_upv_1.Danger, Parent = v50})
        local tbl_upv_13 = {}
        tbl_upv_13.frame = v50
        tbl_upv_13.tile = v51
        tbl_upv_13.tileGrad = v52
        tbl_upv_13.tileStroke = v53
        tbl_upv_13.num = v55
        tbl_upv_13.plus = v56
        tbl_upv_13.shield = v57
        tbl_upv_13.icon = v54
        tbl_upv_13.name = v58
        tbl_upv_13.costPill = v59
        tbl_upv_13.costLabel = v60
        tbl_upv_13.remove = v61
        v61.Activated:Connect(
            function()
                --[[
                  line: 771
                  upvalues:
                    tbl_upv_13 (copy, index: 1)
                    u39 (ref,  index: 2)
                ]]
                if not tbl_upv_13.id then
                    return
                end
                u39(tbl_upv_13.id)
            end
        )
        return tbl_upv_13
    end
    tbl_upv_11[1] = makeRow(1)
    tbl_upv_11[2] = makeRow(2)
    tbl_upv_11[3] = makeRow(3)
    tbl_upv_11[4] = makeRow(4)
    tbl_upv_11[5] = makeRow(5)
    tbl_upv_11[6] = makeRow(6)
    local u40 = makeRow("armor")
    local u41 = UI_upv_1.new("Frame", {Name = "Ammo", Size = UDim2.new(1, 0, 0, 0), Parent = u36})
    local u42 = UI_upv_1.new("TextLabel", {Name = "Head", Text = "AMMO  \194\183  1 POINT PER BUNDLE", TextSize = 13, Size = UDim2.new(1, 0, 0, 18), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u41})
    local tbl_upv_14 = {}
    local u43 = nil
    local function ammoRow(a14)
        --[[
          name: ammoRow
          line: 798
          upvalues:
            tbl_upv_14 (copy, index: 1)
            WeaponInfo_upv_1 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            u37 (ref,  index: 5)
            Colors_upv_1 (copy, index: 6)
            u41 (copy, index: 7)
            WeaponIcon_upv_1 (copy, index: 8)
            Fonts_upv_1 (copy, index: 9)
            u43 (ref,  index: 10)
        ]]
        local v62 = tbl_upv_14[a14]
        if v62 then
            return v62
        end
        local v63 = WeaponInfo_upv_1.AmmoDef(a14)
        local v64
        if a14 ~= "arrows" then
            v64 = tbl_upv_3.gun
        else
            v64 = tbl_upv_3.bow
        end
        local u44 = UI_upv_1.new("Frame", {Name = a14, Size = UDim2.new(1, 0, 0, u37), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.35, [1] = UI_upv_1.Corner(12), Parent = u41})
        UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.93).Parent = u44
        local v65 = UI_upv_1.new("Frame", {Name = "Tile", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(u37 - 8, u37 - 8), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(9), Parent = u44})
        UI_upv_1.Gradient(v64:Lerp(Colors_upv_1.Panel, 0.7), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115).Parent = v65
        local v66 = UI_upv_1.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.86, 0.86), Parent = v65})
        WeaponIcon_upv_1.Set(v66, "ammo_" .. a14, {outline = true, glow = false, outlineTransparency = 0.5, outlineScale = 1.04, outlineColor = v64:Lerp(Color3.new(1, 1, 1), 0.55)})
        if v66:FindFirstChild("WeaponIcon") then
            local v67 = v66:FindFirstChildOfClass("ImageLabel")
            if v67 then
                for _, value_6 in v66:GetChildren() do
                    value_6:Destroy()
                end
                local Image_1 = UI_upv_1.Image
                local v68
                if a14 ~= "arrows" then
                    v68 = UI_upv_1.Assets.Icons.Headshot
                else
                    v68 = UI_upv_1.Assets.Icons.CrossedArrows
                end
                Image_1(v68, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), ImageColor3 = v64:Lerp(Color3.new(1, 1, 1), 0.35), Parent = v66})
            end
        else
            for _, value_6 in v66:GetChildren() do
                value_6:Destroy()
            end
            local Image_1 = UI_upv_1.Image
            local v68
            if a14 ~= "arrows" then
                v68 = UI_upv_1.Assets.Icons.Headshot
            else
                v68 = UI_upv_1.Assets.Icons.CrossedArrows
            end
            Image_1(v68, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), ImageColor3 = v64:Lerp(Color3.new(1, 1, 1), 0.35), Parent = v66})
        end
        local v69 = UI_upv_1.new("Frame", {Name = "NameRow", Position = UDim2.fromOffset(u37 + 8, 4), Size = UDim2.new(1, -(u37 + 150), 0.55, -4), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Bottom), Parent = u44})
        local new_2 = UI_upv_1.new
        local tbl_15 = {LayoutOrder = 1, FontFace = 0, TextSize = 17, Parent = 0, Text = 0}
        tbl_15.Size = UDim2.fromScale(0, 1)
        tbl_15.AutomaticSize = Enum.AutomaticSize.X
        tbl_15.Text = v63 and v63.name or a14
        tbl_15.FontFace = Fonts_upv_1.Bold
        tbl_15.Parent = v69
        local v71 = new_2("TextLabel", tbl_15)
        local v72 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, TextSize = 16, Text = "", Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = v64, Parent = v69})
        local v73 = UI_upv_1.new("TextLabel", {Text = "", TextSize = 12, Position = UDim2.new(0, u37 + 8, 0.55, 1), Size = UDim2.new(1, -(u37 + 150), 0.45, -4), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u44})
        local function stepBtn_1(a15, a16)
            --[[
              name: stepBtn
              line: 877
              upvalues:
                UI_upv_1 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
                u44 (copy, index: 3)
            ]]
            return UI_upv_1.IconButton({Transparency = 0.1, IconScale = 0.42, Name = a15, IconName = a16, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(38, 34), Color = Colors_upv_1.Raised, Parent = u44})
        end
        local v74 = stepBtn_1("Plus", "plus")
        local v75 = UI_upv_1.new("TextLabel", {Name = "Count", Text = "0", TextSize = 22, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(34, 30), FontFace = Fonts_upv_1.Display, Parent = u44})
        local v76 = stepBtn_1("Minus", "minus")
        local tbl_16 = {frame = u44, tile = v65, icon = v66, name = v71, amount = v72, sub = v73, count = v75, minus = v76, plus = v74, t = a14}
        tbl_upv_14[a14] = tbl_16
        v76.Activated:Connect(
            function()
                --[[
                  line: 902
                  upvalues:
                    u43 (ref,  index: 1)
                    a14 (copy, index: 2)
                ]]
                u43(a14, -1)
            end
        )
        v74.Activated:Connect(
            function()
                --[[
                  line: 905
                  upvalues:
                    u43 (ref,  index: 1)
                    a14 (copy, index: 2)
                ]]
                u43(a14, 1)
            end
        )
        return tbl_16
    end
    local u45 = UI_upv_1.new("Frame", {Name = "Right", Position = UDim2.fromOffset(418, 0), Size = UDim2.new(1, -418, 1, 0), Parent = Content_1})
    local v77 = UI_upv_1.new("Frame", {Name = "Tabs", Size = UDim2.new(1, 0, 0, 40), ZIndex = 2, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u45})
    local tbl_upv_17 = {}
    local u46 = UI_upv_1.new("ScrollingFrame", {Name = "Grid", ScrollBarThickness = 5, ScrollBarImageTransparency = 0.4, Position = UDim2.fromOffset(0, 50), Size = UDim2.new(1, 0, 1, -210), AutomaticCanvasSize = Enum.AutomaticSize.None, ScrollBarImageColor3 = Colors_upv_1.TextMuted, Parent = u45})
    local function rightW()
        --[[
          name: rightW
          line: 939
          upvalues:
            u2 (copy, index: 1)
        ]]
        return ((u2.Holder.Size.X.Offset - 44) - 400) - 18
    end
    local function screenPerDesign()
        --[[
          name: screenPerDesign
          line: 942
          upvalues:
            u46 (copy, index: 1)
            u2 (copy, index: 2)
        ]]
        return (math.max(u46.AbsoluteSize.X / math.max(((u2.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01))
    end
    local function cardH()
        --[[
          name: cardH
          line: 946
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return 128
        end
        return 164
    end
    local function detailH()
        --[[
          name: detailH
          line: 949
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return 104
        end
        return 156
    end
    local u47 = UI_upv_1.new("Frame", {Visible = false, Name = "LockedHeader", Size = UDim2.new(1, -8, 0, 44), Parent = u46})
    UI_upv_1.new("Frame", {Name = "Line", BackgroundTransparency = 0.88, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(1, -8, 0, 1), BackgroundColor3 = Colors_upv_1.Text, Parent = u47})
    local _ = UI_upv_1.new("TextLabel", {Text = "  LOCKED  \194\183  find shards in drops  ", TextSize = 13, BackgroundTransparency = 0, Name = "Label", ZIndex = 2, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, BackgroundColor3 = Colors_upv_1.Panel, Parent = u47})
    local function OnClick()
        --[[
          name: OnClick
          line: 991
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        if not tbl_upv_2._openCollection then
            return
        end
        tbl_upv_2._openCollection(nil)
    end
    local v97 = UI_upv_1.Button({Text = "COLLECTION", Name = "OpenCollection", Style = "Dark", ZIndex = 2, TextSize = 14, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0), Size = UDim2.fromOffset(150, 34), Parent = u47, OnClick = OnClick})
    local tbl_upv_18 = {}
    local tbl_upv_19 = {}
    local u48 = nil
    local function makeCard(a17)
        --[[
          name: makeCard
          line: 1030
          upvalues:
            tbl_upv_3 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u46 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            u5 (ref,  index: 7)
            u4 (ref,  index: 8)
            a1 (copy, index: 9)
            tbl_upv_2 (copy, index: 10)
            u48 (ref,  index: 11)
        ]]
        local v78 = tbl_upv_3[a17.category] or (Colors_upv_1.Accent)
        local new_3 = UI_upv_1.new
        local tbl_20 = {Parent = 0, Size = 0}
        tbl_20.Name = a17.id
        tbl_20.Size = UDim2.fromOffset(160, ((UI_upv_1.Compact) and 128) or 164)
        tbl_20.Parent = u46
        local v79 = new_3("TextButton", tbl_20)
        local u49 = UI_upv_1.GetScaleObj(v79, "HoverScale")
        local v80 = UI_upv_1.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.08, ClipsDescendants = true, [1] = UI_upv_1.Corner(14), Parent = v79})
        local v81 = UI_upv_1.Gradient(v78:Lerp(Colors_upv_1.Panel, 0.8), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115)
        v81.Parent = v80
        local v82 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9)
        v82.Parent = v80
        local v83 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.72, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 58), Size = UDim2.fromOffset(170, 150), ImageColor3 = v78, Parent = v80})
        local v84 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.new(1, -22, 1, -62), Parent = v80})
        local v85 = UI_upv_1.new("TextLabel", {Name = "ItemName", ZIndex = 3, TextSize = 17, Position = UDim2.new(0, 12, 1, -48), Size = UDim2.new(1, -24, 0, 22), Text = a17.name, FontFace = Fonts_upv_1.Bold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v80})
        local v86 = UI_upv_1.new("TextLabel", {Text = "", Name = "Status", ZIndex = 3, TextSize = 12, Position = UDim2.new(0, 12, 1, -26), Size = UDim2.new(1, -24, 0, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v80})
        local v87 = UI_upv_1.new("Frame", {Name = "Cost", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Size = UDim2.fromOffset(30, 30), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, ZIndex = 4, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v80})
        local v88 = UI_upv_1.new("TextLabel", {ZIndex = 4, TextSize = 17, Size = UDim2.fromScale(1, 1), Text = tostring(a17.points), FontFace = Fonts_upv_1.Display, Parent = v87})
        local v89 = UI_upv_1.new("Frame", {Name = "Check", Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = Colors_upv_1.Accent, Visible = false, ZIndex = 4, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v80})
        UI_upv_1.Icon("check", 18, Colors_upv_1.Text, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v89})
        local v90 = UI_upv_1.new("Frame", {Name = "Lock", Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(28, 28), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.25, Visible = false, ZIndex = 4, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v80})
        UI_upv_1.Image(UI_upv_1.Assets.Icons.Lock, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(15, 15), ImageColor3 = Colors_upv_1.TextDim, Parent = v90})
        local v91 = UI_upv_1.new("Frame", {Name = "ShardBar", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -8), Size = UDim2.new(1, -24, 0, 4), BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.1, Visible = false, ZIndex = 5, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v80})
        local v92 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Colors_upv_1.Accent, ZIndex = 5, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v91})
        local tbl_21 = {}
        tbl_21.Name = "Level"
        tbl_21.Position = UDim2.fromOffset(8, 8)
        tbl_21.AutomaticSize = Enum.AutomaticSize.X
        tbl_21.Size = UDim2.fromOffset(0, 24)
        tbl_21.BackgroundColor3 = Colors_upv_1.Void
        tbl_21.BackgroundTransparency = 0.3
        tbl_21.Visible = false
        tbl_21.ZIndex = 4
        tbl_21[1], tbl_21[2], tbl_21[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 8, 0, 8), UI_upv_1.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_21.Parent = v80
        local v93 = UI_upv_1.new("Frame", tbl_21)
        local v94 = UI_upv_1.Icon("chevUp", 11, Colors_upv_1.Text, {LayoutOrder = 0, ZIndex = 4, Name = "Ready", Parent = v93})
        v94.Visible = false
        tbl_21 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, RichText = true, Text = "LV 1", Name = "Text", TextSize = 14, ZIndex = 4, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_upv_1.Display, Parent = v93})
        local v95 = UI_upv_1.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 6, [1] = UI_upv_1.Corner(14), Parent = v80})
        local tbl_upv_22 = {visible = true, hover = false, y = 0, rendered = false}
        tbl_upv_22.id = a17.id
        tbl_upv_22.holder = v79
        tbl_upv_22.scale = u49
        tbl_upv_22.inner = v80
        tbl_upv_22.grad = v81
        tbl_upv_22.stroke = v82
        tbl_upv_22.glow = v83
        tbl_upv_22.icon = v84
        tbl_upv_22.costBadge = v87
        tbl_upv_22.costText = v88
        tbl_upv_22.check = v89
        tbl_upv_22.lock = v90
        tbl_upv_22.lv = v93
        tbl_upv_22.lvText = tbl_21
        tbl_upv_22.readyDot = v94
        tbl_upv_22.cbar = v91
        tbl_upv_22.cfill = v92
        tbl_upv_22.nameL = v85
        tbl_upv_22.status = v86
        tbl_upv_22.flash = v95
        v79.MouseEnter:Connect(
            function()
                --[[
                  line: 1209
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    tbl_upv_22 (copy, index: 2)
                    u5 (ref,  index: 3)
                    a17 (copy, index: 4)
                    u4 (ref,  index: 5)
                    a1 (copy, index: 6)
                    u49 (copy, index: 7)
                    Theme_upv_1 (copy, index: 8)
                    tbl_upv_2 (copy, index: 9)
                ]]
                if UI_upv_1.Touch then
                    return
                end
                tbl_upv_22.hover = true
                u5 = a17.id
                u4 = a17.id
                a1.Sounds.Play("Hover")
                UI_upv_1.Tween(u49, Theme_upv_1.Tween.PopSmall, {Scale = 1.035})
                tbl_upv_2._paintCard(tbl_upv_22)
                tbl_upv_2._paintDetail()
                tbl_upv_2._paintPoints()
            end
        )
        v79.MouseLeave:Connect(
            function()
                --[[
                  line: 1222
                  upvalues:
                    tbl_upv_22 (copy, index: 1)
                    u5 (ref,  index: 2)
                    a17 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u49 (copy, index: 5)
                    Theme_upv_1 (copy, index: 6)
                    tbl_upv_2 (copy, index: 7)
                ]]
                tbl_upv_22.hover = false
                if u5 == a17.id then
                    u5 = nil
                end
                UI_upv_1.Tween(u49, Theme_upv_1.Tween.Fast, {Scale = 1})
                tbl_upv_2._paintCard(tbl_upv_22)
                tbl_upv_2._paintPoints()
            end
        )
        v79.MouseButton1Down:Connect(
            function()
                --[[
                  line: 1231
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u49 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                ]]
                UI_upv_1.Tween(u49, Theme_upv_1.Tween.Instant, {Scale = 0.97})
            end
        )
        v79.MouseButton1Up:Connect(
            function()
                --[[
                  line: 1234
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u49 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    tbl_upv_22 (copy, index: 4)
                ]]
                local Tween_1 = UI_upv_1.Tween
                local PopSmall_1 = Theme_upv_1.Tween.PopSmall
                local tbl_23 = {Scale = 0}
                tbl_23.Scale = ((tbl_upv_22.hover) and 1.035) or 1
                Tween_1(u49, PopSmall_1, tbl_23)
            end
        )
        v79.SelectionGained:Connect(
            function()
                --[[
                  line: 1238
                  upvalues:
                    tbl_upv_22 (copy, index: 1)
                    u5 (ref,  index: 2)
                    a17 (copy, index: 3)
                    u4 (ref,  index: 4)
                    tbl_upv_2 (copy, index: 5)
                ]]
                tbl_upv_22.hover = true
                u5 = a17.id
                u4 = a17.id
                tbl_upv_2._paintCard(tbl_upv_22)
                tbl_upv_2._paintDetail()
                tbl_upv_2._paintPoints()
            end
        )
        v79.SelectionLost:Connect(
            function()
                --[[
                  line: 1246
                  upvalues:
                    tbl_upv_22 (copy, index: 1)
                    u5 (ref,  index: 2)
                    a17 (copy, index: 3)
                    tbl_upv_2 (copy, index: 4)
                ]]
                tbl_upv_22.hover = false
                if u5 == a17.id then
                    u5 = nil
                end
                tbl_upv_2._paintCard(tbl_upv_22)
                tbl_upv_2._paintPoints()
            end
        )
        v79.Activated:Connect(
            function()
                --[[
                  line: 1254
                  upvalues:
                    u4 (ref,  index: 1)
                    a17 (copy, index: 2)
                    u48 (ref,  index: 3)
                    tbl_upv_22 (copy, index: 4)
                ]]
                u4 = a17.id
                u48(a17.id, tbl_upv_22)
            end
        )
        return tbl_upv_22
    end
    local u50 = UI_upv_1.Panel({Name = "Detail", BackgroundTransparency = 0.2, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 156), Radius = UDim.new(0, 14), Parent = u45})
    local u51 = UI_upv_1.new("Frame", {Name = "Preview", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(140, 140), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = u50})
    local u52 = UI_upv_1.Gradient(Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.75), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115)
    u52.Parent = u51
    local u53 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.3, 1.3), ImageColor3 = Colors_upv_1.Accent, Parent = u51})
    local u54 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.92, 0.92), Parent = u51})
    local u55 = UI_upv_1.new("Frame", {Name = "Text", Position = UDim2.fromOffset(160, 12), Size = UDim2.new(1, -600, 1, -24), Parent = u50})
    local u56 = UI_upv_1.new("TextLabel", {Name = "ItemName", Text = "", TextSize = 24, Size = UDim2.new(1, 0, 0, 28), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u55})
    a1.Loc.Fit(u56, 17)
    local u57 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Sub", TextSize = 12, Position = UDim2.fromOffset(0, 30), Size = UDim2.new(1, 0, 0, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u55})
    local u58 = UI_upv_1.new("TextLabel", {Text = "", TextWrapped = true, Name = "Desc", TextSize = 14, Position = UDim2.fromOffset(0, 54), Size = UDim2.new(1, 0, 1, -54), FontFace = Fonts_upv_1.Medium, TextColor3 = Colors_upv_1.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = u55})
    local u59 = UI_upv_1.List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    local u60 = UI_upv_1.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -168, 0.5, 0), Size = UDim2.fromOffset(262, 98), [1] = u59, Parent = u50})
    local tbl_upv_24 = {}
    for n_3 = 1, 4 do
        local v96 = UI_upv_1.new("Frame", {Name = "Stat" .. n_3, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = n_3, Parent = u60})
        tbl_upv_24[n_3] = {
            frame = v96,
            label = UI_upv_1.new("TextLabel", {Text = "", TextSize = 12, Size = UDim2.fromOffset(70, 20), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = v96}),
            bar = UI_upv_1.Bar({Stroke = false, Position = UDim2.fromOffset(72, 7), Size = UDim2.fromOffset(92, 7), Color = Colors_upv_1.Accent, Parent = v96}),
            value = UI_upv_1.new("TextLabel", {Text = "", TextSize = 12, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(92, 20), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v96})
        }
        layoutRows = n_3
    end
    local u61 = UI_upv_1.Button({Style = "Primary", Name = "Action", Text = "ADD", TextSize = 20, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(144, 56), Parent = u50})
    local function layoutWindow()
        --[[
          name: layoutWindow
          line: 1382
          upvalues:
            UI_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            layoutSlots (copy, index: 3)
            u14 (ref,  index: 4)
            u24 (copy, index: 5)
            u22 (copy, index: 6)
            u45 (copy, index: 7)
            u23 (copy, index: 8)
            u26 (copy, index: 9)
            u25 (copy, index: 10)
            u28 (copy, index: 11)
            u29 (copy, index: 12)
            u31 (copy, index: 13)
            u30 (copy, index: 14)
            u36 (copy, index: 15)
            u27 (ref,  index: 16)
            Fonts_upv_1 (copy, index: 17)
            TextService_upv_1 (copy, index: 18)
            u50 (copy, index: 19)
            u51 (copy, index: 20)
            u55 (copy, index: 21)
            u58 (copy, index: 22)
            u59 (copy, index: 23)
            u60 (copy, index: 24)
            tbl_upv_24 (copy, index: 25)
            u46 (copy, index: 26)
        ]]
        local v97 = UI_upv_1.CanvasSize()
        if UI_upv_1.Compact then
            u2.Holder.Size = UDim2.fromOffset(math.floor(math.clamp(v97.X - 24, 340, 1280)), math.floor(math.clamp((v97.Y - UI_upv_1.TopInset()) - 12, 300, 720)))
        else
            local v98 = UI_upv_1.TopInset()
            u2.Holder.Size = UDim2.fromOffset(math.floor(math.clamp(v97.X - 96, 1280, 1500)), math.floor(math.clamp((v97.Y - v98) - 22, 720, 980)))
        end
        layoutSlots()
        local Compact_1 = UI_upv_1.Compact
        u14.Visible = not Compact_1
        u24.Position = UDim2.fromOffset(0, (Compact_1 and 0) or 22)
        if Compact_1 then
            u22.Parent = u45
            u22.Position = UDim2.new(1, -4, 0, 11)
        else
            u22.Parent = u23
            u22.Position = UDim2.new(1, 0, 0, 0)
        end
        u26.TextSize = (Compact_1 and 28) or 34
        u26.Size = UDim2.fromOffset(u26.Size.X.Offset, (Compact_1 and 30) or 36)
        u25.Size = UDim2.new(1, -110, 0, (Compact_1 and 30) or 36)
        u28.TextSize = (Compact_1 and 14) or 15
        u29.Position = UDim2.new(1, 0, 0, (Compact_1 and 8) or 12)
        u31.Position = UDim2.fromOffset(0, (Compact_1 and 36) or 44)
        u30.Position = UDim2.fromOffset(0, (Compact_1 and 50) or 60)
        u30.TextSize = (Compact_1 and 13) or 14
        local v99 = (Compact_1 and 70) or 108
        u36.Position = UDim2.fromOffset(0, v99)
        u36.Size = UDim2.new(1, 0, 1, -v99)
        u27 = u27 + 1
        local u62 = u27
        local Text_upv_1 = u26.Text
        local TextSize_upv_1 = u26.TextSize
        task.spawn(
            function()
                --[[
                  line: 559
                  upvalues:
                    Text_upv_1 (copy, index: 1)
                    Fonts_upv_1 (copy, index: 2)
                    TextSize_upv_1 (copy, index: 3)
                    TextService_upv_1 (copy, index: 4)
                    u62 (copy, index: 5)
                    u27 (ref,  index: 6)
                    u26 (copy, index: 7)
                ]]
                local u63 = Instance.new("GetTextBoundsParams")
                u63.Text = Text_upv_1
                u63.Font = Fonts_upv_1.Display
                u63.Size = TextSize_upv_1
                u63.Width = 1000
                local success_1, v100 = pcall(
                    function()
                        --[[
                          line: 565
                          upvalues:
                            TextService_upv_1 (copy, index: 1)
                            u63 (copy, index: 2)
                        ]]
                        return TextService_upv_1:GetTextBoundsAsync(u63)
                    end
                )
                if not success_1 or u62 ~= u27 or not (v100.X > 4) then
                    return
                end
                u26.Size = UDim2.fromOffset(math.ceil(v100.X) + 2, u26.Size.Y.Offset)
            end
        )
        local v101 = ((UI_upv_1.Compact) and 104) or 156
        u50.Size = UDim2.new(1, 0, 0, v101)
        u51.Size = UDim2.fromOffset(v101 - 16, v101 - 16)
        u55.Position = UDim2.fromOffset(v101 + 4, (Compact_1 and 8) or 12)
        u55.Size = UDim2.new(1, -((((v101 + 4) + 262) + 168) + 12), 1, (Compact_1 and -16) or -24)
        u58.TextSize = (Compact_1 and 13) or 14
        local v102 = (Compact_1 and 18) or 20
        local v103 = (Compact_1 and 3) or 6
        u59.Padding = UDim.new(0, v103)
        u60.Size = UDim2.fromOffset(262, (#tbl_upv_24 * v102) + ((#tbl_upv_24 - 1) * v103))
        for _, value_7 in tbl_upv_24 do
            value_7.frame.Size = UDim2.new(1, 0, 0, v102)
            value_7.label.Size = UDim2.fromOffset(70, v102)
            value_7.value.Size = UDim2.fromOffset(92, v102)
            value_7.bar.Frame.Position = UDim2.fromOffset(72, math.floor((v102 - 7) / 2))
        end
        u46.Size = UDim2.new(1, 0, 1, -((v101 + 50) + 12))
    end
    local function layoutRows()
        --[[
          name: layoutRows
          line: 1442
          upvalues:
            u36 (copy, index: 1)
            WeaponInfo_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            u38 (ref,  index: 5)
            u37 (ref,  index: 6)
            tbl_upv_11 (copy, index: 7)
            u40 (ref,  index: 8)
            u41 (copy, index: 9)
            u42 (copy, index: 10)
            tbl_upv_14 (copy, index: 11)
            ammoRow (copy, index: 12)
        ]]
        local v104 = u36.AbsoluteSize.Y / math.max(u36.AbsoluteSize.X / 400, 0.01)
        local v105 = WeaponInfo_upv_1.AmmoNeeded(u3)
        local v106 = 0
        for _, value_8 in WeaponInfo_upv_1.AmmoTypes() do
            if v105[value_8.id] or (u3.ammo[value_8.id] or 0) > 0 then
                v106 = v106 + 1
            end
        end
        local v107 = v106 + 7
        local v108
        if not (v106 > 0) or UI_upv_1.Compact then
            v108 = 0
        else
            v108 = 22
        end
        u38 = ((v104 < 400) and 4) or 6
        u37 = math.clamp(math.floor(((v104 - v108) - ((v107 - 1) * u38)) / v107), 30, 66)
        local u64 = ((UI_upv_1.Touch) and (u37 + 10)) or 36
        local u65 = ((UI_upv_1.Touch) and (u37 - 2)) or (math.min(32, u37 - 8))
        local u66 = u37 - 8
        local function fitRow_1(a18, a19)
            --[[
              name: fitRow
              line: 1459
              upvalues:
                u37 (ref,  index: 1)
                u66 (copy, index: 2)
                u64 (copy, index: 3)
                u65 (copy, index: 4)
                UI_upv_1 (copy, index: 5)
            ]]
            a18.frame.Position = UDim2.fromOffset(0, a19)
            a18.frame.Size = UDim2.new(1, 0, 0, u37)
            a18.tile.Size = UDim2.fromOffset(u66, u66)
            a18.name.Position = UDim2.fromOffset(u66 + 16, 0)
            a18.remove.Size = UDim2.fromOffset(u64, u65)
            local remove_1 = a18.remove
            remove_1.Position = UDim2.new(1, ((UI_upv_1.Touch) and -1) or -6, 0.5, 0)
            local costPill_1 = a18.costPill
            costPill_1.Position = UDim2.new(1, -(u64 + (((UI_upv_1.Touch) and 8) or 12)), 0.5, 0)
            a18.name.Size = UDim2.new(1, -((((u66 + 16) + u64) + 12) + 60), 1, 0)
            a18.name.TextSize = ((u37 < 40) and 15) or 17
            if not a18.num then
                return
            end
            a18.num.Visible = u66 >= 34
        end
        local v110 = 0
        for _, value_9 in tbl_upv_11 do
            fitRow_1(value_9, v110)
            v110 = v110 + (u37 + u38)
        end
        fitRow_1(u40, v110)
        u41.Position = UDim2.fromOffset(0, v110 + (u37 + u38))
        u41.Visible = v106 > 0
        u42.Visible = (v106 > 0) and (not UI_upv_1.Compact)
        for _, value_10 in WeaponInfo_upv_1.AmmoTypes() do
            fitRow_1 = v105[value_10.id] or ((u3.ammo[value_10.id] or 0) > 0)
            if fitRow_1 or tbl_upv_14[value_10.id] then
                v108 = ammoRow(value_10.id)
                if not (v108) then
                    continue
                end
                v108.frame.Visible = fitRow_1
                if fitRow_1 then
                    v108.frame.Position = UDim2.fromOffset(0, v110)
                    v108.frame.Size = UDim2.new(1, 0, 0, u37)
                    v108.tile.Size = UDim2.fromOffset(u66, u66)
                    v106 = ((not (UI_upv_1.Touch)) and 38) or (math.max(38, u37 - 2))
                    v108.plus.Size = UDim2.fromOffset(v106, math.min(34, u37 - 6))
                    v108.plus.Position = UDim2.new(1, -5, 0.5, 0)
                    v108.count.Position = UDim2.new(1, -(v106 + 7), 0.5, 0)
                    v108.minus.Size = v108.plus.Size
                    v108.minus.Position = UDim2.new(1, -(v106 + 45), 0.5, 0)
                    v110 = v110 + (u37 + u38)
                    continue
                end
            end
            v108 = nil
            if not (v108) then
                continue
            end
            v108.frame.Visible = fitRow_1
            if fitRow_1 then
                v108.frame.Position = UDim2.fromOffset(0, v110)
                v108.frame.Size = UDim2.new(1, 0, 0, u37)
                v108.tile.Size = UDim2.fromOffset(u66, u66)
                v106 = ((not (UI_upv_1.Touch)) and 38) or (math.max(38, u37 - 2))
                v108.plus.Size = UDim2.fromOffset(v106, math.min(34, u37 - 6))
                v108.plus.Position = UDim2.new(1, -5, 0.5, 0)
                v108.count.Position = UDim2.new(1, -(v106 + 7), 0.5, 0)
                v108.minus.Size = v108.plus.Size
                v108.minus.Position = UDim2.new(1, -(v106 + 45), 0.5, 0)
                v110 = v110 + (u37 + u38)
            end
        end
        u41.Size = UDim2.new(1, 0, 0, v110)
    end
    local function layoutGrid(a20)
        --[[
          name: layoutGrid
          line: 1507
          upvalues:
            u2 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            u6 (ref,  index: 4)
            tbl_upv_18 (copy, index: 5)
            Economy_upv_1 (copy, index: 6)
            u47 (copy, index: 7)
            u46 (copy, index: 8)
        ]]
        local v111 = (u2.Holder.Size.X.Offset - 44) - 400 - 18
        local u67 = ((UI_upv_1.Compact) and 128) or 164
        local u68 = math.clamp(math.floor(((v111 - 8) + 12) / 170), 2, 5)
        local u69 = math.floor(((v111 - 8) - ((u68 - 1) * 12)) / u68)
        local v112 = nil
        v111 = v112
        for _, value_11 in WeaponInfo_upv_1.FILTERS do
            if value_11.id == u6 then
                v111 = value_11
            end
        end
        local tbl_25 = {}
        local tbl_26 = {}
        local v113, v114 = nil, nil
        for _, value_12 in tbl_upv_18 do
            local v115 = WeaponInfo_upv_1.Get(value_12.id)
            local v116 = false
            if v115 == nil then
                v113 = v116
            else
                v113 = true
                if v111 ~= nil then
                    v113 = true
                    if v111.cats ~= nil then
                        v113 = v111.cats[v115.category] == true
                    end
                end
            end
            value_12.holder.Visible = v113
            value_12.visible = v113
            if not (v113) then
                continue
            end
            if Economy_upv_1.IsLocked(value_12.id) then
                v114 = tbl_26
            else
                v114 = tbl_25
            end
            table.insert(v114, value_12)
        end
        local u70 = 0
        local function place_1(a21)
            --[[
              name: place
              line: 1529
              upvalues:
                u68 (copy, index: 1)
                u70 (ref,  index: 2)
                u67 (copy, index: 3)
                u69 (copy, index: 4)
            ]]
            for key_3, value_13 in a21 do
                value_13.y = u70 + (((key_3 - 1) // u68) * (u67 + 12))
                value_13.holder.Position = UDim2.fromOffset((((key_3 - 1) % u68) * (u69 + 12)) + 4, value_13.y + 4)
                value_13.holder.Size = UDim2.fromOffset(u69, u67)
                value_13.glow.Size = UDim2.fromOffset(u69 * 1.05, u67 * 0.95)
                value_13.glow.Position = UDim2.new(0.5, 0, 0, ((u67 - 60) / 2) + 6)
            end
            u70 = u70 + math.ceil(#a21 / u68) * (u67 + 12)
        end
        place_1(tbl_25)
        u47.Visible = #tbl_26 > 0
        if #tbl_26 > 0 then
            u47.Position = UDim2.fromOffset(4, u70 + (((#tbl_25 > 0) and 6) or 0))
            u70 = u70 + ((((#tbl_25 > 0) and 14) or 8) + 44)
            place_1(tbl_26)
        end
        u46.CanvasSize = UDim2.fromOffset(0, u70 + 8)
        if (a20) then
            return
        end
        u46.CanvasPosition = Vector2.zero
    end
    local tbl_upv_27 = {}
    RunService_upv_1.Heartbeat:Connect(
        function()
            --[[
              line: 1590
              upvalues:
                tbl_upv_27 (copy, index: 1)
                u2 (copy, index: 2)
                UI_upv_1 (copy, index: 3)
                WeaponIcon_upv_1 (copy, index: 4)
                WeaponInfo_upv_1 (copy, index: 5)
                tbl_upv_3 (copy, index: 6)
                Colors_upv_1 (copy, index: 7)
                tbl_upv_2 (copy, index: 8)
            ]]
            if #tbl_upv_27 == 0 or not u2.IsOpen then
                return
            end
            for _ = 1, ((UI_upv_1.Touch) and 2) or 4 do
                local v117 = table.remove(tbl_upv_27, 1)
                if v117 then
                    local Set_1 = WeaponIcon_upv_1.Set
                    local icon_1 = v117.icon
                    local id_1 = v117.id
                    local tbl_28 = {outline = false, glow = false, outlineTransparency = 0.5, outlineColor = 0, outlineScale = 1.035}
                    local v118 = WeaponInfo_upv_1.Get(v117.id)
                    tbl_28.outlineColor = ((v118 and (tbl_upv_3[v118.category])) or (Colors_upv_1.Accent)):Lerp(Color3.new(1, 1, 1), 0.55)
                    Set_1(icon_1, id_1, tbl_28)
                    tbl_upv_2._paintCard(v117)
                    continue
                else
                    break
                end
            end
        end
    )
    local function queueVisible()
        --[[
          name: queueVisible
          line: 1570
          upvalues:
            u46 (copy, index: 1)
            u2 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            tbl_upv_18 (copy, index: 4)
            tbl_upv_27 (copy, index: 5)
            WeaponIcon_upv_1 (copy, index: 6)
        ]]
        local v119 = math.max(u46.AbsoluteSize.X / math.max(((u2.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01)
        local v120 = ((UI_upv_1.Compact) and 128) or 164
        local v121 = u46.CanvasPosition.Y / v119
        local v122 = v121 + u46.AbsoluteWindowSize.Y / v119
        for _, value_14 in tbl_upv_18 do
            if value_14.visible and not value_14.rendered and v121 - v120 <= value_14.y + v120 and value_14.y <= v122 + v120 then
                value_14.rendered = true
                table.insert(tbl_upv_27, value_14)
                continue
            end
            if not (value_14.rendered) then
                continue
            end
            if not (value_14.visible) or value_14.y + v120 < v121 - (v120 * 2) or v122 + (v120 * 2) < value_14.y then
                value_14.rendered = false
                local v123 = table.find(tbl_upv_27, value_14)
                if v123 then
                    table.remove(tbl_upv_27, v123)
                end
                WeaponIcon_upv_1.Set(value_14.icon, nil)
            end
        end
    end
    u46:GetPropertyChangedSignal("CanvasPosition"):Connect(queueVisible)
    local u71 = -1
    local u72 = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    function tbl_upv_2._paintPoints()
        --[[
          name: _paintPoints
          line: 1608
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            buildTicks (copy, index: 3)
            u26 (copy, index: 4)
            u71 (ref,  index: 5)
            UI_upv_1 (copy, index: 6)
            tbl_upv_10 (copy, index: 7)
            u72 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            u33 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
            u29 (copy, index: 12)
            u30 (copy, index: 13)
            u5 (ref,  index: 14)
            canAdd (copy, index: 15)
            ammoExtra (copy, index: 16)
            u32 (copy, index: 17)
        ]]
        local v124 = WeaponInfo_upv_1.Cost(u3)
        local v125 = math.max(WeaponInfo_upv_1.Budget(), 1)
        buildTicks(v125)
        u26.Text = string.format("%d / %d", v124, v125)
        if v124 ~= u71 then
            if u71 >= 0 then
                UI_upv_1.Bump(u26, 0.08)
            end
            u71 = v124
        end
        local v126 = v125 <= v124
        UI_upv_1.Tween(tbl_upv_10, u72, {Size = UDim2.fromScale(math.clamp(v124 / v125, 0, 1), 1)})
        local v127
        if v126 then
            v127 = Colors_upv_1.Success
        else
            v127 = Colors_upv_1.Accent
        end
        u33.Color = ColorSequence.new(Theme_upv_1.Lighten(v127, 0.18), v127)
        u29.Text = ""
        local v128
        if v126 then
            v128 = string.format("All %d points used", v125)
        elseif v124 ~= 0 then
            v128 = string.format("%d of %d points used  \194\183  %d left", v124, v125, v125 - v124)
        else
            v128 = string.format("0 of %d points used  \194\183  pick items on the right", v125)
        end
        u30.Text = v128
        local v129
        if v126 then
            v129 = Colors_upv_1.Success
        else
            v129 = Colors_upv_1.TextDim
        end
        u30.TextColor3 = v129
        local v130 = false
        local v131 = u5
        local v144 = nil
        if v131 then
            local v132 = true
            if table.find(u3.items, v131) == nil then
                v132 = u3.armor == v131
            end
            if v132 then
                v126 = v130
            else
                local v133, v135
                v133, v144, v135 = canAdd(v131)
                if v133 then
                    local v136 = v124 + WeaponInfo_upv_1.Points(v131) + ammoExtra(v131)
                    local v137
                    if (WeaponInfo_upv_1.IsArmor(v131)) and (u3.armor) then
                        v137 = WeaponInfo_upv_1.Points(u3.armor)
                    else
                        v137 = 0
                    end
                    v127, v126 = v136 - v137, v130
                elseif v144 == "points" or v144 == "ammo" then
                    local v138 = true
                    local _, v139 = ammoExtra(v131)
                    local v140
                    if v144 == "ammo" and (v139) then
                        local v141 = WeaponInfo_upv_1.Name(v131)
                        local v142 = string.lower(v139.name)
                        v140 = string.format("%s needs %s too: %d more point%s, remove something first", v141, v142, v135, ((v135 ~= 1) and "s") or "")
                    else
                        local v143 = WeaponInfo_upv_1.Name(v131)
                        v140 = string.format("%s needs %d more point%s: remove something first", v143, v135, ((v135 ~= 1) and "s") or "")
                    end
                    u30.Text = v140
                    u30.TextColor3 = Colors_upv_1.Danger
                    v127, v126 = v125, v138
                else
                    v126 = v130
                end
            end
        else
            v126 = v130
        end
        UI_upv_1.Tween(u32, Theme_upv_1.Tween.Fast, {Size = UDim2.fromScale(math.clamp(v127 / v125, 0, 1), 1)})
        if v126 then
            v144 = Colors_upv_1.Danger
        else
            v144 = Colors_upv_1.Accent
        end
        u32.BackgroundColor3 = v144
        u32.BackgroundTransparency = (v126 and 0.35) or 0.6
    end
    local function paintRow(a22, a23)
        --[[
          name: paintRow
          line: 1651
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            WeaponIcon_upv_1 (copy, index: 4)
            u40 (ref,  index: 5)
            tbl_upv_11 (copy, index: 6)
            u3 (ref,  index: 7)
        ]]
        a22.id = a23
        local v145 = WeaponInfo_upv_1.Get(a23)
        a22.remove.Visible = v145 ~= nil
        a22.costPill.Visible = v145 ~= nil
        a22.frame.BackgroundTransparency = (v145 and 0.3) or 0.72
        local v146
        if v145 then
            v146 = tbl_upv_3[v145.category] or (Colors_upv_1.Accent)
        else
            v146 = Colors_upv_1.Raised
        end
        local tileGrad_2 = a22.tileGrad
        local v147
        if v145 then
            v147 = ColorSequence.new(v146:Lerp(Colors_upv_1.Panel, 0.62), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
        else
            v147 = ColorSequence.new(Colors_upv_1.Panel, Colors_upv_1.Panel)
        end
        tileGrad_2.Color = v147
        a22.tile.BackgroundTransparency = (v145 and 0) or 0.6
        a22.tileStroke.Transparency = (v145 and 0.88) or 0.75
        if a22.plus then
            a22.plus.Visible = v145 == nil
        end
        if a22.shield then
            a22.shield.Visible = v145 == nil
        end
        if v145 then
            a22.name.Text = v145.name
            a22.name.TextColor3 = Colors_upv_1.Text
            a22.costLabel.Text = v145.points .. (((v145.points ~= 1) and " PTS") or " PT")
            local Set_2 = WeaponIcon_upv_1.Set
            local icon_2 = a22.icon
            local tbl_29 = {outline = false, glow = false, outlineTransparency = 0.5, outlineColor = 0, outlineScale = 1.035}
            local v148 = WeaponInfo_upv_1.Get(a23)
            tbl_29.outlineColor = ((v148 and (tbl_upv_3[v148.category])) or (Colors_upv_1.Accent)):Lerp(Color3.new(1, 1, 1), 0.55)
            Set_2(icon_2, a23, tbl_29)
        else
            local v149 = (a22 ~= u40) and (tbl_upv_11[#u3.items + 1] == a22)
            local v150 = ((a22 == u40) and "Armor (optional)") or ((v149 and "Pick an item on the right") or "Empty")
            a22.name.Text = v150
            local name_2 = a22.name
            if v149 then
                v150 = Colors_upv_1.TextDim
            else
                v150 = Colors_upv_1.TextMuted
            end
            name_2.TextColor3 = v150
            WeaponIcon_upv_1.Set(a22.icon, nil)
        end
        if a22.num then
            local num_1 = a22.num
            local v151
            if v145 then
                v151 = Colors_upv_1.TextDim
            else
                v151 = Colors_upv_1.TextMuted
            end
            num_1.TextColor3 = v151
            a22.num.TextTransparency = (v145 and 0.1) or 0.3
        end
    end
    local function paintAmmo()
        --[[
          name: paintAmmo
          line: 1688
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            tbl_upv_14 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            tbl_upv_3 (copy, index: 5)
            ammoFloor (copy, index: 6)
        ]]
        local v152 = WeaponInfo_upv_1.AmmoNeeded(u3)
        local v153 = nil
        local v154 = nil
        for _, value_15 in WeaponInfo_upv_1.AmmoTypes() do
            local v155 = tbl_upv_14[value_15.id]
            if not (v155) or not (v155.frame.Visible) then
                continue
            end
            local v156 = u3.ammo[value_15.id] or 0
            v155.count.Text = tostring(v156)
            v155.amount.Text = "\195\151" .. v156 * value_15.perBundle
            if v156 == 0 and v152[value_15.id] then
                if value_15.optional then
                    v155.sub.Text = string.format("%d %s per bundle", value_15.perBundle, string.lower(value_15.name))
                    v155.sub.TextColor3 = Colors_upv_1.TextMuted
                    local amount_1 = v155.amount
                    if value_15.id == "arrows" or value_15.as == "arrows" then
                        amount_1.TextColor3 = tbl_upv_3.bow
                        amount_1 = (v156 < WeaponInfo_upv_1.MaxAmmoBundles()) and (WeaponInfo_upv_1.Cost(u3) + value_15.points <= WeaponInfo_upv_1.Budget())
                        local v154 = v155.plus
                        if amount_1 then
                            v153 = 0.1
                        else
                            v153 = 0.6
                        end
                        v154.BackgroundTransparency = v153
                        v154 = v155.minus
                        if not (v156 > 0) then
                            v153 = 0.6
                            v154.BackgroundTransparency = v153
                            continue
                        end
                        if ammoFloor(value_15.id) then
                            v153 = 0.6
                        else
                            v153 = 0.1
                        end
                        v154.BackgroundTransparency = v153
                    end
                    v154 = tbl_upv_3.gun
                    amount_1.TextColor3 = v154
                else
                    v155.sub.Text = "No " .. string.lower(value_15.name) .. ": you can't shoot!"
                    v155.sub.TextColor3 = Colors_upv_1.Danger
                    v155.amount.TextColor3 = Colors_upv_1.Danger
                end
            else
                v155.sub.Text = string.format("%d %s per bundle", value_15.perBundle, string.lower(value_15.name))
                v155.sub.TextColor3 = Colors_upv_1.TextMuted
                local amount_1 = v155.amount
                if value_15.id == "arrows" or value_15.as == "arrows" then
                    amount_1.TextColor3 = tbl_upv_3.bow
                    amount_1 = (v156 < WeaponInfo_upv_1.MaxAmmoBundles()) and (WeaponInfo_upv_1.Cost(u3) + value_15.points <= WeaponInfo_upv_1.Budget())
                    local v154 = v155.plus
                    if amount_1 then
                        v153 = 0.1
                    else
                        v153 = 0.6
                    end
                    v154.BackgroundTransparency = v153
                    v154 = v155.minus
                    if not (v156 > 0) then
                        v153 = 0.6
                        v154.BackgroundTransparency = v153
                        continue
                    end
                    if ammoFloor(value_15.id) then
                        v153 = 0.6
                    else
                        v153 = 0.1
                    end
                    v154.BackgroundTransparency = v153
                end
                v154 = tbl_upv_3.gun
                amount_1.TextColor3 = v154
            end
            local amount_1 = (v156 < WeaponInfo_upv_1.MaxAmmoBundles()) and (WeaponInfo_upv_1.Cost(u3) + value_15.points <= WeaponInfo_upv_1.Budget())
            v154 = v155.plus
            if amount_1 then
                v153 = 0.1
            else
                v153 = 0.6
            end
            v154.BackgroundTransparency = v153
            v154 = v155.minus
            if not (v156 > 0) or ammoFloor(value_15.id) then
                v153 = 0.6
            else
                v153 = 0.1
            end
            v154.BackgroundTransparency = v153
        end
    end
    function tbl_upv_2._paintCard(a24)
        --[[
          name: _paintCard
          line: 1712
          upvalues:
            canAdd (copy, index: 1)
            u3 (ref,  index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            tbl_upv_3 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            Economy_upv_1 (copy, index: 6)
            a1 (copy, index: 7)
            WeaponIcon_upv_1 (copy, index: 8)
            ammoExtra (copy, index: 9)
        ]]
        local v157, v158, v159 = canAdd(a24.id)
        local id_2 = a24.id
        local v160 = true
        if table.find(u3.items, id_2) == nil then
            v160 = u3.armor == id_2
        end
        local v161 = WeaponInfo_upv_1.Get(a24.id)
        local v162 = (v161 and (tbl_upv_3[v161.category])) or (Colors_upv_1.Accent)
        local v163 = v158 == "locked"
        local v164 = not v160
        local _ = v164 and (not v157)
        local v165, v166 = Economy_upv_1.Progress(a24.id)
        local v167 = Economy_upv_1.Level(a24.id)
        a24.check.Visible = false
        a24.lock.Visible = v163
        a24.costBadge.Visible = not v163
        a24.lv.Visible = not v163 and (v167 >= 1)
        local v168 = not v163 and (Economy_upv_1.CanUpgrade(a24.id))
        a24.readyDot.Visible = v168
        if Economy_upv_1.MAX_LEVEL <= v167 then
            a24.lvText.Text = "MAX"
            a24.lvText.TextColor3 = Colors_upv_1.TextDark
            a24.lv.BackgroundColor3 = Colors_upv_1.Gold
            a24.lv.BackgroundTransparency = 0
        else
            a1.Loc.Rich(a24.lvText, string.format("<font size=\"11\">LV</font> %d", v167))
            a24.lvText.TextColor3 = Colors_upv_1.Text
            local lv_1 = a24.lv
            local v169
            if v168 then
                v169 = Colors_upv_1.SuccessDark
            else
                v169 = Colors_upv_1.Void
            end
            lv_1.BackgroundColor3 = v169
            a24.lv.BackgroundTransparency = (v168 and 0) or 0.3
        end
        a24.cbar.Visible = v163
        a24.cfill.Visible = v165 > 0
        a24.cfill.Size = UDim2.fromScale(math.clamp(v165 / math.max(v166, 1), 0, 1), 1)
        a24.cfill.BackgroundColor3 = Colors_upv_1.Accent
        local v170 = a24.stroke
        local v171
        if v160 then
            v171 = Colors_upv_1.Accent
        elseif a24.hover then
            if v163 then
                v171 = Colors_upv_1.Stroke
            else
                v171 = v162
            end
        else
            v171 = Colors_upv_1.Stroke
        end
        v170.Color = v171
        a24.stroke.Thickness = (v160 and 2) or 1
        a24.stroke.Transparency = (v160 and 0) or (((not (a24.hover)) and 0.9) or ((v163 and 0.7) or 0.4))
        local grad_1 = a24.grad
        if v163 then
            v171 = ColorSequence.new(Colors_upv_1.Panel, Colors_upv_1.Panel)
        else
            v171 = ColorSequence.new(v162:Lerp(Colors_upv_1.Panel, ((a24.hover) and 0.8) or 0.9), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
        end
        grad_1.Color = v171
        a24.inner.BackgroundTransparency = (v163 and 0.35) or 0.08
        local glow_1 = a24.glow
        if v163 or v164 then
            v171 = 1
        elseif a24.hover or v160 then
            v171 = 0.7
        else
            v171 = 0.85
        end
        glow_1.ImageTransparency = v171
        a24.costBadge.BackgroundColor3 = Colors_upv_1.Void
        a24.costBadge.BackgroundTransparency = 0.3
        if a24.rendered then
            WeaponIcon_upv_1.SetDim(a24.icon, v164)
        end
        local nameL_1 = a24.nameL
        if v163 then
            v171 = Colors_upv_1.TextMuted
        elseif v164 then
            v171 = Colors_upv_1.TextDim
        else
            v171 = Colors_upv_1.Text
        end
        nameL_1.TextColor3 = v171
        if v160 then
            a24.status.Text = "\226\156\147 IN LOADOUT"
            a24.status.TextColor3 = Colors_upv_1.Accent
        elseif v163 then
            a24.status.Text = string.format("%d / %d SHARDS", v165, v166)
            local status_1 = a24.status
            if v165 > 0 then
                v171 = Colors_upv_1.TextDim
            else
                v171 = Colors_upv_1.TextMuted
            end
            status_1.TextColor3 = v171
        elseif v158 == "points" then
            local status_2 = a24.status
            status_2.Text = string.format("NEEDS %d MORE PT%s", v159, ((v159 ~= 1) and "S") or "")
            local status_3 = a24.status
            if a24.hover then
                v171 = Colors_upv_1.Danger
            else
                v171 = Colors_upv_1.TextMuted
            end
            status_3.TextColor3 = v171
        elseif v158 == "ammo" then
            v170, v171 = ammoExtra(a24.id)
            local status_4 = a24.status
            status_4.Text = string.format("NEEDS %d PT%s FOR %s", v159, ((v159 ~= 1) and "S") or "", string.upper((v171 and (v171.name)) or "AMMO"))
            local status_5 = a24.status
            local v172
            if a24.hover then
                v172 = Colors_upv_1.Danger
            else
                v172 = Colors_upv_1.TextMuted
            end
            status_5.TextColor3 = v172
        elseif v158 ~= "full" then
            a24.status.Text = ""
        else
            a24.status.Text = "6 ITEMS MAX"
            a24.status.TextColor3 = Colors_upv_1.TextMuted
        end
    end
    local u73 = nil
    local function statValue(a25, a26)
        --[[
          name: statValue
          line: 1780
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        if a26.value then
            return a26.value
        end
        local label_1 = a26.label
        if type(a25.details) == "table" then
            for _, value_16 in a25.details do
                if type(value_16) ~= "table" or type(value_16[1]) ~= "string" or string.upper(value_16[1]) ~= label_1 then
                    continue
                end
                return (tostring(value_16[2]))
            end
        end
        if a25.category == "armor" and label_1 == "ARMOR" then
            return "+" .. WeaponInfo_upv_1.ArmorStats(a25)
        end
        return string.format("%d / 10", math.floor((a26.frac * 10) + 0.5))
    end
    local function iconOpts(a27, a28)
        --[[
          name: iconOpts
          line: 120
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local tbl_30 = {outline = false, glow = false, outlineTransparency = 0.5, outlineColor = 0, outlineScale = 1.035}
        local v173 = WeaponInfo_upv_1.Get(a27)
        tbl_30.outlineColor = ((v173 and (tbl_upv_3[v173.category])) or (Colors_upv_1.Accent)):Lerp(Color3.new(1, 1, 1), 0.55)
        if a28 then
            for key_4, value_17 in a28 do
                tbl_30[key_4] = value_17
            end
        end
        return tbl_30
    end
    function tbl_upv_2._paintDetail()
        --[[
          name: _paintDetail
          line: 1799
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u4 (ref,  index: 2)
            u50 (copy, index: 3)
            tbl_upv_3 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u73 (ref,  index: 6)
            WeaponIcon_upv_1 (copy, index: 7)
            u54 (copy, index: 8)
            iconOpts (copy, index: 9)
            u52 (copy, index: 10)
            u53 (copy, index: 11)
            UI_upv_1 (copy, index: 12)
            Theme_upv_1 (copy, index: 13)
            u56 (copy, index: 14)
            Economy_upv_1 (copy, index: 15)
            a1 (copy, index: 16)
            u57 (copy, index: 17)
            u58 (copy, index: 18)
            tbl_upv_24 (copy, index: 19)
            statValue (copy, index: 20)
            canAdd (copy, index: 21)
            u60 (copy, index: 22)
            u61 (copy, index: 23)
            u3 (ref,  index: 24)
        ]]
        local v174 = WeaponInfo_upv_1.Get(u4)
        u50.Visible = v174 ~= nil
        if not v174 then
            return
        end
        local v175 = tbl_upv_3[v174.category] or (Colors_upv_1.Accent)
        if u73 ~= v174.id then
            u73 = v174.id
            WeaponIcon_upv_1.Set(u54, v174.id, (iconOpts(v174.id, {outline = true, spin = true})))
            u52.Color = ColorSequence.new(v175:Lerp(Colors_upv_1.Panel, 0.62), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
            u53.ImageColor3 = v175
            UI_upv_1.Pop(u54, 0.9, Theme_upv_1.Tween.PopSmall)
        end
        u56.Text = v174.name
        local v176 = WeaponInfo_upv_1.AmmoOf(v174.id)
        local _ = v176 and (WeaponInfo_upv_1.AmmoDef(v176))
        local v177 = Economy_upv_1.Level(v174.id)
        local Loc_1 = a1.Loc
        local tbl_31 = {}
        if v177 >= 1 then
            local v178 = Loc_1.T("LV " .. v177)
            local v179 = ((v177 > 1) and (" " .. Loc_1.T(string.upper(Economy_upv_1.BonusText(v174.id, v177))))) or ""
            table.insert(tbl_31, v178 .. v179)
        end
        table.insert(tbl_31, Loc_1.T(WeaponInfo_upv_1.CATEGORY_SINGULAR[v174.category] or ""))
        table.insert(tbl_31, Loc_1.T(string.format("%d POINT%s", v174.points, ((v174.points ~= 1) and "S") or "")))
        if v176 then
            table.insert(tbl_31, Loc_1.T("USES " .. string.upper(v176.name)))
        end
        u57.Text = table.concat(tbl_31, "  \194\183  ")
        u57.TextColor3 = v175:Lerp(Colors_upv_1.TextDim, 0.35)
        local description_1 = v174.description
        local v180 = nil
        if v174.category ~= "armor" then
            v180 = WeaponInfo_upv_1.SpeedNote(v174)
            if v180 ~= "" then
                description_1 = v180 .. " " .. description_1
            end
        else
            local v181, v182 = WeaponInfo_upv_1.ArmorStats(v174)
            description_1 = string.format("+%d armor, %d%% slower. %s", v181, math.floor(((1 - v182) * 100) + 0.5), description_1)
        end
        u58.Text = description_1
        description_1 = WeaponInfo_upv_1.Bars(v174)
        for key_5, value_18 in tbl_upv_24 do
            local v183 = description_1[key_5]
            value_18.frame.Visible = v183 ~= nil
            if v183 then
                value_18.label.Text = v183.label
                value_18.bar.Set(v183.frac)
                value_18.bar.SetColor(v175)
                value_18.value.Text = statValue(v174, v183)
            end
        end
        local v184, v185, v186 = canAdd(v174.id)
        local v187 = v185 == "locked"
        u60.Visible = true
        local v188 = nil
        if v187 then
            local v189, v190 = Economy_upv_1.Progress(v174.id)
            if Economy_upv_1.RankAllows(v174.id) then
                u57.Text = a1.Loc.T(string.format("LOCKED  \194\183  %d / %d SHARDS  \194\183  FIND SHARDS IN DROPS", v189, v190))
            else
                u57.Text = a1.Loc.T(string.format("LOCKED  \194\183  JOINS YOUR DROPS AT %s", string.upper(require(game:GetService("ReplicatedStorage").Shared.Ranks).Get(Economy_upv_1.ItemRank(v174.id)).name)))
            end
            u57.TextColor3 = Colors_upv_1.TextMuted
            u61.Instance.AnchorPoint = Vector2.new(1, 0.5)
            u61.Instance.Position = UDim2.new(1, -12, 0.5, 0)
            u61.Instance.Size = UDim2.fromOffset(144, 56)
            u61.Label.TextSize = 17
            u61:SetStyle("Dark")
            u61:SetEnabled(true)
            u61:SetText("COLLECTION")
        else
            u61.Instance.AnchorPoint = Vector2.new(1, 0.5)
            u61.Instance.Position = UDim2.new(1, -12, 0.5, 0)
            u61.Instance.Size = UDim2.fromOffset(144, 56)
            u61.Label.TextSize = 20
            v188 = v174.id
            local v191 = true
            if table.find(u3.items, v188) == nil then
                v191 = u3.armor == v188
            end
            if v191 then
                u61:SetStyle("Dark")
                u61:SetEnabled(true)
                u61:SetText("REMOVE")
            elseif v184 then
                u61:SetStyle("Primary")
                u61:SetEnabled(true)
                local v192
                if (WeaponInfo_upv_1.IsArmor(v174.id)) and (u3.armor) then
                    v192 = "SWAP"
                else
                    v192 = "ADD"
                end
                u61:SetText(v192)
            else
                u61:SetStyle("Dark")
                u61:SetEnabled(false)
                local v192
                if v185 == "points" or v185 == "ammo" then
                    v192 = "NEED " .. v186 .. (((v186 ~= 1) and " PTS") or " PT")
                else
                    v192 = "6 ITEMS MAX"
                end
                u61:SetText(v192)
            end
        end
    end
    local function budget()
        --[[
          name: budget
          line: 162
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        return WeaponInfo_upv_1.Budget()
    end
    local function paintAll()
        --[[
          name: paintAll
          line: 1898
          upvalues:
            tbl_upv_11 (copy, index: 1)
            paintRow (copy, index: 2)
            u3 (ref,  index: 3)
            u40 (ref,  index: 4)
            layoutRows (copy, index: 5)
            paintAmmo (copy, index: 6)
            tbl_upv_2 (copy, index: 7)
            tbl_upv_18 (copy, index: 8)
            u12 (ref,  index: 9)
            u2 (copy, index: 10)
            WeaponInfo_upv_1 (copy, index: 11)
            budget (copy, index: 12)
        ]]
        for key_6, value_19 in tbl_upv_11 do
            paintRow(value_19, u3.items[key_6])
        end
        paintRow(u40, (u3.armor) or nil)
        layoutRows()
        paintAmmo()
        tbl_upv_2._paintPoints()
        for _, value_20 in tbl_upv_18 do
            tbl_upv_2._paintCard(value_20)
        end
        tbl_upv_2._paintDetail()
        u12()
        u2.Subtitle.Text = string.format("Pick up to %d items worth %d points.", WeaponInfo_upv_1.MaxItems(), budget())
    end
    local function save(a29, a30)
        --[[
          name: save
          line: 1916
          upvalues:
            u8 (ref,  index: 1)
            u7 (ref,  index: 2)
            u3 (ref,  index: 3)
            u10 (ref,  index: 4)
            u22 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            WeaponInfo_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
            State_upv_1 (copy, index: 9)
            u12 (ref,  index: 10)
        ]]
        u8 = u8 + 1
        if not (a29) then
            if not u7 then
                return
            end
            a29 = u3
            a30 = u10
        end
        u7 = false
        if #a29.items ~= 0 then
            u22.Text = "Saving\226\128\166"
            u22.TextColor3 = Colors_upv_1.TextMuted
            local _, v195, v193 = WeaponInfo_upv_1.Validate(a29)
            if a1.ProfileAction("SetLoadout", v193, a30) then
                u22.Text = "\226\156\147 Saved"
                u22.TextColor3 = Colors_upv_1.Success
                local tbl_32 = {ammo = 0}
                tbl_32.items = table.clone(v193.items)
                tbl_32.armor = v193.armor
                tbl_32.ammo = table.clone(v193.ammo or {})
                local loadouts_1 = State_upv_1.Profile.loadouts
                if type(loadouts_1) == "table" and a30 and loadouts_1[a30] ~= nil then
                    loadouts_1[a30] = tbl_32
                end
                local v194 = State_upv_1.HasLoadoutSlots()
                if not (v194) or a30 == State_upv_1.ActiveLoadout() then
                    State_upv_1.Profile.loadout = tbl_32
                end
                u12()
            else
                u22.Text = "Not saved"
                u22.TextColor3 = Colors_upv_1.Danger
            end
        else
            u22.Text = "Add an item to save"
            u22.TextColor3 = Colors_upv_1.TextMuted
        end
    end
    local function markDirty()
        --[[
          name: markDirty
          line: 1955
          upvalues:
            u7 (ref,  index: 1)
            u10 (ref,  index: 2)
            u9 (ref,  index: 3)
            u8 (ref,  index: 4)
            u22 (copy, index: 5)
        ]]
        u7 = true
        u10 = u9
        u8 = u8 + 1
        local _ = u8
        u22.Text = ""
        task.delay(1.2, function() end)
    end
    local function topUpAmmo()
        --[[
          name: topUpAmmo
          line: 1970
          upvalues:
            missingAmmo (copy, index: 1)
            u3 (ref,  index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            ammoUser (copy, index: 4)
            u7 (ref,  index: 5)
            u10 (ref,  index: 6)
            u9 (ref,  index: 7)
            u8 (ref,  index: 8)
            u22 (copy, index: 9)
            a1 (copy, index: 11)
        ]]
        local tbl_33 = {}
        local tbl_34 = {}
        for _, value_21 in missingAmmo(u3) do
            local v195 = WeaponInfo_upv_1.AmmoDef(value_21)
            if (v195) and (WeaponInfo_upv_1.Cost(u3) + v195.points <= WeaponInfo_upv_1.Budget()) then
                u3.ammo[value_21] = 1
                table.insert(tbl_33, value_21)
            elseif v195 then
                table.insert(tbl_34, value_21)
            end
        end
        local function line_1(a31)
            --[[
              name: line
              line: 1981
              upvalues:
                ammoUser (copy, index: 1)
                WeaponInfo_upv_1 (copy, index: 2)
            ]]
            local v196 = ammoUser(a31)
            local v197 = string.lower(WeaponInfo_upv_1.AmmoDef(a31).name)
            local v198 = ((not v196) and "weapon") or (WeaponInfo_upv_1.Name(v196))
            return string.format("%s for your %s", v197, v198)
        end
        if #tbl_33 > 0 then
            u7 = true
            u10 = u9
            u8 = u8 + 1
            local _ = u8
            u22.Text = ""
            task.delay(1.2, function() end)
            a1.Toast("Added " .. line_1(tbl_33[1]) .. ": it had none", "info")
        elseif #tbl_34 > 0 then
            a1.Toast("No " .. line_1(tbl_34[1]) .. ": you can't shoot it! Make room for some", "warning")
        end
    end
    local function copyDraft(a32)
        --[[
          name: copyDraft
          line: 171
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v199 = WeaponInfo_upv_1.Normalize(a32)
        local tbl_35 = {}
        tbl_35.items = table.clone(v199.items)
        tbl_35.armor = v199.armor
        tbl_35.ammo = table.clone(v199.ammo)
        return tbl_35
    end
    local function flushSave()
        --[[
          name: flushSave
          line: 1994
          upvalues:
            u7 (ref,  index: 1)
            copyDraft (copy, index: 2)
            u3 (ref,  index: 3)
            u10 (ref,  index: 4)
            u8 (ref,  index: 5)
            save (copy, index: 6)
        ]]
        if not u7 then
            return
        end
        local v200 = copyDraft(u3)
        u7 = false
        u8 = u8 + 1
        task.spawn(save, v200, u10)
    end
    local u74 = false
    a1.MenuManager.Changed:Connect(
        function(a33)
            --[[
              line: 2012
              upvalues:
                u74 (ref,  index: 1)
                a1 (copy, index: 2)
                State_upv_1 (copy, index: 3)
            ]]
            if a33 == nil and u74 then
                u74 = false
                task.defer(
                    function()
                        --[[
                          line: 2015
                          upvalues:
                            a1 (copy, index: 1)
                            State_upv_1 (copy, index: 2)
                        ]]
                        if (a1.MenuManager.IsOpen()) or (State_upv_1.InMatch()) then
                            return
                        end
                        a1.MenuManager.Open("Loadout")
                    end
                )
                return
            end
            if a33 == nil then
                return
            end
            if a33 ~= "Collection" then
                u74 = false
            end
        end
    )
    tbl_upv_2._openCollection = function(a34)
        --[[
          name: openCollection
          line: 2008
          upvalues:
            u74 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        u74 = true
        local Open_1 = a1.MenuManager.Open
        local v201
        if a34 then
            v201 = {}
            v201.focus = a34
        else
            v201 = nil
        end
        Open_1("Collection", v201)
    end
    u13 = function(a35)
        --[[
          line: 2027
          upvalues:
            u9 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            u7 (ref,  index: 3)
            copyDraft (copy, index: 4)
            u3 (ref,  index: 5)
            u10 (ref,  index: 6)
            u8 (ref,  index: 7)
            save (copy, index: 8)
            u11 (ref,  index: 9)
            WeaponInfo_upv_1 (copy, index: 10)
            topUpAmmo (copy, index: 11)
            u4 (ref,  index: 12)
            u5 (ref,  index: 13)
            a1 (copy, index: 14)
            paintAll (copy, index: 15)
            UI_upv_1 (copy, index: 16)
            tbl_upv_8 (copy, index: 17)
            tbl_upv_11 (copy, index: 18)
        ]]
        if a35 == u9 or not State_upv_1.HasLoadoutSlots() or State_upv_1.LoadoutSlotCount() < a35 then
            return
        end
        if u7 then
            local v202 = copyDraft(u3)
            u7 = false
            u8 = u8 + 1
            task.spawn(save, v202, u10)
        end
        u9 = a35
        u11 = a35
        local _, v205, v203 = WeaponInfo_upv_1.Validate(State_upv_1.LoadoutSlot(a35))
        u3 = copyDraft(v203)
        u7 = false
        topUpAmmo()
        local v204 = u3.items[1] or u4
        u4 = v204
        u5 = nil
        a1.Sounds.Play("Equip")
        paintAll()
        UI_upv_1.Pop(tbl_upv_8[a35].tile, 1.2)
        for key_7, value_upv_22 in tbl_upv_11 do
            if u3.items[key_7] then
                task.delay(
                    key_7 * 0.03,
                    function()
                        --[[
                          line: 2045
                          upvalues:
                            UI_upv_1 (copy, index: 1)
                            value_upv_22 (copy, index: 2)
                        ]]
                        UI_upv_1.Pop(value_upv_22.tile, 1.12)
                    end
                )
            end
        end
        task.spawn(
            function()
                --[[
                  line: 2050
                  upvalues:
                    a1 (copy, index: 1)
                    a35 (copy, index: 2)
                    State_upv_1 (copy, index: 3)
                    u11 (ref,  index: 4)
                ]]
                local v205 = a1.ProfileAction("SelectLoadout", a35)
                if v205 then
                    State_upv_1.Profile.activeLoadout = a35
                    State_upv_1.Profile.loadout = ((State_upv_1.Profile.loadouts) and (State_upv_1.Profile.loadouts[a35])) or (State_upv_1.Profile.loadout)
                end
                if u11 == a35 then
                    u11 = nil
                end
                if not v205 then
                    return
                end
                State_upv_1.ProfileChanged:Fire(State_upv_1.Profile)
            end
        )
    end
    local function dropUnusedAmmo()
        --[[
          name: dropUnusedAmmo
          line: 2067
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local v206 = WeaponInfo_upv_1.AmmoNeeded(u3)
        for key_8 in u3.ammo do
            if not (v206[key_8]) then
                u3.ammo[key_8] = nil
            end
        end
    end
    u39 = function(a36)
        --[[
          line: 2076
          upvalues:
            u3 (ref,  index: 1)
            WeaponInfo_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u7 (ref,  index: 4)
            u10 (ref,  index: 5)
            u9 (ref,  index: 6)
            u8 (ref,  index: 7)
            u22 (copy, index: 8)
            paintAll (copy, index: 10)
        ]]
        local v207 = table.find(u3.items, a36)
        if v207 then
            table.remove(u3.items, v207)
            local v208 = WeaponInfo_upv_1.AmmoNeeded(u3)
            for key_9 in u3.ammo do
                if not (v208[key_9]) then
                    u3.ammo[key_9] = nil
                end
            end
            a1.Sounds.Play("Close")
            u7 = true
            u10 = u9
            u8 = u8 + 1
            local _ = u8
            u22.Text = ""
            task.delay(1.2, function() end)
            paintAll()
        elseif u3.armor == a36 then
            u3.armor = false
            a1.Sounds.Play("Close")
            u7 = true
            u10 = u9
            u8 = u8 + 1
            local _ = u8
            u22.Text = ""
            task.delay(1.2, function() end)
            paintAll()
        end
    end
    u43 = function(a37, a38)
        --[[
          line: 2091
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            a1 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            u24 (copy, index: 5)
            ammoFloor (copy, index: 6)
            tbl_upv_14 (copy, index: 7)
            ammoUser (copy, index: 8)
            u7 (ref,  index: 9)
            u10 (ref,  index: 10)
            u9 (ref,  index: 11)
            u8 (ref,  index: 12)
            u22 (copy, index: 13)
            paintAll (copy, index: 15)
            Theme_upv_1 (copy, index: 16)
        ]]
        local v209 = WeaponInfo_upv_1.AmmoDef(a37)
        if not v209 then
            return
        end
        local v210 = u3.ammo[a37] or 0
        if a38 > 0 then
            if WeaponInfo_upv_1.MaxAmmoBundles() <= v210 then
                a1.Sounds.Play("Error")
                return
            else
                local v211 = WeaponInfo_upv_1.Cost(u3)
                if WeaponInfo_upv_1.Budget() < v211 + v209.points then
                    a1.Sounds.Play("Error")
                    UI_upv_1.Shake(u24, 5)
                    a1.Toast("Not enough points for more " .. string.lower(v209.name), "warning")
                    return
                end
            end
        elseif v210 <= 0 then
            return
        else
            local v212 = nil
            if ammoFloor(a37) then
                a1.Sounds.Play("Error")
                v212 = tbl_upv_14[a37]
                if v212 then
                    UI_upv_1.Shake(v212.frame, 5)
                end
                local v213 = ammoUser(a37)
                local Toast_1 = a1.Toast
                local v214 = ((not v213) and "weapon") or (WeaponInfo_upv_1.Name(v213))
                Toast_1(string.format("Your %s needs %s: remove it to free these points", v214, string.lower(v209.name)), "warning")
                return
            end
        end
        local ammo_1 = u3.ammo
        ammo_1[a37] = math.max(0, v210 + a38)
        if u3.ammo[a37] == 0 then
            u3.ammo[a37] = nil
        end
        local Play_1 = a1.Sounds.Play
        local tbl_36 = {pitch = 0}
        tbl_36.pitch = ((a38 > 0) and 1.2) or 0.9
        Play_1("Tick", tbl_36)
        u7 = true
        u10 = u9
        u8 = u8 + 1
        local _ = u8
        u22.Text = ""
        task.delay(1.2, function() end)
        paintAll()
        local v215 = tbl_upv_14[a37]
        if not v215 then
            return
        end
        UI_upv_1.Bump(v215.count, 0.15)
        UI_upv_1.Pop(v215.icon, 0.85, Theme_upv_1.Tween.PopSmall)
    end
    local function flashCard(a39)
        --[[
          name: flashCard
          line: 2155
          upvalues:
            UI_upv_1 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
        ]]
        if not a39 then
            return
        end
        a39.flash.BackgroundTransparency = 0.7
        local tbl_37 = {BackgroundTransparency = 1}
        UI_upv_1.Tween(a39.flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_37)
        UI_upv_1.Pop(a39.icon, 0.85, Theme_upv_1.Tween.PopSmall)
    end
    local function denied(a40, a41, a42)
        --[[
          name: denied
          line: 2135
          upvalues:
            a1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u24 (copy, index: 3)
            ammoExtra (copy, index: 4)
            WeaponInfo_upv_1 (copy, index: 5)
        ]]
        a1.Sounds.Play("Error")
        if a40 then
            UI_upv_1.Shake(a40.holder, 6)
        end
        UI_upv_1.Shake(u24, 4)
        local v216 = nil
        if a40 and a41 == "ammo" then
            local _, v217 = ammoExtra(a40.id)
            v216 = v217
        end
        if v216 then
            local Toast_2 = a1.Toast
            local v218 = WeaponInfo_upv_1.Name(a40.id)
            local v219 = string.lower(v216.name)
            Toast_2(string.format("%s needs %s too: %d more point%s, remove something first", v218, v219, a42, ((a42 ~= 1) and "s") or ""), "warning")
        else
            if a41 ~= "points" and a41 ~= "ammo" then
                if a41 == "full" then
                    a1.Toast("6 items max: remove one first", "warning")
                end
                return
            end
            a1.Toast(string.format("Needs %d more point%s: remove something first", a42, ((a42 ~= 1) and "s") or ""), "warning")
        end
    end
    u48 = function(a43, a44)
        --[[
          line: 2164
          upvalues:
            u3 (ref,  index: 1)
            u39 (ref,  index: 2)
            canAdd (copy, index: 3)
            u4 (ref,  index: 4)
            a1 (copy, index: 5)
            u74 (ref,  index: 6)
            denied (copy, index: 7)
            tbl_upv_19 (copy, index: 8)
            tbl_upv_2 (copy, index: 9)
            WeaponInfo_upv_1 (copy, index: 10)
            u40 (ref,  index: 11)
            tbl_upv_11 (copy, index: 12)
            u7 (ref,  index: 13)
            u10 (ref,  index: 14)
            u9 (ref,  index: 15)
            u8 (ref,  index: 16)
            u22 (copy, index: 17)
            paintAll (copy, index: 19)
            flashCard (copy, index: 20)
            UI_upv_1 (copy, index: 21)
        ]]
        local v220 = true
        if table.find(u3.items, a43) == nil then
            v220 = u3.armor == a43
        end
        if v220 then
            u39(a43)
        else
            local v220, v221, v222 = canAdd(a43)
            if not (v220) and v221 == "locked" then
                u4 = a43
                a1.Sounds.Play("Select")
                u74 = true
                local Open_2 = a1.MenuManager.Open
                local v223
                if a43 then
                    v223 = {}
                    v223.focus = a43
                else
                    v223 = nil
                end
                Open_2("Collection", v223)
                return
            end
            if v220 then
                local v224
                if WeaponInfo_upv_1.IsArmor(a43) then
                    u3.armor = a43
                    v224 = u40
                else
                    table.insert(u3.items, a43)
                    local v225 = tbl_upv_11[#u3.items]
                    local v226 = WeaponInfo_upv_1.AmmoOf(a43)
                    local v227 = v226 and (WeaponInfo_upv_1.AmmoDef(v226))
                    if v227 and (u3.ammo[v227.id] or 0) == 0 and WeaponInfo_upv_1.Cost(u3) + v227.points <= WeaponInfo_upv_1.Budget() then
                        u3.ammo[v227.id] = 1
                    end
                    v224 = v225
                end
                a1.Sounds.Play("Equip")
                u7 = true
                u10 = u9
                u8 = u8 + 1
                v220 = u8
                u22.Text = ""
                task.delay(1.2, function() end)
                paintAll()
                if not (a44) then
                    local _ = tbl_upv_19[a43]
                end
                flashCard(a44)
                UI_upv_1.Pop(v224.tile, 1.18)
            else
                denied(a44 or (tbl_upv_19[a43]), v221, v222)
                tbl_upv_2._paintDetail()
            end
        end
    end
    u61.Activated:Connect(
        function()
            --[[
              line: 2203
              upvalues:
                u4 (ref,  index: 1)
                Economy_upv_1 (copy, index: 2)
                u74 (ref,  index: 3)
                a1 (copy, index: 4)
                u48 (ref,  index: 5)
                tbl_upv_19 (copy, index: 6)
            ]]
            local v228 = u4
            if not v228 then
                return
            end
            if Economy_upv_1.IsLocked(v228) then
                u74 = true
                local Open_3 = a1.MenuManager.Open
                local v229
                if v228 then
                    v229 = {}
                    v229.focus = v228
                else
                    v229 = nil
                end
                Open_3("Collection", v229)
            else
                u48(v228, tbl_upv_19[v228])
            end
        end
    )
    local u75 = UI_upv_1.new("Frame", {Name = "Highlight", Size = UDim2.fromOffset(60, 36), BackgroundColor3 = Colors_upv_1.Accent, ZIndex = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u45})
    local function paintTabs(a45)
        --[[
          name: paintTabs
          line: 2225
          upvalues:
            tbl_upv_17 (copy, index: 1)
            u6 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            u45 (copy, index: 4)
            u2 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u75 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
        ]]
        local v230 = nil
        local _ = nil
        for key_10, value_upv_23 in tbl_upv_17 do
            local v231 = key_10 == u6
            local btn_3 = value_upv_23.btn
            if v231 then
                v230 = 1
            else
                v230 = 0.4
            end
            btn_3.BackgroundTransparency = v230
            local label_2 = value_upv_23.label
            if v231 then
                v230 = Colors_upv_1.Text
            else
                v230 = Colors_upv_1.TextDim
            end
            label_2.TextColor3 = v230
            if v231 then
                task.defer(
                    function()
                        --[[
                          line: 2231
                          upvalues:
                            value_upv_23 (copy, index: 1)
                            u45 (copy, index: 2)
                            u2 (copy, index: 3)
                            a45 (copy, index: 4)
                            UI_upv_1 (copy, index: 5)
                            u75 (copy, index: 6)
                            Theme_upv_1 (copy, index: 7)
                        ]]
                        local v232 = value_upv_23.btn.AbsolutePosition - u45.AbsolutePosition
                        local v233 = math.max(u45.AbsoluteSize.X / math.max(((u2.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01)
                        local tbl_38 = {}
                        tbl_38.Position = UDim2.fromOffset(v232.X / v233, v232.Y / v233)
                        tbl_38.Size = UDim2.fromOffset(value_upv_23.btn.AbsoluteSize.X / v233, value_upv_23.btn.AbsoluteSize.Y / v233)
                        if a45 then
                            UI_upv_1.Tween(u75, Theme_upv_1.Tween.Smooth, tbl_38)
                        else
                            u75.Position = tbl_38.Position
                            u75.Size = tbl_38.Size
                        end
                    end
                )
            end
        end
    end
    local function staggerCards()
        --[[
          name: staggerCards
          line: 1554
          upvalues:
            tbl_upv_18 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v234 = 0
        for _, value_24 in tbl_upv_18 do
            if value_24.visible then
                local v235 = math.min(v234 * 0.018, 0.22)
                value_24.inner.Position = UDim2.fromOffset(0, 14)
                value_24.scale.Scale = 0.94
                UI_upv_1.Tween(value_24.inner, TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, v235), {Position = UDim2.new()})
                local tbl_39 = {Scale = 1}
                UI_upv_1.Tween(value_24.scale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v235), tbl_39)
                v234 = v234 + 1
            end
        end
    end
    for key_11, value_upv_25 in WeaponInfo_upv_1.FILTERS do
        local tbl_40 = {}
        tbl_40.Name = value_upv_25.id
        tbl_40.Size = UDim2.fromOffset(0, 36)
        tbl_40.AutomaticSize = Enum.AutomaticSize.X
        tbl_40.BackgroundColor3 = Colors_upv_1.Raised
        tbl_40.BackgroundTransparency = 0.4
        tbl_40.LayoutOrder = key_11
        tbl_40.ZIndex = 2
        tbl_40[1], tbl_40[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 16, 0, 16)
        tbl_40.Parent = v77
        local u76 = UI_upv_1.new("TextButton", tbl_40)
        tbl_upv_17[value_upv_25.id] = {btn = u76, label = UI_upv_1.new("TextLabel", {TextSize = 15, ZIndex = 2, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, Text = value_upv_25.name, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u76})}
        u76.MouseEnter:Connect(
            function()
                --[[
                  line: 2269
                  upvalues:
                    u6 (ref,  index: 1)
                    value_upv_25 (copy, index: 2)
                    u76 (copy, index: 3)
                ]]
                if u6 == value_upv_25.id then
                    return
                end
                u76.BackgroundTransparency = 0.2
            end
        )
        u76.MouseLeave:Connect(
            function()
                --[[
                  line: 2274
                  upvalues:
                    u76 (copy, index: 1)
                    u6 (ref,  index: 2)
                    value_upv_25 (copy, index: 3)
                ]]
                u76.BackgroundTransparency = ((u6 ~= value_upv_25.id) and 0.4) or 1
            end
        )
        u76.Activated:Connect(
            function()
                --[[
                  line: 2277
                  upvalues:
                    u6 (ref,  index: 1)
                    value_upv_25 (copy, index: 2)
                    a1 (copy, index: 3)
                    paintTabs (copy, index: 4)
                    layoutGrid (copy, index: 5)
                    staggerCards (copy, index: 6)
                    queueVisible (copy, index: 7)
                ]]
                if u6 == value_upv_25.id then
                    return
                end
                u6 = value_upv_25.id
                a1.Sounds.Play("Tab")
                paintTabs(true)
                layoutGrid()
                staggerCards()
                task.defer(queueVisible)
            end
        )
    end
    paintTabs()
    local u77 = false
    local u78 = nil
    local u79 = nil
    local u80 = UI_upv_1.new("Frame", {Name = "InsertMarker", Size = UDim2.new(1, 0, 0, 3), BackgroundColor3 = Colors_upv_1.Accent, Visible = false, ZIndex = 8, [1] = UI_upv_1.Corner(2), Parent = u36})
    local function rowIndexAt(a46)
        --[[
          name: rowIndexAt
          line: 2312
          upvalues:
            u36 (copy, index: 1)
            u37 (ref,  index: 2)
            u38 (ref,  index: 3)
            u3 (ref,  index: 4)
        ]]
        return (math.clamp(math.floor(((a46.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1)))
    end
    local function sweepGhosts()
        --[[
          name: sweepGhosts
          line: 2317
          upvalues:
            u79 (ref,  index: 1)
            a1 (copy, index: 2)
            u80 (copy, index: 3)
        ]]
        if u79 then
            u79:Destroy()
            u79 = nil
        end
        for _, value_26 in a1.Canvas.Top:GetChildren() do
            if value_26.Name == "DragGhost" then
                value_26:Destroy()
            end
        end
        u80.Visible = false
    end
    local function pointOf(a47)
        --[[
          name: pointOf
          line: 2329
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if a47.UserInputType ~= Enum.UserInputType.Touch then
            return UI_upv_1.PointerAbs()
        end
        return Vector2.new(a47.Position.X, a47.Position.Y)
    end
    local u81 = nil
    local function endPress(a48)
        --[[
          name: endPress
          line: 2337
          upvalues:
            u78 (ref,  index: 1)
            sweepGhosts (copy, index: 2)
            u81 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            u36 (copy, index: 5)
            u37 (ref,  index: 6)
            u38 (ref,  index: 7)
            u3 (ref,  index: 8)
            a1 (copy, index: 9)
            u7 (ref,  index: 10)
            u10 (ref,  index: 11)
            u9 (ref,  index: 12)
            u8 (ref,  index: 13)
            u22 (copy, index: 14)
            paintAll (copy, index: 16)
            tbl_upv_11 (copy, index: 17)
            u4 (ref,  index: 18)
            tbl_upv_2 (copy, index: 19)
        ]]
        u78 = nil
        local v236 = (u78 ~= nil) and (u78.dragging)
        sweepGhosts()
        if not u78 then
            return
        end
        local tbl_41 = {to = 0}
        tbl_41.commit = a48
        tbl_41.dragging = v236
        tbl_41.from = u78.index
        local input_1 = u78.input
        local v237
        if input_1.UserInputType ~= Enum.UserInputType.Touch then
            v237 = UI_upv_1.PointerAbs()
        else
            v237 = Vector2.new(input_1.Position.X, input_1.Position.Y)
        end
        tbl_41.to = math.clamp(math.floor(((v237.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
        u81 = tbl_41
        local v238 = nil
        if v236 then
            v238 = u78.input
            local v239
            if v238.UserInputType ~= Enum.UserInputType.Touch then
                v239 = UI_upv_1.PointerAbs()
            else
                v239 = Vector2.new(v238.Position.X, v238.Position.Y)
            end
            local v240 = math.clamp(math.floor(((v239.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
            if a48 and v240 ~= u78.index and u3.items[u78.index] then
                local v241 = table.remove(u3.items, u78.index)
                table.insert(u3.items, v240, v241)
                a1.Sounds.Play("Equip")
                u7 = true
                u10 = u9
                u8 = u8 + 1
                local _ = u8
                u22.Text = ""
                task.delay(1.2, function() end)
                paintAll()
                UI_upv_1.Pop(tbl_upv_11[v240].tile, 1.18)
                return
            end
        elseif a48 then
            local v242 = nil
            if not (u78.armed) then
                v242 = u3.items[u78.index]
                if v242 then
                    u4 = v242
                    tbl_upv_2._paintDetail()
                end
                return
            end
        end
        paintAll()
    end
    local function insideGui(a49, a50)
        --[[
          name: insideGui
          line: 2369
        ]]
        local AbsolutePosition_1 = a49.AbsolutePosition
        local AbsoluteSize_1 = a49.AbsoluteSize
        return (AbsolutePosition_1.X <= a50.X) and ((a50.X <= AbsolutePosition_1.X + AbsoluteSize_1.X) and ((AbsolutePosition_1.Y <= a50.Y) and (a50.Y <= AbsolutePosition_1.Y + AbsoluteSize_1.Y)))
    end
    local function liftGhost(a51)
        --[[
          name: liftGhost
          line: 2373
          upvalues:
            sweepGhosts (copy, index: 1)
            u3 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            u37 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            WeaponInfo_upv_1 (copy, index: 7)
            tbl_upv_3 (copy, index: 8)
            WeaponIcon_upv_1 (copy, index: 9)
            Fonts_upv_1 (copy, index: 10)
            u79 (ref,  index: 11)
            tbl_upv_11 (copy, index: 12)
        ]]
        sweepGhosts()
        a51.dragging = true
        local v243 = u3.items[a51.index]
        local tbl_42 = {}
        tbl_42.Name = "DragGhost"
        tbl_42.AnchorPoint = Vector2.new(0, 0.5)
        tbl_42.Size = UDim2.fromOffset(320, u37)
        tbl_42.BackgroundColor3 = Colors_upv_1.Raised
        tbl_42.BackgroundTransparency = 0.05
        tbl_42.ZIndex = 50
        tbl_42[1], tbl_42[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)
        tbl_42.Parent = a1.Canvas.Top
        local v244 = UI_upv_1.new("Frame", tbl_42)
        local new_4 = UI_upv_1.new
        local tbl_43 = {}
        tbl_43.AnchorPoint = Vector2.new(0, 0.5)
        tbl_43.Position = UDim2.new(0, 4, 0.5, 0)
        tbl_43.Size = UDim2.fromOffset(u37 - 8, u37 - 8)
        local v245 = WeaponInfo_upv_1.Get(v243)
        tbl_43.BackgroundColor3 = ((v245 and (tbl_upv_3[v245.category])) or (Colors_upv_1.Accent)):Lerp(Colors_upv_1.Panel, 0.6)
        tbl_43.ZIndex = 51
        tbl_43[1] = UI_upv_1.Corner(9)
        tbl_43.Parent = v244
        local v246 = new_4("Frame", tbl_43)
        WeaponIcon_upv_1.Set(UI_upv_1.new("Frame", {ZIndex = 52, Size = UDim2.fromScale(1, 1), Parent = v246}), v243, {outline = false, glow = false})
        UI_upv_1.new("TextLabel", {ZIndex = 51, TextSize = 17, Position = UDim2.fromOffset(u37 + 8, 0), Size = UDim2.new(1, -(u37 + 16), 1, 0), Text = WeaponInfo_upv_1.Name(v243), FontFace = Fonts_upv_1.Bold, TextXAlignment = Enum.TextXAlignment.Left, Parent = v244})
        u79 = v244
        tbl_upv_11[a51.index].frame.BackgroundTransparency = 0.85
    end
    local function moveGhost(a52, a53)
        --[[
          name: moveGhost
          line: 2412
          upvalues:
            u79 (ref,  index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u36 (copy, index: 4)
            u37 (ref,  index: 5)
            u38 (ref,  index: 6)
            u3 (ref,  index: 7)
            u80 (copy, index: 8)
        ]]
        if not u79 then
            return
        end
        local v247 = (a53 - a1.Canvas.Top.AbsolutePosition) / math.max(UI_upv_1.Scale, 0.01)
        u79.Position = UDim2.fromOffset(v247.X - 40, v247.Y)
        v247 = math.clamp(math.floor(((a53.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
        u80.Visible = v247 ~= a52.index
        u80.Position = UDim2.fromOffset(0, ((v247 < a52.index) and ((v247 - 1) * (u37 + u38) - 4)) or (v247 * (u37 + u38) - 4))
    end
    for key_upv_12, value_upv_27 in tbl_upv_11 do
        value_upv_27.frame.InputBegan:Connect(
            function(a54)
                --[[
                  line: 2428
                  upvalues:
                    u78 (ref,  index: 1)
                    u3 (ref,  index: 2)
                    key_upv_12 (copy, index: 3)
                    u2 (copy, index: 4)
                    UI_upv_1 (copy, index: 5)
                    value_upv_27 (copy, index: 6)
                    sweepGhosts (copy, index: 7)
                    u81 (ref,  index: 8)
                    u36 (copy, index: 9)
                    u37 (ref,  index: 10)
                    u38 (ref,  index: 11)
                    paintAll (copy, index: 12)
                    u77 (ref,  index: 13)
                ]]
                local UserInputType_1 = a54.UserInputType
                if (UserInputType_1 == Enum.UserInputType.MouseButton1 or UserInputType_1 == Enum.UserInputType.Touch) and a54.UserInputState == Enum.UserInputState.Begin and (not u78 or u78.input ~= a54) then
                    if u3.items[key_upv_12] and u2.IsOpen then
                        local v248
                        if a54.UserInputType ~= Enum.UserInputType.Touch then
                            v248 = UI_upv_1.PointerAbs()
                        else
                            v248 = Vector2.new(a54.Position.X, a54.Position.Y)
                        end
                        local v249, v250 = nil, nil
                        if value_upv_27.remove.Visible then
                            local remove_2 = value_upv_27.remove
                            v249 = remove_2.AbsolutePosition
                            v250 = remove_2.AbsoluteSize
                            if (v249.X <= v248.X) and ((v248.X <= v249.X + v250.X) and ((v249.Y <= v248.Y) and (v248.Y <= v249.Y + v250.Y))) then
                                return
                            end
                        end
                        if u78 then
                            local v251 = u78
                            u78 = nil
                            local v252 = (v251 ~= nil) and (v251.dragging)
                            sweepGhosts()
                            local v253 = nil
                            if v251 then
                                local tbl_44 = {commit = false, to = 0}
                                tbl_44.dragging = v252
                                tbl_44.from = v251.index
                                v253 = v251.input
                                local v254
                                if v253.UserInputType ~= Enum.UserInputType.Touch then
                                    v254 = UI_upv_1.PointerAbs()
                                else
                                    v254 = Vector2.new(v253.Position.X, v253.Position.Y)
                                end
                                tbl_44.to = math.clamp(math.floor(((v254.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
                                u81 = tbl_44
                                local v255 = nil
                                if v252 then
                                    v255 = v251.input
                                    if v255.UserInputType ~= Enum.UserInputType.Touch then
                                        v250 = UI_upv_1.PointerAbs()
                                    else
                                        v250 = Vector2.new(v255.Position.X, v255.Position.Y)
                                    end
                                    local _ = math.clamp(math.floor(((v250.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
                                end
                                paintAll()
                            end
                        end
                        local tbl_45 = {armed = false, dragging = false, hold = 0}
                        tbl_45.index = key_upv_12
                        tbl_45.input = a54
                        tbl_45.start = v248
                        tbl_45.at = os.clock()
                        local v256 = true
                        if UserInputType_1 ~= Enum.UserInputType.Touch then
                            v256 = UI_upv_1.Touch or u77
                        end
                        tbl_45.hold = v256
                        u78 = tbl_45
                        return
                    end
                    return
                end
            end
        )
    end
    UserInputService_upv_1.InputChanged:Connect(
        function(a55)
            --[[
              line: 2459
              upvalues:
                u78 (ref,  index: 1)
                UI_upv_1 (copy, index: 2)
                sweepGhosts (copy, index: 3)
                u81 (ref,  index: 4)
                u36 (copy, index: 5)
                u37 (ref,  index: 6)
                u38 (ref,  index: 7)
                u3 (ref,  index: 8)
                paintAll (copy, index: 9)
                liftGhost (copy, index: 10)
                moveGhost (copy, index: 11)
            ]]
            if not u78 then
                return
            end
            local v257 = u78.input.UserInputType == Enum.UserInputType.Touch
            if v257 then
                if a55 ~= u78.input then
                    return
                end
            elseif a55.UserInputType ~= Enum.UserInputType.MouseMovement then
                return
            end
            local v258
            if v257 then
                v258 = u78.input
            else
                v258 = a55
            end
            local v259
            if v258.UserInputType ~= Enum.UserInputType.Touch then
                v259 = UI_upv_1.PointerAbs()
            else
                v259 = Vector2.new(v258.Position.X, v258.Position.Y)
            end
            local Magnitude_1 = (v259 - u78.start).Magnitude
            if u78.dragging then
                if u78.dragging then
                    moveGhost(u78, v259)
                end
            elseif u78.hold then
                if u78.armed then
                    if Magnitude_1 > 6 then
                        liftGhost(u78)
                    end
                    if u78.dragging then
                        moveGhost(u78, v259)
                    end
                elseif Magnitude_1 > 12 then
                    u78 = nil
                    local v260 = (u78 ~= nil) and (u78.dragging)
                    sweepGhosts()
                    if not u78 then
                        return
                    end
                    local tbl_46 = {commit = false, to = 0}
                    tbl_46.dragging = v260
                    tbl_46.from = u78.index
                    local input_2 = u78.input
                    local v261
                    if input_2.UserInputType ~= Enum.UserInputType.Touch then
                        v261 = UI_upv_1.PointerAbs()
                    else
                        v261 = Vector2.new(input_2.Position.X, input_2.Position.Y)
                    end
                    tbl_46.to = math.clamp(math.floor(((v261.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
                    u81 = tbl_46
                    local v262 = nil
                    if v260 then
                        v262 = u78.input
                        local v263
                        if v262.UserInputType ~= Enum.UserInputType.Touch then
                            v263 = UI_upv_1.PointerAbs()
                        else
                            v263 = Vector2.new(v262.Position.X, v262.Position.Y)
                        end
                        local _ = math.clamp(math.floor(((v263.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
                        paintAll()
                        return
                    end
                    paintAll()
                end
            else
                if Magnitude_1 > 12 then
                    liftGhost(u78)
                end
                if u78.dragging then
                    moveGhost(u78, v259)
                end
            end
        end
    )
    local function onEnded(a56)
        --[[
          name: onEnded
          line: 2493
          upvalues:
            u78 (ref,  index: 1)
            endPress (copy, index: 2)
        ]]
        if not u78 then
            return
        end
        if u78.input.UserInputType ~= Enum.UserInputType.Touch then
            if a56.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
        elseif a56 ~= u78.input then
            return
        end
        endPress(true)
    end
    UserInputService_upv_1.InputEnded:Connect(onEnded)
    UserInputService_upv_1.TouchEnded:Connect(onEnded)
    UserInputService_upv_1.WindowFocusReleased:Connect(
        function()
            --[[
              line: 2509
              upvalues:
                u78 (ref,  index: 1)
                sweepGhosts (copy, index: 2)
                u81 (ref,  index: 3)
                UI_upv_1 (copy, index: 4)
                u36 (copy, index: 5)
                u37 (ref,  index: 6)
                u38 (ref,  index: 7)
                u3 (ref,  index: 8)
                paintAll (copy, index: 9)
            ]]
            u78 = nil
            local v264 = (u78 ~= nil) and (u78.dragging)
            sweepGhosts()
            if not u78 then
                return
            end
            local tbl_47 = {commit = false, to = 0}
            tbl_47.dragging = v264
            tbl_47.from = u78.index
            local input_3 = u78.input
            local v265
            if input_3.UserInputType ~= Enum.UserInputType.Touch then
                v265 = UI_upv_1.PointerAbs()
            else
                v265 = Vector2.new(input_3.Position.X, input_3.Position.Y)
            end
            tbl_47.to = math.clamp(math.floor(((v265.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
            u81 = tbl_47
            if v264 then
                local input_4 = u78.input
                local v266
                if input_4.UserInputType ~= Enum.UserInputType.Touch then
                    v266 = UI_upv_1.PointerAbs()
                else
                    v266 = Vector2.new(input_4.Position.X, input_4.Position.Y)
                end
                local _ = math.clamp(math.floor(((v266.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
            end
            paintAll()
        end
    )
    UI_upv_1.Every(
        u36,
        0.1,
        function()
            --[[
              line: 2513
              upvalues:
                u78 (ref,  index: 1)
                u79 (ref,  index: 2)
                u80 (copy, index: 3)
                sweepGhosts (copy, index: 4)
                paintAll (copy, index: 5)
                u2 (copy, index: 6)
                u81 (ref,  index: 7)
                UI_upv_1 (copy, index: 8)
                u36 (copy, index: 9)
                u37 (ref,  index: 10)
                u38 (ref,  index: 11)
                u3 (ref,  index: 12)
                endPress (copy, index: 13)
                UserInputService_upv_1 (copy, index: 14)
                tbl_upv_11 (copy, index: 15)
                a1 (copy, index: 16)
            ]]
            if u78 then
                local UserInputState_1 = u78.input.UserInputState
                if u2.IsOpen and UserInputState_1 ~= Enum.UserInputState.Cancel then
                    if UserInputState_1 ~= Enum.UserInputState.End then
                        if u78.input.UserInputType == Enum.UserInputType.MouseButton1 and not (UserInputService_upv_1:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                            endPress(true)
                            return
                        end
                        if u78.hold and not (u78.armed) and os.clock() - u78.at >= 0.28 then
                            u78.armed = true
                            tbl_upv_11[u78.index].frame.BackgroundTransparency = 0.12
                            UI_upv_1.Bump(tbl_upv_11[u78.index].tile, 0.08)
                            a1.Sounds.Play("Select")
                        end
                    else
                        endPress(true)
                    end
                    return
                end
                u78 = nil
                local v267 = (u78 ~= nil) and (u78.dragging)
                sweepGhosts()
                if not u78 then
                    return
                end
                local tbl_48 = {commit = false, to = 0}
                tbl_48.dragging = v267
                tbl_48.from = u78.index
                local input_5 = u78.input
                local v268
                if input_5.UserInputType ~= Enum.UserInputType.Touch then
                    v268 = UI_upv_1.PointerAbs()
                else
                    v268 = Vector2.new(input_5.Position.X, input_5.Position.Y)
                end
                tbl_48.to = math.clamp(math.floor(((v268.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
                u81 = tbl_48
                if v267 then
                    local input_6 = u78.input
                    local v269
                    if input_6.UserInputType ~= Enum.UserInputType.Touch then
                        v269 = UI_upv_1.PointerAbs()
                    else
                        v269 = Vector2.new(input_6.Position.X, input_6.Position.Y)
                    end
                    local _ = math.clamp(math.floor(((v269.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
                end
                paintAll()
            elseif u79 or u80.Visible then
                sweepGhosts()
                paintAll()
            end
        end
    )
    a1.Debug.drag = function(a57, a58)
        --[[
          line: 2541
          upvalues:
            u77 (ref,  index: 1)
            a1 (copy, index: 2)
            u78 (ref,  index: 3)
            u81 (ref,  index: 4)
        ]]
        if a57 == "hold" then
            u77 = a58 == true
        end
        local v270 = 0
        for _, value_28 in a1.Canvas.Top:GetChildren() do
            if value_28.Name == "DragGhost" then
                v270 = v270 + 1
            end
        end
        local tbl_49 = {press = 0, lastEnd = 0, dragging = 0, ghosts = 0, armed = 0}
        tbl_49.press = u78 ~= nil
        tbl_49.dragging = u78 ~= nil and u78.dragging
        tbl_49.armed = u78 ~= nil and u78.armed
        tbl_49.ghosts = v270
        tbl_49.lastEnd = u81
        return tbl_49
    end
    a1.Debug.gear = function(a59, a60, a61)
        --[[
          line: 2557
          upvalues:
            u4 (ref,  index: 1)
            u48 (ref,  index: 2)
            tbl_upv_19 (copy, index: 3)
            WeaponInfo_upv_1 (copy, index: 4)
            u3 (ref,  index: 5)
            copyDraft (copy, index: 6)
            u7 (ref,  index: 7)
            u10 (ref,  index: 8)
            u9 (ref,  index: 9)
            u8 (ref,  index: 10)
            u22 (copy, index: 11)
            save (copy, index: 12)
            paintAll (copy, index: 13)
            u43 (ref,  index: 14)
            u6 (ref,  index: 15)
            paintTabs (copy, index: 16)
            layoutGrid (copy, index: 17)
            staggerCards (copy, index: 18)
            queueVisible (copy, index: 19)
            u5 (ref,  index: 20)
            u13 (ref,  index: 21)
            State_upv_1 (copy, index: 22)
        ]]
        if a59 == "toggle" then
            u4 = a60
            u48(a60, tbl_upv_19[a60])
        elseif a59 == "set" and type(a60) == "table" then
            local _, v278, v274 = WeaponInfo_upv_1.Validate(a60)
            local v275 = copyDraft(v274)
            u3 = v275
            local v276 = u3.items[1] or u4
            u4 = v276
            u7 = true
            u10 = u9
            u8 = u8 + 1
            local u82 = u8
            u22.Text = ""
            task.delay(
                1.2,
                function()
                    --[[
                      line: 1961
                      upvalues:
                        u82 (copy, index: 1)
                        u8 (ref,  index: 2)
                        save (copy, index: 3)
                    ]]
                    if u82 ~= u8 then
                        return
                    end
                    save()
                end
            )
            paintAll()
        elseif a59 == "ammo" then
            u43(a60, a61)
        elseif a59 == "filter" then
            u6 = a60
            paintTabs(true)
            layoutGrid()
            staggerCards()
            task.defer(queueVisible)
        elseif a59 == "hover" then
            u5 = a60
            local v277 = a60 or u4
            u4 = v277
            paintAll()
        elseif a59 == "slot" then
            u13(a60)
        end
        local tbl_50 = {}
        tbl_50.items = u3.items
        tbl_50.armor = u3.armor
        tbl_50.ammo = u3.ammo
        tbl_50.cost = WeaponInfo_upv_1.Cost(u3)
        tbl_50.saved = u22.Text
        tbl_50.slot = u9
        tbl_50.active = State_upv_1.ActiveLoadout()
        tbl_50.slots = State_upv_1.LoadoutSlotCount()
        return tbl_50
    end
    local u83 = false
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 2588
              upvalues:
                u2 (copy, index: 1)
                tbl_upv_4 (copy, index: 2)
                State_upv_1 (copy, index: 3)
                u7 (ref,  index: 4)
                u12 (ref,  index: 5)
                u9 (ref,  index: 6)
                u11 (ref,  index: 7)
                u3 (ref,  index: 8)
                copyDraft (copy, index: 9)
                paintAll (copy, index: 10)
            ]]
            if not u2.IsOpen then
                return
            end
            for key_13, value_29 in tbl_upv_4 do
                if State_upv_1.LoadoutCustomName(key_13) == value_29 then
                    tbl_upv_4[key_13] = nil
                end
            end
            if u7 then
                u12()
            else
                local v278 = u11 or (State_upv_1.ActiveLoadout())
                u9 = v278
                u3 = copyDraft(State_upv_1.LoadoutSlot(u9))
                paintAll()
            end
        end
    )
    local tbl_51 = {}
    function tbl_51.open(a62)
        --[[
          name: open
          line: 2607
          upvalues:
            layoutWindow (copy, index: 1)
            u83 (ref,  index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            makeCard (copy, index: 4)
            tbl_upv_18 (copy, index: 5)
            tbl_upv_19 (copy, index: 6)
            u9 (ref,  index: 7)
            State_upv_1 (copy, index: 8)
            u11 (ref,  index: 9)
            u3 (ref,  index: 10)
            copyDraft (copy, index: 11)
            u7 (ref,  index: 12)
            topUpAmmo (copy, index: 13)
            u4 (ref,  index: 14)
            u6 (ref,  index: 15)
            u5 (ref,  index: 16)
            u73 (ref,  index: 17)
            u22 (copy, index: 18)
            u1 (ref,  index: 19)
            TextChatService_upv_1 (copy, index: 20)
            StarterGui_upv_1 (copy, index: 21)
            u2 (copy, index: 22)
            layoutGrid (copy, index: 23)
            paintAll (copy, index: 24)
            paintTabs (copy, index: 25)
            staggerCards (copy, index: 26)
            queueVisible (copy, index: 27)
            u46 (copy, index: 28)
            flashCard (copy, index: 29)
        ]]
        layoutWindow()
        if not (u83) then
            u83 = true
            for _, value_30 in WeaponInfo_upv_1.AllItems() do
                if value_30.category ~= "ammo" then
                    local v279 = makeCard(value_30)
                    table.insert(tbl_upv_18, v279)
                    tbl_upv_19[value_30.id] = v279
                end
            end
        end
        u9 = State_upv_1.ActiveLoadout()
        u11 = nil
        local _, v281, u84 = WeaponInfo_upv_1.Validate(State_upv_1.LoadoutSlot(u9))
        u3 = copyDraft(u84)
        u7 = false
        topUpAmmo()
        local v280 = u3.items[1] or (WeaponInfo_upv_1.DefaultLoadout().items[1])
        u4 = v280
        if type(a62) == "table" and type(a62.focus) == "string" then
            local v282
            u84 = WeaponInfo_upv_1.Get(a62.focus) and a62.focus or nil
        else
            u84 = nil
        end
        if u84 then
            u4 = u84
            if u6 ~= "all" then
                u6 = "all"
            end
        end
        u5 = nil
        u73 = nil
        u22.Text = ""
        if not (u1) then
            local tbl_upv_52 = {}
            pcall(
                function()
                    --[[
                      line: 46
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        tbl_upv_52 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v281, v282 = nil, nil
                    if TextChatService_upv_1.ChatVersion ~= Enum.ChatVersion.TextChatService then
                        tbl_upv_52.core = StarterGui_upv_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                        StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                    else
                        v281 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                        v282 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                        if v281 then
                            tbl_upv_52.window = v281.Enabled
                            v281.Enabled = false
                        end
                        if not v282 then
                            return
                        end
                        tbl_upv_52.bar = v282.Enabled
                        v282.Enabled = false
                    end
                end
            )
            u1 = tbl_upv_52
        end
        u2:Open()
        task.defer(
            function()
                --[[
                  line: 2639
                  upvalues:
                    layoutGrid (copy, index: 1)
                    paintAll (copy, index: 2)
                    paintTabs (copy, index: 3)
                    staggerCards (copy, index: 4)
                    queueVisible (copy, index: 5)
                    u84 (copy, index: 6)
                    tbl_upv_19 (copy, index: 7)
                    u46 (copy, index: 8)
                    u2 (copy, index: 9)
                    flashCard (copy, index: 10)
                ]]
                layoutGrid()
                paintAll()
                paintTabs()
                staggerCards()
                queueVisible()
                local u85 = u84 and (tbl_upv_19[u84])
                if u85 then
                    local v283 = math.max(u46.AbsoluteSize.X / math.max(((u2.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01)
                    u46.CanvasPosition = Vector2.new(0, math.min(math.max(0, u85.y - 8) * v283, math.max(0, u46.AbsoluteCanvasSize.Y - u46.AbsoluteWindowSize.Y)))
                    queueVisible()
                    task.delay(
                        0.3,
                        function()
                            --[[
                              line: 2653
                              upvalues:
                                flashCard (copy, index: 1)
                                u85 (copy, index: 2)
                            ]]
                            flashCard(u85)
                        end
                    )
                end
            end
        )
    end
    function tbl_51.close(a63)
        --[[
          name: close
          line: 2659
          upvalues:
            u1 (ref,  index: 1)
            TextChatService_upv_1 (copy, index: 2)
            StarterGui_upv_1 (copy, index: 3)
            u7 (ref,  index: 4)
            copyDraft (copy, index: 5)
            u3 (ref,  index: 6)
            u10 (ref,  index: 7)
            u8 (ref,  index: 8)
            save (copy, index: 9)
            a1 (copy, index: 10)
            u78 (ref,  index: 11)
            sweepGhosts (copy, index: 12)
            u81 (ref,  index: 13)
            UI_upv_1 (copy, index: 14)
            u36 (copy, index: 15)
            u37 (ref,  index: 16)
            u38 (ref,  index: 17)
            paintAll (copy, index: 18)
            u2 (copy, index: 19)
        ]]
        local u86 = u1
        if u86 then
            u1 = nil
            pcall(
                function()
                    --[[
                      line: 71
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        u86 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v284 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v285 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v284 and u86.window ~= nil then
                        v284.Enabled = u86.window
                    end
                    if v285 and u86.bar ~= nil then
                        v285.Enabled = u86.bar
                    end
                    if u86.core == nil then
                        return
                    end
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, u86.core)
                end
            )
        end
        if u7 then
            local v286 = copyDraft(u3)
            u7 = false
            u8 = u8 + 1
            task.spawn(save, v286, u10)
        end
        if #u3.items == 0 then
            a1.Toast("A loadout needs at least one item. Your last one was kept.", "info")
        end
        u78 = nil
        local v287 = (u78 ~= nil) and (u78.dragging)
        sweepGhosts()
        local v288 = nil
        if u78 then
            local tbl_53 = {commit = false, to = 0}
            tbl_53.dragging = v287
            tbl_53.from = u78.index
            v288 = u78.input
            local v289
            if v288.UserInputType ~= Enum.UserInputType.Touch then
                v289 = UI_upv_1.PointerAbs()
            else
                v289 = Vector2.new(v288.Position.X, v288.Position.Y)
            end
            tbl_53.to = math.clamp(math.floor(((v289.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
            u81 = tbl_53
            local v290 = nil
            if v287 then
                v290 = u78.input
                local v291
                if v290.UserInputType ~= Enum.UserInputType.Touch then
                    v291 = UI_upv_1.PointerAbs()
                else
                    v291 = Vector2.new(v290.Position.X, v290.Position.Y)
                end
                local _ = math.clamp(math.floor(((v291.Y - u36.AbsolutePosition.Y) / math.max(u36.AbsoluteSize.X / 400, 0.01)) / (u37 + u38)) + 1, 1, math.max(#u3.items, 1))
            end
            paintAll()
        end
        u2:Close(a63)
    end
    function tbl_51.select()
        --[[
          name: select
          line: 2670
          upvalues:
            u4 (ref,  index: 1)
            tbl_upv_19 (copy, index: 2)
            tbl_upv_18 (copy, index: 3)
        ]]
        local v292 = u4 and (tbl_upv_19[u4])
        if v292 and v292.holder.Visible then
            return v292.holder
        end
        for _, value_31 in tbl_upv_18 do
            if not (value_31.holder.Visible) then
                continue
            end
            return value_31.holder
        end
        return nil
    end
    a1.MenuManager.Register("Loadout", tbl_51)
    State_upv_1.PlayerStateChanged:Connect(
        function(a64)
            --[[
              line: 2685
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a64 ~= "Match" or not a1.MenuManager.IsOpen("Loadout") then
                return
            end
            a1.MenuManager.Close("Loadout", true)
        end
    )
    u2.Closed:Connect(restoreChat)
    Economy_upv_1.Changed:Connect(
        function()
            --[[
              line: 2692
              upvalues:
                u2 (copy, index: 1)
                u83 (ref,  index: 2)
                layoutGrid (copy, index: 3)
                queueVisible (copy, index: 4)
                tbl_upv_18 (copy, index: 5)
                tbl_upv_2 (copy, index: 6)
            ]]
            if not u2.IsOpen or not u83 then
                return
            end
            layoutGrid(true)
            queueVisible()
            for _, value_32 in tbl_upv_18 do
                tbl_upv_2._paintCard(value_32)
            end
            tbl_upv_2._paintDetail()
        end
    )
    Economy_upv_1.Event:Connect(
        function(a65, a66)
            --[[
              line: 2702
              upvalues:
                u2 (copy, index: 1)
                paintAll (copy, index: 2)
            ]]
            if a65 ~= "Unlocked" or not u2.IsOpen then
                return
            end
            task.delay(
                0.2,
                function()
                    --[[
                      line: 2704
                      upvalues:
                        paintAll (copy, index: 1)
                    ]]
                    paintAll()
                end
            )
        end
    )
    local u87 = false
    Economy_upv_1.CelebrationChanged:Connect(
        function(a67)
            --[[
              line: 2713
              upvalues:
                u2 (copy, index: 1)
                u87 (ref,  index: 2)
                paintAll (copy, index: 3)
                flashCard (copy, index: 4)
                u4 (ref,  index: 5)
                tbl_upv_19 (copy, index: 6)
            ]]
            if a67 and u2.IsOpen and not (u87) then
                u87 = true
                u2.Holder.Visible = false
                return
            end
            if (a67) or not u87 then
                return
            end
            u87 = false
            u2.Holder.Visible = true
            if not u2.IsOpen then
                return
            end
            paintAll()
            flashCard((u4 and (tbl_upv_19[u4])) or nil)
        end
    )
    local function relayout()
        --[[
          name: relayout
          line: 2726
          upvalues:
            u2 (copy, index: 1)
            layoutWindow (copy, index: 2)
            layoutGrid (copy, index: 3)
            paintAll (copy, index: 4)
            paintTabs (copy, index: 5)
            queueVisible (copy, index: 6)
        ]]
        if not u2.IsOpen then
            return
        end
        layoutWindow()
        u2.Refit()
        task.defer(
            function()
                --[[
                  line: 2730
                  upvalues:
                    layoutGrid (copy, index: 1)
                    paintAll (copy, index: 2)
                    paintTabs (copy, index: 3)
                    queueVisible (copy, index: 4)
                ]]
                layoutGrid()
                paintAll()
                paintTabs()
                queueVisible()
            end
        )
    end
    UI_upv_1.LayoutChanged:Connect(relayout)
    UI_upv_1.OnResize(relayout)
end
return tbl_upv_2