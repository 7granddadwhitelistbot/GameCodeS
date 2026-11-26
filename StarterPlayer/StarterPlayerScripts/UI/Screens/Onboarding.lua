local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local v5 = {}
local v6 = {{id = "Classic", chip = "NOW"}, {id = "Pitch", chip = "A"}, {id = "Builds", chip = "B"}, {id = "Briefing", chip = "C"}}
local color3FromRGB = Color3.fromRGB
local v8 = {bow = color3FromRGB(56, 189, 248), gun = color3FromRGB(251, 146, 60), melee = color3FromRGB(248, 113, 113), throwable = color3FromRGB(167, 139, 250), utility = color3FromRGB(250, 204, 21), healing = color3FromRGB(74, 222, 128), armor = color3FromRGB(148, 197, 255)}
local v9 = {
    ["bronze_sword,short_bow,bandage|hide_armor"] = {name = "ALL-ROUNDER", line = "Sword, bow and armor.\nReady for anything."},
    ["short_bow,throwing_knives,smoke_bomb,bandage|hide_armor"] = {name = "ARCHER", line = "Bow, knives and armor.\nFight from range."},
    ["war_club,short_bow,smoke_bomb,bandage|hide_armor"] = {name = "BRAWLER", line = "Hammer, bow and armor.\nWin up close."},
    ["bronze_sword,throwing_knives,sling,bandage,smoke_bomb|hide_armor"] = {name = "DUELIST", line = "Sword, knives and smoke.\nOutplay them."},
    ["short_bow,war_club,bandage|hide_armor"] = {name = "HUNTER", line = "Bow and hammer.\nHit hard at any range."}
}

function v5.Init(a10)
    --[[
      name: Init
      line: 86
      upvalues:
        players (copy, index: 1)
        replicatedStorage (copy, index: 2)
        runService (copy, index: 3)
        v8 (copy, index: 4)
        v9 (copy, index: 5)
        v6 (copy, index: 6)
        tweenService (copy, index: 7)
    ]]
    local v11
    local textSize
    local ui = a10.UI
    local theme = a10.Theme
    local state = a10.State
    local menuManager = a10.MenuManager
    local weaponInfo = a10.WeaponInfo
    local weaponIcon = a10.WeaponIcon
    local portraits = a10.Portraits
    local colors = theme.Colors
    local fonts = theme.Fonts
    local localPlayer = players.LocalPlayer
    local lobbyHud = a10.LobbyHud
    if not lobbyHud then
        return
    end

    local playButton = lobbyHud.PlayButton
    local Config = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Config"))
    local v26 = {}

    local function report(a28, a29)
        --[[
          name: report
          line: 100
          upvalues:
            v26 (copy, index: 1)
            state (copy, index: 2)
            a10 (copy, index: 3)
        ]]
        local v30

        if type(a29) ~= "string" then
            v30 = ""
        else
            v30 = ":" .. a29
        end

        local v31 = a28 .. v30

        if not v26[v31] and not state.Mock and a10.Remotes.Fire("AnalyticsReport", a28, a29) then
            v26[v31] = true
        end
    end

    local function loadingDone()
        --[[
          name: loadingDone
          line: 110
          upvalues:
            localPlayer (copy, index: 1)
        ]]
        return localPlayer:GetAttribute("LoadingShownMs") ~= nil
    end

    local function lobbyShown()
        --[[
          name: lobbyShown
          line: 114
          upvalues:
            localPlayer (copy, index: 1)
            state (copy, index: 2)
            lobbyHud (copy, index: 3)
        ]]
        local v34 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
        v34 = v34 and state.HasProfile and not state.InMatch() and lobbyHud.Root.Visible

        return v34
    end

    menuManager.Changed:Connect(
        function(a35)
            --[[
              line: 118
              upvalues:
                state (copy, index: 1)
                localPlayer (copy, index: 2)
                v26 (copy, index: 3)
                a10 (copy, index: 4)
            ]]
            if a35 and a35 ~= "Welcome" and not state.InMatch() then
                local v36 = localPlayer:GetAttribute("LoadingShownMs") ~= nil

                if v36 and not v26.Menu then
                    if state.Mock then
                        return
                    end

                    if a10.Remotes.Fire("AnalyticsReport", "Menu", nil) then
                        v26.Menu = true
                    end
                end
            end
        end
    )

    local v37 = runService:IsStudio() or game.PlaceId == Config.STAGING_PLACE_ID

    if v37 then
        v11 = "Builds"
    else
        v11 = "Builds"
    end

    local parent = ui.new("Frame", {Name = "Welcome", Visible = false, Size = UDim2.fromScale(1, 1), Parent = a10.Canvas.Menus})
    local ui2 = ui.new("Frame", {Name = "WelcomeDim", BackgroundTransparency = 1, Visible = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = a10.Canvas.Backdrop})
    local parent2 = ui.new("Frame", {Name = "Card", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(560, 360), Parent = parent})
    local ui3 = ui.new("UIScale", {Parent = parent2})
    ui.DropShadow(parent2, 18, 8, 0.45)
    local parent3 = ui.Panel({Name = "Panel", BackgroundTransparency = 0.04, StrokeTransparency = 0.55, StrokeThickness = 1.5, Size = UDim2.fromScale(1, 1), StrokeColor = colors.Accent, Radius = UDim.new(0, 18), Parent = parent2})
    local v43 = nil
    local ui4 = nil
    local v45 = false
    local v46 = 0
    local card = false
    local answered = false
    local v49 = false
    local count = 0
    local detour = false
    local v52 = 0
    local v53 = nil

    local function stepAside(a55)
        --[[
          name: stepAside
          line: 172
          upvalues:
            a10 (copy, index: 1)
        ]]
        a10.SetHudHidden("Welcome", a55)

        if a10.TopbarSettings then
            a10.TopbarSettings.SetHidden("Welcome", a55)
        end
    end

    local function closeCard(a57)
        --[[
          name: closeCard
          line: 179
          upvalues:
            menuManager (copy, index: 1)
        ]]
        if menuManager.IsOpen("Welcome") then
            menuManager.Close("Welcome", a57)
        end
    end

    local function fight()
        --[[
          name: fight
          line: 185
          upvalues:
            v49 (ref,  index: 1)
            card (ref,  index: 2)
            answered (ref,  index: 3)
            detour (ref,  index: 4)
            a10 (copy, index: 5)
            v43 (ref,  index: 6)
            menuManager (copy, index: 7)
        ]]
        if v49 or not card then
            return
        end

        v49 = true
        answered = true
        detour = false
        a10.Sounds.Play("Queue_Join")
        v43.fight:SetText("STARTING…")

        task.spawn(
            function()
                --[[
                  line: 192
                  upvalues:
                    v43 (ref,  index: 1)
                    a10 (copy, index: 2)
                    v49 (ref,  index: 3)
                    menuManager (copy, index: 4)
                    answered (ref,  index: 5)
                ]]
                local timestamp = os.clock()

                while v43 and v43.selecting do
                    if not (os.clock() - timestamp < 1.5) then
                        break
                    end

                    task.wait()
                end

                local v60 = a10.QueueAction("FirstMatch")
                v49 = false

                if v60 then
                    if menuManager.IsOpen("Welcome") then
                        menuManager.Close("Welcome", nil)
                    end
                else
                    answered = false

                    if v43 then
                        v43.fight:SetText("FIGHT")
                    end
                end
            end
        )
    end

    local function explore()
        --[[
          name: explore
          line: 210
          upvalues:
            v49 (ref,  index: 1)
            card (ref,  index: 2)
            answered (ref,  index: 3)
            detour (ref,  index: 4)
            a10 (copy, index: 5)
            menuManager (copy, index: 6)
        ]]
        if v49 or not card then
            return
        end

        answered = true
        detour = false
        a10.Sounds.Play("Click")

        if menuManager.IsOpen("Welcome") then
            menuManager.Close("Welcome", nil)
        end

        task.spawn(a10.QueueAction, "Explore")
    end

    local function customize()
        --[[
          name: customize
          line: 219
          upvalues:
            v49 (ref,  index: 1)
            card (ref,  index: 2)
            detour (ref,  index: 3)
            v52 (ref,  index: 4)
            menuManager (copy, index: 5)
        ]]
        if not v49 and card then
            detour = true
            v52 = 0
            menuManager.Open("Loadout")

            if not menuManager.IsOpen("Loadout") then
                detour = false
            end
        end
    end

    local function px(a64, a65)
        --[[
          name: px
          line: 232
          upvalues:
            ui (copy, index: 1)
        ]]
        if ui.Compact then
            return a65
        end

        return a64
    end

    local function stacker(parent, a68, a69, a70)
        --[[
          name: stacker
          line: 237
          upvalues:
            ui (copy, index: 1)
        ]]
        local v71 = a70
        return {
            row = (function(a72, a73)
                --[[
                  name: row
                  line: 240
                  upvalues:
                    v71 (ref,  index: 1)
                    ui (copy, index: 2)
                    a68 (copy, index: 3)
                    a69 (copy, index: 4)
                    parent (copy, index: 5)
                ]]
                v71 += (a73 or 0)
                local ui2 = ui.new("Frame", {Position = UDim2.fromOffset(a68, v71), Size = UDim2.fromOffset(a69, a72), Parent = parent})
                v71 += a72

                return ui2
            end),
            skip = (function(a75)
                --[[
                  name: skip
                  line: 246
                  upvalues:
                    v71 (ref, index: 1)
                ]]
                v71 += a75
            end),
            y = (function()
                --[[
                  name: y
                  line: 249
                  upvalues:
                    v71 (ref, index: 1)
                ]]
                return v71
            end)
        }
    end

    local function heading(a77, text: string, text2: string, textSize, text3: string?, a82: number?)
        --[[
          name: heading
          line: 255
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local textSize2
        local newUi = ui.new
        local v85 = {Name = "Overline", Size = UDim2.fromScale(1, 1), Text = text, FontFace = fonts.Heavy}

        if ui.Compact then
            textSize2 = 18
        else
            textSize2 = 16
        end

        v85.TextSize = textSize2
        v85.TextColor3 = colors.Accent
        local row = a77.row
        local v87 = ui.Compact and 20 or 18
        v85.Parent = row(v87)
        newUi("TextLabel", v85)
        ui.new("TextLabel", {Name = "Title", Size = UDim2.fromScale(1, 1), Text = text2, FontFace = fonts.Display, TextSize = textSize, TextColor3 = colors.Text, Parent = a77.row(textSize + 4, 6)})

        if text3 then
            local textSize3 = ui.Compact and 21 or 19
            ui.new("TextLabel", {Name = "Blurb", TextWrapped = true, Size = UDim2.fromScale(1, 1), Text = text3, FontFace = fonts.Medium, TextSize = textSize3, TextColor3 = colors.TextDim, Parent = a77.row(math.ceil((textSize3 * 1.3) * (a82
                or 1)), 6)})
        end
    end

    local function fightButton(a90)
        --[[
          name: fightButton
          line: 289
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
        ]]
        return ui.Button({Name = "Fight", Text = "FIGHT", Style = "Primary", Radius = 16, Sound = false, TextSize = a90.TextSize, AnchorPoint = a90.AnchorPoint, Position = a90.Position, Size = a90.Size, Icon = ui.Image(ui.Assets.Icons.CrossedArrows, {Size = UDim2.fromOffset(36, 34), ImageColor3 = colors.Text}), LayoutOrder = a90.LayoutOrder, Parent = a90.Parent})
    end

    local function customizeButton(a92)
        --[[
          name: customizeButton
          line: 305
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            customize (copy, index: 3)
        ]]
        local v93 = ui.Button({Name = "Customize", Text = "CUSTOMIZE", Style = "Dark", Radius = 14, TextSize = a92.TextSize, AnchorPoint = a92.AnchorPoint, Position = a92.Position, Size = a92.Size, Icon = ui.Icon("pencil", math.floor(a92.TextSize * 0.95), colors.Text), Parent = a92.Parent})
        v93.Activated:Connect(customize)

        return v93
    end

    local function exploreLink(a95)
        --[[
          name: exploreLink
          line: 321
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
            theme (copy, index: 4)
            explore (copy, index: 5)
        ]]
        local parent = ui.new("TextButton", {Name = "Explore", BackgroundTransparency = 1, Text = "Explore the lobby first", AutoButtonColor = false, FontFace = fonts.Bold, TextColor3 = colors.TextDim})

        for v97, v98 in a95 do
            parent[v97] = v98
        end

        parent.MouseEnter:Connect(
            function()
                --[[
                  line: 333
                  upvalues:
                    ui (copy, index: 1)
                    parent (copy, index: 2)
                    theme (copy, index: 3)
                    colors (copy, index: 4)
                ]]
                ui.Tween(parent, theme.Tween.Fast, {TextColor3 = colors.Text})
            end
        )
        parent.MouseLeave:Connect(
            function()
                --[[
                  line: 336
                  upvalues:
                    ui (copy, index: 1)
                    parent (copy, index: 2)
                    theme (copy, index: 3)
                    colors (copy, index: 4)
                ]]
                ui.Tween(parent, theme.Tween.Fast, {TextColor3 = colors.TextDim})
            end
        )
        parent.Activated:Connect(explore)

        if ui.Touch then
            local newUi = ui.new
            local v100 = {Name = "Hit", Text = "", BackgroundTransparency = 1, AutoButtonColor = false, Selectable = false, Size = UDim2.new(1, 0, 0, (math.ceil(46 / math.max(ui.Scale, 0.1)))), Parent = parent}
            newUi("TextButton", v100).Activated:Connect(explore)
        end

        return parent
    end

    local function actionRow(a102, a103, a104)
        --[[
          name: actionRow
          line: 357
          upvalues:
            ui (copy, index: 1)
            fightButton (copy, index: 2)
            exploreLink (copy, index: 3)
        ]]
        local textSize
        local textSize2
        local v107 = ui.Compact and 88 or 80
        local parent = a102.row(v107, a104)
        local v109 = ui.Compact and 260 or 230
        local v110 = {Size = UDim2.fromOffset((a103 - v109) - 12, v107)}

        if ui.Compact then
            textSize = 44
        else
            textSize = 42
        end

        v110.TextSize = textSize
        v110.Parent = parent
        local v111 = fightButton(v110)
        local v112 = {AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.fromOffset(v109, v107)}

        if ui.Compact then
            textSize2 = 20
        else
            textSize2 = 18
        end

        v112.TextSize = textSize2
        v112.Parent = parent
        exploreLink(v112)

        return v111
    end

    local function kitOf(a114)
        --[[
          name: kitOf
          line: 373
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        local v115 = weaponInfo.Normalize(a114)
        local v116 = {}

        for _, icon in v115.items do
            if const v119 = weaponInfo.Get(icon) then
                table.insert(v116, {icon = icon, name = v119.name, points = v119.points, cat = v119.category})
            end
        end

        if v115.armor then
            if const v120 = weaponInfo.Get(v115.armor) then
                table.insert(v116, {cat = "armor", icon = v115.armor, name = v120.name, points = v120.points})
            end
        end

        for _, v122 in weaponInfo.AmmoTypes() do
            local v123 = v115.ammo[v122.id] or 0

            if 0 < v123 then
                local cat
                local v125 = {icon = "ammo_" .. v122.id, name = v122.name, points = v123 * v122.points}

                if v122.id == "arrows" then
                    cat = "bow"
                else
                    cat = "gun"
                end

                v125.cat = cat
                table.insert(v116, v125)
            end
        end

        return v116, weaponInfo.Cost(v115)
    end

    local function buildKey(a127)
        --[[
          name: buildKey
          line: 396
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        local v128 = weaponInfo.Normalize(a127)
        return table.concat(v128.items, ",") .. "|" .. (v128.armor or "")
    end

    local function loadoutSig(a130)
        --[[
          name: loadoutSig
          line: 400
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        local v131 = weaponInfo.Normalize(a130)
        local v132 = weaponInfo.Normalize(v131)
        local parts = {table.concat(v132.items, ",") .. "|" .. (v132.armor or "")}

        for _, v135 in weaponInfo.AmmoTypes() do
            table.insert(parts, (tostring((v131.ammo[v135.id] or 0))))
        end

        return table.concat(parts, "|")
    end

    local function tintGradient(parent, startValue, a139)
        --[[
          name: tintGradient
          line: 409
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
        ]]
        ui.Gradient(startValue:Lerp(colors.Panel, 1 - a139), colors.PanelHi:Lerp(colors.Panel, 0.6), 115).Parent = parent
    end

    local function itemTile(parent, a142, a143: number, a144: boolean, a145: number?)
        --[[
          name: itemTile
          line: 413
          upvalues:
            ui (copy, index: 1)
            v8 (copy, index: 2)
            colors (copy, index: 3)
            weaponIcon (copy, index: 4)
            fonts (copy, index: 5)
            theme (copy, index: 6)
        ]]
        local parent2 = ui.new("Frame", {Name = "Tile", Size = UDim2.fromOffset(a143, a143), BackgroundColor3 = Color3.new(1, 1, 1), LayoutOrder = a145
            or 0, (ui.Corner((math.max(6, (math.floor(a143 * 0.15)))))), Parent = parent})
        local v147 = v8[a142.cat] or colors.Accent
        ui.Gradient(v147:Lerp(colors.Panel, 0.6799999999999999), colors.PanelHi:Lerp(colors.Panel, 0.6), 115).Parent = parent2
        ui.Stroke(colors.Stroke, 1, 0.88).Parent = parent2
        local ui2 = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Parent = parent2})
        weaponIcon.Set(ui2, a142.icon, {outline = false, glow = false})
        local ui3 = nil

        if a144 then
            local v150 = math.max(18, (math.floor(a143 * 0.27)))
            ui3 = ui.new("TextLabel", {Name = "Cost", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 4), Size = UDim2.fromOffset(v150, v150), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, Text = tostring(a142.points), FontFace = fonts.Heavy, TextSize = math.floor(v150 * 0.66), TextColor3 = colors.Text, ZIndex = 3, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
        end

        return parent2, ui2, ui3
    end

    local function kitStrip(parent, a153, a154, a155, textSize)
        --[[
          name: kitStrip
          line: 455
          upvalues:
            ui (copy, index: 1)
            itemTile (copy, index: 2)
            fonts (copy, index: 3)
            colors (copy, index: 4)
        ]]
        local v157 = math.max(#a153, 1)
        local v158 = math.min(a155, (math.floor((a154 - ((v157 - 1) * 10)) / v157)))
        local v159 = a155 - 14 <= v158
        local v160 = textSize + 6
        local v161 = not v159 and 0 or v160 + 4
        local v162 = v158 + v161
        local parent2 = ui.new("Frame", {Name = "Kit", Size = UDim2.fromOffset(a154, v162), (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)), Parent = parent})
        local v164 = {}

        for layoutOrder, v166 in a153 do
            local parent3 = ui.new("Frame", {Name = "Item" .. layoutOrder, Size = UDim2.fromOffset(v158, v162), LayoutOrder = layoutOrder, Parent = parent2})
            local _, icon, cost = itemTile(parent3, v166, v158, true)

            if v159 then
                ui.new("TextLabel", {Name = "Name", Position = UDim2.fromOffset(-4, v158 + 4), Size = UDim2.fromOffset(v158 + 8, v160), Text = v166.name, FontFace = fonts.Bold, TextSize = textSize, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent3})
            end

            v164[layoutOrder] = {icon = icon, cost = cost, points = v166.points}
        end

        return parent2, v164, v162
    end

    local function pointsReadout(parent, a173, textSize: number?, textSize2)
        --[[
          name: pointsReadout
          line: 490
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local parent2 = ui.new("Frame", {Name = "Points", AnchorPoint = a173.AnchorPoint, Position = a173.Position, Size = a173.Size, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = parent})
        local ui2 = ui.new("TextLabel", {Name = "Num", Text = "", LayoutOrder = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Heavy, TextSize = textSize, TextColor3 = colors.Text, Parent = parent2})
        ui.new("TextLabel", {Name = "Word", Text = "POINTS", LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Heavy, TextSize = textSize2, TextColor3 = colors.TextMuted, Parent = parent2})

        return ui2
    end

    local function pointsMeter(parent, a180, a181: number, position: UDim2)
        --[[
          name: pointsMeter
          line: 525
          upvalues:
            weaponInfo (copy, index: 1)
            ui (copy, index: 2)
            colors (copy, index: 3)
            theme (copy, index: 4)
        ]]
        local endIndex = math.max(weaponInfo.Budget(), 1)
        local flooredValue = math.floor((a180 - ((endIndex - 1) * 3)) / endIndex)
        local parent2 = ui.new("Frame", {Name = "Meter", Position = position, Size = UDim2.fromOffset(a180, a181), (ui.List(Enum.FillDirection.Horizontal, 3, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
        local v186 = {}

        for layoutOrder = 1, endIndex do
            v186[layoutOrder] = ui.new("Frame", {Name = "P" .. layoutOrder, Size = UDim2.fromOffset(flooredValue, a181), BackgroundColor3 = colors.Raised, LayoutOrder = layoutOrder, (ui.Corner(3)), Parent = parent2})
        end

        return function(a188, a189)
            --[[
              line: 547
              upvalues:
                v186 (copy, index: 1)
                colors (copy, index: 2)
                ui (copy, index: 3)
                theme (copy, index: 4)
            ]]
            for v190, v191 in v186 do
                local v192 = if v190 <= a188 then colors.Accent else colors.Raised

                if a189 then
                    v191.BackgroundColor3 = v192
                else
                    ui.Tween(v191, theme.Tween.Fast, {BackgroundColor3 = v192})
                end
            end
        end
    end

    local v193 = {
        Classic = (function(parent)
            --[[
              name: Classic
              line: 563
              upvalues:
                ui (copy, index: 1)
                fonts (copy, index: 2)
                colors (copy, index: 3)
                fightButton (copy, index: 4)
                exploreLink (copy, index: 5)
                v53 (ref,  index: 6)
                ui3 (copy, index: 7)
            ]]
            local v195
            local textSize
            local textSize2
            local width
            local compact = ui.Compact

            if compact then
                v195 = 6
            else
                v195 = 20
            end

            ui.Padding(28, 34, v195, 34).Parent = parent
            local ui2 = ui.new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), Parent = parent})
            local newUi = ui.new
            local v202 = {Name = "Overline", Text = "WELCOME TO TRIBES", LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 18), FontFace = fonts.Heavy}

            if compact then
                textSize = 18
            else
                textSize = 16
            end

            v202.TextSize = textSize
            v202.TextColor3 = colors.Accent
            v202.Parent = parent
            newUi("TextLabel", v202)
            local newUi2 = ui.new
            local v204 = {Name = "Title", Text = "READY TO FIGHT?", LayoutOrder = 2}
            local newUDim2 = UDim2.new
            local v206 = compact and 52 or 48
            v204.Size = newUDim2(1, 0, 0, v206)
            v204.FontFace = fonts.Display
            v204.TextSize = compact and 48 or 46
            v204.TextColor3 = colors.Text
            v204.Parent = parent
            newUi2("TextLabel", v204)
            local newUi3 = ui.new
            local v208 = {Name = "Blurb", Text = "Team up 3v3 with bows, swords and spears.\nLast tribe standing wins the round.", TextWrapped = true, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, FontFace = fonts.Medium}

            if compact then
                textSize2 = 21
            else
                textSize2 = 19
            end

            v208.TextSize = textSize2
            v208.TextColor3 = colors.TextDim
            v208.Parent = parent
            newUi3("TextLabel", v208)
            ui.new("Frame", {Name = "Gap", LayoutOrder = 4, Size = UDim2.new(1, 0, 0, 10), Parent = parent})
            local v209 = {LayoutOrder = 5}
            v208 = UDim2.new
            local v210 = compact and 88 or 84
            v209.Size = v208(1, 0, 0, v210)
            v209.TextSize = compact and 46 or 44
            v209.Parent = parent
            local fight = fightButton(v209)
            local v212 = {LayoutOrder = 6}
            local newUDim22 = UDim2.new
            local v214 = compact and 80 or 44
            v212.Size = newUDim22(1, 0, 0, v214)
            v212.TextSize = compact and 21 or 18
            v212.Parent = parent
            exploreLink(v212)
            ui2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    --[[
                      line: 619
                      upvalues:
                        v53 (ref, index: 1)
                    ]]
                    task.defer(v53)
                end
            )
            local v215 = {}

            if compact then
                width = 600
            else
                width = 560
            end

            v215.width = width
            v215.fight = fight

            function v215.measure()
                --[[
                  name: measure
                  line: 626
                  upvalues:
                    ui (copy, index: 1)
                    ui3 (copy, index: 2)
                    ui2 (copy, index: 3)
                    v195 (copy, index: 4)
                ]]
                local v216
                local v217 = math.max(ui.Scale * ui3.Scale, 0.01)
                local v218 = ui2.AbsoluteContentSize.Y / v217

                if not (50 < v218) then
                    v216 = 300
                else
                    v216 = v218
                end

                return (math.ceil((v216 + 28) + v195))
            end

            return v215
        end),
        Pitch = (function(parent)
            --[[
              name: Pitch
              line: 636
              upvalues:
                ui (copy, index: 1)
                stacker (copy, index: 2)
                heading (copy, index: 3)
                kitOf (copy, index: 4)
                state (copy, index: 5)
                weaponInfo (copy, index: 6)
                colors (copy, index: 7)
                fonts (copy, index: 8)
                pointsReadout (copy, index: 9)
                kitStrip (copy, index: 10)
                pointsMeter (copy, index: 11)
                customizeButton (copy, index: 12)
                fightButton (copy, index: 13)
                exploreLink (copy, index: 14)
                loadoutSig (copy, index: 15)
            ]]
            local textSize
            local v221
            local textSize2
            local textSize3
            local textSize4
            local width = ui.Compact and 680 or 620
            local v226 = ui.Compact and 30 or 32
            local v227 = width - v226 * 2
            local v228 = ui.Compact and 20 or 26
            local v229 = stacker(parent, v226, v227, v228)
            local textSize5 = ui.Compact and 48 or 46
            heading(v229, "COMPETITIVE 3V3 ARENA", "BUILD YOUR LOADOUT", textSize5, "Spend your gear points on any weapons, armor and healing.\nThen fight 3v3. Last tribe standing wins the round.", 2)
            local v231, v232 = kitOf(state.Loadout())
            local v233 = weaponInfo.Budget()
            local v234 = v227 - 28
            local v235 = v229.row
            local v236 = ui.Compact and 10 or 14
            v235 = v235(0, v236)
            v235.Name = "Loadout"
            v235.BackgroundColor3 = colors.Inset
            v235.BackgroundTransparency = 0.3
            ui.Corner(14).Parent = v235
            ui.Stroke(colors.Stroke, 1, 0.9).Parent = v235
            local newUi = ui.new
            local v238 = {Name = "Label", Text = "YOUR LOADOUT", Position = UDim2.fromOffset(14, 12), Size = UDim2.fromOffset(math.floor(v234 * 0.6), 20), FontFace = fonts.Heavy}

            if ui.Compact then
                textSize = 16
            else
                textSize = 14
            end

            v238.TextSize = textSize
            v238.TextColor3 = colors.TextMuted
            v238.TextXAlignment = Enum.TextXAlignment.Left
            v238.Parent = v235
            newUi("TextLabel", v238)
            local v239 = {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(math.floor(v234 * 0.4), 20)}

            if ui.Compact then
                v221 = 19
            else
                v221 = 17
            end

            local textSize6 = ui.Compact and 15 or 13
            local v241 = pointsReadout(v235, v239, v221, textSize6)
            local v242 = ui.Compact and 90 or 88
            local textSize7 = ui.Compact and 15 or 13
            local v244, _, v246 = kitStrip(v235, v231, v234, v242, textSize7)
            v244.Position = UDim2.fromOffset(14, 42)
            local v247 = pointsMeter(v235, v234, 8, UDim2.fromOffset(14, (42 + v246) + 10))
            local v248 = ((42 + v246) + 10) + 8 + 14
            v235.Size = UDim2.fromOffset(v227, v248)
            v229.skip(v248)
            local v249 = ui.Compact and 88 or 80
            local row = v229.row
            local v251 = ui.Compact and 10 or 14
            local parent2 = row(v249, v251)
            local flooredValue = math.floor(v227 * 0.37)
            local v254 = {Size = UDim2.fromOffset(flooredValue, v249)}

            if ui.Compact then
                textSize2 = 24
            else
                textSize2 = 22
            end

            v254.TextSize = textSize2
            v254.Parent = parent2
            customizeButton(v254)
            local v255 = {Position = UDim2.fromOffset(flooredValue + 12, 0), Size = UDim2.fromOffset((v227 - flooredValue) - 12, v249)}

            if ui.Compact then
                textSize3 = 44
            else
                textSize3 = 42
            end

            v255.TextSize = textSize3
            v255.Parent = parent2
            local fight = fightButton(v255)
            local v257 = {Size = UDim2.fromScale(1, 1)}

            if ui.Compact then
                textSize4 = 21
            else
                textSize4 = 18
            end

            v257.TextSize = textSize4
            local row2 = v229.row
            local v259 = ui.Compact and 60 or 40
            v257.Parent = row2(v259, 2)
            exploreLink(v257)
            local skip = v229.skip
            local v261 = ui.Compact and 2 or 12
            skip(v261)
            v241.Text = v232 .. " / " .. v233
            v247(v232, true)
            local count = 0

            return {
                width = width,
                height = v229.y(),
                fight = fight,
                signature = (function()
                    --[[
                      name: signature
                      line: 703
                      upvalues:
                        loadoutSig (copy, index: 1)
                        state (copy, index: 2)
                    ]]
                    return loadoutSig(state.Loadout())
                end),
                opened = (function()
                    --[[
                      name: opened
                      line: 707
                      upvalues:
                        count (ref,  index: 1)
                        v247 (copy, index: 2)
                        v232 (copy, index: 3)
                        parent (copy, index: 4)
                    ]]
                    count += 1
                    local v263 = count
                    v247(0, true)

                    task.spawn(
                        function()
                            --[[
                              line: 711
                              upvalues:
                                v232 (copy, index: 1)
                                v263 (copy, index: 2)
                                count (ref,  index: 3)
                                parent (copy, index: 4)
                                v247 (copy, index: 5)
                            ]]
                            task.wait(0.3)

                            for index = 1, v232 do
                                if v263 ~= count or not parent.Parent then
                                    return
                                end

                                v247(index)
                                task.wait(0.045)
                            end
                        end
                    )
                end)
            }
        end),
        Builds = (function(parent)
            --[[
              name: Builds
              line: 729
              upvalues:
                ui (copy, index: 1)
                stacker (copy, index: 2)
                heading (copy, index: 3)
                state (copy, index: 4)
                colors (copy, index: 5)
                theme (copy, index: 6)
                fonts (copy, index: 7)
                v49 (ref,  index: 8)
                card (ref,  index: 9)
                a10 (copy, index: 10)
                kitOf (copy, index: 11)
                v9 (copy, index: 12)
                weaponInfo (copy, index: 13)
                v8 (copy, index: 14)
                weaponIcon (copy, index: 15)
                itemTile (copy, index: 16)
                detour (ref,  index: 17)
                v52 (ref,  index: 18)
                menuManager (copy, index: 19)
                fightButton (copy, index: 20)
                exploreLink (copy, index: 21)
                loadoutSig (copy, index: 22)
            ]]
            local v266
            local v267
            local v268
            local stroke, parent2, pill, parent3
            local v273
            local textSize
            local textSize2
            local width = ui.Compact and 1090 or 1000
            local v277 = width - 56
            local v278 = ui.Compact and 16 or 24
            local v279 = stacker(parent, 28, v277, v278)
            local textSize3 = ui.Compact and 48 or 46
            heading(v279, "COMPETITIVE 3V3 ARENA", "CHOOSE YOUR LOADOUT", textSize3, "Every fighter brings their own gear. Pick a build to start, or make your own.", 1)
            local endIndex = math.min(3, state.LoadoutSlotCount())
            local v282 = endIndex + 1
            local flooredValue = math.floor((v277 - ((v282 - 1) * 12)) / v282)

            if ui.Compact then
                v266 = 80
            else
                v266 = 92
            end

            local textSize4 = ui.Compact and 22 or 20
            local textSize5 = ui.Compact and 16 or 15
            local v286 = textSize4 + 4
            local ceilingValue = math.ceil((textSize5 * 1.3) * 2)

            if ui.Compact then
                v267 = 34
            else
                v267 = 36
            end

            local v288 = ((((((v266 + 10) + 8) + v286) + 2) + ceilingValue) + 8) + v267 + 12
            local v289 = v279.row
            local v290 = ui.Compact and 18 or 20
            v289 = v289(v288, v290)
            local backgroundColor3 = Color3.fromRGB(226, 230, 238)
            local backgroundColor32 = Color3.new(1, 1, 1)
            local v293 = ((((v266 + 10) + 8) + v286) + 2) + ceilingValue + 8

            local function shell(a295: number, name: string, text, text2)
                --[[
                  name: shell
                  line: 757
                  upvalues:
                    ui (copy, index: 1)
                    flooredValue (copy, index: 2)
                    v288 (copy, index: 3)
                    v289 (copy, index: 4)
                    backgroundColor3 (copy, index: 5)
                    colors (copy, index: 6)
                    theme (copy, index: 7)
                    backgroundColor32 (copy, index: 8)
                    v266 (copy, index: 9)
                    v286 (copy, index: 10)
                    fonts (copy, index: 11)
                    textSize4 (copy, index: 12)
                    ceilingValue (copy, index: 13)
                    textSize5 (copy, index: 14)
                    v293 (copy, index: 15)
                    v267 (copy, index: 16)
                ]]
                local height
                local parent = ui.new("TextButton", {Name = name, Position = UDim2.fromOffset((a295 - 1) * (flooredValue + 12), 0), Size = UDim2.fromOffset(flooredValue, v288), Parent = v289})
                local parent2 = ui.new("Frame", {Name = "Face", Size = UDim2.fromScale(1, 1), BackgroundColor3 = backgroundColor3, ui.Corner(14), (ui.Gradient(colors.PanelHi, colors.Panel, 90)), Parent = parent})
                local v302 = ui.Stroke(colors.StrokeSoft, 1.5, 0)
                v302.Parent = parent2
                parent.MouseEnter:Connect(
                    function()
                        --[[
                          line: 774
                          upvalues:
                            ui (copy, index: 1)
                            parent2 (copy, index: 2)
                            theme (copy, index: 3)
                            backgroundColor32 (copy, index: 4)
                        ]]
                        ui.Tween(parent2, theme.Tween.Fast, {BackgroundColor3 = backgroundColor32})
                    end
                )
                parent.MouseLeave:Connect(
                    function()
                        --[[
                          line: 777
                          upvalues:
                            ui (copy, index: 1)
                            parent2 (copy, index: 2)
                            theme (copy, index: 3)
                            backgroundColor3 (copy, index: 4)
                        ]]
                        ui.Tween(parent2, theme.Tween.Fast, {BackgroundColor3 = backgroundColor3})
                    end
                )
                local ui2 = ui.new("Frame", {Name = "Hero", Position = UDim2.fromOffset(10, 10), Size = UDim2.fromOffset(flooredValue - 20, v266), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(10)), Parent = parent2})
                local pill = ui.Pill
                local accent = colors.Accent
                local v306 = {Name = "Equipped", Transparency = 0, ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0)}

                if ui.Compact then
                    height = 24
                else
                    height = 22
                end

                v306.Height = height
                v306.TextSize = ui.Compact and 14 or 13
                v306.Parent = parent
                local v307 = pill("EQUIPPED", accent, v306)
                ui.new("TextLabel", {Name = "Name", Position = UDim2.fromOffset(12, (v266 + 10) + 8), Size = UDim2.fromOffset(flooredValue - 24, v286), Text = text, FontFace = fonts.Heavy, TextSize = textSize4, TextColor3 = colors.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent2})
                ui.new("TextLabel", {Name = "Line", TextWrapped = true, Position = UDim2.fromOffset(12, (((v266 + 10) + 8) + v286) + 2), Size = UDim2.fromOffset(flooredValue - 24, ceilingValue), Text = text2, FontFace = fonts.Medium, TextSize = textSize5, TextColor3 = colors.TextDim, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent2})

                return parent, v302, ui2, v307, (ui.new("Frame", {Name = "Rest", Position = UDim2.fromOffset(12, v293), Size = UDim2.fromOffset(flooredValue - 24, v267), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent2}))
            end

            local function tileSize(a309)
                --[[
                  name: tileSize
                  line: 830
                  upvalues:
                    v267 (copy, index: 1)
                    flooredValue (copy, index: 2)
                ]]
                return (math.min(v267, (math.floor((flooredValue - 24 - ((a309 - 1) * 6)) / a309))))
            end

            local v310 = {}
            local v311 = nil
            local v312 = {selecting = false, width = width}

            local function paint()
                --[[
                  name: paint
                  line: 837
                  upvalues:
                    v311 (ref,  index: 1)
                    state (copy, index: 2)
                    v310 (copy, index: 3)
                    endIndex (copy, index: 4)
                    colors (copy, index: 5)
                ]]
                local v314 = v311 or state.ActiveLoadout()

                for v315, v316 in v310 do
                    local visible = if v315 <= endIndex then v315 == v314 else endIndex < v314
                    v316.stroke.Color = if visible then colors.Accent else colors.StrokeSoft
                    v316.stroke.Thickness = visible and 2.5 or 1.5
                    v316.pill.Visible = visible
                end
            end

            local function pick(key)
                --[[
                  name: pick
                  line: 847
                  upvalues:
                    v49 (ref,  index: 1)
                    v312 (copy, index: 2)
                    card (ref,  index: 3)
                    state (copy, index: 4)
                    ui (copy, index: 5)
                    v310 (copy, index: 6)
                    a10 (copy, index: 7)
                    v311 (ref,  index: 8)
                    paint (copy, index: 9)
                    parent (copy, index: 10)
                ]]
                if v49 or v312.selecting or not card then
                    return
                end

                if state.ActiveLoadout() == key then
                    ui.Bump(v310[key].pill, 0.12)
                    return
                end

                a10.Sounds.Play("Select")
                v311 = key
                v312.selecting = true
                paint()

                task.spawn(
                    function()
                        --[[
                          line: 858
                          upvalues:
                            a10 (copy, index: 1)
                            key (copy, index: 2)
                            v311 (ref,  index: 3)
                            v312 (copy, index: 4)
                            parent (copy, index: 5)
                            paint (copy, index: 6)
                        ]]
                        a10.ProfileAction("SelectLoadout", key)
                        v311 = nil
                        v312.selecting = false

                        if parent.Parent then
                            paint()
                        end
                    end
                )
            end

            for index = 1, endIndex do
                local v321
                local v322 = state.LoadoutSlot(index)
                local v323 = kitOf(v322)
                local v324 = weaponInfo.Normalize(v322)
                local v325 = v9[table.concat(v324.items, ",") .. "|" .. (v324.armor or "")]
                local text = state.LoadoutCustomName(index)

                if text == "" then
                    v321 = not v325 and "YOUR BUILD" or v325.name
                else
                    v321 = string.upper(text)
                end

                local name = "Build" .. index
                local v328 = not v325 and "Your own mix of gear." or v325.line
                local v329, stroke2, parent4, pill2, parent5 = shell(index, name, v321, v328)
                local v334 = v323[1]
                local v335 = v334 and v8[v334.cat] or colors.Accent
                ui.Gradient(v335:Lerp(colors.Panel, 0.5800000000000001), colors.PanelHi:Lerp(colors.Panel, 0.6), 115).Parent = parent4

                if v334 then
                    local ui2 = ui.new("Frame", {Name = "Icon", ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(v266 - 6, v266 - 6), Parent = parent4})
                    weaponIcon.Set(ui2, v334.icon, {outline = false, glow = false})
                end

                local v337 = math.max(#v323 - 1, 1)
                local v338 = math.min(v267, (math.floor((flooredValue - 24 - ((v337 - 1) * 6)) / v337)))

                for index2 = 2, #v323 do
                    itemTile(parent5, v323[index2], v338, false, index2)
                end

                v310[index] = {stroke = stroke2, pill = pill2}
                v329.Activated:Connect(
                    function()
                        --[[
                          line: 893
                          upvalues:
                            pick (copy, index: 1)
                            index (copy, index: 2)
                        ]]
                        pick(index)
                    end
                )
            end

            v268, stroke, parent2, pill, parent3 = shell(v282, "Own", "BUILD YOUR OWN", "Mix any gear you own.\nEvery item costs points.")
            local accent = colors.Accent
            ui.Gradient(accent:Lerp(colors.Panel, 0.7), colors.PanelHi:Lerp(colors.Panel, 0.6), 115).Parent = parent2
            local newUi = ui.new
            local v342 = {Name = "Plus", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}
            local udim2FromOffset = UDim2.fromOffset
            local v344 = ui.Compact and 48 or 52
            local v345 = ui.Compact and 48 or 52
            v342.Size = udim2FromOffset(v344, v345)
            v342.BackgroundColor3 = colors.AccentDark
            v342[1] = (ui.Corner(theme.Radius.Pill))
            v342.Parent = parent2
            local parent6 = newUi("Frame", v342)
            ui.Icon("plus", 24, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent6})
            local v347 = math.min(v267, (math.floor(((flooredValue - 24) - 24) / 5)))

            for layoutOrder = 1, 5 do
                local parent7 = ui.new("Frame", {Name = "Slot" .. layoutOrder, Size = UDim2.fromOffset(v347, v347), BackgroundColor3 = colors.Inset, LayoutOrder = layoutOrder, (ui.Corner((math.max(6, (math.floor(v347 * 0.15)))))), Parent = parent3})
                ui.Stroke(colors.StrokeSoft, 1, 0.2).Parent = parent7
                ui.Icon("plus", math.floor(v347 * 0.34), colors.TextMuted, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent7})
            end

            v310[v282] = {stroke = stroke, pill = pill}

            v268.Activated:Connect(
                function()
                    --[[
                      line: 930
                      upvalues:
                        a10 (copy, index: 1)
                        v49 (ref,  index: 2)
                        card (ref,  index: 3)
                        detour (ref,  index: 4)
                        v52 (ref,  index: 5)
                        menuManager (copy, index: 6)
                    ]]
                    a10.Sounds.Play("Click")

                    if not v49 then
                        if not card then
                            return
                        end

                        detour = true
                        v52 = 0
                        menuManager.Open("Loadout")

                        if not menuManager.IsOpen("Loadout") then
                            detour = false
                        end
                    end
                end
            )

            if v282 ~= 4 then
                local v350 = ui.Compact and 480 or 460
                v273 = math.min(v277, v350)
            else
                v273 = flooredValue * 2 + 12
            end

            local v351 = ui.Compact and 88 or 80
            local v352 = {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(v273, v351)}

            if ui.Compact then
                textSize = 44
            else
                textSize = 42
            end

            v352.TextSize = textSize
            local row = v279.row
            local v354 = ui.Compact and 10 or 16
            v352.Parent = row(v351, v354)
            v312.fight = fightButton(v352)
            local v355 = {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, v273, 1, 0)}

            if ui.Compact then
                textSize2 = 20
            else
                textSize2 = 18
            end

            v355.TextSize = textSize2
            local row2 = v279.row
            local v357 = ui.Compact and 56 or 42
            v355.Parent = row2(v357, 2)
            exploreLink(v355)
            local skip = v279.skip
            local v359 = ui.Compact and 2 or 10
            skip(v359)
            v312.height = v279.y()

            v312.signature = function()
                --[[
                  line: 955
                  upvalues:
                    state (copy, index: 1)
                    loadoutSig (copy, index: 2)
                ]]
                local parts = {}

                for index = 1, math.min(3, state.LoadoutSlotCount()) do
                    table.insert(parts, loadoutSig(state.LoadoutSlot(index)) .. "#" .. state.LoadoutCustomName(index))
                end

                return table.concat(parts, ";")
            end

            v312.refresh = paint

            v312.pick = function(key)
                --[[
                  line: 963
                  upvalues:
                    v310 (copy, index: 1)
                    endIndex (copy, index: 2)
                    pick (copy, index: 3)
                ]]
                if v310[key] and key <= endIndex then
                    pick(key)
                end
            end

            paint()

            return v312
        end),
        Briefing = (function(parent)
            --[[
              name: Briefing
              line: 974
              upvalues:
                ui (copy, index: 1)
                stacker (copy, index: 2)
                heading (copy, index: 3)
                kitOf (copy, index: 4)
                state (copy, index: 5)
                weaponInfo (copy, index: 6)
                colors (copy, index: 7)
                fonts (copy, index: 8)
                pointsReadout (copy, index: 9)
                kitStrip (copy, index: 10)
                pointsMeter (copy, index: 11)
                customizeButton (copy, index: 12)
                theme (copy, index: 13)
                portraits (copy, index: 14)
                localPlayer (copy, index: 15)
                actionRow (copy, index: 16)
                loadoutSig (copy, index: 17)
            ]]
            local v364
            local textSize
            local v366
            local textSize2
            local textSize3
            local textSize4
            local width = ui.Compact and 1090 or 1000
            local v371 = width - 56
            local v372 = ui.Compact and 18 or 24
            local v373 = stacker(parent, 28, v371, v372)
            local textSize5 = ui.Compact and 44 or 42
            heading(v373, "WELCOME TO TRIBES", "COMPETITIVE 3V3. YOUR OWN LOADOUT.", textSize5)
            local v375, v376 = kitOf(state.Loadout())
            local v377 = weaponInfo.Budget()
            local flooredValue = math.floor(v371 * 0.36)
            local v379 = v371 - flooredValue - 14
            local row = v373.row

            if ui.Compact then
                v364 = 10
            else
                v364 = 14
            end

            local parent2 = row(0, v364)
            local parent3 = ui.new("Frame", {Name = "Loadout", Position = UDim2.fromOffset(flooredValue + 14, 0), BackgroundColor3 = Color3.new(1, 1, 1), ui.Corner(14), (ui.Gradient(colors.AccentDeep:Lerp(colors.Panel, 0.62), colors.Panel, 100)), Parent = parent2})
            ui.Stroke(colors.Accent, 1.5, 0.5).Parent = parent3
            local v383 = v379 - 32
            local newUi = ui.new
            local v385 = {Name = "Label", Text = "YOUR LOADOUT", Position = UDim2.fromOffset(16, 14), Size = UDim2.fromOffset(math.floor(v383 * 0.5), 20), FontFace = fonts.Heavy}

            if ui.Compact then
                textSize = 17
            else
                textSize = 15
            end

            v385.TextSize = textSize
            v385.TextColor3 = colors.Accent
            v385.TextXAlignment = Enum.TextXAlignment.Left
            v385.Parent = parent3
            newUi("TextLabel", v385)
            local v386 = {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 14), Size = UDim2.fromOffset(math.floor(v383 * 0.5), 20)}

            if ui.Compact then
                v366 = 20
            else
                v366 = 18
            end

            local textSize6 = ui.Compact and 15 or 13
            local v388 = pointsReadout(parent3, v386, v366, textSize6)
            local textSize7 = ui.Compact and 19 or 17
            ui.new("TextLabel", {Name = "Sub", Text = "Every item costs gear points. Spend them your way.", Position = UDim2.fromOffset(16, 38), Size = UDim2.fromOffset(v383, textSize7 + 6), FontFace = fonts.Medium, TextSize = textSize7, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})
            local v390 = (textSize7 + 38) + 6 + 10
            local v391 = ui.Compact and 84 or 80
            local textSize8 = ui.Compact and 15 or 13
            local v393, v394, v395 = kitStrip(parent3, v375, v383, v391, textSize8)
            v393.Position = UDim2.fromOffset(16, v390)
            local v396 = v390 + v395 + 10
            local v397 = pointsMeter(parent3, v383, 8, UDim2.fromOffset(16, v396))
            local v398 = v396 + 8 + 12
            local v399 = ui.Compact and 56 or 48
            local v400 = ui.Compact and 214 or 190
            local newUi2 = ui.new
            local v402 = {Name = "More", Text = "Unlock muskets, spears, traps and heavier armor as you play.", TextWrapped = true, Position = UDim2.fromOffset(16, v398), Size = UDim2.fromOffset((v383 - v400) - 14, v399), FontFace = fonts.Medium}

            if ui.Compact then
                textSize2 = 17
            else
                textSize2 = 15
            end

            v402.TextSize = textSize2
            v402.TextColor3 = colors.TextMuted
            v402.TextXAlignment = Enum.TextXAlignment.Left
            v402.Parent = parent3
            newUi2("TextLabel", v402)
            local v403 = {AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, v398), Size = UDim2.fromOffset(v400, v399)}

            if ui.Compact then
                textSize3 = 22
            else
                textSize3 = 20
            end

            v403.TextSize = textSize3
            v403.Parent = parent3
            customizeButton(v403)
            local v404 = v398 + v399 + 16
            parent3.Size = UDim2.fromOffset(v379, v404)
            local parent4 = ui.new("Frame", {Name = "Fight", Size = UDim2.fromOffset(flooredValue, v404), BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.3, (ui.Corner(14)), Parent = parent2})
            ui.Stroke(colors.Stroke, 1, 0.9).Parent = parent4
            local newUi3 = ui.new
            local v407 = {Name = "Label", Text = "THE FIGHT", Position = UDim2.fromOffset(16, 14), Size = UDim2.fromOffset(flooredValue - 32, 20), FontFace = fonts.Heavy}

            if ui.Compact then
                textSize4 = 17
            else
                textSize4 = 15
            end

            v407.TextSize = textSize4
            v407.TextColor3 = colors.TextMuted
            v407.TextXAlignment = Enum.TextXAlignment.Left
            v407.Parent = parent4
            newUi3("TextLabel", v407)
            local v408 = ui.Compact and 42 or 38
            local parent5 = ui.new("Frame", {Name = "Teams", Position = UDim2.fromOffset(0, 50), Size = UDim2.fromOffset(flooredValue, v408), (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent4})

            local function fighter(layoutOrder: number, startValue, a413: boolean)
                --[[
                  name: fighter
                  line: 1087
                  upvalues:
                    ui (copy, index: 1)
                    v408 (copy, index: 2)
                    colors (copy, index: 3)
                    theme (copy, index: 4)
                    parent5 (copy, index: 5)
                    portraits (copy, index: 6)
                    localPlayer (copy, index: 7)
                ]]
                local parent = ui.new("Frame", {Name = "Fighter", Size = UDim2.fromOffset(v408, v408), BackgroundColor3 = startValue:Lerp(colors.Panel, 0.72), LayoutOrder = layoutOrder, (ui.Corner(theme.Radius.Pill)), Parent = parent5})
                ui.Stroke(startValue, 2, 0).Parent = parent

                if a413 then
                    local ui2 = ui.new("ImageLabel", {Name = "You", Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, (ui.Corner(theme.Radius.Pill)), Parent = parent})
                    portraits.Apply(ui2, {userId = localPlayer.UserId}, 150)

                    return
                end

                ui.Icon("person", math.floor(v408 * 0.56), startValue, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent})
            end

            fighter(1, colors.Ally, true)
            fighter(2, colors.Ally, false)
            fighter(3, colors.Ally, false)
            local newUi4 = ui.new
            local v417 = {Name = "Vs", Text = "VS", LayoutOrder = 4}
            local udim2FromOffset = UDim2.fromOffset
            local v419 = ui.Compact and 38 or 34
            v417.Size = udim2FromOffset(v419, v408)
            v417.FontFace = fonts.Display
            v417.TextSize = ui.Compact and 22 or 20
            v417.TextColor3 = colors.TextDim
            v417.Parent = parent5
            newUi4("TextLabel", v417)
            fighter(5, colors.Enemy, false)
            fighter(6, colors.Enemy, false)
            fighter(7, colors.Enemy, false)
            local v420 = {"Two tribes of three", "One life each round", "Last tribe standing wins"}
            local v421 = ui.Compact and 40 or 38
            local v422 = v408 + 50
            local v423 = v422 + math.floor((v404 - v422 - (#v420 * v421)) / 2)

            for v424, text in v420 do
                local textSize9
                local v427 = v423 + (v424 - 1) * v421
                ui.new("Frame", {Name = "Dot" .. v424, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(18, v427 + (v421 / 2)), Size = UDim2.fromOffset(8, 8), BackgroundColor3 = colors.Accent, (ui.Corner(2)), Parent = parent4})
                local newUi5 = ui.new
                local v429 = {Name = "Fact" .. v424, Position = UDim2.fromOffset(38, v427), Size = UDim2.fromOffset((flooredValue - 32) - 22, v421), Text = text, FontFace = fonts.Bold}

                if ui.Compact then
                    textSize9 = 20
                else
                    textSize9 = 18
                end

                v429.TextSize = textSize9
                v429.TextColor3 = colors.Text
                v429.TextXAlignment = Enum.TextXAlignment.Left
                v429.Parent = parent4
                newUi5("TextLabel", v429)
            end

            parent2.Size = UDim2.fromOffset(v371, v404)
            v373.skip(v404)
            local v430 = ui.Compact and 10 or 14
            local fight = actionRow(v373, v371, v430)
            local skip = v373.skip
            local v433 = ui.Compact and 12 or 14
            skip(v433)
            ;(function()
                --[[
                  name: settle
                  line: 1163
                  upvalues:
                    v388 (copy, index: 1)
                    v376 (copy, index: 2)
                    v377 (copy, index: 3)
                    v397 (copy, index: 4)
                    v394 (copy, index: 5)
                    ui (copy, index: 6)
                ]]
                v388.Text = v376 .. " / " .. v377
                v397(v376, true)

                for _, v435 in v394 do
                    ui.GetScaleObj(v435.icon).Scale = 1

                    if v435.cost then
                        v435.cost.Visible = true
                    end
                end
            end)()
            local count = 0

            return {
                width = width,
                height = v373.y(),
                fight = fight,
                signature = (function()
                    --[[
                      name: signature
                      line: 1179
                      upvalues:
                        loadoutSig (copy, index: 1)
                        state (copy, index: 2)
                    ]]
                    return loadoutSig(state.Loadout())
                end),
                opened = (function()
                    --[[
                      name: opened
                      line: 1183
                      upvalues:
                        count (ref,  index: 1)
                        v388 (copy, index: 2)
                        v377 (copy, index: 3)
                        v397 (copy, index: 4)
                        v394 (copy, index: 5)
                        ui (copy, index: 6)
                        parent (copy, index: 7)
                        theme (copy, index: 8)
                    ]]
                    count += 1
                    local v437 = count
                    v388.Text = "0 / " .. v377
                    v397(0, true)

                    for _, v439 in v394 do
                        ui.GetScaleObj(v439.icon).Scale = 0.001

                        if v439.cost then
                            v439.cost.Visible = false
                        end
                    end

                    task.spawn(
                        function()
                            --[[
                              line: 1194
                              upvalues:
                                v394 (copy, index: 1)
                                v437 (copy, index: 2)
                                count (ref,  index: 3)
                                parent (copy, index: 4)
                                ui (copy, index: 5)
                                theme (copy, index: 6)
                                v388 (copy, index: 7)
                                v377 (copy, index: 8)
                                v397 (copy, index: 9)
                            ]]
                            task.wait(0.4)
                            local total = 0

                            for _, v442 in v394 do
                                if v437 ~= count or not parent.Parent then
                                    return
                                end

                                local scaleObj = ui.GetScaleObj(v442.icon)
                                scaleObj.Scale = 0.5
                                ui.Tween(scaleObj, theme.Tween.Pop, {Scale = 1})

                                if v442.cost then
                                    v442.cost.Visible = true
                                end

                                total += v442.points
                                v388.Text = total .. " / " .. v377
                                v397(total)
                                task.wait(0.17)
                            end
                        end
                    )
                end)
            }
        end)
    }

    v53 = function()
        --[[
          line: 1219
          upvalues:
            v43 (ref,  index: 1)
            parent2 (copy, index: 2)
            ui (copy, index: 3)
            ui3 (copy, index: 4)
            theme (copy, index: 5)
        ]]
        if not v43 then
            return
        end

        local width = v43.width
        local v445 = if v43.measure then v43.measure() else v43.height
        parent2.Size = UDim2.fromOffset(width, v445)
        local v446 = ui.CanvasSize()
        local v447 = ui.TopInset()
        local v448 = 200 < v446.X and 200 < v446.Y
        local scale = not v448 and 1
            or math.clamp(math.min(((v446.Y - v447) - 16) / v445, (v446.X - 32) / width), 0.3, 1)
        ui3.Scale = scale
        local v450 = not v448 and 0 or math.max(0, ((v447 + ((v445 * scale) / 2)) + 4) - (v446.Y / 2))
        local slideTarget = UDim2.new(0.5, 0, 0.5, v450)

        if parent2:GetAttribute("_slideTarget") ~= nil then
            parent2:SetAttribute("_slideTarget", slideTarget)

            ui.Tween(parent2, theme.Tween.Fast, {Position = slideTarget}).Completed:Connect(
                function(a452)
                    --[[
                      line: 1241
                      upvalues:
                        parent2 (copy, index: 1)
                    ]]
                    if a452 == Enum.PlaybackState.Completed then
                        parent2:SetAttribute("_slideTarget", nil)
                    end
                end
            )

            return
        end

        parent2.Position = slideTarget
    end

    local function selectFight()
        --[[
          name: selectFight
          line: 1251
          upvalues:
            ui (copy, index: 1)
            v43 (ref,  index: 2)
        ]]
        if ui.Gamepad then
            game:GetService("GuiService").SelectedObject = v43.fight.Instance
        end
    end

    local function build()
        --[[
          name: build
          line: 1257
          upvalues:
            ui4 (ref,  index: 1)
            ui (copy, index: 2)
            parent3 (copy, index: 3)
            v193 (copy, index: 4)
            v11 (ref,  index: 5)
            fight (copy, index: 6)
            v43 (ref,  index: 7)
            v45 (ref,  index: 8)
            parent2 (copy, index: 9)
            v53 (ref,  index: 10)
            card (ref,  index: 11)
        ]]
        if ui4 then
            ui4:Destroy()
        end

        local ui2 = ui.new("Frame", {Name = "Body", Size = UDim2.fromScale(1, 1), Parent = parent3})
        ui4 = ui2
        local v456 = v193[v11](ui2)
        v456.version = v11
        v456.compact = ui.Compact
        v456.sig = if v456.signature then v456.signature() else nil
        v456.fight.Activated:Connect(fight)
        v43 = v456
        v45 = false
        ui.ResetFade(parent2)
        v53()

        if card and ui.Gamepad then
            game:GetService("GuiService").SelectedObject = v43.fight.Instance
        end
    end

    local function freshen()
        --[[
          name: freshen
          line: 1278
          upvalues:
            v43 (ref,  index: 1)
            build (copy, index: 2)
            v45 (ref,  index: 3)
            ui (copy, index: 4)
            v49 (ref,  index: 5)
            v46 (ref,  index: 6)
        ]]
        if not v43 then
            build()
            return
        end

        if (v45 or v43.compact ~= ui.Compact) and not (v49) then
            local timestamp = os.clock()

            if v46 <= timestamp then
                build()
            end
        end
    end

    if v11 == "Classic" then
        build()
    end

    ui.LayoutChanged:Connect(
        function()
            --[[
              line: 1288
              upvalues:
                v43 (ref,  index: 1)
                build (copy, index: 2)
                v45 (ref,  index: 3)
                ui (copy, index: 4)
                v49 (ref,  index: 5)
                v46 (ref,  index: 6)
                v53 (ref,  index: 7)
            ]]
            if v43 then
                if v43 then
                    if (v45 or v43.compact ~= ui.Compact) and not (v49) then
                        local timestamp = os.clock()

                        if v46 <= timestamp then
                            build()
                        end
                    end
                else
                    build()
                end
            end

            v53()
        end
    )

    ui.ScaleChanged:Connect(v53)

    state.ProfileChanged:Connect(
        function()
            --[[
              line: 1295
              upvalues:
                v43 (ref, index: 1)
                v45 (ref, index: 2)
            ]]
            if v43 and v43.signature then
                local v460 = v43.signature()

                if v460 ~= v43.sig then
                    v45 = true
                    return
                end

                if v43.refresh then
                    v43.refresh()
                end
            end
        end
    )

    local v461 = {}

    local function paintChips()
        --[[
          name: paintChips
          line: 1308
          upvalues:
            v461 (copy, index: 1)
            v11 (ref,  index: 2)
            colors (copy, index: 3)
        ]]
        for v463, v464 in v461 do
            v464.BackgroundColor3 = if v463 == v11 then colors.Accent else colors.Raised
        end
    end

    local function setVersion(version)
        --[[
          name: setVersion
          line: 1313
          upvalues:
            v193 (copy, index: 1)
            v49 (ref,  index: 2)
            v46 (ref,  index: 3)
            v11 (ref,  index: 4)
            v43 (ref,  index: 5)
            build (copy, index: 6)
            v461 (copy, index: 7)
            colors (copy, index: 8)
            card (ref,  index: 9)
        ]]
        if type(version) ~= "string" or not v193[version] or v49 or os.clock() < v46 then
            return false
        end

        if version ~= v11 then
            v11 = version

            if v43 then
                build()
            end

            for v467, v468 in v461 do
                v468.BackgroundColor3 = if v467 == v11 then colors.Accent else colors.Raised
            end

            if card and v43 and v43.opened then
                v43.opened()
            end
        end

        return true
    end

    if v37 then
        local parent4 = ui.new("Frame", {Name = "VersionSwitch", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 6), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, ui.Corner(theme.Radius.Pill), ui.Padding(4, 5, 4, 14), (ui.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
        local ui5 = ui.new("TextLabel", {Name = "Label", Text = "STAGING PREVIEW", LayoutOrder = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, Parent = parent4})

        for layoutOrder, v472 in v6 do
            local layoutOrder2 = layoutOrder
            local v474 = v472
            local ui6 = ui.new("TextButton", {Name = v474.id, BackgroundColor3 = colors.Raised, Text = v474.chip, FontFace = fonts.Heavy, TextColor3 = colors.Text, LayoutOrder = layoutOrder2, (ui.Corner(theme.Radius.Pill)), Parent = parent4})

            ui6.Activated:Connect(
                function()
                    --[[
                      line: 1363
                      upvalues:
                        a10 (copy, index: 1)
                        setVersion (copy, index: 2)
                        v472 (copy, index: 3)
                    ]]
                    a10.Sounds.Play("Click")
                    setVersion(v472.id)
                end
            )

            v461[v474.id] = ui6
        end

        local function sizeSwitch()
            --[[
              name: sizeSwitch
              line: 1370
              upvalues:
                ui (copy, index: 1)
                parent4 (copy, index: 2)
                ui5 (copy, index: 3)
                v461 (copy, index: 4)
            ]]
            local v477
            local compact = ui.Compact
            local udim2FromOffset = UDim2.fromOffset

            if compact then
                v477 = 54
            else
                v477 = 40
            end

            parent4.Size = udim2FromOffset(0, v477)
            ui5.TextSize = compact and 15 or 13

            for _, v481 in v461 do
                local udim2FromOffset2 = UDim2.fromOffset
                local v483 = compact and 74 or 52
                local v484 = compact and 46 or 32
                v481.Size = udim2FromOffset2(v483, v484)
                v481.TextSize = compact and 18 or 15
            end
        end

        sizeSwitch()
        ui.LayoutChanged:Connect(sizeSwitch)

        for v485, v486 in v461 do
            v486.BackgroundColor3 = if v485 == v11 then colors.Accent else colors.Raised
        end
    end

    menuManager.Register(
        "Welcome",
        {
            blur = false,
            back = (function()
                --[[
                  name: back
                  line: 1388
                  upvalues:
                    ui (copy, index: 1)
                    v43 (ref,  index: 2)
                ]]
                if ui.Gamepad then
                    game:GetService("GuiService").SelectedObject = v43.fight.Instance
                end

                return true
            end),
            open = (function()
                --[[
                  name: open
                  line: 1392
                  upvalues:
                    count (ref,  index: 1)
                    card (ref,  index: 2)
                    v49 (ref,  index: 3)
                    detour (ref,  index: 4)
                    v43 (ref,  index: 5)
                    build (copy, index: 6)
                    v45 (ref,  index: 7)
                    ui (copy, index: 8)
                    v46 (ref,  index: 9)
                    a10 (copy, index: 10)
                    v53 (ref,  index: 11)
                    parent (copy, index: 12)
                    ui2 (copy, index: 13)
                    parent2 (copy, index: 14)
                    v26 (copy, index: 15)
                    state (copy, index: 16)
                ]]
                count += 1
                card = true
                v49 = false
                detour = false

                if v43 then
                    if (v45 or v43.compact ~= ui.Compact) and not (v49) then
                        local timestamp = os.clock()

                        if v46 <= timestamp then
                            build()
                        end
                    end
                else
                    build()
                end

                v43.fight:SetText("FIGHT")
                a10.SetHudHidden("Welcome", true)

                if a10.TopbarSettings then
                    a10.TopbarSettings.SetHidden("Welcome", true)
                end

                v53()
                parent.Visible = true
                ui2.Visible = true
                ui2.BackgroundTransparency = 1
                local v488 = {BackgroundTransparency = 0.5}
                ui.Tween(ui2, TweenInfo.new(0.35, Enum.EasingStyle.Quad), v488)
                ui.Enter(parent2, Vector2.new(0, 28), 0.05, parent2.Position)
                a10.Sounds.Play("Open")

                if not v26.Welcome
                    and not state.Mock
                    and a10.Remotes.Fire("AnalyticsReport", "Welcome", nil)
                then
                    v26.Welcome = true
                end

                if ui.Gamepad then
                    game:GetService("GuiService").SelectedObject = v43.fight.Instance
                end

                if v43.opened then
                    v43.opened()
                end
            end),
            close = (function(a489)
                --[[
                  name: close
                  line: 1413
                  upvalues:
                    count (ref,  index: 1)
                    card (ref,  index: 2)
                    detour (ref,  index: 3)
                    a10 (copy, index: 4)
                    answered (ref,  index: 5)
                    state (copy, index: 6)
                    ui (copy, index: 7)
                    ui2 (copy, index: 8)
                    parent (copy, index: 9)
                    v46 (ref,  index: 10)
                    parent2 (copy, index: 11)
                ]]
                count += 1
                local v490 = count
                card = false

                if not detour then
                    a10.SetHudHidden("Welcome", false)

                    if a10.TopbarSettings then
                        a10.TopbarSettings.SetHidden("Welcome", false)
                    end

                    if not answered and not state.InMatch() then
                        answered = true
                        task.spawn(a10.QueueAction, "DismissWelcome")
                    end
                end

                local tween = ui.Tween
                local newTweenInfo = TweenInfo.new
                local v493 = a489 and 0 or 0.2
                tween(ui2, newTweenInfo(v493), {BackgroundTransparency = 1})

                if a489 then
                    parent.Visible = false
                    ui2.Visible = false

                    return
                end

                v46 = os.clock() + 0.3
                ui.FadeOut(parent2, TweenInfo.new(0.16))

                task.delay(
                    0.2,
                    function()
                        --[[
                          line: 1434
                          upvalues:
                            v490 (copy, index: 1)
                            count (ref,  index: 2)
                            parent (copy, index: 3)
                            ui2 (copy, index: 4)
                            ui (copy, index: 5)
                            parent2 (copy, index: 6)
                        ]]
                        if v490 == count then
                            parent.Visible = false
                            ui2.Visible = false
                            ui.Unfade(parent2)
                        end
                    end
                )
            end)
        }
    )

    state.PlayerStateChanged:Connect(
        function()
            --[[
              line: 1444
              upvalues:
                state (copy, index: 1)
                answered (ref,  index: 2)
                localPlayer (copy, index: 3)
                menuManager (copy, index: 4)
            ]]
            if state.InMatch() then
                answered = answered or localPlayer:GetAttribute("WelcomeCard") ~= true

                if menuManager.IsOpen("Welcome") then
                    menuManager.Close("Welcome", true)
                end
            end
        end
    )

    local timestamp = nil

    local function cardWanted()
        --[[
          name: cardWanted
          line: 1452
          upvalues:
            localPlayer (copy, index: 1)
            answered (ref,  index: 2)
            card (ref,  index: 3)
        ]]
        return localPlayer:GetAttribute("WelcomeCard") == true and not answered and not card
    end

    local function readyForCard()
        --[[
          name: readyForCard
          line: 1455
          upvalues:
            localPlayer (copy, index: 1)
            state (copy, index: 2)
            a10 (copy, index: 3)
            menuManager (copy, index: 4)
        ]]
        local v497 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
        v497 = v497
            and state.HasProfile
            and not state.InMatch()
            and not a10.HudHidden
            and localPlayer.Character ~= nil
            and not menuManager.IsOpen()
            and state.Get("Queued") ~= true
            and state.Get("Teleporting") ~= true

        return v497
    end

    local function detourTick()
        --[[
          name: detourTick
          line: 1466
          upvalues:
            detour (ref,  index: 1)
            card (ref,  index: 2)
            menuManager (copy, index: 3)
            v52 (ref,  index: 4)
            localPlayer (copy, index: 5)
            answered (ref,  index: 6)
            state (copy, index: 7)
            a10 (copy, index: 8)
        ]]
        if not detour or card then
            return
        end

        if menuManager.IsOpen() then
            v52 = 0
            return
        end

        v52 += 0.1

        if v52 < 0.2 then
            return
        end

        if localPlayer:GetAttribute("WelcomeCard") == true
            and not answered
            and not card
            and localPlayer:GetAttribute("LoadingShownMs") ~= nil
            and not state.InMatch()
            and state.Get("Queued") ~= true
        then
            if state.Get("Teleporting") ~= true then
                menuManager.Open("Welcome")
                return
            end
        end

        detour = false
        a10.SetHudHidden("Welcome", false)

        if a10.TopbarSettings then
            a10.TopbarSettings.SetHidden("Welcome", false)
        end
    end

    local pressed = false
    local v500 = 0
    local v501 = false
    local callout2 = false
    local v503 = {{spread = 3, t = 0.5}, {spread = 8, t = 0.7}, {spread = 14, t = 0.83}, {spread = 21, t = 0.92}}
    local color3 = Color3.fromRGB(150, 210, 255)
    local parent5 = ui.new("Frame", {Name = "NudgeGlow", ZIndex = 0, Visible = false, Size = UDim2.fromScale(1, 1), Parent = playButton.Instance})
    local v506 = {}

    for v507, v508 in v503 do
        local v509 = v508
        v506[v507] = ui.new("Frame", {Name = "Halo" .. v507, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, v509.spread * 2, 1, v509.spread * 2), BackgroundColor3 = colors.Accent, BackgroundTransparency = 1, ZIndex = 0, (ui.Corner(16 + v509.spread)), Parent = parent5})
    end

    local parent6 = ui.new("Frame", {Name = "Ripple", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0, (ui.Corner(16)), Parent = parent5})
    local v511 = ui.Stroke(color3, 2, 1)
    v511.Parent = parent6

    local instance = Instance.new("NumberValue")
    instance.Parent = parent5
    local value2 = 0

    local function paintGlow()
        --[[
          name: paintGlow
          line: 1532
          upvalues:
            value2 (ref,  index: 1)
            instance (copy, index: 2)
            v503 (copy, index: 3)
            v506 (copy, index: 4)
        ]]
        local v515 = value2 * (0.55 + (0.45 * instance.Value))

        for v516, v517 in v503 do
            v506[v516].BackgroundTransparency = 1 - ((1 - v517.t) * v515)
        end
    end

    instance.Changed:Connect(paintGlow)
    local tween = nil
    local count2 = 0

    local function fadeGlow(value: number, a522: number, callback)
        --[[
          name: fadeGlow
          line: 1541
          upvalues:
            value2 (ref,  index: 1)
            instance (copy, index: 2)
            v503 (copy, index: 3)
            v506 (copy, index: 4)
            tweenService (copy, index: 5)
        ]]
        local instance2 = Instance.new("NumberValue")
        instance2.Value = value2

        instance2.Changed:Connect(
            function(value: number)
                --[[
                  line: 1544
                  upvalues:
                    value2 (ref,  index: 1)
                    instance (copy, index: 2)
                    v503 (copy, index: 3)
                    v506 (copy, index: 4)
                ]]
                value2 = value
                local v526 = value2 * (0.55 + (0.45 * instance.Value))

                for v527, v528 in v503 do
                    v506[v527].BackgroundTransparency = 1 - ((1 - v528.t) * v526)
                end
            end
        )

        local tween = tweenService:Create(instance2, TweenInfo.new(a522, Enum.EasingStyle.Quad), {Value = value})

        tween.Completed:Connect(
            function()
                --[[
                  line: 1549
                  upvalues:
                    instance2 (copy, index: 1)
                    callback (copy, index: 2)
                ]]
                instance2:Destroy()

                if callback then
                    callback()
                end
            end
        )

        tween:Play()
    end

    local function setGlow(glow)
        --[[
          name: setGlow
          line: 1557
          upvalues:
            v501 (ref,  index: 1)
            count2 (ref,  index: 2)
            tween (ref,  index: 3)
            parent5 (copy, index: 4)
            instance (copy, index: 5)
            fadeGlow (copy, index: 6)
            tweenService (copy, index: 7)
            parent6 (copy, index: 8)
            v511 (copy, index: 9)
            ui (copy, index: 10)
            v26 (copy, index: 11)
            state (copy, index: 12)
            a10 (copy, index: 13)
        ]]
        if glow == v501 then
            return
        end

        v501 = glow
        count2 += 1
        local v532 = count2

        if tween then
            tween:Cancel()
            tween = nil
        end

        if glow then
            parent5.Visible = true
            instance.Value = 0
            fadeGlow(1, 0.6)
            local propertyTable = {Value = 1}
            local tween2 = tweenService:Create(instance, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), propertyTable)
            tween = tween2
            tween2:Play()

            task.spawn(
                function()
                    --[[
                      line: 1575
                      upvalues:
                        v532 (copy, index: 1)
                        count2 (ref,  index: 2)
                        parent6 (copy, index: 3)
                        v511 (copy, index: 4)
                        ui (copy, index: 5)
                    ]]
                    task.wait(0.8)

                    while v532 == count2 do
                        parent6.Size = UDim2.fromScale(1, 1)
                        v511.Transparency = 0.25
                        local tweenInfo = TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        ui.Tween(parent6, tweenInfo, {Size = UDim2.new(1, 52, 1, 52)})
                        ui.Tween(v511, tweenInfo, {Transparency = 1})
                        task.wait(2.6)
                    end
                end
            )

            if not v26["Nudge:Glow"] then
                if state.Mock then
                    return
                end

                if a10.Remotes.Fire("AnalyticsReport", "Nudge", "Glow") then
                    v26["Nudge:Glow"] = true
                end
            end
        else
            v511.Transparency = 1

            fadeGlow(
                0,
                0.15,
                function()
                    --[[
                      line: 1589
                      upvalues:
                        v532 (copy, index: 1)
                        count2 (ref,  index: 2)
                        parent5 (copy, index: 3)
                    ]]
                    if v532 == count2 then
                        parent5.Visible = false
                    end
                end
            )
        end
    end

    local parent7 = ui.Panel({Name = "PlayCallout", BackgroundTransparency = 0.08, StrokeTransparency = 0.4, StrokeThickness = 1.5, Visible = false, AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.fromOffset(0, 52), AutomaticSize = Enum.AutomaticSize.X, StrokeColor = colors.Accent, Radius = UDim.new(0, 14), Parent = lobbyHud.Root})
    ui.Padding(0, 10, 0, 18).Parent = parent7
    local parent8 = ui.new("Frame", {Name = "Row", Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, (ui.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent7})
    local ui7 = ui.new("TextLabel", {Name = "Text", Text = "Start your first match", TextSize = 20, LayoutOrder = 1, Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent8})
    local parent9 = ui.new("Frame", {Name = "Arrow", LayoutOrder = 2, Size = UDim2.fromOffset(30, 30), Parent = parent8})
    local instance2 = ui.new("Frame", {Name = "Bob", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(30, 30), Parent = parent9})
    local v541 = ui.Icon("chevRight", 22, colors.Accent, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = instance2})
    local tween2 = nil
    local count3 = 0

    local function placeCallout()
        --[[
          name: placeCallout
          line: 1641
          upvalues:
            ui (copy, index: 1)
            playButton (copy, index: 2)
            lobbyHud (copy, index: 3)
            parent7 (copy, index: 4)
        ]]
        local v545 = math.max(ui.Scale, 0.01)
        local instance = playButton.Instance
        local root = lobbyHud.Root
        local v548 = (instance.AbsolutePosition.X - root.AbsolutePosition.X) / v545 - 14
        local v549 = (instance.AbsolutePosition.Y - root.AbsolutePosition.Y) / v545 + ((instance.AbsoluteSize.Y / v545) - 3) / 2
        parent7.Position = UDim2.fromOffset(math.floor(v548), (math.floor(v549)))
    end

    local compact = ui.Compact

    if compact then
        textSize = 22
    else
        textSize = 20
    end

    ui7.TextSize = textSize
    local udim2FromOffset = UDim2.fromOffset
    local v552 = compact and 56 or 52
    parent7.Size = udim2FromOffset(0, v552)
    udim2FromOffset = UDim2.fromOffset
    local v553 = compact and 24 or 22
    local v554 = compact and 24 or 22
    v541.Size = udim2FromOffset(v553, v554)

    ui.LayoutChanged:Connect(
        function()
            --[[
              name: sizeCallout
              line: 1650
              upvalues:
                ui (copy, index: 1)
                ui7 (copy, index: 2)
                parent7 (copy, index: 3)
                v541 (copy, index: 4)
            ]]
            local textSize
            local compact = ui.Compact

            if compact then
                textSize = 22
            else
                textSize = 20
            end

            ui7.TextSize = textSize
            local udim2FromOffset = UDim2.fromOffset
            local v558 = compact and 56 or 52
            parent7.Size = udim2FromOffset(0, v558)
            local udim2FromOffset2 = UDim2.fromOffset
            local v560 = compact and 24 or 22
            local v561 = compact and 24 or 22
            v541.Size = udim2FromOffset2(v560, v561)
        end
    )

    playButton.Instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(
        function()
            --[[
              line: 1658
              upvalues:
                callout2 (ref,  index: 1)
                placeCallout (copy, index: 2)
            ]]
            if callout2 then
                placeCallout()
            end
        end
    )

    playButton.Instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(
        function()
            --[[
              line: 1663
              upvalues:
                callout2 (ref,  index: 1)
                placeCallout (copy, index: 2)
            ]]
            if callout2 then
                placeCallout()
            end
        end
    )

    local function setCallout(callout)
        --[[
          name: setCallout
          line: 1669
          upvalues:
            callout2 (ref,  index: 1)
            count3 (ref,  index: 2)
            tween2 (ref,  index: 3)
            instance2 (copy, index: 4)
            placeCallout (copy, index: 5)
            ui (copy, index: 6)
            parent7 (copy, index: 7)
            tweenService (copy, index: 8)
            v26 (copy, index: 9)
            state (copy, index: 10)
            a10 (copy, index: 11)
        ]]
        if callout == callout2 then
            return
        end

        callout2 = callout
        count3 += 1
        local v564 = count3

        if tween2 then
            tween2:Cancel()
            tween2 = nil
            instance2.Position = UDim2.fromScale(0.5, 0.5)
        end

        if callout then
            placeCallout()
            ui.Unfade(parent7)
            parent7.Visible = true
            ui.Enter(parent7, Vector2.new(-18, 0), 0, parent7.Position)
            local tween = tweenService:Create(instance2, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Position = UDim2.new(0.5, 5, 0.5, 0)})
            tween2 = tween
            tween:Play()

            if not v26["Nudge:Callout"] then
                if state.Mock then
                    return
                end

                if a10.Remotes.Fire("AnalyticsReport", "Nudge", "Callout") then
                    v26["Nudge:Callout"] = true
                end
            end
        else
            ui.FadeOut(parent7, TweenInfo.new(0.14))

            task.delay(
                0.16,
                function()
                    --[[
                      line: 1696
                      upvalues:
                        v564 (copy, index: 1)
                        count3 (ref,  index: 2)
                        parent7 (copy, index: 3)
                        ui (copy, index: 4)
                    ]]
                    if v564 == count3 then
                        parent7.Visible = false
                        ui.Unfade(parent7)
                    end
                end
            )
        end
    end

    local function nudgeEligible()
        --[[
          name: nudgeEligible
          line: 1705
          upvalues:
            pressed (ref,  index: 1)
            state (copy, index: 2)
            localPlayer (copy, index: 3)
        ]]
        if pressed or state.Mock or not state.HasProfile then
            return false
        end

        local stats = state.Profile and state.Profile.stats

        if type(stats) == "table" and not (0 < (tonumber(stats.matches) or 0)) then
            return localPlayer:GetAttribute("WelcomeCard") ~= true
        end

        return false
    end

    local function playOnScreen()
        --[[
          name: playOnScreen
          line: 1715
          upvalues:
            localPlayer (copy, index: 1)
            state (copy, index: 2)
            lobbyHud (copy, index: 3)
            playButton (copy, index: 4)
            menuManager (copy, index: 5)
        ]]
        local v569 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
        v569 = v569 and state.HasProfile and not state.InMatch() and lobbyHud.Root.Visible

        return v569
            and playButton.Instance.Visible
            and not menuManager.IsOpen()
            and state.Get("Queued") ~= true
    end

    playButton.Activated:Connect(
        function()
            --[[
              line: 1718
              upvalues:
                pressed (ref,  index: 1)
                v501 (ref,  index: 2)
                count2 (ref,  index: 3)
                tween (ref,  index: 4)
                v511 (copy, index: 5)
                fadeGlow (copy, index: 6)
                parent5 (copy, index: 7)
                callout2 (ref,  index: 8)
                count3 (ref,  index: 9)
                tween2 (ref,  index: 10)
                instance2 (copy, index: 11)
                ui (copy, index: 12)
                parent7 (copy, index: 13)
            ]]
            pressed = true

            if v501 ~= false then
                v501 = false
                count2 += 1
                local v570 = count2

                if tween then
                    tween:Cancel()
                    tween = nil
                end

                v511.Transparency = 1

                fadeGlow(
                    0,
                    0.15,
                    function()
                        --[[
                          line: 1589
                          upvalues:
                            v570 (copy, index: 1)
                            count2 (ref,  index: 2)
                            parent5 (copy, index: 3)
                        ]]
                        if v570 == count2 then
                            parent5.Visible = false
                        end
                    end
                )
            end

            if callout2 == false then
                return
            end

            callout2 = false
            count3 += 1
            local v571 = count3

            if tween2 then
                tween2:Cancel()
                tween2 = nil
                instance2.Position = UDim2.fromScale(0.5, 0.5)
            end

            ui.FadeOut(parent7, TweenInfo.new(0.14))

            task.delay(
                0.16,
                function()
                    --[[
                      line: 1696
                      upvalues:
                        v571 (copy, index: 1)
                        count3 (ref,  index: 2)
                        parent7 (copy, index: 3)
                        ui (copy, index: 4)
                    ]]
                    if v571 == count3 then
                        parent7.Visible = false
                        ui.Unfade(parent7)
                    end
                end
            )
        end
    )

    ui.Every(
        parent,
        0.1,
        function()
            --[[
              line: 1725
              upvalues:
                localPlayer (copy, index: 1)
                state (copy, index: 2)
                lobbyHud (copy, index: 3)
                v26 (copy, index: 4)
                a10 (copy, index: 5)
                v43 (ref,  index: 6)
                build (copy, index: 7)
                v45 (ref,  index: 8)
                ui (copy, index: 9)
                v49 (ref,  index: 10)
                v46 (ref,  index: 11)
                detourTick (copy, index: 12)
                answered (ref,  index: 13)
                card (ref,  index: 14)
                readyForCard (copy, index: 15)
                timestamp (ref,  index: 16)
                menuManager (copy, index: 17)
                pressed (ref,  index: 18)
                playButton (copy, index: 19)
                v500 (ref,  index: 20)
                setGlow (copy, index: 21)
                setCallout (copy, index: 22)
            ]]
            local v572
            local v573 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
            v573 = v573 and state.HasProfile and not state.InMatch() and lobbyHud.Root.Visible

            if v573 then
                local v574 = math.floor(time() * 10) / 10
                local v575 = type(v574) ~= "string" and "" or ":" .. v574
                local v576 = "Loaded" .. v575

                if not v26[v576] and not state.Mock and a10.Remotes.Fire("AnalyticsReport", "Loaded", v574) then
                    v26[v576] = true
                end
            end

            if v43 then
                if v43 then
                    if (v45 or v43.compact ~= ui.Compact) and not (v49) then
                        local timestamp2 = os.clock()

                        if v46 <= timestamp2 then
                            build()
                        end
                    end
                else
                    build()
                end
            end

            detourTick()

            if localPlayer:GetAttribute("WelcomeCard") ~= true or answered or card or not readyForCard() then
                timestamp = nil
            else
                timestamp = timestamp or os.clock()

                if 0.6 <= os.clock() - timestamp then
                    timestamp = nil
                    menuManager.Open("Welcome")
                end
            end

            if pressed or state.Mock or not state.HasProfile then
                v572 = false
            else
                local stats = state.Profile and state.Profile.stats

                if type(stats) ~= "table" or 0 < (tonumber(stats.matches) or 0) then
                    v572 = false
                else
                    v572 = localPlayer:GetAttribute("WelcomeCard") ~= true
                end
            end

            if v572 then
                v572 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
                v572 = v572 and state.HasProfile and not state.InMatch() and lobbyHud.Root.Visible
                v572 = v572
                    and playButton.Instance.Visible
                    and not menuManager.IsOpen()
                    and state.Get("Queued") ~= true
            end

            if v572 then
                v500 += 0.1
            end

            setGlow(v572)
            local callout = v572 and 6 <= v500 and state.Get("CombatMode") ~= true
            setCallout(callout)
        end
    )

    local function resetSession()
        --[[
          name: resetSession
          line: 1753
          upvalues:
            answered (ref,  index: 1)
            v49 (ref,  index: 2)
            pressed (ref,  index: 3)
            v500 (ref,  index: 4)
            timestamp (ref,  index: 5)
            detour (ref,  index: 6)
            a10 (copy, index: 7)
            v501 (ref,  index: 8)
            count2 (ref,  index: 9)
            tween (ref,  index: 10)
            v511 (copy, index: 11)
            fadeGlow (copy, index: 12)
            parent5 (copy, index: 13)
            callout2 (ref,  index: 14)
            count3 (ref,  index: 15)
            tween2 (ref,  index: 16)
            instance2 (copy, index: 17)
            ui (copy, index: 18)
            parent7 (copy, index: 19)
            v26 (copy, index: 20)
        ]]
        answered = false
        v49 = false
        pressed = false
        v500 = 0
        timestamp = nil

        if detour then
            detour = false
            a10.SetHudHidden("Welcome", false)

            if a10.TopbarSettings then
                a10.TopbarSettings.SetHidden("Welcome", false)
            end
        end

        if v501 ~= false then
            v501 = false
            count2 += 1
            local v581 = count2

            if tween then
                tween:Cancel()
                tween = nil
            end

            v511.Transparency = 1

            fadeGlow(
                0,
                0.15,
                function()
                    --[[
                      line: 1589
                      upvalues:
                        v581 (copy, index: 1)
                        count2 (ref,  index: 2)
                        parent5 (copy, index: 3)
                    ]]
                    if v581 == count2 then
                        parent5.Visible = false
                    end
                end
            )
        end

        if callout2 ~= false then
            callout2 = false
            count3 += 1
            local v582 = count3

            if tween2 then
                tween2:Cancel()
                tween2 = nil
                instance2.Position = UDim2.fromScale(0.5, 0.5)
            end

            ui.FadeOut(parent7, TweenInfo.new(0.14))

            task.delay(
                0.16,
                function()
                    --[[
                      line: 1696
                      upvalues:
                        v582 (copy, index: 1)
                        count3 (ref,  index: 2)
                        parent7 (copy, index: 3)
                        ui (copy, index: 4)
                    ]]
                    if v582 == count3 then
                        parent7.Visible = false
                        ui.Unfade(parent7)
                    end
                end
            )
        end

        table.clear(v26)
    end

    if runService:IsStudio() or game.PlaceId == Config.STAGING_PLACE_ID then
        a10.ReplayNewPlayer = function(a583)
            --[[
              line: 1766
              upvalues:
                a10 (copy, index: 1)
                answered (ref,  index: 2)
                v49 (ref,  index: 3)
                pressed (ref,  index: 4)
                v500 (ref,  index: 5)
                timestamp (ref,  index: 6)
                detour (ref,  index: 7)
                v501 (ref,  index: 8)
                count2 (ref,  index: 9)
                tween (ref,  index: 10)
                v511 (copy, index: 11)
                fadeGlow (copy, index: 12)
                parent5 (copy, index: 13)
                callout2 (ref,  index: 14)
                count3 (ref,  index: 15)
                tween2 (ref,  index: 16)
                instance2 (copy, index: 17)
                ui (copy, index: 18)
                parent7 (copy, index: 19)
                v26 (copy, index: 20)
                menuManager (copy, index: 21)
            ]]
            local queueAction = a10.QueueAction
            local v585 = a583 and "ReplayFullHub" or "ReplayNewPlayer"
            local v586 = queueAction(v585)
            if v586 then
                answered = false
                v49 = false
                pressed = false
                v500 = 0
                timestamp = nil

                if detour then
                    detour = false
                    a10.SetHudHidden("Welcome", false)

                    if a10.TopbarSettings then
                        a10.TopbarSettings.SetHidden("Welcome", false)
                    end
                end

                if v501 ~= false then
                    v501 = false
                    count2 += 1
                    local v587 = count2

                    if tween then
                        tween:Cancel()
                        tween = nil
                    end

                    v511.Transparency = 1

                    fadeGlow(
                        0,
                        0.15,
                        function()
                            --[[
                              line: 1589
                              upvalues:
                                v587 (copy, index: 1)
                                count2 (ref,  index: 2)
                                parent5 (copy, index: 3)
                            ]]
                            if v587 == count2 then
                                parent5.Visible = false
                            end
                        end
                    )
                end

                local v588

                if callout2 ~= false then
                    callout2 = false
                    count3 += 1
                    local v589 = count3

                    if tween2 then
                        tween2:Cancel()
                        tween2 = nil
                        instance2.Position = UDim2.fromScale(0.5, 0.5)
                    end

                    ui.FadeOut(parent7, TweenInfo.new(0.14))

                    task.delay(
                        0.16,
                        function()
                            --[[
                              line: 1696
                              upvalues:
                                v589 (copy, index: 1)
                                count3 (ref,  index: 2)
                                parent7 (copy, index: 3)
                                ui (copy, index: 4)
                            ]]
                            if v589 == count3 then
                                parent7.Visible = false
                                ui.Unfade(parent7)
                            end
                        end
                    )
                end

                table.clear(v26)
                menuManager.CloseAll()
                local toast = a10.Toast

                if a583 then
                    v588 = "Full hub: FIGHT sends you to a match server"
                else
                    v588 = "New-player flow reset"
                end

                toast(v588, "success")
            end

            return v586
        end
    end

    a10.Debug.onboarding = function(a591, version)
        --[[
          line: 1778
          upvalues:
            fight (copy, index: 1)
            explore (copy, index: 2)
            customize (copy, index: 3)
            setVersion (copy, index: 4)
            v43 (ref,  index: 5)
            answered (ref,  index: 6)
            v49 (ref,  index: 7)
            pressed (ref,  index: 8)
            v500 (ref,  index: 9)
            timestamp (ref,  index: 10)
            detour (ref,  index: 11)
            a10 (copy, index: 12)
            v501 (ref,  index: 13)
            count2 (ref,  index: 14)
            tween (ref,  index: 15)
            v511 (copy, index: 16)
            fadeGlow (copy, index: 17)
            parent5 (copy, index: 18)
            callout2 (ref,  index: 19)
            count3 (ref,  index: 20)
            tween2 (ref,  index: 21)
            instance2 (copy, index: 22)
            ui (copy, index: 23)
            parent7 (copy, index: 24)
            v26 (copy, index: 25)
            localPlayer (copy, index: 26)
            card (ref,  index: 27)
            v11 (ref,  index: 28)
            parent2 (copy, index: 29)
            ui3 (copy, index: 30)
            readyForCard (copy, index: 31)
            state (copy, index: 32)
            lobbyHud (copy, index: 33)
            playButton (copy, index: 34)
            menuManager (copy, index: 35)
        ]]
        local eligible

        if a591 == "fight" then
            task.spawn(fight)
        elseif a591 == "explore" then
            task.spawn(explore)
        elseif a591 == "customize" then
            task.spawn(customize)
        else
            if a591 == "version" then
                return (setVersion(version))
            end

            if a591 == "pick" then
                if not v43 or not v43.pick or type(version) ~= "number" then
                    return false
                end

                task.spawn(v43.pick, version)
            elseif a591 == "reset" then
                answered = false
                v49 = false
                pressed = false
                v500 = 0
                timestamp = nil

                if detour then
                    detour = false
                    a10.SetHudHidden("Welcome", false)

                    if a10.TopbarSettings then
                        a10.TopbarSettings.SetHidden("Welcome", false)
                    end
                end

                if v501 ~= false then
                    v501 = false
                    count2 += 1
                    local v594 = count2

                    if tween then
                        tween:Cancel()
                        tween = nil
                    end

                    v511.Transparency = 1

                    fadeGlow(
                        0,
                        0.15,
                        function()
                            --[[
                              line: 1589
                              upvalues:
                                v594 (copy, index: 1)
                                count2 (ref,  index: 2)
                                parent5 (copy, index: 3)
                            ]]
                            if v594 == count2 then
                                parent5.Visible = false
                            end
                        end
                    )
                end

                if callout2 ~= false then
                    callout2 = false
                    count3 += 1
                    local v595 = count3

                    if tween2 then
                        tween2:Cancel()
                        tween2 = nil
                        instance2.Position = UDim2.fromScale(0.5, 0.5)
                    end

                    ui.FadeOut(parent7, TweenInfo.new(0.14))

                    task.delay(
                        0.16,
                        function()
                            --[[
                              line: 1696
                              upvalues:
                                v595 (copy, index: 1)
                                count3 (ref,  index: 2)
                                parent7 (copy, index: 3)
                                ui (copy, index: 4)
                            ]]
                            if v595 == count3 then
                                parent7.Visible = false
                                ui.Unfade(parent7)
                            end
                        end
                    )
                end

                table.clear(v26)
            elseif a591 == "callout" then
                v500 = math.max(v500, 6)
            end
        end

        local parts = {}

        for v597 in v26 do
            table.insert(parts, v597)
        end

        table.sort(parts)
        local v598 = {}
        local welcomeCard = localPlayer:GetAttribute("WelcomeCard") == true
        v598.want = welcomeCard
        v598.card = card
        v598.version = v11
        v598.built = v43 and v43.version
        v598.detour = detour
        v598.size = string.format("%dx%d @%.2f", parent2.Size.X.Offset, parent2.Size.Y.Offset, ui3.Scale)
        v598.answered = answered
        v598.ready = readyForCard()
        local v600 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
        local visible = v600 and state.HasProfile and not state.InMatch() and lobbyHud.Root.Visible
        v598.lobbyShown = visible

        if pressed or state.Mock or not state.HasProfile then
            eligible = false
        else
            local stats = state.Profile and state.Profile.stats

            if type(stats) ~= "table" or 0 < (tonumber(stats.matches) or 0) then
                eligible = false
            else
                eligible = localPlayer:GetAttribute("WelcomeCard") ~= true
            end
        end

        v598.eligible = eligible
        local v603 = localPlayer:GetAttribute("LoadingShownMs") ~= nil
        v603 = v603 and state.HasProfile and not state.InMatch() and lobbyHud.Root.Visible
        local playOnScreen = v603
            and playButton.Instance.Visible
            and not menuManager.IsOpen()
            and state.Get("Queued") ~= true
        v598.playOnScreen = playOnScreen
        v598.glow = v501
        v598.callout = callout2
        v598.onScreen = math.floor(v500 * 10) / 10
        v598.pressed = pressed
        v598.sent = table.concat(parts, ",")

        return v598
    end
end

return v5