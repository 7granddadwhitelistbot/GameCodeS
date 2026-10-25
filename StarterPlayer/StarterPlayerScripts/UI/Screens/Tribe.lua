local Players_upv_1 = game:GetService("Players")
local GuiService_upv_1 = game:GetService("GuiService")
local HttpService_upv_1 = game:GetService("HttpService")
local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local Tribes_upv_1 = require(v1:WaitForChild("Tribes"))
local TribeArt_upv_1 = require(v1:WaitForChild("TribeArt"))
local TribeMapGrid_upv_1 = require(v1:WaitForChild("TribeMapGrid"))
v1 = {}
local _ = {sub = 14, text = 18, left = 360, swatch = 34, hero = 214, tab = 40, cell = 58, row = 64, gap = 20}
local tbl_upv_1 = {sub = 13, text = 17, left = 320, swatch = 30, hero = 132, tab = 40, cell = 50, row = 60, gap = 14}
local u1 = Color3.fromRGB(142, 149, 166)
local u2 = Color3.fromRGB(10, 11, 15)
local u3 = Color3.fromRGB(255, 186, 46)
local v2 = Color3.fromRGB(150, 98, 10)
local tbl_upv_2 = {}
tbl_upv_2.chief = {text = "CHIEF", color = Color3.fromRGB(196, 136, 20)}
tbl_upv_2.elder = {text = "ELDER", color = Color3.fromRGB(28, 110, 220)}
local tbl_upv_3 = {request = "REQUEST", open = "OPEN", invite = "INVITE ONLY"}
local tbl_upv_4 = {request = "Players ask, Elders accept", open = "Anyone can join", invite = "Only players you invite"}
local tbl_upv_5 = {0, 5, 10, 20, 30, 50}
local function untilText(a1)
    --[[
      name: untilText
      line: 67
    ]]
    if type(a1) ~= "number" then
        return ""
    end
    local v2 = math.max(0, a1 - os.time())
    if v2 >= 86400 then
        return (("%*d %*h"):format(v2 // 86400, (v2 % 86400) // 3600))
    elseif v2 >= 3600 then
        return (("%*h %*m"):format(v2 // 3600, (v2 % 3600) // 60))
    else
        return (("%*m"):format(math.max(1, v2 // 60)))
    end
end
local function ago(a1)
    --[[
      name: ago
      line: 52
    ]]
    if type(a1) == "number" and not (a1 <= 0) then
        local v3 = math.max(0, os.time() - a1)
        if v3 < 60 then
            return "just now"
        end
        if v3 < 3600 then
            return (("%*m ago"):format(v3 // 60))
        elseif v3 < 86400 then
            return (("%*h ago"):format(v3 // 3600))
        else
            return (("%*d ago"):format(v3 // 86400))
        end
    end
    return ""
end
function v1.Init(a1)
    --[[
      name: Init
      line: 80
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        u1 (copy, index: 4)
        HttpService_upv_1 (copy, index: 5)
        GuiService_upv_1 (copy, index: 6)
        u2 (copy, index: 7)
        Tribes_upv_1 (copy, index: 8)
        u3 (copy, index: 9)
        untilText (copy, index: 10)
        tbl_upv_2 (copy, index: 11)
        tbl_upv_3 (copy, index: 12)
        ago (copy, index: 13)
        TribeMapGrid_upv_1 (copy, index: 14)
        TribeArt_upv_1 (copy, index: 15)
        tbl_upv_4 (copy, index: 16)
        tbl_upv_5 (copy, index: 17)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Tribes_upv_2 = a1.Tribes
    local MenuManager_upv_1 = a1.MenuManager
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local fromOffset_upv_1 = UDim2.fromOffset
    local TribeEmblem_upv_1 = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem_upv_1.Init(UI_upv_1)
    local Glow_upv_1 = UI_upv_1.Assets.Icons.Glow
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 99
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("Tribe")
    end
    local u4 = UI_upv_1.Window({HeaderHeight = 80, Subtitle = "Play together, earn Glory, hold the maps", Name = "Tribe", Title = "TRIBES", Size = fromOffset_upv_1(1180, 700), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local Content_1 = u4.Content
    UI_upv_1.SelectionRing(u4.Root)
    local u5 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "HeadInfo", TextSize = 15, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -96, 0, 34), Size = fromOffset_upv_1(320, 22), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u4.Header})
    local u6 = nil
    local u7 = false
    local u8 = nil
    local u9 = nil
    local function roleIn(a2)
        --[[
          name: roleIn
          line: 127
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            Tribes_upv_2 (copy, index: 2)
        ]]
        local v4
        if type(a2) == "table" and type(a2.membersList) == "table" then
            v4 = a2.membersList
        else
            v4 = {}
        end
        for _, value_1 in v4 do
            if value_1.userId ~= LocalPlayer_upv_1.UserId then
                continue
            end
            return (tostring(value_1.role))
        end
        local v5 = Tribes_upv_2.Mine()
        if v5 then
            return v5.role
        end
        return "member"
    end
    local function myTribe()
        --[[
          name: myTribe
          line: 136
          upvalues:
            u6 (ref,  index: 1)
            roleIn (copy, index: 2)
            Tribes_upv_2 (copy, index: 3)
        ]]
        local v6 = u6 and (u6.tribe)
        if type(v6) ~= "table" then
            return Tribes_upv_2.Mine()
        end
        local tbl_6 = {}
        tbl_6.id = v6.id
        tbl_6.role = roleIn(v6)
        return tbl_6
    end
    local u10 = -math.huge
    local function settled()
        --[[
          name: settled
          line: 144
          upvalues:
            u10 (ref, index: 1)
        ]]
        local v7 = os.clock() - u10 >= 0.5
        return v7
    end
    local function label(a3)
        --[[
          name: label
          line: 149
          upvalues:
            Fonts_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        local v8 = table.clone(a3)
        if v8.Name ~= "Name" and v8.Name ~= "Tag" or v8.AutoLocalize ~= nil then
            v8.FontFace = v8.FontFace or (Fonts_upv_1.Bold)
            local v9
            v9.TextColor3 = v8.TextColor3 or (Colors_upv_1.Text)
            v9.TextXAlignment = v9.TextXAlignment or (Enum.TextXAlignment.Left)
            v9.TextTruncate = v9.TextTruncate or (Enum.TextTruncate.AtEnd)
            return UI_upv_1.new("TextLabel", v9)
        end
        v8.AutoLocalize = false
        v8.FontFace = v8.FontFace or (Fonts_upv_1.Bold)
        local v9
        v9.TextColor3 = v8.TextColor3 or (Colors_upv_1.Text)
        v9.TextXAlignment = v9.TextXAlignment or (Enum.TextXAlignment.Left)
        v9.TextTruncate = v9.TextTruncate or (Enum.TextTruncate.AtEnd)
        return UI_upv_1.new("TextLabel", v9)
    end
    local function section(a4, a5, a6, a7, a8, a9)
        --[[
          name: section
          line: 182
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u1 (copy, index: 4)
            label (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
        ]]
        local v10 = UI_upv_1.new("Frame", {Name = "Section_" .. a4, Size = UDim2.new(1, -6, 0, 22), LayoutOrder = a7, Parent = a8})
        local new_1 = UI_upv_1.new
        local tbl_7 = {}
        tbl_7.Name = "Bar"
        tbl_7.Size = fromOffset_upv_1(4, 16)
        tbl_7.Position = fromOffset_upv_1(0, 3)
        tbl_7.BackgroundColor3 = a9 or (Colors_upv_1.Accent)
        tbl_7[1] = UI_upv_1.Corner(2)
        tbl_7.Parent = v10
        new_1("Frame", tbl_7)
        new_1 = string.format("<font color=\"#%s\">%s</font>", Colors_upv_1.TextDim:ToHex(), string.upper(a4))
        if a5 ~= nil then
            new_1 = new_1 .. string.format("  <font color=\"#%s\">\194\183  %s</font>", Colors_upv_1.TextMuted:ToHex(), tostring(a5))
        end
        if a6 and a6 ~= "" then
            new_1 = new_1 .. string.format("    <font color=\"#%s\" weight=\"600\">%s</font>", u1:ToHex(), a6)
        end
        label({RichText = true, Name = "Text", TextSize = 15, Text = new_1, FontFace = Fonts_upv_1.Heavy, Position = fromOffset_upv_1(12, 0), Size = UDim2.new(1, -12, 1, 0), Parent = v10})
        return v10
    end
    local function pad(a10, a11)
        --[[
          name: pad
          line: 211
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        UI_upv_1.Padding(a11, a11, a11, a11).Parent = a10
    end
    local function clear(a12)
        --[[
          name: clear
          line: 228
        ]]
        for _, value_2 in a12:GetChildren() do
            if value_2:IsA("GuiObject") then
                value_2:Destroy()
            end
        end
    end
    local function sigOf(a13)
        --[[
          name: sigOf
          line: 236
          upvalues:
            HttpService_upv_1 (copy, index: 1)
        ]]
        local success_1, v11 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, a13)
        if success_1 then
            return v11
        end
        return (tostring(os.clock()))
    end
    local function smallButton(a14, a15, a16, a17, a18)
        --[[
          name: smallButton
          line: 241
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            u10 (ref,  index: 3)
        ]]
        local v12 = a18 or {}
        local Button_1 = UI_upv_1.Button
        local tbl_8 = {LayoutOrder = 0, Radius = 10, Parent = 0, AnchorPoint = 0, Position = 0, Size = 0}
        tbl_8.Name = v12.Name or a14
        tbl_8.Text = a14
        tbl_8.Style = a15
        tbl_8.TextSize = v12.TextSize or 16
        tbl_8.Icon = v12.Icon
        tbl_8.Size = v12.Size or fromOffset_upv_1(v12.Width or 104, v12.Height or 40)
        tbl_8.LayoutOrder = v12.LayoutOrder or 0
        tbl_8.AnchorPoint = v12.AnchorPoint
        tbl_8.Position = v12.Position
        tbl_8.Parent = a16
        local v14 = Button_1(tbl_8)
        v14.Activated:Connect(
            function()
                --[[
                  line: 256
                  upvalues:
                    u10 (ref,  index: 1)
                    a17 (copy, index: 2)
                ]]
                local v15 = os.clock() - u10 >= 0.5
                if not v15 then
                    return
                end
                a17()
            end
        )
        if v12.Enabled == false then
            v14:SetEnabled(false)
        end
        return v14
    end
    local function tagText(a19)
        --[[
          name: tagText
          line: 267
          upvalues:
            TribeEmblem_upv_1 (copy, index: 1)
        ]]
        local Tag_1 = TribeEmblem_upv_1.Tag
        local v16
        if type(a19) ~= "table" then
            v16 = a19
        else
            v16 = a19.tag
        end
        return Tag_1(v16)
    end
    local function tribeLine(a20)
        --[[
          name: tribeLine
          line: 272
          upvalues:
            TribeEmblem_upv_1 (copy, index: 1)
        ]]
        local format_1 = string.format
        local v17 = TribeEmblem_upv_1.TagColor(a20.color1):ToHex()
        local Tag_2 = TribeEmblem_upv_1.Tag
        local v18
        if type(a20) ~= "table" then
            v18 = a20
        else
            v18 = a20.tag
        end
        return format_1("<font color=\"#%s\">%s</font>  %s", v17, Tag_2(v18), tostring(a20.name or ""))
    end
    local function caps(a21, a22)
        --[[
          name: caps
          line: 163
          upvalues:
            label (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v19 = a22 or {}
        local tbl_9 = {LayoutOrder = 0, TextColor3 = 0, Parent = 0, AnchorPoint = 0, TextXAlignment = 0, Position = 0, ZIndex = 0, Size = 0}
        tbl_9.Name = v19.Name or "Caption"
        tbl_9.Text = a21
        tbl_9.FontFace = Fonts_upv_1.Heavy
        tbl_9.TextSize = v19.TextSize or 12
        tbl_9.TextColor3 = v19.TextColor3 or (Colors_upv_1.TextMuted)
        tbl_9.TextXAlignment = v19.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_9.Size = v19.Size or UDim2.new(1, 0, 0, 14)
        tbl_9.Position = v19.Position
        tbl_9.AnchorPoint = v19.AnchorPoint
        tbl_9.LayoutOrder = v19.LayoutOrder or 0
        tbl_9.ZIndex = v19.ZIndex
        tbl_9.Parent = v19.Parent
        return label(tbl_9)
    end
    local u11 = UI_upv_1.new("Frame", {Name = "Tabs", Size = UDim2.new(1, 0, 0, tbl_upv_1.tab), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = Content_1})
    local u12 = UI_upv_1.new("Frame", {Name = "Pages", Position = fromOffset_upv_1(0, tbl_upv_1.tab + 14), Size = UDim2.new(1, 0, 1, -(tbl_upv_1.tab + 14)), Parent = Content_1})
    local tbl_upv_10 = {}
    local u13 = {}
    local u14 = nil
    local tbl_upv_11 = {}
    local function makeTab(a23, a24, a25)
        --[[
          name: makeTab
          line: 333
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            tbl_upv_1 (ref,  index: 3)
            Colors_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            u11 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            u12 (copy, index: 8)
            tbl_upv_10 (copy, index: 9)
        ]]
        local tbl_12 = {}
        tbl_12.Name = a23
        tbl_12.Text = ""
        tbl_12.AutoButtonColor = false
        tbl_12.AutomaticSize = Enum.AutomaticSize.X
        tbl_12.Size = fromOffset_upv_1(0, tbl_upv_1.tab)
        tbl_12.BackgroundColor3 = Colors_upv_1.Raised
        tbl_12.BackgroundTransparency = 0.4
        tbl_12[1], tbl_12[2], tbl_12[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 18, 0, 14), UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_12.Parent = u11
        local v21 = UI_upv_1.new("TextButton", tbl_12)
        local v22 = UI_upv_1.Glyph(a25, 20, Colors_upv_1.TextDim, {LayoutOrder = 1, Parent = v21})
        local tbl_13 = {}
        tbl_13.button = v21
        tbl_13.text = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Name = "Text", TextSize = 16, Text = a24, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v21})
        tbl_13.icon = v22
        tbl_13.page = UI_upv_1.new("Frame", {Visible = false, Name = a23, Size = UDim2.fromScale(1, 1), Parent = u12})
        tbl_upv_10[a23] = tbl_13
        return tbl_13
    end
    local function paintTabs()
        --[[
          name: paintTabs
          line: 365
          upvalues:
            tbl_upv_10 (copy, index: 1)
            u14 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v23 = nil
        local _ = nil
        local v25 = nil
        for key_1, value_3 in tbl_upv_10 do
            local v24 = key_1 == u14
            local button_1 = value_3.button
            if v24 then
                v23 = Colors_upv_1.Accent
            else
                v23 = Colors_upv_1.Raised
            end
            button_1.BackgroundColor3 = v23
            value_3.button.BackgroundTransparency = (v24 and 0) or 0.4
            local text_1 = value_3.text
            if v24 then
                v23 = Colors_upv_1.Text
            else
                v23 = Colors_upv_1.TextDim
            end
            text_1.TextColor3 = v23
            local icon_1 = value_3.icon
            if v24 then
                v23 = Colors_upv_1.Text
            else
                v23 = Colors_upv_1.TextDim
            end
            icon_1.TextColor3 = v23
        end
    end
    local function showTab(a26)
        --[[
          name: showTab
          line: 375
          upvalues:
            tbl_upv_10 (copy, index: 1)
            u14 (ref,  index: 2)
            paintTabs (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            tbl_upv_11 (copy, index: 5)
        ]]
        if not tbl_upv_10[a26] then
            return
        end
        u14 = a26
        for key_2, value_4 in tbl_upv_10 do
            value_4.page.Visible = key_2 == a26
        end
        paintTabs()
        if u14 ~= a26 then
            UI_upv_1.SlideIn(tbl_upv_10[a26].page, Vector2.new(0, 12), TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), UDim2.new())
        end
        if tbl_upv_11[a26] then
            task.spawn(tbl_upv_11[a26])
        end
    end
    local function setTabs(a27)
        --[[
          name: setTabs
          line: 393
          upvalues:
            u13 (ref,  index: 1)
            tbl_upv_10 (copy, index: 2)
            u14 (ref,  index: 3)
            showTab (copy, index: 4)
        ]]
        u13 = a27
        for key_3, value_5 in tbl_upv_10 do
            local v25 = table.find(a27, key_3)
            value_5.button.Visible = v25 ~= nil
            value_5.button.LayoutOrder = v25 or 99
        end
        if (not u14 or not table.find(a27, u14)) and u14 ~= "Form" and u14 ~= "View" then
            showTab(a27[1])
        end
    end
    local u15 = makeTab("Find", "FIND A TRIBE", "magnifying-glass")
    local v26 = makeTab("Overview", "MY TRIBE", "shield-check")
    local v27 = makeTab("Members", "MEMBERS", "three-people")
    local v28 = makeTab("Leaderboard", "LEADERBOARD", "trophy")
    local v29 = makeTab("Territories", "TERRITORIES", "location-pin-map")
    local v30 = makeTab("Form", "", "pencil")
    v30.button.Visible = false
    local v31 = makeTab("View", "", "eye")
    v31.button.Visible = false
    for key_upv_4, value_upv_6 in tbl_upv_10 do
        value_upv_6.button.Activated:Connect(
            function()
                --[[
                  line: 417
                  upvalues:
                    u14 (ref,  index: 1)
                    key_upv_4 (copy, index: 2)
                    u10 (ref,  index: 3)
                    a1 (copy, index: 4)
                    showTab (copy, index: 5)
                ]]
                if u14 ~= key_upv_4 then
                    local v32 = os.clock() - u10 >= 0.5
                    if not v32 then
                        return
                    end
                    a1.Sounds.Play("Click")
                    showTab(key_upv_4)
                end
            end
        )
        value_upv_6.button.MouseEnter:Connect(
            function()
                --[[
                  line: 423
                  upvalues:
                    u14 (ref,  index: 1)
                    key_upv_4 (copy, index: 2)
                    UI_upv_1 (copy, index: 3)
                    value_upv_6 (copy, index: 4)
                    Theme_upv_1 (copy, index: 5)
                ]]
                if u14 == key_upv_4 or (UI_upv_1.Touch) then
                    return
                end
                UI_upv_1.Tween(value_upv_6.button, Theme_upv_1.Tween.Fast, {BackgroundTransparency = 0.15})
            end
        )
        value_upv_6.button.MouseLeave:Connect(
            function()
                --[[
                  line: 428
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    value_upv_6 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    u14 (ref,  index: 4)
                    key_upv_4 (copy, index: 5)
                ]]
                local Tween_1 = UI_upv_1.Tween
                local button_2 = value_upv_6.button
                local Fast_1 = Theme_upv_1.Tween.Fast
                local tbl_14 = {BackgroundTransparency = 0}
                tbl_14.BackgroundTransparency = ((u14 ~= key_upv_4) and 0.4) or 0
                Tween_1(button_2, Fast_1, tbl_14)
            end
        )
    end
    local u16 = UI_upv_1.new("TextButton", {Name = "DialogDim", Text = "", AutoButtonColor = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, Visible = false, ZIndex = 20, Selectable = false, [1] = UI_upv_1.Corner(16), Parent = u4.Body})
    local tbl_15 = {}
    tbl_15.Name = "Dialog"
    tbl_15.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_15.Position = UDim2.fromScale(0.5, 0.5)
    tbl_15.Size = fromOffset_upv_1(460, 0)
    tbl_15.AutomaticSize = Enum.AutomaticSize.Y
    tbl_15.BackgroundColor3 = Colors_upv_1.Panel
    tbl_15.ZIndex = 21
    tbl_15[1], tbl_15[2], tbl_15[3], tbl_15[4] = UI_upv_1.Corner(16), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.85), UI_upv_1.Padding(22, 22, 22, 22), UI_upv_1.List(Enum.FillDirection.Vertical, 12)
    tbl_15.Parent = u16
    local u17 = UI_upv_1.new("Frame", tbl_15)
    local u18 = false
    local u19 = 0
    local function closeDialog()
        --[[
          name: closeDialog
          line: 463
          upvalues:
            u18 (ref,  index: 1)
            u16 (copy, index: 2)
            clear (copy, index: 3)
            u17 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            MenuManager_upv_1 (copy, index: 6)
        ]]
        u18 = false
        u16.Visible = false
        clear(u17)
        if not UI_upv_1.Gamepad then
            return
        end
        MenuManager_upv_1.Reselect()
    end
    u16.Activated:Connect(
        function()
            --[[
              line: 471
              upvalues:
                u19 (ref,  index: 1)
                u18 (ref,  index: 2)
                u16 (copy, index: 3)
                clear (copy, index: 4)
                u17 (copy, index: 5)
                UI_upv_1 (copy, index: 6)
                MenuManager_upv_1 (copy, index: 7)
            ]]
            if not (os.clock() - u19 > 0.3) then
                return
            end
            u18 = false
            u16.Visible = false
            clear(u17)
            if not UI_upv_1.Gamepad then
                return
            end
            MenuManager_upv_1.Reselect()
        end
    )
    local function openDialog(a28, a29, a30, a31)
        --[[
          name: openDialog
          line: 477
          upvalues:
            clear (copy, index: 1)
            u17 (copy, index: 2)
            u18 (ref,  index: 3)
            u19 (ref,  index: 4)
            u16 (copy, index: 5)
            label (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            UI_upv_1 (copy, index: 9)
            MenuManager_upv_1 (copy, index: 10)
            GuiService_upv_1 (copy, index: 11)
        ]]
        clear(u17)
        u18 = true
        u19 = os.clock()
        u16.Visible = true
        label({LayoutOrder = 1, Name = "Title", ZIndex = 22, TextSize = 26, Text = a28, FontFace = Fonts_upv_1.Display, Size = UDim2.new(1, 0, 0, 30), Parent = u17})
        if a29 and a29 ~= "" then
            label({LayoutOrder = 2, Name = "Text", TextWrapped = true, ZIndex = 22, TextSize = 17, Text = a29, FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = u17})
        end
        if a31 then
            a31((UI_upv_1.new("Frame", {LayoutOrder = 3, Name = "Extra", ZIndex = 22, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = u17})))
        end
        local v33 = UI_upv_1.new("Frame", {Name = "Buttons", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 4, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 8), Parent = u17})
        local v34 = nil
        for key_5, value_upv_7 in a30 do
            local v35 = UI_upv_1.Button({ZIndex = 23, TextSize = 18, Name = "B" .. key_5, Text = value_upv_7.text, Style = value_upv_7.style or "Dark", Size = UDim2.new(1, 0, 0, 48), LayoutOrder = key_5, Parent = v33})
            v35.Activated:Connect(
                function()
                    --[[
                      line: 514
                      upvalues:
                        u19 (ref,  index: 1)
                        u18 (ref,  index: 2)
                        u16 (copy, index: 3)
                        clear (copy, index: 4)
                        u17 (copy, index: 5)
                        UI_upv_1 (copy, index: 6)
                        MenuManager_upv_1 (copy, index: 7)
                        value_upv_7 (copy, index: 8)
                    ]]
                    if (os.clock() - u19 < 0.25) then
                        return
                    end
                    u18 = false
                    u16.Visible = false
                    clear(u17)
                    if UI_upv_1.Gamepad then
                        MenuManager_upv_1.Reselect()
                    end
                    if value_upv_7.fn then
                        task.spawn(value_upv_7.fn)
                    end
                end
            )
            if value_upv_7.enabled == false then
                v35:SetEnabled(false)
            end
            v34 = v34 or v35.Instance
        end
        UI_upv_1.Pop(u17, 0.92)
        if not UI_upv_1.Gamepad or not v34 then
            return
        end
        GuiService_upv_1.SelectedObject = v34
    end
    local function act(a32, ...)
        --[[
          name: act
          line: 535
          upvalues:
            u7 (ref,  index: 1)
            Tribes_upv_2 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        if u7 then
            return false, nil
        end
        u7 = true
        local v37, v38 = Tribes_upv_2.Action(a32, ...)
        u7 = false
        if not (v37) then
            a1.Toast(tostring(v38), "error")
        end
        task.spawn(Tribes_upv_2.Home, true)
        return v37, v38
    end
    local function column(a33, a34, a35)
        --[[
          name: column
          line: 215
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        local tbl_16 = {}
        tbl_16.Name = a33
        tbl_16.ScrollBarThickness = 3
        tbl_16.Selectable = false
        tbl_16[1], tbl_16[2] = UI_upv_1.List(Enum.FillDirection.Vertical, a35 or 10), UI_upv_1.Padding(4, 8, 10, 4)
        tbl_16.Parent = a34
        return UI_upv_1.new("ScrollingFrame", tbl_16)
    end
    local u20 = column("Left", u15.page, 12)
    local u21 = UI_upv_1.new("Frame", {Name = "Right", Parent = u15.page})
    local v39 = UI_upv_1.new("Frame", {Name = "SearchRow", Size = UDim2.new(1, 0, 0, 46), Parent = u21})
    local tbl_17 = {}
    tbl_17.Name = "SearchField"
    tbl_17.Size = UDim2.new(1, -262, 1, 0)
    tbl_17.BackgroundColor3 = u2
    tbl_17.BackgroundTransparency = 0.25
    tbl_17[1], tbl_17[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
    tbl_17.Parent = v39
    local v40 = UI_upv_1.new("Frame", tbl_17)
    UI_upv_1.Glyph("magnifying-glass", 20, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Parent = v40})
    local u22 = UI_upv_1.new("TextBox", {Text = "", ClearTextOnFocus = false, BackgroundTransparency = 1, Name = "Search", PlaceholderText = "Search a tag or name", TextSize = 17, PlaceholderColor3 = Colors_upv_1.TextMuted, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = fromOffset_upv_1(46, 0), Size = UDim2.new(1, -60, 1, 0), Parent = v40})
    local tbl_18 = {}
    tbl_18.Name = "Sort"
    tbl_18.AnchorPoint = Vector2.new(1, 0)
    tbl_18.Position = UDim2.new(1, -4, 0, 0)
    tbl_18.Size = fromOffset_upv_1(250, 46)
    tbl_18.BackgroundColor3 = u2
    tbl_18.BackgroundTransparency = 0.25
    tbl_18[1], tbl_18[2], tbl_18[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(4, 4, 4, 4), UI_upv_1.List(Enum.FillDirection.Horizontal, 4)
    tbl_18.Parent = v39
    local v41 = UI_upv_1.new("Frame", tbl_18)
    local u23 = "top"
    local tbl_upv_19 = {}
    for key_6, value_8 in {{"top", "TOP"}, {"recruiting", "RECRUITING"}} do
        tbl_upv_19[value_8[1]] = UI_upv_1.new("TextButton", {Name = value_8[1], Text = value_8[2], AutoButtonColor = false, FontFace = Fonts_upv_1.Heavy, TextSize = 14, TextColor3 = Colors_upv_1.TextDim, Size = UDim2.new(0.5, -2, 1, 0), LayoutOrder = key_6, BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v41})
    end
    local tbl_20 = {}
    tbl_20.Name = "List"
    tbl_20.Position = fromOffset_upv_1(0, 58)
    tbl_20.Size = UDim2.new(1, 0, 1, -58)
    tbl_20.ScrollBarThickness = 3
    tbl_20.Selectable = false
    tbl_20[1], tbl_20[2] = UI_upv_1.List(Enum.FillDirection.Vertical, 8), UI_upv_1.Padding(4, 10, 10, 4)
    tbl_20.Parent = u21
    local u24 = UI_upv_1.new("ScrollingFrame", tbl_20)
    local u25 = UI_upv_1.new("Frame", {Visible = false, Name = "Empty", Position = fromOffset_upv_1(0, 120), Size = UDim2.new(1, 0, 0, 120), Parent = u21})
    UI_upv_1.Glyph("three-people", 48, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = u25})
    local u26 = label({Text = "", Name = "Text", TextSize = 17, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Center, Position = fromOffset_upv_1(0, 60), Size = UDim2.new(1, 0, 0, 24), Parent = u25})
    local function openable(a36, a37, a38)
        --[[
          name: openable
          line: 630
          upvalues:
            u10 (ref,  index: 1)
            a1 (copy, index: 2)
            u9 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
        ]]
        a36.Activated:Connect(
            function()
                --[[
                  line: 631
                  upvalues:
                    u10 (ref,  index: 1)
                    a1 (copy, index: 2)
                    u9 (ref,  index: 3)
                    a38 (copy, index: 4)
                ]]
                local v42 = os.clock() - u10 >= 0.5
                if not v42 then
                    return
                end
                a1.Sounds.Play("Click")
                u9(a38.id, a38)
            end
        )
        local Transparency_upv_1 = a37.Transparency
        a36.MouseEnter:Connect(
            function()
                --[[
                  line: 638
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    a37 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Transparency_upv_1 (copy, index: 4)
                ]]
                if (UI_upv_1.Touch) then
                    return
                end
                UI_upv_1.Tween(a37, Theme_upv_1.Tween.Fast, {Transparency = math.min(Transparency_upv_1, 0.55)})
            end
        )
        a36.MouseLeave:Connect(
            function()
                --[[
                  line: 643
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    a37 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Transparency_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(a37, Theme_upv_1.Tween.Fast, {Transparency = Transparency_upv_1})
            end
        )
    end
    local function rowStat(a39, a40, a41, a42, a43)
        --[[
          name: rowStat
          line: 623
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            label (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            caps (copy, index: 6)
        ]]
        local v43 = UI_upv_1.new("Frame", {Name = "S_" .. a41, Size = fromOffset_upv_1(78, 40), LayoutOrder = a42, Parent = a39})
        local tbl_21 = {TextXAlignment = 0, Name = "Value", TextColor3 = 0, Parent = 0, TextSize = 18, Size = 0}
        tbl_21.Text = a40
        tbl_21.FontFace = Fonts_upv_1.Display
        tbl_21.TextColor3 = a43 or (Colors_upv_1.Text)
        tbl_21.TextXAlignment = Enum.TextXAlignment.Center
        tbl_21.Size = UDim2.new(1, 0, 0, 22)
        tbl_21.Parent = v43
        label(tbl_21)
        caps(a41, {TextSize = 11, TextXAlignment = Enum.TextXAlignment.Center, Position = fromOffset_upv_1(0, 23), Size = UDim2.new(1, 0, 0, 13), Parent = v43})
    end
    local function tribeRow(a44, a45, a46, a47)
        --[[
          name: tribeRow
          line: 648
          upvalues:
            UI_upv_1 (copy, index: 1)
            tbl_upv_1 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            openable (copy, index: 4)
            Tribes_upv_1 (copy, index: 5)
            TribeEmblem_upv_1 (copy, index: 6)
            label (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            fromOffset_upv_1 (copy, index: 9)
            u1 (copy, index: 10)
            rowStat (copy, index: 11)
            u3 (copy, index: 12)
        ]]
        local v44 = UI_upv_1.new("TextButton", {Name = "T" .. tostring(a44.id), Text = "", AutoButtonColor = false, Size = UDim2.new(1, -4, 0, tbl_upv_1.row + 8), LayoutOrder = a46, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.1, ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = a45})
        local v45 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        v45.Parent = v44
        openable(v44, v45, a44)
        UI_upv_1.Gradient(Tribes_upv_1.Color(a44.color1):Lerp(Colors_upv_1.Panel, 0.8), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.55), 0).Parent = v44
        local v46 = tbl_upv_1.row - 2
        local tbl_22 = {}
        tbl_22.AnchorPoint = Vector2.new(0, 0.5)
        tbl_22.Position = UDim2.new(0, 10, 0.5, 0)
        tbl_22.Parent = v44
        TribeEmblem_upv_1.new(v46, tbl_22):Set(a44.icon, a44.color1, a44.color2, a44.tag)
        local v47 = tbl_upv_1.row + 20
        local tbl_23 = {FontFace = 0, RichText = true, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 0, Size = 0}
        local format_2 = string.format
        local v48 = TribeEmblem_upv_1.TagColor(a44.color1):ToHex()
        local Tag_3 = TribeEmblem_upv_1.Tag
        local v49
        if type(a44) ~= "table" then
            v49 = a44
        else
            v49 = a44.tag
        end
        tbl_23.Text = format_2("<font color=\"#%s\">%s</font>  %s", v48, Tag_3(v49), tostring(a44.name or ""))
        tbl_23.FontFace = Fonts_upv_1.Heavy
        tbl_23.TextSize = tbl_upv_1.text
        tbl_23.Position = fromOffset_upv_1(v47, (math.floor((tbl_upv_1.row + 8) / 2) - tbl_upv_1.text) - 2)
        tbl_23.Size = UDim2.new(1, -(v47 + 400), 0, tbl_upv_1.text + 2)
        tbl_23.Parent = v44
        label(tbl_23).Name = "Name"
        local v50 = ((a44.joinMode == "invite") and "Invite only") or (((a44.joinMode ~= "request") and "Open to everyone") or "Ask to join")
        local v51 = (((tonumber(a44.minLevel) or 0) > 0) and (v50 .. ("  \194\183  level %*+"):format(a44.minLevel))) or v50
        label({Name = "Sub", Text = v51, FontFace = Fonts_upv_1.SemiBold, TextSize = tbl_upv_1.sub, TextColor3 = u1, Position = fromOffset_upv_1(v47, math.floor((tbl_upv_1.row + 8) / 2) + 3), Size = UDim2.new(1, -(v47 + 400), 0, tbl_upv_1.sub + 2), Parent = v44})
        local v52 = UI_upv_1.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -160, 0.5, 0), Size = fromOffset_upv_1(250, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v44})
        rowStat(v52, ("%*/%*"):format(tonumber(a44.members) or 0, Tribes_upv_1.MAX_MEMBERS), "MEMBERS", 1)
        rowStat(v52, UI_upv_1.FormatCompact(tonumber(a44.weekRenown) or 0), "GLORY", 2, u3)
        local str_1 = tostring(tonumber(a44.online) or 0)
        local v53
        if (tonumber(a44.online) or 0) > 0 then
            v53 = Colors_upv_1.Success
        else
            v53 = Colors_upv_1.TextDim
        end
        rowStat(v52, str_1, "ONLINE", 3, v53)
        a47((UI_upv_1.new("Frame", {Name = "Action", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = fromOffset_upv_1(136, 42), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v44})))
        return v44
    end
    local function joinButton(a48, a49, a50)
        --[[
          name: joinButton
          line: 698
          upvalues:
            u6 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            smallButton (copy, index: 3)
            openDialog (copy, index: 4)
            TribeEmblem_upv_1 (copy, index: 5)
            act (copy, index: 6)
            Tribes_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        local v54 = u6 or {}
        local v55 = false
        if type(v54.requested) == "table" then
            v55 = table.find(v54.requested, a48.id) ~= nil
        end
        local v56 = LocalPlayer_upv_1:GetAttribute("Level") or 1
        local u27 = (type(v54.cooldownUntil) == "number") and (os.time() < v54.cooldownUntil)
        local function sized_1(a51)
            --[[
              name: sized
              line: 699
              upvalues:
                a50 (copy, index: 1)
            ]]
            if a50 then
                a51.Size = a50
            end
            return a51
        end
        if v55 then
            local tbl_24 = {TextSize = 15, Width = 130}
            if a50 then
                tbl_24.Size = a50
            end
            local v57 = function()
                --[[
                  line: 710
                  upvalues:
                    openDialog (copy, index: 1)
                    a48 (copy, index: 2)
                    TribeEmblem_upv_1 (copy, index: 3)
                    act (copy, index: 4)
                ]]
                local v58 = "You asked to join %* %*."
                local Tag_4 = TribeEmblem_upv_1.Tag
                local v59
                if type(a48) ~= "table" then
                    v59 = a48
                else
                    v59 = a48.tag
                end
                local v60 = v58:format(Tag_4(v59), tostring(a48.name))
                local tbl_25 = {text = "CANCEL REQUEST", style = "Danger"}
                function tbl_25.fn()
                    --[[
                      name: fn
                      line: 712
                      upvalues:
                        act (copy, index: 1)
                        a48 (copy, index: 2)
                    ]]
                    act("Cancel", a48.id)
                end
                openDialog("Cancel your request?", v60, {tbl_25, {text = "KEEP IT"}})
            end
            smallButton("REQUESTED", "Dark", a49, v57, tbl_24)
        elseif Tribes_upv_1.MAX_MEMBERS <= (tonumber(a48.members) or 0) then
            local tbl_26 = {Enabled = false, Width = 130}
            if a50 then
                tbl_26.Size = a50
            end
            local v61 = function()
                --[[
                  line: 719
                ]]
            end
            smallButton("FULL", "Dark", a49, v61, tbl_26)
        elseif a48.joinMode == "invite" then
            local tbl_27 = {Enabled = false, TextSize = 14, Width = 130}
            if a50 then
                tbl_27.Size = a50
            end
            local v62 = function()
                --[[
                  line: 721
                ]]
            end
            smallButton("INVITE ONLY", "Dark", a49, v62, tbl_27)
        elseif v56 < (tonumber(a48.minLevel) or 0) then
            local v63 = ("LV %*+"):format(a48.minLevel)
            local tbl_28 = {Enabled = false, Width = 130}
            if a50 then
                tbl_28.Size = a50
            end
            local v64 = function()
                --[[
                  line: 723
                ]]
            end
            smallButton(v63, "Dark", a49, v64, tbl_28)
        else
            local v65 = ((a48.joinMode ~= "request") and "JOIN") or "ASK TO JOIN"
            local tbl_29 = {Enabled = 0, TextSize = 0, Width = 130}
            tbl_29.TextSize = ((a48.joinMode ~= "request") and 16) or 15
            tbl_29.Enabled = not u27
            if a50 then
                tbl_29.Size = a50
            end
            local v66 = function()
                --[[
                  line: 727
                  upvalues:
                    u27 (copy, index: 1)
                    a1 (copy, index: 2)
                    Tribes_upv_1 (copy, index: 3)
                    act (copy, index: 4)
                    a48 (copy, index: 5)
                    TribeEmblem_upv_1 (copy, index: 6)
                ]]
                if u27 then
                    a1.Toast(Tribes_upv_1.Message("cooldown"), "error")
                else
                    local v67, v68 = act("Join", a48.id)
                    if v67 and type(v68) == "table" then
                        if v68.joined then
                            a1.Sounds.Play("Queue_Join")
                            local Toast_1 = a1.Toast
                            local Tag_5 = TribeEmblem_upv_1.Tag
                            local v69
                            if type(a48) ~= "table" then
                                v69 = a48
                            else
                                v69 = a48.tag
                            end
                            Toast_1(("Welcome to %* %*!"):format(Tag_5(v69), tostring(a48.name)), "success")
                            return
                        end
                        if v68.requested then
                            local Toast_2 = a1.Toast
                            local Tag_6 = TribeEmblem_upv_1.Tag
                            local v69
                            if type(a48) ~= "table" then
                                v69 = a48
                            else
                                v69 = a48.tag
                            end
                            Toast_2(("Request sent to %*"):format(Tag_6(v69)), "info")
                        end
                    end
                end
            end
            smallButton(v65, "Dark", a49, v66, tbl_29)
        end
    end
    local u28 = 0
    local u29 = nil
    local u30 = nil
    local u31 = nil
    local u32 = ""
    local function rowsSig()
        --[[
          name: rowsSig
          line: 755
          upvalues:
            u6 (ref,  index: 1)
            roleIn (copy, index: 2)
            Tribes_upv_2 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
        ]]
        local v70 = u6 or {}
        local v71 = u6 and (u6.tribe)
        local v72
        if type(v71) ~= "table" then
            v72 = Tribes_upv_2.Mine()
        else
            v72 = {}
            v72.id = v71.id
            v72.role = roleIn(v71)
        end
        local tbl_30 = {}
        local v73 = ((type(v70.requested) ~= "table") and {}) or (v70.requested)
        for _, value_9 in v73 do
            table.insert(tbl_30, (tostring(value_9)))
        end
        local v74 = (type(v70.cooldownUntil) == "number") and (os.time() < v70.cooldownUntil)
        return (("%*|%*|%*|%*"):format(((not v72) and 0) or (v72.id), table.concat(tbl_30, ","), v74, LocalPlayer_upv_1:GetAttribute("Level") or 1))
    end
    local function drawRows(a52, a53)
        --[[
          name: drawRows
          line: 765
          upvalues:
            u32 (ref,  index: 1)
            rowsSig (copy, index: 2)
            clear (copy, index: 3)
            u24 (copy, index: 4)
            u25 (copy, index: 5)
            u26 (copy, index: 6)
            u22 (copy, index: 7)
            tribeRow (copy, index: 8)
            u6 (ref,  index: 9)
            roleIn (copy, index: 10)
            Tribes_upv_2 (copy, index: 11)
            UI_upv_1 (copy, index: 12)
            Colors_upv_1 (copy, index: 13)
            smallButton (copy, index: 14)
            u9 (ref,  index: 15)
            joinButton (copy, index: 16)
        ]]
        u32 = rowsSig()
        clear(u24)
        u25.Visible = #a52 == 0
        u26.Text = ((u22.Text == "") and "No tribes yet. Found the first one!") or "No tribe matches that."
        for key_7, value_upv_10 in a52 do
            if type(value_upv_10) ~= "table" then
                continue
            end
            local v75 = tribeRow(
                value_upv_10,
                u24,
                key_7,
                function(a54)
                    --[[
                      line: 772
                      upvalues:
                        u6 (ref,  index: 1)
                        roleIn (copy, index: 2)
                        Tribes_upv_2 (copy, index: 3)
                        value_upv_10 (copy, index: 4)
                        UI_upv_1 (copy, index: 5)
                        Colors_upv_1 (copy, index: 6)
                        smallButton (copy, index: 7)
                        u9 (ref,  index: 8)
                        joinButton (copy, index: 9)
                    ]]
                    local v76 = u6 and (u6.tribe)
                    local v77
                    if type(v76) ~= "table" then
                        v77 = Tribes_upv_2.Mine()
                    else
                        v77 = {}
                        v77.id = v76.id
                        v77.role = roleIn(v76)
                    end
                    if not v77 or v77.id ~= value_upv_10.id then
                        if v77 then
                            smallButton(
                                "VIEW",
                                "Dark",
                                a54,
                                function()
                                    --[[
                                      line: 778
                                      upvalues:
                                        u9 (ref,  index: 1)
                                        value_upv_10 (copy, index: 2)
                                    ]]
                                    u9(value_upv_10.id, value_upv_10)
                                end,
                                {Width = 130}
                            )
                        else
                            joinButton(value_upv_10, a54)
                        end
                    end
                    UI_upv_1.Pill("YOUR TRIBE", Colors_upv_1.Accent, {Height = 26, TextSize = 12, Parent = a54})
                end
            )
            if a53 then
                UI_upv_1.Enter(v75, Vector2.new(0, 10), math.min(key_7 * 0.03, 0.25), UDim2.new())
            end
        end
    end
    local function runSearch()
        --[[
          name: runSearch
          line: 791
          upvalues:
            u22 (copy, index: 1)
            u23 (ref,  index: 2)
            u31 (ref,  index: 3)
            u28 (ref,  index: 4)
            u29 (ref,  index: 5)
            Tribes_upv_2 (copy, index: 6)
            u30 (ref,  index: 7)
            drawRows (copy, index: 8)
            clear (copy, index: 9)
            u24 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            tbl_upv_1 (ref,  index: 12)
            Colors_upv_1 (copy, index: 13)
            u25 (copy, index: 14)
            u26 (copy, index: 15)
            Tribes_upv_1 (copy, index: 16)
            HttpService_upv_1 (copy, index: 17)
            rowsSig (copy, index: 18)
            u32 (ref,  index: 19)
        ]]
        local Text_1 = u22.Text .. "\n" .. u23
        if u31 == Text_1 then
            return
        end
        u28 = u28 + 1
        u31 = Text_1
        local v78 = u29 ~= Text_1
        local Text_2 = u22.Text
        local v79
        if Text_2 ~= "" then
            v79 = nil
        else
            v79 = Tribes_upv_2.CachedBoard(u23)
        end
        if v78 and type(v79) == "table" then
            u29 = Text_1
            u30 = v79
            drawRows(v79, true)
            v78 = false
        end
        if v78 then
            clear(u24)
            for n_1 = 1, 4 do
                local tbl_31 = {BackgroundTransparency = 0.78}
                UI_upv_1.Tween(UI_upv_1.new("Frame", {Name = "Skeleton", Size = UDim2.new(1, -4, 0, tbl_upv_1.row + 8), LayoutOrder = n_1, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(12), Parent = u24}), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, n_1 * 0.12), tbl_31)
            end
            u25.Visible = false
        end
        local v80, v81
        if Text_2 ~= "" then
            local v82, v83 = Tribes_upv_2.Action("Search", Text_2, u23)
            v80, v81 = v82, v83
        else
            local v84, v85 = Tribes_upv_2.Board(u23)
            v80, v81 = v84, v85
        end
        if u28 ~= u28 then
            return
        end
        u31 = nil
        if v80 and type(v81) == "table" then
            if not (v78) and u30 then
                local success_2, v86 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, v81)
                local v87
                if success_2 then
                    v87 = v86
                else
                    v87 = tostring(os.clock())
                end
                local success_3, v88 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, u30)
                local v85
                if success_3 then
                    v85 = v88
                else
                    v85 = tostring(os.clock())
                end
                if v87 == v85 and rowsSig() == u32 then
                    return
                end
            end
            u29 = Text_1
            u30 = v81
            drawRows(v81, v78)
            return
        end
        if v78 or not (u30) then
            u29 = nil
            u30 = nil
            clear(u24)
            u25.Visible = true
            local v89 = v81 or (Tribes_upv_1.Message("unavailable"))
            u26.Text = tostring(v89)
        end
    end
    local function redrawRows()
        --[[
          name: redrawRows
          line: 842
          upvalues:
            u30 (ref,  index: 1)
            u31 (ref,  index: 2)
            u14 (ref,  index: 3)
            rowsSig (copy, index: 4)
            u32 (ref,  index: 5)
            drawRows (copy, index: 6)
        ]]
        if not u30 or (u31) or u14 ~= "Find" or rowsSig() == u32 then
            return
        end
        drawRows(u30, false)
    end
    local function paintSort()
        --[[
          name: paintSort
          line: 847
          upvalues:
            tbl_upv_19 (copy, index: 1)
            u23 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v90 = nil
        for key_8, value_11 in tbl_upv_19 do
            value_11.BackgroundTransparency = ((key_8 ~= u23) and 1) or 0
            if key_8 ~= u23 then
                v90 = Colors_upv_1.TextDim
            else
                v90 = Colors_upv_1.Text
            end
            value_11.TextColor3 = v90
        end
    end
    for key_upv_9, value_12 in tbl_upv_19 do
        value_12.Activated:Connect(
            function()
                --[[
                  line: 854
                  upvalues:
                    u23 (ref,  index: 1)
                    key_upv_9 (copy, index: 2)
                    u10 (ref,  index: 3)
                    a1 (copy, index: 4)
                    paintSort (copy, index: 5)
                    runSearch (copy, index: 6)
                ]]
                if u23 ~= key_upv_9 then
                    local v91 = os.clock() - u10 >= 0.5
                    if not v91 then
                        return
                    end
                    u23 = key_upv_9
                    a1.Sounds.Play("Click")
                    paintSort()
                    runSearch()
                end
            end
        )
    end
    u22.FocusLost:Connect(
        function()
            --[[
              line: 863
              upvalues:
                runSearch (copy, index: 1)
            ]]
            runSearch()
        end
    )
    local tbl_upv_32 = {{"three-people", "Play together", "Up to 2x Glory with tribemates"}, {"location-pin-map", "Hold the maps", "Most Glory on a map holds it"}, {"trophy", "Weekly Tribe Chest", "Item shards every Monday"}}
    local u33 = 0
    local u34 = -math.huge
    local function heroTile(a55, a56, a57)
        --[[
          name: heroTile
          line: 277
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Glow_upv_1 (copy, index: 3)
        ]]
        local u35 = {}
        u35.Name = "Hero"
        u35.Size = UDim2.new(1, 0, 0, a56)
        u35.BackgroundColor3 = Color3.new(1, 1, 1)
        u35.ClipsDescendants = true
        u35.LayoutOrder = a57
        u35[1] = UI_upv_1.Corner(12)
        u35.Parent = a55
        local v92 = UI_upv_1.new("Frame", u35)
        local u36 = UI_upv_1.Gradient(Colors_upv_1.Accent, Colors_upv_1.Panel, 115)
        u36.Parent = v92
        u35 = UI_upv_1.Image(Glow_upv_1, {Name = "Glow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46), Size = UDim2.fromScale(1.15, 1.35), Parent = v92})
        local Accent_1 = Colors_upv_1.Accent
        u36.Color = ColorSequence.new(Accent_1:Lerp(Colors_upv_1.Panel, 0.45), Colors_upv_1.Panel:Lerp(Colors_upv_1.PanelLo, 0.5))
        u35.ImageColor3 = Accent_1
        local function tint_1(a58)
            --[[
              name: tint
              line: 290
              upvalues:
                u36 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
                u35 (copy, index: 3)
            ]]
            u36.Color = ColorSequence.new(a58:Lerp(Colors_upv_1.Panel, 0.45), Colors_upv_1.Panel:Lerp(Colors_upv_1.PanelLo, 0.5))
            u35.ImageColor3 = a58
        end
        return v92, tint_1
    end
    local function card(a59, a60, a61)
        --[[
          name: card
          line: 196
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        local v93 = a61 or {}
        local new_2 = UI_upv_1.new
        local tbl_33 = {}
        tbl_33.Name = a59
        tbl_33.BackgroundColor3 = v93.Color or (Colors_upv_1.PanelHi)
        tbl_33.BackgroundTransparency = v93.Transparency or 0.35
        tbl_33.Size = v93.Size or UDim2.new(1, -6, 0, 0)
        tbl_33.AutomaticSize = v93.AutomaticSize or (Enum.AutomaticSize.Y)
        tbl_33.LayoutOrder = v93.LayoutOrder or 0
        tbl_33[1], tbl_33[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        tbl_33.Parent = a60
        return new_2("Frame", tbl_33)
    end
    local function renderFindLeft(a62)
        --[[
          name: renderFindLeft
          line: 874
          upvalues:
            clear (copy, index: 1)
            u20 (copy, index: 2)
            u33 (ref,  index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            Tribes_upv_1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            heroTile (copy, index: 7)
            tbl_upv_1 (ref,  index: 8)
            TribeEmblem_upv_1 (copy, index: 9)
            label (copy, index: 10)
            Fonts_upv_1 (copy, index: 11)
            tbl_upv_32 (copy, index: 12)
            fromOffset_upv_1 (copy, index: 13)
            Colors_upv_1 (copy, index: 14)
            Theme_upv_1 (copy, index: 15)
            u1 (copy, index: 16)
            u10 (ref,  index: 17)
            a1 (copy, index: 18)
            caps (copy, index: 19)
            u2 (copy, index: 20)
            u34 (ref,  index: 21)
            untilText (copy, index: 22)
            section (copy, index: 23)
            card (copy, index: 24)
            smallButton (copy, index: 25)
            act (copy, index: 26)
        ]]
        clear(u20)
        u33 = u33 + 1
        local v95 = LocalPlayer_upv_1:GetAttribute("Level") or 1
        local u37 = (type(a62.cooldownUntil) == "number") and (os.time() < a62.cooldownUntil)
        local v96
        if type(a62.foundLevel) ~= "number" then
            v96 = Tribes_upv_1.FOUND_LEVEL
        else
            v96 = a62.foundLevel
        end
        local v97 = UI_upv_1.Panel({LayoutOrder = 1, Name = "FoundPanel", BackgroundTransparency = 0.06, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = u20})
        UI_upv_1.Padding(12, 12, 12, 12).Parent = v97
        UI_upv_1.List(Enum.FillDirection.Vertical, 10).Parent = v97
        local u38, u39 = heroTile(v97, tbl_upv_1.hero - 30, 1)
        local u40 = TribeEmblem_upv_1.new(96, {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u38})
        local u41 = u33
        task.spawn(
            function()
                --[[
                  line: 888
                  upvalues:
                    u41 (copy, index: 1)
                    u33 (ref,  index: 2)
                    u38 (copy, index: 3)
                    u40 (copy, index: 4)
                    Tribes_upv_1 (copy, index: 5)
                    u39 (copy, index: 6)
                    UI_upv_1 (copy, index: 7)
                ]]
                local v98 = Random.new()
                while u41 == u33 do
                    if u38.Parent then
                        local v99 = v98:NextInteger(1, 14)
                        u40:Set(v98:NextInteger(1, #Tribes_upv_1.ICONS), v99, ({Tribes_upv_1.WHITE, Tribes_upv_1.WHITE, 6, 20})[v98:NextInteger(1, 4)], nil)
                        u39(Tribes_upv_1.Color(v99))
                        UI_upv_1.Pop(u40.Instance, 0.9)
                        task.wait(2.2)
                        continue
                    else
                        break
                    end
                end
            end
        )
        label({LayoutOrder = 2, Name = "Title", Text = "FOUND A TRIBE", TextSize = 26, FontFace = Fonts_upv_1.Display, Size = UDim2.new(1, 0, 0, 30), Parent = v97})
        for key_10, value_13 in tbl_upv_32 do
            local v100 = UI_upv_1.new("Frame", {Name = "Perk" .. key_10, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 2 + key_10, Parent = v97})
            local v101 = UI_upv_1.new("Frame", {Name = "Icon", Size = fromOffset_upv_1(32, 32), Position = fromOffset_upv_1(0, 3), BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 0.8, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v100})
            UI_upv_1.Glyph(value_13[1], 18, Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.3), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v101})
            label({Name = "Title", TextSize = 15, Text = value_13[2], FontFace = Fonts_upv_1.Heavy, Position = fromOffset_upv_1(42, 0), Size = UDim2.new(1, -42, 0, 18), Parent = v100})
            label({Name = "Text", TextSize = 13, Text = value_13[3], FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Position = fromOffset_upv_1(42, 19), Size = UDim2.new(1, -42, 0, 16), Parent = v100})
        end
        local Economy_upv_1
        if v96 <= v95 then
            local v102 = UI_upv_1.Button({LayoutOrder = 8, Name = "Found", Text = "FOUND A TRIBE", Style = "Primary", Size = UDim2.new(1, 0, 0, 52), Parent = v97})
            v102.Activated:Connect(
                function()
                    --[[
                      line: 908
                      upvalues:
                        u10 (ref,  index: 1)
                        u37 (copy, index: 2)
                        a1 (copy, index: 3)
                        Tribes_upv_1 (copy, index: 4)
                    ]]
                    local v103 = os.clock() - u10 >= 0.5
                    if not v103 then
                        return
                    end
                    if u37 then
                        a1.Toast(Tribes_upv_1.Message("cooldown"), "error")
                    else
                        a1.OpenTribeForm("create")
                    end
                end
            )
            if u37 then
                v102:SetEnabled(false)
            end
        else
            local v104 = UI_upv_1.new("Frame", {Name = "Lock", Size = UDim2.new(1, 0, 0, 54), LayoutOrder = 8, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(10), Parent = v97})
            UI_upv_1.Glyph("lock-closed", 18, Colors_upv_1.TextDim, {Position = fromOffset_upv_1(12, 9), Parent = v104})
            label({Name = "Text", TextSize = 15, Text = ("Reach level %* to found a tribe"):format(v96), FontFace = Fonts_upv_1.Heavy, Position = fromOffset_upv_1(38, 8), Size = UDim2.new(1, -110, 0, 20), Parent = v104})
            caps(("LV %* / %*"):format(v95, v96), {TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Size = fromOffset_upv_1(80, 14), Parent = v104})
            local v105 = UI_upv_1.new("Frame", {Name = "Bar", Position = fromOffset_upv_1(12, 36), Size = UDim2.new(1, -24, 0, 8), BackgroundColor3 = u2, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v104})
            UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(math.clamp(v95 / v96, 0.03, 1), 1), BackgroundColor3 = Colors_upv_1.Accent, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v105})
            Economy_upv_1 = a1.Economy
            if (Economy_upv_1) and (Economy_upv_1.CanBuy("tribe_found")) then
                local u42 = UI_upv_1.Button({LayoutOrder = 9, Name = "FoundNow", Text = "", Style = "Primary", Size = UDim2.new(1, 0, 0, 52), Parent = v97})
                u42.Label.RichText = true
                local function paintBuy_upv_1()
                    --[[
                      name: paintBuy
                      line: 934
                      upvalues:
                        Economy_upv_1 (copy, index: 1)
                        u42 (copy, index: 2)
                        u37 (copy, index: 3)
                    ]]
                    local v106 = Economy_upv_1.Pending("tribe_found")
                    u42:SetEnabled(not v106 and (not u37))
                    local v107 = (v106 and "FOUNDING\226\128\166") or (string.format("FOUND NOW   <font color=\"#FFFFFF\">%s</font> %s", Economy_upv_1.ROBUX, Economy_upv_1.PriceAmount("tribe_found")))
                    u42:SetText(v107)
                end
                paintBuy_upv_1()
                local u43 = nil
                local v108 = Economy_upv_1.Changed:Connect(
                    function()
                        --[[
                          line: 941
                          upvalues:
                            u42 (copy, index: 1)
                            paintBuy_upv_1 (copy, index: 2)
                            u43 (ref,  index: 3)
                        ]]
                        if u42.Instance.Parent then
                            paintBuy_upv_1()
                        else
                            u43:Disconnect()
                        end
                    end
                )
                u43 = v108
                u42.Activated:Connect(
                    function()
                        --[[
                          line: 948
                          upvalues:
                            u10 (ref,  index: 1)
                            Economy_upv_1 (copy, index: 2)
                            u37 (copy, index: 3)
                            a1 (copy, index: 4)
                            Tribes_upv_1 (copy, index: 5)
                            u34 (ref,  index: 6)
                        ]]
                        local v109 = os.clock() - u10 >= 0.5
                        if not v109 or (Economy_upv_1.Pending("tribe_found")) then
                            return
                        end
                        if u37 then
                            a1.Toast(Tribes_upv_1.Message("cooldown"), "error")
                        else
                            u34 = os.clock()
                            Economy_upv_1.Buy("tribe_found")
                        end
                    end
                )
                caps("OR JOIN A TRIBE AT ANY LEVEL", {LayoutOrder = 10, TextXAlignment = Enum.TextXAlignment.Center, Parent = v97})
            else
                caps("YOU CAN JOIN A TRIBE AT ANY LEVEL", {LayoutOrder = 9, TextXAlignment = Enum.TextXAlignment.Center, Parent = v97})
            end
        end
        if u37 then
            label({LayoutOrder = 11, Name = "Cooldown", TextWrapped = true, TextSize = 13, Text = ("You left a tribe recently. You can join or found one again in %*."):format(untilText(a62.cooldownUntil)), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.Warning, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = v97})
        end
        local v110 = ((type(a62.invites) ~= "table") and {}) or (a62.invites)
        if #v110 > 0 then
            section("INVITES", #v110, nil, 2, u20, Colors_upv_1.Warning)
            local v111 = nil
            for key_11, value_14 in v110 do
                local tribe_upv_1 = value_14.tribe
                if type(tribe_upv_1) ~= "table" then
                    continue
                end
                local v112 = card("Invite" .. key_11, u20, {LayoutOrder = 2 + key_11})
                UI_upv_1.Padding(12, 12, 12, 12).Parent = v112
                UI_upv_1.List(Enum.FillDirection.Vertical, 10).Parent = v112
                local v113 = UI_upv_1.new("Frame", {LayoutOrder = 1, Name = "Top", Size = UDim2.new(1, 0, 0, 54), Parent = v112})
                local tbl_34 = {}
                tbl_34.Parent = v113
                TribeEmblem_upv_1.new(50, tbl_34):Set(tribe_upv_1.icon, tribe_upv_1.color1, tribe_upv_1.color2, tribe_upv_1.tag)
                local tbl_35 = {FontFace = 0, RichText = true, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
                local v114 = TribeEmblem_upv_1.TagColor(tribe_upv_1.color1):ToHex()
                local Tag_7 = TribeEmblem_upv_1.Tag
                if type(tribe_upv_1) ~= "table" then
                    v111 = tribe_upv_1
                else
                    v111 = tribe_upv_1.tag
                end
                tbl_35.Text = string.format("<font color=\"#%s\">%s</font>  %s", v114, Tag_7(v111), tostring(tribe_upv_1.name or ""))
                tbl_35.FontFace = Fonts_upv_1.Heavy
                tbl_35.Position = fromOffset_upv_1(62, 7)
                tbl_35.Size = UDim2.new(1, -62, 0, 20)
                tbl_35.Parent = v113
                label(tbl_35)
                local v115 = nil
                label({Name = "From", TextSize = 13, Text = ("%* invited you  \194\183  %*/%* members"):format(tostring(v115.from or "?"), tonumber(tribe_upv_1.members) or 0, Tribes_upv_1.MAX_MEMBERS), FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Position = fromOffset_upv_1(62, 29), Size = UDim2.new(1, -62, 0, 16), Parent = v113})
                local v116 = UI_upv_1.new("Frame", {Name = "Row", Size = UDim2.new(1, 0, 0, 40), LayoutOrder = 2, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8), Parent = v112})
                smallButton(
                    "JOIN",
                    "Primary",
                    v116,
                    function()
                        --[[
                          line: 982
                          upvalues:
                            act (copy, index: 1)
                            tribe_upv_1 (copy, index: 2)
                            a1 (copy, index: 3)
                            TribeEmblem_upv_1 (copy, index: 4)
                        ]]
                        if act("Join", tribe_upv_1.id) then
                            a1.Sounds.Play("Queue_Join")
                            local Toast_3 = a1.Toast
                            local Tag_8 = TribeEmblem_upv_1.Tag
                            local v117
                            if type(tribe_upv_1) ~= "table" then
                                v117 = tribe_upv_1
                            else
                                v117 = tribe_upv_1.tag
                            end
                            Toast_3(("Welcome to %* %*!"):format(Tag_8(v117), tostring(tribe_upv_1.name)), "success")
                        end
                    end,
                    {Size = UDim2.new(0.5, -4, 1, 0)}
                )
                smallButton(
                    "DECLINE",
                    "Dark",
                    v116,
                    function()
                        --[[
                          line: 988
                          upvalues:
                            act (copy, index: 1)
                            tribe_upv_1 (copy, index: 2)
                        ]]
                        act("Decline", tribe_upv_1.id)
                    end,
                    {Size = UDim2.new(0.5, -4, 1, 0)}
                )
            end
        end
    end
    tbl_upv_11.Find = function()
        --[[
          line: 996
          upvalues:
            paintSort (copy, index: 1)
            runSearch (copy, index: 2)
        ]]
        paintSort()
        runSearch()
    end
    local u44 = column("Left", v26.page, 12)
    local u45 = column("Right", v26.page, 12)
    local tbl_upv_36 = {kicked = 0, joined = 0, chief = 0, demoted = 0, left = 0, promoted = 0, renamed = 0, lost = 0, founded = 0, took = 0}
    function tbl_upv_36.founded(a63)
        --[[
          name: founded
          line: 1006
        ]]
        return (("%* founded the tribe"):format(a63.name))
    end
    function tbl_upv_36.joined(a64)
        --[[
          name: joined
          line: 1009
        ]]
        return (("%* joined"):format(a64.name))
    end
    function tbl_upv_36.left(a65)
        --[[
          name: left
          line: 1012
        ]]
        return (("%* left"):format(a65.name))
    end
    function tbl_upv_36.kicked(a66)
        --[[
          name: kicked
          line: 1015
        ]]
        return (("%* removed %*"):format(a66.by, a66.name))
    end
    function tbl_upv_36.promoted(a67)
        --[[
          name: promoted
          line: 1018
        ]]
        return (("%* is now an Elder"):format(a67.name))
    end
    function tbl_upv_36.demoted(a68)
        --[[
          name: demoted
          line: 1021
        ]]
        return (("%* is now a Member"):format(a68.name))
    end
    function tbl_upv_36.chief(a69)
        --[[
          name: chief
          line: 1024
        ]]
        return (("%* is now the Chief"):format(a69.name))
    end
    function tbl_upv_36.renamed(a70)
        --[[
          name: renamed
          line: 1027
        ]]
        return (("The tribe is now called %*"):format(a70.name))
    end
    function tbl_upv_36.took(a71)
        --[[
          name: took
          line: 1030
          upvalues:
            Tribes_upv_2 (copy, index: 1)
        ]]
        if a71.from then
            return (("Took %* from [%*]"):format(Tribes_upv_2.MapName(a71.mapId), a71.from))
        end
        return (("Took %*"):format(Tribes_upv_2.MapName(a71.mapId)))
    end
    function tbl_upv_36.lost(a72)
        --[[
          name: lost
          line: 1033
          upvalues:
            Tribes_upv_2 (copy, index: 1)
        ]]
        return (("[%*] took %*"):format(a72.to, Tribes_upv_2.MapName(a72.mapId)))
    end
    local tbl_upv_37 = {}
    tbl_upv_37.founded = {"flag", Colors_upv_1.Accent}
    tbl_upv_37.joined = {"person-plus", Colors_upv_1.Success}
    tbl_upv_37.left = {"door-open-arrow-to-bottom-right", Colors_upv_1.TextMuted}
    tbl_upv_37.kicked = {"door-open-arrow-to-bottom-right", Colors_upv_1.Danger}
    tbl_upv_37.promoted = {"crown", u3}
    tbl_upv_37.demoted = {"person", Colors_upv_1.TextMuted}
    tbl_upv_37.chief = {"crown", u3}
    tbl_upv_37.renamed = {"pencil", Colors_upv_1.Accent}
    tbl_upv_37.took = {"location-pin-map", Colors_upv_1.Success}
    tbl_upv_37.lost = {"location-pin-map", Colors_upv_1.Danger}
    local u46 = 0
    local function heldChips(a73, a74, a75, a76, a77, a78)
        --[[
          name: heldChips
          line: 1054
          upvalues:
            UI_upv_1 (copy, index: 1)
            card (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            label (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            u1 (copy, index: 6)
            fromOffset_upv_1 (copy, index: 7)
            smallButton (copy, index: 8)
            showTab (copy, index: 9)
            Tribes_upv_2 (copy, index: 10)
            u10 (ref,  index: 11)
            a1 (copy, index: 12)
        ]]
        local new_3 = UI_upv_1.new
        local v118 = "Frame"
        local tbl_38 = {LayoutOrder = 0, Name = "Held", Parent = 0, AutomaticSize = 0, Size = 0}
        tbl_38.Size = UDim2.new(1, -6, 0, ((#a73 ~= 0) and 0) or 64)
        local v119
        if #a73 ~= 0 then
            v119 = Enum.AutomaticSize.Y
        else
            v119 = Enum.AutomaticSize.None
        end
        tbl_38.AutomaticSize = v119
        tbl_38.LayoutOrder = a75
        tbl_38.Parent = a74
        local v120 = new_3(v118, tbl_38)
        if #a73 ~= 0 then
            UI_upv_1.new("UIGridLayout", {CellSize = fromOffset_upv_1(180, 104), CellPadding = fromOffset_upv_1(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = v120})
            local v121 = Tribes_upv_2.CachedTerritories()
            local tbl_upv_39 = {}
            local v122 = nil
            for key_12, value_upv_15 in a73 do
                local v123 = v121 and (v121.maps and (v121.maps[value_upv_15]))
                local v124 = UI_upv_1.new("TextButton", {Name = value_upv_15, Text = "", AutoButtonColor = false, LayoutOrder = key_12, BackgroundColor3 = Colors_upv_1.Raised, ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = v120})
                local new_4 = UI_upv_1.new
                local tbl_40 = {Image = 0, Name = "Thumb", Parent = 0, ScaleType = 0, Size = 0}
                if not (v123) then
                    v122 = ""
                    tbl_40.Image = tostring(v122)
                    tbl_40.Size = UDim2.fromScale(1, 1)
                    tbl_40.ScaleType = Enum.ScaleType.Crop
                    tbl_40.Parent = v124
                    tbl_upv_39[value_upv_15] = new_4("ImageLabel", tbl_40)
                    UI_upv_1.new("Frame", {Name = "Shade", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Gradient(Color3.new(0, 0, 0), Color3.new(0, 0, 0), 90, NumberSequence.new(1, 0.15)), Parent = v124})
                    UI_upv_1.new("Frame", {Name = "Tint", Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = a76, Parent = v124})
                    label({Name = "Name", TextSize = 16, Text = Tribes_upv_2.MapName(value_upv_15), FontFace = Fonts_upv_1.Heavy, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -8), Size = UDim2.new(1, -20, 0, 20), Parent = v124})
                    v124.Activated:Connect(
                        function()
                            --[[
                              line: 1075
                              upvalues:
                                u10 (ref,  index: 1)
                                a1 (copy, index: 2)
                                value_upv_15 (copy, index: 3)
                                showTab (copy, index: 4)
                            ]]
                            local v125 = os.clock() - u10 >= 0.5
                            if not v125 then
                                return
                            end
                            a1.Sounds.Play("Click")
                            a1.TribeMapSelect = value_upv_15
                            showTab("Territories")
                        end
                    )
                    continue
                end
                v122 = v123.thumb or ""
                tbl_40.Image = tostring(v122)
                tbl_40.Size = UDim2.fromScale(1, 1)
                tbl_40.ScaleType = Enum.ScaleType.Crop
                tbl_40.Parent = v124
                tbl_upv_39[value_upv_15] = new_4("ImageLabel", tbl_40)
                UI_upv_1.new("Frame", {Name = "Shade", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Gradient(Color3.new(0, 0, 0), Color3.new(0, 0, 0), 90, NumberSequence.new(1, 0.15)), Parent = v124})
                UI_upv_1.new("Frame", {Name = "Tint", Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = a76, Parent = v124})
                label({Name = "Name", TextSize = 16, Text = Tribes_upv_2.MapName(value_upv_15), FontFace = Fonts_upv_1.Heavy, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -8), Size = UDim2.new(1, -20, 0, 20), Parent = v124})
                v124.Activated:Connect(
                    function()
                        --[[
                          line: 1075
                          upvalues:
                            u10 (ref,  index: 1)
                            a1 (copy, index: 2)
                            value_upv_15 (copy, index: 3)
                            showTab (copy, index: 4)
                        ]]
                        local v125 = os.clock() - u10 >= 0.5
                        if not v125 then
                            return
                        end
                        a1.Sounds.Play("Click")
                        a1.TribeMapSelect = value_upv_15
                        showTab("Territories")
                    end
                )
            end
            if not (v121) then
                task.spawn(
                    function()
                        --[[
                          line: 1085
                          upvalues:
                            Tribes_upv_2 (copy, index: 1)
                            a77 (copy, index: 2)
                            tbl_upv_39 (copy, index: 3)
                        ]]
                        local v126 = Tribes_upv_2.Territories(false)
                        if not a77() or not v126 or type(v126.maps) ~= "table" then
                            return
                        end
                        for key_13, value_16 in tbl_upv_39 do
                            local v127 = v126.maps[key_13]
                            if not (value_16.Parent) then
                                continue
                            end
                            if v127 then
                                value_16.Image = tostring(v127.thumb or "")
                            end
                        end
                    end
                )
            end
        else
            local v128 = card("Empty", v120, {Transparency = 0.5, Size = UDim2.fromScale(1, 1), AutomaticSize = Enum.AutomaticSize.None})
            UI_upv_1.Glyph("location-pin-map", 22, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Parent = v128})
            label({Name = "Text", TextWrapped = true, TextSize = 14, Text = a78, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Position = fromOffset_upv_1(48, 0), Size = UDim2.new(1, -170, 1, 0), TextTruncate = Enum.TextTruncate.None, Parent = v128})
            smallButton(
                "SEE THE MAP",
                "Dark",
                v128,
                function()
                    --[[
                      line: 1060
                      upvalues:
                        showTab (copy, index: 1)
                    ]]
                    showTab("Territories")
                end,
                {Height = 38, TextSize = 14, Width = 120, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0)}
            )
        end
        return v120
    end
    local function statTile(a79, a80, a81)
        --[[
          name: statTile
          line: 299
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            label (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            fromOffset_upv_1 (copy, index: 5)
            caps (copy, index: 6)
        ]]
        local v129 = UI_upv_1.new("Frame", {Name = "Stat_" .. a80, Size = UDim2.new(0.3333333333333333, -6, 1, 0), LayoutOrder = a81, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.35, [1] = UI_upv_1.Corner(10), Parent = a79})
        local tbl_41 = {Position = 0, Name = "Value", TextXAlignment = 0, Parent = 0, Text = "-", TextSize = 0, Size = 0}
        tbl_41.FontFace = Fonts_upv_1.Display
        tbl_41.TextSize = ((UI_upv_1.Compact) and 20) or 24
        tbl_41.TextXAlignment = Enum.TextXAlignment.Center
        tbl_41.Position = fromOffset_upv_1(0, ((UI_upv_1.Compact) and 5) or 8)
        tbl_41.Size = UDim2.new(1, 0, 0, 26)
        tbl_41.Parent = v129
        local v130 = label(tbl_41)
        caps(a80, {TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 1, -22), Size = UDim2.new(1, 0, 0, 14), Parent = v129})
        return v130
    end
    local function renderOverview(a82)
        --[[
          name: renderOverview
          line: 1101
          upvalues:
            u46 (ref,  index: 1)
            clear (copy, index: 2)
            u44 (copy, index: 3)
            u45 (copy, index: 4)
            roleIn (copy, index: 5)
            Tribes_upv_1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            heroTile (copy, index: 8)
            tbl_upv_1 (ref,  index: 9)
            TribeEmblem_upv_1 (copy, index: 10)
            Colors_upv_1 (copy, index: 11)
            tbl_upv_2 (copy, index: 12)
            fromOffset_upv_1 (copy, index: 13)
            label (copy, index: 14)
            Fonts_upv_1 (copy, index: 15)
            caps (copy, index: 16)
            tbl_upv_3 (copy, index: 17)
            statTile (copy, index: 18)
            u3 (copy, index: 19)
            smallButton (copy, index: 20)
            a1 (copy, index: 21)
            openDialog (copy, index: 22)
            act (copy, index: 23)
            section (copy, index: 24)
            untilText (copy, index: 25)
            card (copy, index: 26)
            u2 (copy, index: 27)
            Theme_upv_1 (copy, index: 28)
            LocalPlayer_upv_1 (copy, index: 29)
            u1 (copy, index: 30)
            heldChips (copy, index: 31)
            tbl_upv_36 (copy, index: 32)
            tbl_upv_37 (copy, index: 33)
            ago (copy, index: 34)
        ]]
        u46 = u46 + 1
        local u47 = u46
        clear(u44)
        clear(u45)
        local v131 = roleIn(a82)
        local v132 = Tribes_upv_1.Color(a82.color1)
        local v133 = UI_upv_1.Panel({LayoutOrder = 1, Name = "Hero", BackgroundTransparency = 0.06, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = u44})
        UI_upv_1.Padding(12, 12, 12, 12).Parent = v133
        UI_upv_1.List(Enum.FillDirection.Vertical, 10).Parent = v133
        local v134, v135 = heroTile(v133, tbl_upv_1.hero, 1)
        v135(v132)
        local new_5 = TribeEmblem_upv_1.new
        local v136 = ((UI_upv_1.Compact) and 78) or 124
        local tbl_42 = {ZIndex = 2}
        tbl_42.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_42.Position = UDim2.fromScale(0.5, 0.44)
        tbl_42.Parent = v134
        new_5(v136, tbl_42):Set(a82.icon, a82.color1, a82.color2, a82.tag)
        local Pill_1 = UI_upv_1.Pill
        local Tag_9 = TribeEmblem_upv_1.Tag
        local v137
        if type(a82) ~= "table" then
            v137 = a82
        else
            v137 = a82.tag
        end
        Pill_1(Tag_9(v137), Colors_upv_1.Void, {AutoLocalize = false, Transparency = 0.3, Height = 26, ZIndex = 3, TextSize = 15, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), TextColor = TribeEmblem_upv_1.TagColor(a82.color1), Parent = v134})
        local v138 = tbl_upv_2[v131]
        if v138 then
            UI_upv_1.Pill("YOU: " .. v138.text, v138.color, {Height = 22, ZIndex = 3, TextSize = 12, Position = fromOffset_upv_1(10, 10), Parent = v134})
        end
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 28, MinTextSize = 16, Parent = label({LayoutOrder = 2, Name = "Name", TextScaled = true, Text = string.upper(tostring(a82.name or "")), FontFace = Fonts_upv_1.Display, Size = UDim2.new(1, 0, 0, 32), Parent = v133})})
        local v139 = tonumber(a82.members) or 0
        local v140 = 0
        local v141 = ((type(a82.membersList) ~= "table") and {}) or (a82.membersList)
        v134 = v140
        for _, value_17 in v141 do
            v134 = (value_17.where and (v134 + 1)) or v134
        end
        caps(("%*/%* MEMBERS  \194\183  %* ONLINE  \194\183  %*"):format(v139, Tribes_upv_1.MAX_MEMBERS, v134, string.upper(tbl_upv_3[a82.joinMode] or "")), {LayoutOrder = 3, Parent = v133})
        local new_6 = UI_upv_1.new
        local tbl_43 = {}
        tbl_43.Name = "Stats"
        tbl_43.Size = UDim2.new(1, 0, 0, ((UI_upv_1.Compact) and 52) or 62)
        tbl_43.LayoutOrder = 4
        tbl_43[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8)
        tbl_43.Parent = v133
        local v142 = new_6("Frame", tbl_43)
        local v143 = statTile(v142, "WEEK RANK", 1)
        local v144 = statTile(v142, "GLORY", 2)
        local v145 = statTile(v142, "TERRITORIES", 3)
        local v146 = ((a82.rank) and ("#" .. tostring(a82.rank))) or "-"
        v143.Text = v146
        v144.TextColor3 = u3
        local v147 = ((type(a82.territories) ~= "table") and {}) or (a82.territories)
        v145.Text = tostring(#v147)
        v146 = UI_upv_1.CountUp(
            v144,
            function(a83)
                --[[
                  line: 1140
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                ]]
                return UI_upv_1.FormatCompact(math.floor(a83))
            end,
            0.6
        )
        local v148 = tonumber(a82.weekRenown) or 0
        local v149 = (tonumber(a82.weekRenown) or 0) == 0
        v146(v148, v149)
        tbl_43 = UI_upv_1.new("Frame", {Name = "Buttons", Size = UDim2.new(1, 0, 0, 42), LayoutOrder = 5, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8), Parent = v133})
        if v131 == "chief" then
            smallButton(
                "EDIT TRIBE",
                "Dark",
                tbl_43,
                function()
                    --[[
                      line: 1146
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    a1.OpenTribeForm("settings")
                end,
                {TextSize = 15, Size = UDim2.new(0.5, -4, 1, 0), Icon = UI_upv_1.Glyph("pencil", 18, Colors_upv_1.Text)}
            )
        end
        local tbl_44 = {Icon = 0, TextSize = 15, Size = 0}
        local v150
        if v131 ~= "chief" then
            v150 = UDim2.new(1, 0, 1, 0)
        else
            v150 = UDim2.new(0.5, -4, 1, 0)
        end
        tbl_44.Size = v150
        tbl_44.Icon = UI_upv_1.Glyph("door-open-arrow-to-bottom-right", 18, Colors_upv_1.Text)
        local v151 = function()
            --[[
              line: 1150
              upvalues:
                a82 (copy, index: 1)
                openDialog (copy, index: 2)
                Tribes_upv_1 (copy, index: 3)
                act (copy, index: 4)
                a1 (copy, index: 5)
                TribeEmblem_upv_1 (copy, index: 6)
            ]]
            local v152 = (tonumber(a82.members) or 0) <= 1
            local v153
            if v152 then
                v153 = "You're the last member: the tribe will be disbanded and its tag freed."
            else
                v153 = ("You can join another tribe in %* minutes. If you leave before Monday you lose this week's chest."):format(Tribes_upv_1.LEAVE_COOLDOWN // 60)
            end
            local tbl_45 = {text = "LEAVE TRIBE", style = "Danger"}
            function tbl_45.fn()
                --[[
                  name: fn
                  line: 1155
                  upvalues:
                    act (copy, index: 1)
                    a1 (copy, index: 2)
                    a82 (copy, index: 3)
                    TribeEmblem_upv_1 (copy, index: 4)
                ]]
                if act("Leave") then
                    local Toast_4 = a1.Toast
                    local Tag_10 = TribeEmblem_upv_1.Tag
                    local v154
                    if type(a82) ~= "table" then
                        v154 = a82
                    else
                        v154 = a82.tag
                    end
                    Toast_4(("You left %*"):format(Tag_10(v154)), "info")
                end
            end
            openDialog("Leave the tribe?", v153, {tbl_45, {text = "STAY"}})
        end
        smallButton("LEAVE", "Dark", tbl_43, v151, tbl_44)
        local v155 = tonumber(a82.weekRenown) or 0
        local v156 = Tribes_upv_1.ChestTier(v155)
        local v157 = Tribes_upv_1.CHEST_TIERS[v156 + 1]
        section("TRIBE CHEST", nil, ("opens Monday 00:00 UTC, in %*"):format(untilText(a82.weekEndsAt)), 1, u45, u3)
        local v158 = card("Chest", u45, {LayoutOrder = 2, Transparency = 0.25})
        UI_upv_1.Padding(16, 16, 16, 16).Parent = v158
        UI_upv_1.List(Enum.FillDirection.Vertical, 12).Parent = v158
        local v159 = UI_upv_1.new("Frame", {LayoutOrder = 1, Name = "Track", Size = UDim2.new(1, 0, 0, 58), Parent = v158})
        v146 = UI_upv_1.new("Frame", {Name = "Line", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 18, 0, 18), Size = UDim2.new(1, -36, 0, 8), BackgroundColor3 = u2, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v159})
        local v160 = Tribes_upv_1.CHEST_TIERS
        local v161 = 0
        local v162 = nil
        for n_2 = 1, #v160 do
            v162 = ((n_2 == 1) and 0) or (v160[n_2 - 1])
            if v160[n_2] <= v155 then
                v161 = n_2 / #v160
                continue
            end
            v161 = v161 + math.clamp((v155 - v162) / (v160[n_2] - v162), 0, 1) / #v160
            break
        end
        local v163 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v146})
        UI_upv_1.Gradient(Color3.fromRGB(255, 214, 110), u3, 0).Parent = v163
        UI_upv_1.Tween(v163, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromScale(math.clamp(v161, 0, 1), 1)})
        local v164 = nil
        local v165 = nil
        for key_14, value_18 in v160 do
            local v166 = value_18 <= v155
            local v167 = key_14 / #v160
            local new_7 = UI_upv_1.new
            local v168 = "Frame"
            local tbl_46 = {}
            tbl_46.Name = "Node" .. key_14
            tbl_46.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_46.Position = UDim2.new(v167, ((key_14 ~= #v160) and 0) or -4, 0.5, 0)
            tbl_46.Size = fromOffset_upv_1(34, 34)
            if v166 then
                v164 = u3
            else
                v164 = Colors_upv_1.Raised
            end
            tbl_46.BackgroundColor3 = v164
            tbl_46.ZIndex = 2
            local v169 = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
            local Stroke_1 = UI_upv_1.Stroke
            if v166 then
                v164 = Color3.fromRGB(255, 226, 150)
            elseif key_14 ~= v156 + 1 then
                v164 = Colors_upv_1.StrokeSoft
            end
            tbl_46[1], tbl_46[2] = v169, Stroke_1(v164, 2, 0)
            tbl_46.Parent = v146
            local v170 = new_7(v168, tbl_46)
            local tbl_47 = {TextColor3 = 0, Parent = 0, Name = "N", TextXAlignment = 0, ZIndex = 3, TextSize = 17, Size = 0}
            tbl_47.Text = tostring(key_14)
            tbl_47.FontFace = Fonts_upv_1.Display
            if v166 then
                v165 = Colors_upv_1.TextDark
            else
                v165 = Colors_upv_1.TextDim
            end
            tbl_47.TextColor3 = v165
            tbl_47.TextXAlignment = Enum.TextXAlignment.Center
            tbl_47.Size = UDim2.fromScale(1, 1)
            tbl_47.Parent = v170
            label(tbl_47)
            local v171 = UI_upv_1.FormatCompact(value_18)
            v165 = {Parent = 0, Position = 0, Size = 0}
            v165.TextXAlignment = Enum.TextXAlignment.Center
            v165.AnchorPoint = Vector2.new(0.5, 0)
            v165.Position = UDim2.new(v167, ((key_14 ~= #v160) and 0) or -4, 0, 40)
            v165.Size = fromOffset_upv_1(60, 14)
            v165.Parent = v159
            caps(v171, v165)
            if key_14 == v156 then
                UI_upv_1.Pop(v170, 1.25)
            end
        end
        local v172 = 0
        local v173 = ((type(a82.membersList) ~= "table") and {}) or (a82.membersList)
        v160 = v172
        for v185, value_19 in v173 do
            if value_19.userId == LocalPlayer_upv_1.UserId then
                v160 = tonumber(value_19.weekRenown) or 0
            end
        end
        v146 = UI_upv_1.new("Frame", {LayoutOrder = 2, Name = "Info", Size = UDim2.new(1, 0, 0, 40), Parent = v158})
        local tbl_48 = {FontFace = 0, Name = "Tribe", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 20, Size = 0}
        tbl_48.Text = not (v156 > 0) and "NO CHEST YET" or ("TIER %*"):format(v156)
        tbl_48.FontFace = Fonts_upv_1.Display
        local v175
        if v156 > 0 then
            v175 = u3
        else
            v175 = Colors_upv_1.TextDim
        end
        tbl_48.TextColor3 = v175
        tbl_48.Size = UDim2.new(0.5, 0, 0, 22)
        tbl_48.Parent = v146
        label(tbl_48)
        tbl_48 = {Position = 0, FontFace = 0, Name = "TribeSub", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 13, Size = 0}
        local v176 = ((not v157) and "Top tier this week") or (("%* more Glory for tier %*"):format(UI_upv_1.FormatNumber(v157 - v155), v156 + 1))
        tbl_48.Text = v176
        tbl_48.FontFace = Fonts_upv_1.SemiBold
        tbl_48.TextColor3 = u1
        tbl_48.Position = fromOffset_upv_1(0, 23)
        tbl_48.Size = UDim2.new(0.5, 0, 0, 16)
        tbl_48.Parent = v146
        label(tbl_48)
        tbl_43 = Tribes_upv_1.CHEST_MIN <= v160
        tbl_48 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, AnchorPoint = 0, Name = "You", TextXAlignment = 0, Position = 0, TextSize = 20, Size = 0}
        if tbl_43 then
            v176 = ("YOU: %* GLORY"):format(v160)
        else
            v176 = ("YOU: %* / %*"):format(v160, Tribes_upv_1.CHEST_MIN)
        end
        tbl_48.Text = v176
        tbl_48.FontFace = Fonts_upv_1.Display
        local v177
        if tbl_43 then
            v177 = Colors_upv_1.Success
        else
            v177 = Colors_upv_1.Warning
        end
        tbl_48.TextColor3 = v177
        tbl_48.TextXAlignment = Enum.TextXAlignment.Right
        tbl_48.AnchorPoint = Vector2.new(1, 0)
        tbl_48.Position = UDim2.new(1, 0, 0, 0)
        tbl_48.Size = UDim2.new(0.5, 0, 0, 22)
        tbl_48.Parent = v146
        label(tbl_48)
        tbl_48 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, AnchorPoint = 0, Name = "YouSub", TextXAlignment = 0, Position = 0, TextSize = 13, Size = 0}
        v176 = (tbl_43 and "You'll get this chest") or (("Earn %* more to get this chest"):format(Tribes_upv_1.CHEST_MIN - v160))
        tbl_48.Text = v176
        tbl_48.FontFace = Fonts_upv_1.SemiBold
        tbl_48.TextColor3 = u1
        tbl_48.TextXAlignment = Enum.TextXAlignment.Right
        tbl_48.AnchorPoint = Vector2.new(1, 0)
        tbl_48.Position = UDim2.new(1, 0, 0, 23)
        tbl_48.Size = UDim2.new(0.5, 0, 0, 16)
        tbl_48.Parent = v146
        label(tbl_48)
        section("TERRITORIES", #v147, ((#v147 ~= 0) and "held this week") or "win matches on a map to take it", 3, u45)
        heldChips(
            v147,
            u45,
            4,
            v132,
            function()
                --[[
                  line: 1263
                  upvalues:
                    u47 (copy, index: 1)
                    u46 (ref,  index: 2)
                ]]
                local v178 = u47 == u46
                return v178
            end,
            "No territories yet. The tribe with the most Glory on a map this week holds it."
        )
        local v179 = ((type(a82.feed) ~= "table") and {}) or (a82.feed)
        section("ACTIVITY", nil, nil, 5, u45)
        v146 = card("Feed", u45, {LayoutOrder = 6, Transparency = 0.5})
        UI_upv_1.List(Enum.FillDirection.Vertical, 0).Parent = v146
        tbl_43 = 0
        local v180 = nil
        for key_15, value_20 in v179 do
            local v181 = tbl_upv_36[tostring(value_20.kind)]
            if not (v181) or type(value_20.data) ~= "table" or not (tbl_43 < 20) then
                continue
            end
            tbl_43 = tbl_43 + 1
            local v182 = tbl_upv_37[value_20.kind] or {"flag", Colors_upv_1.Accent}
            local new_8 = UI_upv_1.new
            local tbl_49 = {Parent = 0, BackgroundTransparency = 0}
            tbl_49.Name = "F" .. key_15
            tbl_49.Size = UDim2.new(1, 0, 0, 44)
            tbl_49.LayoutOrder = key_15
            tbl_49.BackgroundColor3 = Colors_upv_1.Void
            tbl_49.BackgroundTransparency = ((tbl_43 % 2 ~= 0) and 1) or 0.85
            tbl_49.Parent = v146
            local v183 = new_8("Frame", tbl_49)
            v158 = UI_upv_1.new("Frame", {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = fromOffset_upv_1(28, 28), BackgroundColor3 = v182[2], BackgroundTransparency = 0.8, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v183})
            UI_upv_1.Glyph(v182[1], 16, v182[2], {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v158})
            local success_4, v184 = pcall(v181, value_20.data)
            local tbl_50 = {FontFace = 0, Name = "Text", Position = 0, Parent = 0, Text = 0, TextSize = 15, Size = 0}
            if success_4 then
                v180 = v184
            else
                v180 = ""
            end
            tbl_50.Text = v180
            tbl_50.FontFace = Fonts_upv_1.Bold
            tbl_50.Position = fromOffset_upv_1(50, 0)
            tbl_50.Size = UDim2.new(1, -150, 1, 0)
            tbl_50.Parent = v183
            label(tbl_50)
            caps(string.upper(ago(value_20.at)), {TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = fromOffset_upv_1(90, 14), Parent = v183})
        end
        if tbl_43 ~= 0 then
            return
        end
        label({Name = "NoFeed", Text = "Nothing yet.", TextSize = 14, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Size = UDim2.new(1, -24, 0, 40), Position = fromOffset_upv_1(12, 0), Parent = v146})
    end
    local canManage = UI_upv_1.new("Frame", {Name = "Head", Size = UDim2.new(1, 0, 0, 40), Parent = v27.page})
    local u48 = UI_upv_1.new("Frame", {Name = "TitleHolder", Size = UDim2.new(1, -220, 1, 0), Parent = canManage})
    local u49 = UI_upv_1.new("Frame", {Name = "InviteSlot", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 0), Size = fromOffset_upv_1(200, 40), Parent = canManage})
    local tbl_51 = {{"PLAYER", 0}, {"GLORY", -300}, {"STATUS", -190}}
    local v185 = UI_upv_1.new("Frame", {Name = "Cols", Position = fromOffset_upv_1(0, 48), Size = UDim2.new(1, -14, 0, 16), Parent = v27.page})
    local v186 = nil
    local v465 = nil
    for v466, value_21 in tbl_51 do
        local v187 = value_21[1]
        local tbl_52 = {Parent = 0, TextXAlignment = 0, Size = 0, Position = 0}
        if value_21[2] ~= 0 then
            v186 = UDim2.new(1, value_21[2], 0, 0)
        else
            v186 = fromOffset_upv_1(16, 0)
        end
        tbl_52.Position = v186
        tbl_52.Size = fromOffset_upv_1(110, 14)
        if value_21[2] ~= 0 then
            v186 = Enum.TextXAlignment.Center
        else
            v186 = Enum.TextXAlignment.Left
        end
        tbl_52.TextXAlignment = v186
        tbl_52.Parent = v185
        caps(v187, tbl_52)
    end
    local tbl_53 = {}
    tbl_53.Name = "List"
    tbl_53.Position = fromOffset_upv_1(0, 70)
    tbl_53.Size = UDim2.new(1, 0, 1, -70)
    tbl_53.ScrollBarThickness = 3
    tbl_53.Selectable = false
    tbl_53[1], tbl_53[2] = UI_upv_1.List(Enum.FillDirection.Vertical, 6), UI_upv_1.Padding(4, 10, 10, 4)
    tbl_53.Parent = v27.page
    local u50 = UI_upv_1.new("ScrollingFrame", tbl_53)
    canManage = function(a84, a85)
        --[[
          name: canManage
          line: 1311
        ]]
        local v188
        if a84 ~= "chief" then
            v188 = (a84 == "elder") and (a85 == "member")
        else
            v188 = true
            if a85 == "chief" then
                v188 = (a84 == "elder") and (a85 == "member")
            end
        end
        return v188
    end
    local tbl_upv_54 = {}
    tbl_upv_54.hub = {"IN LOBBY", Colors_upv_1.Success}
    tbl_upv_54.match = {"IN MATCH", Colors_upv_1.Warning}
    tbl_upv_54.custom = {"CUSTOM MATCH", Colors_upv_1.Warning}
    local function manage(a86, a87)
        --[[
          name: manage
          line: 1315
          upvalues:
            roleIn (copy, index: 1)
            act (copy, index: 2)
            openDialog (copy, index: 3)
            TribeEmblem_upv_1 (copy, index: 4)
        ]]
        local tbl_55 = {}
        if roleIn(a87) == "chief" then
            if a86.role == "member" then
                local tbl_56 = {text = "PROMOTE TO ELDER", style = "Primary"}
                function tbl_56.fn()
                    --[[
                      name: fn
                      line: 1320
                      upvalues:
                        act (copy, index: 1)
                        a86 (copy, index: 2)
                    ]]
                    act("Role", a86.userId, "elder")
                end
                table.insert(tbl_55, tbl_56)
            elseif a86.role == "elder" then
                local tbl_57 = {text = "DEMOTE TO MEMBER"}
                function tbl_57.fn()
                    --[[
                      name: fn
                      line: 1324
                      upvalues:
                        act (copy, index: 1)
                        a86 (copy, index: 2)
                    ]]
                    act("Role", a86.userId, "member")
                end
                table.insert(tbl_55, tbl_57)
            end
            local tbl_58 = {text = "MAKE CHIEF"}
            function tbl_58.fn()
                --[[
                  name: fn
                  line: 1328
                  upvalues:
                    openDialog (copy, index: 1)
                    a86 (copy, index: 2)
                    act (copy, index: 3)
                ]]
                local v189 = ("Make %* the Chief?"):format(a86.display)
                local tbl_59 = {text = "MAKE CHIEF", style = "Primary"}
                function tbl_59.fn()
                    --[[
                      name: fn
                      line: 1330
                      upvalues:
                        act (copy, index: 1)
                        a86 (copy, index: 2)
                    ]]
                    act("Role", a86.userId, "chief")
                end
                openDialog(v189, "You'll become an Elder. Only the Chief can change ranks and edit the tribe.", {tbl_59, {text = "CANCEL"}})
            end
            table.insert(tbl_55, tbl_58)
        end
        local tbl_60 = {text = "REMOVE FROM TRIBE", style = "Danger"}
        function tbl_60.fn()
            --[[
              name: fn
              line: 1337
              upvalues:
                openDialog (copy, index: 1)
                a86 (copy, index: 2)
                a87 (copy, index: 3)
                TribeEmblem_upv_1 (copy, index: 4)
                act (copy, index: 5)
            ]]
            local v190 = ("Remove %*?"):format(a86.display)
            local v191 = "They'll leave %*. They can be invited again."
            local Tag_11 = TribeEmblem_upv_1.Tag
            local v192
            if type(a87) ~= "table" then
                v192 = a87
            else
                v192 = a87.tag
            end
            local v193 = v191:format(Tag_11(v192))
            local tbl_61 = {text = "REMOVE", style = "Danger"}
            function tbl_61.fn()
                --[[
                  name: fn
                  line: 1339
                  upvalues:
                    act (copy, index: 1)
                    a86 (copy, index: 2)
                ]]
                act("Kick", a86.userId)
            end
            openDialog(v190, v193, {tbl_61, {text = "CANCEL"}})
        end
        table.insert(tbl_55, tbl_60)
        table.insert(tbl_55, {text = "CANCEL"})
        openDialog(tostring(a86.display), ("@%*  \194\183  Level %*"):format(a86.name, a86.level), tbl_55)
    end
    local function memberRow(a88, a89, a90)
        --[[
          name: memberRow
          line: 1354
          upvalues:
            roleIn (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            tbl_upv_1 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            u50 (copy, index: 6)
            fromOffset_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            tbl_upv_54 (copy, index: 9)
            label (copy, index: 10)
            a1 (copy, index: 11)
            Fonts_upv_1 (copy, index: 12)
            tbl_upv_2 (copy, index: 13)
            u1 (copy, index: 14)
            Tribes_upv_1 (copy, index: 15)
            u3 (copy, index: 16)
            ago (copy, index: 17)
            Players_upv_1 (copy, index: 18)
            u10 (ref,  index: 19)
            openDialog (copy, index: 20)
            act (copy, index: 21)
            MenuManager_upv_1 (copy, index: 22)
            manage (copy, index: 23)
        ]]
        local v194 = roleIn(a89)
        local v195 = a88.userId == LocalPlayer_upv_1.UserId
        local new_9 = UI_upv_1.new
        local tbl_62 = {}
        tbl_62.Name = "M" .. tostring(a88.userId)
        tbl_62.Size = UDim2.new(1, -4, 0, tbl_upv_1.row)
        tbl_62.LayoutOrder = a90
        local v196
        if v195 then
            v196 = Colors_upv_1.AccentDeep
        else
            v196 = Colors_upv_1.PanelHi
        end
        tbl_62.BackgroundColor3 = v196
        tbl_62.BackgroundTransparency = (v195 and 0.45) or (((a90 % 2 ~= 0) and 0.35) or 0.55)
        tbl_62[1] = UI_upv_1.Corner(12)
        tbl_62.Parent = u50
        local v197 = new_9("Frame", tbl_62)
        if v195 then
            UI_upv_1.Stroke(Colors_upv_1.Accent, 1, 0.45).Parent = v197
        end
        local v198 = tbl_upv_1.row - 18
        local v199 = UI_upv_1.new("ImageLabel", {Name = "Head", Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a88.userId), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = fromOffset_upv_1(v198, v198), BackgroundColor3 = Colors_upv_1.Raised, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v197})
        local v200 = (a88.where ~= false) and (a88.where ~= nil)
        if v200 then
            local new_10 = UI_upv_1.new
            local tbl_63 = {}
            tbl_63.Name = "Dot"
            tbl_63.AnchorPoint = Vector2.new(1, 1)
            tbl_63.Position = UDim2.fromScale(1.02, 1.02)
            tbl_63.Size = fromOffset_upv_1(13, 13)
            tbl_63.BackgroundColor3 = (tbl_upv_54[a88.where] or (tbl_upv_54.hub))[2]
            tbl_63[1], tbl_63[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Panel, 2, 0)
            tbl_63.Parent = v199
            new_10("Frame", tbl_63)
        else
            v199.ImageTransparency = 0.35
        end
        local v201 = v198 + 26
        local v202 = UI_upv_1.new("Frame", {Name = "NameRow", Position = fromOffset_upv_1(v201, (math.floor(tbl_upv_1.row / 2) - tbl_upv_1.text) - 2), Size = UDim2.new(1, -(v201 + 420), 0, tbl_upv_1.text + 4), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v197})
        local tbl_64 = {LayoutOrder = 1, FontFace = 0, Name = "Name", AutomaticSize = 0, Parent = 0, Text = 0, TextSize = 0, Size = 0}
        local str_2 = tostring(a88.display)
        local v203 = (v195 and ("  " .. a1.Loc.T("(you)"))) or ""
        tbl_64.Text = str_2 .. v203
        tbl_64.FontFace = Fonts_upv_1.Heavy
        tbl_64.TextSize = tbl_upv_1.text
        tbl_64.AutomaticSize = Enum.AutomaticSize.X
        tbl_64.Size = fromOffset_upv_1(0, tbl_upv_1.text + 4)
        tbl_64.Parent = v202
        label(tbl_64)
        local v204 = tbl_upv_2[a88.role]
        if v204 then
            UI_upv_1.Pill(v204.text, v204.color, {LayoutOrder = 2, TextSize = 11, Height = 20, Parent = v202})
        end
        label({Name = "Sub", Text = ("@%*  \194\183  Lv %*"):format(a88.name, a88.level), FontFace = Fonts_upv_1.SemiBold, TextSize = tbl_upv_1.sub, TextColor3 = u1, Position = fromOffset_upv_1(v201, math.floor(tbl_upv_1.row / 2) + 3), Size = UDim2.new(1, -(v201 + 420), 0, tbl_upv_1.sub + 2), Parent = v197})
        local v205 = tonumber(a88.weekRenown) or 0
        local tbl_65 = {TextColor3 = 0, Parent = 0, AnchorPoint = 0, Name = "Renown", TextXAlignment = 0, Position = 0, TextSize = 20, Size = 0}
        tbl_65.Text = tostring(v205)
        tbl_65.FontFace = Fonts_upv_1.Display
        local v206
        if Tribes_upv_1.CHEST_MIN <= v205 then
            v206 = u3
        else
            v206 = Colors_upv_1.TextDim
        end
        tbl_65.TextColor3 = v206
        tbl_65.TextXAlignment = Enum.TextXAlignment.Center
        tbl_65.AnchorPoint = Vector2.new(0, 0.5)
        tbl_65.Position = UDim2.new(1, -300, 0.5, 0)
        tbl_65.Size = fromOffset_upv_1(110, 24)
        tbl_65.Parent = v197
        label(tbl_65)
        if v200 then
            v205 = tbl_upv_54[a88.where] or (tbl_upv_54.hub)
        else
            local tbl_66 = {}
            local v207 = ((not ((tonumber(a88.lastSeen) or 0) > 0)) and "OFFLINE") or (string.upper(ago(a88.lastSeen)))
            tbl_66[1], tbl_66[2] = v207, Colors_upv_1.TextMuted
            v205 = tbl_66
        end
        local Pill_2 = UI_upv_1.Pill
        local v208 = v205[1]
        local v209 = v205[2]
        local tbl_67 = {Transparency = 0, Height = 22, Parent = 0, TextSize = 11, TextColor = 0}
        tbl_67.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_67.Position = UDim2.new(1, -135, 0.5, 0)
        tbl_67.Transparency = (v200 and 0.15) or 0.75
        local v210
        if v200 then
            v210 = Colors_upv_1.TextDark
        else
            v210 = Colors_upv_1.TextDim
        end
        tbl_67.TextColor = v210
        tbl_67.Parent = v197
        Pill_2(v208, v209, tbl_67).Name = "Status"
        local v211 = UI_upv_1.new("Frame", {Name = "Actions", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = fromOffset_upv_1(78, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v197})
        if not (v195) then
            if Players_upv_1:GetPlayerByUserId(a88.userId) then
                v201 = UI_upv_1.IconButton({LayoutOrder = 1, Name = "Invite", Size = fromOffset_upv_1(38, 38), Color = Colors_upv_1.Accent, Parent = v211})
                UI_upv_1.Glyph("person-plus", 18, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v201})
                v201.Activated:Connect(
                    function()
                        --[[
                          line: 1418
                          upvalues:
                            u10 (ref,  index: 1)
                            a1 (copy, index: 2)
                            a88 (copy, index: 3)
                        ]]
                        local v212 = os.clock() - u10 >= 0.5
                        if not v212 then
                            return
                        end
                        local v213, v214, v215 = a1.Remotes.Invoke("PartyAction", "Invite", a88.userId)
                        if v213 and v214 == true then
                            a1.Toast(("Party invite sent to %*"):format(a88.display), "success")
                            return
                        end
                        local Toast_5 = a1.Toast
                        local v216
                        if v213 then
                            v216 = v215 or "Couldn't invite them"
                        else
                            v216 = v214
                        end
                        Toast_5(tostring(v216), "error")
                    end
                )
            elseif a88.where == "hub" and a88.jobId and a88.jobId ~= game.JobId then
                local v217 = UI_upv_1.IconButton({LayoutOrder = 1, Name = "Join", Size = fromOffset_upv_1(38, 38), Color = Colors_upv_1.Accent, Parent = v211})
                UI_upv_1.Glyph("person-teleport", 18, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v217})
                v217.Activated:Connect(
                    function()
                        --[[
                          line: 1432
                          upvalues:
                            u10 (ref,  index: 1)
                            openDialog (copy, index: 2)
                            a88 (copy, index: 3)
                            act (copy, index: 4)
                            a1 (copy, index: 5)
                            MenuManager_upv_1 (copy, index: 6)
                        ]]
                        local v218 = os.clock() - u10 >= 0.5
                        if not v218 then
                            return
                        end
                        local v219 = ("Join %*?"):format(a88.display)
                        local tbl_68 = {text = "JOIN THEIR LOBBY", style = "Primary"}
                        function tbl_68.fn()
                            --[[
                              name: fn
                              line: 1437
                              upvalues:
                                act (copy, index: 1)
                                a88 (copy, index: 2)
                                a1 (copy, index: 3)
                                MenuManager_upv_1 (copy, index: 4)
                            ]]
                            if not act("Visit", a88.userId) then
                                return
                            end
                            a1.Toast(("Joining %*'s lobby..."):format(a88.display), "info")
                            MenuManager_upv_1.Close("Tribe")
                        end
                        openDialog(v219, "You'll move to their lobby.", {tbl_68, {text = "CANCEL"}})
                    end
                )
            end
            local role_1 = a88.role
            local v220
            if v194 ~= "chief" then
                v220 = (v194 == "elder") and (role_1 == "member")
            else
                v220 = true
                if role_1 == "chief" then
                    v220 = (v194 == "elder") and (role_1 == "member")
                end
            end
            if v220 then
                local v221 = UI_upv_1.IconButton({LayoutOrder = 2, Name = "Manage", Size = fromOffset_upv_1(38, 38), Color = Colors_upv_1.Raised, Parent = v211})
                UI_upv_1.Glyph("three-dots-horizontal", 18, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v221})
                v221.Activated:Connect(
                    function()
                        --[[
                          line: 1450
                          upvalues:
                            u10 (ref,  index: 1)
                            manage (copy, index: 2)
                            a88 (copy, index: 3)
                            a89 (copy, index: 4)
                        ]]
                        local v222 = os.clock() - u10 >= 0.5
                        if not v222 then
                            return
                        end
                        manage(a88, a89)
                    end
                )
            end
        end
        return v197
    end
    local function invitePicker()
        --[[
          name: invitePicker
          line: 1460
          upvalues:
            openDialog (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u6 (ref,  index: 3)
            roleIn (copy, index: 4)
            Tribes_upv_2 (copy, index: 5)
            Players_upv_1 (copy, index: 6)
            LocalPlayer_upv_1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            fromOffset_upv_1 (copy, index: 9)
            Theme_upv_1 (copy, index: 10)
            label (copy, index: 11)
            Fonts_upv_1 (copy, index: 12)
            smallButton (copy, index: 13)
            act (copy, index: 14)
            u1 (copy, index: 15)
        ]]
        openDialog(
            "Invite players",
            "Players in this lobby who aren't in a tribe. Invites last 24 hours.",
            {{text = "DONE"}},
            function(a91)
                --[[
                  line: 1461
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u6 (ref,  index: 2)
                    roleIn (copy, index: 3)
                    Tribes_upv_2 (copy, index: 4)
                    Players_upv_1 (copy, index: 5)
                    LocalPlayer_upv_1 (copy, index: 6)
                    Colors_upv_1 (copy, index: 7)
                    fromOffset_upv_1 (copy, index: 8)
                    Theme_upv_1 (copy, index: 9)
                    label (copy, index: 10)
                    Fonts_upv_1 (copy, index: 11)
                    smallButton (copy, index: 12)
                    act (copy, index: 13)
                    u1 (copy, index: 14)
                ]]
                UI_upv_1.List(Enum.FillDirection.Vertical, 6).Parent = a91
                local v223 = 0
                local v224 = u6 and (u6.tribe)
                local v225
                if type(v224) ~= "table" then
                    v225 = Tribes_upv_2.Mine()
                else
                    v225 = {}
                    v225.id = v224.id
                    v225.role = roleIn(v224)
                end
                local tbl_69 = {}
                local v226
                if (v225) and type(v225.invites) == "table" then
                    v226 = v225.invites
                else
                    v226 = {}
                end
                for _, value_22 in v226 do
                    if type(value_22) ~= "table" then
                        continue
                    end
                    if type(value_22.userId) == "number" then
                        tbl_69[value_22.userId] = true
                    end
                end
                for _, value_upv_23 in Players_upv_1:GetPlayers() do
                    local v227 = value_upv_23:GetAttribute("TribeId")
                    if value_upv_23 == LocalPlayer_upv_1 then
                        continue
                    end
                    if type(v227) ~= "number" or v227 == 0 then
                        v223 = v223 + 1
                        local v228 = UI_upv_1.new("Frame", {Name = value_upv_23.Name, Size = UDim2.new(1, 0, 0, 46), LayoutOrder = v223, ZIndex = 22, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(10), Parent = a91})
                        UI_upv_1.new("ImageLabel", {Name = "Head", Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(value_upv_23.UserId), Position = fromOffset_upv_1(6, 5), Size = fromOffset_upv_1(36, 36), BackgroundColor3 = Colors_upv_1.Raised, ZIndex = 22, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v228})
                        label({ZIndex = 22, Name = "Name", TextSize = 16, Text = value_upv_23.DisplayName, FontFace = Fonts_upv_1.Heavy, Position = fromOffset_upv_1(52, 0), Size = UDim2.new(1, -160, 1, 0), Parent = v228})
                        local u51 = nil
                        local v229 = smallButton(
                            "INVITE",
                            "Primary",
                            v228,
                            function()
                                --[[
                                  line: 1479
                                  upvalues:
                                    act (copy, index: 1)
                                    value_upv_23 (copy, index: 2)
                                    u51 (ref,  index: 3)
                                ]]
                                if not act("Invite", value_upv_23.UserId) then
                                    return
                                end
                                u51:SetText("SENT")
                                u51:SetEnabled(false)
                            end,
                            {Height = 36, TextSize = 15, Width = 96, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -6, 0.5, 0)}
                        )
                        u51 = v229
                        u51.Instance.ZIndex = 23
                        if tbl_69[value_upv_23.UserId] then
                            u51:SetText("SENT")
                            u51:SetEnabled(false)
                        end
                    end
                end
                if v223 ~= 0 then
                    return
                end
                label({ZIndex = 22, Name = "None", Text = "Nobody to invite here right now.", TextSize = 15, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Size = UDim2.new(1, 0, 0, 30), Parent = a91})
            end
        )
    end
    local tbl_upv_70 = {}
    local function lookupName(a92, a93)
        --[[
          name: lookupName
          line: 1500
          upvalues:
            tbl_upv_70 (copy, index: 1)
        ]]
        if tbl_upv_70[a92] then
            a93(tbl_upv_70[a92])
        else
            task.spawn(function() end)
        end
    end
    local function pendingRow(a94, a95)
        --[[
          name: pendingRow
          line: 1515
          upvalues:
            UI_upv_1 (copy, index: 1)
            tbl_upv_1 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            u50 (copy, index: 4)
            fromOffset_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            label (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            ago (copy, index: 9)
            u1 (copy, index: 10)
            tbl_upv_70 (copy, index: 11)
            Players_upv_1 (copy, index: 12)
            smallButton (copy, index: 13)
            act (copy, index: 14)
            a1 (copy, index: 15)
        ]]
        local u52 = tonumber(a94.userId) or 0
        local v230 = UI_upv_1.new("Frame", {Name = "I" .. tostring(u52), Size = UDim2.new(1, -4, 0, tbl_upv_1.row), LayoutOrder = a95, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.55, [1] = UI_upv_1.Corner(12), Parent = u50})
        UI_upv_1.new("ImageLabel", {Name = "Head", Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(u52), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = fromOffset_upv_1(tbl_upv_1.row - 18, tbl_upv_1.row - 18), BackgroundColor3 = Colors_upv_1.Raised, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v230})
        local v231 = tbl_upv_1.row + 8
        local v232
        if type(a94.display) ~= "string" or a94.display == "" then
            v232 = nil
        else
            v232 = a94.display
        end
        local v233
        if type(a94.name) ~= "string" or a94.name == "" then
            v233 = nil
        else
            v233 = a94.name
        end
        local tbl_71 = {FontFace = 0, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 0, Size = 0}
        tbl_71.Text = v232 or (v233 or "Player")
        tbl_71.FontFace = Fonts_upv_1.Heavy
        tbl_71.TextSize = tbl_upv_1.text
        tbl_71.Position = fromOffset_upv_1(v231, (math.floor(tbl_upv_1.row / 2) - tbl_upv_1.text) - 2)
        tbl_71.Size = UDim2.new(1, -(v231 + 150), 0, tbl_upv_1.text + 4)
        tbl_71.Parent = v230
        local u53 = label(tbl_71)
        local v234 = math.max(0, (tonumber(a94.expiresAt) or 0) - os.time())
        local u54
        if v234 >= 3600 then
            u54 = ("%*h"):format(v234 // 3600)
        else
            u54 = ("%*m"):format(math.max(1, v234 // 60))
        end
        local v235
        if v233 then
            if v232 ~= nil and string.lower(v233) == string.lower(v232) then
                v235 = nil
            else
                v235 = v233
            end
        else
            v235 = nil
        end
        local tbl_72 = {Position = 0, FontFace = 0, Name = "Sub", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 0, Size = 0}
        local v236
        if v235 then
            v236 = ("@%*  \194\183  "):format(v235)
        else
            v236 = ""
        end
        tbl_72.Text = ("%*invited by %* %*  \194\183  expires in %*"):format(v236, tostring(a94.from or "?"), ago(a94.at), u54)
        tbl_72.FontFace = Fonts_upv_1.SemiBold
        local function sub_1(a96)
            --[[
              name: sub
              line: 1525
              upvalues:
                a94 (copy, index: 1)
                ago (copy, index: 2)
                u54 (copy, index: 3)
            ]]
            local v237 = ((not a96) and "") or (("@%*  \194\183  "):format(a96))
            return (("%*invited by %* %*  \194\183  expires in %*"):format(v237, tostring(a94.from or "?"), ago(a94.at), u54))
        end
        tbl_72.TextSize = tbl_upv_1.sub
        tbl_72.TextColor3 = u1
        tbl_72.Position = fromOffset_upv_1(v231, math.floor(tbl_upv_1.row / 2) + 3)
        tbl_72.Size = UDim2.new(1, -(v231 + 150), 0, tbl_upv_1.sub + 2)
        tbl_72.Parent = v230
        label(tbl_72)
        if not (v232) and not (v233) and u52 > 0 then
            local u55 = function(a97)
                --[[
                  line: 1533
                  upvalues:
                    u53 (copy, index: 1)
                ]]
                if not u53.Parent then
                    return
                end
                u53.Text = a97
            end
            if tbl_upv_70[u52] then
                local v238 = tbl_upv_70[u52]
                if u53.Parent then
                    u53.Text = v238
                end
            else
                task.spawn(
                    function()
                        --[[
                          line: 1505
                          upvalues:
                            Players_upv_1 (copy, index: 1)
                            u52 (copy, index: 2)
                            tbl_upv_70 (copy, index: 3)
                            u55 (copy, index: 4)
                        ]]
                        local success_5, v239 = pcall(
                            function()
                                --[[
                                  line: 1506
                                  upvalues:
                                    Players_upv_1 (copy, index: 1)
                                    u52 (copy, index: 2)
                                ]]
                                return Players_upv_1:GetNameFromUserIdAsync(u52)
                            end
                        )
                        if not success_5 or type(v239) ~= "string" then
                            return
                        end
                        tbl_upv_70[u52] = v239
                        u55(v239)
                    end
                )
            end
        end
        smallButton(
            "CANCEL",
            "Dark",
            UI_upv_1.new("Frame", {Name = "Actions", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = fromOffset_upv_1(130, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v230}),
            function()
                --[[
                  line: 1540
                  upvalues:
                    act (copy, index: 1)
                    u52 (copy, index: 2)
                    a1 (copy, index: 3)
                    u53 (copy, index: 4)
                ]]
                if not act("Uninvite", u52) then
                    return
                end
                a1.Toast(("Invite to %* withdrawn"):format(u53.Text), "info")
            end,
            {TextSize = 15, Width = 110}
        )
    end
    local function renderMembers(a98)
        --[[
          name: renderMembers
          line: 1547
          upvalues:
            clear (copy, index: 1)
            u50 (copy, index: 2)
            u49 (copy, index: 3)
            u48 (copy, index: 4)
            section (copy, index: 5)
            Tribes_upv_1 (copy, index: 6)
            fromOffset_upv_1 (copy, index: 7)
            roleIn (copy, index: 8)
            smallButton (copy, index: 9)
            invitePicker (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            Colors_upv_1 (copy, index: 12)
            tbl_upv_1 (ref,  index: 13)
            Theme_upv_1 (copy, index: 14)
            label (copy, index: 15)
            Fonts_upv_1 (copy, index: 16)
            ago (copy, index: 17)
            u1 (copy, index: 18)
            act (copy, index: 19)
            memberRow (copy, index: 20)
            pendingRow (copy, index: 21)
        ]]
        clear(u50)
        clear(u49)
        clear(u48)
        local v240 = ((type(a98.membersList) ~= "table") and {}) or (a98.membersList)
        local v241 = 0
        for _, value_24 in v240 do
            v241 = ((value_24.where) and (v241 + 1)) or v241
        end
        local v242 = section("MEMBERS", ("%*/%*"):format(#v240, Tribes_upv_1.MAX_MEMBERS), ("%* online"):format(v241), 1, u48)
        v242.Position = fromOffset_upv_1(0, 9)
        v241 = roleIn(a98)
        local v243 = true
        if v241 == "chief" then
            v242 = v243
        else
            v242 = v241 == "elder"
        end
        if v242 then
            smallButton(
                "INVITE PLAYERS",
                "Primary",
                u49,
                function()
                    --[[
                      line: 1562
                      upvalues:
                        invitePicker (copy, index: 1)
                    ]]
                    invitePicker()
                end,
                {TextSize = 15, Size = UDim2.fromScale(1, 1), Icon = UI_upv_1.Glyph("person-plus", 18, Colors_upv_1.Text)}
            )
        end
        local v244 = 0
        local v245 = ((type(a98.requests) ~= "table") and {}) or (a98.requests)
        if v242 and #v245 > 0 then
            local v246 = v244 + 1
            section("JOIN REQUESTS", #v245, nil, v246, u50, Colors_upv_1.Warning)
            v241 = v246
            for _, value_upv_25 in v245 do
                local v247 = v241 + 1
                local tbl_73 = {}
                tbl_73.Name = "R" .. tostring(value_upv_25.userId)
                tbl_73.Size = UDim2.new(1, -4, 0, tbl_upv_1.row)
                tbl_73.LayoutOrder = v247
                tbl_73.BackgroundColor3 = Color3.fromRGB(60, 46, 20)
                tbl_73.BackgroundTransparency = 0.35
                tbl_73[1], tbl_73[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Warning, 1, 0.6)
                tbl_73.Parent = u50
                local v248 = UI_upv_1.new("Frame", tbl_73)
                UI_upv_1.new("ImageLabel", {Name = "Head", Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(value_upv_25.userId), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = fromOffset_upv_1(tbl_upv_1.row - 18, tbl_upv_1.row - 18), BackgroundColor3 = Colors_upv_1.Raised, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v248})
                local v249 = tbl_upv_1.row + 8
                label({Name = "Name", Text = tostring(value_upv_25.display), FontFace = Fonts_upv_1.Heavy, TextSize = tbl_upv_1.text, Position = fromOffset_upv_1(v249, (math.floor(tbl_upv_1.row / 2) - tbl_upv_1.text) - 2), Size = UDim2.new(1, -(v249 + 260), 0, tbl_upv_1.text + 4), Parent = v248})
                label({Name = "Sub", Text = ("@%*  \194\183  Lv %*  \194\183  asked %*"):format(value_upv_25.name, value_upv_25.level, ago(value_upv_25.at)), FontFace = Fonts_upv_1.SemiBold, TextSize = tbl_upv_1.sub, TextColor3 = u1, Position = fromOffset_upv_1(v249, math.floor(tbl_upv_1.row / 2) + 3), Size = UDim2.new(1, -(v249 + 260), 0, tbl_upv_1.sub + 2), Parent = v248})
                local v250 = UI_upv_1.new("Frame", {Name = "Actions", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = fromOffset_upv_1(240, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v248})
                smallButton(
                    "ACCEPT",
                    "Success",
                    v250,
                    function()
                        --[[
                          line: 1579
                          upvalues:
                            act (copy, index: 1)
                            value_upv_25 (copy, index: 2)
                        ]]
                        act("Respond", value_upv_25.userId, true)
                    end,
                    {LayoutOrder = 1, TextSize = 15, Width = 110}
                )
                smallButton(
                    "DECLINE",
                    "Dark",
                    v250,
                    function()
                        --[[
                          line: 1582
                          upvalues:
                            act (copy, index: 1)
                            value_upv_25 (copy, index: 2)
                        ]]
                        act("Respond", value_upv_25.userId, false)
                    end,
                    {LayoutOrder = 2, TextSize = 15, Width = 110}
                )
                v241 = v247
            end
            local v251 = v241 + 1
            section("MEMBERS", nil, nil, v251, u50)
            v244 = v251
        end
        local v252 = table.clone(v240)
        local tbl_upv_74 = {chief = 0, member = 2, elder = 1}
        table.sort(
            v252,
            function(a99, a100)
                --[[
                  line: 1592
                  upvalues:
                    tbl_upv_74 (copy, index: 1)
                ]]
                local v253 = ((a99.where) and 0) or 1
                local v254 = ((a100.where) and 0) or 1
                if v253 ~= v254 then
                    return v253 < v254
                end
                if (tbl_upv_74[a99.role] or 3) ~= (tbl_upv_74[a100.role] or 3) then
                    return (tbl_upv_74[a99.role] or 3) < (tbl_upv_74[a100.role] or 3)
                end
                local v255 = tonumber(a99.weekRenown) or 0
                local v256 = (tonumber(a100.weekRenown) or 0) < v255
                return v256
            end
        )
        v241 = v244
        for key_16, value_26 in v252 do
            local v257 = v241 + 1
            UI_upv_1.Enter(memberRow(value_26, a98, v257), Vector2.new(0, 8), math.min(key_16 * 0.025, 0.25), UDim2.new())
            v241 = v257
        end
        local v258 = ((type(a98.invites) ~= "table") and {}) or (a98.invites)
        if not v242 then
            return
        end
        if #v258 > 0 then
            local v259 = v241 + 1
            section("PENDING INVITES", ("%*/%*"):format(#v258, tonumber(a98.inviteMax) or 50), "expire after 24 h", v259, u50, Colors_upv_1.Accent)
            v241 = v259
            for _, value_27 in v258 do
                local v260 = v241 + 1
                pendingRow(value_27, v260)
                v241 = v260
            end
        end
    end
    local v261 = UI_upv_1.new("Frame", {Name = "Top", Size = UDim2.new(1, 0, 0, 46), Parent = v28.page})
    local tbl_75 = {}
    tbl_75.Name = "Period"
    tbl_75.Size = fromOffset_upv_1(280, 46)
    tbl_75.BackgroundColor3 = u2
    tbl_75.BackgroundTransparency = 0.25
    tbl_75[1], tbl_75[2], tbl_75[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(4, 4, 4, 4), UI_upv_1.List(Enum.FillDirection.Horizontal, 4)
    tbl_75.Parent = v261
    local v262 = UI_upv_1.new("Frame", tbl_75)
    local u56 = "top"
    local tbl_upv_76 = {}
    for key_17, value_28 in {{"top", "THIS WEEK"}, {"alltime", "ALL TIME"}} do
        tbl_upv_76[value_28[1]] = UI_upv_1.new("TextButton", {Name = value_28[1], Text = value_28[2], AutoButtonColor = false, FontFace = Fonts_upv_1.Heavy, TextSize = 14, TextColor3 = Colors_upv_1.TextDim, Size = UDim2.new(0.5, -2, 1, 0), LayoutOrder = key_17, BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v262})
    end
    local u57 = label({RichText = true, Text = "", Name = "Note", TextSize = 15, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(1, -300, 0, 20), Parent = v261})
    local tbl_upv_77 = {}
    tbl_upv_77.Name = "List"
    tbl_upv_77.Position = fromOffset_upv_1(0, 58)
    tbl_upv_77.Size = UDim2.new(1, 0, 1, -58)
    tbl_upv_77.ScrollBarThickness = 3
    tbl_upv_77.Selectable = false
    tbl_upv_77[1], tbl_upv_77[2] = UI_upv_1.List(Enum.FillDirection.Vertical, 8), UI_upv_1.Padding(4, 10, 10, 4)
    tbl_upv_77.Parent = v28.page
    local u58 = UI_upv_1.new("ScrollingFrame", tbl_upv_77)
    local u59 = UI_upv_1.new("Frame", {Name = "Pinned", Visible = false, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, tbl_upv_1.row + 22), Parent = v28.page})
    local u60 = UI_upv_1.new("Frame", {Visible = false, Name = "Empty", Position = fromOffset_upv_1(0, 120), Size = UDim2.new(1, 0, 0, 120), Parent = v28.page})
    UI_upv_1.Glyph("trophy", 48, Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Parent = u60})
    local u61 = label({Text = "", Name = "Text", TextSize = 17, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Center, Position = fromOffset_upv_1(0, 60), Size = UDim2.new(1, 0, 0, 24), Parent = u60})
    tbl_upv_77 = {u3, Color3.fromRGB(196, 206, 222), Color3.fromRGB(222, 140, 74)}
    local function boardValue(a101)
        --[[
          name: boardValue
          line: 1684
          upvalues:
            u56 (ref, index: 1)
        ]]
        local v263
        if u56 ~= "alltime" then
            v263 = a101.weekRenown
        else
            v263 = a101.renown
        end
        return tonumber(v263) or 0
    end
    local function boardRow(a102, a103, a104, a105, a106)
        --[[
          name: boardRow
          line: 1688
          upvalues:
            tbl_upv_1 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Tribes_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            openable (copy, index: 5)
            tbl_upv_77 (copy, index: 6)
            fromOffset_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            label (copy, index: 9)
            Fonts_upv_1 (copy, index: 10)
            TribeEmblem_upv_1 (copy, index: 11)
            u1 (copy, index: 12)
            rowStat (copy, index: 13)
            u56 (ref,  index: 14)
            u3 (copy, index: 15)
        ]]
        local v264 = tbl_upv_1.row + 8
        local v265 = UI_upv_1.new("TextButton", {Name = "R" .. tostring(a103 or 0), Text = "", AutoButtonColor = false, Size = UDim2.new(1, -4, 0, v264), LayoutOrder = a105, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.1, ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = a104})
        UI_upv_1.Gradient(Tribes_upv_1.Color(a102.color1):Lerp(Colors_upv_1.Panel, 0.8), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.55), 0).Parent = v265
        local v266
        if a106 then
            v266 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)
        else
            v266 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        end
        v266.Parent = v265
        openable(v265, v266, a102)
        local v267 = a103
        v266 = v267 and (tbl_upv_77[a103])
        local v268 = ((UI_upv_1.Compact) and 46) or 56
        local new_11 = UI_upv_1.new
        local tbl_78 = {}
        tbl_78.Name = "Rank"
        tbl_78.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_78.Position = UDim2.new(0, (v268 / 2) + 10, 0.5, 0)
        tbl_78.Size = fromOffset_upv_1(v268 - 6, v268 - 6)
        tbl_78.BackgroundColor3 = a103 or (Colors_upv_1.Inset)
        tbl_78.BackgroundTransparency = (v266 and 0.78) or 1
        tbl_78[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_78.Parent = v265
        local v269 = new_11("Frame", tbl_78)
        local tbl_79 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, Name = "Text", TextXAlignment = 0, TextTruncate = 0, TextSize = 0, Size = 0}
        tbl_79.Text = not a103 and "-" or tostring(a103)
        tbl_79.FontFace = Fonts_upv_1.Display
        local v271
        if (a103) and (a103 >= 100) then
            v271 = tbl_upv_1.text
        else
            v271 = tbl_upv_1.text + 6
        end
        tbl_79.TextSize = v271
        tbl_79.TextColor3 = a103 or (Colors_upv_1.TextDim)
        tbl_79.TextXAlignment = Enum.TextXAlignment.Center
        tbl_79.TextTruncate = Enum.TextTruncate.None
        tbl_79.Size = UDim2.fromScale(1, 1)
        tbl_79.Parent = v269
        label(tbl_79)
        local v272 = v268 + 14
        local v273 = tbl_upv_1.row - 6
        local tbl_80 = {}
        tbl_80.AnchorPoint = Vector2.new(0, 0.5)
        tbl_80.Position = UDim2.new(0, v272, 0.5, 0)
        tbl_80.Parent = v265
        TribeEmblem_upv_1.new(v273, tbl_80):Set(a102.icon, a102.color1, a102.color2, a102.tag)
        local v274 = v272 + tbl_upv_1.row + 8
        v269 = ((UI_upv_1.Compact) and 96) or 260
        local tbl_81 = {FontFace = 0, RichText = true, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 0, Size = 0}
        local v275 = TribeEmblem_upv_1.TagColor(a102.color1):ToHex()
        local Tag_12 = TribeEmblem_upv_1.Tag
        local v276
        if type(a102) ~= "table" then
            v276 = a102
        else
            v276 = a102.tag
        end
        tbl_81.Text = string.format("<font color=\"#%s\">%s</font>  %s", v275, Tag_12(v276), tostring(a102.name or ""))
        tbl_81.FontFace = Fonts_upv_1.Heavy
        tbl_81.TextSize = tbl_upv_1.text
        tbl_81.Position = fromOffset_upv_1(v274, (math.floor(v264 / 2) - tbl_upv_1.text) - 2)
        tbl_81.Size = UDim2.new(1, -((v274 + v269) + 12), 0, tbl_upv_1.text + 2)
        tbl_81.Parent = v265
        label(tbl_81)
        local v277 = tonumber(a102.members) or 0
        local v278 = tonumber(a102.held) or 0
        local v279 = ("%* %*"):format(v277, ((v277 ~= 1) and "members") or "member")
        if v278 > 0 and UI_upv_1.Compact then
            v279 = v279 .. ("  \194\183  holds %* %*"):format(v278, ((v278 ~= 1) and "maps") or "map")
        end
        v279 = (a106 and (("<font color=\"#%*\">Your tribe</font>  \194\183  "):format(Colors_upv_1.Accent:ToHex()) .. v279)) or v279
        label({RichText = true, Name = "Sub", Text = v279, FontFace = Fonts_upv_1.SemiBold, TextSize = tbl_upv_1.sub, TextColor3 = u1, Position = fromOffset_upv_1(v274, math.floor(v264 / 2) + 3), Size = UDim2.new(1, -((v274 + v269) + 12), 0, tbl_upv_1.sub + 2), Parent = v265})
        local v280 = UI_upv_1.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = fromOffset_upv_1(v269, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v265})
        local v282 = nil
        if not (UI_upv_1.Compact) then
            rowStat(v280, ("%*/%*"):format(v277, Tribes_upv_1.MAX_MEMBERS), "MEMBERS", 1)
            local str_3 = tostring(v278)
            if v278 > 0 then
                v282 = Colors_upv_1.Text
            else
                v282 = Colors_upv_1.TextDim
            end
            rowStat(v280, str_3, "MAPS HELD", 2, v282)
        end
        local FormatNumber_1 = UI_upv_1.FormatNumber
        if u56 ~= "alltime" then
            v282 = a102.weekRenown
        else
            v282 = a102.renown
        end
        rowStat(v280, FormatNumber_1(tonumber(v282) or 0), "GLORY", 3, u3)
        return v265
    end
    local function paintPeriod()
        --[[
          name: paintPeriod
          line: 1762
          upvalues:
            tbl_upv_76 (copy, index: 1)
            u56 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            u57 (copy, index: 4)
            untilText (copy, index: 5)
            Tribes_upv_1 (copy, index: 6)
        ]]
        local v283 = nil
        for key_18, value_29 in tbl_upv_76 do
            value_29.BackgroundTransparency = ((key_18 ~= u56) and 1) or 0
            if key_18 ~= u56 then
                v283 = Colors_upv_1.TextDim
            else
                v283 = Colors_upv_1.Text
            end
            value_29.TextColor3 = v283
        end
        if u56 ~= "top" then
            u57.Text = "Every match since tribes began"
        else
            u57.Text = ("Resets in <font color=\"#%*\">%*</font>"):format(Colors_upv_1.Text:ToHex(), untilText(Tribes_upv_1.WeekEndsAt(Tribes_upv_1.WeekOf(os.time()))))
        end
    end
    local u62 = 0
    local u63 = 0
    local u64 = nil
    local u65 = nil
    local u66 = nil
    local function drawPin(a107)
        --[[
          name: drawPin
          line: 1785
          upvalues:
            u56 (ref,  index: 1)
            HttpService_upv_1 (copy, index: 2)
            u66 (ref,  index: 3)
            clear (copy, index: 4)
            u59 (copy, index: 5)
            u58 (copy, index: 6)
            tbl_upv_1 (ref,  index: 7)
            UI_upv_1 (copy, index: 8)
            fromOffset_upv_1 (copy, index: 9)
            Colors_upv_1 (copy, index: 10)
            boardRow (copy, index: 11)
        ]]
        local v284, v285 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, a107 or false)
        local v286
        if v284 then
            v286 = v285
        else
            v286 = tostring(os.clock())
        end
        local v287 = u56 .. v286
        if v287 == u66 then
            return
        end
        u66 = v287
        clear(u59)
        if type(a107) == "table" and type(a107.tribe) == "table" then
            local tribe_2 = a107.tribe
            if u56 ~= "alltime" then
                v284 = tribe_2.weekRenown
            else
                v284 = tribe_2.renown
            end
            local v288
            if ((tonumber(v284) or 0) > 0) and type(a107.rank) == "number" then
                v288 = a107.rank
            else
                v288 = nil
            end
            u59.Visible = true
            u59.Size = UDim2.new(1, 0, 0, tbl_upv_1.row + 22)
            u58.Size = UDim2.new(1, 0, 1, -((58 + tbl_upv_1.row) + 26))
            UI_upv_1.new("Frame", {Name = "Rule", BackgroundTransparency = 0.85, Position = fromOffset_upv_1(4, 2), Size = UDim2.new(1, -18, 0, 1), BackgroundColor3 = Colors_upv_1.Stroke, Parent = u59})
            local v289 = boardRow(tribe_2, v288, u59, 1, true)
            v289.AnchorPoint = Vector2.new(0, 1)
            v289.Position = UDim2.new(0, 4, 1, -4)
            v289.Size = UDim2.new(1, -18, 0, tbl_upv_1.row + 8)
            UI_upv_1.Enter(v289, Vector2.new(0, 10), 0.1, UDim2.new(0, 4, 1, -4))
            return
        end
        u59.Visible = false
        u58.Size = UDim2.new(1, 0, 1, -58)
    end
    local function showBoard(a108, a109)
        --[[
          name: showBoard
          line: 1809
          upvalues:
            u6 (ref,  index: 1)
            roleIn (copy, index: 2)
            Tribes_upv_2 (copy, index: 3)
            u56 (ref,  index: 4)
            drawPin (copy, index: 5)
            u63 (ref,  index: 6)
            u62 (ref,  index: 7)
            HttpService_upv_1 (copy, index: 8)
            u66 (ref,  index: 9)
            clear (copy, index: 10)
            u59 (copy, index: 11)
            u58 (copy, index: 12)
            u64 (ref,  index: 13)
            u65 (ref,  index: 14)
            u60 (copy, index: 15)
            u61 (copy, index: 16)
            boardRow (copy, index: 17)
            UI_upv_1 (copy, index: 18)
        ]]
        local v290 = u6 and (u6.tribe)
        local v291
        if type(v290) ~= "table" then
            v291 = Tribes_upv_2.Mine()
        else
            v291 = {}
            v291.id = v290.id
            v291.role = roleIn(v290)
        end
        local u68
        if v291 then
            u68 = v291.id
        else
            v290 = nil
        end
        local tbl_upv_82 = {}
        local u67 = false
        local v292 = nil
        local v293 = nil
        for _, value_30 in a108 do
            if type(value_30) ~= "table" then
                continue
            end
            if u56 ~= "alltime" then
                v292 = value_30.weekRenown
            else
                v292 = value_30.renown
            end
            if (tonumber(v292) or 0) > 0 then
                table.insert(tbl_upv_82, value_30)
                v293 = u67 or ((u68 ~= nil) and (value_30.id == u68))
                u67 = v293
            end
        end
        local function pin_1()
            --[[
              name: pin
              line: 1821
              upvalues:
                u68 (copy, index: 1)
                u67 (ref,  index: 2)
                drawPin (copy, index: 3)
                Tribes_upv_2 (copy, index: 4)
                u56 (ref,  index: 5)
                u63 (ref,  index: 6)
                a109 (copy, index: 7)
                u62 (ref,  index: 8)
                HttpService_upv_1 (copy, index: 9)
                u66 (ref,  index: 10)
                clear (copy, index: 11)
                u59 (copy, index: 12)
                u58 (copy, index: 13)
            ]]
            if u68 and not (u67) then
                drawPin(Tribes_upv_2.CachedRank(u56))
                local u69 = u56
                local u70 = u63
                task.spawn(
                    function()
                        --[[
                          line: 1825
                          upvalues:
                            Tribes_upv_2 (copy, index: 1)
                            u69 (copy, index: 2)
                            a109 (copy, index: 3)
                            u62 (ref,  index: 4)
                            u70 (copy, index: 5)
                            u63 (ref,  index: 6)
                            drawPin (copy, index: 7)
                        ]]
                        local v294, v295 = Tribes_upv_2.Rank(u69)
                        if not v294 or a109 ~= u62 or u70 ~= u63 then
                            return
                        end
                        drawPin(v295)
                    end
                )
                return
            end
            local success_6, v296 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, false)
            local v297
            if success_6 then
                v297 = v296
            else
                v297 = tostring(os.clock())
            end
            local v298 = u56 .. v297
            if v298 == u66 then
                return
            end
            u66 = v298
            clear(u59)
            u59.Visible = false
            u58.Size = UDim2.new(1, 0, 1, -58)
        end
        local v299 = "%*|%*|%*"
        local v300 = u56
        local value_30 = u68 or 0
        local success_7, v301 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, a108)
        if success_7 then
            v293 = v301
        else
            v293 = tostring(os.clock())
        end
        local v302 = v299:format(v300, value_30, v293)
        if v302 ~= u64 then
            local u71 = u65 ~= u56
            u64 = v302
            u65 = u56
            u63 = u63 + 1
            local u72 = u63
            clear(u58)
            u60.Visible = #tbl_upv_82 == 0
            u61.Text = ((u56 ~= "top") and "No tribe has earned Glory yet.") or "No Glory yet this week. Win matches with tribemates to climb."
            local function build_upv_1(a110)
                --[[
                  name: build
                  line: 1847
                  upvalues:
                    tbl_upv_82 (copy, index: 1)
                    boardRow (copy, index: 2)
                    u58 (copy, index: 3)
                    u68 (copy, index: 4)
                    u71 (copy, index: 5)
                    UI_upv_1 (copy, index: 6)
                ]]
                local v303 = tbl_upv_82[a110]
                local v304 = boardRow(v303, a110, u58, a110, (u68 ~= nil) and (v303.id == u68))
                if not u71 or not (a110 <= 10) then
                    return
                end
                UI_upv_1.Enter(v304, Vector2.new(0, 10), math.min(a110 * 0.03, 0.3), UDim2.new())
            end
            for n_3 = 1, math.min(#tbl_upv_82, 10) do
                build_upv_1(n_3)
            end
            if #tbl_upv_82 > 10 then
                task.spawn(
                    function()
                        --[[
                          line: 1858
                          upvalues:
                            tbl_upv_82 (copy, index: 1)
                            u72 (copy, index: 2)
                            u63 (ref,  index: 3)
                            build_upv_1 (copy, index: 4)
                        ]]
                        for n_4 = 11, #tbl_upv_82 do
                            if (n_4 - 10) % 8 ~= 1 then
                                build_upv_1(n_4)
                                continue
                            end
                            task.wait()
                            if u72 == u63 then
                                build_upv_1(n_4)
                                continue
                            end
                            return
                        end
                    end
                )
            end
        end
        pin_1()
    end
    local function loadBoard()
        --[[
          name: loadBoard
          line: 1872
          upvalues:
            u62 (ref,  index: 1)
            u56 (ref,  index: 2)
            paintPeriod (copy, index: 3)
            Tribes_upv_2 (copy, index: 4)
            showBoard (copy, index: 5)
            u65 (ref,  index: 6)
            u64 (ref,  index: 7)
            u63 (ref,  index: 8)
            clear (copy, index: 9)
            u58 (copy, index: 10)
            HttpService_upv_1 (copy, index: 11)
            u66 (ref,  index: 12)
            u59 (copy, index: 13)
            u60 (copy, index: 14)
            UI_upv_1 (copy, index: 15)
            tbl_upv_1 (ref,  index: 16)
            Colors_upv_1 (copy, index: 17)
            u61 (copy, index: 18)
            Tribes_upv_1 (copy, index: 19)
        ]]
        u62 = u62 + 1
        local v305 = u62
        local v306 = u56
        paintPeriod()
        local v307 = Tribes_upv_2.CachedBoard(v306)
        if type(v307) ~= "table" then
            local v308 = nil
            if u65 ~= v306 then
                u64 = nil
                u65 = nil
                u63 = u63 + 1
                clear(u58)
                local v309 = u56
                local success_8, v310 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, false)
                local v311
                if success_8 then
                    v311 = v310
                else
                    v311 = tostring(os.clock())
                end
                v308 = v309 .. v311
                if v308 ~= u66 then
                    u66 = v308
                    clear(u59)
                    u59.Visible = false
                    u58.Size = UDim2.new(1, 0, 1, -58)
                end
                u60.Visible = false
                for n_5 = 1, 5 do
                    local tbl_83 = {BackgroundTransparency = 0.78}
                    UI_upv_1.Tween(UI_upv_1.new("Frame", {Name = "Skeleton", Size = UDim2.new(1, -4, 0, tbl_upv_1.row + 8), LayoutOrder = n_5, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(12), Parent = u58}), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, n_5 * 0.12), tbl_83)
                end
            end
        else
            showBoard(v307, v305)
        end
        local v312, v313 = Tribes_upv_2.Board(u56)
        if u62 ~= u62 then
            return
        end
        if not v312 or type(v313) ~= "table" then
            if type(v307) ~= "table" then
                u64 = nil
                u65 = nil
                u63 = u63 + 1
                clear(u58)
                local v314 = u56
                local success_9, v315 = pcall(HttpService_upv_1.JSONEncode, HttpService_upv_1, false)
                local v316
                if success_9 then
                    v316 = v315
                else
                    v316 = tostring(os.clock())
                end
                local v317 = v314 .. v316
                if v317 ~= u66 then
                    u66 = v317
                    clear(u59)
                    u59.Visible = false
                    u58.Size = UDim2.new(1, 0, 1, -58)
                end
                u60.Visible = true
                local v318 = v313 or (Tribes_upv_1.Message("unavailable"))
                u61.Text = tostring(v318)
            end
            return
        end
        showBoard(v313, u62)
    end
    for key_upv_19, value_31 in tbl_upv_76 do
        value_31.Activated:Connect(
            function()
                --[[
                  line: 1908
                  upvalues:
                    u56 (ref,  index: 1)
                    key_upv_19 (copy, index: 2)
                    u10 (ref,  index: 3)
                    a1 (copy, index: 4)
                    loadBoard (copy, index: 5)
                ]]
                if u56 ~= key_upv_19 then
                    local v319 = os.clock() - u10 >= 0.5
                    if not v319 then
                        return
                    end
                    u56 = key_upv_19
                    a1.Sounds.Play("Click")
                    loadBoard()
                end
            end
        )
    end
    tbl_upv_11.Leaderboard = loadBoard
    local tbl_84 = {}
    tbl_84.Name = "MapArea"
    tbl_84.BackgroundColor3 = Color3.fromRGB(14, 52, 92)
    tbl_84.BackgroundTransparency = 0
    tbl_84.ClipsDescendants = true
    tbl_84[1], tbl_84[2] = UI_upv_1.Corner(14), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9)
    tbl_84.Parent = v29.page
    local u73 = UI_upv_1.new("Frame", tbl_84)
    local u74 = column("Side", v29.page, 10)
    local u75 = UI_upv_1.new("Frame", {Name = "Layer", Size = UDim2.fromScale(1, 1), Parent = u73})
    local u76 = UI_upv_1.new("ScrollingFrame", {Name = "Tiles", Size = UDim2.fromScale(1, 1), ScrollBarThickness = 3, Selectable = false, Visible = false, [1] = UI_upv_1.Padding(12, 12, 12, 12), Parent = u73})
    local u77 = UI_upv_1.new("UIGridLayout", {CellSize = fromOffset_upv_1(200, 150), CellPadding = fromOffset_upv_1(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = u76})
    local u78 = label({Name = "Loading", Text = "Loading the map...", TextSize = 17, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = u73})
    local tbl_85 = {}
    tbl_85.Name = "Legend"
    tbl_85.AnchorPoint = Vector2.new(0, 1)
    tbl_85.Position = UDim2.new(0, 10, 1, -10)
    tbl_85.AutomaticSize = Enum.AutomaticSize.X
    tbl_85.Size = fromOffset_upv_1(0, 30)
    tbl_85.BackgroundColor3 = Colors_upv_1.Void
    tbl_85.BackgroundTransparency = 0.35
    tbl_85.ZIndex = 6
    tbl_85[1], tbl_85[2], tbl_85[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 12, 0, 10), UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    tbl_85.Parent = u73
    local u79 = UI_upv_1.new("Frame", tbl_85)
    local tbl_86 = {}
    tbl_86.Name = "Ring"
    tbl_86.Size = fromOffset_upv_1(14, 14)
    tbl_86.BackgroundTransparency = 1
    tbl_86.LayoutOrder = 1
    tbl_86.ZIndex = 6
    tbl_86[1], tbl_86[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)
    tbl_86.Parent = u79
    UI_upv_1.new("Frame", tbl_86)
    caps("YOUR TRIBE", {LayoutOrder = 2, ZIndex = 6, Size = fromOffset_upv_1(76, 14), TextColor3 = Colors_upv_1.TextDim, Parent = u79})
    UI_upv_1.new("Frame", {Name = "Fog", Size = fromOffset_upv_1(14, 14), BackgroundColor3 = Color3.fromRGB(58, 64, 78), LayoutOrder = 3, ZIndex = 6, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u79})
    caps("NOT IN ROTATION", {LayoutOrder = 4, ZIndex = 6, Size = fromOffset_upv_1(108, 14), TextColor3 = Colors_upv_1.TextDim, Parent = u79})
    local u80 = nil
    local u81 = nil
    local function holderOf(a111)
        --[[
          name: holderOf
          line: 1934
          upvalues:
            u81 (ref, index: 1)
        ]]
        local v320 = u81 and (u81.maps and (u81.maps[a111]))
        if v320 and v320.holder then
            local v321 = u81.tribes and (u81.tribes[tostring(v320.holder)])
            return v321
        end
        return nil
    end
    local u82 = nil
    local tbl_upv_87 = {}
    local function u83(a112)
        --[[
          name: selectTerritory
          line: 1968
          upvalues:
            u10 (ref,  index: 1)
            u80 (ref,  index: 2)
            a1 (copy, index: 3)
            u83 (ref,  index: 4)
            u82 (ref,  index: 5)
        ]]
        local v322 = os.clock() - u10 >= 0.5
        if not v322 then
            return
        end
        if u80 ~= a112 then
            a1.Sounds.Play("Click")
        end
        u80 = a112
        u83()
        u82(a112)
    end
    local function regionAt(a113, a114)
        --[[
          name: regionAt
          line: 1946
          upvalues:
            TribeMapGrid_upv_1 (copy, index: 1)
            tbl_upv_87 (copy, index: 2)
        ]]
        local v323 = math.floor(a113 / TribeMapGrid_upv_1.cell) + 1
        local v324 = math.floor(a114 / TribeMapGrid_upv_1.cell) + 1
        local v325 = TribeMapGrid_upv_1.rows[v324]
        if not v325 or v323 < 1 or TribeMapGrid_upv_1.cols < v323 then
            return nil
        end
        local v326 = tbl_upv_87[v324]
        if not (v326) then
            local tbl_88 = {}
            local v327 = nil
            for key_20, value_32 in string.gmatch(v325, "(%D)(%d+)") do
                local v328 = string.find("abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXY", key_20, 1, true)
                v327 = v328 and TribeMapGrid_upv_1.keys[v328] or false
                for _ = 1, tonumber(value_32) or 0 do
                    table.insert(tbl_88, v327)
                end
            end
            tbl_upv_87[v324] = tbl_88
            v326 = tbl_88
        end
        return v326[v323] or nil
    end
    u83 = function()
        --[[
          line: 1980
          upvalues:
            u78 (copy, index: 1)
            u81 (ref,  index: 2)
            clear (copy, index: 3)
            u75 (copy, index: 4)
            u76 (copy, index: 5)
            u77 (copy, index: 6)
            u6 (ref,  index: 7)
            roleIn (copy, index: 8)
            Tribes_upv_2 (copy, index: 9)
            TribeArt_upv_1 (copy, index: 10)
            u79 (copy, index: 11)
            u73 (copy, index: 12)
            UI_upv_1 (copy, index: 13)
            fromOffset_upv_1 (copy, index: 14)
            regionAt (copy, index: 15)
            u10 (ref,  index: 16)
            u80 (ref,  index: 17)
            a1 (copy, index: 18)
            u83 (ref,  index: 19)
            u82 (ref,  index: 20)
            Tribes_upv_1 (copy, index: 21)
            TribeEmblem_upv_1 (copy, index: 22)
            Colors_upv_1 (copy, index: 23)
            Theme_upv_1 (copy, index: 24)
            label (copy, index: 25)
            Fonts_upv_1 (copy, index: 26)
            u1 (copy, index: 27)
        ]]
        u78.Visible = u81 == nil
        clear(u75)
        clear(u76)
        u77.Parent = u76
        if not u81 then
            return
        end
        local v329 = u6 and (u6.tribe)
        local v330
        if type(v329) ~= "table" then
            v330 = Tribes_upv_2.Mine()
        else
            v330 = {}
            v330.id = v329.id
            v330.role = roleIn(v329)
        end
        local u84 = ((type(u81.order) ~= "table") and {}) or (u81.order)
        local v331 = TribeArt_upv_1.Map.image ~= ""
        u76.Visible = not v331
        u75.Visible = v331
        u79.Visible = v331
        if v331 then
            local v332 = u73.AbsoluteSize / math.max(UI_upv_1.Scale, 0.01)
            local size_upv_1 = TribeArt_upv_1.Map.size
            local v333 = math.min(v332.X / size_upv_1.X, v332.Y / size_upv_1.Y)
            local v334 = math.floor(size_upv_1.X * v333)
            local v335 = math.floor(size_upv_1.Y * v333)
            local v336 = math.floor((v332.X - v334) / 2)
            local v337 = math.floor((v332.Y - v335) / 2)
            UI_upv_1.new("ImageLabel", {Name = "Base", ZIndex = 1, Image = TribeArt_upv_1.Map.image, Position = fromOffset_upv_1(v336, v337), Size = fromOffset_upv_1(v334, v335), Parent = u75})
            local u85 = UI_upv_1.new("TextButton", {ZIndex = 3, Name = "Hit", Selectable = false, Text = "", AutoButtonColor = false, Position = fromOffset_upv_1(v336, v337), Size = fromOffset_upv_1(v334, v335), Parent = u75})
            u85.Activated:Connect(
                function()
                    --[[
                      line: 2005
                      upvalues:
                        u85 (copy, index: 1)
                        UI_upv_1 (copy, index: 2)
                        regionAt (copy, index: 3)
                        size_upv_1 (copy, index: 4)
                        u84 (copy, index: 5)
                        u10 (ref,  index: 6)
                        u80 (ref,  index: 7)
                        a1 (copy, index: 8)
                        u83 (ref,  index: 9)
                        u82 (ref,  index: 10)
                    ]]
                    local AbsoluteSize_1 = u85.AbsoluteSize
                    if (AbsoluteSize_1.X <= 0) then
                        return
                    end
                    if not (AbsoluteSize_1.Y <= 0) then
                        local v338 = (UI_upv_1.PointerAbs() - u85.AbsolutePosition) / AbsoluteSize_1
                        local v339 = regionAt(v338.X * size_upv_1.X, v338.Y * size_upv_1.Y)
                        if v339 and table.find(u84, v339) then
                            local v340 = os.clock() - u10 >= 0.5
                            if not v340 then
                                return
                            end
                            if u80 ~= v339 then
                                a1.Sounds.Play("Click")
                            end
                            u80 = v339
                            u83()
                            u82(v339)
                        end
                    end
                end
            )
            local v341 = nil
            local v342 = nil
            for key_upv_21, value_33 in TribeArt_upv_1.Map.regions do
                local v343 = table.find(u84, key_upv_21) ~= nil
                if v343 then
                    local v344 = u81 and u81.maps and u81.maps[key_upv_21]
                    if not (v344) or not (v344.holder) then
                        v334 = nil
                        local v344 = value_33.bbox[1]
                        local v345 = value_33.bbox[2]
                        v342 = value_33.bbox[3]
                        local v346 = value_33.bbox[4]
                        if value_33.mask ~= "" then
                            local v347 = u80 == key_upv_21
                            local new_12 = UI_upv_1.new
                            local tbl_89 = {ImageColor3 = 0, ImageTransparency = 0, Parent = 0, ZIndex = 2, Position = 0, Size = 0}
                            tbl_89.Name = "Mask_" .. key_upv_21
                            tbl_89.Image = value_33.mask
                            if v334 then
                                v341 = Tribes_upv_1.Color(v334.color1)
                            elseif v343 then
                                v341 = Color3.new(1, 1, 1)
                            else
                                v341 = Color3.fromRGB(58, 64, 78)
                            end
                            tbl_89.ImageColor3 = v341
                            if v334 then
                                v341 = (v347 and 0.3) or 0.42
                            else
                                v341 = ((not v343) and 0.28) or ((v347 and 0.8) or 1)
                            end
                            tbl_89.ImageTransparency = v341
                            tbl_89.Position = fromOffset_upv_1(v336 + math.floor(v344 * v333), v337 + math.floor(v345 * v333))
                            tbl_89.Size = fromOffset_upv_1(math.ceil((v342 - v344) * v333), math.ceil((v346 - v345) * v333))
                            tbl_89.Parent = u75
                            new_12("ImageLabel", tbl_89)
                        end
                        if not (v343) then
                            continue
                        end
                        local v348 = UI_upv_1.new("TextButton", {ZIndex = 4, Text = "", AutoButtonColor = false, Name = "Pin_" .. key_upv_21, AnchorPoint = Vector2.new(0.5, 0.92), Position = fromOffset_upv_1(math.floor(v336 + (value_33.anchor[1] * v333)), math.floor(v337 + (value_33.anchor[2] * v333))), Size = fromOffset_upv_1(64, 70), Parent = u75})
                        if v334 then
                            local new_13 = TribeEmblem_upv_1.new
                            local v349 = ((UI_upv_1.Compact) and 58) or 54
                            local tbl_90 = {ZIndex = 4}
                            tbl_90.AnchorPoint = Vector2.new(0.5, 0.5)
                            tbl_90.Position = UDim2.fromScale(0.5, 0.5)
                            tbl_90.Parent = v348
                            new_13(v349, tbl_90):Set(v334.icon, v334.color1, v334.color2, v334.tag)
                        else
                            local tbl_91 = {}
                            tbl_91.Name = "Dot"
                            tbl_91.AnchorPoint = Vector2.new(0.5, 0.5)
                            tbl_91.Position = UDim2.fromScale(0.5, 0.62)
                            tbl_91.Size = fromOffset_upv_1(14, 14)
                            tbl_91.BackgroundColor3 = Colors_upv_1.Text
                            tbl_91.ZIndex = 4
                            tbl_91[1], tbl_91[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Void, 2, 0.3)
                            tbl_91.Parent = v348
                            UI_upv_1.new("Frame", tbl_91)
                        end
                        if v334 and v330 and v334.id == v330.id then
                            local new_14 = UI_upv_1.new
                            local tbl_92 = {}
                            tbl_92.Name = "Mine"
                            tbl_92.AnchorPoint = Vector2.new(0.5, 0.5)
                            tbl_92.Position = UDim2.fromScale(0.5, 0.5)
                            tbl_92.Size = fromOffset_upv_1(((UI_upv_1.Compact) and 70) or 66, ((UI_upv_1.Compact) and 76) or 72)
                            tbl_92.ZIndex = 3
                            tbl_92[1], tbl_92[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Accent, 3, 0)
                            tbl_92.Parent = v348
                            new_14("Frame", tbl_92)
                        end
                        if u80 == key_upv_21 then
                            UI_upv_1.Pop(UI_upv_1.Pill(Tribes_upv_2.MapName(key_upv_21), Colors_upv_1.Void, {Transparency = 0.15, Height = 24, ZIndex = 5, TextSize = 13, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0, -2), Parent = v348}), 0.85)
                        end
                        v348.Activated:Connect(
                            function()
                                --[[
                                  line: 2061
                                  upvalues:
                                    key_upv_21 (copy, index: 1)
                                    u10 (ref,  index: 2)
                                    u80 (ref,  index: 3)
                                    a1 (copy, index: 4)
                                    u83 (ref,  index: 5)
                                    u82 (ref,  index: 6)
                                ]]
                                local v350 = os.clock() - u10 >= 0.5
                                if not v350 then
                                    return
                                end
                                if u80 ~= key_upv_21 then
                                    a1.Sounds.Play("Click")
                                end
                                u80 = key_upv_21
                                u83()
                                u82(key_upv_21)
                            end
                        )
                    end
                    v334 = u81.tribes and (u81.tribes[tostring(v344.holder)])
                else
                    v334 = nil
                end
                local v344 = value_33.bbox[1]
                local v345 = value_33.bbox[2]
                v342 = value_33.bbox[3]
                local v346 = value_33.bbox[4]
                if value_33.mask ~= "" then
                    local v347 = u80 == key_upv_21
                    local new_12 = UI_upv_1.new
                    local tbl_89 = {ImageColor3 = 0, ImageTransparency = 0, Parent = 0, ZIndex = 2, Position = 0, Size = 0}
                    tbl_89.Name = "Mask_" .. key_upv_21
                    tbl_89.Image = value_33.mask
                    if v334 then
                        v341 = Tribes_upv_1.Color(v334.color1)
                    elseif v343 then
                        v341 = Color3.new(1, 1, 1)
                    else
                        v341 = Color3.fromRGB(58, 64, 78)
                    end
                    tbl_89.ImageColor3 = v341
                    if v334 then
                        v341 = (v347 and 0.3) or 0.42
                    else
                        v341 = ((not v343) and 0.28) or ((v347 and 0.8) or 1)
                    end
                    tbl_89.ImageTransparency = v341
                    tbl_89.Position = fromOffset_upv_1(v336 + math.floor(v344 * v333), v337 + math.floor(v345 * v333))
                    tbl_89.Size = fromOffset_upv_1(math.ceil((v342 - v344) * v333), math.ceil((v346 - v345) * v333))
                    tbl_89.Parent = u75
                    new_12("ImageLabel", tbl_89)
                end
                if not (v343) then
                    continue
                end
                local v348 = UI_upv_1.new("TextButton", {ZIndex = 4, Text = "", AutoButtonColor = false, Name = "Pin_" .. key_upv_21, AnchorPoint = Vector2.new(0.5, 0.92), Position = fromOffset_upv_1(math.floor(v336 + (value_33.anchor[1] * v333)), math.floor(v337 + (value_33.anchor[2] * v333))), Size = fromOffset_upv_1(64, 70), Parent = u75})
                if v334 then
                    local new_13 = TribeEmblem_upv_1.new
                    local v349 = ((UI_upv_1.Compact) and 58) or 54
                    local tbl_90 = {ZIndex = 4}
                    tbl_90.AnchorPoint = Vector2.new(0.5, 0.5)
                    tbl_90.Position = UDim2.fromScale(0.5, 0.5)
                    tbl_90.Parent = v348
                    new_13(v349, tbl_90):Set(v334.icon, v334.color1, v334.color2, v334.tag)
                else
                    local tbl_91 = {}
                    tbl_91.Name = "Dot"
                    tbl_91.AnchorPoint = Vector2.new(0.5, 0.5)
                    tbl_91.Position = UDim2.fromScale(0.5, 0.62)
                    tbl_91.Size = fromOffset_upv_1(14, 14)
                    tbl_91.BackgroundColor3 = Colors_upv_1.Text
                    tbl_91.ZIndex = 4
                    tbl_91[1], tbl_91[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Void, 2, 0.3)
                    tbl_91.Parent = v348
                    UI_upv_1.new("Frame", tbl_91)
                end
                if v334 and v330 and v334.id == v330.id then
                    local new_14 = UI_upv_1.new
                    local tbl_92 = {}
                    tbl_92.Name = "Mine"
                    tbl_92.AnchorPoint = Vector2.new(0.5, 0.5)
                    tbl_92.Position = UDim2.fromScale(0.5, 0.5)
                    tbl_92.Size = fromOffset_upv_1(((UI_upv_1.Compact) and 70) or 66, ((UI_upv_1.Compact) and 76) or 72)
                    tbl_92.ZIndex = 3
                    tbl_92[1], tbl_92[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Accent, 3, 0)
                    tbl_92.Parent = v348
                    new_14("Frame", tbl_92)
                end
                if u80 == key_upv_21 then
                    UI_upv_1.Pop(UI_upv_1.Pill(Tribes_upv_2.MapName(key_upv_21), Colors_upv_1.Void, {Transparency = 0.15, Height = 24, ZIndex = 5, TextSize = 13, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0, -2), Parent = v348}), 0.85)
                end
                v348.Activated:Connect(
                    function()
                        --[[
                          line: 2061
                          upvalues:
                            key_upv_21 (copy, index: 1)
                            u10 (ref,  index: 2)
                            u80 (ref,  index: 3)
                            a1 (copy, index: 4)
                            u83 (ref,  index: 5)
                            u82 (ref,  index: 6)
                        ]]
                        local v350 = os.clock() - u10 >= 0.5
                        if not v350 then
                            return
                        end
                        if u80 ~= key_upv_21 then
                            a1.Sounds.Play("Click")
                        end
                        u80 = key_upv_21
                        u83()
                        u82(key_upv_21)
                    end
                )
            end
        else
            local v351, v352 = nil, nil
            local v353 = nil
            local v354 = nil
            local _ = nil
            local v342 = nil
            local v360 = nil
            for v361, value_upv_34 in u84 do
                local v355 = u81.maps[value_upv_34]
                local v356 = u81 and (u81.maps and (u81.maps[value_upv_34]))
                if not (v356) or not (v356.holder) then
                    v351 = nil
                    local v357 = nil
                    v356 = UI_upv_1.new("TextButton", {Name = value_upv_34, Text = "", AutoButtonColor = false, LayoutOrder = v357, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.2, ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = u76})
                    if v351 and v330 then
                        if v351.id == v330.id then
                            local v362 = true
                        else
                            local v363 = false
                        end
                    end
                    local Stroke_2 = UI_upv_1.Stroke
                    if u80 == value_upv_34 then
                        v353 = Colors_upv_1.Text
                    elseif v351 then
                        v353 = Colors_upv_1.Accent
                    else
                        v353 = Colors_upv_1.Stroke
                    end
                    if u80 == value_upv_34 or v351 then
                        v354 = 2
                        local v358 = ((u80 == value_upv_34) and 0.1) or ((v351 and 0) or 0.9)
                        Stroke_2(v353, v354, v358).Parent = v356
                        local new_15 = UI_upv_1.new
                        local tbl_93 = {Image = 0, Name = "Thumb", Parent = 0, BackgroundColor3 = 0, ScaleType = 0, Size = 0}
                        tbl_93.Image = tostring((v355 and (v355.thumb)) or "")
                        tbl_93.Size = UDim2.new(1, 0, 0, 100)
                        tbl_93.ScaleType = Enum.ScaleType.Crop
                        tbl_93.BackgroundColor3 = Colors_upv_1.Raised
                        tbl_93.Parent = v356
                        new_15("ImageLabel", tbl_93)
                        if v351 then
                            UI_upv_1.new("Frame", {Name = "Tint", BackgroundTransparency = 0.7, Size = UDim2.new(1, 0, 0, 100), BackgroundColor3 = Tribes_upv_1.Color(v351.color1), Parent = v356})
                            local tbl_94 = {}
                            tbl_94.Position = fromOffset_upv_1(8, 50)
                            tbl_94.Parent = v356
                            TribeEmblem_upv_1.new(44, tbl_94):Set(v351.icon, v351.color1, v351.color2, v351.tag)
                        end
                        local tbl_95 = {FontFace = 0, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
                        v352 = v355 and v355.name or value_upv_34
                        tbl_95.Text = tostring(v352)
                        tbl_95.FontFace = Fonts_upv_1.Heavy
                        tbl_95.Position = fromOffset_upv_1(10, 104)
                        tbl_95.Size = UDim2.new(1, -20, 0, 20)
                        tbl_95.Parent = v359
                        label(tbl_95)
                        local tbl_96 = {Position = 0, FontFace = 0, Name = "By", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 14, Size = 0}
                        if v351 then
                            v354 = "Held by %*"
                            local Tag_13 = TribeEmblem_upv_1.Tag
                            if type(v351) ~= "table" then
                                v342 = v351
                            else
                                v342 = v351.tag
                            end
                            v354 = v354:format(Tag_13(v342))
                        else
                            v354 = "Unclaimed"
                        end
                        tbl_96.Text = v354
                        tbl_96.FontFace = Fonts_upv_1.SemiBold
                        if v351 then
                            v354 = TribeEmblem_upv_1.TagColor(v351.color1)
                        else
                            v354 = u1
                        end
                        tbl_96.TextColor3 = v354
                        tbl_96.Position = fromOffset_upv_1(10, 124)
                        tbl_96.Size = UDim2.new(1, -20, 0, 18)
                        tbl_96.Parent = v359
                        label(tbl_96)
                        v359.Activated:Connect(
                            function()
                                --[[
                                  line: 2082
                                  upvalues:
                                    u10 (ref,  index: 1)
                                    a1 (copy, index: 2)
                                    u80 (ref,  index: 3)
                                    value_upv_34 (copy, index: 4)
                                    u83 (ref,  index: 5)
                                    u82 (ref,  index: 6)
                                ]]
                                local v360 = os.clock() - u10 >= 0.5
                                if not v360 then
                                    return
                                end
                                a1.Sounds.Play("Click")
                                u80 = value_upv_34
                                u83()
                                u82(value_upv_34)
                            end
                        )
                    end
                    v354 = 1
                    local v358 = ((u80 == value_upv_34) and 0.1) or ((v351 and 0) or 0.9)
                    Stroke_2(v353, v354, v358).Parent = v356
                    local new_15 = UI_upv_1.new
                    local tbl_93 = {Image = 0, Name = "Thumb", Parent = 0, BackgroundColor3 = 0, ScaleType = 0, Size = 0}
                    tbl_93.Image = tostring((v355 and (v355.thumb)) or "")
                    tbl_93.Size = UDim2.new(1, 0, 0, 100)
                    tbl_93.ScaleType = Enum.ScaleType.Crop
                    tbl_93.BackgroundColor3 = Colors_upv_1.Raised
                    tbl_93.Parent = v356
                    new_15("ImageLabel", tbl_93)
                    if v351 then
                        UI_upv_1.new("Frame", {Name = "Tint", BackgroundTransparency = 0.7, Size = UDim2.new(1, 0, 0, 100), BackgroundColor3 = Tribes_upv_1.Color(v351.color1), Parent = v359})
                        local tbl_94 = {}
                        tbl_94.Position = fromOffset_upv_1(8, 50)
                        tbl_94.Parent = v359
                        TribeEmblem_upv_1.new(44, tbl_94):Set(v351.icon, v351.color1, v351.color2, v351.tag)
                    end
                    local tbl_95 = {FontFace = 0, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
                    v352 = v355 and v355.name or value_upv_34
                    tbl_95.Text = tostring(v352)
                    tbl_95.FontFace = Fonts_upv_1.Heavy
                    tbl_95.Position = fromOffset_upv_1(10, 104)
                    tbl_95.Size = UDim2.new(1, -20, 0, 20)
                    tbl_95.Parent = v359
                    label(tbl_95)
                    local tbl_96 = {Position = 0, FontFace = 0, Name = "By", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 14, Size = 0}
                    if v351 then
                        v354 = "Held by %*"
                        local Tag_13 = TribeEmblem_upv_1.Tag
                        if type(v351) ~= "table" then
                            v342 = v351
                        else
                            v342 = v351.tag
                        end
                        v354 = v354:format(Tag_13(v342))
                    else
                        v354 = "Unclaimed"
                    end
                    tbl_96.Text = v354
                    tbl_96.FontFace = Fonts_upv_1.SemiBold
                    if v351 then
                        v354 = TribeEmblem_upv_1.TagColor(v351.color1)
                    else
                        v354 = u1
                    end
                    tbl_96.TextColor3 = v354
                    tbl_96.Position = fromOffset_upv_1(10, 124)
                    tbl_96.Size = UDim2.new(1, -20, 0, 18)
                    tbl_96.Parent = v359
                    label(tbl_96)
                    v359.Activated:Connect(
                        function()
                            --[[
                              line: 2082
                              upvalues:
                                u10 (ref,  index: 1)
                                a1 (copy, index: 2)
                                u80 (ref,  index: 3)
                                value_upv_34 (copy, index: 4)
                                u83 (ref,  index: 5)
                                u82 (ref,  index: 6)
                            ]]
                            local v360 = os.clock() - u10 >= 0.5
                            if not v360 then
                                return
                            end
                            a1.Sounds.Play("Click")
                            u80 = value_upv_34
                            u83()
                            u82(value_upv_34)
                        end
                    )
                end
                v351 = u81.tribes and (u81.tribes[tostring(v356.holder)])
                local v357 = nil
                v356 = UI_upv_1.new("TextButton", {Name = value_upv_34, Text = "", AutoButtonColor = false, LayoutOrder = v357, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.2, ClipsDescendants = true, [1] = UI_upv_1.Corner(12), Parent = u76})
                if v351 and v330 then
                    if v351.id == v330.id then
                        local v362 = true
                    else
                        local v363 = false
                    end
                end
                local Stroke_2 = UI_upv_1.Stroke
                if u80 == value_upv_34 then
                    v353 = Colors_upv_1.Text
                elseif v351 then
                    v353 = Colors_upv_1.Accent
                else
                    v353 = Colors_upv_1.Stroke
                end
                if u80 == value_upv_34 or v351 then
                    v354 = 2
                    local v358 = ((u80 == value_upv_34) and 0.1) or ((v351 and 0) or 0.9)
                    Stroke_2(v353, v354, v358).Parent = v356
                    local new_15 = UI_upv_1.new
                    local tbl_93 = {Image = 0, Name = "Thumb", Parent = 0, BackgroundColor3 = 0, ScaleType = 0, Size = 0}
                    tbl_93.Image = tostring((v355 and (v355.thumb)) or "")
                    tbl_93.Size = UDim2.new(1, 0, 0, 100)
                    tbl_93.ScaleType = Enum.ScaleType.Crop
                    tbl_93.BackgroundColor3 = Colors_upv_1.Raised
                    tbl_93.Parent = v356
                    new_15("ImageLabel", tbl_93)
                    if v351 then
                        UI_upv_1.new("Frame", {Name = "Tint", BackgroundTransparency = 0.7, Size = UDim2.new(1, 0, 0, 100), BackgroundColor3 = Tribes_upv_1.Color(v351.color1), Parent = v356})
                        local tbl_94 = {}
                        tbl_94.Position = fromOffset_upv_1(8, 50)
                        tbl_94.Parent = v356
                        TribeEmblem_upv_1.new(44, tbl_94):Set(v351.icon, v351.color1, v351.color2, v351.tag)
                    end
                    local tbl_95 = {FontFace = 0, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
                    v352 = v355 and v355.name or value_upv_34
                    tbl_95.Text = tostring(v352)
                    tbl_95.FontFace = Fonts_upv_1.Heavy
                    tbl_95.Position = fromOffset_upv_1(10, 104)
                    tbl_95.Size = UDim2.new(1, -20, 0, 20)
                    tbl_95.Parent = v359
                    label(tbl_95)
                    local tbl_96 = {Position = 0, FontFace = 0, Name = "By", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 14, Size = 0}
                    if v351 then
                        v354 = "Held by %*"
                        local Tag_13 = TribeEmblem_upv_1.Tag
                        if type(v351) ~= "table" then
                            v342 = v351
                        else
                            v342 = v351.tag
                        end
                        v354 = v354:format(Tag_13(v342))
                    else
                        v354 = "Unclaimed"
                    end
                    tbl_96.Text = v354
                    tbl_96.FontFace = Fonts_upv_1.SemiBold
                    if v351 then
                        v354 = TribeEmblem_upv_1.TagColor(v351.color1)
                    else
                        v354 = u1
                    end
                    tbl_96.TextColor3 = v354
                    tbl_96.Position = fromOffset_upv_1(10, 124)
                    tbl_96.Size = UDim2.new(1, -20, 0, 18)
                    tbl_96.Parent = v359
                    label(tbl_96)
                    v359.Activated:Connect(
                        function()
                            --[[
                              line: 2082
                              upvalues:
                                u10 (ref,  index: 1)
                                a1 (copy, index: 2)
                                u80 (ref,  index: 3)
                                value_upv_34 (copy, index: 4)
                                u83 (ref,  index: 5)
                                u82 (ref,  index: 6)
                            ]]
                            local v360 = os.clock() - u10 >= 0.5
                            if not v360 then
                                return
                            end
                            a1.Sounds.Play("Click")
                            u80 = value_upv_34
                            u83()
                            u82(value_upv_34)
                        end
                    )
                end
                v354 = 1
                local v358 = ((u80 == value_upv_34) and 0.1) or ((v351 and 0) or 0.9)
                Stroke_2(v353, v354, v358).Parent = v356
                local new_15 = UI_upv_1.new
                local tbl_93 = {Image = 0, Name = "Thumb", Parent = 0, BackgroundColor3 = 0, ScaleType = 0, Size = 0}
                tbl_93.Image = tostring((v355 and (v355.thumb)) or "")
                tbl_93.Size = UDim2.new(1, 0, 0, 100)
                tbl_93.ScaleType = Enum.ScaleType.Crop
                tbl_93.BackgroundColor3 = Colors_upv_1.Raised
                tbl_93.Parent = v356
                new_15("ImageLabel", tbl_93)
                if v351 then
                    UI_upv_1.new("Frame", {Name = "Tint", BackgroundTransparency = 0.7, Size = UDim2.new(1, 0, 0, 100), BackgroundColor3 = Tribes_upv_1.Color(v351.color1), Parent = v356})
                    local tbl_94 = {}
                    tbl_94.Position = fromOffset_upv_1(8, 50)
                    tbl_94.Parent = v356
                    TribeEmblem_upv_1.new(44, tbl_94):Set(v351.icon, v351.color1, v351.color2, v351.tag)
                end
                local tbl_95 = {FontFace = 0, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
                v352 = v355 and v355.name or value_upv_34
                tbl_95.Text = tostring(v352)
                tbl_95.FontFace = Fonts_upv_1.Heavy
                tbl_95.Position = fromOffset_upv_1(10, 104)
                tbl_95.Size = UDim2.new(1, -20, 0, 20)
                tbl_95.Parent = v359
                label(tbl_95)
                local tbl_96 = {Position = 0, FontFace = 0, Name = "By", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 14, Size = 0}
                if v351 then
                    v354 = "Held by %*"
                    local Tag_13 = TribeEmblem_upv_1.Tag
                    if type(v351) ~= "table" then
                        v342 = v351
                    else
                        v342 = v351.tag
                    end
                    v354 = v354:format(Tag_13(v342))
                else
                    v354 = "Unclaimed"
                end
                tbl_96.Text = v354
                tbl_96.FontFace = Fonts_upv_1.SemiBold
                if v351 then
                    v354 = TribeEmblem_upv_1.TagColor(v351.color1)
                else
                    v354 = u1
                end
                tbl_96.TextColor3 = v354
                tbl_96.Position = fromOffset_upv_1(10, 124)
                tbl_96.Size = UDim2.new(1, -20, 0, 18)
                tbl_96.Parent = v359
                label(tbl_96)
                v359.Activated:Connect(
                    function()
                        --[[
                          line: 2082
                          upvalues:
                            u10 (ref,  index: 1)
                            a1 (copy, index: 2)
                            u80 (ref,  index: 3)
                            value_upv_34 (copy, index: 4)
                            u83 (ref,  index: 5)
                            u82 (ref,  index: 6)
                        ]]
                        local v360 = os.clock() - u10 >= 0.5
                        if not v360 then
                            return
                        end
                        a1.Sounds.Play("Click")
                        u80 = value_upv_34
                        u83()
                        u82(value_upv_34)
                    end
                )
            end
        end
    end
    u82 = function(a115)
        --[[
          line: 2094
          upvalues:
            clear (copy, index: 1)
            u74 (copy, index: 2)
            u81 (ref,  index: 3)
            u6 (ref,  index: 4)
            roleIn (copy, index: 5)
            Tribes_upv_2 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            label (copy, index: 9)
            Fonts_upv_1 (copy, index: 10)
            u10 (ref,  index: 11)
            a1 (copy, index: 12)
            u9 (ref,  index: 13)
            TribeEmblem_upv_1 (copy, index: 14)
            fromOffset_upv_1 (copy, index: 15)
            caps (copy, index: 16)
            u2 (copy, index: 17)
            Theme_upv_1 (copy, index: 18)
            Tribes_upv_1 (copy, index: 19)
            u3 (copy, index: 20)
            untilText (copy, index: 21)
            section (copy, index: 22)
            openable (copy, index: 23)
            u1 (copy, index: 24)
        ]]
        clear(u74)
        if not u81 then
            return
        end
        local v361 = u6 and (u6.tribe)
        local v362
        if type(v361) ~= "table" then
            v362 = Tribes_upv_2.Mine()
        else
            v362 = {}
            v362.id = v361.id
            v362.role = roleIn(v361)
        end
        if a115 and u81.maps and u81.maps[a115] then
            local v363 = u81.maps[a115]
            local v364 = u81 and (u81.maps and (u81.maps[a115]))
            local u86 = not (v364) or not (v364.holder) or u81.tribes and (u81.tribes[tostring(v364.holder)])
            local v365 = UI_upv_1.Panel({LayoutOrder = 1, Name = "Selected", BackgroundTransparency = 0.06, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = u74})
            UI_upv_1.Padding(10, 10, 10, 10).Parent = v365
            UI_upv_1.List(Enum.FillDirection.Vertical, 8).Parent = v365
            local v366 = UI_upv_1.new("ImageLabel", {Name = "Thumb", Image = tostring(v363.thumb or ""), Size = UDim2.new(1, 0, 0, 150), ScaleType = Enum.ScaleType.Crop, BackgroundColor3 = Colors_upv_1.Raised, ClipsDescendants = true, LayoutOrder = 1, [1] = UI_upv_1.Corner(10), Parent = v365})
            local tbl_97 = {}
            tbl_97.Name = "Shade"
            tbl_97.Size = UDim2.fromScale(1, 1)
            tbl_97.BackgroundColor3 = Color3.new(1, 1, 1)
            tbl_97[1], tbl_97[2] = UI_upv_1.Gradient(Color3.new(0, 0, 0), Color3.new(0, 0, 0), 90, NumberSequence.new(1, 0.1)), UI_upv_1.Corner(10)
            tbl_97.Parent = v366
            UI_upv_1.new("Frame", tbl_97)
            label({Name = "Name", TextSize = 22, Text = string.upper(tostring(v363.name or a115)), FontFace = Fonts_upv_1.Display, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -8), Size = UDim2.new(1, -24, 0, 26), Parent = v366})
            local v367 = UI_upv_1.new("TextButton", {LayoutOrder = 2, Name = "Holder", Text = "", AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 54), Parent = v365})
            if u86 then
                v367.Activated:Connect(
                    function()
                        --[[
                          line: 2111
                          upvalues:
                            u10 (ref,  index: 1)
                            a1 (copy, index: 2)
                            u9 (ref,  index: 3)
                            u86 (copy, index: 4)
                        ]]
                        local v368 = os.clock() - u10 >= 0.5
                        if not v368 then
                            return
                        end
                        a1.Sounds.Play("Click")
                        u9(u86.id, u86)
                    end
                )
                TribeEmblem_upv_1.new(48, {Position = fromOffset_upv_1(2, 1), Parent = v367}):Set(u86.icon, u86.color1, u86.color2, u86.tag)
                local v369
                if (v362) and u86.id == v362.id then
                    v369 = "HELD BY YOUR TRIBE"
                else
                    v369 = "HELD BY"
                end
                local tbl_98 = {Parent = 0, TextColor3 = 0}
                tbl_98.Position = fromOffset_upv_1(60, 8)
                tbl_98.Size = UDim2.new(1, -60, 0, 14)
                local v370
                if (v362) and u86.id == v362.id then
                    v370 = Colors_upv_1.Accent
                else
                    v370 = Colors_upv_1.TextMuted
                end
                tbl_98.TextColor3 = v370
                tbl_98.Parent = v367
                caps(v369, tbl_98)
                local tbl_99 = {FontFace = 0, RichText = true, Name = "By", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
                local v371 = TribeEmblem_upv_1.TagColor(u86.color1):ToHex()
                local Tag_14 = TribeEmblem_upv_1.Tag
                local v372
                if type(u86) ~= "table" then
                    v372 = u86
                else
                    v372 = u86.tag
                end
                tbl_99.Text = string.format("<font color=\"#%s\">%s</font>  %s", v371, Tag_14(v372), tostring(u86.name or ""))
                tbl_99.FontFace = Fonts_upv_1.Heavy
                tbl_99.Position = fromOffset_upv_1(60, 24)
                tbl_99.Size = UDim2.new(1, -60, 0, 20)
                tbl_99.Parent = v367
                label(tbl_99)
            else
                UI_upv_1.Glyph("flag", 26, Colors_upv_1.TextMuted, {Position = fromOffset_upv_1(8, 8), Parent = v367})
                caps("UNCLAIMED", {Position = fromOffset_upv_1(50, 3), Size = UDim2.new(1, -50, 0, 14), Parent = v367})
                label({Name = "By", Text = "Win a match here to claim it", TextSize = 15, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Position = fromOffset_upv_1(50, 19), Size = UDim2.new(1, -50, 0, 20), Parent = v367})
            end
            v367 = ((type(v363.top) ~= "table") and {}) or (v363.top)
            if #v367 > 0 then
                caps("THIS WEEK", {LayoutOrder = 3, Parent = v365})
            end
            v361 = ((not (v367[1])) and 1) or (tonumber(v367[1].points) or 1)
            for key_22, value_35 in v367 do
                local tribe_3 = value_35.tribe
                if type(tribe_3) ~= "table" then
                    continue
                end
                local v373 = UI_upv_1.new("Frame", {Name = "Top" .. key_22, Size = UDim2.new(1, 0, 0, 38), LayoutOrder = 3 + key_22, Parent = v365})
                caps(tostring(key_22), {Position = fromOffset_upv_1(0, 12), Size = fromOffset_upv_1(12, 14), TextXAlignment = Enum.TextXAlignment.Center, Parent = v373})
                local tbl_100 = {}
                tbl_100.Position = fromOffset_upv_1(16, 1)
                tbl_100.Parent = v373
                TribeEmblem_upv_1.new(32, tbl_100):Set(tribe_3.icon, tribe_3.color1, tribe_3.color2, tribe_3.tag)
                local tbl_101 = {Position = 0, FontFace = 0, Name = "Tag", TextColor3 = 0, Parent = 0, Text = 0, TextSize = 14, Size = 0}
                local Tag_15 = TribeEmblem_upv_1.Tag
                if type(tribe_3) == "table" then
                    local _ = tribe_3.tag
                end
                tbl_101.Text = Tag_15(tribe_3)
                tbl_101.FontFace = Fonts_upv_1.Heavy
                tbl_101.TextColor3 = TribeEmblem_upv_1.TagColor(tribe_3.color1)
                tbl_101.Position = fromOffset_upv_1(56, 3)
                tbl_101.Size = fromOffset_upv_1(80, 16)
                tbl_101.Parent = v373
                label(tbl_101)
                local v374 = UI_upv_1.new("Frame", {Name = "Bar", Position = fromOffset_upv_1(56, 23), Size = UDim2.new(1, -112, 0, 6), BackgroundColor3 = u2, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v373})
                UI_upv_1.Tween(UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Tribes_upv_1.Color(tribe_3.color1), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v374}), TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, key_22 * 0.05), {Size = UDim2.fromScale(math.clamp((tonumber(value_35.points) or 0) / v361, 0.04, 1), 1)})
                label({Name = "Pts", TextSize = 16, Text = tostring(value_35.points), FontFace = Fonts_upv_1.Display, TextColor3 = u3, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 9), Size = fromOffset_upv_1(50, 20), Parent = v373})
            end
            if v362 and #v367 > 0 then
                if u86 and u86.id == v362.id then
                    if v362 and u86 and u86.id == v362.id then
                        label({LayoutOrder = 9, Name = "Mine", Text = "Keep playing here to defend it", TextSize = 14, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Accent, Size = UDim2.new(1, 0, 0, 18), Parent = v365})
                    end
                else
                    v361 = 0
                    for _, value_36 in v367 do
                        if type(value_36.tribe) ~= "table" then
                            continue
                        end
                        if value_36.tribe.id == v362.id then
                            v361 = tonumber(value_36.points) or 0
                        end
                    end
                    local v376 = ((not (v367[1])) and 0) or (tonumber(v367[1].points) or 0)
                    label({LayoutOrder = 9, Name = "Mine", TextWrapped = true, TextSize = 14, Text = ("Your tribe needs %* more Glory here to take it"):format((v376 - v361) + 1), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Accent, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = v365})
                end
            elseif v362 and u86 and u86.id == v362.id then
                label({LayoutOrder = 9, Name = "Mine", Text = "Keep playing here to defend it", TextSize = 14, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Accent, Size = UDim2.new(1, 0, 0, 18), Parent = v365})
            end
        end
        caps(("TERRITORIES RESET IN %*"):format(string.upper(untilText(u81.weekEndsAt))), {LayoutOrder = 2, Parent = u74})
        local tbl_102 = {}
        local v377 = ((type(u81.order) ~= "table") and {}) or (u81.order)
        for _, value_37 in v377 do
            local v378 = u81.maps[value_37]
            if not (v378) then
                continue
            end
            if v378.holder then
                local str_4 = tostring(v378.holder)
                tbl_102[str_4] = (tbl_102[tostring(v378.holder)] or 0) + 1
            end
        end
        local tbl_103 = {}
        for key_23, value_38 in tbl_102 do
            local v379 = u81.tribes and (u81.tribes[key_23])
            if v379 then
                table.insert(tbl_103, {c = v379, n = value_38})
            end
        end
        table.sort(
            tbl_103,
            function(a116, a117)
                --[[
                  line: 2174
                ]]
                return a117.n < a116.n
            end
        )
        section("WHO HOLDS WHAT", nil, nil, 3, u74)
        local v380 = nil
        for key_24, value_39 in tbl_103 do
            local v381 = UI_upv_1.new("TextButton", {Name = "H" .. key_24, Text = "", AutoButtonColor = false, Size = UDim2.new(1, -6, 0, 50), LayoutOrder = 3 + key_24, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(10), Parent = u74})
            local v382 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
            v382.Parent = v381
            openable(v381, v382, value_39.c)
            local tbl_104 = {}
            tbl_104.AnchorPoint = Vector2.new(0, 0.5)
            tbl_104.Position = UDim2.new(0, 8, 0.5, 0)
            tbl_104.Parent = v381
            TribeEmblem_upv_1.new(38, tbl_104):Set(value_39.c.icon, value_39.c.color1, value_39.c.color2, value_39.c.tag)
            local tbl_105 = {FontFace = 0, RichText = true, Name = "Name", Position = 0, Parent = 0, Text = 0, TextSize = 14, Size = 0}
            local c_1 = value_39.c
            local v383 = TribeEmblem_upv_1.TagColor(c_1.color1):ToHex()
            local Tag_16 = TribeEmblem_upv_1.Tag
            if type(c_1) ~= "table" then
                v380 = c_1
            else
                v380 = c_1.tag
            end
            tbl_105.Text = string.format("<font color=\"#%s\">%s</font>  %s", v383, Tag_16(v380), tostring(c_1.name or ""))
            tbl_105.FontFace = Fonts_upv_1.Heavy
            tbl_105.Position = fromOffset_upv_1(54, 0)
            tbl_105.Size = UDim2.new(1, -106, 1, 0)
            tbl_105.Parent = v381
            label(tbl_105)
            local v384 = nil
            label({Name = "N", TextSize = 19, Text = tostring(v384.n), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 0), Size = fromOffset_upv_1(40, 50), Parent = v381})
        end
        if #tbl_103 ~= 0 then
            return
        end
        label({LayoutOrder = 4, Name = "NoneHeld", Text = "Every territory is open this week.", TextSize = 14, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Size = UDim2.new(1, 0, 0, 24), Parent = u74})
    end
    tbl_upv_11.Territories = function()
        --[[
          line: 2193
          upvalues:
            u81 (ref,  index: 1)
            Tribes_upv_2 (copy, index: 2)
            u78 (copy, index: 3)
            Tribes_upv_1 (copy, index: 4)
            u6 (ref,  index: 5)
            roleIn (copy, index: 6)
            a1 (copy, index: 7)
            u80 (ref,  index: 8)
            u83 (ref,  index: 9)
            u82 (ref,  index: 10)
        ]]
        u81 = Tribes_upv_2.Territories(false)
        u78.Text = u81 and "Loading the map..." or Tribes_upv_1.Message("unavailable")
        local v386 = u6 and (u6.tribe)
        local v387
        if type(v386) ~= "table" then
            v387 = Tribes_upv_2.Mine()
        else
            v387 = {}
            v387.id = v386.id
            v387.role = roleIn(v386)
        end
        if a1.TribeMapSelect then
            u80 = a1.TribeMapSelect
            a1.TribeMapSelect = nil
        end
        if not (u80) and u81 and type(u81.order) == "table" then
            local v388 = nil
            for _, value_40 in u81.order do
                local v389 = u81 and (u81.maps and (u81.maps[value_40]))
                if not (v389) or not (v389.holder) then
                    v388 = nil
                    if not (v388) or not (v387) then
                        continue
                    end
                    if v388.id == v387.id then
                        u80 = value_40
                        break
                    end
                end
                v388 = u81.tribes and (u81.tribes[tostring(v389.holder)])
                if not (v388) or not (v387) then
                    continue
                end
                if v388.id == v387.id then
                    u80 = value_40
                    break
                end
            end
            local v390 = u80 or (u81.order[1])
            u80 = v390
        end
        task.defer(
            function()
                --[[
                  line: 2211
                  upvalues:
                    u83 (ref, index: 1)
                    u82 (ref, index: 2)
                    u80 (ref, index: 3)
                ]]
                u83()
                u82(u80)
            end
        )
    end
    local u87 = column("Left", v31.page, 12)
    local u88 = column("Right", v31.page, 12)
    local u89 = "Find"
    local u90 = 0
    local u91 = nil
    local function viewMemberRow(a118, a119)
        --[[
          name: viewMemberRow
          line: 2228
          upvalues:
            tbl_upv_1 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u88 (copy, index: 4)
            fromOffset_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            label (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            tbl_upv_2 (copy, index: 9)
            u1 (copy, index: 10)
            rowStat (copy, index: 11)
            u3 (copy, index: 12)
        ]]
        local v391 = tbl_upv_1.row - 6
        local new_16 = UI_upv_1.new
        local tbl_106 = {}
        tbl_106.Name = "M" .. tostring(a118.userId)
        tbl_106.Size = UDim2.new(1, -4, 0, v391)
        tbl_106.LayoutOrder = a119
        tbl_106.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_106.BackgroundTransparency = ((a119 % 2 ~= 0) and 0.35) or 0.55
        tbl_106[1] = UI_upv_1.Corner(12)
        tbl_106.Parent = u88
        local v392 = new_16("Frame", tbl_106)
        local v393 = v391 - 16
        local v394 = UI_upv_1.new("ImageLabel", {Name = "Head", Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a118.userId), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = fromOffset_upv_1(v393, v393), BackgroundColor3 = Colors_upv_1.Raised, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v392})
        local v395 = (a118.where ~= false) and (a118.where ~= nil)
        if v395 then
            local tbl_107 = {}
            tbl_107.Name = "Dot"
            tbl_107.AnchorPoint = Vector2.new(1, 1)
            tbl_107.Position = UDim2.fromScale(1.02, 1.02)
            tbl_107.Size = fromOffset_upv_1(12, 12)
            tbl_107.BackgroundColor3 = Colors_upv_1.Success
            tbl_107[1], tbl_107[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Panel, 2, 0)
            tbl_107.Parent = v394
            UI_upv_1.new("Frame", tbl_107)
        else
            v394.ImageTransparency = 0.35
        end
        local v396 = v393 + 22
        local v397 = ((UI_upv_1.Compact) and 92) or 200
        local v398 = UI_upv_1.new("Frame", {Name = "NameRow", Position = fromOffset_upv_1(v396, (math.floor(v391 / 2) - tbl_upv_1.text) - 1), Size = UDim2.new(1, -(v396 + v397), 0, tbl_upv_1.text + 4), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v392})
        local tbl_108 = {LayoutOrder = 1, FontFace = 0, Name = "Name", AutomaticSize = 0, Parent = 0, Text = 0, TextSize = 0, Size = 0}
        tbl_108.Text = tostring(a118.display or (a118.name))
        tbl_108.FontFace = Fonts_upv_1.Heavy
        tbl_108.TextSize = tbl_upv_1.text
        tbl_108.AutomaticSize = Enum.AutomaticSize.X
        tbl_108.Size = fromOffset_upv_1(0, tbl_upv_1.text + 4)
        tbl_108.Parent = v398
        label(tbl_108)
        local v399 = tbl_upv_2[a118.role]
        if v399 then
            UI_upv_1.Pill(v399.text, v399.color, {LayoutOrder = 2, TextSize = 11, Height = 20, Parent = v398})
        end
        label({Name = "Sub", Text = ("@%*  \194\183  Lv %*"):format(a118.name, a118.level), FontFace = Fonts_upv_1.SemiBold, TextSize = tbl_upv_1.sub, TextColor3 = u1, Position = fromOffset_upv_1(v396, math.floor(v391 / 2) + 3), Size = UDim2.new(1, -(v396 + v397), 0, tbl_upv_1.sub + 2), Parent = v392})
        local v400 = UI_upv_1.new("Frame", {Name = "Stats", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = fromOffset_upv_1(v397 - 10, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center), Parent = v392})
        local v401 = tonumber(a118.weekRenown) or 0
        local str_5 = tostring(v401)
        local v402
        if v401 > 0 then
            v402 = u3
        else
            v402 = Colors_upv_1.TextDim
        end
        rowStat(v400, str_5, "GLORY", 1, v402)
        if not (UI_upv_1.Compact) then
            local Pill_3 = UI_upv_1.Pill
            local v403 = (v395 and "ONLINE") or "OFFLINE"
            local v404
            if v395 then
                v404 = Colors_upv_1.Success
            else
                v404 = Colors_upv_1.TextMuted
            end
            local tbl_109 = {LayoutOrder = 2, Transparency = 0, Height = 22, Parent = 0, TextSize = 11, TextColor = 0}
            tbl_109.Transparency = (v395 and 0.15) or 0.75
            local v405
            if v395 then
                v405 = Colors_upv_1.TextDark
            else
                v405 = Colors_upv_1.TextDim
            end
            tbl_109.TextColor = v405
            tbl_109.Parent = v400
            Pill_3(v403, v404, tbl_109)
        end
        return v392
    end
    local function renderView(a120, a121)
        --[[
          name: renderView
          line: 2288
          upvalues:
            clear (copy, index: 1)
            u87 (copy, index: 2)
            u88 (copy, index: 3)
            Tribes_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            smallButton (copy, index: 6)
            showTab (copy, index: 7)
            u89 (ref,  index: 8)
            heroTile (copy, index: 9)
            tbl_upv_1 (ref,  index: 10)
            TribeEmblem_upv_1 (copy, index: 11)
            Colors_upv_1 (copy, index: 12)
            label (copy, index: 13)
            Fonts_upv_1 (copy, index: 14)
            caps (copy, index: 15)
            tbl_upv_3 (copy, index: 16)
            statTile (copy, index: 17)
            u3 (copy, index: 18)
            u6 (ref,  index: 19)
            roleIn (copy, index: 20)
            Tribes_upv_2 (copy, index: 21)
            joinButton (copy, index: 22)
            section (copy, index: 23)
            u90 (ref,  index: 24)
            heldChips (copy, index: 25)
            u14 (ref,  index: 26)
            viewMemberRow (copy, index: 27)
        ]]
        clear(u87)
        clear(u88)
        local v406 = Tribes_upv_1.Color(a120.color1)
        smallButton(
            "\226\128\185  BACK",
            "Dark",
            UI_upv_1.new("Frame", {LayoutOrder = 0, Name = "BackRow", Size = UDim2.new(1, -6, 0, 40), Parent = u87}),
            function()
                --[[
                  line: 2293
                  upvalues:
                    showTab (copy, index: 1)
                    u89 (ref,  index: 2)
                ]]
                showTab(u89)
            end,
            {TextSize = 15, Width = 110}
        )
        local v407 = UI_upv_1.Panel({LayoutOrder = 1, Name = "Hero", BackgroundTransparency = 0.06, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = u87})
        UI_upv_1.Padding(12, 12, 12, 12).Parent = v407
        UI_upv_1.List(Enum.FillDirection.Vertical, 10).Parent = v407
        local u92, v408 = heroTile(v407, tbl_upv_1.hero, 1)
        v408(v406)
        local new_17 = TribeEmblem_upv_1.new
        local v409 = ((UI_upv_1.Compact) and 78) or 124
        local tbl_upv_110 = {ZIndex = 2}
        tbl_upv_110.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_upv_110.Position = UDim2.fromScale(0.5, 0.44)
        tbl_upv_110.Parent = u92
        new_17(v409, tbl_upv_110):Set(a120.icon, a120.color1, a120.color2, a120.tag)
        local Pill_4 = UI_upv_1.Pill
        local Tag_17 = TribeEmblem_upv_1.Tag
        local v410
        if type(a120) ~= "table" then
            v410 = a120
        else
            v410 = a120.tag
        end
        Pill_4(Tag_17(v410), Colors_upv_1.Void, {AutoLocalize = false, Transparency = 0.3, Height = 26, ZIndex = 3, TextSize = 15, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -10), TextColor = TribeEmblem_upv_1.TagColor(a120.color1), Parent = u92})
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 28, MinTextSize = 16, Parent = label({LayoutOrder = 2, Name = "Name", TextScaled = true, Text = string.upper(tostring(a120.name or "")), FontFace = Fonts_upv_1.Display, Size = UDim2.new(1, 0, 0, 32), Parent = v407})})
        local v411 = tonumber(a120.members) or 0
        local v412 = tonumber(a120.online) or 0
        if type(a120.membersList) ~= "table" then
            u92 = v412
        else
            local v413 = 0
            u92 = v413
            for _, value_41 in a120.membersList do
                u92 = ((value_41.where) and (u92 + 1)) or u92
            end
        end
        caps(("%*/%* MEMBERS  \194\183  %* ONLINE  \194\183  %*"):format(v411, Tribes_upv_1.MAX_MEMBERS, u92, string.upper(tbl_upv_3[a120.joinMode] or "")), {LayoutOrder = 3, Parent = v407})
        local new_18 = UI_upv_1.new
        local tbl_111 = {}
        tbl_111.Name = "Stats"
        local v414
        if UI_upv_1.Compact then
            v414 = 52
        else
            v414 = 62
        end
        tbl_111.Size = UDim2.new(1, 0, 0, v414)
        tbl_111.LayoutOrder = 4
        tbl_111[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8)
        tbl_111.Parent = v407
        local v415 = new_18("Frame", tbl_111)
        local v416 = statTile(v415, "WEEK RANK", 1)
        local v417 = statTile(v415, "GLORY", 2)
        local v418 = statTile(v415, "TERRITORIES", 3)
        v416.Text = a120.rank and "#" .. tostring(a120.rank) or "-"
        v417.Text = UI_upv_1.FormatCompact(tonumber(a120.weekRenown) or 0)
        v417.TextColor3 = u3
        v417 = ((type(a120.territories) ~= "table") and {}) or (a120.territories)
        local v420
        if a121 then
            v420 = tostring(#v417)
        else
            v420 = tostring(tonumber(a120.held) or 0)
        end
        v418.Text = v420
        caps(("%* GLORY ALL TIME"):format(UI_upv_1.FormatNumber(tonumber(a120.renownTotal or (a120.renown)) or 0)), {LayoutOrder = 5, TextXAlignment = Enum.TextXAlignment.Center, Parent = v407})
        local v421 = u6 and (u6.tribe)
        local v422
        if type(v421) ~= "table" then
            v422 = Tribes_upv_2.Mine()
        else
            v422 = {}
            v422.id = v421.id
            v422.role = roleIn(v421)
        end
        if not (v422) then
            joinButton(a120, UI_upv_1.new("Frame", {Name = "Join", Size = UDim2.new(1, 0, 0, 46), LayoutOrder = 6, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 0, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v407}), UDim2.new(1, 0, 0, 46))
        end
        local v423 = "TERRITORIES"
        local v424 = (a121 and (#v417)) or nil
        local v425 = (not (a121) or #v417 ~= 0) and (a121 and "held this week") or nil
        section(v423, v424, v425, 1, u88)
        if a121 then
            u92 = u90
            heldChips(
                v417,
                u88,
                2,
                v406,
                function()
                    --[[
                      line: 2339
                      upvalues:
                        u92 (copy, index: 1)
                        u90 (ref,  index: 2)
                        u14 (ref,  index: 3)
                    ]]
                    local v426 = (u92 == u90) and (u14 == "View")
                    return v426
                end,
                "No territories this week."
            )
        end
        if type(a120.membersList) ~= "table" then
            v417 = nil
        else
            v417 = a120.membersList
        end
        section("MEMBERS", v411, nil, 3, u88)
        if v417 then
            local v427 = table.clone(v417)
            tbl_upv_110 = {chief = 0, elder = 1}
            table.sort(
                v427,
                function(a122, a123)
                    --[[
                      line: 2355
                      upvalues:
                        tbl_upv_110 (copy, index: 1)
                    ]]
                    local v428 = tbl_upv_110[a122.role] or 2
                    local v429 = tbl_upv_110[a123.role] or 2
                    if v428 ~= v429 then
                        return v428 < v429
                    end
                    local v430 = ((a122.where) and 1) or 0
                    local v431 = ((a123.where) and 1) or 0
                    if v430 ~= v431 then
                        return v431 < v430
                    end
                    local v432 = tonumber(a122.weekRenown) or 0
                    local v433 = (tonumber(a123.weekRenown) or 0) < v432
                    return v433
                end
            )
            for key_25, value_42 in v427 do
                UI_upv_1.Enter(viewMemberRow(value_42, 3 + key_25), Vector2.new(0, 8), math.min(key_25 * 0.025, 0.25), UDim2.new())
            end
        else
            for n_6 = 1, math.min(math.max(v411, 1), 4) do
                local tbl_112 = {BackgroundTransparency = 0.78}
                UI_upv_1.Tween(UI_upv_1.new("Frame", {Name = "Skeleton", Size = UDim2.new(1, -4, 0, tbl_upv_1.row - 6), LayoutOrder = n_6 + 3, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.5, [1] = UI_upv_1.Corner(12), Parent = u88}), TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, n_6 * 0.12), tbl_112)
            end
        end
    end
    u9 = function(a124, a125)
        --[[
          line: 2372
          upvalues:
            u6 (ref,  index: 1)
            roleIn (copy, index: 2)
            Tribes_upv_2 (copy, index: 3)
            showTab (copy, index: 4)
            u14 (ref,  index: 5)
            u89 (ref,  index: 6)
            u91 (ref,  index: 7)
            u90 (ref,  index: 8)
            u87 (copy, index: 9)
            u88 (copy, index: 10)
            renderView (copy, index: 11)
            clear (copy, index: 12)
            UI_upv_1 (copy, index: 13)
            smallButton (copy, index: 14)
            label (copy, index: 15)
            Tribes_upv_1 (copy, index: 16)
            Fonts_upv_1 (copy, index: 17)
            u1 (copy, index: 18)
        ]]
        if type(a124) ~= "number" then
            return
        end
        local v434 = u6 and (u6.tribe)
        local v435
        if type(v434) ~= "table" then
            v435 = Tribes_upv_2.Mine()
        else
            v435 = {}
            v435.id = v434.id
            v435.role = roleIn(v434)
        end
        if v435 and v435.id == a124 then
            showTab("Overview")
            return
        end
        if u14 ~= "View" then
            u89 = u14 or "Find"
        end
        u91 = a124
        u90 = u90 + 1
        local u93 = u90
        u87.CanvasPosition = Vector2.zero
        u88.CanvasPosition = Vector2.zero
        if type(a125) == "table" and (a125.tag) then
            renderView(a125, false)
        else
            clear(u87)
            clear(u88)
        end
        showTab("View")
        task.spawn(
            function()
                --[[
                  line: 2396
                  upvalues:
                    Tribes_upv_2 (copy, index: 1)
                    a124 (copy, index: 2)
                    u93 (copy, index: 3)
                    u90 (ref,  index: 4)
                    clear (copy, index: 5)
                    u87 (copy, index: 6)
                    u88 (copy, index: 7)
                    UI_upv_1 (copy, index: 8)
                    smallButton (copy, index: 9)
                    showTab (copy, index: 10)
                    u89 (ref,  index: 11)
                    label (copy, index: 12)
                    Tribes_upv_1 (copy, index: 13)
                    Fonts_upv_1 (copy, index: 14)
                    u1 (copy, index: 15)
                    renderView (copy, index: 16)
                ]]
                local v436, v437 = Tribes_upv_2.Action("Get", a124)
                if u93 ~= u90 then
                    return
                end
                if v436 and type(v437) == "table" then
                    renderView(v437, true)
                    return
                end
                clear(u87)
                clear(u88)
                smallButton(
                    "\226\128\185  BACK",
                    "Dark",
                    UI_upv_1.new("Frame", {LayoutOrder = 0, Name = "BackRow", Size = UDim2.new(1, -6, 0, 40), Parent = u87}),
                    function()
                        --[[
                          line: 2406
                          upvalues:
                            showTab (copy, index: 1)
                            u89 (ref,  index: 2)
                        ]]
                        showTab(u89)
                    end,
                    {TextSize = 15, Width = 110}
                )
                local tbl_113 = {LayoutOrder = 1, FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, Name = "Gone", TextTruncate = 0, TextWrapped = true, TextSize = 16, Size = 0}
                local v438 = v437 or (Tribes_upv_1.Message("unavailable"))
                tbl_113.Text = tostring(v438)
                tbl_113.FontFace = Fonts_upv_1.SemiBold
                tbl_113.TextColor3 = u1
                tbl_113.TextTruncate = Enum.TextTruncate.None
                tbl_113.Size = UDim2.new(1, 0, 0, 60)
                tbl_113.Parent = u88
                label(tbl_113)
            end
        )
    end
    local u94 = "create"
    local u95 = {color2 = 0, name = "", minLevel = 0, joinMode = "open", color1 = 1, icon = 1, tag = ""}
    u95.color2 = Tribes_upv_1.WHITE
    local u96 = column("Left", v30.page, 10)
    local u97 = column("Right", v30.page, 10)
    local v439 = UI_upv_1.Panel({LayoutOrder = 1, Name = "PreviewPanel", BackgroundTransparency = 0.06, Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Radius = UDim.new(0, 14), Parent = u96})
    pad(v439, 12)
    UI_upv_1.List(Enum.FillDirection.Vertical, 10).Parent = v439
    local v440, u98 = heroTile(v439, tbl_upv_1.hero - 40, 1)
    local u99 = TribeEmblem_upv_1.new(((UI_upv_1.Compact) and 96) or 112, {ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v440})
    local v441 = UI_upv_1.new("Frame", {Name = "Plate", Size = UDim2.new(1, 0, 0, 36), LayoutOrder = 2, BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(10), Parent = v439})
    local u100 = label({RichText = true, Name = "Text", Text = "", TextSize = 16, FontFace = Fonts_upv_1.Heavy, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = v441})
    local function field(a126, a127, a128, a129, a130, a131)
        --[[
          name: field
          line: 2430
          upvalues:
            UI_upv_1 (copy, index: 1)
            caps (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            u2 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
        ]]
        local v442 = UI_upv_1.new("Frame", {Name = a126 .. "Wrap", Size = UDim2.new(1, -6, 0, 68), LayoutOrder = a130, Parent = a131})
        caps(a127, {Parent = v442})
        local u101 = caps(("0/%*"):format(a129), {TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = fromOffset_upv_1(60, 14), Parent = v442})
        local v443 = UI_upv_1.new("Frame", {Name = a126 .. "Field", Position = fromOffset_upv_1(0, 20), Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = u2, BackgroundTransparency = 0.25, [1] = UI_upv_1.Corner(10), Parent = v442})
        local u102 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88)
        u102.Parent = v443
        local u103 = UI_upv_1.new("TextBox", {Text = "", ClearTextOnFocus = false, BackgroundTransparency = 1, TextSize = 18, Name = a126, PlaceholderText = a128, PlaceholderColor3 = Colors_upv_1.TextMuted, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Position = fromOffset_upv_1(14, 0), Size = UDim2.new(1, -28, 1, 0), Parent = v443})
        u103:GetPropertyChangedSignal("Text"):Connect(
            function()
                --[[
                  line: 2452
                  upvalues:
                    u103 (copy, index: 1)
                    a129 (copy, index: 2)
                    u101 (copy, index: 3)
                ]]
                if a129 < #u103.Text then
                    u103.Text = string.sub(u103.Text, 1, a129)
                else
                    u101.Text = ("%*/%*"):format(#u103.Text, a129)
                end
            end
        )
        u103.Focused:Connect(
            function()
                --[[
                  line: 2459
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u102 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Colors_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(u102, Theme_upv_1.Tween.Fast, {Transparency = 0.2, Color = Colors_upv_1.Accent})
            end
        )
        u103.FocusLost:Connect(
            function()
                --[[
                  line: 2462
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u102 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Colors_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(u102, Theme_upv_1.Tween.Fast, {Transparency = 0.88, Color = Colors_upv_1.Stroke})
            end
        )
        return u103, u101
    end
    local u104 = field("Tag", "TAG  \194\183  2 TO 4 LETTERS OR NUMBERS", "NITE", Tribes_upv_1.TAG_MAX, 3, u96)
    local u105 = field("TribeName", "NAME", "Night Owls", Tribes_upv_1.NAME_MAX, 4, u96)
    local v444 = UI_upv_1.new("Frame", {LayoutOrder = 5, Name = "JoinWrap", Size = UDim2.new(1, -6, 0, 86), Parent = u96})
    caps("WHO CAN JOIN", {Parent = v444})
    local tbl_114 = {}
    tbl_114.Name = "JoinMode"
    tbl_114.Position = fromOffset_upv_1(0, 20)
    tbl_114.Size = UDim2.new(1, 0, 0, 42)
    tbl_114.BackgroundColor3 = u2
    tbl_114.BackgroundTransparency = 0.25
    tbl_114[1], tbl_114[2], tbl_114[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(4, 4, 4, 4), UI_upv_1.List(Enum.FillDirection.Horizontal, 4)
    tbl_114.Parent = v444
    local v445 = UI_upv_1.new("Frame", tbl_114)
    local u106 = label({Name = "JoinDesc", Text = "", TextSize = 13, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, Position = fromOffset_upv_1(4, 66), Size = UDim2.new(1, -8, 0, 16), Parent = v444})
    local tbl_upv_115 = {}
    for key_26, value_43 in Tribes_upv_1.JOIN_MODES do
        tbl_upv_115[value_43] = UI_upv_1.new("TextButton", {Name = value_43, Text = tbl_upv_3[value_43], AutoButtonColor = false, FontFace = Fonts_upv_1.Heavy, TextSize = 13, TextColor3 = Colors_upv_1.TextDim, Size = UDim2.new(0.3333333333333333, -3, 1, 0), LayoutOrder = key_26, BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v445})
    end
    local v446 = UI_upv_1.new("Frame", {LayoutOrder = 6, Name = "LevelWrap", Size = UDim2.new(1, -6, 0, 66), Parent = u96})
    caps("MINIMUM LEVEL TO JOIN", {Parent = v446})
    local v447 = UI_upv_1.new("Frame", {Name = "Stepper", Position = fromOffset_upv_1(0, 20), Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = u2, BackgroundTransparency = 0.25, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v446})
    local u107 = label({Name = "Value", Text = "", TextSize = 18, FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = v447})
    local v448 = UI_upv_1.IconButton({Radius = 17, Name = "Minus", Text = "-", TextSize = 24, Size = fromOffset_upv_1(34, 34), Position = fromOffset_upv_1(4, 4), Color = Colors_upv_1.Raised, Parent = v447})
    local v449 = UI_upv_1.IconButton({Radius = 17, Text = "+", Name = "Plus", TextSize = 22, Size = fromOffset_upv_1(34, 34), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 4), Color = Colors_upv_1.Raised, Parent = v447})
    section("EMBLEM", #Tribes_upv_1.ICONS, "pick one", 1, u97)
    v447 = UI_upv_1.new("Frame", {LayoutOrder = 2, Name = "Icons", Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = u97})
    UI_upv_1.new("UIGridLayout", {FillDirectionMaxCells = 12, CellSize = fromOffset_upv_1(tbl_upv_1.cell, tbl_upv_1.cell), CellPadding = fromOffset_upv_1(6, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = v447})
    section("COLOUR", nil, "the crest", 3, u97)
    local v450 = UI_upv_1.new("Frame", {LayoutOrder = 4, Name = "Color1", Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = u97})
    UI_upv_1.new("UIGridLayout", {FillDirectionMaxCells = 12, CellSize = fromOffset_upv_1(tbl_upv_1.swatch, tbl_upv_1.swatch), CellPadding = fromOffset_upv_1(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = v450})
    section("SECOND COLOUR", nil, "the icon and rim", 5, u97)
    local v451 = UI_upv_1.new("Frame", {LayoutOrder = 6, Name = "Color2", Size = UDim2.new(1, -6, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = u97})
    UI_upv_1.new("UIGridLayout", {FillDirectionMaxCells = 12, CellSize = fromOffset_upv_1(tbl_upv_1.swatch, tbl_upv_1.swatch), CellPadding = fromOffset_upv_1(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = v451})
    local v452 = UI_upv_1.new("Frame", {Name = "Buttons", Size = UDim2.new(1, -6, 0, 54), LayoutOrder = 20, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Right), Parent = u97})
    label({LayoutOrder = 21, Text = "Emblem icons by Lorc, Delapouite, Caro Asercion, Carl Olsen and sbed from game-icons.net, CC BY 3.0 (creativecommons.org/licenses/by/3.0), recoloured", Name = "Credit", TextWrapped = true, TextSize = 12, FontFace = Fonts_upv_1.Medium, TextColor3 = Colors_upv_1.TextMuted, TextTruncate = Enum.TextTruncate.None, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, -6, 0, 0), Parent = u97})
    local v453 = UI_upv_1.Button({LayoutOrder = 1, Name = "Cancel", Text = "BACK", Style = "Dark", Size = fromOffset_upv_1(150, 52), Parent = v452})
    local u108 = UI_upv_1.Button({LayoutOrder = 2, Name = "Submit", Text = "FOUND TRIBE", Style = "Primary", Size = fromOffset_upv_1(240, 52), Parent = v452})
    local tbl_upv_116 = {}
    local tbl_upv_117 = {}
    local tbl_upv_118 = {}
    local function paintForm()
        --[[
          name: paintForm
          line: 2502
          upvalues:
            u99 (copy, index: 1)
            u95 (ref,  index: 2)
            u98 (copy, index: 3)
            Tribes_upv_1 (copy, index: 4)
            u104 (copy, index: 5)
            TribeEmblem_upv_1 (copy, index: 6)
            u100 (copy, index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
            tbl_upv_116 (copy, index: 9)
            tbl_upv_117 (copy, index: 10)
            tbl_upv_118 (copy, index: 11)
            tbl_upv_115 (copy, index: 12)
            Colors_upv_1 (copy, index: 13)
            u106 (copy, index: 14)
            tbl_upv_4 (copy, index: 15)
            u107 (copy, index: 16)
        ]]
        u99:Set(u95.icon, u95.color1, u95.color2, u95.tag)
        u98(Tribes_upv_1.Color(u95.color1))
        local v454 = Tribes_upv_1.CleanTag(u104.Text)
        local v455 = TribeEmblem_upv_1.TagColor(u95.color1)
        local v456 = tonumber(LocalPlayer_upv_1:GetAttribute("Level")) or 1
        local v457 = v455:ToHex()
        local v458
        if v454 == "" then
            v458 = "TAG"
        else
            v458 = v454
        end
        u100.Text = string.format("<font color=\"#AEB5C2\">[%d]</font> <font color=\"#%s\">[%s]</font> %s", v456, v457, v458, LocalPlayer_upv_1.DisplayName)
        for key_27, value_44 in tbl_upv_116 do
            value_44.emblem:Set(key_27, u95.color1, u95.color2, nil)
            local stroke_1 = value_44.stroke
            stroke_1.Transparency = key_27 ~= u95.icon and 1 or 0
            local button_3 = value_44.button
            local v459 = ((key_27 ~= u95.icon) and 0.45) or 0.1
            button_3.BackgroundTransparency = v459
        end
        for key_28, value_45 in tbl_upv_117 do
            v458 = ((key_28 ~= u95.color1) and 1) or 0
            value_45.Transparency = v458
        end
        for key_29, value_46 in tbl_upv_118 do
            v458 = ((key_29 ~= u95.color2) and 1) or 0
            value_46.Transparency = v458
        end
        local v460 = nil
        for key_30, value_47 in tbl_upv_115 do
            v460 = ((key_30 ~= u95.joinMode) and 1) or 0
            value_47.BackgroundTransparency = v460
            if key_30 ~= u95.joinMode then
                v460 = Colors_upv_1.TextDim
            else
                v460 = Colors_upv_1.Text
            end
            value_47.TextColor3 = v460
        end
        u106.Text = tbl_upv_4[u95.joinMode] or ""
        u107.Text = not (u95.minLevel > 0) and "ANY LEVEL" or ("LEVEL %*+"):format(u95.minLevel)
    end
    for n_upv_7 = 1, #Tribes_upv_1.ICONS do
        local v462 = UI_upv_1.new("TextButton", {Name = "Icon" .. n_upv_7, Text = "", AutoButtonColor = false, LayoutOrder = n_upv_7, BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.45, [1] = UI_upv_1.Corner(10), Parent = v447})
        local v463 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 1)
        v463.Parent = v462
        tbl_upv_116[n_upv_7] = {button = v462, stroke = v463, emblem = TribeEmblem_upv_1.new(tbl_upv_1.cell - 6, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v462})}
        v462.Activated:Connect(
            function()
                --[[
                  line: 2532
                  upvalues:
                    u95 (ref,  index: 1)
                    n_upv_7 (copy, index: 2)
                    a1 (copy, index: 3)
                    paintForm (copy, index: 4)
                    UI_upv_1 (copy, index: 5)
                    u99 (copy, index: 6)
                ]]
                u95.icon = n_upv_7
                a1.Sounds.Play("Click")
                paintForm()
                UI_upv_1.Pop(u99.Instance, 0.9)
            end
        )
    end
    for key_upv_31, value_48 in Tribes_upv_1.COLORS do
        for key_upv_32, value_49 in {v450, v451} do
            v447 = UI_upv_1.new("TextButton", {Name = "C" .. key_upv_31, Text = "", AutoButtonColor = false, LayoutOrder = key_upv_31, BackgroundColor3 = value_48, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = value_49})
            local v464 = UI_upv_1.Stroke(Colors_upv_1.Text, 3, 1)
            v464.Parent = v447
            if key_upv_32 ~= 1 then
                tbl_upv_118[key_upv_31] = v464
            else
                tbl_upv_117[key_upv_31] = v464
            end
            v447.Activated:Connect(
                function()
                    --[[
                      line: 2549
                      upvalues:
                        key_upv_32 (copy, index: 1)
                        u95 (ref,  index: 2)
                        key_upv_31 (copy, index: 3)
                        a1 (copy, index: 4)
                        paintForm (copy, index: 5)
                    ]]
                    if key_upv_32 ~= 1 then
                        u95.color2 = key_upv_31
                    else
                        u95.color1 = key_upv_31
                    end
                    a1.Sounds.Play("Click")
                    paintForm()
                end
            )
        end
    end
    for key_upv_33, value_50 in tbl_upv_115 do
        value_50.Activated:Connect(
            function()
                --[[
                  line: 2561
                  upvalues:
                    u95 (ref,  index: 1)
                    key_upv_33 (copy, index: 2)
                    a1 (copy, index: 3)
                    paintForm (copy, index: 4)
                ]]
                u95.joinMode = key_upv_33
                a1.Sounds.Play("Click")
                paintForm()
            end
        )
    end
    local function stepLevel(a132)
        --[[
          name: stepLevel
          line: 2567
          upvalues:
            tbl_upv_5 (copy, index: 1)
            u95 (ref,  index: 2)
            paintForm (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            u107 (copy, index: 5)
        ]]
        local v465 = table.find(tbl_upv_5, u95.minLevel) or 1
        u95.minLevel = tbl_upv_5[math.clamp(v465 + a132, 1, #tbl_upv_5)]
        paintForm()
        UI_upv_1.Bump(u107, 0.12)
    end
    v448.Activated:Connect(
        function()
            --[[
              line: 2573
              upvalues:
                tbl_upv_5 (copy, index: 1)
                u95 (ref,  index: 2)
                paintForm (copy, index: 3)
                UI_upv_1 (copy, index: 4)
                u107 (copy, index: 5)
            ]]
            local v466 = table.find(tbl_upv_5, u95.minLevel) or 1
            u95.minLevel = tbl_upv_5[math.clamp(v466 + -1, 1, #tbl_upv_5)]
            paintForm()
            UI_upv_1.Bump(u107, 0.12)
        end
    )
    v449.Activated:Connect(
        function()
            --[[
              line: 2576
              upvalues:
                tbl_upv_5 (copy, index: 1)
                u95 (ref,  index: 2)
                paintForm (copy, index: 3)
                UI_upv_1 (copy, index: 4)
                u107 (copy, index: 5)
            ]]
            local v467 = table.find(tbl_upv_5, u95.minLevel) or 1
            u95.minLevel = tbl_upv_5[math.clamp(v467 + 1, 1, #tbl_upv_5)]
            paintForm()
            UI_upv_1.Bump(u107, 0.12)
        end
    )
    u104:GetPropertyChangedSignal("Text"):Connect(
        function()
            --[[
              line: 2579
              upvalues:
                u104 (copy, index: 1)
                paintForm (copy, index: 2)
            ]]
            local v468 = string.gsub(string.upper(u104.Text), "[^A-Z0-9]", "")
            if v468 == u104.Text then
                paintForm()
            else
                u104.Text = v468
            end
        end
    )
    u105:GetPropertyChangedSignal("Text"):Connect(paintForm)
    a1.OpenTribeForm = function(a133)
        --[[
          line: 2589
          upvalues:
            u94 (ref,  index: 1)
            u6 (ref,  index: 2)
            u95 (ref,  index: 3)
            u104 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u105 (copy, index: 6)
            u108 (copy, index: 7)
            Tribes_upv_1 (copy, index: 8)
            paintForm (copy, index: 9)
            showTab (copy, index: 10)
            u96 (copy, index: 11)
            u97 (copy, index: 12)
            UI_upv_1 (copy, index: 13)
            GuiService_upv_1 (copy, index: 14)
        ]]
        u94 = a133
        local v469 = u6 and (u6.tribe)
        if a133 == "settings" and type(v469) == "table" then
            local tbl_119 = {}
            tbl_119.tag = v469.tag
            tbl_119.name = v469.name
            tbl_119.icon = v469.icon
            tbl_119.color1 = v469.color1
            tbl_119.color2 = v469.color2
            tbl_119.joinMode = v469.joinMode
            tbl_119.minLevel = tonumber(v469.minLevel) or 0
            u95 = tbl_119
            u104.Text = v469.tag
            u104.TextEditable = false
            u104.TextColor3 = Colors_upv_1.TextDim
            u105.Text = v469.name
            u108:SetText("SAVE")
        else
            local tbl_120 = {name = "", minLevel = 0, joinMode = "open", tag = ""}
            tbl_120.icon = math.random(1, #Tribes_upv_1.ICONS)
            tbl_120.color1 = math.random(1, 14)
            tbl_120.color2 = Tribes_upv_1.WHITE
            u95 = tbl_120
            u104.Text = ""
            u104.TextEditable = true
            u104.TextColor3 = Colors_upv_1.Text
            u105.Text = ""
            u108:SetText("FOUND TRIBE")
        end
        paintForm()
        showTab("Form")
        u96.CanvasPosition = Vector2.zero
        u97.CanvasPosition = Vector2.zero
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = u108.Instance
    end
    local function afterSave()
        --[[
          name: afterSave
          line: 2617
          upvalues:
            Tribes_upv_2 (copy, index: 1)
            u14 (ref,  index: 2)
            u8 (ref,  index: 3)
            u6 (ref,  index: 4)
            showTab (copy, index: 5)
        ]]
        local v470 = Tribes_upv_2.Home(true)
        u14 = nil
        u8(v470 or u6)
        if not u6 or type(u6.tribe) ~= "table" then
            return
        end
        showTab("Overview")
    end
    local function leaveForm()
        --[[
          name: leaveForm
          line: 2625
          upvalues:
            showTab (copy, index: 1)
            u6 (ref,  index: 2)
        ]]
        local v471
        if (u6) and (u6.tribe) then
            v471 = "Overview"
        else
            v471 = "Find"
        end
        showTab(v471)
    end
    v453.Activated:Connect(
        function()
            --[[
              line: 2628
              upvalues:
                u10 (ref,  index: 1)
                showTab (copy, index: 2)
                u6 (ref,  index: 3)
            ]]
            local v472 = os.clock() - u10 >= 0.5
            if v472 then
                local v473
                if (u6) and (u6.tribe) then
                    v473 = "Overview"
                else
                    v473 = "Find"
                end
                showTab(v473)
            end
        end
    )
    u108.Activated:Connect(
        function()
            --[[
              line: 2633
              upvalues:
                u10 (ref,  index: 1)
                Tribes_upv_1 (copy, index: 2)
                u104 (copy, index: 3)
                u105 (copy, index: 4)
                u94 (ref,  index: 5)
                a1 (copy, index: 6)
                UI_upv_1 (copy, index: 7)
                act (copy, index: 8)
                u95 (ref,  index: 9)
                Tribes_upv_2 (copy, index: 10)
                u14 (ref,  index: 11)
                u8 (ref,  index: 12)
                u6 (ref,  index: 13)
                showTab (copy, index: 14)
            ]]
            local v474 = os.clock() - u10 >= 0.5
            if not v474 then
                return
            end
            local v475 = Tribes_upv_1.CleanTag(u104.Text)
            local v476 = Tribes_upv_1.CleanName(u105.Text)
            if u94 ~= "create" or (Tribes_upv_1.ValidTag(v475)) then
                if Tribes_upv_1.ValidName(v476) then
                    if u94 ~= "create" then
                        local tbl_121 = {}
                        tbl_121.name = v476
                        tbl_121.icon = u95.icon
                        tbl_121.color1 = u95.color1
                        tbl_121.color2 = u95.color2
                        tbl_121.joinMode = u95.joinMode
                        tbl_121.minLevel = u95.minLevel
                        if act("Settings", tbl_121) then
                            a1.Toast("Tribe saved", "success")
                            local v477 = Tribes_upv_2.Home(true)
                            u14 = nil
                            local v478 = v477 or u6
                            u8(v478)
                            if not u6 or type(u6.tribe) ~= "table" then
                                return
                            end
                            showTab("Overview")
                        end
                    else
                        local tbl_122 = {}
                        tbl_122.tag = v475
                        tbl_122.name = v476
                        tbl_122.icon = u95.icon
                        tbl_122.color1 = u95.color1
                        tbl_122.color2 = u95.color2
                        tbl_122.joinMode = u95.joinMode
                        tbl_122.minLevel = u95.minLevel
                        if act("Create", tbl_122) then
                            a1.Sounds.Play("Queue_Join")
                            a1.Toast(("[%*] %* is founded!"):format(v475, v476), "success")
                            local v479 = Tribes_upv_2.Home(true)
                            u14 = nil
                            local v480 = v479 or u6
                            u8(v480)
                            if not u6 or type(u6.tribe) ~= "table" then
                                return
                            end
                            showTab("Overview")
                        end
                    end
                else
                    a1.Toast(Tribes_upv_1.Message("bad_name"), "error")
                    UI_upv_1.Shake(u105.Parent, 6)
                end
            end
            a1.Toast(Tribes_upv_1.Message("bad_tag"), "error")
            UI_upv_1.Shake(u104.Parent, 6)
        end
    )
    if a1.Economy then
        a1.Economy.Event:Connect(
            function(a134)
                --[[
                  line: 2667
                  upvalues:
                    Tribes_upv_2 (copy, index: 1)
                    a1 (copy, index: 2)
                    u34 (ref,  index: 3)
                    u4 (copy, index: 4)
                    u14 (ref,  index: 5)
                ]]
                if a134 ~= "TribePass" then
                    return
                end
                task.spawn(
                    function()
                        --[[
                          line: 2671
                          upvalues:
                            Tribes_upv_2 (copy, index: 1)
                            a1 (copy, index: 2)
                            u34 (ref,  index: 3)
                            u4 (copy, index: 4)
                            u14 (ref,  index: 5)
                        ]]
                        local v481 = Tribes_upv_2.Home(true)
                        a1.Sounds.Play("Queue_Join")
                        a1.Toast("Founding unlocked! Make your tribe", "success")
                        local v482 = os.clock() - u34 < 120
                        if not v482 or not u4.IsOpen or type(v481) ~= "table" or (v481.tribe) or u14 == "Form" then
                            return
                        end
                        a1.OpenTribeForm("create")
                    end
                )
            end
        )
    end
    local function layout()
        --[[
          name: layout
          line: 2684
          upvalues:
            tbl_upv_1 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            u4 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            u20 (copy, index: 7)
            u21 (copy, index: 8)
            u44 (copy, index: 9)
            u45 (copy, index: 10)
            u96 (copy, index: 11)
            u97 (copy, index: 12)
            u87 (copy, index: 13)
            u88 (copy, index: 14)
            u6 (ref,  index: 15)
            u73 (copy, index: 16)
            u74 (copy, index: 17)
            u77 (copy, index: 18)
            u5 (copy, index: 19)
        ]]
        local v483 = UI_upv_1.CanvasSize()
        local v484 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            u4.Holder.Size = fromOffset_upv_1(math.floor(math.min(1180, v483.X - 24)), math.floor(math.min(680, (v483.Y - v484) - 12)))
        else
            u4.Holder.Size = fromOffset_upv_1(math.floor(math.clamp(v483.X - 200, 1040, 1280)), math.floor(math.clamp((v483.Y - v484) - 90, 620, 760)))
        end
        local v485 = u4.Holder.Size.X.Offset - 44
        local v486 = (u4.Holder.Size.Y.Offset - 80) - 32 - (tbl_upv_1.tab + 14)
        local left_1 = tbl_upv_1.left
        for _, value_51 in {{u20, u21}, {u44, u45}, {u96, u97}, {u87, u88}} do
            value_51[1].Size = fromOffset_upv_1(left_1, v486)
            value_51[2].Position = fromOffset_upv_1(left_1 + tbl_upv_1.gap, 0)
            value_51[2].Size = fromOffset_upv_1((v485 - left_1) - tbl_upv_1.gap, v486)
        end
        local v487 = (u6 ~= nil) and (type(u6.tribe) == "table")
        u20.Visible = not v487
        if v487 then
            u21.Position = fromOffset_upv_1(0, 0)
            u21.Size = fromOffset_upv_1(v485, v486)
        end
        local v488 = ((UI_upv_1.Compact) and 290) or 330
        u73.Size = fromOffset_upv_1((v485 - v488) - tbl_upv_1.gap, v486)
        u74.Position = fromOffset_upv_1(v485 - v488, 0)
        u74.Size = fromOffset_upv_1(v488, v486)
        u77.CellSize = fromOffset_upv_1(((UI_upv_1.Compact) and 180) or 200, 150)
        u5.Visible = not UI_upv_1.Compact
        u4.Refit()
    end
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 2716
              upvalues:
                u4 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if not u4.IsOpen then
                return
            end
            layout()
        end
    )
    UI_upv_1.ScaleChanged:Connect(
        function()
            --[[
              line: 2721
              upvalues:
                u4 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if not u4.IsOpen then
                return
            end
            layout()
        end
    )
    local u109 = nil
    u8 = function(a135)
        --[[
          line: 2728
          upvalues:
            u6 (ref,  index: 1)
            u4 (copy, index: 2)
            u5 (copy, index: 3)
            setTabs (copy, index: 4)
            clear (copy, index: 5)
            u20 (copy, index: 6)
            label (copy, index: 7)
            Tribes_upv_1 (copy, index: 8)
            Fonts_upv_1 (copy, index: 9)
            u1 (copy, index: 10)
            TribeEmblem_upv_1 (copy, index: 11)
            UI_upv_1 (copy, index: 12)
            u3 (copy, index: 13)
            u109 (ref,  index: 14)
            u14 (ref,  index: 15)
            u91 (ref,  index: 16)
            u15 (copy, index: 17)
            renderOverview (copy, index: 18)
            renderMembers (copy, index: 19)
            renderFindLeft (copy, index: 20)
            layout (copy, index: 21)
            paintTabs (copy, index: 22)
        ]]
        u6 = a135
        if a135 then
            local tribe_4 = a135.tribe
            if type(tribe_4) ~= "table" then
                u4.Title.AutoLocalize = true
                u4.Title.Text = "TRIBES"
                u4.Subtitle.Text = "Play together, earn Glory, hold the maps"
                u5.Text = ""
                if u14 == "Overview" or u14 == "Members" then
                    u14 = nil
                end
                u109 = false
                u15.text.Text = "FIND A TRIBE"
                setTabs({"Find", "Leaderboard", "Territories"})
                renderFindLeft(a135)
            else
                u4.Title.AutoLocalize = false
                u4.Title.Text = string.upper(tostring(tribe_4.name))
                local v489 = tonumber(tribe_4.members) or 0
                local Subtitle_1 = u4.Subtitle
                local Tag_18 = TribeEmblem_upv_1.Tag
                local v490
                if type(tribe_4) ~= "table" then
                    v490 = tribe_4
                else
                    v490 = tribe_4.tag
                end
                local v491 = Tag_18(v490)
                Subtitle_1.Text = ("%*  \194\183  %* %*  \194\183  %* Glory this week"):format(v491, v489, ((v489 ~= 1) and "members") or "member", UI_upv_1.FormatNumber(tonumber(tribe_4.weekRenown) or 0))
                u5.Text = not (tribe_4.rank) and "" or string.format("<font color=\"#%s\">#%d</font> THIS WEEK", u3:ToHex(), tribe_4.rank)
                if u109 == false and (u14 == "Find" or u14 == "View") then
                    u14 = nil
                end
                if u14 == "View" and u91 == tribe_4.id then
                    u14 = nil
                end
                u109 = true
                u15.text.Text = "BROWSE"
                setTabs({"Overview", "Members", "Find", "Leaderboard", "Territories"})
                renderOverview(tribe_4)
                renderMembers(tribe_4)
            end
            layout()
            paintTabs()
        else
            u4.Title.AutoLocalize = true
            u4.Title.Text = "TRIBES"
            u5.Text = ""
            setTabs({"Find", "Territories"})
            clear(u20)
            label({Name = "Down", TextWrapped = true, TextSize = 16, Text = Tribes_upv_1.Message("unavailable"), FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextTruncate = Enum.TextTruncate.None, Size = UDim2.new(1, 0, 0, 60), Parent = u20})
        end
    end
    Tribes_upv_2.HomeChanged:Connect(
        function(a136)
            --[[
              line: 2774
              upvalues:
                u4 (copy, index: 1)
                u14 (ref,  index: 2)
                u8 (ref,  index: 3)
                u30 (ref,  index: 4)
                u31 (ref,  index: 5)
                rowsSig (copy, index: 6)
                u32 (ref,  index: 7)
                drawRows (copy, index: 8)
            ]]
            if not u4.IsOpen or u14 == "Form" then
                return
            end
            u8(a136)
            if not u30 or (u31) or u14 ~= "Find" or rowsSig() == u32 then
                return
            end
            drawRows(u30, false)
        end
    )
    local u110 = 0
    local tbl_123 = {}
    function tbl_123.open(a137)
        --[[
          name: open
          line: 2783
          upvalues:
            u110 (ref,  index: 1)
            u10 (ref,  index: 2)
            a1 (copy, index: 3)
            layout (copy, index: 4)
            u14 (ref,  index: 5)
            u109 (ref,  index: 6)
            u8 (ref,  index: 7)
            Tribes_upv_2 (copy, index: 8)
            tbl_upv_10 (copy, index: 9)
            showTab (copy, index: 10)
            u4 (copy, index: 11)
            u30 (ref,  index: 12)
            u31 (ref,  index: 13)
            rowsSig (copy, index: 14)
            u32 (ref,  index: 15)
            drawRows (copy, index: 16)
        ]]
        u110 = u110 + 1
        local u111 = u110
        u10 = os.clock()
        a1.SetHudHidden("Tribe", true)
        layout()
        u14 = nil
        u109 = nil
        u8(Tribes_upv_2.Cached())
        if type(a137) == "string" and tbl_upv_10[a137] then
            showTab(a137)
        end
        u4:Open()
        task.spawn(
            function()
                --[[
                  line: 2796
                  upvalues:
                    Tribes_upv_2 (copy, index: 1)
                    u111 (copy, index: 2)
                    u110 (ref,  index: 3)
                    u4 (copy, index: 4)
                    u14 (ref,  index: 5)
                    u8 (ref,  index: 6)
                    u30 (ref,  index: 7)
                    u31 (ref,  index: 8)
                    rowsSig (copy, index: 9)
                    u32 (ref,  index: 10)
                    drawRows (copy, index: 11)
                ]]
                local v493 = Tribes_upv_2.Home(true)
                if u111 ~= u110 or not u4.IsOpen then
                    return
                end
                if u14 ~= "Form" then
                    u8(v493)
                end
                if not u30 or (u31) or u14 ~= "Find" or rowsSig() == u32 then
                    return
                end
                drawRows(u30, false)
            end
        )
    end
    function tbl_123.close(a138)
        --[[
          name: close
          line: 2806
          upvalues:
            u33 (ref,  index: 1)
            u90 (ref,  index: 2)
            a1 (copy, index: 3)
            u18 (ref,  index: 4)
            u16 (copy, index: 5)
            clear (copy, index: 6)
            u17 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            MenuManager_upv_1 (copy, index: 9)
            u104 (copy, index: 10)
            u105 (copy, index: 11)
            u22 (copy, index: 12)
            u4 (copy, index: 13)
        ]]
        u33 = u33 + 1
        u90 = u90 + 1
        a1.SetHudHidden("Tribe", false)
        u18 = false
        u16.Visible = false
        clear(u17)
        if UI_upv_1.Gamepad then
            MenuManager_upv_1.Reselect()
        end
        u104:ReleaseFocus()
        u105:ReleaseFocus()
        u22:ReleaseFocus()
        u4:Close(a138)
    end
    function tbl_123.select()
        --[[
          name: select
          line: 2816
          upvalues:
            u13 (ref,  index: 1)
            tbl_upv_10 (copy, index: 2)
        ]]
        local v494 = u13[1]
        if v494 and tbl_upv_10[v494] then
            return tbl_upv_10[v494].button
        end
        return nil
    end
    function tbl_123.back()
        --[[
          name: back
          line: 2820
          upvalues:
            u18 (ref,  index: 1)
            u16 (copy, index: 2)
            clear (copy, index: 3)
            u17 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            MenuManager_upv_1 (copy, index: 6)
            u14 (ref,  index: 7)
            showTab (copy, index: 8)
            u6 (ref,  index: 9)
            u89 (ref,  index: 10)
        ]]
        if u18 then
            u18 = false
            u16.Visible = false
            clear(u17)
            if UI_upv_1.Gamepad then
                MenuManager_upv_1.Reselect()
            end
        elseif u14 ~= "Form" then
            if u14 ~= "View" then
                return false
            end
            showTab(u89)
        else
            local v495
            if (u6) and (u6.tribe) then
                v495 = "Overview"
            else
                v495 = "Find"
            end
            showTab(v495)
        end
        return true
    end
    MenuManager_upv_1.Register("Tribe", tbl_123)
    State_1.PlayerStateChanged:Connect(
        function(a139)
            --[[
              line: 2836
              upvalues:
                MenuManager_upv_1 (copy, index: 1)
            ]]
            if a139 ~= "Match" or not MenuManager_upv_1.IsOpen("Tribe") then
                return
            end
            MenuManager_upv_1.Close("Tribe", true)
        end
    )
    a1.Debug.tribe = function(a140, a141)
        --[[
          line: 2844
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
            showTab (copy, index: 2)
            u9 (ref,  index: 3)
            a1 (copy, index: 4)
            u104 (copy, index: 5)
            u105 (copy, index: 6)
            u8 (ref,  index: 7)
            u10 (ref,  index: 8)
            u108 (copy, index: 9)
            u4 (copy, index: 10)
            u14 (ref,  index: 11)
            u6 (ref,  index: 12)
            u18 (ref,  index: 13)
        ]]
        if a140 == "open" then
            MenuManager_upv_1.Open("Tribe", a141)
        elseif a140 == "tab" then
            showTab((tostring(a141)))
        elseif a140 == "view" then
            u9(tonumber(a141) or 0, nil)
        elseif a140 == "form" then
            a1.OpenTribeForm((tostring(a141 or "create")))
        elseif a140 == "fill" and type(a141) == "table" then
            u104.Text = tostring(a141.tag or "")
            u105.Text = tostring(a141.name or "")
        elseif a140 == "home" and type(a141) == "table" then
            u8(a141)
        elseif a140 == "submit" then
            u10 = -math.huge
            task.spawn(
                function()
                    --[[
                      line: 2860
                      upvalues:
                        u108 (copy, index: 1)
                    ]]
                    u108.Activated:Fire()
                end
            )
        end
        local tbl_124 = {dialog = 0, inTribe = 0}
        tbl_124.open = u4.IsOpen
        tbl_124.tab = u14 or false
        tbl_124.inTribe = (u6 ~= nil) and (u6.tribe ~= false)
        tbl_124.dialog = u18
        return tbl_124
    end
end
return v1