local Ranks_upv_1 = require(game:GetService("ReplicatedStorage").Shared.Ranks)
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 26
      upvalues:
        Ranks_upv_1 (copy, index: 1)
        RankArt_upv_1 (copy, index: 2)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local MenuManager_upv_1 = a1.MenuManager
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Economy_upv_1 = a1.Economy
    local u1 = nil
    local tbl_upv_2 = {}
    local u2 = nil
    local u3 = nil
    local function trophies()
        --[[
          name: trophies
          line: 40
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        if u3 then
            return u3
        end
        local v1 = tonumber((State_upv_1.Profile or {}).trophies) or (tonumber(State_upv_1.Get("Trophies")) or 0)
        return (math.max(0, v1))
    end
    local function best()
        --[[
          name: best
          line: 47
          upvalues:
            State_upv_1 (copy, index: 1)
            Ranks_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
        ]]
        local v2 = tonumber((State_upv_1.Profile or {}).rankBest) or 1
        local RankOf_1 = Ranks_upv_1.RankOf
        local v3
        if u3 then
            v3 = u3
        else
            local v4 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
            v3 = math.max(0, v4)
        end
        return (math.max(v2, RankOf_1(v3)))
    end
    local function label(a2)
        --[[
          name: label
          line: 52
          upvalues:
            Fonts_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        local v5 = table.clone(a2)
        v5.FontFace = v5.FontFace or (Fonts_upv_1.Heavy)
        v5.TextColor3 = v5.TextColor3 or (Colors_upv_1.Text)
        v5.TextXAlignment = v5.TextXAlignment or (Enum.TextXAlignment.Left)
        return UI_upv_1.new("TextLabel", v5)
    end
    local u4 = nil
    local function weaponTile(a3, a4, a5, a6, a7, a8)
        --[[
          name: weaponTile
          line: 62
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            Economy_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            u4 (ref,  index: 7)
        ]]
        local new_1 = UI_upv_1.new
        local tbl_3 = {}
        tbl_3.Name = "W_" .. a4
        tbl_3.Text = ""
        tbl_3.AutoButtonColor = false
        tbl_3.Selectable = true
        tbl_3.Size = UDim2.fromOffset(100, 100)
        tbl_3.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_3.BackgroundTransparency = 0.2
        tbl_3.LayoutOrder = a5
        local v6 = UI_upv_1.Corner(Theme_upv_1.Radius.Large)
        local Stroke_1 = UI_upv_1.Stroke
        local v7
        if a6 then
            v7 = a7
        else
            v7 = Colors_upv_1.StrokeSoft
        end
        tbl_3[1], tbl_3[2] = v6, Stroke_1(v7, 1.5, (a6 and 0.35) or 0.4)
        tbl_3.Parent = a3
        local u5 = new_1("TextButton", tbl_3)
        local v8 = UI_upv_1.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.fromOffset(54, 54), Parent = u5})
        a1.WeaponIcon.Set(v8, a4, {outline = false})
        local v9 = (Economy_upv_1 and (Economy_upv_1.Owns(a4))) or false
        a1.WeaponIcon.SetDim(v8, not v9 and (not a6))
        local v10 = table.clone({Name = "Name", TextSize = 13, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 59), Size = UDim2.new(1, -8, 0, 15), Text = string.upper(a1.WeaponInfo.Name(a4)), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u5})
        v10.FontFace = v10.FontFace or (Fonts_upv_1.Heavy)
        v10.TextColor3 = v10.TextColor3 or (Colors_upv_1.Text)
        v10.TextXAlignment = v10.TextXAlignment or (Enum.TextXAlignment.Left)
        local _ = UI_upv_1.new("TextLabel", v10)
        local u6 = UI_upv_1.new("UIScale", {Scale = 1, Parent = u5})
        u5.MouseEnter:Connect(
            function()
                --[[
                  line: 92
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    a1 (copy, index: 2)
                    u6 (copy, index: 3)
                    Theme_upv_1 (copy, index: 4)
                ]]
                if (UI_upv_1.Touch) then
                    return
                end
                a1.Sounds.Play("Hover")
                UI_upv_1.Tween(u6, Theme_upv_1.Tween.PopSmall, {Scale = 1.06})
            end
        )
        u5.MouseLeave:Connect(
            function()
                --[[
                  line: 98
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u6 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                ]]
                UI_upv_1.Tween(u6, Theme_upv_1.Tween.Fast, {Scale = 1})
            end
        )
        u5.Activated:Connect(
            function()
                --[[
                  line: 101
                  upvalues:
                    a1 (copy, index: 1)
                    u4 (ref,  index: 2)
                    a4 (copy, index: 3)
                    a8 (copy, index: 4)
                ]]
                a1.Sounds.Play("Click")
                u4(a4, a8)
            end
        )
        local function status_1(a9, a10, a11)
            --[[
              name: status
              line: 106
              upvalues:
                Fonts_upv_1 (copy, index: 1)
                u5 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                UI_upv_1 (copy, index: 4)
            ]]
            local v11 = table.clone({Name = "Status", TextSize = 11, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, a11), Size = UDim2.new(1, -8, 0, 13), Text = a9, FontFace = Fonts_upv_1.Bold, TextColor3 = a10, TextXAlignment = Enum.TextXAlignment.Center, Parent = u5})
            v11.FontFace = v11.FontFace or (Fonts_upv_1.Heavy)
            v11.TextColor3 = v11.TextColor3 or (Colors_upv_1.Text)
            v11.TextXAlignment = v11.TextXAlignment or (Enum.TextXAlignment.Left)
            local _ = UI_upv_1.new("TextLabel", v11)
        end
        if v9 then
            status_1("OWNED", Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1), 78)
        else
            if a6 and Economy_upv_1 then
                local v12, v13 = Economy_upv_1.Progress(a4)
                local v14 = {Name = "Shards", Stroke = false}
                v14.AnchorPoint = Vector2.new(0.5, 0)
                v14.Position = UDim2.new(0.5, 0, 0, 77)
                v14.Size = UDim2.fromOffset(70, 5)
                v14.Color = a7
                v14.Parent = u5
                v14 = UI_upv_1.Bar(v14).Set
                v14(((v13 > 0) and (v12 / v13)) or 0, true)
                status_1(string.format("%d / %d", v12, v13), Colors_upv_1.TextDim, 84)
                return u5
            end
            UI_upv_1.Glyph("lock-closed", 16, Colors_upv_1.TextDim, {Name = "Lock", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 78), Parent = u5})
        end
        return u5
    end
    local function paintRow(a12, a13)
        --[[
          name: paintRow
          line: 133
          upvalues:
            Ranks_upv_1 (copy, index: 1)
            RankArt_upv_1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            u3 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            weaponTile (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
        ]]
        local v15 = Ranks_upv_1.Get(a13)
        local v16 = RankArt_upv_1.Color(a13)
        local v17 = tonumber((State_upv_1.Profile or {}).rankBest) or 1
        local RankOf_2 = Ranks_upv_1.RankOf
        local v18
        if u3 then
            v18 = u3
        else
            local v19 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
            v18 = math.max(0, v19)
        end
        local v20 = math.max(v17, RankOf_2(v18))
        local v21
        if u3 then
            v21 = u3
        else
            local v22 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
            v21 = math.max(0, v22)
        end
        local v23 = a13 <= v20
        local v24 = a13 == Ranks_upv_1.RankOf(v21)
        local stroke_1 = a12.stroke
        local v25
        if v24 then
            v25 = v16
        else
            v25 = Colors_upv_1.Stroke
        end
        stroke_1.Color = v25
        a12.stroke.Transparency = (v24 and 0.15) or 0.9
        a12.frame.BackgroundTransparency = (v24 and 0.05) or 0.25
        local name_1 = a12.name
        if v23 then
            v25 = v16
        else
            v25 = Colors_upv_1.TextDim
        end
        name_1.TextColor3 = v25
        a12.emblemHolder.GroupTransparency = (v23 and 0) or 0.45
        for _, value_1 in a12.weapons:GetChildren() do
            if value_1:IsA("GuiObject") then
                value_1:Destroy()
            end
        end
        if #v15.items > 0 then
            for key_1, value_2 in v15.items do
                weaponTile(a12.weapons, value_2, key_1, v23, v16, a13)
            end
            a12.note.Visible = false
        else
            a12.note.Visible = true
            local note_1 = a12.note
            note_1.Text = a13 == 1 and "All starter weapons" or a13 ~= Ranks_upv_1.Count() and "A Rank Reward" or "The top rank"
        end
        if v24 then
            a12.state.Text = "YOU ARE HERE"
            a12.state.TextColor3 = v16
        elseif v23 then
            a12.state.Text = "REACHED"
            a12.state.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1)
        else
            a12.state.Text = string.format("%s TO GO", UI_upv_1.FormatNumber(v15.trophies - v21))
            a12.state.TextColor3 = Colors_upv_1.TextMuted
        end
    end
    local function paint()
        --[[
          name: paint
          line: 171
          upvalues:
            u3 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            Ranks_upv_1 (copy, index: 3)
            RankArt_upv_1 (copy, index: 4)
            tbl_upv_2 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            paintRow (copy, index: 7)
        ]]
        local v27
        if u3 then
            v27 = u3
        else
            local v28 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
            v27 = math.max(0, v28)
        end
        local v29, v30, v31 = Ranks_upv_1.Progress(v27)
        local v32 = RankArt_upv_1.Color(v29)
        RankArt_upv_1.SetEmblem(tbl_upv_2.bigEmblem, v29)
        tbl_upv_2.rankName.Text = string.upper(Ranks_upv_1.Get(v29).name)
        tbl_upv_2.rankName.TextColor3 = v32
        tbl_upv_2.count.Text = UI_upv_1.FormatNumber(v27)
        tbl_upv_2.bar.SetColor(v32)
        tbl_upv_2.bar.Set((v31 and (v30 / v31)) or 1, true)
        local next_1 = tbl_upv_2.next
        next_1.Text = not v31 and "You reached the top rank" or string.format("%s more trophies to %s", UI_upv_1.FormatNumber(v31 - v30), string.upper(Ranks_upv_1.Get(v29 + 1).name))
        tbl_upv_2.best.Text = string.format("BEST  %s", UI_upv_1.FormatNumber(math.max(tonumber((State_upv_1.Profile or {}).trophiesBest) or 0, v27)))
        tbl_upv_2.glow.ImageColor3 = v32
        for key_2, value_3 in tbl_upv_2.rows do
            paintRow(value_3, key_2)
        end
    end
    local function scrollTo(a14)
        --[[
          name: scrollTo
          line: 192
          upvalues:
            Ranks_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        tbl_upv_2.scroll.CanvasPosition = Vector2.new(0, math.max(0, ((Ranks_upv_1.Count() - a14) * 122 - (tbl_upv_2.scroll.AbsoluteWindowSize.Y / math.max(0.01, UI_upv_1.Scale) / 2)) + 56))
    end
    local function close()
        --[[
          name: close
          line: 36
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("Ranks")
    end
    local function build()
        --[[
          name: build
          line: 200
          upvalues:
            u1 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            close (copy, index: 4)
            tbl_upv_2 (copy, index: 5)
            RankArt_upv_1 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            Ranks_upv_1 (copy, index: 9)
            Theme_upv_1 (copy, index: 10)
        ]]
        local v34 = UI_upv_1.Window({HeaderHeight = 80, Subtitle = "Win matches to earn trophies. Every rank adds new weapons to your drops.", Name = "Ranks", Title = "RANK ROAD", Size = UDim2.fromOffset(1060, 660), Parent = a1.Canvas.Menus, OnCloseRequested = close})
        u1 = v34
        UI_upv_1.SelectionRing(u1.Root)
        local Content_upv_1 = u1.Content
        local v35 = UI_upv_1.Panel({Name = "You", ClipsDescendants = true, BackgroundTransparency = 0.25, Position = UDim2.fromOffset(0, 0), Size = UDim2.new(0, 320, 1, 0), Parent = Content_upv_1})
        tbl_upv_2.glow = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 200), Size = UDim2.fromOffset(440, 440), Parent = v35})
        tbl_upv_2.bigEmblem = RankArt_upv_1.Emblem(1, 210, {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 84), Parent = v35})
        tbl_upv_2.rankName = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "", Name = "RankName", ZIndex = 2, TextSize = 42, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 304), Size = UDim2.new(1, -24, 0, 46), TextColor3 = Colors_upv_1.Text, Parent = v35})
        local v36 = UI_upv_1.new("Frame", {Name = "Count", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 356), Size = UDim2.new(1, -24, 0, 34), ZIndex = 2, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v35})
        RankArt_upv_1.Trophy(30, {LayoutOrder = 1, ZIndex = 2, Parent = v36})
        tbl_upv_2.count = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "0", Name = "N", TextSize = 30, ZIndex = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 34), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = v36})
        tbl_upv_2.bar = UI_upv_1.Bar({Name = "Bar", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 404), Size = UDim2.new(1, -56, 0, 14), Color = Colors_upv_1.Gold, Parent = v35})
        v36 = table.clone({Text = "", Name = "Next", TextSize = 15, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 424), Size = UDim2.new(1, -40, 0, 20), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Center, Parent = v35})
        v36.FontFace = v36.FontFace or (Fonts_upv_1.Heavy)
        v36.TextColor3 = v36.TextColor3 or (Colors_upv_1.Text)
        v36.TextXAlignment = v36.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_upv_2.next = UI_upv_1.new("TextLabel", v36)
        local v37 = table.clone({Text = "", Name = "Best", TextSize = 13, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 450), Size = UDim2.new(1, -40, 0, 18), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Center, Parent = v35})
        v37.FontFace = v37.FontFace or (Fonts_upv_1.Heavy)
        v37.TextColor3 = v37.TextColor3 or (Colors_upv_1.Text)
        v37.TextXAlignment = v37.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_upv_2.best = UI_upv_1.new("TextLabel", v37)
        local v38 = UI_upv_1.Button({Style = "Dark", Name = "PlayerCard", Text = "PLAYER CARD", TextSize = 20, Size = UDim2.new(1, -32, 0, 52), AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), Parent = v35})
        v38.Instance.ZIndex = 3
        v38.Activated:Connect(
            function()
                --[[
                  line: 296
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1.MenuManager.Open("PlayerCard")
            end
        )
        local new_2 = UI_upv_1.new
        local tbl_4 = {}
        tbl_4.Name = "Ladder"
        tbl_4.Position = UDim2.fromOffset(336, 0)
        tbl_4.Size = UDim2.new(1, -336, 1, 0)
        tbl_4.CanvasSize = UDim2.new()
        tbl_4.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tbl_4.ScrollBarThickness = ((UI_upv_1.Touch) and 0) or 6
        tbl_4.ScrollBarImageColor3 = Colors_upv_1.TextMuted
        tbl_4.ScrollBarImageTransparency = 0.4
        tbl_4.ScrollingDirection = Enum.ScrollingDirection.Y
        tbl_4.BorderSizePixel = 0
        tbl_4.BackgroundTransparency = 1
        tbl_4[1], tbl_4[2] = UI_upv_1.List(Enum.FillDirection.Vertical, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top), UI_upv_1.Padding(2, 12, 2, 2)
        tbl_4.Parent = Content_upv_1
        tbl_upv_2.scroll = new_2("ScrollingFrame", tbl_4)
        local function fade_1(a15, a16, a17)
            --[[
              name: fade
              line: 317
              upvalues:
                UI_upv_1 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
                Content_upv_1 (copy, index: 3)
            ]]
            local v39 = UI_upv_1.new("Frame", {Name = "Fade", ZIndex = 5, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, a16), Position = UDim2.new(0, 336, a15, 0), Size = UDim2.new(1, -348, 0, 34), BackgroundColor3 = Colors_upv_1.Panel, Parent = Content_upv_1})
            UI_upv_1.new("UIGradient", {Rotation = a17, Transparency = NumberSequence.new(0, 1), Parent = v39})
        end
        fade_1(0, 0, 90)
        fade_1(1, 1, 270)
        tbl_upv_2.rows = {}
        local v40 = Ranks_upv_1.Count()
        for n_1 = 1, v40 do
            local v41 = Ranks_upv_1.Get(n_1)
            local v42 = UI_upv_1.new("Frame", {Name = "Rank_" .. v41.id, Size = UDim2.new(1, 0, 0, 112), BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.25, LayoutOrder = v40 - n_1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Large), Parent = tbl_upv_2.scroll})
            local v43 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 2, 0.9)
            v43.Parent = v42
            local v44 = UI_upv_1.new("CanvasGroup", {Name = "EmblemHolder", BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(92, 92), Parent = v42})
            RankArt_upv_1.Emblem(n_1, 92, {Parent = v44})
            local v45 = UI_upv_1.DisplayText({StrokeThickness = 1.5, Name = "Name", TextSize = 30, Position = UDim2.fromOffset(114, 16), Size = UDim2.fromOffset(200, 34), Text = string.upper(v41.name), TextXAlignment = Enum.TextXAlignment.Left, Parent = v42})
            local v46 = UI_upv_1.new("Frame", {Name = "Trophies", Position = UDim2.fromOffset(114, 54), Size = UDim2.fromOffset(200, 24), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v42})
            RankArt_upv_1.Trophy(20, {LayoutOrder = 1, Parent = v46})
            local v47 = table.clone({LayoutOrder = 2, Name = "N", TextSize = 20, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 24), Text = UI_upv_1.FormatNumber(v41.trophies), FontFace = Fonts_upv_1.Display, Parent = v46})
            v47.FontFace = v47.FontFace or (Fonts_upv_1.Heavy)
            v47.TextColor3 = v47.TextColor3 or (Colors_upv_1.Text)
            v47.TextXAlignment = v47.TextXAlignment or (Enum.TextXAlignment.Left)
            local _ = UI_upv_1.new("TextLabel", v47)
            v41 = table.clone({Name = "State", Text = "", TextSize = 14, Position = UDim2.fromOffset(114, 80), Size = UDim2.fromOffset(200, 18), FontFace = Fonts_upv_1.Heavy, Parent = v42})
            v41.FontFace = v41.FontFace or (Fonts_upv_1.Heavy)
            v41.TextColor3 = v41.TextColor3 or (Colors_upv_1.Text)
            v41.TextXAlignment = v41.TextXAlignment or (Enum.TextXAlignment.Left)
            v46 = UI_upv_1.new("TextLabel", v41)
            local v48 = UI_upv_1.new("Frame", {Name = "Weapons", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(1, -330, 0, 92), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v42})
            local v49 = table.clone({Visible = false, Text = "", Name = "Note", TextWrapped = true, TextSize = 15, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -18, 0.5, 0), Size = UDim2.new(1, -340, 0, 40), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v42})
            v49.FontFace = v49.FontFace or (Fonts_upv_1.Heavy)
            v49.TextColor3 = v49.TextColor3 or (Colors_upv_1.Text)
            v49.TextXAlignment = v49.TextXAlignment or (Enum.TextXAlignment.Left)
            tbl_upv_2.rows[n_1] = {frame = v42, stroke = v43, emblemHolder = v44, name = v45, state = v46, weapons = v48, note = UI_upv_1.new("TextLabel", v49)}
        end
    end
    local tbl_upv_5 = nil
    local function hideInfo()
        --[[
          name: hideInfo
          line: 388
          upvalues:
            tbl_upv_5 (ref, index: 1)
        ]]
        if not tbl_upv_5 then
            return
        end
        tbl_upv_5.root.Visible = false
    end
    local function buildInfo()
        --[[
          name: buildInfo
          line: 393
          upvalues:
            tbl_upv_5 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u1 (ref,  index: 4)
            hideInfo (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            RankArt_upv_1 (copy, index: 8)
        ]]
        if tbl_upv_5 then
            return
        end
        tbl_upv_5 = {}
        tbl_upv_5.root = UI_upv_1.new("TextButton", {Visible = false, Selectable = false, Text = "", AutoButtonColor = false, Name = "ItemInfo", BackgroundTransparency = 0.35, ZIndex = 40, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = u1.Root})
        tbl_upv_5.root.Activated:Connect(hideInfo)
        local v50 = UI_upv_1.Panel({Name = "Card", ZIndex = 41, BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(660, 392), Parent = tbl_upv_5.root})
        tbl_upv_5.card = v50
        UI_upv_1.new("TextButton", {ZIndex = 41, Name = "Swallow", AutoButtonColor = false, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v50})
        tbl_upv_5.tile = UI_upv_1.new("Frame", {Name = "Tile", Position = UDim2.fromOffset(20, 20), Size = UDim2.fromOffset(210, 210), BackgroundColor3 = Colors_upv_1.PanelHi, ZIndex = 42, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Large), Parent = v50})
        tbl_upv_5.glow = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ZIndex = 42, ImageTransparency = 0.6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(260, 260), Parent = tbl_upv_5.tile})
        tbl_upv_5.icon = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 43, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(176, 176), Parent = tbl_upv_5.tile})
        tbl_upv_5.name = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "", Name = "Name", ZIndex = 42, TextSize = 38, Position = UDim2.fromOffset(252, 20), Size = UDim2.fromOffset(340, 42), TextXAlignment = Enum.TextXAlignment.Left, Parent = v50})
        local v51 = table.clone({ZIndex = 42, Name = "Sub", Text = "", TextSize = 15, Position = UDim2.fromOffset(252, 64), Size = UDim2.fromOffset(390, 20), FontFace = Fonts_upv_1.Heavy, Parent = v50})
        v51.FontFace = v51.FontFace or (Fonts_upv_1.Heavy)
        v51.TextColor3 = v51.TextColor3 or (Colors_upv_1.Text)
        v51.TextXAlignment = v51.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_upv_5.sub = UI_upv_1.new("TextLabel", v51)
        local v52 = table.clone({Text = "", ZIndex = 42, Name = "Desc", TextWrapped = true, TextSize = 16, Position = UDim2.fromOffset(252, 92), Size = UDim2.fromOffset(390, 64), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextYAlignment = Enum.TextYAlignment.Top, Parent = v50})
        v52.FontFace = v52.FontFace or (Fonts_upv_1.Heavy)
        v52.TextColor3 = v52.TextColor3 or (Colors_upv_1.Text)
        v52.TextXAlignment = v52.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_upv_5.desc = UI_upv_1.new("TextLabel", v52)
        tbl_upv_5.stats = {}
        for n_2 = 1, 4 do
            local v53 = (n_2 - 1) * 18 + 162
            local v54 = table.clone({Text = "", ZIndex = 42, TextSize = 12, Name = "StatL" .. n_2, Position = UDim2.fromOffset(252, v53), Size = UDim2.fromOffset(92, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v50})
            v54.FontFace = v54.FontFace or Fonts_upv_1.Heavy
            v54.TextColor3 = v54.TextColor3 or Colors_upv_1.Text
            local TextXAlignment_1 = v54.TextXAlignment
            if not (TextXAlignment_1) then
                local _ = Enum.TextXAlignment.Left
            end
            v54.TextXAlignment = TextXAlignment_1
            local v57 = UI_upv_1.new("TextLabel", v54)
            local v58 = UI_upv_1.Bar({Stroke = false, Name = "StatB" .. n_2, Position = UDim2.fromOffset(348, v53 + 4), Size = UDim2.fromOffset(200, 8), Color = Colors_upv_1.Accent, Parent = v50})
            v58.Frame.ZIndex = 42
            v58.Fill.ZIndex = 43
            local v59 = table.clone({Text = "", ZIndex = 42, TextSize = 12, Name = "StatV" .. n_2, Position = UDim2.fromOffset(556, v53), Size = UDim2.fromOffset(84, 16), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = v50})
            v59.FontFace = v59.FontFace or (Fonts_upv_1.Heavy)
            v59.TextColor3 = v59.TextColor3 or (Colors_upv_1.Text)
            v59.TextXAlignment = v59.TextXAlignment or (Enum.TextXAlignment.Left)
            local v60 = UI_upv_1.new("TextLabel", v59)
            tbl_upv_5.stats[n_2] = {label = v57, bar = v58, value = v60}
        end
        tbl_upv_5.state = UI_upv_1.new("Frame", {Name = "State", Position = UDim2.fromOffset(20, 248), Size = UDim2.fromOffset(620, 50), BackgroundColor3 = Colors_upv_1.PanelLo, BackgroundTransparency = 0.2, ZIndex = 42, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Medium), Parent = v50})
        tbl_upv_5.stateEmblem = RankArt_upv_1.Emblem(1, 38, {ZIndex = 43, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Parent = tbl_upv_5.state})
        local v61 = table.clone({ZIndex = 43, Name = "Text", Text = "", TextSize = 16, Position = UDim2.fromOffset(56, 0), Size = UDim2.new(1, -66, 1, 0), FontFace = Fonts_upv_1.Heavy, Parent = tbl_upv_5.state})
        v61.FontFace = v61.FontFace or (Fonts_upv_1.Heavy)
        v61.TextColor3 = v61.TextColor3 or (Colors_upv_1.Text)
        v61.TextXAlignment = v61.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_upv_5.stateText = UI_upv_1.new("TextLabel", v61)
        tbl_upv_5.close = UI_upv_1.Button({Radius = 14, Text = "CLOSE", Name = "Close", Style = "Dark", ZIndex = 42, TextSize = 20, Size = UDim2.fromOffset(200, 58), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -20, 1, -18), Parent = v50})
        tbl_upv_5.close.Activated:Connect(hideInfo)
    end
    local function statValue(a18, a19)
        --[[
          name: statValue
          line: 428
        ]]
        if a19.value then
            return a19.value
        end
        if type(a18.details) == "table" then
            for _, value_4 in a18.details do
                if type(value_4) ~= "table" or type(value_4[1]) ~= "string" or string.upper(value_4[1]) ~= a19.label then
                    continue
                end
                return (tostring(value_4[2]))
            end
        end
        return string.format("%d / 10", math.floor((a19.frac * 10) + 0.5))
    end
    u4 = function(a20, a21)
        --[[
          line: 442
          upvalues:
            a1 (copy, index: 1)
            u1 (ref,  index: 2)
            buildInfo (copy, index: 3)
            tbl_upv_5 (ref,  index: 4)
            RankArt_upv_1 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            statValue (copy, index: 7)
            Ranks_upv_1 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            State_upv_1 (copy, index: 10)
            u3 (ref,  index: 11)
            UI_upv_1 (copy, index: 12)
        ]]
        local v78
        local v62 = a1.WeaponInfo.Get(a20)
        if not v62 or not u1 then
            return
        end
        buildInfo()
        tbl_upv_5.id = a20
        local v63 = RankArt_upv_1.Color(a21)
        local v64, v64
        v64 = a1.WeaponInfo.CATEGORY_COLORS and a1.WeaponInfo.CATEGORY_COLORS[v62.category] or v63
        a1.WeaponIcon.Set(tbl_upv_5.icon, a20, {outline = true, spin = true})
        a1.WeaponIcon.SetDim(tbl_upv_5.icon, false)
        tbl_upv_5.glow.ImageColor3 = v64
        local name_2 = tbl_upv_5.name
        name_2.Text = string.upper(v62.name)
        local sub_1 = tbl_upv_5.sub
        local v65 = string.upper(a1.WeaponInfo.CATEGORY_SINGULAR[v62.category] or (v62.category or ""))
        sub_1.Text = string.format("%s  \194\183  %d POINT%s", v65, v62.points or 0, (((v62.points or 0) ~= 1) and "S") or "")
        local sub_2 = tbl_upv_5.sub
        sub_2.TextColor3 = v64:Lerp(Colors_upv_1.TextDim, 0.3)
        local v66 = ((not (a1.WeaponInfo.SpeedNote)) and "") or (a1.WeaponInfo.SpeedNote(v62))
        local v67 = tbl_upv_5.desc
        local v68
        if v66 == "" then
            v68 = v62.description or ""
        else
            v68 = v66 .. " " .. (v62.description or "")
        end
        v67.Text = v68
        local v69 = a1.WeaponInfo.Bars(v62)
        for key_3, value_5 in tbl_upv_5.stats do
            local v70 = v69[key_3]
            value_5.label.Visible = v70 ~= nil
            value_5.bar.Frame.Visible = v70 ~= nil
            value_5.value.Visible = v70 ~= nil
            if v70 then
                value_5.label.Text = v70.label
                value_5.bar.Set(v70.frac, true)
                value_5.bar.SetColor(v64)
                value_5.value.Text = statValue(v62, v70)
            end
        end
        RankArt_upv_1.SetEmblem(tbl_upv_5.stateEmblem, a21)
        local v71 = string.upper(Ranks_upv_1.Get(a21).name)
        local Economy_2 = a1.Economy
        if (Economy_2) and (Economy_2.Owns(a20)) then
            local v72 = Economy_2.Level(a20)
            local stateText_1 = tbl_upv_5.stateText
            stateText_1.Text = string.format("OWNED  \194\183  LV %d", math.max(v72, 1))
            local stateText_2 = tbl_upv_5.stateText
            stateText_2.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1)
        else
            local v73 = tonumber((State_upv_1.Profile or {}).rankBest) or 1
            local RankOf_3 = Ranks_upv_1.RankOf
            local v74
            if u3 then
                v74 = u3
            else
                local v75 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
                v74 = math.max(0, v75)
            end
            if a21 <= math.max(v73, RankOf_3(v74)) then
                v67 = 0
                v68 = 0
                if Economy_2 then
                    local v76, v77 = Economy_2.Progress(a20)
                    v67, v68 = v76, v77
                end
                local stateText_3 = tbl_upv_5.stateText
                stateText_3.Text = string.format("UNLOCKED AT %s  \194\183  %d / %d SHARDS  \194\183  FIND SHARDS IN DROPS", v71, v67, v68)
                tbl_upv_5.stateText.TextColor3 = Colors_upv_1.Text
            else
                if u3 then
                    v78 = u3
                else
                    local v79 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
                    v78 = math.max(0, v79)
                end
                local stateText_4 = tbl_upv_5.stateText
                stateText_4.Text = string.format("REACH %s (%s TROPHIES) TO ADD IT TO YOUR DROPS", v71, UI_upv_1.FormatNumber(math.max(0, Ranks_upv_1.Get(a21).trophies - v78)) .. " MORE")
                tbl_upv_5.stateText.TextColor3 = v63
            end
        end
        tbl_upv_5.root.Visible = true
        UI_upv_1.Pop(tbl_upv_5.card, 0.9, Theme_upv_1.Tween.PopSmall)
    end
    local tbl_6 = {}
    function tbl_6.open()
        --[[
          name: open
          line: 497
          upvalues:
            u1 (ref,  index: 1)
            build (copy, index: 2)
            a1 (copy, index: 3)
            paint (copy, index: 4)
            u2 (ref,  index: 5)
            Ranks_upv_1 (copy, index: 6)
            u3 (ref,  index: 7)
            State_upv_1 (copy, index: 8)
            tbl_upv_2 (copy, index: 9)
            UI_upv_1 (copy, index: 10)
        ]]
        if not (u1) then
            build()
        end
        a1.SetHudHidden("Ranks", true)
        paint()
        u1:Open()
        local u7 = u2
        if not (u7) then
            local RankOf_4 = Ranks_upv_1.RankOf
            local v80
            if u3 then
                v80 = u3
            else
                local v81 = tonumber((State_upv_1.Profile or {}).trophies) or tonumber(State_upv_1.Get("Trophies")) or 0
                v80 = math.max(0, v81)
            end
            u7 = RankOf_4(v80)
        end
        u2 = nil
        task.defer(
            function()
                --[[
                  line: 506
                  upvalues:
                    u7 (copy, index: 1)
                    Ranks_upv_1 (copy, index: 2)
                    tbl_upv_2 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                ]]
                tbl_upv_2.scroll.CanvasPosition = Vector2.new(0, math.max(0, ((Ranks_upv_1.Count() - u7) * 122 - (tbl_upv_2.scroll.AbsoluteWindowSize.Y / math.max(0.01, UI_upv_1.Scale) / 2)) + 56))
            end
        )
        UI_upv_1.Pop(tbl_upv_2.bigEmblem, 0.7)
    end
    function tbl_6.close(a22)
        --[[
          name: close
          line: 511
          upvalues:
            tbl_upv_5 (ref,  index: 1)
            a1 (copy, index: 2)
            u3 (ref,  index: 3)
            u1 (ref,  index: 4)
        ]]
        if tbl_upv_5 then
            tbl_upv_5.root.Visible = false
        end
        a1.SetHudHidden("Ranks", false)
        u3 = nil
        u1:Close(a22)
    end
    MenuManager_upv_1.Register("Ranks", tbl_6)
    local function refresh()
        --[[
          name: refresh
          line: 519
          upvalues:
            u1 (ref,  index: 1)
            MenuManager_upv_1 (copy, index: 2)
            paint (copy, index: 3)
        ]]
        if not u1 or not MenuManager_upv_1.IsOpen("Ranks") then
            return
        end
        paint()
    end
    State_upv_1.ProfileChanged:Connect(refresh)
    State_upv_1.AttrChanged:Connect(
        function(a23)
            --[[
              line: 525
              upvalues:
                u1 (ref,  index: 1)
                MenuManager_upv_1 (copy, index: 2)
                paint (copy, index: 3)
            ]]
            if (a23 == "Trophies" or a23 == "RankBest") and (u1) and (MenuManager_upv_1.IsOpen("Ranks")) then
                paint()
            end
        end
    )
    local tbl_7 = {}
    function tbl_7.Focus(a24)
        --[[
          name: Focus
          line: 533
          upvalues:
            u2 (ref, index: 1)
        ]]
        u2 = a24
    end
    function tbl_7.OpenAt(a25)
        --[[
          name: OpenAt
          line: 536
          upvalues:
            u2 (ref,  index: 1)
            MenuManager_upv_1 (copy, index: 2)
        ]]
        u2 = a25
        MenuManager_upv_1.Open("Ranks")
    end
    a1.RankRoad = tbl_7
    a1.Debug.rankInfo = function(a26)
        --[[
          line: 542
          upvalues:
            u1 (ref,  index: 1)
            MenuManager_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u4 (ref,  index: 4)
        ]]
        if not (u1) or not (MenuManager_upv_1.IsOpen("Ranks")) then
            MenuManager_upv_1.Open("Ranks")
        end
        local Economy_3 = a1.Economy
        local str_1 = tostring(a26)
        local v82 = ((not Economy_3) and 1) or (Economy_3.ItemRank(tostring(a26)))
        u4(str_1, v82)
        return true
    end
    a1.Debug.ranks = function(a27)
        --[[
          line: 550
          upvalues:
            u3 (ref,  index: 1)
            MenuManager_upv_1 (copy, index: 2)
        ]]
        u3 = tonumber(a27)
        MenuManager_upv_1.Open("Ranks")
        return true
    end
end
return tbl_1