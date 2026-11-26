local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local Keybinds = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Keybinds"))

return {
    Init = (function(a6)
        --[[
          name: Init
          line: 36
          upvalues:
            players (copy, index: 1)
            replicatedStorage (copy, index: 2)
            runService (copy, index: 3)
            Keybinds (copy, index: 4)
            userInputService (copy, index: 5)
        ]]
        local ui = a6.UI
        local theme = a6.Theme
        local state = a6.State
        local weaponIcon = a6.WeaponIcon
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local loadoutSwapCutoff = 0.3
        local config = replicatedStorage.Shared:FindFirstChild("Config")

        local success, result = pcall(
            function()
                --[[
                  line: 44
                  upvalues:
                    config (copy, index: 1)
                ]]
                if config then
                    return (require(config))
                end

                return nil
            end
        )

        if success and type(result) == "table" and type(result.LOADOUT_SWAP_CUTOFF) == "number" then
            loadoutSwapCutoff = result.LOADOUT_SWAP_CUTOFF
        end

        local v18 = loadoutSwapCutoff + 0.12
        local v19 = loadoutSwapCutoff + 0.25
        local parent = ui.new("Frame", {Name = "LoadoutSwap", Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(800, 90), Parent = a6.Canvas.HUD})
        local parent2 = ui.new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, 22), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
        local v22 = ui.ActionCap("NextLoadout", {Height = 20, LayoutOrder = 1, Parent = parent2})
        local parent3 = ui.new("TextLabel", {Name = "Title", Text = "SWITCH LOADOUT", TextSize = 15, LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent2})
        local v24 = ui.TextStroke(colors.Void, 1.5, 0.35)
        v24.Parent = parent3
        local parent4 = ui.new("Frame", {Name = "Cards", Position = UDim2.fromOffset(0, 26), Size = UDim2.new(1, 0, 0, 58), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
        local v26 = {}
        local v27 = nil
        local paint2 = nil
        local v29 = false

        for layoutOrder = 1, 5 do
            local ui2 = ui.new("TextButton", {Name = "Slot" .. layoutOrder, Size = UDim2.fromOffset(128, 60), Text = "", AutoButtonColor = false, BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.25, LayoutOrder = layoutOrder, (ui.Corner(10)), Parent = parent4})
            local stroke = ui.Stroke(colors.Stroke, 1.5, 0.82)
            stroke.Parent = ui2
            local ui3 = ui.new("TextLabel", {Name = "Num", TextSize = 15, ZIndex = 3, Position = UDim2.fromOffset(7, 3), Size = UDim2.fromOffset(16, 16), Text = tostring(layoutOrder), FontFace = fonts.Display, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui2})
            local numStroke = ui.TextStroke(colors.Void, 1.5, 0.3)
            numStroke.Parent = ui3
            local ui4 = ui.new("Frame", {Name = "Icons", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.new(1, -10, 0, 40), (ui.List(Enum.FillDirection.Horizontal, 2, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = ui2})
            local holders = {}

            for layoutOrder2 = 1, 3 do
                holders[layoutOrder2] = ui.new("Frame", {Visible = false, ZIndex = 2, Name = "I" .. layoutOrder2, Size = UDim2.fromOffset(38, 38), LayoutOrder = layoutOrder2, Parent = ui4})
            end

            local ui5 = ui.new("TextLabel", {Name = "More", Text = "", TextSize = 13, Visible = false, ZIndex = 3, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -6, 1, -2), Size = UDim2.fromOffset(30, 16), FontFace = fonts.Display, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = ui2})
            local moreStroke = ui.TextStroke(colors.Void, 1.5, 0.3)
            moreStroke.Parent = ui5
            local v40 = {sig = nil, hover = false, btn = ui2, stroke = stroke, num = ui3, numStroke = numStroke, icons = ui4, holders = holders, more = ui5, moreStroke = moreStroke}
            v26[layoutOrder] = v40
            ui2.Activated:Connect(
                function()
                    --[[
                      line: 164
                      upvalues:
                        v27 (ref,  index: 1)
                        layoutOrder (copy, index: 2)
                    ]]
                    v27(layoutOrder, "tap")
                end
            )

            ui2.MouseEnter:Connect(
                function()
                    --[[
                      line: 167
                      upvalues:
                        v40 (copy, index: 1)
                        paint2 (ref,  index: 2)
                    ]]
                    v40.hover = true

                    if paint2 then
                        paint2()
                    end
                end
            )

            ui2.MouseLeave:Connect(
                function()
                    --[[
                      line: 173
                      upvalues:
                        v40 (copy, index: 1)
                        paint2 (ref,  index: 2)
                    ]]
                    v40.hover = false

                    if paint2 then
                        paint2()
                    end
                end
            )

            for _, v42 in holders do
                v42.ChildAdded:Connect(
                    function()
                        --[[
                          line: 181
                          upvalues:
                            paint2 (ref, index: 1)
                            v29 (ref, index: 2)
                        ]]
                        if paint2 and not v29 then
                            v29 = true

                            task.defer(
                                function()
                                    --[[
                                      line: 184
                                      upvalues:
                                        v29 (ref, index: 1)
                                        paint2 (ref, index: 2)
                                    ]]
                                    v29 = false

                                    if paint2 then
                                        paint2()
                                    end
                                end
                            )
                        end
                    end
                )
            end
        end

        local count2 = 0
        local selected = 1
        local busy = 0
        local count = 0
        local v47 = nil

        local function slotCount()
            --[[
              name: slotCount
              line: 202
              upvalues:
                state (copy, index: 1)
            ]]
            if state.HasLoadoutSlots() then
                return (math.min(state.LoadoutSlotCount(), 5))
            end

            return 0
        end

        local function idsOf(a50: number)
            --[[
              name: idsOf
              line: 206
              upvalues:
                state (copy, index: 1)
            ]]
            local v51 = state.LoadoutSlot(a50)
            local v52 = {}
            local v53 = v51 and v51.items or {}

            for _, v55 in v53 do
                if type(v55) == "string" then
                    table.insert(v52, v55)
                end
            end

            if v51 and type(v51.armor) == "string" then
                table.insert(v52, v51.armor)
            end

            return v52
        end

        local v56 = {outline = false, glow = true, glowTransparency = 1, transparency = 0.98, glowColor = Color3.fromRGB(120, 132, 158)}

        local function fillCard(a58, a59: number)
            --[[
              name: fillCard
              line: 223
              upvalues:
                idsOf (copy, index: 1)
                weaponIcon (copy, index: 2)
                v56 (copy, index: 3)
            ]]
            local parts = idsOf(a59)
            local sig = table.concat(parts, ",")

            if a58.sig == sig then
                return
            end

            a58.sig = sig
            local v62 = math.min(#parts, 3)

            for v63, holder in a58.holders do
                local v65 = if v63 <= v62 then parts[v63] else nil
                holder.Visible = v65 ~= nil
                weaponIcon.Set(holder, v65, v56)
            end

            local more = a58.more
            local visible = v62 < #parts
            more.Visible = visible
            a58.more.Text = "+" .. tostring(#parts - v62)
        end

        local fade = 0
        local v69 = 0

        local function paint()
            --[[
              name: paint
              line: 243
              upvalues:
                fade (ref,  index: 1)
                v26 (copy, index: 2)
                count2 (ref,  index: 3)
                selected (ref,  index: 4)
                colors (copy, index: 5)
                theme (copy, index: 6)
                weaponIcon (copy, index: 7)
                parent3 (copy, index: 8)
                v24 (copy, index: 9)
                ui (copy, index: 10)
                v22 (copy, index: 11)
            ]]
            local v71 = fade
            local textTransparency = 1 - v71

            for v73, v74 in v26 do
                if not (count2 < v73) then
                    local v75
                    local v76 = v73 == selected
                    local btn = v74.btn

                    if v76 then
                        v75 = colors.Accent
                    else
                        v75 = if v74.hover then colors.PanelHi else colors.Panel
                    end

                    btn.BackgroundColor3 = v75
                    local btn2 = v74.btn
                    local v79 = v76 and 0.06 or 0.25
                    local v80 = v76 and 0.06 or 0.25
                    btn2.BackgroundTransparency = v79 + ((1 - v80) * textTransparency)
                    v74.stroke.Color = if v76 then theme.Lighten(colors.Accent, 0.45) else colors.Stroke
                    v74.stroke.Thickness = v76 and 2 or 1.5
                    local stroke = v74.stroke
                    local v82 = v76 and 0.15 or 0.82
                    local v83 = v76 and 0.15 or 0.82
                    stroke.Transparency = v82 + ((1 - v83) * textTransparency)
                    v74.num.TextColor3 = if v76 then colors.Text else colors.TextDim
                    v74.num.TextTransparency = textTransparency
                    v74.numStroke.Transparency = (textTransparency * 0.7) + 0.3
                    v74.more.TextColor3 = if v76 then colors.Text else colors.TextDim
                    v74.more.TextTransparency = textTransparency
                    v74.moreStroke.Transparency = (textTransparency * 0.7) + 0.3
                    v74.btn.Interactable = 0.5 <= v71

                    for _, holder in v74.holders do
                        if holder.Visible then
                            weaponIcon.SetTransparency(holder, textTransparency * 0.98)
                            local weaponGlow = holder:FindFirstChild("WeaponGlow")

                            if weaponGlow and weaponGlow:IsA("ImageLabel") then
                                weaponGlow.ImageTransparency = (textTransparency * 0.55) + 0.45
                            end
                        end
                    end
                end
            end

            parent3.TextTransparency = textTransparency
            v24.Transparency = (textTransparency * 0.65) + 0.35
            ui.SetCapFade(v22, textTransparency)
        end

        paint2 = paint

        local function layout()
            --[[
              name: layout
              line: 282
              upvalues:
                ui (copy, index: 1)
                count2 (ref,  index: 2)
                state (copy, index: 3)
                v26 (copy, index: 4)
                parent4 (copy, index: 5)
                parent2 (copy, index: 6)
                parent (copy, index: 7)
                a6 (copy, index: 8)
            ]]
            local compact = ui.Compact
            count2 = not state.HasLoadoutSlots() and 0 or math.min(state.LoadoutSlotCount(), 5)
            local v89 = compact and 108 or 128
            local v90 = compact and 44 or 60
            local v91 = compact and 30 or 38
            local v92 = compact and 6 or 8

            for v93, v94 in v26 do
                local btn = v94.btn
                btn.Visible = v93 <= count2
                v94.btn.Size = UDim2.fromOffset(v89, v90)
                v94.icons.Size = UDim2.new(1, -8, 0, v91 + 2)

                for _, holder in v94.holders do
                    holder.Size = UDim2.fromOffset(v91, v91)
                end
            end

            if const uiListLayout = parent4:FindFirstChildOfClass("UIListLayout") then
                uiListLayout.Padding = UDim.new(0, v92)
                uiListLayout.FillDirection = if compact then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal
            end

            local v99 = math.max(count2, 1)

            if compact then
                parent2.Visible = false
                parent4.Position = UDim2.new()
                parent4.Size = UDim2.fromScale(1, 1)
                parent.AnchorPoint = Vector2.new(0, 0.5)
                parent.Size = UDim2.fromOffset(v89, v99 * v90 + ((v99 - 1) * v92))
                parent.Position = UDim2.new(0, 12, 0.45, 0)

                return
            end

            parent2.Visible = true
            parent4.Position = UDim2.fromOffset(0, 26)
            parent4.Size = UDim2.new(1, 0, 0, v90)
            parent.AnchorPoint = Vector2.new(0.5, 1)
            parent.Size = UDim2.fromOffset((v99 * v89) + ((v99 - 1) * v92), v90 + 26)
            local v100 = not a6.HotbarTop and 104 or a6.HotbarTop()
            parent.Position = UDim2.new(0.5, 0, 1, -(((v100 + 70) + 28) + 6))
        end

        layout()
        ui.LayoutChanged:Connect(layout)

        if a6.HotbarChanged then
            a6.HotbarChanged.Event:Connect(layout)
        end

        local function refreshCards()
            --[[
              name: refreshCards
              line: 331
              upvalues:
                state (copy, index: 1)
                count2 (ref,  index: 2)
                layout (copy, index: 3)
                busy (ref,  index: 4)
                selected (ref,  index: 5)
                fillCard (copy, index: 6)
                v26 (copy, index: 7)
                paint (copy, index: 8)
            ]]
            local v102 = not state.HasLoadoutSlots() and 0 or math.min(state.LoadoutSlotCount(), 5)

            if v102 ~= count2 then
                layout()
            end

            if busy == 0 then
                selected = state.ActiveLoadout()
            end

            for index = 1, count2 do
                fillCard(v26[index], index)
            end

            paint()
        end

        local function timeLeft()
            --[[
              name: timeLeft
              line: 346
              upvalues:
                state (copy, index: 1)
            ]]
            local v105, v106 = state.PhaseClock()

            if v105 == "PreRound" and not (v106 <= 0) then
                return v106 - state.Now()
            end

            return -1
        end

        local function baseOk()
            --[[
              name: baseOk
              line: 353
              upvalues:
                state (copy, index: 1)
                a6 (copy, index: 2)
                localPlayer (copy, index: 3)
            ]]
            local v108 = state.InMatch()
            if v108 then
                v108 = state.IsAlive()

                if v108 then
                    v108 = state.Get("CombatMode") ~= false
                        and not a6.HudHidden
                        and not a6.MenuManager.IsOpen()
                        and localPlayer:GetAttribute("ReplayPlaying") ~= true

                    if v108 then
                        local v109 = not state.HasLoadoutSlots() and 0 or math.min(state.LoadoutSlotCount(), 5)
                        v108 = 2 <= v109
                    end
                end
            end

            return v108
        end

        local shown2 = false

        local function setShown(shown)
            --[[
              name: setShown
              line: 363
              upvalues:
                shown2 (ref,  index: 1)
                v69 (ref,  index: 2)
                count (ref,  index: 3)
                busy (ref,  index: 4)
                refreshCards (copy, index: 5)
                ui (copy, index: 6)
                parent (copy, index: 7)
                theme (copy, index: 8)
            ]]
            if shown == shown2 then
                return
            end

            shown2 = shown
            v69 = shown and 1 or 0

            if shown then
                count += 1
                busy = 0
                refreshCards()
                local slideIn = ui.SlideIn
                local vector2 = if ui.Compact then Vector2.new(-18, 0) else Vector2.new(0, 18)
                slideIn(parent, vector2, theme.Tween.Smooth)
            end
        end

        local renderSteppedConnection = nil

        local function frame(deltaTime: number)
            --[[
              name: frame
              line: 378
              upvalues:
                state (copy, index: 1)
                setShown (copy, index: 2)
                v19 (copy, index: 3)
                baseOk (copy, index: 4)
                fade (ref,  index: 5)
                v69 (ref,  index: 6)
                paint (copy, index: 7)
            ]]
            local v118, v119 = state.PhaseClock()
            local v120 = if v118 == "PreRound" and not (v119 <= 0) then v119 - state.Now() else -1
            local shown = v19 < v120 and baseOk()
            setShown(shown)

            if fade ~= v69 then
                local v122 = not (fade < v69) and 0.14 or 0.18
                local v123 = deltaTime / v122
                fade = if fade < v69 then math.min(v69, fade + v123) else math.max(v69, fade - v123)
                paint()
            end
        end

        local function watch()
            --[[
              name: watch
              line: 387
              upvalues:
                state (copy, index: 1)
                renderSteppedConnection (ref,  index: 2)
                runService (copy, index: 3)
                frame (copy, index: 4)
                shown2 (ref,  index: 5)
                fade (ref,  index: 6)
                v69 (ref,  index: 7)
                refreshCards (copy, index: 8)
                parent (copy, index: 9)
                count2 (ref,  index: 10)
            ]]
            local v125 = state.InMatch()

            if v125 and not renderSteppedConnection then
                renderSteppedConnection = runService.RenderStepped:Connect(frame)
            elseif not v125 and renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
                shown2 = false
                fade = 0
                v69 = 0
            end

            refreshCards()
            parent.Visible = v125 and 2 <= count2
        end

        watch()
        state.PlayerStateChanged:Connect(watch)

        state.ProfileChanged:Connect(
            function()
                --[[
                  line: 402
                  upvalues:
                    state (copy, index: 1)
                    refreshCards (copy, index: 2)
                    parent (copy, index: 3)
                    count2 (ref,  index: 4)
                ]]
                if state.InMatch() then
                    refreshCards()
                    parent.Visible = 2 <= count2
                end
            end
        )

        local function snapBack()
            --[[
              name: snapBack
              line: 410
              upvalues:
                selected (ref,  index: 1)
                state (copy, index: 2)
                paint (copy, index: 3)
                ui (copy, index: 4)
                parent4 (copy, index: 5)
                a6 (copy, index: 6)
            ]]
            selected = state.ActiveLoadout()
            paint()
            ui.Shake(parent4, 6)
            a6.Sounds.Play("Error")
        end

        v27 = function(key, a128)
            --[[
              line: 416
              upvalues:
                shown2 (ref,  index: 1)
                count2 (ref,  index: 2)
                selected (ref,  index: 3)
                ui (copy, index: 4)
                v26 (copy, index: 5)
                state (copy, index: 6)
                v18 (copy, index: 7)
                paint (copy, index: 8)
                a6 (copy, index: 9)
                count (ref,  index: 10)
                busy (ref,  index: 11)
                v47 (ref,  index: 12)
                parent4 (copy, index: 13)
            ]]
            if not shown2 or key < 1 or count2 < key then
                return
            end

            if key == selected then
                if a128 == "tap" then
                    ui.Bump(v26[key].btn, 0.05)
                end

                return
            end

            local v129, v130 = state.PhaseClock()
            local v131 = if v129 == "PreRound" and not (v130 <= 0) then v130 - state.Now() else -1

            if v131 < v18 then
                return
            end

            selected = key
            paint()
            ui.Bump(v26[key].btn, 0.08)
            a6.Sounds.Play("Equip")
            count += 1
            local v132 = count
            busy += 1
            local taskDelay = task.delay
            local v134, v135 = state.PhaseClock()
            local v136 = if v134 == "PreRound" and not (v135 <= 0) then v135 - state.Now() else -1
            local v137 = not (v18 < v136 - 0.15) and 0 or 0.15

            taskDelay(
                v137,
                function()
                    --[[
                      line: 437
                      upvalues:
                        selected (ref,  index: 1)
                        v132 (copy, index: 2)
                        count (ref,  index: 3)
                        v47 (ref,  index: 4)
                        state (copy, index: 5)
                        busy (ref,  index: 6)
                        paint (copy, index: 7)
                        v18 (copy, index: 8)
                        ui (copy, index: 9)
                        parent4 (copy, index: 10)
                        a6 (copy, index: 11)
                    ]]
                    local v138 = selected
                    local v139 = v132 ~= count
                    if not v139 then
                        local v140 = v47 or state.ActiveLoadout()

                        if v138 ~= v140 then
                            local v141, v142 = state.PhaseClock()
                            local v143 = if v141 == "PreRound" and not (v142 <= 0) then v142 - state.Now() else -1

                            if v143 < v18 then
                                busy = math.max(0, busy - 1)

                                if v132 == count then
                                    selected = state.ActiveLoadout()
                                    paint()
                                    ui.Shake(parent4, 6)
                                    a6.Sounds.Play("Error")
                                end

                                return
                            end

                            v47 = v138
                            local v144 = a6.ProfileAction("SelectLoadout", v138)
                            busy = math.max(0, busy - 1)

                            if v47 == v138 then
                                v47 = nil
                            end

                            if v144 then
                                state.Profile.activeLoadout = v138

                                if type(state.Profile.loadouts) == "table" and state.Profile.loadouts[v138] then
                                    state.Profile.loadout = state.Profile.loadouts[v138]
                                end

                                if busy == 0 then
                                    selected = state.ActiveLoadout()
                                    paint()
                                end
                            elseif v132 == count then
                                selected = state.ActiveLoadout()
                                paint()
                                ui.Shake(parent4, 6)
                                a6.Sounds.Play("Error")
                            end

                            return
                        end
                    end

                    busy = math.max(0, busy - 1)

                    if not v139 then
                        paint()
                    end
                end
            )
        end

        local function step(a146)
            --[[
              name: step
              line: 475
              upvalues:
                count2 (ref, index: 1)
                v27 (ref, index: 2)
                selected (ref, index: 3)
            ]]
            if count2 < 2 then
                return
            end

            v27((((selected - 1) + a146) % count2) + 1, "key")
        end

        Keybinds.OnInput(
            "Began",
            function(a147, a148)
                --[[
                  line: 482
                  upvalues:
                    shown2 (ref,  index: 1)
                    userInputService (copy, index: 2)
                    Keybinds (copy, index: 3)
                    count2 (ref,  index: 4)
                    v27 (ref,  index: 5)
                    selected (ref,  index: 6)
                ]]
                if shown2 and not a148 and not userInputService:GetFocusedTextBox() then
                    if Keybinds.IsPad(a147, "NextLoadout") then
                        if not Keybinds.PadBlocked() and not (count2 < 2) then
                            v27((((selected - 1) + 1) % count2) + 1, "key")
                        end
                    elseif Keybinds.IsPad(a147, "PrevLoadout") then
                        if not Keybinds.PadBlocked() and not (count2 < 2) then
                            v27((((selected - 1) + -1) % count2) + 1, "key")
                        end
                    elseif Keybinds.ActionOf(a147) == "NextLoadout" and not (count2 < 2) then
                        v27((((selected - 1) + 1) % count2) + 1, "key")
                    end
                end
            end
        )

        a6.Debug.loadoutSwap = function(a149, a150)
            --[[
              line: 501
              upvalues:
                v27 (ref,  index: 1)
                count2 (ref,  index: 2)
                selected (ref,  index: 3)
                v26 (copy, index: 4)
                shown2 (ref,  index: 5)
                parent (copy, index: 6)
                fade (ref,  index: 7)
                state (copy, index: 8)
                busy (ref,  index: 9)
            ]]
            local v151

            if a149 == "pick" then
                v27((tonumber(a150) or 1), "tap")
            elseif a149 == "next" and not (count2 < 2) then
                v27((((selected - 1) + 1) % count2) + 1, "key")
            end

            local cards = {}

            for index = 1, count2 do
                cards[index] = v26[index].sig or ""
            end

            local v154 = {shown = shown2, visible = parent.Visible, fade = fade, selected = selected, active = state.ActiveLoadout(), busy = busy, count = count2}
            local v155
            v151, v155 = state.PhaseClock()
            v154.timeLeft = if v151 == "PreRound" and not (v155 <= 0) then v155 - state.Now() else -1
            v154.cards = cards
            v154.rect = {parent.AbsolutePosition.X, parent.AbsolutePosition.Y, parent.AbsoluteSize.X, parent.AbsoluteSize.Y}

            return v154
        end

        a6.LoadoutSwap = {
            IsShown = (function()
                --[[
                  name: IsShown
                  line: 524
                  upvalues:
                    shown2 (ref, index: 1)
                ]]
                return shown2
            end)
        }
    end)
}