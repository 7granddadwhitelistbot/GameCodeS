local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local MatchPrefs_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("MatchPrefs"))
local tbl_1 = {}
local u1 = Color3.fromRGB(142, 149, 166)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 24
      upvalues:
        Players_upv_1 (copy, index: 1)
        MatchPrefs_upv_1 (copy, index: 2)
        u1 (copy, index: 3)
        GuiService_upv_1 (copy, index: 4)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_1.Colors
    local Fonts_upv_1 = Theme_1.Fonts
    local fromOffset_upv_1 = UDim2.fromOffset
    local SettingsStore_upv_1 = require(script.Parent.Parent:WaitForChild("SettingsStore"))
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u2 = false
    function a1.PremiumTestOn()
        --[[
          name: PremiumTestOn
          line: 32
          upvalues:
            u2 (ref, index: 1)
        ]]
        return u2
    end
    function a1.PremiumTestToggle()
        --[[
          name: PremiumTestToggle
          line: 35
          upvalues:
            u2 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        local v1 = not u2
        if not a1.QueueAction((v1 and "PremiumTestOn") or "PremiumTestOff") then
            return
        end
        u2 = v1
    end
    local LobbyHud_upv_1 = a1.LobbyHud
    if not LobbyHud_upv_1 or not LobbyHud_upv_1.PlayButton then
        return
    end
    local Instance_upv_1 = LobbyHud_upv_1.PlayButton.Instance
    local v2 = UI_upv_1.Compact == true
    local v3 = UI_upv_1.Touch == true
    local u3 = (v2 and 56) or 60
    local u4 = UI_upv_1.IconButton({IconName = "gear", Name = "MatchSettingsCog", Size = fromOffset_upv_1(u3, u3), Parent = LobbyHud_upv_1.Root})
    UI_upv_1.Corner(14).Parent = u4
    local function played()
        --[[
          name: played
          line: 59
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v4 = State_upv_1.Profile and (State_upv_1.Profile.stats)
        local v5 = false
        if type(v4) == "table" then
            v5 = (type(v4.matches) == "number") and (v4.matches >= 1)
        end
        return v5
    end
    local function placeCog()
        --[[
          name: placeCog
          line: 63
          upvalues:
            LobbyHud_upv_1 (copy, index: 1)
            Instance_upv_1 (copy, index: 2)
            u4 (copy, index: 3)
            fromOffset_upv_1 (copy, index: 4)
            u3 (copy, index: 5)
            State_upv_1 (copy, index: 6)
        ]]
        local v6 = 1
        local v7 = LobbyHud_upv_1.Root
        while v7 and not v7:IsA("ScreenGui") do
            local v8 = v7:FindFirstChildOfClass("UIScale")
            v6 = (v8 and (v6 * v8.Scale)) or v6
            v7 = v7.Parent
        end
        v6 = ((v6 <= 0.01) and 1) or v6
        v7 = LobbyHud_upv_1.Root.AbsolutePosition
        local AbsolutePosition_1 = Instance_upv_1.AbsolutePosition
        u4.Position = fromOffset_upv_1((((AbsolutePosition_1.X - v7.X) / v6) - 10) - u3, ((AbsolutePosition_1.Y - v7.Y) / v6) + (((Instance_upv_1.AbsoluteSize.Y / v6) - u3) / 2))
        local Visible_1 = Instance_upv_1.Visible
        local v9
        if Visible_1 then
            local v10 = State_upv_1.Profile and (State_upv_1.Profile.stats)
            v9 = false
            if type(v10) == "table" then
                v9 = (type(v10.matches) == "number") and (v10.matches >= 1)
            end
        else
            v9 = Visible_1
        end
        u4.Visible = v9
    end
    for _, value_1 in {"AbsolutePosition", "AbsoluteSize", "Visible"} do
        Instance_upv_1:GetPropertyChangedSignal(value_1):Connect(placeCog)
    end
    LobbyHud_upv_1.Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(placeCog)
    State_upv_1.ProfileChanged:Connect(placeCog)
    placeCog()
    placeCog = (v2 and 640) or 600
    local u5 = (v3 and 76) or 68
    local paintAll = (v3 and 56) or 46
    local u6 = (math.ceil(#MatchPrefs_upv_1.REGIONS / 2) * (paintAll + 8)) + 30 - 8
    local u7 = 106
    local u8 = (((((u7 + 18) + 10) + u5) + 10) + u5) + 18 + 16
    local u9 = u8 + 6 + u6
    local function OnCloseRequested()
        --[[
          name: OnCloseRequested
          line: 114
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.MenuManager.Close("MatchSettings")
    end
    local u10 = UI_upv_1.Window({HeaderHeight = 80, Subtitle = "How we find your matches", Name = "MatchSettings", Title = "MATCHMAKING", Size = fromOffset_upv_1(placeCog, u9 + 80), Parent = a1.Canvas.Menus, OnCloseRequested = OnCloseRequested})
    local Content_upv_1 = u10.Content
    UI_upv_1.SelectionRing(u10.Root)
    local function click()
        --[[
          name: click
          line: 121
          upvalues:
            a1 (copy, index: 1)
        ]]
        a1.Sounds.Play("Click")
    end
    local u11 = nil
    local u12 = nil
    local function fit()
        --[[
          name: fit
          line: 183
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
            u11 (ref,  index: 2)
            u10 (copy, index: 3)
            fromOffset_upv_1 (copy, index: 4)
            placeCog (copy, index: 5)
            u9 (ref,  index: 6)
            u8 (ref,  index: 7)
        ]]
        local v11 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
        u11.Visible = v11
        local Holder_1 = u10.Holder
        local v12
        if v11 then
            v12 = u9
        else
            v12 = u8
        end
        Holder_1.Size = fromOffset_upv_1(placeCog, v12 + 80)
        if not u10.Refit then
            return
        end
        u10.Refit()
    end
    local function switchRow(a2, a3, a4, a5, a6, a7, a8)
        --[[
          name: switchRow
          line: 127
          upvalues:
            u5 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            Content_upv_1 (copy, index: 5)
            Fonts_upv_1 (copy, index: 6)
            u1 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        local v13 = a8 or u5
        local v14
        if u5 < v13 then
            v14 = true
        else
            v14 = false
        end
        local tbl_2 = {}
        tbl_2.Name = a2
        tbl_2.Position = fromOffset_upv_1(18, a3)
        tbl_2.Size = UDim2.new(1, -36, 0, v13)
        tbl_2.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_2.BackgroundTransparency = 0.3
        tbl_2.Text = ""
        tbl_2.AutoButtonColor = false
        tbl_2[1], tbl_2[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        tbl_2.Parent = Content_upv_1
        local v15 = UI_upv_1.new("TextButton", tbl_2)
        local new_1 = UI_upv_1.new
        local tbl_3 = {TextXAlignment = 0, FontFace = 0, Name = "Title", Position = 0, Parent = 0, Text = 0, TextSize = 18, Size = 0}
        local v16
        if v14 then
            v16 = 14
        else
            v16 = u5 / 2 - 24
        end
        tbl_3.Position = fromOffset_upv_1(16, v16)
        tbl_3.Size = UDim2.new(1, -110, 0, 24)
        tbl_3.Text = a4
        tbl_3.FontFace = Fonts_upv_1.Heavy
        tbl_3.TextXAlignment = Enum.TextXAlignment.Left
        tbl_3.Parent = v15
        new_1("TextLabel", tbl_3)
        local new_2 = UI_upv_1.new
        local v17 = "TextLabel"
        local tbl_4 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, TextTruncate = 0, TextWrapped = 0, Name = "Desc", Position = 0, TextXAlignment = 0, TextYAlignment = 0, TextSize = 14, Size = 0}
        tbl_4.Position = fromOffset_upv_1(16, (v14 and 42) or (u5 / 2 + 2))
        tbl_4.Size = UDim2.new(1, -110, 0, (v14 and (v13 - 42 - 12)) or 20)
        tbl_4.Text = a5
        tbl_4.FontFace = Fonts_upv_1.Bold
        tbl_4.TextColor3 = u1
        tbl_4.TextXAlignment = Enum.TextXAlignment.Left
        local v18
        if v14 then
            v18 = Enum.TextYAlignment.Top
        else
            v18 = Enum.TextYAlignment.Center
        end
        tbl_4.TextYAlignment = v18
        tbl_4.TextWrapped = v14
        if v14 then
            v18 = Enum.TextTruncate.None
        else
            v18 = Enum.TextTruncate.AtEnd
        end
        tbl_4.TextTruncate = v18
        tbl_4.Parent = v15
        new_2(v17, tbl_4)
        local u13 = UI_upv_1.Switch({Width = 60, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -16, 0.5, 0), Parent = v15})
        local function paint_1(a9)
            --[[
              name: paint
              line: 167
              upvalues:
                u13 (copy, index: 1)
                a6 (copy, index: 2)
            ]]
            u13:Set(a6(), a9)
        end
        v15.Activated:Connect(
            function()
                --[[
                  line: 170
                  upvalues:
                    a1 (copy, index: 1)
                    a7 (copy, index: 2)
                    a6 (copy, index: 3)
                    u13 (copy, index: 4)
                ]]
                a1.Sounds.Play("Click")
                a7(not a6())
                u13:Set(a6(), nil)
            end
        )
        u13:Set(a6(), true)
        return function()
            --[[
              line: 176
              upvalues:
                u13 (copy, index: 1)
                a6 (copy, index: 2)
            ]]
            u13:Set(a6(), true)
        end, v15
    end
    local u14, u15 = switchRow(
        "NoBots",
        (u7 + 18) + 10,
        "PREVENT FULL BOT MATCHES",
        "Keep searching until another player joins. Can take longer.",
        function()
            --[[
              line: 192
              upvalues:
                SettingsStore_upv_1 (copy, index: 1)
            ]]
            local v19 = SettingsStore_upv_1.Get("mmNoBots") > 0.5
            return v19
        end,
        function(a10)
            --[[
              line: 194
              upvalues:
                SettingsStore_upv_1 (copy, index: 1)
            ]]
            SettingsStore_upv_1.Set("mmNoBots", (a10 and 1) or 0, true)
        end
    )
    local function premium()
        --[[
          name: premium
          line: 205
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            MatchPrefs_upv_1 (copy, index: 2)
        ]]
        local v20 = LocalPlayer_upv_1:GetAttribute(MatchPrefs_upv_1.PREMIUM_ATTR) == true
        return v20
    end
    local u16, u17 = switchRow(
        "Premium",
        18,
        "PREMIUM ONLY QUEUE",
        "Only match with players who bought something in Tribes. This helps prevent cheaters from showing in your games at the cost of slower queue times.",
        function()
            --[[
              line: 208
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                MatchPrefs_upv_1 (copy, index: 2)
                SettingsStore_upv_1 (copy, index: 3)
            ]]
            local v21 = LocalPlayer_upv_1:GetAttribute(MatchPrefs_upv_1.PREMIUM_ATTR) == true
            if v21 then
                v21 = SettingsStore_upv_1.Get("mmPremium") > 0.5
            end
            return v21
        end,
        function(a11)
            --[[
              line: 210
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                MatchPrefs_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                SettingsStore_upv_1 (copy, index: 4)
            ]]
            local v22 = LocalPlayer_upv_1:GetAttribute(MatchPrefs_upv_1.PREMIUM_ATTR) == true
            if v22 then
                SettingsStore_upv_1.Set("mmPremium", (a11 and 1) or 0, true)
            else
                a1.Toast("Unlocks with any Robux purchase in Tribes (accounts 7+ days old).", "info")
            end
        end,
        u7
    )
    local u18 = UI_upv_1.new("ImageLabel", {Image = "rbxasset://textures/ui/common/robux@3x.png", Name = "Robux", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = fromOffset_upv_1(16, 26), Size = fromOffset_upv_1(24, 24), ImageColor3 = Colors_upv_1.Gold, ScaleType = Enum.ScaleType.Fit, Parent = u17})
    local Title_1 = u17:FindFirstChild("Title")
    if Title_1 then
        Title_1.Position = fromOffset_upv_1(48, Title_1.Position.Y.Offset)
        Title_1.Size = UDim2.new(1, -142, 0, Title_1.Size.Y.Offset)
    end
    local u19 = nil
    local function paintPremiumLock()
        --[[
          name: paintPremiumLock
          line: 242
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            MatchPrefs_upv_1 (copy, index: 2)
            u18 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u17 (copy, index: 5)
            u16 (copy, index: 6)
            u19 (ref,  index: 7)
        ]]
        local v23 = LocalPlayer_upv_1:GetAttribute(MatchPrefs_upv_1.PREMIUM_ATTR) == true
        local v24
        if v23 then
            v24 = Colors_upv_1.Gold
        else
            v24 = Color3.fromRGB(140, 140, 140)
        end
        u18.ImageColor3 = v24
        u18.ImageTransparency = (v23 and 0) or 0.35
        local Desc_1 = u17:FindFirstChild("Desc")
        local Title_2 = u17:FindFirstChild("Title")
        if Desc_1 then
            Desc_1.Text = (v23 and "Only match with players who bought something in Tribes. This helps prevent cheaters from showing in your games at the cost of slower queue times.") or "Unlocks with any Robux purchase in Tribes (accounts 7+ days old). This helps prevent cheaters from showing in your games at the cost of slower queue times."
        end
        if Title_2 then
            Title_2.TextTransparency = (v23 and 0) or 0.45
        end
        u17.BackgroundTransparency = (v23 and 0.3) or 0.55
        u16()
        if not u19 then
            return
        end
        task.defer(u19)
    end
    LocalPlayer_upv_1:GetAttributeChangedSignal(MatchPrefs_upv_1.PREMIUM_ATTR):Connect(paintPremiumLock)
    paintPremiumLock()
    local u20, u21 = switchRow(
        "ManualRegion",
        (((u7 + 18) + 10) + u5) + 10,
        "MANUAL REGION SELECTION",
        "Pick more regions to search in. Off: only your own, for the best ping.",
        function()
            --[[
              line: 264
              upvalues:
                SettingsStore_upv_1 (copy, index: 1)
            ]]
            local v25 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
            return v25
        end,
        function(a12)
            --[[
              line: 266
              upvalues:
                SettingsStore_upv_1 (copy, index: 1)
                u12 (ref,  index: 2)
                u11 (ref,  index: 3)
                u10 (copy, index: 4)
                fromOffset_upv_1 (copy, index: 5)
                placeCog (copy, index: 6)
                u9 (ref,  index: 7)
                u8 (ref,  index: 8)
            ]]
            SettingsStore_upv_1.Set("mmAutoRegion", (a12 and 0) or 1, true)
            u12()
            local v26 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
            u11.Visible = v26
            local Holder_2 = u10.Holder
            local v27
            if v26 then
                v27 = u9
            else
                v27 = u8
            end
            Holder_2.Size = fromOffset_upv_1(placeCog, v27 + 80)
            if not u10.Refit then
                return
            end
            u10.Refit()
        end
    )
    local v28 = UI_upv_1.new("Frame", {Name = "Regions", Position = fromOffset_upv_1(18, ((u8 - 18) - 16) + 6), Size = UDim2.new(1, -36, 0, u6), Parent = Content_upv_1})
    u11 = v28
    UI_upv_1.new("TextLabel", {Text = "Also search in these regions. Yours is always included. Other regions mean higher ping.", Name = "Hint", TextSize = 14, Size = UDim2.new(1, 0, 0, 22), FontFace = Fonts_upv_1.Bold, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u11})
    local tbl_upv_5 = {}
    for key_upv_1, value_2 in MatchPrefs_upv_1.REGIONS do
        local v29 = (key_upv_1 - 1) % 2
        local v30 = math.floor((key_upv_1 - 1) / 2)
        local new_3 = UI_upv_1.new
        local tbl_6 = {}
        tbl_6.Name = value_2.id
        tbl_6.Position = UDim2.new(v29 * 0.5, ((v29 ~= 1) and 0) or 5, 0, (v30 * (paintAll + 8)) + 30)
        tbl_6.Size = UDim2.new(0.5, -5, 0, paintAll)
        tbl_6.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_6.BackgroundTransparency = 0.3
        tbl_6.Text = ""
        tbl_6.AutoButtonColor = false
        tbl_6[1], tbl_6[2] = UI_upv_1.Corner(10), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.92)
        tbl_6.Parent = u11
        new_3 = new_3("TextButton", tbl_6)
        local tbl_7 = {}
        tbl_7.Name = "Box"
        tbl_7.AnchorPoint = Vector2.new(0, 0.5)
        tbl_7.Position = UDim2.new(0, 12, 0.5, 0)
        tbl_7.Size = fromOffset_upv_1(24, 24)
        tbl_7.BackgroundColor3 = Colors_upv_1.Void
        tbl_7.BackgroundTransparency = 0.2
        tbl_7[1], tbl_7[2] = UI_upv_1.Corner(6), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.6)
        tbl_7.Parent = new_3
        local v31 = UI_upv_1.new("Frame", tbl_7)
        local v32 = UI_upv_1.Icon("check", 16, Colors_upv_1.Text, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v31})
        UI_upv_1.new("TextLabel", {Name = "Name", TextSize = 16, Position = fromOffset_upv_1(48, 0), Size = UDim2.new(1, -56, 1, 0), Text = value_2.name, FontFace = Fonts_upv_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = new_3})
        tbl_upv_5[key_upv_1] = {box = v31, check = v32}
        new_3.Activated:Connect(
            function()
                --[[
                  line: 328
                  upvalues:
                    a1 (copy, index: 1)
                    SettingsStore_upv_1 (copy, index: 2)
                    MatchPrefs_upv_1 (copy, index: 3)
                    key_upv_1 (copy, index: 4)
                    u12 (ref,  index: 5)
                ]]
                a1.Sounds.Play("Click")
                local v33 = math.floor(SettingsStore_upv_1.Get("mmRegions"))
                SettingsStore_upv_1.Set("mmRegions", MatchPrefs_upv_1.With(v33, key_upv_1, not MatchPrefs_upv_1.Has(v33, key_upv_1)), true)
                u12()
            end
        )
    end
    u12 = function()
        --[[
          line: 335
          upvalues:
            SettingsStore_upv_1 (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
            MatchPrefs_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
        ]]
        local v34 = math.floor(SettingsStore_upv_1.Get("mmRegions"))
        local v35 = nil
        for key_2, value_3 in tbl_upv_5 do
            local v36 = MatchPrefs_upv_1.Has(v34, key_2)
            value_3.check.Visible = v36
            local box_1 = value_3.box
            if v36 then
                v35 = Colors_upv_1.Accent
            else
                v35 = Colors_upv_1.Void
            end
            box_1.BackgroundColor3 = v35
            value_3.box.BackgroundTransparency = (v36 and 0) or 0.2
        end
    end
    local u22 = false
    u19 = function()
        --[[
          line: 348
          upvalues:
            u17 (copy, index: 1)
            u22 (ref,  index: 2)
            u5 (copy, index: 3)
            u7 (ref,  index: 4)
            u15 (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            u21 (copy, index: 7)
            u8 (ref,  index: 8)
            u9 (ref,  index: 9)
            u6 (copy, index: 10)
            u11 (ref,  index: 11)
            SettingsStore_upv_1 (copy, index: 12)
            u10 (copy, index: 13)
            placeCog (copy, index: 14)
        ]]
        local Desc_upv_2 = u17:FindFirstChild("Desc")
        if u22 or not Desc_upv_2 or Desc_upv_2.AbsoluteSize.X <= 0 or Desc_upv_2.Size.Y.Offset <= 0 then
            return
        end
        local u23 = Desc_upv_2.AbsoluteSize.X / math.max(Desc_upv_2.AbsoluteSize.Y / Desc_upv_2.Size.Y.Offset, 0.01)
        u22 = true
        local v37 = 0
        for _, value_upv_4 in {"Only match with players who bought something in Tribes. This helps prevent cheaters from showing in your games at the cost of slower queue times.", "Unlocks with any Robux purchase in Tribes (accounts 7+ days old). This helps prevent cheaters from showing in your games at the cost of slower queue times."} do
            local success_1, v38 = pcall(
                function()
                    --[[
                      line: 358
                      upvalues:
                        value_upv_4 (copy, index: 1)
                        Desc_upv_2 (copy, index: 2)
                        u23 (copy, index: 3)
                    ]]
                    local v39 = Instance.new("GetTextBoundsParams")
                    v39.Text = value_upv_4
                    v39.Font = Desc_upv_2.FontFace
                    v39.Size = Desc_upv_2.TextSize
                    v39.Width = u23
                    return game:GetService("TextService"):GetTextBoundsAsync(v39)
                end
            )
            if not (success_1) then
                continue
            end
            if typeof(v38) == "Vector2" then
                v37 = math.max(v37, v38.Y)
            end
        end
        u22 = false
        if v37 <= 0 then
            return
        end
        local v40 = math.max(u5, math.ceil((v37 + 42) + 14))
        if math.abs(v40 - u7) < 1 then
            return
        end
        u7 = v40
        u17.Size = UDim2.new(1, -36, 0, v40)
        Desc_upv_2.Size = UDim2.new(1, -110, 0, (v40 - 42) - 12)
        u15.Position = fromOffset_upv_1(18, (v40 + 18) + 10)
        u21.Position = fromOffset_upv_1(18, (((v40 + 18) + 10) + u5) + 10)
        u8 = ((((((v40 + 18) + 10) + u5) + 10) + u5) + 18) + 16
        u9 = (u8 + 6) + u6
        u11.Position = fromOffset_upv_1(18, ((u8 - 18) - 16) + 6)
        local v41 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
        u11.Visible = v41
        local Holder_3 = u10.Holder
        local v42
        if v41 then
            v42 = u9
        else
            v42 = u8
        end
        Holder_3.Size = fromOffset_upv_1(placeCog, v42 + 80)
        if not u10.Refit then
            return
        end
        u10.Refit()
    end
    paintAll = function()
        --[[
          name: paintAll
          line: 389
          upvalues:
            u14 (copy, index: 1)
            paintPremiumLock (copy, index: 2)
            u20 (copy, index: 3)
            u12 (ref,  index: 4)
            SettingsStore_upv_1 (copy, index: 5)
            u11 (ref,  index: 6)
            u10 (copy, index: 7)
            fromOffset_upv_1 (copy, index: 8)
            placeCog (copy, index: 9)
            u9 (ref,  index: 10)
            u8 (ref,  index: 11)
            u19 (ref,  index: 12)
        ]]
        u14()
        paintPremiumLock()
        u20()
        u12()
        local v43 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
        u11.Visible = v43
        local Holder_4 = u10.Holder
        local v44
        if v43 then
            v44 = u9
        else
            v44 = u8
        end
        Holder_4.Size = fromOffset_upv_1(placeCog, v44 + 80)
        if u10.Refit then
            u10.Refit()
        end
        task.defer(u19)
    end
    SettingsStore_upv_1.Changed:Connect(
        function(a13)
            --[[
              line: 397
              upvalues:
                a1 (copy, index: 1)
                u14 (copy, index: 2)
                paintPremiumLock (copy, index: 3)
                u20 (copy, index: 4)
                u12 (ref,  index: 5)
                SettingsStore_upv_1 (copy, index: 6)
                u11 (ref,  index: 7)
                u10 (copy, index: 8)
                fromOffset_upv_1 (copy, index: 9)
                placeCog (copy, index: 10)
                u9 (ref,  index: 11)
                u8 (ref,  index: 12)
                u19 (ref,  index: 13)
            ]]
            if string.sub(a13, 1, 2) ~= "mm" then
                return
            end
            if a1.MenuManager.IsOpen("MatchSettings") then
                u14()
                paintPremiumLock()
                u20()
                u12()
                local v45 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
                u11.Visible = v45
                local Holder_5 = u10.Holder
                local v46
                if v45 then
                    v46 = u9
                else
                    v46 = u8
                end
                Holder_5.Size = fromOffset_upv_1(placeCog, v46 + 80)
                if u10.Refit then
                    u10.Refit()
                end
                task.defer(u19)
            end
        end
    )
    local tbl_8 = {}
    function tbl_8.open()
        --[[
          name: open
          line: 404
          upvalues:
            u14 (copy, index: 1)
            paintPremiumLock (copy, index: 2)
            u20 (copy, index: 3)
            u12 (ref,  index: 4)
            SettingsStore_upv_1 (copy, index: 5)
            u11 (ref,  index: 6)
            u10 (copy, index: 7)
            fromOffset_upv_1 (copy, index: 8)
            placeCog (copy, index: 9)
            u9 (ref,  index: 10)
            u8 (ref,  index: 11)
            u19 (ref,  index: 12)
            UI_upv_1 (copy, index: 13)
            GuiService_upv_1 (copy, index: 14)
            Content_upv_1 (copy, index: 15)
        ]]
        u14()
        paintPremiumLock()
        u20()
        u12()
        local v47 = SettingsStore_upv_1.Get("mmAutoRegion") < 0.5
        u11.Visible = v47
        local Holder_6 = u10.Holder
        local v48
        if v47 then
            v48 = u9
        else
            v48 = u8
        end
        Holder_6.Size = fromOffset_upv_1(placeCog, v48 + 80)
        if u10.Refit then
            u10.Refit()
        end
        task.defer(u19)
        u10:Open()
        if not UI_upv_1.Gamepad then
            return
        end
        GuiService_upv_1.SelectedObject = Content_upv_1:FindFirstChild("Premium")
    end
    function tbl_8.close(a14)
        --[[
          name: close
          line: 411
          upvalues:
            GuiService_upv_1 (copy, index: 1)
            u10 (copy, index: 2)
        ]]
        local SelectedObject_1 = GuiService_upv_1.SelectedObject
        if SelectedObject_1 and SelectedObject_1:IsDescendantOf(u10.Root) then
            GuiService_upv_1.SelectedObject = nil
        end
        u10:Close(a14)
    end
    a1.MenuManager.Register("MatchSettings", tbl_8)
    u4.Activated:Connect(
        function()
            --[[
              line: 419
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Sounds.Play("Click")
            a1.MenuManager.Open("MatchSettings")
        end
    )
    State_upv_1.PlayerStateChanged:Connect(
        function()
            --[[
              line: 424
              upvalues:
                State_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            if not State_upv_1.InMatch() or not a1.MenuManager.IsOpen("MatchSettings") then
                return
            end
            a1.MenuManager.Close("MatchSettings", true)
        end
    )
end
return tbl_1