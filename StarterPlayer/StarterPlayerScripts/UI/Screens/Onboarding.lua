local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local tbl_1 = {}
local tbl_upv_2 = {{id = "Classic", chip = "NOW"}, {id = "Pitch", chip = "A"}, {id = "Builds", chip = "B"}, {id = "Briefing", chip = "C"}}
local fromRGB_1 = Color3.fromRGB
local tbl_upv_3 = {}
tbl_upv_3.bow = fromRGB_1(56, 189, 248)
tbl_upv_3.gun = fromRGB_1(251, 146, 60)
tbl_upv_3.melee = fromRGB_1(248, 113, 113)
tbl_upv_3.throwable = fromRGB_1(167, 139, 250)
tbl_upv_3.utility = fromRGB_1(250, 204, 21)
tbl_upv_3.healing = fromRGB_1(74, 222, 128)
tbl_upv_3.armor = fromRGB_1(148, 197, 255)
local tbl_upv_4 = {}
tbl_upv_4["bronze_sword,short_bow,bandage|hide_armor"] = {name = "ALL-ROUNDER", line = "Sword, bow and armor.\nReady for anything."}
tbl_upv_4["short_bow,throwing_knives,smoke_bomb,bandage|hide_armor"] = {name = "ARCHER", line = "Bow, knives and armor.\nFight from range."}
tbl_upv_4["war_club,short_bow,smoke_bomb,bandage|hide_armor"] = {name = "BRAWLER", line = "Hammer, bow and armor.\nWin up close."}
tbl_upv_4["bronze_sword,throwing_knives,sling,bandage,smoke_bomb|hide_armor"] = {name = "DUELIST", line = "Sword, knives and smoke.\nOutplay them."}
tbl_upv_4["short_bow,war_club,bandage|hide_armor"] = {name = "HUNTER", line = "Bow and hammer.\nHit hard at any range."}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 86
      upvalues:
        Players_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
        tbl_upv_4 (copy, index: 5)
        tbl_upv_2 (copy, index: 6)
        TweenService_upv_1 (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local MenuManager_upv_1 = a1.MenuManager
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Portraits_upv_1 = a1.Portraits
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local LobbyHud_upv_1 = a1.LobbyHud
    if not LobbyHud_upv_1 then
        return
    end
    local PlayButton_upv_1 = LobbyHud_upv_1.PlayButton
    local Config_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Config"))
    local tbl_upv_5 = {}
    local function report(a2, a3)
        --[[
          name: report
          line: 100
          upvalues:
            tbl_upv_5 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        local v1 = ((type(a3) ~= "string") and "") or (":" .. a3)
        local v2 = a2 .. v1
        if (tbl_upv_5[v2]) or (State_upv_1.Mock) then
            return
        end
        if a1.Remotes.Fire("AnalyticsReport", a2, a3) then
            tbl_upv_5[v2] = true
        end
    end
    local function loadingDone()
        --[[
          name: loadingDone
          line: 110
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
        ]]
        local v3 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
        return v3
    end
    local function lobbyShown()
        --[[
          name: lobbyShown
          line: 114
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            LobbyHud_upv_1 (copy, index: 3)
        ]]
        local v4 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
        if v4 then
            v4 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
        end
        return v4
    end
    MenuManager_upv_1.Changed:Connect(
        function(a4)
            --[[
              line: 118
              upvalues:
                State_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                tbl_upv_5 (copy, index: 3)
                a1 (copy, index: 4)
            ]]
            if not a4 or a4 == "Welcome" then
                return
            end
            if not (State_upv_1.InMatch()) then
                local v5 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
                if not v5 or (tbl_upv_5.Menu) or State_upv_1.Mock or not a1.Remotes.Fire("AnalyticsReport", "Menu", nil) then
                    return
                end
                tbl_upv_5.Menu = true
            end
        end
    )
    local v6 = RunService_upv_1:IsStudio() or (game.PlaceId == Config_1.STAGING_PLACE_ID)
    local u1
    u1 = "Builds"
    local u2 = UI_upv_1.new("Frame", {Visible = false, Name = "Welcome", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Menus})
    local u3 = UI_upv_1.new("Frame", {Visible = false, Name = "WelcomeDim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = a1.Canvas.Backdrop})
    local u4 = UI_upv_1.new("Frame", {Name = "Card", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(560, 360), Parent = u2})
    local u5 = UI_upv_1.new("UIScale", {Parent = u4})
    UI_upv_1.DropShadow(u4, 18, 8, 0.45)
    local u6 = UI_upv_1.Panel({StrokeThickness = 1.5, Name = "Panel", StrokeTransparency = 0.55, BackgroundTransparency = 0.04, Size = UDim2.fromScale(1, 1), StrokeColor = Colors_upv_1.Accent, Radius = UDim.new(0, 18), Parent = u4})
    local u7 = nil
    local u8 = nil
    local u9 = false
    local u10 = 0
    local u11 = false
    local u12 = false
    local u13 = false
    local u14 = 0
    local u15 = false
    local u16 = 0
    local u17 = nil
    local function stepAside(a5)
        --[[
          name: stepAside
          line: 172
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.SetHudHidden("Welcome", a5)
        if not a1.TopbarSettings then
            return
        end
        a1.TopbarSettings.SetHidden("Welcome", a5)
    end
    local function closeCard(a6)
        --[[
          name: closeCard
          line: 179
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        if not MenuManager_upv_1.IsOpen("Welcome") then
            return
        end
        MenuManager_upv_1.Close("Welcome", a6)
    end
    local function fight()
        --[[
          name: fight
          line: 185
          upvalues:
            u13 (ref,  index: 1)
            u11 (ref,  index: 2)
            u12 (ref,  index: 3)
            u15 (ref,  index: 4)
            a1 (copy, index: 5)
            u7 (ref,  index: 6)
            MenuManager_upv_1 (copy, index: 7)
        ]]
        if (u13) or not u11 then
            return
        end
        u13 = true
        u12 = true
        u15 = false
        a1.Sounds.Play("Queue_Join")
        u7.fight:SetText("STARTING\226\128\166")
        task.spawn(
            function()
                --[[
                  line: 192
                  upvalues:
                    u7 (ref,  index: 1)
                    a1 (copy, index: 2)
                    u13 (ref,  index: 3)
                    MenuManager_upv_1 (copy, index: 4)
                    u12 (ref,  index: 5)
                ]]
                local v7 = os.clock()
                while u7 and (u7.selecting) do
                    if os.clock() - v7 < 1.5 then
                        task.wait()
                        continue
                    else
                        break
                    end
                end
                local v8 = a1.QueueAction("FirstMatch")
                u13 = false
                if v8 then
                    if not MenuManager_upv_1.IsOpen("Welcome") then
                        return
                    end
                    MenuManager_upv_1.Close("Welcome", nil)
                else
                    u12 = false
                    if not u7 then
                        return
                    end
                    u7.fight:SetText("FIGHT")
                end
            end
        )
    end
    local function explore()
        --[[
          name: explore
          line: 210
          upvalues:
            u13 (ref,  index: 1)
            u11 (ref,  index: 2)
            u12 (ref,  index: 3)
            u15 (ref,  index: 4)
            a1 (copy, index: 5)
            MenuManager_upv_1 (copy, index: 6)
        ]]
        if (u13) or not u11 then
            return
        end
        u12 = true
        u15 = false
        a1.Sounds.Play("Click")
        if MenuManager_upv_1.IsOpen("Welcome") then
            MenuManager_upv_1.Close("Welcome", nil)
        end
        task.spawn(a1.QueueAction, "Explore")
    end
    local function customize()
        --[[
          name: customize
          line: 219
          upvalues:
            u13 (ref,  index: 1)
            u11 (ref,  index: 2)
            u15 (ref,  index: 3)
            u16 (ref,  index: 4)
            MenuManager_upv_1 (copy, index: 5)
        ]]
        if (u13) or not u11 then
            return
        end
        u15 = true
        u16 = 0
        MenuManager_upv_1.Open("Loadout")
        if not (MenuManager_upv_1.IsOpen("Loadout")) then
            u15 = false
        end
    end
    local function px(a7, a8)
        --[[
          name: px
          line: 232
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return a8
        end
        return a7
    end
    local function heading(a9, a10, a11, a12, a13, a14)
        --[[
          name: heading
          line: 255
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local new_1 = UI_upv_1.new
        local tbl_6 = {Name = "Overline", TextColor3 = 0, Parent = 0, TextSize = 0}
        tbl_6.Size = UDim2.fromScale(1, 1)
        tbl_6.Text = a10
        tbl_6.FontFace = Fonts_upv_1.Heavy
        tbl_6.TextSize = ((UI_upv_1.Compact) and 18) or 16
        tbl_6.TextColor3 = Colors_upv_1.Accent
        tbl_6.Parent = a9.row(((UI_upv_1.Compact) and 20) or 18)
        new_1("TextLabel", tbl_6)
        UI_upv_1.new("TextLabel", {Name = "Title", Size = UDim2.fromScale(1, 1), Text = a11, FontFace = Fonts_upv_1.Display, TextSize = a12, TextColor3 = Colors_upv_1.Text, Parent = a9.row(a12 + 4, 6)})
        if a13 then
            local v9 = ((UI_upv_1.Compact) and 21) or 19
            UI_upv_1.new("TextLabel", {TextWrapped = true, Name = "Blurb", Size = UDim2.fromScale(1, 1), Text = a13, FontFace = Fonts_upv_1.Medium, TextSize = v9, TextColor3 = Colors_upv_1.TextDim, Parent = a9.row(math.ceil((v9 * 1.3) * (a14 or 1)), 6)})
        end
    end
    local function customizeButton(a15)
        --[[
          name: customizeButton
          line: 305
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            customize (copy, index: 3)
        ]]
        local v10 = UI_upv_1.Button({Radius = 14, Text = "CUSTOMIZE", Name = "Customize", Style = "Dark", TextSize = a15.TextSize, AnchorPoint = a15.AnchorPoint, Position = a15.Position, Size = a15.Size, Icon = UI_upv_1.Icon("pencil", math.floor(a15.TextSize * 0.95), Colors_upv_1.Text), Parent = a15.Parent})
        v10.Activated:Connect(customize)
        return v10
    end
    local function fightButton(a16)
        --[[
          name: fightButton
          line: 289
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        return UI_upv_1.Button({Radius = 16, Text = "FIGHT", Sound = false, Name = "Fight", Style = "Primary", TextSize = a16.TextSize, AnchorPoint = a16.AnchorPoint, Position = a16.Position, Size = a16.Size, Icon = UI_upv_1.Image(UI_upv_1.Assets.Icons.CrossedArrows, {Size = UDim2.fromOffset(36, 34), ImageColor3 = Colors_upv_1.Text}), LayoutOrder = a16.LayoutOrder, Parent = a16.Parent})
    end
    local function exploreLink(a17)
        --[[
          name: exploreLink
          line: 321
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            explore (copy, index: 5)
        ]]
        local u18 = UI_upv_1.new("TextButton", {Name = "Explore", Text = "Explore the lobby first", BackgroundTransparency = 1, AutoButtonColor = false, FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim})
        for key_1, value_1 in a17 do
            u18[key_1] = value_1
        end
        u18.MouseEnter:Connect(
            function()
                --[[
                  line: 333
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u18 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Colors_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(u18, Theme_upv_1.Tween.Fast, {TextColor3 = Colors_upv_1.Text})
            end
        )
        u18.MouseLeave:Connect(
            function()
                --[[
                  line: 336
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    u18 (copy, index: 2)
                    Theme_upv_1 (copy, index: 3)
                    Colors_upv_1 (copy, index: 4)
                ]]
                UI_upv_1.Tween(u18, Theme_upv_1.Tween.Fast, {TextColor3 = Colors_upv_1.TextDim})
            end
        )
        u18.Activated:Connect(explore)
        if UI_upv_1.Touch then
            local tbl_7 = {Name = "Hit", Selectable = false, Text = "", BackgroundTransparency = 1, AutoButtonColor = false}
            tbl_7.Size = UDim2.new(1, 0, 0, math.ceil(46 / math.max(UI_upv_1.Scale, 0.1)))
            tbl_7.Parent = u18
            UI_upv_1.new("TextButton", tbl_7).Activated:Connect(explore)
        end
        return u18
    end
    local function kitOf(a18)
        --[[
          name: kitOf
          line: 373
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v11 = WeaponInfo_upv_1.Normalize(a18)
        local tbl_8 = {}
        for _, value_2 in v11.items do
            local v12 = WeaponInfo_upv_1.Get(value_2)
            if v12 then
                table.insert(tbl_8, {icon = value_2, name = v12.name, points = v12.points, cat = v12.category})
            end
        end
        if v11.armor then
            local v13 = WeaponInfo_upv_1.Get(v11.armor)
            if v13 then
                table.insert(tbl_8, {cat = "armor", icon = v11.armor, name = v13.name, points = v13.points})
            end
        end
        for _, value_3 in WeaponInfo_upv_1.AmmoTypes() do
            local v14 = v11.ammo[value_3.id] or 0
            if v14 > 0 then
                local tbl_9 = {cat = 0}
                tbl_9.icon = "ammo_" .. value_3.id
                tbl_9.name = value_3.name
                tbl_9.points = v14 * value_3.points
                tbl_9.cat = ((value_3.id ~= "arrows") and "gun") or "bow"
                table.insert(tbl_8, tbl_9)
            end
        end
        return tbl_8, WeaponInfo_upv_1.Cost(v11)
    end
    local function buildKey(a19)
        --[[
          name: buildKey
          line: 396
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v15 = WeaponInfo_upv_1.Normalize(a19)
        return table.concat(v15.items, ",") .. "|" .. (v15.armor or "")
    end
    local function tintGradient(a20, a21, a22)
        --[[
          name: tintGradient
          line: 409
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        UI_upv_1.Gradient(a21:Lerp(Colors_upv_1.Panel, 1 - a22), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115).Parent = a20
    end
    local function itemTile(a23, a24, a25, a26, a27)
        --[[
          name: itemTile
          line: 413
          upvalues:
            UI_upv_1 (copy, index: 1)
            tbl_upv_3 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            WeaponIcon_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local v16 = UI_upv_1.new("Frame", {Name = "Tile", Size = UDim2.fromOffset(a25, a25), BackgroundColor3 = Color3.new(1, 1, 1), LayoutOrder = a27 or 0, [1] = UI_upv_1.Corner(math.max(6, math.floor(a25 * 0.15))), Parent = a23})
        UI_upv_1.Gradient((tbl_upv_3[a24.cat] or (Colors_upv_1.Accent)):Lerp(Colors_upv_1.Panel, 0.6799999999999999), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115).Parent = v16
        UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.88).Parent = v16
        local v17 = UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Parent = v16})
        WeaponIcon_upv_1.Set(v17, a24.icon, {outline = false, glow = false})
        local v18 = nil
        if a26 then
            local v19 = math.max(18, math.floor(a25 * 0.27))
            v18 = UI_upv_1.new("TextLabel", {Name = "Cost", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 4), Size = UDim2.fromOffset(v19, v19), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.2, Text = tostring(a24.points), FontFace = Fonts_upv_1.Heavy, TextSize = math.floor(v19 * 0.66), TextColor3 = Colors_upv_1.Text, ZIndex = 3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v16})
        end
        return v16, v17, v18
    end
    local function pointsReadout(a28, a29, a30, a31)
        --[[
          name: pointsReadout
          line: 490
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local tbl_10 = {}
        tbl_10.Name = "Points"
        tbl_10.AnchorPoint = a29.AnchorPoint
        tbl_10.Position = a29.Position
        tbl_10.Size = a29.Size
        tbl_10[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
        tbl_10.Parent = a28
        local v21 = UI_upv_1.new("Frame", tbl_10)
        local v22 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Text = "", Name = "Num", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Heavy, TextSize = a30, TextColor3 = Colors_upv_1.Text, Parent = v21})
        UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "POINTS", Name = "Word", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Heavy, TextSize = a31, TextColor3 = Colors_upv_1.TextMuted, Parent = v21})
        return v22
    end
    local tbl_upv_11 = {}
    function tbl_upv_11.Classic(a32)
        --[[
          name: Classic
          line: 563
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            fightButton (copy, index: 4)
            exploreLink (copy, index: 5)
            u17 (ref,  index: 6)
            u5 (copy, index: 7)
        ]]
        local Compact_1 = UI_upv_1.Compact
        local u19 = (Compact_1 and 6) or 20
        UI_upv_1.Padding(28, 34, u19, 34).Parent = a32
        local u20 = UI_upv_1.new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), Parent = a32})
        local new_2 = UI_upv_1.new
        local tbl_12 = {LayoutOrder = 1, Name = "Overline", TextColor3 = 0, Parent = 0, Text = "WELCOME TO TRIBES", TextSize = 0}
        tbl_12.Size = UDim2.new(1, 0, 0, 18)
        tbl_12.FontFace = Fonts_upv_1.Heavy
        tbl_12.TextSize = (Compact_1 and 18) or 16
        tbl_12.TextColor3 = Colors_upv_1.Accent
        tbl_12.Parent = a32
        new_2("TextLabel", tbl_12)
        local new_3 = UI_upv_1.new
        local tbl_13 = {LayoutOrder = 2, FontFace = 0, Name = "Title", TextColor3 = 0, Parent = 0, Text = "READY TO FIGHT?", TextSize = 0, Size = 0}
        tbl_13.Size = UDim2.new(1, 0, 0, (Compact_1 and 52) or 48)
        tbl_13.FontFace = Fonts_upv_1.Display
        tbl_13.TextSize = (Compact_1 and 48) or 46
        tbl_13.TextColor3 = Colors_upv_1.Text
        tbl_13.Parent = a32
        new_3("TextLabel", tbl_13)
        local new_4 = UI_upv_1.new
        local tbl_14 = {LayoutOrder = 3, TextColor3 = 0, Parent = 0, Text = "Team up 3v3 with bows, swords and spears.\nLast tribe standing wins the round.", Name = "Blurb", TextWrapped = true, TextSize = 0}
        tbl_14.Size = UDim2.new(1, 0, 0, 0)
        tbl_14.AutomaticSize = Enum.AutomaticSize.Y
        tbl_14.FontFace = Fonts_upv_1.Medium
        tbl_14.TextSize = (Compact_1 and 21) or 19
        tbl_14.TextColor3 = Colors_upv_1.TextDim
        tbl_14.Parent = a32
        new_4("TextLabel", tbl_14)
        UI_upv_1.new("Frame", {LayoutOrder = 4, Name = "Gap", Size = UDim2.new(1, 0, 0, 10), Parent = a32})
        local tbl_15 = {LayoutOrder = 5, Parent = 0, TextSize = 0, Size = 0}
        tbl_15.Size = UDim2.new(1, 0, 0, (Compact_1 and 88) or 84)
        tbl_15.TextSize = (Compact_1 and 46) or 44
        tbl_15.Parent = a32
        local v23 = fightButton(tbl_15)
        local tbl_16 = {LayoutOrder = 6, Parent = 0, TextSize = 0, Size = 0}
        tbl_16.Size = UDim2.new(1, 0, 0, (Compact_1 and 80) or 44)
        tbl_16.TextSize = (Compact_1 and 21) or 18
        tbl_16.Parent = a32
        exploreLink(tbl_16)
        u20:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                --[[
                  line: 619
                  upvalues:
                    u17 (ref, index: 1)
                ]]
                task.defer(u17)
            end
        )
        local tbl_17 = {fight = 0, measure = 0, width = 0}
        tbl_17.width = (Compact_1 and 600) or 560
        tbl_17.fight = v23
        function tbl_17.measure()
            --[[
              name: measure
              line: 626
              upvalues:
                UI_upv_1 (copy, index: 1)
                u5 (copy, index: 2)
                u20 (copy, index: 3)
                u19 (copy, index: 4)
            ]]
            local v24 = u20.AbsoluteContentSize.Y / math.max(UI_upv_1.Scale * u5.Scale, 0.01)
            local v25
            if v24 > 50 then
                v25 = v24
            else
                v25 = 300
            end
            return (math.ceil((v25 + 28) + u19))
        end
        return tbl_17
    end
    local function loadoutSig(a33)
        --[[
          name: loadoutSig
          line: 400
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v26 = WeaponInfo_upv_1.Normalize(a33)
        local v27 = WeaponInfo_upv_1.Normalize(v26)
        local tbl_18 = {table.concat(v27.items, ",") .. "|" .. (v27.armor or "")}
        for _, value_4 in WeaponInfo_upv_1.AmmoTypes() do
            table.insert(tbl_18, (tostring(v26.ammo[value_4.id] or 0)))
        end
        return table.concat(tbl_18, "|")
    end
    local function pointsMeter(a34, a35, a36, a37)
        --[[
          name: pointsMeter
          line: 525
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
        ]]
        local v28 = math.max(WeaponInfo_upv_1.Budget(), 1)
        local v29 = math.floor((a35 - ((v28 - 1) * 3)) / v28)
        local v30 = UI_upv_1.new("Frame", {Name = "Meter", Position = a37, Size = UDim2.fromOffset(a35, a36), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = a34})
        local tbl_upv_19 = {}
        for n_1 = 1, v28 do
            tbl_upv_19[n_1] = UI_upv_1.new("Frame", {Name = "P" .. n_1, Size = UDim2.fromOffset(v29, a36), BackgroundColor3 = Colors_upv_1.Raised, LayoutOrder = n_1, [1] = UI_upv_1.Corner(3), Parent = v30})
        end
        return function(a38, a39)
            --[[
              line: 547
              upvalues:
                tbl_upv_19 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
                UI_upv_1 (copy, index: 3)
                Theme_upv_1 (copy, index: 4)
            ]]
            local v31 = nil
            for key_2, value_5 in tbl_upv_19 do
                if key_2 <= a38 then
                    v31 = Colors_upv_1.Accent
                else
                    v31 = Colors_upv_1.Raised
                end
                if a39 then
                    value_5.BackgroundColor3 = v31
                else
                    UI_upv_1.Tween(value_5, Theme_upv_1.Tween.Fast, {BackgroundColor3 = v31})
                end
            end
        end
    end
    local function kitStrip(a40, a41, a42, a43, a44)
        --[[
          name: kitStrip
          line: 455
          upvalues:
            UI_upv_1 (copy, index: 1)
            itemTile (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local v32 = math.max(#a41, 1)
        local v33 = math.min(a43, math.floor((a42 - ((v32 - 1) * 10)) / v32))
        local v34 = a43 - 14 <= v33
        local v35 = a44 + 6
        local v36
        if v34 then
            v36 = v35 + 4
        else
            v36 = 0
        end
        local v37 = v33 + v36
        local v38 = UI_upv_1.new("Frame", {Name = "Kit", Size = UDim2.fromOffset(a42, v37), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top), Parent = a40})
        local tbl_20 = {}
        for key_3, value_6 in a41 do
            local v39 = UI_upv_1.new("Frame", {Name = "Item" .. key_3, Size = UDim2.fromOffset(v33, v37), LayoutOrder = key_3, Parent = v38})
            local _, v40, v41 = itemTile(v39, value_6, v33, true)
            if v34 then
                UI_upv_1.new("TextLabel", {Name = "Name", Position = UDim2.fromOffset(-4, v33 + 4), Size = UDim2.fromOffset(v33 + 8, v35), Text = value_6.name, FontFace = Fonts_upv_1.Bold, TextSize = a44, TextColor3 = Colors_upv_1.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v39})
            end
            tbl_20[key_3] = {icon = v40, cost = v41, points = value_6.points}
        end
        return v38, tbl_20, v37
    end
    local function stacker(a45, a46, a47, a48)
        --[[
          name: stacker
          line: 237
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        local u21 = a48
        local tbl_21 = {}
        function tbl_21.row(a49, a50)
            --[[
              name: row
              line: 240
              upvalues:
                u21 (ref,  index: 1)
                UI_upv_1 (copy, index: 2)
                a46 (copy, index: 3)
                a47 (copy, index: 4)
                a45 (copy, index: 5)
            ]]
            u21 = u21 + (a50 or 0)
            local v42 = UI_upv_1.new("Frame", {Position = UDim2.fromOffset(a46, u21), Size = UDim2.fromOffset(a47, a49), Parent = a45})
            u21 = u21 + a49
            return v42
        end
        function tbl_21.skip(a51)
            --[[
              name: skip
              line: 246
              upvalues:
                u21 (ref, index: 1)
            ]]
            u21 = u21 + a51
        end
        function tbl_21.y()
            --[[
              name: y
              line: 249
              upvalues:
                u21 (ref, index: 1)
            ]]
            return u21
        end
        return tbl_21
    end
    function tbl_upv_11.Pitch(a52)
        --[[
          name: Pitch
          line: 636
          upvalues:
            UI_upv_1 (copy, index: 1)
            stacker (copy, index: 2)
            heading (copy, index: 3)
            kitOf (copy, index: 4)
            State_upv_1 (copy, index: 5)
            WeaponInfo_upv_1 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            pointsReadout (copy, index: 9)
            kitStrip (copy, index: 10)
            pointsMeter (copy, index: 11)
            customizeButton (copy, index: 12)
            fightButton (copy, index: 13)
            exploreLink (copy, index: 14)
            loadoutSig (copy, index: 15)
        ]]
        local v43 = ((UI_upv_1.Compact) and 680) or 620
        local v44 = ((UI_upv_1.Compact) and 30) or 32
        local v45 = v43 - v44 * 2
        local v46 = stacker(a52, v44, v45, ((UI_upv_1.Compact) and 20) or 26)
        heading(v46, "COMPETITIVE 3V3 ARENA", "BUILD YOUR LOADOUT", ((UI_upv_1.Compact) and 48) or 46, "Spend your gear points on any weapons, armor and healing.\nThen fight 3v3. Last tribe standing wins the round.", 2)
        local v47, u22 = kitOf(State_upv_1.Loadout())
        local v48 = WeaponInfo_upv_1.Budget()
        local v49 = v45 - 28
        local v50 = v46.row(0, ((UI_upv_1.Compact) and 10) or 14)
        v50.Name = "Loadout"
        v50.BackgroundColor3 = Colors_upv_1.Inset
        v50.BackgroundTransparency = 0.3
        UI_upv_1.Corner(14).Parent = v50
        UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9).Parent = v50
        local new_5 = UI_upv_1.new
        local tbl_22 = {TextColor3 = 0, Parent = 0, Text = "YOUR LOADOUT", Name = "Label", TextXAlignment = 0, TextSize = 0}
        tbl_22.Position = UDim2.fromOffset(14, 12)
        tbl_22.Size = UDim2.fromOffset(math.floor(v49 * 0.6), 20)
        tbl_22.FontFace = Fonts_upv_1.Heavy
        tbl_22.TextSize = ((UI_upv_1.Compact) and 16) or 14
        tbl_22.TextColor3 = Colors_upv_1.TextMuted
        tbl_22.TextXAlignment = Enum.TextXAlignment.Left
        tbl_22.Parent = v50
        new_5("TextLabel", tbl_22)
        local tbl_23 = {}
        tbl_23.AnchorPoint = Vector2.new(1, 0)
        tbl_23.Position = UDim2.new(1, -14, 0, 12)
        tbl_23.Size = UDim2.fromOffset(math.floor(v49 * 0.4), 20)
        local v51 = ((UI_upv_1.Compact) and 19) or 17
        local v52 = pointsReadout(v50, tbl_23, v51, ((UI_upv_1.Compact) and 15) or 13)
        local v53 = ((UI_upv_1.Compact) and 90) or 88
        local v54, _, v55 = kitStrip(v50, v47, v49, v53, ((UI_upv_1.Compact) and 15) or 13)
        v54.Position = UDim2.fromOffset(14, 42)
        local u23 = pointsMeter(v50, v49, 8, UDim2.fromOffset(14, (42 + v55) + 10))
        local v56 = ((42 + v55) + 10) + 8 + 14
        v50.Size = UDim2.fromOffset(v45, v56)
        v46.skip(v56)
        local v57 = ((UI_upv_1.Compact) and 88) or 80
        local v58 = v46.row(v57, ((UI_upv_1.Compact) and 10) or 14)
        local v59 = math.floor(v45 * 0.37)
        local tbl_24 = {Parent = 0, TextSize = 0}
        tbl_24.Size = UDim2.fromOffset(v59, v57)
        tbl_24.TextSize = ((UI_upv_1.Compact) and 24) or 22
        tbl_24.Parent = v58
        customizeButton(tbl_24)
        local tbl_25 = {Parent = 0, TextSize = 0}
        tbl_25.Position = UDim2.fromOffset(v59 + 12, 0)
        tbl_25.Size = UDim2.fromOffset((v45 - v59) - 12, v57)
        tbl_25.TextSize = ((UI_upv_1.Compact) and 44) or 42
        tbl_25.Parent = v58
        local v60 = fightButton(tbl_25)
        local tbl_26 = {Parent = 0, TextSize = 0}
        tbl_26.Size = UDim2.fromScale(1, 1)
        tbl_26.TextSize = ((UI_upv_1.Compact) and 21) or 18
        tbl_26.Parent = v46.row(((UI_upv_1.Compact) and 60) or 40, 2)
        exploreLink(tbl_26)
        v46.skip(((UI_upv_1.Compact) and 2) or 12)
        v52.Text = u22 .. " / " .. v48
        u23(u22, true)
        local u24 = 0
        local tbl_27 = {}
        tbl_27.width = v43
        tbl_27.height = v46.y()
        tbl_27.fight = v60
        function tbl_27.signature()
            --[[
              name: signature
              line: 703
              upvalues:
                loadoutSig (copy, index: 1)
                State_upv_1 (copy, index: 2)
            ]]
            return loadoutSig(State_upv_1.Loadout())
        end
        function tbl_27.opened()
            --[[
              name: opened
              line: 707
              upvalues:
                u24 (ref,  index: 1)
                u23 (copy, index: 2)
                u22 (copy, index: 3)
                a52 (copy, index: 4)
            ]]
            u24 = u24 + 1
            local u25 = u24
            u23(0, true)
            task.spawn(
                function()
                    --[[
                      line: 711
                      upvalues:
                        u22 (copy, index: 1)
                        u25 (copy, index: 2)
                        u24 (ref,  index: 3)
                        a52 (copy, index: 4)
                        u23 (copy, index: 5)
                    ]]
                    task.wait(0.3)
                    for n_2 = 1, u22 do
                        if u25 ~= u24 or not (a52.Parent) then
                            return
                        end
                        u23(n_2)
                        task.wait(0.045)
                    end
                end
            )
        end
        return tbl_27
    end
    function tbl_upv_11.Builds(a53)
        --[[
          name: Builds
          line: 729
          upvalues:
            UI_upv_1 (copy, index: 1)
            stacker (copy, index: 2)
            heading (copy, index: 3)
            State_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            u13 (ref,  index: 8)
            u11 (ref,  index: 9)
            a1 (copy, index: 10)
            kitOf (copy, index: 11)
            tbl_upv_4 (copy, index: 12)
            WeaponInfo_upv_1 (copy, index: 13)
            tbl_upv_3 (copy, index: 14)
            WeaponIcon_upv_1 (copy, index: 15)
            itemTile (copy, index: 16)
            u15 (ref,  index: 17)
            u16 (ref,  index: 18)
            MenuManager_upv_1 (copy, index: 19)
            fightButton (copy, index: 20)
            exploreLink (copy, index: 21)
            loadoutSig (copy, index: 22)
        ]]
        local v61 = ((UI_upv_1.Compact) and 1090) or 1000
        local v62 = v61 - 56
        local v63 = stacker(a53, 28, v62, ((UI_upv_1.Compact) and 16) or 24)
        heading(v63, "COMPETITIVE 3V3 ARENA", "CHOOSE YOUR LOADOUT", ((UI_upv_1.Compact) and 48) or 46, "Every fighter brings their own gear. Pick a build to start, or make your own.", 1)
        local u26 = math.min(3, State_upv_1.LoadoutSlotCount())
        local v64 = u26 + 1
        local u27 = math.floor((v62 - ((v64 - 1) * 12)) / v64)
        local u28 = ((UI_upv_1.Compact) and 80) or 92
        local u29 = ((UI_upv_1.Compact) and 22) or 20
        local u30 = ((UI_upv_1.Compact) and 16) or 15
        local u31 = u29 + 4
        local u32 = math.ceil((u30 * 1.3) * 2)
        local u33 = ((UI_upv_1.Compact) and 34) or 36
        local u34 = ((((((u28 + 10) + 8) + u31) + 2) + u32) + 8) + u33 + 12
        local u35 = v63.row(u34, ((UI_upv_1.Compact) and 18) or 20)
        local u36 = Color3.fromRGB(226, 230, 238)
        local u37 = Color3.new(1, 1, 1)
        local u38 = ((((u28 + 10) + 8) + u31) + 2) + u32 + 8
        local function tileSize(a54)
            --[[
              name: tileSize
              line: 830
              upvalues:
                u33 (copy, index: 1)
                u27 (copy, index: 2)
            ]]
            return (math.min(u33, math.floor(((u27 - 24) - ((a54 - 1) * 6)) / a54)))
        end
        local tbl_upv_28 = {}
        local u39 = nil
        local tbl_upv_29 = {selecting = false}
        tbl_upv_29.width = v61
        local function paint()
            --[[
              name: paint
              line: 837
              upvalues:
                u39 (ref,  index: 1)
                State_upv_1 (copy, index: 2)
                tbl_upv_28 (copy, index: 3)
                u26 (copy, index: 4)
                Colors_upv_1 (copy, index: 5)
            ]]
            local v65 = u39 or (State_upv_1.ActiveLoadout())
            local v66 = nil
            local v67 = nil
            for key_4, value_7 in tbl_upv_28 do
                if key_4 <= u26 then
                    v66 = key_4 == v65
                else
                    v66 = u26 < v65
                end
                local stroke_1 = value_7.stroke
                if v66 then
                    v67 = Colors_upv_1.Accent
                else
                    v67 = Colors_upv_1.StrokeSoft
                end
                stroke_1.Color = v67
                value_7.stroke.Thickness = (v66 and 2.5) or 1.5
                value_7.pill.Visible = v66
            end
        end
        local function pick(a55)
            --[[
              name: pick
              line: 847
              upvalues:
                u13 (ref,  index: 1)
                tbl_upv_29 (copy, index: 2)
                u11 (ref,  index: 3)
                State_upv_1 (copy, index: 4)
                UI_upv_1 (copy, index: 5)
                tbl_upv_28 (copy, index: 6)
                a1 (copy, index: 7)
                u39 (ref,  index: 8)
                paint (copy, index: 9)
                a53 (copy, index: 10)
            ]]
            if (u13) or (tbl_upv_29.selecting) or not u11 then
                return
            end
            if State_upv_1.ActiveLoadout() ~= a55 then
                a1.Sounds.Play("Select")
                u39 = a55
                tbl_upv_29.selecting = true
                paint()
                task.spawn(
                    function()
                        --[[
                          line: 858
                          upvalues:
                            a1 (copy, index: 1)
                            a55 (copy, index: 2)
                            u39 (ref,  index: 3)
                            tbl_upv_29 (copy, index: 4)
                            a53 (copy, index: 5)
                            paint (copy, index: 6)
                        ]]
                        a1.ProfileAction("SelectLoadout", a55)
                        u39 = nil
                        tbl_upv_29.selecting = false
                        if not a53.Parent then
                            return
                        end
                        paint()
                    end
                )
            else
                UI_upv_1.Bump(tbl_upv_28[a55].pill, 0.12)
            end
        end
        local function shell(a56, a57, a58, a59)
            --[[
              name: shell
              line: 757
              upvalues:
                UI_upv_1 (copy, index: 1)
                u27 (copy, index: 2)
                u34 (copy, index: 3)
                u35 (copy, index: 4)
                u36 (copy, index: 5)
                Colors_upv_1 (copy, index: 6)
                Theme_upv_1 (copy, index: 7)
                u37 (copy, index: 8)
                u28 (copy, index: 9)
                u31 (copy, index: 10)
                Fonts_upv_1 (copy, index: 11)
                u29 (copy, index: 12)
                u32 (copy, index: 13)
                u30 (copy, index: 14)
                u38 (copy, index: 15)
                u33 (copy, index: 16)
            ]]
            local v68 = UI_upv_1.new("TextButton", {Name = a57, Position = UDim2.fromOffset((a56 - 1) * (u27 + 12), 0), Size = UDim2.fromOffset(u27, u34), Parent = u35})
            local v69 = {}
            v69.Name = "Face"
            v69.Size = UDim2.fromScale(1, 1)
            v69.BackgroundColor3 = u36
            v69[1], v69[2] = UI_upv_1.Corner(14), UI_upv_1.Gradient(Colors_upv_1.PanelHi, Colors_upv_1.Panel, 90)
            v69.Parent = v68
            local u40 = UI_upv_1.new("Frame", v69)
            local v70 = UI_upv_1.Stroke(Colors_upv_1.StrokeSoft, 1.5, 0)
            v70.Parent = u40
            v68.MouseEnter:Connect(
                function()
                    --[[
                      line: 774
                      upvalues:
                        UI_upv_1 (copy, index: 1)
                        u40 (copy, index: 2)
                        Theme_upv_1 (copy, index: 3)
                        u37 (copy, index: 4)
                    ]]
                    UI_upv_1.Tween(u40, Theme_upv_1.Tween.Fast, {BackgroundColor3 = u37})
                end
            )
            v68.MouseLeave:Connect(
                function()
                    --[[
                      line: 777
                      upvalues:
                        UI_upv_1 (copy, index: 1)
                        u40 (copy, index: 2)
                        Theme_upv_1 (copy, index: 3)
                        u36 (copy, index: 4)
                    ]]
                    UI_upv_1.Tween(u40, Theme_upv_1.Tween.Fast, {BackgroundColor3 = u36})
                end
            )
            v69 = UI_upv_1.new("Frame", {Name = "Hero", Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(u27 - 20, u28), BackgroundColor3 = Color3.new(1, 1, 1), [1] = UI_upv_1.Corner(10), Parent = u40})
            local Pill_1 = UI_upv_1.Pill
            local Accent_1 = Colors_upv_1.Accent
            local tbl_30 = {Transparency = 0, Name = "Equipped", Height = 0, ZIndex = 4, TextSize = 0, Parent = 0}
            tbl_30.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_30.Position = UDim2.fromScale(0.5, 0)
            tbl_30.Height = ((UI_upv_1.Compact) and 24) or 22
            tbl_30.TextSize = ((UI_upv_1.Compact) and 14) or 13
            tbl_30.Parent = v68
            local v71 = Pill_1("EQUIPPED", Accent_1, tbl_30)
            UI_upv_1.new("TextLabel", {Name = "Name", Position = UDim2.fromOffset(12, (u28 + 10) + 8), Size = UDim2.fromOffset(u27 - 24, u31), Text = a58, FontFace = Fonts_upv_1.Heavy, TextSize = u29, TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u40})
            UI_upv_1.new("TextLabel", {Name = "Line", TextWrapped = true, Position = UDim2.fromOffset(12, (((u28 + 10) + 8) + u31) + 2), Size = UDim2.fromOffset(u27 - 24, u32), Text = a59, FontFace = Fonts_upv_1.Medium, TextSize = u30, TextColor3 = Colors_upv_1.TextDim, TextYAlignment = Enum.TextYAlignment.Top, Parent = u40})
            return v68, v70, v69, v71, (UI_upv_1.new("Frame", {Name = "Rest", Position = UDim2.fromOffset(12, u38), Size = UDim2.fromOffset(u27 - 24, u33), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = u40}))
        end
        local v85, v86 = nil, nil
        for n_upv_3 = 1, u26 do
            v85 = State_upv_1.LoadoutSlot(n_upv_3)
            v86 = kitOf(v85)
            local v74 = WeaponInfo_upv_1.Normalize(v85)
            local v75 = tbl_upv_4[table.concat(v74.items, ",") .. "|" .. (v74.armor or "")]
            v85 = State_upv_1.LoadoutCustomName(n_upv_3)
            local v76
            if v85 == "" then
                v76 = ((not v75) and "YOUR BUILD") or (v75.name)
            else
                v76 = string.upper(v85)
            end
            local v77, v78, v79, v80
            v77, v74, v78, v79, v80 = shell(n_upv_3, "Build" .. n_upv_3, v76, ((not v75) and "Your own mix of gear.") or (v75.line))
            local v81 = v86[1]
            UI_upv_1.Gradient(((v81 and (tbl_upv_3[v81.cat])) or (Colors_upv_1.Accent)):Lerp(Colors_upv_1.Panel, 0.5800000000000001), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115).Parent = v78
            if v81 then
                WeaponIcon_upv_1.Set(UI_upv_1.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(u28 - 6, u28 - 6), Parent = v78}), v81.icon, {outline = false, glow = false})
            end
            local v82 = math.max(#v86 - 1, 1)
            local v83 = math.min(u33, math.floor(((u27 - 24) - ((v82 - 1) * 6)) / v82))
            for n_4 = 2, #v86 do
                itemTile(v80, v86[n_4], v83, false, n_4)
            end
            tbl_upv_28[n_upv_3] = {stroke = v74, pill = v79}
            v77.Activated:Connect(
                function()
                    --[[
                      line: 893
                      upvalues:
                        pick (copy, index: 1)
                        n_upv_3 (copy, index: 2)
                    ]]
                    pick(n_upv_3)
                end
            )
            local v84 = n_upv_3
        end
        local v87, tbl_31, v84
        v87, tbl_31, v84, v85, v86 = shell(v64, "Own", "BUILD YOUR OWN", "Mix any gear you own.\nEvery item costs points.")
        UI_upv_1.Gradient(Colors_upv_1.Accent:Lerp(Colors_upv_1.Panel, 0.7), Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Panel, 0.6), 115).Parent = v84
        local new_6 = UI_upv_1.new
        local tbl_32 = {}
        tbl_32.Name = "Plus"
        tbl_32.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_32.Position = UDim2.fromScale(0.5, 0.5)
        tbl_32.Size = UDim2.fromOffset(((UI_upv_1.Compact) and 48) or 52, ((UI_upv_1.Compact) and 48) or 52)
        tbl_32.BackgroundColor3 = Colors_upv_1.AccentDark
        tbl_32[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_32.Parent = v84
        local v88 = new_6("Frame", tbl_32)
        UI_upv_1.Icon("plus", 24, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v88})
        local v89 = math.min(u33, math.floor(((u27 - 24) - 24) / 5))
        for n_5 = 1, 5 do
            v84 = UI_upv_1.new("Frame", {Name = "Slot" .. n_5, Size = UDim2.fromOffset(v89, v89), BackgroundColor3 = Colors_upv_1.Inset, LayoutOrder = n_5, [1] = UI_upv_1.Corner(math.max(6, math.floor(v89 * 0.15))), Parent = v86})
            UI_upv_1.Stroke(Colors_upv_1.StrokeSoft, 1, 0.2).Parent = v84
            UI_upv_1.Icon("plus", math.floor(v89 * 0.34), Colors_upv_1.TextMuted, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v84})
        end
        tbl_upv_28[v64] = {stroke = tbl_31, pill = v85}
        v87.Activated:Connect(
            function()
                --[[
                  line: 930
                  upvalues:
                    a1 (copy, index: 1)
                    u13 (ref,  index: 2)
                    u11 (ref,  index: 3)
                    u15 (ref,  index: 4)
                    u16 (ref,  index: 5)
                    MenuManager_upv_1 (copy, index: 6)
                ]]
                a1.Sounds.Play("Click")
                if (u13) or not u11 then
                    return
                end
                u15 = true
                u16 = 0
                MenuManager_upv_1.Open("Loadout")
                if (MenuManager_upv_1.IsOpen("Loadout")) then
                    return
                end
                u15 = false
            end
        )
        local v90
        if v64 ~= 4 then
            v90 = math.min(v62, ((UI_upv_1.Compact) and 480) or 460)
        else
            v90 = u27 * 2 + 12
        end
        local v91 = ((UI_upv_1.Compact) and 88) or 80
        tbl_31 = {Parent = 0, TextSize = 0}
        tbl_31.AnchorPoint = Vector2.new(0.5, 0)
        tbl_31.Position = UDim2.fromScale(0.5, 0)
        tbl_31.Size = UDim2.fromOffset(v90, v91)
        tbl_31.TextSize = ((UI_upv_1.Compact) and 44) or 42
        tbl_31.Parent = v63.row(v91, ((UI_upv_1.Compact) and 10) or 16)
        tbl_upv_29.fight = fightButton(tbl_31)
        tbl_31 = {Parent = 0, TextSize = 0}
        tbl_31.AnchorPoint = Vector2.new(0.5, 0)
        tbl_31.Position = UDim2.fromScale(0.5, 0)
        tbl_31.Size = UDim2.new(0, v90, 1, 0)
        tbl_31.TextSize = ((UI_upv_1.Compact) and 20) or 18
        tbl_31.Parent = v63.row(((UI_upv_1.Compact) and 56) or 42, 2)
        exploreLink(tbl_31)
        v63.skip(((UI_upv_1.Compact) and 2) or 10)
        tbl_upv_29.height = v63.y()
        tbl_upv_29.signature = function()
            --[[
              line: 955
              upvalues:
                State_upv_1 (copy, index: 1)
                loadoutSig (copy, index: 2)
            ]]
            local tbl_33 = {}
            for n_6 = 1, math.min(3, State_upv_1.LoadoutSlotCount()) do
                table.insert(tbl_33, loadoutSig(State_upv_1.LoadoutSlot(n_6)) .. "#" .. State_upv_1.LoadoutCustomName(n_6))
            end
            return table.concat(tbl_33, ";")
        end
        tbl_upv_29.refresh = paint
        tbl_upv_29.pick = function(a60)
            --[[
              line: 963
              upvalues:
                tbl_upv_28 (copy, index: 1)
                u26 (copy, index: 2)
                pick (copy, index: 3)
            ]]
            if not tbl_upv_28[a60] or not (a60 <= u26) then
                return
            end
            pick(a60)
        end
        paint()
        return tbl_upv_29
    end
    local function actionRow(a61, a62, a63)
        --[[
          name: actionRow
          line: 357
          upvalues:
            UI_upv_1 (copy, index: 1)
            fightButton (copy, index: 2)
            exploreLink (copy, index: 3)
        ]]
        local v92 = ((UI_upv_1.Compact) and 88) or 80
        local v93 = a61.row(v92, a63)
        local v94 = ((UI_upv_1.Compact) and 260) or 230
        local tbl_34 = {Parent = 0, TextSize = 0}
        tbl_34.Size = UDim2.fromOffset((a62 - v94) - 12, v92)
        tbl_34.TextSize = ((UI_upv_1.Compact) and 44) or 42
        tbl_34.Parent = v93
        local v95 = fightButton(tbl_34)
        local tbl_35 = {Parent = 0, TextSize = 0}
        tbl_35.AnchorPoint = Vector2.new(1, 0)
        tbl_35.Position = UDim2.fromScale(1, 0)
        tbl_35.Size = UDim2.fromOffset(v94, v92)
        tbl_35.TextSize = ((UI_upv_1.Compact) and 20) or 18
        tbl_35.Parent = v93
        exploreLink(tbl_35)
        return v95
    end
    function tbl_upv_11.Briefing(a64)
        --[[
          name: Briefing
          line: 974
          upvalues:
            UI_upv_1 (copy, index: 1)
            stacker (copy, index: 2)
            heading (copy, index: 3)
            kitOf (copy, index: 4)
            State_upv_1 (copy, index: 5)
            WeaponInfo_upv_1 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            pointsReadout (copy, index: 9)
            kitStrip (copy, index: 10)
            pointsMeter (copy, index: 11)
            customizeButton (copy, index: 12)
            Theme_upv_1 (copy, index: 13)
            Portraits_upv_1 (copy, index: 14)
            LocalPlayer_upv_1 (copy, index: 15)
            actionRow (copy, index: 16)
            loadoutSig (copy, index: 17)
        ]]
        local v96 = ((UI_upv_1.Compact) and 1090) or 1000
        local v97 = v96 - 56
        local v98 = stacker(a64, 28, v97, ((UI_upv_1.Compact) and 18) or 24)
        heading(v98, "WELCOME TO TRIBES", "COMPETITIVE 3V3. YOUR OWN LOADOUT.", ((UI_upv_1.Compact) and 44) or 42)
        local v99, u41 = kitOf(State_upv_1.Loadout())
        local u42 = WeaponInfo_upv_1.Budget()
        local v100 = math.floor(v97 * 0.36)
        local v101 = v97 - v100 - 14
        local v102 = v98.row(0, ((UI_upv_1.Compact) and 10) or 14)
        local tbl_36 = {}
        tbl_36.Name = "Loadout"
        tbl_36.Position = UDim2.fromOffset(v100 + 14, 0)
        tbl_36.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_36[1], tbl_36[2] = UI_upv_1.Corner(14), UI_upv_1.Gradient(Colors_upv_1.AccentDeep:Lerp(Colors_upv_1.Panel, 0.62), Colors_upv_1.Panel, 100)
        tbl_36.Parent = v102
        local v103 = UI_upv_1.new("Frame", tbl_36)
        UI_upv_1.Stroke(Colors_upv_1.Accent, 1.5, 0.5).Parent = v103
        local v104 = v101 - 32
        local new_7 = UI_upv_1.new
        local tbl_37 = {TextColor3 = 0, Parent = 0, Text = "YOUR LOADOUT", Name = "Label", TextXAlignment = 0, TextSize = 0}
        tbl_37.Position = UDim2.fromOffset(16, 14)
        tbl_37.Size = UDim2.fromOffset(math.floor(v104 * 0.5), 20)
        tbl_37.FontFace = Fonts_upv_1.Heavy
        tbl_37.TextSize = ((UI_upv_1.Compact) and 17) or 15
        tbl_37.TextColor3 = Colors_upv_1.Accent
        tbl_37.TextXAlignment = Enum.TextXAlignment.Left
        tbl_37.Parent = v103
        new_7("TextLabel", tbl_37)
        local tbl_38 = {}
        tbl_38.AnchorPoint = Vector2.new(1, 0)
        tbl_38.Position = UDim2.new(1, -16, 0, 14)
        tbl_38.Size = UDim2.fromOffset(math.floor(v104 * 0.5), 20)
        local v105 = ((UI_upv_1.Compact) and 20) or 18
        local u43 = pointsReadout(v103, tbl_38, v105, ((UI_upv_1.Compact) and 15) or 13)
        local v106 = ((UI_upv_1.Compact) and 19) or 17
        UI_upv_1.new("TextLabel", {Text = "Every item costs gear points. Spend them your way.", Name = "Sub", Position = UDim2.fromOffset(16, 38), Size = UDim2.fromOffset(v104, v106 + 6), FontFace = Fonts_upv_1.Medium, TextSize = v106, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = v103})
        local v107 = (v106 + 38) + 6 + 10
        local v108 = ((UI_upv_1.Compact) and 84) or 80
        local v109, u44, v110 = kitStrip(v103, v99, v104, v108, ((UI_upv_1.Compact) and 15) or 13)
        v109.Position = UDim2.fromOffset(16, v107)
        local v111 = v107 + v110 + 10
        local u45 = pointsMeter(v103, v104, 8, UDim2.fromOffset(16, v111))
        local v112 = v111 + 8 + 12
        local v113 = ((UI_upv_1.Compact) and 56) or 48
        local v114 = ((UI_upv_1.Compact) and 214) or 190
        local new_8 = UI_upv_1.new
        local tbl_39 = {TextColor3 = 0, Parent = 0, Text = "Unlock muskets, spears, traps and heavier armor as you play.", Name = "More", TextXAlignment = 0, TextWrapped = true, TextSize = 0}
        tbl_39.Position = UDim2.fromOffset(16, v112)
        tbl_39.Size = UDim2.fromOffset((v104 - v114) - 14, v113)
        tbl_39.FontFace = Fonts_upv_1.Medium
        tbl_39.TextSize = ((UI_upv_1.Compact) and 17) or 15
        tbl_39.TextColor3 = Colors_upv_1.TextMuted
        tbl_39.TextXAlignment = Enum.TextXAlignment.Left
        tbl_39.Parent = v103
        new_8("TextLabel", tbl_39)
        local tbl_40 = {Parent = 0, TextSize = 0}
        tbl_40.AnchorPoint = Vector2.new(1, 0)
        tbl_40.Position = UDim2.new(1, -16, 0, v112)
        tbl_40.Size = UDim2.fromOffset(v114, v113)
        tbl_40.TextSize = ((UI_upv_1.Compact) and 22) or 20
        tbl_40.Parent = v103
        customizeButton(tbl_40)
        local v115 = v112 + v113 + 16
        v103.Size = UDim2.fromOffset(v101, v115)
        local v116 = UI_upv_1.new("Frame", {Name = "Fight", Size = UDim2.fromOffset(v100, v115), BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(14), Parent = v102})
        UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9).Parent = v116
        local new_9 = UI_upv_1.new
        local tbl_41 = {TextColor3 = 0, Parent = 0, Text = "THE FIGHT", Name = "Label", TextXAlignment = 0, TextSize = 0}
        tbl_41.Position = UDim2.fromOffset(16, 14)
        tbl_41.Size = UDim2.fromOffset(v100 - 32, 20)
        tbl_41.FontFace = Fonts_upv_1.Heavy
        tbl_41.TextSize = ((UI_upv_1.Compact) and 17) or 15
        tbl_41.TextColor3 = Colors_upv_1.TextMuted
        tbl_41.TextXAlignment = Enum.TextXAlignment.Left
        tbl_41.Parent = v116
        new_9("TextLabel", tbl_41)
        local u46 = ((UI_upv_1.Compact) and 42) or 38
        local u47 = UI_upv_1.new("Frame", {Name = "Teams", Position = UDim2.fromOffset(0, 50), Size = UDim2.fromOffset(v100, u46), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v116})
        local function fighter(a65, a66, a67)
            --[[
              name: fighter
              line: 1087
              upvalues:
                UI_upv_1 (copy, index: 1)
                u46 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                Theme_upv_1 (copy, index: 4)
                u47 (copy, index: 5)
                Portraits_upv_1 (copy, index: 6)
                LocalPlayer_upv_1 (copy, index: 7)
            ]]
            local tbl_42 = {}
            tbl_42.Name = "Fighter"
            tbl_42.Size = UDim2.fromOffset(u46, u46)
            tbl_42.BackgroundColor3 = a66:Lerp(Colors_upv_1.Panel, 0.72)
            tbl_42.LayoutOrder = a65
            tbl_42[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
            tbl_42.Parent = u47
            local v117 = UI_upv_1.new("Frame", tbl_42)
            UI_upv_1.Stroke(a66, 2, 0).Parent = v117
            if a67 then
                local tbl_43 = {}
                tbl_43.Name = "You"
                tbl_43.Size = UDim2.fromScale(1, 1)
                tbl_43.ScaleType = Enum.ScaleType.Crop
                tbl_43[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
                tbl_43.Parent = v117
                Portraits_upv_1.Apply(UI_upv_1.new("ImageLabel", tbl_43), {userId = LocalPlayer_upv_1.UserId}, 150)
            else
                UI_upv_1.Icon("person", math.floor(u46 * 0.56), a66, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v117})
            end
        end
        fighter(1, Colors_upv_1.Ally, true)
        fighter(2, Colors_upv_1.Ally, false)
        fighter(3, Colors_upv_1.Ally, false)
        local new_10 = UI_upv_1.new
        local tbl_44 = {LayoutOrder = 4, FontFace = 0, Name = "Vs", TextColor3 = 0, Parent = 0, Text = "VS", TextSize = 0, Size = 0}
        tbl_44.Size = UDim2.fromOffset(((UI_upv_1.Compact) and 38) or 34, u46)
        tbl_44.FontFace = Fonts_upv_1.Display
        tbl_44.TextSize = ((UI_upv_1.Compact) and 22) or 20
        tbl_44.TextColor3 = Colors_upv_1.TextDim
        tbl_44.Parent = u47
        new_10("TextLabel", tbl_44)
        fighter(5, Colors_upv_1.Enemy, false)
        fighter(6, Colors_upv_1.Enemy, false)
        fighter(7, Colors_upv_1.Enemy, false)
        local tbl_45 = {"Two tribes of three", "One life each round", "Last tribe standing wins"}
        local v118 = ((UI_upv_1.Compact) and 40) or 38
        local v119 = u46 + 50
        local v120 = v119 + math.floor(((v115 - v119) - (#tbl_45 * v118)) / 2)
        for key_5, value_8 in tbl_45 do
            local v121 = v120 + (key_5 - 1) * v118
            UI_upv_1.new("Frame", {Name = "Dot" .. key_5, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(18, v121 + (v118 / 2)), Size = UDim2.fromOffset(8, 8), BackgroundColor3 = Colors_upv_1.Accent, [1] = UI_upv_1.Corner(2), Parent = v116})
            local new_11 = UI_upv_1.new
            local tbl_46 = {TextColor3 = 0, Parent = 0, TextXAlignment = 0, TextSize = 0}
            tbl_46.Name = "Fact" .. key_5
            tbl_46.Position = UDim2.fromOffset(38, v121)
            tbl_46.Size = UDim2.fromOffset((v100 - 32) - 22, v118)
            tbl_46.Text = value_8
            tbl_46.FontFace = Fonts_upv_1.Bold
            tbl_46.TextSize = ((UI_upv_1.Compact) and 20) or 18
            tbl_46.TextColor3 = Colors_upv_1.Text
            tbl_46.TextXAlignment = Enum.TextXAlignment.Left
            tbl_46.Parent = v116
            new_11("TextLabel", tbl_46)
        end
        v102.Size = UDim2.fromOffset(v97, v115)
        v98.skip(v115)
        local v122 = actionRow(v98, v97, ((UI_upv_1.Compact) and 10) or 14)
        v98.skip(((UI_upv_1.Compact) and 12) or 14)
        local function settle()
            --[[
              name: settle
              line: 1163
              upvalues:
                u43 (copy, index: 1)
                u41 (copy, index: 2)
                u42 (copy, index: 3)
                u45 (copy, index: 4)
                u44 (copy, index: 5)
                UI_upv_1 (copy, index: 6)
            ]]
            u43.Text = u41 .. " / " .. u42
            u45(u41, true)
            for _, value_9 in u44 do
                UI_upv_1.GetScaleObj(value_9.icon).Scale = 1
                if value_9.cost then
                    value_9.cost.Visible = true
                end
            end
        end
        settle()
        local u48 = 0
        local tbl_47 = {}
        tbl_47.width = v96
        tbl_47.height = v98.y()
        tbl_47.fight = v122
        function tbl_47.signature()
            --[[
              name: signature
              line: 1179
              upvalues:
                loadoutSig (copy, index: 1)
                State_upv_1 (copy, index: 2)
            ]]
            return loadoutSig(State_upv_1.Loadout())
        end
        function tbl_47.opened()
            --[[
              name: opened
              line: 1183
              upvalues:
                u48 (ref,  index: 1)
                u43 (copy, index: 2)
                u42 (copy, index: 3)
                u45 (copy, index: 4)
                u44 (copy, index: 5)
                UI_upv_1 (copy, index: 6)
                a64 (copy, index: 7)
                Theme_upv_1 (copy, index: 8)
            ]]
            u48 = u48 + 1
            local u49 = u48
            u43.Text = "0 / " .. u42
            u45(0, true)
            for _, value_10 in u44 do
                UI_upv_1.GetScaleObj(value_10.icon).Scale = 0.001
                if value_10.cost then
                    value_10.cost.Visible = false
                end
            end
            task.spawn(
                function()
                    --[[
                      line: 1194
                      upvalues:
                        u44 (copy, index: 1)
                        u49 (copy, index: 2)
                        u48 (ref,  index: 3)
                        a64 (copy, index: 4)
                        UI_upv_1 (copy, index: 5)
                        Theme_upv_1 (copy, index: 6)
                        u43 (copy, index: 7)
                        u42 (copy, index: 8)
                        u45 (copy, index: 9)
                    ]]
                    task.wait(0.4)
                    local v123 = 0
                    for _, value_11 in u44 do
                        if u49 ~= u48 or not (a64.Parent) then
                            return
                        end
                        local v124 = UI_upv_1.GetScaleObj(value_11.icon)
                        v124.Scale = 0.5
                        UI_upv_1.Tween(v124, Theme_upv_1.Tween.Pop, {Scale = 1})
                        if value_11.cost then
                            value_11.cost.Visible = true
                        end
                        v123 = v123 + value_11.points
                        u43.Text = v123 .. " / " .. u42
                        u45(v123)
                        task.wait(0.17)
                    end
                end
            )
        end
        return tbl_47
    end
    u17 = function()
        --[[
          line: 1219
          upvalues:
            u7 (ref,  index: 1)
            u4 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u5 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
        ]]
        if not u7 then
            return
        end
        local width_1 = u7.width
        local v125
        if u7.measure then
            v125 = u7.measure()
        else
            v125 = u7.height
        end
        u4.Size = UDim2.fromOffset(width_1, v125)
        local v126 = UI_upv_1.CanvasSize()
        local v127 = UI_upv_1.TopInset()
        local v128 = (v126.X > 200) and (v126.Y > 200)
        local v129
        if v128 then
            v129 = math.clamp(math.min(((v126.Y - v127) - 16) / v125, (v126.X - 32) / width_1), 0.3, 1)
        else
            v129 = 1
        end
        u5.Scale = v129
        local v130 = ((not v128) and 0) or (math.max(0, ((v127 + ((v125 * v129) / 2)) + 4) - (v126.Y / 2)))
        local v131 = UDim2.new(0.5, 0, 0.5, v130)
        if u4:GetAttribute("_slideTarget") == nil then
            u4.Position = v131
        else
            u4:SetAttribute("_slideTarget", v131)
            local tbl_48 = {}
            tbl_48.Position = v131
            UI_upv_1.Tween(u4, Theme_upv_1.Tween.Fast, tbl_48).Completed:Connect(
                function(a68)
                    --[[
                      line: 1241
                      upvalues:
                        u4 (copy, index: 1)
                    ]]
                    if a68 ~= Enum.PlaybackState.Completed then
                        return
                    end
                    u4:SetAttribute("_slideTarget", nil)
                end
            )
        end
    end
    local function selectFight()
        --[[
          name: selectFight
          line: 1251
          upvalues:
            UI_upv_1 (copy, index: 1)
            u7 (ref,  index: 2)
        ]]
        if UI_upv_1.Gamepad then
            local GuiService_1 = game:GetService("GuiService")
            GuiService_1.SelectedObject = u7.fight.Instance
        end
    end
    local function build()
        --[[
          name: build
          line: 1257
          upvalues:
            u8 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            u6 (copy, index: 3)
            tbl_upv_11 (copy, index: 4)
            u1 (ref,  index: 5)
            fight (copy, index: 6)
            u7 (ref,  index: 7)
            u9 (ref,  index: 8)
            u4 (copy, index: 9)
            u17 (ref,  index: 10)
            u11 (ref,  index: 11)
        ]]
        if u8 then
            u8:Destroy()
        end
        local v132 = UI_upv_1.new("Frame", {Name = "Body", Size = UDim2.fromScale(1, 1), Parent = u6})
        u8 = v132
        local v133 = tbl_upv_11[u1](v132)
        v133.version = u1
        v133.compact = UI_upv_1.Compact
        local v134
        if v133.signature then
            v134 = v133.signature()
        else
            v134 = nil
        end
        v133.sig = v134
        v133.fight.Activated:Connect(fight)
        u7 = v133
        u9 = false
        UI_upv_1.ResetFade(u4)
        u17()
        if not u11 then
            return
        end
        if UI_upv_1.Gamepad then
            local GuiService_2 = game:GetService("GuiService")
            GuiService_2.SelectedObject = u7.fight.Instance
        end
    end
    local function freshen()
        --[[
          name: freshen
          line: 1278
          upvalues:
            u7 (ref,  index: 1)
            build (copy, index: 2)
            u9 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            u13 (ref,  index: 5)
            u10 (ref,  index: 6)
        ]]
        if u7 then
            if not (u9) and u7.compact == UI_upv_1.Compact or u13 then
                return
            end
            local v135 = os.clock()
            if u10 <= v135 then
                build()
            end
        else
            build()
        end
    end
    if u1 == "Classic" then
        build()
    end
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 1288
              upvalues:
                u7 (ref,  index: 1)
                build (copy, index: 2)
                u9 (ref,  index: 3)
                UI_upv_1 (copy, index: 4)
                u13 (ref,  index: 5)
                u10 (ref,  index: 6)
                u17 (ref,  index: 7)
            ]]
            if u7 then
                if u7 then
                    if not (u9) and u7.compact == UI_upv_1.Compact or u13 then
                        u17()
                        return
                    end
                    local v136 = os.clock()
                    if u10 <= v136 then
                        build()
                    end
                else
                    build()
                end
            end
            u17()
        end
    )
    UI_upv_1.ScaleChanged:Connect(u17)
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 1295
              upvalues:
                u7 (ref, index: 1)
                u9 (ref, index: 2)
            ]]
            if not u7 or not u7.signature then
                return
            end
            if u7.signature() == u7.sig then
                if u7.refresh then
                    u7.refresh()
                end
            else
                u9 = true
            end
        end
    )
    local tbl_upv_49 = {}
    local function paintChips()
        --[[
          name: paintChips
          line: 1308
          upvalues:
            tbl_upv_49 (copy, index: 1)
            u1 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v137 = nil
        for key_6, value_12 in tbl_upv_49 do
            if key_6 ~= u1 then
                v137 = Colors_upv_1.Raised
            else
                v137 = Colors_upv_1.Accent
            end
            value_12.BackgroundColor3 = v137
        end
    end
    local function setVersion(a69)
        --[[
          name: setVersion
          line: 1313
          upvalues:
            tbl_upv_11 (copy, index: 1)
            u13 (ref,  index: 2)
            u10 (ref,  index: 3)
            u1 (ref,  index: 4)
            u7 (ref,  index: 5)
            build (copy, index: 6)
            tbl_upv_49 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            u11 (ref,  index: 9)
        ]]
        if type(a69) == "string" and tbl_upv_11[a69] then
            if u13 or os.clock() < u10 then
                return false
            end
            if a69 ~= u1 then
                u1 = a69
                if u7 then
                    build()
                end
                local v138 = nil
                for key_7, value_13 in tbl_upv_49 do
                    if key_7 ~= u1 then
                        v138 = Colors_upv_1.Raised
                    else
                        v138 = Colors_upv_1.Accent
                    end
                    value_13.BackgroundColor3 = v138
                end
                if u11 and u7 and u7.opened then
                    u7.opened()
                end
            end
            return true
        end
        return false
    end
    if v6 then
        local tbl_50 = {}
        tbl_50.Name = "VersionSwitch"
        tbl_50.AnchorPoint = Vector2.new(0.5, 0)
        tbl_50.Position = UDim2.new(0.5, 0, 0, 6)
        tbl_50.AutomaticSize = Enum.AutomaticSize.X
        tbl_50.BackgroundColor3 = Colors_upv_1.Void
        tbl_50.BackgroundTransparency = 0.2
        tbl_50[1], tbl_50[2], tbl_50[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(4, 5, 4, 14), UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_50.Parent = u2
        local u50 = UI_upv_1.new("Frame", tbl_50)
        local u51 = UI_upv_1.new("TextLabel", {LayoutOrder = 0, Name = "Label", Text = "STAGING PREVIEW", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextMuted, Parent = u50})
        for key_8, value_upv_14 in tbl_upv_2 do
            local v139 = UI_upv_1.new("TextButton", {Name = value_upv_14.id, BackgroundColor3 = Colors_upv_1.Raised, Text = value_upv_14.chip, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, LayoutOrder = key_8, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u50})
            v139.Activated:Connect(
                function()
                    --[[
                      line: 1363
                      upvalues:
                        a1 (copy, index: 1)
                        setVersion (copy, index: 2)
                        value_upv_14 (copy, index: 3)
                    ]]
                    a1.Sounds.Play("Click")
                    setVersion(value_upv_14.id)
                end
            )
            tbl_upv_49[value_upv_14.id] = v139
        end
        local function sizeSwitch()
            --[[
              name: sizeSwitch
              line: 1370
              upvalues:
                UI_upv_1 (copy, index: 1)
                u50 (copy, index: 2)
                u51 (copy, index: 3)
                tbl_upv_49 (copy, index: 4)
            ]]
            local Compact_2 = UI_upv_1.Compact
            u50.Size = UDim2.fromOffset(0, (Compact_2 and 54) or 40)
            u51.TextSize = (Compact_2 and 15) or 13
            for _, value_15 in tbl_upv_49 do
                value_15.Size = UDim2.fromOffset((Compact_2 and 74) or 52, (Compact_2 and 46) or 32)
                value_15.TextSize = (Compact_2 and 18) or 15
            end
        end
        sizeSwitch()
        UI_upv_1.LayoutChanged:Connect(sizeSwitch)
        local v140 = nil
        for key_9, value_16 in tbl_upv_49 do
            if key_9 ~= u1 then
                v140 = Colors_upv_1.Raised
            else
                v140 = Colors_upv_1.Accent
            end
            value_16.BackgroundColor3 = v140
        end
    end
    local tbl_51 = {blur = false}
    function tbl_51.back()
        --[[
          name: back
          line: 1388
          upvalues:
            UI_upv_1 (copy, index: 1)
            u7 (ref,  index: 2)
        ]]
        if UI_upv_1.Gamepad then
            local GuiService_3 = game:GetService("GuiService")
            GuiService_3.SelectedObject = u7.fight.Instance
        end
        return true
    end
    function tbl_51.open()
        --[[
          name: open
          line: 1392
          upvalues:
            u14 (ref,  index: 1)
            u11 (ref,  index: 2)
            u13 (ref,  index: 3)
            u15 (ref,  index: 4)
            u7 (ref,  index: 5)
            build (copy, index: 6)
            u9 (ref,  index: 7)
            UI_upv_1 (copy, index: 8)
            u10 (ref,  index: 9)
            a1 (copy, index: 10)
            u17 (ref,  index: 11)
            u2 (copy, index: 12)
            u3 (copy, index: 13)
            u4 (copy, index: 14)
            tbl_upv_5 (copy, index: 15)
            State_upv_1 (copy, index: 16)
        ]]
        u14 = u14 + 1
        u11 = true
        u13 = false
        u15 = false
        if u7 then
            if not (u9) and u7.compact == UI_upv_1.Compact or u13 then
                u7.fight:SetText("FIGHT")
                a1.SetHudHidden("Welcome", true)
                if a1.TopbarSettings then
                    a1.TopbarSettings.SetHidden("Welcome", true)
                end
                u17()
                u2.Visible = true
                u3.Visible = true
                u3.BackgroundTransparency = 1
                local tbl_52 = {BackgroundTransparency = 0.5}
                UI_upv_1.Tween(u3, TweenInfo.new(0.35, Enum.EasingStyle.Quad), tbl_52)
                UI_upv_1.Enter(u4, Vector2.new(0, 28), 0.05, u4.Position)
                a1.Sounds.Play("Open")
                if not (tbl_upv_5.Welcome) and not (State_upv_1.Mock) then
                    local v141 = a1.Remotes.Fire("AnalyticsReport", "Welcome", nil)
                    if v141 then
                        tbl_upv_5.Welcome = true
                    end
                end
                if UI_upv_1.Gamepad then
                    local GuiService_4 = game:GetService("GuiService")
                    GuiService_4.SelectedObject = u7.fight.Instance
                end
                if u7.opened then
                    u7.opened()
                end
                return
            end
            local v142 = os.clock()
            if u10 <= v142 then
                build()
            end
        else
            build()
        end
        u7.fight:SetText("FIGHT")
        a1.SetHudHidden("Welcome", true)
        if a1.TopbarSettings then
            a1.TopbarSettings.SetHidden("Welcome", true)
        end
        u17()
        u2.Visible = true
        u3.Visible = true
        u3.BackgroundTransparency = 1
        local tbl_52 = {BackgroundTransparency = 0.5}
        UI_upv_1.Tween(u3, TweenInfo.new(0.35, Enum.EasingStyle.Quad), tbl_52)
        UI_upv_1.Enter(u4, Vector2.new(0, 28), 0.05, u4.Position)
        a1.Sounds.Play("Open")
        if not (tbl_upv_5.Welcome) and not (State_upv_1.Mock) then
            local v141 = a1.Remotes.Fire("AnalyticsReport", "Welcome", nil)
            if v141 then
                tbl_upv_5.Welcome = true
            end
        end
        if UI_upv_1.Gamepad then
            local GuiService_4 = game:GetService("GuiService")
            GuiService_4.SelectedObject = u7.fight.Instance
        end
        if not u7.opened then
            return
        end
        u7.opened()
    end
    function tbl_51.close(a70)
        --[[
          name: close
          line: 1413
          upvalues:
            u14 (ref,  index: 1)
            u11 (ref,  index: 2)
            u15 (ref,  index: 3)
            a1 (copy, index: 4)
            u12 (ref,  index: 5)
            State_upv_1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            u3 (copy, index: 8)
            u2 (copy, index: 9)
            u10 (ref,  index: 10)
            u4 (copy, index: 11)
        ]]
        u14 = u14 + 1
        local u52 = u14
        u11 = false
        if not (u15) then
            a1.SetHudHidden("Welcome", false)
            if a1.TopbarSettings then
                a1.TopbarSettings.SetHidden("Welcome", false)
            end
            if not (u12) and not (State_upv_1.InMatch()) then
                u12 = true
                task.spawn(a1.QueueAction, "DismissWelcome")
            end
        end
        UI_upv_1.Tween(u3, TweenInfo.new((a70 and 0) or 0.2), {BackgroundTransparency = 1})
        if a70 then
            u2.Visible = false
            u3.Visible = false
        else
            u10 = os.clock() + 0.3
            UI_upv_1.FadeOut(u4, TweenInfo.new(0.16))
            task.delay(
                0.2,
                function()
                    --[[
                      line: 1434
                      upvalues:
                        u52 (copy, index: 1)
                        u14 (ref,  index: 2)
                        u2 (copy, index: 3)
                        u3 (copy, index: 4)
                        UI_upv_1 (copy, index: 5)
                        u4 (copy, index: 6)
                    ]]
                    if u52 ~= u14 then
                        return
                    end
                    u2.Visible = false
                    u3.Visible = false
                    UI_upv_1.Unfade(u4)
                end
            )
        end
    end
    MenuManager_upv_1.Register("Welcome", tbl_51)
    State_upv_1.PlayerStateChanged:Connect(
        function()
            --[[
              line: 1444
              upvalues:
                State_upv_1 (copy, index: 1)
                u12 (ref,  index: 2)
                LocalPlayer_upv_1 (copy, index: 3)
                MenuManager_upv_1 (copy, index: 4)
            ]]
            if State_upv_1.InMatch() then
                local v143 = u12 or (LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true)
                u12 = v143
                if not MenuManager_upv_1.IsOpen("Welcome") then
                    return
                end
                MenuManager_upv_1.Close("Welcome", true)
            end
        end
    )
    local u53 = nil
    local function cardWanted()
        --[[
          name: cardWanted
          line: 1452
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            u12 (ref,  index: 2)
            u11 (ref,  index: 3)
        ]]
        local v144 = (LocalPlayer_upv_1:GetAttribute("WelcomeCard") == true) and (not u12 and (not u11))
        return v144
    end
    local function detourTick()
        --[[
          name: detourTick
          line: 1466
          upvalues:
            u15 (ref,  index: 1)
            u11 (ref,  index: 2)
            MenuManager_upv_1 (copy, index: 3)
            u16 (ref,  index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            u12 (ref,  index: 6)
            State_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        if not u15 or (u11) then
            return
        end
        if MenuManager_upv_1.IsOpen() then
            u16 = 0
        else
            u16 = u16 + 0.1
            if u16 < 0.2 then
                return
            end
            local v145 = (LocalPlayer_upv_1:GetAttribute("WelcomeCard") == true) and (not u12 and (not u11))
            local v146 = nil
            if v145 then
                v146 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
                if v146 then
                    if State_upv_1.InMatch() or State_upv_1.Get("Queued") == true or State_upv_1.Get("Teleporting") == true then
                        u15 = false
                        a1.SetHudHidden("Welcome", false)
                        if a1.TopbarSettings then
                            a1.TopbarSettings.SetHidden("Welcome", false)
                        end
                    else
                        MenuManager_upv_1.Open("Welcome")
                        return
                    end
                else
                    u15 = false
                    a1.SetHudHidden("Welcome", false)
                    if a1.TopbarSettings then
                        a1.TopbarSettings.SetHidden("Welcome", false)
                    end
                end
            else
                u15 = false
                a1.SetHudHidden("Welcome", false)
                if a1.TopbarSettings then
                    a1.TopbarSettings.SetHidden("Welcome", false)
                end
            end
        end
    end
    local u54 = false
    local u55 = 0
    local u56 = false
    local u57 = false
    local tbl_upv_53 = {{spread = 3, t = 0.5}, {spread = 8, t = 0.7}, {spread = 14, t = 0.83}, {spread = 21, t = 0.92}}
    local v147 = Color3.fromRGB(150, 210, 255)
    local u58 = UI_upv_1.new("Frame", {Visible = false, Name = "NudgeGlow", ZIndex = 0, Size = UDim2.fromScale(1, 1), Parent = PlayButton_upv_1.Instance})
    local tbl_upv_54 = {}
    for key_10, value_17 in tbl_upv_53 do
        tbl_upv_54[key_10] = UI_upv_1.new("Frame", {Name = "Halo" .. key_10, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, value_17.spread * 2, 1, value_17.spread * 2), BackgroundColor3 = Colors_upv_1.Accent, BackgroundTransparency = 1, ZIndex = 0, [1] = UI_upv_1.Corner(16 + value_17.spread), Parent = u58})
    end
    local u59 = UI_upv_1.new("Frame", {Name = "Ripple", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0, [1] = UI_upv_1.Corner(16), Parent = u58})
    local u60 = UI_upv_1.Stroke(v147, 2, 1)
    u60.Parent = u59
    local u61 = Instance.new("NumberValue")
    u61.Parent = u58
    local u62 = 0
    local function paintGlow()
        --[[
          name: paintGlow
          line: 1532
          upvalues:
            u62 (ref,  index: 1)
            u61 (copy, index: 2)
            tbl_upv_53 (copy, index: 3)
            tbl_upv_54 (copy, index: 4)
        ]]
        local v148 = u62 * (0.55 + (0.45 * u61.Value))
        for key_11, value_18 in tbl_upv_53 do
            tbl_upv_54[key_11].BackgroundTransparency = 1 - ((1 - value_18.t) * v148)
        end
    end
    u61.Changed:Connect(paintGlow)
    local u63 = nil
    local u64 = 0
    local function fadeGlow(a71, a72, a73)
        --[[
          name: fadeGlow
          line: 1541
          upvalues:
            u62 (ref,  index: 1)
            u61 (copy, index: 2)
            tbl_upv_53 (copy, index: 3)
            tbl_upv_54 (copy, index: 4)
            TweenService_upv_1 (copy, index: 5)
        ]]
        local u65 = Instance.new("NumberValue")
        u65.Value = u62
        u65.Changed:Connect(
            function(a74)
                --[[
                  line: 1544
                  upvalues:
                    u62 (ref,  index: 1)
                    u61 (copy, index: 2)
                    tbl_upv_53 (copy, index: 3)
                    tbl_upv_54 (copy, index: 4)
                ]]
                u62 = a74
                local v149 = u62 * (0.55 + (0.45 * u61.Value))
                for key_12, value_19 in tbl_upv_53 do
                    tbl_upv_54[key_12].BackgroundTransparency = 1 - ((1 - value_19.t) * v149)
                end
            end
        )
        local v150 = TweenService_upv_1:Create(u65, TweenInfo.new(a72, Enum.EasingStyle.Quad), {Value = a71})
        v150.Completed:Connect(
            function()
                --[[
                  line: 1549
                  upvalues:
                    u65 (copy, index: 1)
                    a73 (copy, index: 2)
                ]]
                u65:Destroy()
                if not a73 then
                    return
                end
                a73()
            end
        )
        v150:Play()
    end
    local function setGlow(a75)
        --[[
          name: setGlow
          line: 1557
          upvalues:
            u56 (ref,  index: 1)
            u64 (ref,  index: 2)
            u63 (ref,  index: 3)
            u58 (copy, index: 4)
            u61 (copy, index: 5)
            fadeGlow (copy, index: 6)
            TweenService_upv_1 (copy, index: 7)
            u59 (copy, index: 8)
            u60 (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            tbl_upv_5 (copy, index: 11)
            State_upv_1 (copy, index: 12)
            a1 (copy, index: 13)
        ]]
        if a75 == u56 then
            return
        end
        u56 = a75
        u64 = u64 + 1
        local u66 = u64
        if u63 then
            u63:Cancel()
            u63 = nil
        end
        if a75 then
            u58.Visible = true
            u61.Value = 0
            fadeGlow(1, 0.6)
            local tbl_55 = {Value = 1}
            local v151 = TweenService_upv_1:Create(u61, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), tbl_55)
            u63 = v151
            v151:Play()
            task.spawn(
                function()
                    --[[
                      line: 1575
                      upvalues:
                        u66 (copy, index: 1)
                        u64 (ref,  index: 2)
                        u59 (copy, index: 3)
                        u60 (copy, index: 4)
                        UI_upv_1 (copy, index: 5)
                    ]]
                    task.wait(0.8)
                    while u66 == u64 do
                        u59.Size = UDim2.fromScale(1, 1)
                        u60.Transparency = 0.25
                        local v152 = TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        UI_upv_1.Tween(u59, v152, {Size = UDim2.new(1, 52, 1, 52)})
                        UI_upv_1.Tween(u60, v152, {Transparency = 1})
                        task.wait(2.6)
                    end
                end
            )
            if not tbl_upv_5["Nudge:Glow"] and not State_upv_1.Mock and a1.Remotes.Fire("AnalyticsReport", "Nudge", "Glow") then
                tbl_upv_5["Nudge:Glow"] = true
            end
        else
            u60.Transparency = 1
            fadeGlow(0, 0.15, function() end)
        end
    end
    local u67 = UI_upv_1.Panel({StrokeThickness = 1.5, StrokeTransparency = 0.4, Name = "PlayCallout", Visible = false, BackgroundTransparency = 0.08, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(0, 52), AutomaticSize = Enum.AutomaticSize.X, StrokeColor = Colors_upv_1.Accent, Radius = UDim.new(0, 14), Parent = LobbyHud_upv_1.Root})
    UI_upv_1.Padding(0, 10, 0, 18).Parent = u67
    local v153 = UI_upv_1.new("Frame", {Name = "Row", Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u67})
    local u68 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Text = "Start your first match", Name = "Text", TextSize = 20, Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = v153})
    local u69 = UI_upv_1.new("Frame", {LayoutOrder = 2, Name = "Arrow", Size = UDim2.fromOffset(30, 30), Parent = v153})
    local u70 = UI_upv_1.new("Frame", {Name = "Bob", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(30, 30), Parent = u69})
    u69 = UI_upv_1.Icon("chevRight", 22, Colors_upv_1.Accent, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u70})
    local u71 = nil
    local u72 = 0
    local function sizeCallout()
        --[[
          name: sizeCallout
          line: 1650
          upvalues:
            UI_upv_1 (copy, index: 1)
            u68 (copy, index: 2)
            u67 (copy, index: 3)
            u69 (copy, index: 4)
        ]]
        local Compact_3 = UI_upv_1.Compact
        u68.TextSize = (Compact_3 and 22) or 20
        u67.Size = UDim2.fromOffset(0, (Compact_3 and 56) or 52)
        u69.Size = UDim2.fromOffset((Compact_3 and 24) or 22, (Compact_3 and 24) or 22)
    end
    local Compact_4 = UI_upv_1.Compact
    u68.TextSize = (Compact_4 and 22) or 20
    u67.Size = UDim2.fromOffset(0, (Compact_4 and 56) or 52)
    local v154 = (Compact_4 and 24) or 22
    u69.Size = UDim2.fromOffset(v154, (Compact_4 and 24) or 22)
    UI_upv_1.LayoutChanged:Connect(sizeCallout)
    local function placeCallout()
        --[[
          name: placeCallout
          line: 1641
          upvalues:
            UI_upv_1 (copy, index: 1)
            PlayButton_upv_1 (copy, index: 2)
            LobbyHud_upv_1 (copy, index: 3)
            u67 (copy, index: 4)
        ]]
        local v155 = math.max(UI_upv_1.Scale, 0.01)
        local Instance_1 = PlayButton_upv_1.Instance
        local Root_1 = LobbyHud_upv_1.Root
        u67.Position = UDim2.fromOffset(math.floor(((Instance_1.AbsolutePosition.X - Root_1.AbsolutePosition.X) / v155) - 14), math.floor(((Instance_1.AbsolutePosition.Y - Root_1.AbsolutePosition.Y) / v155) + (((Instance_1.AbsoluteSize.Y / v155) - 3) / 2)))
    end
    PlayButton_upv_1.Instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(
        function()
            --[[
              line: 1658
              upvalues:
                u57 (ref,  index: 1)
                placeCallout (copy, index: 2)
            ]]
            if not u57 then
                return
            end
            placeCallout()
        end
    )
    PlayButton_upv_1.Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        function()
            --[[
              line: 1663
              upvalues:
                u57 (ref,  index: 1)
                placeCallout (copy, index: 2)
            ]]
            if not u57 then
                return
            end
            placeCallout()
        end
    )
    local function setCallout(a76)
        --[[
          name: setCallout
          line: 1669
          upvalues:
            u57 (ref,  index: 1)
            u72 (ref,  index: 2)
            u71 (ref,  index: 3)
            u70 (copy, index: 4)
            placeCallout (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u67 (copy, index: 7)
            TweenService_upv_1 (copy, index: 8)
            tbl_upv_5 (copy, index: 9)
            State_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
        ]]
        if a76 == u57 then
            return
        end
        u57 = a76
        u72 = u72 + 1
        local _ = u72
        if u71 then
            u71:Cancel()
            u71 = nil
            u70.Position = UDim2.fromScale(0.5, 0.5)
        end
        if a76 then
            placeCallout()
            UI_upv_1.Unfade(u67)
            u67.Visible = true
            UI_upv_1.Enter(u67, Vector2.new(-18, 0), 0, u67.Position)
            local v156 = TweenService_upv_1:Create(u70, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(0.5, 5, 0.5, 0)})
            u71 = v156
            v156:Play()
            if not tbl_upv_5["Nudge:Callout"] and not State_upv_1.Mock and a1.Remotes.Fire("AnalyticsReport", "Nudge", "Callout") then
                tbl_upv_5["Nudge:Callout"] = true
            end
        else
            UI_upv_1.FadeOut(u67, TweenInfo.new(0.14))
            task.delay(0.16, function() end)
        end
    end
    local function nudgeEligible()
        --[[
          name: nudgeEligible
          line: 1705
          upvalues:
            u54 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
        ]]
        if not (u54) and not (State_upv_1.Mock) and State_upv_1.HasProfile then
            local v157 = State_upv_1.Profile and (State_upv_1.Profile.stats)
            if type(v157) == "table" and not ((tonumber(v157.matches) or 0) > 0) then
                local v158 = LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true
                return v158
            end
            return false
        end
        return false
    end
    local function playOnScreen()
        --[[
          name: playOnScreen
          line: 1715
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            LobbyHud_upv_1 (copy, index: 3)
            PlayButton_upv_1 (copy, index: 4)
            MenuManager_upv_1 (copy, index: 5)
        ]]
        local v159 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
        if v159 then
            v159 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
        end
        if v159 then
            v159 = PlayButton_upv_1.Instance.Visible and (not MenuManager_upv_1.IsOpen() and (State_upv_1.Get("Queued") ~= true))
        end
        return v159
    end
    PlayButton_upv_1.Activated:Connect(
        function()
            --[[
              line: 1718
              upvalues:
                u54 (ref,  index: 1)
                u56 (ref,  index: 2)
                u64 (ref,  index: 3)
                u63 (ref,  index: 4)
                u60 (copy, index: 5)
                fadeGlow (copy, index: 6)
                u57 (ref,  index: 8)
                u72 (ref,  index: 9)
                u71 (ref,  index: 10)
                u70 (copy, index: 11)
                UI_upv_1 (copy, index: 12)
                u67 (copy, index: 13)
            ]]
            u54 = true
            if u56 ~= false then
                u56 = false
                u64 = u64 + 1
                local _ = u64
                if u63 then
                    u63:Cancel()
                    u63 = nil
                end
                u60.Transparency = 1
                fadeGlow(0, 0.15, function() end)
            end
            if u57 == false then
                return
            end
            u57 = false
            u72 = u72 + 1
            local _ = u72
            if u71 then
                u71:Cancel()
                u71 = nil
                u70.Position = UDim2.fromScale(0.5, 0.5)
            end
            UI_upv_1.FadeOut(u67, TweenInfo.new(0.14))
            task.delay(0.16, function() end)
        end
    )
    local function readyForCard()
        --[[
          name: readyForCard
          line: 1455
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            MenuManager_upv_1 (copy, index: 4)
        ]]
        local v160 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
        if v160 then
            v160 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (not a1.HudHidden and ((LocalPlayer_upv_1.Character ~= nil) and (not MenuManager_upv_1.IsOpen() and ((State_upv_1.Get("Queued") ~= true) and (State_upv_1.Get("Teleporting") ~= true))))))
        end
        return v160
    end
    UI_upv_1.Every(
        u2,
        0.1,
        function()
            --[[
              line: 1725
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                State_upv_1 (copy, index: 2)
                LobbyHud_upv_1 (copy, index: 3)
                tbl_upv_5 (copy, index: 4)
                a1 (copy, index: 5)
                u7 (ref,  index: 6)
                build (copy, index: 7)
                u9 (ref,  index: 8)
                UI_upv_1 (copy, index: 9)
                u13 (ref,  index: 10)
                u10 (ref,  index: 11)
                detourTick (copy, index: 12)
                u12 (ref,  index: 13)
                u11 (ref,  index: 14)
                readyForCard (copy, index: 15)
                u53 (ref,  index: 16)
                MenuManager_upv_1 (copy, index: 17)
                u54 (ref,  index: 18)
                PlayButton_upv_1 (copy, index: 19)
                u55 (ref,  index: 20)
                setGlow (copy, index: 21)
                setCallout (copy, index: 22)
            ]]
            local v161 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
            if v161 then
                v161 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
            end
            local v162 = nil
            if v161 then
                v161 = math.floor(time() * 10) / 10
                local v163 = ((type(v161) ~= "string") and "") or (":" .. v161)
                v162 = "Loaded" .. v163
                if not (tbl_upv_5[v162]) and not (State_upv_1.Mock) and a1.Remotes.Fire("AnalyticsReport", "Loaded", v161) then
                    tbl_upv_5[v162] = true
                end
            end
            if u7 then
                if u7 then
                    if not (u9) and u7.compact == UI_upv_1.Compact or u13 then
                        detourTick()
                        v161 = (LocalPlayer_upv_1:GetAttribute("WelcomeCard") == true) and (not u12 and (not u11))
                        if (v161) and (readyForCard()) then
                            v161 = u53 or (os.clock())
                            u53 = v161
                            if os.clock() - u53 >= 0.6 then
                                u53 = nil
                                MenuManager_upv_1.Open("Welcome")
                            end
                        else
                            u53 = nil
                        end
                        if not u54 and not State_upv_1.Mock and State_upv_1.HasProfile then
                            local v164 = State_upv_1.Profile and (State_upv_1.Profile.stats)
                            if type(v164) ~= "table" or (tonumber(v164.matches) or 0) > 0 then
                                v161 = false
                            else
                                v161 = LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true
                            end
                        else
                            v161 = false
                        end
                        if v161 then
                            v161 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
                            if v161 then
                                v161 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
                            end
                            if v161 then
                                v161 = PlayButton_upv_1.Instance.Visible and (not MenuManager_upv_1.IsOpen() and (State_upv_1.Get("Queued") ~= true))
                            end
                        end
                        if v161 then
                            u55 = u55 + 0.1
                        end
                        setGlow(v161)
                        if v161 then
                            v161 = false
                            if u55 >= 6 then
                                if State_upv_1.Get("CombatMode") ~= true then
                                    local _ = true
                                else
                                    local _ = false
                                end
                            end
                        end
                        setCallout(v161)
                        return
                    end
                    v161 = os.clock()
                    if u10 <= v161 then
                        build()
                    end
                else
                    build()
                end
            end
            detourTick()
            v161 = (LocalPlayer_upv_1:GetAttribute("WelcomeCard") == true) and (not u12 and (not u11))
            if (v161) and (readyForCard()) then
                v161 = u53 or (os.clock())
                u53 = v161
                if os.clock() - u53 >= 0.6 then
                    u53 = nil
                    MenuManager_upv_1.Open("Welcome")
                end
            else
                u53 = nil
            end
            if not u54 and not State_upv_1.Mock and State_upv_1.HasProfile then
                local v164 = State_upv_1.Profile and (State_upv_1.Profile.stats)
                if type(v164) ~= "table" or (tonumber(v164.matches) or 0) > 0 then
                    v161 = false
                else
                    v161 = LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true
                end
            else
                v161 = false
            end
            if v161 then
                v161 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
                if v161 then
                    v161 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
                end
                if v161 then
                    v161 = PlayButton_upv_1.Instance.Visible and (not MenuManager_upv_1.IsOpen() and (State_upv_1.Get("Queued") ~= true))
                end
            end
            if v161 then
                u55 = u55 + 0.1
            end
            setGlow(v161)
            if v161 then
                v161 = false
                if u55 >= 6 then
                    if State_upv_1.Get("CombatMode") ~= true then
                        local _ = true
                    else
                        local _ = false
                    end
                end
            end
            setCallout(v161)
        end
    )
    local function resetSession()
        --[[
          name: resetSession
          line: 1753
          upvalues:
            u12 (ref,  index: 1)
            u13 (ref,  index: 2)
            u54 (ref,  index: 3)
            u55 (ref,  index: 4)
            u53 (ref,  index: 5)
            u15 (ref,  index: 6)
            a1 (copy, index: 7)
            u56 (ref,  index: 8)
            u64 (ref,  index: 9)
            u63 (ref,  index: 10)
            u60 (copy, index: 11)
            fadeGlow (copy, index: 12)
            u57 (ref,  index: 14)
            u72 (ref,  index: 15)
            u71 (ref,  index: 16)
            u70 (copy, index: 17)
            UI_upv_1 (copy, index: 18)
            u67 (copy, index: 19)
            tbl_upv_5 (copy, index: 20)
        ]]
        u12 = false
        u13 = false
        u54 = false
        u55 = 0
        u53 = nil
        if u15 then
            u15 = false
            a1.SetHudHidden("Welcome", false)
            if a1.TopbarSettings then
                a1.TopbarSettings.SetHidden("Welcome", false)
            end
        end
        if u56 ~= false then
            u56 = false
            u64 = u64 + 1
            local _ = u64
            if u63 then
                u63:Cancel()
                u63 = nil
            end
            u60.Transparency = 1
            fadeGlow(0, 0.15, function() end)
        end
        if u57 ~= false then
            u57 = false
            u72 = u72 + 1
            local _ = u72
            if u71 then
                u71:Cancel()
                u71 = nil
                u70.Position = UDim2.fromScale(0.5, 0.5)
            end
            UI_upv_1.FadeOut(u67, TweenInfo.new(0.14))
            task.delay(0.16, function() end)
        end
        table.clear(tbl_upv_5)
    end
    if RunService_upv_1:IsStudio() or game.PlaceId == Config_1.STAGING_PLACE_ID then
        a1.ReplayNewPlayer = function(a77)
            --[[
              line: 1766
              upvalues:
                a1 (copy, index: 1)
                u12 (ref,  index: 2)
                u13 (ref,  index: 3)
                u54 (ref,  index: 4)
                u55 (ref,  index: 5)
                u53 (ref,  index: 6)
                u15 (ref,  index: 7)
                u56 (ref,  index: 8)
                u64 (ref,  index: 9)
                u63 (ref,  index: 10)
                u60 (copy, index: 11)
                fadeGlow (copy, index: 12)
                u57 (ref,  index: 14)
                u72 (ref,  index: 15)
                u71 (ref,  index: 16)
                u70 (copy, index: 17)
                UI_upv_1 (copy, index: 18)
                u67 (copy, index: 19)
                tbl_upv_5 (copy, index: 20)
                MenuManager_upv_1 (copy, index: 21)
            ]]
            local v165 = a1.QueueAction((a77 and "ReplayFullHub") or "ReplayNewPlayer")
            if v165 then
                u12 = false
                u13 = false
                u54 = false
                u55 = 0
                u53 = nil
                if u15 then
                    u15 = false
                    a1.SetHudHidden("Welcome", false)
                    if a1.TopbarSettings then
                        a1.TopbarSettings.SetHidden("Welcome", false)
                    end
                end
                if u56 ~= false then
                    u56 = false
                    u64 = u64 + 1
                    local _ = u64
                    if u63 then
                        u63:Cancel()
                        u63 = nil
                    end
                    u60.Transparency = 1
                    fadeGlow(0, 0.15, function() end)
                end
                if u57 ~= false then
                    u57 = false
                    u72 = u72 + 1
                    local _ = u72
                    if u71 then
                        u71:Cancel()
                        u71 = nil
                        u70.Position = UDim2.fromScale(0.5, 0.5)
                    end
                    UI_upv_1.FadeOut(u67, TweenInfo.new(0.14))
                    task.delay(0.16, function() end)
                end
                table.clear(tbl_upv_5)
                MenuManager_upv_1.CloseAll()
                a1.Toast((a77 and "Full hub: FIGHT sends you to a match server") or "New-player flow reset", "success")
            end
            return v165
        end
    end
    a1.Debug.onboarding = function(a78, a79)
        --[[
          line: 1778
          upvalues:
            fight (copy, index: 1)
            explore (copy, index: 2)
            customize (copy, index: 3)
            setVersion (copy, index: 4)
            u7 (ref,  index: 5)
            u12 (ref,  index: 6)
            u13 (ref,  index: 7)
            u54 (ref,  index: 8)
            u55 (ref,  index: 9)
            u53 (ref,  index: 10)
            u15 (ref,  index: 11)
            a1 (copy, index: 12)
            u56 (ref,  index: 13)
            u64 (ref,  index: 14)
            u63 (ref,  index: 15)
            u60 (copy, index: 16)
            fadeGlow (copy, index: 17)
            u58 (copy, index: 18)
            u57 (ref,  index: 19)
            u72 (ref,  index: 20)
            u71 (ref,  index: 21)
            u70 (copy, index: 22)
            UI_upv_1 (copy, index: 23)
            u67 (copy, index: 24)
            tbl_upv_5 (copy, index: 25)
            LocalPlayer_upv_1 (copy, index: 26)
            u11 (ref,  index: 27)
            u1 (ref,  index: 28)
            u4 (copy, index: 29)
            u5 (copy, index: 30)
            readyForCard (copy, index: 31)
            State_upv_1 (copy, index: 32)
            LobbyHud_upv_1 (copy, index: 33)
            PlayButton_upv_1 (copy, index: 34)
            MenuManager_upv_1 (copy, index: 35)
        ]]
        if a78 == "fight" then
            task.spawn(fight)
        elseif a78 == "explore" then
            task.spawn(explore)
        elseif a78 == "customize" then
            task.spawn(customize)
        elseif a78 == "version" then
            return (setVersion(a79))
        elseif a78 ~= "pick" then
            if a78 == "reset" then
                u12 = false
                u13 = false
                u54 = false
                u55 = 0
                u53 = nil
                if u15 then
                    u15 = false
                    a1.SetHudHidden("Welcome", false)
                    if a1.TopbarSettings then
                        a1.TopbarSettings.SetHidden("Welcome", false)
                    end
                end
                if u56 ~= false then
                    u56 = false
                    u64 = u64 + 1
                    local u73 = u64
                    if u63 then
                        u63:Cancel()
                        u63 = nil
                    end
                    u60.Transparency = 1
                    fadeGlow(
                        0,
                        0.15,
                        function()
                            --[[
                              line: 1589
                              upvalues:
                                u73 (copy, index: 1)
                                u64 (ref,  index: 2)
                                u58 (copy, index: 3)
                            ]]
                            if u73 ~= u64 then
                                return
                            end
                            u58.Visible = false
                        end
                    )
                end
                if u57 ~= false then
                    u57 = false
                    u72 = u72 + 1
                    local u74 = u72
                    if u71 then
                        u71:Cancel()
                        u71 = nil
                        u70.Position = UDim2.fromScale(0.5, 0.5)
                    end
                    UI_upv_1.FadeOut(u67, TweenInfo.new(0.14))
                    task.delay(
                        0.16,
                        function()
                            --[[
                              line: 1696
                              upvalues:
                                u74 (copy, index: 1)
                                u72 (ref,  index: 2)
                                u67 (copy, index: 3)
                                UI_upv_1 (copy, index: 4)
                            ]]
                            if u74 ~= u72 then
                                return
                            end
                            u67.Visible = false
                            UI_upv_1.Unfade(u67)
                        end
                    )
                end
                table.clear(tbl_upv_5)
            elseif a78 == "callout" then
                u55 = math.max(u55, 6)
            end
        elseif u7 and u7.pick and type(a79) == "number" then
            task.spawn(u7.pick, a79)
        else
            return false
        end
        local tbl_56 = {}
        for key_13 in tbl_upv_5 do
            table.insert(tbl_56, key_13)
        end
        table.sort(tbl_56)
        local tbl_57 = {want = 0, answered = 0, callout = 0, playOnScreen = 0, pressed = 0, sent = 0, eligible = 0, glow = 0, onScreen = 0, ready = 0, version = 0, card = 0, lobbyShown = 0, built = 0, detour = 0, size = 0}
        tbl_57.want = LocalPlayer_upv_1:GetAttribute("WelcomeCard") == true
        tbl_57.card = u11
        tbl_57.version = u1
        tbl_57.built = u7 and (u7.version)
        tbl_57.detour = u15
        tbl_57.size = string.format("%dx%d @%.2f", u4.Size.X.Offset, u4.Size.Y.Offset, u5.Scale)
        tbl_57.answered = u12
        tbl_57.ready = readyForCard()
        local v167 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
        if v167 then
            v167 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
        end
        tbl_57.lobbyShown = v167
        if not u54 and not State_upv_1.Mock and State_upv_1.HasProfile then
            local v168 = State_upv_1.Profile and (State_upv_1.Profile.stats)
            if type(v168) ~= "table" or (tonumber(v168.matches) or 0) > 0 then
                v167 = false
            else
                v167 = LocalPlayer_upv_1:GetAttribute("WelcomeCard") ~= true
            end
        else
            v167 = false
        end
        tbl_57.eligible = v167
        v167 = LocalPlayer_upv_1:GetAttribute("LoadingShownMs") ~= nil
        if v167 then
            v167 = State_upv_1.HasProfile and (not State_upv_1.InMatch() and (LobbyHud_upv_1.Root.Visible))
        end
        if v167 then
            v167 = PlayButton_upv_1.Instance.Visible and (not MenuManager_upv_1.IsOpen() and (State_upv_1.Get("Queued") ~= true))
        end
        tbl_57.playOnScreen = v167
        tbl_57.glow = u56
        tbl_57.callout = u57
        tbl_57.onScreen = math.floor(u55 * 10) / 10
        tbl_57.pressed = u54
        tbl_57.sent = table.concat(tbl_56, ",")
        return tbl_57
    end
end
return tbl_1