local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local v3 = {}
local v4 = {Wins = "MOST WINS", Kills = "MOST ELIMINATIONS", Level = "HIGHEST LEVEL", Trophies = "TOP TROPHIES"}

function v3.Init(a5)
    --[[
      name: Init
      line: 14
      upvalues:
        players (copy, index: 1)
        v4 (copy, index: 2)
        collectionService (copy, index: 3)
    ]]
    local ui = a5.UI
    local theme = a5.Theme
    local state = a5.State
    local _ = a5.Portraits
    local colors = theme.Colors
    local fonts = theme.Fonts
    local textColor3 = Color3.fromRGB(228, 232, 240)
    local v13 = {Color3.fromRGB(214, 164, 60), Color3.fromRGB(160, 168, 180), Color3.fromRGB(176, 108, 62)}
    local localPlayer = players.LocalPlayer
    local parent = ui.new("ScreenGui", {Name = "TR_Leaderboards", ResetOnSpawn = false, Parent = a5.PlayerGui})
    local v16 = {}

    local function build(instance: Instance)
        --[[
          name: build
          line: 27
          upvalues:
            ui (copy, index: 1)
            parent (copy, index: 2)
            v4 (copy, index: 3)
            fonts (copy, index: 4)
            colors (copy, index: 5)
            v13 (copy, index: 6)
            textColor3 (copy, index: 7)
        ]]
        local text = tostring((instance:GetAttribute("Stat") or "Wins"))
        local face = instance:GetAttribute("Face")
        local v21 = Enum.NormalId.Front

        if type(face) == "string" then
            pcall(
                function()
                    --[[
                      line: 32
                      upvalues:
                        v21 (ref,  index: 1)
                        face (copy, index: 2)
                    ]]
                    v21 = Enum.NormalId[face]
                end
            )
        end

        local v22, v23 = false, false
        local ui2 = ui.new("SurfaceGui", {LightInfluence = 0, MaxDistance = 220, ResetOnSpawn = false, Name = "Board_" .. text, Adornee = instance, Face = v21, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = Vector2.new(800, 1000), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = parent})
        local v25 = instance.Size.X
        local v26 = instance.Size.Y
        local left = Enum.NormalId.Left

        if v21 == left then
            v23 = true
        else
            local right = Enum.NormalId.Right

            if v21 ~= right then
                local top = Enum.NormalId.Top

                if v21 == top then
                    v22 = true
                else
                    local bottom = Enum.NormalId.Bottom

                    if v21 == bottom then
                        v22 = true
                    end
                end
            else
                v23 = true
            end
        end

        if v22 then
            v26 = instance.Size.Z
        end

        if v23 then
            v25 = instance.Size.Z
        end

        if 0 < v25 and 0 < v26 then
            ui2.CanvasSize = Vector2.new(800, (math.floor((800 * v26) / v25)))
        end

        local textSize = math.clamp(math.floor((((ui2.CanvasSize.Y * 0.94) * 0.85) * 0.18) * 0.42), 14, 72)
        local parent2 = ui.new("Frame", {BackgroundTransparency = 0.05, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(14, 15, 20), Parent = ui2})
        ui.new("UIPadding", {PaddingTop = UDim.new(0.03, 0), PaddingBottom = UDim.new(0.03, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), Parent = parent2})
        local newUi = ui.new
        local v34 = {TextScaled = true, Size = UDim2.fromScale(1, 0.11)}
        local text2 = v4[text] or string.upper(text)
        v34.Text = text2
        v34.FontFace = fonts.Display
        v34.TextColor3 = Color3.fromRGB(96, 172, 255)
        v34.Parent = parent2
        local parent3 = newUi("TextLabel", v34)
        ui.TextStroke(colors.Void, 3, 0).Parent = parent3
        ui.new("Frame", {Position = UDim2.fromScale(0, 0.125), Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = Color3.fromRGB(40, 110, 200), Parent = parent2})
        local newUi2 = ui.new
        local newUi3 = ui.new
        local v39 = {Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder}
        local parent4 = newUi2("Frame", {Position = UDim2.fromScale(0, 0.15), Size = UDim2.fromScale(1, 0.85), (newUi3("UIListLayout", v39)), Parent = parent2})
        local rows = {}

        for layoutOrder = 1, 5 do
            local textColor32
            local newUi4 = ui.new
            local v45 = {Size = UDim2.fromScale(1, 0.18), BackgroundColor3 = if layoutOrder % 2 == 1 then Color3.fromRGB(30, 33, 42) else Color3.fromRGB(24, 26, 34)}
            v45.LayoutOrder = layoutOrder
            v45[1] = (ui.Corner(UDim.new(0.18, 0)))
            v45.Parent = parent4
            local ui3 = newUi4("Frame", v45)
            local stroke = ui.new("UIStroke", {Thickness = 4, Enabled = false, Color = colors.Ally, Parent = ui3})
            local newUi5 = ui.new
            local v49 = {Position = UDim2.fromScale(0.01, 0), Size = UDim2.fromScale(0.1, 1), Text = "#" .. layoutOrder, FontFace = fonts.Display, TextSize = textSize}
            textColor32 = if const color3 = v13[layoutOrder] then color3 else textColor3
            v49.TextColor3 = textColor32
            v49.Parent = ui3
            local rank = newUi5("TextLabel", v49)
            local ui4 = ui.new("ImageLabel", {Position = UDim2.fromScale(0.12, 0.08), Size = UDim2.fromScale(0.1, 0.84), BackgroundColor3 = Color3.fromRGB(44, 48, 60), ScaleType = Enum.ScaleType.Crop, (ui.Corner(UDim.new(0.2, 0))), Parent = ui3})
            ui.new("UIAspectRatioConstraint", {AspectRatio = 1, Parent = ui4})
            rows[layoutOrder] = {
                frame = ui3,
                rank = rank,
                img = ui4,
                name = ui.new("TextLabel", {AutoLocalize = false, Text = "—", Position = UDim2.fromScale(0.25, 0), Size = UDim2.fromScale(0.5, 1), FontFace = fonts.Heavy, TextSize = textSize, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui3}),
                value = ui.new("TextLabel", {Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(0.98, 0), Size = UDim2.fromScale(0.22, 1), FontFace = fonts.Display, TextSize = textSize, TextColor3 = Color3.fromRGB(96, 172, 255), TextXAlignment = Enum.TextXAlignment.Right, Parent = ui3}),
                stroke = stroke
            }
        end

        return {sg = ui2, part = instance, rows = rows, stat = text}
    end

    local function fill(a54)
        --[[
          name: fill
          line: 150
          upvalues:
            state (copy, index: 1)
            ui (copy, index: 2)
            localPlayer (copy, index: 3)
        ]]
        local leaderboards = state.Leaderboards
        local leaderboard = type(leaderboards) == "table" and leaderboards[a54.stat] or nil
        local _

        for v58, row in a54.rows do
            local v60 = type(leaderboard) == "table" and leaderboard[v58] or nil

            if type(v60) == "table" then
                local image
                local scaleType
                row.name.Text = tostring((v60.name or "?"))
                row.value.Text = ui.FormatCompact((tonumber(v60.value) or 0))
                local number = tonumber(v60.userId) or 0
                local img = row.img

                if not (0 < number) then
                    image = ""
                else
                    image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=60&h=60", number)
                end

                img.Image = image
                local img2 = row.img

                if not (0 < (tonumber(v60.userId) or 0)) then
                    scaleType = Enum.ScaleType.Fit
                else
                    scaleType = Enum.ScaleType.Crop
                end

                img2.ScaleType = scaleType
                local stroke = row.stroke
                local number2 = tonumber(v60.userId)
                stroke.Enabled = number2 == localPlayer.UserId
                row.name.TextTransparency = 0
            else
                row.name.Text = "—"
                row.value.Text = ""
                row.img.Image = ""
                row.stroke.Enabled = false
                row.name.TextTransparency = 0.5
            end
        end
    end

    for _, leaderboardBoard in collectionService:GetTagged("LeaderboardBoard") do
        if leaderboardBoard:IsA("BasePart") and not v16[leaderboardBoard] then
            local v70 = build(leaderboardBoard)
            v16[leaderboardBoard] = v70
            fill(v70)
        end
    end

    collectionService:GetInstanceAddedSignal("LeaderboardBoard"):Connect(
        function(leaderboardBoard: Instance)
            --[[
              name: add
              line: 174
              upvalues:
                v16 (copy, index: 1)
                build (copy, index: 2)
                fill (copy, index: 3)
            ]]
            if not leaderboardBoard:IsA("BasePart") or v16[leaderboardBoard] then
                return
            end

            local v72 = build(leaderboardBoard)
            v16[leaderboardBoard] = v72
            fill(v72)
        end
    )

    collectionService:GetInstanceRemovedSignal("LeaderboardBoard"):Connect(
        function(leaderboardBoard: Instance)
            --[[
              name: remove
              line: 182
              upvalues:
                v16 (copy, index: 1)
            ]]
            if const v74 = v16[leaderboardBoard] then
                v16[leaderboardBoard] = nil
                v74.sg:Destroy()
            end
        end
    )

    state.LeaderboardsChanged:Connect(
        function()
            --[[
              line: 194
              upvalues:
                v16 (copy, index: 1)
                fill (copy, index: 2)
            ]]
            for _, v76 in v16 do
                fill(v76)
            end
        end
    )
end

return v3