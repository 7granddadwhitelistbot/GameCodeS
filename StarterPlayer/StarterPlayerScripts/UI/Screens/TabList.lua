local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Shared_1 = ReplicatedStorage_1:WaitForChild("Shared")
local Keybinds_upv_1 = require(Shared_1:WaitForChild("Keybinds"))
local Tribes_upv_1 = require(Shared_1:WaitForChild("Tribes"))
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local tbl_1 = {}
local tbl_upv_2 = {a = 770, portrait = 40, text = 19, width = 900, k = 640, dmg = 845, gear = 34, d = 705, row = 52, gearX = 330}
local tbl_upv_3 = {a = 495, portrait = 30, text = 16, width = 640, k = 385, dmg = 565, gear = 0, d = 440, row = 36, gearX = 0}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 44
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        Tribes_upv_1 (copy, index: 3)
        RankArt_upv_1 (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
        Keybinds_upv_1 (copy, index: 6)
        UserInputService_upv_1 (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Portraits_upv_1 = a1.Portraits
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local MenuManager_upv_1 = a1.MenuManager
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = Color3.fromRGB(142, 149, 166)
    local TribeEmblem_upv_1 = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem_upv_1.Init(UI_upv_1)
    local tbl_upv_4 = {}
    tbl_upv_4.Name = "TabList"
    tbl_upv_4.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_upv_4.Position = UDim2.fromScale(0.5, 0.5)
    tbl_upv_4.Size = UDim2.fromOffset(tbl_upv_2.width, 0)
    tbl_upv_4.AutomaticSize = Enum.AutomaticSize.Y
    tbl_upv_4.BackgroundColor3 = Colors_upv_1.Panel
    tbl_upv_4.BackgroundTransparency = 0.08
    tbl_upv_4.Visible = false
    tbl_upv_4.ZIndex = 40
    tbl_upv_4[1], tbl_upv_4[2], tbl_upv_4[3], tbl_upv_4[4] = UI_upv_1.Corner(16), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.85), UI_upv_1.Padding(14, 16, 16, 16), UI_upv_1.List(Enum.FillDirection.Vertical, 10)
    tbl_upv_4.Parent = a1.Canvas.HUD
    local u2 = UI_upv_1.new("Frame", tbl_upv_4)
    local u3 = tbl_upv_2
    tbl_upv_4 = UI_upv_1.new("TextButton", {Name = "TapToClose", ZIndex = 45, Selectable = false, Text = "", Visible = false, AutoButtonColor = false, AnchorPoint = Vector2.new(0.5, 0.5), Parent = a1.Canvas.HUD})
    local tbl_5 = {}
    tbl_5.Name = "Clash"
    tbl_5.Size = UDim2.new(1, 0, 0, 60)
    tbl_5.LayoutOrder = 1
    tbl_5.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_5.Visible = false
    tbl_5.ClipsDescendants = true
    tbl_5.ZIndex = 40
    tbl_5[1] = UI_upv_1.Corner(12)
    tbl_5.Parent = u2
    local u4 = UI_upv_1.new("Frame", tbl_5)
    local u5 = UI_upv_1.Gradient(Colors_upv_1.Ally, Colors_upv_1.Enemy, 0)
    u5.Parent = u4
    local tbl_upv_6 = {TribeEmblem_upv_1.new(44, {ZIndex = 41, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Parent = u4}), TribeEmblem_upv_1.new(44, {ZIndex = 41, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = u4})}
    local function clashTag(a2)
        --[[
          name: clashTag
          line: 83
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u4 (copy, index: 4)
        ]]
        local new_1 = UI_upv_1.new
        local tbl_7 = {AutoLocalize = false, Parent = 0, Text = "", AnchorPoint = 0, TextXAlignment = 0, Position = 0, ZIndex = 41, TextSize = 22, Size = 0}
        tbl_7.Name = "Tag" .. a2
        tbl_7.FontFace = Fonts_upv_1.Display
        tbl_7.TextColor3 = Colors_upv_1.Text
        local v1
        if a2 ~= 1 then
            v1 = Enum.TextXAlignment.Right
        else
            v1 = Enum.TextXAlignment.Left
        end
        tbl_7.TextXAlignment = v1
        tbl_7.AnchorPoint = Vector2.new(((a2 ~= 1) and 1) or 0, 0.5)
        tbl_7.Position = UDim2.new(((a2 ~= 1) and 1) or 0, ((a2 ~= 1) and -64) or 64, 0.5, 0)
        tbl_7.Size = UDim2.fromOffset(120, 26)
        tbl_7.Parent = u4
        local v2 = new_1("TextLabel", tbl_7)
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = v2
        return v2
    end
    local tbl_upv_8 = {clashTag(1), clashTag(2)}
    local u6 = UI_upv_1.new("TextLabel", {Text = "TRIBE CLASH", Name = "Title", ZIndex = 41, TextSize = 24, FontFace = Fonts_upv_1.Display, TextColor3 = Color3.fromRGB(255, 214, 110), AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(1, -380, 0, 26), Parent = u4})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.3).Parent = u6
    local u7 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", ZIndex = 41, TextSize = 12, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 36), Size = UDim2.new(1, -300, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd, Parent = u4})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1, 0.5).Parent = u7
    local tbl_upv_9 = {}
    local tbl_upv_10 = {}
    local function makeBlock(a3)
        --[[
          name: makeBlock
          line: 114
          upvalues:
            UI_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            TribeEmblem_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local v3 = UI_upv_1.new("Frame", {Name = "Team" .. a3, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = a3 + 1, ZIndex = 40, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 6), Parent = u2})
        local v4 = UI_upv_1.new("Frame", {LayoutOrder = 0, Name = "Top", ZIndex = 40, Size = UDim2.new(1, 0, 0, 28), Parent = v3})
        local v5 = UI_upv_1.new("Frame", {Name = "Left", Size = UDim2.new(1, -200, 1, 0), ZIndex = 40, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = v4})
        local v6 = UI_upv_1.new("Frame", {Name = "Bar", Size = UDim2.fromOffset(4, 18), LayoutOrder = 1, BackgroundColor3 = Colors_upv_1.Ally, ZIndex = 40, [1] = UI_upv_1.Corner(2), Parent = v5})
        local v7 = UI_upv_1.new("Frame", {LayoutOrder = 2, Name = "Crest", ZIndex = 40, Visible = false, Size = UDim2.fromOffset(24, 26), Parent = v5})
        local v8 = TribeEmblem_upv_1.new(24, {ZIndex = 41, Parent = v7})
        local v9 = UI_upv_1.new("TextLabel", {LayoutOrder = 3, RichText = true, AutoLocalize = false, Text = "", Name = "Title", ZIndex = 40, TextSize = 16, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), Parent = v5})
        local tbl_11 = {}
        tbl_11.Name = "Score"
        tbl_11.AutomaticSize = Enum.AutomaticSize.X
        tbl_11.Size = UDim2.fromOffset(0, 22)
        tbl_11.LayoutOrder = 4
        tbl_11.BackgroundColor3 = Colors_upv_1.Ally
        tbl_11.BackgroundTransparency = 0.7
        tbl_11.ZIndex = 40
        tbl_11[1], tbl_11[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 9, 0, 9)
        tbl_11.Parent = v5
        local v10 = UI_upv_1.new("Frame", tbl_11)
        local v11 = UI_upv_1.new("TextLabel", {Text = "0", Name = "Text", ZIndex = 41, TextSize = 16, FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v10})
        local tbl_12 = {}
        tbl_12.Name = "Glory"
        tbl_12.AutomaticSize = Enum.AutomaticSize.X
        tbl_12.Size = UDim2.fromOffset(0, 22)
        tbl_12.LayoutOrder = 5
        tbl_12.Visible = false
        tbl_12.BackgroundColor3 = Color3.fromRGB(255, 186, 46)
        tbl_12.BackgroundTransparency = 0.82
        tbl_12.ZIndex = 40
        tbl_12[1], tbl_12[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 9, 0, 9)
        tbl_12.Parent = v5
        local v12 = UI_upv_1.new("Frame", tbl_12)
        v5 = UI_upv_1.new("TextLabel", {Text = "", Name = "Text", ZIndex = 41, TextSize = 12, FontFace = Fonts_upv_1.Heavy, TextColor3 = Color3.fromRGB(255, 196, 80), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = v12})
        local tbl_13 = {}
        for key_1, value_1 in {"K", "D", "A", "DMG"} do
            local new_2 = UI_upv_1.new
            local tbl_14 = {Parent = 0, ZIndex = 40, TextSize = 13, Size = 0}
            tbl_14.Name = value_1
            tbl_14.Text = value_1
            tbl_14.FontFace = Fonts_upv_1.Heavy
            tbl_14.TextColor3 = Colors_upv_1.TextDim
            tbl_14.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_14.Position = UDim2.new(0, 0, 0.5, 0)
            tbl_14.Size = UDim2.fromOffset(((key_1 ~= 4) and 60) or 80, 16)
            tbl_14.Parent = v4
            tbl_13[key_1] = new_2("TextLabel", tbl_14)
        end
        local tbl_15 = {}
        tbl_15.frame = v3
        tbl_15.bar = v6
        tbl_15.crest = v8
        tbl_15.crestHolder = v7
        tbl_15.title = v9
        tbl_15.score = v11
        tbl_15.scorePill = v10
        tbl_15.chip = v12
        tbl_15.chipText = v5
        tbl_15.caps = tbl_13
        tbl_15.list = UI_upv_1.new("Frame", {Name = "Rows", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, ZIndex = 40, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 6), Parent = v3})
        return tbl_15
    end
    tbl_upv_9[1] = makeBlock(1)
    tbl_upv_9[2] = makeBlock(2)
    local function placeColumns()
        --[[
          name: placeColumns
          line: 142
          upvalues:
            u3 (ref,  index: 1)
            tbl_upv_9 (copy, index: 2)
        ]]
        local tbl_16 = {u3.k, u3.d, u3.a, u3.dmg}
        for _, value_2 in tbl_upv_9 do
            for key_2, value_3 in value_2.caps do
                value_3.Position = UDim2.new(0, tbl_16[key_2], 0.5, 0)
            end
        end
    end
    local u8 = false
    local u9 = false
    local u10 = nil
    local u11 = false
    local u12 = -math.huge
    local u13 = nil
    local u14 = false
    local update = nil
    local function showBans()
        --[[
          name: showBans
          line: 161
          upvalues:
            tbl_upv_10 (copy, index: 1)
            u11 (ref,  index: 2)
            u9 (ref,  index: 3)
            u13 (ref,  index: 4)
        ]]
        for key_3, value_4 in tbl_upv_10 do
            if value_4.ban then
                local ban_1 = value_4.ban
                ban_1.Visible = u11 and (not value_4.me and (u9 or (u13 == key_3)))
            end
        end
    end
    local function askMod()
        --[[
          name: askMod
          line: 168
          upvalues:
            u11 (ref,  index: 1)
            u12 (ref,  index: 2)
            a1 (copy, index: 3)
            u2 (copy, index: 4)
            update (ref,  index: 5)
        ]]
        if (u11) or (os.clock() - u12 < 300) then
            return
        end
        u12 = os.clock()
        task.spawn(
            function()
                --[[
                  line: 173
                  upvalues:
                    a1 (copy, index: 1)
                    u11 (ref,  index: 2)
                    u2 (copy, index: 3)
                    update (ref,  index: 4)
                ]]
                local v13, v14 = a1.Remotes.Invoke("ModAction", "IsMod")
                if not v13 or v14 ~= true or (u11) then
                    return
                end
                u11 = true
                if not u2.Visible then
                    return
                end
                update()
            end
        )
    end
    local function pressBan(a4)
        --[[
          name: pressBan
          line: 183
          upvalues:
            tbl_upv_10 (copy, index: 1)
            u14 (ref,  index: 2)
            u11 (ref,  index: 3)
        ]]
        local v15 = tbl_upv_10[a4]
        if (u14) or not v15 or not u11 then
            return
        end
        u14 = true
        task.spawn(function() end)
    end
    local function banButton(a5, a6)
        --[[
          name: banButton
          line: 199
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u3 (ref,  index: 4)
            Theme_upv_1 (copy, index: 5)
            tbl_upv_10 (copy, index: 6)
            u14 (ref,  index: 7)
            u11 (ref,  index: 8)
        ]]
        local tbl_17 = {}
        tbl_17.Name = "Ban"
        tbl_17.Text = "BAN"
        tbl_17.AutoLocalize = false
        tbl_17.FontFace = Fonts_upv_1.Heavy
        tbl_17.TextSize = 13
        tbl_17.TextColor3 = Colors_upv_1.Text
        tbl_17.BackgroundColor3 = Colors_upv_1.Danger
        tbl_17.AnchorPoint = Vector2.new(1, 0.5)
        tbl_17.Position = UDim2.new(0, u3.k - 36, 0.5, 0)
        tbl_17.Size = UDim2.fromOffset(52, 26)
        tbl_17.Selectable = false
        tbl_17.Visible = false
        tbl_17.ZIndex = 46
        tbl_17[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_17.Parent = a5.frame
        local v16 = UI_upv_1.new("TextButton", tbl_17)
        v16.Activated:Connect(
            function()
                --[[
                  line: 217
                  upvalues:
                    a6 (copy, index: 1)
                    tbl_upv_10 (copy, index: 2)
                    u14 (ref,  index: 3)
                    u11 (ref,  index: 4)
                ]]
                local v17 = tbl_upv_10[a6]
                if (u14) or not v17 or not u11 then
                    return
                end
                u14 = true
                task.spawn(function() end)
            end
        )
        return v16
    end
    local function makeRow(a7)
        --[[
          name: makeRow
          line: 223
          upvalues:
            UI_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            tbl_upv_9 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            u1 (copy, index: 7)
            u13 (ref,  index: 8)
            showBans (copy, index: 9)
        ]]
        local v18 = UI_upv_1.new("Frame", {Name = "R_" .. a7, Size = UDim2.new(1, 0, 0, u3.row), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, ZIndex = 40, [1] = UI_upv_1.Corner(10), Parent = tbl_upv_9[1].list})
        local v19 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)
        v19.Enabled = false
        v19.Parent = v18
        local v20 = UI_upv_1.new("Frame", {Name = "Tribe", Position = UDim2.fromOffset(0, 8), Size = UDim2.new(0, 3, 1, -16), BackgroundColor3 = Colors_upv_1.Text, Visible = false, ZIndex = 42, [1] = UI_upv_1.Corner(2), Parent = v18})
        local v21 = UI_upv_1.new("ImageLabel", {Name = "Img", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(u3.portrait, u3.portrait), BackgroundColor3 = Colors_upv_1.Raised, ScaleType = Enum.ScaleType.Crop, ZIndex = 41, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v18})
        local v22 = u3.portrait + 14
        local v23 = ((not (u3.gear > 0)) and (u3.k - 40)) or (u3.gearX)
        local v24 = v23 - v22 - 10
        local v25 = UI_upv_1.new("TextLabel", {RichText = true, AutoLocalize = false, Text = "", Name = "Name", ZIndex = 41, FontFace = Fonts_upv_1.Heavy, TextSize = u3.text, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, v22, 0.5, -u3.text + 1), Size = UDim2.fromOffset(v24, u3.text + 2), Parent = v18})
        local v26 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Sub", ZIndex = 41, TextSize = 12, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, v22, 0.5, 3), Size = UDim2.fromOffset(v24, 14), Parent = v18})
        local new_3 = UI_upv_1.new
        local tbl_18 = {}
        tbl_18.Name = "Gear"
        tbl_18.AnchorPoint = Vector2.new(0, 0.5)
        tbl_18.Position = UDim2.new(0, u3.gearX, 0.5, 0)
        tbl_18.Size = UDim2.fromOffset(math.max(0, (u3.k - 40) - u3.gearX), u3.gear)
        tbl_18.Visible = u3.gear > 0
        tbl_18.ZIndex = 41
        tbl_18[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_18.Parent = v18
        local v27 = new_3("Frame", tbl_18)
        local tbl_19 = {}
        for key_4, value_5 in {u3.k, u3.d, u3.a, u3.dmg} do
            local new_4 = UI_upv_1.new
            local tbl_20 = {Parent = 0, Text = "0", ZIndex = 41, Size = 0}
            tbl_20.FontFace = Fonts_upv_1.Display
            tbl_20.TextSize = u3.text + 3
            tbl_20.TextColor3 = Colors_upv_1.Text
            tbl_20.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_20.Position = UDim2.new(0, value_5, 0.5, 0)
            tbl_20.Size = UDim2.fromOffset(((key_4 ~= 4) and 60) or 80, u3.row)
            tbl_20.Parent = v18
            tbl_19[key_4] = new_4("TextLabel", tbl_20)
        end
        v18.MouseEnter:Connect(
            function()
                --[[
                  line: 259
                  upvalues:
                    u13 (ref,  index: 1)
                    a7 (copy, index: 2)
                    showBans (copy, index: 3)
                ]]
                u13 = a7
                showBans()
            end
        )
        v18.MouseLeave:Connect(
            function()
                --[[
                  line: 263
                  upvalues:
                    u13 (ref,  index: 1)
                    a7 (copy, index: 2)
                    showBans (copy, index: 3)
                ]]
                if u13 ~= a7 then
                    return
                end
                u13 = nil
                showBans()
            end
        )
        local tbl_21 = {me = false, who = "", gearKey = ""}
        tbl_21.frame = v18
        tbl_21.stroke = v19
        tbl_21.stripe = v20
        tbl_21.img = v21
        tbl_21.name = v25
        tbl_21.sub = v26
        tbl_21.nameW = v24
        tbl_21.gear = v27
        tbl_21.cells = tbl_19
        return tbl_21
    end
    local tbl_upv_22 = {}
    State_upv_1.MatchEvent:Connect(
        function(a8, a9)
            --[[
              line: 290
              upvalues:
                State_upv_1 (copy, index: 1)
                tbl_upv_22 (copy, index: 2)
            ]]
            if a8 ~= "MatchStart" then
                return
            end
            if type(a9) == "table" then
                local Match_1 = State_upv_1.Match
                local str_1 = tostring((Match_1 and (Match_1.mapId)) or (a9.mapId or ""))
                local v28
                if type(a9.holder) ~= "table" then
                    v28 = false
                else
                    v28 = a9.holder
                end
                tbl_upv_22[str_1] = v28
            end
        end
    )
    local u15 = false
    local function mapHolder(a10)
        --[[
          name: mapHolder
          line: 298
          upvalues:
            tbl_upv_22 (copy, index: 1)
            a1 (copy, index: 2)
            u15 (ref,  index: 3)
        ]]
        local str_2 = tostring(a10.mapId or "")
        local v29 = tbl_upv_22[str_2]
        if v29 ~= nil then
            return v29 or nil
        end
        local Tribes_2 = a1.Tribes and (a1.Tribes.CachedTerritories())
        local v30 = Tribes_2 and (Tribes_2.maps and (Tribes_2.maps[str_2]))
        if v30 then
            local v31
            if v30.holder then
                v31 = Tribes_2.tribes and (Tribes_2.tribes[tostring(v30.holder)])
            else
                v31 = nil
            end
            tbl_upv_22[str_2] = v31 or false
            return v31
        end
        if a1.Tribes and not (u15) then
            u15 = true
            task.spawn(
                function()
                    --[[
                      line: 313
                      upvalues:
                        a1 (copy, index: 1)
                        u15 (ref,  index: 2)
                    ]]
                    a1.Tribes.Territories(false)
                    u15 = false
                end
            )
        end
        return nil
    end
    local function score(a11)
        --[[
          name: score
          line: 321
        ]]
        return ((tonumber(a11.kills) or 0) * 100) + (tonumber(a11.damage) or 0) + ((tonumber(a11.assists) or 0) * 40)
    end
    local function paintRow(a12, a13, a14, a15, a16)
        --[[
          name: paintRow
          line: 325
          upvalues:
            State_upv_1 (copy, index: 1)
            u11 (ref,  index: 2)
            banButton (copy, index: 3)
            u3 (ref,  index: 4)
            Tribes_upv_1 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            Portraits_upv_1 (copy, index: 7)
            TribeEmblem_upv_1 (copy, index: 8)
            a1 (copy, index: 9)
            RankArt_upv_1 (copy, index: 10)
            UI_upv_1 (copy, index: 11)
            WeaponIcon_upv_1 (copy, index: 12)
        ]]
        local v32 = a13.id == State_upv_1.MyId()
        a12.me = v32
        a12.who = tostring(a13.name or "")
        if u11 and not (v32) and not (a12.ban) then
            a12.ban = banButton(a12, a13.id)
        end
        local v33
        if (a12.ban) and u3.gear == 0 then
            v33 = a12.nameW - 52 - 8
        else
            v33 = a12.nameW
        end
        a12.name.Size = UDim2.fromOffset(v33, u3.text + 2)
        a12.sub.Size = UDim2.fromOffset(v33, 14)
        v33 = (a16 ~= nil) and ((type(a13.tribe) == "table") and (a13.tribe.id == a16.id))
        a12.stripe.Visible = v33
        if v33 then
            a12.stripe.BackgroundColor3 = Tribes_upv_1.Color(a16.color1)
        end
        v33 = a13.alive ~= false
        local v34
        if a13.connected == false then
            v34 = true
        else
            v34 = false
        end
        a12.frame.LayoutOrder = a15
        a12.stroke.Enabled = v32
        local v35 = a12.frame
        local v36
        if v32 then
            v36 = Colors_upv_1.AccentDeep
        else
            v36 = Colors_upv_1.Void
        end
        v35.BackgroundColor3 = v36
        a12.frame.BackgroundTransparency = (v32 and 0.4) or 0.45
        Portraits_upv_1.Apply(a12.img, a13, 60)
        local v37 = Portraits_upv_1.SetTint
        local img_1 = a12.img
        local v38
        if v33 then
            v38 = Color3.new(1, 1, 1)
        else
            v38 = Color3.fromRGB(110, 110, 120)
        end
        v37(img_1, v38, (v33 and 0) or 0.35)
        local v39 = ""
        if type(a13.tribe) == "table" and type(a13.tribe.tag) == "string" then
            v37 = string.format("<font color=\"#%s\">%s</font> ", TribeEmblem_upv_1.TagColor(a13.tribe.color1):ToHex(), TribeEmblem_upv_1.Tag(a13.tribe.tag))
        else
            v37 = v39
        end
        local name_1 = a12.name
        local str_3 = tostring(a13.name or "?")
        local v40 = (v32 and ("  " .. a1.Loc.T("(you)"))) or ""
        name_1.Text = v37 .. str_3 .. v40
        local name_2 = a12.name
        local v41
        if v34 then
            v41 = Colors_upv_1.TextMuted
        elseif v33 then
            v41 = Colors_upv_1.Text
        else
            v41 = Colors_upv_1.TextDim
        end
        name_2.TextColor3 = v41
        v37 = RankArt_upv_1.Ranks.RankOf(tonumber(a13.trophies) or 0)
        local v42 = string.format("<font color=\"#%s\">%s</font>", RankArt_upv_1.Color(v37):ToHex(), RankArt_upv_1.Ranks.Get(v37).name)
        local Rich_1 = a1.Loc.Rich
        local sub_1 = a12.sub
        local v43 = ("Lv %*  \194\183  "):format(tonumber(a13.level) or 1)
        Rich_1(sub_1, v43 .. v42 .. ((v34 and "  \194\183  left the match") or ((v33 and "") or "  \194\183  eliminated")))
        v37 = {tonumber(a13.kills) or 0, tonumber(a13.deaths) or 0, tonumber(a13.assists) or 0, tonumber(a13.damage) or 0}
        local v44 = nil
        local _ = nil
        local v51 = nil
        for key_5, v52 in a12.cells do
            if key_5 ~= 4 then
                v44 = tostring(v37[key_5])
            else
                v44 = UI_upv_1.FormatCompact(v37[key_5])
            end
            local v45
            v45.Text = v44
            local v46 = nil
            if v46 ~= 1 or not (v37[1] > 0) then
                if v33 then
                    v44 = Colors_upv_1.Text
                else
                    v44 = Colors_upv_1.TextDim
                end
                v45.TextColor3 = v44
            end
            if a14 then
                v44 = Colors_upv_1.Ally
            else
                v44 = Colors_upv_1.Enemy
            end
            v44 = v44:Lerp(Colors_upv_1.Text, 0.35)
            v45.TextColor3 = v44
        end
        if u3.gear > 0 then
            if type(a13.loadout) == "table" and type(a13.loadout.items) == "table" then
                v37 = a13.loadout.items
            else
                v35 = {}
            end
            local v47
            if type(a13.loadout) == "table" and type(a13.loadout.armor) == "string" then
                v47 = a13.loadout.armor
            else
                v47 = nil
            end
            local v48 = table.concat(v37, ",") .. "|" .. tostring(v47)
            if v48 ~= a12.gearKey then
                a12.gearKey = v48
                for v53, value_6 in a12.gear:GetChildren() do
                    if value_6:IsA("GuiObject") then
                        value_6:Destroy()
                    end
                end
                local v49 = table.clone(v37)
                if v47 then
                    table.insert(v49, v47)
                end
                for key_6, value_7 in v49 do
                    if key_6 > 6 then
                        break
                    else
                        local v50 = UI_upv_1.new("Frame", {Name = "G" .. key_6, Size = UDim2.fromOffset(u3.gear, u3.gear), LayoutOrder = key_6, BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.5, ZIndex = 41, [1] = UI_upv_1.Corner(8), Parent = a12.gear})
                        WeaponIcon_upv_1.Set(UI_upv_1.new("Frame", {ZIndex = 42, Name = "Icon", Size = UDim2.fromScale(1, 1), Parent = v50}), value_7, {glow = false})
                    end
                end
            end
        end
    end
    local function teamTribe(a17)
        --[[
          name: teamTribe
          line: 273
        ]]
        local tbl_23 = {}
        local v51 = nil
        local v52 = 0
        local v53
        if type(a17) == "table" and type(a17.members) == "table" then
            v53 = a17.members
        else
            v53 = {}
        end
        v51 = v51
        for _, value_8 in v53 do
            local tribe_1 = value_8.tribe
            if type(tribe_1) ~= "table" or type(tribe_1.id) ~= "number" then
                continue
            end
            tbl_23[tribe_1.id] = (tbl_23[tribe_1.id] or 0) + 1
            if not (tbl_23[tribe_1.id] >= 2) then
                continue
            end
            if v52 < tbl_23[tribe_1.id] then
                v52, v51 = tbl_23[tribe_1.id], tribe_1
            end
        end
        return v51, v52
    end
    local function layout()
        --[[
          name: layout
          line: 490
          upvalues:
            UI_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            u3 (ref,  index: 4)
            tbl_upv_10 (copy, index: 5)
            u2 (copy, index: 6)
            u4 (copy, index: 7)
            u6 (copy, index: 8)
            u7 (copy, index: 9)
            placeColumns (copy, index: 10)
        ]]
        if tbl_upv_3 ~= u3 then
            u3 = tbl_upv_3
            for key_7, value_9 in tbl_upv_10 do
                value_9.frame:Destroy()
                tbl_upv_10[key_7] = nil
            end
        end
        u2.Size = UDim2.fromOffset(math.clamp(UI_upv_1.CanvasSize().X - 24, math.min(u3.width, 240), u3.width), 0)
        local Compact_1 = UI_upv_1.Compact
        local v54 = u2:FindFirstChildOfClass("UIPadding")
        if v54 then
            v54.PaddingTop = UDim.new(0, (Compact_1 and 10) or 14)
            v54.PaddingBottom = UDim.new(0, (Compact_1 and 10) or 16)
        end
        local v55 = u2:FindFirstChildOfClass("UIListLayout")
        if v55 then
            v55.Padding = UDim.new(0, (Compact_1 and 6) or 10)
        end
        u4.Size = UDim2.new(1, 0, 0, (Compact_1 and 50) or 60)
        u6.Position = UDim2.new(0.5, 0, 0, (Compact_1 and 4) or 8)
        u7.Position = UDim2.new(0.5, 0, 0, (Compact_1 and 30) or 36)
        placeColumns()
    end
    local function allowed()
        --[[
          name: allowed
          line: 519
          upvalues:
            State_upv_1 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            MenuManager_upv_1 (copy, index: 3)
        ]]
        local v56 = State_upv_1.SeesMatch() and ((State_upv_1.Phase() ~= "MatchEnd") and ((LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true) and (MenuManager_upv_1.Current() == nil)))
        return v56
    end
    local u16 = false
    local function paint()
        --[[
          name: paint
          line: 393
          upvalues:
            State_upv_1 (copy, index: 1)
            teamTribe (copy, index: 2)
            u4 (copy, index: 3)
            u2 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            tbl_upv_6 (copy, index: 6)
            tbl_upv_8 (copy, index: 7)
            TribeEmblem_upv_1 (copy, index: 8)
            u5 (copy, index: 9)
            Tribes_upv_1 (copy, index: 10)
            mapHolder (copy, index: 11)
            u7 (copy, index: 12)
            tbl_upv_9 (copy, index: 13)
            a1 (copy, index: 14)
            tbl_upv_10 (copy, index: 15)
            makeRow (copy, index: 16)
            paintRow (copy, index: 17)
            showBans (copy, index: 18)
        ]]
        local Match_2 = State_upv_1.Match
        if not Match_2 or type(Match_2.teams) ~= "table" then
            return
        end
        local v57 = State_upv_1.MyTeam()
        local tbl_24 = {}
        tbl_24[1], tbl_24[2] = v57, ((v57 ~= 1) and 1) or 2
        local tbl_25 = {}
        local tbl_26 = {}
        local tbl_27 = {{}, {}}
        local v58 = nil
        for _, value_10 in tbl_24 do
            local v59, v60 = teamTribe(Match_2.teams[value_10])
            if v59 then
                v58 = {}
                v58.tribe = v59
                v58.n = v60
            else
                v58 = nil
            end
            local v61
            tbl_26[v61] = v58
            for v82, value_11 in ((Match_2.teams[value_10]) and (Match_2.teams[value_10].members)) or {} do
                if type(value_11.tribe) ~= "table" then
                    continue
                end
                if type(value_11.tribe.id) == "number" then
                    tbl_27[v61][value_11.tribe.id] = true
                end
            end
        end
        local v62 = (tbl_26[1] ~= nil) and ((tbl_26[2] ~= nil) and (tbl_26[1].tribe.id ~= tbl_26[2].tribe.id))
        u4.Visible = v62
        local v63 = u2:FindFirstChildOfClass("UIStroke")
        local v64
        if v62 then
            v64 = Color3.fromRGB(255, 196, 80)
        else
            v64 = Colors_upv_1.Stroke
        end
        v63.Color = v64
        local v65 = u2:FindFirstChildOfClass("UIStroke")
        v65.Transparency = (v62 and 0.45) or 0.85
        local v66 = nil
        if v62 then
            for n_1 = 1, 2 do
                local tribe_2 = tbl_26[n_1].tribe
                tbl_upv_6[n_1]:Set(tribe_2.icon, tribe_2.color1, tribe_2.color2, tribe_2.tag)
                tbl_upv_8[n_1].Text = TribeEmblem_upv_1.Tag(tribe_2.tag)
            end
            u5.Color = ColorSequence.new(Tribes_upv_1.Color(tbl_26[1].tribe.color1):Lerp(Colors_upv_1.Panel, 0.55), Tribes_upv_1.Color(tbl_26[2].tribe.color1):Lerp(Colors_upv_1.Panel, 0.55))
            local v67 = string.upper(tostring(Match_2.mapName or "this map"))
            v66 = mapHolder(Match_2)
            if v66 and (v66.id == tbl_26[1].tribe.id or v66.id == tbl_26[2].tribe.id) then
                u7.Text = ("%* DEFENDS %*"):format(TribeEmblem_upv_1.Tag(v66.tag), v67)
            elseif v66 then
                u7.Text = ("%*  \194\183  HELD BY %*"):format(v67, TribeEmblem_upv_1.Tag(v66.tag))
            else
                u7.Text = ("GLORY DECIDES WHO HOLDS %*"):format(v67)
            end
        end
        local v68, v69 = nil, nil
        local v70 = nil
        local _ = nil
        local v71 = nil
        for key_8, value_12 in tbl_24 do
            local v72 = Match_2.teams[value_12]
            local v73 = tbl_upv_9[key_8]
            local v74 = value_12 == v57
            if v74 then
                v68 = Colors_upv_1.Ally
            else
                v68 = Colors_upv_1.Enemy
            end
            local v75 = tbl_26[key_8]
            v73.bar.BackgroundColor3 = v68
            v73.scorePill.BackgroundColor3 = v68
            local score_2 = v73.score
            score_2.Text = tostring((v72 and (v72.score)) or 0)
            v73.crestHolder.Visible = v75 ~= nil
            if v75 then
                local tribe_3 = v75.tribe
                v73.crest:Set(tribe_3.icon, tribe_3.color1, tribe_3.color2, tribe_3.tag)
                v73.title.Text = string.format("<font color=\"#%s\">%s</font>  %s", TribeEmblem_upv_1.TagColor(tribe_3.color1):ToHex(), TribeEmblem_upv_1.Tag(tribe_3.tag), string.upper(tostring(tribe_3.name or "")))
                v73.title.TextColor3 = Colors_upv_1.Text
                local v76 = tbl_27[3 - key_8][tribe_3.id] == true
                v73.chip.Visible = true
                local chipText_1 = v73.chipText
                if v76 then
                    v70 = "SPLIT  \194\183  NO GLORY"
                else
                    v70 = string.format("\195\151%s GLORY", tostring(Tribes_upv_1.STACK_MULT[math.clamp(v75.n, 1, 3)]))
                end
                chipText_1.Text = v70
                local chipText_2 = v73.chipText
                if v76 then
                    v70 = Colors_upv_1.TextDim
                else
                    v70 = Color3.fromRGB(255, 196, 80)
                end
                chipText_2.TextColor3 = v70
                v73.chip.BackgroundTransparency = (v76 and 0.9) or 0.82
            else
                local title_1 = v73.title
                title_1.Text = a1.Loc.T(string.upper(tostring((v72 and (v72.name)) or ((v74 and "Your team") or "Enemies"))))
                v73.title.TextColor3 = v68:Lerp(Colors_upv_1.Text, 0.25)
                v73.chip.Visible = false
            end
            local v77 = table.clone((v72 and (v72.members)) or {})
            table.sort(
                v77,
                function(a18, a19)
                    --[[
                      line: 461
                    ]]
                    local v78 = ((tonumber(a18.kills) or 0) * 100) + (tonumber(a18.damage) or 0) + (tonumber(a18.assists) or 0) * 40
                    local v79 = ((tonumber(a19.kills) or 0) * 100) + (tonumber(a19.damage) or 0) + (tonumber(a19.assists) or 0) * 40
                    if v78 ~= v79 then
                        return v79 < v78
                    end
                    local v80 = tostring(a18.name) < tostring(a19.name)
                    return v80
                end
            )
            for key_9, value_13 in v77 do
                if type(value_13) ~= "table" or type(value_13.id) ~= "string" then
                    continue
                end
                tbl_25[value_13.id] = true
                v71 = tbl_upv_10[value_13.id]
                if v71 then
                    v68 = v71
                else
                    local v81 = makeRow(value_13.id)
                    tbl_upv_10[value_13.id] = v81
                    v68 = v81
                end
                v68.frame.Parent = v73.list
                if tbl_26[key_8] then
                    v69 = tbl_26[key_8].tribe
                else
                    v69 = nil
                end
                paintRow(v68, value_13, v74, key_9, v69)
            end
        end
        for key_10, value_14 in tbl_upv_10 do
            if not (tbl_25[key_10]) then
                value_14.frame:Destroy()
                tbl_upv_10[key_10] = nil
            end
        end
        showBans()
    end
    update = function()
        --[[
          name: update
          line: 526
          upvalues:
            u10 (ref,  index: 1)
            u8 (ref,  index: 2)
            u9 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            MenuManager_upv_1 (copy, index: 6)
            u2 (copy, index: 7)
            layout (copy, index: 8)
            paint (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            askMod (copy, index: 11)
            u13 (ref,  index: 12)
            u11 (ref,  index: 13)
            u16 (ref,  index: 14)
            showBans (copy, index: 15)
            tbl_upv_4 (copy, index: 16)
        ]]
        local v82
        if u10 == nil then
            v82 = u8 or u9
        else
            v82 = u10
        end
        local v83
        if v82 then
            local v84 = true
            if u10 == true then
                v83 = v84
            else
                v83 = State_upv_1.SeesMatch() and ((State_upv_1.Phase() ~= "MatchEnd") and ((LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true) and (MenuManager_upv_1.Current() == nil)))
            end
        else
            v83 = v82
        end
        if not (v83) then
            local v85 = State_upv_1.SeesMatch() and State_upv_1.Phase() ~= "MatchEnd" and LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true and MenuManager_upv_1.Current() == nil
            local v86
            if v85 then
                v86 = u9
            else
                v86 = false
            end
            u9 = v86
        end
        if not (v83) or u2.Visible then
            if v83 then
                paint()
            else
                u2.Visible = false
            end
        else
            layout()
            paint()
            u2.Visible = true
            UI_upv_1.Pop(u2, 0.97)
        end
        if u2.Visible then
            askMod()
        else
            u13 = nil
        end
        local v87 = u2.Visible and (u11 and (not u9 and (not UI_upv_1.Gamepad)))
        if v87 ~= u16 then
            u16 = v87
            if v87 then
                MenuManager_upv_1.PushMouse("TabListMod")
            else
                MenuManager_upv_1.PopMouse("TabListMod")
            end
        end
        showBans()
        tbl_upv_4.ZIndex = (u11 and 39) or 45
        tbl_upv_4.Visible = u2.Visible and u9
        if not tbl_upv_4.Visible then
            return
        end
        task.defer(
            function()
                --[[
                  line: 563
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    tbl_upv_4 (copy, index: 2)
                    u2 (copy, index: 3)
                ]]
                local v88 = math.max(UI_upv_1.Scale, 0.01)
                tbl_upv_4.Position = u2.Position
                tbl_upv_4.Size = UDim2.fromOffset(u2.AbsoluteSize.X / v88, u2.AbsoluteSize.Y / v88)
            end
        )
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a20, a21)
            --[[
              line: 571
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
                Keybinds_upv_1 (copy, index: 2)
                State_upv_1 (copy, index: 3)
                u8 (ref,  index: 4)
                update (ref,  index: 5)
            ]]
            if UserInputService_upv_1:GetFocusedTextBox() then
                return
            end
            local v89 = Keybinds_upv_1.ActionOf(a20) == "Scoreboard"
            if (not v89 or (a21)) and (not Keybinds_upv_1.IsPad(a20, "Scoreboard") or not State_upv_1.SeesMatch() or (Keybinds_upv_1.PadBlocked())) then
                return
            end
            u8 = true
            update()
        end
    )
    Keybinds_upv_1.OnInput(
        "Ended",
        function(a22)
            --[[
              line: 582
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
                u8 (ref,  index: 2)
                update (ref,  index: 3)
            ]]
            if Keybinds_upv_1.ActionOf(a22) ~= "Scoreboard" and not Keybinds_upv_1.IsPad(a22, "Scoreboard") then
                return
            end
            u8 = false
            update()
        end
    )
    local function hookScoreboard()
        --[[
          name: hookScoreboard
          line: 589
          upvalues:
            a1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u9 (ref,  index: 3)
            update (ref,  index: 4)
        ]]
        local Scoreboard_1 = a1.Scoreboard
        if not Scoreboard_1 or (Scoreboard_1:FindFirstChild("TabListOpen")) then
            return
        end
        local tbl_28 = {Name = "TabListOpen", ZIndex = 30, Selectable = false, Text = "", AutoButtonColor = false}
        tbl_28.Size = UDim2.fromScale(1, 1)
        tbl_28.Parent = Scoreboard_1
        UI_upv_1.new("TextButton", tbl_28).Activated:Connect(
            function()
                --[[
                  line: 595
                  upvalues:
                    u9 (ref, index: 1)
                    update (ref, index: 2)
                ]]
                u9 = not u9
                update()
            end
        )
    end
    hookScoreboard()
    tbl_upv_4.Activated:Connect(
        function()
            --[[
              line: 601
              upvalues:
                u9 (ref, index: 1)
                update (ref, index: 2)
            ]]
            if not u9 then
                return
            end
            u9 = false
            update()
        end
    )
    State_upv_1.MatchChanged:Connect(
        function()
            --[[
              line: 608
              upvalues:
                hookScoreboard (copy, index: 1)
                u2 (copy, index: 2)
                u8 (ref,  index: 3)
                u9 (ref,  index: 4)
                update (ref,  index: 5)
            ]]
            hookScoreboard()
            if not u2.Visible and not u8 and not u9 then
                return
            end
            update()
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function()
            --[[
              line: 614
              upvalues:
                u8 (ref, index: 1)
                u9 (ref, index: 2)
                update (ref, index: 3)
            ]]
            u8 = false
            u9 = false
            update()
        end
    )
    State_upv_1.WatchChanged:Connect(
        function()
            --[[
              line: 618
              upvalues:
                u8 (ref, index: 1)
                u9 (ref, index: 2)
                update (ref, index: 3)
            ]]
            u8 = false
            u9 = false
            update()
        end
    )
    MenuManager_upv_1.Changed:Connect(
        function()
            --[[
              line: 622
              upvalues:
                update (ref, index: 1)
            ]]
            update()
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("ReplayPlaying"):Connect(update)
    UI_upv_1.OnResize(
        function()
            --[[
              line: 626
              upvalues:
                u2 (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if not u2.Visible then
                return
            end
            layout()
        end
    )
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 631
              upvalues:
                u2 (copy, index: 1)
                layout (copy, index: 2)
                paint (copy, index: 3)
            ]]
            if not u2.Visible then
                return
            end
            layout()
            paint()
        end
    )
    layout()
    a1.Debug.tablist = function(a23, a24, a25)
        --[[
          line: 639
          upvalues:
            u10 (ref,  index: 1)
            u11 (ref,  index: 2)
            u12 (ref,  index: 3)
            tbl_upv_10 (copy, index: 4)
            u14 (ref,  index: 5)
            a1 (copy, index: 6)
            u13 (ref,  index: 7)
            update (ref,  index: 8)
            u2 (copy, index: 9)
            u16 (ref,  index: 10)
        ]]
        if a24 ~= nil then
            local u17
            if a24 == "mod" then
                u11 = a25 == true
                local v90 = a25 == true and -math.huge or os.clock()
                u12 = v90
            elseif a24 == "ban" and type(a25) == "string" then
                u17 = tbl_upv_10[a25]
                if not (u14) and u17 and u11 then
                    u14 = true
                    task.spawn(
                        function()
                            --[[
                              line: 189
                              upvalues:
                                a1 (copy, index: 1)
                                a25 (copy, index: 2)
                                u17 (copy, index: 3)
                                u14 (ref,  index: 4)
                            ]]
                            local v91, v92, v93 = a1.Remotes.Invoke("ModAction", "RowBan", a25, u17.who)
                            u14 = false
                            if v91 then
                                if v92 ~= true and type(v93) == "string" and v93 ~= "" then
                                    a1.Toast(v93, "error")
                                end
                            else
                                a1.Toast("Couldn't reach the server. Try again.", "error")
                            end
                        end
                    )
                end
            elseif a24 == "hover" then
                local v90
                if type(a25) ~= "string" then
                    v90 = nil
                else
                    v90 = a25
                end
                u13 = v90
            end
        else
            local v90
            if a23 ~= nil then
                v90 = a23 == true
            else
                v90 = nil
            end
            u10 = v90
        end
        update()
        local tbl_29 = {}
        for key_11, value_15 in tbl_upv_10 do
            if value_15.ban then
                tbl_29[key_11] = value_15.ban.Visible
            end
        end
        local tbl_30 = {}
        tbl_30.visible = u2.Visible
        tbl_30.rows = #u2:GetDescendants()
        tbl_30.mod = u11
        tbl_30.bans = tbl_29
        tbl_30.cursor = u16
        return tbl_30
    end
end
return tbl_1