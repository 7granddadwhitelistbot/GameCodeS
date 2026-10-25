local Lighting_upv_1 = game:GetService("Lighting")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local tbl_1 = {}
local u1 = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
local fromRGB_upv_1 = Color3.fromRGB
local u2 = fromRGB_upv_1(255, 198, 96)
local u3 = fromRGB_upv_1(255, 146, 52)
local u4 = fromRGB_upv_1(255, 98, 50)
local u5 = fromRGB_upv_1(255, 236, 200)
local u6 = fromRGB_upv_1(38, 12, 5)
tbl_1.Color = u3
local tbl_upv_2 = {Live = true, Overtime = true, PreRound = true}
local tbl_upv_3 = {}
tbl_upv_3.count = {Brightness = -0.04, Saturation = 0.1, Contrast = 0.14, TintColor = fromRGB_upv_1(255, 234, 212)}
tbl_upv_3.live = {Brightness = -0.02, Saturation = 0.07, Contrast = 0.08, TintColor = fromRGB_upv_1(255, 243, 230)}
tbl_upv_3.off = {Brightness = 0, Saturation = 0, Contrast = 0, TintColor = fromRGB_upv_1(255, 255, 255)}
local tbl_upv_4 = {live = 0.54, off = 1, count = 0.34}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 62
      upvalues:
        Players_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
        u6 (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        Lighting_upv_1 (copy, index: 7)
        tbl_upv_4 (copy, index: 8)
        tbl_upv_3 (copy, index: 9)
        u1 (copy, index: 10)
        u3 (copy, index: 11)
        fromRGB_upv_1 (copy, index: 12)
        u2 (copy, index: 13)
        u5 (copy, index: 14)
        u4 (copy, index: 15)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local u7 = UI_upv_1.Assets.Fx or {}
    local u8 = UI_upv_1.Assets.Icons or {}
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local Sfx_upv_1 = ReplicatedStorage_upv_1:WaitForChild("Shared"):FindFirstChild("Sfx")
    local success_1, v1 = pcall(
        function()
            --[[
              line: 72
              upvalues:
                Sfx_upv_1 (copy, index: 1)
            ]]
            if Sfx_upv_1 then
                return (require(Sfx_upv_1))
            end
            return nil
        end
    )
    local u9 = not (success_1) or type(v1) ~= "table" or v1
    local function playSfx(a2, a3)
        --[[
          name: playSfx
          line: 77
          upvalues:
            u9 (ref, index: 1)
        ]]
        if not u9 then
            return
        end
        pcall(u9.Play, a2, nil, a3)
    end
    local function duck(a4, a5, a6)
        --[[
          name: duck
          line: 82
          upvalues:
            u9 (ref, index: 1)
        ]]
        if not u9 or not u9.Duck then
            return
        end
        pcall(u9.Duck, a4, a5, a6)
    end
    if u9 and u9.Preload then
        pcall(u9.Preload, {"Match/Final_Round", "Match/Final_Heartbeat", "Music/Final_Round"})
    end
    local u10 = 1
    local function tw(a7, a8, a9, a10, a11, a12)
        --[[
          name: tw
          line: 93
          upvalues:
            TweenService_upv_1 (copy, index: 1)
            u10 (ref,  index: 2)
        ]]
        local v2 = a8 * u10
        local v3 = a10 or (Enum.EasingStyle.Quint)
        local v4 = TweenService_upv_1:Create(a7, TweenInfo.new(v2, v3, a11 or (Enum.EasingDirection.Out), 0, false, (a12 or 0) * u10), a9)
        v4:Play()
        return v4
    end
    local function after(a13, a14)
        --[[
          name: after
          line: 98
          upvalues:
            u10 (ref, index: 1)
        ]]
        task.delay(a13 * u10, a14)
    end
    local tbl_upv_5 = {}
    local function strokeFor(a15, a16)
        --[[
          name: strokeFor
          line: 108
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        local v5 = tbl_upv_5[a15]
        if v5 and not (a16 >= 1) then
            return v5.base + ((1 - v5.base) * a16)
        end
        return 1
    end
    local function textSet(a17, a18)
        --[[
          name: textSet
          line: 112
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        a17.TextTransparency = a18
        local v6 = tbl_upv_5[a17]
        if v6 then
            local stroke_1 = v6.stroke
            local v7 = tbl_upv_5[a17]
            local v8
            if not (v7) or a18 >= 1 then
                v8 = 1
            else
                v8 = v7.base + (1 - v7.base) * a18
            end
            stroke_1.Transparency = v8
        end
    end
    local function isDecider(a19)
        --[[
          name: isDecider
          line: 128
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v9
        if a19 ~= nil then
            v9 = a19
        else
            v9 = State_upv_1.Match
        end
        if type(v9) == "table" and type(v9.teams) == "table" then
            local v10
            if type(v9.roundsToWin) ~= "number" then
                v10 = State_upv_1.RoundsToWin()
            else
                v10 = v9.roundsToWin
            end
            if v10 < 2 then
                return false
            end
            local v11 = v9.teams[1]
            local v12 = v9.teams[2]
            local v13 = (type(v11) == "table") and ((type(v12) == "table") and ((v11.score == v10 - 1) and (v12.score == v10 - 1)))
            return v13
        end
        return false
    end
    local _, v14 = UI_upv_1.Screen("TR_FinalRound", -1, a1.PlayerGui, {fullBleed = true})
    local u11 = UI_upv_1.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, Visible = false, Size = UDim2.fromScale(1, 1), Image = u7.Vignette or "", ImageColor3 = u6, ScaleType = Enum.ScaleType.Stretch, Parent = v14})
    local u12 = false
    local u13 = "off"
    local u14 = nil
    local u15 = nil
    local u16 = 1
    local off_upv_1 = 1
    local u17 = -math.huge
    local u18 = 0.2
    local u19 = nil
    local u20 = 0
    local function pulse(a20)
        --[[
          name: pulse
          line: 169
        ]]
        if a20 < 0 then
            return 0
        elseif a20 < 0.06 then
            return a20 / 0.06
        else
            return (math.exp(-(a20 - 0.06) / 0.14))
        end
    end
    local function ensureLoop()
        --[[
          name: ensureLoop
          line: 178
          upvalues:
            u19 (ref,  index: 1)
            RunService_upv_1 (copy, index: 2)
        ]]
        if u19 then
            return
        end
        local v15 = RunService_upv_1.RenderStepped:Connect(function() end)
        u19 = v15
    end
    local function outline(a21, a22, a23)
        --[[
          name: outline
          line: 103
          upvalues:
            UI_upv_1 (copy, index: 1)
            u6 (copy, index: 2)
            tbl_upv_5 (copy, index: 3)
        ]]
        local v16 = UI_upv_1.TextStroke(u6, a22, a23)
        v16.Parent = a21
        tbl_upv_5[a21] = {stroke = v16, base = a23}
    end
    local function setAtmos(a24, a25)
        --[[
          name: setAtmos
          line: 204
          upvalues:
            u13 (ref,  index: 1)
            u20 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            u14 (ref,  index: 4)
            UI_upv_1 (copy, index: 5)
            Lighting_upv_1 (copy, index: 6)
            u15 (ref,  index: 7)
            off_upv_1 (ref,  index: 8)
            tbl_upv_4 (copy, index: 9)
            u16 (ref,  index: 10)
            u17 (ref,  index: 11)
            u11 (copy, index: 12)
            u19 (ref,  index: 13)
            RunService_upv_1 (copy, index: 14)
            tbl_upv_3 (copy, index: 16)
            TweenService_upv_1 (copy, index: 17)
        ]]
        if a24 == u13 and not (a25) then
            return
        end
        u13 = a24
        u20 = u20 + 1
        local u21 = u20
        local v17 = a24 ~= "off"
        local v18 = LocalPlayer_upv_1:GetAttribute("FinalRound")
        local v19
        if v17 then
            v19 = true
        else
            v19 = nil
        end
        if v18 ~= v19 then
            LocalPlayer_upv_1:SetAttribute("FinalRound", (v17 and true) or nil)
        end
        if v17 and not (u14) then
            local v20 = UI_upv_1.new("ColorCorrectionEffect", {Name = "TR_FinalRoundCC", Parent = Lighting_upv_1})
            u14 = v20
        end
        if u15 then
            u15:Cancel()
            u15 = nil
        end
        off_upv_1 = tbl_upv_4[a24]
        if a25 then
            u16 = off_upv_1
            u17 = -math.huge
        end
        if v17 then
            u11.Visible = true
            if not (u19) then
                local v21 = RunService_upv_1.RenderStepped:Connect(function() end)
                u19 = v21
            end
        elseif a25 then
            u11.ImageTransparency = 1
            u11.Visible = false
            if u19 then
                u19:Disconnect()
                u19 = nil
            end
        end
        local v22 = u14
        if not v22 then
            return
        end
        v22.Enabled = true
        if a25 then
            if v17 then
                for key_1, value_1 in tbl_upv_3[a24] do
                    v22[key_1] = value_1
                end
            else
                v22:Destroy()
                u14 = nil
            end
        else
            local v23 = ((a24 == "off") and 0.7) or (((a24 ~= "count") and 1.2) or 0.5)
            u15 = TweenService_upv_1:Create(v22, TweenInfo.new(v23, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), tbl_upv_3[a24])
            u15:Play()
            if (v17) then
                return
            end
            task.delay(
                v23 + 0.05,
                function()
                    --[[
                      line: 258
                      upvalues:
                        u21 (copy, index: 1)
                        u20 (ref,  index: 2)
                        u13 (ref,  index: 3)
                        u14 (ref,  index: 4)
                    ]]
                    if u21 ~= u20 or u13 ~= "off" or not u14 then
                        return
                    end
                    u14:Destroy()
                    u14 = nil
                end
            )
        end
    end
    local function wanted()
        --[[
          name: wanted
          line: 267
          upvalues:
            State_upv_1 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            u12 (ref,  index: 3)
            tbl_upv_2 (copy, index: 4)
            isDecider (copy, index: 5)
        ]]
        local Match_1 = State_upv_1.Match
        if State_upv_1.SeesMatch() and type(Match_1) == "table" and LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
            if u12 then
                return "count"
            elseif tbl_upv_2[Match_1.phase] and isDecider(Match_1) then
                if Match_1.phase ~= "PreRound" then
                    return "live"
                end
                return "count"
            else
                return "off"
            end
        end
        return "off"
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
    local function beat(a26)
        --[[
          name: beat
          line: 284
          upvalues:
            u17 (ref,  index: 1)
            u18 (ref,  index: 2)
            u13 (ref,  index: 3)
            u19 (ref,  index: 4)
            RunService_upv_1 (copy, index: 5)
        ]]
        u17 = os.clock()
        u18 = a26
        if u13 ~= "off" and not u19 then
            local v24 = RunService_upv_1.RenderStepped:Connect(function() end)
            u19 = v24
        end
    end
    local u22 = nil
    local function fadeEnds(a27)
        --[[
          name: fadeEnds
          line: 353
        ]]
        return NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(a27, 0), NumberSequenceKeypoint.new(1 - a27, 0), NumberSequenceKeypoint.new(1, 1)})
    end
    local function headlineLabel(a28, a29, a30)
        --[[
          name: headlineLabel
          line: 337
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v25 = UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "FINAL ROUND", TextSize = 100, Name = a29, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1400, 120), FontFace = u1, TextColor3 = Colors_upv_1.Text, ZIndex = a30, Parent = a28})
        return v25, UI_upv_1.new("UIScale", {Name = "HeadScale", Parent = v25})
    end
    local u23 = 0
    local u24 = 0
    local u25 = nil
    local u26 = nil
    local u27 = 0
    local u28 = nil
    local u29 = Random.new()
    local function shake(a31, a32, a33)
        --[[
          name: shake
          line: 619
          upvalues:
            u23 (ref, index: 1)
        ]]
        local _ = u23
        task.spawn(function() end)
    end
    local function burst(a34, a35, a36, a37, a38, a39)
        --[[
          name: burst
          line: 634
          upvalues:
            u10 (ref,  index: 1)
            u2 (copy, index: 2)
            u3 (copy, index: 3)
            u4 (copy, index: 4)
            u5 (copy, index: 5)
        ]]
        local v26 = a39 or {}
        a34.pool.Pace = u10
        local pool_1 = a34.pool
        local tbl_6 = {sparkChance = 0, lifeMult = 0, drag = 0, colors = 0, whiteChance = 0.3, mode = "box", grav = 0, white = 0}
        tbl_6.at = a36
        tbl_6.box = a37
        tbl_6.speed = a38
        tbl_6.colors = v26.colors or {u2, u3, u4}
        tbl_6.white = u5
        tbl_6.sparkChance = v26.sparkChance or 0.6
        tbl_6.grav = v26.grav
        tbl_6.drag = v26.drag
        tbl_6.lifeMult = v26.lifeMult
        pool_1:Burst(a35, tbl_6)
    end
    local function hideCard(a40)
        --[[
          name: hideCard
          line: 652
          upvalues:
            u28 (ref, index: 1)
        ]]
        if u28 then
            u28()
            u28 = nil
        end
        a40.pool:Clear()
        a40.root.Visible = false
        a40.shaker.Position = UDim2.new()
    end
    local tbl_upv_7 = {}
    local function textTo(a41, a42, a43, a44, a45, a46)
        --[[
          name: textTo
          line: 119
          upvalues:
            tw (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
        ]]
        tw(a41, a42, {TextTransparency = a43}, a44, a45, a46)
        local v27 = tbl_upv_5[a41]
        if v27 then
            local stroke_2 = v27.stroke
            local tbl_8 = {Transparency = 0}
            local v28 = tbl_upv_5[a41]
            local v29
            if not (v28) or a43 >= 1 then
                v29 = 1
            else
                v29 = v28.base + (1 - v28.base) * a43
            end
            tbl_8.Transparency = v29
            tw(stroke_2, a42, tbl_8, a44, a45, a46)
        end
    end
    local function cancelCard(a47)
        --[[
          name: cancelCard
          line: 665
          upvalues:
            u22 (ref,  index: 1)
            u12 (ref,  index: 2)
            u25 (ref,  index: 3)
            u26 (ref,  index: 4)
            u23 (ref,  index: 5)
            u28 (ref,  index: 6)
            textTo (copy, index: 7)
            TweenService_upv_1 (copy, index: 8)
            u10 (ref,  index: 9)
        ]]
        local v30 = u12
        u12 = false
        u25 = nil
        u26 = nil
        u23 = u23 + 1
        local u30 = u23
        if not u22 or not u22.root.Visible then
            return
        end
        if not a47 and v30 then
            if u28 then
                u28()
                u28 = nil
            end
            for _, value_2 in {u22.head, u22.shadow, u22.sweep, u22.aura, u22.digit, u22.digitGhost, u22.fight, u22.fightShadow} do
                textTo(value_2, 0.15, 1, Enum.EasingStyle.Quad)
            end
            for _, value_3 in {u22.band, u22.ghost, u22.flare, u22.glow, u22.ring, u22.digitRing} do
                local tbl_9 = {ImageTransparency = 1}
                TweenService_upv_1:Create(value_3, TweenInfo.new(u10 * 0.15, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_9):Play()
            end
            for _, value_4 in u22.boxes do
                value_4.box.Visible = false
            end
            u22.dash.Visible = false
            local tbl_10 = {BackgroundTransparency = 1}
            TweenService_upv_1:Create(u22.dim, TweenInfo.new(u10 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_10):Play()
            task.delay(
                u10 * 0.22,
                function()
                    --[[
                      line: 691
                      upvalues:
                        u30 (copy, index: 1)
                        u23 (ref,  index: 2)
                        u22 (copy, index: 3)
                        u28 (ref,  index: 4)
                    ]]
                    if u30 == u23 then
                        local v31 = u22
                        if u28 then
                            u28()
                            u28 = nil
                        end
                        v31.pool:Clear()
                        v31.root.Visible = false
                        v31.shaker.Position = UDim2.new()
                    end
                end
            )
        else
            if u28 then
                u28()
                u28 = nil
            end
            u22.pool:Clear()
            u22.root.Visible = false
            u22.shaker.Position = UDim2.new()
        end
    end
    function tbl_upv_7.Stop(a48)
        --[[
          name: Stop
          line: 701
          upvalues:
            cancelCard (copy, index: 1)
            setAtmos (copy, index: 2)
            wanted (copy, index: 3)
        ]]
        cancelCard(a48)
        setAtmos((wanted()))
    end
    local function buildCard()
        --[[
          name: buildCard
          line: 362
          upvalues:
            UI_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u8 (copy, index: 4)
            u3 (copy, index: 5)
            u7 (copy, index: 6)
            u6 (copy, index: 7)
            fadeEnds (copy, index: 8)
            fromRGB_upv_1 (copy, index: 9)
            u2 (copy, index: 10)
            headlineLabel (copy, index: 11)
            u5 (copy, index: 12)
            tbl_upv_5 (copy, index: 13)
            Theme_upv_1 (copy, index: 14)
            u1 (copy, index: 15)
        ]]
        local v32 = UI_upv_1.new("Frame", {Visible = false, Name = "FinalRound", ZIndex = 4, Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Overlay})
        local v33 = UI_upv_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = v32})
        local v34 = UI_upv_1.new("Frame", {Name = "Stage", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.265), Size = UDim2.fromOffset(0, 0), Parent = v32})
        local v35 = UI_upv_1.new("UIScale", {Name = "StageScale", Parent = v34})
        local u31 = UI_upv_1.new("Frame", {Name = "Shaker", Size = UDim2.fromOffset(0, 0), Parent = v34})
        local v36 = UI_upv_1.new("ImageLabel", {Name = "Glow", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1100, 360), Image = u8.Glow or "", ImageColor3 = u3, Parent = u31})
        local v37 = UI_upv_1.new("ImageLabel", {ImageTransparency = 1, Name = "GhostBand", ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1500, 198.4), Image = u7.Band or "", ImageColor3 = u6, ScaleType = Enum.ScaleType.Stretch, Parent = u31})
        UI_upv_1.new("UIGradient", {Transparency = fadeEnds(0.25), Parent = v37})
        local v38 = UI_upv_1.new("ImageLabel", {ImageTransparency = 0.06, Name = "Band", ZIndex = 2, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(0, 124), Image = u7.Band or "", ImageColor3 = Color3.new(1, 1, 1), ScaleType = Enum.ScaleType.Stretch, Parent = u31})
        local v39 = UI_upv_1.new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, u6), ColorSequenceKeypoint.new(0.3, fromRGB_upv_1(92, 30, 10)), ColorSequenceKeypoint.new(0.5, fromRGB_upv_1(120, 42, 12)), ColorSequenceKeypoint.new(0.7, fromRGB_upv_1(92, 30, 10)), ColorSequenceKeypoint.new(1, u6)}), Transparency = fadeEnds(0.14), Parent = v38})
        local function edge_1(a49)
            --[[
              name: edge
              line: 419
              upvalues:
                UI_upv_1 (copy, index: 1)
                u2 (copy, index: 2)
                u31 (copy, index: 3)
                fadeEnds (copy, index: 4)
            ]]
            local v40 = UI_upv_1.new("Frame", {ZIndex = 3, BorderSizePixel = 0, Name = a49, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(0, 3), BackgroundColor3 = u2, Parent = u31})
            UI_upv_1.new("UIGradient", {Transparency = fadeEnds(0.2), Parent = v40})
            return v40
        end
        local v41 = edge_1("EdgeTop")
        local v42 = edge_1("EdgeBottom")
        local v43 = UI_upv_1.new("ImageLabel", {ImageTransparency = 1, Name = "Flare", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(900, 96), Image = u7.Flare or "", ImageColor3 = u2, ScaleType = Enum.ScaleType.Stretch, Parent = u31})
        local v44 = UI_upv_1.new("ImageLabel", {Name = "Ring", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(100, 100), Image = u7.Ring or "", ImageColor3 = u2, Parent = u31})
        local v45, v46 = headlineLabel(u31, "Aura", 4)
        v45.TextColor3 = u3
        local v47, v48 = headlineLabel(u31, "Shadow", 4)
        v47.TextColor3 = Colors_upv_1.Void
        local v49, v50 = headlineLabel(u31, "Headline", 5)
        UI_upv_1.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(u5, u2), Parent = v49})
        local v51 = UI_upv_1.TextStroke(u6, 2, 0.35)
        v51.Parent = v49
        tbl_upv_5[v49] = {base = 0.35, stroke = v51}
        local v52, v53 = headlineLabel(u31, "Sweep", 6)
        v52.TextColor3 = u5
        local v54 = UI_upv_1.new("UIGradient", {Rotation = 18, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.44, 1), NumberSequenceKeypoint.new(0.5, 0.1), NumberSequenceKeypoint.new(0.56, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-1, 0), Parent = v52})
        local u32 = UI_upv_1.new("Frame", {Name = "Row", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, 132), Size = UDim2.fromOffset(0, 0), Parent = u31})
        local tbl_11 = {}
        for n_1 = 1, 2 do
            local v55
            if n_1 ~= 1 then
                v55 = Colors_upv_1.Enemy
            else
                v55 = Colors_upv_1.Ally
            end
            local new_1 = UI_upv_1.new
            local tbl_12 = {}
            tbl_12.Name = ((n_1 ~= 1) and "Theirs") or "Mine"
            tbl_12.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_12.Position = UDim2.fromOffset(((n_1 ~= 1) and 156) or -156, 0)
            tbl_12.Size = UDim2.fromOffset(92, 84)
            tbl_12.BackgroundColor3 = Color3.new(1, 1, 1)
            tbl_12.BackgroundTransparency = 0.05
            tbl_12.ZIndex = 6
            tbl_12[1], tbl_12[2], tbl_12[3] = UI_upv_1.Corner(14), UI_upv_1.Gradient(Theme_upv_1.Lighten(v55, 0.1), Theme_upv_1.Darken(v55, 0.35), 90), UI_upv_1.Stroke(Theme_upv_1.Lighten(v55, 0.4), 2.5, 0.25)
            tbl_12.Parent = u32
            local v56 = new_1("Frame", tbl_12)
            local v57 = UI_upv_1.new("UIScale", {Parent = v56})
            tbl_11[n_1] = {box = v56, digit = UI_upv_1.DisplayText({StrokeThickness = 2.5, Text = "2", Name = "Score", ZIndex = 7, TextSize = 62, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), TextColor3 = Colors_upv_1.Text, StrokeColor = Theme_upv_1.Darken(v55, 0.7), Parent = v56}), scale = v57}
        end
        local v58 = UI_upv_1.new("Frame", {Name = "Dash", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(36, 6), BackgroundColor3 = u2, ZIndex = 6, [1] = UI_upv_1.Corner(3), Parent = u32})
        local v59 = UI_upv_1.new("ImageLabel", {Name = "DigitRing", ImageTransparency = 1, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(90, 90), Image = u7.Ring or "", ImageColor3 = u2, Parent = u32})
        local function digitLabel_1(a50, a51)
            --[[
              name: digitLabel
              line: 537
              upvalues:
                UI_upv_1 (copy, index: 1)
                u1 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                u32 (copy, index: 4)
            ]]
            local v60 = UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "", TextSize = 100, Name = a50, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(180, 150), FontFace = u1, TextColor3 = Colors_upv_1.Text, ZIndex = a51, Parent = u32})
            return v60, UI_upv_1.new("UIScale", {Parent = v60})
        end
        local v61, v62 = digitLabel_1("DigitGhost", 6)
        local v63, v64 = digitLabel_1("Digit", 7)
        local v65 = UI_upv_1.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(u5, u2), Parent = v63})
        local v66 = UI_upv_1.TextStroke(u6, 2.5, 0.2)
        v66.Parent = v63
        tbl_upv_5[v63] = {base = 0.2, stroke = v66}
        UI_upv_1.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(u5, u3), Parent = v61})
        local v67, v68 = headlineLabel(u31, "FightShadow", 4)
        v67.TextColor3 = Colors_upv_1.Void
        v67.Text = "FIGHT!"
        local v69, v70 = headlineLabel(u31, "Fight", 5)
        v69.Text = "FIGHT!"
        UI_upv_1.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(u5, u3), Parent = v69})
        local v71 = UI_upv_1.TextStroke(u6, 2, 0.3)
        v71.Parent = v69
        tbl_upv_5[v69] = {base = 0.3, stroke = v71}
        local v72 = UI_upv_1.new("Frame", {ZIndex = 7, Name = "Particles", Size = UDim2.fromOffset(0, 0), Parent = u31})
        local tbl_13 = {}
        tbl_13.root = v32
        tbl_13.dim = v33
        tbl_13.stage = v34
        tbl_13.stageScale = v35
        tbl_13.shaker = u31
        tbl_13.glow = v36
        tbl_13.ring = v44
        tbl_13.band = v38
        tbl_13.bandGrad = v39
        tbl_13.ghost = v37
        tbl_13.edgeTop = v41
        tbl_13.edgeBottom = v42
        tbl_13.flare = v43
        tbl_13.head = v49
        tbl_13.headScale = v50
        tbl_13.shadow = v47
        tbl_13.shadowScale = v48
        tbl_13.aura = v45
        tbl_13.auraScale = v46
        tbl_13.sweep = v52
        tbl_13.sweepScale = v53
        tbl_13.sweepGrad = v54
        tbl_13.row = u32
        tbl_13.boxes = tbl_11
        tbl_13.digit = v63
        tbl_13.digitScale = v64
        tbl_13.digitGrad = v65
        tbl_13.digitGhost = v61
        tbl_13.ghostScale = v62
        tbl_13.digitRing = v59
        tbl_13.dash = v58
        tbl_13.fight = v69
        tbl_13.fightScale = v70
        tbl_13.fightShadow = v67
        tbl_13.fightShadowScale = v68
        tbl_13.pool = require(script.Parent.Parent.Fx).Pool(v72, 110, 7)
        return tbl_13
    end
    function tbl_upv_7.Intro(a52)
        --[[
          name: Intro
          line: 706
          upvalues:
            u22 (ref,  index: 1)
            buildCard (copy, index: 2)
            u12 (ref,  index: 3)
            u25 (ref,  index: 4)
            u26 (ref,  index: 5)
            u23 (ref,  index: 6)
            u28 (ref,  index: 7)
            u27 (ref,  index: 8)
            setAtmos (copy, index: 9)
            wanted (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            TweenService_upv_1 (copy, index: 12)
            u10 (ref,  index: 13)
            u17 (ref,  index: 14)
            u18 (ref,  index: 15)
            u13 (ref,  index: 16)
            u19 (ref,  index: 17)
            RunService_upv_1 (copy, index: 18)
            a1 (copy, index: 22)
            u3 (copy, index: 23)
            u2 (copy, index: 24)
            u4 (copy, index: 25)
            u5 (copy, index: 26)
            tbl_upv_5 (copy, index: 27)
            textTo (copy, index: 28)
            State_upv_1 (copy, index: 29)
            burst (copy, index: 31)
            u9 (ref,  index: 32)
            u24 (ref,  index: 33)
            tbl_upv_7 (copy, index: 34)
        ]]
        local u33 = u22 or (buildCard())
        u22 = u33
        u12 = false
        u25 = nil
        u26 = nil
        u23 = u23 + 1
        if u22 and u22.root.Visible then
            if u28 then
                u28()
                u28 = nil
            end
            u22.pool:Clear()
            u22.root.Visible = false
            u22.shaker.Position = UDim2.new()
        end
        u23 = u23 + 1
        local u34 = u23
        u12 = true
        u27 = 0
        setAtmos((wanted()))
        local Compact_1 = UI_upv_1.Compact
        u33.stageScale.Scale = (Compact_1 and 0.68) or 1
        local stage_1 = u33.stage
        stage_1.Position = UDim2.fromScale(0.5, (Compact_1 and 0.235) or 0.265)
        u33.shaker.Position = UDim2.new()
        u33.root.Visible = true
        u33.dim.BackgroundTransparency = 1
        local tbl_14 = {BackgroundTransparency = 0.72}
        TweenService_upv_1:Create(u33.dim, TweenInfo.new(u10 * 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_14):Play()
        u17 = os.clock()
        u18 = 0.28
        if u13 ~= "off" and not (u19) then
            local v73 = RunService_upv_1.RenderStepped:Connect(function() end)
            u19 = v73
        end
        u33.band.AnchorPoint = Vector2.new(0, 0.5)
        u33.band.Position = UDim2.fromOffset(-750, 0)
        u33.band.Size = UDim2.fromOffset(0, 124)
        u33.band.ImageTransparency = 0.06
        local tbl_15 = {}
        tbl_15.Size = UDim2.fromOffset(1500, 124)
        TweenService_upv_1:Create(u33.band, TweenInfo.new(u10 * 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_15):Play()
        u33.ghost.Size = UDim2.fromOffset(900, 198.4)
        u33.ghost.ImageTransparency = 1
        local tbl_16 = {ImageTransparency = 0.5}
        tbl_16.Size = UDim2.fromOffset(1724.9999999999998, 198.4)
        TweenService_upv_1:Create(u33.ghost, TweenInfo.new(u10 * 0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_16):Play()
        for key_2, value_5 in {u33.edgeTop, u33.edgeBottom} do
            value_5.Position = UDim2.fromOffset(((key_2 ~= 1) and 450) or -450, ((key_2 ~= 1) and 64) or -64)
            value_5.Size = UDim2.fromOffset(0, 3)
            value_5.BackgroundTransparency = 0
            local tbl_17 = {}
            tbl_17.Size = UDim2.fromOffset(1170, 3)
            tbl_17.Position = UDim2.fromOffset(0, value_5.Position.Y.Offset)
            local v74 = u10 * 0.45
            TweenService_upv_1:Create(value_5, TweenInfo.new(v74, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.08 * u10), tbl_17):Play()
        end
        a1.Sounds.Play("Whoosh", {pitch = 0.8, volume = 0.35})
        u33.pool.Pace = u10
        local Match_2 = u33.pool:Emit(16, {lifeMin = 1.3, speedMax = 70, base = 0.15, lifeMax = 2.2, drag = 0.6, whiteChance = 0.12, speedMin = 20, kind = "sparkle", mode = "box", grav = -170, size = 11, at = Vector2.new(0, 150), box = Vector2.new(1300, 60), colors = {u3, u2, u4}, white = u5})
        u28 = Match_2
        local tbl_18, v75, _, tbl_18 = nil, nil, nil, nil
        for v97, value_6 in {u33.head, u33.shadow, u33.sweep, u33.aura} do
            value_6.TextTransparency = 1
            local v76 = tbl_upv_5[value_6]
            if not (v76) then
                v75 = value_6
                v75.Position = UDim2.fromOffset(0, 0)
                continue
            end
            local stroke_3 = v76.stroke
            if tbl_upv_5[value_6] or not tbl_upv_5[value_6] then
                local v77 = 1
                v75 = value_6
                stroke_3.Transparency = v77
                v75.Position = UDim2.fromOffset(0, 0)
            end
        end
        tbl_18 = v78
        for v98, value_7 in {u33.fight, u33.fightShadow} do
            value_7.TextTransparency = 1
            local v79 = tbl_upv_5[value_7]
            if not (v79) then
                continue
            end
            local stroke_4 = v79.stroke
            if tbl_upv_5[value_7] or not tbl_upv_5[value_7] then
                local v80 = 1
                local v81 = tbl_18
                stroke_4.Transparency = v80
                tbl_18 = v81
            end
        end
        u33.shadow.Position = UDim2.fromOffset(0, 7)
        u33.sweepGrad.Offset = Vector2.new(-1, 0)
        for v99, value_8 in {u33.headScale, u33.shadowScale, u33.sweepScale} do
            value_8.Scale = 2.432
            local tbl_19 = {Scale = 1.28}
            TweenService_upv_1:Create(value_8, TweenInfo.new(u10 * 0.26, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.06 * u10), tbl_19):Play()
        end
        u33.auraScale.Scale = 1.28
        textTo(u33.head, 0.1, 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.06)
        tbl_18 = {TextTransparency = 0.5}
        local shadow_1 = u33.shadow
        local v82 = u10 * 0.2
        local v83 = Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint)
        TweenService_upv_1:Create(shadow_1, TweenInfo.new(v82, v83, Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.06 * u10), tbl_18):Play()
        Match_2 = State_upv_1.Match
        tbl_18 = State_upv_1.MyTeam()
        local v84, v85 = nil, nil
        for key_3, value_9 in u33.boxes do
            if Match_2 then
                v84 = Match_2.teams
                if v84 then
                    local teams_1 = Match_2.teams
                    if key_3 ~= 1 then
                        v83 = 3 - tbl_18
                    else
                        v83 = tbl_18
                    end
                    v84 = teams_1[v83]
                end
            else
                v84 = Match_2
            end
            local digit_1 = value_9.digit
            if not (v84) then
                v85 = 1
                digit_1.Text = tostring(v85)
                local v86
                v86.box.Visible = false
                continue
            end
            v85 = v84.score or 1
            digit_1.Text = tostring(v85)
            local v86
            v86.box.Visible = false
        end
        u33.dash.Visible = false
        local v87 = u33.digit
        v87.TextTransparency = 1
        tbl_18 = tbl_upv_5[v87]
        if tbl_18 then
            local stroke_5 = tbl_18.stroke
            local v88 = 1
            local v89, v90 = stroke_5, v88
            v89.Transparency = v90
        end
        v87 = u33.digitGhost
        v87.TextTransparency = 1
        local v91 = tbl_upv_5[v87]
        if v91 then
            local stroke_6 = v91.stroke
            local v92 = 1
            local v93, v94 = stroke_6, v92
            v93.Transparency = v94
        end
        u33.digitRing.ImageTransparency = 1
        u33.row.Position = UDim2.fromOffset(0, 156)
        task.delay(
            u10 * 0.3,
            function()
                --[[
                  line: 798
                  upvalues:
                    u34 (copy, index: 1)
                    u23 (ref,  index: 2)
                    u33 (copy, index: 3)
                    TweenService_upv_1 (copy, index: 4)
                    u10 (ref,  index: 5)
                    RunService_upv_1 (copy, index: 7)
                    burst (copy, index: 8)
                    u2 (copy, index: 9)
                    u17 (ref,  index: 10)
                    u18 (ref,  index: 11)
                    u13 (ref,  index: 12)
                    u19 (ref,  index: 13)
                    u9 (ref,  index: 17)
                    u26 (ref,  index: 18)
                ]]
                if u34 ~= u23 then
                    return
                end
                for _, value_10 in {u33.headScale, u33.shadowScale, u33.sweepScale} do
                    value_10.Scale = 1.3824
                    local tbl_20 = {Scale = 1.28}
                    TweenService_upv_1:Create(value_10, TweenInfo.new(u10 * 0.24, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_20):Play()
                end
                local _ = u23
                local v96 = 0.32
                local v97 = 11
                task.spawn(function() end)
                u33.aura.TextTransparency = 0.3
                u33.auraScale.Scale = 1.3056
                local tbl_21 = {Scale = 1.6640000000000001}
                TweenService_upv_1:Create(u33.auraScale, TweenInfo.new(u10 * 0.6, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_21):Play()
                local tbl_22 = {TextTransparency = 1}
                TweenService_upv_1:Create(u33.aura, TweenInfo.new(u10 * 0.6, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_22):Play()
                burst(u33, 44, Vector2.zero, Vector2.new(605.44, 102.4), 1250)
                u33.ring.ImageColor3 = u2
                u33.ring.Size = UDim2.fromOffset(120, 120)
                u33.ring.ImageTransparency = 0.3
                local tbl_23 = {ImageTransparency = 1}
                tbl_23.Size = UDim2.fromOffset(1500, 1500)
                TweenService_upv_1:Create(u33.ring, TweenInfo.new(u10 * 0.65, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_23):Play()
                u33.glow.Size = UDim2.fromOffset(675, 210.79999999999998)
                u33.glow.ImageTransparency = 0.4
                tbl_23 = {ImageTransparency = 1}
                tbl_23.Size = UDim2.fromOffset(1080, 322.40000000000003)
                TweenService_upv_1:Create(u33.glow, TweenInfo.new(u10 * 0.8, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_23):Play()
                u33.flare.Position = UDim2.fromOffset(-930, 0)
                u33.flare.ImageTransparency = 1
                tbl_23 = {}
                tbl_23.Position = UDim2.fromOffset(930, 0)
                TweenService_upv_1:Create(u33.flare, TweenInfo.new(u10 * 0.55, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.InOut or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_23):Play()
                tbl_23 = {ImageTransparency = 0.12}
                TweenService_upv_1:Create(u33.flare, TweenInfo.new(u10 * 0.12, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_23):Play()
                tbl_23 = {ImageTransparency = 1}
                TweenService_upv_1:Create(u33.flare, TweenInfo.new(u10 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0.36 * u10), tbl_23):Play()
                u17 = os.clock()
                u18 = 0.32
                if u13 ~= "off" and not (u19) then
                    local v95 = RunService_upv_1.RenderStepped:Connect(function() end)
                    u19 = v95
                end
                if u9 then
                    pcall(u9.Play, "Match/Final_Round", nil, nil)
                end
                if u9 and u9.Duck then
                    pcall(u9.Duck, "Music", 0.3, 2.4)
                end
                if u9 and u9.Duck then
                    pcall(u9.Duck, "Ambient", 0.5, 2.4)
                end
                tbl_23 = {}
                tbl_23.Position = UDim2.fromOffset(0, 132)
                TweenService_upv_1:Create(u33.row, TweenInfo.new(u10 * 0.34, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.06 * u10), tbl_23):Play()
                for key_4, value_11 in u33.boxes do
                    value_11.box.Visible = true
                    value_11.scale.Scale = 0.2
                    local tbl_24 = {Scale = 1}
                    TweenService_upv_1:Create(value_11.scale, TweenInfo.new(u10 * 0.34, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, ((0.06 + (key_4 * 0.05)) or 0) * u10), tbl_24):Play()
                end
                if u26 == nil then
                    u33.dash.Visible = true
                    u33.dash.BackgroundTransparency = 1
                    local tbl_25 = {BackgroundTransparency = 0.15}
                    TweenService_upv_1:Create(u33.dash, TweenInfo.new(u10 * 0.25, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.1 * u10), tbl_25):Play()
                end
            end
        )
        task.delay(
            u10 * 0.58,
            function()
                --[[
                  line: 845
                  upvalues:
                    u34 (copy, index: 1)
                    u23 (ref,  index: 2)
                    u33 (copy, index: 3)
                    TweenService_upv_1 (copy, index: 4)
                    u10 (ref,  index: 5)
                ]]
                if u34 ~= u23 then
                    return
                end
                u33.sweep.TextTransparency = 0.15
                u33.sweepGrad.Offset = Vector2.new(-1, 0)
                local tbl_26 = {}
                tbl_26.Offset = Vector2.new(1, 0)
                TweenService_upv_1:Create(u33.sweepGrad, TweenInfo.new(u10 * 0.55, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.InOut or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_26):Play()
                task.delay(
                    u10 * 0.6,
                    function()
                        --[[
                          line: 852
                          upvalues:
                            u34 (copy, index: 1)
                            u23 (ref,  index: 2)
                            u33 (copy, index: 3)
                        ]]
                        if u34 ~= u23 then
                            return
                        end
                        u33.sweep.TextTransparency = 1
                    end
                )
            end
        )
        local v96 = os.clock()
        u24 = v96 + (u10 * 0.48)
        task.delay(
            u10 * 0.48,
            function()
                --[[
                  line: 860
                  upvalues:
                    u34 (copy, index: 1)
                    u23 (ref,  index: 2)
                    u25 (ref,  index: 3)
                    tbl_upv_7 (copy, index: 4)
                ]]
                if u34 ~= u23 then
                    return
                end
                if u25 then
                    local v97 = u25
                    u25 = nil
                    tbl_upv_7.Digit(v97)
                end
            end
        )
    end
    function tbl_upv_7.Digit(a53)
        --[[
          name: Digit
          line: 871
          upvalues:
            u22 (ref,  index: 1)
            u12 (ref,  index: 2)
            u24 (ref,  index: 3)
            u25 (ref,  index: 4)
            u26 (ref,  index: 5)
            u27 (ref,  index: 6)
            u2 (copy, index: 7)
            u3 (copy, index: 8)
            u4 (copy, index: 9)
            TweenService_upv_1 (copy, index: 10)
            u10 (ref,  index: 11)
            u5 (copy, index: 12)
            tbl_upv_5 (copy, index: 13)
            u23 (ref,  index: 14)
            RunService_upv_1 (copy, index: 16)
            burst (copy, index: 17)
            u17 (ref,  index: 18)
            u18 (ref,  index: 19)
            u13 (ref,  index: 20)
            u19 (ref,  index: 21)
            u9 (ref,  index: 25)
        ]]
        if not u22 or not u12 then
            return
        end
        if os.clock() < u24 then
            u25 = a53
        elseif a53 ~= u26 then
            local v98 = u26
            u26 = a53
            u27 = u27 + 1
            local v99 = math.clamp(4 - a53, 1, 3)
            local v100
            if a53 >= 3 then
                v100 = u2
            elseif a53 ~= 2 then
                v100 = u4
            else
                v100 = u3
            end
            u22.dash.Visible = false
            if v98 then
                u22.digitGhost.Text = tostring(v98)
                u22.digitGhost.TextTransparency = 0.25
                u22.ghostScale.Scale = 1.35
                local tbl_27 = {Scale = 2}
                local ghostScale_1 = u22.ghostScale
                TweenService_upv_1:Create(ghostScale_1, TweenInfo.new(u10 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_27):Play()
                local tbl_28 = {TextTransparency = 1}
                TweenService_upv_1:Create(u22.digitGhost, TweenInfo.new(u10 * 0.3, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_28):Play()
            end
            u22.digit.Text = tostring(a53)
            u22.digitGrad.Color = ColorSequence.new(u5, v100)
            local digit_2 = u22.digit
            digit_2.TextTransparency = 0
            local v101 = tbl_upv_5[digit_2]
            local v102 = nil
            if v101 then
                local stroke_7 = v101.stroke
                v102 = tbl_upv_5[digit_2]
                local v103
                if v102 then
                    v103 = v102.base + (1 - v102.base) * 0
                else
                    v103 = 1
                end
                stroke_7.Transparency = v103
            end
            u22.digitScale.Scale = 2.4
            local tbl_29 = {Scale = 1.35}
            TweenService_upv_1:Create(u22.digitScale, TweenInfo.new(u10 * 0.26, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_29):Play()
            u22.digitRing.ImageColor3 = v100
            u22.digitRing.Size = UDim2.fromOffset(90, 90)
            u22.digitRing.ImageTransparency = 0.3
            local tbl_30 = {ImageTransparency = 1}
            tbl_30.Size = UDim2.fromOffset(480, 480)
            TweenService_upv_1:Create(u22.digitRing, TweenInfo.new(u10 * 0.6, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_30):Play()
            for _, value_12 in u22.boxes do
                value_12.scale.Scale = 1.1
                local tbl_31 = {Scale = 1}
                TweenService_upv_1:Create(value_12.scale, TweenInfo.new(u10 * 0.22, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_31):Play()
            end
            local u35 = u23
            task.delay(
                u10 * 0.27,
                function()
                    --[[
                      line: 914
                      upvalues:
                        u35 (copy, index: 1)
                        u23 (ref,  index: 2)
                        u22 (copy, index: 3)
                        TweenService_upv_1 (copy, index: 4)
                        u10 (ref,  index: 5)
                    ]]
                    if u35 ~= u23 then
                        return
                    end
                    for _, value_13 in u22.boxes do
                        value_13.scale.Scale = 1.05
                        local tbl_32 = {Scale = 1}
                        TweenService_upv_1:Create(value_13.scale, TweenInfo.new(u10 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_32):Play()
                    end
                end
            )
            local _ = v99 * 2 + 3
            local v105 = u23
            local v106 = 0.2
            task.spawn(function() end)
            burst(u22, (v99 * 4) + 8, Vector2.new(0, 132), Vector2.new(90, 110), 700, {sparkChance = 0.8, colors = {v100, u3}})
            u17 = os.clock()
            u18 = (v99 * 0.05) + 0.16
            if u13 ~= "off" and not (u19) then
                local v104 = RunService_upv_1.RenderStepped:Connect(function() end)
                u19 = v104
            end
            if u9 then
                pcall(u9.Play, "Match/Final_Heartbeat", nil, nil)
            end
        end
    end
    function tbl_upv_7.Fight()
        --[[
          name: Fight
          line: 930
          upvalues:
            u22 (ref,  index: 1)
            u12 (ref,  index: 2)
            u23 (ref,  index: 3)
            u25 (ref,  index: 4)
            u26 (ref,  index: 5)
            u28 (ref,  index: 6)
            setAtmos (copy, index: 7)
            wanted (copy, index: 8)
            TweenService_upv_1 (copy, index: 9)
            u10 (ref,  index: 10)
            textTo (copy, index: 11)
            tbl_upv_5 (copy, index: 12)
            u29 (copy, index: 13)
            RunService_upv_1 (copy, index: 14)
            burst (copy, index: 15)
            u3 (copy, index: 16)
            u17 (ref,  index: 17)
            u18 (ref,  index: 18)
            u13 (ref,  index: 19)
            u19 (ref,  index: 20)
            u16 (ref,  index: 21)
            off_upv_1 (ref,  index: 22)
            u11 (copy, index: 23)
        ]]
        if not u22 or not u12 then
            return
        end
        u23 = u23 + 1
        local u36 = u23
        u12 = false
        u25 = nil
        u26 = nil
        if u28 then
            u28()
            u28 = nil
        end
        setAtmos((wanted()))
        u22.band.AnchorPoint = Vector2.new(1, 0.5)
        u22.band.Position = UDim2.fromOffset(750, 0)
        local tbl_33 = {ImageTransparency = 0.6}
        tbl_33.Size = UDim2.fromOffset(0, 124)
        TweenService_upv_1:Create(u22.band, TweenInfo.new(u10 * 0.26, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_33):Play()
        local tbl_34 = {ImageTransparency = 1}
        local ghost_1 = u22.ghost
        local v105 = u10 * 0.3
        TweenService_upv_1:Create(ghost_1, TweenInfo.new(v105, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_34):Play()
        for _, value_14 in {u22.edgeTop, u22.edgeBottom} do
            local tbl_35 = {BackgroundTransparency = 1}
            TweenService_upv_1:Create(value_14, TweenInfo.new(u10 * 0.2, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_35):Play()
        end
        for _, value_15 in {u22.head, u22.shadow} do
            textTo(value_15, 0.2, 1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            local tbl_36 = {}
            tbl_36.Position = value_15.Position - UDim2.fromOffset(0, 26)
            TweenService_upv_1:Create(value_15, TweenInfo.new(u10 * 0.2, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_36):Play()
        end
        local sweep_1 = u22.sweep
        sweep_1.TextTransparency = 1
        local tbl_37 = tbl_upv_5[sweep_1]
        local u37
        if tbl_37 then
            local stroke_8 = tbl_37.stroke
            local v106 = 1
            local v107, v108, _ = stroke_8, v106, u22
            v107.Transparency = v108
        else
            u37 = u22
        end
        tbl_37 = {}
        tbl_37.Position = UDim2.fromOffset(0, 172)
        local row_1 = u37.row
        local v109 = u10 * 0.25
        TweenService_upv_1:Create(row_1, TweenInfo.new(v109, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_37):Play()
        for _, value_16 in u37.boxes do
            local tbl_38 = {Scale = 0}
            TweenService_upv_1:Create(value_16.scale, TweenInfo.new(u10 * 0.22, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_38):Play()
        end
        textTo(u37.digit, 0.15, 1, Enum.EasingStyle.Quad)
        u37.dash.Visible = false
        local tbl_39 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(u37.dim, TweenInfo.new(u10 * 0.35, Enum.EasingStyle.Quad or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_39):Play()
        u37.fight.Position = UDim2.fromOffset(0, 10)
        u37.fightShadow.Position = UDim2.fromOffset(0, 17)
        u37.fightScale.Scale = 2.52
        u37.fightShadowScale.Scale = 2.52
        tbl_39 = {Scale = 1.4}
        TweenService_upv_1:Create(u37.fightScale, TweenInfo.new(u10 * 0.24, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.06 * u10), tbl_39):Play()
        tbl_39 = {Scale = 1.4}
        TweenService_upv_1:Create(u37.fightShadowScale, TweenInfo.new(u10 * 0.24, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out or (Enum.EasingDirection.Out), 0, false, 0.06 * u10), tbl_39):Play()
        textTo(u37.fight, 0.08, 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.06)
        textTo(u37.fightShadow, 0.15, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.06)
        task.delay(
            u10 * 0.26,
            function()
                --[[
                  line: 975
                  upvalues:
                    u36 (copy, index: 1)
                    u23 (ref,  index: 2)
                    u37 (copy, index: 3)
                    u10 (ref,  index: 4)
                    u29 (copy, index: 5)
                    RunService_upv_1 (copy, index: 6)
                    burst (copy, index: 7)
                    u3 (copy, index: 8)
                    TweenService_upv_1 (copy, index: 9)
                    u17 (ref,  index: 10)
                    u18 (ref,  index: 11)
                    u13 (ref,  index: 12)
                    u19 (ref,  index: 13)
                    u16 (ref,  index: 14)
                    off_upv_1 (ref,  index: 15)
                    u11 (copy, index: 16)
                ]]
                if u36 ~= u23 then
                    return
                end
                local u38 = u37
                local u39 = u23
                local u40 = 0.28
                local u41 = 9
                task.spawn(
                    function()
                        --[[
                          line: 621
                          upvalues:
                            u40 (copy, index: 1)
                            u10 (ref,  index: 2)
                            u39 (copy, index: 3)
                            u23 (ref,  index: 4)
                            u38 (copy, index: 5)
                            u29 (copy, index: 6)
                            u41 (copy, index: 7)
                            RunService_upv_1 (copy, index: 8)
                        ]]
                        local v110 = os.clock()
                        while os.clock() - v110 < u40 * u10 and u39 == u23 do
                            local v111 = 1 - (os.clock() - v110) / (u40 * u10)
                            u38.shaker.Position = UDim2.fromOffset((u29:NextNumber(-1, 1) * u41) * v111, (u29:NextNumber(-1, 1) * u41) * v111)
                            RunService_upv_1.RenderStepped:Wait()
                        end
                        if u39 ~= u23 then
                            return
                        end
                        u38.shaker.Position = UDim2.new()
                    end
                )
                burst(u37, 34, Vector2.new(0, 10), Vector2.new(361.2, 112), 1150)
                u37.ring.ImageColor3 = u3
                u37.ring.Size = UDim2.fromOffset(120, 120)
                u37.ring.ImageTransparency = 0.35
                local tbl_40 = {ImageTransparency = 1}
                tbl_40.Size = UDim2.fromOffset(1300, 1300)
                TweenService_upv_1:Create(u37.ring, TweenInfo.new(u10 * 0.55, Enum.EasingStyle.Quart or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out, 0, false, 0 * u10), tbl_40):Play()
                u17 = os.clock()
                u18 = 0.2
                if u13 ~= "off" and not u19 then
                    local v112 = RunService_upv_1.RenderStepped:Connect(
                        function(a54)
                            --[[
                              line: 182
                              upvalues:
                                u16 (ref,  index: 1)
                                off_upv_1 (ref,  index: 2)
                                u17 (ref,  index: 3)
                                u18 (ref,  index: 4)
                                u13 (ref,  index: 5)
                                u11 (copy, index: 6)
                                u19 (ref,  index: 7)
                            ]]
                            u16 = u16 + (off_upv_1 - u16) * (1 - math.exp(-a54 * 3))
                            local v113 = os.clock()
                            local v114 = v113 - u17
                            local v115 = 0
                            if v114 < 1 then
                                local v116 = v114 < 0 and 0 or v114 < 0.06 and v114 / 0.06 or math.exp(-(v114 - 0.06) / 0.14)
                                local v117 = u18 * 0.6
                                local v118 = v114 - 0.27
                                local v119 = ((v118 < 0) and 0) or (((v118 < 0.06) and (v118 / 0.06)) or (math.exp(-(v118 - 0.06) / 0.14)))
                                v115 = u18 * v116 + v117 * v119
                            end
                            local v120 = ((u13 ~= "live") and 0) or (math.sin(v113 * 2.4) * 0.03)
                            u11.ImageTransparency = math.clamp((u16 - v115) + v120, math.min(u16, 0.14), 1)
                            if u13 ~= "off" or not (u16 > 0.995) or not (v114 > 1) then
                                return
                            end
                            u11.ImageTransparency = 1
                            u11.Visible = false
                            if not u19 then
                                return
                            end
                            u19:Disconnect()
                            u19 = nil
                        end
                    )
                    u19 = v112
                end
            end
        )
        task.delay(
            u10 * 0.95,
            function()
                --[[
                  line: 987
                  upvalues:
                    u36 (copy, index: 1)
                    u23 (ref,  index: 2)
                    u37 (copy, index: 3)
                    textTo (copy, index: 4)
                    TweenService_upv_1 (copy, index: 5)
                    u10 (ref,  index: 6)
                    u28 (ref,  index: 7)
                ]]
                if u36 ~= u23 then
                    return
                end
                for _, value_17 in {u37.fight, u37.fightShadow} do
                    textTo(value_17, 0.25, 1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    local tbl_41 = {}
                    tbl_41.Position = value_17.Position - UDim2.fromOffset(0, 18)
                    TweenService_upv_1:Create(value_17, TweenInfo.new(u10 * 0.25, Enum.EasingStyle.Quint or (Enum.EasingStyle.Quint), Enum.EasingDirection.In or (Enum.EasingDirection.Out), 0, false, 0 * u10), tbl_41):Play()
                end
                task.delay(
                    u10 * 0.3,
                    function()
                        --[[
                          line: 995
                          upvalues:
                            u36 (copy, index: 1)
                            u23 (ref,  index: 2)
                            u37 (copy, index: 3)
                            u28 (ref,  index: 4)
                        ]]
                        if u36 == u23 then
                            local v121 = u37
                            if u28 then
                                u28()
                                u28 = nil
                            end
                            v121.pool:Clear()
                            v121.root.Visible = false
                            v121.shaker.Position = UDim2.new()
                        end
                    end
                )
            end
        )
    end
    tbl_upv_7.IsDecider = isDecider
    tbl_upv_7.Active = function()
        --[[
          name: active
          line: 140
          upvalues:
            State_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            isDecider (copy, index: 3)
        ]]
        local Match_3 = State_upv_1.Match
        local v122 = State_upv_1.SeesMatch() and ((type(Match_3) == "table") and ((tbl_upv_2[Match_3.phase] == true) and (isDecider(Match_3))))
        return v122
    end
    function tbl_upv_7.Showing()
        --[[
          name: Showing
          line: 1005
          upvalues:
            u12 (ref, index: 1)
        ]]
        return u12
    end
    a1.Decider = tbl_upv_7
    a1.OnMatchEvent(
        function(a55)
            --[[
              line: 1011
              upvalues:
                tbl_upv_7 (copy, index: 1)
                u13 (ref,  index: 2)
                u20 (ref,  index: 3)
                LocalPlayer_upv_1 (copy, index: 4)
                u15 (ref,  index: 5)
                off_upv_1 (ref,  index: 6)
                tbl_upv_4 (copy, index: 7)
                u16 (ref,  index: 8)
                u17 (ref,  index: 9)
                u11 (copy, index: 10)
                u19 (ref,  index: 11)
                u14 (ref,  index: 12)
            ]]
            if a55 ~= "RoundEnd" and a55 ~= "MatchEnd" and a55 ~= "MatchStart" and a55 ~= "PlayOfTheGame" then
                return
            end
            tbl_upv_7.Stop(a55 ~= "RoundEnd")
            if a55 ~= "MatchStart" then
                return
            end
            u13 = "off"
            u20 = u20 + 1
            if LocalPlayer_upv_1:GetAttribute("FinalRound") ~= nil then
                LocalPlayer_upv_1:SetAttribute("FinalRound", nil)
            end
            if u15 then
                u15:Cancel()
                u15 = nil
            end
            off_upv_1 = tbl_upv_4.off
            u16 = off_upv_1
            u17 = -math.huge
            u11.ImageTransparency = 1
            u11.Visible = false
            if u19 then
                u19:Disconnect()
                u19 = nil
            end
            if not u14 then
                return
            end
            u14.Enabled = true
            u14:Destroy()
            u14 = nil
        end
    )
    State_upv_1.MatchChanged:Connect(
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
    State_upv_1.PlayerStateChanged:Connect(
        function(a56)
            --[[
              line: 1022
              upvalues:
                State_upv_1 (copy, index: 1)
                tbl_upv_7 (copy, index: 2)
                u13 (ref,  index: 3)
                u20 (ref,  index: 4)
                LocalPlayer_upv_1 (copy, index: 5)
                u15 (ref,  index: 6)
                off_upv_1 (ref,  index: 7)
                tbl_upv_4 (copy, index: 8)
                u16 (ref,  index: 9)
                u17 (ref,  index: 10)
                u11 (copy, index: 11)
                u19 (ref,  index: 12)
                u14 (ref,  index: 13)
            ]]
            if a56 == "Match" or (State_upv_1.Watching()) then
                return
            end
            tbl_upv_7.Stop(true)
            u13 = "off"
            u20 = u20 + 1
            if LocalPlayer_upv_1:GetAttribute("FinalRound") ~= nil then
                LocalPlayer_upv_1:SetAttribute("FinalRound", nil)
            end
            if u15 then
                u15:Cancel()
                u15 = nil
            end
            off_upv_1 = tbl_upv_4.off
            u16 = off_upv_1
            u17 = -math.huge
            u11.ImageTransparency = 1
            u11.Visible = false
            if u19 then
                u19:Disconnect()
                u19 = nil
            end
            if not u14 then
                return
            end
            u14.Enabled = true
            u14:Destroy()
            u14 = nil
        end
    )
    State_upv_1.WatchChanged:Connect(
        function(a57)
            --[[
              line: 1028
              upvalues:
                State_upv_1 (copy, index: 1)
                tbl_upv_7 (copy, index: 2)
                u13 (ref,  index: 3)
                u20 (ref,  index: 4)
                LocalPlayer_upv_1 (copy, index: 5)
                u15 (ref,  index: 6)
                off_upv_1 (ref,  index: 7)
                tbl_upv_4 (copy, index: 8)
                u16 (ref,  index: 9)
                u17 (ref,  index: 10)
                u11 (copy, index: 11)
                u19 (ref,  index: 12)
                u14 (ref,  index: 13)
                setAtmos (copy, index: 14)
                wanted (copy, index: 15)
            ]]
            if not (a57) then
                local v123 = State_upv_1.InMatch()
                if not (v123) then
                    tbl_upv_7.Stop(true)
                    u13 = "off"
                    u20 = u20 + 1
                    if LocalPlayer_upv_1:GetAttribute("FinalRound") ~= nil then
                        LocalPlayer_upv_1:SetAttribute("FinalRound", nil)
                    end
                    if u15 then
                        u15:Cancel()
                        u15 = nil
                    end
                    off_upv_1 = tbl_upv_4.off
                    u16 = off_upv_1
                    u17 = -math.huge
                    u11.ImageTransparency = 1
                    u11.Visible = false
                    if u19 then
                        u19:Disconnect()
                        u19 = nil
                    end
                    if u14 then
                        u14.Enabled = true
                        u14:Destroy()
                        u14 = nil
                    end
                end
            end
            setAtmos((wanted()))
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("ReplayPlaying"):Connect(
        function()
            --[[
              line: 1035
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                tbl_upv_7 (copy, index: 2)
                u13 (ref,  index: 3)
                u20 (ref,  index: 4)
                u15 (ref,  index: 5)
                off_upv_1 (ref,  index: 6)
                tbl_upv_4 (copy, index: 7)
                u16 (ref,  index: 8)
                u17 (ref,  index: 9)
                u11 (copy, index: 10)
                u19 (ref,  index: 11)
                u14 (ref,  index: 12)
                setAtmos (copy, index: 13)
                wanted (copy, index: 14)
            ]]
            if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                setAtmos((wanted()))
            else
                tbl_upv_7.Stop(true)
                u13 = "off"
                u20 = u20 + 1
                if LocalPlayer_upv_1:GetAttribute("FinalRound") ~= nil then
                    LocalPlayer_upv_1:SetAttribute("FinalRound", nil)
                end
                if u15 then
                    u15:Cancel()
                    u15 = nil
                end
                off_upv_1 = tbl_upv_4.off
                u16 = off_upv_1
                u17 = -math.huge
                u11.ImageTransparency = 1
                u11.Visible = false
                if u19 then
                    u19:Disconnect()
                    u19 = nil
                end
                if not u14 then
                    return
                end
                u14.Enabled = true
                u14:Destroy()
                u14 = nil
            end
        end
    )
    setAtmos((wanted()))
    a1.Debug.finalRound = function(a58, a59)
        --[[
          line: 1046
          upvalues:
            tbl_upv_7 (copy, index: 1)
            u10 (ref,  index: 2)
            u13 (ref,  index: 3)
            u12 (ref,  index: 4)
            State_upv_1 (copy, index: 5)
            tbl_upv_2 (copy, index: 6)
            isDecider (copy, index: 7)
            u14 (ref,  index: 8)
            u11 (copy, index: 9)
            LocalPlayer_upv_1 (copy, index: 10)
            u22 (ref,  index: 11)
            u23 (ref,  index: 12)
        ]]
        if a58 == "stop" then
            tbl_upv_7.Stop(true)
            u10 = 1
            return true
        elseif a58 ~= "state" then
            local tbl_42
            if type(a59) == "number" and (a59 > 0) then
                tbl_42 = a59
            else
                tbl_42 = 1
            end
            u10 = tbl_42
            tbl_upv_7.Intro(((State_upv_1.Match) and (State_upv_1.Match.round)) or 5)
            local u42 = u23
            tbl_upv_7.Digit(3)
            for key_5, value_upv_18 in {2, 1} do
                task.delay(
                    key_5 * u10,
                    function()
                        --[[
                          line: 1070
                          upvalues:
                            u12 (ref,  index: 1)
                            u23 (ref,  index: 2)
                            u42 (ref,  index: 3)
                            tbl_upv_7 (copy, index: 4)
                            value_upv_18 (copy, index: 5)
                        ]]
                        if not u12 or u23 ~= u42 then
                            return
                        end
                        tbl_upv_7.Digit(value_upv_18)
                    end
                )
            end
            task.delay(
                u10 * 3,
                function()
                    --[[
                      line: 1076
                      upvalues:
                        u12 (ref,  index: 1)
                        u23 (ref,  index: 2)
                        u42 (ref,  index: 3)
                        tbl_upv_7 (copy, index: 4)
                    ]]
                    if not u12 or u23 ~= u42 then
                        return
                    end
                    tbl_upv_7.Fight()
                end
            )
            task.delay(
                u10 * 4.4,
                function()
                    --[[
                      line: 1081
                      upvalues:
                        u10 (ref, index: 1)
                    ]]
                    u10 = 1
                end
            )
            return true
        else
            local tbl_42 = {attr = 0, vignette = 0, active = 0, cardVisible = 0, cc = 0, decider = 0}
            tbl_42.atmos = u13
            tbl_42.cardUp = u12
            local Match_4 = State_upv_1.Match
            tbl_42.active = State_upv_1.SeesMatch() and type(Match_4) == "table" and tbl_upv_2[Match_4.phase] == true and isDecider(Match_4)
            tbl_42.decider = isDecider()
            local v125
            if u14 then
                v125 = string.format("B%.3f C%.3f S%.3f", u14.Brightness, u14.Contrast, u14.Saturation)
            else
                v125 = false
            end
            tbl_42.cc = v125
            v125 = ((u11.Visible) and (math.floor((u11.ImageTransparency * 100) + 0.5) / 100)) or false
            tbl_42.vignette = v125
            v125 = LocalPlayer_upv_1:GetAttribute("FinalRound") == true
            tbl_42.attr = v125
            v125 = (u22 ~= nil) and (u22.root.Visible)
            tbl_42.cardVisible = v125
            return tbl_42
        end
    end
end
return tbl_1