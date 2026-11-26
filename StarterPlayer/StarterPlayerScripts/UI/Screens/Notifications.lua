local v1 = {}
local v2 = {info = "Notify", success = "Select", warning = "Notify", error = "Error"}

function v1.Init(a3)
    --[[
      name: Init
      line: 13
      upvalues:
        v2 (copy, index: 1)
    ]]
    local ui = a3.UI
    local theme = a3.Theme
    local state = a3.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local v9 = {info = colors.Accent, success = colors.Success, warning = colors.Warning, error = colors.Danger}
    local parent = ui.new("Frame", {Name = "Toasts", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 120), Size = UDim2.fromOffset(640, 200), (ui.List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)), Parent = a3.Canvas.Overlay})
    local v11 = false
    local v12 = {}

    local function shown(a14)
        --[[
          name: shown
          line: 29
        ]]
        local v15
        v15 = a14

        while v15 and not v15:IsA("PlayerGui") do
            if v15:IsA("GuiObject") and not v15.Visible then
                return false
            end
            if v15:IsA("ScreenGui") and not v15.Enabled then
                return false
            end

            v15 = v15.Parent
        end

        local v16 = v15 ~= nil
        return v16
    end

    local function place()
        --[[
          name: place
          line: 41
          upvalues:
            ui (copy, index: 1)
            v11 (ref,  index: 2)
            parent (copy, index: 3)
            v12 (copy, index: 4)
            shown (copy, index: 5)
        ]]
        local v18 = ui.TopInset() + 4

        if not v11 then
            local y = parent.Parent.AbsolutePosition.Y
            local v20 = math.max(ui.Scale, 0.01)

            for _, v22 in v12 do
                if v22.Parent then
                    if not shown(v22) then
                        continue
                    end
                    if not (0 < v22.AbsoluteSize.Y) then
                        continue
                    end

                    v18 = math.max(v18, math.ceil(((v22.AbsolutePosition.Y + v22.AbsoluteSize.Y) - y) / v20) + 8)
                end
            end
        end

        parent.Position = UDim2.new(0.5, 0, 0, v18)
    end

    a3.MenuManager.Changed:Connect(
        function(a23)
            --[[
              line: 54
              upvalues:
                v11 (ref,  index: 1)
                place (copy, index: 2)
            ]]
            v11 = a23 ~= nil
            place()
        end
    )

    function a3.ToastAvoid(key, value)
        --[[
          name: ToastAvoid
          line: 58
          upvalues:
            v12 (copy, index: 1)
            place (copy, index: 2)
        ]]
        v12[key] = value
        place()
    end

    ui.LayoutChanged:Connect(place)
    ui.TopInsetChanged:Connect(place)
    place()
    local v26 = {}
    local v27 = {}
    local count = 0

    local function newRow()
        --[[
          name: newRow
          line: 71
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            fonts (copy, index: 3)
        ]]
        local ui2 = ui.new("Frame", {Name = "Toast", Size = UDim2.fromOffset(0, 44), AutomaticSize = Enum.AutomaticSize.X})
        local ui3 = ui.new("Frame", {Name = "Inner", Size = UDim2.fromOffset(0, 44), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.12, ui.Corner(10), ui.Stroke(colors.Stroke, 1.5, 0.7), (ui.Padding(0, 18, 0, 22)), Parent = ui2})
        local bar = ui.new("Frame", {Name = "Accent", Position = UDim2.fromOffset(-14, 8), Size = UDim2.new(0, 5, 1, -16), BackgroundColor3 = colors.Accent, (ui.Corner(3)), Parent = ui3})
        local label = ui.new("TextLabel", {Name = "Text", AutoLocalize = false, TextSize = 20, Size = UDim2.fromScale(0, 1), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = ui3})
        ui.new("UISizeConstraint", {MaxSize = Vector2.new(620, 44), Parent = ui3})
        label.TextTruncate = Enum.TextTruncate.AtEnd

        return {text = "", count = 1, expire = 0, token = 0, holder = ui2, inner = ui3, bar = bar, label = label}
    end

    local function release(target)
        --[[
          name: release
          line: 112
          upvalues:
            v26 (copy, index: 1)
            v27 (copy, index: 2)
        ]]
        if const index = table.find(v26, target) then
            table.remove(v26, index)
        end

        target.holder.Parent = nil
        table.insert(v27, target)
    end

    local function dismiss(target)
        --[[
          name: dismiss
          line: 121
          upvalues:
            ui (copy, index: 1)
            v26 (copy, index: 2)
            v27 (copy, index: 3)
        ]]
        target.token += 1
        local token = target.token
        ui.FadeOut(target.inner, TweenInfo.new(0.2))

        task.delay(
            0.22,
            function()
                --[[
                  line: 125
                  upvalues:
                    target (copy, index: 1)
                    token (copy, index: 2)
                    v26 (copy, index: 3)
                    v27 (copy, index: 4)
                ]]
                if target.token == token then
                    local target2 = target

                    if const index = table.find(v26, target2) then
                        table.remove(v26, index)
                    end

                    target2.holder.Parent = nil
                    table.insert(v27, target2)
                end
            end
        )
    end

    local timestamp = -math.huge

    local function toast(a44, key, a46)
        --[[
          name: toast
          line: 133
          upvalues:
            v9 (copy, index: 1)
            a3 (copy, index: 2)
            place (copy, index: 3)
            v26 (copy, index: 4)
            ui (copy, index: 5)
            dismiss (copy, index: 6)
            v27 (copy, index: 7)
            newRow (copy, index: 8)
            count (ref,  index: 9)
            parent (copy, index: 10)
            timestamp (ref,  index: 11)
            v2 (copy, index: 12)
        ]]
        if type(a44) ~= "string" or a44 == "" then
            return
        end

        local v47 = if key and v9[key] then key else "info"
        local text = a3.Loc.T(a44)
        place()

        for _, v50 in v26 do
            if v50.text == text then
                v50.count += 1
                v50.label.Text = text .. "  ×" .. v50.count
                v50.expire = os.clock() + 3.5
                ui.Bump(v50.label, 0.08)

                return
            end
        end

        if 3 <= #v26 then
            dismiss(v26[1])
            table.remove(v26, 1)
        end

        local v51 = table.remove(v27) or newRow()
        v51.token += 1
        local token = v51.token
        count += 1
        v51.text = text
        v51.count = 1
        local timestamp2 = os.clock()
        local v54 = v47 ~= "error" and 3.5 or 3
        v51.expire = timestamp2 + v54
        v51.label.Text = text
        v51.bar.BackgroundColor3 = v9[v47]
        v51.holder.LayoutOrder = count
        v51.holder.Parent = parent
        table.insert(v26, v51)
        ui.Enter(v51.inner, Vector2.new(0, -12), 0, UDim2.new())

        if a46 ~= true and 1 <= os.clock() - timestamp then
            timestamp = os.clock()
            a3.Sounds.Play(v2[v47])
        end

        task.spawn(
            function()
                --[[
                  line: 171
                  upvalues:
                    v51 (copy, index: 1)
                    token (copy, index: 2)
                    dismiss (copy, index: 3)
                ]]
                while v51.token == token do
                    local timestamp = os.clock()

                    if not (timestamp < v51.expire) then
                        break
                    end

                    task.wait(0.25)
                end

                if v51.token == token then
                    dismiss(v51)
                end
            end
        )
    end

    a3.Toast = toast
    state.Notify:Connect(toast)
end

return v1