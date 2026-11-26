local collectionService = game:GetService("CollectionService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local Tribes = require(shared:WaitForChild("Tribes"))
local TribeArt = require(shared:WaitForChild("TribeArt"))
local v7 = {}
local color3 = Color3.fromRGB(176, 162, 134)
local textColor3 = Color3.fromRGB(228, 232, 240)
local textColor32 = Color3.fromRGB(142, 149, 166)
local textColor33 = Color3.fromRGB(255, 186, 46)
local v12 = {textColor33, Color3.fromRGB(196, 206, 222), Color3.fromRGB(222, 140, 74)}
local backgroundColor3 = Color3.fromRGB(14, 15, 20)

function v7.Init(a14)
    --[[
      name: Init
      line: 29
      upvalues:
        Tribes (copy, index: 1)
        color3 (copy, index: 2)
        collectionService (copy, index: 3)
        workspace (copy, index: 4)
        TribeArt (copy, index: 5)
        backgroundColor3 (copy, index: 6)
        textColor33 (copy, index: 7)
        textColor32 (copy, index: 8)
        v12 (copy, index: 9)
        textColor3 (copy, index: 10)
    ]]
    local ui = a14.UI
    local theme = a14.Theme
    local fonts = theme.Fonts
    local tribes = a14.Tribes
    local TribeEmblem = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem.Init(ui)
    local v20 = {}
    local v21 = {}
    local v22 = {}

    local function paintBanner(tribeBanner: Instance)
        --[[
          name: paintBanner
          line: 40
          upvalues:
            v20 (ref,  index: 1)
            v22 (copy, index: 2)
            Tribes (copy, index: 3)
            color3 (copy, index: 4)
            TribeEmblem (copy, index: 5)
            ui (copy, index: 6)
            fonts (copy, index: 7)
        ]]
        local v25
        local rank = tribeBanner:GetAttribute("Rank")

        if type(rank) ~= "number" then
            v25 = nil
        else
            v25 = v20[rank]
        end

        local v27 = not v25 and "-"
            or string.format("%s:%s:%s:%s", tostring(v25.id), tostring(v25.icon), tostring(v25.color1), (tostring(v25.color2)))

        if v22[tribeBanner] == v27 then
            return
        end

        v22[tribeBanner] = v27
        local color = if v25 then Tribes.Color(v25.color1):Lerp(Color3.new(0, 0, 0), 0.12) else color3
        tribeBanner.Color = color

        if const firstAncestorOfClass = tribeBanner:FindFirstAncestorOfClass("Model") then
            for _, descendant in firstAncestorOfClass:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:GetAttribute("BannerTail") == rank then
                    descendant.Color = color
                end
            end
        end

        local placeholder = tribeBanner:FindFirstChild("Placeholder")

        if placeholder and placeholder:IsA("SurfaceGui") then
            placeholder.Enabled = v25 == nil
        end

        local emblem = tribeBanner:FindFirstChild("Emblem")
        if not emblem then
            return
        end

        for _, child in emblem:GetChildren() do
            child:Destroy()
        end

        if not v25 then
            return
        end

        local newTribeEmblem = TribeEmblem.new
        local v37 = {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 22), Parent = emblem}
        newTribeEmblem(116, v37):Set(v25.icon, v25.color2, v25.color1, v25.tag)
        local parent = ui.new("TextLabel", {Name = "Tag", AutoLocalize = false, TextScaled = true, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 160), Size = UDim2.new(1, -16, 0, 40), Text = "[" .. tostring(v25.tag) .. "]", FontFace = fonts.Display, TextColor3 = Tribes.Color(v25.color2), Parent = emblem})
        ui.TextStroke(Color3.new(0, 0, 0), 1.5, 0.6).Parent = parent
    end

    local function paintAll()
        --[[
          name: paintAll
          line: 90
          upvalues:
            collectionService (copy, index: 1)
            paintBanner (copy, index: 2)
        ]]
        for _, tribeBanner in collectionService:GetTagged("TribeBanner") do
            if tribeBanner:IsA("BasePart") then
                paintBanner(tribeBanner)
            end
        end
    end

    local function paintMap()
        --[[
          name: paintMap
          line: 98
          upvalues:
            workspace (copy, index: 1)
            TribeArt (copy, index: 2)
            ui (copy, index: 3)
        ]]
        local instance = workspace:FindFirstChild("TribeHall")
        instance = instance and instance:FindFirstChild("MapCloth", true)
        local map = instance and instance:FindFirstChild("Map")

        if not map or TribeArt.Map.image == "" or map:FindFirstChild("Base") then
            return
        end

        local title = map:FindFirstChild("Title")

        if title and title:IsA("GuiObject") then
            title.Visible = false
        end

        ui.new("ImageLabel", {Name = "Base", Image = TribeArt.Map.image, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, Parent = map})
    end

    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local parent = ui.new("ScreenGui", {Name = "TR_TribeBoards", ResetOnSpawn = false, Parent = a14.PlayerGui})
    local v49 = {}
    local v50 = "top"

    local function buildBoard(adornee: Instance)
        --[[
          name: buildBoard
          line: 121
          upvalues:
            ui (copy, index: 1)
            parent (copy, index: 2)
            backgroundColor3 (copy, index: 3)
            fonts (copy, index: 4)
            textColor33 (copy, index: 5)
            theme (copy, index: 6)
            textColor32 (copy, index: 7)
            v12 (copy, index: 8)
            textColor3 (copy, index: 9)
        ]]
        local y = math.floor(800 * adornee.Size.Y / math.max(adornee.Size.X, 0.1))
        local ui2 = ui.new("SurfaceGui", {Name = "TopTribes", LightInfluence = 0, MaxDistance = 220, ResetOnSpawn = false, Adornee = adornee, Face = Enum.NormalId.Front, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = Vector2.new(800, y), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = parent})
        local parent2 = ui.new("Frame", {BackgroundTransparency = 0.05, Size = UDim2.fromScale(1, 1), BackgroundColor3 = backgroundColor3, Parent = ui2})
        ui.new("UIPadding", {PaddingTop = UDim.new(0.03, 0), PaddingBottom = UDim.new(0.03, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), Parent = parent2})
        local parent3 = ui.new("TextLabel", {Text = "TOP TRIBES", TextScaled = true, Size = UDim2.fromScale(1, 0.1), FontFace = fonts.Display, TextColor3 = textColor33, Parent = parent2})
        ui.TextStroke(theme.Colors.Void, 3, 0).Parent = parent3
        local caption = ui.new("TextLabel", {Text = "", TextScaled = true, Position = UDim2.fromScale(0, 0.105), Size = UDim2.fromScale(1, 0.045), FontFace = fonts.Heavy, TextColor3 = textColor32, Parent = parent2})
        ui.new("Frame", {Position = UDim2.fromScale(0, 0.162), Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = Color3.fromRGB(176, 120, 22), Parent = parent2})
        local newUi = ui.new
        local newUi2 = ui.new
        local v60 = {Padding = UDim.new(0.022, 0), SortOrder = Enum.SortOrder.LayoutOrder}
        local parent4 = newUi("Frame", {Position = UDim2.fromScale(0, 0.185), Size = UDim2.fromScale(1, 0.815), (newUi2("UIListLayout", v60)), Parent = parent2})
        local v62 = (y * 0.94) * 0.815 * 0.18
        local clampedValue = math.clamp(math.floor(v62 * 0.36), 14, 60)
        local rows = {}

        for layoutOrder = 1, 5 do
            local textColor34
            local newUi3 = ui.new
            local v68 = {Name = "Row" .. layoutOrder, Size = UDim2.fromScale(1, 0.18), BackgroundColor3 = if layoutOrder % 2 == 1 then Color3.fromRGB(30, 33, 42) else Color3.fromRGB(24, 26, 34)}
            v68.LayoutOrder = layoutOrder
            v68[1] = (ui.Corner(UDim.new(0.18, 0)))
            v68.Parent = parent4
            local ui3 = newUi3("Frame", v68)
            local stroke = ui.new("UIStroke", {Thickness = 4, Enabled = false, Color = theme.Colors.Ally, Parent = ui3})
            local flooredValue = math.floor(v62 * 0.8)
            local newUi4 = ui.new
            local v73 = {Position = UDim2.fromScale(0.005, 0), Size = UDim2.fromScale(0.09, 1), Text = "#" .. layoutOrder, FontFace = fonts.Display, TextSize = clampedValue}
            textColor34 = if const color3 = v12[layoutOrder] then color3 else textColor3
            v73.TextColor3 = textColor34
            v73.Parent = ui3
            local rank = newUi4("TextLabel", v73)
            local crest = ui.new("Frame", {Name = "Crest", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0.095, 0.5), Size = UDim2.fromOffset(flooredValue, flooredValue), Parent = ui3})
            local newUi5 = ui.new
            local newUi6 = ui.new
            local v79 = {MaxTextSize = clampedValue, MinTextSize = math.floor(clampedValue * 0.55)}
            rows[layoutOrder] = {
                frame = ui3,
                rank = rank,
                crest = crest,
                name = newUi5("TextLabel", {AutoLocalize = false, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0.095, flooredValue + 14, 0.5, 0), Size = UDim2.new(0.705, -(flooredValue + 14), 0.5, 0), Text = "-", RichText = true, FontFace = fonts.Heavy, TextScaled = true, TextWrapped = false, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, (newUi6("UITextSizeConstraint", v79)), Parent = ui3}),
                value = ui.new("TextLabel", {Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(0.975, 0), Size = UDim2.fromScale(0.175, 1), FontFace = fonts.Display, TextSize = clampedValue, TextColor3 = textColor33, TextXAlignment = Enum.TextXAlignment.Right, Parent = ui3}),
                stroke = stroke
            }
        end

        return {sg = ui2, rows = rows, caption = caption, emblems = {}, emblemSize = math.floor(v62 * 0.74)}
    end

    local function fillBoard(a81)
        --[[
          name: fillBoard
          line: 195
          upvalues:
            v50 (ref,  index: 1)
            v21 (ref,  index: 2)
            v20 (ref,  index: 3)
            localPlayer (copy, index: 4)
            Tribes (copy, index: 5)
            TribeEmblem (copy, index: 6)
            textColor3 (copy, index: 7)
            ui (copy, index: 8)
            textColor32 (copy, index: 9)
        ]]
        local v82 = if v50 == "alltime" then v21 else v20
        local tribeId = localPlayer:GetAttribute("TribeId")

        if v50 ~= "alltime" then
            local formattedText
            local v85 = math.max(0, Tribes.WeekEndsAt(Tribes.WeekOf(os.time())) - os.time())

            if not (86400 <= v85) then
                formattedText = `{v85 // 3600}H {(v85 % 3600) // 60}M`
            else
                formattedText = `{v85 // 86400}D {(v85 % 86400) // 3600}H`
            end

            a81.caption.Text = `THIS WEEK  ·  RESETS IN {formattedText}`
        else
            a81.caption.Text = "ALL TIME  ·  GLORY"
        end

        for emblemKey, row in a81.rows do
            local v88 = v82[emblemKey]
            local emblem = a81.emblems[emblemKey]

            if v88 then
                local v90
                local v91

                if emblem then
                    v90 = emblem
                else
                    v90 = TribeEmblem.new(a81.emblemSize, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = row.crest})
                    a81.emblems[emblemKey] = v90
                end

                v90:Set(v88.icon, v88.color1, v88.color2, v88.tag)
                row.crest.Visible = true
                row.name.Text = string.format("<font color=\"#%s\">%s</font> %s", TribeEmblem.TagColor(v88.color1):ToHex(), TribeEmblem.Tag(v88.tag), (tostring(v88.name
                    or "")))
                row.name.TextColor3 = textColor3
                local value = row.value
                local formatNumber = ui.FormatNumber

                if v50 == "alltime" then
                    v91 = v88.renown
                else
                    v91 = v88.weekRenown
                end

                value.Text = formatNumber((tonumber(v91) or 0))
                local stroke = row.stroke
                local enabled = type(tribeId) == "number" and 0 < tribeId and v88.id == tribeId
                stroke.Enabled = enabled
            else
                row.crest.Visible = false
                row.name.Text = "-"
                row.name.TextColor3 = textColor32
                row.value.Text = ""
                row.stroke.Enabled = false
            end
        end
    end

    for _, tribeLeaderboard in collectionService:GetTagged("TribeLeaderboard") do
        if tribeLeaderboard:IsA("BasePart") and not v49[tribeLeaderboard] then
            local v98 = buildBoard(tribeLeaderboard)
            v49[tribeLeaderboard] = v98
            fillBoard(v98)
        end
    end

    collectionService:GetInstanceAddedSignal("TribeLeaderboard"):Connect(
        function(tribeLeaderboard: Instance)
            --[[
              name: addBoard
              line: 235
              upvalues:
                v49 (copy, index: 1)
                buildBoard (copy, index: 2)
                fillBoard (copy, index: 3)
            ]]
            if tribeLeaderboard:IsA("BasePart") and not v49[tribeLeaderboard] then
                local v100 = buildBoard(tribeLeaderboard)
                v49[tribeLeaderboard] = v100
                fillBoard(v100)
            end
        end
    )

    collectionService:GetInstanceRemovedSignal("TribeLeaderboard"):Connect(
        function(tribeLeaderboard: Instance)
            --[[
              line: 246
              upvalues:
                v49 (copy, index: 1)
            ]]
            if const v102 = v49[tribeLeaderboard] then
                v49[tribeLeaderboard] = nil
                v102.sg:Destroy()
            end
        end
    )

    localPlayer:GetAttributeChangedSignal("TribeId"):Connect(
        function()
            --[[
              name: fillAll
              line: 229
              upvalues:
                v49 (copy, index: 1)
                fillBoard (copy, index: 2)
            ]]
            for _, v104 in v49 do
                fillBoard(v104)
            end
        end
    )

    local function fadeText(textTransparency: number, a107: number)
        --[[
          name: fadeText
          line: 255
          upvalues:
            v49 (copy, index: 1)
            ui (copy, index: 2)
        ]]
        local tweenInfo = TweenInfo.new(a107, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

        for _, v110 in v49 do
            ui.Tween(v110.caption, tweenInfo, {TextTransparency = textTransparency})

            for _, row in v110.rows do
                ui.Tween(row.name, tweenInfo, {TextTransparency = textTransparency})
                ui.Tween(row.value, tweenInfo, {TextTransparency = textTransparency})
            end
        end
    end

    task.spawn(
        function()
            --[[
              line: 267
              upvalues:
                v50 (ref,  index: 1)
                v21 (ref,  index: 2)
                v20 (ref,  index: 3)
                v49 (copy, index: 4)
                fadeText (copy, index: 5)
                fillBoard (copy, index: 6)
            ]]
            while true do
                local v113
                task.wait(8)

                if v50 == "top" then
                    if not (0 < #v21) then
                        if not (0 < #v20) then
                            v113 = "alltime"
                        else
                            v113 = "top"
                        end
                    else
                        v113 = "alltime"
                    end
                elseif not (0 < #v20) then
                    v113 = "alltime"
                else
                    v113 = "top"
                end

                if v113 ~= v50 and next(v49) then
                    fadeText(1, 0.18)
                    task.wait(0.2)
                    v50 = v113

                    for _, v115 in v49 do
                        fillBoard(v115)
                    end

                    fadeText(0, 0.3)
                    continue
                end

                if v113 ~= v50 then
                    v50 = v113
                end
            end
        end
    )

    collectionService:GetInstanceAddedSignal("TribeBanner"):Connect(
        function(tribeBanner: Instance)
            --[[
              line: 285
              upvalues:
                v22 (copy, index: 1)
                paintBanner (copy, index: 2)
                paintMap (copy, index: 3)
            ]]
            if tribeBanner:IsA("BasePart") then
                v22[tribeBanner] = nil
                paintBanner(tribeBanner)
                paintMap()
            end
        end
    )

    collectionService:GetInstanceRemovedSignal("TribeBanner"):Connect(
        function(tribeBanner: Instance)
            --[[
              line: 292
              upvalues:
                v22 (copy, index: 1)
            ]]
            v22[tribeBanner] = nil
        end
    )

    task.spawn(
        function()
            --[[
              line: 296
              upvalues:
                workspace (copy, index: 1)
                a14 (copy, index: 2)
                tribes (copy, index: 3)
                v20 (ref,  index: 4)
                paintAll (copy, index: 5)
                v21 (ref,  index: 6)
                v50 (ref,  index: 7)
                v49 (copy, index: 8)
                fillBoard (copy, index: 9)
                paintMap (copy, index: 10)
            ]]
            while true do
                if workspace:FindFirstChild("TribeHall") then
                    if not a14.State.InMatch() then
                        local v118, v119 = tribes.Board("top")
                        if v118 then
                            if type(v119) == "table" then
                                v20 = {}

                                for _, v121 in v119 do
                                    if type(v121) == "table" then
                                        if 0 < (tonumber(v121.weekRenown) or 0) and #v20 < 5 then
                                            table.insert(v20, v121)
                                        end
                                    end
                                end

                                paintAll()
                            end
                        end

                        local v122, v123 = tribes.Board("alltime")
                        if v122 then
                            if type(v123) == "table" then
                                v21 = {}

                                for _, v125 in v123 do
                                    if type(v125) == "table" then
                                        if 0 < (tonumber(v125.renown) or 0) and #v21 < 5 then
                                            table.insert(v21, v125)
                                        end
                                    end
                                end
                            end
                        end

                        if v50 == "top" then
                            if #v20 == 0 then
                                v50 = "alltime"
                            end

                            for _, v127 in v49 do
                                fillBoard(v127)
                            end

                            paintMap()
                        else
                            for _, v127 in v49 do
                                fillBoard(v127)
                            end

                            paintMap()
                        end
                    end
                end

                task.wait(120)
            end
        end
    )
end

return v7