local replicatedStorage = game:GetService("ReplicatedStorage")
local Ranks = require(replicatedStorage.Shared.Ranks)
local RankArt = require(script.Parent.Parent.RankArt)

return {
    Init = (function(a4)
        --[[
          name: Init
          line: 26
          upvalues:
            Ranks (copy, index: 1)
            RankArt (copy, index: 2)
        ]]
        local ui = a4.UI
        local theme = a4.Theme
        local state = a4.State
        local menuManager = a4.MenuManager
        local colors = theme.Colors
        local fonts = theme.Fonts
        local economy = a4.Economy
        local v12 = nil
        local v13 = {}
        local v14 = nil
        local number = nil

        local function close()
            --[[
              name: close
              line: 36
              upvalues:
                menuManager (copy, index: 1)
            ]]
            menuManager.Close("Ranks")
        end

        local function trophies()
            --[[
              name: trophies
              line: 40
              upvalues:
                number (ref,  index: 1)
                state (copy, index: 2)
            ]]
            if number then
                return number
            end

            local v18 = state.Profile or {}

            return (math.max(0, (tonumber(v18.trophies) or tonumber(state.Get("Trophies")) or 0)))
        end

        local function best()
            --[[
              name: best
              line: 47
              upvalues:
                state (copy, index: 1)
                Ranks (copy, index: 2)
                number (ref,  index: 3)
            ]]
            local v20
            local v21 = state.Profile or {}
            local number2 = tonumber(v21.rankBest) or 1
            local rankOf = Ranks.RankOf

            if number then
                v20 = number
            else
                local v24 = state.Profile or {}
                v20 = math.max(0, (tonumber(v24.trophies) or tonumber(state.Get("Trophies")) or 0))
            end

            return (math.max(number2, rankOf(v20)))
        end

        local function label(a26)
            --[[
              name: label
              line: 52
              upvalues:
                fonts (copy, index: 1)
                colors (copy, index: 2)
                ui (copy, index: 3)
            ]]
            local values = table.clone(a26)
            values.FontFace = values.FontFace or fonts.Heavy
            values.TextColor3 = values.TextColor3 or colors.Text
            values.TextXAlignment = values.TextXAlignment or Enum.TextXAlignment.Left

            return ui.new("TextLabel", values)
        end

        local v28 = nil

        local function weaponTile(parent, item, layoutOrder, a33: boolean, color, a35: number)
            --[[
              name: weaponTile
              line: 62
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                theme (copy, index: 3)
                a4 (copy, index: 4)
                economy (copy, index: 5)
                fonts (copy, index: 6)
                v28 (ref,  index: 7)
            ]]
            local newUi = ui.new
            local v37 = {Name = "W_" .. item, Text = "", AutoButtonColor = false, Selectable = true, Size = UDim2.fromOffset(100, 100), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.2, LayoutOrder = layoutOrder}
            local v38 = ui.Corner(theme.Radius.Large)
            local stroke = ui.Stroke
            local v40 = if a33 then color else colors.StrokeSoft
            local v41 = a33 and 0.35 or 0.4
            v37[1], v37[2] = v38, (stroke(v40, 1.5, v41))
            v37.Parent = parent
            local parent2 = newUi("TextButton", v37)
            local ui2 = ui.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.fromOffset(54, 54), Parent = parent2})
            a4.WeaponIcon.Set(ui2, item, {outline = false})
            local v44 = economy and economy.Owns(item) or false
            a4.WeaponIcon.SetDim(ui2, not v44 and not a33)
            local v45 = {Name = "Name", TextSize = 13, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 59), Size = UDim2.new(1, -8, 0, 15), Text = string.upper(a4.WeaponInfo.Name(item)), TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent2}
            local values = table.clone(v45)
            values.FontFace = values.FontFace or fonts.Heavy
            values.TextColor3 = values.TextColor3 or colors.Text
            values.TextXAlignment = values.TextXAlignment or Enum.TextXAlignment.Left
            ui.new("TextLabel", values)
            local ui3 = ui.new("UIScale", {Scale = 1, Parent = parent2})

            parent2.MouseEnter:Connect(
                function()
                    --[[
                      line: 92
                      upvalues:
                        ui (copy, index: 1)
                        a4 (copy, index: 2)
                        ui3 (copy, index: 3)
                        theme (copy, index: 4)
                    ]]
                    if not ui.Touch then
                        a4.Sounds.Play("Hover")
                        ui.Tween(ui3, theme.Tween.PopSmall, {Scale = 1.06})
                    end
                end
            )

            parent2.MouseLeave:Connect(
                function()
                    --[[
                      line: 98
                      upvalues:
                        ui (copy, index: 1)
                        ui3 (copy, index: 2)
                        theme (copy, index: 3)
                    ]]
                    ui.Tween(ui3, theme.Tween.Fast, {Scale = 1})
                end
            )

            parent2.Activated:Connect(
                function()
                    --[[
                      line: 101
                      upvalues:
                        a4 (copy, index: 1)
                        v28 (ref,  index: 2)
                        item (copy, index: 3)
                        a35 (copy, index: 4)
                    ]]
                    a4.Sounds.Play("Click")
                    v28(item, a35)
                end
            )

            local function status(text: string, textColor3, a51: number)
                --[[
                  name: status
                  line: 106
                  upvalues:
                    fonts (copy, index: 1)
                    parent2 (copy, index: 2)
                    colors (copy, index: 3)
                    ui (copy, index: 4)
                ]]
                local v52 = {Name = "Status", TextSize = 11, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, a51), Size = UDim2.new(1, -8, 0, 13), Text = text, FontFace = fonts.Bold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent2}
                local values = table.clone(v52)
                values.FontFace = values.FontFace or fonts.Heavy
                values.TextColor3 = values.TextColor3 or colors.Text
                values.TextXAlignment = values.TextXAlignment or Enum.TextXAlignment.Left
                ui.new("TextLabel", values)
            end

            if v44 then
                status("OWNED", theme.Lighten(colors.Success, 0.1), 78)
                return parent2
            end

            if not a33 or not economy then
                ui.Glyph("lock-closed", 16, colors.TextDim, {Name = "Lock", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 78), Parent = parent2})
                return parent2
            end

            local v54, v55 = economy.Progress(item)
            local v56 = ui.Bar({Name = "Shards", Stroke = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 77), Size = UDim2.fromOffset(70, 5), Color = color, Parent = parent2})
            local set = v56.Set
            local v58 = not (0 < v55) and 0 or v54 / v55
            set(v58, true)
            status(string.format("%d / %d", v54, v55), colors.TextDim, 84)

            return parent2
        end

        local function paintRow(row, a61: number)
            --[[
              name: paintRow
              line: 133
              upvalues:
                Ranks (copy, index: 1)
                RankArt (copy, index: 2)
                state (copy, index: 3)
                number (ref,  index: 4)
                colors (copy, index: 5)
                weaponTile (copy, index: 6)
                theme (copy, index: 7)
                ui (copy, index: 8)
            ]]
            local v62
            local v63
            local v64 = Ranks.Get(a61)
            local textColor3 = RankArt.Color(a61)
            local v66 = state.Profile or {}
            local number2 = tonumber(v66.rankBest) or 1
            local rankOf = Ranks.RankOf

            if number then
                v62 = number
            else
                local v69 = state.Profile or {}
                v62 = math.max(0, (tonumber(v69.trophies) or tonumber(state.Get("Trophies")) or 0))
            end

            local v70 = math.max(number2, rankOf(v62))

            if number then
                v63 = number
            else
                local v71 = state.Profile or {}
                v63 = math.max(0, (tonumber(v71.trophies) or tonumber(state.Get("Trophies")) or 0))
            end

            local v72 = a61 <= v70
            local v73 = a61 == Ranks.RankOf(v63)
            row.stroke.Color = if v73 then textColor3 else colors.Stroke
            row.stroke.Transparency = v73 and 0.15 or 0.9
            row.frame.BackgroundTransparency = v73 and 0.05 or 0.25
            row.name.TextColor3 = if v72 then textColor3 else colors.TextDim
            row.emblemHolder.GroupTransparency = v72 and 0 or 0.45

            for _, child in row.weapons:GetChildren() do
                if child:IsA("GuiObject") then
                    child:Destroy()
                end
            end

            if not (0 < #v64.items) then
                row.note.Visible = true
                local note = row.note
                local text = a61 ~= 1 and (a61 ~= Ranks.Count() and "A Rank Reward" or "The top rank")
                    or "All starter weapons"
                note.Text = text
            else
                for layoutOrder, item in v64.items do
                    weaponTile(row.weapons, item, layoutOrder, v72, textColor3, a61)
                end

                row.note.Visible = false
            end

            if v73 then
                row.state.Text = "YOU ARE HERE"
                row.state.TextColor3 = textColor3

                return
            end

            if v72 then
                row.state.Text = "REACHED"
                row.state.TextColor3 = theme.Lighten(colors.Success, 0.1)

                return
            end

            row.state.Text = string.format("%s TO GO", ui.FormatNumber(v64.trophies - v63))
            row.state.TextColor3 = colors.TextMuted
        end

        local function paint()
            --[[
              name: paint
              line: 171
              upvalues:
                number (ref,  index: 1)
                state (copy, index: 2)
                Ranks (copy, index: 3)
                RankArt (copy, index: 4)
                v13 (copy, index: 5)
                ui (copy, index: 6)
                paintRow (copy, index: 7)
            ]]
            local v81

            if number then
                v81 = number
            else
                local v82 = state.Profile or {}
                v81 = math.max(0, (tonumber(v82.trophies) or tonumber(state.Get("Trophies")) or 0))
            end

            local v83, v84, v85 = Ranks.Progress(v81)
            local v86 = RankArt.Color(v83)
            RankArt.SetEmblem(v13.bigEmblem, v83)
            v13.rankName.Text = string.upper(Ranks.Get(v83).name)
            v13.rankName.TextColor3 = v86
            v13.count.Text = ui.FormatNumber(v81)
            v13.bar.SetColor(v86)
            local set = v13.bar.Set
            local v88 = not v85 and 1 or v84 / v85
            set(v88, true)
            v13.next.Text = not v85 and "You reached the top rank"
                or string.format("%s more trophies to %s", ui.FormatNumber(v85 - v84), string.upper(Ranks.Get(v83 + 1).name))
            local v89 = state.Profile or {}
            v13.best.Text = string.format("BEST  %s", ui.FormatNumber((math.max(tonumber(v89.trophiesBest) or 0, v81))))
            v13.glow.ImageColor3 = v86

            for v90, row in v13.rows do
                paintRow(row, v90)
            end
        end

        local function scrollTo(a93)
            --[[
              name: scrollTo
              line: 192
              upvalues:
                Ranks (copy, index: 1)
                v13 (copy, index: 2)
                ui (copy, index: 3)
            ]]
            local v94 = (Ranks.Count() - a93) * 122
            local v95 = v13.scroll.AbsoluteWindowSize.Y / math.max(0.01, ui.Scale)
            v13.scroll.CanvasPosition = Vector2.new(0, (math.max(0, (v94 - (v95 / 2)) + 56)))
        end

        local function build()
            --[[
              name: build
              line: 200
              upvalues:
                v12 (ref,  index: 1)
                ui (copy, index: 2)
                a4 (copy, index: 3)
                close (copy, index: 4)
                v13 (copy, index: 5)
                RankArt (copy, index: 6)
                colors (copy, index: 7)
                fonts (copy, index: 8)
                Ranks (copy, index: 9)
                theme (copy, index: 10)
            ]]
            local scrollBarThickness
            v12 = ui.Window({Name = "Ranks", Title = "RANK ROAD", Subtitle = "Win matches to earn trophies. Every rank adds new weapons to your drops.", HeaderHeight = 80, Size = UDim2.fromOffset(1060, 660), Parent = a4.Canvas.Menus, OnCloseRequested = close})
            ui.SelectionRing(v12.Root)
            local content = v12.Content
            local parent = ui.Panel({Name = "You", BackgroundTransparency = 0.25, ClipsDescendants = true, Position = UDim2.fromOffset(0, 0), Size = UDim2.new(0, 320, 1, 0), Parent = content})
            v13.glow = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 200), Size = UDim2.fromOffset(440, 440), Parent = parent})
            v13.bigEmblem = RankArt.Emblem(1, 210, {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 84), Parent = parent})
            v13.rankName = ui.DisplayText({Name = "RankName", Text = "", TextSize = 42, StrokeThickness = 2, ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 304), Size = UDim2.new(1, -24, 0, 46), TextColor3 = colors.Text, Parent = parent})
            local parent2 = ui.new("Frame", {Name = "Count", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 356), Size = UDim2.new(1, -24, 0, 34), ZIndex = 2, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
            RankArt.Trophy(30, {LayoutOrder = 1, ZIndex = 2, Parent = parent2})
            v13.count = ui.new("TextLabel", {Name = "N", Text = "0", TextSize = 30, LayoutOrder = 2, ZIndex = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 34), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = parent2})
            v13.bar = ui.Bar({Name = "Bar", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 404), Size = UDim2.new(1, -56, 0, 14), Color = colors.Gold, Parent = parent})
            local v101 = {Name = "Next", Text = "", TextSize = 15, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 424), Size = UDim2.new(1, -40, 0, 20), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent}
            local values = table.clone(v101)
            values.FontFace = values.FontFace or fonts.Heavy
            values.TextColor3 = values.TextColor3 or colors.Text
            values.TextXAlignment = values.TextXAlignment or Enum.TextXAlignment.Left
            v13.next = ui.new("TextLabel", values)
            local v103 = {Name = "Best", Text = "", TextSize = 13, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 450), Size = UDim2.new(1, -40, 0, 18), FontFace = fonts.Bold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent}
            local values2 = table.clone(v103)
            values2.FontFace = values2.FontFace or fonts.Heavy
            values2.TextColor3 = values2.TextColor3 or colors.Text
            values2.TextXAlignment = values2.TextXAlignment or Enum.TextXAlignment.Left
            v13.best = ui.new("TextLabel", values2)
            local v105 = ui.Button({Name = "PlayerCard", Text = "PLAYER CARD", TextSize = 20, Style = "Dark", Size = UDim2.new(1, -32, 0, 52), AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), Parent = parent})
            v105.Instance.ZIndex = 3
            v105.Activated:Connect(
                function()
                    --[[
                      line: 296
                      upvalues:
                        a4 (copy, index: 1)
                    ]]
                    a4.MenuManager.Open("PlayerCard")
                end
            )
            local newUi = ui.new
            local v107 = {Name = "Ladder", Position = UDim2.fromOffset(336, 0), Size = UDim2.new(1, -336, 1, 0), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y}

            if ui.Touch then
                scrollBarThickness = 0
            else
                scrollBarThickness = 6
            end

            v107.ScrollBarThickness = scrollBarThickness
            v107.ScrollBarImageColor3 = colors.TextMuted
            v107.ScrollBarImageTransparency = 0.4
            v107.ScrollingDirection = Enum.ScrollingDirection.Y
            v107.BorderSizePixel = 0
            v107.BackgroundTransparency = 1
            v107[1], v107[2] = ui.List(Enum.FillDirection.Vertical, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top), (ui.Padding(2, 12, 2, 2))
            v107.Parent = content
            v13.scroll = newUi("ScrollingFrame", v107)

            local function fade(a109: number, y: number, rotation: number)
                --[[
                  name: fade
                  line: 317
                  upvalues:
                    ui (copy, index: 1)
                    colors (copy, index: 2)
                    content (copy, index: 3)
                ]]
                local parent = ui.new("Frame", {Name = "Fade", BorderSizePixel = 0, ZIndex = 5, AnchorPoint = Vector2.new(0, y), Position = UDim2.new(0, 336, a109, 0), Size = UDim2.new(1, -348, 0, 34), BackgroundColor3 = colors.Panel, Parent = content})
                ui.new("UIGradient", {Rotation = rotation, Transparency = NumberSequence.new(0, 1), Parent = parent})
            end

            fade(0, 0, 90)
            fade(1, 1, 270)
            v13.rows = {}
            local endIndex = Ranks.Count()

            for rowKey = 1, endIndex do
                local v115 = Ranks.Get(rowKey)
                local ui2 = ui.new("Frame", {Name = "Rank_" .. v115.id, Size = UDim2.new(1, 0, 0, 112), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.25, LayoutOrder = endIndex - rowKey, (ui.Corner(theme.Radius.Large)), Parent = v13.scroll})
                local stroke = ui.Stroke(colors.Stroke, 2, 0.9)
                stroke.Parent = ui2
                local ui3 = ui.new("CanvasGroup", {Name = "EmblemHolder", BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(92, 92), Parent = ui2})
                RankArt.Emblem(rowKey, 92, {Parent = ui3})
                local name = ui.DisplayText({Name = "Name", TextSize = 30, StrokeThickness = 1.5, Position = UDim2.fromOffset(114, 16), Size = UDim2.fromOffset(200, 34), Text = string.upper(v115.name), TextXAlignment = Enum.TextXAlignment.Left, Parent = ui2})
                local parent3 = ui.new("Frame", {Name = "Trophies", Position = UDim2.fromOffset(114, 54), Size = UDim2.fromOffset(200, 24), (ui.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = ui2})
                RankArt.Trophy(20, {LayoutOrder = 1, Parent = parent3})
                local v121 = {Name = "N", TextSize = 20, LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 24), Text = ui.FormatNumber(v115.trophies), FontFace = fonts.Display, Parent = parent3}
                local values3 = table.clone(v121)
                values3.FontFace = values3.FontFace or fonts.Heavy
                values3.TextColor3 = values3.TextColor3 or colors.Text
                values3.TextXAlignment = values3.TextXAlignment or Enum.TextXAlignment.Left
                ui.new("TextLabel", values3)
                local v123 = {Name = "State", Text = "", TextSize = 14, Position = UDim2.fromOffset(114, 80), Size = UDim2.fromOffset(200, 18), FontFace = fonts.Heavy, Parent = ui2}
                local values4 = table.clone(v123)
                values4.FontFace = values4.FontFace or fonts.Heavy
                values4.TextColor3 = values4.TextColor3 or colors.Text
                values4.TextXAlignment = values4.TextXAlignment or Enum.TextXAlignment.Left
                local state = ui.new("TextLabel", values4)
                local weapons = ui.new("Frame", {Name = "Weapons", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(1, -330, 0, 92), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = ui2})
                local v127 = {Name = "Note", Text = "", TextSize = 15, TextWrapped = true, Visible = false, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -18, 0.5, 0), Size = UDim2.new(1, -340, 0, 40), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = ui2}
                local values5 = table.clone(v127)
                values5.FontFace = values5.FontFace or fonts.Heavy
                values5.TextColor3 = values5.TextColor3 or colors.Text
                values5.TextXAlignment = values5.TextXAlignment or Enum.TextXAlignment.Left
                local note = ui.new("TextLabel", values5)
                v13.rows[rowKey] = {frame = ui2, stroke = stroke, emblemHolder = ui3, name = name, state = state, weapons = weapons, note = note}
            end
        end

        local v130 = nil

        local function hideInfo()
            --[[
              name: hideInfo
              line: 388
              upvalues:
                v130 (ref, index: 1)
            ]]
            if v130 then
                v130.root.Visible = false
            end
        end

        local function buildInfo()
            --[[
              name: buildInfo
              line: 393
              upvalues:
                v130 (ref,  index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
                v12 (ref,  index: 4)
                hideInfo (copy, index: 5)
                theme (copy, index: 6)
                fonts (copy, index: 7)
                RankArt (copy, index: 8)
            ]]
            if v130 then
                return
            end

            v130 = {}
            v130.root = ui.new("TextButton", {Name = "ItemInfo", BackgroundTransparency = 0.35, Text = "", AutoButtonColor = false, Selectable = false, Visible = false, ZIndex = 40, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = v12.Root})
            v130.root.Activated:Connect(hideInfo)
            local v133 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, ZIndex = 41, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(660, 392), Parent = v130.root})
            v130.card = v133
            ui.new("TextButton", {Name = "Swallow", BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 41, Size = UDim2.fromScale(1, 1), Parent = v133})
            v130.tile = ui.new("Frame", {Name = "Tile", Position = UDim2.fromOffset(20, 20), Size = UDim2.fromOffset(210, 210), BackgroundColor3 = colors.PanelHi, ZIndex = 42, (ui.Corner(theme.Radius.Large)), Parent = v133})
            v130.glow = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.6, ZIndex = 42, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(260, 260), Parent = v130.tile})
            v130.icon = ui.new("Frame", {Name = "Icon", ZIndex = 43, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(176, 176), Parent = v130.tile})
            v130.name = ui.DisplayText({Name = "Name", Text = "", TextSize = 38, StrokeThickness = 2, ZIndex = 42, Position = UDim2.fromOffset(252, 20), Size = UDim2.fromOffset(340, 42), TextXAlignment = Enum.TextXAlignment.Left, Parent = v133})
            local v134 = v130
            local v135 = {Name = "Sub", Text = "", TextSize = 15, ZIndex = 42, Position = UDim2.fromOffset(252, 64), Size = UDim2.fromOffset(390, 20), FontFace = fonts.Heavy, Parent = v133}
            local values = table.clone(v135)
            values.FontFace = values.FontFace or fonts.Heavy
            values.TextColor3 = values.TextColor3 or colors.Text
            values.TextXAlignment = values.TextXAlignment or Enum.TextXAlignment.Left
            v134.sub = ui.new("TextLabel", values)
            local v137 = v130
            local v138 = {Name = "Desc", Text = "", TextSize = 16, TextWrapped = true, ZIndex = 42, Position = UDim2.fromOffset(252, 92), Size = UDim2.fromOffset(390, 64), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextYAlignment = Enum.TextYAlignment.Top, Parent = v133}
            local values2 = table.clone(v138)
            values2.FontFace = values2.FontFace or fonts.Heavy
            values2.TextColor3 = values2.TextColor3 or colors.Text
            values2.TextXAlignment = values2.TextXAlignment or Enum.TextXAlignment.Left
            v137.desc = ui.new("TextLabel", values2)
            v130.stats = {}

            for statKey = 1, 4 do
                local v141 = (statKey - 1) * 18 + 162
                local v142 = {Text = "", TextSize = 12, ZIndex = 42, Name = "StatL" .. statKey, Position = UDim2.fromOffset(252, v141), Size = UDim2.fromOffset(92, 16), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = v133}
                local values3 = table.clone(v142)
                local v144 = values3.FontFace or fonts.Heavy
                values3.FontFace = v144
                local v145 = values3.TextColor3 or colors.Text
                values3.TextColor3 = v145
                local v146 = values3.TextXAlignment or Enum.TextXAlignment.Left
                values3.TextXAlignment = v146
                local label = ui.new("TextLabel", values3)
                local bar = ui.Bar({Stroke = false, Name = "StatB" .. statKey, Position = UDim2.fromOffset(348, v141 + 4), Size = UDim2.fromOffset(200, 8), Color = colors.Accent, Parent = v133})
                bar.Frame.ZIndex = 42
                bar.Fill.ZIndex = 43
                local v149 = {Text = "", TextSize = 12, ZIndex = 42, Name = "StatV" .. statKey, Position = UDim2.fromOffset(556, v141), Size = UDim2.fromOffset(84, 16), FontFace = fonts.Bold, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = v133}
                local values4 = table.clone(v149)
                values4.FontFace = values4.FontFace or fonts.Heavy
                values4.TextColor3 = values4.TextColor3 or colors.Text
                values4.TextXAlignment = values4.TextXAlignment or Enum.TextXAlignment.Left
                local ui2 = ui.new("TextLabel", values4)
                v130.stats[statKey] = {label = label, bar = bar, value = ui2}
            end

            v130.state = ui.new("Frame", {Name = "State", Position = UDim2.fromOffset(20, 248), Size = UDim2.fromOffset(620, 50), BackgroundColor3 = colors.PanelLo, BackgroundTransparency = 0.2, ZIndex = 42, (ui.Corner(theme.Radius.Medium)), Parent = v133})
            v130.stateEmblem = RankArt.Emblem(1, 38, {ZIndex = 43, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Parent = v130.state})
            local v152 = v130
            local v153 = {Name = "Text", Text = "", TextSize = 16, ZIndex = 43, Position = UDim2.fromOffset(56, 0), Size = UDim2.new(1, -66, 1, 0), FontFace = fonts.Heavy, Parent = v130.state}
            local values5 = table.clone(v153)
            values5.FontFace = values5.FontFace or fonts.Heavy
            values5.TextColor3 = values5.TextColor3 or colors.Text
            values5.TextXAlignment = values5.TextXAlignment or Enum.TextXAlignment.Left
            v152.stateText = ui.new("TextLabel", values5)
            v130.close = ui.Button({Name = "Close", Text = "CLOSE", TextSize = 20, Style = "Dark", Radius = 14, ZIndex = 42, Size = UDim2.fromOffset(200, 58), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -20, 1, -18), Parent = v133})
            v130.close.Activated:Connect(hideInfo)
        end

        local function statValue(a156, a157)
            --[[
              name: statValue
              line: 428
            ]]
            if a157.value then
                return a157.value
            end

            if type(a156.details) == "table" then
                for _, detail in a156.details do
                    if type(detail) == "table" then
                        if type(detail[1]) ~= "string" then
                            continue
                        end

                        local uppercaseText = string.upper(detail[1])

                        if uppercaseText ~= a157.label then
                            continue
                        end

                        return (tostring(detail[2]))
                    end
                end
            end

            return string.format("%d / 10", (math.floor((a157.frac * 10) + 0.5)))
        end

        v28 = function(id, a162)
            --[[
              line: 442
              upvalues:
                a4 (copy, index: 1)
                v12 (ref,  index: 2)
                buildInfo (copy, index: 3)
                v130 (ref,  index: 4)
                RankArt (copy, index: 5)
                colors (copy, index: 6)
                statValue (copy, index: 7)
                Ranks (copy, index: 8)
                theme (copy, index: 9)
                state (copy, index: 10)
                number (ref,  index: 11)
                ui (copy, index: 12)
            ]]
            local v163 = a4.WeaponInfo.Get(id)

            if not v163 or not v12 then
                return
            end

            buildInfo()
            v130.id = id
            local textColor3 = RankArt.Color(a162)
            local startValue = a4.WeaponInfo.CATEGORY_COLORS
                and a4.WeaponInfo.CATEGORY_COLORS[v163.category]
                or textColor3
            a4.WeaponIcon.Set(v130.icon, id, {spin = true, outline = true})
            a4.WeaponIcon.SetDim(v130.icon, false)
            v130.glow.ImageColor3 = startValue
            v130.name.Text = string.upper(v163.name)
            local sub = v130.sub
            local stringFormat = string.format
            local uppercaseText = string.upper((a4.WeaponInfo.CATEGORY_SINGULAR[v163.category]
                or v163.category
                or ""))
            local points = v163.points or 0
            local v170 = (v163.points or 0) ~= 1 and "S" or ""
            sub.Text = stringFormat("%s  ·  %d POINT%s", uppercaseText, points, v170)
            v130.sub.TextColor3 = startValue:Lerp(colors.TextDim, 0.3)
            local v171 = not a4.WeaponInfo.SpeedNote and "" or a4.WeaponInfo.SpeedNote(v163)
            v130.desc.Text = if v171 ~= "" then v171 .. " " .. (v163.description or "") else v163.description or ""
            local v172 = a4.WeaponInfo.Bars(v163)

            for v173, stat in v130.stats do
                local v175 = v172[v173]
                stat.label.Visible = v175 ~= nil
                stat.bar.Frame.Visible = v175 ~= nil
                stat.value.Visible = v175 ~= nil

                if v175 then
                    stat.label.Text = v175.label
                    stat.bar.Set(v175.frac, true)
                    stat.bar.SetColor(startValue)
                    stat.value.Text = statValue(v163, v175)
                end
            end

            RankArt.SetEmblem(v130.stateEmblem, a162)
            local uppercaseText2 = string.upper(Ranks.Get(a162).name)
            local economy = a4.Economy

            if economy and economy.Owns(id) then
                local v178 = economy.Level(id)
                v130.stateText.Text = string.format("OWNED  ·  LV %d", (math.max(v178, 1)))
                v130.stateText.TextColor3 = theme.Lighten(colors.Success, 0.1)
            else
                local v179
                local v180 = state.Profile or {}
                local number2 = tonumber(v180.rankBest) or 1
                local rankOf = Ranks.RankOf

                if number then
                    v179 = number
                else
                    local v183 = state.Profile or {}
                    v179 = math.max(0, (tonumber(v183.trophies) or tonumber(state.Get("Trophies")) or 0))
                end

                if a162 <= math.max(number2, rankOf(v179)) then
                    local v184 = 0
                    local v185 = 0

                    if economy then
                        v184, v185 = economy.Progress(id)
                    end

                    v130.stateText.Text = string.format("UNLOCKED AT %s  ·  %d / %d SHARDS  ·  FIND SHARDS IN DROPS", uppercaseText2, v184, v185)
                    v130.stateText.TextColor3 = colors.Text
                else
                    local v186

                    if number then
                        v186 = number
                    else
                        local v187 = state.Profile or {}
                        v186 = math.max(0, (tonumber(v187.trophies) or tonumber(state.Get("Trophies")) or 0))
                    end

                    v130.stateText.Text = string.format("REACH %s (%s TROPHIES) TO ADD IT TO YOUR DROPS", uppercaseText2, ui.FormatNumber((math.max(0, Ranks.Get(a162).trophies - v186))) .. " MORE")
                    v130.stateText.TextColor3 = textColor3
                end
            end

            v130.root.Visible = true
            ui.Pop(v130.card, 0.9, theme.Tween.PopSmall)
        end

        menuManager.Register(
            "Ranks",
            {
                open = (function()
                    --[[
                      name: open
                      line: 497
                      upvalues:
                        v12 (ref,  index: 1)
                        build (copy, index: 2)
                        a4 (copy, index: 3)
                        paint (copy, index: 4)
                        v14 (ref,  index: 5)
                        Ranks (copy, index: 6)
                        number (ref,  index: 7)
                        state (copy, index: 8)
                        v13 (copy, index: 9)
                        ui (copy, index: 10)
                    ]]
                    if not v12 then
                        build()
                    end

                    a4.SetHudHidden("Ranks", true)
                    paint()
                    v12:Open()
                    local v188 = v14
                    if not v188 then
                        local v189
                        local rankOf = Ranks.RankOf

                        if number then
                            v189 = number
                        else
                            local v191 = state.Profile or {}
                            v189 = math.max(0, (tonumber(v191.trophies) or tonumber(state.Get("Trophies")) or 0))
                        end

                        v188 = rankOf(v189)
                    end

                    v14 = nil

                    task.defer(
                        function()
                            --[[
                              line: 506
                              upvalues:
                                v188 (copy, index: 1)
                                Ranks (copy, index: 2)
                                v13 (copy, index: 3)
                                ui (copy, index: 4)
                            ]]
                            local v192 = (Ranks.Count() - v188) * 122
                            local v193 = v13.scroll.AbsoluteWindowSize.Y / math.max(0.01, ui.Scale)
                            v13.scroll.CanvasPosition = Vector2.new(0, (math.max(0, (v192 - (v193 / 2)) + 56)))
                        end
                    )

                    ui.Pop(v13.bigEmblem, 0.7)
                end),
                close = (function(a194)
                    --[[
                      name: close
                      line: 511
                      upvalues:
                        v130 (ref,  index: 1)
                        a4 (copy, index: 2)
                        number (ref,  index: 3)
                        v12 (ref,  index: 4)
                    ]]
                    if v130 then
                        v130.root.Visible = false
                    end

                    a4.SetHudHidden("Ranks", false)
                    number = nil
                    v12:Close(a194)
                end)
            }
        )

        local function refresh()
            --[[
              name: refresh
              line: 519
              upvalues:
                v12 (ref,  index: 1)
                menuManager (copy, index: 2)
                paint (copy, index: 3)
            ]]
            if v12 and menuManager.IsOpen("Ranks") then
                paint()
            end
        end

        state.ProfileChanged:Connect(refresh)

        state.AttrChanged:Connect(
            function(a196)
                --[[
                  line: 525
                  upvalues:
                    v12 (ref,  index: 1)
                    menuManager (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                if (a196 == "Trophies" or a196 == "RankBest") and v12 and menuManager.IsOpen("Ranks") then
                    paint()
                end
            end
        )

        a4.RankRoad = {
            Focus = (function(a197)
                --[[
                  name: Focus
                  line: 533
                  upvalues:
                    v14 (ref, index: 1)
                ]]
                v14 = a197
            end),
            OpenAt = (function(a198)
                --[[
                  name: OpenAt
                  line: 536
                  upvalues:
                    v14 (ref,  index: 1)
                    menuManager (copy, index: 2)
                ]]
                v14 = a198
                menuManager.Open("Ranks")
            end)
        }

        a4.Debug.rankInfo = function(a199)
            --[[
              line: 542
              upvalues:
                v12 (ref,  index: 1)
                menuManager (copy, index: 2)
                a4 (copy, index: 3)
                v28 (ref,  index: 4)
            ]]
            local v200

            if not v12 or not menuManager.IsOpen("Ranks") then
                menuManager.Open("Ranks")
            end

            local economy = a4.Economy
            local v202 = v28
            local text = tostring(a199)

            if economy then
                v200 = economy.ItemRank((tostring(a199)))
            else
                v200 = 1
            end

            v202(text, v200)

            return true
        end

        a4.Debug.ranks = function(a204)
            --[[
              line: 550
              upvalues:
                number (ref,  index: 1)
                menuManager (copy, index: 2)
            ]]
            number = tonumber(a204)
            menuManager.Open("Ranks")

            return true
        end
    end)
}