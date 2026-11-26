local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local shared = replicatedStorage:WaitForChild("Shared")
local News = require(shared:WaitForChild("News"))
local Ranks = require(shared:WaitForChild("Ranks"))
local RankArt = require(script.Parent.Parent:WaitForChild("RankArt"))
local v10 = {}
local color3 = Color3.fromRGB(255, 206, 92)
local color32 = Color3.fromRGB(214, 140, 34)
local v13 = {0, 2, 4, 5, 7, 9, 11}
local v14 = {{key = "trophy", title = "WIN TO CLIMB", text = "Every win earns trophies.\nClimb to Immortal."}, {key = "weapons", title = "NEW WEAPONS", text = "Each rank adds new\nweapons to your drops."}, {key = "reward", title = "RANK REWARDS", text = "Every rank-up opens\na Rank Reward."}}

function v10.Init(a15)
    --[[
      name: Init
      line: 61
      upvalues:
        players (copy, index: 1)
        tweenService (copy, index: 2)
        color3 (copy, index: 3)
        color32 (copy, index: 4)
        Ranks (copy, index: 5)
        RankArt (copy, index: 6)
        v14 (copy, index: 7)
        lighting (copy, index: 8)
        v13 (copy, index: 9)
        News (copy, index: 10)
        runService (copy, index: 11)
    ]]
    local ui = a15.UI
    local theme = a15.Theme
    local state = a15.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local assets = ui.Assets
    local menuManager = a15.MenuManager
    local localPlayer = players.LocalPlayer
    local v24 = nil
    local count = 0
    local playing = false
    local v27 = nil
    local v28 = nil
    local renderSteppedConnection = nil

    local function tw(instance: Instance, a32: number?, propertyTable, a34, a35)
        --[[
          name: tw
          line: 75
          upvalues:
            tweenService (copy, index: 1)
        ]]
        local newTweenInfo = TweenInfo.new
        local v37 = a34 or Enum.EasingStyle.Quad
        local v38 = a35 or Enum.EasingDirection.Out
        local tween = tweenService:Create(instance, newTweenInfo(a32, v37, v38), propertyTable)
        tween:Play()

        return tween
    end

    local function close()
        --[[
          name: close
          line: 81
          upvalues:
            menuManager (copy, index: 1)
        ]]
        menuManager.Close("News")
    end

    local function build()
        --[[
          name: build
          line: 85
          upvalues:
            v24 (ref,  index: 1)
            ui (copy, index: 2)
            a15 (copy, index: 3)
            colors (copy, index: 4)
            assets (copy, index: 5)
            color3 (copy, index: 6)
            theme (copy, index: 7)
            fonts (copy, index: 8)
            color32 (copy, index: 9)
            Ranks (copy, index: 10)
            RankArt (copy, index: 11)
            v14 (copy, index: 12)
            menuManager (copy, index: 13)
            close (copy, index: 14)
        ]]
        if v24 then
            return
        end

        local sg, parent = ui.Screen("TR_News", 30, a15.PlayerGui, {fullBleed = true})
        v24 = {sg = sg}
        local ui2 = ui.new("Frame", {Name = "Root", Visible = false, Size = UDim2.fromScale(1, 1), Parent = parent})
        v24.root = ui2
        v24.dim = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = ui2})
        v24.catcher = ui.new("TextButton", {Name = "Backdrop", BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 2, Size = UDim2.fromScale(1, 1), Parent = ui2})
        local ui3 = ui.new("Frame", {Name = "Stage", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1600, 900), Parent = ui2})
        local ui4 = ui.new("UIScale", {Scale = 1, Parent = ui3})

        local function fit()
            --[[
              name: fit
              line: 98
              upvalues:
                ui (copy, index: 1)
                ui4 (copy, index: 2)
            ]]
            local v48 = ui.CanvasSize()
            ui4.Scale = math.min(1, v48.X / 1600, v48.Y / 900)
        end

        local v49 = ui.CanvasSize()
        ui4.Scale = math.min(1, v49.X / 1600, v49.Y / 900)
        ui.ScaleChanged:Connect(fit)
        ui.LayoutChanged:Connect(fit)
        v24.stage = ui3
        v24.glow = ui.Image(assets.Icons.Glow, {Name = "Glow", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 300), Size = UDim2.fromOffset(1500, 1000), ImageColor3 = color3, Parent = ui3})
        v24.rays = ui.Image(assets.Fx.Rays, {Name = "Rays", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 270), Size = UDim2.fromOffset(1250, 1250), ImageColor3 = color3, Parent = ui3})
        v24.raysThin = ui.Image(assets.Fx.RaysThin, {Name = "RaysThin", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 270), Size = UDim2.fromOffset(1500, 1500), ImageColor3 = theme.Lighten(color3, 0.4), Parent = ui3})
        v24.pill = ui.new("Frame", {Name = "Pill", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 74), Size = UDim2.fromOffset(232, 46), BackgroundColor3 = colors.Accent, ZIndex = 6, (ui.Corner(UDim.new(0.5, 0))), Parent = ui3})
        ui.new("TextLabel", {Name = "T", Text = "NEW UPDATE", TextSize = 25, ZIndex = 7, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = Color3.new(1, 1, 1), Parent = v24.pill})
        v24.pillScale = ui.new("UIScale", {Scale = 1, Parent = v24.pill})
        v24.title = ui.DisplayText({Name = "Title", Text = "THE RANKED UPDATE", TextSize = 116, StrokeThickness = 4, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 168), Size = UDim2.fromOffset(1500, 128), TextColor3 = Color3.new(1, 1, 1), Parent = ui3})
        ui.Gradient(theme.Lighten(color3, 0.45), color32, 90).Parent = v24.title
        v24.titleScale = ui.new("UIScale", {Scale = 1, Parent = v24.title})
        v24.sub = ui.new("TextLabel", {Name = "Sub", Text = "Eight ranks. New weapons. Prove you're Immortal.", TextSize = 36, TextTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(800, 258), Size = UDim2.fromOffset(1300, 44), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = ui3})
        v24.subStroke = ui.TextStroke(colors.Void, 2, 0.35)
        v24.subStroke.Parent = v24.sub
        local endIndex = Ranks.Count()
        ui.new("Frame", {Name = "RoadBack", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(190, 405), Size = UDim2.fromOffset(1220, 8), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.45, ZIndex = 4, (ui.Corner(UDim.new(0.5, 0))), Parent = ui3})
        v24.road = ui.new("Frame", {Name = "Road", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(190, 405), Size = UDim2.fromOffset(0, 8), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 5, (ui.Corner(UDim.new(0.5, 0))), Parent = ui3})
        ui.new("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, RankArt.Color(1)), ColorSequenceKeypoint.new(0.5, RankArt.Color(4)), ColorSequenceKeypoint.new(1, color3)}), Parent = v24.road})
        v24.emblems = {}

        for emblemKey = 1, endIndex do
            local textSize
            local v53 = 190 + (emblemKey - 1) * 1220 / (endIndex - 1)
            local size = emblemKey == endIndex and 176 or (emblemKey - 1) * 7 + 100
            local v55 = emblemKey ~= endIndex and 405 or 393
            local ui5 = ui.new("Frame", {Visible = false, ZIndex = 8, Name = "Rank" .. emblemKey, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(v53, v55), Size = UDim2.fromOffset(size, size), Parent = ui3})
            RankArt.Emblem(emblemKey, size, {ZIndex = 8, Parent = ui5})
            local scale = ui.new("UIScale", {Scale = 1, Parent = ui5})
            local textColor3 = RankArt.Color(emblemKey)
            local ui6 = ui.new("Frame", {Name = "Ring", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(v53, v55), Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, Visible = false, ZIndex = 7, (ui.Corner(UDim.new(0.5, 0))), Parent = ui3})
            local ringStroke = ui.Stroke(textColor3, 4, 0)
            ringStroke.Parent = ui6
            local newUi = ui.new
            local v62 = {Name = "Name", TextTransparency = 1, ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromOffset(v53, 485), Size = UDim2.fromOffset(200, 34), Text = string.upper(Ranks.Get(emblemKey).name), FontFace = fonts.Display}

            if emblemKey == endIndex then
                textSize = 31
            else
                textSize = 24
            end

            v62.TextSize = textSize
            v62.TextColor3 = textColor3
            v62.Parent = ui3
            local ui7 = newUi("TextLabel", v62)
            local nameStroke = ui.TextStroke(colors.Void, 2, 0.3)
            nameStroke.Parent = ui7
            v24.emblems[emblemKey] = {holder = ui5, scale = scale, ring = ui6, ringStroke = ringStroke, name = ui7, nameStroke = nameStroke, size = size}
        end

        v24.cards = {}

        for cardKey, v66 in v14 do
            local parent2 = ui.Panel({BackgroundTransparency = 0.12, StrokeTransparency = 0.55, Visible = false, ZIndex = 6, Name = "Card_" .. v66.key, Position = UDim2.fromOffset(71 + ((cardKey - 1) * 494), 548), Size = UDim2.fromOffset(470, 156), StrokeColor = color3, Parent = ui3})
            local parent3 = ui.new("Frame", {Name = "Icon", BackgroundTransparency = 1, ZIndex = 7, Position = UDim2.fromOffset(16, 0), Size = UDim2.fromOffset(124, 156), Parent = parent2})

            if v66.key == "trophy" then
                RankArt.Trophy(96, {ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent3})
            elseif v66.key ~= "weapons" then
                RankArt.Emblem(Ranks.Count() - 1, 100, {ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent3})
            else
                local newWeapons = assets.News.NewWeapons
                ui.Image(newWeapons, {Name = "Shadow", ImageTransparency = 0.55, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 3, 0.5, 5), Size = UDim2.fromOffset(136, 136), ImageColor3 = Color3.new(0, 0, 0), Parent = parent3})
                ui.Image(newWeapons, {Name = "Art", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(136, 136), Parent = parent3})
            end

            ui.DisplayText({Name = "Title", TextSize = 34, StrokeThickness = 2, ZIndex = 7, Position = UDim2.fromOffset(156, 26), Size = UDim2.fromOffset(294, 38), Text = v66.title, TextColor3 = color3, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent2})
            ui.new("TextLabel", {Name = "Text", TextSize = 25, TextWrapped = true, ZIndex = 7, Position = UDim2.fromOffset(156, 70), Size = UDim2.fromOffset(294, 70), Text = v66.text, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent2})
            v24.cards[cardKey] = parent2
        end

        v24.rankBtn = ui.Button({Name = "SeeRank", Text = "SEE YOUR RANK", TextSize = 30, Style = "Primary", Radius = 16, Visible = false, Size = UDim2.fromOffset(360, 80), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(604, 790), Parent = ui3})
        v24.goBtn = ui.Button({Name = "Go", Text = "LET'S GO", TextSize = 30, Style = "Dark", Radius = 16, Visible = false, Size = UDim2.fromOffset(360, 80), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(996, 790), Parent = ui3})
        v24.rankBtn.Activated:Connect(
            function()
                --[[
                  line: 299
                  upvalues:
                    menuManager (copy, index: 1)
                ]]
                menuManager.Open("Ranks")
            end
        )
        v24.goBtn.Activated:Connect(close)
    end

    local ui2 = nil

    local function setBlur(blur)
        --[[
          name: setBlur
          line: 307
          upvalues:
            ui2 (ref,  index: 1)
            ui (copy, index: 2)
            lighting (copy, index: 3)
            tweenService (copy, index: 4)
        ]]
        if blur then
            if not ui2 or not ui2.Parent then
                ui2 = ui.new("BlurEffect", {Name = "TR_NewsBlur", Size = 0, Parent = lighting})
            end

            local propertyTable = {Size = 16}
            tweenService:Create(ui2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()

            return
        end

        if ui2 then
            local instance = ui2
            ui2 = nil
            local propertyTable = {Size = 0}
            local tween = tweenService:Create(instance, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable)
            tween:Play()
            tween.Completed:Connect(
                function()
                    --[[
                      line: 316
                      upvalues:
                        instance (copy, index: 1)
                    ]]
                    instance:Destroy()
                end
            )
        end
    end

    local function markSeen()
        --[[
          name: markSeen
          line: 322
          upvalues:
            v28 (ref,  index: 1)
            a15 (copy, index: 2)
        ]]
        if v28 then
            a15.Remotes.Fire("NewsAction", "Seen", v28)
            v28 = nil
        end
    end

    local function showAll()
        --[[
          name: showAll
          line: 330
          upvalues:
            v24 (ref, index: 1)
            v27 (ref, index: 2)
            playing (ref, index: 3)
        ]]
        v24.dim.BackgroundTransparency = 0.18
        v24.glow.ImageTransparency = 0.72
        v24.rays.ImageTransparency = 0.8
        v24.raysThin.ImageTransparency = 0.88
        v24.pill.Visible = true
        v24.pillScale.Scale = 1
        v24.title.Visible = true
        v24.titleScale.Scale = 1
        v24.sub.TextTransparency = 0
        v24.subStroke.Transparency = 0.35
        v24.road.Size = UDim2.fromOffset(1220, 8)

        for _, emblem in v24.emblems do
            emblem.holder.Visible = true
            emblem.scale.Scale = 1
            emblem.ring.Visible = false
            emblem.name.TextTransparency = 0
            emblem.nameStroke.Transparency = 0.3
        end

        for _, card in v24.cards do
            card.Visible = true
            card.Position = UDim2.fromOffset(card.Position.X.Offset, 548)
        end

        v24.rankBtn.Instance.Visible = true
        v24.goBtn.Instance.Visible = true
        v27 = nil
        playing = false
    end

    local function play()
        --[[
          name: play
          line: 359
          upvalues:
            count (ref,  index: 1)
            playing (ref,  index: 2)
            v24 (ref,  index: 3)
            v27 (ref,  index: 4)
            showAll (copy, index: 5)
            tweenService (copy, index: 6)
            a15 (copy, index: 7)
            ui (copy, index: 8)
            v13 (copy, index: 9)
        ]]
        count += 1
        local v84 = count
        playing = true
        v24.dim.BackgroundTransparency = 1

        for _, v86 in {v24.glow, v24.rays, v24.raysThin} do
            v86.ImageTransparency = 1
        end

        v24.pill.Visible = false
        v24.title.Visible = false
        v24.sub.TextTransparency = 1
        v24.subStroke.Transparency = 1
        v24.road.Size = UDim2.fromOffset(0, 8)

        for _, emblem in v24.emblems do
            emblem.holder.Visible = false
            emblem.ring.Visible = false
            emblem.name.TextTransparency = 1
            emblem.nameStroke.Transparency = 1
        end

        for _, card in v24.cards do
            card.Visible = false
        end

        v24.rankBtn.Instance.Visible = false
        v24.goBtn.Instance.Visible = false

        v27 = function()
            --[[
              line: 384
              upvalues:
                count (ref,  index: 1)
                showAll (copy, index: 2)
            ]]
            count += 1
            showAll()
        end

        local function at(a92: number, callback)
            --[[
              name: at
              line: 388
              upvalues:
                v84 (copy, index: 1)
                count (ref,  index: 2)
            ]]
            task.delay(
                a92,
                function()
                    --[[
                      line: 389
                      upvalues:
                        v84 (copy, index: 1)
                        count (ref,  index: 2)
                        callback (copy, index: 3)
                    ]]
                    if v84 == count then
                        callback()
                    end
                end
            )
        end

        local propertyTable = {BackgroundTransparency = 0.18}
        tweenService:Create(v24.dim, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
        local propertyTable2 = {ImageTransparency = 0.72}
        tweenService:Create(v24.glow, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable2):Play()
        local propertyTable3 = {ImageTransparency = 0.8}
        tweenService:Create(v24.rays, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable3):Play()
        local propertyTable4 = {ImageTransparency = 0.88}
        tweenService:Create(v24.raysThin, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable4):Play()

        local v98 = function()
            --[[
              line: 399
              upvalues:
                v24 (ref,  index: 1)
                tweenService (copy, index: 2)
                a15 (copy, index: 3)
            ]]
            v24.pill.Visible = true
            v24.pillScale.Scale = 0.4
            local pillScale = v24.pillScale
            local propertyTable = {Scale = 1}
            local back = Enum.EasingStyle.Back
            local newTweenInfo = TweenInfo.new
            local easingStyle = back or Enum.EasingStyle.Quad
            tweenService:Create(pillScale, newTweenInfo(0.35, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
            a15.Sounds.Play("Whoosh")
        end

        task.delay(
            0.15,
            function()
                --[[
                  line: 389
                  upvalues:
                    v84 (copy, index: 1)
                    count (ref,  index: 2)
                    v98 (copy, index: 3)
                ]]
                if v84 == count then
                    v98()
                end
            end
        )

        local v104 = function()
            --[[
              line: 405
              upvalues:
                v24 (ref,  index: 1)
                tweenService (copy, index: 2)
                a15 (copy, index: 3)
                ui (copy, index: 4)
            ]]
            v24.title.Visible = true
            v24.titleScale.Scale = 1.9
            local titleScale = v24.titleScale
            local propertyTable = {Scale = 1}
            local back = Enum.EasingStyle.Back
            local newTweenInfo = TweenInfo.new
            local easingStyle = back or Enum.EasingStyle.Quad
            tweenService:Create(titleScale, newTweenInfo(0.32, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
            a15.Sounds.Play("LevelUp")
            ui.Shake(v24.stage, 6, 0.25)
        end

        task.delay(
            0.3,
            function()
                --[[
                  line: 389
                  upvalues:
                    v84 (copy, index: 1)
                    count (ref,  index: 2)
                    v104 (copy, index: 3)
                ]]
                if v84 == count then
                    v104()
                end
            end
        )

        local v110 = function()
            --[[
              line: 412
              upvalues:
                v24 (ref,  index: 1)
                tweenService (copy, index: 2)
            ]]
            local propertyTable = {TextTransparency = 0}
            tweenService:Create(v24.sub, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
            local propertyTable2 = {Transparency = 0.35}
            tweenService:Create(v24.subStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable2):Play()
        end

        task.delay(
            0.6,
            function()
                --[[
                  line: 389
                  upvalues:
                    v84 (copy, index: 1)
                    count (ref,  index: 2)
                    v110 (copy, index: 3)
                ]]
                if v84 == count then
                    v110()
                end
            end
        )

        local emblemCount = #v24.emblems

        local v114 = function()
            --[[
              line: 419
              upvalues:
                v24 (ref,  index: 1)
                emblemCount (copy, index: 2)
                tweenService (copy, index: 3)
            ]]
            local road = v24.road
            local v116 = (emblemCount - 1) * 0.26 + 0.1
            local propertyTable = {Size = UDim2.fromOffset(1220, 8)}
            local linear = Enum.EasingStyle.Linear
            local newTweenInfo = TweenInfo.new
            local easingStyle = linear or Enum.EasingStyle.Quad
            tweenService:Create(road, newTweenInfo(v116, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
        end

        task.delay(
            0.75,
            function()
                --[[
                  line: 389
                  upvalues:
                    v84 (copy, index: 1)
                    count (ref,  index: 2)
                    v114 (copy, index: 3)
                ]]
                if v84 == count then
                    v114()
                end
            end
        )

        for v121, emblem in v24.emblems do
            local v123 = 0.75 + (v121 - 1) * 0.26

            local v124 = function()
                --[[
                  line: 423
                  upvalues:
                    emblem (copy, index: 1)
                    v121 (copy, index: 2)
                    emblemCount (copy, index: 3)
                    tweenService (copy, index: 4)
                    a15 (copy, index: 5)
                    ui (copy, index: 6)
                    v24 (ref,  index: 7)
                    v84 (copy, index: 8)
                    count (ref,  index: 9)
                    v13 (copy, index: 10)
                ]]
                emblem.holder.Visible = true
                emblem.scale.Scale = v121 ~= emblemCount and 1.7 or 2.4
                local scale = emblem.scale
                local v126 = v121 ~= emblemCount and 0.34 or 0.5
                local propertyTable = {Scale = 1}
                local back = Enum.EasingStyle.Back
                local newTweenInfo = TweenInfo.new
                local easingStyle = back or Enum.EasingStyle.Quad
                tweenService:Create(scale, newTweenInfo(v126, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
                local propertyTable2 = {TextTransparency = 0}
                tweenService:Create(emblem.name, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable2):Play()
                local propertyTable3 = {Transparency = 0.3}
                tweenService:Create(emblem.nameStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable3):Play()
                emblem.ring.Visible = true
                emblem.ring.Size = UDim2.fromOffset(emblem.size * 0.8, emblem.size * 0.8)
                emblem.ringStroke.Transparency = 0
                local ring = emblem.ring
                local propertyTable4 = {Size = UDim2.fromOffset(emblem.size * 1.9, emblem.size * 1.9)}
                tweenService:Create(ring, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable4):Play()
                local propertyTable5 = {Transparency = 1}
                tweenService:Create(emblem.ringStroke, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable5):Play()

                if v121 == emblemCount then
                    a15.Sounds.Play("Fanfare")
                    ui.Shake(v24.stage, 10, 0.35)
                    local propertyTable6 = {ImageTransparency = 0.5}
                    tweenService:Create(v24.glow, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable6):Play()

                    task.delay(
                        0.3,
                        function()
                            --[[
                              line: 439
                              upvalues:
                                v84 (copy, index: 1)
                                count (ref,  index: 2)
                                v24 (ref,  index: 3)
                                tweenService (copy, index: 4)
                            ]]
                            if v84 == count then
                                local propertyTable = {ImageTransparency = 0.72}
                                local tween = tweenService:Create(v24.glow, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable)
                                tween:Play()
                            end
                        end
                    )

                    return
                end

                a15.Sounds.Play("Rank_Pop", {pitch = 0.8 * (2 ^ (function(...) return ... end)((((v13[v121] or 12) / 12))))})
            end

            task.delay(
                v123,
                function()
                    --[[
                      line: 389
                      upvalues:
                        v84 (copy, index: 1)
                        count (ref,  index: 2)
                        v124 (copy, index: 3)
                    ]]
                    if v84 == count then
                        v124()
                    end
                end
            )
        end

        local v139 = ((emblemCount - 1) * 0.26) + 0.75 + 0.45

        for v140, instance in v24.cards do
            local v142 = v139 + (v140 - 1) * 0.12

            local v143 = function()
                --[[
                  line: 453
                  upvalues:
                    instance (copy, index: 1)
                    tweenService (copy, index: 2)
                    a15 (copy, index: 3)
                ]]
                instance.Visible = true
                local offset = instance.Position.X.Offset
                instance.Position = UDim2.fromOffset(offset, 628)
                local propertyTable = {Position = UDim2.fromOffset(offset, 548)}
                local back = Enum.EasingStyle.Back
                local newTweenInfo = TweenInfo.new
                local easingStyle = back or Enum.EasingStyle.Quad
                tweenService:Create(instance, newTweenInfo(0.4, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
                a15.Sounds.Play("Whoosh", {volume = 0.3})
            end

            task.delay(
                v142,
                function()
                    --[[
                      line: 389
                      upvalues:
                        v84 (copy, index: 1)
                        count (ref,  index: 2)
                        v143 (copy, index: 3)
                    ]]
                    if v84 == count then
                        v143()
                    end
                end
            )
        end

        local v149 = v139 + 0.55

        local v150 = function()
            --[[
              line: 461
              upvalues:
                v24 (ref,  index: 1)
                ui (copy, index: 2)
                v27 (ref,  index: 3)
                playing (ref,  index: 4)
            ]]
            v24.rankBtn.Instance.Visible = true
            v24.goBtn.Instance.Visible = true
            ui.Pop(v24.rankBtn.Instance, 0.7)
            ui.Pop(v24.goBtn.Instance, 0.7)
            v27 = nil
            playing = false
        end

        task.delay(
            v149,
            function()
                --[[
                  line: 389
                  upvalues:
                    v84 (copy, index: 1)
                    count (ref,  index: 2)
                    v150 (copy, index: 3)
                ]]
                if v84 == count then
                    v150()
                end
            end
        )
    end

    menuManager.Register(
        "News",
        {
            open = (function()
                --[[
                  name: open
                  line: 472
                  upvalues:
                    build (copy, index: 1)
                    v28 (ref,  index: 2)
                    localPlayer (copy, index: 3)
                    News (copy, index: 4)
                    a15 (copy, index: 5)
                    ui2 (ref,  index: 6)
                    ui (copy, index: 7)
                    lighting (copy, index: 8)
                    tweenService (copy, index: 9)
                    v24 (ref,  index: 10)
                    renderSteppedConnection (ref,  index: 11)
                    runService (copy, index: 12)
                    play (copy, index: 13)
                ]]
                build()
                v28 = localPlayer:GetAttribute("News") or News.CURRENT
                a15.SetHudHidden("News", true)

                if not ui2 or not ui2.Parent then
                    ui2 = ui.new("BlurEffect", {Name = "TR_NewsBlur", Size = 0, Parent = lighting})
                end

                local propertyTable = {Size = 16}
                tweenService:Create(ui2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()

                if a15.TopbarSettings and type(a15.TopbarSettings.SetHidden) == "function" then
                    pcall(a15.TopbarSettings.SetHidden, "News", true)
                end

                v24.root.Visible = true

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                end

                renderSteppedConnection = runService.RenderStepped:Connect(
                    function(deltaTime: number)
                        --[[
                          line: 485
                          upvalues:
                            v24 (ref, index: 1)
                        ]]
                        v24.rays.Rotation = (v24.rays.Rotation + (deltaTime * 6)) % 360
                        v24.raysThin.Rotation = (v24.raysThin.Rotation - (deltaTime * 3.5)) % 360
                    end
                )

                play()
            end),
            close = (function(a153)
                --[[
                  name: close
                  line: 491
                  upvalues:
                    count (ref,  index: 1)
                    v27 (ref,  index: 2)
                    playing (ref,  index: 3)
                    renderSteppedConnection (ref,  index: 4)
                    a15 (copy, index: 5)
                    ui2 (ref,  index: 6)
                    tweenService (copy, index: 7)
                    v28 (ref,  index: 8)
                    v24 (ref,  index: 9)
                ]]
                count += 1
                v27 = nil
                playing = false

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                a15.SetHudHidden("News", false)

                if ui2 then
                    local instance = ui2
                    ui2 = nil
                    local propertyTable = {Size = 0}
                    local tween = tweenService:Create(instance, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable)
                    tween:Play()
                    tween.Completed:Connect(
                        function()
                            --[[
                              line: 316
                              upvalues:
                                instance (copy, index: 1)
                            ]]
                            instance:Destroy()
                        end
                    )
                end

                if a15.TopbarSettings and type(a15.TopbarSettings.SetHidden) == "function" then
                    pcall(a15.TopbarSettings.SetHidden, "News", false)
                end

                if v28 then
                    a15.Remotes.Fire("NewsAction", "Seen", v28)
                    v28 = nil
                end

                if v24 then
                    v24.root.Visible = false
                end
            end),
            select = (function()
                --[[
                  name: select
                  line: 509
                  upvalues:
                    v24 (ref, index: 1)
                ]]
                if v24 then
                    return v24.rankBtn.Instance
                end

                return nil
            end),
            back = (function()
                --[[
                  name: back
                  line: 513
                  upvalues:
                    playing (ref, index: 1)
                ]]
                return playing
            end)
        }
    )

    local function lobbyQuiet()
        --[[
          name: lobbyQuiet
          line: 520
          upvalues:
            state (copy, index: 1)
            menuManager (copy, index: 2)
            a15 (copy, index: 3)
            localPlayer (copy, index: 4)
        ]]
        local v158 = not state.InMatch()
            and not menuManager.IsOpen()
            and not a15.IsHudHiddenFor("Reveal")
            and not a15.IsHudHiddenFor("RankUp")
            and not a15.IsHudHiddenFor("MatchEnd")
            and not a15.IsHudHiddenFor("Celebrate")
            and not a15.IsHudHiddenFor("Intro")
            and localPlayer:GetAttribute("WelcomeCard") ~= true
            and localPlayer:GetAttribute("Teleporting") ~= true
            and localPlayer:GetAttribute("Queued") ~= true
            and localPlayer.Character ~= nil
        return v158
    end

    local waiting = false

    local function maybeShow()
        --[[
          name: maybeShow
          line: 534
          upvalues:
            waiting (ref,  index: 1)
            localPlayer (copy, index: 2)
            News (copy, index: 3)
            lobbyQuiet (copy, index: 4)
            menuManager (copy, index: 5)
        ]]
        if not waiting then
            local news = localPlayer:GetAttribute("News")

            if news == News.CURRENT then
                waiting = true

                task.spawn(
                    function()
                        --[[
                          line: 539
                          upvalues:
                            localPlayer (copy, index: 1)
                            News (copy, index: 2)
                            lobbyQuiet (copy, index: 3)
                            menuManager (copy, index: 4)
                            waiting (ref,  index: 5)
                        ]]
                        local timestamp
                        local timestamp2 = os.clock()

                        while true do
                            local news = localPlayer:GetAttribute("News")

                            if news ~= News.CURRENT then
                                break
                            end

                            local timestamp3

                            if not (os.clock() - timestamp2 < 180) then
                                break
                            end

                            if lobbyQuiet() then
                                timestamp3 = timestamp or os.clock()

                                if 1.5 <= os.clock() - timestamp3 then
                                    menuManager.Open("News")
                                    break
                                end
                            else
                                timestamp3 = nil
                            end

                            task.wait(0.25)
                            timestamp = timestamp3
                        end

                        waiting = false
                    end
                )
            end
        end
    end

    localPlayer:GetAttributeChangedSignal("News"):Connect(maybeShow)

    if not waiting then
        local news = localPlayer:GetAttribute("News")

        if news == News.CURRENT then
            waiting = true

            task.spawn(
                function()
                    --[[
                      line: 539
                      upvalues:
                        localPlayer (copy, index: 1)
                        News (copy, index: 2)
                        lobbyQuiet (copy, index: 3)
                        menuManager (copy, index: 4)
                        waiting (ref,  index: 5)
                    ]]
                    local timestamp
                    local timestamp2 = os.clock()

                    while true do
                        local news = localPlayer:GetAttribute("News")

                        if news ~= News.CURRENT then
                            break
                        end

                        local timestamp3

                        if not (os.clock() - timestamp2 < 180) then
                            break
                        end

                        if lobbyQuiet() then
                            timestamp3 = timestamp or os.clock()

                            if 1.5 <= os.clock() - timestamp3 then
                                menuManager.Open("News")
                                break
                            end
                        else
                            timestamp3 = nil
                        end

                        task.wait(0.25)
                        timestamp = timestamp3
                    end

                    waiting = false
                end
            )
        end
    end

    a15.ShowNews = function()
        --[[
          line: 560
          upvalues:
            menuManager (copy, index: 1)
        ]]
        menuManager.Open("News")
    end

    a15.Debug.news = function(a171)
        --[[
          line: 563
          upvalues:
            menuManager (copy, index: 1)
            v27 (ref,  index: 2)
            localPlayer (copy, index: 3)
            waiting (ref,  index: 4)
            News (copy, index: 5)
            playing (ref,  index: 6)
        ]]
        if a171 == "open" then
            menuManager.Open("News")
        elseif a171 == "skip" and v27 then
            v27()
        elseif a171 == "close" then
            menuManager.Close("News")
        end

        return {attr = localPlayer:GetAttribute("News") or false, open = menuManager.IsOpen("News"), waiting = waiting, item = News.CURRENT, playing = playing}
    end
end

return v10