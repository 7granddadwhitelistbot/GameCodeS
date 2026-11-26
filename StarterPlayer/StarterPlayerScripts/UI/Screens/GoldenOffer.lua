local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local Unlocks = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Unlocks"))
local v5 = {}
local color3FromRGB = Color3.fromRGB
local textColor3 = color3FromRGB(255, 196, 60)
local color3 = color3FromRGB(255, 226, 150)
local color32 = color3FromRGB(92, 50, 4)
local backgroundColor3 = color3FromRGB(245, 52, 64)

function v5.Init(a11)
    --[[
      name: Init
      line: 29
      upvalues:
        players (copy, index: 1)
        Unlocks (copy, index: 2)
        color3FromRGB (copy, index: 3)
        textColor3 (copy, index: 4)
        color32 (copy, index: 5)
        color3 (copy, index: 6)
        backgroundColor3 (copy, index: 7)
        runService (copy, index: 8)
    ]]
    local buildChest
    local v13
    local ui = a11.UI
    local theme = a11.Theme
    local state = a11.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local menuManager = a11.MenuManager
    local economy = a11.Economy
    local localPlayer = players.LocalPlayer
    local udim2FromOffset = UDim2.fromOffset
    local key = Unlocks.FIRST_DROP.key
    local v24 = nil
    local dropModels = script.Parent.Parent:FindFirstChild("DropModels")

    local success, DropModels = pcall(
        function()
            --[[
              line: 41
              upvalues:
                dropModels (copy, index: 1)
            ]]
            local dropModels2 = dropModels
            return require(dropModels2)
        end
    )

    if success then
        if type(DropModels) ~= "table" then
            v13 = v24
        else
            v13 = DropModels
        end
    else
        v13 = v24
    end

    local v29 = nil
    local v30 = {}
    local timestamp = 0
    local shownThisSession = false
    local v33 = {}
    local renderSteppedConnection = nil

    local function close()
        --[[
          name: close
          line: 56
          upvalues:
            menuManager (copy, index: 1)
        ]]
        menuManager.Close("GoldenOffer")
    end

    buildChest = function(parent)
        --[[
          name: buildChest
          line: 60
          upvalues:
            v13 (ref,  index: 1)
            color3FromRGB (copy, index: 2)
            v33 (copy, index: 3)
        ]]
        local golden = v13 and v13.Golden
        if not golden then
            return
        end

        for _, part in golden.parts do
            local part2 = Instance.new("Part")
            part2.Anchored = true
            part2.CanCollide = false
            part2.CanQuery = false
            part2.CanTouch = false
            part2.CastShadow = false
            part2.Size = Vector3.new(part.size[1], part.size[2], part.size[3])
            part2.Color = color3FromRGB(part.color[1], part.color[2], part.color[3])
            pcall(
                function()
                    --[[
                      line: 74
                      upvalues:
                        part2 (copy, index: 1)
                        part (copy, index: 2)
                    ]]
                    part2.Material = Enum.Material[part.material]
                end
            )

            if part.mesh ~= "" then
                local specialMesh = Instance.new("SpecialMesh")
                specialMesh.MeshType = Enum.MeshType.FileMesh
                specialMesh.MeshId = part.mesh
                specialMesh.TextureId = part.tex
                specialMesh.Scale = Vector3.new(part.scale[1], part.scale[2], part.scale[3])
                specialMesh.Parent = part2
            end

            part2.Parent = parent
            table.insert(v33, {part = part2, cf = CFrame.new(table.unpack(part.cf))})
        end
    end

    local function build()
        --[[
          name: build
          line: 90
          upvalues:
            v29 (ref,  index: 1)
            ui (copy, index: 2)
            udim2FromOffset (copy, index: 3)
            a11 (copy, index: 4)
            close (copy, index: 5)
            textColor3 (copy, index: 6)
            color3FromRGB (copy, index: 7)
            color32 (copy, index: 8)
            v30 (copy, index: 9)
            color3 (copy, index: 10)
            buildChest (copy, index: 11)
            fonts (copy, index: 12)
            backgroundColor3 (copy, index: 13)
            colors (copy, index: 14)
            timestamp (ref,  index: 15)
            economy (copy, index: 16)
            key (copy, index: 17)
            menuManager (copy, index: 18)
        ]]
        v29 = ui.Window({Name = "GoldenOffer", Title = "LIMITED-TIME OFFER", Subtitle = "Only once, only for your first purchase", HeaderHeight = 80, Size = udim2FromOffset(780, 520), Parent = a11.Canvas.Menus, OnCloseRequested = close})
        v29.Title.TextColor3 = textColor3
        ui.SelectionRing(v29.Root)
        local content = v29.Content
        local ui2 = ui.new("Frame", {Name = "Hero", Size = UDim2.new(0, 330, 1, 0), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, ui.Corner(14), ui.Gradient(color3FromRGB(150, 88, 10), color32, 90), (ui.Stroke(textColor3, 2, 0.35)), Parent = content})
        v30.hero = ui2
        v30.rays = ui.Image(ui.Assets.Fx.Rays, {Name = "Rays", ImageTransparency = 0.62, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(1.9, 1.9), SizeConstraint = Enum.SizeConstraint.RelativeXX, ImageColor3 = color3, Parent = ui2})
        ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.35, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.1, 0.8), ImageColor3 = color3FromRGB(255, 214, 120), Parent = ui2})
        local parent = ui.new("ViewportFrame", {Name = "Chest", BackgroundTransparency = 1, LightDirection = Vector3.new(0.44999998807907104, -1, 0.550000011920929), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX, Ambient = color3FromRGB(160, 150, 140), LightColor = color3FromRGB(255, 244, 228), Parent = ui2})
        local currentCamera = Instance.new("Camera")
        currentCamera.FieldOfView = 28
        currentCamera.CFrame = CFrame.lookAt(Vector3.new(0, 4.599999904632568, -15.5), Vector3.new(0, 2.200000047683716, 0))
        currentCamera.Parent = parent
        parent.CurrentCamera = currentCamera
        buildChest(parent)
        ui.new("TextLabel", {Name = "Caption", Text = "1 × GOLDEN DROP", FontFace = fonts.Heavy, TextSize = 18, TextColor3 = color3, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), Size = UDim2.new(1, -20, 0, 22), (ui.TextStroke(color32, 2, 0.2)), Parent = ui2})
        local parent2 = ui.new("Frame", {Name = "Burst", Rotation = -12, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Position = udim2FromOffset(70, 70), Size = udim2FromOffset(112, 112), Parent = ui2})

        for index = 0, 1 do
            ui.new("Frame", {Name = "Star" .. index, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.74, 0.74), Rotation = index * 45, BackgroundColor3 = backgroundColor3, ZIndex = 5, ui.Corner(8), (ui.Stroke(color3FromRGB(255, 170, 176), 2, 0.25)), Parent = parent2})
        end

        v30.burstScale = ui.new("UIScale", {Parent = parent2})
        v30.burstPct = ui.new("TextLabel", {Name = "Pct", Text = "SALE", FontFace = fonts.Display, TextSize = 30, TextColor3 = colors.Text, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, -6), Size = UDim2.fromScale(1, 0.4), ZIndex = 6, (ui.TextStroke(color3FromRGB(120, 10, 20), 2, 0.2)), Parent = parent2})
        v30.burstOff = ui.new("TextLabel", {Name = "Off", Text = "OFF", TextSize = 15, ZIndex = 6, FontFace = fonts.Heavy, TextColor3 = colors.Text, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 18), Size = UDim2.fromScale(1, 0.2), Parent = parent2})
        local ui3 = ui.new("Frame", {Name = "Offer", Position = udim2FromOffset(352, 0), Size = UDim2.new(1, -352, 1, 0), Parent = content})
        v30.col = ui3
        local list = ui.List(Enum.FillDirection.Vertical, 10)
        list.Parent = ui3
        v30.list = list
        v30.tag = ui.Pill("ONE-TIME OFFER", backgroundColor3, {Name = "Tag", Height = 28, TextSize = 14, Transparency = 0, LayoutOrder = 1, Parent = ui3})
        v30.title = ui.DisplayText({Name = "Name", Text = "GOLDEN DROP", TextSize = 42, StrokeThickness = 0, LayoutOrder = 2, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 44), Parent = ui3})
        v30.line = ui.new("TextLabel", {Name = "Line", Text = "", TextSize = 16, TextWrapped = true, LayoutOrder = 3, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 42), Parent = ui3})
        local ui4 = ui.new("Frame", {Name = "Prices", LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 56), Parent = ui3})
        v30.prices = ui4
        v30.was = ui.new("TextLabel", {Name = "Was", Text = "", RichText = true, TextSize = 28, FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.X, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 2), Size = UDim2.new(0, 0, 0, 30), Parent = ui4})
        v30.slash = ui.new("Frame", {Name = "Slash", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 8, 0, 3), Rotation = -14, BackgroundColor3 = backgroundColor3, ZIndex = 3, (ui.Corner(2)), Parent = v30.was})
        v30.now = ui.DisplayText({Name = "Now", Text = "", TextSize = 50, StrokeThickness = 0, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 110, 0.5, 0), Size = UDim2.new(0, 160, 0, 54), Parent = ui4})
        local ui5 = ui.new("Frame", {Name = "Timer", Size = UDim2.new(1, 0, 0, 64), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.86, LayoutOrder = 5, ui.Corner(12), (ui.Stroke(backgroundColor3, 1.5, 0.55)), Parent = ui3})
        v30.timer = ui5
        ui.Glyph("clock", 26, color3FromRGB(255, 140, 146), {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Parent = ui5})
        ui.new("TextLabel", {Name = "Ends", Text = "ENDS IN", TextSize = 14, FontFace = fonts.Heavy, TextColor3 = color3FromRGB(255, 160, 166), TextXAlignment = Enum.TextXAlignment.Left, Position = udim2FromOffset(50, 10), Size = udim2FromOffset(80, 18), Parent = ui5})
        v30.left = ui.new("TextLabel", {Name = "Left", Text = "", TextSize = 28, FontFace = fonts.Display, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = udim2FromOffset(50, 28), Size = udim2FromOffset(150, 30), Parent = ui5})
        ui.new("TextLabel", {Name = "Gone", Text = "Then this price is gone for good.", TextSize = 13, TextWrapped = true, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.new(1, -220, 1, -12), Parent = ui5})
        v30.buy = ui.Button({Name = "Buy", Text = "", TextSize = 22, Style = "Success", LayoutOrder = 6, Size = UDim2.new(1, 0, 0, 60), Parent = ui3})
        v30.buy.Label.RichText = true

        v30.buy.Activated:Connect(
            function()
                --[[
                  line: 321
                  upvalues:
                    timestamp (ref,  index: 1)
                    economy (copy, index: 2)
                    key (copy, index: 3)
                ]]
                if 0.4 < os.clock() - timestamp then
                    economy.Buy(key)
                end
            end
        )

        local ui6 = ui.new("Frame", {Name = "Row", Size = UDim2.new(1, 0, 0, 46), LayoutOrder = 7, (ui.List(Enum.FillDirection.Horizontal, 10)), Parent = ui3})
        v30.row = ui6
        v30.odds = ui.Button({Name = "Odds", Text = "VIEW ODDS", TextSize = 16, Style = "Dark", LayoutOrder = 1, Size = UDim2.new(0.5, -5, 1, 0), Parent = ui6})

        v30.odds.Activated:Connect(
            function()
                --[[
                  line: 329
                  upvalues:
                    timestamp (ref,  index: 1)
                    menuManager (copy, index: 2)
                ]]
                if 0.4 < os.clock() - timestamp then
                    menuManager.Close("GoldenOffer")
                    task.defer(
                        function()
                            --[[
                              line: 332
                              upvalues:
                                menuManager (copy, index: 1)
                            ]]
                            menuManager.Open("Collection", {odds = true})
                        end
                    )
                end
            end
        )

        v30.later = ui.Button({Name = "Later", Text = "NOT NOW", TextSize = 16, Style = "Dark", LayoutOrder = 2, Size = UDim2.new(0.5, -5, 1, 0), Parent = ui6})

        v30.later.Activated:Connect(
            function()
                --[[
                  line: 338
                  upvalues:
                    timestamp (ref,  index: 1)
                    menuManager (copy, index: 2)
                ]]
                if 0.4 < os.clock() - timestamp then
                    menuManager.Close("GoldenOffer")
                end
            end
        )
    end

    local function paint()
        --[[
          name: paint
          line: 345
          upvalues:
            v29 (ref,  index: 1)
            economy (copy, index: 2)
            v30 (copy, index: 3)
            key (copy, index: 4)
            Unlocks (copy, index: 5)
        ]]
        local flooredValue
        local v56
        local text

        if not v29 then
            return
        end

        local v58 = economy.DropInfo("golden")
        local number = tonumber(v58.stacks) or 4
        local number2 = tonumber(v58.min)
        local number3 = tonumber(v58.max)

        if number2 and number3 then
            flooredValue = math.floor(((number * (number2 + number3)) / 2) + 0.5)
        else
            flooredValue = 60
        end

        v30.line.Text = string.format("About %d item shards in %d big stacks. One is always an item you don't own yet.", flooredValue, number)
        local v62 = economy.OfferDiscount()
        v30.burstPct.Text = not v62 and "SALE" or string.format("-%d%%", v62)
        v30.burstOff.Visible = v62 ~= nil
        local v63 = economy.Price("drop_golden")
        local v64 = economy.Price(key)
        v30.was.Text = not v63 and "" or string.format("%s %d", economy.ROBUX, v63)
        v30.slash.Visible = v63 ~= nil
        v30.now.Text = if v64 then string.format("%s %d", economy.ROBUX, v64) else economy.ROBUX .. " …"
        local now = v30.now
        local newUDim2 = UDim2.new

        if v63 then
            v56 = math.max(v30.was.TextBounds.X, 60) + 22
            v56 = key
        else
            v56 = 0
            v56 = key
        end

        now.Position = newUDim2(0, v56, 0.5, 0)
        local v67 = economy.Pending(v56)
        local buy = v30.buy

        if v67 then
            text = "…"
        else
            text = string.format("BUY NOW  <font color=\"#FFFFFF\">%s</font> %s", economy.ROBUX, economy.PriceAmount(v56))
        end

        buy:SetText(text)
        v30.buy:SetEnabled(not v67)
        local v69 = economy.OfferLeft() or Unlocks.FIRST_DROP.duration
        v30.left.Text = economy.FormatLeft(v69)
    end

    local function layout()
        --[[
          name: layout
          line: 369
          upvalues:
            ui (copy, index: 1)
            v29 (ref,  index: 2)
            udim2FromOffset (copy, index: 3)
            v30 (copy, index: 4)
            paint (copy, index: 5)
        ]]
        local maxValue
        local v72
        local v73
        local v74
        local v75 = ui.CanvasSize()
        local v76 = ui.TopInset()
        local v77 = ui.Compact or v75.Y - v76 < 600
        local flooredValue = math.floor((math.clamp(v75.X - 24, 360, 780)))
        local v79 = v75.Y - v76 - 12

        if v77 then
            maxValue = 440
        else
            maxValue = 520
        end

        local flooredValue2 = math.floor((math.clamp(v79, 320, maxValue)))
        v29.Holder.Size = udim2FromOffset(flooredValue, flooredValue2)

        if v77 then
            v72 = 270
        else
            v72 = 330
        end

        v30.hero.Size = UDim2.new(0, v72, 1, 0)
        v30.col.Position = udim2FromOffset(v72 + 22, 0)
        v30.col.Size = UDim2.new(1, -(v72 + 22), 1, 0)
        local list = v30.list
        v79 = UDim.new
        local v82 = v77 and 6 or 10
        list.Padding = v79(0, v82)
        v30.title.TextSize = v77 and 34 or 42
        local title = v30.title
        local newUDim2 = UDim2.new
        local v85 = v77 and 36 or 44
        title.Size = newUDim2(1, 0, 0, v85)
        v30.line.TextSize = v77 and 14 or 16
        local line = v30.line
        local newUDim22 = UDim2.new
        local v88 = v77 and 36 or 42
        line.Size = newUDim22(1, 0, 0, v88)
        local prices = v30.prices
        newUDim22 = UDim2.new

        if v77 then
            v73 = 46
            v73 = v30
        else
            v73 = 56
            v73 = v30
        end

        prices.Size = newUDim22(1, 0, 0, v73)
        v73.now.TextSize = v77 and 40 or 50
        local timer = v73.timer
        local newUDim23 = UDim2.new

        if v77 then
            v74 = 56
            v74 = v30
        else
            v74 = 64
            v74 = v30
        end

        timer.Size = newUDim23(1, 0, 0, v74)
        local instance = v74.buy.Instance
        newUDim23 = UDim2.new
        local v93 = v77 and 52 or 60
        instance.Size = newUDim23(1, 0, 0, v93)
        local row = v74.row
        newUDim23 = UDim2.new
        local v95 = v77 and 40 or 46
        row.Size = newUDim23(1, 0, 0, v95)
        v29.Refit()
        paint()
    end

    local function startSpin()
        --[[
          name: startSpin
          line: 395
          upvalues:
            renderSteppedConnection (ref,  index: 1)
            runService (copy, index: 2)
            v33 (copy, index: 3)
            v30 (copy, index: 4)
        ]]
        if renderSteppedConnection then
            return
        end

        local timestamp = os.clock()

        renderSteppedConnection = runService.RenderStepped:Connect(
            function()
                --[[
                  line: 400
                  upvalues:
                    timestamp (copy, index: 1)
                    v33 (copy, index: 2)
                    v30 (copy, index: 3)
                ]]
                local elapsedTime = os.clock() - timestamp
                local rotationY = math.sin(elapsedTime * 0.9) * 0.4886921905584123 + 0.4188790204786391
                local y = math.sin(elapsedTime * 1.7) * 0.12
                local cframe = CFrame.new(0, y, 0) * CFrame.Angles(0, rotationY, 0)

                for _, v103 in v33 do
                    v103.part.CFrame = cframe * v103.cf
                end

                v30.rays.Rotation = (elapsedTime * 10) % 360
                v30.burstScale.Scale = (((function(...) return (...) ^ 3 end)((math.max(0, (math.sin(elapsedTime * 5)))))) * 0.06) + 1
            end
        )
    end

    local function stopSpin()
        --[[
          name: stopSpin
          line: 413
          upvalues:
            renderSteppedConnection (ref, index: 1)
        ]]
        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end
    end

    menuManager.Register(
        "GoldenOffer",
        {
            open = (function()
                --[[
                  name: open
                  line: 421
                  upvalues:
                    v29 (ref,  index: 1)
                    build (copy, index: 2)
                    timestamp (ref,  index: 3)
                    shownThisSession (ref,  index: 4)
                    a11 (copy, index: 5)
                    layout (copy, index: 6)
                    renderSteppedConnection (ref,  index: 7)
                    runService (copy, index: 8)
                    v33 (copy, index: 9)
                    v30 (copy, index: 10)
                    economy (copy, index: 11)
                    ui (copy, index: 12)
                ]]
                if not v29 then
                    build()
                end

                timestamp = os.clock()
                shownThisSession = true
                a11.SetHudHidden("GoldenOffer", true)
                layout()
                v29:Open()

                if not renderSteppedConnection then
                    local timestamp2 = os.clock()

                    renderSteppedConnection = runService.RenderStepped:Connect(
                        function()
                            --[[
                              line: 400
                              upvalues:
                                timestamp2 (copy, index: 1)
                                v33 (copy, index: 2)
                                v30 (copy, index: 3)
                            ]]
                            local elapsedTime = os.clock() - timestamp2
                            local rotationY = math.sin(elapsedTime * 0.9) * 0.4886921905584123 + 0.4188790204786391
                            local y = math.sin(elapsedTime * 1.7) * 0.12
                            local cframe = CFrame.new(0, y, 0) * CFrame.Angles(0, rotationY, 0)

                            for _, v111 in v33 do
                                v111.part.CFrame = cframe * v111.cf
                            end

                            v30.rays.Rotation = (elapsedTime * 10) % 360
                            v30.burstScale.Scale = (((function(...) return (...) ^ 3 end)((math.max(0, (math.sin(elapsedTime * 5)))))) * 0.06) + 1
                        end
                    )
                end

                economy.OfferSeen()
                a11.Sounds.Play("Open")

                task.delay(
                    0.2,
                    function()
                        --[[
                          line: 433
                          upvalues:
                            v29 (ref,  index: 1)
                            ui (copy, index: 2)
                            v30 (copy, index: 3)
                        ]]
                        if v29.IsOpen then
                            ui.Pop(v30.burstScale.Parent, 0.7)
                        end
                    end
                )
            end),
            close = (function(a112)
                --[[
                  name: close
                  line: 439
                  upvalues:
                    a11 (copy, index: 1)
                    renderSteppedConnection (ref,  index: 2)
                    v29 (ref,  index: 3)
                ]]
                a11.SetHudHidden("GoldenOffer", false)

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                v29:Close(a112)
            end),
            select = (function()
                --[[
                  name: select
                  line: 444
                  upvalues:
                    v30 (copy, index: 1)
                ]]
                if v30.buy then
                    return v30.buy.Instance
                end

                return nil
            end)
        }
    )

    local function relayout()
        --[[
          name: relayout
          line: 448
          upvalues:
            v29 (ref,  index: 1)
            layout (copy, index: 2)
        ]]
        if v29 and v29.IsOpen then
            layout()
        end
    end

    ui.LayoutChanged:Connect(relayout)
    ui.OnResize(relayout)

    economy.Changed:Connect(
        function()
            --[[
              line: 456
              upvalues:
                v29 (ref,  index: 1)
                economy (copy, index: 2)
                menuManager (copy, index: 3)
                paint (copy, index: 4)
            ]]
            if v29 and v29.IsOpen then
                if economy.GoldenOffer() then
                    paint()
                else
                    menuManager.Close("GoldenOffer")
                end
            end
        end
    )

    task.spawn(
        function()
            --[[
              line: 465
              upvalues:
                v29 (ref,  index: 1)
                economy (copy, index: 2)
                menuManager (copy, index: 3)
                paint (copy, index: 4)
            ]]
            while true do
                task.wait(1)

                if v29 then
                    if not v29.IsOpen then
                        continue
                    end

                    if economy.GoldenOffer() then
                        paint()
                    else
                        menuManager.Close("GoldenOffer")
                    end
                end
            end
        end
    )

    local function lobbyQuiet()
        --[[
          name: lobbyQuiet
          line: 479
          upvalues:
            state (copy, index: 1)
            menuManager (copy, index: 2)
            a11 (copy, index: 3)
            localPlayer (copy, index: 4)
        ]]
        return not state.InMatch()
            and not menuManager.IsOpen()
            and not a11.IsHudHiddenFor("Reveal")
            and localPlayer:GetAttribute("WelcomeCard") ~= true
            and localPlayer:GetAttribute("Teleporting") ~= true
            and localPlayer:GetAttribute("Queued") ~= true
            and localPlayer.Character ~= nil
    end

    local function wanted()
        --[[
          name: wanted
          line: 488
          upvalues:
            economy (copy, index: 1)
            shownThisSession (ref,  index: 2)
            key (copy, index: 3)
        ]]
        return economy.GoldenOffer() ~= false and not shownThisSession and economy.CanBuy(key)
    end

    local waiting = false

    local function maybeShow()
        --[[
          name: maybeShow
          line: 493
          upvalues:
            waiting (ref,  index: 1)
            economy (copy, index: 2)
            shownThisSession (ref,  index: 3)
            key (copy, index: 4)
            lobbyQuiet (copy, index: 5)
            menuManager (copy, index: 6)
        ]]
        if waiting or economy.GoldenOffer() == false or shownThisSession or not economy.CanBuy(key) then
            return
        end

        waiting = true

        task.spawn(
            function()
                --[[
                  line: 498
                  upvalues:
                    economy (copy, index: 1)
                    shownThisSession (ref,  index: 2)
                    key (copy, index: 3)
                    lobbyQuiet (copy, index: 4)
                    menuManager (copy, index: 5)
                    waiting (ref,  index: 6)
                ]]
                local timestamp
                local canBuy, key2, economy2
                local timestamp2 = os.clock()
                key2, timestamp = key, nil

                while true do
                    local timestamp3
                    canBuy = economy.GoldenOffer() ~= false and not shownThisSession and economy2.CanBuy(key2)

                    if not canBuy then
                        break
                    end
                    if not (os.clock() - timestamp2 < 600) then
                        break
                    end

                    if lobbyQuiet() then
                        timestamp3 = timestamp or os.clock()

                        if 1.5 <= os.clock() - timestamp3 then
                            menuManager.Open("GoldenOffer")
                            break
                        end

                        economy2, key2 = economy, key
                    else
                        economy2, key2, timestamp3 = economy, key, nil
                    end

                    task.wait(0.25)
                    key2, timestamp = key, timestamp3
                end

                waiting = false
            end
        )
    end

    economy.Changed:Connect(maybeShow)
    state.PlayerStateChanged:Connect(maybeShow)

    if not waiting and economy.GoldenOffer() ~= false and not shownThisSession and economy.CanBuy(key) then
        waiting = true

        task.spawn(
            function()
                --[[
                  line: 498
                  upvalues:
                    economy (copy, index: 1)
                    shownThisSession (ref,  index: 2)
                    key (copy, index: 3)
                    lobbyQuiet (copy, index: 4)
                    menuManager (copy, index: 5)
                    waiting (ref,  index: 6)
                ]]
                local timestamp
                local canBuy, key2, economy2
                local timestamp2 = os.clock()
                key2, timestamp = key, nil

                while true do
                    local timestamp3
                    canBuy = economy.GoldenOffer() ~= false and not shownThisSession and economy2.CanBuy(key2)

                    if not canBuy then
                        break
                    end
                    if not (os.clock() - timestamp2 < 600) then
                        break
                    end

                    if lobbyQuiet() then
                        timestamp3 = timestamp or os.clock()

                        if 1.5 <= os.clock() - timestamp3 then
                            menuManager.Open("GoldenOffer")
                            break
                        end

                        economy2, key2 = economy, key
                    else
                        economy2, key2, timestamp3 = economy, key, nil
                    end

                    task.wait(0.25)
                    key2, timestamp = key, timestamp3
                end

                waiting = false
            end
        )
    end

    a11.Debug.goldenOffer = function(a130)
        --[[
          line: 520
          upvalues:
            menuManager (copy, index: 1)
            economy (copy, index: 2)
            shownThisSession (ref,  index: 3)
            waiting (ref,  index: 4)
        ]]
        if a130 == "open" then
            menuManager.Open("GoldenOffer")
        end

        return {offer = economy.GoldenOffer(), left = economy.OfferLeft() or false, discount = economy.OfferDiscount()
            or false, open = menuManager.IsOpen("GoldenOffer"), shownThisSession = shownThisSession, waiting = waiting}
    end
end

return v5