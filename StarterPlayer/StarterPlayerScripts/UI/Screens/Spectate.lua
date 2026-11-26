local players = game:GetService("Players")
local runService = game:GetService("RunService")

return {
    Init = (function(a3)
        --[[
          name: Init
          line: 24
          upvalues:
            players (copy, index: 1)
            runService (copy, index: 2)
        ]]
        local ui = a3.UI
        local theme = a3.Theme
        local state = a3.State
        local portraits = a3.Portraits
        local weaponIcon = a3.WeaponIcon
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local parent = ui.new("Frame", {Name = "Spectate", Size = UDim2.fromScale(1, 1), Parent = a3.Canvas.HUD})
        local parent2 = ui.new("Frame", {Name = "EliminatedBy", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.58), Size = UDim2.fromOffset(470, 116), Parent = parent})
        local parent3 = ui.Panel({Name = "Inner", BackgroundTransparency = 0.12, StrokeTransparency = 0.3, Size = UDim2.fromScale(1, 1), StrokeColor = colors.Enemy, Trim = colors.Enemy, Parent = parent2})
        local ui2 = ui.new("ImageLabel", {Name = "Killer", Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(88, 88), BackgroundColor3 = theme.Darken(colors.Enemy, 0.6), ScaleType = Enum.ScaleType.Crop, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Enemy, 2.5, 0.1)), Parent = parent3})
        local v16 = ui.DisplayText({Name = "Title", Text = "ELIMINATED BY", TextSize = 26, StrokeThickness = 2, Position = UDim2.fromOffset(118, 12), Size = UDim2.new(1, -190, 0, 32), TextColor3 = colors.Enemy, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})
        local parent4 = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextScaled = true, Position = UDim2.fromOffset(118, 44), Size = UDim2.new(1, -190, 0, 34), FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})
        ui.new("UITextSizeConstraint", {MaxTextSize = 30, MinTextSize = 12, Parent = parent4})
        ui.TextStroke(colors.Void, 1.5, 0.3).Parent = parent4
        local ui3 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 16, Position = UDim2.fromOffset(118, 80), Size = UDim2.new(1, -190, 0, 20), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})
        local ui4 = ui.new("Frame", {Name = "Weapon", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(64, 64), Parent = parent3})
        local count = 0

        local function showCard(text, a23, weaponId, headshot: boolean, isAllyTeam)
            --[[
              name: showCard
              line: 103
              upvalues:
                count (ref,  index: 1)
                v16 (copy, index: 2)
                parent4 (copy, index: 3)
                colors (copy, index: 4)
                ui2 (copy, index: 5)
                portraits (copy, index: 6)
                ui (copy, index: 7)
                a3 (copy, index: 8)
                ui3 (copy, index: 9)
                weaponIcon (copy, index: 10)
                ui4 (copy, index: 11)
                parent2 (copy, index: 12)
                parent3 (copy, index: 13)
                theme (copy, index: 14)
            ]]
            local weaponId2
            count += 1
            local v28 = count
            v16.Text = text ~= "" and "ELIMINATED BY" or "YOU WERE ELIMINATED"
            parent4.Text = text
            parent4.TextColor3 = if isAllyTeam then colors.Ally else colors.Text
            ui2.Visible = text ~= ""

            if a23 then
                portraits.Apply(ui2, a23, 150)
            else
                ui2.Image = ui.Assets.Icons.Skull
                ui2.ScaleType = Enum.ScaleType.Fit
            end

            local parts = {}

            if type(weaponId) == "string" and weaponId ~= "" then
                table.insert(parts, a3.Loc.T(string.upper(a3.WeaponInfo.Name(weaponId))))
            end

            if headshot then
                table.insert(parts, a3.Loc.T("HEADSHOT"))
            end

            ui3.AutoLocalize = false
            ui3.Text = table.concat(parts, "  ·  ")
            local set = weaponIcon.Set

            if type(weaponId) ~= "string" or weaponId == "" then
                weaponId2 = nil
            else
                weaponId2 = weaponId
            end

            set(ui4, weaponId2)
            parent2.Visible = true
            ui.Unfade(parent3)
            ui.SlideIn(parent3, Vector2.new(0, 30), theme.Tween.PopSmall, UDim2.new())

            task.delay(
                3.2,
                function()
                    --[[
                      line: 129
                      upvalues:
                        v28 (copy, index: 1)
                        count (ref,  index: 2)
                        ui (copy, index: 3)
                        parent3 (copy, index: 4)
                        parent2 (copy, index: 5)
                    ]]
                    if v28 ~= count then
                        return
                    end

                    ui.FadeOut(parent3, TweenInfo.new(0.3))

                    task.delay(
                        0.32,
                        function()
                            --[[
                              line: 134
                              upvalues:
                                v28 (copy, index: 1)
                                count (ref,  index: 2)
                                parent2 (copy, index: 3)
                            ]]
                            if v28 == count then
                                parent2.Visible = false
                            end
                        end
                    )
                end
            )
        end

        local function hideCard()
            --[[
              name: hideCard
              line: 141
              upvalues:
                count (ref,  index: 1)
                parent2 (copy, index: 2)
            ]]
            count += 1
            parent2.Visible = false
        end

        local refreshBar = nil

        local function slamY()
            --[[
              name: slamY
              line: 148
              upvalues:
                ui (copy, index: 1)
            ]]
            if ui.Compact then
                return 0.3
            end

            return 0.36
        end

        local v34 = ui.new
        local v35 = {Name = "Respawn", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5)}
        local udim2FromScale = UDim2.fromScale
        local v37 = ui.Compact and 0.3 or 0.36
        v35.Position = udim2FromScale(0.5, v37)
        v35.Size = UDim2.fromOffset(500, 220)
        v35.Parent = parent
        v34 = v34("Frame", v35)
        local parent5 = ui.new("TextLabel", {Name = "Tag", Text = "RESPAWNING IN", TextSize = 26, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0.5, -70), Size = UDim2.fromOffset(500, 30), FontFace = fonts.Heavy, TextColor3 = colors.Accent, Parent = v34})
        ui.TextStroke(colors.Void, 2, 0.2).Parent = parent5
        local parent6 = ui.new("TextLabel", {Name = "Digit", Text = "", TextSize = 100, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 8), Size = UDim2.fromOffset(300, 130), FontFace = fonts.Display, TextColor3 = colors.Bone, Parent = v34})
        ui.TextStroke(colors.Void, 2, 0.15).Parent = parent6
        local ui5 = ui.new("UIScale", {Parent = parent6})

        ui.LayoutChanged:Connect(
            function()
                --[[
                  line: 184
                  upvalues:
                    v34 (copy, index: 1)
                    ui (copy, index: 2)
                ]]
                local udim2FromScale = UDim2.fromScale
                local v42 = ui.Compact and 0.3 or 0.36
                v34.Position = udim2FromScale(0.5, v42)
            end
        )

        local function outBack(a44)
            --[[
              name: outBack
              line: 187
            ]]
            local v45 = a44 - 1
            return (((v45 * 2.5) * v45) * v45) + 1 + ((v45 * 1.5) * v45)
        end

        local renderSteppedConnection = nil

        local function stopRespawn()
            --[[
              name: stopRespawn
              line: 192
              upvalues:
                renderSteppedConnection (ref,  index: 1)
                refreshBar (ref,  index: 2)
                v34 (copy, index: 3)
            ]]
            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
                refreshBar()
            end

            v34.Visible = false
        end

        local function startRespawn(number: number?)
            --[[
              name: startRespawn
              line: 201
              upvalues:
                renderSteppedConnection (ref,  index: 1)
                refreshBar (ref,  index: 2)
                v34 (copy, index: 3)
                parent6 (copy, index: 4)
                ui (copy, index: 5)
                parent5 (copy, index: 6)
                runService (copy, index: 7)
                localPlayer (copy, index: 8)
                a3 (copy, index: 9)
                ui5 (copy, index: 10)
            ]]
            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
                refreshBar()
            end

            v34.Visible = false
            local v50 = os.clock() + number
            local ceilingValue = 0
            parent6.Text = ""
            v34.Visible = true
            ui.Unfade(parent5)

            renderSteppedConnection = runService.RenderStepped:Connect(
                function()
                    --[[
                      line: 208
                      upvalues:
                        renderSteppedConnection (ref,  index: 1)
                        v50 (copy, index: 2)
                        localPlayer (copy, index: 3)
                        number (copy, index: 4)
                        refreshBar (ref,  index: 5)
                        v34 (copy, index: 6)
                        ceilingValue (ref,  index: 7)
                        parent6 (copy, index: 8)
                        a3 (copy, index: 9)
                        ui5 (copy, index: 10)
                        ui (copy, index: 11)
                    ]]
                    local v52
                    local v53 = false

                    if not renderSteppedConnection then
                        return
                    end

                    local v54 = v50 - os.clock()

                    if not (v54 <= 0) then
                        if localPlayer:GetAttribute("Alive") ~= true then
                            v53 = true
                        elseif not (v54 < number - 0.5) then
                            v53 = true
                        end
                    end

                    if v53 then
                        local v55
                        local v56
                        local ceilingValue2 = math.ceil(v54)
                        v52 = ceilingValue2 - v54

                        if ceilingValue2 ~= ceilingValue then
                            ceilingValue = ceilingValue2
                            parent6.Text = tostring(ceilingValue2)

                            if ceilingValue2 <= 3 then
                                a3.Sounds.Play("Match/Countdown_" .. ceilingValue2)
                            end
                        end

                        if not (v52 < 0.2) then
                            v56 = 1 - (0.03 * (v52 - 0.2)) / 0.8
                        else
                            local v58 = v52 / 0.2 - 1
                            v56 = 1.4 - ((((v58 * 2.5) * v58) * v58) + 1 + ((v58 * 1.5) * v58)) * 0.4
                        end

                        if ui.Compact then
                            v55 = 1.3
                        else
                            v55 = 1.6
                        end

                        ui5.Scale = v55 * v56
                        parent6.TextTransparency = 1 - math.min(1, v52 / 0.06)

                        return
                    end

                    if renderSteppedConnection then
                        renderSteppedConnection:Disconnect()
                        renderSteppedConnection = nil
                        refreshBar()
                    end

                    v34.Visible = false
                end
            )

            refreshBar()
        end

        local parent7 = ui.Panel({Name = "SpectateBar", BackgroundTransparency = 0.15, Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(440, 76), Trim = colors.Accent, Parent = parent})
        local ui6 = ui.new("TextLabel", {Name = "Tag", Text = "SPECTATING", TextSize = 15, Position = UDim2.fromOffset(84, 8), Size = UDim2.new(1, -168, 0, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent7})
        local parent8 = ui.new("TextLabel", {Name = "Target", AutoLocalize = false, Text = "", TextScaled = true, Position = UDim2.fromOffset(84, 28), Size = UDim2.new(1, -168, 0, 36), FontFace = fonts.Display, Parent = parent7})
        ui.new("UITextSizeConstraint", {MaxTextSize = 30, MinTextSize = 12, Parent = parent8})
        ui.TextStroke(colors.Void, 2, 0.2).Parent = parent8

        local function cam()
            --[[
              name: cam
              line: 267
              upvalues:
                a3 (copy, index: 1)
            ]]
            return a3.MenuManager.Camera()
        end

        local function spectateNext(a64)
            --[[
              name: spectateNext
              line: 270
              upvalues:
                a3 (copy, index: 1)
            ]]
            local v65 = a3.MenuManager.Camera()

            if v65 and type(v65.SpectateNext) == "function" then
                pcall(v65.SpectateNext, a64)
            end
        end

        local v66 = ui.IconButton(
            {
                Name = "Prev",
                IconName = "chevLeft",
                IconScale = 0.5,
                Size = UDim2.fromOffset(64, 60),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 8, 0.5, 0),
                Color = colors.Raised,
                Parent = parent7,
                OnClick = (function()
                    --[[
                      name: OnClick
                      line: 285
                      upvalues:
                        a3 (copy, index: 1)
                    ]]
                    local v67 = a3.MenuManager.Camera()

                    if v67 and type(v67.SpectateNext) == "function" then
                        pcall(v67.SpectateNext, -1)
                    end
                end)
            }
        )

        local v68 = ui.IconButton(
            {
                Name = "Next",
                IconName = "chevRight",
                IconScale = 0.5,
                Size = UDim2.fromOffset(64, 60),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -8, 0.5, 0),
                Color = colors.Raised,
                Parent = parent7,
                OnClick = (function()
                    --[[
                      name: OnClick
                      line: 298
                      upvalues:
                        a3 (copy, index: 1)
                    ]]
                    local v69 = a3.MenuManager.Camera()

                    if v69 and type(v69.SpectateNext) == "function" then
                        pcall(v69.SpectateNext, 1)
                    end
                end)
            }
        )

        local v70 = ui.Button({Name = "StopWatching", Text = "STOP WATCHING", TextSize = 17, Style = "Dark", Visible = false, Icon = ui.Glyph("door-open-arrow-to-bottom-right", 18, colors.TextDim), Size = UDim2.fromOffset(230, 46), Parent = parent7})
        v70.Instance.AnchorPoint = Vector2.new(0.5, 1)
        v70.Instance.Position = UDim2.new(0.5, 0, 0, -10)
        local v71 = false

        v70.Activated:Connect(
            function()
                --[[
                  line: 316
                  upvalues:
                    v71 (ref,  index: 1)
                    a3 (copy, index: 2)
                    v70 (copy, index: 3)
                ]]
                if v71 or not a3.Custom then
                    return
                end

                v71 = true
                v70:SetText("…")

                task.spawn(
                    function()
                        --[[
                          line: 322
                          upvalues:
                            a3 (copy, index: 1)
                            v71 (ref,  index: 2)
                            v70 (copy, index: 3)
                        ]]
                        local v72, v73 = a3.Custom.Action("Watch", false)
                        v71 = false
                        v70:SetText("STOP WATCHING")

                        if not v72 and v73 then
                            a3.Toast(tostring(v73), "error")
                        end
                    end
                )
            end
        )

        local function cycleCount()
            --[[
              name: cycleCount
              line: 331
              upvalues:
                state (copy, index: 1)
            ]]
            local v75 = state.Get("SpectateCount")

            if type(v75) ~= "number" then
                return 0
            end

            return v75
        end

        local visible = true

        local function layout()
            --[[
              name: layout
              line: 337
              upvalues:
                a3 (copy, index: 1)
                parent7 (copy, index: 2)
                ui (copy, index: 3)
                visible (ref,  index: 4)
                ui6 (copy, index: 5)
                parent8 (copy, index: 6)
            ]]
            local v78

            if a3.HotbarTop then
                a3.HotbarTop()
            end

            local newUDim2 = UDim2.new

            if ui.Compact then
                v78 = 16
            else
                v78 = 40
            end

            parent7.Position = newUDim2(0.5, 0, 1, -v78)
            local v80 = visible and 84 or 20
            local v81 = visible and (ui.Compact and 460 or 440) or 320
            local udim2FromOffset = UDim2.fromOffset
            local v83 = ui.Touch and 84 or 76
            parent7.Size = udim2FromOffset(v81, v83)
            ui6.Position = UDim2.fromOffset(v80, 8)
            ui6.Size = UDim2.new(1, v80 * -2, 0, 20)
            parent8.Position = UDim2.fromOffset(v80, 28)
            parent8.Size = UDim2.new(1, v80 * -2, 0, 36)
        end

        layout()
        ui.LayoutChanged:Connect(layout)
        local v84 = ""
        local v85 = ""

        refreshBar = function()
            --[[
              name: refreshBar
              line: 356
              upvalues:
                state (copy, index: 1)
                a3 (copy, index: 2)
                renderSteppedConnection (ref,  index: 3)
                v85 (ref,  index: 4)
                v70 (copy, index: 5)
                visible (ref,  index: 6)
                layout (copy, index: 7)
                v66 (copy, index: 8)
                v68 (copy, index: 9)
                v84 (ref,  index: 10)
                parent8 (copy, index: 11)
                theme (copy, index: 12)
                colors (copy, index: 13)
                ui6 (copy, index: 14)
                parent7 (copy, index: 15)
                ui (copy, index: 16)
            ]]
            local v86 = state.Get("SpectateMode")
            local v87 = state.Watching()
            local v88 = if not state.InMatch() and not v87 then v87 else v86 == "follow"
                and not a3.HudHidden
                and renderSteppedConnection == nil
            local v89 = state.Get("SpectateTargetName")
            local v90 = state.Get("SpectateTargetId")

            if v87 and type(v90) == "string" and v90 ~= "" and v90 ~= v85 and a3.Custom then
                v85 = v90
                task.spawn(a3.Custom.Action, "WatchTarget", v90)
            elseif not v87 then
                v85 = ""
            end

            v70.Instance.Visible = v87 and not a3.HudHidden
            local text

            if v88 then
                local v92
                local v93 = state.Get("SpectateCount")

                if type(v93) ~= "number" then
                    v92 = 0
                else
                    v92 = v93
                end

                local v94 = 1 < v92
                local v95
                local member
                local v97 = false

                if v94 ~= visible then
                    visible = v94
                    layout()
                end

                v66.Visible = visible
                v68.Visible = visible
                local v98 = state.Get("SpectateTargetId")
                member, text = state.FindMember(v98)
                local isAllyTeam = true

                if text ~= nil then
                    isAllyTeam = state.IsAllyTeam(text)
                end

                local stringUpper = string.upper

                if type(v89) ~= "string" then
                    v97 = true
                elseif v89 == "" then
                    v97 = true
                else
                    v95 = v89
                end

                if v97 then
                    if member then
                        v95 = member.name
                    elseif v87 then
                        v95 = a3.Loc.T("Loading the match...")
                    else
                        v95 = "?"
                    end
                end

                local text2
                local textColor3
                text = stringUpper((tostring(v95)))
                local v103 = text ~= v84
                v84 = text
                parent8.Text = text

                if isAllyTeam then
                    textColor3 = theme.Lighten(colors.Ally, 0.2)
                else
                    textColor3 = theme.Lighten(colors.Enemy, 0.1)
                end

                parent8.TextColor3 = textColor3

                if v87 then
                    text2 = "WATCHING"
                else
                    text2 = "SPECTATING"
                end

                ui6.Text = text2

                if not parent7.Visible then
                    parent7.Visible = true
                    ui.Unfade(parent7)
                    ui.SlideIn(parent7, Vector2.new(0, 30), theme.Tween.PopSmall)
                    a3.MenuManager.PushMouse("Spectate")

                    return
                end

                if v103 then
                    ui.Bump(parent8, 0.06)
                end
            elseif parent7.Visible then
                parent7.Visible = false
                a3.MenuManager.PopMouse("Spectate")
            end
        end

        for _, attribute in {"SpectateMode", "SpectateTargetId", "SpectateTargetName", "SpectateKillerName", "SpectateCount"} do
            localPlayer:GetAttributeChangedSignal(attribute):Connect(refreshBar)
        end

        state.AttrChanged:Connect(
            function(a106)
                --[[
                  line: 405
                  upvalues:
                    refreshBar (ref,  index: 1)
                    state (copy, index: 2)
                    count (ref,  index: 3)
                    parent2 (copy, index: 4)
                ]]
                if a106 == "SpectateMode" or a106 == "SpectateTargetName" or a106 == "SpectateCount" or a106 == "State" then
                    refreshBar()
                end

                if a106 == "Alive" and state.Get("Alive") == true then
                    count += 1
                    parent2.Visible = false
                end
            end
        )

        a3.HudHiddenChanged:Connect(refreshBar)

        state.PlayerStateChanged:Connect(
            function(a107)
                --[[
                  line: 414
                  upvalues:
                    count (ref,  index: 1)
                    parent2 (copy, index: 2)
                    refreshBar (ref,  index: 3)
                ]]
                if a107 ~= "Match" then
                    count += 1
                    parent2.Visible = false
                end

                refreshBar()
            end
        )

        state.WatchChanged:Connect(
            function()
                --[[
                  line: 420
                  upvalues:
                    layout (copy, index: 1)
                    refreshBar (ref,  index: 2)
                ]]
                layout()
                refreshBar()
            end
        )

        a3.OnMatchEvent(
            function(a108, a109)
                --[[
                  line: 425
                  upvalues:
                    state (copy, index: 1)
                    showCard (copy, index: 2)
                    startRespawn (copy, index: 3)
                    count (ref,  index: 4)
                    parent2 (copy, index: 5)
                    renderSteppedConnection (ref,  index: 6)
                    refreshBar (ref,  index: 7)
                    v34 (copy, index: 8)
                ]]
                if a108 == "Elimination" and type(a109) == "table" and a109.victimId == state.MyId() then
                    local v110 = type(a109.killerName) == "string"
                        and a109.killerName ~= ""
                        and a109.killerId ~= a109.victimId
                    local v111 = if v110 then state.FindMember(a109.killerId) else nil
                    local v112 = not v110 and "" or a109.killerName
                    showCard(v112, v111, a109.weaponId, a109.headshot == true, (v110
                        and state.IsAllyTeam(a109.killerTeam)))
                    local number = tonumber(a109.secondWind)

                    if not number or not (0 < number) then
                        return
                    end

                    startRespawn(number)

                    return
                end

                if a108 == "RoundStart" or a108 == "RoundEnd" or a108 == "MatchEnd" then
                    count += 1
                    parent2.Visible = false

                    if renderSteppedConnection then
                        renderSteppedConnection:Disconnect()
                        renderSteppedConnection = nil
                        refreshBar()
                    end

                    v34.Visible = false
                end
            end
        )

        refreshBar()

        a3.Debug.spectate = function(a114, a115, a116)
            --[[
              line: 440
              upvalues:
                state (copy, index: 1)
                refreshBar (ref,  index: 2)
            ]]
            state.SetMockAttr("SpectateMode", a114)
            state.SetMockAttr("SpectateTargetName", a115)
            state.SetMockAttr("SpectateCount", a116)
            refreshBar()

            return true
        end
    end)
}