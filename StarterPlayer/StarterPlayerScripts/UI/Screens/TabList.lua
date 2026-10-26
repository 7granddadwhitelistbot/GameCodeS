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
      line: 36
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
          line: 75
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
          line: 106
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
          line: 134
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
    local function makeRow(a4)
        --[[
          name: makeRow
          line: 143
          upvalues:
            UI_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            tbl_upv_9 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            u1 (copy, index: 7)
        ]]
        local v13 = UI_upv_1.new("Frame", {Name = "R_" .. a4, Size = UDim2.new(1, 0, 0, u3.row), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, ZIndex = 40, [1] = UI_upv_1.Corner(10), Parent = tbl_upv_9[1].list})
        local v14 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0)
        v14.Enabled = false
        v14.Parent = v13
        local v15 = UI_upv_1.new("Frame", {Name = "Tribe", Position = UDim2.fromOffset(0, 8), Size = UDim2.new(0, 3, 1, -16), BackgroundColor3 = Colors_upv_1.Text, Visible = false, ZIndex = 42, [1] = UI_upv_1.Corner(2), Parent = v13})
        local v16 = UI_upv_1.new("ImageLabel", {Name = "Img", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(u3.portrait, u3.portrait), BackgroundColor3 = Colors_upv_1.Raised, ScaleType = Enum.ScaleType.Crop, ZIndex = 41, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v13})
        local v17 = u3.portrait + 14
        local v18 = ((not (u3.gear > 0)) and (u3.k - 40)) or (u3.gearX)
        local v19 = v18 - v17 - 10
        local v20 = UI_upv_1.new("TextLabel", {RichText = true, AutoLocalize = false, Text = "", Name = "Name", ZIndex = 41, FontFace = Fonts_upv_1.Heavy, TextSize = u3.text, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, v17, 0.5, -u3.text + 1), Size = UDim2.fromOffset(v19, u3.text + 2), Parent = v13})
        local v21 = UI_upv_1.new("TextLabel", {RichText = true, Text = "", Name = "Sub", ZIndex = 41, TextSize = 12, FontFace = Fonts_upv_1.SemiBold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, v17, 0.5, 3), Size = UDim2.fromOffset(v19, 14), Parent = v13})
        local new_3 = UI_upv_1.new
        local tbl_17 = {}
        tbl_17.Name = "Gear"
        tbl_17.AnchorPoint = Vector2.new(0, 0.5)
        tbl_17.Position = UDim2.new(0, u3.gearX, 0.5, 0)
        tbl_17.Size = UDim2.fromOffset(math.max(0, (u3.k - 40) - u3.gearX), u3.gear)
        tbl_17.Visible = u3.gear > 0
        tbl_17.ZIndex = 41
        tbl_17[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_17.Parent = v13
        local v22 = new_3("Frame", tbl_17)
        local tbl_18 = {}
        for key_3, value_4 in {u3.k, u3.d, u3.a, u3.dmg} do
            local new_4 = UI_upv_1.new
            local tbl_19 = {Parent = 0, Text = "0", ZIndex = 41, Size = 0}
            tbl_19.FontFace = Fonts_upv_1.Display
            tbl_19.TextSize = u3.text + 3
            tbl_19.TextColor3 = Colors_upv_1.Text
            tbl_19.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_19.Position = UDim2.new(0, value_4, 0.5, 0)
            tbl_19.Size = UDim2.fromOffset(((key_3 ~= 4) and 60) or 80, u3.row)
            tbl_19.Parent = v13
            tbl_18[key_3] = new_4("TextLabel", tbl_19)
        end
        local tbl_20 = {gearKey = ""}
        tbl_20.frame = v13
        tbl_20.stroke = v14
        tbl_20.stripe = v15
        tbl_20.img = v16
        tbl_20.name = v20
        tbl_20.sub = v21
        tbl_20.gear = v22
        tbl_20.cells = tbl_18
        return tbl_20
    end
    local tbl_upv_21 = {}
    State_upv_1.MatchEvent:Connect(
        function(a5, a6)
            --[[
              line: 200
              upvalues:
                State_upv_1 (copy, index: 1)
                tbl_upv_21 (copy, index: 2)
            ]]
            if a5 ~= "MatchStart" then
                return
            end
            if type(a6) == "table" then
                local Match_1 = State_upv_1.Match
                local str_1 = tostring((Match_1 and (Match_1.mapId)) or (a6.mapId or ""))
                local v23
                if type(a6.holder) ~= "table" then
                    v23 = false
                else
                    v23 = a6.holder
                end
                tbl_upv_21[str_1] = v23
            end
        end
    )
    local u8 = false
    local function mapHolder(a7)
        --[[
          name: mapHolder
          line: 208
          upvalues:
            tbl_upv_21 (copy, index: 1)
            a1 (copy, index: 2)
            u8 (ref,  index: 3)
        ]]
        local str_2 = tostring(a7.mapId or "")
        local v24 = tbl_upv_21[str_2]
        if v24 ~= nil then
            return v24 or nil
        end
        local Tribes_2 = a1.Tribes and (a1.Tribes.CachedTerritories())
        local v25 = Tribes_2 and (Tribes_2.maps and (Tribes_2.maps[str_2]))
        if v25 then
            local v26
            if v25.holder then
                v26 = Tribes_2.tribes and (Tribes_2.tribes[tostring(v25.holder)])
            else
                v26 = nil
            end
            tbl_upv_21[str_2] = v26 or false
            return v26
        end
        if a1.Tribes and not (u8) then
            u8 = true
            task.spawn(
                function()
                    --[[
                      line: 223
                      upvalues:
                        a1 (copy, index: 1)
                        u8 (ref,  index: 2)
                    ]]
                    a1.Tribes.Territories(false)
                    u8 = false
                end
            )
        end
        return nil
    end
    local function score(a8)
        --[[
          name: score
          line: 231
        ]]
        return ((tonumber(a8.kills) or 0) * 100) + (tonumber(a8.damage) or 0) + ((tonumber(a8.assists) or 0) * 40)
    end
    local function paintRow(a9, a10, a11, a12, a13)
        --[[
          name: paintRow
          line: 235
          upvalues:
            State_upv_1 (copy, index: 1)
            Tribes_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Portraits_upv_1 (copy, index: 4)
            TribeEmblem_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            RankArt_upv_1 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u3 (ref,  index: 9)
            WeaponIcon_upv_1 (copy, index: 10)
        ]]
        local v27 = a10.id == State_upv_1.MyId()
        local v28 = (a13 ~= nil) and ((type(a10.tribe) == "table") and (a10.tribe.id == a13.id))
        a9.stripe.Visible = v28
        if v28 then
            a9.stripe.BackgroundColor3 = Tribes_upv_1.Color(a13.color1)
        end
        local v29 = a10.alive ~= false
        local v30 = a10.connected == false
        a9.frame.LayoutOrder = a12
        a9.stroke.Enabled = v27
        local v31 = a9.frame
        local v32
        if v27 then
            v32 = Colors_upv_1.AccentDeep
        else
            v32 = Colors_upv_1.Void
        end
        v31.BackgroundColor3 = v32
        a9.frame.BackgroundTransparency = (v27 and 0.4) or 0.45
        Portraits_upv_1.Apply(a9.img, a10, 60)
        local v33 = Portraits_upv_1.SetTint
        local img_1 = a9.img
        local v34
        if v29 then
            v34 = Color3.new(1, 1, 1)
        else
            v34 = Color3.fromRGB(110, 110, 120)
        end
        v33(img_1, v34, (v29 and 0) or 0.35)
        local v35 = ""
        if type(a10.tribe) == "table" and type(a10.tribe.tag) == "string" then
            v33 = string.format("<font color=\"#%s\">%s</font> ", TribeEmblem_upv_1.TagColor(a10.tribe.color1):ToHex(), TribeEmblem_upv_1.Tag(a10.tribe.tag))
        else
            v33 = v35
        end
        local name_1 = a9.name
        local str_3 = tostring(a10.name or "?")
        local v36 = (v27 and ("  " .. a1.Loc.T("(you)"))) or ""
        name_1.Text = v33 .. str_3 .. v36
        local name_2 = a9.name
        local v37
        if v30 then
            v37 = Colors_upv_1.TextMuted
        elseif v29 then
            v37 = Colors_upv_1.Text
        else
            v37 = Colors_upv_1.TextDim
        end
        name_2.TextColor3 = v37
        v33 = RankArt_upv_1.Ranks.RankOf(tonumber(a10.trophies) or 0)
        local v38 = string.format("<font color=\"#%s\">%s</font>", RankArt_upv_1.Color(v33):ToHex(), RankArt_upv_1.Ranks.Get(v33).name)
        local Rich_1 = a1.Loc.Rich
        local sub_1 = a9.sub
        local v39 = ("Lv %*  \194\183  "):format(tonumber(a10.level) or 1)
        Rich_1(sub_1, v39 .. v38 .. ((v30 and "  \194\183  left the match") or ((v29 and "") or "  \194\183  eliminated")))
        v33 = {tonumber(a10.kills) or 0, tonumber(a10.deaths) or 0, tonumber(a10.assists) or 0, tonumber(a10.damage) or 0}
        local v40 = nil
        local _ = nil
        local v46 = nil
        for key_4, v47 in a9.cells do
            if key_4 ~= 4 then
                v40 = tostring(v33[key_4])
            else
                v40 = UI_upv_1.FormatCompact(v33[key_4])
            end
            local v41
            v41.Text = v40
            local v42 = nil
            if v42 ~= 1 or not (v33[1] > 0) then
                if v29 then
                    v40 = Colors_upv_1.Text
                else
                    v40 = Colors_upv_1.TextDim
                end
                v41.TextColor3 = v40
            end
            if a11 then
                v40 = Colors_upv_1.Ally
            else
                v40 = Colors_upv_1.Enemy
            end
            v40 = v40:Lerp(Colors_upv_1.Text, 0.35)
            v41.TextColor3 = v40
        end
        if u3.gear > 0 then
            if type(a10.loadout) == "table" and type(a10.loadout.items) == "table" then
                v33 = a10.loadout.items
            else
                v31 = {}
            end
            if type(a10.loadout) == "table" and type(a10.loadout.armor) == "string" then
                v30 = a10.loadout.armor
            else
                v30 = nil
            end
            local v43 = table.concat(v33, ",") .. "|" .. tostring(v30)
            if v43 ~= a9.gearKey then
                a9.gearKey = v43
                for v48, value_5 in a9.gear:GetChildren() do
                    if value_5:IsA("GuiObject") then
                        value_5:Destroy()
                    end
                end
                local v44 = table.clone(v33)
                if v30 then
                    table.insert(v44, v30)
                end
                for key_5, value_6 in v44 do
                    if key_5 > 6 then
                        break
                    else
                        local v45 = UI_upv_1.new("Frame", {Name = "G" .. key_5, Size = UDim2.fromOffset(u3.gear, u3.gear), LayoutOrder = key_5, BackgroundColor3 = Colors_upv_1.Raised, BackgroundTransparency = 0.5, ZIndex = 41, [1] = UI_upv_1.Corner(8), Parent = a9.gear})
                        WeaponIcon_upv_1.Set(UI_upv_1.new("Frame", {ZIndex = 42, Name = "Icon", Size = UDim2.fromScale(1, 1), Parent = v45}), value_6, {glow = false})
                    end
                end
            end
        end
    end
    local function teamTribe(a14)
        --[[
          name: teamTribe
          line: 183
        ]]
        local tbl_22 = {}
        local v46 = nil
        local v47 = 0
        local v48
        if type(a14) == "table" and type(a14.members) == "table" then
            v48 = a14.members
        else
            v48 = {}
        end
        v46 = v46
        for _, value_7 in v48 do
            local tribe_1 = value_7.tribe
            if type(tribe_1) ~= "table" or type(tribe_1.id) ~= "number" then
                continue
            end
            tbl_22[tribe_1.id] = (tbl_22[tribe_1.id] or 0) + 1
            if not (tbl_22[tribe_1.id] >= 2) then
                continue
            end
            if v47 < tbl_22[tribe_1.id] then
                v47, v46 = tbl_22[tribe_1.id], tribe_1
            end
        end
        return v46, v47
    end
    local function layout()
        --[[
          name: layout
          line: 390
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
            for key_6, value_8 in tbl_upv_10 do
                value_8.frame:Destroy()
                tbl_upv_10[key_6] = nil
            end
        end
        u2.Size = UDim2.fromOffset(math.clamp(UI_upv_1.CanvasSize().X - 24, math.min(u3.width, 240), u3.width), 0)
        local Compact_1 = UI_upv_1.Compact
        local v49 = u2:FindFirstChildOfClass("UIPadding")
        if v49 then
            v49.PaddingTop = UDim.new(0, (Compact_1 and 10) or 14)
            v49.PaddingBottom = UDim.new(0, (Compact_1 and 10) or 16)
        end
        local v50 = u2:FindFirstChildOfClass("UIListLayout")
        if v50 then
            v50.Padding = UDim.new(0, (Compact_1 and 6) or 10)
        end
        u4.Size = UDim2.new(1, 0, 0, (Compact_1 and 50) or 60)
        u6.Position = UDim2.new(0.5, 0, 0, (Compact_1 and 4) or 8)
        u7.Position = UDim2.new(0.5, 0, 0, (Compact_1 and 30) or 36)
        placeColumns()
    end
    local u9 = false
    local u10 = false
    local u11 = nil
    local function allowed()
        --[[
          name: allowed
          line: 422
          upvalues:
            State_upv_1 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            MenuManager_upv_1 (copy, index: 3)
        ]]
        local v51 = State_upv_1.SeesMatch() and ((State_upv_1.Phase() ~= "MatchEnd") and ((LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true) and (MenuManager_upv_1.Current() == nil)))
        return v51
    end
    local function paint()
        --[[
          name: paint
          line: 294
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
        ]]
        local Match_2 = State_upv_1.Match
        if not Match_2 or type(Match_2.teams) ~= "table" then
            return
        end
        local v52 = State_upv_1.MyTeam()
        local tbl_23 = {}
        tbl_23[1], tbl_23[2] = v52, ((v52 ~= 1) and 1) or 2
        local tbl_24 = {}
        local tbl_25 = {}
        local tbl_26 = {{}, {}}
        local v53 = nil
        for _, value_9 in tbl_23 do
            local v54, v55 = teamTribe(Match_2.teams[value_9])
            if v54 then
                v53 = {}
                v53.tribe = v54
                v53.n = v55
            else
                v53 = nil
            end
            local v56
            tbl_25[v56] = v53
            for v77, value_10 in ((Match_2.teams[value_9]) and (Match_2.teams[value_9].members)) or {} do
                if type(value_10.tribe) ~= "table" then
                    continue
                end
                if type(value_10.tribe.id) == "number" then
                    tbl_26[v56][value_10.tribe.id] = true
                end
            end
        end
        local v57 = (tbl_25[1] ~= nil) and ((tbl_25[2] ~= nil) and (tbl_25[1].tribe.id ~= tbl_25[2].tribe.id))
        u4.Visible = v57
        local v58 = u2:FindFirstChildOfClass("UIStroke")
        local v59
        if v57 then
            v59 = Color3.fromRGB(255, 196, 80)
        else
            v59 = Colors_upv_1.Stroke
        end
        v58.Color = v59
        local v60 = u2:FindFirstChildOfClass("UIStroke")
        v60.Transparency = (v57 and 0.45) or 0.85
        local v61 = nil
        if v57 then
            for n_1 = 1, 2 do
                local tribe_2 = tbl_25[n_1].tribe
                tbl_upv_6[n_1]:Set(tribe_2.icon, tribe_2.color1, tribe_2.color2, tribe_2.tag)
                tbl_upv_8[n_1].Text = TribeEmblem_upv_1.Tag(tribe_2.tag)
            end
            u5.Color = ColorSequence.new(Tribes_upv_1.Color(tbl_25[1].tribe.color1):Lerp(Colors_upv_1.Panel, 0.55), Tribes_upv_1.Color(tbl_25[2].tribe.color1):Lerp(Colors_upv_1.Panel, 0.55))
            local v62 = string.upper(tostring(Match_2.mapName or "this map"))
            v61 = mapHolder(Match_2)
            if v61 and (v61.id == tbl_25[1].tribe.id or v61.id == tbl_25[2].tribe.id) then
                u7.Text = ("%* DEFENDS %*"):format(TribeEmblem_upv_1.Tag(v61.tag), v62)
            elseif v61 then
                u7.Text = ("%*  \194\183  HELD BY %*"):format(v62, TribeEmblem_upv_1.Tag(v61.tag))
            else
                u7.Text = ("GLORY DECIDES WHO HOLDS %*"):format(v62)
            end
        end
        local v63, v64 = nil, nil
        local v65 = nil
        local _ = nil
        local v66 = nil
        for key_7, value_11 in tbl_23 do
            local v67 = Match_2.teams[value_11]
            local v68 = tbl_upv_9[key_7]
            local v69 = value_11 == v52
            if v69 then
                v63 = Colors_upv_1.Ally
            else
                v63 = Colors_upv_1.Enemy
            end
            local v70 = tbl_25[key_7]
            v68.bar.BackgroundColor3 = v63
            v68.scorePill.BackgroundColor3 = v63
            local score_2 = v68.score
            score_2.Text = tostring((v67 and (v67.score)) or 0)
            v68.crestHolder.Visible = v70 ~= nil
            if v70 then
                local tribe_3 = v70.tribe
                v68.crest:Set(tribe_3.icon, tribe_3.color1, tribe_3.color2, tribe_3.tag)
                v68.title.Text = string.format("<font color=\"#%s\">%s</font>  %s", TribeEmblem_upv_1.TagColor(tribe_3.color1):ToHex(), TribeEmblem_upv_1.Tag(tribe_3.tag), string.upper(tostring(tribe_3.name or "")))
                v68.title.TextColor3 = Colors_upv_1.Text
                local v71 = tbl_26[3 - key_7][tribe_3.id] == true
                v68.chip.Visible = true
                local chipText_1 = v68.chipText
                if v71 then
                    v65 = "SPLIT  \194\183  NO GLORY"
                else
                    v65 = string.format("\195\151%s GLORY", tostring(Tribes_upv_1.STACK_MULT[math.clamp(v70.n, 1, 3)]))
                end
                chipText_1.Text = v65
                local chipText_2 = v68.chipText
                if v71 then
                    v65 = Colors_upv_1.TextDim
                else
                    v65 = Color3.fromRGB(255, 196, 80)
                end
                chipText_2.TextColor3 = v65
                v68.chip.BackgroundTransparency = (v71 and 0.9) or 0.82
            else
                local title_1 = v68.title
                title_1.Text = a1.Loc.T(string.upper(tostring((v67 and (v67.name)) or ((v69 and "Your team") or "Enemies"))))
                v68.title.TextColor3 = v63:Lerp(Colors_upv_1.Text, 0.25)
                v68.chip.Visible = false
            end
            local v72 = table.clone((v67 and (v67.members)) or {})
            table.sort(
                v72,
                function(a15, a16)
                    --[[
                      line: 362
                    ]]
                    local v73 = ((tonumber(a15.kills) or 0) * 100) + (tonumber(a15.damage) or 0) + (tonumber(a15.assists) or 0) * 40
                    local v74 = ((tonumber(a16.kills) or 0) * 100) + (tonumber(a16.damage) or 0) + (tonumber(a16.assists) or 0) * 40
                    if v73 ~= v74 then
                        return v74 < v73
                    end
                    local v75 = tostring(a15.name) < tostring(a16.name)
                    return v75
                end
            )
            for key_8, value_12 in v72 do
                if type(value_12) ~= "table" or type(value_12.id) ~= "string" then
                    continue
                end
                tbl_24[value_12.id] = true
                v66 = tbl_upv_10[value_12.id]
                if v66 then
                    v63 = v66
                else
                    local v76 = makeRow(value_12.id)
                    tbl_upv_10[value_12.id] = v76
                    v63 = v76
                end
                v63.frame.Parent = v68.list
                if tbl_25[key_7] then
                    v64 = tbl_25[key_7].tribe
                else
                    v64 = nil
                end
                paintRow(v63, value_12, v69, key_8, v64)
            end
        end
        for key_9, value_13 in tbl_upv_10 do
            if not (tbl_24[key_9]) then
                value_13.frame:Destroy()
                tbl_upv_10[key_9] = nil
            end
        end
    end
    local function update()
        --[[
          name: update
          line: 428
          upvalues:
            u11 (ref,  index: 1)
            u9 (ref,  index: 2)
            u10 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            MenuManager_upv_1 (copy, index: 6)
            u2 (copy, index: 7)
            layout (copy, index: 8)
            paint (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            tbl_upv_4 (copy, index: 11)
        ]]
        local v77
        if u11 == nil then
            v77 = u9 or u10
        else
            v77 = u11
        end
        local v78
        if v77 then
            local v79 = true
            if u11 == true then
                v78 = v79
            else
                v78 = State_upv_1.SeesMatch() and ((State_upv_1.Phase() ~= "MatchEnd") and ((LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true) and (MenuManager_upv_1.Current() == nil)))
            end
        else
            v78 = v77
        end
        if not (v78) then
            local v80 = State_upv_1.SeesMatch() and State_upv_1.Phase() ~= "MatchEnd" and LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true and MenuManager_upv_1.Current() == nil
            local v81
            if v80 then
                v81 = u10
            else
                v81 = false
            end
            u10 = v81
        end
        if not (v78) or u2.Visible then
            if v78 then
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
        tbl_upv_4.Visible = u2.Visible and u10
        if not tbl_upv_4.Visible then
            return
        end
        task.defer(
            function()
                --[[
                  line: 447
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    tbl_upv_4 (copy, index: 2)
                    u2 (copy, index: 3)
                ]]
                local v82 = math.max(UI_upv_1.Scale, 0.01)
                tbl_upv_4.Position = u2.Position
                tbl_upv_4.Size = UDim2.fromOffset(u2.AbsoluteSize.X / v82, u2.AbsoluteSize.Y / v82)
            end
        )
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a17, a18)
            --[[
              line: 455
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
                Keybinds_upv_1 (copy, index: 2)
                State_upv_1 (copy, index: 3)
                u9 (ref,  index: 4)
                update (copy, index: 5)
            ]]
            if UserInputService_upv_1:GetFocusedTextBox() then
                return
            end
            local v83 = Keybinds_upv_1.ActionOf(a17) == "Scoreboard"
            if not (v83) or a18 then
                if Keybinds_upv_1.IsPad(a17, "Scoreboard") and State_upv_1.SeesMatch() then
                    local v84 = Keybinds_upv_1.PadBlocked()
                    if not (v84) then
                        u9 = true
                        update()
                    end
                end
                return
            end
            u9 = true
            update()
        end
    )
    Keybinds_upv_1.OnInput(
        "Ended",
        function(a19)
            --[[
              line: 466
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
                u9 (ref,  index: 2)
                update (copy, index: 3)
            ]]
            if Keybinds_upv_1.ActionOf(a19) ~= "Scoreboard" and not Keybinds_upv_1.IsPad(a19, "Scoreboard") then
                return
            end
            u9 = false
            update()
        end
    )
    local function hookScoreboard()
        --[[
          name: hookScoreboard
          line: 473
          upvalues:
            a1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u10 (ref,  index: 3)
            update (copy, index: 4)
        ]]
        local Scoreboard_1 = a1.Scoreboard
        if not Scoreboard_1 or (Scoreboard_1:FindFirstChild("TabListOpen")) then
            return
        end
        local tbl_27 = {Name = "TabListOpen", ZIndex = 30, Selectable = false, Text = "", AutoButtonColor = false}
        tbl_27.Size = UDim2.fromScale(1, 1)
        tbl_27.Parent = Scoreboard_1
        UI_upv_1.new("TextButton", tbl_27).Activated:Connect(
            function()
                --[[
                  line: 479
                  upvalues:
                    u10 (ref,  index: 1)
                    update (copy, index: 2)
                ]]
                u10 = not u10
                update()
            end
        )
    end
    hookScoreboard()
    tbl_upv_4.Activated:Connect(
        function()
            --[[
              line: 485
              upvalues:
                u10 (ref,  index: 1)
                update (copy, index: 2)
            ]]
            if not u10 then
                return
            end
            u10 = false
            update()
        end
    )
    State_upv_1.MatchChanged:Connect(
        function()
            --[[
              line: 492
              upvalues:
                hookScoreboard (copy, index: 1)
                u2 (copy, index: 2)
                u9 (ref,  index: 3)
                u10 (ref,  index: 4)
                update (copy, index: 5)
            ]]
            hookScoreboard()
            if not u2.Visible and not u9 and not u10 then
                return
            end
            update()
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function()
            --[[
              line: 498
              upvalues:
                u9 (ref,  index: 1)
                u10 (ref,  index: 2)
                update (copy, index: 3)
            ]]
            u9 = false
            u10 = false
            update()
        end
    )
    State_upv_1.WatchChanged:Connect(
        function()
            --[[
              line: 502
              upvalues:
                u9 (ref,  index: 1)
                u10 (ref,  index: 2)
                update (copy, index: 3)
            ]]
            u9 = false
            u10 = false
            update()
        end
    )
    MenuManager_upv_1.Changed:Connect(
        function()
            --[[
              line: 506
              upvalues:
                update (copy, index: 1)
            ]]
            update()
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("ReplayPlaying"):Connect(update)
    UI_upv_1.OnResize(
        function()
            --[[
              line: 510
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
              line: 515
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
    a1.Debug.tablist = function(a20)
        --[[
          line: 523
          upvalues:
            u11 (ref,  index: 1)
            update (copy, index: 2)
            u2 (copy, index: 3)
        ]]
        local v85
        if a20 ~= nil then
            v85 = a20 == true
        else
            v85 = nil
        end
        u11 = v85
        update()
        local tbl_28 = {}
        tbl_28.visible = u2.Visible
        tbl_28.rows = #u2:GetDescendants()
        return tbl_28
    end
end
return tbl_1