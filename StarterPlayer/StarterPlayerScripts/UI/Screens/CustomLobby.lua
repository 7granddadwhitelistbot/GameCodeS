local ProximityPromptService_upv_1 = game:GetService("ProximityPromptService")
local _ = game:GetService("UserInputService")
local v1 = game:GetService("GuiService")
local CustomMatch_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 32
      upvalues:
        CustomMatch_upv_1 (copy, index: 1)
        ProximityPromptService_upv_1 (copy, index: 2)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Custom_upv_1 = a1.Custom
    local fromOffset_upv_1 = UDim2.fromOffset
    local u1 = false
    local u2 = nil
    local u3 = nil
    local u4 = nil
    local u5 = nil
    local u6 = nil
    local u7 = nil
    local u8 = nil
    local u9 = nil
    local u10 = nil
    local u11 = nil
    local function placeLock()
        --[[
          name: placeLock
          line: 42
          upvalues:
            u8 (ref, index: 1)
            u4 (ref, index: 2)
            u9 (ref, index: 3)
        ]]
        if not u8 or not u4 then
            return
        end
        if u9 then
            local v1 = u4.Position.Y.Offset + u4.Size.Y.Offset / 2
            u9.Position = UDim2.new(1, u4.Position.X.Offset, 0, v1)
            local v2
            if u9.Visible then
                v2 = u9.Size.X.Offset
            else
                v2 = u4.TextBounds.X
            end
            u8.Position = UDim2.new(1, (u4.Position.X.Offset - v2) - 7, 0, v1)
        end
    end
    local u12 = nil
    local u13 = nil
    local u14 = nil
    local u15 = false
    local u16 = nil
    local function closeConfirm()
        --[[
          name: closeConfirm
          line: 55
          upvalues:
            u16 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if u16 then
            u16.Visible = false
        end
        a1.MenuManager.PopMouse("CustomLeave")
        a1.MenuManager.PopFocus("CustomLeave")
    end
    local function leave()
        --[[
          name: leave
          line: 62
          upvalues:
            u16 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if u16 then
            u16.Visible = false
        end
        a1.MenuManager.PopMouse("CustomLeave")
        a1.MenuManager.PopFocus("CustomLeave")
        task.spawn(function() end)
    end
    local function openConfirm()
        --[[
          name: openConfirm
          line: 71
          upvalues:
            u16 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            closeConfirm (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            leave (copy, index: 8)
        ]]
        if not (u16) then
            local v3 = UI_upv_1.new("TextButton", {Visible = false, Selectable = false, Text = "", AutoButtonColor = false, Name = "CustomLeaveConfirm", BackgroundTransparency = 0.45, ZIndex = 50, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = a1.Canvas.Overlay})
            v3.Activated:Connect(closeConfirm)
            local v4 = UI_upv_1.Panel({Name = "Card", ZIndex = 51, BackgroundTransparency = 0.02, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(480, 256), Radius = UDim.new(0, 16), Parent = v3})
            UI_upv_1.DropShadow(v4, 16, 8, 0.5)
            UI_upv_1.new("TextButton", {Name = "Sink", ZIndex = 52, Selectable = false, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = v4})
            UI_upv_1.DisplayText({ZIndex = 53, Name = "Title", Text = "LEAVE CUSTOM MATCH?", TextSize = 32, Position = fromOffset_upv_1(0, 24), Size = UDim2.new(1, 0, 0, 40), TextColor3 = Colors_upv_1.Text, Parent = v4})
            UI_upv_1.new("TextLabel", {Text = "You'll go back to a public lobby. You can come back with the code while there's room.", Name = "Body", TextWrapped = true, ZIndex = 53, TextSize = 19, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 74), Size = UDim2.new(1, -56, 0, 74), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.TextDim, Parent = v4})
            local v5 = UI_upv_1.Button({Text = "STAY", Name = "Stay", Style = "Dark", ZIndex = 54, TextSize = 21, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v4})
            local v6 = UI_upv_1.Button({Text = "LEAVE", Name = "Leave", Style = "Danger", ZIndex = 54, TextSize = 21, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -24), Size = fromOffset_upv_1(200, 58), Parent = v4})
            v5.Activated:Connect(closeConfirm)
            v6.Activated:Connect(leave)
            u16 = v3
        end
        local u17 = u16
        u17.Visible = true
        UI_upv_1.Enter(u17:FindFirstChild("Card"), Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        a1.MenuManager.PushMouse("CustomLeave")
        a1.MenuManager.PushFocus(
            "CustomLeave",
            function()
                --[[
                  line: 125
                  upvalues:
                    u17 (copy, index: 1)
                ]]
                local Card_1 = u17:FindFirstChild("Card")
                local v7 = Card_1 and (Card_1:FindFirstChild("Stay"))
                return v7 or nil
            end,
            function()
                --[[
                  line: 129
                  upvalues:
                    u16 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if u16 then
                    u16.Visible = false
                end
                a1.MenuManager.PopMouse("CustomLeave")
                a1.MenuManager.PopFocus("CustomLeave")
                return true
            end
        )
    end
    local function build()
        --[[
          name: build
          line: 136
          upvalues:
            u1 (ref,  index: 1)
            a1 (copy, index: 2)
            u2 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            u3 (ref,  index: 5)
            Fonts_upv_1 (copy, index: 6)
            Colors_upv_1 (copy, index: 7)
            u4 (ref,  index: 8)
            u9 (ref,  index: 9)
            Custom_upv_1 (copy, index: 10)
            u8 (ref,  index: 11)
            placeLock (copy, index: 12)
            u10 (ref,  index: 13)
            u5 (ref,  index: 14)
            u6 (ref,  index: 15)
            Theme_upv_1 (copy, index: 16)
            u7 (ref,  index: 17)
            u11 (ref,  index: 18)
            u12 (ref,  index: 19)
            u13 (ref,  index: 20)
            u14 (ref,  index: 21)
            u15 (ref,  index: 22)
            openConfirm (copy, index: 23)
        ]]
        if u1 then
            return
        end
        u1 = true
        local v8
        if a1.LobbyHud then
            v8 = a1.LobbyHud.Root
        else
            v8 = a1.Canvas.HUD
        end
        local v9 = UI_upv_1.Panel({Visible = false, Name = "CustomMatchCard", StrokeTransparency = 0.82, BackgroundTransparency = 0.12, Radius = UDim.new(0, 16), Parent = v8})
        u2 = v9
        local v10 = UI_upv_1.new("TextLabel", {Name = "Cap", Text = "CUSTOM MATCH", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = u2})
        u3 = v10
        local v11 = UI_upv_1.new("TextLabel", {Name = "Code", Text = "", AnchorPoint = Vector2.new(1, 0), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Accent, TextXAlignment = Enum.TextXAlignment.Right, Parent = u2})
        u4 = v11
        local v12 = Custom_upv_1.MaskDots({GroupGap = 9, Name = "Mask", Dot = 7, Gap = 4, Color = Colors_upv_1.TextDim, AnchorPoint = Vector2.new(1, 0.5), Parent = u2})
        u9 = v12
        u9.Visible = false
        local v13 = UI_upv_1.Glyph("lock-closed", 15, Colors_upv_1.TextDim, {Name = "Lock", AnchorPoint = Vector2.new(1, 0.5), Parent = u2})
        u8 = v13
        u8.Visible = false
        u4:GetPropertyChangedSignal("TextBounds"):Connect(
            function()
                --[[
                  line: 172
                  upvalues:
                    placeLock (copy, index: 1)
                ]]
                placeLock()
            end
        )
        local v14 = UI_upv_1.Icon("chevRight", 18, Colors_upv_1.TextDim, {Name = "Open", AnchorPoint = Vector2.new(1, 0.5), Parent = u2})
        u10 = v14
        local v15 = UI_upv_1.new("TextLabel", {Name = "ServerName", Text = "", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u2})
        u5 = v15
        local v16 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4)
        v16.Parent = u5
        local v17 = UI_upv_1.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Colors_upv_1.Success, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u2})
        u6 = v17
        local v18 = UI_upv_1.new("TextLabel", {Name = "Status", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u2})
        u7 = v18
        local v19 = UI_upv_1.new("TextButton", {AutoButtonColor = false, Name = "Open", ZIndex = 6, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = u2})
        u11 = v19
        local u18 = u2:FindFirstChildOfClass("UIStroke")
        local Transparency_upv_1 = u18.Transparency
        local Color_upv_1 = u18.Color
        local u19 = false
        local function paintHover_upv_1(a2)
            --[[
              name: paintHover
              line: 210
              upvalues:
                UI_upv_1 (copy, index: 1)
                u18 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
                u19 (ref,  index: 4)
                Colors_upv_1 (copy, index: 5)
                Color_upv_1 (copy, index: 6)
                Transparency_upv_1 (copy, index: 7)
                u2 (ref,  index: 8)
            ]]
            local Tween_1 = UI_upv_1.Tween
            local Fast_1 = Theme_upv_1.Tween.Fast
            local tbl_2 = {Color = 0, Transparency = 0}
            local v20
            if u19 or a2 then
                v20 = Colors_upv_1.Accent
            else
                v20 = Color_upv_1
            end
            tbl_2.Color = v20
            if a2 then
                v20 = 0.1
            elseif u19 then
                v20 = 0.35
            else
                v20 = Transparency_upv_1
            end
            tbl_2.Transparency = v20
            Tween_1(u18, Fast_1, tbl_2)
            local Tween_2 = UI_upv_1.Tween
            local v21 = u2
            local Fast_2 = Theme_upv_1.Tween.Fast
            local tbl_3 = {BackgroundTransparency = 0}
            v20 = (a2 and 0.2) or ((u19 and 0.04) or 0.12)
            tbl_3.BackgroundTransparency = v20
            Tween_2(v21, Fast_2, tbl_3)
        end
        u11.MouseEnter:Connect(
            function()
                --[[
                  line: 217
                  upvalues:
                    u19 (ref,  index: 1)
                    UI_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                    paintHover_upv_1 (copy, index: 4)
                ]]
                u19 = true
                if not (UI_upv_1.Touch) then
                    a1.Sounds.Play("Hover")
                end
                paintHover_upv_1()
            end
        )
        u11.MouseLeave:Connect(
            function()
                --[[
                  line: 224
                  upvalues:
                    u19 (ref,  index: 1)
                    paintHover_upv_1 (copy, index: 2)
                ]]
                u19 = false
                paintHover_upv_1()
            end
        )
        u11.MouseButton1Down:Connect(
            function()
                --[[
                  line: 228
                  upvalues:
                    paintHover_upv_1 (copy, index: 1)
                ]]
                paintHover_upv_1(true)
            end
        )
        u11.MouseButton1Up:Connect(
            function()
                --[[
                  line: 231
                  upvalues:
                    paintHover_upv_1 (copy, index: 1)
                ]]
                paintHover_upv_1()
            end
        )
        u11.Activated:Connect(
            function()
                --[[
                  line: 234
                  upvalues:
                    u19 (ref,  index: 1)
                    paintHover_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                ]]
                u19 = false
                paintHover_upv_1()
                a1.Sounds.Play("Click")
                a1.MenuManager.Toggle("CustomHost")
            end
        )
        local function OnDisabledClick_1()
            --[[
              name: OnDisabledClick
              line: 249
              upvalues:
                Custom_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            local v22 = Custom_upv_1.State()
            a1.Toast(tostring(((v22 and (v22.startHint ~= "")) and (v22.startHint)) or "Can't start yet"), "info")
        end
        local v23 = UI_upv_1.Button({Visible = false, Name = "CustomStart", Text = "START MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("play-large", 22, Colors_upv_1.Text), Parent = v8, OnDisabledClick = OnDisabledClick_1})
        u12 = v23
        local v24 = UI_upv_1.Button({Visible = false, Name = "CustomLeave", Sound = false, Text = "LEAVE", Style = "Dark", Icon = UI_upv_1.Glyph("door-open-arrow-to-bottom-right", 20, Colors_upv_1.TextDim), Parent = v8})
        u13 = v24
        local v25 = UI_upv_1.Button({Visible = false, Name = "CustomWatch", Text = "WATCH MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("eye", 22, Colors_upv_1.Text), Parent = v8})
        u14 = v25
        u14.Activated:Connect(
            function()
                --[[
                  line: 271
                  upvalues:
                    u15 (ref,  index: 1)
                    u14 (ref,  index: 2)
                    Custom_upv_1 (copy, index: 3)
                    a1 (copy, index: 4)
                ]]
                if u15 then
                    return
                end
                u15 = true
                u14:SetText("LOADING...")
                local v26, v27 = Custom_upv_1.Action("Watch", true)
                u15 = false
                u14:SetText("WATCH MATCH")
                if v26 then
                    a1.Sounds.Play("Click")
                else
                    a1.Toast(tostring(v27), "error")
                end
            end
        )
        u12.Activated:Connect(
            function()
                --[[
                  line: 286
                  upvalues:
                    u15 (ref,  index: 1)
                    Custom_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u12 (ref,  index: 5)
                ]]
                if u15 then
                    return
                end
                local v28 = Custom_upv_1.State()
                if v28 and v28.canStart then
                    u15 = true
                    u12:SetText("STARTING...")
                    local v29, v30 = Custom_upv_1.Host("Start")
                    u15 = false
                    u12:SetText("START MATCH")
                    if v29 then
                        a1.Sounds.Play("Match_Found")
                    else
                        a1.Toast(tostring(v30), "error")
                    end
                    return
                end
                a1.Toast(tostring((v28 and (v28.startHint)) or "Can't start yet"), "info")
                UI_upv_1.Shake(u12.Instance, 5)
            end
        )
        u13.Activated:Connect(
            function()
                --[[
                  line: 307
                  upvalues:
                    a1 (copy, index: 1)
                    openConfirm (copy, index: 2)
                ]]
                a1.Sounds.Play("Click")
                openConfirm()
            end
        )
    end
    local function layout()
        --[[
          name: layout
          line: 313
          upvalues:
            u1 (ref,  index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u2 (ref,  index: 4)
            fromOffset_upv_1 (copy, index: 5)
            u3 (ref,  index: 6)
            u4 (ref,  index: 7)
            u5 (ref,  index: 8)
            u10 (ref,  index: 9)
            u6 (ref,  index: 10)
            u7 (ref,  index: 11)
            u12 (ref,  index: 12)
            u13 (ref,  index: 13)
            u14 (ref,  index: 14)
            placeLock (copy, index: 15)
        ]]
        if not u1 then
            return
        end
        local v31 = a1.LobbyHud and (a1.LobbyHud.PlayButton)
        if UI_upv_1.Compact then
            local v32
            if v31 then
                v32 = v31.Instance.Position.Y.Offset
            else
                v32 = UI_upv_1.TopInset()
            end
            u2.AnchorPoint = Vector2.new(1, 0)
            u2.Position = UDim2.new(1, -16, 0, v32)
            u2.Size = fromOffset_upv_1(272, 88)
            local v33 = fromOffset_upv_1(16, 10)
            local v34 = fromOffset_upv_1(150, 16)
            u3.Position = v33
            u3.Size = v34
            u3.TextSize = 13
            local v35 = UDim2.new(1, -16, 0, 7)
            local v36 = fromOffset_upv_1(110, 22)
            u4.Position = v35
            u4.Size = v36
            u4.TextSize = 20
            local v37 = fromOffset_upv_1(16, 29)
            local v38 = fromOffset_upv_1(214, 26)
            u5.Position = v37
            u5.Size = v38
            u5.TextSize = 21
            u10.Position = UDim2.new(1, -12, 0, 43)
            local v39 = fromOffset_upv_1(17, 69)
            local v40 = fromOffset_upv_1(8, 8)
            u6.Position = v39
            u6.Size = v40
            local v41 = fromOffset_upv_1(31, 60)
            local v42 = fromOffset_upv_1(228, 18)
            u7.Position = v41
            u7.Size = v42
            u7.TextSize = 14
            for _, value_1 in {u12, u13, u14} do
                value_1.Instance.AnchorPoint = Vector2.new(1, 0)
                value_1.Instance.Position = UDim2.new(1, -16, 0, v32 + 96)
                value_1.Instance.Size = fromOffset_upv_1(272, 52)
                value_1.Label.TextSize = 20
            end
        else
            u2.AnchorPoint = Vector2.new(1, 1)
            u2.Position = UDim2.new(1, -28, 1, -104)
            u2.Size = fromOffset_upv_1(300, 98)
            local v43 = fromOffset_upv_1(18, 12)
            local v44 = fromOffset_upv_1(160, 16)
            u3.Position = v43
            u3.Size = v44
            u3.TextSize = 13
            local v45 = UDim2.new(1, -18, 0, 9)
            local v46 = fromOffset_upv_1(120, 22)
            u4.Position = v45
            u4.Size = v46
            u4.TextSize = 21
            local v47 = fromOffset_upv_1(18, 32)
            local v48 = fromOffset_upv_1(236, 28)
            u5.Position = v47
            u5.Size = v48
            u5.TextSize = 23
            u10.Position = UDim2.new(1, -14, 0, 47)
            local v49 = fromOffset_upv_1(19, 76)
            local v50 = fromOffset_upv_1(8, 8)
            u6.Position = v49
            u6.Size = v50
            local v51 = fromOffset_upv_1(33, 67)
            local v52 = fromOffset_upv_1(252, 18)
            u7.Position = v51
            u7.Size = v52
            u7.TextSize = 15
            for _, value_2 in {u12, u13, u14} do
                value_2.Instance.AnchorPoint = Vector2.new(1, 1)
                value_2.Instance.Position = UDim2.new(1, -28, 1, -40)
                value_2.Instance.Size = fromOffset_upv_1(300, 54)
                value_2.Label.TextSize = 22
            end
        end
        placeLock()
    end
    local u20 = false
    local u21 = ""
    local u22 = false
    local u23 = false
    local function paint()
        --[[
          name: paint
          line: 360
          upvalues:
            Custom_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            u1 (ref,  index: 3)
            u2 (ref,  index: 4)
            u12 (ref,  index: 5)
            u13 (ref,  index: 6)
            u14 (ref,  index: 7)
            u20 (ref,  index: 8)
            build (copy, index: 9)
            layout (copy, index: 10)
            u22 (ref,  index: 11)
            UI_upv_1 (copy, index: 12)
            u23 (ref,  index: 13)
            u4 (ref,  index: 14)
            CustomMatch_upv_1 (copy, index: 15)
            u9 (ref,  index: 16)
            u8 (ref,  index: 17)
            placeLock (copy, index: 18)
            u5 (ref,  index: 19)
            Colors_upv_1 (copy, index: 20)
            u7 (ref,  index: 21)
            u6 (ref,  index: 22)
            u15 (ref,  index: 23)
            u21 (ref,  index: 24)
        ]]
        local v53 = Custom_upv_1.IsServer()
        if a1.LobbyHud and a1.LobbyHud.SetPlayHidden then
            a1.LobbyHud.SetPlayHidden("Custom", v53)
        end
        local v54 = v53 and (Custom_upv_1.IsHost())
        if a1.TopbarSettings and a1.TopbarSettings.SetHostVisible then
            a1.TopbarSettings.SetHostVisible(v54)
        end
        if v53 then
            build()
            layout()
            v53 = Custom_upv_1.State() or {}
            u2.Visible = true
            local v55 = false
            local v56 = 0
            local v57
            if type(v53.players) ~= "table" then
                v57 = {}
            else
                v57 = v53.players
            end
            for _, value_3 in v57 do
                if type(value_3) ~= "table" or value_3.userId ~= a1.Player.UserId then
                    continue
                end
                v55 = value_3.playing == true
                if value_3.team == 1 then
                    v56 = value_3.team
                    continue
                end
                if value_3.team ~= 2 then
                    v56 = 0
                else
                    v56 = value_3.team
                end
            end
            local v58 = (v53.status == "Match") and (not v55)
            local Instance_1 = u12.Instance
            Instance_1.Visible = v53 and (not v58)
            local Instance_2 = u13.Instance
            Instance_2.Visible = not v53 and (not v58)
            u14.Instance.Visible = v58
            if v58 and not (u22) then
                UI_upv_1.Enter(u14.Instance, Vector2.new(0, 12), 0.05, u14.Instance.Position)
            end
            if not (u23) and type(v53.status) == "string" then
                u23 = true
                if v58 then
                    a1.Toast("A match is in progress. Watch it while you wait for the next one.", "info")
                end
            end
            u22 = v58
            local v59 = Custom_upv_1.IsPrivate() and (not Custom_upv_1.IsRevealed())
            u4.Text = CustomMatch_upv_1.FormatCode(Custom_upv_1.Code())
            u4.Visible = not v59
            u9.Visible = v59
            u8.Visible = Custom_upv_1.IsPrivate()
            placeLock()
            u5.AutoLocalize = false
            u5.Text = tostring(v53.name or "Custom match")
            local v60 = ((type(v53.players) ~= "table") and 0) or (#v53.players)
            v55 = tonumber(v53.max) or (CustomMatch_upv_1.MAX_PLAYERS)
            local v61 = v53.status or "Lobby"
            local v62, v63
            if v61 == "Match" then
                v62 = string.format("Match in progress  \194\183  %d/%d", v60, v55)
                v63 = Colors_upv_1.Warning
            elseif v61 == "Results" then
                v62, v63 = "Showing the results", Colors_upv_1.Accent
            elseif v53 then
                if v53.canStart == true or type(v53.startHint) ~= "string" or v53.startHint == "" then
                    if v53 then
                        v62, v63 = string.format("You're the host  \194\183  %s", tostring(v53.mapName or "Random")), Colors_upv_1.Success
                    elseif v56 == 0 then
                        v62, v63 = string.format("Waiting for the host  \194\183  %d/%d", v60, v55), Colors_upv_1.Success
                    else
                        v62, v63 = string.format("Team %d  \194\183  Waiting for the host", v56), Colors_upv_1.Success
                    end
                else
                    v62, v63 = v53.startHint, Colors_upv_1.Warning
                end
            elseif v53 then
                v62, v63 = string.format("You're the host  \194\183  %s", tostring(v53.mapName or "Random")), Colors_upv_1.Success
            elseif v56 == 0 then
                v62, v63 = string.format("Waiting for the host  \194\183  %d/%d", v60, v55), Colors_upv_1.Success
            else
                v62, v63 = string.format("Team %d  \194\183  Waiting for the host", v56), Colors_upv_1.Success
            end
            u7.Text = v62
            u6.BackgroundColor3 = v63
            local v64 = u12
            local v65 = false
            if v53.canStart == true then
                v65 = not u15
            end
            v64:SetEnabled(v65)
            if v53 and not (u20) then
                UI_upv_1.Enter(u12.Instance, Vector2.new(0, 12), 0.05, u12.Instance.Position)
            end
            if v61 ~= u21 then
                u21 = v61
                UI_upv_1.Pop(u6, 1.8)
            end
            u20 = v53
        else
            if u1 then
                u2.Visible = false
                u12.Instance.Visible = false
                u13.Instance.Visible = false
                u14.Instance.Visible = false
            end
            u20 = false
        end
    end
    Custom_upv_1.Changed:Connect(paint)
    Custom_upv_1.RevealChanged:Connect(paint)
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 445
              upvalues:
                layout (copy, index: 1)
            ]]
            layout()
        end
    )
    if a1.LobbyHud and a1.LobbyHud.PlayButton then
        a1.LobbyHud.PlayButton.Instance:GetPropertyChangedSignal("Position"):Connect(layout)
    end
    if a1.TopbarSettings and a1.TopbarSettings.HostActivated then
        a1.TopbarSettings.HostActivated:Connect(
            function()
                --[[
                  line: 452
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1.MenuManager.Toggle("CustomHost")
            end
        )
    end
    local UserInputService_upv_1 = game:GetService("UserInputService")
    local Keybinds_upv_1 = require(game:GetService("ReplicatedStorage").Shared:WaitForChild("Keybinds"))
    Keybinds_upv_1.OnInput(
        "Began",
        function(a3, a4)
            --[[
              line: 462
              upvalues:
                UserInputService_upv_1 (copy, index: 1)
                Custom_upv_1 (copy, index: 2)
                Keybinds_upv_1 (copy, index: 3)
                State_upv_1 (copy, index: 4)
                a1 (copy, index: 5)
            ]]
            if (a4) or (UserInputService_upv_1:GetFocusedTextBox()) then
                return
            end
            if Custom_upv_1.IsServer() then
                local v66 = Keybinds_upv_1.IsPad(a3, "CustomMenu") and ((State_upv_1.Get("State") ~= "Match") and ((State_upv_1.Get("CombatMode") ~= true) and (not Keybinds_upv_1.PadBlocked() or (a1.MenuManager.IsOpen("CustomHost")))))
                if v66 or Keybinds_upv_1.ActionOf(a3) == "CustomMenu" then
                    a1.MenuManager.Toggle("CustomHost")
                end
            end
        end
    )
    task.spawn(
        function()
            --[[
              line: 474
              upvalues:
                u1 (ref,  index: 1)
                u2 (ref,  index: 2)
                UI_upv_1 (copy, index: 3)
                u6 (ref,  index: 4)
            ]]
            repeat
                task.wait(1.2)
            until u1
            if u2.Visible then
                local Tween_3 = UI_upv_1.Tween
                local v67 = TweenInfo.new(0.6, Enum.EasingStyle.Sine)
                local tbl_4 = {BackgroundTransparency = 0}
                tbl_4.BackgroundTransparency = ((u6.BackgroundTransparency < 0.3) and 0.55) or 0
                Tween_3(u6, v67, tbl_4)
            end
        end
    )
    paint()
    ProximityPromptService_upv_1.PromptShown:Connect(
        function(a5)
            --[[
              line: 485
              upvalues:
                Custom_upv_1 (copy, index: 1)
            ]]
            if a5.Name ~= "CustomMatchesPrompt" or not Custom_upv_1.IsServer() then
                return
            end
            a5.Enabled = false
            task.spawn(
                function()
                    --[[
                      line: 488
                      upvalues:
                        a5 (copy, index: 1)
                        Custom_upv_1 (copy, index: 2)
                    ]]
                    while a5.Parent do
                        if Custom_upv_1.IsServer() then
                            task.wait(2)
                            continue
                        else
                            break
                        end
                    end
                    if not a5.Parent then
                        return
                    end
                    a5.Enabled = true
                end
            )
        end
    )
    a1.Debug.customLobby = function(a6)
        --[[
          line: 500
          upvalues:
            openConfirm (copy, index: 1)
            u16 (ref,  index: 2)
            a1 (copy, index: 3)
            u12 (ref,  index: 4)
            u14 (ref,  index: 5)
            Custom_upv_1 (copy, index: 6)
            u1 (ref,  index: 7)
            u2 (ref,  index: 8)
            u7 (ref,  index: 9)
            u9 (ref,  index: 10)
            u4 (ref,  index: 11)
            u8 (ref,  index: 12)
            u13 (ref,  index: 13)
        ]]
        if a6 == "leave" then
            openConfirm()
        elseif a6 == "closeConfirm" then
            if u16 then
                u16.Visible = false
            end
            a1.MenuManager.PopMouse("CustomLeave")
            a1.MenuManager.PopFocus("CustomLeave")
        elseif a6 == "start" then
            u12.Activated:Fire()
        elseif a6 == "watch" then
            u14.Activated:Fire()
        elseif a6 == "leaveYes" then
            if u16 then
                u16.Visible = false
            end
            a1.MenuManager.PopMouse("CustomLeave")
            a1.MenuManager.PopFocus("CustomLeave")
            task.spawn(
                function()
                    --[[
                      line: 64
                      upvalues:
                        Custom_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    local v68, v69 = Custom_upv_1.Action("Leave")
                    if (v68) then
                        return
                    end
                    a1.Toast(tostring(v69), "error")
                end
            )
        end
        local tbl_5 = {code = 0, crown = 0, leave = 0, card = 0, status = 0, watch = 0, start = 0, lock = 0}
        tbl_5.custom = Custom_upv_1.IsServer()
        tbl_5.host = Custom_upv_1.IsHost()
        tbl_5.card = u1 and (u2.Visible)
        local v70 = ((not u1) and "") or (u7.Text)
        tbl_5.status = v70
        if u1 then
            if u9.Visible then
                v70 = Custom_upv_1.MASK
            else
                v70 = u4.Text
            end
        else
            v70 = ""
        end
        tbl_5.code = v70
        tbl_5.lock = u1 and (u8.Visible)
        tbl_5.start = u1 and (u12.Instance.Visible)
        tbl_5.leave = u1 and (u13.Instance.Visible)
        tbl_5.watch = u1 and (u14.Instance.Visible)
        tbl_5.crown = ((a1.TopbarSettings) and (a1.TopbarSettings.HostButton.Visible)) or false
        return tbl_5
    end
    a1.Debug.custom = function(a7, a8)
        --[[
          line: 525
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        if a7 == "mock" then
            Custom_upv_1.SetMock(a8)
        end
        local v71 = Custom_upv_1.State()
        local tbl_6 = {status = 0}
        tbl_6.server = Custom_upv_1.IsServer()
        tbl_6.host = Custom_upv_1.IsHost()
        tbl_6.code = Custom_upv_1.Code()
        tbl_6.status = (v71 and (v71.status)) or false
        return tbl_6
    end
end
return tbl_1