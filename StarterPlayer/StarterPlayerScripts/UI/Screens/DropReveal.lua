local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local contextActionService = game:GetService("ContextActionService")
local proximityPromptService = game:GetService("ProximityPromptService")
local workspace = game:GetService("Workspace")
local v9 = {}
local fontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
local color3FromRGB = Color3.fromRGB
local v12 = {
    drop = {title = "DROP", model = "Drop", fit = 0.84, rays = 0.8, burst = 20, sparkle = 5, idle = 1.2, wiggle = 5, primary = color3FromRGB(116, 158, 222), deep = color3FromRGB(16, 28, 54), light = color3FromRGB(186, 212, 246)},
    victory = {title = "VICTORY DROP", model = "Victory", fit = 1, rays = 0.68, burst = 30, sparkle = 8, idle = 1.2, wiggle = 6, primary = color3FromRGB(40, 150, 255), deep = color3FromRGB(8, 32, 84), light = color3FromRGB(148, 206, 255)},
    golden = {title = "GOLDEN DROP", model = "Golden", fit = 0.98, rays = 0.52, burst = 54, sparkle = 16, idle = 1.55, wiggle = 8, legendary = true, primary = color3FromRGB(255, 186, 46), deep = color3FromRGB(92, 50, 4), light = color3FromRGB(255, 226, 150)}
}
local v13 = {fall = 0.42, settle = 0.5, openCrouch = 0.1, openHold = 0.6, toCards = 0.42, cardFly = 0.32, flip = 0.2, count = 0.42, bar = 0.5, dwell = 0.45, cardOut = 0.16, newItem = 2, hold = 0.55, summaryAuto = {match = 15, lobby = 20, robux = 20}}
local v14 = {stageH = 780, stageW = 1200, titleY = -335, chestY = 20, chestCardY = 290, chestCardScale = 0.46, cardY = -64, cardW = 232, cardH = 322, barY = 128, barW = 330, promptY = 332}
local v15 = {small = 10, medium = 20, large = 40, starter = 0}
local v16 = {small = {10, 20, 40, 80}, medium = {20, 40, 80, 160}, large = {40, 80, 160, 320}, starter = {10, 20, 40, 80}}

function v9.Init(a17)
    --[[
      name: Init
      line: 103
      upvalues:
        replicatedStorage (copy, index: 1)
        players (copy, index: 2)
        v15 (copy, index: 3)
        v16 (copy, index: 4)
        tweenService (copy, index: 5)
        color3FromRGB (copy, index: 6)
        fontFace (copy, index: 7)
        lighting (copy, index: 8)
        v13 (copy, index: 9)
        v14 (copy, index: 10)
        workspace (copy, index: 11)
        proximityPromptService (copy, index: 12)
        v12 (copy, index: 13)
        runService (copy, index: 14)
        contextActionService (copy, index: 15)
    ]]
    local buildChest
    local v19
    local v20
    local ui = a17.UI
    local theme = a17.Theme
    local state = a17.State
    local weaponInfo = a17.WeaponInfo
    local weaponIcon = a17.WeaponIcon
    local colors = theme.Colors
    local fonts = theme.Fonts
    local v28 = ui.Assets.Fx or {}
    local Fx = require(script.Parent.Parent.Fx)
    local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
    local localPlayer = players.LocalPlayer
    local dropReveal = {Changed = Signal.new()}
    a17.DropReveal = dropReveal
    local shared = replicatedStorage:WaitForChild("Shared")
    local result = nil
    local timestamp = -math.huge

    local function shards()
        --[[
          name: shards
          line: 120
          upvalues:
            result (ref,  index: 1)
            timestamp (ref,  index: 2)
            shared (copy, index: 3)
        ]]
        if not result then
            if os.clock() - timestamp < 5 then
                return nil
            end

            timestamp = os.clock()
            local shards = shared:FindFirstChild("Shards")

            if shards and shards:IsA("ModuleScript") then
                local success, result2 = pcall(require, shards)

                if success and type(result2) == "table" then
                    result = result2
                end
            end
        end

        return result
    end

    local v40 = nil

    local function sizeOf(a42)
        --[[
          name: sizeOf
          line: 138
          upvalues:
            v40 (ref,  index: 1)
            shared (copy, index: 2)
        ]]
        if not v40 then
            local success, result = pcall(require, (shared:FindFirstChild("Unlocks")))

            if not success or type(result) ~= "table" then
                v40 = {}
            else
                v40 = result
            end
        end

        if type(v40.SizeOf) == "function" then
            local success, result = pcall(v40.SizeOf, a42)

            if success and type(result) == "string" then
                return result
            end
        end

        return "medium"
    end

    local function unlockCost(a48)
        --[[
          name: unlockCost
          line: 152
          upvalues:
            shards (copy, index: 1)
            v15 (copy, index: 2)
            sizeOf (copy, index: 3)
        ]]
        local v49 = shards()

        if v49 and type(v49.UnlockCost) == "function" then
            local success, result = pcall(v49.UnlockCost, a48)

            if success and type(result) == "number" then
                return result
            end
        end

        return v15[sizeOf(a48)] or 20
    end

    local function upgradeCost(item, key: number)
        --[[
          name: upgradeCost
          line: 162
          upvalues:
            shards (copy, index: 1)
            v16 (copy, index: 2)
            sizeOf (copy, index: 3)
        ]]
        local v55 = shards()

        if v55 and type(v55.UpgradeCost) == "function" then
            local success, result = pcall(v55.UpgradeCost, item, key)
            if success then
                if type(result) ~= "number" then
                    return nil
                end

                return result
            end
        end

        local v58 = v16[sizeOf(item)] or v16.medium

        return v58[key]
    end

    local function catColor(item)
        --[[
          name: catColor
          line: 173
          upvalues:
            a17 (copy, index: 1)
            weaponInfo (copy, index: 2)
            colors (copy, index: 3)
        ]]
        local economy = a17.Economy

        if economy and type(economy.CategoryColor) == "function" then
            local success, result = pcall(economy.CategoryColor, item)

            if success and typeof(result) == "Color3" then
                return result
            end
        end

        local v64 = weaponInfo.Get(item)

        return v64 and weaponInfo.CATEGORY_COLORS and weaponInfo.CATEGORY_COLORS[v64.category]
            or colors.Accent
    end

    local function catWord(a66)
        --[[
          name: catWord
          line: 184
          upvalues:
            weaponInfo (copy, index: 1)
        ]]
        local v67 = weaponInfo.Get(a66)
        return v67 and weaponInfo.CATEGORY_SINGULAR and weaponInfo.CATEGORY_SINGULAR[v67.category] or "ITEM"
    end

    local function normStack(stack)
        --[[
          name: normStack
          line: 203
          upvalues:
            shards (copy, index: 1)
            v15 (copy, index: 2)
            sizeOf (copy, index: 3)
            upgradeCost (copy, index: 4)
        ]]
        if type(stack) ~= "table" or type(stack.item) ~= "string" then
            return nil
        end

        local v70
        local item = stack.item
        local shards2 = math.max(0, (math.floor((tonumber(stack.shards) or 0))))
        local before = math.max(0, (math.floor((tonumber(stack.before) or 0))))
        local levelBefore = math.max(0, (math.floor((tonumber(stack.levelBefore) or 0))))
        local v75 = {unlocked = false, ready = false, surplus = 0, needAfter = nil, item = item, shards = shards2, before = before, levelBefore = levelBefore, total = before + shards2, bonus = stack.bonus == true}
        local number = tonumber(stack.need)

        if levelBefore <= 0 then
            local v77

            if number then
                if not (0 < number) then
                    local v78 = shards()

                    if not v78 or type(v78.UnlockCost) ~= "function" then
                        v77 = v15[sizeOf(item)] or 20
                    else
                        local success, result = pcall(v78.UnlockCost, item)

                        if not success or type(result) ~= "number" then
                            v77 = v15[sizeOf(item)] or 20
                        else
                            v77 = result
                        end
                    end
                else
                    v77 = number
                end
            else
                local v78 = shards()

                if not v78 or type(v78.UnlockCost) ~= "function" then
                    v77 = v15[sizeOf(item)] or 20
                else
                    local success, result = pcall(v78.UnlockCost, item)

                    if not success or type(result) ~= "number" then
                        v77 = v15[sizeOf(item)] or 20
                    else
                        v77 = result
                    end
                end
            end

            v75.need = math.max(1, v77)
            v75.unlocked = stack.unlocked == true or v75.need <= v75.total

            if not v75.unlocked then
                return v75
            end

            v75.surplus = math.max(0, v75.total - v75.need)
            v75.needAfter = upgradeCost(item, 1)
            local v81 = stack.ready == true

            if v81 or v75.needAfter == nil then
                v75.ready = v81
                return v75
            end

            local surplus = v75.surplus
            v81 = v75.needAfter <= surplus
            v75.ready = v81

            return v75
        end

        if number == nil then
            v75.need = upgradeCost(item, levelBefore)
        else
            v75.need = if 0 < number then number else nil
        end

        local number2 = tonumber(stack.after)

        if number2 and before <= number2 then
            v75.total = number2
        end

        local v84 = stack.ready == true

        if not v84 and v75.need ~= nil then
            local total = v75.total
            v84 = v75.need <= total
        end

        v75.ready = v84
        v70 = v75

        return v70
    end

    local function normReveal(raw)
        --[[
          name: normReveal
          line: 238
          upvalues:
            normStack (copy, index: 1)
        ]]
        if type(raw) ~= "table" then
            return nil
        end

        local source
        local v89 = raw.kind ~= "golden" and raw.kind ~= "victory" and "drop" or raw.kind
        local stacks = {}

        if type(raw.stacks) == "table" then
            for _, stack in raw.stacks do
                if const v93 = normStack(stack) then
                    table.insert(stacks, v93)
                end
            end
        end

        local v94 = {id = tostring((raw.id or "")), kind = v89}

        if type(raw.source) ~= "string" then
            source = "match"
        else
            source = raw.source
        end

        v94.source = source
        v94.stacks = stacks
        v94.xp = tonumber(raw.xp)
        v94.raw = raw

        return v94
    end

    dropReveal.Normalize = normReveal
    local v95 = nil

    if const dropModels = script.Parent.Parent:FindFirstChild("DropModels") then
        local success, result2 = pcall(require, dropModels)

        if success then
            if type(result2) ~= "table" then
                v19 = v95
            else
                v19 = result2
            end
        else
            v19 = v95
        end
    else
        v19 = v95
    end

    local pace = 1
    local hasRun = false
    local v101 = {}
    local v102 = nil
    local count = 0
    local v104 = false

    local function strokeFor(a106, a107)
        --[[
          name: strokeFor
          line: 285
        ]]
        local v108 = if a106:IsA("TextLabel") then a106:FindFirstChildWhichIsA("UIStroke") else nil
        if not v108 then
            return nil, 1
        end

        local v109 = v108:GetAttribute("Authored")

        if type(v109) ~= "number" then
            v109 = v108.Transparency
            v108:SetAttribute("Authored", v109)
        end

        if 0.99 <= a107 then
            return v108, 1
        end

        return v108, v109 + ((1 - v109) * a107)
    end

    local function setTT(tt, textTransparency)
        --[[
          name: setTT
          line: 297
          upvalues:
            strokeFor (copy, index: 1)
        ]]
        tt.TextTransparency = textTransparency
        local v113, transparency = strokeFor(tt, textTransparency)
        if v113 then
            v113.Transparency = transparency
        end
    end

    local function tw(instance, a117, propertyTable, easingStyle: Enum.EasingStyle?, easingDirection: Enum.EasingDirection?, a121)
        --[[
          name: tw
          line: 304
          upvalues:
            pace (ref,  index: 1)
            tweenService (copy, index: 2)
            v102 (ref,  index: 3)
            strokeFor (copy, index: 4)
        ]]
        local easingStyle2
        local v123 = TweenInfo.new
        local v124 = math.max(0, a117 * pace)

        if easingStyle then
            easingStyle2 = easingStyle
        else
            easingStyle2 = Enum.EasingStyle.Quint
        end

        v123 = v123(v124, easingStyle2, (easingDirection or Enum.EasingDirection.Out), 0, false, (a121 or 0) * pace)
        local tween = tweenService:Create(instance, v123, propertyTable)
        tween:Play()

        if v102 and v102.group then
            table.insert(v102.group, {tween, instance, propertyTable})
        end

        if propertyTable.TextTransparency ~= nil then
            local instance2, transparency = strokeFor(instance, propertyTable.TextTransparency)
            if instance2 then
                local propertyTable2 = {Transparency = transparency}
                tweenService:Create(instance2, v123, propertyTable2):Play()

                if v102 and v102.group then
                    table.insert(v102.group, {nil, instance2, propertyTable2})
                end
            end
        end

        return tween
    end

    local function finishGroup()
        --[[
          name: finishGroup
          line: 324
          upvalues:
            v102 (ref, index: 1)
        ]]
        if not v102 or not v102.group then
            return
        end

        for _, v131 in v102.group do
            if v131[1] then
                v131[1]:Cancel()
            end

            for v132, v133 in v131[3] do
                pcall(
                    function()
                        --[[
                          line: 333
                          upvalues:
                            v131 (copy, index: 1)
                            v132 (copy, index: 2)
                            v133 (copy, index: 3)
                        ]]
                        v131[2][v132] = v133
                    end
                )
            end
        end

        table.clear(v102.group)
    end

    local v134 = {y = 0, yaw = 0, roll = 0, pitch = 0, sq = 0, lid = 0, s = 1, raysSpin = 8, glow = 0}
    local v135 = {}
    local v136 = {
        linear = (function(a137)
            --[[
              name: linear
              line: 345
            ]]
            return a137
        end),
        outQuad = (function(a138)
            --[[
              name: outQuad
              line: 348
            ]]
            return 1 - ((1 - a138) * (1 - a138))
        end),
        inQuad = (function(a139)
            --[[
              name: inQuad
              line: 351
            ]]
            return a139 * a139
        end),
        outCubic = (function(a140)
            --[[
              name: outCubic
              line: 354
            ]]
            return 1 - ((function(...) return (...) ^ 3 end)(((1 - a140))))
        end),
        inOutSine = (function(a141)
            --[[
              name: inOutSine
              line: 357
            ]]
            return -(math.cos(math.pi * a141) - 1) / 2
        end),
        outBack = (function(a142)
            --[[
              name: outBack
              line: 360
            ]]
            return 1 + (2.9 * ((function(...) return (...) ^ 3 end)(((a142 - 1))))) + (1.9 * ((function(...) return (...) ^ 2 end)(((a142 - 1)))))
        end)
    }

    local function animate(key: string, a145)
        --[[
          name: animate
          line: 366
          upvalues:
            v136 (copy, index: 1)
            v135 (copy, index: 2)
        ]]
        local v146 = {}

        for _, v148 in a145 do
            local v149 = {t = 0, from = nil, to = v148[1], dur = math.max(0.001, v148[2]), ease = v136[v148[3]
                or "outQuad"]
                or v136.outQuad}
            v149.delay = v148[4] or 0
            table.insert(v146, v149)
        end

        v135[key] = v146
    end

    local function snapAnims()
        --[[
          name: snapAnims
          line: 373
          upvalues:
            v135 (copy, index: 1)
            v134 (copy, index: 2)
        ]]
        for v151, v152 in v135 do
            if const v153 = v152[#v152] then
                v134[v151] = v153.to
            end
        end

        table.clear(v135)
    end

    local function stepAnims(a155)
        --[[
          name: stepAnims
          line: 382
          upvalues:
            v135 (copy, index: 1)
            v134 (copy, index: 2)
        ]]
        for v156, v157 in v135 do
            local v158 = false
            local v159 = v157[1]

            if v159 then
                if not (0 < v159.delay) then
                    v158 = true
                else
                    v159.delay -= a155

                    if not (0 < v159.delay) then
                        a155 = -v159.delay
                        v159.delay = 0
                        v158 = true
                    end
                end
            else
                v135[v156] = nil
            end

            if v158 then
                if v159.from == nil then
                    v159.from = v134[v156]
                end

                v159.t += a155
                local v160 = math.min(1, v159.t / v159.dur)
                v134[v156] = v159.from + ((v159.to - v159.from) * v159.ease(v160))

                if 1 <= v160 then
                    table.remove(v157, 1)

                    if #v157 == 0 then
                        v135[v156] = nil
                    end
                end
            end
        end
    end

    local v161 = {}
    local v162 = nil
    local cframe = CFrame.new()
    local cframe2 = CFrame.new()
    local cFrame = CFrame.lookAt(Vector3.new(0, 4.800000190734863, -14), Vector3.new(0, 2.799999952316284, 0))

    local function build()
        --[[
          name: build
          line: 421
          upvalues:
            hasRun (ref,  index: 1)
            ui (copy, index: 2)
            a17 (copy, index: 3)
            v101 (copy, index: 4)
            colors (copy, index: 5)
            v28 (copy, index: 6)
            Fx (copy, index: 7)
            color3FromRGB (copy, index: 8)
            cFrame (copy, index: 9)
            theme (copy, index: 10)
            fonts (copy, index: 11)
            fontFace (copy, index: 12)
        ]]
        local transparency, v168
        local transparency2, v170
        local transparency3, v172
        local transparency4, v174

        if hasRun then
            return
        end

        hasRun = true
        local gui, v176 = ui.Screen("TR_Reveal", 30, a17.PlayerGui, {fullBleed = true})
        gui.Enabled = true
        v101.gui = gui
        v101.canvas = v176
        local ui2 = ui.new("Frame", {Name = "Reveal", Visible = false, Size = UDim2.fromScale(1, 1), Parent = v176})
        v101.root = ui2
        v101.dim = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = ui2})
        v101.tint = ui.new("ImageLabel", {Name = "Tint", ImageTransparency = 1, ZIndex = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.3, 1.6), Image = ui.Assets.Icons.Glow
            or "", Parent = ui2})
        v101.vignette = ui.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, ZIndex = 2, Size = UDim2.fromScale(1, 1), Image = v28.Vignette
            or "", ImageColor3 = colors.Void, ScaleType = Enum.ScaleType.Stretch, Parent = ui2})
        v101.flash = ui.new("Frame", {Name = "Flash", BackgroundTransparency = 1, ZIndex = 20, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Accent, Parent = ui2})
        v101.catcher = ui.new("TextButton", {Name = "Input", Modal = true, Selectable = false, ZIndex = 3, Size = UDim2.fromScale(1, 1), Parent = ui2})
        local ui3 = ui.new("Frame", {Name = "Stage", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 0), Parent = ui2})
        v101.stage = ui3
        v101.stageScale = ui.new("UIScale", {Parent = ui3})
        local ui4 = ui.new("Frame", {Name = "Shaker", ZIndex = 4, Size = UDim2.fromOffset(0, 0), Parent = ui3})
        v101.shaker = ui4

        local function img(name: string, a182, zIndex: number, options)
            --[[
              name: img
              line: 465
              upvalues:
                ui4 (copy, index: 1)
                ui (copy, index: 2)
            ]]
            local v185 = options or {}
            v185.Name = name
            local v186 = v185.AnchorPoint or Vector2.new(0.5, 0.5)
            v185.AnchorPoint = v186
            v185.Image = a182 or ""
            v185.ImageTransparency = v185.ImageTransparency == nil and 1 or v185.ImageTransparency
            v185.ZIndex = zIndex
            v185.Parent = v185.Parent or ui4

            return ui.new("ImageLabel", v185)
        end

        v101.raysHolder = ui.new("Frame", {Name = "RaysHolder", ZIndex = 4, Size = UDim2.fromOffset(0, 0), Parent = ui4})
        v101.raysScale = ui.new("UIScale", {Parent = v101.raysHolder})
        v101.raysA = img("RaysA", v28.Rays, 4, {Size = UDim2.fromOffset(1100, 1100), Parent = v101.raysHolder})
        v101.raysB = img("RaysB", v28.RaysThin, 4, {Size = UDim2.fromOffset(1250, 1250), Parent = v101.raysHolder})
        v101.halo = img("Halo", ui.Assets.Icons.Glow, 5, {Size = UDim2.fromOffset(620, 620), Parent = v101.raysHolder})
        v101.backLayer = ui.new("Frame", {Name = "BackFx", ZIndex = 6, Size = UDim2.fromOffset(0, 0), Parent = ui4})
        v101.backPool = Fx.Pool(v101.backLayer, 60, 6)
        v101.floorRing = img("FloorRing", v28.GlowRing, 6, {Size = UDim2.fromOffset(200, 50)})
        v101.shadow = img("Shadow", ui.Assets.Icons.Glow, 6, {Size = UDim2.fromOffset(380, 76), ImageColor3 = colors.Void})
        v101.beam = img("Beam", v28.Beam, 7, {AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(220, 620)})
        v101.chestHolder = ui.new("Frame", {Name = "Chest", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(600, 600), Parent = ui4})
        v101.chestScale = ui.new("UIScale", {Parent = v101.chestHolder})
        v101.chestGlow = img("ChestGlow", ui.Assets.Icons.Glow, 7, {Size = UDim2.fromOffset(540, 460), Position = UDim2.fromScale(0.5, 0.6), Parent = v101.chestHolder})
        local ui5 = ui.new("ViewportFrame", {Name = "View", LightDirection = Vector3.new(0.44999998807907104, -1, 0.550000011920929), ZIndex = 8, Size = UDim2.fromScale(1, 1), Ambient = color3FromRGB(150, 146, 150), LightColor = color3FromRGB(255, 244, 228), Parent = v101.chestHolder})
        v101.vpf = ui5
        local camera = Instance.new("Camera")
        camera.FieldOfView = 28
        camera.CFrame = cFrame
        camera.Parent = ui5
        ui5.CurrentCamera = camera
        v101.cam = camera
        v101.leak = img("Leak", ui.Assets.Icons.Glow, 9, {Size = UDim2.fromOffset(300, 90), Parent = v101.chestHolder})
        v101.leakFlare = img("LeakFlare", v28.Flare, 9, {Size = UDim2.fromOffset(420, 44), Parent = v101.chestHolder})
        v101.counter = ui.new("Frame", {Name = "Counter", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(74, 50), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.05, Visible = false, ZIndex = 10, (ui.Corner(theme.Radius.Pill)), Parent = ui4})
        v101.counterStroke = ui.Stroke(colors.Accent, 2, 0.2)
        v101.counterStroke.Parent = v101.counter
        v101.counterText = ui.new("TextLabel", {Text = "x3", TextSize = 30, ZIndex = 11, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = v101.counter})
        v101.frontLayer = ui.new("Frame", {Name = "FrontFx", ZIndex = 14, Size = UDim2.fromOffset(0, 0), Parent = ui4})
        v101.frontPool = Fx.Pool(v101.frontLayer, 120, 14)

        local function headline(name: string, textSize: number, zIndex: number)
            --[[
              name: headline
              line: 535
              upvalues:
                ui (copy, index: 1)
                fontFace (copy, index: 2)
                colors (copy, index: 3)
                ui4 (copy, index: 4)
            ]]
            return ui.new("TextLabel", {Text = "", TextTransparency = 1, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1200, textSize * 1.2), FontFace = fontFace, TextSize = textSize, TextColor3 = colors.Text, ZIndex = zIndex, Parent = ui4})
        end

        v101.titleShadow = headline("TitleShadow", 64, 15)
        v101.titleShadow.TextColor3 = colors.Void
        v101.title = headline("Title", 64, 16)
        v101.titleScale = ui.new("UIScale", {Parent = v101.title})
        v101.titleShadowScale = ui.new("UIScale", {Parent = v101.titleShadow})
        v101.titleGrad = ui.new("UIGradient", {Rotation = 90, Parent = v101.title})
        v101.subtitle = ui.new("TextLabel", {Name = "Subtitle", Text = "", TextSize = 22, TextTransparency = 1, ZIndex = 16, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(800, 30), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = ui4})
        ui.TextStroke(colors.Void, 1.5, 0.5).Parent = v101.subtitle
        local subtitle = v101.subtitle
        subtitle.TextTransparency = 1

        if const v194 = if subtitle:IsA("TextLabel") then subtitle:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v194:GetAttribute("Authored"))) ~= "number" then
                v194:SetAttribute("Authored", v194.Transparency)
            end

            transparency = 1
            v168 = v194
        else
            transparency = 1
            v168 = nil
        end

        if v168 then
            v168.Transparency = transparency
        end

        v101.prompt = ui.new("Frame", {Name = "OpenPrompt", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(190, 52), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.15, Visible = false, ZIndex = 16, ClipsDescendants = true, (ui.Corner(theme.Radius.Pill)), Parent = ui4})
        v101.promptScale = ui.GetScaleObj(v101.prompt, "AnimScale")
        v101.promptStroke = ui.Stroke(colors.Accent, 2, 0.25)
        v101.promptStroke.Parent = v101.prompt
        v101.promptFill = ui.new("Frame", {Name = "Auto", BackgroundTransparency = 0.55, ZIndex = 16, Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Accent, Parent = v101.prompt})
        v101.promptText = ui.new("TextLabel", {Text = "OPEN", TextSize = 26, ZIndex = 17, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = v101.prompt})
        local ui6 = ui.new("Frame", {Name = "Card", Visible = false, ZIndex = 12, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(232, 322), Parent = ui4})
        v101.card = ui6
        v101.cardScale = ui.new("UIScale", {Parent = ui6})
        v101.cardGlow = img("CardGlow", ui.Assets.Icons.Glow, 11, {Size = UDim2.fromOffset(487.20000000000005, 611.8), Position = UDim2.fromScale(0.5, 0.5), Parent = ui6})
        local ui7 = ui.new("Frame", {Name = "Back", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 12, (ui.Corner(18)), Parent = ui6})
        v101.backGrad = ui.new("UIGradient", {Rotation = 90, Parent = ui7})
        v101.backStroke = ui.Stroke(colors.Accent, 3, 0.1)
        v101.backStroke.Parent = ui7
        v101.backArt = img("Art", v28.CardBack, 13, {ImageTransparency = 0.15, AnchorPoint = Vector2.zero, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Stretch, Parent = ui7})
        v101.back = ui7
        local ui8 = ui.new("Frame", {Name = "Face", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), Visible = false, ZIndex = 12, (ui.Corner(18)), Parent = ui6})
        v101.faceGrad = ui.new("UIGradient", {Rotation = 90, Parent = ui8})
        v101.faceStroke = ui.Stroke(colors.Accent, 3, 0.05)
        v101.faceStroke.Parent = ui8
        v101.face = ui8
        local ui9 = ui.new("Frame", {Name = "Well", Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 206), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.45, ZIndex = 13, (ui.Corner(12)), Parent = ui8})
        v101.well = ui9
        v101.wellGlow = img("WellGlow", ui.Assets.Icons.Glow, 13, {ImageTransparency = 0.5, Size = UDim2.fromScale(1.1, 1.1), Position = UDim2.fromScale(0.5, 0.5), Parent = ui9})
        v101.icon = ui.new("Frame", {Name = "Icon", ZIndex = 14, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(196, 196), Parent = ui9})
        v101.iconScale = ui.new("UIScale", {Parent = v101.icon})
        v101.tag = ui.new("Frame", {Name = "Tag", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 6), Size = UDim2.fromOffset(74, 26), BackgroundColor3 = colors.Gold, ZIndex = 15, (ui.Corner(theme.Radius.Pill)), Parent = ui9})
        v101.tagText = ui.new("TextLabel", {Text = "NEW", TextSize = 16, ZIndex = 16, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.TextDark, Parent = v101.tag})
        v101.cat = ui.new("TextLabel", {Name = "Category", Text = "BOW", TextSize = 14, ZIndex = 16, Position = UDim2.fromOffset(10, 8), Size = UDim2.fromOffset(150, 22), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = ui9})
        v101.name = ui.new("TextLabel", {Name = "ItemName", Text = "", TextSize = 26, ZIndex = 14, Position = UDim2.fromOffset(12, 222), Size = UDim2.new(1, -24, 0, 30), FontFace = fonts.Display, TextColor3 = colors.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui8})
        ui.TextStroke(colors.Void, 1.5, 0.4).Parent = v101.name
        v101.count = ui.new("Frame", {Name = "Count", ZIndex = 14, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 258), Size = UDim2.fromOffset(160, 50), Parent = ui8})
        v101.countScale = ui.new("UIScale", {Parent = v101.count})
        v101.gem = img("Gem", v28.Gem, 15, {ImageTransparency = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(40, 40), Parent = v101.count})
        v101.countText = ui.new("TextLabel", {Name = "N", Text = "x0", TextSize = 40, ZIndex = 15, Position = UDim2.fromOffset(54, 0), Size = UDim2.new(1, -54, 1, 0), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = v101.count})
        ui.TextStroke(colors.Void, 2, 0.35).Parent = v101.countText
        v101.sheen = ui.new("Frame", {Name = "Sheen", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 17, (ui.Corner(18)), Parent = ui6})
        v101.sheenGrad = ui.new("UIGradient", {Rotation = 25, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.42, 1), NumberSequenceKeypoint.new(0.5, 0.35), NumberSequenceKeypoint.new(0.58, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-1, 0), Parent = v101.sheen})
        v101.stamp = ui.new("Frame", {Name = "Stamp", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 158), Size = UDim2.fromOffset(250, 52), BackgroundColor3 = colors.Success, Rotation = -8, Visible = false, ZIndex = 18, (ui.Corner(12)), Parent = ui6})
        ui.Gradient(theme.Lighten(colors.Success, 0.12), colors.SuccessDark, 90).Parent = v101.stamp
        ui.Stroke(color3FromRGB(200, 255, 214), 3, 0.15).Parent = v101.stamp
        v101.stampScale = ui.new("UIScale", {Parent = v101.stamp})
        ui.Icon("chevUp", 26, colors.Text, {ZIndex = 19, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, -1), Parent = v101.stamp})
        ui.new("TextLabel", {Text = "UPGRADE READY", TextSize = 25, ZIndex = 19, Position = UDim2.fromOffset(40, 0), Size = UDim2.new(1, -46, 1, 0), FontFace = fonts.Display, Parent = v101.stamp})
        local ui10 = ui.new("Frame", {Name = "Bar", Visible = false, ZIndex = 12, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(330, 62), Parent = ui4})
        v101.barBox = ui10
        v101.barCaption = ui.new("TextLabel", {Name = "Caption", Text = "", RichText = true, TextSize = 17, ZIndex = 12, Size = UDim2.new(1, 0, 0, 22), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = ui10})
        ui.TextStroke(colors.Void, 1.5, 0.45).Parent = v101.barCaption
        local ui11 = ui.new("Frame", {Name = "Track", Position = UDim2.fromOffset(0, 28), Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.2, ClipsDescendants = true, ZIndex = 12, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Stroke, 1.5, 0.75)), Parent = ui10})
        v101.track = ui11
        v101.barFill = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 13, (ui.Corner(theme.Radius.Pill)), Parent = ui11})
        v101.barGrad = ui.new("UIGradient", {Rotation = 90, Parent = v101.barFill})
        v101.barText = ui.new("TextLabel", {Name = "N", Text = "", TextSize = 20, ZIndex = 15, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = ui11})
        ui.TextStroke(colors.Void, 2, 0.3).Parent = v101.barText
        v101.barHead = img("Head", v28.Sparkle, 14, {Position = UDim2.fromOffset(0, 43), Size = UDim2.fromOffset(54, 54), Parent = ui10})
        v101.barFlash = ui.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Gold, BackgroundTransparency = 1, ZIndex = 14, (ui.Corner(theme.Radius.Pill)), Parent = ui11})
        local ui12 = ui.new("Frame", {Name = "NewItem", Visible = false, ZIndex = 13, Size = UDim2.fromOffset(0, 0), Parent = ui4})
        v101.newRoot = ui12
        v101.newDim = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 20, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(6000, 4000), BackgroundColor3 = colors.Void, Parent = ui12})
        v101.newRaysA = img("RaysA", v28.Rays, 21, {Size = UDim2.fromOffset(1300, 1300), Position = UDim2.fromOffset(0, -40), Parent = ui12})
        v101.newRaysB = img("RaysB", v28.RaysThin, 21, {Size = UDim2.fromOffset(1500, 1500), Position = UDim2.fromOffset(0, -40), Parent = ui12})
        v101.newGlow = img("Glow", ui.Assets.Icons.Glow, 22, {Size = UDim2.fromOffset(760, 760), Position = UDim2.fromOffset(0, -40), Parent = ui12})
        v101.newRing = img("Ring", v28.GlowRing, 22, {Size = UDim2.fromOffset(200, 200), Position = UDim2.fromOffset(0, -40), Parent = ui12})
        v101.newFlare = img("Flare", v28.Flare, 25, {Size = UDim2.fromOffset(1400, 140), Position = UDim2.fromOffset(0, -270), Parent = ui12})
        v101.newItem = ui.new("Frame", {Name = "Item", ZIndex = 23, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, -40), Size = UDim2.fromOffset(400, 400), Parent = ui12})
        v101.newItemScale = ui.new("UIScale", {Parent = v101.newItem})

        local function newText(name: string, textSize: number, zIndex: number, a206)
            --[[
              name: newText
              line: 767
              upvalues:
                ui (copy, index: 1)
                fontFace (copy, index: 2)
                colors (copy, index: 3)
                ui12 (copy, index: 4)
            ]]
            local v207
            local newUi = ui.new
            local v209 = {Text = "", TextTransparency = 1, Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1400, textSize * 1.25)}

            if a206 then
                v207 = a206
            else
                v207 = fontFace
            end

            v209.FontFace = v207
            v209.TextSize = textSize
            v209.TextColor3 = colors.Text
            v209.ZIndex = zIndex
            v209.Parent = ui12

            return newUi("TextLabel", v209)
        end

        v101.newAura = newText("Aura", 104, 24)
        v101.newAuraScale = ui.new("UIScale", {Parent = v101.newAura})
        v101.newShadow = newText("Shadow", 104, 24)
        v101.newShadow.TextColor3 = colors.Void
        v101.newShadowScale = ui.new("UIScale", {Parent = v101.newShadow})
        v101.newHead = newText("Headline", 104, 26)
        v101.newHeadScale = ui.new("UIScale", {Parent = v101.newHead})
        v101.newHeadGrad = ui.new("UIGradient", {Rotation = 90, Parent = v101.newHead})
        v101.newName = newText("ItemName", 50, 26, fonts.Display)
        ui.TextStroke(colors.Void, 2, 0.35).Parent = v101.newName
        v101.newSub = newText("Sub", 20, 26, fonts.Heavy)
        v101.newSub.TextColor3 = colors.TextDim
        ui.TextStroke(colors.Void, 1.5, 0.45).Parent = v101.newSub
        local newName = v101.newName
        newName.TextTransparency = 1

        if const v211 = if newName:IsA("TextLabel") then newName:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v211:GetAttribute("Authored"))) ~= "number" then
                v211:SetAttribute("Authored", v211.Transparency)
            end

            transparency2 = 1
            v170 = v211
        else
            transparency2 = 1
            v170 = nil
        end

        if v170 then
            v170.Transparency = transparency2
        end

        local newSub = v101.newSub
        newSub.TextTransparency = 1

        if const v213 = if newSub:IsA("TextLabel") then newSub:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v213:GetAttribute("Authored"))) ~= "number" then
                v213:SetAttribute("Authored", v213.Transparency)
            end

            transparency3 = 1
            v172 = v213
        else
            transparency3 = 1
            v172 = nil
        end

        if v172 then
            v172.Transparency = transparency3
        end

        local ui13 = ui.new("Frame", {Name = "Summary", Visible = false, ZIndex = 12, Size = UDim2.fromOffset(0, 0), Parent = ui4})
        v101.sumRoot = ui13
        v101.sumRow = ui.new("Frame", {Name = "Row", ZIndex = 12, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, -40), Size = UDim2.fromOffset(0, 0), Parent = ui13})
        v101.sumTotals = ui.new("TextLabel", {AutoLocalize = false, Name = "Totals", Text = "", RichText = true, TextSize = 28, ZIndex = 13, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, 150), Size = UDim2.fromOffset(900, 34), FontFace = fonts.Display, Parent = ui13})
        ui.TextStroke(colors.Void, 2, 0.35).Parent = v101.sumTotals
        local sumTotals = v101.sumTotals
        sumTotals.TextTransparency = 1

        if const v216 = if sumTotals:IsA("TextLabel") then sumTotals:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v216:GetAttribute("Authored"))) ~= "number" then
                v216:SetAttribute("Authored", v216.Transparency)
            end

            transparency4 = 1
            v174 = v216
        else
            transparency4 = 1
            v174 = nil
        end

        if v174 then
            v174.Transparency = transparency4
        end

        v101.cont = ui.new("TextButton", {Name = "Continue", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, 236), Size = UDim2.fromOffset(280, 60), BackgroundColor3 = colors.Accent, ClipsDescendants = true, ZIndex = 16, (ui.Corner(theme.Radius.Pill)), Parent = ui13})
        v101.contGrad = ui.Gradient(theme.Lighten(colors.Accent, 0.12), colors.AccentDark, 90)
        v101.contGrad.Parent = v101.cont
        v101.contScale = ui.new("UIScale", {Parent = v101.cont})
        v101.contFill = ui.new("Frame", {Name = "Auto", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.8, ZIndex = 16, (ui.Corner(theme.Radius.Pill)), Parent = v101.cont})
        v101.contFillGrad = ui.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-0.5, 0), Parent = v101.contFill})
        ui.new("TextLabel", {Text = "CONTINUE", TextSize = 28, ZIndex = 17, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, Parent = v101.cont})
        v101.tiles = {}
        v101.skip = ui.new("TextButton", {Name = "Skip", AnchorPoint = Vector2.new(1, 1), Size = UDim2.fromOffset(128, 52), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.12, Text = "", Visible = false, ZIndex = 30, ClipsDescendants = true, ui.Corner(10), (ui.Stroke(colors.Text, 1, 0.8)), Parent = ui2})
        v101.skipScale = ui.new("UIScale", {Parent = v101.skip})
        v101.skipFill = ui.new("Frame", {Name = "Hold", Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Text, BackgroundTransparency = 0.82, ZIndex = 30, (ui.Corner(10)), Parent = v101.skip})
        ui.new("TextLabel", {Text = "SKIP  ›", TextSize = 22, ZIndex = 31, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = v101.skip})
        v101.safe = ui.new("ScreenGui", {Name = "TR_RevealSafe", IgnoreGuiInset = true, ResetOnSpawn = false, Parent = a17.PlayerGui})
        pcall(
            function()
                --[[
                  line: 865
                  upvalues:
                    v101 (copy, index: 1)
                ]]
                v101.safe.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
            end
        )
    end

    local function layout()
        --[[
          name: layout
          line: 871
          upvalues:
            hasRun (ref,  index: 1)
            ui (copy, index: 2)
            v101 (copy, index: 3)
        ]]
        local clampedValue
        local textSize

        if not hasRun then
            return
        end

        local v220 = ui.CanvasSize()
        local v221 = ui.TopInset()
        local scale = math.min(1, ((v220.Y - (v221 * 0.5)) - 6) / 780, (v220.X - 20) / 1200)
        v101.stageScale.Scale = scale
        v101.stage.Position = UDim2.new(0.5, 0, 0.5, (math.floor(v221 * 0.25)))
        local v223 = v220 * ui.Scale

        if not (v223.Y < 560) then
            clampedValue = math.clamp(v223.Y / 900, 0.6, 1.4)
        else
            clampedValue = math.clamp(v223.Y / 620, 0.5, 1)
        end

        local v224 = math.floor((clampedValue * 50) + 0.5) * 0.5
        local v225 = 0
        local v226 = 0

        if not ui.DebugDevice and 0 < v101.safe.AbsoluteSize.X then
            local v227 = v101.gui.AbsolutePosition + v101.gui.AbsoluteSize
            local v228 = v101.safe.AbsolutePosition + v101.safe.AbsoluteSize
            v225 = math.max(0, v227.X - v228.X)
            v226 = math.max(0, v227.Y - v228.Y)
        end

        local v229 = v225 + math.floor(math.clamp(v223.X * 0.0225, 12, 44) + 0.5) + v224
        local v230 = v226 + math.floor(math.clamp(v223.Y * 0.03, 10, 30) + 0.5) + v224
        v101.skip.Position = UDim2.new(1, -v229 / ui.Scale, 1, -v230 / ui.Scale)
        v101.skipScale.Scale = clampedValue / ui.Scale
        local compact = ui.Compact
        local subtitle = v101.subtitle

        if compact then
            textSize = 28
        else
            textSize = 22
        end

        subtitle.TextSize = textSize
        v101.barCaption.TextSize = compact and 23 or 17
        v101.barText.TextSize = compact and 25 or 20
        v101.cat.TextSize = compact and 18 or 14
        v101.tagText.TextSize = compact and 19 or 16
        v101.tag.Size = if compact then UDim2.fromOffset(92, 30) else UDim2.fromOffset(74, 26)
        v101.sumTotals.TextSize = compact and 34 or 28
        v101.newSub.TextSize = compact and 26 or 20
    end

    local function clearChest()
        --[[
          name: clearChest
          line: 911
          upvalues:
            v161 (copy, index: 1)
            v162 (ref,  index: 2)
        ]]
        for _, v235 in v161 do
            v235.part:Destroy()
        end

        table.clear(v161)
        v162 = nil
    end

    buildChest = function(model, fit)
        --[[
          name: buildChest
          line: 918
          upvalues:
            v161 (copy, index: 1)
            v162 (ref,  index: 2)
            v19 (ref,  index: 3)
            cframe (ref,  index: 4)
            cframe2 (ref,  index: 5)
            color3FromRGB (copy, index: 6)
            v101 (copy, index: 7)
        ]]
        for _, v239 in v161 do
            v239.part:Destroy()
        end

        table.clear(v161)
        v162 = nil
        local v240 = v19 and v19[model]
        v240 = v240
            or {size = {5, 3.6, 3.4}, hinge = {0, 2.2, 1.7}, parts = {{lid = false, mesh = "", tex = "", material = "Wood", size = {5, 2.2, 3.4}, scale = {1, 1, 1}, cf = {0, 1.1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1}, color = {150, 96, 52}}, {lid = true, mesh = "", tex = "", material = "Wood", size = {5.1, 1.4, 3.5}, scale = {1, 1, 1}, cf = {0, 2.9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1}, color = {172, 112, 60}}}}
        v162 = v240
        cframe = CFrame.new(v240.hinge[1] * fit, v240.hinge[2] * fit, v240.hinge[3] * fit)
        cframe2 = cframe:Inverse()

        for _, part in v240.parts do
            local mesh
            local part2 = Instance.new("Part")
            part2.Anchored = true
            part2.CanCollide = false
            part2.CanQuery = false
            part2.CanTouch = false
            part2.CastShadow = false
            part2.Size = Vector3.new(part.size[1] * fit, part.size[2] * fit, part.size[3] * fit)
            part2.Color = color3FromRGB(part.color[1], part.color[2], part.color[3])
            pcall(
                function()
                    --[[
                      line: 945
                      upvalues:
                        part2 (copy, index: 1)
                        part (copy, index: 2)
                    ]]
                    part2.Material = Enum.Material[part.material]
                end
            )
            part2.TopSurface = Enum.SurfaceType.Smooth
            part2.BottomSurface = Enum.SurfaceType.Smooth
            local cframe3 = CFrame.new(table.unpack(part.cf))
            local cf = cframe3.Rotation + cframe3.Position * fit
            local scale = Vector3.new(part.scale[1], part.scale[2], part.scale[3]) * fit

            if part.mesh == "" then
                mesh = nil
            else
                local specialMesh = Instance.new("SpecialMesh")
                specialMesh.MeshType = Enum.MeshType.FileMesh
                specialMesh.MeshId = part.mesh
                specialMesh.TextureId = part.tex
                specialMesh.Scale = scale
                specialMesh.Parent = part2
                mesh = specialMesh
            end

            part2.Parent = v101.vpf
            table.insert(v161, {part = part2, mesh = mesh, cf = cf, lid = part.lid == true, scale = scale, size = part2.Size})
        end
    end

    local function applyPose()
        --[[
          name: applyPose
          line: 968
          upvalues:
            v162 (ref,  index: 1)
            v134 (copy, index: 2)
            v161 (copy, index: 3)
            cframe (ref,  index: 4)
            cframe2 (ref,  index: 5)
        ]]
        if not v162 then
            return
        end

        local sq = v134.sq
        local v251 = (1 - sq) * v134.s
        local v252 = (1 + (sq * 0.55)) * v134.s
        local cframe3 = CFrame.new(0, v134.y, 0) * CFrame.Angles(0, 0.4188790204786391 + v134.yaw, 0) * CFrame.Angles(v134.pitch, 0, v134.roll)
        local cframe4 = CFrame.Angles(math.rad(v134.lid), 0, 0)
        local cf

        for _, v257 in v161 do
            cf = v257.cf
            local v258 = if v257.lid then cframe * cframe4 * cframe2 * cf else cf
            local position = v258.Position
            local rotation = v258.Rotation
            v257.part.CFrame = cframe3 * (CFrame.new(position.X * v252, position.Y * v251, position.Z * v252) * rotation)
            local rightVector = rotation.RightVector
            local upVector = rotation.UpVector
            local lookVector = rotation.LookVector
            local x = math.abs(rightVector.Y) * v251 + (1 - math.abs(rightVector.Y)) * v252
            local y = math.abs(upVector.Y) * v251 + (1 - math.abs(upVector.Y)) * v252
            local z = math.abs(lookVector.Y) * v251 + (1 - math.abs(lookVector.Y)) * v252

            if v257.mesh then
                v257.mesh.Scale = v257.scale * Vector3.new(x, y, z)
            else
                v257.part.Size = v257.size * Vector3.new(x, y, z)
            end
        end
    end

    local function project(a268)
        --[[
          name: project
          line: 998
          upvalues:
            v134 (copy, index: 1)
            cFrame (copy, index: 2)
            v101 (copy, index: 3)
        ]]
        local objectSpacePoint = cFrame:PointToObjectSpace((CFrame.new(0, v134.y, 0) * CFrame.Angles(0, 0.4188790204786391 + v134.yaw, 0)) * a268)
        local size = v101.chestHolder.Size
        local offset = size.X.Offset
        local offset2 = size.Y.Offset
        local v273 = math.max(-objectSpacePoint.Z, 0.1)
        local v274 = objectSpacePoint.X / (v273 * 0.24932800284318068 * (offset / offset2))
        local v275 = objectSpacePoint.Y / (v273 * 0.24932800284318068)

        return Vector2.new((v274 * offset) / 2, (-v275 * offset2) / 2)
    end

    local function chestHeight()
        --[[
          name: chestHeight
          line: 1010
          upvalues:
            v162 (ref, index: 1)
            v102 (ref, index: 2)
        ]]
        local v277 = v162
        if not v277 then
            return 4
        end

        local v278 = v277.size[2]
        local fit = v102 and v102.look.fit or 1

        return v278 * fit
    end

    local function frontZ()
        --[[
          name: frontZ
          line: 1014
          upvalues:
            v162 (ref, index: 1)
            v102 (ref, index: 2)
        ]]
        local v281

        if const v282 = v162 then
            local v283 = v282.size[3]
            local fit = v102 and v102.look.fit or 1
            v281 = v283 * fit / 2
        else
            v281 = 1.7
        end

        return -v281
    end

    local function seamPoint()
        --[[
          name: seamPoint
          line: 1019
          upvalues:
            cframe (ref, index: 1)
            v162 (ref, index: 2)
            v102 (ref, index: 3)
        ]]
        local v286
        local y = cframe.Position.Y

        if const v288 = v162 then
            local v289 = v288.size[3]
            local fit = v102 and v102.look.fit or 1
            v286 = v289 * fit / 2
        else
            v286 = 1.7
        end

        return (Vector3.new(0, y, -v286))
    end

    local function mouthPoint()
        --[[
          name: mouthPoint
          line: 1022
          upvalues:
            cframe (ref, index: 1)
        ]]
        return (Vector3.new(0, cframe.Position.Y + 0.2, 0))
    end

    local function stagePoint(a293, a294, a295)
        --[[
          name: stagePoint
          line: 1026
          upvalues:
            project (copy, index: 1)
            v101 (copy, index: 2)
        ]]
        local vector2 = project(a293)
        local position = v101.chestHolder.Position
        local v298 = a295 or v101.chestScale.Scale
        local newVector2 = Vector2.new
        local x = position.X.Offset + vector2.X * v298
        local v301 = a294 or position.Y.Offset

        return newVector2(x, v301 + (vector2.Y * v298))
    end

    local ui2 = nil
    local ui3 = nil

    local function gradeIn(a305)
        --[[
          name: gradeIn
          line: 1036
          upvalues:
            ui2 (ref,  index: 1)
            ui (copy, index: 2)
            lighting (copy, index: 3)
            ui3 (ref,  index: 4)
            tw (copy, index: 5)
        ]]
        local saturation
        ui2 = ui2 or ui.new("ColorCorrectionEffect", {Name = "TR_RevealCC", Parent = lighting})
        ui3 = ui3 or ui.new("BlurEffect", {Name = "TR_RevealBlur", Size = 0, Parent = lighting})
        local ui4 = ui2
        ui4.Brightness, ui4.Contrast, ui4.Saturation, ui4.TintColor = 0, 0, 0, Color3.new(1, 1, 1)
        local propertyTable = {Contrast = 0.1, Brightness = -0.02}

        if a305.legendary then
            saturation = 0.22
        else
            saturation = 0.14
        end

        propertyTable.Saturation = saturation
        propertyTable.TintColor = a305.light:Lerp(Color3.new(1, 1, 1), 0.85)
        tw(ui4, 0.4, propertyTable)
        ui3.Size = 0
        tw(ui3, 0.45, {Size = 14})
    end

    local function gradePulse(saturation)
        --[[
          name: gradePulse
          line: 1050
          upvalues:
            ui2 (ref,  index: 1)
            tw (copy, index: 2)
        ]]
        if ui2 then
            local ui = ui2
            ui.Saturation = saturation
            tw(ui, 0.6, {Saturation = 0.16}, Enum.EasingStyle.Quad)
        end
    end

    local function gradeOut(a313: number)
        --[[
          name: gradeOut
          line: 1057
          upvalues:
            ui2 (ref,  index: 1)
            tw (copy, index: 2)
            ui3 (ref,  index: 3)
        ]]
        if ui2 then
            tw(ui2, a313, {Contrast = 0, Saturation = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1)}, Enum.EasingStyle.Quad)
        end

        if ui3 then
            tw(ui3, a313, {Size = 0}, Enum.EasingStyle.Quad)
        end
    end

    local function gradeOff()
        --[[
          name: gradeOff
          line: 1065
          upvalues:
            ui2 (ref, index: 1)
            ui3 (ref, index: 2)
        ]]
        if ui2 then
            ui2:Destroy()
            ui2 = nil
        end

        if ui3 then
            ui3:Destroy()
            ui3 = nil
        end
    end

    local renderSteppedConnection = nil
    local random = Random.new()
    local v317 = 0
    local v318 = 0
    local v319 = 0

    local function shake(a321, a322)
        --[[
          name: shake
          line: 1080
          upvalues:
            v317 (ref, index: 1)
            v318 (ref, index: 2)
            v319 (ref, index: 3)
        ]]
        v317 = a321
        v318 = 0
        v319 = a322
    end

    local v323 = {on = false, t = 0, nextWiggle = 0.5, wiggleT = -1, interval = 0.9, build = 0}

    local function onRender(deltaTime: number)
        --[[
          name: onRender
          line: 1084
          upvalues:
            pace (ref,  index: 1)
            stepAnims (copy, index: 2)
            v102 (ref,  index: 3)
            v323 (copy, index: 4)
            a17 (copy, index: 5)
            random (copy, index: 6)
            v101 (copy, index: 7)
            cframe (ref,  index: 8)
            v162 (ref,  index: 9)
            project (copy, index: 10)
            v134 (copy, index: 11)
            applyPose (copy, index: 12)
            v317 (ref,  index: 13)
            v318 (ref,  index: 14)
            v319 (ref,  index: 15)
            v13 (copy, index: 16)
            dropReveal (copy, index: 17)
        ]]
        local v326 = deltaTime / pace
        stepAnims(v326)

        if not v102 then
            return
        end

        local look = v102.look

        if v323.on then
            local v328
            local v329
            local v330 = v323
            v330.t += v326
            v323.build = math.min(1, v323.build + (v326 / math.max(look.idle, 0.1)))
            local v331 = math.sin(v323.t * 2.4) * 0.07
            local roll = 0
            local lid = 0
            local t = v323.t

            if v323.nextWiggle <= t and v323.wiggleT < 0 then
                local v335
                v323.wiggleT = 0
                a17.Sounds.Play("Drop_Rattle", {pitch = 0.95 + (random:NextNumber() * 0.1) + (v323.build * 0.08)})
                local backPool = v101.backPool
                local v337 = look.legendary and 5 or 3
                local v338 = {mode = "point", jitter = 60, dir = -90, spread = 55, speedMin = 90, speedMax = 220, kind = "sparkle", size = 26, grav = 120, drag = 1.6, lifeMin = 0.45, lifeMax = 0.8, whiteChance = 0}
                local y = cframe.Position.Y

                if const v340 = v162 then
                    local v341 = v340.size[3]
                    local fit = v102 and v102.look.fit or 1
                    v335 = v341 * fit / 2
                else
                    v335 = 1.7
                end

                local vector2 = project((Vector3.new(0, y, -v335)))
                local position = v101.chestHolder.Position
                local scale = v101.chestScale.Scale
                v338.at = Vector2.new(position.X.Offset + (vector2.X * scale), position.Y.Offset + (vector2.Y * scale))
                v338.colors = {look.light, look.primary}
                backPool:Burst(v337, v338)
            end

            if 0 <= v323.wiggleT then
                local v346 = v323
                v346.wiggleT += v326
                local v347 = v323.wiggleT / 0.36

                if not (1 <= v347) then
                    local v348
                    local v349
                    local v350 = math.rad(look.wiggle)
                    local build = v323.build

                    if look.legendary then
                        v348 = 0.8
                    else
                        v348 = 0.2
                    end

                    local v352 = v350 * (1 + (build * v348))
                    roll = math.sin((v347 * math.pi) * 5) * (1 - v347) * v352
                    local v353 = math.sin(v347 * math.pi)

                    if look.legendary then
                        v349 = 9
                    else
                        v349 = 5
                    end

                    lid = v353 * v349
                else
                    v323.wiggleT = -1
                    v323.interval = not look.legendary and 0.9 or math.max(0.32, 0.9 - (v323.build * 0.6))
                    v323.nextWiggle = v323.t + v323.interval
                end
            end

            local v354 = not look.legendary and 0 or v323.build * 0.25
            v134.y = v331 + v354
            v134.roll = roll
            v134.yaw = roll * 0.6
            v134.lid = lid
            local y = cframe.Position.Y

            if const v356 = v162 then
                local v357 = v356.size[3]
                local fit = v102 and v102.look.fit or 1
                v328 = v357 * fit / 2
            else
                v328 = 1.7
            end

            local vector2 = project((Vector3.new(0, y, -v328)))
            v101.leak.Position = UDim2.new(0.5, vector2.X, 0.5, vector2.Y)
            v101.leakFlare.Position = v101.leak.Position
            local clampedValue = math.clamp(lid / 9, 0, 1)
            v101.leak.ImageTransparency = 1 - (clampedValue * 0.75)
            v101.leakFlare.ImageTransparency = 1 - (clampedValue * 0.6)
            local v361 = math.sin(v323.t * 4.2) * 0.5 + 0.5
            local chestGlow = v101.chestGlow
            local v363 = 0.62 - v361 * 0.14
            local build = v323.build

            if look.legendary then
                v329 = 0.2
            else
                v329 = 0.05
            end

            chestGlow.ImageTransparency = v363 - (build * v329)
            v101.promptScale.Scale = (v361 * 0.04) + 1

            if look.legendary then
                v101.raysA.ImageTransparency = 1 - (v323.build * 0.28)
                v101.raysB.ImageTransparency = 1 - (v323.build * 0.22)
            end
        end

        v101.raysA.Rotation = (v101.raysA.Rotation + (v326 * v134.raysSpin)) % 360
        v101.raysB.Rotation = (v101.raysB.Rotation - ((v326 * v134.raysSpin) * 0.6)) % 360

        if v101.newRoot.Visible then
            v101.newRaysA.Rotation = (v101.newRaysA.Rotation + ((v326 * v134.raysSpin) * 1.6)) % 360
            v101.newRaysB.Rotation = (v101.newRaysB.Rotation - (v326 * v134.raysSpin)) % 360
        end

        if v101.chestHolder.Visible then
            applyPose()
        end

        if 0 < v317 then
            v318 += v326
            local v365 = 1 - v318 / math.max(v319, 0.001)

            if not (v365 <= 0) then
                v101.shaker.Position = UDim2.fromOffset((random:NextNumber(-1, 1) * v317) * v365, (random:NextNumber(-1, 1) * v317) * v365)
            else
                v317 = 0
                v101.shaker.Position = UDim2.new()
            end
        end

        if v102.barNeed and v101.barBox.Visible then
            local barShown = math.clamp(math.floor((v101.barFill.Size.X.Scale * v102.barNeed) + 0.5), v102.barMin, v102.barMax)

            if barShown ~= v102.barShown then
                v102.barShown = barShown
                v101.barText.Text = string.format("%d / %d", barShown, v102.barNeed)
            end
        end

        if v102.fallOpts then
            v102.fallOpts.at = Vector2.new(0, v101.chestHolder.Position.Y.Offset + 40)
        end

        if v102.headOpts then
            v102.headOpts.at = Vector2.new(-165 + (v101.barFill.Size.X.Scale * 330), 171)
        end

        if v102.holdAt then
            local v367 = os.clock() - v102.holdAt
            v101.skipFill.Size = UDim2.fromScale(math.clamp(v367 / v13.hold, 0, 1), 1)

            if v13.hold <= v367 and not v102.skip and v102.phase ~= "summary" then
                v102.holdAt = nil
                v101.skipFill.Size = UDim2.fromScale(0, 1)
                dropReveal.Skip()
            end
        end
    end

    local function alive(a369)
        --[[
          name: alive
          line: 1185
          upvalues:
            v102 (ref, index: 1)
        ]]
        return v102 ~= nil and v102.token == a369
    end

    local function sleep(a371, a372, a373)
        --[[
          name: sleep
          line: 1189
          upvalues:
            pace (ref, index: 1)
            v102 (ref, index: 2)
        ]]
        local timestamp = os.clock()
        local v375 = a372 * pace

        while os.clock() - timestamp < v375 do
            local v376 = v102 ~= nil and v102.token == a371
            if v376 then
                if v102.skip then
                    return false
                end
                if v102.hurry and a373 ~= false then
                    return true
                end

                if a373 and v102.tapped then
                    v102.tapped = false
                    return true
                end

                task.wait()
                continue
            end

            return false
        end

        local v377 = v102 ~= nil and v102.token == a371

        return v377 and not v102.skip
    end

    local function paletteOf(a379)
        --[[
          name: paletteOf
          line: 1209
          upvalues:
            v101 (copy, index: 1)
            colors (copy, index: 2)
        ]]
        v101.backGrad.Color = ColorSequence.new(a379.primary:Lerp(colors.Void, 0.25), a379.deep)
        v101.backStroke.Color = a379.light
        v101.backArt.ImageColor3 = a379.light
        v101.counterStroke.Color = a379.primary
        v101.promptStroke.Color = a379.primary
        v101.promptFill.BackgroundColor3 = a379.primary
        v101.cont.BackgroundColor3 = a379.primary
        v101.contGrad.Color = ColorSequence.new(a379.primary:Lerp(Color3.new(1, 1, 1), 0.08), a379.primary:Lerp(colors.Void, 0.35))
        v101.flash.BackgroundColor3 = a379.primary
        v101.tint.ImageColor3 = a379.primary
        v101.halo.ImageColor3 = a379.primary
        v101.raysA.ImageColor3 = a379.light:Lerp(a379.primary, 0.35)
        v101.raysB.ImageColor3 = a379.primary
        v101.chestGlow.ImageColor3 = a379.primary
        v101.leak.ImageColor3 = a379.light
        v101.leakFlare.ImageColor3 = a379.light
        v101.beam.ImageColor3 = a379.light
        v101.floorRing.ImageColor3 = a379.light
        v101.titleGrad.Color = ColorSequence.new(a379.light:Lerp(Color3.new(1, 1, 1), 0.3), a379.primary)
    end

    local function titleIn(text, text2)
        --[[
          name: titleIn
          line: 1231
          upvalues:
            v101 (copy, index: 1)
            tw (copy, index: 2)
        ]]
        local transparency, v384
        local title = v101.title
        local titleShadow = v101.titleShadow
        local subtitle = v101.subtitle
        title.Visible = true
        titleShadow.Visible = true
        subtitle.Visible = true

        for _, v389 in {v101.title, v101.titleShadow} do
            v389.Text = text
            v389.TextTransparency = 1
        end

        v101.title.Position = UDim2.fromOffset(0, -335)
        v101.titleShadow.Position = UDim2.fromOffset(0, -330)
        v101.titleScale.Scale = 1.8
        v101.titleShadowScale.Scale = 1.8
        tw(v101.titleScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
        tw(v101.titleShadowScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
        tw(v101.title, 0.12, {TextTransparency = 0}, Enum.EasingStyle.Quad)
        tw(v101.titleShadow, 0.2, {TextTransparency = 0.55}, Enum.EasingStyle.Quad)
        v101.subtitle.Text = text2
        v101.subtitle.Position = UDim2.fromOffset(0, -279)
        local subtitle2 = v101.subtitle
        subtitle2.TextTransparency = 1

        if const v391 = if subtitle2:IsA("TextLabel") then subtitle2:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v391:GetAttribute("Authored"))) ~= "number" then
                v391:SetAttribute("Authored", v391.Transparency)
            end

            transparency = 1
            v384 = v391
        else
            transparency = 1
            v384 = nil
        end

        if v384 then
            v384.Transparency = transparency
        end

        tw(v101.subtitle, 0.3, {TextTransparency = 0, Position = UDim2.fromOffset(0, -289)}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0.15)
    end

    local function setCounter(a393, a394)
        --[[
          name: setCounter
          line: 1251
          upvalues:
            v101 (copy, index: 1)
            ui (copy, index: 2)
        ]]
        v101.counter.Visible = 0 < a393
        v101.counterText.Text = "x" .. a393

        if a394 then
            ui.Pop(v101.counter, 1.35)
        end
    end

    local function placeCounter()
        --[[
          name: placeCounter
          line: 1258
          upvalues:
            v101 (copy, index: 1)
        ]]
        v101.counter.Position = UDim2.fromOffset(128, 228)
    end

    local function phaseLand(token: number)
        --[[
          name: phaseLand
          line: 1264
          upvalues:
            v102 (ref,  index: 1)
            v134 (copy, index: 2)
            applyPose (copy, index: 3)
            v101 (copy, index: 4)
            tw (copy, index: 5)
            v13 (copy, index: 6)
            animate (copy, index: 7)
            a17 (copy, index: 8)
            project (copy, index: 9)
            sleep (copy, index: 10)
            v317 (ref,  index: 11)
            v318 (ref,  index: 12)
            v319 (ref,  index: 13)
            v162 (ref,  index: 14)
            colors (copy, index: 15)
            titleIn (copy, index: 16)
        ]]
        local pitch
        local v399
        local look = v102.look
        v102.phase = "land"
        v134.y = 0
        v134.yaw = -0.24434609527920614
        v134.roll = 0
        v134.pitch = 0
        v134.sq = -0.16
        v134.lid = 0
        v134.s = 1
        applyPose()
        v101.chestHolder.Visible = true
        v101.chestHolder.Position = UDim2.fromOffset(0, -800)
        v101.chestScale.Scale = 1
        tw(v101.chestHolder, v13.fall, {Position = UDim2.fromOffset(0, 20)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        animate("yaw", {{0, v13.fall + 0.25, "outQuad"}})
        a17.Sounds.Play("Whoosh", {volume = 0.3, pitch = 0.75})
        v102.fallOpts = {mode = "point", jitter = 150, dir = -90, spread = 3, speedMin = 1100, speedMax = 1700, kind = "spark", size = 190, grav = 0, drag = 0, lifeMin = 0.12, lifeMax = 0.22, whiteChance = 0, base = 0.55, at = Vector2.new(0, -800), colors = {look.light}}
        local v401 = v101.backPool:Emit(40, v102.fallOpts)
        local vector2 = project(Vector3.new(0, 0, 0))
        local position = v101.chestHolder.Position
        local vector22 = Vector2.new(position.X.Offset + (vector2.X * 1), 20 + (vector2.Y * 1))
        v101.shadow.Position = UDim2.fromOffset(vector22.X, vector22.Y + 4)
        v101.shadow.Size = UDim2.fromOffset(120, 24)
        v101.shadow.ImageTransparency = 0.9
        tw(v101.shadow, v13.fall, {ImageTransparency = 0.35, Size = UDim2.fromOffset(420, 84)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local v405 = sleep(token, v13.fall, false)
        v401()

        if v102 then
            v102.fallOpts = nil
        end

        if not v405 then
            return false
        end

        local play = a17.Sounds.Play
        local v407 = {}

        if look.legendary then
            pitch = 0.9
        else
            pitch = 1
        end

        v407.pitch = pitch
        play("Drop_Land", v407)
        animate("sq", {{0.3, 0.06, "outQuad"}, {-0.12, 0.13, "inOutSine"}, {0.05, 0.12, "inOutSine"}, {0, 0.14, "outQuad"}})
        v317 = look.legendary and 16 or 11
        v318 = 0
        v319 = 0.32
        local vector23 = project(Vector3.new(0, 0.10000000149011612, 0))
        local position2 = v101.chestHolder.Position
        local scale = v101.chestScale.Scale
        local vector24 = Vector2.new(position2.X.Offset + (vector23.X * scale), position2.Y.Offset + (vector23.Y * scale))

        if const v412 = v162 then
            local v413 = v412.size[3]
            local fit = v102 and v102.look.fit or 1
            v399 = v413 * fit / 2
        else
            v399 = 1.7
        end

        local vector25 = project((Vector3.new(0, 0, -v399)))
        local position3 = v101.chestHolder.Position
        local scale2 = v101.chestScale.Scale
        local vector26 = Vector2.new(position3.X.Offset + (vector25.X * scale2), position3.Y.Offset + (vector25.Y * scale2))

        for _, v420 in {180, 0} do
            local x, dir
            local frontPool = v101.frontPool
            local v424 = look.legendary and 9 or 7
            local v425 = {mode = "point", jitter = 30, spread = 14, speedMin = 180, speedMax = 480, kind = "dust", size = 70, grav = -40, drag = 3.2, lifeMin = 0.5, lifeMax = 0.9, base = 0.6, grow = 2.6}
            local newVector2 = Vector2.new

            if v420 == 0 then
                x = 120
                dir = v420
            else
                x = -120
                dir = v420
            end

            v425.at = vector26 + newVector2(x, -6)
            v425.dir = dir
            v425.color = look.light:Lerp(colors.TextDim, 0.55)
            frontPool:Burst(v424, v425)
        end

        local frontPool = v101.frontPool
        local v428 = look.legendary and 16 or 9
        frontPool:Burst(v428, {mode = "point", jitter = 120, dir = -90, spread = 70, speedMin = 260, speedMax = 620, kind = "sparkle", size = 24, grav = 900, drag = 1.2, lifeMin = 0.4, lifeMax = 0.75, whiteChance = 0, at = vector24 + Vector2.new(0, -20), colors = {look.light, look.primary}})
        v101.floorRing.Position = UDim2.fromOffset(vector24.X, vector24.Y + 4)
        v101.floorRing.Size = UDim2.fromOffset(160, 40)
        v101.floorRing.ImageTransparency = 0.2
        tw(v101.floorRing, 0.55, {ImageTransparency = 1, Size = UDim2.fromOffset(900, 210)}, Enum.EasingStyle.Quart)
        v101.halo.ImageTransparency = 1
        v101.raysHolder.Position = UDim2.fromOffset(0, 0)
        tw(v101.halo, 0.5, {ImageTransparency = 0.55}, Enum.EasingStyle.Quad)
        titleIn(look.title, v102.subtitle)

        return (sleep(token, v13.settle, false))
    end

    local function phaseIdle(token: number)
        --[[
          name: phaseIdle
          line: 1314
          upvalues:
            v102 (ref,  index: 1)
            v323 (copy, index: 2)
            v101 (copy, index: 3)
            tw (copy, index: 4)
            v162 (ref,  index: 5)
            project (copy, index: 6)
            a17 (copy, index: 7)
            v134 (copy, index: 8)
            sleep (copy, index: 9)
            pace (ref,  index: 10)
        ]]
        local v431
        local look = v102.look
        v102.phase = "idle"
        v323.on = true
        v323.t = 0
        v323.nextWiggle = 0.18
        v323.wiggleT = -1
        v323.build = 0
        v101.prompt.Visible = true
        v101.prompt.Position = UDim2.fromOffset(0, 332)
        v101.promptFill.Size = UDim2.fromScale(0, 1)
        local autoOpen = v102.opts.autoOpen == true
        local v434 = not autoOpen and 86400 or look.idle

        if autoOpen then
            tw(v101.promptFill, v434, {Size = UDim2.fromScale(1, 1)}, Enum.EasingStyle.Linear)
        end

        local v435 = v102
        local backPool = v101.backPool
        local sparkle = look.sparkle
        local v438 = {mode = "point", jitter = 170, dir = -90, spread = 15, speedMin = 26, speedMax = 70, grav = -30, drag = 0.2, kind = "sparkle", size = 24, lifeMin = 0.9, lifeMax = 1.6, whiteChance = 0}

        if const v439 = v162 then
            local v440 = v439.size[2]
            local fit = v102 and v102.look.fit or 1
            v431 = v440 * fit
        else
            v431 = 4
        end

        local vector3 = Vector3.new(0, v431 * 0.5, 0)
        local vector2 = project(vector3)
        local position = v101.chestHolder.Position
        local scale = v101.chestScale.Scale
        v438.at = Vector2.new(position.X.Offset + (vector2.X * scale), position.Y.Offset + (vector2.Y * scale))
        v438.colors = {look.light, look.primary}
        v435.stopSparkles = backPool:Emit(sparkle, v438)

        if look.legendary then
            a17.Sounds.Play("Drop_BuildUp")
            v101.raysHolder.Position = UDim2.fromOffset(0, 0)
            v101.raysScale.Scale = 0.75
            tw(v101.raysScale, look.idle, {Scale = 0.95}, Enum.EasingStyle.Quad)
            v134.raysSpin = 14
            tw(v101.vignette, look.idle, {ImageTransparency = 0.25, ImageColor3 = look.deep}, Enum.EasingStyle.Quad)
        end

        if v102.tapped then
            v102.tapped = false

            if sleep(token, 0.15, false) == false then
                return false
            end
        elseif not sleep(token, v434, true) then
            return false
        end

        v323.on = false
        v134.roll = 0
        v134.yaw = 0
        v134.lid = 0
        v101.leak.ImageTransparency = 1
        v101.leakFlare.ImageTransparency = 1
        tw(v101.prompt, 0.15, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)

        task.delay(
            pace * 0.16,
            function()
                --[[
                  line: 1353
                  upvalues:
                    v101 (copy, index: 1)
                ]]
                if v101.prompt then
                    v101.prompt.Visible = false
                    v101.prompt.BackgroundTransparency = 0.15
                end
            end
        )

        return true
    end

    local function phaseOpen(token: number)
        --[[
          name: phaseOpen
          line: 1362
          upvalues:
            v102 (ref,  index: 1)
            animate (copy, index: 2)
            v13 (copy, index: 3)
            sleep (copy, index: 4)
            a17 (copy, index: 5)
            v317 (ref,  index: 6)
            v318 (ref,  index: 7)
            v319 (ref,  index: 8)
            ui2 (ref,  index: 9)
            tw (copy, index: 10)
            v101 (copy, index: 11)
            cframe (ref,  index: 12)
            project (copy, index: 13)
            v134 (copy, index: 14)
            colors (copy, index: 15)
        ]]
        local scale2
        local scale3
        local raysSpin
        local look = v102.look
        v102.phase = "open"
        animate("sq", {{0.2, v13.openCrouch, "outQuad"}})

        if not sleep(token, v13.openCrouch, false) then
            return false
        end

        animate("sq", {{-0.14, 0.1, "outQuad"}, {0.06, 0.14, "inOutSine"}, {0, 0.2, "outQuad"}})
        animate("y", {{0.45, 0.12, "outQuad"}, {0, 0.26, "inQuad"}})
        local v452 = look.model ~= "Drop" and 118 or 140
        animate("lid", {{v452, 0.34, "outBack"}})
        animate("s", {{1.06, 0.1, "outQuad"}, {1, 0.3, "outQuad"}})
        a17.Sounds.Play("Drop_Open")

        if look.legendary then
            a17.Sounds.Play("Drop_Open_Golden")
        end

        v317 = look.legendary and 20 or 13
        v318 = 0
        v319 = 0.4
        local saturation = look.legendary and 0.45 or 0.32

        if ui2 then
            local ui = ui2
            ui.Saturation = saturation
            tw(ui, 0.6, {Saturation = 0.16}, Enum.EasingStyle.Quad)
        end

        v101.flash.BackgroundTransparency = look.legendary and 0.55 or 0.64
        tw(v101.flash, 0.45, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
        tw(v101.dim, 0.3, {BackgroundTransparency = 0.12}, Enum.EasingStyle.Quad)
        v101.tint.ImageTransparency = 0.45
        tw(v101.tint, 1.2, {ImageTransparency = 0.72}, Enum.EasingStyle.Quad)
        local vector2 = project((Vector3.new(0, cframe.Position.Y + 0.2, 0)))
        local position = v101.chestHolder.Position
        local scale = v101.chestScale.Scale
        local at = Vector2.new(position.X.Offset + (vector2.X * scale), position.Y.Offset + (vector2.Y * scale))
        v101.raysHolder.Position = UDim2.fromOffset(at.X, at.Y)
        local raysScale = v101.raysScale

        if look.legendary then
            scale2 = 0.8
        else
            scale2 = 0.25
        end

        raysScale.Scale = scale2
        local raysScale2 = v101.raysScale
        local propertyTable = {}

        if look.legendary then
            scale3 = 1.15
        else
            scale3 = 1
        end

        propertyTable.Scale = scale3
        tw(raysScale2, 0.55, propertyTable, Enum.EasingStyle.Back)
        v101.raysA.ImageTransparency = look.legendary and 0.3 or 0.5
        v101.raysB.ImageTransparency = look.legendary and 0.4 or 0.6
        tw(v101.raysA, 1.1, {ImageTransparency = look.rays}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)
        tw(v101.raysB, 1.1, {ImageTransparency = math.min(0.92, look.rays + 0.12)}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)

        if look.legendary then
            raysSpin = 60
        else
            raysSpin = 40
        end

        v134.raysSpin = raysSpin
        local v462 = look.legendary and 12 or 8
        animate("raysSpin", {{v462, 1.4, "outQuad"}})
        v101.halo.ImageTransparency = 0.2
        v101.halo.Size = UDim2.fromOffset(380, 380)
        tw(v101.halo, 0.8, {ImageTransparency = 0.5, Size = UDim2.fromOffset(720, 720)}, Enum.EasingStyle.Quart)
        v101.beam.Position = UDim2.fromOffset(at.X, at.Y + 30)
        v101.beam.Size = UDim2.fromOffset(120, 300)
        v101.beam.ImageTransparency = 0.25
        tw(v101.beam, 0.25, {Size = UDim2.fromOffset(260, 760)}, Enum.EasingStyle.Quart)
        tw(v101.beam, 0.9, {ImageTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0.15)
        v101.floorRing.Position = UDim2.fromOffset(at.X, at.Y)
        v101.floorRing.Size = UDim2.fromOffset(160, 160)
        v101.floorRing.ImageTransparency = 0.15
        tw(v101.floorRing, 0.6, {ImageTransparency = 1, Size = UDim2.fromOffset(1500, 1500)}, Enum.EasingStyle.Quart)
        v101.frontPool:Burst(look.burst, {mode = "point", jitter = 50, dir = -90, spread = 62, speedMin = 700, speedMax = 1500, sparkChance = 0.7, sparkLen = 170, size = 26, grav = 900, drag = 1.5, lifeMin = 0.5, lifeMax = 1, whiteChance = 0.3, at = at, colors = {look.primary, look.light}, white = look.light})
        v101.frontPool:Burst(math.floor(look.burst * 0.6), {mode = "point", jitter = 70, dir = -90, spread = 80, speedMin = 250, speedMax = 700, kind = "sparkle", size = 32, grav = 500, drag = 1.4, lifeMin = 0.7, lifeMax = 1.3, whiteChance = 0, at = at, colors = {look.light, look.primary}})

        if look.legendary then
            v101.frontPool:Burst(24, {mode = "point", jitter = 40, speedMin = 500, speedMax = 1100, kind = "shard", size = 26, grav = 700, drag = 1.2, lifeMin = 0.6, lifeMax = 1.2, whiteChance = 0, at = at, colors = {colors.Gold, look.light}})
        end

        v101.chestGlow.ImageTransparency = 0.25
        tw(v101.chestGlow, 0.9, {ImageTransparency = 0.55}, Enum.EasingStyle.Quad)

        if v102.stopSparkles then
            v102.stopSparkles()
            v102.stopSparkles = nil
        end

        if not sleep(token, v13.openHold, false) then
            return false
        end

        return true
    end

    local function chestToCards()
        --[[
          name: chestToCards
          line: 1428
          upvalues:
            tw (copy, index: 1)
            v101 (copy, index: 2)
            v13 (copy, index: 3)
            project (copy, index: 4)
        ]]
        tw(v101.chestHolder, v13.toCards, {Position = UDim2.fromOffset(0, 290)})
        tw(v101.chestScale, v13.toCards, {Scale = 0.46})
        local vector2 = project(Vector3.new(0, 0, 0))
        local position = v101.chestHolder.Position
        local vector22 = Vector2.new(position.X.Offset + (vector2.X * 0.46), 290 + (vector2.Y * 0.46))
        tw(v101.shadow, v13.toCards, {Position = UDim2.fromOffset(vector22.X, vector22.Y + 3), Size = UDim2.fromOffset(250, 50)})
        tw(v101.raysHolder, v13.toCards + 0.1, {Position = UDim2.fromOffset(0, -64)})
        tw(v101.halo, v13.toCards, {ImageTransparency = 0.6}, Enum.EasingStyle.Quad)
    end

    local function paintBar(stack, a469, barNeed, a471, startValue, a473)
        --[[
          name: paintBar
          line: 1437
          upvalues:
            v101 (copy, index: 1)
            v102 (ref,  index: 2)
            colors (copy, index: 3)
            a17 (copy, index: 4)
            weaponInfo (copy, index: 5)
        ]]
        if barNeed then
            v101.barText.Text = string.format("%d / %d", a469, barNeed)
        else
            v101.barText.Text = "MAX"
        end

        if v102 then
            v102.barNeed = barNeed
            v102.barMin = a469
            v102.barMax = math.max(a469, (a473 or a469))
            v102.barShown = a469
        end

        v101.barGrad.Color = ColorSequence.new(startValue:Lerp(Color3.new(1, 1, 1), 0.18), startValue:Lerp(colors.Void, 0.18))

        if a471 <= 0 then
            a17.Loc.Rich(v101.barCaption, string.format("<font color=\"#%s\">UNLOCK</font>  %s", colors.Gold:ToHex(), string.upper(weaponInfo.Name(stack.item))))
            return
        end

        if barNeed then
            a17.Loc.Rich(v101.barCaption, string.format("LEVEL %d  <font color=\"#%s\">›</font>  %d", a471, startValue:Lerp(Color3.new(1, 1, 1), 0.3):ToHex(), a471 + 1))
            return
        end

        a17.Loc.Rich(v101.barCaption, string.format("LEVEL %d  ·  MAX", a471))
    end

    local function setBar(a475, a476: boolean, a477: nil)
        --[[
          name: setBar
          line: 1458
          upvalues:
            v101 (copy, index: 1)
            tw (copy, index: 2)
            v13 (copy, index: 3)
        ]]
        local clampedValue = math.clamp(a475, 0, 1)

        if a476 then
            v101.barFill.Size = UDim2.fromScale(clampedValue, 1)
            v101.barHead.Position = UDim2.fromOffset(clampedValue * 330, 43)

            return
        end

        tw(v101.barFill, (a477 or v13.bar), {Size = UDim2.fromScale(clampedValue, 1)}, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        tw(v101.barHead, (a477 or v13.bar), {Position = UDim2.fromOffset(clampedValue * 330, 43)}, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    end

    local function paintFace(stack)
        --[[
          name: paintFace
          line: 1470
          upvalues:
            catColor (copy, index: 1)
            v101 (copy, index: 2)
            colors (copy, index: 3)
            weaponInfo (copy, index: 4)
        ]]
        local text
        local startValue = catColor(stack.item)
        v101.faceGrad.Color = ColorSequence.new(startValue:Lerp(Color3.new(1, 1, 1), 0.1), startValue:Lerp(colors.Void, 0.55))
        v101.faceStroke.Color = startValue:Lerp(Color3.new(1, 1, 1), 0.45)
        v101.wellGlow.ImageColor3 = startValue
        local cat = v101.cat

        if stack.bonus then
            local item = stack.item
            local v485 = weaponInfo.Get(item)
            local v486 = v485 and weaponInfo.CATEGORY_SINGULAR and weaponInfo.CATEGORY_SINGULAR[v485.category]
                or "ITEM"
            text = v486 .. "  ·  MVP BONUS"
        else
            local item = stack.item
            local v488 = weaponInfo.Get(item)
            text = v488 and weaponInfo.CATEGORY_SINGULAR and weaponInfo.CATEGORY_SINGULAR[v488.category]
                or "ITEM"
        end

        cat.Text = text
        v101.name.Text = string.upper(weaponInfo.Name(stack.item))
        v101.countText.Text = "x0"
        v101.gem.ImageColor3 = startValue:Lerp(Color3.new(1, 1, 1), 0.25)
        v101.cardGlow.ImageColor3 = startValue

        if not (stack.levelBefore <= 0) then
            v101.tag.Visible = true
            v101.tag.BackgroundColor3 = colors.Raised
            v101.tagText.Text = "LV " .. stack.levelBefore
            v101.tagText.TextColor3 = colors.Text
        else
            v101.tag.Visible = true
            v101.tag.BackgroundColor3 = colors.Raised
            v101.tagText.Text = "LOCKED"
            v101.tagText.TextColor3 = colors.TextDim
        end

        v101.stamp.Visible = false
    end

    local function phaseNewItem(token: number, stack)
        --[[
          name: phaseNewItem
          line: 1496
          upvalues:
            v102 (ref,  index: 1)
            catColor (copy, index: 2)
            v101 (copy, index: 3)
            tw (copy, index: 4)
            v134 (copy, index: 5)
            animate (copy, index: 6)
            ui2 (ref,  index: 7)
            weaponIcon (copy, index: 8)
            colors (copy, index: 9)
            weaponInfo (copy, index: 10)
            a17 (copy, index: 11)
            pace (ref,  index: 12)
            sleep (copy, index: 13)
            v317 (ref,  index: 14)
            v318 (ref,  index: 15)
            v319 (ref,  index: 16)
            v13 (copy, index: 17)
        ]]
        local transparency, v493
        local transparency2, v495
        v102.phase = "newitem"
        local startValue = catColor(stack.item)
        local interpolatedValue = startValue:Lerp(Color3.new(1, 1, 1), 0.4)
        v101.newRoot.Visible = true
        v101.newRoot.Position = UDim2.fromOffset(0, 0)
        local card = v101.card
        local barBox = v101.barBox
        local counter = v101.counter
        card.Visible = false
        barBox.Visible = false
        counter.Visible = false
        v101.newDim.BackgroundTransparency = 1
        tw(v101.newDim, 0.25, {BackgroundTransparency = 0.18}, Enum.EasingStyle.Quad)
        v101.newRaysA.ImageColor3 = interpolatedValue
        v101.newRaysB.ImageColor3 = startValue
        local newRaysA = v101.newRaysA
        local newRaysB = v101.newRaysB
        newRaysA.ImageTransparency = 0.25
        newRaysB.ImageTransparency = 0.35
        v101.newRaysA.Size = UDim2.fromOffset(300, 300)
        v101.newRaysB.Size = UDim2.fromOffset(300, 300)
        tw(v101.newRaysA, 0.6, {ImageTransparency = 0.5, Size = UDim2.fromOffset(1300, 1300)}, Enum.EasingStyle.Back)
        tw(v101.newRaysB, 0.7, {ImageTransparency = 0.62, Size = UDim2.fromOffset(1500, 1500)}, Enum.EasingStyle.Back)
        v134.raysSpin = 70
        animate("raysSpin", {{10, 1.6, "outQuad"}})
        v101.newGlow.ImageColor3 = startValue
        v101.newGlow.ImageTransparency = 0.4
        v101.newGlow.Size = UDim2.fromOffset(300, 300)
        tw(v101.newGlow, 0.7, {ImageTransparency = 0.55, Size = UDim2.fromOffset(820, 820)}, Enum.EasingStyle.Quart)
        v101.newRing.ImageColor3 = startValue
        v101.newRing.Size = UDim2.fromOffset(200, 200)
        v101.newRing.ImageTransparency = 0.3
        tw(v101.newRing, 0.7, {ImageTransparency = 1, Size = UDim2.fromOffset(1700, 1700)}, Enum.EasingStyle.Quart)
        v101.flash.BackgroundColor3 = startValue
        v101.flash.BackgroundTransparency = 0.7
        tw(v101.flash, 0.5, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)

        if ui2 then
            local ui = ui2
            ui.Saturation = 0.5
            tw(ui, 0.6, {Saturation = 0.16}, Enum.EasingStyle.Quad)
        end

        weaponIcon.Set(v101.newItem, stack.item, {spin = true, outline = true, glow = false, outlineScale = 1.04, outlineTransparency = 0.4, outlineColor = interpolatedValue})
        v101.newItemScale.Scale = 0.2
        tw(v101.newItemScale, 0.55, {Scale = 1}, Enum.EasingStyle.Back)

        for _, v505 in {v101.newHead, v101.newShadow, v101.newAura} do
            v505.Text = "NEW ITEM!"
            v505.TextTransparency = 1
            v505.Position = UDim2.fromOffset(0, -300)
        end

        v101.newShadow.Position = UDim2.fromOffset(0, -293)
        v101.newHeadGrad.Color = ColorSequence.new(colors.Text, interpolatedValue)
        v101.newAura.TextColor3 = interpolatedValue
        v101.newHeadScale.Scale = 2.2
        v101.newShadowScale.Scale = 2.2
        tw(v101.newHeadScale, 0.26, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.08)
        tw(v101.newShadowScale, 0.26, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.08)
        tw(v101.newHead, 0.1, {TextTransparency = 0}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.08)
        tw(v101.newShadow, 0.2, {TextTransparency = 0.5}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.08)
        v101.newName.Text = string.upper(weaponInfo.Name(stack.item))
        v101.newName.Position = UDim2.fromOffset(0, 230)
        local newName = v101.newName
        newName.TextTransparency = 1

        if const v507 = if newName:IsA("TextLabel") then newName:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v507:GetAttribute("Authored"))) ~= "number" then
                v507:SetAttribute("Authored", v507.Transparency)
            end

            transparency = 1
            v493 = v507
        else
            transparency = 1
            v493 = nil
        end

        if v493 then
            v493.Transparency = transparency
        end

        tw(v101.newName, 0.35, {TextTransparency = 0, Position = UDim2.fromOffset(0, 210)}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0.3)
        local newSub = v101.newSub
        local stringFormat = string.format
        local item = stack.item
        local v511 = weaponInfo.Get(item)
        local v512 = v511 and weaponInfo.CATEGORY_SINGULAR and weaponInfo.CATEGORY_SINGULAR[v511.category]
            or "ITEM"
        newSub.Text = stringFormat("%s  ·  UNLOCKED  ·  EQUIP IT IN YOUR LOADOUT", v512)
        v101.newSub.Position = UDim2.fromOffset(0, 272)
        local newSub2 = v101.newSub
        newSub2.TextTransparency = 1

        if const v514 = if newSub2:IsA("TextLabel") then newSub2:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v514:GetAttribute("Authored"))) ~= "number" then
                v514:SetAttribute("Authored", v514.Transparency)
            end

            transparency2 = 1
            v495 = v514
        else
            transparency2 = 1
            v495 = nil
        end

        if v495 then
            v495.Transparency = transparency2
        end

        tw(v101.newSub, 0.35, {TextTransparency = 0, Position = UDim2.fromOffset(0, 256)}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0.42)
        a17.Sounds.Play("NewItem_Fanfare")

        for _, instance in {v101.title, v101.titleShadow, v101.subtitle} do
            tw(instance, 0.15, {TextTransparency = 1}, Enum.EasingStyle.Quad)
        end

        task.delay(
            pace * 0.16,
            function()
                --[[
                  line: 1560
                  upvalues:
                    token (copy, index: 1)
                    v102 (ref,  index: 2)
                    v101 (copy, index: 3)
                ]]
                local v517 = v102 ~= nil and v102.token == token

                if v517 and v102.phase == "newitem" then
                    local title = v101.title
                    local titleShadow = v101.titleShadow
                    local subtitle = v101.subtitle
                    title.Visible = false
                    titleShadow.Visible = false
                    subtitle.Visible = false
                end
            end
        )

        if not sleep(token, 0.3, false) then
            return false
        end

        v317 = 18
        v318 = 0
        v319 = 0.35
        v101.newHeadScale.Scale = 1.08
        tw(v101.newHeadScale, 0.22, {Scale = 1}, Enum.EasingStyle.Back)
        v101.newAura.TextTransparency = 0.3
        v101.newAuraScale.Scale = 1.02
        tw(v101.newAuraScale, 0.6, {Scale = 1.35}, Enum.EasingStyle.Quart)
        tw(v101.newAura, 0.6, {TextTransparency = 1}, Enum.EasingStyle.Quad)
        v101.newFlare.ImageColor3 = interpolatedValue
        v101.newFlare.ImageTransparency = 0.2
        v101.newFlare.Size = UDim2.fromOffset(300, 120)
        tw(v101.newFlare, 0.5, {ImageTransparency = 1, Size = UDim2.fromOffset(1600, 150)}, Enum.EasingStyle.Quart)
        v101.frontPool:Burst(40, {mode = "box", speed = 1300, sparkChance = 0.6, whiteChance = 0.3, box = Vector2.new(560, 90), at = Vector2.new(0, -300), colors = {startValue, interpolatedValue}, white = interpolatedValue})
        local frontPool = v101.frontPool
        local v522 = {mode = "point", jitter = 90, speedMin = 500, speedMax = 1300, sparkChance = 0.55, sparkLen = 150, size = 26, grav = 500, drag = 1.6, lifeMin = 0.6, lifeMax = 1.2, whiteChance = 0, at = Vector2.new(0, -40), colors = {startValue, interpolatedValue, colors.Gold}}
        frontPool:Burst(36, v522)
        local frontPool2 = v101.frontPool
        local v524 = {mode = "point", jitter = 160, speedMin = 60, speedMax = 260, kind = "sparkle", size = 36, grav = -60, drag = 0.8, lifeMin = 1, lifeMax = 1.8, whiteChance = 0, at = Vector2.new(0, -40), colors = {interpolatedValue, colors.Gold}}
        frontPool2:Burst(20, v524)

        if not sleep(token, 0.5, false) then
            return false
        end

        v102.tapped = false
        sleep(token, v13.newItem - 0.8, true)
        local v525 = v102 ~= nil and v102.token == token

        if not v525 or v102.skip then
            return false
        end

        tw(v101.newItemScale, 0.25, {Scale = 0}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

        for _, instance in {v101.newHead, v101.newShadow, v101.newName, v101.newSub} do
            tw(instance, 0.2, {TextTransparency = 1}, Enum.EasingStyle.Quad)
        end

        tw(v101.newRaysA, 0.3, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
        tw(v101.newRaysB, 0.3, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
        tw(v101.newGlow, 0.3, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
        tw(v101.newDim, 0.3, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
        local title = v101.title
        local titleShadow = v101.titleShadow
        local subtitle = v101.subtitle
        title.Visible = true
        titleShadow.Visible = true
        subtitle.Visible = true
        tw(v101.title, 0.25, {TextTransparency = 0}, Enum.EasingStyle.Quad)
        tw(v101.titleShadow, 0.25, {TextTransparency = 0.55}, Enum.EasingStyle.Quad)
        tw(v101.subtitle, 0.25, {TextTransparency = 0}, Enum.EasingStyle.Quad)
        sleep(token, 0.22, false)
        v101.newRoot.Visible = false
        weaponIcon.Set(v101.newItem, nil)
        local card2 = v101.card
        local barBox2 = v101.barBox
        card2.Visible = true
        barBox2.Visible = true
        local v533 = #v102.reveal.stacks - (v102.cardIndex or 0)
        local counter2 = v101.counter
        local visible = 0 < v533
        counter2.Visible = visible
        v101.counterText.Text = "x" .. v533
        v134.raysSpin = 8
        local v536 = v102 ~= nil and v102.token == token

        return v536 and not v102.skip
    end

    local function phaseCard(token: number, cardIndex, stack)
        --[[
          name: phaseCard
          line: 1615
          upvalues:
            v102 (ref,  index: 1)
            catColor (copy, index: 2)
            paintFace (copy, index: 3)
            cframe (ref,  index: 4)
            project (copy, index: 5)
            v101 (copy, index: 6)
            weaponIcon (copy, index: 7)
            a17 (copy, index: 8)
            random (copy, index: 9)
            ui (copy, index: 10)
            animate (copy, index: 11)
            tw (copy, index: 12)
            v13 (copy, index: 13)
            sleep (copy, index: 14)
            paintBar (copy, index: 15)
            v14 (copy, index: 16)
            pace (ref,  index: 17)
            setBar (copy, index: 18)
            finishGroup (copy, index: 19)
            colors (copy, index: 20)
            phaseNewItem (copy, index: 21)
            v317 (ref,  index: 22)
            v318 (ref,  index: 23)
            v319 (ref,  index: 24)
            theme (copy, index: 25)
        ]]
        local v541
        local rotation
        local v543
        local v544
        local v545
        local v546
        local look = v102.look
        v102.phase = "card"
        v102.cardIndex = cardIndex
        v102.hurry = false
        v102.tapped = false
        v102.group = {}
        local startValue = catColor(stack.item)
        paintFace(stack)
        local vector2 = project((Vector3.new(0, cframe.Position.Y + 0.2, 0)))
        local position = v101.chestHolder.Position
        local at = Vector2.new(position.X.Offset + (vector2.X * 0.46), 290 + (vector2.Y * 0.46))

        if not (4 <= #v102.reveal.stacks) then
            v541 = 1
        else
            v541 = 0.82
        end

        local card = v101.card
        card.Visible = true
        v101.back.Visible = true
        v101.face.Visible = false
        card.Size = UDim2.fromOffset(232, 322)
        card.Position = UDim2.fromOffset(at.X, at.Y)

        if cardIndex % 2 ~= 0 then
            rotation = 200
        else
            rotation = -200
        end

        card.Rotation = rotation
        v101.cardScale.Scale = 0.22799999999999998
        v101.cardGlow.ImageTransparency = 1
        v101.sheen.BackgroundTransparency = 1
        weaponIcon.Set(v101.icon, nil)
        a17.Sounds.Play("Card_Whoosh", {pitch = 0.95 + (random:NextNumber() * 0.1)})
        local v553 = #v102.reveal.stacks - cardIndex
        v101.counter.Visible = 0 < v553
        v101.counterText.Text = "x" .. v553
        ui.Pop(v101.counter, 1.35)
        animate("sq", {{0.1, 0.06, "outQuad"}, {0, 0.16, "outQuad"}})
        v101.chestGlow.ImageTransparency = 0.3
        tw(v101.chestGlow, 0.5, {ImageTransparency = 0.6}, Enum.EasingStyle.Quad)
        v101.backPool:Burst(8, {mode = "point", jitter = 30, dir = -90, spread = 40, speedMin = 250, speedMax = 600, kind = "sparkle", size = 26, grav = 700, drag = 1.3, lifeMin = 0.4, lifeMax = 0.8, whiteChance = 0, at = at, colors = {look.light, look.primary}})
        tw(card, v13.cardFly * v541, {Position = UDim2.fromOffset(0, -64)}, Enum.EasingStyle.Quint)
        tw(card, v13.cardFly * v541, {Rotation = 0}, Enum.EasingStyle.Quart)
        tw(v101.cardScale, v13.cardFly * v541, {Scale = 1.14}, Enum.EasingStyle.Back)
        v101.barBox.Visible = false

        if not sleep(token, v13.cardFly * v541, true) then
            return false
        end

        a17.Sounds.Play("Card_Flip")
        tw(card, v13.flip / 2, {Size = UDim2.fromOffset(0, 322)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        tw(v101.cardScale, v13.flip / 2, {Scale = 1.254}, Enum.EasingStyle.Quad)

        if not sleep(token, v13.flip / 2, true) then
            return false
        end

        v101.back.Visible = false
        v101.face.Visible = true
        local well = v101.well
        local name = v101.name
        local count = v101.count
        well.Visible = false
        name.Visible = false
        count.Visible = false
        tw(card, v13.flip / 2, {Size = UDim2.fromOffset(232, 322)}, Enum.EasingStyle.Quad)
        tw(v101.cardScale, 0.3, {Scale = 1.14}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, v13.flip / 2)
        v101.icon.Visible = false
        weaponIcon.Set(v101.icon, stack.item, {spin = true, outline = true, glow = false, outlineScale = 1.04, outlineTransparency = 0.45, outlineColor = startValue:Lerp(Color3.new(1, 1, 1), 0.5)})

        if not sleep(token, v13.flip / 2, true) then
            return false
        end

        local well2 = v101.well
        local name2 = v101.name
        local count2 = v101.count
        well2.Visible = true
        name2.Visible = true
        count2.Visible = true
        v101.icon.Visible = true
        v101.iconScale.Scale = 0.6
        tw(v101.iconScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
        a17.Sounds.Play("Card_Reveal", {pitch = (math.min(cardIndex - 1, 4) * 0.04) + 1})
        v101.sheen.BackgroundTransparency = 0.55
        v101.sheenGrad.Offset = Vector2.new(-1, 0)
        tw(v101.sheenGrad, 0.45, {Offset = Vector2.new(1, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        v101.cardGlow.ImageTransparency = 0.35
        tw(v101.cardGlow, 0.8, {ImageTransparency = 0.62}, Enum.EasingStyle.Quad)
        v101.frontPool:Burst(14, {mode = "point", jitter = 130, speedMin = 250, speedMax = 700, sparkChance = 0.5, sparkLen = 110, size = 20, grav = 400, drag = 2, lifeMin = 0.4, lifeMax = 0.8, whiteChance = 0, at = Vector2.new(0, -64), colors = {startValue, startValue:Lerp(Color3.new(1, 1, 1), 0.4)}})
        local levelBefore = stack.levelBefore
        local need = stack.need
        local before = stack.before
        local total = stack.total
        v543 = if const need2 = need then need2 else stack.total
        paintBar(stack, before, need, levelBefore, startValue, (math.min(total, v543)))

        if need then
            v544 = stack.before / need
            v544 = ui
        else
            v544 = 1
            v544 = ui
        end

        local clampedValue = math.clamp(v544, 0, 1)
        v101.barFill.Size = UDim2.fromScale(clampedValue, 1)
        v101.barHead.Position = UDim2.fromOffset(clampedValue * v14.barW, 43)
        v101.barBox.Visible = true
        v101.barBox.Position = UDim2.fromOffset(0, 128)
        v544.FadeIn(v101.barBox, TweenInfo.new(pace * 0.18))
        local shards = stack.shards

        task.spawn(
            function()
                --[[
                  line: 1693
                  upvalues:
                    shards (copy, index: 1)
                    v13 (copy, index: 2)
                    token (copy, index: 3)
                    v102 (ref,  index: 4)
                    v101 (copy, index: 5)
                    a17 (copy, index: 6)
                    pace (ref,  index: 7)
                    tw (copy, index: 8)
                ]]
                local v567 = math.min(shards, 12)
                local v568 = v13.count / math.max(v567, 1)

                for index = 1, v567 do
                    local v570 = v102 ~= nil and v102.token == token
                    if not v570 then
                        break
                    end
                    if v102.hurry then
                        break
                    end
                    if v102.skip then
                        break
                    end

                    v101.countText.Text = "x" .. math.floor(((shards * index) / v567) + 0.5)
                    a17.Sounds.Play("Tick", {volume = 0.8, pitch = (index * 0.045) + 1})
                    task.wait(v568 * pace)
                end

                local v571 = v102 ~= nil and v102.token == token
                if v571 then
                    v101.countText.Text = "x" .. shards
                    v101.countScale.Scale = 1.35
                    tw(v101.countScale, 0.25, {Scale = 1}, Enum.EasingStyle.Back)
                end
            end
        )

        a17.Sounds.Play("XP_Tick", {volume = 0.9})

        if need then
            v545 = math.min(1, stack.total / need)
        else
            v545 = 1
        end

        v101.barHead.ImageColor3 = startValue:Lerp(Color3.new(1, 1, 1), 0.45)
        v101.barHead.ImageTransparency = 0.05
        setBar(v545, false)
        tw(v101.barHead, v13.bar + 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0.1)
        local v572 = v102
        local headOpts = {mode = "point", jitter = 6, dir = -90, spread = 70, speedMin = 60, speedMax = 200, kind = "sparkle", size = 16, grav = 300, drag = 1, lifeMin = 0.3, lifeMax = 0.6, whiteChance = 0}
        local newVector2 = Vector2.new

        if need then
            v546 = stack.before / need
            v546 = sleep
        else
            v546 = 0
            v546 = sleep
        end

        headOpts.at = newVector2(-165 + (330 * v546), 171)
        headOpts.colors = {startValue:Lerp(Color3.new(1, 1, 1), 0.4)}
        v572.headOpts = headOpts
        local v575 = v101.frontPool:Emit(34, v102.headOpts)
        local v576 = v546(token, math.max(v13.bar, v13.count) * v541, true)
        v575()

        if v102 then
            v102.headOpts = nil
        end

        if not v576 then
            return false
        end

        v101.countText.Text = "x" .. shards
        finishGroup()
        v102.group = nil
        v102.hurry = false
        v102.tapped = false

        if stack.unlocked then
            local v577
            v101.barFlash.BackgroundColor3 = colors.Gold
            v101.barFlash.BackgroundTransparency = 0.2
            tw(v101.barFlash, 0.4, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)

            if not sleep(token, 0.18, false) then
                return false
            end
            if not phaseNewItem(token, stack) then
                return false
            end

            v102.phase = "card"
            v101.tag.BackgroundColor3 = colors.Gold
            v101.tagText.Text = "NEW"
            v101.tagText.TextColor3 = colors.TextDark
            ui.Pop(v101.tag, 1.6)
            paintBar(stack, stack.surplus, stack.needAfter, 1, startValue, stack.surplus)

            if stack.needAfter then
                v577, v577 = stack.surplus / stack.needAfter, v14
            else
                v577, v577 = 1, v14
            end

            local clampedValue2 = math.clamp(v577, 0, 1)
            v101.barFill.Size = UDim2.fromScale(clampedValue2, 1)
            v101.barHead.Position = UDim2.fromOffset(clampedValue2 * v577.barW, 43)
        end

        if stack.ready then
            v101.stamp.Visible = true
            v101.stampScale.Scale = 2.4
            v101.stamp.Rotation = -18
            tw(v101.stampScale, 0.22, {Scale = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            tw(v101.stamp, 0.22, {Rotation = -8}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            a17.Sounds.Play("Upgrade_Ready")

            if not sleep(token, 0.22, false) then
                return false
            end

            v317 = 8
            v318 = 0
            v319 = 0.2
            v101.barGrad.Color = ColorSequence.new(theme.Lighten(colors.Success, 0.15), colors.SuccessDark)
            v101.barFlash.BackgroundColor3 = colors.Success
            v101.barFlash.BackgroundTransparency = 0.25
            tw(v101.barFlash, 0.4, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
            v101.frontPool:Burst(16, {mode = "point", jitter = 110, speedMin = 250, speedMax = 650, sparkChance = 0.5, sparkLen = 110, size = 20, grav = 500, drag = 1.8, lifeMin = 0.4, lifeMax = 0.8, whiteChance = 0, at = Vector2.new(0, -67.42), colors = {colors.Success, theme.Lighten(colors.Success, 0.4)}})
        end

        v102.hurry = false
        v102.tapped = false
        local v579 = v13.dwell * v541
        local v580 = stack.ready and 0.35 or 0
        sleep(token, v579 + v580, true)
        local v581 = v102 ~= nil and v102.token == token

        if not v581 or v102.skip then
            return false
        end

        if cardIndex ~= #v102.reveal.stacks then
            local cardOut = v13.cardOut
            local propertyTable = {}
            local udim2FromOffset = UDim2.fromOffset
            local v585 = cardIndex % 2 ~= 0 and -520 or 520
            propertyTable.Position = udim2FromOffset(v585, -104)
            propertyTable.Rotation = cardIndex % 2 ~= 0 and -14 or 14
            tw(card, cardOut, propertyTable, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            tw(v101.cardScale, v13.cardOut, {Scale = 0.6839999999999999}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            ui.FadeOut(v101.barBox, TweenInfo.new(v13.cardOut * 0.8 * pace))

            if not sleep(token, v13.cardOut, false) then
                return false
            end

            card.Visible = false
            ui.Unfade(v101.barBox)
            v101.barBox.Visible = false
        end

        return true
    end

    local function tileFor(tileKey: number)
        --[[
          name: tileFor
          line: 1794
          upvalues:
            v101 (copy, index: 1)
            ui (copy, index: 2)
            colors (copy, index: 3)
            fonts (copy, index: 4)
            theme (copy, index: 5)
        ]]
        if const tile = v101.tiles[tileKey] then
            return tile
        end

        local ui2 = ui.new("Frame", {Name = "Tile" .. tileKey, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(168, 236), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 12, (ui.Corner(14)), Parent = v101.sumRow})
        local grad = ui.new("UIGradient", {Rotation = 90, Parent = ui2})
        local stroke = ui.Stroke(colors.Accent, 2.5, 0.1)
        stroke.Parent = ui2
        local scale = ui.new("UIScale", {Parent = ui2})
        local parent = ui.new("Frame", {Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 132), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.45, ZIndex = 13, (ui.Corner(10)), Parent = ui2})
        local icon = ui.new("Frame", {ZIndex = 14, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(126, 126), Parent = parent})
        local ui3 = ui.new("TextLabel", {Text = "", TextSize = 17, ZIndex = 14, Position = UDim2.fromOffset(8, 146), Size = UDim2.new(1, -16, 0, 22), FontFace = fonts.Heavy, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
        ui.TextStroke(colors.Void, 1.5, 0.45).Parent = ui3
        local ui4 = ui.new("TextLabel", {Text = "", TextSize = 28, ZIndex = 14, Position = UDim2.fromOffset(8, 168), Size = UDim2.new(1, -16, 0, 30), FontFace = fonts.Display, Parent = ui2})
        ui.TextStroke(colors.Void, 1.5, 0.4).Parent = ui4
        local parent2 = ui.new("Frame", {Position = UDim2.fromOffset(12, 206), Size = UDim2.new(1, -24, 0, 12), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.25, ClipsDescendants = true, ZIndex = 14, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local barFill = ui.new("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = colors.Accent, ZIndex = 15, (ui.Corner(theme.Radius.Pill)), Parent = parent2})
        local ui5 = ui.new("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 8), Size = UDim2.fromOffset(120, 28), BackgroundColor3 = colors.Gold, ZIndex = 16, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local v600 = {frame = ui2, grad = grad, stroke = stroke, scale = scale, icon = icon, name = ui3, count = ui4, barFill = barFill, tag = ui5, tagText = ui.new("TextLabel", {Text = "NEW", TextSize = 16, ZIndex = 17, Size = UDim2.fromScale(1, 1), FontFace = fonts.Display, TextColor3 = colors.TextDark, Parent = ui5})}
        v101.tiles[tileKey] = v600

        return v600
    end

    local function phaseSummary(token: number)
        --[[
          name: phaseSummary
          line: 1818
          upvalues:
            v102 (ref,  index: 1)
            v323 (copy, index: 2)
            v101 (copy, index: 3)
            weaponIcon (copy, index: 4)
            tw (copy, index: 5)
            titleIn (copy, index: 6)
            v134 (copy, index: 7)
            tileFor (copy, index: 8)
            catColor (copy, index: 9)
            colors (copy, index: 10)
            weaponInfo (copy, index: 11)
            theme (copy, index: 12)
            a17 (copy, index: 13)
            v13 (copy, index: 14)
            sleep (copy, index: 15)
        ]]
        local parts
        local transparency, v605
        local reveal = v102.reveal
        local look = v102.look
        v102.phase = "summary"
        v102.skip = false
        v102.hurry = false
        v102.tapped = false
        v323.on = false

        if v102.stopSparkles then
            v102.stopSparkles()
            v102.stopSparkles = nil
        end

        v101.card.Visible = false
        v101.barBox.Visible = false
        v101.newRoot.Visible = false
        weaponIcon.Set(v101.newItem, nil)
        weaponIcon.Set(v101.icon, nil)
        v101.prompt.Visible = false
        v101.counter.Visible = false
        v101.skip.Visible = false
        v101.leak.ImageTransparency = 1
        v101.leakFlare.ImageTransparency = 1
        v101.beam.ImageTransparency = 1

        if not v102.summaryOnly then
            tw(v101.chestHolder, 0.3, {Position = UDim2.fromOffset(0, 350)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            tw(v101.vpf, 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(v101.chestGlow, 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(v101.shadow, 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
        end

        if 0.5 < v101.title.TextTransparency then
            titleIn(look.title, v102.subtitle)
        end

        tw(v101.dim, 0.3, {BackgroundTransparency = 0.12}, Enum.EasingStyle.Quad)
        v101.raysHolder.Position = UDim2.fromOffset(0, -40)
        v101.raysScale.Scale = 1
        tw(v101.raysA, 0.4, {ImageTransparency = math.min(0.9, look.rays + 0.1)}, Enum.EasingStyle.Quad)
        tw(v101.raysB, 0.4, {ImageTransparency = math.min(0.94, look.rays + 0.2)}, Enum.EasingStyle.Quad)
        tw(v101.halo, 0.4, {ImageTransparency = 0.62, Size = UDim2.fromOffset(900, 700)}, Enum.EasingStyle.Quad)
        v134.raysSpin = 6
        local stackCount = #reveal.stacks
        local scale = math.min(1.14, 1040 / math.max(1, (stackCount * 186) - 18))

        for v610 = 1, math.max(stackCount, #v101.tiles) do
            if const stack = reveal.stacks[v610] then
                local levelBefore, v613, v614
                local v615 = tileFor(v610)
                local v616 = catColor(stack.item)
                v615.frame.Visible = true
                v615.grad.Color = ColorSequence.new(v616:Lerp(colors.Void, 0.2), v616:Lerp(colors.Void, 0.7))
                v615.stroke.Color = v616:Lerp(Color3.new(1, 1, 1), 0.4)
                v615.name.Text = string.upper(weaponInfo.Name(stack.item))
                v615.count.Text = "x" .. stack.shards
                local levelBefore2 = stack.levelBefore
                local total = stack.total
                local need = stack.need

                if stack.unlocked then
                    levelBefore = 1
                    v613 = stack.surplus
                    v614 = stack.needAfter
                else
                    v614, v613, levelBefore = need, total, levelBefore2
                end

                local barFill = v615.barFill
                local udim2FromScale = UDim2.fromScale
                local v622 = not v614 and 1 or math.clamp(v613 / v614, 0, 1)
                barFill.Size = udim2FromScale(v622, 1)
                local barFill2 = v615.barFill

                if stack.ready then
                    v616 = colors.Success
                end

                barFill2.BackgroundColor3 = v616

                if stack.unlocked then
                    v615.tag.Visible = true
                    v615.tag.BackgroundColor3 = colors.Gold
                    v615.tagText.Text = "NEW ITEM"
                    v615.tagText.TextColor3 = colors.TextDark
                elseif stack.ready then
                    v615.tag.Visible = true
                    v615.tag.BackgroundColor3 = colors.Success
                    v615.tagText.Text = "UPGRADE"
                    v615.tagText.TextColor3 = colors.Text
                elseif not (levelBefore <= 0) then
                    v615.tag.Visible = true
                    v615.tag.BackgroundColor3 = colors.Raised
                    v615.tagText.Text = "LV " .. levelBefore
                    v615.tagText.TextColor3 = colors.Text
                else
                    v615.tag.Visible = true
                    v615.tag.BackgroundColor3 = colors.Raised
                    v615.tagText.Text = string.format("%d / %d", v613, v614 or 0)
                    v615.tagText.TextColor3 = colors.TextDim
                end

                weaponIcon.Set(v615.icon, stack.item, {outline = false, glow = false})
                local v624 = (v610 - 1 - ((stackCount - 1) / 2)) * 186 * scale
                v615.frame.Position = UDim2.fromOffset(v624, 60)
                v615.scale.Scale = 0
                tw(v615.frame, 0.4, {Position = UDim2.fromOffset(v624, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((v610 - 1) * 0.07) + 0.05)
                tw(v615.scale, 0.4, {Scale = scale}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((v610 - 1) * 0.07) + 0.05)
            elseif const tile = v101.tiles[v610] then
                tile.frame.Visible = false
                weaponIcon.Set(tile.icon, nil)
            end
        end

        local total = 0
        local count = 0
        local count2 = 0

        for _, stack in reveal.stacks do
            total += stack.shards

            if stack.unlocked then
                count += 1
            end

            if stack.ready then
                count2 += 1
            end
        end

        local v631 = {string.format("<font color=\"#%s\">+%d</font> SHARDS", look.light:ToHex(), total)}

        if 0 < count then
            local stringFormat = string.format
            local v633 = colors.Gold:ToHex()
            local v634 = not (1 < count) and "" or "S"
            table.insert(v631, stringFormat("<font color=\"#%s\">%d NEW ITEM%s</font>", v633, count, v634))
        end

        if 0 < count2 then
            local stringFormat = string.format
            local v636 = theme.Lighten(colors.Success, 0.2):ToHex()
            local v637 = not (1 < count2) and "" or "S"
            table.insert(v631, stringFormat("<font color=\"#%s\">%d UPGRADE%s READY</font>", v636, count2, v637))
        end

        if stackCount ~= 0 then
            parts = v631
        else
            local v638 = {}
            v638[1] = if reveal.xp then string.format("EVERYTHING MAXED  ·  +%d XP", reveal.xp) else "EVERYTHING MAXED"
            parts = v638
        end

        for v639, v640 in parts do
            parts[v639] = a17.Loc.T(v640)
        end

        v101.sumTotals.Text = table.concat(parts, "   ·   ")
        local sumTotals = v101.sumTotals
        sumTotals.TextTransparency = 1

        if const v642 = if sumTotals:IsA("TextLabel") then sumTotals:FindFirstChildWhichIsA("UIStroke") else nil then
            if type((v642:GetAttribute("Authored"))) ~= "number" then
                v642:SetAttribute("Authored", v642.Transparency)
            end

            transparency = 1
            v605 = v642
        else
            transparency = 1
            v605 = nil
        end

        if v605 then
            v605.Transparency = transparency
        end

        tw(v101.sumTotals, 0.3, {TextTransparency = 0}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, (stackCount * 0.07) + 0.25)
        v101.sumRoot.Visible = true
        v101.cont.Visible = true
        v101.contScale.Scale = 0
        tw(v101.contScale, 0.35, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, (stackCount * 0.07) + 0.35)
        a17.Sounds.Play("Reward")
        local frontPool = v101.frontPool
        local v644 = look.legendary and 34 or 20
        frontPool:Burst(v644, {mode = "point", jitter = 380, speedMin = 40, speedMax = 180, kind = "sparkle", size = 28, grav = -40, drag = 0.6, lifeMin = 0.9, lifeMax = 1.7, whiteChance = 0, at = Vector2.new(0, -40), colors = {look.light, look.primary}})
        local v645 = v102.opts.autoContinue or v13.summaryAuto[v102.source] or 6
        v101.contFillGrad.Offset = Vector2.new(-0.5, 0)
        tw(v101.contFillGrad, v645, {Offset = Vector2.new(0.5, 0)}, Enum.EasingStyle.Linear)

        if not sleep(token, 0.45, false) then
            return
        end

        sleep(token, v645 - 0.45, true)
    end

    local function hideAll()
        --[[
          name: hideAll
          line: 1958
          upvalues:
            v101 (copy, index: 1)
            weaponIcon (copy, index: 2)
            v161 (copy, index: 3)
            v162 (ref,  index: 4)
        ]]
        v101.root.Visible = false
        v101.card.Visible = false
        v101.barBox.Visible = false
        v101.newRoot.Visible = false
        v101.sumRoot.Visible = false
        v101.prompt.Visible = false
        v101.counter.Visible = false
        v101.skip.Visible = false
        v101.chestHolder.Visible = false
        weaponIcon.Set(v101.icon, nil)
        weaponIcon.Set(v101.newItem, nil)

        for _, tile in v101.tiles do
            weaponIcon.Set(tile.icon, nil)
            tile.frame.Visible = false
        end

        v101.backPool:Clear()
        v101.frontPool:Clear()

        for _, v650 in v161 do
            v650.part:Destroy()
        end

        table.clear(v161)
        v162 = nil
    end

    local v651 = {}

    local function cancelOut()
        --[[
          name: cancelOut
          line: 1981
          upvalues:
            v651 (copy, index: 1)
        ]]
        for _, v654 in v651 do
            v654:Cancel()
        end

        table.clear(v651)
    end

    local function fadeOut(a656: number)
        --[[
          name: fadeOut
          line: 1987
          upvalues:
            v651 (copy, index: 1)
            tweenService (copy, index: 2)
            v101 (copy, index: 3)
        ]]
        for _, v658 in v651 do
            v658:Cancel()
        end

        table.clear(v651)
        local tweenInfo = TweenInfo.new(a656, Enum.EasingStyle.Quad)

        local function add(instance: Instance, propertyTable)
            --[[
              name: add
              line: 1990
              upvalues:
                tweenService (copy, index: 1)
                tweenInfo (copy, index: 2)
                v651 (copy, index: 3)
            ]]
            local tween = tweenService:Create(instance, tweenInfo, propertyTable)
            tween:Play()
            table.insert(v651, tween)
        end

        local tween = tweenService:Create(v101.dim, tweenInfo, {BackgroundTransparency = 1})
        tween:Play()
        table.insert(v651, tween)
        local tween2 = tweenService:Create(v101.vignette, tweenInfo, {ImageTransparency = 1})
        tween2:Play()
        table.insert(v651, tween2)
        local tween3 = tweenService:Create(v101.tint, tweenInfo, {ImageTransparency = 1})
        tween3:Play()
        table.insert(v651, tween3)
        local tween4 = tweenService:Create(v101.flash, tweenInfo, {BackgroundTransparency = 1})
        tween4:Play()
        table.insert(v651, tween4)

        for _, instance in {v101.raysA, v101.raysB, v101.halo, v101.vpf, v101.chestGlow, v101.shadow} do
            local tween5 = tweenService:Create(instance, tweenInfo, {ImageTransparency = 1})
            tween5:Play()
            table.insert(v651, tween5)
        end

        for _, instance in {v101.title, v101.titleShadow, v101.subtitle, v101.sumTotals} do
            local uiStroke
            local uiStroke2
            local tween6 = tweenService:Create(instance, tweenInfo, {TextTransparency = 1})
            tween6:Play()
            table.insert(v651, tween6)

            if instance:IsA("TextLabel") then
                uiStroke = instance:FindFirstChildWhichIsA("UIStroke")
            else
                uiStroke = nil
            end

            if uiStroke then
                if type((uiStroke:GetAttribute("Authored"))) ~= "number" then
                    uiStroke:SetAttribute("Authored", uiStroke.Transparency)
                end

                uiStroke2 = uiStroke
            else
                uiStroke2 = nil
            end

            if uiStroke2 then
                local tween7 = tweenService:Create(uiStroke2, tweenInfo, {Transparency = 1})
                tween7:Play()
                table.insert(v651, tween7)
            end
        end

        local tween8 = tweenService:Create(v101.contScale, tweenInfo, {Scale = 0})
        tween8:Play()
        table.insert(v651, tween8)
        local tween9 = tweenService:Create(v101.cardScale, tweenInfo, {Scale = 0})
        tween9:Play()
        table.insert(v651, tween9)
        local tween10 = tweenService:Create(v101.skip, tweenInfo, {BackgroundTransparency = 1})
        tween10:Play()
        table.insert(v651, tween10)

        for _, tile in v101.tiles do
            local tween11 = tweenService:Create(tile.scale, tweenInfo, {Scale = 0})
            tween11:Play()
            table.insert(v651, tween11)
        end
    end

    local function snap(instance: Instance, propertyTable)
        --[[
          name: snap
          line: 2017
          upvalues:
            tweenService (copy, index: 1)
        ]]
        tweenService:Create(instance, TweenInfo.new(0), propertyTable):Play()

        for v686, v687 in propertyTable do
            instance[v686] = v687
        end
    end

    local v688 = {TR_RevealSafe = true, TR_TopbarSettings = true, CombatHUD = true, CombatTouch = true, CharacterTouch = true, TouchGui = true, Chat = true, BubbleChat = true}
    local v689 = {TR_Replay = true, TR_ReplayFrame = true, TR_ReplayHud = true}
    local v690 = {}
    local v691 = {}
    local v692 = false

    local function hideCollector(descendant)
        --[[
          name: hideCollector
          line: 2043
          upvalues:
            v101 (copy, index: 1)
            v688 (copy, index: 2)
            a17 (copy, index: 3)
            v689 (copy, index: 4)
            v690 (copy, index: 5)
            v691 (copy, index: 6)
        ]]
        repeat
            if descendant == v101.gui or v688[descendant.Name] then
                return
            elseif const firstAncestorWhichIsA = descendant:FindFirstAncestorWhichIsA("ScreenGui") then
                if firstAncestorWhichIsA.Name == "Chat" then
                    break
                end
                if firstAncestorWhichIsA.Name == "BubbleChat" then
                    break
                end
            end

            if descendant:IsA("ScreenGui") then
                if descendant.Parent == a17.PlayerGui and descendant.Enabled then
                    descendant.Enabled = false

                    if not v689[descendant.Name] then
                        v690[descendant] = true
                        return
                    end
                end
            elseif (descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui")) and v691[descendant] == nil then
                pcall(
                    function()
                        --[[
                          line: 2059
                          upvalues:
                            descendant (copy, index: 1)
                            v691 (copy, index: 2)
                        ]]
                        descendant.MaxDistance, v691[descendant] = 0.001, descendant.MaxDistance
                    end
                )
            end

            return
        until true
    end

    local function sweepUi()
        --[[
          name: sweepUi
          line: 2066
          upvalues:
            a17 (copy, index: 1)
            hideCollector (copy, index: 2)
            workspace (copy, index: 3)
        ]]
        for _, descendant in a17.PlayerGui:GetDescendants() do
            if descendant:IsA("LayerCollector") then
                hideCollector(descendant)
            end
        end

        if const trContractDisplay = workspace:FindFirstChild("TR_ContractDisplay") then
            for _, descendant in trContractDisplay:GetDescendants() do
                if descendant:IsA("LayerCollector") then
                    hideCollector(descendant)
                end
            end
        end
    end

    local function setAllUiHidden(allUiHidden: boolean)
        --[[
          name: setAllUiHidden
          line: 2081
          upvalues:
            v692 (ref,  index: 1)
            sweepUi (copy, index: 2)
            proximityPromptService (copy, index: 3)
            v690 (copy, index: 4)
            v691 (copy, index: 5)
            a17 (copy, index: 6)
        ]]
        if v692 == allUiHidden then
            return
        end

        v692 = allUiHidden

        if allUiHidden then
            sweepUi()
            proximityPromptService.Enabled = false

            return
        end

        for v704 in v690 do
            if v704.Parent then
                v704.Enabled = true
            end
        end

        table.clear(v690)

        for v705, maxDistance in v691 do
            if v705.Parent then
                pcall(
                    function()
                        --[[
                          line: 2098
                          upvalues:
                            v705 (copy, index: 1)
                            maxDistance (copy, index: 2)
                        ]]
                        v705.MaxDistance = maxDistance
                    end
                )
            end
        end

        table.clear(v691)
        proximityPromptService.Enabled = not a17.MenuManager.IsOpen()
    end

    dropReveal._SweepUi = function()
        --[[
          line: 2107
          upvalues:
            v692 (ref,  index: 1)
            sweepUi (copy, index: 2)
        ]]
        if v692 then
            sweepUi()
        end
    end

    local v707 = nil
    local v708 = false

    local function setPlaying(playing: boolean)
        --[[
          name: setPlaying
          line: 2115
          upvalues:
            v104 (ref,  index: 1)
            a17 (copy, index: 2)
            v708 (ref,  index: 3)
            dropReveal (copy, index: 4)
            setAllUiHidden (copy, index: 5)
        ]]
        if v104 == playing then
            return
        end

        v104 = playing
        a17.SetHudHidden("Reveal", playing)
        a17.MenuManager.HoldChat("Reveal", playing)

        if playing then
            a17.MenuManager.PushMouse("DropReveal")

            if a17.Canvas.Menus.Visible then
                a17.Canvas.Menus.Visible = false
                v708 = true
            end
        else
            a17.MenuManager.PopMouse("DropReveal")

            if v708 then
                a17.Canvas.Menus.Visible = true
                v708 = false
            end
        end

        dropReveal.Changed:Fire(playing)

        if a17.TopbarSettings and type(a17.TopbarSettings.SetHidden) == "function" then
            pcall(a17.TopbarSettings.SetHidden, "Reveal", playing)
        end

        setAllUiHidden(playing)
        local economy = a17.Economy

        if economy and type(economy.SetRevealShowing) == "function" then
            pcall(economy.SetRevealShowing, playing)
        end
    end

    local function finish(a713, a714: boolean?)
        --[[
          name: finish
          line: 2150
          upvalues:
            v102 (ref,  index: 1)
            count (ref,  index: 2)
            v323 (copy, index: 3)
            v135 (copy, index: 4)
            v707 (ref,  index: 5)
            hideAll (copy, index: 6)
            ui2 (ref,  index: 7)
            ui3 (ref,  index: 8)
            renderSteppedConnection (ref,  index: 9)
            pace (ref,  index: 10)
            fadeOut (copy, index: 11)
            gradeOut (copy, index: 12)
            setPlaying (copy, index: 13)
            dropReveal (copy, index: 14)
        ]]
        if not v102 then
            return
        end

        local v715 = v102
        v102 = nil
        count += 1
        local v716 = count
        v323.on = false
        table.clear(v135)

        if v707 then
            v707()
            v707 = nil
        end

        local function tail()
            --[[
              name: tail
              line: 2164
              upvalues:
                v716 (copy, index: 1)
                count (ref,  index: 2)
                hideAll (copy, index: 3)
                ui2 (ref,  index: 4)
                ui3 (ref,  index: 5)
                renderSteppedConnection (ref,  index: 6)
                pace (ref,  index: 7)
            ]]
            if v716 ~= count then
                return
            end

            hideAll()

            if ui2 then
                ui2:Destroy()
                ui2 = nil
            end

            if ui3 then
                ui3:Destroy()
                ui3 = nil
            end

            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end

            pace = 1
        end

        if a714 then
            if v716 == count then
                hideAll()

                if ui2 then
                    ui2:Destroy()
                    ui2 = nil
                end

                if ui3 then
                    ui3:Destroy()
                    ui3 = nil
                end

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                pace = 1
            end
        else
            fadeOut(0.28)
            gradeOut(0.3)

            task.delay(
                0.3,
                function()
                    --[[
                      line: 2181
                      upvalues:
                        v716 (copy, index: 1)
                        count (ref,  index: 2)
                        hideAll (copy, index: 3)
                        ui2 (ref,  index: 4)
                        ui3 (ref,  index: 5)
                        renderSteppedConnection (ref,  index: 6)
                        pace (ref,  index: 7)
                    ]]
                    if v716 == count then
                        if v716 ~= count then
                            return
                        end

                        hideAll()

                        if ui2 then
                            ui2:Destroy()
                            ui2 = nil
                        end

                        if ui3 then
                            ui3:Destroy()
                            ui3 = nil
                        end

                        if renderSteppedConnection then
                            renderSteppedConnection:Disconnect()
                            renderSteppedConnection = nil
                        end

                        pace = 1
                    end
                end
            )
        end

        setPlaying(false)

        if v715.opts.onDone then
            task.spawn(v715.opts.onDone, a713, v715.reveal.raw)
        end

        if a713 ~= "interrupted" and v715.reveal.id ~= "" and not v715.summaryOnly then
            dropReveal._Seen(v715.reveal.id)
        end

        dropReveal._Pump()
    end

    function dropReveal.Skip()
        --[[
          name: Skip
          line: 2197
          upvalues:
            v102 (ref,  index: 1)
            a17 (copy, index: 2)
        ]]
        if v102 and v102.phase ~= "summary" and not v102.skip then
            v102.skip = true
            a17.Sounds.Play("Click")
        end
    end

    local function tap()
        --[[
          name: tap
          line: 2203
          upvalues:
            v102 (ref,  index: 1)
            pace (ref,  index: 2)
            finishGroup (copy, index: 3)
            v135 (copy, index: 4)
            v134 (copy, index: 5)
        ]]
        if not v102 then
            return
        end

        if v102.phase == "land" then
            v102.tapped = true
            return
        end

        if v102.phase ~= "summary" then
            if v102.phase == "card" then
                if v102.hurry or not v102.group then
                    v102.tapped = true
                    return
                end

                v102.hurry = true
                finishGroup()

                for v719, v720 in v135 do
                    if const v721 = v720[#v720] then
                        v134[v719] = v721.to
                    end
                end

                table.clear(v135)

                return
            end

            v102.tapped = true
        else
            local v722 = os.clock() - (v102.summaryAt or 0)

            if pace * 0.35 < v722 then
                v102.tapped = true
            end
        end
    end

    dropReveal.Tap = tap

    function dropReveal.Play(raw, options)
        --[[
          name: Play
          line: 2230
          upvalues:
            normReveal (copy, index: 1)
            a17 (copy, index: 2)
            dropReveal (copy, index: 3)
            v102 (ref,  index: 4)
            finish (copy, index: 5)
            build (copy, index: 6)
            layout (copy, index: 7)
            pace (ref,  index: 8)
            v101 (copy, index: 9)
            count (ref,  index: 10)
            v12 (copy, index: 11)
            v651 (copy, index: 12)
            v135 (copy, index: 13)
            v134 (copy, index: 14)
            tweenService (copy, index: 15)
            colors (copy, index: 16)
            v317 (ref,  index: 17)
            paletteOf (copy, index: 18)
            buildChest (copy, index: 19)
            setPlaying (copy, index: 20)
            tw (copy, index: 21)
            gradeIn (copy, index: 22)
            renderSteppedConnection (ref,  index: 23)
            runService (copy, index: 24)
            onRender (copy, index: 25)
            contextActionService (copy, index: 26)
            tap (copy, index: 27)
            v707 (ref,  index: 28)
            titleIn (copy, index: 29)
            phaseSummary (copy, index: 30)
            phaseLand (copy, index: 31)
            phaseIdle (copy, index: 32)
            phaseOpen (copy, index: 33)
            chestToCards (copy, index: 34)
            v14 (copy, index: 35)
            sleep (copy, index: 36)
            v13 (copy, index: 37)
            phaseCard (copy, index: 38)
        ]]
        local v725
        local reveal = normReveal(raw)
        if not reveal then
            return false
        end

        local opts = options or {}

        if reveal.source == "rank" and opts.rankShown ~= true then
            if not a17.RankUp then
                a17.EnsureScreen("RankUp")
            end

            if a17.RankUp then
                local values = table.clone(opts)
                values.rankShown = true

                return a17.RankUp.Play(
                    raw,
                    function(a729)
                        --[[
                          line: 2244
                          upvalues:
                            values (copy, index: 1)
                            raw (copy, index: 2)
                            dropReveal (copy, index: 3)
                        ]]
                        if a729 ~= "interrupted" then
                            dropReveal.Play(raw, values)
                            return
                        end

                        if values.onDone then
                            values.onDone("interrupted", raw)
                        end
                    end
                )
            end
        end

        if v102 then
            finish("interrupted", true)
        end

        build()
        layout()

        if type(opts.pace) ~= "number" or not (0 < opts.pace) then
            pace = 1
        else
            pace = opts.pace
        end

        v101.backPool.Pace = pace
        v101.frontPool.Pace = pace
        count += 1
        local token = count
        local v731 = v12[reveal.kind] or v12.drop

        if reveal.source == "rank" then
            v731 = table.clone(v731)
            v731.title = "RANK REWARD"
        end

        local total = 0

        for _, stack in reveal.stacks do
            total += stack.shards
        end

        local v735 = {phase = "start", tapped = false, skip = false, hurry = false, token = token, reveal = reveal, look = v731, opts = opts}
        local source = opts.source or reveal.source or "lobby"
        v735.source = source
        v735.summaryOnly = opts.summaryOnly == true
        local stringFormat = string.format
        local stackCount = #reveal.stacks
        local v739 = #reveal.stacks ~= 1 and "S" or ""
        v735.subtitle = stringFormat("%d ITEM%s  ·  %d SHARDS", stackCount, v739, total)
        v102 = v735

        for _, v741 in v651 do
            v741:Cancel()
        end

        table.clear(v651)
        table.clear(v135)
        v134.y = 0
        v134.yaw = 0
        v134.roll = 0
        v134.pitch = 0
        v134.sq = 0
        v134.lid = 0
        v134.s = 1
        v134.raysSpin = 8
        v101.backPool:Clear()
        v101.frontPool:Clear()
        v101.root.Visible = true
        local dim = v101.dim
        local propertyTable = {BackgroundTransparency = 1}
        tweenService:Create(dim, TweenInfo.new(0), propertyTable):Play()

        for v744, v745 in propertyTable do
            dim[v744] = v745
        end

        local flash = v101.flash
        local propertyTable2 = {BackgroundTransparency = 1}
        tweenService:Create(flash, TweenInfo.new(0), propertyTable2):Play()

        for v748, v749 in propertyTable2 do
            flash[v748] = v749
        end

        local vignette = v101.vignette
        local propertyTable3 = {ImageTransparency = 1, ImageColor3 = colors.Void}
        tweenService:Create(vignette, TweenInfo.new(0), propertyTable3):Play()

        for v752, v753 in propertyTable3 do
            vignette[v752] = v753
        end

        local skip = v101.skip
        local propertyTable4 = {BackgroundTransparency = 0.12}
        tweenService:Create(skip, TweenInfo.new(0), propertyTable4):Play()

        for v756, v757 in propertyTable4 do
            skip[v756] = v757
        end

        for _, instance in {v101.tint, v101.raysA, v101.raysB, v101.halo, v101.beam, v101.floorRing, v101.shadow, v101.leak, v101.leakFlare, v101.chestGlow} do
            local propertyTable5 = {ImageTransparency = 1}
            tweenService:Create(instance, TweenInfo.new(0), propertyTable5):Play()

            for v761, v762 in propertyTable5 do
                instance[v761] = v762
            end
        end

        local vpf = v101.vpf
        local propertyTable6 = {ImageTransparency = 0}
        tweenService:Create(vpf, TweenInfo.new(0), propertyTable6):Play()

        for v765, v766 in propertyTable6 do
            vpf[v765] = v766
        end

        for _, instance in {v101.title, v101.titleShadow, v101.subtitle, v101.sumTotals} do
            local v769
            local propertyTable7 = {TextTransparency = 1}
            tweenService:Create(instance, TweenInfo.new(0), propertyTable7):Play()

            for v771, v772 in propertyTable7 do
                instance[v771] = v772
            end

            if const v773 = if instance:IsA("TextLabel") then instance:FindFirstChildWhichIsA("UIStroke") else nil then
                if type((v773:GetAttribute("Authored"))) ~= "number" then
                    v773:SetAttribute("Authored", v773.Transparency)
                end

                v769 = v773
            else
                v769 = nil
            end

            if v769 then
                local propertyTable8 = {Transparency = 1}
                tweenService:Create(v769, TweenInfo.new(0), propertyTable8):Play()

                for v775, v776 in propertyTable8 do
                    v769[v775] = v776
                end
            end
        end

        local raysScale = v101.raysScale
        local propertyTable9 = {Scale = 1}
        tweenService:Create(raysScale, TweenInfo.new(0), propertyTable9):Play()

        for v779, v780 in propertyTable9 do
            raysScale[v779] = v780
        end

        local contScale = v101.contScale
        local propertyTable10 = {Scale = 0}
        tweenService:Create(contScale, TweenInfo.new(0), propertyTable10):Play()

        for v783, v784 in propertyTable10 do
            contScale[v783] = v784
        end

        local cardScale = v101.cardScale
        local propertyTable11 = {Scale = 1.14}
        tweenService:Create(cardScale, TweenInfo.new(0), propertyTable11):Play()
        v725 = v731

        for v787, v788 in propertyTable11 do
            cardScale[v787] = v788
        end

        local card = v101.card
        local barBox = v101.barBox
        local newRoot = v101.newRoot
        local sumRoot = v101.sumRoot
        card.Visible = false
        barBox.Visible = false
        newRoot.Visible = false
        sumRoot.Visible = false
        local prompt = v101.prompt
        local counter = v101.counter
        prompt.Visible = false
        counter.Visible = false
        v101.shaker.Position = UDim2.new()
        v317 = 0
        v101.chestHolder.Visible = false
        paletteOf(v725)
        buildChest(v725.model, v725.fit)
        setPlaying(true)
        tw(v101.dim, 0.35, {BackgroundTransparency = 0.2}, Enum.EasingStyle.Quad)
        tw(v101.vignette, 0.4, {ImageTransparency = 0.25}, Enum.EasingStyle.Quad)
        tw(v101.tint, 0.6, {ImageTransparency = 0.8}, Enum.EasingStyle.Quad)
        gradeIn(v725)
        renderSteppedConnection = renderSteppedConnection or runService.RenderStepped:Connect(onRender)
        v101.skip.Visible = not v102.summaryOnly
        v101.skipFill.Size = UDim2.fromScale(0, 1)

        contextActionService:BindActionAtPriority(
            "TR_RevealKeys",
            function(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject)
                --[[
                  line: 2332
                  upvalues:
                    dropReveal (copy, index: 1)
                    tap (copy, index: 2)
                ]]
                if inputState ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Sink
                end

                if inputObject.KeyCode == Enum.KeyCode.ButtonB or inputObject.KeyCode == Enum.KeyCode.ButtonY then
                    dropReveal.Skip()
                else
                    tap()
                end

                return Enum.ContextActionResult.Sink
            end,
            false,
            Enum.ContextActionPriority.High.Value + 50,
            Enum.KeyCode.Space,
            Enum.KeyCode.Return,
            Enum.KeyCode.ButtonA,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.ButtonY
        )

        v707 = function()
            --[[
              line: 2343
              upvalues:
                contextActionService (copy, index: 1)
            ]]
            contextActionService:UnbindAction("TR_RevealKeys")
        end

        task.spawn(
            xpcall,
            function()
                --[[
                  line: 2347
                  upvalues:
                    v102 (ref,  index: 1)
                    titleIn (copy, index: 2)
                    v725 (ref,  index: 3)
                    phaseSummary (copy, index: 4)
                    token (copy, index: 5)
                    finish (copy, index: 6)
                    phaseLand (copy, index: 7)
                    phaseIdle (copy, index: 8)
                    phaseOpen (copy, index: 9)
                    reveal (copy, index: 10)
                    chestToCards (copy, index: 11)
                    v101 (copy, index: 12)
                    v14 (copy, index: 13)
                    sleep (copy, index: 14)
                    v13 (copy, index: 15)
                    phaseCard (copy, index: 16)
                ]]
                if v102 and v102.summaryOnly then
                    titleIn(v725.title, v102.subtitle)
                    v102.summaryAt = os.clock()
                    phaseSummary(token)
                    local v798 = v102 ~= nil and v102.token == token
                    if v798 then
                        finish("done")
                    end

                    return
                end

                local v799 = phaseLand(token) and phaseIdle(token)
                v799 = v799 and phaseOpen(token)

                if v799 and 0 < #reveal.stacks then
                    chestToCards()
                    local stackCount = #reveal.stacks
                    v101.counter.Visible = 0 < stackCount
                    v101.counterText.Text = "x" .. stackCount

                    if v102 then
                        v101.counter.Position = UDim2.fromOffset(128, v14.chestCardY - 62)
                    end

                    if sleep(token, v13.toCards * 0.6, false) then
                        for cardIndex, stack in reveal.stacks do
                            if not phaseCard(token, cardIndex, stack) then
                                break
                            end
                        end
                    end
                end

                local v803 = v102 ~= nil and v102.token == token
                if not v803 then
                    return
                end

                local skip = v102.skip
                v102.summaryAt = os.clock()
                phaseSummary(token)
                local v805 = v102 ~= nil and v102.token == token
                if v805 then
                    local v806 = skip and "skipped" or "done"
                    finish(v806)
                end
            end,
            function(a807)
                --[[
                  line: 2392
                  upvalues:
                    v102 (ref,  index: 1)
                    token (copy, index: 2)
                    finish (copy, index: 3)
                ]]
                warn("[DropReveal] " .. tostring(a807) .. "\n" .. debug.traceback())

                if v102 and v102.token == token then
                    finish("interrupted", true)
                end
            end
        )

        return true
    end

    function dropReveal.ShowSummary(a808, a809)
        --[[
          name: ShowSummary
          line: 2402
          upvalues:
            dropReveal (copy, index: 1)
        ]]
        local v810 = a809 and table.clone(a809) or {}
        v810.summaryOnly = true

        return dropReveal.Play(a808, v810)
    end

    function dropReveal.Stop(a811)
        --[[
          name: Stop
          line: 2407
          upvalues:
            v102 (ref,  index: 1)
            finish (copy, index: 2)
        ]]
        if v102 then
            finish("interrupted", a811 ~= false)
        end
    end

    function dropReveal.IsPlaying()
        --[[
          name: IsPlaying
          line: 2412
          upvalues:
            v102 (ref, index: 1)
        ]]
        return v102 ~= nil
    end

    function dropReveal.State()
        --[[
          name: State
          line: 2415
          upvalues:
            v102 (ref, index: 1)
            pace (ref, index: 2)
        ]]
        local v812 = {}
        local playing = v102 ~= nil
        v812.playing = playing
        local v814 = v102 and v102.phase or nil
        v812.phase = v814
        v814 = v102 and v102.reveal.id or nil
        v812.id = v814
        v812.kind = v102 and v102.reveal.kind or nil
        v812.pace = pace

        return v812
    end

    local v815 = false

    local function wire()
        --[[
          name: wire
          line: 2421
          upvalues:
            v815 (ref,  index: 1)
            hasRun (ref,  index: 2)
            v101 (copy, index: 3)
            v102 (ref,  index: 4)
            tap (copy, index: 5)
            dropReveal (copy, index: 6)
            ui (copy, index: 7)
            layout (copy, index: 8)
        ]]
        if v815 or not hasRun then
            return
        end

        v815 = true

        v101.catcher.InputBegan:Connect(
            function(a817)
                --[[
                  line: 2430
                  upvalues:
                    v102 (ref, index: 1)
                ]]
                local userInputType = a817.UserInputType

                if (userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch)
                    and v102
                then
                    v102.holdAt = os.clock()
                end
            end
        )

        v101.catcher.InputEnded:Connect(
            function(a819)
                --[[
                  line: 2438
                  upvalues:
                    v102 (ref,  index: 1)
                    v101 (copy, index: 2)
                    tap (copy, index: 3)
                ]]
                local userInputType = a819.UserInputType

                if (userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch)
                    and v102
                    and v102.holdAt
                then
                    v102.holdAt = nil
                    v101.skipFill.Size = UDim2.fromScale(0, 1)
                    tap()
                end
            end
        )

        v101.skip.Activated:Connect(
            function()
                --[[
                  line: 2448
                  upvalues:
                    dropReveal (copy, index: 1)
                ]]
                dropReveal.Skip()
            end
        )

        v101.cont.Activated:Connect(
            function()
                --[[
                  line: 2451
                  upvalues:
                    v102 (ref, index: 1)
                ]]
                if v102 and v102.phase == "summary" then
                    v102.tapped = true
                end
            end
        )

        ui.ScaleChanged:Connect(layout)
        ui.TopInsetChanged:Connect(layout)
        v101.safe:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)
    end

    local play = dropReveal.Play

    dropReveal.Play = function(a822, a823)
        --[[
          line: 2461
          upvalues:
            play (copy, index: 1)
            wire (copy, index: 2)
        ]]
        local v824 = play(a822, a823)
        if v824 then
            wire()
        end

        return v824
    end

    state.MatchEvent:Connect(
        function(a825)
            --[[
              line: 2470
              upvalues:
                v102 (ref,  index: 1)
                finish (copy, index: 2)
            ]]
            if a825 == "MatchStart" and v102 then
                finish("interrupted", true)
            end
        end
    )

    local function blocked()
        --[[
          name: blocked
          line: 2475
          upvalues:
            localPlayer (copy, index: 1)
            a17 (copy, index: 2)
        ]]
        return localPlayer:GetAttribute("ReplayPlaying") == true
            or a17.IsHudHiddenFor("Intro")
            or a17.IsHudHiddenFor("Celebrate")
    end

    task.spawn(
        function()
            --[[
              line: 2478
              upvalues:
                v102 (ref,  index: 1)
                localPlayer (copy, index: 2)
                a17 (copy, index: 3)
                finish (copy, index: 4)
                dropReveal (copy, index: 5)
            ]]
            while true do
                task.wait(0.25)
                local isHudHiddenFor

                if v102 then
                    local isHudHiddenFor2 = true

                    if localPlayer:GetAttribute("ReplayPlaying") ~= true then
                        isHudHiddenFor = a17.IsHudHiddenFor("Intro")

                        if isHudHiddenFor then
                            isHudHiddenFor2 = isHudHiddenFor
                        else
                            isHudHiddenFor2 = a17.IsHudHiddenFor("Celebrate")
                        end
                    end

                    if isHudHiddenFor2 then
                        finish("interrupted", true)
                        continue
                    end
                end

                if v102 then
                    dropReveal._SweepUi()
                end
            end
        end
    )

    local v829 = {}
    local v830 = {}
    local v831 = {}
    local v832 = {}

    if state.GetPlayerState() ~= "Lobby" then
        v20 = math.huge
    else
        v20 = os.clock()
    end

    local function tryAck(a834)
        --[[
          name: tryAck
          line: 2495
          upvalues:
            v830 (copy, index: 1)
            v831 (copy, index: 2)
            state (copy, index: 3)
            players (copy, index: 4)
            a17 (copy, index: 5)
        ]]
        if v830[a834] or 4 <= (v831[a834] or 0) or state.Mock then
            return
        end
        if state.GetPlayerState() ~= "Lobby" and 0 < (v831[a834] or 0) then
            return
        end

        v831[a834] = (v831[a834] or 0) + 1

        task.spawn(
            function()
                --[[
                  line: 2503
                  upvalues:
                    players (copy, index: 1)
                    a17 (copy, index: 2)
                    a834 (copy, index: 3)
                    v830 (copy, index: 4)
                ]]
                local core = players.LocalPlayer:FindFirstChild("PlayerScripts")
                    and players.LocalPlayer.PlayerScripts:FindFirstChild("Core")
                local inputStats = core and core:FindFirstChild("InputStats")
                local v837 = if inputStats and inputStats:IsA("ModuleScript") then require(inputStats).Take() else 0
                local v838, v839 = a17.Remotes.Invoke("ProfileAction", "AckReveal", a834, v837)

                if v838 and v839 == true then
                    v830[a834] = true
                end
            end
        )
    end

    function dropReveal._Seen(key)
        --[[
          name: _Seen
          line: 2514
          upvalues:
            v829 (copy, index: 1)
            tryAck (copy, index: 2)
        ]]
        v829[key] = true
        tryAck(key)
    end

    local function canPlayLobby(a842: boolean)
        --[[
          name: canPlayLobby
          line: 2518
          upvalues:
            v102 (ref,  index: 1)
            state (copy, index: 2)
            localPlayer (copy, index: 3)
            a17 (copy, index: 4)
            v20 (ref,  index: 5)
        ]]
        if not v102 and state.GetPlayerState() == "Lobby" then
            local v843 = localPlayer:GetAttribute("ReplayPlaying") == true
                or a17.IsHudHiddenFor("Intro")
                or a17.IsHudHiddenFor("Celebrate")
            if not v843 then
                if a17.RankUp and a17.RankUp.IsPlaying() then
                    return false
                end
                if a17.LossForgiven and a17.LossForgiven.IsPlaying() then
                    return false
                end
                if a17.IsHudHiddenFor("MatchEnd") then
                    return false
                end

                if not a842 then
                    if a17.MenuManager.IsOpen() or os.clock() - v20 < 1.5 or not localPlayer.Character then
                        return false
                    end
                    if state.Get("CombatMode") == true then
                        return false
                    end
                end

                return true
            end
        end

        return false
    end

    local function pump()
        --[[
          name: pump
          line: 2541
          upvalues:
            v102 (ref,  index: 1)
            v832 (copy, index: 2)
            state (copy, index: 3)
            localPlayer (copy, index: 4)
            a17 (copy, index: 5)
            dropReveal (copy, index: 6)
            canPlayLobby (copy, index: 7)
            v829 (copy, index: 8)
            v830 (copy, index: 9)
            tryAck (copy, index: 10)
        ]]
        if v102 then
            return
        end

        if 0 < #v832 then
            local v845

            if v102 or state.GetPlayerState() ~= "Lobby" then
                v845 = false
            else
                local v846 = localPlayer:GetAttribute("ReplayPlaying") == true
                    or a17.IsHudHiddenFor("Intro")
                    or a17.IsHudHiddenFor("Celebrate")

                if v846 then
                    v845 = false
                else
                    v845 = (not a17.RankUp or not a17.RankUp.IsPlaying())
                        and (if a17.LossForgiven and a17.LossForgiven.IsPlaying() then false else not a17.IsHudHiddenFor("MatchEnd"))
                end
            end

            if v845 then
                local removedValue = table.remove(v832, 1)
                dropReveal.Play(removedValue, {source = "robux"})

                return
            end
        end

        if not canPlayLobby(false) then
            return
        end

        local reveals = state.Profile and state.Profile.reveals

        if type(reveals) ~= "table" then
            return
        end

        for _, reveal in reveals do
            local text

            if type(reveal) ~= "table" or reveal.id == nil then
                text = nil
            else
                text = tostring(reveal.id)
                text = text or nil
            end

            if text and not v829[text] then
                dropReveal.Play(reveal, {source = "lobby"})
                return
            end

            if text then
                if v829[text] and not v830[text] then
                    tryAck(text)
                end
            end
        end
    end

    dropReveal._Pump = function()
        --[[
          line: 2567
          upvalues:
            pump (copy, index: 1)
        ]]
        task.delay(0.6, pump)
    end

    function dropReveal.Queue(a852)
        --[[
          name: Queue
          line: 2570
          upvalues:
            v832 (copy, index: 1)
            pump (copy, index: 2)
        ]]
        if type(a852) == "table" then
            table.insert(v832, a852)
            pump()
        end
    end

    state.PlayerStateChanged:Connect(
        function(a853)
            --[[
              line: 2576
              upvalues:
                v20 (ref,  index: 1)
                pump (copy, index: 2)
            ]]
            v20 = a853 ~= "Lobby" and math.huge or os.clock()

            if a853 == "Lobby" then
                task.delay(1.6, pump)
            end
        end
    )

    state.ProfileChanged:Connect(
        function()
            --[[
              line: 2582
              upvalues:
                pump (copy, index: 1)
            ]]
            task.defer(pump)
        end
    )
    a17.MenuManager.Changed:Connect(
        function()
            --[[
              line: 2585
              upvalues:
                pump (copy, index: 1)
            ]]
            task.defer(pump)
        end
    )

    task.spawn(
        function()
            --[[
              line: 2588
              upvalues:
                pump (copy, index: 1)
            ]]
            while true do
                task.wait(1)
                pump()
            end
        end
    )

    local function hookEconomy()
        --[[
          name: hookEconomy
          line: 2595
          upvalues:
            a17 (copy, index: 1)
            dropReveal (copy, index: 2)
        ]]
        local economy = a17.Economy

        if economy and economy.Event then
            economy.Event:Connect(
                function(a856, a857)
                    --[[
                      line: 2598
                      upvalues:
                        dropReveal (copy, index: 1)
                    ]]
                    if a856 ~= "Drop" or type(a857) ~= "table" then
                        return
                    end

                    if type(a857.reveals) ~= "table" then
                        dropReveal.Queue(a857)
                        return
                    end

                    for _, reveal in a857.reveals do
                        dropReveal.Queue(reveal)
                    end
                end
            )
        end
    end

    local economy = a17.Economy

    if economy and economy.Event then
        economy.Event:Connect(
            function(a861, a862)
                --[[
                  line: 2598
                  upvalues:
                    dropReveal (copy, index: 1)
                ]]
                if a861 ~= "Drop" or type(a862) ~= "table" then
                    return
                end

                if type(a862.reveals) ~= "table" then
                    dropReveal.Queue(a862)
                    return
                end

                for _, reveal in a862.reveals do
                    dropReveal.Queue(reveal)
                end
            end
        )
    end

    local v865 = {
        drop = {kind = "drop", stacks = {{item = "crossbow", shards = 6, before = 4, levelBefore = 0}, {item = "bronze_sword", shards = 4, before = 6, levelBefore = 1}}},
        victory = {kind = "victory", stacks = {{item = "spear", shards = 8, before = 3, levelBefore = 0}, {item = "short_bow", shards = 7, before = 1, levelBefore = 2}, {item = "throwing_knives", shards = 5, before = 1, levelBefore = 1}}},
        golden = {kind = "golden", stacks = {{item = "longbow", shards = 18, before = 26, levelBefore = 0}, {item = "battle_axe", shards = 16, before = 2, levelBefore = 0}, {item = "fire_bomb", shards = 14, before = 0, levelBefore = 0}, {item = "bandage", shards = 12, before = 3, levelBefore = 1}}},
        newitem = {kind = "victory", stacks = {{item = "crossbow", shards = 9, before = 14, levelBefore = 0}, {item = "war_club", shards = 6, before = 2, levelBefore = 1}, {item = "sling", shards = 5, before = 12, levelBefore = 2}}}
    }

    dropReveal.Mock = function(a866)
        --[[
          line: 2649
          upvalues:
            v865 (copy, index: 1)
        ]]
        local v867 = v865[a866 or "victory"] or v865.victory
        local values = table.clone(v867)
        values.id = "mock-" .. tostring((a866 or "victory")) .. "-" .. tostring((math.floor(os.clock() * 1000)))
        values.source = "match"
        values.stacks = table.clone(v867.stacks)

        for stackKey, stack in values.stacks do
            local values2 = table.clone(stack)
            values2.after = values2.before + values2.shards
            values.stacks[stackKey] = values2
        end

        return values
    end

    a17.Debug.reveal = function(a872, a873, a874)
        --[[
          line: 2662
          upvalues:
            dropReveal (copy, index: 1)
        ]]
        local v875
        local v876

        if type(a872) ~= "table" then
            local v877
            local mock = dropReveal.Mock

            if type(a872) ~= "string" then
                v877 = "victory"
            else
                v877 = a872
            end

            v875 = mock(v877)
        else
            v875 = a872
        end

        if type(a874) ~= "table" then
            v876 = {}
        else
            v876 = table.clone(a874)
        end

        v876.pace = tonumber(a873) or 1
        v876.source = v876.source or "lobby"

        return dropReveal.Play(v875, v876)
    end

    a17.Debug.revealStop = function()
        --[[
          line: 2669
          upvalues:
            dropReveal (copy, index: 1)
        ]]
        dropReveal.Stop(true)
        return true
    end

    a17.Debug.revealTap = function()
        --[[
          line: 2673
          upvalues:
            tap (copy, index: 1)
            dropReveal (copy, index: 2)
        ]]
        tap()
        return dropReveal.State()
    end

    a17.Debug.revealSkip = function()
        --[[
          line: 2677
          upvalues:
            dropReveal (copy, index: 1)
        ]]
        dropReveal.Skip()
        return dropReveal.State()
    end

    a17.Debug.revealState = function()
        --[[
          line: 2681
          upvalues:
            dropReveal (copy, index: 1)
            v832 (copy, index: 2)
            v829 (copy, index: 3)
        ]]
        local v879 = dropReveal.State()
        v879.queue = #v832
        local seen = {}

        for v881 in v829 do
            table.insert(seen, v881)
        end

        v879.seen = seen

        return v879
    end

    a17.Debug.revealSummary = function(a882)
        --[[
          line: 2691
          upvalues:
            dropReveal (copy, index: 1)
        ]]
        local v883

        if type(a882) ~= "table" then
            local v884
            local mock = dropReveal.Mock

            if type(a882) ~= "string" then
                v884 = "victory"
            else
                v884 = a882
            end

            v883 = mock(v884)
        else
            v883 = a882
        end

        return dropReveal.ShowSummary(v883, {source = "lobby"})
    end
end

return v9