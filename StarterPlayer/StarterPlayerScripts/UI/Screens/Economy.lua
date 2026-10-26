local tbl_1 = {}
local fromRGB_upv_1 = Color3.fromRGB
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 21
      upvalues:
        fromRGB_upv_1 (copy, index: 1)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Economy_upv_1 = a1.Economy
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_1 = Theme_upv_1.Fonts
    local Success_upv_1 = Colors_upv_1.Success
    local u1 = UI_upv_1.new("Frame", {Name = "Economy", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local u2 = UI_upv_1.new("Frame", {Visible = false, Name = "Collection", Size = UDim2.fromOffset(340, 70), Parent = u1})
    local u3 = nil
    local Button_1 = UI_upv_1.Button
    local tbl_2 = {Parent = 0, Text = "COLLECTION", Gap = 6, Name = "Button", OnClick = 0, Icon = 0, Style = "Dark", TextSize = 26}
    tbl_2.Size = UDim2.fromScale(1, 1)
    tbl_2.Icon = UI_upv_1.Image(UI_upv_1.Assets.Icons.CollectionGem or (UI_upv_1.Assets.Fx.Gem), {Name = "Icon", Size = UDim2.fromOffset(38, 38), ScaleType = Enum.ScaleType.Fit})
    tbl_2.Parent = u2
    function tbl_2.OnClick()
        --[[
          name: OnClick
          line: 46
          upvalues:
            a1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        local Open_1 = a1.MenuManager.Open
        local v1
        if u3 then
            v1 = {}
            v1.focus = u3
        else
            v1 = nil
        end
        Open_1("Collection", v1)
    end
    local Label_upv_1 = Button_1(tbl_2).Label
    Label_upv_1.RichText = true
    Label_upv_1.LineHeight = 0.92
    local tbl_3 = {}
    tbl_3.Name = "Ready"
    tbl_3.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_3.Position = UDim2.new(1, -8, 0, 8)
    tbl_3.Size = UDim2.fromOffset(28, 28)
    tbl_3.BackgroundColor3 = Success_upv_1
    tbl_3.Visible = false
    tbl_3.ZIndex = 6
    tbl_3[1], tbl_3[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Void, 2, 0.15)
    tbl_3.Parent = u2
    local u4 = UI_upv_1.new("Frame", tbl_3)
    local u5 = UI_upv_1.new("TextLabel", {ZIndex = 6, Name = "Count", Text = "1", TextSize = 17, Size = UDim2.fromScale(1, 1), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Text, Parent = u4})
    local u6 = UI_upv_1.GetScaleObj(u4, "Pulse")
    local u7 = -1
    local function paintCard()
        --[[
          name: paintCard
          line: 77
          upvalues:
            u2 (copy, index: 1)
            Economy_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
            Theme_upv_1 (copy, index: 4)
            Success_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            Label_upv_1 (copy, index: 7)
            u4 (copy, index: 8)
            u5 (copy, index: 9)
            u7 (ref,  index: 10)
            UI_upv_1 (copy, index: 11)
        ]]
        u2.Visible = Economy_upv_1.HasData()
        if not u2.Visible then
            return
        end
        local v2 = Economy_upv_1.ReadyList()
        u3 = v2[1]
        local v3 = 0
        local v4 = 0
        for _, value_1 in Economy_upv_1.Unlocks.AllIds() do
            v4 = v4 + 1
            v3 = (Economy_upv_1.Owns(value_1) and (v3 + 1)) or v3
        end
        local v5
        if #v2 > 0 then
            local v6 = Theme_upv_1.Lighten(Success_upv_1, 0.2):ToHex()
            local v7 = ((#v2 == 1) and "1 UPGRADE READY") or (string.format("%d UPGRADES READY", #v2))
            v5 = string.format("<font size=\"14\" color=\"#%s\">%s</font>", v6, v7)
        elseif (v4 <= v3) and (v4 > 0) then
            v5 = "<font size=\"14\" color=\"#BAC0CE\">EVERY ITEM FOUND</font>"
        else
            v5 = string.format("<font size=\"14\" color=\"#BAC0CE\">%d / %d ITEMS</font>", v3, v4)
        end
        a1.Loc.Rich(Label_upv_1, "COLLECTION\n" .. v5)
        u4.Visible = #v2 > 0
        u5.Text = tostring(#v2)
        if u7 < #v2 and u7 >= 0 then
            UI_upv_1.Pop(u4, 0.6)
        end
        u7 = #v2
    end
    UI_upv_1.Every(
        u4,
        0.03333333333333333,
        function()
            --[[
              line: 108
              upvalues:
                u4 (copy, index: 1)
                u2 (copy, index: 2)
                u6 (copy, index: 3)
            ]]
            if not u4.Visible or not u2.Visible then
                return
            end
            u6.Scale = (((math.sin(os.clock() * 4.2) * 0.5) + 0.5) * 0.1) + 1
        end
    )
    local u8 = UI_upv_1.new("Frame", {Name = "StreakBadge", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme_upv_1.Colors.Inset, BackgroundTransparency = 0.15, Visible = false, ZIndex = 3, UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(fromRGB_upv_1(255, 150, 60), 1, 0.45), UI_upv_1.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Fire, {LayoutOrder = 1, Name = "Flame", ZIndex = 3, Size = UDim2.fromOffset(17, 17), Parent = u8})
    local u9 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "0", Name = "Streak", TextSize = 16, ZIndex = 3, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_1.Display, TextColor3 = fromRGB_upv_1(255, 196, 120), Parent = u8})
    local u10 = -1
    local function streakNow()
        --[[
          name: streakNow
          line: 141
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v8 = State_upv_1.Get("Streak")
        if type(v8) ~= "number" then
            local _ = State_upv_1.Profile.stats
            v8 = type(State_upv_1.Profile.stats) == "table" and State_upv_1.Profile.stats.streak or 0
        end
        return (math.max(0, math.floor(v8)))
    end
    local function paintBadge()
        --[[
          name: paintBadge
          line: 149
          upvalues:
            a1 (copy, index: 1)
            u8 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            u9 (copy, index: 4)
            u10 (ref,  index: 5)
            UI_upv_1 (copy, index: 6)
        ]]
        local v10 = a1.LobbyHud and (a1.LobbyHud.StreakSlot)
        if not v10 then
            return
        end
        if u8.Parent ~= v10 then
            u8.Parent = v10
        end
        local v11 = State_upv_1.Get("Streak")
        if type(v11) ~= "number" then
            local _ = State_upv_1.Profile.stats
            v11 = type(State_upv_1.Profile.stats) == "table" and State_upv_1.Profile.stats.streak or 0
        end
        local v13 = math.max(0, math.floor(v11))
        v11 = v13 >= 2
        u8.Visible = v11
        u9.Text = tostring(v13)
        if v11 and u10 >= 0 and u10 < v13 then
            UI_upv_1.Pop(u8, 1.4)
        end
        u10 = v13
    end
    local u11 = UI_upv_1.new("Frame", {Visible = false, Name = "StreakRestore", Size = UDim2.fromOffset(340, 50), Parent = u1})
    local u12 = UI_upv_1.Button({Radius = 12, Text = "RESTORE", Name = "Restore", Style = "Dark", TextSize = 20, Size = UDim2.new(1, -58, 1, 0), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, -29, 0.5, 0), Icon = UI_upv_1.Image(UI_upv_1.Assets.Icons.Fire, {Size = UDim2.fromOffset(26, 26)}), Parent = u11})
    u12.Instance.AnchorPoint = Vector2.new(0.5, 0.5)
    u12.Instance.Position = UDim2.new(0.5, -29, 0.5, 0)
    u12.Label.RichText = true
    local u13 = UI_upv_1.Pill("", Colors_upv_1.SuccessDark, {LayoutOrder = 3, Transparency = 0, Name = "Price", Height = 26, TextSize = 15})
    u13.Parent = u12.Content
    local v14 = UI_upv_1.IconButton({IconName = "cross", IconScale = 0.36, Transparency = 0.35, Name = "Dismiss", Sound = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, -1), Size = UDim2.fromOffset(42, 42), Color = Colors_upv_1.Raised, Parent = u11})
    local u14 = nil
    local function paintRestore()
        --[[
          name: paintRestore
          line: 204
          upvalues:
            Economy_upv_1 (copy, index: 1)
            u14 (ref,  index: 2)
            u11 (copy, index: 3)
            u12 (copy, index: 4)
            u13 (copy, index: 5)
        ]]
        local v15 = Economy_upv_1.StreakOffer()
        local v16 = (v15 ~= false) and (u14 ~= v15.expiresAt)
        u11.Visible = v16
        if not v16 then
            return
        end
        local v17 = Economy_upv_1.Pending(v15.key)
        local v18 = (v17 and "RESTORING\226\128\166") or (string.format("RESTORE <font color=\"#FFC478\">%d</font>", v15.lost))
        u12:SetText(v18)
        u13.Visible = not v17
        local Text_1 = u13:FindFirstChild("Text")
        Text_1.Text = Economy_upv_1.PriceText(v15.key)
        u12:SetEnabled(not v17)
    end
    u12.Activated:Connect(
        function()
            --[[
              line: 217
              upvalues:
                Economy_upv_1 (copy, index: 1)
            ]]
            local v19 = Economy_upv_1.StreakOffer()
            if not v19 then
                return
            end
            Economy_upv_1.Buy(v19.key)
        end
    )
    v14.Activated:Connect(
        function()
            --[[
              line: 223
              upvalues:
                Economy_upv_1 (copy, index: 1)
                u14 (ref,  index: 2)
                paintRestore (copy, index: 3)
            ]]
            local v20 = Economy_upv_1.StreakOffer()
            local v21
            if v20 then
                v21 = v20.expiresAt
            else
                v21 = nil
            end
            u14 = v21
            paintRestore()
        end
    )
    local v22 = fromRGB_upv_1(245, 52, 64)
    local u15 = UI_upv_1.new("Frame", {Visible = false, Name = "GoldenOffer", Size = UDim2.fromOffset(340, 60), Parent = u1})
    local v23 = UI_upv_1.new("Frame", {Name = "Body", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Parent = u15})
    local tbl_upv_4 = {}
    tbl_upv_4.Name = "Button"
    tbl_upv_4.Text = ""
    tbl_upv_4.AutoButtonColor = false
    tbl_upv_4.Size = UDim2.fromScale(1, 1)
    tbl_upv_4.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_upv_4.ClipsDescendants = true
    tbl_upv_4[1], tbl_upv_4[2], tbl_upv_4[3] = UI_upv_1.Corner(12), UI_upv_1.Gradient(fromRGB_upv_1(178, 106, 14), fromRGB_upv_1(98, 52, 6), 90), UI_upv_1.Stroke(fromRGB_upv_1(255, 204, 90), 2, 0.15)
    tbl_upv_4.Parent = v23
    local v24 = UI_upv_1.new("TextButton", tbl_upv_4)
    local u16 = UI_upv_1.new("Frame", {Name = "Sweep", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(-0.4, 0.5), Size = UDim2.new(0, 70, 2, 0), Rotation = 20, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, [1] = UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0, NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.72), NumberSequenceKeypoint.new(1, 1)})), Parent = v24})
    tbl_upv_4 = UI_upv_1.Image(UI_upv_1.Assets.Icons.CollectionGem or (UI_upv_1.Assets.Fx.Gem), {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(40, 40), ScaleType = Enum.ScaleType.Fit, Parent = v24})
    local u17 = UI_upv_1.new("TextLabel", {Name = "Title", Text = "GOLDEN DROP", FontFace = Fonts_1.Heavy, TextSize = 20, TextColor3 = fromRGB_upv_1(255, 226, 150), TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(58, 7), Size = UDim2.new(1, -150, 0, 24), [1] = UI_upv_1.TextStroke(fromRGB_upv_1(70, 36, 2), 1.5, 0.3), Parent = v24})
    local u18 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Left", TextSize = 14, FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(58, 31), Size = UDim2.new(1, -150, 0, 20), Parent = v24})
    local u19 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Was", TextSize = 14, FontFace = Fonts_1.Heavy, TextColor3 = fromRGB_upv_1(236, 206, 150), TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 8), Size = UDim2.fromOffset(90, 18), Parent = v24})
    local u20 = UI_upv_1.new("TextLabel", {Name = "Now", Text = "", FontFace = Fonts_1.Display, TextSize = 24, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 26), Size = UDim2.fromOffset(90, 26), [1] = UI_upv_1.TextStroke(fromRGB_upv_1(70, 36, 2), 1.5, 0.3), Parent = v24})
    local u21 = UI_upv_1.Pill("", v22, {Transparency = 0, Name = "Tag", Height = 28, ZIndex = 4, TextSize = 16, PadX = 9, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 16, 0, 2)})
    u21.Rotation = -10
    u21.Parent = v23
    UI_upv_1.new("Frame", {Name = "Slash", ZIndex = 3, Rotation = -14, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -22, 0.5, 0), Size = UDim2.fromOffset(46, 2), BackgroundColor3 = v22, Parent = u19})
    local u22 = UI_upv_1.new("UIScale", {Parent = v23})
    local u23 = UI_upv_1.new("UIScale", {Parent = u21})
    v24.MouseEnter:Connect(
        function()
            --[[
              line: 275
              upvalues:
                UI_upv_1 (copy, index: 1)
                u22 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            if (UI_upv_1.Touch) then
                return
            end
            UI_upv_1.Tween(u22, Theme_upv_1.Tween.Fast, {Scale = 1.03})
        end
    )
    v24.MouseLeave:Connect(
        function()
            --[[
              line: 280
              upvalues:
                UI_upv_1 (copy, index: 1)
                u22 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            UI_upv_1.Tween(u22, Theme_upv_1.Tween.Fast, {Scale = 1})
        end
    )
    v24.Activated:Connect(
        function()
            --[[
              line: 283
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Sounds.Play("Click")
            a1.MenuManager.Open("GoldenOffer")
        end
    )
    task.spawn(
        function()
            --[[
              line: 307
              upvalues:
                u1 (copy, index: 1)
                u15 (copy, index: 2)
                u16 (copy, index: 3)
                UI_upv_1 (copy, index: 4)
                u23 (copy, index: 5)
            ]]
            while u1.Parent do
                task.wait(3.2)
                if not (u15.Visible) then
                    continue
                end
                if u1.Visible then
                    u16.Position = UDim2.fromScale(-0.4, 0.5)
                    UI_upv_1.Tween(u16, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.fromScale(1.4, 0.5)})
                    task.delay(
                        0.45,
                        function()
                            --[[
                              line: 314
                              upvalues:
                                u23 (copy, index: 1)
                                UI_upv_1 (copy, index: 2)
                            ]]
                            u23.Scale = 1.18
                            local tbl_5 = {Scale = 1}
                            UI_upv_1.Tween(u23, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_5)
                        end
                    )
                end
            end
        end
    )
    local function paintSale()
        --[[
          name: paintSale
          line: 287
          upvalues:
            Economy_upv_1 (copy, index: 1)
            u15 (copy, index: 2)
            a1 (copy, index: 3)
            u18 (copy, index: 4)
            u19 (copy, index: 5)
            u20 (copy, index: 6)
            u21 (copy, index: 7)
        ]]
        local v25 = Economy_upv_1.GoldenOffer()
        local v26 = Economy_upv_1.OfferLeft()
        local v27 = (v25 ~= false) and ((v25.state == "active") and (v26 ~= nil))
        u15.Visible = v27
        if not v27 then
            return
        end
        a1.Loc.Rich(u18, string.format("<font color=\"#FFB4B8\">ENDS IN</font>  %s", Economy_upv_1.FormatLeft(v26)))
        local v28 = Economy_upv_1.Price("drop_golden")
        local v29 = Economy_upv_1.Price(v25.key)
        u19.Text = not v28 and "" or string.format("<s>%s %d</s>", Economy_upv_1.ROBUX, v28)
        u20.Text = not v29 and Economy_upv_1.ROBUX .. " \226\128\166" or string.format("%s %d", Economy_upv_1.ROBUX, v29)
        local v32 = Economy_upv_1.OfferDiscount()
        u21.Visible = v32 ~= nil
        if v32 then
            local Text_2 = u21:FindFirstChild("Text")
            Text_2.Text = string.format("-%d%%", v32)
        end
    end
    local function layout()
        --[[
          name: layout
          line: 323
          upvalues:
            UI_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            u2 (copy, index: 3)
            u11 (copy, index: 4)
            Label_upv_1 (copy, index: 5)
            u12 (copy, index: 6)
            u15 (copy, index: 7)
            tbl_upv_4 (copy, index: 8)
            u17 (copy, index: 9)
            u18 (copy, index: 10)
            u19 (copy, index: 11)
            u20 (copy, index: 12)
            paintBadge (copy, index: 13)
        ]]
        local v33 = UI_upv_1.TopInset()
        local LobbyColumn_1 = a1.LobbyColumn
        local v34
        if UI_upv_1.Compact and LobbyColumn_1 and LobbyColumn_1.Row then
            v34 = LobbyColumn_1.Row()
        else
            v34 = nil
        end
        local v35
        if v34 then
            u2.AnchorPoint = Vector2.new(0, 0.5)
            v35 = UDim2.fromOffset(v34.cardX, v34.y)
            u2.Size = UDim2.fromOffset(v34.cardW, v34.h)
            u11.AnchorPoint = Vector2.new(0, 0)
            local v36 = UDim2.fromOffset(v34.restoreX, v34.restoreY)
            u11.Size = UDim2.fromOffset(v34.restoreW, 46)
            Label_upv_1.TextSize = 24
            u12.Label.TextSize = 17
        elseif UI_upv_1.Compact then
            u2.AnchorPoint = Vector2.new(0, 0)
            local v37 = UDim2.fromOffset(16, v33 + 158)
            u2.Size = UDim2.fromOffset(254, 62)
            u11.AnchorPoint = Vector2.new(0, 0)
            local v38 = UDim2.fromOffset(16, v33 + 228)
            u11.Size = UDim2.fromOffset(254, 46)
            Label_upv_1.TextSize = 24
            u12.Label.TextSize = 17
            local v36
            v35, v36 = v37, v38
        else
            u2.AnchorPoint = Vector2.new(0, 1)
            local v39 = UDim2.new(0, 24, 1, -192)
            u2.Size = UDim2.fromOffset(340, 70)
            u11.AnchorPoint = Vector2.new(0, 1)
            local v40 = UDim2.new(0, 24, 1, -274)
            u11.Size = UDim2.fromOffset(340, 50)
            Label_upv_1.TextSize = 26
            u12.Label.TextSize = 20
            local v36
            v35, v36 = v39, v40
        end
        v34 = ((UI_upv_1.Touch) and 58) or 70
        u12.Instance.Size = UDim2.new(1, -v34, 1, 0)
        u12.Instance.Position = UDim2.new(0.5, -v34 / 2, 0.5, 0)
        local v36 = nil
        if not (u2.Visible) then
            u11.AnchorPoint = u2.AnchorPoint
            v36 = v35
        end
        u15.AnchorPoint = u11.AnchorPoint
        v34 = u11.AnchorPoint.Y > 0.5
        u15.Size = UDim2.fromOffset(u11.Size.X.Offset, ((UI_upv_1.Compact) and 48) or 60)
        if u11.Visible then
            local v41 = u11.Size.Y.Offset + 10
            local v42
            if v34 then
                v42 = -v41
            else
                v42 = v41
            end
            local _ = v36 + UDim2.fromOffset(0, v42)
        end
        tbl_upv_4.Size = UDim2.fromOffset(((UI_upv_1.Compact) and 32) or 40, ((UI_upv_1.Compact) and 32) or 40)
        u17.TextSize = ((UI_upv_1.Compact) and 16) or 20
        u17.Position = UDim2.fromOffset(((UI_upv_1.Compact) and 48) or 58, ((UI_upv_1.Compact) and 4) or 7)
        u18.TextSize = ((UI_upv_1.Compact) and 12) or 14
        u18.Position = UDim2.fromOffset(((UI_upv_1.Compact) and 48) or 58, ((UI_upv_1.Compact) and 25) or 31)
        u19.Position = UDim2.new(1, -12, 0, ((UI_upv_1.Compact) and 4) or 8)
        u20.TextSize = ((UI_upv_1.Compact) and 20) or 24
        u20.Position = UDim2.new(1, -12, 0, ((UI_upv_1.Compact) and 20) or 26)
        if LobbyColumn_1 then
            LobbyColumn_1.Place(u2, v35)
            LobbyColumn_1.Place(u11, v36)
            LobbyColumn_1.Place(u15, v36)
        else
            u2.Position = v35
            u11.Position = v36
            u15.Position = v36
        end
        paintBadge()
    end
    paintCard()
    paintRestore()
    paintSale()
    layout()
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
    Economy_upv_1.Changed:Connect(refresh)
    UI_upv_1.LayoutChanged:Connect(refresh)
    UI_upv_1.TopInsetChanged:Connect(layout)
    if a1.LobbyColumn and a1.LobbyColumn.RowChanged then
        a1.LobbyColumn.RowChanged:Connect(layout)
    end
    State_upv_1.AttrChanged:Connect(
        function(a2)
            --[[
              line: 413
              upvalues:
                paintBadge (copy, index: 1)
            ]]
            if a2 ~= "Streak" then
                return
            end
            paintBadge()
        end
    )
    UI_upv_1.Every(
        u1,
        1,
        function()
            --[[
              line: 419
              upvalues:
                u11 (copy, index: 1)
                Economy_upv_1 (copy, index: 2)
                paintCard (copy, index: 3)
                paintRestore (copy, index: 4)
                paintSale (copy, index: 5)
                layout (copy, index: 6)
                u15 (copy, index: 7)
                u8 (copy, index: 8)
                paintBadge (copy, index: 9)
            ]]
            if u11.Visible and not (Economy_upv_1.StreakOffer()) then
                paintCard()
                paintRestore()
                paintSale()
                layout()
            end
            if u15.Visible or Economy_upv_1.OfferLeft() then
                paintSale()
                if u15.Visible ~= u15.Visible then
                    layout()
                end
            end
            if (u8.Parent) then
                return
            end
            paintBadge()
        end
    )
    u1.Visible = not State_upv_1.SeesMatch() and not a1.HudHidden
    local function refreshVisible()
        --[[
          name: refreshVisible
          line: 434
          upvalues:
            u1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        u1.Visible = not State_upv_1.SeesMatch() and not a1.HudHidden
    end
    State_upv_1.PlayerStateChanged:Connect(refreshVisible)
    State_upv_1.WatchChanged:Connect(refreshVisible)
    a1.HudHiddenChanged:Connect(refreshVisible)
    Economy_upv_1.Event:Connect(
        function(a3, a4)
            --[[
              line: 442
              upvalues:
                a1 (copy, index: 1)
                u10 (ref,  index: 2)
                paintBadge (copy, index: 3)
                WeaponInfo_upv_1 (copy, index: 4)
            ]]
            if a3 == "StreakRestored" then
                a1.Sounds.Play("Reward")
                a1.Toast(string.format("Win streak restored: \240\159\148\165 %d", tonumber(a4.streak) or 0), "success")
                task.defer(
                    function()
                        --[[
                          line: 446
                          upvalues:
                            u10 (ref,  index: 1)
                            paintBadge (copy, index: 2)
                        ]]
                        u10 = 0
                        paintBadge()
                    end
                )
            elseif a3 == "StreakCredit" then
                a1.Toast("Streak restore saved: it protects your next win streak", "info")
            elseif a3 == "Credit" and type(a4.item) == "string" then
                local v45
                if type(a4.target) ~= "string" then
                    v45 = a4.item
                else
                    v45 = a4.target
                end
                local num_1 = tonumber(a4.shards)
                if v45 == a4.item then
                    local Toast_1 = a1.Toast
                    local v46 = WeaponInfo_upv_1.Name(a4.item)
                    local v47 = ((not num_1) and "its") or (tostring(num_1))
                    Toast_1(string.format("You already own the %s: %s shards went toward its next upgrade", v46, v47), "info")
                else
                    local Toast_2 = a1.Toast
                    local v48 = WeaponInfo_upv_1.Name(a4.item)
                    local v49 = ((not num_1) and "its") or (tostring(num_1))
                    Toast_2(string.format("You already own the %s: %s shards went to your %s", v48, v49, WeaponInfo_upv_1.Name(v45)), "info")
                    return
                end
            end
        end
    )
    local Overlay_1 = a1.Canvas.Overlay
    local u24 = UI_upv_1.new("Frame", {Visible = false, Name = "UnlockDim", BackgroundTransparency = 1, ZIndex = 29, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = Overlay_1})
    local u25 = UI_upv_1.new("TextButton", {Name = "UnlockMoment", Selectable = false, ZIndex = 30, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(560, 320), Parent = Overlay_1})
    local u26 = UI_upv_1.GetScaleObj(u25, "FitScale")
    UI_upv_1.Panel({StrokeTransparency = 0.55, Name = "Card", ZIndex = 29, BackgroundTransparency = 0.06, Position = UDim2.fromOffset(0, 18), Size = UDim2.new(1, 0, 1, -18), StrokeColor = Colors_upv_1.Gold, Parent = u25})
    local u27 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {ImageTransparency = 0.45, Name = "Glow", ZIndex = 30, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 125), Size = UDim2.fromOffset(460, 400), ImageColor3 = Colors_upv_1.Accent, Parent = u25})
    local u28 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Ring, {Name = "Ring", ZIndex = 31, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 125), Size = UDim2.fromOffset(120, 120), Parent = u25})
    local u29 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 32, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 125), Size = UDim2.fromOffset(170, 170), Parent = u25})
    local u30 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "NEW ITEM UNLOCKED", Name = "Title", ZIndex = 33, TextSize = 26, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.fromOffset(520, 36), TextColor3 = Colors_upv_1.Gold, Parent = u25})
    local u31 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "", Name = "ItemName", ZIndex = 33, TextSize = 44, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 210), Size = UDim2.fromOffset(520, 46), Parent = u25})
    local u32 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Sub", ZIndex = 33, TextSize = 16, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 258), Size = UDim2.fromOffset(520, 20), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u25})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = u32
    local u33 = UI_upv_1.new("TextLabel", {Text = "", Name = "Next", ZIndex = 33, TextSize = 15, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 284), Size = UDim2.fromOffset(520, 20), FontFace = Fonts_1.Bold, TextColor3 = Colors_upv_1.TextMuted, Parent = u25})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = u33
    local u34 = 0
    local u35 = false
    local function hideOthers(a5)
        --[[
          name: hideOthers
          line: 572
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.SetHudHidden("Unlock", a5)
        if not a1.TopbarSettings or not a1.TopbarSettings.SetHidden then
            return
        end
        a1.TopbarSettings.SetHidden("Unlock", a5)
    end
    local function setShowing(a6)
        --[[
          name: setShowing
          line: 578
          upvalues:
            u35 (ref,  index: 1)
            a1 (copy, index: 2)
            Economy_upv_1 (copy, index: 3)
        ]]
        if u35 == a6 then
            return
        end
        u35 = a6
        a1.SetHudHidden("Unlock", a6)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("Unlock", a6)
        end
        Economy_upv_1.CelebrationChanged:Fire(a6)
    end
    local u36 = false
    local function hideCelebration()
        --[[
          name: hideCelebration
          line: 586
          upvalues:
            u36 (ref,  index: 1)
            u34 (ref,  index: 2)
            u25 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            u24 (copy, index: 5)
            u35 (ref,  index: 6)
            a1 (copy, index: 7)
            Economy_upv_1 (copy, index: 8)
            WeaponIcon_upv_1 (copy, index: 9)
            u29 (copy, index: 10)
        ]]
        if u36 then
            return
        end
        u34 = u34 + 1
        if not u25.Visible then
            return
        end
        u36 = true
        local u37 = u34
        UI_upv_1.FadeOut(u25, TweenInfo.new(0.25))
        local tbl_6 = {BackgroundTransparency = 1}
        UI_upv_1.Tween(u24, TweenInfo.new(0.25), tbl_6)
        task.delay(
            0.27,
            function()
                --[[
                  line: 598
                  upvalues:
                    u36 (ref,  index: 1)
                    u37 (copy, index: 2)
                    u34 (ref,  index: 3)
                    u25 (copy, index: 4)
                    u24 (copy, index: 5)
                    u35 (ref,  index: 6)
                    a1 (copy, index: 7)
                    Economy_upv_1 (copy, index: 8)
                    UI_upv_1 (copy, index: 9)
                    WeaponIcon_upv_1 (copy, index: 10)
                    u29 (copy, index: 11)
                ]]
                u36 = false
                if u37 ~= u34 then
                    return
                end
                u25.Visible = false
                u24.Visible = false
                if u35 ~= false then
                    u35 = false
                    a1.SetHudHidden("Unlock", false)
                    if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
                        a1.TopbarSettings.SetHidden("Unlock", false)
                    end
                    Economy_upv_1.CelebrationChanged:Fire(false)
                end
                UI_upv_1.Unfade(u25)
                WeaponIcon_upv_1.Set(u29, nil)
            end
        )
    end
    local function showCelebration(a7)
        --[[
          name: showCelebration
          line: 609
          upvalues:
            u36 (ref,  index: 1)
            u34 (ref,  index: 2)
            UI_upv_1 (copy, index: 3)
            u26 (copy, index: 4)
            Economy_upv_1 (copy, index: 5)
            WeaponInfo_upv_1 (copy, index: 6)
            u31 (copy, index: 7)
            u32 (copy, index: 8)
            u33 (copy, index: 9)
            u27 (copy, index: 10)
            u25 (copy, index: 11)
            u35 (ref,  index: 12)
            a1 (copy, index: 13)
            u24 (copy, index: 14)
            WeaponIcon_upv_1 (copy, index: 15)
            u29 (copy, index: 16)
            Theme_upv_1 (copy, index: 17)
            u30 (copy, index: 18)
            u28 (copy, index: 19)
            Colors_upv_1 (copy, index: 20)
            hideCelebration (copy, index: 21)
        ]]
        u36 = false
        u34 = u34 + 1
        local u38 = u34
        local v50 = UI_upv_1.CanvasSize()
        u26.Scale = math.min(1, (v50.X - 32) / 560, (v50.Y - 40) / 340)
        v50 = Economy_upv_1.CategoryColor(a7)
        local v51 = WeaponInfo_upv_1.Get(a7)
        local v52 = ((not v51) and "") or (WeaponInfo_upv_1.CATEGORY_SINGULAR[v51.category] or "")
        u31.Text = string.upper(WeaponInfo_upv_1.Name(a7))
        u32.Text = string.format("%s  \194\183  EQUIP IT IN YOUR LOADOUT", string.upper(v52))
        u33.Text = "LEVEL 1  \194\183  SHARDS FROM DROPS LEVEL IT UP"
        u27.ImageColor3 = Economy_upv_1.CategoryColor(a7)
        UI_upv_1.Unfade(u25)
        if u35 ~= true then
            u35 = true
            a1.SetHudHidden("Unlock", true)
            if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
                a1.TopbarSettings.SetHidden("Unlock", true)
            end
            Economy_upv_1.CelebrationChanged:Fire(true)
        end
        u25.Visible = true
        u24.Visible = true
        u24.BackgroundTransparency = 1
        local tbl_7 = {BackgroundTransparency = 0.45}
        UI_upv_1.Tween(u24, TweenInfo.new(0.3), tbl_7)
        WeaponIcon_upv_1.Set(u29, a7, {outline = true, spin = true, outlineTransparency = 0.45, outlineScale = 1.04, glow = false, outlineColor = v50:Lerp(Color3.new(1, 1, 1), 0.5)})
        a1.Sounds.Play("Unlock")
        UI_upv_1.Pop(u29, 0.3, Theme_upv_1.Tween.Slam)
        UI_upv_1.Pop(u30, 1.6, Theme_upv_1.Tween.Slam)
        UI_upv_1.Enter(u31, Vector2.new(0, 16), 0.12)
        UI_upv_1.Enter(u32, Vector2.new(0, 12), 0.2)
        UI_upv_1.Enter(u33, Vector2.new(0, 12), 0.28)
        u27.ImageTransparency = 1
        local tbl_8 = {ImageTransparency = 0.5}
        UI_upv_1.Tween(u27, TweenInfo.new(0.5, Enum.EasingStyle.Quint), tbl_8)
        u28.Size = UDim2.fromOffset(120, 120)
        u28.ImageTransparency = 0.2
        u28.ImageColor3 = Colors_upv_1.Accent
        UI_upv_1.Tween(u28, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 1, Size = UDim2.fromOffset(520, 520)})
        task.delay(
            4.2,
            function()
                --[[
                  line: 641
                  upvalues:
                    u38 (copy, index: 1)
                    u34 (ref,  index: 2)
                    hideCelebration (copy, index: 3)
                ]]
                if u38 ~= u34 then
                    return
                end
                hideCelebration()
            end
        )
    end
    u25.Activated:Connect(hideCelebration)
    local LocalPlayer_upv_1 = game:GetService("Players").LocalPlayer
    local u39 = nil
    local function canShow()
        --[[
          name: canShow
          line: 653
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
        ]]
        if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true and not (a1.IsHudHiddenFor("Intro")) and not (a1.IsHudHiddenFor("Celebrate")) then
            local v53 = not State_upv_1.InMatch() or (a1.IsHudHiddenFor("MatchEnd"))
            return v53
        end
        return false
    end
    local function flushPending()
        --[[
          name: flushPending
          line: 659
          upvalues:
            u39 (ref,  index: 1)
            canShow (copy, index: 2)
            showCelebration (copy, index: 3)
        ]]
        if not u39 or not canShow() then
            return
        end
        u39 = nil
        showCelebration(u39.id)
    end
    Economy_upv_1.Celebrate:Connect(
        function(a8)
            --[[
              line: 666
              upvalues:
                u39 (ref,  index: 1)
                canShow (copy, index: 2)
                showCelebration (copy, index: 3)
            ]]
            if type(a8) == "string" then
                u39 = {id = a8}
                local v54 = u39
                if not v54 or not canShow() then
                    return
                end
                u39 = nil
                showCelebration(v54.id)
            end
        end
    )
    UI_upv_1.Every(
        u25,
        0.25,
        function()
            --[[
              line: 675
              upvalues:
                u35 (ref,  index: 1)
                u25 (copy, index: 2)
                canShow (copy, index: 3)
                hideCelebration (copy, index: 4)
                u39 (ref,  index: 5)
                showCelebration (copy, index: 6)
            ]]
            if u35 and u25.Visible and not (canShow()) then
                hideCelebration()
            end
            if not u39 or not canShow() then
                return
            end
            u39 = nil
            showCelebration(u39.id)
        end
    )
    local success_1, v55 = pcall(
        function()
            --[[
              line: 682
              upvalues:
                a1 (copy, index: 1)
            ]]
            require(script.Parent.Parent.ContractPodium).Init(a1)
        end
    )
    if not (success_1) then
        warn("[UI] contract podium failed: " .. tostring(v55))
    end
    a1.Debug.unlockEvent = function(a9)
        --[[
          line: 690
          upvalues:
            Economy_upv_1 (copy, index: 1)
            u39 (ref,  index: 2)
            u35 (ref,  index: 3)
        ]]
        local Celebrate_1 = Economy_upv_1.Celebrate
        local v56
        if type(a9) ~= "string" then
            v56 = "crossbow"
        else
            v56 = a9
        end
        Celebrate_1:Fire(v56)
        local tbl_9 = {showing = 0, pending = 0}
        tbl_9.pending = u39 ~= nil
        tbl_9.showing = u35
        return tbl_9
    end
    a1.Debug.unlockMoment = function(a10)
        --[[
          line: 694
          upvalues:
            showCelebration (copy, index: 1)
        ]]
        local v57
        if type(a10) ~= "string" then
            v57 = "crossbow"
        else
            v57 = a10
        end
        showCelebration(v57)
        return true
    end
    a1.Debug.collectionCard = function()
        --[[
          line: 699
          upvalues:
            u2 (copy, index: 1)
            Label_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
            Economy_upv_1 (copy, index: 4)
            u4 (copy, index: 5)
        ]]
        local tbl_10 = {}
        tbl_10.visible = u2.Visible
        tbl_10.label = Label_upv_1.Text
        tbl_10.focus = u3 or false
        tbl_10.ready = Economy_upv_1.UpgradesReady()
        tbl_10.badge = u4.Visible
        return tbl_10
    end
end
return tbl_1