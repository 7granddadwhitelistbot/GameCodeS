local v1 = {}
local color3FromRGB = Color3.fromRGB

function v1.Init(a3)
    --[[
      name: Init
      line: 21
      upvalues:
        color3FromRGB (copy, index: 1)
    ]]
    local ui = a3.UI
    local theme = a3.Theme
    local state = a3.State
    local weaponInfo = a3.WeaponInfo
    local weaponIcon = a3.WeaponIcon
    local economy = a3.Economy
    local colors = theme.Colors
    local fonts = theme.Fonts
    local success = colors.Success
    local parent = ui.new("Frame", {Name = "Economy", Size = UDim2.fromScale(1, 1), Parent = a3.Canvas.HUD})
    local parent2 = ui.new("Frame", {Name = "Collection", Visible = false, Size = UDim2.fromOffset(340, 70), Parent = parent})
    local focus = nil
    local button = ui.Button
    local v17 = {
        Name = "Button",
        Text = "COLLECTION",
        TextSize = 26,
        Style = "Dark",
        Gap = 6,
        Size = UDim2.fromScale(1, 1),
        Icon = ui.Image((ui.Assets.Icons.CollectionGem or ui.Assets.Fx.Gem), {Name = "Icon", Size = UDim2.fromOffset(38, 38), ScaleType = Enum.ScaleType.Fit}),
        Parent = parent2,
        OnClick = (function()
            --[[
              name: OnClick
              line: 46
              upvalues:
                a3 (copy, index: 1)
                focus (ref,  index: 2)
            ]]
            local open = a3.MenuManager.Open
            local v19 = focus and {focus = focus} or nil
            open("Collection", v19)
        end)
    }
    local label = button(v17).Label
    label.RichText = true
    label.LineHeight = 0.92
    local parent3 = ui.new("Frame", {Name = "Ready", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -8, 0, 8), Size = UDim2.fromOffset(28, 28), BackgroundColor3 = success, Visible = false, ZIndex = 6, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Void, 2, 0.15)), Parent = parent2})
    local ui2 = ui.new("TextLabel", {Name = "Count", Text = "1", TextSize = 17, ZIndex = 6, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent3})
    local scaleObj = ui.GetScaleObj(parent3, "Pulse")
    local v24 = -1

    local function paintCard()
        --[[
          name: paintCard
          line: 77
          upvalues:
            parent2 (copy, index: 1)
            economy (copy, index: 2)
            focus (ref,  index: 3)
            theme (copy, index: 4)
            success (copy, index: 5)
            a3 (copy, index: 6)
            label (copy, index: 7)
            parent3 (copy, index: 8)
            ui2 (copy, index: 9)
            v24 (ref,  index: 10)
            ui (copy, index: 11)
        ]]
        local v26
        parent2.Visible = economy.HasData()

        if not parent2.Visible then
            return
        end

        local v27 = economy.ReadyList()
        focus = v27[1]
        local count = 0
        local count2 = 0

        for _, v31 in economy.Unlocks.AllIds() do
            count2 += 1

            if economy.Owns(v31) then
                count += 1
            end
        end

        if not (0 < #v27) then
            v26 = count2 <= count and 0 < count2 and "<font size=\"14\" color=\"#BAC0CE\">EVERY ITEM FOUND</font>"
                or string.format("<font size=\"14\" color=\"#BAC0CE\">%d / %d ITEMS</font>", count, count2)
        else
            local stringFormat = string.format
            local v33 = theme.Lighten(success, 0.2):ToHex()
            local v34 = #v27 == 1 and "1 UPGRADE READY" or string.format("%d UPGRADES READY", #v27)
            v26 = stringFormat("<font size=\"14\" color=\"#%s\">%s</font>", v33, v34)
        end

        a3.Loc.Rich(label, "COLLECTION\n" .. v26)
        parent3.Visible = 0 < #v27
        ui2.Text = tostring(#v27)

        if v24 < #v27 and 0 <= v24 then
            ui.Pop(parent3, 0.6)
        end

        v24 = #v27
    end

    ui.Every(
        parent3,
        0.03333333333333333,
        function()
            --[[
              line: 108
              upvalues:
                parent3 (copy, index: 1)
                parent2 (copy, index: 2)
                scaleObj (copy, index: 3)
            ]]
            if parent3.Visible and parent2.Visible then
                scaleObj.Scale = (((math.sin(os.clock() * 4.2) * 0.5) + 0.5) * 0.1) + 1
            end
        end
    )

    local parent4 = ui.new("Frame", {Name = "StreakBadge", Size = UDim2.fromScale(1, 1), BackgroundColor3 = theme.Colors.Inset, BackgroundTransparency = 0.15, Visible = false, ZIndex = 3, ui.Corner(theme.Radius.Pill), ui.Stroke(color3FromRGB(255, 150, 60), 1, 0.45), ui.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)})
    ui.Image(ui.Assets.Icons.Fire, {Name = "Flame", LayoutOrder = 1, ZIndex = 3, Size = UDim2.fromOffset(17, 17), Parent = parent4})
    local ui3 = ui.new("TextLabel", {Name = "Streak", Text = "0", TextSize = 16, LayoutOrder = 2, ZIndex = 3, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Display, TextColor3 = color3FromRGB(255, 196, 120), Parent = parent4})
    local v37 = -1

    local function streakNow()
        --[[
          name: streakNow
          line: 141
          upvalues:
            state (copy, index: 1)
        ]]
        local v39 = state.Get("Streak")

        if type(v39) ~= "number" then
            local stats = state.Profile.stats
            v39 = type(stats) == "table" and stats.streak or 0
        end

        return (math.max(0, (math.floor(v39))))
    end

    local function paintBadge()
        --[[
          name: paintBadge
          line: 149
          upvalues:
            a3 (copy, index: 1)
            parent4 (copy, index: 2)
            state (copy, index: 3)
            ui3 (copy, index: 4)
            v37 (ref,  index: 5)
            ui (copy, index: 6)
        ]]
        local streakSlot = a3.LobbyHud and a3.LobbyHud.StreakSlot
        if not streakSlot then
            return
        end

        if parent4.Parent ~= streakSlot then
            parent4.Parent = streakSlot
        end

        local v43 = state.Get("Streak")

        if type(v43) ~= "number" then
            local stats = state.Profile.stats
            v43 = type(stats) == "table" and stats.streak or 0
        end

        local v45 = math.max(0, (math.floor(v43)))
        local visible = 2 <= v45
        parent4.Visible = visible
        ui3.Text = tostring(v45)

        if visible and 0 <= v37 and v37 < v45 then
            ui.Pop(parent4, 1.4)
        end

        v37 = v45
    end

    local parent5 = ui.new("Frame", {Name = "StreakRestore", Visible = false, Size = UDim2.fromOffset(340, 50), Parent = parent})
    local v48 = ui.Button({Name = "Restore", Text = "RESTORE", TextSize = 20, Style = "Dark", Radius = 12, Size = UDim2.new(1, -58, 1, 0), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, -29, 0.5, 0), Icon = ui.Image(ui.Assets.Icons.Fire, {Size = UDim2.fromOffset(26, 26)}), Parent = parent5})
    v48.Instance.AnchorPoint = Vector2.new(0.5, 0.5)
    v48.Instance.Position = UDim2.new(0.5, -29, 0.5, 0)
    v48.Label.RichText = true
    local v49 = ui.Pill("", colors.SuccessDark, {Name = "Price", Height = 26, TextSize = 15, LayoutOrder = 3, Transparency = 0})
    v49.Parent = v48.Content
    local v50 = ui.IconButton({Name = "Dismiss", IconName = "cross", IconScale = 0.36, Transparency = 0.35, Sound = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, -1), Size = UDim2.fromOffset(42, 42), Color = colors.Raised, Parent = parent5})
    local v51 = nil

    local function paintRestore()
        --[[
          name: paintRestore
          line: 204
          upvalues:
            economy (copy, index: 1)
            v51 (ref,  index: 2)
            parent5 (copy, index: 3)
            v48 (copy, index: 4)
            v49 (copy, index: 5)
        ]]
        local text
        local v54 = economy.StreakOffer()
        local visible = v54 ~= false and v51 ~= v54.expiresAt
        parent5.Visible = visible

        if not visible then
            return
        end

        local v56 = economy.Pending(v54.key)

        if v56 then
            text = "RESTORING…"
        else
            text = string.format("RESTORE <font color=\"#FFC478\">%d</font>", v54.lost)
        end

        v48:SetText(text)
        v49.Visible = not v56
        v49:FindFirstChild("Text").Text = economy.PriceText(v54.key)
        v48:SetEnabled(not v56)
    end

    v48.Activated:Connect(
        function()
            --[[
              line: 217
              upvalues:
                economy (copy, index: 1)
            ]]
            if const v57 = economy.StreakOffer() then
                economy.Buy(v57.key)
            end
        end
    )

    v50.Activated:Connect(
        function()
            --[[
              line: 223
              upvalues:
                economy (copy, index: 1)
                v51 (ref,  index: 2)
                paintRestore (copy, index: 3)
            ]]
            v51 = if const v58 = economy.StreakOffer() then v58.expiresAt else nil
            paintRestore()
        end
    )

    local backgroundColor3 = color3FromRGB(245, 52, 64)
    local parent6 = ui.new("Frame", {Name = "GoldenOffer", Visible = false, Size = UDim2.fromOffset(340, 60), Parent = parent})
    local parent7 = ui.new("Frame", {Name = "Body", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Parent = parent6})
    local parent8 = ui.new("TextButton", {Name = "Button", Text = "", AutoButtonColor = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, ui.Corner(12), ui.Gradient(color3FromRGB(178, 106, 14), color3FromRGB(98, 52, 6), 90), (ui.Stroke(color3FromRGB(255, 204, 90), 2, 0.15)), Parent = parent7})
    local ui4 = ui.new("Frame", {Name = "Sweep", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(-0.4, 0.5), Size = UDim2.new(0, 70, 2, 0), Rotation = 20, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, (ui.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0, NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.72), NumberSequenceKeypoint.new(1, 1)}))), Parent = parent8})
    local v64 = ui.Image((ui.Assets.Icons.CollectionGem or ui.Assets.Fx.Gem), {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(40, 40), ScaleType = Enum.ScaleType.Fit, Parent = parent8})
    local ui5 = ui.new("TextLabel", {Name = "Title", Text = "GOLDEN DROP", FontFace = fonts.Heavy, TextSize = 20, TextColor3 = color3FromRGB(255, 226, 150), TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(58, 7), Size = UDim2.new(1, -150, 0, 24), (ui.TextStroke(color3FromRGB(70, 36, 2), 1.5, 0.3)), Parent = parent8})
    local ui6 = ui.new("TextLabel", {Name = "Left", Text = "", RichText = true, TextSize = 14, FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(58, 31), Size = UDim2.new(1, -150, 0, 20), Parent = parent8})
    local parent9 = ui.new("TextLabel", {Name = "Was", Text = "", RichText = true, TextSize = 14, FontFace = fonts.Heavy, TextColor3 = color3FromRGB(236, 206, 150), TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 8), Size = UDim2.fromOffset(90, 18), Parent = parent8})
    local ui7 = ui.new("TextLabel", {Name = "Now", Text = "", FontFace = fonts.Display, TextSize = 24, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 26), Size = UDim2.fromOffset(90, 26), (ui.TextStroke(color3FromRGB(70, 36, 2), 1.5, 0.3)), Parent = parent8})
    local parent10 = ui.Pill("", backgroundColor3, {Name = "Tag", Height = 28, TextSize = 16, Transparency = 0, PadX = 9, ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 16, 0, 2)})
    parent10.Rotation = -10
    parent10.Parent = parent7
    ui.new("Frame", {Name = "Slash", Rotation = -14, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -22, 0.5, 0), Size = UDim2.fromOffset(46, 2), BackgroundColor3 = backgroundColor3, Parent = parent9})
    local ui8 = ui.new("UIScale", {Parent = parent7})
    local ui9 = ui.new("UIScale", {Parent = parent10})

    parent8.MouseEnter:Connect(
        function()
            --[[
              line: 275
              upvalues:
                ui (copy, index: 1)
                ui8 (copy, index: 2)
                theme (copy, index: 3)
            ]]
            if not ui.Touch then
                ui.Tween(ui8, theme.Tween.Fast, {Scale = 1.03})
            end
        end
    )

    parent8.MouseLeave:Connect(
        function()
            --[[
              line: 280
              upvalues:
                ui (copy, index: 1)
                ui8 (copy, index: 2)
                theme (copy, index: 3)
            ]]
            ui.Tween(ui8, theme.Tween.Fast, {Scale = 1})
        end
    )

    parent8.Activated:Connect(
        function()
            --[[
              line: 283
              upvalues:
                a3 (copy, index: 1)
            ]]
            a3.Sounds.Play("Click")
            a3.MenuManager.Open("GoldenOffer")
        end
    )

    local function paintSale()
        --[[
          name: paintSale
          line: 287
          upvalues:
            economy (copy, index: 1)
            parent6 (copy, index: 2)
            a3 (copy, index: 3)
            ui6 (copy, index: 4)
            parent9 (copy, index: 5)
            ui7 (copy, index: 6)
            parent10 (copy, index: 7)
        ]]
        local v73 = economy.GoldenOffer()
        local v74 = economy.OfferLeft()
        local visible = v73 ~= false and v73.state == "active" and v74 ~= nil
        parent6.Visible = visible

        if not visible then
            return
        end

        a3.Loc.Rich(ui6, string.format("<font color=\"#FFB4B8\">ENDS IN</font>  %s", economy.FormatLeft(v74)))
        local v76 = economy.Price("drop_golden")
        local v77 = economy.Price(v73.key)
        parent9.Text = not v76 and "" or string.format("<s>%s %d</s>", economy.ROBUX, v76)
        ui7.Text = if v77 then string.format("%s %d", economy.ROBUX, v77) else economy.ROBUX .. " …"
        local v78 = economy.OfferDiscount()
        parent10.Visible = v78 ~= nil

        if v78 then
            parent10:FindFirstChild("Text").Text = string.format("-%d%%", v78)
        end
    end

    task.spawn(
        function()
            --[[
              line: 307
              upvalues:
                parent (copy, index: 1)
                parent6 (copy, index: 2)
                ui4 (copy, index: 3)
                ui (copy, index: 4)
                ui9 (copy, index: 5)
            ]]
            while parent.Parent do
                task.wait(3.2)

                if parent6.Visible and parent.Visible then
                    ui4.Position = UDim2.fromScale(-0.4, 0.5)
                    ui.Tween(ui4, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.fromScale(1.4, 0.5)})

                    task.delay(
                        0.45,
                        function()
                            --[[
                              line: 314
                              upvalues:
                                ui9 (copy, index: 1)
                                ui (copy, index: 2)
                            ]]
                            ui9.Scale = 1.18
                            local v79 = {Scale = 1}
                            ui.Tween(ui9, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v79)
                        end
                    )
                end
            end
        end
    )

    local function layout()
        --[[
          name: layout
          line: 323
          upvalues:
            ui (copy, index: 1)
            a3 (copy, index: 2)
            parent2 (copy, index: 3)
            parent5 (copy, index: 4)
            label (copy, index: 5)
            v48 (copy, index: 6)
            parent6 (copy, index: 7)
            v64 (copy, index: 8)
            ui5 (copy, index: 9)
            ui6 (copy, index: 10)
            parent9 (copy, index: 11)
            ui7 (copy, index: 12)
            paintBadge (copy, index: 13)
        ]]
        local position, position2
        local position3
        local ui2
        local v85 = ui.TopInset()
        local lobbyColumn = a3.LobbyColumn

        if const v87 = if ui.Compact and lobbyColumn and lobbyColumn.Row then lobbyColumn.Row() else nil then
            parent2.AnchorPoint = Vector2.new(0, 0.5)
            position = UDim2.fromOffset(v87.cardX, v87.y)
            parent2.Size = UDim2.fromOffset(v87.cardW, v87.h)
            parent5.AnchorPoint = Vector2.new(0, 0)
            position2 = UDim2.fromOffset(v87.restoreX, v87.restoreY)
            parent5.Size = UDim2.fromOffset(v87.restoreW, 46)
            label.TextSize = 24
            v48.Label.TextSize = 17
        elseif ui.Compact then
            parent2.AnchorPoint = Vector2.new(0, 0)
            position = UDim2.fromOffset(16, v85 + 158)
            parent2.Size = UDim2.fromOffset(254, 62)
            parent5.AnchorPoint = Vector2.new(0, 0)
            position2 = UDim2.fromOffset(16, v85 + 228)
            parent5.Size = UDim2.fromOffset(254, 46)
            label.TextSize = 24
            v48.Label.TextSize = 17
        else
            parent2.AnchorPoint = Vector2.new(0, 1)
            position = UDim2.new(0, 24, 1, -192)
            parent2.Size = UDim2.fromOffset(340, 70)
            parent5.AnchorPoint = Vector2.new(0, 1)
            position2 = UDim2.new(0, 24, 1, -274)
            parent5.Size = UDim2.fromOffset(340, 50)
            label.TextSize = 26
            v48.Label.TextSize = 20
        end

        local v88 = ui.Touch and 58 or 70
        v48.Instance.Size = UDim2.new(1, -v88, 1, 0)
        v48.Instance.Position = UDim2.new(0.5, -v88 / 2, 0.5, 0)

        if not parent2.Visible then
            parent5.AnchorPoint = parent2.AnchorPoint
            position2 = position
        end

        parent6.AnchorPoint = parent5.AnchorPoint
        local v89 = 0.5 < parent5.AnchorPoint.Y
        local v90 = ui.Compact and 48 or 60
        parent6.Size = UDim2.fromOffset(parent5.Size.X.Offset, v90)

        if parent5.Visible then
            local v91 = parent5.Size.Y.Offset + 10
            local udim2FromOffset = UDim2.fromOffset
            local v93 = if v89 then -v91 else v91
            position3 = position2 + udim2FromOffset(0, v93)
        else
            position3 = position2
        end

        local udim2FromOffset = UDim2.fromOffset
        local v95 = ui.Compact and 32 or 40
        local v96 = ui.Compact and 32 or 40
        v64.Size = udim2FromOffset(v95, v96)
        ui5.TextSize = ui.Compact and 16 or 20
        local udim2FromOffset2 = UDim2.fromOffset
        local v98 = ui.Compact and 48 or 58
        local v99 = ui.Compact and 4 or 7
        ui5.Position = udim2FromOffset2(v98, v99)
        ui6.TextSize = ui.Compact and 12 or 14
        local v100 = UDim2.fromOffset
        local v101 = ui.Compact and 48 or 58

        if ui.Compact then
            ui2 = 25
            ui2 = ui
        else
            ui2 = 31
            ui2 = ui
        end

        ui6.Position = v100(v101, ui2)
        v100 = UDim2.new
        local v102 = ui2.Compact and 4 or 8
        parent9.Position = v100(1, -12, 0, v102)
        ui7.TextSize = ui.Compact and 20 or 24
        local newUDim2 = UDim2.new
        local v104 = ui.Compact and 20 or 26
        ui7.Position = newUDim2(1, -12, 0, v104)

        if lobbyColumn then
            lobbyColumn.Place(parent2, position)
            lobbyColumn.Place(parent5, position2)
            lobbyColumn.Place(parent6, position3)
        else
            parent2.Position = position
            parent5.Position = position2
            parent6.Position = position3
        end

        paintBadge()
    end

    local function refresh()
        --[[
          name: refresh
          line: 400
          upvalues:
            paintCard (copy, index: 1)
            paintRestore (copy, index: 2)
            paintSale (copy, index: 3)
            layout (copy, index: 4)
        ]]
        paintCard()
        paintRestore()
        paintSale()
        layout()
    end

    paintCard()
    paintRestore()
    paintSale()
    layout()
    economy.Changed:Connect(refresh)
    ui.LayoutChanged:Connect(refresh)
    ui.TopInsetChanged:Connect(layout)

    if a3.LobbyColumn and a3.LobbyColumn.RowChanged then
        a3.LobbyColumn.RowChanged:Connect(layout)
    end

    state.AttrChanged:Connect(
        function(a106)
            --[[
              line: 413
              upvalues:
                paintBadge (copy, index: 1)
            ]]
            if a106 == "Streak" then
                paintBadge()
            end
        end
    )

    ui.Every(
        parent,
        1,
        function()
            --[[
              line: 419
              upvalues:
                parent5 (copy, index: 1)
                economy (copy, index: 2)
                paintCard (copy, index: 3)
                paintRestore (copy, index: 4)
                paintSale (copy, index: 5)
                layout (copy, index: 6)
                parent6 (copy, index: 7)
                parent4 (copy, index: 8)
                paintBadge (copy, index: 9)
            ]]
            if parent5.Visible and not economy.StreakOffer() then
                paintCard()
                paintRestore()
                paintSale()
                layout()
            end

            if parent6.Visible or economy.OfferLeft() then
                local visible = parent6.Visible
                paintSale()

                if parent6.Visible ~= visible then
                    layout()
                end
            end

            if not parent4.Parent then
                paintBadge()
            end
        end
    )

    local function refreshVisible()
        --[[
          name: refreshVisible
          line: 434
          upvalues:
            parent (copy, index: 1)
            state (copy, index: 2)
            a3 (copy, index: 3)
        ]]
        local visible = not state.SeesMatch() and not a3.HudHidden
        parent.Visible = visible
    end

    local visible = not state.SeesMatch() and not a3.HudHidden
    parent.Visible = visible
    state.PlayerStateChanged:Connect(refreshVisible)
    state.WatchChanged:Connect(refreshVisible)
    a3.HudHiddenChanged:Connect(refreshVisible)

    economy.Event:Connect(
        function(a111, a112)
            --[[
              line: 442
              upvalues:
                a3 (copy, index: 1)
                v37 (ref,  index: 2)
                paintBadge (copy, index: 3)
                weaponInfo (copy, index: 4)
            ]]
            if a111 == "StreakRestored" then
                a3.Sounds.Play("Reward")
                a3.Toast(string.format("Win streak restored: 🔥 %d", (tonumber(a112.streak) or 0)), "success")

                task.defer(
                    function()
                        --[[
                          line: 446
                          upvalues:
                            v37 (ref,  index: 1)
                            paintBadge (copy, index: 2)
                        ]]
                        v37 = 0
                        paintBadge()
                    end
                )

                return
            end

            if a111 == "StreakCredit" then
                a3.Toast("Streak restore saved: it protects your next win streak", "info")
                return
            end

            if a111 == "Credit" and type(a112.item) == "string" then
                local v113

                if type(a112.target) ~= "string" then
                    v113 = a112.item
                else
                    v113 = a112.target
                end

                local number = tonumber(a112.shards)

                if v113 ~= a112.item then
                    local toast = a3.Toast
                    local stringFormat = string.format
                    local v117 = weaponInfo.Name(a112.item)
                    local v118 = not number and "its" or tostring(number)
                    toast(stringFormat("You already own the %s: %s shards went to your %s", v117, v118, weaponInfo.Name(v113)), "info")

                    return
                end

                local toast = a3.Toast
                local stringFormat = string.format
                local v121 = weaponInfo.Name(a112.item)
                local v122 = not number and "its" or tostring(number)
                toast(stringFormat("You already own the %s: %s shards went toward its next upgrade", v121, v122), "info")
            end
        end
    )

    local overlay = a3.Canvas.Overlay
    local ui10 = ui.new("Frame", {Name = "UnlockDim", BackgroundTransparency = 1, Visible = false, ZIndex = 29, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = overlay})
    local parent11 = ui.new("TextButton", {Name = "UnlockMoment", Selectable = false, Visible = false, ZIndex = 30, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(560, 320), Parent = overlay})
    local scaleObj2 = ui.GetScaleObj(parent11, "FitScale")
    ui.Panel({Name = "Card", BackgroundTransparency = 0.06, StrokeTransparency = 0.55, ZIndex = 29, Position = UDim2.fromOffset(0, 18), Size = UDim2.new(1, 0, 1, -18), StrokeColor = colors.Gold, Parent = parent11})
    local v127 = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.45, ZIndex = 30, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 125), Size = UDim2.fromOffset(460, 400), ImageColor3 = colors.Accent, Parent = parent11})
    local v128 = ui.Image(ui.Assets.Fx.Ring, {Name = "Ring", ImageTransparency = 1, ZIndex = 31, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 125), Size = UDim2.fromOffset(120, 120), Parent = parent11})
    local ui11 = ui.new("Frame", {Name = "Icon", ZIndex = 32, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 125), Size = UDim2.fromOffset(170, 170), Parent = parent11})
    local v130 = ui.DisplayText({Name = "Title", Text = "NEW ITEM UNLOCKED", TextSize = 26, StrokeThickness = 2, ZIndex = 33, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.fromOffset(520, 36), TextColor3 = colors.Gold, Parent = parent11})
    local v131 = ui.DisplayText({Name = "ItemName", Text = "", TextSize = 44, StrokeThickness = 2, ZIndex = 33, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 210), Size = UDim2.fromOffset(520, 46), Parent = parent11})
    local parent12 = ui.new("TextLabel", {Name = "Sub", Text = "", RichText = true, TextSize = 16, ZIndex = 33, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 258), Size = UDim2.fromOffset(520, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = parent11})
    ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent12
    local parent13 = ui.new("TextLabel", {Name = "Next", Text = "", TextSize = 15, ZIndex = 33, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 284), Size = UDim2.fromOffset(520, 20), FontFace = fonts.Bold, TextColor3 = colors.TextMuted, Parent = parent11})
    ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent13
    local count = 0
    local showing2 = false

    local function hideOthers(a137)
        --[[
          name: hideOthers
          line: 572
          upvalues:
            a3 (copy, index: 1)
        ]]
        a3.SetHudHidden("Unlock", a137)

        if a3.TopbarSettings and a3.TopbarSettings.SetHidden then
            a3.TopbarSettings.SetHidden("Unlock", a137)
        end
    end

    local function setShowing(showing)
        --[[
          name: setShowing
          line: 578
          upvalues:
            showing2 (ref,  index: 1)
            a3 (copy, index: 2)
            economy (copy, index: 3)
        ]]
        if showing2 ~= showing then
            showing2 = showing
            a3.SetHudHidden("Unlock", showing)

            if a3.TopbarSettings and a3.TopbarSettings.SetHidden then
                a3.TopbarSettings.SetHidden("Unlock", showing)
            end

            economy.CelebrationChanged:Fire(showing)
        end
    end

    local v140 = false

    local function hideCelebration()
        --[[
          name: hideCelebration
          line: 586
          upvalues:
            v140 (ref,  index: 1)
            count (ref,  index: 2)
            parent11 (copy, index: 3)
            ui (copy, index: 4)
            ui10 (copy, index: 5)
            showing2 (ref,  index: 6)
            a3 (copy, index: 7)
            economy (copy, index: 8)
            weaponIcon (copy, index: 9)
            ui11 (copy, index: 10)
        ]]
        if v140 then
            return
        end

        count += 1

        if not parent11.Visible then
            return
        end

        v140 = true
        local v142 = count
        ui.FadeOut(parent11, TweenInfo.new(0.25))
        local v143 = {BackgroundTransparency = 1}
        ui.Tween(ui10, TweenInfo.new(0.25), v143)

        task.delay(
            0.27,
            function()
                --[[
                  line: 598
                  upvalues:
                    v140 (ref,  index: 1)
                    v142 (copy, index: 2)
                    count (ref,  index: 3)
                    parent11 (copy, index: 4)
                    ui10 (copy, index: 5)
                    showing2 (ref,  index: 6)
                    a3 (copy, index: 7)
                    economy (copy, index: 8)
                    ui (copy, index: 9)
                    weaponIcon (copy, index: 10)
                    ui11 (copy, index: 11)
                ]]
                v140 = false

                if v142 == count then
                    parent11.Visible = false
                    ui10.Visible = false

                    if showing2 ~= false then
                        showing2 = false
                        a3.SetHudHidden("Unlock", false)

                        if a3.TopbarSettings and a3.TopbarSettings.SetHidden then
                            a3.TopbarSettings.SetHidden("Unlock", false)
                        end

                        economy.CelebrationChanged:Fire(false)
                    end

                    ui.Unfade(parent11)
                    weaponIcon.Set(ui11, nil)
                end
            end
        )
    end

    local function showCelebration(a145)
        --[[
          name: showCelebration
          line: 609
          upvalues:
            v140 (ref,  index: 1)
            count (ref,  index: 2)
            ui (copy, index: 3)
            scaleObj2 (copy, index: 4)
            economy (copy, index: 5)
            weaponInfo (copy, index: 6)
            v131 (copy, index: 7)
            parent12 (copy, index: 8)
            parent13 (copy, index: 9)
            v127 (copy, index: 10)
            parent11 (copy, index: 11)
            showing2 (ref,  index: 12)
            a3 (copy, index: 13)
            ui10 (copy, index: 14)
            weaponIcon (copy, index: 15)
            ui11 (copy, index: 16)
            theme (copy, index: 17)
            v130 (copy, index: 18)
            v128 (copy, index: 19)
            colors (copy, index: 20)
            hideCelebration (copy, index: 21)
        ]]
        local text
        v140 = false
        count += 1
        local v147 = count
        local v148 = ui.CanvasSize()
        scaleObj2.Scale = math.min(1, (v148.X - 32) / 560, (v148.Y - 40) / 340)
        local startValue = economy.CategoryColor(a145)
        text = if const v150 = weaponInfo.Get(a145) then weaponInfo.CATEGORY_SINGULAR[v150.category] or "" else ""
        v131.Text = string.upper(weaponInfo.Name(a145))
        parent12.Text = string.format("%s  ·  EQUIP IT IN YOUR LOADOUT", string.upper(text))
        parent13.Text = "LEVEL 1  ·  SHARDS FROM DROPS LEVEL IT UP"
        v127.ImageColor3 = economy.CategoryColor(a145)
        ui.Unfade(parent11)

        if showing2 ~= true then
            showing2 = true
            a3.SetHudHidden("Unlock", true)

            if a3.TopbarSettings and a3.TopbarSettings.SetHidden then
                a3.TopbarSettings.SetHidden("Unlock", true)
            end

            economy.CelebrationChanged:Fire(true)
        end

        parent11.Visible = true
        ui10.Visible = true
        ui10.BackgroundTransparency = 1
        local v151 = {BackgroundTransparency = 0.45}
        ui.Tween(ui10, TweenInfo.new(0.3), v151)
        weaponIcon.Set(ui11, a145, {spin = true, outline = true, glow = false, outlineScale = 1.04, outlineTransparency = 0.45, outlineColor = startValue:Lerp(Color3.new(1, 1, 1), 0.5)})
        a3.Sounds.Play("Unlock")
        ui.Pop(ui11, 0.3, theme.Tween.Slam)
        ui.Pop(v130, 1.6, theme.Tween.Slam)
        ui.Enter(v131, Vector2.new(0, 16), 0.12)
        ui.Enter(parent12, Vector2.new(0, 12), 0.2)
        ui.Enter(parent13, Vector2.new(0, 12), 0.28)
        v127.ImageTransparency = 1
        local v152 = {ImageTransparency = 0.5}
        ui.Tween(v127, TweenInfo.new(0.5, Enum.EasingStyle.Quint), v152)
        v128.Size = UDim2.fromOffset(120, 120)
        v128.ImageTransparency = 0.2
        v128.ImageColor3 = colors.Accent
        ui.Tween(v128, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 1, Size = UDim2.fromOffset(520, 520)})

        task.delay(
            4.2,
            function()
                --[[
                  line: 641
                  upvalues:
                    v147 (copy, index: 1)
                    count (ref,  index: 2)
                    hideCelebration (copy, index: 3)
                ]]
                if v147 == count then
                    hideCelebration()
                end
            end
        )
    end

    parent11.Activated:Connect(hideCelebration)
    local localPlayer = game:GetService("Players").LocalPlayer
    local v154 = nil

    local function canShow()
        --[[
          name: canShow
          line: 653
          upvalues:
            localPlayer (copy, index: 1)
            a3 (copy, index: 2)
            state (copy, index: 3)
        ]]
        if localPlayer:GetAttribute("ReplayPlaying") ~= true
            and not a3.IsHudHiddenFor("Intro")
            and not a3.IsHudHiddenFor("Celebrate")
        then
            return not state.InMatch() or a3.IsHudHiddenFor("MatchEnd")
        end

        return false
    end

    local function flushPending()
        --[[
          name: flushPending
          line: 659
          upvalues:
            v154 (ref,  index: 1)
            canShow (copy, index: 2)
            showCelebration (copy, index: 3)
        ]]
        local v157 = v154

        if v157 and canShow() then
            v154 = nil
            showCelebration(v157.id)
        end
    end

    economy.Celebrate:Connect(
        function(id)
            --[[
              line: 666
              upvalues:
                v154 (ref,  index: 1)
                canShow (copy, index: 2)
                showCelebration (copy, index: 3)
            ]]
            if type(id) == "string" then
                v154 = {id = id}
                local v159 = v154

                if v159 and canShow() then
                    v154 = nil
                    showCelebration(v159.id)
                end
            end
        end
    )

    ui.Every(
        parent11,
        0.25,
        function()
            --[[
              line: 675
              upvalues:
                showing2 (ref,  index: 1)
                parent11 (copy, index: 2)
                canShow (copy, index: 3)
                hideCelebration (copy, index: 4)
                v154 (ref,  index: 5)
                showCelebration (copy, index: 6)
            ]]
            if showing2 and parent11.Visible and not canShow() then
                hideCelebration()
            end

            local v160 = v154

            if v160 and canShow() then
                v154 = nil
                showCelebration(v160.id)
            end
        end
    )

    local success2, result = pcall(
        function()
            --[[
              line: 682
              upvalues:
                a3 (copy, index: 1)
            ]]
            require(script.Parent.Parent.ContractPodium).Init(a3)
        end
    )
    if not success2 then
        warn("[UI] contract podium failed: " .. tostring(result))
    end

    a3.Debug.unlockEvent = function(a163)
        --[[
          line: 690
          upvalues:
            economy (copy, index: 1)
            v154 (ref,  index: 2)
            showing2 (ref,  index: 3)
        ]]
        local v164
        local celebrate = economy.Celebrate

        if type(a163) ~= "string" then
            v164 = "crossbow"
        else
            v164 = a163
        end

        celebrate:Fire(v164)
        local v166 = {}
        v166.pending = v154 ~= nil
        v166.showing = showing2
        return v166
    end

    a3.Debug.unlockMoment = function(a167)
        --[[
          line: 694
          upvalues:
            showCelebration (copy, index: 1)
        ]]
        local v168

        if type(a167) ~= "string" then
            v168 = "crossbow"
        else
            v168 = a167
        end

        showCelebration(v168)

        return true
    end

    a3.Debug.collectionCard = function()
        --[[
          line: 699
          upvalues:
            parent2 (copy, index: 1)
            label (copy, index: 2)
            focus (ref,  index: 3)
            economy (copy, index: 4)
            parent3 (copy, index: 5)
        ]]
        return {visible = parent2.Visible, label = label.Text, focus = focus or false, ready = economy.UpgradesReady(), badge = parent3.Visible}
    end
end

return v1