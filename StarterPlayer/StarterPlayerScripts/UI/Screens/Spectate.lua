local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 24
      upvalues:
        Players_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Portraits_upv_1 = a1.Portraits
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local v1 = UI_upv_1.new("Frame", {Name = "Spectate", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local u1 = UI_upv_1.new("Frame", {Name = "EliminatedBy", Visible = false, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.58), Size = UDim2.fromOffset(470, 116), Parent = v1})
    local u2 = UI_upv_1.Panel({Name = "Inner", BackgroundTransparency = 0.12, StrokeTransparency = 0.3, Size = UDim2.fromScale(1, 1), StrokeColor = Colors_upv_1.Enemy, Trim = Colors_upv_1.Enemy, Parent = u1})
    local tbl_upv_2 = {}
    tbl_upv_2.Name = "Killer"
    tbl_upv_2.Position = UDim2.fromOffset(14, 14)
    tbl_upv_2.Size = UDim2.fromOffset(88, 88)
    tbl_upv_2.BackgroundColor3 = Theme_upv_1.Darken(Colors_upv_1.Enemy, 0.6)
    tbl_upv_2.ScaleType = Enum.ScaleType.Crop
    tbl_upv_2[1], tbl_upv_2[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Enemy, 2.5, 0.1)
    tbl_upv_2.Parent = u2
    local u3 = UI_upv_1.new("ImageLabel", tbl_upv_2)
    local u4 = UI_upv_1.DisplayText({StrokeThickness = 2, Text = "ELIMINATED BY", Name = "Title", TextSize = 26, Position = UDim2.fromOffset(118, 12), Size = UDim2.new(1, -190, 0, 32), TextColor3 = Colors_upv_1.Enemy, TextXAlignment = Enum.TextXAlignment.Left, Parent = u2})
    tbl_upv_2 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Name", TextScaled = true, Position = UDim2.fromOffset(118, 44), Size = UDim2.new(1, -190, 0, 34), FontFace = Fonts_1.Heavy, TextXAlignment = Enum.TextXAlignment.Left, Parent = u2})
    UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 30, MinTextSize = 12, Parent = tbl_upv_2})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = tbl_upv_2
    local u5 = UI_upv_1.new("TextLabel", {Text = "", Name = "Sub", TextSize = 16, Position = UDim2.fromOffset(118, 80), Size = UDim2.new(1, -190, 0, 20), FontFace = Fonts_1.Bold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u2})
    local u6 = UI_upv_1.new("Frame", {Name = "Weapon", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(64, 64), Parent = u2})
    local u7 = 0
    local function showCard(a2, a3, a4, a5, a6)
        --[[
          name: showCard
          line: 103
          upvalues:
            u7 (ref,  index: 1)
            u4 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u3 (copy, index: 5)
            Portraits_upv_1 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
            u5 (copy, index: 9)
            WeaponIcon_upv_1 (copy, index: 10)
            u6 (copy, index: 11)
            u1 (copy, index: 12)
            u2 (copy, index: 13)
            Theme_upv_1 (copy, index: 14)
        ]]
        u7 = u7 + 1
        local u8 = u7
        u4.Text = ((a2 ~= "") and "ELIMINATED BY") or "YOU WERE ELIMINATED"
        tbl_upv_2.Text = a2
        local v2
        if a6 then
            v2 = Colors_upv_1.Ally
        else
            v2 = Colors_upv_1.Text
        end
        tbl_upv_2.TextColor3 = v2
        u3.Visible = a2 ~= ""
        if a3 then
            Portraits_upv_1.Apply(u3, a3, 150)
        else
            u3.Image = UI_upv_1.Assets.Icons.Skull
            u3.ScaleType = Enum.ScaleType.Fit
        end
        local tbl_3 = {}
        if type(a4) == "string" and a4 ~= "" then
            table.insert(tbl_3, a1.Loc.T(string.upper(a1.WeaponInfo.Name(a4))))
        end
        if a5 then
            table.insert(tbl_3, a1.Loc.T("HEADSHOT"))
        end
        u5.AutoLocalize = false
        u5.Text = table.concat(tbl_3, "  \194\183  ")
        local Set_1 = WeaponIcon_upv_1.Set
        local v3
        if type(a4) ~= "string" or a4 == "" then
            v3 = nil
        else
            v3 = a4
        end
        Set_1(u6, v3)
        u1.Visible = true
        UI_upv_1.Unfade(u2)
        UI_upv_1.SlideIn(u2, Vector2.new(0, 30), Theme_upv_1.Tween.PopSmall, UDim2.new())
        task.delay(
            3.2,
            function()
                --[[
                  line: 129
                  upvalues:
                    u8 (copy, index: 1)
                    u7 (ref,  index: 2)
                    UI_upv_1 (copy, index: 3)
                    u2 (copy, index: 4)
                    u1 (copy, index: 5)
                ]]
                if u8 ~= u7 then
                    return
                end
                UI_upv_1.FadeOut(u2, TweenInfo.new(0.3))
                task.delay(
                    0.32,
                    function()
                        --[[
                          line: 134
                          upvalues:
                            u8 (copy, index: 1)
                            u7 (ref,  index: 2)
                            u1 (copy, index: 3)
                        ]]
                        if u8 ~= u7 then
                            return
                        end
                        u1.Visible = false
                    end
                )
            end
        )
    end
    local function hideCard()
        --[[
          name: hideCard
          line: 141
          upvalues:
            u7 (ref,  index: 1)
            u1 (copy, index: 2)
        ]]
        u7 = u7 + 1
        u1.Visible = false
    end
    local refreshBar = nil
    local function slamY()
        --[[
          name: slamY
          line: 148
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if UI_upv_1.Compact then
            return 0.3
        end
        return 0.36
    end
    local new_upv_1 = UI_upv_1.new
    local tbl_4 = {Name = "Respawn", Position = 0, Parent = 0, Visible = false, Size = 0}
    tbl_4.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_4.Position = UDim2.fromScale(0.5, ((UI_upv_1.Compact) and 0.3) or 0.36)
    tbl_4.Size = UDim2.fromOffset(500, 220)
    tbl_4.Parent = v1
    new_upv_1 = new_upv_1("Frame", tbl_4)
    local u9 = UI_upv_1.new("TextLabel", {Text = "RESPAWNING IN", Name = "Tag", TextSize = 26, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 0.5, -70), Size = UDim2.fromOffset(500, 30), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.Accent, Parent = new_upv_1})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = u9
    local u10 = UI_upv_1.new("TextLabel", {Text = "", Name = "Digit", TextSize = 100, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 8), Size = UDim2.fromOffset(300, 130), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.Bone, Parent = new_upv_1})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.15).Parent = u10
    local u11 = UI_upv_1.new("UIScale", {Parent = u10})
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 184
              upvalues:
                new_upv_1 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
            ]]
            new_upv_1.Position = UDim2.fromScale(0.5, ((UI_upv_1.Compact) and 0.3) or 0.36)
        end
    )
    local function outBack(a7)
        --[[
          name: outBack
          line: 187
        ]]
        local v4 = a7 - 1
        return ((((v4 * 2.5) * v4) * v4) + 1) + ((v4 * 1.5) * v4)
    end
    local u12 = nil
    local function stopRespawn()
        --[[
          name: stopRespawn
          line: 192
          upvalues:
            u12 (ref,  index: 1)
            refreshBar (ref,  index: 2)
            new_upv_1 (copy, index: 3)
        ]]
        if u12 then
            u12:Disconnect()
            u12 = nil
            refreshBar()
        end
        new_upv_1.Visible = false
    end
    local function startRespawn(a8)
        --[[
          name: startRespawn
          line: 201
          upvalues:
            u12 (ref,  index: 1)
            refreshBar (ref,  index: 2)
            new_upv_1 (copy, index: 3)
            u10 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u9 (copy, index: 6)
            RunService_upv_1 (copy, index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
            a1 (copy, index: 9)
            u11 (copy, index: 10)
        ]]
        if u12 then
            u12:Disconnect()
            u12 = nil
            refreshBar()
        end
        new_upv_1.Visible = false
        local u13 = os.clock() + a8
        local u14 = 0
        u10.Text = ""
        new_upv_1.Visible = true
        UI_upv_1.Unfade(u9)
        local v5 = RunService_upv_1.RenderStepped:Connect(
            function()
                --[[
                  line: 208
                  upvalues:
                    u12 (ref,  index: 1)
                    u13 (copy, index: 2)
                    LocalPlayer_upv_1 (copy, index: 3)
                    a8 (copy, index: 4)
                    refreshBar (ref,  index: 5)
                    new_upv_1 (copy, index: 6)
                    u14 (ref,  index: 7)
                    u10 (copy, index: 8)
                    a1 (copy, index: 9)
                    u11 (copy, index: 10)
                    UI_upv_1 (copy, index: 11)
                ]]
                if not u12 then
                    return
                end
                local v6 = u13 - os.clock()
                local v7
                if v6 <= 0 or LocalPlayer_upv_1:GetAttribute("Alive") == true and v6 < a8 - 0.5 then
                    if u12 then
                        u12:Disconnect()
                        u12 = nil
                        refreshBar()
                    end
                    new_upv_1.Visible = false
                    return
                end
                v7 = math.ceil(v6)
                local v8 = v7 - v6
                if v7 ~= u14 then
                    u14 = v7
                    u10.Text = tostring(v7)
                    if v7 <= 3 then
                        a1.Sounds.Play("Match/Countdown_" .. v7)
                    end
                end
                if v8 < 0.2 then
                    local _ = v8 / 0.2 - 1
                    v7 = 1.4 - ((v8 / 0.2 - 1) * 2.5 * (v8 / 0.2 - 1) * (v8 / 0.2 - 1) + 1 + (v8 / 0.2 - 1) * 1.5 * (v8 / 0.2 - 1)) * 0.4
                else
                    v7 = 1 - (0.03 * (v8 - 0.2)) / 0.8
                end
                u11.Scale = (((UI_upv_1.Compact) and 1.3) or 1.6) * v7
                u10.TextTransparency = 1 - math.min(1, v8 / 0.06)
            end
        )
        u12 = v5
        refreshBar()
    end
    local u15 = UI_upv_1.Panel({Name = "SpectateBar", Visible = false, BackgroundTransparency = 0.15, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(440, 76), Trim = Colors_upv_1.Accent, Parent = v1})
    local u16 = UI_upv_1.new("TextLabel", {Name = "Tag", Text = "SPECTATING", TextSize = 15, Position = UDim2.fromOffset(84, 8), Size = UDim2.new(1, -168, 0, 20), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u15})
    local u17 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Name = "Target", Text = "", TextScaled = true, Position = UDim2.fromOffset(84, 28), Size = UDim2.new(1, -168, 0, 36), FontFace = Fonts_1.Display, Parent = u15})
    UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 30, MinTextSize = 12, Parent = u17})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = u17
    local function cam()
        --[[
          name: cam
          line: 267
          upvalues:
            a1 (copy, index: 1)
        ]]
        return a1.MenuManager.Camera()
    end
    local function spectateNext(a9)
        --[[
          name: spectateNext
          line: 270
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v9 = a1.MenuManager.Camera()
        if not v9 or type(v9.SpectateNext) ~= "function" then
            return
        end
        pcall(v9.SpectateNext, a9)
    end
    local function OnClick()
        --[[
          name: OnClick
          line: 285
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v10 = a1.MenuManager.Camera()
        if not v10 or type(v10.SpectateNext) ~= "function" then
            return
        end
        pcall(v10.SpectateNext, -1)
    end
    local u18 = UI_upv_1.IconButton({IconName = "chevLeft", IconScale = 0.5, Name = "Prev", Size = UDim2.fromOffset(64, 60), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Color = Colors_upv_1.Raised, Parent = u15, OnClick = OnClick})
    local function OnClick_2()
        --[[
          name: OnClick
          line: 298
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v11 = a1.MenuManager.Camera()
        if not v11 or type(v11.SpectateNext) ~= "function" then
            return
        end
        pcall(v11.SpectateNext, 1)
    end
    local u19 = UI_upv_1.IconButton({IconName = "chevRight", IconScale = 0.5, Name = "Next", Size = UDim2.fromOffset(64, 60), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Color = Colors_upv_1.Raised, Parent = u15, OnClick = OnClick_2})
    local u20 = UI_upv_1.Button({Visible = false, Name = "StopWatching", Style = "Dark", Text = "STOP WATCHING", TextSize = 17, Icon = UI_upv_1.Glyph("door-open-arrow-to-bottom-right", 18, Colors_upv_1.TextDim), Size = UDim2.fromOffset(230, 46), Parent = u15})
    u20.Instance.AnchorPoint = Vector2.new(0.5, 1)
    u20.Instance.Position = UDim2.new(0.5, 0, 0, -10)
    local u21 = false
    u20.Activated:Connect(
        function()
            --[[
              line: 316
              upvalues:
                u21 (ref,  index: 1)
                a1 (copy, index: 2)
                u20 (copy, index: 3)
            ]]
            if (u21) or not a1.Custom then
                return
            end
            u21 = true
            u20:SetText("\226\128\166")
            task.spawn(
                function()
                    --[[
                      line: 322
                      upvalues:
                        a1 (copy, index: 1)
                        u21 (ref,  index: 2)
                        u20 (copy, index: 3)
                    ]]
                    local v12, v13 = a1.Custom.Action("Watch", false)
                    u21 = false
                    u20:SetText("STOP WATCHING")
                    if (v12) or not v13 then
                        return
                    end
                    a1.Toast(tostring(v13), "error")
                end
            )
        end
    )
    local function cycleCount()
        --[[
          name: cycleCount
          line: 331
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v14 = State_upv_1.Get("SpectateCount")
        if type(v14) ~= "number" then
            return 0
        end
        return v14
    end
    local u22 = true
    local function layout()
        --[[
          name: layout
          line: 337
          upvalues:
            a1 (copy, index: 1)
            u15 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u22 (ref,  index: 4)
            u16 (copy, index: 5)
            u17 (copy, index: 6)
        ]]
        if a1.HotbarTop then
            local _ = a1.HotbarTop()
        end
        u15.Position = UDim2.new(0.5, 0, 1, -(((UI_upv_1.Compact) and 16) or 40))
        local v15 = (u22 and 84) or 20
        u15.Size = UDim2.fromOffset(((not u22) and 320) or (((UI_upv_1.Compact) and 460) or 440), ((UI_upv_1.Touch) and 84) or 76)
        u16.Position = UDim2.fromOffset(v15, 8)
        u16.Size = UDim2.new(1, v15 * -2, 0, 20)
        u17.Position = UDim2.fromOffset(v15, 28)
        u17.Size = UDim2.new(1, v15 * -2, 0, 36)
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    local u23 = ""
    local u24 = ""
    refreshBar = function()
        --[[
          name: refreshBar
          line: 356
          upvalues:
            State_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            u12 (ref,  index: 3)
            u24 (ref,  index: 4)
            u20 (copy, index: 5)
            u22 (ref,  index: 6)
            layout (copy, index: 7)
            u18 (copy, index: 8)
            u19 (copy, index: 9)
            u23 (ref,  index: 10)
            u17 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
            Colors_upv_1 (copy, index: 13)
            u16 (copy, index: 14)
            u15 (copy, index: 15)
            UI_upv_1 (copy, index: 16)
        ]]
        local v16 = State_upv_1.Get("SpectateMode")
        local v17 = State_upv_1.Watching()
        local v18
        if State_upv_1.InMatch() or v17 then
            v18 = (v16 == "follow") and (not a1.HudHidden and (u12 == nil))
        else
            v18 = v17
        end
        local v19 = State_upv_1.Get("SpectateTargetName")
        local v20 = State_upv_1.Get("SpectateTargetId")
        if v17 and type(v20) == "string" and v20 ~= "" and v20 ~= u24 and a1.Custom then
            u24 = v20
            task.spawn(a1.Custom.Action, "WatchTarget", v20)
        elseif not (v17) then
            u24 = ""
        end
        u20.Instance.Visible = v17 and (not a1.HudHidden)
        local v21 = nil
        if v18 then
            v21 = State_upv_1.Get("SpectateCount")
            local v22
            if type(v21) ~= "number" then
                v22 = 0
            else
                v22 = v21
            end
            if v22 > 1 then
                v20 = true
            else
                v20 = false
            end
            if v20 ~= u22 then
                u22 = v20
                layout()
            end
            u18.Visible = u22
            u19.Visible = u22
            local v23, v21 = State_upv_1.FindMember(State_upv_1.Get("SpectateTargetId"))
            v20 = true
            if v21 ~= nil then
                v20 = State_upv_1.IsAllyTeam(v21)
            end
            v21 = string.upper
            local v24
            if type(v19) ~= "string" or v19 == "" then
                if v23 then
                    v24 = v23.name
                else
                    v24 = ((not v17) and "?") or (a1.Loc.T("Loading the match..."))
                end
            else
                v24 = v19
            end
            v21 = v21(tostring(v24))
            local v25 = v21 ~= u23
            u23 = v21
            u17.Text = v21
            local v26
            if v20 then
                v26 = Theme_upv_1.Lighten(Colors_upv_1.Ally, 0.2)
            else
                v26 = Theme_upv_1.Lighten(Colors_upv_1.Enemy, 0.1)
            end
            u17.TextColor3 = v26
            u16.Text = (v17 and "WATCHING") or "SPECTATING"
            if u15.Visible then
                if not v25 then
                    return
                end
                UI_upv_1.Bump(u17, 0.06)
            else
                u15.Visible = true
                UI_upv_1.Unfade(u15)
                UI_upv_1.SlideIn(u15, Vector2.new(0, 30), Theme_upv_1.Tween.PopSmall)
                a1.MenuManager.PushMouse("Spectate")
            end
        elseif u15.Visible then
            u15.Visible = false
            a1.MenuManager.PopMouse("Spectate")
        end
    end
    for _, value_1 in {"SpectateMode", "SpectateTargetId", "SpectateTargetName", "SpectateKillerName", "SpectateCount"} do
        LocalPlayer_upv_1:GetAttributeChangedSignal(value_1):Connect(refreshBar)
    end
    State_upv_1.AttrChanged:Connect(
        function(a10)
            --[[
              line: 405
              upvalues:
                refreshBar (ref,  index: 1)
                State_upv_1 (copy, index: 2)
                u7 (ref,  index: 3)
                u1 (copy, index: 4)
            ]]
            if a10 == "SpectateMode" or a10 == "SpectateTargetName" or a10 == "SpectateCount" or a10 == "State" then
                refreshBar()
            end
            if a10 ~= "Alive" or State_upv_1.Get("Alive") ~= true then
                return
            end
            u7 = u7 + 1
            u1.Visible = false
        end
    )
    a1.HudHiddenChanged:Connect(refreshBar)
    State_upv_1.PlayerStateChanged:Connect(
        function(a11)
            --[[
              line: 414
              upvalues:
                u7 (ref,  index: 1)
                u1 (copy, index: 2)
                refreshBar (ref,  index: 3)
            ]]
            if a11 ~= "Match" then
                u7 = u7 + 1
                u1.Visible = false
            end
            refreshBar()
        end
    )
    State_upv_1.WatchChanged:Connect(
        function()
            --[[
              line: 420
              upvalues:
                layout (copy, index: 1)
                refreshBar (ref,  index: 2)
            ]]
            layout()
            refreshBar()
        end
    )
    a1.OnMatchEvent(
        function(a12, a13)
            --[[
              line: 425
              upvalues:
                State_upv_1 (copy, index: 1)
                showCard (copy, index: 2)
                startRespawn (copy, index: 3)
                u7 (ref,  index: 4)
                u1 (copy, index: 5)
                u12 (ref,  index: 6)
                refreshBar (ref,  index: 7)
                new_upv_1 (copy, index: 8)
            ]]
            if a12 == "Elimination" and type(a13) == "table" then
                local v27 = nil
                if a13.victimId == State_upv_1.MyId() then
                    local v28 = (type(a13.killerName) == "string") and ((a13.killerName ~= "") and (a13.killerId ~= a13.victimId))
                    local v29
                    if v28 then
                        v29 = State_upv_1.FindMember(a13.killerId)
                    else
                        v29 = nil
                    end
                    local v30 = ((not v28) and "") or (a13.killerName)
                    local weaponId_1 = a13.weaponId
                    local v31 = a13.headshot == true
                    local v32 = v28 and (State_upv_1.IsAllyTeam(a13.killerTeam))
                    showCard(v30, v29, weaponId_1, v31, v32)
                    v27 = tonumber(a13.secondWind)
                    if v27 and v27 > 0 then
                        startRespawn(v27)
                    end
                    return
                end
            end
            if a12 ~= "RoundStart" and a12 ~= "RoundEnd" and a12 ~= "MatchEnd" then
                return
            end
            u7 = u7 + 1
            u1.Visible = false
            if u12 then
                u12:Disconnect()
                u12 = nil
                refreshBar()
            end
            new_upv_1.Visible = false
        end
    )
    refreshBar()
    a1.Debug.spectate = function(a14, a15, a16)
        --[[
          line: 440
          upvalues:
            State_upv_1 (copy, index: 1)
            refreshBar (ref,  index: 2)
        ]]
        State_upv_1.SetMockAttr("SpectateMode", a14)
        State_upv_1.SetMockAttr("SpectateTargetName", a15)
        State_upv_1.SetMockAttr("SpectateCount", a16)
        refreshBar()
        return true
    end
end
return tbl_1