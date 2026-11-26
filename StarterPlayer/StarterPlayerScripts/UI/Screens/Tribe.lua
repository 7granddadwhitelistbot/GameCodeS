local players = game:GetService("Players")
local guiService = game:GetService("GuiService")
local httpService = game:GetService("HttpService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "Tribes"
local child = require(shared:WaitForChild(childName))
local TribeArt = require(shared:WaitForChild("TribeArt"))
local TribeMapGrid = require(shared:WaitForChild("TribeMapGrid"))
local v10 = {}
local v11 = {left = 360, gap = 20, row = 64, text = 18, sub = 14, tab = 40, cell = 58, swatch = 34, hero = 214}
local v12 = {left = 320, gap = 14, row = 60, text = 17, sub = 13, tab = 40, cell = 50, swatch = 30, hero = 132}
local textColor3 = Color3.fromRGB(142, 149, 166)
local backgroundColor3 = Color3.fromRGB(10, 11, 15)
local textColor32 = Color3.fromRGB(255, 186, 46)
Color3.fromRGB(150, 98, 10)
local v16 = {chief = {text = "CHIEF", color = Color3.fromRGB(196, 136, 20)}, elder = {text = "ELDER", color = Color3.fromRGB(28, 110, 220)}}
local v17 = {open = "OPEN", request = "REQUEST", invite = "INVITE ONLY"}
local v18 = {open = "Anyone can join", request = "Players ask, Elders accept", invite = "Only players you invite"}
local v19 = {0, 5, 10, 20, 30, 50}

local function ago(a21)
    --[[
      name: ago
      line: 52
    ]]
    if type(a21) ~= "number" or a21 <= 0 then
        return ""
    end

    local v22 = math.max(0, os.time() - a21)

    if v22 < 60 then
        return "just now"
    end
    if v22 < 3600 then
        return (`{v22 // 60}m ago`)
    end
    if v22 < 86400 then
        return (`{v22 // 3600}h ago`)
    end

    return (`{v22 // 86400}d ago`)
end

local function untilText(a24)
    --[[
      name: untilText
      line: 67
    ]]
    if type(a24) ~= "number" then
        return ""
    end

    local v25 = math.max(0, a24 - os.time())

    if 86400 <= v25 then
        return (`{v25 // 86400}d {(v25 % 86400) // 3600}h`)
    end
    if 3600 <= v25 then
        return (`{v25 // 3600}h {(v25 % 3600) // 60}m`)
    end

    return (`{(math.max(1, v25 // 60))}m`)
end

function v10.Init(a26)
    --[[
      name: Init
      line: 80
      upvalues:
        players (copy, index: 1)
        v12 (copy, index: 2)
        v11 (copy, index: 3)
        textColor3 (copy, index: 4)
        httpService (copy, index: 5)
        guiService (copy, index: 6)
        backgroundColor3 (copy, index: 7)
        child (copy, index: 8)
        textColor32 (copy, index: 9)
        untilText (copy, index: 10)
        v16 (copy, index: 11)
        v17 (copy, index: 12)
        ago (copy, index: 13)
        TribeMapGrid (copy, index: 14)
        TribeArt (copy, index: 15)
        v18 (copy, index: 16)
        v19 (copy, index: 17)
    ]]
    local v27
    local ui = a26.UI
    local theme = a26.Theme
    local state = a26.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local tribes = a26.Tribes
    local menuManager = a26.MenuManager
    local localPlayer = players.LocalPlayer
    local udim2FromOffset = UDim2.fromOffset

    if ui.Compact then
        v27 = v12
    else
        v27 = v11
    end

    local TribeEmblem = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem.Init(ui)
    local glow = ui.Assets.Icons.Glow
    local v39 = ui.Window(
        {
            Name = "Tribe",
            Title = "TRIBES",
            Subtitle = "Play together, earn Glory, hold the maps",
            HeaderHeight = 80,
            Size = udim2FromOffset(1180, 700),
            Parent = a26.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 99
                  upvalues:
                    menuManager (copy, index: 1)
                ]]
                menuManager.Close("Tribe")
            end)
        }
    )
    local content = v39.Content
    ui.SelectionRing(v39.Root)
    local ui2 = ui.new("TextLabel", {Name = "HeadInfo", Text = "", RichText = true, TextSize = 15, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -96, 0, 34), Size = udim2FromOffset(320, 22), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v39.Header})
    local v42 = nil
    local v43 = false
    local v44 = nil
    local v45 = nil

    local function roleIn(a47)
        --[[
          name: roleIn
          line: 127
          upvalues:
            localPlayer (copy, index: 1)
            tribes (copy, index: 2)
        ]]
        local v48

        if type(a47) ~= "table" or type(a47.membersList) ~= "table" then
            v48 = {}
        else
            v48 = a47.membersList
        end

        for _, v50 in v48 do
            if v50.userId == localPlayer.UserId then
                return (tostring(v50.role))
            end
        end

        return if const v51 = tribes.Mine() then v51.role else "member"
    end

    do
        local function myTribe()
            --[[
              name: myTribe
              line: 136
              upvalues:
                v42 (ref,  index: 1)
                roleIn (copy, index: 2)
                tribes (copy, index: 3)
            ]]
            local tribe = v42 and v42.tribe

            if type(tribe) ~= "table" then
                return tribes.Mine()
            end

            return {id = tribe.id, role = roleIn(tribe)}
        end
    end

    local timestamp = -math.huge

    do
        local function settled()
            --[[
              name: settled
              line: 144
              upvalues:
                timestamp (ref, index: 1)
            ]]
            return 0.5 <= os.clock() - timestamp
        end
    end

    local function label(a57)
        --[[
          name: label
          line: 149
          upvalues:
            fonts (copy, index: 1)
            colors (copy, index: 2)
            ui (copy, index: 3)
        ]]
        local values
        local values2 = table.clone(a57)

        if (values2.Name == "Name" or values2.Name == "Tag") and values2.AutoLocalize == nil then
            values2.AutoLocalize = false
        end

        values2.FontFace = values2.FontFace or fonts.Bold
        values = values2
        values.TextColor3 = values.TextColor3 or colors.Text
        values.TextXAlignment = values.TextXAlignment or Enum.TextXAlignment.Left
        values.TextTruncate = values.TextTruncate or Enum.TextTruncate.AtEnd

        return ui.new("TextLabel", values)
    end

    local function caps(text, options)
        --[[
          name: caps
          line: 163
          upvalues:
            label (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local v63 = options or {}
        local v64 = {Name = v63.Name or "Caption", Text = text, FontFace = fonts.Heavy, TextSize = v63.TextSize or 12, TextColor3 = v63.TextColor3
            or colors.TextMuted, TextXAlignment = v63.TextXAlignment or Enum.TextXAlignment.Left}
        local v65 = v63.Size or UDim2.new(1, 0, 0, 14)
        v64.Size = v65
        v64.Position = v63.Position
        v64.AnchorPoint = v63.AnchorPoint
        v64.LayoutOrder = v63.LayoutOrder or 0
        v64.ZIndex = v63.ZIndex
        v64.Parent = v63.Parent

        return label(v64)
    end

    local function section(text: string, a68, a69, layoutOrder, parent, a72)
        --[[
          name: section
          line: 182
          upvalues:
            ui (copy, index: 1)
            udim2FromOffset (copy, index: 2)
            colors (copy, index: 3)
            textColor3 (copy, index: 4)
            label (copy, index: 5)
            fonts (copy, index: 6)
        ]]
        local parent2 = ui.new("Frame", {Name = "Section_" .. text, Size = UDim2.new(1, -6, 0, 22), LayoutOrder = layoutOrder, Parent = parent})
        local newUi = ui.new
        local v75 = {Name = "Bar", Size = udim2FromOffset(4, 16), Position = udim2FromOffset(0, 3), BackgroundColor3 = a72
            or colors.Accent, [1] = (ui.Corner(2)), Parent = parent2}
        newUi("Frame", v75)
        local text2 = string.format("<font color=\"#%s\">%s</font>", colors.TextDim:ToHex(), string.upper(text))

        if a68 ~= nil then
            text2 ..= string.format("  <font color=\"#%s\">·  %s</font>", colors.TextMuted:ToHex(), (tostring(a68)))
        end

        if a69 and a69 ~= "" then
            text2 ..= string.format("    <font color=\"#%s\" weight=\"600\">%s</font>", textColor3:ToHex(), a69)
        end

        label({Name = "Text", RichText = true, TextSize = 15, Text = text2, FontFace = fonts.Heavy, Position = udim2FromOffset(12, 0), Size = UDim2.new(1, -12, 1, 0), Parent = parent2})

        return parent2
    end

    local function card(name, parent, options)
        --[[
          name: card
          line: 196
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
        ]]
        local v81 = options or {}
        local newUi = ui.new
        local v83 = {Name = name, BackgroundColor3 = v81.Color or colors.PanelHi, BackgroundTransparency = v81.Transparency
            or 0.35}
        local udim2 = v81.Size or UDim2.new(1, -6, 0, 0)
        v83.Size = udim2
        v83.AutomaticSize = v81.AutomaticSize or Enum.AutomaticSize.Y
        v83.LayoutOrder = v81.LayoutOrder or 0
        v83[1], v83[2] = ui.Corner(12), (ui.Stroke(colors.Stroke, 1, 0.92))
        v83.Parent = parent

        return newUi("Frame", v83)
    end

    local function column(name: string, parent, a88: number)
        --[[
          name: column
          line: 215
          upvalues:
            ui (copy, index: 1)
        ]]
        return ui.new("ScrollingFrame", {Name = name, ScrollBarThickness = 3, Selectable = false, ui.List(Enum.FillDirection.Vertical, a88
            or 10), (ui.Padding(4, 8, 10, 4)), Parent = parent})
    end

    local function clear(a90)
        --[[
          name: clear
          line: 228
        ]]
        for _, child in a90:GetChildren() do
            if child:IsA("GuiObject") then
                child:Destroy()
            end
        end
    end

    do
        local function sigOf(a94)
            --[[
              name: sigOf
              line: 236
              upvalues:
                httpService (copy, index: 1)
            ]]
            local success, result = pcall(httpService.JSONEncode, httpService, a94)
            if success then
                return result
            end

            return (tostring(os.clock()))
        end
    end

    local function smallButton(text, style: string, parent, callback, options)
        --[[
          name: smallButton
          line: 241
          upvalues:
            ui (copy, index: 1)
            udim2FromOffset (copy, index: 2)
            timestamp (ref,  index: 3)
        ]]
        local v103 = options or {}
        local button = ui.Button
        local v105 = {Radius = 10, Name = v103.Name or text, Text = text, Style = style, TextSize = v103.TextSize
            or 16, Icon = v103.Icon}
        local v106 = v103.Size or udim2FromOffset((v103.Width or 104), (v103.Height or 40))
        v105.Size = v106
        v105.LayoutOrder = v103.LayoutOrder or 0
        v105.AnchorPoint = v103.AnchorPoint
        v105.Position = v103.Position
        v105.Parent = parent
        local v107 = button(v105)

        v107.Activated:Connect(
            function()
                --[[
                  line: 256
                  upvalues:
                    timestamp (ref,  index: 1)
                    callback (copy, index: 2)
                ]]
                if 0.5 <= os.clock() - timestamp then
                    callback()
                end
            end
        )

        if v103.Enabled == false then
            v107:SetEnabled(false)
        end

        return v107
    end

    do
        local function tagText(a109)
            --[[
              name: tagText
              line: 267
              upvalues:
                TribeEmblem (copy, index: 1)
            ]]
            local v110
            local tag = TribeEmblem.Tag

            if type(a109) ~= "table" then
                v110 = a109
            else
                v110 = a109.tag
            end

            return tag(v110)
        end
    end

    do
        local function tribeLine(a113)
            --[[
              name: tribeLine
              line: 272
              upvalues:
                TribeEmblem (copy, index: 1)
            ]]
            local v114
            local stringFormat = string.format
            local v116 = TribeEmblem.TagColor(a113.color1):ToHex()
            local tag = TribeEmblem.Tag

            if type(a113) ~= "table" then
                v114 = a113
            else
                v114 = a113.tag
            end

            return stringFormat("<font color=\"#%s\">%s</font>  %s", v116, tag(v114), (tostring(a113.name or "")))
        end
    end

    local function heroTile(parent, a120, layoutOrder: number)
        --[[
          name: heroTile
          line: 277
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            glow (copy, index: 3)
        ]]
        local parent2 = ui.new("Frame", {Name = "Hero", Size = UDim2.new(1, 0, 0, a120), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, LayoutOrder = layoutOrder, (ui.Corner(12)), Parent = parent})
        local v123 = ui.Gradient(colors.Accent, colors.Panel, 115)
        v123.Parent = parent2
        local v124 = ui.Image(glow, {Name = "Glow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46), Size = UDim2.fromScale(1.15, 1.35), Parent = parent2})
        local accent = colors.Accent
        v123.Color = ColorSequence.new(accent:Lerp(colors.Panel, 0.45), colors.Panel:Lerp(colors.PanelLo, 0.5))
        v124.ImageColor3 = accent

        return parent2,
            function(imageColor3)
                --[[
                  name: tint
                  line: 290
                  upvalues:
                    v123 (copy, index: 1)
                    colors (copy, index: 2)
                    v124 (copy, index: 3)
                ]]
                v123.Color = ColorSequence.new(imageColor3:Lerp(colors.Panel, 0.45), colors.Panel:Lerp(colors.PanelLo, 0.5))
                v124.ImageColor3 = imageColor3
            end
    end

    local function statTile(parent, text: string, layoutOrder: number)
        --[[
          name: statTile
          line: 299
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            label (copy, index: 3)
            fonts (copy, index: 4)
            udim2FromOffset (copy, index: 5)
            caps (copy, index: 6)
        ]]
        local textSize
        local parent2 = ui.new("Frame", {Name = "Stat_" .. text, Size = UDim2.new(0.3333333333333333, -6, 1, 0), LayoutOrder = layoutOrder, BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.35, (ui.Corner(10)), Parent = parent})
        local v133 = {Name = "Value", Text = "-", FontFace = fonts.Display}

        if ui.Compact then
            textSize = 20
        else
            textSize = 24
        end

        v133.TextSize = textSize
        v133.TextXAlignment = Enum.TextXAlignment.Center
        local v134 = ui.Compact and 5 or 8
        v133.Position = udim2FromOffset(0, v134)
        v133.Size = UDim2.new(1, 0, 0, 26)
        v133.Parent = parent2
        local v135 = label(v133)
        caps(text, {TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 1, -22), Size = UDim2.new(1, 0, 0, 14), Parent = parent2})

        return v135
    end

    local parent = ui.new("Frame", {Name = "Tabs", Size = UDim2.new(1, 0, 0, v27.tab), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = content})
    local parent2 = ui.new("Frame", {Name = "Pages", Position = udim2FromOffset(0, v27.tab + 14), Size = UDim2.new(1, 0, 1, -(v27.tab + 14)), Parent = content})
    local v138 = {}
    local v139 = {}
    local target = nil
    local v141 = {}

    local function makeTab(name: string, text: string, a145: string)
        --[[
          name: makeTab
          line: 333
          upvalues:
            ui (copy, index: 1)
            udim2FromOffset (copy, index: 2)
            v27 (ref,  index: 3)
            colors (copy, index: 4)
            theme (copy, index: 5)
            parent (copy, index: 6)
            fonts (copy, index: 7)
            parent2 (copy, index: 8)
            v138 (copy, index: 9)
        ]]
        local ui2 = ui.new("TextButton", {Name = name, Text = "", AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, v27.tab), BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.4, ui.Corner(theme.Radius.Pill), ui.Padding(0, 18, 0, 14), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
        local icon = ui.Glyph(a145, 20, colors.TextDim, {LayoutOrder = 1, Parent = ui2})
        local text2 = ui.new("TextLabel", {Name = "Text", TextSize = 16, LayoutOrder = 2, Text = text, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = ui2})
        local page = ui.new("Frame", {Visible = false, Name = name, Size = UDim2.fromScale(1, 1), Parent = parent2})
        local v150 = {button = ui2, text = text2, icon = icon, page = page}
        v138[name] = v150

        return v150
    end

    local function paintTabs()
        --[[
          name: paintTabs
          line: 365
          upvalues:
            v138 (copy, index: 1)
            target (ref,  index: 2)
            colors (copy, index: 3)
        ]]
        for v152, v153 in v138 do
            local v154 = v152 == target
            v153.button.BackgroundColor3 = if v154 then colors.Accent else colors.Raised
            v153.button.BackgroundTransparency = v154 and 0 or 0.4
            v153.text.TextColor3 = if v154 then colors.Text else colors.TextDim
            v153.icon.TextColor3 = if v154 then colors.Text else colors.TextDim
        end
    end

    local function showTab(a156)
        --[[
          name: showTab
          line: 375
          upvalues:
            v138 (copy, index: 1)
            target (ref,  index: 2)
            paintTabs (copy, index: 3)
            ui (copy, index: 4)
            v141 (copy, index: 5)
        ]]
        if not v138[a156] then
            return
        end

        local v157 = target
        target = a156

        for v158, v159 in v138 do
            v159.page.Visible = v158 == a156
        end

        paintTabs()

        if v157 ~= a156 then
            ui.SlideIn(v138[a156].page, Vector2.new(0, 12), TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
        end

        if v141[a156] then
            task.spawn(v141[a156])
        end
    end

    local function setTabs(tabs)
        --[[
          name: setTabs
          line: 393
          upvalues:
            v139 (ref,  index: 1)
            v138 (copy, index: 2)
            target (ref,  index: 3)
            showTab (copy, index: 4)
        ]]
        v139 = tabs

        for target2, v163 in v138 do
            local index = table.find(tabs, target2)
            v163.button.Visible = index ~= nil
            v163.button.LayoutOrder = index or 99
        end

        if (not target or not table.find(tabs, target)) and target ~= "Form" and target ~= "View" then
            showTab(tabs[1])
        end
    end

    local tab = makeTab("Find", "FIND A TRIBE", "magnifying-glass")
    local tab2 = makeTab("Overview", "MY TRIBE", "shield-check")
    local tab3 = makeTab("Members", "MEMBERS", "three-people")
    local tab4 = makeTab("Leaderboard", "LEADERBOARD", "trophy")
    local tab5 = makeTab("Territories", "TERRITORIES", "location-pin-map")
    local tab6 = makeTab("Form", "", "pencil")
    tab6.button.Visible = false
    local tab7 = makeTab("View", "", "eye")
    tab7.button.Visible = false

    for v172, v173 in v138 do
        v173.button.Activated:Connect(
            function()
                --[[
                  line: 417
                  upvalues:
                    target (ref,  index: 1)
                    v172 (copy, index: 2)
                    timestamp (ref,  index: 3)
                    a26 (copy, index: 4)
                    showTab (copy, index: 5)
                ]]
                if target ~= v172 and 0.5 <= os.clock() - timestamp then
                    a26.Sounds.Play("Click")
                    showTab(v172)
                end
            end
        )

        v173.button.MouseEnter:Connect(
            function()
                --[[
                  line: 423
                  upvalues:
                    target (ref,  index: 1)
                    v172 (copy, index: 2)
                    ui (copy, index: 3)
                    v173 (copy, index: 4)
                    theme (copy, index: 5)
                ]]
                if target ~= v172 and not ui.Touch then
                    ui.Tween(v173.button, theme.Tween.Fast, {BackgroundTransparency = 0.15})
                end
            end
        )

        v173.button.MouseLeave:Connect(
            function()
                --[[
                  line: 428
                  upvalues:
                    ui (copy, index: 1)
                    v173 (copy, index: 2)
                    theme (copy, index: 3)
                    target (ref,  index: 4)
                    v172 (copy, index: 5)
                ]]
                local backgroundTransparency
                local tween = ui.Tween
                local button = v173.button
                local fast = theme.Tween.Fast
                local v178 = {}

                if target ~= v172 then
                    backgroundTransparency = 0.4
                else
                    backgroundTransparency = 0
                end

                v178.BackgroundTransparency = backgroundTransparency
                tween(button, fast, v178)
            end
        )
    end

    local parent3 = ui.new("TextButton", {Name = "DialogDim", Text = "", AutoButtonColor = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, Visible = false, ZIndex = 20, Selectable = false, (ui.Corner(16)), Parent = v39.Body})
    local parent4 = ui.new("Frame", {Name = "Dialog", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(460, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = colors.Panel, ZIndex = 21, ui.Corner(16), ui.Stroke(colors.Stroke, 1, 0.85), ui.Padding(22, 22, 22, 22), (ui.List(Enum.FillDirection.Vertical, 12)), Parent = parent3})
    local dialog = false
    local timestamp2 = 0

    do
        local function closeDialog()
            --[[
              name: closeDialog
              line: 463
              upvalues:
                dialog (ref,  index: 1)
                parent3 (copy, index: 2)
                clear (copy, index: 3)
                parent4 (copy, index: 4)
                ui (copy, index: 5)
                menuManager (copy, index: 6)
            ]]
            dialog = false
            parent3.Visible = false
            clear(parent4)

            if ui.Gamepad then
                menuManager.Reselect()
            end
        end
    end

    parent3.Activated:Connect(
        function()
            --[[
              line: 471
              upvalues:
                timestamp2 (ref,  index: 1)
                dialog (ref,  index: 2)
                parent3 (copy, index: 3)
                clear (copy, index: 4)
                parent4 (copy, index: 5)
                ui (copy, index: 6)
                menuManager (copy, index: 7)
            ]]
            if 0.3 < os.clock() - timestamp2 then
                dialog = false
                parent3.Visible = false
                clear(parent4)

                if ui.Gamepad then
                    menuManager.Reselect()
                end
            end
        end
    )

    local function openDialog(text: string, text2, a187, callback)
        --[[
          name: openDialog
          line: 477
          upvalues:
            clear (copy, index: 1)
            parent4 (copy, index: 2)
            dialog (ref,  index: 3)
            timestamp2 (ref,  index: 4)
            parent3 (copy, index: 5)
            label (copy, index: 6)
            fonts (copy, index: 7)
            colors (copy, index: 8)
            ui (copy, index: 9)
            menuManager (copy, index: 10)
            guiService (copy, index: 11)
        ]]
        local instance
        clear(parent4)
        dialog = true
        timestamp2 = os.clock()
        parent3.Visible = true
        label({Name = "Title", TextSize = 26, ZIndex = 22, LayoutOrder = 1, Text = text, FontFace = fonts.Display, Size = UDim2.new(1, 0, 0, 30), Parent = parent4})

        if text2 and text2 ~= "" then
            label({Name = "Text", TextSize = 17, TextWrapped = true, ZIndex = 22, LayoutOrder = 2, Text = text2, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = parent4})
        end

        if callback then
            local ui2 = ui.new("Frame", {Name = "Extra", LayoutOrder = 3, ZIndex = 22, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = parent4})
            callback(ui2)
        end

        local parent = ui.new("Frame", {Name = "Buttons", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 4, (ui.List(Enum.FillDirection.Vertical, 8)), Parent = parent4})
        instance = nil

        for layoutOrder, v193 in a187 do
            local v194 = ui.Button({TextSize = 18, ZIndex = 23, Name = "B" .. layoutOrder, Text = v193.text, Style = v193.style
                or "Dark", Size = UDim2.new(1, 0, 0, 48), LayoutOrder = layoutOrder, Parent = parent})

            v194.Activated:Connect(
                function()
                    --[[
                      line: 514
                      upvalues:
                        timestamp2 (ref,  index: 1)
                        dialog (ref,  index: 2)
                        parent3 (copy, index: 3)
                        clear (copy, index: 4)
                        parent4 (copy, index: 5)
                        ui (copy, index: 6)
                        menuManager (copy, index: 7)
                        v193 (copy, index: 8)
                    ]]
                    if os.clock() - timestamp2 < 0.25 then
                        return
                    end

                    dialog = false
                    parent3.Visible = false
                    clear(parent4)

                    if ui.Gamepad then
                        menuManager.Reselect()
                    end

                    if v193.fn then
                        task.spawn(v193.fn)
                    end
                end
            )

            if v193.enabled == false then
                v194:SetEnabled(false)
            end

            local instance2 = instance or v194.Instance
            instance = instance2
        end

        ui.Pop(parent4, 0.92)

        if ui.Gamepad and instance then
            guiService.SelectedObject = instance
        end
    end

    local function act(a197: string, ...)
        --[[
          name: act
          line: 535
          upvalues:
            v43 (ref,  index: 1)
            tribes (copy, index: 2)
            a26 (copy, index: 3)
        ]]
        if v43 then
            return false, nil
        end

        v43 = true
        local v198, v199 = tribes.Action(a197, ...)
        v43 = false

        if not v198 then
            a26.Toast(tostring(v199), "error")
        end

        task.spawn(tribes.Home, true)

        return v198, v199
    end

    local parent5 = column("Left", tab.page, 12)
    local parent6 = ui.new("Frame", {Name = "Right", Parent = tab.page})
    local parent7 = ui.new("Frame", {Name = "SearchRow", Size = UDim2.new(1, 0, 0, 46), Parent = parent6})
    local parent8 = ui.new("Frame", {Name = "SearchField", Size = UDim2.new(1, -262, 1, 0), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Stroke, 1, 0.88)), Parent = parent7})
    ui.Glyph("magnifying-glass", 20, colors.TextMuted, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Parent = parent8})
    local ui3 = ui.new("TextBox", {Name = "Search", Text = "", PlaceholderText = "Search a tag or name", ClearTextOnFocus = false, TextSize = 17, BackgroundTransparency = 1, PlaceholderColor3 = colors.TextMuted, FontFace = fonts.Bold, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = udim2FromOffset(46, 0), Size = UDim2.new(1, -60, 1, 0), Parent = parent8})
    local parent9 = ui.new("Frame", {Name = "Sort", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 0), Size = udim2FromOffset(250, 46), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, ui.Corner(theme.Radius.Pill), ui.Padding(4, 4, 4, 4), (ui.List(Enum.FillDirection.Horizontal, 4)), Parent = parent7})
    local v206 = "top"
    local v207 = {}

    for layoutOrder, v209 in {{"top", "TOP"}, {"recruiting", "RECRUITING"}} do
        v207[v209[1]] = ui.new("TextButton", {Name = v209[1], Text = v209[2], AutoButtonColor = false, FontFace = fonts.Heavy, TextSize = 14, TextColor3 = colors.TextDim, Size = UDim2.new(0.5, -2, 1, 0), LayoutOrder = layoutOrder, BackgroundColor3 = colors.Accent, BackgroundTransparency = 1, (ui.Corner(theme.Radius.Pill)), Parent = parent9})
    end

    local parent10 = ui.new("ScrollingFrame", {Name = "List", Position = udim2FromOffset(0, 58), Size = UDim2.new(1, 0, 1, -58), ScrollBarThickness = 3, Selectable = false, ui.List(Enum.FillDirection.Vertical, 8), (ui.Padding(4, 10, 10, 4)), Parent = parent6})
    local parent11 = ui.new("Frame", {Name = "Empty", Visible = false, Position = udim2FromOffset(0, 120), Size = UDim2.new(1, 0, 0, 120), Parent = parent6})
    ui.Glyph("three-people", 48, colors.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = parent11})
    local v212 = label({Name = "Text", Text = "", TextSize = 17, FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Center, Position = udim2FromOffset(0, 60), Size = UDim2.new(1, 0, 0, 24), Parent = parent11})

    local function rowStat(parent, text, text2: string, layoutOrder: number, a218)
        --[[
          name: rowStat
          line: 623
          upvalues:
            ui (copy, index: 1)
            udim2FromOffset (copy, index: 2)
            label (copy, index: 3)
            fonts (copy, index: 4)
            colors (copy, index: 5)
            caps (copy, index: 6)
        ]]
        local parent2 = ui.new("Frame", {Name = "S_" .. text2, Size = udim2FromOffset(78, 40), LayoutOrder = layoutOrder, Parent = parent})
        local v220 = {Name = "Value", TextSize = 18, Text = text, FontFace = fonts.Display, TextColor3 = a218
            or colors.Text, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 22), Parent = parent2}
        label(v220)
        caps(text2, {TextSize = 11, TextXAlignment = Enum.TextXAlignment.Center, Position = udim2FromOffset(0, 23), Size = UDim2.new(1, 0, 0, 13), Parent = parent2})
    end

    local function openable(ui2, a223, a224)
        --[[
          name: openable
          line: 630
          upvalues:
            timestamp (ref,  index: 1)
            a26 (copy, index: 2)
            v45 (ref,  index: 3)
            ui (copy, index: 4)
            theme (copy, index: 5)
        ]]
        ui2.Activated:Connect(
            function()
                --[[
                  line: 631
                  upvalues:
                    timestamp (ref,  index: 1)
                    a26 (copy, index: 2)
                    v45 (ref,  index: 3)
                    a224 (copy, index: 4)
                ]]
                if 0.5 <= os.clock() - timestamp then
                    a26.Sounds.Play("Click")
                    v45(a224.id, a224)
                end
            end
        )

        local transparency = a223.Transparency

        ui2.MouseEnter:Connect(
            function()
                --[[
                  line: 638
                  upvalues:
                    ui (copy, index: 1)
                    a223 (copy, index: 2)
                    theme (copy, index: 3)
                    transparency (copy, index: 4)
                ]]
                if not ui.Touch then
                    ui.Tween(a223, theme.Tween.Fast, {Transparency = math.min(transparency, 0.55)})
                end
            end
        )

        ui2.MouseLeave:Connect(
            function()
                --[[
                  line: 643
                  upvalues:
                    ui (copy, index: 1)
                    a223 (copy, index: 2)
                    theme (copy, index: 3)
                    transparency (copy, index: 4)
                ]]
                ui.Tween(a223, theme.Tween.Fast, {Transparency = transparency})
            end
        )
    end

    local function tribeRow(a227, parent, layoutOrder, callback)
        --[[
          name: tribeRow
          line: 648
          upvalues:
            ui (copy, index: 1)
            v27 (ref,  index: 2)
            colors (copy, index: 3)
            openable (copy, index: 4)
            child (copy, index: 5)
            TribeEmblem (copy, index: 6)
            label (copy, index: 7)
            fonts (copy, index: 8)
            udim2FromOffset (copy, index: 9)
            textColor3 (copy, index: 10)
            rowStat (copy, index: 11)
            textColor32 (copy, index: 12)
        ]]
        local v231
        local v232
        local parent2 = ui.new("TextButton", {Name = "T" .. tostring(a227.id), Text = "", AutoButtonColor = false, Size = UDim2.new(1, -4, 0, v27.row + 8), LayoutOrder = layoutOrder, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.1, ClipsDescendants = true, (ui.Corner(12)), Parent = parent})
        local v234 = ui.Stroke(colors.Stroke, 1, 0.92)
        v234.Parent = parent2
        openable(parent2, v234, a227)
        ui.Gradient(child.Color(a227.color1):Lerp(colors.Panel, 0.8), colors.PanelHi:Lerp(colors.Panel, 0.55), 0).Parent = parent2
        local newTribeEmblem = TribeEmblem.new
        local v236 = v27.row - 2
        local v237 = {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Parent = parent2}
        newTribeEmblem(v236, v237):Set(a227.icon, a227.color1, a227.color2, a227.tag)
        local v238 = v27.row + 20
        local v239 = {Name = "Name", RichText = true}
        local stringFormat = string.format
        local v241 = TribeEmblem.TagColor(a227.color1):ToHex()
        local tag = TribeEmblem.Tag

        if type(a227) ~= "table" then
            v231 = a227
        else
            v231 = a227.tag
        end

        v239.Text = stringFormat("<font color=\"#%s\">%s</font>  %s", v241, tag(v231), (tostring(a227.name or "")))
        v239.FontFace = fonts.Heavy
        v239.TextSize = v27.text
        v239.Position = udim2FromOffset(v238, (math.floor((v27.row + 8) / 2) - v27.text) - 2)
        v239.Size = UDim2.new(1, -(v238 + 400), 0, v27.text + 2)
        v239.Parent = parent2
        label(v239).Name = "Name"
        local text2 = a227.joinMode ~= "invite"
            and (a227.joinMode ~= "request" and "Open to everyone" or "Ask to join")
            or "Invite only"

        if 0 < (tonumber(a227.minLevel) or 0) then
            text2 ..= `  ·  level {a227.minLevel}+`
        end

        label({Name = "Sub", Text = text2, FontFace = fonts.SemiBold, TextSize = v27.sub, TextColor3 = textColor3, Position = udim2FromOffset(v238, math.floor((v27.row + 8) / 2) + 3), Size = UDim2.new(1, -(v238 + 400), 0, v27.sub + 2), Parent = parent2})
        local ui2 = ui.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -160, 0.5, 0), Size = udim2FromOffset(250, 40), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent2})
        rowStat(ui2, `{tonumber(a227.members) or 0}/{child.MAX_MEMBERS}`, "MEMBERS", 1)
        rowStat(ui2, ui.FormatCompact((tonumber(a227.weekRenown) or 0)), "GLORY", 2, textColor32)
        local text = tostring((tonumber(a227.online) or 0))

        if not (0 < (tonumber(a227.online) or 0)) then
            v232 = colors.TextDim
        else
            v232 = colors.Success
        end

        rowStat(ui2, text, "ONLINE", 3, v232)
        callback((ui.new("Frame", {Name = "Action", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = udim2FromOffset(136, 42), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent2})))

        return parent2
    end

    local function joinButton(a247, a248, size: UDim2?)
        --[[
          name: joinButton
          line: 698
          upvalues:
            v42 (ref,  index: 1)
            localPlayer (copy, index: 2)
            smallButton (copy, index: 3)
            openDialog (copy, index: 4)
            TribeEmblem (copy, index: 5)
            act (copy, index: 6)
            child (copy, index: 7)
            a26 (copy, index: 8)
        ]]
        local function sized(a251)
            --[[
              name: sized
              line: 699
              upvalues:
                size (copy, index: 1)
            ]]
            if size then
                a251.Size = size
            end

            return a251
        end

        local v252 = v42 or {}
        local v253 = type(v252.requested) == "table" and table.find(v252.requested, a247.id) ~= nil
        local level = localPlayer:GetAttribute("Level") or 1
        local v255 = type(v252.cooldownUntil) == "number" and os.time() < v252.cooldownUntil

        if v253 then
            local options = {Width = 130, TextSize = 15}

            if size then
                options.Size = size
            end

            smallButton(
                "REQUESTED",
                "Dark",
                a248,
                function()
                    --[[
                      line: 710
                      upvalues:
                        openDialog (copy, index: 1)
                        a247 (copy, index: 2)
                        TribeEmblem (copy, index: 3)
                        act (copy, index: 4)
                    ]]
                    local v257
                    local tag = TribeEmblem.Tag

                    if type(a247) ~= "table" then
                        v257 = a247
                    else
                        v257 = a247.tag
                    end

                    openDialog(
                        "Cancel your request?",
                        `You asked to join {tag(v257)} {(tostring(a247.name))}.`,
                        {
                            {
                                text = "CANCEL REQUEST",
                                style = "Danger",
                                fn = (function()
                                    --[[
                                      name: fn
                                      line: 712
                                      upvalues:
                                        act (copy, index: 1)
                                        a247 (copy, index: 2)
                                    ]]
                                    act("Cancel", a247.id)
                                end)
                            },
                            {text = "KEEP IT"}
                        }
                    )
                end,
                options
            )

            return
        end

        local number = tonumber(a247.members) or 0

        if child.MAX_MEMBERS <= number then
            local callback = function()
                --[[
                  line: 719
                ]]
            end

            local options = {Width = 130, Enabled = false}

            if size then
                options.Size = size
            end

            smallButton("FULL", "Dark", a248, callback, options)

            return
        end

        if a247.joinMode == "invite" then
            local callback = function()
                --[[
                  line: 721
                ]]
            end

            local options = {Width = 130, Enabled = false, TextSize = 14}

            if size then
                options.Size = size
            end

            smallButton("INVITE ONLY", "Dark", a248, callback, options)

            return
        end

        if level < (tonumber(a247.minLevel) or 0) then
            local formattedText = `LV {a247.minLevel}+`

            local callback = function()
                --[[
                  line: 723
                ]]
            end

            local options = {Width = 130, Enabled = false}

            if size then
                options.Size = size
            end

            smallButton(formattedText, "Dark", a248, callback, options)

            return
        end

        local textSize
        local text = a247.joinMode ~= "request" and "JOIN" or "ASK TO JOIN"
        local options = {Width = 130}

        if a247.joinMode ~= "request" then
            textSize = 16
        else
            textSize = 15
        end

        options.TextSize = textSize
        options.Enabled = not v255

        if size then
            options.Size = size
        end

        smallButton(
            text,
            "Dark",
            a248,
            function()
                --[[
                  line: 727
                  upvalues:
                    v255 (copy, index: 1)
                    a26 (copy, index: 2)
                    child (copy, index: 3)
                    act (copy, index: 4)
                    a247 (copy, index: 5)
                    TribeEmblem (copy, index: 6)
                ]]
                if v255 then
                    a26.Toast(child.Message("cooldown"), "error")
                    return
                end

                local v270, v271 = act("Join", a247.id)

                if v270 and type(v271) == "table" then
                    if v271.joined then
                        local v272
                        a26.Sounds.Play("Queue_Join")
                        local toast = a26.Toast
                        local tag = TribeEmblem.Tag

                        if type(a247) ~= "table" then
                            v272 = a247
                        else
                            v272 = a247.tag
                        end

                        toast(`Welcome to {tag(v272)} {(tostring(a247.name))}!`, "success")

                        return
                    end

                    if v271.requested then
                        local v275
                        local toast = a26.Toast
                        local tag = TribeEmblem.Tag

                        if type(a247) ~= "table" then
                            v275 = a247
                        else
                            v275 = a247.tag
                        end

                        toast(`Request sent to {(tag(v275))}`, "info")
                    end
                end
            end,
            options
        )
    end

    local count = 0
    local v279 = nil
    local v280 = nil
    local v281 = nil
    local v282 = ""

    local function rowsSig()
        --[[
          name: rowsSig
          line: 755
          upvalues:
            v42 (ref,  index: 1)
            roleIn (copy, index: 2)
            tribes (copy, index: 3)
            localPlayer (copy, index: 4)
        ]]
        local v284
        local v285
        local cooldownUntil
        local v287 = v42 or {}
        local tribe = v42 and v42.tribe

        if type(tribe) ~= "table" then
            v284 = tribes.Mine()
        else
            v284 = {id = tribe.id, role = roleIn(tribe)}
        end

        local parts = {}

        if type(v287.requested) ~= "table" then
            v285 = {}
        else
            v285 = v287.requested
        end

        for _, v291 in v285 do
            table.insert(parts, (tostring(v291)))
        end

        local v292 = false

        if type(v287.cooldownUntil) == "number" then
            cooldownUntil = v287.cooldownUntil
            v292 = os.time() < cooldownUntil
        end

        local v293 = not v284 and 0 or v284.id

        return (`{v293}|{table.concat(parts, ",")}|{v292}|{localPlayer:GetAttribute("Level") or 1}`)
    end

    local function drawRows(a295, a296: boolean)
        --[[
          name: drawRows
          line: 765
          upvalues:
            v282 (ref,  index: 1)
            rowsSig (copy, index: 2)
            clear (copy, index: 3)
            parent10 (copy, index: 4)
            parent11 (copy, index: 5)
            v212 (copy, index: 6)
            ui3 (copy, index: 7)
            tribeRow (copy, index: 8)
            v42 (ref,  index: 9)
            roleIn (copy, index: 10)
            tribes (copy, index: 11)
            ui (copy, index: 12)
            colors (copy, index: 13)
            smallButton (copy, index: 14)
            v45 (ref,  index: 15)
            joinButton (copy, index: 16)
        ]]
        v282 = rowsSig()
        clear(parent10)
        parent11.Visible = #a295 == 0
        v212.Text = ui3.Text == "" and "No tribes yet. Found the first one!" or "No tribe matches that."

        for layoutOrder, v298 in a295 do
            if type(v298) == "table" then
                local v299 = tribeRow(
                    v298,
                    parent10,
                    layoutOrder,
                    function(parent)
                        --[[
                          line: 772
                          upvalues:
                            v42 (ref,  index: 1)
                            roleIn (copy, index: 2)
                            tribes (copy, index: 3)
                            v298 (copy, index: 4)
                            ui (copy, index: 5)
                            colors (copy, index: 6)
                            smallButton (copy, index: 7)
                            v45 (ref,  index: 8)
                            joinButton (copy, index: 9)
                        ]]
                        local v301
                        local tribe = v42 and v42.tribe

                        if type(tribe) ~= "table" then
                            v301 = tribes.Mine()
                        else
                            v301 = {id = tribe.id, role = roleIn(tribe)}
                        end

                        if v301 and v301.id == v298.id then
                            ui.Pill("YOUR TRIBE", colors.Accent, {Height = 26, TextSize = 12, Parent = parent})
                            return
                        end

                        if v301 then
                            smallButton(
                                "VIEW",
                                "Dark",
                                parent,
                                function()
                                    --[[
                                      line: 778
                                      upvalues:
                                        v45 (ref,  index: 1)
                                        v298 (copy, index: 2)
                                    ]]
                                    v45(v298.id, v298)
                                end,
                                {Width = 130}
                            )
                            return
                        end

                        joinButton(v298, parent)
                    end
                )

                if not a296 then
                    continue
                end

                ui.Enter(v299, Vector2.new(0, 10), math.min(layoutOrder * 0.03, 0.25), UDim2.new())
            end
        end
    end

    local function runSearch()
        --[[
          name: runSearch
          line: 791
          upvalues:
            ui3 (copy, index: 1)
            v206 (ref,  index: 2)
            v281 (ref,  index: 3)
            count (ref,  index: 4)
            v279 (ref,  index: 5)
            tribes (copy, index: 6)
            v280 (ref,  index: 7)
            drawRows (copy, index: 8)
            clear (copy, index: 9)
            parent10 (copy, index: 10)
            ui (copy, index: 11)
            v27 (ref,  index: 12)
            colors (copy, index: 13)
            parent11 (copy, index: 14)
            v212 (copy, index: 15)
            child (copy, index: 16)
            httpService (copy, index: 17)
            rowsSig (copy, index: 18)
            v282 (ref,  index: 19)
        ]]
        local v304
        local v305, v306
        local v307 = ui3.Text .. "\n" .. v206

        if v281 == v307 then
            return
        end

        count += 1
        local v308 = count
        v281 = v307
        local v309 = v279 ~= v307
        local text = ui3.Text

        if text ~= "" then
            v304 = nil
        else
            v304 = tribes.CachedBoard(v206)
        end

        if v309 and type(v304) == "table" then
            v279 = v307
            v280 = v304
            drawRows(v304, true)
            v309 = false
        end

        if v309 then
            clear(parent10)

            for layoutOrder = 1, 4 do
                local ui2 = ui.new("Frame", {Name = "Skeleton", Size = UDim2.new(1, -4, 0, v27.row + 8), LayoutOrder = layoutOrder, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.5, (ui.Corner(12)), Parent = parent10})
                local v313 = {BackgroundTransparency = 0.78}
                ui.Tween(ui2, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, layoutOrder * 0.12), v313)
            end

            parent11.Visible = false
        end

        if text ~= "" then
            v305, v306 = tribes.Action("Search", text, v206)
        else
            v305, v306 = tribes.Board(v206)
        end

        if v308 ~= count then
            return
        end

        local success, result, success2, result2
        local v318
        local v319, v320, v321, v322 = false, false, false, false
        v281 = nil

        if v305 then
            if type(v306) == "table" then
                if not v309 and v280 then
                    success, result = pcall(httpService.JSONEncode, httpService, v306)

                    if success then
                        v318 = result
                    else
                        v318 = tostring(os.clock())
                    end

                    v322 = true
                end
            else
                v319 = true
            end
        else
            v319 = true
        end

        if v319 then
            if v309 then
                v320 = true
            elseif v280 then
                v321 = true
            else
                v320 = true
            end
        end

        if v320 then
            v279 = nil
            v280 = nil
            clear(parent10)
            parent11.Visible = true
            v212.Text = tostring((v306 or child.Message("unavailable")))
            v321 = true
        end

        if v321 then
            return
        end

        if v322 then
            local v323
            local v324 = v280
            success2, result2 = pcall(httpService.JSONEncode, httpService, v324)

            if success2 then
                v323 = result2
            else
                v323 = tostring(os.clock())
            end

            if v318 == v323 and rowsSig() == v282 then
                return
            end
        end

        v279 = v307
        v280 = v306
        drawRows(v306, v309)
    end

    do
        local function redrawRows()
            --[[
              name: redrawRows
              line: 842
              upvalues:
                v280 (ref,  index: 1)
                v281 (ref,  index: 2)
                target (ref,  index: 3)
                rowsSig (copy, index: 4)
                v282 (ref,  index: 5)
                drawRows (copy, index: 6)
            ]]
            if v280 and not v281 and target == "Find" and rowsSig() ~= v282 then
                drawRows(v280, false)
            end
        end
    end

    local function paintSort()
        --[[
          name: paintSort
          line: 847
          upvalues:
            v207 (copy, index: 1)
            v206 (ref,  index: 2)
            colors (copy, index: 3)
        ]]
        for v327, v328 in v207 do
            v328.BackgroundTransparency = v327 ~= v206 and 1 or 0
            v328.TextColor3 = if v327 == v206 then colors.Text else colors.TextDim
        end
    end

    for v329, v330 in v207 do
        v330.Activated:Connect(
            function()
                --[[
                  line: 854
                  upvalues:
                    v206 (ref,  index: 1)
                    v329 (copy, index: 2)
                    timestamp (ref,  index: 3)
                    a26 (copy, index: 4)
                    paintSort (copy, index: 5)
                    runSearch (copy, index: 6)
                ]]
                if v206 ~= v329 and 0.5 <= os.clock() - timestamp then
                    v206 = v329
                    a26.Sounds.Play("Click")
                    paintSort()
                    runSearch()
                end
            end
        )
    end

    ui3.FocusLost:Connect(
        function()
            --[[
              line: 863
              upvalues:
                runSearch (copy, index: 1)
            ]]
            runSearch()
        end
    )
    local v331 = {{"three-people", "Play together", "Up to 2x Glory with tribemates"}, {"location-pin-map", "Hold the maps", "Most Glory on a map holds it"}, {"trophy", "Weekly Tribe Chest", "Item shards every Monday"}}
    local count2 = 0
    local timestamp3 = -math.huge

    local function renderFindLeft(a335)
        --[[
          name: renderFindLeft
          line: 874
          upvalues:
            clear (copy, index: 1)
            parent5 (copy, index: 2)
            count2 (ref,  index: 3)
            localPlayer (copy, index: 4)
            child (copy, index: 5)
            ui (copy, index: 6)
            heroTile (copy, index: 7)
            v27 (ref,  index: 8)
            TribeEmblem (copy, index: 9)
            label (copy, index: 10)
            fonts (copy, index: 11)
            v331 (copy, index: 12)
            udim2FromOffset (copy, index: 13)
            colors (copy, index: 14)
            theme (copy, index: 15)
            textColor3 (copy, index: 16)
            timestamp (ref,  index: 17)
            a26 (copy, index: 18)
            caps (copy, index: 19)
            backgroundColor3 (copy, index: 20)
            timestamp3 (ref,  index: 21)
            untilText (copy, index: 22)
            section (copy, index: 23)
            card (copy, index: 24)
            smallButton (copy, index: 25)
            act (copy, index: 26)
        ]]
        local foundLevel
        local v337
        clear(parent5)
        count2 += 1
        local level = localPlayer:GetAttribute("Level") or 1
        local v339 = type(a335.cooldownUntil) == "number" and os.time() < a335.cooldownUntil

        if type(a335.foundLevel) ~= "number" then
            foundLevel = child.FOUND_LEVEL
        else
            foundLevel = a335.foundLevel
        end

        local parent = ui.Panel({Name = "FoundPanel", BackgroundTransparency = 0.06, LayoutOrder = 1, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = parent5})
        ui.Padding(12, 12, 12, 12).Parent = parent
        ui.List(Enum.FillDirection.Vertical, 10).Parent = parent
        local parent2, v342 = heroTile(parent, v27.hero - 30, 1)
        local tribeEmblem = TribeEmblem.new(96, {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent2})
        local v344 = count2

        task.spawn(
            function()
                --[[
                  line: 888
                  upvalues:
                    v344 (copy, index: 1)
                    count2 (ref,  index: 2)
                    parent2 (copy, index: 3)
                    tribeEmblem (copy, index: 4)
                    child (copy, index: 5)
                    v342 (copy, index: 6)
                    ui (copy, index: 7)
                ]]
                local random = Random.new()

                while v344 == count2 and parent2.Parent do
                    local v346 = random:NextInteger(1, 14)
                    tribeEmblem:Set(random:NextInteger(1, #child.ICONS), v346, ({child.WHITE, child.WHITE, 6, 20})[random:NextInteger(1, 4)], nil)
                    v342(child.Color(v346))
                    ui.Pop(tribeEmblem.Instance, 0.9)
                    task.wait(2.2)
                end
            end
        )

        label({Name = "Title", Text = "FOUND A TRIBE", TextSize = 26, LayoutOrder = 2, FontFace = fonts.Display, Size = UDim2.new(1, 0, 0, 30), Parent = parent})

        for v347, v348 in v331 do
            local parent3 = ui.new("Frame", {Name = "Perk" .. v347, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 2 + v347, Parent = parent})
            local parent4 = ui.new("Frame", {Name = "Icon", Size = udim2FromOffset(32, 32), Position = udim2FromOffset(0, 3), BackgroundColor3 = colors.Accent, BackgroundTransparency = 0.8, (ui.Corner(theme.Radius.Pill)), Parent = parent3})
            ui.Glyph(v348[1], 18, theme.Lighten(colors.Accent, 0.3), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent4})
            label({Name = "Title", TextSize = 15, Text = v348[2], FontFace = fonts.Heavy, Position = udim2FromOffset(42, 0), Size = UDim2.new(1, -42, 0, 18), Parent = parent3})
            label({Name = "Text", TextSize = 13, Text = v348[3], FontFace = fonts.SemiBold, TextColor3 = textColor3, Position = udim2FromOffset(42, 19), Size = UDim2.new(1, -42, 0, 16), Parent = parent3})
        end

        if foundLevel <= level then
            local v351 = ui.Button({Name = "Found", Text = "FOUND A TRIBE", Style = "Primary", LayoutOrder = 8, Size = UDim2.new(1, 0, 0, 52), Parent = parent})

            v351.Activated:Connect(
                function()
                    --[[
                      line: 908
                      upvalues:
                        timestamp (ref,  index: 1)
                        v339 (copy, index: 2)
                        a26 (copy, index: 3)
                        child (copy, index: 4)
                    ]]
                    if not (0.5 <= os.clock() - timestamp) then
                        return
                    end

                    if v339 then
                        a26.Toast(child.Message("cooldown"), "error")
                        return
                    end

                    a26.OpenTribeForm("create")
                end
            )

            if v339 then
                v351:SetEnabled(false)
            end
        else
            local parent6 = ui.new("Frame", {Name = "Lock", Size = UDim2.new(1, 0, 0, 54), LayoutOrder = 8, BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.3, (ui.Corner(10)), Parent = parent})
            ui.Glyph("lock-closed", 18, colors.TextDim, {Position = udim2FromOffset(12, 9), Parent = parent6})
            label({Name = "Text", TextSize = 15, Text = `Reach level {foundLevel} to found a tribe`, FontFace = fonts.Heavy, Position = udim2FromOffset(38, 8), Size = UDim2.new(1, -110, 0, 20), Parent = parent6})
            caps(`LV {level} / {foundLevel}`, {TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Size = udim2FromOffset(80, 14), Parent = parent6})
            local parent7 = ui.new("Frame", {Name = "Bar", Position = udim2FromOffset(12, 36), Size = UDim2.new(1, -24, 0, 8), BackgroundColor3 = backgroundColor3, (ui.Corner(theme.Radius.Pill)), Parent = parent6})
            ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(math.clamp(level / foundLevel, 0.03, 1), 1), BackgroundColor3 = colors.Accent, (ui.Corner(theme.Radius.Pill)), Parent = parent7})
            local economy = a26.Economy

            if economy and economy.CanBuy("tribe_found") then
                local v355 = ui.Button({Name = "FoundNow", Text = "", Style = "Primary", LayoutOrder = 9, Size = UDim2.new(1, 0, 0, 52), Parent = parent})
                v355.Label.RichText = true

                local function paintBuy()
                    --[[
                      name: paintBuy
                      line: 934
                      upvalues:
                        economy (copy, index: 1)
                        v355 (copy, index: 2)
                        v339 (copy, index: 3)
                    ]]
                    local v357 = economy.Pending("tribe_found")
                    local enabled = not v357 and not v339
                    v355:SetEnabled(enabled)
                    local text = v357 and "FOUNDING…"
                        or string.format("FOUND NOW   <font color=\"#FFFFFF\">%s</font> %s", economy.ROBUX, economy.PriceAmount("tribe_found"))
                    v355:SetText(text)
                end

                paintBuy()
                local v360 = nil

                v360 = economy.Changed:Connect(
                    function()
                        --[[
                          line: 941
                          upvalues:
                            v355 (copy, index: 1)
                            paintBuy (copy, index: 2)
                            v360 (ref,  index: 3)
                        ]]
                        if v355.Instance.Parent then
                            paintBuy()
                            return
                        end

                        v360:Disconnect()
                    end
                )

                v355.Activated:Connect(
                    function()
                        --[[
                          line: 948
                          upvalues:
                            timestamp (ref,  index: 1)
                            economy (copy, index: 2)
                            v339 (copy, index: 3)
                            a26 (copy, index: 4)
                            child (copy, index: 5)
                            timestamp3 (ref,  index: 6)
                        ]]
                        local v361 = 0.5 <= os.clock() - timestamp

                        if not v361 or economy.Pending("tribe_found") then
                            return
                        end

                        if v339 then
                            a26.Toast(child.Message("cooldown"), "error")
                            return
                        end

                        timestamp3 = os.clock()
                        economy.Buy("tribe_found")
                    end
                )

                caps("OR JOIN A TRIBE AT ANY LEVEL", {LayoutOrder = 10, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent})
            else
                caps("YOU CAN JOIN A TRIBE AT ANY LEVEL", {LayoutOrder = 9, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent})
            end
        end

        if v339 then
            label({Name = "Cooldown", TextSize = 13, TextWrapped = true, LayoutOrder = 11, Text = `You left a tribe recently. You can join or found one again in {(untilText(a335.cooldownUntil))}.`, FontFace = fonts.SemiBold, TextColor3 = colors.Warning, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = parent})
        end

        if type(a335.invites) ~= "table" then
            v337 = {}
        else
            v337 = a335.invites
        end

        if 0 < #v337 then
            section("INVITES", #v337, nil, 2, parent5, colors.Warning)

            for v362, v363 in v337 do
                local tribe = v363.tribe

                if type(tribe) == "table" then
                    local v365
                    local parent8 = card("Invite" .. v362, parent5, {LayoutOrder = 2 + v362})
                    ui.Padding(12, 12, 12, 12).Parent = parent8
                    ui.List(Enum.FillDirection.Vertical, 10).Parent = parent8
                    local parent9 = ui.new("Frame", {Name = "Top", LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 54), Parent = parent8})
                    TribeEmblem.new(50, {Parent = parent9}):Set(tribe.icon, tribe.color1, tribe.color2, tribe.tag)
                    local v368 = {Name = "Name", RichText = true, TextSize = 16}
                    local stringFormat = string.format
                    local v370 = TribeEmblem.TagColor(tribe.color1):ToHex()
                    local tag = TribeEmblem.Tag

                    if type(tribe) == "table" then
                        v365 = tribe.tag
                    else
                        v365 = tribe
                    end

                    local v372 = tag(v365)
                    v368.Text = stringFormat("<font color=\"#%s\">%s</font>  %s", v370, v372, (tostring(tribe.name
                        or "")))
                    v368.FontFace = fonts.Heavy
                    v368.Position = udim2FromOffset(62, 7)
                    v368.Size = UDim2.new(1, -62, 0, 20)
                    v368.Parent = parent9
                    label(v368)
                    local v373 = {Name = "From", TextSize = 13}
                    local text = tostring(v363.from or "?")
                    local number = tonumber(tribe.members) or 0
                    v373.Text = `{text} invited you  ·  {number}/{child.MAX_MEMBERS} members`
                    v373.FontFace = fonts.SemiBold
                    v373.TextColor3 = textColor3
                    v373.Position = udim2FromOffset(62, 29)
                    v373.Size = UDim2.new(1, -62, 0, 16)
                    v373.Parent = parent9
                    label(v373)
                    local ui2 = ui.new("Frame", {Name = "Row", Size = UDim2.new(1, 0, 0, 40), LayoutOrder = 2, (ui.List(Enum.FillDirection.Horizontal, 8)), Parent = parent8})

                    smallButton(
                        "JOIN",
                        "Primary",
                        ui2,
                        function()
                            --[[
                              line: 982
                              upvalues:
                                act (copy, index: 1)
                                tribe (copy, index: 2)
                                a26 (copy, index: 3)
                                TribeEmblem (copy, index: 4)
                            ]]
                            if act("Join", tribe.id) then
                                local v377
                                a26.Sounds.Play("Queue_Join")
                                local toast = a26.Toast
                                local tag = TribeEmblem.Tag

                                if type(tribe) ~= "table" then
                                    v377 = tribe
                                else
                                    v377 = tribe.tag
                                end

                                toast(`Welcome to {tag(v377)} {(tostring(tribe.name))}!`, "success")
                            end
                        end,
                        {Size = UDim2.new(0.5, -4, 1, 0)}
                    )

                    smallButton(
                        "DECLINE",
                        "Dark",
                        ui2,
                        function()
                            --[[
                              line: 988
                              upvalues:
                                act (copy, index: 1)
                                tribe (copy, index: 2)
                            ]]
                            act("Decline", tribe.id)
                        end,
                        {Size = UDim2.new(0.5, -4, 1, 0)}
                    )
                end
            end
        end
    end

    v141.Find = function()
        --[[
          line: 996
          upvalues:
            paintSort (copy, index: 1)
            runSearch (copy, index: 2)
        ]]
        paintSort()
        runSearch()
    end

    local parent12 = column("Left", tab2.page, 12)
    local parent13 = column("Right", tab2.page, 12)
    local v382 = {
        founded = (function(a383)
            --[[
              name: founded
              line: 1006
            ]]
            return (`{a383.name} founded the tribe`)
        end),
        joined = (function(a384)
            --[[
              name: joined
              line: 1009
            ]]
            return (`{a384.name} joined`)
        end),
        left = (function(a385)
            --[[
              name: left
              line: 1012
            ]]
            return (`{a385.name} left`)
        end),
        kicked = (function(a386)
            --[[
              name: kicked
              line: 1015
            ]]
            return (`{a386.by} removed {a386.name}`)
        end),
        promoted = (function(a387)
            --[[
              name: promoted
              line: 1018
            ]]
            return (`{a387.name} is now an Elder`)
        end),
        demoted = (function(a388)
            --[[
              name: demoted
              line: 1021
            ]]
            return (`{a388.name} is now a Member`)
        end),
        chief = (function(a389)
            --[[
              name: chief
              line: 1024
            ]]
            return (`{a389.name} is now the Chief`)
        end),
        renamed = (function(a390)
            --[[
              name: renamed
              line: 1027
            ]]
            return (`The tribe is now called {a390.name}`)
        end),
        took = (function(a391)
            --[[
              name: took
              line: 1030
              upvalues:
                tribes (copy, index: 1)
            ]]
            if a391.from then
                return (`Took {tribes.MapName(a391.mapId)} from [{a391.from}]`)
            end

            return (`Took {(tribes.MapName(a391.mapId))}`)
        end),
        lost = (function(a392)
            --[[
              name: lost
              line: 1033
              upvalues:
                tribes (copy, index: 1)
            ]]
            return (`[{a392.to}] took {(tribes.MapName(a392.mapId))}`)
        end)
    }
    local v393 = {founded = {"flag", colors.Accent}, joined = {"person-plus", colors.Success}, left = {"door-open-arrow-to-bottom-right", colors.TextMuted}, kicked = {"door-open-arrow-to-bottom-right", colors.Danger}, promoted = {"crown", textColor32}, demoted = {"person", colors.TextMuted}, chief = {"crown", textColor32}, renamed = {"pencil", colors.Accent}, took = {"location-pin-map", colors.Success}, lost = {"location-pin-map", colors.Danger}}
    local count3 = 0

    local function heldChips(a396, parent, layoutOrder: number, backgroundColor3, predicate, text: string)
        --[[
          name: heldChips
          line: 1054
          upvalues:
            ui (copy, index: 1)
            card (copy, index: 2)
            colors (copy, index: 3)
            label (copy, index: 4)
            fonts (copy, index: 5)
            textColor3 (copy, index: 6)
            udim2FromOffset (copy, index: 7)
            smallButton (copy, index: 8)
            showTab (copy, index: 9)
            tribes (copy, index: 10)
            timestamp (ref,  index: 11)
            a26 (copy, index: 12)
        ]]
        local newUi = ui.new
        local v403 = {Name = "Held"}
        local newUDim2 = UDim2.new
        local v405 = #a396 ~= 0 and 0 or 64
        v403.Size = newUDim2(1, -6, 0, v405)
        v403.AutomaticSize = if #a396 == 0 then Enum.AutomaticSize.None else Enum.AutomaticSize.Y
        v403.LayoutOrder = layoutOrder
        v403.Parent = parent
        local parent2 = newUi("Frame", v403)

        if #a396 == 0 then
            local parent3 = card("Empty", parent2, {Transparency = 0.5, Size = UDim2.fromScale(1, 1), AutomaticSize = Enum.AutomaticSize.None})
            ui.Glyph("location-pin-map", 22, colors.TextMuted, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Parent = parent3})
            label({Name = "Text", TextSize = 14, TextWrapped = true, Text = text, FontFace = fonts.SemiBold, TextColor3 = textColor3, Position = udim2FromOffset(48, 0), Size = UDim2.new(1, -170, 1, 0), TextTruncate = Enum.TextTruncate.None, Parent = parent3})
            smallButton(
                "SEE THE MAP",
                "Dark",
                parent3,
                function()
                    --[[
                      line: 1060
                      upvalues:
                        showTab (copy, index: 1)
                    ]]
                    showTab("Territories")
                end,
                {Width = 120, TextSize = 14, Height = 38, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0)}
            )

            return parent2
        end

        ui.new("UIGridLayout", {CellSize = udim2FromOffset(180, 104), CellPadding = udim2FromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent2})
        local v408 = tribes.CachedTerritories()
        local v409 = {}

        for layoutOrder2, v411 in a396 do
            local map = v408 and v408.maps and v408.maps[v411]
            local parent4 = ui.new("TextButton", {Name = v411, Text = "", AutoButtonColor = false, LayoutOrder = layoutOrder2, BackgroundColor3 = colors.Raised, ClipsDescendants = true, (ui.Corner(12)), Parent = parent2})
            local newUi2 = ui.new
            local v415 = {Name = "Thumb"}
            local thumb = map and map.thumb or ""
            v415.Image = tostring(thumb)
            v415.Size = UDim2.fromScale(1, 1)
            v415.ScaleType = Enum.ScaleType.Crop
            v415.Parent = parent4
            v409[v411] = newUi2("ImageLabel", v415)
            ui.new("Frame", {Name = "Shade", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Gradient(Color3.new(0, 0, 0), Color3.new(0, 0, 0), 90, NumberSequence.new(1, 0.15))), Parent = parent4})
            ui.new("Frame", {Name = "Tint", Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = backgroundColor3, Parent = parent4})
            label({Name = "Name", TextSize = 16, Text = tribes.MapName(v411), FontFace = fonts.Heavy, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -8), Size = UDim2.new(1, -20, 0, 20), Parent = parent4})

            parent4.Activated:Connect(
                function()
                    --[[
                      line: 1075
                      upvalues:
                        timestamp (ref,  index: 1)
                        a26 (copy, index: 2)
                        v411 (copy, index: 3)
                        showTab (copy, index: 4)
                    ]]
                    if 0.5 <= os.clock() - timestamp then
                        a26.Sounds.Play("Click")
                        a26.TribeMapSelect = v411
                        showTab("Territories")
                    end
                end
            )
        end

        if not v408 then
            task.spawn(
                function()
                    --[[
                      line: 1085
                      upvalues:
                        tribes (copy, index: 1)
                        predicate (copy, index: 2)
                        v409 (copy, index: 3)
                    ]]
                    local v417 = tribes.Territories(false)

                    if not predicate() or not v417 or type(v417.maps) ~= "table" then
                        return
                    end

                    for mapKey, v419 in v409 do
                        local map = v417.maps[mapKey]

                        if v419.Parent and map then
                            v419.Image = tostring((map.thumb or ""))
                        end
                    end
                end
            )
        end

        return parent2
    end

    local function renderOverview(tribe)
        --[[
          name: renderOverview
          line: 1101
          upvalues:
            count3 (ref,  index: 1)
            clear (copy, index: 2)
            parent12 (copy, index: 3)
            parent13 (copy, index: 4)
            roleIn (copy, index: 5)
            child (copy, index: 6)
            ui (copy, index: 7)
            heroTile (copy, index: 8)
            v27 (ref,  index: 9)
            TribeEmblem (copy, index: 10)
            colors (copy, index: 11)
            v16 (copy, index: 12)
            udim2FromOffset (copy, index: 13)
            label (copy, index: 14)
            fonts (copy, index: 15)
            caps (copy, index: 16)
            v17 (copy, index: 17)
            statTile (copy, index: 18)
            textColor32 (copy, index: 19)
            smallButton (copy, index: 20)
            a26 (copy, index: 21)
            openDialog (copy, index: 22)
            act (copy, index: 23)
            section (copy, index: 24)
            untilText (copy, index: 25)
            card (copy, index: 26)
            backgroundColor3 (copy, index: 27)
            theme (copy, index: 28)
            localPlayer (copy, index: 29)
            textColor3 (copy, index: 30)
            heldChips (copy, index: 31)
            v382 (copy, index: 32)
            v393 (copy, index: 33)
            ago (copy, index: 34)
        ]]
        local v423
        local v424
        local v425
        local v426
        local v427
        local v428
        local formattedText
        local v430
        local v431
        count3 += 1
        local v432 = count3
        clear(parent12)
        clear(parent13)
        local v433 = roleIn(tribe)
        local backgroundColor32 = child.Color(tribe.color1)
        local parent = ui.Panel({Name = "Hero", BackgroundTransparency = 0.06, LayoutOrder = 1, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = parent12})
        ui.Padding(12, 12, 12, 12).Parent = parent
        ui.List(Enum.FillDirection.Vertical, 10).Parent = parent
        local parent2, v437 = heroTile(parent, v27.hero, 1)
        v437(backgroundColor32)
        local newTribeEmblem = TribeEmblem.new
        local v439 = ui.Compact and 78 or 124
        local v440 = {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.44), Parent = parent2}
        newTribeEmblem(v439, v440):Set(tribe.icon, tribe.color1, tribe.color2, tribe.tag)
        local pill = ui.Pill
        local tag = TribeEmblem.Tag

        if type(tribe) ~= "table" then
            v423 = tribe
        else
            v423 = tribe.tag
        end

        pill(tag(v423), colors.Void, {Height = 26, TextSize = 15, Transparency = 0.3, ZIndex = 3, AutoLocalize = false, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), TextColor = TribeEmblem.TagColor(tribe.color1), Parent = parent2})

        if const v443 = v16[v433] then
            ui.Pill("YOU: " .. v443.text, v443.color, {Height = 22, TextSize = 12, ZIndex = 3, Position = udim2FromOffset(10, 10), Parent = parent2})
        end

        local parent3 = label({Name = "Name", TextScaled = true, LayoutOrder = 2, Text = string.upper((tostring(tribe.name
            or ""))), FontFace = fonts.Display, Size = UDim2.new(1, 0, 0, 32), Parent = parent})
        ui.new("UITextSizeConstraint", {MaxTextSize = 28, MinTextSize = 16, Parent = parent3})
        local number = tonumber(tribe.members) or 0
        local v446 = 0

        if type(tribe.membersList) ~= "table" then
            v424 = {}
        else
            v424 = tribe.membersList
        end

        v425 = v446

        for _, v448 in v424 do
            if v448.where then
                v425 += 1
            end
        end

        caps(`{number}/{child.MAX_MEMBERS} MEMBERS  ·  {v425} ONLINE  ·  {(string.upper((v17[tribe.joinMode] or "")))}`, {LayoutOrder = 3, Parent = parent})
        local newUi = ui.new
        local v450 = {Name = "Stats"}
        local newUDim2 = UDim2.new
        local v452 = ui.Compact and 52 or 62
        v450.Size = newUDim2(1, 0, 0, v452)
        v450.LayoutOrder = 4
        v450[1] = (ui.List(Enum.FillDirection.Horizontal, 8))
        v450.Parent = parent
        local ui2 = newUi("Frame", v450)
        local v454 = statTile(ui2, "WEEK RANK", 1)
        local v455 = statTile(ui2, "GLORY", 2)
        local v456 = statTile(ui2, "TERRITORIES", 3)
        v454.Text = if tribe.rank then "#" .. tostring(tribe.rank) else "-"
        v455.TextColor3 = textColor32

        if type(tribe.territories) ~= "table" then
            v426 = {}
        else
            v426 = tribe.territories
        end

        v456.Text = tostring(#v426)
        local v457 = ui.CountUp(
            v455,
            function(a458: number)
                --[[
                  line: 1140
                  upvalues:
                    ui (copy, index: 1)
                ]]
                return ui.FormatCompact((math.floor(a458)))
            end,
            0.6
        )
        v457((tonumber(tribe.weekRenown) or 0), (tonumber(tribe.weekRenown) or 0) == 0)
        local ui3 = ui.new("Frame", {Name = "Buttons", Size = UDim2.new(1, 0, 0, 42), LayoutOrder = 5, [1] = (ui.List(Enum.FillDirection.Horizontal, 8)), Parent = parent})

        if v433 == "chief" then
            smallButton(
                "EDIT TRIBE",
                "Dark",
                ui3,
                function()
                    --[[
                      line: 1146
                      upvalues:
                        a26 (copy, index: 1)
                    ]]
                    a26.OpenTribeForm("settings")
                end,
                {TextSize = 15, Size = UDim2.new(0.5, -4, 1, 0), Icon = ui.Glyph("pencil", 18, colors.Text)}
            )
        end

        local options = {TextSize = 15, Size = if v433 == "chief" then UDim2.new(0.5, -4, 1, 0) else UDim2.new(1, 0, 1, 0)}
        options.Icon = ui.Glyph("door-open-arrow-to-bottom-right", 18, colors.Text)

        smallButton(
            "LEAVE",
            "Dark",
            ui3,
            function()
                --[[
                  line: 1150
                  upvalues:
                    tribe (copy, index: 1)
                    openDialog (copy, index: 2)
                    child (copy, index: 3)
                    act (copy, index: 4)
                    a26 (copy, index: 5)
                    TribeEmblem (copy, index: 6)
                ]]
                local v461 = (tonumber(tribe.members) or 0) <= 1
                    and "You're the last member: the tribe will be disbanded and its tag freed."
                    or `You can join another tribe in {child.LEAVE_COOLDOWN // 60} minutes. If you leave before Monday you lose this week's chest.`

                openDialog(
                    "Leave the tribe?",
                    v461,
                    {
                        {
                            text = "LEAVE TRIBE",
                            style = "Danger",
                            fn = (function()
                                --[[
                                  name: fn
                                  line: 1155
                                  upvalues:
                                    act (copy, index: 1)
                                    a26 (copy, index: 2)
                                    tribe (copy, index: 3)
                                    TribeEmblem (copy, index: 4)
                                ]]
                                if act("Leave") then
                                    local v462
                                    local toast = a26.Toast
                                    local tag = TribeEmblem.Tag

                                    if type(tribe) ~= "table" then
                                        v462 = tribe
                                    else
                                        v462 = tribe.tag
                                    end

                                    toast(`You left {(tag(v462))}`, "info")
                                end
                            end)
                        },
                        {text = "STAY"}
                    }
                )
            end,
            options
        )

        local number2 = tonumber(tribe.weekRenown) or 0
        local v466 = child.ChestTier(number2)
        local chestTier = child.CHEST_TIERS[v466 + 1]
        section("TRIBE CHEST", nil, `opens Monday 00:00 UTC, in {(untilText(tribe.weekEndsAt))}`, 1, parent13, textColor32)
        local parent4 = card("Chest", parent13, {LayoutOrder = 2, Transparency = 0.25})
        ui.Padding(16, 16, 16, 16).Parent = parent4
        ui.List(Enum.FillDirection.Vertical, 12).Parent = parent4
        local parent5 = ui.new("Frame", {Name = "Track", LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 58), Parent = parent4})
        local parent6 = ui.new("Frame", {Name = "Line", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 18, 0, 18), Size = UDim2.new(1, -36, 0, 8), BackgroundColor3 = backgroundColor3, (ui.Corner(theme.Radius.Pill)), Parent = parent5})
        local chestTiers = child.CHEST_TIERS
        local v472 = 0
        local v473

        for chestTierKey = 1, #chestTiers do
            v473 = chestTierKey == 1 and 0 or chestTiers[chestTierKey - 1]

            if not (chestTiers[chestTierKey] <= number2) then
                v472 += math.clamp((number2 - v473) / (chestTiers[chestTierKey] - v473), 0, 1) / #chestTiers
                break
            end

            v472 = chestTierKey / #chestTiers
        end

        local parent7 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(theme.Radius.Pill)), Parent = parent6})
        ui.Gradient(Color3.fromRGB(255, 214, 110), textColor32, 0).Parent = parent7
        ui.Tween(parent7, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromScale(math.clamp(v472, 0, 1), 1)})

        for v476, chestTier2 in chestTiers do
            local v478
            local v479
            local v480 = chestTier2 <= number2
            local v481 = v476 / #chestTiers
            local newUi2 = ui.new
            local v483 = {Name = "Node" .. v476, AnchorPoint = Vector2.new(0.5, 0.5)}
            local newUDim22 = UDim2.new
            local v485 = v476 ~= #chestTiers and 0 or -4
            v483.Position = newUDim22(v481, v485, 0.5, 0)
            v483.Size = udim2FromOffset(34, 34)
            v483.BackgroundColor3 = if v480 then textColor32 else colors.Raised
            v483.ZIndex = 2
            local v486 = ui.Corner(theme.Radius.Pill)
            local v487 = ui.Stroke

            if v480 then
                v478 = Color3.fromRGB(255, 226, 150)
            else
                v478 = if v476 == v466 + 1 then textColor32 else colors.StrokeSoft
            end

            v483[1], v483[2] = v486, (v487(v478, 2, 0))
            v483.Parent = parent6
            local parent8 = newUi2("Frame", v483)
            local v489 = {Name = "N", TextSize = 17, ZIndex = 3, Text = tostring(v476), FontFace = fonts.Display}

            if v480 then
                v479 = colors.TextDark
            else
                v479 = colors.TextDim
            end

            v489.TextColor3 = v479
            v489.TextXAlignment = Enum.TextXAlignment.Center
            v489.Size = UDim2.fromScale(1, 1)
            v489.Parent = parent8
            label(v489)
            local text = ui.FormatCompact(chestTier2)
            local options2 = {TextXAlignment = Enum.TextXAlignment.Center, AnchorPoint = Vector2.new(0.5, 0)}
            v487 = UDim2.new
            local v492 = v476 ~= #chestTiers and 0 or -4
            options2.Position = v487(v481, v492, 0, 40)
            options2.Size = udim2FromOffset(60, 14)
            options2.Parent = parent5
            caps(text, options2)

            if v476 == v466 then
                ui.Pop(parent8, 1.25)
            end
        end

        local v493 = 0

        if type(tribe.membersList) ~= "table" then
            v427 = {}
        else
            v427 = tribe.membersList
        end

        v428 = v493

        for _, v495 in v427 do
            if v495.userId == localPlayer.UserId then
                v428 = tonumber(v495.weekRenown) or 0
            end
        end

        local parent9 = ui.new("Frame", {Name = "Info", LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 40), Parent = parent4})
        local v497 = {Name = "Tribe", TextSize = 20, Text = if 0 < v466 then `TIER {v466}` else "NO CHEST YET"}
        v497.FontFace = fonts.Display
        v497.TextColor3 = if 0 < v466 then textColor32 else colors.TextDim
        v497.Size = UDim2.new(0.5, 0, 0, 22)
        v497.Parent = parent9
        label(v497)
        local v498 = {Name = "TribeSub", TextSize = 13, Text = if chestTier then `{ui.FormatNumber(chestTier - number2)} more Glory for tier {v466 + 1}` else "Top tier this week"}
        v498.FontFace = fonts.SemiBold
        v498.TextColor3 = textColor3
        v498.Position = udim2FromOffset(0, 23)
        v498.Size = UDim2.new(0.5, 0, 0, 16)
        v498.Parent = parent9
        label(v498)
        local v499 = child.CHEST_MIN <= v428
        local v500 = {Name = "You", TextSize = 20, Text = if v499 then `YOU: {v428} GLORY` else `YOU: {v428} / {child.CHEST_MIN}`}
        v500.FontFace = fonts.Display
        v500.TextColor3 = if v499 then colors.Success else colors.Warning
        v500.TextXAlignment = Enum.TextXAlignment.Right
        v500.AnchorPoint = Vector2.new(1, 0)
        v500.Position = UDim2.new(1, 0, 0, 0)
        v500.Size = UDim2.new(0.5, 0, 0, 22)
        v500.Parent = parent9
        label(v500)
        local v501 = {Name = "YouSub", TextSize = 13}

        if v499 then
            formattedText = "You'll get this chest"
        else
            formattedText = `Earn {child.CHEST_MIN - v428} more to get this chest`
        end

        v501.Text = formattedText
        v501.FontFace = fonts.SemiBold
        v501.TextColor3 = textColor3
        v501.TextXAlignment = Enum.TextXAlignment.Right
        v501.AnchorPoint = Vector2.new(1, 0)
        v501.Position = UDim2.new(1, 0, 0, 23)
        v501.Size = UDim2.new(0.5, 0, 0, 16)
        v501.Parent = parent9
        label(v501)
        local length = #v426
        local v503 = #v426 ~= 0 and "held this week" or "win matches on a map to take it"
        section("TERRITORIES", length, v503, 3, parent13)
        heldChips(
            v426,
            parent13,
            4,
            backgroundColor32,
            function()
                --[[
                  line: 1263
                  upvalues:
                    v432 (copy, index: 1)
                    count3 (ref,  index: 2)
                ]]
                return v432 == count3
            end,
            "No territories yet. The tribe with the most Glory on a map this week holds it."
        )

        if type(tribe.feed) ~= "table" then
            v430 = {}
        else
            v430 = tribe.feed
        end

        section("ACTIVITY", nil, nil, 5, parent13)
        local parent10 = card("Feed", parent13, {LayoutOrder = 6, Transparency = 0.5})
        ui.List(Enum.FillDirection.Vertical, 0).Parent = parent10
        local v505 = 0
        v431 = v505

        for layoutOrder, v507 in v430 do
            if const v508 = v382[tostring(v507.kind)] then
                local backgroundTransparency
                local result

                if type(v507.data) ~= "table" then
                    continue
                end
                if not (v431 < 20) then
                    continue
                end

                v431 += 1
                local v511 = v393[v507.kind] or {"flag", colors.Accent}
                local newUi3 = ui.new
                local v513 = {Name = "F" .. layoutOrder, Size = UDim2.new(1, 0, 0, 44), LayoutOrder = layoutOrder, BackgroundColor3 = colors.Void}

                if v431 % 2 == 0 then
                    backgroundTransparency = 0.85
                else
                    backgroundTransparency = 1
                end

                v513.BackgroundTransparency = backgroundTransparency
                v513.Parent = parent10
                local parent11 = newUi3("Frame", v513)
                local parent14 = ui.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = udim2FromOffset(28, 28), BackgroundColor3 = v511[2], BackgroundTransparency = 0.8, (ui.Corner(theme.Radius.Pill)), Parent = parent11})
                ui.Glyph(v511[1], 16, v511[2], {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent14})
                local success, result2 = pcall(v508, v507.data)
                local v518 = {Name = "Text", TextSize = 15}

                if success then
                    result = result2
                else
                    result = ""
                end

                v518.Text = result
                v518.FontFace = fonts.Bold
                v518.Position = udim2FromOffset(50, 0)
                v518.Size = UDim2.new(1, -150, 1, 0)
                v518.Parent = parent11
                label(v518)
                caps(string.upper((ago(v507.at))), {TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = udim2FromOffset(90, 14), Parent = parent11})
            end
        end

        if v431 == 0 then
            label({Name = "NoFeed", Text = "Nothing yet.", TextSize = 14, FontFace = fonts.SemiBold, TextColor3 = textColor3, Size = UDim2.new(1, -24, 0, 40), Position = udim2FromOffset(12, 0), Parent = parent10})
        end
    end

    local parent14 = ui.new("Frame", {Name = "Head", Size = UDim2.new(1, 0, 0, 40), Parent = tab3.page})
    local ui4 = ui.new("Frame", {Name = "TitleHolder", Size = UDim2.new(1, -220, 1, 0), Parent = parent14})
    local ui5 = ui.new("Frame", {Name = "InviteSlot", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 0), Size = udim2FromOffset(200, 40), Parent = parent14})

    do
        local v522 = {{"PLAYER", 0}, {"GLORY", -300}, {"STATUS", -190}}
        local parent15 = ui.new("Frame", {Name = "Cols", Position = udim2FromOffset(0, 48), Size = UDim2.new(1, -14, 0, 16), Parent = tab3.page})

        for _, v525 in v522 do
            do
                local text = v525[1]
                local options = {}
                options.Position = if v525[2] == 0 then udim2FromOffset(16, 0) else UDim2.new(1, v525[2], 0, 0)
                options.Size = udim2FromOffset(110, 14)
                options.TextXAlignment = if v525[2] == 0 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center
                options.Parent = parent15
                caps(text, options)
            end
        end
    end

    local parent16 = ui.new("ScrollingFrame", {Name = "List", Position = udim2FromOffset(0, 70), Size = UDim2.new(1, 0, 1, -70), ScrollBarThickness = 3, Selectable = false, ui.List(Enum.FillDirection.Vertical, 6), (ui.Padding(4, 10, 10, 4)), Parent = tab3.page})

    do
        local function canManage(a530, a531)
            --[[
              name: canManage
              line: 1311
            ]]
            return not (a530 ~= "chief" or a531 == "chief") or (a530 == "elder" and a531 == "member")
        end
    end

    local function manage(value, tribe)
        --[[
          name: manage
          line: 1315
          upvalues:
            roleIn (copy, index: 1)
            act (copy, index: 2)
            openDialog (copy, index: 3)
            TribeEmblem (copy, index: 4)
        ]]
        local v535 = {}

        if roleIn(tribe) == "chief" then
            if value.role == "member" then
                table.insert(
                    v535,
                    {
                        text = "PROMOTE TO ELDER",
                        style = "Primary",
                        fn = (function()
                            --[[
                              name: fn
                              line: 1320
                              upvalues:
                                act (copy, index: 1)
                                value (copy, index: 2)
                            ]]
                            act("Role", value.userId, "elder")
                        end)
                    }
                )
            elseif value.role == "elder" then
                table.insert(
                    v535,
                    {
                        text = "DEMOTE TO MEMBER",
                        fn = (function()
                            --[[
                              name: fn
                              line: 1324
                              upvalues:
                                act (copy, index: 1)
                                value (copy, index: 2)
                            ]]
                            act("Role", value.userId, "member")
                        end)
                    }
                )
            end

            table.insert(
                v535,
                {
                    text = "MAKE CHIEF",
                    fn = (function()
                        --[[
                          name: fn
                          line: 1328
                          upvalues:
                            openDialog (copy, index: 1)
                            value (copy, index: 2)
                            act (copy, index: 3)
                        ]]
                        openDialog(
                            `Make {value.display} the Chief?`,
                            "You'll become an Elder. Only the Chief can change ranks and edit the tribe.",
                            {
                                {
                                    text = "MAKE CHIEF",
                                    style = "Primary",
                                    fn = (function()
                                        --[[
                                          name: fn
                                          line: 1330
                                          upvalues:
                                            act (copy, index: 1)
                                            value (copy, index: 2)
                                        ]]
                                        act("Role", value.userId, "chief")
                                    end)
                                },
                                {text = "CANCEL"}
                            }
                        )
                    end)
                }
            )
        end

        table.insert(
            v535,
            {
                text = "REMOVE FROM TRIBE",
                style = "Danger",
                fn = (function()
                    --[[
                      name: fn
                      line: 1337
                      upvalues:
                        openDialog (copy, index: 1)
                        value (copy, index: 2)
                        tribe (copy, index: 3)
                        TribeEmblem (copy, index: 4)
                        act (copy, index: 5)
                    ]]
                    local v536
                    local formattedText = `Remove {value.display}?`
                    local tag = TribeEmblem.Tag

                    if type(tribe) ~= "table" then
                        v536 = tribe
                    else
                        v536 = tribe.tag
                    end

                    openDialog(
                        formattedText,
                        `They'll leave {(tag(v536))}. They can be invited again.`,
                        {
                            {
                                text = "REMOVE",
                                style = "Danger",
                                fn = (function()
                                    --[[
                                      name: fn
                                      line: 1339
                                      upvalues:
                                        act (copy, index: 1)
                                        value (copy, index: 2)
                                    ]]
                                    act("Kick", value.userId)
                                end)
                            },
                            {text = "CANCEL"}
                        }
                    )
                end)
            }
        )

        table.insert(v535, {text = "CANCEL"})
        openDialog(tostring(value.display), `@{value.name}  ·  Level {value.level}`, v535)
    end

    local v539 = {hub = {"IN LOBBY", colors.Success}, match = {"IN MATCH", colors.Warning}, custom = {"CUSTOM MATCH", colors.Warning}}

    local function memberRow(value, tribe, layoutOrder)
        --[[
          name: memberRow
          line: 1354
          upvalues:
            roleIn (copy, index: 1)
            localPlayer (copy, index: 2)
            ui (copy, index: 3)
            v27 (ref,  index: 4)
            colors (copy, index: 5)
            parent16 (copy, index: 6)
            udim2FromOffset (copy, index: 7)
            theme (copy, index: 8)
            v539 (copy, index: 9)
            label (copy, index: 10)
            a26 (copy, index: 11)
            fonts (copy, index: 12)
            v16 (copy, index: 13)
            textColor3 (copy, index: 14)
            child (copy, index: 15)
            textColor32 (copy, index: 16)
            ago (copy, index: 17)
            players (copy, index: 18)
            timestamp (ref,  index: 19)
            openDialog (copy, index: 20)
            act (copy, index: 21)
            menuManager (copy, index: 22)
            manage (copy, index: 23)
        ]]
        local v544
        local v545
        local v546
        local v547
        local transparency
        local v549 = roleIn(tribe)
        local v550 = value.userId == localPlayer.UserId
        local newUi = ui.new
        local v552 = {Name = "M" .. tostring(value.userId), Size = UDim2.new(1, -4, 0, v27.row), LayoutOrder = layoutOrder}

        if v550 then
            v544 = colors.AccentDeep
        else
            v544 = colors.PanelHi
        end

        v552.BackgroundColor3 = v544
        v552.BackgroundTransparency = v550 and 0.45 or layoutOrder % 2 ~= 0 and 0.35 or 0.55
        v552[1] = (ui.Corner(12))
        v552.Parent = parent16
        local parent = newUi("Frame", v552)

        if v550 then
            ui.Stroke(colors.Accent, 1, 0.45).Parent = parent
        end

        local v554 = v27.row - 18
        local parent2 = ui.new("ImageLabel", {Name = "Head", Image = `rbxthumb://type=AvatarHeadShot&id={value.userId}&w=150&h=150`, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = udim2FromOffset(v554, v554), BackgroundColor3 = colors.Raised, (ui.Corner(theme.Radius.Pill)), Parent = parent})
        local v556 = value.where ~= false and value.where ~= nil

        if v556 then
            local newUi2 = ui.new
            local v558 = {Name = "Dot", AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1.02, 1.02), Size = udim2FromOffset(13, 13)}
            local v559 = v539[value.where] or v539.hub
            v558.BackgroundColor3 = v559[2]
            v558[1], v558[2] = ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Panel, 2, 0))
            v558.Parent = parent2
            newUi2("Frame", v558)
        else
            parent2.ImageTransparency = 0.35
        end

        local v560 = v554 + 26
        local parent3 = ui.new("Frame", {Name = "NameRow", Position = udim2FromOffset(v560, (math.floor(v27.row / 2) - v27.text) - 2), Size = UDim2.new(1, -(v560 + 420), 0, v27.text + 4), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
        local v562 = {Name = "Name", LayoutOrder = 1}
        local text = tostring(value.display)

        if v550 then
            v545 = "  " .. a26.Loc.T("(you)")
        else
            v545 = ""
        end

        v562.Text = text .. v545
        v562.FontFace = fonts.Heavy
        v562.TextSize = v27.text
        v562.AutomaticSize = Enum.AutomaticSize.X
        v562.Size = udim2FromOffset(0, v27.text + 4)
        v562.Parent = parent3
        label(v562)

        if const v564 = v16[value.role] then
            ui.Pill(v564.text, v564.color, {LayoutOrder = 2, Height = 20, TextSize = 11, Parent = parent3})
        end

        label({Name = "Sub", Text = `@{value.name}  ·  Lv {value.level}`, FontFace = fonts.SemiBold, TextSize = v27.sub, TextColor3 = textColor3, Position = udim2FromOffset(v560, math.floor(v27.row / 2) + 3), Size = UDim2.new(1, -(v560 + 420), 0, v27.sub + 2), Parent = parent})
        local number = tonumber(value.weekRenown) or 0
        local v566 = {Name = "Renown", TextSize = 20, Text = tostring(number), FontFace = fonts.Display}

        if child.CHEST_MIN <= number then
            v546 = textColor32
        else
            v546 = colors.TextDim
        end

        v566.TextColor3 = v546
        v566.TextXAlignment = Enum.TextXAlignment.Center
        v566.AnchorPoint = Vector2.new(0, 0.5)
        v566.Position = UDim2.new(1, -300, 0.5, 0)
        v566.Size = udim2FromOffset(110, 24)
        v566.Parent = parent
        label(v566)

        if v556 then
            v547 = v539[value.where] or v539.hub
        else
            local uppercaseText
            local v568 = {}

            if not (0 < (tonumber(value.lastSeen) or 0)) then
                uppercaseText = "OFFLINE"
            else
                uppercaseText = string.upper((ago(value.lastSeen)))
            end

            v568[1], v568[2] = uppercaseText, colors.TextMuted
            v547 = v568
        end

        local pill = ui.Pill
        local v570 = v547[1]
        local v571 = v547[2]
        local v572 = {Height = 22, TextSize = 11, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -135, 0.5, 0)}

        if v556 then
            transparency = 0.15
        else
            transparency = 0.75
        end

        v572.Transparency = transparency
        v572.TextColor = if v556 then colors.TextDark else colors.TextDim
        v572.Parent = parent
        pill(v570, v571, v572).Name = "Status"
        local parent4 = ui.new("Frame", {Name = "Actions", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = udim2FromOffset(78, 40), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent})

        if not v550 then
            if players:GetPlayerByUserId(value.userId) then
                local parent5 = ui.IconButton({Name = "Invite", LayoutOrder = 1, Size = udim2FromOffset(38, 38), Color = colors.Accent, Parent = parent4})
                ui.Glyph("person-plus", 18, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent5})

                parent5.Activated:Connect(
                    function()
                        --[[
                          line: 1418
                          upvalues:
                            timestamp (ref,  index: 1)
                            a26 (copy, index: 2)
                            value (copy, index: 3)
                        ]]
                        if not (0.5 <= os.clock() - timestamp) then
                            return
                        end

                        local v575, v576, v577 = a26.Remotes.Invoke("PartyAction", "Invite", value.userId)

                        if v575 and v576 == true then
                            a26.Toast(`Party invite sent to {value.display}`, "success")
                            return
                        end

                        local toast = a26.Toast
                        local v579 = if v575 then v577 or "Couldn't invite them" else v576
                        toast(tostring(v579), "error")
                    end
                )
            elseif value.where == "hub" and value.jobId and value.jobId ~= game.JobId then
                local parent6 = ui.IconButton({Name = "Join", LayoutOrder = 1, Size = udim2FromOffset(38, 38), Color = colors.Accent, Parent = parent4})
                ui.Glyph("person-teleport", 18, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent6})

                parent6.Activated:Connect(
                    function()
                        --[[
                          line: 1432
                          upvalues:
                            timestamp (ref,  index: 1)
                            openDialog (copy, index: 2)
                            value (copy, index: 3)
                            act (copy, index: 4)
                            a26 (copy, index: 5)
                            menuManager (copy, index: 6)
                        ]]
                        if not (0.5 <= os.clock() - timestamp) then
                            return
                        end

                        openDialog(
                            `Join {value.display}?`,
                            "You'll move to their lobby.",
                            {
                                {
                                    text = "JOIN THEIR LOBBY",
                                    style = "Primary",
                                    fn = (function()
                                        --[[
                                          name: fn
                                          line: 1437
                                          upvalues:
                                            act (copy, index: 1)
                                            value (copy, index: 2)
                                            a26 (copy, index: 3)
                                            menuManager (copy, index: 4)
                                        ]]
                                        if act("Visit", value.userId) then
                                            a26.Toast(`Joining {value.display}'s lobby...`, "info")
                                            menuManager.Close("Tribe")
                                        end
                                    end)
                                },
                                {text = "CANCEL"}
                            }
                        )
                    end
                )
            end

            local role = value.role

            if v549 == "chief" and role ~= "chief" or v549 == "elder" and role == "member" then
                local parent7 = ui.IconButton({Name = "Manage", LayoutOrder = 2, Size = udim2FromOffset(38, 38), Color = colors.Raised, Parent = parent4})
                ui.Glyph("three-dots-horizontal", 18, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent7})

                parent7.Activated:Connect(
                    function()
                        --[[
                          line: 1450
                          upvalues:
                            timestamp (ref,  index: 1)
                            manage (copy, index: 2)
                            value (copy, index: 3)
                            tribe (copy, index: 4)
                        ]]
                        if 0.5 <= os.clock() - timestamp then
                            manage(value, tribe)
                        end
                    end
                )
            end
        end

        return parent
    end

    local function invitePicker()
        --[[
          name: invitePicker
          line: 1460
          upvalues:
            openDialog (copy, index: 1)
            ui (copy, index: 2)
            v42 (ref,  index: 3)
            roleIn (copy, index: 4)
            tribes (copy, index: 5)
            players (copy, index: 6)
            localPlayer (copy, index: 7)
            colors (copy, index: 8)
            udim2FromOffset (copy, index: 9)
            theme (copy, index: 10)
            label (copy, index: 11)
            fonts (copy, index: 12)
            smallButton (copy, index: 13)
            act (copy, index: 14)
            textColor3 (copy, index: 15)
        ]]
        openDialog(
            "Invite players",
            "Players in this lobby who aren't in a tribe. Invites last 24 hours.",
            {{text = "DONE"}},
            function(parent)
                --[[
                  line: 1461
                  upvalues:
                    ui (copy, index: 1)
                    v42 (ref,  index: 2)
                    roleIn (copy, index: 3)
                    tribes (copy, index: 4)
                    players (copy, index: 5)
                    localPlayer (copy, index: 6)
                    colors (copy, index: 7)
                    udim2FromOffset (copy, index: 8)
                    theme (copy, index: 9)
                    label (copy, index: 10)
                    fonts (copy, index: 11)
                    smallButton (copy, index: 12)
                    act (copy, index: 13)
                    textColor3 (copy, index: 14)
                ]]
                local v585
                local v586
                ui.List(Enum.FillDirection.Vertical, 6).Parent = parent
                local count = 0
                local tribe = v42 and v42.tribe

                if type(tribe) ~= "table" then
                    v585 = tribes.Mine()
                else
                    v585 = {id = tribe.id, role = roleIn(tribe)}
                end

                local v589 = {}

                if not v585 or type(v585.invites) ~= "table" then
                    v586 = {}
                else
                    v586 = v585.invites
                end

                for _, v591 in v586 do
                    if type(v591) == "table" and type(v591.userId) == "number" then
                        v589[v591.userId] = true
                    end
                end

                for _, player in players:GetPlayers() do
                    local tribeId = player:GetAttribute("TribeId")

                    if player ~= localPlayer then
                        if type(tribeId) ~= "number" or tribeId == 0 then
                            count += 1
                            local parent2 = ui.new("Frame", {Name = player.Name, Size = UDim2.new(1, 0, 0, 46), LayoutOrder = count, ZIndex = 22, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.5, (ui.Corner(10)), Parent = parent})
                            ui.new("ImageLabel", {Name = "Head", Image = `rbxthumb://type=AvatarHeadShot&id={player.UserId}&w=150&h=150`, Position = udim2FromOffset(6, 5), Size = udim2FromOffset(36, 36), BackgroundColor3 = colors.Raised, ZIndex = 22, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
                            label({Name = "Name", TextSize = 16, ZIndex = 22, Text = player.DisplayName, FontFace = fonts.Heavy, Position = udim2FromOffset(52, 0), Size = UDim2.new(1, -160, 1, 0), Parent = parent2})
                            local v596 = nil

                            v596 = smallButton(
                                "INVITE",
                                "Primary",
                                parent2,
                                function()
                                    --[[
                                      line: 1479
                                      upvalues:
                                        act (copy, index: 1)
                                        player (copy, index: 2)
                                        v596 (ref,  index: 3)
                                    ]]
                                    if act("Invite", player.UserId) then
                                        v596:SetText("SENT")
                                        v596:SetEnabled(false)
                                    end
                                end,
                                {Width = 96, Height = 36, TextSize = 15, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0)}
                            )

                            v596.Instance.ZIndex = 23

                            if v589[player.UserId] then
                                v596:SetText("SENT")
                                v596:SetEnabled(false)
                            end
                        end
                    end
                end

                if count == 0 then
                    label({Name = "None", Text = "Nobody to invite here right now.", TextSize = 15, ZIndex = 22, FontFace = fonts.SemiBold, TextColor3 = textColor3, Size = UDim2.new(1, 0, 0, 30), Parent = parent})
                end
            end
        )
    end

    local v597 = {}

    do
        local function lookupName(userId, callback)
            --[[
              name: lookupName
              line: 1500
              upvalues:
                v597 (copy, index: 1)
                players (copy, index: 2)
            ]]
            if v597[userId] then
                callback(v597[userId])
                return
            end

            task.spawn(
                function()
                    --[[
                      line: 1505
                      upvalues:
                        players (copy, index: 1)
                        userId (copy, index: 2)
                        v597 (copy, index: 3)
                        callback (copy, index: 4)
                    ]]
                    local success, name = pcall(
                        function()
                            --[[
                              line: 1506
                              upvalues:
                                players (copy, index: 1)
                                userId (copy, index: 2)
                            ]]
                            return players:GetNameFromUserIdAsync(userId)
                        end
                    )

                    if success and type(name) == "string" then
                        v597[userId] = name
                        callback(name)
                    end
                end
            )
        end
    end

    local function pendingRow(a604, layoutOrder)
        --[[
          name: pendingRow
          line: 1515
          upvalues:
            ui (copy, index: 1)
            v27 (ref,  index: 2)
            colors (copy, index: 3)
            parent16 (copy, index: 4)
            udim2FromOffset (copy, index: 5)
            theme (copy, index: 6)
            label (copy, index: 7)
            fonts (copy, index: 8)
            ago (copy, index: 9)
            textColor3 (copy, index: 10)
            v597 (copy, index: 11)
            players (copy, index: 12)
            smallButton (copy, index: 13)
            act (copy, index: 14)
            a26 (copy, index: 15)
        ]]
        local display
        local name
        local formattedText
        local name2
        local number = tonumber(a604.userId) or 0
        local parent = ui.new("Frame", {Name = "I" .. tostring(number), Size = UDim2.new(1, -4, 0, v27.row), LayoutOrder = layoutOrder, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.55, (ui.Corner(12)), Parent = parent16})
        ui.new("ImageLabel", {Name = "Head", Image = `rbxthumb://type=AvatarHeadShot&id={number}&w=150&h=150`, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = udim2FromOffset(v27.row - 18, v27.row - 18), BackgroundColor3 = colors.Raised, (ui.Corner(theme.Radius.Pill)), Parent = parent})
        local v612 = v27.row + 8

        if type(a604.display) == "string" and a604.display ~= "" then
            display = a604.display
        else
            display = nil
        end

        if type(a604.name) == "string" and a604.name ~= "" then
            name = a604.name
        else
            name = nil
        end

        local v613 = {Name = "Name", Text = display or name or "Player", FontFace = fonts.Heavy, TextSize = v27.text, Position = udim2FromOffset(v612, (math.floor(v27.row / 2) - v27.text) - 2), Size = UDim2.new(1, -(v612 + 150), 0, v27.text + 4), Parent = parent}
        local v614 = label(v613)
        local v615 = math.max(0, (tonumber(a604.expiresAt) or 0) - os.time())

        if not (3600 <= v615) then
            formattedText = `{(math.max(1, v615 // 60))}m`
        else
            formattedText = `{v615 // 3600}h`
        end

        local function sub(a617)
            --[[
              name: sub
              line: 1525
              upvalues:
                a604 (copy, index: 1)
                ago (copy, index: 2)
                formattedText (copy, index: 3)
            ]]
            local v618 = not a617 and "" or `@{a617}  ·  `
            return (`{v618}invited by {tostring((a604.from or "?"))} {ago(a604.at)}  ·  expires in {formattedText}`)
        end

        if not name or display ~= nil and string.lower(name) == string.lower(display) then
            name2 = nil
        else
            name2 = name
        end

        local v619 = {Name = "Sub"}
        local v620 = not name2 and "" or `@{name2}  ·  `
        v619.Text = `{v620}invited by {tostring((a604.from or "?"))} {ago(a604.at)}  ·  expires in {formattedText}`
        v619.FontFace = fonts.SemiBold
        v619.TextSize = v27.sub
        v619.TextColor3 = textColor3
        v619.Position = udim2FromOffset(v612, math.floor(v27.row / 2) + 3)
        v619.Size = UDim2.new(1, -(v612 + 150), 0, v27.sub + 2)
        v619.Parent = parent
        label(v619)

        if not display and not name and 0 < number then
            local v621 = function(text)
                --[[
                  line: 1533
                  upvalues:
                    v614 (copy, index: 1)
                ]]
                if v614.Parent then
                    v614.Text = text
                end
            end

            if v597[number] then
                local text = v597[number]

                if v614.Parent then
                    v614.Text = text
                end
            else
                task.spawn(
                    function()
                        --[[
                          line: 1505
                          upvalues:
                            players (copy, index: 1)
                            number (copy, index: 2)
                            v597 (copy, index: 3)
                            v621 (copy, index: 4)
                        ]]
                        local success, name = pcall(
                            function()
                                --[[
                                  line: 1506
                                  upvalues:
                                    players (copy, index: 1)
                                    number (copy, index: 2)
                                ]]
                                return players:GetNameFromUserIdAsync(number)
                            end
                        )

                        if success and type(name) == "string" then
                            v597[number] = name
                            v621(name)
                        end
                    end
                )
            end
        end

        local ui2 = ui.new("Frame", {Name = "Actions", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = udim2FromOffset(130, 40), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent})

        smallButton(
            "CANCEL",
            "Dark",
            ui2,
            function()
                --[[
                  line: 1540
                  upvalues:
                    act (copy, index: 1)
                    number (copy, index: 2)
                    a26 (copy, index: 3)
                    v614 (copy, index: 4)
                ]]
                if act("Uninvite", number) then
                    a26.Toast(`Invite to {v614.Text} withdrawn`, "info")
                end
            end,
            {Width = 110, TextSize = 15}
        )
    end

    local function renderMembers(tribe)
        --[[
          name: renderMembers
          line: 1547
          upvalues:
            clear (copy, index: 1)
            parent16 (copy, index: 2)
            ui5 (copy, index: 3)
            ui4 (copy, index: 4)
            section (copy, index: 5)
            child (copy, index: 6)
            udim2FromOffset (copy, index: 7)
            roleIn (copy, index: 8)
            smallButton (copy, index: 9)
            invitePicker (copy, index: 10)
            ui (copy, index: 11)
            colors (copy, index: 12)
            v27 (ref,  index: 13)
            theme (copy, index: 14)
            label (copy, index: 15)
            fonts (copy, index: 16)
            ago (copy, index: 17)
            textColor3 (copy, index: 18)
            act (copy, index: 19)
            memberRow (copy, index: 20)
            pendingRow (copy, index: 21)
        ]]
        local v629
        local v630
        local v631
        local v632
        clear(parent16)
        clear(ui5)
        clear(ui4)

        if type(tribe.membersList) ~= "table" then
            v629 = {}
        else
            v629 = tribe.membersList
        end

        local count = 0

        for _, v635 in v629 do
            if v635.where then
                count += 1
            end
        end

        section("MEMBERS", `{#v629}/{child.MAX_MEMBERS}`, `{count} online`, 1, ui4).Position = udim2FromOffset(0, 9)
        local v636 = roleIn(tribe)
        local v637 = v636 == "chief" or v636 == "elder"
        if v637 then
            smallButton(
                "INVITE PLAYERS",
                "Primary",
                ui5,
                function()
                    --[[
                      line: 1562
                      upvalues:
                        invitePicker (copy, index: 1)
                    ]]
                    invitePicker()
                end,
                {TextSize = 15, Size = UDim2.fromScale(1, 1), Icon = ui.Glyph("person-plus", 18, colors.Text)}
            )
        end

        local v638 = 0

        if type(tribe.requests) ~= "table" then
            v630 = {}
        else
            v630 = tribe.requests
        end

        if v637 and 0 < #v630 then
            local v639
            local layoutOrder = v638 + 1
            section("JOIN REQUESTS", #v630, nil, layoutOrder, parent16, colors.Warning)
            v639 = layoutOrder

            for _, v642 in v630 do
                local layoutOrder2 = v639 + 1
                local parent = ui.new("Frame", {Name = "R" .. tostring(v642.userId), Size = UDim2.new(1, -4, 0, v27.row), LayoutOrder = layoutOrder2, BackgroundColor3 = Color3.fromRGB(60, 46, 20), BackgroundTransparency = 0.35, ui.Corner(12), (ui.Stroke(colors.Warning, 1, 0.6)), Parent = parent16})
                ui.new("ImageLabel", {Name = "Head", Image = `rbxthumb://type=AvatarHeadShot&id={v642.userId}&w=150&h=150`, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = udim2FromOffset(v27.row - 18, v27.row - 18), BackgroundColor3 = colors.Raised, (ui.Corner(theme.Radius.Pill)), Parent = parent})
                local v645 = v27.row + 8
                label({Name = "Name", Text = tostring(v642.display), FontFace = fonts.Heavy, TextSize = v27.text, Position = udim2FromOffset(v645, (math.floor(v27.row / 2) - v27.text) - 2), Size = UDim2.new(1, -(v645 + 260), 0, v27.text + 4), Parent = parent})
                label({Name = "Sub", Text = `@{v642.name}  ·  Lv {v642.level}  ·  asked {(ago(v642.at))}`, FontFace = fonts.SemiBold, TextSize = v27.sub, TextColor3 = textColor3, Position = udim2FromOffset(v645, math.floor(v27.row / 2) + 3), Size = UDim2.new(1, -(v645 + 260), 0, v27.sub + 2), Parent = parent})
                local ui2 = ui.new("Frame", {Name = "Actions", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = udim2FromOffset(240, 40), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent})
                smallButton(
                    "ACCEPT",
                    "Success",
                    ui2,
                    function()
                        --[[
                          line: 1579
                          upvalues:
                            act (copy, index: 1)
                            v642 (copy, index: 2)
                        ]]
                        act("Respond", v642.userId, true)
                    end,
                    {Width = 110, LayoutOrder = 1, TextSize = 15}
                )
                smallButton(
                    "DECLINE",
                    "Dark",
                    ui2,
                    function()
                        --[[
                          line: 1582
                          upvalues:
                            act (copy, index: 1)
                            v642 (copy, index: 2)
                        ]]
                        act("Respond", v642.userId, false)
                    end,
                    {Width = 110, LayoutOrder = 2, TextSize = 15}
                )
                v639 = layoutOrder2
            end

            v638 = v639 + 1
            section("MEMBERS", nil, nil, v638, parent16)
        end

        local values = table.clone(v629)
        local v648 = {chief = 0, elder = 1, member = 2}

        table.sort(
            values,
            function(left, right)
                --[[
                  line: 1592
                  upvalues:
                    v648 (copy, index: 1)
                ]]
                local v651 = left.where and 0 or 1
                local v652 = right.where and 0 or 1

                if v651 ~= v652 then
                    return v651 < v652
                end
                if (v648[left.role] or 3) ~= (v648[right.role] or 3) then
                    return (v648[left.role] or 3) < (v648[right.role] or 3)
                end

                local number = tonumber(left.weekRenown) or 0

                return (tonumber(right.weekRenown) or 0) < number
            end
        )

        v631 = v638

        for v654, value in values do
            local layoutOrder = v631 + 1
            local v657 = memberRow(value, tribe, layoutOrder)
            ui.Enter(v657, Vector2.new(0, 8), math.min(v654 * 0.025, 0.25), UDim2.new())
            v631 = layoutOrder
        end

        if type(tribe.invites) ~= "table" then
            v632 = {}
        else
            v632 = tribe.invites
        end

        if v637 and 0 < #v632 then
            local layoutOrder = v631 + 1
            section("PENDING INVITES", `{#v632}/{tonumber(tribe.inviteMax) or 50}`, "expire after 24 h", layoutOrder, parent16, colors.Accent)
            local v659 = layoutOrder

            for _, v661 in v632 do
                v659 += 1
                pendingRow(v661, v659)
            end
        end
    end

    local parent17 = ui.new("Frame", {Name = "Top", Size = UDim2.new(1, 0, 0, 46), Parent = tab4.page})
    local parent18 = ui.new("Frame", {Name = "Period", Size = udim2FromOffset(280, 46), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, ui.Corner(theme.Radius.Pill), ui.Padding(4, 4, 4, 4), (ui.List(Enum.FillDirection.Horizontal, 4)), Parent = parent17})
    local v664 = "top"
    local v665 = {}

    for layoutOrder, v667 in {{"top", "THIS WEEK"}, {"alltime", "ALL TIME"}} do
        v665[v667[1]] = ui.new("TextButton", {Name = v667[1], Text = v667[2], AutoButtonColor = false, FontFace = fonts.Heavy, TextSize = 14, TextColor3 = colors.TextDim, Size = UDim2.new(0.5, -2, 1, 0), LayoutOrder = layoutOrder, BackgroundColor3 = colors.Accent, BackgroundTransparency = 1, (ui.Corner(theme.Radius.Pill)), Parent = parent18})
    end

    local v668 = label({Name = "Note", Text = "", RichText = true, TextSize = 15, FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(1, -300, 0, 20), Parent = parent17})
    local parent19 = ui.new("ScrollingFrame", {Name = "List", Position = udim2FromOffset(0, 58), Size = UDim2.new(1, 0, 1, -58), ScrollBarThickness = 3, Selectable = false, ui.List(Enum.FillDirection.Vertical, 8), (ui.Padding(4, 10, 10, 4)), Parent = tab4.page})
    local parent20 = ui.new("Frame", {Name = "Pinned", Visible = false, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, v27.row + 22), Parent = tab4.page})
    local parent21 = ui.new("Frame", {Name = "Empty", Visible = false, Position = udim2FromOffset(0, 120), Size = UDim2.new(1, 0, 0, 120), Parent = tab4.page})
    ui.Glyph("trophy", 48, colors.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = parent21})
    local v672 = label({Name = "Text", Text = "", TextSize = 17, FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Center, Position = udim2FromOffset(0, 60), Size = UDim2.new(1, 0, 0, 24), Parent = parent21})
    local v673 = {textColor32, Color3.fromRGB(196, 206, 222), Color3.fromRGB(222, 140, 74)}

    do
        local function boardValue(a675)
            --[[
              name: boardValue
              line: 1684
              upvalues:
                v664 (ref, index: 1)
            ]]
            local v676 = if v664 == "alltime" then a675.renown else a675.weekRenown
            return tonumber(v676) or 0
        end
    end

    local function boardRow(a678, a679, parent, layoutOrder: number, a682: boolean)
        --[[
          name: boardRow
          line: 1688
          upvalues:
            v27 (ref,  index: 1)
            ui (copy, index: 2)
            child (copy, index: 3)
            colors (copy, index: 4)
            openable (copy, index: 5)
            v673 (copy, index: 6)
            udim2FromOffset (copy, index: 7)
            theme (copy, index: 8)
            label (copy, index: 9)
            fonts (copy, index: 10)
            TribeEmblem (copy, index: 11)
            textColor3 (copy, index: 12)
            rowStat (copy, index: 13)
            v664 (ref,  index: 14)
            textColor32 (copy, index: 15)
        ]]
        local v683
        local v684
        local v685
        local v686 = v27.row + 8
        local parent2 = ui.new("TextButton", {Name = "R" .. tostring((a679 or 0)), Text = "", AutoButtonColor = false, Size = UDim2.new(1, -4, 0, v686), LayoutOrder = layoutOrder, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.1, ClipsDescendants = true, (ui.Corner(12)), Parent = parent})
        ui.Gradient(child.Color(a678.color1):Lerp(colors.Panel, 0.8), colors.PanelHi:Lerp(colors.Panel, 0.55), 0).Parent = parent2

        if a682 then
            v683 = ui.Stroke(colors.Accent, 2, 0)
        else
            v683 = ui.Stroke(colors.Stroke, 1, 0.92)
        end

        v683.Parent = parent2
        openable(parent2, v683, a678)
        local v688 = a679 and v673[a679]
        local v689 = ui.Compact and 46 or 56
        local newUi = ui.new
        local v691 = {Name = "Rank", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, (v689 / 2) + 10, 0.5, 0), Size = udim2FromOffset(v689 - 6, v689 - 6), BackgroundColor3 = v688
            or colors.Inset}
        v691.BackgroundTransparency = v688 and 0.78 or 1
        v691[1] = (ui.Corner(theme.Radius.Pill))
        v691.Parent = parent2
        local parent3 = newUi("Frame", v691)
        local v693 = {Name = "Text", Text = if a679 then tostring(a679) else "-"}
        v693.FontFace = fonts.Display
        v693.TextSize = if a679 and 100 <= a679 then v27.text else v27.text + 6
        v693.TextColor3 = v688 or colors.TextDim
        v693.TextXAlignment = Enum.TextXAlignment.Center
        v693.TextTruncate = Enum.TextTruncate.None
        v693.Size = UDim2.fromScale(1, 1)
        v693.Parent = parent3
        label(v693)
        local v694 = v689 + 14
        local newTribeEmblem = TribeEmblem.new
        local v696 = v27.row - 6
        local v697 = {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, v694, 0.5, 0), Parent = parent2}
        newTribeEmblem(v696, v697):Set(a678.icon, a678.color1, a678.color2, a678.tag)
        local v698 = v694 + v27.row + 8
        local v699 = ui.Compact and 96 or 260
        local v700 = {Name = "Name", RichText = true}
        local stringFormat = string.format
        local v702 = TribeEmblem.TagColor(a678.color1):ToHex()
        local tag = TribeEmblem.Tag

        if type(a678) ~= "table" then
            v684 = a678
        else
            v684 = a678.tag
        end

        v700.Text = stringFormat("<font color=\"#%s\">%s</font>  %s", v702, tag(v684), (tostring(a678.name or "")))
        v700.FontFace = fonts.Heavy
        v700.TextSize = v27.text
        v700.Position = udim2FromOffset(v698, (math.floor(v686 / 2) - v27.text) - 2)
        v700.Size = UDim2.new(1, -((v698 + v699) + 12), 0, v27.text + 2)
        v700.Parent = parent2
        label(v700)
        local number = tonumber(a678.members) or 0
        local number2 = tonumber(a678.held) or 0

        if number ~= 1 then
            v685 = "members"
        else
            v685 = "member"
        end

        local v706 = `{number} {v685}`

        if 0 < number2 and ui.Compact then
            local v707 = number2 ~= 1 and "maps" or "map"
            v706 ..= `  ·  holds {number2} {v707}`
        end

        if a682 then
            v706 = `<font color="#{(colors.Accent:ToHex())}">Your tribe</font>  ·  ` .. v706
        end

        label({Name = "Sub", RichText = true, Text = v706, FontFace = fonts.SemiBold, TextSize = v27.sub, TextColor3 = textColor3, Position = udim2FromOffset(v698, math.floor(v686 / 2) + 3), Size = UDim2.new(1, -((v698 + v699) + 12), 0, v27.sub + 2), Parent = parent2})
        local ui2 = ui.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = udim2FromOffset(v699, 40), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent2})

        if not ui.Compact then
            local v709
            rowStat(ui2, `{number}/{child.MAX_MEMBERS}`, "MEMBERS", 1)
            local text = tostring(number2)

            if not (0 < number2) then
                v709 = colors.TextDim
            else
                v709 = colors.Text
            end

            rowStat(ui2, text, "MAPS HELD", 2, v709)
        end

        local formatNumber = ui.FormatNumber
        local v712 = if v664 == "alltime" then a678.renown else a678.weekRenown
        rowStat(ui2, formatNumber((tonumber(v712) or 0)), "GLORY", 3, textColor32)

        return parent2
    end

    local function paintPeriod()
        --[[
          name: paintPeriod
          line: 1762
          upvalues:
            v665 (copy, index: 1)
            v664 (ref,  index: 2)
            colors (copy, index: 3)
            v668 (copy, index: 4)
            untilText (copy, index: 5)
            child (copy, index: 6)
        ]]
        for v714, v715 in v665 do
            v715.BackgroundTransparency = v714 ~= v664 and 1 or 0
            v715.TextColor3 = if v714 == v664 then colors.Text else colors.TextDim
        end

        if v664 == "top" then
            v668.Text = `Resets in <font color="#{colors.Text:ToHex()}">{(untilText(child.WeekEndsAt(child.WeekOf(os.time()))))}</font>`
            return
        end

        v668.Text = "Every match since tribes began"
    end

    local count4 = 0
    local count5 = 0
    local formattedText = nil
    local v719 = nil
    local v720 = nil

    local function drawPin(a722)
        --[[
          name: drawPin
          line: 1785
          upvalues:
            v664 (ref,  index: 1)
            httpService (copy, index: 2)
            v720 (ref,  index: 3)
            clear (copy, index: 4)
            parent20 (copy, index: 5)
            parent19 (copy, index: 6)
            v27 (ref,  index: 7)
            ui (copy, index: 8)
            udim2FromOffset (copy, index: 9)
            colors (copy, index: 10)
            boardRow (copy, index: 11)
        ]]
        local v723
        local v724 = v664
        local success, result = pcall(httpService.JSONEncode, httpService, (a722 or false))

        if success then
            v723 = result
        else
            v723 = tostring(os.clock())
        end

        local v727 = v724 .. v723

        if v727 == v720 then
            return
        end

        v720 = v727
        clear(parent20)

        if type(a722) == "table" then
            if type(a722.tribe) == "table" then
                local rank
                local tribe = a722.tribe
                local v730 = if v664 == "alltime" then tribe.renown else tribe.weekRenown

                if not (0 < (tonumber(v730) or 0)) or type(a722.rank) ~= "number" then
                    rank = nil
                    parent20.Visible = true
                    parent20.Size = UDim2.new(1, 0, 0, v27.row + 22)
                    parent19.Size = UDim2.new(1, 0, 1, -((58 + v27.row) + 26))
                    ui.new("Frame", {Name = "Rule", BackgroundTransparency = 0.85, Position = udim2FromOffset(4, 2), Size = UDim2.new(1, -18, 0, 1), BackgroundColor3 = colors.Stroke, Parent = parent20})
                    local v731 = boardRow(tribe, rank, parent20, 1, true)
                    v731.AnchorPoint = Vector2.new(0, 1)
                    v731.Position = UDim2.new(0, 4, 1, -4)
                    v731.Size = UDim2.new(1, -18, 0, v27.row + 8)
                    ui.Enter(v731, Vector2.new(0, 10), 0.1, UDim2.new(0, 4, 1, -4))

                    return
                end

                rank = a722.rank
                parent20.Visible = true
                parent20.Size = UDim2.new(1, 0, 0, v27.row + 22)
                parent19.Size = UDim2.new(1, 0, 1, -((58 + v27.row) + 26))
                ui.new("Frame", {Name = "Rule", BackgroundTransparency = 0.85, Position = udim2FromOffset(4, 2), Size = UDim2.new(1, -18, 0, 1), BackgroundColor3 = colors.Stroke, Parent = parent20})
                local v731 = boardRow(tribe, rank, parent20, 1, true)
                v731.AnchorPoint = Vector2.new(0, 1)
                v731.Position = UDim2.new(0, 4, 1, -4)
                v731.Size = UDim2.new(1, -18, 0, v27.row + 8)
                ui.Enter(v731, Vector2.new(0, 10), 0.1, UDim2.new(0, 4, 1, -4))

                return
            end
        end

        parent20.Visible = false
        parent19.Size = UDim2.new(1, 0, 1, -58)
    end

    local function showBoard(a733, a734: number)
        --[[
          name: showBoard
          line: 1809
          upvalues:
            v42 (ref,  index: 1)
            roleIn (copy, index: 2)
            tribes (copy, index: 3)
            v664 (ref,  index: 4)
            drawPin (copy, index: 5)
            count5 (ref,  index: 6)
            count4 (ref,  index: 7)
            httpService (copy, index: 8)
            v720 (ref,  index: 9)
            clear (copy, index: 10)
            parent20 (copy, index: 11)
            parent19 (copy, index: 12)
            formattedText (ref,  index: 13)
            v719 (ref,  index: 14)
            parent21 (copy, index: 15)
            v672 (copy, index: 16)
            boardRow (copy, index: 17)
            ui (copy, index: 18)
        ]]
        local v735
        local v736
        local v737
        local tribe = v42 and v42.tribe

        if type(tribe) ~= "table" then
            v735 = tribes.Mine()
        else
            v735 = {id = tribe.id, role = roleIn(tribe)}
        end

        local v739 = if v735 then v735.id else nil
        local v740 = {}
        local v741 = false
        v736 = v741

        for _, v743 in a733 do
            if type(v743) == "table" then
                local v744 = if v664 == "alltime" then v743.renown else v743.weekRenown

                if not (0 < (tonumber(v744) or 0)) then
                    continue
                end

                table.insert(v740, v743)
                local v745 = v736 or v739 ~= nil and v743.id == v739
                v736 = v745
            end
        end

        local function pin()
            --[[
              name: pin
              line: 1821
              upvalues:
                v739 (copy, index: 1)
                v736 (ref,  index: 2)
                drawPin (copy, index: 3)
                tribes (copy, index: 4)
                v664 (ref,  index: 5)
                count5 (ref,  index: 6)
                a734 (copy, index: 7)
                count4 (ref,  index: 8)
                httpService (copy, index: 9)
                v720 (ref,  index: 10)
                clear (copy, index: 11)
                parent20 (copy, index: 12)
                parent19 (copy, index: 13)
            ]]
            local v747

            if v739 and not v736 then
                drawPin(tribes.CachedRank(v664))
                local v748 = v664
                local v749 = count5

                task.spawn(
                    function()
                        --[[
                          line: 1825
                          upvalues:
                            tribes (copy, index: 1)
                            v748 (copy, index: 2)
                            a734 (copy, index: 3)
                            count4 (ref,  index: 4)
                            v749 (copy, index: 5)
                            count5 (ref,  index: 6)
                            drawPin (copy, index: 7)
                        ]]
                        local v750, v751 = tribes.Rank(v748)

                        if v750 and a734 == count4 and v749 == count5 then
                            drawPin(v751)
                        end
                    end
                )

                return
            end

            local v752 = v664
            local success, result = pcall(httpService.JSONEncode, httpService, false)

            if success then
                v747 = result
            else
                v747 = tostring(os.clock())
            end

            local v755 = v752 .. v747

            if v755 == v720 then
                return
            end

            v720 = v755
            clear(parent20)
            parent20.Visible = false
            parent19.Size = UDim2.new(1, 0, 1, -58)
        end

        local v756 = v664
        local success, result = pcall(httpService.JSONEncode, httpService, a733)

        if success then
            v737 = result
        else
            v737 = tostring(os.clock())
        end

        local formattedText2 = `{v756}|{v739 or 0}|{v737}`

        if formattedText2 == formattedText then
            pin()
            return
        end

        local v760 = v719 ~= v664
        formattedText = formattedText2
        v719 = v664
        count5 += 1
        local v761 = count5
        clear(parent19)
        parent21.Visible = #v740 == 0
        v672.Text = v664 ~= "top" and "No tribe has earned Glory yet."
            or "No Glory yet this week. Win matches with tribemates to climb."

        local function build(key: number)
            --[[
              name: build
              line: 1847
              upvalues:
                v740 (copy, index: 1)
                boardRow (copy, index: 2)
                parent19 (copy, index: 3)
                v739 (copy, index: 4)
                v760 (copy, index: 5)
                ui (copy, index: 6)
            ]]
            local v764 = v740[key]
            local v765 = boardRow(v764, key, parent19, key, ((v739 ~= nil) and (v764.id == v739)))

            if v760 and key <= 10 then
                ui.Enter(v765, Vector2.new(0, 10), math.min(key * 0.03, 0.3), UDim2.new())
            end
        end

        for index = 1, math.min(#v740, 10) do
            build(index)
        end

        if 10 < #v740 then
            task.spawn(
                function()
                    --[[
                      line: 1858
                      upvalues:
                        v740 (copy, index: 1)
                        v761 (copy, index: 2)
                        count5 (ref,  index: 3)
                        build (copy, index: 4)
                    ]]
                    for index = 11, #v740 do
                        if (index - 10) % 8 == 1 then
                            task.wait()

                            if v761 ~= count5 then
                                return
                            end
                        end

                        build(index)
                    end
                end
            )
        end

        pin()
    end

    do
        local function loadBoard()
            --[[
              name: loadBoard
              line: 1872
              upvalues:
                count4 (ref,  index: 1)
                v664 (ref,  index: 2)
                paintPeriod (copy, index: 3)
                tribes (copy, index: 4)
                showBoard (copy, index: 5)
                v719 (ref,  index: 6)
                formattedText (ref,  index: 7)
                count5 (ref,  index: 8)
                clear (copy, index: 9)
                parent19 (copy, index: 10)
                httpService (copy, index: 11)
                v720 (ref,  index: 12)
                parent20 (copy, index: 13)
                parent21 (copy, index: 14)
                ui (copy, index: 15)
                v27 (ref,  index: 16)
                colors (copy, index: 17)
                v672 (copy, index: 18)
                child (copy, index: 19)
            ]]
            count4 += 1
            local v769 = count4
            local v770 = v664
            paintPeriod()
            local v771 = tribes.CachedBoard(v770)

            if type(v771) ~= "table" then
                if v719 ~= v770 then
                    local v772
                    formattedText = nil
                    v719 = nil
                    count5 += 1
                    clear(parent19)
                    local v773 = v770
                    local success, result = pcall(httpService.JSONEncode, httpService, false)

                    if success then
                        v772 = result
                    else
                        v772 = tostring(os.clock())
                    end

                    local v776 = v773 .. v772

                    if v776 ~= v720 then
                        v720 = v776
                        clear(parent20)
                        parent20.Visible = false
                        parent19.Size = UDim2.new(1, 0, 1, -58)
                    end

                    parent21.Visible = false

                    for layoutOrder = 1, 5 do
                        local ui2 = ui.new("Frame", {Name = "Skeleton", Size = UDim2.new(1, -4, 0, v27.row + 8), LayoutOrder = layoutOrder, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.5, (ui.Corner(12)), Parent = parent19})
                        local v779 = {BackgroundTransparency = 0.78}
                        ui.Tween(ui2, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, layoutOrder * 0.12), v779)
                    end
                end
            else
                showBoard(v771, v769)
            end

            local v780, v781 = tribes.Board(v770)

            if v769 ~= count4 then
                return
            end

            if v780 and type(v781) == "table" then
                showBoard(v781, v769)
                return
            end

            if type(v771) ~= "table" then
                local v782
                formattedText = nil
                v719 = nil
                count5 += 1
                clear(parent19)
                local v783 = v770
                local success, result = pcall(httpService.JSONEncode, httpService, false)

                if success then
                    v782 = result
                else
                    v782 = tostring(os.clock())
                end

                local v786 = v783 .. v782

                if v786 ~= v720 then
                    v720 = v786
                    clear(parent20)
                    parent20.Visible = false
                    parent19.Size = UDim2.new(1, 0, 1, -58)
                end

                parent21.Visible = true
                v672.Text = tostring((v781 or child.Message("unavailable")))
            end
        end

        for v787, v788 in v665 do
            v788.Activated:Connect(
                function()
                    --[[
                      line: 1908
                      upvalues:
                        v664 (ref,  index: 1)
                        v787 (copy, index: 2)
                        timestamp (ref,  index: 3)
                        a26 (copy, index: 4)
                        loadBoard (copy, index: 5)
                    ]]
                    if v664 ~= v787 and 0.5 <= os.clock() - timestamp then
                        v664 = v787
                        a26.Sounds.Play("Click")
                        loadBoard()
                    end
                end
            )
        end

        v141.Leaderboard = loadBoard
    end

    local parent22 = ui.new("Frame", {Name = "MapArea", BackgroundColor3 = Color3.fromRGB(14, 52, 92), BackgroundTransparency = 0, ClipsDescendants = true, ui.Corner(14), (ui.Stroke(colors.Stroke, 1, 0.9)), Parent = tab5.page})
    local parent23 = column("Side", tab5.page, 10)
    local parent24 = ui.new("Frame", {Name = "Layer", Size = UDim2.fromScale(1, 1), Parent = parent22})
    local parent25 = ui.new("ScrollingFrame", {Name = "Tiles", Size = UDim2.fromScale(1, 1), ScrollBarThickness = 3, Selectable = false, Visible = false, (ui.Padding(12, 12, 12, 12)), Parent = parent22})
    local ui6 = ui.new("UIGridLayout", {CellSize = udim2FromOffset(200, 150), CellPadding = udim2FromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent25})

    do
        local v794 = label({Name = "Loading", Text = "Loading the map...", TextSize = 17, FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = parent22})
        local parent26 = ui.new("Frame", {Name = "Legend", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -10), AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 30), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.35, ZIndex = 6, ui.Corner(theme.Radius.Pill), ui.Padding(0, 12, 0, 10), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent22})
        ui.new("Frame", {Name = "Ring", Size = udim2FromOffset(14, 14), BackgroundTransparency = 1, LayoutOrder = 1, ZIndex = 6, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Accent, 2, 0)), Parent = parent26})
        caps("YOUR TRIBE", {LayoutOrder = 2, ZIndex = 6, Size = udim2FromOffset(76, 14), TextColor3 = colors.TextDim, Parent = parent26})
        ui.new("Frame", {Name = "Fog", Size = udim2FromOffset(14, 14), BackgroundColor3 = Color3.fromRGB(58, 64, 78), LayoutOrder = 3, ZIndex = 6, (ui.Corner(theme.Radius.Pill)), Parent = parent26})
        caps("NOT IN ROTATION", {LayoutOrder = 4, ZIndex = 6, Size = udim2FromOffset(108, 14), TextColor3 = colors.TextDim, Parent = parent26})
        local v796 = nil
        local v797 = nil

        do
            local function holderOf(mapKey)
                --[[
                  name: holderOf
                  line: 1934
                  upvalues:
                    v797 (ref, index: 1)
                ]]
                local map = v797 and v797.maps and v797.maps[mapKey]

                if map and map.holder then
                    return v797.tribes and v797.tribes[tostring(map.holder)]
                end

                return nil
            end
        end

        local v801 = nil
        local v802 = {}

        local function regionAt(a804, a805)
            --[[
              name: regionAt
              line: 1946
              upvalues:
                TribeMapGrid (copy, index: 1)
                v802 (copy, index: 2)
            ]]
            local v806 = math.floor(a804 / TribeMapGrid.cell) + 1
            local rowKey = math.floor(a805 / TribeMapGrid.cell) + 1
            local row = TribeMapGrid.rows[rowKey]

            if not row or v806 < 1 or TribeMapGrid.cols < v806 then
                return nil
            end

            local v809 = v802[rowKey]
            if not v809 then
                v809 = {}

                for pattern, v811 in string.gmatch(row, "(%D)(%d+)") do
                    local v813 = if const startIndex = string.find("abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXY", pattern, 1, true) then TribeMapGrid.keys[startIndex]
                        or false else false

                    for _ = 1, tonumber(v811) or 0 do
                        table.insert(v809, v813)
                    end
                end

                v802[rowKey] = v809
            end

            return v809[v806] or nil
        end

        local v815 = nil

        do
            local function selectTerritory(a817)
                --[[
                  name: selectTerritory
                  line: 1968
                  upvalues:
                    timestamp (ref,  index: 1)
                    v796 (ref,  index: 2)
                    a26 (copy, index: 3)
                    v815 (ref,  index: 4)
                    v801 (ref,  index: 5)
                ]]
                if not (0.5 <= os.clock() - timestamp) then
                    return
                end

                if v796 ~= a817 then
                    a26.Sounds.Play("Click")
                end

                v796 = a817
                v815()
                v801(a817)
            end
        end

        v815 = function()
            --[[
              line: 1980
              upvalues:
                v794 (copy, index: 1)
                v797 (ref,  index: 2)
                clear (copy, index: 3)
                parent24 (copy, index: 4)
                parent25 (copy, index: 5)
                ui6 (copy, index: 6)
                v42 (ref,  index: 7)
                roleIn (copy, index: 8)
                tribes (copy, index: 9)
                TribeArt (copy, index: 10)
                parent26 (copy, index: 11)
                parent22 (copy, index: 12)
                ui (copy, index: 13)
                udim2FromOffset (copy, index: 14)
                regionAt (copy, index: 15)
                timestamp (ref,  index: 16)
                v796 (ref,  index: 17)
                a26 (copy, index: 18)
                v815 (ref,  index: 19)
                v801 (ref,  index: 20)
                child (copy, index: 21)
                TribeEmblem (copy, index: 22)
                colors (copy, index: 23)
                theme (copy, index: 24)
                label (copy, index: 25)
                fonts (copy, index: 26)
                textColor3 (copy, index: 27)
            ]]
            local v818
            v794.Visible = v797 == nil
            clear(parent24)
            clear(parent25)
            ui6.Parent = parent25

            if not v797 then
                return
            end

            local v819 = v42 and v42.tribe

            if type(v819) ~= "table" then
                v818 = tribes.Mine()
            else
                v818 = {id = v819.id, role = roleIn(v819)}
            end

            if type(v797.order) ~= "table" then
                v819 = {}
            else
                v819 = v797.order
            end

            local visible = TribeArt.Map.image ~= ""
            parent25.Visible = not visible
            parent24.Visible = visible
            parent26.Visible = visible

            if not visible then
                local _, _

                for layoutOrder, v824 in v819 do
                    local tribe
                    local v826
                    local formattedText
                    local map = v797.maps[v824]
                    local map2 = v797 and v797.maps and v797.maps[v824]

                    if not map2 or not map2.holder then
                        tribe = nil
                    else
                        tribe = v797.tribes and v797.tribes[tostring(map2.holder)]
                    end

                    local parent = ui.new("TextButton", {Name = v824, Text = "", AutoButtonColor = false, LayoutOrder = layoutOrder, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.2, ClipsDescendants = true, (ui.Corner(12)), Parent = parent25})
                    local v831 = tribe and v818 and tribe.id == v818.id
                    local stroke = ui.Stroke

                    if v796 == v824 then
                        v826 = colors.Text
                    else
                        v826 = if v831 then colors.Accent else colors.Stroke
                    end

                    local v833 = v796 ~= v824 and not v831 and 1 or 2
                    local v834 = v796 ~= v824 and (v831 and 0 or 0.9) or 0.1
                    stroke(v826, v833, v834).Parent = parent
                    local newUi = ui.new
                    local v836 = {Name = "Thumb"}
                    local thumb = map and map.thumb or ""
                    v836.Image = tostring(thumb)
                    v836.Size = UDim2.new(1, 0, 0, 100)
                    v836.ScaleType = Enum.ScaleType.Crop
                    v836.BackgroundColor3 = colors.Raised
                    v836.Parent = parent
                    newUi("ImageLabel", v836)

                    if tribe then
                        ui.new("Frame", {Name = "Tint", BackgroundTransparency = 0.7, Size = UDim2.new(1, 0, 0, 100), BackgroundColor3 = child.Color(tribe.color1), Parent = parent})
                        local newTribeEmblem = TribeEmblem.new
                        local v839 = {Position = udim2FromOffset(8, 50), Parent = parent}
                        newTribeEmblem(44, v839):Set(tribe.icon, tribe.color1, tribe.color2, tribe.tag)
                    end

                    local v840 = {Name = "Name", TextSize = 16}
                    local v841 = map and map.name or v824
                    v840.Text = tostring(v841)
                    v840.FontFace = fonts.Heavy
                    v840.Position = udim2FromOffset(10, 104)
                    v840.Size = UDim2.new(1, -20, 0, 20)
                    v840.Parent = parent
                    label(v840)
                    local v842 = {Name = "By", TextSize = 14}

                    if tribe then
                        local v843
                        local tag = TribeEmblem.Tag

                        if type(tribe) == "table" then
                            v843 = tribe.tag
                        else
                            v843 = tribe
                        end

                        formattedText = `Held by {(tag(v843))}`
                    else
                        formattedText = "Unclaimed"
                    end

                    v842.Text = formattedText
                    v842.FontFace = fonts.SemiBold
                    v842.TextColor3 = if tribe then TribeEmblem.TagColor(tribe.color1) else textColor3
                    v842.Position = udim2FromOffset(10, 124)
                    v842.Size = UDim2.new(1, -20, 0, 18)
                    v842.Parent = parent
                    label(v842)

                    parent.Activated:Connect(
                        function()
                            --[[
                              line: 2082
                              upvalues:
                                timestamp (ref,  index: 1)
                                a26 (copy, index: 2)
                                v796 (ref,  index: 3)
                                v824 (copy, index: 4)
                                v815 (ref,  index: 5)
                                v801 (ref,  index: 6)
                            ]]
                            if 0.5 <= os.clock() - timestamp then
                                a26.Sounds.Play("Click")
                                v796 = v824
                                v815()
                                v801(v824)
                            end
                        end
                    )
                end

                return
            end

            local v845 = parent22.AbsoluteSize / math.max(ui.Scale, 0.01)
            local size = TribeArt.Map.size
            local v847 = math.min(v845.X / size.X, v845.Y / size.Y)
            local flooredValue = math.floor(size.X * v847)
            local flooredValue2 = math.floor(size.Y * v847)
            local flooredValue3 = math.floor((v845.X - flooredValue) / 2)
            local flooredValue4 = math.floor((v845.Y - flooredValue2) / 2)
            ui.new("ImageLabel", {Name = "Base", ZIndex = 1, Image = TribeArt.Map.image, Position = udim2FromOffset(flooredValue3, flooredValue4), Size = udim2FromOffset(flooredValue, flooredValue2), Parent = parent24})
            local ui2 = ui.new("TextButton", {Name = "Hit", Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 3, Position = udim2FromOffset(flooredValue3, flooredValue4), Size = udim2FromOffset(flooredValue, flooredValue2), Parent = parent24})

            ui2.Activated:Connect(
                function()
                    --[[
                      line: 2005
                      upvalues:
                        ui2 (copy, index: 1)
                        ui (copy, index: 2)
                        regionAt (copy, index: 3)
                        size (copy, index: 4)
                        v819 (copy, index: 5)
                        timestamp (ref,  index: 6)
                        v796 (ref,  index: 7)
                        a26 (copy, index: 8)
                        v815 (ref,  index: 9)
                        v801 (ref,  index: 10)
                    ]]
                    local absoluteSize = ui2.AbsoluteSize

                    if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
                        return
                    end

                    local v854 = (ui.PointerAbs() - ui2.AbsolutePosition) / absoluteSize
                    local target = regionAt(v854.X * size.X, v854.Y * size.Y)

                    if target and table.find(v819, target) then
                        if not (0.5 <= os.clock() - timestamp) then
                            return
                        end

                        if v796 ~= target then
                            a26.Sounds.Play("Click")
                        end

                        v796 = target
                        v815()
                        v801(target)
                    end
                end
            )

            local _

            for mapKey, region in TribeArt.Map.regions do
                local tribe
                local v860 = table.find(v819, mapKey) ~= nil

                if v860 then
                    local map = v797 and v797.maps and v797.maps[mapKey]

                    if not map or not map.holder then
                        tribe = nil
                    else
                        tribe = v797.tribes and v797.tribes[tostring(map.holder)]
                    end
                else
                    tribe = nil
                end

                local v862 = region.bbox[1]
                local v863 = region.bbox[2]
                local v864 = region.bbox[3]
                local v865 = region.bbox[4]

                if region.mask ~= "" then
                    local imageColor3
                    local imageTransparency
                    local v868 = v796 == mapKey
                    local newUi = ui.new
                    local v870 = {ZIndex = 2, Name = "Mask_" .. mapKey, Image = region.mask}

                    if tribe then
                        imageColor3 = child.Color(tribe.color1)
                    else
                        imageColor3 = if v860 then Color3.new(1, 1, 1) else Color3.fromRGB(58, 64, 78)
                    end

                    v870.ImageColor3 = imageColor3

                    if tribe then
                        imageTransparency = v868 and 0.3 or 0.42
                    else
                        imageTransparency = v860 and (v868 and 0.8 or 1) or 0.28
                    end

                    v870.ImageTransparency = imageTransparency
                    v870.Position = udim2FromOffset(flooredValue3 + math.floor(v862 * v847), flooredValue4 + math.floor(v863 * v847))
                    v870.Size = udim2FromOffset(math.ceil((v864 - v862) * v847), (math.ceil((v865 - v863) * v847)))
                    v870.Parent = parent24
                    newUi("ImageLabel", v870)
                end

                if v860 then
                    local v871 = flooredValue3 + region.anchor[1] * v847
                    local v872 = flooredValue4 + region.anchor[2] * v847
                    local parent = ui.new("TextButton", {Text = "", AutoButtonColor = false, ZIndex = 4, Name = "Pin_" .. mapKey, AnchorPoint = Vector2.new(0.5, 0.92), Position = udim2FromOffset(math.floor(v871), (math.floor(v872))), Size = udim2FromOffset(64, 70), Parent = parent24})

                    if tribe then
                        local newTribeEmblem = TribeEmblem.new
                        local v875 = ui.Compact and 58 or 54
                        local v876 = {ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent}
                        newTribeEmblem(v875, v876):Set(tribe.icon, tribe.color1, tribe.color2, tribe.tag)
                    else
                        ui.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.62), Size = udim2FromOffset(14, 14), BackgroundColor3 = colors.Text, ZIndex = 4, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Void, 2, 0.3)), Parent = parent})
                    end

                    if tribe and v818 and tribe.id == v818.id then
                        local newUi = ui.new
                        local v878 = {Name = "Mine", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}
                        local v879 = ui.Compact and 70 or 66
                        local v880 = ui.Compact and 76 or 72
                        v878.Size = udim2FromOffset(v879, v880)
                        v878.ZIndex = 3
                        v878[1], v878[2] = ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Accent, 3, 0))
                        v878.Parent = parent
                        newUi("Frame", v878)
                    end

                    if v796 == mapKey then
                        local v881 = ui.Pill(tribes.MapName(mapKey), colors.Void, {Height = 24, TextSize = 13, Transparency = 0.15, ZIndex = 5, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0, -2), Parent = parent})
                        ui.Pop(v881, 0.85)
                    end

                    parent.Activated:Connect(
                        function()
                            --[[
                              line: 2061
                              upvalues:
                                mapKey (copy, index: 1)
                                timestamp (ref,  index: 2)
                                v796 (ref,  index: 3)
                                a26 (copy, index: 4)
                                v815 (ref,  index: 5)
                                v801 (ref,  index: 6)
                            ]]
                            local mapKey2 = mapKey

                            if not (0.5 <= os.clock() - timestamp) then
                                return
                            end

                            if v796 ~= mapKey2 then
                                a26.Sounds.Play("Click")
                            end

                            v796 = mapKey2
                            v815()
                            v801(mapKey2)
                        end
                    )
                end
            end
        end

        v801 = function(mapKey)
            --[[
              line: 2094
              upvalues:
                clear (copy, index: 1)
                parent23 (copy, index: 2)
                v797 (ref,  index: 3)
                v42 (ref,  index: 4)
                roleIn (copy, index: 5)
                tribes (copy, index: 6)
                ui (copy, index: 7)
                colors (copy, index: 8)
                label (copy, index: 9)
                fonts (copy, index: 10)
                timestamp (ref,  index: 11)
                a26 (copy, index: 12)
                v45 (ref,  index: 13)
                TribeEmblem (copy, index: 14)
                udim2FromOffset (copy, index: 15)
                caps (copy, index: 16)
                backgroundColor3 (copy, index: 17)
                theme (copy, index: 18)
                child (copy, index: 19)
                textColor32 (copy, index: 20)
                untilText (copy, index: 21)
                section (copy, index: 22)
                openable (copy, index: 23)
                textColor3 (copy, index: 24)
            ]]
            local v884
            local v885
            clear(parent23)

            if not v797 then
                return
            end

            local tribe = v42 and v42.tribe

            if type(tribe) ~= "table" then
                v884 = tribes.Mine()
            else
                v884 = {id = tribe.id, role = roleIn(tribe)}
            end

            if mapKey and v797.maps and v797.maps[mapKey] then
                local tribe3
                local v888
                local map = v797.maps[mapKey]
                local map2 = v797 and v797.maps and v797.maps[mapKey]

                if not map2 or not map2.holder then
                    tribe3 = nil
                else
                    tribe3 = v797.tribes and v797.tribes[tostring(map2.holder)]
                end

                local parent = ui.Panel({Name = "Selected", BackgroundTransparency = 0.06, LayoutOrder = 1, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = parent23})
                ui.Padding(10, 10, 10, 10).Parent = parent
                ui.List(Enum.FillDirection.Vertical, 8).Parent = parent
                local parent2 = ui.new("ImageLabel", {Name = "Thumb", Image = tostring((map.thumb or "")), Size = UDim2.new(1, 0, 0, 150), ScaleType = Enum.ScaleType.Crop, BackgroundColor3 = colors.Raised, ClipsDescendants = true, LayoutOrder = 1, (ui.Corner(10)), Parent = parent})
                ui.new("Frame", {Name = "Shade", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ui.Gradient(Color3.new(0, 0, 0), Color3.new(0, 0, 0), 90, NumberSequence.new(1, 0.1)), (ui.Corner(10)), Parent = parent2})
                label({Name = "Name", TextSize = 22, Text = string.upper((tostring(map.name or mapKey))), FontFace = fonts.Display, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -8), Size = UDim2.new(1, -24, 0, 26), Parent = parent2})
                local parent3 = ui.new("TextButton", {Name = "Holder", Text = "", AutoButtonColor = false, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 54), Parent = parent})

                if tribe3 then
                    parent3.Activated:Connect(
                        function()
                            --[[
                              line: 2111
                              upvalues:
                                timestamp (ref,  index: 1)
                                a26 (copy, index: 2)
                                v45 (ref,  index: 3)
                                tribe3 (copy, index: 4)
                            ]]
                            if 0.5 <= os.clock() - timestamp then
                                a26.Sounds.Play("Click")
                                v45(tribe3.id, tribe3)
                            end
                        end
                    )

                    TribeEmblem.new(48, {Position = udim2FromOffset(2, 1), Parent = parent3}):Set(tribe3.icon, tribe3.color1, tribe3.color2, tribe3.tag)
                    local text = v884 and tribe3.id == v884.id and "HELD BY YOUR TRIBE" or "HELD BY"
                    local v895
                    local options = {Position = udim2FromOffset(60, 8), Size = UDim2.new(1, -60, 0, 14), TextColor3 = if v884
                        and tribe3.id == v884.id then colors.Accent else colors.TextMuted}
                    options.Parent = parent3
                    caps(text, options)
                    local v897 = {Name = "By", RichText = true, TextSize = 16}
                    local stringFormat = string.format
                    local v899 = TribeEmblem.TagColor(tribe3.color1):ToHex()
                    local tag = TribeEmblem.Tag

                    if type(tribe3) ~= "table" then
                        v895 = tribe3
                    else
                        v895 = tribe3.tag
                    end

                    local v901 = tag(v895)
                    local name = tribe3.name or ""
                    v897.Text = stringFormat("<font color=\"#%s\">%s</font>  %s", v899, v901, (tostring(name)))
                    v897.FontFace = fonts.Heavy
                    v897.Position = udim2FromOffset(60, 24)
                    v897.Size = UDim2.new(1, -60, 0, 20)
                    v897.Parent = parent3
                    label(v897)
                else
                    ui.Glyph("flag", 26, colors.TextMuted, {Position = udim2FromOffset(8, 8), Parent = parent3})
                    caps("UNCLAIMED", {Position = udim2FromOffset(50, 3), Size = UDim2.new(1, -50, 0, 14), Parent = parent3})
                    label({Name = "By", Text = "Win a match here to claim it", TextSize = 15, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Position = udim2FromOffset(50, 19), Size = UDim2.new(1, -50, 0, 20), Parent = parent3})
                end

                if type(map.top) ~= "table" then
                    v888 = {}
                else
                    v888 = map.top
                end

                if 0 < #v888 then
                    caps("THIS WEEK", {LayoutOrder = 3, Parent = parent})
                end

                local v903 = not v888[1] and 1 or tonumber(v888[1].points) or 1
                local tribe2

                for v905, v906 in v888 do
                    tribe2 = v906.tribe

                    if type(tribe2) == "table" then
                        local v907
                        local parent4 = ui.new("Frame", {Name = "Top" .. v905, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 3 + v905, Parent = parent})
                        caps(tostring(v905), {Position = udim2FromOffset(0, 12), Size = udim2FromOffset(12, 14), TextXAlignment = Enum.TextXAlignment.Center, Parent = parent4})
                        local newTribeEmblem = TribeEmblem.new
                        local v910 = {Position = udim2FromOffset(16, 1), Parent = parent4}
                        newTribeEmblem(32, v910):Set(tribe2.icon, tribe2.color1, tribe2.color2, tribe2.tag)
                        local v911 = {Name = "Tag", TextSize = 14}
                        local tag = TribeEmblem.Tag

                        if type(tribe2) == "table" then
                            v907 = tribe2.tag
                        else
                            v907 = tribe2
                        end

                        v911.Text = tag(v907)
                        v911.FontFace = fonts.Heavy
                        v911.TextColor3 = TribeEmblem.TagColor(tribe2.color1)
                        v911.Position = udim2FromOffset(56, 3)
                        v911.Size = udim2FromOffset(80, 16)
                        v911.Parent = parent4
                        label(v911)
                        local parent5 = ui.new("Frame", {Name = "Bar", Position = udim2FromOffset(56, 23), Size = UDim2.new(1, -112, 0, 6), BackgroundColor3 = backgroundColor3, (ui.Corner(theme.Radius.Pill)), Parent = parent4})
                        local ui2 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = child.Color(tribe2.color1), (ui.Corner(theme.Radius.Pill)), Parent = parent5})
                        ui.Tween(ui2, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, v905 * 0.05), {Size = UDim2.fromScale(math.clamp((tonumber(v906.points)
                            or 0) / v903, 0.04, 1), 1)})
                        label({Name = "Pts", TextSize = 16, Text = tostring(v906.points), FontFace = fonts.Display, TextColor3 = textColor32, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 9), Size = udim2FromOffset(50, 20), Parent = parent4})
                    end
                end

                if v884 and 0 < #v888 and (not tribe3 or tribe3.id ~= v884.id) then
                    local v915
                    local v916 = 0
                    v915 = v916

                    for _, v918 in v888 do
                        if type(v918.tribe) == "table" then
                            if v918.tribe.id ~= v884.id then
                                continue
                            end

                            v915 = tonumber(v918.points) or 0
                        end
                    end

                    local v919 = not v888[1] and 0 or tonumber(v888[1].points) or 0
                    label({Name = "Mine", TextSize = 14, TextWrapped = true, LayoutOrder = 9, Text = `Your tribe needs {(v919 - v915) + 1} more Glory here to take it`, FontFace = fonts.Bold, TextColor3 = colors.Accent, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = parent})
                elseif v884 and tribe3 and tribe3.id == v884.id then
                    label({Name = "Mine", Text = "Keep playing here to defend it", TextSize = 14, LayoutOrder = 9, FontFace = fonts.Bold, TextColor3 = colors.Accent, Size = UDim2.new(1, 0, 0, 18), Parent = parent})
                end
            end

            caps(`TERRITORIES RESET IN {(string.upper((untilText(v797.weekEndsAt))))}`, {LayoutOrder = 2, Parent = parent23})
            local v920 = {}

            if type(v797.order) ~= "table" then
                v885 = {}
            else
                v885 = v797.order
            end

            for _, mapKey2 in v885 do
                local map = v797.maps[mapKey2]

                if map and map.holder then
                    v920[tostring(map.holder)] = (v920[tostring(map.holder)] or 0) + 1
                end
            end

            local v924 = {}
            local _

            for tribeKey, n in v920 do
                if const c = v797.tribes and v797.tribes[tribeKey] then
                    table.insert(v924, {c = c, n = n})
                end
            end

            table.sort(
                v924,
                function(left, right)
                    --[[
                      line: 2174
                    ]]
                    local n = left.n
                    return right.n < n
                end
            )

            section("WHO HOLDS WHAT", nil, nil, 3, parent23)
            local c

            for v933, v934 in v924 do
                local v935
                local parent = ui.new("TextButton", {Name = "H" .. v933, Text = "", AutoButtonColor = false, Size = UDim2.new(1, -6, 0, 50), LayoutOrder = 3 + v933, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.5, (ui.Corner(10)), Parent = parent23})
                local v937 = ui.Stroke(colors.Stroke, 1, 0.92)
                v937.Parent = parent
                openable(parent, v937, v934.c)
                local newTribeEmblem = TribeEmblem.new
                local v939 = {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Parent = parent}
                newTribeEmblem(38, v939):Set(v934.c.icon, v934.c.color1, v934.c.color2, v934.c.tag)
                local v940 = {Name = "Name", RichText = true, TextSize = 14}
                c = v934.c
                local stringFormat = string.format
                local v942 = TribeEmblem.TagColor(c.color1):ToHex()
                local tag = TribeEmblem.Tag

                if type(c) == "table" then
                    v935 = c.tag
                else
                    v935 = c
                end

                local v944 = tag(v935)
                v940.Text = stringFormat("<font color=\"#%s\">%s</font>  %s", v942, v944, (tostring(c.name or "")))
                v940.FontFace = fonts.Heavy
                v940.Position = udim2FromOffset(54, 0)
                v940.Size = UDim2.new(1, -106, 1, 0)
                v940.Parent = parent
                label(v940)
                label({Name = "N", TextSize = 19, Text = tostring(v934.n), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 0), Size = udim2FromOffset(40, 50), Parent = parent})
            end

            if #v924 == 0 then
                label({Name = "NoneHeld", Text = "Every territory is open this week.", TextSize = 14, LayoutOrder = 4, FontFace = fonts.SemiBold, TextColor3 = textColor3, Size = UDim2.new(1, 0, 0, 24), Parent = parent23})
            end
        end

        v141.Territories = function()
            --[[
              line: 2193
              upvalues:
                v797 (ref,  index: 1)
                tribes (copy, index: 2)
                v794 (copy, index: 3)
                child (copy, index: 4)
                v42 (ref,  index: 5)
                roleIn (copy, index: 6)
                a26 (copy, index: 7)
                v796 (ref,  index: 8)
                v815 (ref,  index: 9)
                v801 (ref,  index: 10)
            ]]
            local text
            local v946
            v797 = tribes.Territories(false)

            if v797 then
                text = "Loading the map..."
            else
                text = child.Message("unavailable")
            end

            v794.Text = text
            local tribe = v42 and v42.tribe

            if type(tribe) ~= "table" then
                v946 = tribes.Mine()
            else
                v946 = {id = tribe.id, role = roleIn(tribe)}
            end

            if a26.TribeMapSelect then
                v796 = a26.TribeMapSelect
                a26.TribeMapSelect = nil
            end

            if not v796 and v797 and type(v797.order) == "table" then
                for _, mapKey in v797.order do
                    local tribe2
                    local map = v797 and v797.maps and v797.maps[mapKey]

                    if not map or not map.holder then
                        tribe2 = nil
                    else
                        tribe2 = v797.tribes and v797.tribes[tostring(map.holder)]
                    end

                    if tribe2 and v946 and tribe2.id == v946.id then
                        v796 = mapKey
                        break
                    end
                end

                v796 = v796 or v797.order[1]
            end

            task.defer(
                function()
                    --[[
                      line: 2211
                      upvalues:
                        v815 (ref, index: 1)
                        v801 (ref, index: 2)
                        v796 (ref, index: 3)
                    ]]
                    v815()
                    v801(v796)
                end
            )
        end
    end

    local parent27 = column("Left", tab7.page, 12)
    local parent28 = column("Right", tab7.page, 12)
    local v954 = "Find"
    local count6 = 0
    local v956 = nil

    do
        local function viewMemberRow(value, layoutOrder)
            --[[
              name: viewMemberRow
              line: 2228
              upvalues:
                v27 (ref,  index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
                parent28 (copy, index: 4)
                udim2FromOffset (copy, index: 5)
                theme (copy, index: 6)
                label (copy, index: 7)
                fonts (copy, index: 8)
                v16 (copy, index: 9)
                textColor3 (copy, index: 10)
                rowStat (copy, index: 11)
                textColor32 (copy, index: 12)
            ]]
            local backgroundTransparency
            local v961
            local v962 = v27.row - 6
            local newUi = ui.new
            local v964 = {Name = "M" .. tostring(value.userId), Size = UDim2.new(1, -4, 0, v962), LayoutOrder = layoutOrder, BackgroundColor3 = colors.PanelHi}

            if layoutOrder % 2 ~= 0 then
                backgroundTransparency = 0.35
            else
                backgroundTransparency = 0.55
            end

            v964.BackgroundTransparency = backgroundTransparency
            v964[1] = (ui.Corner(12))
            v964.Parent = parent28
            local parent = newUi("Frame", v964)
            local v966 = v962 - 16
            local parent2 = ui.new("ImageLabel", {Name = "Head", Image = `rbxthumb://type=AvatarHeadShot&id={value.userId}&w=150&h=150`, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = udim2FromOffset(v966, v966), BackgroundColor3 = colors.Raised, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            local v968 = value.where ~= false and value.where ~= nil

            if v968 then
                ui.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1.02, 1.02), Size = udim2FromOffset(12, 12), BackgroundColor3 = colors.Success, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Panel, 2, 0)), Parent = parent2})
            else
                parent2.ImageTransparency = 0.35
            end

            local v969 = v966 + 22
            local v970 = ui.Compact and 92 or 200
            local parent3 = ui.new("Frame", {Name = "NameRow", Position = udim2FromOffset(v969, (math.floor(v962 / 2) - v27.text) - 1), Size = UDim2.new(1, -(v969 + v970), 0, v27.text + 4), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
            local v972 = {Name = "Name", LayoutOrder = 1, Text = tostring((value.display or value.name)), FontFace = fonts.Heavy, TextSize = v27.text, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, v27.text + 4), Parent = parent3}
            label(v972)

            if const v973 = v16[value.role] then
                ui.Pill(v973.text, v973.color, {LayoutOrder = 2, Height = 20, TextSize = 11, Parent = parent3})
            end

            label({Name = "Sub", Text = `@{value.name}  ·  Lv {value.level}`, FontFace = fonts.SemiBold, TextSize = v27.sub, TextColor3 = textColor3, Position = udim2FromOffset(v969, math.floor(v962 / 2) + 3), Size = UDim2.new(1, -(v969 + v970), 0, v27.sub + 2), Parent = parent})
            local parent4 = ui.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = udim2FromOffset(v970 - 10, 40), (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent})
            local number = tonumber(value.weekRenown) or 0
            local text = tostring(number)

            if not (0 < number) then
                v961 = colors.TextDim
            else
                v961 = textColor32
            end

            rowStat(parent4, text, "GLORY", 1, v961)

            if not ui.Compact then
                local transparency
                local pill = ui.Pill
                local v979 = v968 and "ONLINE" or "OFFLINE"
                local v980 = if v968 then colors.Success else colors.TextMuted
                local v981 = {LayoutOrder = 2, Height = 22, TextSize = 11}

                if v968 then
                    transparency = 0.15
                else
                    transparency = 0.75
                end

                v981.Transparency = transparency
                v981.TextColor = if v968 then colors.TextDark else colors.TextDim
                v981.Parent = parent4
                pill(v979, v980, v981)
            end

            return parent
        end

        local function renderView(a983, a984: boolean)
            --[[
              name: renderView
              line: 2288
              upvalues:
                clear (copy, index: 1)
                parent27 (copy, index: 2)
                parent28 (copy, index: 3)
                child (copy, index: 4)
                ui (copy, index: 5)
                smallButton (copy, index: 6)
                showTab (copy, index: 7)
                v954 (ref,  index: 8)
                heroTile (copy, index: 9)
                v27 (ref,  index: 10)
                TribeEmblem (copy, index: 11)
                colors (copy, index: 12)
                label (copy, index: 13)
                fonts (copy, index: 14)
                caps (copy, index: 15)
                v17 (copy, index: 16)
                statTile (copy, index: 17)
                textColor32 (copy, index: 18)
                v42 (ref,  index: 19)
                roleIn (copy, index: 20)
                tribes (copy, index: 21)
                joinButton (copy, index: 22)
                section (copy, index: 23)
                count6 (ref,  index: 24)
                heldChips (copy, index: 25)
                target (ref,  index: 26)
                viewMemberRow (copy, index: 27)
            ]]
            local v985
            local v986
            local v987
            local v988
            local membersList
            clear(parent27)
            clear(parent28)
            local backgroundColor3 = child.Color(a983.color1)
            smallButton(
                "‹  BACK",
                "Dark",
                ui.new("Frame", {Name = "BackRow", LayoutOrder = 0, Size = UDim2.new(1, -6, 0, 40), Parent = parent27}),
                function()
                    --[[
                      line: 2293
                      upvalues:
                        showTab (copy, index: 1)
                        v954 (ref,  index: 2)
                    ]]
                    showTab(v954)
                end,
                {Width = 110, TextSize = 15}
            )
            local parent = ui.Panel({Name = "Hero", BackgroundTransparency = 0.06, LayoutOrder = 1, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = parent27})
            ui.Padding(12, 12, 12, 12).Parent = parent
            ui.List(Enum.FillDirection.Vertical, 10).Parent = parent
            local parent2, v993 = heroTile(parent, v27.hero, 1)
            v993(backgroundColor3)
            local newTribeEmblem = TribeEmblem.new
            local v995 = ui.Compact and 78 or 124
            local v996 = {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.44), Parent = parent2}
            newTribeEmblem(v995, v996):Set(a983.icon, a983.color1, a983.color2, a983.tag)
            local pill = ui.Pill
            local tag = TribeEmblem.Tag

            if type(a983) ~= "table" then
                v985 = a983
            else
                v985 = a983.tag
            end

            pill(tag(v985), colors.Void, {Height = 26, TextSize = 15, Transparency = 0.3, ZIndex = 3, AutoLocalize = false, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), TextColor = TribeEmblem.TagColor(a983.color1), Parent = parent2})
            local parent3 = label({Name = "Name", TextScaled = true, LayoutOrder = 2, Text = string.upper((tostring(a983.name
                or ""))), FontFace = fonts.Display, Size = UDim2.new(1, 0, 0, 32), Parent = parent})
            ui.new("UITextSizeConstraint", {MaxTextSize = 28, MinTextSize = 16, Parent = parent3})
            local number = tonumber(a983.members) or 0
            local v1001 = tonumber(a983.online) or 0

            if type(a983.membersList) == "table" then
                local v1002 = 0
                v1001 = v1002

                for _, v1004 in a983.membersList do
                    if v1004.where then
                        v1001 += 1
                    end
                end
            end

            local options = {LayoutOrder = 3, Parent = parent}
            caps(`{number}/{child.MAX_MEMBERS} MEMBERS  ·  {v1001} ONLINE  ·  {(string.upper((v17[a983.joinMode]
                or "")))}`, options)
            local newUi = ui.new
            local v1007 = {Name = "Stats"}
            local newUDim2 = UDim2.new
            local v1009 = ui.Compact and 52 or 62
            v1007.Size = newUDim2(1, 0, 0, v1009)
            v1007.LayoutOrder = 4
            v1007[1] = (ui.List(Enum.FillDirection.Horizontal, 8))
            v1007.Parent = parent
            local ui2 = newUi("Frame", v1007)
            local v1011 = statTile(ui2, "WEEK RANK", 1)
            local v1012 = statTile(ui2, "GLORY", 2)
            local v1013 = statTile(ui2, "TERRITORIES", 3)
            v1011.Text = if a983.rank then "#" .. tostring(a983.rank) else "-"
            v1012.Text = ui.FormatCompact((tonumber(a983.weekRenown) or 0))
            v1012.TextColor3 = textColor32

            if type(a983.territories) ~= "table" then
                v986 = {}
            else
                v986 = a983.territories
            end

            v1013.Text = if a984 then tostring(#v986) else tostring((tonumber(a983.held) or 0))
            local number2 = tonumber((a983.renownTotal or a983.renown)) or 0
            caps(`{(ui.FormatNumber(number2))} GLORY ALL TIME`, {LayoutOrder = 5, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent})
            local tribe = v42 and v42.tribe

            if type(tribe) ~= "table" then
                v987 = tribes.Mine()
            else
                v987 = {id = tribe.id, role = roleIn(tribe)}
            end

            if not v987 then
                joinButton(a983, ui.new("Frame", {Name = "Join", Size = UDim2.new(1, 0, 0, 46), LayoutOrder = 6, (ui.List(Enum.FillDirection.Horizontal, 0, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent}), UDim2.new(1, 0, 0, 46))
            end

            local v1016 = if a984 then #v986 else nil

            if a984 and #v986 == 0 then
                v988 = nil
            else
                v988 = a984 and "held this week" or nil
            end

            section("TERRITORIES", v1016, v988, 1, parent28)

            if a984 then
                local v1017 = count6
                heldChips(
                    v986,
                    parent28,
                    2,
                    backgroundColor3,
                    function()
                        --[[
                          line: 2339
                          upvalues:
                            v1017 (copy, index: 1)
                            count6 (ref,  index: 2)
                            target (ref,  index: 3)
                        ]]
                        return v1017 == count6 and target == "View"
                    end,
                    "No territories this week."
                )
            end

            if type(a983.membersList) ~= "table" then
                membersList = nil
            else
                membersList = a983.membersList
            end

            section("MEMBERS", number, nil, 3, parent28)

            if not membersList then
                for index = 1, math.min(math.max(number, 1), 4) do
                    local ui3 = ui.new("Frame", {Name = "Skeleton", Size = UDim2.new(1, -4, 0, v27.row - 6), LayoutOrder = index + 3, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.5, (ui.Corner(12)), Parent = parent28})
                    local v1020 = {BackgroundTransparency = 0.78}
                    ui.Tween(ui3, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, index * 0.12), v1020)
                end

                return
            end

            local values = table.clone(membersList)
            local v1022 = {chief = 0, elder = 1}

            table.sort(
                values,
                function(left, right)
                    --[[
                      line: 2355
                      upvalues:
                        v1022 (copy, index: 1)
                    ]]
                    local v1025 = v1022[left.role] or 2
                    local v1026 = v1022[right.role] or 2

                    if v1025 ~= v1026 then
                        return v1025 < v1026
                    end

                    local v1027 = left.where and 1 or 0
                    local v1028 = right.where and 1 or 0

                    if v1027 ~= v1028 then
                        return v1028 < v1027
                    end

                    local number = tonumber(left.weekRenown) or 0

                    return (tonumber(right.weekRenown) or 0) < number
                end
            )

            for v1030, value in values do
                local v1032 = viewMemberRow(value, 3 + v1030)
                ui.Enter(v1032, Vector2.new(0, 8), math.min(v1030 * 0.025, 0.25), UDim2.new())
            end
        end

        v45 = function(a1033, a1034)
            --[[
              line: 2372
              upvalues:
                v42 (ref,  index: 1)
                roleIn (copy, index: 2)
                tribes (copy, index: 3)
                showTab (copy, index: 4)
                target (ref,  index: 5)
                v954 (ref,  index: 6)
                v956 (ref,  index: 7)
                count6 (ref,  index: 8)
                parent27 (copy, index: 9)
                parent28 (copy, index: 10)
                renderView (copy, index: 11)
                clear (copy, index: 12)
                ui (copy, index: 13)
                smallButton (copy, index: 14)
                label (copy, index: 15)
                child (copy, index: 16)
                fonts (copy, index: 17)
                textColor3 (copy, index: 18)
            ]]
            if type(a1033) ~= "number" then
                return
            end

            local v1035
            local tribe = v42 and v42.tribe

            if type(tribe) ~= "table" then
                v1035 = tribes.Mine()
            else
                v1035 = {id = tribe.id, role = roleIn(tribe)}
            end

            if v1035 and v1035.id == a1033 then
                showTab("Overview")
                return
            end

            if target ~= "View" then
                v954 = target or "Find"
            end

            v956 = a1033
            count6 += 1
            local v1037 = count6
            parent27.CanvasPosition = Vector2.zero
            parent28.CanvasPosition = Vector2.zero

            if type(a1034) ~= "table" or not a1034.tag then
                clear(parent27)
                clear(parent28)
            else
                renderView(a1034, false)
            end

            showTab("View")

            task.spawn(
                function()
                    --[[
                      line: 2396
                      upvalues:
                        tribes (copy, index: 1)
                        a1033 (copy, index: 2)
                        v1037 (copy, index: 3)
                        count6 (ref,  index: 4)
                        clear (copy, index: 5)
                        parent27 (copy, index: 6)
                        parent28 (copy, index: 7)
                        ui (copy, index: 8)
                        smallButton (copy, index: 9)
                        showTab (copy, index: 10)
                        v954 (ref,  index: 11)
                        label (copy, index: 12)
                        child (copy, index: 13)
                        fonts (copy, index: 14)
                        textColor3 (copy, index: 15)
                        renderView (copy, index: 16)
                    ]]
                    local v1038, v1039 = tribes.Action("Get", a1033)

                    if v1037 ~= count6 then
                        return
                    end

                    if v1038 and type(v1039) == "table" then
                        renderView(v1039, true)
                        return
                    end

                    clear(parent27)
                    clear(parent28)
                    local ui2 = ui.new("Frame", {Name = "BackRow", LayoutOrder = 0, Size = UDim2.new(1, -6, 0, 40), Parent = parent27})
                    smallButton(
                        "‹  BACK",
                        "Dark",
                        ui2,
                        function()
                            --[[
                              line: 2406
                              upvalues:
                                showTab (copy, index: 1)
                                v954 (ref,  index: 2)
                            ]]
                            showTab(v954)
                        end,
                        {Width = 110, TextSize = 15}
                    )
                    local v1041 = {Name = "Gone", TextSize = 16, TextWrapped = true, LayoutOrder = 1, Text = tostring((v1039
                        or child.Message("unavailable"))), FontFace = fonts.SemiBold, TextColor3 = textColor3, TextTruncate = Enum.TextTruncate.None, Size = UDim2.new(1, 0, 0, 60), Parent = parent28}
                    label(v1041)
                end
            )
        end
    end

    local v1042 = "create"
    local v1043 = {tag = "", name = "", icon = 1, color1 = 1, color2 = nil, joinMode = "open", minLevel = 0}

    do
        local white = child.WHITE
        v1043.color2 = white
    end

    local parent29 = column("Left", tab6.page, 10)
    local parent30 = column("Right", tab6.page, 10)
    local parent31 = ui.Panel({Name = "PreviewPanel", BackgroundTransparency = 0.06, LayoutOrder = 1, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = parent29})
    ;(function(parent, a1049: number)
        --[[
          name: pad
          line: 211
          upvalues:
            ui (copy, index: 1)
        ]]
        ui.Padding(a1049, a1049, a1049, a1049).Parent = parent
    end)(parent31, 12)
    ui.List(Enum.FillDirection.Vertical, 10).Parent = parent31
    local parent32, v1051 = heroTile(parent31, v27.hero - 40, 1)
    local newTribeEmblem = TribeEmblem.new
    local v1053 = ui.Compact and 96 or 112
    local tribeEmblem = newTribeEmblem(v1053, {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent32})
    local parent33 = ui.new("Frame", {Name = "Plate", Size = UDim2.new(1, 0, 0, 36), LayoutOrder = 2, BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.3, (ui.Corner(10)), Parent = parent31})
    local v1056 = label({Name = "Text", Text = "", RichText = true, TextSize = 16, FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = parent33})

    local function field(name: string, text: string, placeholderText: string, a1061, layoutOrder: number, parent)
        --[[
          name: field
          line: 2430
          upvalues:
            ui (copy, index: 1)
            caps (copy, index: 2)
            udim2FromOffset (copy, index: 3)
            backgroundColor3 (copy, index: 4)
            colors (copy, index: 5)
            fonts (copy, index: 6)
            theme (copy, index: 7)
        ]]
        local parent2 = ui.new("Frame", {Name = name .. "Wrap", Size = UDim2.new(1, -6, 0, 68), LayoutOrder = layoutOrder, Parent = parent})
        caps(text, {Parent = parent2})
        local v1065 = caps(`0/{a1061}`, {TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = udim2FromOffset(60, 14), Parent = parent2})
        local parent3 = ui.new("Frame", {Name = name .. "Field", Position = udim2FromOffset(0, 20), Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, (ui.Corner(10)), Parent = parent2})
        local v1067 = ui.Stroke(colors.Stroke, 1, 0.88)
        v1067.Parent = parent3
        local ui2 = ui.new("TextBox", {Text = "", ClearTextOnFocus = false, TextSize = 18, BackgroundTransparency = 1, Name = name, PlaceholderText = placeholderText, PlaceholderColor3 = colors.TextMuted, FontFace = fonts.Bold, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = udim2FromOffset(14, 0), Size = UDim2.new(1, -28, 1, 0), Parent = parent3})

        ui2:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 2452
                  upvalues:
                    ui2 (copy, index: 1)
                    a1061 (copy, index: 2)
                    v1065 (copy, index: 3)
                ]]
                if a1061 < #ui2.Text then
                    ui2.Text = string.sub(ui2.Text, 1, a1061)
                    return
                end

                v1065.Text = `{#ui2.Text}/{a1061}`
            end
        )

        ui2.Focused:Connect(
            function()
                --[[
                  line: 2459
                  upvalues:
                    ui (copy, index: 1)
                    v1067 (copy, index: 2)
                    theme (copy, index: 3)
                    colors (copy, index: 4)
                ]]
                ui.Tween(v1067, theme.Tween.Fast, {Transparency = 0.2, Color = colors.Accent})
            end
        )
        ui2.FocusLost:Connect(
            function()
                --[[
                  line: 2462
                  upvalues:
                    ui (copy, index: 1)
                    v1067 (copy, index: 2)
                    theme (copy, index: 3)
                    colors (copy, index: 4)
                ]]
                ui.Tween(v1067, theme.Tween.Fast, {Transparency = 0.88, Color = colors.Stroke})
            end
        )

        return ui2, v1065
    end

    local v1069 = field("Tag", "TAG  ·  2 TO 4 LETTERS OR NUMBERS", "NITE", child.TAG_MAX, 3, parent29)
    local v1070 = field("TribeName", "NAME", "Night Owls", child.NAME_MAX, 4, parent29)
    local parent34 = ui.new("Frame", {Name = "JoinWrap", LayoutOrder = 5, Size = UDim2.new(1, -6, 0, 86), Parent = parent29})
    caps("WHO CAN JOIN", {Parent = parent34})
    local parent35 = ui.new("Frame", {Name = "JoinMode", Position = udim2FromOffset(0, 20), Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, ui.Corner(theme.Radius.Pill), ui.Padding(4, 4, 4, 4), (ui.List(Enum.FillDirection.Horizontal, 4)), Parent = parent34})
    local v1073 = label({Name = "JoinDesc", Text = "", TextSize = 13, FontFace = fonts.SemiBold, TextColor3 = textColor3, Position = udim2FromOffset(4, 66), Size = UDim2.new(1, -8, 0, 16), Parent = parent34})
    local v1074 = {}

    for layoutOrder, name in child.JOIN_MODES do
        v1074[name] = ui.new("TextButton", {Name = name, Text = v17[name], AutoButtonColor = false, FontFace = fonts.Heavy, TextSize = 13, TextColor3 = colors.TextDim, Size = UDim2.new(0.3333333333333333, -3, 1, 0), LayoutOrder = layoutOrder, BackgroundColor3 = colors.Accent, BackgroundTransparency = 1, [1] = (ui.Corner(theme.Radius.Pill)), Parent = parent35})
    end

    local parent36 = ui.new("Frame", {Name = "LevelWrap", LayoutOrder = 6, Size = UDim2.new(1, -6, 0, 66), Parent = parent29})
    caps("MINIMUM LEVEL TO JOIN", {Parent = parent36})
    local parent37 = ui.new("Frame", {Name = "Stepper", Position = udim2FromOffset(0, 20), Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = backgroundColor3, BackgroundTransparency = 0.25, (ui.Corner(theme.Radius.Pill)), Parent = parent36})
    local v1079 = label({Name = "Value", Text = "", TextSize = 18, FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = parent37})
    local v1080 = ui.IconButton({Name = "Minus", Text = "-", TextSize = 24, Radius = 17, Size = udim2FromOffset(34, 34), Position = udim2FromOffset(4, 4), Color = colors.Raised, Parent = parent37})
    local v1081 = ui.IconButton({Name = "Plus", Text = "+", TextSize = 22, Radius = 17, Size = udim2FromOffset(34, 34), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 4), Color = colors.Raised, Parent = parent37})
    section("EMBLEM", #child.ICONS, "pick one", 1, parent30)
    local parent38 = ui.new("Frame", {Name = "Icons", LayoutOrder = 2, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = parent30})
    ui.new("UIGridLayout", {FillDirectionMaxCells = 12, CellSize = udim2FromOffset(v27.cell, v27.cell), CellPadding = udim2FromOffset(6, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent38})
    section("COLOUR", nil, "the crest", 3, parent30)
    local parent39 = ui.new("Frame", {Name = "Color1", LayoutOrder = 4, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = parent30})
    ui.new("UIGridLayout", {FillDirectionMaxCells = 12, CellSize = udim2FromOffset(v27.swatch, v27.swatch), CellPadding = udim2FromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent39})
    section("SECOND COLOUR", nil, "the icon and rim", 5, parent30)
    local parent40 = ui.new("Frame", {Name = "Color2", LayoutOrder = 6, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = parent30})
    ui.new("UIGridLayout", {FillDirectionMaxCells = 12, CellSize = udim2FromOffset(v27.swatch, v27.swatch), CellPadding = udim2FromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent40})
    local parent41 = ui.new("Frame", {Name = "Buttons", Size = UDim2.new(1, -6, 0, 54), LayoutOrder = 20, (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Right)), Parent = parent30})
    label({Name = "Credit", Text = "Emblem icons by Lorc, Delapouite, Caro Asercion, Carl Olsen and sbed from game-icons.net, CC BY 3.0 (creativecommons.org/licenses/by/3.0), recoloured", TextSize = 12, TextWrapped = true, LayoutOrder = 21, FontFace = fonts.Medium, TextColor3 = colors.TextMuted, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, -6, 0, 0), Parent = parent30})
    local v1086 = ui.Button({Name = "Cancel", Text = "BACK", Style = "Dark", LayoutOrder = 1, Size = udim2FromOffset(150, 52), Parent = parent41})
    local v1087 = ui.Button({Name = "Submit", Text = "FOUND TRIBE", Style = "Primary", LayoutOrder = 2, Size = udim2FromOffset(240, 52), Parent = parent41})
    local v1088 = {}
    local v1089 = {}
    local v1090 = {}

    local function paintForm()
        --[[
          name: paintForm
          line: 2502
          upvalues:
            tribeEmblem (copy, index: 1)
            v1043 (ref,  index: 2)
            v1051 (copy, index: 3)
            child (copy, index: 4)
            v1069 (copy, index: 5)
            TribeEmblem (copy, index: 6)
            v1056 (copy, index: 7)
            localPlayer (copy, index: 8)
            v1088 (copy, index: 9)
            v1089 (copy, index: 10)
            v1090 (copy, index: 11)
            v1074 (copy, index: 12)
            colors (copy, index: 13)
            v1073 (copy, index: 14)
            v18 (copy, index: 15)
            v1079 (copy, index: 16)
        ]]
        local v1092
        tribeEmblem:Set(v1043.icon, v1043.color1, v1043.color2, v1043.tag)
        v1051(child.Color(v1043.color1))
        local v1093 = child.CleanTag(v1069.Text)
        local v1094 = TribeEmblem.TagColor(v1043.color1)
        local stringFormat = string.format
        local number = tonumber(localPlayer:GetAttribute("Level")) or 1
        local v1097 = v1094:ToHex()

        if v1093 == "" then
            v1092 = "TAG"
        else
            v1092 = v1093
        end

        v1056.Text = stringFormat("<font color=\"#AEB5C2\">[%d]</font> <font color=\"#%s\">[%s]</font> %s", number, v1097, v1092, localPlayer.DisplayName)

        for v1098, v1099 in v1088 do
            v1099.emblem:Set(v1098, v1043.color1, v1043.color2, nil)
            v1099.stroke.Transparency = v1098 ~= v1043.icon and 1 or 0
            v1099.button.BackgroundTransparency = v1098 ~= v1043.icon and 0.45 or 0.1
        end

        for v1100, v1101 in v1089 do
            v1101.Transparency = v1100 ~= v1043.color1 and 1 or 0
        end

        for v1102, v1103 in v1090 do
            v1103.Transparency = v1102 ~= v1043.color2 and 1 or 0
        end

        for v1104, v1105 in v1074 do
            v1105.BackgroundTransparency = v1104 ~= v1043.joinMode and 1 or 0
            v1105.TextColor3 = if v1104 == v1043.joinMode then colors.Text else colors.TextDim
        end

        v1073.Text = v18[v1043.joinMode] or ""
        v1079.Text = not (0 < v1043.minLevel) and "ANY LEVEL" or `LEVEL {v1043.minLevel}+`
    end

    for v1106 = 1, #child.ICONS do
        do
            local ui7 = ui.new("TextButton", {Name = "Icon" .. v1106, Text = "", AutoButtonColor = false, LayoutOrder = v1106, BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.45, (ui.Corner(10)), Parent = parent38})

            do
                local stroke = ui.Stroke(colors.Accent, 2, 1)
                stroke.Parent = ui7
                v1088[v1106] = {button = ui7, stroke = stroke, emblem = TribeEmblem.new(v27.cell - 6, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui7})}
            end

            ui7.Activated:Connect(
                function()
                    --[[
                      line: 2532
                      upvalues:
                        v1043 (ref,  index: 1)
                        v1106 (copy, index: 2)
                        a26 (copy, index: 3)
                        paintForm (copy, index: 4)
                        ui (copy, index: 5)
                        tribeEmblem (copy, index: 6)
                    ]]
                    v1043.icon = v1106
                    a26.Sounds.Play("Click")
                    paintForm()
                    ui.Pop(tribeEmblem.Instance, 0.9)
                end
            )
        end
    end

    for v1109, backgroundColor32 in child.COLORS do
        for v1111, parent42 in {parent39, parent40} do
            do
                local parent43 = ui.new("TextButton", {Name = "C" .. v1109, Text = "", AutoButtonColor = false, LayoutOrder = v1109, BackgroundColor3 = backgroundColor32, (ui.Corner(theme.Radius.Pill)), Parent = parent42})
                local v1114 = ui.Stroke(colors.Text, 3, 1)
                v1114.Parent = parent43

                if v1111 == 1 then
                    v1089[v1109] = v1114
                else
                    v1090[v1109] = v1114
                end

                parent43.Activated:Connect(
                    function()
                        --[[
                          line: 2549
                          upvalues:
                            v1111 (copy, index: 1)
                            v1043 (ref,  index: 2)
                            v1109 (copy, index: 3)
                            a26 (copy, index: 4)
                            paintForm (copy, index: 5)
                        ]]
                        if v1111 ~= 1 then
                            v1043.color2 = v1109
                        else
                            v1043.color1 = v1109
                        end

                        a26.Sounds.Play("Click")
                        paintForm()
                    end
                )
            end
        end
    end

    for joinMode, v1116 in v1074 do
        v1116.Activated:Connect(
            function()
                --[[
                  line: 2561
                  upvalues:
                    v1043 (ref,  index: 1)
                    joinMode (copy, index: 2)
                    a26 (copy, index: 3)
                    paintForm (copy, index: 4)
                ]]
                v1043.joinMode = joinMode
                a26.Sounds.Play("Click")
                paintForm()
            end
        )
    end

    do
        local function stepLevel(a1118)
            --[[
              name: stepLevel
              line: 2567
              upvalues:
                v19 (copy, index: 1)
                v1043 (ref,  index: 2)
                paintForm (copy, index: 3)
                ui (copy, index: 4)
                v1079 (copy, index: 5)
            ]]
            local index = table.find(v19, v1043.minLevel) or 1
            v1043.minLevel = v19[math.clamp(index + a1118, 1, #v19)]
            paintForm()
            ui.Bump(v1079, 0.12)
        end
    end

    v1080.Activated:Connect(
        function()
            --[[
              line: 2573
              upvalues:
                v19 (copy, index: 1)
                v1043 (ref,  index: 2)
                paintForm (copy, index: 3)
                ui (copy, index: 4)
                v1079 (copy, index: 5)
            ]]
            local index = table.find(v19, v1043.minLevel) or 1
            v1043.minLevel = v19[math.clamp(index + -1, 1, #v19)]
            paintForm()
            ui.Bump(v1079, 0.12)
        end
    )

    v1081.Activated:Connect(
        function()
            --[[
              line: 2576
              upvalues:
                v19 (copy, index: 1)
                v1043 (ref,  index: 2)
                paintForm (copy, index: 3)
                ui (copy, index: 4)
                v1079 (copy, index: 5)
            ]]
            local index = table.find(v19, v1043.minLevel) or 1
            v1043.minLevel = v19[math.clamp(index + 1, 1, #v19)]
            paintForm()
            ui.Bump(v1079, 0.12)
        end
    )

    v1069:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 2579
              upvalues:
                v1069 (copy, index: 1)
                paintForm (copy, index: 2)
            ]]
            local text = string.gsub(string.upper(v1069.Text), "[^A-Z0-9]", "")

            if text ~= v1069.Text then
                v1069.Text = text
                return
            end

            paintForm()
        end
    )

    v1070:GetPropertyChangedSignal("Text"):Connect(paintForm)

    a26.OpenTribeForm = function(a1123)
        --[[
          line: 2589
          upvalues:
            v1042 (ref,  index: 1)
            v42 (ref,  index: 2)
            v1043 (ref,  index: 3)
            v1069 (copy, index: 4)
            colors (copy, index: 5)
            v1070 (copy, index: 6)
            v1087 (copy, index: 7)
            child (copy, index: 8)
            paintForm (copy, index: 9)
            showTab (copy, index: 10)
            parent29 (copy, index: 11)
            parent30 (copy, index: 12)
            ui (copy, index: 13)
            guiService (copy, index: 14)
        ]]
        v1042 = a1123
        local tribe = v42 and v42.tribe

        if a1123 ~= "settings" or type(tribe) ~= "table" then
            v1043 = {tag = "", name = "", joinMode = "open", minLevel = 0, icon = math.random(1, #child.ICONS), color1 = math.random(1, 14), color2 = child.WHITE}
            v1069.Text = ""
            v1069.TextEditable = true
            v1069.TextColor3 = colors.Text
            v1070.Text = ""
            v1087:SetText("FOUND TRIBE")
        else
            v1043 = {tag = tribe.tag, name = tribe.name, icon = tribe.icon, color1 = tribe.color1, color2 = tribe.color2, joinMode = tribe.joinMode, minLevel = tonumber(tribe.minLevel)
                or 0}
            v1069.Text = tribe.tag
            v1069.TextEditable = false
            v1069.TextColor3 = colors.TextDim
            v1070.Text = tribe.name
            v1087:SetText("SAVE")
        end

        paintForm()
        showTab("Form")
        parent29.CanvasPosition = Vector2.zero
        parent30.CanvasPosition = Vector2.zero

        if ui.Gamepad then
            guiService.SelectedObject = v1087.Instance
        end
    end

    do
        local function afterSave()
            --[[
              name: afterSave
              line: 2617
              upvalues:
                tribes (copy, index: 1)
                target (ref,  index: 2)
                v44 (ref,  index: 3)
                v42 (ref,  index: 4)
                showTab (copy, index: 5)
            ]]
            local v1126 = tribes.Home(true)
            target = nil
            v44(v1126 or v42)

            if v42 and type(v42.tribe) == "table" then
                showTab("Overview")
            end
        end
    end

    do
        local function leaveForm()
            --[[
              name: leaveForm
              line: 2625
              upvalues:
                showTab (copy, index: 1)
                v42 (ref,  index: 2)
            ]]
            local v1128 = v42 and v42.tribe and "Overview" or "Find"
            showTab(v1128)
        end
    end

    v1086.Activated:Connect(
        function()
            --[[
              line: 2628
              upvalues:
                timestamp (ref,  index: 1)
                showTab (copy, index: 2)
                v42 (ref,  index: 3)
            ]]
            if 0.5 <= os.clock() - timestamp then
                local v1129 = v42 and v42.tribe and "Overview" or "Find"
                showTab(v1129)
            end
        end
    )

    v1087.Activated:Connect(
        function()
            --[[
              line: 2633
              upvalues:
                timestamp (ref,  index: 1)
                child (copy, index: 2)
                v1069 (copy, index: 3)
                v1070 (copy, index: 4)
                v1042 (ref,  index: 5)
                a26 (copy, index: 6)
                ui (copy, index: 7)
                act (copy, index: 8)
                v1043 (ref,  index: 9)
                tribes (copy, index: 10)
                target (ref,  index: 11)
                v44 (ref,  index: 12)
                v42 (ref,  index: 13)
                showTab (copy, index: 14)
            ]]
            if not (0.5 <= os.clock() - timestamp) then
                return
            end

            local tag = child.CleanTag(v1069.Text)
            local name = child.CleanName(v1070.Text)

            if v1042 == "create" and not child.ValidTag(tag) then
                a26.Toast(child.Message("bad_tag"), "error")
                ui.Shake(v1069.Parent, 6)

                return
            end

            if not child.ValidName(name) then
                a26.Toast(child.Message("bad_name"), "error")
                ui.Shake(v1070.Parent, 6)

                return
            end

            if v1042 ~= "create" then
                if act("Settings", {name = name, icon = v1043.icon, color1 = v1043.color1, color2 = v1043.color2, joinMode = v1043.joinMode, minLevel = v1043.minLevel}) then
                    a26.Toast("Tribe saved", "success")
                    local v1132 = tribes.Home(true)
                    target = nil
                    v44(v1132 or v42)

                    if v42 and type(v42.tribe) == "table" then
                        showTab("Overview")
                    end
                end
            elseif act("Create", {tag = tag, name = name, icon = v1043.icon, color1 = v1043.color1, color2 = v1043.color2, joinMode = v1043.joinMode, minLevel = v1043.minLevel}) then
                a26.Sounds.Play("Queue_Join")
                a26.Toast(`[{tag}] {name} is founded!`, "success")
                local v1133 = tribes.Home(true)
                target = nil
                v44(v1133 or v42)

                if v42 and type(v42.tribe) == "table" then
                    showTab("Overview")
                end
            end
        end
    )

    if a26.Economy then
        a26.Economy.Event:Connect(
            function(a1134)
                --[[
                  line: 2667
                  upvalues:
                    tribes (copy, index: 1)
                    a26 (copy, index: 2)
                    timestamp3 (ref,  index: 3)
                    v39 (copy, index: 4)
                    target (ref,  index: 5)
                ]]
                if a1134 ~= "TribePass" then
                    return
                end

                task.spawn(
                    function()
                        --[[
                          line: 2671
                          upvalues:
                            tribes (copy, index: 1)
                            a26 (copy, index: 2)
                            timestamp3 (ref,  index: 3)
                            v39 (copy, index: 4)
                            target (ref,  index: 5)
                        ]]
                        local v1135 = tribes.Home(true)
                        a26.Sounds.Play("Queue_Join")
                        a26.Toast("Founding unlocked! Make your tribe", "success")
                        local v1136 = os.clock() - timestamp3 < 120

                        if v1136
                            and v39.IsOpen
                            and type(v1135) == "table"
                            and not v1135.tribe
                            and target ~= "Form"
                        then
                            a26.OpenTribeForm("create")
                        end
                    end
                )
            end
        )
    end

    do
        local function layout()
            --[[
              name: layout
              line: 2684
              upvalues:
                v27 (ref,  index: 1)
                ui (copy, index: 2)
                v12 (copy, index: 3)
                v11 (copy, index: 4)
                v39 (copy, index: 5)
                udim2FromOffset (copy, index: 6)
                parent5 (copy, index: 7)
                parent6 (copy, index: 8)
                parent12 (copy, index: 9)
                parent13 (copy, index: 10)
                parent29 (copy, index: 11)
                parent30 (copy, index: 12)
                parent27 (copy, index: 13)
                parent28 (copy, index: 14)
                v42 (ref,  index: 15)
                parent22 (copy, index: 16)
                parent23 (copy, index: 17)
                ui6 (copy, index: 18)
                ui2 (copy, index: 19)
            ]]
            v27 = if ui.Compact then v12 else v11
            local v1138 = ui.CanvasSize()
            local v1139 = ui.TopInset()

            if ui.Compact then
                v39.Holder.Size = udim2FromOffset(math.floor((math.min(1180, v1138.X - 24))), (math.floor((math.min(680, (v1138.Y - v1139) - 12)))))
            else
                v39.Holder.Size = udim2FromOffset(math.floor((math.clamp(v1138.X - 200, 1040, 1280))), (math.floor((math.clamp((v1138.Y - v1139) - 90, 620, 760)))))
            end

            local v1140 = v39.Holder.Size.X.Offset - 44
            local v1141 = (v39.Holder.Size.Y.Offset - 80) - 32 - (v27.tab + 14)
            local left = v27.left

            for _, v1144 in {{parent5, parent6}, {parent12, parent13}, {parent29, parent30}, {parent27, parent28}} do
                v1144[1].Size = udim2FromOffset(left, v1141)
                v1144[2].Position = udim2FromOffset(left + v27.gap, 0)
                v1144[2].Size = udim2FromOffset((v1140 - left) - v27.gap, v1141)
            end

            local v1145 = v42 ~= nil and type(v42.tribe) == "table"
            parent5.Visible = not v1145

            if v1145 then
                parent6.Position = udim2FromOffset(0, 0)
                parent6.Size = udim2FromOffset(v1140, v1141)
            end

            local v1146 = ui.Compact and 290 or 330
            parent22.Size = udim2FromOffset((v1140 - v1146) - v27.gap, v1141)
            parent23.Position = udim2FromOffset(v1140 - v1146, 0)
            parent23.Size = udim2FromOffset(v1146, v1141)
            local v1147 = ui.Compact and 180 or 200
            ui6.CellSize = udim2FromOffset(v1147, 150)
            ui2.Visible = not ui.Compact
            v39.Refit()
        end

        ui.LayoutChanged:Connect(
            function()
                --[[
                  line: 2716
                  upvalues:
                    v39 (copy, index: 1)
                    layout (copy, index: 2)
                ]]
                if v39.IsOpen then
                    layout()
                end
            end
        )

        ui.ScaleChanged:Connect(
            function()
                --[[
                  line: 2721
                  upvalues:
                    v39 (copy, index: 1)
                    layout (copy, index: 2)
                ]]
                if v39.IsOpen then
                    layout()
                end
            end
        )

        local v1148 = nil

        v44 = function(a1149)
            --[[
              line: 2728
              upvalues:
                v42 (ref,  index: 1)
                v39 (copy, index: 2)
                ui2 (copy, index: 3)
                setTabs (copy, index: 4)
                clear (copy, index: 5)
                parent5 (copy, index: 6)
                label (copy, index: 7)
                child (copy, index: 8)
                fonts (copy, index: 9)
                textColor3 (copy, index: 10)
                TribeEmblem (copy, index: 11)
                ui (copy, index: 12)
                textColor32 (copy, index: 13)
                v1148 (ref,  index: 14)
                target (ref,  index: 15)
                v956 (ref,  index: 16)
                tab (copy, index: 17)
                renderOverview (copy, index: 18)
                renderMembers (copy, index: 19)
                renderFindLeft (copy, index: 20)
                layout (copy, index: 21)
                paintTabs (copy, index: 22)
            ]]
            v42 = a1149

            if not a1149 then
                v39.Title.AutoLocalize = true
                v39.Title.Text = "TRIBES"
                ui2.Text = ""
                setTabs({"Find", "Territories"})
                clear(parent5)
                label({Name = "Down", TextSize = 16, TextWrapped = true, Text = child.Message("unavailable"), FontFace = fonts.SemiBold, TextColor3 = textColor3, TextTruncate = Enum.TextTruncate.None, Size = UDim2.new(1, 0, 0, 60), Parent = parent5})

                return
            end

            local tribe = a1149.tribe

            if type(tribe) ~= "table" then
                v39.Title.AutoLocalize = true
                v39.Title.Text = "TRIBES"
                v39.Subtitle.Text = "Play together, earn Glory, hold the maps"
                ui2.Text = ""

                if target == "Overview" or target == "Members" then
                    target = nil
                end

                v1148 = false
                tab.text.Text = "FIND A TRIBE"
                setTabs({"Find", "Leaderboard", "Territories"})
                renderFindLeft(a1149)
            else
                local v1151
                local text
                v39.Title.AutoLocalize = false
                v39.Title.Text = string.upper((tostring(tribe.name)))
                local number = tonumber(tribe.members) or 0
                local subtitle = v39.Subtitle
                local tag = TribeEmblem.Tag

                if type(tribe) ~= "table" then
                    v1151 = tribe
                else
                    v1151 = tribe.tag
                end

                local v1156 = tag(v1151)
                local v1157 = number ~= 1 and "members" or "member"
                subtitle.Text = `{v1156}  ·  {number} {v1157}  ·  {(ui.FormatNumber((tonumber(tribe.weekRenown)
                    or 0)))} Glory this week`

                if tribe.rank then
                    text = string.format("<font color=\"#%s\">#%d</font> THIS WEEK", textColor32:ToHex(), tribe.rank)
                else
                    text = ""
                end

                ui2.Text = text

                if v1148 == false and (target == "Find" or target == "View") then
                    target = nil
                end

                if target == "View" and v956 == tribe.id then
                    target = nil
                end

                v1148 = true
                tab.text.Text = "BROWSE"
                setTabs({"Overview", "Members", "Find", "Leaderboard", "Territories"})
                renderOverview(tribe)
                renderMembers(tribe)
            end

            layout()
            paintTabs()
        end

        tribes.HomeChanged:Connect(
            function(a1158)
                --[[
                  line: 2774
                  upvalues:
                    v39 (copy, index: 1)
                    target (ref,  index: 2)
                    v44 (ref,  index: 3)
                    v280 (ref,  index: 4)
                    v281 (ref,  index: 5)
                    rowsSig (copy, index: 6)
                    v282 (ref,  index: 7)
                    drawRows (copy, index: 8)
                ]]
                if v39.IsOpen and target ~= "Form" then
                    v44(a1158)

                    if v280 and not v281 and target == "Find" and rowsSig() ~= v282 then
                        drawRows(v280, false)
                    end
                end
            end
        )

        local count7 = 0

        menuManager.Register(
            "Tribe",
            {
                open = (function(key)
                    --[[
                      name: open
                      line: 2783
                      upvalues:
                        count7 (ref,  index: 1)
                        timestamp (ref,  index: 2)
                        a26 (copy, index: 3)
                        layout (copy, index: 4)
                        target (ref,  index: 5)
                        v1148 (ref,  index: 6)
                        v44 (ref,  index: 7)
                        tribes (copy, index: 8)
                        v138 (copy, index: 9)
                        showTab (copy, index: 10)
                        v39 (copy, index: 11)
                        v280 (ref,  index: 12)
                        v281 (ref,  index: 13)
                        rowsSig (copy, index: 14)
                        v282 (ref,  index: 15)
                        drawRows (copy, index: 16)
                    ]]
                    count7 += 1
                    local v1161 = count7
                    timestamp = os.clock()
                    a26.SetHudHidden("Tribe", true)
                    layout()
                    target = nil
                    v1148 = nil
                    v44(tribes.Cached())

                    if type(key) == "string" and v138[key] then
                        showTab(key)
                    end

                    v39:Open()

                    task.spawn(
                        function()
                            --[[
                              line: 2796
                              upvalues:
                                tribes (copy, index: 1)
                                v1161 (copy, index: 2)
                                count7 (ref,  index: 3)
                                v39 (copy, index: 4)
                                target (ref,  index: 5)
                                v44 (ref,  index: 6)
                                v280 (ref,  index: 7)
                                v281 (ref,  index: 8)
                                rowsSig (copy, index: 9)
                                v282 (ref,  index: 10)
                                drawRows (copy, index: 11)
                            ]]
                            local v1162 = tribes.Home(true)

                            if v1161 == count7 and v39.IsOpen then
                                if target ~= "Form" then
                                    v44(v1162)
                                end

                                if v280 and not v281 and target == "Find" and rowsSig() ~= v282 then
                                    drawRows(v280, false)
                                end
                            end
                        end
                    )
                end),
                close = (function(a1163)
                    --[[
                      name: close
                      line: 2806
                      upvalues:
                        count2 (ref,  index: 1)
                        count6 (ref,  index: 2)
                        a26 (copy, index: 3)
                        dialog (ref,  index: 4)
                        parent3 (copy, index: 5)
                        clear (copy, index: 6)
                        parent4 (copy, index: 7)
                        ui (copy, index: 8)
                        menuManager (copy, index: 9)
                        v1069 (copy, index: 10)
                        v1070 (copy, index: 11)
                        ui3 (copy, index: 12)
                        v39 (copy, index: 13)
                    ]]
                    count2 += 1
                    count6 += 1
                    a26.SetHudHidden("Tribe", false)
                    dialog = false
                    parent3.Visible = false
                    clear(parent4)

                    if ui.Gamepad then
                        menuManager.Reselect()
                    end

                    v1069:ReleaseFocus()
                    v1070:ReleaseFocus()
                    ui3:ReleaseFocus()
                    v39:Close(a1163)
                end),
                select = (function()
                    --[[
                      name: select
                      line: 2816
                      upvalues:
                        v139 (ref,  index: 1)
                        v138 (copy, index: 2)
                    ]]
                    local v1164 = v139[1]

                    if v1164 and v138[v1164] then
                        return v138[v1164].button
                    end

                    return nil
                end),
                back = (function()
                    --[[
                      name: back
                      line: 2820
                      upvalues:
                        dialog (ref,  index: 1)
                        parent3 (copy, index: 2)
                        clear (copy, index: 3)
                        parent4 (copy, index: 4)
                        ui (copy, index: 5)
                        menuManager (copy, index: 6)
                        target (ref,  index: 7)
                        showTab (copy, index: 8)
                        v42 (ref,  index: 9)
                        v954 (ref,  index: 10)
                    ]]
                    if dialog then
                        dialog = false
                        parent3.Visible = false
                        clear(parent4)

                        if ui.Gamepad then
                            menuManager.Reselect()
                        end

                        return true
                    end

                    if target == "Form" then
                        local v1165 = v42 and v42.tribe and "Overview" or "Find"
                        showTab(v1165)

                        return true
                    end

                    if target == "View" then
                        showTab(v954)
                        return true
                    end

                    return false
                end)
            }
        )
    end

    state.PlayerStateChanged:Connect(
        function(a1166)
            --[[
              line: 2836
              upvalues:
                menuManager (copy, index: 1)
            ]]
            if a1166 == "Match" and menuManager.IsOpen("Tribe") then
                menuManager.Close("Tribe", true)
            end
        end
    )

    a26.Debug.tribe = function(a1167, options)
        --[[
          line: 2844
          upvalues:
            menuManager (copy, index: 1)
            showTab (copy, index: 2)
            v45 (ref,  index: 3)
            a26 (copy, index: 4)
            v1069 (copy, index: 5)
            v1070 (copy, index: 6)
            v44 (ref,  index: 7)
            timestamp (ref,  index: 8)
            v1087 (copy, index: 9)
            v39 (copy, index: 10)
            target (ref,  index: 11)
            v42 (ref,  index: 12)
            dialog (ref,  index: 13)
        ]]
        if a1167 == "open" then
            menuManager.Open("Tribe", options)
        elseif a1167 == "tab" then
            showTab((tostring(options)))
        elseif a1167 == "view" then
            v45((tonumber(options) or 0), nil)
        elseif a1167 == "form" then
            a26.OpenTribeForm((tostring((options or "create"))))
        elseif a1167 == "fill" and type(options) == "table" then
            v1069.Text = tostring((options.tag or ""))
            v1070.Text = tostring((options.name or ""))
        elseif a1167 == "home" and type(options) == "table" then
            v44(options)
        elseif a1167 == "submit" then
            timestamp = -math.huge
            task.spawn(
                function()
                    --[[
                      line: 2860
                      upvalues:
                        v1087 (copy, index: 1)
                    ]]
                    v1087.Activated:Fire()
                end
            )
        end

        local v1169 = {open = v39.IsOpen, tab = target or false}
        v1169.inTribe = v42 ~= nil and v42.tribe ~= false
        v1169.dialog = dialog
        return v1169
    end
end

return v10