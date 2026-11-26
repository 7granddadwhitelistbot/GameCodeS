local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local v3 = {}

local function M1(label)
    --[[
      name: M1
      line: 36
    ]]
    return {key = "M1", action = "Attack", pad = Enum.KeyCode.ButtonR2, label = label}
end

local function M2(label)
    --[[
      name: M2
      line: 39
    ]]
    return {key = "M2", action = "Aim", pad = Enum.KeyCode.ButtonL2, label = label}
end

;({key = "R", action = "Reload", pad = nil, label = "reload", reload = true}).pad = Enum.KeyCode.ButtonX
local v8 = {key = "M2", action = "Aim", label = "throw", pad = Enum.KeyCode.ButtonL2, hatchet = true}
local v9 = {
    Bow = {bit = 0, acts = {{key = "M1", action = "Attack", label = "draw", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "zoom", pad = Enum.KeyCode.ButtonL2}}},
    Crossbow = {bit = 1, acts = {{key = "M1", action = "Attack", label = "fire", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "aim", pad = Enum.KeyCode.ButtonL2}}},
    Musket = {bit = 2, acts = {{key = "M1", action = "Attack", label = "fire", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "aim", pad = Enum.KeyCode.ButtonL2}}},
    Pistol = {bit = 3, acts = {{key = "M1", action = "Attack", label = "fire", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "aim", pad = Enum.KeyCode.ButtonL2}}},
    Blunderbuss = {bit = 4, acts = {{key = "M1", action = "Attack", label = "fire", pad = Enum.KeyCode.ButtonR2}}},
    Knives = {bit = 5, acts = {{key = "M1", action = "Attack", label = "throw", pad = Enum.KeyCode.ButtonR2}}},
    Javelin = {bit = 6, acts = {{key = "M1", action = "Attack", label = "throw", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "cancel", pad = Enum.KeyCode.ButtonL2}}},
    Sling = {bit = 7, acts = {{key = "M1", action = "Attack", label = "sling", pad = Enum.KeyCode.ButtonR2}}},
    Sword = {bit = 8, acts = {{key = "M1", action = "Attack", label = "attack", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "block", pad = Enum.KeyCode.ButtonL2}}},
    Axe = {bit = 9, acts = {{key = "M1", action = "Attack", label = "chop", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "heavy", pad = Enum.KeyCode.ButtonL2}}},
    Spear = {bit = 10, acts = {{key = "M1", action = "Attack", label = "thrust", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "lunge", pad = Enum.KeyCode.ButtonL2}}},
    Dagger = {bit = 11, acts = {{key = "M1", action = "Attack", label = "stab", pad = Enum.KeyCode.ButtonR2}}},
    Club = {bit = 12, acts = {{key = "M1", action = "Attack", label = "smash", pad = Enum.KeyCode.ButtonR2}}},
    Bomb = {bit = 13, acts = {{key = "M1", action = "Attack", label = "throw", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "cancel", pad = Enum.KeyCode.ButtonL2}}},
    Herbs = {bit = 14, acts = {{key = "M1", action = "Attack", label = "eat", pad = Enum.KeyCode.ButtonR2}}},
    Trap = {bit = 15, acts = {{key = "M1", action = "Attack", label = "set", pad = Enum.KeyCode.ButtonR2}}},
    Bandage = {bit = 16, acts = {{key = "M1", action = "Attack", label = "use", pad = Enum.KeyCode.ButtonR2}}},
    Tonic = {bit = 17, acts = {{key = "M1", action = "Attack", label = "eat", pad = Enum.KeyCode.ButtonR2}}},
    Horn = {bit = 18, acts = {{key = "M1", action = "Attack", label = "blow", pad = Enum.KeyCode.ButtonR2}}},
    Shield = {bit = 19, acts = {{key = "M1", action = "Attack", label = "bash", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "block", pad = Enum.KeyCode.ButtonL2}}},
    Wall = {bit = 20, acts = {{key = "M1", action = "Attack", label = "build", pad = Enum.KeyCode.ButtonR2}}},
    Gauntlets = {bit = 21, acts = {{key = "M1", action = "Attack", label = "punch", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "dash", pad = Enum.KeyCode.ButtonL2}}},
    Scythe = {bit = 22, acts = {{key = "M1", action = "Attack", label = "sweep", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "dash", pad = Enum.KeyCode.ButtonL2}}},
    Katana = {bit = 23, acts = {{key = "M1", action = "Attack", label = "cut", pad = Enum.KeyCode.ButtonR2}, {key = "M2", action = "Aim", label = "parry", pad = Enum.KeyCode.ButtonL2}}},
    Hatchets = {bit = 24, acts = {{key = "M1", action = "Attack", label = "chop", pad = Enum.KeyCode.ButtonR2}, v8}}
}

function v3.Init(a10)
    --[[
      name: Init
      line: 79
      upvalues:
        players (copy, index: 1)
        replicatedStorage (copy, index: 2)
        v9 (copy, index: 3)
    ]]
    local result
    local text
    local ui = a10.UI
    local theme = a10.Theme
    local state = a10.State
    local weaponInfo = a10.WeaponInfo
    local colors = theme.Colors
    local fonts = theme.Fonts
    local localPlayer = players.LocalPlayer
    local kindsMask = 0
    local matchesSeen = 0
    local loaded = false

    local function loadFromProfile()
        --[[
          name: loadFromProfile
          line: 88
          upvalues:
            state (copy, index: 1)
            loaded (ref,  index: 2)
            kindsMask (ref,  index: 3)
            matchesSeen (ref,  index: 4)
        ]]
        local settings = state.Profile and state.Profile.settings

        if state.HasProfile and type(settings) == "table" then
            loaded = true

            if type(settings.tutKinds) == "number" then
                kindsMask = bit32.bor(kindsMask, settings.tutKinds)
            end

            if type(settings.tutMatches) == "number" then
                matchesSeen = math.max(matchesSeen, settings.tutMatches)
            end
        end
    end

    local settings = state.Profile and state.Profile.settings

    if state.HasProfile and type(settings) == "table" then
        loaded = true

        if type(settings.tutKinds) == "number" then
            local tutKinds = settings.tutKinds
            kindsMask = bit32.bor(kindsMask, tutKinds)
        end

        if type(settings.tutMatches) == "number" then
            local tutMatches = settings.tutMatches
            matchesSeen = math.max(matchesSeen, tutMatches)
        end
    end

    state.ProfileChanged:Connect(loadFromProfile)

    local function save(a29, a30)
        --[[
          name: save
          line: 102
          upvalues:
            state (copy, index: 1)
            a10 (copy, index: 2)
        ]]
        if state.Mock then
            return
        end

        task.spawn(
            function()
                --[[
                  line: 106
                  upvalues:
                    a10 (copy, index: 1)
                    a29 (copy, index: 2)
                    a30 (copy, index: 3)
                ]]
                a10.Remotes.Invoke("ProfileAction", "SetSetting", a29, a30)
            end
        )
    end

    local v31 = false

    state.MatchEvent:Connect(
        function(a32)
            --[[
              line: 111
              upvalues:
                loaded (ref,  index: 1)
                v31 (ref,  index: 2)
                matchesSeen (ref,  index: 3)
                state (copy, index: 4)
                a10 (copy, index: 5)
            ]]
            if a32 == "MatchStart" and loaded then
                v31 = matchesSeen < 3

                if v31 then
                    matchesSeen += 1
                    local v33 = matchesSeen

                    if not state.Mock then
                        local v34 = "tutMatches"
                        task.spawn(
                            function()
                                --[[
                                  line: 106
                                  upvalues:
                                    a10 (copy, index: 1)
                                    v34 (copy, index: 2)
                                    v33 (copy, index: 3)
                                ]]
                                a10.Remotes.Invoke("ProfileAction", "SetSetting", v34, v33)
                            end
                        )
                    end
                end
            end
        end
    )

    local function newRow(parent, act, layoutOrder, a39: boolean)
        --[[
          name: newRow
          line: 124
          upvalues:
            ui (copy, index: 1)
            fonts (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local layoutOrder2
        local layoutOrder3
        local ui2 = ui.new("CanvasGroup", {GroupTransparency = 0.45, Name = "Hint_" .. act.key, Size = UDim2.fromOffset(0, 32), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = layoutOrder, Parent = parent})
        local newUi = ui.new
        local v44 = {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = if a39 then Enum.HorizontalAlignment.Right else Enum.HorizontalAlignment.Left}
        v44.VerticalAlignment = Enum.VerticalAlignment.Center
        v44.Padding = UDim.new(0, 8)
        v44.SortOrder = Enum.SortOrder.LayoutOrder
        v44.Parent = ui2
        newUi("UIListLayout", v44)
        local actionCap = ui.ActionCap
        local action = act.action
        local v47 = {Height = 26, TextSize = 15, Gamepad = act.pad}

        if a39 then
            layoutOrder2 = 2
        else
            layoutOrder2 = 1
        end

        v47.LayoutOrder = layoutOrder2
        v47.Parent = ui2
        local cap = actionCap(action, v47)
        local newUi2 = ui.new
        local v50 = {Name = "Label", TextSize = 18, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, Text = act.label, FontFace = fonts.Bold, TextColor3 = colors.Text}

        if a39 then
            layoutOrder3 = 1
        else
            layoutOrder3 = 2
        end

        v50.LayoutOrder = layoutOrder3
        v50.Parent = ui2
        local ui3 = newUi2("TextLabel", v50)
        ui.TextStroke(colors.Void, 1, 0.55).Parent = ui3

        return {capFade = 0, group = ui2, label = ui3, cap = cap, act = act}
    end

    local parent = ui.new("Frame", {Name = "ActionStrip", Visible = false, AnchorPoint = Vector2.new(0, 1), Size = UDim2.fromOffset(200, 110), Parent = a10.Canvas.HUD})
    ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Bottom, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent})
    local ui2 = ui.new("Frame", {Name = "LeftHints", AnchorPoint = Vector2.new(1, 1), Size = UDim2.fromOffset(220, 68), Visible = false, (ui.List(Enum.FillDirection.Vertical, 4, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Bottom)), Parent = a10.Canvas.HUD})
    local v54 = newRow(ui2, {key = "C", action = "Slide", label = "slide", pad = Enum.KeyCode.ButtonB}, 1, true)
    v54.group.GroupTransparency = 1
    local v55 = newRow(ui2, {key = "V", action = "View", label = "first person", pad = Enum.KeyCode.DPadUp}, 2, true)
    local camera = replicatedStorage:WaitForChild("Shared"):FindFirstChild("Camera")

    local success, result2 = pcall(
        function()
            --[[
              line: 191
              upvalues:
                camera (copy, index: 1)
            ]]
            if camera then
                return (require(camera))
            end

            return nil
        end
    )

    if not success or type(result2) ~= "table" then
        result = nil
    else
        result = result2
    end

    local function paintView()
        --[[
          name: paintView
          line: 196
          upvalues:
            result (ref,  index: 1)
            v55 (copy, index: 2)
        ]]
        local isFirstPerson = result ~= nil and result.IsFirstPerson ~= nil and result.IsFirstPerson() == true
        v55.label.Text = isFirstPerson and "third person" or "first person"
    end

    local isFirstPerson = result ~= nil and result.IsFirstPerson ~= nil and result.IsFirstPerson() == true
    local label = v55.label

    if isFirstPerson then
        text = "third person"
    else
        text = "first person"
    end

    label.Text = text

    if result and typeof(result.FirstPersonChanged) == "RBXScriptSignal" then
        result.FirstPersonChanged:Connect(paintView)
    end

    local function layout()
        --[[
          name: layout
          line: 205
          upvalues:
            a10 (copy, index: 1)
            ui (copy, index: 2)
            parent (copy, index: 3)
            ui2 (copy, index: 4)
        ]]
        local v64 = not a10.HotbarWidth and 372 or a10.HotbarWidth()
        local v65 = ui.Compact and -8 or -18
        parent.Position = UDim2.new(0.5, math.floor(v64 / 2) + 22, 1, v65)
        ui2.Position = UDim2.new(0.5, -(math.floor(v64 / 2) + 22), 1, v65)
    end

    layout()
    ui.LayoutChanged:Connect(layout)

    local function kindOf(a67)
        --[[
          name: kindOf
          line: 215
          upvalues:
            weaponInfo (copy, index: 1)
            v9 (copy, index: 2)
        ]]
        if a67 == "bandage" then
            return "Bandage"
        end
        if a67 == "healing_tonic" then
            return "Tonic"
        end
        if a67 == "palisade" then
            return "Wall"
        end

        local v68 = weaponInfo.Get(a67)
        local kind = v68 and v68.kind

        if type(kind) == "string" and v9[kind] then
            return kind
        end

        return nil
    end

    local function heldTool()
        --[[
          name: heldTool
          line: 231
          upvalues:
            localPlayer (copy, index: 1)
        ]]
        local model = localPlayer.Character
        model = model and model:FindFirstChildOfClass("Tool")

        if model and model:IsA("Tool") then
            return model
        end

        return nil
    end

    local v72 = {}
    local v73 = nil
    local v74 = 0
    local kind = nil

    local function rebuild(a77)
        --[[
          name: rebuild
          line: 242
          upvalues:
            v72 (copy, index: 1)
            v73 (ref,  index: 2)
            v9 (copy, index: 3)
            newRow (copy, index: 4)
            parent (copy, index: 5)
        ]]
        for _, v79 in v72 do
            v79.group:Destroy()
        end

        table.clear(v72)
        v73 = a77
        local v80 = a77 and v9[a77]
        if not v80 then
            return
        end

        local actCount = #v80.acts

        for v82, act in v80.acts do
            v72[v82] = newRow(parent, act, actCount - v82, false)
        end
    end

    local function emphasize(key)
        --[[
          name: emphasize
          line: 259
          upvalues:
            v74 (ref,  index: 1)
            v72 (copy, index: 2)
            kindsMask (ref,  index: 3)
            v9 (copy, index: 4)
            state (copy, index: 5)
            a10 (copy, index: 6)
        ]]
        v74 = os.clock() + 6

        for _, v87 in v72 do
            v87.group.GroupTransparency = 1
        end

        if not bit32.btest(kindsMask, (bit32.lshift(1, v9[key].bit))) then
            kindsMask = bit32.bor(kindsMask, (bit32.lshift(1, v9[key].bit)))
            local v88 = kindsMask

            if state.Mock then
                return
            end

            local v89 = "tutKinds"
            task.spawn(
                function()
                    --[[
                      line: 106
                      upvalues:
                        a10 (copy, index: 1)
                        v89 (copy, index: 2)
                        v88 (copy, index: 3)
                    ]]
                    a10.Remotes.Invoke("ProfileAction", "SetSetting", v89, v88)
                end
            )
        end
    end

    a10.HeldWeaponChanged:Connect(
        function(a90)
            --[[
              line: 270
              upvalues:
                weaponInfo (copy, index: 1)
                v9 (copy, index: 2)
                v73 (ref,  index: 3)
                rebuild (copy, index: 4)
                loaded (ref,  index: 5)
                kindsMask (ref,  index: 6)
                a10 (copy, index: 7)
                kind (ref,  index: 8)
                emphasize (copy, index: 9)
            ]]
            local kind2

            if a90 == "bandage" then
                kind2 = "Bandage"
            elseif a90 == "healing_tonic" then
                kind2 = "Tonic"
            elseif a90 == "palisade" then
                kind2 = "Wall"
            else
                local v92 = weaponInfo.Get(a90)
                local kind3 = v92 and v92.kind

                if type(kind3) ~= "string" or not v9[kind3] then
                    kind2 = nil
                else
                    kind2 = kind3
                end
            end

            if kind2 ~= v73 then
                rebuild(kind2)
            end

            if kind2 and loaded and not bit32.btest(kindsMask, (bit32.lshift(1, v9[kind2].bit))) then
                if a10.HudHidden then
                    kind = kind2
                else
                    emphasize(kind2)
                end
            end
        end
    )

    a10.HudHiddenChanged:Connect(
        function(a94)
            --[[
              line: 284
              upvalues:
                kind (ref,  index: 1)
                v73 (ref,  index: 2)
                emphasize (copy, index: 3)
            ]]
            if not a94 and kind and kind == v73 then
                local kind2 = kind
                kind = nil
                task.defer(emphasize, kind2)
            end
        end
    )

    local function inCombat()
        --[[
          name: inCombat
          line: 293
          upvalues:
            state (copy, index: 1)
            a10 (copy, index: 2)
        ]]
        return state.Get("CombatMode") ~= false
            and state.IsAlive()
            and not a10.HudHidden
            and not state.Watching()
    end

    local v97 = false
    local position = nil
    local timestamp = os.clock()

    local function planarSpeed()
        --[[
          name: planarSpeed
          line: 301
          upvalues:
            localPlayer (copy, index: 1)
            position (ref,  index: 2)
            timestamp (ref,  index: 3)
        ]]
        local instance = localPlayer.Character
        instance = instance and instance:FindFirstChild("HumanoidRootPart")
        local timestamp2 = os.clock()

        if not instance or not instance:IsA("BasePart") then
            position = nil
            return 0
        end

        local position2 = instance.Position
        local v104 = 0

        if position and timestamp < timestamp2 then
            v104 = ((position2 - position) * Vector3.new(1, 0, 1)).Magnitude / (timestamp2 - timestamp)

            if 120 < v104 then
                v104 = 0
            end
        end

        position = position2
        timestamp = timestamp2

        return v104
    end

    local v105 = 0
    local timestamp2 = -math.huge

    local function threwHatchet()
        --[[
          name: threwHatchet
          line: 324
          upvalues:
            kindsMask (ref, index: 1)
        ]]
        return (bit32.btest(kindsMask, 33554432))
    end

    local v108 = nil

    local function setTouchNudge(nudge)
        --[[
          name: setTouchNudge
          line: 328
          upvalues:
            v108 (ref,  index: 1)
            localPlayer (copy, index: 2)
        ]]
        if nudge == v108 then
            return
        end

        local instance = localPlayer:FindFirstChildOfClass("PlayerGui")
        instance = instance and instance:FindFirstChild("CombatTouch")

        if instance then
            v108 = nudge
            instance:SetAttribute("Nudge", nudge)
        end
    end

    ui.Every(
        parent,
        0.1,
        function()
            --[[
              line: 339
              upvalues:
                localPlayer (copy, index: 1)
                v73 (ref,  index: 2)
                loaded (ref,  index: 3)
                kindsMask (ref,  index: 4)
                state (copy, index: 5)
                a10 (copy, index: 6)
                ui (copy, index: 7)
                v108 (ref,  index: 8)
                v72 (copy, index: 9)
                parent (copy, index: 10)
                layout (copy, index: 11)
                v74 (ref,  index: 12)
                colors (copy, index: 13)
                theme (copy, index: 14)
                v31 (ref,  index: 15)
                matchesSeen (ref,  index: 16)
                planarSpeed (copy, index: 17)
                v105 (ref,  index: 18)
                timestamp2 (ref,  index: 19)
                ui2 (copy, index: 20)
                v97 (ref,  index: 21)
                v54 (copy, index: 22)
            ]]
            local nudge
            local model = localPlayer.Character
            model = model and model:FindFirstChildOfClass("Tool")
            local model2 = if model and model:IsA("Tool") then model else nil
            local v115 = v73 == "Hatchets" and model2 ~= nil
            local thrown = v115 and model2:GetAttribute("Thrown") == true
            local landed = thrown and model2:GetAttribute("Landed") == true

            if thrown and loaded and not bit32.btest(kindsMask, 33554432) then
                kindsMask = bit32.bor(kindsMask, 33554432)
                local v118 = kindsMask

                if not state.Mock then
                    local v119 = "tutKinds"
                    task.spawn(
                        function()
                            --[[
                              line: 106
                              upvalues:
                                a10 (copy, index: 1)
                                v119 (copy, index: 2)
                                v118 (copy, index: 3)
                            ]]
                            a10.Remotes.Invoke("ProfileAction", "SetSetting", v119, v118)
                        end
                    )
                end
            end

            if not ui.Touch or not v115 or thrown or not loaded or bit32.btest(kindsMask, 33554432) then
                nudge = nil
            else
                local v120 = state.Get("CombatMode") ~= false
                    and state.IsAlive()
                    and not a10.HudHidden
                    and not state.Watching()

                if v120 then
                    nudge = "Secondary"
                else
                    nudge = nil
                end
            end

            if nudge ~= v108 then
                local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

                if const combatTouch = playerGui and playerGui:FindFirstChild("CombatTouch") then
                    v108 = nudge
                    combatTouch:SetAttribute("Nudge", nudge)
                end
            end

            local visible = not ui.Touch
            if visible then
                local v124 = state.Get("CombatMode") ~= false
                    and state.IsAlive()
                    and not a10.HudHidden
                    and not state.Watching()
                visible = v124 and 0 < #v72 and model2 ~= nil
            end

            parent.Visible = visible

            if visible then
                layout()
                local ammo = model2:GetAttribute("Ammo")
                local maxAmmo = model2:GetAttribute("MaxAmmo")
                local reloading = model2:GetAttribute("Reloading") == true
                local v128 = type(ammo) == "number" and type(maxAmmo) == "number" and 0 < maxAmmo and ammo <= 0
                local v129 = os.clock() < v74
                local v130, reloading2

                for _, v133 in v72 do
                    local v134

                    if v133.act.reload == true then
                        v130 = v128

                        if v130 then
                            v134 = v130
                        else
                            reloading2 = reloading

                            if reloading2 then
                                v134 = reloading2
                            else
                                v134 = v133.act.hatchet == true and landed
                            end
                        end
                    else
                        v134 = v133.act.hatchet == true and landed
                    end

                    local groupTransparency = not v129 and not v134 and 0.45 or 0
                    local capFade = 0

                    if v133.act.hatchet then
                        if thrown and not landed then
                            groupTransparency = 0.7
                            capFade = 0.75
                        elseif thrown then
                            capFade = 1
                        elseif loaded and not bit32.btest(kindsMask, 33554432) then
                            groupTransparency = 0
                        end

                        v133.label.Text = landed and "pick up" or "throw"
                        v133.label.TextColor3 = if landed then colors.Warning else colors.Text
                    end

                    if 0.01 < math.abs(v133.group.GroupTransparency - groupTransparency) then
                        ui.Tween(v133.group, theme.Tween.Smooth, {GroupTransparency = groupTransparency})
                    end

                    if capFade ~= v133.capFade then
                        v133.capFade = capFade
                        ui.SetCapFade(v133.cap, capFade)
                    end

                    if v133.act.reload then
                        v133.label.Text = reloading and "reloading" or "reload"
                        v133.label.TextColor3 = if v134 then colors.Warning else colors.Text
                    end
                end
            end

            local v137 = loaded and (if state.InMatch() then v31 else matchesSeen < 3)
            local v138 = planarSpeed()
            local v139 = false

            if not v137 or ui.Touch then
                v105 = 0
            else
                local v140 = state.Get("CombatMode") ~= false
                    and state.IsAlive()
                    and not a10.HudHidden
                    and not state.Watching()

                if v140 then
                    local character = localPlayer.Character
                    v105 = if 12 < v138 and character and character:GetAttribute("Sliding") ~= true then v105 + 1 else 0

                    if 3 <= v105 then
                        timestamp2 = os.clock()
                    end

                    v139 = os.clock() - timestamp2 < 1.5
                else
                    v105 = 0
                end
            end

            ui2.Visible = not ui.Touch
                and state.Get("CombatMode") ~= false
                and state.IsAlive()
                and not a10.HudHidden
                and not state.Watching()

            if v139 ~= v97 then
                local groupTransparency
                v97 = v139
                local tween = ui.Tween
                local group = v54.group
                local smooth = theme.Tween.Smooth
                local v146 = {}

                if v139 then
                    groupTransparency = 0.35
                else
                    groupTransparency = 1
                end

                v146.GroupTransparency = groupTransparency
                tween(group, smooth, v146)
            end
        end
    )

    a10.Debug.tutorial = function(a147)
        --[[
          line: 411
          upvalues:
            kindsMask (ref,  index: 1)
            matchesSeen (ref,  index: 2)
            state (copy, index: 3)
            a10 (copy, index: 4)
            loaded (ref,  index: 5)
            v73 (ref,  index: 6)
            v72 (copy, index: 7)
        ]]
        if a147 ~= "reset" then
            return {kindsMask = kindsMask, matchesSeen = matchesSeen, loaded = loaded, kind = v73, rows = #v72}
        end

        kindsMask = 0
        matchesSeen = 0

        if not state.Mock then
            local v148 = "tutKinds"
            local v149 = 0
            task.spawn(
                function()
                    --[[
                      line: 106
                      upvalues:
                        a10 (copy, index: 1)
                        v148 (copy, index: 2)
                        v149 (copy, index: 3)
                    ]]
                    a10.Remotes.Invoke("ProfileAction", "SetSetting", v148, v149)
                end
            )
        end

        if not state.Mock then
            local v150 = "tutMatches"
            local v151 = 0
            task.spawn(
                function()
                    --[[
                      line: 106
                      upvalues:
                        a10 (copy, index: 1)
                        v150 (copy, index: 2)
                        v151 (copy, index: 3)
                    ]]
                    a10.Remotes.Invoke("ProfileAction", "SetSetting", v150, v151)
                end
            )
        end

        return true
    end

    a10.Debug.hints = function(key)
        --[[
          line: 421
          upvalues:
            v9 (copy, index: 1)
            rebuild (copy, index: 2)
            emphasize (copy, index: 3)
            v72 (copy, index: 4)
            v73 (ref,  index: 5)
            parent (copy, index: 6)
            ui2 (copy, index: 7)
            kindsMask (ref,  index: 8)
            v108 (ref,  index: 9)
        ]]
        if type(key) == "string" and v9[key] then
            rebuild(key)
            emphasize(key)

            return true
        end

        local texts = {}

        for _, v155 in v72 do
            table.insert(texts, {key = v155.act.key, label = v155.label.Text, transparency = v155.group.GroupTransparency, capFade = v155.capFade})
        end

        return {kind = v73, rows = #v72, visible = parent.Visible, slide = ui2.Visible, texts = texts, threwHatchet = bit32.btest(kindsMask, 33554432), nudge = v108
            or false}
    end
end

return v3