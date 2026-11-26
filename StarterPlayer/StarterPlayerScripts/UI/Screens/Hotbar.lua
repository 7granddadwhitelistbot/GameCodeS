local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local hotbar = {}
local Keybinds = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local v6 = {Item1 = 1, Item2 = 2, Item3 = 3, Item4 = 4, Item5 = 5, Item6 = 6}
local v7 = {primary = 1, secondary = 2, melee = 3, utility = 4}

function hotbar.Init(a8)
    --[[
      name: Init
      line: 23
      upvalues:
        players (copy, index: 1)
        v7 (copy, index: 2)
        runService (copy, index: 3)
        hotbar (copy, index: 4)
        userInputService (copy, index: 5)
        Keybinds (copy, index: 6)
        v6 (copy, index: 7)
    ]]
    local reserveOf
    local v10

    local v11 = function()
        --[[
          line: 411
        ]]
        return {}
    end

    local ui = a8.UI
    local theme = a8.Theme
    local state = a8.State
    local weaponIcon = a8.WeaponIcon
    local weaponInfo = a8.WeaponInfo
    local colors = theme.Colors
    local _ = theme.Fonts
    local localPlayer = players.LocalPlayer
    local ui2 = ui.new("Frame", {Name = "Hotbar", Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(566, 98), Parent = a8.Canvas.HUD})
    local v21 = ui.DisplayText({Name = "Equipped", Text = "", TextSize = 24, TextTransparency = 1, StrokeThickness = 2, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0, -4), Size = UDim2.fromOffset(420, 28), TextColor3 = colors.Text, Parent = ui2})
    local uiStroke = v21:FindFirstChildOfClass("UIStroke")
    uiStroke.Transparency = 1
    local v23 = {}
    local v24 = 0
    local v25 = nil
    local v26 = 0
    local v27 = 4
    local v28 = a8.HotbarChanged or Instance.new("BindableEvent")
    a8.HotbarChanged = v28
    local v29 = ui.PadActionCap("PrevItem", {Height = 24, ZIndex = 3, Position = UDim2.fromOffset(4, 4)})
    local v30 = ui.PadActionCap("NextItem", {Height = 24, ZIndex = 3, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 4)})
    v29.Name = "PadPrev"
    v30.Name = "PadNext"

    local function layout()
        --[[
          name: layout
          line: 86
          upvalues:
            ui (copy, index: 1)
            ui2 (copy, index: 2)
            v27 (ref,  index: 3)
            v23 (copy, index: 4)
            v24 (ref,  index: 5)
            v29 (copy, index: 6)
            v30 (copy, index: 7)
        ]]
        local v32
        local v33 = ui.Compact and 76 or 86
        local v34 = ui.Compact and 6 or 10
        ui2.Size = UDim2.fromOffset((v27 * v33) + ((v27 - 1) * v34), v33 + 12)
        local newUDim2 = UDim2.new

        if ui.Compact then
            v32 = -8
            v32 = v23
        else
            v32 = -18
            v32 = v23
        end

        ui2.Position = newUDim2(0.5, 0, 1, v32)

        for v36, v37 in v32 do
            local holder = v37.holder
            local v39 = v36 <= v27
            holder.Visible = v39
            v37.holder.Size = UDim2.fromOffset(v33, v33)
            local holder2 = v37.holder
            v39 = UDim2.fromOffset
            local v41 = (v36 - 1) * (v33 + v34)
            local v42 = v36 ~= v24 and 12 or 0
            holder2.Position = v39(v41, v42)
        end

        local v43 = v32[1]
        local v44 = v32[math.clamp(v27, 1, 6)]

        if v43 and v44 then
            v29.Parent, v30.Parent = v43.face, v44.face
        end
    end

    function a8.HotbarTop()
        --[[
          name: HotbarTop
          line: 101
          upvalues:
            ui (copy, index: 1)
        ]]
        local v45 = ui.Compact and 76 or 86
        local v46 = v45 + 12
        local v47 = ui.Compact and 8 or 18

        return v46 + v47
    end

    function a8.HotbarWidth()
        --[[
          name: HotbarWidth
          line: 108
          upvalues:
            ui (copy, index: 1)
            v27 (ref,  index: 2)
        ]]
        local v48 = ui.Compact and 76 or 86
        local v49 = ui.Compact and 6 or 10

        return (math.max((v27 * v48) + ((v27 - 1) * v49), (v48 * 4) + (v49 * 3)))
    end

    local equip = nil

    for index = 1, 6 do
        local ui3 = ui.new("TextButton", {Selectable = false, Name = "Slot" .. index, Size = UDim2.fromOffset(86, 86), Position = UDim2.fromOffset((index - 1) * 96, 12), Parent = ui2})
        local ui4 = ui.new("Frame", {Name = "Face", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.2, ui.Corner(12), (ui.Gradient(colors.PanelHi, colors.PanelLo, 90)), Parent = ui3})
        local stroke = ui.Stroke(colors.Stroke, 2, 0.7)
        stroke.Parent = ui4
        local icon = ui.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -14, 1, -14), Parent = ui4})
        local key = ui.ActionCap("Item" .. index, {Height = 22, ZIndex = 3, Position = UDim2.fromOffset(5, 5), Parent = ui4})
        local ammo = ui.DisplayText({Name = "Ammo", Text = "", TextSize = 22, ZIndex = 4, StrokeThickness = 2, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -6, 1, -3), Size = UDim2.fromOffset(60, 24), TextXAlignment = Enum.TextXAlignment.Right, Parent = ui4})
        local pips = ui.new("Frame", {Name = "Pips", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -12, 0, 8), Visible = false, ZIndex = 4, (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = ui4})
        local ui5 = ui.new("Frame", {Name = "Reload", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.4, Visible = false, ZIndex = 5, ClipsDescendants = true, (ui.Corner(12)), Parent = ui4})
        local reloadFill = ui.new("Frame", {Name = "Fill", BackgroundTransparency = 0.55, ZIndex = 5, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0), BackgroundColor3 = colors.Accent, Parent = ui5})
        local displayText = ui.DisplayText
        local v62 = {Text = "RELOAD", TextSize = 16, ZIndex = 6, StrokeThickness = 1.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 0, 0, 20), TextColor3 = colors.Accent, Parent = ui5}
        displayText(v62).Name = "Label"
        local ui6 = ui.new("Frame", {Name = "Cooldown", ClipsDescendants = true, Visible = false, ZIndex = 5, Size = UDim2.fromScale(1, 1), Parent = ui4})
        local coolFill = ui.new("Frame", {AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.45, ZIndex = 5, (ui.Corner(12)), Parent = ui6})
        local ui7 = ui.new("Frame", {Name = "Regen", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -2), Size = UDim2.new(1, -20, 0, 3), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, Visible = false, ZIndex = 4, (ui.Corner(2)), Parent = ui4})
        local v66 = {tool = nil, weaponId = nil, holder = ui3, face = ui4, stroke = stroke, icon = icon, key = key, ammo = ammo, pips = pips, reload = ui5, reloadFill = reloadFill, cool = ui6, coolFill = coolFill, regen = ui7, regenFill = ui.new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Bone, ZIndex = 4, (ui.Corner(2)), Parent = ui7}), timers = {}}
        v23[index] = v66
        ui3.Activated:Connect(
            function()
                --[[
                  line: 261
                  upvalues:
                    equip (ref,  index: 1)
                    index (copy, index: 2)
                ]]
                equip(index)
            end
        )

        ui3.MouseEnter:Connect(
            function()
                --[[
                  line: 264
                  upvalues:
                    v66 (copy, index: 1)
                    v24 (ref,  index: 2)
                    index (copy, index: 3)
                    ui (copy, index: 4)
                    stroke (copy, index: 5)
                    theme (copy, index: 6)
                ]]
                if v66.tool and v24 ~= index then
                    ui.Tween(stroke, theme.Tween.Fast, {Transparency = 0.35})
                end
            end
        )

        ui3.MouseLeave:Connect(
            function()
                --[[
                  line: 269
                  upvalues:
                    v24 (ref,  index: 1)
                    index (copy, index: 2)
                    ui (copy, index: 3)
                    stroke (copy, index: 4)
                    theme (copy, index: 5)
                ]]
                if v24 ~= index then
                    ui.Tween(stroke, theme.Tween.Fast, {Transparency = 0.7})
                end
            end
        )
    end

    layout()
    ui.LayoutChanged:Connect(layout)

    local function slotOfTool(a68)
        --[[
          name: slotOfTool
          line: 279
          upvalues:
            v7 (copy, index: 1)
        ]]
        local slotIndex = a68:GetAttribute("SlotIndex")

        if type(slotIndex) == "number" and 1 <= slotIndex and slotIndex <= 6 then
            return slotIndex
        end

        local slot = a68:GetAttribute("Slot")

        if type(slot) ~= "string" then
            return nil
        end

        return v7[slot]
    end

    local v71 = nil

    local function srcBackpack()
        --[[
          name: srcBackpack
          line: 292
          upvalues:
            v71 (ref,  index: 1)
            localPlayer (copy, index: 2)
        ]]
        if v71 then
            return v71.backpack
        end

        return (localPlayer:FindFirstChildOfClass("Backpack"))
    end

    local function srcCharacter()
        --[[
          name: srcCharacter
          line: 295
          upvalues:
            v71 (ref,  index: 1)
            localPlayer (copy, index: 2)
        ]]
        if v71 then
            return v71.character
        end

        return localPlayer.Character
    end

    local function toolsBySlot()
        --[[
          name: toolsBySlot
          line: 299
          upvalues:
            v7 (copy, index: 1)
            v71 (ref,  index: 2)
            localPlayer (copy, index: 3)
        ]]
        local v75 = {}

        local function scan(a77)
            --[[
              name: scan
              line: 301
              upvalues:
                v7 (copy, index: 1)
                v75 (copy, index: 2)
            ]]
            if not a77 then
                return
            end

            for _, child in a77:GetChildren() do
                if child:IsA("Tool") then
                    local v80 = child:GetAttribute("SlotIndex")

                    if type(v80) ~= "number" or not (1 <= v80) or not (v80 <= 6) then
                        local slot = child:GetAttribute("Slot")

                        if type(slot) == "string" then
                            v80 = v7[slot]
                        else
                            v80 = nil
                        end
                    end

                    if not v80 then
                        continue
                    end

                    v75[v80] = child
                end
            end
        end

        local backpack = if v71 then v71.backpack else localPlayer:FindFirstChildOfClass("Backpack")
        scan(backpack)
        local character = if v71 then v71.character else localPlayer.Character
        scan(character)

        return v75
    end

    local function heldSlot()
        --[[
          name: heldSlot
          line: 319
          upvalues:
            v71 (ref,  index: 1)
            localPlayer (copy, index: 2)
            v7 (copy, index: 3)
        ]]
        local v85
        local character = if v71 then v71.character else localPlayer.Character
        local tool = character and character:FindFirstChildOfClass("Tool")
        if not tool then
            return 0
        end

        local slotIndex = tool:GetAttribute("SlotIndex")

        if type(slotIndex) == "number" and 1 <= slotIndex and slotIndex <= 6 then
            v85 = slotIndex
        else
            local slot = tool:GetAttribute("Slot")

            if type(slot) ~= "string" then
                v85 = nil
            else
                v85 = v7[slot]
            end
        end

        return v85 or 0
    end

    local function setPips(pips, a92, a93)
        --[[
          name: setPips
          line: 325
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
        ]]
        local v94 = {}

        for _, child in pips.pips:GetChildren() do
            if child:IsA("Frame") then
                table.insert(v94, child)
            end
        end

        for layoutOrder = #v94 + 1, a93 do
            table.insert(v94, ui.new("Frame", {Size = UDim2.fromOffset(12, 6), BackgroundColor3 = colors.Accent, LayoutOrder = layoutOrder, ZIndex = 4, ui.Corner(3), (ui.Stroke(colors.Void, 1, 0.4)), Parent = pips.pips}))
        end

        for v98, v99 in v94 do
            local v100
            v99.Visible = v98 <= a93

            if v98 <= a92 then
                v100 = colors.Accent
            else
                v100 = Color3.fromRGB(60, 64, 78)
            end

            v99.BackgroundColor3 = v100
        end
    end

    local renderSteppedConnection = nil

    local function stepTimers()
        --[[
          name: stepTimers
          line: 352
          upvalues:
            state (copy, index: 1)
            v23 (copy, index: 2)
            renderSteppedConnection (ref,  index: 3)
        ]]
        local v103 = state.Now()
        local v104 = false

        for _, v106 in v23 do
            for timerKey, timer in v106.timers do
                local v109 = timer.endsAt - v103
                local v110 = not (0 < timer.total) and 1 or 1 - math.clamp(v109 / timer.total, 0, 1)

                if timerKey == "reload" then
                    v106.reloadFill.Size = UDim2.fromScale(1, v110)
                elseif timerKey == "cooldown" then
                    v106.coolFill.Size = UDim2.fromScale(1, 1 - v110)
                elseif timerKey == "regen" then
                    v106.regenFill.Size = UDim2.fromScale(v110, 1)
                end

                if not (v109 <= 0) then
                    v104 = true
                else
                    v106.timers[timerKey] = nil

                    if timerKey == "cooldown" then
                        v106.cool.Visible = false
                    elseif timerKey == "regen" then
                        v106.regen.Visible = false
                    end
                end
            end
        end

        if not v104 and renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end
    end

    local v111 = function(pips, timerKey, endsAt)
        --[[
          line: 383
          upvalues:
            state (copy, index: 1)
            renderSteppedConnection (ref,  index: 2)
            runService (copy, index: 3)
            stepTimers (copy, index: 4)
        ]]
        local v115 = state.Now()
        local visible = type(endsAt) == "number" and v115 < endsAt
        local timer = pips.timers[timerKey]

        if visible then
            if not timer or 0.01 < math.abs(timer.endsAt - endsAt) then
                pips.timers[timerKey] = {endsAt = endsAt, total = math.max(0.1, endsAt - v115)}
            end
        else
            pips.timers[timerKey] = nil
        end

        if timerKey == "cooldown" then
            pips.cool.Visible = visible
        elseif timerKey == "regen" then
            pips.regen.Visible = visible
        elseif timerKey == "reload" and not visible then
            local reloadFill = pips.reloadFill
            local udim2FromScale = UDim2.fromScale
            local v120 = pips.reload.Visible and 1 or 0
            reloadFill.Size = udim2FromScale(1, v120)
        end

        if visible and not renderSteppedConnection then
            renderSteppedConnection = runService.RenderStepped:Connect(stepTimers)
        end
    end

    local success, Weapons = pcall(
        function()
            --[[
              line: 415
            ]]
            return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Weapons")))
        end
    )

    if success then
        if type(Weapons) ~= "table" then
            v10 = v11
        elseif type(Weapons.AltAmmo) ~= "function" then
            v10 = v11
        else
            v10 = Weapons.AltAmmo
        end
    else
        v10 = v11
    end

    reserveOf = function(a123)
        --[[
          name: reserveOf
          line: 422
          upvalues:
            v71 (ref,  index: 1)
            localPlayer (copy, index: 2)
            v10 (ref,  index: 3)
        ]]
        local v124

        if not a123 then
            return nil
        end

        local v125 = if v71 then v71.model else localPlayer.Character

        local function pool(a127)
            --[[
              name: pool
              line: 427
              upvalues:
                v125 (copy, index: 1)
                localPlayer (copy, index: 2)
            ]]
            local v128 = v125 and v125:GetAttribute("Ammo_" .. a127)

            if type(v128) ~= "number" then
                v128 = localPlayer:GetAttribute("Ammo_" .. a127)
            end

            if type(v128) ~= "number" then
                return nil
            end

            return v128
        end

        local v129 = v125 and v125:GetAttribute("Ammo_" .. a123)

        if type(v129) ~= "number" then
            v129 = localPlayer:GetAttribute("Ammo_" .. a123)
        end

        if type(v129) ~= "number" then
            v124 = nil
        else
            v124 = v129
        end

        for _, v131 in v10(a123) do
            local v132
            local v133 = v125 and v125:GetAttribute("Ammo_" .. v131)

            if type(v133) ~= "number" then
                v133 = localPlayer:GetAttribute("Ammo_" .. v131)
            end

            if type(v133) == "number" then
                v132 = v133
            else
                v132 = nil
            end

            if v132 then
                v124 = (v124 or 0) + v132
            end
        end

        return v124
    end

    hotbar.ReserveOf = reserveOf

    local function refreshState(key)
        --[[
          name: refreshState
          line: 445
          upvalues:
            v23 (copy, index: 1)
            v111 (ref,  index: 2)
            weaponInfo (copy, index: 3)
            reserveOf (copy, index: 4)
            setPips (copy, index: 5)
            colors (copy, index: 6)
            ui (copy, index: 7)
        ]]
        local pips = v23[key]
        local tool = pips.tool
        if not tool then
            pips.ammo.Text = ""
            pips.pips.Visible = false
            pips.reload.Visible = false

            for timerKey in pips.timers do
                v111(pips, timerKey, nil)
            end

            return
        end

        local v139
        local v140
        local ammo = tool:GetAttribute("Ammo")
        local maxAmmo = tool:GetAttribute("MaxAmmo")
        local charges = tool:GetAttribute("Charges")
        local maxCharges = tool:GetAttribute("MaxCharges")

        if type(ammo) ~= "number" then
            if type(charges) ~= "number" then
                v139 = nil
            else
                v139 = charges
            end
        else
            v139 = ammo
        end

        if type(ammo) ~= "number" then
            if type(maxCharges) ~= "number" then
                v140 = nil
            else
                v140 = maxCharges
            end
        elseif type(maxAmmo) ~= "number" then
            v140 = nil
        else
            v140 = maxAmmo
        end

        if const v145 = reserveOf((weaponInfo.AmmoOf(pips.weaponId))) then
            v139, v140 = v145, nil
        end

        if v139 then
            if not v140 or not (v140 <= 6) or not (1 < v140) then
                pips.pips.Visible = false
                pips.ammo.Text = tostring(v139)
            else
                pips.pips.Visible = true
                pips.ammo.Text = ""
                setPips(pips, v139, v140)
            end

            pips.ammo.TextColor3 = if v139 <= 0 then colors.Danger else colors.Text

            if pips.lastAmmo and v139 < pips.lastAmmo then
                ui.Bump(pips.ammo, 0.2)
            end

            pips.lastAmmo = v139
        else
            pips.ammo.Text = ""
            pips.pips.Visible = false
            pips.lastAmmo = nil
        end

        local reloading = tool:GetAttribute("Reloading") == true

        if reloading ~= pips.reload.Visible then
            pips.reload.Visible = reloading

            if not reloading and v139 and 0 < v139 then
                ui.Pop(pips.ammo, 1.4)
            end
        end

        local v147 = v111
        local v148 = if reloading then tool:GetAttribute("ReloadEndsAt") else nil
        v147(pips, "reload", v148)
        v111(pips, "cooldown", tool:GetAttribute("Cooldown"))
        local v149 = type(charges) == "number" and type(maxCharges) == "number" and maxCharges <= charges
        local v150 = v111
        local v151 = if v149 then nil else tool:GetAttribute("NextCharge")
        v150(pips, "regen", v151)
    end

    local function paintSelection(a153: boolean)
        --[[
          name: paintSelection
          line: 503
          upvalues:
            v23 (copy, index: 1)
            v24 (ref,  index: 2)
            ui (copy, index: 3)
            theme (copy, index: 4)
            colors (copy, index: 5)
            weaponIcon (copy, index: 6)
        ]]
        for v154, v155 in v23 do
            local v156 = v154 == v24
            local v157 = v155.tool ~= nil
            local v158 = UDim2.fromOffset
            local offset = v155.holder.Position.X.Offset
            local v160 = v156 and 0 or 12
            v158 = v158(offset, v160)

            if a153 then
                ui.Tween(v155.holder, theme.Tween.PopSmall, {Position = v158})
            else
                v155.holder.Position = v158
            end

            v155.stroke.Color = if v156 then colors.Accent else colors.Stroke
            v155.stroke.Thickness = v156 and 3 or 2
            v155.stroke.Transparency = v156 and 0 or 0.7
            v155.face.BackgroundTransparency = v156 and 0.05 or v157 and 0.2 or 0.5
            weaponIcon.SetDim(v155.icon, not v157)
        end
    end

    local function rebuild()
        --[[
          name: rebuild
          line: 521
          upvalues:
            toolsBySlot (copy, index: 1)
            v23 (copy, index: 2)
            refreshState (copy, index: 3)
            v24 (ref,  index: 4)
            hotbar (copy, index: 5)
            weaponIcon (copy, index: 6)
            v71 (ref,  index: 7)
            localPlayer (copy, index: 8)
            v7 (copy, index: 9)
            v25 (ref,  index: 10)
            v26 (ref,  index: 11)
            paintSelection (copy, index: 12)
            a8 (copy, index: 13)
            ui (copy, index: 14)
            v21 (copy, index: 15)
            state (copy, index: 16)
            weaponInfo (copy, index: 17)
            uiStroke (copy, index: 18)
            theme (copy, index: 19)
            v27 (ref,  index: 20)
            layout (copy, index: 21)
        ]]
        local v162
        local v163 = toolsBySlot()
        local hasTools = false

        for key, v166 in v23 do
            local tool = v163[key]

            if tool ~= v166.tool then
                if v166.conn then
                    v166.conn:Disconnect()
                    v166.conn = nil
                end

                v166.reload.Visible = false
                v166.lastAmmo = nil
                v166.tool = tool

                if tool then
                    v166.conn = tool.AttributeChanged:Connect(
                        function()
                            --[[
                              line: 535
                              upvalues:
                                refreshState (copy, index: 1)
                                key (copy, index: 2)
                                v24 (ref,  index: 3)
                                hotbar (copy, index: 4)
                            ]]
                            refreshState(key)

                            if key == v24 and hotbar.RefreshCrosshairAmmo then
                                hotbar.RefreshCrosshairAmmo()
                            end
                        end
                    )
                end
            end

            local v168 = tool and tool:GetAttribute("WeaponId")

            if type(v168) ~= "string" then
                v168 = if tool then tool.Name else nil
            end

            if v168 ~= v166.weaponId then
                v166.weaponId = v168
                weaponIcon.Set(v166.icon, v168)
            end

            refreshState(key)

            if tool then
                hasTools = true
            end
        end

        local character = if v71 then v71.character else localPlayer.Character

        if const tool = character and character:FindFirstChildOfClass("Tool") then
            local v171
            local slotIndex = tool:GetAttribute("SlotIndex")

            if type(slotIndex) == "number" and 1 <= slotIndex and slotIndex <= 6 then
                v171 = slotIndex
            else
                local slot = tool:GetAttribute("Slot")

                if type(slot) ~= "string" then
                    v171 = nil
                else
                    v171 = v7[slot]
                end
            end

            v162 = v171 or 0
        else
            v162 = 0
        end

        local v174 = if v162 ~= 0 then v23[v162].weaponId else nil

        if v162 == v24 and v174 == v25 then
            paintSelection(false)
        else
            if v24 ~= 0 and v162 ~= v24 then
                v26 = v24
            end

            v24 = v162
            v25 = v174
            paintSelection(true)
            a8.HeldWeaponChanged:Fire(v174)

            if v162 ~= 0 and v23[v162].tool then
                local v175 = v23[v162]
                ui.Pop(v175.icon, 0.8)
                local newUDim2 = UDim2.new
                local v177 = state.InMatch() and -70 or -4
                v21.Position = newUDim2(0.5, 0, 0, v177)
                v21.Text = string.upper(weaponInfo.Name(v175.weaponId))
                v21.TextTransparency = 0
                uiStroke.Transparency = 0.1

                task.delay(
                    1.1,
                    function()
                        --[[
                          line: 573
                          upvalues:
                            v24 (ref,  index: 1)
                            v162 (copy, index: 2)
                            ui (copy, index: 3)
                            v21 (copy, index: 4)
                            theme (copy, index: 5)
                            uiStroke (copy, index: 6)
                        ]]
                        if v24 == v162 then
                            ui.Tween(v21, theme.Tween.Slow, {TextTransparency = 1})
                            ui.Tween(uiStroke, theme.Tween.Slow, {Transparency = 1})
                        end
                    end
                )
            end
        end

        hotbar.HasTools = hasTools
        local v178 = 0

        for v179, v180 in v23 do
            if v180.tool then
                v178 = v179
            end
        end

        local v181 = math.max(v178, 1)

        if v181 ~= v27 then
            v27 = v181
            layout()
            a8.HotbarChanged:Fire()
        end

        hotbar.RefreshVisible()
    end

    local isBusy = false

    local function queueRebuild()
        --[[
          name: queueRebuild
          line: 600
          upvalues:
            isBusy (ref,  index: 1)
            rebuild (copy, index: 2)
        ]]
        if isBusy then
            return
        end

        isBusy = true

        task.defer(
            function()
                --[[
                  line: 605
                  upvalues:
                    isBusy (ref,  index: 1)
                    rebuild (copy, index: 2)
                ]]
                isBusy = false
                rebuild()
            end
        )
    end

    local v184 = {}

    local function watch(a186)
        --[[
          name: watch
          line: 612
          upvalues:
            v184 (copy, index: 1)
            queueRebuild (copy, index: 2)
        ]]
        if not a186 then
            return
        end

        table.insert(v184, a186.ChildAdded:Connect(queueRebuild))
        table.insert(v184, a186.ChildRemoved:Connect(queueRebuild))
    end

    local function rewatch()
        --[[
          name: rewatch
          line: 619
          upvalues:
            v184 (copy, index: 1)
            v71 (ref,  index: 2)
            localPlayer (copy, index: 3)
            queueRebuild (copy, index: 4)
            isBusy (ref,  index: 5)
            rebuild (copy, index: 6)
        ]]
        local character

        for _, v190 in v184 do
            v190:Disconnect()
        end

        table.clear(v184)

        if const backpack = if v71 then v71.backpack else localPlayer:FindFirstChildOfClass("Backpack") then
            table.insert(v184, backpack.ChildAdded:Connect(queueRebuild))
            table.insert(v184, backpack.ChildRemoved:Connect(queueRebuild))
        end

        if v71 then
            character = v71.character
        else
            character = localPlayer.Character
        end

        if character then
            table.insert(v184, character.ChildAdded:Connect(queueRebuild))
            table.insert(v184, character.ChildRemoved:Connect(queueRebuild))
        end

        if isBusy then
            return
        end

        isBusy = true

        task.defer(
            function()
                --[[
                  line: 605
                  upvalues:
                    isBusy (ref,  index: 1)
                    rebuild (copy, index: 2)
                ]]
                isBusy = false
                rebuild()
            end
        )
    end

    localPlayer.ChildAdded:Connect(
        function(child: Instance)
            --[[
              line: 628
              upvalues:
                rewatch (copy, index: 1)
            ]]
            if child:IsA("Backpack") then
                rewatch()
            end
        end
    )

    local parent = ui.new("Frame", {Name = "CrosshairAmmo", Visible = false, AnchorPoint = Vector2.new(0, 0), Position = UDim2.new(0.5, 34, 0.5, 26), Size = UDim2.fromOffset(240, 26), Parent = a8.Canvas.HUD})
    local v194 = ui.DisplayText({Name = "Count", Text = "12", TextSize = 22, StrokeThickness = 1.5, Size = UDim2.fromOffset(60, 26), TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local v195 = ui.DisplayText({Name = "Out", Text = "OUT OF ARROWS", TextSize = 18, StrokeThickness = 1.5, Visible = false, Size = UDim2.fromOffset(240, 26), TextColor3 = colors.Danger, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local v196 = -1

    local function refreshCrosshairAmmo()
        --[[
          name: refreshCrosshairAmmo
          line: 665
          upvalues:
            v24 (ref,  index: 1)
            v23 (copy, index: 2)
            weaponInfo (copy, index: 3)
            reserveOf (copy, index: 4)
            a8 (copy, index: 5)
            ui2 (copy, index: 6)
            parent (copy, index: 7)
            v196 (ref,  index: 8)
            v195 (copy, index: 9)
            v194 (copy, index: 10)
            colors (copy, index: 11)
            ui (copy, index: 12)
        ]]
        local v198 = if v24 ~= 0 then v23[v24] else nil
        local v199 = v198 and weaponInfo.AmmoOf(v198.weaponId)
        local v200 = reserveOf(v199)
        local v201 = a8.PlayerGui:FindFirstChild("CombatHUD") ~= nil
        local visible = ui2.Visible and v200 ~= nil and not v201
        parent.Visible = visible

        if not visible or not v198 then
            v196 = -1
            return
        end

        local v203
        local v204
        local v205 = v198.tool
        v205 = v205 and v205:GetAttribute("Ammo")

        if type(v205) ~= "number" then
            v203 = 0
        else
            v203 = v205
        end

        local v206 = v200 + v203
        local v207 = weaponInfo.AmmoDef(v199)
        local stringUpper = string.upper
        local name = v207 and v207.name or "AMMO"
        v195.Text = "OUT OF " .. stringUpper(name)
        v195.Visible = v206 <= 0
        v194.Visible = 0 < v206
        v194.Text = tostring(v206)

        if not (v206 <= 3) then
            v204 = colors.Text
        else
            v204 = colors.Warning
        end

        v194.TextColor3 = v204

        if v206 ~= v196 then
            if v206 < v196 and 0 < v206 then
                ui.Bump(v194, 0.15)
            elseif v206 <= 0 and 0 < v196 then
                ui.Pop(v195, 1.3)
            end

            v196 = v206
        end
    end

    hotbar.RefreshCrosshairAmmo = refreshCrosshairAmmo
    a8.HeldWeaponChanged:Connect(refreshCrosshairAmmo)
    local v210 = {}

    local function hookAmmoAttrs(a212)
        --[[
          name: hookAmmoAttrs
          line: 698
          upvalues:
            v210 (copy, index: 1)
            v23 (copy, index: 2)
            refreshState (copy, index: 3)
            refreshCrosshairAmmo (copy, index: 4)
            localPlayer (copy, index: 5)
        ]]
        for _, v214 in v210 do
            v214:Disconnect()
        end

        table.clear(v210)

        local function onAttr(text: string)
            --[[
              name: onAttr
              line: 703
              upvalues:
                v23 (copy, index: 1)
                refreshState (copy, index: 2)
                refreshCrosshairAmmo (copy, index: 3)
            ]]
            if string.sub(text, 1, 5) == "Ammo_" then
                for key in v23 do
                    refreshState(key)
                end

                refreshCrosshairAmmo()
            end
        end

        if a212 then
            table.insert(v210, a212.AttributeChanged:Connect(onAttr))
        end

        table.insert(v210, localPlayer.AttributeChanged:Connect(onAttr))
    end

    hookAmmoAttrs(localPlayer.Character)

    localPlayer.CharacterAdded:Connect(
        function(character: Model)
            --[[
              line: 718
              upvalues:
                rewatch (copy, index: 1)
                hookAmmoAttrs (copy, index: 2)
                hotbar (copy, index: 3)
            ]]
            task.defer(rewatch)
            hookAmmoAttrs(character)
            local humanoid = character:WaitForChild("Humanoid", 10)

            if humanoid and humanoid:IsA("Humanoid") then
                humanoid.Died:Connect(
                    function()
                        --[[
                          line: 723
                          upvalues:
                            hotbar (copy, index: 1)
                        ]]
                        hotbar.RefreshVisible()
                    end
                )
            end
        end
    )

    rewatch()

    local function humanoid()
        --[[
          name: humanoid
          line: 731
          upvalues:
            localPlayer (copy, index: 1)
        ]]
        local character = localPlayer.Character
        return character and character:FindFirstChildOfClass("Humanoid")
    end

    local result = nil

    local function combat()
        --[[
          name: combat
          line: 739
          upvalues:
            result (ref,  index: 1)
            localPlayer (copy, index: 2)
        ]]
        if result == nil then
            local instance = localPlayer:FindFirstChildOfClass("PlayerScripts")
            instance = instance and instance:FindFirstChild("Combat")
            local controller = instance and instance:FindFirstChild("Controller")

            if controller and controller:IsA("ModuleScript") then
                local success, result2 = pcall(require, controller)

                if not success or type(result2) ~= "table" or type(result2.Equip) ~= "function" then
                    result = false
                else
                    result = result2
                end
            end
        end

        return result or nil
    end

    equip = function(key)
        --[[
          line: 752
          upvalues:
            v23 (copy, index: 1)
            ui (copy, index: 2)
            localPlayer (copy, index: 3)
            v71 (ref,  index: 4)
            combat (copy, index: 5)
            isBusy (ref,  index: 6)
            rebuild (copy, index: 7)
        ]]
        local v229 = v23[key]

        if v229 and v229.tool then
            local character = localPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if not humanoid or humanoid.Health <= 0 or v71 then
                return
            end

            local v232 = combat()
            local v233 = v229.tool.Parent == localPlayer.Character

            if v232 and type(v232.Wanted) == "function" then
                v233 = v233 and v232.Wanted() == v229.tool
            end

            if v233 then
                ui.Bump(v229.icon, 0.1)
                return
            end

            if v232 then
                v232.Equip(v229.tool)
            else
                humanoid:EquipTool(v229.tool)
            end

            if isBusy then
                return
            end

            isBusy = true

            task.defer(
                function()
                    --[[
                      line: 605
                      upvalues:
                        isBusy (ref,  index: 1)
                        rebuild (copy, index: 2)
                    ]]
                    isBusy = false
                    rebuild()
                end
            )

            return
        end

        if v229 then
            ui.Shake(v229.holder, 4)
        end
    end

    hotbar.Equip = equip

    a8.Debug.equip = function(a234)
        --[[
          line: 781
          upvalues:
            equip (ref,  index: 1)
            v71 (ref,  index: 2)
            localPlayer (copy, index: 3)
            v7 (copy, index: 4)
        ]]
        local v235
        equip(a234)
        local character = if v71 then v71.character else localPlayer.Character
        local tool = character and character:FindFirstChildOfClass("Tool")
        if not tool then
            return 0
        end

        local slotIndex = tool:GetAttribute("SlotIndex")

        if type(slotIndex) == "number" and 1 <= slotIndex and slotIndex <= 6 then
            v235 = slotIndex
        else
            local slot = tool:GetAttribute("Slot")

            if type(slot) ~= "string" then
                v235 = nil
            else
                v235 = v7[slot]
            end
        end

        return v235 or 0
    end

    local function cycle(a241)
        --[[
          name: cycle
          line: 786
          upvalues:
            v24 (ref,  index: 1)
            v23 (copy, index: 2)
            equip (ref,  index: 3)
        ]]
        local v242

        if v24 ~= 0 then
            v242 = v24
        else
            v242 = not (0 < a241) and 7 or 0
        end

        local v243

        for index = 1, 6 do
            v243 = (v242 - 1 + (a241 * index)) % 6 + 1

            if v23[v243].tool then
                equip(v243)
                return
            end
        end
    end

    local function inputBlocked(a246)
        --[[
          name: inputBlocked
          line: 797
          upvalues:
            userInputService (copy, index: 1)
            a8 (copy, index: 2)
            ui2 (copy, index: 3)
        ]]
        if a246 or userInputService:GetFocusedTextBox() then
            return true
        end
        if not a8.MenuManager.RecentlyOpen(0.2) and not a8.HudHidden then
            return not ui2.Visible
        end

        return true
    end

    local function equipLast()
        --[[
          name: equipLast
          line: 807
          upvalues:
            v26 (ref,  index: 1)
            v24 (ref,  index: 2)
            v23 (copy, index: 3)
            equip (ref,  index: 4)
        ]]
        if v26 ~= 0 and v26 ~= v24 and v23[v26].tool then
            equip(v26)
        end
    end

    Keybinds.OnInput(
        "Began",
        function(a248, a249)
            --[[
              line: 812
              upvalues:
                Keybinds (copy, index: 1)
                userInputService (copy, index: 2)
                a8 (copy, index: 3)
                ui2 (copy, index: 4)
                v26 (ref,  index: 5)
                v24 (ref,  index: 6)
                v23 (copy, index: 7)
                equip (ref,  index: 8)
                cycle (copy, index: 9)
                v6 (copy, index: 10)
            ]]
            local isPad = Keybinds.IsPad(a248, "PrevItem")
            local isPad2 = Keybinds.IsPad(a248, "NextItem")
            local isPad3 = Keybinds.IsPad(a248, "LastItem")

            if not isPad and not isPad2 and not isPad3 then
                local v253 = Keybinds.ActionOf(a248)

                if not v253
                    or a249
                    or userInputService:GetFocusedTextBox()
                    or a8.MenuManager.RecentlyOpen(0.2)
                    or a8.HudHidden
                    or not ui2.Visible
                then
                    return
                elseif const v254 = v6[v253] then
                    equip(v254)
                    return
                end

                if v253 == "LastItem" and v26 ~= 0 and v26 ~= v24 and v23[v26].tool then
                    equip(v26)
                end

                return
            end

            local v255 = not not (userInputService:GetFocusedTextBox()
                or a8.MenuManager.RecentlyOpen(0.2)
                or a8.HudHidden
                or not ui2.Visible)

            if v255 or a8.MenuManager.PadBlocked() then
                return
            end

            if isPad3 then
                if v26 ~= 0 and v26 ~= v24 and v23[v26].tool then
                    equip(v26)
                end
            else
                local v256 = isPad and -1 or 1
                cycle(v256)
            end
        end
    )

    userInputService.InputChanged:Connect(
        function(input: InputObject, gameProcessedEvent: boolean)
            --[[
              line: 839
              upvalues:
                userInputService (copy, index: 1)
                a8 (copy, index: 2)
                ui2 (copy, index: 3)
                cycle (copy, index: 4)
            ]]
            if input.UserInputType == Enum.UserInputType.MouseWheel
                and not gameProcessedEvent
                and not userInputService:GetFocusedTextBox()
                and not a8.MenuManager.RecentlyOpen(0.2)
                and not a8.HudHidden
                and ui2.Visible
            then
                local v259 = not (0 < input.Position.Z) and 1 or -1
                cycle(v259)
            end
        end
    )

    function hotbar.RefreshVisible()
        --[[
          name: RefreshVisible
          line: 846
          upvalues:
            hotbar (copy, index: 1)
            a8 (copy, index: 2)
            state (copy, index: 3)
            v71 (ref,  index: 4)
            ui2 (copy, index: 5)
            ui (copy, index: 6)
            theme (copy, index: 7)
        ]]
        local v260 = hotbar.HasTools == true
            and not a8.HudHidden
            and state.IsAlive()
            and state.Get("CombatMode") ~= false
            and not state.Watching()

        if v71 then
            v260 = hotbar.HasTools == true
        end

        if hotbar.RefreshCrosshairAmmo then
            task.defer(hotbar.RefreshCrosshairAmmo)
        end

        if v260 ~= ui2.Visible then
            ui2.Visible = v260

            if v260 then
                ui.SlideIn(ui2, Vector2.new(0, 30), theme.Tween.PopSmall)
            end
        end
    end

    a8.HudHiddenChanged:Connect(hotbar.RefreshVisible)

    state.AttrChanged:Connect(
        function(a261)
            --[[
              line: 864
              upvalues:
                hotbar (copy, index: 1)
            ]]
            if a261 == "Alive" or a261 == "State" or a261 == "CombatMode" or a261 == "Spectating" then
                hotbar.RefreshVisible()
            end
        end
    )

    function hotbar.SetReplaySource(replaySource)
        --[[
          name: SetReplaySource
          line: 870
          upvalues:
            v71 (ref,  index: 1)
            rewatch (copy, index: 2)
            hookAmmoAttrs (copy, index: 3)
            localPlayer (copy, index: 4)
            hotbar (copy, index: 5)
        ]]
        v71 = replaySource
        rewatch()
        local v263 = if replaySource then replaySource.model else localPlayer.Character
        hookAmmoAttrs(v263)
        hotbar.RefreshVisible()
    end

    a8.Hotbar = hotbar
    a8.HotbarRoot = ui2
end

return hotbar