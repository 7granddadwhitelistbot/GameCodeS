local Players_upv_1 = game:GetService("Players")
local GuiService_upv_1 = game:GetService("GuiService")
local CustomMatch_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local tbl_1 = {}
local _ = {sectionGap = 8, label = true, joinW = 100, left = 400, box = 50, pad = 16, H = 660, thumbW = 128, switchRow = 60, button = 58, errH = 18, sub = 15, sectionH = 24, rowBtn = 108, rowBtnH = 48, text = 18, W = 1120, desc = 15, rowH = 88, rowGap = 8, name = 20, slotH = 56, cardGap = 22, rowsGap = 2, section = 16, gap = 24}
local tbl_upv_2 = {sectionGap = 6, label = false, joinW = 100, left = 380, box = 52, pad = 14, H = 660, thumbW = 112, switchRow = 56, button = 56, errH = 18, sub = 14, sectionH = 24, rowBtn = 112, rowBtnH = 56, text = 18, W = 1120, desc = 14, rowH = 84, rowGap = 8, name = 19, slotH = 58, cardGap = 14, rowsGap = 0, section = 16, gap = 16}
local u1 = Color3.fromRGB(142, 149, 166)
local u2 = Color3.fromRGB(10, 11, 15)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 42
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        CustomMatch_upv_1 (copy, index: 4)
        u2 (copy, index: 5)
        u1 (copy, index: 6)
        GuiService_upv_1 (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Custom_upv_1 = a1.Custom
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local fromOffset_upv_1 = UDim2.fromOffset
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 57
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Close("CustomMatches")
    end
    local u3 = UI_upv_1.Window({HeaderHeight = 80, Name = "CustomMatches", Title = "CUSTOM MATCHES", Subtitle = "Your own server: invite friends, pick the map, start when you're ready  \194\183  " .. CustomMatch_upv_1.NO_REWARDS, Size = fromOffset_upv_1(tbl_upv_2.W, tbl_upv_2.H), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local Content_1 = u3.Content
    UI_upv_1.SelectionRing(u3.Root)
    local u4 = UI_upv_1.new("ScrollingFrame", {Name = "Left", ScrollBarThickness = 3, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, VerticalScrollBarInset = Enum.ScrollBarInset.None, Parent = Content_1})
    local u5 = UI_upv_1.SectionTitle("CREATE A MATCH", {Parent = u4})
    local function card(a2, a3)
        --[[
          name: card
          line: 64
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        local tbl_3 = {}
        tbl_3.Name = a2
        tbl_3.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_3.BackgroundTransparency = 0.3
        tbl_3[1], tbl_3[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        tbl_3.Parent = a3
        return UI_upv_1.new("Frame", tbl_3)
    end
    local u6 = card("Create", u4)
    local u7 = UI_upv_1.new("TextLabel", {Name = "NameLabel", Text = "SERVER NAME", TextSize = 13, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u6})
    local u8 = UI_upv_1.new("Frame", {Name = "NameField", BackgroundColor3 = u2, BackgroundTransparency = 0.25, [1] = UI_upv_1.Corner(10), Parent = u6})
    local u9 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
    u9.Parent = u8
    local u10 = UI_upv_1.new("TextBox", {Text = "", BackgroundTransparency = 1, Name = "NameBox", ClearTextOnFocus = false, PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName), PlaceholderColor3 = Colors_upv_1.TextMuted, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = fromOffset_upv_1(14, 0), Parent = u8})
    local u11 = UI_upv_1.new("TextLabel", {Name = "Counter", TextSize = 14, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = fromOffset_upv_1(56, 20), Text = "0/" .. CustomMatch_upv_1.NAME_MAX, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = u8})
    local u12 = CustomMatch_upv_1.DEFAULT_MODE
    local u13 = UI_upv_1.new("Frame", {Name = "ModeRow", Parent = u6})
    local u14 = UI_upv_1.Glyph("three-people", 24, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = u13})
    local u15 = UI_upv_1.new("TextLabel", {Name = "Label", Text = "MODE", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u13})
    local u16 = UI_upv_1.new("TextLabel", {Name = "Desc", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u13})
    local u17 = nil
    local function onMode(a4)
        --[[
          name: onMode
          line: 156
          upvalues:
            u12 (ref,  index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u17 (ref,  index: 4)
        ]]
        u12 = CustomMatch_upv_1.Mode(a4)
        local Play_1 = a1.Sounds.Play
        local tbl_4 = {pitch = 0}
        tbl_4.pitch = ((u12 ~= "1v1") and 0.94) or 1.08
        Play_1("Click", tbl_4)
        u17()
    end
    local tbl_5 = {{id = "3v3", text = "3V3"}, {id = "1v1", text = "1V1"}}
    local u18 = UI_upv_1.Segmented({Name = "Mode", Height = 38, Width = 132, Options = tbl_5, Selected = u12, AnchorPoint = Vector2.new(1, 0.5), Parent = u13, OnSelect = onMode})
    local u19 = UI_upv_1.Segmented({Name = "ModeCompact", TextSize = 20, Width = 124, Options = tbl_5, Selected = u12, Height = tbl_upv_2.button, Parent = u6, OnSelect = onMode})
    u17 = function(a5)
        --[[
          line: 182
          upvalues:
            u18 (copy, index: 1)
            u12 (ref,  index: 2)
            u19 (copy, index: 3)
            u16 (copy, index: 4)
            u14 (copy, index: 5)
        ]]
        u18:Set(u12, a5)
        u19:Set(u12, a5)
        u16.Text = u12 ~= "1v1" and "Three a side" or "One on one"
        u14.Text = u12 ~= "1v1" and "three-people" or "person"
    end
    local u20 = UI_upv_1.new("TextButton", {Text = "", Name = "PublicRow", AutoButtonColor = false, Parent = u6})
    local u21 = UI_upv_1.new("Frame", {Name = "Highlight", BackgroundColor3 = Colors_upv_1.White, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), [1] = UI_upv_1.Corner(10), Parent = u20})
    local u22 = UI_upv_1.Glyph("globe-simplified", 24, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = u20})
    local u23 = UI_upv_1.new("TextLabel", {Name = "Label", Text = "PUBLIC", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u20})
    local u24 = UI_upv_1.new("TextLabel", {Name = "Desc", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u20})
    local u25 = UI_upv_1.Switch({On = true, Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = u20})
    local u26 = true
    local u27 = UI_upv_1.Button({Name = "Create", Text = "CREATE MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("person-plus", 24, Colors_upv_1.Text), Parent = u6})
    local u28 = UI_upv_1.SectionTitle("JOIN WITH A CODE", {Parent = u4})
    local u29 = card("Join", u4)
    local u30 = UI_upv_1.new("TextButton", {Text = "", Name = "Slots", AutoButtonColor = false, Parent = u29})
    local tbl_upv_6 = {}
    for n_1 = 1, CustomMatch_upv_1.CODE_LEN do
        local v3 = UI_upv_1.new("Frame", {Name = "Slot" .. n_1, BackgroundColor3 = u2, BackgroundTransparency = 0.25, [1] = UI_upv_1.Corner(9), Parent = u30})
        local v4 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.86)
        v4.Parent = v3
        tbl_upv_6[n_1] = {
            frame = v3,
            stroke = v4,
            label = UI_upv_1.new("TextLabel", {Name = "Char", Text = "", TextSize = 28, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = v3}),
            caret = UI_upv_1.new("Frame", {Name = "Caret", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -9), Size = fromOffset_upv_1(16, 3), BackgroundColor3 = Colors_upv_1.Accent, Visible = false, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v3})
        }
        local u31 = n_1
    end
    local u32 = UI_upv_1.new("TextBox", {TextTransparency = 1, Text = "", ZIndex = 3, Name = "CodeBox", ClearTextOnFocus = false, BackgroundTransparency = 1, PlaceholderText = "", TextSize = 20, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = u30})
    local u33 = UI_upv_1.Button({Text = "JOIN", Name = "JoinCode", Style = "Primary", Parent = u29})
    local u31 = UI_upv_1.new("TextLabel", {Name = "Error", Text = "", TextSize = 15, FontFace = Fonts_upv_1.Bold, TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Danger, 0.15), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u29})
    local function paintHelp()
        --[[
          name: paintHelp
          line: 292
          upvalues:
            u31 (copy, index: 1)
            u1 (copy, index: 2)
        ]]
        if u31.Text ~= "" and u31.Text ~= "Ask the host for their code" then
            return
        end
        u31.Text = "Ask the host for their code"
        u31.TextColor3 = u1
    end
    local u34 = UI_upv_1.new("Frame", {Name = "Right", Parent = Content_1})
    local u35 = UI_upv_1.SectionTitle("PUBLIC MATCHES", {Parent = u34})
    local u36 = UI_upv_1.new("Frame", {Name = "Live", AnchorPoint = Vector2.new(1, 0), Size = fromOffset_upv_1(200, 24), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = u34})
    local u37 = UI_upv_1.new("Frame", {Name = "Dot", Size = fromOffset_upv_1(8, 8), BackgroundColor3 = Colors_upv_1.Success, LayoutOrder = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u36})
    local u38 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "LIVE", Name = "Text", TextSize = 13, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 20), Parent = u36})
    local paintSlots = UI_upv_1.IconButton({LayoutOrder = 3, Name = "Refresh", Size = fromOffset_upv_1(34, 34), Color = Colors_upv_1.Raised, Parent = u36})
    local u39 = UI_upv_1.Glyph("arrow-spin-clockwise", 20, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = paintSlots})
    local tbl_7 = {}
    tbl_7.Name = "List"
    tbl_7.ScrollBarThickness = 5
    tbl_7.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tbl_7.Selectable = false
    tbl_7[1], tbl_7[2] = UI_upv_1.List(Enum.FillDirection.Vertical, 8), UI_upv_1.Padding(0, 10, 4, 0)
    tbl_7.Parent = u34
    local u40 = UI_upv_1.new("ScrollingFrame", tbl_7)
    local u41 = UI_upv_1.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, -10, 0, 40), BackgroundColor3 = Colors_upv_1.PanelLo, ZIndex = 4, Visible = false, [1] = UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05)), Parent = u34})
    local function updateFade()
        --[[
          name: updateFade
          line: 352
          upvalues:
            u40 (copy, index: 1)
            u41 (copy, index: 2)
        ]]
        u41.Visible = (u40.AbsoluteCanvasSize.Y - (u40.CanvasPosition.Y + u40.AbsoluteWindowSize.Y)) > 2
    end
    u40:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
    u40:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
    u40:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
    local u42 = UI_upv_1.new("Frame", {Visible = false, Name = "Empty", Parent = u34})
    UI_upv_1.Glyph("three-people", 52, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = u42})
    local u43 = UI_upv_1.new("TextLabel", {Text = "No public matches right now", Name = "Title", TextSize = 21, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 64), Size = UDim2.new(1, -40, 0, 26), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = u42})
    local u44 = UI_upv_1.new("TextLabel", {TextWrapped = true, Text = "Create one and it shows up here for everyone. Private matches only take a code.", Name = "Sub", TextSize = 16, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 94), Size = UDim2.new(1, -60, 0, 44), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, Parent = u42})
    local u45 = UI_upv_1.Button({Visible = false, Text = "TRY AGAIN", Name = "Retry", Style = "Dark", TextSize = 18, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 150), Size = fromOffset_upv_1(180, 48), Parent = u42})
    local tbl_upv_8 = {}
    local tbl_upv_9 = {}
    local u46 = nil
    local u47 = nil
    local function makeRow(a6)
        --[[
          name: makeRow
          line: 416
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            u40 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            u1 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            u47 (ref,  index: 8)
        ]]
        local v5 = {}
        v5.Name = "Match_" .. a6.code
        v5.BackgroundColor3 = Colors_upv_1.PanelHi
        v5.BackgroundTransparency = 0.3
        v5[1], v5[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        v5.Parent = u40
        local v6 = UI_upv_1.new("Frame", v5)
        local tbl_10 = {}
        tbl_10.Name = "Thumb"
        tbl_10.ScaleType = Enum.ScaleType.Crop
        tbl_10.BackgroundColor3 = Colors_upv_1.Raised
        tbl_10.BackgroundTransparency = 0
        tbl_10[1] = UI_upv_1.Corner(8)
        tbl_10.Parent = v6
        local v7 = UI_upv_1.new("ImageLabel", tbl_10)
        UI_upv_1.Gradient(Color3.fromRGB(46, 52, 66), Color3.fromRGB(28, 31, 40), 120).Parent = v7
        v5 = UI_upv_1.new("TextLabel", {Visible = false, Name = "Random", Text = "?", TextSize = 34, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextMuted, Parent = v7})
        local v8 = UI_upv_1.Pill("3V3", Colors_upv_1.Void, {Name = "Mode", Height = 20, ZIndex = 2, TextSize = 13, PadX = 7, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 5, 1, -5), Parent = v7})
        local Text_1 = v8:FindFirstChild("Text")
        local v9 = UI_upv_1.new("TextLabel", {Name = "MatchName", Text = "", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v6})
        local v10 = UI_upv_1.new("TextLabel", {Name = "Sub", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v6})
        local tbl_11 = {}
        tbl_11.Name = "Players"
        tbl_11.AnchorPoint = Vector2.new(1, 0.5)
        tbl_11.Size = fromOffset_upv_1(96, 22)
        tbl_11[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
        tbl_11.Parent = v6
        local v11 = UI_upv_1.new("Frame", tbl_11)
        local v12 = UI_upv_1.Glyph("person", 17, Colors_upv_1.TextDim, {LayoutOrder = 1, Parent = v11})
        tbl_11 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "", Name = "Count", TextSize = 18, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 22), Parent = v11})
        local tbl_12 = {}
        tbl_12.Name = "Status"
        tbl_12.AnchorPoint = Vector2.new(1, 0.5)
        tbl_12.AutomaticSize = Enum.AutomaticSize.X
        tbl_12.Size = fromOffset_upv_1(0, 22)
        tbl_12[1], tbl_12[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 9, 0, 9)
        tbl_12.Parent = v6
        local v13 = UI_upv_1.new("Frame", tbl_12)
        local v14 = UI_upv_1.new("TextLabel", {Name = "Text", Text = "", TextSize = 13, FontFace = Fonts_upv_1.Heavy, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v13})
        tbl_12 = UI_upv_1.Button({Name = "Join", Text = "JOIN", TextSize = 19, Style = "Primary", AnchorPoint = Vector2.new(1, 0.5), Parent = v6})
        local tbl_upv_13 = {full = false, frame = v6, thumb = v7, random = v5, name = v9, sub = v10, count = tbl_11, people = v12, pill = v13, pillText = v14, mode = v8, modeText = Text_1, button = tbl_12, code = a6.code}
        tbl_12.Activated:Connect(
            function()
                --[[
                  line: 518
                  upvalues:
                    u47 (ref, index: 1)
                    tbl_upv_13 (ref, index: 2)
                ]]
                u47(tbl_upv_13.code, tbl_upv_13)
            end
        )
        return tbl_upv_13
    end
    local function layoutRow(a7, a8)
        --[[
          name: layoutRow
          line: 524
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            fromOffset_upv_1 (copy, index: 2)
        ]]
        local rowH_1 = tbl_upv_2.rowH
        a7.frame.Size = UDim2.new(1, -4, 0, rowH_1)
        local thumbW_1 = tbl_upv_2.thumbW
        local v15 = math.floor((thumbW_1 * 9) / 16)
        a7.thumb.Position = fromOffset_upv_1(10, math.floor((rowH_1 - v15) / 2))
        a7.thumb.Size = fromOffset_upv_1(thumbW_1, v15)
        local v16 = 10 + thumbW_1 + 14
        local v17 = tbl_upv_2.rowBtn + 16 + 96
        a7.name.Position = fromOffset_upv_1(v16, (math.floor(rowH_1 / 2) - tbl_upv_2.name) - 4)
        a7.name.Size = fromOffset_upv_1(math.max(80, (a8 - v16) - v17), tbl_upv_2.name + 4)
        a7.name.TextSize = tbl_upv_2.name
        a7.sub.Position = fromOffset_upv_1(v16, math.floor(rowH_1 / 2) + 3)
        a7.sub.Size = fromOffset_upv_1(math.max(80, (a8 - v16) - v17), tbl_upv_2.sub + 4)
        a7.sub.TextSize = tbl_upv_2.sub
        a7.button.Instance.Position = UDim2.new(1, -12, 0.5, 0)
        a7.button.Instance.Size = fromOffset_upv_1(tbl_upv_2.rowBtn, tbl_upv_2.rowBtnH)
        local v18 = -((12 + tbl_upv_2.rowBtn) + 16)
        a7.count.Parent.Position = UDim2.new(1, v18, 0.5, -12)
        a7.pill.Position = UDim2.new(1, v18, 0.5, 14)
    end
    local function statusLook(a9)
        --[[
          name: statusLook
          line: 407
          upvalues:
            Colors_upv_1 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
        ]]
        if a9 ~= "Match" then
            return "LOBBY", Colors_upv_1.Success:Lerp(Colors_upv_1.Panel, 0.78), Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1)
        end
        return "IN MATCH", Colors_upv_1.Warning:Lerp(Colors_upv_1.Panel, 0.78), Theme_upv_1.Lighten(Colors_upv_1.Warning, 0.1)
    end
    local function paintRow(a10, a11, a12)
        --[[
          name: paintRow
          line: 547
          upvalues:
            CustomMatch_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            statusLook (copy, index: 3)
            u46 (ref,  index: 4)
        ]]
        a10.name.AutoLocalize = false
        a10.name.Text = a11.name
        local v19
        if type(a11.host) ~= "string" or a11.host == "" then
            v19 = ""
        else
            v19 = "  \194\183  " .. a11.host
        end
        a10.sub.Text = string.upper(a11.mapName or "Random") .. v19
        if type(a11.thumb) ~= "string" or a11.thumb == "" then
            a10.thumb.Image = ""
            a10.random.Visible = true
        else
            a10.thumb.Image = a11.thumb
            a10.random.Visible = false
        end
        v19 = CustomMatch_upv_1.Mode(a11.mode) == "1v1"
        a10.modeText.Text = CustomMatch_upv_1.ModeLabel(a11.mode)
        local mode_1 = a10.mode
        local v20
        if v19 then
            v20 = Colors_upv_1.Accent
        else
            v20 = Colors_upv_1.Void
        end
        mode_1.BackgroundColor3 = v20
        a10.mode.BackgroundTransparency = (v19 and 0.05) or 0.3
        a10.count.Text = string.format("%d/%d", a11.players, a11.max)
        local v21, v22, v23 = statusLook(a11.status)
        a10.pillText.Text = v21
        a10.pillText.TextColor3 = v23
        a10.pill.BackgroundColor3 = v22
        a10.full = a11.max <= a11.players
        a10.frame.LayoutOrder = a12
        if u46 == a11.code then
            a10.button:SetText("JOINING...")
            a10.button:SetEnabled(false)
        elseif a10.full then
            a10.button:SetText("FULL")
            a10.button:SetEnabled(false)
        else
            a10.button:SetText("JOIN")
            a10.button:SetEnabled(u46 == nil)
        end
    end
    local u48 = 600
    local u49 = "loading"
    local u50 = {}
    local function clearSkeletons()
        --[[
          name: clearSkeletons
          line: 585
          upvalues:
            tbl_upv_9 (copy, index: 1)
        ]]
        for _, value_1 in tbl_upv_9 do
            value_1:Destroy()
        end
        table.clear(tbl_upv_9)
    end
    local function showSkeletons()
        --[[
          name: showSkeletons
          line: 591
          upvalues:
            tbl_upv_9 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_2 (ref,  index: 3)
            Colors_upv_1 (copy, index: 4)
            u40 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
        ]]
        for _, value_2 in tbl_upv_9 do
            value_2:Destroy()
        end
        table.clear(tbl_upv_9)
        for n_2 = 1, 3 do
            local v24 = UI_upv_1.new("Frame", {Name = "Skeleton" .. n_2, Size = UDim2.new(1, -4, 0, tbl_upv_2.rowH), BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, LayoutOrder = n_2, [1] = UI_upv_1.Corner(12), Parent = u40})
            local v25 = math.floor((tbl_upv_2.thumbW * 9) / 16)
            UI_upv_1.new("Frame", {Position = fromOffset_upv_1(10, math.floor((tbl_upv_2.rowH - v25) / 2)), Size = fromOffset_upv_1(tbl_upv_2.thumbW, v25), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(8), Parent = v24})
            UI_upv_1.new("Frame", {Position = fromOffset_upv_1(tbl_upv_2.thumbW + 24, math.floor(tbl_upv_2.rowH / 2) - 20), Size = fromOffset_upv_1(200, 14), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v24})
            UI_upv_1.new("Frame", {Position = fromOffset_upv_1(tbl_upv_2.thumbW + 24, math.floor(tbl_upv_2.rowH / 2) + 6), Size = fromOffset_upv_1(130, 10), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v24})
            local tbl_14 = {BackgroundTransparency = 0.72}
            UI_upv_1.Tween(v24, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, n_2 * 0.12), tbl_14)
            table.insert(tbl_upv_9, v24)
        end
    end
    local function renderList(a13, a14)
        --[[
          name: renderList
          line: 612
          upvalues:
            u50 (ref,  index: 1)
            tbl_upv_9 (copy, index: 2)
            tbl_upv_8 (copy, index: 3)
            makeRow (copy, index: 4)
            layoutRow (copy, index: 5)
            u48 (ref,  index: 6)
            paintRow (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u35 (copy, index: 9)
            u42 (copy, index: 10)
            u49 (ref,  index: 11)
            u43 (copy, index: 12)
            u44 (copy, index: 13)
            u45 (copy, index: 14)
            u38 (copy, index: 15)
            u37 (copy, index: 16)
            Colors_upv_1 (copy, index: 17)
            updateFade (copy, index: 18)
        ]]
        u50 = a13
        for _, value_3 in tbl_upv_9 do
            value_3:Destroy()
        end
        table.clear(tbl_upv_9)
        local tbl_15 = {}
        local v26, v27 = nil, nil
        for key_1, value_4 in a13 do
            if type(value_4) ~= "table" or type(value_4.code) ~= "string" then
                continue
            end
            tbl_15[value_4.code] = true
            v26 = tbl_upv_8[value_4.code]
            v27 = false
            if not v26 then
                v26 = makeRow(value_4)
                tbl_upv_8[value_4.code] = v26
                v27 = true
            end
            layoutRow(v26, u48)
            paintRow(v26, value_4, key_1)
            if not (v27) then
                continue
            end
            if a14 then
                UI_upv_1.Enter(v26.frame, Vector2.new(0, 12), math.min(key_1 * 0.035, 0.25), UDim2.new())
            end
        end
        for key_2, value_5 in tbl_upv_8 do
            if not (tbl_15[key_2]) then
                value_5.frame:Destroy()
                tbl_upv_8[key_2] = nil
            end
        end
        local v29 = 0
        for _ in tbl_upv_8 do
            v29 = v29 + 1
        end
        local Text_2 = u35.Text
        Text_2.Text = not (v29 > 0) and "PUBLIC MATCHES" or string.format("PUBLIC MATCHES  \194\183  %d", v29)
        u42.Visible = v29 == 0 and u49 ~= "loading"
        u43.Text = u49 ~= "error" and "No public matches right now" or "Couldn't load public matches"
        u44.Text = u49 ~= "error" and "Create one and it shows up here for everyone. Private matches only take a code." or "Check your connection and try again. Joining with a code still works."
        u45.Instance.Visible = u49 == "error"
        u38.Text = u49 ~= "error" and "LIVE" or "OFFLINE"
        local v36
        if u49 ~= "error" then
            v36 = Colors_upv_1.Success
        else
            v36 = Colors_upv_1.TextMuted
        end
        u37.BackgroundColor3 = v36
        task.defer(updateFade)
    end
    local u51 = false
    local u52 = 0
    local function refresh(a15)
        --[[
          name: refresh
          line: 658
          upvalues:
            u51 (ref,  index: 1)
            u52 (ref,  index: 2)
            u39 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            Custom_upv_1 (copy, index: 5)
            u3 (copy, index: 6)
            u49 (ref,  index: 7)
            renderList (copy, index: 8)
            tbl_upv_8 (copy, index: 9)
            u50 (ref,  index: 10)
        ]]
        if u51 or not (a15) and os.clock() - u52 < 2 then
            return
        end
        u51 = true
        u52 = os.clock()
        local _ = os.clock()
        u39.Rotation = 0
        local tbl_16 = {Rotation = 360}
        UI_upv_1.Tween(u39, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_16)
        local v37, v38 = Custom_upv_1.Action("List")
        u51 = false
        if not u3.IsOpen then
            return
        end
        if v37 and type(v38) == "table" and type(v38.list) == "table" then
            local v39 = u49 ~= "ok"
            u49 = "ok"
            renderList(v38.list, v39)
            return
        end
        local v40 = ((next(tbl_upv_8)) and "ok") or "error"
        u49 = v40
        renderList(u50, false)
    end
    paintSlots.Activated:Connect(
        function()
            --[[
              line: 682
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    u45.Activated:Connect(
        function()
            --[[
              line: 685
              upvalues:
                u49 (ref,  index: 1)
                u42 (copy, index: 2)
                showSkeletons (copy, index: 3)
                refresh (copy, index: 4)
            ]]
            u49 = "loading"
            u42.Visible = false
            showSkeletons()
            refresh(true)
        end
    )
    local u53 = false
    local u54 = 0
    paintSlots = function()
        --[[
          name: paintSlots
          line: 695
          upvalues:
            u32 (copy, index: 1)
            tbl_upv_6 (copy, index: 2)
            u53 (ref,  index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u33 (copy, index: 6)
            u46 (ref,  index: 7)
        ]]
        local Text_3 = u32.Text
        local v41 = #Text_3
        local v42 = nil
        local v43 = nil
        for key_3, value_6 in tbl_upv_6 do
            local v44 = string.sub(Text_3, key_3, key_3)
            value_6.label.Text = v44
            v42 = u53
            if v42 then
                v42 = true
                if key_3 ~= v41 + 1 then
                    v42 = (v41 == CustomMatch_upv_1.CODE_LEN) and (key_3 == v41)
                end
            end
            value_6.caret.Visible = u53 and (key_3 == v41 + 1)
            local stroke_1 = value_6.stroke
            if v42 then
                v43 = Colors_upv_1.Accent
                stroke_1.Color = v43
                value_6.stroke.Transparency = (v42 and 0.1) or (((v44 == "") and 0.86) or 0.7)
                continue
            end
            if v44 == "" or v44 ~= "" then
                v43 = Colors_upv_1.Stroke
                stroke_1.Color = v43
                value_6.stroke.Transparency = (v42 and 0.1) or (((v44 == "") and 0.86) or 0.7)
            end
        end
        local v45 = (v41 == CustomMatch_upv_1.CODE_LEN) and (u46 == nil)
        u33:SetEnabled(v45)
    end
    local u55 = false
    u32:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 709
              upvalues:
                u55 (ref,  index: 1)
                CustomMatch_upv_1 (copy, index: 2)
                u32 (copy, index: 3)
                u31 (copy, index: 4)
                u1 (copy, index: 5)
                tbl_upv_6 (copy, index: 6)
                UI_upv_1 (copy, index: 7)
                paintSlots (copy, index: 8)
            ]]
            if u55 then
                return
            end
            local v46 = CustomMatch_upv_1.CleanCode(u32.Text)
            if v46 ~= u32.Text then
                u55 = true
                u32.Text = v46
                u32.CursorPosition = #v46 + 1
                u55 = false
            end
            if u31.Text ~= "Ask the host for their code" then
                u31.Text = ""
                if u31.Text == "" or u31.Text == "Ask the host for their code" then
                    u31.Text = "Ask the host for their code"
                    u31.TextColor3 = u1
                end
            end
            local v47 = #v46
            local v48 = tbl_upv_6[v47]
            if v48 and v47 > 0 then
                UI_upv_1.Bump(v48.label, 0.18)
            end
            paintSlots()
        end
    )
    u32.Focused:Connect(
        function()
            --[[
              line: 731
              upvalues:
                u53 (ref,  index: 1)
                paintSlots (copy, index: 2)
            ]]
            u53 = true
            paintSlots()
        end
    )
    u32.FocusLost:Connect(
        function(a16)
            --[[
              line: 735
              upvalues:
                u53 (ref,  index: 1)
                paintSlots (copy, index: 2)
                u32 (copy, index: 3)
                CustomMatch_upv_1 (copy, index: 4)
                u47 (ref,  index: 5)
            ]]
            u53 = false
            paintSlots()
            if not a16 or #u32.Text ~= CustomMatch_upv_1.CODE_LEN then
                return
            end
            u47(u32.Text, nil)
        end
    )
    UI_upv_1.Every(
        u3.Root,
        0.5,
        function()
            --[[
              line: 743
              upvalues:
                u53 (ref,  index: 1)
                u32 (copy, index: 2)
                tbl_upv_6 (copy, index: 3)
            ]]
            if u53 then
                local v49 = tbl_upv_6[#u32.Text + 1]
                if not v49 then
                    return
                end
                v49.caret.BackgroundTransparency = ((v49.caret.BackgroundTransparency < 0.5) and 1) or 0
            end
        end
    )
    local function showCodeError(a17)
        --[[
          name: showCodeError
          line: 753
          upvalues:
            u54 (ref,  index: 1)
            u31 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u30 (copy, index: 6)
            a1 (copy, index: 7)
            tbl_upv_6 (copy, index: 8)
            paintSlots (copy, index: 9)
        ]]
        u54 = u54 + 1
        local u56 = u54
        u31.Text = a17
        u31.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Danger, 0.15)
        UI_upv_1.Shake(u30, 8)
        a1.Sounds.Play("Error")
        for _, value_7 in tbl_upv_6 do
            value_7.stroke.Color = Colors_upv_1.Danger
            value_7.stroke.Transparency = 0.15
        end
        task.delay(
            1.2,
            function()
                --[[
                  line: 764
                  upvalues:
                    u56 (copy, index: 1)
                    u54 (ref,  index: 2)
                    paintSlots (copy, index: 3)
                ]]
                if u56 ~= u54 then
                    return
                end
                paintSlots()
            end
        )
    end
    local u57 = false
    local function paintBusy()
        --[[
          name: paintBusy
          line: 773
          upvalues:
            u27 (copy, index: 1)
            u57 (ref,  index: 2)
            u46 (ref,  index: 3)
            u33 (copy, index: 4)
            u32 (copy, index: 5)
            paintSlots (copy, index: 6)
            tbl_upv_8 (copy, index: 7)
            u50 (ref,  index: 8)
            paintRow (copy, index: 9)
        ]]
        local v50 = (u57 and "CREATING...") or "CREATE MATCH"
        u27:SetText(v50)
        v50 = not u57 and (u46 == nil)
        u27:SetEnabled(v50)
        if u46 == nil or u46 ~= u32.Text then
            v50 = "JOIN"
        else
            v50 = "..."
        end
        u33:SetText(v50)
        paintSlots()
        for key_4, value_8 in tbl_upv_8 do
            for _, value_9 in u50 do
                if value_9.code == key_4 then
                    paintRow(value_8, value_9, value_8.frame.LayoutOrder)
                end
            end
        end
    end
    u47 = function(a18, a19)
        --[[
          line: 787
          upvalues:
            u46 (ref,  index: 1)
            u57 (ref,  index: 2)
            CustomMatch_upv_1 (copy, index: 3)
            showCodeError (copy, index: 4)
            paintBusy (copy, index: 5)
            Custom_upv_1 (copy, index: 6)
            a1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            refresh (copy, index: 9)
        ]]
        if (u46) then
            return
        end
        if not (u57) then
            local v51 = CustomMatch_upv_1.ValidCode(a18)
            if v51 then
                u46 = v51
                paintBusy()
                local v52, v53 = Custom_upv_1.Action("Join", v51)
                u46 = nil
                paintBusy()
                if v52 then
                    a1.Sounds.Play("Queue_Join")
                    a1.MenuManager.Close("CustomMatches")
                else
                    local str_1 = tostring(v53 or "Couldn't join that match")
                    if a19 then
                        a1.Toast(str_1, "error")
                        UI_upv_1.Shake(a19.frame, 6)
                        refresh(true)
                    else
                        showCodeError(str_1)
                    end
                end
            else
                showCodeError(string.format("Codes have %d letters and numbers", CustomMatch_upv_1.CODE_LEN))
            end
        end
    end
    u33.Activated:Connect(
        function()
            --[[
              line: 815
              upvalues:
                u47 (ref,  index: 1)
                u32 (copy, index: 2)
            ]]
            u47(u32.Text, nil)
        end
    )
    u30.Activated:Connect(
        function()
            --[[
              line: 818
              upvalues:
                u32 (copy, index: 1)
            ]]
            u32:CaptureFocus()
        end
    )
    local function create()
        --[[
          name: create
          line: 822
          upvalues:
            u57 (ref,  index: 1)
            u46 (ref,  index: 2)
            paintBusy (copy, index: 3)
            Custom_upv_1 (copy, index: 4)
            u10 (copy, index: 5)
            u26 (ref,  index: 6)
            u12 (ref,  index: 7)
            a1 (copy, index: 8)
            UI_upv_1 (copy, index: 9)
            u27 (copy, index: 10)
            u9 (copy, index: 11)
            Colors_upv_1 (copy, index: 12)
        ]]
        if (u57) then
            return
        end
        if not (u46) then
            u57 = true
            paintBusy()
            local v54, v55 = Custom_upv_1.Action("Create", {name = u10.Text, public = u26, mode = u12})
            u57 = false
            paintBusy()
            if v54 then
                a1.Sounds.Play("Queue_Join")
                a1.MenuManager.Close("CustomMatches")
            else
                a1.Toast(tostring(v55 or "Couldn't create the match"), "error")
                UI_upv_1.Shake(u27.Instance, 6)
                if type(v55) == "string" and (string.find(v55, "name", 1, true) or string.find(v55, "Name", 1, true)) then
                    u9.Color = Colors_upv_1.Danger
                    u9.Transparency = 0.15
                    task.delay(
                        1.4,
                        function()
                            --[[
                              line: 841
                              upvalues:
                                u9 (copy, index: 1)
                                Colors_upv_1 (copy, index: 2)
                            ]]
                            u9.Color = Colors_upv_1.Stroke
                            u9.Transparency = 0.88
                        end
                    )
                end
            end
        end
    end
    u27.Activated:Connect(create)
    local function paintPublic(a20)
        --[[
          name: paintPublic
          line: 849
          upvalues:
            u25 (copy, index: 1)
            u26 (ref,  index: 2)
            u23 (copy, index: 3)
            u24 (copy, index: 4)
            u22 (copy, index: 5)
        ]]
        u25:Set(u26, a20)
        u23.Text = u26 and "PUBLIC" or "PRIVATE"
        u24.Text = u26 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
        u22.Text = u26 and "globe-simplified" or "lock-closed"
    end
    u20.Activated:Connect(
        function()
            --[[
              line: 855
              upvalues:
                u26 (ref,  index: 1)
                a1 (copy, index: 2)
                u25 (copy, index: 3)
                u23 (copy, index: 4)
                u24 (copy, index: 5)
                u22 (copy, index: 6)
            ]]
            u26 = not u26
            local Play_2 = a1.Sounds.Play
            local tbl_17 = {pitch = 0}
            tbl_17.pitch = (u26 and 1.08) or 0.94
            Play_2("Click", tbl_17)
            u25:Set(u26, nil)
            u23.Text = u26 and "PUBLIC" or "PRIVATE"
            u24.Text = u26 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
            u22.Text = u26 and "globe-simplified" or "lock-closed"
        end
    )
    u20.MouseEnter:Connect(
        function()
            --[[
              line: 860
              upvalues:
                UI_upv_1 (copy, index: 1)
                u21 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            if (UI_upv_1.Touch) then
                return
            end
            UI_upv_1.Tween(u21, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.955})
        end
    )
    u20.MouseLeave:Connect(
        function()
            --[[
              line: 865
              upvalues:
                UI_upv_1 (copy, index: 1)
                u21 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            UI_upv_1.Tween(u21, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 1})
        end
    )
    local function capName()
        --[[
          name: capName
          line: 869
          upvalues:
            u10 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            u11 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local Text_4 = u10.Text
        local v62 = utf8.len(Text_4) or (#Text_4)
        if CustomMatch_upv_1.NAME_MAX < v62 then
            local v63 = utf8.offset(Text_4, CustomMatch_upv_1.NAME_MAX + 1) or (#Text_4 + 1)
            u10.Text = string.sub(Text_4, 1, v63 - 1)
        else
            u11.Text = string.format("%d/%d", v62, CustomMatch_upv_1.NAME_MAX)
            local v64
            if CustomMatch_upv_1.NAME_MAX <= v62 then
                v64 = Colors_upv_1.Warning
            else
                v64 = Colors_upv_1.TextMuted
            end
            u11.TextColor3 = v64
        end
    end
    u10:GetPropertyChangedSignal("Text"):Connect(capName)
    u10.Focused:Connect(
        function()
            --[[
              line: 881
              upvalues:
                UI_upv_1 (copy, index: 1)
                u9 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
                Colors_upv_1 (copy, index: 4)
            ]]
            UI_upv_1.Tween(u9, Theme_upv_1.Tween.Fast, {Transparency = 0.2, Color = Colors_upv_1.Accent})
        end
    )
    u10.FocusLost:Connect(
        function(a21)
            --[[
              line: 884
              upvalues:
                UI_upv_1 (copy, index: 1)
                u9 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
                Colors_upv_1 (copy, index: 4)
                create (copy, index: 5)
            ]]
            UI_upv_1.Tween(u9, Theme_upv_1.Tween.Fast, {Transparency = 0.88, Color = Colors_upv_1.Stroke})
            if not a21 then
                return
            end
            create()
        end
    )
    local function layout()
        --[[
          name: layout
          line: 892
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            u3 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            u4 (copy, index: 7)
            u34 (copy, index: 8)
            u5 (copy, index: 9)
            u7 (copy, index: 10)
            u8 (copy, index: 11)
            u10 (copy, index: 12)
            u13 (copy, index: 13)
            u19 (copy, index: 14)
            u14 (copy, index: 15)
            u15 (copy, index: 16)
            u16 (copy, index: 17)
            u18 (copy, index: 18)
            u20 (copy, index: 19)
            u22 (copy, index: 20)
            u23 (copy, index: 21)
            u24 (copy, index: 22)
            u25 (copy, index: 23)
            u27 (copy, index: 24)
            u6 (copy, index: 25)
            u28 (copy, index: 26)
            CustomMatch_upv_1 (copy, index: 27)
            u30 (copy, index: 28)
            tbl_upv_6 (copy, index: 29)
            u33 (copy, index: 30)
            u31 (copy, index: 31)
            u29 (copy, index: 32)
            u35 (copy, index: 33)
            u36 (copy, index: 34)
            u40 (copy, index: 35)
            u48 (ref,  index: 36)
            tbl_upv_8 (copy, index: 37)
            layoutRow (copy, index: 38)
            tbl_upv_9 (copy, index: 39)
            u42 (copy, index: 40)
        ]]
        local v65 = UI_upv_1.CanvasSize()
        local v66 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            u3.Holder.Size = fromOffset_upv_1(math.floor(math.min(tbl_upv_2.W, v65.X - 24)), math.floor(math.min(tbl_upv_2.H, (v65.Y - v66) - 12)))
        else
            u3.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v65.X - 240, tbl_upv_2.W, 1240)), math.floor(math.clamp((v65.Y - v66) - 110, 620, 680)))
        end
        u3.Subtitle.TextSize = ((UI_upv_1.Compact) and 15) or 17
        local v67 = u3.Holder.Size.Y.Offset - 80 - 32
        local left_1 = tbl_upv_2.left
        u4.Size = fromOffset_upv_1(left_1, v67)
        u34.Position = fromOffset_upv_1(left_1 + tbl_upv_2.gap, 0)
        local v68 = (u3.Holder.Size.X.Offset - 44) - left_1 - tbl_upv_2.gap
        u34.Size = fromOffset_upv_1(v68, v67)
        local pad_1 = tbl_upv_2.pad
        local v69 = left_1 - pad_1 * 2
        u5.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        u5.Position = fromOffset_upv_1(0, 0)
        local v70 = pad_1
        u7.Visible = tbl_upv_2.label
        if tbl_upv_2.label then
            u7.Position = fromOffset_upv_1(pad_1 + 2, v70)
            u7.Size = fromOffset_upv_1(v69, 16)
            v70 = v70 + 22
        end
        u8.Position = fromOffset_upv_1(pad_1, v70)
        u8.Size = fromOffset_upv_1(v69, tbl_upv_2.box)
        u10.Size = UDim2.new(1, -84, 1, 0)
        u10.TextSize = tbl_upv_2.text
        local v71 = v70 + (tbl_upv_2.box + 10)
        u13.Visible = not UI_upv_1.Compact
        u19.Instance.Visible = UI_upv_1.Compact
        if UI_upv_1.Compact then
            v70 = v71
        else
            u13.Position = fromOffset_upv_1(pad_1 - 6, v71)
            u13.Size = fromOffset_upv_1(v69 + 12, tbl_upv_2.switchRow)
            u14.Position = UDim2.new(0, 8, 0.5, 0)
            u15.Position = fromOffset_upv_1(42, (math.floor(tbl_upv_2.switchRow / 2) - tbl_upv_2.text) - 1)
            u15.Size = fromOffset_upv_1(v69 - 180, tbl_upv_2.text + 2)
            u15.TextSize = tbl_upv_2.text
            u16.Position = fromOffset_upv_1(42, math.floor(tbl_upv_2.switchRow / 2) + 2)
            u16.Size = fromOffset_upv_1(v69 - 180, tbl_upv_2.desc + 2)
            u16.TextSize = tbl_upv_2.desc
            u18.Instance.Position = UDim2.new(1, -8, 0.5, 0)
            v70 = v71 + (tbl_upv_2.switchRow + tbl_upv_2.rowsGap)
        end
        u20.Position = fromOffset_upv_1(pad_1 - 6, v70)
        u20.Size = fromOffset_upv_1(v69 + 12, tbl_upv_2.switchRow)
        u22.Position = UDim2.new(0, 8, 0.5, 0)
        u23.Position = fromOffset_upv_1(42, (math.floor(tbl_upv_2.switchRow / 2) - tbl_upv_2.text) - 1)
        u23.Size = fromOffset_upv_1(v69 - 110, tbl_upv_2.text + 2)
        u23.TextSize = tbl_upv_2.text
        u24.Position = fromOffset_upv_1(42, math.floor(tbl_upv_2.switchRow / 2) + 2)
        u24.Size = fromOffset_upv_1(v69 - 110, tbl_upv_2.desc + 2)
        u24.TextSize = tbl_upv_2.desc
        u25.Instance.Position = UDim2.new(1, -8, 0.5, 0)
        local v72 = v70 + (tbl_upv_2.switchRow + 10)
        if UI_upv_1.Compact then
            local Offset_1 = u19.Instance.Size.X.Offset
            u19.Instance.Position = fromOffset_upv_1(pad_1, v72)
            u27.Instance.Position = fromOffset_upv_1((pad_1 + Offset_1) + 8, v72)
            u27.Instance.Size = fromOffset_upv_1((v69 - Offset_1) - 8, tbl_upv_2.button)
        else
            u27.Instance.Position = fromOffset_upv_1(pad_1, v72)
            u27.Instance.Size = fromOffset_upv_1(v69, tbl_upv_2.button)
        end
        u27.Label.TextSize = ((UI_upv_1.Compact) and 22) or 24
        local v73 = v72 + (tbl_upv_2.button + pad_1)
        local v74 = tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        u6.Position = fromOffset_upv_1(0, v74)
        u6.Size = fromOffset_upv_1(left_1, v73)
        local v75 = v74 + v73 + tbl_upv_2.cardGap
        u28.Position = fromOffset_upv_1(0, v75)
        u28.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        local v76 = v75 + tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        local v77 = math.floor((((v69 - tbl_upv_2.joinW) - 12 - (5 * (CustomMatch_upv_1.CODE_LEN - 2))) - 14) / CustomMatch_upv_1.CODE_LEN)
        u30.Position = fromOffset_upv_1(pad_1, pad_1)
        u30.Size = fromOffset_upv_1(((v77 * CustomMatch_upv_1.CODE_LEN) + (5 * (CustomMatch_upv_1.CODE_LEN - 2))) + 14, tbl_upv_2.slotH)
        for key_5, value_10 in tbl_upv_6 do
            value_10.frame.Position = fromOffset_upv_1(((key_5 - 1) * (v77 + 5)) + (((CustomMatch_upv_1.CODE_LEN // 2 < key_5) and 9) or 0), 0)
            value_10.frame.Size = fromOffset_upv_1(v77, tbl_upv_2.slotH)
            value_10.label.TextSize = ((UI_upv_1.Compact) and 26) or 28
        end
        u33.Instance.Position = UDim2.new(1, -pad_1, 0, pad_1)
        u33.Instance.AnchorPoint = Vector2.new(1, 0)
        u33.Instance.Size = fromOffset_upv_1(tbl_upv_2.joinW, tbl_upv_2.slotH)
        u33.Label.TextSize = 20
        u31.Position = fromOffset_upv_1(pad_1 + 2, (pad_1 + tbl_upv_2.slotH) + 7)
        u31.Size = fromOffset_upv_1(v69, tbl_upv_2.errH)
        u29.Position = fromOffset_upv_1(0, v76)
        u29.Size = fromOffset_upv_1(left_1, ((pad_1 + tbl_upv_2.slotH) + 7 + tbl_upv_2.errH) + 10)
        u4.CanvasSize = fromOffset_upv_1(0, (v76 + u29.Size.Y.Offset) + 2)
        u35.Size = UDim2.new(1, -210, 0, tbl_upv_2.sectionH)
        u36.Position = UDim2.new(1, -4, 0, ((UI_upv_1.Compact) and 0) or -5)
        u40.Position = fromOffset_upv_1(0, tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
        u40.Size = UDim2.new(1, 0, 1, -(tbl_upv_2.sectionH + tbl_upv_2.sectionGap))
        local v78 = u40:FindFirstChildOfClass("UIListLayout")
        v78.Padding = UDim.new(0, tbl_upv_2.rowGap)
        u48 = v68 - 14
        for _, value_11 in tbl_upv_8 do
            layoutRow(value_11, u48)
        end
        for _, value_12 in tbl_upv_9 do
            value_12.Size = UDim2.new(1, -4, 0, tbl_upv_2.rowH)
        end
        u42.Position = fromOffset_upv_1(0, tbl_upv_2.sectionH + tbl_upv_2.sectionGap + math.max(24, math.floor(v67 * 0.18)))
        u42.Size = UDim2.new(1, 0, 0, 220)
        u3.Refit()
    end
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 1014
              upvalues:
                u3 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if not u3.IsOpen then
                return
            end
            layout()
        end
    )
    UI_upv_1.ScaleChanged:Connect(
        function()
            --[[
              line: 1019
              upvalues:
                u3 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if not u3.IsOpen then
                return
            end
            layout()
        end
    )
    UI_upv_1.Every(
        u3.Root,
        0.9,
        function()
            --[[
              line: 1026
              upvalues:
                u3 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
                u37 (copy, index: 3)
            ]]
            if u3.IsOpen then
                local Tween_1 = UI_upv_1.Tween
                local v79 = TweenInfo.new(0.45, Enum.EasingStyle.Sine)
                local tbl_18 = {BackgroundTransparency = 0}
                tbl_18.BackgroundTransparency = ((u37.BackgroundTransparency < 0.3) and 0.6) or 0
                Tween_1(u37, v79, tbl_18)
            end
        end
    )
    local u58 = 0
    local function startLoop()
        --[[
          name: startLoop
          line: 1034
          upvalues:
            u58 (ref, index: 1)
        ]]
        u58 = u58 + 1
        local _ = u58
        task.spawn(function() end)
    end
    local tbl_19 = {}
    function tbl_19.open()
        --[[
          name: open
          line: 1046
          upvalues:
            a1 (copy, index: 1)
            layout (copy, index: 2)
            u10 (copy, index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            u31 (copy, index: 6)
            u1 (copy, index: 7)
            u17 (ref,  index: 8)
            u25 (copy, index: 9)
            u26 (ref,  index: 10)
            u23 (copy, index: 11)
            u24 (copy, index: 12)
            u22 (copy, index: 13)
            capName (copy, index: 14)
            paintBusy (copy, index: 15)
            u49 (ref,  index: 16)
            u42 (copy, index: 17)
            showSkeletons (copy, index: 18)
            u3 (copy, index: 19)
            u40 (copy, index: 20)
            UI_upv_1 (copy, index: 21)
            u4 (copy, index: 22)
            u34 (copy, index: 23)
            fromOffset_upv_1 (copy, index: 24)
            tbl_upv_2 (ref,  index: 25)
            u58 (ref,  index: 26)
            refresh (copy, index: 27)
            GuiService_upv_1 (copy, index: 28)
            u27 (copy, index: 29)
        ]]
        a1.SetHudHidden("CustomMatches", true)
        layout()
        u10.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
        u31.Text = ""
        if u31.Text == "" or u31.Text == "Ask the host for their code" then
            u31.Text = "Ask the host for their code"
            u31.TextColor3 = u1
        end
        u17(true)
        u25:Set(u26, true)
        u23.Text = u26 and "PUBLIC" or "PRIVATE"
        u24.Text = u26 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
        u22.Text = u26 and "globe-simplified" or "lock-closed"
        capName()
        paintBusy()
        if u49 ~= "ok" then
            u49 = "loading"
            u42.Visible = false
            showSkeletons()
        end
        u3:Open()
        u40.CanvasPosition = Vector2.zero
        UI_upv_1.SlideIn(u4, Vector2.new(-18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
        UI_upv_1.SlideIn(u34, Vector2.new(18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), fromOffset_upv_1(tbl_upv_2.left + tbl_upv_2.gap, 0))
        u58 = u58 + 1
        local u59 = u58
        task.spawn(
            function()
                --[[
                  line: 1037
                  upvalues:
                    u59 (copy, index: 1)
                    u58 (ref,  index: 2)
                    u3 (copy, index: 3)
                    refresh (copy, index: 4)
                    CustomMatch_upv_1 (copy, index: 5)
                ]]
                while u59 == u58 do
                    if u3.IsOpen then
                        refresh(false)
                        task.wait(CustomMatch_upv_1.LIST_REFRESH)
                        continue
                    else
                        break
                    end
                end
            end
        )
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = u27.Instance
    end
    function tbl_19.close(a22)
        --[[
          name: close
          line: 1072
          upvalues:
            a1 (copy, index: 1)
            u58 (ref,  index: 2)
            u53 (ref,  index: 3)
            u32 (copy, index: 4)
            u10 (copy, index: 5)
            GuiService_upv_1 (copy, index: 6)
            u3 (copy, index: 7)
        ]]
        a1.SetHudHidden("CustomMatches", false)
        u58 = u58 + 1
        if u53 then
            u32:ReleaseFocus()
        end
        u10:ReleaseFocus()
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        if SelectedObject_1 then
            local v83 = SelectedObject_1:IsDescendantOf(u3.Root)
            if v83 then
                GuiService_upv_1.SelectedObject = nil
            end
        end
        u3:Close(a22)
    end
    a1.MenuManager.Register("CustomMatches", tbl_19)
    State_1.PlayerStateChanged:Connect(
        function(a23)
            --[[
              line: 1086
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a23 ~= "Match" or not a1.MenuManager.IsOpen("CustomMatches") then
                return
            end
            a1.MenuManager.Close("CustomMatches", true)
        end
    )
    a1.Debug.customMatches = function(a24, a25)
        --[[
          line: 1097
          upvalues:
            a1 (copy, index: 1)
            u58 (ref,  index: 2)
            u49 (ref,  index: 3)
            renderList (copy, index: 4)
            tbl_upv_8 (copy, index: 5)
            u42 (copy, index: 6)
            showSkeletons (copy, index: 7)
            u32 (copy, index: 8)
            showCodeError (copy, index: 9)
            u26 (ref,  index: 10)
            u25 (copy, index: 11)
            u23 (copy, index: 12)
            u24 (copy, index: 13)
            u22 (copy, index: 14)
            u12 (ref,  index: 15)
            CustomMatch_upv_1 (copy, index: 16)
            u17 (ref,  index: 17)
            u10 (copy, index: 18)
            create (copy, index: 19)
            u47 (ref,  index: 20)
            refresh (copy, index: 21)
            u3 (copy, index: 22)
            u31 (copy, index: 23)
            u57 (ref,  index: 24)
            u46 (ref,  index: 25)
        ]]
        if a24 == "open" then
            a1.MenuManager.Open("CustomMatches")
        elseif a24 == "list" and type(a25) == "table" then
            u58 = u58 + 1
            u49 = "ok"
            renderList(a25, true)
        elseif a24 == "error" then
            u58 = u58 + 1
            for key_6, value_13 in tbl_upv_8 do
                value_13.frame:Destroy()
                tbl_upv_8[key_6] = nil
            end
            u49 = "error"
            renderList({}, false)
        elseif a24 == "loading" then
            u58 = u58 + 1
            for key_7, value_14 in tbl_upv_8 do
                value_14.frame:Destroy()
                tbl_upv_8[key_7] = nil
            end
            u49 = "loading"
            u42.Visible = false
            showSkeletons()
        elseif a24 == "code" then
            u32.Text = tostring(a25 or "")
        elseif a24 == "codeError" then
            showCodeError((tostring(a25 or "No custom match has that code")))
        elseif a24 == "focusCode" then
            u32:CaptureFocus()
        elseif a24 == "public" then
            u26 = a25 ~= false
            u25:Set(u26, nil)
            u23.Text = u26 and "PUBLIC" or "PRIVATE"
            u24.Text = u26 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
            u22.Text = u26 and "globe-simplified" or "lock-closed"
        elseif a24 == "mode" then
            u12 = CustomMatch_upv_1.Mode(a25)
            u17()
        elseif a24 == "name" then
            u10.Text = tostring(a25 or "")
        elseif a24 == "create" then
            task.spawn(create)
        elseif a24 == "join" then
            task.spawn(u47, u32.Text, nil)
        elseif a24 == "refresh" then
            task.spawn(refresh, true)
        end
        local v87 = 0
        for _ in tbl_upv_8 do
            v87 = v87 + 1
        end
        local tbl_20 = {}
        tbl_20.open = u3.IsOpen
        tbl_20.rows = v87
        tbl_20.listState = u49
        tbl_20.code = u32.Text
        tbl_20.codeError = u31.Text
        tbl_20.public = u26
        tbl_20.mode = u12
        tbl_20.name = u10.Text
        tbl_20.creating = u57
        tbl_20.joining = u46 or false
        tbl_20.empty = u42.Visible
        tbl_20.size = string.format("%dx%d", u3.Holder.Size.X.Offset, u3.Holder.Size.Y.Offset)
        return tbl_20
    end
end
return tbl_1