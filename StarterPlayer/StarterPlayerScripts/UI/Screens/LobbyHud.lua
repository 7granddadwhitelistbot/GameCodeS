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
    local u23 = UI_upv_1.Button({Radius = 16, Text = "PLAY", Name = "Play", Style = "Primary", TextSize = 46, Size = UDim2.fromOffset(300, 96), AnchorPoint = Vector2.new(1, 1), Icon = UI_upv_1.Image(UI_upv_1.Assets.Icons.CrossedArrows, {Size = UDim2.fromOffset(36, 34), ImageColor3 = Colors_upv_1.Text}), Parent = u1})
    local u24 = UI_upv_1.new("TextLabel", {Text = "3V3  \194\183  BEST OF 5", Name = "Sub", TextSize = 15, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 1, 2), Size = UDim2.new(1, 0, 0, 18), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u23.Instance})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = u24
    local u25 = 2
    pcall(
        function()
            --[[
              line: 386
              upvalues:
                u25 (ref, index: 1)
            ]]
            local v35 = tonumber(require(game:GetService("ReplicatedStorage").Shared.Config).FIRST_MATCH_ROUNDS_TO_WIN) or u25
            u25 = v35
        end
    )
    local u26 = UI_upv_1.new("Frame", {ZIndex = 4, Name = "Pad", Size = UDim2.fromScale(1, 1), Parent = u23.Face})
    UI_upv_1.PadActionCap("Play", {Height = 28, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = u26})
    local function refreshPlaySub()
        --[[
          name: refreshPlaySub
          line: 399
          upvalues:
            State_upv_1 (copy, index: 1)
            u25 (ref,  index: 2)
            u24 (copy, index: 3)
        ]]
        local v36 = State_upv_1.Profile
        local v37 = State_upv_1.HasProfile and ((type(v36) == "table") and ((type(v36.stats) == "table") and (v36.stats.matches == 0)))
        if v37 then
            v36 = u25
        else
            v36 = State_upv_1.DEFAULT_ROUNDS_TO_WIN
        end
        local v38 = State_upv_1.Get("Duel") == true
        local v39
        if v38 then
            v39 = "3V3  \194\183  1V1"
        else
            v39 = string.format("3V3  \194\183  BEST OF %d", (v36 * 2) - 1)
        end
        u24.Text = v39
    end
    refreshPlaySub()
    State_upv_1.ProfileChanged:Connect(refreshPlaySub)
    State_upv_1.AttrChanged:Connect(
        function(a8)
            --[[
              line: 407
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
          line: 423
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
          line: 435
          upvalues:
            State_upv_1 (copy, index: 1)
            Loc_upv_1 (copy, index: 2)
            Label_upv_1 (copy, index: 3)
        ]]
        if State_upv_1.HasLoadoutSlots() and State_upv_1.LoadoutSlotCount() > 1 then
            local v40 = string.gsub(string.gsub(string.gsub(Loc_upv_1.T(string.upper(State_upv_1.LoadoutName(State_upv_1.ActiveLoadout()))), "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
            Label_upv_1.Text = string.format("%s\n<font size=\"14\" color=\"#BAC0CE\">%s</font>", Loc_upv_1.T("LOADOUT"), v40)
        else
            Label_upv_1.Text = Loc_upv_1.T("LOADOUT")
        end
    end
    refreshLoadoutLabel()
    State_upv_1.ProfileChanged:Connect(refreshLoadoutLabel)
    Loc_upv_1.Changed:Connect(refreshLoadoutLabel)
    local GuiService_upv_2 = game:GetService("GuiService")
    local u27 = Instance.new("ScreenGui")
    u27.Name = "TR_TopbarSettings"
    u27.ResetOnSpawn = false
    u27.IgnoreGuiInset = true
    u27.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    u27.DisplayOrder = 8
    u27.Parent = a1.PlayerGui
    local u28 = Instance.new("TextButton")
    u28.Name = "Settings"
    u28.Text = ""
    u28.AutoButtonColor = false
    u28.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    u28.BackgroundTransparency = 0.08
    u28.Size = UDim2.fromOffset(44, 44)
    u28.Parent = u27
    UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = u28
    local u29 = UI_upv_1.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u28})
    local u30 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "gear", Name = "Icon", TextSize = 24, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(24, 24), FontFace = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular), TextColor3 = Color3.fromRGB(247, 247, 248), Parent = u28})
    task.delay(
        3,
        function()
            --[[
              line: 499
              upvalues:
                u30 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
                u28 (copy, index: 3)
            ]]
            local X_1 = u30.TextBounds.X
            if not (X_1 < 1) and not (X_1 > 32) then
                return
            end
            u30.Visible = false
            UI_upv_1.Icon("gear", 24, Color3.fromRGB(247, 247, 248), {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), HoleColor = Color3.fromRGB(18, 18, 21), Parent = u28})
        end
    )
    UI_upv_1.KeyCap("M", {Transparency = 0.05, Height = 17, TextSize = 11, ZIndex = 3, Gamepad = Enum.KeyCode.ButtonSelect, Color = Color3.fromRGB(18, 18, 21), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 5, 1, 1), Parent = u28})
    local u31 = Instance.new("TextButton")
    u31.Name = "News"
    u31.Text = ""
    u31.AutoButtonColor = false
    u31.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    u31.BackgroundTransparency = 0.08
    u31.Size = UDim2.fromOffset(44, 44)
    u31.Parent = u27
    UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = u31
    local u32 = UI_upv_1.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u31})
    UI_upv_1.Glyph("megaphone", 24, Color3.fromRGB(247, 247, 248), {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u31})
    local u33 = false
    local u34 = false
    local u35 = Instance.new("TextButton")
    u35.Name = "CustomHost"
    u35.Text = ""
    u35.AutoButtonColor = false
    u35.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    u35.BackgroundTransparency = 0.08
    u35.Size = UDim2.fromOffset(44, 44)
    u35.Visible = false
    u35.Parent = u27
    UI_upv_1.Corner(Theme_upv_1.Radius.Pill).Parent = u35
    local u36 = UI_upv_1.new("Frame", {Name = "State", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u35})
    local v184 = UI_upv_1.Glyph("crown", 24, Color3.fromRGB(247, 247, 248), {Name = "Icon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = u35})
    UI_upv_1.ActionCap("CustomMenu", {Transparency = 0.05, Height = 17, TextSize = 11, ZIndex = 3, Gamepad = Enum.KeyCode.DPadDown, Color = Color3.fromRGB(18, 18, 21), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 5, 1, 1), Parent = u35})
    local u37 = Signal_upv_1.new()
    local u38 = false
    local u39 = false
    local u40 = false
    local u41 = false
    local tbl_upv_6 = {}
    local UserInputService_upv_2 = game:GetService("UserInputService")
    local function paint()
        --[[
          name: paint
          line: 574
          upvalues:
            UserInputService_upv_2 (copy, index: 1)
            u38 (ref,  index: 2)
            u39 (ref,  index: 3)
            u40 (ref,  index: 4)
            u41 (ref,  index: 5)
            u33 (ref,  index: 6)
            u34 (ref,  index: 7)
            a1 (copy, index: 8)
            u29 (copy, index: 9)
            u36 (copy, index: 10)
            u32 (copy, index: 11)
        ]]
        if UserInputService_upv_2.MouseBehavior ~= Enum.MouseBehavior.Default then
            u38 = false
            u39 = false
            u40 = false
            u41 = false
            u33 = false
            u34 = false
        end
        local v41 = a1.MenuManager.IsOpen("Settings")
        local v42
        if u39 then
            v42 = 0.8
        elseif u38 or v41 then
            v42 = 0.9
        else
            v42 = 1
        end
        u29.BackgroundTransparency = v42
        local v43 = a1.MenuManager.IsOpen("CustomHost")
        if u41 then
            v42 = 0.8
        elseif u40 or v43 then
            v42 = 0.9
        else
            v42 = 1
        end
        u36.BackgroundTransparency = v42
        v42 = (u34 and 0.8) or ((u33 and 0.9) or 1)
        u32.BackgroundTransparency = v42
    end
    UserInputService_upv_2:GetPropertyChangedSignal("MouseBehavior"):Connect(paint)
    local function place()
        --[[
          name: place
          line: 588
          upvalues:
            GuiService_upv_2 (copy, index: 1)
            u28 (copy, index: 2)
            u31 (copy, index: 3)
            u35 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
        ]]
        local TopbarInset_1 = GuiService_upv_2.TopbarInset
        local Height_1 = TopbarInset_1.Height
        local v44 = math.clamp(Height_1 - 14, 28, 44)
        u28.Size = UDim2.fromOffset(v44, v44)
        u28.Position = UDim2.fromOffset(TopbarInset_1.Min.X + 8, math.max(0, (Height_1 - 2) - v44))
        local v45 = (TopbarInset_1.Min.X + 8) + v44 + 12
        u31.Size = UDim2.fromOffset(v44, v44)
        u31.Position = UDim2.fromOffset(v45, math.max(0, (Height_1 - 2) - v44))
        local v46 = ((u31.Visible) and (v45 + (v44 + 12))) or v45
        u35.Size = UDim2.fromOffset(v44, v44)
        u35.Position = UDim2.fromOffset(v46, math.max(0, (Height_1 - 2) - v44))
        local v47 = ((u31.Visible) and (v44 + 12)) or 0
        local v48 = v44 + 8 + v47 + (((u35.Visible) and (v44 + 12)) or 0)
        if UI_upv_1.TopbarReserved == v48 then
            return
        end
        UI_upv_1.TopbarReserved = v48
        UI_upv_1.TopInsetChanged:Fire()
    end
    place()
    GuiService_upv_2:GetPropertyChangedSignal("TopbarInset"):Connect(place)
    local u42 = UI_upv_1.new("TextLabel", {Name = "Text", TextSize = 14, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = Fonts_1.SemiBold, TextColor3 = Color3.fromRGB(247, 247, 248)})
    local tbl_7 = {}
    tbl_7.Name = "Tooltip"
    tbl_7.AnchorPoint = Vector2.new(0.5, 0)
    tbl_7.AutomaticSize = Enum.AutomaticSize.X
    tbl_7.Size = UDim2.fromOffset(0, 30)
    tbl_7.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
    tbl_7.BackgroundTransparency = 0.08
    tbl_7.Visible = false
    tbl_7.ZIndex = 10
    tbl_7[1], tbl_7[2], tbl_7[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.new("UIPadding", {PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)}), u42
    tbl_7.Parent = u27
    local u43 = UI_upv_1.new("Frame", tbl_7)
    u42.ZIndex = 11
    local tbl_upv_8 = {}
    local u44 = nil
    local u45 = false
    local u46 = 0
    local function hideTip(a9)
        --[[
          name: hideTip
          line: 644
          upvalues:
            u44 (ref,  index: 1)
            u46 (ref,  index: 2)
            u45 (ref,  index: 3)
            u43 (copy, index: 4)
        ]]
        if a9 and u44 ~= a9 then
            return
        end
        u46 = u46 + 1
        u44 = nil
        u45 = false
        u43.Visible = false
    end
    local function showTip(a10, a11, a12)
        --[[
          name: showTip
          line: 652
          upvalues:
            u46 (ref, index: 1)
            u44 (ref, index: 2)
            u45 (ref, index: 3)
        ]]
        u46 = u46 + 1
        local _ = u46
        local v49 = a12 == true
        u44 = a10
        u45 = v49
        task.delay(a11, function() end)
    end
    local function tooltip(a13, a14)
        --[[
          name: tooltip
          line: 671
          upvalues:
            tbl_upv_8 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            UserInputService_upv_2 (copy, index: 3)
            u46 (ref,  index: 4)
            u44 (ref,  index: 5)
            u45 (ref,  index: 6)
            u43 (copy, index: 9)
        ]]
        tbl_upv_8[a13] = a14
        a13.MouseEnter:Connect(
            function()
                --[[
                  line: 673
                  upvalues:
                    UI_upv_1 (copy, index: 1)
                    UserInputService_upv_2 (copy, index: 2)
                    a13 (copy, index: 3)
                    u46 (ref,  index: 4)
                    u44 (ref,  index: 5)
                    u45 (ref,  index: 6)
                ]]
                if (UI_upv_1.Touch) or UserInputService_upv_2.MouseBehavior ~= Enum.MouseBehavior.Default then
                    return
                end
                local v50 = a13
                u46 = u46 + 1
                local _ = u46
                u44 = v50
                u45 = false
                task.delay(0.3, function() end)
            end
        )
        a13.MouseLeave:Connect(
            function()
                --[[
                  line: 679
                  upvalues:
                    a13 (copy, index: 1)
                    u44 (ref,  index: 2)
                    u46 (ref,  index: 3)
                    u45 (ref,  index: 4)
                    u43 (copy, index: 5)
                ]]
                if a13 and u44 ~= a13 then
                    return
                end
                u46 = u46 + 1
                u44 = nil
                u45 = false
                u43.Visible = false
            end
        )
        a13.MouseButton1Down:Connect(
            function()
                --[[
                  line: 682
                  upvalues:
                    u46 (ref,  index: 1)
                    u44 (ref,  index: 2)
                    u45 (ref,  index: 3)
                    u43 (copy, index: 4)
                ]]
                u46 = u46 + 1
                u44 = nil
                u45 = false
                u43.Visible = false
            end
        )
        a13.Activated:Connect(
            function()
                --[[
                  line: 685
                  upvalues:
                    u46 (ref,  index: 1)
                    u44 (ref,  index: 2)
                    u45 (ref,  index: 3)
                    u43 (copy, index: 4)
                ]]
                u46 = u46 + 1
                u44 = nil
                u45 = false
                u43.Visible = false
            end
        )
        a13:GetPropertyChangedSignal("Visible"):Connect(
            function()
                --[[
                  line: 688
                  upvalues:
                    a13 (copy, index: 1)
                    u44 (ref,  index: 2)
                    u46 (ref,  index: 3)
                    u45 (ref,  index: 4)
                    u43 (copy, index: 5)
                ]]
                if not (a13.Visible) then
                    local v51 = a13
                    if not v51 or u44 == v51 then
                        u46 = u46 + 1
                        u44 = nil
                        u45 = false
                        u43.Visible = false
                    end
                end
            end
        )
    end
    tooltip(u28, "Settings")
    tooltip(u31, "What's New")
    tooltip(u35, "Host Menu")
    GuiService_upv_2:GetPropertyChangedSignal("SelectedObject"):Connect(
        function()
            --[[
              line: 697
              upvalues:
                GuiService_upv_2 (copy, index: 1)
                tbl_upv_8 (copy, index: 2)
                u46 (ref,  index: 3)
                u44 (ref,  index: 4)
                u45 (ref,  index: 5)
                u27 (copy, index: 6)
                u42 (copy, index: 7)
                u43 (copy, index: 8)
                TweenService_upv_1 (copy, index: 9)
            ]]
            local SelectedObject_upv_1 = GuiService_upv_2.SelectedObject
            if SelectedObject_upv_1 and tbl_upv_8[SelectedObject_upv_1] then
                u46 = u46 + 1
                local u47 = u46
                u44 = SelectedObject_upv_1
                u45 = true
                task.delay(
                    0.1,
                    function()
                        --[[
                          line: 656
                          upvalues:
                            u47 (copy, index: 1)
                            u46 (ref,  index: 2)
                            SelectedObject_upv_1 (copy, index: 3)
                            u27 (copy, index: 4)
                            u42 (copy, index: 5)
                            tbl_upv_8 (copy, index: 6)
                            u43 (copy, index: 7)
                            TweenService_upv_1 (copy, index: 8)
                        ]]
                        if u47 ~= u46 or not SelectedObject_upv_1.Visible then
                            return
                        end
                        if u27.Enabled then
                            u42.Text = tbl_upv_8[SelectedObject_upv_1]
                            local v52 = SelectedObject_upv_1.Position.X.Offset + SelectedObject_upv_1.Size.X.Offset / 2
                            local v53 = SelectedObject_upv_1.Position.Y.Offset + SelectedObject_upv_1.Size.Y.Offset + 8
                            u43.Position = UDim2.fromOffset(v52, v53 - 4)
                            u43.BackgroundTransparency = 1
                            u42.TextTransparency = 1
                            u43.Visible = true
                            local v54 = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local tbl_9 = {BackgroundTransparency = 0.08}
                            tbl_9.Position = UDim2.fromOffset(v52, v53)
                            TweenService_upv_1:Create(u43, v54, tbl_9):Play()
                            TweenService_upv_1:Create(u42, v54, {TextTransparency = 0}):Play()
                        end
                    end
                )
                return
            end
            if not u45 then
                return
            end
            u46 = u46 + 1
            u44 = nil
            u45 = false
            u43.Visible = false
        end
    )
    UserInputService_upv_2:GetPropertyChangedSignal("MouseBehavior"):Connect(
        function()
            --[[
              line: 705
              upvalues:
                UserInputService_upv_2 (copy, index: 1)
                u46 (ref,  index: 2)
                u44 (ref,  index: 3)
                u45 (ref,  index: 4)
                u43 (copy, index: 5)
            ]]
            if UserInputService_upv_2.MouseBehavior == Enum.MouseBehavior.Default then
                return
            end
            u46 = u46 + 1
            u44 = nil
            u45 = false
            u43.Visible = false
        end
    )
    a1.MenuManager.Changed:Connect(
        function()
            --[[
              line: 710
              upvalues:
                u46 (ref,  index: 1)
                u44 (ref,  index: 2)
                u45 (ref,  index: 3)
                u43 (copy, index: 4)
            ]]
            u46 = u46 + 1
            u44 = nil
            u45 = false
            u43.Visible = false
        end
    )
    u28.MouseEnter:Connect(
        function()
            --[[
              line: 714
              upvalues:
                u38 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u38 = true
            paint()
        end
    )
    u28.MouseLeave:Connect(
        function()
            --[[
              line: 718
              upvalues:
                u38 (ref,  index: 1)
                u39 (ref,  index: 2)
                paint (copy, index: 3)
            ]]
            u38 = false
            u39 = false
            paint()
        end
    )
    u28.MouseButton1Down:Connect(
        function()
            --[[
              line: 722
              upvalues:
                u39 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u39 = true
            paint()
        end
    )
    u28.MouseButton1Up:Connect(
        function()
            --[[
              line: 726
              upvalues:
                u39 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u39 = false
            paint()
        end
    )
    u28.Activated:Connect(
        function()
            --[[
              line: 730
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Sounds.Play("Click")
            a1.MenuManager.Toggle("Settings")
        end
    )
    u31.MouseEnter:Connect(
        function()
            --[[
              line: 734
              upvalues:
                u33 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u33 = true
            paint()
        end
    )
    u31.MouseLeave:Connect(
        function()
            --[[
              line: 738
              upvalues:
                u33 (ref,  index: 1)
                u34 (ref,  index: 2)
                paint (copy, index: 3)
            ]]
            u33 = false
            u34 = false
            paint()
        end
    )
    u31.MouseButton1Down:Connect(
        function()
            --[[
              line: 742
              upvalues:
                u34 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u34 = true
            paint()
        end
    )
    u31.MouseButton1Up:Connect(
        function()
            --[[
              line: 746
              upvalues:
                u34 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u34 = false
            paint()
        end
    )
    u31.Activated:Connect(
        function()
            --[[
              line: 750
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Sounds.Play("Click")
            a1.MenuManager.Open("News")
        end
    )
    u35.MouseEnter:Connect(
        function()
            --[[
              line: 754
              upvalues:
                u40 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u40 = true
            paint()
        end
    )
    u35.MouseLeave:Connect(
        function()
            --[[
              line: 758
              upvalues:
                u40 (ref,  index: 1)
                u41 (ref,  index: 2)
                paint (copy, index: 3)
            ]]
            u40 = false
            u41 = false
            paint()
        end
    )
    u35.MouseButton1Down:Connect(
        function()
            --[[
              line: 762
              upvalues:
                u41 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u41 = true
            paint()
        end
    )
    u35.MouseButton1Up:Connect(
        function()
            --[[
              line: 766
              upvalues:
                u41 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            u41 = false
            paint()
        end
    )
    u35.Activated:Connect(
        function()
            --[[
              line: 770
              upvalues:
                a1 (copy, index: 1)
                u37 (copy, index: 2)
            ]]
            a1.Sounds.Play("Click")
            u37:Fire()
        end
    )
    a1.MenuManager.Changed:Connect(paint)
    local tbl_upv_10 = {}
    tbl_upv_10.Button = u28
    tbl_upv_10.HostButton = u35
    tbl_upv_10.HostActivated = u37
    function tbl_upv_10.SetHostVisible(a15)
        --[[
          name: SetHostVisible
          line: 780
          upvalues:
            u35 (copy, index: 1)
            place (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        if u35.Visible == a15 then
            return
        end
        u35.Visible = a15
        place()
        if not a15 then
            return
        end
        UI_upv_1.Pop(u35, 0.6)
    end
    tbl_upv_10.NewsButton = u31
    function tbl_upv_10.SetNewsVisible(a16)
        --[[
          name: SetNewsVisible
          line: 791
          upvalues:
            u31 (copy, index: 1)
            place (copy, index: 2)
        ]]
        if u31.Visible == a16 then
            return
        end
        u31.Visible = a16
        place()
    end
    function tbl_upv_10.Last()
        --[[
          name: Last
          line: 798
          upvalues:
            u35 (copy, index: 1)
            u31 (copy, index: 2)
            u28 (copy, index: 3)
        ]]
        if u35.Visible then
            return u35
        elseif u31.Visible then
            return u31
        else
            return u28
        end
    end
    function tbl_upv_10.SetHidden(a17, a18)
        --[[
          name: SetHidden
          line: 802
          upvalues:
            tbl_upv_6 (copy, index: 1)
            u27 (copy, index: 2)
        ]]
        tbl_upv_6[a17] = (a18 and true) or nil
        u27.Enabled = next(tbl_upv_6) == nil
    end
    a1.TopbarSettings = tbl_upv_10
    local u48 = UI_upv_1.Panel({Name = "TrainingBanner", Visible = false, BackgroundTransparency = 0.15, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(440, 64), Trim = Colors_upv_1.Accent, Parent = u1})
    local u49 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Sword, {Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 18, 0.5, 2), Size = UDim2.fromOffset(34, 34), ImageColor3 = Colors_upv_1.Accent, Parent = u48})
    local u50 = UI_upv_1.new("TextLabel", {Text = "TRAINING", Name = "Title", TextSize = 28, Position = UDim2.fromOffset(66, 8), Size = UDim2.new(1, -82, 0, 30), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Left, Parent = u48})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = u50
    local u51 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", TextSize = 15, Position = UDim2.fromOffset(66, 38), Size = UDim2.new(1, -82, 0, 18), FontFace = Fonts_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u48})
    local u52 = UI_upv_1.Panel({StrokeThickness = 2, StrokeTransparency = 0.3, Name = "Matchmaking", Visible = false, BackgroundTransparency = 0.06, Size = UDim2.fromOffset(300, 96), Radius = UDim.new(0, 16), StrokeColor = Colors_upv_1.Accent, Parent = u1})
    local u53 = u52:FindFirstChildOfClass("UIGradient")
    local u54 = u52:FindFirstChildOfClass("UIStroke")
    local u55 = UI_upv_1.new("TextLabel", {Text = "FINDING MATCH", Name = "Title", TextSize = 24, Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -120, 0, 28), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u52})
    local u56 = UI_upv_1.new("TextLabel", {Text = "0:00", Name = "Timer", TextSize = 30, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -18, 0, 9), Size = UDim2.fromOffset(96, 34), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u52})
    local u57 = UI_upv_1.new("TextLabel", {Visible = false, Text = "MATCH FOUND", Name = "Found", TextSize = 36, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.new(1, -24, 0, 40), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Text, Parent = u52})
    local u58 = UI_upv_1.new("Frame", {Name = "Seats", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 18, 1, -20), Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u52})
    local u59 = Color3.fromRGB(58, 63, 78)
    local tbl_upv_11 = {}
    for n_1 = 1, 6 do
        tbl_upv_11[n_1] = UI_upv_1.new("Frame", {Name = "Seat" .. n_1, Size = UDim2.fromOffset(16, 16), BackgroundColor3 = u59, LayoutOrder = n_1, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u58})
    end
    local u60 = UI_upv_1.Pill("1V1", Colors_upv_1.Accent, {LayoutOrder = 7, Name = "Mode", PadX = 9, Height = 22, TextSize = 15, Parent = u58})
    u60.Visible = false
    local u61 = UI_upv_1.new("TextLabel", {Text = "1/6 PLAYERS", Name = "Count", TextSize = 18, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -18, 1, -16), Size = UDim2.fromOffset(140, 24), FontFace = Fonts_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u52})
    local u62 = UI_upv_1.new("Frame", {Name = "Scan", ClipsDescendants = true, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -32, 0, 3), Parent = u52})
    local u63 = UI_upv_1.new("Frame", {Name = "Bar", BackgroundColor3 = Colors_upv_1.Accent, Size = UDim2.fromScale(0.3, 1), Position = UDim2.fromScale(-0.3, 0), [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u62})
    local u64 = UI_upv_1.Button({Visible = false, Text = "CANCEL", Name = "Cancel", Sound = false, Style = "Dark", TextSize = 22, Size = UDim2.fromOffset(300, 54), Icon = UI_upv_1.Icon("cross", 18, Colors_upv_1.TextDim), Parent = u1})
    local u65 = UI_upv_1.new("Frame", {ZIndex = 4, Name = "Pad", Size = UDim2.fromScale(1, 1), Parent = u64.Face})
    UI_upv_1.PadActionCap("Play", {Height = 24, ZIndex = 4, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Parent = u65})
    local tbl_upv_12 = {}
    local tbl_upv_13 = {}
    local u66 = Vector2.zero
    local u67 = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local function homeRect(a19, a20, a21, a22)
        --[[
          name: homeRect
          line: 991
        ]]
        local v56 = a19.AbsoluteSize / a21
        local v57 = (a20.X.Scale * a22.X) + a20.X.Offset - a19.AnchorPoint.X * v56.X
        local v58 = (a20.Y.Scale * a22.Y) + a20.Y.Offset - a19.AnchorPoint.Y * v56.Y
        return Rect.new(v57, v58, v57 + v56.X, v58 + v56.Y)
    end
    local function applyShift(a23)
        --[[
          name: applyShift
          line: 1041
          upvalues:
            tbl_upv_12 (copy, index: 1)
            u66 (ref,  index: 2)
            tbl_upv_13 (copy, index: 3)
            u1 (copy, index: 4)
            TweenService_upv_1 (copy, index: 5)
            u67 (copy, index: 6)
        ]]
        for key_1, value_3 in tbl_upv_12 do
            local v59 = value_3 + UDim2.fromOffset(u66.X, u66.Y)
            local v60 = tbl_upv_13[key_1]
            if v60 then
                v60:Cancel()
                tbl_upv_13[key_1] = nil
            end
            if not (a23) or not (key_1.Visible) then
                key_1.Position = v59
                continue
            end
            if u1.Visible then
                local v61 = TweenService_upv_1:Create(key_1, u67, {Position = v59})
                tbl_upv_13[key_1] = v61
                v61:Play()
            else
                key_1.Position = v59
            end
        end
    end
    local function computeShift()
        --[[
          name: computeShift
          line: 998
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            tbl_upv_12 (copy, index: 3)
            homeRect (copy, index: 4)
            u23 (copy, index: 5)
            u52 (copy, index: 6)
            u64 (copy, index: 7)
        ]]
        local v62 = UI_upv_1.ChatRectIn(u1)
        if not v62 or not u1.Visible or UI_upv_1.Compact then
            return Vector2.zero
        end
        local v63 = math.max(UI_upv_1.Scale, 0.01)
        local v64 = u1.AbsoluteSize / v63
        local v65 = nil
        for key_2, value_4 in tbl_upv_12 do
            if not (key_2.Visible) or not (key_2.Parent) then
                continue
            end
            local v66 = homeRect(key_2, value_4, v63, v64)
            if v65 then
                v65 = Rect.new(math.min(v65.Min.X, v66.Min.X), math.min(v65.Min.Y, v66.Min.Y), math.max(v65.Max.X, v66.Max.X), math.max(v65.Max.Y, v66.Max.Y))
            else
                v65 = v66
            end
        end
        if not v65 or v62.Max.X + 12 <= v65.Min.X or v65.Max.X + 12 <= v62.Min.X or v62.Max.Y + 12 <= v65.Min.Y or v65.Max.Y + 12 <= v62.Min.Y then
            return Vector2.zero
        end
        local v68 = v64.X - 16
        for _, value_5 in {u23.Instance, u52, u64.Instance} do
            if value_5.Visible then
                v68 = math.min(v68, ((value_5.AbsolutePosition.X - u1.AbsolutePosition.X) / v63) - 12)
            end
        end
        local v69 = v62.Max.X + 12 - v65.Min.X
        if v65.Max.X + v69 <= v68 then
            return Vector2.new(v69, 0)
        end
        local v70 = ((UI_upv_1.Touch) and (v64.Y * 0.62)) or (v64.Y - 16)
        local v71 = v62.Max.Y + 12 - v65.Min.Y
        if v65.Max.Y + v71 <= v70 then
            return Vector2.new(0, v71)
        end
        return Vector2.new(math.max(0, v68 - v65.Max.X), 0)
    end
    local function redodge(a24)
        --[[
          name: redodge
          line: 1059
          upvalues:
            computeShift (copy, index: 1)
            u66 (ref,  index: 2)
            applyShift (copy, index: 3)
        ]]
        local v72 = computeShift()
        if not ((v72 - u66).Magnitude > 1) then
            return
        end
        u66 = v72
        applyShift(a24)
    end
    local u68 = false
    local function queueRedodge()
        --[[
          name: queueRedodge
          line: 1068
          upvalues:
            u68 (ref, index: 1)
        ]]
        if u68 then
            return
        end
        u68 = true
        task.defer(function() end)
    end
    local function place_2(a25, a26)
        --[[
          name: place
          line: 1080
          upvalues:
            tbl_upv_12 (copy, index: 1)
            tbl_upv_13 (copy, index: 2)
            u66 (ref,  index: 3)
            u68 (ref,  index: 4)
        ]]
        tbl_upv_12[a25] = a26
        local v73 = tbl_upv_13[a25]
        if v73 then
            v73:Cancel()
            tbl_upv_13[a25] = nil
        end
        a25.Position = a26 + UDim2.fromOffset(u66.X, u66.Y)
        if u68 then
            return
        end
        u68 = true
        task.defer(function() end)
    end
    local u69 = nil
    local u70 = Signal_upv_1.new()
    local function Shift()
        --[[
          name: Shift
          line: 1152
          upvalues:
            u66 (ref, index: 1)
        ]]
        return u66
    end
    local function Row()
        --[[
          name: Row
          line: 1155
          upvalues:
            u69 (ref, index: 1)
        ]]
        return u69
    end
    a1.LobbyColumn = {Place = place_2, Shift = Shift, Row = Row, RowChanged = u70}
    UI_upv_1.ChatChanged:Connect(queueRedodge)
    u1:GetPropertyChangedSignal("Visible"):Connect(
        function()
            --[[
              line: 1161
              upvalues:
                computeShift (copy, index: 1)
                u66 (ref,  index: 2)
                tbl_upv_12 (copy, index: 3)
                tbl_upv_13 (copy, index: 4)
            ]]
            local v74 = computeShift()
            if not ((v74 - u66).Magnitude > 1) then
                return
            end
            u66 = v74
            for key_3, value_6 in tbl_upv_12 do
                local v75 = value_6 + UDim2.fromOffset(u66.X, u66.Y)
                local v76 = tbl_upv_13[key_3]
                if v76 then
                    v76:Cancel()
                    tbl_upv_13[key_3] = nil
                end
                key_3.Position = v75
            end
        end
    )
    local u71 = "idle"
    local function phoneRow()
        --[[
          name: phoneRow
          line: 1102
          upvalues:
            UI_upv_1 (copy, index: 1)
            u1 (copy, index: 2)
            tbl_upv_10 (copy, index: 3)
            GuiService_upv_1 (copy, index: 4)
        ]]
        local v77 = math.max(UI_upv_1.Scale, 0.01)
        local v78 = u1.AbsoluteSize / v77
        local AbsolutePosition_1 = u1.AbsolutePosition
        local v79 = tbl_upv_10.Last()
        local v80 = v79:FindFirstAncestorOfClass("ScreenGui")
        local v81, v82, v83
        if UI_upv_1.DebugDevice or not v80 then
            local v84 = UI_upv_1.TopInset() - 4
            local Button_2 = tbl_upv_10.Button
            local v85
            if v79 ~= Button_2 and v79.AbsoluteSize.X > 0 and Button_2.AbsoluteSize.X > 0 then
                v85 = math.max(0, (v79.AbsolutePosition.X + v79.AbsoluteSize.X) - (Button_2.AbsolutePosition.X + Button_2.AbsoluteSize.X)) / v77
            else
                v85 = 0
            end
            v81, v82, v83 = math.floor((v84 * 6) + v85), math.floor(v84 / 2), v78.X - 16
        elseif v79.AbsoluteSize.X < 1 then
            local v84 = UI_upv_1.TopInset() - 4
            local Button_2 = tbl_upv_10.Button
            local v85
            if v79 ~= Button_2 and v79.AbsoluteSize.X > 0 and Button_2.AbsoluteSize.X > 0 then
                v85 = math.max(0, (v79.AbsolutePosition.X + v79.AbsoluteSize.X) - (Button_2.AbsolutePosition.X + Button_2.AbsoluteSize.X)) / v77
            else
                v85 = 0
            end
            v81, v82, v83 = math.floor((v84 * 6) + v85), math.floor(v84 / 2), v78.X - 16
        else
            v81 = (v79.AbsolutePosition.X + v79.AbsoluteSize.X - AbsolutePosition_1.X) / v77 + 10
            v82 = (v79.AbsolutePosition.Y + v79.AbsoluteSize.Y / 2 - AbsolutePosition_1.Y) / v77
            local _ = GuiService_upv_1.TopbarInset
            v83 = GuiService_upv_1.TopbarInset.Width > 0 and (v80.AbsolutePosition.X + GuiService_upv_1.TopbarInset.Max.X - AbsolutePosition_1.X) / v77 - 8 or v78.X - 16
        end
        local v86 = math.floor(v81)
        local v87 = math.floor(math.max(v82, 38))
        local v88 = math.clamp((((math.min(v83, v78.X - 16) - v86) - 280) - 20) / 440, 0.7, 1)
        local v89 = v86 + 280 + 10
        local v90 = math.floor(v88 * 196)
        local tbl_14 = {chipW = 280, restoreW = 254, h = 72}
        tbl_14.x = v86
        tbl_14.y = v87
        tbl_14.loadoutX = v89
        tbl_14.loadoutW = v90
        tbl_14.cardX = (v89 + v90) + 10
        tbl_14.cardW = math.floor(v88 * 244)
        tbl_14.restoreX = math.max(v86, math.min(v89, ((((v78.X - 16) - 272) - 44) - 10) - 254))
        tbl_14.restoreY = (v87 + 36) + 8
        return tbl_14
    end
    local function layout()
        --[[
          name: layout
          line: 1167
          upvalues:
            UI_upv_1 (copy, index: 1)
            phoneRow (copy, index: 2)
            u69 (ref,  index: 3)
            u2 (copy, index: 4)
            u15 (ref,  index: 5)
            layoutChip (copy, index: 6)
            tbl_upv_12 (copy, index: 7)
            tbl_upv_13 (copy, index: 8)
            u66 (ref,  index: 9)
            u68 (ref,  index: 10)
            computeShift (copy, index: 11)
            applyShift (copy, index: 12)
            Button_upv_1 (copy, index: 13)
            u23 (copy, index: 14)
            u48 (copy, index: 15)
            u52 (copy, index: 16)
            u64 (copy, index: 17)
            u55 (copy, index: 18)
            u56 (copy, index: 19)
            u57 (copy, index: 20)
            u61 (copy, index: 21)
            u58 (copy, index: 22)
            tbl_upv_11 (copy, index: 23)
            u71 (ref,  index: 24)
        ]]
        local v91 = UI_upv_1.TopInset()
        local v92, v93, v94, v95 = nil, nil, nil, nil
        if UI_upv_1.Compact then
            local v96 = phoneRow()
            u69 = v96
            u2.AnchorPoint = Vector2.new(0, 0.5)
            u2.Size = UDim2.fromOffset(v96.chipW, v96.h)
            u15 = true
            layoutChip(true)
            local v97 = u2
            local v98 = UDim2.fromOffset(v96.x, v96.y)
            tbl_upv_12[v97] = v98
            v92 = tbl_upv_13[v97]
            if v92 then
                v92:Cancel()
                tbl_upv_13[v97] = nil
            end
            v97.Position = v98 + UDim2.fromOffset(u66.X, u66.Y)
            if not (u68) then
                u68 = true
                task.defer(function() end)
            end
            Button_upv_1.Instance.AnchorPoint = Vector2.new(0, 0.5)
            Button_upv_1.Instance.Size = UDim2.fromOffset(v96.loadoutW, v96.h)
            local Instance_1 = Button_upv_1.Instance
            local v99 = UDim2.fromOffset(v96.loadoutX, v96.y)
            tbl_upv_12[Instance_1] = v99
            v93 = tbl_upv_13[Instance_1]
            if v93 then
                v93:Cancel()
                tbl_upv_13[Instance_1] = nil
            end
            Instance_1.Position = v99 + UDim2.fromOffset(u66.X, u66.Y)
            if not (u68) then
                u68 = true
                task.defer(function() end)
            end
            local v100 = math.max(v91, (v96.y + (v96.h / 2)) + 8)
            u23.Instance.AnchorPoint = Vector2.new(1, 0)
            u23.Instance.Position = UDim2.new(1, -16, 0, v100)
            u23.Instance.Size = UDim2.fromOffset(240, 84)
            u48.Position = UDim2.new(0.5, 0, 0, v91)
            u52.AnchorPoint = Vector2.new(1, 0)
            u52.Position = UDim2.new(1, -16, 0, v100)
            u52.Size = UDim2.fromOffset(272, 84)
            u64.Instance.AnchorPoint = Vector2.new(1, 0)
            u64.Instance.Position = UDim2.new(1, -16, 0, v100 + 94)
            u64.Instance.Size = UDim2.fromOffset(272, 52)
            u55.TextSize = 20
            u56.TextSize = 26
            u57.TextSize = 30
            u61.TextSize = 17
            u55.Position = UDim2.fromOffset(16, 11)
            u55.Size = UDim2.new(1, -96, 0, 28)
            u56.Position = UDim2.new(1, -16, 0, 7)
            u56.Size = UDim2.fromOffset(76, 34)
            u58.Position = UDim2.new(0, 16, 1, -18)
            u61.Position = UDim2.new(1, -16, 1, -14)
            for _, value_7 in tbl_upv_11 do
                value_7.Size = UDim2.fromOffset(14, 14)
            end
            local v101 = u58:FindFirstChildOfClass("UIListLayout")
            v101.Padding = UDim.new(0, 5)
        else
            u69 = nil
            u2.AnchorPoint = Vector2.new(0, 1)
            u2.Size = UDim2.fromOffset(340, 78)
            u15 = false
            layoutChip(false)
            local v102 = u2
            local v103 = UDim2.new(0, 24, 1, -24)
            tbl_upv_12[v102] = v103
            v94 = tbl_upv_13[v102]
            if v94 then
                v94:Cancel()
                tbl_upv_13[v102] = nil
            end
            v102.Position = v103 + UDim2.fromOffset(u66.X, u66.Y)
            if not (u68) then
                u68 = true
                task.defer(function() end)
            end
            Button_upv_1.Instance.AnchorPoint = Vector2.new(0, 1)
            Button_upv_1.Instance.Size = UDim2.fromOffset(340, 66)
            local Instance_2 = Button_upv_1.Instance
            local v104 = UDim2.new(0, 24, 1, -114)
            tbl_upv_12[Instance_2] = v104
            v95 = tbl_upv_13[Instance_2]
            if v95 then
                v95:Cancel()
                tbl_upv_13[Instance_2] = nil
            end
            Instance_2.Position = v104 + UDim2.fromOffset(u66.X, u66.Y)
            if not (u68) then
                u68 = true
                task.defer(
                    function()
                        --[[
                          line: 1073
                          upvalues:
                            u68 (ref,  index: 1)
                            computeShift (copy, index: 2)
                            u66 (ref,  index: 3)
                            applyShift (copy, index: 4)
                        ]]
                        u68 = false
                        local v105 = computeShift()
                        if not ((v105 - u66).Magnitude > 1) then
                            return
                        end
                        u66 = v105
                        applyShift(true)
                    end
                )
            end
            u23.Instance.AnchorPoint = Vector2.new(1, 1)
            u23.Instance.Position = UDim2.new(1, -28, 1, -44)
            u23.Instance.Size = UDim2.fromOffset(300, 96)
            u48.Position = UDim2.new(0.5, 0, 0, v91)
            u52.AnchorPoint = Vector2.new(1, 1)
            u52.Position = UDim2.new(1, -28, 1, ((u71 ~= "search") and -44) or -104)
            u52.Size = UDim2.fromOffset(300, 96)
            u64.Instance.AnchorPoint = Vector2.new(1, 1)
            u64.Instance.Position = UDim2.new(1, -28, 1, -40)
            u64.Instance.Size = UDim2.fromOffset(300, 54)
            u55.TextSize = 24
            u56.TextSize = 30
            u57.TextSize = 36
            u61.TextSize = 18
            u55.Position = UDim2.fromOffset(18, 12)
            u55.Size = UDim2.new(1, -120, 0, 28)
            u56.Position = UDim2.new(1, -18, 0, 9)
            u56.Size = UDim2.fromOffset(96, 34)
            u58.Position = UDim2.new(0, 18, 1, -20)
            u61.Position = UDim2.new(1, -18, 1, -16)
            for _, value_8 in tbl_upv_11 do
                value_8.Size = UDim2.fromOffset(16, 16)
            end
            local v106 = u58:FindFirstChildOfClass("UIListLayout")
            v106.Padding = UDim.new(0, 6)
        end
    end
    local u72 = false
    local function relayout()
        --[[
          name: relayout
          line: 1238
          upvalues:
            layout (copy, index: 1)
            u70 (copy, index: 2)
            u69 (ref,  index: 3)
        ]]
        layout()
        u70:Fire(u69)
    end
    local function queueLayout()
        --[[
          name: queueLayout
          line: 1242
          upvalues:
            u72 (ref,  index: 1)
            layout (copy, index: 2)
            u70 (copy, index: 3)
            u69 (ref,  index: 4)
        ]]
        if u72 then
            return
        end
        u72 = true
        task.defer(
            function()
                --[[
                  line: 1247
                  upvalues:
                    u72 (ref,  index: 1)
                    layout (copy, index: 2)
                    u70 (copy, index: 3)
                    u69 (ref,  index: 4)
                ]]
                u72 = false
                layout()
                u70:Fire(u69)
            end
        )
    end
    layout()
    u70:Fire(u69)
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
        a1.ToastAvoid("TrainingBanner", u48)
    end
    local u73 = State_upv_1.Level()
    local function refreshProfile()
        --[[
          name: refreshProfile
          line: 1269
          upvalues:
            State_upv_1 (copy, index: 1)
            u11 (copy, index: 2)
            u73 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            u8 (copy, index: 5)
            a1 (copy, index: 6)
            u10 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
        ]]
        local v107 = State_upv_1.Level()
        local v108 = State_upv_1.Xp()
        local v109 = State_upv_1.XpToNext()
        u11.Text = "LV " .. tostring(v107)
        if u73 < v107 then
            UI_upv_1.Pop(u8, 1.5)
            a1.Sounds.Play("LevelUp")
        end
        u73 = v107
        local Tween_3 = UI_upv_1.Tween
        local Slow_1 = Theme_upv_1.Tween.Slow
        local tbl_15 = {Value = 0}
        tbl_15.Value = not (v109 > 0) and 0 or math.clamp(v108 / v109, 0, 1)
        Tween_3(u10, Slow_1, tbl_15)
    end
    refreshProfile()
    State_upv_1.ProfileChanged:Connect(refreshProfile)
    State_upv_1.AttrChanged:Connect(
        function(a27)
            --[[
              line: 1283
              upvalues:
                refreshProfile (copy, index: 1)
            ]]
            if a27 ~= "Level" and a27 ~= "XP" then
                return
            end
            refreshProfile()
        end
    )
    local tbl_upv_16 = {}
    local u74 = false
    local u75 = "3v3"
    local u76 = 0
    local u77 = 0
    local u78 = false
    local u79 = 0
    local u80 = false
    local function attrQueued()
        --[[
          name: attrQueued
          line: 1302
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v111 = State_upv_1.Get("Queued") == true
        return v111
    end
    local function wantMode()
        --[[
          name: wantMode
          line: 1305
          upvalues:
            State_upv_1 (copy, index: 1)
            u78 (ref,  index: 2)
            u74 (ref,  index: 3)
        ]]
        if State_upv_1.InMatch() or u78 then
            return "idle"
        end
        if State_upv_1.Get("QueueFound") == true then
            local v112 = State_upv_1.Get("Queued") == true
            if not (v112) and not (u74) then
                local v113 = State_upv_1.Get("Queued") == true
                if not (v113) and not (u74) then
                    return "idle"
                end
                return "search"
            end
            return "found"
        end
        local v113 = State_upv_1.Get("Queued") == true
        if not (v113) and not (u74) then
            return "idle"
        end
        return "search"
    end
    local function searchMode()
        --[[
          name: searchMode
          line: 1321
          upvalues:
            State_upv_1 (copy, index: 1)
            u75 (ref,  index: 2)
        ]]
        local v114 = State_upv_1.Get("QueueMode")
        local v115 = State_upv_1.Get("Queued") == true
        if v115 then
            if v114 ~= "1v1" and v114 ~= "3v3" then
                return u75
            end
            return v114
        end
        return u75
    end
    local function seatCount()
        --[[
          name: seatCount
          line: 1328
          upvalues:
            State_upv_1 (copy, index: 1)
            u75 (ref,  index: 2)
        ]]
        local v116 = State_upv_1.Get("QueueMode")
        local v117 = State_upv_1.Get("Queued") == true
        local v118
        if v117 then
            if v116 ~= "1v1" and v116 ~= "3v3" then
                v118 = u75
            else
                v118 = v116
            end
        else
            v118 = u75
        end
        if v118 ~= "1v1" then
            return 6
        end
        return 2
    end
    local function queuedAt()
        --[[
          name: queuedAt
          line: 1331
          upvalues:
            State_upv_1 (copy, index: 1)
            u76 (ref,  index: 2)
        ]]
        local v119 = State_upv_1.Get("QueuedAt")
        local v120 = State_upv_1.Get("Queued") == true
        if v120 and type(v119) == "number" and v119 > 0 then
            return v119
        end
        return u76
    end
    local function seatsFilled(a28, a29)
        --[[
          name: seatsFilled
          line: 1343
          upvalues:
            State_upv_1 (copy, index: 1)
            u75 (ref,  index: 2)
        ]]
        local v127, v129
        local v121 = State_upv_1.Get("QueueFilled")
        local v122 = State_upv_1.Get("QueueMode")
        local v123 = State_upv_1.Get("Queued") == true
        local v124
        if v123 then
            if v122 ~= "1v1" and v122 ~= "3v3" then
                v124 = u75
            else
                v124 = v122
            end
        else
            v124 = u75
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
    local u81 = 0
    local function paintSeats(a30, a31)
        --[[
          name: paintSeats
          line: 1362
          upvalues:
            State_upv_1 (copy, index: 1)
            u75 (ref,  index: 2)
            u60 (copy, index: 3)
            tbl_upv_11 (copy, index: 4)
            u71 (ref,  index: 5)
            Colors_upv_1 (copy, index: 6)
            u59 (copy, index: 7)
            u81 (ref,  index: 8)
            UI_upv_1 (copy, index: 9)
            Theme_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u61 (copy, index: 12)
        ]]
        local v130 = State_upv_1.Get("QueueMode")
        local v131 = State_upv_1.Get("Queued") == true
        local v132
        if v131 then
            if v130 ~= "1v1" and v130 ~= "3v3" then
                v132 = u75
            else
                v132 = v130
            end
        else
            v132 = u75
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
        u60.Visible = v130
        local v134 = nil
        for key_4, value_9 in tbl_upv_11 do
            value_9.Visible = key_4 <= v133
            local v135 = key_4 <= a30
            if u71 == "found" then
                v134 = Colors_upv_1.Text
            elseif v135 then
                v134 = Colors_upv_1.Accent
            else
                v134 = u59
            end
            if not (a31) or not (v135) then
                value_9.BackgroundColor3 = v134
                continue
            end
            if u81 < key_4 then
                value_9.BackgroundColor3 = Colors_upv_1.Text
                UI_upv_1.Tween(value_9, Theme_upv_1.Tween.Smooth, {BackgroundColor3 = v134})
                UI_upv_1.Pop(value_9, 1.8)
            else
                value_9.BackgroundColor3 = v134
            end
        end
        if a31 and u81 < a30 and u71 == "search" then
            a1.Sounds.Play("Tick", {pitch = (a30 * 0.06) + 0.9})
        end
        u81 = a30
        if UI_upv_1.Compact then
            v130 = string.format("%d/%d", a30, v133)
        else
            v130 = string.format("%d/%d PLAYERS", a30, v133)
        end
        u61.Text = v130
    end
    local u82 = nil
    local function setScan(a32)
        --[[
          name: setScan
          line: 1385
          upvalues:
            u82 (ref,  index: 1)
            u63 (copy, index: 2)
            u62 (copy, index: 3)
        ]]
        if not (a32) or u82 then
            if not (a32) and u82 then
                u82:Cancel()
                u82 = nil
            end
        else
            u63.Position = UDim2.fromScale(-0.3, 0)
            local v136 = game:GetService("TweenService"):Create(u63, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, 0.15), {Position = UDim2.fromScale(1, 0)})
            v136:Play()
            u82 = v136
        end
        u62.Visible = a32
    end
    local function paintCard()
        --[[
          name: paintCard
          line: 1402
          upvalues:
            u71 (ref,  index: 1)
            u53 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u54 (copy, index: 4)
            u55 (copy, index: 5)
            u56 (copy, index: 6)
            u57 (copy, index: 7)
            u61 (copy, index: 8)
        ]]
        local v137 = u71 == "found"
        local v138
        if v137 then
            v138 = ColorSequence.new(Color3.fromRGB(64, 168, 255), Color3.fromRGB(28, 132, 246))
        else
            v138 = ColorSequence.new(Colors_upv_1.Panel, Colors_upv_1.PanelLo)
        end
        u53.Color = v138
        local v139
        if v137 then
            v139 = Color3.fromRGB(150, 210, 255)
        else
            v139 = Colors_upv_1.Accent
        end
        u54.Color = v139
        u54.Transparency = (v137 and 0.4) or 0.3
        u55.Visible = not v137
        u56.Visible = not v137
        u57.Visible = v137
        local v140
        if v137 then
            v140 = Colors_upv_1.Text
        else
            v140 = Colors_upv_1.TextDim
        end
        u61.TextColor3 = v140
    end
    local function tick()
        --[[
          name: tick
          line: 1415
          upvalues:
            u71 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            u76 (ref,  index: 3)
            u56 (copy, index: 4)
            seatsFilled (copy, index: 5)
            u81 (ref,  index: 6)
            paintSeats (copy, index: 7)
        ]]
        if u71 == "idle" then
            return
        end
        local v141 = State_upv_1.Get("QueuedAt")
        local v142 = State_upv_1.Get("Queued") == true
        local v143
        if v142 and type(v141) == "number" and v141 > 0 then
            v143 = v141
        else
            v143 = u76
        end
        local v144 = math.max(0, State_upv_1.Now() - v143)
        u56.Text = string.format("%d:%02d", v144 // 60, math.floor(v144) % 60)
        if u71 == "search" then
            local v145 = seatsFilled(v144, math.floor(v143 * 1000) % 2147483647)
            if v145 ~= u81 then
                paintSeats(v145, true)
            end
        end
    end
    local function applyMode(a33)
        --[[
          name: applyMode
          line: 1430
          upvalues:
            State_upv_1 (copy, index: 1)
            u78 (ref,  index: 2)
            u74 (ref,  index: 3)
            u71 (ref,  index: 4)
            layout (copy, index: 5)
            u23 (copy, index: 6)
            tbl_upv_16 (copy, index: 7)
            u52 (copy, index: 8)
            u64 (copy, index: 9)
            setScan (copy, index: 10)
            paintCard (copy, index: 11)
            u81 (ref,  index: 12)
            paintSeats (copy, index: 13)
            UI_upv_1 (copy, index: 14)
            Theme_upv_1 (copy, index: 15)
            tick (copy, index: 16)
            u75 (ref,  index: 17)
            u60 (copy, index: 18)
            tbl_upv_11 (copy, index: 19)
            u59 (copy, index: 20)
            Colors_upv_1 (copy, index: 21)
            u61 (copy, index: 22)
            u57 (copy, index: 23)
            a1 (copy, index: 24)
        ]]
        local v146
        if State_upv_1.InMatch() or u78 then
            v146 = "idle"
        elseif State_upv_1.Get("QueueFound") ~= true then
            local v147 = State_upv_1.Get("Queued") == true
            if v147 or u74 then
                v146 = "search"
            else
                v146 = "idle"
            end
        else
            local v148 = State_upv_1.Get("Queued") == true
            if v148 or u74 then
                v146 = "found"
            else
                local v147 = State_upv_1.Get("Queued") == true
                if v147 or u74 then
                    v146 = "search"
                else
                    v146 = "idle"
                end
            end
        end
        if v146 == u71 then
            return
        end
        local v149 = u71
        u71 = v146
        layout()
        local Instance_3 = u23.Instance
        local v150 = (u71 == "idle") and (next(tbl_upv_16) == nil)
        Instance_3.Visible = v150
        u52.Visible = u71 ~= "idle"
        u64.Instance.Visible = u71 == "search"
        local v150 = u71 == "search"
        setScan(v150)
        paintCard()
        if u71 == "search" then
            if v149 == "idle" then
                u81 = 0
                paintSeats(1, false)
                if a33 then
                    local Position_1 = u52.Position
                    if not (UI_upv_1.Compact) then
                        u52.Position = u23.Instance.Position
                    end
                    UI_upv_1.Pop(u52, 0.92)
                    UI_upv_1.Tween(u52, Theme_upv_1.Tween.Smooth, {Position = Position_1})
                    UI_upv_1.Enter(u64.Instance, Vector2.new(0, 16), 0.08, u64.Instance.Position)
                end
            end
            tick()
        elseif u71 == "found" then
            tick()
            if not (UI_upv_1.Compact) and v149 == "search" then
                u52.Position = UDim2.new(1, -28, 1, -104)
                UI_upv_1.Tween(u52, Theme_upv_1.Tween.Smooth, {Position = u52.Position})
            end
            local v151 = State_upv_1.Get("QueueMode")
            local v152 = State_upv_1.Get("Queued") == true
            local v153
            if v152 then
                if v151 ~= "1v1" and v151 ~= "3v3" then
                    v153 = u75
                else
                    v153 = v151
                end
            else
                v153 = u75
            end
            if v153 ~= "1v1" then
                v150 = 6
            else
                v150 = 2
            end
            u81 = v150
            if v150 == 2 then
                v151 = true
            else
                v151 = false
            end
            u60.Visible = v151
            for key_5, value_upv_10 in tbl_upv_11 do
                value_upv_10.Visible = key_5 <= v150
                if u81 < key_5 then
                    value_upv_10.BackgroundColor3 = u59
                    task.delay(
                        (key_5 - u81) * 0.06,
                        function()
                            --[[
                              line: 1475
                              upvalues:
                                u71 (ref,  index: 1)
                                value_upv_10 (copy, index: 2)
                                Colors_upv_1 (copy, index: 3)
                                UI_upv_1 (copy, index: 4)
                            ]]
                            if u71 ~= "found" then
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
            u61.Text = v151
            UI_upv_1.Pop(u52, 1.12)
            UI_upv_1.Pop(u57, 1.3)
            a1.Sounds.Play("Match_Found")
            if a1.MenuManager.IsOpen() then
                a1.MenuManager.CloseAll()
            end
            a1.MenuManager.EndHudFocus()
        elseif v149 ~= "idle" and a33 and not State_upv_1.InMatch() then
            UI_upv_1.Pop(u23.Instance, 0.92)
        end
    end
    local function queue(a34)
        --[[
          name: queue
          line: 1501
          upvalues:
            u80 (ref,  index: 1)
            u71 (ref,  index: 2)
            tbl_upv_16 (copy, index: 3)
            u75 (ref,  index: 4)
            u74 (ref,  index: 5)
            u76 (ref,  index: 6)
            u77 (ref,  index: 7)
            State_upv_1 (copy, index: 8)
            u78 (ref,  index: 9)
            a1 (copy, index: 10)
            applyMode (copy, index: 11)
        ]]
        if (u80) or u71 ~= "idle" then
            return
        end
        if next(tbl_upv_16) == nil then
            u80 = true
            u75 = ((a34 ~= "1v1") and "3v3") or "1v1"
            local v154 = State_upv_1.Now()
            local v155 = os.clock()
            u74 = true
            u76 = v154
            u77 = v155
            u78 = false
            a1.Sounds.Play("Queue_Join")
            applyMode(true)
            local v156 = a1.QueueAction("Queue", nil, nil, u75)
            u80 = false
            if not (v156) then
                u74 = false
                applyMode(true)
            end
        end
    end
    local function cancel()
        --[[
          name: cancel
          line: 1518
          upvalues:
            u71 (ref,  index: 1)
            u78 (ref,  index: 2)
            u79 (ref,  index: 3)
            u74 (ref,  index: 4)
            a1 (copy, index: 5)
            applyMode (copy, index: 6)
        ]]
        if u71 ~= "search" then
            return
        end
        local v157 = os.clock()
        u78 = true
        u79 = v157
        u74 = false
        a1.Sounds.Play("Queue_Leave")
        applyMode(true)
        if (a1.QueueAction("Cancel")) then
            return
        end
        u78 = false
        applyMode(true)
    end
    local function onPlay()
        --[[
          name: onPlay
          line: 1534
          upvalues:
            u71 (ref,  index: 1)
            tbl_upv_16 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            queue (copy, index: 5)
        ]]
        if u71 ~= "idle" then
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
    u23.Activated:Connect(onPlay)
    u64.Activated:Connect(cancel)
    local function padY()
        --[[
          name: padY
          line: 1548
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
              line: 1551
              upvalues:
                Keybinds_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                u1 (copy, index: 3)
                UserInputService_upv_1 (copy, index: 4)
                State_upv_1 (copy, index: 5)
                u71 (ref,  index: 6)
                cancel (copy, index: 7)
                u23 (copy, index: 8)
                tbl_upv_16 (copy, index: 9)
                queue (copy, index: 10)
                u64 (copy, index: 11)
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
                                if u71 == "search" then
                                    task.spawn(cancel)
                                elseif u71 == "idle" and u23.Instance.Visible and u71 == "idle" then
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
                        if u71 == "search" then
                            task.spawn(cancel)
                        elseif u71 == "idle" and u23.Instance.Visible and u71 == "idle" then
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
                if u64.Instance.Visible then
                    v164 = u64.Instance
                elseif u23.Instance.Visible then
                    v164 = u23.Instance
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
          line: 1588
          upvalues:
            State_upv_1 (copy, index: 1)
            u26 (copy, index: 2)
            u65 (copy, index: 3)
        ]]
        local v166 = State_upv_1.Get("CombatMode") ~= true
        u26.Visible = v166
        u65.Visible = v166
    end
    local v167 = State_upv_1.Get("CombatMode") ~= true
    u26.Visible = v167
    u65.Visible = v167
    State_upv_1.AttrChanged:Connect(
        function(a36)
            --[[
              line: 1594
              upvalues:
                State_upv_1 (copy, index: 1)
                u74 (ref,  index: 2)
                u78 (ref,  index: 3)
                applyMode (copy, index: 4)
                tick (copy, index: 5)
            ]]
            if a36 == "Queued" then
                local v168 = State_upv_1.Get("Queued") == true
                if v168 then
                    u74 = false
                else
                    u78 = false
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
              line: 1607
              upvalues:
                paintSeats (copy, index: 1)
                u81 (ref,  index: 2)
            ]]
            paintSeats(u81, false)
        end
    )
    UI_upv_1.Every(
        u1,
        0.1,
        function()
            --[[
              line: 1610
              upvalues:
                u74 (ref,  index: 1)
                State_upv_1 (copy, index: 2)
                u80 (ref,  index: 3)
                u77 (ref,  index: 4)
                u78 (ref,  index: 5)
                u79 (ref,  index: 6)
                applyMode (copy, index: 7)
                tick (copy, index: 8)
            ]]
            local v169 = nil
            if u74 then
                v169 = State_upv_1.Get("Queued") == true
                if not (v169) and not (u80) and os.clock() - u77 > 3 then
                    u74 = false
                end
            end
            if u78 and os.clock() - u79 > 2 then
                u78 = false
            end
            applyMode(true)
            tick()
        end
    )
    a1.Debug.queue = function(a37, a38)
        --[[
          line: 1622
          upvalues:
            queue (copy, index: 1)
            u71 (ref,  index: 2)
            tbl_upv_16 (copy, index: 3)
            State_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            cancel (copy, index: 6)
            u81 (ref,  index: 7)
            u75 (ref,  index: 8)
            u74 (ref,  index: 9)
            u78 (ref,  index: 10)
        ]]
        if a37 ~= "play" then
            if a37 == "cancel" then
                task.spawn(cancel)
            end
        elseif a38 == "1v1" or a38 == "3v3" then
            task.spawn(queue, a38)
        elseif u71 == "idle" and next(tbl_upv_16) == nil then
            local v170 = State_upv_1.Get("Duel") == true
            if v170 then
                a1.MenuManager.Open("Mode")
            else
                task.spawn(queue, "3v3")
            end
        end
        local tbl_17 = {cancelling = 0, seatCount = 0, searchMode = 0, localQueued = 0}
        tbl_17.mode = u71
        tbl_17.queued = State_upv_1.Get("Queued")
        tbl_17.queuedAt = State_upv_1.Get("QueuedAt")
        tbl_17.found = State_upv_1.Get("QueueFound")
        tbl_17.seats = u81
        local v171 = State_upv_1.Get("QueueMode")
        local v172 = State_upv_1.Get("Queued") == true
        local v173
        if v172 then
            if v171 ~= "1v1" and v171 ~= "3v3" then
                v173 = u75
            else
                v173 = v171
            end
        else
            v173 = u75
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
                v174 = u75
            else
                v174 = v175
            end
        else
            v174 = u75
        end
        tbl_17.searchMode = v174
        tbl_17.localQueued = u74
        tbl_17.cancelling = u78
        return tbl_17
    end
    local function inTraining()
        --[[
          name: inTraining
          line: 1639
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v177 = (State_upv_1.Get("CombatMode") == true) and (not State_upv_1.InMatch())
        return v177
    end
    local u83 = (State_upv_1.Get("CombatMode") == true) and (not State_upv_1.InMatch())
    local u84 = 0
    local function showZoneBanner(a39)
        --[[
          name: showZoneBanner
          line: 1644
          upvalues:
            u84 (ref,  index: 1)
            u50 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u51 (copy, index: 4)
            u49 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u48 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        u84 = u84 + 1
        local u85 = u84
        u50.Text = (a39 and "TRAINING") or "LEFT TRAINING"
        local v178
        if a39 then
            v178 = Colors_upv_1.Accent
        else
            v178 = Colors_upv_1.Text
        end
        u50.TextColor3 = v178
        u51.Text = (a39 and "COMBAT MODE  \194\183  WEAPONS OUT") or "WEAPONS STOWED"
        local v179
        if a39 then
            v179 = Colors_upv_1.Accent
        else
            v179 = Colors_upv_1.TextDim
        end
        u49.ImageColor3 = v179
        UI_upv_1.Unfade(u48)
        u48.Visible = true
        UI_upv_1.Enter(u48, Vector2.new(0, -16))
        UI_upv_1.Pop(u49, 0.5)
        a1.Sounds.Play((a39 and "Select") or "Close")
        task.delay(
            (a39 and 2.6) or 1.8,
            function()
                --[[
                  line: 1656
                  upvalues:
                    u85 (copy, index: 1)
                    u84 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    u48 (copy, index: 4)
                ]]
                if u85 ~= u84 then
                    return
                end
                UI_upv_1.FadeOut(u48)
                task.delay(
                    0.3,
                    function()
                        --[[
                          line: 1661
                          upvalues:
                            u85 (copy, index: 1)
                            u84 (ref,  index: 2)
                            u48 (copy, index: 3)
                            UI_upv_1 (copy, index: 4)
                        ]]
                        if u85 ~= u84 then
                            return
                        end
                        u48.Visible = false
                        UI_upv_1.Unfade(u48)
                    end
                )
            end
        )
    end
    a1.Debug.trainingBanner = function(a40)
        --[[
          line: 1669
          upvalues:
            showZoneBanner (copy, index: 1)
        ]]
        showZoneBanner(a40 ~= false)
        return true
    end
    State_upv_1.AttrChanged:Connect(
        function(a41)
            --[[
              line: 1673
              upvalues:
                State_upv_1 (copy, index: 1)
                u26 (copy, index: 2)
                u65 (copy, index: 3)
                u83 (ref,  index: 4)
                showZoneBanner (copy, index: 5)
            ]]
            if a41 ~= "CombatMode" and a41 ~= "State" then
                return
            end
            local v180 = State_upv_1.Get("CombatMode") ~= true
            u26.Visible = v180
            u65.Visible = v180
            local v181 = (State_upv_1.Get("CombatMode") == true) and (not State_upv_1.InMatch())
            if v181 == u83 then
                return
            end
            u83 = v181
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
          line: 1688
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
          line: 1709
          upvalues:
            tbl_upv_16 (copy, index: 1)
            u23 (copy, index: 2)
            u71 (ref,  index: 3)
        ]]
        tbl_upv_16[a42] = (a43 and true) or nil
        local Instance_4 = u23.Instance
        Instance_4.Visible = u71 == "idle" and next(tbl_upv_16) == nil
    end
    local function CanPlay()
        --[[
          name: CanPlay
          line: 1719
          upvalues:
            u71 (ref,  index: 1)
            tbl_upv_16 (copy, index: 2)
        ]]
        local v185 = (u71 == "idle") and (next(tbl_upv_16) == nil)
        return v185
    end
    local function Queue(a44)
        --[[
          name: Queue
          line: 1715
          upvalues:
            queue (copy, index: 1)
        ]]
        task.spawn(queue, a44)
    end
    local function duelOn()
        --[[
          name: duelOn
          line: 396
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v186 = State_upv_1.Get("Duel") == true
        return v186
    end
    a1.LobbyHud = {Root = u1, PlayButton = u23, Chip = u2, StreakSlot = u4, SetPlayHidden = SetPlayHidden, Queue = Queue, DuelOn = duelOn, CanPlay = CanPlay}
end
return tbl_1