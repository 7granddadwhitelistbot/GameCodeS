local players = game:GetService("Players")
local guiService = game:GetService("GuiService")
local CustomMatch = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local v4 = {}
local v5 = {W = 1120, H = 660, left = 400, gap = 24, pad = 16, label = true, box = 50, switchRow = 60, rowsGap = 2, button = 58, section = 16, sectionH = 24, sectionGap = 8, cardGap = 22, slotH = 56, joinW = 100, errH = 18, rowH = 88, thumbW = 128, name = 20, sub = 15, rowGap = 8, rowBtn = 108, rowBtnH = 48, text = 18, desc = 15}
local v6 = {W = 1120, H = 660, left = 380, gap = 16, pad = 14, label = false, box = 52, switchRow = 56, rowsGap = 0, button = 56, section = 16, sectionH = 24, sectionGap = 6, cardGap = 14, slotH = 58, joinW = 100, errH = 18, rowH = 84, thumbW = 112, name = 19, sub = 14, rowGap = 8, rowBtn = 112, rowBtnH = 56, text = 18, desc = 14}
local textColor3 = Color3.fromRGB(142, 149, 166)
local backgroundColor3 = Color3.fromRGB(10, 11, 15)

function v4.Init(a9)
    --[[
      name: Init
      line: 42
      upvalues:
        players (copy, index: 1)
        v6 (copy, index: 2)
        v5 (copy, index: 3)
        CustomMatch (copy, index: 4)
        backgroundColor3 (copy, index: 5)
        textColor3 (copy, index: 6)
        guiService (copy, index: 7)
    ]]
    local v10
    local ui = a9.UI
    local theme = a9.Theme
    local state = a9.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local custom = a9.Custom
    local localPlayer = players.LocalPlayer
    local udim2FromOffset = UDim2.fromOffset
    local v19 = if ui.Compact then v6 else v5
    local v20 = ui.Window(
        {
            Name = "CustomMatches",
            Title = "CUSTOM MATCHES",
            HeaderHeight = 80,
            Subtitle = "Your own server: invite friends, pick the map, start when you're ready  ·  " .. CustomMatch.NO_REWARDS,
            Size = udim2FromOffset(v19.W, v19.H),
            Parent = a9.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 57
                  upvalues:
                    a9 (copy, index: 1)
                ]]
                a9.MenuManager.Close("CustomMatches")
            end)
        }
    )
    local content = v20.Content
    ui.SelectionRing(v20.Root)

    local function card(name: string, parent)
        --[[
          name: card
          line: 64
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
        ]]
        return ui.new("Frame", {Name = name, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3, ui.Corner(12), (ui.Stroke(colors.Stroke, 1, 0.92)), Parent = parent})
    end

    local parent = ui.new("ScrollingFrame", {Name = "Left", ScrollBarThickness = 3, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, VerticalScrollBarInset = Enum.ScrollBarInset.None, Parent = content})
    local v26 = ui.SectionTitle("CREATE A MATCH", {Parent = parent})
    local parent2 = card("Create", parent)
    local ui2 = ui.new("TextLabel", {Name = "NameLabel", Text = "SERVER NAME", TextSize = 13, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent2})
    local parent3 = ui.new("Frame", {Name = "NameField", BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, (ui.Corner(10)), Parent = parent2})
    local v30 = ui.Stroke(colors.Stroke, 1, 0.88)
    v30.Parent = parent3
    local ui3 = ui.new("TextBox", {Name = "NameBox", Text = "", ClearTextOnFocus = false, BackgroundTransparency = 1, PlaceholderText = CustomMatch.DefaultName(localPlayer.DisplayName), PlaceholderColor3 = colors.TextMuted, FontFace = fonts.Bold, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = udim2FromOffset(14, 0), Parent = parent3})
    local ui4 = ui.new("TextLabel", {Name = "Counter", TextSize = 14, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = udim2FromOffset(56, 20), Text = "0/" .. CustomMatch.NAME_MAX, FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent3})
    local v33 = CustomMatch.DEFAULT_MODE
    local parent4 = ui.new("Frame", {Name = "ModeRow", Parent = parent2})
    local v35 = ui.Glyph("three-people", 24, colors.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = parent4})
    local ui5 = ui.new("TextLabel", {Name = "Label", Text = "MODE", FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent4})
    local ui6 = ui.new("TextLabel", {Name = "Desc", Text = "", FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent4})
    local v38 = nil

    local function onMode(a40)
        --[[
          name: onMode
          line: 156
          upvalues:
            v33 (ref,  index: 1)
            CustomMatch (copy, index: 2)
            a9 (copy, index: 3)
            v38 (ref,  index: 4)
        ]]
        local pitch
        v33 = CustomMatch.Mode(a40)
        local play = a9.Sounds.Play
        local v43 = {}

        if v33 ~= "1v1" then
            pitch = 0.94
        else
            pitch = 1.08
        end

        v43.pitch = pitch
        play("Click", v43)
        v38()
    end

    local options = {{id = "3v3", text = "3V3"}, {id = "1v1", text = "1V1"}}
    local v45 = ui.Segmented({Name = "Mode", Width = 132, Height = 38, Options = options, Selected = v33, AnchorPoint = Vector2.new(1, 0.5), Parent = parent4, OnSelect = onMode})
    local v46 = ui.Segmented({Name = "ModeCompact", Width = 124, TextSize = 20, Options = options, Selected = v33, Height = v6.button, Parent = parent2, OnSelect = onMode})

    v38 = function(a47)
        --[[
          line: 182
          upvalues:
            v45 (copy, index: 1)
            v33 (ref,  index: 2)
            v46 (copy, index: 3)
            ui6 (copy, index: 4)
            v35 (copy, index: 5)
        ]]
        v45:Set(v33, a47)
        v46:Set(v33, a47)
        ui6.Text = v33 ~= "1v1" and "Three a side" or "One on one"
        v35.Text = v33 ~= "1v1" and "three-people" or "person"
    end

    local parent5 = ui.new("TextButton", {Name = "PublicRow", Text = "", AutoButtonColor = false, Parent = parent2})
    local ui7 = ui.new("Frame", {Name = "Highlight", BackgroundColor3 = colors.White, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), (ui.Corner(10)), Parent = parent5})
    local v50 = ui.Glyph("globe-simplified", 24, colors.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = parent5})
    local ui8 = ui.new("TextLabel", {Name = "Label", Text = "PUBLIC", FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent5})
    local ui9 = ui.new("TextLabel", {Name = "Desc", Text = "", FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent5})
    local v53 = ui.Switch({Width = 58, On = true, AnchorPoint = Vector2.new(1, 0.5), Parent = parent5})
    local public = true
    local v55 = ui.Button({Name = "Create", Text = "CREATE MATCH", Style = "Primary", Icon = ui.Glyph("person-plus", 24, colors.Text), Parent = parent2})
    local v56 = ui.SectionTitle("JOIN WITH A CODE", {Parent = parent})
    local parent6 = card("Join", parent)
    local parent7 = ui.new("TextButton", {Name = "Slots", Text = "", AutoButtonColor = false, Parent = parent6})
    local v59 = {}
    v10 = v19

    for index = 1, CustomMatch.CODE_LEN do
        local ui10 = ui.new("Frame", {Name = "Slot" .. index, BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, (ui.Corner(9)), Parent = parent7})
        local stroke = ui.Stroke(colors.Stroke, 1.5, 0.86)
        stroke.Parent = ui10
        v59[index] = {frame = ui10, stroke = stroke, label = ui.new("TextLabel", {Name = "Char", Text = "", TextSize = 28, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = ui10}), caret = ui.new("Frame", {Name = "Caret", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -9), Size = udim2FromOffset(16, 3), BackgroundColor3 = colors.Accent, Visible = false, (ui.Corner(theme.Radius.Pill)), Parent = ui10})}
    end

    local ui11 = ui.new("TextBox", {Name = "CodeBox", Text = "", PlaceholderText = "", ClearTextOnFocus = false, TextTransparency = 1, BackgroundTransparency = 1, TextSize = 20, ZIndex = 3, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = parent7})
    local v64 = ui.Button({Name = "JoinCode", Text = "JOIN", Style = "Primary", Parent = parent6})
    local ui12 = ui.new("TextLabel", {Name = "Error", Text = "", TextSize = 15, FontFace = fonts.Bold, TextColor3 = theme.Lighten(colors.Danger, 0.15), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent6})

    local function paintHelp()
        --[[
          name: paintHelp
          line: 292
          upvalues:
            ui12 (copy, index: 1)
            textColor3 (copy, index: 2)
        ]]
        if ui12.Text == "" or ui12.Text == "Ask the host for their code" then
            ui12.Text = "Ask the host for their code"
            ui12.TextColor3 = textColor3
        end
    end

    local parent8 = ui.new("Frame", {Name = "Right", Parent = content})
    local v68 = ui.SectionTitle("PUBLIC MATCHES", {Parent = parent8})
    local parent9 = ui.new("Frame", {Name = "Live", AnchorPoint = Vector2.new(1, 0), Size = udim2FromOffset(200, 24), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent8})
    local ui13 = ui.new("Frame", {Name = "Dot", Size = udim2FromOffset(8, 8), BackgroundColor3 = colors.Success, LayoutOrder = 1, (ui.Corner(theme.Radius.Pill)), Parent = parent9})
    local ui14 = ui.new("TextLabel", {Name = "Text", Text = "LIVE", TextSize = 13, LayoutOrder = 2, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 20), Parent = parent9})
    local parent10 = ui.IconButton({Name = "Refresh", LayoutOrder = 3, Size = udim2FromOffset(34, 34), Color = colors.Raised, Parent = parent9})
    local v73 = ui.Glyph("arrow-spin-clockwise", 20, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent10})
    local parent11 = ui.new("ScrollingFrame", {Name = "List", ScrollBarThickness = 5, AutomaticCanvasSize = Enum.AutomaticSize.Y, Selectable = false, ui.List(Enum.FillDirection.Vertical, 8), (ui.Padding(0, 10, 4, 0)), Parent = parent8})
    local ui15 = ui.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, -10, 0, 40), BackgroundColor3 = colors.PanelLo, ZIndex = 4, Visible = false, (ui.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05))), Parent = parent8})

    local function updateFade()
        --[[
          name: updateFade
          line: 352
          upvalues:
            parent11 (copy, index: 1)
            ui15 (copy, index: 2)
        ]]
        ui15.Visible = 2 < (parent11.AbsoluteCanvasSize.Y - (parent11.CanvasPosition.Y + parent11.AbsoluteWindowSize.Y))
    end

    parent11:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
    parent11:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
    parent11:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
    local parent12 = ui.new("Frame", {Name = "Empty", Visible = false, Parent = parent8})
    ui.Glyph("three-people", 52, colors.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = parent12})
    local ui16 = ui.new("TextLabel", {Name = "Title", Text = "No public matches right now", TextSize = 21, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 64), Size = UDim2.new(1, -40, 0, 26), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent12})
    local ui17 = ui.new("TextLabel", {Name = "Sub", Text = "Create one and it shows up here for everyone. Private matches only take a code.", TextWrapped = true, TextSize = 16, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 94), Size = UDim2.new(1, -60, 0, 44), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, Parent = parent12})
    local v80 = ui.Button({Name = "Retry", Text = "TRY AGAIN", TextSize = 18, Style = "Dark", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 150), Size = udim2FromOffset(180, 48), Parent = parent12})
    local v81 = {}
    local v82 = {}
    local v83 = nil

    local function statusLook(status)
        --[[
          name: statusLook
          line: 407
          upvalues:
            colors (copy, index: 1)
            theme (copy, index: 2)
        ]]
        if status == "Match" then
            return "IN MATCH", colors.Warning:Lerp(colors.Panel, 0.78), theme.Lighten(colors.Warning, 0.1)
        end

        return "LOBBY", colors.Success:Lerp(colors.Panel, 0.78), theme.Lighten(colors.Success, 0.1)
    end

    local v86 = nil

    local function makeRow(a88)
        --[[
          name: makeRow
          line: 416
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            parent11 (copy, index: 3)
            fonts (copy, index: 4)
            textColor3 (copy, index: 5)
            udim2FromOffset (copy, index: 6)
            theme (copy, index: 7)
            v86 (ref,  index: 8)
        ]]
        local ui2 = ui.new("Frame", {Name = "Match_" .. a88.code, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3, ui.Corner(12), (ui.Stroke(colors.Stroke, 1, 0.92)), Parent = parent11})
        local ui3 = ui.new("ImageLabel", {Name = "Thumb", ScaleType = Enum.ScaleType.Crop, BackgroundColor3 = colors.Raised, BackgroundTransparency = 0, (ui.Corner(8)), Parent = ui2})
        ui.Gradient(Color3.fromRGB(46, 52, 66), Color3.fromRGB(28, 31, 40), 120).Parent = ui3
        local random = ui.new("TextLabel", {Name = "Random", Text = "?", TextSize = 34, Visible = false, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.TextMuted, Parent = ui3})
        local mode = ui.Pill("3V3", colors.Void, {Name = "Mode", Height = 20, TextSize = 13, PadX = 7, ZIndex = 2, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 5, 1, -5), Parent = ui3})
        local text = mode:FindFirstChild("Text")
        local name = ui.new("TextLabel", {Name = "MatchName", Text = "", FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
        local sub = ui.new("TextLabel", {Name = "Sub", Text = "", FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
        local parent = ui.new("Frame", {Name = "Players", AnchorPoint = Vector2.new(1, 0.5), Size = udim2FromOffset(96, 22), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = ui2})
        local people = ui.Glyph("person", 17, colors.TextDim, {LayoutOrder = 1, Parent = parent})
        local count = ui.new("TextLabel", {Name = "Count", Text = "", TextSize = 18, LayoutOrder = 2, FontFace = fonts.Heavy, TextColor3 = colors.Text, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 22), Parent = parent})
        local ui4 = ui.new("Frame", {Name = "Status", AnchorPoint = Vector2.new(1, 0.5), AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 22), ui.Corner(theme.Radius.Pill), (ui.Padding(0, 9, 0, 9)), Parent = ui2})
        local pillText = ui.new("TextLabel", {Name = "Text", Text = "", TextSize = 13, FontFace = fonts.Heavy, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = ui4})
        local button = ui.Button({Name = "Join", Text = "JOIN", TextSize = 19, Style = "Primary", AnchorPoint = Vector2.new(1, 0.5), Parent = ui2})
        local v102 = {full = false, frame = ui2, thumb = ui3, random = random, name = name, sub = sub, count = count, people = people, pill = ui4, pillText = pillText, mode = mode, modeText = text, button = button, code = a88.code}
        button.Activated:Connect(
            function()
                --[[
                  line: 518
                  upvalues:
                    v86 (ref, index: 1)
                    v102 (ref, index: 2)
                ]]
                v86(v102.code, v102)
            end
        )

        return v102
    end

    local function layoutRow(a104, a105)
        --[[
          name: layoutRow
          line: 524
          upvalues:
            v10 (ref,  index: 1)
            udim2FromOffset (copy, index: 2)
        ]]
        local rowH = v10.rowH
        a104.frame.Size = UDim2.new(1, -4, 0, rowH)
        local thumbW = v10.thumbW
        local flooredValue = math.floor((thumbW * 9) / 16)
        a104.thumb.Position = udim2FromOffset(10, (math.floor((rowH - flooredValue) / 2)))
        a104.thumb.Size = udim2FromOffset(thumbW, flooredValue)
        local v109 = 10 + thumbW + 14
        local v110 = v10.rowBtn + 16 + 96
        a104.name.Position = udim2FromOffset(v109, (math.floor(rowH / 2) - v10.name) - 4)
        a104.name.Size = udim2FromOffset(math.max(80, (a105 - v109) - v110), v10.name + 4)
        a104.name.TextSize = v10.name
        a104.sub.Position = udim2FromOffset(v109, math.floor(rowH / 2) + 3)
        a104.sub.Size = udim2FromOffset(math.max(80, (a105 - v109) - v110), v10.sub + 4)
        a104.sub.TextSize = v10.sub
        a104.button.Instance.Position = UDim2.new(1, -12, 0.5, 0)
        a104.button.Instance.Size = udim2FromOffset(v10.rowBtn, v10.rowBtnH)
        local v111 = -((12 + v10.rowBtn) + 16)
        a104.count.Parent.Position = UDim2.new(1, v111, 0.5, -12)
        a104.pill.Position = UDim2.new(1, v111, 0.5, 14)
    end

    local function paintRow(a113, a114, layoutOrder)
        --[[
          name: paintRow
          line: 547
          upvalues:
            CustomMatch (copy, index: 1)
            colors (copy, index: 2)
            statusLook (copy, index: 3)
            v83 (ref,  index: 4)
        ]]
        local v116
        a113.name.AutoLocalize = false
        a113.name.Text = a114.name

        if type(a114.host) ~= "string" or a114.host == "" then
            v116 = ""
        else
            v116 = "  ·  " .. a114.host
        end

        a113.sub.Text = string.upper((a114.mapName or "Random")) .. v116

        if type(a114.thumb) ~= "string" or a114.thumb == "" then
            a113.thumb.Image = ""
            a113.random.Visible = true
        else
            a113.thumb.Image = a114.thumb
            a113.random.Visible = false
        end

        local v117 = CustomMatch.Mode(a114.mode) == "1v1"
        a113.modeText.Text = CustomMatch.ModeLabel(a114.mode)
        a113.mode.BackgroundColor3 = if v117 then colors.Accent else colors.Void
        a113.mode.BackgroundTransparency = v117 and 0.05 or 0.3
        a113.count.Text = string.format("%d/%d", a114.players, a114.max)
        local text, backgroundColor3, textColor3 = statusLook(a114.status)
        a113.pillText.Text = text
        a113.pillText.TextColor3 = textColor3
        a113.pill.BackgroundColor3 = backgroundColor3
        local players = a114.players
        a113.full = a114.max <= players
        a113.frame.LayoutOrder = layoutOrder

        if v83 == a114.code then
            a113.button:SetText("JOINING...")
            a113.button:SetEnabled(false)

            return
        end

        if a113.full then
            a113.button:SetText("FULL")
            a113.button:SetEnabled(false)

            return
        end

        a113.button:SetText("JOIN")
        local button = a113.button
        button:SetEnabled(v83 == nil)
    end

    local v123 = 600
    local listState = "loading"
    local v125 = {}

    local function clearSkeletons()
        --[[
          name: clearSkeletons
          line: 585
          upvalues:
            v82 (copy, index: 1)
        ]]
        for _, v128 in v82 do
            v128:Destroy()
        end

        table.clear(v82)
    end

    local function showSkeletons()
        --[[
          name: showSkeletons
          line: 591
          upvalues:
            v82 (copy, index: 1)
            ui (copy, index: 2)
            v10 (ref,  index: 3)
            colors (copy, index: 4)
            parent11 (copy, index: 5)
            udim2FromOffset (copy, index: 6)
            theme (copy, index: 7)
        ]]
        for _, v131 in v82 do
            v131:Destroy()
        end

        table.clear(v82)

        for layoutOrder = 1, 3 do
            local parent = ui.new("Frame", {Name = "Skeleton" .. layoutOrder, Size = UDim2.new(1, -4, 0, v10.rowH), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.5, LayoutOrder = layoutOrder, (ui.Corner(12)), Parent = parent11})
            local flooredValue = math.floor((v10.thumbW * 9) / 16)
            ui.new("Frame", {Position = udim2FromOffset(10, (math.floor((v10.rowH - flooredValue) / 2))), Size = udim2FromOffset(v10.thumbW, flooredValue), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.3, (ui.Corner(8)), Parent = parent})
            ui.new("Frame", {Position = udim2FromOffset(v10.thumbW + 24, math.floor(v10.rowH / 2) - 20), Size = udim2FromOffset(200, 14), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.3, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            ui.new("Frame", {Position = udim2FromOffset(v10.thumbW + 24, math.floor(v10.rowH / 2) + 6), Size = udim2FromOffset(130, 10), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.5, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            local v135 = {BackgroundTransparency = 0.72}
            ui.Tween(parent, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, layoutOrder * 0.12), v135)
            table.insert(v82, parent)
        end
    end

    local function renderList(a137, a138: boolean)
        --[[
          name: renderList
          line: 612
          upvalues:
            v125 (ref,  index: 1)
            v82 (copy, index: 2)
            v81 (copy, index: 3)
            makeRow (copy, index: 4)
            layoutRow (copy, index: 5)
            v123 (ref,  index: 6)
            paintRow (copy, index: 7)
            ui (copy, index: 8)
            v68 (copy, index: 9)
            parent12 (copy, index: 10)
            listState (ref,  index: 11)
            ui16 (copy, index: 12)
            ui17 (copy, index: 13)
            v80 (copy, index: 14)
            ui14 (copy, index: 15)
            ui13 (copy, index: 16)
            colors (copy, index: 17)
            updateFade (copy, index: 18)
        ]]
        local v139
        v125 = a137

        for _, v141 in v82 do
            v141:Destroy()
        end

        table.clear(v82)
        local v142 = {}

        for layoutOrder, v144 in a137 do
            if type(v144) == "table" then
                local v145

                if type(v144.code) ~= "string" then
                    continue
                end

                v142[v144.code] = true
                local v146 = v81[v144.code]
                local v147 = false

                if v146 then
                    v145 = v146
                else
                    v145 = makeRow(v144)
                    v81[v144.code] = v145
                    v147 = true
                end

                layoutRow(v145, v123)
                paintRow(v145, v144, layoutOrder)

                if v147 and a138 then
                    ui.Enter(v145.frame, Vector2.new(0, 12), math.min(layoutOrder * 0.035, 0.25), UDim2.new())
                end
            end
        end

        for v148, v149 in v81 do
            if not v142[v148] then
                v149.frame:Destroy()
                v81[v148] = nil
            end
        end

        local v150 = 0
        v139 = v150

        for _ in v81 do
            v139 += 1
        end

        v68.Text.Text = not (0 < v139) and "PUBLIC MATCHES" or string.format("PUBLIC MATCHES  ·  %d", v139)
        parent12.Visible = v139 == 0 and listState ~= "loading"
        ui16.Text = listState ~= "error" and "No public matches right now" or "Couldn't load public matches"
        ui17.Text = listState ~= "error"
            and "Create one and it shows up here for everyone. Private matches only take a code."
            or "Check your connection and try again. Joining with a code still works."
        local instance = v80.Instance
        instance.Visible = listState == "error"
        ui14.Text = listState ~= "error" and "LIVE" or "OFFLINE"
        ui13.BackgroundColor3 = if listState == "error" then colors.TextMuted else colors.Success
        task.defer(updateFade)
    end

    local v153 = false
    local timestamp = 0

    local function refresh(a156: boolean)
        --[[
          name: refresh
          line: 658
          upvalues:
            v153 (ref,  index: 1)
            timestamp (ref,  index: 2)
            v73 (copy, index: 3)
            ui (copy, index: 4)
            custom (copy, index: 5)
            v20 (copy, index: 6)
            listState (ref,  index: 7)
            renderList (copy, index: 8)
            v81 (copy, index: 9)
            v125 (ref,  index: 10)
        ]]
        if not v153 then
            if a156 or not (os.clock() - timestamp < 2) then
                v153 = true
                timestamp = os.clock()
                local _ = os.clock()
                v73.Rotation = 0
                local v158 = {Rotation = 360}
                ui.Tween(v73, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v158)
                local v159, v160 = custom.Action("List")
                v153 = false

                if not v20.IsOpen then
                    return
                end

                if v159 and type(v160) == "table" then
                    if type(v160.list) == "table" then
                        local v161 = listState ~= "ok"
                        listState = "ok"
                        renderList(v160.list, v161)

                        return
                    end
                end

                listState = next(v81) and "ok" or "error"
                renderList(v125, false)
            end
        end
    end

    parent10.Activated:Connect(
        function()
            --[[
              line: 682
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )

    v80.Activated:Connect(
        function()
            --[[
              line: 685
              upvalues:
                listState (ref,  index: 1)
                parent12 (copy, index: 2)
                showSkeletons (copy, index: 3)
                refresh (copy, index: 4)
            ]]
            listState = "loading"
            parent12.Visible = false
            showSkeletons()
            refresh(true)
        end
    )

    local v162 = false
    local count = 0

    local function paintSlots()
        --[[
          name: paintSlots
          line: 695
          upvalues:
            ui11 (copy, index: 1)
            v59 (copy, index: 2)
            v162 (ref,  index: 3)
            CustomMatch (copy, index: 4)
            colors (copy, index: 5)
            v64 (copy, index: 6)
            v83 (ref,  index: 7)
        ]]
        local text = ui11.Text
        local textLength = #text

        for v167, v168 in v59 do
            local v169
            local text2 = string.sub(text, v167, v167)
            v168.label.Text = text2
            local v171 = v162
                and (v167 == textLength + 1 or textLength == CustomMatch.CODE_LEN and v167 == textLength)
            local caret = v168.caret
            caret.Visible = v162 and v167 == textLength + 1
            local stroke = v168.stroke

            if v171 then
                v169 = colors.Accent
            else
                v169 = if text2 ~= "" then colors.Stroke else colors.Stroke
            end

            stroke.Color = v169
            v168.stroke.Transparency = v171 and 0.1 or text2 == "" and 0.86 or 0.7
        end

        local enabled = false

        if textLength == CustomMatch.CODE_LEN then
            enabled = v83 == nil
        end

        v64:SetEnabled(enabled)
    end

    local v175 = false

    ui11:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 709
              upvalues:
                v175 (ref,  index: 1)
                CustomMatch (copy, index: 2)
                ui11 (copy, index: 3)
                ui12 (copy, index: 4)
                textColor3 (copy, index: 5)
                v59 (copy, index: 6)
                ui (copy, index: 7)
                paintSlots (copy, index: 8)
            ]]
            if v175 then
                return
            end

            local text = CustomMatch.CleanCode(ui11.Text)

            if text ~= ui11.Text then
                v175 = true
                ui11.Text = text
                ui11.CursorPosition = #text + 1
                v175 = false
            end

            if ui12.Text ~= "Ask the host for their code" then
                ui12.Text = ""

                if ui12.Text == "" or ui12.Text == "Ask the host for their code" then
                    ui12.Text = "Ask the host for their code"
                    ui12.TextColor3 = textColor3
                end
            end

            local textLength = #text
            local v178 = v59[textLength]

            if v178 and 0 < textLength then
                ui.Bump(v178.label, 0.18)
            end

            paintSlots()
        end
    )

    ui11.Focused:Connect(
        function()
            --[[
              line: 731
              upvalues:
                v162 (ref,  index: 1)
                paintSlots (copy, index: 2)
            ]]
            v162 = true
            paintSlots()
        end
    )

    ui11.FocusLost:Connect(
        function(a179)
            --[[
              line: 735
              upvalues:
                v162 (ref,  index: 1)
                paintSlots (copy, index: 2)
                ui11 (copy, index: 3)
                CustomMatch (copy, index: 4)
                v86 (ref,  index: 5)
            ]]
            v162 = false
            paintSlots()

            if a179 and #ui11.Text == CustomMatch.CODE_LEN then
                v86(ui11.Text, nil)
            end
        end
    )

    ui.Every(
        v20.Root,
        0.5,
        function()
            --[[
              line: 743
              upvalues:
                v162 (ref,  index: 1)
                ui11 (copy, index: 2)
                v59 (copy, index: 3)
            ]]
            if v162 then
                if const v180 = v59[#ui11.Text + 1] then
                    v180.caret.BackgroundTransparency = not (v180.caret.BackgroundTransparency < 0.5) and 0 or 1
                end
            end
        end
    )

    local function showCodeError(text: string)
        --[[
          name: showCodeError
          line: 753
          upvalues:
            count (ref,  index: 1)
            ui12 (copy, index: 2)
            theme (copy, index: 3)
            colors (copy, index: 4)
            ui (copy, index: 5)
            parent7 (copy, index: 6)
            a9 (copy, index: 7)
            v59 (copy, index: 8)
            paintSlots (copy, index: 9)
        ]]
        count += 1
        local v183 = count
        ui12.Text = text
        ui12.TextColor3 = theme.Lighten(colors.Danger, 0.15)
        ui.Shake(parent7, 8)
        a9.Sounds.Play("Error")

        for _, v185 in v59 do
            v185.stroke.Color = colors.Danger
            v185.stroke.Transparency = 0.15
        end

        task.delay(
            1.2,
            function()
                --[[
                  line: 764
                  upvalues:
                    v183 (copy, index: 1)
                    count (ref,  index: 2)
                    paintSlots (copy, index: 3)
                ]]
                if v183 == count then
                    paintSlots()
                end
            end
        )
    end

    local creating = false

    local function paintBusy()
        --[[
          name: paintBusy
          line: 773
          upvalues:
            v55 (copy, index: 1)
            creating (ref,  index: 2)
            v83 (ref,  index: 3)
            v64 (copy, index: 4)
            ui11 (copy, index: 5)
            paintSlots (copy, index: 6)
            v81 (copy, index: 7)
            v125 (ref,  index: 8)
            paintRow (copy, index: 9)
        ]]
        local text
        local text2 = creating and "CREATING..." or "CREATE MATCH"
        v55:SetText(text2)
        local enabled = not creating and v83 == nil
        v55:SetEnabled(enabled)

        if v83 == nil or v83 ~= ui11.Text then
            text = "JOIN"
            text2 = v81
        else
            text = "..."
            text2 = v81
        end

        v64:SetText(text)
        paintSlots()

        for v191, v192 in text2 do
            for _, v194 in v125 do
                if v194.code == v191 then
                    paintRow(v192, v194, v192.frame.LayoutOrder)
                end
            end
        end
    end

    v86 = function(a195, a196)
        --[[
          line: 787
          upvalues:
            v83 (ref,  index: 1)
            creating (ref,  index: 2)
            CustomMatch (copy, index: 3)
            showCodeError (copy, index: 4)
            paintBusy (copy, index: 5)
            custom (copy, index: 6)
            a9 (copy, index: 7)
            ui (copy, index: 8)
            refresh (copy, index: 9)
        ]]
        if v83 or creating then
            return
        end

        local v197 = CustomMatch.ValidCode(a195)
        if not v197 then
            showCodeError(string.format("Codes have %d letters and numbers", CustomMatch.CODE_LEN))
            return
        end

        v83 = v197
        paintBusy()
        local v198, v199 = custom.Action("Join", v197)
        v83 = nil
        paintBusy()

        if v198 then
            a9.Sounds.Play("Queue_Join")
            a9.MenuManager.Close("CustomMatches")

            return
        end

        local text = tostring((v199 or "Couldn't join that match"))

        if not a196 then
            showCodeError(text)
            return
        end

        a9.Toast(text, "error")
        ui.Shake(a196.frame, 6)
        refresh(true)
    end

    v64.Activated:Connect(
        function()
            --[[
              line: 815
              upvalues:
                v86 (ref,  index: 1)
                ui11 (copy, index: 2)
            ]]
            v86(ui11.Text, nil)
        end
    )
    parent7.Activated:Connect(
        function()
            --[[
              line: 818
              upvalues:
                ui11 (copy, index: 1)
            ]]
            ui11:CaptureFocus()
        end
    )

    local function create()
        --[[
          name: create
          line: 822
          upvalues:
            creating (ref,  index: 1)
            v83 (ref,  index: 2)
            paintBusy (copy, index: 3)
            custom (copy, index: 4)
            ui3 (copy, index: 5)
            public (ref,  index: 6)
            v33 (ref,  index: 7)
            a9 (copy, index: 8)
            ui (copy, index: 9)
            v55 (copy, index: 10)
            v30 (copy, index: 11)
            colors (copy, index: 12)
        ]]
        if creating or v83 then
            return
        end

        creating = true
        paintBusy()
        local v202, text = custom.Action("Create", {name = ui3.Text, public = public, mode = v33})
        creating = false
        paintBusy()

        if v202 then
            a9.Sounds.Play("Queue_Join")
            a9.MenuManager.Close("CustomMatches")

            return
        end

        a9.Toast(tostring((text or "Couldn't create the match")), "error")
        ui.Shake(v55.Instance, 6)

        if type(text) == "string" and (string.find(text, "name", 1, true) or string.find(text, "Name", 1, true)) then
            v30.Color = colors.Danger
            v30.Transparency = 0.15

            task.delay(
                1.4,
                function()
                    --[[
                      line: 841
                      upvalues:
                        v30 (copy, index: 1)
                        colors (copy, index: 2)
                    ]]
                    v30.Color = colors.Stroke
                    v30.Transparency = 0.88
                end
            )
        end
    end

    v55.Activated:Connect(create)

    local function paintPublic(a205)
        --[[
          name: paintPublic
          line: 849
          upvalues:
            v53 (copy, index: 1)
            public (ref,  index: 2)
            ui8 (copy, index: 3)
            ui9 (copy, index: 4)
            v50 (copy, index: 5)
        ]]
        v53:Set(public, a205)
        ui8.Text = public and "PUBLIC" or "PRIVATE"
        ui9.Text = public and "Anyone in a lobby can find and join it" or "Only people with your code can join"
        v50.Text = public and "globe-simplified" or "lock-closed"
    end

    parent5.Activated:Connect(
        function()
            --[[
              line: 855
              upvalues:
                public (ref,  index: 1)
                a9 (copy, index: 2)
                v53 (copy, index: 3)
                ui8 (copy, index: 4)
                ui9 (copy, index: 5)
                v50 (copy, index: 6)
            ]]
            local pitch
            public = not public
            local play = a9.Sounds.Play
            local v208 = {}

            if public then
                pitch = 1.08
            else
                pitch = 0.94
            end

            v208.pitch = pitch
            play("Click", v208)
            v53:Set(public, nil)
            ui8.Text = public and "PUBLIC" or "PRIVATE"
            ui9.Text = public and "Anyone in a lobby can find and join it" or "Only people with your code can join"
            v50.Text = public and "globe-simplified" or "lock-closed"
        end
    )

    parent5.MouseEnter:Connect(
        function()
            --[[
              line: 860
              upvalues:
                ui (copy, index: 1)
                ui7 (copy, index: 2)
                theme (copy, index: 3)
            ]]
            if not ui.Touch then
                ui.Tween(ui7, theme.Tween.Fast, {BackgroundTransparency = 0.955})
            end
        end
    )

    parent5.MouseLeave:Connect(
        function()
            --[[
              line: 865
              upvalues:
                ui (copy, index: 1)
                ui7 (copy, index: 2)
                theme (copy, index: 3)
            ]]
            ui.Tween(ui7, theme.Tween.Fast, {BackgroundTransparency = 1})
        end
    )

    local function capName()
        --[[
          name: capName
          line: 869
          upvalues:
            ui3 (copy, index: 1)
            CustomMatch (copy, index: 2)
            ui4 (copy, index: 3)
            colors (copy, index: 4)
        ]]
        local text = ui3.Text
        local v211 = utf8.len(text) or #text

        if CustomMatch.NAME_MAX < v211 then
            local v212 = utf8.offset(text, CustomMatch.NAME_MAX + 1) or #text + 1
            ui3.Text = string.sub(text, 1, v212 - 1)

            return
        end

        ui4.Text = string.format("%d/%d", v211, CustomMatch.NAME_MAX)
        ui4.TextColor3 = if CustomMatch.NAME_MAX <= v211 then colors.Warning else colors.TextMuted
    end

    ui3:GetPropertyChangedSignal("Text"):Connect(capName)
    ui3.Focused:Connect(
        function()
            --[[
              line: 881
              upvalues:
                ui (copy, index: 1)
                v30 (copy, index: 2)
                theme (copy, index: 3)
                colors (copy, index: 4)
            ]]
            ui.Tween(v30, theme.Tween.Fast, {Transparency = 0.2, Color = colors.Accent})
        end
    )

    ui3.FocusLost:Connect(
        function(a213)
            --[[
              line: 884
              upvalues:
                ui (copy, index: 1)
                v30 (copy, index: 2)
                theme (copy, index: 3)
                colors (copy, index: 4)
                create (copy, index: 5)
            ]]
            ui.Tween(v30, theme.Tween.Fast, {Transparency = 0.88, Color = colors.Stroke})

            if a213 then
                create()
            end
        end
    )

    local function layout()
        --[[
          name: layout
          line: 892
          upvalues:
            v10 (ref,  index: 1)
            ui (copy, index: 2)
            v6 (copy, index: 3)
            v5 (copy, index: 4)
            v20 (copy, index: 5)
            udim2FromOffset (copy, index: 6)
            parent (copy, index: 7)
            parent8 (copy, index: 8)
            v26 (copy, index: 9)
            ui2 (copy, index: 10)
            parent3 (copy, index: 11)
            ui3 (copy, index: 12)
            parent4 (copy, index: 13)
            v46 (copy, index: 14)
            v35 (copy, index: 15)
            ui5 (copy, index: 16)
            ui6 (copy, index: 17)
            v45 (copy, index: 18)
            parent5 (copy, index: 19)
            v50 (copy, index: 20)
            ui8 (copy, index: 21)
            ui9 (copy, index: 22)
            v53 (copy, index: 23)
            v55 (copy, index: 24)
            parent2 (copy, index: 25)
            v56 (copy, index: 26)
            CustomMatch (copy, index: 27)
            parent7 (copy, index: 28)
            v59 (copy, index: 29)
            v64 (copy, index: 30)
            ui12 (copy, index: 31)
            parent6 (copy, index: 32)
            v68 (copy, index: 33)
            parent9 (copy, index: 34)
            parent11 (copy, index: 35)
            v123 (ref,  index: 36)
            v81 (copy, index: 37)
            layoutRow (copy, index: 38)
            v82 (copy, index: 39)
            parent12 (copy, index: 40)
        ]]
        local textSize
        local textSize2
        v10 = if ui.Compact then v6 else v5
        local v217 = ui.CanvasSize()
        local v218 = ui.TopInset()

        if ui.Compact then
            v20.Holder.Size = udim2FromOffset(math.floor((math.min(v10.W, v217.X - 24))), (math.floor((math.min(v10.H, (v217.Y - v218) - 12)))))
        else
            v20.Holder.Size = udim2FromOffset(math.floor((math.clamp(v217.X - 240, v10.W, 1240))), (math.floor((math.clamp((v217.Y - v218) - 110, 620, 680)))))
        end

        local subtitle = v20.Subtitle

        if ui.Compact then
            textSize = 15
            textSize = parent
        else
            textSize = 17
            textSize = parent
        end

        subtitle.TextSize = textSize
        local v220 = v20.Holder.Size.X.Offset - 44
        local v221 = v20.Holder.Size.Y.Offset - 80 - 32
        local left = v10.left
        textSize.Size = udim2FromOffset(left, v221)
        parent8.Position = udim2FromOffset(left + v10.gap, 0)
        local v223 = v220 - left - v10.gap
        parent8.Size = udim2FromOffset(v223, v221)
        local pad = v10.pad
        local v225 = left - pad * 2
        v26.Size = UDim2.new(1, 0, 0, v10.sectionH)
        v26.Position = udim2FromOffset(0, 0)
        local v226 = pad
        ui2.Visible = v10.label

        if v10.label then
            ui2.Position = udim2FromOffset(pad + 2, v226)
            ui2.Size = udim2FromOffset(v225, 16)
            v226 += 22
            v226 = parent4
        else
            v226 = parent4
        end

        parent3.Position = udim2FromOffset(pad, v226)
        parent3.Size = udim2FromOffset(v225, v10.box)
        ui3.Size = UDim2.new(1, -84, 1, 0)
        ui3.TextSize = v10.text
        local v227 = v226 + (v10.box + 10)
        v226.Visible = not ui.Compact
        v46.Instance.Visible = ui.Compact

        if not ui.Compact then
            v226.Position = udim2FromOffset(pad - 6, v227)
            v226.Size = udim2FromOffset(v225 + 12, v10.switchRow)
            v35.Position = UDim2.new(0, 8, 0.5, 0)
            ui5.Position = udim2FromOffset(42, (math.floor(v10.switchRow / 2) - v10.text) - 1)
            ui5.Size = udim2FromOffset(v225 - 180, v10.text + 2)
            ui5.TextSize = v10.text
            ui6.Position = udim2FromOffset(42, math.floor(v10.switchRow / 2) + 2)
            ui6.Size = udim2FromOffset(v225 - 180, v10.desc + 2)
            ui6.TextSize = v10.desc
            v45.Instance.Position = UDim2.new(1, -8, 0.5, 0)
            v227 += v10.switchRow + v10.rowsGap
        end

        parent5.Position = udim2FromOffset(pad - 6, v227)
        parent5.Size = udim2FromOffset(v225 + 12, v10.switchRow)
        v50.Position = UDim2.new(0, 8, 0.5, 0)
        ui8.Position = udim2FromOffset(42, (math.floor(v10.switchRow / 2) - v10.text) - 1)
        ui8.Size = udim2FromOffset(v225 - 110, v10.text + 2)
        ui8.TextSize = v10.text
        ui9.Position = udim2FromOffset(42, math.floor(v10.switchRow / 2) + 2)
        ui9.Size = udim2FromOffset(v225 - 110, v10.desc + 2)
        ui9.TextSize = v10.desc
        v53.Instance.Position = UDim2.new(1, -8, 0.5, 0)
        local v228 = v227 + (v10.switchRow + 10)

        if ui.Compact then
            local offset = v46.Instance.Size.X.Offset
            v46.Instance.Position = udim2FromOffset(pad, v228)
            v55.Instance.Position = udim2FromOffset((pad + offset) + 8, v228)
            v55.Instance.Size = udim2FromOffset((v225 - offset) - 8, v10.button)
        else
            v55.Instance.Position = udim2FromOffset(pad, v228)
            v55.Instance.Size = udim2FromOffset(v225, v10.button)
        end

        local label = v55.Label

        if ui.Compact then
            textSize2 = 22
            textSize2 = parent2
        else
            textSize2 = 24
            textSize2 = parent2
        end

        label.TextSize = textSize2
        local v231 = v228 + (v10.button + pad)
        local v232 = v10.sectionH + v10.sectionGap
        textSize2.Position = udim2FromOffset(0, v232)
        textSize2.Size = udim2FromOffset(left, v231)
        local v233 = v232 + v231 + v10.cardGap
        v56.Position = udim2FromOffset(0, v233)
        v56.Size = UDim2.new(1, 0, 0, v10.sectionH)
        local v234 = v233 + v10.sectionH + v10.sectionGap
        local v235 = v225 - v10.joinW - 12
        local v236 = CustomMatch.CODE_LEN // 2
        local flooredValue = math.floor(((v235 - (5 * (CustomMatch.CODE_LEN - 2))) - 14) / CustomMatch.CODE_LEN)
        parent7.Position = udim2FromOffset(pad, pad)
        parent7.Size = udim2FromOffset((flooredValue * CustomMatch.CODE_LEN + (5 * (CustomMatch.CODE_LEN - 2))) + 14, v10.slotH)

        for v238, v239 in v59 do
            local v240 = (v238 - 1) * (flooredValue + 5)
            local v241 = not (v236 < v238) and 0 or 9
            local v242 = v240 + v241
            v239.frame.Position = udim2FromOffset(v242, 0)
            v239.frame.Size = udim2FromOffset(flooredValue, v10.slotH)
            v239.label.TextSize = ui.Compact and 26 or 28
        end

        v64.Instance.Position = UDim2.new(1, -pad, 0, pad)
        v64.Instance.AnchorPoint = Vector2.new(1, 0)
        v64.Instance.Size = udim2FromOffset(v10.joinW, v10.slotH)
        v64.Label.TextSize = 20
        ui12.Position = udim2FromOffset(pad + 2, (pad + v10.slotH) + 7)
        ui12.Size = udim2FromOffset(v225, v10.errH)
        parent6.Position = udim2FromOffset(0, v234)
        parent6.Size = udim2FromOffset(left, ((pad + v10.slotH) + 7 + v10.errH) + 10)
        textSize.CanvasSize = udim2FromOffset(0, (v234 + parent6.Size.Y.Offset) + 2)
        v68.Size = UDim2.new(1, -210, 0, v10.sectionH)
        local newUDim2 = UDim2.new
        local v244 = ui.Compact and 0 or -5
        parent9.Position = newUDim2(1, -4, 0, v244)
        parent11.Position = udim2FromOffset(0, v10.sectionH + v10.sectionGap)
        parent11.Size = UDim2.new(1, 0, 1, -(v10.sectionH + v10.sectionGap))
        parent11:FindFirstChildOfClass("UIListLayout").Padding = UDim.new(0, v10.rowGap)
        v123 = v223 - 14

        for _, v246 in v81 do
            layoutRow(v246, v123)
        end

        for _, v248 in v82 do
            v248.Size = UDim2.new(1, -4, 0, v10.rowH)
        end

        parent12.Position = udim2FromOffset(0, v10.sectionH + v10.sectionGap + math.max(24, (math.floor(v221 * 0.18))))
        parent12.Size = UDim2.new(1, 0, 0, 220)
        v20.Refit()
    end

    ui.LayoutChanged:Connect(
        function()
            --[[
              line: 1014
              upvalues:
                v20 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if v20.IsOpen then
                layout()
            end
        end
    )

    ui.ScaleChanged:Connect(
        function()
            --[[
              line: 1019
              upvalues:
                v20 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if v20.IsOpen then
                layout()
            end
        end
    )

    ui.Every(
        v20.Root,
        0.9,
        function()
            --[[
              line: 1026
              upvalues:
                v20 (copy, index: 1)
                ui (copy, index: 2)
                ui13 (copy, index: 3)
            ]]
            if v20.IsOpen then
                local backgroundTransparency
                local tween = ui.Tween
                local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Sine)
                local v252 = {}

                if not (ui13.BackgroundTransparency < 0.3) then
                    backgroundTransparency = 0
                else
                    backgroundTransparency = 0.6
                end

                v252.BackgroundTransparency = backgroundTransparency
                tween(ui13, tweenInfo, v252)
            end
        end
    )

    local count2 = 0

    local function startLoop()
        --[[
          name: startLoop
          line: 1034
          upvalues:
            count2 (ref,  index: 1)
            v20 (copy, index: 2)
            refresh (copy, index: 3)
            CustomMatch (copy, index: 4)
        ]]
        count2 += 1
        local v255 = count2

        task.spawn(
            function()
                --[[
                  line: 1037
                  upvalues:
                    v255 (copy, index: 1)
                    count2 (ref,  index: 2)
                    v20 (copy, index: 3)
                    refresh (copy, index: 4)
                    CustomMatch (copy, index: 5)
                ]]
                while v255 == count2 and v20.IsOpen do
                    refresh(false)
                    task.wait(CustomMatch.LIST_REFRESH)
                end
            end
        )
    end

    a9.MenuManager.Register(
        "CustomMatches",
        {
            open = (function()
                --[[
                  name: open
                  line: 1046
                  upvalues:
                    a9 (copy, index: 1)
                    layout (copy, index: 2)
                    ui3 (copy, index: 3)
                    CustomMatch (copy, index: 4)
                    localPlayer (copy, index: 5)
                    ui12 (copy, index: 6)
                    textColor3 (copy, index: 7)
                    v38 (ref,  index: 8)
                    v53 (copy, index: 9)
                    public (ref,  index: 10)
                    ui8 (copy, index: 11)
                    ui9 (copy, index: 12)
                    v50 (copy, index: 13)
                    capName (copy, index: 14)
                    paintBusy (copy, index: 15)
                    listState (ref,  index: 16)
                    parent12 (copy, index: 17)
                    showSkeletons (copy, index: 18)
                    v20 (copy, index: 19)
                    parent11 (copy, index: 20)
                    ui (copy, index: 21)
                    parent (copy, index: 22)
                    parent8 (copy, index: 23)
                    udim2FromOffset (copy, index: 24)
                    v10 (ref,  index: 25)
                    count2 (ref,  index: 26)
                    refresh (copy, index: 27)
                    guiService (copy, index: 28)
                    v55 (copy, index: 29)
                ]]
                a9.SetHudHidden("CustomMatches", true)
                layout()
                ui3.PlaceholderText = CustomMatch.DefaultName(localPlayer.DisplayName)
                ui12.Text = ""

                if ui12.Text == "" or ui12.Text == "Ask the host for their code" then
                    ui12.Text = "Ask the host for their code"
                    ui12.TextColor3 = textColor3
                end

                v38(true)
                v53:Set(public, true)
                ui8.Text = public and "PUBLIC" or "PRIVATE"
                ui9.Text = public and "Anyone in a lobby can find and join it" or "Only people with your code can join"
                v50.Text = public and "globe-simplified" or "lock-closed"
                capName()
                paintBusy()

                if listState ~= "ok" then
                    listState = "loading"
                    parent12.Visible = false
                    showSkeletons()
                end

                v20:Open()
                parent11.CanvasPosition = Vector2.zero
                ui.SlideIn(parent, Vector2.new(-18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
                ui.SlideIn(parent8, Vector2.new(18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), udim2FromOffset(v10.left + v10.gap, 0))
                count2 += 1
                local v256 = count2

                task.spawn(
                    function()
                        --[[
                          line: 1037
                          upvalues:
                            v256 (copy, index: 1)
                            count2 (ref,  index: 2)
                            v20 (copy, index: 3)
                            refresh (copy, index: 4)
                            CustomMatch (copy, index: 5)
                        ]]
                        while v256 == count2 and v20.IsOpen do
                            refresh(false)
                            task.wait(CustomMatch.LIST_REFRESH)
                        end
                    end
                )

                if ui.Gamepad then
                    guiService.SelectedObject = v55.Instance
                end
            end),
            close = (function(a257)
                --[[
                  name: close
                  line: 1072
                  upvalues:
                    a9 (copy, index: 1)
                    count2 (ref,  index: 2)
                    v162 (ref,  index: 3)
                    ui11 (copy, index: 4)
                    ui3 (copy, index: 5)
                    guiService (copy, index: 6)
                    v20 (copy, index: 7)
                ]]
                a9.SetHudHidden("CustomMatches", false)
                count2 += 1

                if v162 then
                    ui11:ReleaseFocus()
                end

                ui3:ReleaseFocus()
                local selectedObject = guiService.SelectedObject

                if selectedObject and selectedObject:IsDescendantOf(v20.Root) then
                    guiService.SelectedObject = nil
                end

                v20:Close(a257)
            end)
        }
    )

    state.PlayerStateChanged:Connect(
        function(a259)
            --[[
              line: 1086
              upvalues:
                a9 (copy, index: 1)
            ]]
            if a259 == "Match" and a9.MenuManager.IsOpen("CustomMatches") then
                a9.MenuManager.Close("CustomMatches", true)
            end
        end
    )

    a9.Debug.customMatches = function(a260, a261)
        --[[
          line: 1097
          upvalues:
            a9 (copy, index: 1)
            count2 (ref,  index: 2)
            listState (ref,  index: 3)
            renderList (copy, index: 4)
            v81 (copy, index: 5)
            parent12 (copy, index: 6)
            showSkeletons (copy, index: 7)
            ui11 (copy, index: 8)
            showCodeError (copy, index: 9)
            public (ref,  index: 10)
            v53 (copy, index: 11)
            ui8 (copy, index: 12)
            ui9 (copy, index: 13)
            v50 (copy, index: 14)
            v33 (ref,  index: 15)
            CustomMatch (copy, index: 16)
            v38 (ref,  index: 17)
            ui3 (copy, index: 18)
            create (copy, index: 19)
            v86 (ref,  index: 20)
            refresh (copy, index: 21)
            v20 (copy, index: 22)
            ui12 (copy, index: 23)
            creating (ref,  index: 24)
            v83 (ref,  index: 25)
        ]]
        if a260 == "open" then
            a9.MenuManager.Open("CustomMatches")
        elseif a260 == "list" and type(a261) == "table" then
            count2 += 1
            listState = "ok"
            renderList(a261, true)
        elseif a260 == "error" then
            count2 += 1

            for v262, v263 in v81 do
                v263.frame:Destroy()
                v81[v262] = nil
            end

            listState = "error"
            renderList({}, false)
        elseif a260 == "loading" then
            count2 += 1

            for v264, v265 in v81 do
                v265.frame:Destroy()
                v81[v264] = nil
            end

            listState = "loading"
            parent12.Visible = false
            showSkeletons()
        elseif a260 == "code" then
            ui11.Text = tostring((a261 or ""))
        elseif a260 == "codeError" then
            showCodeError((tostring((a261 or "No custom match has that code"))))
        elseif a260 == "focusCode" then
            ui11:CaptureFocus()
        elseif a260 == "public" then
            local text
            public = a261 ~= false
            v53:Set(public, nil)

            if public then
                text = "PUBLIC"
            else
                text = "PRIVATE"
            end

            ui8.Text = text
            ui9.Text = public and "Anyone in a lobby can find and join it" or "Only people with your code can join"
            v50.Text = public and "globe-simplified" or "lock-closed"
        elseif a260 == "mode" then
            v33 = CustomMatch.Mode(a261)
            v38()
        elseif a260 == "name" then
            ui3.Text = tostring((a261 or ""))
        elseif a260 == "create" then
            task.spawn(create)
        elseif a260 == "join" then
            task.spawn(v86, ui11.Text, nil)
        elseif a260 == "refresh" then
            task.spawn(refresh, true)
        end

        local count = 0

        for _ in v81 do
            count += 1
        end

        return {open = v20.IsOpen, rows = count, listState = listState, code = ui11.Text, codeError = ui12.Text, public = public, mode = v33, name = ui3.Text, creating = creating, joining = v83
            or false, empty = parent12.Visible, size = string.format("%dx%d", v20.Holder.Size.X.Offset, v20.Holder.Size.Y.Offset)}
    end
end

return v4