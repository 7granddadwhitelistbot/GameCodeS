local ContextActionService_upv_1 = game:GetService("ContextActionService")
local Lighting_upv_1 = game:GetService("Lighting")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local TweenService_upv_1 = game:GetService("TweenService")
local Ranks_upv_1 = require(ReplicatedStorage_1.Shared.Ranks)
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local Fx_upv_1 = require(script.Parent.Parent.Fx)
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 33
      upvalues:
        Players_upv_1 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        Fx_upv_1 (copy, index: 3)
        RankArt_upv_1 (copy, index: 4)
        Lighting_upv_1 (copy, index: 5)
        Ranks_upv_1 (copy, index: 6)
        ContextActionService_upv_1 (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local Assets_upv_1 = UI_upv_1.Assets
    local tbl_upv_2 = nil
    local tbl_upv_3 = nil
    local u1 = 0
    local function tw(a2, a3, a4, a5, a6)
        --[[
          name: tw
          line: 43
          upvalues:
            TweenService_upv_1 (copy, index: 1)
        ]]
        local v1 = a5 or (Enum.EasingStyle.Quad)
        local v2 = TweenService_upv_1:Create(a2, TweenInfo.new(a3, v1, a6 or (Enum.EasingDirection.Out)), a4)
        v2:Play()
        return v2
    end
    local function build()
        --[[
          name: build
          line: 49
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Assets_upv_1 (copy, index: 5)
            Fx_upv_1 (copy, index: 6)
            RankArt_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
        ]]
        if tbl_upv_2 then
            return
        end
        local v3, v4 = UI_upv_1.Screen("TR_RankUp", 31, a1.PlayerGui, {fullBleed = true})
        tbl_upv_2 = {sg = v3, canvas = v4}
        local v5 = UI_upv_1.new("Frame", {Visible = false, Name = "Root", Size = UDim2.fromScale(1, 1), Parent = v4})
        tbl_upv_2.root = v5
        tbl_upv_2.dim = UI_upv_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = v5})
        local v6 = UI_upv_1.new("Frame", {Name = "Stage", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1600, 900), Parent = v5})
        local u2 = UI_upv_1.new("UIScale", {Scale = 1, Parent = v6})
        local v7 = UI_upv_1.CanvasSize()
        u2.Scale = math.min(1, v7.X / 1600, v7.Y / 900)
        local function fit_1()
            --[[
              name: fit
              line: 62
              upvalues:
                UI_upv_1 (copy, index: 1)
                u2 (copy, index: 2)
            ]]
            local v8 = UI_upv_1.CanvasSize()
            u2.Scale = math.min(1, v8.X / 1600, v8.Y / 900)
        end
        UI_upv_1.ScaleChanged:Connect(fit_1)
        UI_upv_1.LayoutChanged:Connect(fit_1)
        tbl_upv_2.stage = v6
        tbl_upv_2.glow = UI_upv_1.Image(Assets_upv_1.Icons.Glow, {Name = "Glow", ZIndex = 2, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(1100, 1100), Parent = tbl_upv_2.stage})
        tbl_upv_2.rays = UI_upv_1.Image(Assets_upv_1.Fx.Rays, {Name = "Rays", ZIndex = 3, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(820, 820), Parent = tbl_upv_2.stage})
        tbl_upv_2.raysThin = UI_upv_1.Image(Assets_upv_1.Fx.RaysThin, {Name = "RaysThin", ZIndex = 3, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(980, 980), Parent = tbl_upv_2.stage})
        tbl_upv_2.ring = UI_upv_1.Image(Assets_upv_1.Fx.Ring, {Name = "Ring", ZIndex = 4, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(200, 200), Parent = tbl_upv_2.stage})
        tbl_upv_2.flash = UI_upv_1.new("Frame", {Name = "Flash", BackgroundTransparency = 1, ZIndex = 9, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.White, Parent = v5})
        tbl_upv_2.fxLayer = UI_upv_1.new("Frame", {Name = "FxLayer", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(0, 0), Parent = tbl_upv_2.stage})
        tbl_upv_2.pool = Fx_upv_1.Pool(tbl_upv_2.fxLayer, 90, 8)
        tbl_upv_2.emblemHolder = UI_upv_1.new("Frame", {Name = "EmblemHolder", ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(300, 300), Parent = tbl_upv_2.stage})
        tbl_upv_2.emblemScale = UI_upv_1.new("UIScale", {Scale = 1, Parent = tbl_upv_2.emblemHolder})
        tbl_upv_2.emblem = RankArt_upv_1.Emblem(1, 300, {ZIndex = 6, Parent = tbl_upv_2.emblemHolder})
        local emblem_1 = tbl_upv_2.emblem
        emblem_1.Size = UDim2.fromScale(1, 1)
        local tbl_4 = {}
        tbl_4.Name = "Kicker"
        tbl_4.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_4.Position = UDim2.fromScale(0.5, 0.11)
        tbl_4.Size = UDim2.fromOffset(800, 50)
        tbl_4.Text = "RANK UP"
        tbl_4.FontFace = Fonts_upv_1.Display
        tbl_4.TextSize = 46
        tbl_4.TextColor3 = Colors_upv_1.Text
        tbl_4.TextTransparency = 1
        tbl_4.ZIndex = 7
        tbl_4[1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 3, 0.3)
        tbl_4.Parent = tbl_upv_2.stage
        tbl_upv_2.kicker = UI_upv_1.new("TextLabel", tbl_4)
        tbl_upv_2.name = UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "", Name = "RankName", ZIndex = 7, TextSize = 104, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.615), Size = UDim2.fromOffset(1000, 110), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = tbl_upv_2.stage})
        tbl_upv_2.nameGrad = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = tbl_upv_2.name})
        tbl_upv_2.nameStroke = UI_upv_1.TextStroke(Colors_upv_1.Void, 4, 0.2)
        tbl_upv_2.nameStroke.Parent = tbl_upv_2.name
        tbl_upv_2.nameScale = UI_upv_1.new("UIScale", {Scale = 1, Parent = tbl_upv_2.name})
        local tbl_5 = {}
        tbl_5.Name = "Sub"
        tbl_5.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_5.Position = UDim2.fromScale(0.5, 0.68)
        tbl_5.Size = UDim2.fromOffset(900, 34)
        tbl_5.Text = ""
        tbl_5.FontFace = Fonts_upv_1.Heavy
        tbl_5.TextSize = 28
        tbl_5.TextColor3 = Colors_upv_1.TextDim
        tbl_5.TextTransparency = 1
        tbl_5.ZIndex = 7
        tbl_5[1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.35)
        tbl_5.Parent = tbl_upv_2.stage
        tbl_upv_2.sub = UI_upv_1.new("TextLabel", tbl_5)
        local tbl_6 = {}
        tbl_6.Name = "NewTitle"
        tbl_6.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_6.Position = UDim2.fromScale(0.5, 0.735)
        tbl_6.Size = UDim2.fromOffset(900, 28)
        tbl_6.Text = ""
        tbl_6.FontFace = Fonts_upv_1.Heavy
        tbl_6.TextSize = 22
        tbl_6.TextColor3 = Colors_upv_1.TextDim
        tbl_6.TextTransparency = 1
        tbl_6.ZIndex = 7
        tbl_6[1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.4)
        tbl_6.Parent = tbl_upv_2.stage
        tbl_upv_2.newTitle = UI_upv_1.new("TextLabel", tbl_6)
        local tbl_7 = {}
        tbl_7.Name = "Cards"
        tbl_7.AnchorPoint = Vector2.new(0.5, 0)
        tbl_7.Position = UDim2.fromScale(0.5, 0.76)
        tbl_7.Size = UDim2.fromOffset(1000, 132)
        tbl_7.ZIndex = 7
        tbl_7[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 16, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)
        tbl_7.Parent = tbl_upv_2.stage
        tbl_upv_2.cards = UI_upv_1.new("Frame", tbl_7)
        local tbl_8 = {}
        tbl_8.Name = "Continue"
        tbl_8.AnchorPoint = Vector2.new(0.5, 1)
        tbl_8.Position = UDim2.new(0.5, 0, 1, -14)
        tbl_8.Size = UDim2.fromOffset(260, 52)
        tbl_8.Text = ""
        tbl_8.AutoButtonColor = false
        tbl_8.BackgroundColor3 = Colors_upv_1.Panel
        tbl_8.BackgroundTransparency = 0.15
        tbl_8.Visible = false
        tbl_8.ZIndex = 10
        tbl_8[1], tbl_8[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.6)
        tbl_8.Parent = tbl_upv_2.stage
        tbl_upv_2.cont = UI_upv_1.new("TextButton", tbl_8)
        UI_upv_1.new("TextLabel", {ZIndex = 11, Name = "Label", Text = "CONTINUE", TextSize = 24, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = tbl_upv_2.cont})
        tbl_upv_2.contScale = UI_upv_1.new("UIScale", {Scale = 1, Parent = tbl_upv_2.cont})
        tbl_upv_2.catcher = UI_upv_1.new("TextButton", {AutoButtonColor = false, Name = "Catcher", ZIndex = 1, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v5})
    end
    local function blocked()
        --[[
          name: blocked
          line: 188
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v9 = true
        if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
            v9 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
        end
        return v9
    end
    local u3 = nil
    local function setBlur(a7)
        --[[
          name: setBlur
          line: 193
          upvalues:
            u3 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Lighting_upv_1 (copy, index: 3)
            TweenService_upv_1 (copy, index: 4)
        ]]
        if a7 then
            if not (u3) or not (u3.Parent) then
                local v10 = UI_upv_1.new("BlurEffect", {Name = "TR_RankUpBlur", Size = 0, Parent = Lighting_upv_1})
                u3 = v10
            end
            local tbl_9 = {Size = 14}
            TweenService_upv_1:Create(u3, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_9):Play()
        elseif u3 then
            local v11 = u3
            u3 = nil
            local tbl_10 = {Size = 0}
            local v12 = TweenService_upv_1:Create(v11, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_10)
            v12:Play()
            v12.Completed:Connect(function() end)
        end
    end
    local function clearCards()
        --[[
          name: clearCards
          line: 209
          upvalues:
            tbl_upv_2 (ref, index: 1)
        ]]
        for _, value_1 in tbl_upv_2.cards:GetChildren() do
            if value_1:IsA("GuiObject") then
                value_1:Destroy()
            end
        end
    end
    local function weaponCard(a8, a9, a10, a11)
        --[[
          name: weaponCard
          line: 217
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            tbl_upv_2 (ref,  index: 4)
            a1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
        ]]
        local tbl_11 = {}
        tbl_11.Name = "Card_" .. a8
        tbl_11.Size = UDim2.fromOffset(150, 132)
        tbl_11.BackgroundColor3 = Colors_upv_1.Panel
        tbl_11.BackgroundTransparency = 0.1
        tbl_11.LayoutOrder = a11
        tbl_11.ZIndex = 7
        tbl_11[1], tbl_11[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Large), UI_upv_1.Stroke(a10, 2, 0.25)
        tbl_11.Parent = tbl_upv_2.cards
        local v13 = UI_upv_1.new("Frame", tbl_11)
        UI_upv_1.new("UIScale", {Scale = 1, Parent = v13})
        a1.WeaponIcon.Set(UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(84, 84), Parent = v13}), a8, {spin = true})
        UI_upv_1.new("TextLabel", {TextScaled = false, Name = "Name", ZIndex = 8, TextSize = 17, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -12, 0, 22), Text = string.upper(a1.WeaponInfo.Name(a8)), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v13})
        local new_1 = UI_upv_1.new
        local v14 = "TextLabel"
        local tbl_12 = {}
        tbl_12.Name = "Tag"
        tbl_12.AnchorPoint = Vector2.new(1, 0)
        tbl_12.Position = UDim2.new(1, -6, 0, 6)
        tbl_12.AutomaticSize = Enum.AutomaticSize.X
        tbl_12.Size = UDim2.fromOffset(0, 20)
        tbl_12.Text = (a9 and " OWNED ") or " NEW "
        tbl_12.FontFace = Fonts_upv_1.Heavy
        tbl_12.TextSize = 14
        local v15
        if a9 then
            v15 = Colors_upv_1.TextDim
        else
            v15 = Colors_upv_1.TextDark
        end
        tbl_12.TextColor3 = v15
        local v16
        if a9 then
            v16 = Colors_upv_1.Raised
        else
            v16 = a10
        end
        tbl_12.BackgroundColor3 = v16
        tbl_12.BackgroundTransparency = 0
        tbl_12.ZIndex = 9
        tbl_12[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_12.Parent = v13
        new_1(v14, tbl_12)
        return v13
    end
    local u5 = nil
    local u6 = nil
    local u7 = nil
    local function u4(a12)
        --[[
          name: finish
          line: 277
          upvalues:
            tbl_upv_3 (ref,  index: 1)
            u1 (ref,  index: 2)
            u4 (ref,  index: 3)
            u5 (ref,  index: 4)
            u6 (ref,  index: 5)
            u7 (ref,  index: 6)
            u3 (ref,  index: 7)
            TweenService_upv_1 (copy, index: 8)
            tbl_upv_2 (ref,  index: 9)
            clearCards (copy, index: 10)
            a1 (copy, index: 11)
        ]]
        if not tbl_upv_3 then
            return
        end
        local onDone_1 = tbl_upv_3.onDone
        tbl_upv_3 = nil
        u1 = u1 + 1
        if u4 then
            u4()
            u4 = nil
        end
        if u5 then
            u5:Disconnect()
            u5 = nil
        end
        if u6 then
            u6:Disconnect()
            u6 = nil
        end
        if u7 then
            u7:Disconnect()
            u7 = nil
        end
        if u3 then
            local u8 = u3
            u3 = nil
            local tbl_13 = {Size = 0}
            local v17 = TweenService_upv_1:Create(u8, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_13)
            v17:Play()
            v17.Completed:Connect(
                function()
                    --[[
                      line: 203
                      upvalues:
                        u8 (copy, index: 1)
                    ]]
                    u8:Destroy()
                end
            )
        end
        tbl_upv_2.pool:Clear()
        for _, value_2 in {tbl_upv_2.glow, tbl_upv_2.rays, tbl_upv_2.raysThin, tbl_upv_2.ring} do
            local tbl_14 = {ImageTransparency = 1}
            TweenService_upv_1:Create(value_2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_14):Play()
        end
        for _, value_3 in {tbl_upv_2.kicker, tbl_upv_2.name, tbl_upv_2.sub, tbl_upv_2.newTitle} do
            local tbl_15 = {TextTransparency = 1}
            TweenService_upv_1:Create(value_3, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_15):Play()
        end
        local tbl_16 = {Transparency = 1}
        TweenService_upv_1:Create(tbl_upv_2.nameStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_16):Play()
        tbl_16 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(tbl_upv_2.dim, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_16):Play()
        tbl_upv_2.cont.Visible = false
        task.delay(
            0.25,
            function()
                --[[
                  line: 312
                  upvalues:
                    tbl_upv_3 (ref,  index: 1)
                    tbl_upv_2 (ref,  index: 2)
                    clearCards (copy, index: 3)
                ]]
                if (tbl_upv_3) then
                    return
                end
                tbl_upv_2.root.Visible = false
                clearCards()
            end
        )
        a1.SetHudHidden("RankUp", false)
        a1.MenuManager.HoldChat("RankUp", false)
        if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
            pcall(a1.TopbarSettings.SetHidden, "RankUp", false)
        end
        if not onDone_1 then
            return
        end
        task.spawn(onDone_1, a12)
    end
    local function settle(a13)
        --[[
          name: settle
          line: 329
          upvalues:
            tbl_upv_3 (ref,  index: 1)
            tbl_upv_2 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        if not tbl_upv_3 or tbl_upv_3.token ~= a13 or tbl_upv_3.settled then
            return
        end
        tbl_upv_3.settled = true
        tbl_upv_2.emblemScale.Scale = 1
        tbl_upv_2.nameScale.Scale = 1
        tbl_upv_2.kicker.TextTransparency = 0
        tbl_upv_2.name.TextTransparency = 0
        tbl_upv_2.nameStroke.Transparency = 0.2
        tbl_upv_2.sub.TextTransparency = 0
        tbl_upv_2.newTitle.TextTransparency = 0
        tbl_upv_2.glow.ImageTransparency = 0.35
        tbl_upv_2.rays.ImageTransparency = 0.55
        tbl_upv_2.raysThin.ImageTransparency = 0.75
        tbl_upv_2.dim.BackgroundTransparency = 0.22
        for _, value_4 in tbl_upv_3.cards do
            value_4.Visible = true
            local v18 = value_4:FindFirstChildOfClass("UIScale")
            if v18 then
                v18.Scale = 1
            end
        end
        tbl_upv_2.cont.Visible = true
        tbl_upv_3.contAt = os.clock()
        UI_upv_1.Pop(tbl_upv_2.cont, 0.6)
    end
    local function tap(a14)
        --[[
          name: tap
          line: 358
          upvalues:
            tbl_upv_3 (ref,  index: 1)
            settle (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        if not tbl_upv_3 then
            return
        end
        if tbl_upv_3.settled then
            if a14 and os.clock() - (tbl_upv_3.contAt or 0) > 0.35 then
                a1.Sounds.Play("Click")
                finish("done")
            end
        else
            settle(tbl_upv_3.token)
        end
    end
    local tbl_upv_17 = {}
    function tbl_upv_17.IsPlaying()
        --[[
          name: IsPlaying
          line: 372
          upvalues:
            tbl_upv_3 (ref, index: 1)
        ]]
        local v19 = tbl_upv_3 ~= nil
        return v19
    end
    function tbl_upv_17.Stop()
        --[[
          name: Stop
          line: 376
        ]]
        finish("interrupted")
    end
    function tbl_upv_17.Play(a15, a16)
        --[[
          name: Play
          line: 381
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            build (copy, index: 3)
            tbl_upv_3 (ref,  index: 4)
            u4 (copy, index: 5)
            u1 (ref,  index: 6)
            Ranks_upv_1 (copy, index: 7)
            RankArt_upv_1 (copy, index: 8)
            clearCards (copy, index: 9)
            tbl_upv_2 (ref,  index: 10)
            Theme_upv_1 (copy, index: 11)
            State_upv_1 (copy, index: 12)
            UI_upv_1 (copy, index: 13)
            weaponCard (copy, index: 14)
            u6 (ref,  index: 15)
            settle (copy, index: 16)
            u7 (ref,  index: 17)
            ContextActionService_upv_1 (copy, index: 18)
            u4 (ref,  index: 19)
            u5 (ref,  index: 20)
            u3 (ref,  index: 21)
            Lighting_upv_1 (copy, index: 22)
            TweenService_upv_1 (copy, index: 23)
        ]]
        local v20 = ((type(a15) == "table") and (tonumber(a15.rank))) or nil
        if not v20 then
            return false
        end
        local v21 = true
        if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
            v21 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
        end
        if v21 then
            return false
        end
        build()
        if tbl_upv_3 then
            finish("interrupted")
        end
        u1 = u1 + 1
        v21 = u1
        local v22 = math.clamp(math.floor(v20), 1, Ranks_upv_1.Count())
        local v23 = Ranks_upv_1.Get(v22)
        local u9, u10 = RankArt_upv_1.Color(v22)
        local v24 = Ranks_upv_1.NewItems(v22 - 1, v22)
        tbl_upv_3 = {settled = false, token = v21, onDone = a16, cards = {}}
        a1.SetHudHidden("RankUp", true)
        a1.MenuManager.HoldChat("RankUp", true)
        if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
            pcall(a1.TopbarSettings.SetHidden, "RankUp", true)
        end
        clearCards()
        tbl_upv_2.root.Visible = true
        tbl_upv_2.dim.BackgroundTransparency = 1
        tbl_upv_2.flash.BackgroundTransparency = 1
        for _, value_5 in {tbl_upv_2.glow, tbl_upv_2.rays, tbl_upv_2.raysThin, tbl_upv_2.ring} do
            value_5.ImageTransparency = 1
            value_5.ImageColor3 = u9
        end
        local raysThin_1 = tbl_upv_2.raysThin
        raysThin_1.ImageColor3 = Theme_upv_1.Lighten(u9, 0.4)
        local ring_1 = tbl_upv_2.ring
        ring_1.Size = UDim2.fromOffset(200, 200)
        RankArt_upv_1.SetEmblem(tbl_upv_2.emblem, v22)
        tbl_upv_2.emblem.Visible = false
        tbl_upv_2.emblemScale.Scale = 2.6
        tbl_upv_2.kicker.TextTransparency = 1
        local name_1 = tbl_upv_2.name
        name_1.Text = string.upper(v23.name)
        tbl_upv_2.name.TextTransparency = 1
        tbl_upv_2.nameStroke.Transparency = 1
        local nameGrad_1 = tbl_upv_2.nameGrad
        nameGrad_1.Color = ColorSequence.new(Theme_upv_1.Lighten(u9, 0.35), u9)
        tbl_upv_2.nameScale.Scale = 1.8
        local v25 = math.max(tonumber((State_upv_1.Profile or {}).trophies) or 0, v23.trophies)
        local sub_1 = tbl_upv_2.sub
        sub_1.Text = string.format("%s TROPHIES", UI_upv_1.FormatNumber(v25))
        tbl_upv_2.sub.TextTransparency = 1
        tbl_upv_2.newTitle.TextTransparency = 1
        if #v24 > 0 then
            local newTitle_1 = tbl_upv_2.newTitle
            newTitle_1.Text = ((#v24 ~= 1) and "NEW WEAPONS IN DROPS") or "NEW WEAPON IN DROPS"
        elseif Ranks_upv_1.Count() <= v22 then
            tbl_upv_2.newTitle.Text = "THE TOP RANK"
        else
            local v26 = Ranks_upv_1.Get(v22 + 1)
            local newTitle_2 = tbl_upv_2.newTitle
            newTitle_2.Text = string.format("NEXT: %s AT %s", string.upper(v26.name), UI_upv_1.FormatNumber(v26.trophies))
        end
        local Economy_1 = a1.Economy
        local _ = Economy_1 and (a1.Economy.Owns)
        for key_1, value_6 in v24 do
            if type(Economy_1) ~= "function" then
                v22 = false
            else
                v22 = Economy_1(value_6) == true
            end
            local v27 = weaponCard(value_6, v22, u9, key_1)
            v27.Visible = false
            table.insert(tbl_upv_3.cards, v27)
        end
        tbl_upv_2.cont.Visible = false
        local v28 = tbl_upv_2.catcher.Activated:Connect(
            function()
                --[[
                  line: 449
                  upvalues:
                    tbl_upv_3 (ref,  index: 1)
                    settle (copy, index: 2)
                ]]
                if not tbl_upv_3 or tbl_upv_3.settled then
                    return
                end
                settle(tbl_upv_3.token)
            end
        )
        u6 = v28
        v28 = tbl_upv_2.cont.Activated:Connect(
            function()
                --[[
                  line: 452
                  upvalues:
                    tbl_upv_3 (ref,  index: 1)
                    settle (copy, index: 2)
                    a1 (copy, index: 3)
                    finish (copy, index: 4)
                ]]
                if not tbl_upv_3 then
                    return
                end
                if tbl_upv_3.settled then
                    if os.clock() - (tbl_upv_3.contAt or 0) > 0.35 then
                        a1.Sounds.Play("Click")
                        finish("done")
                    end
                else
                    settle(tbl_upv_3.token)
                end
            end
        )
        u7 = v28
        ContextActionService_upv_1:BindActionAtPriority(
            "TR_RankUpKeys",
            function(a17, a18)
                --[[
                  line: 456
                  upvalues:
                    tbl_upv_3 (ref,  index: 1)
                    settle (copy, index: 2)
                    a1 (copy, index: 3)
                    finish (copy, index: 4)
                ]]
                if a18 == Enum.UserInputState.Begin and tbl_upv_3 then
                    if tbl_upv_3.settled then
                        if os.clock() - (tbl_upv_3.contAt or 0) > 0.35 then
                            a1.Sounds.Play("Click")
                            finish("done")
                        end
                    else
                        settle(tbl_upv_3.token)
                    end
                end
                return Enum.ContextActionResult.Sink
            end,
            false,
            Enum.ContextActionPriority.High.Value + 60,
            Enum.KeyCode.Space,
            Enum.KeyCode.Return,
            Enum.KeyCode.ButtonA
        )
        u4 = function()
            --[[
              line: 462
              upvalues:
                ContextActionService_upv_1 (copy, index: 1)
            ]]
            ContextActionService_upv_1:UnbindAction("TR_RankUpKeys")
        end
        v28 = game:GetService("RunService").RenderStepped:Connect(
            function(a19)
                --[[
                  line: 466
                  upvalues:
                    tbl_upv_3 (ref,  index: 1)
                    u1 (copy, index: 2)
                    tbl_upv_2 (ref,  index: 3)
                ]]
                if not tbl_upv_3 or tbl_upv_3.token ~= u1 then
                    return
                end
                tbl_upv_2.rays.Rotation = (tbl_upv_2.rays.Rotation + (a19 * 9)) % 360
                tbl_upv_2.raysThin.Rotation = (tbl_upv_2.raysThin.Rotation - (a19 * 5)) % 360
            end
        )
        u5 = v28
        local function alive()
            --[[
              name: alive
              line: 474
              upvalues:
                tbl_upv_3 (ref,  index: 1)
                u1 (copy, index: 2)
                LocalPlayer_upv_1 (copy, index: 3)
                a1 (copy, index: 4)
                finish (copy, index: 5)
            ]]
            if tbl_upv_3 and tbl_upv_3.token == u1 then
                local v29 = true
                if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                    v29 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                end
                if v29 then
                    finish("interrupted")
                    return false
                end
                return not tbl_upv_3.settled
            end
            return false
        end
        task.spawn(
            function()
                --[[
                  line: 485
                  upvalues:
                    u3 (ref,  index: 1)
                    UI_upv_1 (copy, index: 2)
                    Lighting_upv_1 (copy, index: 3)
                    TweenService_upv_1 (copy, index: 4)
                    tbl_upv_2 (ref,  index: 5)
                    tbl_upv_3 (ref,  index: 6)
                    u1 (copy, index: 7)
                    LocalPlayer_upv_1 (copy, index: 8)
                    a1 (copy, index: 9)
                    finish (copy, index: 10)
                    u9 (copy, index: 11)
                    Theme_upv_1 (copy, index: 12)
                    u10 (copy, index: 13)
                    settle (copy, index: 14)
                ]]
                if not (u3) or not (u3.Parent) then
                    local v30 = UI_upv_1.new("BlurEffect", {Name = "TR_RankUpBlur", Size = 0, Parent = Lighting_upv_1})
                    u3 = v30
                end
                local v31 = {Size = 14}
                TweenService_upv_1:Create(u3, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v31):Play()
                local tbl_18 = {BackgroundTransparency = 0.22}
                TweenService_upv_1:Create(tbl_upv_2.dim, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_18):Play()
                local tbl_19 = {ImageTransparency = 0.6}
                TweenService_upv_1:Create(tbl_upv_2.glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_19):Play()
                task.wait(0.25)
                local v32
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v32 = false
                    else
                        v32 = not tbl_upv_3.settled
                    end
                else
                    v32 = false
                end
                if not v32 then
                    return
                end
                local kicker_1 = tbl_upv_2.kicker
                kicker_1.Position = UDim2.fromScale(0.5, 0.08)
                local kicker_2 = tbl_upv_2.kicker
                v31 = {TextTransparency = 0}
                v31.Position = UDim2.fromScale(0.5, 0.11)
                TweenService_upv_1:Create(kicker_2, TweenInfo.new(0.35, Enum.EasingStyle.Back or (Enum.EasingStyle.Quad), Enum.EasingDirection.Out), v31):Play()
                a1.Sounds.Play("Whoosh")
                task.wait(0.2)
                local v33
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v33 = false
                    else
                        v33 = not tbl_upv_3.settled
                    end
                else
                    v33 = false
                end
                if not v33 then
                    return
                end
                tbl_upv_2.emblem.Visible = true
                v31 = {Scale = 1}
                TweenService_upv_1:Create(tbl_upv_2.emblemScale, TweenInfo.new(0.28, Enum.EasingStyle.Back or (Enum.EasingStyle.Quad), Enum.EasingDirection.Out or (Enum.EasingDirection.Out)), v31):Play()
                task.wait(0.2)
                local v34
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v34 = false
                    else
                        v34 = not tbl_upv_3.settled
                    end
                else
                    v34 = false
                end
                if not v34 then
                    return
                end
                a1.Sounds.Play("LevelUp")
                a1.Sounds.Play("Fanfare")
                tbl_upv_2.flash.BackgroundTransparency = 0.55
                v31 = {BackgroundTransparency = 1}
                TweenService_upv_1:Create(tbl_upv_2.flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v31):Play()
                tbl_upv_2.ring.ImageTransparency = 0.1
                local ring_2 = tbl_upv_2.ring
                local tbl_20 = {ImageTransparency = 1}
                tbl_20.Size = UDim2.fromOffset(900, 900)
                TweenService_upv_1:Create(ring_2, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_20):Play()
                local tbl_21 = {ImageTransparency = 0.35}
                TweenService_upv_1:Create(tbl_upv_2.glow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_21):Play()
                tbl_upv_2.pool:Burst(46, {life = 1.1, speed = 900, mode = "point", grav = 260, colors = {u9, Theme_upv_1.Lighten(u9, 0.4), u10}, white = Theme_upv_1.Lighten(u9, 0.7)})
                tbl_upv_2.pool:Burst(18, {life = 1.4, kind = "sparkle", speed = 420, mode = "point", grav = -40, size = 26, color = Theme_upv_1.Lighten(u9, 0.5)})
                UI_upv_1.Shake(tbl_upv_2.root, 10)
                v31 = {ImageTransparency = 0.55}
                TweenService_upv_1:Create(tbl_upv_2.rays, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v31):Play()
                local tbl_22 = {ImageTransparency = 0.75}
                TweenService_upv_1:Create(tbl_upv_2.raysThin, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_22):Play()
                task.wait(0.15)
                local v35
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v35 = false
                    else
                        v35 = not tbl_upv_3.settled
                    end
                else
                    v35 = false
                end
                if not v35 then
                    return
                end
                v31 = {TextTransparency = 0}
                TweenService_upv_1:Create(tbl_upv_2.name, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v31):Play()
                local tbl_23 = {Transparency = 0.2}
                TweenService_upv_1:Create(tbl_upv_2.nameStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_23):Play()
                local tbl_24 = {Scale = 1}
                TweenService_upv_1:Create(tbl_upv_2.nameScale, TweenInfo.new(0.32, Enum.EasingStyle.Back or (Enum.EasingStyle.Quad), Enum.EasingDirection.Out), tbl_24):Play()
                task.wait(0.3)
                local v36
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v36 = false
                    else
                        v36 = not tbl_upv_3.settled
                    end
                else
                    v36 = false
                end
                if not v36 then
                    return
                end
                v31 = {TextTransparency = 0}
                TweenService_upv_1:Create(tbl_upv_2.sub, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v31):Play()
                task.wait(0.45)
                local v37
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v37 = false
                    else
                        v37 = not tbl_upv_3.settled
                    end
                else
                    v37 = false
                end
                if not v37 then
                    return
                end
                v31 = {TextTransparency = 0}
                TweenService_upv_1:Create(tbl_upv_2.newTitle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v31):Play()
                local v38 = nil
                local v39 = nil
                for _, value_7 in tbl_upv_3.cards do
                    task.wait(0.2)
                    if not (tbl_upv_3) or tbl_upv_3.token ~= u1 then
                        v39 = false
                        if not v39 then
                            return
                        end
                        value_7.Visible = true
                        v39 = value_7:FindFirstChildOfClass("UIScale")
                        if v39 then
                            v39.Scale = 0.3
                            v38 = {Scale = 1}
                            TweenService_upv_1:Create(v39, TweenInfo.new(0.3, Enum.EasingStyle.Back or (Enum.EasingStyle.Quad), Enum.EasingDirection.Out), v38):Play()
                        end
                        a1.Sounds.Play("Coin", {pitch = 1.1})
                    end
                    v38 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v38 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v38 then
                        finish("interrupted")
                        v39 = false
                    else
                        v39 = not tbl_upv_3.settled
                    end
                    if not v39 then
                        return
                    end
                    value_7.Visible = true
                    v39 = value_7:FindFirstChildOfClass("UIScale")
                    if v39 then
                        v39.Scale = 0.3
                        v38 = {Scale = 1}
                        TweenService_upv_1:Create(v39, TweenInfo.new(0.3, Enum.EasingStyle.Back or (Enum.EasingStyle.Quad), Enum.EasingDirection.Out), v38):Play()
                    end
                    a1.Sounds.Play("Coin", {pitch = 1.1})
                end
                task.wait(0.5)
                local v40
                if (tbl_upv_3) and tbl_upv_3.token == u1 then
                    v31 = true
                    if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                        v31 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                    end
                    if v31 then
                        finish("interrupted")
                        v40 = false
                    else
                        v40 = not tbl_upv_3.settled
                    end
                else
                    v40 = false
                end
                if not v40 then
                    return
                end
                settle(u1)
            end
        )
        return true
    end
    a1.RankUp = tbl_upv_17
    a1.Debug.rankUp = function(a20)
        --[[
          line: 561
          upvalues:
            tbl_upv_17 (copy, index: 1)
        ]]
        return tbl_upv_17.Play(
            {source = "rank", rank = tonumber(a20) or 4},
            function(a21)
                --[[
                  line: 562
                ]]
                print("[RankUp] done:", a21)
            end
        )
    end
end
return tbl_1