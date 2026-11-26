local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local textService = game:GetService("TextService")
local textChatService = game:GetService("TextChatService")
local starterGui = game:GetService("StarterGui")
local v6 = nil

local function hideChat()
    --[[
      name: hideChat
      line: 41
      upvalues:
        v6 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    if v6 then
        return
    end

    local v8 = {}

    pcall(
        function()
            --[[
              line: 46
              upvalues:
                textChatService (copy, index: 1)
                v8 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            if textChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then
                v8.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
            else
                local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                if chatWindowConfiguration then
                    v8.window = chatWindowConfiguration.Enabled
                    chatWindowConfiguration.Enabled = false
                end

                if chatInputBarConfiguration then
                    v8.bar = chatInputBarConfiguration.Enabled
                    chatInputBarConfiguration.Enabled = false
                end
            end
        end
    )

    v6 = v8
end

local function restoreChat()
    --[[
      name: restoreChat
      line: 65
      upvalues:
        v6 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    local v12 = v6
    if not v12 then
        return
    end

    v6 = nil

    pcall(
        function()
            --[[
              line: 71
              upvalues:
                textChatService (copy, index: 1)
                v12 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration and v12.window ~= nil then
                chatWindowConfiguration.Enabled = v12.window
            end

            if chatInputBarConfiguration and v12.bar ~= nil then
                chatInputBarConfiguration.Enabled = v12.bar
            end

            if v12.core ~= nil then
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v12.core)
            end
        end
    )
end

local v15 = {}
local color3FromRGB = Color3.fromRGB
local v17 = {bow = color3FromRGB(56, 189, 248), gun = color3FromRGB(251, 146, 60), melee = color3FromRGB(248, 113, 113), throwable = color3FromRGB(167, 139, 250), utility = color3FromRGB(250, 204, 21), healing = color3FromRGB(74, 222, 128), armor = color3FromRGB(148, 197, 255)}

function v15.Init(a18)
    --[[
      name: Init
      line: 106
      upvalues:
        v17 (copy, index: 1)
        textService (copy, index: 2)
        v15 (copy, index: 3)
        runService (copy, index: 4)
        userInputService (copy, index: 5)
        v6 (ref,  index: 6)
        textChatService (copy, index: 7)
        starterGui (copy, index: 8)
        restoreChat (copy, index: 9)
    ]]
    local ui = a18.UI
    local theme = a18.Theme
    local state = a18.State
    local weaponInfo = a18.WeaponInfo
    local weaponIcon = a18.WeaponIcon
    local colors = theme.Colors
    local fonts = theme.Fonts
    local economy = a18.Economy

    do
        local function catOf(a28)
            --[[
              name: catOf
              line: 111
              upvalues:
                weaponInfo (copy, index: 1)
                v17 (copy, index: 2)
                colors (copy, index: 3)
            ]]
            local v29 = weaponInfo.Get(a28)
            return v29 and v17[v29.category] or colors.Accent
        end
    end

    do
        local function tintGradient(parent, startValue, a33)
            --[[
              name: tintGradient
              line: 115
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
            ]]
            local v34 = ui.Gradient(startValue:Lerp(colors.Panel, 1 - a33), colors.PanelHi:Lerp(colors.Panel, 0.6), 115)
            v34.Parent = parent
            return v34
        end
    end

    local function iconOpts(id, a37)
        --[[
          name: iconOpts
          line: 120
          upvalues:
            weaponInfo (copy, index: 1)
            v17 (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local v38 = {outline = false, glow = false, outlineScale = 1.035, outlineTransparency = 0.5}
        local v39 = weaponInfo.Get(id)
        local v40 = v39 and v17[v39.category] or colors.Accent
        v38.outlineColor = v40:Lerp(Color3.new(1, 1, 1), 0.55)

        if a37 then
            for v41, v42 in a37 do
                v38[v41] = v42
            end
        end

        return v38
    end

    local v43 = ui.Window(
        {
            Name = "Loadout",
            Title = "LOADOUT",
            Subtitle = "Pick any gear up to 12 points.",
            HeaderHeight = 80,
            OpenSound = "Armory_Open",
            Size = UDim2.fromOffset(1280, 720),
            Parent = a18.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 138
                  upvalues:
                    a18 (copy, index: 1)
                ]]
                a18.MenuManager.Close("Loadout")
            end)
        }
    )
    local content = v43.Content
    local v45 = {armor = false, items = {}, ammo = {}}
    local v46 = nil
    local v47 = nil
    local v48 = "all"
    local v49 = false
    local count = 0
    local slot = 1
    local v52 = 1
    local v53 = nil
    local v54 = {}
    local v55 = nil
    local v56 = nil
    local ui2 = nil

    local function budget()
        --[[
          name: budget
          line: 162
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        return weaponInfo.Budget()
    end

    do
        local function cost()
            --[[
              name: cost
              line: 165
              upvalues:
                weaponInfo (copy, index: 1)
                v45 (ref,  index: 2)
            ]]
            return weaponInfo.Cost(v45)
        end
    end

    do
        local function has(target)
            --[[
              name: has
              line: 168
              upvalues:
                v45 (ref, index: 1)
            ]]
            return table.find(v45.items, target) ~= nil or v45.armor == target
        end
    end

    local function copyDraft(a63)
        --[[
          name: copyDraft
          line: 171
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        local v64 = weaponInfo.Normalize(a63)
        return {items = table.clone(v64.items), armor = v64.armor, ammo = table.clone(v64.ammo)}
    end

    local function missingAmmo(a66)
        --[[
          name: missingAmmo
          line: 180
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        local v67 = weaponInfo.AmmoNeeded(a66)
        local v68 = {}

        for _, v70 in weaponInfo.AmmoTypes() do
            if not v70.optional then
                if not v67[v70.id] then
                    continue
                end
                if not ((a66.ammo[v70.id] or 0) < 1) then
                    continue
                end

                local v71 = false

                for _, v73 in weaponInfo.AmmoTypes() do
                    local v74 = v71 or v73.as == v70.id and 1 <= (a66.ammo[v73.id] or 0)
                    v71 = v74
                end

                if v71 then
                    continue
                end

                table.insert(v68, v70.id)
            end
        end

        return v68
    end

    local function ammoExtra(a76)
        --[[
          name: ammoExtra
          line: 197
          upvalues:
            weaponInfo (copy, index: 1)
            v45 (ref,  index: 2)
            missingAmmo (copy, index: 3)
        ]]
        local points
        local v78 = if weaponInfo.IsArmor(a76) then nil else weaponInfo.AmmoOf(a76)
        local v79 = v78 and weaponInfo.AmmoDef(v78)
        if not v79 then
            return 0, nil
        end

        local v80 = {items = table.clone(v45.items), armor = v45.armor, ammo = v45.ammo}
        table.insert(v80.items, a76)

        if table.find(missingAmmo(v80), v79.id) then
            points = v79.points
        else
            points = 0
        end

        return points, v79
    end

    local function ammoUser(a82)
        --[[
          name: ammoUser
          line: 208
          upvalues:
            weaponInfo (copy, index: 1)
            v45 (ref,  index: 2)
        ]]
        local v83 = weaponInfo.AmmoDef(a82)

        for _, item in v45.items do
            if const v86 = weaponInfo.AmmoOf(item) then
                if v86 ~= a82 and (not v83 or v83.as ~= v86) then
                    continue
                end

                return item
            end
        end

        return nil
    end

    local function ammoFloor(a88)
        --[[
          name: ammoFloor
          line: 219
          upvalues:
            v45 (ref,  index: 1)
            missingAmmo (copy, index: 2)
        ]]
        if (v45.ammo[a88] or 0) ~= 1 then
            return false
        end

        local v89 = {items = v45.items, armor = v45.armor, ammo = table.clone(v45.ammo)}
        v89.ammo[a88] = nil
        local length = #missingAmmo(v89)

        return #missingAmmo(v45) < length
    end

    local function canAdd(target)
        --[[
          name: canAdd
          line: 228
          upvalues:
            v45 (ref,  index: 1)
            economy (copy, index: 2)
            weaponInfo (copy, index: 3)
            ammoExtra (copy, index: 4)
        ]]
        if table.find(v45.items, target) ~= nil or v45.armor == target then
            return false, "in", 0
        end
        if economy.IsLocked(target) then
            return false, "locked", 0
        end

        local v93 = weaponInfo.Points(target)
        local v94 = weaponInfo.Cost(v45)

        if not weaponInfo.IsArmor(target) or not v45.armor then
            if not weaponInfo.IsArmor(target) then
                local itemCount = #v45.items

                if weaponInfo.MaxItems() <= itemCount then
                    return false, "full", 0
                end
            end
        else
            v94 -= weaponInfo.Points(v45.armor)
        end

        local v96 = ammoExtra(target)
        local v97 = (v94 + v93) + v96 - weaponInfo.Budget()

        if not (0 < v97) then
            return true, nil, 0
        end

        local v98 = not (v94 + v93 <= weaponInfo.Budget()) and "points" or "ammo"

        return false, v98, v97
    end

    local parent = ui.new("Frame", {Name = "Slots", Position = UDim2.fromOffset(300, 12), Size = UDim2.new(0, 700, 0, 56), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = v43.Header})
    local v100 = {}
    local v101 = nil

    do
        local v102 = nil

        for layoutOrder = 1, 5 do
            do
                local ui3 = ui.new("TextButton", {Name = "Slot" .. layoutOrder, Size = UDim2.fromOffset(140, 56), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.35, LayoutOrder = layoutOrder, (ui.Corner(12)), Parent = parent})
                local stroke = ui.Stroke(colors.Stroke, 1, 0.9)
                stroke.Parent = ui3
                local ui4 = ui.new("Frame", {Name = "Tile", Position = UDim2.fromOffset(6, 6), Size = UDim2.fromOffset(44, 44), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(9)), Parent = ui3})
                local accent = colors.Accent
                local tileGrad = ui.Gradient(accent:Lerp(colors.Panel, 0.7), colors.PanelHi:Lerp(colors.Panel, 0.6), 115)
                tileGrad.Parent = ui4
                local icon = ui.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95), Parent = ui4})
                local name = ui.new("TextLabel", {Name = "SlotName", AutoLocalize = false, Text = "", TextSize = 15, Position = UDim2.fromOffset(58, 8), Size = UDim2.new(1, -86, 0, 20), FontFace = fonts.Bold, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3})
                local sub = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 12, Position = UDim2.fromOffset(58, 30), Size = UDim2.new(1, -62, 0, 16), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui3})
                local ui5 = ui.new("TextButton", {Name = "Rename", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -4, 1, -4), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.6, Visible = false, ZIndex = 3, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
                ui.Icon("pencil", 16, colors.Text, {ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui5})
                local box = ui.new(
                    "TextBox",
                    {
                        Name = "NameBox",
                        AutoLocalize = false,
                        Position = UDim2.fromOffset(54, 5),
                        Size = UDim2.new(1, -58, 0, 26),
                        Text = "",
                        PlaceholderText = a18.Loc.T("LOADOUT " .. layoutOrder),
                        PlaceholderColor3 = colors.TextMuted,
                        ClearTextOnFocus = false,
                        FontFace = fonts.Bold,
                        TextSize = 15,
                        TextColor3 = colors.Text,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundColor3 = colors.Inset,
                        BackgroundTransparency = 0.05,
                        Visible = false,
                        ZIndex = 4,
                        ui.Corner(6),
                        (ui.Padding(0, 6, 0, 6)),
                        Parent = ui3
                    }
                )
                icon.Visible = false
                v100[layoutOrder] = {shownIcon = nil, btn = ui3, stroke = stroke, tile = ui4, tileGrad = tileGrad, icon = icon, name = name, sub = sub, pencil = ui5, box = box, numL = ui.new("TextLabel", {Name = "Num", TextSize = 22, ZIndex = 2, Size = UDim2.fromScale(1, 1), Text = tostring(layoutOrder), FontFace = fonts.Display, TextColor3 = colors.TextDim, Parent = ui4})}

                ui3.MouseEnter:Connect(
                    function()
                        --[[
                          line: 357
                          upvalues:
                            layoutOrder (copy, index: 1)
                            slot (ref,  index: 2)
                            ui (copy, index: 3)
                            ui3 (copy, index: 4)
                            a18 (copy, index: 5)
                        ]]
                        if layoutOrder ~= slot and not ui.Touch then
                            ui3.BackgroundTransparency = 0.15
                            a18.Sounds.Play("Hover")
                        end
                    end
                )

                ui3.MouseLeave:Connect(
                    function()
                        --[[
                          line: 363
                          upvalues:
                            v55 (ref, index: 1)
                        ]]
                        v55()
                    end
                )

                ui3.Activated:Connect(
                    function()
                        --[[
                          line: 366
                          upvalues:
                            v101 (ref,  index: 1)
                            layoutOrder (copy, index: 2)
                            slot (ref,  index: 3)
                            ui (copy, index: 4)
                            ui3 (copy, index: 5)
                            v56 (ref,  index: 6)
                        ]]
                        if v101 == layoutOrder then
                            return
                        end

                        if layoutOrder == slot then
                            ui.Bump(ui3, 0.04)
                            return
                        end

                        v56(layoutOrder)
                    end
                )

                ui5.Activated:Connect(
                    function()
                        --[[
                          line: 376
                          upvalues:
                            v101 (ref,  index: 1)
                            layoutOrder (copy, index: 2)
                            box (copy, index: 3)
                            v54 (copy, index: 4)
                            state (copy, index: 5)
                            name (copy, index: 6)
                            ui5 (copy, index: 7)
                            a18 (copy, index: 8)
                        ]]
                        if v101 then
                            return
                        end

                        v101 = layoutOrder
                        local text = v54[layoutOrder] or state.LoadoutCustomName(layoutOrder)
                        box.Text = text
                        box.Visible = true
                        name.Visible = false
                        ui5.Visible = false
                        box:CaptureFocus()
                        a18.Sounds.Play("Click")
                    end
                )

                box:GetPropertyChangedSignal("Text"):Connect(
                    function()
                        --[[
                          line: 388
                          upvalues:
                            box (copy, index: 1)
                        ]]
                        if utf8.len(box.Text) and 16 < utf8.len(box.Text) then
                            box.Text = string.sub(box.Text, 1, (utf8.offset(box.Text, 17) or 17) - 1)
                        end
                    end
                )

                box.FocusLost:Connect(
                    function()
                        --[[
                          line: 393
                          upvalues:
                            v102 (ref,  index: 1)
                            layoutOrder (copy, index: 2)
                        ]]
                        v102(layoutOrder)
                    end
                )
            end
        end

        v102 = function(loadoutNameKey)
            --[[
              line: 398
              upvalues:
                v101 (ref,  index: 1)
                v100 (copy, index: 2)
                v54 (copy, index: 3)
                state (copy, index: 4)
                v55 (ref,  index: 5)
                a18 (copy, index: 6)
            ]]
            if v101 ~= loadoutNameKey then
                return
            end

            v101 = nil
            local v116 = v100[loadoutNameKey]
            v116.box.Visible = false
            v116.name.Visible = true
            local text = string.gsub(string.gsub(v116.box.Text, "^%s+", ""), "%s+$", "")
            local v118 = v54[loadoutNameKey] or state.LoadoutCustomName(loadoutNameKey)

            if text == v118 then
                v55()
                return
            end

            v54[loadoutNameKey] = text
            v55()

            task.spawn(
                function()
                    --[[
                      line: 414
                      upvalues:
                        a18 (copy, index: 1)
                        loadoutNameKey (copy, index: 2)
                        text (copy, index: 3)
                        v54 (copy, index: 4)
                        state (copy, index: 5)
                        v55 (ref,  index: 6)
                    ]]
                    local v119, _, v121 = a18.ProfileAction("RenameLoadout", loadoutNameKey, text)

                    if v119 then
                        local v122

                        if type(v121) ~= "string" then
                            v122 = text
                        else
                            v122 = v121
                        end

                        v54[loadoutNameKey] = v122
                        local loadoutNames = state.Profile.loadoutNames

                        if type(loadoutNames) == "table" then
                            loadoutNames[loadoutNameKey] = v122
                        end

                        if v122 ~= text then
                            a18.Toast("Name changed by the chat filter", "info")
                        end

                        a18.Sounds.Play("Select")
                    else
                        v54[loadoutNameKey] = nil
                    end

                    v55()
                end
            )
        end
    end

    local function layoutSlots()
        --[[
          name: layoutSlots
          line: 434
          upvalues:
            state (copy, index: 1)
            v43 (copy, index: 2)
            ui (copy, index: 3)
            parent (copy, index: 4)
            v100 (copy, index: 5)
            slot (ref,  index: 6)
        ]]
        local v125 = state.LoadoutSlotCount()
        local offset = v43.Holder.Size.X.Offset
        local v127 = ui.Compact and 250 or 290
        local v128 = ui.Compact and 66 or 56
        local v129 = ui.Compact and 7 or 12

        if const closeButton = v43.CloseButton then
            closeButton.Size = UDim2.fromOffset(v128, v128)
            closeButton.Position = UDim2.new(1, -14, 0, v129)
        end

        local v131 = v128 + 26 + 16
        local v132 = offset - v127 - v131
        local v133 = not (1 < v125) and 0 or 34
        local clampedValue = math.clamp(math.floor((v132 - v133 - (6 * (v125 - 1))) / v125), 92, 260)
        parent.Position = UDim2.fromOffset(v127, v129)
        parent.Size = UDim2.fromOffset(v132, v128)

        for v135, v136 in v100 do
            local v137
            v136.btn.Visible = v135 <= v125
            local btn = v136.btn
            local udim2FromOffset = UDim2.fromOffset

            if v135 == slot then
                v137 = clampedValue + v133
            else
                v137 = clampedValue
            end

            btn.Size = udim2FromOffset(v137, v128)
            local v140 = v128 - 20
            v136.tile.Size = UDim2.fromOffset(v140, v140)
            v136.tile.Position = UDim2.fromOffset(8, 10)
            v136.name.Position = UDim2.fromOffset(v140 + 16, (v128 / 2) - 20)
            v136.sub.Position = UDim2.fromOffset(v140 + 16, (v128 / 2) + 2)
            v136.box.Position = UDim2.fromOffset(v140 + 12, (v128 / 2) - 23)
        end

        v43.Subtitle.Visible = not ui.Compact
    end

    ui.TouchChanged:Connect(
        function()
            --[[
              line: 469
              upvalues:
                layoutSlots (copy, index: 1)
            ]]
            task.defer(layoutSlots)
        end
    )

    v55 = function()
        --[[
          line: 472
          upvalues:
            layoutSlots (copy, index: 1)
            state (copy, index: 2)
            weaponInfo (copy, index: 3)
            v100 (copy, index: 4)
            slot (ref,  index: 5)
            v45 (ref,  index: 6)
            colors (copy, index: 7)
            v101 (ref,  index: 8)
            v54 (copy, index: 9)
            a18 (copy, index: 10)
            theme (copy, index: 11)
            ui2 (ref,  index: 12)
            ui (copy, index: 13)
        ]]
        layoutSlots()
        local v141 = state.LoadoutSlotCount()
        local hasLoadoutSlots = state.HasLoadoutSlots()
        local v143 = math.max(weaponInfo.Budget(), 1)

        for v144, v145 in v100 do
            if not (v141 < v144) then
                local v146 = v144 == slot
                local v147 = if v146 then v45 else state.LoadoutSlot(v144)
                v145.tileGrad.Color = if v146 then ColorSequence.new(colors.AccentDark, colors.AccentDark) else ColorSequence.new(colors.Panel, colors.Panel)
                v145.numL.TextColor3 = if v146 then colors.Text else colors.TextDim
                local text, name
                local v150, v151 = false, false

                if v101 ~= v144 then
                    text = v54[v144]
                    name = v145.name

                    if text then
                        if text == "" then
                            v150 = true
                        else
                            v151 = true
                        end
                    else
                        v150 = true
                    end
                end

                if v150 then
                    if text ~= "" then
                        text = a18.Loc.T(state.LoadoutName(v144))
                    else
                        text = a18.Loc.T("LOADOUT " .. v144)
                    end

                    v151 = true
                end

                if v151 then
                    name.Text = text
                end

                local v152 = weaponInfo.Cost(v147)
                v145.btn.BackgroundColor3 = if v146 then colors.Accent else colors.Raised
                v145.btn.BackgroundTransparency = v146 and 0 or 0.35
                v145.stroke.Color = if v146 then theme.Lighten(colors.Accent, 0.35) else colors.Stroke
                v145.stroke.Transparency = v146 and 0.2 or 0.9
                v145.name.TextColor3 = if v146 then colors.Text else colors.TextDim
                v145.sub.Text = v146 and "✓ EQUIPPED" or string.format("%d / %d PTS", v152, v143)
                v145.sub.TextColor3 = if v146 then colors.Text else colors.TextMuted
                local pencil = v145.pencil
                local v154 = v146 and hasLoadoutSlots and v101 ~= v144
                pencil.Visible = v154
                local v155 = v145.tile.Size.X.Offset + 18
                v145.name.Size = UDim2.new(1, -v155, 0, 20)
                local sub = v145.sub
                v154 = UDim2.new
                local v157 = if v146 and hasLoadoutSlots then -(v155 + 30) else -v155
                sub.Size = v154(1, v157, 0, 16)
            end
        end

        ui2.Text = ui.Gamepad and "YOUR ITEMS  ·  HOTBAR ORDER" or "YOUR ITEMS  ·  HOTBAR KEYS 1–6"
    end

    local parent2 = ui.new("Frame", {Name = "Left", Size = UDim2.new(0, 400, 1, 0), Parent = content})
    ui2 = ui.new("TextLabel", {Name = "Heading", Text = "YOUR ITEMS  ·  HOTBAR KEYS 1–6", TextSize = 14, Size = UDim2.new(1, -120, 0, 18), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent2})
    local ui6 = ui.new("TextLabel", {Name = "Save", Text = "", TextSize = 13, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(120, 18), FontFace = fonts.Bold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent2})
    local parent3 = ui.new("Frame", {Name = "Points", Position = UDim2.fromOffset(0, 22), Size = UDim2.new(1, 0, 0, 58), Parent = parent2})
    local parent4 = ui.new("Frame", {Name = "Line", Size = UDim2.new(1, -110, 0, 36), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Bottom)), Parent = parent3})
    local ui7 = ui.new("TextLabel", {Name = "Number", Text = "", TextSize = 34, LayoutOrder = 1, Size = UDim2.fromOffset(112, 36), TextXAlignment = Enum.TextXAlignment.Left, FontFace = fonts.Display, Parent = parent4})
    local count2 = 0

    do
        local function measureNum()
            --[[
              name: measureNum
              line: 556
              upvalues:
                count2 (ref,  index: 1)
                ui7 (copy, index: 2)
                fonts (copy, index: 3)
                textService (copy, index: 4)
            ]]
            count2 += 1
            local v165 = count2
            local text = ui7.Text
            local textSize = ui7.TextSize

            task.spawn(
                function()
                    --[[
                      line: 559
                      upvalues:
                        text (copy, index: 1)
                        fonts (copy, index: 2)
                        textSize (copy, index: 3)
                        textService (copy, index: 4)
                        v165 (copy, index: 5)
                        count2 (ref,  index: 6)
                        ui7 (copy, index: 7)
                    ]]
                    local params = Instance.new("GetTextBoundsParams")
                    params.Text = text
                    params.Font = fonts.Display
                    params.Size = textSize
                    params.Width = 1000
                    local success, textBoundsAsync = pcall(
                        function()
                            --[[
                              line: 565
                              upvalues:
                                textService (copy, index: 1)
                                params (copy, index: 2)
                            ]]
                            return textService:GetTextBoundsAsync(params)
                        end
                    )

                    if success and v165 == count2 and 4 < textBoundsAsync.X then
                        ui7.Size = UDim2.fromOffset(math.ceil(textBoundsAsync.X) + 2, ui7.Size.Y.Offset)
                    end
                end
            )
        end

        ui7:GetPropertyChangedSignal("Text"):Connect(measureNum)
    end

    local ui8 = ui.new("TextLabel", {Name = "Word", Text = "POINTS", TextSize = 15, LayoutOrder = 2, Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent4})
    local ui9 = ui.new("TextLabel", {Name = "Left", Text = "", TextSize = 15, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 12), Size = UDim2.fromOffset(110, 22), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent3})
    local ui10 = ui.new("TextLabel", {Name = "Helper", Text = "", TextSize = 14, Position = UDim2.fromOffset(0, 60), Size = UDim2.new(1, 0, 0, 18), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})
    local parent5 = ui.new("Frame", {Name = "Bar", Position = UDim2.fromOffset(0, 44), Size = UDim2.new(1, 0, 0, 10), BackgroundColor3 = colors.Inset, ClipsDescendants = true, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Stroke, 1, 0.92)), Parent = parent3})
    local ui11 = ui.new("Frame", {Name = "Ghost", Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Accent, BackgroundTransparency = 0.6, (ui.Corner(theme.Radius.Pill)), Parent = parent5})
    local parent6 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(theme.Radius.Pill)), Parent = parent5})
    local v177 = ui.Gradient(theme.Lighten(colors.Accent, 0.15), colors.Accent, 0)
    v177.Parent = parent6
    local parent7 = ui.new("Frame", {Name = "Ticks", ZIndex = 3, Size = UDim2.fromScale(1, 1), Parent = parent5})
    local v179 = 0

    local function buildTicks(a181: number)
        --[[
          name: buildTicks
          line: 624
          upvalues:
            v179 (ref,  index: 1)
            parent7 (copy, index: 2)
            ui (copy, index: 3)
            colors (copy, index: 4)
        ]]
        if a181 == v179 then
            return
        end

        v179 = a181
        parent7:ClearAllChildren()

        for index = 1, a181 - 1 do
            ui.new("Frame", {BackgroundTransparency = 0.35, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(index / a181, 0), Size = UDim2.new(0, 2, 1, 0), BackgroundColor3 = colors.Void, Parent = parent7})
        end
    end

    local parent8 = ui.new("Frame", {Name = "Rows", Position = UDim2.fromOffset(0, 88), Size = UDim2.new(1, 0, 1, -88), Parent = parent2})
    local v184 = {}
    local clampedValue = 48
    local v186 = 6
    local v187 = nil

    local function makeRow(a189)
        --[[
          name: makeRow
          line: 666
          upvalues:
            ui (copy, index: 1)
            clampedValue (ref,  index: 2)
            colors (copy, index: 3)
            parent8 (copy, index: 4)
            fonts (copy, index: 5)
            theme (copy, index: 6)
            v187 (ref,  index: 7)
        ]]
        local v190
        local v191 = a189 == "armor"
        local newUi = ui.new
        local v193 = {}

        if v191 then
            v190 = "Armor"
            v190 = colors
        else
            v190 = "Row" .. a189
            v190 = colors
        end

        v193.Name = v190
        v193.Size = UDim2.new(1, 0, 0, clampedValue)
        v193.BackgroundColor3 = v190.Raised
        v193.BackgroundTransparency = 0.5
        v193[1] = (ui.Corner(12))
        v193.Parent = parent8
        local ui2 = newUi("Frame", v193)
        ui.Stroke(v190.Stroke, 1, 0.93).Parent = ui2
        local ui3 = ui.new("Frame", {Name = "Tile", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(clampedValue - 8, clampedValue - 8), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, (ui.Corner(9)), Parent = ui2})
        local accent = v190.Accent
        local tileGrad = ui.Gradient(accent:Lerp(v190.Panel, 0.7), v190.PanelHi:Lerp(v190.Panel, 0.6), 115)
        tileGrad.Parent = ui3

        local tileStroke = ui.Stroke(v190.Stroke, 1, 0.88)
        tileStroke.Parent = ui3
        local icon = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.92, 0.92), Parent = ui3})
        local ui4 = nil
        local plus = nil
        local shield = nil

        if v191 then
            shield = ui.Image(ui.Assets.Icons.Shield, {Name = "Shield", ImageTransparency = 0.3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.45, 0.45), ImageColor3 = v190.TextMuted, Parent = ui3})
        else
            ui4 = ui.new("TextLabel", {Name = "Num", TextSize = 12, ZIndex = 3, Position = UDim2.fromOffset(4, 2), Size = UDim2.fromOffset(14, 14), Text = tostring(a189), FontFace = fonts.Heavy, TextColor3 = v190.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui3})
            ui.TextStroke(v190.Void, 1, 0.4).Parent = ui4
            plus = ui.Icon("plus", 16, v190.TextMuted, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui3})
        end

        local name = ui.new("TextLabel", {Name = "ItemName", Text = "", TextSize = 17, Position = UDim2.fromOffset(clampedValue + 8, 0), Size = UDim2.new(1, -(clampedValue + 130), 1, 0), FontFace = fonts.Bold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
        local ui5 = ui.new("Frame", {Name = "Cost", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -52, 0.5, 0), Size = UDim2.fromOffset(52, 24), BackgroundColor3 = v190.Void, BackgroundTransparency = 0.45, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local costLabel = ui.new("TextLabel", {Text = "", TextSize = 13, Size = UDim2.fromScale(1, 1), FontFace = fonts.Heavy, TextColor3 = v190.TextDim, Parent = ui5})
        local remove = ui.IconButton({Name = "RemoveButton", IconName = "cross", IconScale = 0.4, Transparency = 0.5, Sound = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromOffset(36, 32), Color = v190.Raised, HoverColor = v190.Danger, Parent = ui2})
        local v207 = {id = nil, frame = ui2, tile = ui3, tileGrad = tileGrad, tileStroke = tileStroke, num = ui4, plus = plus, shield = shield, icon = icon, name = name, costPill = ui5, costLabel = costLabel, remove = remove}

        remove.Activated:Connect(
            function()
                --[[
                  line: 771
                  upvalues:
                    v207 (copy, index: 1)
                    v187 (ref,  index: 2)
                ]]
                if v207.id then
                    v187(v207.id)
                end
            end
        )

        return v207
    end

    v184[1] = makeRow(1)
    v184[2] = makeRow(2)
    v184[3] = makeRow(3)
    v184[4] = makeRow(4)
    v184[5] = makeRow(5)
    v184[6] = makeRow(6)
    local row = makeRow("armor")
    local parent9 = ui.new("Frame", {Name = "Ammo", Size = UDim2.new(1, 0, 0, 0), Parent = parent8})
    local ui12 = ui.new("TextLabel", {Name = "Head", Text = "AMMO  ·  1 POINT PER BUNDLE", TextSize = 13, Size = UDim2.new(1, 0, 0, 18), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent9})
    local v211 = {}
    local v212 = nil

    local function ammoRow(id)
        --[[
          name: ammoRow
          line: 798
          upvalues:
            v211 (copy, index: 1)
            weaponInfo (copy, index: 2)
            v17 (copy, index: 3)
            ui (copy, index: 4)
            clampedValue (ref,  index: 5)
            colors (copy, index: 6)
            parent9 (copy, index: 7)
            weaponIcon (copy, index: 8)
            fonts (copy, index: 9)
            v212 (ref,  index: 10)
        ]]
        local v215

        if const v216 = v211[id] then
            return v216
        end

        local v217 = weaponInfo.AmmoDef(id)
        local color3 = if id == "arrows" then v17.bow else v17.gun
        local ui2 = ui.new("Frame", {Name = id, Size = UDim2.new(1, 0, 0, clampedValue), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.35, (ui.Corner(12)), Parent = parent9})
        ui.Stroke(colors.Stroke, 1, 0.93).Parent = ui2
        local ui3 = ui.new("Frame", {Name = "Tile", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(clampedValue - 8, clampedValue - 8), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(9)), Parent = ui2})
        ui.Gradient(color3:Lerp(colors.Panel, 0.7), colors.PanelHi:Lerp(colors.Panel, 0.6), 115).Parent = ui3
        local ui4 = ui.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.86, 0.86), Parent = ui3})
        weaponIcon.Set(ui4, "ammo_" .. id, {outline = true, glow = false, outlineScale = 1.04, outlineTransparency = 0.5, outlineColor = color3:Lerp(Color3.new(1, 1, 1), 0.55)})

        if not ui4:FindFirstChild("WeaponIcon") or ui4:FindFirstChildOfClass("ImageLabel") then
            for _, child in ui4:GetChildren() do
                child:Destroy()
            end

            local image = ui.Image
            local v225 = if id == "arrows" then ui.Assets.Icons.CrossedArrows else ui.Assets.Icons.Headshot
            image(v225, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), ImageColor3 = color3:Lerp(Color3.new(1, 1, 1), 0.35), Parent = ui4})
        end

        local parent = ui.new("Frame", {Name = "NameRow", Position = UDim2.fromOffset(clampedValue + 8, 4), Size = UDim2.new(1, -(clampedValue + 150), 0.55, -4), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Bottom)), Parent = ui2})
        local newUi = ui.new
        local v228 = {TextSize = 17, LayoutOrder = 1, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X}

        if v217 then
            v215 = v217.name
            v215 = v215 or id
        else
            v215 = id
        end

        v228.Text = v215
        v228.FontFace = fonts.Bold
        v228.Parent = parent
        local name = newUi("TextLabel", v228)
        local amount = ui.new("TextLabel", {Text = "", TextSize = 16, LayoutOrder = 2, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = color3, Parent = parent})
        local sub = ui.new("TextLabel", {Text = "", TextSize = 12, Position = UDim2.new(0, clampedValue + 8, 0.55, 1), Size = UDim2.new(1, -(clampedValue + 150), 0.45, -4), FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})

        local function stepBtn(name: string, iconName: string)
            --[[
              name: stepBtn
              line: 877
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                ui2 (copy, index: 3)
            ]]
            return ui.IconButton({IconScale = 0.42, Transparency = 0.1, Name = name, IconName = iconName, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(38, 34), Color = colors.Raised, Parent = ui2})
        end

        local plus = stepBtn("Plus", "plus")
        local count = ui.new("TextLabel", {Name = "Count", Text = "0", TextSize = 22, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(34, 30), FontFace = fonts.Display, Parent = ui2})
        local minus = stepBtn("Minus", "minus")
        local v238 = {frame = ui2, tile = ui3, icon = ui4, name = name, amount = amount, sub = sub, count = count, minus = minus, plus = plus, t = id}
        v211[id] = v238
        minus.Activated:Connect(
            function()
                --[[
                  line: 902
                  upvalues:
                    v212 (ref,  index: 1)
                    id (copy, index: 2)
                ]]
                v212(id, -1)
            end
        )
        plus.Activated:Connect(
            function()
                --[[
                  line: 905
                  upvalues:
                    v212 (ref,  index: 1)
                    id (copy, index: 2)
                ]]
                v212(id, 1)
            end
        )

        return v238
    end

    local parent10 = ui.new("Frame", {Name = "Right", Position = UDim2.fromOffset(418, 0), Size = UDim2.new(1, -418, 1, 0), Parent = content})
    local parent11 = ui.new("Frame", {Name = "Tabs", Size = UDim2.new(1, 0, 0, 40), ZIndex = 2, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent10})
    local v241 = {}
    local parent12 = ui.new("ScrollingFrame", {Name = "Grid", ScrollBarThickness = 5, ScrollBarImageTransparency = 0.4, Position = UDim2.fromOffset(0, 50), Size = UDim2.new(1, 0, 1, -210), AutomaticCanvasSize = Enum.AutomaticSize.None, ScrollBarImageColor3 = colors.TextMuted, Parent = parent10})

    do
        local function rightW()
            --[[
              name: rightW
              line: 939
              upvalues:
                v43 (copy, index: 1)
            ]]
            return ((v43.Holder.Size.X.Offset - 44) - 400) - 18
        end
    end

    do
        local function screenPerDesign()
            --[[
              name: screenPerDesign
              line: 942
              upvalues:
                parent12 (copy, index: 1)
                v43 (copy, index: 2)
            ]]
            return (math.max(parent12.AbsoluteSize.X / math.max(((v43.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01))
        end
    end

    do
        local function cardH()
            --[[
              name: cardH
              line: 946
              upvalues:
                ui (copy, index: 1)
            ]]
            if ui.Compact then
                return 128
            end

            return 164
        end
    end

    do
        local function detailH()
            --[[
              name: detailH
              line: 949
              upvalues:
                ui (copy, index: 1)
            ]]
            if ui.Compact then
                return 104
            end

            return 156
        end
    end

    local parent13 = ui.new("Frame", {Name = "LockedHeader", Visible = false, Size = UDim2.new(1, -8, 0, 44), Parent = parent12})
    ui.new("Frame", {Name = "Line", BackgroundTransparency = 0.88, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(1, -8, 0, 1), BackgroundColor3 = colors.Text, Parent = parent13})
    ui.new("TextLabel", {Name = "Label", Text = "  LOCKED  ·  find shards in drops  ", TextSize = 13, BackgroundTransparency = 0, ZIndex = 2, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, BackgroundColor3 = colors.Panel, Parent = parent13})

    ui.Button(
        {
            Name = "OpenCollection",
            Text = "COLLECTION",
            TextSize = 14,
            Style = "Dark",
            ZIndex = 2,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -4, 0.5, 0),
            Size = UDim2.fromOffset(150, 34),
            Parent = parent13,
            OnClick = (function()
                --[[
                  name: OnClick
                  line: 991
                  upvalues:
                    v15 (copy, index: 1)
                ]]
                if v15._openCollection then
                    v15._openCollection(nil)
                end
            end)
        }
    )

    local targets = {}
    local v249 = {}
    local v250 = nil

    local function makeCard(a252)
        --[[
          name: makeCard
          line: 1030
          upvalues:
            v17 (copy, index: 1)
            colors (copy, index: 2)
            ui (copy, index: 3)
            parent12 (copy, index: 4)
            fonts (copy, index: 5)
            theme (copy, index: 6)
            v47 (ref,  index: 7)
            v46 (ref,  index: 8)
            a18 (copy, index: 9)
            v15 (copy, index: 10)
            v250 (ref,  index: 11)
        ]]
        local colors2
        local v254 = v17[a252.category] or colors.Accent
        local newUi = ui.new
        local v256 = {Name = a252.id}
        local udim2FromOffset = UDim2.fromOffset

        if ui.Compact then
            colors2 = 128
            colors2 = colors
        else
            colors2 = 164
            colors2 = colors
        end

        v256.Size = udim2FromOffset(160, colors2)
        v256.Parent = parent12
        local ui2 = newUi("TextButton", v256)
        local scale = ui.GetScaleObj(ui2, "HoverScale")
        local ui3 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.08, ClipsDescendants = true, (ui.Corner(14)), Parent = ui2})
        local grad = ui.Gradient(v254:Lerp(colors2.Panel, 0.8), colors2.PanelHi:Lerp(colors2.Panel, 0.6), 115)
        grad.Parent = ui3

        local stroke = ui.Stroke(colors2.Stroke, 1, 0.9)
        stroke.Parent = ui3
        local glow = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.72, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 58), Size = UDim2.fromOffset(170, 150), ImageColor3 = v254, Parent = ui3})
        local icon = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.new(1, -22, 1, -62), Parent = ui3})
        local nameL = ui.new("TextLabel", {Name = "ItemName", TextSize = 17, ZIndex = 3, Position = UDim2.new(0, 12, 1, -48), Size = UDim2.new(1, -24, 0, 22), Text = a252.name, FontFace = fonts.Bold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3})
        local status = ui.new("TextLabel", {Name = "Status", Text = "", TextSize = 12, ZIndex = 3, Position = UDim2.new(0, 12, 1, -26), Size = UDim2.new(1, -24, 0, 16), FontFace = fonts.Heavy, TextColor3 = colors2.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3})
        local ui4 = ui.new("Frame", {Name = "Cost", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Size = UDim2.fromOffset(30, 30), BackgroundColor3 = colors2.Void, BackgroundTransparency = 0.3, ZIndex = 4, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
        local costText = ui.new("TextLabel", {TextSize = 17, ZIndex = 4, Size = UDim2.fromScale(1, 1), Text = tostring(a252.points), FontFace = fonts.Display, Parent = ui4})
        local ui5 = ui.new("Frame", {Name = "Check", Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = colors2.Accent, Visible = false, ZIndex = 4, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
        ui.Icon("check", 18, colors2.Text, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui5})
        local ui6 = ui.new("Frame", {Name = "Lock", Position = UDim2.fromOffset(8, 8), Size = UDim2.fromOffset(28, 28), BackgroundColor3 = colors2.Void, BackgroundTransparency = 0.25, Visible = false, ZIndex = 4, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
        ui.Image(ui.Assets.Icons.Lock, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(15, 15), ImageColor3 = colors2.TextDim, Parent = ui6})
        local ui7 = ui.new("Frame", {Name = "ShardBar", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -8), Size = UDim2.new(1, -24, 0, 4), BackgroundColor3 = colors2.Inset, BackgroundTransparency = 0.1, Visible = false, ZIndex = 5, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
        local cfill = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors2.Accent, ZIndex = 5, (ui.Corner(theme.Radius.Pill)), Parent = ui7})
        local ui8 = ui.new("Frame", {Name = "Level", Position = UDim2.fromOffset(8, 8), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 24), BackgroundColor3 = colors2.Void, BackgroundTransparency = 0.3, Visible = false, ZIndex = 4, ui.Corner(theme.Radius.Pill), ui.Padding(0, 8, 0, 8), (ui.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = ui3})
        local readyDot = ui.Icon("chevUp", 11, colors2.Text, {Name = "Ready", LayoutOrder = 0, ZIndex = 4, Parent = ui8})
        readyDot.Visible = false
        local lvText = ui.new("TextLabel", {Name = "Text", Text = "LV 1", RichText = true, TextSize = 14, LayoutOrder = 1, ZIndex = 4, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Display, Parent = ui8})
        local flash = ui.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 6, (ui.Corner(14)), Parent = ui3})
        local v277 = {rendered = false, visible = true, hover = false, y = 0, id = a252.id, holder = ui2, scale = scale, inner = ui3, grad = grad, stroke = stroke, glow = glow, icon = icon, costBadge = ui4, costText = costText, check = ui5, lock = ui6, lv = ui8, lvText = lvText, readyDot = readyDot, cbar = ui7, cfill = cfill, nameL = nameL, status = status, flash = flash}

        ui2.MouseEnter:Connect(
            function()
                --[[
                  line: 1209
                  upvalues:
                    ui (copy, index: 1)
                    v277 (copy, index: 2)
                    v47 (ref,  index: 3)
                    a252 (copy, index: 4)
                    v46 (ref,  index: 5)
                    a18 (copy, index: 6)
                    scale (copy, index: 7)
                    theme (copy, index: 8)
                    v15 (copy, index: 9)
                ]]
                if ui.Touch then
                    return
                end

                v277.hover = true
                v47 = a252.id
                v46 = a252.id
                a18.Sounds.Play("Hover")
                ui.Tween(scale, theme.Tween.PopSmall, {Scale = 1.035})
                v15._paintCard(v277)
                v15._paintDetail()
                v15._paintPoints()
            end
        )

        ui2.MouseLeave:Connect(
            function()
                --[[
                  line: 1222
                  upvalues:
                    v277 (copy, index: 1)
                    v47 (ref,  index: 2)
                    a252 (copy, index: 3)
                    ui (copy, index: 4)
                    scale (copy, index: 5)
                    theme (copy, index: 6)
                    v15 (copy, index: 7)
                ]]
                v277.hover = false

                if v47 == a252.id then
                    v47 = nil
                end

                ui.Tween(scale, theme.Tween.Fast, {Scale = 1})
                v15._paintCard(v277)
                v15._paintPoints()
            end
        )

        ui2.MouseButton1Down:Connect(
            function()
                --[[
                  line: 1231
                  upvalues:
                    ui (copy, index: 1)
                    scale (copy, index: 2)
                    theme (copy, index: 3)
                ]]
                ui.Tween(scale, theme.Tween.Instant, {Scale = 0.97})
            end
        )

        ui2.MouseButton1Up:Connect(
            function()
                --[[
                  line: 1234
                  upvalues:
                    ui (copy, index: 1)
                    scale (copy, index: 2)
                    theme (copy, index: 3)
                    v277 (copy, index: 4)
                ]]
                local scale2
                local tween = ui.Tween
                local popSmall = theme.Tween.PopSmall
                local v281 = {}

                if v277.hover then
                    scale2 = 1.035
                else
                    scale2 = 1
                end

                v281.Scale = scale2
                tween(scale, popSmall, v281)
            end
        )

        ui2.SelectionGained:Connect(
            function()
                --[[
                  line: 1238
                  upvalues:
                    v277 (copy, index: 1)
                    v47 (ref,  index: 2)
                    a252 (copy, index: 3)
                    v46 (ref,  index: 4)
                    v15 (copy, index: 5)
                ]]
                v277.hover = true
                v47 = a252.id
                v46 = a252.id
                v15._paintCard(v277)
                v15._paintDetail()
                v15._paintPoints()
            end
        )

        ui2.SelectionLost:Connect(
            function()
                --[[
                  line: 1246
                  upvalues:
                    v277 (copy, index: 1)
                    v47 (ref,  index: 2)
                    a252 (copy, index: 3)
                    v15 (copy, index: 4)
                ]]
                v277.hover = false

                if v47 == a252.id then
                    v47 = nil
                end

                v15._paintCard(v277)
                v15._paintPoints()
            end
        )

        ui2.Activated:Connect(
            function()
                --[[
                  line: 1254
                  upvalues:
                    v46 (ref,  index: 1)
                    a252 (copy, index: 2)
                    v250 (ref,  index: 3)
                    v277 (copy, index: 4)
                ]]
                v46 = a252.id
                v250(a252.id, v277)
            end
        )

        return v277
    end

    local parent14 = ui.Panel({Name = "Detail", BackgroundTransparency = 0.2, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 156), Radius = UDim.new(0, 14), Parent = parent10})
    local parent15 = ui.new("Frame", {Name = "Preview", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(140, 140), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, (ui.Corner(12)), Parent = parent14})
    local accent = colors.Accent
    local v285 = ui.Gradient(accent:Lerp(colors.Panel, 0.75), colors.PanelHi:Lerp(colors.Panel, 0.6), 115)
    v285.Parent = parent15
    local v286 = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.3, 1.3), ImageColor3 = colors.Accent, Parent = parent15})
    local ui13 = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.92, 0.92), Parent = parent15})
    local parent16 = ui.new("Frame", {Name = "Text", Position = UDim2.fromOffset(160, 12), Size = UDim2.new(1, -600, 1, -24), Parent = parent14})
    local ui14 = ui.new("TextLabel", {Name = "ItemName", Text = "", TextSize = 24, Size = UDim2.new(1, 0, 0, 28), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent16})
    a18.Loc.Fit(ui14, 17)
    local ui15 = ui.new("TextLabel", {Name = "Sub", AutoLocalize = false, Text = "", TextSize = 12, Position = UDim2.fromOffset(0, 30), Size = UDim2.new(1, 0, 0, 16), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent16})
    local ui16 = ui.new("TextLabel", {Name = "Desc", Text = "", TextSize = 14, TextWrapped = true, Position = UDim2.fromOffset(0, 54), Size = UDim2.new(1, 0, 1, -54), FontFace = fonts.Medium, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent16})
    local v292 = ui.List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    local parent17 = ui.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -168, 0.5, 0), Size = UDim2.fromOffset(262, 98), v292, Parent = parent14})
    local v294 = {}

    for layoutOrder = 1, 4 do
        do
            local ui17 = ui.new("Frame", {Name = "Stat" .. layoutOrder, Size = UDim2.new(1, 0, 0, 20), LayoutOrder = layoutOrder, Parent = parent17})
            v294[layoutOrder] = {
                frame = ui17,
                label = ui.new("TextLabel", {Text = "", TextSize = 12, Size = UDim2.fromOffset(70, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui17}),
                bar = ui.Bar({Stroke = false, Position = UDim2.fromOffset(72, 7), Size = UDim2.fromOffset(92, 7), Color = colors.Accent, Parent = ui17}),
                value = ui.new("TextLabel", {Text = "", TextSize = 12, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(92, 20), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui17})
            }
        end
    end

    local v297 = ui.Button({Name = "Action", Text = "ADD", TextSize = 20, Style = "Primary", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(144, 56), Parent = parent14})

    local function layoutWindow()
        --[[
          name: layoutWindow
          line: 1382
          upvalues:
            ui (copy, index: 1)
            v43 (copy, index: 2)
            layoutSlots (copy, index: 3)
            ui2 (ref,  index: 4)
            parent3 (copy, index: 5)
            ui6 (copy, index: 6)
            parent10 (copy, index: 7)
            parent2 (copy, index: 8)
            ui7 (copy, index: 9)
            parent4 (copy, index: 10)
            ui8 (copy, index: 11)
            ui9 (copy, index: 12)
            parent5 (copy, index: 13)
            ui10 (copy, index: 14)
            parent8 (copy, index: 15)
            count2 (ref,  index: 16)
            fonts (copy, index: 17)
            textService (copy, index: 18)
            parent14 (copy, index: 19)
            parent15 (copy, index: 20)
            parent16 (copy, index: 21)
            ui16 (copy, index: 22)
            v292 (copy, index: 23)
            parent17 (copy, index: 24)
            v294 (copy, index: 25)
            parent12 (copy, index: 26)
        ]]
        local v299
        local v300 = ui.CanvasSize()

        if ui.Compact then
            local flooredValue = math.floor((math.clamp(v300.X - 24, 340, 1280)))
            local flooredValue2 = math.floor((math.clamp((v300.Y - ui.TopInset()) - 12, 300, 720)))
            v43.Holder.Size = UDim2.fromOffset(flooredValue, flooredValue2)
        else
            local v303 = ui.TopInset()
            local flooredValue = math.floor((math.clamp(v300.X - 96, 1280, 1500)))
            local flooredValue3 = math.floor((math.clamp((v300.Y - v303) - 22, 720, 980)))
            v43.Holder.Size = UDim2.fromOffset(flooredValue, flooredValue3)
        end

        layoutSlots()
        local compact = ui.Compact
        ui2.Visible = not compact
        local udim2FromOffset = UDim2.fromOffset

        if compact then
            v299 = 0
        else
            v299 = 22
        end

        parent3.Position = udim2FromOffset(0, v299)

        if compact then
            ui6.Parent = parent10
            ui6.Position = UDim2.new(1, -4, 0, 11)
        else
            ui6.Parent = parent2
            ui6.Position = UDim2.new(1, 0, 0, 0)
        end

        ui7.TextSize = compact and 28 or 34
        local v308 = UDim2.fromOffset
        local v309 = ui7.Size.X.Offset
        local v310 = compact and 30 or 36
        ui7.Size = v308(v309, v310)
        v308 = UDim2.new
        local v311 = compact and 30 or 36
        parent4.Size = v308(1, -110, 0, v311)
        ui8.TextSize = compact and 14 or 15
        local v312 = UDim2.new
        local v313 = compact and 8 or 12
        ui9.Position = v312(1, 0, 0, v313)
        v312 = UDim2.fromOffset
        local v314 = compact and 36 or 44
        parent5.Position = v312(0, v314)
        v312 = UDim2.fromOffset
        local v315 = compact and 50 or 60
        ui10.Position = v312(0, v315)
        ui10.TextSize = compact and 13 or 14
        local v316 = compact and 70 or 108
        parent8.Position = UDim2.fromOffset(0, v316)
        parent8.Size = UDim2.new(1, 0, 1, -v316)
        count2 += 1
        local v317 = count2
        local text = ui7.Text
        local textSize = ui7.TextSize

        task.spawn(
            function()
                --[[
                  line: 559
                  upvalues:
                    text (copy, index: 1)
                    fonts (copy, index: 2)
                    textSize (copy, index: 3)
                    textService (copy, index: 4)
                    v317 (copy, index: 5)
                    count2 (ref,  index: 6)
                    ui7 (copy, index: 7)
                ]]
                local params = Instance.new("GetTextBoundsParams")
                params.Text = text
                params.Font = fonts.Display
                params.Size = textSize
                params.Width = 1000
                local success, textBoundsAsync = pcall(
                    function()
                        --[[
                          line: 565
                          upvalues:
                            textService (copy, index: 1)
                            params (copy, index: 2)
                        ]]
                        return textService:GetTextBoundsAsync(params)
                    end
                )

                if success and v317 == count2 and 4 < textBoundsAsync.X then
                    ui7.Size = UDim2.fromOffset(math.ceil(textBoundsAsync.X) + 2, ui7.Size.Y.Offset)
                end
            end
        )

        local v323 = ui.Compact and 104 or 156
        parent14.Size = UDim2.new(1, 0, 0, v323)
        parent15.Size = UDim2.fromOffset(v323 - 16, v323 - 16)
        v309 = UDim2.fromOffset
        local v324 = v323 + 4
        local v325 = compact and 8 or 12
        parent16.Position = v309(v324, v325)
        v309 = UDim2.new
        local v326 = -((((v323 + 4) + 262) + 168) + 12)
        local v327 = compact and -16 or -24
        parent16.Size = v309(1, v326, 1, v327)
        ui16.TextSize = compact and 13 or 14
        local v328 = compact and 18 or 20
        local v329 = compact and 3 or 6
        v292.Padding = UDim.new(0, v329)
        parent17.Size = UDim2.fromOffset(262, #v294 * v328 + ((#v294 - 1) * v329))

        for _, v331 in v294 do
            v331.frame.Size = UDim2.new(1, 0, 0, v328)
            v331.label.Size = UDim2.fromOffset(70, v328)
            v331.value.Size = UDim2.fromOffset(92, v328)
            v331.bar.Frame.Position = UDim2.fromOffset(72, (math.floor((v328 - 7) / 2)))
        end

        parent12.Size = UDim2.new(1, 0, 1, -((v323 + 50) + 12))
    end

    local function layoutRows()
        --[[
          name: layoutRows
          line: 1442
          upvalues:
            parent8 (copy, index: 1)
            weaponInfo (copy, index: 2)
            v45 (ref,  index: 3)
            ui (copy, index: 4)
            v186 (ref,  index: 5)
            clampedValue (ref,  index: 6)
            v184 (copy, index: 7)
            row (ref,  index: 8)
            parent9 (copy, index: 9)
            ui12 (copy, index: 10)
            v211 (copy, index: 11)
            ammoRow (copy, index: 12)
        ]]
        local v333
        local v334
        local _, v336
        local v337 = parent8.AbsoluteSize.Y / math.max(parent8.AbsoluteSize.X / 400, 0.01)
        local v338 = weaponInfo.AmmoNeeded(v45)
        local count = 0

        for _, v341 in weaponInfo.AmmoTypes() do
            if v338[v341.id] or 0 < (v45.ammo[v341.id] or 0) then
                count += 1
            end
        end

        local v342 = count + 7
        local v343 = 0 < count and not ui.Compact and 22 or 0
        v186 = not (v337 < 400) and 6 or 4
        clampedValue = math.clamp(math.floor((v337 - v343 - ((v342 - 1) * v186)) / v342), 30, 66)

        if ui.Touch then
            v333 = clampedValue + 10
        else
            v333 = 36
        end

        local v344 = if ui.Touch then clampedValue - 2 else math.min(32, clampedValue - 8)
        local v345 = clampedValue - 8

        local function fitRow(a347, a348)
            --[[
              name: fitRow
              line: 1459
              upvalues:
                clampedValue (ref,  index: 1)
                v345 (copy, index: 2)
                v333 (copy, index: 3)
                v344 (copy, index: 4)
                ui (copy, index: 5)
            ]]
            a347.frame.Position = UDim2.fromOffset(0, a348)
            a347.frame.Size = UDim2.new(1, 0, 0, clampedValue)
            a347.tile.Size = UDim2.fromOffset(v345, v345)
            a347.name.Position = UDim2.fromOffset(v345 + 16, 0)
            a347.remove.Size = UDim2.fromOffset(v333, v344)
            local remove = a347.remove
            local newUDim2 = UDim2.new
            local v351 = ui.Touch and -1 or -6
            remove.Position = newUDim2(1, v351, 0.5, 0)
            local costPill = a347.costPill
            newUDim2 = UDim2.new
            local v353 = ui.Touch and 8 or 12
            costPill.Position = newUDim2(1, -(v333 + v353), 0.5, 0)
            a347.name.Size = UDim2.new(1, -((((v345 + 16) + v333) + 12) + 60), 1, 0)
            a347.name.TextSize = not (clampedValue < 40) and 17 or 15

            if a347.num then
                a347.num.Visible = 34 <= v345
            end
        end

        local v354 = 0
        v334 = v354

        for _, v356 in v184 do
            fitRow(v356, v334)
            v334 += clampedValue + v186
        end

        fitRow(row, v334)
        v334 += clampedValue + v186
        parent9.Position = UDim2.fromOffset(0, v334)
        local visible = 0 < count
        parent9.Visible = visible
        ui12.Visible = 0 < count and not ui.Compact
        v336 = v343

        for _, v359 in weaponInfo.AmmoTypes() do
            local visible2 = v338[v359.id] or 0 < (v45.ammo[v359.id] or 0)

            if const v361 = if not visible2 and not v211[v359.id] then nil else ammoRow(v359.id) then
                v361.frame.Visible = visible2

                if not visible2 then
                    continue
                end

                v361.frame.Position = UDim2.fromOffset(0, v336)
                v361.frame.Size = UDim2.new(1, 0, 0, clampedValue)
                v361.tile.Size = UDim2.fromOffset(v345, v345)
                local v362 = not ui.Touch and 38 or math.max(38, clampedValue - 2)
                v361.plus.Size = UDim2.fromOffset(v362, (math.min(34, clampedValue - 6)))
                v361.plus.Position = UDim2.new(1, -5, 0.5, 0)
                v361.count.Position = UDim2.new(1, -(v362 + 7), 0.5, 0)
                v361.minus.Size = v361.plus.Size
                v361.minus.Position = UDim2.new(1, -(v362 + 45), 0.5, 0)
                v336 += clampedValue + v186
            end
        end

        parent9.Size = UDim2.new(1, 0, 0, v336)
    end

    local function layoutGrid(a364: boolean?)
        --[[
          name: layoutGrid
          line: 1507
          upvalues:
            v43 (copy, index: 1)
            ui (copy, index: 2)
            weaponInfo (copy, index: 3)
            v48 (ref,  index: 4)
            targets (copy, index: 5)
            economy (copy, index: 6)
            parent13 (copy, index: 7)
            parent12 (copy, index: 8)
        ]]
        local place
        local filter
        local v367 = (v43.Holder.Size.X.Offset - 44) - 400 - 18
        local v368 = ui.Compact and 128 or 164
        local clampedValue = math.clamp(math.floor(((v367 - 8) + 12) / 170), 2, 5)
        local flooredValue = math.floor((v367 - 8 - ((clampedValue - 1) * 12)) / clampedValue)
        filter = nil

        for _, filter2 in weaponInfo.FILTERS do
            if filter2.id == v48 then
                filter = filter2
            end
        end

        local v373 = {}
        local v374 = {}

        for _, v376 in targets do
            local v377 = weaponInfo.Get(v376.id)
            local visible = v377 ~= nil
                and (filter == nil or filter.cats == nil or filter.cats[v377.category] == true)
            v376.holder.Visible = visible
            v376.visible = visible

            if visible then
                local v379 = if economy.IsLocked(v376.id) then v374 else v373
                table.insert(v379, v376)
            end
        end

        local v380 = 0

        place = function(a381)
            --[[
              name: place
              line: 1529
              upvalues:
                clampedValue (copy, index: 1)
                v380 (ref,  index: 2)
                v368 (copy, index: 3)
                flooredValue (copy, index: 4)
            ]]
            for v382, v383 in a381 do
                local v384 = (v382 - 1) % clampedValue
                v383.y = v380 + ((v382 - 1) // clampedValue * (v368 + 12))
                v383.holder.Position = UDim2.fromOffset((v384 * (flooredValue + 12)) + 4, v383.y + 4)
                v383.holder.Size = UDim2.fromOffset(flooredValue, v368)
                v383.glow.Size = UDim2.fromOffset(flooredValue * 1.05, v368 * 0.95)
                v383.glow.Position = UDim2.new(0.5, 0, 0, ((v368 - 60) / 2) + 6)
            end

            v380 += (math.ceil(#a381 / clampedValue) * (v368 + 12))
        end

        place(v373)
        local visible = 0 < #v374
        parent13.Visible = visible

        if 0 < #v374 then
            local udim2FromOffset = UDim2.fromOffset
            local v387 = not (0 < #v373) and 0 or 6
            parent13.Position = udim2FromOffset(4, v380 + v387)
            local v388 = not (0 < #v373) and 8 or 14
            local v389 = v388 + 44
            v380 += v389
            place(v374)
        end

        parent12.CanvasSize = UDim2.fromOffset(0, v380 + 8)

        if not a364 then
            parent12.CanvasPosition = Vector2.zero
        end
    end

    local function staggerCards()
        --[[
          name: staggerCards
          line: 1554
          upvalues:
            targets (copy, index: 1)
            ui (copy, index: 2)
        ]]
        local count = 0

        for _, v393 in targets do
            if v393.visible then
                local v394 = math.min(count * 0.018, 0.22)
                v393.inner.Position = UDim2.fromOffset(0, 14)
                v393.scale.Scale = 0.94
                ui.Tween(v393.inner, TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, v394), {Position = UDim2.new()})
                local v395 = {Scale = 1}
                ui.Tween(v393.scale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v394), v395)
                count += 1
            end
        end
    end

    local v396 = {}

    local function queueVisible()
        --[[
          name: queueVisible
          line: 1570
          upvalues:
            parent12 (copy, index: 1)
            v43 (copy, index: 2)
            ui (copy, index: 3)
            targets (copy, index: 4)
            v396 (copy, index: 5)
            weaponIcon (copy, index: 6)
        ]]
        local v398
        local v399 = math.max(parent12.AbsoluteSize.X / math.max(((v43.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01)

        if ui.Compact then
            v398 = 128
        else
            v398 = 164
        end

        local v400 = parent12.CanvasPosition.Y / v399
        local v401 = v400 + parent12.AbsoluteWindowSize.Y / v399

        for _, target in targets do
            local v404, v405 = false, false

            if target.visible then
                if target.rendered then
                    v404 = true
                else
                    local v406 = target.y + v398

                    if not (v400 - v398 <= v406) then
                        v404 = true
                    elseif not (target.y <= v401 + v398) then
                        v404 = true
                    else
                        target.rendered = true
                        table.insert(v396, target)
                    end
                end
            else
                v404 = true
            end

            if v404 and target.rendered then
                if target.visible then
                    if target.y + v398 < v400 - (v398 * 2) then
                        v405 = true
                    else
                        local y = target.y

                        if v401 + (v398 * 2) < y then
                            v405 = true
                        end
                    end
                else
                    v405 = true
                end
            end

            if v405 then
                target.rendered = false

                if const index = table.find(v396, target) then
                    table.remove(v396, index)
                end

                weaponIcon.Set(target.icon, nil)
            end
        end
    end

    runService.Heartbeat:Connect(
        function()
            --[[
              line: 1590
              upvalues:
                v396 (copy, index: 1)
                v43 (copy, index: 2)
                ui (copy, index: 3)
                weaponIcon (copy, index: 4)
                weaponInfo (copy, index: 5)
                v17 (copy, index: 6)
                colors (copy, index: 7)
                v15 (copy, index: 8)
            ]]
            if #v396 == 0 or not v43.IsOpen then
                return
            end

            local v409 = ui.Touch and 2 or 4

            for _ = 1, v409 do
                local removedValue = table.remove(v396, 1)
                if not removedValue then
                    break
                end

                local set = weaponIcon.Set
                local icon = removedValue.icon
                local id = removedValue.id
                local id2 = removedValue.id
                local v416 = {outline = false, glow = false, outlineScale = 1.035, outlineTransparency = 0.5}
                local v417 = weaponInfo.Get(id2)
                local v418 = v417 and v17[v417.category] or colors.Accent
                v416.outlineColor = v418:Lerp(Color3.new(1, 1, 1), 0.55)
                set(icon, id, v416)
                v15._paintCard(removedValue)
            end
        end
    )

    parent12:GetPropertyChangedSignal("CanvasPosition"):Connect(queueVisible)

    do
        local v419 = -1
        local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        function v15._paintPoints()
            --[[
              name: _paintPoints
              line: 1608
              upvalues:
                weaponInfo (copy, index: 1)
                v45 (ref,  index: 2)
                buildTicks (copy, index: 3)
                ui7 (copy, index: 4)
                v419 (ref,  index: 5)
                ui (copy, index: 6)
                parent6 (copy, index: 7)
                tweenInfo (copy, index: 8)
                colors (copy, index: 9)
                v177 (copy, index: 10)
                theme (copy, index: 11)
                ui9 (copy, index: 12)
                ui10 (copy, index: 13)
                v47 (ref,  index: 14)
                canAdd (copy, index: 15)
                ammoExtra (copy, index: 16)
                ui11 (copy, index: 17)
            ]]
            local v421
            local text
            local v423
            local v424
            local v425 = weaponInfo.Cost(v45)
            local v426 = math.max(weaponInfo.Budget(), 1)
            buildTicks(v426)
            ui7.Text = string.format("%d / %d", v425, v426)

            if v425 ~= v419 then
                if 0 <= v419 then
                    ui.Bump(ui7, 0.08)
                end

                v419 = v425
            end

            local v427 = v426 <= v425
            ui.Tween(parent6, tweenInfo, {Size = UDim2.fromScale(math.clamp(v425 / v426, 0, 1), 1)})

            if v427 then
                v421 = colors.Success
            else
                v421 = colors.Accent
            end

            v177.Color = ColorSequence.new(theme.Lighten(v421, 0.18), v421)
            local v428 = v426 - v425
            ui9.Text = ""

            if v427 then
                text = string.format("All %d points used", v426)
            else
                text = if v425 == 0 then string.format("0 of %d points used  ·  pick items on the right", v426) else string.format("%d of %d points used  ·  %d left", v425, v426, v428)
            end

            ui10.Text = text
            ui10.TextColor3 = if v427 then colors.Success else colors.TextDim
            local v429 = v425
            local v430 = false

            if const v431 = v47 then
                local v432 = table.find(v45.items, v431) ~= nil or v45.armor == v431

                if v432 then
                    v423 = v429
                else
                    local canAdd2, v434, v435 = canAdd(v431)

                    if canAdd2 then
                        local v436 = v425 + weaponInfo.Points(v431) + ammoExtra(v431)
                        local v437 = if weaponInfo.IsArmor(v431) and v45.armor then weaponInfo.Points(v45.armor) else 0
                        v423 = v436 - v437
                    elseif v434 == "points" or v434 == "ammo" then
                        local text2
                        v430 = true
                        local _, v440 = ammoExtra(v431)

                        if v434 == "ammo" and v440 then
                            local stringFormat = string.format
                            local v442 = weaponInfo.Name(v431)
                            local lowercaseText = string.lower(v440.name)
                            local v444 = v435 ~= 1 and "s" or ""
                            text2 = stringFormat("%s needs %s too: %d more point%s, remove something first", v442, lowercaseText, v435, v444)
                        else
                            local stringFormat = string.format
                            local v446 = weaponInfo.Name(v431)
                            local v447 = v435 ~= 1 and "s" or ""
                            text2 = stringFormat("%s needs %d more point%s: remove something first", v446, v435, v447)
                        end

                        ui10.Text = text2
                        ui10.TextColor3 = colors.Danger
                        v423 = v426
                    else
                        v423 = v429
                    end
                end
            else
                v423 = v429
            end

            ui.Tween(ui11, theme.Tween.Fast, {Size = UDim2.fromScale(math.clamp(v423 / v426, 0, 1), 1)})

            if v430 then
                v424 = colors.Danger
            else
                v424 = colors.Accent
            end

            ui11.BackgroundColor3 = v424
            ui11.BackgroundTransparency = v430 and 0.35 or 0.6
        end
    end

    local function paintRow(a449, id)
        --[[
          name: paintRow
          line: 1651
          upvalues:
            weaponInfo (copy, index: 1)
            v17 (copy, index: 2)
            colors (copy, index: 3)
            weaponIcon (copy, index: 4)
            row (ref,  index: 5)
            v184 (copy, index: 6)
            v45 (ref,  index: 7)
        ]]
        local v451
        a449.id = id
        local v452 = weaponInfo.Get(id)
        a449.remove.Visible = v452 ~= nil
        a449.costPill.Visible = v452 ~= nil
        a449.frame.BackgroundTransparency = v452 and 0.3 or 0.72

        if v452 then
            v451 = v17[v452.category] or colors.Accent
        else
            v451 = colors.Raised
        end

        a449.tileGrad.Color = if v452 then ColorSequence.new(v451:Lerp(colors.Panel, 0.62), colors.PanelHi:Lerp(colors.Panel, 0.6)) else ColorSequence.new(colors.Panel, colors.Panel)
        a449.tile.BackgroundTransparency = v452 and 0 or 0.6
        a449.tileStroke.Transparency = v452 and 0.88 or 0.75

        if a449.plus then
            a449.plus.Visible = v452 == nil
        end

        if a449.shield then
            a449.shield.Visible = v452 == nil
        end

        if v452 then
            a449.name.Text = v452.name
            a449.name.TextColor3 = colors.Text
            local costLabel = a449.costLabel
            local points = v452.points
            local v455 = v452.points ~= 1 and " PTS" or " PT"
            costLabel.Text = points .. v455
            local set = weaponIcon.Set
            local icon = a449.icon
            local v458 = {outline = false, glow = false, outlineScale = 1.035, outlineTransparency = 0.5}
            local v459 = weaponInfo.Get(id)
            local v460 = v459 and v17[v459.category] or colors.Accent
            v458.outlineColor = v460:Lerp(Color3.new(1, 1, 1), 0.55)
            set(icon, id, v458)
        else
            local v461 = a449 ~= row and v184[#v45.items + 1] == a449
            local name = a449.name
            local text = a449 ~= row and (v461 and "Pick an item on the right" or "Empty") or "Armor (optional)"
            name.Text = text
            a449.name.TextColor3 = if v461 then colors.TextDim else colors.TextMuted
            weaponIcon.Set(a449.icon, nil)
        end

        if a449.num then
            a449.num.TextColor3 = if v452 then colors.TextDim else colors.TextMuted
            a449.num.TextTransparency = v452 and 0.1 or 0.3
        end
    end

    local function paintAmmo()
        --[[
          name: paintAmmo
          line: 1688
          upvalues:
            weaponInfo (copy, index: 1)
            v45 (ref,  index: 2)
            v211 (copy, index: 3)
            colors (copy, index: 4)
            v17 (copy, index: 5)
            ammoFloor (copy, index: 6)
        ]]
        local v465 = weaponInfo.AmmoNeeded(v45)

        for _, v467 in weaponInfo.AmmoTypes() do
            if const v468 = v211[v467.id] then
                if not v468.frame.Visible then
                    continue
                end

                local v469 = v45.ammo[v467.id] or 0
                v468.count.Text = tostring(v469)
                v468.amount.Text = "×" .. v469 * v467.perBundle

                if v469 == 0 and v465[v467.id] and not v467.optional then
                    v468.sub.Text = "No " .. string.lower(v467.name) .. ": you can't shoot!"
                    v468.sub.TextColor3 = colors.Danger
                    v468.amount.TextColor3 = colors.Danger
                else
                    v468.sub.Text = string.format("%d %s per bundle", v467.perBundle, string.lower(v467.name))
                    v468.sub.TextColor3 = colors.TextMuted
                    v468.amount.TextColor3 = if v467.id ~= "arrows" and v467.as ~= "arrows" then v17.gun else v17.bow
                end

                local v470 = v469 < weaponInfo.MaxAmmoBundles()
                    and weaponInfo.Cost(v45) + v467.points <= weaponInfo.Budget()
                v468.plus.BackgroundTransparency = v470 and 0.1 or 0.6
                v468.minus.BackgroundTransparency = 0 < v469 and not ammoFloor(v467.id) and 0.1 or 0.6
            end
        end
    end

    function v15._paintCard(a471)
        --[[
          name: _paintCard
          line: 1712
          upvalues:
            canAdd (copy, index: 1)
            v45 (ref,  index: 2)
            weaponInfo (copy, index: 3)
            v17 (copy, index: 4)
            colors (copy, index: 5)
            economy (copy, index: 6)
            a18 (copy, index: 7)
            weaponIcon (copy, index: 8)
            ammoExtra (copy, index: 9)
        ]]
        local v472
        local color
        local v474
        local canAdd2, v476, v477 = canAdd(a471.id)
        local id = a471.id
        local v479 = table.find(v45.items, id) ~= nil or v45.armor == id
        local v480 = weaponInfo.Get(a471.id)
        local v481 = v480 and v17[v480.category] or colors.Accent
        local visible = v476 == "locked"
        local v483 = not v479 and not canAdd2
        local v484, v485 = economy.Progress(a471.id)
        local v486 = economy.Level(a471.id)
        a471.check.Visible = false
        a471.lock.Visible = visible
        a471.costBadge.Visible = not visible
        a471.lv.Visible = not visible and (1 <= v486)
        local visible2 = not visible and economy.CanUpgrade(a471.id)
        a471.readyDot.Visible = visible2

        if economy.MAX_LEVEL <= v486 then
            a471.lvText.Text = "MAX"
            a471.lvText.TextColor3 = colors.TextDark
            a471.lv.BackgroundColor3 = colors.Gold
            a471.lv.BackgroundTransparency = 0
        else
            a18.Loc.Rich(a471.lvText, string.format("<font size=\"11\">LV</font> %d", v486))
            a471.lvText.TextColor3 = colors.Text
            a471.lv.BackgroundColor3 = if visible2 then colors.SuccessDark else colors.Void
            a471.lv.BackgroundTransparency = visible2 and 0 or 0.3
        end

        a471.cbar.Visible = visible
        a471.cfill.Visible = 0 < v484
        a471.cfill.Size = UDim2.fromScale(math.clamp(v484 / math.max(v485, 1), 0, 1), 1)
        a471.cfill.BackgroundColor3 = colors.Accent
        local stroke = a471.stroke

        if v479 then
            v472 = colors.Accent
        elseif a471.hover then
            v472 = if visible then colors.Stroke else v481
        else
            v472 = colors.Stroke
        end

        stroke.Color = v472
        a471.stroke.Thickness = v479 and 2 or 1
        a471.stroke.Transparency = v479 and 0 or a471.hover and (visible and 0.7 or 0.4) or 0.9
        local grad = a471.grad

        if visible then
            color = ColorSequence.new(colors.Panel, colors.Panel)
        else
            local newColorSequence = ColorSequence.new
            local panel = colors.Panel
            local alpha = a471.hover and 0.8 or 0.9
            color = newColorSequence(v481:Lerp(panel, alpha), colors.PanelHi:Lerp(colors.Panel, 0.6))
        end

        grad.Color = color
        a471.inner.BackgroundTransparency = visible and 0.35 or 0.08
        a471.glow.ImageTransparency = visible and 1 or v483 and 1 or a471.hover and 0.7 or v479 and 0.7 or 0.85
        a471.costBadge.BackgroundColor3 = colors.Void
        a471.costBadge.BackgroundTransparency = 0.3

        if a471.rendered then
            weaponIcon.SetDim(a471.icon, v483)
        end

        local nameL = a471.nameL

        if visible then
            v474 = colors.TextMuted
        else
            v474 = if v483 then colors.TextDim else colors.Text
        end

        nameL.TextColor3 = v474

        if v479 then
            a471.status.Text = "✓ IN LOADOUT"
            a471.status.TextColor3 = colors.Accent

            return
        end

        if visible then
            a471.status.Text = string.format("%d / %d SHARDS", v484, v485)
            a471.status.TextColor3 = if 0 < v484 then colors.TextDim else colors.TextMuted

            return
        end

        if v476 == "points" then
            local status = a471.status
            local stringFormat = string.format
            local v496 = v477 ~= 1 and "S" or ""
            status.Text = stringFormat("NEEDS %d MORE PT%s", v477, v496)
            a471.status.TextColor3 = if a471.hover then colors.Danger else colors.TextMuted

            return
        end

        if v476 ~= "ammo" then
            if v476 == "full" then
                a471.status.Text = "6 ITEMS MAX"
                a471.status.TextColor3 = colors.TextMuted

                return
            end

            a471.status.Text = ""

            return
        end

        local _, v498 = ammoExtra(a471.id)
        local status = a471.status
        local stringFormat = string.format
        local v501 = v477 ~= 1 and "S" or ""
        local stringUpper = string.upper
        local name = v498 and v498.name or "AMMO"
        status.Text = stringFormat("NEEDS %d PT%s FOR %s", v477, v501, stringUpper(name))
        a471.status.TextColor3 = if a471.hover then colors.Danger else colors.TextMuted
    end

    local function statValue(a505, a506)
        --[[
          name: statValue
          line: 1780
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        if a506.value then
            return a506.value
        end

        local label = a506.label

        if type(a505.details) == "table" then
            for _, detail in a505.details do
                if type(detail) == "table" and type(detail[1]) == "string" and string.upper(detail[1]) == label then
                    return (tostring(detail[2]))
                end
            end
        end

        if a505.category == "armor" and label == "ARMOR" then
            return "+" .. weaponInfo.ArmorStats(a505)
        end

        return string.format("%d / 10", (math.floor((a506.frac * 10) + 0.5)))
    end

    local id = nil

    function v15._paintDetail()
        --[[
          name: _paintDetail
          line: 1799
          upvalues:
            weaponInfo (copy, index: 1)
            v46 (ref,  index: 2)
            parent14 (copy, index: 3)
            v17 (copy, index: 4)
            colors (copy, index: 5)
            id (ref,  index: 6)
            weaponIcon (copy, index: 7)
            ui13 (copy, index: 8)
            iconOpts (copy, index: 9)
            v285 (copy, index: 10)
            v286 (copy, index: 11)
            ui (copy, index: 12)
            theme (copy, index: 13)
            ui14 (copy, index: 14)
            economy (copy, index: 15)
            a18 (copy, index: 16)
            ui15 (copy, index: 17)
            ui16 (copy, index: 18)
            v294 (copy, index: 19)
            statValue (copy, index: 20)
            canAdd (copy, index: 21)
            parent17 (copy, index: 22)
            v297 (copy, index: 23)
            v45 (ref,  index: 24)
        ]]
        local v511
        local v512
        local canAdd2, v514
        local v515 = weaponInfo.Get(v46)
        parent14.Visible = v515 ~= nil

        if not v515 then
            return
        end

        local v516 = v17[v515.category] or colors.Accent

        if id ~= v515.id then
            id = v515.id
            weaponIcon.Set(ui13, v515.id, (iconOpts(v515.id, {spin = true, outline = true})))
            v285.Color = ColorSequence.new(v516:Lerp(colors.Panel, 0.62), colors.PanelHi:Lerp(colors.Panel, 0.6))
            v286.ImageColor3 = v516
            ui.Pop(ui13, 0.9, theme.Tween.PopSmall)
        end

        ui14.Text = v515.name
        local v517 = weaponInfo.CATEGORY_SINGULAR[v515.category] or ""
        local v518 = weaponInfo.AmmoOf(v515.id)
        local v519 = v518 and weaponInfo.AmmoDef(v518)
        local v520 = economy.Level(v515.id)
        local loc = a18.Loc
        local parts = {}

        if 1 <= v520 then
            local v523 = loc.T("LV " .. v520)
            local v524 = not (1 < v520) and "" or " " .. loc.T(string.upper(economy.BonusText(v515.id, v520)))
            table.insert(parts, v523 .. v524)
        end

        table.insert(parts, loc.T(v517))
        local t = loc.T
        local stringFormat = string.format
        local points = v515.points

        if v515.points ~= 1 then
            v511 = "S"
        else
            v511 = ""
        end

        table.insert(parts, t(stringFormat("%d POINT%s", points, v511)))

        if v519 then
            table.insert(parts, loc.T("USES " .. string.upper(v519.name)))
        end

        ui15.Text = table.concat(parts, "  ·  ")
        ui15.TextColor3 = v516:Lerp(colors.TextDim, 0.35)
        local v528 = v515.description

        if v515.category ~= "armor" then
            local v529 = weaponInfo.SpeedNote(v515)

            if v529 == "" then
                v528 = weaponInfo
            else
                v528 = v529 .. " " .. v528
                v528 = weaponInfo
            end
        else
            local v530, v531 = weaponInfo.ArmorStats(v515)
            v528 = string.format("+%d armor, %d%% slower. %s", v530, math.floor(((1 - v531) * 100) + 0.5), v528)
            v528 = weaponInfo
        end

        ui16.Text = v528
        local v532 = v528.Bars(v515)

        for v533, v534 in v294 do
            local v535 = v532[v533]
            v534.frame.Visible = v535 ~= nil

            if v535 then
                v534.label.Text = v535.label
                v534.bar.Set(v535.frac)
                v534.bar.SetColor(v516)
                v534.value.Text = statValue(v515, v535)
            end
        end

        canAdd2, v514, v512 = canAdd(v515.id)
        local v536 = v514 == "locked"
        parent17.Visible = true

        if v536 then
            local v537, v538 = economy.Progress(v515.id)

            if economy.RankAllows(v515.id) then
                ui15.Text = a18.Loc.T(string.format("LOCKED  ·  %d / %d SHARDS  ·  FIND SHARDS IN DROPS", v537, v538))
            else
                local Ranks = require(game:GetService("ReplicatedStorage").Shared.Ranks)
                ui15.Text = a18.Loc.T(string.format("LOCKED  ·  JOINS YOUR DROPS AT %s", string.upper(Ranks.Get(economy.ItemRank(v515.id)).name)))
            end

            ui15.TextColor3 = colors.TextMuted
            v297.Instance.AnchorPoint = Vector2.new(1, 0.5)
            v297.Instance.Position = UDim2.new(1, -12, 0.5, 0)
            v297.Instance.Size = UDim2.fromOffset(144, 56)
            v297.Label.TextSize = 17
            v297:SetStyle("Dark")
            v297:SetEnabled(true)
            v297:SetText("COLLECTION")

            return
        end

        v297.Instance.AnchorPoint = Vector2.new(1, 0.5)
        v297.Instance.Position = UDim2.new(1, -12, 0.5, 0)
        v297.Instance.Size = UDim2.fromOffset(144, 56)
        v297.Label.TextSize = 20
        local id2 = v515.id
        local v541 = table.find(v45.items, id2) ~= nil or v45.armor == id2
        if v541 then
            v297:SetStyle("Dark")
            v297:SetEnabled(true)
            v297:SetText("REMOVE")

            return
        end

        if canAdd2 then
            v297:SetStyle("Primary")
            v297:SetEnabled(true)
            local text = weaponInfo.IsArmor(v515.id) and v45.armor and "SWAP" or "ADD"
            v297:SetText(text)

            return
        end

        local text
        v297:SetStyle("Dark")
        v297:SetEnabled(false)

        if v514 == "points" or v514 == "ammo" then
            local v544 = v512 ~= 1 and " PTS" or " PT"
            text = "NEED " .. v512 .. v544
        else
            text = "6 ITEMS MAX"
        end

        v297:SetText(text)
    end

    local function paintAll()
        --[[
          name: paintAll
          line: 1898
          upvalues:
            v184 (copy, index: 1)
            paintRow (copy, index: 2)
            v45 (ref,  index: 3)
            row (ref,  index: 4)
            layoutRows (copy, index: 5)
            paintAmmo (copy, index: 6)
            v15 (copy, index: 7)
            targets (copy, index: 8)
            v55 (ref,  index: 9)
            v43 (copy, index: 10)
            weaponInfo (copy, index: 11)
            budget (copy, index: 12)
        ]]
        for itemKey, v547 in v184 do
            paintRow(v547, v45.items[itemKey])
        end

        local row2 = row
        local v549 = if v45.armor then v45.armor else nil
        paintRow(row2, v549)
        layoutRows()
        paintAmmo()
        v15._paintPoints()

        for _, v551 in targets do
            v15._paintCard(v551)
        end

        v15._paintDetail()
        v55()
        v43.Subtitle.Text = string.format("Pick up to %d items worth %d points.", weaponInfo.MaxItems(), budget())
    end

    local function save(a553, loadoutKey)
        --[[
          name: save
          line: 1916
          upvalues:
            count (ref,  index: 1)
            v49 (ref,  index: 2)
            v45 (ref,  index: 3)
            v52 (ref,  index: 4)
            ui6 (copy, index: 5)
            colors (copy, index: 6)
            weaponInfo (copy, index: 7)
            a18 (copy, index: 8)
            state (copy, index: 9)
            v55 (ref,  index: 10)
        ]]
        count += 1

        if not a553 then
            if not v49 then
                return
            end

            a553 = v45
            loadoutKey = v52
        end

        v49 = false

        if #a553.items == 0 then
            ui6.Text = "Add an item to save"
            ui6.TextColor3 = colors.TextMuted

            return
        end

        ui6.Text = "Saving…"
        ui6.TextColor3 = colors.TextMuted
        local _, _, v557 = weaponInfo.Validate(a553)

        if not a18.ProfileAction("SetLoadout", v557, loadoutKey) then
            ui6.Text = "Not saved"
            ui6.TextColor3 = colors.Danger

            return
        end

        ui6.Text = "✓ Saved"
        ui6.TextColor3 = colors.Success
        local loadout = {items = table.clone(v557.items), armor = v557.armor, ammo = table.clone((v557.ammo or {}))}
        local loadouts = state.Profile.loadouts

        if type(loadouts) == "table" and loadoutKey and loadouts[loadoutKey] ~= nil then
            loadouts[loadoutKey] = loadout
        end

        if not state.HasLoadoutSlots() or loadoutKey == state.ActiveLoadout() then
            state.Profile.loadout = loadout
        end

        v55()
    end

    do
        local function markDirty()
            --[[
              name: markDirty
              line: 1955
              upvalues:
                v49 (ref,  index: 1)
                v52 (ref,  index: 2)
                slot (ref,  index: 3)
                count (ref,  index: 4)
                ui6 (copy, index: 5)
                save (copy, index: 6)
            ]]
            v49 = true
            v52 = slot
            count += 1
            local v561 = count
            ui6.Text = ""

            task.delay(
                1.2,
                function()
                    --[[
                      line: 1961
                      upvalues:
                        v561 (copy, index: 1)
                        count (ref,  index: 2)
                        save (copy, index: 3)
                    ]]
                    if v561 == count then
                        save()
                    end
                end
            )
        end
    end

    local function topUpAmmo()
        --[[
          name: topUpAmmo
          line: 1970
          upvalues:
            missingAmmo (copy, index: 1)
            v45 (ref,  index: 2)
            weaponInfo (copy, index: 3)
            ammoUser (copy, index: 4)
            v49 (ref,  index: 5)
            v52 (ref,  index: 6)
            slot (ref,  index: 7)
            count (ref,  index: 8)
            ui6 (copy, index: 9)
            save (copy, index: 10)
            a18 (copy, index: 11)
        ]]
        local v563 = {}
        local v564 = {}

        for _, v566 in missingAmmo(v45) do
            local v567 = weaponInfo.AmmoDef(v566)

            if v567 and weaponInfo.Cost(v45) + v567.points <= weaponInfo.Budget() then
                v45.ammo[v566] = 1
                table.insert(v563, v566)
            elseif v567 then
                table.insert(v564, v566)
            end
        end

        local function line(a569)
            --[[
              name: line
              line: 1981
              upvalues:
                ammoUser (copy, index: 1)
                weaponInfo (copy, index: 2)
            ]]
            local v570 = ammoUser(a569)
            local stringFormat = string.format
            local lowercaseText = string.lower(weaponInfo.AmmoDef(a569).name)
            local v573 = not v570 and "weapon" or weaponInfo.Name(v570)

            return stringFormat("%s for your %s", lowercaseText, v573)
        end

        if 0 < #v563 then
            v49 = true
            v52 = slot
            count += 1
            local v574 = count
            ui6.Text = ""

            task.delay(
                1.2,
                function()
                    --[[
                      line: 1961
                      upvalues:
                        v574 (copy, index: 1)
                        count (ref,  index: 2)
                        save (copy, index: 3)
                    ]]
                    if v574 == count then
                        save()
                    end
                end
            )

            a18.Toast("Added " .. line(v563[1]) .. ": it had none", "info")

            return
        end

        if 0 < #v564 then
            a18.Toast("No " .. line(v564[1]) .. ": you can't shoot it! Make room for some", "warning")
        end
    end

    do
        local function flushSave()
            --[[
              name: flushSave
              line: 1994
              upvalues:
                v49 (ref,  index: 1)
                copyDraft (copy, index: 2)
                v45 (ref,  index: 3)
                v52 (ref,  index: 4)
                count (ref,  index: 5)
                save (copy, index: 6)
            ]]
            if not v49 then
                return
            end

            local v576 = copyDraft(v45)
            local v577 = v52
            v49 = false
            count += 1
            task.spawn(save, v576, v577)
        end
    end

    local v578 = false

    do
        local function openCollection(focus)
            --[[
              name: openCollection
              line: 2008
              upvalues:
                v578 (ref,  index: 1)
                a18 (copy, index: 2)
            ]]
            v578 = true
            local open = a18.MenuManager.Open
            local v582 = focus and {focus = focus} or nil
            open("Collection", v582)
        end

        a18.MenuManager.Changed:Connect(
            function(a583)
                --[[
                  line: 2012
                  upvalues:
                    v578 (ref,  index: 1)
                    a18 (copy, index: 2)
                    state (copy, index: 3)
                ]]
                if a583 == nil and v578 then
                    v578 = false

                    task.defer(
                        function()
                            --[[
                              line: 2015
                              upvalues:
                                a18 (copy, index: 1)
                                state (copy, index: 2)
                            ]]
                            if not a18.MenuManager.IsOpen() and not state.InMatch() then
                                a18.MenuManager.Open("Loadout")
                            end
                        end
                    )

                    return
                end

                if a583 ~= nil and a583 ~= "Collection" then
                    v578 = false
                end
            end
        )

        v15._openCollection = openCollection
    end

    v56 = function(activeLoadout)
        --[[
          line: 2027
          upvalues:
            slot (ref,  index: 1)
            state (copy, index: 2)
            v49 (ref,  index: 3)
            copyDraft (copy, index: 4)
            v45 (ref,  index: 5)
            v52 (ref,  index: 6)
            count (ref,  index: 7)
            save (copy, index: 8)
            v53 (ref,  index: 9)
            weaponInfo (copy, index: 10)
            topUpAmmo (copy, index: 11)
            v46 (ref,  index: 12)
            v47 (ref,  index: 13)
            a18 (copy, index: 14)
            paintAll (copy, index: 15)
            ui (copy, index: 16)
            v100 (copy, index: 17)
            v184 (copy, index: 18)
        ]]
        if activeLoadout == slot or not state.HasLoadoutSlots() or state.LoadoutSlotCount() < activeLoadout then
            return
        end

        if v49 then
            local v585 = copyDraft(v45)
            local v586 = v52
            v49 = false
            count += 1
            task.spawn(save, v585, v586)
        end

        slot = activeLoadout
        v53 = activeLoadout
        local _, _, v589 = weaponInfo.Validate(state.LoadoutSlot(activeLoadout))
        v45 = copyDraft(v589)
        v49 = false
        topUpAmmo()
        v46 = v45.items[1] or v46
        v47 = nil
        a18.Sounds.Play("Equip")
        paintAll()
        ui.Pop(v100[activeLoadout].tile, 1.2)

        for itemKey, v591 in v184 do
            if v45.items[itemKey] then
                task.delay(
                    itemKey * 0.03,
                    function()
                        --[[
                          line: 2045
                          upvalues:
                            ui (copy, index: 1)
                            v591 (copy, index: 2)
                        ]]
                        ui.Pop(v591.tile, 1.12)
                    end
                )
            end
        end

        task.spawn(
            function()
                --[[
                  line: 2050
                  upvalues:
                    a18 (copy, index: 1)
                    activeLoadout (copy, index: 2)
                    state (copy, index: 3)
                    v53 (ref,  index: 4)
                ]]
                local v592 = a18.ProfileAction("SelectLoadout", activeLoadout)
                if v592 then
                    state.Profile.activeLoadout = activeLoadout
                    state.Profile.loadout = state.Profile.loadouts and state.Profile.loadouts[activeLoadout]
                        or state.Profile.loadout
                end

                if v53 == activeLoadout then
                    v53 = nil
                end

                if v592 then
                    state.ProfileChanged:Fire(state.Profile)
                end
            end
        )
    end

    do
        local function dropUnusedAmmo()
            --[[
              name: dropUnusedAmmo
              line: 2067
              upvalues:
                weaponInfo (copy, index: 1)
                v45 (ref,  index: 2)
            ]]
            local v594 = weaponInfo.AmmoNeeded(v45)

            for v595 in v45.ammo do
                if not v594[v595] then
                    v45.ammo[v595] = nil
                end
            end
        end
    end

    v187 = function(target)
        --[[
          line: 2076
          upvalues:
            v45 (ref,  index: 1)
            weaponInfo (copy, index: 2)
            a18 (copy, index: 3)
            v49 (ref,  index: 4)
            v52 (ref,  index: 5)
            slot (ref,  index: 6)
            count (ref,  index: 7)
            ui6 (copy, index: 8)
            save (copy, index: 9)
            paintAll (copy, index: 10)
        ]]
        if const index = table.find(v45.items, target) then
            table.remove(v45.items, index)
            local v598 = weaponInfo.AmmoNeeded(v45)

            for v599 in v45.ammo do
                if not v598[v599] then
                    v45.ammo[v599] = nil
                end
            end
        else
            if v45.armor ~= target then
                return
            end

            v45.armor = false
        end

        a18.Sounds.Play("Close")
        v49 = true
        v52 = slot
        count += 1
        local v600 = count
        ui6.Text = ""

        task.delay(
            1.2,
            function()
                --[[
                  line: 1961
                  upvalues:
                    v600 (copy, index: 1)
                    count (ref,  index: 2)
                    save (copy, index: 3)
                ]]
                if v600 == count then
                    save()
                end
            end
        )

        paintAll()
    end

    v212 = function(key, a602)
        --[[
          line: 2091
          upvalues:
            weaponInfo (copy, index: 1)
            v45 (ref,  index: 2)
            a18 (copy, index: 3)
            ui (copy, index: 4)
            parent3 (copy, index: 5)
            ammoFloor (copy, index: 6)
            v211 (copy, index: 7)
            ammoUser (copy, index: 8)
            v49 (ref,  index: 9)
            v52 (ref,  index: 10)
            slot (ref,  index: 11)
            count (ref,  index: 12)
            ui6 (copy, index: 13)
            save (copy, index: 14)
            paintAll (copy, index: 15)
            theme (copy, index: 16)
        ]]
        local pitch
        local v604 = weaponInfo.AmmoDef(key)
        if not v604 then
            return
        end

        local v605 = v45.ammo[key] or 0

        if not (0 < a602) then
            if v605 <= 0 then
                return
            end

            if ammoFloor(key) then
                a18.Sounds.Play("Error")

                if const v606 = v211[key] then
                    ui.Shake(v606.frame, 5)
                end

                local v607 = ammoUser(key)
                local toast = a18.Toast
                local stringFormat = string.format
                local v610 = not v607 and "weapon" or weaponInfo.Name(v607)
                toast(stringFormat("Your %s needs %s: remove it to free these points", v610, string.lower(v604.name)), "warning")

                return
            end
        else
            if weaponInfo.MaxAmmoBundles() <= v605 then
                a18.Sounds.Play("Error")
                return
            end

            local v611 = weaponInfo.Cost(v45) + v604.points

            if weaponInfo.Budget() < v611 then
                a18.Sounds.Play("Error")
                ui.Shake(parent3, 5)
                a18.Toast("Not enough points for more " .. string.lower(v604.name), "warning")

                return
            end
        end

        v45.ammo[key] = math.max(0, v605 + a602)

        if v45.ammo[key] == 0 then
            v45.ammo[key] = nil
        end

        local play = a18.Sounds.Play
        local v613 = {}

        if not (0 < a602) then
            pitch = 0.9
            pitch = ui6
        else
            pitch = 1.2
            pitch = ui6
        end

        v613.pitch = pitch
        play("Tick", v613)
        v49 = true
        v52 = slot
        count += 1
        local v614 = count
        pitch.Text = ""

        task.delay(
            1.2,
            function()
                --[[
                  line: 1961
                  upvalues:
                    v614 (copy, index: 1)
                    count (ref,  index: 2)
                    save (copy, index: 3)
                ]]
                if v614 == count then
                    save()
                end
            end
        )

        paintAll()

        if const v615 = v211[key] then
            ui.Bump(v615.count, 0.15)
            ui.Pop(v615.icon, 0.85, theme.Tween.PopSmall)
        end
    end

    local function denied(a617, a618, a619)
        --[[
          name: denied
          line: 2135
          upvalues:
            a18 (copy, index: 1)
            ui (copy, index: 2)
            parent3 (copy, index: 3)
            ammoExtra (copy, index: 4)
            weaponInfo (copy, index: 5)
        ]]
        a18.Sounds.Play("Error")

        if a617 then
            ui.Shake(a617.holder, 6)
        end

        ui.Shake(parent3, 4)
        local v620 = nil

        if a617 and a618 == "ammo" then
            local _
            _, v620 = ammoExtra(a617.id)
        end

        if v620 then
            local toast = a18.Toast
            local stringFormat = string.format
            local v624 = weaponInfo.Name(a617.id)
            local lowercaseText = string.lower(v620.name)
            local v626 = a619 ~= 1 and "s" or ""
            toast(stringFormat("%s needs %s too: %d more point%s, remove something first", v624, lowercaseText, a619, v626), "warning")

            return
        end

        if a618 ~= "points" and a618 ~= "ammo" then
            if a618 == "full" then
                a18.Toast("6 items max: remove one first", "warning")
            end

            return
        end

        local toast = a18.Toast
        local stringFormat = string.format
        local v629 = a619 ~= 1 and "s" or ""
        toast(stringFormat("Needs %d more point%s: remove something first", a619, v629), "warning")
    end

    local function flashCard(a631)
        --[[
          name: flashCard
          line: 2155
          upvalues:
            ui (copy, index: 1)
            theme (copy, index: 2)
        ]]
        if not a631 then
            return
        end

        a631.flash.BackgroundTransparency = 0.7
        local v632 = {BackgroundTransparency = 1}
        ui.Tween(a631.flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v632)
        ui.Pop(a631.icon, 0.85, theme.Tween.PopSmall)
    end

    v250 = function(target, a634)
        --[[
          line: 2164
          upvalues:
            v45 (ref,  index: 1)
            v187 (ref,  index: 2)
            canAdd (copy, index: 3)
            v46 (ref,  index: 4)
            a18 (copy, index: 5)
            v578 (ref,  index: 6)
            denied (copy, index: 7)
            v249 (copy, index: 8)
            v15 (copy, index: 9)
            weaponInfo (copy, index: 10)
            row (ref,  index: 11)
            v184 (copy, index: 12)
            v49 (ref,  index: 13)
            v52 (ref,  index: 14)
            slot (ref,  index: 15)
            count (ref,  index: 16)
            ui6 (copy, index: 17)
            save (copy, index: 18)
            paintAll (copy, index: 19)
            flashCard (copy, index: 20)
            ui (copy, index: 21)
        ]]
        local v635

        if table.find(v45.items, target) ~= nil or v45.armor == target then
            v187(target)
            return
        end

        local canAdd2, v637, v638 = canAdd(target)

        if not canAdd2 and v637 == "locked" then
            v46 = target
            a18.Sounds.Play("Select")
            v578 = true
            local open = a18.MenuManager.Open
            local v640 = target and {focus = target} or nil
            open("Collection", v640)

            return
        end

        if not canAdd2 then
            denied((a634 or v249[target]), v637, v638)
            v15._paintDetail()

            return
        end

        if weaponInfo.IsArmor(target) then
            v45.armor = target
            v635 = row
        else
            table.insert(v45.items, target)
            local v641 = v184[#v45.items]
            local v642 = weaponInfo.AmmoOf(target)
            v642 = v642 and weaponInfo.AmmoDef(v642)

            if v642 then
                if (v45.ammo[v642.id] or 0) ~= 0 then
                    v635 = v641
                elseif weaponInfo.Cost(v45) + v642.points <= weaponInfo.Budget() then
                    v45.ammo[v642.id] = 1
                    v635 = v641
                else
                    v635 = v641
                end
            else
                v635 = v641
            end
        end

        a18.Sounds.Play("Equip")
        v49 = true
        v52 = slot
        count += 1
        local v643 = count
        ui6.Text = ""

        task.delay(
            1.2,
            function()
                --[[
                  line: 1961
                  upvalues:
                    v643 (copy, index: 1)
                    count (ref,  index: 2)
                    save (copy, index: 3)
                ]]
                if v643 == count then
                    save()
                end
            end
        )

        paintAll()
        local v644 = a634 or v249[target]
        flashCard(v644)
        ui.Pop(v635.tile, 1.18)
    end

    v297.Activated:Connect(
        function()
            --[[
              line: 2203
              upvalues:
                v46 (ref,  index: 1)
                economy (copy, index: 2)
                v578 (ref,  index: 3)
                a18 (copy, index: 4)
                v250 (ref,  index: 5)
                v249 (copy, index: 6)
            ]]
            local v645 = v46
            if not v645 then
                return
            end

            if not economy.IsLocked(v645) then
                v250(v645, v249[v645])
                return
            end

            v578 = true
            local open = a18.MenuManager.Open
            local v647 = v645 and {focus = v645} or nil
            open("Collection", v647)
        end
    )

    local ui18 = ui.new("Frame", {Name = "Highlight", Size = UDim2.fromOffset(60, 36), BackgroundColor3 = colors.Accent, ZIndex = 1, (ui.Corner(theme.Radius.Pill)), Parent = parent10})

    local function paintTabs(a650: boolean?)
        --[[
          name: paintTabs
          line: 2225
          upvalues:
            v241 (copy, index: 1)
            v48 (ref,  index: 2)
            colors (copy, index: 3)
            parent10 (copy, index: 4)
            v43 (copy, index: 5)
            ui (copy, index: 6)
            ui18 (copy, index: 7)
            theme (copy, index: 8)
        ]]
        for v651, v652 in v241 do
            local v653 = v651 == v48
            v652.btn.BackgroundTransparency = v653 and 1 or 0.4
            v652.label.TextColor3 = if v653 then colors.Text else colors.TextDim

            if v653 then
                task.defer(
                    function()
                        --[[
                          line: 2231
                          upvalues:
                            v652 (copy, index: 1)
                            parent10 (copy, index: 2)
                            v43 (copy, index: 3)
                            a650 (copy, index: 4)
                            ui (copy, index: 5)
                            ui18 (copy, index: 6)
                            theme (copy, index: 7)
                        ]]
                        local v654 = v652.btn.AbsolutePosition - parent10.AbsolutePosition
                        local v655 = math.max(parent10.AbsoluteSize.X / math.max(((v43.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01)
                        local v656 = {Position = UDim2.fromOffset(v654.X / v655, v654.Y / v655), Size = UDim2.fromOffset(v652.btn.AbsoluteSize.X / v655, v652.btn.AbsoluteSize.Y / v655)}

                        if a650 then
                            ui.Tween(ui18, theme.Tween.Smooth, v656)
                            return
                        end

                        ui18.Position = v656.Position
                        ui18.Size = v656.Size
                    end
                )
            end
        end
    end

    for layoutOrder, filter in weaponInfo.FILTERS do
        do
            local ui19 = ui.new("TextButton", {Name = filter.id, Size = UDim2.fromOffset(0, 36), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.4, LayoutOrder = layoutOrder, ZIndex = 2, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 16, 0, 16)), Parent = parent11})

            do
                local label = ui.new("TextLabel", {TextSize = 15, ZIndex = 2, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, Text = filter.name, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = ui19})
                v241[filter.id] = {btn = ui19, label = label}
            end

            ui19.MouseEnter:Connect(
                function()
                    --[[
                      line: 2269
                      upvalues:
                        v48 (ref,  index: 1)
                        filter (copy, index: 2)
                        ui19 (copy, index: 3)
                    ]]
                    if v48 ~= filter.id then
                        ui19.BackgroundTransparency = 0.2
                    end
                end
            )

            ui19.MouseLeave:Connect(
                function()
                    --[[
                      line: 2274
                      upvalues:
                        ui19 (copy, index: 1)
                        v48 (ref,  index: 2)
                        filter (copy, index: 3)
                    ]]
                    ui19.BackgroundTransparency = v48 ~= filter.id and 0.4 or 1
                end
            )

            ui19.Activated:Connect(
                function()
                    --[[
                      line: 2277
                      upvalues:
                        v48 (ref,  index: 1)
                        filter (copy, index: 2)
                        a18 (copy, index: 3)
                        paintTabs (copy, index: 4)
                        layoutGrid (copy, index: 5)
                        staggerCards (copy, index: 6)
                        queueVisible (copy, index: 7)
                    ]]
                    if v48 ~= filter.id then
                        v48 = filter.id
                        a18.Sounds.Play("Tab")
                        paintTabs(true)
                        layoutGrid()
                        staggerCards()
                        task.defer(queueVisible)
                    end
                end
            )
        end
    end

    paintTabs()
    local v661 = false
    local v662 = nil
    local ui20 = nil
    local ui21 = ui.new("Frame", {Name = "InsertMarker", Size = UDim2.new(1, 0, 0, 3), BackgroundColor3 = colors.Accent, Visible = false, ZIndex = 8, (ui.Corner(2)), Parent = parent8})

    do
        local function rowIndexAt(a666)
            --[[
              name: rowIndexAt
              line: 2312
              upvalues:
                parent8 (copy, index: 1)
                clampedValue (ref,  index: 2)
                v186 (ref,  index: 3)
                v45 (ref,  index: 4)
            ]]
            local v667 = parent8.AbsoluteSize.X / 400
            return (math.clamp(math.floor(((a666.Y - parent8.AbsolutePosition.Y) / math.max(v667, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1))))
        end
    end

    local function sweepGhosts()
        --[[
          name: sweepGhosts
          line: 2317
          upvalues:
            ui20 (ref,  index: 1)
            a18 (copy, index: 2)
            ui21 (copy, index: 3)
        ]]
        if ui20 then
            ui20:Destroy()
            ui20 = nil
        end

        for _, child in a18.Canvas.Top:GetChildren() do
            if child.Name == "DragGhost" then
                child:Destroy()
            end
        end

        ui21.Visible = false
    end

    do
        local function pointOf(a672)
            --[[
              name: pointOf
              line: 2329
              upvalues:
                ui (copy, index: 1)
            ]]
            if a672.UserInputType == Enum.UserInputType.Touch then
                return Vector2.new(a672.Position.X, a672.Position.Y)
            end

            return ui.PointerAbs()
        end
    end

    local lastEnd = nil

    local function endPress(commit: boolean)
        --[[
          name: endPress
          line: 2337
          upvalues:
            v662 (ref,  index: 1)
            sweepGhosts (copy, index: 2)
            lastEnd (ref,  index: 3)
            ui (copy, index: 4)
            parent8 (copy, index: 5)
            clampedValue (ref,  index: 6)
            v186 (ref,  index: 7)
            v45 (ref,  index: 8)
            a18 (copy, index: 9)
            v49 (ref,  index: 10)
            v52 (ref,  index: 11)
            slot (ref,  index: 12)
            count (ref,  index: 13)
            ui6 (copy, index: 14)
            save (copy, index: 15)
            paintAll (copy, index: 16)
            v184 (copy, index: 17)
            v46 (ref,  index: 18)
            v15 (copy, index: 19)
        ]]
        local v676 = v662
        v662 = nil
        local dragging = v676 ~= nil and v676.dragging
        sweepGhosts()

        if not v676 then
            return
        end

        local v678 = {commit = commit, dragging = dragging, from = v676.index}
        local input = v676.input
        local v680 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) else ui.PointerAbs()
        local v681 = parent8.AbsoluteSize.X / 400
        v678.to = math.clamp(math.floor(((v680.Y - parent8.AbsolutePosition.Y) / math.max(v681, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
        lastEnd = v678

        if dragging then
            local input2 = v676.input
            local v683 = if input2.UserInputType == Enum.UserInputType.Touch then Vector2.new(input2.Position.X, input2.Position.Y) else ui.PointerAbs()
            local v684 = parent8.AbsoluteSize.X / 400
            local clampedValue2 = math.clamp(math.floor(((v683.Y - parent8.AbsolutePosition.Y) / math.max(v684, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))

            if not commit or clampedValue2 == v676.index or not v45.items[v676.index] then
                paintAll()
                return
            end

            local removedValue = table.remove(v45.items, v676.index)
            table.insert(v45.items, clampedValue2, removedValue)
            a18.Sounds.Play("Equip")
            v49 = true
            v52 = slot
            count += 1
            local v687 = count
            ui6.Text = ""

            task.delay(
                1.2,
                function()
                    --[[
                      line: 1961
                      upvalues:
                        v687 (copy, index: 1)
                        count (ref,  index: 2)
                        save (copy, index: 3)
                    ]]
                    if v687 == count then
                        save()
                    end
                end
            )

            paintAll()
            ui.Pop(v184[clampedValue2].tile, 1.18)

            return
        end

        if commit then
            if not v676.armed then
                if const item = v45.items[v676.index] then
                    v46 = item
                    v15._paintDetail()

                    return
                end

                return
            end
        end

        paintAll()
    end

    do
        local function insideGui(remove, start)
            --[[
              name: insideGui
              line: 2369
            ]]
            local absolutePosition = remove.AbsolutePosition
            local absoluteSize = remove.AbsoluteSize
            local v694 = false
            local x = start.X

            if absolutePosition.X <= x then
                v694 = false

                if start.X <= absolutePosition.X + absoluteSize.X then
                    v694 = false
                    local y = start.Y

                    if absolutePosition.Y <= y then
                        v694 = start.Y <= absolutePosition.Y + absoluteSize.Y
                    end
                end
            end

            return v694
        end
    end

    do
        local function liftGhost(a698)
            --[[
              name: liftGhost
              line: 2373
              upvalues:
                sweepGhosts (copy, index: 1)
                v45 (ref,  index: 2)
                ui (copy, index: 3)
                clampedValue (ref,  index: 4)
                colors (copy, index: 5)
                a18 (copy, index: 6)
                weaponInfo (copy, index: 7)
                v17 (copy, index: 8)
                weaponIcon (copy, index: 9)
                fonts (copy, index: 10)
                ui20 (ref,  index: 11)
                v184 (copy, index: 12)
            ]]
            local v699
            local v700 = false
            sweepGhosts()
            a698.dragging = true
            local item = v45.items[a698.index]
            local parent = ui.new("Frame", {Name = "DragGhost", AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(320, clampedValue), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.05, ZIndex = 50, ui.Corner(12), (ui.Stroke(colors.Accent, 2, 0)), Parent = a18.Canvas.Top})
            local newUi = ui.new
            local v704 = {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(clampedValue - 8, clampedValue - 8)}

            if const v705 = weaponInfo.Get(item) then
                v699 = v17[v705.category]

                if v699 then
                    v699 = weaponIcon
                else
                    v700 = true
                end
            else
                v700 = true
            end

            if v700 then
                v699 = colors.Accent
                v699 = weaponIcon
            end

            v704.BackgroundColor3 = v699:Lerp(colors.Panel, 0.6)
            v704.ZIndex = 51
            v704[1] = (ui.Corner(9))
            v704.Parent = parent
            local parent2 = newUi("Frame", v704)
            local ui2 = ui.new("Frame", {ZIndex = 52, Size = UDim2.fromScale(1, 1), Parent = parent2})
            v699.Set(ui2, item, {outline = false, glow = false})
            ui.new("TextLabel", {TextSize = 17, ZIndex = 51, Position = UDim2.fromOffset(clampedValue + 8, 0), Size = UDim2.new(1, -(clampedValue + 16), 1, 0), Text = weaponInfo.Name(item), FontFace = fonts.Bold, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
            ui20 = parent
            v184[a698.index].frame.BackgroundTransparency = 0.85
        end

        local function moveGhost(a709, a710)
            --[[
              name: moveGhost
              line: 2412
              upvalues:
                ui20 (ref,  index: 1)
                a18 (copy, index: 2)
                ui (copy, index: 3)
                parent8 (copy, index: 4)
                clampedValue (ref,  index: 5)
                v186 (ref,  index: 6)
                v45 (ref,  index: 7)
                ui21 (copy, index: 8)
            ]]
            local ui2 = ui20
            if not ui2 then
                return
            end

            local top = a18.Canvas.Top
            local v713 = math.max(ui.Scale, 0.01)
            local v714 = (a710 - top.AbsolutePosition) / v713
            ui2.Position = UDim2.fromOffset(v714.X - 40, v714.Y)
            local v715 = parent8.AbsoluteSize.X / 400
            local clampedValue2 = math.clamp(math.floor(((a710.Y - parent8.AbsolutePosition.Y) / math.max(v715, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
            ui21.Visible = clampedValue2 ~= a709.index
            local v717 = if clampedValue2 < a709.index then (clampedValue2 - 1) * (clampedValue + v186) - 4 else clampedValue2 * (clampedValue + v186) - 4
            ui21.Position = UDim2.fromOffset(0, v717)
        end

        for v718, v719 in v184 do
            v719.frame.InputBegan:Connect(
                function(input)
                    --[[
                      line: 2428
                      upvalues:
                        v662 (ref,  index: 1)
                        v45 (ref,  index: 2)
                        v718 (copy, index: 3)
                        v43 (copy, index: 4)
                        ui (copy, index: 5)
                        v719 (copy, index: 6)
                        sweepGhosts (copy, index: 7)
                        lastEnd (ref,  index: 8)
                        parent8 (copy, index: 9)
                        clampedValue (ref,  index: 10)
                        v186 (ref,  index: 11)
                        paintAll (copy, index: 12)
                        v661 (ref,  index: 13)
                        insideGui (copy, index: 14)
                    ]]
                    local userInputType = input.UserInputType

                    if userInputType ~= Enum.UserInputType.MouseButton1 and userInputType ~= Enum.UserInputType.Touch then
                        return
                    end

                    if input.UserInputState == Enum.UserInputState.Begin then
                        if not v662 or v662.input ~= input then
                            if not v45.items[v718] or not v43.IsOpen then
                                return
                            end

                            local start = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) else ui.PointerAbs()

                            if v719.remove.Visible and insideGui(v719.remove, start) then
                                return
                            end

                            if v662 then
                                local v723 = v662
                                v662 = nil
                                local dragging = v723 ~= nil and v723.dragging
                                sweepGhosts()

                                if v723 then
                                    local v725 = {commit = false, dragging = dragging, from = v723.index}
                                    local input2 = v723.input
                                    local v727 = if input2.UserInputType == Enum.UserInputType.Touch then Vector2.new(input2.Position.X, input2.Position.Y) else ui.PointerAbs()
                                    local v728 = parent8.AbsoluteSize.X / 400
                                    v725.to = math.clamp(math.floor(((v727.Y - parent8.AbsolutePosition.Y) / math.max(v728, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                                    lastEnd = v725

                                    if dragging then
                                        local input3 = v723.input
                                        local v730 = if input3.UserInputType == Enum.UserInputType.Touch then Vector2.new(input3.Position.X, input3.Position.Y) else ui.PointerAbs()
                                        local v731 = parent8.AbsoluteSize.X / 400
                                        math.clamp(math.floor(((v730.Y - parent8.AbsolutePosition.Y) / math.max(v731, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                                        paintAll()
                                    else
                                        paintAll()
                                    end
                                end
                            end

                            local v732 = {armed = false, dragging = false, index = v718, input = input, start = start, at = os.clock()}
                            v732.hold = userInputType == Enum.UserInputType.Touch or ui.Touch or v661
                            v662 = v732
                        end
                    end
                end
            )
        end

        userInputService.InputChanged:Connect(
            function(input3: InputObject)
                --[[
                  line: 2459
                  upvalues:
                    v662 (ref,  index: 1)
                    ui (copy, index: 2)
                    sweepGhosts (copy, index: 3)
                    lastEnd (ref,  index: 4)
                    parent8 (copy, index: 5)
                    clampedValue (ref,  index: 6)
                    v186 (ref,  index: 7)
                    v45 (ref,  index: 8)
                    paintAll (copy, index: 9)
                    liftGhost (copy, index: 10)
                    moveGhost (copy, index: 11)
                ]]
                local v734 = v662
                if not v734 then
                    return
                end

                local isTouch = v734.input.UserInputType == Enum.UserInputType.Touch

                if isTouch then
                    if input3 ~= v734.input then
                        return
                    end
                elseif input3.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end

                local v736 = if isTouch then v734.input else input3
                local v737 = if v736.UserInputType == Enum.UserInputType.Touch then Vector2.new(v736.Position.X, v736.Position.Y) else ui.PointerAbs()
                local magnitude = (v737 - v734.start).Magnitude

                if not v734.dragging then
                    if v734.hold then
                        if not v734.armed then
                            if 12 < magnitude then
                                local v739 = v662
                                v662 = nil
                                local dragging = v739 ~= nil and v739.dragging
                                sweepGhosts()

                                if not v739 then
                                    return
                                end

                                local v741 = {commit = false, dragging = dragging, from = v739.index}
                                local input = v739.input
                                local v743 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) else ui.PointerAbs()
                                local v744 = parent8.AbsoluteSize.X / 400
                                v741.to = math.clamp(math.floor(((v743.Y - parent8.AbsolutePosition.Y) / math.max(v744, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                                lastEnd = v741

                                if dragging then
                                    local input2 = v739.input
                                    local v746 = if input2.UserInputType == Enum.UserInputType.Touch then Vector2.new(input2.Position.X, input2.Position.Y) else ui.PointerAbs()
                                    local v747 = parent8.AbsoluteSize.X / 400
                                    math.clamp(math.floor(((v746.Y - parent8.AbsolutePosition.Y) / math.max(v747, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                                    paintAll()

                                    return
                                end

                                paintAll()
                            end

                            return
                        end

                        if 6 < magnitude then
                            liftGhost(v734)
                        end
                    elseif 12 < magnitude then
                        liftGhost(v734)
                    end
                end

                if v734.dragging then
                    moveGhost(v734, v737)
                end
            end
        )

        do
            local function onEnded(inputObject: InputObject)
                --[[
                  name: onEnded
                  line: 2493
                  upvalues:
                    v662 (ref,  index: 1)
                    endPress (copy, index: 2)
                ]]
                local v750 = v662
                if not v750 then
                    return
                end

                if v750.input.UserInputType ~= Enum.UserInputType.Touch then
                    if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        return
                    end
                elseif inputObject ~= v750.input then
                    return
                end

                endPress(true)
            end

            userInputService.InputEnded:Connect(onEnded)
            userInputService.TouchEnded:Connect(onEnded)
        end

        userInputService.WindowFocusReleased:Connect(
            function()
                --[[
                  line: 2509
                  upvalues:
                    v662 (ref,  index: 1)
                    sweepGhosts (copy, index: 2)
                    lastEnd (ref,  index: 3)
                    ui (copy, index: 4)
                    parent8 (copy, index: 5)
                    clampedValue (ref,  index: 6)
                    v186 (ref,  index: 7)
                    v45 (ref,  index: 8)
                    paintAll (copy, index: 9)
                ]]
                local v751 = v662
                v662 = nil
                local dragging = v751 ~= nil and v751.dragging
                sweepGhosts()

                if not v751 then
                    return
                end

                local v753 = {commit = false, dragging = dragging, from = v751.index}
                local input = v751.input
                local v755 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) else ui.PointerAbs()
                local v756 = parent8.AbsoluteSize.X / 400
                v753.to = math.clamp(math.floor(((v755.Y - parent8.AbsolutePosition.Y) / math.max(v756, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                lastEnd = v753

                if not dragging then
                    paintAll()
                    return
                end

                local input2 = v751.input
                local v758 = if input2.UserInputType == Enum.UserInputType.Touch then Vector2.new(input2.Position.X, input2.Position.Y) else ui.PointerAbs()
                local v759 = parent8.AbsoluteSize.X / 400
                math.clamp(math.floor(((v758.Y - parent8.AbsolutePosition.Y) / math.max(v759, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                paintAll()
            end
        )

        ui.Every(
            parent8,
            0.1,
            function()
                --[[
                  line: 2513
                  upvalues:
                    v662 (ref,  index: 1)
                    ui20 (ref,  index: 2)
                    ui21 (copy, index: 3)
                    sweepGhosts (copy, index: 4)
                    paintAll (copy, index: 5)
                    v43 (copy, index: 6)
                    lastEnd (ref,  index: 7)
                    ui (copy, index: 8)
                    parent8 (copy, index: 9)
                    clampedValue (ref,  index: 10)
                    v186 (ref,  index: 11)
                    v45 (ref,  index: 12)
                    endPress (copy, index: 13)
                    userInputService (copy, index: 14)
                    v184 (copy, index: 15)
                    a18 (copy, index: 16)
                ]]
                local v760 = v662
                if not v760 then
                    if ui20 or ui21.Visible then
                        sweepGhosts()
                        paintAll()
                    end

                    return
                end

                local userInputState = v760.input.UserInputState

                if v43.IsOpen and userInputState ~= Enum.UserInputState.Cancel then
                    if userInputState == Enum.UserInputState.End then
                        endPress(true)
                        return
                    end

                    if v760.input.UserInputType == Enum.UserInputType.MouseButton1
                        and not userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                    then
                        endPress(true)
                        return
                    end

                    if v760.hold and not v760.armed and 0.28 <= os.clock() - v760.at then
                        v760.armed = true
                        v184[v760.index].frame.BackgroundTransparency = 0.12
                        ui.Bump(v184[v760.index].tile, 0.08)
                        a18.Sounds.Play("Select")
                    end

                    return
                end

                local v762 = v662
                v662 = nil
                local dragging = v762 ~= nil and v762.dragging
                sweepGhosts()

                if not v762 then
                    return
                end

                local v764 = {commit = false, dragging = dragging, from = v762.index}
                local input = v762.input
                local v766 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) else ui.PointerAbs()
                local v767 = parent8.AbsoluteSize.X / 400
                v764.to = math.clamp(math.floor(((v766.Y - parent8.AbsolutePosition.Y) / math.max(v767, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                lastEnd = v764

                if not dragging then
                    paintAll()
                    return
                end

                local input2 = v762.input
                local v769 = if input2.UserInputType == Enum.UserInputType.Touch then Vector2.new(input2.Position.X, input2.Position.Y) else ui.PointerAbs()
                local v770 = parent8.AbsoluteSize.X / 400
                math.clamp(math.floor(((v769.Y - parent8.AbsolutePosition.Y) / math.max(v770, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                paintAll()
            end
        )

        a18.Debug.drag = function(a771, a772)
            --[[
              line: 2541
              upvalues:
                v661 (ref,  index: 1)
                a18 (copy, index: 2)
                v662 (ref,  index: 3)
                lastEnd (ref,  index: 4)
            ]]
            if a771 == "hold" then
                v661 = a772 == true
            end

            local count = 0

            for _, child in a18.Canvas.Top:GetChildren() do
                if child.Name == "DragGhost" then
                    count += 1
                end
            end

            local v776 = {}
            local press = v662 ~= nil
            v776.press = press
            v776.dragging = v662 ~= nil and v662.dragging
            v776.armed = v662 ~= nil and v662.armed
            v776.ghosts = count
            v776.lastEnd = lastEnd

            return v776
        end

        a18.Debug.gear = function(a778, key, a780)
            --[[
              line: 2557
              upvalues:
                v46 (ref,  index: 1)
                v250 (ref,  index: 2)
                v249 (copy, index: 3)
                weaponInfo (copy, index: 4)
                v45 (ref,  index: 5)
                copyDraft (copy, index: 6)
                v49 (ref,  index: 7)
                v52 (ref,  index: 8)
                slot (ref,  index: 9)
                count (ref,  index: 10)
                ui6 (copy, index: 11)
                save (copy, index: 12)
                paintAll (copy, index: 13)
                v212 (ref,  index: 14)
                v48 (ref,  index: 15)
                paintTabs (copy, index: 16)
                layoutGrid (copy, index: 17)
                staggerCards (copy, index: 18)
                queueVisible (copy, index: 19)
                v47 (ref,  index: 20)
                v56 (ref,  index: 21)
                state (copy, index: 22)
            ]]
            if a778 == "toggle" then
                v46 = key
                v250(key, v249[key])
            elseif a778 == "set" and type(key) == "table" then
                local _, _, v783 = weaponInfo.Validate(key)
                v45 = copyDraft(v783)
                v46 = v45.items[1] or v46
                v49 = true
                v52 = slot
                count += 1
                local v784 = count
                ui6.Text = ""

                task.delay(
                    1.2,
                    function()
                        --[[
                          line: 1961
                          upvalues:
                            v784 (copy, index: 1)
                            count (ref,  index: 2)
                            save (copy, index: 3)
                        ]]
                        if v784 == count then
                            save()
                        end
                    end
                )

                paintAll()
            elseif a778 == "ammo" then
                v212(key, a780)
            elseif a778 == "filter" then
                v48 = key
                paintTabs(true)
                layoutGrid()
                staggerCards()
                task.defer(queueVisible)
            elseif a778 == "hover" then
                v47 = key
                v46 = key or v46
                paintAll()
            elseif a778 == "slot" then
                v56(key)
            end

            return {items = v45.items, armor = v45.armor, ammo = v45.ammo, cost = weaponInfo.Cost(v45), saved = ui6.Text, slot = slot, active = state.ActiveLoadout(), slots = state.LoadoutSlotCount()}
        end

        do
            local v785 = false

            state.ProfileChanged:Connect(
                function()
                    --[[
                      line: 2588
                      upvalues:
                        v43 (copy, index: 1)
                        v54 (copy, index: 2)
                        state (copy, index: 3)
                        v49 (ref,  index: 4)
                        v55 (ref,  index: 5)
                        slot (ref,  index: 6)
                        v53 (ref,  index: 7)
                        v45 (ref,  index: 8)
                        copyDraft (copy, index: 9)
                        paintAll (copy, index: 10)
                    ]]
                    if not v43.IsOpen then
                        return
                    end

                    for v786, v787 in v54 do
                        if state.LoadoutCustomName(v786) == v787 then
                            v54[v786] = nil
                        end
                    end

                    if v49 then
                        v55()
                        return
                    end

                    slot = v53 or state.ActiveLoadout()
                    v45 = copyDraft(state.LoadoutSlot(slot))
                    paintAll()
                end
            )

            a18.MenuManager.Register(
                "Loadout",
                {
                    open = (function(a788)
                        --[[
                          name: open
                          line: 2607
                          upvalues:
                            layoutWindow (copy, index: 1)
                            v785 (ref,  index: 2)
                            weaponInfo (copy, index: 3)
                            makeCard (copy, index: 4)
                            targets (copy, index: 5)
                            v249 (copy, index: 6)
                            slot (ref,  index: 7)
                            state (copy, index: 8)
                            v53 (ref,  index: 9)
                            v45 (ref,  index: 10)
                            copyDraft (copy, index: 11)
                            v49 (ref,  index: 12)
                            topUpAmmo (copy, index: 13)
                            v46 (ref,  index: 14)
                            v48 (ref,  index: 15)
                            v47 (ref,  index: 16)
                            id (ref,  index: 17)
                            ui6 (copy, index: 18)
                            v6 (ref,  index: 19)
                            textChatService (copy, index: 20)
                            starterGui (copy, index: 21)
                            v43 (copy, index: 22)
                            layoutGrid (copy, index: 23)
                            paintAll (copy, index: 24)
                            paintTabs (copy, index: 25)
                            staggerCards (copy, index: 26)
                            queueVisible (copy, index: 27)
                            parent12 (copy, index: 28)
                            flashCard (copy, index: 29)
                        ]]
                        layoutWindow()

                        if not v785 then
                            v785 = true

                            for _, v790 in weaponInfo.AllItems() do
                                if v790.category ~= "ammo" then
                                    local card = makeCard(v790)
                                    table.insert(targets, card)
                                    v249[v790.id] = card
                                end
                            end
                        end

                        slot = state.ActiveLoadout()
                        v53 = nil
                        local _, _, v794 = weaponInfo.Validate(state.LoadoutSlot(slot))
                        v45 = copyDraft(v794)
                        v49 = false
                        topUpAmmo()
                        local item = v45.items[1] or weaponInfo.DefaultLoadout().items[1]
                        v46 = item
                        local focus = type(a788) == "table"
                            and type(a788.focus) == "string"
                            and weaponInfo.Get(a788.focus)
                            and a788.focus
                            or nil
                        if focus then
                            v46 = focus

                            if v48 ~= "all" then
                                v48 = "all"
                            end
                        end

                        v47 = nil
                        id = nil
                        ui6.Text = ""

                        if not v6 then
                            local v797 = {}

                            pcall(
                                function()
                                    --[[
                                      line: 46
                                      upvalues:
                                        textChatService (copy, index: 1)
                                        v797 (copy, index: 2)
                                        starterGui (copy, index: 3)
                                    ]]
                                    if textChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then
                                        v797.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                                        starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                                    else
                                        local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                        local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                        if chatWindowConfiguration then
                                            v797.window = chatWindowConfiguration.Enabled
                                            chatWindowConfiguration.Enabled = false
                                        end

                                        if chatInputBarConfiguration then
                                            v797.bar = chatInputBarConfiguration.Enabled
                                            chatInputBarConfiguration.Enabled = false
                                        end
                                    end
                                end
                            )

                            v6 = v797
                        end

                        v43:Open()

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
                                    focus (copy, index: 6)
                                    v249 (copy, index: 7)
                                    parent12 (copy, index: 8)
                                    v43 (copy, index: 9)
                                    flashCard (copy, index: 10)
                                ]]
                                layoutGrid()
                                paintAll()
                                paintTabs()
                                staggerCards()
                                queueVisible()

                                if const v800 = focus and v249[focus] then
                                    local v801 = math.max(parent12.AbsoluteSize.X / math.max(((v43.Holder.Size.X.Offset - 44) - 400) - 18, 1), 0.01)
                                    local v802 = math.max(0, v800.y - 8) * v801
                                    local v803 = math.max(0, parent12.AbsoluteCanvasSize.Y - parent12.AbsoluteWindowSize.Y)
                                    parent12.CanvasPosition = Vector2.new(0, (math.min(v802, v803)))
                                    queueVisible()
                                    task.delay(
                                        0.3,
                                        function()
                                            --[[
                                              line: 2653
                                              upvalues:
                                                flashCard (copy, index: 1)
                                                v800 (copy, index: 2)
                                            ]]
                                            flashCard(v800)
                                        end
                                    )
                                end
                            end
                        )
                    end),
                    close = (function(a804)
                        --[[
                          name: close
                          line: 2659
                          upvalues:
                            v6 (ref,  index: 1)
                            textChatService (copy, index: 2)
                            starterGui (copy, index: 3)
                            v49 (ref,  index: 4)
                            copyDraft (copy, index: 5)
                            v45 (ref,  index: 6)
                            v52 (ref,  index: 7)
                            count (ref,  index: 8)
                            save (copy, index: 9)
                            a18 (copy, index: 10)
                            v662 (ref,  index: 11)
                            sweepGhosts (copy, index: 12)
                            lastEnd (ref,  index: 13)
                            ui (copy, index: 14)
                            parent8 (copy, index: 15)
                            clampedValue (ref,  index: 16)
                            v186 (ref,  index: 17)
                            paintAll (copy, index: 18)
                            v43 (copy, index: 19)
                        ]]
                        if const v805 = v6 then
                            v6 = nil

                            pcall(
                                function()
                                    --[[
                                      line: 71
                                      upvalues:
                                        textChatService (copy, index: 1)
                                        v805 (copy, index: 2)
                                        starterGui (copy, index: 3)
                                    ]]
                                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                    if chatWindowConfiguration and v805.window ~= nil then
                                        chatWindowConfiguration.Enabled = v805.window
                                    end

                                    if chatInputBarConfiguration and v805.bar ~= nil then
                                        chatInputBarConfiguration.Enabled = v805.bar
                                    end

                                    if v805.core ~= nil then
                                        starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v805.core)
                                    end
                                end
                            )
                        end

                        if v49 then
                            local v808 = copyDraft(v45)
                            local v809 = v52
                            v49 = false
                            count += 1
                            task.spawn(save, v808, v809)
                        end

                        if #v45.items == 0 then
                            a18.Toast("A loadout needs at least one item. Your last one was kept.", "info")
                        end

                        local v810 = v662
                        v662 = nil
                        local dragging = v810 ~= nil and v810.dragging
                        sweepGhosts()

                        if v810 then
                            local v812 = {commit = false, dragging = dragging, from = v810.index}
                            local input = v810.input
                            local v814 = if input.UserInputType == Enum.UserInputType.Touch then Vector2.new(input.Position.X, input.Position.Y) else ui.PointerAbs()
                            local v815 = parent8.AbsoluteSize.X / 400
                            v812.to = math.clamp(math.floor(((v814.Y - parent8.AbsolutePosition.Y) / math.max(v815, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                            lastEnd = v812

                            if dragging then
                                local input2 = v810.input
                                local v817 = if input2.UserInputType == Enum.UserInputType.Touch then Vector2.new(input2.Position.X, input2.Position.Y) else ui.PointerAbs()
                                local v818 = parent8.AbsoluteSize.X / 400
                                math.clamp(math.floor(((v817.Y - parent8.AbsolutePosition.Y) / math.max(v818, 0.01)) / (clampedValue + v186)) + 1, 1, (math.max(#v45.items, 1)))
                                paintAll()
                            else
                                paintAll()
                            end
                        end

                        v43:Close(a804)
                    end),
                    select = (function()
                        --[[
                          name: select
                          line: 2670
                          upvalues:
                            v46 (ref,  index: 1)
                            v249 (copy, index: 2)
                            targets (copy, index: 3)
                        ]]
                        local v819 = v46 and v249[v46]

                        if v819 and v819.holder.Visible then
                            return v819.holder
                        end

                        for _, v821 in targets do
                            if v821.holder.Visible then
                                return v821.holder
                            end
                        end

                        return nil
                    end)
                }
            )

            state.PlayerStateChanged:Connect(
                function(a822)
                    --[[
                      line: 2685
                      upvalues:
                        a18 (copy, index: 1)
                    ]]
                    if a822 == "Match" and a18.MenuManager.IsOpen("Loadout") then
                        a18.MenuManager.Close("Loadout", true)
                    end
                end
            )

            v43.Closed:Connect(restoreChat)

            economy.Changed:Connect(
                function()
                    --[[
                      line: 2692
                      upvalues:
                        v43 (copy, index: 1)
                        v785 (ref,  index: 2)
                        layoutGrid (copy, index: 3)
                        queueVisible (copy, index: 4)
                        targets (copy, index: 5)
                        v15 (copy, index: 6)
                    ]]
                    if v43.IsOpen and v785 then
                        layoutGrid(true)
                        queueVisible()

                        for _, v824 in targets do
                            v15._paintCard(v824)
                        end

                        v15._paintDetail()
                    end
                end
            )
        end

        economy.Event:Connect(
            function(a825, a826)
                --[[
                  line: 2702
                  upvalues:
                    v43 (copy, index: 1)
                    paintAll (copy, index: 2)
                ]]
                if a825 == "Unlocked" and v43.IsOpen then
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
            end
        )

        do
            local v827 = false

            economy.CelebrationChanged:Connect(
                function(a828)
                    --[[
                      line: 2713
                      upvalues:
                        v43 (copy, index: 1)
                        v827 (ref,  index: 2)
                        paintAll (copy, index: 3)
                        flashCard (copy, index: 4)
                        v46 (ref,  index: 5)
                        v249 (copy, index: 6)
                    ]]
                    if a828 and v43.IsOpen and not v827 then
                        v827 = true
                        v43.Holder.Visible = false

                        return
                    end

                    if not a828 and v827 then
                        v827 = false
                        v43.Holder.Visible = true

                        if v43.IsOpen then
                            paintAll()
                            local v829 = v46 and v249[v46] or nil
                            flashCard(v829)
                        end
                    end
                end
            )
        end

        do
            local function relayout()
                --[[
                  name: relayout
                  line: 2726
                  upvalues:
                    v43 (copy, index: 1)
                    layoutWindow (copy, index: 2)
                    layoutGrid (copy, index: 3)
                    paintAll (copy, index: 4)
                    paintTabs (copy, index: 5)
                    queueVisible (copy, index: 6)
                ]]
                if v43.IsOpen then
                    layoutWindow()
                    v43.Refit()

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
            end

            ui.LayoutChanged:Connect(relayout)
            ui.OnResize(relayout)
        end
    end
end

return v15