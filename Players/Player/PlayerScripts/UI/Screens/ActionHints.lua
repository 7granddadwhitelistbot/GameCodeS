local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local tbl_1 = {}
local function M1(a1)
    --[[
      name: M1
      line: 36
    ]]
    local tbl_2 = {action = "Attack", key = "M1"}
    tbl_2.pad = Enum.KeyCode.ButtonR2
    tbl_2.label = a1
    return tbl_2
end
local function M2(a1)
    --[[
      name: M2
      line: 39
    ]]
    local tbl_3 = {action = "Aim", key = "M2"}
    tbl_3.pad = Enum.KeyCode.ButtonL2
    tbl_3.label = a1
    return tbl_3
end
;({pad = 0, key = "R", label = "reload", action = "Reload", reload = true}).pad = Enum.KeyCode.ButtonX
local tbl_upv_4 = {}
tbl_upv_4.Bow = {bit = 0, acts = {{action = "Attack", key = "M1", label = "draw", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "zoom", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Crossbow = {bit = 1, acts = {{action = "Attack", key = "M1", label = "fire", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "aim", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Musket = {bit = 2, acts = {{action = "Attack", key = "M1", label = "fire", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "aim", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Pistol = {bit = 3, acts = {{action = "Attack", key = "M1", label = "fire", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "aim", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Blunderbuss = {bit = 4, acts = {{action = "Attack", key = "M1", label = "fire", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Knives = {bit = 5, acts = {{action = "Attack", key = "M1", label = "throw", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Javelin = {bit = 6, acts = {{action = "Attack", key = "M1", label = "throw", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "cancel", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Sling = {bit = 7, acts = {{action = "Attack", key = "M1", label = "sling", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Sword = {bit = 8, acts = {{action = "Attack", key = "M1", label = "attack", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "block", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Axe = {bit = 9, acts = {{action = "Attack", key = "M1", label = "chop", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "heavy", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Spear = {bit = 10, acts = {{action = "Attack", key = "M1", label = "thrust", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "lunge", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Dagger = {bit = 11, acts = {{action = "Attack", key = "M1", label = "stab", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Club = {bit = 12, acts = {{action = "Attack", key = "M1", label = "smash", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Bomb = {bit = 13, acts = {{action = "Attack", key = "M1", label = "throw", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "cancel", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Herbs = {bit = 14, acts = {{action = "Attack", key = "M1", label = "eat", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Trap = {bit = 15, acts = {{action = "Attack", key = "M1", label = "set", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Bandage = {bit = 16, acts = {{action = "Attack", key = "M1", label = "use", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Tonic = {bit = 17, acts = {{action = "Attack", key = "M1", label = "eat", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Horn = {bit = 18, acts = {{action = "Attack", key = "M1", label = "blow", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Shield = {bit = 19, acts = {{action = "Attack", key = "M1", label = "bash", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "block", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Wall = {bit = 20, acts = {{action = "Attack", key = "M1", label = "build", pad = Enum.KeyCode.ButtonR2}}}
tbl_upv_4.Gauntlets = {bit = 21, acts = {{action = "Attack", key = "M1", label = "punch", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "dash", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Scythe = {bit = 22, acts = {{action = "Attack", key = "M1", label = "sweep", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "dash", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Katana = {bit = 23, acts = {{action = "Attack", key = "M1", label = "cut", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "parry", pad = Enum.KeyCode.ButtonL2}}}
tbl_upv_4.Hatchets = {bit = 24, acts = {{action = "Attack", key = "M1", label = "chop", pad = Enum.KeyCode.ButtonR2}, {action = "Aim", key = "M2", label = "throw", pad = Enum.KeyCode.ButtonL2, hatchet = true}}}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 79
      upvalues:
        Players_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        tbl_upv_4 (copy, index: 3)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = 0
    local u2 = 0
    local u3 = false
    local function loadFromProfile()
        --[[
          name: loadFromProfile
          line: 88
          upvalues:
            State_upv_1 (copy, index: 1)
            u3 (ref,  index: 2)
            u1 (ref,  index: 3)
            u2 (ref,  index: 4)
        ]]
        local Profile_1 = State_upv_1.Profile and (State_upv_1.Profile.settings)
        if not State_upv_1.HasProfile or type(Profile_1) ~= "table" then
            return
        end
        u3 = true
        if type(Profile_1.tutKinds) == "number" then
            u1 = bit32.bor(u1, Profile_1.tutKinds)
        end
        if type(Profile_1.tutMatches) ~= "number" then
            return
        end
        u2 = math.max(u2, Profile_1.tutMatches)
    end
    local v1 = State_upv_1.Profile and (State_upv_1.Profile.settings)
    if State_upv_1.HasProfile and type(v1) == "table" then
        u3 = true
        if type(v1.tutKinds) == "number" then
            u1 = bit32.bor(u1, v1.tutKinds)
        end
        if type(v1.tutMatches) == "number" then
            u2 = math.max(u2, v1.tutMatches)
        end
    end
    State_upv_1.ProfileChanged:Connect(loadFromProfile)
    local function save(a2, a3)
        --[[
          name: save
          line: 102
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        if State_upv_1.Mock then
            return
        end
        task.spawn(function() end)
    end
    local u4 = false
    State_upv_1.MatchEvent:Connect(
        function(a4)
            --[[
              line: 111
              upvalues:
                u3 (ref,  index: 1)
                u4 (ref,  index: 2)
                u2 (ref,  index: 3)
                State_upv_1 (copy, index: 4)
            ]]
            if a4 ~= "MatchStart" then
                return
            end
            if u3 then
                local v2 = u2 < 3
                u4 = v2
                if u4 then
                    u2 = u2 + 1
                    local _ = u2
                    if State_upv_1.Mock then
                        return
                    end
                    local v3 = "tutMatches"
                    task.spawn(function() end)
                end
            end
        end
    )
    local u5 = UI_upv_1.new("Frame", {Name = "ActionStrip", Visible = false, AnchorPoint = Vector2.new(0, 1), Size = UDim2.fromOffset(200, 110), Parent = a1.Canvas.HUD})
    UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Bottom, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = u5})
    local u6 = UI_upv_1.new("Frame", {Name = "LeftHints", AnchorPoint = Vector2.new(1, 1), Size = UDim2.fromOffset(220, 68), Visible = false, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom), Parent = a1.Canvas.HUD})
    local function newRow(a5, a6, a7, a8)
        --[[
          name: newRow
          line: 124
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local v3 = UI_upv_1.new("CanvasGroup", {GroupTransparency = 0.45, Name = "Hint_" .. a6.key, Size = UDim2.fromOffset(0, 32), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = a7, Parent = a5})
        local new_1 = UI_upv_1.new
        local tbl_5 = {VerticalAlignment = 0, HorizontalAlignment = 0, Parent = 0, Padding = 0, SortOrder = 0}
        tbl_5.FillDirection = Enum.FillDirection.Horizontal
        local v4
        if a8 then
            v4 = Enum.HorizontalAlignment.Right
        else
            v4 = Enum.HorizontalAlignment.Left
        end
        tbl_5.HorizontalAlignment = v4
        tbl_5.VerticalAlignment = Enum.VerticalAlignment.Center
        tbl_5.Padding = UDim.new(0, 8)
        tbl_5.SortOrder = Enum.SortOrder.LayoutOrder
        tbl_5.Parent = v3
        new_1("UIListLayout", tbl_5)
        local ActionCap_1 = UI_upv_1.ActionCap
        local action_1 = a6.action
        local tbl_6 = {LayoutOrder = 0, Height = 26, TextSize = 15, Parent = 0}
        tbl_6.Gamepad = a6.pad
        tbl_6.LayoutOrder = (a8 and 2) or 1
        tbl_6.Parent = v3
        local v5 = ActionCap_1(action_1, tbl_6)
        local new_2 = UI_upv_1.new
        local tbl_7 = {LayoutOrder = 0, Parent = 0, Name = "Label", TextSize = 18}
        tbl_7.Size = UDim2.fromOffset(0, 26)
        tbl_7.AutomaticSize = Enum.AutomaticSize.X
        tbl_7.Text = a6.label
        tbl_7.FontFace = Fonts_upv_1.Bold
        tbl_7.TextColor3 = Colors_upv_1.Text
        tbl_7.LayoutOrder = (a8 and 1) or 2
        tbl_7.Parent = v3
        action_1 = new_2("TextLabel", tbl_7)
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1, 0.55).Parent = action_1
        local tbl_8 = {capFade = 0}
        tbl_8.group = v3
        tbl_8.label = action_1
        tbl_8.cap = v5
        tbl_8.act = a6
        return tbl_8
    end
    local u7 = newRow(u6, {action = "Slide", key = "C", label = "slide", pad = Enum.KeyCode.ButtonB}, 1, true)
    u7.group.GroupTransparency = 1
    local u8 = newRow(u6, {action = "View", key = "V", label = "first person", pad = Enum.KeyCode.DPadUp}, 2, true)
    local Camera_upv_1 = ReplicatedStorage_upv_1:WaitForChild("Shared"):FindFirstChild("Camera")
    local success_1, v6 = pcall(
        function()
            --[[
              line: 191
              upvalues:
                Camera_upv_1 (copy, index: 1)
            ]]
            if Camera_upv_1 then
                return (require(Camera_upv_1))
            end
            return nil
        end
    )
    local u9 = not (success_1) or type(v6) ~= "table" or v6
    local function paintView()
        --[[
          name: paintView
          line: 196
          upvalues:
            u9 (ref,  index: 1)
            u8 (copy, index: 2)
        ]]
        local v7 = (u9 ~= nil) and ((u9.IsFirstPerson ~= nil) and (u9.IsFirstPerson() == true))
        local label_1 = u8.label
        local v8
        if v7 then
            v8 = "third person"
        else
            v8 = "first person"
        end
        label_1.Text = v8
    end
    local v9 = false
    if u9 ~= nil then
        v9 = (u9.IsFirstPerson ~= nil) and (u9.IsFirstPerson() == true)
    end
    local label_2 = u8.label
    local v10
    if v9 then
        v10 = "third person"
    else
        v10 = "first person"
    end
    label_2.Text = v10
    if u9 and typeof(u9.FirstPersonChanged) == "RBXScriptSignal" then
        u9.FirstPersonChanged:Connect(paintView)
    end
    local function layout()
        --[[
          name: layout
          line: 205
          upvalues:
            a1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            u5 (copy, index: 3)
            u6 (copy, index: 4)
        ]]
        local v11 = ((not (a1.HotbarWidth)) and 372) or (a1.HotbarWidth())
        local v12 = ((UI_upv_1.Compact) and -8) or -18
        u5.Position = UDim2.new(0.5, math.floor(v11 / 2) + 22, 1, v12)
        u6.Position = UDim2.new(0.5, -(math.floor(v11 / 2) + 22), 1, v12)
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    local function kindOf(a9)
        --[[
          name: kindOf
          line: 215
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
        ]]
        if a9 == "bandage" then
            return "Bandage"
        end
        if a9 == "healing_tonic" then
            return "Tonic"
        end
        if a9 == "palisade" then
            return "Wall"
        end
        local v13 = WeaponInfo_upv_1.Get(a9)
        local v14 = v13 and (v13.kind)
        if type(v14) == "string" and tbl_upv_4[v14] then
            return v14
        end
        return nil
    end
    local function heldTool()
        --[[
          name: heldTool
          line: 231
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
        ]]
        local Character_1 = LocalPlayer_upv_1.Character
        local v15 = Character_1 and (Character_1:FindFirstChildOfClass("Tool"))
        if v15 and v15:IsA("Tool") then
            return v15
        end
        return nil
    end
    local tbl_upv_9 = {}
    local u10 = nil
    local u11 = 0
    local u12 = nil
    local function rebuild(a10)
        --[[
          name: rebuild
          line: 242
          upvalues:
            tbl_upv_9 (copy, index: 1)
            u10 (ref,  index: 2)
            tbl_upv_4 (copy, index: 3)
            newRow (copy, index: 4)
            u5 (copy, index: 5)
        ]]
        for _, value_1 in tbl_upv_9 do
            value_1.group:Destroy()
        end
        table.clear(tbl_upv_9)
        u10 = a10
        local v16 = a10 and (tbl_upv_4[a10])
        if not v16 then
            return
        end
        for key_1, value_2 in v16.acts do
            tbl_upv_9[key_1] = newRow(u5, value_2, #v16.acts - key_1, false)
        end
    end
    local function emphasize(a11)
        --[[
          name: emphasize
          line: 259
          upvalues:
            u11 (ref,  index: 1)
            tbl_upv_9 (copy, index: 2)
            u1 (ref,  index: 3)
            tbl_upv_4 (copy, index: 4)
            State_upv_1 (copy, index: 5)
        ]]
        u11 = os.clock() + 6
        for _, value_3 in tbl_upv_9 do
            value_3.group.GroupTransparency = 1
        end
        if not (bit32.btest(u1, bit32.lshift(1, tbl_upv_4[a11].bit))) then
            u1 = bit32.bor(u1, bit32.lshift(1, tbl_upv_4[a11].bit))
            local _ = u1
            if State_upv_1.Mock then
                return
            end
            local v1 = "tutKinds"
            task.spawn(function() end)
        end
    end
    a1.HeldWeaponChanged:Connect(
        function(a12)
            --[[
              line: 270
              upvalues:
                WeaponInfo_upv_1 (copy, index: 1)
                tbl_upv_4 (copy, index: 2)
                u10 (ref,  index: 3)
                rebuild (copy, index: 4)
                u3 (ref,  index: 5)
                u1 (ref,  index: 6)
                a1 (copy, index: 7)
                u12 (ref,  index: 8)
                emphasize (copy, index: 9)
            ]]
            local v17
            if a12 == "bandage" then
                v17 = "Bandage"
            elseif a12 == "healing_tonic" then
                v17 = "Tonic"
            elseif a12 ~= "palisade" then
                local v18 = WeaponInfo_upv_1.Get(a12)
                local v19 = v18 and (v18.kind)
                v17 = type(v19) ~= "string" or not (tbl_upv_4[v19]) or v19
            else
                v17 = "Wall"
            end
            if v17 ~= u10 then
                rebuild(v17)
            end
            if not v17 or not u3 or (bit32.btest(u1, bit32.lshift(1, tbl_upv_4[v17].bit))) then
                return
            end
            if a1.HudHidden then
                u12 = v17
            else
                emphasize(v17)
            end
        end
    )
    a1.HudHiddenChanged:Connect(
        function(a13)
            --[[
              line: 284
              upvalues:
                u12 (ref,  index: 1)
                u10 (ref,  index: 2)
                emphasize (copy, index: 3)
            ]]
            if (a13) or not u12 then
                return
            end
            if u12 == u10 then
                local v20 = u12
                u12 = nil
                task.defer(emphasize, v20)
            end
        end
    )
    local function inCombat()
        --[[
          name: inCombat
          line: 293
          upvalues:
            State_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v21 = (State_upv_1.Get("CombatMode") ~= false) and (State_upv_1.IsAlive() and (not a1.HudHidden and (not State_upv_1.Watching())))
        return v21
    end
    local u13 = false
    local u14 = nil
    local u15 = os.clock()
    local function planarSpeed()
        --[[
          name: planarSpeed
          line: 301
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            u14 (ref,  index: 2)
            u15 (ref,  index: 3)
        ]]
        local Character_2 = LocalPlayer_upv_1.Character
        local v22 = Character_2 and (Character_2:FindFirstChild("HumanoidRootPart"))
        local v23 = os.clock()
        if v22 and v22:IsA("BasePart") then
            local Position_1 = v22.Position
            v22 = 0
            if u14 and u15 < v23 then
                v22 = ((Position_1 - u14) * Vector3.new(1, 0, 1)).Magnitude / (v23 - u15)
                v22 = ((Position_1 - u14) * Vector3.new(1, 0, 1)).Magnitude / (v23 - u15) > 120 and 0 or ((Position_1 - u14) * Vector3.new(1, 0, 1)).Magnitude / (v23 - u15)
            end
            u14 = Position_1
            u15 = v23
            return v22
        end
        u14 = nil
        return 0
    end
    local u16 = 0
    local u17 = -math.huge
    local function threwHatchet()
        --[[
          name: threwHatchet
          line: 324
          upvalues:
            u1 (ref, index: 1)
        ]]
        return (bit32.btest(u1, 33554432))
    end
    local u18 = nil
    local function setTouchNudge(a14)
        --[[
          name: setTouchNudge
          line: 328
          upvalues:
            u18 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        if a14 == u18 then
            return
        end
        local v24 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
        local v25 = v24 and (v24:FindFirstChild("CombatTouch"))
        if not v25 then
            return
        end
        u18 = a14
        v25:SetAttribute("Nudge", a14)
    end
    UI_upv_1.Every(
        u5,
        0.1,
        function()
            --[[
              line: 339
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u10 (ref,  index: 2)
                u3 (ref,  index: 3)
                u1 (ref,  index: 4)
                State_upv_1 (copy, index: 5)
                a1 (copy, index: 6)
                UI_upv_1 (copy, index: 7)
                u18 (ref,  index: 8)
                tbl_upv_9 (copy, index: 9)
                u5 (copy, index: 10)
                layout (copy, index: 11)
                u11 (ref,  index: 12)
                Colors_upv_1 (copy, index: 13)
                Theme_upv_1 (copy, index: 14)
                u4 (ref,  index: 15)
                u2 (ref,  index: 16)
                planarSpeed (copy, index: 17)
                u16 (ref,  index: 18)
                u17 (ref,  index: 19)
                u6 (copy, index: 20)
                u13 (ref,  index: 21)
                u7 (copy, index: 22)
            ]]
            local v26 = LocalPlayer_upv_1.Character
            local v27 = v26 and (v26:FindFirstChildOfClass("Tool"))
            local v28 = not (v27) or not (v27:IsA("Tool")) or v27
            v26 = (u10 == "Hatchets") and (v28 ~= nil)
            local v29 = v26 and (v28:GetAttribute("Thrown") == true)
            local v30
            if v29 and u3 and not (bit32.btest(u1, 33554432)) then
                u1 = bit32.bor(u1, 33554432)
                v30 = u1
                if not (State_upv_1.Mock) then
                    local v50 = "tutKinds"
                    task.spawn(function() end)
                end
            end
            if UI_upv_1.Touch and v26 and not v29 and u3 then
                local v31 = nil
                if bit32.btest(u1, 33554432) then
                    v30 = nil
                else
                    v31 = (State_upv_1.Get("CombatMode") ~= false) and (State_upv_1.IsAlive() and (not a1.HudHidden and (not State_upv_1.Watching())))
                    if v31 then
                        v30 = "Secondary"
                    else
                        v30 = nil
                    end
                end
            else
                v30 = nil
            end
            if v30 ~= u18 then
                local v32 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
                local v33 = v32 and (v32:FindFirstChild("CombatTouch"))
                if v33 then
                    u18 = v30
                    v33:SetAttribute("Nudge", v30)
                end
            end
            local v34 = not UI_upv_1.Touch
            if v34 then
                v26 = (State_upv_1.Get("CombatMode") ~= false) and (State_upv_1.IsAlive() and (not a1.HudHidden and (not State_upv_1.Watching())))
                if v26 then
                    v34 = (#tbl_upv_9 > 0) and (v28 ~= nil)
                else
                    v34 = v26
                end
            end
            u5.Visible = v34
            if v34 then
                layout()
                v30 = v28:GetAttribute("Ammo")
                local v35 = v28:GetAttribute("MaxAmmo")
                local v36 = v28:GetAttribute("Reloading") == true
                local v37 = (type(v30) == "number") and ((type(v35) == "number") and ((v35 > 0) and (v30 <= 0)))
                local v38 = os.clock() < u11
                local v39, v40, v39, v40 = nil, nil, nil, nil
                local v41 = nil
                local _ = nil
                for v51, value_4 in tbl_upv_9 do
                    if value_4.act.reload ~= true then
                        local v42 = false
                        if value_4.act.hatchet ~= true then
                            v30 = v42
                        else
                            v30 = v29
                        end
                    else
                        v30 = v37
                        if not (v30) then
                            v30 = v36
                            if not (v30) then
                                local v42 = false
                                if value_4.act.hatchet ~= true then
                                    v30 = v42
                                else
                                    v30 = v29
                                end
                            end
                        end
                    end
                    if v38 or v30 then
                        v39 = 0
                        v40 = 0
                        if value_4.act.hatchet then
                            if not (v29) or v29 then
                                if v29 then
                                    v40 = 1
                                elseif u3 then
                                    local v43 = bit32.btest(u1, 33554432)
                                    if not v43 then
                                        v39 = 0
                                    end
                                end
                                value_4.label.Text = (v29 and "pick up") or "throw"
                                local label_3 = value_4.label
                                if v29 then
                                    v41 = Colors_upv_1.Warning
                                else
                                    v41 = Colors_upv_1.Text
                                end
                                label_3.TextColor3 = v41
                                if math.abs(value_4.group.GroupTransparency - v39) > 0.01 then
                                    UI_upv_1.Tween(value_4.group, Theme_upv_1.Tween.Smooth, {GroupTransparency = v39})
                                end
                                if v40 ~= value_4.capFade then
                                    value_4.capFade = v40
                                    UI_upv_1.SetCapFade(value_4.cap, v40)
                                end
                                if not (value_4.act.reload) then
                                    continue
                                end
                                value_4.label.Text = (v36 and "reloading") or "reload"
                                local label_4 = value_4.label
                                if v30 then
                                    v41 = Colors_upv_1.Warning
                                else
                                    v41 = Colors_upv_1.Text
                                end
                                label_4.TextColor3 = v41
                            end
                            v39, v40 = 0.7, 0.75
                            value_4.label.Text = (v29 and "pick up") or "throw"
                            local label_3 = value_4.label
                            if v29 then
                                v41 = Colors_upv_1.Warning
                            else
                                v41 = Colors_upv_1.Text
                            end
                            label_3.TextColor3 = v41
                        end
                        if math.abs(value_4.group.GroupTransparency - v39) > 0.01 then
                            UI_upv_1.Tween(value_4.group, Theme_upv_1.Tween.Smooth, {GroupTransparency = v39})
                        end
                        if v40 ~= value_4.capFade then
                            value_4.capFade = v40
                            UI_upv_1.SetCapFade(value_4.cap, v40)
                        end
                        if not (value_4.act.reload) then
                            continue
                        end
                        value_4.label.Text = (v36 and "reloading") or "reload"
                        local label_4 = value_4.label
                        if v30 then
                            v41 = Colors_upv_1.Warning
                        else
                            v41 = Colors_upv_1.Text
                        end
                        label_4.TextColor3 = v41
                    end
                    v39 = 0.45
                    v40 = 0
                    if value_4.act.hatchet then
                        if not (v29) or v29 then
                            if v29 then
                                v40 = 1
                            elseif u3 then
                                local v43 = bit32.btest(u1, 33554432)
                                if not v43 then
                                    v39 = 0
                                end
                            end
                            value_4.label.Text = (v29 and "pick up") or "throw"
                            local label_3 = value_4.label
                            if v29 then
                                v41 = Colors_upv_1.Warning
                            else
                                v41 = Colors_upv_1.Text
                            end
                            label_3.TextColor3 = v41
                            if math.abs(value_4.group.GroupTransparency - v39) > 0.01 then
                                UI_upv_1.Tween(value_4.group, Theme_upv_1.Tween.Smooth, {GroupTransparency = v39})
                            end
                            if v40 ~= value_4.capFade then
                                value_4.capFade = v40
                                UI_upv_1.SetCapFade(value_4.cap, v40)
                            end
                            if not (value_4.act.reload) then
                                continue
                            end
                            value_4.label.Text = (v36 and "reloading") or "reload"
                            local label_4 = value_4.label
                            if v30 then
                                v41 = Colors_upv_1.Warning
                            else
                                v41 = Colors_upv_1.Text
                            end
                            label_4.TextColor3 = v41
                        end
                        v39, v40 = 0.7, 0.75
                        value_4.label.Text = (v29 and "pick up") or "throw"
                        local label_3 = value_4.label
                        if v29 then
                            v41 = Colors_upv_1.Warning
                        else
                            v41 = Colors_upv_1.Text
                        end
                        label_3.TextColor3 = v41
                    end
                    if math.abs(value_4.group.GroupTransparency - v39) > 0.01 then
                        UI_upv_1.Tween(value_4.group, Theme_upv_1.Tween.Smooth, {GroupTransparency = v39})
                    end
                    if v40 ~= value_4.capFade then
                        value_4.capFade = v40
                        UI_upv_1.SetCapFade(value_4.cap, v40)
                    end
                    if not (value_4.act.reload) then
                        continue
                    end
                    value_4.label.Text = (v36 and "reloading") or "reload"
                    local label_4 = value_4.label
                    if v30 then
                        v41 = Colors_upv_1.Warning
                    else
                        v41 = Colors_upv_1.Text
                    end
                    label_4.TextColor3 = v41
                end
            end
            local v44 = u3
            if v44 then
                if State_upv_1.InMatch() then
                    v44 = u4
                else
                    v44 = u2 < 3
                end
            end
            local v45 = planarSpeed()
            local v46 = false
            if v44 then
                local v47 = nil
                if UI_upv_1.Touch then
                    u16 = 0
                    v26 = v46
                else
                    v47 = (State_upv_1.Get("CombatMode") ~= false) and (State_upv_1.IsAlive() and (not a1.HudHidden and (not State_upv_1.Watching())))
                    if v47 then
                        local Character_3 = LocalPlayer_upv_1.Character
                        if v45 > 12 and Character_3 then
                            if Character_3:GetAttribute("Sliding") == true then
                                v47 = 0
                            else
                                v47 = u16 + 1
                            end
                        else
                            v47 = 0
                        end
                        u16 = v47
                        if u16 >= 3 then
                            u17 = os.clock()
                        end
                        v26 = os.clock() - u17 < 1.5
                    else
                        u16 = 0
                        v26 = v46
                    end
                end
            else
                u16 = 0
                v26 = v46
            end
            u6.Visible = not UI_upv_1.Touch and State_upv_1.Get("CombatMode") ~= false and State_upv_1.IsAlive() and not a1.HudHidden and not State_upv_1.Watching()
            if v26 ~= u13 then
                u13 = v26
                local Tween_1 = UI_upv_1.Tween
                local group_1 = u7.group
                local Smooth_1 = Theme_upv_1.Tween.Smooth
                local tbl_10 = {GroupTransparency = 0}
                tbl_10.GroupTransparency = (v26 and 0.35) or 1
                Tween_1(group_1, Smooth_1, tbl_10)
            end
        end
    )
    a1.Debug.tutorial = function(a15)
        --[[
          line: 411
          upvalues:
            u1 (ref,  index: 1)
            u2 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            u3 (ref,  index: 5)
            u10 (ref,  index: 6)
            tbl_upv_9 (copy, index: 7)
        ]]
        if a15 ~= "reset" then
            local tbl_11 = {}
            tbl_11.kindsMask = u1
            tbl_11.matchesSeen = u2
            tbl_11.loaded = u3
            tbl_11.kind = u10
            tbl_11.rows = #tbl_upv_9
            return tbl_11
        end
        u1 = 0
        u2 = 0
        if not (State_upv_1.Mock) then
            local _ = "tutKinds"
            local v1 = 0
            task.spawn(function() end)
        end
        if not (State_upv_1.Mock) then
            local u19 = "tutMatches"
            local u20 = 0
            task.spawn(
                function()
                    --[[
                      line: 106
                      upvalues:
                        a1 (copy, index: 1)
                        u19 (copy, index: 2)
                        u20 (copy, index: 3)
                    ]]
                    a1.Remotes.Invoke("ProfileAction", "SetSetting", u19, u20)
                end
            )
        end
        return true
    end
    a1.Debug.hints = function(a16)
        --[[
          line: 421
          upvalues:
            tbl_upv_4 (copy, index: 1)
            rebuild (copy, index: 2)
            emphasize (copy, index: 3)
            tbl_upv_9 (copy, index: 4)
            u10 (ref,  index: 5)
            u5 (copy, index: 6)
            u6 (copy, index: 7)
            u1 (ref,  index: 8)
            u18 (ref,  index: 9)
        ]]
        if type(a16) == "string" and tbl_upv_4[a16] then
            rebuild(a16)
            emphasize(a16)
            return true
        end
        local tbl_12 = {}
        for _, value_5 in tbl_upv_9 do
            table.insert(tbl_12, {key = value_5.act.key, label = value_5.label.Text, transparency = value_5.group.GroupTransparency, capFade = value_5.capFade})
        end
        local tbl_13 = {}
        tbl_13.kind = u10
        tbl_13.rows = #tbl_upv_9
        tbl_13.visible = u5.Visible
        tbl_13.slide = u6.Visible
        tbl_13.texts = tbl_12
        tbl_13.threwHatchet = bit32.btest(u1, 33554432)
        tbl_13.nudge = u18 or false
        return tbl_13
    end
end
return tbl_1