local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local guiService = game:GetService("GuiService")
local textService = game:GetService("TextService")
local CustomMatch = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local Keybinds = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local v7 = {}
local v8 = {W = 1180, H = 700, left = 410, gap = 24, pad = 16, sectionH = 24, sectionGap = 8, blockGap = 20, status = 18, button = 60, hint = 16, rowH = 62, label = 18, desc = 15, switchW = 58, mapCols = 4, mapGap = 12, mapName = 16, playerName = 17, playerSub = 13, leaveH = 50, teamHead = 40, teamGap = 12, seatH = 56, seatGap = 6, head = 36, moreW = 38, sectionHint = 14}
local v9 = {W = 1180, H = 700, left = 390, gap = 16, pad = 14, sectionH = 24, sectionGap = 6, blockGap = 14, status = 17, button = 54, hint = 15, rowH = 56, label = 17, desc = 14, switchW = 58, mapCols = 3, mapGap = 10, mapName = 15, playerName = 17, playerSub = 13, leaveH = 54, teamHead = 40, teamGap = 10, seatH = 60, seatGap = 6, head = 38, moreW = 46, sectionHint = 14}
local textColor3 = Color3.fromRGB(142, 149, 166)

function v7.Init(a11)
    --[[
      name: Init
      line: 55
      upvalues:
        players (copy, index: 1)
        v9 (copy, index: 2)
        v8 (copy, index: 3)
        textColor3 (copy, index: 4)
        CustomMatch (copy, index: 5)
        textService (copy, index: 6)
        userInputService (copy, index: 7)
        Keybinds (copy, index: 8)
        guiService (copy, index: 9)
    ]]
    local v12
    local ui = a11.UI
    local theme = a11.Theme

    do
        local _ = a11.State
    end

    local colors = theme.Colors
    local fonts = theme.Fonts
    local custom = a11.Custom
    local localPlayer = players.LocalPlayer
    local udim2FromOffset = UDim2.fromOffset
    local v21 = if ui.Compact then v9 else v8
    local v22 = ui.Window(
        {
            Name = "CustomHost",
            Title = "CUSTOM MATCH",
            Subtitle = "",
            HeaderHeight = 80,
            Size = udim2FromOffset(v21.W, v21.H),
            Parent = a11.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 70
                  upvalues:
                    a11 (copy, index: 1)
                ]]
                a11.MenuManager.Close("CustomHost")
            end)
        }
    )
    local content = v22.Content
    ui.SelectionRing(v22.Root)
    local parent = ui.new("Frame", {Name = "Code", AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.2, ui.Corner(10), (ui.Stroke(colors.Accent, 1.5, 0.5)), Parent = v22.Header})
    ui.new("TextLabel", {Name = "Cap", Text = "CODE", TextSize = 13, Position = udim2FromOffset(14, 0), Size = UDim2.new(0, 48, 1, 0), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local ui2 = ui.new("TextBox", {Name = "Value", Text = "", PlaceholderText = "", TextEditable = false, ClearTextOnFocus = false, TextSize = 28, BackgroundTransparency = 1, Selectable = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 0), Size = UDim2.new(1, -70, 1, 0), FontFace = fonts.Display, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent})
    local v26 = custom.MaskDots({Name = "Mask", Dot = 9, Gap = 5, GroupGap = 12, Color = colors.TextDim, AnchorPoint = Vector2.new(1, 0.5), Parent = parent})
    v26.Visible = false
    local parent2 = ui.IconButton({Name = "Reveal", Visible = false, Size = udim2FromOffset(36, 36), AnchorPoint = Vector2.new(1, 0.5), Color = colors.Raised, Parent = parent})
    local v28 = ui.Glyph("eye", 22, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent2})
    local icon = ui.Glyph("two-stacked-squares", 18, colors.Text)
    local v30 = ui.Button({Name = "Copy", Text = "COPY", TextSize = 17, Style = "Dark", Gap = 6, AnchorPoint = Vector2.new(1, 0), Icon = icon, Parent = v22.Header})
    local ui3 = ui.new("TextLabel", {Name = "CopyHint", Text = "", TextSize = 13, Visible = false, AnchorPoint = Vector2.new(1, 0), FontFace = fonts.Bold, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = v22.Header})

    local function card(name: string, parent)
        --[[
          name: card
          line: 136
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
        ]]
        return ui.new("Frame", {Name = name, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3, ui.Corner(12), (ui.Stroke(colors.Stroke, 1, 0.92)), Parent = parent})
    end

    local parent3 = ui.new("ScrollingFrame", {Name = "Left", ScrollBarThickness = 3, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, VerticalScrollBarInset = Enum.ScrollBarInset.None, Parent = content})
    local v36 = ui.SectionTitle("MATCH", {Parent = parent3})
    local parent4 = card("Match", parent3)
    local ui4 = ui.new("Frame", {Name = "Dot", Size = udim2FromOffset(10, 10), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = colors.Success, (ui.Corner(theme.Radius.Pill)), Parent = parent4})
    local ui5 = ui.new("TextLabel", {Name = "Status", Text = "", FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent4})
    local ui6 = ui.new("TextLabel", {Name = "Teams", Text = "", AnchorPoint = Vector2.new(1, 0), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent4})
    local v41 = ui.Button({Name = "Start", Text = "START MATCH", Style = "Primary", Icon = ui.Glyph("play-large", 26, colors.Text), Parent = parent4})
    local parent5 = ui.new("Frame", {Name = "HostedBy", BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.35, Visible = false, ui.Corner(12), ui.Stroke(colors.Stroke, 1, 0.9), (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent4})
    ui.Glyph("crown", 22, colors.Gold, {LayoutOrder = 1, Parent = parent5})
    local ui7 = ui.new("TextLabel", {Name = "Text", Text = "", LayoutOrder = 2, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 24), Parent = parent5})
    local v44 = ui.Button({Name = "End", Text = "END MATCH", Style = "Danger", Visible = false, Parent = parent4})
    local ui8 = ui.new("TextLabel", {Name = "Hint", Text = "", FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent4})
    local v46 = ui.SectionTitle("SETTINGS", {Parent = parent3})
    local parent6 = card("Settings", parent3)

    local function row(name: string, a50: number)
        --[[
          name: row
          line: 216
          upvalues:
            ui (copy, index: 1)
            parent6 (copy, index: 2)
            colors (copy, index: 3)
            udim2FromOffset (copy, index: 4)
            custom (copy, index: 5)
            theme (copy, index: 6)
        ]]
        local parent = ui.new("TextButton", {Text = "", AutoButtonColor = false, Name = name, Parent = parent6})

        if 1 < a50 then
            ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = colors.Stroke, Size = UDim2.new(1, -32, 0, 1), Position = udim2FromOffset(16, 0), Parent = parent})
        end

        local ui2 = ui.new("Frame", {Name = "Highlight", BackgroundColor3 = colors.White, BackgroundTransparency = 1, Position = udim2FromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), (ui.Corner(9)), Parent = parent})

        parent.MouseEnter:Connect(
            function()
                --[[
                  line: 222
                  upvalues:
                    ui (copy, index: 1)
                    custom (copy, index: 2)
                    ui2 (copy, index: 3)
                    theme (copy, index: 4)
                ]]
                if not ui.Touch and custom.IsHost() then
                    ui.Tween(ui2, theme.Tween.Fast, {BackgroundTransparency = 0.955})
                end
            end
        )

        parent.MouseLeave:Connect(
            function()
                --[[
                  line: 227
                  upvalues:
                    ui (copy, index: 1)
                    ui2 (copy, index: 2)
                    theme (copy, index: 3)
                ]]
                ui.Tween(ui2, theme.Tween.Fast, {BackgroundTransparency = 1})
            end
        )

        return parent, ui2
    end

    local function rowText(parent, text: string)
        --[[
          name: rowText
          line: 232
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            fonts (copy, index: 3)
            textColor3 (copy, index: 4)
        ]]
        local v56 = ui.Glyph("pencil", 22, colors.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = parent})
        local ui2 = ui.new("TextLabel", {Name = "Label", Text = text, FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})

        return v56, ui2, (ui.new("TextLabel", {Name = "Desc", Text = "", FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent}))
    end

    local parent7 = row("ModeRow", 1)
    local v59, _, v61 = rowText(parent7, "MODE")
    local v62 = nil
    local v63 = ui.Segmented(
        {
            Name = "Mode",
            Width = 128,
            Height = 36,
            Options = {{id = "3v3", text = "3V3"}, {id = "1v1", text = "1V1"}},
            Selected = CustomMatch.DEFAULT_MODE,
            AnchorPoint = Vector2.new(1, 0.5),
            Parent = parent7,
            OnSelect = (function(a64)
                --[[
                  name: OnSelect
                  line: 252
                  upvalues:
                    v62 (ref, index: 1)
                ]]
                v62(a64)
            end)
        }
    )
    local ui9 = ui.new("TextLabel", {Name = "Value", Text = "", Visible = false, AnchorPoint = Vector2.new(1, 0.5), FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent7})
    local v66 = ui.Segmented(
        {
            Name = "ModeCompact",
            Width = 124,
            TextSize = 20,
            Visible = false,
            Options = {{id = "3v3", text = "3V3"}, {id = "1v1", text = "1V1"}},
            Selected = CustomMatch.DEFAULT_MODE,
            Height = v9.button,
            Parent = parent4,
            OnSelect = (function(a67)
                --[[
                  name: OnSelect
                  line: 276
                  upvalues:
                    v62 (ref, index: 1)
                ]]
                v62(a67)
            end)
        }
    )
    local parent8 = row("NameRow", 2)
    local v69, v70, v71 = rowText(parent8, "SERVER NAME")
    v71.TextColor3 = colors.TextDim
    local ui10 = ui.new("TextLabel", {Name = "Edit", Text = "EDIT", AnchorPoint = Vector2.new(1, 0.5), FontFace = fonts.Heavy, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent8})
    local parent9 = ui.new("TextBox", {Name = "NameBox", Text = "", PlaceholderText = "", PlaceholderColor3 = colors.TextMuted, ClearTextOnFocus = false, FontFace = fonts.Bold, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.05, Visible = false, ZIndex = 4, ui.Corner(8), (ui.Padding(0, 10, 0, 10)), Parent = parent8})
    ui.Stroke(colors.Accent, 1.5, 0.3).Parent = parent9
    local parent10 = row("PublicRow", 3)
    local v75, v76, v77 = rowText(parent10, "PUBLIC")
    local v78 = ui.Switch({Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = parent10})
    local parent11 = row("BotsRow", 4)
    local v80, _, v82 = rowText(parent11, "FILL WITH BOTS")
    v80.Text = "three-people"
    v82.Text = "Bots take the empty slots, up to 3v3"
    local v83 = ui.Switch({Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = parent11})
    local ui11 = ui.new("TextLabel", {Name = "Value", Text = "", Visible = false, AnchorPoint = Vector2.new(1, 0.5), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent11})
    local v85 = ui.Button({Name = "Leave", Text = "LEAVE SERVER", TextSize = 18, Style = "Dark", Parent = parent3})
    local parent12 = ui.new("ScrollingFrame", {Name = "Right", ScrollBarThickness = 5, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, Parent = content})
    local ui12 = ui.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = colors.PanelLo, ZIndex = 6, Visible = false, (ui.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05))), Parent = content})

    local function updateFade()
        --[[
          name: updateFade
          line: 356
          upvalues:
            ui12 (copy, index: 1)
            parent12 (copy, index: 2)
        ]]
        ui12.Visible = 2 < (parent12.AbsoluteCanvasSize.Y - (parent12.CanvasPosition.Y + parent12.AbsoluteWindowSize.Y))
    end

    parent12:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
    parent12:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
    parent12:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)

    local function sectionHint(name: string)
        --[[
          name: sectionHint
          line: 364
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            textColor3 (copy, index: 3)
            parent12 (copy, index: 4)
        ]]
        return ui.new("TextLabel", {Text = "", Name = name, AnchorPoint = Vector2.new(1, 0), FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent12})
    end

    local v91 = {colors.Ally, colors.Enemy}
    local v92 = ui.SectionTitle("TEAMS", {Parent = parent12})
    local v93 = sectionHint("TeamsHint")
    local v94 = nil

    local function makeSeat(parent, team: number, name: string)
        --[[
          name: makeSeat
          line: 385
          upvalues:
            colors (copy, index: 1)
            v91 (copy, index: 2)
            ui (copy, index: 3)
            theme (copy, index: 4)
            fonts (copy, index: 5)
            a11 (copy, index: 6)
            v94 (ref,  index: 7)
        ]]
        local v99 = if team == 0 then colors.Accent else v91[team]
        local ui2 = ui.new("TextButton", {Name = name, Text = "", AutoButtonColor = false, BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.75, (ui.Corner(10)), Parent = parent})
        local stroke = ui.Stroke(colors.Stroke, 1, 0.92)
        stroke.Parent = ui2
        local ui3 = ui.new("Frame", {Name = "Ring", AnchorPoint = Vector2.new(0, 0.5), (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local v103 = ui.Stroke(colors.TextMuted, 1.5, 0.55)
        v103.Parent = ui3
        local plus = ui.Icon("plus", 16, v99, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui3})
        local label = ui.new("TextLabel", {Name = "Label", Text = "Open", AnchorPoint = Vector2.new(0, 0.5), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui2})
        local v106 = nil
        local v107 = false

        local function look()
            --[[
              name: look
              line: 413
              upvalues:
                v106 (ref,  index: 1)
                v107 (ref,  index: 2)
                ui (copy, index: 3)
                stroke (copy, index: 4)
                theme (copy, index: 5)
                v99 (copy, index: 6)
                colors (copy, index: 7)
                ui2 (copy, index: 8)
                v103 (copy, index: 9)
            ]]
            local v109 = v106.join and v107
            local tween = ui.Tween
            local fast = theme.Tween.Fast
            local v112 = {Color = if v106.join then v99 else colors.Stroke}
            local transparency = v109 and 0.05 or v106.join and 0.45 or 0.92
            v112.Transparency = transparency
            tween(stroke, fast, v112)
            local tween2 = ui.Tween
            local fast2 = theme.Tween.Fast
            local v116 = {BackgroundColor3 = if v106.join then v99 else colors.Inset}
            local backgroundTransparency = v109 and 0.82 or v106.join and 0.92 or 0.75
            v116.BackgroundTransparency = backgroundTransparency
            tween2(ui2, fast2, v116)
            v103.Color = if v106.join then v99 else colors.TextMuted
            v103.Transparency = v106.join and 0.2 or 0.55
        end

        v106 = {join = false, btn = ui2, stroke = stroke, ring = ui3, plus = plus, label = label, team = team, look = look}

        ui2.MouseEnter:Connect(
            function()
                --[[
                  line: 427
                  upvalues:
                    v107 (ref,  index: 1)
                    v106 (ref,  index: 2)
                    ui (copy, index: 3)
                    a11 (copy, index: 4)
                    look (copy, index: 5)
                ]]
                v107 = true

                if v106.join and not ui.Touch then
                    a11.Sounds.Play("Hover")
                end

                look()
            end
        )

        ui2.MouseLeave:Connect(
            function()
                --[[
                  line: 434
                  upvalues:
                    v107 (ref,  index: 1)
                    look (copy, index: 2)
                ]]
                v107 = false
                look()
            end
        )

        ui2.Activated:Connect(
            function()
                --[[
                  line: 438
                  upvalues:
                    v106 (ref,  index: 1)
                    ui (copy, index: 2)
                    ui2 (copy, index: 3)
                    v94 (ref,  index: 4)
                ]]
                if v106.join then
                    ui.Bump(ui2, 0.04)
                    v94(v106.team)
                end
            end
        )

        return v106
    end

    local function setSeat(seat, a120: boolean)
        --[[
          name: setSeat
          line: 446
          upvalues:
            theme (copy, index: 1)
            colors (copy, index: 2)
            v91 (copy, index: 3)
            fonts (copy, index: 4)
        ]]
        local v121
        seat.join = a120
        seat.label.Text = a120 and "JOIN" or "Open"
        local label = seat.label

        if a120 then
            local lighten = theme.Lighten
            local v124 = if seat.team == 0 then colors.Accent else v91[seat.team]
            v121 = lighten(v124, 0.3)
        else
            v121 = colors.TextMuted
        end

        label.TextColor3 = v121
        seat.label.FontFace = if a120 then fonts.Heavy else fonts.SemiBold
        seat.plus.Visible = a120
        seat.btn.Selectable = a120
        seat.look()
    end

    local v125 = {}
    local v126 = {}
    v12 = v21

    for index = 1, 2 do
        do
            local v128 = card("Team" .. index, parent12)

            do
                local uiStroke = v128:FindFirstChildOfClass("UIStroke")
                uiStroke.Color = v91[index]
                uiStroke.Thickness = 1.5
                uiStroke.Transparency = 0.7
            end

            local dot = ui.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = v91[index], (ui.Corner(theme.Radius.Pill)), Parent = v128})
            local title = ui.new("TextLabel", {Name = "Title", AnchorPoint = Vector2.new(0, 0.5), Text = "TEAM " .. index, FontFace = fonts.Heavy, TextColor3 = theme.Lighten(v91[index], 0.35), TextXAlignment = Enum.TextXAlignment.Left, Parent = v128})
            local count = ui.new("TextLabel", {Name = "Count", Text = "", AnchorPoint = Vector2.new(1, 0.5), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v128})
            local seats = {}

            for index2 = 1, CustomMatch.TEAM_SIZE do
                table.insert(seats, (makeSeat(v128, index, "Open" .. index2)))
                table.insert(v126, seats[index2])
            end

            v125[index] = {n = -1, frame = v128, dot = dot, title = title, count = count, seats = seats}
        end
    end

    do
        local v135 = ui.SectionTitle("RANDOM", {Parent = parent12})
        local v136 = sectionHint("RandomHint")
        local parent13 = card("Random", parent12)
        local seat = makeSeat(parent13, 0, "Join")
        table.insert(v126, seat)
        local v139 = ui.SectionTitle("MAP", {Parent = parent12})
        local ui13 = ui.new("TextLabel", {Name = "MapValue", Text = "", TextSize = 15, AnchorPoint = Vector2.new(1, 0), FontFace = fonts.Heavy, TextColor3 = colors.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent12})
        local parent14 = ui.new("Frame", {Name = "Maps", Parent = parent12})
        local v142 = false
        local v143 = {}
        local isBusy = false
        local isBusy2 = false

        do
            local function isHost()
                --[[
                  name: isHost
                  line: 516
                  upvalues:
                    custom (copy, index: 1)
                ]]
                return custom.IsHost()
            end
        end

        do
            local function stateNow()
                --[[
                  name: stateNow
                  line: 520
                  upvalues:
                    custom (copy, index: 1)
                ]]
                return custom.State() or {}
            end
        end

        local function modeOf(a149)
            --[[
              name: modeOf
              line: 525
              upvalues:
                CustomMatch (copy, index: 1)
                v143 (copy, index: 2)
            ]]
            local mode = CustomMatch.Mode
            local mode2 = if v143.mode ~= nil then v143.mode else a149.mode

            return mode(mode2)
        end

        do
            local function sizeOf(a153)
                --[[
                  name: sizeOf
                  line: 528
                  upvalues:
                    CustomMatch (copy, index: 1)
                    modeOf (copy, index: 2)
                ]]
                return CustomMatch.TeamSize(modeOf(a153))
            end
        end

        do
            local function teamCardH(a155)
                --[[
                  name: teamCardH
                  line: 532
                  upvalues:
                    v12 (ref, index: 1)
                ]]
                return (v12.teamHead + (a155 * v12.seatH) + ((a155 - 1) * v12.seatGap)) + 8
            end
        end

        local v156 = {}
        local v157 = ""
        local v158 = nil

        local function buildMapCards(a160)
            --[[
              name: buildMapCards
              line: 543
              upvalues:
                v157 (ref,  index: 1)
                v156 (copy, index: 2)
                ui (copy, index: 3)
                colors (copy, index: 4)
                parent14 (copy, index: 5)
                fonts (copy, index: 6)
                v12 (ref,  index: 7)
                udim2FromOffset (copy, index: 8)
                theme (copy, index: 9)
                custom (copy, index: 10)
                a11 (copy, index: 11)
                v158 (ref,  index: 12)
            ]]
            local v161
            local v162 = ""
            v161 = v162

            for _, v164 in a160 do
                v161 ..= v164.id .. ";"
            end

            if v161 == v157 then
                return
            end

            v157 = v161

            for _, v166 in v156 do
                v166.btn:Destroy()
            end

            table.clear(v156)
            local v167 = {{id = "", name = "Random", thumb = ""}}

            for _, v169 in a160 do
                table.insert(v167, v169)
            end

            for layoutOrder, v171 in v167 do
                local newUi = ui.new
                local v173 = {}
                local v174 = v171.id == "" and "Random" or v171.id
                v173.Name = "Map_" .. v174
                v173.Text = ""
                v173.AutoButtonColor = false
                v173.BackgroundColor3 = colors.Raised
                v173.LayoutOrder = layoutOrder
                v173[1] = (ui.Corner(10))
                v173.Parent = parent14
                local ui2 = newUi("TextButton", v173)
                local stroke = ui.Stroke(colors.Stroke, 1, 0.88)
                stroke.Parent = ui2
                local img = ui.new("ImageLabel", {Name = "Thumb", Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, Image = v171.thumb
                    or "", BackgroundTransparency = 1, (ui.Corner(10)), Parent = ui2})

                if v171.id == "" then
                    ui.Gradient(Color3.fromRGB(52, 58, 74), Color3.fromRGB(26, 29, 38), 120).Parent = ui2
                    ui2.BackgroundColor3 = Color3.new(1, 1, 1)
                    ui.new("TextLabel", {Name = "Mark", Text = "?", TextSize = 46, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(1, 0.6), FontFace = fonts.Display, TextColor3 = colors.TextDim, Parent = ui2})
                end

                local parent = ui.new("Frame", {Name = "Band", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = colors.Void, BackgroundTransparency = 0, ui.Corner(10), (ui.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(0.85, 0.2))), Parent = ui2})
                local name = ui.new("TextLabel", {Name = "MapName", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -6), Size = UDim2.new(1, -20, 0, 20), Text = string.upper(v171.name), FontFace = fonts.Heavy, TextSize = v12.mapName, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent})
                local ui3 = ui.new("Frame", {Name = "Check", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Size = udim2FromOffset(26, 26), BackgroundColor3 = colors.Accent, Visible = false, ZIndex = 3, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Void, 1, 0.6)), Parent = ui2})
                ui.Icon("check", 16, colors.Text, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui3})
                local v181 = {id = v171.id, btn = ui2, stroke = stroke, check = ui3, img = img, name = name, scaleObj = ui.GetScaleObj(ui2, "HoverScale")}

                ui2.MouseEnter:Connect(
                    function()
                        --[[
                          line: 635
                          upvalues:
                            ui (copy, index: 1)
                            custom (copy, index: 2)
                            a11 (copy, index: 3)
                            v181 (copy, index: 4)
                            theme (copy, index: 5)
                        ]]
                        if not ui.Touch and custom.IsHost() then
                            a11.Sounds.Play("Hover")
                            ui.Tween(v181.scaleObj, theme.Tween.PopSmall, {Scale = 1.03})

                            if v181.stroke.Thickness < 2 then
                                ui.Tween(v181.stroke, theme.Tween.Fast, {Transparency = 0.55})
                            end
                        end
                    end
                )

                ui2.MouseLeave:Connect(
                    function()
                        --[[
                          line: 644
                          upvalues:
                            ui (copy, index: 1)
                            v181 (copy, index: 2)
                            theme (copy, index: 3)
                        ]]
                        ui.Tween(v181.scaleObj, theme.Tween.PopSmall, {Scale = 1})

                        if v181.stroke.Thickness < 2 then
                            ui.Tween(v181.stroke, theme.Tween.Fast, {Transparency = 0.88})
                        end
                    end
                )

                ui2.Activated:Connect(
                    function()
                        --[[
                          line: 650
                          upvalues:
                            custom (copy, index: 1)
                            v158 (ref,  index: 2)
                            v181 (copy, index: 3)
                        ]]
                        if custom.IsHost() then
                            v158(v181.id)
                        end
                    end
                )

                table.insert(v156, v181)
            end
        end

        local v182 = {}
        local v183 = {}

        do
            local function headshot(userId, a186)
                --[[
                  name: headshot
                  line: 663
                  upvalues:
                    v183 (copy, index: 1)
                    players (copy, index: 2)
                ]]
                if userId <= 0 then
                    a186.Image = ""
                    return
                end

                if v183[userId] then
                    a186.Image = v183[userId]
                    return
                end

                task.spawn(
                    function()
                        --[[
                          line: 672
                          upvalues:
                            players (copy, index: 1)
                            userId (copy, index: 2)
                            v183 (copy, index: 3)
                            a186 (copy, index: 4)
                        ]]
                        local success, image = pcall(
                            function()
                                --[[
                                  line: 673
                                  upvalues:
                                    players (copy, index: 1)
                                    userId (copy, index: 2)
                                ]]
                                return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                            end
                        )

                        if success and type(image) == "string" then
                            v183[userId] = image

                            if a186.Parent then
                                a186.Image = image
                            end
                        end
                    end
                )
            end
        end

        local v189 = nil

        do
            local function textWidth(string: string, fontSize: number)
                --[[
                  name: textWidth
                  line: 689
                  upvalues:
                    textService (copy, index: 1)
                ]]
                local success, x = pcall(
                    function()
                        --[[
                          line: 690
                          upvalues:
                            textService (copy, index: 1)
                            string (copy, index: 2)
                            fontSize (copy, index: 3)
                        ]]
                        return textService:GetTextSize(string, fontSize, Enum.Font.BuilderSansExtraBold, Vector2.new(1000, 100)).X
                    end
                )

                if success and type(x) == "number" then
                    return x
                end

                return (#string * fontSize) * 0.62
            end
        end

        local function tag(parent, text: string, backgroundColor3, textColor3, layoutOrder: number)
            --[[
              name: tag
              line: 696
              upvalues:
                ui (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                theme (copy, index: 3)
                fonts (copy, index: 4)
                textService (copy, index: 5)
            ]]
            local v201
            local parent2 = ui.new("Frame", {Name = "Tag", AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 18), BackgroundColor3 = backgroundColor3, LayoutOrder = layoutOrder, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 7, 0, 7)), Parent = parent})
            ui.new("TextLabel", {TextSize = 11, Text = text, FontFace = fonts.Heavy, TextColor3 = textColor3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = parent2})
            local fontSize = 11
            local success, x = pcall(
                function()
                    --[[
                      line: 690
                      upvalues:
                        textService (copy, index: 1)
                        text (copy, index: 2)
                        fontSize (copy, index: 3)
                    ]]
                    return textService:GetTextSize(text, fontSize, Enum.Font.BuilderSansExtraBold, Vector2.new(1000, 100)).X
                end
            )

            if not success or type(x) ~= "number" then
                v201 = #text * 11 * 0.62
            else
                v201 = x
            end

            return (math.ceil(v201) + 14) + 5
        end

        local function makePRow(options)
            --[[
              name: makePRow
              line: 711
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                theme (copy, index: 3)
                fonts (copy, index: 4)
                textColor3 (copy, index: 5)
                v189 (ref,  index: 6)
                v183 (copy, index: 7)
                players (copy, index: 8)
            ]]
            local ui2 = ui.new("Frame", {Name = "P" .. options.userId, BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.45, ui.Corner(10)})
            local img = ui.new("ImageLabel", {Name = "Headshot", BackgroundColor3 = colors.Raised, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
            local name = ui.new("TextLabel", {Name = "PlayerName", FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
            local ui3 = ui.new("Frame", {Name = "Line", (ui.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = ui2})
            local sub = ui.new("TextLabel", {Name = "Username", LayoutOrder = 10, FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3})
            local v213 = ui.IconButton({Name = "More", Visible = false, AnchorPoint = Vector2.new(1, 0.5), Color = colors.Raised, Parent = ui2})
            ui.Glyph("three-dots-horizontal", 20, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v213})
            local v214 = {group = -1, tagW = 0, frame = ui2, img = img, name = name, line = ui3, sub = sub, more = v213, userId = options.userId}
            v213.Activated:Connect(
                function()
                    --[[
                      line: 751
                      upvalues:
                        v189 (ref,  index: 1)
                        v214 (copy, index: 2)
                    ]]
                    v189(v214.userId)
                end
            )
            local userId = options.userId

            if userId <= 0 then
                img.Image = ""
                return v214
            end

            if v183[userId] then
                img.Image = v183[userId]
                return v214
            end

            task.spawn(
                function()
                    --[[
                      line: 672
                      upvalues:
                        players (copy, index: 1)
                        userId (copy, index: 2)
                        v183 (copy, index: 3)
                        img (copy, index: 4)
                    ]]
                    local success, image = pcall(
                        function()
                            --[[
                              line: 673
                              upvalues:
                                players (copy, index: 1)
                                userId (copy, index: 2)
                            ]]
                            return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                        end
                    )

                    if success and type(image) == "string" then
                        v183[userId] = image

                        if img.Parent then
                            img.Image = image
                        end
                    end
                end
            )

            return v214
        end

        local function layoutPRow(a219, a220: number, visible)
            --[[
              name: layoutPRow
              line: 758
              upvalues:
                v12 (ref,  index: 1)
                udim2FromOffset (copy, index: 2)
            ]]
            local v222
            local seatH = v12.seatH
            local head = v12.head
            a219.frame.Size = udim2FromOffset(a220, seatH)
            a219.img.Position = udim2FromOffset(10, (math.floor((seatH - head) / 2)))
            a219.img.Size = udim2FromOffset(head, head)
            local v225 = 10 + head + 10
            a219.more.Visible = visible
            a219.more.Size = udim2FromOffset(v12.moreW, v12.moreW)
            a219.more.Position = UDim2.new(1, -8, 0.5, 0)
            local v226 = a220 - v225

            if visible then
                v222 = v12.moreW + 16
            else
                v222 = 10
            end

            local v227 = v226 - v222
            a219.name.Position = udim2FromOffset(v225, (math.floor(seatH / 2) - v12.playerName) - 3)
            a219.name.Size = udim2FromOffset(v227, v12.playerName + 4)
            a219.name.TextSize = v12.playerName
            a219.line.Position = udim2FromOffset(v225, math.floor(seatH / 2) + 2)
            a219.line.Size = udim2FromOffset(v227, 18)
            a219.sub.TextSize = v12.playerSub
            a219.sub.Size = udim2FromOffset(math.max(0, v227 - a219.tagW), 18)
        end

        local v228 = {}

        do
            local function teamOfRow(a230)
                --[[
                  name: teamOfRow
                  line: 779
                  upvalues:
                    v228 (copy, index: 1)
                ]]
                local v231 = v228[a230.userId]
                if v231 == nil then
                    v231 = tonumber(a230.team) or 0
                end

                if v231 ~= 1 and v231 ~= 2 then
                    return 0
                end

                return v231
            end
        end

        local v232 = 600
        local flooredValue = 294
        local v234 = nil
        local v235 = {{}, {}, {}}

        local function paintTeams(options2)
            --[[
              name: paintTeams
              line: 790
              upvalues:
                custom (copy, index: 1)
                CustomMatch (copy, index: 2)
                modeOf (copy, index: 3)
                v234 (ref,  index: 4)
                v228 (copy, index: 5)
                localPlayer (copy, index: 6)
                v182 (copy, index: 7)
                v235 (copy, index: 8)
                makePRow (copy, index: 9)
                tag (copy, index: 10)
                colors (copy, index: 11)
                theme (copy, index: 12)
                layoutPRow (copy, index: 13)
                flooredValue (ref,  index: 14)
                udim2FromOffset (copy, index: 15)
                ui (copy, index: 16)
                v12 (ref,  index: 17)
                v125 (copy, index: 18)
                setSeat (copy, index: 19)
                parent13 (copy, index: 20)
                seat (copy, index: 21)
                v232 (ref,  index: 22)
                v135 (copy, index: 23)
                v136 (copy, index: 24)
                v93 (copy, index: 25)
            ]]
            local v238
            local v239

            if type(options2.players) ~= "table" then
                v238 = {}
            else
                v238 = options2.players
            end

            local isHost = custom.IsHost()
            local v241 = options2.status == "Match" or options2.status == "Results"
            local v242 = CustomMatch.TeamSize(modeOf(options2))
            local v243 = {{}, {}, {}}
            local v244 = {}
            v234 = nil

            for _, v246 in v238 do
                if type(v246) == "table" then
                    local v247, v248

                    if type(v246.userId) ~= "number" then
                        continue
                    end

                    v244[v246.userId] = true
                    local v249 = v228[v246.userId]
                    local v250 = if v249 == nil then tonumber(v246.team) or 0 else v249
                    local v251 = v250 ~= 1 and v250 ~= 2 and 0 or v250

                    if v246.userId == localPlayer.UserId then
                        v234 = v251
                    end

                    v248, v247 = v246, v251 == 0 and 3 or v251
                    table.insert(v243[v247], v248)
                end
            end

            for v252, v253 in v182 do
                if not v244[v252] then
                    v253.frame:Destroy()
                    v182[v252] = nil
                end
            end

            for index = 1, 2 do
                while v242 < #v243[index] do
                    table.insert(v243[3], (table.remove(v243[index])))
                end
            end

            for index = 1, 3 do
                v235[index] = {}

                for _, v257 in v243[index] do
                    table.insert(v235[index], v257.userId)
                end
            end

            local function place(options, parent, a261, a262, group: number)
                --[[
                  name: place
                  line: 829
                  upvalues:
                    v182 (copy, index: 1)
                    makePRow (copy, index: 2)
                    options2 (copy, index: 3)
                    tag (copy, index: 4)
                    colors (copy, index: 5)
                    theme (copy, index: 6)
                    localPlayer (copy, index: 7)
                    layoutPRow (copy, index: 8)
                    flooredValue (ref,  index: 9)
                    isHost (copy, index: 10)
                    udim2FromOffset (copy, index: 11)
                    ui (copy, index: 12)
                ]]
                local tagW
                local v265 = v182[options.userId]
                if not v265 then
                    v265 = makePRow(options)
                    v182[options.userId] = v265
                end

                v265.name.AutoLocalize = false
                v265.sub.AutoLocalize = false
                v265.name.Text = tostring((options.name or "?"))
                v265.sub.Text = "@" .. tostring(options.username or "")

                for _, child in v265.line:GetChildren() do
                    if child:IsA("Frame") then
                        child:Destroy()
                    end
                end

                local v268 = 0
                local v269 = if options.userId == options2.ownerId then v268 + tag(v265.line, "HOST", colors.Gold:Lerp(colors.Panel, 0.72), theme.Lighten(colors.Gold, 0.1), 1) else v268

                if options.userId == localPlayer.UserId then
                    v269 += tag(v265.line, "YOU", colors.Accent:Lerp(colors.Panel, 0.7), theme.Lighten(colors.Accent, 0.25), 2)
                end

                if options.playing then
                    tagW = v269 + tag(v265.line, "PLAYING", colors.Success:Lerp(colors.Panel, 0.75), theme.Lighten(colors.Success, 0.1), 3)
                elseif options.watching then
                    tagW = v269 + tag(v265.line, "WATCHING", colors.Accent:Lerp(colors.Panel, 0.75), theme.Lighten(colors.Accent, 0.25), 3)
                else
                    tagW = if options.satOut then v269 + tag(v265.line, "NEXT UP", colors.Warning:Lerp(colors.Panel, 0.75), theme.Lighten(colors.Warning, 0.1), 3) else v269
                end

                v265.tagW = tagW
                v265.frame.Parent = parent
                layoutPRow(v265, flooredValue - 16, (isHost and (options.userId ~= localPlayer.UserId)))
                v265.frame.Position = udim2FromOffset(a261, a262)

                if v265.group ~= group then
                    if v265.group ~= -1 then
                        ui.Enter(v265.frame, Vector2.new(0, 6), 0, udim2FromOffset(a261, a262))
                    end

                    v265.group = group
                end
            end

            local v270 = v12.seatH + v12.seatGap

            for index = 1, 2 do
                local v272 = v125[index]
                local v273 = v243[index]
                v272.count.Text = string.format("%d/%d", #v273, v242)

                if v272.n ~= #v273 then
                    if v272.n ~= -1 then
                        ui.Pop(v272.count, 1.25)
                    end

                    v272.n = #v273
                end

                v272.frame.Size = udim2FromOffset(flooredValue, (v12.teamHead + (v242 * v12.seatH) + ((v242 - 1) * v12.seatGap)) + 8)
                local v274 = false

                for seatKey = 1, CustomMatch.TEAM_SIZE do
                    local v276 = v12.teamHead + (seatKey - 1) * v270
                    local seat2 = v272.seats[seatKey]
                    local options = v273[seatKey]

                    if v242 < seatKey then
                        seat2.btn.Visible = false
                    elseif options then
                        place(options, v272.frame, 8, v276, index)
                        seat2.btn.Visible = false
                    else
                        seat2.btn.Visible = true
                        seat2.btn.Position = udim2FromOffset(8, v276)
                        seat2.btn.Size = udim2FromOffset(flooredValue - 16, v12.seatH)
                        local v279 = v234 ~= nil and v234 ~= index and not v274
                        v274 = v274 or v279
                        setSeat(seat2, v279)
                    end
                end
            end

            local v280 = v243[3]
            local visible = v234 ~= nil and v234 ~= 0
            local length = #v280
            local v283 = visible and 1 or 0
            local v284 = length + v283
            local v285 = flooredValue + v12.teamGap

            local function at(a287)
                --[[
                  name: at
                  line: 911
                  upvalues:
                    v285 (copy, index: 1)
                    v270 (copy, index: 2)
                ]]
                return 8 + (((a287 - 1) % 2) * v285), 8 + (((a287 - 1) // 2) * v270)
            end

            for v288, options in v280 do
                place(options, parent13, 8 + (((v288 - 1) % 2) * v285), 8 + (((v288 - 1) // 2) * v270), 0)
            end

            seat.btn.Visible = visible

            if visible then
                local v290 = #v280 + 1
                local v291 = 8 + ((v290 - 1) % 2) * v285
                local v292 = 8 + ((v290 - 1) // 2) * v270
                seat.btn.Position = udim2FromOffset(v291, v292)
                seat.btn.Size = udim2FromOffset(flooredValue - 16, v12.seatH)
                setSeat(seat, true)
            end

            local ceilingValue = math.ceil(v284 / 2)
            local v294 = v232

            if not (0 < ceilingValue) then
                v239 = 0
            else
                v239 = 16 + (ceilingValue * v12.seatH) + (ceilingValue - 1) * v12.seatGap
            end

            parent13.Size = udim2FromOffset(v294, v239)
            parent13.Visible = 0 < ceilingValue
            v135.Visible = 0 < ceilingValue
            v136.Visible = 0 < ceilingValue
            v135.Text.Text = not (0 < #v280) and "RANDOM" or string.format("RANDOM  ·  %d", #v280)
            v93.Text = v241 and "Picks count from the next match" or "Join a team, or stay random"
            v136.Text = v242 ~= 1 and "Placed where there's room when the match starts" or "They watch and play next"
        end

        local function teamsPreview(options)
            --[[
              name: teamsPreview
              line: 937
              upvalues:
                v143 (copy, index: 1)
                CustomMatch (copy, index: 2)
                modeOf (copy, index: 3)
            ]]
            local bots = if v143.bots ~= nil then v143.bots else options.bots
            if bots then
                local v298 = CustomMatch.TeamSize(modeOf(options))
                return string.format("%d V %d", v298, v298)
            end

            local split = options.split

            if type(split) ~= "table" then
                return ""
            end

            local number = tonumber(split[1]) or 0
            local number2 = tonumber(split[2]) or 0

            if not (2 <= number + number2) then
                return ""
            end

            return (string.format("%d V %d", number, number2))
        end

        local function anyPicks(options)
            --[[
              name: anyPicks
              line: 952
              upvalues:
                v228 (copy, index: 1)
            ]]
            local v304

            if type(options.players) ~= "table" then
                v304 = {}
            else
                v304 = options.players
            end

            for _, v306 in v304 do
                if type(v306) == "table" then
                    local v307 = v228[v306.userId]
                    local v308 = if v307 == nil then tonumber(v306.team) or 0 else v307
                    local v309 = v308 ~= 1 and v308 ~= 2 and 0 or v308

                    if v309 == 0 then
                        continue
                    end

                    return true
                end
            end

            return false
        end

        local function paintSwitches(options, a312: boolean?)
            --[[
              name: paintSwitches
              line: 961
              upvalues:
                custom (copy, index: 1)
                v143 (copy, index: 2)
                v78 (copy, index: 3)
                v76 (copy, index: 4)
                v75 (copy, index: 5)
                v77 (copy, index: 6)
                v83 (copy, index: 7)
                ui11 (copy, index: 8)
                colors (copy, index: 9)
                CustomMatch (copy, index: 10)
                v63 (copy, index: 11)
                v66 (copy, index: 12)
                ui9 (copy, index: 13)
                v59 (copy, index: 14)
                v61 (copy, index: 15)
                v82 (copy, index: 16)
                ui10 (copy, index: 17)
                isBusy2 (ref,  index: 18)
                parent8 (copy, index: 19)
                v46 (copy, index: 20)
            ]]
            local v313
            local visible = custom.IsHost()
            local public = if v143.public ~= nil then v143.public else options.public == true
            v78:Set(public, a312)
            v78.Instance.Visible = visible
            v76.Text = public and "PUBLIC" or "PRIVATE"
            v75.Text = public and "globe-simplified" or "lock-closed"
            v77.Text = public and "Listed in every lobby's Custom Matches" or "Only people with the code can join"
            local bots = if v143.bots ~= nil then v143.bots else options.bots == true
            v83:Set(bots, a312)
            v83.Instance.Visible = visible
            ui11.Visible = not visible
            ui11.Text = bots and "ON" or "OFF"

            if bots then
                v313 = colors.Text
                v313 = v143
            else
                v313 = colors.TextDim
                v313 = v143
            end

            ui11.TextColor3 = v313
            local mode = CustomMatch.Mode
            local mode2 = if v313.mode ~= nil then v313.mode else options.mode
            local v319 = mode(mode2)
            local v320 = v319 == "1v1"

            if v63.Value ~= v319 or a312 then
                v63:Set(v319, a312)
            end

            if v66.Value ~= v319 or a312 then
                v66:Set(v319, a312)
            end

            v63.Instance.Visible = visible
            ui9.Visible = not visible
            ui9.Text = CustomMatch.ModeLabel(v319)
            v59.Text = v320 and "person" or "three-people"
            v61.Text = v320 and "One on one" or "Three a side"
            v82.Text = v320 and "A bot takes an empty side" or "Bots take the empty slots, up to 3v3"
            ui10.Visible = visible and not isBusy2
            parent8.AutoButtonColor = false
            v46.Text.Text = visible and "SETTINGS" or "SERVER"
        end

        local function paintMaps(options)
            --[[
              name: paintMaps
              line: 994
              upvalues:
                buildMapCards (copy, index: 1)
                v143 (copy, index: 2)
                v156 (copy, index: 3)
                colors (copy, index: 4)
                ui13 (copy, index: 5)
            ]]
            local v323
            local v324
            local text

            if type(options.maps) ~= "table" then
                v323 = {}
            else
                v323 = options.maps
            end

            buildMapCards(v323)
            local map = if v143.map ~= nil then v143.map else options.map or ""

            for _, v328 in v156 do
                local visible = v328.id == map
                v328.check.Visible = visible
                v328.stroke.Color = if visible then colors.Accent else colors.Stroke
                v328.stroke.Thickness = visible and 3 or 1
                v328.stroke.Transparency = visible and 0 or 0.88
                v328.img.ImageTransparency = not visible and map ~= "" and 0.15 or 0
            end

            local v330 = "RANDOM"

            if type(options.maps) ~= "table" then
                v324 = {}
            else
                v324 = options.maps
            end

            text = v330

            for _, v332 in v324 do
                if v332.id == map then
                    text = string.upper(v332.name)
                end
            end

            ui13.Text = text
        end

        local function paintMatch(options)
            --[[
              name: paintMatch
              line: 1014
              upvalues:
                custom (copy, index: 1)
                v41 (copy, index: 2)
                v44 (copy, index: 3)
                parent5 (copy, index: 4)
                v66 (copy, index: 5)
                ui (copy, index: 6)
                ui7 (copy, index: 7)
                isBusy (ref,  index: 8)
                ui4 (copy, index: 9)
                colors (copy, index: 10)
                ui5 (copy, index: 11)
                ui6 (copy, index: 12)
                CustomMatch (copy, index: 13)
                modeOf (copy, index: 14)
                teamsPreview (copy, index: 15)
                v143 (copy, index: 16)
                theme (copy, index: 17)
                ui8 (copy, index: 18)
                textColor3 (copy, index: 19)
                anyPicks (copy, index: 20)
            ]]
            local text
            local text3
            local status = options.status or "Lobby"
            local v338 = status == "Match" or status == "Results"
            local isHost = custom.IsHost()
            v41.Instance.Visible = isHost and not v338
            v44.Instance.Visible = isHost and v338
            parent5.Visible = not isHost
            v66.Instance.Visible = ui.Compact and isHost
            ui7.Text = "HOSTED BY " .. string.upper((tostring(options.ownerName or "?")))

            if status ~= "Results" then
                text = "END MATCH"
            else
                text = "CLOSE RESULTS"
            end

            v44:SetText(text)
            v41:SetEnabled(options.canStart == true and not isBusy)
            local text2 = options.startHint ~= "Starting..." and "START MATCH" or "STARTING..."
            v41:SetText(text2)

            if status == "Match" then
                ui4.BackgroundColor3 = colors.Warning
                ui5.Text = "Match in progress"
            elseif status == "Results" then
                ui4.BackgroundColor3 = colors.Accent
                ui5.Text = "Showing the results"
            else
                ui4.BackgroundColor3 = colors.Success
                ui5.Text = "Waiting to start"
            end

            local v341 = ui.Compact and not isHost

            if v341 then
                text3 = CustomMatch.ModeLabel(modeOf(options))
            else
                text3 = v338 and "" or teamsPreview(options)
            end

            ui6.Text = text3
            ui6.TextColor3 = if v341
                and CustomMatch.Mode(if v143.mode == nil then options.mode else v143.mode) == "1v1" then theme.Lighten(colors.Accent, 0.2) else colors.TextDim

            if v338 then
                ui8.Text = "Everyone comes back here after the match"
                ui8.TextColor3 = textColor3

                return
            end

            if not isHost then
                ui8.Text = "The host picks the map and starts the match"
                ui8.TextColor3 = textColor3

                return
            end

            if not options.canStart then
                local textColor32
                ui8.Text = tostring((options.startHint or ""))

                if options.startHint ~= "Starting..." then
                    textColor32 = theme.Lighten(colors.Warning, 0.15)
                else
                    textColor32 = textColor3
                end

                ui8.TextColor3 = textColor32

                return
            end

            local v343
            local bots = if v143.bots ~= nil then v143.bots else options.bots == true

            if type(options.players) ~= "table" then
                v343 = 0
            else
                v343 = #options.players
            end

            if anyPicks(options) then
                ui8.Text = bots and "Picked teams stay, bots fill the empty slots"
                    or "Picked teams stay, the rest are shuffled"
            elseif CustomMatch.TeamSize(modeOf(options)) == 1 and 2 < v343 then
                ui8.Text = "Two fight, the rest watch and go next"
            else
                ui8.Text = bots and "Teams are shuffled, bots fill the empty slots" or "Teams are shuffled every match"
            end

            ui8.TextColor3 = textColor3
        end

        local copying = false

        local function paintCode(a347)
            --[[
              name: paintCode
              line: 1063
              upvalues:
                custom (copy, index: 1)
                CustomMatch (copy, index: 2)
                ui2 (copy, index: 3)
                v26 (copy, index: 4)
                parent2 (copy, index: 5)
                v28 (copy, index: 6)
            ]]
            local visible = a347.public == false
            local visible2 = visible and not custom.IsRevealed()
            local text = CustomMatch.FormatCode((tostring(a347.code or "")))

            if ui2.Text ~= text then
                ui2.Text = text
            end

            ui2.TextTransparency = visible2 and 1 or 0
            v26.Visible = visible2
            parent2.Visible = visible
            v28.Text = custom.IsRevealed() and "eye-slash" or "eye"
            local v351 = visible and -52 or -14
            ui2.Position = UDim2.new(1, v351, 0, 0)
            v26.Position = UDim2.new(1, v351 - 2, 0.5, 0)
            ui2.Size = UDim2.new(1, v351 - 56, 1, 0)
        end

        local function paintHeader(options)
            --[[
              name: paintHeader
              line: 1080
              upvalues:
                v22 (copy, index: 1)
                custom (copy, index: 2)
                CustomMatch (copy, index: 3)
                paintCode (copy, index: 4)
                parent9 (copy, index: 5)
                v71 (copy, index: 6)
            ]]
            local v354
            v22.Title.Text = "CUSTOM MATCH"

            if type(options.players) ~= "table" then
                v354 = 0
            else
                v354 = #options.players
            end

            local v355 = custom.IsHost() and "" or "  ·  hosted by " .. tostring(options.ownerName or "?")
            local subtitle = v22.Subtitle
            local stringFormat = string.format
            local text = tostring((options.name or ""))
            subtitle.Text = stringFormat("%s  ·  %d/%d players%s", text, v354, (tonumber(options.max)
                or CustomMatch.MAX_PLAYERS), v355)
            paintCode(options)

            if not parent9.Visible then
                v71.AutoLocalize = false
                v71.Text = tostring((options.name or ""))
            end
        end

        local v359 = false

        local function stack()
            --[[
              name: stack
              line: 1094
              upvalues:
                v92 (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                v93 (copy, index: 3)
                v232 (ref,  index: 4)
                v12 (ref,  index: 5)
                v125 (copy, index: 6)
                flooredValue (ref,  index: 7)
                parent13 (copy, index: 8)
                v135 (copy, index: 9)
                v136 (copy, index: 10)
                v139 (copy, index: 11)
                ui13 (copy, index: 12)
                parent14 (copy, index: 13)
                v359 (ref,  index: 14)
                v85 (copy, index: 15)
                parent12 (copy, index: 16)
            ]]
            local v361 = 8
            v92.Position = udim2FromOffset(8, v361)
            v93.Position = udim2FromOffset(v232 + 8, v361 + 3)
            local v362 = v361 + (v12.sectionH + v12.sectionGap)
            v125[1].frame.Position = udim2FromOffset(8, v362)
            v125[2].frame.Position = udim2FromOffset((flooredValue + 8) + v12.teamGap, v362)
            local v363 = v362 + (v125[1].frame.Size.Y.Offset + v12.blockGap)

            if parent13.Visible then
                v135.Position = udim2FromOffset(8, v363)
                v136.Position = udim2FromOffset(v232 + 8, v363 + 3)
                local v364 = v363 + (v12.sectionH + v12.sectionGap)
                parent13.Position = udim2FromOffset(8, v364)
                v363 = v364 + (parent13.Size.Y.Offset + v12.blockGap)
            end

            v139.Position = udim2FromOffset(8, v363)
            ui13.Position = udim2FromOffset(v232 + 8, v363 + 3)
            local v365 = v363 + (v12.sectionH + v12.sectionGap)
            parent14.Position = udim2FromOffset(8, v365)
            local v366 = v365 + parent14.Size.Y.Offset

            if v359 then
                v85.Instance.Position = udim2FromOffset(8, v366 + 16)
                v366 += 16 + v12.leaveH
            end

            parent12.CanvasSize = udim2FromOffset(0, v366 + 8)
        end

        local function paint(a368: boolean?)
            --[[
              name: paint
              line: 1121
              upvalues:
                custom (copy, index: 1)
                v142 (ref,  index: 2)
                paintHeader (copy, index: 3)
                paintMatch (copy, index: 4)
                paintSwitches (copy, index: 5)
                paintMaps (copy, index: 6)
                paintTeams (copy, index: 7)
                stack (copy, index: 8)
            ]]
            local options = custom.State() or {}
            v142 = options
            paintHeader(options)
            paintMatch(options)
            paintSwitches(options, a368)
            paintMaps(options)
            paintTeams(options)
            stack()
        end

        local function host(a371: string, a372, key: string?, value)
            --[[
              name: host
              line: 1133
              upvalues:
                v143 (copy, index: 1)
                paint (copy, index: 2)
                custom (copy, index: 3)
                a11 (copy, index: 4)
            ]]
            if key then
                v143[key] = value
                paint()
            end

            local v375, v376 = custom.Host(a371, a372)

            if key then
                v143[key] = nil
            end

            if not v375 then
                a11.Toast(tostring(v376), "error")
            end

            paint()

            return v375
        end

        v158 = function(value)
            --[[
              line: 1149
              upvalues:
                custom (copy, index: 1)
                v143 (copy, index: 2)
                a11 (copy, index: 3)
                v156 (copy, index: 4)
                ui (copy, index: 5)
                host (copy, index: 6)
            ]]
            local v378 = custom.State() or {}
            local map = if v143.map ~= nil then v143.map else v378.map or ""

            if value == map then
                return
            end

            a11.Sounds.Play("Select")

            for _, v381 in v156 do
                if v381.id == value then
                    ui.Bump(v381.btn, 0.05)
                end
            end

            task.spawn(host, "SetMap", value, "map", value)
        end

        local function sideCount(a383, a384)
            --[[
              name: sideCount
              line: 1166
              upvalues:
                custom (copy, index: 1)
                v228 (copy, index: 2)
            ]]
            local v385
            local count = 0
            local v387 = custom.State() or {}

            if type(v387.players) ~= "table" then
                v385 = {}
            else
                v385 = v387.players
            end

            for _, v389 in v385 do
                if type(v389) == "table" then
                    if v389.userId == a384 then
                        continue
                    end

                    local v390 = v228[v389.userId]
                    local v391 = if v390 == nil then tonumber(v389.team) or 0 else v390
                    local v392 = v391 ~= 1 and v391 ~= 2 and 0 or v391

                    if v392 == a383 then
                        count += 1
                    end
                end
            end

            return count
        end

        local v393 = {}

        local function setTeamOf(userId, team)
            --[[
              name: setTeamOf
              line: 1177
              upvalues:
                v393 (copy, index: 1)
                v228 (copy, index: 2)
                paint (copy, index: 3)
                localPlayer (copy, index: 4)
                custom (copy, index: 5)
                a11 (copy, index: 6)
            ]]
            local v397, v398
            v393[userId] = (v393[userId] or 0) + 1
            local v399 = v393[userId]
            v228[userId] = team
            paint()

            if userId ~= localPlayer.UserId then
                v397, v398 = custom.Host("Move", {userId = userId, team = team})
            else
                v397, v398 = custom.Host("Team", team)
            end

            if v393[userId] == v399 then
                v228[userId] = nil
            end

            if not v397 then
                a11.Toast(tostring(v398), "error")
            end

            paint()
        end

        v94 = function(team)
            --[[
              line: 1196
              upvalues:
                v234 (ref,  index: 1)
                sideCount (copy, index: 2)
                localPlayer (copy, index: 3)
                custom (copy, index: 4)
                CustomMatch (copy, index: 5)
                modeOf (copy, index: 6)
                a11 (copy, index: 7)
                setTeamOf (copy, index: 8)
            ]]
            if v234 == nil or v234 == team then
                return
            end

            if team ~= 0 then
                local v401 = sideCount(team, localPlayer.UserId)
                local v402 = custom.State() or {}

                if CustomMatch.TeamSize(modeOf(v402)) <= v401 then
                    a11.Toast(`Team {team} is full`, "info")
                    return
                end
            end

            a11.Sounds.Play("Select")
            task.spawn(setTeamOf, localPlayer.UserId, team)
        end

        parent10.Activated:Connect(
            function()
                --[[
                  line: 1208
                  upvalues:
                    custom (copy, index: 1)
                    v143 (copy, index: 2)
                    a11 (copy, index: 3)
                    host (copy, index: 4)
                ]]
                local pitch

                if not custom.IsHost() then
                    return
                end

                local v404 = custom.State() or {}
                local public = if v143.public ~= nil then v143.public else v404.public == true
                local play = a11.Sounds.Play
                local v407 = {}

                if public then
                    pitch = 0.94
                else
                    pitch = 1.08
                end

                v407.pitch = pitch
                play("Click", v407)
                task.spawn(host, "SetPublic", not public, "public", not public)
            end
        )

        v62 = function(a408)
            --[[
              line: 1218
              upvalues:
                custom (copy, index: 1)
                CustomMatch (copy, index: 2)
                v143 (copy, index: 3)
                a11 (copy, index: 4)
                host (copy, index: 5)
            ]]
            local pitch

            if not custom.IsHost() then
                return
            end

            local value = CustomMatch.Mode(a408)
            local v411 = custom.State() or {}
            local mode = CustomMatch.Mode
            local mode2 = if v143.mode ~= nil then v143.mode else v411.mode

            if value == mode(mode2) then
                return
            end

            local play = a11.Sounds.Play
            local v415 = {}

            if value ~= "1v1" then
                pitch = 0.94
            else
                pitch = 1.08
            end

            v415.pitch = pitch
            play("Click", v415)
            task.spawn(host, "SetMode", value, "mode", value)
        end

        parent7.Activated:Connect(
            function()
                --[[
                  line: 1229
                  upvalues:
                    custom (copy, index: 1)
                    v62 (ref,  index: 2)
                    CustomMatch (copy, index: 3)
                    v143 (copy, index: 4)
                ]]
                if custom.IsHost() then
                    local v416 = v62
                    local v417 = custom.State() or {}
                    local mode = CustomMatch.Mode
                    local mode2 = if v143.mode ~= nil then v143.mode else v417.mode
                    local v420 = mode(mode2) ~= "1v1" and "1v1" or "3v3"
                    v416(v420)
                end
            end
        )

        parent11.Activated:Connect(
            function()
                --[[
                  line: 1234
                  upvalues:
                    custom (copy, index: 1)
                    v143 (copy, index: 2)
                    a11 (copy, index: 3)
                    host (copy, index: 4)
                ]]
                local pitch

                if not custom.IsHost() then
                    return
                end

                local v422 = custom.State() or {}
                local bots = if v143.bots ~= nil then v143.bots else v422.bots == true
                local play = a11.Sounds.Play
                local v425 = {}

                if bots then
                    pitch = 0.94
                else
                    pitch = 1.08
                end

                v425.pitch = pitch
                play("Click", v425)
                task.spawn(host, "SetBots", not bots, "bots", not bots)
            end
        )

        v41.Activated:Connect(
            function()
                --[[
                  line: 1244
                  upvalues:
                    isBusy (ref,  index: 1)
                    v41 (copy, index: 2)
                    custom (copy, index: 3)
                    a11 (copy, index: 4)
                    paint (copy, index: 5)
                ]]
                if isBusy then
                    return
                end

                isBusy = true
                v41:SetText("STARTING...")
                v41:SetEnabled(false)
                local v426, v427 = custom.Host("Start", nil)
                if not v426 then
                    a11.Toast(tostring(v427), "error")
                end

                paint()
                isBusy = false

                if v426 then
                    a11.Sounds.Play("Match_Found")
                    a11.MenuManager.Close("CustomHost")

                    return
                end

                paint()
            end
        )

        do
            local function beginEdit()
                --[[
                  name: beginEdit
                  line: 1262
                  upvalues:
                    isBusy2 (ref,  index: 1)
                    parent9 (copy, index: 2)
                    custom (copy, index: 3)
                    CustomMatch (copy, index: 4)
                    localPlayer (copy, index: 5)
                    v71 (copy, index: 6)
                    v70 (copy, index: 7)
                    ui10 (copy, index: 8)
                    v69 (copy, index: 9)
                ]]
                if isBusy2 then
                    return
                end

                isBusy2 = true
                local v429 = custom.State() or {}
                parent9.Text = tostring((v429.name or ""))
                parent9.PlaceholderText = CustomMatch.DefaultName(localPlayer.DisplayName)
                parent9.Visible = true
                v71.Visible = false
                v70.Visible = false
                ui10.Visible = false
                v69.Visible = false
                parent9:CaptureFocus()
            end
        end

        do
            local function endEdit()
                --[[
                  name: endEdit
                  line: 1276
                  upvalues:
                    isBusy2 (ref,  index: 1)
                    parent9 (copy, index: 2)
                    v71 (copy, index: 3)
                    v70 (copy, index: 4)
                    ui10 (copy, index: 5)
                    v69 (copy, index: 6)
                ]]
                isBusy2 = false
                parent9.Visible = false
                v71.Visible = true
                v70.Visible = true
                ui10.Visible = true
                v69.Visible = true
            end
        end

        parent8.Activated:Connect(
            function()
                --[[
                  line: 1284
                  upvalues:
                    custom (copy, index: 1)
                    a11 (copy, index: 2)
                    isBusy2 (ref,  index: 3)
                    parent9 (copy, index: 4)
                    CustomMatch (copy, index: 5)
                    localPlayer (copy, index: 6)
                    v71 (copy, index: 7)
                    v70 (copy, index: 8)
                    ui10 (copy, index: 9)
                    v69 (copy, index: 10)
                ]]
                if not custom.IsHost() then
                    return
                end

                a11.Sounds.Play("Click")

                if isBusy2 then
                    return
                end

                isBusy2 = true
                local v431 = custom.State() or {}
                parent9.Text = tostring((v431.name or ""))
                parent9.PlaceholderText = CustomMatch.DefaultName(localPlayer.DisplayName)
                parent9.Visible = true
                v71.Visible = false
                v70.Visible = false
                ui10.Visible = false
                v69.Visible = false
                parent9:CaptureFocus()
            end
        )

        parent9:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 1291
                  upvalues:
                    parent9 (copy, index: 1)
                    CustomMatch (copy, index: 2)
                ]]
                local text = parent9.Text
                local v433 = utf8.len(text) or #text

                if CustomMatch.NAME_MAX < v433 then
                    local v434 = utf8.offset(text, CustomMatch.NAME_MAX + 1) or #text + 1
                    parent9.Text = string.sub(text, 1, v434 - 1)
                end
            end
        )

        parent9.FocusLost:Connect(
            function()
                --[[
                  line: 1299
                  upvalues:
                    isBusy2 (ref,  index: 1)
                    parent9 (copy, index: 2)
                    custom (copy, index: 3)
                    v71 (copy, index: 4)
                    v70 (copy, index: 5)
                    ui10 (copy, index: 6)
                    v69 (copy, index: 7)
                    CustomMatch (copy, index: 8)
                    localPlayer (copy, index: 9)
                    a11 (copy, index: 10)
                    paint (copy, index: 11)
                ]]
                if not isBusy2 then
                    return
                end

                local text = parent9.Text
                local v436 = custom.State() or {}
                local text2 = tostring((v436.name or ""))
                isBusy2 = false
                parent9.Visible = false
                v71.Visible = true
                v70.Visible = true
                ui10.Visible = true
                v69.Visible = true

                if CustomMatch.CleanName(text) == text2 then
                    return
                end

                v71.Text = if CustomMatch.CleanName(text) ~= "" then CustomMatch.CleanName(text) else CustomMatch.DefaultName(localPlayer.DisplayName)

                task.spawn(
                    function()
                        --[[
                          line: 1310
                          upvalues:
                            text (copy, index: 1)
                            custom (copy, index: 2)
                            a11 (copy, index: 3)
                            paint (copy, index: 4)
                            v71 (copy, index: 5)
                            text2 (copy, index: 6)
                        ]]
                        local v438, v439 = custom.Host("SetName", text)
                        if not v438 then
                            a11.Toast(tostring(v439), "error")
                        end

                        paint()

                        if v438 then
                            a11.Sounds.Play("Select")
                            return
                        end

                        v71.Text = text2
                    end
                )
            end
        )

        parent2.Activated:Connect(
            function()
                --[[
                  line: 1324
                  upvalues:
                    custom (copy, index: 1)
                ]]
                if custom.IsRevealed() then
                    custom.Hide()
                    return
                end

                custom.Reveal()
            end
        )

        local count = 0
        local v441 = 0

        do
            local function resetCopyLook()
                --[[
                  name: resetCopyLook
                  line: 1333
                  upvalues:
                    ui3 (copy, index: 1)
                    v30 (copy, index: 2)
                    icon (copy, index: 3)
                ]]
                ui3.Visible = false
                v30:SetText("COPY")
                icon.Text = "two-stacked-squares"
            end
        end

        do
            local function stopCopy()
                --[[
                  name: stopCopy
                  line: 1338
                  upvalues:
                    copying (ref,  index: 1)
                    v441 (ref,  index: 2)
                    ui3 (copy, index: 3)
                    v30 (copy, index: 4)
                    icon (copy, index: 5)
                ]]
                copying = false
                local timestamp = os.clock()

                if v441 <= timestamp then
                    ui3.Visible = false
                    v30:SetText("COPY")
                    icon.Text = "two-stacked-squares"
                end
            end
        end

        local function copyCode()
            --[[
              name: copyCode
              line: 1344
              upvalues:
                custom (copy, index: 1)
                ui (copy, index: 2)
                paintCode (copy, index: 3)
                count (ref,  index: 4)
                v441 (ref,  index: 5)
                icon (copy, index: 6)
                copying (ref,  index: 7)
                ui2 (copy, index: 8)
                ui3 (copy, index: 9)
                v30 (copy, index: 10)
            ]]
            local v446 = custom.State() or {}

            if type(v446.code) ~= "string" or v446.code == "" then
                return
            end

            if ui.Touch and v446.public == false and not custom.IsRevealed() then
                custom.Reveal()
            end

            paintCode(v446)
            count += 1
            v441 = 0
            icon.Text = "two-stacked-squares"
            copying = true
            ui2:CaptureFocus()

            local function selectAll()
                --[[
                  name: selectAll
                  line: 1358
                  upvalues:
                    copying (ref,  index: 1)
                    ui2 (copy, index: 2)
                ]]
                if copying and ui2:IsFocused() then
                    ui2.SelectionStart = 1
                    ui2.CursorPosition = #ui2.Text + 1
                end
            end

            if copying and ui2:IsFocused() then
                ui2.SelectionStart = 1
                ui2.CursorPosition = #ui2.Text + 1
            end

            task.defer(selectAll)
            ui3.Text = ui.Touch and "Tap and hold the code to copy" or "Press Ctrl+C (Cmd+C on Mac) to copy"
            ui3.Visible = true
            ui.Enter(ui3, Vector2.new(0, -4), 0, ui3.Position)
            v30:SetText("SELECTED")
        end

        v30.Activated:Connect(copyCode)
        v30.Instance.Visible = not ui.Gamepad
        ui.GamepadChanged:Connect(
            function()
                --[[
                  name: refreshCopy
                  line: 1374
                  upvalues:
                    v30 (copy, index: 1)
                    ui (copy, index: 2)
                ]]
                v30.Instance.Visible = not ui.Gamepad
            end
        )

        do
            local function copyModifier()
                --[[
                  name: copyModifier
                  line: 1382
                  upvalues:
                    userInputService (copy, index: 1)
                ]]
                for _, keyCode in {Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.LeftSuper, Enum.KeyCode.RightSuper, Enum.KeyCode.LeftMeta, Enum.KeyCode.RightMeta} do
                    if userInputService:IsKeyDown(keyCode) then
                        return true
                    end
                end

                return false
            end

            userInputService.InputBegan:Connect(
                function(input: InputObject)
                    --[[
                      line: 1390
                      upvalues:
                        copying (ref,  index: 1)
                        ui2 (copy, index: 2)
                        copyModifier (copy, index: 3)
                        count (ref,  index: 4)
                        v441 (ref,  index: 5)
                        v30 (copy, index: 6)
                        icon (copy, index: 7)
                        ui3 (copy, index: 8)
                        Keybinds (copy, index: 9)
                        a11 (copy, index: 10)
                    ]]
                    if not copying or not ui2:IsFocused() then
                        return
                    end

                    if input.KeyCode == Enum.KeyCode.C and copyModifier() then
                        count += 1
                        local v452 = count
                        v441 = os.clock() + 1.6
                        v30:SetText("COPIED")
                        icon.Text = "check"
                        ui3.Text = "Copied to your clipboard"
                        ui3.Visible = true

                        task.delay(
                            0.2,
                            function()
                                --[[
                                  line: 1402
                                  upvalues:
                                    v452 (copy, index: 1)
                                    count (ref,  index: 2)
                                    ui2 (copy, index: 3)
                                ]]
                                if v452 == count and ui2:IsFocused() then
                                    ui2:ReleaseFocus()
                                end
                            end
                        )

                        task.delay(
                            1.65,
                            function()
                                --[[
                                  line: 1407
                                  upvalues:
                                    v452 (copy, index: 1)
                                    count (ref,  index: 2)
                                    copying (ref,  index: 3)
                                    ui3 (copy, index: 4)
                                    v30 (copy, index: 5)
                                    icon (copy, index: 6)
                                ]]
                                if v452 == count and not copying then
                                    ui3.Visible = false
                                    v30:SetText("COPY")
                                    icon.Text = "two-stacked-squares"
                                end
                            end
                        )

                        return
                    end

                    if Keybinds.IsPad(input, "CustomMenu") or Keybinds.ActionOf(input) == "CustomMenu" then
                        a11.MenuManager.Toggle("CustomHost")
                    end
                end
            )
        end

        ui2.FocusLost:Connect(
            function()
                --[[
                  line: 1416
                  upvalues:
                    ui (copy, index: 1)
                    ui2 (copy, index: 2)
                    copying (ref,  index: 3)
                    v441 (ref,  index: 4)
                    ui3 (copy, index: 5)
                    v30 (copy, index: 6)
                    icon (copy, index: 7)
                ]]
                local taskDelay = task.delay
                local v454 = ui.Touch and 0 or 0.15

                taskDelay(
                    v454,
                    function()
                        --[[
                          line: 1417
                          upvalues:
                            ui2 (copy, index: 1)
                            copying (ref,  index: 2)
                            v441 (ref,  index: 3)
                            ui3 (copy, index: 4)
                            v30 (copy, index: 5)
                            icon (copy, index: 6)
                        ]]
                        if not ui2:IsFocused() then
                            copying = false
                            local timestamp = os.clock()

                            if v441 <= timestamp then
                                ui3.Visible = false
                                v30:SetText("COPY")
                                icon.Text = "two-stacked-squares"
                            end
                        end
                    end
                )
            end
        )

        ui2:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 1424
                  upvalues:
                    CustomMatch (copy, index: 1)
                    custom (copy, index: 2)
                    ui2 (copy, index: 3)
                ]]
                local formatCode = CustomMatch.FormatCode
                local v457 = custom.State() or {}
                local text = formatCode((tostring(v457.code or "")))

                if ui2.Text ~= text then
                    ui2.Text = text
                end
            end
        )

        custom.RevealChanged:Connect(
            function()
                --[[
                  line: 1430
                  upvalues:
                    v22 (copy, index: 1)
                    paintCode (copy, index: 2)
                    custom (copy, index: 3)
                ]]
                if v22.IsOpen then
                    paintCode((custom.State() or {}))
                end
            end
        )

        local v459 = nil
        local v460 = nil

        local function closeConfirm()
            --[[
              name: closeConfirm
              line: 1440
              upvalues:
                v460 (ref, index: 1)
                v459 (ref, index: 2)
            ]]
            v460 = nil

            if v459 then
                v459.layer.Visible = false
            end
        end

        local function openConfirm(text: string, text2: string, text3: string, text4: string, style: string, a468)
            --[[
              name: openConfirm
              line: 1446
              upvalues:
                v459 (ref,  index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
                v22 (copy, index: 4)
                closeConfirm (copy, index: 5)
                udim2FromOffset (copy, index: 6)
                fonts (copy, index: 7)
                v460 (ref,  index: 8)
                a11 (copy, index: 9)
                guiService (copy, index: 10)
            ]]
            if not v459 then
                local ui2 = ui.new("TextButton", {Name = "Confirm", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, (ui.Corner(UDim.new(0, 16))), Parent = v22.Holder})
                ui2.Activated:Connect(closeConfirm)
                local v470 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(480, 256), Radius = UDim.new(0, 16), Parent = ui2})
                ui.new("TextButton", {Name = "Sink", BackgroundTransparency = 1, Text = "", Selectable = false, ZIndex = 41, Size = UDim2.fromScale(1, 1), Parent = v470})
                local title = ui.DisplayText({Name = "Title", Text = "", TextSize = 34, ZIndex = 42, Position = udim2FromOffset(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = colors.Text, Parent = v470})
                local body = ui.new("TextLabel", {Name = "Body", Text = "", TextSize = 19, TextWrapped = true, ZIndex = 42, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 74), FontFace = fonts.Bold, TextColor3 = colors.TextDim, Parent = v470})
                local no = ui.Button({Name = "No", Text = "", TextSize = 21, Style = "Dark", ZIndex = 43, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = udim2FromOffset(200, 58), Parent = v470})
                local yes = ui.Button({Name = "Yes", Text = "", TextSize = 21, Style = "Danger", ZIndex = 43, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = udim2FromOffset(200, 58), Parent = v470})
                no.Activated:Connect(closeConfirm)

                yes.Activated:Connect(
                    function()
                        --[[
                          line: 1488
                          upvalues:
                            v460 (ref, index: 1)
                            v459 (ref, index: 2)
                        ]]
                        local v475 = v460
                        v460 = nil

                        if v459 then
                            v459.layer.Visible = false
                        end

                        if v475 then
                            v475()
                        end
                    end
                )

                v459 = {layer = ui2, card = v470, title = title, body = body, no = no, yes = yes}
            end

            local v476 = v459
            v476.title.AutoLocalize = true
            v476.title.Text = text
            v476.body.Text = text2
            v476.no:SetText(text3)
            v476.yes:SetText(text4)
            v476.yes:SetStyle(style)
            v460 = a468
            v476.layer.Visible = true
            ui.Enter(v476.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
            a11.Sounds.Play("Open")

            if ui.Gamepad then
                guiService.SelectedObject = v476.no.Instance
            end
        end

        v44.Activated:Connect(
            function()
                --[[
                  line: 1513
                  upvalues:
                    custom (copy, index: 1)
                    host (copy, index: 2)
                    openConfirm (copy, index: 3)
                    a11 (copy, index: 4)
                    paint (copy, index: 5)
                ]]
                local v477 = custom.State() or {}

                if v477.status == "Results" then
                    task.spawn(host, "End")
                    return
                end

                openConfirm(
                    "END MATCH?",
                    "Everyone goes back to the lobby now. The match won't count for anything.",
                    "KEEP PLAYING",
                    "END MATCH",
                    "Danger",
                    function()
                        --[[
                          line: 1519
                          upvalues:
                            custom (copy, index: 1)
                            a11 (copy, index: 2)
                            paint (copy, index: 3)
                        ]]
                        task.spawn(
                            function()
                                --[[
                                  line: 1520
                                  upvalues:
                                    custom (copy, index: 1)
                                    a11 (copy, index: 2)
                                    paint (copy, index: 3)
                                ]]
                                local v478, v479 = custom.Host("End", nil)
                                if not v478 then
                                    a11.Toast(tostring(v479), "error")
                                end

                                paint()

                                if v478 then
                                    a11.MenuManager.Close("CustomHost")
                                end
                            end
                        )
                    end
                )
            end
        )

        local v480 = function(a481, text)
            --[[
              line: 1527
              upvalues:
                openConfirm (copy, index: 1)
                custom (copy, index: 2)
                a11 (copy, index: 3)
                paint (copy, index: 4)
            ]]
            openConfirm(
                "REMOVE PLAYER?",
                string.format("%s goes back to a public lobby and can't rejoin this match.", text),
                "CANCEL",
                "REMOVE",
                "Danger",
                function()
                    --[[
                      line: 1528
                      upvalues:
                        a481 (copy, index: 1)
                        custom (copy, index: 2)
                        a11 (copy, index: 3)
                        paint (copy, index: 4)
                        text (copy, index: 5)
                    ]]
                    task.spawn(
                        function()
                            --[[
                              line: 1529
                              upvalues:
                                a481 (copy, index: 1)
                                custom (copy, index: 2)
                                a11 (copy, index: 3)
                                paint (copy, index: 4)
                                text (copy, index: 5)
                            ]]
                            local v483, v484 = custom.Host("Kick", a481)
                            if not v483 then
                                a11.Toast(tostring(v484), "error")
                            end

                            paint()

                            if v483 then
                                a11.Toast(string.format("%s was removed", text), "info")
                            end
                        end
                    )
                end
            )
        end

        v85.Activated:Connect(
            function()
                --[[
                  line: 1536
                  upvalues:
                    openConfirm (copy, index: 1)
                    custom (copy, index: 2)
                    a11 (copy, index: 3)
                ]]
                openConfirm(
                    "LEAVE SERVER?",
                    "You'll go back to a public lobby. The player here longest becomes the host.",
                    "STAY",
                    "LEAVE",
                    "Danger",
                    function()
                        --[[
                          line: 1537
                          upvalues:
                            custom (copy, index: 1)
                            a11 (copy, index: 2)
                        ]]
                        task.spawn(
                            function()
                                --[[
                                  line: 1538
                                  upvalues:
                                    custom (copy, index: 1)
                                    a11 (copy, index: 2)
                                ]]
                                local v485, v486 = custom.Action("Leave")
                                if v485 then
                                    a11.MenuManager.Close("CustomHost")
                                    return
                                end

                                a11.Toast(tostring(v486), "error")
                            end
                        )
                    end
                )
            end
        )
        local v487 = nil
        local v488 = 0

        do
            local v489 = {"TEAM 1", "TEAM 2", "RANDOM"}

            local function closeMove()
                --[[
                  name: closeMove
                  line: 1556
                  upvalues:
                    v488 (ref, index: 1)
                    v487 (ref, index: 2)
                ]]
                v488 = 0

                if v487 then
                    v487.layer.Visible = false
                end
            end

            local function findPlayer(a492)
                --[[
                  name: findPlayer
                  line: 1562
                  upvalues:
                    custom (copy, index: 1)
                ]]
                local v493
                local v494 = custom.State() or {}

                if type(v494.players) ~= "table" then
                    v493 = {}
                else
                    v493 = v494.players
                end

                for _, v496 in v493 do
                    if type(v496) == "table" and v496.userId == a492 then
                        return v496
                    end
                end

                return nil
            end

            v189 = function(a497)
                --[[
                  line: 1571
                  upvalues:
                    findPlayer (copy, index: 1)
                    custom (copy, index: 2)
                    v487 (ref,  index: 3)
                    ui (copy, index: 4)
                    colors (copy, index: 5)
                    v22 (copy, index: 6)
                    closeMove (copy, index: 7)
                    udim2FromOffset (copy, index: 8)
                    fonts (copy, index: 9)
                    v91 (copy, index: 10)
                    theme (copy, index: 11)
                    v489 (copy, index: 12)
                    v488 (ref,  index: 13)
                    v228 (copy, index: 14)
                    a11 (copy, index: 15)
                    setTeamOf (copy, index: 16)
                    v480 (ref,  index: 17)
                    sideCount (copy, index: 18)
                    CustomMatch (copy, index: 19)
                    modeOf (copy, index: 20)
                    guiService (copy, index: 21)
                ]]
                local player = findPlayer(a497)

                if not custom.IsHost() or not player then
                    return
                end

                local formattedText
                local v500

                if not v487 then
                    local ui2 = ui.new("TextButton", {Name = "Move", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, (ui.Corner(UDim.new(0, 16))), Parent = v22.Holder})
                    ui2.Activated:Connect(closeMove)
                    local v502 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(540, 286), Radius = UDim.new(0, 16), Parent = ui2})
                    ui.new("TextButton", {Name = "Sink", BackgroundTransparency = 1, Text = "", Selectable = false, ZIndex = 41, Size = UDim2.fromScale(1, 1), Parent = v502})
                    local title = ui.DisplayText({Name = "Title", Text = "", TextSize = 32, ZIndex = 42, Position = udim2FromOffset(28, 24), Size = UDim2.new(1, -56, 0, 40), TextColor3 = colors.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v502})
                    local body = ui.new("TextLabel", {Name = "Body", Text = "", TextSize = 18, ZIndex = 42, Position = udim2FromOffset(28, 66), Size = UDim2.new(1, -56, 0, 22), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v502})
                    local picks = {}
                    local marks = {}
                    local v507 = {v91[1], v91[2], colors.TextMuted}

                    for index = 1, 3 do
                        local team = index == 3 and 0 or index
                        local ui3 = ui.new("Frame", {Name = "Mark", Size = udim2FromOffset(16, 16)})
                        ui.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(12, 12), BackgroundColor3 = v507[index], (ui.Corner(theme.Radius.Pill)), Parent = ui3})
                        local v511 = ui.Icon("check", 16, colors.TextDim, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui3})
                        v511.Name = "Check"
                        v511.Visible = false
                        marks[index] = ui3

                        local v512 = ui.Button(
                            {
                                TextSize = 19,
                                Style = "Dark",
                                ZIndex = 43,
                                Name = "Pick" .. team,
                                Text = v489[index],
                                Icon = ui3,
                                Position = udim2FromOffset(((index - 1) * 165) + 28, 110),
                                Size = udim2FromOffset(153, 58),
                                Parent = v502,
                                OnDisabledClick = (function()
                                    --[[
                                      name: OnDisabledClick
                                      line: 1635
                                      upvalues:
                                        findPlayer (copy, index: 1)
                                        v488 (ref,  index: 2)
                                        v228 (copy, index: 3)
                                        team (copy, index: 4)
                                        a11 (copy, index: 5)
                                    ]]
                                    if const player = findPlayer(v488) then
                                        local v514 = v228[player.userId]
                                        if v514 == nil then
                                            v514 = tonumber(player.team) or 0
                                        end

                                        local v515 = v514 ~= 1 and v514 ~= 2 and 0 or v514

                                        if v515 ~= team then
                                            a11.Toast(`Team {team} is full`, "info")
                                        end
                                    end
                                end)
                            }
                        )

                        v512.Activated:Connect(
                            function()
                                --[[
                                  line: 1642
                                  upvalues:
                                    v488 (ref,  index: 1)
                                    v487 (ref,  index: 2)
                                    custom (copy, index: 3)
                                    setTeamOf (copy, index: 4)
                                    team (copy, index: 5)
                                ]]
                                local userId = v488
                                v488 = 0

                                if v487 then
                                    v487.layer.Visible = false
                                end

                                if userId ~= 0 and custom.IsHost() then
                                    task.spawn(setTeamOf, userId, team)
                                end
                            end
                        )

                        picks[index] = v512
                    end

                    local cancel = ui.Button({Name = "Cancel", Text = "CANCEL", TextSize = 21, Style = "Dark", ZIndex = 43, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = udim2FromOffset(200, 58), Parent = v502})
                    local remove = ui.Button({Name = "Remove", Text = "REMOVE", TextSize = 21, Style = "Danger", ZIndex = 43, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = udim2FromOffset(200, 58), Parent = v502})
                    cancel.Activated:Connect(closeMove)

                    remove.Activated:Connect(
                        function()
                            --[[
                              line: 1654
                              upvalues:
                                v488 (ref,  index: 1)
                                findPlayer (copy, index: 2)
                                v487 (ref,  index: 3)
                                v480 (ref,  index: 4)
                            ]]
                            local v519 = v488
                            local player = findPlayer(v519)
                            v488 = 0

                            if v487 then
                                v487.layer.Visible = false
                            end

                            if player then
                                v480(v519, (tostring(player.name or "Player")))
                            end
                        end
                    )

                    v487 = {layer = ui2, card = v502, title = title, body = body, picks = picks, marks = marks, cancel = cancel, remove = remove}
                end

                local v521 = v487
                v488 = a497
                local v522 = v228[player.userId]
                if v522 == nil then
                    v522 = tonumber(player.team) or 0
                end

                local v523 = v522 ~= 1 and v522 ~= 2 and 0 or v522
                v521.title.AutoLocalize = false
                v521.title.Text = string.upper((tostring(player.name or "Player")))
                local body = v521.body
                local stringFormat = string.format
                local text = tostring((player.username or ""))

                if v523 ~= 0 then
                    formattedText = `Team {v523}`
                else
                    formattedText = "Random team"
                end

                body.Text = stringFormat("@%s  ·  %s", text, formattedText)
                v500 = nil

                for v527, pick in v521.picks do
                    local markKey = v527 == 3 and 0 or v527
                    local v530 = false

                    if markKey ~= 0 then
                        v530 = false

                        if markKey ~= v523 then
                            local v531 = sideCount(markKey, a497)
                            local v532 = custom.State() or {}
                            v530 = CustomMatch.TeamSize(modeOf(v532)) <= v531
                        end
                    end

                    local enabled = markKey ~= v523 and not v530
                    pick:SetEnabled(enabled)
                    local text2 = if v530 then v489[markKey] .. " FULL" else v489[v527]
                    pick:SetText(text2)
                    pick.Label.TextSize = v530 and 17 or 19
                    local mark = v521.marks[markKey]
                    local dot = mark:FindFirstChild("Dot")
                    dot.Visible = markKey ~= v523

                    local check = mark:FindFirstChild("Check")
                    check.Visible = markKey == v523
                    local v538 = v500 or (if enabled then pick else nil)
                    v500 = v538
                end

                v521.layer.Visible = true
                ui.Enter(v521.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
                a11.Sounds.Play("Open")

                if ui.Gamepad then
                    local v539 = v500 or v521.cancel
                    guiService.SelectedObject = v539.Instance
                end
            end

            local function layout()
                --[[
                  name: layout
                  line: 1692
                  upvalues:
                    v12 (ref,  index: 1)
                    ui (copy, index: 2)
                    v9 (copy, index: 3)
                    v8 (copy, index: 4)
                    v22 (copy, index: 5)
                    udim2FromOffset (copy, index: 6)
                    v30 (copy, index: 7)
                    parent (copy, index: 8)
                    ui2 (copy, index: 9)
                    v26 (copy, index: 10)
                    parent2 (copy, index: 11)
                    ui3 (copy, index: 12)
                    parent3 (copy, index: 13)
                    v36 (copy, index: 14)
                    ui4 (copy, index: 15)
                    ui5 (copy, index: 16)
                    ui6 (copy, index: 17)
                    v66 (copy, index: 18)
                    v41 (copy, index: 19)
                    v44 (copy, index: 20)
                    parent5 (copy, index: 21)
                    ui7 (copy, index: 22)
                    ui8 (copy, index: 23)
                    parent4 (copy, index: 24)
                    v46 (copy, index: 25)
                    parent7 (copy, index: 26)
                    parent8 (copy, index: 27)
                    parent10 (copy, index: 28)
                    parent11 (copy, index: 29)
                    v69 (copy, index: 30)
                    v70 (copy, index: 31)
                    v71 (copy, index: 32)
                    v75 (copy, index: 33)
                    v76 (copy, index: 34)
                    v77 (copy, index: 35)
                    v59 (copy, index: 36)
                    v61 (copy, index: 37)
                    v63 (copy, index: 38)
                    ui9 (copy, index: 39)
                    v80 (copy, index: 40)
                    v82 (copy, index: 41)
                    ui10 (copy, index: 42)
                    parent9 (copy, index: 43)
                    v78 (copy, index: 44)
                    v83 (copy, index: 45)
                    ui11 (copy, index: 46)
                    parent6 (copy, index: 47)
                    v85 (copy, index: 48)
                    parent12 (copy, index: 49)
                    ui12 (copy, index: 50)
                    updateFade (copy, index: 51)
                    v232 (ref,  index: 52)
                    flooredValue (ref,  index: 53)
                    v92 (copy, index: 54)
                    v93 (copy, index: 55)
                    v135 (copy, index: 56)
                    v136 (copy, index: 57)
                    v139 (copy, index: 58)
                    ui13 (copy, index: 59)
                    custom (copy, index: 60)
                    CustomMatch (copy, index: 61)
                    modeOf (copy, index: 62)
                    v125 (copy, index: 63)
                    v126 (copy, index: 64)
                    v156 (copy, index: 65)
                    parent14 (copy, index: 66)
                    v359 (ref,  index: 67)
                ]]
                local textSize
                local parent13
                v12 = if ui.Compact then v9 else v8
                local v543 = ui.CanvasSize()
                local v544 = ui.TopInset()

                if ui.Compact then
                    v22.Holder.Size = udim2FromOffset(math.floor((math.min(v12.W, v543.X - 24))), (math.floor((math.min(v12.H, (v543.Y - v544) - 12)))))
                else
                    v22.Holder.Size = udim2FromOffset(math.floor((math.clamp(v543.X - 240, v12.W, 1280))), (math.floor((math.clamp((v543.Y - v544) - 90, 660, 740)))))
                end

                v22.Subtitle.TextSize = ui.Compact and 15 or 17
                local v545 = ui.Compact and 226 or 246
                local v546 = ui.Compact and 44 or 48
                local v547 = ui.Compact and 116 or 118
                local v548 = ui.WindowCloseSize() + 30
                v30.Instance.Position = UDim2.new(1, -v548, 0, 14)
                v30.Instance.Size = udim2FromOffset(v547, v546 + 3)
                v30.Label.TextSize = ui.Compact and 18 or 17
                parent.Size = udim2FromOffset(v545, v546)
                parent.Position = UDim2.new(1, -((v548 + v547) + 10), 0, 14)
                ui2.TextSize = ui.Compact and 25 or 28
                local v549 = ui.Compact and 8 or 9

                for v550, child in v26:GetChildren() do
                    local v552
                    local v553 = tonumber(string.match(child.Name, "%d+")) or v550
                    local v554 = v549 * 0.55
                    local v555 = v549 * 1.35
                    child.Size = udim2FromOffset(v549, v549)
                    local v556 = (v553 - 1) * (v549 + v554)

                    if not (3 < v553) then
                        v552 = 0
                    else
                        v552 = v555 - v554
                    end

                    child.Position = udim2FromOffset(v556 + v552, 0)
                end

                v26.Size = udim2FromOffset(((v549 * 6) + ((v549 * 4) * 0.55)) + (v549 * 1.35), v549)
                parent2.Position = UDim2.new(1, -8, 0.5, 0)
                ui3.Position = UDim2.new(1, -v548, 0, (v546 + 14) + 4)
                ui3.Size = udim2FromOffset((v545 + v547) + 10, 14)
                local v557 = (v545 + v547) + v548 + 40
                v22.Title.Size = UDim2.new(1, -v557, 0, 40)
                v22.Subtitle.Size = UDim2.new(1, -v557, 0, 20)
                v22.Subtitle.TextTruncate = Enum.TextTruncate.AtEnd
                local v558 = v22.Holder.Size.X.Offset - 44
                local v559 = v22.Holder.Size.Y.Offset - 80 - 32
                local left = v12.left
                parent3.Size = udim2FromOffset(left, v559)
                local pad = v12.pad
                local v562 = left - pad * 2
                v36.Size = UDim2.new(1, 0, 0, v12.sectionH)
                local pad2 = pad
                ui4.Position = udim2FromOffset(pad + 2, pad2 + 11)
                ui5.Position = udim2FromOffset(pad + 20, pad2)
                ui5.Size = udim2FromOffset(v562 - 110, 22)
                ui5.TextSize = v12.status
                ui6.Position = UDim2.new(1, -pad, 0, pad2)
                ui6.Size = udim2FromOffset(100, 22)
                ui6.TextSize = v12.status - 1
                local v564 = pad2 + 32
                local v565 = not ui.Compact and 0 or v66.Instance.Size.X.Offset + 8
                v66.Instance.Position = udim2FromOffset(pad, v564)

                for _, v567 in {v41, v44} do
                    v567.Instance.Position = udim2FromOffset(pad + v565, v564)
                    v567.Instance.Size = udim2FromOffset(v562 - v565, v12.button)
                    v567.Label.TextSize = ui.Compact and 23 or 26
                end

                parent5.Position = udim2FromOffset(pad, v564)
                parent5.Size = udim2FromOffset(v562, v12.button - 3)
                ui7.TextSize = ui.Compact and 19 or 20
                local v568 = v564 + (v12.button + 8)
                ui8.Position = udim2FromOffset(pad, v568)
                ui8.Size = udim2FromOffset(v562, v12.hint + 2)
                ui8.TextSize = v12.hint
                local v569 = v568 + (((v12.hint + 2) + pad) - 4)
                local v570 = v12.sectionH + v12.sectionGap
                parent4.Position = udim2FromOffset(0, v570)
                parent4.Size = udim2FromOffset(left, v569)
                local v571 = v570 + v569 + v12.blockGap
                v46.Position = udim2FromOffset(0, v571)
                v46.Size = UDim2.new(1, 0, 0, v12.sectionH)
                local v572 = v571 + v12.sectionH + v12.sectionGap
                parent7.Visible = not ui.Compact
                parent8:FindFirstChild("Divider").Visible = not ui.Compact
                local v573 = ui.Compact and {parent8, parent10, parent11} or {parent7, parent8, parent10, parent11}

                for v574, v575 in v573 do
                    v575.Position = udim2FromOffset(0, (v574 - 1) * v12.rowH)
                    v575.Size = udim2FromOffset(left, v12.rowH)
                end

                local v576 = {{parent8, v69, v70, v71}, {parent10, v75, v76, v77}, {parent7, v59, parent7:FindFirstChild("Label"), v61}}

                for _, v578 in v576 do
                    local v579
                    local v580 = v578[1]
                    local v581 = v578[2]
                    local v582 = v578[3]
                    local v583 = v578[4]

                    if v580 == parent7 then
                        v579 = 140
                    else
                        v579 = 86
                    end

                    v581.Position = UDim2.new(0, pad + 2, 0.5, 0)
                    v581.TextSize = 22
                    v582.Position = udim2FromOffset(pad + 36, (math.floor(v12.rowH / 2) - v12.label) - 1)
                    v582.Size = udim2FromOffset((v562 - 36) - v579, v12.label + 2)
                    v582.TextSize = v12.label
                    v583.Position = udim2FromOffset(pad + 36, math.floor(v12.rowH / 2) + 2)
                    v583.Size = udim2FromOffset((v562 - 36) - v579, v12.desc + 2)
                    v583.TextSize = v12.desc
                end

                v63.Instance.Position = UDim2.new(1, -pad, 0.5, 0)
                ui9.Position = UDim2.new(1, -pad, 0.5, 0)
                ui9.Size = udim2FromOffset(60, 22)
                ui9.TextSize = v12.label
                v80.Position = UDim2.new(0, pad + 2, 0.5, 0)
                local label = parent11:FindFirstChild("Label")
                label.Position = udim2FromOffset(pad + 36, (math.floor(v12.rowH / 2) - v12.label) - 1)
                label.Size = udim2FromOffset((v562 - 36) - 86, v12.label + 2)
                label.TextSize = v12.label
                v82.Position = udim2FromOffset(pad + 36, math.floor(v12.rowH / 2) + 2)
                v82.Size = udim2FromOffset((v562 - 36) - 86, v12.desc + 2)
                v82.TextSize = v12.desc
                ui10.Position = UDim2.new(1, -pad, 0.5, 0)
                ui10.Size = udim2FromOffset(60, 20)
                ui10.TextSize = v12.label - 2
                parent9.Position = udim2FromOffset(pad - 4, 8)
                parent9.Size = udim2FromOffset(v562 + 8, v12.rowH - 16)
                parent9.TextSize = v12.label
                v78.Instance.Position = UDim2.new(1, -pad, 0.5, 0)
                v83.Instance.Position = UDim2.new(1, -pad, 0.5, 0)
                ui11.Position = UDim2.new(1, -pad, 0.5, 0)
                ui11.Size = udim2FromOffset(60, 22)
                ui11.TextSize = v12.label
                parent6.Position = udim2FromOffset(0, v572)
                parent6.Size = udim2FromOffset(left, #v573 * v12.rowH)
                local label2 = v85.Label

                if ui.Compact then
                    textSize = 17
                else
                    textSize = 18
                end

                label2.TextSize = textSize
                local v586 = (v572 + (#v573 * v12.rowH)) + 12 + v12.leaveH <= v559

                if v586 then
                    parent13, parent13 = v559, parent12
                else
                    parent13 = v572 + (#v573 * v12.rowH) + 2
                    parent13 = parent12
                end

                parent3.CanvasSize = udim2FromOffset(0, parent13)
                parent13.Position = udim2FromOffset((left + v12.gap) - 8, -8)
                local v587 = v558 - left - v12.gap
                parent13.Size = udim2FromOffset(v587 + 8, v559 + 8)
                ui12.Position = udim2FromOffset(left + v12.gap, v559)
                ui12.Size = udim2FromOffset(v587 - 10, 40)
                task.defer(updateFade)
                v232 = v587 - 14
                flooredValue = math.floor((v232 - v12.teamGap) / 2)

                for _, v589 in {{v92, v93}, {v135, v136}, {v139, ui13}} do
                    local v590 = v589[1]
                    local v591 = v589[2]
                    v590.Size = UDim2.new(0, v232, 0, v12.sectionH)
                    v591.Size = udim2FromOffset(math.floor(v232 * 0.62), 18)
                    v591.TextSize = v12.sectionHint
                end

                ui13.TextSize = 15
                local v592 = custom.State() or {}
                local v593 = CustomMatch.TeamSize(modeOf(v592))
                local v594 = v12.teamHead + (v593 * v12.seatH) + ((v593 - 1) * v12.seatGap) + 8

                for _, v596 in v125 do
                    v596.frame.Size = udim2FromOffset(flooredValue, v594)
                    v596.dot.Position = UDim2.new(0, 16, 0, math.floor(v12.teamHead / 2) + 1)
                    v596.dot.Size = udim2FromOffset(10, 10)
                    v596.title.Position = UDim2.new(0, 34, 0, math.floor(v12.teamHead / 2) + 1)
                    v596.title.Size = udim2FromOffset(160, 22)
                    v596.title.TextSize = v12.label
                    v596.count.Position = UDim2.new(1, -16, 0, math.floor(v12.teamHead / 2) + 1)
                    v596.count.Size = udim2FromOffset(80, 22)
                    v596.count.TextSize = v12.label - 1
                end

                for _, v598 in v126 do
                    v598.ring.Position = udim2FromOffset(10, (math.floor(v12.seatH / 2)))
                    v598.ring.Size = udim2FromOffset(v12.head, v12.head)
                    v598.label.Position = udim2FromOffset((10 + v12.head) + 10, (math.floor(v12.seatH / 2)))
                    v598.label.Size = udim2FromOffset(160, 22)
                    v598.label.TextSize = v12.playerName - 1
                end

                local mapCols = v12.mapCols
                local flooredValue2 = math.floor((v232 - ((mapCols - 1) * v12.mapGap)) / mapCols)
                local flooredValue3 = math.floor((flooredValue2 * 9) / 16)
                local ceilingValue = math.ceil(math.max(1, #v156) / mapCols)

                for v603, v604 in v156 do
                    local v605 = (v603 - 1) % mapCols
                    local v606 = (v603 - 1) // mapCols
                    v604.btn.AnchorPoint = Vector2.new(0.5, 0.5)
                    v604.btn.Position = udim2FromOffset((v605 * (flooredValue2 + v12.mapGap)) + math.floor(flooredValue2 / 2), v606 * (flooredValue3 + v12.mapGap) + math.floor(flooredValue3 / 2))
                    v604.btn.Size = udim2FromOffset(flooredValue2, flooredValue3)
                    v604.name.TextSize = v12.mapName
                end

                parent14.Size = udim2FromOffset(v232, ceilingValue * flooredValue3 + ((ceilingValue - 1) * v12.mapGap))

                if v586 then
                    v85.Instance.Parent = parent3
                    v85.Instance.AnchorPoint = Vector2.new(0, 1)
                    v85.Instance.Position = UDim2.new(0, 0, 1, 0)
                    v85.Instance.Size = udim2FromOffset(left, v12.leaveH)
                else
                    v85.Instance.Parent = parent13
                    v85.Instance.AnchorPoint = Vector2.new(0, 0)
                    v85.Instance.Size = udim2FromOffset(v232, v12.leaveH)
                end

                v359 = not v586
                v22.Refit()
            end

            do
                local function relayout()
                    --[[
                      name: relayout
                      line: 1893
                      upvalues:
                        v22 (copy, index: 1)
                        paint (copy, index: 2)
                        layout (copy, index: 3)
                    ]]
                    if not v22.IsOpen then
                        return
                    end

                    paint(true)
                    layout()
                    paint(true)
                end

                ui.LayoutChanged:Connect(relayout)
                ui.ScaleChanged:Connect(relayout)
            end

            custom.Changed:Connect(
                function()
                    --[[
                      line: 1904
                      upvalues:
                        v22 (copy, index: 1)
                        isBusy2 (ref,  index: 2)
                        custom (copy, index: 3)
                        parent9 (copy, index: 4)
                        v488 (ref,  index: 5)
                        findPlayer (copy, index: 6)
                        v487 (ref,  index: 7)
                        v156 (copy, index: 8)
                        paint (copy, index: 9)
                        layout (copy, index: 10)
                    ]]
                    if not v22.IsOpen then
                        return
                    end

                    if isBusy2 and not custom.IsHost() then
                        parent9:ReleaseFocus()
                    end

                    if v488 ~= 0 and (not custom.IsHost() or not findPlayer(v488)) then
                        v488 = 0

                        if v487 then
                            v487.layer.Visible = false
                        end
                    end

                    local length = #v156
                    paint()

                    if #v156 ~= length then
                        layout()
                        paint(true)
                    end
                end
            )

            a11.MenuManager.Register(
                "CustomHost",
                {
                    open = (function()
                        --[[
                          name: open
                          line: 1923
                          upvalues:
                            a11 (copy, index: 1)
                            v143 (copy, index: 2)
                            v228 (copy, index: 3)
                            v460 (ref,  index: 4)
                            v459 (ref,  index: 5)
                            v488 (ref,  index: 6)
                            v487 (ref,  index: 7)
                            isBusy2 (ref,  index: 8)
                            parent9 (copy, index: 9)
                            v71 (copy, index: 10)
                            v70 (copy, index: 11)
                            ui10 (copy, index: 12)
                            v69 (copy, index: 13)
                            paint (copy, index: 14)
                            layout (copy, index: 15)
                            parent12 (copy, index: 16)
                            v22 (copy, index: 17)
                            ui (copy, index: 18)
                            parent3 (copy, index: 19)
                            guiService (copy, index: 20)
                            v41 (copy, index: 21)
                            v44 (copy, index: 22)
                            custom (copy, index: 23)
                        ]]
                        a11.SetHudHidden("CustomHost", true)
                        table.clear(v143)
                        table.clear(v228)
                        v460 = nil

                        if v459 then
                            v459.layer.Visible = false
                        end

                        v488 = 0

                        if v487 then
                            v487.layer.Visible = false
                        end

                        if isBusy2 then
                            isBusy2 = false
                            parent9.Visible = false
                            v71.Visible = true
                            v70.Visible = true
                            ui10.Visible = true
                            v69.Visible = true
                        end

                        paint(true)
                        layout()
                        paint(true)
                        parent12.CanvasPosition = Vector2.zero
                        v22:Open()
                        ui.SlideIn(parent3, Vector2.new(-18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())

                        if ui.Gamepad then
                            local v609

                            if v41.Instance.Visible then
                                v609 = v41.Instance
                            else
                                v609 = if v44.Instance.Visible then v44.Instance else v22.CloseButton
                            end

                            guiService.SelectedObject = v609
                        end

                        task.spawn(
                            function()
                                --[[
                                  line: 1944
                                  upvalues:
                                    custom (copy, index: 1)
                                ]]
                                custom.Host("Get")
                            end
                        )
                    end),
                    close = (function(a610)
                        --[[
                          name: close
                          line: 1948
                          upvalues:
                            a11 (copy, index: 1)
                            v460 (ref,  index: 2)
                            v459 (ref,  index: 3)
                            v488 (ref,  index: 4)
                            v487 (ref,  index: 5)
                            isBusy2 (ref,  index: 6)
                            parent9 (copy, index: 7)
                            ui2 (copy, index: 8)
                            v441 (ref,  index: 9)
                            copying (ref,  index: 10)
                            ui3 (copy, index: 11)
                            v30 (copy, index: 12)
                            icon (copy, index: 13)
                            custom (copy, index: 14)
                            guiService (copy, index: 15)
                            v22 (copy, index: 16)
                        ]]
                        a11.SetHudHidden("CustomHost", false)
                        v460 = nil

                        if v459 then
                            v459.layer.Visible = false
                        end

                        v488 = 0

                        if v487 then
                            v487.layer.Visible = false
                        end

                        if isBusy2 then
                            parent9:ReleaseFocus()
                        end

                        if ui2:IsFocused() then
                            ui2:ReleaseFocus()
                        end

                        v441 = 0
                        copying = false
                        local timestamp = os.clock()

                        if v441 <= timestamp then
                            ui3.Visible = false
                            v30:SetText("COPY")
                            icon.Text = "two-stacked-squares"
                        end

                        custom.Hide()
                        local selectedObject = guiService.SelectedObject

                        if selectedObject and selectedObject:IsDescendantOf(v22.Root) then
                            guiService.SelectedObject = nil
                        end

                        v22:Close(a610)
                    end)
                }
            )
        end

        a11.Debug.customHost = function(a613, a614)
            --[[
              line: 1975
              upvalues:
                seat (copy, index: 1)
                v125 (copy, index: 2)
                v94 (ref,  index: 3)
                v189 (ref,  index: 4)
                v487 (ref,  index: 5)
                v488 (ref,  index: 6)
                a11 (copy, index: 7)
                v158 (ref,  index: 8)
                host (copy, index: 9)
                v62 (ref,  index: 10)
                v41 (copy, index: 11)
                v44 (copy, index: 12)
                v182 (copy, index: 13)
                v480 (ref,  index: 14)
                v85 (copy, index: 15)
                v459 (ref,  index: 16)
                v460 (ref,  index: 17)
                isBusy2 (ref,  index: 18)
                parent9 (copy, index: 19)
                custom (copy, index: 20)
                CustomMatch (copy, index: 21)
                localPlayer (copy, index: 22)
                v71 (copy, index: 23)
                v70 (copy, index: 24)
                ui10 (copy, index: 25)
                v69 (copy, index: 26)
                copyCode (copy, index: 27)
                v156 (copy, index: 28)
                v22 (copy, index: 29)
                ui8 (copy, index: 30)
                v63 (copy, index: 31)
                ui9 (copy, index: 32)
                modeOf (copy, index: 33)
                ui2 (copy, index: 34)
                v26 (copy, index: 35)
                parent2 (copy, index: 36)
                copying (ref,  index: 37)
                ui3 (copy, index: 38)
                v30 (copy, index: 39)
                parent5 (copy, index: 40)
                v234 (ref,  index: 41)
                v235 (copy, index: 42)
                ui6 (copy, index: 43)
            ]]
            local players
            local moreShown

            local function joinSeat(a618: number?)
                --[[
                  name: joinSeat
                  line: 1976
                  upvalues:
                    seat (copy, index: 1)
                    v125 (copy, index: 2)
                ]]
                if a618 == 0 then
                    if seat.btn.Visible and seat.join then
                        return seat
                    end

                    return nil
                end

                local v619 = v125[a618] or {seats = {}}

                for _, seat2 in v619.seats do
                    if seat2.btn.Visible and seat2.join then
                        return seat2
                    end
                end

                return nil
            end

            if a613 == "join" then
                local v622 = joinSeat((tonumber(a614) or 0))
                if not v622 then
                    return "no JOIN seat there"
                end

                v94(v622.team)
            elseif a613 == "more" then
                v189((tonumber(a614) or 0))
            elseif a613 == "movePick" then
                local v623 = a614 == 0 and 3 or tonumber(a614) or 0
                local pick = v487 and v487.picks[v623]

                if not pick or not pick.Enabled then
                    return "that pick is off"
                end

                pick.Activated:Fire()
            elseif a613 == "moveRemove" then
                if v487 then
                    v487.remove.Activated:Fire()
                end
            elseif a613 == "moveCancel" then
                v488 = 0

                if v487 then
                    v487.layer.Visible = false
                end
            elseif a613 == "open" then
                a11.MenuManager.Open("CustomHost")
            elseif a613 == "map" then
                v158((tostring((a614 or ""))))
            elseif a613 == "public" then
                task.spawn(host, "SetPublic", a614 ~= false, "public", a614 ~= false)
            elseif a613 == "bots" then
                task.spawn(host, "SetBots", a614 == true, "bots", a614 == true)
            elseif a613 == "mode" then
                v62((tostring((a614 or ""))))
            elseif a613 == "start" then
                v41.Activated:Fire()
            elseif a613 == "end" then
                v44.Activated:Fire()
            elseif a613 == "kick" then
                local text
                local v626 = v182[tonumber(a614) or 0]
                local v627 = v480
                local number = tonumber(a614) or 0

                if v626 then
                    text = v626.name.Text
                else
                    text = "Player"
                end

                v627(number, text)
            elseif a613 == "leave" then
                v85.Activated:Fire()
            elseif a613 == "confirmYes" then
                if v459 then
                    v459.yes.Activated:Fire()
                end
            elseif a613 == "confirmNo" then
                v460 = nil

                if v459 then
                    v459.layer.Visible = false
                end
            elseif a613 == "edit" then
                if not isBusy2 then
                    isBusy2 = true
                    local v629 = custom.State() or {}
                    parent9.Text = tostring((v629.name or ""))
                    parent9.PlaceholderText = CustomMatch.DefaultName(localPlayer.DisplayName)
                    parent9.Visible = true
                    v71.Visible = false
                    v70.Visible = false
                    ui10.Visible = false
                    v69.Visible = false
                    parent9:CaptureFocus()
                end
            elseif a613 == "name" then
                if not isBusy2 then
                    isBusy2 = true
                    local v630 = custom.State() or {}
                    parent9.Text = tostring((v630.name or ""))
                    parent9.PlaceholderText = CustomMatch.DefaultName(localPlayer.DisplayName)
                    parent9.Visible = true
                    v71.Visible = false
                    v70.Visible = false
                    ui10.Visible = false
                    v69.Visible = false
                    parent9:CaptureFocus()
                end

                parent9.Text = tostring((a614 or ""))
                parent9:ReleaseFocus()
            elseif a613 == "copy" then
                copyCode()
            elseif a613 == "reveal" then
                if a614 ~= false then
                    custom.Reveal()
                else
                    custom.Hide()
                end
            elseif a613 == "hoverMap" then
                for _, v632 in v156 do
                    if v632.id == tostring((a614 or "")) then
                        v632.scaleObj.Scale = 1.03
                        v632.stroke.Transparency = 0.55
                    end
                end
            end

            local v633 = custom.State() or {}
            local v634 = {open = v22.IsOpen, host = custom.IsHost(), status = v633.status or false, canStart = v633.canStart
                or false, hint = ui8.Text, map = v633.map or false, public = v633.public or false, bots = v633.bots
                or false, mode = v633.mode or false, modeShown = v63.Value, modeValue = if ui9.Visible then ui9.Text else false}
            v634.seats = CustomMatch.TeamSize(modeOf(v633))

            if type(v633.players) ~= "table" then
                players = 0
            else
                players = #v633.players
            end

            v634.players = players
            v634.mapCards = #v156
            v634.confirm = v459 ~= nil and v459.layer.Visible
            v634.code = ui2.Text
            v634.codeShown = if v26.Visible then custom.MASK else ui2.Text
            v634.masked = v26.Visible
            v634.eye = parent2.Visible
            v634.copying = copying
            v634.focused = ui2:IsFocused()
            v634.selection = string.format("%d..%d", ui2.SelectionStart, ui2.CursorPosition)
            v634.copyHint = if ui3.Visible then ui3.Text else false
            v634.copyLabel = v30.Label.Text
            v634.readOnly = parent5.Visible
            v634.size = string.format("%dx%d", v22.Holder.Size.X.Offset, v22.Holder.Size.Y.Offset)
            v634.team = v234 or false
            v634.team1 = v235[1]
            v634.team2 = v235[2]
            v634.random = v235[3]
            local join1 = joinSeat(1) ~= nil
            v634.join1 = join1
            local join2 = joinSeat(2) ~= nil
            v634.join2 = join2
            local v637 = if seat.btn.Visible and seat.join then seat else nil
            v634.joinRandom = v637 ~= nil
            v634.preview = ui6.Text
            v634.move = v487 ~= nil and v487.layer.Visible
            v634.movePicks = v487
                and {v487.picks[1].Enabled, v487.picks[2].Enabled, v487.picks[3].Enabled}
                or false
            local v638 = 0
            moreShown = v638

            for _, v640 in v182 do
                if v640.more.Visible then
                    moreShown += 1
                end
            end

            v634.moreShown = moreShown

            return v634
        end
    end
end

return v7