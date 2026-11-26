local runService = game:GetService("RunService")
local textChatService = game:GetService("TextChatService")
local starterGui = game:GetService("StarterGui")
local guiService = game:GetService("GuiService")
local Unlocks = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Unlocks"))
local RankArt = require(script.Parent.Parent.RankArt)
local v7 = {}
local v8 = nil

local function hideChat()
    --[[
      name: hideChat
      line: 41
      upvalues:
        v8 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    if v8 then
        return
    end

    local v10 = {}

    pcall(
        function()
            --[[
              line: 46
              upvalues:
                textChatService (copy, index: 1)
                v10 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            if textChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then
                v10.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
            else
                local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                if chatWindowConfiguration then
                    v10.window = chatWindowConfiguration.Enabled
                    chatWindowConfiguration.Enabled = false
                end

                if chatInputBarConfiguration then
                    v10.bar = chatInputBarConfiguration.Enabled
                    chatInputBarConfiguration.Enabled = false
                end
            end
        end
    )

    v8 = v10
end

local function restoreChat()
    --[[
      name: restoreChat
      line: 65
      upvalues:
        v8 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    local v14 = v8
    if not v14 then
        return
    end

    v8 = nil

    pcall(
        function()
            --[[
              line: 71
              upvalues:
                textChatService (copy, index: 1)
                v14 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration and v14.window ~= nil then
                chatWindowConfiguration.Enabled = v14.window
            end

            if chatInputBarConfiguration and v14.bar ~= nil then
                chatInputBarConfiguration.Enabled = v14.bar
            end

            if v14.core ~= nil then
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v14.core)
            end
        end
    )
end

local function hex(a18)
    --[[
      name: hex
      line: 86
    ]]
    return string.format("#%02X%02X%02X", math.floor((a18.R * 255) + 0.5), math.floor((a18.G * 255) + 0.5), (math.floor((a18.B * 255) + 0.5)))
end

function v7.Init(a19)
    --[[
      name: Init
      line: 90
      upvalues:
        Unlocks (copy, index: 1)
        guiService (copy, index: 2)
        RankArt (copy, index: 3)
        runService (copy, index: 4)
        v8 (ref,  index: 5)
        textChatService (copy, index: 6)
        starterGui (copy, index: 7)
        restoreChat (copy, index: 8)
    ]]
    local ui = a19.UI
    local theme = a19.Theme
    local state = a19.State
    local weaponInfo = a19.WeaponInfo
    local weaponIcon = a19.WeaponIcon
    local economy = a19.Economy
    local colors = theme.Colors
    local fonts = theme.Fonts
    local udim2FromOffset = UDim2.fromOffset
    local maxLevel = economy.MAX_LEVEL
    local success = colors.Success
    local gold = colors.Gold
    local textMuted = colors.TextMuted
    local formattedText = string.format("#%02X%02X%02X", math.floor((textMuted.R * 255) + 0.5), math.floor((textMuted.G * 255) + 0.5), (math.floor((textMuted.B * 255) + 0.5)))
    local v34 = theme.Lighten(success, 0.15)
    local formattedText2 = string.format("#%02X%02X%02X", math.floor((v34.R * 255) + 0.5), math.floor((v34.G * 255) + 0.5), (math.floor((v34.B * 255) + 0.5)))
    v34 = string.format("#%02X%02X%02X", math.floor((gold.R * 255) + 0.5), math.floor((gold.G * 255) + 0.5), (math.floor((gold.B * 255) + 0.5)))

    do
        local function catOf(a37)
            --[[
              name: catOf
              line: 104
              upvalues:
                economy (copy, index: 1)
            ]]
            return economy.CategoryColor(a37)
        end
    end

    do
        local function catWord(a39)
            --[[
              name: catWord
              line: 107
              upvalues:
                weaponInfo (copy, index: 1)
            ]]
            local text
            local v41 = weaponInfo.Get(a39)
            local stringUpper = string.upper

            if v41 then
                text = weaponInfo.CATEGORY_SINGULAR[v41.category] or ""
            else
                text = ""
            end

            return stringUpper(text)
        end
    end

    do
        local function tint(startValue, a45)
            --[[
              name: tint
              line: 111
              upvalues:
                colors (copy, index: 1)
            ]]
            return ColorSequence.new(startValue:Lerp(colors.Panel, 1 - a45), colors.PanelHi:Lerp(colors.Panel, 0.6))
        end
    end

    local function pct(a47: number)
        --[[
          name: pct
          line: 114
        ]]
        return string.format("+%d%%", a47)
    end

    local function stateOf(a49)
        --[[
          name: stateOf
          line: 118
          upvalues:
            economy (copy, index: 1)
        ]]
        if economy.Level(a49) <= 0 then
            return "locked"
        end

        local _, _, v52 = economy.Progress(a49)

        if v52 ~= "max" then
            if economy.CanUpgrade(a49) then
                return "ready"
            end

            return "owned"
        end

        if economy.MaxLevel(a49) <= 1 then
            return "fixed"
        end

        return "max"
    end

    local v53 = ui.Window(
        {
            Name = "Collection",
            Title = "COLLECTION",
            HeaderHeight = 80,
            OpenSound = "Armory_Open",
            Subtitle = string.format("Win matches to find shards  ·  Shards unlock items and upgrade them (max +%d%%)", economy.MaxBonusPercent()),
            Size = UDim2.fromOffset(1180, 720),
            Parent = a19.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 140
                  upvalues:
                    a19 (copy, index: 1)
                ]]
                a19.MenuManager.Close("Collection")
            end)
        }
    )
    local content = v53.Content
    local ui2 = ui.new("TextLabel", {Name = "Summary", Text = "", RichText = true, TextSize = 16, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -(ui.WindowCloseSize() + 34), 0, 22), Size = udim2FromOffset(420, 24), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v53.Header})
    local selectionImageObject = ui.new("Frame", {Name = "CollectionSelection", Size = UDim2.fromScale(1, 1), ui.Corner(14), ui.Stroke(colors.Accent, 3, 0)})
    local parent = ui.Panel({Name = "Detail", BackgroundTransparency = 0.06, Size = udim2FromOffset(360, 500), Radius = UDim.new(0, 14), Parent = content})
    local uiGradient = parent:FindFirstChildOfClass("UIGradient")
    local uiStroke = parent:FindFirstChildOfClass("UIStroke")
    local parent2 = ui.new("Frame", {Name = "Preview", Size = udim2FromOffset(320, 220), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, (ui.Corner(12)), Parent = parent})
    local v61 = ui.Gradient(colors.Accent, colors.Panel, 115)
    v61.Parent = parent2
    local v62 = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1, 1.3), ImageColor3 = colors.Accent, Parent = parent2})
    local ui3 = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(0.86, 0.86), Parent = parent2})
    local ui4 = ui.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = gold, BackgroundTransparency = 1, ZIndex = 5, (ui.Corner(12)), Parent = parent2})
    local v65 = ui.Image(ui.Assets.Fx.Ring, {Name = "Ring", ImageTransparency = 1, ZIndex = 6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = udim2FromOffset(60, 60), ImageColor3 = gold, Parent = parent2})
    local parent3 = ui.new("Frame", {Name = "Burst", ZIndex = 7, Size = UDim2.fromScale(1, 1), Parent = parent2})
    local v67 = ui.DisplayText({Name = "LevelSlam", Text = "", TextSize = 52, StrokeThickness = 3, ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 0, 0, 60), TextColor3 = gold, Parent = parent2})
    v67.Visible = false
    local parent4 = ui.new("Frame", {Name = "Level", Position = udim2FromOffset(10, 10), Size = udim2FromOffset(76, 34), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, ZIndex = 9, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
    local v69 = ui.Stroke(colors.Stroke, 1, 0.8)
    v69.Parent = parent4
    local ui5 = ui.new("TextLabel", {Name = "Lv", Text = "LV", TextSize = 14, ZIndex = 9, Position = udim2FromOffset(12, 0), Size = udim2FromOffset(22, 34), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent4})
    local parent5 = ui.new("Frame", {Name = "Num", ClipsDescendants = true, ZIndex = 9, Position = udim2FromOffset(36, 2), Size = udim2FromOffset(30, 30), Parent = parent4})
    local ui6 = ui.new("TextLabel", {Name = "A", Text = "1", TextSize = 24, ZIndex = 9, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent5})
    local ui7 = ui.new("TextLabel", {Name = "B", Text = "", TextSize = 24, ZIndex = 9, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = gold, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent5})
    local parent6 = ui.new("Frame", {Name = "Lock", Position = udim2FromOffset(10, 10), Size = udim2FromOffset(36, 36), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, ZIndex = 9, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
    ui.Image(ui.Assets.Icons.Lock, {ZIndex = 9, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(18, 18), ImageColor3 = colors.TextDim, Parent = parent6})
    local parent7 = ui.new("TextLabel", {Name = "ItemName", Text = "", TextSize = 30, TextScaled = true, FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, Parent = parent})
    local ui8 = ui.new("UITextSizeConstraint", {MaxTextSize = 30, MinTextSize = 14, Parent = parent7})
    local ui9 = ui.new("TextLabel", {Name = "Sub", Text = "", RichText = true, TextSize = 14, FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local ui10 = ui.new("TextLabel", {Name = "BarCaption", Text = "SHARDS", TextSize = 12, FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local ui11 = ui.new("TextLabel", {Name = "BarGoal", Text = "", TextSize = 12, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent})
    local v80 = ui.Bar({Name = "Shards", Stroke = false, Size = udim2FromOffset(300, 24), Color = colors.Accent, Parent = parent})
    local parent8 = ui.new("TextLabel", {Name = "Count", Text = "", TextSize = 16, ZIndex = 3, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = v80.Frame})
    ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent8
    local ui12 = ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.9, BackgroundColor3 = colors.Text, Size = udim2FromOffset(300, 1), Parent = parent})
    local ui13 = ui.new("TextLabel", {Name = "BonusCaption", Text = "DAMAGE BONUS", TextSize = 12, FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
    local parent9 = ui.new("Frame", {Name = "Bonus", Size = udim2FromOffset(300, 36), (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
    local ui14 = ui.new("TextLabel", {Name = "Now", Text = "+0%", TextSize = 32, LayoutOrder = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Display, Parent = parent9})
    local v86 = ui.Icon("chevRight", 18, colors.TextMuted, {LayoutOrder = 2, Parent = parent9})
    local ui15 = ui.new("TextLabel", {Name = "Next", Text = "+2%", TextSize = 32, LayoutOrder = 3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Display, TextColor3 = theme.Lighten(success, 0.15), Parent = parent9})
    local ui16 = ui.new("TextLabel", {Name = "Word", AutoLocalize = false, Text = "damage", TextSize = 16, LayoutOrder = 4, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Bold, TextColor3 = colors.TextDim, Parent = parent9})
    local v89 = ui.CountUp(
        ui14,
        function(a90: number)
            --[[
              line: 303
              upvalues:
                pct (copy, index: 1)
            ]]
            return pct(a90)
        end,
        0.6
    )
    local v91 = ui.CountUp(
        ui15,
        function(a92: number)
            --[[
              line: 306
              upvalues:
                pct (copy, index: 1)
            ]]
            return pct(a92)
        end,
        0.6
    )
    local parent10 = ui.new("Frame", {Name = "Pips", Size = udim2FromOffset(300, 10), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
    local v94 = {}

    for layoutOrder = 1, maxLevel do
        v94[layoutOrder] = ui.new("Frame", {Name = "Pip" .. layoutOrder, Size = udim2FromOffset(40, 8), BackgroundColor3 = colors.Inset, LayoutOrder = layoutOrder, (ui.Corner(theme.Radius.Pill)), Parent = parent10})
    end

    do
        local ui17 = ui.new("TextLabel", {AutoLocalize = false, Name = "Note", Text = "", TextSize = 14, TextWrapped = true, FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent})
        local parent11 = ui.new("Frame", {Name = "ActionBox", Size = udim2FromOffset(300, 56), Parent = parent})
        local scaleObj = ui.GetScaleObj(parent11, "Pulse")
        local v99 = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.new(1, 60, 2.4, 0), ImageColor3 = success, Parent = parent11})
        local v100 = ui.Button({Name = "Action", Text = "UPGRADE", TextSize = 21, Style = "Success", Radius = 12, PassInput = true, Size = UDim2.fromScale(1, 1), Parent = parent11})
        v100.Label.RichText = true
        local ui18 = ui.new("TextLabel", {Name = "ActionNote", Text = "", AutoLocalize = false, RichText = true, TextSize = 13, FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, Parent = parent})
        local parent12 = ui.new("ScrollingFrame", {Name = "Grid", ScrollBarThickness = 5, ScrollBarImageTransparency = 0.4, AutomaticCanvasSize = Enum.AutomaticSize.None, ScrollBarImageColor3 = colors.TextMuted, Parent = content})
        local v103 = 900

        do
            local function screenPerDesign()
                --[[
                  name: screenPerDesign
                  line: 358
                  upvalues:
                    parent12 (copy, index: 1)
                    v103 (ref,  index: 2)
                ]]
                return (math.max(parent12.AbsoluteSize.X / math.max(v103, 1), 0.01))
            end
        end

        local function makeHeader(name: string, backgroundColor3, parent)
            --[[
              name: makeHeader
              line: 364
              upvalues:
                ui (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                fonts (copy, index: 3)
                colors (copy, index: 4)
            ]]
            local ui2 = ui.new("Frame", {Name = name, Size = UDim2.new(1, -8, 0, 34), Parent = parent})
            ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = ui2})
            ui.new("UIPadding", {PaddingLeft = UDim.new(0, 4), Parent = ui2})
            local tick = ui.new("Frame", {Name = "Bar", BackgroundColor3 = backgroundColor3, Size = udim2FromOffset(4, 18), LayoutOrder = 0, (ui.Corner(2)), Parent = ui2})
            local title = ui.new("TextLabel", {Name = "Text", Text = "", RichText = true, TextSize = 16, LayoutOrder = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = ui2})
            local sub = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 14, LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, Parent = ui2})

            return {frame = ui2, tick = tick, title = title, sub = sub}
        end

        local v113 = {"owned", "locked"}
        local v114 = {owned = makeHeader("Section_owned", colors.Accent, parent12), locked = makeHeader("Section_locked", colors.TextMuted, parent12)}
        v114.owned.sub.Text = string.format("level up with shards  ·  +%d%% per level", (math.floor((economy.BONUS_PER_LEVEL * 100) + 0.5)))
        v114.locked.sub.Text = "find shards in drops to unlock"
        local parent13 = ui.new("Frame", {Name = "Shop", Visible = false, Size = UDim2.new(1, -12, 0, 104), Parent = parent12})
        ui.Panel({Name = "Bg", BackgroundTransparency = 0.05, StrokeTransparency = 0.6, Size = UDim2.fromScale(1, 1), Radius = UDim.new(0, 14), TopColor = gold:Lerp(colors.Panel, 0.8), BottomColor = gold:Lerp(colors.PanelLo, 0.92), StrokeColor = gold, Parent = parent13})
        local parent14 = ui.new("Frame", {Name = "Emblem", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Size = udim2FromOffset(76, 76), Parent = parent13})
        ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.7, 1.7), ImageColor3 = gold, Parent = parent14})

        do
            local parent15 = ui.new("Frame", {Name = "Gem", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.66, 0.66), Rotation = 45, BackgroundColor3 = Color3.new(1, 1, 1), ui.Corner(10), ui.Gradient(Color3.fromRGB(255, 214, 110), Color3.fromRGB(214, 138, 20), 90), (ui.Stroke(Color3.fromRGB(255, 230, 160), 2, 0.3)), Parent = parent14})
            ui.new("Frame", {Name = "Facet", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62), BackgroundColor3 = Color3.fromRGB(255, 226, 150), BackgroundTransparency = 0.55, (ui.Corner(6)), Parent = parent15})
        end

        ui.Image(ui.Assets.Icons.Star, {Name = "Star", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(26, 26), ImageColor3 = Color3.fromRGB(120, 70, 8), Parent = parent14})
        local ui19 = ui.new("TextLabel", {Name = "Title", Text = "GOLDEN DROP", TextSize = 24, Position = udim2FromOffset(104, 18), Size = udim2FromOffset(300, 28), FontFace = fonts.Display, TextColor3 = gold, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent13})
        local ui20 = ui.new("TextLabel", {Name = "Line", Text = "", TextSize = 14, TextWrapped = true, Position = udim2FromOffset(104, 48), Size = udim2FromOffset(300, 40), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent13})
        local parent16 = ui.new("Frame", {Name = "Buttons", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = udim2FromOffset(470, 50), (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent13})
        local v121 = ui.Button({Name = "Odds", Text = "VIEW ODDS", TextSize = 15, Style = "Dark", Radius = 10, LayoutOrder = 1, Size = udim2FromOffset(122, 46), Parent = parent16})
        local v122 = ui.Button({Name = "Buy1", Text = "", TextSize = 16, Style = "Success", Radius = 10, LayoutOrder = 2, Size = udim2FromOffset(150, 46), Parent = parent16})
        local v123 = ui.Button({Name = "Buy5", Text = "", TextSize = 16, Style = "Success", Radius = 10, LayoutOrder = 3, Size = udim2FromOffset(166, 46), Parent = parent16})
        v122.Label.RichText = true
        v123.Label.RichText = true
        local v124 = ui.Pill("", gold, {Name = "Save", Height = 20, TextSize = 11, Transparency = 0, PadX = 7, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, -1), TextColor = colors.TextDark})
        v124.Parent = v123.Instance
        local color3 = Color3.fromRGB(245, 52, 64)
        local v126 = ui.Pill("", color3, {Name = "Sale", Height = 22, TextSize = 12, Transparency = 0, PadX = 8, ZIndex = 3, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, -1)})
        v126.Parent = v122.Instance
        local ancestor = ui.new("TextButton", {Name = "Odds", BackgroundTransparency = 0.35, Visible = false, Selectable = false, ZIndex = 20, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = v53.Body})
        ui.Corner(UDim.new(0, 16)).Parent = ancestor
        local parent17 = ui.Panel({Name = "Card", BackgroundTransparency = 0.02, StrokeTransparency = 0.6, ZIndex = 21, Active = true, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(560, 420), Radius = UDim.new(0, 16), StrokeColor = gold, Parent = ancestor})
        local scaleObj2 = ui.GetScaleObj(parent17, "FitScale")
        ui.new("TextLabel", {Name = "Title", Text = "GOLDEN DROP ODDS", TextSize = 26, ZIndex = 22, Position = udim2FromOffset(24, 18), Size = UDim2.new(1, -90, 0, 30), FontFace = fonts.Display, TextColor3 = gold, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent17})
        local ui21 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 14, ZIndex = 22, Position = udim2FromOffset(24, 50), Size = UDim2.new(1, -48, 0, 18), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent17})
        local v131 = ui.IconButton({Name = "Close", IconName = "cross", Sound = "Close", ZIndex = 23, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 14), Size = udim2FromOffset(44, 44), Color = colors.Raised, HoverColor = colors.Danger, Parent = parent17})
        local parent18 = ui.new("ScrollingFrame", {Name = "List", Position = udim2FromOffset(24, 80), Size = UDim2.new(1, -48, 1, -164), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 4, ScrollBarImageColor3 = colors.TextMuted, ZIndex = 22, (ui.List(Enum.FillDirection.Vertical, 2, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Top)), Parent = parent17})
        local parent19 = ui.new("Frame", {Name = "Buy", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -18), Size = UDim2.new(1, -48, 0, 50), ZIndex = 22, (ui.List(Enum.FillDirection.Horizontal, 12, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent17})
        local v134 = ui.Button({Name = "Buy1", Text = "", TextSize = 17, Style = "Success", Radius = 10, ZIndex = 23, LayoutOrder = 1, Size = udim2FromOffset(220, 48), Parent = parent19})
        local v135 = ui.Button({Name = "Buy5", Text = "", TextSize = 17, Style = "Success", Radius = 10, ZIndex = 23, LayoutOrder = 2, Size = udim2FromOffset(220, 48), Parent = parent19})
        v134.Label.RichText = true
        v135.Label.RichText = true

        local function oddsValue(a137)
            --[[
              name: oddsValue
              line: 532
            ]]
            for _, v139 in {"value", "text"} do
                if type(a137[v139]) == "string" and string.find(a137[v139], "%%") then
                    return a137[v139]
                end
            end

            local v140 = a137.chance
                or a137.p
                or a137.probability
                or a137.percent
                or a137.odds
                or a137.weight

            if type(v140) ~= "number" then
                return nil
            end

            local v141 = a137.percent ~= nil and type(a137.percent) == "number"
            local v142 = if not v141 and not (1 < v140) then v140 * 100 else v140

            if 0 < v142 and v142 < 0.1 then
                return "<0.1%"
            end
            if not (math.abs(v142 - math.floor(v142 + 0.5)) < 0.05) then
                return (string.format("%.1f%%", v142))
            end

            return (string.format("%d%%", (math.floor(v142 + 0.5))))
        end

        local function oddsLabel(a144)
            --[[
              name: oddsLabel
              line: 549
              upvalues:
                weaponInfo (copy, index: 1)
            ]]
            local v145 = type(a144.item) == "string" and a144.item
                or type(a144.id) == "string" and weaponInfo.Get(a144.id) and a144.id
                or nil

            if v145 and weaponInfo.Get(v145) then
                return weaponInfo.Name(v145)
            end

            for _, v147 in {"label", "name", "text", "kind", "title"} do
                if type(a144[v147]) == "string" then
                    return a144[v147]
                end
            end

            return "?"
        end

        local function addOddsRow(a149: string, text, text2, layoutOrder: number, a153)
            --[[
              name: addOddsRow
              line: 561
              upvalues:
                ui (copy, index: 1)
                parent18 (copy, index: 2)
                fonts (copy, index: 3)
                colors (copy, index: 4)
                a19 (copy, index: 5)
                formattedText (copy, index: 6)
                gold (copy, index: 7)
            ]]
            local v154
            local v155 = a149 ~= "title" and (a149 ~= "note" and 28 or 0) or 34
            local parent = ui.new("Frame", {ZIndex = 22, Name = "Row" .. layoutOrder, Size = UDim2.new(1, -8, 0, v155), LayoutOrder = layoutOrder, Parent = parent18})

            if a149 == "note" then
                parent.AutomaticSize = Enum.AutomaticSize.Y
                ui.new("TextLabel", {TextSize = 13, TextWrapped = true, ZIndex = 22, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = text, FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})

                return
            end

            local newUi = ui.new
            local v158 = "TextLabel"
            local v159 = {AutoLocalize = false, RichText = true, ZIndex = 22, Size = UDim2.new(1, -150, 1, 0)}
            local t = a19.Loc.T

            if a149 ~= "title" then
                v154 = if a153 then string.format("%s  <font size=\"12\" color=\"%s\">%s</font>", text, formattedText, a153) else text
            else
                v154 = string.upper(text)
            end

            v159.Text = t(v154)
            v159.FontFace = if a149 == "title" then fonts.Heavy else fonts.Bold
            v159.TextSize = a149 ~= "title" and 16 or 14
            v159.TextColor3 = if a149 == "title" then colors.TextMuted else colors.Text
            v159.TextXAlignment = Enum.TextXAlignment.Left
            v159.TextYAlignment = if a149 == "title" then Enum.TextYAlignment.Bottom else Enum.TextYAlignment.Center
            v159.TextTruncate = Enum.TextTruncate.AtEnd
            v159.Parent = parent
            newUi(v158, v159)

            if text2 then
                ui.new("TextLabel", {TextSize = 17, ZIndex = 22, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 150, 1, 0), Text = text2, FontFace = fonts.Display, TextColor3 = gold, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent})
            end

            if a149 == "row" then
                ui.new("Frame", {BackgroundTransparency = 0.93, ZIndex = 22, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = colors.Text, Parent = parent})
            end
        end

        local function buildOdds()
            --[[
              name: buildOdds
              line: 613
              upvalues:
                parent18 (copy, index: 1)
                addOddsRow (copy, index: 2)
                oddsLabel (copy, index: 3)
                oddsValue (copy, index: 4)
                economy (copy, index: 5)
                weaponInfo (copy, index: 6)
            ]]
            for _, child in parent18:GetChildren() do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end

            local v164 = 0
            local v165 = 0

            local function walk(a167, a168: number)
                --[[
                  name: walk
                  line: 621
                  upvalues:
                    v164 (ref,  index: 1)
                    addOddsRow (copy, index: 2)
                    oddsLabel (copy, index: 3)
                    walk (copy, index: 4)
                    oddsValue (copy, index: 5)
                    v165 (ref,  index: 6)
                ]]
                for _, v170 in a167 do
                    if type(v170) == "table" then
                        local v171 = type(v170.rows) == "table" and v170.rows
                            or type(v170.items) == "table" and v170.items
                            or type(v170.odds) == "table" and v170.odds
                            or type(v170.entries) == "table" and v170.entries
                            or nil

                        if v171 and a168 < 2 then
                            v164 += 1
                            addOddsRow("title", oddsLabel(v170), nil, v164)
                            walk(v171, a168 + 1)

                            if type(v170.note) == "string" then
                                v164 += 1
                                addOddsRow("note", v170.note, nil, v164)
                            end
                        else
                            local text = oddsValue(v170)
                            v164 += 1

                            if text then
                                v165 += 1
                                addOddsRow("row", oddsLabel(v170), text, v164)
                            elseif type(v170.note) == "string" or type(v170.text) == "string" then
                                addOddsRow("note", (v170.note or v170.text), nil, v164)
                            end
                        end
                    end
                end
            end

            local v173 = economy.Odds("golden")
            local v174 = economy.DropInfo("golden")

            if type(v173) ~= "table" or type(v173.items) ~= "table" then
                walk(v173, 0)
            else
                local function fmt(chance)
                    --[[
                      name: fmt
                      line: 652
                      upvalues:
                        oddsValue (copy, index: 1)
                    ]]
                    return oddsValue({chance = chance}) or "0%"
                end

                v164 += 1
                addOddsRow("title", "Every Golden Drop", nil, v164)

                if type(v174.stacks) == "number" and type(v174.min) == "number" then
                    v164 += 1
                    local stringFormat = string.format
                    local stacks = v174.stacks
                    local min = v174.min
                    local v180 = v174.max or v174.min
                    addOddsRow("row", "Stacks of shards", stringFormat("%d × %d–%d", stacks, min, v180), v164)
                end

                if type(v173.lockedChance) == "number" then
                    v164 += 1
                    v165 += 1
                    addOddsRow("row", "An item you don't own yet", (oddsValue({chance = v173.lockedChance}) or "0%"), v164)
                end

                v164 += 1
                addOddsRow("title", "Chance each item is in your drop", nil, v164)

                for _, item in v173.items do
                    if type(item) == "table" then
                        if type(item.item) ~= "string" then
                            continue
                        end
                        if type(item.chance) ~= "number" then
                            continue
                        end

                        v164 += 1
                        v165 += 1
                        local text = weaponInfo.Name(item.item)
                        local text2 = oddsValue({chance = item.chance}) or "0%"
                        local layoutOrder = v164
                        local v186 = item.locked and "LOCKED" or nil
                        addOddsRow("row", text, text2, layoutOrder, v186)
                    end
                end

                v164 += 1
                addOddsRow("note", "For your collection right now: maxed items never drop, and items in the loadout you carry turn up more often. Stack sizes are random within the range above.", nil, v164)
            end

            if v165 == 0 then
                v164 += 1
                addOddsRow("note", "The odds are on their way from the server. Try again in a moment.", nil, v164)
            end

            return v165
        end

        local function priceLabel(a188, a189: string)
            --[[
              name: priceLabel
              line: 686
              upvalues:
                economy (copy, index: 1)
                Unlocks (copy, index: 2)
            ]]
            if economy.Pending(a188) then
                return "…"
            end

            local v191 = if const v190 = if a188 == Unlocks.FIRST_DROP.key then economy.Price("drop_golden") else nil then string.format("<font color=\"#C9F5D6\"><s>%d</s></font> ", v190) else ""

            return string.format("%s  <font color=\"%s\">%s</font> %s%s", a189, "#FFFFFF", economy.ROBUX, v191, economy.PriceAmount(a188))
        end

        local function paintShop()
            --[[
              name: paintShop
              line: 696
              upvalues:
                economy (copy, index: 1)
                ui20 (copy, index: 2)
                a19 (copy, index: 3)
                v126 (copy, index: 4)
                ui21 (copy, index: 5)
                v122 (copy, index: 6)
                priceLabel (copy, index: 7)
                v123 (copy, index: 8)
                v134 (copy, index: 9)
                v135 (copy, index: 10)
                v124 (copy, index: 11)
            ]]
            local flooredValue
            local v194
            local flooredValue2
            local v196, v197, v198, v199 = false, false, false, false
            local v200 = economy.DropInfo("golden")
            local number = tonumber(v200.stacks) or 4
            local number2 = tonumber(v200.min)
            local number3 = tonumber(v200.max)

            if number2 then
                if number3 then
                    flooredValue2 = math.floor(((number * (number2 + number3)) / 2) + 0.5)
                else
                    v196 = true
                end
            else
                v196 = true
            end

            if v196 then
                flooredValue2 = 60
            end

            local v204 = economy.GoldenOffer()
            local v205 = economy.OfferLeft()

            if v204 then
                if v204.state ~= "active" then
                    v197 = true
                elseif v205 then
                    ui20.RichText = true
                    a19.Loc.Rich(ui20, string.format("<font color=\"#FF8C92\"><b>ONE-TIME OFFER</b>: ends in %s</font>\nAbout %d shards in %d big stacks.", economy.FormatLeft(v205), flooredValue2, number))
                else
                    v197 = true
                end
            else
                v197 = true
            end

            if v197 then
                a19.Loc.Rich(ui20, string.format("About %d shards in %d big stacks.\nOne is always an item you don't own yet.", flooredValue2, number))
            end

            if v204 then
                if v204.state ~= "active" then
                    v198 = true
                else
                    v194 = economy.OfferDiscount()
                end
            else
                v198 = true
            end

            if v198 then
                v194 = nil
            end

            v126.Visible = v194 ~= nil

            if v194 then
                v126:FindFirstChild("Text").Text = string.format("-%d%%", v194)
            end

            ui21.Text = string.format("About %d shards in %d stacks. Odds for your collection, before you buy.", flooredValue2, number)
            local v206 = economy.DropKey(1)
            local v207 = economy.DropKey(5)
            v122:SetText(priceLabel(v206, "1 DROP"))
            v123:SetText(priceLabel(v207, "5 DROPS"))
            v134:SetText(priceLabel(v206, "BUY 1"))
            v135:SetText(priceLabel(v207, "BUY 5"))
            v122:SetEnabled(not economy.Pending(v206))
            v123:SetEnabled(not economy.Pending(v207))
            v134:SetEnabled(not economy.Pending(v206))
            v135:SetEnabled(not economy.Pending(v207))
            local v208 = economy.Price(v206) or 0
            local v209 = economy.Price(v207) or 0

            if not (0 < v208) then
                v199 = true
            elseif not (0 < v209) then
                v199 = true
            else
                flooredValue = math.floor(((1 - (v209 / (5 * v208))) * 100) + 0.5)
            end

            if v199 then
                flooredValue = 0
            end

            v124.Visible = 5 <= flooredValue
            v124:FindFirstChild("Text").Text = string.format("SAVE %d%%", flooredValue)
        end

        local function openOdds()
            --[[
              name: openOdds
              line: 730
              upvalues:
                buildOdds (copy, index: 1)
                paintShop (copy, index: 2)
                ui (copy, index: 3)
                v53 (copy, index: 4)
                parent17 (copy, index: 5)
                udim2FromOffset (copy, index: 6)
                scaleObj2 (copy, index: 7)
                ancestor (copy, index: 8)
                theme (copy, index: 9)
                a19 (copy, index: 10)
                guiService (copy, index: 11)
                v134 (copy, index: 12)
            ]]
            buildOdds()
            paintShop()
            local _ = ui.CanvasSize()
            local v212 = math.min(460, (math.floor(v53.Holder.Size.Y.Offset - 40)))
            parent17.Size = udim2FromOffset(560, v212)
            scaleObj2.Scale = math.min(1, (v53.Holder.Size.X.Offset - 40) / 560)
            ancestor.Visible = true
            ancestor.BackgroundTransparency = 1
            ui.Tween(ancestor, theme.Tween.Smooth, {BackgroundTransparency = 0.35})
            ui.SlideIn(parent17, Vector2.new(0, 24), theme.Tween.Pop, UDim2.fromScale(0.5, 0.5))
            a19.Sounds.Play("Open")

            if ui.Gamepad then
                guiService.SelectedObject = v134.Instance
            end
        end

        do
            local function closeOdds()
                --[[
                  name: closeOdds
                  line: 747
                  upvalues:
                    ancestor (copy, index: 1)
                    guiService (copy, index: 2)
                    v121 (copy, index: 3)
                ]]
                if not ancestor.Visible then
                    return
                end

                ancestor.Visible = false
                local selectedObject = guiService.SelectedObject

                if selectedObject and selectedObject:IsDescendantOf(ancestor) then
                    guiService.SelectedObject = v121.Instance
                end
            end

            v121.Activated:Connect(openOdds)
            v131.Activated:Connect(closeOdds)
            ancestor.Activated:Connect(closeOdds)
        end

        do
            local function buyDrops(a216)
                --[[
                  name: buyDrops
                  line: 760
                  upvalues:
                    economy (copy, index: 1)
                    paintShop (copy, index: 2)
                ]]
                if not economy.DropsAllowed() then
                    return
                end

                economy.Buy(economy.DropKey(a216))
                paintShop()
            end
        end

        v122.Activated:Connect(
            function()
                --[[
                  line: 767
                  upvalues:
                    economy (copy, index: 1)
                    paintShop (copy, index: 2)
                ]]
                if not economy.DropsAllowed() then
                    return
                end

                economy.Buy(economy.DropKey(1))
                paintShop()
            end
        )

        v123.Activated:Connect(
            function()
                --[[
                  line: 770
                  upvalues:
                    economy (copy, index: 1)
                    paintShop (copy, index: 2)
                ]]
                if not economy.DropsAllowed() then
                    return
                end

                economy.Buy(economy.DropKey(5))
                paintShop()
            end
        )

        v134.Activated:Connect(
            function()
                --[[
                  line: 773
                  upvalues:
                    economy (copy, index: 1)
                    paintShop (copy, index: 2)
                ]]
                if not economy.DropsAllowed() then
                    return
                end

                economy.Buy(economy.DropKey(1))
                paintShop()
            end
        )

        v135.Activated:Connect(
            function()
                --[[
                  line: 776
                  upvalues:
                    economy (copy, index: 1)
                    paintShop (copy, index: 2)
                ]]
                if not economy.DropsAllowed() then
                    return
                end

                economy.Buy(economy.DropKey(5))
                paintShop()
            end
        )

        do
            local function cardH()
                --[[
                  name: cardH
                  line: 781
                  upvalues:
                    ui (copy, index: 1)
                ]]
                if ui.Compact then
                    return 184
                end

                return 212
            end
        end

        local targets = {}
        local v219 = {}
        local v220 = nil
        local v221 = nil
        local v222 = nil
        local v223 = nil

        local function makeCard(a225)
            --[[
              name: makeCard
              line: 826
              upvalues:
                economy (copy, index: 1)
                ui (copy, index: 2)
                udim2FromOffset (copy, index: 3)
                parent12 (copy, index: 4)
                selectionImageObject (copy, index: 5)
                colors (copy, index: 6)
                theme (copy, index: 7)
                fonts (copy, index: 8)
                RankArt (copy, index: 9)
                success (copy, index: 10)
                a19 (copy, index: 11)
                v221 (ref,  index: 12)
                v222 (ref,  index: 13)
                v220 (ref,  index: 14)
                v223 (ref,  index: 15)
            ]]
            local h
            local id = a225.id
            local startValue = economy.CategoryColor(id)
            local newUi = ui.new
            local v230 = {Selectable = true, Name = a225.id}
            local v231 = ui.Compact and 184 or 212
            v230.Size = udim2FromOffset(170, v231)
            v230.Parent = parent12
            local ui2 = newUi("TextButton", v230)
            ui2.SelectionImageObject = selectionImageObject
            local scale = ui.GetScaleObj(ui2, "HoverScale")
            local ui3 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.08, ClipsDescendants = true, (ui.Corner(14)), Parent = ui2})
            local grad = ui.Gradient(startValue:Lerp(colors.Panel, 0.82), colors.PanelHi:Lerp(colors.Panel, 0.6), 115)
            grad.Parent = ui3

            local stroke = ui.Stroke(colors.Stroke, 1, 0.9)
            stroke.Parent = ui3
            local glow = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.72, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 64), Size = udim2FromOffset(190, 150), ImageColor3 = startValue, Parent = ui3})
            local icon = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 12), Size = UDim2.new(1, -28, 1, -100), Parent = ui3})
            local ui4 = ui.new("Frame", {Name = "Level", Position = udim2FromOffset(8, 8), AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 24), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.25, ZIndex = 4, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 9, 0, 9)), Parent = ui3})
            local lvText = ui.new("TextLabel", {Name = "Text", Text = "LV 1", RichText = true, TextSize = 14, ZIndex = 4, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Display, Parent = ui4})
            local ui5 = ui.new("Frame", {Name = "Lock", Position = udim2FromOffset(8, 8), Size = udim2FromOffset(28, 28), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.25, ZIndex = 4, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
            ui.Image(ui.Assets.Icons.Lock, {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(15, 15), ImageColor3 = colors.TextDim, Parent = ui5})
            local name = ui.new("TextLabel", {Name = "ItemName", TextSize = 17, ZIndex = 3, Position = UDim2.new(0, 12, 1, -84), Size = UDim2.new(1, -24, 0, 22), Text = a225.name, FontFace = fonts.Bold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3})
            local sub = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 11, ZIndex = 3, Position = UDim2.new(0, 12, 1, -61), Size = UDim2.new(0.62, -12, 0, 15), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3})
            local meta = ui.new("TextLabel", {Name = "Meta", Text = "", TextSize = 11, ZIndex = 3, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 1, -61), Size = UDim2.new(0.38, 0, 0, 15), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = ui3})
            local rankEmblem = RankArt.Emblem(1, 18, {Name = "RankEmblem", ZIndex = 3, Position = UDim2.new(0, 10, 1, -62.5), Parent = ui3})
            rankEmblem.Visible = false
            local ui6 = ui.new("Frame", {Name = "Shards", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -10), Size = UDim2.new(1, -20, 0, 22), BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.1, ClipsDescendants = true, ZIndex = 3, (ui.Corner(theme.Radius.Pill)), Parent = ui3})
            local ui7 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, (ui.Corner(theme.Radius.Pill)), Parent = ui6})
            local barFillGrad = ui.Gradient(theme.Lighten(colors.Accent, 0.2), colors.Accent, 90)
            barFillGrad.Parent = ui7
            local ui8 = ui.new("TextLabel", {Name = "Count", Text = "", TextSize = 14, ZIndex = 4, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = ui6})
            ui.TextStroke(colors.Void, 1.2, 0.35).Parent = ui8
            local ui9 = ui.new("TextButton", {Name = "Upgrade", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8), Size = UDim2.new(1, -16, 0, 30), BackgroundColor3 = Color3.new(1, 1, 1), Text = "", Selectable = true, Visible = false, ZIndex = 6, ui.Corner(theme.Radius.Pill), ui.Gradient(Color3.fromRGB(84, 224, 124), Color3.fromRGB(40, 184, 92), 90), (ui.Stroke(Color3.fromRGB(170, 255, 200), 1, 0.5)), Parent = ui3})
            ui9.SelectionImageObject = selectionImageObject
            local upScale = ui.GetScaleObj(ui9, "Pulse")
            local upGlow = ui.Image(ui.Assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.6, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 30, 2.6, 0), ImageColor3 = success, Parent = ui9})
            local parent = ui.new("Frame", {Size = UDim2.fromScale(1, 1), ZIndex = 6, (ui.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = ui9})
            ui.Icon("chevUp", 13, colors.Text, {LayoutOrder = 1, ZIndex = 6, Parent = parent})
            ui.new("TextLabel", {Text = "UPGRADE", TextSize = 15, LayoutOrder = 2, ZIndex = 6, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Display, Parent = parent})
            local flash = ui.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Accent, BackgroundTransparency = 1, ZIndex = 5, (ui.Corner(14)), Parent = ui3})
            local v255 = {state = "locked", section = "locked", rendered = false, visible = true, shown = false, hover = false, y = 0, id = a225.id, holder = ui2, scale = scale, inner = ui3, grad = grad, stroke = stroke, glow = glow, icon = icon, lv = ui4, lvText = lvText, lock = ui5, name = name, sub = sub, meta = meta, rankEmblem = rankEmblem, barBg = ui6, barFill = ui7, barFillGrad = barFillGrad, barText = ui8, up = ui9, upScale = upScale, upGlow = upGlow, flash = flash}

            if ui.Compact then
                h = 184
            else
                h = 212
            end

            v255.h = h

            ui2.MouseEnter:Connect(
                function()
                    --[[
                      line: 986
                      upvalues:
                        ui (copy, index: 1)
                        v255 (copy, index: 2)
                        a19 (copy, index: 3)
                        scale (copy, index: 4)
                        theme (copy, index: 5)
                        v221 (ref,  index: 6)
                    ]]
                    if ui.Touch then
                        return
                    end

                    v255.hover = true
                    a19.Sounds.Play("Hover")
                    ui.Tween(scale, theme.Tween.PopSmall, {Scale = 1.03})
                    v221(v255)
                end
            )

            ui2.MouseLeave:Connect(
                function()
                    --[[
                      line: 995
                      upvalues:
                        v255 (copy, index: 1)
                        ui (copy, index: 2)
                        scale (copy, index: 3)
                        theme (copy, index: 4)
                        v221 (ref,  index: 5)
                    ]]
                    v255.hover = false
                    ui.Tween(scale, theme.Tween.Fast, {Scale = 1})
                    v221(v255)
                end
            )

            ui2.MouseButton1Down:Connect(
                function()
                    --[[
                      line: 1000
                      upvalues:
                        ui (copy, index: 1)
                        scale (copy, index: 2)
                        theme (copy, index: 3)
                    ]]
                    ui.Tween(scale, theme.Tween.Instant, {Scale = 0.97})
                end
            )

            ui2.MouseButton1Up:Connect(
                function()
                    --[[
                      line: 1003
                      upvalues:
                        ui (copy, index: 1)
                        scale (copy, index: 2)
                        theme (copy, index: 3)
                        v255 (copy, index: 4)
                    ]]
                    local scale2
                    local tween = ui.Tween
                    local popSmall = theme.Tween.PopSmall
                    local v259 = {}

                    if v255.hover then
                        scale2 = 1.03
                    else
                        scale2 = 1
                    end

                    v259.Scale = scale2
                    tween(scale, popSmall, v259)
                end
            )

            ui2.Activated:Connect(
                function()
                    --[[
                      line: 1006
                      upvalues:
                        a19 (copy, index: 1)
                        v222 (ref,  index: 2)
                        a225 (copy, index: 3)
                    ]]
                    a19.Sounds.Play("Select")
                    v222(a225.id)
                end
            )

            ui2.SelectionGained:Connect(
                function()
                    --[[
                      line: 1010
                      upvalues:
                        v220 (ref,  index: 1)
                        a225 (copy, index: 2)
                        v222 (ref,  index: 3)
                    ]]
                    if v220 ~= a225.id then
                        v222(a225.id, {quiet = true})
                    end
                end
            )

            ui.TrackPress(ui9)

            ui9.MouseEnter:Connect(
                function()
                    --[[
                      line: 1016
                      upvalues:
                        ui (copy, index: 1)
                        a19 (copy, index: 2)
                    ]]
                    if not ui.Touch then
                        a19.Sounds.Play("Hover")
                    end
                end
            )

            ui9.Activated:Connect(
                function(a260)
                    --[[
                      line: 1021
                      upvalues:
                        v222 (ref,  index: 1)
                        a225 (copy, index: 2)
                        v223 (ref,  index: 3)
                        ui9 (copy, index: 4)
                    ]]
                    v222(a225.id, {quiet = true})
                    v223(a225.id, a260, ui9)
                end
            )

            return v255
        end

        v221 = function(a261)
            --[[
              line: 1028
              upvalues:
                stateOf (copy, index: 1)
                economy (copy, index: 2)
                v220 (ref,  index: 3)
                gold (copy, index: 4)
                colors (copy, index: 5)
                a19 (copy, index: 6)
                weaponIcon (copy, index: 7)
                success (copy, index: 8)
                theme (copy, index: 9)
                RankArt (copy, index: 10)
                weaponInfo (copy, index: 11)
            ]]
            local color
            local id = a261.id
            local state = stateOf(id)
            a261.state = state
            local v265 = economy.Level(id)
            local v266, v267 = economy.Progress(id)
            local startValue = economy.CategoryColor(id)
            local v269 = v220 == id
            local visible = state == "locked"
            a261.lock.Visible = visible
            a261.lv.Visible = not visible

            if state ~= "max" then
                a261.lv.BackgroundColor3 = colors.Void
                a261.lv.BackgroundTransparency = 0.25
                local rich = a19.Loc.Rich
                local lvText = a261.lvText
                local stringFormat = string.format
                local textDim = colors.TextDim
                rich(lvText, stringFormat("<font size=\"11\" color=\"%s\">LV</font> %d", string.format("#%02X%02X%02X", math.floor((textDim.R * 255) + 0.5), math.floor((textDim.G * 255) + 0.5), (math.floor((textDim.B * 255) + 0.5))), v265))
                a261.lvText.TextColor3 = colors.Text
            else
                a261.lv.BackgroundColor3 = gold
                a261.lv.BackgroundTransparency = 0
                a261.lvText.Text = "MAX"
                a261.lvText.TextColor3 = colors.TextDark
            end

            local grad = a261.grad

            if visible then
                color = ColorSequence.new(colors.Panel, colors.Panel)
            else
                local v276 = state ~= "max" and (a261.hover and 0.24 or 0.18) or 0.22
                color = ColorSequence.new(startValue:Lerp(colors.Panel, 1 - v276), colors.PanelHi:Lerp(colors.Panel, 0.6))
            end

            grad.Color = color
            a261.inner.BackgroundTransparency = visible and 0.3 or 0.08
            a261.glow.ImageTransparency = visible and 1 or a261.hover and 0.62 or v269 and 0.62 or 0.74

            if a261.rendered then
                weaponIcon.SetDim(a261.icon, visible)
            end

            a261.name.TextColor3 = if visible then colors.TextDim else colors.Text

            if v269 then
                a261.stroke.Color = if state == "ready" then success else colors.Accent
                a261.stroke.Thickness = 2
                a261.stroke.Transparency = 0
            elseif state == "ready" then
                a261.stroke.Color = success
                a261.stroke.Thickness = 2
            elseif state == "max" then
                a261.stroke.Color = gold
                a261.stroke.Thickness = 1
                a261.stroke.Transparency = 0.55
            else
                a261.stroke.Color = colors.Stroke
                a261.stroke.Thickness = 1
                a261.stroke.Transparency = a261.hover and 0.6 or 0.9
            end

            a261.up.Visible = state == "ready"
            a261.barBg.Visible = state ~= "ready"
            local v277 = not (0 < v267) and 1 or math.clamp(v266 / v267, 0, 1)
            local barFill = a261.barFill
            local v279 = UDim2.fromScale
            local v280 = state == "max" and 1 or v277
            barFill.Size = v279(v280, 1)
            a261.barFill.Visible = (state == "max") or (0 < v266)
            a261.rankEmblem.Visible = false
            a261.sub.Position = UDim2.new(0, 12, 1, -61)
            a261.sub.Size = UDim2.new(0.62, -12, 0, 15)

            if state == "max" then
                a261.barFillGrad.Color = ColorSequence.new(theme.Lighten(gold, 0.15), gold:Lerp(Color3.fromRGB(180, 110, 10), 0.3))
                a261.barText.Text = "MAX"
                a261.sub.Text = "MAX LEVEL"
                a261.sub.TextColor3 = gold
                a261.meta.Text = string.upper(economy.BonusText(id, v265))
                a261.meta.TextColor3 = gold

                return
            end

            if visible and not economy.RankAllows(id) then
                local v281 = economy.ItemRank(id)
                a261.barFillGrad.Color = ColorSequence.new(theme.Lighten(colors.Accent, 0.1), colors.AccentDark)
                a261.barText.Text = string.format("%d / %d", v266, v267)
                RankArt.SetEmblem(a261.rankEmblem, v281)
                a261.rankEmblem.Visible = true
                a261.sub.Position = UDim2.new(0, 32, 1, -61)
                a261.sub.Size = UDim2.new(1, -44, 0, 15)
                a261.sub.Text = "REACH " .. string.upper(RankArt.Ranks.Get(v281).name)
                a261.sub.TextColor3 = RankArt.Color(v281)
                a261.meta.Text = ""

                return
            end

            if visible then
                a261.barFillGrad.Color = ColorSequence.new(theme.Lighten(colors.Accent, 0.1), colors.AccentDark)
                a261.barText.Text = string.format("%d / %d", v266, v267)
                a261.sub.Text = "LOCKED"
                a261.sub.TextColor3 = colors.TextMuted
                a261.meta.Text = "TO UNLOCK"
                a261.meta.TextColor3 = colors.TextMuted

                return
            end

            if state == "ready" then
                a261.sub.Text = "UPGRADE READY"
                a261.sub.TextColor3 = theme.Lighten(success, 0.15)
                a261.meta.Text = string.format("%d / %d", v266, v267)
                a261.meta.TextColor3 = colors.TextDim

                return
            end

            if state == "fixed" then
                local v282
                a261.barFill.Visible = false
                a261.barText.Text = "NO LEVELS"
                local sub = a261.sub
                local v284 = weaponInfo.Get(id)
                v279 = string.upper

                if v284 then
                    v282 = weaponInfo.CATEGORY_SINGULAR[v284.category] or ""
                else
                    v282 = ""
                end

                sub.Text = v279(v282)
                a261.sub.TextColor3 = colors.TextMuted
                a261.meta.Text = ""

                return
            end

            local text2
            a261.barFillGrad.Color = ColorSequence.new(theme.Lighten(colors.Accent, 0.2), colors.Accent)
            a261.barText.Text = string.format("%d / %d", v266, v267)
            local sub = a261.sub

            if not (1 < v265) then
                local text
                local v288 = weaponInfo.Get(id)
                local stringUpper = string.upper

                if v288 then
                    text = weaponInfo.CATEGORY_SINGULAR[v288.category] or ""
                else
                    text = ""
                end

                text2 = stringUpper(text)
            else
                text2 = string.upper(economy.BonusText(id, v265))
            end

            sub.Text = text2
            a261.sub.TextColor3 = colors.TextMuted
            a261.meta.Text = "TO LV " .. v265 + 1
            a261.meta.TextColor3 = colors.TextMuted
        end

        local v290 = {}

        local function queueVisible()
            --[[
              name: queueVisible
              line: 1131
              upvalues:
                parent12 (copy, index: 1)
                v103 (ref,  index: 2)
                targets (copy, index: 3)
                v290 (copy, index: 4)
                weaponIcon (copy, index: 5)
            ]]
            local v292 = math.max(parent12.AbsoluteSize.X / math.max(v103, 1), 0.01)
            local v293 = parent12.CanvasPosition.Y / v292
            local v294 = v293 + parent12.AbsoluteWindowSize.Y / v292

            for _, target in targets do
                local v297
                local visible = target.visible

                if visible then
                    v297 = false
                    local v299 = target.y + target.h

                    if v293 - target.h <= v299 then
                        v297 = target.y <= v294 + target.h
                    end
                else
                    v297 = visible
                end

                local v300, v301 = false, false

                if v297 then
                    if target.rendered then
                        v300 = true
                    else
                        target.rendered = true
                        table.insert(v290, target)
                    end
                else
                    v300 = true
                end

                if v300 and target.rendered then
                    if target.visible then
                        if target.y + target.h < v293 - (target.h * 2) then
                            v301 = true
                        else
                            local y = target.y

                            if v294 + (target.h * 2) < y then
                                v301 = true
                            end
                        end
                    else
                        v301 = true
                    end
                end

                if v301 then
                    target.rendered = false

                    if const index = table.find(v290, target) then
                        table.remove(v290, index)
                    end

                    weaponIcon.Set(target.icon, nil)
                end
            end
        end

        runService.Heartbeat:Connect(
            function()
                --[[
                  line: 1151
                  upvalues:
                    v290 (copy, index: 1)
                    v53 (copy, index: 2)
                    ui (copy, index: 3)
                    weaponIcon (copy, index: 4)
                ]]
                if #v290 == 0 or not v53.IsOpen then
                    return
                end

                local v304 = ui.Touch and 2 or 4

                for _ = 1, v304 do
                    local removedValue = table.remove(v290, 1)
                    if not removedValue then
                        break
                    end

                    weaponIcon.Set(removedValue.icon, removedValue.id, {outline = false, glow = false})
                    weaponIcon.SetDim(removedValue.icon, removedValue.state == "locked")
                end
            end
        )

        parent12:GetPropertyChangedSignal("CanvasPosition"):Connect(queueVisible)
        local visible = true

        local function layoutPanel(a309, a310, compact)
            --[[
              name: layoutPanel
              line: 1168
              upvalues:
                parent (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                parent2 (copy, index: 3)
                ui8 (copy, index: 4)
                parent7 (copy, index: 5)
                ui9 (copy, index: 6)
                ui (copy, index: 7)
                parent4 (copy, index: 8)
                parent6 (copy, index: 9)
                v67 (copy, index: 10)
                ui10 (copy, index: 11)
                ui11 (copy, index: 12)
                v80 (copy, index: 13)
                parent8 (copy, index: 14)
                ui12 (copy, index: 15)
                ui13 (copy, index: 16)
                v94 (copy, index: 17)
                maxLevel (copy, index: 18)
                parent10 (copy, index: 19)
                parent9 (copy, index: 20)
                ui14 (copy, index: 21)
                ui15 (copy, index: 22)
                ui16 (copy, index: 23)
                ui17 (copy, index: 24)
                visible (ref,  index: 25)
                parent11 (copy, index: 26)
                v100 (copy, index: 27)
                ui18 (copy, index: 28)
            ]]
            local v312
            parent.Size = udim2FromOffset(a309, a310)
            local v313 = compact and 12 or 16
            local v314 = a309 - v313 * 2
            local v315 = compact and 48 or 56
            local v316 = compact and 14 or 16

            if compact then
                parent2.Position = udim2FromOffset(v313, v313)
                parent2.Size = udim2FromOffset(104, 104)
                local v317 = v313 + 104 + 12
                ui8.MaxTextSize = 24
                parent7.Position = udim2FromOffset(v317, v313 + 20)
                parent7.Size = udim2FromOffset((a309 - v317) - v313, 30)
                ui9.Position = udim2FromOffset(v317, v313 + 54)
                ui9.Size = udim2FromOffset((a309 - v317) - v313, 16)
                ui9.TextSize = 12
                v312 = v313 + 104 + 12
            else
                local v318 = ((v315 + 16) + 4) + v316 + v313
                local clampedValue = math.clamp(((a310 - v313) - 279) - v318, 150, 300)
                parent2.Position = udim2FromOffset(v313, v313)
                parent2.Size = udim2FromOffset(v314, clampedValue)
                ui8.MaxTextSize = 30
                local v320 = v313 + clampedValue + 14
                parent7.Position = udim2FromOffset(v313, v320)
                parent7.Size = udim2FromOffset(v314, 36)
                local v321 = v320 + 36
                ui9.Position = udim2FromOffset(v313, v321)
                ui9.Size = udim2FromOffset(v314, 20)
                ui9.TextSize = 15
                v312 = v321 + 38
            end

            local scale = compact and 0.8 or 1
            ui.GetScaleObj(parent4, "Size").Scale = scale
            ui.GetScaleObj(parent6, "Size").Scale = scale
            v67.TextSize = compact and 30 or 52
            ui10.Position = udim2FromOffset(v313, v312)
            ui10.Size = udim2FromOffset(v314, 16)
            ui10.TextSize = compact and 11 or 12
            ui11.Position = udim2FromOffset(v313, v312)
            ui11.Size = udim2FromOffset(v314, 16)
            ui11.TextSize = compact and 11 or 12
            local v323 = v312 + 18
            local v324 = compact and 20 or 26
            v80.Frame.Position = udim2FromOffset(v313, v323)
            v80.Frame.Size = udim2FromOffset(v314, v324)
            parent8.TextSize = compact and 14 or 17
            local v325 = compact and 12 or 16
            v323 += v324 + v325
            ui12.Position = udim2FromOffset(v313, v323)
            ui12.Size = udim2FromOffset(v314, 1)
            local v326 = compact and 10 or 16
            v323 += v326 + 1
            ui13.Position = udim2FromOffset(v313, v323)
            ui13.Size = udim2FromOffset(v314, 16)
            ui13.TextSize = compact and 11 or 12
            local v327 = compact and 18 or 26

            for _, v329 in v94 do
                local v330 = compact and 6 or 8
                v329.Size = udim2FromOffset(v327, v330)
            end

            local v331 = maxLevel * v327 + (maxLevel - 1) * 6
            parent10.Position = udim2FromOffset((v313 + v314) - v331, v323 + 4)
            parent10.Size = udim2FromOffset(v331, 8)
            local v332 = compact and 2 or 4
            v323 += v332 + 16
            parent9.Position = udim2FromOffset(v313, v323)
            local v333 = compact and 30 or 40
            parent9.Size = udim2FromOffset(v314, v333)
            ui14.TextSize = compact and 24 or 34
            ui15.TextSize = compact and 24 or 34
            ui16.TextSize = compact and 14 or 17
            local v334 = compact and 30 or 40
            local v335 = compact and 4 or 8
            v323 += v334 + v335
            ui17.Position = udim2FromOffset(v313, v323)
            local v336 = compact and 34 or 40
            ui17.Size = udim2FromOffset(v314, v336)
            ui17.TextSize = compact and 13 or 14
            local v337 = compact and 34 or 40
            local v338 = ((a310 - (v323 + v337)) - v313) - v315 - 8
            visible = (v316 + 4) <= v338
            local v339 = if visible then ((a310 - v313) - v316) - 4 - v315 else a310 - v313 - v315
            parent11.Position = udim2FromOffset(v313, v339)
            parent11.Size = udim2FromOffset(v314, v315)
            v100.Label.TextSize = compact and 18 or 21
            ui18.Position = udim2FromOffset(v313, (v339 + v315) + 4)
            ui18.Size = udim2FromOffset(v314, v316)
            ui18.TextSize = compact and 12 or 13
        end

        local v340 = nil
        local count = 0
        local v342 = nil
        local v343 = nil

        local v344 = function()
            --[[
              line: 1263
              upvalues:
                v220 (ref,  index: 1)
                stateOf (copy, index: 2)
                economy (copy, index: 3)
                v340 (ref,  index: 4)
                v342 (ref,  index: 5)
                weaponIcon (copy, index: 6)
                ui3 (copy, index: 7)
                ui (copy, index: 8)
                theme (copy, index: 9)
                parent7 (copy, index: 10)
                weaponInfo (copy, index: 11)
                a19 (copy, index: 12)
                ui9 (copy, index: 13)
                formattedText (copy, index: 14)
                v34 (copy, index: 15)
                colors (copy, index: 16)
                maxLevel (copy, index: 17)
                success (copy, index: 18)
                gold (copy, index: 19)
                v61 (copy, index: 20)
                v62 (copy, index: 21)
                uiGradient (copy, index: 22)
                uiStroke (copy, index: 23)
                parent6 (copy, index: 24)
                parent4 (copy, index: 25)
                ui5 (copy, index: 26)
                udim2FromOffset (copy, index: 27)
                parent5 (copy, index: 28)
                ui6 (copy, index: 29)
                ui7 (copy, index: 30)
                v69 (copy, index: 31)
                v80 (copy, index: 32)
                parent8 (copy, index: 33)
                ui11 (copy, index: 34)
                ui13 (copy, index: 35)
                ui16 (copy, index: 36)
                parent9 (copy, index: 37)
                parent10 (copy, index: 38)
                v89 (copy, index: 39)
                v91 (copy, index: 40)
                ui14 (copy, index: 41)
                v86 (copy, index: 42)
                ui15 (copy, index: 43)
                v94 (copy, index: 44)
                ui17 (copy, index: 45)
                RankArt (copy, index: 46)
                v99 (copy, index: 47)
                v100 (copy, index: 48)
                ui18 (copy, index: 49)
                v343 (ref,  index: 50)
                formattedText2 (copy, index: 51)
                visible (ref,  index: 52)
            ]]
            local text
            local v346
            local v347
            local v348
            local v349 = v220
            if not v349 then
                return
            end

            local v350 = stateOf(v349)
            local v351 = economy.Level(v349)
            local v352, v353 = economy.Progress(v349)
            local startValue = economy.CategoryColor(v349)
            local visible2 = v350 == "locked"
            local v356 = v340 ~= nil and v340.id == v349

            if v342 ~= v349 then
                v342 = v349
                weaponIcon.Set(ui3, v349, {spin = true, outline = true, glow = false, outlineScale = 1.035, outlineTransparency = 0.5, outlineColor = startValue:Lerp(Color3.new(1, 1, 1), 0.55)})
                ui.Pop(ui3, 0.85, theme.Tween.PopSmall)
            end

            weaponIcon.SetDim(ui3, visible2)
            parent7.Text = string.upper(weaponInfo.Name(v349))
            local v357 = weaponInfo.Get(v349)
            local stringUpper = string.upper

            if v357 then
                text = weaponInfo.CATEGORY_SINGULAR[v357.category] or ""
            else
                text = ""
            end

            local uppercaseText = stringUpper(text)

            if visible2 then
                a19.Loc.Rich(ui9, string.format("%s  <font color=\"%s\">·  LOCKED</font>", uppercaseText, formattedText))
            elseif v350 == "max" then
                a19.Loc.Rich(ui9, string.format("%s  <font color=\"%s\">·  MAX LEVEL</font>", uppercaseText, v34))
            elseif v350 == "fixed" then
                a19.Loc.Rich(ui9, string.format("%s  <font color=\"%s\">·  NO LEVELS</font>", uppercaseText, formattedText))
            else
                local rich = a19.Loc.Rich
                local stringFormat = string.format
                local textDim = colors.TextDim
                rich(ui9, stringFormat("%s  <font color=\"%s\">·  LEVEL %d OF %d</font>", uppercaseText, string.format("#%02X%02X%02X", math.floor((textDim.R * 255) + 0.5), math.floor((textDim.G * 255) + 0.5), (math.floor((textDim.B * 255) + 0.5))), v351, maxLevel))
            end

            local v363 = v350 == "fixed"

            if visible2 then
                v346 = colors.TextMuted
            elseif v350 ~= "ready" then
                v346 = if v350 == "max" then gold else startValue
            else
                v346 = success
            end

            local v364 = visible2 and 0.18 or 0.35
            v61.Color = ColorSequence.new(v346:Lerp(colors.Panel, 1 - v364), colors.PanelHi:Lerp(colors.Panel, 0.6))
            v62.ImageColor3 = v346
            v62.ImageTransparency = visible2 and 0.8 or 0.5
            uiGradient.Color = ColorSequence.new(v346:Lerp(colors.Panel, 0.9), colors.PanelLo)

            if v350 ~= "ready" then
                v347 = if v350 == "max" then gold else colors.Stroke
            else
                v347 = success
            end

            uiStroke.Color = v347
            uiStroke.Transparency = v350 ~= "ready" and v350 ~= "max" and 0.88 or 0.55
            parent6.Visible = visible2
            parent4.Visible = not visible2

            if not v356 then
                if v350 ~= "max" then
                    local v365
                    parent4.BackgroundColor3 = colors.Void
                    parent4.BackgroundTransparency = 0.2
                    ui5.Text = "LV"
                    ui5.TextSize = 14
                    ui5.TextColor3 = colors.TextDim
                    ui5.Size = udim2FromOffset(22, 34)
                    parent5.Visible = true
                    ui6.Text = tostring(v351)
                    ui6.Position = UDim2.new()
                    ui6.TextColor3 = colors.Text
                    ui7.Text = ""

                    if not (10 <= v351) then
                        v365 = 70
                    else
                        v365 = 90
                    end

                    parent4.Size = udim2FromOffset(v365, 34)
                else
                    parent4.BackgroundColor3 = gold
                    parent4.BackgroundTransparency = 0
                    ui5.Text = "MAX"
                    ui5.TextSize = 18
                    ui5.TextColor3 = colors.TextDark
                    ui5.Size = udim2FromOffset(52, 34)
                    parent5.Visible = false
                    parent4.Size = udim2FromOffset(76, 34)
                end

                v69.Color = if v350 == "ready" then success else colors.Stroke
                v69.Transparency = v350 ~= "ready" and 0.8 or 0.2
            end

            local v366 = not (0 < v353) and 1 or math.clamp(v352 / v353, 0, 1)

            if v350 ~= "max" then
                if v363 then
                    v80.Set(0, true)
                    parent8.Text = "NO LEVELS"
                    ui11.Text = ""
                else
                    if not v356 then
                        local v367
                        v80.Set(v366)
                        local setColor = v80.SetColor

                        if v350 ~= "ready" then
                            v367 = if visible2 then colors.AccentDark else colors.Accent
                        else
                            v367 = success
                        end

                        setColor(v367)
                        parent8.Text = string.format("%d / %d", v352, v353)
                    end

                    ui11.Text = visible2 and "TO UNLOCK" or "TO LEVEL " .. v351 + 1
                    ui11.TextColor3 = if v350 == "ready" then theme.Lighten(success, 0.15) else colors.TextDim
                end
            else
                v80.Set(1, true)
                v80.SetColor(gold)
                parent8.Text = "MAX"
                ui11.Text = "MAX LEVEL"
                ui11.TextColor3 = gold
            end

            local text2 = economy.StatWord(v349) or "damage"
            ui13.Text = v363 and "NO LEVEL BONUS" or string.upper(text2) .. " BONUS"
            local loc = a19.Loc
            local text6 = loc.Pick(text2 .. " (bonus)", text2)
            ui16.Text = text6
            parent9.Visible = not v363
            parent10.Visible = not v363
            local v372 = visible2 and 0 or economy.BonusPercent(v351)
            local v373 = economy.BonusPercent((math.min(maxLevel, math.max(v351, 1) + 1)))

            if not v356 then
                v89(v372, true)
                v91(v373, true)
            end

            if visible2 then
                v348 = colors.TextMuted
            else
                v348 = if v350 == "max" then gold else colors.Text
            end

            ui14.TextColor3 = v348
            v86.Visible = (v350 ~= "max") and not visible2
            ui15.Visible = (v350 ~= "max") and not visible2

            if not v356 then
                for v374, v375 in v94 do
                    local v376
                    local backgroundTransparency
                    local v378 = v374 <= v351

                    if v378 then
                        v376 = if v350 == "max" then gold else colors.Accent
                    else
                        v376 = if v374 == v351 + 1 and v350 == "ready" then success else colors.Inset
                    end

                    v375.BackgroundColor3 = v376

                    if v378 or v374 == v351 + 1 and v350 == "ready" then
                        backgroundTransparency = 0
                    else
                        backgroundTransparency = 0.1
                    end

                    v375.BackgroundTransparency = backgroundTransparency
                end
            end

            local flooredValue = math.floor((economy.BONUS_PER_LEVEL * 100) + 0.5)

            if v363 then
                ui17.Text = loc.T("Nothing on this item scales with levels: it's the same for everyone, and it never drops once you own it.")
            elseif visible2 and not economy.RankAllows(v349) then
                local v380 = RankArt.Ranks.Get(economy.ItemRank(v349))
                ui17.Text = loc.T(string.format("Joins your drops at %s (%s trophies). Win matches to climb the Rank Road.", v380.name, ui.FormatNumber(v380.trophies)))
            elseif visible2 and economy.MaxLevel(v349) <= 1 then
                ui17.Text = loc.T("Nothing on this item scales with levels: unlock it once and it's yours.")
            elseif visible2 then
                ui17.Text = loc.T(string.format("Unlocks at level 1. Each level after that adds +%d%% %s, up to +%d%%.", flooredValue, text6, economy.MaxBonusPercent()))
            elseif v350 ~= "max" then
                if not (v351 <= 1) then
                    ui17.Text = loc.T(string.format("Level %d adds another +%d%% %s (max +%d%%).", v351 + 1, flooredValue, text6, economy.MaxBonusPercent()))
                else
                    ui17.Text = loc.T(string.format("Level %d adds +%d%% %s.", v351 + 1, flooredValue, text6))
                end
            else
                ui17.Text = loc.T(string.format("Maxed out: +%d%% %s for good. The cap may rise in a later update.", v372, text6))
            end

            local v381 = math.max(0, v353 - v352)
            v99.ImageTransparency = 1

            if visible2 and not economy.RankAllows(v349) then
                local v382 = economy.ItemRank(v349)
                v100:SetStyle("Dark")
                v100:SetEnabled(true)
                v100:SetText("UNLOCKS AT " .. string.upper(RankArt.Ranks.Get(v382).name))
                ui18.Text = loc.T("See the Rank Road")
            elseif visible2 then
                local v383 = economy.ItemKey(v349)
                local canBuy = economy.CanBuy(v383)
                local v385 = economy.Pending(v383)

                if canBuy then
                    v100:SetStyle("Primary")
                    v100:SetEnabled(not v385)
                    local text3 = v385 and "UNLOCKING…"
                        or string.format("UNLOCK NOW   <font color=\"%s\">%s</font> %s", "#FFFFFF", economy.ROBUX, economy.PriceAmount(v383))
                    v100:SetText(text3)
                    local t = loc.T
                    local stringFormat = string.format
                    local v389 = v381 ~= 1 and "s" or ""
                    ui18.Text = t(stringFormat("or find %d more shard%s in drops", v381, v389))
                else
                    v100:SetStyle("Dark")
                    v100:SetEnabled(false)
                    local stringFormat = string.format
                    local v391 = v381 ~= 1 and "S" or ""
                    v100:SetText(stringFormat("FIND %d MORE SHARD%s", v381, v391))
                    ui18.Text = loc.T("Win matches to find shards")
                end
            elseif v350 == "max" or v363 then
                v100:SetStyle("Dark")
                v100:SetEnabled(false)
                local text4 = v363 and "NO UPGRADES" or "MAX LEVEL"
                v100:SetText(text4)
                ui18.Text = loc.T("It won't drop any more: shards go to your other items")
            elseif v350 == "ready" then
                local v393 = v343 == v349 or economy.Upgrading(v349)
                v100:SetStyle("Success")
                v100:SetEnabled(not v393)
                local text5 = v393 and "UPGRADING…" or string.format("UPGRADE TO LV %d", v351 + 1)
                v100:SetText(text5)
                ui18.Text = loc.T(string.format("Spends %d shards  ·  <font color=\"%s\">%s</font>", v353, formattedText2, loc.T(economy.BonusText(v349, v351 + 1))))
            else
                v100:SetStyle("Dark")
                v100:SetEnabled(false)
                local stringFormat = string.format
                local v396 = v381 ~= 1 and "S" or ""
                v100:SetText(stringFormat("NEED %d MORE SHARD%s", v381, v396))
                ui18.Text = loc.T("Win matches to find shards")
            end

            ui18.Visible = visible

            if v356 then
                v100:SetEnabled(false)
            end
        end

        local function layoutWindow()
            --[[
              name: layoutWindow
              line: 1443
              upvalues:
                ui (copy, index: 1)
                v53 (copy, index: 2)
                udim2FromOffset (copy, index: 3)
                ui2 (copy, index: 4)
                layoutPanel (copy, index: 5)
                parent (copy, index: 6)
                v103 (ref,  index: 7)
                parent12 (copy, index: 8)
                parent13 (copy, index: 9)
                parent14 (copy, index: 10)
                v121 (copy, index: 11)
                v122 (copy, index: 12)
                v123 (copy, index: 13)
                parent16 (copy, index: 14)
                ui19 (copy, index: 15)
                ui20 (copy, index: 16)
            ]]
            local v398
            local v399 = ui.CanvasSize()
            local v400 = ui.TopInset()
            local compact = ui.Compact

            if compact then
                v53.Holder.Size = udim2FromOffset(math.floor((math.clamp(v399.X - 24, 340, 1180))), (math.floor((math.clamp((v399.Y - v400) - 12, 300, 720)))))
            else
                v53.Holder.Size = udim2FromOffset(math.floor((math.clamp(v399.X - 160, 1180, 1400))), (math.floor((math.clamp((v399.Y - v400) - 40, 720, 940)))))
            end

            v53.Subtitle.Visible = true
            v53.Subtitle.TextSize = compact and 15 or 17
            ui2.TextSize = compact and 14 or 16
            local newUDim2 = UDim2.new
            local v403 = -(ui.WindowCloseSize() + 34)
            local v404 = compact and 18 or 22
            ui2.Position = newUDim2(1, v403, 0, v404)
            local v405 = v53.Holder.Size.X.Offset - 44
            local v406 = v53.Holder.Size.Y.Offset - 80 - 32
            local v407 = compact and 300 or math.clamp(math.floor(v405 * 0.28), 330, 390)
            local v408 = compact and 14 or 20
            layoutPanel(v407, v406, compact)
            parent.Position = udim2FromOffset(0, 0)
            v103 = (v405 - v407) - v408
            parent12.Position = udim2FromOffset(v407 + v408, 0)
            parent12.Size = UDim2.new(0, v103, 1, 0)
            local v409 = v103 - 12
            local v410 = compact and 92 or 104
            parent13.Size = UDim2.new(1, -12, 0, v410)
            local v411 = compact and 64 or 76
            local v412 = compact and 64 or 76
            parent14.Size = udim2FromOffset(v411, v412)
            local v413 = compact and 104 or 122
            local v414 = compact and 138 or 150
            local v415 = compact and 152 or 166
            v121.Instance.Size = udim2FromOffset(v413, 46)
            v122.Instance.Size = udim2FromOffset(v414, 46)
            v123.Instance.Size = udim2FromOffset(v415, 46)
            local v416 = (v413 + v414) + v415 + 20
            parent16.Size = udim2FromOffset(v416, 50)
            local v417 = compact and 64 or 76
            local v418 = v417 + 28
            local v419 = compact and 12 or 18
            ui19.Position = udim2FromOffset(v418, v419)
            ui19.TextSize = compact and 21 or 24
            local v420 = compact and 40 or 48
            ui20.Position = udim2FromOffset(v418, v420)
            local v421 = math.max(160, ((v409 - v418) - v416) - 28)

            if compact then
                v398 = 44
            else
                v398 = 42
            end

            ui20.Size = udim2FromOffset(v421, v398)
            ui20.TextSize = compact and 13 or 14
        end

        local function layoutGrid(a423: boolean?)
            --[[
              name: layoutGrid
              line: 1484
              upvalues:
                v103 (ref,  index: 1)
                ui (copy, index: 2)
                targets (copy, index: 3)
                v221 (ref,  index: 4)
                economy (copy, index: 5)
                parent13 (copy, index: 6)
                udim2FromOffset (copy, index: 7)
                v113 (copy, index: 8)
                v114 (copy, index: 9)
                a19 (copy, index: 10)
                formattedText (copy, index: 11)
                theme (copy, index: 12)
                parent12 (copy, index: 13)
            ]]
            local v424
            local v425
            local v426 = v103 - 12
            local clampedValue = math.clamp(math.floor((v426 + 12) / 162), 2, 7)
            local flooredValue = math.floor((v426 - ((clampedValue - 1) * 12)) / clampedValue)

            if ui.Compact then
                v424 = 30
            else
                v424 = 34
            end

            local h = ui.Compact and 184 or 212
            local v430 = {owned = {}, locked = {}}
            local v431 = {}

            for v432, v433 in targets do
                v431[v433] = v432
                v221(v433)
                v433.section = v433.state ~= "locked" and "owned" or "locked"
                table.insert(v430[v433.section], v433)
            end

            table.sort(
                v430.owned,
                function(left, right)
                    --[[
                      line: 1499
                      upvalues:
                        v431 (copy, index: 1)
                    ]]
                    local v436 = left.state == "ready"

                    if v436 == (right.state == "ready") then
                        return v431[left] < v431[right]
                    end

                    return v436
                end
            )

            local function frac(a438)
                --[[
                  name: frac
                  line: 1506
                  upvalues:
                    economy (copy, index: 1)
                ]]
                local v439, v440 = economy.Progress(a438.id)
                return v439 / math.max(v440, 1), v440
            end

            table.sort(
                v430.locked,
                function(left, right)
                    --[[
                      line: 1510
                      upvalues:
                        economy (copy, index: 1)
                        v431 (copy, index: 2)
                    ]]
                    local v443, v444 = economy.Progress(left.id)
                    local v445 = v443 / math.max(v444, 1)
                    local v446 = v444
                    local v447, v448 = economy.Progress(right.id)
                    local v449 = v447 / math.max(v448, 1)
                    local v450 = v448

                    if v445 ~= v449 then
                        return v449 < v445
                    end
                    if v446 ~= v450 then
                        return v446 < v450
                    end

                    return v431[left] < v431[right]
                end
            )

            local v451 = 0
            local visible = economy.DropsAllowed()
            parent13.Visible = visible

            if visible then
                parent13.Position = udim2FromOffset(4, 4)
                v451 = parent13.Size.Y.Offset + 14
            end

            v425 = v451

            for _, v454 in v113 do
                local v455 = v430[v454]
                local v456 = v114[v454]
                v456.frame.Visible = 0 < #v455

                if 0 < #v455 then
                    local v457 = v454 ~= "owned" and "LOCKED" or "YOUR ITEMS"
                    a19.Loc.Rich(v456.title, string.format("%s  <font color=\"%s\">·  %d</font>", v457, formattedText, #v455))
                    v456.sub.TextSize = ui.Compact and 13 or 14
                    v456.frame.Size = UDim2.new(1, -8, 0, v424)
                    v456.frame.Position = udim2FromOffset(4, v425)
                    v425 += v424

                    for v458, v459 in v455 do
                        local v460 = false
                        local v461 = (v458 - 1) % clampedValue
                        v459.y = v425 + ((v458 - 1) // clampedValue * (h + 12))
                        v459.h = h
                        v459.visible = true
                        v459.holder.Visible = true
                        local position = udim2FromOffset((v461 * (flooredValue + 12)) + 4, v459.y + 4)

                        if a423 then
                            if v459.shown then
                                if v459.holder.Position == position then
                                    v460 = true
                                else
                                    ui.Tween(v459.holder, theme.Tween.Smooth, {Position = position})
                                end
                            else
                                v460 = true
                            end
                        else
                            v460 = true
                        end

                        if v460 then
                            v459.holder.Position = position
                        end

                        v459.holder.Size = udim2FromOffset(flooredValue, h)
                        v459.glow.Size = udim2FromOffset(math.floor(flooredValue * 1.05), 150)
                        v459.glow.Position = UDim2.new(0.5, 0, 0, math.floor((h - 88) / 2) + 6)
                    end

                    v425 += (math.ceil(#v455 / clampedValue) * (h + 12)) + 12
                end
            end

            for _, v464 in targets do
                v464.shown = v464.visible
            end

            parent12.CanvasSize = udim2FromOffset(0, v425 + 8)
        end

        local function paintSummary()
            --[[
              name: paintSummary
              line: 1565
              upvalues:
                weaponInfo (copy, index: 1)
                economy (copy, index: 2)
                formattedText (copy, index: 3)
                formattedText2 (copy, index: 4)
                a19 (copy, index: 5)
                ui2 (copy, index: 6)
            ]]
            local count = 0
            local count2 = 0

            for _, v469 in weaponInfo.AllItems() do
                count += 1

                if economy.Owns(v469.id) then
                    count2 += 1
                end
            end

            local v470 = economy.UpgradesReady()
            local v471 = string.format("%d / %d <font color=\"%s\">UNLOCKED</font>", count2, count, formattedText)

            if 0 < v470 then
                local stringFormat = string.format
                local v473 = v470 ~= 1 and "S" or ""
                v471 ..= stringFormat("   <font color=\"%s\">·   %d UPGRADE%s READY</font>", formattedText2, v470, v473)
            end

            a19.Loc.Rich(ui2, v471)
        end

        local v474 = function(a475: boolean?)
            --[[
              line: 1581
              upvalues:
                layoutGrid (copy, index: 1)
                v344 (ref,  index: 2)
                paintShop (copy, index: 3)
                paintSummary (copy, index: 4)
                queueVisible (copy, index: 5)
            ]]
            layoutGrid(a475)
            v344()
            paintShop()
            paintSummary()
            task.defer(queueVisible)
        end

        local function flashCard(a477, a478)
            --[[
              name: flashCard
              line: 1590
              upvalues:
                colors (copy, index: 1)
                ui (copy, index: 2)
            ]]
            a477.flash.BackgroundColor3 = a478 or colors.Accent
            a477.flash.BackgroundTransparency = 0.65
            local v479 = {BackgroundTransparency = 1}
            ui.Tween(a477.flash, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v479)
        end

        v222 = function(key, a481)
            --[[
              line: 1596
              upvalues:
                v219 (copy, index: 1)
                v220 (ref,  index: 2)
                v221 (ref,  index: 3)
                v344 (ref,  index: 4)
                ui (copy, index: 5)
                ui3 (copy, index: 6)
                theme (copy, index: 7)
            ]]
            if not v219[key] then
                return
            end

            local v482 = v220 and v219[v220]
            v220 = key

            if v482 then
                v221(v482)
            end

            v221(v219[key])
            v344()

            if type(a481) ~= "table" or not a481.quiet then
                ui.Pop(ui3, 0.9, theme.Tween.PopSmall)
            end
        end

        local function shardBurst(a484)
            --[[
              name: shardBurst
              line: 1613
              upvalues:
                ui (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                theme (copy, index: 3)
                parent3 (copy, index: 4)
            ]]
            local v485 = ui.Touch and 9 or 14

            for index = 1, v485 do
                local v487 = ((index / v485) * math.pi) * 2 + math.random() * 0.4
                local v488 = 0.32 + math.random() * 0.22
                local v489 = math.random(12, 22)
                local image = ui.Image
                local shard = ui.Assets.Fx.Shard
                local v492 = {ImageTransparency = 0.05, ZIndex = 7, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = udim2FromOffset(v489, v489), Rotation = math.random(0, 360), ImageColor3 = if index % 3 == 0 then theme.Lighten(a484, 0.25) else a484}
                v492.Parent = parent3
                local v493 = image(shard, v492)
                local tweenInfo = TweenInfo.new(0.6 + (math.random() * 0.25), Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                ui.Tween(v493, tweenInfo, {ImageTransparency = 1, Position = UDim2.fromScale(0.5 + (math.cos(v487) * v488), 0.52 + ((math.sin(v487) * v488) * 0.9)), Rotation = v493.Rotation + math.random(-160, 160), Size = udim2FromOffset(v489 * 0.5, v489 * 0.5)})
                task.delay(
                    1,
                    function()
                        --[[
                          line: 1636
                          upvalues:
                            v493 (copy, index: 1)
                        ]]
                        v493:Destroy()
                    end
                )
            end
        end

        local function levelUpMoment(id, a497, a498)
            --[[
              name: levelUpMoment
              line: 1642
              upvalues:
                count (ref,  index: 1)
                v340 (ref,  index: 2)
                maxLevel (copy, index: 3)
                gold (copy, index: 4)
                success (copy, index: 5)
                v80 (copy, index: 6)
                ui4 (copy, index: 7)
                ui (copy, index: 8)
                parent2 (copy, index: 9)
                v65 (copy, index: 10)
                udim2FromOffset (copy, index: 11)
                shardBurst (copy, index: 12)
                v62 (copy, index: 13)
                ui3 (copy, index: 14)
                theme (copy, index: 15)
                a19 (copy, index: 16)
                parent4 (copy, index: 17)
                colors (copy, index: 18)
                ui5 (copy, index: 19)
                parent5 (copy, index: 20)
                ui6 (copy, index: 21)
                ui7 (copy, index: 22)
                v69 (copy, index: 23)
                v67 (copy, index: 24)
                economy (copy, index: 25)
                v89 (copy, index: 26)
                v91 (copy, index: 27)
                ui14 (copy, index: 28)
                v94 (copy, index: 29)
                parent8 (copy, index: 30)
                v219 (copy, index: 31)
                flashCard (copy, index: 32)
                v474 (ref,  index: 33)
            ]]
            local text
            count += 1
            local token = count
            v340 = {id = id, token = token}
            local v501 = maxLevel <= a498
            local v502 = if v501 then gold else success
            v80.SetColor(success)
            v80.Set(1, false, TweenInfo.new(0.18, Enum.EasingStyle.Quad))
            ui4.BackgroundColor3 = v502
            ui4.BackgroundTransparency = 0.55
            local v503 = {BackgroundTransparency = 1}
            ui.Tween(ui4, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v503)
            local offset = parent2.Size.X.Offset
            v65.ImageColor3 = v502
            v65.Size = udim2FromOffset(60, 60)
            v65.ImageTransparency = 0.15
            ui.Tween(v65, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1, Size = udim2FromOffset(offset * 1.4, offset * 1.4)})
            shardBurst(v502)
            v62.ImageColor3 = v502
            v62.ImageTransparency = 0.2
            local v505 = {ImageTransparency = 0.5}
            ui.Tween(v62, TweenInfo.new(0.9, Enum.EasingStyle.Quad), v505)
            ui.Pop(ui3, 0.7, theme.Tween.Slam)
            a19.Sounds.Play("LevelUp")
            parent4.BackgroundColor3 = colors.Void
            parent4.BackgroundTransparency = 0.2
            ui5.Text = "LV"
            ui5.TextSize = 14
            ui5.TextColor3 = colors.TextDim
            ui5.Size = udim2FromOffset(22, 34)
            parent5.Visible = true
            parent4.Size = udim2FromOffset(70, 34)
            ui6.Text = tostring(a497)
            ui6.TextColor3 = colors.Text
            ui6.Position = UDim2.new()
            ui7.Text = tostring(a498)
            ui7.TextColor3 = gold
            ui7.Position = UDim2.fromScale(0, 1)
            v69.Color = gold
            v69.Transparency = 0

            task.delay(
                0.12,
                function()
                    --[[
                      line: 1683
                      upvalues:
                        token (copy, index: 1)
                        count (ref,  index: 2)
                        a19 (copy, index: 3)
                        ui (copy, index: 4)
                        ui6 (copy, index: 5)
                        ui7 (copy, index: 6)
                        parent4 (copy, index: 7)
                        theme (copy, index: 8)
                    ]]
                    if token ~= count then
                        return
                    end

                    a19.Sounds.Play("XP_Tick")
                    local tweenInfo = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    ui.Tween(ui6, tweenInfo, {Position = UDim2.fromScale(0, -1)})
                    ui.Tween(ui7, tweenInfo, {Position = UDim2.new()})

                    task.delay(
                        0.3,
                        function()
                            --[[
                              line: 1691
                              upvalues:
                                token (copy, index: 1)
                                count (ref,  index: 2)
                                ui (copy, index: 3)
                                parent4 (copy, index: 4)
                                theme (copy, index: 5)
                            ]]
                            if token == count then
                                ui.Pop(parent4, 1.45, theme.Tween.Slam)
                            end
                        end
                    )
                end
            )

            if v501 then
                text = "MAX LEVEL"
            else
                text = "LEVEL " .. a498
            end

            v67.Text = text
            v67.TextColor3 = if v501 then gold else theme.Lighten(success, 0.2)
            v67.Visible = true
            ui.Unfade(v67)
            ui.Pop(v67, 1.9, theme.Tween.Slam)
            local v507 = economy.BonusPercent(a498)
            local v508 = economy.BonusPercent((math.min(maxLevel, a498 + 1)))

            task.delay(
                0.25,
                function()
                    --[[
                      line: 1706
                      upvalues:
                        token (copy, index: 1)
                        count (ref,  index: 2)
                        v89 (copy, index: 3)
                        v507 (copy, index: 4)
                        v91 (copy, index: 5)
                        v508 (copy, index: 6)
                        ui (copy, index: 7)
                        ui14 (copy, index: 8)
                        v94 (copy, index: 9)
                        a498 (copy, index: 10)
                        v501 (copy, index: 11)
                        gold (copy, index: 12)
                        colors (copy, index: 13)
                        theme (copy, index: 14)
                    ]]
                    if token ~= count then
                        return
                    end

                    v89(v507)
                    v91(v508)
                    ui.Bump(ui14, 0.2)

                    for v509, v510 in v94 do
                        if v509 == a498 then
                            v510.BackgroundColor3 = if v501 then gold else colors.Accent
                            v510.BackgroundTransparency = 0
                            ui.Pop(v510, 1.8, theme.Tween.Slam)
                        end
                    end
                end
            )

            task.delay(
                0.35,
                function()
                    --[[
                      line: 1721
                      upvalues:
                        token (copy, index: 1)
                        count (ref,  index: 2)
                        economy (copy, index: 3)
                        id (copy, index: 4)
                        v80 (copy, index: 5)
                        v501 (copy, index: 6)
                        gold (copy, index: 7)
                        colors (copy, index: 8)
                        parent8 (copy, index: 9)
                    ]]
                    if token ~= count then
                        return
                    end

                    local v511, v512 = economy.Progress(id)
                    v80.Set(0, true)
                    local setColor = v80.SetColor
                    local v514 = if v501 then gold else colors.Accent
                    setColor(v514)
                    local set = v80.Set
                    local v516 = not (0 < v512) and 1 or v511 / v512
                    set(v516, false, TweenInfo.new(0.5, Enum.EasingStyle.Quint))
                    parent8.Text = v501 and "MAX" or string.format("%d / %d", v511, v512)
                end
            )

            if const v517 = v219[id] then
                flashCard(v517, v502)
                ui.Pop(v517.icon, 0.8, theme.Tween.PopSmall)
            end

            task.delay(
                1.15,
                function()
                    --[[
                      line: 1736
                      upvalues:
                        token (copy, index: 1)
                        count (ref,  index: 2)
                        ui (copy, index: 3)
                        v67 (copy, index: 4)
                    ]]
                    if token ~= count then
                        return
                    end

                    ui.FadeOut(v67, TweenInfo.new(0.3))
                end
            )

            task.delay(
                1.5,
                function()
                    --[[
                      line: 1742
                      upvalues:
                        token (copy, index: 1)
                        count (ref,  index: 2)
                        v340 (ref,  index: 3)
                        v67 (copy, index: 4)
                        ui (copy, index: 5)
                        v474 (ref,  index: 6)
                    ]]
                    if token ~= count then
                        return
                    end

                    v340 = nil
                    v67.Visible = false
                    ui.Unfade(v67)
                    v474(true)
                end
            )
        end

        v223 = function(id, a519, a520)
            --[[
              line: 1754
              upvalues:
                v343 (ref,  index: 1)
                economy (copy, index: 2)
                state (copy, index: 3)
                a19 (copy, index: 4)
                v340 (ref,  index: 5)
                count (ref,  index: 6)
                v344 (ref,  index: 7)
                ui (copy, index: 8)
                v220 (ref,  index: 9)
                v222 (ref,  index: 10)
                levelUpMoment (copy, index: 11)
                parent11 (copy, index: 12)
                v474 (ref,  index: 13)
            ]]
            if v343 or not economy.CanUpgrade(id) then
                return
            end

            if state.InMatch() then
                a19.Toast("Upgrade in the lobby", "warning")
                return
            end

            v343 = id
            local v521 = economy.Level(id)
            v340 = {id = id, token = count}
            v344()

            task.spawn(
                function()
                    --[[
                      line: 1768
                      upvalues:
                        economy (copy, index: 1)
                        id (copy, index: 2)
                        ui (copy, index: 3)
                        a519 (copy, index: 4)
                        a520 (copy, index: 5)
                        v343 (ref,  index: 6)
                        v220 (ref,  index: 7)
                        v222 (ref,  index: 8)
                        levelUpMoment (copy, index: 9)
                        v521 (copy, index: 10)
                        v340 (ref,  index: 11)
                        parent11 (copy, index: 12)
                        v474 (ref,  index: 13)
                        v344 (ref,  index: 14)
                    ]]
                    local v522, v523 = economy.Upgrade(id, "collection", ui.PressKind(a519, a520))
                    v343 = nil

                    if v522 then
                        if v220 ~= id then
                            v222(id, {quiet = true})
                        end

                        levelUpMoment(id, v521, (v523 or (v521 + 1)))
                    else
                        v340 = nil
                        ui.Shake(parent11, 6)
                        v474(true)
                    end

                    v344()
                end
            )
        end

        v100.Activated:Connect(
            function(a524)
                --[[
                  line: 1784
                  upvalues:
                    v220 (ref,  index: 1)
                    stateOf (copy, index: 2)
                    v223 (ref,  index: 3)
                    v100 (copy, index: 4)
                    economy (copy, index: 5)
                    a19 (copy, index: 6)
                    v344 (ref,  index: 7)
                ]]
                local v525 = v220
                if not v525 then
                    return
                end

                local v526 = stateOf(v525)

                if v526 == "ready" then
                    v223(v525, a524, v100.Instance)
                    return
                end

                if v526 == "locked" and not economy.RankAllows(v525) then
                    a19.Sounds.Play("Click")

                    if a19.RankRoad then
                        a19.RankRoad.Focus(economy.ItemRank(v525))
                    else
                        a19.EnsureScreen("RankRoad")

                        if a19.RankRoad then
                            a19.RankRoad.Focus(economy.ItemRank(v525))
                        end
                    end

                    a19.MenuManager.Open("Ranks")

                    return
                end

                if v526 == "locked" then
                    local v527 = economy.ItemKey(v525)

                    if economy.CanBuy(v527) then
                        economy.Buy(v527)
                        v344()
                    end
                end
            end
        )

        runService.Heartbeat:Connect(
            function()
                --[[
                  line: 1813
                  upvalues:
                    v53 (copy, index: 1)
                    targets (copy, index: 2)
                    v220 (ref,  index: 3)
                    stateOf (copy, index: 4)
                    v340 (ref,  index: 5)
                    v343 (ref,  index: 6)
                    scaleObj (copy, index: 7)
                    v99 (copy, index: 8)
                ]]
                if not v53.IsOpen then
                    return
                end

                local v528 = math.sin(os.clock() * 4.2) * 0.5 + 0.5

                for _, v530 in targets do
                    if v530.state == "ready" then
                        if not v530.visible then
                            continue
                        end

                        if v220 ~= v530.id then
                            v530.stroke.Transparency = (v528 * 0.45) + 0.1
                        end

                        v530.upScale.Scale = (v528 * 0.035) + 1
                        v530.upGlow.ImageTransparency = ((1 - v528) * 0.35) + 0.45
                    end
                end

                local v531 = v220

                if v531 and stateOf(v531) == "ready" and not v340 and v343 == nil then
                    scaleObj.Scale = (v528 * 0.025) + 1
                    v99.ImageTransparency = ((1 - v528) * 0.4) + 0.45

                    return
                end

                if scaleObj.Scale ~= 1 then
                    scaleObj.Scale = 1
                    v99.ImageTransparency = 1
                end
            end
        )

        local v532 = false

        do
            local v533 = {}

            local function stepAside(key: string, a536)
                --[[
                  name: stepAside
                  line: 1841
                  upvalues:
                    v533 (copy, index: 1)
                    v53 (copy, index: 2)
                    v532 (ref,  index: 3)
                    v342 (ref,  index: 4)
                    v474 (ref,  index: 5)
                    v220 (ref,  index: 6)
                    v219 (copy, index: 7)
                    flashCard (copy, index: 8)
                ]]
                local v537 = next(v533) ~= nil
                v533[key] = a536 and true or nil
                local v538 = next(v533) ~= nil

                if v538 == v537 then
                    return
                end

                if v538 and v53.IsOpen then
                    v53.Holder.Visible = false
                    return
                end

                if not v538 then
                    v53.Holder.Visible = true

                    if v53.IsOpen and v532 then
                        v342 = nil
                        v474(true)

                        if const v539 = v220 and v219[v220] then
                            flashCard(v539)
                        end
                    end
                end
            end

            economy.Changed:Connect(
                function()
                    --[[
                      line: 1862
                      upvalues:
                        v53 (copy, index: 1)
                        v532 (ref,  index: 2)
                        v340 (ref,  index: 3)
                        v474 (ref,  index: 4)
                        paintShop (copy, index: 5)
                    ]]
                    if v53.IsOpen and v532 and not v340 then
                        v474(true)
                        return
                    end

                    if v53.IsOpen and v532 then
                        paintShop()
                    end
                end
            )

            ui.Every(
                v53.Root,
                1,
                function()
                    --[[
                      line: 1870
                      upvalues:
                        v53 (copy, index: 1)
                        v532 (ref,  index: 2)
                        economy (copy, index: 3)
                        paintShop (copy, index: 4)
                    ]]
                    if v53.IsOpen and v532 and economy.OfferLeft() then
                        paintShop()
                    end
                end
            )

            economy.CelebrationChanged:Connect(
                function(a540)
                    --[[
                      line: 1877
                      upvalues:
                        stepAside (copy, index: 1)
                    ]]
                    stepAside("unlock", a540)
                end
            )
            economy.RevealChanged:Connect(
                function(a541)
                    --[[
                      line: 1880
                      upvalues:
                        stepAside (copy, index: 1)
                    ]]
                    stepAside("reveal", a541)
                end
            )
        end

        economy.Event:Connect(
            function(a542, a543)
                --[[
                  line: 1883
                  upvalues:
                    v53 (copy, index: 1)
                    v219 (copy, index: 2)
                    v222 (ref,  index: 3)
                ]]
                if a542 == "Unlocked" and type(a543.item) == "string" and v53.IsOpen and v219[a543.item] then
                    v222(a543.item, {quiet = true})
                end
            end
        )

        do
            local function isGamepad()
                --[[
                  name: isGamepad
                  line: 1889
                  upvalues:
                    ui (copy, index: 1)
                ]]
                return ui.Gamepad
            end
        end

        local function firstTarget()
            --[[
              name: firstTarget
              line: 1892
              upvalues:
                targets (copy, index: 1)
            ]]
            local v546

            for _, v548 in targets do
                if v548.visible then
                    if not v546
                        or v548.y < v546.y
                        or v548.y == v546.y
                            and v548.holder.Position.X.Offset < v546.holder.Position.X.Offset
                    then
                        v546 = v548
                    end
                end
            end

            return v546 and v546.holder or nil
        end

        do
            local function defaultSelection()
                --[[
                  name: defaultSelection
                  line: 1902
                  upvalues:
                    economy (copy, index: 1)
                    v219 (copy, index: 2)
                    firstTarget (copy, index: 3)
                ]]
                local v550 = economy.ReadyList()

                if v550[1] then
                    return v550[1]
                end

                local v551 = economy.Spotlight()

                if v551 and v219[v551] then
                    return v551
                end

                local v552 = firstTarget()

                return v552 and v552.Name or nil
            end
        end

        a19.MenuManager.Register(
            "Collection",
            {
                open = (function(a553)
                    --[[
                      name: open
                      line: 1916
                      upvalues:
                        layoutWindow (copy, index: 1)
                        v532 (ref,  index: 2)
                        weaponInfo (copy, index: 3)
                        makeCard (copy, index: 4)
                        targets (copy, index: 5)
                        v219 (copy, index: 6)
                        v342 (ref,  index: 7)
                        ancestor (copy, index: 8)
                        v8 (ref,  index: 9)
                        textChatService (copy, index: 10)
                        starterGui (copy, index: 11)
                        v53 (copy, index: 12)
                        economy (copy, index: 13)
                        openOdds (copy, index: 14)
                        layoutGrid (copy, index: 15)
                        v220 (ref,  index: 16)
                        firstTarget (copy, index: 17)
                        v474 (ref,  index: 18)
                        parent12 (copy, index: 19)
                        v103 (ref,  index: 20)
                        ui (copy, index: 21)
                        flashCard (copy, index: 22)
                        queueVisible (copy, index: 23)
                        udim2FromOffset (copy, index: 24)
                        guiService (copy, index: 25)
                    ]]
                    layoutWindow()

                    if not v532 then
                        v532 = true

                        for _, v555 in weaponInfo.AllItems() do
                            local card = makeCard(v555)
                            table.insert(targets, card)
                            v219[v555.id] = card
                        end
                    end

                    v342 = nil
                    ancestor.Visible = false

                    if not v8 then
                        local v557 = {}

                        pcall(
                            function()
                                --[[
                                  line: 46
                                  upvalues:
                                    textChatService (copy, index: 1)
                                    v557 (copy, index: 2)
                                    starterGui (copy, index: 3)
                                ]]
                                if textChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then
                                    v557.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                                else
                                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                    if chatWindowConfiguration then
                                        v557.window = chatWindowConfiguration.Enabled
                                        chatWindowConfiguration.Enabled = false
                                    end

                                    if chatInputBarConfiguration then
                                        v557.bar = chatInputBarConfiguration.Enabled
                                        chatInputBarConfiguration.Enabled = false
                                    end
                                end
                            end
                        )

                        v8 = v557
                    end

                    v53:Open()
                    local focus = type(a553) == "table"
                        and type(a553.focus) == "string"
                        and v219[a553.focus]
                        and a553.focus
                        or nil

                    if type(a553) == "table" and a553.odds == true and economy.DropsAllowed() then
                        task.delay(0.15, openOdds)
                    end

                    task.defer(
                        function()
                            --[[
                              line: 1934
                              upvalues:
                                targets (copy, index: 1)
                                layoutGrid (copy, index: 2)
                                v220 (ref,  index: 3)
                                focus (copy, index: 4)
                                economy (copy, index: 5)
                                v219 (copy, index: 6)
                                firstTarget (copy, index: 7)
                                v474 (ref,  index: 8)
                                parent12 (copy, index: 9)
                                v103 (ref,  index: 10)
                                ui (copy, index: 11)
                                flashCard (copy, index: 12)
                                queueVisible (copy, index: 13)
                                udim2FromOffset (copy, index: 14)
                                guiService (copy, index: 15)
                            ]]
                            local v561

                            for _, v563 in targets do
                                v563.shown = false
                            end

                            layoutGrid(false)
                            local v564 = focus

                            if focus then
                                v564 = focus
                            elseif const v565 = if 0 < economy.UpgradesReady() then nil else v220 then
                                v564 = v565
                            else
                                local v566 = economy.ReadyList()

                                if v566[1] then
                                    v564 = v566[1]
                                else
                                    v566 = economy.Spotlight()

                                    if v566 and v219[v566] then
                                        v564 = v566
                                    else
                                        local v567 = firstTarget()
                                        v564 = v567 and v567.Name or nil
                                    end
                                end
                            end

                            v220 = v564
                            v474(false)

                            if v220 then
                                v561 = v219[v220]
                                v561 = v561 or nil
                            else
                                v561 = nil
                            end

                            local y = 0

                            if v561 and focus then
                                local v569
                                local v570 = math.max(parent12.AbsoluteSize.X / math.max(v103, 1), 0.01)
                                local v571 = math.max(0, parent12.AbsoluteCanvasSize.Y - parent12.AbsoluteWindowSize.Y)

                                if ui.Compact then
                                    v569 = 30
                                else
                                    v569 = 34
                                end

                                y = math.min(math.max(0, (v561.y - v569) - 4) * v570, v571)
                                task.delay(
                                    0.25,
                                    function()
                                        --[[
                                          line: 1950
                                          upvalues:
                                            flashCard (copy, index: 1)
                                            v561 (copy, index: 2)
                                        ]]
                                        flashCard(v561)
                                    end
                                )
                            end

                            parent12.CanvasPosition = Vector2.new(0, y)
                            queueVisible()
                            local v572 = 0
                            local v573 = v572

                            for _, v575 in targets do
                                if v575.visible and v575.y < 520 then
                                    v575.inner.Position = udim2FromOffset(0, 14)
                                    ui.Tween(v575.inner, TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, (math.min(v573 * 0.018, 0.2))), {Position = UDim2.new()})
                                    v573 += 1
                                end
                            end

                            if ui.Gamepad then
                                guiService.SelectedObject = if v561 then v561.holder else firstTarget()
                            end
                        end
                    )
                end),
                close = (function(a576)
                    --[[
                      name: close
                      line: 1969
                      upvalues:
                        v8 (ref,  index: 1)
                        textChatService (copy, index: 2)
                        starterGui (copy, index: 3)
                        ancestor (copy, index: 4)
                        guiService (copy, index: 5)
                        v53 (copy, index: 6)
                    ]]
                    if const v577 = v8 then
                        v8 = nil

                        pcall(
                            function()
                                --[[
                                  line: 71
                                  upvalues:
                                    textChatService (copy, index: 1)
                                    v577 (copy, index: 2)
                                    starterGui (copy, index: 3)
                                ]]
                                local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                if chatWindowConfiguration and v577.window ~= nil then
                                    chatWindowConfiguration.Enabled = v577.window
                                end

                                if chatInputBarConfiguration and v577.bar ~= nil then
                                    chatInputBarConfiguration.Enabled = v577.bar
                                end

                                if v577.core ~= nil then
                                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v577.core)
                                end
                            end
                        )
                    end

                    ancestor.Visible = false
                    local selectedObject = guiService.SelectedObject

                    if selectedObject and selectedObject:IsDescendantOf(v53.Root) then
                        guiService.SelectedObject = nil
                    end

                    v53:Close(a576)
                end),
                back = (function()
                    --[[
                      name: back
                      line: 1979
                      upvalues:
                        ancestor (copy, index: 1)
                        guiService (copy, index: 2)
                        v121 (copy, index: 3)
                    ]]
                    if not ancestor.Visible then
                        return false
                    end

                    if ancestor.Visible then
                        ancestor.Visible = false
                        local selectedObject = guiService.SelectedObject

                        if selectedObject and selectedObject:IsDescendantOf(ancestor) then
                            guiService.SelectedObject = v121.Instance
                        end
                    end

                    return true
                end)
            }
        )

        v53.Closed:Connect(restoreChat)

        state.PlayerStateChanged:Connect(
            function(a582)
                --[[
                  line: 1988
                  upvalues:
                    a19 (copy, index: 1)
                ]]
                if a582 == "Match" and a19.MenuManager.IsOpen("Collection") then
                    a19.MenuManager.Close("Collection", true)
                end
            end
        )

        do
            local function relayout()
                --[[
                  name: relayout
                  line: 1993
                  upvalues:
                    v53 (copy, index: 1)
                    layoutWindow (copy, index: 2)
                    v342 (ref,  index: 3)
                    v474 (ref,  index: 4)
                ]]
                if v53.IsOpen then
                    layoutWindow()
                    v53.Refit()
                    v342 = nil
                    task.defer(v474)
                end
            end

            ui.LayoutChanged:Connect(relayout)
            ui.OnResize(relayout)
        end

        a19.Debug.collection = function(a584, focus: number, a586, a587)
            --[[
              line: 2008
              upvalues:
                v220 (ref,  index: 1)
                a19 (copy, index: 2)
                v222 (ref,  index: 3)
                v100 (copy, index: 4)
                economy (copy, index: 5)
                paintShop (copy, index: 6)
                openOdds (copy, index: 7)
                ancestor (copy, index: 8)
                guiService (copy, index: 9)
                v121 (copy, index: 10)
                parent12 (copy, index: 11)
                v219 (copy, index: 12)
                firstTarget (copy, index: 13)
                levelUpMoment (copy, index: 14)
                targets (copy, index: 15)
                v53 (copy, index: 16)
                parent13 (copy, index: 17)
                parent18 (copy, index: 18)
                v340 (ref,  index: 19)
                v103 (ref,  index: 20)
            ]]
            local v588

            if type(focus) ~= "string" then
                v588 = v220
            else
                v588 = focus
            end

            if a584 == "open" then
                local v589
                local open = a19.MenuManager.Open

                if type(focus) ~= "string" then
                    v589 = nil
                else
                    v589 = {focus = focus}
                end

                open("Collection", v589)
            elseif a584 == "select" and type(focus) == "string" then
                v222(focus)
            elseif a584 == "upgrade" and v588 then
                if v220 ~= v588 then
                    v222(v588, {quiet = true})
                end

                v100.Activated:Fire(a586, 0)
            elseif a584 == "unlock" and v588 then
                if v220 ~= v588 then
                    v222(v588, {quiet = true})
                end

                v100.Activated:Fire()
            elseif a584 == "buy" then
                local v591 = focus ~= 5 and 1 or 5

                if economy.DropsAllowed() then
                    economy.Buy(economy.DropKey(v591))
                    paintShop()
                end
            elseif a584 == "odds" then
                openOdds()
            elseif a584 == "closeOdds" then
                if ancestor.Visible then
                    ancestor.Visible = false
                    local selectedObject = guiService.SelectedObject

                    if selectedObject and selectedObject:IsDescendantOf(ancestor) then
                        guiService.SelectedObject = v121.Instance
                    end
                end
            elseif a584 == "scroll" and type(focus) == "number" then
                parent12.CanvasPosition = Vector2.new(0, focus)
            elseif a584 == "gamepad" then
                guiService.SelectedObject = v220 and v219[v220] and v219[v220].holder or firstTarget()
            elseif a584 == "mock" then
                local setMock = economy.SetMock
                local v594 = if focus == false then nil else focus
                setMock(v594)
            elseif a584 == "reveal" then
                economy.SetRevealShowing(focus == true)
            elseif a584 == "levelup" and type(focus) == "string" then
                if v220 ~= focus then
                    v222(focus, {quiet = true})
                end

                levelUpMoment(focus, (tonumber(a586) or 1), (tonumber(a587) or 2))
            end

            local count = 0
            local count2 = 0
            local v597 = {locked = 0, owned = 0, ready = 0, max = 0}

            for _, v599 in targets do
                if v599.rendered then
                    count += 1
                end

                v597[v599.state] = (v597[v599.state] or 0) + 1
            end

            for _, descendant in v53.Root:GetDescendants() do
                if descendant:IsA("ViewportFrame") then
                    count2 += 1
                end
            end

            local progress
            local level
            local v604, v605 = false, false
            local v606 = v220
            local v607 = 0
            local v608 = 0
            local v609 = "?"

            if v606 then
                v607, v608, v609 = economy.Progress(v606)
            end

            local v610 = {open = v53.IsOpen, selected = v606 or false}

            if v606 then
                level = economy.Level(v606)

                if not level then
                    v604 = true
                end
            else
                v604 = true
            end

            if v604 then
                level = false
            end

            v610.level = level

            if v606 then
                progress = string.format("%d/%d %s", v607, v608, v609)

                if not progress then
                    v605 = true
                end
            else
                v605 = true
            end

            if v605 then
                progress = false
            end

            local gamepadSelected
            v610.progress = progress
            v610.action = v100.Label.Text
            v610.actionEnabled = v100.Enabled
            v610.cards = #targets
            v610.rendered = count
            v610.viewports = count2
            v610.locked = v597.locked
            v610.owned = v597.owned
            v610.ready = v597.ready
            v610.max = v597.max
            v610.shop = parent13.Visible
            v610.odds = ancestor.Visible
            v610.oddsRows = #parent18:GetChildren()
            v610.animating = v340 ~= nil
            v610.grid = string.format("%dx%d", v103, (math.floor(parent12.AbsoluteWindowSize.Y / math.max(parent12.AbsoluteSize.X / math.max(v103, 1), 0.01))))
            v610.canvas = math.floor(parent12.CanvasSize.Y.Offset)

            if guiService.SelectedObject then
                gamepadSelected = guiService.SelectedObject:GetFullName()
            else
                gamepadSelected = false
            end

            v610.gamepadSelected = gamepadSelected
            v610.mock = economy.Mock ~= nil

            return v610
        end
    end
end

return v7