return {
    Init = (function(a1)
        --[[
          name: Init
          line: 10
        ]]
        local ui = a1.UI
        local theme = a1.Theme
        local state = a1.State
        local weaponIcon = a1.WeaponIcon
        local colors = theme.Colors
        local fonts = theme.Fonts
        local parent = ui.new("Frame", {Name = "KillFeed", AnchorPoint = Vector2.new(1, 0), Size = UDim2.fromOffset(460, 190), (ui.List(Enum.FillDirection.Vertical, 5, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Top)), Parent = a1.Canvas.HUD})

        local function layout()
            --[[
              name: layout
              line: 21
              upvalues:
                a1 (copy, index: 1)
                parent (copy, index: 2)
                ui (copy, index: 3)
            ]]
            local v10 = if a1.MatchHud and a1.MatchHud.KillFeedTop then a1.MatchHud.KillFeedTop() else nil
            local newUDim2 = UDim2.new
            local v12 = ui.Compact and -14 or -22
            parent.Position = newUDim2(1, v12, 0, (v10 or ui.TopInset()))
        end

        a1.KillFeedRelayout = layout
        local v13 = if a1.MatchHud and a1.MatchHud.KillFeedTop then a1.MatchHud.KillFeedTop() else nil
        local newUDim2 = UDim2.new
        local v15 = ui.Compact and -14 or -22
        parent.Position = newUDim2(1, v15, 0, (v13 or ui.TopInset()))
        ui.LayoutChanged:Connect(layout)
        ui.TopInsetChanged:Connect(layout)
        local v16 = {}
        local targets = {}
        local count = 0

        local function newRow()
            --[[
              name: newRow
              line: 37
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                fonts (copy, index: 3)
            ]]
            local ui2 = ui.new("Frame", {Name = "Row", Size = UDim2.fromOffset(0, 33), AutomaticSize = Enum.AutomaticSize.X})
            local ui3 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromOffset(0, 33), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Void, BackgroundTransparency = 0.4, ui.Corner(8), ui.Padding(0, 10, 0, 10), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = ui2})
            local stroke = ui.Stroke(colors.Accent, 2, 0.1)
            stroke.Parent = ui3
            local ui4 = ui.new("TextLabel", {Name = "Killer", AutoLocalize = false, TextSize = 18, LayoutOrder = 1, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, Parent = ui3})
            ui.TextStroke(colors.Void, 1.5, 0.3).Parent = ui4
            local icon = ui.new("Frame", {Name = "Weapon", LayoutOrder = 2, Size = UDim2.fromOffset(38, 28), Parent = ui3})
            local hs = ui.Image(ui.Assets.Icons.Headshot, {Name = "Headshot", LayoutOrder = 3, Size = UDim2.fromOffset(20, 20), ImageColor3 = colors.Accent, Parent = ui3})
            local ui5 = ui.new("TextLabel", {Name = "Victim", AutoLocalize = false, TextSize = 18, LayoutOrder = 4, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, Parent = ui3})
            ui.TextStroke(colors.Void, 1.5, 0.3).Parent = ui5
            ui.new("UISizeConstraint", {MaxSize = Vector2.new(170, 30), Parent = ui4})
            ui.new("UISizeConstraint", {MaxSize = Vector2.new(170, 30), Parent = ui5})
            ui4.TextTruncate = Enum.TextTruncate.AtEnd
            ui5.TextTruncate = Enum.TextTruncate.AtEnd

            return {token = 0, holder = ui2, inner = ui3, stroke = stroke, killer = ui4, victim = ui5, icon = icon, hs = hs}
        end

        local function release(target)
            --[[
              name: release
              line: 89
              upvalues:
                targets (copy, index: 1)
                v16 (copy, index: 2)
            ]]
            if const index = table.find(targets, target) then
                table.remove(targets, index)
            end

            target.holder.Parent = nil
            table.insert(v16, target)
        end

        local function colorFor(a31)
            --[[
              name: colorFor
              line: 98
              upvalues:
                colors (copy, index: 1)
                state (copy, index: 2)
                theme (copy, index: 3)
            ]]
            if a31 == nil or a31 == 0 or a31 == false then
                return colors.TextDim
            end
            if state.IsAllyTeam(a31) then
                return (theme.Lighten(colors.Ally, 0.15))
            end

            return (theme.Lighten(colors.Enemy, 0.1))
        end

        local function push(a33)
            --[[
              name: push
              line: 105
              upvalues:
                state (copy, index: 1)
                ui (copy, index: 2)
                targets (copy, index: 3)
                v16 (copy, index: 4)
                newRow (copy, index: 5)
                count (ref,  index: 6)
                colors (copy, index: 7)
                theme (copy, index: 8)
                weaponIcon (copy, index: 9)
                parent (copy, index: 10)
            ]]
            local v34, v35
            local v36
            local v37
            local v38
            local v39
            local v40 = state.MyId()

            if ui.Compact then
                v34 = 3
            else
                v34 = 5
            end

            while v34 < #targets do
                local removedValue = table.remove(targets, 1)
                removedValue.token += 1
                removedValue.holder.Parent = nil
                table.insert(v16, removedValue)
            end

            if v34 <= #targets then
                v35 = targets[1]
                table.remove(targets, 1)
            else
                v35 = table.remove(v16) or newRow()
            end

            local token2 = v35.token + 1
            v35.token = token2
            local token = v35.token
            count += 1
            local visible = type(a33.killerName) == "string"
                and a33.killerName ~= ""
                and a33.killerId ~= a33.victimId

            local function tagged(a46, a47)
                --[[
                  name: tagged
                  line: 126
                  upvalues:
                    state (copy, index: 1)
                ]]
                local member = state.FindMember(a46)
                local tribe = member and member.tribe

                if type(tribe) == "table" and type(tribe.tag) == "string" then
                    return "[" .. tribe.tag .. "] " .. a47
                end

                return a47
            end

            v35.killer.Visible = visible
            local killer = v35.killer

            if visible then
                local killerId = a33.killerId
                local killerName = a33.killerName
                local member = state.FindMember(killerId)
                local tribe = member and member.tribe

                if type(tribe) == "table" and type(tribe.tag) == "string" then
                    v36 = "[" .. tribe.tag .. "] " .. killerName
                else
                    v36 = killerName
                end
            else
                v36 = ""
            end

            killer.Text = v36
            local killer2 = v35.killer
            local killerTeam = a33.killerTeam

            if killerTeam == nil or killerTeam == 0 or killerTeam == false then
                v37 = colors.TextDim
            else
                v37 = if state.IsAllyTeam(killerTeam) then theme.Lighten(colors.Ally, 0.15) else theme.Lighten(colors.Enemy, 0.1)
            end

            killer2.TextColor3 = v37
            local victim = v35.victim
            local victimId = a33.victimId
            local text = tostring((a33.victimName or "?"))
            local member = state.FindMember(victimId)
            local tribe = member and member.tribe

            if type(tribe) == "table" and type(tribe.tag) == "string" then
                v38 = "[" .. tribe.tag .. "] " .. text
            else
                v38 = text
            end

            victim.Text = v38
            local victim2 = v35.victim
            local victimTeam = a33.victimTeam

            if victimTeam == nil or victimTeam == 0 or victimTeam == false then
                v39 = colors.TextDim
            else
                v39 = if state.IsAllyTeam(victimTeam) then theme.Lighten(colors.Ally, 0.15) else theme.Lighten(colors.Enemy, 0.1)
            end

            victim2.TextColor3 = v39
            local hs = v35.hs
            hs.Visible = a33.headshot == true

            if type(a33.weaponId) == "string" and a33.weaponId ~= "" then
                weaponIcon.Set(v35.icon, a33.weaponId, {glow = false})
            else
                weaponIcon.Set(v35.icon, nil)

                if not v35.icon:FindFirstChild("WeaponIcon") then
                    ui.Image(ui.Assets.Icons.Skull, {Name = "WeaponIcon", Size = UDim2.fromScale(1, 1), ImageColor3 = colors.TextDim, Parent = v35.icon})
                end
            end

            ui.Unfade(v35.inner)
            local enabled = a33.killerId == v40 or a33.victimId == v40
            v35.stroke.Enabled = enabled
            v35.stroke.Transparency = 0.1
            v35.inner.BackgroundTransparency = enabled and 0.2 or 0.4
            v35.holder.LayoutOrder = count
            v35.holder.Parent = parent
            table.insert(targets, v35)
            ui.SlideIn(v35.inner, Vector2.new(40, 0), theme.Tween.PopSmall, UDim2.new())

            task.delay(
                5,
                function()
                    --[[
                      line: 161
                      upvalues:
                        v35 (ref,  index: 1)
                        token (copy, index: 2)
                        ui (copy, index: 3)
                        targets (copy, index: 4)
                        v16 (copy, index: 5)
                    ]]
                    if v35.token ~= token then
                        return
                    end

                    ui.FadeOut(v35.inner, TweenInfo.new(0.3))

                    task.delay(
                        0.32,
                        function()
                            --[[
                              line: 166
                              upvalues:
                                v35 (ref,  index: 1)
                                token (copy, index: 2)
                                targets (copy, index: 3)
                                v16 (copy, index: 4)
                            ]]
                            if v35.token == token then
                                local target = v35

                                if const index = table.find(targets, target) then
                                    table.remove(targets, index)
                                end

                                target.holder.Parent = nil
                                table.insert(v16, target)
                            end
                        end
                    )
                end
            )
        end

        a1.OnMatchEvent(
            function(a68, a69)
                --[[
                  line: 174
                  upvalues:
                    push (copy, index: 1)
                    targets (copy, index: 2)
                    v16 (copy, index: 3)
                ]]
                if a68 == "Elimination" and type(a69) == "table" then
                    push(a69)
                    return
                end

                if a68 == "MatchStart" then
                    for index2 = #targets, 1, -1 do
                        local v71 = targets[index2]
                        v71.token += 1
                        local target = targets[index2]

                        if const index = table.find(targets, target) then
                            table.remove(targets, index)
                        end

                        target.holder.Parent = nil
                        table.insert(v16, target)
                    end
                end
            end
        )

        local function vis()
            --[[
              name: vis
              line: 185
              upvalues:
                parent (copy, index: 1)
                state (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            local visible = state.SeesMatch() and not a1.HudHidden
            parent.Visible = visible
        end

        local visible = state.SeesMatch() and not a1.HudHidden
        parent.Visible = visible
        state.PlayerStateChanged:Connect(vis)
        state.WatchChanged:Connect(vis)
        a1.HudHiddenChanged:Connect(vis)

        a1.Debug.killfeed = function(a77)
            --[[
              line: 192
              upvalues:
                push (copy, index: 1)
                state (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            push((a77
                or {victimId = "b2", victimName = "Grimtooth", weaponId = "short_bow", headshot = true, killerId = state.MyId(), killerName = a1.Player.DisplayName, killerTeam = state.MyTeam(), victimTeam = 3 - state.MyTeam()}))
            return true
        end
    end)
}