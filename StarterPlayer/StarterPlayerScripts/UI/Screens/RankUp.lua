local contextActionService = game:GetService("ContextActionService")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local Ranks = require(replicatedStorage.Shared.Ranks)
local RankArt = require(script.Parent.Parent.RankArt)
local Fx = require(script.Parent.Parent.Fx)

return {
    Init = (function(a9)
        --[[
          name: Init
          line: 33
          upvalues:
            players (copy, index: 1)
            tweenService (copy, index: 2)
            Fx (copy, index: 3)
            RankArt (copy, index: 4)
            lighting (copy, index: 5)
            Ranks (copy, index: 6)
            contextActionService (copy, index: 7)
        ]]
        local ui = a9.UI
        local theme = a9.Theme
        local state = a9.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local assets = ui.Assets
        local v17 = nil
        local v18 = nil
        local count = 0

        local function tw(instance: Instance, a22: number?, propertyTable, a24, a25)
            --[[
              name: tw
              line: 43
              upvalues:
                tweenService (copy, index: 1)
            ]]
            local newTweenInfo = TweenInfo.new
            local v27 = a24 or Enum.EasingStyle.Quad
            local v28 = a25 or Enum.EasingDirection.Out
            local tween = tweenService:Create(instance, newTweenInfo(a22, v27, v28), propertyTable)
            tween:Play()

            return tween
        end

        local function build()
            --[[
              name: build
              line: 49
              upvalues:
                v17 (ref,  index: 1)
                ui (copy, index: 2)
                a9 (copy, index: 3)
                colors (copy, index: 4)
                assets (copy, index: 5)
                Fx (copy, index: 6)
                RankArt (copy, index: 7)
                fonts (copy, index: 8)
                theme (copy, index: 9)
            ]]
            if v17 then
                return
            end

            local sg, v32 = ui.Screen("TR_RankUp", 31, a9.PlayerGui, {fullBleed = true})
            v17 = {sg = sg, canvas = v32}
            local ui2 = ui.new("Frame", {Name = "Root", Visible = false, Size = UDim2.fromScale(1, 1), Parent = v32})
            v17.root = ui2
            v17.dim = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = ui2})
            local ui3 = ui.new("Frame", {Name = "Stage", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1600, 900), Parent = ui2})
            local ui4 = ui.new("UIScale", {Scale = 1, Parent = ui3})

            local function fit()
                --[[
                  name: fit
                  line: 62
                  upvalues:
                    ui (copy, index: 1)
                    ui4 (copy, index: 2)
                ]]
                local v37 = ui.CanvasSize()
                ui4.Scale = math.min(1, v37.X / 1600, v37.Y / 900)
            end

            local v38 = ui.CanvasSize()
            ui4.Scale = math.min(1, v38.X / 1600, v38.Y / 900)
            ui.ScaleChanged:Connect(fit)
            ui.LayoutChanged:Connect(fit)
            v17.stage = ui3
            v17.glow = ui.Image(assets.Icons.Glow, {Name = "Glow", ImageTransparency = 1, ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(1100, 1100), Parent = v17.stage})
            v17.rays = ui.Image(assets.Fx.Rays, {Name = "Rays", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(820, 820), Parent = v17.stage})
            v17.raysThin = ui.Image(assets.Fx.RaysThin, {Name = "RaysThin", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(980, 980), Parent = v17.stage})
            v17.ring = ui.Image(assets.Fx.Ring, {Name = "Ring", ImageTransparency = 1, ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(200, 200), Parent = v17.stage})
            v17.flash = ui.new("Frame", {Name = "Flash", BackgroundTransparency = 1, ZIndex = 9, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.White, Parent = ui2})
            v17.fxLayer = ui.new("Frame", {Name = "FxLayer", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(0, 0), Parent = v17.stage})
            v17.pool = Fx.Pool(v17.fxLayer, 90, 8)
            v17.emblemHolder = ui.new("Frame", {Name = "EmblemHolder", ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.385), Size = UDim2.fromOffset(300, 300), Parent = v17.stage})
            v17.emblemScale = ui.new("UIScale", {Scale = 1, Parent = v17.emblemHolder})
            v17.emblem = RankArt.Emblem(1, 300, {ZIndex = 6, Parent = v17.emblemHolder})
            v17.emblem.Size = UDim2.fromScale(1, 1)
            v17.kicker = ui.new("TextLabel", {Name = "Kicker", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.11), Size = UDim2.fromOffset(800, 50), Text = "RANK UP", FontFace = fonts.Display, TextSize = 46, TextColor3 = colors.Text, TextTransparency = 1, ZIndex = 7, (ui.TextStroke(colors.Void, 3, 0.3)), Parent = v17.stage})
            v17.name = ui.new("TextLabel", {Name = "RankName", Text = "", TextSize = 104, TextTransparency = 1, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.615), Size = UDim2.fromOffset(1000, 110), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = v17.stage})
            v17.nameGrad = ui.new("UIGradient", {Rotation = 90, Parent = v17.name})
            v17.nameStroke = ui.TextStroke(colors.Void, 4, 0.2)
            v17.nameStroke.Parent = v17.name
            v17.nameScale = ui.new("UIScale", {Scale = 1, Parent = v17.name})
            v17.sub = ui.new("TextLabel", {Name = "Sub", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.68), Size = UDim2.fromOffset(900, 34), Text = "", FontFace = fonts.Heavy, TextSize = 28, TextColor3 = colors.TextDim, TextTransparency = 1, ZIndex = 7, (ui.TextStroke(colors.Void, 2, 0.35)), Parent = v17.stage})
            v17.newTitle = ui.new("TextLabel", {Name = "NewTitle", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.735), Size = UDim2.fromOffset(900, 28), Text = "", FontFace = fonts.Heavy, TextSize = 22, TextColor3 = colors.TextDim, TextTransparency = 1, ZIndex = 7, (ui.TextStroke(colors.Void, 2, 0.4)), Parent = v17.stage})
            v17.cards = ui.new("Frame", {Name = "Cards", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.76), Size = UDim2.fromOffset(1000, 132), ZIndex = 7, (ui.List(Enum.FillDirection.Horizontal, 16, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)), Parent = v17.stage})
            v17.cont = ui.new("TextButton", {Name = "Continue", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -14), Size = UDim2.fromOffset(260, 52), Text = "", AutoButtonColor = false, BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.15, Visible = false, ZIndex = 10, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Stroke, 1.5, 0.6)), Parent = v17.stage})
            ui.new("TextLabel", {Name = "Label", Text = "CONTINUE", TextSize = 24, ZIndex = 11, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = v17.cont})
            v17.contScale = ui.new("UIScale", {Scale = 1, Parent = v17.cont})
            v17.catcher = ui.new("TextButton", {Name = "Catcher", Text = "", BackgroundTransparency = 1, AutoButtonColor = false, ZIndex = 1, Size = UDim2.fromScale(1, 1), Parent = ui2})
        end

        local function blocked()
            --[[
              name: blocked
              line: 188
              upvalues:
                localPlayer (copy, index: 1)
                a9 (copy, index: 2)
            ]]
            return localPlayer:GetAttribute("ReplayPlaying") == true
                or a9.IsHudHiddenFor("Intro")
                or a9.IsHudHiddenFor("Celebrate")
        end

        local ui2 = nil

        local function setBlur(blur)
            --[[
              name: setBlur
              line: 193
              upvalues:
                ui2 (ref,  index: 1)
                ui (copy, index: 2)
                lighting (copy, index: 3)
                tweenService (copy, index: 4)
            ]]
            if blur then
                if not ui2 or not ui2.Parent then
                    ui2 = ui.new("BlurEffect", {Name = "TR_RankUpBlur", Size = 0, Parent = lighting})
                end

                local propertyTable = {Size = 14}
                tweenService:Create(ui2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()

                return
            end

            if ui2 then
                local instance = ui2
                ui2 = nil
                local propertyTable = {Size = 0}
                local tween = tweenService:Create(instance, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable)
                tween:Play()
                tween.Completed:Connect(
                    function()
                        --[[
                          line: 203
                          upvalues:
                            instance (copy, index: 1)
                        ]]
                        instance:Destroy()
                    end
                )
            end
        end

        local function clearCards()
            --[[
              name: clearCards
              line: 209
              upvalues:
                v17 (ref, index: 1)
            ]]
            for _, child in v17.cards:GetChildren() do
                if child:IsA("GuiObject") then
                    child:Destroy()
                end
            end
        end

        local function weaponCard(a51, a52: boolean?, imageColor3, layoutOrder)
            --[[
              name: weaponCard
              line: 217
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                theme (copy, index: 3)
                v17 (ref,  index: 4)
                a9 (copy, index: 5)
                fonts (copy, index: 6)
            ]]
            local text
            local parent = ui.new("Frame", {Name = "Card_" .. a51, Size = UDim2.fromOffset(150, 132), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.1, LayoutOrder = layoutOrder, ZIndex = 7, ui.Corner(theme.Radius.Large), (ui.Stroke(imageColor3, 2, 0.25)), Parent = v17.cards})
            ui.new("UIScale", {Scale = 1, Parent = parent})
            local ui2 = ui.new("Frame", {Name = "Icon", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(84, 84), Parent = parent})
            a9.WeaponIcon.Set(ui2, a51, {spin = true})
            ui.new("TextLabel", {Name = "Name", TextSize = 17, TextScaled = false, ZIndex = 8, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -12, 0, 22), Text = string.upper(a9.WeaponInfo.Name(a51)), FontFace = fonts.Heavy, TextColor3 = colors.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent})
            local newUi = ui.new
            local v59 = "TextLabel"
            local v60 = {Name = "Tag", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 6), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20)}

            if a52 then
                text = " OWNED "
            else
                text = " NEW "
            end

            v60.Text = text
            v60.FontFace = fonts.Heavy
            v60.TextSize = 14
            v60.TextColor3 = if a52 then colors.TextDim else colors.TextDark
            v60.BackgroundColor3 = if a52 then colors.Raised else imageColor3
            v60.BackgroundTransparency = 0
            v60.ZIndex = 9
            v60[1] = (ui.Corner(theme.Radius.Pill))
            v60.Parent = parent
            newUi(v59, v60)

            return parent
        end

        local v61 = nil
        local renderSteppedConnection = nil
        local v63 = nil
        local v64 = nil

        local function finish(a66: string)
            --[[
              name: finish
              line: 277
              upvalues:
                v18 (ref,  index: 1)
                count (ref,  index: 2)
                v61 (ref,  index: 3)
                renderSteppedConnection (ref,  index: 4)
                v63 (ref,  index: 5)
                v64 (ref,  index: 6)
                ui2 (ref,  index: 7)
                tweenService (copy, index: 8)
                v17 (ref,  index: 9)
                clearCards (copy, index: 10)
                a9 (copy, index: 11)
            ]]
            if not v18 then
                return
            end

            local onDone = v18.onDone
            v18 = nil
            count += 1

            if v61 then
                v61()
                v61 = nil
            end

            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end

            if v63 then
                v63:Disconnect()
                v63 = nil
            end

            if v64 then
                v64:Disconnect()
                v64 = nil
            end

            if ui2 then
                local instance = ui2
                ui2 = nil
                local propertyTable = {Size = 0}
                local tween = tweenService:Create(instance, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable)
                tween:Play()
                tween.Completed:Connect(
                    function()
                        --[[
                          line: 203
                          upvalues:
                            instance (copy, index: 1)
                        ]]
                        instance:Destroy()
                    end
                )
            end

            v17.pool:Clear()

            for _, instance in {v17.glow, v17.rays, v17.raysThin, v17.ring} do
                local propertyTable = {ImageTransparency = 1}
                tweenService:Create(instance, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
            end

            for _, instance in {v17.kicker, v17.name, v17.sub, v17.newTitle} do
                local propertyTable = {TextTransparency = 1}
                tweenService:Create(instance, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
            end

            local propertyTable = {Transparency = 1}
            tweenService:Create(v17.nameStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
            local propertyTable2 = {BackgroundTransparency = 1}
            tweenService:Create(v17.dim, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable2):Play()
            v17.cont.Visible = false

            task.delay(
                0.25,
                function()
                    --[[
                      line: 312
                      upvalues:
                        v18 (ref,  index: 1)
                        v17 (ref,  index: 2)
                        clearCards (copy, index: 3)
                    ]]
                    if not v18 then
                        v17.root.Visible = false
                        clearCards()
                    end
                end
            )

            a9.SetHudHidden("RankUp", false)
            a9.MenuManager.HoldChat("RankUp", false)

            if a9.TopbarSettings and type(a9.TopbarSettings.SetHidden) == "function" then
                pcall(a9.TopbarSettings.SetHidden, "RankUp", false)
            end

            if onDone then
                task.spawn(onDone, a66)
            end
        end

        local function settle(a80)
            --[[
              name: settle
              line: 329
              upvalues:
                v18 (ref,  index: 1)
                v17 (ref,  index: 2)
                ui (copy, index: 3)
            ]]
            if not v18 or v18.token ~= a80 or v18.settled then
                return
            end

            v18.settled = true
            v17.emblemScale.Scale = 1
            v17.nameScale.Scale = 1
            v17.kicker.TextTransparency = 0
            v17.name.TextTransparency = 0
            v17.nameStroke.Transparency = 0.2
            v17.sub.TextTransparency = 0
            v17.newTitle.TextTransparency = 0
            v17.glow.ImageTransparency = 0.35
            v17.rays.ImageTransparency = 0.55
            v17.raysThin.ImageTransparency = 0.75
            v17.dim.BackgroundTransparency = 0.22

            for _, card in v18.cards do
                card.Visible = true

                if const uiScale = card:FindFirstChildOfClass("UIScale") then
                    uiScale.Scale = 1
                end
            end

            v17.cont.Visible = true
            v18.contAt = os.clock()
            ui.Pop(v17.cont, 0.6)
        end

        local function tap(a85)
            --[[
              name: tap
              line: 358
              upvalues:
                v18 (ref,  index: 1)
                settle (copy, index: 2)
                a9 (copy, index: 3)
                finish (copy, index: 4)
            ]]
            if not v18 then
                return
            end

            if not v18.settled then
                settle(v18.token)
                return
            end

            if a85 and 0.35 < os.clock() - (v18.contAt or 0) then
                a9.Sounds.Play("Click")
                finish("done")
            end
        end

        local rankUp = {
            IsPlaying = (function()
                --[[
                  name: IsPlaying
                  line: 372
                  upvalues:
                    v18 (ref, index: 1)
                ]]
                return v18 ~= nil
            end),
            Stop = (function()
                --[[
                  name: Stop
                  line: 376
                  upvalues:
                    finish (copy, index: 1)
                ]]
                finish("interrupted")
            end),
            Play = (function(a87, onDone)
                --[[
                  name: Play
                  line: 381
                  upvalues:
                    localPlayer (copy, index: 1)
                    a9 (copy, index: 2)
                    build (copy, index: 3)
                    v18 (ref,  index: 4)
                    finish (copy, index: 5)
                    count (ref,  index: 6)
                    Ranks (copy, index: 7)
                    RankArt (copy, index: 8)
                    clearCards (copy, index: 9)
                    v17 (ref,  index: 10)
                    theme (copy, index: 11)
                    state (copy, index: 12)
                    ui (copy, index: 13)
                    weaponCard (copy, index: 14)
                    v63 (ref,  index: 15)
                    settle (copy, index: 16)
                    v64 (ref,  index: 17)
                    contextActionService (copy, index: 18)
                    v61 (ref,  index: 19)
                    renderSteppedConnection (ref,  index: 20)
                    ui2 (ref,  index: 21)
                    lighting (copy, index: 22)
                    tweenService (copy, index: 23)
                ]]
                local number

                if type(a87) ~= "table" then
                    number = nil
                else
                    number = tonumber(a87.rank)
                    number = number or nil
                end

                if not number then
                    return false
                end

                local v90 = localPlayer:GetAttribute("ReplayPlaying") == true
                    or a9.IsHudHiddenFor("Intro")
                    or a9.IsHudHiddenFor("Celebrate")
                if v90 then
                    return false
                end

                build()

                if v18 then
                    finish("interrupted")
                end

                count += 1
                local token = count
                local clampedValue = math.clamp(math.floor(number), 1, Ranks.Count())
                local v93 = Ranks.Get(clampedValue)
                local imageColor3, v95 = RankArt.Color(clampedValue)
                local v96 = Ranks.NewItems(clampedValue - 1, clampedValue)
                v18 = {settled = false, token = token, onDone = onDone, cards = {}}
                a9.SetHudHidden("RankUp", true)
                a9.MenuManager.HoldChat("RankUp", true)

                if a9.TopbarSettings and type(a9.TopbarSettings.SetHidden) == "function" then
                    pcall(a9.TopbarSettings.SetHidden, "RankUp", true)
                end

                clearCards()
                v17.root.Visible = true
                v17.dim.BackgroundTransparency = 1
                v17.flash.BackgroundTransparency = 1

                for _, v98 in {v17.glow, v17.rays, v17.raysThin, v17.ring} do
                    v98.ImageTransparency = 1
                    v98.ImageColor3 = imageColor3
                end

                v17.raysThin.ImageColor3 = theme.Lighten(imageColor3, 0.4)
                v17.ring.Size = UDim2.fromOffset(200, 200)
                RankArt.SetEmblem(v17.emblem, clampedValue)
                v17.emblem.Visible = false
                v17.emblemScale.Scale = 2.6
                v17.kicker.TextTransparency = 1
                v17.name.Text = string.upper(v93.name)
                v17.name.TextTransparency = 1
                v17.nameStroke.Transparency = 1
                v17.nameGrad.Color = ColorSequence.new(theme.Lighten(imageColor3, 0.35), imageColor3)
                v17.nameScale.Scale = 1.8
                local v99 = state.Profile or {}
                local v100 = math.max((tonumber(v99.trophies) or 0), v93.trophies)
                v17.sub.Text = string.format("%s TROPHIES", ui.FormatNumber(v100))
                v17.sub.TextTransparency = 1
                v17.newTitle.TextTransparency = 1

                if not (0 < #v96) then
                    if Ranks.Count() <= clampedValue then
                        v17.newTitle.Text = "THE TOP RANK"
                    else
                        local v101 = Ranks.Get(clampedValue + 1)
                        v17.newTitle.Text = string.format("NEXT: %s AT %s", string.upper(v101.name), ui.FormatNumber(v101.trophies))
                    end
                else
                    v17.newTitle.Text = #v96 ~= 1 and "NEW WEAPONS IN DROPS" or "NEW WEAPON IN DROPS"
                end

                local owns = a9.Economy and a9.Economy.Owns

                for layoutOrder, v104 in v96 do
                    local v105

                    if type(owns) == "function" then
                        v105 = owns(v104) == true
                    else
                        v105 = false
                    end

                    local v106 = weaponCard(v104, v105, imageColor3, layoutOrder)
                    v106.Visible = false
                    table.insert(v18.cards, v106)
                end

                v17.cont.Visible = false

                v63 = v17.catcher.Activated:Connect(
                    function()
                        --[[
                          line: 449
                          upvalues:
                            v18 (ref,  index: 1)
                            settle (copy, index: 2)
                        ]]
                        if not v18 then
                            return
                        end

                        if not v18.settled then
                            settle(v18.token)
                        end
                    end
                )

                v64 = v17.cont.Activated:Connect(
                    function()
                        --[[
                          line: 452
                          upvalues:
                            v18 (ref,  index: 1)
                            settle (copy, index: 2)
                            a9 (copy, index: 3)
                            finish (copy, index: 4)
                        ]]
                        if not v18 then
                            return
                        end

                        if not v18.settled then
                            settle(v18.token)
                            return
                        end

                        if 0.35 < os.clock() - (v18.contAt or 0) then
                            a9.Sounds.Play("Click")
                            finish("done")
                        end
                    end
                )

                contextActionService:BindActionAtPriority(
                    "TR_RankUpKeys",
                    function(actionName: string, inputState: Enum.UserInputState)
                        --[[
                          line: 456
                          upvalues:
                            v18 (ref,  index: 1)
                            settle (copy, index: 2)
                            a9 (copy, index: 3)
                            finish (copy, index: 4)
                        ]]
                        if inputState == Enum.UserInputState.Begin and v18 then
                            if v18.settled then
                                if 0.35 < os.clock() - (v18.contAt or 0) then
                                    a9.Sounds.Play("Click")
                                    finish("done")
                                end
                            else
                                settle(v18.token)
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

                v61 = function()
                    --[[
                      line: 462
                      upvalues:
                        contextActionService (copy, index: 1)
                    ]]
                    contextActionService:UnbindAction("TR_RankUpKeys")
                end

                renderSteppedConnection = game:GetService("RunService").RenderStepped:Connect(
                    function(deltaTime: number)
                        --[[
                          line: 466
                          upvalues:
                            v18 (ref,  index: 1)
                            token (copy, index: 2)
                            v17 (ref,  index: 3)
                        ]]
                        if not v18 or v18.token ~= token then
                            return
                        end

                        v17.rays.Rotation = (v17.rays.Rotation + (deltaTime * 9)) % 360
                        v17.raysThin.Rotation = (v17.raysThin.Rotation - (deltaTime * 5)) % 360
                    end
                )

                local function alive()
                    --[[
                      name: alive
                      line: 474
                      upvalues:
                        v18 (ref,  index: 1)
                        token (copy, index: 2)
                        localPlayer (copy, index: 3)
                        a9 (copy, index: 4)
                        finish (copy, index: 5)
                    ]]
                    if not v18 or v18.token ~= token then
                        return false
                    end

                    local v111 = localPlayer:GetAttribute("ReplayPlaying") == true
                        or a9.IsHudHiddenFor("Intro")
                        or a9.IsHudHiddenFor("Celebrate")
                    if v111 then
                        finish("interrupted")
                        return false
                    end

                    return not v18.settled
                end

                task.spawn(
                    function()
                        --[[
                          line: 485
                          upvalues:
                            ui2 (ref,  index: 1)
                            ui (copy, index: 2)
                            lighting (copy, index: 3)
                            tweenService (copy, index: 4)
                            v17 (ref,  index: 5)
                            v18 (ref,  index: 6)
                            token (copy, index: 7)
                            localPlayer (copy, index: 8)
                            a9 (copy, index: 9)
                            finish (copy, index: 10)
                            imageColor3 (copy, index: 11)
                            theme (copy, index: 12)
                            v95 (copy, index: 13)
                            settle (copy, index: 14)
                        ]]
                        local v112
                        local v113
                        local v114
                        local v115
                        local v116
                        local v117
                        local v118

                        if not ui2 or not ui2.Parent then
                            ui2 = ui.new("BlurEffect", {Name = "TR_RankUpBlur", Size = 0, Parent = lighting})
                        end

                        local propertyTable = {Size = 14}
                        tweenService:Create(ui2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable):Play()
                        local propertyTable2 = {BackgroundTransparency = 0.22}
                        tweenService:Create(v17.dim, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable2):Play()
                        local propertyTable3 = {ImageTransparency = 0.6}
                        tweenService:Create(v17.glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable3):Play()
                        task.wait(0.25)

                        if not v18 or v18.token ~= token then
                            v112 = false
                        else
                            local v122 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v122 then
                                finish("interrupted")
                                v112 = false
                            else
                                v112 = not v18.settled
                            end
                        end

                        if not v112 then
                            return
                        end

                        v17.kicker.Position = UDim2.fromScale(0.5, 0.08)
                        local kicker = v17.kicker
                        local propertyTable4 = {TextTransparency = 0, Position = UDim2.fromScale(0.5, 0.11)}
                        local back = Enum.EasingStyle.Back
                        local newTweenInfo = TweenInfo.new
                        local easingStyle = back or Enum.EasingStyle.Quad
                        tweenService:Create(kicker, newTweenInfo(0.35, easingStyle, Enum.EasingDirection.Out), propertyTable4):Play()
                        a9.Sounds.Play("Whoosh")
                        task.wait(0.2)

                        if not v18 or v18.token ~= token then
                            v113 = false
                        else
                            local v128 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v128 then
                                finish("interrupted")
                                v113 = false
                            else
                                v113 = not v18.settled
                            end
                        end

                        if not v113 then
                            return
                        end

                        v17.emblem.Visible = true
                        local emblemScale = v17.emblemScale
                        local propertyTable5 = {Scale = 1}
                        local back2 = Enum.EasingStyle.Back
                        local out = Enum.EasingDirection.Out
                        local newTweenInfo2 = TweenInfo.new
                        local easingStyle2 = back2 or Enum.EasingStyle.Quad
                        local out2 = out or Enum.EasingDirection.Out
                        tweenService:Create(emblemScale, newTweenInfo2(0.28, easingStyle2, out2), propertyTable5):Play()
                        task.wait(0.2)

                        if not v18 or v18.token ~= token then
                            v114 = false
                        else
                            local v136 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v136 then
                                finish("interrupted")
                                v114 = false
                            else
                                v114 = not v18.settled
                            end
                        end

                        if not v114 then
                            return
                        end

                        a9.Sounds.Play("LevelUp")
                        a9.Sounds.Play("Fanfare")
                        v17.flash.BackgroundTransparency = 0.55
                        local propertyTable6 = {BackgroundTransparency = 1}
                        tweenService:Create(v17.flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable6):Play()
                        v17.ring.ImageTransparency = 0.1
                        local ring = v17.ring
                        local propertyTable7 = {ImageTransparency = 1, Size = UDim2.fromOffset(900, 900)}
                        tweenService:Create(ring, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable7):Play()
                        local propertyTable8 = {ImageTransparency = 0.35}
                        tweenService:Create(v17.glow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable8):Play()
                        local pool = v17.pool
                        pool:Burst(46, {mode = "point", speed = 900, life = 1.1, grav = 260, colors = {imageColor3, theme.Lighten(imageColor3, 0.4), v95}, white = theme.Lighten(imageColor3, 0.7)})
                        local pool2 = v17.pool
                        pool2:Burst(18, {mode = "point", kind = "sparkle", speed = 420, size = 26, life = 1.4, grav = -40, color = theme.Lighten(imageColor3, 0.5)})
                        ui.Shake(v17.root, 10)
                        local propertyTable9 = {ImageTransparency = 0.55}
                        tweenService:Create(v17.rays, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable9):Play()
                        local propertyTable10 = {ImageTransparency = 0.75}
                        tweenService:Create(v17.raysThin, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable10):Play()
                        task.wait(0.15)

                        if not v18 or v18.token ~= token then
                            v115 = false
                        else
                            local v145 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v145 then
                                finish("interrupted")
                                v115 = false
                            else
                                v115 = not v18.settled
                            end
                        end

                        if not v115 then
                            return
                        end

                        local propertyTable11 = {TextTransparency = 0}
                        tweenService:Create(v17.name, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable11):Play()
                        local propertyTable12 = {Transparency = 0.2}
                        tweenService:Create(v17.nameStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable12):Play()
                        local nameScale = v17.nameScale
                        local propertyTable13 = {Scale = 1}
                        local back3 = Enum.EasingStyle.Back
                        local newTweenInfo3 = TweenInfo.new
                        local easingStyle3 = back3 or Enum.EasingStyle.Quad
                        tweenService:Create(nameScale, newTweenInfo3(0.32, easingStyle3, Enum.EasingDirection.Out), propertyTable13):Play()
                        task.wait(0.3)

                        if not v18 or v18.token ~= token then
                            v116 = false
                        else
                            local v153 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v153 then
                                finish("interrupted")
                                v116 = false
                            else
                                v116 = not v18.settled
                            end
                        end

                        if not v116 then
                            return
                        end

                        local propertyTable14 = {TextTransparency = 0}
                        tweenService:Create(v17.sub, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable14):Play()
                        task.wait(0.45)

                        if not v18 or v18.token ~= token then
                            v117 = false
                        else
                            local v155 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v155 then
                                finish("interrupted")
                                v117 = false
                            else
                                v117 = not v18.settled
                            end
                        end

                        if not v117 then
                            return
                        end

                        local propertyTable15 = {TextTransparency = 0}
                        tweenService:Create(v17.newTitle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), propertyTable15):Play()

                        for _, card in v18.cards do
                            local v159
                            task.wait(0.2)

                            if not v18 or v18.token ~= token then
                                v159 = false
                            else
                                local v160 = localPlayer:GetAttribute("ReplayPlaying") == true
                                    or a9.IsHudHiddenFor("Intro")
                                    or a9.IsHudHiddenFor("Celebrate")

                                if v160 then
                                    finish("interrupted")
                                    v159 = false
                                else
                                    v159 = not v18.settled
                                end
                            end

                            if not v159 then
                                return
                            end

                            card.Visible = true

                            if const uiScale = card:FindFirstChildOfClass("UIScale") then
                                uiScale.Scale = 0.3
                                local propertyTable16 = {Scale = 1}
                                local back4 = Enum.EasingStyle.Back
                                local newTweenInfo4 = TweenInfo.new
                                local easingStyle4 = back4 or Enum.EasingStyle.Quad
                                tweenService:Create(uiScale, newTweenInfo4(0.3, easingStyle4, Enum.EasingDirection.Out), propertyTable16):Play()
                            end

                            a9.Sounds.Play("Coin", {pitch = 1.1})
                        end

                        task.wait(0.5)

                        if not v18 or v18.token ~= token then
                            v118 = false
                        else
                            local v166 = localPlayer:GetAttribute("ReplayPlaying") == true
                                or a9.IsHudHiddenFor("Intro")
                                or a9.IsHudHiddenFor("Celebrate")

                            if v166 then
                                finish("interrupted")
                                v118 = false
                            else
                                v118 = not v18.settled
                            end
                        end

                        if v118 then
                            settle(token)
                        end
                    end
                )

                return true
            end)
        }
        a9.RankUp = rankUp

        a9.Debug.rankUp = function(a167)
            --[[
              line: 561
              upvalues:
                rankUp (copy, index: 1)
            ]]
            return rankUp.Play(
                {source = "rank", rank = tonumber(a167) or 4},
                function(a168)
                    --[[
                      line: 562
                    ]]
                    print("[RankUp] done:", a168)
                end
            )
        end
    end)
}