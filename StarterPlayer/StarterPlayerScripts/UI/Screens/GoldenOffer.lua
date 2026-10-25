local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local Unlocks_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Unlocks"))
local tbl_1 = {}
local fromRGB_upv_1 = Color3.fromRGB
local u1 = fromRGB_upv_1(255, 196, 60)
local u2 = fromRGB_upv_1(255, 226, 150)
local u3 = fromRGB_upv_1(92, 50, 4)
local u4 = fromRGB_upv_1(245, 52, 64)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 29
      upvalues:
        Players_upv_1 (copy, index: 1)
        Unlocks_upv_1 (copy, index: 2)
        fromRGB_upv_1 (copy, index: 3)
        u1 (copy, index: 4)
        u3 (copy, index: 5)
        u2 (copy, index: 6)
        u4 (copy, index: 7)
        RunService_upv_1 (copy, index: 8)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_1.Colors
    local Fonts_upv_1 = Theme_1.Fonts
    local MenuManager_upv_1 = a1.MenuManager
    local Economy_upv_1 = a1.Economy
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local fromOffset_upv_1 = UDim2.fromOffset
    local key_upv_1 = Unlocks_upv_1.FIRST_DROP.key
    local u5 = nil
    local DropModels_upv_1 = script.Parent.Parent:FindFirstChild("DropModels")
    local success_1, v1 = pcall(
        function()
            --[[
              line: 41
              upvalues:
                DropModels_upv_1 (copy, index: 1)
            ]]
            return require(DropModels_upv_1)
        end
    )
    if success_1 and type(v1) == "table" then
        u5 = v1
    end
    local u6 = nil
    local tbl_upv_2 = {}
    local u7 = 0
    local u8 = false
    local tbl_upv_3 = {}
    local u9 = nil
    local function buildChest(a2)
        --[[
          name: buildChest
          line: 60
          upvalues:
            u5 (ref,  index: 1)
            fromRGB_upv_1 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
        ]]
        local v2 = u5 and (u5.Golden)
        if not v2 then
            return
        end
        for _, value_upv_1 in v2.parts do
            local u10 = Instance.new("Part")
            u10.Anchored = true
            u10.CanCollide = false
            u10.CanQuery = false
            u10.CanTouch = false
            u10.CastShadow = false
            u10.Size = Vector3.new(value_upv_1.size[1], value_upv_1.size[2], value_upv_1.size[3])
            u10.Color = fromRGB_upv_1(value_upv_1.color[1], value_upv_1.color[2], value_upv_1.color[3])
            pcall(
                function()
                    --[[
                      line: 74
                      upvalues:
                        u10 (copy, index: 1)
                        value_upv_1 (copy, index: 2)
                    ]]
                    u10.Material = Enum.Material[value_upv_1.material]
                end
            )
            if value_upv_1.mesh ~= "" then
                local v3 = Instance.new("SpecialMesh")
                v3.MeshType = Enum.MeshType.FileMesh
                v3.MeshId = value_upv_1.mesh
                v3.TextureId = value_upv_1.tex
                v3.Scale = Vector3.new(value_upv_1.scale[1], value_upv_1.scale[2], value_upv_1.scale[3])
                v3.Parent = u10
            end
            u10.Parent = a2
            table.insert(tbl_upv_3, {part = u10, cf = CFrame.new(table.unpack(value_upv_1.cf))})
        end
    end
    local function close()
        --[[
          name: close
          line: 56
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("GoldenOffer")
    end
    local function build()
        --[[
          name: build
          line: 90
          upvalues:
            u6 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            close (copy, index: 5)
            u1 (copy, index: 6)
            fromRGB_upv_1 (copy, index: 7)
            u3 (copy, index: 8)
            tbl_upv_2 (copy, index: 9)
            u2 (copy, index: 10)
            buildChest (copy, index: 11)
            Fonts_upv_1 (copy, index: 12)
            u4 (copy, index: 13)
            Colors_upv_1 (copy, index: 14)
            u7 (ref,  index: 15)
            Economy_upv_1 (copy, index: 16)
            key_upv_1 (copy, index: 17)
            MenuManager_upv_1 (copy, index: 18)
        ]]
        local v4 = UI_upv_1.Window({HeaderHeight = 80, Subtitle = "Only once, only for your first purchase", Name = "GoldenOffer", Title = "LIMITED-TIME OFFER", Size = fromOffset_upv_1(780, 520), Parent = a1.Canvas.Menus, OnCloseRequested = close})
        u6 = v4
        u6.Title.TextColor3 = u1
        UI_upv_1.SelectionRing(u6.Root)
        local Content_1 = u6.Content
        local v5 = {}
        v5.Name = "Hero"
        v5.Size = UDim2.new(0, 330, 1, 0)
        v5.BackgroundColor3 = Color3.new(1, 1, 1)
        v5.ClipsDescendants = true
        v5[1], v5[2], v5[3] = UI_upv_1.Corner(14), UI_upv_1.Gradient(fromRGB_upv_1(150, 88, 10), u3, 90), UI_upv_1.Stroke(u1, 2, 0.35)
        v5.Parent = Content_1
        local v6 = UI_upv_1.new("Frame", v5)
        tbl_upv_2.hero = v6
        tbl_upv_2.rays = UI_upv_1.Image(UI_upv_1.Assets.Fx.Rays, {Name = "Rays", ImageTransparency = 0.62, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(1.9, 1.9), SizeConstraint = Enum.SizeConstraint.RelativeXX, ImageColor3 = u2, Parent = v6})
        UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.35, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1.1, 0.8), ImageColor3 = fromRGB_upv_1(255, 214, 120), Parent = v6})
        local v7 = UI_upv_1.new("ViewportFrame", {LightDirection = Vector3.new(0.44999998807907104, -1, 0.550000011920929), Name = "Chest", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX, Ambient = fromRGB_upv_1(160, 150, 140), LightColor = fromRGB_upv_1(255, 244, 228), Parent = v6})
        v5 = Instance.new("Camera")
        v5.FieldOfView = 28
        v5.CFrame = CFrame.lookAt(Vector3.new(0, 4.599999904632568, -15.5), Vector3.new(0, 2.200000047683716, 0))
        v5.Parent = v7
        v7.CurrentCamera = v5
        buildChest(v7)
        UI_upv_1.new("TextLabel", {Name = "Caption", Text = "1 \195\151 GOLDEN DROP", FontFace = Fonts_upv_1.Heavy, TextSize = 18, TextColor3 = u2, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), Size = UDim2.new(1, -20, 0, 22), [1] = UI_upv_1.TextStroke(u3, 2, 0.2), Parent = v6})
        v5 = UI_upv_1.new("Frame", {Name = "Burst", ZIndex = 5, Rotation = -12, AnchorPoint = Vector2.new(0.5, 0.5), Position = fromOffset_upv_1(70, 70), Size = fromOffset_upv_1(112, 112), Parent = v6})
        for n_1 = 0, 1 do
            local tbl_4 = {}
            tbl_4.Name = "Star" .. n_1
            tbl_4.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_4.Position = UDim2.fromScale(0.5, 0.5)
            tbl_4.Size = UDim2.fromScale(0.74, 0.74)
            tbl_4.Rotation = n_1 * 45
            tbl_4.BackgroundColor3 = u4
            tbl_4.ZIndex = 5
            tbl_4[1], tbl_4[2] = UI_upv_1.Corner(8), UI_upv_1.Stroke(fromRGB_upv_1(255, 170, 176), 2, 0.25)
            tbl_4.Parent = v5
            UI_upv_1.new("Frame", tbl_4)
        end
        tbl_upv_2.burstScale = UI_upv_1.new("UIScale", {Parent = v5})
        tbl_upv_2.burstPct = UI_upv_1.new("TextLabel", {Name = "Pct", Text = "SALE", FontFace = Fonts_upv_1.Display, TextSize = 30, TextColor3 = Colors_upv_1.Text, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, -6), Size = UDim2.fromScale(1, 0.4), ZIndex = 6, [1] = UI_upv_1.TextStroke(fromRGB_upv_1(120, 10, 20), 2, 0.2), Parent = v5})
        tbl_upv_2.burstOff = UI_upv_1.new("TextLabel", {Text = "OFF", Name = "Off", ZIndex = 6, TextSize = 15, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 18), Size = UDim2.fromScale(1, 0.2), Parent = v5})
        local v8 = UI_upv_1.new("Frame", {Name = "Offer", Position = fromOffset_upv_1(352, 0), Size = UDim2.new(1, -352, 1, 0), Parent = Content_1})
        tbl_upv_2.col = v8
        local v9 = UI_upv_1.List(Enum.FillDirection.Vertical, 10)
        v9.Parent = v8
        tbl_upv_2.list = v9
        tbl_upv_2.tag = UI_upv_1.Pill("ONE-TIME OFFER", u4, {LayoutOrder = 1, Transparency = 0, Name = "Tag", Height = 28, TextSize = 14, Parent = v8})
        tbl_upv_2.title = UI_upv_1.DisplayText({StrokeThickness = 0, Text = "GOLDEN DROP", Name = "Name", LayoutOrder = 2, TextSize = 42, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, 0, 0, 44), Parent = v8})
        tbl_upv_2.line = UI_upv_1.new("TextLabel", {LayoutOrder = 3, Text = "", Name = "Line", TextWrapped = true, TextSize = 16, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 42), Parent = v8})
        local v10 = UI_upv_1.new("Frame", {LayoutOrder = 4, Name = "Prices", Size = UDim2.new(1, 0, 0, 56), Parent = v8})
        tbl_upv_2.prices = v10
        tbl_upv_2.was = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Was", TextSize = 28, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.X, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 2), Size = UDim2.new(0, 0, 0, 30), Parent = v10})
        tbl_upv_2.slash = UI_upv_1.new("Frame", {Name = "Slash", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 8, 0, 3), Rotation = -14, BackgroundColor3 = u4, ZIndex = 3, [1] = UI_upv_1.Corner(2), Parent = tbl_upv_2.was})
        tbl_upv_2.now = UI_upv_1.DisplayText({StrokeThickness = 0, Text = "", Name = "Now", TextSize = 50, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 110, 0.5, 0), Size = UDim2.new(0, 160, 0, 54), Parent = v10})
        local tbl_5 = {}
        tbl_5.Name = "Timer"
        tbl_5.Size = UDim2.new(1, 0, 0, 64)
        tbl_5.BackgroundColor3 = u4
        tbl_5.BackgroundTransparency = 0.86
        tbl_5.LayoutOrder = 5
        tbl_5[1], tbl_5[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(u4, 1.5, 0.55)
        tbl_5.Parent = v8
        local v11 = UI_upv_1.new("Frame", tbl_5)
        tbl_upv_2.timer = v11
        UI_upv_1.Glyph("clock", 26, fromRGB_upv_1(255, 140, 146), {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Parent = v11})
        UI_upv_1.new("TextLabel", {Text = "ENDS IN", Name = "Ends", TextSize = 14, FontFace = Fonts_upv_1.Heavy, TextColor3 = fromRGB_upv_1(255, 160, 166), TextXAlignment = Enum.TextXAlignment.Left, Position = fromOffset_upv_1(50, 10), Size = fromOffset_upv_1(80, 18), Parent = v11})
        tbl_upv_2.left = UI_upv_1.new("TextLabel", {Text = "", Name = "Left", TextSize = 28, FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = fromOffset_upv_1(50, 28), Size = fromOffset_upv_1(150, 30), Parent = v11})
        UI_upv_1.new("TextLabel", {Text = "Then this price is gone for good.", Name = "Gone", TextWrapped = true, TextSize = 13, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.new(1, -220, 1, -12), Parent = v11})
        tbl_upv_2.buy = UI_upv_1.Button({LayoutOrder = 6, Name = "Buy", Style = "Success", Text = "", TextSize = 22, Size = UDim2.new(1, 0, 0, 60), Parent = v8})
        tbl_upv_2.buy.Label.RichText = true
        tbl_upv_2.buy.Activated:Connect(
            function()
                --[[
                  line: 321
                  upvalues:
                    u7 (ref,  index: 1)
                    Economy_upv_1 (copy, index: 2)
                    key_upv_1 (copy, index: 3)
                ]]
                if not (os.clock() - u7 > 0.4) then
                    return
                end
                Economy_upv_1.Buy(key_upv_1)
            end
        )
        local v12 = UI_upv_1.new("Frame", {Name = "Row", Size = UDim2.new(1, 0, 0, 46), LayoutOrder = 7, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10), Parent = v8})
        tbl_upv_2.row = v12
        tbl_upv_2.odds = UI_upv_1.Button({LayoutOrder = 1, Name = "Odds", Style = "Dark", Text = "VIEW ODDS", TextSize = 16, Size = UDim2.new(0.5, -5, 1, 0), Parent = v12})
        tbl_upv_2.odds.Activated:Connect(
            function()
                --[[
                  line: 329
                  upvalues:
                    u7 (ref,  index: 1)
                    MenuManager_upv_1 (copy, index: 2)
                ]]
                if not (os.clock() - u7 > 0.4) then
                    return
                end
                MenuManager_upv_1.Close("GoldenOffer")
                task.defer(
                    function()
                        --[[
                          line: 332
                          upvalues:
                            MenuManager_upv_1 (copy, index: 1)
                        ]]
                        MenuManager_upv_1.Open("Collection", {odds = true})
                    end
                )
            end
        )
        tbl_upv_2.later = UI_upv_1.Button({LayoutOrder = 2, Name = "Later", Style = "Dark", Text = "NOT NOW", TextSize = 16, Size = UDim2.new(0.5, -5, 1, 0), Parent = v12})
        tbl_upv_2.later.Activated:Connect(
            function()
                --[[
                  line: 338
                  upvalues:
                    u7 (ref,  index: 1)
                    MenuManager_upv_1 (copy, index: 2)
                ]]
                if not (os.clock() - u7 > 0.4) then
                    return
                end
                MenuManager_upv_1.Close("GoldenOffer")
            end
        )
    end
    local function paint()
        --[[
          name: paint
          line: 345
          upvalues:
            u6 (ref,  index: 1)
            Economy_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            key_upv_1 (copy, index: 4)
            Unlocks_upv_1 (copy, index: 5)
        ]]
        if not u6 then
            return
        end
        local v13 = Economy_upv_1.DropInfo("golden")
        local v14 = tonumber(v13.stacks) or 4
        local num_1 = tonumber(v13.min)
        local num_2 = tonumber(v13.max)
        if (num_1) and (num_2) then
            v13 = math.floor(((v14 * (num_1 + num_2)) / 2) + 0.5)
        else
            v13 = 60
        end
        tbl_upv_2.line.Text = string.format("About %d item shards in %d big stacks. One is always an item you don't own yet.", v13, v14)
        local v15 = Economy_upv_1.OfferDiscount()
        local burstPct_1 = tbl_upv_2.burstPct
        burstPct_1.Text = not v15 and "SALE" or string.format("-%d%%", v15)
        tbl_upv_2.burstOff.Visible = v15 ~= nil
        local v17 = Economy_upv_1.Price("drop_golden")
        local v18 = Economy_upv_1.Price(key_upv_1)
        local was_1 = tbl_upv_2.was
        was_1.Text = not v17 and "" or string.format("%s %d", Economy_upv_1.ROBUX, v17)
        tbl_upv_2.slash.Visible = v17 ~= nil
        local now_1 = tbl_upv_2.now
        now_1.Text = not v18 and Economy_upv_1.ROBUX .. " \226\128\166" or string.format("%s %d", Economy_upv_1.ROBUX, v18)
        local now_2 = tbl_upv_2.now
        local v21 = (v17 and (math.max(tbl_upv_2.was.TextBounds.X, 60) + 22)) or 0
        now_2.Position = UDim2.new(0, v21, 0.5, 0)
        local v22 = Economy_upv_1.Pending(key_upv_1)
        local buy_1 = tbl_upv_2.buy
        local v23 = (v22 and "\226\128\166") or (string.format("BUY NOW  <font color=\"#FFFFFF\">%s</font> %s", Economy_upv_1.ROBUX, Economy_upv_1.PriceAmount(key_upv_1)))
        buy_1:SetText(v23)
        tbl_upv_2.buy:SetEnabled(not v22)
        local v24 = Economy_upv_1.OfferLeft() or (Unlocks_upv_1.FIRST_DROP.duration)
        tbl_upv_2.left.Text = Economy_upv_1.FormatLeft(v24)
    end
    local function layout()
        --[[
          name: layout
          line: 369
          upvalues:
            UI_upv_1 (copy, index: 1)
            u6 (ref,  index: 2)
            fromOffset_upv_1 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            paint (copy, index: 5)
        ]]
        local v25 = UI_upv_1.CanvasSize()
        local v26 = UI_upv_1.TopInset()
        local v27 = UI_upv_1.Compact or (v25.Y - v26 < 600)
        local v28 = math.floor(math.clamp(v25.X - 24, 360, 780))
        local v29 = v25.Y - v26 - 12
        local v30
        if v27 then
            v30 = 440
        else
            v30 = 520
        end
        local v31 = math.floor(math.clamp(v29, 320, v30))
        local Holder_1 = u6.Holder
        Holder_1.Size = fromOffset_upv_1(v28, v31)
        local v32 = (v27 and 270) or 330
        tbl_upv_2.hero.Size = UDim2.new(0, v32, 1, 0)
        tbl_upv_2.col.Position = fromOffset_upv_1(v32 + 22, 0)
        tbl_upv_2.col.Size = UDim2.new(1, -(v32 + 22), 1, 0)
        local list_1 = tbl_upv_2.list
        list_1.Padding = UDim.new(0, (v27 and 6) or 10)
        tbl_upv_2.title.TextSize = (v27 and 34) or 42
        local title_1 = tbl_upv_2.title
        title_1.Size = UDim2.new(1, 0, 0, (v27 and 36) or 44)
        tbl_upv_2.line.TextSize = (v27 and 14) or 16
        local line_1 = tbl_upv_2.line
        line_1.Size = UDim2.new(1, 0, 0, (v27 and 36) or 42)
        local prices_1 = tbl_upv_2.prices
        prices_1.Size = UDim2.new(1, 0, 0, (v27 and 46) or 56)
        tbl_upv_2.now.TextSize = (v27 and 40) or 50
        local timer_1 = tbl_upv_2.timer
        timer_1.Size = UDim2.new(1, 0, 0, (v27 and 56) or 64)
        local Instance_1 = tbl_upv_2.buy.Instance
        Instance_1.Size = UDim2.new(1, 0, 0, (v27 and 52) or 60)
        local row_1 = tbl_upv_2.row
        row_1.Size = UDim2.new(1, 0, 0, (v27 and 40) or 46)
        u6.Refit()
        paint()
    end
    local function startSpin()
        --[[
          name: startSpin
          line: 395
          upvalues:
            u9 (ref,  index: 1)
            RunService_upv_1 (copy, index: 2)
        ]]
        if u9 then
            return
        end
        local _ = os.clock()
        local v33 = RunService_upv_1.RenderStepped:Connect(function() end)
        u9 = v33
    end
    local function stopSpin()
        --[[
          name: stopSpin
          line: 413
          upvalues:
            u9 (ref, index: 1)
        ]]
        if not u9 then
            return
        end
        u9:Disconnect()
        u9 = nil
    end
    local tbl_6 = {}
    function tbl_6.open()
        --[[
          name: open
          line: 421
          upvalues:
            u6 (ref,  index: 1)
            build (copy, index: 2)
            u7 (ref,  index: 3)
            u8 (ref,  index: 4)
            a1 (copy, index: 5)
            layout (copy, index: 6)
            u9 (ref,  index: 7)
            RunService_upv_1 (copy, index: 8)
            tbl_upv_3 (copy, index: 9)
            tbl_upv_2 (copy, index: 10)
            Economy_upv_1 (copy, index: 11)
            UI_upv_1 (copy, index: 12)
        ]]
        if not (u6) then
            build()
        end
        u7 = os.clock()
        u8 = true
        a1.SetHudHidden("GoldenOffer", true)
        layout()
        u6:Open()
        if not (u9) then
            local u11 = os.clock()
            local v34 = RunService_upv_1.RenderStepped:Connect(
                function()
                    --[[
                      line: 400
                      upvalues:
                        u11 (copy, index: 1)
                        tbl_upv_3 (copy, index: 2)
                        tbl_upv_2 (copy, index: 3)
                    ]]
                    local v35 = os.clock() - u11
                    local v36 = math.sin(v35 * 0.9) * 0.4886921905584123 + 0.4188790204786391
                    local v37 = CFrame.new(0, math.sin(v35 * 1.7) * 0.12, 0) * CFrame.Angles(0, v36, 0)
                    for _, value_2 in tbl_upv_3 do
                        value_2.part.CFrame = v37 * value_2.cf
                    end
                    tbl_upv_2.rays.Rotation = (v35 * 10) % 360
                    tbl_upv_2.burstScale.Scale = ((math.max(0, math.sin(v35 * 5)) ^ 3) * 0.06) + 1
                end
            )
            u9 = v34
        end
        Economy_upv_1.OfferSeen()
        a1.Sounds.Play("Open")
        task.delay(
            0.2,
            function()
                --[[
                  line: 433
                  upvalues:
                    u6 (ref,  index: 1)
                    UI_upv_1 (copy, index: 2)
                    tbl_upv_2 (copy, index: 3)
                ]]
                if not u6.IsOpen then
                    return
                end
                UI_upv_1.Pop(tbl_upv_2.burstScale.Parent, 0.7)
            end
        )
    end
    function tbl_6.close(a3)
        --[[
          name: close
          line: 439
          upvalues:
            a1 (copy, index: 1)
            u9 (ref,  index: 2)
            u6 (ref,  index: 3)
        ]]
        a1.SetHudHidden("GoldenOffer", false)
        if u9 then
            u9:Disconnect()
            u9 = nil
        end
        u6:Close(a3)
    end
    function tbl_6.select()
        --[[
          name: select
          line: 444
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        if tbl_upv_2.buy then
            return tbl_upv_2.buy.Instance
        end
        return nil
    end
    MenuManager_upv_1.Register("GoldenOffer", tbl_6)
    local function relayout()
        --[[
          name: relayout
          line: 448
          upvalues:
            u6 (ref,  index: 1)
            layout (copy, index: 2)
        ]]
        if not u6 or not u6.IsOpen then
            return
        end
        layout()
    end
    UI_upv_1.LayoutChanged:Connect(relayout)
    UI_upv_1.OnResize(relayout)
    Economy_upv_1.Changed:Connect(
        function()
            --[[
              line: 456
              upvalues:
                u6 (ref,  index: 1)
                Economy_upv_1 (copy, index: 2)
                MenuManager_upv_1 (copy, index: 3)
                paint (copy, index: 4)
            ]]
            if not u6 or not u6.IsOpen then
                return
            end
            if Economy_upv_1.GoldenOffer() then
                paint()
            else
                MenuManager_upv_1.Close("GoldenOffer")
            end
        end
    )
    task.spawn(
        function()
            --[[
              line: 465
              upvalues:
                u6 (ref,  index: 1)
                Economy_upv_1 (copy, index: 2)
                MenuManager_upv_1 (copy, index: 3)
                paint (copy, index: 4)
            ]]
            repeat
                task.wait(1)
            until u6
            if not u6.IsOpen then
                return
            end
            if Economy_upv_1.GoldenOffer() then
                paint()
            else
                MenuManager_upv_1.Close("GoldenOffer")
            end
        end
    )
    local function wanted()
        --[[
          name: wanted
          line: 488
          upvalues:
            Economy_upv_1 (copy, index: 1)
            u8 (ref,  index: 2)
            key_upv_1 (copy, index: 3)
        ]]
        local v38 = (Economy_upv_1.GoldenOffer() ~= false) and (not u8 and (Economy_upv_1.CanBuy(key_upv_1)))
        return v38
    end
    local u12 = false
    local function maybeShow()
        --[[
          name: maybeShow
          line: 493
          upvalues:
            u12 (ref,  index: 1)
            Economy_upv_1 (copy, index: 2)
            u8 (ref,  index: 3)
            key_upv_1 (copy, index: 4)
        ]]
        if not (u12) then
            local v39 = (Economy_upv_1.GoldenOffer() ~= false) and (not u8 and (Economy_upv_1.CanBuy(key_upv_1)))
            if not v39 then
                return
            end
            u12 = true
            task.spawn(function() end)
        end
    end
    Economy_upv_1.Changed:Connect(maybeShow)
    State_upv_1.PlayerStateChanged:Connect(maybeShow)
    local function lobbyQuiet()
        --[[
          name: lobbyQuiet
          line: 479
          upvalues:
            State_upv_1 (copy, index: 1)
            MenuManager_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
        ]]
        local v40 = not State_upv_1.InMatch() and (not MenuManager_upv_1.IsOpen() and (not a1.IsHudHiddenFor("Reveal") and ((LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true) and ((LocalPlayer_upv_1:GetAttribute("Teleporting") ~= true) and ((LocalPlayer_upv_1:GetAttribute("Queued") ~= true) and (LocalPlayer_upv_1.Character ~= nil))))))
        return v40
    end
    if not (u12) then
        local v41 = (Economy_upv_1.GoldenOffer() ~= false) and (not u8 and (Economy_upv_1.CanBuy(key_upv_1)))
        if v41 then
            u12 = true
            task.spawn(
                function()
                    --[[
                      line: 498
                      upvalues:
                        Economy_upv_1 (copy, index: 1)
                        u8 (ref,  index: 2)
                        key_upv_1 (copy, index: 3)
                        lobbyQuiet (copy, index: 4)
                        MenuManager_upv_1 (copy, index: 5)
                        u12 (ref,  index: 6)
                    ]]
                    local v42 = nil
                    local v43 = os.clock()
                    local v44 = nil
                    while true do
                        v44 = false
                        if Economy_upv_1.GoldenOffer() ~= false then
                            v44 = not u8 and (Economy_upv_1.CanBuy(key_upv_1))
                        end
                        if v44 and os.clock() - v43 < 600 then
                            if not (lobbyQuiet()) then
                                v42 = nil
                                task.wait(0.25)
                                continue
                            end
                            v44 = v42 or (os.clock())
                            v42 = v44
                            if os.clock() - v42 >= 1.5 then
                                break
                            else
                                task.wait(0.25)
                                continue
                            end
                        end
                        u12 = false
                        return
                    end
                    MenuManager_upv_1.Open("GoldenOffer")
                end
            )
        end
    end
    a1.Debug.goldenOffer = function(a4)
        --[[
          line: 520
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
            Economy_upv_1 (copy, index: 2)
            u8 (ref,  index: 3)
            u12 (ref,  index: 4)
        ]]
        if a4 == "open" then
            MenuManager_upv_1.Open("GoldenOffer")
        end
        local tbl_7 = {}
        tbl_7.offer = Economy_upv_1.GoldenOffer()
        tbl_7.left = Economy_upv_1.OfferLeft() or false
        tbl_7.discount = Economy_upv_1.OfferDiscount() or false
        tbl_7.open = MenuManager_upv_1.IsOpen("GoldenOffer")
        tbl_7.shownThisSession = u8
        tbl_7.waiting = u12
        return tbl_7
    end
end
return tbl_1