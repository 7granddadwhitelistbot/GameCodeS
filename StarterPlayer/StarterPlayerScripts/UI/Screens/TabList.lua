local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "Keybinds"
local child = require(shared:WaitForChild(childName))
local Tribes = require(shared:WaitForChild("Tribes"))
local RankArt = require(script.Parent.Parent.RankArt)
local v9 = {}
local v10 = {width = 900, row = 52, portrait = 40, text = 19, gearX = 330, gear = 34, k = 640, d = 705, a = 770, dmg = 845}
local v11 = {width = 640, row = 36, portrait = 30, text = 16, gearX = 0, gear = 0, k = 385, d = 440, a = 495, dmg = 565}

function v9.Init(a12)
    --[[
      name: Init
      line: 44
      upvalues:
        players (copy, index: 1)
        v10 (copy, index: 2)
        Tribes (copy, index: 3)
        RankArt (copy, index: 4)
        v11 (copy, index: 5)
        child (copy, index: 6)
        userInputService (copy, index: 7)
    ]]
    local ui = a12.UI
    local theme = a12.Theme
    local state = a12.State
    local portraits = a12.Portraits
    local weaponIcon = a12.WeaponIcon
    local colors = theme.Colors
    local fonts = theme.Fonts
    local menuManager = a12.MenuManager
    local localPlayer = players.LocalPlayer
    local textColor3 = Color3.fromRGB(142, 149, 166)
    local TribeEmblem = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem.Init(ui)
    local parent = ui.new("Frame", {Name = "TabList", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(v10.width, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.08, Visible = false, ZIndex = 40, ui.Corner(16), ui.Stroke(colors.Stroke, 1, 0.85), ui.Padding(14, 16, 16, 16), (ui.List(Enum.FillDirection.Vertical, 10)), Parent = a12.Canvas.HUD})
    local v25 = v10
    local ui2 = ui.new("TextButton", {Name = "TapToClose", Text = "", AutoButtonColor = false, Selectable = false, Visible = false, ZIndex = 45, AnchorPoint = Vector2.new(0.5, 0.5), Parent = a12.Canvas.HUD})
    local parent2 = ui.new("Frame", {Name = "Clash", Size = UDim2.new(1, 0, 0, 60), LayoutOrder = 1, BackgroundColor3 = Color3.new(1, 1, 1), Visible = false, ClipsDescendants = true, ZIndex = 40, (ui.Corner(12)), Parent = parent})
    local v28 = ui.Gradient(colors.Ally, colors.Enemy, 0)
    v28.Parent = parent2
    local v29 = {TribeEmblem.new(44, {ZIndex = 41, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Parent = parent2}), TribeEmblem.new(44, {ZIndex = 41, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = parent2})}

    local function clashTag(a31: number)
        --[[
          name: clashTag
          line: 83
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
            parent2 (copy, index: 4)
        ]]
        local newUi = ui.new
        local v33 = "TextLabel"
        local v34 = {AutoLocalize = false, Text = "", TextSize = 22, ZIndex = 41, Name = "Tag" .. a31, FontFace = fonts.Display, TextColor3 = colors.Text, TextXAlignment = if a31 == 1 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Right}
        local newVector2 = Vector2.new
        local x = a31 ~= 1 and 1 or 0
        v34.AnchorPoint = newVector2(x, 0.5)
        local newUDim2 = UDim2.new
        local v38 = a31 ~= 1 and 1 or 0
        local v39 = a31 ~= 1 and -64 or 64
        v34.Position = newUDim2(v38, v39, 0.5, 0)
        v34.Size = UDim2.fromOffset(120, 26)
        v34.Parent = parent2
        local parent = newUi(v33, v34)
        ui.TextStroke(colors.Void, 1.5, 0.4).Parent = parent

        return parent
    end

    local v41 = {clashTag(1), (clashTag(2))}
    local parent3 = ui.new("TextLabel", {Name = "Title", Text = "TRIBE CLASH", TextSize = 24, ZIndex = 41, FontFace = fonts.Display, TextColor3 = Color3.fromRGB(255, 214, 110), AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(1, -380, 0, 26), Parent = parent2})
    ui.TextStroke(colors.Void, 2, 0.3).Parent = parent3
    local parent4 = ui.new("TextLabel", {Name = "Sub", Text = "", TextSize = 12, ZIndex = 41, FontFace = fonts.Heavy, TextColor3 = colors.Text, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 36), Size = UDim2.new(1, -300, 0, 14), TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent2})
    ui.TextStroke(colors.Void, 1, 0.5).Parent = parent4
    local v44 = {}
    local v45 = {}

    local function makeBlock(a47: number)
        --[[
          name: makeBlock
          line: 114
          upvalues:
            ui (copy, index: 1)
            parent (copy, index: 2)
            colors (copy, index: 3)
            TribeEmblem (copy, index: 4)
            fonts (copy, index: 5)
            theme (copy, index: 6)
        ]]
        local ui2 = ui.new("Frame", {Name = "Team" .. a47, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = a47 + 1, ZIndex = 40, (ui.List(Enum.FillDirection.Vertical, 6)), Parent = parent})
        local parent2 = ui.new("Frame", {Name = "Top", LayoutOrder = 0, ZIndex = 40, Size = UDim2.new(1, 0, 0, 28), Parent = ui2})
        local parent3 = ui.new("Frame", {Name = "Left", Size = UDim2.new(1, -200, 1, 0), ZIndex = 40, (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent2})
        local bar = ui.new("Frame", {Name = "Bar", Size = UDim2.fromOffset(4, 18), LayoutOrder = 1, BackgroundColor3 = colors.Ally, ZIndex = 40, (ui.Corner(2)), Parent = parent3})
        local ui3 = ui.new("Frame", {Name = "Crest", LayoutOrder = 2, Visible = false, ZIndex = 40, Size = UDim2.fromOffset(24, 26), Parent = parent3})
        local crest = TribeEmblem.new(24, {ZIndex = 41, Parent = ui3})
        local title = ui.new("TextLabel", {Name = "Title", Text = "", AutoLocalize = false, RichText = true, TextSize = 16, LayoutOrder = 3, ZIndex = 40, FontFace = fonts.Heavy, TextColor3 = colors.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), Parent = parent3})
        local ui4 = ui.new("Frame", {Name = "Score", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), LayoutOrder = 4, BackgroundColor3 = colors.Ally, BackgroundTransparency = 0.7, ZIndex = 40, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 9, 0, 9)), Parent = parent3})
        local score = ui.new("TextLabel", {Name = "Text", Text = "0", TextSize = 16, ZIndex = 41, FontFace = fonts.Display, TextColor3 = colors.Text, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = ui4})
        local ui5 = ui.new("Frame", {Name = "Glory", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 22), LayoutOrder = 5, Visible = false, BackgroundColor3 = Color3.fromRGB(255, 186, 46), BackgroundTransparency = 0.82, ZIndex = 40, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 9, 0, 9)), Parent = parent3})
        local chipText = ui.new("TextLabel", {Name = "Text", Text = "", TextSize = 12, ZIndex = 41, FontFace = fonts.Heavy, TextColor3 = Color3.fromRGB(255, 196, 80), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = ui5})
        local caps = {}

        for v60, v61 in {"K", "D", "A", "DMG"} do
            local newUi = ui.new
            local v63 = {TextSize = 13, ZIndex = 40, Name = v61, Text = v61, FontFace = fonts.Heavy, TextColor3 = colors.TextDim, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0)}
            local udim2FromOffset = UDim2.fromOffset
            local v65 = v60 ~= 4 and 60 or 80
            v63.Size = udim2FromOffset(v65, 16)
            v63.Parent = parent2
            caps[v60] = newUi("TextLabel", v63)
        end

        local list = ui.new("Frame", {Name = "Rows", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, ZIndex = 40, (ui.List(Enum.FillDirection.Vertical, 6)), Parent = ui2})

        return {frame = ui2, bar = bar, crest = crest, crestHolder = ui3, title = title, score = score, scorePill = ui4, chip = ui5, chipText = chipText, caps = caps, list = list}
    end

    v44[1] = makeBlock(1)
    v44[2] = makeBlock(2)

    local function placeColumns()
        --[[
          name: placeColumns
          line: 142
          upvalues:
            v25 (ref,  index: 1)
            v44 (copy, index: 2)
        ]]
        local v68 = {v25.k, v25.d, v25.a, v25.dmg}

        for _, v70 in v44 do
            for v71, cap in v70.caps do
                cap.Position = UDim2.new(0, v68[v71], 0.5, 0)
            end
        end
    end

    local v73 = false
    local v74 = false
    local v75 = nil
    local mod = false
    local timestamp = -math.huge
    local v78 = nil
    local v79 = false
    local update = nil

    local function showBans()
        --[[
          name: showBans
          line: 161
          upvalues:
            v45 (copy, index: 1)
            mod (ref,  index: 2)
            v74 (ref,  index: 3)
            v78 (ref,  index: 4)
        ]]
        for v82, v83 in v45 do
            if v83.ban then
                local ban = v83.ban
                ban.Visible = mod and not v83.me and (v74 or v78 == v82)
            end
        end
    end

    local function askMod()
        --[[
          name: askMod
          line: 168
          upvalues:
            mod (ref,  index: 1)
            timestamp (ref,  index: 2)
            a12 (copy, index: 3)
            parent (copy, index: 4)
            update (ref,  index: 5)
        ]]
        if mod or os.clock() - timestamp < 300 then
            return
        end

        timestamp = os.clock()

        task.spawn(
            function()
                --[[
                  line: 173
                  upvalues:
                    a12 (copy, index: 1)
                    mod (ref,  index: 2)
                    parent (copy, index: 3)
                    update (ref,  index: 4)
                ]]
                local v86, v87 = a12.Remotes.Invoke("ModAction", "IsMod")

                if v86 and v87 == true and not mod then
                    mod = true

                    if parent.Visible then
                        update()
                    end
                end
            end
        )
    end

    local function pressBan(key)
        --[[
          name: pressBan
          line: 183
          upvalues:
            v45 (copy, index: 1)
            v79 (ref,  index: 2)
            mod (ref,  index: 3)
            a12 (copy, index: 4)
        ]]
        local v90 = v45[key]

        if v79 or not v90 or not mod then
            return
        end

        v79 = true

        task.spawn(
            function()
                --[[
                  line: 189
                  upvalues:
                    a12 (copy, index: 1)
                    key (copy, index: 2)
                    v90 (copy, index: 3)
                    v79 (ref,  index: 4)
                ]]
                local v91, v92, v93 = a12.Remotes.Invoke("ModAction", "RowBan", key, v90.who)
                v79 = false

                if not v91 then
                    a12.Toast("Couldn't reach the server. Try again.", "error")
                    return
                end

                if v92 ~= true and type(v93) == "string" and v93 ~= "" then
                    a12.Toast(v93, "error")
                end
            end
        )
    end

    local function banButton(a95, id)
        --[[
          name: banButton
          line: 199
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
            v25 (ref,  index: 4)
            theme (copy, index: 5)
            v45 (copy, index: 6)
            v79 (ref,  index: 7)
            mod (ref,  index: 8)
            a12 (copy, index: 9)
        ]]
        local ui2 = ui.new("TextButton", {Name = "Ban", Text = "BAN", AutoLocalize = false, FontFace = fonts.Heavy, TextSize = 13, TextColor3 = colors.Text, BackgroundColor3 = colors.Danger, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(0, v25.k - 36, 0.5, 0), Size = UDim2.fromOffset(52, 26), Selectable = false, Visible = false, ZIndex = 46, (ui.Corner(theme.Radius.Pill)), Parent = a95.frame})

        ui2.Activated:Connect(
            function()
                --[[
                  line: 217
                  upvalues:
                    id (copy, index: 1)
                    v45 (copy, index: 2)
                    v79 (ref,  index: 3)
                    mod (ref,  index: 4)
                    a12 (copy, index: 5)
                ]]
                local id2 = id
                local v99 = v45[id2]

                if not v79 and v99 and mod then
                    v79 = true

                    task.spawn(
                        function()
                            --[[
                              line: 189
                              upvalues:
                                a12 (copy, index: 1)
                                id2 (copy, index: 2)
                                v99 (copy, index: 3)
                                v79 (ref,  index: 4)
                            ]]
                            local v100, v101, v102 = a12.Remotes.Invoke("ModAction", "RowBan", id2, v99.who)
                            v79 = false

                            if not v100 then
                                a12.Toast("Couldn't reach the server. Try again.", "error")
                                return
                            end

                            if v101 ~= true and type(v102) == "string" and v102 ~= "" then
                                a12.Toast(v102, "error")
                            end
                        end
                    )
                end
            end
        )

        return ui2
    end

    local function makeRow(id)
        --[[
          name: makeRow
          line: 223
          upvalues:
            ui (copy, index: 1)
            v25 (ref,  index: 2)
            colors (copy, index: 3)
            v44 (copy, index: 4)
            theme (copy, index: 5)
            fonts (copy, index: 6)
            textColor3 (copy, index: 7)
            v78 (ref,  index: 8)
            showBans (copy, index: 9)
        ]]
        local ui2 = ui.new("Frame", {Name = "R_" .. id, Size = UDim2.new(1, 0, 0, v25.row), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.45, ZIndex = 40, (ui.Corner(10)), Parent = v44[1].list})
        local stroke = ui.Stroke(colors.Accent, 2, 0)
        stroke.Enabled = false
        stroke.Parent = ui2
        local stripe = ui.new("Frame", {Name = "Tribe", Position = UDim2.fromOffset(0, 8), Size = UDim2.new(0, 3, 1, -16), BackgroundColor3 = colors.Text, Visible = false, ZIndex = 42, (ui.Corner(2)), Parent = ui2})
        local img = ui.new("ImageLabel", {Name = "Img", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(v25.portrait, v25.portrait), BackgroundColor3 = colors.Raised, ScaleType = Enum.ScaleType.Crop, ZIndex = 41, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local v109 = v25.portrait + 14
        local v110 = if 0 < v25.gear then v25.gearX else v25.k - 40
        local nameW = v110 - v109 - 10
        local name = ui.new("TextLabel", {Name = "Name", Text = "", AutoLocalize = false, RichText = true, ZIndex = 41, FontFace = fonts.Heavy, TextSize = v25.text, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, v109, 0.5, -v25.text + 1), Size = UDim2.fromOffset(nameW, v25.text + 2), Parent = ui2})
        local sub = ui.new("TextLabel", {Name = "Sub", Text = "", RichText = true, TextSize = 12, ZIndex = 41, FontFace = fonts.SemiBold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, v109, 0.5, 3), Size = UDim2.fromOffset(nameW, 14), Parent = ui2})
        local newUi = ui.new
        local v115 = {Name = "Gear", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, v25.gearX, 0.5, 0), Size = UDim2.fromOffset(math.max(0, (v25.k - 40) - v25.gearX), v25.gear)}
        local visible = 0 < v25.gear
        v115.Visible = visible
        v115.ZIndex = 41
        v115[1] = (ui.List(Enum.FillDirection.Horizontal, 4, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center))
        v115.Parent = ui2
        local gear = newUi("Frame", v115)
        local cells = {}

        for v119, v120 in {v25.k, v25.d, v25.a, v25.dmg} do
            local newUi2 = ui.new
            local v122 = {Text = "0", ZIndex = 41, FontFace = fonts.Display, TextSize = v25.text + 3, TextColor3 = colors.Text, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, v120, 0.5, 0)}
            local udim2FromOffset = UDim2.fromOffset
            local v124 = v119 ~= 4 and 60 or 80
            v122.Size = udim2FromOffset(v124, v25.row)
            v122.Parent = ui2
            cells[v119] = newUi2("TextLabel", v122)
        end

        ui2.MouseEnter:Connect(
            function()
                --[[
                  line: 259
                  upvalues:
                    v78 (ref,  index: 1)
                    id (copy, index: 2)
                    showBans (copy, index: 3)
                ]]
                v78 = id
                showBans()
            end
        )

        ui2.MouseLeave:Connect(
            function()
                --[[
                  line: 263
                  upvalues:
                    v78 (ref,  index: 1)
                    id (copy, index: 2)
                    showBans (copy, index: 3)
                ]]
                if v78 == id then
                    v78 = nil
                    showBans()
                end
            end
        )

        return {gearKey = "", ban = nil, who = "", me = false, frame = ui2, stroke = stroke, stripe = stripe, img = img, name = name, sub = sub, nameW = nameW, gear = gear, cells = cells}
    end

    local function teamTribe(team)
        --[[
          name: teamTribe
          line: 273
        ]]
        local v127
        local tribe
        local v129 = {}
        local v130 = 0

        if type(team) ~= "table" or type(team.members) ~= "table" then
            v127 = {}
        else
            v127 = team.members
        end

        tribe = nil

        for _, v132 in v127 do
            local tribe2 = v132.tribe

            if type(tribe2) == "table" then
                if type(tribe2.id) ~= "number" then
                    continue
                end

                v129[tribe2.id] = (v129[tribe2.id] or 0) + 1

                if not (2 <= v129[tribe2.id]) or not (v130 < v129[tribe2.id]) then
                    continue
                end

                v130 = v129[tribe2.id]
                tribe = tribe2
            end
        end

        return tribe, v130
    end

    local v134 = {}

    state.MatchEvent:Connect(
        function(a135, a136)
            --[[
              line: 290
              upvalues:
                state (copy, index: 1)
                v134 (copy, index: 2)
            ]]
            if a135 == "MatchStart" and type(a136) == "table" then
                local holder
                local match = state.Match
                local mapId = match and match.mapId or a136.mapId or ""
                local text = tostring(mapId)

                if type(a136.holder) ~= "table" then
                    holder = false
                else
                    holder = a136.holder
                end

                v134[text] = holder
            end
        end
    )

    local v141 = false

    local function mapHolder(match)
        --[[
          name: mapHolder
          line: 298
          upvalues:
            v134 (copy, index: 1)
            a12 (copy, index: 2)
            v141 (ref,  index: 3)
        ]]
        local text = tostring((match.mapId or ""))
        local v145 = v134[text]
        if v145 ~= nil then
            return v145 or nil
        end

        local v146 = a12.Tribes and a12.Tribes.CachedTerritories()
        local map = v146 and v146.maps and v146.maps[text]
        if not map then
            if a12.Tribes and not v141 then
                v141 = true

                task.spawn(
                    function()
                        --[[
                          line: 313
                          upvalues:
                            a12 (copy, index: 1)
                            v141 (ref,  index: 2)
                        ]]
                        a12.Tribes.Territories(false)
                        v141 = false
                    end
                )
            end

            return nil
        end

        local tribe

        if map.holder then
            tribe = v146.tribes and v146.tribes[tostring(map.holder)]
        else
            tribe = nil
        end

        v134[text] = tribe or false

        return tribe
    end

    local function score(a150)
        --[[
          name: score
          line: 321
        ]]
        return ((tonumber(a150.kills) or 0) * 100) + (tonumber(a150.damage) or 0) + ((tonumber(a150.assists) or 0) * 40)
    end

    local function paintRow(a152, a153, a154: boolean, layoutOrder, a156)
        --[[
          name: paintRow
          line: 325
          upvalues:
            state (copy, index: 1)
            mod (ref,  index: 2)
            banButton (copy, index: 3)
            v25 (ref,  index: 4)
            Tribes (copy, index: 5)
            colors (copy, index: 6)
            portraits (copy, index: 7)
            TribeEmblem (copy, index: 8)
            a12 (copy, index: 9)
            RankArt (copy, index: 10)
            ui (copy, index: 11)
            weaponIcon (copy, index: 12)
        ]]
        local v157
        local v158
        local v159 = a153.id == state.MyId()
        a152.me = v159
        a152.who = tostring((a153.name or ""))

        if mod and not v159 and not a152.ban then
            a152.ban = banButton(a152, a153.id)
        end

        local v160 = if a152.ban and v25.gear == 0 then a152.nameW - 52 - 8 else a152.nameW
        a152.name.Size = UDim2.fromOffset(v160, v25.text + 2)
        a152.sub.Size = UDim2.fromOffset(v160, 14)
        local visible = a156 ~= nil and type(a153.tribe) == "table" and a153.tribe.id == a156.id
        a152.stripe.Visible = visible

        if visible then
            a152.stripe.BackgroundColor3 = Tribes.Color(a156.color1)
        end

        local alive = a153.alive ~= false
        local v163 = a153.connected == false
        a152.frame.LayoutOrder = layoutOrder
        a152.stroke.Enabled = v159
        a152.frame.BackgroundColor3 = if v159 then colors.AccentDeep else colors.Void
        a152.frame.BackgroundTransparency = v159 and 0.4 or 0.45
        portraits.Apply(a152.img, a153, 60)
        local setTint = portraits.SetTint
        local img = a152.img
        local color3 = if alive then Color3.new(1, 1, 1) else Color3.fromRGB(110, 110, 120)
        local v167 = alive and 0 or 0.35
        setTint(img, color3, v167)
        local formattedText2 = ""

        if type(a153.tribe) == "table" and type(a153.tribe.tag) == "string" then
            formattedText2 = string.format("<font color=\"#%s\">%s</font> ", TribeEmblem.TagColor(a153.tribe.color1):ToHex(), TribeEmblem.Tag(a153.tribe.tag))
        end

        local name = a152.name
        local text = tostring((a153.name or "?"))

        if v159 then
            v157 = "  " .. a12.Loc.T("(you)")
        else
            v157 = ""
        end

        name.Text = formattedText2 .. text .. v157
        local name2 = a152.name

        if v163 then
            v158 = colors.TextMuted
        else
            v158 = if alive then colors.Text else colors.TextDim
        end

        name2.TextColor3 = v158
        local v172 = RankArt.Ranks.RankOf((tonumber(a153.trophies) or 0))
        local formattedText3 = string.format("<font color=\"#%s\">%s</font>", RankArt.Color(v172):ToHex(), RankArt.Ranks.Get(v172).name)
        local rich = a12.Loc.Rich
        local sub = a152.sub
        local formattedText = `Lv {tonumber(a153.level) or 1}  ·  `
        rich(sub, formattedText .. formattedText3 .. (v163 and "  ·  left the match"
            or alive and ""
            or "  ·  eliminated"))
        local v177 = {tonumber(a153.kills) or 0, tonumber(a153.deaths) or 0, tonumber(a153.assists) or 0, tonumber(a153.damage)
            or 0}

        for v178, cell in a152.cells do
            local v180
            cell.Text = if v178 == 4 then ui.FormatCompact(v177[v178]) else tostring(v177[v178])

            if v178 == 1 and 0 < v177[1] then
                local v181 = if a154 then colors.Ally else colors.Enemy
                v180 = v181:Lerp(colors.Text, 0.35)
            else
                v180 = if alive then colors.Text else colors.TextDim
            end

            cell.TextColor3 = v180
        end

        if 0 < v25.gear then
            local v182
            local armor

            if type(a153.loadout) ~= "table" or type(a153.loadout.items) ~= "table" then
                v182 = {}
            else
                v182 = a153.loadout.items
            end

            if type(a153.loadout) ~= "table" or type(a153.loadout.armor) ~= "string" then
                armor = nil
            else
                armor = a153.loadout.armor
            end

            local gearKey = table.concat(v182, ",") .. "|" .. tostring(armor)

            if gearKey ~= a152.gearKey then
                a152.gearKey = gearKey

                for _, child in a152.gear:GetChildren() do
                    if child:IsA("GuiObject") then
                        child:Destroy()
                    end
                end

                local values = table.clone(v182)

                if armor then
                    table.insert(values, armor)
                end

                for layoutOrder2, value in values do
                    if 6 < layoutOrder2 then
                        break
                    end

                    local parent = ui.new("Frame", {Name = "G" .. layoutOrder2, Size = UDim2.fromOffset(v25.gear, v25.gear), LayoutOrder = layoutOrder2, BackgroundColor3 = colors.Raised, BackgroundTransparency = 0.5, ZIndex = 41, (ui.Corner(8)), Parent = a152.gear})
                    local ui2 = ui.new("Frame", {Name = "Icon", ZIndex = 42, Size = UDim2.fromScale(1, 1), Parent = parent})
                    weaponIcon.Set(ui2, value, {glow = false})
                end
            end
        end
    end

    local function paint()
        --[[
          name: paint
          line: 393
          upvalues:
            state (copy, index: 1)
            teamTribe (copy, index: 2)
            parent2 (copy, index: 3)
            parent (copy, index: 4)
            colors (copy, index: 5)
            v29 (copy, index: 6)
            v41 (copy, index: 7)
            TribeEmblem (copy, index: 8)
            v28 (copy, index: 9)
            Tribes (copy, index: 10)
            mapHolder (copy, index: 11)
            parent4 (copy, index: 12)
            v44 (copy, index: 13)
            a12 (copy, index: 14)
            v45 (copy, index: 15)
            makeRow (copy, index: 16)
            paintRow (copy, index: 17)
            showBans (copy, index: 18)
        ]]
        local compare = function(left, right)
            --[[
              line: 461
            ]]
            local v196 = ((tonumber(left.kills) or 0) * 100) + (tonumber(left.damage) or 0) + (tonumber(left.assists)
                or 0) * 40
            local v197 = ((tonumber(right.kills) or 0) * 100) + (tonumber(right.damage) or 0) + (tonumber(right.assists)
                or 0) * 40

            if v196 == v197 then
                return tostring(left.name) < tostring(right.name)
            end

            return v197 < v196
        end

        local match = state.Match

        if not match or type(match.teams) ~= "table" then
            return
        end

        local v199
        local v200 = state.MyTeam()
        local v201 = {}

        if v200 ~= 1 then
            v199 = 1
        else
            v199 = 2
        end

        v201[1], v201[2] = v200, v199
        local v202 = {}
        local v203 = {}
        local v204 = {{}, {}}

        for v205, teamKey in v201 do
            local tribe, n = teamTribe(match.teams[teamKey])
            v203[v205] = tribe and {tribe = tribe, n = n} or nil
            local v209 = match.teams[teamKey] and match.teams[teamKey].members or {}

            for _, v211 in v209 do
                if type(v211.tribe) == "table" and type(v211.tribe.id) == "number" then
                    v204[v205][v211.tribe.id] = true
                end
            end
        end

        local visible = v203[1] ~= nil and v203[2] ~= nil and v203[1].tribe.id ~= v203[2].tribe.id
        parent2.Visible = visible
        parent:FindFirstChildOfClass("UIStroke").Color = if visible then Color3.fromRGB(255, 196, 80) else colors.Stroke
        parent:FindFirstChildOfClass("UIStroke").Transparency = visible and 0.45 or 0.85

        if visible then
            for index = 1, 2 do
                local tribe = v203[index].tribe
                v29[index]:Set(tribe.icon, tribe.color1, tribe.color2, tribe.tag)
                v41[index].Text = TribeEmblem.Tag(tribe.tag)
            end

            v28.Color = ColorSequence.new(Tribes.Color(v203[1].tribe.color1):Lerp(colors.Panel, 0.55), Tribes.Color(v203[2].tribe.color1):Lerp(colors.Panel, 0.55))
            local uppercaseText = string.upper((tostring(match.mapName or "this map")))
            local v216 = mapHolder(match)

            if v216 and (v216.id == v203[1].tribe.id or v216.id == v203[2].tribe.id) then
                parent4.Text = `{TribeEmblem.Tag(v216.tag)} DEFENDS {uppercaseText}`
            elseif v216 then
                parent4.Text = `{uppercaseText}  ·  HELD BY {(TribeEmblem.Tag(v216.tag))}`
            else
                parent4.Text = `GLORY DECIDES WHO HOLDS {uppercaseText}`
            end
        end

        for v217, teamKey in v201 do
            local team = match.teams[teamKey]
            local v220 = v44[v217]
            local v221 = teamKey == v200
            local v222 = if v221 then colors.Ally else colors.Enemy
            local v223 = v203[v217]
            v220.bar.BackgroundColor3 = v222
            v220.scorePill.BackgroundColor3 = v222
            local score = v220.score
            local score2 = team and team.score or 0
            score.Text = tostring(score2)
            v220.crestHolder.Visible = v223 ~= nil

            if v223 then
                local tribe = v223.tribe
                v220.crest:Set(tribe.icon, tribe.color1, tribe.color2, tribe.tag)
                v220.title.Text = string.format("<font color=\"#%s\">%s</font>  %s", TribeEmblem.TagColor(tribe.color1):ToHex(), TribeEmblem.Tag(tribe.tag), string.upper((tostring(tribe.name
                    or ""))))
                v220.title.TextColor3 = colors.Text
                local v227 = v204[3 - v217][tribe.id] == true
                v220.chip.Visible = true
                v220.chipText.Text = v227 and "SPLIT  ·  NO GLORY"
                    or string.format("×%s GLORY", (tostring(Tribes.STACK_MULT[math.clamp(v223.n, 1, 3)])))
                v220.chipText.TextColor3 = if v227 then colors.TextDim else Color3.fromRGB(255, 196, 80)
                v220.chip.BackgroundTransparency = v227 and 0.9 or 0.82
            else
                local title = v220.title
                local t = a12.Loc.T
                local stringUpper = string.upper
                local v231 = team and team.name or v221 and "Your team" or "Enemies"
                title.Text = t(stringUpper((tostring(v231))))
                v220.title.TextColor3 = v222:Lerp(colors.Text, 0.25)
                v220.chip.Visible = false
            end

            v223 = table.clone
            local v232 = team and team.members or {}
            v223 = v223(v232)
            table.sort(v223, compare)
            local v233

            for layoutOrder, v235 in v223 do
                if type(v235) == "table" then
                    if type(v235.id) ~= "string" then
                        continue
                    end

                    local v236
                    v202[v235.id] = true
                    v233 = v45[v235.id]

                    if v233 then
                        v236 = v233
                    else
                        v236 = makeRow(v235.id)
                        v45[v235.id] = v236
                    end

                    v236.frame.Parent = v220.list
                    local v237 = if v203[v217] then v203[v217].tribe else nil
                    paintRow(v236, v235, v221, layoutOrder, v237)
                end
            end
        end

        for v238, v239 in v45 do
            if not v202[v238] then
                v239.frame:Destroy()
                v45[v238] = nil
            end
        end

        showBans()
    end

    local function layout()
        --[[
          name: layout
          line: 490
          upvalues:
            ui (copy, index: 1)
            v11 (copy, index: 2)
            v10 (copy, index: 3)
            v25 (ref,  index: 4)
            v45 (copy, index: 5)
            parent (copy, index: 6)
            parent2 (copy, index: 7)
            parent3 (copy, index: 8)
            parent4 (copy, index: 9)
            placeColumns (copy, index: 10)
        ]]
        local v241 = if ui.Compact then v11 else v10

        if v241 ~= v25 then
            v25 = v241

            for v242, v243 in v45 do
                v243.frame:Destroy()
                v45[v242] = nil
            end
        end

        local v244 = ui.CanvasSize()
        parent.Size = UDim2.fromOffset(math.clamp(v244.X - 24, math.min(v25.width, 240), v25.width), 0)
        local compact = ui.Compact

        if const uiPadding = parent:FindFirstChildOfClass("UIPadding") then
            local newUDim = UDim.new
            local v248 = compact and 10 or 14
            uiPadding.PaddingTop = newUDim(0, v248)
            newUDim = UDim.new
            local v249 = compact and 10 or 16
            uiPadding.PaddingBottom = newUDim(0, v249)
        end

        if const uiListLayout = parent:FindFirstChildOfClass("UIListLayout") then
            local newUDim = UDim.new
            local v252 = compact and 6 or 10
            uiListLayout.Padding = newUDim(0, v252)
        end

        local newUDim2 = UDim2.new
        local v254 = compact and 50 or 60
        parent2.Size = newUDim2(1, 0, 0, v254)
        newUDim2 = UDim2.new
        local v255 = compact and 4 or 8
        parent3.Position = newUDim2(0.5, 0, 0, v255)
        newUDim2 = UDim2.new
        local v256 = compact and 30 or 36
        parent4.Position = newUDim2(0.5, 0, 0, v256)
        placeColumns()
    end

    local function allowed()
        --[[
          name: allowed
          line: 519
          upvalues:
            state (copy, index: 1)
            localPlayer (copy, index: 2)
            menuManager (copy, index: 3)
        ]]
        return state.SeesMatch()
            and state.Phase() ~= "MatchEnd"
            and localPlayer:GetAttribute("ReplayPlaying") ~= true
            and menuManager.Current() == nil
    end

    local cursor = false

    update = function()
        --[[
          name: update
          line: 526
          upvalues:
            v75 (ref,  index: 1)
            v73 (ref,  index: 2)
            v74 (ref,  index: 3)
            state (copy, index: 4)
            localPlayer (copy, index: 5)
            menuManager (copy, index: 6)
            parent (copy, index: 7)
            layout (copy, index: 8)
            paint (copy, index: 9)
            ui (copy, index: 10)
            askMod (copy, index: 11)
            v78 (ref,  index: 12)
            mod (ref,  index: 13)
            cursor (ref,  index: 14)
            showBans (copy, index: 15)
            ui2 (copy, index: 16)
        ]]
        local v259

        if v75 == nil then
            v259 = v73 or v74
        else
            v259 = v75
        end

        local v260 = v259
            and (v75 == true
                or state.SeesMatch()
                    and state.Phase() ~= "MatchEnd"
                    and localPlayer:GetAttribute("ReplayPlaying") ~= true
                    and menuManager.Current() == nil)
        if not v260 then
            local v261 = state.SeesMatch()
                and state.Phase() ~= "MatchEnd"
                and localPlayer:GetAttribute("ReplayPlaying") ~= true
                and menuManager.Current() == nil
            v74 = if v261 then v74 else false
        end

        if v260 and not parent.Visible then
            layout()
            paint()
            parent.Visible = true
            ui.Pop(parent, 0.97)
        elseif v260 then
            paint()
        else
            parent.Visible = false
        end

        if parent.Visible then
            askMod()
        else
            v78 = nil
        end

        local v262 = parent.Visible and mod and not v74 and not ui.Gamepad

        if v262 ~= cursor then
            cursor = v262

            if v262 then
                menuManager.PushMouse("TabListMod")
            else
                menuManager.PopMouse("TabListMod")
            end
        end

        showBans()
        ui2.ZIndex = mod and 39 or 45
        local visible = parent.Visible and v74
        ui2.Visible = visible

        if ui2.Visible then
            task.defer(
                function()
                    --[[
                      line: 563
                      upvalues:
                        ui (copy, index: 1)
                        ui2 (copy, index: 2)
                        parent (copy, index: 3)
                    ]]
                    local v264 = math.max(ui.Scale, 0.01)
                    ui2.Position = parent.Position
                    ui2.Size = UDim2.fromOffset(parent.AbsoluteSize.X / v264, parent.AbsoluteSize.Y / v264)
                end
            )
        end
    end

    child.OnInput(
        "Began",
        function(a265, a266)
            --[[
              line: 571
              upvalues:
                userInputService (copy, index: 1)
                child (copy, index: 2)
                state (copy, index: 3)
                v73 (ref,  index: 4)
                update (ref,  index: 5)
            ]]
            local v267, v268 = false, false

            if userInputService:GetFocusedTextBox() then
                return
            end

            if child.ActionOf(a265) == "Scoreboard" then
                if a266 then
                    v267 = true
                else
                    v268 = true
                end
            else
                v267 = true
            end

            if v267 and child.IsPad(a265, "Scoreboard") and state.SeesMatch() and not child.PadBlocked() then
                v268 = true
            end

            if v268 then
                v73 = true
                update()
            end
        end
    )

    child.OnInput(
        "Ended",
        function(a269)
            --[[
              line: 582
              upvalues:
                child (copy, index: 1)
                v73 (ref,  index: 2)
                update (ref,  index: 3)
            ]]
            if child.ActionOf(a269) == "Scoreboard" or child.IsPad(a269, "Scoreboard") then
                v73 = false
                update()
            end
        end
    )

    local function hookScoreboard()
        --[[
          name: hookScoreboard
          line: 589
          upvalues:
            a12 (copy, index: 1)
            ui (copy, index: 2)
            v74 (ref,  index: 3)
            update (ref,  index: 4)
        ]]
        local scoreboard = a12.Scoreboard

        if not scoreboard or scoreboard:FindFirstChild("TabListOpen") then
            return
        end

        local ui2 = ui.new("TextButton", {Name = "TabListOpen", Text = "", AutoButtonColor = false, Selectable = false, ZIndex = 30, Size = UDim2.fromScale(1, 1), Parent = scoreboard})

        ui2.Activated:Connect(
            function()
                --[[
                  line: 595
                  upvalues:
                    v74 (ref, index: 1)
                    update (ref, index: 2)
                ]]
                v74 = not v74
                update()
            end
        )
    end

    hookScoreboard()

    ui2.Activated:Connect(
        function()
            --[[
              line: 601
              upvalues:
                v74 (ref, index: 1)
                update (ref, index: 2)
            ]]
            if v74 then
                v74 = false
                update()
            end
        end
    )

    state.MatchChanged:Connect(
        function()
            --[[
              line: 608
              upvalues:
                hookScoreboard (copy, index: 1)
                parent (copy, index: 2)
                v73 (ref,  index: 3)
                v74 (ref,  index: 4)
                update (ref,  index: 5)
            ]]
            hookScoreboard()

            if parent.Visible or v73 or v74 then
                update()
            end
        end
    )

    state.PlayerStateChanged:Connect(
        function()
            --[[
              line: 614
              upvalues:
                v73 (ref, index: 1)
                v74 (ref, index: 2)
                update (ref, index: 3)
            ]]
            v73 = false
            v74 = false
            update()
        end
    )

    state.WatchChanged:Connect(
        function()
            --[[
              line: 618
              upvalues:
                v73 (ref, index: 1)
                v74 (ref, index: 2)
                update (ref, index: 3)
            ]]
            v73 = false
            v74 = false
            update()
        end
    )

    menuManager.Changed:Connect(
        function()
            --[[
              line: 622
              upvalues:
                update (ref, index: 1)
            ]]
            update()
        end
    )
    localPlayer:GetAttributeChangedSignal("ReplayPlaying"):Connect(update)

    ui.OnResize(
        function()
            --[[
              line: 626
              upvalues:
                parent (copy, index: 1)
                layout (copy, index: 2)
            ]]
            if parent.Visible then
                layout()
            end
        end
    )

    ui.LayoutChanged:Connect(
        function()
            --[[
              line: 631
              upvalues:
                parent (copy, index: 1)
                layout (copy, index: 2)
                paint (copy, index: 3)
            ]]
            if parent.Visible then
                layout()
                paint()
            end
        end
    )

    layout()

    a12.Debug.tablist = function(a273, a274, key)
        --[[
          line: 639
          upvalues:
            v75 (ref,  index: 1)
            mod (ref,  index: 2)
            timestamp (ref,  index: 3)
            v45 (copy, index: 4)
            v79 (ref,  index: 5)
            a12 (copy, index: 6)
            v78 (ref,  index: 7)
            update (ref,  index: 8)
            parent (copy, index: 9)
            cursor (ref,  index: 10)
        ]]
        if a274 ~= nil then
            if a274 == "mod" then
                mod = key == true

                if mod then
                    timestamp = -math.huge
                else
                    timestamp = os.clock()
                end
            elseif a274 == "ban" and type(key) == "string" then
                local v276 = v45[key]

                if not v79 and v276 and mod then
                    v79 = true

                    task.spawn(
                        function()
                            --[[
                              line: 189
                              upvalues:
                                a12 (copy, index: 1)
                                key (copy, index: 2)
                                v276 (copy, index: 3)
                                v79 (ref,  index: 4)
                            ]]
                            local v277, v278, v279 = a12.Remotes.Invoke("ModAction", "RowBan", key, v276.who)
                            v79 = false

                            if not v277 then
                                a12.Toast("Couldn't reach the server. Try again.", "error")
                                return
                            end

                            if v278 ~= true and type(v279) == "string" and v279 ~= "" then
                                a12.Toast(v279, "error")
                            end
                        end
                    )
                end
            elseif a274 == "hover" then
                if type(key) ~= "string" then
                    v78 = nil
                else
                    v78 = key
                end
            end
        else
            v75 = if a273 ~= nil then a273 == true and true or false else nil
        end

        update()
        local bans = {}

        for v281, v282 in v45 do
            if v282.ban then
                bans[v281] = v282.ban.Visible
            end
        end

        return {visible = parent.Visible, rows = #parent:GetDescendants(), mod = mod, bans = bans, cursor = cursor}
    end
end

return v9