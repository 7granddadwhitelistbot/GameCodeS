local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Lighting_upv_1 = game:GetService("Lighting")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local News_upv_1 = require(Shared_1:WaitForChild("News"))
local Ranks_upv_1 = require(Shared_1:WaitForChild("Ranks"))
local RankArt_upv_1 = require(script.Parent.Parent:WaitForChild("RankArt"))
local tbl_1 = {}
local u1 = Color3.fromRGB(255, 206, 92)
local u2 = Color3.fromRGB(214, 140, 34)
local tbl_upv_2 = {0, 2, 4, 5, 7, 9, 11}
local tbl_upv_3 = {{text = "Every win earns trophies.\nClimb to Immortal.", key = "trophy", title = "WIN TO CLIMB"}, {text = "Each rank adds new\nweapons to your drops.", key = "weapons", title = "NEW WEAPONS"}, {text = "Every rank-up opens\na Rank Reward.", key = "reward", title = "RANK REWARDS"}}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 61
      upvalues:
        Players_upv_1 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
        u2 (copy, index: 4)
        Ranks_upv_1 (copy, index: 5)
        RankArt_upv_1 (copy, index: 6)
        tbl_upv_3 (copy, index: 7)
        Lighting_upv_1 (copy, index: 8)
        tbl_upv_2 (copy, index: 9)
        News_upv_1 (copy, index: 10)
        RunService_upv_1 (copy, index: 11)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Assets_upv_1 = UI_upv_1.Assets
    local MenuManager_upv_1 = a1.MenuManager
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local tbl_upv_4 = nil
    local u3 = 0
    local u4 = false
    local u5 = nil
    local u6 = nil
    local u7 = nil
    local function tw(a2, a3, a4, a5, a6)
        --[[
          name: tw
          line: 75
          upvalues:
            TweenService_upv_1 (copy, index: 1)
        ]]
        local v1 = a5 or (Enum.EasingStyle.Quad)
        local v2 = TweenService_upv_1:Create(a2, TweenInfo.new(a3, v1, a6 or (Enum.EasingDirection.Out)), a4)
        v2:Play()
        return v2
    end
    local function close()
        --[[
          name: close
          line: 81
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("News")
    end
    local function build()
        --[[
          name: build
          line: 85
          upvalues:
            tbl_upv_4 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Assets_upv_1 (copy, index: 5)
            u1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            u2 (copy, index: 9)
            Ranks_upv_1 (copy, index: 10)
            RankArt_upv_1 (copy, index: 11)
            tbl_upv_3 (copy, index: 12)
            MenuManager_upv_1 (copy, index: 13)
            close (copy, index: 14)
        ]]
        if tbl_upv_4 then
            return
        end
        local v3, v4 = UI_upv_1.Screen("TR_News", 30, a1.PlayerGui, {fullBleed = true})
        tbl_upv_4 = {sg = v3}
        local v5 = UI_upv_1.new("Frame", {Visible = false, Name = "Root", Size = UDim2.fromScale(1, 1), Parent = v4})
        tbl_upv_4.root = v5
        tbl_upv_4.dim = UI_upv_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = v5})
        tbl_upv_4.catcher = UI_upv_1.new("TextButton", {ZIndex = 2, Name = "Backdrop", AutoButtonColor = false, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v5})
        local v6 = UI_upv_1.new("Frame", {Name = "Stage", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1600, 900), Parent = v5})
        local u8 = UI_upv_1.new("UIScale", {Scale = 1, Parent = v6})
        local v7 = UI_upv_1.CanvasSize()
        u8.Scale = math.min(1, v7.X / 1600, v7.Y / 900)
        local function fit_1()
            --[[
              name: fit
              line: 98
              upvalues:
                UI_upv_1 (copy, index: 1)
                u8 (copy, index: 2)
            ]]
            local v8 = UI_upv_1.CanvasSize()
            u8.Scale = math.min(1, v8.X / 1600, v8.Y / 900)
        end
        UI_upv_1.ScaleChanged:Connect(fit_1)
        UI_upv_1.LayoutChanged:Connect(fit_1)
        tbl_upv_4.stage = v6
        tbl_upv_4.glow = UI_upv_1.Image(Assets_upv_1.Icons.Glow, {ImageTransparency = 1, Name = "Glow", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 300), Size = UDim2.fromOffset(1500, 1000), ImageColor3 = u1, Parent = v6})
        tbl_upv_4.rays = UI_upv_1.Image(Assets_upv_1.Fx.Rays, {ImageTransparency = 1, Name = "Rays", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 270), Size = UDim2.fromOffset(1250, 1250), ImageColor3 = u1, Parent = v6})
        tbl_upv_4.raysThin = UI_upv_1.Image(Assets_upv_1.Fx.RaysThin, {ImageTransparency = 1, Name = "RaysThin", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 270), Size = UDim2.fromOffset(1500, 1500), ImageColor3 = Theme_upv_1.Lighten(u1, 0.4), Parent = v6})
        tbl_upv_4.pill = UI_upv_1.new("Frame", {Name = "Pill", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 74), Size = UDim2.fromOffset(232, 46), BackgroundColor3 = Colors_upv_1.Accent, ZIndex = 6, [1] = UI_upv_1.Corner(UDim.new(0.5, 0)), Parent = v6})
        UI_upv_1.new("TextLabel", {ZIndex = 7, Name = "T", Text = "NEW UPDATE", TextSize = 25, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Color3.new(1, 1, 1), Parent = tbl_upv_4.pill})
        tbl_upv_4.pillScale = UI_upv_1.new("UIScale", {Scale = 1, Parent = tbl_upv_4.pill})
        tbl_upv_4.title = UI_upv_1.DisplayText({StrokeThickness = 4, Text = "THE RANKED UPDATE", Name = "Title", ZIndex = 6, TextSize = 116, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 168), Size = UDim2.fromOffset(1500, 128), TextColor3 = Color3.new(1, 1, 1), Parent = v6})
        v7 = UI_upv_1.Gradient(Theme_upv_1.Lighten(u1, 0.45), u2, 90)
        v7.Parent = tbl_upv_4.title
        tbl_upv_4.titleScale = UI_upv_1.new("UIScale", {Scale = 1, Parent = tbl_upv_4.title})
        tbl_upv_4.sub = UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "Eight ranks. New weapons. Prove you're Immortal.", Name = "Sub", ZIndex = 6, TextSize = 36, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 258), Size = UDim2.fromOffset(1300, 44), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = v6})
        tbl_upv_4.subStroke = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.35)
        tbl_upv_4.subStroke.Parent = tbl_upv_4.sub
        local v9 = Ranks_upv_1.Count()
        UI_upv_1.new("Frame", {Name = "RoadBack", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(190, 405), Size = UDim2.fromOffset(1220, 8), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, ZIndex = 4, [1] = UI_upv_1.Corner(UDim.new(0.5, 0)), Parent = v6})
        tbl_upv_4.road = UI_upv_1.new("Frame", {Name = "Road", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(190, 405), Size = UDim2.fromOffset(0, 8), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 5, [1] = UI_upv_1.Corner(UDim.new(0.5, 0)), Parent = v6})
        UI_upv_1.new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, RankArt_upv_1.Color(1)), ColorSequenceKeypoint.new(0.5, RankArt_upv_1.Color(4)), ColorSequenceKeypoint.new(1, u1)}), Parent = tbl_upv_4.road})
        tbl_upv_4.emblems = {}
        for n_1 = 1, v9 do
            local v10 = 190 + ((n_1 - 1) * 1220) / (v9 - 1)
            local v11 = ((n_1 ~= v9) and ((n_1 - 1) * 7 + 100)) or 176
            local v12 = ((n_1 ~= v9) and 405) or 393
            local v13 = UI_upv_1.new("Frame", {ZIndex = 8, Visible = false, Name = "Rank" .. n_1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(v10, v12), Size = UDim2.fromOffset(v11, v11), Parent = v6})
            RankArt_upv_1.Emblem(n_1, v11, {ZIndex = 8, Parent = v13})
            local v14 = UI_upv_1.new("UIScale", {Scale = 1, Parent = v13})
            local v15 = RankArt_upv_1.Color(n_1)
            local v16 = UI_upv_1.new("Frame", {Name = "Ring", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(v10, v12), Size = UDim2.fromOffset(v11, v11), BackgroundTransparency = 1, Visible = false, ZIndex = 7, [1] = UI_upv_1.Corner(UDim.new(0.5, 0)), Parent = v6})
            local v17 = UI_upv_1.Stroke(v15, 4, 0)
            v17.Parent = v16
            local new_1 = UI_upv_1.new
            local tbl_5 = {TextColor3 = 0, TextTransparency = 1, Name = "Name", Parent = 0, ZIndex = 8, TextSize = 0}
            tbl_5.AnchorPoint = Vector2.new(0.5, 0)
            tbl_5.Position = UDim2.fromOffset(v10, 485)
            tbl_5.Size = UDim2.fromOffset(200, 34)
            tbl_5.Text = string.upper(Ranks_upv_1.Get(n_1).name)
            tbl_5.FontFace = Fonts_upv_1.Display
            tbl_5.TextSize = ((n_1 ~= v9) and 24) or 31
            tbl_5.TextColor3 = v15
            tbl_5.Parent = v6
            local v18 = new_1("TextLabel", tbl_5)
            local v19 = UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.3)
            v19.Parent = v18
            tbl_upv_4.emblems[n_1] = {holder = v13, scale = v14, ring = v16, ringStroke = v17, name = v18, nameStroke = v19, size = v11}
        end
        tbl_upv_4.cards = {}
        for key_1, value_1 in tbl_upv_3 do
            local v20 = UI_upv_1.Panel({Visible = false, StrokeTransparency = 0.55, ZIndex = 6, BackgroundTransparency = 0.12, Name = "Card_" .. value_1.key, Position = UDim2.fromOffset(71 + ((key_1 - 1) * 494), 548), Size = UDim2.fromOffset(470, 156), StrokeColor = u1, Parent = v6})
            local v21 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 7, BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 0), Size = UDim2.fromOffset(124, 156), Parent = v20})
            if value_1.key == "trophy" then
                RankArt_upv_1.Trophy(96, {ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v21})
                UI_upv_1.DisplayText({StrokeThickness = 2, Name = "Title", ZIndex = 7, TextSize = 34, Position = UDim2.fromOffset(156, 26), Size = UDim2.fromOffset(294, 38), Text = value_1.title, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, Parent = v20})
                UI_upv_1.new("TextLabel", {ZIndex = 7, TextWrapped = true, Name = "Text", TextSize = 25, Position = UDim2.fromOffset(156, 70), Size = UDim2.fromOffset(294, 70), Text = value_1.text, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v20})
                tbl_upv_4.cards[key_1] = v20
                continue
            end
            if value_1.key ~= "weapons" then
                RankArt_upv_1.Emblem(Ranks_upv_1.Count() - 1, 100, {ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v21})
            else
                local NewWeapons_1 = Assets_upv_1.News.NewWeapons
                UI_upv_1.Image(NewWeapons_1, {ImageTransparency = 0.55, Name = "Shadow", ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 3, 0.5, 5), Size = UDim2.fromOffset(136, 136), ImageColor3 = Color3.new(0, 0, 0), Parent = v21})
                UI_upv_1.Image(NewWeapons_1, {Name = "Art", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(136, 136), Parent = v21})
            end
            UI_upv_1.DisplayText({StrokeThickness = 2, Name = "Title", ZIndex = 7, TextSize = 34, Position = UDim2.fromOffset(156, 26), Size = UDim2.fromOffset(294, 38), Text = value_1.title, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, Parent = v20})
            UI_upv_1.new("TextLabel", {ZIndex = 7, TextWrapped = true, Name = "Text", TextSize = 25, Position = UDim2.fromOffset(156, 70), Size = UDim2.fromOffset(294, 70), Text = value_1.text, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v20})
            tbl_upv_4.cards[key_1] = v20
        end
        tbl_upv_4.rankBtn = UI_upv_1.Button({Visible = false, Radius = 16, Text = "SEE YOUR RANK", Name = "SeeRank", Style = "Primary", TextSize = 30, Size = UDim2.fromOffset(360, 80), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(604, 790), Parent = v6})
        tbl_upv_4.goBtn = UI_upv_1.Button({Visible = false, Radius = 16, Text = "LET'S GO", Name = "Go", Style = "Dark", TextSize = 30, Size = UDim2.fromOffset(360, 80), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(996, 790), Parent = v6})
        tbl_upv_4.rankBtn.Activated:Connect(
            function()
                --[[
                  line: 299
                  upvalues:
                    MenuManager_upv_1 (copy, index: 1)
                ]]
                MenuManager_upv_1.Open("Ranks")
            end
        )
        tbl_upv_4.goBtn.Activated:Connect(close)
    end
    local u9 = nil
    local function setBlur(a7)
        --[[
          name: setBlur
          line: 307
          upvalues:
            u9 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Lighting_upv_1 (copy, index: 3)
            TweenService_upv_1 (copy, index: 4)
        ]]
        if a7 then
            if not (u9) or not (u9.Parent) then
                local v22 = UI_upv_1.new("BlurEffect", {Name = "TR_NewsBlur", Size = 0, Parent = Lighting_upv_1})
                u9 = v22
            end
            local tbl_6 = {Size = 16}
            TweenService_upv_1:Create(u9, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_6):Play()
        elseif u9 then
            local v23 = u9
            u9 = nil
            local tbl_7 = {Size = 0}
            local v24 = TweenService_upv_1:Create(v23, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_7)
            v24:Play()
            v24.Completed:Connect(function() end)
        end
    end
    local function markSeen()
        --[[
          name: markSeen
          line: 322
          upvalues:
            u6 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if not u6 then
            return
        end
        a1.Remotes.Fire("NewsAction", "Seen", u6)
        u6 = nil
    end
    local function showAll()
        --[[
          name: showAll
          line: 330
          upvalues:
            tbl_upv_4 (ref, index: 1)
            u5 (ref, index: 2)
            u4 (ref, index: 3)
        ]]
        tbl_upv_4.dim.BackgroundTransparency = 0.18
        tbl_upv_4.glow.ImageTransparency = 0.72
        tbl_upv_4.rays.ImageTransparency = 0.8
        tbl_upv_4.raysThin.ImageTransparency = 0.88
        tbl_upv_4.pill.Visible = true
        tbl_upv_4.pillScale.Scale = 1
        tbl_upv_4.title.Visible = true
        tbl_upv_4.titleScale.Scale = 1
        tbl_upv_4.sub.TextTransparency = 0
        tbl_upv_4.subStroke.Transparency = 0.35
        local road_1 = tbl_upv_4.road
        road_1.Size = UDim2.fromOffset(1220, 8)
        for _, value_2 in tbl_upv_4.emblems do
            value_2.holder.Visible = true
            value_2.scale.Scale = 1
            value_2.ring.Visible = false
            value_2.name.TextTransparency = 0
            value_2.nameStroke.Transparency = 0.3
        end
        for _, value_3 in tbl_upv_4.cards do
            value_3.Visible = true
            value_3.Position = UDim2.fromOffset(value_3.Position.X.Offset, 548)
        end
        tbl_upv_4.rankBtn.Instance.Visible = true
        tbl_upv_4.goBtn.Instance.Visible = true
        u5 = nil
        u4 = false
    end
    local function play()
        --[[
          name: play
          line: 359
          upvalues:
            u3 (ref,  index: 1)
            u4 (ref,  index: 2)
            tbl_upv_4 (ref,  index: 3)
            u5 (ref,  index: 4)
            showAll (copy, index: 5)
            TweenService_upv_1 (copy, index: 6)
            a1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            tbl_upv_2 (copy, index: 9)
        ]]
        u3 = u3 + 1
        local u10 = u3
        u4 = true
        tbl_upv_4.dim.BackgroundTransparency = 1
        for _, value_4 in {tbl_upv_4.glow, tbl_upv_4.rays, tbl_upv_4.raysThin} do
            value_4.ImageTransparency = 1
        end
        tbl_upv_4.pill.Visible = false
        tbl_upv_4.title.Visible = false
        tbl_upv_4.sub.TextTransparency = 1
        tbl_upv_4.subStroke.Transparency = 1
        local road_2 = tbl_upv_4.road
        road_2.Size = UDim2.fromOffset(0, 8)
        for _, value_5 in tbl_upv_4.emblems do
            value_5.holder.Visible = false
            value_5.ring.Visible = false
            value_5.name.TextTransparency = 1
            value_5.nameStroke.Transparency = 1
        end
        for _, value_6 in tbl_upv_4.cards do
            value_6.Visible = false
        end
        tbl_upv_4.rankBtn.Instance.Visible = false
        tbl_upv_4.goBtn.Instance.Visible = false
        u5 = function()
            --[[
              line: 384
              upvalues:
                u3 (ref,  index: 1)
                showAll (copy, index: 2)
            ]]
            u3 = u3 + 1
            showAll()
        end
        local function at_1(a8, a9)
            --[[
              name: at
              line: 388
            ]]
            task.delay(a8, function() end)
        end
        local tbl_8 = {BackgroundTransparency = 0.18}
        TweenService_upv_1:Create(tbl_upv_4.dim, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_8):Play()
        tbl_8 = {ImageTransparency = 0.72}
        TweenService_upv_1:Create(tbl_upv_4.glow, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_8):Play()
        tbl_8 = {ImageTransparency = 0.8}
        TweenService_upv_1:Create(tbl_upv_4.rays, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_8):Play()
        tbl_8 = {ImageTransparency = 0.88}
        TweenService_upv_1:Create(tbl_upv_4.raysThin, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_8):Play()
        task.delay(0.15, function() end)
        task.delay(0.3, function() end)
        task.delay(0.6, function() end)
        local u11 = #tbl_upv_4.emblems
        task.delay(0.75, function() end)
        for key_upv_2, value_upv_7 in tbl_upv_4.emblems do
            local _ = function()
                --[[
                  line: 423
                  upvalues:
                    value_upv_7 (copy, index: 1)
                    key_upv_2 (copy, index: 2)
                    u11 (copy, index: 3)
                    TweenService_upv_1 (copy, index: 4)
                    a1 (copy, index: 5)
                    UI_upv_1 (copy, index: 6)
                    tbl_upv_4 (ref,  index: 7)
                    u10 (copy, index: 8)
                    u3 (ref,  index: 9)
                    tbl_upv_2 (copy, index: 10)
                ]]
                value_upv_7.holder.Visible = true
                value_upv_7.scale.Scale = ((key_upv_2 ~= u11) and 1.7) or 2.4
                local scale_1 = value_upv_7.scale
                local v25 = ((key_upv_2 ~= u11) and 0.34) or 0.5
                local tbl_9 = {Scale = 1}
                TweenService_upv_1:Create(scale_1, TweenInfo.new(v25, Enum.EasingStyle.Back or (Enum.EasingStyle.Quad), Enum.EasingDirection.Out), tbl_9):Play()
                local tbl_10 = {TextTransparency = 0}
                TweenService_upv_1:Create(value_upv_7.name, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_10):Play()
                local tbl_11 = {Transparency = 0.3}
                TweenService_upv_1:Create(value_upv_7.nameStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_11):Play()
                value_upv_7.ring.Visible = true
                value_upv_7.ring.Size = UDim2.fromOffset(value_upv_7.size * 0.8, value_upv_7.size * 0.8)
                value_upv_7.ringStroke.Transparency = 0
                local tbl_12 = {}
                tbl_12.Size = UDim2.fromOffset(value_upv_7.size * 1.9, value_upv_7.size * 1.9)
                TweenService_upv_1:Create(value_upv_7.ring, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_12):Play()
                local tbl_13 = {Transparency = 1}
                TweenService_upv_1:Create(value_upv_7.ringStroke, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_13):Play()
                if key_upv_2 ~= u11 then
                    a1.Sounds.Play("Rank_Pop", {pitch = 0.8 * (2 ^ ((tbl_upv_2[key_upv_2] or 12) / 12))})
                else
                    a1.Sounds.Play("Fanfare")
                    UI_upv_1.Shake(tbl_upv_4.stage, 10, 0.35)
                    local tbl_14 = {ImageTransparency = 0.5}
                    TweenService_upv_1:Create(tbl_upv_4.glow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_14):Play()
                    task.delay(
                        0.3,
                        function()
                            --[[
                              line: 439
                              upvalues:
                                u10 (copy, index: 1)
                                u3 (ref,  index: 2)
                                tbl_upv_4 (ref,  index: 3)
                                TweenService_upv_1 (copy, index: 4)
                            ]]
                            if u10 == u3 then
                                local tbl_15 = {ImageTransparency = 0.72}
                                TweenService_upv_1:Create(tbl_upv_4.glow, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_15):Play()
                            end
                        end
                    )
                end
            end
            task.delay(0.75 + ((key_upv_2 - 1) * 0.26), function() end)
        end
        local v26 = ((u11 - 1) * 0.26) + 0.75 + 0.45
        for key_3, _ in tbl_upv_4.cards do
            task.delay(v26 + ((key_3 - 1) * 0.12), function() end)
        end
        local u12 = function()
            --[[
              line: 461
              upvalues:
                tbl_upv_4 (ref,  index: 1)
                UI_upv_1 (copy, index: 2)
                u5 (ref,  index: 3)
                u4 (ref,  index: 4)
            ]]
            tbl_upv_4.rankBtn.Instance.Visible = true
            tbl_upv_4.goBtn.Instance.Visible = true
            UI_upv_1.Pop(tbl_upv_4.rankBtn.Instance, 0.7)
            UI_upv_1.Pop(tbl_upv_4.goBtn.Instance, 0.7)
            u5 = nil
            u4 = false
        end
        task.delay(
            v26 + 0.55,
            function()
                --[[
                  line: 389
                  upvalues:
                    u10 (copy, index: 1)
                    u3 (ref,  index: 2)
                    u12 (copy, index: 3)
                ]]
                if u10 ~= u3 then
                    return
                end
                u12()
            end
        )
    end
    local tbl_16 = {}
    function tbl_16.open()
        --[[
          name: open
          line: 472
          upvalues:
            build (copy, index: 1)
            u6 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            News_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            UI_upv_1 (copy, index: 7)
            Lighting_upv_1 (copy, index: 8)
            TweenService_upv_1 (copy, index: 9)
            tbl_upv_4 (ref,  index: 10)
            u7 (ref,  index: 11)
            RunService_upv_1 (copy, index: 12)
            play (copy, index: 13)
        ]]
        build()
        local v27 = LocalPlayer_upv_1:GetAttribute("News") or (News_upv_1.CURRENT)
        u6 = v27
        a1.SetHudHidden("News", true)
        if not (u6) or not (u6.Parent) then
            local v28 = UI_upv_1.new("BlurEffect", {Name = "TR_NewsBlur", Size = 0, Parent = Lighting_upv_1})
            u6 = v28
        end
        local tbl_17 = {Size = 16}
        TweenService_upv_1:Create(u6, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_17):Play()
        if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
            pcall(a1.TopbarSettings.SetHidden, "News", true)
        end
        tbl_upv_4.root.Visible = true
        if u7 then
            u7:Disconnect()
        end
        local v29 = RunService_upv_1.RenderStepped:Connect(
            function(a10)
                --[[
                  line: 485
                  upvalues:
                    tbl_upv_4 (ref, index: 1)
                ]]
                tbl_upv_4.rays.Rotation = (tbl_upv_4.rays.Rotation + (a10 * 6)) % 360
                tbl_upv_4.raysThin.Rotation = (tbl_upv_4.raysThin.Rotation - (a10 * 3.5)) % 360
            end
        )
        u7 = v29
        play()
    end
    function tbl_16.close(a11)
        --[[
          name: close
          line: 491
          upvalues:
            u3 (ref,  index: 1)
            u5 (ref,  index: 2)
            u4 (ref,  index: 3)
            u7 (ref,  index: 4)
            a1 (copy, index: 5)
            u9 (ref,  index: 6)
            TweenService_upv_1 (copy, index: 7)
            u6 (ref,  index: 8)
            tbl_upv_4 (ref,  index: 9)
        ]]
        u3 = u3 + 1
        u5 = nil
        u4 = false
        if u7 then
            u7:Disconnect()
            u7 = nil
        end
        a1.SetHudHidden("News", false)
        if u9 then
            local u13 = u9
            u9 = nil
            local tbl_18 = {Size = 0}
            local v30 = TweenService_upv_1:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_18)
            v30:Play()
            v30.Completed:Connect(
                function()
                    --[[
                      line: 316
                      upvalues:
                        u13 (copy, index: 1)
                    ]]
                    u13:Destroy()
                end
            )
        end
        if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
            pcall(a1.TopbarSettings.SetHidden, "News", false)
        end
        if u6 then
            a1.Remotes.Fire("NewsAction", "Seen", u6)
            u6 = nil
        end
        if not tbl_upv_4 then
            return
        end
        tbl_upv_4.root.Visible = false
    end
    function tbl_16.select()
        --[[
          name: select
          line: 509
          upvalues:
            tbl_upv_4 (ref, index: 1)
        ]]
        if tbl_upv_4 then
            return tbl_upv_4.rankBtn.Instance
        end
        return nil
    end
    function tbl_16.back()
        --[[
          name: back
          line: 513
          upvalues:
            u4 (ref, index: 1)
        ]]
        return u4
    end
    MenuManager_upv_1.Register("News", tbl_16)
    local u14 = false
    local function maybeShow()
        --[[
          name: maybeShow
          line: 534
          upvalues:
            u14 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            News_upv_1 (copy, index: 3)
        ]]
        if (u14) or LocalPlayer_upv_1:GetAttribute("News") ~= News_upv_1.CURRENT then
            return
        end
        u14 = true
        task.spawn(function() end)
    end
    LocalPlayer_upv_1:GetAttributeChangedSignal("News"):Connect(maybeShow)
    local function lobbyQuiet()
        --[[
          name: lobbyQuiet
          line: 520
          upvalues:
            State_upv_1 (copy, index: 1)
            MenuManager_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
        ]]
        local v31 = not State_upv_1.InMatch() and (not MenuManager_upv_1.IsOpen() and (not a1.IsHudHiddenFor("Reveal") and (not a1.IsHudHiddenFor("RankUp") and (not a1.IsHudHiddenFor("MatchEnd") and (not a1.IsHudHiddenFor("Celebrate") and (not a1.IsHudHiddenFor("Intro") and ((LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true) and ((LocalPlayer_upv_1:GetAttribute("Teleporting") ~= true) and ((LocalPlayer_upv_1:GetAttribute("Queued") ~= true) and (LocalPlayer_upv_1.Character ~= nil))))))))))
        return v31
    end
    if not (u14) and LocalPlayer_upv_1:GetAttribute("News") == News_upv_1.CURRENT then
        u14 = true
        task.spawn(
            function()
                --[[
                  line: 539
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                    News_upv_1 (copy, index: 2)
                    lobbyQuiet (copy, index: 3)
                    MenuManager_upv_1 (copy, index: 4)
                    u14 (ref,  index: 5)
                ]]
                local v32 = nil
                local v33 = os.clock()
                while LocalPlayer_upv_1:GetAttribute("News") == News_upv_1.CURRENT and (os.clock() - v33 < 180) do
                    if not (lobbyQuiet()) then
                        v32 = nil
                        task.wait(0.25)
                        continue
                    end
                    v32 = v32 or os.clock()
                    if os.clock() - v32 >= 1.5 then
                        MenuManager_upv_1.Open("News")
                        break
                    else
                        task.wait(0.25)
                    end
                end
                u14 = false
            end
        )
    end
    a1.ShowNews = function()
        --[[
          line: 560
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Open("News")
    end
    a1.Debug.news = function(a12)
        --[[
          line: 563
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
            u5 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            u14 (ref,  index: 4)
            News_upv_1 (copy, index: 5)
            u4 (ref,  index: 6)
        ]]
        if a12 == "open" then
            MenuManager_upv_1.Open("News")
        elseif a12 == "skip" and (u5) then
            u5()
        elseif a12 == "close" then
            MenuManager_upv_1.Close("News")
        end
        local tbl_19 = {}
        tbl_19.attr = LocalPlayer_upv_1:GetAttribute("News") or false
        tbl_19.open = MenuManager_upv_1.IsOpen("News")
        tbl_19.waiting = u14
        tbl_19.item = News_upv_1.CURRENT
        tbl_19.playing = u4
        return tbl_19
    end
end
return tbl_1