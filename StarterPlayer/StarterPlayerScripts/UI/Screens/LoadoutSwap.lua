local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Keybinds_upv_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Keybinds"))
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 36
      upvalues:
        Players_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        Keybinds_upv_1 (copy, index: 4)
        UserInputService_upv_1 (copy, index: 5)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local LOADOUT_SWAP_CUTOFF_upv_1 = 0.3
    local Config_upv_1 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Config")
    local success_1, v1 = pcall(
        function()
            --[[
              line: 44
              upvalues:
                Config_upv_1 (copy, index: 1)
            ]]
            if Config_upv_1 then
                return (require(Config_upv_1))
            end
            return nil
        end
    )
    if success_1 and type(v1) == "table" and type(v1.LOADOUT_SWAP_CUTOFF) == "number" then
        LOADOUT_SWAP_CUTOFF_upv_1 = v1.LOADOUT_SWAP_CUTOFF
    end
    local u1 = LOADOUT_SWAP_CUTOFF_upv_1 + 0.12
    local u2 = LOADOUT_SWAP_CUTOFF_upv_1 + 0.25
    LOADOUT_SWAP_CUTOFF_upv_1 = UI_upv_1.new("Frame", {Name = "LoadoutSwap", Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(800, 90), Parent = a1.Canvas.HUD})
    local u3 = UI_upv_1.new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, 22), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = LOADOUT_SWAP_CUTOFF_upv_1})
    local u4 = UI_upv_1.ActionCap("NextLoadout", {Height = 20, LayoutOrder = 1, Parent = u3})
    local u5 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "SWITCH LOADOUT", Name = "Title", TextSize = 15, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20), FontFace = Fonts_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u3})
    local u6 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35)
    u6.Parent = u5
    local u7 = UI_upv_1.new("Frame", {Name = "Cards", Position = UDim2.fromOffset(0, 26), Size = UDim2.new(1, 0, 0, 58), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = LOADOUT_SWAP_CUTOFF_upv_1})
    local tbl_upv_2 = {}
    local u8 = nil
    local u9 = nil
    local u10 = false
    for n_upv_1 = 1, 5 do
        local v2 = UI_upv_1.new("TextButton", {Name = "Slot" .. n_upv_1, Size = UDim2.fromOffset(128, 60), Text = "", AutoButtonColor = false, BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.25, LayoutOrder = n_upv_1, [1] = UI_upv_1.Corner(10), Parent = u7})
        local v3 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.82)
        v3.Parent = v2
        local v4 = UI_upv_1.new("TextLabel", {Name = "Num", ZIndex = 3, TextSize = 15, Position = UDim2.fromOffset(7, 3), Size = UDim2.fromOffset(16, 16), Text = tostring(n_upv_1), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = v2})
        local v5 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3)
        v5.Parent = v4
        local v6 = UI_upv_1.new("Frame", {Name = "Icons", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.new(1, -10, 0, 40), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 2, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center), Parent = v2})
        local tbl_3 = {}
        for n_2 = 1, 3 do
            tbl_3[n_2] = UI_upv_1.new("Frame", {ZIndex = 2, Visible = false, Name = "I" .. n_2, Size = UDim2.fromOffset(38, 38), LayoutOrder = n_2, Parent = v6})
        end
        local v7 = UI_upv_1.new("TextLabel", {Visible = false, Text = "", Name = "More", ZIndex = 3, TextSize = 13, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -6, 1, -2), Size = UDim2.fromOffset(30, 16), FontFace = Fonts_1.Display, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v2})
        local v8 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3)
        v8.Parent = v7
        local tbl_upv_4 = {hover = false}
        tbl_upv_4.btn = v2
        tbl_upv_4.stroke = v3
        tbl_upv_4.num = v4
        tbl_upv_4.numStroke = v5
        tbl_upv_4.icons = v6
        tbl_upv_4.holders = tbl_3
        tbl_upv_4.more = v7
        tbl_upv_4.moreStroke = v8
        tbl_upv_2[n_upv_1] = tbl_upv_4
        v2.Activated:Connect(
            function()
                --[[
                  line: 164
                  upvalues:
                    u8 (ref,  index: 1)
                    n_upv_1 (copy, index: 2)
                ]]
                u8(n_upv_1, "tap")
            end
        )
        v2.MouseEnter:Connect(
            function()
                --[[
                  line: 167
                  upvalues:
                    tbl_upv_4 (copy, index: 1)
                    u9 (ref,  index: 2)
                ]]
                tbl_upv_4.hover = true
                if not u9 then
                    return
                end
                u9()
            end
        )
        v2.MouseLeave:Connect(
            function()
                --[[
                  line: 173
                  upvalues:
                    tbl_upv_4 (copy, index: 1)
                    u9 (ref,  index: 2)
                ]]
                tbl_upv_4.hover = false
                if not u9 then
                    return
                end
                u9()
            end
        )
        for _, value_1 in tbl_3 do
            value_1.ChildAdded:Connect(
                function()
                    --[[
                      line: 181
                      upvalues:
                        u9 (ref, index: 1)
                        u10 (ref, index: 2)
                    ]]
                    if not u9 or (u10) then
                        return
                    end
                    u10 = true
                    task.defer(
                        function()
                            --[[
                              line: 184
                              upvalues:
                                u10 (ref, index: 1)
                                u9 (ref, index: 2)
                            ]]
                            u10 = false
                            if not u9 then
                                return
                            end
                            u9()
                        end
                    )
                end
            )
        end
    end
    local u11 = 0
    local u12 = 1
    local u13 = 0
    local u14 = 0
    local u15 = nil
    local function slotCount()
        --[[
          name: slotCount
          line: 202
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        if State_upv_1.HasLoadoutSlots() then
            return (math.min(State_upv_1.LoadoutSlotCount(), 5))
        end
        return 0
    end
    local tbl_upv_5 = {outline = false, glow = true, glowTransparency = 1, transparency = 0.98}
    tbl_upv_5.glowColor = Color3.fromRGB(120, 132, 158)
    local function idsOf(a2)
        --[[
          name: idsOf
          line: 206
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v9 = State_upv_1.LoadoutSlot(a2)
        local tbl_6 = {}
        for _, value_2 in (v9 and (v9.items)) or {} do
            if type(value_2) == "string" then
                table.insert(tbl_6, value_2)
            end
        end
        if v9 and type(v9.armor) == "string" then
            table.insert(tbl_6, v9.armor)
        end
        return tbl_6
    end
    local u16 = 0
    local u17 = 0
    local function paint()
        --[[
          name: paint
          line: 243
          upvalues:
            u16 (ref,  index: 1)
            tbl_upv_2 (copy, index: 2)
            u11 (ref,  index: 3)
            u12 (ref,  index: 4)
            Colors_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            WeaponIcon_upv_1 (copy, index: 7)
            u5 (copy, index: 8)
            u6 (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            u4 (copy, index: 11)
        ]]
        local v10 = u16
        local v11 = 1 - v10
        local v12 = nil
        local v15 = nil
        local v16 = nil
        for key_1, value_3 in tbl_upv_2 do
            if u11 < key_1 then
                continue
            end
            local v13 = key_1 == u12
            local btn_1 = value_3.btn
            if v13 then
                v12 = Colors_upv_1.Accent
            elseif value_3.hover then
                v12 = Colors_upv_1.PanelHi
            else
                v12 = Colors_upv_1.Panel
            end
            btn_1.BackgroundColor3 = v12
            local btn_2 = value_3.btn
            btn_2.BackgroundTransparency = ((v13 and 0.06) or 0.25) + ((1 - ((v13 and 0.06) or 0.25)) * v11)
            local stroke_1 = value_3.stroke
            if v13 then
                v12 = Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.45)
            else
                v12 = Colors_upv_1.Stroke
            end
            stroke_1.Color = v12
            value_3.stroke.Thickness = (v13 and 2) or 1.5
            local stroke_2 = value_3.stroke
            local v14 = (v13 and 0.15) or 0.82
            stroke_2.Transparency = v14 + ((1 - ((v13 and 0.15) or 0.82)) * v11)
            local num_1 = value_3.num
            if v13 then
                v12 = Colors_upv_1.Text
            else
                v12 = Colors_upv_1.TextDim
            end
            num_1.TextColor3 = v12
            value_3.num.TextTransparency = v11
            value_3.numStroke.Transparency = (v11 * 0.7) + 0.3
            local more_1 = value_3.more
            if v13 then
                v12 = Colors_upv_1.Text
            else
                v12 = Colors_upv_1.TextDim
            end
            more_1.TextColor3 = v12
            value_3.more.TextTransparency = v11
            value_3.moreStroke.Transparency = (v11 * 0.7) + 0.3
            local btn_3 = value_3.btn
            if v10 >= 0.5 then
                v12 = true
            else
                v12 = false
            end
            btn_3.Interactable = v12
            for v17, value_4 in value_3.holders do
                if not (value_4.Visible) then
                    continue
                end
                WeaponIcon_upv_1.SetTransparency(value_4, v11 * 0.98)
                local WeaponGlow_1 = value_4:FindFirstChild("WeaponGlow")
                if not (WeaponGlow_1) then
                    continue
                end
                if WeaponGlow_1:IsA("ImageLabel") then
                    WeaponGlow_1.ImageTransparency = (v11 * 0.55) + 0.45
                end
            end
        end
        u5.TextTransparency = v11
        u6.Transparency = (v11 * 0.65) + 0.35
        UI_upv_1.SetCapFade(u4, v11)
    end
    local function layout()
        --[[
          name: layout
          line: 282
          upvalues:
            UI_upv_1 (copy, index: 1)
            u11 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            u7 (copy, index: 5)
            u3 (copy, index: 6)
            LOADOUT_SWAP_CUTOFF_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        local Compact_1 = UI_upv_1.Compact
        local v15 = ((not (State_upv_1.HasLoadoutSlots())) and 0) or (math.min(State_upv_1.LoadoutSlotCount(), 5))
        u11 = v15
        local v16 = (Compact_1 and 108) or 128
        local v17 = (Compact_1 and 44) or 60
        local v18 = (Compact_1 and 30) or 38
        local v19 = (Compact_1 and 6) or 8
        for key_2, value_5 in tbl_upv_2 do
            value_5.btn.Visible = key_2 <= u11
            value_5.btn.Size = UDim2.fromOffset(v16, v17)
            value_5.icons.Size = UDim2.new(1, -8, 0, v18 + 2)
            for _, value_6 in value_5.holders do
                value_6.Size = UDim2.fromOffset(v18, v18)
            end
        end
        local v20 = u7:FindFirstChildOfClass("UIListLayout")
        if v20 then
            v20.Padding = UDim.new(0, v19)
            local v21
            if Compact_1 then
                v21 = Enum.FillDirection.Vertical
            else
                v21 = Enum.FillDirection.Horizontal
            end
            v20.FillDirection = v21
        end
        local v22 = math.max(u11, 1)
        if Compact_1 then
            u3.Visible = false
            u7.Position = UDim2.new()
            u7.Size = UDim2.fromScale(1, 1)
            LOADOUT_SWAP_CUTOFF_upv_1.AnchorPoint = Vector2.new(0, 0.5)
            LOADOUT_SWAP_CUTOFF_upv_1.Size = UDim2.fromOffset(v16, (v22 * v17) + ((v22 - 1) * v19))
            LOADOUT_SWAP_CUTOFF_upv_1.Position = UDim2.new(0, 12, 0.45, 0)
        else
            u3.Visible = true
            u7.Position = UDim2.fromOffset(0, 26)
            u7.Size = UDim2.new(1, 0, 0, v17)
            LOADOUT_SWAP_CUTOFF_upv_1.AnchorPoint = Vector2.new(0.5, 1)
            LOADOUT_SWAP_CUTOFF_upv_1.Size = UDim2.fromOffset((v22 * v16) + ((v22 - 1) * v19), v17 + 26)
            local v21 = ((not (a1.HotbarTop)) and 104) or (a1.HotbarTop())
            LOADOUT_SWAP_CUTOFF_upv_1.Position = UDim2.new(0.5, 0, 1, -(((v21 + 70) + 28) + 6))
        end
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    if a1.HotbarChanged then
        a1.HotbarChanged.Event:Connect(layout)
    end
    local function fillCard(a3, a4)
        --[[
          name: fillCard
          line: 223
          upvalues:
            idsOf (copy, index: 1)
            WeaponIcon_upv_1 (copy, index: 2)
            tbl_upv_5 (copy, index: 3)
        ]]
        local v23 = idsOf(a4)
        local v24 = table.concat(v23, ",")
        if a3.sig == v24 then
            return
        end
        a3.sig = v24
        local v25 = math.min(#v23, 3)
        local v26 = nil
        local v27 = nil
        for key_3, value_7 in a3.holders do
            if key_3 <= v25 then
                v26 = v23[key_3]
            else
                v26 = nil
            end
            if v26 ~= nil then
                v27 = true
            else
                v27 = false
            end
            value_7.Visible = v27
            WeaponIcon_upv_1.Set(value_7, v26, tbl_upv_5)
        end
        a3.more.Visible = v25 < #v23
        a3.more.Text = "+" .. tostring(#v23 - v25)
    end
    local function refreshCards()
        --[[
          name: refreshCards
          line: 331
          upvalues:
            State_upv_1 (copy, index: 1)
            u11 (ref,  index: 2)
            layout (copy, index: 3)
            u13 (ref,  index: 4)
            u12 (ref,  index: 5)
            fillCard (copy, index: 6)
            tbl_upv_2 (copy, index: 7)
            paint (copy, index: 8)
        ]]
        local v28 = ((not (State_upv_1.HasLoadoutSlots())) and 0) or (math.min(State_upv_1.LoadoutSlotCount(), 5))
        if v28 ~= u11 then
            layout()
        end
        if u13 == 0 then
            u12 = State_upv_1.ActiveLoadout()
        end
        for n_3 = 1, u11 do
            fillCard(tbl_upv_2[n_3], n_3)
        end
        paint()
    end
    local function timeLeft()
        --[[
          name: timeLeft
          line: 346
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local v29, v30 = State_upv_1.PhaseClock()
        if v29 == "PreRound" and not (v30 <= 0) then
            return v30 - State_upv_1.Now()
        end
        return -1
    end
    local u18 = false
    local function setShown(a5)
        --[[
          name: setShown
          line: 363
          upvalues:
            u18 (ref,  index: 1)
            u17 (ref,  index: 2)
            u14 (ref,  index: 3)
            u13 (ref,  index: 4)
            refreshCards (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            LOADOUT_SWAP_CUTOFF_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
        ]]
        if a5 == u18 then
            return
        end
        u18 = a5
        u17 = (a5 and 1) or 0
        if a5 then
            u14 = u14 + 1
            u13 = 0
            refreshCards()
            local SlideIn_1 = UI_upv_1.SlideIn
            local v31
            if UI_upv_1.Compact then
                v31 = Vector2.new(-18, 0)
            else
                v31 = Vector2.new(0, 18)
            end
            SlideIn_1(LOADOUT_SWAP_CUTOFF_upv_1, v31, Theme_upv_1.Tween.Smooth)
        end
    end
    local u19 = nil
    local function baseOk()
        --[[
          name: baseOk
          line: 353
          upvalues:
            State_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
        ]]
        local v32 = State_upv_1.InMatch()
        local v33 = nil
        if v32 then
            v33 = State_upv_1.IsAlive()
            if v33 then
                local v34 = false
                local v35 = nil
                if State_upv_1.Get("CombatMode") == false then
                    v32 = v34
                else
                    v35 = not a1.HudHidden
                    local v36 = nil
                    if v35 then
                        v36 = not a1.MenuManager.IsOpen()
                        if v36 then
                            local v37 = false
                            if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") == true then
                                v32 = v37
                            else
                                local v38 = ((not (State_upv_1.HasLoadoutSlots())) and 0) or (math.min(State_upv_1.LoadoutSlotCount(), 5))
                                if v38 >= 2 then
                                    v32 = true
                                else
                                    v32 = false
                                end
                            end
                        else
                            v32 = v36
                        end
                    else
                        v32 = v35
                    end
                end
            else
                v32 = v33
            end
        end
        return v32
    end
    local function frame(a6)
        --[[
          name: frame
          line: 378
          upvalues:
            State_upv_1 (copy, index: 1)
            setShown (copy, index: 2)
            u2 (copy, index: 3)
            baseOk (copy, index: 4)
            u16 (ref,  index: 5)
            u17 (ref,  index: 6)
            paint (copy, index: 7)
        ]]
        local v39, v40 = State_upv_1.PhaseClock()
        local v41
        if v39 ~= "PreRound" or v40 <= 0 then
            v41 = -1
        else
            v41 = v40 - State_upv_1.Now()
        end
        local v42 = false
        if u2 < v41 then
            v42 = baseOk()
        end
        setShown(v42)
        if u16 ~= u17 then
            local v43 = ((u16 < u17) and 0.18) or 0.14
            local v44 = a6 / v43
            local v45
            if u16 < u17 then
                v45 = math.min(u17, u16 + v44)
            else
                v45 = math.max(u17, u16 - v44)
            end
            u16 = v45
            paint()
        end
    end
    local function watch()
        --[[
          name: watch
          line: 387
          upvalues:
            State_upv_1 (copy, index: 1)
            u19 (ref,  index: 2)
            RunService_upv_1 (copy, index: 3)
            frame (copy, index: 4)
            u18 (ref,  index: 5)
            u16 (ref,  index: 6)
            u17 (ref,  index: 7)
            refreshCards (copy, index: 8)
            LOADOUT_SWAP_CUTOFF_upv_1 (copy, index: 9)
            u11 (ref,  index: 10)
        ]]
        local v46 = State_upv_1.InMatch()
        if not (v46) or u19 then
            if not (v46) and u19 then
                u19:Disconnect()
                u19 = nil
                u18 = false
                u16 = 0
                u17 = 0
            end
        else
            u19 = RunService_upv_1.RenderStepped:Connect(frame)
        end
        refreshCards()
        LOADOUT_SWAP_CUTOFF_upv_1.Visible = v46 and (u11 >= 2)
    end
    watch()
    State_upv_1.PlayerStateChanged:Connect(watch)
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 402
              upvalues:
                State_upv_1 (copy, index: 1)
                refreshCards (copy, index: 2)
                LOADOUT_SWAP_CUTOFF_upv_1 (copy, index: 3)
                u11 (ref,  index: 4)
            ]]
            if not State_upv_1.InMatch() then
                return
            end
            refreshCards()
            LOADOUT_SWAP_CUTOFF_upv_1.Visible = u11 >= 2
        end
    )
    local function snapBack()
        --[[
          name: snapBack
          line: 410
          upvalues:
            u12 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            paint (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            u7 (copy, index: 5)
            a1 (copy, index: 6)
        ]]
        u12 = State_upv_1.ActiveLoadout()
        paint()
        UI_upv_1.Shake(u7, 6)
        a1.Sounds.Play("Error")
    end
    local u20 = function(a7, a8)
        --[[
          line: 416
          upvalues:
            u18 (ref,  index: 1)
            u11 (ref,  index: 2)
            u12 (ref,  index: 3)
            UI_upv_1 (copy, index: 4)
            tbl_upv_2 (copy, index: 5)
            State_upv_1 (copy, index: 6)
            u1 (copy, index: 7)
            paint (copy, index: 8)
            a1 (copy, index: 9)
            u14 (ref,  index: 10)
            u13 (ref,  index: 11)
            u15 (ref,  index: 12)
            u7 (copy, index: 13)
        ]]
        if not u18 or (a7 < 1) or (u11 < a7) then
            return
        end
        if a7 ~= u12 then
            local v47, v48 = State_upv_1.PhaseClock()
            local v49
            if v47 ~= "PreRound" or v48 <= 0 then
                v49 = -1
            else
                v49 = v48 - State_upv_1.Now()
            end
            if v49 < u1 then
                return
            end
            u12 = a7
            paint()
            UI_upv_1.Bump(tbl_upv_2[a7].btn, 0.08)
            a1.Sounds.Play("Equip")
            u14 = u14 + 1
            local u21 = u14
            u13 = u13 + 1
            local v50, v51 = State_upv_1.PhaseClock()
            local v52
            if v50 ~= "PreRound" or v51 <= 0 then
                v52 = -1
            else
                v52 = v51 - State_upv_1.Now()
            end
            local v53
            if u1 < v52 - 0.15 then
                v53 = 0.15
            else
                v53 = 0
            end
            task.delay(
                v53,
                function()
                    --[[
                      line: 437
                      upvalues:
                        u12 (ref,  index: 1)
                        u21 (copy, index: 2)
                        u14 (ref,  index: 3)
                        u15 (ref,  index: 4)
                        State_upv_1 (copy, index: 5)
                        u13 (ref,  index: 6)
                        paint (copy, index: 7)
                        u1 (copy, index: 8)
                        UI_upv_1 (copy, index: 9)
                        u7 (copy, index: 10)
                        a1 (copy, index: 11)
                    ]]
                    local v54 = u21 ~= u14
                    local v55 = nil
                    if not (v54) then
                        v55 = u15 or (State_upv_1.ActiveLoadout())
                        if u12 ~= v55 then
                            local v56, v57 = State_upv_1.PhaseClock()
                            local v58
                            if v56 ~= "PreRound" or v57 <= 0 then
                                v58 = -1
                            else
                                v58 = v57 - State_upv_1.Now()
                            end
                            if v58 < u1 then
                                u13 = math.max(0, u13 - 1)
                                if u21 == u14 then
                                    u12 = State_upv_1.ActiveLoadout()
                                    paint()
                                    UI_upv_1.Shake(u7, 6)
                                    a1.Sounds.Play("Error")
                                end
                            else
                                u15 = u12
                                v54 = a1.ProfileAction("SelectLoadout", u12)
                                u13 = math.max(0, u13 - 1)
                                if u15 == u12 then
                                    u15 = nil
                                end
                                if v54 then
                                    State_upv_1.Profile.activeLoadout = u12
                                    if type(State_upv_1.Profile.loadouts) == "table" and State_upv_1.Profile.loadouts[u12] then
                                        State_upv_1.Profile.loadout = State_upv_1.Profile.loadouts[u12]
                                    end
                                    if u13 == 0 then
                                        u12 = State_upv_1.ActiveLoadout()
                                        paint()
                                        return
                                    end
                                elseif u21 == u14 then
                                    u12 = State_upv_1.ActiveLoadout()
                                    paint()
                                    UI_upv_1.Shake(u7, 6)
                                    a1.Sounds.Play("Error")
                                end
                            end
                            return
                        end
                    end
                    u13 = math.max(0, u13 - 1)
                    if (v54) then
                        return
                    end
                    paint()
                end
            )
        elseif a8 == "tap" then
            UI_upv_1.Bump(tbl_upv_2[a7].btn, 0.05)
        end
    end
    local function step(a9)
        --[[
          name: step
          line: 475
          upvalues:
            u11 (ref, index: 1)
            u20 (ref, index: 2)
            u12 (ref, index: 3)
        ]]
        if (u11 < 2) then
            return
        end
        u20((((u12 - 1) + a9) % u11) + 1, "key")
    end
    Keybinds_upv_1.OnInput(
        "Began",
        function(a10, a11)
            --[[
              line: 482
              upvalues:
                u18 (ref,  index: 1)
                UserInputService_upv_1 (copy, index: 2)
                Keybinds_upv_1 (copy, index: 3)
                u11 (ref,  index: 4)
                u20 (ref,  index: 5)
                u12 (ref,  index: 6)
            ]]
            if not u18 or (a11) or (UserInputService_upv_1:GetFocusedTextBox()) then
                return
            end
            if Keybinds_upv_1.IsPad(a10, "NextLoadout") then
                if not (Keybinds_upv_1.PadBlocked()) then
                    if not (u11 < 2) then
                        u20((((u12 - 1) + 1) % u11) + 1, "key")
                    end
                    return
                end
            elseif Keybinds_upv_1.IsPad(a10, "PrevLoadout") then
                if not (Keybinds_upv_1.PadBlocked()) then
                    if not (u11 < 2) then
                        u20((((u12 - 1) + -1) % u11) + 1, "key")
                    end
                    return
                end
            elseif Keybinds_upv_1.ActionOf(a10) == "NextLoadout" and not (u11 < 2) then
                u20((((u12 - 1) + 1) % u11) + 1, "key")
            end
        end
    )
    a1.Debug.loadoutSwap = function(a12, a13)
        --[[
          line: 501
          upvalues:
            u20 (ref,  index: 1)
            u11 (ref,  index: 2)
            u12 (ref,  index: 3)
            tbl_upv_2 (copy, index: 4)
            u18 (ref,  index: 5)
            LOADOUT_SWAP_CUTOFF_upv_1 (copy, index: 6)
            u16 (ref,  index: 7)
            State_upv_1 (copy, index: 8)
            u13 (ref,  index: 9)
        ]]
        if a12 == "pick" then
            u20(tonumber(a13) or 1, "tap")
        elseif a12 == "next" and not (u11 < 2) then
            u20((((u12 - 1) + 1) % u11) + 1, "key")
        end
        local tbl_7 = {}
        for n_4 = 1, u11 do
            tbl_7[n_4] = tbl_upv_2[n_4].sig or ""
            local v59 = n_4
        end
        local tbl_8 = {rect = 0, cards = 0, timeLeft = 0}
        tbl_8.shown = u18
        tbl_8.visible = LOADOUT_SWAP_CUTOFF_upv_1.Visible
        tbl_8.fade = u16
        tbl_8.selected = u12
        tbl_8.active = State_upv_1.ActiveLoadout()
        tbl_8.busy = u13
        tbl_8.count = u11
        local v59, v60 = State_upv_1.PhaseClock()
        local v61
        if v59 ~= "PreRound" or v60 <= 0 then
            v61 = -1
        else
            v61 = v60 - State_upv_1.Now()
        end
        tbl_8.timeLeft = v61
        tbl_8.cards = tbl_7
        tbl_8.rect = {LOADOUT_SWAP_CUTOFF_upv_1.AbsolutePosition.X, LOADOUT_SWAP_CUTOFF_upv_1.AbsolutePosition.Y, LOADOUT_SWAP_CUTOFF_upv_1.AbsoluteSize.X, LOADOUT_SWAP_CUTOFF_upv_1.AbsoluteSize.Y}
        return tbl_8
    end
    local tbl_9 = {}
    function tbl_9.IsShown()
        --[[
          name: IsShown
          line: 524
          upvalues:
            u18 (ref, index: 1)
        ]]
        return u18
    end
    a1.LoadoutSwap = tbl_9
end
return tbl_1