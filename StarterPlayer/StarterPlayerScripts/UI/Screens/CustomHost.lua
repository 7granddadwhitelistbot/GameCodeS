local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local GuiService_upv_1 = game:GetService("GuiService")
local TextService_upv_1 = game:GetService("TextService")
local CustomMatch_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local Keybinds_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local tbl_1 = {}
local _ = {sectionGap = 8, seatGap = 6, label = 18, left = 410, pad = 16, H = 700, teamGap = 12, leaveH = 50, status = 18, moreW = 38, head = 36, hint = 16, seatH = 56, sectionHint = 14, sectionH = 24, playerSub = 13, playerName = 17, mapCols = 4, W = 1180, desc = 15, rowH = 62, switchW = 58, teamHead = 40, mapName = 16, blockGap = 20, button = 60, mapGap = 12, gap = 24}
local tbl_upv_2 = {sectionGap = 6, seatGap = 6, label = 17, left = 390, pad = 14, H = 700, teamGap = 10, leaveH = 54, status = 17, moreW = 46, head = 38, hint = 15, seatH = 60, sectionHint = 14, sectionH = 24, playerSub = 13, playerName = 17, mapCols = 3, W = 1180, desc = 14, rowH = 56, switchW = 58, teamHead = 40, mapName = 15, blockGap = 14, button = 54, mapGap = 10, gap = 16}
local u1 = Color3.fromRGB(142, 149, 166)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 51
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        u1 (copy, index: 4)
        CustomMatch_upv_1 (copy, index: 5)
        TextService_upv_1 (copy, index: 6)
        UserInputService_upv_1 (copy, index: 7)
        Keybinds_upv_1 (copy, index: 8)
        GuiService_upv_1 (copy, index: 9)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Custom_upv_1 = a1.Custom
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local fromOffset_upv_1 = UDim2.fromOffset
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 66
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Close("CustomHost")
    end
    local u2 = UI_upv_1.Window({HeaderHeight = 80, Subtitle = "", Name = "CustomHost", Title = "CUSTOM MATCH", Size = fromOffset_upv_1(tbl_upv_2.W, tbl_upv_2.H), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local updateFade = u2.Content
    UI_upv_1.SelectionRing(u2.Root)
    local tbl_upv_3 = {}
    tbl_upv_3.Name = "Code"
    tbl_upv_3.AnchorPoint = Vector2.new(1, 0)
    tbl_upv_3.BackgroundColor3 = Colors_upv_1.Inset
    tbl_upv_3.BackgroundTransparency = 0.2
    tbl_upv_3[1], tbl_upv_3[2] = UI_upv_1.Corner(10), UI_upv_1.Stroke(Colors_upv_1.Accent, 1.5, 0.5)
    tbl_upv_3.Parent = u2.Header
    local u3 = UI_upv_1.new("Frame", tbl_upv_3)
    _ = UI_upv_1.new("TextLabel", {Text = "CODE", Name = "Cap", TextSize = 13, Position = fromOffset_upv_1(14, 0), Size = UDim2.new(0, 48, 1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u3})
    local u4 = UI_upv_1.new("TextBox", {Selectable = false, Text = "", BackgroundTransparency = 1, TextEditable = false, Name = "Value", ClearTextOnFocus = false, PlaceholderText = "", TextSize = 28, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 0), Size = UDim2.new(1, -70, 1, 0), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = u3})
    tbl_upv_3 = Custom_upv_1.MaskDots({GroupGap = 12, Name = "Mask", Dot = 9, Gap = 5, Color = Colors_upv_1.TextDim, AnchorPoint = Vector2.new(1, 0.5), Parent = u3})
    tbl_upv_3.Visible = false
    local u5 = UI_upv_1.IconButton({Name = "Reveal", Visible = false, Size = fromOffset_upv_1(36, 36), AnchorPoint = Vector2.new(1, 0.5), Color = Colors_upv_1.Raised, Parent = u3})
    local u6 = UI_upv_1.Glyph("eye", 22, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u5})
    local u7 = UI_upv_1.Glyph("two-stacked-squares", 18, Colors_upv_1.Text)
    local u8 = UI_upv_1.Button({Name = "Copy", Gap = 6, Text = "COPY", TextSize = 17, Style = "Dark", AnchorPoint = Vector2.new(1, 0), Icon = u7, Parent = u2.Header})
    local u9 = UI_upv_1.new("TextLabel", {Visible = false, Text = "", Name = "CopyHint", TextSize = 13, AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u2.Header})
    local u10 = UI_upv_1.new("ScrollingFrame", {Name = "Left", ScrollBarThickness = 3, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, VerticalScrollBarInset = Enum.ScrollBarInset.None, Parent = updateFade})
    local u11 = UI_upv_1.SectionTitle("MATCH", {Parent = u10})
    local function card(a2, a3)
        --[[
          name: card
          line: 132
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        local tbl_4 = {}
        tbl_4.Name = a2
        tbl_4.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_4.BackgroundTransparency = 0.3
        tbl_4[1], tbl_4[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        tbl_4.Parent = a3
        return UI_upv_1.new("Frame", tbl_4)
    end
    local u12 = card("Match", u10)
    local u13 = UI_upv_1.new("Frame", {Name = "Dot", Size = fromOffset_upv_1(10, 10), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Colors_upv_1.Success, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u12})
    local u14 = UI_upv_1.new("TextLabel", {Name = "Status", Text = "", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u12})
    local u15 = UI_upv_1.new("TextLabel", {Name = "Teams", Text = "", AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u12})
    local u16 = UI_upv_1.Button({Name = "Start", Text = "START MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("play-large", 26, Colors_upv_1.Text), Parent = u12})
    local tbl_upv_5 = {}
    tbl_upv_5.Name = "HostedBy"
    tbl_upv_5.BackgroundColor3 = Colors_upv_1.Inset
    tbl_upv_5.BackgroundTransparency = 0.35
    tbl_upv_5.Visible = false
    tbl_upv_5[1], tbl_upv_5[2], tbl_upv_5[3] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9), UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    tbl_upv_5.Parent = u12
    local u17 = UI_upv_1.new("Frame", tbl_upv_5)
    UI_upv_1.Glyph("crown", 22, Colors_upv_1.Gold, {LayoutOrder = 1, Parent = u17})
    local u18 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Name = "Text", Text = "", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 24), Parent = u17})
    tbl_upv_5 = UI_upv_1.Button({Visible = false, Name = "End", Text = "END MATCH", Style = "Danger", Parent = u12})
    local u19 = UI_upv_1.new("TextLabel", {Name = "Hint", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u12})
    local u20 = UI_upv_1.SectionTitle("SETTINGS", {Parent = u10})
    local u21 = card("Settings", u10)
    local function rowText(a4, a5)
        --[[
          name: rowText
          line: 228
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
            u1 (copy, index: 4)
        ]]
        return UI_upv_1.Glyph("pencil", 22, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0, 0.5), Parent = a4}), UI_upv_1.new("TextLabel", {Name = "Label", Text = a5, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = a4}), (UI_upv_1.new("TextLabel", {Name = "Desc", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = a4}))
    end
    local function row(a6, a7)
        --[[
          name: row
          line: 212
          upvalues:
            UI_upv_1 (copy, index: 1)
            u21 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            fromOffset_upv_1 (copy, index: 4)
            Custom_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local v1 = UI_upv_1.new("TextButton", {Text = "", AutoButtonColor = false, Name = a6, Parent = u21})
        if a7 > 1 then
            UI_upv_1.new("Frame", {Name = "Divider", BackgroundTransparency = 0.93, BackgroundColor3 = Colors_upv_1.Stroke, Size = UDim2.new(1, -32, 0, 1), Position = fromOffset_upv_1(16, 0), Parent = v1})
        end
        local u22 = UI_upv_1.new("Frame", {Name = "Highlight", BackgroundColor3 = Colors_upv_1.White, BackgroundTransparency = 1, Position = fromOffset_upv_1(4, 4), Size = UDim2.new(1, -8, 1, -8), [1] = UI_upv_1.Corner(9), Parent = v1})
        v1.MouseEnter:Connect(
            function()
                --[[
                  line: 218
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    Custom_upv_1 (copy, index: 2)
                    u22 (copy, index: 3)
                    Theme_upv_1 (copy, index: 4)
                ]]
                if (UI_upv_1.Touch) or not Custom_upv_1.IsHost() then
                    return
                end
                UI_upv_1.Tween(u22, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.955})
            end
        )
        v1.MouseLeave:Connect(
            function()
                --[[
                  line: 223
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u22 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                ]]
                UI_upv_1.Tween(u22, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 1})
            end
        )
        return v1, u22
    end
    local u23 = row("NameRow", 1)
    local u24, u25, u26 = rowText(u23, "SERVER NAME")
    u26.TextColor3 = Colors_upv_1.TextDim
    local u27 = UI_upv_1.new("TextLabel", {Name = "Edit", Text = "EDIT", AnchorPoint = Vector2.new(1, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u23})
    local tbl_upv_6 = {}
    tbl_upv_6.Name = "NameBox"
    tbl_upv_6.Text = ""
    tbl_upv_6.PlaceholderText = ""
    tbl_upv_6.PlaceholderColor3 = Colors_upv_1.TextMuted
    tbl_upv_6.ClearTextOnFocus = false
    tbl_upv_6.FontFace = Fonts_upv_1.Bold
    tbl_upv_6.TextColor3 = Colors_upv_1.Text
    tbl_upv_6.TextXAlignment = Enum.TextXAlignment.Left
    tbl_upv_6.BackgroundColor3 = Colors_upv_1.Inset
    tbl_upv_6.BackgroundTransparency = 0.05
    tbl_upv_6.Visible = false
    tbl_upv_6.ZIndex = 4
    tbl_upv_6[1], tbl_upv_6[2] = UI_upv_1.Corner(8), UI_upv_1.Padding(0, 10, 0, 10)
    tbl_upv_6.Parent = u23
    local u28 = UI_upv_1.new("TextBox", tbl_upv_6)
    UI_upv_1.Stroke(Colors_upv_1.Accent, 1.5, 0.3).Parent = u28
    local u29 = row("PublicRow", 2)
    local u30, u31
    tbl_upv_6, u30, u31 = rowText(u29, "PUBLIC")
    local u32 = UI_upv_1.Switch({Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = u29})
    local u33 = row("BotsRow", 3)
    local u34, u35
    u34, _, u35 = rowText(u33, "FILL WITH BOTS")
    u34.Text = "three-people"
    u35.Text = "Bots take the empty slots, up to 3v3"
    local u36 = UI_upv_1.Switch({Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = u33})
    local u37 = UI_upv_1.new("TextLabel", {Name = "Value", Text = "", Visible = false, AnchorPoint = Vector2.new(1, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u33})
    local u38 = UI_upv_1.Button({Name = "Leave", Text = "LEAVE SERVER", TextSize = 18, Style = "Dark", Parent = u10})
    local u39 = UI_upv_1.new("ScrollingFrame", {Name = "Right", ScrollBarThickness = 5, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, Parent = updateFade})
    local u40 = UI_upv_1.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Colors_upv_1.PanelLo, ZIndex = 6, Visible = false, [1] = UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05)), Parent = updateFade})
    updateFade = function()
        --[[
          name: updateFade
          line: 310
          upvalues:
            u40 (copy, index: 1)
            u39 (copy, index: 2)
        ]]
        u40.Visible = (u39.AbsoluteCanvasSize.Y - (u39.CanvasPosition.Y + u39.AbsoluteWindowSize.Y)) > 2
    end
    u39:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
    u39:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
    u39:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
    local tbl_upv_7 = {Colors_upv_1.Ally, Colors_upv_1.Enemy}
    local u41 = UI_upv_1.SectionTitle("TEAMS", {Parent = u39})
    local function sectionHint(a8)
        --[[
          name: sectionHint
          line: 318
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            u1 (copy, index: 3)
            u39 (copy, index: 4)
        ]]
        return UI_upv_1.new("TextLabel", {Text = "", Name = a8, AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u39})
    end
    local u42 = sectionHint("TeamsHint")
    local u43 = nil
    local function makeSeat(a9, a10, a11)
        --[[
          name: makeSeat
          line: 339
          upvalues:
            Colors_upv_1 (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            u43 (ref,  index: 7)
        ]]
        local Accent_upv_1
        if a10 ~= 0 then
            Accent_upv_1 = tbl_upv_7[a10]
        else
            Accent_upv_1 = Colors_upv_1.Accent
        end
        local u44 = UI_upv_1.new("TextButton", {Name = a11, Text = "", AutoButtonColor = false, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.75, [1] = UI_upv_1.Corner(10), Parent = a9})
        local u45 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        u45.Parent = u44
        local v2 = UI_upv_1.new("Frame", {Name = "Ring", AnchorPoint = Vector2.new(0, 0.5), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u44})
        local u46 = UI_upv_1.Stroke(Colors_upv_1.TextMuted, 1.5, 0.55)
        u46.Parent = v2
        local v3 = UI_upv_1.Icon("plus", 16, Accent_upv_1, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v2})
        local v4 = "TextLabel"
        local v5 = UI_upv_1.new(v4, {Name = "Label", Text = "Open", AnchorPoint = Vector2.new(0, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u44})
        local tbl_upv_8 = nil
        local u47 = false
        local function look_upv_1()
            --[[
              name: look
              line: 367
              upvalues:
                tbl_upv_8 (ref,  index: 1)
                u47 (ref,  index: 2)
                UI_upv_1 (copy, index: 3)
                u45 (copy, index: 4)
                Theme_upv_1 (copy, index: 5)
                Accent_upv_1 (copy, index: 6)
                Colors_upv_1 (copy, index: 7)
                u44 (copy, index: 8)
                u46 (copy, index: 9)
            ]]
            local join_1 = tbl_upv_8.join
            local _ = join_1 and u47
            local Tween_1 = UI_upv_1.Tween
            local Fast_1 = Theme_upv_1.Tween.Fast
            local tbl_9 = {Color = 0, Transparency = 0}
            local v6
            if tbl_upv_8.join then
                v6 = Accent_upv_1
            else
                v6 = Colors_upv_1.Stroke
            end
            tbl_9.Color = v6
            v6 = (join_1 and 0.05) or (((tbl_upv_8.join) and 0.45) or 0.92)
            tbl_9.Transparency = v6
            Tween_1(u45, Fast_1, tbl_9)
            local Tween_2 = UI_upv_1.Tween
            local Fast_2 = Theme_upv_1.Tween.Fast
            local tbl_10 = {BackgroundTransparency = 0, BackgroundColor3 = 0}
            local v7
            if tbl_upv_8.join then
                v7 = Accent_upv_1
            else
                v7 = Colors_upv_1.Inset
            end
            tbl_10.BackgroundColor3 = v7
            tbl_10.BackgroundTransparency = (join_1 and 0.82) or (((tbl_upv_8.join) and 0.92) or 0.75)
            Tween_2(u44, Fast_2, tbl_10)
            local v8
            if tbl_upv_8.join then
                v8 = Accent_upv_1
            else
                v8 = Colors_upv_1.TextMuted
            end
            u46.Color = v8
            u46.Transparency = ((tbl_upv_8.join) and 0.2) or 0.55
        end
        tbl_upv_8 = {join = false, btn = u44, stroke = u45, ring = v2, plus = v3, label = v5, team = a10, look = look_upv_1}
        u44.MouseEnter:Connect(
            function()
                --[[
                  line: 381
                  upvalues:
                    u47 (ref,  index: 1)
                    tbl_upv_8 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    a1 (copy, index: 4)
                    look_upv_1 (copy, index: 5)
                ]]
                u47 = true
                if tbl_upv_8.join and not (UI_upv_1.Touch) then
                    a1.Sounds.Play("Hover")
                end
                look_upv_1()
            end
        )
        u44.MouseLeave:Connect(
            function()
                --[[
                  line: 388
                  upvalues:
                    u47 (ref,  index: 1)
                    look_upv_1 (copy, index: 2)
                ]]
                u47 = false
                look_upv_1()
            end
        )
        u44.Activated:Connect(
            function()
                --[[
                  line: 392
                  upvalues:
                    tbl_upv_8 (ref,  index: 1)
                    UI_upv_1 (copy, index: 2)
                    u44 (copy, index: 3)
                    u43 (ref,  index: 4)
                ]]
                if not tbl_upv_8.join then
                    return
                end
                UI_upv_1.Bump(u44, 0.04)
                u43(tbl_upv_8.team)
            end
        )
        return v4
    end
    local tbl_upv_11 = {}
    local tbl_upv_12 = {}
    for n_1 = 1, 2 do
        local v9 = card("Team" .. n_1, u39)
        local v10 = v9:FindFirstChildOfClass("UIStroke")
        v10.Color = tbl_upv_7[n_1]
        v10.Thickness = 1.5
        v10.Transparency = 0.7
        local v11 = UI_upv_1.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = tbl_upv_7[n_1], [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v9})
        local v12 = UI_upv_1.new("TextLabel", {Name = "Title", AnchorPoint = Vector2.new(0, 0.5), Text = "TEAM " .. n_1, FontFace = Fonts_upv_1.Heavy, TextColor3 = Theme_upv_1.Lighten(tbl_upv_7[n_1], 0.35), TextXAlignment = Enum.TextXAlignment.Left, Parent = v9})
        local v13 = UI_upv_1.new("TextLabel", {Name = "Count", Text = "", AnchorPoint = Vector2.new(1, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v9})
        local tbl_13 = {}
        for n_2 = 1, CustomMatch_upv_1.TEAM_SIZE do
            table.insert(tbl_13, (makeSeat(v9, n_1, "Open" .. n_2)))
            table.insert(tbl_upv_12, tbl_13[n_2])
        end
        tbl_upv_11[n_1] = {n = -1, frame = v9, dot = v11, title = v12, count = v13, seats = tbl_13}
        local u48 = n_1
    end
    local u49 = UI_upv_1.SectionTitle("RANDOM", {Parent = u39})
    local u50 = sectionHint("RandomHint")
    local u51 = card("Random", u39)
    card = makeSeat(u51, 0, "Join")
    table.insert(tbl_upv_12, card)
    local u52 = UI_upv_1.SectionTitle("MAP", {Parent = u39})
    local u48 = UI_upv_1.new("TextLabel", {Name = "MapValue", Text = "", TextSize = 15, AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u39})
    local u53 = UI_upv_1.new("Frame", {Name = "Maps", Parent = u39})
    local u54 = false
    local tbl_upv_14 = {}
    local u55 = false
    local u56 = false
    local function isHost()
        --[[
          name: isHost
          line: 470
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        return Custom_upv_1.IsHost()
    end
    local function stateNow()
        --[[
          name: stateNow
          line: 474
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        local v14 = Custom_upv_1.State() or {}
        return v14
    end
    local tbl_upv_15 = {}
    local u57 = ""
    local u58 = nil
    local function buildMapCards(a12)
        --[[
          name: buildMapCards
          line: 485
          upvalues:
            u57 (ref,  index: 1)
            tbl_upv_15 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u53 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            tbl_upv_2 (ref,  index: 7)
            fromOffset_upv_1 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            Custom_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u58 (ref,  index: 12)
        ]]
        local tbl_16 = ""
        for _, value_1 in a12 do
            tbl_16 = tbl_16 .. value_1.id .. ";"
        end
        if tbl_16 == u57 then
            return
        end
        u57 = tbl_16
        for _, value_2 in tbl_upv_15 do
            value_2.btn:Destroy()
        end
        table.clear(tbl_upv_15)
        tbl_16 = {{id = "", name = "Random", thumb = ""}}
        for _, value_3 in a12 do
            table.insert(tbl_16, value_3)
        end
        for key_1, value_4 in tbl_16 do
            local new_1 = UI_upv_1.new
            local tbl_17 = {}
            tbl_17.Name = "Map_" .. (((value_4.id == "") and "Random") or (value_4.id))
            tbl_17.Text = ""
            tbl_17.AutoButtonColor = false
            tbl_17.BackgroundColor3 = Colors_upv_1.Raised
            tbl_17.LayoutOrder = key_1
            tbl_17[1] = UI_upv_1.Corner(10)
            tbl_17.Parent = u53
            local v15 = new_1("TextButton", tbl_17)
            local v16 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
            v16.Parent = v15
            local v17 = UI_upv_1.new("ImageLabel", {Name = "Thumb", Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, Image = value_4.thumb or "", BackgroundTransparency = 1, [1] = UI_upv_1.Corner(10), Parent = v15})
            if value_4.id == "" then
                UI_upv_1.Gradient(Color3.fromRGB(52, 58, 74), Color3.fromRGB(26, 29, 38), 120).Parent = v15
                v15.BackgroundColor3 = Color3.new(1, 1, 1)
                UI_upv_1.new("TextLabel", {Text = "?", Name = "Mark", TextSize = 46, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(1, 0.6), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextDim, Parent = v15})
            end
            local tbl_upv_18 = {}
            tbl_upv_18.Name = "Band"
            tbl_upv_18.AnchorPoint = Vector2.new(0, 1)
            tbl_upv_18.Position = UDim2.fromScale(0, 1)
            tbl_upv_18.Size = UDim2.new(1, 0, 0, 34)
            tbl_upv_18.BackgroundColor3 = Colors_upv_1.Void
            tbl_upv_18.BackgroundTransparency = 0
            tbl_upv_18[1], tbl_upv_18[2] = UI_upv_1.Corner(10), UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(0.85, 0.2))
            tbl_upv_18.Parent = v15
            local v18 = UI_upv_1.new("Frame", tbl_upv_18)
            local v19 = UI_upv_1.new("TextLabel", {Name = "MapName", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -6), Size = UDim2.new(1, -20, 0, 20), Text = string.upper(value_4.name), FontFace = Fonts_upv_1.Heavy, TextSize = tbl_upv_2.mapName, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v18})
            local tbl_19 = {}
            tbl_19.Name = "Check"
            tbl_19.AnchorPoint = Vector2.new(1, 0)
            tbl_19.Position = UDim2.new(1, -8, 0, 8)
            tbl_19.Size = fromOffset_upv_1(26, 26)
            tbl_19.BackgroundColor3 = Colors_upv_1.Accent
            tbl_19.Visible = false
            tbl_19.ZIndex = 3
            tbl_19[1], tbl_19[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Void, 1, 0.6)
            tbl_19.Parent = v15
            v18 = UI_upv_1.new("Frame", tbl_19)
            UI_upv_1.Icon("check", 16, Colors_upv_1.Text, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v18})
            tbl_upv_18 = {}
            tbl_upv_18.id = value_4.id
            tbl_upv_18.btn = v15
            tbl_upv_18.stroke = v16
            tbl_upv_18.check = v18
            tbl_upv_18.img = v17
            tbl_upv_18.name = v19
            tbl_upv_18.scaleObj = UI_upv_1.GetScaleObj(v15, "HoverScale")
            v15.MouseEnter:Connect(
                function()
                    --[[
                      line: 577
                      upvalues:
                        UI_upv_1 (copy, index: 1)
                        Custom_upv_1 (copy, index: 2)
                        a1 (copy, index: 3)
                        tbl_upv_18 (copy, index: 4)
                        Theme_upv_1 (copy, index: 5)
                    ]]
                    if (UI_upv_1.Touch) or not Custom_upv_1.IsHost() then
                        return
                    end
                    a1.Sounds.Play("Hover")
                    UI_upv_1.Tween(tbl_upv_18.scaleObj, Theme_upv_1.Tween.PopSmall, {Scale = 1.03})
                    if not (tbl_upv_18.stroke.Thickness < 2) then
                        return
                    end
                    UI_upv_1.Tween(tbl_upv_18.stroke, Theme_upv_1.Tween.Fast, {Transparency = 0.55})
                end
            )
            v15.MouseLeave:Connect(
                function()
                    --[[
                      line: 586
                      upvalues:
                        UI_upv_1 (copy, index: 1)
                        tbl_upv_18 (copy, index: 2)
                        Theme_upv_1 (copy, index: 3)
                    ]]
                    UI_upv_1.Tween(tbl_upv_18.scaleObj, Theme_upv_1.Tween.PopSmall, {Scale = 1})
                    if not (tbl_upv_18.stroke.Thickness < 2) then
                        return
                    end
                    UI_upv_1.Tween(tbl_upv_18.stroke, Theme_upv_1.Tween.Fast, {Transparency = 0.88})
                end
            )
            v15.Activated:Connect(
                function()
                    --[[
                      line: 592
                      upvalues:
                        Custom_upv_1 (copy, index: 1)
                        u58 (ref,  index: 2)
                        tbl_upv_18 (copy, index: 3)
                    ]]
                    if not Custom_upv_1.IsHost() then
                        return
                    end
                    u58(tbl_upv_18.id)
                end
            )
            table.insert(tbl_upv_15, tbl_upv_18)
        end
    end
    local tbl_upv_20 = {}
    local tbl_upv_21 = {}
    local function headshot(a13, a14)
        --[[
          name: headshot
          line: 605
          upvalues:
            tbl_upv_21 (copy, index: 1)
        ]]
        if a13 <= 0 then
            a14.Image = ""
        elseif tbl_upv_21[a13] then
            a14.Image = tbl_upv_21[a13]
        else
            task.spawn(function() end)
        end
    end
    local u59 = nil
    local function textWidth(a15, a16)
        --[[
          name: textWidth
          line: 631
        ]]
        local success_1, v20 = pcall(function() end)
        if success_1 and type(v20) == "number" then
            return v20
        end
        return (#a15 * a16) * 0.62
    end
    local function makePRow(a17)
        --[[
          name: makePRow
          line: 653
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            u1 (copy, index: 5)
            u59 (ref,  index: 6)
            tbl_upv_21 (copy, index: 7)
            Players_upv_1 (copy, index: 8)
        ]]
        local v21 = UI_upv_1.new("Frame", {Name = "P" .. a17.userId, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.45, UI_upv_1.Corner(10)})
        local tbl_22 = {}
        tbl_22.Name = "Headshot"
        tbl_22.BackgroundColor3 = Colors_upv_1.Raised
        tbl_22[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_22.Parent = v21
        local u60 = UI_upv_1.new("ImageLabel", tbl_22)
        local v22 = UI_upv_1.new("TextLabel", {Name = "PlayerName", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v21})
        local tbl_23 = {}
        tbl_23.Name = "Line"
        tbl_23[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_23.Parent = v21
        local v23 = UI_upv_1.new("Frame", tbl_23)
        local v24 = UI_upv_1.new("TextLabel", {LayoutOrder = 10, Name = "Username", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v23})
        tbl_23 = UI_upv_1.IconButton({Name = "More", Visible = false, AnchorPoint = Vector2.new(1, 0.5), Color = Colors_upv_1.Raised, Parent = v21})
        UI_upv_1.Glyph("three-dots-horizontal", 20, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = tbl_23})
        local tbl_upv_24 = {group = -1, tagW = 0}
        tbl_upv_24.frame = v21
        tbl_upv_24.img = u60
        tbl_upv_24.name = v22
        tbl_upv_24.line = v23
        tbl_upv_24.sub = v24
        tbl_upv_24.more = tbl_23
        tbl_upv_24.userId = a17.userId
        tbl_23.Activated:Connect(
            function()
                --[[
                  line: 693
                  upvalues:
                    u59 (ref,  index: 1)
                    tbl_upv_24 (copy, index: 2)
                ]]
                u59(tbl_upv_24.userId)
            end
        )
        local userId_upv_1 = a17.userId
        if userId_upv_1 <= 0 then
            u60.Image = ""
        elseif tbl_upv_21[userId_upv_1] then
            u60.Image = tbl_upv_21[userId_upv_1]
        else
            task.spawn(
                function()
                    --[[
                      line: 614
                      upvalues:
                        Players_upv_1 (copy, index: 1)
                        userId_upv_1 (copy, index: 2)
                        tbl_upv_21 (copy, index: 3)
                        u60 (copy, index: 4)
                    ]]
                    local success_2, v25 = pcall(
                        function()
                            --[[
                              line: 615
                              upvalues:
                                Players_upv_1 (copy, index: 1)
                                userId_upv_1 (copy, index: 2)
                            ]]
                            return Players_upv_1:GetUserThumbnailAsync(userId_upv_1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                        end
                    )
                    if not success_2 or type(v25) ~= "string" then
                        return
                    end
                    tbl_upv_21[userId_upv_1] = v25
                    if not u60.Parent then
                        return
                    end
                    u60.Image = v25
                end
            )
        end
        return tbl_upv_24
    end
    local function layoutPRow(a18, a19, a20)
        --[[
          name: layoutPRow
          line: 700
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            fromOffset_upv_1 (copy, index: 2)
        ]]
        local seatH_1 = tbl_upv_2.seatH
        local head_1 = tbl_upv_2.head
        a18.frame.Size = fromOffset_upv_1(a19, seatH_1)
        a18.img.Position = fromOffset_upv_1(10, math.floor((seatH_1 - head_1) / 2))
        a18.img.Size = fromOffset_upv_1(head_1, head_1)
        local v26 = 10 + head_1 + 10
        a18.more.Visible = a20
        a18.more.Size = fromOffset_upv_1(tbl_upv_2.moreW, tbl_upv_2.moreW)
        a18.more.Position = UDim2.new(1, -8, 0.5, 0)
        local v27 = (a20 and (tbl_upv_2.moreW + 16)) or 10
        local v28 = a19 - v26 - v27
        a18.name.Position = fromOffset_upv_1(v26, (math.floor(seatH_1 / 2) - tbl_upv_2.playerName) - 3)
        a18.name.Size = fromOffset_upv_1(v28, tbl_upv_2.playerName + 4)
        a18.name.TextSize = tbl_upv_2.playerName
        a18.line.Position = fromOffset_upv_1(v26, math.floor(seatH_1 / 2) + 2)
        a18.line.Size = fromOffset_upv_1(v28, 18)
        a18.sub.TextSize = tbl_upv_2.playerSub
        a18.sub.Size = fromOffset_upv_1(math.max(0, v28 - a18.tagW), 18)
    end
    local tbl_upv_25 = {}
    local function teamOfRow(a21)
        --[[
          name: teamOfRow
          line: 721
          upvalues:
            tbl_upv_25 (copy, index: 1)
        ]]
        local v29 = tbl_upv_25[a21.userId]
        if v29 == nil then
            v29 = tonumber(a21.team) or 0
        end
        if v29 ~= 1 and v29 ~= 2 then
            return 0
        end
        return v29
    end
    local u61 = 600
    local u62 = 294
    local u63 = nil
    local tbl_upv_26 = {{}, {}, {}}
    local function tag(a22, a23, a24, a25, a26)
        --[[
          name: tag
          line: 638
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            TextService_upv_1 (copy, index: 5)
        ]]
        local tbl_27 = {}
        tbl_27.Name = "Tag"
        tbl_27.AutomaticSize = Enum.AutomaticSize.X
        tbl_27.Size = fromOffset_upv_1(0, 18)
        tbl_27.BackgroundColor3 = a24
        tbl_27.LayoutOrder = a26
        tbl_27[1], tbl_27[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 7, 0, 7)
        tbl_27.Parent = a22
        local v30 = UI_upv_1.new("Frame", tbl_27)
        UI_upv_1.new("TextLabel", {TextSize = 11, Text = a23, FontFace = Fonts_upv_1.Heavy, TextColor3 = a25, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v30})
        local u64 = 11
        local success_3, v31 = pcall(
            function()
                --[[
                  line: 632
                  upvalues:
                    TextService_upv_1 (copy, index: 1)
                    a23 (copy, index: 2)
                    u64 (copy, index: 3)
                ]]
                return TextService_upv_1:GetTextSize(a23, u64, Enum.Font.BuilderSansExtraBold, Vector2.new(1000, 100)).X
            end
        )
        local v32
        if (success_3) and type(v31) == "number" then
            v32 = v31
        else
            v32 = #a23 * 11 * 0.62
        end
        return (math.ceil(v32) + 14) + 5
    end
    local function setSeat(a27, a28)
        --[[
          name: setSeat
          line: 400
          upvalues:
            Theme_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            tbl_upv_7 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
        ]]
        a27.join = a28
        a27.label.Text = (a28 and "JOIN") or "Open"
        local label_1 = a27.label
        local v33
        local v35 = nil
        if a28 then
            v35 = Theme_upv_1.Lighten
            local v34
            if a27.team ~= 0 then
                v34 = tbl_upv_7[a27.team]
            else
                v34 = Colors_upv_1.Accent
            end
            v33 = v35(v34, 0.3)
        else
            v33 = Colors_upv_1.TextMuted
        end
        label_1.TextColor3 = v33
        local label_2 = a27.label
        if a28 then
            v35 = Fonts_upv_1.Heavy
        else
            v35 = Fonts_upv_1.SemiBold
        end
        label_2.FontFace = v35
        a27.plus.Visible = a28
        a27.btn.Selectable = a28
        a27.look()
    end
    local function paintTeams(a29)
        --[[
          name: paintTeams
          line: 732
          upvalues:
            Custom_upv_1 (copy, index: 1)
            u63 (ref,  index: 2)
            tbl_upv_25 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            tbl_upv_20 (copy, index: 5)
            CustomMatch_upv_1 (copy, index: 6)
            tbl_upv_26 (copy, index: 7)
            makePRow (copy, index: 8)
            tag (copy, index: 9)
            Colors_upv_1 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
            layoutPRow (copy, index: 12)
            u62 (ref,  index: 13)
            fromOffset_upv_1 (copy, index: 14)
            UI_upv_1 (copy, index: 15)
            tbl_upv_2 (ref,  index: 16)
            tbl_upv_11 (copy, index: 17)
            setSeat (copy, index: 18)
            u51 (copy, index: 19)
            card (copy, index: 20)
            u61 (ref,  index: 21)
            u49 (copy, index: 22)
            u50 (copy, index: 23)
            u42 (copy, index: 24)
        ]]
        local v36 = ((type(a29.players) ~= "table") and {}) or (a29.players)
        local u65 = Custom_upv_1.IsHost()
        local v37 = true
        if a29.status ~= "Match" then
            v37 = a29.status == "Results"
        end
        local tbl_28 = {{}, {}, {}}
        local tbl_29 = {}
        u63 = nil
        local v38 = nil
        local v39 = nil
        local v40 = nil
        for _, value_5 in v36 do
            if type(value_5) ~= "table" or type(value_5.userId) ~= "number" then
                continue
            end
            tbl_29[value_5.userId] = true
            v38 = tbl_upv_25[value_5.userId]
            if v38 == nil then
                v38 = tonumber(value_5.team) or 0
            end
            if v38 == 1 or v38 == 2 then
                v39 = v38
                if value_5.userId == LocalPlayer_upv_1.UserId then
                    u63 = v39
                end
                if v39 ~= 0 then
                    v40 = v39
                else
                    v40 = 3
                end
                local v41 = nil
                table.insert(tbl_28[v40], v41)
            end
            v39 = 0
            if value_5.userId == LocalPlayer_upv_1.UserId then
                u63 = v39
            end
            if v39 ~= 0 then
                v40 = v39
            else
                v40 = 3
            end
            local v41 = nil
            table.insert(tbl_28[v40], v41)
        end
        for key_2, value_6 in tbl_upv_20 do
            if not (tbl_29[key_2]) then
                value_6.frame:Destroy()
                tbl_upv_20[key_2] = nil
            end
        end
        for n_3 = 1, 2 do
            while CustomMatch_upv_1.TEAM_SIZE < #tbl_28[n_3] do
                table.insert(tbl_28[3], (table.remove(tbl_28[n_3])))
            end
        end
        for n_4 = 1, 3 do
            tbl_upv_26[n_4] = {}
            for _, value_7 in tbl_28[n_4] do
                table.insert(tbl_upv_26[n_4], value_7.userId)
            end
        end
        local function place_1(a30, a31, a32, a33, a34)
            --[[
              name: place
              line: 769
              upvalues:
                tbl_upv_20 (copy, index: 1)
                makePRow (copy, index: 2)
                a29 (copy, index: 3)
                tag (copy, index: 4)
                Colors_upv_1 (copy, index: 5)
                Theme_upv_1 (copy, index: 6)
                LocalPlayer_upv_1 (copy, index: 7)
                layoutPRow (copy, index: 8)
                u62 (ref,  index: 9)
                u65 (copy, index: 10)
                fromOffset_upv_1 (copy, index: 11)
                UI_upv_1 (copy, index: 12)
            ]]
            local v42 = tbl_upv_20[a30.userId]
            if not (v42) then
                v42 = makePRow(a30)
                tbl_upv_20[a30.userId] = v42
            end
            v42.name.AutoLocalize = false
            v42.sub.AutoLocalize = false
            v42.name.Text = tostring(a30.name or "?")
            v42.sub.Text = "@" .. tostring(a30.username or "")
            for _, value_8 in v42.line:GetChildren() do
                if value_8:IsA("Frame") then
                    value_8:Destroy()
                end
            end
            local v43 = 0
            local v44
            if a30.userId ~= a29.ownerId then
                v44 = v43
            else
                v44 = v43 + tag(v42.line, "HOST", Colors_upv_1.Gold:Lerp(Colors_upv_1.Panel, 0.72), Theme_upv_1.Lighten(Colors_upv_1.Gold, 0.1), 1)
            end
            if a30.userId ~= LocalPlayer_upv_1.UserId then
                v43 = v44
            else
                v43 = v44 + tag(v42.line, "YOU", Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.7), Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.25), 2)
            end
            v43 = ((a30.playing) and (v43 + tag(v42.line, "PLAYING", Colors_upv_1.Success:Lerp(Colors_upv_1.Panel, 0.75), Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1), 3)))
                or (((a30.watching) and (v43 + tag(v42.line, "WATCHING", Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.75), Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.25), 3))) or (((a30.satOut) and (v43 + tag(v42.line, "NEXT UP", Colors_upv_1.Warning:Lerp(Colors_upv_1.Panel, 0.75), Theme_upv_1.Lighten(Colors_upv_1.Warning, 0.1), 3))) or v43))
            v42.tagW = v43
            v42.frame.Parent = a31
            layoutPRow(v42, u62 - 16, u65 and (a30.userId ~= LocalPlayer_upv_1.UserId))
            v42.frame.Position = fromOffset_upv_1(a32, a33)
            if v42.group == a34 then
                return
            end
            if v42.group ~= -1 then
                UI_upv_1.Enter(v42.frame, Vector2.new(0, 6), 0, fromOffset_upv_1(a32, a33))
            end
            v42.group = a34
        end
        local u66 = tbl_upv_2.seatH + tbl_upv_2.seatGap
        local v53 = nil
        for n_5 = 1, 2 do
            v53 = tbl_upv_11[n_5]
            local v46 = tbl_28[n_5]
            v53.count.Text = string.format("%d/%d", #v46, CustomMatch_upv_1.TEAM_SIZE)
            if v53.n ~= #v46 then
                if v53.n ~= -1 then
                    UI_upv_1.Pop(v53.count, 1.25)
                end
                v53.n = #v46
            end
            local v47 = false
            v39 = v47
            for n_6 = 1, CustomMatch_upv_1.TEAM_SIZE do
                local v48 = tbl_upv_2.teamHead + (n_6 - 1) * u66
                local v49 = v53.seats[n_6]
                local v50 = v46[n_6]
                if v50 then
                    place_1(v50, v53.frame, 8, v48, n_5)
                    v49.btn.Visible = false
                else
                    v49.btn.Visible = true
                    v49.btn.Position = fromOffset_upv_1(8, v48)
                    v49.btn.Size = fromOffset_upv_1(u62 - 16, tbl_upv_2.seatH)
                    local v51 = (u63 ~= nil) and ((u63 ~= n_5) and (not v39))
                    v39 = v39 or v51
                    setSeat(v49, v51)
                end
            end
            local v50
        end
        local v52 = tbl_28[3]
        tbl_28 = (u63 ~= nil) and (u63 ~= 0)
        if tbl_28 then
            v53 = 1
        else
            v53 = 0
        end
        local u67 = u62 + tbl_upv_2.teamGap
        local function at_1(a35)
            --[[
              name: at
              line: 848
              upvalues:
                u67 (copy, index: 1)
                u66 (copy, index: 2)
            ]]
            return 8 + (((a35 - 1) % 2) * u67), 8 + (((a35 - 1) // 2) * u66)
        end
        for key_3, value_9 in v52 do
            place_1(value_9, u51, 8 + (((key_3 - 1) % 2) * u67), 8 + (((key_3 - 1) // 2) * u66), 0)
        end
        card.btn.Visible = tbl_28
        if tbl_28 then
            local v54 = #v52 + 1
            card.btn.Position = fromOffset_upv_1(8 + (((v54 - 1) % 2) * u67), 8 + (((v54 - 1) // 2) * u66))
            card.btn.Size = fromOffset_upv_1(u62 - 16, tbl_upv_2.seatH)
            setSeat(card, true)
        end
        local v55 = math.ceil((#v52 + v53) / 2)
        u51.Size = fromOffset_upv_1(u61, ((v55 > 0) and (16 + (v55 * tbl_upv_2.seatH) + (v55 - 1) * tbl_upv_2.seatGap)) or 0)
        u51.Visible = v55 > 0
        u49.Visible = v55 > 0
        u50.Visible = v55 > 0
        local Text_1 = u49.Text
        Text_1.Text = not (#v52 > 0) and "RANDOM" or string.format("RANDOM  \194\183  %d", #v52)
        u42.Text = (v37 and "Picks count from the next match") or "Join a team, or stay random"
        u50.Text = "Placed where there's room when the match starts"
    end
    local function anyPicks(a36)
        --[[
          name: anyPicks
          line: 887
          upvalues:
            tbl_upv_25 (copy, index: 1)
        ]]
        local v57 = ((type(a36.players) ~= "table") and {}) or (a36.players)
        local v58 = nil
        local v59 = nil
        for _, value_10 in v57 do
            if type(value_10) ~= "table" then
                continue
            end
            v58 = tbl_upv_25[value_10.userId]
            if v58 == nil then
                v58 = tonumber(value_10.team) or 0
            end
            if v58 == 1 or v58 == 2 then
                v59 = v58
                if v59 == 0 then
                    continue
                end
                return true
            end
            v59 = 0
            if v59 == 0 then
                continue
            end
            return true
        end
        return false
    end
    local function paintSwitches(a37, a38)
        --[[
          name: paintSwitches
          line: 896
          upvalues:
            Custom_upv_1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            u32 (copy, index: 3)
            u30 (copy, index: 4)
            tbl_upv_6 (copy, index: 5)
            u31 (copy, index: 6)
            u36 (copy, index: 7)
            u37 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            u27 (copy, index: 10)
            u56 (ref,  index: 11)
            u23 (copy, index: 12)
            u20 (copy, index: 13)
        ]]
        local v60 = Custom_upv_1.IsHost()
        local v61
        if tbl_upv_14.public == nil then
            v61 = a37.public == true
        else
            v61 = tbl_upv_14.public
        end
        u32:Set(v61, a38)
        u32.Instance.Visible = v60
        local v62
        if v61 then
            v62 = "PUBLIC"
        else
            v62 = "PRIVATE"
        end
        u30.Text = v62
        tbl_upv_6.Text = (v61 and "globe-simplified") or "lock-closed"
        u31.Text = (v61 and "Listed in every lobby's Custom Matches") or "Only people with the code can join"
        local v63
        if tbl_upv_14.bots == nil then
            v63 = a37.bots == true
        else
            v63 = tbl_upv_14.bots
        end
        u36:Set(v63, a38)
        u36.Instance.Visible = v60
        u37.Visible = not v60
        if v63 then
            v62 = "ON"
        else
            v62 = "OFF"
        end
        u37.Text = v62
        if v63 then
            v62 = Colors_upv_1.Text
        else
            v62 = Colors_upv_1.TextDim
        end
        u37.TextColor3 = v62
        v62 = v60 and (not u56)
        u27.Visible = v62
        u23.AutoButtonColor = false
        u20.Text.Text = (v60 and "SETTINGS") or "SERVER"
    end
    local function teamsPreview(a39)
        --[[
          name: teamsPreview
          line: 873
          upvalues:
            tbl_upv_14 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
        ]]
        local v64
        if tbl_upv_14.bots == nil then
            v64 = a39.bots
        else
            v64 = tbl_upv_14.bots
        end
        if v64 then
            return string.format("%d V %d", CustomMatch_upv_1.TEAM_SIZE, CustomMatch_upv_1.TEAM_SIZE)
        end
        local split_1 = a39.split
        if type(split_1) ~= "table" then
            return ""
        end
        local v65 = tonumber(split_1[1]) or 0
        local v66 = tonumber(split_1[2]) or 0
        if v65 + v66 >= 2 then
            return (string.format("%d V %d", v65, v66))
        end
        return ""
    end
    local function paintMatch(a40)
        --[[
          name: paintMatch
          line: 935
          upvalues:
            Custom_upv_1 (copy, index: 1)
            u16 (copy, index: 2)
            tbl_upv_5 (copy, index: 3)
            u17 (copy, index: 4)
            u18 (copy, index: 5)
            u55 (ref,  index: 6)
            u13 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            u14 (copy, index: 9)
            u15 (copy, index: 10)
            teamsPreview (copy, index: 11)
            u19 (copy, index: 12)
            u1 (copy, index: 13)
            tbl_upv_14 (copy, index: 14)
            anyPicks (copy, index: 15)
            Theme_upv_1 (copy, index: 16)
        ]]
        local v67 = a40.status or "Lobby"
        local v68 = true
        if v67 ~= "Match" then
            v68 = v67 == "Results"
        end
        local v69 = Custom_upv_1.IsHost()
        u16.Instance.Visible = v69 and (not v68)
        tbl_upv_5.Instance.Visible = v69 and v68
        u17.Visible = not v69
        u18.Text = "HOSTED BY " .. string.upper(tostring(a40.ownerName or "?"))
        tbl_upv_5:SetText(((v67 ~= "Results") and "END MATCH") or "CLOSE RESULTS")
        u16:SetEnabled((a40.canStart == true) and (not u55))
        u16:SetText(((a40.startHint ~= "Starting...") and "START MATCH") or "STARTING...")
        if v67 == "Match" then
            u13.BackgroundColor3 = Colors_upv_1.Warning
            u14.Text = "Match in progress"
        elseif v67 ~= "Results" then
            u13.BackgroundColor3 = Colors_upv_1.Success
            u14.Text = "Waiting to start"
        else
            u13.BackgroundColor3 = Colors_upv_1.Accent
            u14.Text = "Showing the results"
        end
        u15.Text = v68 and "" or teamsPreview(a40)
        if v68 then
            u19.Text = "Everyone comes back here after the match"
            u19.TextColor3 = u1
        elseif v69 then
            if a40.canStart then
                local v71
                if tbl_upv_14.bots == nil then
                    v71 = a40.bots == true
                else
                    v71 = tbl_upv_14.bots
                end
                if anyPicks(a40) then
                    u19.Text = (v71 and "Picked teams stay, bots fill the empty slots") or "Picked teams stay, the rest are shuffled"
                else
                    u19.Text = (v71 and "Teams are shuffled, bots fill the empty slots") or "Teams are shuffled every match"
                end
                u19.TextColor3 = u1
            else
                u19.Text = tostring(a40.startHint or "")
                local v72
                if a40.startHint ~= "Starting..." then
                    v72 = Theme_upv_1.Lighten(Colors_upv_1.Warning, 0.15)
                else
                    v72 = u1
                end
                u19.TextColor3 = v72
            end
        else
            u19.Text = "The host picks the map and starts the match"
            u19.TextColor3 = u1
        end
    end
    local u68 = false
    local function paintCode(a41)
        --[[
          name: paintCode
          line: 978
          upvalues:
            Custom_upv_1 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            u4 (copy, index: 3)
            tbl_upv_3 (copy, index: 4)
            u5 (copy, index: 5)
            u6 (copy, index: 6)
        ]]
        local v73 = a41.public == false and (not Custom_upv_1.IsRevealed())
        local v74 = CustomMatch_upv_1.FormatCode(tostring(a41.code or ""))
        if u4.Text ~= v74 then
            u4.Text = v74
        end
        u4.TextTransparency = (v73 and 1) or 0
        tbl_upv_3.Visible = v73
        u5.Visible = v73
        u6.Text = Custom_upv_1.IsRevealed() and "eye-slash" or "eye"
        local v76 = (v73 and -52) or -14
        u4.Position = UDim2.new(1, v76, 0, 0)
        tbl_upv_3.Position = UDim2.new(1, v76 - 2, 0.5, 0)
        u4.Size = UDim2.new(1, v76 - 56, 1, 0)
    end
    local u69 = false
    local function stack()
        --[[
          name: stack
          line: 1009
          upvalues:
            u41 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            u42 (copy, index: 3)
            u61 (ref,  index: 4)
            tbl_upv_2 (ref,  index: 5)
            tbl_upv_11 (copy, index: 6)
            u62 (ref,  index: 7)
            u51 (copy, index: 8)
            u49 (copy, index: 9)
            u50 (copy, index: 10)
            u52 (copy, index: 11)
            u48 (copy, index: 12)
            u53 (copy, index: 13)
            u69 (ref,  index: 14)
            u38 (copy, index: 15)
            u39 (copy, index: 16)
        ]]
        local v77 = 8
        u41.Position = fromOffset_upv_1(8, v77)
        u42.Position = fromOffset_upv_1(u61 + 8, v77 + 3)
        local v78 = v77 + (tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
        tbl_upv_11[1].frame.Position = fromOffset_upv_1(8, v78)
        tbl_upv_11[2].frame.Position = fromOffset_upv_1((u62 + 8) + tbl_upv_2.teamGap, v78)
        v78 = v78 + (tbl_upv_11[1].frame.Size.Y.Offset + tbl_upv_2.blockGap)
        if u51.Visible then
            u49.Position = fromOffset_upv_1(8, v78)
            u50.Position = fromOffset_upv_1(u61 + 8, v78 + 3)
            v78 = v78 + (tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
            u51.Position = fromOffset_upv_1(8, v78)
            v78 = v78 + (u51.Size.Y.Offset + tbl_upv_2.blockGap)
        end
        u52.Position = fromOffset_upv_1(8, v78)
        u48.Position = fromOffset_upv_1(u61 + 8, v78 + 3)
        v78 = v78 + (tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
        u53.Position = fromOffset_upv_1(8, v78)
        v78 = v78 + u53.Size.Y.Offset
        if u69 then
            u38.Instance.Position = fromOffset_upv_1(8, v78 + 16)
            v78 = v78 + (16 + tbl_upv_2.leaveH)
        end
        u39.CanvasSize = fromOffset_upv_1(0, v78 + 8)
    end
    local function paintHeader(a42)
        --[[
          name: paintHeader
          line: 995
          upvalues:
            u2 (copy, index: 1)
            Custom_upv_1 (copy, index: 2)
            CustomMatch_upv_1 (copy, index: 3)
            paintCode (copy, index: 4)
            u28 (copy, index: 5)
            u26 (copy, index: 6)
        ]]
        u2.Title.Text = "CUSTOM MATCH"
        local v79 = ((type(a42.players) ~= "table") and 0) or (#a42.players)
        local v80 = ((Custom_upv_1.IsHost()) and "") or ("  \194\183  hosted by " .. tostring(a42.ownerName or "?"))
        local Subtitle_1 = u2.Subtitle
        local str_1 = tostring(a42.name or "")
        local v81 = tonumber(a42.max) or (CustomMatch_upv_1.MAX_PLAYERS)
        Subtitle_1.Text = string.format("%s  \194\183  %d/%d players%s", str_1, v79, v81, v80)
        paintCode(a42)
        if (u28.Visible) then
            return
        end
        u26.AutoLocalize = false
        u26.Text = tostring(a42.name or "")
    end
    local function paintMaps(a43)
        --[[
          name: paintMaps
          line: 915
          upvalues:
            buildMapCards (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            tbl_upv_15 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u48 (copy, index: 5)
        ]]
        local v82 = ((type(a43.maps) ~= "table") and {}) or (a43.maps)
        buildMapCards(v82)
        local v83
        if tbl_upv_14.map == nil then
            v83 = a43.map or ""
        else
            v83 = tbl_upv_14.map
        end
        local v84 = nil
        for _, value_11 in tbl_upv_15 do
            local v85 = value_11.id == v83
            value_11.check.Visible = v85
            local stroke_1 = value_11.stroke
            if v85 then
                v84 = Colors_upv_1.Accent
            else
                v84 = Colors_upv_1.Stroke
            end
            stroke_1.Color = v84
            value_11.stroke.Thickness = (v85 and 3) or 1
            value_11.stroke.Transparency = (v85 and 0) or 0.88
            local img_1 = value_11.img
            if v85 then
                v84 = 0
                img_1.ImageTransparency = v84
                continue
            end
            if v83 ~= "" then
                v84 = 0.15
            else
                v84 = 0
            end
            img_1.ImageTransparency = v84
        end
        local v86 = "RANDOM"
        local v87 = ((type(a43.maps) ~= "table") and {}) or (a43.maps)
        local v88 = v86
        for _, value_12 in v87 do
            if value_12.id == v83 then
                v88 = string.upper(value_12.name)
            end
        end
        u48.Text = v88
    end
    local function paint(a44)
        --[[
          name: paint
          line: 1036
          upvalues:
            Custom_upv_1 (copy, index: 1)
            u54 (ref,  index: 2)
            paintHeader (copy, index: 3)
            paintMatch (copy, index: 4)
            paintSwitches (copy, index: 5)
            paintMaps (copy, index: 6)
            paintTeams (copy, index: 7)
            stack (copy, index: 8)
        ]]
        local v89 = Custom_upv_1.State() or {}
        u54 = v89
        paintHeader(v89)
        paintMatch(v89)
        paintSwitches(v89, a44)
        paintMaps(v89)
        paintTeams(v89)
        stack()
    end
    local function host(a45, a46, a47, a48)
        --[[
          name: host
          line: 1048
          upvalues:
            tbl_upv_14 (copy, index: 1)
            paint (copy, index: 2)
            Custom_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
        ]]
        if a47 then
            tbl_upv_14[a47] = a48
            paint()
        end
        local v90, v91 = Custom_upv_1.Host(a45, a46)
        if a47 then
            tbl_upv_14[a47] = nil
        end
        if not (v90) then
            a1.Toast(tostring(v91), "error")
        end
        paint()
        return v90
    end
    u58 = function(a49)
        --[[
          line: 1064
          upvalues:
            Custom_upv_1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            a1 (copy, index: 3)
            tbl_upv_15 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            host (copy, index: 6)
        ]]
        local v92 = Custom_upv_1.State() or {}
        local v93
        if tbl_upv_14.map == nil then
            v93 = v92.map or ""
        else
            v93 = tbl_upv_14.map
        end
        if a49 == v93 then
            return
        end
        a1.Sounds.Play("Select")
        for _, value_13 in tbl_upv_15 do
            if value_13.id == a49 then
                UI_upv_1.Bump(value_13.btn, 0.05)
            end
        end
        task.spawn(host, "SetMap", a49, "map", a49)
    end
    local tbl_upv_30 = {}
    local function sideCount(a50, a51)
        --[[
          name: sideCount
          line: 1081
          upvalues:
            Custom_upv_1 (copy, index: 1)
            tbl_upv_25 (copy, index: 2)
        ]]
        local v94 = 0
        local v95 = Custom_upv_1.State() or {}
        local v96
        if type(v95.players) ~= "table" then
            v96 = {}
        else
            v96 = v95.players
        end
        local v97 = nil
        local v98 = nil
        for _, value_14 in v96 do
            if type(value_14) ~= "table" or value_14.userId == a51 then
                continue
            end
            v97 = tbl_upv_25[value_14.userId]
            if v97 == nil then
                v97 = tonumber(value_14.team) or 0
            end
            if v97 == 1 or v97 == 2 then
                v98 = v97
                if v98 == a50 then
                    v94 = v94 + 1
                    continue
                end
            end
            v98 = 0
            if v98 == a50 then
                v94 = v94 + 1
            end
        end
        return v94
    end
    local function setTeamOf(a52, a53)
        --[[
          name: setTeamOf
          line: 1092
          upvalues:
            tbl_upv_30 (copy, index: 1)
            tbl_upv_25 (copy, index: 2)
            paint (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            Custom_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
        ]]
        tbl_upv_30[a52] = (tbl_upv_30[a52] or 0) + 1
        local v99 = tbl_upv_30[a52]
        tbl_upv_25[a52] = a53
        paint()
        local v100, v101
        if a52 ~= LocalPlayer_upv_1.UserId then
            local v102, v103 = Custom_upv_1.Host("Move", {userId = a52, team = a53})
            v100, v101 = v102, v103
        else
            local v104, v105 = Custom_upv_1.Host("Team", a53)
            v100, v101 = v104, v105
        end
        if tbl_upv_30[a52] == v99 then
            tbl_upv_25[a52] = nil
        end
        if not (v100) then
            a1.Toast(tostring(v101), "error")
        end
        paint()
    end
    u43 = function(a54)
        --[[
          line: 1111
          upvalues:
            u63 (ref,  index: 1)
            sideCount (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            setTeamOf (copy, index: 6)
        ]]
        if u63 == nil or u63 == a54 then
            return
        end
        if a54 ~= 0 and CustomMatch_upv_1.TEAM_SIZE <= sideCount(a54, LocalPlayer_upv_1.UserId) then
            a1.Toast(("Team %* is full"):format(a54), "info")
        else
            a1.Sounds.Play("Select")
            task.spawn(setTeamOf, LocalPlayer_upv_1.UserId, a54)
        end
    end
    u29.Activated:Connect(
        function()
            --[[
              line: 1123
              upvalues:
                Custom_upv_1 (copy, index: 1)
                tbl_upv_14 (copy, index: 2)
                a1 (copy, index: 3)
                host (copy, index: 4)
            ]]
            if not Custom_upv_1.IsHost() then
                return
            end
            local v106 = Custom_upv_1.State() or {}
            local v107
            if tbl_upv_14.public == nil then
                v107 = v106.public == true
            else
                v107 = tbl_upv_14.public
            end
            local Play_1 = a1.Sounds.Play
            local tbl_31 = {pitch = 0}
            local v108
            if v107 then
                v108 = 0.94
            else
                v108 = 1.08
            end
            tbl_31.pitch = v108
            Play_1("Click", tbl_31)
            task.spawn(host, "SetPublic", not v107, "public", not v107)
        end
    )
    u33.Activated:Connect(
        function()
            --[[
              line: 1132
              upvalues:
                Custom_upv_1 (copy, index: 1)
                tbl_upv_14 (copy, index: 2)
                a1 (copy, index: 3)
                host (copy, index: 4)
            ]]
            if not Custom_upv_1.IsHost() then
                return
            end
            local v109 = Custom_upv_1.State() or {}
            local v110
            if tbl_upv_14.bots == nil then
                v110 = v109.bots == true
            else
                v110 = tbl_upv_14.bots
            end
            local Play_2 = a1.Sounds.Play
            local tbl_32 = {pitch = 0}
            local v111
            if v110 then
                v111 = 0.94
            else
                v111 = 1.08
            end
            tbl_32.pitch = v111
            Play_2("Click", tbl_32)
            task.spawn(host, "SetBots", not v110, "bots", not v110)
        end
    )
    u16.Activated:Connect(
        function()
            --[[
              line: 1142
              upvalues:
                u55 (ref,  index: 1)
                u16 (copy, index: 2)
                Custom_upv_1 (copy, index: 3)
                a1 (copy, index: 4)
                paint (copy, index: 5)
            ]]
            if u55 then
                return
            end
            u55 = true
            u16:SetText("STARTING...")
            u16:SetEnabled(false)
            local v112, v113 = Custom_upv_1.Host("Start", nil)
            if not (v112) then
                a1.Toast(tostring(v113), "error")
            end
            paint()
            u55 = false
            if v112 then
                a1.Sounds.Play("Match_Found")
                a1.MenuManager.Close("CustomHost")
            else
                paint()
            end
        end
    )
    local function beginEdit()
        --[[
          name: beginEdit
          line: 1160
          upvalues:
            u56 (ref,  index: 1)
            u28 (copy, index: 2)
            Custom_upv_1 (copy, index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            u26 (copy, index: 6)
            u25 (copy, index: 7)
            u27 (copy, index: 8)
            u24 (copy, index: 9)
        ]]
        if u56 then
            return
        end
        u56 = true
        local v114 = Custom_upv_1.State() or {}
        u28.Text = tostring(v114.name or "")
        u28.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
        u28.Visible = true
        u26.Visible = false
        u25.Visible = false
        u27.Visible = false
        u24.Visible = false
        u28:CaptureFocus()
    end
    local function endEdit()
        --[[
          name: endEdit
          line: 1174
          upvalues:
            u56 (ref,  index: 1)
            u28 (copy, index: 2)
            u26 (copy, index: 3)
            u25 (copy, index: 4)
            u27 (copy, index: 5)
            u24 (copy, index: 6)
        ]]
        u56 = false
        u28.Visible = false
        u26.Visible = true
        u25.Visible = true
        u27.Visible = true
        u24.Visible = true
    end
    u23.Activated:Connect(
        function()
            --[[
              line: 1182
              upvalues:
                Custom_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u56 (ref,  index: 3)
                u28 (copy, index: 4)
                CustomMatch_upv_1 (copy, index: 5)
                LocalPlayer_upv_1 (copy, index: 6)
                u26 (copy, index: 7)
                u25 (copy, index: 8)
                u27 (copy, index: 9)
                u24 (copy, index: 10)
            ]]
            if not Custom_upv_1.IsHost() then
                return
            end
            a1.Sounds.Play("Click")
            if u56 then
                return
            end
            u56 = true
            local v115 = Custom_upv_1.State() or {}
            u28.Text = tostring(v115.name or "")
            u28.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
            u28.Visible = true
            u26.Visible = false
            u25.Visible = false
            u27.Visible = false
            u24.Visible = false
            u28:CaptureFocus()
        end
    )
    u28:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 1189
              upvalues:
                u28 (copy, index: 1)
                CustomMatch_upv_1 (copy, index: 2)
            ]]
            local Text_2 = u28.Text
            local v116 = utf8.len(Text_2) or (#Text_2)
            if CustomMatch_upv_1.NAME_MAX < v116 then
                local v117 = utf8.offset(Text_2, CustomMatch_upv_1.NAME_MAX + 1) or (#Text_2 + 1)
                u28.Text = string.sub(Text_2, 1, v117 - 1)
            end
        end
    )
    u28.FocusLost:Connect(
        function()
            --[[
              line: 1197
              upvalues:
                u56 (ref,  index: 1)
                u28 (copy, index: 2)
                Custom_upv_1 (copy, index: 3)
                u26 (copy, index: 4)
                u25 (copy, index: 5)
                u27 (copy, index: 6)
                u24 (copy, index: 7)
                CustomMatch_upv_1 (copy, index: 8)
                LocalPlayer_upv_1 (copy, index: 9)
                a1 (copy, index: 10)
                paint (copy, index: 11)
            ]]
            if not u56 then
                return
            end
            local Text_upv_3 = u28.Text
            local v118 = Custom_upv_1.State() or {}
            local str_upv_2 = tostring(v118.name or "")
            u56 = false
            u28.Visible = false
            u26.Visible = true
            u25.Visible = true
            u27.Visible = true
            u24.Visible = true
            if CustomMatch_upv_1.CleanName(Text_upv_3) ~= str_upv_2 then
                local v119
                if CustomMatch_upv_1.CleanName(Text_upv_3) == "" then
                    v119 = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
                else
                    v119 = CustomMatch_upv_1.CleanName(Text_upv_3)
                end
                u26.Text = v119
                task.spawn(
                    function()
                        --[[
                          line: 1208
                          upvalues:
                            Text_upv_3 (copy, index: 1)
                            Custom_upv_1 (copy, index: 2)
                            a1 (copy, index: 3)
                            paint (copy, index: 4)
                            u26 (copy, index: 5)
                            str_upv_2 (copy, index: 6)
                        ]]
                        local v120, v121 = Custom_upv_1.Host("SetName", Text_upv_3)
                        if not (v120) then
                            a1.Toast(tostring(v121), "error")
                        end
                        paint()
                        if v120 then
                            a1.Sounds.Play("Select")
                        else
                            u26.Text = str_upv_2
                        end
                    end
                )
            end
        end
    )
    u5.Activated:Connect(
        function()
            --[[
              line: 1222
              upvalues:
                Custom_upv_1 (copy, index: 1)
            ]]
            if Custom_upv_1.IsRevealed() then
                Custom_upv_1.Hide()
            else
                Custom_upv_1.Reveal()
            end
        end
    )
    local u70 = 0
    local u71 = 0
    local function resetCopyLook()
        --[[
          name: resetCopyLook
          line: 1231
          upvalues:
            u9 (copy, index: 1)
            u8 (copy, index: 2)
            u7 (copy, index: 3)
        ]]
        u9.Visible = false
        u8:SetText("COPY")
        u7.Text = "two-stacked-squares"
    end
    local function stopCopy()
        --[[
          name: stopCopy
          line: 1236
          upvalues:
            u68 (ref,  index: 1)
            u71 (ref,  index: 2)
            u9 (copy, index: 3)
            u8 (copy, index: 4)
            u7 (copy, index: 5)
        ]]
        u68 = false
        local v122 = os.clock()
        if not (u71 <= v122) then
            return
        end
        u9.Visible = false
        u8:SetText("COPY")
        u7.Text = "two-stacked-squares"
    end
    local function copyCode()
        --[[
          name: copyCode
          line: 1242
          upvalues:
            Custom_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            paintCode (copy, index: 3)
            u70 (ref,  index: 4)
            u71 (ref,  index: 5)
            u7 (copy, index: 6)
            u68 (ref,  index: 7)
            u4 (copy, index: 8)
            u9 (copy, index: 9)
            u8 (copy, index: 10)
        ]]
        local v123 = Custom_upv_1.State() or {}
        if type(v123.code) ~= "string" then
            return
        end
        if v123.code ~= "" then
            if UI_upv_1.Touch and v123.public == false and not (Custom_upv_1.IsRevealed()) then
                Custom_upv_1.Reveal()
            end
            paintCode(v123)
            u70 = u70 + 1
            u71 = 0
            u7.Text = "two-stacked-squares"
            u68 = true
            u4:CaptureFocus()
            local function selectAll_1()
                --[[
                  name: selectAll
                  line: 1256
                  upvalues:
                    u68 (ref,  index: 1)
                    u4 (copy, index: 2)
                ]]
                if not u68 or not u4:IsFocused() then
                    return
                end
                u4.SelectionStart = 1
                u4.CursorPosition = #u4.Text + 1
            end
            if u68 then
                local v124 = u4:IsFocused()
                if v124 then
                    u4.SelectionStart = 1
                    u4.CursorPosition = #u4.Text + 1
                end
            end
            task.defer(selectAll_1)
            u9.Text = ((UI_upv_1.Touch) and "Tap and hold the code to copy") or "Press Ctrl+C (Cmd+C on Mac) to copy"
            u9.Visible = true
            UI_upv_1.Enter(u9, Vector2.new(0, -4), 0, u9.Position)
            u8:SetText("SELECTED")
        end
    end
    u8.Activated:Connect(copyCode)
    u8.Instance.Visible = not UI_upv_1.Gamepad
    local function refreshCopy()
        --[[
          name: refreshCopy
          line: 1272
          upvalues:
            u8 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        u8.Instance.Visible = not UI_upv_1.Gamepad
    end
    UI_upv_1.GamepadChanged:Connect(refreshCopy)
    local function copyModifier()
        --[[
          name: copyModifier
          line: 1280
          upvalues:
            UserInputService_upv_1 (copy, index: 1)
        ]]
        for _, value_15 in {Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.LeftSuper, Enum.KeyCode.RightSuper, Enum.KeyCode.LeftMeta, Enum.KeyCode.RightMeta} do
            if not (UserInputService_upv_1:IsKeyDown(value_15)) then
                continue
            end
            return true
        end
        return false
    end
    UserInputService_upv_1.InputBegan:Connect(
        function(a55)
            --[[
              line: 1288
              upvalues:
                u68 (ref,  index: 1)
                u4 (copy, index: 2)
                copyModifier (copy, index: 3)
                u70 (ref,  index: 4)
                u71 (ref,  index: 5)
                u8 (copy, index: 6)
                u7 (copy, index: 7)
                u9 (copy, index: 8)
                Keybinds_upv_1 (copy, index: 9)
                a1 (copy, index: 10)
            ]]
            if not u68 or not u4:IsFocused() then
                return
            end
            if a55.KeyCode == Enum.KeyCode.C and copyModifier() then
                u70 = u70 + 1
                local u72 = u70
                u71 = os.clock() + 1.6
                u8:SetText("COPIED")
                u7.Text = "check"
                u9.Text = "Copied to your clipboard"
                u9.Visible = true
                task.delay(
                    0.2,
                    function()
                        --[[
                          line: 1300
                          upvalues:
                            u72 (copy, index: 1)
                            u70 (ref,  index: 2)
                            u4 (copy, index: 3)
                        ]]
                        if u72 ~= u70 or not u4:IsFocused() then
                            return
                        end
                        u4:ReleaseFocus()
                    end
                )
                task.delay(
                    1.65,
                    function()
                        --[[
                          line: 1305
                          upvalues:
                            u72 (copy, index: 1)
                            u70 (ref,  index: 2)
                            u68 (ref,  index: 3)
                            u9 (copy, index: 4)
                            u8 (copy, index: 5)
                            u7 (copy, index: 6)
                        ]]
                        if u72 ~= u70 or (u68) then
                            return
                        end
                        u9.Visible = false
                        u8:SetText("COPY")
                        u7.Text = "two-stacked-squares"
                    end
                )
                return
            end
            if Keybinds_upv_1.IsPad(a55, "CustomMenu") or Keybinds_upv_1.ActionOf(a55) == "CustomMenu" then
                a1.MenuManager.Toggle("CustomHost")
            end
        end
    )
    u4.FocusLost:Connect(
        function()
            --[[
              line: 1314
              upvalues:
                UI_upv_1 (copy, index: 1)
                u4 (copy, index: 2)
                u68 (ref,  index: 3)
                u71 (ref,  index: 4)
                u9 (copy, index: 5)
                u8 (copy, index: 6)
                u7 (copy, index: 7)
            ]]
            task.delay(
                ((UI_upv_1.Touch) and 0) or 0.15,
                function()
                    --[[
                      line: 1315
                      upvalues:
                        u4 (copy, index: 1)
                        u68 (ref,  index: 2)
                        u71 (ref,  index: 3)
                        u9 (copy, index: 4)
                        u8 (copy, index: 5)
                        u7 (copy, index: 6)
                    ]]
                    if not (u4:IsFocused()) then
                        u68 = false
                        local v125 = os.clock()
                        if not (u71 <= v125) then
                            return
                        end
                        u9.Visible = false
                        u8:SetText("COPY")
                        u7.Text = "two-stacked-squares"
                    end
                end
            )
        end
    )
    u4:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 1322
              upvalues:
                CustomMatch_upv_1 (copy, index: 1)
                Custom_upv_1 (copy, index: 2)
                u4 (copy, index: 3)
            ]]
            local FormatCode_1 = CustomMatch_upv_1.FormatCode
            local v126 = Custom_upv_1.State() or {}
            local v127 = FormatCode_1(tostring(v126.code or ""))
            if u4.Text == v127 then
                return
            end
            u4.Text = v127
        end
    )
    Custom_upv_1.RevealChanged:Connect(
        function()
            --[[
              line: 1328
              upvalues:
                u2 (copy, index: 1)
                paintCode (copy, index: 2)
                Custom_upv_1 (copy, index: 3)
            ]]
            if u2.IsOpen then
                local v128 = Custom_upv_1.State() or {}
                paintCode(v128)
            end
        end
    )
    local tbl_upv_33 = nil
    local u73 = nil
    local function closeConfirm()
        --[[
          name: closeConfirm
          line: 1338
          upvalues:
            u73 (ref, index: 1)
            tbl_upv_33 (ref, index: 2)
        ]]
        u73 = nil
        if not tbl_upv_33 then
            return
        end
        tbl_upv_33.layer.Visible = false
    end
    local function openConfirm(a56, a57, a58, a59, a60, a61)
        --[[
          name: openConfirm
          line: 1344
          upvalues:
            tbl_upv_33 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u2 (copy, index: 4)
            closeConfirm (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            u73 (ref,  index: 8)
            a1 (copy, index: 9)
            GuiService_upv_1 (copy, index: 10)
        ]]
        if not (tbl_upv_33) then
            local v129 = UI_upv_1.new("TextButton", {Name = "Confirm", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, [1] = UI_upv_1.Corner(UDim.new(0, 16)), Parent = u2.Holder})
            v129.Activated:Connect(closeConfirm)
            local v130 = UI_upv_1.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(480, 256), Radius = UDim.new(0, 16), Parent = v129})
            UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 41, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v130})
            local v131 = UI_upv_1.DisplayText({ZIndex = 42, Name = "Title", Text = "", TextSize = 34, Position = fromOffset_upv_1(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = Colors_upv_1.Text, Parent = v130})
            local v132 = UI_upv_1.new("TextLabel", {Text = "", Name = "Body", TextWrapped = true, ZIndex = 42, TextSize = 19, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 74), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = v130})
            local v133 = UI_upv_1.Button({Text = "", Name = "No", Style = "Dark", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v130})
            local v134 = UI_upv_1.Button({Text = "", Name = "Yes", Style = "Danger", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v130})
            v133.Activated:Connect(closeConfirm)
            v134.Activated:Connect(
                function()
                    --[[
                      line: 1386
                      upvalues:
                        u73 (ref, index: 1)
                        tbl_upv_33 (ref, index: 2)
                    ]]
                    u73 = nil
                    if tbl_upv_33 then
                        tbl_upv_33.layer.Visible = false
                    end
                    if not u73 then
                        return
                    end
                    u73()
                end
            )
            tbl_upv_33 = {layer = v129, card = v130, title = v131, body = v132, no = v133, yes = v134}
        end
        tbl_upv_33.title.AutoLocalize = true
        tbl_upv_33.title.Text = a56
        tbl_upv_33.body.Text = a57
        tbl_upv_33.no:SetText(a58)
        tbl_upv_33.yes:SetText(a59)
        tbl_upv_33.yes:SetStyle(a60)
        u73 = a61
        tbl_upv_33.layer.Visible = true
        UI_upv_1.Enter(tbl_upv_33.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = tbl_upv_33.no.Instance
    end
    tbl_upv_5.Activated:Connect(
        function()
            --[[
              line: 1411
              upvalues:
                Custom_upv_1 (copy, index: 1)
                host (copy, index: 2)
                openConfirm (copy, index: 3)
                a1 (copy, index: 4)
                paint (copy, index: 5)
            ]]
            local v135 = Custom_upv_1.State() or {}
            if v135.status ~= "Results" then
                openConfirm(
                    "END MATCH?",
                    "Everyone goes back to the lobby now. The match won't count for anything.",
                    "KEEP PLAYING",
                    "END MATCH",
                    "Danger",
                    function()
                        --[[
                          line: 1417
                          upvalues:
                            Custom_upv_1 (copy, index: 1)
                            a1 (copy, index: 2)
                            paint (copy, index: 3)
                        ]]
                        task.spawn(
                            function()
                                --[[
                                  line: 1418
                                  upvalues:
                                    Custom_upv_1 (copy, index: 1)
                                    a1 (copy, index: 2)
                                    paint (copy, index: 3)
                                ]]
                                local v136, v137 = Custom_upv_1.Host("End", nil)
                                if not (v136) then
                                    a1.Toast(tostring(v137), "error")
                                end
                                paint()
                                if not v136 then
                                    return
                                end
                                a1.MenuManager.Close("CustomHost")
                            end
                        )
                    end
                )
            else
                task.spawn(host, "End")
            end
        end
    )
    u38.Activated:Connect(
        function()
            --[[
              line: 1434
              upvalues:
                openConfirm (copy, index: 1)
                Custom_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            openConfirm(
                "LEAVE SERVER?",
                "You'll go back to a public lobby. The player here longest becomes the host.",
                "STAY",
                "LEAVE",
                "Danger",
                function()
                    --[[
                      line: 1435
                      upvalues:
                        Custom_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    task.spawn(
                        function()
                            --[[
                              line: 1436
                              upvalues:
                                Custom_upv_1 (copy, index: 1)
                                a1 (copy, index: 2)
                            ]]
                            local v138, v139 = Custom_upv_1.Action("Leave")
                            if v138 then
                                a1.MenuManager.Close("CustomHost")
                            else
                                a1.Toast(tostring(v139), "error")
                            end
                        end
                    )
                end
            )
        end
    )
    local tbl_upv_34 = nil
    local u74 = 0
    local tbl_upv_35 = {"TEAM 1", "TEAM 2", "RANDOM"}
    local function closeMove()
        --[[
          name: closeMove
          line: 1454
          upvalues:
            u74 (ref, index: 1)
            tbl_upv_34 (ref, index: 2)
        ]]
        u74 = 0
        if not tbl_upv_34 then
            return
        end
        tbl_upv_34.layer.Visible = false
    end
    local u75 = function(a62, a63)
        --[[
          line: 1425
          upvalues:
            openConfirm (copy, index: 1)
            Custom_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            paint (copy, index: 4)
        ]]
        openConfirm(
            "REMOVE PLAYER?",
            string.format("%s goes back to a public lobby and can't rejoin this match.", a63),
            "CANCEL",
            "REMOVE",
            "Danger",
            function()
                --[[
                  line: 1426
                  upvalues:
                    a62 (copy, index: 1)
                    Custom_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                    paint (copy, index: 4)
                    a63 (copy, index: 5)
                ]]
                task.spawn(
                    function()
                        --[[
                          line: 1427
                          upvalues:
                            a62 (copy, index: 1)
                            Custom_upv_1 (copy, index: 2)
                            a1 (copy, index: 3)
                            paint (copy, index: 4)
                            a63 (copy, index: 5)
                        ]]
                        local v140, v141 = Custom_upv_1.Host("Kick", a62)
                        if not (v140) then
                            a1.Toast(tostring(v141), "error")
                        end
                        paint()
                        if not v140 then
                            return
                        end
                        a1.Toast(string.format("%s was removed", a63), "info")
                    end
                )
            end
        )
    end
    local function findPlayer(a64)
        --[[
          name: findPlayer
          line: 1460
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        local v142 = Custom_upv_1.State() or {}
        local v143
        if type(v142.players) ~= "table" then
            v143 = {}
        else
            v143 = v142.players
        end
        for _, value_16 in v143 do
            if type(value_16) ~= "table" or value_16.userId ~= a64 then
                continue
            end
            return value_16
        end
        return nil
    end
    u59 = function(a65)
        --[[
          line: 1469
          upvalues:
            findPlayer (copy, index: 1)
            Custom_upv_1 (copy, index: 2)
            tbl_upv_34 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u2 (copy, index: 6)
            closeMove (copy, index: 7)
            fromOffset_upv_1 (copy, index: 8)
            Fonts_upv_1 (copy, index: 9)
            tbl_upv_7 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
            tbl_upv_35 (copy, index: 12)
            u74 (ref,  index: 13)
            tbl_upv_25 (copy, index: 14)
            a1 (copy, index: 15)
            setTeamOf (copy, index: 16)
            u75 (ref,  index: 17)
            sideCount (copy, index: 18)
            CustomMatch_upv_1 (copy, index: 19)
            GuiService_upv_1 (copy, index: 20)
        ]]
        local v144 = findPlayer(a65)
        if not Custom_upv_1.IsHost() or not v144 then
            return
        end
        local body_1
        if not (tbl_upv_34) then
            local v145 = UI_upv_1.new("TextButton", {Name = "Move", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, [1] = UI_upv_1.Corner(UDim.new(0, 16)), Parent = u2.Holder})
            v145.Activated:Connect(closeMove)
            local v146 = UI_upv_1.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(540, 286), Radius = UDim.new(0, 16), Parent = v145})
            UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 41, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v146})
            body_1 = UI_upv_1.DisplayText({Text = "", Name = "Title", ZIndex = 42, TextSize = 32, Position = fromOffset_upv_1(28, 24), Size = UDim2.new(1, -56, 0, 40), TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v146})
            local v147 = UI_upv_1.new("TextLabel", {Text = "", Name = "Body", ZIndex = 42, TextSize = 18, Position = fromOffset_upv_1(28, 66), Size = UDim2.new(1, -56, 0, 22), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v146})
            local tbl_36 = {}
            local tbl_37 = {}
            local tbl_38 = {tbl_upv_7[1], tbl_upv_7[2], Colors_upv_1.TextMuted}
            for n_7 = 1, 3 do
                local u76
                if n_7 ~= 3 then
                    u76 = n_7
                else
                    u76 = 0
                end
                local v148 = UI_upv_1.new("Frame", {Name = "Mark", Size = fromOffset_upv_1(16, 16)})
                UI_upv_1.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(12, 12), BackgroundColor3 = tbl_38[n_7], [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v148})
                local v149 = UI_upv_1.Icon("check", 16, Colors_upv_1.TextDim, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v148})
                v149.Name = "Check"
                v149.Visible = false
                tbl_37[n_7] = v148
                local tbl_39 = {Style = "Dark", ZIndex = 43, TextSize = 19}
                tbl_39.Name = "Pick" .. u76
                tbl_39.Text = tbl_upv_35[n_7]
                tbl_39.Icon = v148
                tbl_39.Position = fromOffset_upv_1(((n_7 - 1) * 165) + 28, 110)
                tbl_39.Size = fromOffset_upv_1(153, 58)
                tbl_39.Parent = v146
                function tbl_39.OnDisabledClick()
                    --[[
                      name: OnDisabledClick
                      line: 1533
                      upvalues:
                        findPlayer (copy, index: 1)
                        u74 (ref,  index: 2)
                        tbl_upv_25 (copy, index: 3)
                        u76 (copy, index: 4)
                        a1 (copy, index: 5)
                    ]]
                    local v150 = findPlayer(u74)
                    if v150 then
                        local v151 = tbl_upv_25[v150.userId]
                        if v151 == nil then
                            v151 = tonumber(v150.team) or 0
                        end
                        local v152
                        if v151 == 1 or v151 == 2 then
                            v152 = v151
                        else
                            v152 = 0
                        end
                        if v152 == u76 then
                            return
                        end
                        a1.Toast(("Team %* is full"):format(u76), "info")
                    end
                end
                local v153 = UI_upv_1.Button(tbl_39)
                v153.Activated:Connect(
                    function()
                        --[[
                          line: 1540
                          upvalues:
                            u74 (ref,  index: 1)
                            tbl_upv_34 (ref,  index: 2)
                            Custom_upv_1 (copy, index: 3)
                            setTeamOf (copy, index: 4)
                            u76 (copy, index: 5)
                        ]]
                        u74 = 0
                        if tbl_upv_34 then
                            tbl_upv_34.layer.Visible = false
                        end
                        if u74 == 0 or not Custom_upv_1.IsHost() then
                            return
                        end
                        task.spawn(setTeamOf, u74, u76)
                    end
                )
                tbl_36[n_7] = v153
            end
            local v154 = UI_upv_1.Button({Text = "CANCEL", Name = "Cancel", Style = "Dark", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v146})
            local v155 = UI_upv_1.Button({Text = "REMOVE", Name = "Remove", Style = "Danger", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v146})
            v154.Activated:Connect(closeMove)
            v155.Activated:Connect(
                function()
                    --[[
                      line: 1552
                      upvalues:
                        u74 (ref,  index: 1)
                        findPlayer (copy, index: 2)
                        tbl_upv_34 (ref,  index: 3)
                        u75 (ref,  index: 4)
                    ]]
                    local v156 = findPlayer(u74)
                    u74 = 0
                    if tbl_upv_34 then
                        tbl_upv_34.layer.Visible = false
                    end
                    if not v156 then
                        return
                    end
                    u75(u74, (tostring(v156.name or "Player")))
                end
            )
            tbl_upv_34 = {layer = v145, card = v146, title = body_1, body = v147, picks = tbl_36, marks = tbl_37, cancel = v154, remove = v155}
        end
        local v157 = tbl_upv_34
        u74 = a65
        body_1 = tbl_upv_25[v144.userId]
        if body_1 == nil then
            body_1 = tonumber(v144.team) or 0
        end
        local v158
        if body_1 == 1 or body_1 == 2 then
            v158 = body_1
        else
            v158 = 0
        end
        v157.title.AutoLocalize = false
        v157.title.Text = string.upper(tostring(v144.name or "Player"))
        body_1 = v157.body
        local format_1 = string.format
        local str_3 = tostring(v144.username or "")
        local v159
        if v158 ~= 0 then
            v159 = ("Team %*"):format(v158)
        else
            v159 = "Random team"
        end
        body_1.Text = format_1("@%s  \194\183  %s", str_3, v159)
        local v160 = nil
        local v161, v162 = nil, nil
        v144 = v160
        local v163 = nil
        for key_4, value_17 in v157.picks do
            if key_4 ~= 3 then
                v163 = key_4
            else
                v163 = 0
            end
            v161 = false
            if v163 ~= 0 then
                v161 = (v163 ~= v158) and (CustomMatch_upv_1.TEAM_SIZE <= sideCount(v163, a65))
            end
            local v164 = (v163 ~= v158) and (not v161)
            value_17:SetEnabled(v164)
            value_17:SetText((v161 and (tbl_upv_35[key_4] .. " FULL")) or (tbl_upv_35[key_4]))
            value_17.Label.TextSize = (v161 and 17) or 19
            v161 = v157.marks[key_4]
            local Dot_1 = v161:FindFirstChild("Dot")
            Dot_1.Visible = v163 ~= v158
            v162 = v161:FindFirstChild("Check")
            v162.Visible = v163 == v158
            if v144 then
                v162 = v144
                v144 = v162
                continue
            end
            if v164 then
                v162 = value_17
            else
                v162 = nil
            end
            v144 = v162
        end
        v157.layer.Visible = true
        UI_upv_1.Enter(v157.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = (v144 or (v157.cancel)).Instance
    end
    local function layout()
        --[[
          name: layout
          line: 1590
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            u2 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            u8 (copy, index: 7)
            u3 (copy, index: 8)
            u4 (copy, index: 9)
            tbl_upv_3 (copy, index: 10)
            u5 (copy, index: 11)
            u9 (copy, index: 12)
            u10 (copy, index: 13)
            u11 (copy, index: 14)
            u13 (copy, index: 15)
            u14 (copy, index: 16)
            u15 (copy, index: 17)
            u16 (copy, index: 18)
            tbl_upv_5 (copy, index: 19)
            u17 (copy, index: 20)
            u18 (copy, index: 21)
            u19 (copy, index: 22)
            u12 (copy, index: 23)
            u20 (copy, index: 24)
            u23 (copy, index: 25)
            u29 (copy, index: 26)
            u33 (copy, index: 27)
            u24 (copy, index: 28)
            u25 (copy, index: 29)
            u26 (copy, index: 30)
            tbl_upv_6 (copy, index: 31)
            u30 (copy, index: 32)
            u31 (copy, index: 33)
            u34 (copy, index: 34)
            u35 (copy, index: 35)
            u27 (copy, index: 36)
            u28 (copy, index: 37)
            u32 (copy, index: 38)
            u36 (copy, index: 39)
            u37 (copy, index: 40)
            u21 (copy, index: 41)
            u38 (copy, index: 42)
            u39 (copy, index: 43)
            u40 (copy, index: 44)
            updateFade (copy, index: 45)
            u61 (ref,  index: 46)
            u62 (ref,  index: 47)
            u41 (copy, index: 48)
            u42 (copy, index: 49)
            u49 (copy, index: 50)
            u50 (copy, index: 51)
            u52 (copy, index: 52)
            u48 (copy, index: 53)
            CustomMatch_upv_1 (copy, index: 54)
            tbl_upv_11 (copy, index: 55)
            tbl_upv_12 (copy, index: 56)
            tbl_upv_15 (copy, index: 57)
            u53 (copy, index: 58)
            u69 (ref,  index: 59)
        ]]
        local v165 = UI_upv_1.CanvasSize()
        local v166 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            u2.Holder.Size = fromOffset_upv_1(math.floor(math.min(tbl_upv_2.W, v165.X - 24)), math.floor(math.min(tbl_upv_2.H, (v165.Y - v166) - 12)))
        else
            u2.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v165.X - 240, tbl_upv_2.W, 1280)), math.floor(math.clamp((v165.Y - v166) - 90, 660, 740)))
        end
        u2.Subtitle.TextSize = ((UI_upv_1.Compact) and 15) or 17
        local v167 = ((UI_upv_1.Compact) and 226) or 246
        local v168 = ((UI_upv_1.Compact) and 44) or 48
        local v169 = ((UI_upv_1.Compact) and 116) or 118
        local v170 = UI_upv_1.WindowCloseSize() + 30
        u8.Instance.Position = UDim2.new(1, -v170, 0, 14)
        u8.Instance.Size = fromOffset_upv_1(v169, v168 + 3)
        u8.Label.TextSize = ((UI_upv_1.Compact) and 18) or 17
        u3.Size = fromOffset_upv_1(v167, v168)
        u3.Position = UDim2.new(1, -((v170 + v169) + 10), 0, 14)
        u4.TextSize = ((UI_upv_1.Compact) and 25) or 28
        local v171 = ((UI_upv_1.Compact) and 8) or 9
        for key_5, value_18 in tbl_upv_3:GetChildren() do
            local v172 = tonumber(string.match(value_18.Name, "%d+")) or key_5
            local v173 = v171 * 0.55
            value_18.Size = fromOffset_upv_1(v171, v171)
            value_18.Position = fromOffset_upv_1((v172 - 1) * (v171 + v173) + (((v172 > 3) and (v171 * 1.35 - v173)) or 0), 0)
        end
        tbl_upv_3.Size = fromOffset_upv_1(((v171 * 6) + ((v171 * 4) * 0.55)) + (v171 * 1.35), v171)
        u5.Position = UDim2.new(1, -8, 0.5, 0)
        u9.Position = UDim2.new(1, -v170, 0, (v168 + 14) + 4)
        u9.Size = fromOffset_upv_1((v167 + v169) + 10, 14)
        local v174 = (v167 + v169) + v170 + 40
        u2.Title.Size = UDim2.new(1, -v174, 0, 40)
        u2.Subtitle.Size = UDim2.new(1, -v174, 0, 20)
        u2.Subtitle.TextTruncate = Enum.TextTruncate.AtEnd
        local v175 = u2.Holder.Size.Y.Offset - 80 - 32
        local left_1 = tbl_upv_2.left
        u10.Size = fromOffset_upv_1(left_1, v175)
        local pad_1 = tbl_upv_2.pad
        local v176 = left_1 - pad_1 * 2
        u11.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        local v177 = pad_1
        u13.Position = fromOffset_upv_1(pad_1 + 2, v177 + 11)
        u14.Position = fromOffset_upv_1(pad_1 + 20, v177)
        u14.Size = fromOffset_upv_1(v176 - 110, 22)
        u14.TextSize = tbl_upv_2.status
        u15.Position = UDim2.new(1, -pad_1, 0, v177)
        u15.Size = fromOffset_upv_1(100, 22)
        u15.TextSize = tbl_upv_2.status - 1
        local v178 = v177 + 32
        for _, value_19 in {u16, tbl_upv_5} do
            value_19.Instance.Position = fromOffset_upv_1(pad_1, v178)
            value_19.Instance.Size = fromOffset_upv_1(v176, tbl_upv_2.button)
            value_19.Label.TextSize = ((UI_upv_1.Compact) and 23) or 26
        end
        u17.Position = fromOffset_upv_1(pad_1, v178)
        u17.Size = fromOffset_upv_1(v176, tbl_upv_2.button - 3)
        u18.TextSize = ((UI_upv_1.Compact) and 19) or 20
        local v179 = v178 + (tbl_upv_2.button + 8)
        u19.Position = fromOffset_upv_1(pad_1, v179)
        u19.Size = fromOffset_upv_1(v176, tbl_upv_2.hint + 2)
        u19.TextSize = tbl_upv_2.hint
        local v180 = v179 + (((tbl_upv_2.hint + 2) + pad_1) - 4)
        local v181 = tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        u12.Position = fromOffset_upv_1(0, v181)
        u12.Size = fromOffset_upv_1(left_1, v180)
        local v182 = v181 + v180 + tbl_upv_2.blockGap
        u20.Position = fromOffset_upv_1(0, v182)
        u20.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        local v183 = v182 + tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        local tbl_40 = {u23, u29, u33}
        for key_6, value_20 in tbl_40 do
            value_20.Position = fromOffset_upv_1(0, (key_6 - 1) * tbl_upv_2.rowH)
            value_20.Size = fromOffset_upv_1(left_1, tbl_upv_2.rowH)
        end
        for _, value_21 in {{u23, u24, u25, u26}, {u29, tbl_upv_6, u30, u31}} do
            local v184 = value_21[2]
            local v185 = value_21[3]
            local v186 = value_21[4]
            v184.Position = UDim2.new(0, pad_1 + 2, 0.5, 0)
            v184.TextSize = 22
            v185.Position = fromOffset_upv_1(pad_1 + 36, (math.floor(tbl_upv_2.rowH / 2) - tbl_upv_2.label) - 1)
            v185.Size = fromOffset_upv_1((v176 - 36) - 86, tbl_upv_2.label + 2)
            v185.TextSize = tbl_upv_2.label
            v186.Position = fromOffset_upv_1(pad_1 + 36, math.floor(tbl_upv_2.rowH / 2) + 2)
            v186.Size = fromOffset_upv_1((v176 - 36) - 86, tbl_upv_2.desc + 2)
            v186.TextSize = tbl_upv_2.desc
        end
        u34.Position = UDim2.new(0, pad_1 + 2, 0.5, 0)
        local Label_1 = u33:FindFirstChild("Label")
        Label_1.Position = fromOffset_upv_1(pad_1 + 36, (math.floor(tbl_upv_2.rowH / 2) - tbl_upv_2.label) - 1)
        Label_1.Size = fromOffset_upv_1((v176 - 36) - 86, tbl_upv_2.label + 2)
        Label_1.TextSize = tbl_upv_2.label
        u35.Position = fromOffset_upv_1(pad_1 + 36, math.floor(tbl_upv_2.rowH / 2) + 2)
        u35.Size = fromOffset_upv_1((v176 - 36) - 86, tbl_upv_2.desc + 2)
        u35.TextSize = tbl_upv_2.desc
        u27.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u27.Size = fromOffset_upv_1(60, 20)
        u27.TextSize = tbl_upv_2.label - 2
        u28.Position = fromOffset_upv_1(pad_1 - 4, 8)
        u28.Size = fromOffset_upv_1(v176 + 8, tbl_upv_2.rowH - 16)
        u28.TextSize = tbl_upv_2.label
        u32.Instance.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u36.Instance.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u37.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u37.Size = fromOffset_upv_1(60, 22)
        u37.TextSize = tbl_upv_2.label
        u21.Position = fromOffset_upv_1(0, v183)
        u21.Size = fromOffset_upv_1(left_1, #tbl_40 * tbl_upv_2.rowH)
        u38.Label.TextSize = ((UI_upv_1.Compact) and 17) or 18
        local v187 = (v183 + (#tbl_40 * tbl_upv_2.rowH)) + 12 + tbl_upv_2.leaveH <= v175
        local v188
        if v187 then
            v188 = v175
        else
            v188 = v183 + (#tbl_40 * tbl_upv_2.rowH) + 2
        end
        u10.CanvasSize = fromOffset_upv_1(0, v188)
        u39.Position = fromOffset_upv_1((left_1 + tbl_upv_2.gap) - 8, -8)
        local v189 = u2.Holder.Size.X.Offset - 44 - left_1 - tbl_upv_2.gap
        u39.Size = fromOffset_upv_1(v189 + 8, v175 + 8)
        u40.Position = fromOffset_upv_1(left_1 + tbl_upv_2.gap, v175)
        u40.Size = fromOffset_upv_1(v189 - 10, 40)
        task.defer(updateFade)
        u61 = v189 - 14
        u62 = math.floor((u61 - tbl_upv_2.teamGap) / 2)
        for _, value_22 in {{u41, u42}, {u49, u50}, {u52, u48}} do
            local v190 = value_22[2]
            value_22[1].Size = UDim2.new(0, u61, 0, tbl_upv_2.sectionH)
            v190.Size = fromOffset_upv_1(math.floor(u61 * 0.62), 18)
            v190.TextSize = tbl_upv_2.sectionHint
        end
        u48.TextSize = 15
        local v191 = tbl_upv_2.teamHead + (CustomMatch_upv_1.TEAM_SIZE * tbl_upv_2.seatH) + ((CustomMatch_upv_1.TEAM_SIZE - 1) * tbl_upv_2.seatGap) + 8
        for _, value_23 in tbl_upv_11 do
            value_23.frame.Size = fromOffset_upv_1(u62, v191)
            value_23.dot.Position = UDim2.new(0, 16, 0, math.floor(tbl_upv_2.teamHead / 2) + 1)
            value_23.dot.Size = fromOffset_upv_1(10, 10)
            value_23.title.Position = UDim2.new(0, 34, 0, math.floor(tbl_upv_2.teamHead / 2) + 1)
            value_23.title.Size = fromOffset_upv_1(160, 22)
            value_23.title.TextSize = tbl_upv_2.label
            value_23.count.Position = UDim2.new(1, -16, 0, math.floor(tbl_upv_2.teamHead / 2) + 1)
            value_23.count.Size = fromOffset_upv_1(80, 22)
            value_23.count.TextSize = tbl_upv_2.label - 1
        end
        for _, value_24 in tbl_upv_12 do
            value_24.ring.Position = fromOffset_upv_1(10, math.floor(tbl_upv_2.seatH / 2))
            value_24.ring.Size = fromOffset_upv_1(tbl_upv_2.head, tbl_upv_2.head)
            value_24.label.Position = fromOffset_upv_1((10 + tbl_upv_2.head) + 10, math.floor(tbl_upv_2.seatH / 2))
            value_24.label.Size = fromOffset_upv_1(160, 22)
            value_24.label.TextSize = tbl_upv_2.playerName - 1
        end
        local mapCols_1 = tbl_upv_2.mapCols
        local v192 = math.floor((u61 - ((mapCols_1 - 1) * tbl_upv_2.mapGap)) / mapCols_1)
        local v193 = math.floor((v192 * 9) / 16)
        local v194 = math.ceil(math.max(1, #tbl_upv_15) / mapCols_1)
        for key_7, value_25 in tbl_upv_15 do
            value_25.btn.AnchorPoint = Vector2.new(0.5, 0.5)
            value_25.btn.Position = fromOffset_upv_1((((key_7 - 1) % mapCols_1) * (v192 + tbl_upv_2.mapGap)) + math.floor(v192 / 2), ((key_7 - 1) // mapCols_1) * (v193 + tbl_upv_2.mapGap) + math.floor(v193 / 2))
            value_25.btn.Size = fromOffset_upv_1(v192, v193)
            value_25.name.TextSize = tbl_upv_2.mapName
        end
        u53.Size = fromOffset_upv_1(u61, (v194 * v193) + ((v194 - 1) * tbl_upv_2.mapGap))
        if v187 then
            u38.Instance.Parent = u10
            u38.Instance.AnchorPoint = Vector2.new(0, 1)
            u38.Instance.Position = UDim2.new(0, 0, 1, 0)
            u38.Instance.Size = fromOffset_upv_1(left_1, tbl_upv_2.leaveH)
        else
            u38.Instance.Parent = u39
            u38.Instance.AnchorPoint = Vector2.new(0, 0)
            u38.Instance.Size = fromOffset_upv_1(u61, tbl_upv_2.leaveH)
        end
        u69 = not v187
        u2.Refit()
    end
    local function relayout()
        --[[
          name: relayout
          line: 1779
          upvalues:
            u2 (copy, index: 1)
            paint (copy, index: 2)
            layout (copy, index: 3)
        ]]
        if not u2.IsOpen then
            return
        end
        paint(true)
        layout()
        paint(true)
    end
    UI_upv_1.LayoutChanged:Connect(relayout)
    UI_upv_1.ScaleChanged:Connect(relayout)
    Custom_upv_1.Changed:Connect(
        function()
            --[[
              line: 1790
              upvalues:
                u2 (copy, index: 1)
                u56 (ref,  index: 2)
                Custom_upv_1 (copy, index: 3)
                u28 (copy, index: 4)
                u74 (ref,  index: 5)
                findPlayer (copy, index: 6)
                tbl_upv_34 (ref,  index: 7)
                tbl_upv_15 (copy, index: 8)
                paint (copy, index: 9)
                layout (copy, index: 10)
            ]]
            if not u2.IsOpen then
                return
            end
            if u56 and not (Custom_upv_1.IsHost()) then
                u28:ReleaseFocus()
            end
            if u74 ~= 0 and (not Custom_upv_1.IsHost() or not findPlayer(u74)) then
                u74 = 0
                if tbl_upv_34 then
                    tbl_upv_34.layer.Visible = false
                end
                paint()
                if #tbl_upv_15 ~= #tbl_upv_15 then
                    layout()
                    paint(true)
                end
                return
            end
            paint()
            if #tbl_upv_15 ~= #tbl_upv_15 then
                layout()
                paint(true)
            end
        end
    )
    local tbl_41 = {}
    function tbl_41.open()
        --[[
          name: open
          line: 1809
          upvalues:
            a1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            tbl_upv_25 (copy, index: 3)
            u73 (ref,  index: 4)
            tbl_upv_33 (ref,  index: 5)
            u74 (ref,  index: 6)
            tbl_upv_34 (ref,  index: 7)
            u56 (ref,  index: 8)
            u28 (copy, index: 9)
            u26 (copy, index: 10)
            u25 (copy, index: 11)
            u27 (copy, index: 12)
            u24 (copy, index: 13)
            paint (copy, index: 14)
            layout (copy, index: 15)
            u39 (copy, index: 16)
            u2 (copy, index: 17)
            UI_upv_1 (copy, index: 18)
            u10 (copy, index: 19)
            GuiService_upv_1 (copy, index: 20)
            u16 (copy, index: 21)
            tbl_upv_5 (copy, index: 22)
            Custom_upv_1 (copy, index: 23)
        ]]
        a1.SetHudHidden("CustomHost", true)
        table.clear(tbl_upv_14)
        table.clear(tbl_upv_25)
        u73 = nil
        if tbl_upv_33 then
            tbl_upv_33.layer.Visible = false
        end
        u74 = 0
        if tbl_upv_34 then
            tbl_upv_34.layer.Visible = false
        end
        if u56 then
            u56 = false
            u28.Visible = false
            u26.Visible = true
            u25.Visible = true
            u27.Visible = true
            u24.Visible = true
        end
        paint(true)
        layout()
        paint(true)
        u39.CanvasPosition = Vector2.zero
        u2:Open()
        UI_upv_1.SlideIn(u10, Vector2.new(-18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
        if UI_upv_1.Gamepad then
            local v195
            if u16.Instance.Visible then
                v195 = u16.Instance
            elseif tbl_upv_5.Instance.Visible then
                v195 = tbl_upv_5.Instance
            else
                v195 = u2.CloseButton
            end
            GuiService_upv_1.SelectedObject = v195
        end
        task.spawn(
            function()
                --[[
                  line: 1830
                  upvalues:
                    Custom_upv_1 (copy, index: 1)
                ]]
                Custom_upv_1.Host("Get")
            end
        )
    end
    function tbl_41.close(a66)
        --[[
          name: close
          line: 1834
          upvalues:
            a1 (copy, index: 1)
            u73 (ref,  index: 2)
            tbl_upv_33 (ref,  index: 3)
            u74 (ref,  index: 4)
            tbl_upv_34 (ref,  index: 5)
            u56 (ref,  index: 6)
            u28 (copy, index: 7)
            u4 (copy, index: 8)
            u71 (ref,  index: 9)
            u68 (ref,  index: 10)
            u9 (copy, index: 11)
            u8 (copy, index: 12)
            u7 (copy, index: 13)
            Custom_upv_1 (copy, index: 14)
            GuiService_upv_1 (copy, index: 15)
            u2 (copy, index: 16)
        ]]
        a1.SetHudHidden("CustomHost", false)
        u73 = nil
        if tbl_upv_33 then
            tbl_upv_33.layer.Visible = false
        end
        u74 = 0
        if tbl_upv_34 then
            tbl_upv_34.layer.Visible = false
        end
        if u56 then
            u28:ReleaseFocus()
        end
        if u4:IsFocused() then
            u4:ReleaseFocus()
        end
        u71 = 0
        u68 = false
        local v196 = os.clock()
        if u71 <= v196 then
            u9.Visible = false
            u8:SetText("COPY")
            u7.Text = "two-stacked-squares"
        end
        Custom_upv_1.Hide()
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        if SelectedObject_1 and SelectedObject_1:IsDescendantOf(u2.Root) then
            GuiService_upv_1.SelectedObject = nil
        end
        u2:Close(a66)
    end
    a1.MenuManager.Register("CustomHost", tbl_41)
    a1.Debug.customHost = function(a67, a68)
        --[[
          line: 1860
          upvalues:
            card (copy, index: 1)
            tbl_upv_11 (copy, index: 2)
            u43 (ref,  index: 3)
            u59 (ref,  index: 4)
            tbl_upv_34 (ref,  index: 5)
            u74 (ref,  index: 6)
            a1 (copy, index: 7)
            u58 (ref,  index: 8)
            host (copy, index: 9)
            u16 (copy, index: 10)
            tbl_upv_5 (copy, index: 11)
            tbl_upv_20 (copy, index: 12)
            u75 (ref,  index: 13)
            u38 (copy, index: 14)
            tbl_upv_33 (ref,  index: 15)
            u73 (ref,  index: 16)
            u56 (ref,  index: 17)
            u28 (copy, index: 18)
            Custom_upv_1 (copy, index: 19)
            CustomMatch_upv_1 (copy, index: 20)
            LocalPlayer_upv_1 (copy, index: 21)
            u26 (copy, index: 22)
            u25 (copy, index: 23)
            u27 (copy, index: 24)
            u24 (copy, index: 25)
            copyCode (copy, index: 26)
            tbl_upv_15 (copy, index: 27)
            u2 (copy, index: 28)
            u19 (copy, index: 29)
            u4 (copy, index: 30)
            tbl_upv_3 (copy, index: 31)
            u5 (copy, index: 32)
            u68 (ref,  index: 33)
            u9 (copy, index: 34)
            u8 (copy, index: 35)
            u17 (copy, index: 36)
            u63 (ref,  index: 37)
            tbl_upv_26 (copy, index: 38)
            u15 (copy, index: 39)
        ]]
        local v197 = nil
        local function joinSeat(a69)
            --[[
              name: joinSeat
              line: 1861
              upvalues:
                card (copy, index: 1)
                tbl_upv_11 (copy, index: 2)
            ]]
            local v198 = nil
            if a69 ~= 0 then
                v198 = tbl_upv_11[a69]
                if not (v198) then
                    v198 = {}
                    v198.seats = {}
                end
                for _, value_26 in v198.seats do
                    if not (value_26.btn.Visible) or not (value_26.join) then
                        continue
                    end
                    return value_26
                end
            elseif card.btn.Visible and card.join then
                return card
            end
            return nil
        end
        if a67 == "join" then
            v197 = joinSeat(tonumber(a68) or 0)
            if not v197 then
                return "no JOIN seat there"
            end
            u43(v197.team)
            local v199 = Custom_upv_1.State() or {}
            local tbl_42 = {}
            tbl_42.open = u2.IsOpen
            tbl_42.host = Custom_upv_1.IsHost()
            tbl_42.status = v199.status or false
            tbl_42.canStart = v199.canStart or false
            tbl_42.hint = u19.Text
            tbl_42.map = v199.map or false
            tbl_42.public = v199.public or false
            tbl_42.bots = v199.bots or false
            local v200
            if type(v199.players) ~= "table" then
                v200 = 0
            else
                v200 = #v199.players
            end
            tbl_42.players = v200
            tbl_42.mapCards = #tbl_upv_15
            v200 = (tbl_upv_33 ~= nil) and (tbl_upv_33.layer.Visible)
            tbl_42.confirm = v200
            tbl_42.code = u4.Text
            local v201
            if tbl_upv_3.Visible then
                v201 = Custom_upv_1.MASK
            else
                v201 = u4.Text
            end
            tbl_42.codeShown = v201
            tbl_42.masked = tbl_upv_3.Visible
            tbl_42.eye = u5.Visible
            tbl_42.copying = u68
            tbl_42.focused = u4:IsFocused()
            tbl_42.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            local v202
            if u9.Visible then
                v202 = u9.Text
            else
                v202 = false
            end
            tbl_42.copyHint = v202
            tbl_42.copyLabel = u8.Label.Text
            tbl_42.readOnly = u17.Visible
            tbl_42.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_42.team = u63 or false
            tbl_42.team1 = tbl_upv_26[1]
            tbl_42.team2 = tbl_upv_26[2]
            tbl_42.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join1 = v200
            if joinSeat(2) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join2 = v200
            local v203 = not (card.btn.Visible) or not (card.join) or card
            if v203 ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.joinRandom = v200
            tbl_42.preview = u15.Text
            tbl_42.move = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            tbl_42.movePicks = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            local v204 = 0
            local v200 = v204
            for _, value_27 in tbl_upv_20 do
                v200 = ((value_27.more.Visible) and (v200 + 1)) or v200
            end
            tbl_42.moreShown = v200
            return tbl_42
        elseif a67 == "more" then
            u59(tonumber(a68) or 0)
            local v199 = Custom_upv_1.State() or {}
            local tbl_42 = {}
            tbl_42.open = u2.IsOpen
            tbl_42.host = Custom_upv_1.IsHost()
            tbl_42.status = v199.status or false
            tbl_42.canStart = v199.canStart or false
            tbl_42.hint = u19.Text
            tbl_42.map = v199.map or false
            tbl_42.public = v199.public or false
            tbl_42.bots = v199.bots or false
            local v200
            if type(v199.players) ~= "table" then
                v200 = 0
            else
                v200 = #v199.players
            end
            tbl_42.players = v200
            tbl_42.mapCards = #tbl_upv_15
            v200 = (tbl_upv_33 ~= nil) and (tbl_upv_33.layer.Visible)
            tbl_42.confirm = v200
            tbl_42.code = u4.Text
            local v201
            if tbl_upv_3.Visible then
                v201 = Custom_upv_1.MASK
            else
                v201 = u4.Text
            end
            tbl_42.codeShown = v201
            tbl_42.masked = tbl_upv_3.Visible
            tbl_42.eye = u5.Visible
            tbl_42.copying = u68
            tbl_42.focused = u4:IsFocused()
            tbl_42.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            local v202
            if u9.Visible then
                v202 = u9.Text
            else
                v202 = false
            end
            tbl_42.copyHint = v202
            tbl_42.copyLabel = u8.Label.Text
            tbl_42.readOnly = u17.Visible
            tbl_42.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_42.team = u63 or false
            tbl_42.team1 = tbl_upv_26[1]
            tbl_42.team2 = tbl_upv_26[2]
            tbl_42.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join1 = v200
            if joinSeat(2) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join2 = v200
            local v203 = not (card.btn.Visible) or not (card.join) or card
            if v203 ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.joinRandom = v200
            tbl_42.preview = u15.Text
            v200 = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            tbl_42.move = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            local v200 = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            tbl_42.movePicks = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            local v204 = 0
            local v200 = v204
            for _, value_27 in tbl_upv_20 do
                v200 = ((value_27.more.Visible) and (v200 + 1)) or v200
            end
            tbl_42.moreShown = v200
            return tbl_42
        elseif a67 ~= "movePick" then
            if a67 ~= "moveRemove" then
                if a67 == "moveCancel" then
                    u74 = 0
                    if tbl_upv_34 then
                        tbl_upv_34.layer.Visible = false
                    end
                elseif a67 == "open" then
                    a1.MenuManager.Open("CustomHost")
                elseif a67 == "map" then
                    u58((tostring(a68 or "")))
                elseif a67 == "public" then
                    local v205 = a68 ~= false
                    task.spawn(host, "SetPublic", v205, "public", a68 ~= false)
                elseif a67 == "bots" then
                    local v206 = a68 == true
                    task.spawn(host, "SetBots", v206, "bots", a68 == true)
                elseif a67 == "start" then
                    u16.Activated:Fire()
                elseif a67 == "end" then
                    tbl_upv_5.Activated:Fire()
                elseif a67 == "kick" then
                    local v207 = tbl_upv_20[tonumber(a68) or 0]
                    local v208 = u75
                    local v209 = tonumber(a68) or 0
                    v208(v209, ((not v207) and "Player") or (v207.name.Text))
                elseif a67 == "leave" then
                    u38.Activated:Fire()
                elseif a67 ~= "confirmYes" then
                    if a67 == "confirmNo" then
                        u73 = nil
                        if tbl_upv_33 then
                            tbl_upv_33.layer.Visible = false
                        end
                    elseif a67 ~= "edit" then
                        if a67 == "name" then
                            if not (u56) then
                                u56 = true
                                local v210 = Custom_upv_1.State() or {}
                                u28.Text = tostring(v210.name or "")
                                u28.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
                                u28.Visible = true
                                u26.Visible = false
                                u25.Visible = false
                                u27.Visible = false
                                u24.Visible = false
                                u28:CaptureFocus()
                            end
                            u28.Text = tostring(a68 or "")
                            u28:ReleaseFocus()
                        elseif a67 == "copy" then
                            copyCode()
                        elseif a67 ~= "reveal" then
                            if a67 == "hoverMap" then
                                for _, value_28 in tbl_upv_15 do
                                    if value_28.id == tostring(a68 or "") then
                                        value_28.scaleObj.Scale = 1.03
                                        value_28.stroke.Transparency = 0.55
                                    end
                                end
                            end
                        elseif a68 ~= false then
                            Custom_upv_1.Reveal()
                        else
                            Custom_upv_1.Hide()
                        end
                    elseif not (u56) then
                        u56 = true
                        local v211 = Custom_upv_1.State() or {}
                        u28.Text = tostring(v211.name or "")
                        u28.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
                        u28.Visible = true
                        u26.Visible = false
                        u25.Visible = false
                        u27.Visible = false
                        u24.Visible = false
                        u28:CaptureFocus()
                    end
                elseif tbl_upv_33 then
                    tbl_upv_33.yes.Activated:Fire()
                end
            elseif tbl_upv_34 then
                tbl_upv_34.remove.Activated:Fire()
            end
            local v199 = Custom_upv_1.State() or {}
            local tbl_42 = {}
            tbl_42.open = u2.IsOpen
            tbl_42.host = Custom_upv_1.IsHost()
            tbl_42.status = v199.status or false
            tbl_42.canStart = v199.canStart or false
            tbl_42.hint = u19.Text
            tbl_42.map = v199.map or false
            tbl_42.public = v199.public or false
            tbl_42.bots = v199.bots or false
            local v200
            if type(v199.players) ~= "table" then
                v200 = 0
            else
                v200 = #v199.players
            end
            tbl_42.players = v200
            tbl_42.mapCards = #tbl_upv_15
            v200 = (tbl_upv_33 ~= nil) and (tbl_upv_33.layer.Visible)
            tbl_42.confirm = v200
            tbl_42.code = u4.Text
            local v201
            if tbl_upv_3.Visible then
                v201 = Custom_upv_1.MASK
            else
                v201 = u4.Text
            end
            tbl_42.codeShown = v201
            tbl_42.masked = tbl_upv_3.Visible
            tbl_42.eye = u5.Visible
            tbl_42.copying = u68
            tbl_42.focused = u4:IsFocused()
            tbl_42.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            local v202
            if u9.Visible then
                v202 = u9.Text
            else
                v202 = false
            end
            tbl_42.copyHint = v202
            tbl_42.copyLabel = u8.Label.Text
            tbl_42.readOnly = u17.Visible
            tbl_42.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_42.team = u63 or false
            tbl_42.team1 = tbl_upv_26[1]
            tbl_42.team2 = tbl_upv_26[2]
            tbl_42.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join1 = v200
            if joinSeat(2) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join2 = v200
            local v203 = not (card.btn.Visible) or not (card.join) or card
            if v203 ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.joinRandom = v200
            tbl_42.preview = u15.Text
            v200 = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            tbl_42.move = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            local v200 = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            tbl_42.movePicks = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            local v204 = 0
            local v200 = v204
            for _, value_27 in tbl_upv_20 do
                v200 = ((value_27.more.Visible) and (v200 + 1)) or v200
            end
            tbl_42.moreShown = v200
            return tbl_42
        else
            local v212 = ((a68 == 0) and 3) or (tonumber(a68) or 0)
            local v213 = tbl_upv_34 and (tbl_upv_34.picks[v212])
            if not v213 or not v213.Enabled then
                return "that pick is off"
            end
            v213.Activated:Fire()
            local v199 = Custom_upv_1.State() or {}
            local tbl_42 = {}
            tbl_42.open = u2.IsOpen
            tbl_42.host = Custom_upv_1.IsHost()
            tbl_42.status = v199.status or false
            tbl_42.canStart = v199.canStart or false
            tbl_42.hint = u19.Text
            tbl_42.map = v199.map or false
            tbl_42.public = v199.public or false
            tbl_42.bots = v199.bots or false
            local v200
            if type(v199.players) ~= "table" then
                v200 = 0
            else
                v200 = #v199.players
            end
            tbl_42.players = v200
            tbl_42.mapCards = #tbl_upv_15
            v200 = (tbl_upv_33 ~= nil) and (tbl_upv_33.layer.Visible)
            tbl_42.confirm = v200
            tbl_42.code = u4.Text
            local v201
            if tbl_upv_3.Visible then
                v201 = Custom_upv_1.MASK
            else
                v201 = u4.Text
            end
            tbl_42.codeShown = v201
            tbl_42.masked = tbl_upv_3.Visible
            tbl_42.eye = u5.Visible
            tbl_42.copying = u68
            tbl_42.focused = u4:IsFocused()
            tbl_42.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            local v202
            if u9.Visible then
                v202 = u9.Text
            else
                v202 = false
            end
            tbl_42.copyHint = v202
            tbl_42.copyLabel = u8.Label.Text
            tbl_42.readOnly = u17.Visible
            tbl_42.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_42.team = u63 or false
            tbl_42.team1 = tbl_upv_26[1]
            tbl_42.team2 = tbl_upv_26[2]
            tbl_42.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join1 = v200
            if joinSeat(2) ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.join2 = v200
            local v203 = not (card.btn.Visible) or not (card.join) or card
            if v203 ~= nil then
                v200 = true
            else
                v200 = false
            end
            tbl_42.joinRandom = v200
            tbl_42.preview = u15.Text
            v200 = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            tbl_42.move = tbl_upv_34 ~= nil and tbl_upv_34.layer.Visible
            local v200 = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            tbl_42.movePicks = tbl_upv_34 and {tbl_upv_34.picks[1].Enabled, tbl_upv_34.picks[2].Enabled, tbl_upv_34.picks[3].Enabled} or false
            local v204 = 0
            local v200 = v204
            for _, value_27 in tbl_upv_20 do
                v200 = ((value_27.more.Visible) and (v200 + 1)) or v200
            end
            tbl_42.moreShown = v200
            return tbl_42
        end
    end
end
return tbl_1