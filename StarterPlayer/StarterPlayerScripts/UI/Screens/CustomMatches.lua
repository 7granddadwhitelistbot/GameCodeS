local Players_upv_1 = game:GetService("Players")
local GuiService_upv_1 = game:GetService("GuiService")
local CustomMatch_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local tbl_1 = {}
local _ = {sectionGap = 8, label = true, joinW = 100, left = 400, box = 50, pad = 16, H = 660, thumbW = 128, switchRow = 60, button = 58, errH = 18, sectionH = 24, rowBtn = 108, rowBtnH = 48, text = 18, W = 1120, desc = 15, rowH = 88, rowGap = 8, name = 20, slotH = 56, cardGap = 22, sub = 15, section = 16, gap = 24}
local tbl_upv_2 = {sectionGap = 6, label = false, joinW = 100, left = 380, box = 52, pad = 14, H = 660, thumbW = 112, switchRow = 56, button = 56, errH = 18, sectionH = 24, rowBtn = 112, rowBtnH = 56, text = 18, W = 1120, desc = 14, rowH = 84, rowGap = 8, name = 19, slotH = 58, cardGap = 14, sub = 14, section = 16, gap = 16}
local u1 = Color3.fromRGB(142, 149, 166)
local u2 = Color3.fromRGB(10, 11, 15)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 40
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
          line: 55
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
          line: 62
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
    local u12 = UI_upv_1.new("TextButton", {Text = "", Name = "PublicRow", AutoButtonColor = false, Parent = u6})
    local u13 = UI_upv_1.new("Frame", {Name = "Highlight", BackgroundColor3 = Colors_upv_1.White, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), [1] = UI_upv_1.Corner(10), Parent = u12})
    local u14 = UI_upv_1.Glyph("globe-simplified", 24, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = u12})
    local u15 = UI_upv_1.new("TextLabel", {Name = "Label", Text = "PUBLIC", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u12})
    local u16 = UI_upv_1.new("TextLabel", {Name = "Desc", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u12})
    local u17 = UI_upv_1.Switch({On = true, Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = u12})
    local u18 = true
    local u19 = UI_upv_1.Button({Name = "Create", Text = "CREATE MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("person-plus", 24, Colors_upv_1.Text), Parent = u6})
    local u20 = UI_upv_1.SectionTitle("JOIN WITH A CODE", {Parent = u4})
    local u21 = card("Join", u4)
    local u22 = UI_upv_1.new("TextButton", {Text = "", Name = "Slots", AutoButtonColor = false, Parent = u21})
    local tbl_upv_4 = {}
    for n_1 = 1, CustomMatch_upv_1.CODE_LEN do
        local v1 = UI_upv_1.new("Frame", {Name = "Slot" .. n_1, BackgroundColor3 = u2, BackgroundTransparency = 0.25, [1] = UI_upv_1.Corner(9), Parent = u22})
        local v2 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.86)
        v2.Parent = v1
        tbl_upv_4[n_1] = {
            frame = v1,
            stroke = v2,
            label = UI_upv_1.new("TextLabel", {Name = "Char", Text = "", TextSize = 28, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = v1}),
            caret = UI_upv_1.new("Frame", {Name = "Caret", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -9), Size = fromOffset_upv_1(16, 3), BackgroundColor3 = Colors_upv_1.Accent, Visible = false, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v1})
        }
        local u23 = n_1
    end
    local u24 = UI_upv_1.new("TextBox", {TextTransparency = 1, Text = "", ZIndex = 3, Name = "CodeBox", ClearTextOnFocus = false, BackgroundTransparency = 1, PlaceholderText = "", TextSize = 20, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = u22})
    local u25 = UI_upv_1.Button({Text = "JOIN", Name = "JoinCode", Style = "Primary", Parent = u21})
    local u23 = UI_upv_1.new("TextLabel", {Name = "Error", Text = "", TextSize = 15, FontFace = Fonts_upv_1.Bold, TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Danger, 0.15), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u21})
    local function paintHelp()
        --[[
          name: paintHelp
          line: 233
          upvalues:
            u23 (copy, index: 1)
            u1 (copy, index: 2)
        ]]
        if u23.Text ~= "" and u23.Text ~= "Ask the host for their code" then
            return
        end
        u23.Text = "Ask the host for their code"
        u23.TextColor3 = u1
    end
    local u26 = UI_upv_1.new("Frame", {Name = "Right", Parent = Content_1})
    local u27 = UI_upv_1.SectionTitle("PUBLIC MATCHES", {Parent = u26})
    local u28 = UI_upv_1.new("Frame", {Name = "Live", AnchorPoint = Vector2.new(1, 0), Size = fromOffset_upv_1(200, 24), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = u26})
    local u29 = UI_upv_1.new("Frame", {Name = "Dot", Size = fromOffset_upv_1(8, 8), BackgroundColor3 = Colors_upv_1.Success, LayoutOrder = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u28})
    local u30 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "LIVE", Name = "Text", TextSize = 13, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 20), Parent = u28})
    local paintSlots = UI_upv_1.IconButton({LayoutOrder = 3, Name = "Refresh", Size = fromOffset_upv_1(34, 34), Color = Colors_upv_1.Raised, Parent = u28})
    local u31 = UI_upv_1.Glyph("arrow-spin-clockwise", 20, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = paintSlots})
    local tbl_5 = {}
    tbl_5.Name = "List"
    tbl_5.ScrollBarThickness = 5
    tbl_5.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tbl_5.Selectable = false
    tbl_5[1], tbl_5[2] = UI_upv_1.List(Enum.FillDirection.Vertical, 8), UI_upv_1.Padding(0, 10, 4, 0)
    tbl_5.Parent = u26
    local u32 = UI_upv_1.new("ScrollingFrame", tbl_5)
    local u33 = UI_upv_1.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, -10, 0, 40), BackgroundColor3 = Colors_upv_1.PanelLo, ZIndex = 4, Visible = false, [1] = UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05)), Parent = u26})
    local function updateFade()
        --[[
          name: updateFade
          line: 293
          upvalues:
            u32 (copy, index: 1)
            u33 (copy, index: 2)
        ]]
        u33.Visible = (u32.AbsoluteCanvasSize.Y - (u32.CanvasPosition.Y + u32.AbsoluteWindowSize.Y)) > 2
    end
    u32:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
    u32:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
    u32:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
    local u34 = UI_upv_1.new("Frame", {Visible = false, Name = "Empty", Parent = u26})
    UI_upv_1.Glyph("three-people", 52, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = u34})
    local u35 = UI_upv_1.new("TextLabel", {Text = "No public matches right now", Name = "Title", TextSize = 21, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 64), Size = UDim2.new(1, -40, 0, 26), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = u34})
    local u36 = UI_upv_1.new("TextLabel", {TextWrapped = true, Text = "Create one and it shows up here for everyone. Private matches only take a code.", Name = "Sub", TextSize = 16, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 94), Size = UDim2.new(1, -60, 0, 44), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, Parent = u34})
    local u37 = UI_upv_1.Button({Visible = false, Text = "TRY AGAIN", Name = "Retry", Style = "Dark", TextSize = 18, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 150), Size = fromOffset_upv_1(180, 48), Parent = u34})
    local tbl_upv_6 = {}
    local tbl_upv_7 = {}
    local u38 = nil
    local u39 = nil
    local function makeRow(a4)
        --[[
          name: makeRow
          line: 356
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            u32 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            u1 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            u39 (ref,  index: 8)
        ]]
        local v3 = {}
        v3.Name = "Match_" .. a4.code
        v3.BackgroundColor3 = Colors_upv_1.PanelHi
        v3.BackgroundTransparency = 0.3
        v3[1], v3[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        v3.Parent = u32
        local v4 = UI_upv_1.new("Frame", v3)
        local tbl_8 = {}
        tbl_8.Name = "Thumb"
        tbl_8.ScaleType = Enum.ScaleType.Crop
        tbl_8.BackgroundColor3 = Colors_upv_1.Raised
        tbl_8.BackgroundTransparency = 0
        tbl_8[1] = UI_upv_1.Corner(8)
        tbl_8.Parent = v4
        local v5 = UI_upv_1.new("ImageLabel", tbl_8)
        UI_upv_1.Gradient(Color3.fromRGB(46, 52, 66), Color3.fromRGB(28, 31, 40), 120).Parent = v5
        v3 = UI_upv_1.new("TextLabel", {Visible = false, Name = "Random", Text = "?", TextSize = 34, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextMuted, Parent = v5})
        tbl_8 = UI_upv_1.new("TextLabel", {Name = "MatchName", Text = "", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v4})
        local v6 = UI_upv_1.new("TextLabel", {Name = "Sub", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v4})
        local tbl_9 = {}
        tbl_9.Name = "Players"
        tbl_9.AnchorPoint = Vector2.new(1, 0.5)
        tbl_9.Size = fromOffset_upv_1(96, 22)
        tbl_9[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
        tbl_9.Parent = v4
        local v7 = UI_upv_1.new("Frame", tbl_9)
        local v8 = UI_upv_1.Glyph("person", 17, Colors_upv_1.TextDim, {LayoutOrder = 1, Parent = v7})
        tbl_9 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "", Name = "Count", TextSize = 18, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 22), Parent = v7})
        local tbl_10 = {}
        tbl_10.Name = "Status"
        tbl_10.AnchorPoint = Vector2.new(1, 0.5)
        tbl_10.AutomaticSize = Enum.AutomaticSize.X
        tbl_10.Size = fromOffset_upv_1(0, 22)
        tbl_10[1], tbl_10[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 9, 0, 9)
        tbl_10.Parent = v4
        local v9 = UI_upv_1.new("Frame", tbl_10)
        local v10 = UI_upv_1.new("TextLabel", {Name = "Text", Text = "", TextSize = 13, FontFace = Fonts_upv_1.Heavy, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v9})
        tbl_10 = UI_upv_1.Button({Name = "Join", Text = "JOIN", TextSize = 19, Style = "Primary", AnchorPoint = Vector2.new(1, 0.5), Parent = v4})
        local tbl_upv_11 = {full = false, frame = v4, thumb = v5, random = v3, name = tbl_8, sub = v6, count = tbl_9, people = v8, pill = v9, pillText = v10, button = tbl_10, code = a4.code}
        tbl_10.Activated:Connect(
            function()
                --[[
                  line: 446
                  upvalues:
                    u39 (ref, index: 1)
                    tbl_upv_11 (ref, index: 2)
                ]]
                u39(tbl_upv_11.code, tbl_upv_11)
            end
        )
        return tbl_upv_11
    end
    local function layoutRow(a5, a6)
        --[[
          name: layoutRow
          line: 452
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            fromOffset_upv_1 (copy, index: 2)
        ]]
        local rowH_1 = tbl_upv_2.rowH
        a5.frame.Size = UDim2.new(1, -4, 0, rowH_1)
        local thumbW_1 = tbl_upv_2.thumbW
        local v11 = math.floor((thumbW_1 * 9) / 16)
        a5.thumb.Position = fromOffset_upv_1(10, math.floor((rowH_1 - v11) / 2))
        a5.thumb.Size = fromOffset_upv_1(thumbW_1, v11)
        local v12 = 10 + thumbW_1 + 14
        local v13 = tbl_upv_2.rowBtn + 16 + 96
        a5.name.Position = fromOffset_upv_1(v12, (math.floor(rowH_1 / 2) - tbl_upv_2.name) - 4)
        a5.name.Size = fromOffset_upv_1(math.max(80, (a6 - v12) - v13), tbl_upv_2.name + 4)
        a5.name.TextSize = tbl_upv_2.name
        a5.sub.Position = fromOffset_upv_1(v12, math.floor(rowH_1 / 2) + 3)
        a5.sub.Size = fromOffset_upv_1(math.max(80, (a6 - v12) - v13), tbl_upv_2.sub + 4)
        a5.sub.TextSize = tbl_upv_2.sub
        a5.button.Instance.Position = UDim2.new(1, -12, 0.5, 0)
        a5.button.Instance.Size = fromOffset_upv_1(tbl_upv_2.rowBtn, tbl_upv_2.rowBtnH)
        local v14 = -((12 + tbl_upv_2.rowBtn) + 16)
        a5.count.Parent.Position = UDim2.new(1, v14, 0.5, -12)
        a5.pill.Position = UDim2.new(1, v14, 0.5, 14)
    end
    local function statusLook(a7)
        --[[
          name: statusLook
          line: 347
          upvalues:
            Colors_upv_1 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
        ]]
        if a7 ~= "Match" then
            return "LOBBY", Colors_upv_1.Success:Lerp(Colors_upv_1.Panel, 0.78), Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1)
        end
        return "IN MATCH", Colors_upv_1.Warning:Lerp(Colors_upv_1.Panel, 0.78), Theme_upv_1.Lighten(Colors_upv_1.Warning, 0.1)
    end
    local function paintRow(a8, a9, a10)
        --[[
          name: paintRow
          line: 475
          upvalues:
            statusLook (copy, index: 1)
            u38 (ref,  index: 2)
        ]]
        a8.name.AutoLocalize = false
        a8.name.Text = a9.name
        local v15
        if type(a9.host) ~= "string" or a9.host == "" then
            v15 = ""
        else
            v15 = "  \194\183  " .. a9.host
        end
        a8.sub.Text = string.upper(a9.mapName or "Random") .. v15
        if type(a9.thumb) ~= "string" or a9.thumb == "" then
            a8.thumb.Image = ""
            a8.random.Visible = true
        else
            a8.thumb.Image = a9.thumb
            a8.random.Visible = false
        end
        a8.count.Text = string.format("%d/%d", a9.players, a9.max)
        local v16, v17, v18 = statusLook(a9.status)
        a8.pillText.Text = v16
        a8.pillText.TextColor3 = v18
        a8.pill.BackgroundColor3 = v17
        a8.full = a9.max <= a9.players
        a8.frame.LayoutOrder = a10
        if u38 == a9.code then
            a8.button:SetText("JOINING...")
            a8.button:SetEnabled(false)
        elseif a8.full then
            a8.button:SetText("FULL")
            a8.button:SetEnabled(false)
        else
            a8.button:SetText("JOIN")
            a8.button:SetEnabled(u38 == nil)
        end
    end
    local u40 = 600
    local u41 = "loading"
    local u42 = {}
    local function clearSkeletons()
        --[[
          name: clearSkeletons
          line: 509
          upvalues:
            tbl_upv_7 (copy, index: 1)
        ]]
        for _, value_1 in tbl_upv_7 do
            value_1:Destroy()
        end
        table.clear(tbl_upv_7)
    end
    local function showSkeletons()
        --[[
          name: showSkeletons
          line: 515
          upvalues:
            tbl_upv_7 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_2 (ref,  index: 3)
            Colors_upv_1 (copy, index: 4)
            u32 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
        ]]
        for _, value_2 in tbl_upv_7 do
            value_2:Destroy()
        end
        table.clear(tbl_upv_7)
        for n_2 = 1, 3 do
            local v19 = UI_upv_1.new("Frame", {Name = "Skeleton" .. n_2, Size = UDim2.new(1, -4, 0, tbl_upv_2.rowH), BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, LayoutOrder = n_2, [1] = UI_upv_1.Corner(12), Parent = u32})
            local v20 = math.floor((tbl_upv_2.thumbW * 9) / 16)
            UI_upv_1.new("Frame", {Position = fromOffset_upv_1(10, math.floor((tbl_upv_2.rowH - v20) / 2)), Size = fromOffset_upv_1(tbl_upv_2.thumbW, v20), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(8), Parent = v19})
            UI_upv_1.new("Frame", {Position = fromOffset_upv_1(tbl_upv_2.thumbW + 24, math.floor(tbl_upv_2.rowH / 2) - 20), Size = fromOffset_upv_1(200, 14), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v19})
            UI_upv_1.new("Frame", {Position = fromOffset_upv_1(tbl_upv_2.thumbW + 24, math.floor(tbl_upv_2.rowH / 2) + 6), Size = fromOffset_upv_1(130, 10), BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v19})
            local tbl_12 = {BackgroundTransparency = 0.72}
            UI_upv_1.Tween(v19, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, n_2 * 0.12), tbl_12)
            table.insert(tbl_upv_7, v19)
        end
    end
    local function renderList(a11, a12)
        --[[
          name: renderList
          line: 536
          upvalues:
            u42 (ref,  index: 1)
            tbl_upv_7 (copy, index: 2)
            tbl_upv_6 (copy, index: 3)
            makeRow (copy, index: 4)
            layoutRow (copy, index: 5)
            u40 (ref,  index: 6)
            paintRow (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u27 (copy, index: 9)
            u34 (copy, index: 10)
            u41 (ref,  index: 11)
            u35 (copy, index: 12)
            u36 (copy, index: 13)
            u37 (copy, index: 14)
            u30 (copy, index: 15)
            u29 (copy, index: 16)
            Colors_upv_1 (copy, index: 17)
            updateFade (copy, index: 18)
        ]]
        u42 = a11
        for _, value_3 in tbl_upv_7 do
            value_3:Destroy()
        end
        table.clear(tbl_upv_7)
        local tbl_13 = {}
        local v21, v22 = nil, nil
        for key_1, value_4 in a11 do
            if type(value_4) ~= "table" or type(value_4.code) ~= "string" then
                continue
            end
            tbl_13[value_4.code] = true
            v21 = tbl_upv_6[value_4.code]
            v22 = false
            if not v21 then
                v21 = makeRow(value_4)
                tbl_upv_6[value_4.code] = v21
                v22 = true
            end
            layoutRow(v21, u40)
            paintRow(v21, value_4, key_1)
            if not (v22) then
                continue
            end
            if a12 then
                UI_upv_1.Enter(v21.frame, Vector2.new(0, 12), math.min(key_1 * 0.035, 0.25), UDim2.new())
            end
        end
        for key_2, value_5 in tbl_upv_6 do
            if not (tbl_13[key_2]) then
                value_5.frame:Destroy()
                tbl_upv_6[key_2] = nil
            end
        end
        local v24 = 0
        for _ in tbl_upv_6 do
            v24 = v24 + 1
        end
        local Text_1 = u27.Text
        Text_1.Text = not (v24 > 0) and "PUBLIC MATCHES" or string.format("PUBLIC MATCHES  \194\183  %d", v24)
        u34.Visible = v24 == 0 and u41 ~= "loading"
        u35.Text = u41 ~= "error" and "No public matches right now" or "Couldn't load public matches"
        u36.Text = u41 ~= "error" and "Create one and it shows up here for everyone. Private matches only take a code." or "Check your connection and try again. Joining with a code still works."
        u37.Instance.Visible = u41 == "error"
        u30.Text = u41 ~= "error" and "LIVE" or "OFFLINE"
        local v31
        if u41 ~= "error" then
            v31 = Colors_upv_1.Success
        else
            v31 = Colors_upv_1.TextMuted
        end
        u29.BackgroundColor3 = v31
        task.defer(updateFade)
    end
    local u43 = false
    local u44 = 0
    local function refresh(a13)
        --[[
          name: refresh
          line: 582
          upvalues:
            u43 (ref,  index: 1)
            u44 (ref,  index: 2)
            u31 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            Custom_upv_1 (copy, index: 5)
            u3 (copy, index: 6)
            u41 (ref,  index: 7)
            renderList (copy, index: 8)
            tbl_upv_6 (copy, index: 9)
            u42 (ref,  index: 10)
        ]]
        if u43 or not (a13) and os.clock() - u44 < 2 then
            return
        end
        u43 = true
        u44 = os.clock()
        local _ = os.clock()
        u31.Rotation = 0
        local tbl_14 = {Rotation = 360}
        UI_upv_1.Tween(u31, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_14)
        local v32, v33 = Custom_upv_1.Action("List")
        u43 = false
        if not u3.IsOpen then
            return
        end
        if v32 and type(v33) == "table" and type(v33.list) == "table" then
            local v34 = u41 ~= "ok"
            u41 = "ok"
            renderList(v33.list, v34)
            return
        end
        local v35 = ((next(tbl_upv_6)) and "ok") or "error"
        u41 = v35
        renderList(u42, false)
    end
    paintSlots.Activated:Connect(
        function()
            --[[
              line: 606
              upvalues:
                refresh (copy, index: 1)
            ]]
            refresh(true)
        end
    )
    u37.Activated:Connect(
        function()
            --[[
              line: 609
              upvalues:
                u41 (ref,  index: 1)
                u34 (copy, index: 2)
                showSkeletons (copy, index: 3)
                refresh (copy, index: 4)
            ]]
            u41 = "loading"
            u34.Visible = false
            showSkeletons()
            refresh(true)
        end
    )
    local u45 = false
    local u46 = 0
    paintSlots = function()
        --[[
          name: paintSlots
          line: 619
          upvalues:
            u24 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            u45 (ref,  index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u25 (copy, index: 6)
            u38 (ref,  index: 7)
        ]]
        local Text_2 = u24.Text
        local v36 = #Text_2
        local v37 = nil
        local v38 = nil
        for key_3, value_6 in tbl_upv_4 do
            local v39 = string.sub(Text_2, key_3, key_3)
            value_6.label.Text = v39
            v37 = u45
            if v37 then
                v37 = true
                if key_3 ~= v36 + 1 then
                    v37 = (v36 == CustomMatch_upv_1.CODE_LEN) and (key_3 == v36)
                end
            end
            value_6.caret.Visible = u45 and (key_3 == v36 + 1)
            local stroke_1 = value_6.stroke
            if v37 then
                v38 = Colors_upv_1.Accent
                stroke_1.Color = v38
                value_6.stroke.Transparency = (v37 and 0.1) or (((v39 == "") and 0.86) or 0.7)
                continue
            end
            if v39 == "" or v39 ~= "" then
                v38 = Colors_upv_1.Stroke
                stroke_1.Color = v38
                value_6.stroke.Transparency = (v37 and 0.1) or (((v39 == "") and 0.86) or 0.7)
            end
        end
        local v40 = (v36 == CustomMatch_upv_1.CODE_LEN) and (u38 == nil)
        u25:SetEnabled(v40)
    end
    local u47 = false
    u24:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 633
              upvalues:
                u47 (ref,  index: 1)
                CustomMatch_upv_1 (copy, index: 2)
                u24 (copy, index: 3)
                u23 (copy, index: 4)
                u1 (copy, index: 5)
                tbl_upv_4 (copy, index: 6)
                UI_upv_1 (copy, index: 7)
                paintSlots (copy, index: 8)
            ]]
            if u47 then
                return
            end
            local v41 = CustomMatch_upv_1.CleanCode(u24.Text)
            if v41 ~= u24.Text then
                u47 = true
                u24.Text = v41
                u24.CursorPosition = #v41 + 1
                u47 = false
            end
            if u23.Text ~= "Ask the host for their code" then
                u23.Text = ""
                if u23.Text == "" or u23.Text == "Ask the host for their code" then
                    u23.Text = "Ask the host for their code"
                    u23.TextColor3 = u1
                end
            end
            local v42 = #v41
            local v43 = tbl_upv_4[v42]
            if v43 and v42 > 0 then
                UI_upv_1.Bump(v43.label, 0.18)
            end
            paintSlots()
        end
    )
    u24.Focused:Connect(
        function()
            --[[
              line: 655
              upvalues:
                u45 (ref,  index: 1)
                paintSlots (copy, index: 2)
            ]]
            u45 = true
            paintSlots()
        end
    )
    u24.FocusLost:Connect(
        function(a14)
            --[[
              line: 659
              upvalues:
                u45 (ref,  index: 1)
                paintSlots (copy, index: 2)
                u24 (copy, index: 3)
                CustomMatch_upv_1 (copy, index: 4)
                u39 (ref,  index: 5)
            ]]
            u45 = false
            paintSlots()
            if not a14 or #u24.Text ~= CustomMatch_upv_1.CODE_LEN then
                return
            end
            u39(u24.Text, nil)
        end
    )
    UI_upv_1.Every(
        u3.Root,
        0.5,
        function()
            --[[
              line: 667
              upvalues:
                u45 (ref,  index: 1)
                u24 (copy, index: 2)
                tbl_upv_4 (copy, index: 3)
            ]]
            if u45 then
                local v44 = tbl_upv_4[#u24.Text + 1]
                if not v44 then
                    return
                end
                v44.caret.BackgroundTransparency = ((v44.caret.BackgroundTransparency < 0.5) and 1) or 0
            end
        end
    )
    local function showCodeError(a15)
        --[[
          name: showCodeError
          line: 677
          upvalues:
            u46 (ref,  index: 1)
            u23 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u22 (copy, index: 6)
            a1 (copy, index: 7)
            tbl_upv_4 (copy, index: 8)
            paintSlots (copy, index: 9)
        ]]
        u46 = u46 + 1
        local u48 = u46
        u23.Text = a15
        u23.TextColor3 = Theme_upv_1.Lighten(Colors_upv_1.Danger, 0.15)
        UI_upv_1.Shake(u22, 8)
        a1.Sounds.Play("Error")
        for _, value_7 in tbl_upv_4 do
            value_7.stroke.Color = Colors_upv_1.Danger
            value_7.stroke.Transparency = 0.15
        end
        task.delay(
            1.2,
            function()
                --[[
                  line: 688
                  upvalues:
                    u48 (copy, index: 1)
                    u46 (ref,  index: 2)
                    paintSlots (copy, index: 3)
                ]]
                if u48 ~= u46 then
                    return
                end
                paintSlots()
            end
        )
    end
    local u49 = false
    local function paintBusy()
        --[[
          name: paintBusy
          line: 697
          upvalues:
            u19 (copy, index: 1)
            u49 (ref,  index: 2)
            u38 (ref,  index: 3)
            u25 (copy, index: 4)
            u24 (copy, index: 5)
            paintSlots (copy, index: 6)
            tbl_upv_6 (copy, index: 7)
            u42 (ref,  index: 8)
            paintRow (copy, index: 9)
        ]]
        local v45 = (u49 and "CREATING...") or "CREATE MATCH"
        u19:SetText(v45)
        v45 = not u49 and (u38 == nil)
        u19:SetEnabled(v45)
        if u38 == nil or u38 ~= u24.Text then
            v45 = "JOIN"
        else
            v45 = "..."
        end
        u25:SetText(v45)
        paintSlots()
        for key_4, value_8 in tbl_upv_6 do
            for _, value_9 in u42 do
                if value_9.code == key_4 then
                    paintRow(value_8, value_9, value_8.frame.LayoutOrder)
                end
            end
        end
    end
    u39 = function(a16, a17)
        --[[
          line: 711
          upvalues:
            u38 (ref,  index: 1)
            u49 (ref,  index: 2)
            CustomMatch_upv_1 (copy, index: 3)
            showCodeError (copy, index: 4)
            paintBusy (copy, index: 5)
            Custom_upv_1 (copy, index: 6)
            a1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            refresh (copy, index: 9)
        ]]
        if (u38) then
            return
        end
        if not (u49) then
            local v46 = CustomMatch_upv_1.ValidCode(a16)
            if v46 then
                u38 = v46
                paintBusy()
                local v47, v48 = Custom_upv_1.Action("Join", v46)
                u38 = nil
                paintBusy()
                if v47 then
                    a1.Sounds.Play("Queue_Join")
                    a1.MenuManager.Close("CustomMatches")
                else
                    local str_1 = tostring(v48 or "Couldn't join that match")
                    if a17 then
                        a1.Toast(str_1, "error")
                        UI_upv_1.Shake(a17.frame, 6)
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
    u25.Activated:Connect(
        function()
            --[[
              line: 739
              upvalues:
                u39 (ref,  index: 1)
                u24 (copy, index: 2)
            ]]
            u39(u24.Text, nil)
        end
    )
    u22.Activated:Connect(
        function()
            --[[
              line: 742
              upvalues:
                u24 (copy, index: 1)
            ]]
            u24:CaptureFocus()
        end
    )
    local function create()
        --[[
          name: create
          line: 746
          upvalues:
            u49 (ref,  index: 1)
            u38 (ref,  index: 2)
            paintBusy (copy, index: 3)
            Custom_upv_1 (copy, index: 4)
            u10 (copy, index: 5)
            u18 (ref,  index: 6)
            a1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u19 (copy, index: 9)
            u9 (copy, index: 10)
            Colors_upv_1 (copy, index: 11)
        ]]
        if (u49) then
            return
        end
        if not (u38) then
            u49 = true
            paintBusy()
            local v49, v50 = Custom_upv_1.Action("Create", {name = u10.Text, public = u18})
            u49 = false
            paintBusy()
            if v49 then
                a1.Sounds.Play("Queue_Join")
                a1.MenuManager.Close("CustomMatches")
            else
                a1.Toast(tostring(v50 or "Couldn't create the match"), "error")
                UI_upv_1.Shake(u19.Instance, 6)
                if type(v50) == "string" and (string.find(v50, "name", 1, true) or string.find(v50, "Name", 1, true)) then
                    u9.Color = Colors_upv_1.Danger
                    u9.Transparency = 0.15
                    task.delay(
                        1.4,
                        function()
                            --[[
                              line: 765
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
    u19.Activated:Connect(create)
    local function paintPublic(a18)
        --[[
          name: paintPublic
          line: 773
          upvalues:
            u17 (copy, index: 1)
            u18 (ref,  index: 2)
            u15 (copy, index: 3)
            u16 (copy, index: 4)
            u14 (copy, index: 5)
        ]]
        u17:Set(u18, a18)
        u15.Text = u18 and "PUBLIC" or "PRIVATE"
        u16.Text = u18 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
        u14.Text = u18 and "globe-simplified" or "lock-closed"
    end
    u12.Activated:Connect(
        function()
            --[[
              line: 779
              upvalues:
                u18 (ref,  index: 1)
                a1 (copy, index: 2)
                u17 (copy, index: 3)
                u15 (copy, index: 4)
                u16 (copy, index: 5)
                u14 (copy, index: 6)
            ]]
            u18 = not u18
            local Play_1 = a1.Sounds.Play
            local tbl_15 = {pitch = 0}
            tbl_15.pitch = (u18 and 1.08) or 0.94
            Play_1("Click", tbl_15)
            u17:Set(u18, nil)
            u15.Text = u18 and "PUBLIC" or "PRIVATE"
            u16.Text = u18 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
            u14.Text = u18 and "globe-simplified" or "lock-closed"
        end
    )
    u12.MouseEnter:Connect(
        function()
            --[[
              line: 784
              upvalues:
                UI_upv_1 (copy, index: 1)
                u13 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            if (UI_upv_1.Touch) then
                return
            end
            UI_upv_1.Tween(u13, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.955})
        end
    )
    u12.MouseLeave:Connect(
        function()
            --[[
              line: 789
              upvalues:
                UI_upv_1 (copy, index: 1)
                u13 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
            ]]
            UI_upv_1.Tween(u13, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 1})
        end
    )
    local function capName()
        --[[
          name: capName
          line: 793
          upvalues:
            u10 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            u11 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local Text_3 = u10.Text
        local v57 = utf8.len(Text_3) or (#Text_3)
        if CustomMatch_upv_1.NAME_MAX < v57 then
            local v58 = utf8.offset(Text_3, CustomMatch_upv_1.NAME_MAX + 1) or (#Text_3 + 1)
            u10.Text = string.sub(Text_3, 1, v58 - 1)
        else
            u11.Text = string.format("%d/%d", v57, CustomMatch_upv_1.NAME_MAX)
            local v59
            if CustomMatch_upv_1.NAME_MAX <= v57 then
                v59 = Colors_upv_1.Warning
            else
                v59 = Colors_upv_1.TextMuted
            end
            u11.TextColor3 = v59
        end
    end
    u10:GetPropertyChangedSignal("Text"):Connect(capName)
    u10.Focused:Connect(
        function()
            --[[
              line: 805
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
        function(a19)
            --[[
              line: 808
              upvalues:
                UI_upv_1 (copy, index: 1)
                u9 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
                Colors_upv_1 (copy, index: 4)
                create (copy, index: 5)
            ]]
            UI_upv_1.Tween(u9, Theme_upv_1.Tween.Fast, {Transparency = 0.88, Color = Colors_upv_1.Stroke})
            if not a19 then
                return
            end
            create()
        end
    )
    local function layout()
        --[[
          name: layout
          line: 816
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            u3 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            u4 (copy, index: 7)
            u26 (copy, index: 8)
            u5 (copy, index: 9)
            u7 (copy, index: 10)
            u8 (copy, index: 11)
            u10 (copy, index: 12)
            u12 (copy, index: 13)
            u14 (copy, index: 14)
            u15 (copy, index: 15)
            u16 (copy, index: 16)
            u17 (copy, index: 17)
            u19 (copy, index: 18)
            u6 (copy, index: 19)
            u20 (copy, index: 20)
            CustomMatch_upv_1 (copy, index: 21)
            u22 (copy, index: 22)
            tbl_upv_4 (copy, index: 23)
            u25 (copy, index: 24)
            u23 (copy, index: 25)
            u21 (copy, index: 26)
            u27 (copy, index: 27)
            u28 (copy, index: 28)
            u32 (copy, index: 29)
            u40 (ref,  index: 30)
            tbl_upv_6 (copy, index: 31)
            layoutRow (copy, index: 32)
            tbl_upv_7 (copy, index: 33)
            u34 (copy, index: 34)
        ]]
        local v60 = UI_upv_1.CanvasSize()
        local v61 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            u3.Holder.Size = fromOffset_upv_1(math.floor(math.min(tbl_upv_2.W, v60.X - 24)), math.floor(math.min(tbl_upv_2.H, (v60.Y - v61) - 12)))
        else
            u3.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v60.X - 240, tbl_upv_2.W, 1240)), math.floor(math.clamp((v60.Y - v61) - 110, 620, 680)))
        end
        u3.Subtitle.TextSize = ((UI_upv_1.Compact) and 15) or 17
        local v62 = u3.Holder.Size.Y.Offset - 80 - 32
        local left_1 = tbl_upv_2.left
        u4.Size = fromOffset_upv_1(left_1, v62)
        u26.Position = fromOffset_upv_1(left_1 + tbl_upv_2.gap, 0)
        local v63 = (u3.Holder.Size.X.Offset - 44) - left_1 - tbl_upv_2.gap
        u26.Size = fromOffset_upv_1(v63, v62)
        local pad_1 = tbl_upv_2.pad
        local v64 = left_1 - pad_1 * 2
        u5.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        u5.Position = fromOffset_upv_1(0, 0)
        local v65 = pad_1
        u7.Visible = tbl_upv_2.label
        if tbl_upv_2.label then
            u7.Position = fromOffset_upv_1(pad_1 + 2, v65)
            u7.Size = fromOffset_upv_1(v64, 16)
            v65 = v65 + 22
        end
        u8.Position = fromOffset_upv_1(pad_1, v65)
        u8.Size = fromOffset_upv_1(v64, tbl_upv_2.box)
        u10.Size = UDim2.new(1, -84, 1, 0)
        u10.TextSize = tbl_upv_2.text
        local v66 = v65 + (tbl_upv_2.box + 10)
        u12.Position = fromOffset_upv_1(pad_1 - 6, v66)
        u12.Size = fromOffset_upv_1(v64 + 12, tbl_upv_2.switchRow)
        u14.Position = UDim2.new(0, 8, 0.5, 0)
        u15.Position = fromOffset_upv_1(42, (math.floor(tbl_upv_2.switchRow / 2) - tbl_upv_2.text) - 1)
        u15.Size = fromOffset_upv_1(v64 - 110, tbl_upv_2.text + 2)
        u15.TextSize = tbl_upv_2.text
        u16.Position = fromOffset_upv_1(42, math.floor(tbl_upv_2.switchRow / 2) + 2)
        u16.Size = fromOffset_upv_1(v64 - 110, tbl_upv_2.desc + 2)
        u16.TextSize = tbl_upv_2.desc
        u17.Instance.Position = UDim2.new(1, -8, 0.5, 0)
        local v67 = v66 + (tbl_upv_2.switchRow + 10)
        u19.Instance.Position = fromOffset_upv_1(pad_1, v67)
        u19.Instance.Size = fromOffset_upv_1(v64, tbl_upv_2.button)
        u19.Label.TextSize = ((UI_upv_1.Compact) and 22) or 24
        local v68 = v67 + (tbl_upv_2.button + pad_1)
        local v69 = tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        u6.Position = fromOffset_upv_1(0, v69)
        u6.Size = fromOffset_upv_1(left_1, v68)
        local v70 = v69 + v68 + tbl_upv_2.cardGap
        u20.Position = fromOffset_upv_1(0, v70)
        u20.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        local v71 = v70 + tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        local v72 = math.floor((((v64 - tbl_upv_2.joinW) - 12 - (5 * (CustomMatch_upv_1.CODE_LEN - 2))) - 14) / CustomMatch_upv_1.CODE_LEN)
        u22.Position = fromOffset_upv_1(pad_1, pad_1)
        u22.Size = fromOffset_upv_1(((v72 * CustomMatch_upv_1.CODE_LEN) + (5 * (CustomMatch_upv_1.CODE_LEN - 2))) + 14, tbl_upv_2.slotH)
        for key_5, value_10 in tbl_upv_4 do
            value_10.frame.Position = fromOffset_upv_1(((key_5 - 1) * (v72 + 5)) + (((CustomMatch_upv_1.CODE_LEN // 2 < key_5) and 9) or 0), 0)
            value_10.frame.Size = fromOffset_upv_1(v72, tbl_upv_2.slotH)
            value_10.label.TextSize = ((UI_upv_1.Compact) and 26) or 28
        end
        u25.Instance.Position = UDim2.new(1, -pad_1, 0, pad_1)
        u25.Instance.AnchorPoint = Vector2.new(1, 0)
        u25.Instance.Size = fromOffset_upv_1(tbl_upv_2.joinW, tbl_upv_2.slotH)
        u25.Label.TextSize = 20
        u23.Position = fromOffset_upv_1(pad_1 + 2, (pad_1 + tbl_upv_2.slotH) + 7)
        u23.Size = fromOffset_upv_1(v64, tbl_upv_2.errH)
        u21.Position = fromOffset_upv_1(0, v71)
        u21.Size = fromOffset_upv_1(left_1, ((pad_1 + tbl_upv_2.slotH) + 7 + tbl_upv_2.errH) + 10)
        u4.CanvasSize = fromOffset_upv_1(0, (v71 + u21.Size.Y.Offset) + 2)
        u27.Size = UDim2.new(1, -210, 0, tbl_upv_2.sectionH)
        u28.Position = UDim2.new(1, -4, 0, ((UI_upv_1.Compact) and 0) or -5)
        u32.Position = fromOffset_upv_1(0, tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
        u32.Size = UDim2.new(1, 0, 1, -(tbl_upv_2.sectionH + tbl_upv_2.sectionGap))
        local v73 = u32:FindFirstChildOfClass("UIListLayout")
        v73.Padding = UDim.new(0, tbl_upv_2.rowGap)
        u40 = v63 - 14
        for _, value_11 in tbl_upv_6 do
            layoutRow(value_11, u40)
        end
        for _, value_12 in tbl_upv_7 do
            value_12.Size = UDim2.new(1, -4, 0, tbl_upv_2.rowH)
        end
        u34.Position = fromOffset_upv_1(0, tbl_upv_2.sectionH + tbl_upv_2.sectionGap + math.max(24, math.floor(v62 * 0.18)))
        u34.Size = UDim2.new(1, 0, 0, 220)
        u3.Refit()
    end
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 915
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
              line: 920
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
              line: 927
              upvalues:
                u3 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
                u29 (copy, index: 3)
            ]]
            if u3.IsOpen then
                local Tween_1 = UI_upv_1.Tween
                local v74 = TweenInfo.new(0.45, Enum.EasingStyle.Sine)
                local tbl_16 = {BackgroundTransparency = 0}
                tbl_16.BackgroundTransparency = ((u29.BackgroundTransparency < 0.3) and 0.6) or 0
                Tween_1(u29, v74, tbl_16)
            end
        end
    )
    local u50 = 0
    local function startLoop()
        --[[
          name: startLoop
          line: 935
          upvalues:
            u50 (ref, index: 1)
        ]]
        u50 = u50 + 1
        local _ = u50
        task.spawn(function() end)
    end
    local tbl_17 = {}
    function tbl_17.open()
        --[[
          name: open
          line: 947
          upvalues:
            a1 (copy, index: 1)
            layout (copy, index: 2)
            u10 (copy, index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            u23 (copy, index: 6)
            u1 (copy, index: 7)
            u17 (copy, index: 8)
            u18 (ref,  index: 9)
            u15 (copy, index: 10)
            u16 (copy, index: 11)
            u14 (copy, index: 12)
            capName (copy, index: 13)
            paintBusy (copy, index: 14)
            u41 (ref,  index: 15)
            u34 (copy, index: 16)
            showSkeletons (copy, index: 17)
            u3 (copy, index: 18)
            u32 (copy, index: 19)
            UI_upv_1 (copy, index: 20)
            u4 (copy, index: 21)
            u26 (copy, index: 22)
            fromOffset_upv_1 (copy, index: 23)
            tbl_upv_2 (ref,  index: 24)
            u50 (ref,  index: 25)
            refresh (copy, index: 26)
            GuiService_upv_1 (copy, index: 27)
            u19 (copy, index: 28)
        ]]
        a1.SetHudHidden("CustomMatches", true)
        layout()
        u10.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
        u23.Text = ""
        if u23.Text == "" or u23.Text == "Ask the host for their code" then
            u23.Text = "Ask the host for their code"
            u23.TextColor3 = u1
        end
        u17:Set(u18, true)
        u15.Text = u18 and "PUBLIC" or "PRIVATE"
        u16.Text = u18 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
        u14.Text = u18 and "globe-simplified" or "lock-closed"
        capName()
        paintBusy()
        if u41 ~= "ok" then
            u41 = "loading"
            u34.Visible = false
            showSkeletons()
        end
        u3:Open()
        u32.CanvasPosition = Vector2.zero
        UI_upv_1.SlideIn(u4, Vector2.new(-18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
        UI_upv_1.SlideIn(u26, Vector2.new(18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), fromOffset_upv_1(tbl_upv_2.left + tbl_upv_2.gap, 0))
        u50 = u50 + 1
        local u51 = u50
        task.spawn(
            function()
                --[[
                  line: 938
                  upvalues:
                    u51 (copy, index: 1)
                    u50 (ref,  index: 2)
                    u3 (copy, index: 3)
                    refresh (copy, index: 4)
                    CustomMatch_upv_1 (copy, index: 5)
                ]]
                while u51 == u50 do
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
        GuiService_upv_1.SelectedObject = u19.Instance
    end
    function tbl_17.close(a20)
        --[[
          name: close
          line: 972
          upvalues:
            a1 (copy, index: 1)
            u50 (ref,  index: 2)
            u45 (ref,  index: 3)
            u24 (copy, index: 4)
            u10 (copy, index: 5)
            GuiService_upv_1 (copy, index: 6)
            u3 (copy, index: 7)
        ]]
        a1.SetHudHidden("CustomMatches", false)
        u50 = u50 + 1
        if u45 then
            u24:ReleaseFocus()
        end
        u10:ReleaseFocus()
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        if SelectedObject_1 then
            local v78 = SelectedObject_1:IsDescendantOf(u3.Root)
            if v78 then
                GuiService_upv_1.SelectedObject = nil
            end
        end
        u3:Close(a20)
    end
    a1.MenuManager.Register("CustomMatches", tbl_17)
    State_1.PlayerStateChanged:Connect(
        function(a21)
            --[[
              line: 986
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a21 ~= "Match" or not a1.MenuManager.IsOpen("CustomMatches") then
                return
            end
            a1.MenuManager.Close("CustomMatches", true)
        end
    )
    a1.Debug.customMatches = function(a22, a23)
        --[[
          line: 996
          upvalues:
            a1 (copy, index: 1)
            u50 (ref,  index: 2)
            u41 (ref,  index: 3)
            renderList (copy, index: 4)
            tbl_upv_6 (copy, index: 5)
            u34 (copy, index: 6)
            showSkeletons (copy, index: 7)
            u24 (copy, index: 8)
            showCodeError (copy, index: 9)
            u18 (ref,  index: 10)
            u17 (copy, index: 11)
            u15 (copy, index: 12)
            u16 (copy, index: 13)
            u14 (copy, index: 14)
            u10 (copy, index: 15)
            create (copy, index: 16)
            u39 (ref,  index: 17)
            refresh (copy, index: 18)
            u3 (copy, index: 19)
            u23 (copy, index: 20)
            u49 (ref,  index: 21)
            u38 (ref,  index: 22)
        ]]
        if a22 == "open" then
            a1.MenuManager.Open("CustomMatches")
        elseif a22 == "list" and type(a23) == "table" then
            u50 = u50 + 1
            u41 = "ok"
            renderList(a23, true)
        elseif a22 == "error" then
            u50 = u50 + 1
            for key_6, value_13 in tbl_upv_6 do
                value_13.frame:Destroy()
                tbl_upv_6[key_6] = nil
            end
            u41 = "error"
            renderList({}, false)
        elseif a22 == "loading" then
            u50 = u50 + 1
            for key_7, value_14 in tbl_upv_6 do
                value_14.frame:Destroy()
                tbl_upv_6[key_7] = nil
            end
            u41 = "loading"
            u34.Visible = false
            showSkeletons()
        elseif a22 == "code" then
            u24.Text = tostring(a23 or "")
        elseif a22 == "codeError" then
            showCodeError((tostring(a23 or "No custom match has that code")))
        elseif a22 == "focusCode" then
            u24:CaptureFocus()
        elseif a22 == "public" then
            u18 = a23 ~= false
            u17:Set(u18, nil)
            u15.Text = u18 and "PUBLIC" or "PRIVATE"
            u16.Text = u18 and "Anyone in a lobby can find and join it" or "Only people with your code can join"
            u14.Text = u18 and "globe-simplified" or "lock-closed"
        elseif a22 == "name" then
            u10.Text = tostring(a23 or "")
        elseif a22 == "create" then
            task.spawn(create)
        elseif a22 == "join" then
            task.spawn(u39, u24.Text, nil)
        elseif a22 == "refresh" then
            task.spawn(refresh, true)
        end
        local v82 = 0
        for _ in tbl_upv_6 do
            v82 = v82 + 1
        end
        local tbl_18 = {}
        tbl_18.open = u3.IsOpen
        tbl_18.rows = v82
        tbl_18.listState = u41
        tbl_18.code = u24.Text
        tbl_18.codeError = u23.Text
        tbl_18.public = u18
        tbl_18.name = u10.Text
        tbl_18.creating = u49
        tbl_18.joining = u38 or false
        tbl_18.empty = u34.Visible
        tbl_18.size = string.format("%dx%d", u3.Holder.Size.X.Offset, u3.Holder.Size.Y.Offset)
        return tbl_18
    end
end
return tbl_1