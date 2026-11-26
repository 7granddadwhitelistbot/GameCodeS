local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local v6 = {}
local fontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
local color3FromRGB = Color3.fromRGB
local color3 = color3FromRGB(255, 198, 96)
local color32 = color3FromRGB(255, 146, 52)
local color33 = color3FromRGB(255, 98, 50)
local color34 = color3FromRGB(255, 236, 200)
local imageColor3 = color3FromRGB(38, 12, 5)
v6.Color = color32
local v14 = {PreRound = true, Live = true, Overtime = true}
local v15 = {count = {Brightness = -0.04, Contrast = 0.14, Saturation = 0.1, TintColor = color3FromRGB(255, 234, 212)}, live = {Brightness = -0.02, Contrast = 0.08, Saturation = 0.07, TintColor = color3FromRGB(255, 243, 230)}, off = {Brightness = 0, Contrast = 0, Saturation = 0, TintColor = color3FromRGB(255, 255, 255)}}
local v16 = {count = 0.34, live = 0.54, off = 1}

function v6.Init(a17)
    --[[
      name: Init
      line: 62
      upvalues:
        players (copy, index: 1)
        replicatedStorage (copy, index: 2)
        tweenService (copy, index: 3)
        imageColor3 (copy, index: 4)
        v14 (copy, index: 5)
        runService (copy, index: 6)
        lighting (copy, index: 7)
        v16 (copy, index: 8)
        v15 (copy, index: 9)
        fontFace (copy, index: 10)
        color32 (copy, index: 11)
        color3FromRGB (copy, index: 12)
        color3 (copy, index: 13)
        color34 (copy, index: 14)
        color33 (copy, index: 15)
    ]]
    local result
    local ui = a17.UI
    local theme = a17.Theme
    local state = a17.State
    local colors = theme.Colors
    local v23 = ui.Assets.Fx or {}
    local v24 = ui.Assets.Icons or {}
    local localPlayer = players.LocalPlayer
    local sfx = replicatedStorage:WaitForChild("Shared"):FindFirstChild("Sfx")

    local success, result2 = pcall(
        function()
            --[[
              line: 72
              upvalues:
                sfx (copy, index: 1)
            ]]
            if sfx then
                return (require(sfx))
            end

            return nil
        end
    )

    if not success or type(result2) ~= "table" then
        result = nil
    else
        result = result2
    end

    local function playSfx(a30, a31)
        --[[
          name: playSfx
          line: 77
          upvalues:
            result (ref, index: 1)
        ]]
        if result then
            pcall(result.Play, a30, nil, a31)
        end
    end

    local function duck(a33, a34, a35)
        --[[
          name: duck
          line: 82
          upvalues:
            result (ref, index: 1)
        ]]
        if result and result.Duck then
            pcall(result.Duck, a33, a34, a35)
        end
    end

    if result and result.Preload then
        pcall(result.Preload, {"Match/Final_Round", "Match/Final_Heartbeat", "Music/Final_Round"})
    end

    local pace = 1

    local function tw(instance, a39: number, propertyTable, easingStyle: Enum.EasingStyle, easingDirection: Enum.EasingDirection?, a43: number?)
        --[[
          name: tw
          line: 93
          upvalues:
            tweenService (copy, index: 1)
            pace (ref,  index: 2)
        ]]
        local newTweenInfo = TweenInfo.new
        local v45 = a39 * pace
        local easingStyle2 = easingStyle or Enum.EasingStyle.Quint
        local easingDirection2 = easingDirection or Enum.EasingDirection.Out
        local tween = tweenService:Create(instance, newTweenInfo(v45, easingStyle2, easingDirection2, 0, false, (a43
            or 0) * pace), propertyTable)
        tween:Play()

        return tween
    end

    local function after(a50, a51)
        --[[
          name: after
          line: 98
          upvalues:
            pace (ref, index: 1)
        ]]
        task.delay(a50 * pace, a51)
    end

    local v52 = {}

    local function outline(parent, a55, base)
        --[[
          name: outline
          line: 103
          upvalues:
            ui (copy, index: 1)
            imageColor3 (copy, index: 2)
            v52 (copy, index: 3)
        ]]
        local stroke = ui.TextStroke(imageColor3, a55, base)
        stroke.Parent = parent
        v52[parent] = {stroke = stroke, base = base}
    end

    local function strokeFor(key, a60)
        --[[
          name: strokeFor
          line: 108
          upvalues:
            v52 (copy, index: 1)
        ]]
        local v61 = v52[key]

        if v61 and not (1 <= a60) then
            return v61.base + ((1 - v61.base) * a60)
        end

        return 1
    end

    local function textSet(key, textTransparency)
        --[[
          name: textSet
          line: 112
          upvalues:
            v52 (copy, index: 1)
        ]]
        key.TextTransparency = textTransparency

        if const v65 = v52[key] then
            local stroke = v65.stroke
            local v67 = v52[key]
            stroke.Transparency = if v67 and not (1 <= textTransparency) then v67.base + (1 - v67.base) * textTransparency else 1
        end
    end

    local function textTo(a69, a70: number, textTransparency: number, easingStyle: Enum.EasingStyle, easingDirection: Enum.EasingDirection?, a74: number?)
        --[[
          name: textTo
          line: 119
          upvalues:
            tw (copy, index: 1)
            v52 (copy, index: 2)
        ]]
        tw(a69, a70, {TextTransparency = textTransparency}, easingStyle, easingDirection, a74)

        if const v75 = v52[a69] then
            local stroke = v75.stroke
            local propertyTable = {}
            local v78 = v52[a69]
            propertyTable.Transparency = if v78 and not (1 <= textTransparency) then v78.base + (1 - v78.base) * textTransparency else 1
            tw(stroke, a70, propertyTable, easingStyle, easingDirection, a74)
        end
    end

    local function isDecider(a80)
        --[[
          name: isDecider
          line: 128
          upvalues:
            state (copy, index: 1)
        ]]
        local v81 = if a80 == nil then state.Match else a80

        if type(v81) ~= "table" or type(v81.teams) ~= "table" then
            return false
        end

        local v82

        if type(v81.roundsToWin) ~= "number" then
            v82 = state.RoundsToWin()
        else
            v82 = v81.roundsToWin
        end

        if v82 < 2 then
            return false
        end

        local team = v81.teams[1]
        local team2 = v81.teams[2]

        return type(team) == "table"
            and type(team2) == "table"
            and team.score == v82 - 1
            and team2.score == v82 - 1
    end

    local _, parent = ui.Screen("TR_FinalRound", -1, a17.PlayerGui, {fullBleed = true})
    local ui2 = ui.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, Visible = false, Size = UDim2.fromScale(1, 1), Image = v23.Vignette
        or "", ImageColor3 = imageColor3, ScaleType = Enum.ScaleType.Stretch, Parent = parent})
    local cardUp = false
    local atmos = "off"
    local ui3 = nil
    local tween = nil
    local v92 = 1
    local v93 = 1
    local timestamp = -math.huge
    local v95 = 0.2
    local renderSteppedConnection = nil
    local count = 0

    local function pulse(a99)
        --[[
          name: pulse
          line: 169
        ]]
        if a99 < 0 then
            return 0
        end
        if a99 < 0.06 then
            return a99 / 0.06
        end

        return (math.exp(-(a99 - 0.06) / 0.14))
    end

    local function ensureLoop()
        --[[
          name: ensureLoop
          line: 178
          upvalues:
            renderSteppedConnection (ref,  index: 1)
            runService (copy, index: 2)
            v92 (ref,  index: 3)
            v93 (ref,  index: 4)
            timestamp (ref,  index: 5)
            v95 (ref,  index: 6)
            atmos (ref,  index: 7)
            ui2 (copy, index: 8)
        ]]
        if renderSteppedConnection then
            return
        end

        renderSteppedConnection = runService.RenderStepped:Connect(
            function(deltaTime: number)
                --[[
                  line: 182
                  upvalues:
                    v92 (ref,  index: 1)
                    v93 (ref,  index: 2)
                    timestamp (ref,  index: 3)
                    v95 (ref,  index: 4)
                    atmos (ref,  index: 5)
                    ui2 (copy, index: 6)
                    renderSteppedConnection (ref,  index: 7)
                ]]
                v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                local timestamp2 = os.clock()
                local v103 = timestamp2 - timestamp
                local v104 = 0

                if v103 < 1 then
                    local v105
                    local v106 = v95
                    local v107 = v103 < 0 and 0
                        or (if v103 < 0.06 then v103 / 0.06 else math.exp(-(v103 - 0.06) / 0.14))
                    local v108 = v106 * v107
                    local v109 = v95 * 0.6
                    local v110 = v103 - 0.27

                    if not (v110 < 0) then
                        v105 = if v110 < 0.06 then v110 / 0.06 else math.exp(-(v110 - 0.06) / 0.14)
                    else
                        v105 = 0
                    end

                    v104 = v108 + v109 * v105
                end

                local v111 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                ui2.ImageTransparency = math.clamp((v92 - v104) + v111, math.min(v92, 0.14), 1)

                if atmos == "off" and 0.995 < v92 and 1 < v103 then
                    ui2.ImageTransparency = 1
                    ui2.Visible = false

                    if renderSteppedConnection then
                        renderSteppedConnection:Disconnect()
                        renderSteppedConnection = nil
                    end
                end
            end
        )
    end

    local function setAtmos(key: string, a114: nil)
        --[[
          name: setAtmos
          line: 204
          upvalues:
            atmos (ref,  index: 1)
            count (ref,  index: 2)
            localPlayer (copy, index: 3)
            ui3 (ref,  index: 4)
            ui (copy, index: 5)
            lighting (copy, index: 6)
            tween (ref,  index: 7)
            v93 (ref,  index: 8)
            v16 (copy, index: 9)
            v92 (ref,  index: 10)
            timestamp (ref,  index: 11)
            ui2 (copy, index: 12)
            renderSteppedConnection (ref,  index: 13)
            runService (copy, index: 14)
            v95 (ref,  index: 15)
            v15 (copy, index: 16)
            tweenService (copy, index: 17)
        ]]
        if key == atmos and not a114 then
            return
        end

        atmos = key
        count += 1
        local v115 = count
        local v116 = key ~= "off"
        local finalRound = localPlayer:GetAttribute("FinalRound")
        local v118 = v116 and true or nil

        if finalRound ~= v118 then
            local finalRound2 = v116 and true or nil
            localPlayer:SetAttribute("FinalRound", finalRound2)
        end

        if v116 and not ui3 then
            ui3 = ui.new("ColorCorrectionEffect", {Name = "TR_FinalRoundCC", Parent = lighting})
        end

        if tween then
            tween:Cancel()
            tween = nil
        end

        v93 = v16[key]

        if a114 then
            v92 = v93
            timestamp = -math.huge
        end

        if v116 then
            ui2.Visible = true

            renderSteppedConnection = renderSteppedConnection
                or runService.RenderStepped:Connect(
                    function(deltaTime: number)
                        --[[
                          line: 182
                          upvalues:
                            v92 (ref,  index: 1)
                            v93 (ref,  index: 2)
                            timestamp (ref,  index: 3)
                            v95 (ref,  index: 4)
                            atmos (ref,  index: 5)
                            ui2 (copy, index: 6)
                            renderSteppedConnection (ref,  index: 7)
                        ]]
                        v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                        local timestamp2 = os.clock()
                        local v122 = timestamp2 - timestamp
                        local v123 = 0

                        if v122 < 1 then
                            local v124
                            local v125 = v95
                            local v126 = v122 < 0 and 0
                                or (if v122 < 0.06 then v122 / 0.06 else math.exp(-(v122 - 0.06) / 0.14))
                            local v127 = v125 * v126
                            local v128 = v95 * 0.6
                            local v129 = v122 - 0.27

                            if not (v129 < 0) then
                                v124 = if v129 < 0.06 then v129 / 0.06 else math.exp(-(v129 - 0.06) / 0.14)
                            else
                                v124 = 0
                            end

                            v123 = v127 + v128 * v124
                        end

                        local v130 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                        ui2.ImageTransparency = math.clamp((v92 - v123) + v130, math.min(v92, 0.14), 1)

                        if atmos == "off" and 0.995 < v92 and 1 < v122 then
                            ui2.ImageTransparency = 1
                            ui2.Visible = false

                            if renderSteppedConnection then
                                renderSteppedConnection:Disconnect()
                                renderSteppedConnection = nil
                            end
                        end
                    end
                )
        elseif a114 then
            ui2.ImageTransparency = 1
            ui2.Visible = false

            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end
        end

        local instance = ui3
        if not instance then
            return
        end

        instance.Enabled = true

        if not a114 then
            local v132 = key ~= "off" and (key ~= "count" and 1.2 or 0.5) or 0.7
            tween = tweenService:Create(instance, TweenInfo.new(v132, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), v15[key])
            tween:Play()

            if not v116 then
                task.delay(
                    v132 + 0.05,
                    function()
                        --[[
                          line: 258
                          upvalues:
                            v115 (copy, index: 1)
                            count (ref,  index: 2)
                            atmos (ref,  index: 3)
                            ui3 (ref,  index: 4)
                        ]]
                        if v115 == count and atmos == "off" and ui3 then
                            ui3:Destroy()
                            ui3 = nil
                        end
                    end
                )
            end

            return
        end

        if not v116 then
            instance:Destroy()
            ui3 = nil

            return
        end

        for v133, v134 in v15[key] do
            instance[v133] = v134
        end
    end

    local function wanted()
        --[[
          name: wanted
          line: 267
          upvalues:
            state (copy, index: 1)
            localPlayer (copy, index: 2)
            cardUp (ref,  index: 3)
            v14 (copy, index: 4)
            isDecider (copy, index: 5)
        ]]
        local match = state.Match

        if not state.SeesMatch() or type(match) ~= "table" or localPlayer:GetAttribute("ReplayPlaying") == true then
            return "off"
        end
        if cardUp then
            return "count"
        end
        if not v14[match.phase] or not isDecider(match) then
            return "off"
        end
        if match.phase == "PreRound" then
            return "count"
        end

        return "live"
    end

    local function refresh()
        --[[
          name: refresh
          line: 280
          upvalues:
            setAtmos (copy, index: 1)
            wanted (copy, index: 2)
        ]]
        setAtmos((wanted()))
    end

    local function beat(a139)
        --[[
          name: beat
          line: 284
          upvalues:
            timestamp (ref,  index: 1)
            v95 (ref,  index: 2)
            atmos (ref,  index: 3)
            renderSteppedConnection (ref,  index: 4)
            runService (copy, index: 5)
            v92 (ref,  index: 6)
            v93 (ref,  index: 7)
            ui2 (copy, index: 8)
        ]]
        timestamp = os.clock()
        v95 = a139

        if atmos ~= "off" and not renderSteppedConnection then
            renderSteppedConnection = runService.RenderStepped:Connect(
                function(deltaTime: number)
                    --[[
                      line: 182
                      upvalues:
                        v92 (ref,  index: 1)
                        v93 (ref,  index: 2)
                        timestamp (ref,  index: 3)
                        v95 (ref,  index: 4)
                        atmos (ref,  index: 5)
                        ui2 (copy, index: 6)
                        renderSteppedConnection (ref,  index: 7)
                    ]]
                    v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                    local timestamp2 = os.clock()
                    local v142 = timestamp2 - timestamp
                    local v143 = 0

                    if v142 < 1 then
                        local v144
                        local v145 = v95
                        local v146 = v142 < 0 and 0
                            or (if v142 < 0.06 then v142 / 0.06 else math.exp(-(v142 - 0.06) / 0.14))
                        local v147 = v145 * v146
                        local v148 = v95 * 0.6
                        local v149 = v142 - 0.27

                        if not (v149 < 0) then
                            v144 = if v149 < 0.06 then v149 / 0.06 else math.exp(-(v149 - 0.06) / 0.14)
                        else
                            v144 = 0
                        end

                        v143 = v147 + v148 * v144
                    end

                    local v150 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                    ui2.ImageTransparency = math.clamp((v92 - v143) + v150, math.min(v92, 0.14), 1)

                    if atmos == "off" and 0.995 < v92 and 1 < v142 then
                        ui2.ImageTransparency = 1
                        ui2.Visible = false

                        if renderSteppedConnection then
                            renderSteppedConnection:Disconnect()
                            renderSteppedConnection = nil
                        end
                    end
                end
            )
        end
    end

    local v151 = nil

    local function headlineLabel(parent, name: string, zIndex: number)
        --[[
          name: headlineLabel
          line: 337
          upvalues:
            ui (copy, index: 1)
            fontFace (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local parent2 = ui.new("TextLabel", {Text = "FINAL ROUND", TextSize = 100, TextTransparency = 1, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1400, 120), FontFace = fontFace, TextColor3 = colors.Text, ZIndex = zIndex, Parent = parent})
        local parent3 = parent2

        return parent3, ui.new("UIScale", {Name = "HeadScale", Parent = parent2})
    end

    local function fadeEnds(a159: number)
        --[[
          name: fadeEnds
          line: 353
        ]]
        return NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(a159, 0), NumberSequenceKeypoint.new(1 - a159, 0), NumberSequenceKeypoint.new(1, 1)})
    end

    local function buildCard()
        --[[
          name: buildCard
          line: 362
          upvalues:
            ui (copy, index: 1)
            a17 (copy, index: 2)
            colors (copy, index: 3)
            v24 (copy, index: 4)
            color32 (copy, index: 5)
            v23 (copy, index: 6)
            imageColor3 (copy, index: 7)
            fadeEnds (copy, index: 8)
            color3FromRGB (copy, index: 9)
            color3 (copy, index: 10)
            headlineLabel (copy, index: 11)
            color34 (copy, index: 12)
            v52 (copy, index: 13)
            theme (copy, index: 14)
            fontFace (copy, index: 15)
        ]]
        local ui2 = ui.new("Frame", {Name = "FinalRound", ZIndex = 4, Visible = false, Size = UDim2.fromScale(1, 1), Parent = a17.Canvas.Overlay})
        local dim = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = ui2})
        local ui3 = ui.new("Frame", {Name = "Stage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.265), Size = UDim2.fromOffset(0, 0), Parent = ui2})
        local stageScale = ui.new("UIScale", {Name = "StageScale", Parent = ui3})
        local ui4 = ui.new("Frame", {Name = "Shaker", Size = UDim2.fromOffset(0, 0), Parent = ui3})
        local glow = ui.new("ImageLabel", {Name = "Glow", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1100, 360), Image = v24.Glow
            or "", ImageColor3 = color32, Parent = ui4})
        local ui5 = ui.new("ImageLabel", {Name = "GhostBand", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1500, 198.4), Image = v23.Band
            or "", ImageColor3 = imageColor3, ScaleType = Enum.ScaleType.Stretch, Parent = ui4})
        ui.new("UIGradient", {Transparency = fadeEnds(0.25), Parent = ui5})
        local ui6 = ui.new("ImageLabel", {Name = "Band", ImageTransparency = 0.06, ZIndex = 2, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(0, 124), Image = v23.Band
            or "", ImageColor3 = Color3.new(1, 1, 1), ScaleType = Enum.ScaleType.Stretch, Parent = ui4})
        local bandGrad = ui.new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, imageColor3), ColorSequenceKeypoint.new(0.3, color3FromRGB(92, 30, 10)), ColorSequenceKeypoint.new(0.5, color3FromRGB(120, 42, 12)), ColorSequenceKeypoint.new(0.7, color3FromRGB(92, 30, 10)), ColorSequenceKeypoint.new(1, imageColor3)}), Transparency = fadeEnds(0.14), Parent = ui6})

        local function edge(name: string)
            --[[
              name: edge
              line: 419
              upvalues:
                ui (copy, index: 1)
                color3 (copy, index: 2)
                ui4 (copy, index: 3)
                fadeEnds (copy, index: 4)
            ]]
            local parent = ui.new("Frame", {BorderSizePixel = 0, ZIndex = 3, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(0, 3), BackgroundColor3 = color3, Parent = ui4})
            ui.new("UIGradient", {Transparency = fadeEnds(0.2), Parent = parent})

            return parent
        end

        local edgeTop = edge("EdgeTop")
        local edgeBottom = edge("EdgeBottom")
        local flare = ui.new("ImageLabel", {Name = "Flare", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(900, 96), Image = v23.Flare
            or "", ImageColor3 = color3, ScaleType = Enum.ScaleType.Stretch, Parent = ui4})
        local ring = ui.new("ImageLabel", {Name = "Ring", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(100, 100), Image = v23.Ring
            or "", ImageColor3 = color3, Parent = ui4})
        local aura, auraScale = headlineLabel(ui4, "Aura", 4)
        aura.TextColor3 = color32
        local shadow, shadowScale = headlineLabel(ui4, "Shadow", 4)
        shadow.TextColor3 = colors.Void
        local v181, headScale = headlineLabel(ui4, "Headline", 5)
        ui.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(color34, color3), Parent = v181})
        local stroke = ui.TextStroke(imageColor3, 2, 0.35)
        stroke.Parent = v181
        v52[v181] = {base = 0.35, stroke = stroke}
        local v184, sweepScale = headlineLabel(ui4, "Sweep", 6)
        v184.TextColor3 = color34
        local sweepGrad = ui.new("UIGradient", {Rotation = 18, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.44, 1), NumberSequenceKeypoint.new(0.5, 0.1), NumberSequenceKeypoint.new(0.56, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-1, 0), Parent = v184})
        local ui7 = ui.new("Frame", {Name = "Row", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, 132), Size = UDim2.fromOffset(0, 0), Parent = ui4})
        local boxes = {}

        for index = 1, 2 do
            local name
            local v191 = if index == 1 then colors.Ally else colors.Enemy
            local newUi = ui.new
            local v193 = {}

            if index == 1 then
                name = "Mine"
            else
                name = "Theirs"
            end

            v193.Name = name
            v193.AnchorPoint = Vector2.new(0.5, 0.5)
            local udim2FromOffset = UDim2.fromOffset
            local v195 = index ~= 1 and 156 or -156
            v193.Position = udim2FromOffset(v195, 0)
            v193.Size = UDim2.fromOffset(92, 84)
            v193.BackgroundColor3 = Color3.new(1, 1, 1)
            v193.BackgroundTransparency = 0.05
            v193.ZIndex = 6
            v193[1], v193[2], v193[3] = ui.Corner(14), ui.Gradient(theme.Lighten(v191, 0.1), theme.Darken(v191, 0.35), 90), (ui.Stroke(theme.Lighten(v191, 0.4), 2.5, 0.25))
            v193.Parent = ui7
            local ui8 = newUi("Frame", v193)
            local scale = ui.new("UIScale", {Parent = ui8})
            boxes[index] = {box = ui8, digit = ui.DisplayText({Name = "Score", Text = "2", TextSize = 62, StrokeThickness = 2.5, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), TextColor3 = colors.Text, StrokeColor = theme.Darken(v191, 0.7), Parent = ui8}), scale = scale}
        end

        local dash = ui.new("Frame", {Name = "Dash", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(36, 6), BackgroundColor3 = color3, ZIndex = 6, (ui.Corner(3)), Parent = ui7})
        local digitRing = ui.new("ImageLabel", {Name = "DigitRing", ImageTransparency = 1, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(90, 90), Image = v23.Ring
            or "", ImageColor3 = color3, Parent = ui7})

        local function digitLabel(name: string, zIndex: number)
            --[[
              name: digitLabel
              line: 537
              upvalues:
                ui (copy, index: 1)
                fontFace (copy, index: 2)
                colors (copy, index: 3)
                ui7 (copy, index: 4)
            ]]
            local parent = ui.new("TextLabel", {Text = "", TextSize = 100, TextTransparency = 1, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(180, 150), FontFace = fontFace, TextColor3 = colors.Text, ZIndex = zIndex, Parent = ui7})
            local parent2 = parent

            return parent2, ui.new("UIScale", {Parent = parent})
        end

        local v205, ghostScale = digitLabel("DigitGhost", 6)
        local v207, digitScale = digitLabel("Digit", 7)
        local digitGrad = ui.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(color34, color3), Parent = v207})
        local stroke2 = ui.TextStroke(imageColor3, 2.5, 0.2)
        stroke2.Parent = v207
        v52[v207] = {base = 0.2, stroke = stroke2}
        ui.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(color34, color32), Parent = v205})
        local fightShadow, fightShadowScale = headlineLabel(ui4, "FightShadow", 4)
        fightShadow.TextColor3 = colors.Void
        fightShadow.Text = "FIGHT!"
        local v213, fightScale = headlineLabel(ui4, "Fight", 5)
        v213.Text = "FIGHT!"
        ui.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(color34, color32), Parent = v213})
        local stroke3 = ui.TextStroke(imageColor3, 2, 0.3)
        stroke3.Parent = v213
        v52[v213] = {base = 0.3, stroke = stroke3}
        local ui9 = ui.new("Frame", {Name = "Particles", ZIndex = 7, Size = UDim2.fromOffset(0, 0), Parent = ui4})
        local pool = require(script.Parent.Parent.Fx).Pool(ui9, 110, 7)

        return {
            root = ui2,
            dim = dim,
            stage = ui3,
            stageScale = stageScale,
            shaker = ui4,
            glow = glow,
            ring = ring,
            band = ui6,
            bandGrad = bandGrad,
            ghost = ui5,
            edgeTop = edgeTop,
            edgeBottom = edgeBottom,
            flare = flare,
            head = v181,
            headScale = headScale,
            shadow = shadow,
            shadowScale = shadowScale,
            aura = aura,
            auraScale = auraScale,
            sweep = v184,
            sweepScale = sweepScale,
            sweepGrad = sweepGrad,
            row = ui7,
            boxes = boxes,
            digit = v207,
            digitScale = digitScale,
            digitGrad = digitGrad,
            digitGhost = v205,
            ghostScale = ghostScale,
            digitRing = digitRing,
            dash = dash,
            fight = v213,
            fightScale = fightScale,
            fightShadow = fightShadow,
            fightShadowScale = fightShadowScale,
            pool = pool
        }
    end

    local count2 = 0
    local v219 = 0
    local v220 = nil
    local v221 = nil
    local v222 = 0
    local v223 = nil
    local random = Random.new()

    local function shake(a226, a227, a228)
        --[[
          name: shake
          line: 619
          upvalues:
            count2 (ref,  index: 1)
            pace (ref,  index: 2)
            random (copy, index: 3)
            runService (copy, index: 4)
        ]]
        local v229 = count2

        task.spawn(
            function()
                --[[
                  line: 621
                  upvalues:
                    a228 (copy, index: 1)
                    pace (ref,  index: 2)
                    v229 (copy, index: 3)
                    count2 (ref,  index: 4)
                    a226 (copy, index: 5)
                    random (copy, index: 6)
                    a227 (copy, index: 7)
                    runService (copy, index: 8)
                ]]
                local timestamp = os.clock()

                while os.clock() - timestamp < a228 * pace and v229 == count2 do
                    local v231 = 1 - (os.clock() - timestamp) / (a228 * pace)
                    a226.shaker.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * a227) * v231, (random:NextNumber(-1, 1) * a227) * v231)
                    runService.RenderStepped:Wait()
                end

                if v229 == count2 then
                    a226.shaker.Position = UDim2.new()
                end
            end
        )
    end

    local function burst(a233, a234: number, at: Vector2, box: Vector2, speed: number, options)
        --[[
          name: burst
          line: 634
          upvalues:
            pace (ref,  index: 1)
            color3 (copy, index: 2)
            color32 (copy, index: 3)
            color33 (copy, index: 4)
            color34 (copy, index: 5)
        ]]
        local v239 = options or {}
        a233.pool.Pace = pace
        a233.pool:Burst(a234, {mode = "box", whiteChance = 0.3, at = at, box = box, speed = speed, colors = v239.colors
            or {color3, color32, color33}, white = color34, sparkChance = v239.sparkChance or 0.6, grav = v239.grav, drag = v239.drag, lifeMult = v239.lifeMult})
    end

    local function hideCard(a241)
        --[[
          name: hideCard
          line: 652
          upvalues:
            v223 (ref, index: 1)
        ]]
        if v223 then
            v223()
            v223 = nil
        end

        a241.pool:Clear()
        a241.root.Visible = false
        a241.shaker.Position = UDim2.new()
    end

    local decider = {}

    local function cancelCard(a244)
        --[[
          name: cancelCard
          line: 665
          upvalues:
            v151 (ref,  index: 1)
            cardUp (ref,  index: 2)
            v220 (ref,  index: 3)
            v221 (ref,  index: 4)
            count2 (ref,  index: 5)
            v223 (ref,  index: 6)
            textTo (copy, index: 7)
            tweenService (copy, index: 8)
            pace (ref,  index: 9)
        ]]
        local v245 = v151
        local v246 = cardUp
        cardUp = false
        v220 = nil
        v221 = nil
        count2 += 1
        local v247 = count2

        if v245 and v245.root.Visible then
            if not a244 and v246 then
                if v223 then
                    v223()
                    v223 = nil
                end

                for _, v249 in {v245.head, v245.shadow, v245.sweep, v245.aura, v245.digit, v245.digitGhost, v245.fight, v245.fightShadow} do
                    textTo(v249, 0.15, 1, Enum.EasingStyle.Quad)
                end

                for _, instance in {v245.band, v245.ghost, v245.flare, v245.glow, v245.ring, v245.digitRing} do
                    local propertyTable = {ImageTransparency = 1}
                    local quad = Enum.EasingStyle.Quad
                    local newTweenInfo = TweenInfo.new
                    local v255 = pace * 0.15
                    local easingStyle = quad or Enum.EasingStyle.Quint
                    local tween = tweenService:Create(instance, newTweenInfo(v255, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
                    tween:Play()
                end

                for _, box in v245.boxes do
                    box.box.Visible = false
                end

                v245.dash.Visible = false
                local dim = v245.dim
                local propertyTable = {BackgroundTransparency = 1}
                local quad = Enum.EasingStyle.Quad
                local newTweenInfo = TweenInfo.new
                local v264 = pace * 0.2
                local easingStyle = quad or Enum.EasingStyle.Quint
                tweenService:Create(dim, newTweenInfo(v264, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()

                local v266 = function()
                    --[[
                      line: 691
                      upvalues:
                        v247 (copy, index: 1)
                        count2 (ref,  index: 2)
                        v245 (copy, index: 3)
                        v223 (ref,  index: 4)
                    ]]
                    if v247 == count2 then
                        local v267 = v245

                        if v223 then
                            v223()
                            v223 = nil
                        end

                        v267.pool:Clear()
                        v267.root.Visible = false
                        v267.shaker.Position = UDim2.new()
                    end
                end

                task.delay(pace * 0.22, v266)
            else
                if v223 then
                    v223()
                    v223 = nil
                end

                v245.pool:Clear()
                v245.root.Visible = false
                v245.shaker.Position = UDim2.new()
            end
        end
    end

    function decider.Stop(a268)
        --[[
          name: Stop
          line: 701
          upvalues:
            cancelCard (copy, index: 1)
            setAtmos (copy, index: 2)
            wanted (copy, index: 3)
        ]]
        cancelCard(a268)
        setAtmos((wanted()))
    end

    function decider.Intro(a269)
        --[[
          name: Intro
          line: 706
          upvalues:
            v151 (ref,  index: 1)
            buildCard (copy, index: 2)
            cardUp (ref,  index: 3)
            v220 (ref,  index: 4)
            v221 (ref,  index: 5)
            count2 (ref,  index: 6)
            v223 (ref,  index: 7)
            v222 (ref,  index: 8)
            setAtmos (copy, index: 9)
            wanted (copy, index: 10)
            ui (copy, index: 11)
            tweenService (copy, index: 12)
            pace (ref,  index: 13)
            timestamp (ref,  index: 14)
            v95 (ref,  index: 15)
            atmos (ref,  index: 16)
            renderSteppedConnection (ref,  index: 17)
            runService (copy, index: 18)
            v92 (ref,  index: 19)
            v93 (ref,  index: 20)
            ui2 (copy, index: 21)
            a17 (copy, index: 22)
            color32 (copy, index: 23)
            color3 (copy, index: 24)
            color33 (copy, index: 25)
            color34 (copy, index: 26)
            v52 (copy, index: 27)
            textTo (copy, index: 28)
            state (copy, index: 29)
            random (copy, index: 30)
            burst (copy, index: 31)
            result (ref,  index: 32)
            v219 (ref,  index: 33)
            decider (copy, index: 34)
        ]]
        local stroke, v271, stroke2, v273, v274, v275, v276, v277, v278, v279, v280
        local stroke3, v282, v283
        local stroke4, v285, v286
        local v287, v288
        local v289, v290
        local v291 = v151 or buildCard()
        v151 = v291
        local v292 = v151
        cardUp = false
        v220 = nil
        v221 = nil
        count2 += 1

        if v292 and v292.root.Visible then
            if v223 then
                v223()
                v223 = nil
            end

            v292.pool:Clear()
            v292.root.Visible = false
            v292.shaker.Position = UDim2.new()
        end

        count2 += 1
        local v293 = count2
        cardUp = true
        v222 = 0
        setAtmos((wanted()))
        local compact = ui.Compact
        v291.stageScale.Scale = compact and 0.68 or 1
        local stage = v291.stage
        local udim2FromScale = UDim2.fromScale
        local v297 = compact and 0.235 or 0.265
        stage.Position = udim2FromScale(0.5, v297)
        v291.shaker.Position = UDim2.new()
        v291.root.Visible = true
        v291.dim.BackgroundTransparency = 1
        local propertyTable = {BackgroundTransparency = 0.72}
        tweenService:Create(v291.dim, TweenInfo.new(pace * 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        timestamp = os.clock()
        v95 = 0.28

        if atmos ~= "off" and not renderSteppedConnection then
            renderSteppedConnection = runService.RenderStepped:Connect(
                function(deltaTime: number)
                    --[[
                      line: 182
                      upvalues:
                        v92 (ref,  index: 1)
                        v93 (ref,  index: 2)
                        timestamp (ref,  index: 3)
                        v95 (ref,  index: 4)
                        atmos (ref,  index: 5)
                        ui2 (copy, index: 6)
                        renderSteppedConnection (ref,  index: 7)
                    ]]
                    v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                    local timestamp2 = os.clock()
                    local v301 = timestamp2 - timestamp
                    local v302 = 0

                    if v301 < 1 then
                        local v303
                        local v304 = v95
                        local v305 = v301 < 0 and 0
                            or (if v301 < 0.06 then v301 / 0.06 else math.exp(-(v301 - 0.06) / 0.14))
                        local v306 = v304 * v305
                        local v307 = v95 * 0.6
                        local v308 = v301 - 0.27

                        if not (v308 < 0) then
                            v303 = if v308 < 0.06 then v308 / 0.06 else math.exp(-(v308 - 0.06) / 0.14)
                        else
                            v303 = 0
                        end

                        v302 = v306 + v307 * v303
                    end

                    local v309 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                    ui2.ImageTransparency = math.clamp((v92 - v302) + v309, math.min(v92, 0.14), 1)

                    if atmos == "off" and 0.995 < v92 and 1 < v301 then
                        ui2.ImageTransparency = 1
                        ui2.Visible = false

                        if renderSteppedConnection then
                            renderSteppedConnection:Disconnect()
                            renderSteppedConnection = nil
                        end
                    end
                end
            )
        end

        v291.band.AnchorPoint = Vector2.new(0, 0.5)
        v291.band.Position = UDim2.fromOffset(-750, 0)
        v291.band.Size = UDim2.fromOffset(0, 124)
        v291.band.ImageTransparency = 0.06
        local band = v291.band
        local propertyTable2 = {Size = UDim2.fromOffset(1500, 124)}
        tweenService:Create(band, TweenInfo.new(pace * 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
        v291.ghost.Size = UDim2.fromOffset(900, 198.4)
        v291.ghost.ImageTransparency = 1
        local ghost = v291.ghost
        local propertyTable3 = {ImageTransparency = 0.5, Size = UDim2.fromOffset(1724.9999999999998, 198.4)}
        tweenService:Create(ghost, TweenInfo.new(pace * 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()

        for v314, instance in {v291.edgeTop, v291.edgeBottom} do
            local udim2FromOffset = UDim2.fromOffset
            local v317 = v314 ~= 1 and 450 or -450
            local v318 = v314 ~= 1 and 64 or -64
            instance.Position = udim2FromOffset(v317, v318)
            instance.Size = UDim2.fromOffset(0, 3)
            instance.BackgroundTransparency = 0
            local propertyTable4 = {Size = UDim2.fromOffset(1170, 3), Position = UDim2.fromOffset(0, instance.Position.Y.Offset)}
            local quint = Enum.EasingStyle.Quint
            local out = Enum.EasingDirection.Out
            local newTweenInfo = TweenInfo.new
            local v323 = pace * 0.45
            local quint2 = quint or Enum.EasingStyle.Quint
            local out2 = out or Enum.EasingDirection.Out
            tweenService:Create(instance, newTweenInfo(v323, quint2, out2, 0, false, 0.08 * pace), propertyTable4):Play()
        end

        a17.Sounds.Play("Whoosh", {volume = 0.35, pitch = 0.8})
        v291.pool.Pace = pace
        v223 = v291.pool:Emit(16, {mode = "box", kind = "sparkle", size = 11, speedMin = 20, speedMax = 70, grav = -170, drag = 0.6, lifeMin = 1.3, lifeMax = 2.2, whiteChance = 0.12, base = 0.15, at = Vector2.new(0, 150), box = Vector2.new(1300, 60), colors = {color32, color3, color33}, white = color34})
        v282, v283 = v291, v293

        for _, v327 in {v291.head, v291.shadow, v291.sweep, v291.aura} do
            local v328, v329
            v327.TextTransparency = 1

            if const v330 = v52[v327] then
                stroke3 = v330.stroke
                local _ = v52[v327]
                local transparency = 1
                stroke, v271, v273, v274 = stroke3, v327, v282, v283
                stroke.Transparency = transparency
                v328, v329 = v273, v274
            else
                v271, v328, v329 = v327, v282, v283
            end

            v271.Position = UDim2.fromOffset(0, 0)
            v282, v283 = v328, v329
        end

        v285, v286 = v282, v283

        for _, v334 in {v282.fight, v282.fightShadow} do
            v334.TextTransparency = 1

            if const v335 = v52[v334] then
                stroke4 = v335.stroke
                local _ = v52[v334]
                local transparency = 1
                stroke2, v275, v276 = stroke4, v285, v286
                stroke2.Transparency = transparency
                v285, v286 = v275, v276
            end
        end

        v285.shadow.Position = UDim2.fromOffset(0, 7)
        v285.sweepGrad.Offset = Vector2.new(-1, 0)

        for _, instance in {v285.headScale, v285.shadowScale, v285.sweepScale} do
            instance.Scale = 2.432
            local propertyTable5 = {Scale = 1.28}
            local back = Enum.EasingStyle.Back
            local out = Enum.EasingDirection.Out
            local newTweenInfo = TweenInfo.new
            local v344 = pace * 0.26
            local _ = back or Enum.EasingStyle.Quint
            local out3 = out or Enum.EasingDirection.Out
            local v347
            tweenService:Create(instance, newTweenInfo(v344, v347, out3, 0, false, 0.06 * pace), propertyTable5):Play()
        end

        v285.auraScale.Scale = 1.28
        textTo(v285.head, 0.1, 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.06)
        local shadow = v285.shadow
        local propertyTable6 = {TextTransparency = 0.5}
        local quad = Enum.EasingStyle.Quad
        local out = Enum.EasingDirection.Out
        local newTweenInfo = TweenInfo.new
        local v353 = pace * 0.2
        local easingStyle = quad or Enum.EasingStyle.Quint
        local out4 = out or Enum.EasingDirection.Out
        tweenService:Create(shadow, newTweenInfo(v353, easingStyle, out4, 0, false, 0.06 * pace), propertyTable6):Play()
        local match = state.Match
        local v357 = state.MyTeam()

        for v358, box in v285.boxes do
            local v360
            local match2 = match

            if match2 then
                local teams = match.teams

                if teams then
                    local teams2 = match.teams
                    local teamKey = if v358 == 1 then v357 else 3 - v357
                    v360 = teams2[teamKey]
                else
                    v360 = teams
                end
            else
                v360 = match2
            end

            local digit = box.digit
            local score = v360 and v360.score or 1
            digit.Text = tostring(score)
            box.box.Visible = false
        end

        v285.dash.Visible = false
        local digit = v285.digit
        digit.TextTransparency = 1

        if const v368 = v52[digit] then
            local stroke5 = v368.stroke
            local _ = v52[digit]
            local transparency = 1
            v277, v278 = v285, v286
            stroke5.Transparency = transparency
            v287, v288 = v277, v278
        else
            v287, v288 = v285, v286
        end

        local digitGhost = v287.digitGhost
        digitGhost.TextTransparency = 1

        if const v373 = v52[digitGhost] then
            local stroke6 = v373.stroke
            local _ = v52[digitGhost]
            local transparency = 1
            v279, v280 = v287, v288
            stroke6.Transparency = transparency
            v289, v290 = v279, v280
        else
            v289, v290 = v287, v288
        end

        v289.digitRing.ImageTransparency = 1
        v289.row.Position = UDim2.fromOffset(0, 156)

        local v377 = function()
            --[[
              line: 798
              upvalues:
                v290 (copy, index: 1)
                count2 (ref,  index: 2)
                v289 (copy, index: 3)
                tweenService (copy, index: 4)
                pace (ref,  index: 5)
                random (copy, index: 6)
                runService (copy, index: 7)
                burst (copy, index: 8)
                color3 (copy, index: 9)
                timestamp (ref,  index: 10)
                v95 (ref,  index: 11)
                atmos (ref,  index: 12)
                renderSteppedConnection (ref,  index: 13)
                v92 (ref,  index: 14)
                v93 (ref,  index: 15)
                ui2 (copy, index: 16)
                result (ref,  index: 17)
                v221 (ref,  index: 18)
            ]]
            if v290 ~= count2 then
                return
            end

            for _, instance in {v289.headScale, v289.shadowScale, v289.sweepScale} do
                instance.Scale = 1.3824
                local propertyTable = {Scale = 1.28}
                local back = Enum.EasingStyle.Back
                local newTweenInfo = TweenInfo.new
                local v383 = pace * 0.24
                local easingStyle = back or Enum.EasingStyle.Quint
                tweenService:Create(instance, newTweenInfo(v383, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
            end

            local v385 = v289
            local v386 = count2
            local v387 = 0.32
            local v388 = 11

            task.spawn(
                function()
                    --[[
                      line: 621
                      upvalues:
                        v387 (copy, index: 1)
                        pace (ref,  index: 2)
                        v386 (copy, index: 3)
                        count2 (ref,  index: 4)
                        v385 (copy, index: 5)
                        random (copy, index: 6)
                        v388 (copy, index: 7)
                        runService (copy, index: 8)
                    ]]
                    local timestamp = os.clock()

                    while os.clock() - timestamp < v387 * pace and v386 == count2 do
                        local v390 = 1 - (os.clock() - timestamp) / (v387 * pace)
                        v385.shaker.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v388) * v390, (random:NextNumber(-1, 1) * v388) * v390)
                        runService.RenderStepped:Wait()
                    end

                    if v386 == count2 then
                        v385.shaker.Position = UDim2.new()
                    end
                end
            )

            v289.aura.TextTransparency = 0.3
            v289.auraScale.Scale = 1.3056
            local auraScale = v289.auraScale
            local propertyTable = {Scale = 1.6640000000000001}
            local quart = Enum.EasingStyle.Quart
            local newTweenInfo = TweenInfo.new
            local v395 = pace * 0.6
            local easingStyle = quart or Enum.EasingStyle.Quint
            tweenService:Create(auraScale, newTweenInfo(v395, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
            local aura = v289.aura
            local propertyTable2 = {TextTransparency = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo2 = TweenInfo.new
            local v401 = pace * 0.6
            local easingStyle2 = quad or Enum.EasingStyle.Quint
            tweenService:Create(aura, newTweenInfo2(v401, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()
            burst(v289, 44, Vector2.zero, Vector2.new(605.44, 102.4), 1250)
            v289.ring.ImageColor3 = color3
            v289.ring.Size = UDim2.fromOffset(120, 120)
            v289.ring.ImageTransparency = 0.3
            local ring = v289.ring
            local v404 = {ImageTransparency = 1, Size = UDim2.fromOffset(1500, 1500)}
            local quart2 = Enum.EasingStyle.Quart
            local newTweenInfo3 = TweenInfo.new
            local v407 = pace * 0.65
            local easingStyle3 = quart2 or Enum.EasingStyle.Quint
            tweenService:Create(ring, newTweenInfo3(v407, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), v404):Play()
            v289.glow.Size = UDim2.fromOffset(675, 210.79999999999998)
            v289.glow.ImageTransparency = 0.4
            local glow = v289.glow
            v404 = {ImageTransparency = 1, Size = UDim2.fromOffset(1080, 322.40000000000003)}
            local quad2 = Enum.EasingStyle.Quad
            local newTweenInfo4 = TweenInfo.new
            local v412 = pace * 0.8
            local easingStyle4 = quad2 or Enum.EasingStyle.Quint
            tweenService:Create(glow, newTweenInfo4(v412, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), v404):Play()
            v289.flare.Position = UDim2.fromOffset(-930, 0)
            v289.flare.ImageTransparency = 1
            local flare = v289.flare
            local propertyTable3 = {Position = UDim2.fromOffset(930, 0)}
            local quad3 = Enum.EasingStyle.Quad
            local inOut = Enum.EasingDirection.InOut
            v412 = TweenInfo.new
            local v418 = pace * 0.55
            local easingStyle5 = quad3 or Enum.EasingStyle.Quint
            local easingDirection = inOut or Enum.EasingDirection.Out
            tweenService:Create(flare, v412(v418, easingStyle5, easingDirection, 0, false, 0 * pace), propertyTable3):Play()
            local flare2 = v289.flare
            local propertyTable4 = {ImageTransparency = 0.12}
            local quad4 = Enum.EasingStyle.Quad
            local newTweenInfo5 = TweenInfo.new
            local v425 = pace * 0.12
            local easingStyle6 = quad4 or Enum.EasingStyle.Quint
            tweenService:Create(flare2, newTweenInfo5(v425, easingStyle6, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable4):Play()
            local flare3 = v289.flare
            local propertyTable5 = {ImageTransparency = 1}
            local quad5 = Enum.EasingStyle.Quad
            local inValue = Enum.EasingDirection.In
            local newTweenInfo6 = TweenInfo.new
            local v432 = pace * 0.2
            local easingStyle7 = quad5 or Enum.EasingStyle.Quint
            local easingDirection2 = inValue or Enum.EasingDirection.Out
            tweenService:Create(flare3, newTweenInfo6(v432, easingStyle7, easingDirection2, 0, false, 0.36 * pace), propertyTable5):Play()
            timestamp = os.clock()
            v95 = 0.32

            if atmos ~= "off" and not renderSteppedConnection then
                renderSteppedConnection = runService.RenderStepped:Connect(
                    function(deltaTime: number)
                        --[[
                          line: 182
                          upvalues:
                            v92 (ref,  index: 1)
                            v93 (ref,  index: 2)
                            timestamp (ref,  index: 3)
                            v95 (ref,  index: 4)
                            atmos (ref,  index: 5)
                            ui2 (copy, index: 6)
                            renderSteppedConnection (ref,  index: 7)
                        ]]
                        v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                        local timestamp2 = os.clock()
                        local v437 = timestamp2 - timestamp
                        local v438 = 0

                        if v437 < 1 then
                            local v439
                            local v440 = v95
                            local v441 = v437 < 0 and 0
                                or (if v437 < 0.06 then v437 / 0.06 else math.exp(-(v437 - 0.06) / 0.14))
                            local v442 = v440 * v441
                            local v443 = v95 * 0.6
                            local v444 = v437 - 0.27

                            if not (v444 < 0) then
                                v439 = if v444 < 0.06 then v444 / 0.06 else math.exp(-(v444 - 0.06) / 0.14)
                            else
                                v439 = 0
                            end

                            v438 = v442 + v443 * v439
                        end

                        local v445 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                        ui2.ImageTransparency = math.clamp((v92 - v438) + v445, math.min(v92, 0.14), 1)

                        if atmos == "off" and 0.995 < v92 and 1 < v437 then
                            ui2.ImageTransparency = 1
                            ui2.Visible = false

                            if renderSteppedConnection then
                                renderSteppedConnection:Disconnect()
                                renderSteppedConnection = nil
                            end
                        end
                    end
                )
            end

            if result then
                pcall(result.Play, "Match/Final_Round", nil, nil)
            end

            if result and result.Duck then
                pcall(result.Duck, "Music", 0.3, 2.4)
            end

            if result and result.Duck then
                pcall(result.Duck, "Ambient", 0.5, 2.4)
            end

            local row = v289.row
            local propertyTable6 = {Position = UDim2.fromOffset(0, 132)}
            local quint = Enum.EasingStyle.Quint
            local out = Enum.EasingDirection.Out
            v425 = TweenInfo.new
            local v450 = pace * 0.34
            local quint2 = quint or Enum.EasingStyle.Quint
            local v452 = out

            if v452 then
                v452 = v289
            else
                v452 = Enum.EasingDirection.Out
                v452 = v289
            end

            tweenService:Create(row, v425(v450, quint2, v452, 0, false, 0.06 * pace), propertyTable6):Play()

            for v453, box in v452.boxes do
                box.box.Visible = true
                box.scale.Scale = 0.2
                local scale = box.scale
                local propertyTable7 = {Scale = 1}
                local back = Enum.EasingStyle.Back
                local out2 = Enum.EasingDirection.Out
                local v459 = 0.06 + v453 * 0.05
                local newTweenInfo7 = TweenInfo.new
                local v461 = pace * 0.34
                local easingStyle8 = back or Enum.EasingStyle.Quint
                local out3 = out2 or Enum.EasingDirection.Out
                tweenService:Create(scale, newTweenInfo7(v461, easingStyle8, out3, 0, false, (v459 or 0) * pace), propertyTable7):Play()
            end

            if v221 == nil then
                v452.dash.Visible = true
                v452.dash.BackgroundTransparency = 1
                local dash = v452.dash
                local propertyTable8 = {BackgroundTransparency = 0.15}
                local quad6 = Enum.EasingStyle.Quad
                local out4 = Enum.EasingDirection.Out
                local newTweenInfo8 = TweenInfo.new
                local v469 = pace * 0.25
                local easingStyle9 = quad6 or Enum.EasingStyle.Quint
                local out5 = out4 or Enum.EasingDirection.Out
                tweenService:Create(dash, newTweenInfo8(v469, easingStyle9, out5, 0, false, 0.1 * pace), propertyTable8):Play()
            end
        end

        task.delay(pace * 0.3, v377)

        local v472 = function()
            --[[
              line: 845
              upvalues:
                v290 (copy, index: 1)
                count2 (ref,  index: 2)
                v289 (copy, index: 3)
                tweenService (copy, index: 4)
                pace (ref,  index: 5)
            ]]
            if v290 ~= count2 then
                return
            end

            v289.sweep.TextTransparency = 0.15
            v289.sweepGrad.Offset = Vector2.new(-1, 0)
            local sweepGrad = v289.sweepGrad
            local propertyTable = {Offset = Vector2.new(1, 0)}
            local quad = Enum.EasingStyle.Quad
            local inOut = Enum.EasingDirection.InOut
            local newTweenInfo = TweenInfo.new
            local v478 = pace * 0.55
            local easingStyle = quad or Enum.EasingStyle.Quint
            local easingDirection = inOut or Enum.EasingDirection.Out
            tweenService:Create(sweepGrad, newTweenInfo(v478, easingStyle, easingDirection, 0, false, 0 * pace), propertyTable):Play()

            local v481 = function()
                --[[
                  line: 852
                  upvalues:
                    v290 (copy, index: 1)
                    count2 (ref,  index: 2)
                    v289 (copy, index: 3)
                ]]
                if v290 == count2 then
                    v289.sweep.TextTransparency = 1
                end
            end

            task.delay(pace * 0.6, v481)
        end

        task.delay(pace * 0.58, v472)
        v219 = os.clock() + (pace * 0.48)

        local v482 = function()
            --[[
              line: 860
              upvalues:
                v290 (copy, index: 1)
                count2 (ref,  index: 2)
                v220 (ref,  index: 3)
                decider (copy, index: 4)
            ]]
            if v290 == count2 and v220 then
                local v483 = v220
                v220 = nil
                decider.Digit(v483)
            end
        end

        task.delay(pace * 0.48, v482)
    end

    function decider.Digit(a484)
        --[[
          name: Digit
          line: 871
          upvalues:
            v151 (ref,  index: 1)
            cardUp (ref,  index: 2)
            v219 (ref,  index: 3)
            v220 (ref,  index: 4)
            v221 (ref,  index: 5)
            v222 (ref,  index: 6)
            color3 (copy, index: 7)
            color32 (copy, index: 8)
            color33 (copy, index: 9)
            tweenService (copy, index: 10)
            pace (ref,  index: 11)
            color34 (copy, index: 12)
            v52 (copy, index: 13)
            count2 (ref,  index: 14)
            random (copy, index: 15)
            runService (copy, index: 16)
            burst (copy, index: 17)
            timestamp (ref,  index: 18)
            v95 (ref,  index: 19)
            atmos (ref,  index: 20)
            renderSteppedConnection (ref,  index: 21)
            v92 (ref,  index: 22)
            v93 (ref,  index: 23)
            ui2 (copy, index: 24)
            result (ref,  index: 25)
        ]]
        local v485 = v151

        if not v485 or not cardUp then
            return
        end

        local imageColor3

        if os.clock() < v219 then
            v220 = a484
            return
        end

        if a484 == v221 then
            return
        end

        local v487 = v221
        v221 = a484
        v222 += 1
        local clampedValue = math.clamp(4 - a484, 1, 3)

        if not (3 <= a484) then
            imageColor3 = if a484 == 2 then color32 else color33
        else
            imageColor3 = color3
        end

        v485.dash.Visible = false

        if v487 then
            v485.digitGhost.Text = tostring(v487)
            v485.digitGhost.TextTransparency = 0.25
            v485.ghostScale.Scale = 1.35
            local ghostScale = v485.ghostScale
            local propertyTable = {Scale = 2}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local v493 = pace * 0.3
            local easingStyle = quad or Enum.EasingStyle.Quint
            tweenService:Create(ghostScale, newTweenInfo(v493, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
            local digitGhost = v485.digitGhost
            local propertyTable2 = {TextTransparency = 1}
            local quad2 = Enum.EasingStyle.Quad
            local newTweenInfo2 = TweenInfo.new
            local v499 = pace * 0.3
            local easingStyle2 = quad2 or Enum.EasingStyle.Quint
            local tween = tweenService:Create(digitGhost, newTweenInfo2(v499, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2)
            tween:Play()
        end

        v485.digit.Text = tostring(a484)
        v485.digitGrad.Color = ColorSequence.new(color34, imageColor3)
        local digit = v485.digit
        digit.TextTransparency = 0

        if const v503 = v52[digit] then
            local stroke = v503.stroke
            local v505 = v52[digit]
            stroke.Transparency = if v505 then v505.base + (1 - v505.base) * 0 else 1
        end

        v485.digitScale.Scale = 2.4
        local digitScale = v485.digitScale
        local propertyTable = {Scale = 1.35}
        local back = Enum.EasingStyle.Back
        local newTweenInfo = TweenInfo.new
        local v510 = pace * 0.26
        local easingStyle = back or Enum.EasingStyle.Quint
        tweenService:Create(digitScale, newTweenInfo(v510, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
        v485.digitRing.ImageColor3 = imageColor3
        v485.digitRing.Size = UDim2.fromOffset(90, 90)
        v485.digitRing.ImageTransparency = 0.3
        local digitRing = v485.digitRing
        local propertyTable3 = {ImageTransparency = 1, Size = UDim2.fromOffset(480, 480)}
        local quart = Enum.EasingStyle.Quart
        local newTweenInfo3 = TweenInfo.new
        local v516 = pace * 0.6
        local easingStyle3 = quart or Enum.EasingStyle.Quint
        tweenService:Create(digitRing, newTweenInfo3(v516, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()

        for _, box in v485.boxes do
            box.scale.Scale = 1.1
            local scale = box.scale
            local propertyTable4 = {Scale = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo4 = TweenInfo.new
            local v524 = pace * 0.22
            local easingStyle4 = quad or Enum.EasingStyle.Quint
            tweenService:Create(scale, newTweenInfo4(v524, easingStyle4, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable4):Play()
        end

        local v526 = count2

        local v527 = function()
            --[[
              line: 914
              upvalues:
                v526 (copy, index: 1)
                count2 (ref,  index: 2)
                v485 (copy, index: 3)
                tweenService (copy, index: 4)
                pace (ref,  index: 5)
            ]]
            if v526 ~= count2 then
                return
            end

            for _, box in v485.boxes do
                box.scale.Scale = 1.05
                local scale = box.scale
                local propertyTable = {Scale = 1}
                local quad = Enum.EasingStyle.Quad
                local newTweenInfo = TweenInfo.new
                local v534 = pace * 0.2
                local easingStyle = quad or Enum.EasingStyle.Quint
                local tween = tweenService:Create(scale, newTweenInfo(v534, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable)
                tween:Play()
            end
        end

        task.delay(pace * 0.27, v527)
        local v537 = clampedValue * 2 + 3
        local v538 = count2
        local v539 = 0.2

        task.spawn(
            function()
                --[[
                  line: 621
                  upvalues:
                    v539 (copy, index: 1)
                    pace (ref,  index: 2)
                    v538 (copy, index: 3)
                    count2 (ref,  index: 4)
                    v485 (copy, index: 5)
                    random (copy, index: 6)
                    v537 (copy, index: 7)
                    runService (copy, index: 8)
                ]]
                local timestamp = os.clock()

                while os.clock() - timestamp < v539 * pace and v538 == count2 do
                    local v541 = 1 - (os.clock() - timestamp) / (v539 * pace)
                    v485.shaker.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v537) * v541, (random:NextNumber(-1, 1) * v537) * v541)
                    runService.RenderStepped:Wait()
                end

                if v538 == count2 then
                    v485.shaker.Position = UDim2.new()
                end
            end
        )

        burst(v485, (clampedValue * 4) + 8, Vector2.new(0, 132), Vector2.new(90, 110), 700, {sparkChance = 0.8, colors = {imageColor3, color32}})
        local v542 = clampedValue * 0.05 + 0.16
        timestamp = os.clock()
        v95 = v542

        if atmos ~= "off" and not renderSteppedConnection then
            renderSteppedConnection = runService.RenderStepped:Connect(
                function(deltaTime: number)
                    --[[
                      line: 182
                      upvalues:
                        v92 (ref,  index: 1)
                        v93 (ref,  index: 2)
                        timestamp (ref,  index: 3)
                        v95 (ref,  index: 4)
                        atmos (ref,  index: 5)
                        ui2 (copy, index: 6)
                        renderSteppedConnection (ref,  index: 7)
                    ]]
                    v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                    local timestamp2 = os.clock()
                    local v545 = timestamp2 - timestamp
                    local v546 = 0

                    if v545 < 1 then
                        local v547
                        local v548 = v95
                        local v549 = v545 < 0 and 0
                            or (if v545 < 0.06 then v545 / 0.06 else math.exp(-(v545 - 0.06) / 0.14))
                        local v550 = v548 * v549
                        local v551 = v95 * 0.6
                        local v552 = v545 - 0.27

                        if not (v552 < 0) then
                            v547 = if v552 < 0.06 then v552 / 0.06 else math.exp(-(v552 - 0.06) / 0.14)
                        else
                            v547 = 0
                        end

                        v546 = v550 + v551 * v547
                    end

                    local v553 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                    ui2.ImageTransparency = math.clamp((v92 - v546) + v553, math.min(v92, 0.14), 1)

                    if atmos == "off" and 0.995 < v92 and 1 < v545 then
                        ui2.ImageTransparency = 1
                        ui2.Visible = false

                        if renderSteppedConnection then
                            renderSteppedConnection:Disconnect()
                            renderSteppedConnection = nil
                        end
                    end
                end
            )
        end

        if result then
            pcall(result.Play, "Match/Final_Heartbeat", nil, nil)
        end
    end

    function decider.Fight()
        --[[
          name: Fight
          line: 930
          upvalues:
            v151 (ref,  index: 1)
            cardUp (ref,  index: 2)
            count2 (ref,  index: 3)
            v220 (ref,  index: 4)
            v221 (ref,  index: 5)
            v223 (ref,  index: 6)
            setAtmos (copy, index: 7)
            wanted (copy, index: 8)
            tweenService (copy, index: 9)
            pace (ref,  index: 10)
            textTo (copy, index: 11)
            v52 (copy, index: 12)
            random (copy, index: 13)
            runService (copy, index: 14)
            burst (copy, index: 15)
            color32 (copy, index: 16)
            timestamp (ref,  index: 17)
            v95 (ref,  index: 18)
            atmos (ref,  index: 19)
            renderSteppedConnection (ref,  index: 20)
            v92 (ref,  index: 21)
            v93 (ref,  index: 22)
            ui2 (copy, index: 23)
        ]]
        local v554 = v151

        if not v554 or not cardUp then
            return
        end

        local v555, v556
        count2 += 1
        local v557 = count2
        cardUp = false
        v220 = nil
        v221 = nil

        if v223 then
            v223()
            v223 = nil
        end

        setAtmos((wanted()))
        v554.band.AnchorPoint = Vector2.new(1, 0.5)
        v554.band.Position = UDim2.fromOffset(750, 0)
        local band = v554.band
        local propertyTable = {ImageTransparency = 0.6, Size = UDim2.fromOffset(0, 124)}
        local quint = Enum.EasingStyle.Quint
        local inValue = Enum.EasingDirection.In
        local newTweenInfo = TweenInfo.new
        local v563 = pace * 0.26
        local quint2 = quint or Enum.EasingStyle.Quint
        local easingDirection = inValue or Enum.EasingDirection.Out
        tweenService:Create(band, newTweenInfo(v563, quint2, easingDirection, 0, false, 0 * pace), propertyTable):Play()
        local ghost = v554.ghost
        local propertyTable2 = {ImageTransparency = 1}
        local quad = Enum.EasingStyle.Quad
        local newTweenInfo2 = TweenInfo.new
        local v570 = pace * 0.3
        local easingStyle = quad or Enum.EasingStyle.Quint
        tweenService:Create(ghost, newTweenInfo2(v570, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable2):Play()

        for _, instance in {v554.edgeTop, v554.edgeBottom} do
            local propertyTable3 = {BackgroundTransparency = 1}
            local quad2 = Enum.EasingStyle.Quad
            local newTweenInfo3 = TweenInfo.new
            local v577 = pace * 0.2
            local easingStyle2 = quad2 or Enum.EasingStyle.Quint
            tweenService:Create(instance, newTweenInfo3(v577, easingStyle2, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable3):Play()
        end

        for _, instance in {v554.head, v554.shadow} do
            textTo(instance, 0.2, 1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            local propertyTable4 = {Position = instance.Position - UDim2.fromOffset(0, 26)}
            local quint3 = Enum.EasingStyle.Quint
            local inValue2 = Enum.EasingDirection.In
            local newTweenInfo4 = TweenInfo.new
            local v585 = pace * 0.2
            local quint4 = quint3 or Enum.EasingStyle.Quint
            local easingDirection2 = inValue2 or Enum.EasingDirection.Out
            tweenService:Create(instance, newTweenInfo4(v585, quint4, easingDirection2, 0, false, 0 * pace), propertyTable4):Play()
        end

        local sweep = v554.sweep
        sweep.TextTransparency = 1

        if const v589 = v52[sweep] then
            local stroke = v589.stroke
            local _ = v52[sweep]
            local transparency = 1
            stroke.Transparency = transparency
            v555, v556 = v554, v557
        else
            v555, v556 = v554, v557
        end

        local row = v555.row
        local propertyTable5 = {Position = UDim2.fromOffset(0, 172)}
        local quint5 = Enum.EasingStyle.Quint
        local inValue3 = Enum.EasingDirection.In
        v570 = TweenInfo.new
        local v597 = pace * 0.25
        local quint6 = quint5 or Enum.EasingStyle.Quint
        local easingDirection3 = inValue3 or Enum.EasingDirection.Out
        tweenService:Create(row, v570(v597, quint6, easingDirection3, 0, false, 0 * pace), propertyTable5):Play()

        for _, box in v555.boxes do
            local scale = box.scale
            local propertyTable6 = {Scale = 0}
            local quint7 = Enum.EasingStyle.Quint
            local inValue4 = Enum.EasingDirection.In
            local newTweenInfo5 = TweenInfo.new
            local v607 = pace * 0.22
            local _ = quint7 or Enum.EasingStyle.Quint
            local easingDirection4 = inValue4 or Enum.EasingDirection.Out
            local v610
            tweenService:Create(scale, newTweenInfo5(v607, v610, easingDirection4, 0, false, 0 * pace), propertyTable6):Play()
        end

        textTo(v555.digit, 0.15, 1, Enum.EasingStyle.Quad)
        v555.dash.Visible = false
        local dim = v555.dim
        local propertyTable7 = {BackgroundTransparency = 1}
        local quad3 = Enum.EasingStyle.Quad
        local newTweenInfo6 = TweenInfo.new
        local v615 = pace * 0.35
        local easingStyle3 = quad3 or Enum.EasingStyle.Quint
        tweenService:Create(dim, newTweenInfo6(v615, easingStyle3, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable7):Play()
        v555.fight.Position = UDim2.fromOffset(0, 10)
        v555.fightShadow.Position = UDim2.fromOffset(0, 17)
        v555.fightScale.Scale = 2.52
        v555.fightShadowScale.Scale = 2.52
        local fightScale = v555.fightScale
        local propertyTable8 = {Scale = 1.4}
        local back = Enum.EasingStyle.Back
        local out = Enum.EasingDirection.Out
        local newTweenInfo7 = TweenInfo.new
        local v622 = pace * 0.24
        local easingStyle4 = back or Enum.EasingStyle.Quint
        local out2 = out or Enum.EasingDirection.Out
        tweenService:Create(fightScale, newTweenInfo7(v622, easingStyle4, out2, 0, false, 0.06 * pace), propertyTable8):Play()
        local fightShadowScale = v555.fightShadowScale
        local propertyTable9 = {Scale = 1.4}
        local back2 = Enum.EasingStyle.Back
        local out3 = Enum.EasingDirection.Out
        local newTweenInfo8 = TweenInfo.new
        local v630 = pace * 0.24
        local easingStyle5 = back2 or Enum.EasingStyle.Quint
        local out4 = out3 or Enum.EasingDirection.Out
        tweenService:Create(fightShadowScale, newTweenInfo8(v630, easingStyle5, out4, 0, false, 0.06 * pace), propertyTable9):Play()
        textTo(v555.fight, 0.08, 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.06)
        textTo(v555.fightShadow, 0.15, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.06)

        local v633 = function()
            --[[
              line: 975
              upvalues:
                v556 (copy, index: 1)
                count2 (ref,  index: 2)
                v555 (copy, index: 3)
                pace (ref,  index: 4)
                random (copy, index: 5)
                runService (copy, index: 6)
                burst (copy, index: 7)
                color32 (copy, index: 8)
                tweenService (copy, index: 9)
                timestamp (ref,  index: 10)
                v95 (ref,  index: 11)
                atmos (ref,  index: 12)
                renderSteppedConnection (ref,  index: 13)
                v92 (ref,  index: 14)
                v93 (ref,  index: 15)
                ui2 (copy, index: 16)
            ]]
            if v556 ~= count2 then
                return
            end

            local v634 = v555
            local v635 = count2
            local v636 = 0.28
            local v637 = 9

            task.spawn(
                function()
                    --[[
                      line: 621
                      upvalues:
                        v636 (copy, index: 1)
                        pace (ref,  index: 2)
                        v635 (copy, index: 3)
                        count2 (ref,  index: 4)
                        v634 (copy, index: 5)
                        random (copy, index: 6)
                        v637 (copy, index: 7)
                        runService (copy, index: 8)
                    ]]
                    local timestamp = os.clock()

                    while os.clock() - timestamp < v636 * pace and v635 == count2 do
                        local v639 = 1 - (os.clock() - timestamp) / (v636 * pace)
                        v634.shaker.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v637) * v639, (random:NextNumber(-1, 1) * v637) * v639)
                        runService.RenderStepped:Wait()
                    end

                    if v635 == count2 then
                        v634.shaker.Position = UDim2.new()
                    end
                end
            )

            burst(v555, 34, Vector2.new(0, 10), Vector2.new(361.2, 112), 1150)
            v555.ring.ImageColor3 = color32
            v555.ring.Size = UDim2.fromOffset(120, 120)
            v555.ring.ImageTransparency = 0.35
            local ring = v555.ring
            local propertyTable = {ImageTransparency = 1, Size = UDim2.fromOffset(1300, 1300)}
            local quart = Enum.EasingStyle.Quart
            local newTweenInfo = TweenInfo.new
            local v644 = pace * 0.55
            local easingStyle = quart or Enum.EasingStyle.Quint
            tweenService:Create(ring, newTweenInfo(v644, easingStyle, Enum.EasingDirection.Out, 0, false, 0 * pace), propertyTable):Play()
            timestamp = os.clock()
            v95 = 0.2

            if atmos ~= "off" and not renderSteppedConnection then
                renderSteppedConnection = runService.RenderStepped:Connect(
                    function(deltaTime: number)
                        --[[
                          line: 182
                          upvalues:
                            v92 (ref,  index: 1)
                            v93 (ref,  index: 2)
                            timestamp (ref,  index: 3)
                            v95 (ref,  index: 4)
                            atmos (ref,  index: 5)
                            ui2 (copy, index: 6)
                            renderSteppedConnection (ref,  index: 7)
                        ]]
                        v92 += ((v93 - v92) * (1 - math.exp(-deltaTime * 3)))
                        local timestamp2 = os.clock()
                        local v648 = timestamp2 - timestamp
                        local v649 = 0

                        if v648 < 1 then
                            local v650
                            local v651 = v95
                            local v652 = v648 < 0 and 0
                                or (if v648 < 0.06 then v648 / 0.06 else math.exp(-(v648 - 0.06) / 0.14))
                            local v653 = v651 * v652
                            local v654 = v95 * 0.6
                            local v655 = v648 - 0.27

                            if not (v655 < 0) then
                                v650 = if v655 < 0.06 then v655 / 0.06 else math.exp(-(v655 - 0.06) / 0.14)
                            else
                                v650 = 0
                            end

                            v649 = v653 + v654 * v650
                        end

                        local v656 = atmos ~= "live" and 0 or math.sin(timestamp2 * 2.4) * 0.03
                        ui2.ImageTransparency = math.clamp((v92 - v649) + v656, math.min(v92, 0.14), 1)

                        if atmos == "off" and 0.995 < v92 and 1 < v648 then
                            ui2.ImageTransparency = 1
                            ui2.Visible = false

                            if renderSteppedConnection then
                                renderSteppedConnection:Disconnect()
                                renderSteppedConnection = nil
                            end
                        end
                    end
                )
            end
        end

        task.delay(pace * 0.26, v633)

        local v657 = function()
            --[[
              line: 987
              upvalues:
                v557 (copy, index: 1)
                count2 (ref,  index: 2)
                v554 (copy, index: 3)
                textTo (copy, index: 4)
                tweenService (copy, index: 5)
                pace (ref,  index: 6)
                v223 (ref,  index: 7)
            ]]
            if v557 ~= count2 then
                return
            end

            for _, instance in {v554.fight, v554.fightShadow} do
                textTo(instance, 0.25, 1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                local propertyTable = {Position = instance.Position - UDim2.fromOffset(0, 18)}
                local quint = Enum.EasingStyle.Quint
                local inValue = Enum.EasingDirection.In
                local newTweenInfo = TweenInfo.new
                local v664 = pace * 0.25
                local quint2 = quint or Enum.EasingStyle.Quint
                local easingDirection = inValue or Enum.EasingDirection.Out
                local tween = tweenService:Create(instance, newTweenInfo(v664, quint2, easingDirection, 0, false, 0 * pace), propertyTable)
                tween:Play()
            end

            local v668 = function()
                --[[
                  line: 995
                  upvalues:
                    v557 (copy, index: 1)
                    count2 (ref,  index: 2)
                    v554 (copy, index: 3)
                    v223 (ref,  index: 4)
                ]]
                if v557 == count2 then
                    local v669 = v554

                    if v223 then
                        v223()
                        v223 = nil
                    end

                    v669.pool:Clear()
                    v669.root.Visible = false
                    v669.shaker.Position = UDim2.new()
                end
            end

            task.delay(pace * 0.3, v668)
        end

        task.delay(pace * 0.95, v657)
    end

    decider.IsDecider = isDecider

    decider.Active = function()
        --[[
          name: active
          line: 140
          upvalues:
            state (copy, index: 1)
            v14 (copy, index: 2)
            isDecider (copy, index: 3)
        ]]
        local match = state.Match
        return state.SeesMatch() and type(match) == "table" and v14[match.phase] == true and isDecider(match)
    end

    function decider.Showing()
        --[[
          name: Showing
          line: 1005
          upvalues:
            cardUp (ref, index: 1)
        ]]
        return cardUp
    end

    a17.Decider = decider

    a17.OnMatchEvent(
        function(a671)
            --[[
              line: 1011
              upvalues:
                decider (copy, index: 1)
                atmos (ref,  index: 2)
                count (ref,  index: 3)
                localPlayer (copy, index: 4)
                tween (ref,  index: 5)
                v93 (ref,  index: 6)
                v16 (copy, index: 7)
                v92 (ref,  index: 8)
                timestamp (ref,  index: 9)
                ui2 (copy, index: 10)
                renderSteppedConnection (ref,  index: 11)
                ui3 (ref,  index: 12)
            ]]
            if a671 ~= "RoundEnd" and a671 ~= "MatchEnd" and a671 ~= "MatchStart" and a671 ~= "PlayOfTheGame" then
                return
            end

            decider.Stop(a671 ~= "RoundEnd")

            if a671 == "MatchStart" then
                atmos = "off"
                count += 1

                if localPlayer:GetAttribute("FinalRound") ~= nil then
                    localPlayer:SetAttribute("FinalRound", nil)
                end

                if tween then
                    tween:Cancel()
                    tween = nil
                end

                v93 = v16.off
                v92 = v93
                timestamp = -math.huge
                ui2.ImageTransparency = 1
                ui2.Visible = false

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                local ui = ui3
                if not ui then
                    return
                end

                ui.Enabled = true
                ui:Destroy()
                ui3 = nil
            end
        end
    )

    state.MatchChanged:Connect(
        function()
            --[[
              line: 1019
              upvalues:
                setAtmos (copy, index: 1)
                wanted (copy, index: 2)
            ]]
            setAtmos((wanted()))
        end
    )

    state.PlayerStateChanged:Connect(
        function(a673)
            --[[
              line: 1022
              upvalues:
                state (copy, index: 1)
                decider (copy, index: 2)
                atmos (ref,  index: 3)
                count (ref,  index: 4)
                localPlayer (copy, index: 5)
                tween (ref,  index: 6)
                v93 (ref,  index: 7)
                v16 (copy, index: 8)
                v92 (ref,  index: 9)
                timestamp (ref,  index: 10)
                ui2 (copy, index: 11)
                renderSteppedConnection (ref,  index: 12)
                ui3 (ref,  index: 13)
            ]]
            if a673 ~= "Match" and not state.Watching() then
                decider.Stop(true)
                atmos = "off"
                count += 1

                if localPlayer:GetAttribute("FinalRound") ~= nil then
                    localPlayer:SetAttribute("FinalRound", nil)
                end

                if tween then
                    tween:Cancel()
                    tween = nil
                end

                v93 = v16.off
                v92 = v93
                timestamp = -math.huge
                ui2.ImageTransparency = 1
                ui2.Visible = false

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                if const ui = ui3 then
                    ui.Enabled = true
                    ui:Destroy()
                    ui3 = nil
                end
            end
        end
    )

    state.WatchChanged:Connect(
        function(a675)
            --[[
              line: 1028
              upvalues:
                state (copy, index: 1)
                decider (copy, index: 2)
                atmos (ref,  index: 3)
                count (ref,  index: 4)
                localPlayer (copy, index: 5)
                tween (ref,  index: 6)
                v93 (ref,  index: 7)
                v16 (copy, index: 8)
                v92 (ref,  index: 9)
                timestamp (ref,  index: 10)
                ui2 (copy, index: 11)
                renderSteppedConnection (ref,  index: 12)
                ui3 (ref,  index: 13)
                setAtmos (copy, index: 14)
                wanted (copy, index: 15)
            ]]
            if not a675 and not state.InMatch() then
                decider.Stop(true)
                atmos = "off"
                count += 1

                if localPlayer:GetAttribute("FinalRound") ~= nil then
                    localPlayer:SetAttribute("FinalRound", nil)
                end

                if tween then
                    tween:Cancel()
                    tween = nil
                end

                v93 = v16.off
                v92 = v93
                timestamp = -math.huge
                ui2.ImageTransparency = 1
                ui2.Visible = false

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                if const ui = ui3 then
                    ui.Enabled = true
                    ui:Destroy()
                    ui3 = nil
                end
            end

            setAtmos((wanted()))
        end
    )

    localPlayer:GetAttributeChangedSignal("ReplayPlaying"):Connect(
        function()
            --[[
              line: 1035
              upvalues:
                localPlayer (copy, index: 1)
                decider (copy, index: 2)
                atmos (ref,  index: 3)
                count (ref,  index: 4)
                tween (ref,  index: 5)
                v93 (ref,  index: 6)
                v16 (copy, index: 7)
                v92 (ref,  index: 8)
                timestamp (ref,  index: 9)
                ui2 (copy, index: 10)
                renderSteppedConnection (ref,  index: 11)
                ui3 (ref,  index: 12)
                setAtmos (copy, index: 13)
                wanted (copy, index: 14)
            ]]
            if localPlayer:GetAttribute("ReplayPlaying") ~= true then
                setAtmos((wanted()))
                return
            end

            decider.Stop(true)
            atmos = "off"
            count += 1

            if localPlayer:GetAttribute("FinalRound") ~= nil then
                localPlayer:SetAttribute("FinalRound", nil)
            end

            if tween then
                tween:Cancel()
                tween = nil
            end

            v93 = v16.off
            v92 = v93
            timestamp = -math.huge
            ui2.ImageTransparency = 1
            ui2.Visible = false

            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end

            local ui = ui3
            if not ui then
                return
            end

            ui.Enabled = true
            ui:Destroy()
            ui3 = nil
        end
    )

    setAtmos((wanted()))

    a17.Debug.finalRound = function(a678, a679)
        --[[
          line: 1046
          upvalues:
            decider (copy, index: 1)
            pace (ref,  index: 2)
            atmos (ref,  index: 3)
            cardUp (ref,  index: 4)
            state (copy, index: 5)
            v14 (copy, index: 6)
            isDecider (copy, index: 7)
            ui3 (ref,  index: 8)
            ui2 (copy, index: 9)
            localPlayer (copy, index: 10)
            v151 (ref,  index: 11)
            count2 (ref,  index: 12)
        ]]
        if a678 == "stop" then
            decider.Stop(true)
            pace = 1

            return true
        end

        if a678 == "state" then
            local v680 = {atmos = atmos, cardUp = cardUp}
            local match = state.Match
            local active = state.SeesMatch()
                and type(match) == "table"
                and v14[match.phase] == true
                and isDecider(match)
            v680.active = active
            v680.decider = isDecider()
            v680.cc = if ui3 then string.format("B%.3f C%.3f S%.3f", ui3.Brightness, ui3.Contrast, ui3.Saturation) else false
            v680.vignette = if ui2.Visible then math.floor((ui2.ImageTransparency * 100) + 0.5) / 100 else false
            local finalRound = localPlayer:GetAttribute("FinalRound") == true
            v680.attr = finalRound
            v680.cardVisible = v151 ~= nil and v151.root.Visible

            return v680
        end

        if type(a679) ~= "number" or not (0 < a679) then
            pace = 1
        else
            pace = a679
        end

        local intro = decider.Intro
        local round = state.Match and state.Match.round or 5
        intro(round)
        local v686 = count2
        decider.Digit(3)

        for v687, v688 in {2, 1} do
            local v689 = function()
                --[[
                  line: 1070
                  upvalues:
                    cardUp (ref,  index: 1)
                    count2 (ref,  index: 2)
                    v686 (ref,  index: 3)
                    decider (copy, index: 4)
                    v688 (copy, index: 5)
                ]]
                if cardUp and count2 == v686 then
                    decider.Digit(v688)
                end
            end

            task.delay(v687 * pace, v689)
        end

        local v690 = function()
            --[[
              line: 1076
              upvalues:
                cardUp (ref,  index: 1)
                count2 (ref,  index: 2)
                v686 (ref,  index: 3)
                decider (copy, index: 4)
            ]]
            if cardUp and count2 == v686 then
                decider.Fight()
            end
        end

        task.delay(pace * 3, v690)

        local v691 = function()
            --[[
              line: 1081
              upvalues:
                pace (ref, index: 1)
            ]]
            pace = 1
        end

        task.delay(pace * 4.4, v691)

        return true
    end
end

return v6