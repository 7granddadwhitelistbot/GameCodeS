local CollectionService_upv_1 = game:GetService("CollectionService")
local Players_upv_1 = game:GetService("Players")
local tbl_1 = {}
local tbl_upv_2 = {Trophies = "TOP TROPHIES", Wins = "MOST WINS", Level = "HIGHEST LEVEL", Kills = "MOST ELIMINATIONS"}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 14
      upvalues:
        Players_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        CollectionService_upv_1 (copy, index: 3)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_1.Colors
    local Fonts_upv_1 = Theme_1.Fonts
    local u1 = Color3.fromRGB(228, 232, 240)
    local tbl_upv_3 = {Color3.fromRGB(214, 164, 60), Color3.fromRGB(160, 168, 180), Color3.fromRGB(176, 108, 62)}
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u2 = UI_upv_1.new("ScreenGui", {ResetOnSpawn = false, Name = "TR_Leaderboards", Parent = a1.PlayerGui})
    local tbl_upv_4 = {}
    local function fill(a2)
        --[[
          name: fill
          line: 150
          upvalues:
            State_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
        ]]
        local Leaderboards_1 = State_upv_1.Leaderboards
        local v1 = ((type(Leaderboards_1) == "table") and (Leaderboards_1[a2.stat])) or nil
        local v2, v2 = nil, nil
        for key_1, value_1 in a2.rows do
            local v3 = ((type(v1) == "table") and (v1[key_1])) or nil
            if type(v3) ~= "table" then
                value_1.name.Text = "\226\128\148"
                value_1.value.Text = ""
                value_1.img.Image = ""
                value_1.stroke.Enabled = false
                value_1.name.TextTransparency = 0.5
                continue
            end
            value_1.name.Text = tostring(v3.name or "?")
            value_1.value.Text = UI_upv_1.FormatCompact(tonumber(v3.value) or 0)
            local v4 = tonumber(v3.userId) or 0
            local img_1 = value_1.img
            v2 = ((not (v4 > 0)) and "") or (string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=60&h=60", v4))
            img_1.Image = v2
            local img_2 = value_1.img
            if (tonumber(v3.userId) or 0) > 0 then
                v2 = Enum.ScaleType.Crop
            else
                v2 = Enum.ScaleType.Fit
            end
            img_2.ScaleType = v2
            local stroke_1 = value_1.stroke
            if tonumber(v3.userId) == LocalPlayer_upv_1.UserId then
                v2 = true
            else
                v2 = false
            end
            stroke_1.Enabled = v2
            value_1.name.TextTransparency = 0
        end
    end
    local function build(a3)
        --[[
          name: build
          line: 27
          upvalues:
            UI_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            tbl_upv_3 (copy, index: 6)
            u1 (copy, index: 7)
        ]]
        local str_1 = tostring(a3:GetAttribute("Stat") or "Wins")
        local u3 = a3:GetAttribute("Face")
        local u4 = Enum.NormalId.Front
        if type(u3) == "string" then
            pcall(
                function()
                    --[[
                      line: 32
                      upvalues:
                        u4 (ref,  index: 1)
                        u3 (copy, index: 2)
                    ]]
                    u4 = Enum.NormalId[u3]
                end
            )
        end
        local v5 = UI_upv_1.new("SurfaceGui", {LightInfluence = 0, ResetOnSpawn = false, MaxDistance = 220, Name = "Board_" .. str_1, Adornee = a3, Face = u4, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = Vector2.new(800, 1000), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = u2})
        local v6 = a3.Size.X
        local v7 = a3.Size.Y
        if u4 == Enum.NormalId.Left or u4 == Enum.NormalId.Right then
            v6 = a3.Size.Z
        elseif u4 == Enum.NormalId.Top or u4 == Enum.NormalId.Bottom then
            v7 = a3.Size.Z
        end
        if v6 > 0 and v7 > 0 then
            v5.CanvasSize = Vector2.new(800, math.floor((800 * v7) / v6))
        end
        local v8 = math.clamp(math.floor((((v5.CanvasSize.Y * 0.94) * 0.85) * 0.18) * 0.42), 14, 72)
        v7 = UI_upv_1.new("Frame", {BackgroundTransparency = 0.05, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(14, 15, 20), Parent = v5})
        UI_upv_1.new("UIPadding", {PaddingTop = UDim.new(0.03, 0), PaddingBottom = UDim.new(0.03, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), Parent = v7})
        local new_1 = UI_upv_1.new
        local tbl_5 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, TextScaled = true}
        tbl_5.Size = UDim2.fromScale(1, 0.11)
        tbl_5.Text = tbl_upv_2[str_1] or string.upper(str_1)
        tbl_5.FontFace = Fonts_upv_1.Display
        tbl_5.TextColor3 = Color3.fromRGB(96, 172, 255)
        tbl_5.Parent = v7
        local v10 = new_1("TextLabel", tbl_5)
        UI_upv_1.TextStroke(Colors_upv_1.Void, 3, 0).Parent = v10
        UI_upv_1.new("Frame", {Position = UDim2.fromScale(0, 0.125), Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = Color3.fromRGB(40, 110, 200), Parent = v7})
        local v11 = UI_upv_1.new("Frame", {Position = UDim2.fromScale(0, 0.15), Size = UDim2.fromScale(1, 0.85), [1] = UI_upv_1.new("UIListLayout", {Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder}), Parent = v7})
        v7 = {}
        local v12 = nil
        for n_1 = 1, 5 do
            local new_2 = UI_upv_1.new
            local tbl_6 = {}
            tbl_6.Size = UDim2.fromScale(1, 0.18)
            local v13
            if n_1 % 2 ~= 1 then
                v13 = Color3.fromRGB(24, 26, 34)
            else
                v13 = Color3.fromRGB(30, 33, 42)
            end
            tbl_6.BackgroundColor3 = v13
            tbl_6.LayoutOrder = n_1
            tbl_6[1] = UI_upv_1.Corner(UDim.new(0.18, 0))
            tbl_6.Parent = v11
            local v14 = new_2("Frame", tbl_6)
            local v15 = UI_upv_1.new("UIStroke", {Enabled = false, Thickness = 4, Color = Colors_upv_1.Ally, Parent = v14})
            local new_3 = UI_upv_1.new
            local tbl_7 = {TextColor3 = 0, Parent = 0}
            tbl_7.Position = UDim2.fromScale(0.01, 0)
            tbl_7.Size = UDim2.fromScale(0.1, 1)
            tbl_7.Text = "#" .. n_1
            tbl_7.FontFace = Fonts_upv_1.Display
            tbl_7.TextSize = v8
            v12 = tbl_upv_3[n_1] or u1
            tbl_7.TextColor3 = v12
            tbl_7.Parent = v14
            tbl_6 = new_3("TextLabel", tbl_7)
            local v16 = UI_upv_1.new("ImageLabel", {Position = UDim2.fromScale(0.12, 0.08), Size = UDim2.fromScale(0.1, 0.84), BackgroundColor3 = Color3.fromRGB(44, 48, 60), ScaleType = Enum.ScaleType.Crop, [1] = UI_upv_1.Corner(UDim.new(0.2, 0)), Parent = v14})
            UI_upv_1.new("UIAspectRatioConstraint", {AspectRatio = 1, Parent = v16})
            v7[n_1] = {
                frame = v14,
                rank = tbl_6,
                img = v16,
                name = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "\226\128\148", Position = UDim2.fromScale(0.25, 0), Size = UDim2.fromScale(0.5, 1), FontFace = Fonts_upv_1.Heavy, TextSize = v8, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v14}),
                value = UI_upv_1.new("TextLabel", {Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(0.98, 0), Size = UDim2.fromScale(0.22, 1), FontFace = Fonts_upv_1.Display, TextSize = v8, TextColor3 = Color3.fromRGB(96, 172, 255), TextXAlignment = Enum.TextXAlignment.Right, Parent = v14}),
                stroke = v15
            }
        end
        local tbl_8 = {}
        tbl_8.sg = v5
        tbl_8.part = a3
        tbl_8.rows = v7
        tbl_8.stat = str_1
        return tbl_8
    end
    local function remove(a4)
        --[[
          name: remove
          line: 182
          upvalues:
            tbl_upv_4 (copy, index: 1)
        ]]
        local v17 = tbl_upv_4[a4]
        if not v17 then
            return
        end
        tbl_upv_4[a4] = nil
        v17.sg:Destroy()
    end
    for _, value_2 in CollectionService_upv_1:GetTagged("LeaderboardBoard") do
        local v18 = value_2:IsA("BasePart")
        if not (v18) then
            continue
        end
        if not (tbl_upv_4[value_2]) then
            local v19 = build(value_2)
            tbl_upv_4[value_2] = v19
            fill(v19)
        end
    end
    local function add(a5)
        --[[
          name: add
          line: 174
          upvalues:
            tbl_upv_4 (copy, index: 1)
            build (copy, index: 2)
            fill (copy, index: 3)
        ]]
        if not a5:IsA("BasePart") or (tbl_upv_4[a5]) then
            return
        end
        local v20 = build(a5)
        tbl_upv_4[a5] = v20
        fill(v20)
    end
    CollectionService_upv_1:GetInstanceAddedSignal("LeaderboardBoard"):Connect(add)
    CollectionService_upv_1:GetInstanceRemovedSignal("LeaderboardBoard"):Connect(remove)
    State_upv_1.LeaderboardsChanged:Connect(
        function()
            --[[
              line: 194
              upvalues:
                tbl_upv_4 (copy, index: 1)
                fill (copy, index: 2)
            ]]
            for _, value_3 in tbl_upv_4 do
                fill(value_3)
            end
        end
    )
end
return tbl_1