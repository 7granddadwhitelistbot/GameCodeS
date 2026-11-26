local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

return {
    Init = (function(a5)
        --[[
          name: Init
          line: 19
          upvalues:
            players (copy, index: 1)
            tweenService (copy, index: 2)
            guiService (copy, index: 3)
            runService (copy, index: 4)
        ]]
        local paintFinal
        local ui = a5.UI
        local theme = a5.Theme
        local state = a5.State
        local portraits = a5.Portraits
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local ui2 = ui.new("Frame", {Name = "MatchHud", Visible = false, Size = UDim2.fromScale(1, 1), Parent = a5.Canvas.HUD})
        local targetValue = Color3.fromRGB(255, 146, 52)
        local instance = ui.new("Frame", {Name = "Scoreboard", AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(700, 96), Parent = ui2})
        a5.Scoreboard = instance
        local parent = ui.Panel({Name = "Center", BackgroundTransparency = 0.2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(150, 74), Radius = UDim.new(0, 12), Trim = colors.Accent, Parent = instance})
        local v18 = ui.DisplayText({Name = "Timer", Text = "1:15", TextSize = 42, Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0, 44), TextColor3 = colors.Text, Parent = parent})
        local ui3 = ui.new("TextLabel", {Name = "Round", Text = "ROUND 1", TextSize = 15, Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 0, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent})
        local v20 = {}

        local function makeSide(a22: boolean)
            --[[
              name: makeSide
              line: 80
              upvalues:
                colors (copy, index: 1)
                ui (copy, index: 2)
                instance (copy, index: 3)
                targetValue (copy, index: 4)
                theme (copy, index: 5)
                fonts (copy, index: 6)
            ]]
            local name
            local v24 = if a22 then colors.Ally else colors.Enemy
            local newUi = ui.new
            local v26 = {}

            if a22 then
                name = "Left"
            else
                name = "Right"
            end

            v26.Name = name
            local v27 = Vector2.new
            local v28 = a22 and 1 or 0
            v26.AnchorPoint = v27(v28, 0)
            v27 = UDim2.new
            local v29 = a22 and -80 or 80
            v26.Position = v27(0.5, v29, 0, 0)
            v26.Size = UDim2.fromOffset(270, 96)
            v26.Parent = instance
            local ui2 = newUi("Frame", v26)
            local newUi2 = ui.new
            local v32 = {Name = "FinalGlow", ImageTransparency = 1, ZIndex = 0, AnchorPoint = Vector2.new(0.5, 0.5)}
            local newUDim2 = UDim2.new
            local v34 = a22 and 1 or 0
            local v35 = a22 and -33 or 33
            v32.Position = newUDim2(v34, v35, 0, 30)
            v32.Size = UDim2.fromOffset(150, 136)
            v32.Image = ui.Assets.Icons.Glow
            v32.ImageColor3 = targetValue
            v32.Parent = ui2
            local glow = newUi2("ImageLabel", v32)
            local boxStroke = ui.Stroke(theme.Lighten(v24, 0.4), 2, 0.3)
            local newUi3 = ui.new
            local v39 = {Name = "ScoreBox"}
            local v40 = Vector2.new
            local v41 = a22 and 1 or 0
            v39.AnchorPoint = v40(v41, 0)
            v40 = UDim2.fromScale
            local v42 = a22 and 1 or 0
            v39.Position = v40(v42, 0)
            v39.Size = UDim2.fromOffset(66, 60)
            v39.BackgroundColor3 = Color3.new(1, 1, 1)
            v39.BackgroundTransparency = 0.05
            v39[1], v39[2], v39[3] = ui.Corner(12), ui.Gradient(theme.Lighten(v24, 0.1), theme.Darken(v24, 0.35), 90), boxStroke
            v39.Parent = ui2
            local parent = newUi3("Frame", v39)
            local score = ui.DisplayText({Name = "Score", Text = "0", TextSize = 44, StrokeThickness = 2.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), TextColor3 = colors.Text, StrokeColor = theme.Darken(v24, 0.7), Parent = parent})
            local newUi4 = ui.new
            local v46 = {Name = "Pips", AnchorPoint = Vector2.new(0.5, 0)}
            v40 = UDim2.new
            local v47 = a22 and 1 or 0
            local v48 = a22 and -33 or 33
            v46.Position = v40(v47, v48, 0, 64)
            v46.Size = UDim2.fromOffset(66, 10)
            v46[1] = (ui.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center))
            v46.Parent = ui2
            local pips = newUi4("Frame", v46)
            local newUi5 = ui.new
            local v51 = {Name = "Portraits"}
            local newVector2 = Vector2.new
            local x = a22 and 1 or 0
            v51.AnchorPoint = newVector2(x, 0)
            v40 = UDim2.new
            local v54 = a22 and 1 or 0
            local v55 = a22 and -74 or 74
            v51.Position = v40(v54, v55, 0, 2)
            v51.Size = UDim2.fromOffset(174, 54)
            local list = ui.List
            local v57 = Enum.FillDirection.Horizontal
            local horizontalAlignment = if a22 then Enum.HorizontalAlignment.Right else Enum.HorizontalAlignment.Left
            v51[1] = (list(v57, 6, horizontalAlignment, Enum.VerticalAlignment.Top))
            v51.Parent = ui2
            local parent2 = newUi5("Frame", v51)
            local newUi6 = ui.new
            local v61 = {Name = "Tribe", Text = "WOLF", TextSize = 16, Visible = false}
            local newVector22 = Vector2.new
            local x2 = a22 and 1 or 0
            v61.AnchorPoint = newVector22(x2, 0)
            v57 = UDim2.new
            local v64 = a22 and 1 or 0
            local v65 = a22 and -74 or 74
            v61.Position = v57(v64, v65, 0, 60)
            v61.Size = UDim2.fromOffset(174, 18)
            v61.FontFace = fonts.Heavy
            v61.TextColor3 = theme.Lighten(v24, 0.45)
            v61.TextXAlignment = if a22 then Enum.TextXAlignment.Right else Enum.TextXAlignment.Left
            v61.Parent = ui2
            local name2 = newUi6("TextLabel", v61)
            local portraits = {}

            for index = 1, 3 do
                local newUi7 = ui.new
                local v70 = {Name = "P" .. index, Size = UDim2.fromOffset(54, 54), BackgroundColor3 = theme.Darken(v24, 0.55), BackgroundTransparency = 0.1, LayoutOrder = if a22 then 4 - index else index}
                v70.ClipsDescendants = false
                v70[1] = (ui.Corner(theme.Radius.Pill))
                v70.Parent = parent2
                local ui3 = newUi7("Frame", v70)
                local stroke = ui.Stroke(v24, 2.5, 0)
                stroke.Parent = ui3
                local img = ui.new("ImageLabel", {Name = "Img", Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
                local dim = ui.new("Frame", {Name = "Dim", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.35, Visible = false, ZIndex = 2, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
                local x3 = ui.Icon("cross", 40, colors.Danger, {Thickness = 5, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui3})
                x3.Visible = false
                portraits[index] = {holder = ui3, img = img, stroke = stroke, x = x3, dim = dim}
            end

            return {frame = ui2, score = score, boxStroke = boxStroke, glow = glow, name = name2, pips = pips, portraits = portraits}
        end

        v20[1] = makeSide(true)
        v20[2] = makeSide(false)

        local function setPips(pips, score, a79, backgroundColor3)
            --[[
              name: setPips
              line: 207
              upvalues:
                ui (copy, index: 1)
            ]]
            local v81 = {}

            for _, child in pips.pips:GetChildren() do
                if child:IsA("Frame") then
                    table.insert(v81, child)
                end
            end

            for layoutOrder = #v81 + 1, a79 do
                table.insert(v81, ui.new("Frame", {Size = UDim2.fromOffset(12, 8), BackgroundColor3 = backgroundColor3, LayoutOrder = layoutOrder, (ui.Corner(3)), Parent = pips.pips}))
            end

            local clampedValue = math.clamp(math.floor(66 / math.max(a79, 1)) - 3, 4, 14)

            for v86, v87 in v81 do
                local v88
                v87.Visible = v86 <= a79
                v87.Size = UDim2.fromOffset(clampedValue, 8)

                if v86 <= score then
                    v88 = backgroundColor3
                else
                    v88 = Color3.fromRGB(52, 56, 68)
                end

                v87.BackgroundColor3 = v88
                v87.BackgroundTransparency = not (v86 <= score) and 0.25 or 0
            end
        end

        local function paintBoard(a90)
            --[[
              name: paintBoard
              line: 232
              upvalues:
                state (copy, index: 1)
                v20 (copy, index: 2)
                colors (copy, index: 3)
                ui (copy, index: 4)
                setPips (copy, index: 5)
                portraits (copy, index: 6)
            ]]
            if not a90 then
                return
            end

            local v91 = state.MyTeam()

            for v92, teamKey in {v91, 3 - v91} do
                local pips = v20[v92]
                local team = a90.teams[teamKey]
                local v96 = if v92 == 1 then colors.Ally else colors.Enemy
                pips.name.Text = ""
                local score = team.score or 0
                pips.score.Text = tostring(score)

                if pips.lastScore and pips.lastScore < score then
                    ui.Pop(pips.score, 1.6)
                end

                pips.lastScore = score
                setPips(pips, score, (a90.roundsToWin or state.RoundsToWin()), v96)

                for memberKey, portrait in pips.portraits do
                    local member = team.members[memberKey]
                    portrait.holder.Visible = member ~= nil

                    if member then
                        portraits.Apply(portrait.img, member, 60)
                        local visible = member.alive == false
                        local v102 = member.connected == false
                        portrait.x.Visible = visible
                        portrait.dim.Visible = visible or v102
                        local setTint = portraits.SetTint
                        local img = portrait.img
                        local color3 = if visible then Color3.fromRGB(150, 150, 150) else Color3.new(1, 1, 1)
                        local v106 = visible and 0.35 or 0
                        setTint(img, color3, v106)
                        portrait.stroke.Color = if visible then Color3.fromRGB(90, 84, 78) else v96
                        local v107 = member.id == state.MyId()
                        portrait.stroke.Thickness = v107 and 3.5 or 2.5
                    end
                end
            end
        end

        local ceilingValue = -1
        local v109 = false
        local v110 = false
        local uiStroke = parent:FindFirstChildOfClass("UIStroke")
        local v112 = uiStroke and {uiStroke.Color, uiStroke.Transparency, uiStroke.Thickness}

        paintFinal = function(a113)
            --[[
              name: paintFinal
              line: 275
              upvalues:
                v110 (ref,  index: 1)
                ui (copy, index: 2)
                ui3 (copy, index: 3)
                v20 (copy, index: 4)
                theme (copy, index: 5)
                colors (copy, index: 6)
                uiStroke (copy, index: 7)
                v112 (copy, index: 8)
                targetValue (copy, index: 9)
            ]]
            if a113 ~= v110 then
                v110 = a113

                if a113 then
                    ui.Bump(ui3, 0.25)
                else
                    for v114, v115 in v20 do
                        v115.glow.ImageTransparency = 1
                        local boxStroke = v115.boxStroke
                        local lighten = theme.Lighten
                        local v118 = if v114 == 1 then colors.Ally else colors.Enemy
                        boxStroke.Color = lighten(v118, 0.4)
                        v115.boxStroke.Transparency = 0.3
                    end

                    if uiStroke and v112 then
                        uiStroke.Color, uiStroke.Transparency, uiStroke.Thickness = v112[1], v112[2], v112[3]
                    end
                end
            end

            if not a113 then
                return
            end

            local v119 = math.sin(os.clock() * 2.4) * 0.5 + 0.5

            for v120, v121 in v20 do
                v121.glow.ImageTransparency = 0.7 - (v119 * 0.24)
                local boxStroke = v121.boxStroke
                local lighten = theme.Lighten
                local v124 = if v120 == 1 then colors.Ally else colors.Enemy
                boxStroke.Color = lighten(v124, 0.4):Lerp(targetValue, (v119 * 0.35) + 0.35)
                v121.boxStroke.Transparency = 0.25 - (v119 * 0.15)
            end

            if uiStroke then
                uiStroke.Color = targetValue
                uiStroke.Thickness = 1.5
                uiStroke.Transparency = 0.6 - (v119 * 0.3)
            end
        end

        local function phaseText(match)
            --[[
              name: phaseText
              line: 306
              upvalues:
                state (copy, index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
            ]]
            local phase = match and match.phase
            local v128 = state.PhaseTimeLeft()

            if phase == "Overtime" then
                local v129 = not (0 < v128) and "OVERTIME" or ui.FormatTime(v128)
                return v129, colors.Danger
            end

            if phase == "Live" then
                local v130 = ui.FormatTime(v128)

                if v128 <= 10 then
                    return v130, colors.Danger
                end

                return v130, colors.Text
            end

            if phase ~= "PreRound" then
                if phase ~= "Intro" then
                    if phase == "RoundEnd" or phase == "MatchEnd" then
                        return "0:00", colors.TextDim
                    end

                    return ui.FormatTime(v128), colors.Text
                end
            end

            return ui.FormatTime(state.RoundTime()), colors.TextDim
        end

        local parent2 = ui.new("TextLabel", {Name = "Overtime", Text = "OVERTIME", TextSize = 17, Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 78), Size = UDim2.fromOffset(200, 20), FontFace = fonts.Title, TextColor3 = colors.Danger, Parent = instance})
        ui.TextStroke(colors.Void, 2, 0.1).Parent = parent2

        local function tickTimer()
            --[[
              name: tickTimer
              line: 335
              upvalues:
                state (copy, index: 1)
                phaseText (copy, index: 2)
                v18 (copy, index: 3)
                a5 (copy, index: 4)
                ui3 (copy, index: 5)
                targetValue (copy, index: 6)
                colors (copy, index: 7)
                paintFinal (copy, index: 8)
                v109 (ref,  index: 9)
                parent2 (copy, index: 10)
                ui (copy, index: 11)
                ceilingValue (ref,  index: 12)
            ]]
            local text
            local match = state.Match
            local text2, textColor3 = phaseText(match)
            v18.Text = text2
            v18.TextColor3 = textColor3
            local v137 = a5.Decider ~= nil and a5.Decider.Active()

            if v137 then
                text = "FINAL ROUND"
            else
                local round = match and match.round or 1
                text = "ROUND " .. tostring(round)
            end

            ui3.Text = text
            ui3.TextColor3 = if v137 then targetValue else colors.TextDim
            paintFinal(v137)
            local phase = match and match.phase
            local visible = phase == "Overtime"

            if visible ~= v109 then
                v109 = visible
                parent2.Visible = visible

                if visible then
                    ui.Pop(parent2, 1.5)
                end
            end

            if visible then
                parent2.TextTransparency = (math.sin(os.clock() * 6) * 0.25) + 0.25
            end

            if phase == "Live" or phase == "Overtime" then
                local ceilingValue2 = math.ceil((state.PhaseTimeLeft()))

                if ceilingValue2 ~= ceilingValue then
                    ceilingValue = ceilingValue2

                    if ceilingValue2 <= 10 and 0 < ceilingValue2 then
                        ui.Bump(v18, 0.12)
                    end
                end
            end
        end

        local ui4 = ui.new("Frame", {Name = "Health", AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(372, 40), Parent = ui2})
        local v143 = ui.DisplayText({Name = "Number", Text = "100", TextSize = 40, StrokeThickness = 2.5, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 2), Size = UDim2.fromOffset(72, 40), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = colors.Text, Parent = ui4})
        local parent3 = ui.new("Frame", {Name = "Bar", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 1, -4), Size = UDim2.new(1, -80, 0, 20), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, ClipsDescendants = true, ui.Corner(6), (ui.Stroke(colors.Stroke, 2, 0.6)), Parent = ui4})
        local ui5 = ui.new("Frame", {Name = "Trail", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.HealthTrail, BackgroundTransparency = 0.15, (ui.Corner(6)), Parent = parent3})
        local parent4 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(6)), Parent = parent3})
        local v147 = ui.Gradient(theme.Lighten(colors.Health, 0.2), theme.Darken(colors.Health, 0.15), 90)
        v147.Parent = parent4

        for index = 1, 3 do
            ui.new("Frame", {BackgroundTransparency = 0.55, ZIndex = 2, Position = UDim2.new(index * 0.25, -1, 0, 3), Size = UDim2.new(0, 2, 1, -6), BackgroundColor3 = colors.Void, Parent = parent3})
        end

        local ui6 = ui.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 3, (ui.Corner(6)), Parent = parent3})
        local armor = colors.Armor
        local parent5 = ui.new("Frame", {Name = "Armor", Visible = false, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 0, -2), Size = UDim2.new(1, -80, 0, 12), Parent = ui4})
        local v152 = ui.Image(ui.Assets.Icons.Shield, {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0, -6, 0.5, 0), Size = UDim2.fromOffset(16, 16), ImageColor3 = armor, Parent = parent5})
        local v153 = ui.DisplayText({Text = "0", TextSize = 16, StrokeThickness = 1.5, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0, -26, 0.5, 1), Size = UDim2.fromOffset(40, 16), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = armor, Parent = parent5})
        local parent6 = ui.new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, ClipsDescendants = true, ui.Corner(4), (ui.Stroke(colors.Stroke, 1.5, 0.7)), Parent = parent5})
        local v155 = ui.Gradient(theme.Lighten(armor, 0.2), theme.Darken(armor, 0.15), 90)
        local parent7 = ui.new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(4)), Parent = parent6})
        v155.Parent = parent7
        local clampedValue = 0
        local v158 = nil
        local v159 = false
        local bonusArmorUntil = 0

        local function paintArmor(a162: boolean)
            --[[
              name: paintArmor
              line: 488
              upvalues:
                v158 (ref,  index: 1)
                parent5 (copy, index: 2)
                clampedValue (ref,  index: 3)
                v159 (ref,  index: 4)
                colors (copy, index: 5)
                armor (copy, index: 6)
                v155 (copy, index: 7)
                theme (copy, index: 8)
                v152 (copy, index: 9)
                v153 (copy, index: 10)
                ui (copy, index: 11)
                bonusArmorUntil (ref,  index: 12)
                parent7 (copy, index: 13)
            ]]
            local maxArmor
            local clampedValue2
            local v165 = v158
            local maxArmor2 = v165 and v165:GetAttribute("MaxArmor")
            local armor2 = v165 and v165:GetAttribute("Armor")

            if type(maxArmor2) ~= "number" then
                maxArmor = 0
            else
                maxArmor = maxArmor2
            end

            if type(armor2) ~= "number" then
                clampedValue2 = 0
            else
                clampedValue2 = math.clamp(armor2, 0, maxArmor)
            end

            parent5.Visible = 0 < maxArmor

            if maxArmor <= 0 then
                clampedValue = 0
                return
            end

            local bonusArmor = v165 and v165:GetAttribute("BonusArmor")
            local v169 = type(bonusArmor) == "number" and 0 < bonusArmor

            if v169 ~= v159 then
                v159 = v169
                local v170 = if v169 then colors.Gold else armor
                v155.Color = ColorSequence.new(theme.Lighten(v170, 0.2), theme.Darken(v170, 0.15))
                v152.ImageColor3 = v170
                v153.TextColor3 = v170

                if v169 then
                    ui.Bump(v152, 0.3)
                end
            end

            v153.Text = tostring((math.ceil(clampedValue2)))
            local v171 = clampedValue2 / maxArmor
            local serverTimeNow = workspace:GetServerTimeNow()
            local v173 = 0 < bonusArmorUntil
                and bonusArmorUntil - 0.3 < serverTimeNow
                and serverTimeNow < bonusArmorUntil + 1.5

            if a162 then
                parent7.Size = UDim2.fromScale(v171, 1)
            else
                local tween = ui.Tween
                local v175 = if clampedValue2 < clampedValue then theme.Tween.Fast else theme.Tween.Smooth
                tween(parent7, v175, {Size = UDim2.fromScale(v171, 1)})

                if clampedValue2 < clampedValue and not v173 then
                    ui.Bump(v152, 0.25)

                    if clampedValue2 <= 0 then
                        ui.Shake(parent5, 6)
                    end
                end
            end

            parent7.BackgroundTransparency = not (clampedValue2 <= 0) and 0 or 1
            clampedValue = clampedValue2
        end

        local humanoid = nil
        local v177 = 100
        local count = 0
        local v179 = false

        local function paintHealth(a181: boolean)
            --[[
              name: paintHealth
              line: 534
              upvalues:
                humanoid (ref,  index: 1)
                v143 (copy, index: 2)
                colors (copy, index: 3)
                v147 (copy, index: 4)
                theme (copy, index: 5)
                v179 (ref,  index: 6)
                parent4 (copy, index: 7)
                ui5 (copy, index: 8)
                v177 (ref,  index: 9)
                ui6 (copy, index: 10)
                ui (copy, index: 11)
                ui4 (copy, index: 12)
                count (ref,  index: 13)
            ]]
            local v182
            local humanoid2 = humanoid
            if not humanoid2 then
                return
            end

            local v184 = not (0 < humanoid2.MaxHealth) and 100 or humanoid2.MaxHealth
            local clampedValue = math.clamp(humanoid2.Health, 0, v184)
            local v186 = clampedValue / v184
            v143.Text = tostring((math.ceil(clampedValue)))

            if not (v186 <= 0.3) then
                v182 = if v186 <= 0.6 then Color3.fromRGB(240, 196, 70) else colors.Health
            else
                v182 = colors.HealthLow
            end

            v147.Color = ColorSequence.new(theme.Lighten(v182, 0.2), theme.Darken(v182, 0.15))
            v179 = (v186 <= 0.3) and (0 < clampedValue)

            if a181 then
                parent4.Size = UDim2.fromScale(v186, 1)
                ui5.Size = UDim2.fromScale(v186, 1)
            elseif clampedValue < v177 then
                parent4.Size = UDim2.fromScale(v186, 1)
                ui6.BackgroundTransparency = 0.35
                local v187 = {BackgroundTransparency = 1}
                ui.Tween(ui6, TweenInfo.new(0.25), v187)
                ui.Bump(v143, (math.clamp((v177 - clampedValue) / 60, 0.08, 0.3)))

                if 8 <= v177 - clampedValue then
                    ui.Shake(ui4, (math.clamp((v177 - clampedValue) / 5, 3, 9)))
                end

                count += 1
                local v188 = count

                task.delay(
                    0.35,
                    function()
                        --[[
                          line: 561
                          upvalues:
                            v188 (copy, index: 1)
                            count (ref,  index: 2)
                            ui (copy, index: 3)
                            ui5 (copy, index: 4)
                            v186 (copy, index: 5)
                        ]]
                        if v188 == count then
                            ui.Tween(ui5, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(v186, 1)})
                        end
                    end
                )
            else
                ui.Tween(parent4, theme.Tween.Smooth, {Size = UDim2.fromScale(v186, 1)})
                ui.Tween(ui5, theme.Tween.Smooth, {Size = UDim2.fromScale(v186, 1)})

                if v177 + 1 < clampedValue then
                    v143.TextColor3 = colors.Health
                    task.delay(
                        0.4,
                        function()
                            --[[
                              line: 572
                              upvalues:
                                v143 (copy, index: 1)
                                colors (copy, index: 2)
                            ]]
                            v143.TextColor3 = colors.Text
                        end
                    )
                end
            end

            v177 = clampedValue
        end

        local v189 = {}
        local v190 = nil

        local function hookCharacter(a192)
            --[[
              name: hookCharacter
              line: 585
              upvalues:
                v189 (copy, index: 1)
                humanoid (ref,  index: 2)
                v158 (ref,  index: 3)
                clampedValue (ref,  index: 4)
                bonusArmorUntil (ref,  index: 5)
                paintArmor (copy, index: 6)
                localPlayer (copy, index: 7)
                v190 (ref,  index: 8)
                v177 (ref,  index: 9)
                paintHealth (copy, index: 10)
            ]]
            for _, v194 in v189 do
                v194:Disconnect()
            end

            table.clear(v189)
            humanoid = nil
            v158 = a192
            clampedValue = 0
            bonusArmorUntil = 0
            paintArmor(true)

            if not a192 then
                return
            end

            table.insert(
                v189,
                a192:GetAttributeChangedSignal("Armor"):Connect(
                    function()
                        --[[
                          line: 598
                          upvalues:
                            paintArmor (copy, index: 1)
                        ]]
                        paintArmor(false)
                    end
                )
            )
            table.insert(
                v189,
                a192:GetAttributeChangedSignal("BonusArmor"):Connect(
                    function()
                        --[[
                          line: 601
                          upvalues:
                            paintArmor (copy, index: 1)
                        ]]
                        paintArmor(false)
                    end
                )
            )

            table.insert(
                v189,
                a192:GetAttributeChangedSignal("BonusArmorUntil"):Connect(
                    function()
                        --[[
                          line: 604
                          upvalues:
                            a192 (copy, index: 1)
                            bonusArmorUntil (ref,  index: 2)
                        ]]
                        local bonusArmorUntil2 = a192:GetAttribute("BonusArmorUntil")

                        if type(bonusArmorUntil2) == "number" then
                            bonusArmorUntil = bonusArmorUntil2
                        end
                    end
                )
            )

            table.insert(
                v189,
                a192:GetAttributeChangedSignal("MaxArmor"):Connect(
                    function()
                        --[[
                          line: 610
                          upvalues:
                            paintArmor (copy, index: 1)
                        ]]
                        paintArmor(true)
                    end
                )
            )
            local humanoid2 = a192:FindFirstChildOfClass("Humanoid") or a192:WaitForChild("Humanoid", 10)

            if humanoid2 and humanoid2:IsA("Humanoid") and (localPlayer.Character == a192 or v190 == a192) then
                humanoid = humanoid2
                v177 = humanoid2.Health
                paintHealth(true)
                table.insert(
                    v189,
                    humanoid2.HealthChanged:Connect(
                        function()
                            --[[
                              line: 620
                              upvalues:
                                paintHealth (copy, index: 1)
                            ]]
                            paintHealth(false)
                        end
                    )
                )
                table.insert(
                    v189,
                    humanoid2:GetPropertyChangedSignal("MaxHealth"):Connect(
                        function()
                            --[[
                              line: 623
                              upvalues:
                                paintHealth (copy, index: 1)
                            ]]
                            paintHealth(true)
                        end
                    )
                )
            end
        end

        localPlayer.CharacterAdded:Connect(
            function(character: Model)
                --[[
                  line: 627
                  upvalues:
                    v190 (ref,  index: 1)
                    hookCharacter (copy, index: 2)
                ]]
                if not v190 then
                    hookCharacter(character)
                end
            end
        )

        task.spawn(hookCharacter, localPlayer.Character)
        local udim2 = UDim2.new(0.5, 0, 0, 0)
        local v199 = 0
        local tween = nil
        local tweenInfo = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        local function boardHomeRect()
            --[[
              name: boardHomeRect
              line: 646
              upvalues:
                ui (copy, index: 1)
                ui2 (copy, index: 2)
                instance (copy, index: 3)
                udim2 (ref,  index: 4)
            ]]
            local v203 = math.max(ui.Scale, 0.01)
            local v204 = ui2.AbsoluteSize / v203
            local v205 = instance.AbsoluteSize / v203
            local v206 = (udim2.X.Scale * v204.X) + udim2.X.Offset - instance.AnchorPoint.X * v205.X
            local v207 = udim2.Y.Scale * v204.Y + udim2.Y.Offset

            return Rect.new(v206, v207, v206 + v205.X, v207 + v205.Y), v204
        end

        local function computeBoardShift()
            --[[
              name: computeBoardShift
              line: 655
              upvalues:
                ui (copy, index: 1)
                ui2 (copy, index: 2)
                instance (copy, index: 3)
                boardHomeRect (copy, index: 4)
            ]]
            local v209 = ui.ChatRectIn(ui2)

            if not v209 or not ui2.Visible or not instance.Visible or ui.Compact then
                return 0
            end

            local v210, v211 = boardHomeRect()

            if not (v209.Max.X + 12 <= v210.Min.X) then
                local x = v209.Min.X

                if not (v210.Max.X <= x) and not (v209.Max.Y <= v210.Min.Y) then
                    local y = v209.Min.Y

                    if not (v210.Max.Y <= y) then
                        return (math.max(0, (math.min((v209.Max.X + 12) - v210.Min.X, (v211.X - 12) - v210.Max.X))))
                    end
                end
            end

            return 0
        end

        local function applyBoard(a215: boolean)
            --[[
              name: applyBoard
              line: 669
              upvalues:
                udim2 (ref,  index: 1)
                v199 (ref,  index: 2)
                tween (ref,  index: 3)
                ui2 (copy, index: 4)
                instance (copy, index: 5)
                tweenService (copy, index: 6)
                tweenInfo (copy, index: 7)
                a5 (copy, index: 8)
            ]]
            local position = udim2 + UDim2.fromOffset(v199, 0)

            if tween then
                tween:Cancel()
                tween = nil
            end

            if not a215 or not ui2.Visible or not instance.Visible then
                instance.Position = position
            else
                tween = tweenService:Create(instance, tweenInfo, {Position = position})
                tween:Play()
            end

            if a5.KillFeedRelayout then
                a5.KillFeedRelayout()
            end
        end

        local function redodgeBoard(a218: boolean)
            --[[
              name: redodgeBoard
              line: 686
              upvalues:
                computeBoardShift (copy, index: 1)
                v199 (ref,  index: 2)
                applyBoard (copy, index: 3)
            ]]
            local v219 = computeBoardShift()

            if 1 < math.abs(v219 - v199) then
                v199 = v219
                applyBoard(a218)
            end
        end

        ui.ChatChanged:Connect(
            function()
                --[[
                  line: 693
                  upvalues:
                    redodgeBoard (copy, index: 1)
                ]]
                task.defer(redodgeBoard, true)
            end
        )
        ui2:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 696
                  upvalues:
                    redodgeBoard (copy, index: 1)
                ]]
                task.defer(redodgeBoard, false)
            end
        )
        instance:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 699
                  upvalues:
                    redodgeBoard (copy, index: 1)
                ]]
                task.defer(redodgeBoard, false)
            end
        )

        local function boardW()
            --[[
              name: boardW
              line: 712
              upvalues:
                state (copy, index: 1)
            ]]
            local clampedValue = math.clamp(state.TeamSize(), 1, 3)

            if not (3 <= clampedValue) then
                return (((clampedValue * 54) + 154 + ((clampedValue - 1) * 6)) * 2) + 24
            end

            return 700
        end

        local ui7 = ui.new("UIScale", {Name = "FitScale", Parent = instance})

        local function phoneBoardHome()
            --[[
              name: phoneBoardHome
              line: 720
              upvalues:
                ui (copy, index: 1)
                ui2 (copy, index: 2)
                a5 (copy, index: 3)
                guiService (copy, index: 4)
                state (copy, index: 5)
            ]]
            local v224, v225, v226
            local v227
            local v228 = math.max(ui.Scale, 0.01)
            local absolutePosition = ui2.AbsolutePosition
            local v230 = ui2.AbsoluteSize / v228
            local button = a5.TopbarSettings and a5.TopbarSettings.Button
            local firstAncestorOfClass = button and button:FindFirstAncestorOfClass("ScreenGui")

            if ui.DebugDevice or not button or not firstAncestorOfClass or button.AbsoluteSize.X < 1 then
                v224 = (ui.TopInset() - 4) * 6
                v225 = v230.X - 16
                v226 = 6
            else
                v224 = (button.AbsolutePosition.X + button.AbsoluteSize.X - absolutePosition.X) / v228 + 12
                v226 = (button.AbsolutePosition.Y - absolutePosition.Y) / v228
                local topbarInset = guiService.TopbarInset
                v225 = if 0 < topbarInset.Width then (firstAncestorOfClass.AbsolutePosition.X + topbarInset.Max.X - absolutePosition.X) / v228 - 8 else v230.X - 16
            end

            local v234 = math.min(v225, v230.X - 16)
            local clampedValue = math.clamp(state.TeamSize(), 1, 3)

            if not (3 <= clampedValue) then
                v227 = ((clampedValue * 54) + 154 + ((clampedValue - 1) * 6)) * 2 + 24
            else
                v227 = 700
            end

            local v236 = (v234 - v224) / v227

            if v236 < 0.55 then
                local v237 = math.min(1, (v230.X - 32) / v227)
                return UDim2.new(0.5, 0, 0, ui.TopInset()), v237
            end

            local v238 = math.min(v236, 1)
            local v239 = v227 * v238
            local v240 = v230.X / 2

            if v240 - (v239 / 2) < v224 then
                v240 = v224 + v239 / 2
            end

            if v234 < v240 + (v239 / 2) then
                v240 = math.max(v224 + (v239 / 2), v234 - (v239 / 2))
            end

            return UDim2.fromOffset(math.floor(v240), (math.floor((math.max(2, v226))))), v238
        end

        local function layout()
            --[[
              name: layout
              line: 757
              upvalues:
                ui (copy, index: 1)
                phoneBoardHome (copy, index: 2)
                udim2 (ref,  index: 3)
                ui7 (copy, index: 4)
                v199 (ref,  index: 5)
                tween (ref,  index: 6)
                instance (copy, index: 7)
                a5 (copy, index: 8)
                redodgeBoard (copy, index: 9)
                ui4 (copy, index: 10)
            ]]
            local v242 = ui.TopInset()

            if ui.Compact then
                local udim22, scale = phoneBoardHome()
                udim2 = udim22
                ui7.Scale = scale
            else
                udim2 = UDim2.new(0.5, 0, 0, v242)
                ui7.Scale = 1
            end

            local position = udim2 + UDim2.fromOffset(v199, 0)

            if tween then
                tween:Cancel()
                tween = nil
            end

            instance.Position = position

            if a5.KillFeedRelayout then
                a5.KillFeedRelayout()
            end

            task.defer(redodgeBoard, false)
            local v246 = not a5.HotbarWidth and 372 or a5.HotbarWidth()
            ui4.Size = UDim2.fromOffset(v246, 40)
            local v247 = not a5.HotbarTop and 110 or a5.HotbarTop()
            ui4.Position = UDim2.new(0.5, 0, 1, -(v247 + 8))
        end

        layout()
        ui.LayoutChanged:Connect(layout)
        ui.TopInsetChanged:Connect(layout)
        local isBusy = false

        local function queueLayout()
            --[[
              name: queueLayout
              line: 779
              upvalues:
                isBusy (ref,  index: 1)
                layout (copy, index: 2)
            ]]
            if isBusy then
                return
            end

            isBusy = true

            task.defer(
                function()
                    --[[
                      line: 784
                      upvalues:
                        isBusy (ref,  index: 1)
                        layout (copy, index: 2)
                    ]]
                    isBusy = false
                    layout()
                end
            )
        end

        ui.ScaleChanged:Connect(queueLayout)
        ui2:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueLayout)

        if a5.TopbarSettings and a5.TopbarSettings.Button then
            a5.TopbarSettings.Button:GetPropertyChangedSignal("AbsolutePosition"):Connect(queueLayout)
        end

        if a5.HotbarChanged then
            a5.HotbarChanged.Event:Connect(layout)
        end

        if a5.ToastAvoid then
            a5.ToastAvoid("Scoreboard", instance)
        end

        local heartbeatConnection = nil

        local function refreshVisible()
            --[[
              name: refreshVisible
              line: 803
              upvalues:
                state (copy, index: 1)
                a5 (copy, index: 2)
                v190 (ref,  index: 3)
                ui2 (copy, index: 4)
                ui4 (copy, index: 5)
                instance (copy, index: 6)
                heartbeatConnection (ref,  index: 7)
                runService (copy, index: 8)
                tickTimer (copy, index: 9)
                v179 (ref,  index: 10)
                parent4 (copy, index: 11)
            ]]
            local v252 = state.SeesMatch() and not a5.HudHidden or v190 ~= nil

            if state.Match == nil or state.Match.phase == "Loading" then
                v252 = false
                v252 = state
            else
                v252 = state
            end

            ui2.Visible = v252
            local v253 = v252.IsAlive() and not v252.Watching()
            ui4.Visible = v253 or v190 ~= nil
            instance.Visible = v190 == nil

            if a5.TopbarSettings then
                a5.TopbarSettings.SetHidden("Replay", v190 ~= nil)
            end

            if v252 and not heartbeatConnection then
                heartbeatConnection = runService.Heartbeat:Connect(
                    function()
                        --[[
                          line: 816
                          upvalues:
                            tickTimer (copy, index: 1)
                            v179 (ref,  index: 2)
                            parent4 (copy, index: 3)
                        ]]
                        tickTimer()

                        if v179 then
                            parent4.BackgroundTransparency = (math.sin(os.clock() * 8) * 0.25) + 0.25
                            return
                        end

                        if parent4.BackgroundTransparency ~= 0 then
                            parent4.BackgroundTransparency = 0
                        end
                    end
                )

                return
            end

            if not v252 and heartbeatConnection then
                heartbeatConnection:Disconnect()
                heartbeatConnection = nil
            end
        end

        local v254 = state.TeamSize()

        state.MatchChanged:Connect(
            function(a255)
                --[[
                  line: 830
                  upvalues:
                    paintBoard (copy, index: 1)
                    refreshVisible (copy, index: 2)
                    state (copy, index: 3)
                    v254 (ref,  index: 4)
                    isBusy (ref,  index: 5)
                    layout (copy, index: 6)
                ]]
                paintBoard(a255)
                refreshVisible()
                local v256 = state.TeamSize()

                if v256 ~= v254 then
                    v254 = v256

                    if not isBusy then
                        isBusy = true

                        task.defer(
                            function()
                                --[[
                                  line: 784
                                  upvalues:
                                    isBusy (ref,  index: 1)
                                    layout (copy, index: 2)
                                ]]
                                isBusy = false
                                layout()
                            end
                        )
                    end
                end
            end
        )

        state.PlayerStateChanged:Connect(refreshVisible)

        state.WatchChanged:Connect(
            function()
                --[[
                  line: 841
                  upvalues:
                    paintBoard (copy, index: 1)
                    state (copy, index: 2)
                    refreshVisible (copy, index: 3)
                ]]
                paintBoard(state.Match)
                refreshVisible()
            end
        )

        state.AttrChanged:Connect(
            function(a257)
                --[[
                  line: 845
                  upvalues:
                    refreshVisible (copy, index: 1)
                    paintBoard (copy, index: 2)
                    state (copy, index: 3)
                ]]
                if a257 == "Alive" or a257 == "Team" then
                    refreshVisible()
                    paintBoard(state.Match)
                end
            end
        )

        a5.HudHiddenChanged:Connect(refreshVisible)
        paintBoard(state.Match)
        refreshVisible()
        a5.MatchHud = {Root = ui2, Board = instance, Health = ui4}

        local function KillFeedTop()
            --[[
              name: KillFeedTop
              line: 858
              upvalues:
                ui (copy, index: 1)
                instance (copy, index: 2)
                ui2 (copy, index: 3)
                v199 (ref,  index: 4)
                boardHomeRect (copy, index: 5)
            ]]
            if ui.Compact and instance.Visible then
                local v259 = math.max(ui.Scale, 0.01)
                local absolutePosition = ui2.AbsolutePosition
                local v261 = (instance.AbsolutePosition.X + instance.AbsoluteSize.X - absolutePosition.X) / v259
                local v262 = (instance.AbsolutePosition.Y + instance.AbsoluteSize.Y - absolutePosition.Y) / v259

                if not ((ui2.AbsoluteSize / v259).X - 340 < v261) then
                    return nil
                end

                local v263 = v262 + 8

                if ui.TopInset() < v263 then
                    return v262 + 8
                end

                return nil
            end

            if v199 <= 0 then
                return nil
            end

            return boardHomeRect().Max.Y + 8
        end

        a5.MatchHud.KillFeedTop = KillFeedTop

        local function SetReplaySource(replaySource)
            --[[
              name: SetReplaySource
              line: 877
              upvalues:
                v190 (ref,  index: 1)
                hookCharacter (copy, index: 2)
                localPlayer (copy, index: 3)
                refreshVisible (copy, index: 4)
            ]]
            v190 = replaySource
            local v266 = replaySource or localPlayer.Character
            hookCharacter(v266)
            refreshVisible()
        end

        a5.MatchHud.SetReplaySource = SetReplaySource
    end)
}