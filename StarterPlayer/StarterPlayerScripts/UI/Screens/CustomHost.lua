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
      line: 55
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
          line: 70
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
          line: 136
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
          line: 232
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
          line: 216
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
                  line: 222
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
                  line: 227
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
    local u23 = row("ModeRow", 1)
    local u24, u25
    u24, _, u25 = rowText(u23, "MODE")
    local u26 = nil
    local u27 = {Name = "Mode", Height = 36, Width = 128}
    u27.Options = {{id = "3v3", text = "3V3"}, {id = "1v1", text = "1V1"}}
    u27.Selected = CustomMatch_upv_1.DEFAULT_MODE
    u27.AnchorPoint = Vector2.new(1, 0.5)
    u27.Parent = u23
    function u27.OnSelect(a8)
        --[[
          name: OnSelect
          line: 252
          upvalues:
            u26 (ref, index: 1)
        ]]
        u26(a8)
    end
    local u28 = UI_upv_1.Segmented(u27)
    local u29 = UI_upv_1.new("TextLabel", {Name = "Value", Text = "", Visible = false, AnchorPoint = Vector2.new(1, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Right, Parent = u23})
    local function OnSelect(a9)
        --[[
          name: OnSelect
          line: 276
          upvalues:
            u26 (ref, index: 1)
        ]]
        u26(a9)
    end
    u27 = UI_upv_1.Segmented({Visible = false, Width = 124, Name = "ModeCompact", TextSize = 20, Options = {{id = "3v3", text = "3V3"}, {id = "1v1", text = "1V1"}}, Selected = CustomMatch_upv_1.DEFAULT_MODE, Height = tbl_upv_2.button, Parent = u12, OnSelect = OnSelect})
    local u30 = row("NameRow", 2)
    local u31, u32
    local u33, u31, u32 = rowText(u30, "SERVER NAME")
    u32.TextColor3 = Colors_upv_1.TextDim
    local u34 = UI_upv_1.new("TextLabel", {Name = "Edit", Text = "EDIT", AnchorPoint = Vector2.new(1, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u30})
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
    tbl_upv_6.Parent = u30
    local u35 = UI_upv_1.new("TextBox", tbl_upv_6)
    UI_upv_1.Stroke(Colors_upv_1.Accent, 1.5, 0.3).Parent = u35
    local u36 = row("PublicRow", 3)
    local u37, u38
    tbl_upv_6, u37, u38 = rowText(u36, "PUBLIC")
    local u39 = UI_upv_1.Switch({Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = u36})
    local u40 = row("BotsRow", 4)
    local u41, u42
    u41, _, u42 = rowText(u40, "FILL WITH BOTS")
    u41.Text = "three-people"
    u42.Text = "Bots take the empty slots, up to 3v3"
    local u43 = UI_upv_1.Switch({Width = 58, AnchorPoint = Vector2.new(1, 0.5), Parent = u40})
    local u44 = UI_upv_1.new("TextLabel", {Name = "Value", Text = "", Visible = false, AnchorPoint = Vector2.new(1, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u40})
    local u45 = UI_upv_1.Button({Name = "Leave", Text = "LEAVE SERVER", TextSize = 18, Style = "Dark", Parent = u10})
    local u46 = UI_upv_1.new("ScrollingFrame", {Name = "Right", ScrollBarThickness = 5, Selectable = false, AutomaticCanvasSize = Enum.AutomaticSize.None, Parent = updateFade})
    local u47 = UI_upv_1.new("Frame", {Name = "Fade", AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Colors_upv_1.PanelLo, ZIndex = 6, Visible = false, [1] = UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(1, 0.05)), Parent = updateFade})
    updateFade = function()
        --[[
          name: updateFade
          line: 356
          upvalues:
            u47 (copy, index: 1)
            u46 (copy, index: 2)
        ]]
        u47.Visible = (u46.AbsoluteCanvasSize.Y - (u46.CanvasPosition.Y + u46.AbsoluteWindowSize.Y)) > 2
    end
    u46:GetPropertyChangedSignal("CanvasPosition"):Connect(updateFade)
    u46:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateFade)
    u46:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateFade)
    local tbl_upv_7 = {Colors_upv_1.Ally, Colors_upv_1.Enemy}
    local u48 = UI_upv_1.SectionTitle("TEAMS", {Parent = u46})
    local function sectionHint(a10)
        --[[
          name: sectionHint
          line: 364
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            u1 (copy, index: 3)
            u46 (copy, index: 4)
        ]]
        return UI_upv_1.new("TextLabel", {Text = "", Name = a10, AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u46})
    end
    local u49 = sectionHint("TeamsHint")
    local u50 = nil
    local function makeSeat(a11, a12, a13)
        --[[
          name: makeSeat
          line: 385
          upvalues:
            Colors_upv_1 (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            u50 (ref,  index: 7)
        ]]
        local Accent_upv_1
        if a12 ~= 0 then
            Accent_upv_1 = tbl_upv_7[a12]
        else
            Accent_upv_1 = Colors_upv_1.Accent
        end
        local u51 = UI_upv_1.new("TextButton", {Name = a13, Text = "", AutoButtonColor = false, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.75, [1] = UI_upv_1.Corner(10), Parent = a11})
        local u52 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        u52.Parent = u51
        local v2 = UI_upv_1.new("Frame", {Name = "Ring", AnchorPoint = Vector2.new(0, 0.5), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u51})
        local u53 = UI_upv_1.Stroke(Colors_upv_1.TextMuted, 1.5, 0.55)
        u53.Parent = v2
        local v3 = UI_upv_1.Icon("plus", 16, Accent_upv_1, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v2})
        local v4 = "TextLabel"
        local v5 = UI_upv_1.new(v4, {Name = "Label", Text = "Open", AnchorPoint = Vector2.new(0, 0.5), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u51})
        local tbl_upv_8 = nil
        local u54 = false
        local function look_upv_1()
            --[[
              name: look
              line: 413
              upvalues:
                tbl_upv_8 (ref,  index: 1)
                u54 (ref,  index: 2)
                UI_upv_1 (copy, index: 3)
                u52 (copy, index: 4)
                Theme_upv_1 (copy, index: 5)
                Accent_upv_1 (copy, index: 6)
                Colors_upv_1 (copy, index: 7)
                u51 (copy, index: 8)
                u53 (copy, index: 9)
            ]]
            local join_1 = tbl_upv_8.join
            local _ = join_1 and u54
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
            Tween_1(u52, Fast_1, tbl_9)
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
            Tween_2(u51, Fast_2, tbl_10)
            local v8
            if tbl_upv_8.join then
                v8 = Accent_upv_1
            else
                v8 = Colors_upv_1.TextMuted
            end
            u53.Color = v8
            u53.Transparency = ((tbl_upv_8.join) and 0.2) or 0.55
        end
        tbl_upv_8 = {join = false, btn = u51, stroke = u52, ring = v2, plus = v3, label = v5, team = a12, look = look_upv_1}
        u51.MouseEnter:Connect(
            function()
                --[[
                  line: 427
                  upvalues:
                    u54 (ref,  index: 1)
                    tbl_upv_8 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    a1 (copy, index: 4)
                    look_upv_1 (copy, index: 5)
                ]]
                u54 = true
                if tbl_upv_8.join and not (UI_upv_1.Touch) then
                    a1.Sounds.Play("Hover")
                end
                look_upv_1()
            end
        )
        u51.MouseLeave:Connect(
            function()
                --[[
                  line: 434
                  upvalues:
                    u54 (ref,  index: 1)
                    look_upv_1 (copy, index: 2)
                ]]
                u54 = false
                look_upv_1()
            end
        )
        u51.Activated:Connect(
            function()
                --[[
                  line: 438
                  upvalues:
                    tbl_upv_8 (ref,  index: 1)
                    UI_upv_1 (copy, index: 2)
                    u51 (copy, index: 3)
                    u50 (ref,  index: 4)
                ]]
                if not tbl_upv_8.join then
                    return
                end
                UI_upv_1.Bump(u51, 0.04)
                u50(tbl_upv_8.team)
            end
        )
        return v4
    end
    local tbl_upv_11 = {}
    local tbl_upv_12 = {}
    for n_1 = 1, 2 do
        local v9 = card("Team" .. n_1, u46)
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
        local u55 = n_1
    end
    local u56 = UI_upv_1.SectionTitle("RANDOM", {Parent = u46})
    local u57 = sectionHint("RandomHint")
    local u58 = card("Random", u46)
    card = makeSeat(u58, 0, "Join")
    table.insert(tbl_upv_12, card)
    local u59 = UI_upv_1.SectionTitle("MAP", {Parent = u46})
    local u55 = UI_upv_1.new("TextLabel", {Name = "MapValue", Text = "", TextSize = 15, AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u46})
    local u60 = UI_upv_1.new("Frame", {Name = "Maps", Parent = u46})
    local u61 = false
    local tbl_upv_14 = {}
    local u62 = false
    local u63 = false
    local function isHost()
        --[[
          name: isHost
          line: 516
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        return Custom_upv_1.IsHost()
    end
    local function stateNow()
        --[[
          name: stateNow
          line: 520
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        local v14 = Custom_upv_1.State() or {}
        return v14
    end
    local function modeOf(a14)
        --[[
          name: modeOf
          line: 525
          upvalues:
            CustomMatch_upv_1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
        ]]
        local Mode_1 = CustomMatch_upv_1.Mode
        local v15
        if tbl_upv_14.mode == nil then
            v15 = a14.mode
        else
            v15 = tbl_upv_14.mode
        end
        return Mode_1(v15)
    end
    local function sizeOf(a15)
        --[[
          name: sizeOf
          line: 528
          upvalues:
            CustomMatch_upv_1 (copy, index: 1)
            modeOf (copy, index: 2)
        ]]
        return CustomMatch_upv_1.TeamSize(modeOf(a15))
    end
    local function teamCardH(a16)
        --[[
          name: teamCardH
          line: 532
          upvalues:
            tbl_upv_2 (ref, index: 1)
        ]]
        return (tbl_upv_2.teamHead + (a16 * tbl_upv_2.seatH) + ((a16 - 1) * tbl_upv_2.seatGap)) + 8
    end
    local tbl_upv_15 = {}
    local u64 = ""
    local u65 = nil
    local function buildMapCards(a17)
        --[[
          name: buildMapCards
          line: 543
          upvalues:
            u64 (ref,  index: 1)
            tbl_upv_15 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u60 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            tbl_upv_2 (ref,  index: 7)
            fromOffset_upv_1 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            Custom_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u65 (ref,  index: 12)
        ]]
        local tbl_16 = ""
        for _, value_1 in a17 do
            tbl_16 = tbl_16 .. value_1.id .. ";"
        end
        if tbl_16 == u64 then
            return
        end
        u64 = tbl_16
        for _, value_2 in tbl_upv_15 do
            value_2.btn:Destroy()
        end
        table.clear(tbl_upv_15)
        tbl_16 = {{id = "", name = "Random", thumb = ""}}
        for _, value_3 in a17 do
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
            tbl_17.Parent = u60
            local v16 = new_1("TextButton", tbl_17)
            local v17 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
            v17.Parent = v16
            local v18 = UI_upv_1.new("ImageLabel", {Name = "Thumb", Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, Image = value_4.thumb or "", BackgroundTransparency = 1, [1] = UI_upv_1.Corner(10), Parent = v16})
            if value_4.id == "" then
                UI_upv_1.Gradient(Color3.fromRGB(52, 58, 74), Color3.fromRGB(26, 29, 38), 120).Parent = v16
                v16.BackgroundColor3 = Color3.new(1, 1, 1)
                UI_upv_1.new("TextLabel", {Text = "?", Name = "Mark", TextSize = 46, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(1, 0.6), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextDim, Parent = v16})
            end
            local tbl_upv_18 = {}
            tbl_upv_18.Name = "Band"
            tbl_upv_18.AnchorPoint = Vector2.new(0, 1)
            tbl_upv_18.Position = UDim2.fromScale(0, 1)
            tbl_upv_18.Size = UDim2.new(1, 0, 0, 34)
            tbl_upv_18.BackgroundColor3 = Colors_upv_1.Void
            tbl_upv_18.BackgroundTransparency = 0
            tbl_upv_18[1], tbl_upv_18[2] = UI_upv_1.Corner(10), UI_upv_1.Gradient(Color3.new(1, 1, 1), Color3.new(1, 1, 1), 90, NumberSequence.new(0.85, 0.2))
            tbl_upv_18.Parent = v16
            local v19 = UI_upv_1.new("Frame", tbl_upv_18)
            local v20 = UI_upv_1.new("TextLabel", {Name = "MapName", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -6), Size = UDim2.new(1, -20, 0, 20), Text = string.upper(value_4.name), FontFace = Fonts_upv_1.Heavy, TextSize = tbl_upv_2.mapName, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v19})
            local tbl_19 = {}
            tbl_19.Name = "Check"
            tbl_19.AnchorPoint = Vector2.new(1, 0)
            tbl_19.Position = UDim2.new(1, -8, 0, 8)
            tbl_19.Size = fromOffset_upv_1(26, 26)
            tbl_19.BackgroundColor3 = Colors_upv_1.Accent
            tbl_19.Visible = false
            tbl_19.ZIndex = 3
            tbl_19[1], tbl_19[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Void, 1, 0.6)
            tbl_19.Parent = v16
            v19 = UI_upv_1.new("Frame", tbl_19)
            UI_upv_1.Icon("check", 16, Colors_upv_1.Text, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v19})
            tbl_upv_18 = {}
            tbl_upv_18.id = value_4.id
            tbl_upv_18.btn = v16
            tbl_upv_18.stroke = v17
            tbl_upv_18.check = v19
            tbl_upv_18.img = v18
            tbl_upv_18.name = v20
            tbl_upv_18.scaleObj = UI_upv_1.GetScaleObj(v16, "HoverScale")
            v16.MouseEnter:Connect(
                function()
                    --[[
                      line: 635
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
            v16.MouseLeave:Connect(
                function()
                    --[[
                      line: 644
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
            v16.Activated:Connect(
                function()
                    --[[
                      line: 650
                      upvalues:
                        Custom_upv_1 (copy, index: 1)
                        u65 (ref,  index: 2)
                        tbl_upv_18 (copy, index: 3)
                    ]]
                    if not Custom_upv_1.IsHost() then
                        return
                    end
                    u65(tbl_upv_18.id)
                end
            )
            table.insert(tbl_upv_15, tbl_upv_18)
        end
    end
    local tbl_upv_20 = {}
    local tbl_upv_21 = {}
    local function headshot(a18, a19)
        --[[
          name: headshot
          line: 663
          upvalues:
            tbl_upv_21 (copy, index: 1)
        ]]
        if a18 <= 0 then
            a19.Image = ""
        elseif tbl_upv_21[a18] then
            a19.Image = tbl_upv_21[a18]
        else
            task.spawn(function() end)
        end
    end
    local u66 = nil
    local function textWidth(a20, a21)
        --[[
          name: textWidth
          line: 689
        ]]
        local success_1, v21 = pcall(function() end)
        if success_1 and type(v21) == "number" then
            return v21
        end
        return (#a20 * a21) * 0.62
    end
    local function makePRow(a22)
        --[[
          name: makePRow
          line: 711
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            u1 (copy, index: 5)
            u66 (ref,  index: 6)
            tbl_upv_21 (copy, index: 7)
            Players_upv_1 (copy, index: 8)
        ]]
        local v22 = UI_upv_1.new("Frame", {Name = "P" .. a22.userId, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.45, UI_upv_1.Corner(10)})
        local tbl_22 = {}
        tbl_22.Name = "Headshot"
        tbl_22.BackgroundColor3 = Colors_upv_1.Raised
        tbl_22[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_22.Parent = v22
        local u67 = UI_upv_1.new("ImageLabel", tbl_22)
        local v23 = UI_upv_1.new("TextLabel", {Name = "PlayerName", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v22})
        local tbl_23 = {}
        tbl_23.Name = "Line"
        tbl_23[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_23.Parent = v22
        local v24 = UI_upv_1.new("Frame", tbl_23)
        local v25 = UI_upv_1.new("TextLabel", {LayoutOrder = 10, Name = "Username", FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v24})
        tbl_23 = UI_upv_1.IconButton({Name = "More", Visible = false, AnchorPoint = Vector2.new(1, 0.5), Color = Colors_upv_1.Raised, Parent = v22})
        UI_upv_1.Glyph("three-dots-horizontal", 20, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = tbl_23})
        local tbl_upv_24 = {group = -1, tagW = 0}
        tbl_upv_24.frame = v22
        tbl_upv_24.img = u67
        tbl_upv_24.name = v23
        tbl_upv_24.line = v24
        tbl_upv_24.sub = v25
        tbl_upv_24.more = tbl_23
        tbl_upv_24.userId = a22.userId
        tbl_23.Activated:Connect(
            function()
                --[[
                  line: 751
                  upvalues:
                    u66 (ref,  index: 1)
                    tbl_upv_24 (copy, index: 2)
                ]]
                u66(tbl_upv_24.userId)
            end
        )
        local userId_upv_1 = a22.userId
        if userId_upv_1 <= 0 then
            u67.Image = ""
        elseif tbl_upv_21[userId_upv_1] then
            u67.Image = tbl_upv_21[userId_upv_1]
        else
            task.spawn(
                function()
                    --[[
                      line: 672
                      upvalues:
                        Players_upv_1 (copy, index: 1)
                        userId_upv_1 (copy, index: 2)
                        tbl_upv_21 (copy, index: 3)
                        u67 (copy, index: 4)
                    ]]
                    local success_2, v26 = pcall(
                        function()
                            --[[
                              line: 673
                              upvalues:
                                Players_upv_1 (copy, index: 1)
                                userId_upv_1 (copy, index: 2)
                            ]]
                            return Players_upv_1:GetUserThumbnailAsync(userId_upv_1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                        end
                    )
                    if not success_2 or type(v26) ~= "string" then
                        return
                    end
                    tbl_upv_21[userId_upv_1] = v26
                    if not u67.Parent then
                        return
                    end
                    u67.Image = v26
                end
            )
        end
        return tbl_upv_24
    end
    local function layoutPRow(a23, a24, a25)
        --[[
          name: layoutPRow
          line: 758
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            fromOffset_upv_1 (copy, index: 2)
        ]]
        local seatH_1 = tbl_upv_2.seatH
        local head_1 = tbl_upv_2.head
        a23.frame.Size = fromOffset_upv_1(a24, seatH_1)
        a23.img.Position = fromOffset_upv_1(10, math.floor((seatH_1 - head_1) / 2))
        a23.img.Size = fromOffset_upv_1(head_1, head_1)
        local v27 = 10 + head_1 + 10
        a23.more.Visible = a25
        a23.more.Size = fromOffset_upv_1(tbl_upv_2.moreW, tbl_upv_2.moreW)
        a23.more.Position = UDim2.new(1, -8, 0.5, 0)
        local v28 = (a25 and (tbl_upv_2.moreW + 16)) or 10
        local v29 = a24 - v27 - v28
        a23.name.Position = fromOffset_upv_1(v27, (math.floor(seatH_1 / 2) - tbl_upv_2.playerName) - 3)
        a23.name.Size = fromOffset_upv_1(v29, tbl_upv_2.playerName + 4)
        a23.name.TextSize = tbl_upv_2.playerName
        a23.line.Position = fromOffset_upv_1(v27, math.floor(seatH_1 / 2) + 2)
        a23.line.Size = fromOffset_upv_1(v29, 18)
        a23.sub.TextSize = tbl_upv_2.playerSub
        a23.sub.Size = fromOffset_upv_1(math.max(0, v29 - a23.tagW), 18)
    end
    local tbl_upv_25 = {}
    local function teamOfRow(a26)
        --[[
          name: teamOfRow
          line: 779
          upvalues:
            tbl_upv_25 (copy, index: 1)
        ]]
        local v30 = tbl_upv_25[a26.userId]
        if v30 == nil then
            v30 = tonumber(a26.team) or 0
        end
        if v30 ~= 1 and v30 ~= 2 then
            return 0
        end
        return v30
    end
    local u68 = 600
    local u69 = 294
    local u70 = nil
    local tbl_upv_26 = {{}, {}, {}}
    local function tag(a27, a28, a29, a30, a31)
        --[[
          name: tag
          line: 696
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
        tbl_27.BackgroundColor3 = a29
        tbl_27.LayoutOrder = a31
        tbl_27[1], tbl_27[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 7, 0, 7)
        tbl_27.Parent = a27
        local v31 = UI_upv_1.new("Frame", tbl_27)
        UI_upv_1.new("TextLabel", {TextSize = 11, Text = a28, FontFace = Fonts_upv_1.Heavy, TextColor3 = a30, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v31})
        local u71 = 11
        local success_3, v32 = pcall(
            function()
                --[[
                  line: 690
                  upvalues:
                    TextService_upv_1 (copy, index: 1)
                    a28 (copy, index: 2)
                    u71 (copy, index: 3)
                ]]
                return TextService_upv_1:GetTextSize(a28, u71, Enum.Font.BuilderSansExtraBold, Vector2.new(1000, 100)).X
            end
        )
        local v33
        if (success_3) and type(v32) == "number" then
            v33 = v32
        else
            v33 = #a28 * 11 * 0.62
        end
        return (math.ceil(v33) + 14) + 5
    end
    local function setSeat(a32, a33)
        --[[
          name: setSeat
          line: 446
          upvalues:
            Theme_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            tbl_upv_7 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
        ]]
        a32.join = a33
        a32.label.Text = (a33 and "JOIN") or "Open"
        local label_1 = a32.label
        local v34
        local v36 = nil
        if a33 then
            v36 = Theme_upv_1.Lighten
            local v35
            if a32.team ~= 0 then
                v35 = tbl_upv_7[a32.team]
            else
                v35 = Colors_upv_1.Accent
            end
            v34 = v36(v35, 0.3)
        else
            v34 = Colors_upv_1.TextMuted
        end
        label_1.TextColor3 = v34
        local label_2 = a32.label
        if a33 then
            v36 = Fonts_upv_1.Heavy
        else
            v36 = Fonts_upv_1.SemiBold
        end
        label_2.FontFace = v36
        a32.plus.Visible = a33
        a32.btn.Selectable = a33
        a32.look()
    end
    local function paintTeams(a34)
        --[[
          name: paintTeams
          line: 790
          upvalues:
            Custom_upv_1 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            modeOf (copy, index: 3)
            u70 (ref,  index: 4)
            tbl_upv_25 (copy, index: 5)
            LocalPlayer_upv_1 (copy, index: 6)
            tbl_upv_20 (copy, index: 7)
            tbl_upv_26 (copy, index: 8)
            makePRow (copy, index: 9)
            tag (copy, index: 10)
            Colors_upv_1 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
            layoutPRow (copy, index: 13)
            u69 (ref,  index: 14)
            fromOffset_upv_1 (copy, index: 15)
            UI_upv_1 (copy, index: 16)
            tbl_upv_2 (ref,  index: 17)
            tbl_upv_11 (copy, index: 18)
            setSeat (copy, index: 19)
            u58 (copy, index: 20)
            card (copy, index: 21)
            u68 (ref,  index: 22)
            u56 (copy, index: 23)
            u57 (copy, index: 24)
            u49 (copy, index: 25)
        ]]
        local v37 = ((type(a34.players) ~= "table") and {}) or (a34.players)
        local u72 = Custom_upv_1.IsHost()
        local v38 = true
        if a34.status ~= "Match" then
            v38 = a34.status == "Results"
        end
        local v39 = CustomMatch_upv_1.TeamSize(modeOf(a34))
        local tbl_28 = {{}, {}, {}}
        local tbl_29 = {}
        u70 = nil
        local v40 = nil
        local v41 = nil
        local v42 = nil
        for _, value_5 in v37 do
            if type(value_5) ~= "table" or type(value_5.userId) ~= "number" then
                continue
            end
            tbl_29[value_5.userId] = true
            v40 = tbl_upv_25[value_5.userId]
            if v40 == nil then
                v40 = tonumber(value_5.team) or 0
            end
            if v40 == 1 or v40 == 2 then
                v41 = v40
                if value_5.userId == LocalPlayer_upv_1.UserId then
                    u70 = v41
                end
                if v41 ~= 0 then
                    v42 = v41
                else
                    v42 = 3
                end
                local v43 = nil
                table.insert(tbl_28[v42], v43)
            end
            v41 = 0
            if value_5.userId == LocalPlayer_upv_1.UserId then
                u70 = v41
            end
            if v41 ~= 0 then
                v42 = v41
            else
                v42 = 3
            end
            local v43 = nil
            table.insert(tbl_28[v42], v43)
        end
        for key_2, value_6 in tbl_upv_20 do
            if not (tbl_29[key_2]) then
                value_6.frame:Destroy()
                tbl_upv_20[key_2] = nil
            end
        end
        for n_3 = 1, 2 do
            while v39 < #tbl_28[n_3] do
                table.insert(tbl_28[3], (table.remove(tbl_28[n_3])))
            end
        end
        for n_4 = 1, 3 do
            tbl_upv_26[n_4] = {}
            for _, value_7 in tbl_28[n_4] do
                table.insert(tbl_upv_26[n_4], value_7.userId)
            end
        end
        local function place_1(a35, a36, a37, a38, a39)
            --[[
              name: place
              line: 829
              upvalues:
                tbl_upv_20 (copy, index: 1)
                makePRow (copy, index: 2)
                a34 (copy, index: 3)
                tag (copy, index: 4)
                Colors_upv_1 (copy, index: 5)
                Theme_upv_1 (copy, index: 6)
                LocalPlayer_upv_1 (copy, index: 7)
                layoutPRow (copy, index: 8)
                u69 (ref,  index: 9)
                u72 (copy, index: 10)
                fromOffset_upv_1 (copy, index: 11)
                UI_upv_1 (copy, index: 12)
            ]]
            local v44 = tbl_upv_20[a35.userId]
            if not (v44) then
                v44 = makePRow(a35)
                tbl_upv_20[a35.userId] = v44
            end
            v44.name.AutoLocalize = false
            v44.sub.AutoLocalize = false
            v44.name.Text = tostring(a35.name or "?")
            v44.sub.Text = "@" .. tostring(a35.username or "")
            for _, value_8 in v44.line:GetChildren() do
                if value_8:IsA("Frame") then
                    value_8:Destroy()
                end
            end
            local v45 = 0
            local v46
            if a35.userId ~= a34.ownerId then
                v46 = v45
            else
                v46 = v45 + tag(v44.line, "HOST", Colors_upv_1.Gold:Lerp(Colors_upv_1.Panel, 0.72), Theme_upv_1.Lighten(Colors_upv_1.Gold, 0.1), 1)
            end
            if a35.userId ~= LocalPlayer_upv_1.UserId then
                v45 = v46
            else
                v45 = v46 + tag(v44.line, "YOU", Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.7), Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.25), 2)
            end
            v45 = ((a35.playing) and (v45 + tag(v44.line, "PLAYING", Colors_upv_1.Success:Lerp(Colors_upv_1.Panel, 0.75), Theme_upv_1.Lighten(Colors_upv_1.Success, 0.1), 3)))
                or (((a35.watching) and (v45 + tag(v44.line, "WATCHING", Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.75), Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.25), 3))) or (((a35.satOut) and (v45 + tag(v44.line, "NEXT UP", Colors_upv_1.Warning:Lerp(Colors_upv_1.Panel, 0.75), Theme_upv_1.Lighten(Colors_upv_1.Warning, 0.1), 3))) or v45))
            v44.tagW = v45
            v44.frame.Parent = a36
            layoutPRow(v44, u69 - 16, u72 and (a35.userId ~= LocalPlayer_upv_1.UserId))
            v44.frame.Position = fromOffset_upv_1(a37, a38)
            if v44.group == a39 then
                return
            end
            if v44.group ~= -1 then
                UI_upv_1.Enter(v44.frame, Vector2.new(0, 6), 0, fromOffset_upv_1(a37, a38))
            end
            v44.group = a39
        end
        local u73 = tbl_upv_2.seatH + tbl_upv_2.seatGap
        local v56 = nil
        for n_5 = 1, 2 do
            v56 = tbl_upv_11[n_5]
            local v48 = tbl_28[n_5]
            v56.count.Text = string.format("%d/%d", #v48, v39)
            if v56.n ~= #v48 then
                if v56.n ~= -1 then
                    UI_upv_1.Pop(v56.count, 1.25)
                end
                v56.n = #v48
            end
            v56.frame.Size = fromOffset_upv_1(u69, (tbl_upv_2.teamHead + (v39 * tbl_upv_2.seatH) + ((v39 - 1) * tbl_upv_2.seatGap)) + 8)
            local v49 = false
            v41 = v49
            for n_6 = 1, CustomMatch_upv_1.TEAM_SIZE do
                local v50 = tbl_upv_2.teamHead + (n_6 - 1) * u73
                local v51 = v56.seats[n_6]
                local v52 = v48[n_6]
                if v39 < n_6 then
                    v51.btn.Visible = false
                    continue
                end
                if v52 then
                    place_1(v52, v56.frame, 8, v50, n_5)
                    v51.btn.Visible = false
                else
                    v51.btn.Visible = true
                    v51.btn.Position = fromOffset_upv_1(8, v50)
                    v51.btn.Size = fromOffset_upv_1(u69 - 16, tbl_upv_2.seatH)
                    local v53 = (u70 ~= nil) and ((u70 ~= n_5) and (not v41))
                    v41 = v41 or v53
                    setSeat(v51, v53)
                end
            end
        end
        local v54 = tbl_28[3]
        local v55 = (u70 ~= nil) and (u70 ~= 0)
        if v55 then
            v56 = 1
        else
            v56 = 0
        end
        local u74 = u69 + tbl_upv_2.teamGap
        local function at_1(a40)
            --[[
              name: at
              line: 911
              upvalues:
                u74 (copy, index: 1)
                u73 (copy, index: 2)
            ]]
            return 8 + (((a40 - 1) % 2) * u74), 8 + (((a40 - 1) // 2) * u73)
        end
        for key_3, value_9 in v54 do
            place_1(value_9, u58, 8 + (((key_3 - 1) % 2) * u74), 8 + (((key_3 - 1) // 2) * u73), 0)
        end
        card.btn.Visible = v55
        if v55 then
            local v57 = #v54 + 1
            card.btn.Position = fromOffset_upv_1(8 + (((v57 - 1) % 2) * u74), 8 + (((v57 - 1) // 2) * u73))
            card.btn.Size = fromOffset_upv_1(u69 - 16, tbl_upv_2.seatH)
            setSeat(card, true)
        end
        local v58 = math.ceil((#v54 + v56) / 2)
        u58.Size = fromOffset_upv_1(u68, ((v58 > 0) and (16 + (v58 * tbl_upv_2.seatH) + (v58 - 1) * tbl_upv_2.seatGap)) or 0)
        u58.Visible = v58 > 0
        u56.Visible = v58 > 0
        u57.Visible = v58 > 0
        local Text_1 = u56.Text
        Text_1.Text = not (#v54 > 0) and "RANDOM" or string.format("RANDOM  \194\183  %d", #v54)
        u49.Text = (v38 and "Picks count from the next match") or "Join a team, or stay random"
        u57.Text = ((v39 ~= 1) and "Placed where there's room when the match starts") or "They watch and play next"
    end
    local function anyPicks(a41)
        --[[
          name: anyPicks
          line: 952
          upvalues:
            tbl_upv_25 (copy, index: 1)
        ]]
        local v60 = ((type(a41.players) ~= "table") and {}) or (a41.players)
        local v61 = nil
        local v62 = nil
        for _, value_10 in v60 do
            if type(value_10) ~= "table" then
                continue
            end
            v61 = tbl_upv_25[value_10.userId]
            if v61 == nil then
                v61 = tonumber(value_10.team) or 0
            end
            if v61 == 1 or v61 == 2 then
                v62 = v61
                if v62 == 0 then
                    continue
                end
                return true
            end
            v62 = 0
            if v62 == 0 then
                continue
            end
            return true
        end
        return false
    end
    local function paintSwitches(a42, a43)
        --[[
          name: paintSwitches
          line: 961
          upvalues:
            Custom_upv_1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            u39 (copy, index: 3)
            u37 (copy, index: 4)
            tbl_upv_6 (copy, index: 5)
            u38 (copy, index: 6)
            u43 (copy, index: 7)
            u44 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            CustomMatch_upv_1 (copy, index: 10)
            u28 (copy, index: 11)
            u27 (copy, index: 12)
            u29 (copy, index: 13)
            u24 (copy, index: 14)
            u25 (copy, index: 15)
            u42 (copy, index: 16)
            u34 (copy, index: 17)
            u63 (ref,  index: 18)
            u30 (copy, index: 19)
            u20 (copy, index: 20)
        ]]
        local v63 = Custom_upv_1.IsHost()
        local v64
        if tbl_upv_14.public == nil then
            v64 = a42.public == true
        else
            v64 = tbl_upv_14.public
        end
        u39:Set(v64, a43)
        u39.Instance.Visible = v63
        local v65
        if v64 then
            v65 = "PUBLIC"
        else
            v65 = "PRIVATE"
        end
        u37.Text = v65
        tbl_upv_6.Text = (v64 and "globe-simplified") or "lock-closed"
        u38.Text = (v64 and "Listed in every lobby's Custom Matches") or "Only people with the code can join"
        local v66
        if tbl_upv_14.bots == nil then
            v66 = a42.bots == true
        else
            v66 = tbl_upv_14.bots
        end
        u43:Set(v66, a43)
        u43.Instance.Visible = v63
        u44.Visible = not v63
        if v66 then
            v65 = "ON"
        else
            v65 = "OFF"
        end
        u44.Text = v65
        if v66 then
            v65 = Colors_upv_1.Text
        else
            v65 = Colors_upv_1.TextDim
        end
        u44.TextColor3 = v65
        local Mode_2 = CustomMatch_upv_1.Mode
        local v67
        if tbl_upv_14.mode == nil then
            v67 = a42.mode
        else
            v67 = tbl_upv_14.mode
        end
        local v68 = Mode_2(v67)
        v67 = v68 == "1v1"
        if u28.Value ~= v68 or a43 then
            u28:Set(v68, a43)
        end
        if u27.Value ~= v68 or a43 then
            u27:Set(v68, a43)
        end
        u28.Instance.Visible = v63
        u29.Visible = not v63
        u29.Text = CustomMatch_upv_1.ModeLabel(v68)
        u24.Text = (v67 and "person") or "three-people"
        u25.Text = (v67 and "One on one") or "Three a side"
        u42.Text = (v67 and "A bot takes an empty side") or "Bots take the empty slots, up to 3v3"
        u34.Visible = v63 and (not u63)
        u30.AutoButtonColor = false
        u20.Text.Text = (v63 and "SETTINGS") or "SERVER"
    end
    local function teamsPreview(a44)
        --[[
          name: teamsPreview
          line: 937
          upvalues:
            tbl_upv_14 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            modeOf (copy, index: 3)
        ]]
        local v69
        if tbl_upv_14.bots == nil then
            v69 = a44.bots
        else
            v69 = tbl_upv_14.bots
        end
        if v69 then
            local v70 = CustomMatch_upv_1.TeamSize(modeOf(a44))
            return string.format("%d V %d", v70, v70)
        else
            local split_1 = a44.split
            if type(split_1) ~= "table" then
                return ""
            end
            local v71 = tonumber(split_1[1]) or 0
            local v72 = tonumber(split_1[2]) or 0
            if v71 + v72 >= 2 then
                return (string.format("%d V %d", v71, v72))
            end
            return ""
        end
    end
    local function paintMatch(a45)
        --[[
          name: paintMatch
          line: 1014
          upvalues:
            Custom_upv_1 (copy, index: 1)
            u16 (copy, index: 2)
            tbl_upv_5 (copy, index: 3)
            u17 (copy, index: 4)
            u27 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u18 (copy, index: 7)
            u62 (ref,  index: 8)
            u13 (copy, index: 9)
            Colors_upv_1 (copy, index: 10)
            u14 (copy, index: 11)
            u15 (copy, index: 12)
            CustomMatch_upv_1 (copy, index: 13)
            modeOf (copy, index: 14)
            teamsPreview (copy, index: 15)
            tbl_upv_14 (copy, index: 16)
            Theme_upv_1 (copy, index: 17)
            u19 (copy, index: 18)
            u1 (copy, index: 19)
            anyPicks (copy, index: 20)
        ]]
        local v73 = a45.status or "Lobby"
        local v74 = true
        if v73 ~= "Match" then
            v74 = v73 == "Results"
        end
        local v75 = Custom_upv_1.IsHost()
        u16.Instance.Visible = v75 and (not v74)
        tbl_upv_5.Instance.Visible = v75 and v74
        u17.Visible = not v75
        u27.Instance.Visible = UI_upv_1.Compact and v75
        u18.Text = "HOSTED BY " .. string.upper(tostring(a45.ownerName or "?"))
        tbl_upv_5:SetText(((v73 ~= "Results") and "END MATCH") or "CLOSE RESULTS")
        u16:SetEnabled((a45.canStart == true) and (not u62))
        u16:SetText(((a45.startHint ~= "Starting...") and "START MATCH") or "STARTING...")
        if v73 == "Match" then
            u13.BackgroundColor3 = Colors_upv_1.Warning
            u14.Text = "Match in progress"
        elseif v73 ~= "Results" then
            u13.BackgroundColor3 = Colors_upv_1.Success
            u14.Text = "Waiting to start"
        else
            u13.BackgroundColor3 = Colors_upv_1.Accent
            u14.Text = "Showing the results"
        end
        local Compact_1 = UI_upv_1.Compact
        local v76
        if Compact_1 and (not v75) then
            v76 = CustomMatch_upv_1.ModeLabel(modeOf(a45))
        else
            v76 = (v74 and "") or (teamsPreview(a45))
        end
        u15.Text = v76
        local v77, v78 = nil, nil
        if Compact_1 then
            v77 = CustomMatch_upv_1.Mode
            local v79
            if tbl_upv_14.mode == nil then
                v79 = a45.mode
            else
                v79 = tbl_upv_14.mode
            end
            if v77(v79) ~= "1v1" then
                v78 = Colors_upv_1.TextDim
            else
                v78 = Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.2)
            end
        else
            v78 = Colors_upv_1.TextDim
        end
        u15.TextColor3 = v78
        if v74 then
            u19.Text = "Everyone comes back here after the match"
            u19.TextColor3 = u1
        elseif v75 then
            if a45.canStart then
                local v80
                if tbl_upv_14.bots == nil then
                    v80 = a45.bots == true
                else
                    v80 = tbl_upv_14.bots
                end
                local v81 = ((type(a45.players) ~= "table") and 0) or (#a45.players)
                if anyPicks(a45) then
                    u19.Text = (v80 and "Picked teams stay, bots fill the empty slots") or "Picked teams stay, the rest are shuffled"
                elseif CustomMatch_upv_1.TeamSize(modeOf(a45)) == 1 and (v81 > 2) then
                    u19.Text = "Two fight, the rest watch and go next"
                else
                    u19.Text = (v80 and "Teams are shuffled, bots fill the empty slots") or "Teams are shuffled every match"
                end
                u19.TextColor3 = u1
            else
                u19.Text = tostring(a45.startHint or "")
                if a45.startHint ~= "Starting..." then
                    v78 = Theme_upv_1.Lighten(Colors_upv_1.Warning, 0.15)
                else
                    v78 = u1
                end
                u19.TextColor3 = v78
            end
        else
            u19.Text = "The host picks the map and starts the match"
            u19.TextColor3 = u1
        end
    end
    local u75 = false
    local function paintCode(a46)
        --[[
          name: paintCode
          line: 1063
          upvalues:
            Custom_upv_1 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            u4 (copy, index: 3)
            tbl_upv_3 (copy, index: 4)
            u5 (copy, index: 5)
            u6 (copy, index: 6)
        ]]
        local v82 = a46.public == false and (not Custom_upv_1.IsRevealed())
        local v83 = CustomMatch_upv_1.FormatCode(tostring(a46.code or ""))
        if u4.Text ~= v83 then
            u4.Text = v83
        end
        u4.TextTransparency = (v82 and 1) or 0
        tbl_upv_3.Visible = v82
        u5.Visible = v82
        u6.Text = Custom_upv_1.IsRevealed() and "eye-slash" or "eye"
        local v85 = (v82 and -52) or -14
        u4.Position = UDim2.new(1, v85, 0, 0)
        tbl_upv_3.Position = UDim2.new(1, v85 - 2, 0.5, 0)
        u4.Size = UDim2.new(1, v85 - 56, 1, 0)
    end
    local u76 = false
    local function stack()
        --[[
          name: stack
          line: 1094
          upvalues:
            u48 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            u49 (copy, index: 3)
            u68 (ref,  index: 4)
            tbl_upv_2 (ref,  index: 5)
            tbl_upv_11 (copy, index: 6)
            u69 (ref,  index: 7)
            u58 (copy, index: 8)
            u56 (copy, index: 9)
            u57 (copy, index: 10)
            u59 (copy, index: 11)
            u55 (copy, index: 12)
            u60 (copy, index: 13)
            u76 (ref,  index: 14)
            u45 (copy, index: 15)
            u46 (copy, index: 16)
        ]]
        local v86 = 8
        u48.Position = fromOffset_upv_1(8, v86)
        u49.Position = fromOffset_upv_1(u68 + 8, v86 + 3)
        local v87 = v86 + (tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
        tbl_upv_11[1].frame.Position = fromOffset_upv_1(8, v87)
        tbl_upv_11[2].frame.Position = fromOffset_upv_1((u69 + 8) + tbl_upv_2.teamGap, v87)
        v87 = v87 + (tbl_upv_11[1].frame.Size.Y.Offset + tbl_upv_2.blockGap)
        if u58.Visible then
            u56.Position = fromOffset_upv_1(8, v87)
            u57.Position = fromOffset_upv_1(u68 + 8, v87 + 3)
            v87 = v87 + (tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
            u58.Position = fromOffset_upv_1(8, v87)
            v87 = v87 + (u58.Size.Y.Offset + tbl_upv_2.blockGap)
        end
        u59.Position = fromOffset_upv_1(8, v87)
        u55.Position = fromOffset_upv_1(u68 + 8, v87 + 3)
        v87 = v87 + (tbl_upv_2.sectionH + tbl_upv_2.sectionGap)
        u60.Position = fromOffset_upv_1(8, v87)
        v87 = v87 + u60.Size.Y.Offset
        if u76 then
            u45.Instance.Position = fromOffset_upv_1(8, v87 + 16)
            v87 = v87 + (16 + tbl_upv_2.leaveH)
        end
        u46.CanvasSize = fromOffset_upv_1(0, v87 + 8)
    end
    local function paintHeader(a47)
        --[[
          name: paintHeader
          line: 1080
          upvalues:
            u2 (copy, index: 1)
            Custom_upv_1 (copy, index: 2)
            CustomMatch_upv_1 (copy, index: 3)
            paintCode (copy, index: 4)
            u35 (copy, index: 5)
            u32 (copy, index: 6)
        ]]
        u2.Title.Text = "CUSTOM MATCH"
        local v88 = ((type(a47.players) ~= "table") and 0) or (#a47.players)
        local v89 = ((Custom_upv_1.IsHost()) and "") or ("  \194\183  hosted by " .. tostring(a47.ownerName or "?"))
        local Subtitle_1 = u2.Subtitle
        local str_1 = tostring(a47.name or "")
        local v90 = tonumber(a47.max) or (CustomMatch_upv_1.MAX_PLAYERS)
        Subtitle_1.Text = string.format("%s  \194\183  %d/%d players%s", str_1, v88, v90, v89)
        paintCode(a47)
        if (u35.Visible) then
            return
        end
        u32.AutoLocalize = false
        u32.Text = tostring(a47.name or "")
    end
    local function paintMaps(a48)
        --[[
          name: paintMaps
          line: 994
          upvalues:
            buildMapCards (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            tbl_upv_15 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u55 (copy, index: 5)
        ]]
        local v91 = ((type(a48.maps) ~= "table") and {}) or (a48.maps)
        buildMapCards(v91)
        local v92
        if tbl_upv_14.map == nil then
            v92 = a48.map or ""
        else
            v92 = tbl_upv_14.map
        end
        local v93 = nil
        for _, value_11 in tbl_upv_15 do
            local v94 = value_11.id == v92
            value_11.check.Visible = v94
            local stroke_1 = value_11.stroke
            if v94 then
                v93 = Colors_upv_1.Accent
            else
                v93 = Colors_upv_1.Stroke
            end
            stroke_1.Color = v93
            value_11.stroke.Thickness = (v94 and 3) or 1
            value_11.stroke.Transparency = (v94 and 0) or 0.88
            local img_1 = value_11.img
            if v94 then
                v93 = 0
                img_1.ImageTransparency = v93
                continue
            end
            if v92 ~= "" then
                v93 = 0.15
            else
                v93 = 0
            end
            img_1.ImageTransparency = v93
        end
        local v95 = "RANDOM"
        local v96 = ((type(a48.maps) ~= "table") and {}) or (a48.maps)
        local v97 = v95
        for _, value_12 in v96 do
            if value_12.id == v92 then
                v97 = string.upper(value_12.name)
            end
        end
        u55.Text = v97
    end
    local function paint(a49)
        --[[
          name: paint
          line: 1121
          upvalues:
            Custom_upv_1 (copy, index: 1)
            u61 (ref,  index: 2)
            paintHeader (copy, index: 3)
            paintMatch (copy, index: 4)
            paintSwitches (copy, index: 5)
            paintMaps (copy, index: 6)
            paintTeams (copy, index: 7)
            stack (copy, index: 8)
        ]]
        local v98 = Custom_upv_1.State() or {}
        u61 = v98
        paintHeader(v98)
        paintMatch(v98)
        paintSwitches(v98, a49)
        paintMaps(v98)
        paintTeams(v98)
        stack()
    end
    local function host(a50, a51, a52, a53)
        --[[
          name: host
          line: 1133
          upvalues:
            tbl_upv_14 (copy, index: 1)
            paint (copy, index: 2)
            Custom_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
        ]]
        if a52 then
            tbl_upv_14[a52] = a53
            paint()
        end
        local v99, v100 = Custom_upv_1.Host(a50, a51)
        if a52 then
            tbl_upv_14[a52] = nil
        end
        if not (v99) then
            a1.Toast(tostring(v100), "error")
        end
        paint()
        return v99
    end
    u65 = function(a54)
        --[[
          line: 1149
          upvalues:
            Custom_upv_1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            a1 (copy, index: 3)
            tbl_upv_15 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            host (copy, index: 6)
        ]]
        local v101 = Custom_upv_1.State() or {}
        local v102
        if tbl_upv_14.map == nil then
            v102 = v101.map or ""
        else
            v102 = tbl_upv_14.map
        end
        if a54 == v102 then
            return
        end
        a1.Sounds.Play("Select")
        for _, value_13 in tbl_upv_15 do
            if value_13.id == a54 then
                UI_upv_1.Bump(value_13.btn, 0.05)
            end
        end
        task.spawn(host, "SetMap", a54, "map", a54)
    end
    local tbl_upv_30 = {}
    local function sideCount(a55, a56)
        --[[
          name: sideCount
          line: 1166
          upvalues:
            Custom_upv_1 (copy, index: 1)
            tbl_upv_25 (copy, index: 2)
        ]]
        local v103 = 0
        local v104 = Custom_upv_1.State() or {}
        local v105
        if type(v104.players) ~= "table" then
            v105 = {}
        else
            v105 = v104.players
        end
        local v106 = nil
        local v107 = nil
        for _, value_14 in v105 do
            if type(value_14) ~= "table" or value_14.userId == a56 then
                continue
            end
            v106 = tbl_upv_25[value_14.userId]
            if v106 == nil then
                v106 = tonumber(value_14.team) or 0
            end
            if v106 == 1 or v106 == 2 then
                v107 = v106
                if v107 == a55 then
                    v103 = v103 + 1
                    continue
                end
            end
            v107 = 0
            if v107 == a55 then
                v103 = v103 + 1
            end
        end
        return v103
    end
    local function setTeamOf(a57, a58)
        --[[
          name: setTeamOf
          line: 1177
          upvalues:
            tbl_upv_30 (copy, index: 1)
            tbl_upv_25 (copy, index: 2)
            paint (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            Custom_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
        ]]
        tbl_upv_30[a57] = (tbl_upv_30[a57] or 0) + 1
        local v108 = tbl_upv_30[a57]
        tbl_upv_25[a57] = a58
        paint()
        local v109, v110
        if a57 ~= LocalPlayer_upv_1.UserId then
            local v111, v112 = Custom_upv_1.Host("Move", {userId = a57, team = a58})
            v109, v110 = v111, v112
        else
            local v113, v114 = Custom_upv_1.Host("Team", a58)
            v109, v110 = v113, v114
        end
        if tbl_upv_30[a57] == v108 then
            tbl_upv_25[a57] = nil
        end
        if not (v109) then
            a1.Toast(tostring(v110), "error")
        end
        paint()
    end
    u50 = function(a59)
        --[[
          line: 1196
          upvalues:
            u70 (ref,  index: 1)
            sideCount (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            Custom_upv_1 (copy, index: 4)
            CustomMatch_upv_1 (copy, index: 5)
            modeOf (copy, index: 6)
            a1 (copy, index: 7)
            setTeamOf (copy, index: 8)
        ]]
        if u70 == nil or u70 == a59 then
            return
        end
        if a59 ~= 0 then
            local v115 = sideCount(a59, LocalPlayer_upv_1.UserId)
            local v116 = Custom_upv_1.State() or {}
            if CustomMatch_upv_1.TeamSize(modeOf(v116)) <= v115 then
                a1.Toast(("Team %* is full"):format(a59), "info")
                return
            end
        end
        a1.Sounds.Play("Select")
        task.spawn(setTeamOf, LocalPlayer_upv_1.UserId, a59)
    end
    u36.Activated:Connect(
        function()
            --[[
              line: 1208
              upvalues:
                Custom_upv_1 (copy, index: 1)
                tbl_upv_14 (copy, index: 2)
                a1 (copy, index: 3)
                host (copy, index: 4)
            ]]
            if not Custom_upv_1.IsHost() then
                return
            end
            local v117 = Custom_upv_1.State() or {}
            local v118
            if tbl_upv_14.public == nil then
                v118 = v117.public == true
            else
                v118 = tbl_upv_14.public
            end
            local Play_1 = a1.Sounds.Play
            local tbl_31 = {pitch = 0}
            local v119
            if v118 then
                v119 = 0.94
            else
                v119 = 1.08
            end
            tbl_31.pitch = v119
            Play_1("Click", tbl_31)
            task.spawn(host, "SetPublic", not v118, "public", not v118)
        end
    )
    u26 = function(a60)
        --[[
          line: 1218
          upvalues:
            Custom_upv_1 (copy, index: 1)
            CustomMatch_upv_1 (copy, index: 2)
            tbl_upv_14 (copy, index: 3)
            a1 (copy, index: 4)
            host (copy, index: 5)
        ]]
        if not Custom_upv_1.IsHost() then
            return
        end
        local v120 = CustomMatch_upv_1.Mode(a60)
        local v121 = Custom_upv_1.State() or {}
        local Mode_3 = CustomMatch_upv_1.Mode
        local v122
        if tbl_upv_14.mode == nil then
            v122 = v121.mode
        else
            v122 = tbl_upv_14.mode
        end
        if v120 == Mode_3(v122) then
            return
        end
        local Play_2 = a1.Sounds.Play
        local tbl_32 = {pitch = 0}
        tbl_32.pitch = ((v120 ~= "1v1") and 0.94) or 1.08
        Play_2("Click", tbl_32)
        task.spawn(host, "SetMode", v120, "mode", v120)
    end
    u23.Activated:Connect(
        function()
            --[[
              line: 1229
              upvalues:
                Custom_upv_1 (copy, index: 1)
                u26 (ref,  index: 2)
                CustomMatch_upv_1 (copy, index: 3)
                tbl_upv_14 (copy, index: 4)
            ]]
            if Custom_upv_1.IsHost() then
                local v123 = Custom_upv_1.State() or {}
                local Mode_4 = CustomMatch_upv_1.Mode
                local v124
                if tbl_upv_14.mode == nil then
                    v124 = v123.mode
                else
                    v124 = tbl_upv_14.mode
                end
                local v125
                if Mode_4(v124) ~= "1v1" then
                    v125 = "1v1"
                else
                    v125 = "3v3"
                end
                u26(v125)
            end
        end
    )
    u40.Activated:Connect(
        function()
            --[[
              line: 1234
              upvalues:
                Custom_upv_1 (copy, index: 1)
                tbl_upv_14 (copy, index: 2)
                a1 (copy, index: 3)
                host (copy, index: 4)
            ]]
            if not Custom_upv_1.IsHost() then
                return
            end
            local v126 = Custom_upv_1.State() or {}
            local v127
            if tbl_upv_14.bots == nil then
                v127 = v126.bots == true
            else
                v127 = tbl_upv_14.bots
            end
            local Play_3 = a1.Sounds.Play
            local tbl_33 = {pitch = 0}
            local v128
            if v127 then
                v128 = 0.94
            else
                v128 = 1.08
            end
            tbl_33.pitch = v128
            Play_3("Click", tbl_33)
            task.spawn(host, "SetBots", not v127, "bots", not v127)
        end
    )
    u16.Activated:Connect(
        function()
            --[[
              line: 1244
              upvalues:
                u62 (ref,  index: 1)
                u16 (copy, index: 2)
                Custom_upv_1 (copy, index: 3)
                a1 (copy, index: 4)
                paint (copy, index: 5)
            ]]
            if u62 then
                return
            end
            u62 = true
            u16:SetText("STARTING...")
            u16:SetEnabled(false)
            local v129, v130 = Custom_upv_1.Host("Start", nil)
            if not (v129) then
                a1.Toast(tostring(v130), "error")
            end
            paint()
            u62 = false
            if v129 then
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
          line: 1262
          upvalues:
            u63 (ref,  index: 1)
            u35 (copy, index: 2)
            Custom_upv_1 (copy, index: 3)
            CustomMatch_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            u32 (copy, index: 6)
            u31 (copy, index: 7)
            u34 (copy, index: 8)
            u33 (copy, index: 9)
        ]]
        if u63 then
            return
        end
        u63 = true
        local v131 = Custom_upv_1.State() or {}
        u35.Text = tostring(v131.name or "")
        u35.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
        u35.Visible = true
        u32.Visible = false
        u31.Visible = false
        u34.Visible = false
        u33.Visible = false
        u35:CaptureFocus()
    end
    local function endEdit()
        --[[
          name: endEdit
          line: 1276
          upvalues:
            u63 (ref,  index: 1)
            u35 (copy, index: 2)
            u32 (copy, index: 3)
            u31 (copy, index: 4)
            u34 (copy, index: 5)
            u33 (copy, index: 6)
        ]]
        u63 = false
        u35.Visible = false
        u32.Visible = true
        u31.Visible = true
        u34.Visible = true
        u33.Visible = true
    end
    u30.Activated:Connect(
        function()
            --[[
              line: 1284
              upvalues:
                Custom_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u63 (ref,  index: 3)
                u35 (copy, index: 4)
                CustomMatch_upv_1 (copy, index: 5)
                LocalPlayer_upv_1 (copy, index: 6)
                u32 (copy, index: 7)
                u31 (copy, index: 8)
                u34 (copy, index: 9)
                u33 (copy, index: 10)
            ]]
            if not Custom_upv_1.IsHost() then
                return
            end
            a1.Sounds.Play("Click")
            if u63 then
                return
            end
            u63 = true
            local v132 = Custom_upv_1.State() or {}
            u35.Text = tostring(v132.name or "")
            u35.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
            u35.Visible = true
            u32.Visible = false
            u31.Visible = false
            u34.Visible = false
            u33.Visible = false
            u35:CaptureFocus()
        end
    )
    u35:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 1291
              upvalues:
                u35 (copy, index: 1)
                CustomMatch_upv_1 (copy, index: 2)
            ]]
            local Text_2 = u35.Text
            local v133 = utf8.len(Text_2) or (#Text_2)
            if CustomMatch_upv_1.NAME_MAX < v133 then
                local v134 = utf8.offset(Text_2, CustomMatch_upv_1.NAME_MAX + 1) or (#Text_2 + 1)
                u35.Text = string.sub(Text_2, 1, v134 - 1)
            end
        end
    )
    u35.FocusLost:Connect(
        function()
            --[[
              line: 1299
              upvalues:
                u63 (ref,  index: 1)
                u35 (copy, index: 2)
                Custom_upv_1 (copy, index: 3)
                u32 (copy, index: 4)
                u31 (copy, index: 5)
                u34 (copy, index: 6)
                u33 (copy, index: 7)
                CustomMatch_upv_1 (copy, index: 8)
                LocalPlayer_upv_1 (copy, index: 9)
                a1 (copy, index: 10)
                paint (copy, index: 11)
            ]]
            if not u63 then
                return
            end
            local Text_upv_3 = u35.Text
            local v135 = Custom_upv_1.State() or {}
            local str_upv_2 = tostring(v135.name or "")
            u63 = false
            u35.Visible = false
            u32.Visible = true
            u31.Visible = true
            u34.Visible = true
            u33.Visible = true
            if CustomMatch_upv_1.CleanName(Text_upv_3) ~= str_upv_2 then
                local v136
                if CustomMatch_upv_1.CleanName(Text_upv_3) == "" then
                    v136 = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
                else
                    v136 = CustomMatch_upv_1.CleanName(Text_upv_3)
                end
                u32.Text = v136
                task.spawn(
                    function()
                        --[[
                          line: 1310
                          upvalues:
                            Text_upv_3 (copy, index: 1)
                            Custom_upv_1 (copy, index: 2)
                            a1 (copy, index: 3)
                            paint (copy, index: 4)
                            u32 (copy, index: 5)
                            str_upv_2 (copy, index: 6)
                        ]]
                        local v137, v138 = Custom_upv_1.Host("SetName", Text_upv_3)
                        if not (v137) then
                            a1.Toast(tostring(v138), "error")
                        end
                        paint()
                        if v137 then
                            a1.Sounds.Play("Select")
                        else
                            u32.Text = str_upv_2
                        end
                    end
                )
            end
        end
    )
    u5.Activated:Connect(
        function()
            --[[
              line: 1324
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
    local u77 = 0
    local u78 = 0
    local function resetCopyLook()
        --[[
          name: resetCopyLook
          line: 1333
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
          line: 1338
          upvalues:
            u75 (ref,  index: 1)
            u78 (ref,  index: 2)
            u9 (copy, index: 3)
            u8 (copy, index: 4)
            u7 (copy, index: 5)
        ]]
        u75 = false
        local v139 = os.clock()
        if not (u78 <= v139) then
            return
        end
        u9.Visible = false
        u8:SetText("COPY")
        u7.Text = "two-stacked-squares"
    end
    local function copyCode()
        --[[
          name: copyCode
          line: 1344
          upvalues:
            Custom_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            paintCode (copy, index: 3)
            u77 (ref,  index: 4)
            u78 (ref,  index: 5)
            u7 (copy, index: 6)
            u75 (ref,  index: 7)
            u4 (copy, index: 8)
            u9 (copy, index: 9)
            u8 (copy, index: 10)
        ]]
        local v140 = Custom_upv_1.State() or {}
        if type(v140.code) ~= "string" then
            return
        end
        if v140.code ~= "" then
            if UI_upv_1.Touch and v140.public == false and not (Custom_upv_1.IsRevealed()) then
                Custom_upv_1.Reveal()
            end
            paintCode(v140)
            u77 = u77 + 1
            u78 = 0
            u7.Text = "two-stacked-squares"
            u75 = true
            u4:CaptureFocus()
            local function selectAll_1()
                --[[
                  name: selectAll
                  line: 1358
                  upvalues:
                    u75 (ref,  index: 1)
                    u4 (copy, index: 2)
                ]]
                if not u75 or not u4:IsFocused() then
                    return
                end
                u4.SelectionStart = 1
                u4.CursorPosition = #u4.Text + 1
            end
            if u75 then
                local v141 = u4:IsFocused()
                if v141 then
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
          line: 1374
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
          line: 1382
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
        function(a61)
            --[[
              line: 1390
              upvalues:
                u75 (ref,  index: 1)
                u4 (copy, index: 2)
                copyModifier (copy, index: 3)
                u77 (ref,  index: 4)
                u78 (ref,  index: 5)
                u8 (copy, index: 6)
                u7 (copy, index: 7)
                u9 (copy, index: 8)
                Keybinds_upv_1 (copy, index: 9)
                a1 (copy, index: 10)
            ]]
            if not u75 or not u4:IsFocused() then
                return
            end
            if a61.KeyCode == Enum.KeyCode.C and copyModifier() then
                u77 = u77 + 1
                local u79 = u77
                u78 = os.clock() + 1.6
                u8:SetText("COPIED")
                u7.Text = "check"
                u9.Text = "Copied to your clipboard"
                u9.Visible = true
                task.delay(
                    0.2,
                    function()
                        --[[
                          line: 1402
                          upvalues:
                            u79 (copy, index: 1)
                            u77 (ref,  index: 2)
                            u4 (copy, index: 3)
                        ]]
                        if u79 ~= u77 or not u4:IsFocused() then
                            return
                        end
                        u4:ReleaseFocus()
                    end
                )
                task.delay(
                    1.65,
                    function()
                        --[[
                          line: 1407
                          upvalues:
                            u79 (copy, index: 1)
                            u77 (ref,  index: 2)
                            u75 (ref,  index: 3)
                            u9 (copy, index: 4)
                            u8 (copy, index: 5)
                            u7 (copy, index: 6)
                        ]]
                        if u79 ~= u77 or (u75) then
                            return
                        end
                        u9.Visible = false
                        u8:SetText("COPY")
                        u7.Text = "two-stacked-squares"
                    end
                )
                return
            end
            if Keybinds_upv_1.IsPad(a61, "CustomMenu") or Keybinds_upv_1.ActionOf(a61) == "CustomMenu" then
                a1.MenuManager.Toggle("CustomHost")
            end
        end
    )
    u4.FocusLost:Connect(
        function()
            --[[
              line: 1416
              upvalues:
                UI_upv_1 (copy, index: 1)
                u4 (copy, index: 2)
                u75 (ref,  index: 3)
                u78 (ref,  index: 4)
                u9 (copy, index: 5)
                u8 (copy, index: 6)
                u7 (copy, index: 7)
            ]]
            task.delay(
                ((UI_upv_1.Touch) and 0) or 0.15,
                function()
                    --[[
                      line: 1417
                      upvalues:
                        u4 (copy, index: 1)
                        u75 (ref,  index: 2)
                        u78 (ref,  index: 3)
                        u9 (copy, index: 4)
                        u8 (copy, index: 5)
                        u7 (copy, index: 6)
                    ]]
                    if not (u4:IsFocused()) then
                        u75 = false
                        local v142 = os.clock()
                        if not (u78 <= v142) then
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
              line: 1424
              upvalues:
                CustomMatch_upv_1 (copy, index: 1)
                Custom_upv_1 (copy, index: 2)
                u4 (copy, index: 3)
            ]]
            local FormatCode_1 = CustomMatch_upv_1.FormatCode
            local v143 = Custom_upv_1.State() or {}
            local v144 = FormatCode_1(tostring(v143.code or ""))
            if u4.Text == v144 then
                return
            end
            u4.Text = v144
        end
    )
    Custom_upv_1.RevealChanged:Connect(
        function()
            --[[
              line: 1430
              upvalues:
                u2 (copy, index: 1)
                paintCode (copy, index: 2)
                Custom_upv_1 (copy, index: 3)
            ]]
            if u2.IsOpen then
                local v145 = Custom_upv_1.State() or {}
                paintCode(v145)
            end
        end
    )
    local tbl_upv_34 = nil
    local u80 = nil
    local function closeConfirm()
        --[[
          name: closeConfirm
          line: 1440
          upvalues:
            u80 (ref, index: 1)
            tbl_upv_34 (ref, index: 2)
        ]]
        u80 = nil
        if not tbl_upv_34 then
            return
        end
        tbl_upv_34.layer.Visible = false
    end
    local function openConfirm(a62, a63, a64, a65, a66, a67)
        --[[
          name: openConfirm
          line: 1446
          upvalues:
            tbl_upv_34 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u2 (copy, index: 4)
            closeConfirm (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            u80 (ref,  index: 8)
            a1 (copy, index: 9)
            GuiService_upv_1 (copy, index: 10)
        ]]
        if not (tbl_upv_34) then
            local v146 = UI_upv_1.new("TextButton", {Name = "Confirm", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, [1] = UI_upv_1.Corner(UDim.new(0, 16)), Parent = u2.Holder})
            v146.Activated:Connect(closeConfirm)
            local v147 = UI_upv_1.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(480, 256), Radius = UDim.new(0, 16), Parent = v146})
            UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 41, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v147})
            local v148 = UI_upv_1.DisplayText({ZIndex = 42, Name = "Title", Text = "", TextSize = 34, Position = fromOffset_upv_1(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = Colors_upv_1.Text, Parent = v147})
            local v149 = UI_upv_1.new("TextLabel", {Text = "", Name = "Body", TextWrapped = true, ZIndex = 42, TextSize = 19, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 74), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = v147})
            local v150 = UI_upv_1.Button({Text = "", Name = "No", Style = "Dark", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v147})
            local v151 = UI_upv_1.Button({Text = "", Name = "Yes", Style = "Danger", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v147})
            v150.Activated:Connect(closeConfirm)
            v151.Activated:Connect(
                function()
                    --[[
                      line: 1488
                      upvalues:
                        u80 (ref, index: 1)
                        tbl_upv_34 (ref, index: 2)
                    ]]
                    u80 = nil
                    if tbl_upv_34 then
                        tbl_upv_34.layer.Visible = false
                    end
                    if not u80 then
                        return
                    end
                    u80()
                end
            )
            tbl_upv_34 = {layer = v146, card = v147, title = v148, body = v149, no = v150, yes = v151}
        end
        tbl_upv_34.title.AutoLocalize = true
        tbl_upv_34.title.Text = a62
        tbl_upv_34.body.Text = a63
        tbl_upv_34.no:SetText(a64)
        tbl_upv_34.yes:SetText(a65)
        tbl_upv_34.yes:SetStyle(a66)
        u80 = a67
        tbl_upv_34.layer.Visible = true
        UI_upv_1.Enter(tbl_upv_34.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = tbl_upv_34.no.Instance
    end
    tbl_upv_5.Activated:Connect(
        function()
            --[[
              line: 1513
              upvalues:
                Custom_upv_1 (copy, index: 1)
                host (copy, index: 2)
                openConfirm (copy, index: 3)
                a1 (copy, index: 4)
                paint (copy, index: 5)
            ]]
            local v152 = Custom_upv_1.State() or {}
            if v152.status ~= "Results" then
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
                            Custom_upv_1 (copy, index: 1)
                            a1 (copy, index: 2)
                            paint (copy, index: 3)
                        ]]
                        task.spawn(
                            function()
                                --[[
                                  line: 1520
                                  upvalues:
                                    Custom_upv_1 (copy, index: 1)
                                    a1 (copy, index: 2)
                                    paint (copy, index: 3)
                                ]]
                                local v153, v154 = Custom_upv_1.Host("End", nil)
                                if not (v153) then
                                    a1.Toast(tostring(v154), "error")
                                end
                                paint()
                                if not v153 then
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
    u45.Activated:Connect(
        function()
            --[[
              line: 1536
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
                      line: 1537
                      upvalues:
                        Custom_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    task.spawn(
                        function()
                            --[[
                              line: 1538
                              upvalues:
                                Custom_upv_1 (copy, index: 1)
                                a1 (copy, index: 2)
                            ]]
                            local v155, v156 = Custom_upv_1.Action("Leave")
                            if v155 then
                                a1.MenuManager.Close("CustomHost")
                            else
                                a1.Toast(tostring(v156), "error")
                            end
                        end
                    )
                end
            )
        end
    )
    local tbl_upv_35 = nil
    local u81 = 0
    local tbl_upv_36 = {"TEAM 1", "TEAM 2", "RANDOM"}
    local function closeMove()
        --[[
          name: closeMove
          line: 1556
          upvalues:
            u81 (ref, index: 1)
            tbl_upv_35 (ref, index: 2)
        ]]
        u81 = 0
        if not tbl_upv_35 then
            return
        end
        tbl_upv_35.layer.Visible = false
    end
    local u82 = function(a68, a69)
        --[[
          line: 1527
          upvalues:
            openConfirm (copy, index: 1)
            Custom_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            paint (copy, index: 4)
        ]]
        openConfirm(
            "REMOVE PLAYER?",
            string.format("%s goes back to a public lobby and can't rejoin this match.", a69),
            "CANCEL",
            "REMOVE",
            "Danger",
            function()
                --[[
                  line: 1528
                  upvalues:
                    a68 (copy, index: 1)
                    Custom_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                    paint (copy, index: 4)
                    a69 (copy, index: 5)
                ]]
                task.spawn(
                    function()
                        --[[
                          line: 1529
                          upvalues:
                            a68 (copy, index: 1)
                            Custom_upv_1 (copy, index: 2)
                            a1 (copy, index: 3)
                            paint (copy, index: 4)
                            a69 (copy, index: 5)
                        ]]
                        local v157, v158 = Custom_upv_1.Host("Kick", a68)
                        if not (v157) then
                            a1.Toast(tostring(v158), "error")
                        end
                        paint()
                        if not v157 then
                            return
                        end
                        a1.Toast(string.format("%s was removed", a69), "info")
                    end
                )
            end
        )
    end
    local function findPlayer(a70)
        --[[
          name: findPlayer
          line: 1562
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        local v159 = Custom_upv_1.State() or {}
        local v160
        if type(v159.players) ~= "table" then
            v160 = {}
        else
            v160 = v159.players
        end
        for _, value_16 in v160 do
            if type(value_16) ~= "table" or value_16.userId ~= a70 then
                continue
            end
            return value_16
        end
        return nil
    end
    u66 = function(a71)
        --[[
          line: 1571
          upvalues:
            findPlayer (copy, index: 1)
            Custom_upv_1 (copy, index: 2)
            tbl_upv_35 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u2 (copy, index: 6)
            closeMove (copy, index: 7)
            fromOffset_upv_1 (copy, index: 8)
            Fonts_upv_1 (copy, index: 9)
            tbl_upv_7 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
            tbl_upv_36 (copy, index: 12)
            u81 (ref,  index: 13)
            tbl_upv_25 (copy, index: 14)
            a1 (copy, index: 15)
            setTeamOf (copy, index: 16)
            u82 (ref,  index: 17)
            sideCount (copy, index: 18)
            CustomMatch_upv_1 (copy, index: 19)
            modeOf (copy, index: 20)
            GuiService_upv_1 (copy, index: 21)
        ]]
        local v161 = findPlayer(a71)
        if not Custom_upv_1.IsHost() or not v161 then
            return
        end
        local body_1
        if not (tbl_upv_35) then
            local v162 = UI_upv_1.new("TextButton", {Name = "Move", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 40, [1] = UI_upv_1.Corner(UDim.new(0, 16)), Parent = u2.Holder})
            v162.Activated:Connect(closeMove)
            local v163 = UI_upv_1.Panel({Name = "Card", BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(540, 286), Radius = UDim.new(0, 16), Parent = v162})
            UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 41, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v163})
            body_1 = UI_upv_1.DisplayText({Text = "", Name = "Title", ZIndex = 42, TextSize = 32, Position = fromOffset_upv_1(28, 24), Size = UDim2.new(1, -56, 0, 40), TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v163})
            local v164 = UI_upv_1.new("TextLabel", {Text = "", Name = "Body", ZIndex = 42, TextSize = 18, Position = fromOffset_upv_1(28, 66), Size = UDim2.new(1, -56, 0, 22), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v163})
            local tbl_37 = {}
            local tbl_38 = {}
            local tbl_39 = {tbl_upv_7[1], tbl_upv_7[2], Colors_upv_1.TextMuted}
            for n_7 = 1, 3 do
                local u83
                if n_7 ~= 3 then
                    u83 = n_7
                else
                    u83 = 0
                end
                local v165 = UI_upv_1.new("Frame", {Name = "Mark", Size = fromOffset_upv_1(16, 16)})
                UI_upv_1.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(12, 12), BackgroundColor3 = tbl_39[n_7], [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v165})
                local v166 = UI_upv_1.Icon("check", 16, Colors_upv_1.TextDim, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v165})
                v166.Name = "Check"
                v166.Visible = false
                tbl_38[n_7] = v165
                local tbl_40 = {Style = "Dark", ZIndex = 43, TextSize = 19}
                tbl_40.Name = "Pick" .. u83
                tbl_40.Text = tbl_upv_36[n_7]
                tbl_40.Icon = v165
                tbl_40.Position = fromOffset_upv_1(((n_7 - 1) * 165) + 28, 110)
                tbl_40.Size = fromOffset_upv_1(153, 58)
                tbl_40.Parent = v163
                function tbl_40.OnDisabledClick()
                    --[[
                      name: OnDisabledClick
                      line: 1635
                      upvalues:
                        findPlayer (copy, index: 1)
                        u81 (ref,  index: 2)
                        tbl_upv_25 (copy, index: 3)
                        u83 (copy, index: 4)
                        a1 (copy, index: 5)
                    ]]
                    local v167 = findPlayer(u81)
                    if v167 then
                        local v168 = tbl_upv_25[v167.userId]
                        if v168 == nil then
                            v168 = tonumber(v167.team) or 0
                        end
                        local v169
                        if v168 == 1 or v168 == 2 then
                            v169 = v168
                        else
                            v169 = 0
                        end
                        if v169 == u83 then
                            return
                        end
                        a1.Toast(("Team %* is full"):format(u83), "info")
                    end
                end
                local v170 = UI_upv_1.Button(tbl_40)
                v170.Activated:Connect(
                    function()
                        --[[
                          line: 1642
                          upvalues:
                            u81 (ref,  index: 1)
                            tbl_upv_35 (ref,  index: 2)
                            Custom_upv_1 (copy, index: 3)
                            setTeamOf (copy, index: 4)
                            u83 (copy, index: 5)
                        ]]
                        u81 = 0
                        if tbl_upv_35 then
                            tbl_upv_35.layer.Visible = false
                        end
                        if u81 == 0 or not Custom_upv_1.IsHost() then
                            return
                        end
                        task.spawn(setTeamOf, u81, u83)
                    end
                )
                tbl_37[n_7] = v170
            end
            local v171 = UI_upv_1.Button({Text = "CANCEL", Name = "Cancel", Style = "Dark", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v163})
            local v172 = UI_upv_1.Button({Text = "REMOVE", Name = "Remove", Style = "Danger", ZIndex = 43, TextSize = 21, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v163})
            v171.Activated:Connect(closeMove)
            v172.Activated:Connect(
                function()
                    --[[
                      line: 1654
                      upvalues:
                        u81 (ref,  index: 1)
                        findPlayer (copy, index: 2)
                        tbl_upv_35 (ref,  index: 3)
                        u82 (ref,  index: 4)
                    ]]
                    local v173 = findPlayer(u81)
                    u81 = 0
                    if tbl_upv_35 then
                        tbl_upv_35.layer.Visible = false
                    end
                    if not v173 then
                        return
                    end
                    u82(u81, (tostring(v173.name or "Player")))
                end
            )
            tbl_upv_35 = {layer = v162, card = v163, title = body_1, body = v164, picks = tbl_37, marks = tbl_38, cancel = v171, remove = v172}
        end
        local v174 = tbl_upv_35
        u81 = a71
        body_1 = tbl_upv_25[v161.userId]
        if body_1 == nil then
            body_1 = tonumber(v161.team) or 0
        end
        local v175
        if body_1 == 1 or body_1 == 2 then
            v175 = body_1
        else
            v175 = 0
        end
        v174.title.AutoLocalize = false
        v174.title.Text = string.upper(tostring(v161.name or "Player"))
        body_1 = v174.body
        local format_1 = string.format
        local str_3 = tostring(v161.username or "")
        local v176
        if v175 ~= 0 then
            v176 = ("Team %*"):format(v175)
        else
            v176 = "Random team"
        end
        body_1.Text = format_1("@%s  \194\183  %s", str_3, v176)
        local v177 = nil
        local v178, v179 = nil, nil
        v161 = v177
        local v180 = nil
        for key_4, value_17 in v174.picks do
            if key_4 ~= 3 then
                v180 = key_4
            else
                v180 = 0
            end
            v178 = false
            if v180 ~= 0 then
                v178 = false
                if v180 ~= v175 then
                    local v181 = sideCount(v180, a71)
                    local v182 = Custom_upv_1.State() or {}
                    if CustomMatch_upv_1.TeamSize(modeOf(v182)) <= v181 then
                        v178 = true
                    else
                        v178 = false
                    end
                end
            end
            local v181 = (v180 ~= v175) and (not v178)
            value_17:SetEnabled(v181)
            value_17:SetText((v178 and (tbl_upv_36[key_4] .. " FULL")) or (tbl_upv_36[key_4]))
            value_17.Label.TextSize = (v178 and 17) or 19
            v178 = v174.marks[key_4]
            local Dot_1 = v178:FindFirstChild("Dot")
            Dot_1.Visible = v180 ~= v175
            v179 = v178:FindFirstChild("Check")
            v179.Visible = v180 == v175
            if v161 then
                v179 = v161
                v161 = v179
                continue
            end
            if v181 then
                v179 = value_17
            else
                v179 = nil
            end
            v161 = v179
        end
        v174.layer.Visible = true
        UI_upv_1.Enter(v174.card, Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = (v161 or (v174.cancel)).Instance
    end
    local function layout()
        --[[
          name: layout
          line: 1692
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
            u27 (copy, index: 18)
            u16 (copy, index: 19)
            tbl_upv_5 (copy, index: 20)
            u17 (copy, index: 21)
            u18 (copy, index: 22)
            u19 (copy, index: 23)
            u12 (copy, index: 24)
            u20 (copy, index: 25)
            u23 (copy, index: 26)
            u30 (copy, index: 27)
            u36 (copy, index: 28)
            u40 (copy, index: 29)
            u33 (copy, index: 30)
            u31 (copy, index: 31)
            u32 (copy, index: 32)
            tbl_upv_6 (copy, index: 33)
            u37 (copy, index: 34)
            u38 (copy, index: 35)
            u24 (copy, index: 36)
            u25 (copy, index: 37)
            u28 (copy, index: 38)
            u29 (copy, index: 39)
            u41 (copy, index: 40)
            u42 (copy, index: 41)
            u34 (copy, index: 42)
            u35 (copy, index: 43)
            u39 (copy, index: 44)
            u43 (copy, index: 45)
            u44 (copy, index: 46)
            u21 (copy, index: 47)
            u45 (copy, index: 48)
            u46 (copy, index: 49)
            u47 (copy, index: 50)
            updateFade (copy, index: 51)
            u68 (ref,  index: 52)
            u69 (ref,  index: 53)
            u48 (copy, index: 54)
            u49 (copy, index: 55)
            u56 (copy, index: 56)
            u57 (copy, index: 57)
            u59 (copy, index: 58)
            u55 (copy, index: 59)
            Custom_upv_1 (copy, index: 60)
            CustomMatch_upv_1 (copy, index: 61)
            modeOf (copy, index: 62)
            tbl_upv_11 (copy, index: 63)
            tbl_upv_12 (copy, index: 64)
            tbl_upv_15 (copy, index: 65)
            u60 (copy, index: 66)
            u76 (ref,  index: 67)
        ]]
        local v183 = UI_upv_1.CanvasSize()
        local v184 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            u2.Holder.Size = fromOffset_upv_1(math.floor(math.min(tbl_upv_2.W, v183.X - 24)), math.floor(math.min(tbl_upv_2.H, (v183.Y - v184) - 12)))
        else
            u2.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v183.X - 240, tbl_upv_2.W, 1280)), math.floor(math.clamp((v183.Y - v184) - 90, 660, 740)))
        end
        u2.Subtitle.TextSize = ((UI_upv_1.Compact) and 15) or 17
        local v185 = ((UI_upv_1.Compact) and 226) or 246
        local v186 = ((UI_upv_1.Compact) and 44) or 48
        local v187 = ((UI_upv_1.Compact) and 116) or 118
        local v188 = UI_upv_1.WindowCloseSize() + 30
        u8.Instance.Position = UDim2.new(1, -v188, 0, 14)
        u8.Instance.Size = fromOffset_upv_1(v187, v186 + 3)
        u8.Label.TextSize = ((UI_upv_1.Compact) and 18) or 17
        u3.Size = fromOffset_upv_1(v185, v186)
        u3.Position = UDim2.new(1, -((v188 + v187) + 10), 0, 14)
        u4.TextSize = ((UI_upv_1.Compact) and 25) or 28
        local v189 = ((UI_upv_1.Compact) and 8) or 9
        for key_5, value_18 in tbl_upv_3:GetChildren() do
            local v190 = tonumber(string.match(value_18.Name, "%d+")) or key_5
            local v191 = v189 * 0.55
            value_18.Size = fromOffset_upv_1(v189, v189)
            value_18.Position = fromOffset_upv_1((v190 - 1) * (v189 + v191) + (((v190 > 3) and (v189 * 1.35 - v191)) or 0), 0)
        end
        tbl_upv_3.Size = fromOffset_upv_1(((v189 * 6) + ((v189 * 4) * 0.55)) + (v189 * 1.35), v189)
        u5.Position = UDim2.new(1, -8, 0.5, 0)
        u9.Position = UDim2.new(1, -v188, 0, (v186 + 14) + 4)
        u9.Size = fromOffset_upv_1((v185 + v187) + 10, 14)
        local v192 = (v185 + v187) + v188 + 40
        u2.Title.Size = UDim2.new(1, -v192, 0, 40)
        u2.Subtitle.Size = UDim2.new(1, -v192, 0, 20)
        u2.Subtitle.TextTruncate = Enum.TextTruncate.AtEnd
        local v193 = u2.Holder.Size.Y.Offset - 80 - 32
        local left_1 = tbl_upv_2.left
        u10.Size = fromOffset_upv_1(left_1, v193)
        local pad_1 = tbl_upv_2.pad
        local v194 = left_1 - pad_1 * 2
        u11.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        local v195 = pad_1
        u13.Position = fromOffset_upv_1(pad_1 + 2, v195 + 11)
        u14.Position = fromOffset_upv_1(pad_1 + 20, v195)
        u14.Size = fromOffset_upv_1(v194 - 110, 22)
        u14.TextSize = tbl_upv_2.status
        u15.Position = UDim2.new(1, -pad_1, 0, v195)
        u15.Size = fromOffset_upv_1(100, 22)
        u15.TextSize = tbl_upv_2.status - 1
        local v196 = v195 + 32
        local v197 = ((UI_upv_1.Compact) and (u27.Instance.Size.X.Offset + 8)) or 0
        u27.Instance.Position = fromOffset_upv_1(pad_1, v196)
        for _, value_19 in {u16, tbl_upv_5} do
            value_19.Instance.Position = fromOffset_upv_1(pad_1 + v197, v196)
            value_19.Instance.Size = fromOffset_upv_1(v194 - v197, tbl_upv_2.button)
            value_19.Label.TextSize = ((UI_upv_1.Compact) and 23) or 26
        end
        u17.Position = fromOffset_upv_1(pad_1, v196)
        u17.Size = fromOffset_upv_1(v194, tbl_upv_2.button - 3)
        u18.TextSize = ((UI_upv_1.Compact) and 19) or 20
        local v198 = v196 + (tbl_upv_2.button + 8)
        u19.Position = fromOffset_upv_1(pad_1, v198)
        u19.Size = fromOffset_upv_1(v194, tbl_upv_2.hint + 2)
        u19.TextSize = tbl_upv_2.hint
        local v199 = v198 + (((tbl_upv_2.hint + 2) + pad_1) - 4)
        local v200 = tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        u12.Position = fromOffset_upv_1(0, v200)
        u12.Size = fromOffset_upv_1(left_1, v199)
        local v201 = v200 + v199 + tbl_upv_2.blockGap
        u20.Position = fromOffset_upv_1(0, v201)
        u20.Size = UDim2.new(1, 0, 0, tbl_upv_2.sectionH)
        local v202 = v201 + tbl_upv_2.sectionH + tbl_upv_2.sectionGap
        u23.Visible = not UI_upv_1.Compact
        u30:FindFirstChild("Divider").Visible = not UI_upv_1.Compact
        local v203 = ((UI_upv_1.Compact) and {u30, u36, u40}) or {u23, u30, u36, u40}
        for key_6, value_20 in v203 do
            value_20.Position = fromOffset_upv_1(0, (key_6 - 1) * tbl_upv_2.rowH)
            value_20.Size = fromOffset_upv_1(left_1, tbl_upv_2.rowH)
        end
        local tbl_41 = {{u30, u33, u31, u32}, {u36, tbl_upv_6, u37, u38}, {u23, u24, u23:FindFirstChild("Label"), u25}}
        for _, value_21 in tbl_41 do
            local v204 = value_21[2]
            local v205 = value_21[3]
            local v206 = value_21[4]
            local v207 = ((value_21[1] ~= u23) and 86) or 140
            v204.Position = UDim2.new(0, pad_1 + 2, 0.5, 0)
            v204.TextSize = 22
            v205.Position = fromOffset_upv_1(pad_1 + 36, (math.floor(tbl_upv_2.rowH / 2) - tbl_upv_2.label) - 1)
            v205.Size = fromOffset_upv_1((v194 - 36) - v207, tbl_upv_2.label + 2)
            v205.TextSize = tbl_upv_2.label
            v206.Position = fromOffset_upv_1(pad_1 + 36, math.floor(tbl_upv_2.rowH / 2) + 2)
            v206.Size = fromOffset_upv_1((v194 - 36) - v207, tbl_upv_2.desc + 2)
            v206.TextSize = tbl_upv_2.desc
        end
        u28.Instance.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u29.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u29.Size = fromOffset_upv_1(60, 22)
        u29.TextSize = tbl_upv_2.label
        u41.Position = UDim2.new(0, pad_1 + 2, 0.5, 0)
        local Label_1 = u40:FindFirstChild("Label")
        Label_1.Position = fromOffset_upv_1(pad_1 + 36, (math.floor(tbl_upv_2.rowH / 2) - tbl_upv_2.label) - 1)
        Label_1.Size = fromOffset_upv_1((v194 - 36) - 86, tbl_upv_2.label + 2)
        Label_1.TextSize = tbl_upv_2.label
        u42.Position = fromOffset_upv_1(pad_1 + 36, math.floor(tbl_upv_2.rowH / 2) + 2)
        u42.Size = fromOffset_upv_1((v194 - 36) - 86, tbl_upv_2.desc + 2)
        u42.TextSize = tbl_upv_2.desc
        u34.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u34.Size = fromOffset_upv_1(60, 20)
        u34.TextSize = tbl_upv_2.label - 2
        u35.Position = fromOffset_upv_1(pad_1 - 4, 8)
        u35.Size = fromOffset_upv_1(v194 + 8, tbl_upv_2.rowH - 16)
        u35.TextSize = tbl_upv_2.label
        u39.Instance.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u43.Instance.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u44.Position = UDim2.new(1, -pad_1, 0.5, 0)
        u44.Size = fromOffset_upv_1(60, 22)
        u44.TextSize = tbl_upv_2.label
        u21.Position = fromOffset_upv_1(0, v202)
        u21.Size = fromOffset_upv_1(left_1, #v203 * tbl_upv_2.rowH)
        u45.Label.TextSize = ((UI_upv_1.Compact) and 17) or 18
        local v208 = (v202 + (#v203 * tbl_upv_2.rowH)) + 12 + tbl_upv_2.leaveH <= v193
        local v209
        if v208 then
            v209 = v193
        else
            v209 = v202 + (#v203 * tbl_upv_2.rowH) + 2
        end
        u10.CanvasSize = fromOffset_upv_1(0, v209)
        u46.Position = fromOffset_upv_1((left_1 + tbl_upv_2.gap) - 8, -8)
        local v210 = u2.Holder.Size.X.Offset - 44 - left_1 - tbl_upv_2.gap
        u46.Size = fromOffset_upv_1(v210 + 8, v193 + 8)
        u47.Position = fromOffset_upv_1(left_1 + tbl_upv_2.gap, v193)
        u47.Size = fromOffset_upv_1(v210 - 10, 40)
        task.defer(updateFade)
        u68 = v210 - 14
        u69 = math.floor((u68 - tbl_upv_2.teamGap) / 2)
        for _, value_22 in {{u48, u49}, {u56, u57}, {u59, u55}} do
            local v211 = value_22[2]
            value_22[1].Size = UDim2.new(0, u68, 0, tbl_upv_2.sectionH)
            v211.Size = fromOffset_upv_1(math.floor(u68 * 0.62), 18)
            v211.TextSize = tbl_upv_2.sectionHint
        end
        u55.TextSize = 15
        local v212 = Custom_upv_1.State() or {}
        local v213 = CustomMatch_upv_1.TeamSize(modeOf(v212))
        local v214 = tbl_upv_2.teamHead + (v213 * tbl_upv_2.seatH) + ((v213 - 1) * tbl_upv_2.seatGap) + 8
        for _, value_23 in tbl_upv_11 do
            value_23.frame.Size = fromOffset_upv_1(u69, v214)
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
        local v215 = math.floor((u68 - ((mapCols_1 - 1) * tbl_upv_2.mapGap)) / mapCols_1)
        local v216 = math.floor((v215 * 9) / 16)
        local v217 = math.ceil(math.max(1, #tbl_upv_15) / mapCols_1)
        for key_7, value_25 in tbl_upv_15 do
            value_25.btn.AnchorPoint = Vector2.new(0.5, 0.5)
            value_25.btn.Position = fromOffset_upv_1((((key_7 - 1) % mapCols_1) * (v215 + tbl_upv_2.mapGap)) + math.floor(v215 / 2), ((key_7 - 1) // mapCols_1) * (v216 + tbl_upv_2.mapGap) + math.floor(v216 / 2))
            value_25.btn.Size = fromOffset_upv_1(v215, v216)
            value_25.name.TextSize = tbl_upv_2.mapName
        end
        u60.Size = fromOffset_upv_1(u68, (v217 * v216) + ((v217 - 1) * tbl_upv_2.mapGap))
        if v208 then
            u45.Instance.Parent = u10
            u45.Instance.AnchorPoint = Vector2.new(0, 1)
            u45.Instance.Position = UDim2.new(0, 0, 1, 0)
            u45.Instance.Size = fromOffset_upv_1(left_1, tbl_upv_2.leaveH)
        else
            u45.Instance.Parent = u46
            u45.Instance.AnchorPoint = Vector2.new(0, 0)
            u45.Instance.Size = fromOffset_upv_1(u68, tbl_upv_2.leaveH)
        end
        u76 = not v208
        u2.Refit()
    end
    local function relayout()
        --[[
          name: relayout
          line: 1893
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
              line: 1904
              upvalues:
                u2 (copy, index: 1)
                u63 (ref,  index: 2)
                Custom_upv_1 (copy, index: 3)
                u35 (copy, index: 4)
                u81 (ref,  index: 5)
                findPlayer (copy, index: 6)
                tbl_upv_35 (ref,  index: 7)
                tbl_upv_15 (copy, index: 8)
                paint (copy, index: 9)
                layout (copy, index: 10)
            ]]
            if not u2.IsOpen then
                return
            end
            if u63 and not (Custom_upv_1.IsHost()) then
                u35:ReleaseFocus()
            end
            if u81 ~= 0 and (not Custom_upv_1.IsHost() or not findPlayer(u81)) then
                u81 = 0
                if tbl_upv_35 then
                    tbl_upv_35.layer.Visible = false
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
    local tbl_42 = {}
    function tbl_42.open()
        --[[
          name: open
          line: 1923
          upvalues:
            a1 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
            tbl_upv_25 (copy, index: 3)
            u80 (ref,  index: 4)
            tbl_upv_34 (ref,  index: 5)
            u81 (ref,  index: 6)
            tbl_upv_35 (ref,  index: 7)
            u63 (ref,  index: 8)
            u35 (copy, index: 9)
            u32 (copy, index: 10)
            u31 (copy, index: 11)
            u34 (copy, index: 12)
            u33 (copy, index: 13)
            paint (copy, index: 14)
            layout (copy, index: 15)
            u46 (copy, index: 16)
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
        u80 = nil
        if tbl_upv_34 then
            tbl_upv_34.layer.Visible = false
        end
        u81 = 0
        if tbl_upv_35 then
            tbl_upv_35.layer.Visible = false
        end
        if u63 then
            u63 = false
            u35.Visible = false
            u32.Visible = true
            u31.Visible = true
            u34.Visible = true
            u33.Visible = true
        end
        paint(true)
        layout()
        paint(true)
        u46.CanvasPosition = Vector2.zero
        u2:Open()
        UI_upv_1.SlideIn(u10, Vector2.new(-18, 0), TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
        if UI_upv_1.Gamepad then
            local v218
            if u16.Instance.Visible then
                v218 = u16.Instance
            elseif tbl_upv_5.Instance.Visible then
                v218 = tbl_upv_5.Instance
            else
                v218 = u2.CloseButton
            end
            GuiService_upv_1.SelectedObject = v218
        end
        task.spawn(
            function()
                --[[
                  line: 1944
                  upvalues:
                    Custom_upv_1 (copy, index: 1)
                ]]
                Custom_upv_1.Host("Get")
            end
        )
    end
    function tbl_42.close(a72)
        --[[
          name: close
          line: 1948
          upvalues:
            a1 (copy, index: 1)
            u80 (ref,  index: 2)
            tbl_upv_34 (ref,  index: 3)
            u81 (ref,  index: 4)
            tbl_upv_35 (ref,  index: 5)
            u63 (ref,  index: 6)
            u35 (copy, index: 7)
            u4 (copy, index: 8)
            u78 (ref,  index: 9)
            u75 (ref,  index: 10)
            u9 (copy, index: 11)
            u8 (copy, index: 12)
            u7 (copy, index: 13)
            Custom_upv_1 (copy, index: 14)
            GuiService_upv_1 (copy, index: 15)
            u2 (copy, index: 16)
        ]]
        a1.SetHudHidden("CustomHost", false)
        u80 = nil
        if tbl_upv_34 then
            tbl_upv_34.layer.Visible = false
        end
        u81 = 0
        if tbl_upv_35 then
            tbl_upv_35.layer.Visible = false
        end
        if u63 then
            u35:ReleaseFocus()
        end
        if u4:IsFocused() then
            u4:ReleaseFocus()
        end
        u78 = 0
        u75 = false
        local v219 = os.clock()
        if u78 <= v219 then
            u9.Visible = false
            u8:SetText("COPY")
            u7.Text = "two-stacked-squares"
        end
        Custom_upv_1.Hide()
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        if SelectedObject_1 and SelectedObject_1:IsDescendantOf(u2.Root) then
            GuiService_upv_1.SelectedObject = nil
        end
        u2:Close(a72)
    end
    a1.MenuManager.Register("CustomHost", tbl_42)
    a1.Debug.customHost = function(a73, a74)
        --[[
          line: 1975
          upvalues:
            card (copy, index: 1)
            tbl_upv_11 (copy, index: 2)
            u50 (ref,  index: 3)
            u66 (ref,  index: 4)
            tbl_upv_35 (ref,  index: 5)
            u81 (ref,  index: 6)
            a1 (copy, index: 7)
            u65 (ref,  index: 8)
            host (copy, index: 9)
            u26 (ref,  index: 10)
            u16 (copy, index: 11)
            tbl_upv_5 (copy, index: 12)
            tbl_upv_20 (copy, index: 13)
            u82 (ref,  index: 14)
            u45 (copy, index: 15)
            tbl_upv_34 (ref,  index: 16)
            u80 (ref,  index: 17)
            u63 (ref,  index: 18)
            u35 (copy, index: 19)
            Custom_upv_1 (copy, index: 20)
            CustomMatch_upv_1 (copy, index: 21)
            LocalPlayer_upv_1 (copy, index: 22)
            u32 (copy, index: 23)
            u31 (copy, index: 24)
            u34 (copy, index: 25)
            u33 (copy, index: 26)
            copyCode (copy, index: 27)
            tbl_upv_15 (copy, index: 28)
            u2 (copy, index: 29)
            u19 (copy, index: 30)
            u28 (copy, index: 31)
            u29 (copy, index: 32)
            modeOf (copy, index: 33)
            u4 (copy, index: 34)
            tbl_upv_3 (copy, index: 35)
            u5 (copy, index: 36)
            u75 (ref,  index: 37)
            u9 (copy, index: 38)
            u8 (copy, index: 39)
            u17 (copy, index: 40)
            u70 (ref,  index: 41)
            tbl_upv_26 (copy, index: 42)
            u15 (copy, index: 43)
        ]]
        local v220 = nil
        local function joinSeat(a75)
            --[[
              name: joinSeat
              line: 1976
              upvalues:
                card (copy, index: 1)
                tbl_upv_11 (copy, index: 2)
            ]]
            local v221 = nil
            if a75 ~= 0 then
                v221 = tbl_upv_11[a75]
                if not (v221) then
                    v221 = {}
                    v221.seats = {}
                end
                for _, value_26 in v221.seats do
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
        if a73 == "join" then
            v220 = joinSeat(tonumber(a74) or 0)
            if not v220 then
                return "no JOIN seat there"
            end
            u50(v220.team)
            local v222 = Custom_upv_1.State() or {}
            local tbl_43 = {}
            tbl_43.open = u2.IsOpen
            tbl_43.host = Custom_upv_1.IsHost()
            tbl_43.status = v222.status or false
            tbl_43.canStart = v222.canStart or false
            tbl_43.hint = u19.Text
            tbl_43.map = v222.map or false
            tbl_43.public = v222.public or false
            tbl_43.bots = v222.bots or false
            tbl_43.mode = v222.mode or false
            tbl_43.modeShown = u28.Value
            local v223
            if u29.Visible then
                v223 = u29.Text
            else
                v223 = false
            end
            tbl_43.modeValue = v223
            tbl_43.seats = CustomMatch_upv_1.TeamSize(modeOf(v222))
            if type(v222.players) ~= "table" then
                v223 = 0
            else
                v223 = #v222.players
            end
            tbl_43.players = v223
            tbl_43.mapCards = #tbl_upv_15
            v223 = (tbl_upv_34 ~= nil) and (tbl_upv_34.layer.Visible)
            tbl_43.confirm = v223
            tbl_43.code = u4.Text
            if tbl_upv_3.Visible then
                v223 = Custom_upv_1.MASK
            else
                v223 = u4.Text
            end
            tbl_43.codeShown = v223
            tbl_43.masked = tbl_upv_3.Visible
            tbl_43.eye = u5.Visible
            tbl_43.copying = u75
            tbl_43.focused = u4:IsFocused()
            tbl_43.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            if u9.Visible then
                v223 = u9.Text
            else
                v223 = false
            end
            tbl_43.copyHint = v223
            tbl_43.copyLabel = u8.Label.Text
            tbl_43.readOnly = u17.Visible
            tbl_43.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_43.team = u70 or false
            tbl_43.team1 = tbl_upv_26[1]
            tbl_43.team2 = tbl_upv_26[2]
            tbl_43.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join1 = v223
            if joinSeat(2) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join2 = v223
            local v224 = not (card.btn.Visible) or not (card.join) or card
            if v224 ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.joinRandom = v223
            tbl_43.preview = u15.Text
            tbl_43.move = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            tbl_43.movePicks = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            local v225 = 0
            local v223 = v225
            for _, value_27 in tbl_upv_20 do
                v223 = ((value_27.more.Visible) and (v223 + 1)) or v223
            end
            tbl_43.moreShown = v223
            return tbl_43
        elseif a73 == "more" then
            u66(tonumber(a74) or 0)
            local v222 = Custom_upv_1.State() or {}
            local tbl_43 = {}
            tbl_43.open = u2.IsOpen
            tbl_43.host = Custom_upv_1.IsHost()
            tbl_43.status = v222.status or false
            tbl_43.canStart = v222.canStart or false
            tbl_43.hint = u19.Text
            tbl_43.map = v222.map or false
            tbl_43.public = v222.public or false
            tbl_43.bots = v222.bots or false
            tbl_43.mode = v222.mode or false
            tbl_43.modeShown = u28.Value
            local v223
            if u29.Visible then
                v223 = u29.Text
            else
                v223 = false
            end
            tbl_43.modeValue = v223
            tbl_43.seats = CustomMatch_upv_1.TeamSize(modeOf(v222))
            if type(v222.players) ~= "table" then
                v223 = 0
            else
                v223 = #v222.players
            end
            tbl_43.players = v223
            tbl_43.mapCards = #tbl_upv_15
            v223 = (tbl_upv_34 ~= nil) and (tbl_upv_34.layer.Visible)
            tbl_43.confirm = v223
            tbl_43.code = u4.Text
            if tbl_upv_3.Visible then
                v223 = Custom_upv_1.MASK
            else
                v223 = u4.Text
            end
            tbl_43.codeShown = v223
            tbl_43.masked = tbl_upv_3.Visible
            tbl_43.eye = u5.Visible
            tbl_43.copying = u75
            tbl_43.focused = u4:IsFocused()
            tbl_43.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            if u9.Visible then
                v223 = u9.Text
            else
                v223 = false
            end
            tbl_43.copyHint = v223
            tbl_43.copyLabel = u8.Label.Text
            tbl_43.readOnly = u17.Visible
            tbl_43.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_43.team = u70 or false
            tbl_43.team1 = tbl_upv_26[1]
            tbl_43.team2 = tbl_upv_26[2]
            tbl_43.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join1 = v223
            if joinSeat(2) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join2 = v223
            local v224 = not (card.btn.Visible) or not (card.join) or card
            if v224 ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.joinRandom = v223
            tbl_43.preview = u15.Text
            v223 = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            tbl_43.move = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            local v223 = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            tbl_43.movePicks = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            local v225 = 0
            local v223 = v225
            for _, value_27 in tbl_upv_20 do
                v223 = ((value_27.more.Visible) and (v223 + 1)) or v223
            end
            tbl_43.moreShown = v223
            return tbl_43
        elseif a73 ~= "movePick" then
            if a73 ~= "moveRemove" then
                if a73 == "moveCancel" then
                    u81 = 0
                    if tbl_upv_35 then
                        tbl_upv_35.layer.Visible = false
                    end
                elseif a73 == "open" then
                    a1.MenuManager.Open("CustomHost")
                elseif a73 == "map" then
                    u65((tostring(a74 or "")))
                elseif a73 == "public" then
                    local v226 = a74 ~= false
                    task.spawn(host, "SetPublic", v226, "public", a74 ~= false)
                elseif a73 == "bots" then
                    local v227 = a74 == true
                    task.spawn(host, "SetBots", v227, "bots", a74 == true)
                elseif a73 == "mode" then
                    u26((tostring(a74 or "")))
                elseif a73 == "start" then
                    u16.Activated:Fire()
                elseif a73 == "end" then
                    tbl_upv_5.Activated:Fire()
                elseif a73 == "kick" then
                    local v228 = tbl_upv_20[tonumber(a74) or 0]
                    local v229 = u82
                    local v230 = tonumber(a74) or 0
                    v229(v230, ((not v228) and "Player") or (v228.name.Text))
                elseif a73 == "leave" then
                    u45.Activated:Fire()
                elseif a73 ~= "confirmYes" then
                    if a73 == "confirmNo" then
                        u80 = nil
                        if tbl_upv_34 then
                            tbl_upv_34.layer.Visible = false
                        end
                    elseif a73 ~= "edit" then
                        if a73 == "name" then
                            if not (u63) then
                                u63 = true
                                local v231 = Custom_upv_1.State() or {}
                                u35.Text = tostring(v231.name or "")
                                u35.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
                                u35.Visible = true
                                u32.Visible = false
                                u31.Visible = false
                                u34.Visible = false
                                u33.Visible = false
                                u35:CaptureFocus()
                            end
                            u35.Text = tostring(a74 or "")
                            u35:ReleaseFocus()
                        elseif a73 == "copy" then
                            copyCode()
                        elseif a73 ~= "reveal" then
                            if a73 == "hoverMap" then
                                for _, value_28 in tbl_upv_15 do
                                    if value_28.id == tostring(a74 or "") then
                                        value_28.scaleObj.Scale = 1.03
                                        value_28.stroke.Transparency = 0.55
                                    end
                                end
                            end
                        elseif a74 ~= false then
                            Custom_upv_1.Reveal()
                        else
                            Custom_upv_1.Hide()
                        end
                    elseif not (u63) then
                        u63 = true
                        local v232 = Custom_upv_1.State() or {}
                        u35.Text = tostring(v232.name or "")
                        u35.PlaceholderText = CustomMatch_upv_1.DefaultName(LocalPlayer_upv_1.DisplayName)
                        u35.Visible = true
                        u32.Visible = false
                        u31.Visible = false
                        u34.Visible = false
                        u33.Visible = false
                        u35:CaptureFocus()
                    end
                elseif tbl_upv_34 then
                    tbl_upv_34.yes.Activated:Fire()
                end
            elseif tbl_upv_35 then
                tbl_upv_35.remove.Activated:Fire()
            end
            local v222 = Custom_upv_1.State() or {}
            local tbl_43 = {}
            tbl_43.open = u2.IsOpen
            tbl_43.host = Custom_upv_1.IsHost()
            tbl_43.status = v222.status or false
            tbl_43.canStart = v222.canStart or false
            tbl_43.hint = u19.Text
            tbl_43.map = v222.map or false
            tbl_43.public = v222.public or false
            tbl_43.bots = v222.bots or false
            tbl_43.mode = v222.mode or false
            tbl_43.modeShown = u28.Value
            local v223
            if u29.Visible then
                v223 = u29.Text
            else
                v223 = false
            end
            tbl_43.modeValue = v223
            tbl_43.seats = CustomMatch_upv_1.TeamSize(modeOf(v222))
            if type(v222.players) ~= "table" then
                v223 = 0
            else
                v223 = #v222.players
            end
            tbl_43.players = v223
            tbl_43.mapCards = #tbl_upv_15
            v223 = (tbl_upv_34 ~= nil) and (tbl_upv_34.layer.Visible)
            tbl_43.confirm = v223
            tbl_43.code = u4.Text
            if tbl_upv_3.Visible then
                v223 = Custom_upv_1.MASK
            else
                v223 = u4.Text
            end
            tbl_43.codeShown = v223
            tbl_43.masked = tbl_upv_3.Visible
            tbl_43.eye = u5.Visible
            tbl_43.copying = u75
            tbl_43.focused = u4:IsFocused()
            tbl_43.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            if u9.Visible then
                v223 = u9.Text
            else
                v223 = false
            end
            tbl_43.copyHint = v223
            tbl_43.copyLabel = u8.Label.Text
            tbl_43.readOnly = u17.Visible
            tbl_43.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_43.team = u70 or false
            tbl_43.team1 = tbl_upv_26[1]
            tbl_43.team2 = tbl_upv_26[2]
            tbl_43.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join1 = v223
            if joinSeat(2) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join2 = v223
            local v224 = not (card.btn.Visible) or not (card.join) or card
            if v224 ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.joinRandom = v223
            tbl_43.preview = u15.Text
            v223 = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            tbl_43.move = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            local v223 = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            tbl_43.movePicks = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            local v225 = 0
            local v223 = v225
            for _, value_27 in tbl_upv_20 do
                v223 = ((value_27.more.Visible) and (v223 + 1)) or v223
            end
            tbl_43.moreShown = v223
            return tbl_43
        else
            local v233 = ((a74 == 0) and 3) or (tonumber(a74) or 0)
            local v234 = tbl_upv_35 and (tbl_upv_35.picks[v233])
            if not v234 or not v234.Enabled then
                return "that pick is off"
            end
            v234.Activated:Fire()
            local v222 = Custom_upv_1.State() or {}
            local tbl_43 = {}
            tbl_43.open = u2.IsOpen
            tbl_43.host = Custom_upv_1.IsHost()
            tbl_43.status = v222.status or false
            tbl_43.canStart = v222.canStart or false
            tbl_43.hint = u19.Text
            tbl_43.map = v222.map or false
            tbl_43.public = v222.public or false
            tbl_43.bots = v222.bots or false
            tbl_43.mode = v222.mode or false
            tbl_43.modeShown = u28.Value
            local v223
            if u29.Visible then
                v223 = u29.Text
            else
                v223 = false
            end
            tbl_43.modeValue = v223
            tbl_43.seats = CustomMatch_upv_1.TeamSize(modeOf(v222))
            if type(v222.players) ~= "table" then
                v223 = 0
            else
                v223 = #v222.players
            end
            tbl_43.players = v223
            tbl_43.mapCards = #tbl_upv_15
            v223 = (tbl_upv_34 ~= nil) and (tbl_upv_34.layer.Visible)
            tbl_43.confirm = v223
            tbl_43.code = u4.Text
            if tbl_upv_3.Visible then
                v223 = Custom_upv_1.MASK
            else
                v223 = u4.Text
            end
            tbl_43.codeShown = v223
            tbl_43.masked = tbl_upv_3.Visible
            tbl_43.eye = u5.Visible
            tbl_43.copying = u75
            tbl_43.focused = u4:IsFocused()
            tbl_43.selection = string.format("%d..%d", u4.SelectionStart, u4.CursorPosition)
            if u9.Visible then
                v223 = u9.Text
            else
                v223 = false
            end
            tbl_43.copyHint = v223
            tbl_43.copyLabel = u8.Label.Text
            tbl_43.readOnly = u17.Visible
            tbl_43.size = string.format("%dx%d", u2.Holder.Size.X.Offset, u2.Holder.Size.Y.Offset)
            tbl_43.team = u70 or false
            tbl_43.team1 = tbl_upv_26[1]
            tbl_43.team2 = tbl_upv_26[2]
            tbl_43.random = tbl_upv_26[3]
            if joinSeat(1) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join1 = v223
            if joinSeat(2) ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.join2 = v223
            local v224 = not (card.btn.Visible) or not (card.join) or card
            if v224 ~= nil then
                v223 = true
            else
                v223 = false
            end
            tbl_43.joinRandom = v223
            tbl_43.preview = u15.Text
            v223 = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            tbl_43.move = tbl_upv_35 ~= nil and tbl_upv_35.layer.Visible
            local v223 = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            tbl_43.movePicks = tbl_upv_35 and {tbl_upv_35.picks[1].Enabled, tbl_upv_35.picks[2].Enabled, tbl_upv_35.picks[3].Enabled} or false
            local v225 = 0
            local v223 = v225
            for _, value_27 in tbl_upv_20 do
                v223 = ((value_27.more.Visible) and (v223 + 1)) or v223
            end
            tbl_43.moreShown = v223
            return tbl_43
        end
    end
end
return tbl_1