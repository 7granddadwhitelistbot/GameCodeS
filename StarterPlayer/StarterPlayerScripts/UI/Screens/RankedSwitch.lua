local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 10
    ]]
    local UI_upv_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_1.Colors
    local Fonts_1 = Theme_1.Fonts
    local fromOffset_upv_1 = UDim2.fromOffset
    local SettingsStore_upv_1 = require(script.Parent.Parent:WaitForChild("SettingsStore"))
    local LobbyHud_upv_1 = a1.LobbyHud
    if not LobbyHud_upv_1 or not LobbyHud_upv_1.PlayButton then
        return
    end
    local Instance_upv_1 = LobbyHud_upv_1.PlayButton.Instance
    local u1 = UI_upv_1.new("TextButton", {Name = "RankedSwitch", Size = fromOffset_upv_1(300, 50), AutoButtonColor = false, Text = "", BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.18, Visible = false, [1] = UI_upv_1.Corner(14), Parent = LobbyHud_upv_1.Root})
    local u2 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.86)
    u2.Parent = u1
    local u3 = require(script.Parent.Parent:WaitForChild("RankArt")).Trophy(26, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Parent = u1})
    local u4 = UI_upv_1.new("TextLabel", {Text = "RANKED", Name = "Title", TextSize = 18, Position = fromOffset_upv_1(48, 7), Size = UDim2.new(1, -128, 0, 20), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = u1})
    local u5 = UI_upv_1.new("TextLabel", {Text = "", Name = "Desc", TextSize = 13, Position = fromOffset_upv_1(48, 27), Size = UDim2.new(1, -128, 0, 16), FontFace = Fonts_1.SemiBold, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u1})
    local u6 = UI_upv_1.Switch({Width = 56, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Parent = u1})
    local function ranked()
        --[[
          name: ranked
          line: 64
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
        ]]
        local v1 = SettingsStore_upv_1.Get("mmRanked") > 0.5
        return v1
    end
    local function paint(a2)
        --[[
          name: paint
          line: 67
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
            u4 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u5 (copy, index: 4)
            u2 (copy, index: 5)
            u3 (copy, index: 6)
            u6 (copy, index: 7)
        ]]
        local v2 = SettingsStore_upv_1.Get("mmRanked") > 0.5
        local v3
        if v2 then
            v3 = "RANKED"
        else
            v3 = "UNRANKED"
        end
        u4.Text = v3
        local v4
        if v2 then
            v4 = Colors_upv_1.Text
        else
            v4 = Colors_upv_1.TextDim
        end
        u4.TextColor3 = v4
        u5.Text = (v2 and "Win or lose trophies") or "No trophies at stake"
        local v5
        if v2 then
            v5 = Colors_upv_1.Accent
        else
            v5 = Colors_upv_1.Stroke
        end
        u2.Color = v5
        u2.Transparency = (v2 and 0.55) or 0.86
        local tbl_2 = {u3, unpack(u3:GetDescendants())}
        for _, value_1 in tbl_2 do
            if value_1:IsA("ImageLabel") then
                value_1.ImageTransparency = (v2 and 0) or 0.6
                continue
            end
            if value_1:IsA("TextLabel") then
                value_1.TextTransparency = (v2 and 0) or 0.6
            end
        end
        u6:Set(v2, a2)
    end
    u1.Activated:Connect(
        function()
            --[[
              line: 83
              upvalues:
                a1 (copy, index: 1)
                SettingsStore_upv_1 (copy, index: 2)
                paint (copy, index: 3)
                UI_upv_1 (copy, index: 4)
                u1 (copy, index: 5)
            ]]
            a1.Sounds.Play("Click")
            local Set_1 = SettingsStore_upv_1.Set
            local v6 = "mmRanked"
            local v7 = SettingsStore_upv_1.Get("mmRanked") > 0.5
            local v8
            if v7 then
                v8 = 0
            else
                v8 = 1
            end
            Set_1(v6, v8, "now")
            paint()
            UI_upv_1.Pop(u1, 0.96)
        end
    )
    SettingsStore_upv_1.Changed:Connect(
        function(a3)
            --[[
              line: 89
              upvalues:
                paint (copy, index: 1)
            ]]
            if a3 ~= "mmRanked" then
                return
            end
            paint()
        end
    )
    paint(true)
    local function played()
        --[[
          name: played
          line: 96
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v9 = State_upv_1.Profile and (State_upv_1.Profile.stats)
        local v10 = false
        if type(v9) == "table" then
            v10 = (type(v9.matches) == "number") and (v9.matches >= 1)
        end
        return v10
    end
    local function place()
        --[[
          name: place
          line: 100
          upvalues:
            LobbyHud_upv_1 (copy, index: 1)
            Instance_upv_1 (copy, index: 2)
            u1 (copy, index: 3)
            fromOffset_upv_1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            State_upv_1 (copy, index: 6)
        ]]
        local v11 = 1
        local v12 = LobbyHud_upv_1.Root
        while v12 and not v12:IsA("ScreenGui") do
            local v13 = v12:FindFirstChildOfClass("UIScale")
            v11 = (v13 and (v11 * v13.Scale)) or v11
            v12 = v12.Parent
        end
        v11 = ((v11 <= 0.01) and 1) or v11
        v12 = LobbyHud_upv_1.Root.AbsolutePosition
        local AbsolutePosition_1 = Instance_upv_1.AbsolutePosition
        local AbsoluteSize_1 = Instance_upv_1.AbsoluteSize
        local Offset_1 = Instance_upv_1.Size.X.Offset
        local Offset_2 = Instance_upv_1.Size.Y.Offset
        local v14 = ((AbsolutePosition_1.X + (AbsoluteSize_1.X / 2)) - v12.X) / v11 - Offset_1 / 2
        local v15 = ((AbsolutePosition_1.Y + (AbsoluteSize_1.Y / 2)) - v12.Y) / v11 - Offset_2 / 2
        u1.Size = fromOffset_upv_1(Offset_1, 50)
        local v16
        if UI_upv_1.Compact ~= true then
            v16 = fromOffset_upv_1(v14, (v15 - 12) - 50)
        else
            v16 = fromOffset_upv_1(v14, (v15 + Offset_2) + 26)
        end
        u1.Position = v16
        local Visible_1 = Instance_upv_1.Visible
        local v17
        if Visible_1 then
            local v18 = State_upv_1.Profile and (State_upv_1.Profile.stats)
            v17 = false
            if type(v18) == "table" then
                v17 = (type(v18.matches) == "number") and (v18.matches >= 1)
            end
        else
            v17 = Visible_1
        end
        u1.Visible = v17
    end
    for _, value_2 in {"AbsolutePosition", "AbsoluteSize", "Visible"} do
        Instance_upv_1:GetPropertyChangedSignal(value_2):Connect(place)
    end
    LobbyHud_upv_1.Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(place)
    UI_upv_1.LayoutChanged:Connect(place)
    State_upv_1.ProfileChanged:Connect(place)
    place()
end
return tbl_1