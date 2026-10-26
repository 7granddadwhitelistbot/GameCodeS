local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local TweenService_upv_1 = game:GetService("TweenService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Signal_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Keybinds"))
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 36
      upvalues:
        Players_upv_1 (copy, index: 1)
        Signal_upv_1 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
        GuiService_upv_1 (copy, index: 4)
        Keybinds_upv_1 (copy, index: 5)
        UserInputService_upv_1 (copy, index: 6)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_1 = Theme_upv_1.Fonts
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local u1 = UI_upv_1.new("Frame", {Name = "LobbyHud", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local u2 = UI_upv_1.Panel({Name = "PlayerChip", BackgroundTransparency = 0.22, Size = UDim2.fromOffset(340, 78), Trim = Colors_upv_1.Accent, Parent = u1})
    local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
    local Ranks_upv_1 = RankArt_upv_1.Ranks
    local function trophiesNow()
        --[[
          name: trophiesNow
          line: 64
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v1 = tonumber(State_upv_1.Get("Trophies")) or (((State_upv_1.Profile) and (tonumber(State_upv_1.Profile.trophies))) or 0)
        return v1
    end
    local Emblem_upv_1 = RankArt_upv_1.Emblem
    local RankOf_1 = Ranks_upv_1.RankOf
    local v2 = tonumber(State_upv_1.Get("Trophies")) or (((State_upv_1.Profile) and (tonumber(State_upv_1.Profile.trophies))) or 0)
    Emblem_upv_1 = Emblem_upv_1(RankOf_1(v2), 64, {ZIndex = 3, Name = "RankEmblem", Parent = u2})
    local u3 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Name = "PlayerName", ZIndex = 3, TextSize = 22, Text = LocalPlayer_1.DisplayName, FontFace = Fonts_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u2})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = u3
    local u4 = UI_upv_1.new("Frame", {Name = "StreakSlot", ZIndex = 3, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Parent = u2})
    local u5 = UI_upv_1.new("Frame", {Name = "RankRow", AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, ZIndex = 3, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u2})
    local u6 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Text = "", Name = "RankName", TextSize = 16, ZIndex = 3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_1.Heavy, Parent = u5})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = u6
    local _ = RankArt_upv_1.Trophy(16, {LayoutOrder = 2, ZIndex = 3, Parent = u5})
    local u7 = UI_upv_1.new("TextLabel", {LayoutOrder = 3, Text = "0", Name = "Trophies", TextSize = 17, ZIndex = 3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Text, Parent = u5})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = u7
    local u8 = UI_upv_1.new("Frame", {Name = "LevelPill", AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Colors_upv_1.Inset, BackgroundTransparency = 0.15, ClipsDescendants = true, ZIndex = 3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u2})
    UI_upv_1.Stroke(Colors_upv_1.Xp, 1, 0.55).Parent = u8
    local v3 = UI_upv_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u8})
    local u9 = UI_upv_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Xp, 0.2), Colors_upv_1.Xp, 0)
    u9.Parent = v3
    local u10 = Instance.new("NumberValue")
    local function paintLevelFill()
        --[[
          name: paintLevelFill
          line: 149
          upvalues:
            u10 (copy, index: 1)
            u9 (copy, index: 2)
        ]]
        local v4 = math.clamp(u10.Value, 0, 1)
        local v5
        if v4 <= 0.002 then
            v5 = NumberSequence.new(1)
        elseif v4 >= 0.998 then
            v5 = NumberSequence.new(0)
        else
            v5 = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(v4, 0), NumberSequenceKeypoint.new(math.min(v4 + 0.002, 1), 1), NumberSequenceKeypoint.new(1, 1)})
        end
        u9.Transparency = v5
    end
    u10.Changed:Connect(paintLevelFill)
    paintLevelFill()
    local u11 = UI_upv_1.new("TextLabel", {ZIndex = 4, Name = "Level", Text = "LV 1", TextSize = 15, Size = UDim2.fromScale(1, 1), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Text, Parent = u8})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = u11
    local u12 = UI_upv_1.Bar({Name = "RankBar", Color = Colors_upv_1.Accent, Parent = u2})
    u12.Frame.ZIndex = 3
    u12.Fill.ZIndex = 3
    local TextService_upv_1 = game:GetService("TextService")
    local tbl_upv_2 = {name = 16, trophies = 17}
    local u13 = 0
    local u14 = 0
    local function fitRow()
        --[[
          name: fitRow
          line: 194
          upvalues:
            u14 (ref, index: 1)
        ]]
        u14 = u14 + 1
        local _ = u14
        task.spawn(function() end)
    end
    local function streakShown()
        --[[
          name: streakShown
          line: 180
          upvalues:
            u4 (copy, index: 1)
        ]]
        for _, value_1 in u4:GetChildren() do
            if not (value_1:IsA("GuiObject")) or not (value_1.Visible) then
                continue
            end
            return true
        end
        return false
    end
    local function layoutChip(a2)
        --[[
          name: layoutChip
          line: 218
          upvalues:
            Emblem_upv_1 (copy, index: 1)
            u3 (copy, index: 2)
            u5 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            streakShown (copy, index: 5)
            u4 (copy, index: 6)
            u8 (copy, index: 7)
            u11 (copy, index: 8)
            u13 (ref,  index: 9)
            u14 (ref,  index: 10)
            u12 (copy, index: 15)
        ]]
        local v6 = 78
        local v7 = 64
        local v8 = 7
        local v9 = 80
        local v10 = 12
        local v11 = 66
        local v12 = 27
        local v13 = 6
        if a2 then
            local _ = 72
            v7 = 56
            v8 = 6
            local v17 = 69
            local v18 = 10
            local v19 = 58
            v12 = 25
            local v20 = 5
        end
        Emblem_upv_1.Size = UDim2.fromOffset(v7, v7)
        Emblem_upv_1.AnchorPoint = Vector2.new(0, 0.5)
        Emblem_upv_1.Position = UDim2.new(0, v8, 0.5, 0)
        u3.TextSize = (a2 and 20) or 22
        u3.Position = UDim2.fromOffset(v9, 7)
        u5.Position = UDim2.fromOffset(v9, 35)
        u5.Size = UDim2.fromOffset(0, 20)
        tbl_upv_2.name = (a2 and 15) or 16
        tbl_upv_2.trophies = (a2 and 16) or 17
        local v14 = streakShown()
        u4.Visible = v14
        u4.Size = UDim2.fromOffset(v11, v12)
        u8.Size = UDim2.fromOffset(v11, v12)
        u11.TextSize = (a2 and 14) or 15
        if v14 then
            local v15 = math.floor(((v6 - (v12 * 2)) - v13) / 2)
            u4.Position = UDim2.new(1, -v10, 0, v15)
            u8.Position = UDim2.new(1, -v10, 0, (v15 + v12) + v13)
        else
            u8.Position = UDim2.new(1, -v10, 0, math.floor((v6 - v12) / 2))
        end
        local v16 = v10 + v11 + 12
        u13 = v9 + v16
        u14 = u14 + 1
        v12 = u14
        task.spawn(function() end)
        u3.Size = UDim2.new(1, -v9 - v16, 0, 26)
        u12.Frame.Position = UDim2.fromOffset(v9, 61)
        u12.Frame.Size = UDim2.new(1, -v9 - v16, 0, 9)
    end
    local u15 = false
    local function watchStreak(a3)
        --[[
          name: watchStreak
          line: 259
          upvalues:
            layoutChip (copy, index: 1)
            u15 (ref,  index: 2)
        ]]
        if not a3:IsA("GuiObject") then
            return
        end
        a3:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 261
                  upvalues:
                    layoutChip (copy, index: 1)
                    u15 (ref,  index: 2)
                ]]
                layoutChip(u15)
            end
        )
        layoutChip(u15)
    end
    u4.ChildAdded:Connect(watchStreak)
    for v183, value_2 in u4:GetChildren() do
        watchStreak(value_2)
    end
    local v17 = UI_upv_1.new("TextButton", {AutoButtonColor = false, Name = "OpenCard", ZIndex = 6, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = u2})
    local u16 = u2:FindFirstChildOfClass("UIStroke")
    local u17 = ((not u16) and 0.9) or (u16.Transparency)
    local u18
    if u16 then
        u18 = u16.Color
    else
        u18 = Colors_upv_1.Stroke
    end
    local u19 = false
    local function paintHover(a4)
        --[[
          name: paintHover
          line: 287
          upvalues:
            u16 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            u19 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            u18 (copy, index: 6)
            u17 (copy, index: 7)
            u2 (copy, index: 8)
        ]]
        if u16 then
            local Tween_1 = UI_upv_1.Tween
            local Fast_1 = Theme_upv_1.Tween.Fast
            local tbl_3 = {Color = 0, Transparency = 0}
            local v18
            if u19 or a4 then
                v18 = Colors_upv_1.Accent
            else
                v18 = u18
            end
            tbl_3.Color = v18
            if a4 then
                v18 = 0.1
            elseif u19 then
                v18 = 0.35
            else
                v18 = u17
            end
            tbl_3.Transparency = v18
            Tween_1(u16, Fast_1, tbl_3)
        end
        local Tween_2 = UI_upv_1.Tween
        local Fast_2 = Theme_upv_1.Tween.Fast
        local tbl_4 = {BackgroundTransparency = 0}
        tbl_4.BackgroundTransparency = (a4 and 0.3) or ((u19 and 0.12) or 0.22)
        Tween_2(u2, Fast_2, tbl_4)
    end
    v17.MouseEnter:Connect(
        function()
            --[[
              line: 296
              upvalues:
                u19 (ref,  index: 1)
                UI_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                paintHover (copy, index: 4)
            ]]
            u19 = true
            if not (UI_upv_1.Touch) then
                a1.Sounds.Play("Hover")
            end
            paintHover()
        end
    )
    v17.MouseLeave:Connect(
        function()
            --[[
              line: 303
              upvalues:
                u19 (ref,  index: 1)
                paintHover (copy, index: 2)
            ]]
            u19 = false
            paintHover()
        end
    )
    v17.MouseButton1Down:Connect(
        function()
            --[[
              line: 307
              upvalues:
                paintHover (copy, index: 1)
            ]]
            paintHover(true)
        end
    )
    v17.MouseButton1Up:Connect(
        function()
            --[[
              line: 310
              upvalues:
                paintHover (copy, index: 1)
            ]]
            paintHover()
        end
    )
    v17.Activated:Connect(
        function()
            --[[
              line: 313
              upvalues:
                u19 (ref,  index: 1)
                paintHover (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            u19 = false
            paintHover()
            a1.Sounds.Play("Click")
            a1.MenuManager.Toggle("Ranks")
        end
    )
    local u20 = -1
    local u21 = -1
    local function refreshRank()
        --[[
          name: refreshRank
          line: 325
          upvalues:
            State_upv_1 (copy, index: 1)
            u20 (ref,  index: 2)
            Ranks_upv_1 (copy, index: 3)
            RankArt_upv_1 (copy, index: 4)
            Emblem_upv_1 (copy, index: 5)
            u6 (copy, index: 6)
            u7 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u14 (ref,  index: 9)
            TextService_upv_1 (copy, index: 10)
            u2 (copy, index: 11)
            u13 (ref,  index: 12)
            tbl_upv_2 (copy, index: 13)
            u12 (copy, index: 14)
            Theme_upv_1 (copy, index: 15)
            u21 (ref,  index: 16)
        ]]
        local v19 = tonumber(State_upv_1.Get("Trophies")) or (((State_upv_1.Profile) and (tonumber(State_upv_1.Profile.trophies))) or 0)
        local v20 = math.max(0, math.floor(v19))
        if v20 == u20 then
            return
        end
        local v21, v22
        v21, v22, v19 = Ranks_upv_1.Progress(v20)
        local v23 = RankArt_upv_1.Color(v21)
        RankArt_upv_1.SetEmblem(Emblem_upv_1, v21)
        u6.Text = string.upper(Ranks_upv_1.Get(v21).name)
        u6.TextColor3 = v23
        u7.Text = UI_upv_1.FormatNumber(v20)
        u14 = u14 + 1
        local u22 = u14
        task.spawn(
            function()
                --[[
                  line: 197
                  upvalues:
                    TextService_upv_1 (copy, index: 1)
                    u2 (copy, index: 2)
                    u13 (ref,  index: 3)
                    tbl_upv_2 (copy, index: 4)
                    u6 (copy, index: 5)
                    u7 (copy, index: 6)
                    u22 (copy, index: 7)
                    u14 (ref,  index: 8)
                ]]
                local function width_1(a5, a6)
                    --[[
                      name: width
                      line: 198
                      upvalues:
                        TextService_upv_1 (copy, index: 1)
                    ]]
                    local v24 = Instance.new("GetTextBoundsParams")
                    v24.Text = a5.Text
                    v24.Font = a5.FontFace
                    v24.Size = a6
                    v24.Width = 1000
                    local success_1, v25 = pcall(TextService_upv_1.GetTextBoundsAsync, TextService_upv_1, v24)
                    if success_1 then
                        return v25.X
                    end
                    return 0
                end
                local v26 = u2.Size.X.Offset - u13
                local name_1 = tbl_upv_2.name
                local trophies_1 = tbl_upv_2.trophies
                while true do
                    local v27, v28, v29
                    if not (name_1 > 11) then
                        break
                    end
                    local v30 = Instance.new("GetTextBoundsParams")
                    v30.Text = u6.Text
                    v30.Font = u6.FontFace
                    v30.Size = name_1
                    v30.Width = 1000
                    local success_2, v31 = pcall(TextService_upv_1.GetTextBoundsAsync, TextService_upv_1, v30)
                    v27 = ((not success_2) and 0) or (v31.X)
                    local v32 = Instance.new("GetTextBoundsParams")
                    v32.Text = u7.Text
                    v32.Font = u7.FontFace
                    v32.Size = trophies_1
                    v32.Width = 1000
                    v28, v29 = pcall(TextService_upv_1.GetTextBoundsAsync, TextService_upv_1, v32)
                    if v26 < ((v27 + (((not v28) and 0) or (v29.X))) + 16) + 12 then
                        name_1, trophies_1 = name_1 - 1, trophies_1 - 1
                        continue
                    else
                        break
                    end
                end
                if u22 ~= u14 then
                    return
                end
                u6.TextSize = name_1
                u7.TextSize = trophies_1
            end
        )
        local v33 = u12.Fill:FindFirstChildOfClass("UIGradient")
        if v33 then
            v33.Color = ColorSequence.new(Theme_upv_1.Lighten(v23, 0.2), v23)
        end
        local Set_1 = u12.Set
        local v34
        if (v19) and (v19 > 0) then
            v34 = v22 / v19
        else
            v34 = 1
        end
        Set_1(v34, u20 < 0)
        if u20 >= 0 then
            if u21 < v21 then
                UI_upv_1.Pop(Emblem_upv_1, 1.4)
            else
                UI_upv_1.Bump(u7, 0.12)
            end
        end
        u20 = v20
        u21 = v21
    end
    refreshRank()
    State_upv_1.AttrChanged:Connect(
        function(a7)
            --[[
              line: 352
              upvalues:
                refreshRank (copy, index: 1)
            ]]
            if a7 ~= "Trophies" then
                return
            end
            refreshRank()
        end
    )
    State_upv_1.ProfileChanged:Connect(refreshRank)
    local u23 = UI_upv_1.Panel({Name = "ShellsPill", BackgroundTransparency = 0.22, AnchorPoint = Vector2.new(1, 0), Size = UDim2.fromOffset(0, 48), AutomaticSize = Enum.AutomaticSize.X, Radius = Theme_upv_1.Radius.Pill, Parent = u1})
    UI_upv_1.Padding(0, 18, 0, 10).Parent = u23
    local u24, v35 = UI_upv_1.ShellAmount(State_upv_1.Shells(), {TextSize = 28, Parent = u23})
    u24.AnchorPoint = Vector2.new(0, 0.5)
    u24.Position = UDim2.fromScale(0, 0.5)
    local u25 = UI_upv_1.CountUp(v35)
    u25(State_upv_1.Shells(), true)
    u23.Visible = Theme_upv_1.ShowCurrency
    local u26 = State_upv_1.Shells()
    local u27 = UI_upv_1.Button({Radius = 16, Text = "PLAY", Name = "Play", Style = "Primary", TextSize = 46, Size = UDim2.fromOffset(300, 96), AnchorPoint = Vector2.new(1, 1), Icon = UI_upv_1.Image(UI_upv_1.Assets.Icons.CrossedArrows, {Size = UDim2.fromOffset(36, 34), ImageColor3 = Colors_upv_1.Text}), Parent = u1})
    local u28 = UI_upv_1.new("TextLabel", {Text = "3V3  \194\183  BEST OF 5", Name = "Sub", TextSize = 15, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 2), Size = UDim2.new(1, 0, 0, 18), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u27.Instance})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = u28
    local u29 = 2
    pcall(
        function()
            --[[
              line: 405
              upvalues:
                u29 (ref, index: 1)
            ]]
            local v36 = tonumber(require(game:GetService("ReplicatedStorage").Shared.Config).FIRST_MATCH_ROUNDS_TO_WIN) or u29
            u29 = v36
        end
    )
    local u30 = UI_upv_1.new("Frame", {ZIndex = 4, Name = "Pad", Size = UDim2.fromScale(1, 1), Parent = u27.Face})
    UI_upv_1.PadActionCap("Play", {Height = 28, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = u30})
    local function refreshPlaySub()
        --[[
          name: refreshPlaySub
          line: 418
          upvalues:
            State_upv_1 (copy, index: 1)
            u29 (ref,  index: 2)
            u28 (copy, index: 3)
        ]]
        local v37 = State_upv_1.Profile
        local v38 = State_upv_1.HasProfile and ((type(v37) == "table") and ((type(v37.stats) == "table") and (v37.stats.matches == 0)))
        if v38 then
            v37 = u29
        else
            v37 = State_upv_1.DEFAULT_ROUNDS_TO_WIN
        end
        local v39 = State_upv_1.Get("Duel") == true
        local v40
        if v39 then
            v40 = "3V3  \194\183  1V1"
        else
            v40 = string.format("3V3  \194\183  BEST OF %d", (v37 * 2) - 1)
        end
        u28.Text = v40
    end
    refreshPlaySub()
    State_upv_1.ProfileChanged:Connect(refreshPlaySub)
    State_upv_1.AttrChanged:Connect(
        function(a8)
            --[[
              line: 426
              upvalues:
                refreshPlaySub (copy, index: 1)
            ]]
            if a8 ~= "Duel" then
                return
            end
            refreshPlaySub()
        end
    )
    local Button_upv_1 = UI_upv_1.Button
    local tbl_5 = {Parent = 0, Text = "LOADOUT", Gap = 6, Name = "Loadout", OnClick = 0, Icon = 0, Style = "Dark", TextSize = 26}
    tbl_5.Size = UDim2.fromOffset(200, 66)
    tbl_5.Icon = UI_upv_1.Image(UI_upv_1.Assets.Icons.LoadoutSword or (UI_upv_1.Assets.Icons.Sword), {Name = "Icon", Size = UDim2.fromOffset(40, 40), ScaleType = Enum.ScaleType.Fit})
    tbl_5.Parent = u1
    function tbl_5.OnClick()
        --[[
          name: OnClick
          line: 442
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Toggle("Loadout")
    end
    Button_upv_1 = Button_upv_1(tbl_5)
    UI_upv_1.PadCap(Enum.KeyCode.DPadLeft, {Height = 24, ZIndex = 4, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = Button_upv_1.Face})
    local Label_upv_1 = Button_upv_1.Label
    Label_upv_1.RichText = true
    Label_upv_1.LineHeight = 0.92
    Label_upv_1.AutoLocalize = false
    local Loc_upv_1 = a1.Loc
    local function refreshLoadoutLabel()
        --[[
          name: refreshLoadoutLabel
          line: 454
          upvalues:
            State_upv_1 (copy, index: 1)
            Loc_upv_1 (copy, index: 2)
            Label_upv_1 (copy, index: 3)
        ]]
        if State_upv_1.HasLoadoutSlots() and State_upv_1.LoadoutSlotCount() > 1 then
            local v41 = string.gsub(string.gsub(string.gsub(Loc_upv_1.T(string.upper(State_upv_1.LoadoutName(State_upv_1.ActiveLoadout()))), "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
            Label_upv_1.Text = string.format("%s\n<font size=\"14\" color=\"#BAC0CE\">%s</font>", Loc_upv_1.T("LOADOUT"), v41)
        else
            Label_upv_1.Text = Loc_upv_1.T("LOADOUT")
        end
    end
    refreshLoadoutLabel()
    State_upv_1.ProfileChanged:Connect(refreshLoadoutLabel)
    Loc_upv_1.Changed:Connect(refreshLoadoutLabel)
    local GuiService_upv_2 = game:GetService("GuiService")
    local u31 = Instance.new("ScreenGui")
    u31.Name = "TR_TopbarSettings"
    u31.ResetOnSpawn = false
    u31.IgnoreGuiInset = true
    u31.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    u31.DisplayOrder = 8
    u31.Parent = a1.PlayerGui
    local u32 = Instance.new("TextButton")
    u32.Name = "Settings"
    u32.Text = ""
    u32.AutoButtonColor = false
    u32.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    u32.BackgroundTransparency = 0.08
    u32.Size = UDim2.fromOffset(44, 44)
    u32.Parent = u31
    UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = u32
    local u33 = UI_upv_1.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u32})
    local u34 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "gear", Name = "Icon", TextSize = 24, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(24, 24), FontFace = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular), TextColor3 = Color3.fromRGB(247, 247, 248), Parent = u32})
    task.delay(
        3,
        function()
            --[[
              line: 518
              upvalues:
                u34 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
                u32 (copy, index: 3)
            ]]
            local X_1 = u34.TextBounds.X
            if not (X_1 < 1) and not (X_1 > 32) then
                return
            end
            u34.Visible = false
            UI_upv_1.Icon("gear", 24, Color3.fromRGB(247, 247, 248), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), HoleColor = Color3.fromRGB(18, 18, 21), Parent = u32})
        end
    )
    UI_upv_1.KeyCap("M", {Transparency = 0.05, Height = 17, TextSize = 11, ZIndex = 3, Gamepad = Enum.KeyCode.ButtonSelect, Color = Color3.fromRGB(18, 18, 21), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 5, 1, 1), Parent = u32})
    local u35 = Instance.new("TextButton")
    u35.Name = "News"
    u35.Text = ""
    u35.AutoButtonColor = false
    u35.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    u35.BackgroundTransparency = 0.08
    u35.Size = UDim2.fromOffset(44, 44)
    u35.Parent = u31
    UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = u35
    local u36 = UI_upv_1.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u35})
    UI_upv_1.Glyph("megaphone", 24, Color3.fromRGB(247, 247, 248), {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u35})
    local u37 = false
    local u38 = false
    local u39 = Instance.new("TextButton")
    u39.Name = "CustomHost"
    u39.Text = ""
    u39.AutoButtonColor = false
    u39.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    u39.BackgroundTransparency = 0.08
    u39.Size = UDim2.fromOffset(44, 44)
    u39.Visible = false
    u39.Parent = u31
    UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = u39
    local u40 = UI_upv_1.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u39})
    local v184 = UI_upv_1.Glyph("crown", 24, Color3.fromRGB(247, 247, 248), {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u39})
    UI_upv_1.ActionCap("CustomMenu", {Transparency = 0.05, Height = 17, TextSize = 11, ZIndex = 3, Gamepad = Enum.KeyCode.DPadDown, Color = Color3.fromRGB(18, 18, 21), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 5, 1, 1), Parent = u39})
    local u41 = Signal_upv_1.new()
    local u42 = false
    local u43 = false
    local u44 = false
    local u45 = false
    local tbl_upv_6 = {}
    local UserInputService_upv_2 = game:GetService("UserInputService")
    local function paint()
        --[[
          name: paint
          line: 593
          upvalues:
            UserInputService_upv_2 (copy, index: 1)
            u42 (ref,  index: 2)
            u43 (ref,  index: 3)
            u44 (ref,  index: 4)
            u45 (ref,  index: 5)
            u37 (ref,  index: 6)
            u38 (ref,  index: 7)
            a1 (copy, index: 8)
            u33 (copy, index: 9)
            u40 (copy, index: 10)
            u36 (copy, index: 11)
        ]]
        if UserInputService_upv_2.MouseBehavior ~= Enum.MouseBehavior.Default then
            u42 = false
            u43 = false
            u44 = false
            u45 = false
            u37 = false
            u38 = false
        end
        local v42 = a1.MenuManager.IsOpen("Settings")
        local v43
        if u43 then
            v43 = 0.8
        elseif u42 or v42 then
            v43 = 0.9
        else
            v43 = 1
        end
        u33.BackgroundTransparency = v43
        local v44 = a1.MenuManager.IsOpen("CustomHost")
        if u45 then
            v43 = 0.8
        elseif u44 or v44 then
            v43 = 0.9
        else
            v43 = 1
        end
        u40.BackgroundTransparency = v43
        v43 = (u38 and 0.8) or ((u37 and 0.9) or 1)
        u36.BackgroundTransparency = v43
    end
    UserInputService_upv_2:GetPropertyChangedSignal("MouseBehavior"):Connect(paint)
    local function place()
        --[[
          name: place
          line: 607
          upvalues:
            GuiService_upv_2 (copy, index: 1)
            u32 (copy, index: 2)
            u35 (copy, index: 3)
            u39 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
        ]]
        local TopbarInset_1 = GuiService_upv_2.TopbarInset
        local Height_1 = TopbarInset_1.Height
        local v45 = math.clamp(Height_1 - 14, 28, 44)
        u32.Size = UDim2.fromOffset(v45, v45)
        u32.Position = UDim2.fromOffset(TopbarInset_1.Min.X + 8, math.max(0, (Height_1 - 2) - v45))
        local v46 = (TopbarInset_1.Min.X + 8) + v45 + 12
        u35.Size = UDim2.fromOffset(v45, v45)
        u35.Position = UDim2.fromOffset(v46, math.max(0, (Height_1 - 2) - v45))
        local v47 = ((u35.Visible) and (v46 + (v45 + 12))) or v46
        u39.Size = UDim2.fromOffset(v45, v45)
        u39.Position = UDim2.fromOffset(v47, math.max(0, (Height_1 - 2) - v45))
        local v48 = ((u35.Visible) and (v45 + 12)) or 0
        local v49 = v45 + 8 + v48 + (((u39.Visible) and (v45 + 12)) or 0)
        if UI_upv_1.TopbarReserved == v49 then
            return
        end
        UI_upv_1.TopbarReserved = v49
        UI_upv_1.TopInsetChanged:Fire()
    end
    place()
    GuiService_upv_2:GetPropertyChangedSignal("TopbarInset"):Connect(place)
    local u46 = UI_upv_1.new("TextLabel", {Name = "Text", TextSize = 14, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_1.SemiBold, TextColor3 = Color3.fromRGB(247, 247, 248)})
    local tbl_7 = {}
    tbl_7.Name = "Tooltip"
    tbl_7.AnchorPoint = Vector2.new(0.5, 0)
    tbl_7.AutomaticSize = Enum.AutomaticSize.X
    tbl_7.Size = UDim2.fromOffset(0, 30)
    tbl_7.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    tbl_7.BackgroundTransparency = 0.08
    tbl_7.Visible = false
    tbl_7.ZIndex = 10
    tbl_7[1], tbl_7[2], tbl_7[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.new("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}), u46
    tbl_7.Parent = u31
    local u47 = UI_upv_1.new("Frame", tbl_7)
    u46.ZIndex = 11
    local tbl_upv_8 = {}
    local u48 = nil
    local u49 = false
    local u50 = 0
    local function hideTip(a9)
        --[[
          name: hideTip
          line: 663
          upvalues:
            u48 (ref,  index: 1)
            u50 (ref,  index: 2)
            u49 (ref,  index: 3)
            u47 (copy, index: 4)
        ]]
        if a9 and u48 ~= a9 then
            return
        end
        u50 = u50 + 1
        u48 = nil
        u49 = false
        u47.Visible = false
    end
    local function showTip(a10, a11, a12)
        --[[
          name: showTip
          line: 671
          upvalues:
            u50 (ref, index: 1)
            u48 (ref, index: 2)
            u49 (ref, index: 3)
        ]]
        u50 = u50 + 1
        local _ = u50
        local v50 = a12 == true
        u48 = a10
        u49 = v50
        task.delay(a11, function() end)
    end
    local function tooltip(a13, a14)
        --[[
          name: tooltip
          line: 690
          upvalues:
            tbl_upv_8 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            UserInputService_upv_2 (copy, index: 3)
            u50 (ref,  index: 4)
            u48 (ref,  index: 5)
            u49 (ref,  index: 6)
            u47 (copy, index: 9)
        ]]
        tbl_upv_8[a13] = a14
        a13.MouseEnter:Connect(
            function()
                --[[
                  line: 692
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    UserInputService_upv_2 (copy, index: 2)
                    a13 (copy, index: 3)
                    u50 (ref,  index: 4)
                    u48 (ref,  index: 5)
                    u49 (ref,  index: 6)
                ]]
                if (UI_upv_1.Touch) or UserInputService_upv_2.MouseBehavior ~= Enum.MouseBehavior.Default then
                    return
                end
                local v51 = a13
                u50 = u50 + 1
                local _ = u50
                u48 = v51
                u49 = false
                task.delay(0.3, function() end)
            end
        )
        a13.MouseLeave:Connect(
            function()
                --[[
                  line: 698
                  upvalues:
                    a13 (copy, index: 1)
                    u48 (ref,  index: 2)
                    u50 (ref,  index: 3)
                    u49 (ref,  index: 4)
                    u47 (copy, index: 5)
                ]]
                if a13 and u48 ~= a13 then
                    return
                end
                u50 = u50 + 1
                u48 = nil
                u49 = false
                u47.Visible = false
            end
        )
        a13.MouseButton1Down:Connect(
            function()
                --[[
                  line: 701
                  upvalues:
                    u50 (ref,  index: 1)
                    u48 (ref,  index: 2)
                    u49 (ref,  index: 3)
                    u47 (copy, index: 4)
                ]]
                u50 = u50 + 1
                u48 = nil
                u49 = false
                u47.Visible = false
            end
        )
        a13.Activated:Connect(
            function()
                --[[
                  line: 704
                  upvalues:
                    u50 (ref,  index: 1)
                    u48 (ref,  index: 2)
                    u49 (ref,  index: 3)
                    u47 (copy, index: 4)
                ]]
                u50 = u50 + 1
                u48 = nil
                u49 = false
                u47.Visible = false
            end
        )
        a13:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 707
                  upvalues:
                    a13 (copy, index: 1)
                    u48 (ref,  index: 2)
                    u50 (ref,  index: 3)
                    u49 (ref,  index: 4)
                    u47 (copy, index: 5)
                ]]
                if not (a13.Visible) then
                    local v52 = a13
                    if not v52 or u48 == v52 then
                        u50 = u50 + 1
                        u48 = nil
                        u49 = false
                        u47.Visible = false
                    end
                end
            end
        )
    end
    tooltip(u32, "Settings")
    tooltip(u35, "What's New")
    tooltip(u39, "Host Menu")
    GuiService_upv_2:GetPropertyChangedSignal("SelectedObject"):Connect(
        function()
            --[[
              line: 716
              upvalues:
                GuiService_upv_2 (copy, index: 1)
                tbl_upv_8 (copy, index: 2)
                u50 (ref,  index: 3)
                u48 (ref,  index: 4)
                u49 (ref,  index: 5)
                u31 (copy, index: 6)
                u46 (copy, index: 7)
                u47 (copy, index: 8)
                TweenService_upv_1 (copy, index: 9)
            ]]
            local SelectedObject_upv_1 = GuiService_upv_2.SelectedObject
            if SelectedObject_upv_1 and tbl_upv_8[SelectedObject_upv_1] then
                u50 = u50 + 1
                local u51 = u50
                u48 = SelectedObject_upv_1
                u49 = true
                task.delay(
                    0.1,
                    function()
                        --[[
                          line: 675
                          upvalues:
                            u51 (copy, index: 1)
                            u50 (ref,  index: 2)
                            SelectedObject_upv_1 (copy, index: 3)
                            u31 (copy, index: 4)
                            u46 (copy, index: 5)
                            tbl_upv_8 (copy, index: 6)
                            u47 (copy, index: 7)
                            TweenService_upv_1 (copy, index: 8)
                        ]]
                        if u51 ~= u50 or not SelectedObject_upv_1.Visible then
                            return
                        end
                        if u31.Enabled then
                            u46.Text = tbl_upv_8[SelectedObject_upv_1]
                            local v53 = SelectedObject_upv_1.Position.X.Offset + SelectedObject_upv_1.Size.X.Offset / 2
                            local v54 = SelectedObject_upv_1.Position.Y.Offset + SelectedObject_upv_1.Size.Y.Offset + 8
                            u47.Position = UDim2.fromOffset(v53, v54 - 4)
                            u47.BackgroundTransparency = 1
                            u46.TextTransparency = 1
                            u47.Visible = true
                            local v55 = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local tbl_9 = {BackgroundTransparency = 0.08}
                            tbl_9.Position = UDim2.fromOffset(v53, v54)
                            TweenService_upv_1:Create(u47, v55, tbl_9):Play()
                            TweenService_upv_1:Create(u46, v55, {TextTransparency = 0}):Play()
                        end
                    end
                )
                return
            end
            if not u49 then
                return
            end
            u50 = u50 + 1
            u48 = nil
            u49 = false
            u47.Visible = false
        end
    )
    UserInputService_upv_2:GetPropertyChangedSignal("MouseBehavior"):Connect(
        function()
            --[[
              line: 724
              upvalues:
                UserInputService_upv_2 (copy, index: 1)
                u50 (ref,  index: 2)
                u48 (ref,  index: 3)
                u49 (ref,  index: 4)
                u47 (copy, index: 5)
            ]]
            if UserInputService_upv_2.MouseBehavior == Enum.MouseBehavior.Default then
                return
            end
            u50 = u50 + 1
            u48 = nil
            u49 = false
            u47.Visible = false
        end
    )
    a1.MenuManager.Changed:Connect(
        function()
            --[[
              line: 729
              upvalues:
                u50 (ref,  index: 1)
                u48 (ref,  index: 2)
                u49 (ref,  index: 3)
                u47 (copy, index: 4)
            ]]
            u50 = u50 + 1
            u48 = nil
            u49 = false
            u47.Visible = false
        end
    )
    u32.MouseEnter:Connect(
        function()
            --[[
              line: 733
              upvalues:
                u42 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u42 = true
            paint()
        end
    )
    u32.MouseLeave:Connect(
        function()
            --[[
              line: 737
              upvalues:
                u42 (ref,  index: 1)
                u43 (ref,  index: 2)
                paint (copy, index: 3)
            ]]
            u42 = false
            u43 = false
            paint()
        end
    )
    u32.MouseButton1Down:Connect(
        function()
            --[[
              line: 741
              upvalues:
                u43 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u43 = true
            paint()
        end
    )
    u32.MouseButton1Up:Connect(
        function()
            --[[
              line: 745
              upvalues:
                u43 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u43 = false
            paint()
        end
    )
    u32.Activated:Connect(
        function()
            --[[
              line: 749
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Sounds.Play("Click")
            a1.MenuManager.Toggle("Settings")
        end
    )
    u35.MouseEnter:Connect(
        function()
            --[[
              line: 753
              upvalues:
                u37 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u37 = true
            paint()
        end
    )
    u35.MouseLeave:Connect(
        function()
            --[[
              line: 757
              upvalues:
                u37 (ref,  index: 1)
                u38 (ref,  index: 2)
                paint (copy, index: 3)
            ]]
            u37 = false
            u38 = false
            paint()
        end
    )
    u35.MouseButton1Down:Connect(
        function()
            --[[
              line: 761
              upvalues:
                u38 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u38 = true
            paint()
        end
    )
    u35.MouseButton1Up:Connect(
        function()
            --[[
              line: 765
              upvalues:
                u38 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u38 = false
            paint()
        end
    )
    u35.Activated:Connect(
        function()
            --[[
              line: 769
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Sounds.Play("Click")
            a1.MenuManager.Open("News")
        end
    )
    u39.MouseEnter:Connect(
        function()
            --[[
              line: 773
              upvalues:
                u44 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u44 = true
            paint()
        end
    )
    u39.MouseLeave:Connect(
        function()
            --[[
              line: 777
              upvalues:
                u44 (ref,  index: 1)
                u45 (ref,  index: 2)
                paint (copy, index: 3)
            ]]
            u44 = false
            u45 = false
            paint()
        end
    )
    u39.MouseButton1Down:Connect(
        function()
            --[[
              line: 781
              upvalues:
                u45 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u45 = true
            paint()
        end
    )
    u39.MouseButton1Up:Connect(
        function()
            --[[
              line: 785
              upvalues:
                u45 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u45 = false
            paint()
        end
    )
    u39.Activated:Connect(
        function()
            --[[
              line: 789
              upvalues:
                a1 (copy, index: 1)
                u41 (copy, index: 2)
            ]]
            a1.Sounds.Play("Click")
            u41:Fire()
        end
    )
    a1.MenuManager.Changed:Connect(paint)
    local tbl_upv_10 = {}
    tbl_upv_10.Button = u32
    tbl_upv_10.HostButton = u39
    tbl_upv_10.HostActivated = u41
    function tbl_upv_10.SetHostVisible(a15)
        --[[
          name: SetHostVisible
          line: 799
          upvalues:
            u39 (copy, index: 1)
            place (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        if u39.Visible == a15 then
            return
        end
        u39.Visible = a15
        place()
        if not a15 then
            return
        end
        UI_upv_1.Pop(u39, 0.6)
    end
    tbl_upv_10.NewsButton = u35
    function tbl_upv_10.SetNewsVisible(a16)
        --[[
          name: SetNewsVisible
          line: 810
          upvalues:
            u35 (copy, index: 1)
            place (copy, index: 2)
        ]]
        if u35.Visible == a16 then
            return
        end
        u35.Visible = a16
        place()
    end
    function tbl_upv_10.Last()
        --[[
          name: Last
          line: 817
          upvalues:
            u39 (copy, index: 1)
            u35 (copy, index: 2)
            u32 (copy, index: 3)
        ]]
        if u39.Visible then
            return u39
        elseif u35.Visible then
            return u35
        else
            return u32
        end
    end
    function tbl_upv_10.SetHidden(a17, a18)
        --[[
          name: SetHidden
          line: 821
          upvalues:
            tbl_upv_6 (copy, index: 1)
            u31 (copy, index: 2)
        ]]
        tbl_upv_6[a17] = (a18 and true) or nil
        u31.Enabled = next(tbl_upv_6) == nil
    end
    a1.TopbarSettings = tbl_upv_10
    local u52 = UI_upv_1.Panel({Name = "TrainingBanner", Visible = false, BackgroundTransparency = 0.15, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(440, 64), Trim = Colors_upv_1.Accent, Parent = u1})
    local u53 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Sword, {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 18, 0.5, 2), Size = UDim2.fromOffset(34, 34), ImageColor3 = Colors_upv_1.Accent, Parent = u52})
    local u54 = UI_upv_1.new("TextLabel", {Text = "TRAINING", Name = "Title", TextSize = 28, Position = UDim2.fromOffset(66, 8), Size = UDim2.new(1, -82, 0, 30), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Left, Parent = u52})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = u54
    local u55 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", TextSize = 15, Position = UDim2.fromOffset(66, 38), Size = UDim2.new(1, -82, 0, 18), FontFace = Fonts_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u52})
    local u56 = UI_upv_1.Panel({StrokeThickness = 2, StrokeTransparency = 0.3, Name = "Matchmaking", Visible = false, BackgroundTransparency = 0.06, Size = UDim2.fromOffset(300, 96), Radius = UDim.new(0, 16), StrokeColor = Colors_upv_1.Accent, Parent = u1})
    local u57 = u56:FindFirstChildOfClass("UIGradient")
    local u58 = u56:FindFirstChildOfClass("UIStroke")
    local u59 = UI_upv_1.new("TextLabel", {Text = "FINDING MATCH", Name = "Title", TextSize = 24, Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -120, 0, 28), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u56})
    local u60 = UI_upv_1.new("TextLabel", {Text = "0:00", Name = "Timer", TextSize = 30, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -18, 0, 9), Size = UDim2.fromOffset(96, 34), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u56})
    local u61 = UI_upv_1.new("TextLabel", {Visible = false, Text = "MATCH FOUND", Name = "Found", TextSize = 36, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(1, -24, 0, 40), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Text, Parent = u56})
    local u62 = UI_upv_1.new("Frame", {Name = "Seats", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 18, 1, -20), Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u56})
    local u63 = Color3.fromRGB(58, 63, 78)
    local tbl_upv_11 = {}
    for n_1 = 1, 6 do
        tbl_upv_11[n_1] = UI_upv_1.new("Frame", {Name = "Seat" .. n_1, Size = UDim2.fromOffset(16, 16), BackgroundColor3 = u63, LayoutOrder = n_1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u62})
    end
    local u64 = UI_upv_1.Pill("1V1", Colors_upv_1.Accent, {LayoutOrder = 7, Name = "Mode", PadX = 9, Height = 22, TextSize = 15, Parent = u62})
    u64.Visible = false
    local u65 = UI_upv_1.new("TextLabel", {Text = "1/6 PLAYERS", Name = "Count", TextSize = 18, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -18, 1, -16), Size = UDim2.fromOffset(140, 24), FontFace = Fonts_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u56})
    local u66 = UI_upv_1.new("Frame", {Name = "Scan", ClipsDescendants = true, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -32, 0, 3), Parent = u56})
    local u67 = UI_upv_1.new("Frame", {Name = "Bar", BackgroundColor3 = Colors_upv_1.Accent, Size = UDim2.fromScale(0.3, 1), Position = UDim2.fromScale(-0.3, 0), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u66})
    local u68 = UI_upv_1.Button({Visible = false, Text = "CANCEL", Name = "Cancel", Sound = false, Style = "Dark", TextSize = 22, Size = UDim2.fromOffset(300, 54), Icon = UI_upv_1.Icon("cross", 18, Colors_upv_1.TextDim), Parent = u1})
    local u69 = UI_upv_1.new("Frame", {ZIndex = 4, Name = "Pad", Size = UDim2.fromScale(1, 1), Parent = u68.Face})
    UI_upv_1.PadActionCap("Play", {Height = 24, ZIndex = 4, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = u69})
    local tbl_upv_12 = {}
    local tbl_upv_13 = {}
    local u70 = Vector2.zero
    local u71 = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local function homeRect(a19, a20, a21, a22)
        --[[
          name: homeRect
          line: 1010
        ]]
        local v57 = a19.AbsoluteSize / a21
        local v58 = (a20.X.Scale * a22.X) + a20.X.Offset - a19.AnchorPoint.X * v57.X
        local v59 = (a20.Y.Scale * a22.Y) + a20.Y.Offset - a19.AnchorPoint.Y * v57.Y
        return Rect.new(v58, v59, v58 + v57.X, v59 + v57.Y)
    end
    local function applyShift(a23)
        --[[
          name: applyShift
          line: 1060
          upvalues:
            tbl_upv_12 (copy, index: 1)
            u70 (ref,  index: 2)
            tbl_upv_13 (copy, index: 3)
            u1 (copy, index: 4)
            TweenService_upv_1 (copy, index: 5)
            u71 (copy, index: 6)
        ]]
        for key_1, value_3 in tbl_upv_12 do
            local v60 = value_3 + UDim2.fromOffset(u70.X, u70.Y)
            local v61 = tbl_upv_13[key_1]
            if v61 then
                v61:Cancel()
                tbl_upv_13[key_1] = nil
            end
            if not (a23) or not (key_1.Visible) then
                key_1.Position = v60
                continue
            end
            if u1.Visible then
                local v62 = TweenService_upv_1:Create(key_1, u71, {Position = v60})
                tbl_upv_13[key_1] = v62
                v62:Play()
            else
                key_1.Position = v60
            end
        end
    end
    local function computeShift()
        --[[
          name: computeShift
          line: 1017
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            tbl_upv_12 (copy, index: 3)
            homeRect (copy, index: 4)
            u27 (copy, index: 5)
            u56 (copy, index: 6)
            u68 (copy, index: 7)
        ]]
        local v63 = UI_upv_1.ChatRectIn(u1)
        if not v63 or not u1.Visible or UI_upv_1.Compact then
            return Vector2.zero
        end
        local v64 = math.max(UI_upv_1.Scale, 0.01)
        local v65 = u1.AbsoluteSize / v64
        local v66 = nil
        for key_2, value_4 in tbl_upv_12 do
            if not (key_2.Visible) or not (key_2.Parent) then
                continue
            end
            local v67 = homeRect(key_2, value_4, v64, v65)
            if v66 then
                v66 = Rect.new(math.min(v66.Min.X, v67.Min.X), math.min(v66.Min.Y, v67.Min.Y), math.max(v66.Max.X, v67.Max.X), math.max(v66.Max.Y, v67.Max.Y))
            else
                v66 = v67
            end
        end
        if not v66 or v63.Max.X + 12 <= v66.Min.X or v66.Max.X + 12 <= v63.Min.X or v63.Max.Y + 12 <= v66.Min.Y or v66.Max.Y + 12 <= v63.Min.Y then
            return Vector2.zero
        end
        local v69 = v65.X - 16
        for _, value_5 in {u27.Instance, u56, u68.Instance} do
            if value_5.Visible then
                v69 = math.min(v69, ((value_5.AbsolutePosition.X - u1.AbsolutePosition.X) / v64) - 12)
            end
        end
        local v70 = v63.Max.X + 12 - v66.Min.X
        if v66.Max.X + v70 <= v69 then
            return Vector2.new(v70, 0)
        end
        local v71 = ((UI_upv_1.Touch) and (v65.Y * 0.62)) or (v65.Y - 16)
        local v72 = v63.Max.Y + 12 - v66.Min.Y
        if v66.Max.Y + v72 <= v71 then
            return Vector2.new(0, v72)
        end
        return Vector2.new(math.max(0, v69 - v66.Max.X), 0)
    end
    local function redodge(a24)
        --[[
          name: redodge
          line: 1078
          upvalues:
            computeShift (copy, index: 1)
            u70 (ref,  index: 2)
            applyShift (copy, index: 3)
        ]]
        local v73 = computeShift()
        if not ((v73 - u70).Magnitude > 1) then
            return
        end
        u70 = v73
        applyShift(a24)
    end
    local u72 = false
    local function queueRedodge()
        --[[
          name: queueRedodge
          line: 1087
          upvalues:
            u72 (ref, index: 1)
        ]]
        if u72 then
            return
        end
        u72 = true
        task.defer(function() end)
    end
    local function place_2(a25, a26)
        --[[
          name: place
          line: 1099
          upvalues:
            tbl_upv_12 (copy, index: 1)
            tbl_upv_13 (copy, index: 2)
            u70 (ref,  index: 3)
            u72 (ref,  index: 4)
        ]]
        tbl_upv_12[a25] = a26
        local v74 = tbl_upv_13[a25]
        if v74 then
            v74:Cancel()
            tbl_upv_13[a25] = nil
        end
        a25.Position = a26 + UDim2.fromOffset(u70.X, u70.Y)
        if u72 then
            return
        end
        u72 = true
        task.defer(function() end)
    end
    local u73 = nil
    local u74 = Signal_upv_1.new()
    local function Shift()
        --[[
          name: Shift
          line: 1171
          upvalues:
            u70 (ref, index: 1)
        ]]
        return u70
    end
    local function Row()
        --[[
          name: Row
          line: 1174
          upvalues:
            u73 (ref, index: 1)
        ]]
        return u73
    end
    a1.LobbyColumn = {Place = place_2, Shift = Shift, Row = Row, RowChanged = u74}
    UI_upv_1.ChatChanged:Connect(queueRedodge)
    u1:GetPropertyChangedSignal("Visible"):Connect(
        function()
            --[[
              line: 1180
              upvalues:
                computeShift (copy, index: 1)
                u70 (ref,  index: 2)
                tbl_upv_12 (copy, index: 3)
                tbl_upv_13 (copy, index: 4)
            ]]
            local v75 = computeShift()
            if not ((v75 - u70).Magnitude > 1) then
                return
            end
            u70 = v75
            for key_3, value_6 in tbl_upv_12 do
                local v76 = value_6 + UDim2.fromOffset(u70.X, u70.Y)
                local v77 = tbl_upv_13[key_3]
                if v77 then
                    v77:Cancel()
                    tbl_upv_13[key_3] = nil
                end
                key_3.Position = v76
            end
        end
    )
    local u75 = "idle"
    local function phoneRow()
        --[[
          name: phoneRow
          line: 1121
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            tbl_upv_10 (copy, index: 3)
            GuiService_upv_1 (copy, index: 4)
        ]]
        local v78 = math.max(UI_upv_1.Scale, 0.01)
        local v79 = u1.AbsoluteSize / v78
        local AbsolutePosition_1 = u1.AbsolutePosition
        local v80 = tbl_upv_10.Last()
        local v81 = v80:FindFirstAncestorOfClass("ScreenGui")
        local v82, v83, v84
        if UI_upv_1.DebugDevice or not v81 then
            local v85 = UI_upv_1.TopInset() - 4
            local Button_2 = tbl_upv_10.Button
            local v86
            if v80 ~= Button_2 and v80.AbsoluteSize.X > 0 and Button_2.AbsoluteSize.X > 0 then
                v86 = math.max(0, (v80.AbsolutePosition.X + v80.AbsoluteSize.X) - (Button_2.AbsolutePosition.X + Button_2.AbsoluteSize.X)) / v78
            else
                v86 = 0
            end
            v82, v83, v84 = math.floor((v85 * 6) + v86), math.floor(v85 / 2), v79.X - 16
        elseif v80.AbsoluteSize.X < 1 then
            local v85 = UI_upv_1.TopInset() - 4
            local Button_2 = tbl_upv_10.Button
            local v86
            if v80 ~= Button_2 and v80.AbsoluteSize.X > 0 and Button_2.AbsoluteSize.X > 0 then
                v86 = math.max(0, (v80.AbsolutePosition.X + v80.AbsoluteSize.X) - (Button_2.AbsolutePosition.X + Button_2.AbsoluteSize.X)) / v78
            else
                v86 = 0
            end
            v82, v83, v84 = math.floor((v85 * 6) + v86), math.floor(v85 / 2), v79.X - 16
        else
            v82 = (v80.AbsolutePosition.X + v80.AbsoluteSize.X - AbsolutePosition_1.X) / v78 + 10
            v83 = (v80.AbsolutePosition.Y + v80.AbsoluteSize.Y / 2 - AbsolutePosition_1.Y) / v78
            local _ = GuiService_upv_1.TopbarInset
            v84 = GuiService_upv_1.TopbarInset.Width > 0 and (v81.AbsolutePosition.X + GuiService_upv_1.TopbarInset.Max.X - AbsolutePosition_1.X) / v78 - 8 or v79.X - 16
        end
        local v87 = math.floor(v82)
        local v88 = math.floor(math.max(v83, 38))
        local v89 = math.clamp((((math.min(v84, v79.X - 16) - v87) - 280) - 20) / 440, 0.7, 1)
        local v90 = v87 + 280 + 10
        local v91 = math.floor(v89 * 196)
        local tbl_14 = {chipW = 280, restoreW = 254, h = 72}
        tbl_14.x = v87
        tbl_14.y = v88
        tbl_14.loadoutX = v90
        tbl_14.loadoutW = v91
        tbl_14.cardX = (v90 + v91) + 10
        tbl_14.cardW = math.floor(v89 * 244)
        tbl_14.restoreX = math.max(v87, math.min(v90, ((((v79.X - 16) - 272) - 44) - 10) - 254))
        tbl_14.restoreY = (v88 + 36) + 8
        return tbl_14
    end
    local function layout()
        --[[
          name: layout
          line: 1186
          upvalues:
            UI_upv_1 (copy, index: 1)
            phoneRow (copy, index: 2)
            u73 (ref,  index: 3)
            u2 (copy, index: 4)
            u15 (ref,  index: 5)
            layoutChip (copy, index: 6)
            tbl_upv_12 (copy, index: 7)
            tbl_upv_13 (copy, index: 8)
            u70 (ref,  index: 9)
            u72 (ref,  index: 10)
            computeShift (copy, index: 11)
            applyShift (copy, index: 12)
            Button_upv_1 (copy, index: 13)
            u23 (copy, index: 14)
            Theme_upv_1 (copy, index: 15)
            u27 (copy, index: 16)
            u52 (copy, index: 17)
            u56 (copy, index: 18)
            u68 (copy, index: 19)
            u59 (copy, index: 20)
            u60 (copy, index: 21)
            u61 (copy, index: 22)
            u65 (copy, index: 23)
            u62 (copy, index: 24)
            tbl_upv_11 (copy, index: 25)
            u75 (ref,  index: 26)
        ]]
        local v92 = UI_upv_1.TopInset()
        local v93, v94, v95, v96 = nil, nil, nil, nil
        if UI_upv_1.Compact then
            local v97 = phoneRow()
            u73 = v97
            u2.AnchorPoint = Vector2.new(0, 0.5)
            u2.Size = UDim2.fromOffset(v97.chipW, v97.h)
            u15 = true
            layoutChip(true)
            local v98 = u2
            local v99 = UDim2.fromOffset(v97.x, v97.y)
            tbl_upv_12[v98] = v99
            v93 = tbl_upv_13[v98]
            if v93 then
                v93:Cancel()
                tbl_upv_13[v98] = nil
            end
            v98.Position = v99 + UDim2.fromOffset(u70.X, u70.Y)
            if not (u72) then
                u72 = true
                task.defer(function() end)
            end
            Button_upv_1.Instance.AnchorPoint = Vector2.new(0, 0.5)
            Button_upv_1.Instance.Size = UDim2.fromOffset(v97.loadoutW, v97.h)
            local Instance_1 = Button_upv_1.Instance
            v95 = UDim2.fromOffset(v97.loadoutX, v97.y)
            tbl_upv_12[Instance_1] = v95
            v94 = tbl_upv_13[Instance_1]
            if v94 then
                v94:Cancel()
                tbl_upv_13[Instance_1] = nil
            end
            Instance_1.Position = v95 + UDim2.fromOffset(u70.X, u70.Y)
            if not (u72) then
                u72 = true
                task.defer(function() end)
            end
            u23.Position = UDim2.new(1, -16, 0, v92)
            if Theme_upv_1.ShowCurrency then
                v95 = v92 + 60
            else
                v95 = v92
            end
            local v100 = math.max(v95, (v97.y + (v97.h / 2)) + 8)
            u27.Instance.AnchorPoint = Vector2.new(1, 0)
            u27.Instance.Position = UDim2.new(1, -16, 0, v100)
            u27.Instance.Size = UDim2.fromOffset(240, 84)
            u52.Position = UDim2.new(0.5, 0, 0, v92)
            u56.AnchorPoint = Vector2.new(1, 0)
            u56.Position = UDim2.new(1, -16, 0, v100)
            u56.Size = UDim2.fromOffset(272, 84)
            u68.Instance.AnchorPoint = Vector2.new(1, 0)
            u68.Instance.Position = UDim2.new(1, -16, 0, v100 + 94)
            u68.Instance.Size = UDim2.fromOffset(272, 52)
            u59.TextSize = 20
            u60.TextSize = 26
            u61.TextSize = 30
            u65.TextSize = 17
            u59.Position = UDim2.fromOffset(16, 11)
            u59.Size = UDim2.new(1, -96, 0, 28)
            u60.Position = UDim2.new(1, -16, 0, 7)
            u60.Size = UDim2.fromOffset(76, 34)
            u62.Position = UDim2.new(0, 16, 1, -18)
            u65.Position = UDim2.new(1, -16, 1, -14)
            for _, value_7 in tbl_upv_11 do
                value_7.Size = UDim2.fromOffset(14, 14)
            end
            v95 = u62:FindFirstChildOfClass("UIListLayout")
            v95.Padding = UDim.new(0, 5)
        else
            u73 = nil
            u2.AnchorPoint = Vector2.new(0, 1)
            u2.Size = UDim2.fromOffset(340, 78)
            u15 = false
            layoutChip(false)
            local v101 = u2
            local v102 = UDim2.new(0, 24, 1, -24)
            tbl_upv_12[v101] = v102
            v95 = tbl_upv_13[v101]
            if v95 then
                v95:Cancel()
                tbl_upv_13[v101] = nil
            end
            v101.Position = v102 + UDim2.fromOffset(u70.X, u70.Y)
            if not (u72) then
                u72 = true
                task.defer(function() end)
            end
            Button_upv_1.Instance.AnchorPoint = Vector2.new(0, 1)
            Button_upv_1.Instance.Size = UDim2.fromOffset(340, 66)
            local Instance_2 = Button_upv_1.Instance
            local v103 = UDim2.new(0, 24, 1, -114)
            tbl_upv_12[Instance_2] = v103
            v96 = tbl_upv_13[Instance_2]
            if v96 then
                v96:Cancel()
                tbl_upv_13[Instance_2] = nil
            end
            Instance_2.Position = v103 + UDim2.fromOffset(u70.X, u70.Y)
            if not (u72) then
                u72 = true
                task.defer(
                    function()
                        --[[
                          line: 1092
                          upvalues:
                            u72 (ref,  index: 1)
                            computeShift (copy, index: 2)
                            u70 (ref,  index: 3)
                            applyShift (copy, index: 4)
                        ]]
                        u72 = false
                        local v104 = computeShift()
                        if not ((v104 - u70).Magnitude > 1) then
                            return
                        end
                        u70 = v104
                        applyShift(true)
                    end
                )
            end
            u23.Position = UDim2.new(1, -24, 0, v92)
            u27.Instance.AnchorPoint = Vector2.new(1, 1)
            u27.Instance.Position = UDim2.new(1, -28, 1, -44)
            u27.Instance.Size = UDim2.fromOffset(300, 96)
            u52.Position = UDim2.new(0.5, 0, 0, v92)
            u56.AnchorPoint = Vector2.new(1, 1)
            u56.Position = UDim2.new(1, -28, 1, ((u75 ~= "search") and -44) or -104)
            u56.Size = UDim2.fromOffset(300, 96)
            u68.Instance.AnchorPoint = Vector2.new(1, 1)
            u68.Instance.Position = UDim2.new(1, -28, 1, -40)
            u68.Instance.Size = UDim2.fromOffset(300, 54)
            u59.TextSize = 24
            u60.TextSize = 30
            u61.TextSize = 36
            u65.TextSize = 18
            u59.Position = UDim2.fromOffset(18, 12)
            u59.Size = UDim2.new(1, -120, 0, 28)
            u60.Position = UDim2.new(1, -18, 0, 9)
            u60.Size = UDim2.fromOffset(96, 34)
            u62.Position = UDim2.new(0, 18, 1, -20)
            u65.Position = UDim2.new(1, -18, 1, -16)
            for _, value_8 in tbl_upv_11 do
                value_8.Size = UDim2.fromOffset(16, 16)
            end
            local v105 = u62:FindFirstChildOfClass("UIListLayout")
            v105.Padding = UDim.new(0, 6)
        end
    end
    local u76 = false
    local function relayout()
        --[[
          name: relayout
          line: 1259
          upvalues:
            layout (copy, index: 1)
            u74 (copy, index: 2)
            u73 (ref,  index: 3)
        ]]
        layout()
        u74:Fire(u73)
    end
    local function queueLayout()
        --[[
          name: queueLayout
          line: 1263
          upvalues:
            u76 (ref,  index: 1)
            layout (copy, index: 2)
            u74 (copy, index: 3)
            u73 (ref,  index: 4)
        ]]
        if u76 then
            return
        end
        u76 = true
        task.defer(
            function()
                --[[
                  line: 1268
                  upvalues:
                    u76 (ref,  index: 1)
                    layout (copy, index: 2)
                    u74 (copy, index: 3)
                    u73 (ref,  index: 4)
                ]]
                u76 = false
                layout()
                u74:Fire(u73)
            end
        )
    end
    layout()
    u74:Fire(u73)
    UI_upv_1.LayoutChanged:Connect(relayout)
    UI_upv_1.TopInsetChanged:Connect(relayout)
    UI_upv_1.ScaleChanged:Connect(queueLayout)
    tbl_upv_10.Button:GetPropertyChangedSignal("AbsolutePosition"):Connect(queueLayout)
    tbl_upv_10.Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueLayout)
    tbl_upv_10.HostButton:GetPropertyChangedSignal("Visible"):Connect(queueLayout)
    tbl_upv_10.NewsButton:GetPropertyChangedSignal("Visible"):Connect(queueLayout)
    tbl_upv_10.HostButton:GetPropertyChangedSignal("AbsolutePosition"):Connect(queueLayout)
    u1:GetPropertyChangedSignal("AbsoluteSize"):Connect(queueLayout)
    if a1.ToastAvoid then
        a1.ToastAvoid("TrainingBanner", u52)
    end
    local u77 = State_upv_1.Level()
    local function refreshProfile()
        --[[
          name: refreshProfile
          line: 1290
          upvalues:
            State_upv_1 (copy, index: 1)
            u11 (copy, index: 2)
            u77 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            u8 (copy, index: 5)
            a1 (copy, index: 6)
            u10 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            u26 (ref,  index: 9)
            u25 (copy, index: 10)
            u24 (copy, index: 11)
        ]]
        local v106 = State_upv_1.Level()
        local v107 = State_upv_1.Xp()
        local v108 = State_upv_1.XpToNext()
        u11.Text = "LV " .. tostring(v106)
        if u77 < v106 then
            UI_upv_1.Pop(u8, 1.5)
            a1.Sounds.Play("LevelUp")
        end
        u77 = v106
        local Tween_3 = UI_upv_1.Tween
        local Slow_1 = Theme_upv_1.Tween.Slow
        local tbl_15 = {Value = 0}
        tbl_15.Value = not (v108 > 0) and 0 or math.clamp(v107 / v108, 0, 1)
        Tween_3(u10, Slow_1, tbl_15)
        local v110 = State_upv_1.Shells()
        if v110 == u26 or not Theme_upv_1.ShowCurrency then
            return
        end
        u25(v110)
        UI_upv_1.Bump(u24, 0.12)
        if u26 < v110 then
            a1.Sounds.Play("Coin")
        end
        u26 = v110
    end
    refreshProfile()
    State_upv_1.ProfileChanged:Connect(refreshProfile)
    State_upv_1.AttrChanged:Connect(
        function(a27)
            --[[
              line: 1313
              upvalues:
                refreshProfile (copy, index: 1)
            ]]
            if a27 ~= "Level" and a27 ~= "XP" and a27 ~= "Shells" then
                return
            end
            refreshProfile()
        end
    )
    local tbl_upv_16 = {}
    local u78 = false
    local u79 = "3v3"
    local u80 = 0
    local u81 = 0
    local u82 = false
    local u83 = 0
    local u84 = false
    local function attrQueued()
        --[[
          name: attrQueued
          line: 1332
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v111 = State_upv_1.Get("Queued") == true
        return v111
    end
    local function wantMode()
        --[[
          name: wantMode
          line: 1335
          upvalues:
            State_upv_1 (copy, index: 1)
            u82 (ref,  index: 2)
            u78 (ref,  index: 3)
        ]]
        if State_upv_1.InMatch() or u82 then
            return "idle"
        end
        if State_upv_1.Get("QueueFound") == true then
            local v112 = State_upv_1.Get("Queued") == true
            if not (v112) and not (u78) then
                local v113 = State_upv_1.Get("Queued") == true
                if not (v113) and not (u78) then
                    return "idle"
                end
                return "search"
            end
            return "found"
        end
        local v113 = State_upv_1.Get("Queued") == true
        if not (v113) and not (u78) then
            return "idle"
        end
        return "search"
    end
    local function searchMode()
        --[[
          name: searchMode
          line: 1351
          upvalues:
            State_upv_1 (copy, index: 1)
            u79 (ref,  index: 2)
        ]]
        local v114 = State_upv_1.Get("QueueMode")
        local v115 = State_upv_1.Get("Queued") == true
        if v115 then
            if v114 ~= "1v1" and v114 ~= "3v3" then
                return u79
            end
            return v114
        end
        return u79
    end
    local function seatCount()
        --[[
          name: seatCount
          line: 1358
          upvalues:
            State_upv_1 (copy, index: 1)
            u79 (ref,  index: 2)
        ]]
        local v116 = State_upv_1.Get("QueueMode")
        local v117 = State_upv_1.Get("Queued") == true
        local v118
        if v117 then
            if v116 ~= "1v1" and v116 ~= "3v3" then
                v118 = u79
            else
                v118 = v116
            end
        else
            v118 = u79
        end
        if v118 ~= "1v1" then
            return 6
        end
        return 2
    end
    local function queuedAt()
        --[[
          name: queuedAt
          line: 1361
          upvalues:
            State_upv_1 (copy, index: 1)
            u80 (ref,  index: 2)
        ]]
        local v119 = State_upv_1.Get("QueuedAt")
        local v120 = State_upv_1.Get("Queued") == true
        if v120 and type(v119) == "number" and v119 > 0 then
            return v119
        end
        return u80
    end
    local function seatsFilled(a28, a29)
        --[[
          name: seatsFilled
          line: 1373
          upvalues:
            State_upv_1 (copy, index: 1)
            u79 (ref,  index: 2)
        ]]
        local v127, v129
        local v121 = State_upv_1.Get("QueueFilled")
        local v122 = State_upv_1.Get("QueueMode")
        local v123 = State_upv_1.Get("Queued") == true
        local v124
        if v123 then
            if v122 ~= "1v1" and v122 ~= "3v3" then
                v124 = u79
            else
                v124 = v122
            end
        else
            v124 = u79
        end
        local v125
        if v124 ~= "1v1" then
            v125 = 6
        else
            v125 = 2
        end
        local v126 = State_upv_1.Get("Queued") == true
        if v126 then
            if type(v121) ~= "number" then
                v127 = Random.new(a29)
                local v128 = 0
                v129 = 1
            else
                if v121 >= 1 then
                    return (math.clamp(math.floor(v121), 1, v125))
                end
                v127 = Random.new(a29)
                local v128 = 0
                v129 = 1
            end
        else
            v127 = Random.new(a29)
            local v128 = 0
            v129 = 1
        end
        while v129 < v125 - 1 do
            local v128 = nil
            v128 = v128 + v127:NextNumber(0.35, 0.95) * (((v129 - 1) * 0.45) + 1)
            if a28 < v128 then
                break
            else
                v129 = nil
                v129 = v129 + 1
            end
        end
        return v129
    end
    local u85 = 0
    local function paintSeats(a30, a31)
        --[[
          name: paintSeats
          line: 1392
          upvalues:
            State_upv_1 (copy, index: 1)
            u79 (ref,  index: 2)
            u64 (copy, index: 3)
            tbl_upv_11 (copy, index: 4)
            u75 (ref,  index: 5)
            Colors_upv_1 (copy, index: 6)
            u63 (copy, index: 7)
            u85 (ref,  index: 8)
            UI_upv_1 (copy, index: 9)
            Theme_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u65 (copy, index: 12)
        ]]
        local v130 = State_upv_1.Get("QueueMode")
        local v131 = State_upv_1.Get("Queued") == true
        local v132
        if v131 then
            if v130 ~= "1v1" and v130 ~= "3v3" then
                v132 = u79
            else
                v132 = v130
            end
        else
            v132 = u79
        end
        local v133
        if v132 ~= "1v1" then
            v133 = 6
        else
            v133 = 2
        end
        if v133 == 2 then
            v130 = true
        else
            v130 = false
        end
        u64.Visible = v130
        local v134 = nil
        for key_4, value_9 in tbl_upv_11 do
            value_9.Visible = key_4 <= v133
            local v135 = key_4 <= a30
            if u75 == "found" then
                v134 = Colors_upv_1.Text
            elseif v135 then
                v134 = Colors_upv_1.Accent
            else
                v134 = u63
            end
            if not (a31) or not (v135) then
                value_9.BackgroundColor3 = v134
                continue
            end
            if u85 < key_4 then
                value_9.BackgroundColor3 = Colors_upv_1.Text
                UI_upv_1.Tween(value_9, Theme_upv_1.Tween.Smooth, {BackgroundColor3 = v134})
                UI_upv_1.Pop(value_9, 1.8)
            else
                value_9.BackgroundColor3 = v134
            end
        end
        if a31 and u85 < a30 and u75 == "search" then
            a1.Sounds.Play("Tick", {pitch = (a30 * 0.06) + 0.9})
        end
        u85 = a30
        if UI_upv_1.Compact then
            v130 = string.format("%d/%d", a30, v133)
        else
            v130 = string.format("%d/%d PLAYERS", a30, v133)
        end
        u65.Text = v130
    end
    local u86 = nil
    local function setScan(a32)
        --[[
          name: setScan
          line: 1415
          upvalues:
            u86 (ref,  index: 1)
            u67 (copy, index: 2)
            u66 (copy, index: 3)
        ]]
        if not (a32) or u86 then
            if not (a32) and u86 then
                u86:Cancel()
                u86 = nil
            end
        else
            u67.Position = UDim2.fromScale(-0.3, 0)
            local v136 = game:GetService("TweenService"):Create(u67, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, 0.15), {Position = UDim2.fromScale(1, 0)})
            v136:Play()
            u86 = v136
        end
        u66.Visible = a32
    end
    local function paintCard()
        --[[
          name: paintCard
          line: 1432
          upvalues:
            u75 (ref,  index: 1)
            u57 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u58 (copy, index: 4)
            u59 (copy, index: 5)
            u60 (copy, index: 6)
            u61 (copy, index: 7)
            u65 (copy, index: 8)
        ]]
        local v137 = u75 == "found"
        local v138
        if v137 then
            v138 = ColorSequence.new(Color3.fromRGB(64, 168, 255), Color3.fromRGB(28, 132, 246))
        else
            v138 = ColorSequence.new(Colors_upv_1.Panel, Colors_upv_1.PanelLo)
        end
        u57.Color = v138
        local v139
        if v137 then
            v139 = Color3.fromRGB(150, 210, 255)
        else
            v139 = Colors_upv_1.Accent
        end
        u58.Color = v139
        u58.Transparency = (v137 and 0.4) or 0.3
        u59.Visible = not v137
        u60.Visible = not v137
        u61.Visible = v137
        local v140
        if v137 then
            v140 = Colors_upv_1.Text
        else
            v140 = Colors_upv_1.TextDim
        end
        u65.TextColor3 = v140
    end
    local function tick()
        --[[
          name: tick
          line: 1445
          upvalues:
            u75 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            u80 (ref,  index: 3)
            u60 (copy, index: 4)
            seatsFilled (copy, index: 5)
            u85 (ref,  index: 6)
            paintSeats (copy, index: 7)
        ]]
        if u75 == "idle" then
            return
        end
        local v141 = State_upv_1.Get("QueuedAt")
        local v142 = State_upv_1.Get("Queued") == true
        local v143
        if v142 and type(v141) == "number" and v141 > 0 then
            v143 = v141
        else
            v143 = u80
        end
        local v144 = math.max(0, State_upv_1.Now() - v143)
        u60.Text = string.format("%d:%02d", v144 // 60, math.floor(v144) % 60)
        if u75 == "search" then
            local v145 = seatsFilled(v144, math.floor(v143 * 1000) % 2147483647)
            if v145 ~= u85 then
                paintSeats(v145, true)
            end
        end
    end
    local function applyMode(a33)
        --[[
          name: applyMode
          line: 1460
          upvalues:
            State_upv_1 (copy, index: 1)
            u82 (ref,  index: 2)
            u78 (ref,  index: 3)
            u75 (ref,  index: 4)
            layout (copy, index: 5)
            u27 (copy, index: 6)
            tbl_upv_16 (copy, index: 7)
            u56 (copy, index: 8)
            u68 (copy, index: 9)
            setScan (copy, index: 10)
            paintCard (copy, index: 11)
            u85 (ref,  index: 12)
            paintSeats (copy, index: 13)
            UI_upv_1 (copy, index: 14)
            Theme_upv_1 (copy, index: 15)
            tick (copy, index: 16)
            u79 (ref,  index: 17)
            u64 (copy, index: 18)
            tbl_upv_11 (copy, index: 19)
            u63 (copy, index: 20)
            Colors_upv_1 (copy, index: 21)
            u65 (copy, index: 22)
            u61 (copy, index: 23)
            a1 (copy, index: 24)
        ]]
        local v146
        if State_upv_1.InMatch() or u82 then
            v146 = "idle"
        elseif State_upv_1.Get("QueueFound") ~= true then
            local v147 = State_upv_1.Get("Queued") == true
            if v147 or u78 then
                v146 = "search"
            else
                v146 = "idle"
            end
        else
            local v148 = State_upv_1.Get("Queued") == true
            if v148 or u78 then
                v146 = "found"
            else
                local v147 = State_upv_1.Get("Queued") == true
                if v147 or u78 then
                    v146 = "search"
                else
                    v146 = "idle"
                end
            end
        end
        if v146 == u75 then
            return
        end
        local v149 = u75
        u75 = v146
        layout()
        local Instance_3 = u27.Instance
        local v150 = (u75 == "idle") and (next(tbl_upv_16) == nil)
        Instance_3.Visible = v150
        u56.Visible = u75 ~= "idle"
        u68.Instance.Visible = u75 == "search"
        local v150 = u75 == "search"
        setScan(v150)
        paintCard()
        if u75 == "search" then
            if v149 == "idle" then
                u85 = 0
                paintSeats(1, false)
                if a33 then
                    local Position_1 = u56.Position
                    if not (UI_upv_1.Compact) then
                        u56.Position = u27.Instance.Position
                    end
                    UI_upv_1.Pop(u56, 0.92)
                    UI_upv_1.Tween(u56, Theme_upv_1.Tween.Smooth, {Position = Position_1})
                    UI_upv_1.Enter(u68.Instance, Vector2.new(0, 16), 0.08, u68.Instance.Position)
                end
            end
            tick()
        elseif u75 == "found" then
            tick()
            if not (UI_upv_1.Compact) and v149 == "search" then
                u56.Position = UDim2.new(1, -28, 1, -104)
                UI_upv_1.Tween(u56, Theme_upv_1.Tween.Smooth, {Position = u56.Position})
            end
            local v151 = State_upv_1.Get("QueueMode")
            local v152 = State_upv_1.Get("Queued") == true
            local v153
            if v152 then
                if v151 ~= "1v1" and v151 ~= "3v3" then
                    v153 = u79
                else
                    v153 = v151
                end
            else
                v153 = u79
            end
            if v153 ~= "1v1" then
                v150 = 6
            else
                v150 = 2
            end
            u85 = v150
            if v150 == 2 then
                v151 = true
            else
                v151 = false
            end
            u64.Visible = v151
            for key_5, value_upv_10 in tbl_upv_11 do
                value_upv_10.Visible = key_5 <= v150
                if u85 < key_5 then
                    value_upv_10.BackgroundColor3 = u63
                    task.delay(
                        (key_5 - u85) * 0.06,
                        function()
                            --[[
                              line: 1505
                              upvalues:
                                u75 (ref,  index: 1)
                                value_upv_10 (copy, index: 2)
                                Colors_upv_1 (copy, index: 3)
                                UI_upv_1 (copy, index: 4)
                            ]]
                            if u75 ~= "found" then
                                return
                            end
                            value_upv_10.BackgroundColor3 = Colors_upv_1.Text
                            UI_upv_1.Pop(value_upv_10, 1.8)
                        end
                    )
                else
                    value_upv_10.BackgroundColor3 = Colors_upv_1.Text
                end
            end
            if UI_upv_1.Compact then
                v151 = string.format("%d/%d", v150, v150)
            else
                v151 = string.format("%d/%d PLAYERS", v150, v150)
            end
            u65.Text = v151
            UI_upv_1.Pop(u56, 1.12)
            UI_upv_1.Pop(u61, 1.3)
            a1.Sounds.Play("Match_Found")
            if a1.MenuManager.IsOpen() then
                a1.MenuManager.CloseAll()
            end
            a1.MenuManager.EndHudFocus()
        elseif v149 ~= "idle" and a33 and not State_upv_1.InMatch() then
            UI_upv_1.Pop(u27.Instance, 0.92)
        end
    end
    local function queue(a34)
        --[[
          name: queue
          line: 1531
          upvalues:
            u84 (ref,  index: 1)
            u75 (ref,  index: 2)
            tbl_upv_16 (copy, index: 3)
            u79 (ref,  index: 4)
            u78 (ref,  index: 5)
            u80 (ref,  index: 6)
            u81 (ref,  index: 7)
            State_upv_1 (copy, index: 8)
            u82 (ref,  index: 9)
            a1 (copy, index: 10)
            applyMode (copy, index: 11)
        ]]
        if (u84) or u75 ~= "idle" then
            return
        end
        if next(tbl_upv_16) == nil then
            u84 = true
            u79 = ((a34 ~= "1v1") and "3v3") or "1v1"
            local v154 = State_upv_1.Now()
            local v155 = os.clock()
            u78 = true
            u80 = v154
            u81 = v155
            u82 = false
            a1.Sounds.Play("Queue_Join")
            applyMode(true)
            local v156 = a1.QueueAction("Queue", nil, nil, u79)
            u84 = false
            if not (v156) then
                u78 = false
                applyMode(true)
            end
        end
    end
    local function cancel()
        --[[
          name: cancel
          line: 1548
          upvalues:
            u75 (ref,  index: 1)
            u82 (ref,  index: 2)
            u83 (ref,  index: 3)
            u78 (ref,  index: 4)
            a1 (copy, index: 5)
            applyMode (copy, index: 6)
        ]]
        if u75 ~= "search" then
            return
        end
        local v157 = os.clock()
        u82 = true
        u83 = v157
        u78 = false
        a1.Sounds.Play("Queue_Leave")
        applyMode(true)
        if (a1.QueueAction("Cancel")) then
            return
        end
        u82 = false
        applyMode(true)
    end
    local function onPlay()
        --[[
          name: onPlay
          line: 1564
          upvalues:
            u75 (ref,  index: 1)
            tbl_upv_16 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            queue (copy, index: 5)
        ]]
        if u75 ~= "idle" then
            return
        end
        if next(tbl_upv_16) == nil then
            local v158 = State_upv_1.Get("Duel") == true
            if v158 then
                a1.MenuManager.Open("Mode")
            else
                task.spawn(queue, "3v3")
            end
        end
    end
    u27.Activated:Connect(onPlay)
    u68.Activated:Connect(cancel)
    local function padY()
        --[[
          name: padY
          line: 1578
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v159 = State_upv_1.Get("CombatMode") ~= true
        return v159
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a35)
            --[[
              line: 1581
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u1 (copy, index: 3)
                UserInputService_upv_1 (copy, index: 4)
                State_upv_1 (copy, index: 5)
                u75 (ref,  index: 6)
                cancel (copy, index: 7)
                u27 (copy, index: 8)
                tbl_upv_16 (copy, index: 9)
                queue (copy, index: 10)
                u68 (copy, index: 11)
                Button_upv_1 (copy, index: 12)
            ]]
            local KeyCode_1 = a35.KeyCode
            local v160 = Keybinds_upv_1.IsPad(a35, "Play")
            if not (v160) and KeyCode_1 ~= Enum.KeyCode.DPadLeft and KeyCode_1 ~= Enum.KeyCode.DPadRight then
                return
            end
            local MenuManager_1 = a1.MenuManager
            if not u1.Visible or (MenuManager_1.IsOpen()) or (MenuManager_1.HasFocus()) then
                return
            end
            if not (UserInputService_upv_1:GetFocusedTextBox()) then
                local v161 = nil
                if v160 then
                    v161 = State_upv_1.Get("CombatMode") ~= true
                    if v161 then
                        if MenuManager_1.HudFocused() then
                            if KeyCode_1 ~= Enum.KeyCode.ButtonA and KeyCode_1 ~= Enum.KeyCode.ButtonB and string.sub(KeyCode_1.Name, 1, 4) ~= "DPad" then
                                if u75 == "search" then
                                    task.spawn(cancel)
                                elseif u75 == "idle" and u27.Instance.Visible and u75 == "idle" then
                                    if next(tbl_upv_16) ~= nil then
                                        return
                                    end
                                    local v162 = State_upv_1.Get("Duel") == true
                                    if v162 then
                                        a1.MenuManager.Open("Mode")
                                        return
                                    end
                                    task.spawn(queue, "3v3")
                                end
                                return
                            end
                            return
                        end
                        if u75 == "search" then
                            task.spawn(cancel)
                        elseif u75 == "idle" and u27.Instance.Visible and u75 == "idle" then
                            if next(tbl_upv_16) ~= nil then
                                return
                            end
                            local v162 = State_upv_1.Get("Duel") == true
                            if v162 then
                                a1.MenuManager.Open("Mode")
                                return
                            end
                            task.spawn(queue, "3v3")
                        end
                        return
                    end
                end
                if KeyCode_1 ~= Enum.KeyCode.DPadLeft and KeyCode_1 ~= Enum.KeyCode.DPadRight or MenuManager_1.HudFocused() then
                    return
                end
                local PadUsedIn_1 = Keybinds_upv_1.PadUsedIn
                local v163 = ((State_upv_1.Get("CombatMode") ~= true) and "lobby") or "training"
                if PadUsedIn_1(a35, v163) then
                    return
                end
                local v164
                if u68.Instance.Visible then
                    v164 = u68.Instance
                elseif u27.Instance.Visible then
                    v164 = u27.Instance
                else
                    v164 = Button_upv_1.Instance
                end
                local v165 = a1.Party and (a1.Party.PadTarget and (a1.Party.PadTarget()))
                local HudFocus_1 = MenuManager_1.HudFocus
                if KeyCode_1 ~= Enum.KeyCode.DPadLeft then
                    v163 = v165 or v164
                else
                    v163 = Button_upv_1.Instance
                end
                HudFocus_1(v163)
            end
        end
    )
    local function refreshPadY()
        --[[
          name: refreshPadY
          line: 1618
          upvalues:
            State_upv_1 (copy, index: 1)
            u30 (copy, index: 2)
            u69 (copy, index: 3)
        ]]
        local v166 = State_upv_1.Get("CombatMode") ~= true
        u30.Visible = v166
        u69.Visible = v166
    end
    local v167 = State_upv_1.Get("CombatMode") ~= true
    u30.Visible = v167
    u69.Visible = v167
    State_upv_1.AttrChanged:Connect(
        function(a36)
            --[[
              line: 1624
              upvalues:
                State_upv_1 (copy, index: 1)
                u78 (ref,  index: 2)
                u82 (ref,  index: 3)
                applyMode (copy, index: 4)
                tick (copy, index: 5)
            ]]
            if a36 == "Queued" then
                local v168 = State_upv_1.Get("Queued") == true
                if v168 then
                    u78 = false
                else
                    u82 = false
                end
            elseif a36 ~= "QueueFound" and a36 ~= "QueuedAt" and a36 ~= "QueueFilled" and a36 ~= "State" then
                return
            end
            applyMode(true)
            tick()
        end
    )
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 1637
              upvalues:
                paintSeats (copy, index: 1)
                u85 (ref,  index: 2)
            ]]
            paintSeats(u85, false)
        end
    )
    UI_upv_1.Every(
        u1,
        0.1,
        function()
            --[[
              line: 1640
              upvalues:
                u78 (ref,  index: 1)
                State_upv_1 (copy, index: 2)
                u84 (ref,  index: 3)
                u81 (ref,  index: 4)
                u82 (ref,  index: 5)
                u83 (ref,  index: 6)
                applyMode (copy, index: 7)
                tick (copy, index: 8)
            ]]
            local v169 = nil
            if u78 then
                v169 = State_upv_1.Get("Queued") == true
                if not (v169) and not (u84) and os.clock() - u81 > 3 then
                    u78 = false
                end
            end
            if u82 and os.clock() - u83 > 2 then
                u82 = false
            end
            applyMode(true)
            tick()
        end
    )
    a1.Debug.queue = function(a37, a38)
        --[[
          line: 1652
          upvalues:
            queue (copy, index: 1)
            u75 (ref,  index: 2)
            tbl_upv_16 (copy, index: 3)
            State_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            cancel (copy, index: 6)
            u85 (ref,  index: 7)
            u79 (ref,  index: 8)
            u78 (ref,  index: 9)
            u82 (ref,  index: 10)
        ]]
        if a37 ~= "play" then
            if a37 == "cancel" then
                task.spawn(cancel)
            end
        elseif a38 == "1v1" or a38 == "3v3" then
            task.spawn(queue, a38)
        elseif u75 == "idle" and next(tbl_upv_16) == nil then
            local v170 = State_upv_1.Get("Duel") == true
            if v170 then
                a1.MenuManager.Open("Mode")
            else
                task.spawn(queue, "3v3")
            end
        end
        local tbl_17 = {cancelling = 0, seatCount = 0, searchMode = 0, localQueued = 0}
        tbl_17.mode = u75
        tbl_17.queued = State_upv_1.Get("Queued")
        tbl_17.queuedAt = State_upv_1.Get("QueuedAt")
        tbl_17.found = State_upv_1.Get("QueueFound")
        tbl_17.seats = u85
        local v171 = State_upv_1.Get("QueueMode")
        local v172 = State_upv_1.Get("Queued") == true
        local v173
        if v172 then
            if v171 ~= "1v1" and v171 ~= "3v3" then
                v173 = u79
            else
                v173 = v171
            end
        else
            v173 = u79
        end
        local v174
        if v173 ~= "1v1" then
            v174 = 6
        else
            v174 = 2
        end
        tbl_17.seatCount = v174
        local v175 = State_upv_1.Get("QueueMode")
        local v176 = State_upv_1.Get("Queued") == true
        if v176 then
            if v175 ~= "1v1" and v175 ~= "3v3" then
                v174 = u79
            else
                v174 = v175
            end
        else
            v174 = u79
        end
        tbl_17.searchMode = v174
        tbl_17.localQueued = u78
        tbl_17.cancelling = u82
        return tbl_17
    end
    local function inTraining()
        --[[
          name: inTraining
          line: 1669
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v177 = (State_upv_1.Get("CombatMode") == true) and (not State_upv_1.InMatch())
        return v177
    end
    local u87 = (State_upv_1.Get("CombatMode") == true) and (not State_upv_1.InMatch())
    local u88 = 0
    local function showZoneBanner(a39)
        --[[
          name: showZoneBanner
          line: 1674
          upvalues:
            u88 (ref,  index: 1)
            u54 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u55 (copy, index: 4)
            u53 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u52 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        u88 = u88 + 1
        local u89 = u88
        u54.Text = (a39 and "TRAINING") or "LEFT TRAINING"
        local v178
        if a39 then
            v178 = Colors_upv_1.Accent
        else
            v178 = Colors_upv_1.Text
        end
        u54.TextColor3 = v178
        u55.Text = (a39 and "COMBAT MODE  \194\183  WEAPONS OUT") or "WEAPONS STOWED"
        local v179
        if a39 then
            v179 = Colors_upv_1.Accent
        else
            v179 = Colors_upv_1.TextDim
        end
        u53.ImageColor3 = v179
        UI_upv_1.Unfade(u52)
        u52.Visible = true
        UI_upv_1.Enter(u52, Vector2.new(0, -16))
        UI_upv_1.Pop(u53, 0.5)
        a1.Sounds.Play((a39 and "Select") or "Close")
        task.delay(
            (a39 and 2.6) or 1.8,
            function()
                --[[
                  line: 1686
                  upvalues:
                    u89 (copy, index: 1)
                    u88 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    u52 (copy, index: 4)
                ]]
                if u89 ~= u88 then
                    return
                end
                UI_upv_1.FadeOut(u52)
                task.delay(
                    0.3,
                    function()
                        --[[
                          line: 1691
                          upvalues:
                            u89 (copy, index: 1)
                            u88 (ref,  index: 2)
                            u52 (copy, index: 3)
                            UI_upv_1 (copy, index: 4)
                        ]]
                        if u89 ~= u88 then
                            return
                        end
                        u52.Visible = false
                        UI_upv_1.Unfade(u52)
                    end
                )
            end
        )
    end
    a1.Debug.trainingBanner = function(a40)
        --[[
          line: 1699
          upvalues:
            showZoneBanner (copy, index: 1)
        ]]
        showZoneBanner(a40 ~= false)
        return true
    end
    State_upv_1.AttrChanged:Connect(
        function(a41)
            --[[
              line: 1703
              upvalues:
                State_upv_1 (copy, index: 1)
                u30 (copy, index: 2)
                u69 (copy, index: 3)
                u87 (ref,  index: 4)
                showZoneBanner (copy, index: 5)
            ]]
            if a41 ~= "CombatMode" and a41 ~= "State" then
                return
            end
            local v180 = State_upv_1.Get("CombatMode") ~= true
            u30.Visible = v180
            u69.Visible = v180
            local v181 = (State_upv_1.Get("CombatMode") == true) and (not State_upv_1.InMatch())
            if v181 == u87 then
                return
            end
            u87 = v181
            if not State_upv_1.InMatch() then
                showZoneBanner(v181)
            end
        end
    )
    u1.Visible = not State_upv_1.SeesMatch() and not a1.HudHidden
    tbl_upv_10.SetNewsVisible(not State_upv_1.SeesMatch())
    if not (u1.Visible) then
        a1.MenuManager.EndHudFocus()
    end
    local function refreshVisible()
        --[[
          name: refreshVisible
          line: 1718
          upvalues:
            u1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            tbl_upv_10 (copy, index: 4)
        ]]
        u1.Visible = not State_upv_1.SeesMatch() and not a1.HudHidden
        tbl_upv_10.SetNewsVisible(not State_upv_1.SeesMatch())
        if (u1.Visible) then
            return
        end
        a1.MenuManager.EndHudFocus()
    end
    State_upv_1.PlayerStateChanged:Connect(refreshVisible)
    State_upv_1.WatchChanged:Connect(refreshVisible)
    a1.HudHiddenChanged:Connect(refreshVisible)
    local function SetPlayHidden(a42, a43)
        --[[
          name: SetPlayHidden
          line: 1739
          upvalues:
            tbl_upv_16 (copy, index: 1)
            u27 (copy, index: 2)
            u75 (ref,  index: 3)
        ]]
        tbl_upv_16[a42] = (a43 and true) or nil
        local Instance_4 = u27.Instance
        Instance_4.Visible = u75 == "idle" and next(tbl_upv_16) == nil
    end
    local function CanPlay()
        --[[
          name: CanPlay
          line: 1749
          upvalues:
            u75 (ref,  index: 1)
            tbl_upv_16 (copy, index: 2)
        ]]
        local v185 = (u75 == "idle") and (next(tbl_upv_16) == nil)
        return v185
    end
    local function Queue(a44)
        --[[
          name: Queue
          line: 1745
          upvalues:
            queue (copy, index: 1)
        ]]
        task.spawn(queue, a44)
    end
    local function duelOn()
        --[[
          name: duelOn
          line: 415
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v186 = State_upv_1.Get("Duel") == true
        return v186
    end
    a1.LobbyHud = {Root = u1, PlayButton = u27, Chip = u2, StreakSlot = u4, SetPlayHidden = SetPlayHidden, Queue = Queue, DuelOn = duelOn, CanPlay = CanPlay}
end
return tbl_1