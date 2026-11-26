local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local Tribes = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Tribes"))
local v5 = {}
local Tips = require(script.Parent.Parent.Tips)

function v5.Init(a7)
    --[[
      name: Init
      line: 25
      upvalues:
        players (copy, index: 1)
        Tribes (copy, index: 2)
        Tips (copy, index: 3)
        replicatedStorage (copy, index: 4)
        runService (copy, index: 5)
    ]]
    local cdFrame
    local v9
    local ui = a7.UI
    local theme = a7.Theme
    local state = a7.State
    local portraits = a7.Portraits
    local colors = theme.Colors
    local fonts = theme.Fonts
    local _ = players.LocalPlayer
    local overlay = a7.Canvas.Overlay
    local parent = ui.new("Frame", {Name = "Banners", Size = UDim2.fromScale(1, 1), Parent = overlay})
    local parent2 = ui.DisplayText({Name = "Slam", Text = "", TextSize = 100, StrokeThickness = 5, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.36), Size = UDim2.fromOffset(900, 140), TextColor3 = colors.Text, Parent = parent})
    local uiStroke = parent2:FindFirstChildOfClass("UIStroke")
    local ui2 = ui.new("UIScale", {Name = "Scale", Parent = parent2})
    local parent3 = ui.new("TextLabel", {Name = "SlamSub", Text = "", TextSize = 30, Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.36, 66), Size = UDim2.fromOffset(900, 40), FontFace = fonts.Title, TextColor3 = colors.TextDim, Parent = parent})
    ui.TextStroke(colors.Void, 2.5, 0.1).Parent = parent3
    local count = 0

    local function slamY()
        --[[
          name: slamY
          line: 67
          upvalues:
            ui (copy, index: 1)
        ]]
        if ui.Compact then
            return 0.3
        end

        return 0.36
    end

    local function subPos()
        --[[
          name: subPos
          line: 70
          upvalues:
            ui (copy, index: 1)
        ]]
        if ui.Compact then
            return (UDim2.new(0.5, 0, 0.3, 52))
        end

        return (UDim2.new(0.5, 0, 0.36, 66))
    end

    local v26 = false
    local v27 = 0
    local uiStroke2 = parent3:FindFirstChildOfClass("UIStroke")
    local v29 = {}

    local function fadeTo(a31, a32: string, a33: number, a34: number)
        --[[
          name: fadeTo
          line: 81
          upvalues:
            v29 (copy, index: 1)
            ui (copy, index: 2)
        ]]
        local v35 = v29[a31]
        if not v35 then
            v35 = {}
            v29[a31] = v35
        end

        table.insert(v35, ui.Tween(a31, TweenInfo.new(a34), {[a32] = a33}))
    end

    local function stopFades(...)
        --[[
          name: stopFades
          line: 89
          upvalues:
            v29 (copy, index: 1)
        ]]
        local v37 = {...}

        for _, v39 in v37 do
            if const v40 = v29[v39] then
                for _, v42 in v40 do
                    v42:Cancel()
                end

                table.clear(v40)
            end
        end
    end

    local function pinSub(text, a45)
        --[[
          name: pinSub
          line: 100
          upvalues:
            v27 (ref,  index: 1)
            parent3 (copy, index: 2)
            colors (copy, index: 3)
            v26 (ref,  index: 4)
            stopFades (copy, index: 5)
            uiStroke2 (copy, index: 6)
            ui (copy, index: 7)
            theme (copy, index: 8)
            fadeTo (copy, index: 9)
        ]]
        v27 += 1
        local v46 = v27

        if not text then
            if v26 then
                v26 = false
                fadeTo(parent3, "TextTransparency", 1, 0.2)
                fadeTo(uiStroke2, "Transparency", 1, 0.2)

                task.delay(
                    0.21,
                    function()
                        --[[
                          line: 118
                          upvalues:
                            v46 (copy, index: 1)
                            v27 (ref,  index: 2)
                            v26 (ref,  index: 3)
                            parent3 (copy, index: 4)
                        ]]
                        if v46 == v27 and not v26 then
                            parent3.Visible = false
                        end
                    end
                )
            end

            return
        end

        parent3.TextColor3 = a45 or colors.TextDim

        if not v26 or not parent3.Visible or parent3.Text ~= text then
            stopFades(parent3, uiStroke2)
            parent3.Text = text
            parent3.TextTransparency = 0
            uiStroke2.Transparency = 0.1
            parent3.Visible = true
            local slideIn = ui.SlideIn
            local vector2 = Vector2.new(0, 16)
            local smooth = theme.Tween.Smooth
            local udim2 = if ui.Compact then UDim2.new(0.5, 0, 0.3, 52) else UDim2.new(0.5, 0, 0.36, 66)
            slideIn(parent3, vector2, smooth, udim2)
        end

        v26 = true
    end

    local function showSlam(text: string, textColor3, text2: string, a55: number, a56: boolean)
        --[[
          name: showSlam
          line: 125
          upvalues:
            count (ref,  index: 1)
            stopFades (copy, index: 2)
            parent2 (copy, index: 3)
            uiStroke (copy, index: 4)
            parent3 (copy, index: 5)
            uiStroke2 (copy, index: 6)
            ui (copy, index: 7)
            ui2 (copy, index: 8)
            theme (copy, index: 9)
            v26 (ref,  index: 10)
            colors (copy, index: 11)
            fadeTo (copy, index: 12)
        ]]
        count += 1
        local v57 = count
        stopFades(parent2, uiStroke, parent3, uiStroke2)
        parent2.Text = text
        parent2.TextColor3 = textColor3
        local udim2FromScale = UDim2.fromScale
        local v59 = ui.Compact and 0.3 or 0.36
        parent2.Position = udim2FromScale(0.5, v59)
        local scale = a56 ~= false and 1.2 or 0.84
        parent2.TextTransparency = 0
        uiStroke.Transparency = 0
        parent2.Visible = true
        ui2.Scale = scale * 1.8
        ui.Tween(ui2, theme.Tween.Slam, {Scale = scale})

        if not v26 then
            parent3.Visible = text2 ~= nil

            if text2 then
                parent3.Text = text2
                parent3.TextColor3 = colors.TextDim
                parent3.TextTransparency = 0
                uiStroke2.Transparency = 0.1
                local slideIn = ui.SlideIn
                local vector2 = Vector2.new(0, 16)
                local smooth = theme.Tween.Smooth
                local udim2 = if ui.Compact then UDim2.new(0.5, 0, 0.3, 52) else UDim2.new(0.5, 0, 0.36, 66)
                slideIn(parent3, vector2, smooth, udim2)
            end
        end

        task.delay(
            (a55 or 0.8),
            function()
                --[[
                  line: 148
                  upvalues:
                    v57 (copy, index: 1)
                    count (ref,  index: 2)
                    fadeTo (copy, index: 3)
                    parent2 (copy, index: 4)
                    uiStroke (copy, index: 5)
                    v26 (ref,  index: 6)
                    parent3 (copy, index: 7)
                    uiStroke2 (copy, index: 8)
                ]]
                if v57 ~= count then
                    return
                end

                fadeTo(parent2, "TextTransparency", 1, 0.25)
                fadeTo(uiStroke, "Transparency", 1, 0.25)

                if not v26 then
                    fadeTo(parent3, "TextTransparency", 1, 0.25)
                    fadeTo(uiStroke2, "Transparency", 1, 0.25)
                end

                task.delay(
                    0.26,
                    function()
                        --[[
                          line: 158
                          upvalues:
                            v57 (copy, index: 1)
                            count (ref,  index: 2)
                            parent2 (copy, index: 3)
                            v26 (ref,  index: 4)
                            parent3 (copy, index: 5)
                        ]]
                        if v57 == count then
                            parent2.Visible = false

                            if not v26 then
                                parent3.Visible = false
                            end
                        end
                    end
                )
            end
        )
    end

    local function hideSlam()
        --[[
          name: hideSlam
          line: 168
          upvalues:
            count (ref,  index: 1)
            stopFades (copy, index: 2)
            parent2 (copy, index: 3)
            uiStroke (copy, index: 4)
            v26 (ref,  index: 5)
            parent3 (copy, index: 6)
        ]]
        count += 1
        stopFades(parent2, uiStroke)
        parent2.Visible = false

        if not v26 then
            parent3.Visible = false
        end
    end

    local v66 = nil
    local count2 = 0
    local v68 = {}

    local function recordLook(a70)
        --[[
          name: recordLook
          line: 183
          upvalues:
            v68 (copy, index: 1)
        ]]
        local v71 = {}
        local descendants = a70:GetDescendants()
        table.insert(descendants, a70)

        for _, descendant in descendants do
            local v75 = {}

            if descendant:IsA("GuiObject") and descendant.BackgroundTransparency < 1 then
                v75.BackgroundTransparency = descendant.BackgroundTransparency
            end

            if (descendant:IsA("TextLabel") or descendant:IsA("TextButton")) and descendant.TextTransparency < 1 then
                v75.TextTransparency = descendant.TextTransparency
            elseif (descendant:IsA("ImageLabel") or descendant:IsA("ViewportFrame"))
                and descendant.ImageTransparency < 1
            then
                v75.ImageTransparency = descendant.ImageTransparency
            elseif descendant:IsA("UIStroke") and descendant.Transparency < 1 then
                v75.Transparency = descendant.Transparency
            end

            if next(v75) then
                v71[descendant] = v75
            end
        end

        v68[a70] = v71
    end

    local function setFade(a77, a78)
        --[[
          name: setFade
          line: 206
          upvalues:
            v68 (copy, index: 1)
        ]]
        local v79 = v68[a77] or {}

        for v80, v81 in v79 do
            for v82, v83 in v81 do
                v80[v82] = v83 + ((1 - v83) * a78)
            end
        end
    end

    local TribeEmblem = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem.Init(ui)
    local v85 = {}
    Color3.fromRGB(255, 214, 110)

    local function buildIntro()
        --[[
          name: buildIntro
          line: 219
          upvalues:
            ui (copy, index: 1)
            parent (copy, index: 2)
            colors (copy, index: 3)
            theme (copy, index: 4)
            fonts (copy, index: 5)
            TribeEmblem (copy, index: 6)
            v85 (ref,  index: 7)
            recordLook (copy, index: 8)
        ]]
        local parent2 = ui.new("Frame", {Name = "Intro", Visible = false, Size = UDim2.fromScale(1, 1), Parent = parent})

        for index = 1, 2 do
            local name
            local v90 = if index == 1 then colors.Ally else colors.Enemy
            local newUi = ui.new
            local v92 = {}

            if index == 1 then
                name = "Left"
            else
                name = "Right"
            end

            v92.Name = name
            local v93 = Vector2.new
            local v94 = index ~= 1 and 1 or 0
            v92.AnchorPoint = v93(v94, 0)
            v93 = UDim2.fromScale
            local v95 = index ~= 1 and 1 or 0
            v92.Position = v93(v95, 0)
            v92.Size = UDim2.fromScale(0.5, 1)
            v92.BackgroundColor3 = Color3.new(1, 1, 1)
            v92.BackgroundTransparency = 0.08
            v92.ClipsDescendants = true
            local gradient = ui.Gradient
            local v97 = theme.Darken(v90, 0.45)
            local v98 = theme.Darken(v90, 0.82)
            local v99 = index ~= 1 and 180 or 0
            v92[1] = (gradient(v97, v98, v99))
            v92.Parent = parent2
            local parent3 = newUi("Frame", v92)
            local parent4 = ui.new("Frame", {Name = "Content", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46), Size = UDim2.fromOffset(560, 380), Parent = parent3})
            ui.DisplayText({Name = "Tribe", Text = "WOLF", TextSize = 76, StrokeThickness = 4, Size = UDim2.new(1, 0, 0, 80), TextColor3 = theme.Lighten(v90, 0.3), Parent = parent4})
            local parent5 = ui.new("TextLabel", {Name = "Tag", Text = "3 V 3", TextSize = 22, Position = UDim2.fromOffset(0, 80), Size = UDim2.new(1, 0, 0, 30), FontFace = fonts.Title, TextColor3 = colors.TextDim, Parent = parent4})
            ui.TextStroke(colors.Void, 2, 0.3).Parent = parent5
            local parent6 = ui.new("Frame", {Name = "Fighters", Position = UDim2.fromOffset(0, 130), Size = UDim2.new(1, 0, 0, 220), (ui.List(Enum.FillDirection.Horizontal, 18, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)), Parent = parent4})

            for layoutOrder = 1, 3 do
                local parent7 = ui.new("Frame", {Name = "F" .. layoutOrder, Size = UDim2.fromOffset(150, 210), LayoutOrder = layoutOrder, Parent = parent6})
                local parent8 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), Parent = parent7})
                ui.new("ImageLabel", {Name = "Img", Size = UDim2.fromOffset(150, 150), BackgroundColor3 = theme.Darken(v90, 0.6), BackgroundTransparency = 0.1, ScaleType = Enum.ScaleType.Crop, ui.Corner(theme.Radius.Pill), (ui.Stroke(v90, 3, 0)), Parent = parent8})
                local parent9 = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextSize = 21, Position = UDim2.fromOffset(-10, 156), Size = UDim2.new(1, 20, 0, 26), FontFace = fonts.Heavy, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent8})
                ui.TextStroke(colors.Void, 1.5, 0.2).Parent = parent9
                ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 15, Position = UDim2.fromOffset(0, 182), Size = UDim2.new(1, 0, 0, 20), FontFace = fonts.Bold, TextColor3 = colors.TextDim, Parent = parent8})
            end
        end

        ui.DisplayText({Name = "VS", Text = "VS", TextSize = 110, StrokeThickness = 6, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.44), Size = UDim2.fromOffset(240, 140), TextColor3 = colors.Text, Parent = parent2})
        local parent10 = ui.new("Frame", {Name = "Map", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -40), Size = UDim2.fromOffset(760, 176), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, ZIndex = 3, ui.Corner(14), (ui.Stroke(colors.Stroke, 2, 0.6)), Parent = parent2})
        ui.new("ImageLabel", {Name = "Thumb", Position = UDim2.fromOffset(9, 9), Size = UDim2.fromOffset(280, 158), BackgroundColor3 = colors.Raised, ScaleType = Enum.ScaleType.Crop, ImageTransparency = 1, ZIndex = 3, (ui.Corner(10)), Parent = parent10})
        local parent11 = ui.new("TextLabel", {Name = "MapName", Text = "", TextSize = 38, ZIndex = 3, Position = UDim2.fromOffset(306, 14), Size = UDim2.new(1, -322, 0, 40), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent10})
        ui.TextStroke(colors.Void, 2, 0.2).Parent = parent11
        ui.new("TextLabel", {Name = "Mode", Text = "3V3 · FIRST TO 5 ROUNDS", TextSize = 18, ZIndex = 3, Position = UDim2.fromOffset(306, 56), Size = UDim2.new(1, -322, 0, 22), FontFace = fonts.Heavy, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent10})
        ui.new("TextLabel", {Name = "Tip", Text = "", TextSize = 19, TextWrapped = true, ZIndex = 3, Position = UDim2.fromOffset(306, 88), Size = UDim2.new(1, -322, 0, 70), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent10})
        parent11 = ui.new("Frame", {Name = "Clash", Visible = false, ZIndex = 4, Size = UDim2.fromScale(1, 1), Parent = parent2})
        ui.Image(ui.Assets.Fx.Rays, {Name = "Rays", ImageTransparency = 1, ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(620, 620), ImageColor3 = Color3.fromRGB(255, 205, 110), Parent = parent11})
        local v110 = {}

        for index = 1, 2 do
            local parent12 = ui.new("Frame", {Name = "Crest" .. index, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(140, 151), ZIndex = 5, (ui.new("UIScale", {Name = "Fit"})), Parent = parent11})
            v110[index] = TribeEmblem.new(140, {ZIndex = 5, Parent = parent12})
        end

        ui.Image(ui.Assets.Fx.Flare, {Name = "Flare", ImageTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(1100, 120), ImageColor3 = Color3.fromRGB(255, 220, 150), Parent = parent11})
        ui.Image(ui.Assets.Fx.Ring, {Name = "Ring", ImageTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(60, 60), ImageColor3 = Color3.fromRGB(255, 214, 140), Parent = parent11})

        for index = 1, 8 do
            ui.Image(ui.Assets.Fx.Spark, {ImageTransparency = 1, ZIndex = 6, Name = "Spark" .. index, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(96, 18), ImageColor3 = Color3.fromRGB(255, 226, 160), Parent = parent11})
        end

        local parent13 = ui.DisplayText({Name = "Title", Text = "TRIBE CLASH", TextSize = 84, StrokeThickness = 5, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromOffset(900, 100), TextColor3 = Color3.fromRGB(255, 214, 110), Parent = parent11})
        ui.Gradient(Color3.fromRGB(255, 236, 170), Color3.fromRGB(240, 170, 50), 90).Parent = parent13
        local parent14 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 22, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.1, 50), Size = UDim2.fromOffset(900, 26), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent11})
        ui.TextStroke(colors.Void, 2, 0.25).Parent = parent14
        ui.new("Frame", {Name = "Flash", BackgroundTransparency = 1, ZIndex = 8, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(255, 206, 120), Parent = parent11})
        v85 = v110
        recordLook((parent11:FindFirstChild("Crest" .. 1)))
        recordLook((parent11:FindFirstChild("Crest" .. 2)))
        recordLook(parent13)
        recordLook((parent2:FindFirstChild("VS")))
        recordLook((parent2:FindFirstChild("Map")))
        local v116 = {parent2:FindFirstChild("Left"), parent2:FindFirstChild("Right")}

        for _, v118 in v116 do
            for index = 1, 3 do
                recordLook((v118:FindFirstChild("Content"):FindFirstChild("Fighters"):FindFirstChild("F" .. index):FindFirstChild("Inner")))
            end
        end

        return parent2
    end

    local function teamTribe(a121)
        --[[
          name: teamTribe
          line: 432
        ]]
        local v122
        local tribe
        local v124 = {}

        if type(a121) ~= "table" or type(a121.members) ~= "table" then
            v122 = {}
        else
            v122 = a121.members
        end

        tribe = nil

        for _, v126 in v122 do
            local tribe2 = v126.tribe

            if type(tribe2) == "table" then
                if type(tribe2.id) ~= "number" then
                    continue
                end

                v124[tribe2.id] = (v124[tribe2.id] or 0) + 1

                if not (2 <= v124[tribe2.id]) then
                    continue
                end

                tribe = tribe2
            end
        end

        return tribe
    end

    local function fillIntro(a129, a130)
        --[[
          name: fillIntro
          line: 447
          upvalues:
            state (copy, index: 1)
            a7 (copy, index: 2)
            ui (copy, index: 3)
            teamTribe (copy, index: 4)
            colors (copy, index: 5)
            Tribes (copy, index: 6)
            theme (copy, index: 7)
            portraits (copy, index: 8)
            Tips (copy, index: 9)
            v85 (ref,  index: 10)
        ]]
        local v131
        local mapThumb
        local v133
        local textSize
        local v135
        local v136 = type(a130.teams) == "table" and a130.teams
            or state.Match and state.Match.teams
            or {}
        local v137 = state.MyTeam()
        local v138 = state.TeamSize(v136)
        local v139 = v138 == 1
        local v140 = v139
            and (state.IsDuel()
                or a130.mode == "1v1"
                or not (a7.Custom and a7.Custom.IsServer and a7.Custom.IsServer()))
        local v141 = v139 and (ui.Compact and 160 or 204) or 150
        local v142 = {teamTribe(v136[v137]), (teamTribe(v136[3 - v137]))}
        local clash = v142[1] ~= nil and v142[2] ~= nil and v142[1].id ~= v142[2].id
        a129:SetAttribute("Clash", clash)

        for v144, v145 in {v137, 3 - v137} do
            local text2
            local v147 = v144 ~= 1 and "Right" or "Left"
            local v148 = a129:FindFirstChild(v147)
            local content = v148:FindFirstChild("Content")
            local v150 = v136[v145] or {}
            local tribe = content:FindFirstChild("Tribe")
            local v152 = if v144 == 1 then colors.Ally else colors.Enemy
            local v153 = if clash then Tribes.Color(v142[v144].color1) else v152

            if const uiGradient = v148:FindFirstChildOfClass("UIGradient") then
                uiGradient.Color = ColorSequence.new(theme.Darken(v153, 0.45), theme.Darken(v153, 0.82))
            end

            tribe.AutoLocalize = not clash

            if clash then
                local stringUpper = string.upper
                local v156 = v142[v144].name or v142[v144].tag
                text2 = stringUpper((tostring(v156)))
            elseif v140 then
                text2 = v144 ~= 1 and "OPPONENT" or "YOU"
            else
                text2 = v144 ~= 1 and "ENEMY TEAM" or "YOUR TEAM"
            end

            tribe.Text = text2
            tribe.TextColor3 = theme.Lighten(v153, 0.3)

            if const tag = content:FindFirstChild("Tag") then
                if tag:GetAttribute("Default") == nil then
                    tag:SetAttribute("Default", tag.Text)
                end

                local v158 = v142[v144]

                if clash then
                    local v159
                    local text = tostring(v158.tag)

                    if v144 == 1 then
                        v159 = "YOUR TRIBE"
                    else
                        v159 = "ENEMY TRIBE"
                    end

                    tag.Text = "[" .. text .. "]  ·  " .. v159
                    tag.TextColor3 = theme.Lighten(v152, 0.35)
                else
                    local v161

                    if v158 then
                        v161 = "TRIBE  [" .. tostring(v158.tag) .. "]"
                    else
                        v161 = if v138 ~= 3 then string.format("%d V %d", v138, v138) else tostring(tag:GetAttribute("Default"))
                    end

                    tag.Text = v161
                    tag.TextColor3 = if v158 then Tribes.TextColor(v158.color1) else colors.TextDim
                end
            end

            local fighters = content:FindFirstChild("Fighters")

            for memberKey = 1, 3 do
                local textSize2
                local v165 = fighters:FindFirstChild("F" .. memberKey)
                local inner = v165:FindFirstChild("Inner")
                local member = type(v150.members) == "table" and v150.members[memberKey] or nil
                v165.Visible = member ~= nil
                v165.Size = UDim2.fromOffset(v141, v141 + 60)
                local img = inner:FindFirstChild("Img")
                img.Size = UDim2.fromOffset(v141, v141)

                if const uiStroke = img:FindFirstChildOfClass("UIStroke") then
                    uiStroke.Thickness = v139 and 4 or 3
                end

                local name = inner:FindFirstChild("Name")
                name.Position = UDim2.fromOffset(-10, v141 + 6)

                if v139 then
                    textSize2 = 25
                else
                    textSize2 = 21
                end

                name.TextSize = textSize2
                local v171 = UDim2.new
                local v172 = v139 and 30 or 26
                name.Size = v171(1, 20, 0, v172)
                local sub = inner:FindFirstChild("Sub")
                v171 = UDim2.fromOffset
                local v174 = v139 and 36 or 32
                sub.Position = v171(0, v141 + v174)
                sub.TextSize = v139 and 16 or 15

                if member then
                    local v175
                    local v176
                    local apply = portraits.Apply
                    local v178 = v139 and 420 or 150
                    apply(img, member, v178)
                    local name2 = inner:FindFirstChild("Name")

                    if type(member.tribe) ~= "table" or type(member.tribe.tag) ~= "string" then
                        v175 = ""
                    else
                        v175 = "[" .. member.tribe.tag .. "] "
                    end

                    name2.Text = v175 .. tostring(member.name or "?")

                    if member.id == state.MyId() then
                        v176 = colors.Accent
                    else
                        v176 = colors.Text
                    end

                    name2.TextColor3 = v176
                    inner:FindFirstChild("Sub").Text = "LEVEL " .. tostring(member.level or 1)
                end
            end
        end

        local map = a129:FindFirstChild("Map")
        local mapName = map:FindFirstChild("MapName")
        local stringUpper = string.upper
        local mapName2 = a130.mapName or state.Match and state.Match.mapName or "ARENA"
        mapName.Text = stringUpper((tostring(mapName2)))
        local thumb = map:FindFirstChild("Thumb")
        local mapThumb2 = a130.mapThumb or state.Match and state.Match.mapThumb
        local compact = ui.Compact

        if compact then
            v131 = 200
        else
            v131 = 280
        end

        local v187 = compact and 112 or 158
        local udim2FromOffset = UDim2.fromOffset
        local v189 = compact and 640 or 760
        map.Size = udim2FromOffset(v189, v187 + 18)
        local newUDim2 = UDim2.new
        local v191 = compact and -14 or -40
        map.Position = newUDim2(0.5, 0, 1, v191)
        thumb.Size = UDim2.fromOffset(v131, v187)

        if type(mapThumb2) ~= "string" then
            mapThumb = ""
        else
            mapThumb = mapThumb2
        end

        thumb.Image = mapThumb
        thumb.Visible = thumb.Image ~= ""

        if thumb.Visible then
            if thumb.IsLoaded then
                thumb.ImageTransparency = 0
            else
                thumb.ImageTransparency = 1

                task.spawn(
                    function()
                        --[[
                          line: 543
                          upvalues:
                            a7 (copy, index: 1)
                            thumb (copy, index: 2)
                            ui (copy, index: 3)
                            theme (copy, index: 4)
                        ]]
                        a7.PreloadThumb(thumb.Image, true)

                        if thumb.Image ~= "" then
                            ui.Tween(thumb, theme.Tween.Smooth, {ImageTransparency = 0})
                        end
                    end
                )
            end
        end

        local visible = thumb.Visible

        if visible then
            v133 = v131 + 26
        else
            v133 = 16
        end

        for _, v194 in {"MapName", "Mode", "Tip"} do
            local v195 = map:FindFirstChild(v194)
            v195.Position = UDim2.fromOffset(v133, v195.Position.Y.Offset)
            v195.Size = UDim2.new(1, -(v133 + 16), 0, v195.Size.Y.Offset)
            v195.TextXAlignment = if visible then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center
        end

        local tip = map:FindFirstChild("Tip")
        tip.Text = "TIP  ·  " .. Tips.Next()
        tip.Size = UDim2.new(1, -(v133 + 16), 0, v187 - 80)

        if compact then
            textSize = 17
        else
            textSize = 19
        end

        tip.TextSize = textSize
        local v197 = tonumber((a130 and a130.roundsToWin)) or state.RoundsToWin()
        local holder = a130 and a130.holder

        if type(holder) ~= "table" or type(holder.tag) ~= "string" then
            v135 = ""
        else
            v135 = "  ·  HELD BY [" .. holder.tag .. "]"
        end

        map:FindFirstChild("Mode").Text = string.format("%dV%d  ·  BEST OF %d%s", v138, v138, (v197 * 2) - 1, v135)
        local clash2 = a129:FindFirstChild("Clash")
        clash2.Visible = clash

        if clash then
            local v200 = v142[1]
            local v201 = v85[1]
            v201:Set(v200.icon, v200.color1, v200.color2, v200.tag)
            local v202 = v142[2]
            local v203 = v85[2]
            v203:Set(v202.icon, v202.color1, v202.color2, v202.tag)
            local stringUpper2 = string.upper
            local mapName3 = a130.mapName or state.Match and state.Match.mapName or "this map"
            local uppercaseText = stringUpper2((tostring(mapName3)))
            local sub = clash2:FindFirstChild("Sub")
            local isServer = a7.Custom and a7.Custom.IsServer and a7.Custom.IsServer()
            local v209 = false

            if isServer then
                sub.Text = "CUSTOM MATCH  ·  NO GLORY AT STAKE"
                return
            end

            if type(holder) == "table" then
                if holder.id == v142[1].id then
                    v209 = true
                elseif holder.id == v142[2].id then
                    v209 = true
                end
            end

            if v209 then
                sub.Text = `[{holder.tag}] DEFENDS {uppercaseText}`
                return
            end

            if type(holder) == "table" then
                sub.Text = `{uppercaseText}  ·  HELD BY [{holder.tag}]`
                return
            end

            sub.Text = `GLORY DECIDES WHO HOLDS {uppercaseText}`
        end
    end

    local result = nil

    local function lookLock(a212: boolean)
        --[[
          name: lookLock
          line: 597
          upvalues:
            result (ref,  index: 1)
            replicatedStorage (copy, index: 2)
        ]]
        if result == nil then
            local camera = replicatedStorage:WaitForChild("Shared"):FindFirstChild("Camera")

            local success, result2 = pcall(
                function()
                    --[[
                      line: 600
                      upvalues:
                        camera (copy, index: 1)
                    ]]
                    if camera then
                        return (require(camera))
                    end

                    return nil
                end
            )

            if not success or type(result2) ~= "table" then
                result = false
            else
                result = result2
            end
        end

        if result and result.PushLookLock then
            if a212 then
                result.PushLookLock("Intro")
            else
                result.PopLookLock("Intro")
            end
        end
    end

    local function c01(a217: number)
        --[[
          name: c01
          line: 622
        ]]
        return (math.clamp(a217, 0, 1))
    end

    local function quadIn(a219)
        --[[
          name: quadIn
          line: 625
        ]]
        return a219 * a219
    end

    local function quadOut(a221)
        --[[
          name: quadOut
          line: 628
        ]]
        return 1 - ((1 - a221) * (1 - a221))
    end

    local function quartOut(a223)
        --[[
          name: quartOut
          line: 631
        ]]
        return 1 - ((1 - a223) ^ 4)
    end

    local function quintOut(a225)
        --[[
          name: quintOut
          line: 634
        ]]
        return 1 - ((1 - a225) ^ 5)
    end

    local function backOut(a227)
        --[[
          name: backOut
          line: 637
        ]]
        local v228 = a227 - 1
        return (((v228 * 2.70158) * v228) * v228) + 1 + ((v228 * 1.70158) * v228)
    end

    local function lerp(a230, a231, a232)
        --[[
          name: lerp
          line: 641
        ]]
        return a230 + ((a231 - a230) * a232)
    end

    local function newClashState(a234: number?)
        --[[
          name: newClashState
          line: 645
        ]]
        local random = Random.new((a234 or (os.clock() * 1000)))
        local sparks = {}

        for index = 1, 8 do
            sparks[index] = {a = (((index - 1) / 8) * math.pi) * 2 + random:NextNumber(-0.25, 0.25), d = random:NextNumber(170, 260), dur = random:NextNumber(0.35, 0.5)}
        end

        return {sparks = sparks}
    end

    local function clashLook(a239, a240, a241, a242)
        --[[
          name: clashLook
          line: 655
          upvalues:
            ui (copy, index: 1)
            v85 (ref,  index: 2)
            setFade (copy, index: 3)
        ]]
        local v243
        local backgroundTransparency
        local v245
        local imageTransparency
        local imageTransparency2
        local clash = a239:FindFirstChild("Clash")
        local compact = ui.Compact

        if compact then
            v243 = 0.085
        else
            v243 = 0.4
        end

        local v250 = compact and 28 or 56
        local v251 = compact and 232 or 80

        local function vis(a253)
            --[[
              name: vis
              line: 660
              upvalues:
                a241 (copy, index: 1)
            ]]
            return 1 - ((1 - a253) * (1 - a241))
        end

        local v254 = a240 - 0.45

        for index = 1, 2 do
            local scale
            local v257 = clash:FindFirstChild("Crest" .. index)
            local v258 = index ~= 1 and 1 or -1
            local startValue = UDim2.new((v258 * 0.62) + 0.5, 0, v243, 0)
            local udim2 = UDim2.new(0.5, v258 * v250, v243, 0)
            local targetValue = UDim2.new(0.5, v258 * v251, v243, 0)

            if not (v254 < 0) then
                v257.Position = udim2:Lerp(targetValue, 1 - ((1 - math.clamp(v254 / 0.45, 0, 1)) ^ 5))
                v257.Rotation = 0
            else
                local clampedValue = math.clamp((a240 - 0.09) / 0.36, 0, 1)
                local alpha = clampedValue * clampedValue
                v257.Position = startValue:Lerp(udim2, alpha)
                v257.Rotation = v258 * 18 * (1 - alpha)
            end

            v257:FindFirstChild("Fit").Scale = compact and 0.5 or 1
            local scaleObj = ui.GetScaleObj(v85[index].Instance)

            if not (v254 < 0) then
                local v265 = math.clamp(v254 / 0.35, 0, 1) - 1
                scale = ((((v265 * 2.70158) * v265) * v265) + 1 + ((v265 * 1.70158) * v265)) * -0.17999999999999994 + 1.18
            else
                scale = 1
            end

            scaleObj.Scale = scale
            setFade(v257, a241)
        end

        local flash = clash:FindFirstChild("Flash")

        if not (v254 < 0) then
            local clampedValue = math.clamp(v254 / 0.32, 0, 1)
            backgroundTransparency = 1 - (1 - (((1 - ((1 - clampedValue) * (1 - clampedValue))) * 0.5) + 0.5)) * (1 - a241)
        else
            backgroundTransparency = 1
        end

        flash.BackgroundTransparency = backgroundTransparency
        local ring = clash:FindFirstChild("Ring")
        local v269 = 1 - (1 - math.clamp(v254 / 0.55, 0, 1)) ^ 4

        if compact then
            v245 = 380
        else
            v245 = 640
        end

        ring.Position = UDim2.fromScale(0.5, v243)
        ring.Size = UDim2.fromOffset(((v245 - 60) * v269) + 60, ((v245 - 60) * v269) + 60)
        ring.ImageTransparency = v254 < 0 and 1 or 1 - (1 - ((v269 * 0.95) + 0.05)) * (1 - a241)
        local flare = clash:FindFirstChild("Flare")
        local v271 = 1 - (1 - math.clamp(v254 / 0.5, 0, 1)) ^ 4
        flare.Position = UDim2.fromScale(0.5, v243)
        flare.Size = UDim2.fromOffset((v271 * 1060) + 240, (v271 * 40) + 90)

        if not (v254 < 0) then
            imageTransparency = 1 - (1 - v271) * (1 - a241)
        else
            imageTransparency = 1
        end

        flare.ImageTransparency = imageTransparency

        for v272, spark in a242.sparks do
            local v274
            local imageTransparency3
            local v276 = clash:FindFirstChild("Spark" .. v272)
            local v277 = 1 - (1 - math.clamp(v254 / spark.dur, 0, 1)) ^ 4
            local d = spark.d

            if compact then
                v274 = 0.6
            else
                v274 = 1
            end

            local v279 = d * v274 * v277
            v276.Rotation = math.deg(spark.a)
            v276.Position = UDim2.new(0.5, math.cos(spark.a) * v279, v243, math.sin(spark.a) * v279)
            v276.Size = UDim2.fromOffset((v277 * -70) + 110, (v277 * -10) + 18)

            if not (v254 < 0) then
                imageTransparency3 = 1 - (1 - v277) * (1 - a241)
            else
                imageTransparency3 = 1
            end

            v276.ImageTransparency = imageTransparency3
        end

        local vector2 = Vector2.zero

        if 0 <= v254 and v254 < 0.14 then
            vector2 = ({Vector2.new(10, -6), Vector2.new(-8, 5), Vector2.new(5, 3), Vector2.new(-3, -2)})[math.floor(v254 / 0.035) + 1]
        end

        a239.Position = UDim2.fromOffset(vector2.X, vector2.Y)
        local rays = clash:FindFirstChild("Rays")
        rays.Position = UDim2.fromScale(0.5, v243)
        rays.Size = if compact then UDim2.fromOffset(380, 380) else UDim2.fromOffset(620, 620)

        if not (v254 < 0) then
            local clampedValue = math.clamp(v254 / 0.6, 0, 1)
            imageTransparency2 = 1 - (1 - (((1 - ((1 - clampedValue) * (1 - clampedValue))) * 0.20000000000000007) + 0.35)) * (1 - a241)
        else
            imageTransparency2 = 1
        end

        rays.ImageTransparency = imageTransparency2
        rays.Rotation = math.clamp(v254 / 6, 0, 1) * 40
        local title = clash:FindFirstChild("Title")
        title.Visible = 0 <= v254
        local udim2FromScale = UDim2.fromScale
        local v285 = compact and 0.085 or 0.1
        title.Position = udim2FromScale(0.5, v285)
        title.TextSize = compact and 54 or 84
        local scaleObj = ui.GetScaleObj(title)
        local v287 = math.clamp(v254 / 0.28, 0, 1) - 1
        scaleObj.Scale = (((((v287 * 2.70158) * v287) * v287) + 1 + ((v287 * 1.70158) * v287)) * -1.2000000000000002) + 2.2
        setFade(title, a241)
        local sub = clash:FindFirstChild("Sub")
        sub.Visible = not compact
        local clampedValue = math.clamp((v254 - 0.15) / 0.3, 0, 1)
        local v290 = 1 - (1 - clampedValue) * (1 - clampedValue)
        sub.TextTransparency = 1 - ((1 - (1 - v290)) * (1 - a241))

        if const uiStroke = sub:FindFirstChildOfClass("UIStroke") then
            uiStroke.Transparency = 1 - ((1 - ((v290 * -0.75) + 1)) * (1 - a241))
        end
    end

    local v292 = nil

    local function stopClash()
        --[[
          name: stopClash
          line: 735
          upvalues:
            v292 (ref, index: 1)
        ]]
        if v292 then
            v292.conn:Disconnect()
            v292 = nil
        end
    end

    local function playClash(a295)
        --[[
          name: playClash
          line: 741
          upvalues:
            v292 (ref,  index: 1)
            newClashState (copy, index: 2)
            a7 (copy, index: 3)
            runService (copy, index: 4)
            clashLook (copy, index: 5)
        ]]
        if v292 then
            v292.conn:Disconnect()
            v292 = nil
        end

        local v296 = newClashState()
        local timestamp = os.clock()
        local v298 = false
        a7.Sounds.Play("UI/Whoosh")
        local v299 = {}

        v299.conn = runService.RenderStepped:Connect(
            function()
                --[[
                  line: 748
                  upvalues:
                    timestamp (copy, index: 1)
                    v298 (ref,  index: 2)
                    a7 (copy, index: 3)
                    v299 (copy, index: 4)
                    clashLook (copy, index: 5)
                    a295 (copy, index: 6)
                    v296 (copy, index: 7)
                    v292 (ref,  index: 8)
                ]]
                local timestamp2 = os.clock()
                local elapsedTime = timestamp2 - timestamp

                if not v298 and 0.45 <= elapsedTime then
                    v298 = true
                    a7.Sounds.Play("Match/Tribe_Clash")
                end

                local v302 = not v299.outAt and 0 or math.clamp((timestamp2 - v299.outAt) / 0.2, 0, 1)
                clashLook(a295, elapsedTime, v302, v296)

                if 1 <= v302 and v292 then
                    v292.conn:Disconnect()
                    v292 = nil
                end
            end
        )

        v292 = v299
        clashLook(a295, 0, 0, v296)
    end

    local function hideIntro(a304: nil)
        --[[
          name: hideIntro
          line: 765
          upvalues:
            count2 (ref,  index: 1)
            lookLock (copy, index: 2)
            v66 (ref,  index: 3)
            a7 (copy, index: 4)
            v292 (ref,  index: 5)
            ui (copy, index: 6)
        ]]
        count2 += 1
        lookLock(false)
        local v305 = v66

        if not v305 or not v305.Visible then
            return
        end

        a7.SetHudHidden("Intro", false)

        if a304 then
            if v292 then
                v292.conn:Disconnect()
                v292 = nil
            end

            v305.Visible = false

            return
        end

        local v306 = count2
        local left = v305:FindFirstChild("Left")
        local right = v305:FindFirstChild("Right")
        ui.Tween(left, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.fromScale(-0.55, 0)})
        ui.Tween(right, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.fromScale(1.55, 0)})
        ui.FadeOut(v305:FindFirstChild("VS"), TweenInfo.new(0.2))
        ui.FadeOut(v305:FindFirstChild("Map"), TweenInfo.new(0.2))

        if v292 then
            v292.outAt = os.clock()
        end

        task.delay(
            0.36,
            function()
                --[[
                  line: 788
                  upvalues:
                    v306 (copy, index: 1)
                    count2 (ref,  index: 2)
                    v305 (copy, index: 3)
                ]]
                if v306 == count2 then
                    v305.Visible = false
                end
            end
        )
    end

    local function showIntro(a310)
        --[[
          name: showIntro
          line: 795
          upvalues:
            v66 (ref,  index: 1)
            buildIntro (copy, index: 2)
            fillIntro (copy, index: 3)
            count2 (ref,  index: 4)
            a7 (copy, index: 5)
            lookLock (copy, index: 6)
            ui (copy, index: 7)
            playClash (copy, index: 8)
            theme (copy, index: 9)
            state (copy, index: 10)
            hideIntro (copy, index: 11)
        ]]
        v66 = v66 or buildIntro()
        local v311 = v66
        fillIntro(v311, a310)
        count2 += 1
        local v312 = count2
        v311.Visible = true
        a7.SetHudHidden("Intro", true)
        lookLock(true)
        local left = v311:FindFirstChild("Left")
        local right = v311:FindFirstChild("Right")
        left.Position = UDim2.fromScale(-0.55, 0)
        right.Position = UDim2.fromScale(1.55, 0)
        ui.Tween(left, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {Position = UDim2.fromScale(0, 0)})
        ui.Tween(right, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {Position = UDim2.fromScale(1, 0)})
        local vs = v311:FindFirstChild("VS")
        ui.Unfade(vs)
        vs.Visible = false

        if v311:GetAttribute("Clash") ~= true then
            task.delay(
                0.35,
                function()
                    --[[
                      line: 816
                      upvalues:
                        v312 (copy, index: 1)
                        count2 (ref,  index: 2)
                        vs (copy, index: 3)
                        ui (copy, index: 4)
                        theme (copy, index: 5)
                    ]]
                    if v312 ~= count2 then
                        return
                    end

                    vs.Visible = true
                    ui.Pop(vs, 2.4, theme.Tween.Slam)
                end
            )
        else
            playClash(v311)
        end

        local map = v311:FindFirstChild("Map")
        ui.Unfade(map)
        ui.Enter(map, Vector2.new(0, 40), 0.5)

        for index = 1, 2 do
            local v318 = if index == 1 then left else right
            local fighters = v318:FindFirstChild("Content"):FindFirstChild("Fighters")

            for index2 = 1, 3 do
                local inner = fighters:FindFirstChild("F" .. index2):FindFirstChild("Inner")
                ui.Unfade(inner)
                ui.Enter(inner, Vector2.new(0, 30), (index2 * 0.08) + 0.2, UDim2.new())
            end
        end

        local phaseEndsAt = state.Match and state.Match.phase == "Intro" and state.Match.phaseEndsAt or 0
        local v323 = not (0 < phaseEndsAt) and 4 or math.clamp(phaseEndsAt - state.Now(), 1.5, 6)

        task.delay(
            v323 - 0.3,
            function()
                --[[
                  line: 840
                  upvalues:
                    v312 (copy, index: 1)
                    count2 (ref,  index: 2)
                    hideIntro (copy, index: 3)
                ]]
                if v312 == count2 then
                    hideIntro()
                end
            end
        )
    end

    local v324 = nil

    a7.Debug.introScrub = function(a325, a326, a327)
        --[[
          line: 852
          upvalues:
            v292 (ref,  index: 1)
            count2 (ref,  index: 2)
            v66 (ref,  index: 3)
            buildIntro (copy, index: 4)
            fillIntro (copy, index: 5)
            v324 (ref,  index: 6)
            newClashState (copy, index: 7)
            ui (copy, index: 8)
            setFade (copy, index: 9)
            clashLook (copy, index: 10)
            a7 (copy, index: 11)
        ]]
        if type(a325) == "table" then
            if v292 then
                v292.conn:Disconnect()
                v292 = nil
            end

            count2 += 1
            v66 = v66 or buildIntro()
            fillIntro(v66, a325)
            v66.Visible = true
            v324 = newClashState(7)
        end

        local v328 = v66

        if not v328 or type(a326) ~= "number" then
            return false
        end

        local v329
        local v330

        if type(a327) ~= "number" then
            v329 = 3
        else
            v329 = a327
        end

        local v331 = v329 - 0.3
        local clash = v328:GetAttribute("Clash") == true
        local v333 = 1 - (1 - math.clamp(a326 / 0.45, 0, 1)) ^ 5
        local clampedValue = math.clamp((a326 - v331) / 0.35, 0, 1)
        local v335 = clampedValue * clampedValue
        v328:FindFirstChild("Left").Position = UDim2.fromScale(((v333 * 0.55) + -0.55) - (v335 * 0.55), 0)
        v328:FindFirstChild("Right").Position = UDim2.fromScale(((v333 * -0.55) + 1.55) + (v335 * 0.55), 0)
        local clampedValue2 = math.clamp((a326 - v331) / 0.2, 0, 1)
        local vs = v328:FindFirstChild("VS")
        vs.Visible = not clash and (0.35 <= a326)
        local scaleObj = ui.GetScaleObj(vs)
        local v339 = math.clamp((a326 - 0.35) / 0.28, 0, 1) - 1
        scaleObj.Scale = (((((v339 * 2.70158) * v339) * v339) + 1 + ((v339 * 1.70158) * v339)) * -1.4) + 2.4
        setFade(vs, clampedValue2)
        local map = v328:FindFirstChild("Map")
        local newUDim2 = UDim2.new

        if ui.Compact then
            v330 = -14
        else
            v330 = -40
        end

        local v342 = math.clamp((a326 - 0.5) / 0.36, 0, 1) - 1
        map.Position = newUDim2(0.5, 0, 1, v330 + ((1 - ((((v342 * 2.70158) * v342) * v342) + 1 + ((v342 * 1.70158) * v342))) * 40))
        local clampedValue3 = math.clamp((a326 - 0.5) / 0.2, 0, 1)
        local imageTransparency = math.max(1 - (1 - (1 - clampedValue3) * (1 - clampedValue3)), clampedValue2)
        setFade(map, imageTransparency)
        local thumb = map:FindFirstChild("Thumb")

        if thumb.Image ~= "" then
            thumb.ImageTransparency = imageTransparency
        end

        for index = 1, 2 do
            local v347 = index ~= 1 and "Right" or "Left"
            local fighters = v328:FindFirstChild(v347):FindFirstChild("Content"):FindFirstChild("Fighters")

            for index2 = 1, 3 do
                local inner = fighters:FindFirstChild("F" .. index2):FindFirstChild("Inner")
                local v351 = index2 * 0.08 + 0.2
                local udim2FromOffset = UDim2.fromOffset
                local v353 = math.clamp((a326 - v351) / 0.36, 0, 1) - 1
                inner.Position = udim2FromOffset(0, (1 - ((((v353 * 2.70158) * v353) * v353) + 1 + ((v353 * 1.70158) * v353))) * 30)
                local clampedValue4 = math.clamp((a326 - v351) / 0.2, 0, 1)
                setFade(inner, 1 - (1 - ((1 - clampedValue4) * (1 - clampedValue4))))
            end
        end

        if clash and v324 then
            clashLook(v328, a326, math.clamp((a326 - v331) / 0.2, 0, 1), v324)
        else
            v328.Position = UDim2.new()
        end

        v328.Visible = a326 < (v329 + 0.06)
        a7.SetHudHidden("Intro", a326 < v331)

        return true
    end

    local v355 = 8
    local config = replicatedStorage:FindFirstChild("Shared") and replicatedStorage.Shared:FindFirstChild("Config")

    local success, result2 = pcall(
        function()
            --[[
              line: 918
              upvalues:
                config (copy, index: 1)
            ]]
            if config then
                return (require(config))
            end

            return nil
        end
    )

    if success then
        if type(result2) ~= "table" then
            v9 = v355
        elseif type(result2.PRE_ROUND_TIME) ~= "number" then
            v9 = v355
        else
            v9 = math.clamp(math.floor(result2.PRE_ROUND_TIME), 3, 9)
        end
    else
        v9 = v355
    end

    local v359 = ui.new
    local v360 = {Name = "Countdown", Visible = false, AnchorPoint = Vector2.new(0.5, 0.5)}
    local udim2FromScale = UDim2.fromScale
    local v362 = ui.Compact and 0.3 or 0.36
    v360.Position = udim2FromScale(0.5, v362)
    v360.Size = UDim2.fromOffset(700, 200)
    v360.Parent = parent
    v359 = v359("Frame", v360)

    local function cdLabel(name: string, textColor3)
        --[[
          name: cdLabel
          line: 934
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            v359 (copy, index: 3)
            colors (copy, index: 4)
        ]]
        local ui2 = ui.new("TextLabel", {Text = "", TextSize = 100, TextTransparency = 1, Visible = false, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(700, 130), FontFace = fonts.Display, TextColor3 = textColor3, Parent = v359})
        local stroke = ui.TextStroke(colors.Void, 2, 1)
        stroke.Parent = ui2
        local scale = ui.new("UIScale", {Name = "Scale", Parent = ui2})

        return {text = "", a = 0, s = 1, y = 0, on = false, label = ui2, stroke = stroke, scale = scale}
    end

    local v369 = cdLabel("DigitOdd", colors.Bone)
    local v370 = cdLabel("DigitEven", colors.Bone)
    local v371 = {[1] = tostring(1), [2] = tostring(2), [3] = tostring(3), [4] = tostring(4), [5] = tostring(5), [6] = tostring(6), [7] = tostring(7), [8] = tostring(8), [9] = tostring(9)}

    ui.LayoutChanged:Connect(
        function()
            --[[
              line: 958
              upvalues:
                v359 (copy, index: 1)
                ui (copy, index: 2)
            ]]
            local udim2FromScale = UDim2.fromScale
            local v373 = ui.Compact and 0.3 or 0.36
            v359.Position = udim2FromScale(0.5, v373)
        end
    )

    local v374 = cdLabel("Fight", colors.Accent)
    v374.label.Text = "FIGHT!"
    v374.text = "FIGHT!"

    local function put(a376, text: string?, a, a379, a380)
        --[[
          name: put
          line: 964
        ]]
        if a <= 0.004 then
            if a376.on then
                a376.on = false
                a376.label.Visible = false
            end

            return
        end

        if a376.text ~= text then
            a376.text = text
            a376.label.Text = text
        end

        if 0.003 < math.abs(a376.a - a) or not a376.on then
            a376.a = a
            a376.label.TextTransparency = 1 - a
            a376.stroke.Transparency = 1 - (a * 0.85)
        end

        if 8e-04 < math.abs(a376.s - a379) or not a376.on then
            a376.s = a379
            a376.scale.Scale = a379
        end

        local y = math.floor(a380 + 0.5)

        if a376.y ~= y or not a376.on then
            a376.y = y
            a376.label.Position = UDim2.new(0.5, 0, 0.5, y)
        end

        if not a376.on then
            a376.on = true
            a376.label.Visible = true
        end
    end

    local function cdBase()
        --[[
          name: cdBase
          line: 995
          upvalues:
            ui (copy, index: 1)
        ]]
        if ui.Compact then
            return 1.5
        end

        return 1.8
    end

    local function outBack(a384)
        --[[
          name: outBack
          line: 998
        ]]
        local v385 = a384 - 1
        return (((v385 * 2.5) * v385) * v385) + 1 + ((v385 * 1.5) * v385)
    end

    local function outCubic(a387)
        --[[
          name: outCubic
          line: 1003
        ]]
        local v388 = 1 - a387
        return 1 - ((v388 * v388) * v388)
    end

    local function digitLook(a390)
        --[[
          name: digitLook
          line: 1011
        ]]
        if a390 < 0 then
            return 0, 1, 0
        end

        if a390 < 0.2 then
            local v391 = math.min(1, a390 / 0.06)
            local v392 = a390 / 0.2 - 1

            return v391, 1.4 - (((((v392 * 2.5) * v392) * v392) + 1 + ((v392 * 1.5) * v392)) * 0.4), 0
        end

        if a390 < 0.84 then
            return 1, 1 - (((a390 - 0.2) * 0.03) / 0.6399999999999999), 0
        end

        local v393 = math.min(1, (a390 - 0.84) / 0.22)
        local v394 = 1 - v393 * v393
        local v395 = 1 - v393
        local v396 = 0.97 - (1 - ((v395 * v395) * v395)) * 0.2
        local v397 = 1 - v393

        return v394, v396, (1 - ((v397 * v397) * v397)) * -14
    end

    local function fightLook(a399)
        --[[
          name: fightLook
          line: 1023
        ]]
        if a399 < 0 or 1 <= a399 then
            return 0, 1, 0
        end

        if a399 < 0.2 then
            local v400 = math.min(1, a399 / 0.05)
            local v401 = a399 / 0.2 - 1

            return v400, 1.6 - (((((v401 * 2.5) * v401) * v401) + 1 + ((v401 * 1.5) * v401)) * 0.6), 0
        end

        if a399 < 0.72 then
            return 1, 1, 0
        end

        local v402 = (a399 - 0.72) / 0.28
        local v403 = 1 - v402 * v402
        local v404 = 1 - v402

        return v403, ((1 - ((v404 * v404) * v404)) * 0.12) + 1, 0
    end

    local function digitStyle(a406)
        --[[
          name: digitStyle
          line: 1035
        ]]
        if 3 < a406 then
            return 0.8, 0.82
        end

        return 1, 1
    end

    local v407 = nil
    local v408 = 0
    local v409 = 1
    local decider = false
    local timestamp = 0
    local digit = 0
    local fought = false

    local function cdClear()
        --[[
          name: cdClear
          line: 1049
          upvalues:
            v369 (copy, index: 1)
            v370 (copy, index: 2)
            v374 (copy, index: 3)
            v359 (copy, index: 4)
        ]]
        if v369.on then
            v369.on = false
            v369.label.Visible = false
        end

        if v370.on then
            v370.on = false
            v370.label.Visible = false
        end

        if v374.on then
            v374.on = false
            v374.label.Visible = false
        end

        v359.Visible = false
    end

    local function cdStop(a416: nil)
        --[[
          name: cdStop
          line: 1055
          upvalues:
            v407 (ref,  index: 1)
            decider (ref,  index: 2)
            fought (ref,  index: 3)
            a7 (copy, index: 4)
            v369 (copy, index: 5)
            v370 (copy, index: 6)
            v374 (copy, index: 7)
            v359 (copy, index: 8)
            v26 (ref,  index: 9)
            v27 (ref,  index: 10)
            stopFades (copy, index: 11)
            parent3 (copy, index: 12)
            uiStroke2 (copy, index: 13)
            fadeTo (copy, index: 14)
        ]]
        if v407 and decider and not fought and a7.Decider then
            a7.Decider.Stop(false)
        end

        v407 = nil

        if v369.on then
            v369.on = false
            v369.label.Visible = false
        end

        if v370.on then
            v370.on = false
            v370.label.Visible = false
        end

        if v374.on then
            v374.on = false
            v374.label.Visible = false
        end

        v359.Visible = false

        if a416 then
            v26 = false
            v27 += 1
            stopFades(parent3, uiStroke2)
            parent3.Visible = false

            return
        end

        v27 += 1
        local v417 = v27

        if v26 then
            v26 = false
            fadeTo(parent3, "TextTransparency", 1, 0.2)
            fadeTo(uiStroke2, "Transparency", 1, 0.2)

            task.delay(
                0.21,
                function()
                    --[[
                      line: 118
                      upvalues:
                        v417 (copy, index: 1)
                        v27 (ref,  index: 2)
                        v26 (ref,  index: 3)
                        parent3 (copy, index: 4)
                    ]]
                    if v417 == v27 and not v26 then
                        parent3.Visible = false
                    end
                end
            )
        end
    end

    local function cdBegin(a419, a420, a421)
        --[[
          name: cdBegin
          line: 1070
          upvalues:
            v407 (ref,  index: 1)
            v408 (ref,  index: 2)
            v409 (ref,  index: 3)
            timestamp (ref,  index: 4)
            digit (ref,  index: 5)
            fought (ref,  index: 6)
            decider (ref,  index: 7)
            a7 (copy, index: 8)
            state (copy, index: 9)
            count (ref,  index: 10)
            stopFades (copy, index: 11)
            parent2 (copy, index: 12)
            uiStroke (copy, index: 13)
            v26 (ref,  index: 14)
            parent3 (copy, index: 15)
            v369 (copy, index: 16)
            v370 (copy, index: 17)
            v374 (copy, index: 18)
            v359 (copy, index: 19)
        ]]
        v407 = a419
        v408 = a421
        v409 = a420
        timestamp = 0
        digit = 0
        fought = false
        decider = a7.Decider ~= nil and a7.Decider.IsDecider(state.Match)
        count += 1
        stopFades(parent2, uiStroke)
        parent2.Visible = false

        if not v26 then
            parent3.Visible = false
        end

        if v369.on then
            v369.on = false
            v369.label.Visible = false
        end

        if v370.on then
            v370.on = false
            v370.label.Visible = false
        end

        if v374.on then
            v374.on = false
            v374.label.Visible = false
        end

        v359.Visible = false
    end

    local function cdOnShow()
        --[[
          name: cdOnShow
          line: 1082
          upvalues:
            decider (ref,  index: 1)
            a7 (copy, index: 2)
            v409 (ref,  index: 3)
            state (copy, index: 4)
            pinSub (copy, index: 5)
            colors (copy, index: 6)
        ]]
        if decider then
            a7.Decider.Intro(v409)
            return
        end

        local match = state.Match
        local v424 = state.RoundsToWin()
        local v425 = false

        if match then
            local score = match.teams[1].score or 0

            if v424 - 1 <= score then
                v425 = true
            end

            local score2 = match.teams[2].score or 0

            if v424 - 1 <= score2 then
                v425 = true
            end
        end

        local text = v425 and "MATCH POINT" or "ROUND " .. v409
        local v429 = if v425 then colors.Warning else colors.TextDim
        pinSub(text, v429)
    end

    cdFrame = function()
        --[[
          name: cdFrame
          line: 1099
          upvalues:
            state (copy, index: 1)
            v407 (ref,  index: 2)
            v409 (ref,  index: 3)
            v408 (ref,  index: 4)
            timestamp (ref,  index: 5)
            digit (ref,  index: 6)
            fought (ref,  index: 7)
            decider (ref,  index: 8)
            a7 (copy, index: 9)
            count (ref,  index: 10)
            stopFades (copy, index: 11)
            parent2 (copy, index: 12)
            uiStroke (copy, index: 13)
            v26 (ref,  index: 14)
            parent3 (copy, index: 15)
            v369 (copy, index: 16)
            v370 (copy, index: 17)
            v374 (copy, index: 18)
            v359 (copy, index: 19)
            cdStop (copy, index: 20)
            v66 (ref,  index: 21)
            cdOnShow (copy, index: 22)
            v9 (ref,  index: 23)
            v27 (ref,  index: 24)
            fadeTo (copy, index: 25)
            uiStroke2 (copy, index: 26)
            ui (copy, index: 27)
            digitLook (copy, index: 28)
            put (copy, index: 29)
            v371 (copy, index: 30)
        ]]
        local ceilingValue
        local v431, v432, v433 = state.PhaseClock()

        if v431 == "PreRound" and 0 < v432 then
            local v434 = state.Get("MatchId") or "?"

            if v434 ~= v407 or v433 ~= v409 or 0.05 < math.abs(v432 - v408) then
                v407 = v434
                v408 = v432
                v409 = v433
                timestamp = 0
                digit = 0
                fought = false
                decider = a7.Decider ~= nil and a7.Decider.IsDecider(state.Match)
                count += 1
                stopFades(parent2, uiStroke)
                parent2.Visible = false

                if not v26 then
                    parent3.Visible = false
                end

                if v369.on then
                    v369.on = false
                    v369.label.Visible = false
                end

                if v370.on then
                    v370.on = false
                    v370.label.Visible = false
                end

                if v374.on then
                    v374.on = false
                    v374.label.Visible = false
                end

                v359.Visible = false
            end
        end

        if not v407 then
            return
        end

        local v435 = v408 - state.Now()

        if v431 ~= "PreRound" and v431 ~= "Live" or v435 < -1.05 then
            cdStop()
            return
        end

        if v66 and v66.Visible then
            timestamp = 0

            if v369.on then
                v369.on = false
                v369.label.Visible = false
            end

            if v370.on then
                v370.on = false
                v370.label.Visible = false
            end

            if v374.on then
                v374.on = false
                v374.label.Visible = false
            end

            v359.Visible = false

            return
        end

        if timestamp == 0 then
            timestamp = os.clock()
            cdOnShow()
        end

        local v436 = math.min(1, (os.clock() - timestamp) / 0.15)

        if not (0 < v435) then
            ceilingValue = 0
        else
            ceilingValue = math.ceil(v435)
        end

        if ceilingValue ~= digit and 1 <= ceilingValue and ceilingValue <= v9 then
            digit = ceilingValue

            if decider then
                a7.Decider.Digit(ceilingValue)
            end
        end

        if v435 <= 0 and not fought then
            fought = true
            v27 += 1
            local v437 = v27

            if v26 then
                v26 = false
                fadeTo(parent3, "TextTransparency", 1, 0.2)
                fadeTo(uiStroke2, "Transparency", 1, 0.2)

                task.delay(
                    0.21,
                    function()
                        --[[
                          line: 118
                          upvalues:
                            v437 (copy, index: 1)
                            v27 (ref,  index: 2)
                            v26 (ref,  index: 3)
                            parent3 (copy, index: 4)
                        ]]
                        if v437 == v27 and not v26 then
                            parent3.Visible = false
                        end
                    end
                )
            end

            if decider then
                a7.Decider.Fight()
            end
        end

        if decider then
            if v369.on then
                v369.on = false
                v369.label.Visible = false
            end

            if v370.on then
                v370.on = false
                v370.label.Visible = false
            end

            if v374.on then
                v374.on = false
                v374.label.Visible = false
            end

            v359.Visible = false

            return
        end

        local index
        local v439, v440, _

        if not v359.Visible then
            v359.Visible = true
        end

        local v442 = ui.Compact and 1.5 or 1.8

        for index = ceilingValue, ceilingValue + 1 do
            local v443 = if index % 2 == 1 then v369 else v370

            if 1 <= index and index <= v9 then
                local v444, v445
                local v446, v447, v448 = digitLook(index - v435)

                if not (3 < index) then
                    v444 = 1
                    v445 = 1
                else
                    v444 = 0.8
                    v445 = 0.82
                end

                put(v443, v371[index], (v446 * v445) * v436, (v442 * v444) * v447, v448 * v442)
            elseif v443.on then
                v443.on = false
                v443.label.Visible = false
            end
        end

        local v449 = false
        local v450 = -v435

        if v450 < 0 then
            v449 = true
        elseif not (1 <= v450) then
            if not (v450 < 0.2) then
                if not (v450 < 0.72) then
                    local v451 = (v450 - 0.72) / 0.28
                    v439 = 1 - v451 * v451
                    local v452 = 1 - v451
                    v440 = (1 - ((v452 * v452) * v452)) * 0.12 + 1
                    _ = 0
                else
                    v439 = 1
                    v440 = 1
                    _ = 0
                end
            else
                v439 = math.min(1, v450 / 0.05)
                local v453 = v450 / 0.2 - 1
                v440 = 1.6 - ((((v453 * 2.5) * v453) * v453) + 1 + ((v453 * 1.5) * v453)) * 0.6
                _ = 0
            end
        else
            v449 = true
        end

        if v449 then
            v439 = 0
            v440 = 1
            _ = 0
        end

        local a = v439 * v436
        local v455 = ui.Compact and 0.9 or 1
        put(v374, "FIGHT!", a, (v455 * 1.2) * v440, index)
    end

    local renderSteppedConnection = nil

    local function cdWatch()
        --[[
          name: cdWatch
          line: 1165
          upvalues:
            state (copy, index: 1)
            renderSteppedConnection (ref,  index: 2)
            runService (copy, index: 3)
            cdFrame (copy, index: 4)
            v407 (ref,  index: 5)
            decider (ref,  index: 6)
            fought (ref,  index: 7)
            a7 (copy, index: 8)
            v369 (copy, index: 9)
            v370 (copy, index: 10)
            v374 (copy, index: 11)
            v359 (copy, index: 12)
            v26 (ref,  index: 13)
            v27 (ref,  index: 14)
            stopFades (copy, index: 15)
            parent3 (copy, index: 16)
            uiStroke2 (copy, index: 17)
        ]]
        local v458 = state.SeesMatch()

        if v458 and not renderSteppedConnection then
            renderSteppedConnection = runService.RenderStepped:Connect(cdFrame)
            return
        end

        if not v458 and renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil

            if v407 and decider and not fought and a7.Decider then
                a7.Decider.Stop(false)
            end

            v407 = nil

            if v369.on then
                v369.on = false
                v369.label.Visible = false
            end

            if v370.on then
                v370.on = false
                v370.label.Visible = false
            end

            if v374.on then
                v374.on = false
                v374.label.Visible = false
            end

            v359.Visible = false
            v26 = false
            v27 += 1
            stopFades(parent3, uiStroke2)
            parent3.Visible = false
        end
    end

    local v459 = state.SeesMatch()

    if v459 and not renderSteppedConnection then
        renderSteppedConnection = runService.RenderStepped:Connect(cdFrame)
    elseif not v459 and renderSteppedConnection then
        renderSteppedConnection:Disconnect()
        renderSteppedConnection = nil

        if v407 and decider and not fought and a7.Decider then
            a7.Decider.Stop(false)
        end

        v407 = nil

        if v369.on then
            v369.on = false
            v369.label.Visible = false
        end

        if v370.on then
            v370.on = false
            v370.label.Visible = false
        end

        if v374.on then
            v374.on = false
            v374.label.Visible = false
        end

        v359.Visible = false
        v26 = false
        v27 += 1
        stopFades(parent3, uiStroke2)
        parent3.Visible = false
    end

    local parent4 = ui.new("Frame", {Name = "Elimination", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromOffset(600, 90), Parent = parent})
    local parent5 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), Parent = parent4})
    local v462 = ui.Image(ui.Assets.Icons.Skull, {Name = "Skull", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(34, 34), ImageColor3 = colors.Enemy, Parent = parent5})
    local v463 = ui.DisplayText({Name = "Title", Text = "ELIMINATED", TextSize = 32, StrokeThickness = 2.5, Position = UDim2.fromOffset(0, 34), Size = UDim2.new(1, 0, 0, 34), TextColor3 = colors.Enemy, Parent = parent5})
    local parent6 = ui.new("TextLabel", {Name = "Victim", AutoLocalize = false, Text = "", TextSize = 22, Position = UDim2.fromOffset(0, 66), Size = UDim2.new(1, 0, 0, 24), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent5})
    ui.TextStroke(colors.Void, 2, 0.2).Parent = parent6
    local count3 = 0
    local timestamp2 = 0
    local v467 = 0
    local v468 = {[2] = "DOUBLE ELIMINATION", [3] = "TRIPLE ELIMINATION"}

    local function showElim(text: string, headshot: boolean)
        --[[
          name: showElim
          line: 1221
          upvalues:
            count3 (ref,  index: 1)
            v467 (ref,  index: 2)
            timestamp2 (ref,  index: 3)
            v463 (copy, index: 4)
            v468 (copy, index: 5)
            parent6 (copy, index: 6)
            a7 (copy, index: 7)
            parent4 (copy, index: 8)
            ui (copy, index: 9)
            parent5 (copy, index: 10)
            theme (copy, index: 11)
            v462 (copy, index: 12)
        ]]
        count3 += 1
        local v472 = count3
        local timestamp = os.clock()

        if not (timestamp - timestamp2 <= 4) then
            v467 = 1
        else
            v467 += 1
        end

        timestamp2 = timestamp
        local text2 = v468[v467] or not (3 <= v467) and "ELIMINATED" or "TRIPLE ELIMINATION"
        v463.Text = text2
        local uppercaseText = string.upper(text)
        local v476 = not headshot and "" or "  ·  " .. a7.Loc.T("HEADSHOT")
        parent6.Text = uppercaseText .. v476
        local udim2FromScale = UDim2.fromScale
        local v478 = ui.Compact and 0.54 or 0.6
        parent4.Position = udim2FromScale(0.5, v478)
        parent4.Visible = true
        ui.Unfade(parent5)
        ui.SlideIn(parent5, Vector2.new(0, 14), theme.Tween.PopSmall, UDim2.new())
        ui.Pop(v462, 1.6)

        task.delay(
            1.8,
            function()
                --[[
                  line: 1234
                  upvalues:
                    v472 (copy, index: 1)
                    count3 (ref,  index: 2)
                    ui (copy, index: 3)
                    parent5 (copy, index: 4)
                    parent4 (copy, index: 5)
                ]]
                if v472 ~= count3 then
                    return
                end

                ui.FadeOut(parent5, TweenInfo.new(0.3))

                task.delay(
                    0.32,
                    function()
                        --[[
                          line: 1239
                          upvalues:
                            v472 (copy, index: 1)
                            count3 (ref,  index: 2)
                            parent4 (copy, index: 3)
                        ]]
                        if v472 == count3 then
                            parent4.Visible = false
                        end
                    end
                )
            end
        )
    end

    a7.OnMatchEvent(
        function(a479, a480)
            --[[
              line: 1248
              upvalues:
                v407 (ref,  index: 1)
                decider (ref,  index: 2)
                fought (ref,  index: 3)
                a7 (copy, index: 4)
                v369 (copy, index: 5)
                v370 (copy, index: 6)
                v374 (copy, index: 7)
                v359 (copy, index: 8)
                v26 (ref,  index: 9)
                v27 (ref,  index: 10)
                stopFades (copy, index: 11)
                parent3 (copy, index: 12)
                uiStroke2 (copy, index: 13)
                showIntro (copy, index: 14)
                hideIntro (copy, index: 15)
                count (ref,  index: 16)
                parent2 (copy, index: 17)
                uiStroke (copy, index: 18)
                showSlam (copy, index: 19)
                colors (copy, index: 20)
                state (copy, index: 21)
                showElim (copy, index: 22)
                count2 (ref,  index: 23)
                lookLock (copy, index: 24)
                v66 (ref,  index: 25)
                v292 (ref,  index: 26)
            ]]
            local v481

            if type(a480) ~= "table" then
                v481 = {}
            else
                v481 = a480
            end

            if a479 == "MatchStart" then
                if v407 and decider and not fought and a7.Decider then
                    a7.Decider.Stop(false)
                end

                v407 = nil

                if v369.on then
                    v369.on = false
                    v369.label.Visible = false
                end

                if v370.on then
                    v370.on = false
                    v370.label.Visible = false
                end

                if v374.on then
                    v374.on = false
                    v374.label.Visible = false
                end

                v359.Visible = false
                v26 = false
                v27 += 1
                stopFades(parent3, uiStroke2)
                parent3.Visible = false
                showIntro(v481)

                return
            end

            if a479 == "RoundStart" then
                hideIntro()
                return
            end

            if a479 ~= "RoundEnd" then
                if a479 == "Overtime" then
                    showSlam("OVERTIME", colors.Danger, "THE RING OF FIRE IS CLOSING", 2.2, false)
                    return
                end

                if a479 ~= "Elimination" then
                    if a479 == "Replaced" then
                        a7.Toast(string.format("%s left · %s joined", tostring((v481.name or "A fighter")), (tostring(v481.botName
                            or "a new fighter"))), "info")
                        return
                    end

                    if a479 == "MatchEnd" then
                        if v407 and decider and not fought and a7.Decider then
                            a7.Decider.Stop(false)
                        end

                        v407 = nil

                        if v369.on then
                            v369.on = false
                            v369.label.Visible = false
                        end

                        if v370.on then
                            v370.on = false
                            v370.label.Visible = false
                        end

                        if v374.on then
                            v374.on = false
                            v374.label.Visible = false
                        end

                        v359.Visible = false
                        v26 = false
                        v27 += 1
                        stopFades(parent3, uiStroke2)
                        parent3.Visible = false
                        count2 += 1
                        lookLock(false)

                        if const v482 = v66 then
                            if not v482.Visible then
                                return
                            end

                            a7.SetHudHidden("Intro", false)

                            if v292 then
                                v292.conn:Disconnect()
                                v292 = nil
                            end

                            v482.Visible = false
                        end
                    end
                else
                    local v483 = a7.PlayerGui:FindFirstChild("CombatHUD") ~= nil

                    if v481.killerId == state.MyId() and v481.victimId ~= state.MyId() and not v483 then
                        local text = tostring((v481.victimName or "?"))
                        showElim(text, v481.headshot == true)
                    end
                end
            else
                if v407 and decider and not fought and a7.Decider then
                    a7.Decider.Stop(false)
                end

                v407 = nil

                if v369.on then
                    v369.on = false
                    v369.label.Visible = false
                end

                if v370.on then
                    v370.on = false
                    v370.label.Visible = false
                end

                if v374.on then
                    v374.on = false
                    v374.label.Visible = false
                end

                v359.Visible = false
                v26 = false
                v27 += 1
                stopFades(parent3, uiStroke2)
                parent3.Visible = false
                count += 1
                stopFades(parent2, uiStroke)
                parent2.Visible = false

                if not v26 then
                    parent3.Visible = false
                end
            end
        end
    )

    state.PlayerStateChanged:Connect(
        function(a485)
            --[[
              line: 1274
              upvalues:
                state (copy, index: 1)
                count2 (ref,  index: 2)
                lookLock (copy, index: 3)
                v66 (ref,  index: 4)
                a7 (copy, index: 5)
                v292 (ref,  index: 6)
                count (ref,  index: 7)
                stopFades (copy, index: 8)
                parent2 (copy, index: 9)
                uiStroke (copy, index: 10)
                v26 (ref,  index: 11)
                parent3 (copy, index: 12)
                renderSteppedConnection (ref,  index: 13)
                runService (copy, index: 14)
                cdFrame (copy, index: 15)
                v407 (ref,  index: 16)
                decider (ref,  index: 17)
                fought (ref,  index: 18)
                v369 (copy, index: 19)
                v370 (copy, index: 20)
                v374 (copy, index: 21)
                v359 (copy, index: 22)
                v27 (ref,  index: 23)
                uiStroke2 (copy, index: 24)
            ]]
            if a485 ~= "Match" and not state.Watching() then
                count2 += 1
                lookLock(false)
                local v486 = v66

                if v486 and v486.Visible then
                    a7.SetHudHidden("Intro", false)

                    if v292 then
                        v292.conn:Disconnect()
                        v292 = nil
                    end

                    v486.Visible = false
                end

                count += 1
                stopFades(parent2, uiStroke)
                parent2.Visible = false

                if not v26 then
                    parent3.Visible = false
                end
            end

            local v487 = state.SeesMatch()

            if v487 and not renderSteppedConnection then
                renderSteppedConnection = runService.RenderStepped:Connect(cdFrame)
                return
            end

            if not v487 and renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil

                if v407 and decider and not fought and a7.Decider then
                    a7.Decider.Stop(false)
                end

                v407 = nil

                if v369.on then
                    v369.on = false
                    v369.label.Visible = false
                end

                if v370.on then
                    v370.on = false
                    v370.label.Visible = false
                end

                if v374.on then
                    v374.on = false
                    v374.label.Visible = false
                end

                v359.Visible = false
                v26 = false
                v27 += 1
                stopFades(parent3, uiStroke2)
                parent3.Visible = false
            end
        end
    )

    state.WatchChanged:Connect(
        function(a488)
            --[[
              line: 1281
              upvalues:
                state (copy, index: 1)
                count2 (ref,  index: 2)
                lookLock (copy, index: 3)
                v66 (ref,  index: 4)
                a7 (copy, index: 5)
                v292 (ref,  index: 6)
                count (ref,  index: 7)
                stopFades (copy, index: 8)
                parent2 (copy, index: 9)
                uiStroke (copy, index: 10)
                v26 (ref,  index: 11)
                parent3 (copy, index: 12)
                renderSteppedConnection (ref,  index: 13)
                runService (copy, index: 14)
                cdFrame (copy, index: 15)
                v407 (ref,  index: 16)
                decider (ref,  index: 17)
                fought (ref,  index: 18)
                v369 (copy, index: 19)
                v370 (copy, index: 20)
                v374 (copy, index: 21)
                v359 (copy, index: 22)
                v27 (ref,  index: 23)
                uiStroke2 (copy, index: 24)
            ]]
            if not a488 and not state.InMatch() then
                count2 += 1
                lookLock(false)
                local v489 = v66

                if v489 and v489.Visible then
                    a7.SetHudHidden("Intro", false)

                    if v292 then
                        v292.conn:Disconnect()
                        v292 = nil
                    end

                    v489.Visible = false
                end

                count += 1
                stopFades(parent2, uiStroke)
                parent2.Visible = false

                if not v26 then
                    parent3.Visible = false
                end
            end

            local v490 = state.SeesMatch()

            if v490 and not renderSteppedConnection then
                renderSteppedConnection = runService.RenderStepped:Connect(cdFrame)
                return
            end

            if not v490 and renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil

                if v407 and decider and not fought and a7.Decider then
                    a7.Decider.Stop(false)
                end

                v407 = nil

                if v369.on then
                    v369.on = false
                    v369.label.Visible = false
                end

                if v370.on then
                    v370.on = false
                    v370.label.Visible = false
                end

                if v374.on then
                    v374.on = false
                    v374.label.Visible = false
                end

                v359.Visible = false
                v26 = false
                v27 += 1
                stopFades(parent3, uiStroke2)
                parent3.Visible = false
            end
        end
    )

    a7.Debug.banner = function(a491, a492)
        --[[
          line: 1289
          upvalues:
            state (copy, index: 1)
        ]]
        local matchEvent = state.MatchEvent
        local v494 = a492 or {}
        matchEvent:Fire(a491, v494)

        return true
    end

    a7.Debug.countdown = function(a495)
        --[[
          line: 1295
          upvalues:
            v407 (ref,  index: 1)
            decider (ref,  index: 2)
            fought (ref,  index: 3)
            a7 (copy, index: 4)
            v369 (copy, index: 5)
            v370 (copy, index: 6)
            v374 (copy, index: 7)
            v359 (copy, index: 8)
            v26 (ref,  index: 9)
            v27 (ref,  index: 10)
            stopFades (copy, index: 11)
            parent3 (copy, index: 12)
            uiStroke2 (copy, index: 13)
            state (copy, index: 14)
            digit (ref,  index: 15)
        ]]
        if a495 == "restart" then
            if v407 and decider and not fought and a7.Decider then
                a7.Decider.Stop(false)
            end

            v407 = nil

            if v369.on then
                v369.on = false
                v369.label.Visible = false
            end

            if v370.on then
                v370.on = false
                v370.label.Visible = false
            end

            if v374.on then
                v374.on = false
                v374.label.Visible = false
            end

            v359.Visible = false
            v26 = false
            v27 += 1
            stopFades(parent3, uiStroke2)
            parent3.Visible = false
        end

        local phase, v497 = state.PhaseClock()
        local v498 = {phase = phase, left = if 0 < v497 then v497 - state.Now() else 0}
        v498.running = v407 ~= nil
        v498.digit = digit
        v498.decider = decider
        v498.fought = fought
        v498.odd = if v369.on then v369.text else false
        v498.even = if v370.on then v370.text else false
        v498.fight = v374.on
        v498.sub = if parent3.Visible then parent3.Text else false
        return v498
    end
end

return v5