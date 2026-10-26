local ProximityPromptService_upv_1 = game:GetService("ProximityPromptService")
local _ = game:GetService("UserInputService")
local v1 = game:GetService("GuiService")
local CustomMatch_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("CustomMatch"))
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 34
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
    local u12 = nil
    local u13 = nil
    local function placeLock()
        --[[
          name: placeLock
          line: 46
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
    local u14 = nil
    local u15 = nil
    local u16 = nil
    local u17 = false
    local u18 = nil
    local function closeConfirm()
        --[[
          name: closeConfirm
          line: 59
          upvalues:
            u18 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if u18 then
            u18.Visible = false
        end
        a1.MenuManager.PopMouse("CustomLeave")
        a1.MenuManager.PopFocus("CustomLeave")
    end
    local function leave()
        --[[
          name: leave
          line: 66
          upvalues:
            u18 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if u18 then
            u18.Visible = false
        end
        a1.MenuManager.PopMouse("CustomLeave")
        a1.MenuManager.PopFocus("CustomLeave")
        task.spawn(function() end)
    end
    local function openConfirm()
        --[[
          name: openConfirm
          line: 75
          upvalues:
            u18 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            closeConfirm (copy, index: 5)
            fromOffset_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            leave (copy, index: 8)
        ]]
        if not (u18) then
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
            u18 = v3
        end
        local u19 = u18
        u19.Visible = true
        UI_upv_1.Enter(u19:FindFirstChild("Card"), Vector2.new(0, 16), 0, UDim2.fromScale(0.5, 0.5))
        a1.Sounds.Play("Open")
        a1.MenuManager.PushMouse("CustomLeave")
        a1.MenuManager.PushFocus(
            "CustomLeave",
            function()
                --[[
                  line: 129
                  upvalues:
                    u19 (copy, index: 1)
                ]]
                local Card_1 = u19:FindFirstChild("Card")
                local v7 = Card_1 and (Card_1:FindFirstChild("Stay"))
                return v7 or nil
            end,
            function()
                --[[
                  line: 133
                  upvalues:
                    u18 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if u18 then
                    u18.Visible = false
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
          line: 140
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
            u12 (ref,  index: 14)
            fromOffset_upv_1 (copy, index: 15)
            Theme_upv_1 (copy, index: 16)
            u13 (ref,  index: 17)
            u5 (ref,  index: 18)
            u6 (ref,  index: 19)
            u7 (ref,  index: 20)
            u11 (ref,  index: 21)
            u14 (ref,  index: 22)
            u15 (ref,  index: 23)
            u16 (ref,  index: 24)
            u17 (ref,  index: 25)
            openConfirm (copy, index: 26)
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
                  line: 176
                  upvalues:
                    placeLock (copy, index: 1)
                ]]
                placeLock()
            end
        )
        local v14 = UI_upv_1.Icon("chevRight", 18, Colors_upv_1.TextDim, {Name = "Open", AnchorPoint = Vector2.new(1, 0.5), Parent = u2})
        u10 = v14
        local v15 = UI_upv_1.new("Frame", {Name = "Mode", AnchorPoint = Vector2.new(1, 0.5), Size = fromOffset_upv_1(50, 22), BackgroundColor3 = Colors_upv_1.Raised, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u2})
        u12 = v15
        local v16 = UI_upv_1.new("TextLabel", {Name = "Text", Text = "3V3", TextSize = 15, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u12})
        u13 = v16
        a1.Loc.Fit(u13, 11, 0.1)
        local v17 = UI_upv_1.new("TextLabel", {Name = "ServerName", Text = "", FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u2})
        u5 = v17
        local v18 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4)
        v18.Parent = u5
        local v19 = UI_upv_1.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Colors_upv_1.Success, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u2})
        u6 = v19
        local v20 = UI_upv_1.new("TextLabel", {Name = "Status", Text = "", FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u2})
        u7 = v20
        local v21 = UI_upv_1.new("TextButton", {AutoButtonColor = false, Name = "Open", ZIndex = 6, Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = u2})
        u11 = v21
        local u20 = u2:FindFirstChildOfClass("UIStroke")
        local Transparency_upv_1 = u20.Transparency
        local Color_upv_1 = u20.Color
        local u21 = false
        local function paintHover_upv_1(a2)
            --[[
              name: paintHover
              line: 233
              upvalues:
                UI_upv_1 (copy, index: 1)
                u20 (copy, index: 2)
                Theme_upv_1 (copy, index: 3)
                u21 (ref,  index: 4)
                Colors_upv_1 (copy, index: 5)
                Color_upv_1 (copy, index: 6)
                Transparency_upv_1 (copy, index: 7)
                u2 (ref,  index: 8)
            ]]
            local Tween_1 = UI_upv_1.Tween
            local Fast_1 = Theme_upv_1.Tween.Fast
            local tbl_2 = {Color = 0, Transparency = 0}
            local v22
            if u21 or a2 then
                v22 = Colors_upv_1.Accent
            else
                v22 = Color_upv_1
            end
            tbl_2.Color = v22
            if a2 then
                v22 = 0.1
            elseif u21 then
                v22 = 0.35
            else
                v22 = Transparency_upv_1
            end
            tbl_2.Transparency = v22
            Tween_1(u20, Fast_1, tbl_2)
            local Tween_2 = UI_upv_1.Tween
            local v23 = u2
            local Fast_2 = Theme_upv_1.Tween.Fast
            local tbl_3 = {BackgroundTransparency = 0}
            v22 = (a2 and 0.2) or ((u21 and 0.04) or 0.12)
            tbl_3.BackgroundTransparency = v22
            Tween_2(v23, Fast_2, tbl_3)
        end
        u11.MouseEnter:Connect(
            function()
                --[[
                  line: 240
                  upvalues:
                    u21 (ref,  index: 1)
                    UI_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                    paintHover_upv_1 (copy, index: 4)
                ]]
                u21 = true
                if not (UI_upv_1.Touch) then
                    a1.Sounds.Play("Hover")
                end
                paintHover_upv_1()
            end
        )
        u11.MouseLeave:Connect(
            function()
                --[[
                  line: 247
                  upvalues:
                    u21 (ref,  index: 1)
                    paintHover_upv_1 (copy, index: 2)
                ]]
                u21 = false
                paintHover_upv_1()
            end
        )
        u11.MouseButton1Down:Connect(
            function()
                --[[
                  line: 251
                  upvalues:
                    paintHover_upv_1 (copy, index: 1)
                ]]
                paintHover_upv_1(true)
            end
        )
        u11.MouseButton1Up:Connect(
            function()
                --[[
                  line: 254
                  upvalues:
                    paintHover_upv_1 (copy, index: 1)
                ]]
                paintHover_upv_1()
            end
        )
        u11.Activated:Connect(
            function()
                --[[
                  line: 257
                  upvalues:
                    u21 (ref,  index: 1)
                    paintHover_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                ]]
                u21 = false
                paintHover_upv_1()
                a1.Sounds.Play("Click")
                a1.MenuManager.Toggle("CustomHost")
            end
        )
        local function OnDisabledClick_1()
            --[[
              name: OnDisabledClick
              line: 272
              upvalues:
                Custom_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            local v24 = Custom_upv_1.State()
            a1.Toast(tostring(((v24 and (v24.startHint ~= "")) and (v24.startHint)) or "Can't start yet"), "info")
        end
        local v25 = UI_upv_1.Button({Visible = false, Name = "CustomStart", Text = "START MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("play-large", 22, Colors_upv_1.Text), Parent = v8, OnDisabledClick = OnDisabledClick_1})
        u14 = v25
        local v26 = UI_upv_1.Button({Visible = false, Name = "CustomLeave", Sound = false, Text = "LEAVE", Style = "Dark", Icon = UI_upv_1.Glyph("door-open-arrow-to-bottom-right", 20, Colors_upv_1.TextDim), Parent = v8})
        u15 = v26
        local v27 = UI_upv_1.Button({Visible = false, Name = "CustomWatch", Text = "WATCH MATCH", Style = "Primary", Icon = UI_upv_1.Glyph("eye", 22, Colors_upv_1.Text), Parent = v8})
        u16 = v27
        u16.Activated:Connect(
            function()
                --[[
                  line: 294
                  upvalues:
                    u17 (ref,  index: 1)
                    u16 (ref,  index: 2)
                    Custom_upv_1 (copy, index: 3)
                    a1 (copy, index: 4)
                ]]
                if u17 then
                    return
                end
                u17 = true
                u16:SetText("LOADING...")
                local v28, v29 = Custom_upv_1.Action("Watch", true)
                u17 = false
                u16:SetText("WATCH MATCH")
                if v28 then
                    a1.Sounds.Play("Click")
                else
                    a1.Toast(tostring(v29), "error")
                end
            end
        )
        u14.Activated:Connect(
            function()
                --[[
                  line: 309
                  upvalues:
                    u17 (ref,  index: 1)
                    Custom_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                    UI_upv_1 (copy, index: 4)
                    u14 (ref,  index: 5)
                ]]
                if u17 then
                    return
                end
                local v30 = Custom_upv_1.State()
                if v30 and v30.canStart then
                    u17 = true
                    u14:SetText("STARTING...")
                    local v31, v32 = Custom_upv_1.Host("Start")
                    u17 = false
                    u14:SetText("START MATCH")
                    if v31 then
                        a1.Sounds.Play("Match_Found")
                    else
                        a1.Toast(tostring(v32), "error")
                    end
                    return
                end
                a1.Toast(tostring((v30 and (v30.startHint)) or "Can't start yet"), "info")
                UI_upv_1.Shake(u14.Instance, 5)
            end
        )
        u15.Activated:Connect(
            function()
                --[[
                  line: 330
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
          line: 336
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
            u12 (ref,  index: 10)
            u6 (ref,  index: 11)
            u7 (ref,  index: 12)
            u14 (ref,  index: 13)
            u15 (ref,  index: 14)
            u16 (ref,  index: 15)
            placeLock (copy, index: 16)
        ]]
        if not u1 then
            return
        end
        local v33 = a1.LobbyHud and (a1.LobbyHud.PlayButton)
        if UI_upv_1.Compact then
            local v34
            if v33 then
                v34 = v33.Instance.Position.Y.Offset
            else
                v34 = UI_upv_1.TopInset()
            end
            u2.AnchorPoint = Vector2.new(1, 0)
            u2.Position = UDim2.new(1, -16, 0, v34)
            u2.Size = fromOffset_upv_1(272, 88)
            local v35 = fromOffset_upv_1(16, 10)
            local v36 = fromOffset_upv_1(150, 16)
            u3.Position = v35
            u3.Size = v36
            u3.TextSize = 13
            local v37 = UDim2.new(1, -16, 0, 7)
            local v38 = fromOffset_upv_1(110, 22)
            u4.Position = v37
            u4.Size = v38
            u4.TextSize = 20
            local v39 = fromOffset_upv_1(16, 29)
            local v40 = fromOffset_upv_1(162, 26)
            u5.Position = v39
            u5.Size = v40
            u5.TextSize = 21
            u10.Position = UDim2.new(1, -12, 0, 43)
            u12.Position = UDim2.new(1, -36, 0, 43)
            local v41 = fromOffset_upv_1(17, 69)
            local v42 = fromOffset_upv_1(8, 8)
            u6.Position = v41
            u6.Size = v42
            local v43 = fromOffset_upv_1(31, 60)
            local v44 = fromOffset_upv_1(228, 18)
            u7.Position = v43
            u7.Size = v44
            u7.TextSize = 14
            for _, value_1 in {u14, u15, u16} do
                value_1.Instance.AnchorPoint = Vector2.new(1, 0)
                value_1.Instance.Position = UDim2.new(1, -16, 0, v34 + 96)
                value_1.Instance.Size = fromOffset_upv_1(272, 52)
                value_1.Label.TextSize = 20
            end
        else
            u2.AnchorPoint = Vector2.new(1, 1)
            u2.Position = UDim2.new(1, -28, 1, -104)
            u2.Size = fromOffset_upv_1(300, 98)
            local v45 = fromOffset_upv_1(18, 12)
            local v46 = fromOffset_upv_1(160, 16)
            u3.Position = v45
            u3.Size = v46
            u3.TextSize = 13
            local v47 = UDim2.new(1, -18, 0, 9)
            local v48 = fromOffset_upv_1(120, 22)
            u4.Position = v47
            u4.Size = v48
            u4.TextSize = 21
            local v49 = fromOffset_upv_1(18, 32)
            local v50 = fromOffset_upv_1(186, 28)
            u5.Position = v49
            u5.Size = v50
            u5.TextSize = 23
            u10.Position = UDim2.new(1, -14, 0, 47)
            u12.Position = UDim2.new(1, -38, 0, 47)
            local v51 = fromOffset_upv_1(19, 76)
            local v52 = fromOffset_upv_1(8, 8)
            u6.Position = v51
            u6.Size = v52
            local v53 = fromOffset_upv_1(33, 67)
            local v54 = fromOffset_upv_1(252, 18)
            u7.Position = v53
            u7.Size = v54
            u7.TextSize = 15
            for _, value_2 in {u14, u15, u16} do
                value_2.Instance.AnchorPoint = Vector2.new(1, 1)
                value_2.Instance.Position = UDim2.new(1, -28, 1, -40)
                value_2.Instance.Size = fromOffset_upv_1(300, 54)
                value_2.Label.TextSize = 22
            end
        end
        placeLock()
    end
    local u22 = false
    local u23 = ""
    local u24 = false
    local u25 = false
    local function paint()
        --[[
          name: paint
          line: 385
          upvalues:
            Custom_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            u1 (ref,  index: 3)
            u2 (ref,  index: 4)
            u14 (ref,  index: 5)
            u15 (ref,  index: 6)
            u16 (ref,  index: 7)
            u22 (ref,  index: 8)
            build (copy, index: 9)
            layout (copy, index: 10)
            u24 (ref,  index: 11)
            UI_upv_1 (copy, index: 12)
            u25 (ref,  index: 13)
            u4 (ref,  index: 14)
            CustomMatch_upv_1 (copy, index: 15)
            u9 (ref,  index: 16)
            u8 (ref,  index: 17)
            placeLock (copy, index: 18)
            u5 (ref,  index: 19)
            u13 (ref,  index: 20)
            u23 (ref,  index: 21)
            u12 (ref,  index: 22)
            Theme_upv_1 (copy, index: 23)
            Colors_upv_1 (copy, index: 24)
            u7 (ref,  index: 25)
            u6 (ref,  index: 26)
            u17 (ref,  index: 27)
        ]]
        local v55 = Custom_upv_1.IsServer()
        if a1.LobbyHud and a1.LobbyHud.SetPlayHidden then
            a1.LobbyHud.SetPlayHidden("Custom", v55)
        end
        local v56 = v55 and (Custom_upv_1.IsHost())
        if a1.TopbarSettings and a1.TopbarSettings.SetHostVisible then
            a1.TopbarSettings.SetHostVisible(v56)
        end
        local v57 = nil
        if v55 then
            build()
            layout()
            v55 = Custom_upv_1.State() or {}
            u2.Visible = true
            local v58 = false
            local v59 = 0
            local v60
            if type(v55.players) ~= "table" then
                v60 = {}
            else
                v60 = v55.players
            end
            for _, value_3 in v60 do
                if type(value_3) ~= "table" or value_3.userId ~= a1.Player.UserId then
                    continue
                end
                v58 = value_3.playing == true
                if value_3.team == 1 then
                    v59 = value_3.team
                    continue
                end
                if value_3.team ~= 2 then
                    v59 = 0
                else
                    v59 = value_3.team
                end
            end
            local v61 = (v55.status == "Match") and (not v58)
            local Instance_1 = u14.Instance
            Instance_1.Visible = v55 and (not v61)
            local Instance_2 = u15.Instance
            Instance_2.Visible = not v55 and (not v61)
            u16.Instance.Visible = v61
            if v61 and not (u24) then
                UI_upv_1.Enter(u16.Instance, Vector2.new(0, 12), 0.05, u16.Instance.Position)
            end
            if not (u25) and type(v55.status) == "string" then
                u25 = true
                if v61 then
                    a1.Toast("A match is in progress. Watch it while you wait for the next one.", "info")
                end
            end
            u24 = v61
            v61 = Custom_upv_1.IsPrivate() and (not Custom_upv_1.IsRevealed())
            u4.Text = CustomMatch_upv_1.FormatCode(Custom_upv_1.Code())
            u4.Visible = not v61
            u9.Visible = v61
            u8.Visible = Custom_upv_1.IsPrivate()
            placeLock()
            u5.AutoLocalize = false
            u5.Text = tostring(v55.name or "Custom match")
            v61 = CustomMatch_upv_1.Mode(v55.mode) == "1v1"
            v57 = CustomMatch_upv_1.ModeLabel(v55.mode)
            if u13.Text ~= v57 then
                u13.Text = v57
                if u23 ~= "" then
                    UI_upv_1.Pop(u12, 0.8, Theme_upv_1.Tween.PopSmall)
                end
            end
            local v62
            if v61 then
                v62 = Colors_upv_1.Accent
            else
                v62 = Colors_upv_1.Raised
            end
            u12.BackgroundColor3 = v62
            local v63 = u13
            local v64
            if v61 then
                v64 = Colors_upv_1.Text
            else
                v64 = Colors_upv_1.TextDim
            end
            v63.TextColor3 = v64
            if type(v55.players) ~= "table" then
                v61 = 0
            else
                v61 = #v55.players
            end
            v58 = tonumber(v55.max) or (CustomMatch_upv_1.MAX_PLAYERS)
            local v65 = v55.status or "Lobby"
            local v66
            if v65 == "Match" then
                local v67 = string.format("Match in progress  \194\183  %d/%d", v61, v58)
                v66 = Colors_upv_1.Warning
                v64 = v67
            elseif v65 == "Results" then
                v64, v66 = "Showing the results", Colors_upv_1.Accent
            elseif v55 then
                if v55.canStart == true or type(v55.startHint) ~= "string" or v55.startHint == "" then
                    if v55 then
                        v64, v66 = string.format("You're the host  \194\183  %s", tostring(v55.mapName or "Random")), Colors_upv_1.Success
                    elseif v59 == 0 then
                        v64, v66 = string.format("Waiting for the host  \194\183  %d/%d", v61, v58), Colors_upv_1.Success
                    else
                        v64, v66 = string.format("Team %d  \194\183  Waiting for the host", v59), Colors_upv_1.Success
                    end
                else
                    v64, v66 = v55.startHint, Colors_upv_1.Warning
                end
            elseif v55 then
                v64, v66 = string.format("You're the host  \194\183  %s", tostring(v55.mapName or "Random")), Colors_upv_1.Success
            elseif v59 == 0 then
                v64, v66 = string.format("Waiting for the host  \194\183  %d/%d", v61, v58), Colors_upv_1.Success
            else
                v64, v66 = string.format("Team %d  \194\183  Waiting for the host", v59), Colors_upv_1.Success
            end
            u7.Text = v64
            u6.BackgroundColor3 = v66
            local v68 = u14
            local v69 = false
            if v55.canStart == true then
                v69 = not u17
            end
            v68:SetEnabled(v69)
            if v55 and not (u22) then
                UI_upv_1.Enter(u14.Instance, Vector2.new(0, 12), 0.05, u14.Instance.Position)
            end
            if v65 ~= u23 then
                u23 = v65
                UI_upv_1.Pop(u6, 1.8)
            end
            u22 = v55
        else
            if u1 then
                u2.Visible = false
                u14.Instance.Visible = false
                u15.Instance.Visible = false
                u16.Instance.Visible = false
            end
            u22 = false
        end
    end
    Custom_upv_1.Changed:Connect(paint)
    Custom_upv_1.RevealChanged:Connect(paint)
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 480
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
                  line: 487
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
              line: 497
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
                local v70 = Keybinds_upv_1.IsPad(a3, "CustomMenu") and ((State_upv_1.Get("State") ~= "Match") and ((State_upv_1.Get("CombatMode") ~= true) and (not Keybinds_upv_1.PadBlocked() or (a1.MenuManager.IsOpen("CustomHost")))))
                if v70 or Keybinds_upv_1.ActionOf(a3) == "CustomMenu" then
                    a1.MenuManager.Toggle("CustomHost")
                end
            end
        end
    )
    task.spawn(
        function()
            --[[
              line: 509
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
                local v71 = TweenInfo.new(0.6, Enum.EasingStyle.Sine)
                local tbl_4 = {BackgroundTransparency = 0}
                tbl_4.BackgroundTransparency = ((u6.BackgroundTransparency < 0.3) and 0.55) or 0
                Tween_3(u6, v71, tbl_4)
            end
        end
    )
    paint()
    ProximityPromptService_upv_1.PromptShown:Connect(
        function(a5)
            --[[
              line: 520
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
                      line: 523
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
          line: 535
          upvalues:
            openConfirm (copy, index: 1)
            u18 (ref,  index: 2)
            a1 (copy, index: 3)
            u14 (ref,  index: 4)
            u16 (ref,  index: 5)
            Custom_upv_1 (copy, index: 6)
            u1 (ref,  index: 7)
            u2 (ref,  index: 8)
            u7 (ref,  index: 9)
            u9 (ref,  index: 10)
            u4 (ref,  index: 11)
            u8 (ref,  index: 12)
            u13 (ref,  index: 13)
            u15 (ref,  index: 14)
        ]]
        if a6 == "leave" then
            openConfirm()
        elseif a6 == "closeConfirm" then
            if u18 then
                u18.Visible = false
            end
            a1.MenuManager.PopMouse("CustomLeave")
            a1.MenuManager.PopFocus("CustomLeave")
        elseif a6 == "start" then
            u14.Activated:Fire()
        elseif a6 == "watch" then
            u16.Activated:Fire()
        elseif a6 == "leaveYes" then
            if u18 then
                u18.Visible = false
            end
            a1.MenuManager.PopMouse("CustomLeave")
            a1.MenuManager.PopFocus("CustomLeave")
            task.spawn(
                function()
                    --[[
                      line: 68
                      upvalues:
                        Custom_upv_1 (copy, index: 1)
                        a1 (copy, index: 2)
                    ]]
                    local v72, v73 = Custom_upv_1.Action("Leave")
                    if (v72) then
                        return
                    end
                    a1.Toast(tostring(v73), "error")
                end
            )
        end
        local tbl_5 = {code = 0, crown = 0, watch = 0, leave = 0, card = 0, status = 0, mode = 0, start = 0, lock = 0}
        tbl_5.custom = Custom_upv_1.IsServer()
        tbl_5.host = Custom_upv_1.IsHost()
        tbl_5.card = u1 and (u2.Visible)
        local v74 = ((not u1) and "") or (u7.Text)
        tbl_5.status = v74
        if u1 then
            if u9.Visible then
                v74 = Custom_upv_1.MASK
            else
                v74 = u4.Text
            end
        else
            v74 = ""
        end
        tbl_5.code = v74
        tbl_5.lock = u1 and (u8.Visible)
        if u1 then
            v74 = u13.Text
        else
            v74 = false
        end
        tbl_5.mode = v74
        tbl_5.start = u1 and (u14.Instance.Visible)
        tbl_5.leave = u1 and (u15.Instance.Visible)
        tbl_5.watch = u1 and (u16.Instance.Visible)
        tbl_5.crown = ((a1.TopbarSettings) and (a1.TopbarSettings.HostButton.Visible)) or false
        return tbl_5
    end
    a1.Debug.custom = function(a7, a8)
        --[[
          line: 561
          upvalues:
            Custom_upv_1 (copy, index: 1)
        ]]
        if a7 == "mock" then
            Custom_upv_1.SetMock(a8)
        end
        local v75 = Custom_upv_1.State()
        local tbl_6 = {status = 0}
        tbl_6.server = Custom_upv_1.IsServer()
        tbl_6.host = Custom_upv_1.IsHost()
        tbl_6.code = Custom_upv_1.Code()
        tbl_6.status = (v75 and (v75.status)) or false
        return tbl_6
    end
end
return tbl_1