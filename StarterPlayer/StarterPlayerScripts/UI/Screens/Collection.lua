local RunService_upv_1 = game:GetService("RunService")
local TextChatService_upv_1 = game:GetService("TextChatService")
local StarterGui_upv_1 = game:GetService("StarterGui")
local GuiService_upv_1 = game:GetService("GuiService")
local Unlocks_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Unlocks"))
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local tbl_1 = {}
local u1 = nil
local function hideChat()
    --[[
      name: hideChat
      line: 41
      upvalues:
        u1 (ref, index: 1)
    ]]
    if u1 then
        return
    end
    local tbl_2 = {}
    pcall(function() end)
    u1 = tbl_2
end
local function restoreChat()
    --[[
      name: restoreChat
      line: 65
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v1 = u1
    if not v1 then
        return
    end
    u1 = nil
    pcall(function() end)
end
local function hex(a1)
    --[[
      name: hex
      line: 86
    ]]
    return string.format("#%02X%02X%02X", math.floor((a1.R * 255) + 0.5), math.floor((a1.G * 255) + 0.5), math.floor((a1.B * 255) + 0.5))
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 90
      upvalues:
        Unlocks_upv_1 (copy, index: 1)
        GuiService_upv_1 (copy, index: 2)
        RankArt_upv_1 (copy, index: 3)
        RunService_upv_1 (copy, index: 4)
        u1 (ref,  index: 5)
        TextChatService_upv_1 (copy, index: 6)
        StarterGui_upv_1 (copy, index: 7)
        restoreChat (copy, index: 8)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Economy_upv_1 = a1.Economy
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local fromOffset_upv_1 = UDim2.fromOffset
    local MAX_LEVEL_upv_1 = Economy_upv_1.MAX_LEVEL
    local Success_upv_1 = Colors_upv_1.Success
    local Gold_upv_1 = Colors_upv_1.Gold
    local TextMuted_1 = Colors_upv_1.TextMuted
    local u2 = string.format("#%02X%02X%02X", math.floor((TextMuted_1.R * 255) + 0.5), math.floor((TextMuted_1.G * 255) + 0.5), math.floor((TextMuted_1.B * 255) + 0.5))
    local u3 = Theme_upv_1.Lighten(Success_upv_1, 0.15)
    local u4 = string.format("#%02X%02X%02X", math.floor((u3.R * 255) + 0.5), math.floor((u3.G * 255) + 0.5), math.floor((u3.B * 255) + 0.5))
    u3 = string.format("#%02X%02X%02X", math.floor((Gold_upv_1.R * 255) + 0.5), math.floor((Gold_upv_1.G * 255) + 0.5), math.floor((Gold_upv_1.B * 255) + 0.5))
    local function catOf(a2)
        --[[
          name: catOf
          line: 104
          upvalues:
            Economy_upv_1 (copy, index: 1)
        ]]
        return Economy_upv_1.CategoryColor(a2)
    end
    local function catWord(a3)
        --[[
          name: catWord
          line: 107
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v2 = WeaponInfo_upv_1.Get(a3)
        return string.upper(((not v2) and "") or (WeaponInfo_upv_1.CATEGORY_SINGULAR[v2.category] or ""))
    end
    local function tint(a4, a5)
        --[[
          name: tint
          line: 111
          upvalues:
            Colors_upv_1 (copy, index: 1)
        ]]
        return ColorSequence.new(a4:Lerp(Colors_upv_1.Panel, 1 - a5), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
    end
    local function stateOf(a6)
        --[[
          name: stateOf
          line: 118
          upvalues:
            Economy_upv_1 (copy, index: 1)
        ]]
        if Economy_upv_1.Level(a6) <= 0 then
            return "locked"
        else
            local _, v4, v3 = Economy_upv_1.Progress(a6)
            if v3 ~= "max" then
                if Economy_upv_1.CanUpgrade(a6) then
                    return "ready"
                end
                return "owned"
            elseif Economy_upv_1.MaxLevel(a6) <= 1 then
                return "fixed"
            else
                return "max"
            end
        end
    end
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 140
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Close("Collection")
    end
    local u5 = UI_upv_1.Window({HeaderHeight = 80, Name = "Collection", OpenSound = "Armory_Open", Title = "COLLECTION", Subtitle = string.format("Win matches to find shards  \194\183  Shards unlock items and upgrade them (max +%d%%)", Economy_upv_1.MaxBonusPercent()), Size = UDim2.fromOffset(1180, 720), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local Content_1 = u5.Content
    local u6 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Summary", TextSize = 16, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -(UI_upv_1.WindowCloseSize() + 34), 0, 22), Size = fromOffset_upv_1(420, 24), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u5.Header})
    local u7 = UI_upv_1.new("Frame", {Name = "CollectionSelection", Size = UDim2.fromScale(1, 1), UI_upv_1.Corner(14), UI_upv_1.Stroke(Colors_upv_1.Accent, 3, 0)})
    local u8 = UI_upv_1.Panel({Name = "Detail", BackgroundTransparency = 0.06, Size = fromOffset_upv_1(360, 500), Radius = UDim.new(0, 14), Parent = Content_1})
    local u9 = u8:FindFirstChildOfClass("UIGradient")
    local u10 = u8:FindFirstChildOfClass("UIStroke")
    local u11 = UI_upv_1.new("Frame", {Name = "Preview", Size = fromOffset_upv_1(320, 220), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = u8})
    local u12 = UI_upv_1.Gradient(Colors_upv_1.Accent, Colors_upv_1.Panel, 115)
    u12.Parent = u11
    local u13 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.3), ImageColor3 = Colors_upv_1.Accent, Parent = u11})
    local u14 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(0.86, 0.86), Parent = u11})
    local u15 = UI_upv_1.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Gold_upv_1, BackgroundTransparency = 1, ZIndex = 5, [1] = UI_upv_1.Corner(12), Parent = u11})
    local u16 = UI_upv_1.Image(UI_upv_1.Assets.Fx.Ring, {ImageTransparency = 1, Name = "Ring", ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = fromOffset_upv_1(60, 60), ImageColor3 = Gold_upv_1, Parent = u11})
    local u17 = UI_upv_1.new("Frame", {ZIndex = 7, Name = "Burst", Size = UDim2.fromScale(1, 1), Parent = u11})
    local u18 = UI_upv_1.DisplayText({StrokeThickness = 3, Text = "", Name = "LevelSlam", ZIndex = 8, TextSize = 52, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 0, 0, 60), TextColor3 = Gold_upv_1, Parent = u11})
    u18.Visible = false
    local u19 = UI_upv_1.new("Frame", {Name = "Level", Position = fromOffset_upv_1(10, 10), Size = fromOffset_upv_1(76, 34), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.2, ZIndex = 9, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u11})
    local u20 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.8)
    u20.Parent = u19
    local u21 = UI_upv_1.new("TextLabel", {Text = "LV", Name = "Lv", ZIndex = 9, TextSize = 14, Position = fromOffset_upv_1(12, 0), Size = fromOffset_upv_1(22, 34), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u19})
    local u22 = UI_upv_1.new("Frame", {Name = "Num", ZIndex = 9, ClipsDescendants = true, Position = fromOffset_upv_1(36, 2), Size = fromOffset_upv_1(30, 30), Parent = u19})
    local u23 = UI_upv_1.new("TextLabel", {ZIndex = 9, Name = "A", Text = "1", TextSize = 24, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = u22})
    local u24 = UI_upv_1.new("TextLabel", {Text = "", Name = "B", ZIndex = 9, TextSize = 24, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Gold_upv_1, TextXAlignment = Enum.TextXAlignment.Left, Parent = u22})
    local u25 = UI_upv_1.new("Frame", {Name = "Lock", Position = fromOffset_upv_1(10, 10), Size = fromOffset_upv_1(36, 36), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.2, ZIndex = 9, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u11})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Lock, {ZIndex = 9, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(18, 18), ImageColor3 = Colors_upv_1.TextDim, Parent = u25})
    local u26 = UI_upv_1.new("TextLabel", {Name = "ItemName", Text = "", TextSize = 30, TextScaled = true, FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, Parent = u8})
    local u27 = UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 30, MinTextSize = 14, Parent = u26})
    local u28 = UI_upv_1.new("TextLabel", {RichText = true, Name = "Sub", Text = "", TextSize = 14, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u8})
    local u29 = UI_upv_1.new("TextLabel", {Name = "BarCaption", Text = "SHARDS", TextSize = 12, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u8})
    local u30 = UI_upv_1.new("TextLabel", {Name = "BarGoal", Text = "", TextSize = 12, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u8})
    local u31 = UI_upv_1.Bar({Name = "Shards", Stroke = false, Size = fromOffset_upv_1(300, 24), Color = Colors_upv_1.Accent, Parent = u8})
    local u32 = UI_upv_1.new("TextLabel", {Name = "Count", ZIndex = 3, Text = "", TextSize = 16, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = u31.Frame})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = u32
    local u33 = UI_upv_1.new("Frame", {Name = "Divider", BackgroundTransparency = 0.9, BackgroundColor3 = Colors_upv_1.Text, Size = fromOffset_upv_1(300, 1), Parent = u8})
    local u34 = UI_upv_1.new("TextLabel", {Name = "BonusCaption", Text = "DAMAGE BONUS", TextSize = 12, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u8})
    local u35 = UI_upv_1.new("Frame", {Name = "Bonus", Size = fromOffset_upv_1(300, 36), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u8})
    local u36 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Now", TextSize = 32, Text = "+0%", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Display, Parent = u35})
    local u37 = UI_upv_1.Icon("chevRight", 18, Colors_upv_1.TextMuted, {LayoutOrder = 2, Parent = u35})
    local u38 = UI_upv_1.new("TextLabel", {LayoutOrder = 3, Text = "+2%", Name = "Next", TextSize = 32, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Display, TextColor3 = Theme_upv_1.Lighten(Success_upv_1, 0.15), Parent = u35})
    local u39 = UI_upv_1.new("TextLabel", {LayoutOrder = 4, AutoLocalize = false, Text = "damage", Name = "Word", TextSize = 16, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = u35})
    local function pct(a7)
        --[[
          name: pct
          line: 114
        ]]
        return string.format("+%d%%", a7)
    end
    local u40 = UI_upv_1.CountUp(
        u36,
        function(a8)
            --[[
              line: 303
              upvalues:
                pct (copy, index: 1)
            ]]
            return pct(a8)
        end,
        0.6
    )
    local u41 = UI_upv_1.CountUp(
        u38,
        function(a9)
            --[[
              line: 306
              upvalues:
                pct (copy, index: 1)
            ]]
            return pct(a9)
        end,
        0.6
    )
    local u42 = UI_upv_1.new("Frame", {Name = "Pips", Size = fromOffset_upv_1(300, 10), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u8})
    local tbl_upv_3 = {}
    for n_1 = 1, MAX_LEVEL_upv_1 do
        tbl_upv_3[n_1] = UI_upv_1.new("Frame", {Name = "Pip" .. n_1, Size = fromOffset_upv_1(40, 8), BackgroundColor3 = Colors_upv_1.Inset, LayoutOrder = n_1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u42})
        local u43 = n_1
    end
    local u44 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Note", TextSize = 14, TextWrapped = true, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = u8})
    local u45 = UI_upv_1.new("Frame", {Name = "ActionBox", Size = fromOffset_upv_1(300, 56), Parent = u8})
    local u43 = UI_upv_1.GetScaleObj(u45, "Pulse")
    local u46 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.new(1, 60, 2.4, 0), ImageColor3 = Success_upv_1, Parent = u45})
    local u47 = UI_upv_1.Button({PassInput = true, Radius = 12, Name = "Action", Style = "Success", Text = "UPGRADE", TextSize = 21, Size = UDim2.fromScale(1, 1), Parent = u45})
    u47.Label.RichText = true
    local u48 = UI_upv_1.new("TextLabel", {RichText = true, Name = "ActionNote", Text = "", TextSize = 13, AutoLocalize = false, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, Parent = u8})
    local u49 = UI_upv_1.new("ScrollingFrame", {Name = "Grid", ScrollBarThickness = 5, ScrollBarImageTransparency = 0.4, AutomaticCanvasSize = Enum.AutomaticSize.None, ScrollBarImageColor3 = Colors_upv_1.TextMuted, Parent = Content_1})
    local u50 = 900
    local function screenPerDesign()
        --[[
          name: screenPerDesign
          line: 358
          upvalues:
            u49 (copy, index: 1)
            u50 (ref,  index: 2)
        ]]
        return (math.max(u49.AbsoluteSize.X / math.max(u50, 1), 0.01))
    end
    local tbl_upv_4 = {"owned", "locked"}
    local tbl_upv_5 = {}
    local function makeHeader(a10, a11, a12)
        --[[
          name: makeHeader
          line: 364
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local v4 = UI_upv_1.new("Frame", {Name = a10, Size = UDim2.new(1, -8, 0, 34), Parent = a12})
        UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = v4})
        UI_upv_1.new("UIPadding", {PaddingLeft = UDim.new(0, 4), Parent = v4})
        local tbl_6 = {}
        tbl_6.Name = "Bar"
        tbl_6.BackgroundColor3 = a11
        tbl_6.Size = fromOffset_upv_1(4, 18)
        tbl_6.LayoutOrder = 0
        tbl_6[1] = UI_upv_1.Corner(2)
        tbl_6.Parent = v4
        local tbl_7 = {}
        tbl_7.frame = v4
        tbl_7.tick = UI_upv_1.new("Frame", tbl_6)
        tbl_7.title = UI_upv_1.new("TextLabel", {LayoutOrder = 1, RichText = true, Text = "", Name = "Text", TextSize = 16, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v4})
        tbl_7.sub = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "", Name = "Sub", TextSize = 14, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, Parent = v4})
        return tbl_7
    end
    tbl_upv_5.owned = makeHeader("Section_owned", Colors_upv_1.Accent, u49)
    tbl_upv_5.locked = makeHeader("Section_locked", Colors_upv_1.TextMuted, u49)
    tbl_upv_5.owned.sub.Text = string.format("level up with shards  \194\183  +%d%% per level", math.floor((Economy_upv_1.BONUS_PER_LEVEL * 100) + 0.5))
    tbl_upv_5.locked.sub.Text = "find shards in drops to unlock"
    local u51 = UI_upv_1.new("Frame", {Visible = false, Name = "Shop", Size = UDim2.new(1, -12, 0, 104), Parent = u49})
    local _ = UI_upv_1.Panel({StrokeTransparency = 0.6, Name = "Bg", BackgroundTransparency = 0.05, Size = UDim2.fromScale(1, 1), Radius = UDim.new(0, 14), TopColor = Gold_upv_1:Lerp(Colors_upv_1.Panel, 0.8), BottomColor = Gold_upv_1:Lerp(Colors_upv_1.PanelLo, 0.92), StrokeColor = Gold_upv_1, Parent = u51})
    local u52 = UI_upv_1.new("Frame", {Name = "Emblem", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Size = fromOffset_upv_1(76, 76), Parent = u51})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.7, 1.7), ImageColor3 = Gold_upv_1, Parent = u52})
    local tbl_8 = {}
    tbl_8.Name = "Gem"
    tbl_8.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_8.Position = UDim2.fromScale(0.5, 0.5)
    tbl_8.Size = UDim2.fromScale(0.66, 0.66)
    tbl_8.Rotation = 45
    tbl_8.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_8[1], tbl_8[2], tbl_8[3] = UI_upv_1.Corner(10), UI_upv_1.Gradient(Color3.fromRGB(255, 214, 110), Color3.fromRGB(214, 138, 20), 90), UI_upv_1.Stroke(Color3.fromRGB(255, 230, 160), 2, 0.3)
    tbl_8.Parent = u52
    local v5 = UI_upv_1.new("Frame", tbl_8)
    UI_upv_1.new("Frame", {Name = "Facet", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), BackgroundColor3 = Color3.fromRGB(255, 226, 150), BackgroundTransparency = 0.55, [1] = UI_upv_1.Corner(6), Parent = v5})
    UI_upv_1.Image(UI_upv_1.Assets.Icons.Star, {Name = "Star", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(26, 26), ImageColor3 = Color3.fromRGB(120, 70, 8), Parent = u52})
    local u53 = UI_upv_1.new("TextLabel", {Text = "GOLDEN DROP", Name = "Title", TextSize = 24, Position = fromOffset_upv_1(104, 18), Size = fromOffset_upv_1(300, 28), FontFace = Fonts_upv_1.Display, TextColor3 = Gold_upv_1, TextXAlignment = Enum.TextXAlignment.Left, Parent = u51})
    local u54 = UI_upv_1.new("TextLabel", {Text = "", TextWrapped = true, Name = "Line", TextSize = 14, Position = fromOffset_upv_1(104, 48), Size = fromOffset_upv_1(300, 40), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = u51})
    local u55 = UI_upv_1.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = fromOffset_upv_1(470, 50), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = u51})
    local u56 = UI_upv_1.Button({LayoutOrder = 1, Radius = 10, Name = "Odds", Style = "Dark", Text = "VIEW ODDS", TextSize = 15, Size = fromOffset_upv_1(122, 46), Parent = u55})
    local u57 = UI_upv_1.Button({LayoutOrder = 2, Radius = 10, Name = "Buy1", Style = "Success", Text = "", TextSize = 16, Size = fromOffset_upv_1(150, 46), Parent = u55})
    local u58 = UI_upv_1.Button({LayoutOrder = 3, Radius = 10, Name = "Buy5", Style = "Success", Text = "", TextSize = 16, Size = fromOffset_upv_1(166, 46), Parent = u55})
    u57.Label.RichText = true
    u58.Label.RichText = true
    local u59 = UI_upv_1.Pill("", Gold_upv_1, {PadX = 7, Transparency = 0, Name = "Save", Height = 20, ZIndex = 3, TextSize = 11, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, -1), TextColor = Colors_upv_1.TextDark})
    u59.Parent = u58.Instance
    local u60 = UI_upv_1.Pill("", Color3.fromRGB(245, 52, 64), {Visible = false, PadX = 8, Transparency = 0, Name = "Sale", Height = 22, ZIndex = 3, TextSize = 12, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, -1)})
    u60.Parent = u57.Instance
    local u61 = UI_upv_1.new("TextButton", {Visible = false, Name = "Odds", BackgroundTransparency = 0.35, Selectable = false, ZIndex = 20, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = u5.Body})
    UI_upv_1.Corner(UDim.new(0, 16)).Parent = u61
    local u62 = UI_upv_1.Panel({StrokeTransparency = 0.6, Active = true, Name = "Card", ZIndex = 21, BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(560, 420), Radius = UDim.new(0, 16), StrokeColor = Gold_upv_1, Parent = u61})
    local u63 = UI_upv_1.GetScaleObj(u62, "FitScale")
    UI_upv_1.new("TextLabel", {Text = "GOLDEN DROP ODDS", Name = "Title", ZIndex = 22, TextSize = 26, Position = fromOffset_upv_1(24, 18), Size = UDim2.new(1, -90, 0, 30), FontFace = Fonts_upv_1.Display, TextColor3 = Gold_upv_1, TextXAlignment = Enum.TextXAlignment.Left, Parent = u62})
    local u64 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", ZIndex = 22, TextSize = 14, Position = fromOffset_upv_1(24, 50), Size = UDim2.new(1, -48, 0, 18), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u62})
    local v6 = UI_upv_1.IconButton({IconName = "cross", Name = "Close", Sound = "Close", ZIndex = 23, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 14), Size = fromOffset_upv_1(44, 44), Color = Colors_upv_1.Raised, HoverColor = Colors_upv_1.Danger, Parent = u62})
    local u65 = UI_upv_1.new("ScrollingFrame", {Name = "List", Position = fromOffset_upv_1(24, 80), Size = UDim2.new(1, -48, 1, -164), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 4, ScrollBarImageColor3 = Colors_upv_1.TextMuted, ZIndex = 22, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 2, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top), Parent = u62})
    local oddsValue = UI_upv_1.new("Frame", {Name = "Buy", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -18), Size = UDim2.new(1, -48, 0, 50), ZIndex = 22, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 12, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = u62})
    local u66 = UI_upv_1.Button({LayoutOrder = 1, Radius = 10, Text = "", Name = "Buy1", Style = "Success", ZIndex = 23, TextSize = 17, Size = fromOffset_upv_1(220, 48), Parent = oddsValue})
    local u67 = UI_upv_1.Button({LayoutOrder = 2, Radius = 10, Text = "", Name = "Buy5", Style = "Success", ZIndex = 23, TextSize = 17, Size = fromOffset_upv_1(220, 48), Parent = oddsValue})
    u66.Label.RichText = true
    u67.Label.RichText = true
    local function oddsLabel(a13)
        --[[
          name: oddsLabel
          line: 549
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v7 = ((type(a13.item) == "string") and (a13.item)) or (((type(a13.id) == "string" and not (not (WeaponInfo_upv_1.Get(a13.id)))) and (a13.id)) or nil)
        if v7 and WeaponInfo_upv_1.Get(v7) then
            return WeaponInfo_upv_1.Name(v7)
        end
        for _, value_1 in {"label", "name", "text", "kind", "title"} do
            if type(a13[value_1]) ~= "string" then
                continue
            end
            return a13[value_1]
        end
        return "?"
    end
    oddsValue = function(a14)
        --[[
          name: oddsValue
          line: 532
        ]]
        for _, value_2 in {"value", "text"} do
            if type(a14[value_2]) ~= "string" or not (string.find(a14[value_2], "%%")) then
                continue
            end
            return a14[value_2]
        end
        local v8 = a14.chance or (a14.p or (a14.probability or (a14.percent or (a14.odds or (a14.weight)))))
        if type(v8) ~= "number" then
            return nil
        end
        local v9 = (a14.percent ~= nil) and (type(a14.percent) == "number")
        local v10
        if v9 or v8 > 1 then
            v10 = v8
        else
            v10 = v8 * 100
        end
        if v10 > 0 and v10 < 0.1 then
            return "<0.1%"
        elseif math.abs(v10 - math.floor(v10 + 0.5)) < 0.05 then
            return (string.format("%d%%", math.floor(v10 + 0.5)))
        else
            return (string.format("%.1f%%", v10))
        end
    end
    local function addOddsRow(a15, a16, a17, a18, a19)
        --[[
          name: addOddsRow
          line: 561
          upvalues:
            UI_upv_1 (copy, index: 1)
            u65 (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            u2 (copy, index: 6)
            Gold_upv_1 (copy, index: 7)
        ]]
        local v11 = UI_upv_1.new("Frame", {ZIndex = 22, Name = "Row" .. a18, Size = UDim2.new(1, -8, 0, ((a15 == "title") and 34) or (((a15 ~= "note") and 28) or 0)), LayoutOrder = a18, Parent = u65})
        if a15 ~= "note" then
            local new_1 = UI_upv_1.new
            local v12 = "TextLabel"
            local tbl_9 = {RichText = true, AutoLocalize = false, TextColor3 = 0, Parent = 0, Text = 0, ZIndex = 22, TextTruncate = 0, TextXAlignment = 0, FontFace = 0, TextYAlignment = 0, TextSize = 0}
            tbl_9.Size = UDim2.new(1, -150, 1, 0)
            local T_1 = a1.Loc.T
            local v13
            if a15 == "title" then
                v13 = string.upper(a16)
            elseif a19 then
                v13 = string.format("%s  <font size=\"12\" color=\"%s\">%s</font>", a16, u2, a19)
            else
                v13 = a16
            end
            tbl_9.Text = T_1(v13)
            local v14
            if a15 ~= "title" then
                v14 = Fonts_upv_1.Bold
            else
                v14 = Fonts_upv_1.Heavy
            end
            tbl_9.FontFace = v14
            tbl_9.TextSize = ((a15 ~= "title") and 16) or 14
            local v15
            if a15 ~= "title" then
                v15 = Colors_upv_1.Text
            else
                v15 = Colors_upv_1.TextMuted
            end
            tbl_9.TextColor3 = v15
            tbl_9.TextXAlignment = Enum.TextXAlignment.Left
            if a15 ~= "title" then
                v15 = Enum.TextYAlignment.Center
            else
                v15 = Enum.TextYAlignment.Bottom
            end
            tbl_9.TextYAlignment = v15
            tbl_9.TextTruncate = Enum.TextTruncate.AtEnd
            tbl_9.Parent = v11
            new_1(v12, tbl_9)
            if a17 then
                UI_upv_1.new("TextLabel", {ZIndex = 22, TextSize = 17, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 150, 1, 0), Text = a17, FontFace = Fonts_upv_1.Display, TextColor3 = Gold_upv_1, TextXAlignment = Enum.TextXAlignment.Right, Parent = v11})
            end
            if a15 == "row" then
                UI_upv_1.new("Frame", {BackgroundTransparency = 0.93, ZIndex = 22, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Colors_upv_1.Text, Parent = v11})
            end
        else
            v11.AutomaticSize = Enum.AutomaticSize.Y
            UI_upv_1.new("TextLabel", {TextSize = 13, TextWrapped = true, ZIndex = 22, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = a16, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = v11})
        end
    end
    local function priceLabel(a20, a21)
        --[[
          name: priceLabel
          line: 686
          upvalues:
            Economy_upv_1 (copy, index: 1)
            Unlocks_upv_1 (copy, index: 2)
        ]]
        if Economy_upv_1.Pending(a20) then
            return "\226\128\166"
        else
            local v16
            if a20 ~= Unlocks_upv_1.FIRST_DROP.key then
                v16 = nil
            else
                v16 = Economy_upv_1.Price("drop_golden")
            end
            local v17
            if v16 then
                v17 = string.format("<font color=\"#C9F5D6\"><s>%d</s></font> ", v16)
            else
                v17 = ""
            end
            return string.format("%s  <font color=\"%s\">%s</font> %s%s", a21, "#FFFFFF", Economy_upv_1.ROBUX, v17, Economy_upv_1.PriceAmount(a20))
        end
    end
    local function buildOdds()
        --[[
          name: buildOdds
          line: 613
          upvalues:
            u65 (copy, index: 1)
            addOddsRow (copy, index: 2)
            oddsLabel (copy, index: 3)
            oddsValue (copy, index: 4)
            Economy_upv_1 (copy, index: 5)
            WeaponInfo_upv_1 (copy, index: 6)
        ]]
        for _, value_3 in u65:GetChildren() do
            if value_3:IsA("Frame") then
                value_3:Destroy()
            end
        end
        local u68 = 0
        local u69 = 0
        local function walk_upv_1(a22, a23)
            --[[
              name: walk
              line: 621
              upvalues:
                u68 (ref,  index: 1)
                addOddsRow (copy, index: 2)
                oddsLabel (copy, index: 3)
                walk_upv_1 (copy, index: 4)
                oddsValue (copy, index: 5)
                u69 (ref,  index: 6)
            ]]
            for _, value_4 in a22 do
                if type(value_4) ~= "table" then
                    continue
                end
                local v18 = ((type(value_4.rows) == "table") and (value_4.rows)) or (((type(value_4.items) == "table") and (value_4.items)) or (((type(value_4.odds) == "table") and (value_4.odds)) or (((type(value_4.entries) == "table") and (value_4.entries)) or nil)))
                if not (v18) or not (a23 < 2) then
                    local v19 = oddsValue(value_4)
                    u68 = u68 + 1
                    if v19 then
                        u69 = u69 + 1
                        addOddsRow("row", oddsLabel(value_4), v19, u68)
                        continue
                    end
                    if type(value_4.note) == "string" or type(value_4.text) == "string" then
                        addOddsRow("note", value_4.note or (value_4.text), nil, u68)
                        continue
                    end
                    continue
                end
                u68 = u68 + 1
                addOddsRow("title", oddsLabel(value_4), nil, u68)
                walk_upv_1(v18, a23 + 1)
                if type(value_4.note) == "string" then
                    u68 = u68 + 1
                    addOddsRow("note", value_4.note, nil, u68)
                end
            end
        end
        local v20 = Economy_upv_1.Odds("golden")
        local v21 = Economy_upv_1.DropInfo("golden")
        if type(v20) == "table" and type(v20.items) == "table" then
            local function fmt_1(a24)
                --[[
                  name: fmt
                  line: 652
                  upvalues:
                    oddsValue (copy, index: 1)
                ]]
                return oddsValue({chance = a24}) or "0%"
            end
            u68 = u68 + 1
            addOddsRow("title", "Every Golden Drop", nil, u68)
            if type(v21.stacks) == "number" and type(v21.min) == "number" then
                u68 = u68 + 1
                addOddsRow("row", "Stacks of shards", string.format("%d \195\151 %d\226\128\147%d", v21.stacks, v21.min, v21.max or (v21.min)), u68)
            end
            if type(v20.lockedChance) == "number" then
                u68 = u68 + 1
                u69 = u69 + 1
                addOddsRow("row", "An item you don't own yet", oddsValue({chance = v20.lockedChance}) or "0%", u68)
            end
            u68 = u68 + 1
            addOddsRow("title", "Chance each item is in your drop", nil, u68)
            for _, value_5 in v20.items do
                if type(value_5) ~= "table" or type(value_5.item) ~= "string" then
                    continue
                end
                if type(value_5.chance) == "number" then
                    u68 = u68 + 1
                    u69 = u69 + 1
                    local v22 = WeaponInfo_upv_1.Name(value_5.item)
                    local v23 = oddsValue({chance = value_5.chance}) or "0%"
                    addOddsRow("row", v22, v23, u68, ((value_5.locked) and "LOCKED") or nil)
                end
            end
            u68 = u68 + 1
            addOddsRow("note", "For your collection right now: maxed items never drop, and items in the loadout you carry turn up more often. Stack sizes are random within the range above.", nil, u68)
        else
            walk_upv_1(v20, 0)
        end
        if u69 == 0 then
            u68 = u68 + 1
            addOddsRow("note", "The odds are on their way from the server. Try again in a moment.", nil, u68)
        end
        return u69
    end
    local function paintShop()
        --[[
          name: paintShop
          line: 696
          upvalues:
            Economy_upv_1 (copy, index: 1)
            u54 (copy, index: 2)
            a1 (copy, index: 3)
            u60 (copy, index: 4)
            u64 (copy, index: 5)
            u57 (copy, index: 6)
            priceLabel (copy, index: 7)
            u58 (copy, index: 8)
            u66 (copy, index: 9)
            u67 (copy, index: 10)
            u59 (copy, index: 11)
        ]]
        local v24 = Economy_upv_1.DropInfo("golden")
        local v25 = tonumber(v24.stacks) or 4
        local num_1 = tonumber(v24.min)
        local num_2 = tonumber(v24.max)
        if (num_1) and (num_2) then
            v24 = math.floor(((v25 * (num_1 + num_2)) / 2) + 0.5)
        else
            v24 = 60
        end
        local v26 = Economy_upv_1.GoldenOffer()
        local v27 = Economy_upv_1.OfferLeft()
        if v26 and v26.state == "active" and v27 then
            u54.RichText = true
            a1.Loc.Rich(u54, string.format("<font color=\"#FF8C92\"><b>ONE-TIME OFFER</b>: ends in %s</font>\nAbout %d shards in %d big stacks.", Economy_upv_1.FormatLeft(v27), v24, v25))
        else
            a1.Loc.Rich(u54, string.format("About %d shards in %d big stacks.\nOne is always an item you don't own yet.", v24, v25))
        end
        num_1 = not (v26) or v26.state ~= "active" or Economy_upv_1.OfferDiscount()
        local v28
        if num_1 ~= nil then
            v28 = true
        else
            v28 = false
        end
        u60.Visible = v28
        if num_1 then
            local Text_1 = u60:FindFirstChild("Text")
            Text_1.Text = string.format("-%d%%", num_1)
        end
        u64.Text = string.format("About %d shards in %d stacks. Odds for your collection, before you buy.", v24, v25)
        local v29 = Economy_upv_1.DropKey(1)
        local v30 = Economy_upv_1.DropKey(5)
        u57:SetText(priceLabel(v29, "1 DROP"))
        u58:SetText(priceLabel(v30, "5 DROPS"))
        u66:SetText(priceLabel(v29, "BUY 1"))
        u67:SetText(priceLabel(v30, "BUY 5"))
        u57:SetEnabled(not Economy_upv_1.Pending(v29))
        u58:SetEnabled(not Economy_upv_1.Pending(v30))
        u66:SetEnabled(not Economy_upv_1.Pending(v29))
        u67:SetEnabled(not Economy_upv_1.Pending(v30))
        local v31 = Economy_upv_1.Price(v29) or 0
        local v32 = Economy_upv_1.Price(v30) or 0
        if (v31 > 0) and (v32 > 0) then
            v28 = math.floor(((1 - (v32 / (5 * v31))) * 100) + 0.5)
        else
            v28 = 0
        end
        local v33
        if v28 >= 5 then
            v33 = true
        else
            v33 = false
        end
        u59.Visible = v33
        local Text_2 = u59:FindFirstChild("Text")
        Text_2.Text = string.format("SAVE %d%%", v28)
    end
    local function closeOdds()
        --[[
          name: closeOdds
          line: 747
          upvalues:
            u61 (copy, index: 1)
            GuiService_upv_1 (copy, index: 2)
            u56 (copy, index: 3)
        ]]
        if not u61.Visible then
            return
        end
        u61.Visible = false
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        if not SelectedObject_1 then
            return
        end
        if SelectedObject_1:IsDescendantOf(u61) then
            GuiService_upv_1.SelectedObject = u56.Instance
        end
    end
    local function openOdds()
        --[[
          name: openOdds
          line: 730
          upvalues:
            buildOdds (copy, index: 1)
            paintShop (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u5 (copy, index: 4)
            u62 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            u63 (copy, index: 7)
            u61 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            a1 (copy, index: 10)
            GuiService_upv_1 (copy, index: 11)
            u66 (copy, index: 12)
        ]]
        buildOdds()
        paintShop()
        local _ = UI_upv_1.CanvasSize()
        u62.Size = fromOffset_upv_1(560, math.min(460, math.floor(u5.Holder.Size.Y.Offset - 40)))
        u63.Scale = math.min(1, (u5.Holder.Size.X.Offset - 40) / 560)
        u61.Visible = true
        u61.BackgroundTransparency = 1
        UI_upv_1.Tween(u61, Theme_upv_1.Tween.Smooth, {BackgroundTransparency = 0.35})
        UI_upv_1.SlideIn(u62, Vector2.new(0, 24), Theme_upv_1.Tween.Pop, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = u66.Instance
    end
    u56.Activated:Connect(openOdds)
    v6.Activated:Connect(closeOdds)
    u61.Activated:Connect(closeOdds)
    local function buyDrops(a25)
        --[[
          name: buyDrops
          line: 760
          upvalues:
            Economy_upv_1 (copy, index: 1)
            paintShop (copy, index: 2)
        ]]
        if not Economy_upv_1.DropsAllowed() then
            return
        end
        Economy_upv_1.Buy(Economy_upv_1.DropKey(a25))
        paintShop()
    end
    u57.Activated:Connect(
        function()
            --[[
              line: 767
              upvalues:
                Economy_upv_1 (copy, index: 1)
                paintShop (copy, index: 2)
            ]]
            if not Economy_upv_1.DropsAllowed() then
                return
            end
            Economy_upv_1.Buy(Economy_upv_1.DropKey(1))
            paintShop()
        end
    )
    u58.Activated:Connect(
        function()
            --[[
              line: 770
              upvalues:
                Economy_upv_1 (copy, index: 1)
                paintShop (copy, index: 2)
            ]]
            if not Economy_upv_1.DropsAllowed() then
                return
            end
            Economy_upv_1.Buy(Economy_upv_1.DropKey(5))
            paintShop()
        end
    )
    u66.Activated:Connect(
        function()
            --[[
              line: 773
              upvalues:
                Economy_upv_1 (copy, index: 1)
                paintShop (copy, index: 2)
            ]]
            if not Economy_upv_1.DropsAllowed() then
                return
            end
            Economy_upv_1.Buy(Economy_upv_1.DropKey(1))
            paintShop()
        end
    )
    u67.Activated:Connect(
        function()
            --[[
              line: 776
              upvalues:
                Economy_upv_1 (copy, index: 1)
                paintShop (copy, index: 2)
            ]]
            if not Economy_upv_1.DropsAllowed() then
                return
            end
            Economy_upv_1.Buy(Economy_upv_1.DropKey(5))
            paintShop()
        end
    )
    local function cardH()
        --[[
          name: cardH
          line: 781
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return 184
        end
        return 212
    end
    local tbl_upv_10 = {}
    local tbl_upv_11 = {}
    local u70 = nil
    local u71 = nil
    local u72 = nil
    local u73 = nil
    local function makeCard(a26)
        --[[
          name: makeCard
          line: 826
          upvalues:
            Economy_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            u49 (copy, index: 4)
            u7 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            RankArt_upv_1 (copy, index: 9)
            Success_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u71 (ref,  index: 12)
            u72 (ref,  index: 13)
            u70 (ref,  index: 14)
            u73 (ref,  index: 15)
        ]]
        local v34 = Economy_upv_1.CategoryColor(a26.id)
        local new_2 = UI_upv_1.new
        local tbl_12 = {Selectable = true, Parent = 0, Size = 0}
        tbl_12.Name = a26.id
        tbl_12.Size = fromOffset_upv_1(170, ((UI_upv_1.Compact) and 184) or 212)
        tbl_12.Parent = u49
        local v35 = new_2("TextButton", tbl_12)
        v35.SelectionImageObject = u7
        local u74 = UI_upv_1.GetScaleObj(v35, "HoverScale")
        local v36 = UI_upv_1.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.08, ClipsDescendants = true, [1] = UI_upv_1.Corner(14), Parent = v35})
        local v37 = UI_upv_1.Gradient(v34:Lerp(Colors_upv_1.Panel, 0.82), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115)
        v37.Parent = v36
        local v38 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9)
        v38.Parent = v36
        local v39 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.72, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 64), Size = fromOffset_upv_1(190, 150), ImageColor3 = v34, Parent = v36})
        local v40 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 12), Size = UDim2.new(1, -28, 1, -100), Parent = v36})
        local tbl_13 = {}
        tbl_13.Name = "Level"
        tbl_13.Position = fromOffset_upv_1(8, 8)
        tbl_13.AutomaticSize = Enum.AutomaticSize.X
        tbl_13.Size = fromOffset_upv_1(0, 24)
        tbl_13.BackgroundColor3 = Colors_upv_1.Void
        tbl_13.BackgroundTransparency = 0.25
        tbl_13.ZIndex = 4
        tbl_13[1], tbl_13[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 9, 0, 9)
        tbl_13.Parent = v36
        local v41 = UI_upv_1.new("Frame", tbl_13)
        local v42 = UI_upv_1.new("TextLabel", {RichText = true, Text = "LV 1", Name = "Text", TextSize = 14, ZIndex = 4, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_upv_1.Display, Parent = v41})
        tbl_13 = UI_upv_1.new("Frame", {Name = "Lock", Position = fromOffset_upv_1(8, 8), Size = fromOffset_upv_1(28, 28), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.25, ZIndex = 4, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v36})
        UI_upv_1.Image(UI_upv_1.Assets.Icons.Lock, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(15, 15), ImageColor3 = Colors_upv_1.TextDim, Parent = tbl_13})
        local v43 = UI_upv_1.new("TextLabel", {Name = "ItemName", ZIndex = 3, TextSize = 17, Position = UDim2.new(0, 12, 1, -84), Size = UDim2.new(1, -24, 0, 22), Text = a26.name, FontFace = Fonts_upv_1.Bold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v36})
        local v44 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", ZIndex = 3, TextSize = 11, Position = UDim2.new(0, 12, 1, -61), Size = UDim2.new(0.62, -12, 0, 15), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v36})
        local v45 = UI_upv_1.new("TextLabel", {Text = "", Name = "Meta", ZIndex = 3, TextSize = 11, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 1, -61), Size = UDim2.new(0.38, 0, 0, 15), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = v36})
        local v46 = RankArt_upv_1.Emblem(1, 18, {ZIndex = 3, Name = "RankEmblem", Position = UDim2.new(0, 10, 1, -62.5), Parent = v36})
        v46.Visible = false
        local v47 = UI_upv_1.new("Frame", {Name = "Shards", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -10), Size = UDim2.new(1, -20, 0, 22), BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.1, ClipsDescendants = true, ZIndex = 3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v36})
        local v48 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v47})
        local v49 = UI_upv_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.2), Colors_upv_1.Accent, 90)
        v49.Parent = v48
        local v50 = UI_upv_1.new("TextLabel", {Name = "Count", ZIndex = 4, Text = "", TextSize = 14, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = v47})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.2, 0.35).Parent = v50
        local tbl_14 = {}
        tbl_14.Name = "Upgrade"
        tbl_14.AnchorPoint = Vector2.new(0.5, 1)
        tbl_14.Position = UDim2.new(0.5, 0, 1, -8)
        tbl_14.Size = UDim2.new(1, -16, 0, 30)
        tbl_14.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_14.Text = ""
        tbl_14.Selectable = true
        tbl_14.Visible = false
        tbl_14.ZIndex = 6
        tbl_14[1], tbl_14[2], tbl_14[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Gradient(Color3.fromRGB(84, 224, 124), Color3.fromRGB(40, 184, 92), 90), UI_upv_1.Stroke(Color3.fromRGB(170, 255, 200), 1, 0.5)
        tbl_14.Parent = v36
        local v51 = UI_upv_1.new("TextButton", tbl_14)
        v51.SelectionImageObject = u7
        local v52 = UI_upv_1.GetScaleObj(v51, "Pulse")
        tbl_14 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Glow, {ImageTransparency = 0.6, Name = "Glow", ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 30, 2.6, 0), ImageColor3 = Success_upv_1, Parent = v51})
        local v53 = UI_upv_1.new("Frame", {Size = UDim2.fromScale(1, 1), ZIndex = 6, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v51})
        UI_upv_1.Icon("chevUp", 13, Colors_upv_1.Text, {LayoutOrder = 1, ZIndex = 6, Parent = v53})
        UI_upv_1.new("TextLabel", {LayoutOrder = 2, TextSize = 15, ZIndex = 6, Text = "UPGRADE", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_upv_1.Display, Parent = v53})
        local v54 = UI_upv_1.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 1, ZIndex = 5, [1] = UI_upv_1.Corner(14), Parent = v36})
        local tbl_upv_15 = {visible = true, h = 0, y = 0, hover = false, shown = false, section = "locked", state = "locked", rendered = false}
        tbl_upv_15.id = a26.id
        tbl_upv_15.holder = v35
        tbl_upv_15.scale = u74
        tbl_upv_15.inner = v36
        tbl_upv_15.grad = v37
        tbl_upv_15.stroke = v38
        tbl_upv_15.glow = v39
        tbl_upv_15.icon = v40
        tbl_upv_15.lv = v41
        tbl_upv_15.lvText = v42
        tbl_upv_15.lock = tbl_13
        tbl_upv_15.name = v43
        tbl_upv_15.sub = v44
        tbl_upv_15.meta = v45
        tbl_upv_15.rankEmblem = v46
        tbl_upv_15.barBg = v47
        tbl_upv_15.barFill = v48
        tbl_upv_15.barFillGrad = v49
        tbl_upv_15.barText = v50
        tbl_upv_15.up = v51
        tbl_upv_15.upScale = v52
        tbl_upv_15.upGlow = tbl_14
        tbl_upv_15.flash = v54
        tbl_upv_15.h = ((UI_upv_1.Compact) and 184) or 212
        v35.MouseEnter:Connect(
            function()
                --[[
                  line: 986
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    tbl_upv_15 (copy, index: 2)
                    a1 (copy, index: 3)
                    u74 (copy, index: 4)
                    Theme_upv_1 (copy, index: 5)
                    u71 (ref,  index: 6)
                ]]
                if UI_upv_1.Touch then
                    return
                end
                tbl_upv_15.hover = true
                a1.Sounds.Play("Hover")
                UI_upv_1.Tween(u74, Theme_upv_1.Tween.PopSmall, {Scale = 1.03})
                u71(tbl_upv_15)
            end
        )
        v35.MouseLeave:Connect(
            function()
                --[[
                  line: 995
                  upvalues:
                    tbl_upv_15 (copy, index: 1)
                    UI_upv_1 (copy, index: 2)
                    u74 (copy, index: 3)
                    Theme_upv_1 (copy, index: 4)
                    u71 (ref,  index: 5)
                ]]
                tbl_upv_15.hover = false
                UI_upv_1.Tween(u74, Theme_upv_1.Tween.Fast, {Scale = 1})
                u71(tbl_upv_15)
            end
        )
        v35.MouseButton1Down:Connect(
            function()
                --[[
                  line: 1000
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u74 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                ]]
                UI_upv_1.Tween(u74, Theme_upv_1.Tween.Instant, {Scale = 0.97})
            end
        )
        v35.MouseButton1Up:Connect(
            function()
                --[[
                  line: 1003
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u74 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    tbl_upv_15 (copy, index: 4)
                ]]
                local Tween_1 = UI_upv_1.Tween
                local PopSmall_1 = Theme_upv_1.Tween.PopSmall
                local tbl_16 = {Scale = 0}
                tbl_16.Scale = ((tbl_upv_15.hover) and 1.03) or 1
                Tween_1(u74, PopSmall_1, tbl_16)
            end
        )
        v35.Activated:Connect(
            function()
                --[[
                  line: 1006
                  upvalues:
                    a1 (copy, index: 1)
                    u72 (ref,  index: 2)
                    a26 (copy, index: 3)
                ]]
                a1.Sounds.Play("Select")
                u72(a26.id)
            end
        )
        v35.SelectionGained:Connect(
            function()
                --[[
                  line: 1010
                  upvalues:
                    u70 (ref,  index: 1)
                    a26 (copy, index: 2)
                    u72 (ref,  index: 3)
                ]]
                if u70 == a26.id then
                    return
                end
                u72(a26.id, {quiet = true})
            end
        )
        v51.MouseEnter:Connect(
            function()
                --[[
                  line: 1015
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                if (UI_upv_1.Touch) then
                    return
                end
                a1.Sounds.Play("Hover")
            end
        )
        v51.Activated:Connect(
            function(a27)
                --[[
                  line: 1020
                  upvalues:
                    u72 (ref,  index: 1)
                    a26 (copy, index: 2)
                    u73 (ref,  index: 3)
                ]]
                u72(a26.id, {quiet = true})
                u73(a26.id, a27)
            end
        )
        return tbl_upv_15
    end
    u71 = function(a28)
        --[[
          line: 1027
          upvalues:
            stateOf (copy, index: 1)
            Economy_upv_1 (copy, index: 2)
            u70 (ref,  index: 3)
            Gold_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            WeaponIcon_upv_1 (copy, index: 7)
            Success_upv_1 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            RankArt_upv_1 (copy, index: 10)
            WeaponInfo_upv_1 (copy, index: 11)
        ]]
        local id_1 = a28.id
        local v55 = stateOf(id_1)
        a28.state = v55
        local v56 = Economy_upv_1.Level(id_1)
        local v57, v58 = Economy_upv_1.Progress(id_1)
        local v59 = Economy_upv_1.CategoryColor(id_1)
        local v60 = u70 == id_1
        local v61 = v55 == "locked"
        a28.lock.Visible = v61
        a28.lv.Visible = not v61
        if v55 ~= "max" then
            a28.lv.BackgroundColor3 = Colors_upv_1.Void
            a28.lv.BackgroundTransparency = 0.25
            local TextDim_1 = Colors_upv_1.TextDim
            a1.Loc.Rich(a28.lvText, string.format("<font size=\"11\" color=\"%s\">LV</font> %d", string.format("#%02X%02X%02X", math.floor((TextDim_1.R * 255) + 0.5), math.floor((TextDim_1.G * 255) + 0.5), math.floor((TextDim_1.B * 255) + 0.5)), v56))
            a28.lvText.TextColor3 = Colors_upv_1.Text
        else
            a28.lv.BackgroundColor3 = Gold_upv_1
            a28.lv.BackgroundTransparency = 0
            a28.lvText.Text = "MAX"
            a28.lvText.TextColor3 = Colors_upv_1.TextDark
        end
        local grad_1 = a28.grad
        local v62
        if v61 then
            v62 = ColorSequence.new(Colors_upv_1.Panel, Colors_upv_1.Panel)
        else
            v62 = ColorSequence.new(v59:Lerp(Colors_upv_1.Panel, 1 - (((v55 == "max") and 0.22) or (((a28.hover) and 0.24) or 0.18))), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
        end
        grad_1.Color = v62
        a28.inner.BackgroundTransparency = (v61 and 0.3) or 0.08
        local glow_1 = a28.glow
        if v61 then
            v62 = 1
        elseif a28.hover or v60 then
            v62 = 0.62
        else
            v62 = 0.74
        end
        glow_1.ImageTransparency = v62
        if a28.rendered then
            WeaponIcon_upv_1.SetDim(a28.icon, v61)
        end
        local name_1 = a28.name
        if v61 then
            v62 = Colors_upv_1.TextDim
        else
            v62 = Colors_upv_1.Text
        end
        name_1.TextColor3 = v62
        if v60 then
            local stroke_1 = a28.stroke
            if v55 ~= "ready" then
                v62 = Colors_upv_1.Accent
            else
                v62 = Success_upv_1
            end
            stroke_1.Color = v62
            a28.stroke.Thickness = 2
            a28.stroke.Transparency = 0
        elseif v55 == "ready" then
            a28.stroke.Color = Success_upv_1
            a28.stroke.Thickness = 2
        elseif v55 ~= "max" then
            a28.stroke.Color = Colors_upv_1.Stroke
            a28.stroke.Thickness = 1
            a28.stroke.Transparency = ((a28.hover) and 0.6) or 0.9
        else
            a28.stroke.Color = Gold_upv_1
            a28.stroke.Thickness = 1
            a28.stroke.Transparency = 0.55
        end
        a28.up.Visible = v55 == "ready"
        a28.barBg.Visible = v55 ~= "ready"
        local v63 = ((not (v58 > 0)) and 1) or (math.clamp(v57 / v58, 0, 1))
        local barFill_1 = a28.barFill
        local v64
        if v55 ~= "max" then
            v64 = v63
        else
            v64 = 1
        end
        barFill_1.Size = UDim2.fromScale(v64, 1)
        local barFill_2 = a28.barFill
        v62 = true
        if v55 ~= "max" then
            v62 = v57 > 0
        end
        barFill_2.Visible = v62
        a28.rankEmblem.Visible = false
        a28.sub.Position = UDim2.new(0, 12, 1, -61)
        a28.sub.Size = UDim2.new(0.62, -12, 0, 15)
        if v55 ~= "max" then
            if v61 and not (Economy_upv_1.RankAllows(id_1)) then
                local v65 = Economy_upv_1.ItemRank(id_1)
                a28.barFillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.1), Colors_upv_1.AccentDark)
                a28.barText.Text = string.format("%d / %d", v57, v58)
                RankArt_upv_1.SetEmblem(a28.rankEmblem, v65)
                a28.rankEmblem.Visible = true
                a28.sub.Position = UDim2.new(0, 32, 1, -61)
                a28.sub.Size = UDim2.new(1, -44, 0, 15)
                a28.sub.Text = "REACH " .. string.upper(RankArt_upv_1.Ranks.Get(v65).name)
                a28.sub.TextColor3 = RankArt_upv_1.Color(v65)
                a28.meta.Text = ""
                return
            end
            if v61 then
                a28.barFillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.1), Colors_upv_1.AccentDark)
                a28.barText.Text = string.format("%d / %d", v57, v58)
                a28.sub.Text = "LOCKED"
                a28.sub.TextColor3 = Colors_upv_1.TextMuted
                a28.meta.Text = "TO UNLOCK"
                a28.meta.TextColor3 = Colors_upv_1.TextMuted
            elseif v55 == "ready" then
                a28.sub.Text = "UPGRADE READY"
                a28.sub.TextColor3 = Theme_upv_1.Lighten(Success_upv_1, 0.15)
                a28.meta.Text = string.format("%d / %d", v57, v58)
                a28.meta.TextColor3 = Colors_upv_1.TextDim
            elseif v55 ~= "fixed" then
                a28.barFillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.2), Colors_upv_1.Accent)
                a28.barText.Text = string.format("%d / %d", v57, v58)
                local sub_1 = a28.sub
                if v56 > 1 then
                    v62 = string.upper(Economy_upv_1.BonusText(id_1, v56))
                else
                    local v66 = WeaponInfo_upv_1.Get(id_1)
                    v62 = string.upper(((not v66) and "") or (WeaponInfo_upv_1.CATEGORY_SINGULAR[v66.category] or ""))
                end
                sub_1.Text = v62
                a28.sub.TextColor3 = Colors_upv_1.TextMuted
                a28.meta.Text = "TO LV " .. v56 + 1
                a28.meta.TextColor3 = Colors_upv_1.TextMuted
            else
                a28.barFill.Visible = false
                a28.barText.Text = "NO LEVELS"
                local sub_2 = a28.sub
                local v67 = WeaponInfo_upv_1.Get(id_1)
                sub_2.Text = string.upper(((not v67) and "") or (WeaponInfo_upv_1.CATEGORY_SINGULAR[v67.category] or ""))
                a28.sub.TextColor3 = Colors_upv_1.TextMuted
                a28.meta.Text = ""
            end
        else
            a28.barFillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(Gold_upv_1, 0.15), Gold_upv_1:Lerp(Color3.fromRGB(180, 110, 10), 0.3))
            a28.barText.Text = "MAX"
            a28.sub.Text = "MAX LEVEL"
            a28.sub.TextColor3 = Gold_upv_1
            a28.meta.Text = string.upper(Economy_upv_1.BonusText(id_1, v56))
            a28.meta.TextColor3 = Gold_upv_1
        end
    end
    local tbl_upv_17 = {}
    local function queueVisible()
        --[[
          name: queueVisible
          line: 1130
          upvalues:
            u49 (copy, index: 1)
            u50 (ref,  index: 2)
            tbl_upv_10 (copy, index: 3)
            tbl_upv_17 (copy, index: 4)
            WeaponIcon_upv_1 (copy, index: 5)
        ]]
        local v68 = math.max(u49.AbsoluteSize.X / math.max(u50, 1), 0.01)
        local v69 = u49.CanvasPosition.Y / v68
        local v70 = v69 + u49.AbsoluteWindowSize.Y / v68
        for _, value_6 in tbl_upv_10 do
            if not value_6.visible or not (v69 - value_6.h <= value_6.y + value_6.h) or not (value_6.y <= v70 + value_6.h) or value_6.rendered then
                if not (value_6.rendered) then
                    continue
                end
                if not (value_6.visible) or value_6.y + value_6.h < v69 - (value_6.h * 2) or v70 + (value_6.h * 2) < value_6.y then
                    value_6.rendered = false
                    local v71 = table.find(tbl_upv_17, value_6)
                    if v71 then
                        table.remove(tbl_upv_17, v71)
                    end
                    WeaponIcon_upv_1.Set(value_6.icon, nil)
                end
                continue
            end
            value_6.rendered = true
            table.insert(tbl_upv_17, value_6)
        end
    end
    RunService_upv_1.Heartbeat:Connect(
        function()
            --[[
              line: 1150
              upvalues:
                tbl_upv_17 (copy, index: 1)
                u5 (copy, index: 2)
                UI_upv_1 (copy, index: 3)
                WeaponIcon_upv_1 (copy, index: 4)
            ]]
            if #tbl_upv_17 == 0 or not u5.IsOpen then
                return
            end
            for _ = 1, ((UI_upv_1.Touch) and 2) or 4 do
                local v72 = table.remove(tbl_upv_17, 1)
                if v72 then
                    WeaponIcon_upv_1.Set(v72.icon, v72.id, {outline = false, glow = false})
                    WeaponIcon_upv_1.SetDim(v72.icon, v72.state == "locked")
                    continue
                else
                    break
                end
            end
        end
    )
    u49:GetPropertyChangedSignal("CanvasPosition"):Connect(queueVisible)
    local u75 = true
    local function layoutPanel(a29, a30, a31)
        --[[
          name: layoutPanel
          line: 1167
          upvalues:
            u8 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            u11 (copy, index: 3)
            u27 (copy, index: 4)
            u26 (copy, index: 5)
            u28 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u19 (copy, index: 8)
            u25 (copy, index: 9)
            u18 (copy, index: 10)
            u29 (copy, index: 11)
            u30 (copy, index: 12)
            u31 (copy, index: 13)
            u32 (copy, index: 14)
            u33 (copy, index: 15)
            u34 (copy, index: 16)
            tbl_upv_3 (copy, index: 17)
            MAX_LEVEL_upv_1 (copy, index: 18)
            u42 (copy, index: 19)
            u35 (copy, index: 20)
            u36 (copy, index: 21)
            u38 (copy, index: 22)
            u39 (copy, index: 23)
            u44 (copy, index: 24)
            u75 (ref,  index: 25)
            u45 (copy, index: 26)
            u47 (copy, index: 27)
            u48 (copy, index: 28)
        ]]
        u8.Size = fromOffset_upv_1(a29, a30)
        local v73 = (a31 and 12) or 16
        local v74 = a29 - v73 * 2
        local v75 = (a31 and 48) or 56
        local v76 = (a31 and 14) or 16
        local v77
        if a31 then
            u11.Position = fromOffset_upv_1(v73, v73)
            u11.Size = fromOffset_upv_1(104, 104)
            local v78 = v73 + 104 + 12
            u27.MaxTextSize = 24
            u26.Position = fromOffset_upv_1(v78, v73 + 20)
            u26.Size = fromOffset_upv_1((a29 - v78) - v73, 30)
            u28.Position = fromOffset_upv_1(v78, v73 + 54)
            u28.Size = fromOffset_upv_1((a29 - v78) - v73, 16)
            u28.TextSize = 12
            v77 = v73 + 104 + 12
        else
            local v79 = math.clamp(a30 - v73 - 279 - (v75 + 16 + 4 + v76 + v73), 150, 300)
            u11.Position = fromOffset_upv_1(v73, v73)
            u11.Size = fromOffset_upv_1(v74, v79)
            u27.MaxTextSize = 30
            local v80 = v73 + v79 + 14
            u26.Position = fromOffset_upv_1(v73, v80)
            u26.Size = fromOffset_upv_1(v74, 36)
            local v81 = v80 + 36
            u28.Position = fromOffset_upv_1(v73, v81)
            u28.Size = fromOffset_upv_1(v74, 20)
            u28.TextSize = 15
            v81 = v81 + 38
            v77 = v81
        end
        local v82 = (a31 and 0.8) or 1
        UI_upv_1.GetScaleObj(u19, "Size").Scale = v82
        UI_upv_1.GetScaleObj(u25, "Size").Scale = v82
        u18.TextSize = (a31 and 30) or 52
        u29.Position = fromOffset_upv_1(v73, v77)
        u29.Size = fromOffset_upv_1(v74, 16)
        u29.TextSize = (a31 and 11) or 12
        u30.Position = fromOffset_upv_1(v73, v77)
        u30.Size = fromOffset_upv_1(v74, 16)
        u30.TextSize = (a31 and 11) or 12
        v77 = v77 + 18
        local v83 = (a31 and 20) or 26
        u31.Frame.Position = fromOffset_upv_1(v73, v77)
        u31.Frame.Size = fromOffset_upv_1(v74, v83)
        u32.TextSize = (a31 and 14) or 17
        v77 = v77 + (v83 + ((a31 and 12) or 16))
        u33.Position = fromOffset_upv_1(v73, v77)
        u33.Size = fromOffset_upv_1(v74, 1)
        v77 = v77 + (((a31 and 10) or 16) + 1)
        u34.Position = fromOffset_upv_1(v73, v77)
        u34.Size = fromOffset_upv_1(v74, 16)
        u34.TextSize = (a31 and 11) or 12
        local v84 = (a31 and 18) or 26
        for _, value_7 in tbl_upv_3 do
            value_7.Size = fromOffset_upv_1(v84, (a31 and 6) or 8)
        end
        local v85 = MAX_LEVEL_upv_1 * v84 + (MAX_LEVEL_upv_1 - 1) * 6
        u42.Position = fromOffset_upv_1((v73 + v74) - v85, v77 + 4)
        u42.Size = fromOffset_upv_1(v85, 8)
        v77 = v77 + (((a31 and 2) or 4) + 16)
        u35.Position = fromOffset_upv_1(v73, v77)
        u35.Size = fromOffset_upv_1(v74, (a31 and 30) or 40)
        u36.TextSize = (a31 and 24) or 34
        u38.TextSize = (a31 and 24) or 34
        u39.TextSize = (a31 and 14) or 17
        local v86 = (a31 and 30) or 40
        v77 = v77 + (v86 + ((a31 and 4) or 8))
        u44.Position = fromOffset_upv_1(v73, v77)
        u44.Size = fromOffset_upv_1(v74, (a31 and 34) or 40)
        u44.TextSize = (a31 and 13) or 14
        u75 = (v76 + 4) <= ((((a30 - (v77 + ((a31 and 34) or 40))) - v73) - v75) - 8)
        local v87 = (u75 and (((a30 - v73) - v76) - 4 - v75)) or (a30 - v73 - v75)
        u45.Position = fromOffset_upv_1(v73, v87)
        u45.Size = fromOffset_upv_1(v74, v75)
        u47.Label.TextSize = (a31 and 18) or 21
        u48.Position = fromOffset_upv_1(v73, (v87 + v75) + 4)
        u48.Size = fromOffset_upv_1(v74, v76)
        u48.TextSize = (a31 and 12) or 13
    end
    local u76 = nil
    local u77 = 0
    local u78 = nil
    local u79 = nil
    local u80 = function()
        --[[
          line: 1262
          upvalues:
            u70 (ref,  index: 1)
            stateOf (copy, index: 2)
            Economy_upv_1 (copy, index: 3)
            u76 (ref,  index: 4)
            u78 (ref,  index: 5)
            WeaponIcon_upv_1 (copy, index: 6)
            u14 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            Theme_upv_1 (copy, index: 9)
            u26 (copy, index: 10)
            WeaponInfo_upv_1 (copy, index: 11)
            a1 (copy, index: 12)
            u28 (copy, index: 13)
            u2 (copy, index: 14)
            u3 (copy, index: 15)
            Colors_upv_1 (copy, index: 16)
            MAX_LEVEL_upv_1 (copy, index: 17)
            Success_upv_1 (copy, index: 18)
            Gold_upv_1 (copy, index: 19)
            u12 (copy, index: 20)
            u13 (copy, index: 21)
            u9 (copy, index: 22)
            u10 (copy, index: 23)
            u25 (copy, index: 24)
            u19 (copy, index: 25)
            u21 (copy, index: 26)
            fromOffset_upv_1 (copy, index: 27)
            u22 (copy, index: 28)
            u23 (copy, index: 29)
            u24 (copy, index: 30)
            u20 (copy, index: 31)
            u31 (copy, index: 32)
            u32 (copy, index: 33)
            u30 (copy, index: 34)
            u34 (copy, index: 35)
            u39 (copy, index: 36)
            u35 (copy, index: 37)
            u42 (copy, index: 38)
            u40 (copy, index: 39)
            u41 (copy, index: 40)
            u36 (copy, index: 41)
            u37 (copy, index: 42)
            u38 (copy, index: 43)
            tbl_upv_3 (copy, index: 44)
            u44 (copy, index: 45)
            RankArt_upv_1 (copy, index: 46)
            u46 (copy, index: 47)
            u47 (copy, index: 48)
            u48 (copy, index: 49)
            u79 (ref,  index: 50)
            u4 (copy, index: 51)
            u75 (ref,  index: 52)
        ]]
        local v88 = u70
        if not v88 then
            return
        end
        local v89 = stateOf(v88)
        local v90 = Economy_upv_1.Level(v88)
        local v91, v92 = Economy_upv_1.Progress(v88)
        local v93 = Economy_upv_1.CategoryColor(v88)
        local v94 = v89 == "locked"
        local v95 = (u76 ~= nil) and (u76.id == u70)
        if u78 ~= u70 then
            u78 = u70
            WeaponIcon_upv_1.Set(u14, u70, {outline = true, spin = true, outlineTransparency = 0.5, outlineScale = 1.035, glow = false, outlineColor = v93:Lerp(Color3.new(1, 1, 1), 0.55)})
            UI_upv_1.Pop(u14, 0.85, Theme_upv_1.Tween.PopSmall)
        end
        WeaponIcon_upv_1.SetDim(u14, v94)
        u26.Text = string.upper(WeaponInfo_upv_1.Name(u70))
        local v96 = WeaponInfo_upv_1.Get(u70)
        local v97 = string.upper(((not v96) and "") or (WeaponInfo_upv_1.CATEGORY_SINGULAR[v96.category] or ""))
        if v94 then
            a1.Loc.Rich(u28, string.format("%s  <font color=\"%s\">\194\183  LOCKED</font>", v97, u2))
        elseif v89 == "max" then
            a1.Loc.Rich(u28, string.format("%s  <font color=\"%s\">\194\183  MAX LEVEL</font>", v97, u3))
        elseif v89 ~= "fixed" then
            local TextDim_2 = Colors_upv_1.TextDim
            a1.Loc.Rich(u28, string.format("%s  <font color=\"%s\">\194\183  LEVEL %d OF %d</font>", v97, string.format("#%02X%02X%02X", math.floor((TextDim_2.R * 255) + 0.5), math.floor((TextDim_2.G * 255) + 0.5), math.floor((TextDim_2.B * 255) + 0.5)), v90, MAX_LEVEL_upv_1))
        else
            a1.Loc.Rich(u28, string.format("%s  <font color=\"%s\">\194\183  NO LEVELS</font>", v97, u2))
        end
        local v98 = v89 == "fixed"
        local v99
        if v94 then
            v99 = Colors_upv_1.TextMuted
        elseif v89 == "ready" then
            v99 = Success_upv_1
        elseif v89 ~= "max" then
            v99 = v93
        else
            v99 = Gold_upv_1
        end
        u12.Color = ColorSequence.new(v99:Lerp(Colors_upv_1.Panel, 1 - ((v94 and 0.18) or 0.35)), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6))
        u13.ImageColor3 = v99
        u13.ImageTransparency = (v94 and 0.8) or 0.5
        u9.Color = ColorSequence.new(v99:Lerp(Colors_upv_1.Panel, 0.9), Colors_upv_1.PanelLo)
        local v100
        if v89 == "ready" then
            v100 = Success_upv_1
        elseif v89 ~= "max" then
            v100 = Colors_upv_1.Stroke
        else
            v100 = Gold_upv_1
        end
        u10.Color = v100
        local v101
        if v89 == "ready" or v89 == "max" then
            v101 = 0.55
        else
            v101 = 0.88
        end
        u10.Transparency = v101
        u25.Visible = v94
        u19.Visible = not v94
        if not (v95) then
            if v89 ~= "max" then
                u19.BackgroundColor3 = Colors_upv_1.Void
                u19.BackgroundTransparency = 0.2
                u21.Text = "LV"
                u21.TextSize = 14
                u21.TextColor3 = Colors_upv_1.TextDim
                u21.Size = fromOffset_upv_1(22, 34)
                u22.Visible = true
                u23.Text = tostring(v90)
                u23.Position = UDim2.new()
                u23.TextColor3 = Colors_upv_1.Text
                u24.Text = ""
                u19.Size = fromOffset_upv_1(((v90 >= 10) and 90) or 70, 34)
            else
                u19.BackgroundColor3 = Gold_upv_1
                u19.BackgroundTransparency = 0
                u21.Text = "MAX"
                u21.TextSize = 18
                u21.TextColor3 = Colors_upv_1.TextDark
                u21.Size = fromOffset_upv_1(52, 34)
                u22.Visible = false
                u19.Size = fromOffset_upv_1(76, 34)
            end
            local v102
            if v89 ~= "ready" then
                v102 = Colors_upv_1.Stroke
            else
                v102 = Success_upv_1
            end
            u20.Color = v102
            local v103
            if v89 ~= "ready" then
                v103 = 0.8
            else
                v103 = 0.2
            end
            u20.Transparency = v103
        end
        v99 = ((not (v92 > 0)) and 1) or (math.clamp(v91 / v92, 0, 1))
        if v89 == "max" then
            u31.Set(1, true)
            u31.SetColor(Gold_upv_1)
            u32.Text = "MAX"
            u30.Text = "MAX LEVEL"
            u30.TextColor3 = Gold_upv_1
        elseif v98 then
            u31.Set(0, true)
            u32.Text = "NO LEVELS"
            u30.Text = ""
        else
            local v105 = nil
            if not (v95) then
                u31.Set(v99)
                local SetColor_1 = u31.SetColor
                if v89 == "ready" then
                    v105 = Success_upv_1
                elseif v94 then
                    v105 = Colors_upv_1.AccentDark
                else
                    v105 = Colors_upv_1.Accent
                end
                SetColor_1(v105)
                u32.Text = string.format("%d / %d", v91, v92)
            end
            u30.Text = (v94 and "TO UNLOCK") or ("TO LEVEL " .. v90 + 1)
            if v89 ~= "ready" then
                v105 = Colors_upv_1.TextDim
            else
                v105 = Theme_upv_1.Lighten(Success_upv_1, 0.15)
            end
            u30.TextColor3 = v105
        end
        local v106 = Economy_upv_1.StatWord(u70) or "damage"
        u34.Text = v98 and "NO LEVEL BONUS" or string.upper(v106) .. " BONUS"
        local Loc_1 = a1.Loc
        local v108 = Loc_1.Pick(v106 .. " (bonus)", v106)
        u39.Text = v108
        u35.Visible = not v98
        u42.Visible = not v98
        v99 = (v94 and 0) or (Economy_upv_1.BonusPercent(v90))
        local v109 = Economy_upv_1.BonusPercent(math.min(MAX_LEVEL_upv_1, math.max(v90, 1) + 1))
        if not (v95) then
            u40(v99, true)
            u41(v109, true)
        end
        local v110
        if v94 then
            v110 = Colors_upv_1.TextMuted
        elseif v89 ~= "max" then
            v110 = Colors_upv_1.Text
        else
            v110 = Gold_upv_1
        end
        u36.TextColor3 = v110
        local v111 = false
        if v89 == "max" then
            v110 = v111
        else
            v110 = not v94
        end
        u37.Visible = v110
        local v112 = false
        if v89 ~= "max" then
            v112 = not v94
        end
        u38.Visible = v112
        if not (v95) then
            local v113 = nil
            local _ = nil
            local v114 = nil
            for key_1, value_8 in tbl_upv_3 do
                local v115 = key_1 <= v90
                if v115 then
                    if v89 ~= "max" then
                        v113 = Colors_upv_1.Accent
                    else
                        v113 = Gold_upv_1
                    end
                else
                    if key_1 ~= v90 + 1 or v89 ~= "ready" then
                        v113 = Colors_upv_1.Inset
                        value_8.BackgroundColor3 = v113
                        if v115 or key_1 == v90 + 1 and v89 == "ready" then
                            v113 = 0
                            v114.BackgroundTransparency = v113
                            continue
                        end
                        v113 = 0.1
                        v114.BackgroundTransparency = v113
                        continue
                    end
                    v113 = Success_upv_1
                end
                value_8.BackgroundColor3 = v113
                if v115 or key_1 == v90 + 1 and v89 == "ready" then
                    v113 = 0
                    v114.BackgroundTransparency = v113
                    continue
                end
                v113 = 0.1
                v114.BackgroundTransparency = v113
            end
        end
        local v116 = math.floor((Economy_upv_1.BONUS_PER_LEVEL * 100) + 0.5)
        if v98 then
            u44.Text = Loc_1.T("Nothing on this item scales with levels: it's the same for everyone, and it never drops once you own it.")
        elseif not (v94) or Economy_upv_1.RankAllows(u70) then
            if (v94) and (Economy_upv_1.MaxLevel(u70) <= 1) then
                u44.Text = Loc_1.T("Nothing on this item scales with levels: unlock it once and it's yours.")
            elseif v94 then
                u44.Text = Loc_1.T(string.format("Unlocks at level 1. Each level after that adds +%d%% %s, up to +%d%%.", v116, v108, Economy_upv_1.MaxBonusPercent()))
            elseif v89 == "max" then
                u44.Text = Loc_1.T(string.format("Maxed out: +%d%% %s for good. The cap may rise in a later update.", v99, v108))
            elseif v90 <= 1 then
                u44.Text = Loc_1.T(string.format("Level %d adds +%d%% %s.", v90 + 1, v116, v108))
            else
                u44.Text = Loc_1.T(string.format("Level %d adds another +%d%% %s (max +%d%%).", v90 + 1, v116, v108, Economy_upv_1.MaxBonusPercent()))
            end
        else
            v110 = RankArt_upv_1.Ranks.Get(Economy_upv_1.ItemRank(u70))
            u44.Text = Loc_1.T(string.format("Joins your drops at %s (%s trophies). Win matches to climb the Rank Road.", v110.name, UI_upv_1.FormatNumber(v110.trophies)))
        end
        local v117 = math.max(0, v92 - v91)
        u46.ImageTransparency = 1
        if not (v94) or Economy_upv_1.RankAllows(u70) then
            if v94 then
                local v118 = Economy_upv_1.ItemKey(u70)
                v91 = Economy_upv_1.CanBuy(v118)
                v110 = Economy_upv_1.Pending(v118)
                if v91 then
                    u47:SetStyle("Primary")
                    u47:SetEnabled(not v110)
                    local v114 = (v110 and "UNLOCKING\226\128\166") or (string.format("UNLOCK NOW   <font color=\"%s\">%s</font> %s", "#FFFFFF", Economy_upv_1.ROBUX, Economy_upv_1.PriceAmount(v118)))
                    u47:SetText(v114)
                    u48.Text = Loc_1.T(string.format("or find %d more shard%s in drops", v117, ((v117 ~= 1) and "s") or ""))
                else
                    u47:SetStyle("Dark")
                    u47:SetEnabled(false)
                    u47:SetText(string.format("FIND %d MORE SHARD%s", v117, ((v117 ~= 1) and "S") or ""))
                    u48.Text = Loc_1.T("Win matches to find shards")
                end
            elseif v89 == "max" or v98 then
                u47:SetStyle("Dark")
                u47:SetEnabled(false)
                u47:SetText((v98 and "NO UPGRADES") or "MAX LEVEL")
                u48.Text = Loc_1.T("It won't drop any more: shards go to your other items")
            elseif v89 ~= "ready" then
                u47:SetStyle("Dark")
                u47:SetEnabled(false)
                u47:SetText(string.format("NEED %d MORE SHARD%s", v117, ((v117 ~= 1) and "S") or ""))
                u48.Text = Loc_1.T("Win matches to find shards")
            else
                v110 = true
                if u79 ~= u70 then
                    v110 = Economy_upv_1.Upgrading(u70)
                end
                u47:SetStyle("Success")
                u47:SetEnabled(not v110)
                local v114
                if v110 then
                    v114 = "UPGRADING\226\128\166"
                else
                    v114 = string.format("UPGRADE TO LV %d", v90 + 1)
                end
                u47:SetText(v114)
                u48.Text = Loc_1.T(string.format("Spends %d shards  \194\183  <font color=\"%s\">%s</font>", v92, u4, Loc_1.T(Economy_upv_1.BonusText(u70, v90 + 1))))
            end
        else
            local v119 = Economy_upv_1.ItemRank(u70)
            u47:SetStyle("Dark")
            u47:SetEnabled(true)
            u47:SetText("UNLOCKS AT " .. string.upper(RankArt_upv_1.Ranks.Get(v119).name))
            u48.Text = Loc_1.T("See the Rank Road")
        end
        u48.Visible = u75
        if not v95 then
            return
        end
        u47:SetEnabled(false)
    end
    local function layoutWindow()
        --[[
          name: layoutWindow
          line: 1442
          upvalues:
            UI_upv_1 (copy, index: 1)
            u5 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            u6 (copy, index: 4)
            layoutPanel (copy, index: 5)
            u8 (copy, index: 6)
            u50 (ref,  index: 7)
            u49 (copy, index: 8)
            u51 (copy, index: 9)
            u52 (copy, index: 10)
            u56 (copy, index: 11)
            u57 (copy, index: 12)
            u58 (copy, index: 13)
            u55 (copy, index: 14)
            u53 (copy, index: 15)
            u54 (copy, index: 16)
        ]]
        local v120 = UI_upv_1.CanvasSize()
        local v121 = UI_upv_1.TopInset()
        local Compact_1 = UI_upv_1.Compact
        if Compact_1 then
            u5.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v120.X - 24, 340, 1180)), math.floor(math.clamp((v120.Y - v121) - 12, 300, 720)))
        else
            u5.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v120.X - 160, 1180, 1400)), math.floor(math.clamp((v120.Y - v121) - 40, 720, 940)))
        end
        u5.Subtitle.Visible = true
        u5.Subtitle.TextSize = (Compact_1 and 15) or 17
        u6.TextSize = (Compact_1 and 14) or 16
        local v122 = -(UI_upv_1.WindowCloseSize() + 34)
        u6.Position = UDim2.new(1, v122, 0, (Compact_1 and 18) or 22)
        local v123 = u5.Holder.Size.X.Offset - 44
        local v124 = (Compact_1 and 300) or (math.clamp(math.floor(v123 * 0.28), 330, 390))
        local v125 = (Compact_1 and 14) or 20
        layoutPanel(v124, (u5.Holder.Size.Y.Offset - 80) - 32, Compact_1)
        u8.Position = fromOffset_upv_1(0, 0)
        u50 = (v123 - v124) - v125
        u49.Position = fromOffset_upv_1(v124 + v125, 0)
        u49.Size = UDim2.new(0, u50, 1, 0)
        local v126 = u50 - 12
        u51.Size = UDim2.new(1, -12, 0, (Compact_1 and 92) or 104)
        local v127 = (Compact_1 and 64) or 76
        u52.Size = fromOffset_upv_1(v127, (Compact_1 and 64) or 76)
        local v128 = (Compact_1 and 104) or 122
        local v129 = (Compact_1 and 138) or 150
        local v130 = (Compact_1 and 152) or 166
        u56.Instance.Size = fromOffset_upv_1(v128, 46)
        u57.Instance.Size = fromOffset_upv_1(v129, 46)
        u58.Instance.Size = fromOffset_upv_1(v130, 46)
        local v131 = (v128 + v129) + v130 + 20
        u55.Size = fromOffset_upv_1(v131, 50)
        local v132 = ((Compact_1 and 64) or 76) + 28
        u53.Position = fromOffset_upv_1(v132, (Compact_1 and 12) or 18)
        u53.TextSize = (Compact_1 and 21) or 24
        u54.Position = fromOffset_upv_1(v132, (Compact_1 and 40) or 48)
        local v133 = math.max(160, ((v126 - v132) - v131) - 28)
        u54.Size = fromOffset_upv_1(v133, (Compact_1 and 44) or 42)
        u54.TextSize = (Compact_1 and 13) or 14
    end
    local function layoutGrid(a32)
        --[[
          name: layoutGrid
          line: 1483
          upvalues:
            u50 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_10 (copy, index: 3)
            u71 (ref,  index: 4)
            Economy_upv_1 (copy, index: 5)
            u51 (copy, index: 6)
            fromOffset_upv_1 (copy, index: 7)
            tbl_upv_4 (copy, index: 8)
            tbl_upv_5 (copy, index: 9)
            a1 (copy, index: 10)
            u2 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
            u49 (copy, index: 13)
        ]]
        local v134 = u50 - 12
        local v135 = math.clamp(math.floor((v134 + 12) / 162), 2, 7)
        local v136 = math.floor((v134 - ((v135 - 1) * 12)) / v135)
        local v137 = ((UI_upv_1.Compact) and 30) or 34
        local v138 = ((UI_upv_1.Compact) and 184) or 212
        local tbl_18 = {}
        tbl_18.owned = {}
        tbl_18.locked = {}
        local tbl_upv_19 = {}
        for key_2, value_9 in tbl_upv_10 do
            tbl_upv_19[value_9] = key_2
            u71(value_9)
            value_9.section = ((value_9.state ~= "locked") and "owned") or "locked"
            table.insert(tbl_18[value_9.section], value_9)
        end
        table.sort(
            tbl_18.owned,
            function(a33, a34)
                --[[
                  line: 1498
                  upvalues:
                    tbl_upv_19 (copy, index: 1)
                ]]
                local v139 = a33.state == "ready"
                if v139 == (a34.state == "ready") then
                    return tbl_upv_19[a33] < tbl_upv_19[a34]
                end
                return v139
            end
        )
        local function frac_1(a35)
            --[[
              name: frac
              line: 1505
              upvalues:
                Economy_upv_1 (copy, index: 1)
            ]]
            local v140, v141 = Economy_upv_1.Progress(a35.id)
            return v140 / math.max(v141, 1), v141
        end
        table.sort(
            tbl_18.locked,
            function(a36, a37)
                --[[
                  line: 1509
                  upvalues:
                    Economy_upv_1 (copy, index: 1)
                    tbl_upv_19 (copy, index: 2)
                ]]
                local v142, v143 = Economy_upv_1.Progress(a36.id)
                local v144 = v142 / math.max(v143, 1)
                local v145, v146 = Economy_upv_1.Progress(a37.id)
                local v147 = v145 / math.max(v146, 1)
                if v144 == v147 then
                    if v143 == v146 then
                        return tbl_upv_19[a36] < tbl_upv_19[a37]
                    end
                    return v143 < v146
                end
                return v147 < v144
            end
        )
        local v148 = 0
        local v149 = Economy_upv_1.DropsAllowed()
        u51.Visible = v149
        if v149 then
            u51.Position = fromOffset_upv_1(4, 4)
            v148 = u51.Size.Y.Offset + 14
        end
        for _, value_10 in tbl_upv_4 do
            v149 = tbl_18[value_10]
            local v150 = tbl_upv_5[value_10]
            v150.frame.Visible = #v149 > 0
            if not (#v149 > 0) then
                continue
            end
            a1.Loc.Rich(v150.title, string.format("%s  <font color=\"%s\">\194\183  %d</font>", ((value_10 ~= "owned") and "LOCKED") or "YOUR ITEMS", u2, #v149))
            v150.sub.TextSize = ((UI_upv_1.Compact) and 13) or 14
            v150.frame.Size = UDim2.new(1, -8, 0, v137)
            v150.frame.Position = fromOffset_upv_1(4, v148)
            v148 = v148 + v137
            for key_3, value_11 in v149 do
                value_11.y = v148 + (((key_3 - 1) // v135) * (v138 + 12))
                value_11.h = v138
                value_11.visible = true
                value_11.holder.Visible = true
                local v151 = fromOffset_upv_1(((key_3 - 1) % v135 * (v136 + 12)) + 4, value_11.y + 4)
                if (a32) and (value_11.shown) and value_11.holder.Position ~= v151 then
                    UI_upv_1.Tween(value_11.holder, Theme_upv_1.Tween.Smooth, {Position = v151})
                else
                    value_11.holder.Position = v151
                end
                value_11.holder.Size = fromOffset_upv_1(v136, v138)
                value_11.glow.Size = fromOffset_upv_1(math.floor(v136 * 1.05), 150)
                value_11.glow.Position = UDim2.new(0.5, 0, 0, math.floor((v138 - 88) / 2) + 6)
            end
            v148 = v148 + ((math.ceil(#v149 / v135) * (v138 + 12)) + 12)
        end
        for _, value_12 in tbl_upv_10 do
            value_12.shown = value_12.visible
        end
        u49.CanvasSize = fromOffset_upv_1(0, v148 + 8)
    end
    local function paintSummary()
        --[[
          name: paintSummary
          line: 1564
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            Economy_upv_1 (copy, index: 2)
            u2 (copy, index: 3)
            u4 (copy, index: 4)
            a1 (copy, index: 5)
            u6 (copy, index: 6)
        ]]
        local v152 = 0
        local v153 = 0
        for _, value_13 in WeaponInfo_upv_1.AllItems() do
            v152 = v152 + 1
            v153 = (Economy_upv_1.Owns(value_13.id) and (v153 + 1)) or v153
        end
        local v154 = Economy_upv_1.UpgradesReady()
        local v155 = string.format("%d / %d <font color=\"%s\">UNLOCKED</font>", v153, v152, u2)
        if v154 > 0 then
            v155 = v155 .. string.format("   <font color=\"%s\">\194\183   %d UPGRADE%s READY</font>", u4, v154, ((v154 ~= 1) and "S") or "")
        end
        a1.Loc.Rich(u6, v155)
    end
    local u81 = function(a38)
        --[[
          line: 1580
          upvalues:
            layoutGrid (copy, index: 1)
            u80 (ref,  index: 2)
            paintShop (copy, index: 3)
            paintSummary (copy, index: 4)
            queueVisible (copy, index: 5)
        ]]
        layoutGrid(a38)
        u80()
        paintShop()
        paintSummary()
        task.defer(queueVisible)
    end
    u72 = function(a39, a40)
        --[[
          line: 1595
          upvalues:
            tbl_upv_11 (copy, index: 1)
            u70 (ref,  index: 2)
            u71 (ref,  index: 3)
            u80 (ref,  index: 4)
            UI_upv_1 (copy, index: 5)
            u14 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
        ]]
        if not tbl_upv_11[a39] then
            return
        end
        local v156 = u70 and (tbl_upv_11[u70])
        u70 = a39
        if v156 then
            u71(v156)
        end
        u71(tbl_upv_11[a39])
        u80()
        if type(a40) == "table" and (a40.quiet) then
            return
        end
        UI_upv_1.Pop(u14, 0.9, Theme_upv_1.Tween.PopSmall)
    end
    local function flashCard(a41, a42)
        --[[
          name: flashCard
          line: 1589
          upvalues:
            Colors_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        a41.flash.BackgroundColor3 = a42 or (Colors_upv_1.Accent)
        a41.flash.BackgroundTransparency = 0.65
        local tbl_20 = {BackgroundTransparency = 1}
        UI_upv_1.Tween(a41.flash, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_20)
    end
    local function shardBurst(a43)
        --[[
          name: shardBurst
          line: 1612
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            u17 (copy, index: 4)
        ]]
        local v157 = ((UI_upv_1.Touch) and 9) or 14
        for n_2 = 1, v157 do
            local v158 = ((n_2 / v157) * math.pi) * 2 + math.random() * 0.4
            local v159 = 0.32 + math.random() * 0.22
            local v160 = math.random(12, 22)
            local Image_1 = UI_upv_1.Image
            local Shard_1 = UI_upv_1.Assets.Fx.Shard
            local tbl_21 = {ImageTransparency = 0.05, ImageColor3 = 0, Parent = 0, ZIndex = 7}
            tbl_21.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_21.Position = UDim2.fromScale(0.5, 0.52)
            tbl_21.Size = fromOffset_upv_1(v160, v160)
            tbl_21.Rotation = math.random(0, 360)
            local v161
            if n_2 % 3 ~= 0 then
                v161 = a43
            else
                v161 = Theme_upv_1.Lighten(a43, 0.25)
            end
            tbl_21.ImageColor3 = v161
            tbl_21.Parent = u17
            local u82 = Image_1(Shard_1, tbl_21)
            UI_upv_1.Tween(u82, TweenInfo.new(0.6 + (math.random() * 0.25), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.fromScale(0.5 + (math.cos(v158) * v159), 0.52 + ((math.sin(v158) * v159) * 0.9)), Rotation = u82.Rotation + math.random(-160, 160), Size = fromOffset_upv_1(v160 * 0.5, v160 * 0.5)})
            task.delay(
                1,
                function()
                    --[[
                      line: 1635
                      upvalues:
                        u82 (copy, index: 1)
                    ]]
                    u82:Destroy()
                end
            )
        end
    end
    local function levelUpMoment(a44, a45, a46)
        --[[
          name: levelUpMoment
          line: 1641
          upvalues:
            u77 (ref,  index: 1)
            u76 (ref,  index: 2)
            MAX_LEVEL_upv_1 (copy, index: 3)
            Gold_upv_1 (copy, index: 4)
            Success_upv_1 (copy, index: 5)
            u31 (copy, index: 6)
            u15 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u11 (copy, index: 9)
            u16 (copy, index: 10)
            fromOffset_upv_1 (copy, index: 11)
            shardBurst (copy, index: 12)
            u13 (copy, index: 13)
            u14 (copy, index: 14)
            Theme_upv_1 (copy, index: 15)
            a1 (copy, index: 16)
            u19 (copy, index: 17)
            Colors_upv_1 (copy, index: 18)
            u21 (copy, index: 19)
            u22 (copy, index: 20)
            u23 (copy, index: 21)
            u24 (copy, index: 22)
            u20 (copy, index: 23)
            u18 (copy, index: 24)
            Economy_upv_1 (copy, index: 25)
            u40 (copy, index: 26)
            u41 (copy, index: 27)
            u36 (copy, index: 28)
            tbl_upv_3 (copy, index: 29)
            u32 (copy, index: 30)
            tbl_upv_11 (copy, index: 31)
            flashCard (copy, index: 32)
            u81 (ref,  index: 33)
        ]]
        u77 = u77 + 1
        local u83 = u77
        u76 = {id = a44, token = u83}
        local u84 = MAX_LEVEL_upv_1 <= a46
        local v162
        if u84 then
            v162 = Gold_upv_1
        else
            v162 = Success_upv_1
        end
        u31.SetColor(Success_upv_1)
        u31.Set(1, false, TweenInfo.new(0.18, Enum.EasingStyle.Quad))
        u15.BackgroundColor3 = v162
        u15.BackgroundTransparency = 0.55
        local tbl_22 = {BackgroundTransparency = 1}
        UI_upv_1.Tween(u15, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_22)
        local Offset_1 = u11.Size.X.Offset
        u16.ImageColor3 = v162
        u16.Size = fromOffset_upv_1(60, 60)
        u16.ImageTransparency = 0.15
        UI_upv_1.Tween(u16, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1, Size = fromOffset_upv_1(Offset_1 * 1.4, Offset_1 * 1.4)})
        shardBurst(v162)
        u13.ImageColor3 = v162
        u13.ImageTransparency = 0.2
        local tbl_23 = {ImageTransparency = 0.5}
        UI_upv_1.Tween(u13, TweenInfo.new(0.9, Enum.EasingStyle.Quad), tbl_23)
        UI_upv_1.Pop(u14, 0.7, Theme_upv_1.Tween.Slam)
        a1.Sounds.Play("LevelUp")
        u19.BackgroundColor3 = Colors_upv_1.Void
        u19.BackgroundTransparency = 0.2
        u21.Text = "LV"
        u21.TextSize = 14
        u21.TextColor3 = Colors_upv_1.TextDim
        u21.Size = fromOffset_upv_1(22, 34)
        u22.Visible = true
        u19.Size = fromOffset_upv_1(70, 34)
        u23.Text = tostring(a45)
        u23.TextColor3 = Colors_upv_1.Text
        u23.Position = UDim2.new()
        u24.Text = tostring(a46)
        u24.TextColor3 = Gold_upv_1
        u24.Position = UDim2.fromScale(0, 1)
        u20.Color = Gold_upv_1
        u20.Transparency = 0
        task.delay(
            0.12,
            function()
                --[[
                  line: 1682
                  upvalues:
                    u83 (copy, index: 1)
                    u77 (ref,  index: 2)
                    a1 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u23 (copy, index: 5)
                    u24 (copy, index: 6)
                    u19 (copy, index: 7)
                    Theme_upv_1 (copy, index: 8)
                ]]
                if u83 ~= u77 then
                    return
                end
                a1.Sounds.Play("XP_Tick")
                local v163 = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                UI_upv_1.Tween(u23, v163, {Position = UDim2.fromScale(0, -1)})
                UI_upv_1.Tween(u24, v163, {Position = UDim2.new()})
                task.delay(
                    0.3,
                    function()
                        --[[
                          line: 1690
                          upvalues:
                            u83 (copy, index: 1)
                            u77 (ref,  index: 2)
                            UI_upv_1 (copy, index: 3)
                            u19 (copy, index: 4)
                            Theme_upv_1 (copy, index: 5)
                        ]]
                        if u83 ~= u77 then
                            return
                        end
                        UI_upv_1.Pop(u19, 1.45, Theme_upv_1.Tween.Slam)
                    end
                )
            end
        )
        u18.Text = (u84 and "MAX LEVEL") or ("LEVEL " .. a46)
        local v164
        if u84 then
            v164 = Gold_upv_1
        else
            v164 = Theme_upv_1.Lighten(Success_upv_1, 0.2)
        end
        u18.TextColor3 = v164
        u18.Visible = true
        UI_upv_1.Unfade(u18)
        UI_upv_1.Pop(u18, 1.9, Theme_upv_1.Tween.Slam)
        local u85 = Economy_upv_1.BonusPercent(a46)
        local u86 = Economy_upv_1.BonusPercent(math.min(MAX_LEVEL_upv_1, a46 + 1))
        task.delay(
            0.25,
            function()
                --[[
                  line: 1705
                  upvalues:
                    u83 (copy, index: 1)
                    u77 (ref,  index: 2)
                    u40 (copy, index: 3)
                    u85 (copy, index: 4)
                    u41 (copy, index: 5)
                    u86 (copy, index: 6)
                    UI_upv_1 (copy, index: 7)
                    u36 (copy, index: 8)
                    tbl_upv_3 (copy, index: 9)
                    a46 (copy, index: 10)
                    u84 (copy, index: 11)
                    Gold_upv_1 (copy, index: 12)
                    Colors_upv_1 (copy, index: 13)
                    Theme_upv_1 (copy, index: 14)
                ]]
                if u83 == u77 then
                    u40(u85)
                    u41(u86)
                    UI_upv_1.Bump(u36, 0.2)
                    local v165 = nil
                    for key_4, value_14 in tbl_upv_3 do
                        if key_4 ~= a46 then
                            continue
                        end
                        if u84 then
                            v165 = Gold_upv_1
                        else
                            v165 = Colors_upv_1.Accent
                        end
                        value_14.BackgroundColor3 = v165
                        value_14.BackgroundTransparency = 0
                        UI_upv_1.Pop(value_14, 1.8, Theme_upv_1.Tween.Slam)
                    end
                end
            end
        )
        task.delay(
            0.35,
            function()
                --[[
                  line: 1720
                  upvalues:
                    u83 (copy, index: 1)
                    u77 (ref,  index: 2)
                    Economy_upv_1 (copy, index: 3)
                    a44 (copy, index: 4)
                    u31 (copy, index: 5)
                    u84 (copy, index: 6)
                    Gold_upv_1 (copy, index: 7)
                    Colors_upv_1 (copy, index: 8)
                    u32 (copy, index: 9)
                ]]
                if u83 ~= u77 then
                    return
                end
                local v166, v167 = Economy_upv_1.Progress(a44)
                u31.Set(0, true)
                local SetColor_2 = u31.SetColor
                local v168
                if u84 then
                    v168 = Gold_upv_1
                else
                    v168 = Colors_upv_1.Accent
                end
                SetColor_2(v168)
                u31.Set(((v167 > 0) and (v166 / v167)) or 1, false, TweenInfo.new(0.5, Enum.EasingStyle.Quint))
                u32.Text = u84 and "MAX" or string.format("%d / %d", v166, v167)
            end
        )
        local v170 = tbl_upv_11[a44]
        if v170 then
            flashCard(v170, v162)
            UI_upv_1.Pop(v170.icon, 0.8, Theme_upv_1.Tween.PopSmall)
        end
        task.delay(
            1.15,
            function()
                --[[
                  line: 1735
                  upvalues:
                    u83 (copy, index: 1)
                    u77 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    u18 (copy, index: 4)
                ]]
                if u83 ~= u77 then
                    return
                end
                UI_upv_1.FadeOut(u18, TweenInfo.new(0.3))
            end
        )
        task.delay(
            1.5,
            function()
                --[[
                  line: 1741
                  upvalues:
                    u83 (copy, index: 1)
                    u77 (ref,  index: 2)
                    u76 (ref,  index: 3)
                    u18 (copy, index: 4)
                    UI_upv_1 (copy, index: 5)
                    u81 (ref,  index: 6)
                ]]
                if u83 ~= u77 then
                    return
                end
                u76 = nil
                u18.Visible = false
                UI_upv_1.Unfade(u18)
                u81(true)
            end
        )
    end
    u73 = function(a47, a48)
        --[[
          line: 1753
          upvalues:
            u79 (ref,  index: 1)
            Economy_upv_1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            u76 (ref,  index: 5)
            u77 (ref,  index: 6)
            u80 (ref,  index: 7)
            UI_upv_1 (copy, index: 8)
            u70 (ref,  index: 9)
            u72 (ref,  index: 10)
            levelUpMoment (copy, index: 11)
            u45 (copy, index: 12)
            u81 (ref,  index: 13)
        ]]
        if (u79) or not Economy_upv_1.CanUpgrade(a47) then
            return
        end
        if State_upv_1.InMatch() then
            a1.Toast("Upgrade in the lobby", "warning")
        else
            u79 = a47
            local u87 = Economy_upv_1.Level(a47)
            u76 = {id = a47, token = u77}
            u80()
            task.spawn(
                function()
                    --[[
                      line: 1767
                      upvalues:
                        Economy_upv_1 (copy, index: 1)
                        a47 (copy, index: 2)
                        UI_upv_1 (copy, index: 3)
                        a48 (copy, index: 4)
                        u79 (ref,  index: 5)
                        u70 (ref,  index: 6)
                        u72 (ref,  index: 7)
                        levelUpMoment (copy, index: 8)
                        u87 (copy, index: 9)
                        u76 (ref,  index: 10)
                        u45 (copy, index: 11)
                        u81 (ref,  index: 12)
                        u80 (ref,  index: 13)
                    ]]
                    local v171, v172 = Economy_upv_1.Upgrade(a47, "collection", UI_upv_1.PressKind(a48))
                    u79 = nil
                    if v171 then
                        if u70 ~= a47 then
                            u72(a47, {quiet = true})
                        end
                        levelUpMoment(a47, u87, v172 or (u87 + 1))
                    else
                        u76 = nil
                        UI_upv_1.Shake(u45, 6)
                        u81(true)
                    end
                    u80()
                end
            )
        end
    end
    u47.Activated:Connect(
        function(a49)
            --[[
              line: 1783
              upvalues:
                u70 (ref,  index: 1)
                stateOf (copy, index: 2)
                u73 (ref,  index: 3)
                Economy_upv_1 (copy, index: 4)
                a1 (copy, index: 5)
                u80 (ref,  index: 6)
            ]]
            local v173 = u70
            if not v173 then
                return
            end
            local v174 = stateOf(v173)
            if v174 ~= "ready" then
                if v174 == "locked" and not (Economy_upv_1.RankAllows(v173)) then
                    a1.Sounds.Play("Click")
                    if a1.RankRoad then
                        a1.RankRoad.Focus(Economy_upv_1.ItemRank(v173))
                    else
                        a1.EnsureScreen("RankRoad")
                        if a1.RankRoad then
                            a1.RankRoad.Focus(Economy_upv_1.ItemRank(v173))
                        end
                    end
                    a1.MenuManager.Open("Ranks")
                    return
                end
                if v174 == "locked" then
                    local v175 = Economy_upv_1.ItemKey(u70)
                    if not Economy_upv_1.CanBuy(v175) then
                        return
                    end
                    Economy_upv_1.Buy(v175)
                    u80()
                end
            else
                u73(v173, a49)
            end
        end
    )
    RunService_upv_1.Heartbeat:Connect(
        function()
            --[[
              line: 1812
              upvalues:
                u5 (copy, index: 1)
                tbl_upv_10 (copy, index: 2)
                u70 (ref,  index: 3)
                stateOf (copy, index: 4)
                u76 (ref,  index: 5)
                u79 (ref,  index: 6)
                u43 (copy, index: 7)
                u46 (copy, index: 8)
            ]]
            if not u5.IsOpen then
                return
            end
            local v176 = math.sin(os.clock() * 4.2) * 0.5 + 0.5
            for _, value_15 in tbl_upv_10 do
                if value_15.state ~= "ready" or not (value_15.visible) then
                    continue
                end
                if u70 ~= value_15.id then
                    value_15.stroke.Transparency = (v176 * 0.45) + 0.1
                end
                value_15.upScale.Scale = (v176 * 0.035) + 1
                value_15.upGlow.ImageTransparency = ((1 - v176) * 0.35) + 0.45
            end
            local v177 = u70
            if v177 and stateOf(v177) == "ready" and not u76 and u79 == nil then
                u43.Scale = (v176 * 0.025) + 1
                u46.ImageTransparency = ((1 - v176) * 0.4) + 0.45
            elseif u43.Scale ~= 1 then
                u43.Scale = 1
                u46.ImageTransparency = 1
            end
        end
    )
    local u88 = false
    local tbl_upv_24 = {}
    local function stepAside(a50, a51)
        --[[
          name: stepAside
          line: 1840
          upvalues:
            tbl_upv_24 (copy, index: 1)
            u5 (copy, index: 2)
            u88 (ref,  index: 3)
            u78 (ref,  index: 4)
            u81 (ref,  index: 5)
            u70 (ref,  index: 6)
            tbl_upv_11 (copy, index: 7)
            flashCard (copy, index: 8)
        ]]
        local v178 = next(tbl_upv_24) ~= nil
        tbl_upv_24[a50] = (a51 and true) or nil
        local v179 = next(tbl_upv_24) ~= nil
        if v179 == v178 then
            return
        end
        if not v179 or not u5.IsOpen then
            if not (v179) then
                u5.Holder.Visible = true
                if u5.IsOpen and u88 then
                    u78 = nil
                    u81(true)
                    local v180 = u70 and (tbl_upv_11[u70])
                    if v180 then
                        flashCard(v180)
                    end
                end
            end
            return
        end
        u5.Holder.Visible = false
    end
    Economy_upv_1.Changed:Connect(
        function()
            --[[
              line: 1861
              upvalues:
                u5 (copy, index: 1)
                u88 (ref,  index: 2)
                u76 (ref,  index: 3)
                u81 (ref,  index: 4)
                paintShop (copy, index: 5)
            ]]
            if u5.IsOpen and u88 and not (u76) then
                u81(true)
                return
            end
            if not u5.IsOpen or not u88 then
                return
            end
            paintShop()
        end
    )
    UI_upv_1.Every(
        u5.Root,
        1,
        function()
            --[[
              line: 1869
              upvalues:
                u5 (copy, index: 1)
                u88 (ref,  index: 2)
                Economy_upv_1 (copy, index: 3)
                paintShop (copy, index: 4)
            ]]
            if not u5.IsOpen or not u88 or not Economy_upv_1.OfferLeft() then
                return
            end
            paintShop()
        end
    )
    Economy_upv_1.CelebrationChanged:Connect(
        function(a52)
            --[[
              line: 1876
              upvalues:
                stepAside (copy, index: 1)
            ]]
            stepAside("unlock", a52)
        end
    )
    Economy_upv_1.RevealChanged:Connect(
        function(a53)
            --[[
              line: 1879
              upvalues:
                stepAside (copy, index: 1)
            ]]
            stepAside("reveal", a53)
        end
    )
    Economy_upv_1.Event:Connect(
        function(a54, a55)
            --[[
              line: 1882
              upvalues:
                u5 (copy, index: 1)
                tbl_upv_11 (copy, index: 2)
                u72 (ref,  index: 3)
            ]]
            if a54 ~= "Unlocked" or type(a55.item) ~= "string" or not u5.IsOpen or not tbl_upv_11[a55.item] then
                return
            end
            u72(a55.item, {quiet = true})
        end
    )
    local function isGamepad()
        --[[
          name: isGamepad
          line: 1888
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        return UI_upv_1.Gamepad
    end
    local function firstTarget()
        --[[
          name: firstTarget
          line: 1891
          upvalues:
            tbl_upv_10 (copy, index: 1)
        ]]
        local v181 = nil
        for _, value_16 in tbl_upv_10 do
            if not (value_16.visible) then
                continue
            end
            if not (v181) or value_16.y < v181.y or value_16.y == v181.y and value_16.holder.Position.X.Offset < v181.holder.Position.X.Offset then
                v181 = value_16
            end
        end
        return (v181 and (v181.holder)) or nil
    end
    local function defaultSelection()
        --[[
          name: defaultSelection
          line: 1901
          upvalues:
            Economy_upv_1 (copy, index: 1)
            tbl_upv_11 (copy, index: 2)
            firstTarget (copy, index: 3)
        ]]
        local v182 = Economy_upv_1.ReadyList()
        if v182[1] then
            return v182[1]
        end
        local v183 = Economy_upv_1.Spotlight()
        if v183 and tbl_upv_11[v183] then
            return v183
        end
        local v184 = firstTarget()
        return (v184 and (v184.Name)) or nil
    end
    local tbl_25 = {}
    function tbl_25.open(a56)
        --[[
          name: open
          line: 1915
          upvalues:
            layoutWindow (copy, index: 1)
            u88 (ref,  index: 2)
            WeaponInfo_upv_1 (copy, index: 3)
            makeCard (copy, index: 4)
            tbl_upv_10 (copy, index: 5)
            tbl_upv_11 (copy, index: 6)
            u78 (ref,  index: 7)
            u61 (copy, index: 8)
            u1 (ref,  index: 9)
            TextChatService_upv_1 (copy, index: 10)
            StarterGui_upv_1 (copy, index: 11)
            u5 (copy, index: 12)
            Economy_upv_1 (copy, index: 13)
            openOdds (copy, index: 14)
            layoutGrid (copy, index: 15)
            u70 (ref,  index: 16)
            firstTarget (copy, index: 17)
            u81 (ref,  index: 18)
            u49 (copy, index: 19)
            u50 (ref,  index: 20)
            UI_upv_1 (copy, index: 21)
            flashCard (copy, index: 22)
            queueVisible (copy, index: 23)
            fromOffset_upv_1 (copy, index: 24)
            GuiService_upv_1 (copy, index: 25)
        ]]
        layoutWindow()
        if not (u88) then
            u88 = true
            for _, value_17 in WeaponInfo_upv_1.AllItems() do
                local v185 = makeCard(value_17)
                table.insert(tbl_upv_10, v185)
                tbl_upv_11[value_17.id] = v185
            end
        end
        u78 = nil
        u61.Visible = false
        local u89
        if not (u1) then
            u89 = {}
            pcall(
                function()
                    --[[
                      line: 46
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        u89 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v186, v187 = nil, nil
                    if TextChatService_upv_1.ChatVersion ~= Enum.ChatVersion.TextChatService then
                        u89.core = StarterGui_upv_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                        StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                    else
                        v186 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                        v187 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                        if v186 then
                            u89.window = v186.Enabled
                            v186.Enabled = false
                        end
                        if not v187 then
                            return
                        end
                        u89.bar = v187.Enabled
                        v187.Enabled = false
                    end
                end
            )
            u1 = u89
        end
        u5:Open()
        if type(a56) == "table" and type(a56.focus) == "string" then
            u89 = tbl_upv_11[a56.focus] and a56.focus or nil
        else
            u89 = nil
        end
        if type(a56) == "table" and a56.odds == true and Economy_upv_1.DropsAllowed() then
            task.delay(0.15, openOdds)
        end
        task.defer(
            function()
                --[[
                  line: 1933
                  upvalues:
                    tbl_upv_10 (copy, index: 1)
                    layoutGrid (copy, index: 2)
                    u70 (ref,  index: 3)
                    u89 (copy, index: 4)
                    Economy_upv_1 (copy, index: 5)
                    tbl_upv_11 (copy, index: 6)
                    firstTarget (copy, index: 7)
                    u81 (ref,  index: 8)
                    u49 (copy, index: 9)
                    u50 (ref,  index: 10)
                    UI_upv_1 (copy, index: 11)
                    flashCard (copy, index: 12)
                    queueVisible (copy, index: 13)
                    fromOffset_upv_1 (copy, index: 14)
                    GuiService_upv_1 (copy, index: 15)
                ]]
                for _, value_18 in tbl_upv_10 do
                    value_18.shown = false
                end
                layoutGrid(false)
                local v188 = u89
                if not (v188) then
                    if Economy_upv_1.UpgradesReady() > 0 then
                        v188 = nil
                    else
                        v188 = u70
                    end
                    local v189 = nil
                    if not (v188) then
                        v189 = Economy_upv_1.ReadyList()
                        if v189[1] then
                            v188 = v189[1]
                        else
                            v189 = Economy_upv_1.Spotlight()
                            if (v189) and (tbl_upv_11[v189]) then
                                v188 = v189
                            else
                                local v190 = firstTarget()
                                v188 = (v190 and (v190.Name)) or nil
                            end
                        end
                    end
                end
                u70 = v188
                u81(false)
                local u90 = (u70 and (tbl_upv_11[u70])) or nil
                local v191 = 0
                if u90 and u89 then
                    local v192 = math.max(u49.AbsoluteSize.X / math.max(u50, 1), 0.01)
                    local v193 = math.max(0, u49.AbsoluteCanvasSize.Y - u49.AbsoluteWindowSize.Y)
                    local v194 = math.min(math.max(0, (u90.y - (((UI_upv_1.Compact) and 30) or 34)) - 4) * v192, v193)
                    task.delay(
                        0.25,
                        function()
                            --[[
                              line: 1949
                              upvalues:
                                flashCard (copy, index: 1)
                                u90 (copy, index: 2)
                            ]]
                            flashCard(u90)
                        end
                    )
                    v191 = v194
                end
                u49.CanvasPosition = Vector2.new(0, v191)
                queueVisible()
                v191 = 0
                for _, value_19 in tbl_upv_10 do
                    if not (value_19.visible) then
                        continue
                    end
                    if value_19.y < 520 then
                        value_19.inner.Position = fromOffset_upv_1(0, 14)
                        UI_upv_1.Tween(value_19.inner, TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, math.min(v191 * 0.018, 0.2)), {Position = UDim2.new()})
                        v191 = v191 + 1
                    end
                end
                if UI_upv_1.Gamepad then
                    local v196
                    if u90 then
                        v196 = u90.holder
                    else
                        v196 = firstTarget()
                    end
                    GuiService_upv_1.SelectedObject = v196
                end
            end
        )
    end
    function tbl_25.close(a57)
        --[[
          name: close
          line: 1968
          upvalues:
            u1 (ref,  index: 1)
            TextChatService_upv_1 (copy, index: 2)
            StarterGui_upv_1 (copy, index: 3)
            u61 (copy, index: 4)
            GuiService_upv_1 (copy, index: 5)
            u5 (copy, index: 6)
        ]]
        local u91 = u1
        if u91 then
            u1 = nil
            pcall(
                function()
                    --[[
                      line: 71
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        u91 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v197 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v198 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v197 and u91.window ~= nil then
                        v197.Enabled = u91.window
                    end
                    if v198 and u91.bar ~= nil then
                        v198.Enabled = u91.bar
                    end
                    if u91.core == nil then
                        return
                    end
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, u91.core)
                end
            )
        end
        u61.Visible = false
        local SelectedObject_2 = GuiService_upv_1.SelectedObject
        if SelectedObject_2 then
            local v199 = SelectedObject_2:IsDescendantOf(u5.Root)
            if v199 then
                GuiService_upv_1.SelectedObject = nil
            end
        end
        u5:Close(a57)
    end
    function tbl_25.back()
        --[[
          name: back
          line: 1978
          upvalues:
            u61 (copy, index: 1)
            GuiService_upv_1 (copy, index: 2)
            u56 (copy, index: 3)
        ]]
        if u61.Visible then
            local v200 = nil
            if u61.Visible then
                u61.Visible = false
                v200 = GuiService_upv_1.SelectedObject
                if v200 and v200:IsDescendantOf(u61) then
                    GuiService_upv_1.SelectedObject = u56.Instance
                end
            end
            return true
        end
        return false
    end
    a1.MenuManager.Register("Collection", tbl_25)
    u5.Closed:Connect(restoreChat)
    State_upv_1.PlayerStateChanged:Connect(
        function(a58)
            --[[
              line: 1987
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a58 ~= "Match" or not a1.MenuManager.IsOpen("Collection") then
                return
            end
            a1.MenuManager.Close("Collection", true)
        end
    )
    local function relayout()
        --[[
          name: relayout
          line: 1992
          upvalues:
            u5 (copy, index: 1)
            layoutWindow (copy, index: 2)
            u78 (ref,  index: 3)
            u81 (ref,  index: 4)
        ]]
        if not u5.IsOpen then
            return
        end
        layoutWindow()
        u5.Refit()
        u78 = nil
        task.defer(u81)
    end
    UI_upv_1.LayoutChanged:Connect(relayout)
    UI_upv_1.OnResize(relayout)
    a1.Debug.collection = function(a59, a60, a61, a62)
        --[[
          line: 2007
          upvalues:
            u70 (ref,  index: 1)
            a1 (copy, index: 2)
            u72 (ref,  index: 3)
            u47 (copy, index: 4)
            Economy_upv_1 (copy, index: 5)
            paintShop (copy, index: 6)
            openOdds (copy, index: 7)
            u61 (copy, index: 8)
            GuiService_upv_1 (copy, index: 9)
            u56 (copy, index: 10)
            u49 (copy, index: 11)
            tbl_upv_11 (copy, index: 12)
            firstTarget (copy, index: 13)
            levelUpMoment (copy, index: 14)
            tbl_upv_10 (copy, index: 15)
            u5 (copy, index: 16)
            u51 (copy, index: 17)
            u65 (copy, index: 18)
            u76 (ref,  index: 19)
            u50 (ref,  index: 20)
        ]]
        local v201
        if type(a60) ~= "string" then
            v201 = u70
        else
            v201 = a60
        end
        if a59 == "open" then
            local Open_1 = a1.MenuManager.Open
            local v202
            if type(a60) ~= "string" then
                v202 = nil
            else
                v202 = {}
                v202.focus = a60
            end
            Open_1("Collection", v202)
        elseif a59 == "select" and type(a60) == "string" then
            u72(a60)
        elseif a59 == "upgrade" and (v201) then
            if u70 ~= v201 then
                u72(v201, {quiet = true})
            end
            u47.Activated:Fire()
        elseif a59 == "unlock" and (v201) then
            if u70 ~= v201 then
                u72(v201, {quiet = true})
            end
            u47.Activated:Fire()
        elseif a59 == "buy" then
            local v203 = ((a60 ~= 5) and 1) or 5
            if Economy_upv_1.DropsAllowed() then
                Economy_upv_1.Buy(Economy_upv_1.DropKey(v203))
                paintShop()
            end
        elseif a59 == "odds" then
            openOdds()
        elseif a59 == "closeOdds" then
            local v204 = nil
            if u61.Visible then
                u61.Visible = false
                v204 = GuiService_upv_1.SelectedObject
                if v204 and v204:IsDescendantOf(u61) then
                    GuiService_upv_1.SelectedObject = u56.Instance
                end
            end
        elseif a59 == "scroll" and type(a60) == "number" then
            u49.CanvasPosition = Vector2.new(0, a60)
        elseif a59 == "gamepad" then
            local v205 = ((u70 and (tbl_upv_11[u70])) and (tbl_upv_11[u70].holder)) or (firstTarget())
            GuiService_upv_1.SelectedObject = v205
        elseif a59 == "mock" then
            local SetMock_1 = Economy_upv_1.SetMock
            local v205
            if a60 ~= false then
                v205 = a60
            else
                v205 = nil
            end
            SetMock_1(v205)
        elseif a59 == "reveal" then
            Economy_upv_1.SetRevealShowing(a60 == true)
        elseif a59 == "levelup" and type(a60) == "string" then
            if u70 ~= a60 then
                u72(a60, {quiet = true})
            end
            levelUpMoment(a60, tonumber(a61) or 1, tonumber(a62) or 2)
        end
        local v206 = 0
        local v207 = 0
        local tbl_27 = {locked = 0, max = 0, owned = 0, ready = 0}
        for _, value_20 in tbl_upv_10 do
            v206 = ((value_20.rendered) and (v206 + 1)) or v206
            tbl_27[value_20.state] = (tbl_27[value_20.state] or 0) + 1
        end
        for _, value_21 in u5.Root:GetDescendants() do
            v207 = (value_21:IsA("ViewportFrame") and (v207 + 1)) or v207
        end
        local v208 = u70
        if v208 then
            Economy_upv_1.Progress(v208)
        end
        local tbl_28 = {cards = 0, action = 0, progress = 0, oddsRows = 0, gamepadSelected = 0, grid = 0, shop = 0, mock = 0, locked = 0, ready = 0, odds = 0, max = 0, viewports = 0, canvas = 0, rendered = 0, animating = 0, owned = 0, actionEnabled = 0, level = 0}
        tbl_28.open = u5.IsOpen
        tbl_28.selected = u70 or false
        tbl_28.level = v208 and Economy_upv_1.Level(u70) or false
        tbl_28.progress = v208 and string.format("%d/%d %s", 0, 0, "?") or false
        tbl_28.action = u47.Label.Text
        tbl_28.actionEnabled = u47.Enabled
        tbl_28.cards = #tbl_upv_10
        tbl_28.rendered = v206
        tbl_28.viewports = v207
        tbl_28.locked = tbl_27.locked
        tbl_28.owned = tbl_27.owned
        tbl_28.ready = tbl_27.ready
        tbl_28.max = tbl_27.max
        tbl_28.shop = u51.Visible
        tbl_28.odds = u61.Visible
        tbl_28.oddsRows = #u65:GetChildren()
        tbl_28.animating = u76 ~= nil
        tbl_28.grid = string.format("%dx%d", u50, math.floor(u49.AbsoluteWindowSize.Y / math.max(u49.AbsoluteSize.X / math.max(u50, 1), 0.01)))
        tbl_28.canvas = math.floor(u49.CanvasSize.Y.Offset)
        local v211
        if GuiService_upv_1.SelectedObject then
            v211 = GuiService_upv_1.SelectedObject:GetFullName()
        else
            v211 = false
        end
        tbl_28.gamepadSelected = v211
        tbl_28.mock = Economy_upv_1.Mock ~= nil
        return tbl_28
    end
end
return tbl_1