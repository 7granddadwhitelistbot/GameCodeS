local tbl_1 = {}
local tbl_upv_2 = {error = "Error", warning = "Notify", info = "Notify", success = "Select"}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 13
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_1 = a1.Theme
    local State_1 = a1.State
    local Colors_upv_1 = Theme_1.Colors
    local Fonts_upv_1 = Theme_1.Fonts
    local tbl_upv_3 = {}
    tbl_upv_3.info = Colors_upv_1.Accent
    tbl_upv_3.success = Colors_upv_1.Success
    tbl_upv_3.warning = Colors_upv_1.Warning
    tbl_upv_3.error = Colors_upv_1.Danger
    local tbl_4 = {}
    tbl_4.Name = "Toasts"
    tbl_4.AnchorPoint = Vector2.new(0.5, 0)
    tbl_4.Position = UDim2.new(0.5, 0, 0, 120)
    tbl_4.Size = UDim2.fromOffset(640, 200)
    tbl_4[1] = UI_upv_1.List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)
    tbl_4.Parent = a1.Canvas.Overlay
    local u1 = UI_upv_1.new("Frame", tbl_4)
    local u2 = false
    local tbl_upv_5 = {}
    local function shown(a2)
        --[[
          name: shown
          line: 29
        ]]
        local v1 = a2
        while v1 and not v1:IsA("PlayerGui") do
            if not (v1:IsA("GuiObject")) or v1.Visible then
                if not (v1:IsA("ScreenGui")) or v1.Enabled then
                    v1 = v1.Parent
                    continue
                end
                return false
            end
            return false
        end
        return v1 ~= nil
    end
    local function place()
        --[[
          name: place
          line: 41
          upvalues:
            UI_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
            u1 (copy, index: 3)
            tbl_upv_5 (copy, index: 4)
            shown (copy, index: 5)
        ]]
        local v2 = UI_upv_1.TopInset() + 4
        if not (u2) then
            local Y_1 = u1.Parent.AbsolutePosition.Y
            local v3 = math.max(UI_upv_1.Scale, 0.01)
            for _, value_1 in tbl_upv_5 do
                if not (value_1.Parent) then
                    continue
                end
                local v4 = shown(value_1)
                if not (v4) then
                    continue
                end
                if value_1.AbsoluteSize.Y > 0 then
                    v2 = math.max(v2, math.ceil(((value_1.AbsolutePosition.Y + value_1.AbsoluteSize.Y) - Y_1) / v3) + 8)
                end
            end
        end
        u1.Position = UDim2.new(0.5, 0, 0, v2)
    end
    a1.MenuManager.Changed:Connect(
        function(a3)
            --[[
              line: 54
              upvalues:
                u2 (ref,  index: 1)
                place (copy, index: 2)
            ]]
            u2 = a3 ~= nil
            place()
        end
    )
    function a1.ToastAvoid(a4, a5)
        --[[
          name: ToastAvoid
          line: 58
          upvalues:
            tbl_upv_5 (copy, index: 1)
            place (copy, index: 2)
        ]]
        tbl_upv_5[a4] = a5
        place()
    end
    UI_upv_1.LayoutChanged:Connect(place)
    UI_upv_1.TopInsetChanged:Connect(place)
    place()
    local tbl_upv_6 = {}
    local tbl_upv_7 = {}
    local u3 = 0
    local function release(a6)
        --[[
          name: release
          line: 112
          upvalues:
            tbl_upv_6 (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
        ]]
        local v5 = table.find(tbl_upv_6, a6)
        if v5 then
            table.remove(tbl_upv_6, v5)
        end
        a6.holder.Parent = nil
        table.insert(tbl_upv_7, a6)
    end
    local u4 = -math.huge
    local function dismiss(a7)
        --[[
          name: dismiss
          line: 121
          upvalues:
            UI_upv_1 (copy, index: 1)
            tbl_upv_6 (copy, index: 2)
            tbl_upv_7 (copy, index: 3)
        ]]
        a7.token = a7.token + 1
        local token_upv_1 = a7.token
        UI_upv_1.FadeOut(a7.inner, TweenInfo.new(0.2))
        task.delay(
            0.22,
            function()
                --[[
                  line: 125
                  upvalues:
                    a7 (copy, index: 1)
                    token_upv_1 (copy, index: 2)
                    tbl_upv_6 (copy, index: 3)
                    tbl_upv_7 (copy, index: 4)
                ]]
                if a7.token == token_upv_1 then
                    local v6 = a7
                    local v7 = table.find(tbl_upv_6, v6)
                    if v7 then
                        table.remove(tbl_upv_6, v7)
                    end
                    v6.holder.Parent = nil
                    table.insert(tbl_upv_7, v6)
                end
            end
        )
    end
    local function newRow()
        --[[
          name: newRow
          line: 71
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
        ]]
        local v8 = UI_upv_1.new("Frame", {Name = "Toast", Size = UDim2.fromOffset(0, 44), AutomaticSize = Enum.AutomaticSize.X})
        local tbl_8 = {}
        tbl_8.Name = "Inner"
        tbl_8.Size = UDim2.fromOffset(0, 44)
        tbl_8.AutomaticSize = Enum.AutomaticSize.X
        tbl_8.BackgroundColor3 = Colors_upv_1.Panel
        tbl_8.BackgroundTransparency = 0.12
        tbl_8[1], tbl_8[2], tbl_8[3] = UI_upv_1.Corner(10), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.7), UI_upv_1.Padding(0, 18, 0, 22)
        tbl_8.Parent = v8
        local v9 = UI_upv_1.new("Frame", tbl_8)
        local tbl_9 = {}
        tbl_9.Name = "Accent"
        tbl_9.Position = UDim2.fromOffset(-14, 8)
        tbl_9.Size = UDim2.new(0, 5, 1, -16)
        tbl_9.BackgroundColor3 = Colors_upv_1.Accent
        tbl_9[1] = UI_upv_1.Corner(3)
        tbl_9.Parent = v9
        local v10 = UI_upv_1.new("Frame", tbl_9)
        tbl_8 = UI_upv_1.new("TextLabel", {TextSize = 20, Name = "Text", AutoLocalize = false, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = v9})
        UI_upv_1.new("UISizeConstraint", {MaxSize = Vector2.new(620, 44), Parent = v9})
        tbl_8.TextTruncate = Enum.TextTruncate.AtEnd
        local tbl_10 = {token = 0, expire = 0, count = 1, text = ""}
        tbl_10.holder = v8
        tbl_10.inner = v9
        tbl_10.bar = v10
        tbl_10.label = tbl_8
        return tbl_10
    end
    local function toast(a8, a9, a10)
        --[[
          name: toast
          line: 133
          upvalues:
            tbl_upv_3 (copy, index: 1)
            a1 (copy, index: 2)
            place (copy, index: 3)
            tbl_upv_6 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            dismiss (copy, index: 6)
            tbl_upv_7 (copy, index: 7)
            newRow (copy, index: 8)
            u3 (ref,  index: 9)
            u1 (copy, index: 10)
            u4 (ref,  index: 11)
            tbl_upv_2 (copy, index: 12)
        ]]
        if type(a8) ~= "string" or a8 == "" then
            return
        end
        local v11
        if (a9) and (tbl_upv_3[a9]) then
            v11 = a9
        else
            v11 = "info"
        end
        local v12 = a1.Loc.T(a8)
        place()
        for _, value_2 in tbl_upv_6 do
            if value_2.text ~= v12 then
                continue
            end
            value_2.count = value_2.count + 1
            value_2.label.Text = v12 .. "  \195\151" .. value_2.count
            value_2.expire = os.clock() + 3.5
            UI_upv_1.Bump(value_2.label, 0.08)
            return
        end
        if #tbl_upv_6 >= 3 then
            dismiss(tbl_upv_6[1])
            table.remove(tbl_upv_6, 1)
        end
        local u5 = table.remove(tbl_upv_7) or (newRow())
        u5.token = u5.token + 1
        local token_upv_2 = u5.token
        u3 = u3 + 1
        u5.text = v12
        u5.count = 1
        local v13 = os.clock()
        u5.expire = v13 + (((v11 ~= "error") and 3.5) or 3)
        u5.label.Text = v12
        u5.bar.BackgroundColor3 = tbl_upv_3[v11]
        u5.holder.LayoutOrder = u3
        u5.holder.Parent = u1
        table.insert(tbl_upv_6, u5)
        UI_upv_1.Enter(u5.inner, Vector2.new(0, -12), 0, UDim2.new())
        if a10 ~= true and os.clock() - u4 >= 1 then
            u4 = os.clock()
            a1.Sounds.Play(tbl_upv_2[v11])
        end
        task.spawn(
            function()
                --[[
                  line: 171
                  upvalues:
                    u5 (copy, index: 1)
                    token_upv_2 (copy, index: 2)
                    dismiss (copy, index: 3)
                ]]
                while u5.token == token_upv_2 do
                    if os.clock() < u5.expire then
                        task.wait(0.25)
                        continue
                    else
                        break
                    end
                end
                if u5.token ~= token_upv_2 then
                    return
                end
                dismiss(u5)
            end
        )
    end
    a1.Toast = toast
    State_1.Notify:Connect(toast)
end
return tbl_1