local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local MatchPrefs = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("MatchPrefs"))
local v5 = {}
local textColor3 = Color3.fromRGB(142, 149, 166)

function v5.Init(a7)
    --[[
      name: Init
      line: 24
      upvalues:
        players (copy, index: 1)
        MatchPrefs (copy, index: 2)
        textColor3 (copy, index: 3)
        guiService (copy, index: 4)
    ]]
    local ui = a7.UI
    local theme = a7.Theme
    local state = a7.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local udim2FromOffset = UDim2.fromOffset
    local SettingsStore = require(script.Parent.Parent:WaitForChild("SettingsStore"))
    local localPlayer = players.LocalPlayer
    local v16 = false

    function a7.PremiumTestOn()
        --[[
          name: PremiumTestOn
          line: 32
          upvalues:
            v16 (ref, index: 1)
        ]]
        return v16
    end

    function a7.PremiumTestToggle()
        --[[
          name: PremiumTestToggle
          line: 35
          upvalues:
            v16 (ref,  index: 1)
            a7 (copy, index: 2)
        ]]
        local v17
        local v18 = not v16
        local queueAction = a7.QueueAction

        if v18 then
            v17 = "PremiumTestOn"
        else
            v17 = "PremiumTestOff"
        end

        if queueAction(v17) then
            v16 = v18
        end
    end

    local lobbyHud = a7.LobbyHud

    if not lobbyHud or not lobbyHud.PlayButton then
        return
    end

    local instance = lobbyHud.PlayButton.Instance
    local compact = ui.Compact == true
    local touch = ui.Touch == true
    local v24 = compact and 56 or 60
    local parent = ui.IconButton({Name = "MatchSettingsCog", IconName = "gear", Size = udim2FromOffset(v24, v24), Parent = lobbyHud.Root})
    ui.Corner(14).Parent = parent

    local function played()
        --[[
          name: played
          line: 59
          upvalues:
            state (copy, index: 1)
        ]]
        local stats = state.Profile and state.Profile.stats
        return type(stats) == "table" and type(stats.matches) == "number" and 1 <= stats.matches
    end

    local function placeCog()
        --[[
          name: placeCog
          line: 63
          upvalues:
            lobbyHud (copy, index: 1)
            instance (copy, index: 2)
            parent (copy, index: 3)
            udim2FromOffset (copy, index: 4)
            v24 (copy, index: 5)
            state (copy, index: 6)
        ]]
        local v29 = 1
        local v30 = lobbyHud.Root

        while v30 and not v30:IsA("ScreenGui") do
            if const uiScale = v30:FindFirstChildOfClass("UIScale") then
                v29 *= uiScale.Scale
            end

            v30 = v30.Parent
        end

        if v29 <= 0.01 then
            v29 = 1
        end

        local absolutePosition = lobbyHud.Root.AbsolutePosition
        local absolutePosition2 = instance.AbsolutePosition
        local absoluteSize = instance.AbsoluteSize
        parent.Position = udim2FromOffset((((absolutePosition2.X - absolutePosition.X) / v29) - 10) - v24, (absolutePosition2.Y - absolutePosition.Y) / v29 + (((absoluteSize.Y / v29) - v24) / 2))
        local v35 = instance.Visible
        if v35 then
            local stats = state.Profile and state.Profile.stats
            v35 = type(stats) == "table" and type(stats.matches) == "number" and 1 <= stats.matches
        end

        parent.Visible = v35
    end

    for _, v38 in {"AbsolutePosition", "AbsoluteSize", "Visible"} do
        instance:GetPropertyChangedSignal(v38):Connect(placeCog)
    end

    lobbyHud.Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeCog)
    state.ProfileChanged:Connect(placeCog)
    placeCog()
    local v39 = compact and 640 or 600
    local v40 = touch and 76 or 68
    local v41 = touch and 56 or 46
    local v42 = (math.ceil(#MatchPrefs.REGIONS / 2) * (v41 + 8)) + 30 - 8
    local v43 = 106
    local v44 = (((((v43 + 18) + 10) + v40) + 10) + v40) + 18 + 16
    local v45 = v44 + 6 + v42
    local v46 = ui.Window(
        {
            Name = "MatchSettings",
            Title = "MATCHMAKING",
            Subtitle = "How we find your matches",
            HeaderHeight = 80,
            Size = udim2FromOffset(v39, v45 + 80),
            Parent = a7.Canvas.Menus,
            OnCloseRequested = (function()
                --[[
                  name: OnCloseRequested
                  line: 114
                  upvalues:
                    a7 (copy, index: 1)
                ]]
                a7.MenuManager.Close("MatchSettings")
            end)
        }
    )
    local content = v46.Content
    ui.SelectionRing(v46.Root)

    local function click()
        --[[
          name: click
          line: 121
          upvalues:
            a7 (copy, index: 1)
        ]]
        a7.Sounds.Play("Click")
    end

    local function switchRow(name: string, a51, text: string, text2: string, callback, callback2, a56: number?)
        --[[
          name: switchRow
          line: 127
          upvalues:
            v40 (copy, index: 1)
            ui (copy, index: 2)
            udim2FromOffset (copy, index: 3)
            colors (copy, index: 4)
            content (copy, index: 5)
            fonts (copy, index: 6)
            textColor3 (copy, index: 7)
            a7 (copy, index: 8)
        ]]
        local v57
        local v58 = a56 or v40
        local textWrapped = v40 < v58
        local parent = ui.new("TextButton", {Name = name, Position = udim2FromOffset(18, a51), Size = UDim2.new(1, -36, 0, v58), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, ui.Corner(12), (ui.Stroke(colors.Stroke, 1, 0.92)), Parent = content})
        local newUi = ui.new
        local v62 = {Name = "Title", TextSize = 18}
        local v63 = textWrapped and 14 or v40 / 2 - 24
        v62.Position = udim2FromOffset(16, v63)
        v62.Size = UDim2.new(1, -110, 0, 24)
        v62.Text = text
        v62.FontFace = fonts.Heavy
        v62.TextXAlignment = Enum.TextXAlignment.Left
        v62.Parent = parent
        newUi("TextLabel", v62)
        local newUi2 = ui.new
        local v65 = "TextLabel"
        local v66 = {Name = "Desc", TextSize = 14}
        local v67 = textWrapped and 42 or v40 / 2 + 2
        v66.Position = udim2FromOffset(16, v67)
        local newUDim2 = UDim2.new
        local v69 = not textWrapped and 20 or v58 - 42 - 12
        v66.Size = newUDim2(1, -110, 0, v69)
        v66.Text = text2
        v66.FontFace = fonts.Bold
        v66.TextColor3 = textColor3
        v66.TextXAlignment = Enum.TextXAlignment.Left
        v66.TextYAlignment = if textWrapped then Enum.TextYAlignment.Top else Enum.TextYAlignment.Center
        v66.TextWrapped = textWrapped

        if textWrapped then
            v57 = Enum.TextTruncate.None
            v57 = ui
        else
            v57 = Enum.TextTruncate.AtEnd
            v57 = ui
        end

        v66.TextTruncate = v57
        v66.Parent = parent
        newUi2(v65, v66)
        local v70 = v57.Switch({Width = 60, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0.5, 0), Parent = parent})

        local function paint(a72)
            --[[
              name: paint
              line: 167
              upvalues:
                v70 (copy, index: 1)
                callback (copy, index: 2)
            ]]
            v70:Set(callback(), a72)
        end

        parent.Activated:Connect(
            function()
                --[[
                  line: 170
                  upvalues:
                    a7 (copy, index: 1)
                    callback2 (copy, index: 2)
                    callback (copy, index: 3)
                    v70 (copy, index: 4)
                ]]
                a7.Sounds.Play("Click")
                callback2(not callback())
                v70:Set(callback(), nil)
            end
        )

        v70:Set(callback(), true)

        return function()
            --[[
              line: 176
              upvalues:
                v70 (copy, index: 1)
                callback (copy, index: 2)
            ]]
            v70:Set(callback(), true)
        end, parent
    end

    local parent2 = nil
    local v74 = nil

    local function fit()
        --[[
          name: fit
          line: 183
          upvalues:
            SettingsStore (copy, index: 1)
            parent2 (ref,  index: 2)
            v46 (copy, index: 3)
            udim2FromOffset (copy, index: 4)
            v39 (copy, index: 5)
            v45 (ref,  index: 6)
            v44 (ref,  index: 7)
        ]]
        local visible = SettingsStore.Get("mmAutoRegion") < 0.5
        parent2.Visible = visible
        local holder = v46.Holder
        local v78 = if visible then v45 else v44
        holder.Size = udim2FromOffset(v39, v78 + 80)

        if v46.Refit then
            v46.Refit()
        end
    end

    local v79, v80 = switchRow(
        "NoBots",
        (v43 + 18) + 10,
        "PREVENT FULL BOT MATCHES",
        "Keep searching until another player joins. Can take longer.",
        function()
            --[[
              line: 192
              upvalues:
                SettingsStore (copy, index: 1)
            ]]
            return 0.5 < SettingsStore.Get("mmNoBots")
        end,
        function(a81: boolean)
            --[[
              line: 194
              upvalues:
                SettingsStore (copy, index: 1)
            ]]
            local set = SettingsStore.Set
            local v83 = a81 and 1 or 0
            set("mmNoBots", v83, true)
        end
    )

    local function premium()
        --[[
          name: premium
          line: 205
          upvalues:
            localPlayer (copy, index: 1)
            MatchPrefs (copy, index: 2)
        ]]
        return localPlayer:GetAttribute(MatchPrefs.PREMIUM_ATTR) == true
    end

    local v85, parent3 = switchRow(
        "Premium",
        18,
        "PREMIUM ONLY QUEUE",
        "Only match with players who bought something in Tribes. This helps prevent cheaters from showing in your games at the cost of slower queue times.",
        function()
            --[[
              line: 208
              upvalues:
                localPlayer (copy, index: 1)
                MatchPrefs (copy, index: 2)
                SettingsStore (copy, index: 3)
            ]]
            local v87 = localPlayer:GetAttribute(MatchPrefs.PREMIUM_ATTR) == true
            v87 = v87 and 0.5 < SettingsStore.Get("mmPremium")

            return v87
        end,
        function(a88: boolean)
            --[[
              line: 210
              upvalues:
                localPlayer (copy, index: 1)
                MatchPrefs (copy, index: 2)
                a7 (copy, index: 3)
                SettingsStore (copy, index: 4)
            ]]
            if localPlayer:GetAttribute(MatchPrefs.PREMIUM_ATTR) ~= true then
                a7.Toast("Unlocks with any Robux purchase in Tribes (accounts 7+ days old).", "info")
                return
            end

            local set = SettingsStore.Set
            local v90 = a88 and 1 or 0
            set("mmPremium", v90, true)
        end,
        v43
    )

    local ui2 = ui.new("ImageLabel", {Name = "Robux", BackgroundTransparency = 1, Image = "rbxasset://textures/ui/common/robux@3x.png", AnchorPoint = Vector2.new(0, 0.5), Position = udim2FromOffset(16, 26), Size = udim2FromOffset(24, 24), ImageColor3 = colors.Gold, ScaleType = Enum.ScaleType.Fit, Parent = parent3})

    if const title = parent3:FindFirstChild("Title") then
        title.Position = udim2FromOffset(48, title.Position.Y.Offset)
        title.Size = UDim2.new(1, -142, 0, title.Size.Y.Offset)
    end

    local v93 = nil

    local function paintPremiumLock()
        --[[
          name: paintPremiumLock
          line: 242
          upvalues:
            localPlayer (copy, index: 1)
            MatchPrefs (copy, index: 2)
            ui2 (copy, index: 3)
            colors (copy, index: 4)
            parent3 (copy, index: 5)
            v85 (copy, index: 6)
            v93 (ref,  index: 7)
        ]]
        local imageTransparency
        local v96 = localPlayer:GetAttribute(MatchPrefs.PREMIUM_ATTR) == true
        ui2.ImageColor3 = if v96 then colors.Gold else Color3.fromRGB(140, 140, 140)

        if v96 then
            imageTransparency = 0
            imageTransparency = parent3
        else
            imageTransparency = 0.35
            imageTransparency = parent3
        end

        ui2.ImageTransparency = imageTransparency
        local desc = imageTransparency:FindFirstChild("Desc")
        local title = imageTransparency:FindFirstChild("Title")

        if desc then
            desc.Text = v96
                and "Only match with players who bought something in Tribes. This helps prevent cheaters from showing in your games at the cost of slower queue times."
                or "Unlocks with any Robux purchase in Tribes (accounts 7+ days old). This helps prevent cheaters from showing in your games at the cost of slower queue times."
        end

        if title then
            title.TextTransparency = v96 and 0 or 0.45
        end

        imageTransparency.BackgroundTransparency = v96 and 0.3 or 0.55
        v85()

        if v93 then
            task.defer(v93)
        end
    end

    localPlayer:GetAttributeChangedSignal(MatchPrefs.PREMIUM_ATTR):Connect(paintPremiumLock)
    paintPremiumLock()

    local v99, v100 = switchRow(
        "ManualRegion",
        (((v43 + 18) + 10) + v40) + 10,
        "MANUAL REGION SELECTION",
        "Pick more regions to search in. Off: only your own, for the best ping.",
        function()
            --[[
              line: 264
              upvalues:
                SettingsStore (copy, index: 1)
            ]]
            return SettingsStore.Get("mmAutoRegion") < 0.5
        end,
        function(a101: boolean)
            --[[
              line: 266
              upvalues:
                SettingsStore (copy, index: 1)
                v74 (ref,  index: 2)
                parent2 (ref,  index: 3)
                v46 (copy, index: 4)
                udim2FromOffset (copy, index: 5)
                v39 (copy, index: 6)
                v45 (ref,  index: 7)
                v44 (ref,  index: 8)
            ]]
            local set = SettingsStore.Set
            local v103 = a101 and 0 or 1
            set("mmAutoRegion", v103, true)
            v74()
            local visible = SettingsStore.Get("mmAutoRegion") < 0.5
            parent2.Visible = visible
            local holder = v46.Holder
            local v106 = if visible then v45 else v44
            holder.Size = udim2FromOffset(v39, v106 + 80)

            if v46.Refit then
                v46.Refit()
            end
        end
    )

    parent2 = ui.new("Frame", {Name = "Regions", Position = udim2FromOffset(18, ((v44 - 18) - 16) + 6), Size = UDim2.new(1, -36, 0, v42), Parent = content})
    ui.new("TextLabel", {Name = "Hint", Text = "Also search in these regions. Yours is always included. Other regions mean higher ping.", TextSize = 14, Size = UDim2.new(1, 0, 0, 22), FontFace = fonts.Bold, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent2})
    local v107 = {}

    for v108, region in MatchPrefs.REGIONS do
        local v110
        local v111 = (v108 - 1) % 2
        local flooredValue = math.floor((v108 - 1) / 2)
        local v113 = ui.new
        local v114 = {Name = region.id}
        local newUDim2 = UDim2.new
        local v116 = v111 * 0.5

        if v111 == 1 then
            v110 = 5
        else
            v110 = 0
        end

        v114.Position = newUDim2(v116, v110, 0, (flooredValue * (v41 + 8)) + 30)
        v114.Size = UDim2.new(0.5, -5, 0, v41)
        v114.BackgroundColor3 = colors.PanelHi
        v114.BackgroundTransparency = 0.3
        v114.Text = ""
        v114.AutoButtonColor = false
        v114[1], v114[2] = ui.Corner(10), (ui.Stroke(colors.Stroke, 1, 0.92))
        v114.Parent = parent2
        v113 = v113("TextButton", v114)
        local ui3 = ui.new("Frame", {Name = "Box", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = udim2FromOffset(24, 24), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, ui.Corner(6), (ui.Stroke(colors.Stroke, 1.5, 0.6)), Parent = v113})
        local check = ui.Icon("check", 16, colors.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = ui3})
        ui.new("TextLabel", {Name = "Name", TextSize = 16, Position = udim2FromOffset(48, 0), Size = UDim2.new(1, -56, 1, 0), Text = region.name, FontFace = fonts.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v113})
        v107[v108] = {box = ui3, check = check}

        v113.Activated:Connect(
            function()
                --[[
                  line: 328
                  upvalues:
                    a7 (copy, index: 1)
                    SettingsStore (copy, index: 2)
                    MatchPrefs (copy, index: 3)
                    v108 (copy, index: 4)
                    v74 (ref,  index: 5)
                ]]
                a7.Sounds.Play("Click")
                local flooredValue = math.floor((SettingsStore.Get("mmRegions")))
                SettingsStore.Set("mmRegions", MatchPrefs.With(flooredValue, v108, not MatchPrefs.Has(flooredValue, v108)), true)
                v74()
            end
        )
    end

    v74 = function()
        --[[
          line: 335
          upvalues:
            SettingsStore (copy, index: 1)
            v107 (copy, index: 2)
            MatchPrefs (copy, index: 3)
            colors (copy, index: 4)
        ]]
        local flooredValue = math.floor((SettingsStore.Get("mmRegions")))

        for v121, v122 in v107 do
            local visible = MatchPrefs.Has(flooredValue, v121)
            v122.check.Visible = visible
            v122.box.BackgroundColor3 = if visible then colors.Accent else colors.Void
            v122.box.BackgroundTransparency = visible and 0 or 0.2
        end
    end

    local v124 = false

    v93 = function()
        --[[
          line: 348
          upvalues:
            parent3 (copy, index: 1)
            v124 (ref,  index: 2)
            v40 (copy, index: 3)
            v43 (ref,  index: 4)
            v80 (copy, index: 5)
            udim2FromOffset (copy, index: 6)
            v100 (copy, index: 7)
            v44 (ref,  index: 8)
            v45 (ref,  index: 9)
            v42 (copy, index: 10)
            parent2 (ref,  index: 11)
            SettingsStore (copy, index: 12)
            v46 (copy, index: 13)
            v39 (copy, index: 14)
        ]]
        local desc = parent3:FindFirstChild("Desc")

        if v124 or not desc or desc.AbsoluteSize.X <= 0 or desc.Size.Y.Offset <= 0 then
            return
        end

        local v126
        local v127 = desc.AbsoluteSize.Y / desc.Size.Y.Offset
        local width = desc.AbsoluteSize.X / math.max(v127, 0.01)
        v124 = true
        local v129 = 0
        v126 = v129

        for _, text in {"Only match with players who bought something in Tribes. This helps prevent cheaters from showing in your games at the cost of slower queue times.", "Unlocks with any Robux purchase in Tribes (accounts 7+ days old). This helps prevent cheaters from showing in your games at the cost of slower queue times."} do
            local success, textBoundsAsync = pcall(
                function()
                    --[[
                      line: 358
                      upvalues:
                        text (copy, index: 1)
                        desc (copy, index: 2)
                        width (copy, index: 3)
                    ]]
                    local params = Instance.new("GetTextBoundsParams")
                    params.Text = text
                    params.Font = desc.FontFace
                    params.Size = desc.TextSize
                    params.Width = width

                    return game:GetService("TextService"):GetTextBoundsAsync(params)
                end
            )

            if success then
                if typeof(textBoundsAsync) ~= "Vector2" then
                    continue
                end

                v126 = math.max(v126, textBoundsAsync.Y)
            end
        end

        v124 = false

        if v126 <= 0 then
            return
        end

        local v135 = math.max(v40, (math.ceil((v126 + 42) + 14)))

        if math.abs(v135 - v43) < 1 then
            return
        end

        v43 = v135
        parent3.Size = UDim2.new(1, -36, 0, v135)
        desc.Size = UDim2.new(1, -110, 0, (v135 - 42) - 12)
        v80.Position = udim2FromOffset(18, (v135 + 18) + 10)
        v100.Position = udim2FromOffset(18, (((v135 + 18) + 10) + v40) + 10)
        v44 = ((((((v135 + 18) + 10) + v40) + 10) + v40) + 18) + 16
        v45 = (v44 + 6) + v42
        parent2.Position = udim2FromOffset(18, ((v44 - 18) - 16) + 6)
        local visible = SettingsStore.Get("mmAutoRegion") < 0.5
        parent2.Visible = visible
        local holder = v46.Holder
        local v138 = if visible then v45 else v44
        holder.Size = udim2FromOffset(v39, v138 + 80)

        if v46.Refit then
            v46.Refit()
        end
    end

    local function paintAll()
        --[[
          name: paintAll
          line: 389
          upvalues:
            v79 (copy, index: 1)
            paintPremiumLock (copy, index: 2)
            v99 (copy, index: 3)
            v74 (ref,  index: 4)
            SettingsStore (copy, index: 5)
            parent2 (ref,  index: 6)
            v46 (copy, index: 7)
            udim2FromOffset (copy, index: 8)
            v39 (copy, index: 9)
            v45 (ref,  index: 10)
            v44 (ref,  index: 11)
            v93 (ref,  index: 12)
        ]]
        v79()
        paintPremiumLock()
        v99()
        v74()
        local visible = SettingsStore.Get("mmAutoRegion") < 0.5
        parent2.Visible = visible
        local holder = v46.Holder
        local v142 = if visible then v45 else v44
        holder.Size = udim2FromOffset(v39, v142 + 80)

        if v46.Refit then
            v46.Refit()
        end

        task.defer(v93)
    end

    SettingsStore.Changed:Connect(
        function(text: string)
            --[[
              line: 397
              upvalues:
                a7 (copy, index: 1)
                v79 (copy, index: 2)
                paintPremiumLock (copy, index: 3)
                v99 (copy, index: 4)
                v74 (ref,  index: 5)
                SettingsStore (copy, index: 6)
                parent2 (ref,  index: 7)
                v46 (copy, index: 8)
                udim2FromOffset (copy, index: 9)
                v39 (copy, index: 10)
                v45 (ref,  index: 11)
                v44 (ref,  index: 12)
                v93 (ref,  index: 13)
            ]]
            if string.sub(text, 1, 2) == "mm" and a7.MenuManager.IsOpen("MatchSettings") then
                v79()
                paintPremiumLock()
                v99()
                v74()
                local visible = SettingsStore.Get("mmAutoRegion") < 0.5
                parent2.Visible = visible
                local holder = v46.Holder
                local v146 = if visible then v45 else v44
                holder.Size = udim2FromOffset(v39, v146 + 80)

                if v46.Refit then
                    v46.Refit()
                end

                task.defer(v93)
            end
        end
    )

    a7.MenuManager.Register(
        "MatchSettings",
        {
            open = (function()
                --[[
                  name: open
                  line: 404
                  upvalues:
                    v79 (copy, index: 1)
                    paintPremiumLock (copy, index: 2)
                    v99 (copy, index: 3)
                    v74 (ref,  index: 4)
                    SettingsStore (copy, index: 5)
                    parent2 (ref,  index: 6)
                    v46 (copy, index: 7)
                    udim2FromOffset (copy, index: 8)
                    v39 (copy, index: 9)
                    v45 (ref,  index: 10)
                    v44 (ref,  index: 11)
                    v93 (ref,  index: 12)
                    ui (copy, index: 13)
                    guiService (copy, index: 14)
                    content (copy, index: 15)
                ]]
                v79()
                paintPremiumLock()
                v99()
                v74()
                local visible = SettingsStore.Get("mmAutoRegion") < 0.5
                parent2.Visible = visible
                local holder = v46.Holder
                local v149 = if visible then v45 else v44
                holder.Size = udim2FromOffset(v39, v149 + 80)

                if v46.Refit then
                    v46.Refit()
                end

                task.defer(v93)
                v46:Open()

                if ui.Gamepad then
                    guiService.SelectedObject = content:FindFirstChild("Premium")
                end
            end),
            close = (function(a150)
                --[[
                  name: close
                  line: 411
                  upvalues:
                    guiService (copy, index: 1)
                    v46 (copy, index: 2)
                ]]
                local selectedObject = guiService.SelectedObject

                if selectedObject and selectedObject:IsDescendantOf(v46.Root) then
                    guiService.SelectedObject = nil
                end

                v46:Close(a150)
            end)
        }
    )

    parent.Activated:Connect(
        function()
            --[[
              line: 419
              upvalues:
                a7 (copy, index: 1)
            ]]
            a7.Sounds.Play("Click")
            a7.MenuManager.Open("MatchSettings")
        end
    )

    state.PlayerStateChanged:Connect(
        function()
            --[[
              line: 424
              upvalues:
                state (copy, index: 1)
                a7 (copy, index: 2)
            ]]
            if state.InMatch() and a7.MenuManager.IsOpen("MatchSettings") then
                a7.MenuManager.Close("MatchSettings", true)
            end
        end
    )
end

return v5