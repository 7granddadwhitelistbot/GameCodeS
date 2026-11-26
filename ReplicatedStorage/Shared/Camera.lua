local contextActionService = game:GetService("ContextActionService")
local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local Spring = require(script:WaitForChild("Spring"))
local Spectate = require(script:WaitForChild("Spectate"))
local Fighters = require(script:WaitForChild("Fighters"))
local Fades = require(script:WaitForChild("Fades"))
local AimAssist = require(script:WaitForChild("AimAssist"))
local SpectateKeys = require(script:WaitForChild("SpectateKeys"))
local Smoothing = require(script:WaitForChild("Smoothing"))
local Occlusion = require(script:WaitForChild("Occlusion"))
local Shoulder = require(script:WaitForChild("Shoulder"))
local FirstPerson = require(script:WaitForChild("FirstPerson"))
local Guards = require(script:WaitForChild("Guards"))
local Simulation = require(script.Parent:WaitForChild("Simulation"))
local Finite = require(script:WaitForChild("Finite"))
Finite.Authority = tostring(Simulation.Authority)
local Keybinds = require(script.Parent:WaitForChild("Keybinds"))
local v21 = {}
local minValue = -1.3962634015954636
local maxValue = 1.361356816555577
v21.PadLook = require(script:WaitForChild("PadLook"))
local v24 = runService:IsClient() and not runService:IsServer()
local localPlayer = players.LocalPlayer
local v26 = 0
local v27 = -0.20943951023931956
local v28 = false
local clampedValue = 50
local fieldOfView2 = 70
local clampedValue2 = 10.5
local clampedValue3 = 1
local v33 = {zoom = 1, sens = 1, fovNow = nil}
local v34 = true
local v35 = false
local unlockReasons = {}
local lookLocks = {}
local v38 = {}
local v39 = {}
local v40 = {}
local spring = Spring.new(70, 3.2, 1)
local spring2 = Spring.new(10.5, 3.5, 1)
local spring3 = Spring.new(Vector3.new(0, 0, 0), 4, 1)
local spring4 = Spring.new(0, 5, 1)
local spring5 = Spring.new(0, 3.2, 0.45)
local spring6 = Spring.new(Vector3.new(0, 0, 0), 5, 0.75)
local v47 = {time = 0, max = 0, frames = 0, touchLookPx = 0, touchesIgnored = 0, since = os.clock()}
local v48 = {ignoreBuilt = 0, reconcile = 0, deathSpot = 0, headFade = 0, propFadeFrame = 0}
local v49 = false
local v50 = nil
local v51 = {blend = 0, target = 0, startedAt = 0}
local v52 = 1.6666666666666667
local character = nil
local v54 = CFrame.new()
local v55 = 70
local v56 = nil
local v57 = nil
local v58 = false
local v59 = false
local v60 = false
local v61 = false
local cFrame = nil
local fieldOfView = 70
local v64 = 1
local position = nil
local v66 = false
local vector2 = Vector2.zero
local v68 = Vector2.zero
local touches = {}
local magnitude = nil
local v71 = "none"
local v72 = CFrame.new()
local v73 = 70
local v74 = nil
local v75 = nil
local v76 = 70
local v77 = 1
local v78 = CFrame.new()
local v79 = 70
local target4 = nil

do
    local function wrapAngle(a82)
        --[[
          name: wrapAngle
          line: 195
        ]]
        return ((a82 + math.pi) % math.tau) - math.pi
    end
end

local InputStats = nil

local v84 = function(a85: number, a86: boolean?)
    --[[
      line: 203
      upvalues:
        InputStats (ref,  index: 1)
        localPlayer (copy, index: 2)
    ]]
    if not InputStats then
        local core = localPlayer
            and localPlayer:FindFirstChild("PlayerScripts")
            and localPlayer.PlayerScripts:FindFirstChild("Core")
        local inputStats = core and core:FindFirstChild("InputStats")

        if not inputStats or not inputStats:IsA("ModuleScript") then
            return
        end

        local inputStats2 = inputStats
        InputStats = require(inputStats2)
    end

    if a86 then
        InputStats.Note(a85)
        return
    end

    InputStats.Caller(a85)
end

local v90 = 0
local v91 = -0.2
local v92 = 0
local v93 = -0.2
local v94 = 0
local v95 = -0.2
local v96 = 0
local v97 = -0.2
local v98 = 0
local v99 = -0.2
local v100 = 0
local v101 = -0.2
local v102 = 0
local v103 = -0.2
local v104 = {minValue, maxValue}

local v105 = function()
    --[[
      line: 233
      upvalues:
        v100 (ref,  index: 1)
        v99 (ref,  index: 2)
        v96 (ref,  index: 3)
        v103 (ref,  index: 4)
        v95 (ref,  index: 5)
        v90 (ref,  index: 6)
        maxValue (ref,  index: 7)
        v104 (copy, index: 8)
        v91 (ref,  index: 9)
        v97 (ref,  index: 10)
        v102 (ref,  index: 11)
        v92 (ref,  index: 12)
        minValue (ref,  index: 13)
        v93 (ref,  index: 14)
        v94 (ref,  index: 15)
        v98 (ref,  index: 16)
        v101 (ref,  index: 17)
        v84 (copy, index: 18)
    ]]
    if v100 ~= 0
        or v99 ~= -0.2
        or v96 ~= 0
        or v103 ~= -0.2
        or v95 ~= -0.2
        or v90 ~= 0
        or maxValue ~= v104[2]
        or v91 ~= -0.2
        or v97 ~= -0.2
        or v102 ~= 0
        or v92 ~= 0
        or minValue ~= v104[1]
        or v93 ~= -0.2
        or v94 ~= 0
        or v98 ~= 0
        or v101 ~= -0.2
    then
        v90 = 0
        v91 = -0.2
        v92 = 0
        v93 = -0.2
        v94 = 0
        v95 = -0.2
        v96 = 0
        v97 = -0.2
        v98 = 0
        v99 = -0.2
        v100 = 0
        v101 = -0.2
        v102 = 0
        v103 = -0.2
        local v106 = v104[1]
        local v107 = v104[2]
        minValue = v106
        maxValue = v107
        v84(256, true)
    end
end

function v21.SetLook(a108, a109: number)
    --[[
      name: SetLook
      line: 264
      upvalues:
        v84 (copy, index: 1)
        v61 (ref,  index: 4)
        v60 (ref,  index: 5)
        minValue (ref,  index: 10)
        maxValue (ref,  index: 11)
        v26 (ref,  index: 20)
        v27 (ref,  index: 21)
    ]]
    v84(32768)
    v61 = v60
    local minValue2 = minValue
    local maxValue2 = maxValue
    v26 = ((a108 + math.pi) % math.tau) - math.pi

    if a109 then
        v27 = math.clamp(a109, minValue2, maxValue2)
    end
end

do
    local function smoothstep(a113: number)
        --[[
          name: smoothstep
          line: 278
        ]]
        local clampedValue = math.clamp(a113, 0, 1)
        return clampedValue * clampedValue * (3 - (clampedValue * 2))
    end
end

local v115 = {amount = 0, t0 = 0, rise = 0.05, fall = 0.2}

local function fovKickNow()
    --[[
      name: fovKickNow
      line: 286
      upvalues:
        v115 (copy, index: 1)
    ]]
    if v115.amount == 0 then
        return 0
    end

    local v117 = os.clock() - v115.t0

    if v117 < v115.rise then
        local amount = v115.amount
        local clampedValue = math.clamp(v117 / v115.rise, 0, 1)

        return amount * (clampedValue * clampedValue * (3 - (clampedValue * 2)))
    end

    local v120 = (v117 - v115.rise) / v115.fall

    if 1 <= v120 then
        v115.amount = 0
        return 0
    end

    local amount = v115.amount
    local clampedValue = math.clamp(v120, 0, 1)

    return amount * (1 - (clampedValue * clampedValue * (3 - (clampedValue * 2))))
end

do
    local function isMouseUnlocked()
        --[[
          name: isMouseUnlocked
          line: 303
          upvalues:
            unlockReasons (copy, index: 1)
            guiService (copy, index: 2)
        ]]
        return next(unlockReasons) ~= nil or guiService.MenuIsOpen
    end
end

do
    local function combatModeOn()
        --[[
          name: combatModeOn
          line: 309
          upvalues:
            localPlayer (copy, index: 1)
        ]]
        local combatMode = localPlayer:GetAttribute("CombatMode")
        if combatMode == nil then
            return localPlayer:GetAttribute("State") == "Match"
        end

        return combatMode == true
    end
end

do
    local function getCharacterParts()
        --[[
          name: getCharacterParts
          line: 317
          upvalues:
            localPlayer (copy, index: 1)
        ]]
        local character = localPlayer and localPlayer.Character
        if not character then
            return nil, nil, nil
        end

        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart2 = humanoidRootPart and humanoidRootPart:IsA("BasePart") and humanoidRootPart or nil

        return character, humanoidRootPart2, humanoid
    end
end

do
    local function yawOf(a132)
        --[[
          name: yawOf
          line: 327
        ]]
        local lookVector = a132.LookVector
        return (math.atan2(-lookVector.X, -lookVector.Z))
    end
end

do
    local function drawnCharacter(a135)
        --[[
          name: drawnCharacter
          line: 334
          upvalues:
            Smoothing (copy, index: 1)
        ]]
        return Smoothing.DrawnModel() or a135
    end
end

local v136 = {}
local v137 = true
local v138 = nil
local v139 = true
local childNames = {"FX", "Projectiles"}

local function markIgnoreDirty()
    --[[
      name: markIgnoreDirty
      line: 347
      upvalues:
        v137 (ref, index: 1)
    ]]
    v137 = true
end

local function ignoreList(a143)
    --[[
      name: ignoreList
      line: 351
      upvalues:
        v137 (ref,  index: 1)
        v138 (ref,  index: 2)
        v48 (copy, index: 3)
        v136 (copy, index: 4)
        childNames (copy, index: 5)
        workspace (copy, index: 6)
        players (copy, index: 7)
        Fighters (copy, index: 8)
        Occlusion (copy, index: 9)
        v139 (ref,  index: 10)
    ]]
    local timestamp = os.clock()

    if v137 or a143 ~= v138 or 2 < timestamp - v48.ignoreBuilt then
        table.clear(v136)

        if a143 then
            table.insert(v136, a143)
        end

        for _, childName in childNames do
            if const child = workspace:FindFirstChild(childName) then
                table.insert(v136, child)
            end
        end

        for _, player in players:GetPlayers() do
            if player.Character and player.Character ~= a143 then
                table.insert(v136, player.Character)
            end
        end

        Fighters.EachTagged(
            function(a150)
                --[[
                  line: 369
                  upvalues:
                    a143 (copy, index: 1)
                    v136 (copy, index: 2)
                ]]
                if a150 ~= a143 then
                    table.insert(v136, a150)
                end
            end
        )

        v137 = false
        v138 = a143
        v48.ignoreBuilt = timestamp
        Occlusion.IgnoreChanged()
        v139 = true
    end

    return v136
end

do
    local function watchPlayerForIgnore(a152)
        --[[
          name: watchPlayerForIgnore
          line: 383
          upvalues:
            markIgnoreDirty (copy, index: 1)
        ]]
        a152.CharacterAdded:Connect(markIgnoreDirty)
        a152.CharacterRemoving:Connect(markIgnoreDirty)
    end
end

do
    local function castDistance(a154, a155, a156)
        --[[
          name: castDistance
          line: 390
          upvalues:
            Occlusion (copy, index: 1)
        ]]
        return Occlusion.Cast(a154, a155, a156)
    end
end

local v157 = {}
local v158 = true
local v159 = {}
local v160 = -1
local v161 = -1
local v162 = false
local firstPerson = false
local bindableEvent = Instance.new("BindableEvent")
local v165 = nil

local function isHeadAccessoryPart(descendant, head)
    --[[
      name: isHeadAccessoryPart
      line: 407
    ]]
    for _, child in descendant:GetChildren() do
        if child:IsA("Attachment") and head:FindFirstChild(child.Name) then
            return true
        end
    end

    return false
end

local function rebuildFadeEntries(a172)
    --[[
      name: rebuildFadeEntries
      line: 417
      upvalues:
        v157 (copy, index: 1)
        isHeadAccessoryPart (copy, index: 2)
        v158 (ref,  index: 3)
    ]]
    table.clear(v157)
    local head = a172:FindFirstChild("Head")

    for _, inst in a172:GetDescendants() do
        local head2
        local v177, v178, v179 = false, false, false

        if inst:IsA("BasePart") then
            v177 = true
        elseif inst:IsA("Decal") then
            v177 = true
        end

        if v177 then
            head2 = false

            if head then
                if head:IsA("BasePart") then
                    if inst == head then
                        v178 = true
                    elseif inst.Parent ~= head then
                        if inst:IsA("BasePart") and inst.Parent and inst.Parent:IsA("Accessory") then
                            head2 = isHeadAccessoryPart(inst, head)
                        end

                        v179 = true
                    else
                        v178 = true
                    end
                else
                    v179 = true
                end
            else
                v179 = true
            end
        end

        if v178 then
            head2 = true
            v179 = true
        end

        if v179 then
            table.insert(v157, {inst = inst, head = head2})
        end
    end

    v158 = false
end

do
    local function restoreAll(a181)
        --[[
          name: restoreAll
          line: 436
        ]]
        for _, v183 in a181 do
            local inst = v183.inst

            if inst.Parent and inst.LocalTransparencyModifier ~= 0 then
                inst.LocalTransparencyModifier = 0
            end
        end
    end
end

local function setCharacterFade(characterFade, a187, a188, a189: boolean?)
    --[[
      name: setCharacterFade
      line: 451
      upvalues:
        v165 (ref,  index: 1)
        v157 (copy, index: 2)
        v159 (copy, index: 3)
        v158 (ref,  index: 4)
        v160 (ref,  index: 5)
        v161 (ref,  index: 6)
        v162 (ref,  index: 7)
        rebuildFadeEntries (copy, index: 8)
        v48 (copy, index: 9)
    ]]
    if a187 < 0.01 then
        a187 = 0
    end

    local v190 = math.max(a187, (a188 or 0))

    if v190 < 0.01 then
        v190 = 0
    end

    if characterFade ~= v165 then
        for _, v192 in v157 do
            local inst = v192.inst

            if inst.Parent and inst.LocalTransparencyModifier ~= 0 then
                inst.LocalTransparencyModifier = 0
            end
        end

        for _, v195 in v159 do
            v195:Disconnect()
        end

        table.clear(v159)
        table.clear(v157)
        v165 = characterFade
        v158 = true
        v160 = -1
        v161 = -1
        v162 = false

        if characterFade then
            table.insert(
                v159,
                characterFade.DescendantAdded:Connect(
                    function(a196)
                        --[[
                          line: 471
                          upvalues:
                            v158 (ref, index: 1)
                            v162 (ref, index: 2)
                            v160 (ref, index: 3)
                        ]]
                        v158 = true

                        if a196:IsA("BasePart") or a196:IsA("Decal") then
                            a196.LocalTransparencyModifier = v162 and 1 or math.max(v160, 0)
                        end
                    end
                )
            )

            table.insert(
                v159,
                characterFade.DescendantRemoving:Connect(
                    function()
                        --[[
                          line: 478
                          upvalues:
                            v158 (ref, index: 1)
                        ]]
                        v158 = true
                    end
                )
            )
        end
    end

    if not characterFade then
        return
    end

    local v197 = v158

    if v158 then
        rebuildFadeEntries(characterFade)
    end

    local timestamp = os.clock()
    local v199 = v197 or 0.25 < timestamp - v48.reconcile
    local v200, v201 = false, false
    local v202 = true

    if not (0.02 <= math.abs(a187 - v160)) then
        v202 = true

        if not (0.02 <= math.abs(v190 - v161)) then
            if a187 ~= 0 then
                v200 = true
            else
                v202 = true

                if v160 == 0 then
                    v200 = true
                end
            end
        end
    end

    if v200 then
        if v190 ~= 0 then
            v201 = true
        else
            v202 = true

            if v161 == 0 then
                v201 = true
            end
        end
    end

    if v201 then
        v202 = a189 == true ~= v162
    end

    if not v199 and not v202 then
        return
    end

    v48.reconcile = timestamp
    v160 = a187
    v161 = v190
    v162 = a189 == true

    for _, v204 in v157 do
        local inst = v204.inst

        if inst.Parent then
            local localTransparencyModifier = v162 and 1 or (if v204.head then v190 else a187)

            if not (0.001 < math.abs(inst.LocalTransparencyModifier - localTransparencyModifier)) then
                continue
            end

            inst.LocalTransparencyModifier = localTransparencyModifier
        end
    end
end

local v207 = {}
local v208 = {High = 1, Medium = 2, Low = 4}
local v209 = 1
local v210 = {}
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Exclude

do
    local function clearPropFade()
        --[[
          name: clearPropFade
          line: 524
          upvalues:
            v207 (copy, index: 1)
        ]]
        for v213 in v207 do
            if v213.Parent then
                v213.LocalTransparencyModifier = 0
            end
        end

        table.clear(v207)
    end
end

local function boxDistance(a215, position)
    --[[
      name: boxDistance
      line: 533
    ]]
    local objectSpacePosition = a215.CFrame:PointToObjectSpace(position)
    local v218 = a215.Size * 0.5

    return Vector3.new(math.max(math.abs(objectSpacePosition.X) - v218.X, 0), math.max(math.abs(objectSpacePosition.Y) - v218.Y, 0), (math.max(math.abs(objectSpacePosition.Z) - v218.Z, 0))).Magnitude
end

local function propFadeable(a220)
    --[[
      name: propFadeable
      line: 542
    ]]
    if 1 <= a220.Transparency or a220:HasTag("Foliage") or 80 <= a220.Size.Magnitude then
        return false
    end

    local size = a220.Size

    if 6 <= math.max(math.min(size.X, size.Y), (math.min(math.max(size.X, size.Y), size.Z))) then
        return false
    end

    local firstAncestorWhichIsA = a220:FindFirstAncestorWhichIsA("Model")

    while firstAncestorWhichIsA do
        if firstAncestorWhichIsA:FindFirstChildOfClass("Humanoid") then
            return false
        end
        if firstAncestorWhichIsA:HasTag("BearTrap") then
            return false
        end

        firstAncestorWhichIsA = firstAncestorWhichIsA:FindFirstAncestorWhichIsA("Model")
    end

    return true
end

do
    local function markProp(key)
        --[[
          name: markProp
          line: 561
          upvalues:
            v210 (copy, index: 1)
            v207 (copy, index: 2)
        ]]
        v210[key] = true

        if not v207[key] then
            v207[key] = true
            key.LocalTransparencyModifier = 0.7
        end
    end
end

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local function updatePropFade(position2, a228, filterDescendantsInstances)
    --[[
      name: updatePropFade
      line: 574
      upvalues:
        v139 (ref,  index: 1)
        overlapParams (copy, index: 2)
        v210 (copy, index: 3)
        workspace (copy, index: 4)
        propFadeable (copy, index: 5)
        boxDistance (copy, index: 6)
        v207 (copy, index: 7)
        raycastParams (copy, index: 8)
        Occlusion (copy, index: 9)
    ]]
    if v139 then
        overlapParams.FilterDescendantsInstances = filterDescendantsInstances
        v139 = false
    end

    table.clear(v210)
    local success, partBoundsInRadius = pcall(
        function()
            --[[
              line: 580
              upvalues:
                workspace (copy, index: 1)
                position2 (copy, index: 2)
                overlapParams (copy, index: 3)
            ]]
            return workspace:GetPartBoundsInRadius(position2, 4.2, overlapParams)
        end
    )
    if success then
        for _, v233 in partBoundsInRadius do
            local v234 = v233.Position.Y + v233.Size.Y / 2

            if position2.Y - 1 < v234 then
                if not propFadeable(v233) then
                    continue
                end

                local v235 = boxDistance(v233, position2)
                local v236 = v207[v233] and 0.7 or 0

                if not (v235 <= v236 + 3.5) then
                    continue
                end

                v210[v233] = true

                if v207[v233] then
                    continue
                end

                v207[v233] = true
                v233.LocalTransparencyModifier = 0.7
            end
        end
    end

    if a228 then
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances
        local position = position2

        for _ = 1, 4 do
            local direction = a228 - position

            if direction.Magnitude < 0.05 then
                break
            end

            local raycastResult = workspace:Raycast(position, direction, raycastParams)
            if not raycastResult then
                break
            end

            local instance = raycastResult.Instance

            if not instance:IsA("BasePart") or Occlusion.Classify(instance) ~= 2 or not propFadeable(instance) then
                raycastParams:AddToFilter(instance)
                position = raycastResult.Position
            else
                v210[instance] = true

                if not v207[instance] then
                    v207[instance] = true
                    instance.LocalTransparencyModifier = 0.7
                end

                raycastParams:AddToFilter(instance)
                position = raycastResult.Position
            end
        end
    end

    for v242 in v207 do
        if not v210[v242] then
            v207[v242] = nil

            if not v242.Parent then
                continue
            end

            v242.LocalTransparencyModifier = 0
        end
    end
end

local function totalModifier()
    --[[
      name: totalModifier
      line: 623
      upvalues:
        v39 (copy, index: 1)
    ]]
    local total = 0
    local total2 = 0
    local v246 = Vector3.new(0, 0, 0)
    local v247 = 1

    for _, v249 in v39 do
        total += v249.fov or 0
        total2 += v249.distance or 0
        v246 += v249.pivot or Vector3.new(0, 0, 0)
        v247 *= v249.sensitivity or 1
    end

    return total, total2, v246, v247
end

local function applyMouseBehavior()
    --[[
      name: applyMouseBehavior
      line: 634
      upvalues:
        v34 (ref,  index: 1)
        v60 (ref,  index: 2)
        unlockReasons (copy, index: 3)
        guiService (copy, index: 4)
        userInputService (copy, index: 5)
    ]]
    if not v34 or v60 then
        return
    end

    local v251 = next(unlockReasons) ~= nil or guiService.MenuIsOpen

    if v251 then
        if userInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            userInputService.MouseBehavior = Enum.MouseBehavior.Default
        end

        if not userInputService.MouseIconEnabled then
            userInputService.MouseIconEnabled = true
        end
    else
        if userInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
            userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end

        if userInputService.MouseIconEnabled then
            userInputService.MouseIconEnabled = false
        end
    end
end

local v252 = {}
v252[Enum.HumanoidStateType.Running] = true
v252[Enum.HumanoidStateType.RunningNoPhysics] = true
v252[Enum.HumanoidStateType.Jumping] = true
v252[Enum.HumanoidStateType.Freefall] = true
v252[Enum.HumanoidStateType.Landed] = true
v252[Enum.HumanoidStateType.GettingUp] = true

do
    local function releaseAutoRotate(a254)
        --[[
          name: releaseAutoRotate
          line: 668
          upvalues:
            v58 (ref,  index: 1)
            v59 (ref,  index: 2)
            Simulation (copy, index: 3)
        ]]
        v58 = false

        if v59 then
            Simulation.SetFacing(nil)
            v59 = false
        end
    end
end

local function updateCharacterRotation(a256: number, humanoidRootPart, humanoid: Humanoid?, a259: boolean)
    --[[
      name: updateCharacterRotation
      line: 676
      upvalues:
        v38 (copy, index: 1)
        v252 (copy, index: 2)
        v58 (ref,  index: 3)
        v59 (ref,  index: 4)
        Simulation (copy, index: 5)
        Smoothing (copy, index: 6)
        v26 (ref,  index: 7)
        v28 (ref,  index: 8)
        firstPerson (ref,  index: 9)
    ]]
    if a259
        or next(v38) ~= nil
        or not (0 < humanoid.Health)
        or humanoidRootPart.Anchored
        or v252[humanoid:GetState()] ~= true
        or humanoid.Sit ~= false
        or humanoid.PlatformStand ~= false
    then
        v58 = false

        if v59 then
            Simulation.SetFacing(nil)
            v59 = false
        end

        return
    end

    v59 = true
    local _, v261 = Smoothing.SimCFrame(humanoidRootPart):ToEulerAnglesYXZ()
    local v262 = ((v26 - v261) + math.pi) % math.tau - math.pi
    local v263 = 0.05 < humanoid.MoveDirection.Magnitude
    local v264 = humanoidRootPart.Parent ~= nil and humanoidRootPart.Parent:FindFirstChildOfClass("Tool") ~= nil
    local v265 = v263 or v264 or v28 or firstPerson

    if v265 then
        v58 = false
    else
        if 1.7453292519943295 < math.abs(v262) then
            v58 = true
        end

        if v58 and math.abs(v262) < 0.06981317007977318 then
            v58 = false
        end

        v265 = v58
    end

    if not v265 then
        Simulation.SetFacing(v261)
        return
    end

    local v266 = firstPerson and 40 or v28 and 30 or v264 and 30 or v263 and 18 or 12
    local v267 = v261 + v262 * (1 - math.exp(-v266 * math.max(a256, 0.016666666666666666)))
    Simulation.SetFacing(v267)
end

local v268 = {Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1), Vector3.new(-1, 1, -1), Vector3.new(-1, 1, 1), Vector3.new(1, -1, -1), Vector3.new(1, -1, 1), Vector3.new(1, 1, -1), Vector3.new(1, 1, 1)}

local function headCrowdsCrosshair(camera: Camera?, a271: boolean)
    --[[
      name: headCrowdsCrosshair
      line: 729
      upvalues:
        v157 (copy, index: 1)
        v268 (copy, index: 2)
    ]]
    local vector2 = camera.ViewportSize / 2
    local v273 = a271 and 40 or 16
    local v274 = v273 * math.max(camera.ViewportSize.Y, 200) / 768

    for _, v276 in v157 do
        local inst = v276.inst

        if v276.head then
            if not inst:IsA("BasePart") then
                continue
            end
            if not inst.Parent then
                continue
            end

            local cFrame = inst.CFrame
            local v279 = inst.Size / 2
            local v280 = math.huge
            local v281 = math.huge
            local v282 = -math.huge
            local v283 = -math.huge

            for _, vector3 in v268 do
                local v286 = camera:WorldToViewportPoint(cFrame:PointToWorldSpace(v279 * vector3))

                if 0 < v286.Z then
                    v280 = math.min(v280, v286.X)
                    v282 = math.max(v282, v286.X)
                    v281 = math.min(v281, v286.Y)
                    v283 = math.max(v283, v286.Y)
                end
            end

            if not (v280 <= v282) then
                continue
            end

            local v287 = math.max(v280 - vector2.X, 0, vector2.X - v282)
            local v288 = math.max(v281 - vector2.Y, 0, vector2.Y - v283)

            if not ((v287 * v287) + (v288 * v288) < v274 * v274) then
                continue
            end

            return true
        end
    end

    return false
end

local function frameSubject(a290: number, a291, a292, a293)
    --[[
      name: frameSubject
      line: 761
      upvalues:
        Finite (copy, index: 1)
        v78 (ref,  index: 2)
        v57 (ref,  index: 3)
        v56 (ref,  index: 4)
        spring4 (copy, index: 5)
        Occlusion (copy, index: 6)
        v26 (ref,  index: 7)
        spring6 (copy, index: 8)
        v21 (copy, index: 9)
        v27 (ref,  index: 10)
        spring2 (copy, index: 11)
        spring5 (copy, index: 12)
        spring3 (copy, index: 13)
        Shoulder (copy, index: 14)
        v28 (ref,  index: 15)
    ]]
    local v294

    if not Finite.Vector(a292) then
        return v78, v78.Position + (v78.LookVector * 10)
    end

    if a291 ~= v57 or v56 == nil or 40 < (a292 - v56).Magnitude then
        spring4:Snap(a292.Y)
        Occlusion.Reset()
        v57 = a291
    end

    v56 = a292
    spring4.target = a292.Y
    spring4:Update(a290)
    local clampedValue = math.clamp(spring4.value, a292.Y - 1.5, a292.Y + 1.5)
    spring4.value = clampedValue
    local v296 = CFrame.fromEulerAnglesYXZ(0, v26, 0)
    local v297 = spring6.value + v21.SlowRecoil.value
    local v298 = CFrame.fromEulerAnglesYXZ(v27 + v297.X, v26 + v297.Y, v297.Z)
    local lookVector = v298.LookVector
    local value = spring2.value
    local v301 = Vector3.new(a292.X, (clampedValue + 3.1) + spring5.value, a292.Z) + v296:VectorToWorldSpace(spring3.value)
    local vector3 = Vector3.new(a292.X, a292.Y + 0.5, a292.Z)
    local frame = Occlusion.Frame
    local rightVector = v296.RightVector
    local v305 = Shoulder.Value()

    if v28 then
        v294 = 2.8
    else
        v294 = 2.9
    end

    local v306, v307, v308 = frame(a290, vector3, v301, rightVector, lookVector, v305, value, a293, v294)
    Shoulder.Update(v308, v296.RightVector, 2.9, a293)

    return CFrame.new(v306) * v298.Rotation, v307
end

local function applyShake(a310, a311: number, a312)
    --[[
      name: applyShake
      line: 795
      upvalues:
        v40 (copy, index: 1)
    ]]
    local v313 = 0

    for index = #v40, 1, -1 do
        local v315 = v40[index]
        v315.t += a311
        local t = v315.t

        if v315.duration <= t then
            table.remove(v40, index)
        else
            local v317 = 1 - v315.t / v315.duration
            v313 += (v315.intensity * v317) * v317
        end
    end

    if v313 <= 0 then
        return a310
    end

    v313 = math.min(v313, 3) * (a312 or 1)
    local v318 = os.clock() * 17
    local v319 = v313 * 0.022689280275926284
    local rotationX = math.noise(v318, 0.37, 1.1) * 2 * v319
    local rotationY = math.noise(3.1, v318, 7.3) * 2 * v319
    local rotationZ = math.noise(9.2, 4.4, v318) * 1.2 * v319
    local x = math.noise(v318, 11.3, 2.9) * 0.12 * v313
    local y = math.noise(5.5, v318, 13.7) * 0.12 * v313

    return a310 * CFrame.new(x, y, 0) * CFrame.Angles(rotationX, rotationY, rotationZ)
end

local function focusPointOf(killer)
    --[[
      name: focusPointOf
      line: 821
    ]]
    local head = killer:FindFirstChild("Head")

    if head and head:IsA("BasePart") then
        return head.Position - Vector3.new(0, 0.6000000238418579, 0)
    end

    local humanoidRootPart = killer:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
        return humanoidRootPart.Position + Vector3.new(0, 1, 0)
    end

    return nil
end

local overlapParams2 = OverlapParams.new()
overlapParams2.FilterType = Enum.RaycastFilterType.Exclude
overlapParams2.RespectCanCollide = true

do
    local function spotIsFree(position: Vector3, filterDescendantsInstances)
        --[[
          name: spotIsFree
          line: 837
          upvalues:
            overlapParams2 (copy, index: 1)
            workspace (copy, index: 2)
        ]]
        overlapParams2.FilterDescendantsInstances = filterDescendantsInstances
        local success, partBoundsInRadius = pcall(
            function()
                --[[
                  line: 839
                  upvalues:
                    workspace (copy, index: 1)
                    position (copy, index: 2)
                    overlapParams2 (copy, index: 3)
                ]]
                return workspace:GetPartBoundsInRadius(position, 0.6, overlapParams2)
            end
        )

        return success and (#partBoundsInRadius == 0)
    end
end

local v335 = nil
local v336 = nil

do
    local function sees(a338, a339, filterDescendantsInstances)
        --[[
          name: sees
          line: 851
          upvalues:
            Occlusion (copy, index: 1)
        ]]
        local v341 = Occlusion.Cast(a338, a339, filterDescendantsInstances)
        return ((a339 - a338).Magnitude - 0.5) <= v341
    end
end

local function pickDeathSpot(position2, a344, filterDescendantsInstances)
    --[[
      name: pickDeathSpot
      line: 855
      upvalues:
        v336 (ref,  index: 1)
        Occlusion (copy, index: 2)
        overlapParams2 (copy, index: 3)
        workspace (copy, index: 4)
        sees (copy, index: 5)
    ]]
    local vector3
    local v347 = v336

    if v347 and sees(v347, a344, filterDescendantsInstances) then
        return v347
    end

    local vector32 = Vector3.new(position2.X - a344.X, 0, position2.Z - a344.Z)

    if not (0.1 < vector32.Magnitude) then
        vector3 = Vector3.new(0, 0, 1)
    else
        vector3 = vector32.Unit
    end

    for v349, position in {position2, position2 + Vector3.new(0, 7, 0), position2 + Vector3.new(0, 14, 0), (a344 + (vector3 * 16)) + Vector3.new(0, 8, 0), (a344 + (vector3 * 11)) + Vector3.new(0, 4, 0), (a344 + (vector3 * 14)) + Vector3.new(0, 18, 0)} do
        local v351 = Occlusion.Cast(position, a344, filterDescendantsInstances)
        local success, partBoundsInRadius, v354
        local v355, v356 = false, false

        if ((a344 - position).Magnitude - 0.5) <= v351 then
            if v349 == 1 then
                v356 = true
            else
                overlapParams2.FilterDescendantsInstances = filterDescendantsInstances
                success, partBoundsInRadius = pcall(
                    function()
                        --[[
                          line: 839
                          upvalues:
                            workspace (copy, index: 1)
                            position (copy, index: 2)
                            overlapParams2 (copy, index: 3)
                        ]]
                        return workspace:GetPartBoundsInRadius(position, 0.6, overlapParams2)
                    end
                )
                v354 = success
                v354 = v354 and #partBoundsInRadius == 0
                v355 = true
            end
        end

        if v355 and v354 then
            v356 = true
        end

        if v356 then
            return position
        end
    end

    return position2 + Vector3.new(0, 10, 0)
end

local function deathView(a358: number)
    --[[
      name: deathView
      line: 881
      upvalues:
        Spectate (copy, index: 1)
        v72 (ref,  index: 2)
        focusPointOf (copy, index: 3)
        fieldOfView2 (ref,  index: 4)
        v336 (ref,  index: 5)
        v48 (copy, index: 6)
        pickDeathSpot (copy, index: 7)
        ignoreList (copy, index: 8)
        localPlayer (copy, index: 9)
        v335 (ref,  index: 10)
        v74 (ref,  index: 11)
        v73 (ref,  index: 12)
    ]]
    local targetValue
    local targetValue2
    local clampedValue = math.clamp(Spectate.DeathElapsed() / 0.35, 0, 1)
    local alpha = clampedValue * clampedValue * (3 - (clampedValue * 2))
    local v363 = v72
    local killer = Spectate.GetKiller()

    if killer and killer.Parent then
        targetValue = focusPointOf(killer)
    else
        targetValue = nil
    end

    local clampedValue2 = fieldOfView2

    if targetValue then
        local timestamp = os.clock()

        if v336 == nil or 0.25 < timestamp - v48.deathSpot then
            v48.deathSpot = timestamp
            v336 = pickDeathSpot(v363.Position, targetValue, (ignoreList(localPlayer.Character)))
        end

        targetValue2 = v336
    else
        targetValue2 = v363.Position + Vector3.new(0, 3, 0)
        targetValue = Spectate.GetDeathPosition() or v363.Position + v363.LookVector * 10
    end

    if v335 == nil then
        v335 = v363.Position
    end

    local v367 = v335
    v335 = v367:Lerp(targetValue2, 1 - math.exp(a358 * -5))
    local v368 = v335

    if killer and killer.Parent then
        clampedValue2 = math.clamp(math.deg((math.atan(9 / math.max((targetValue - v368).Magnitude, 1)))) * 2, 35, fieldOfView2)
    end

    if v74 ~= nil then
        local startValue = v74
        v74 = startValue:Lerp(targetValue, 1 - math.exp(a358 * -8))
    else
        v74 = targetValue
    end

    local v370 = v74
    local v371 = if 0.1 < (v370 - v368).Magnitude then CFrame.lookAt(v368, v370) else CFrame.new(v368) * v363.Rotation

    return v363.Rotation:Lerp(v371.Rotation, alpha) + v368, v73 + ((clampedValue2 - v73) * alpha)
end

function v33.fovNow()
    --[[
      name: fovNow
      line: 925
      upvalues:
        clampedValue (ref,  index: 1)
        fieldOfView2 (ref,  index: 2)
        v33 (copy, index: 3)
    ]]
    if fieldOfView2 <= clampedValue then
        return clampedValue
    end

    return clampedValue + ((fieldOfView2 - clampedValue) * (1 - v33.zoom))
end

local function readLookInput(a373: number, a374: boolean, a375)
    --[[
      name: readLookInput
      line: 932
      upvalues:
        clampedValue3 (ref,  index: 1)
        v28 (ref,  index: 2)
        v33 (copy, index: 3)
        fieldOfView2 (ref,  index: 4)
        userInputService (copy, index: 5)
        v26 (ref,  index: 6)
        v27 (ref,  index: 7)
        v68 (ref,  index: 8)
        AimAssist (copy, index: 9)
        v21 (copy, index: 10)
        vector2 (ref,  index: 11)
        localPlayer (copy, index: 12)
        ignoreList (copy, index: 13)
        v39 (copy, index: 14)
        v47 (copy, index: 15)
        maxValue (ref,  index: 16)
        minValue (ref,  index: 17)
    ]]
    local v376 = clampedValue3 * a375

    if v28 then
        v376 *= math.clamp(v33.fovNow() / fieldOfView2, 0.35, 1) * v33.sens
    end

    if not a374 then
        if userInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
            and userInputService:GetLastInputType() ~= Enum.UserInputType.Touch
        then
            local mouseDelta = userInputService:GetMouseDelta()
            local v378 = 0.006283185307179587 * v376
            v26 -= (mouseDelta.X * v378)
            v27 -= (mouseDelta.Y * v378)
        end

        v68 += AimAssist.TakeInjected()
        local v379, v380 = v21.PadLook.Step(vector2, a373, v28)
        local v381 = v379 * (v376 / clampedValue3)
        local v382 = v380 * (v376 / clampedValue3)
        local v383 = v381 - (v68.X * 0.01745) * v376
        local v384 = (-v68.Y * 0.01745) * 0.66 * v376

        if 0 < v384 * v27 then
            v384 *= ((1 - ((math.min(math.abs(v27), 1.5707963267948966) * 2 / math.pi) ^ 0.75)) * 0.75) + 0.25
        end

        local v385 = v382 + v384
        local apply = AimAssist.Apply
        local v387 = v26
        local v388 = v27
        local combatMode = localPlayer:GetAttribute("CombatMode")
        local v390 = if combatMode == nil then localPlayer:GetAttribute("State") == "Match" else combatMode == true
        local v391 = ignoreList(localPlayer.Character)
        local v392 = v28
        local v393 = v33.fovNow()
        local v394, v395 = apply(a373, v383, v385, v387, v388, v390, v391, v392, v393, v39.CombatDraw ~= nil)
        v26 += v394
        v27 += v395
        v47.touchLookPx += (math.abs(v68.X) + math.abs(v68.Y))
    end

    v68 = Vector2.zero
    v26 = ((v26 + math.pi) % math.tau) - math.pi
    local v396 = maxValue

    for _, v398 in v39 do
        if v398.maxPitch then
            if not (v398.maxPitch < v396) then
                continue
            end

            v396 = v398.maxPitch
        end
    end

    if v396 < v27 then
        v27 += ((v396 - v27) * (1 - math.exp(a373 * -5)))
    end

    v27 = math.clamp(v27, minValue, maxValue)
end

do
    local function resetToOwnCharacter()
        --[[
          name: resetToOwnCharacter
          line: 982
          upvalues:
            localPlayer (copy, index: 1)
            v26 (ref,  index: 2)
            v27 (ref,  index: 3)
            v56 (ref,  index: 4)
            v57 (ref,  index: 5)
            v74 (ref,  index: 6)
            v75 (ref,  index: 7)
            v77 (ref,  index: 8)
            target4 (ref,  index: 9)
        ]]
        local humanoidRootPart

        if const character = localPlayer and localPlayer.Character then
            local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
            character:FindFirstChildOfClass("Humanoid")
            humanoidRootPart = humanoidRootPart2 and humanoidRootPart2:IsA("BasePart") and humanoidRootPart2 or nil
        else
            humanoidRootPart = nil
        end

        if humanoidRootPart then
            local lookVector = humanoidRootPart.CFrame.LookVector
            v26 = math.atan2(-lookVector.X, -lookVector.Z)
            v27 = -0.20943951023931956
        end

        v56 = nil
        v57 = nil
        v74 = nil
        v75 = nil
        v77 = 1
        target4 = nil
    end
end

local function setLobby(a405: boolean, camera: Camera?, cameraSubject: Humanoid?)
    --[[
      name: setLobby
      line: 999
      upvalues:
        v60 (ref,  index: 1)
        localPlayer (copy, index: 2)
        v66 (ref,  index: 3)
        cFrame (ref,  index: 4)
        fieldOfView (ref,  index: 5)
        v64 (ref,  index: 6)
        position (ref,  index: 7)
        v21 (copy, index: 8)
        v28 (ref,  index: 9)
        v40 (copy, index: 10)
        spring6 (copy, index: 11)
        spring5 (copy, index: 12)
        v58 (ref,  index: 13)
        v59 (ref,  index: 14)
        Simulation (copy, index: 15)
        v165 (ref,  index: 16)
        v157 (copy, index: 17)
        v159 (copy, index: 18)
        v158 (ref,  index: 19)
        v160 (ref,  index: 20)
        v161 (ref,  index: 21)
        v162 (ref,  index: 22)
        v207 (copy, index: 23)
        userInputService (copy, index: 24)
        v26 (ref,  index: 25)
        v27 (ref,  index: 26)
        v56 (ref,  index: 27)
        v57 (ref,  index: 28)
    ]]
    local humanoidRootPart
    v60 = a405

    if const character = localPlayer and localPlayer.Character then
        local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
        character:FindFirstChildOfClass("Humanoid")
        humanoidRootPart = humanoidRootPart2 and humanoidRootPart2:IsA("BasePart") and humanoidRootPart2 or nil
    else
        humanoidRootPart = nil
    end

    if v66 then
        local cFrame2 = camera.CFrame
        local fieldOfView2 = camera.FieldOfView
        cFrame = cFrame2
        fieldOfView = fieldOfView2
        v64 = 0
        position = humanoidRootPart and humanoidRootPart.Position
    end

    v21.PopMouseUnlock("FreeCursor")

    if not a405 then
        local lookVector = camera.CFrame.LookVector
        v26 = math.atan2(-lookVector.X, -lookVector.Z)
        v27 = math.clamp(math.asin((math.clamp(lookVector.Y, -1, 1))), -0.6981317007977318, 0.4363323129985824)
        v56 = nil
        v57 = nil
        v58 = false

        return
    end

    v28 = false
    table.clear(v40)
    spring6:Snap(Vector3.new(0, 0, 0))
    v21.SlowRecoil:Snap(Vector3.new(0, 0, 0))
    v21.SlowRecoilStay = Vector3.new(0, 0, 0)
    spring5:Snap(0)
    v58 = false

    if v59 then
        Simulation.SetFacing(nil)
        v59 = false
    end

    local v414 = 0

    if v414 < 0.01 then
        v414 = 0
    end

    local _ = math.max(v414, 0) < 0.01

    if v165 ~= nil then
        for _, v417 in v157 do
            local inst = v417.inst

            if inst.Parent and inst.LocalTransparencyModifier ~= 0 then
                inst.LocalTransparencyModifier = 0
            end
        end

        for _, v420 in v159 do
            v420:Disconnect()
        end

        table.clear(v159)
        table.clear(v157)
        v165 = nil
        v158 = true
        v160 = -1
        v161 = -1
        v162 = false
    end

    for v421 in v207 do
        if v421.Parent then
            v421.LocalTransparencyModifier = 0
        end
    end

    table.clear(v207)

    if cameraSubject and camera.CameraSubject ~= cameraSubject then
        camera.CameraSubject = cameraSubject
    end

    camera.CameraType = Enum.CameraType.Custom
    userInputService.MouseBehavior = Enum.MouseBehavior.Default
    userInputService.MouseIconEnabled = true
end

local function updateLobby(a423: number, camera: Camera?, humanoidRootPart, cameraSubject: Humanoid?)
    --[[
      name: updateLobby
      line: 1035
      upvalues:
        lookLocks (copy, index: 1)
        v68 (ref,  index: 2)
        totalModifier (copy, index: 3)
        spring (copy, index: 4)
        fieldOfView2 (ref,  index: 5)
        v61 (ref,  index: 6)
        v27 (ref,  index: 7)
        v26 (ref,  index: 8)
        v64 (ref,  index: 9)
        cFrame (ref,  index: 10)
        position (ref,  index: 11)
        fieldOfView (ref,  index: 12)
        Smoothing (copy, index: 13)
        Occlusion (copy, index: 14)
        v78 (ref,  index: 15)
        v79 (ref,  index: 16)
        v66 (ref,  index: 17)
    ]]
    if next(lookLocks) ~= nil then
        camera.CameraType = Enum.CameraType.Scriptable
        v68 = Vector2.zero

        return
    end

    if cameraSubject and cameraSubject.Parent and camera.CameraSubject ~= cameraSubject then
        camera.CameraSubject = cameraSubject
    end

    if camera.CameraType == Enum.CameraType.Scriptable then
        camera.CameraType = Enum.CameraType.Custom
    end

    v68 = Vector2.zero
    local v427 = totalModifier()
    spring.target = fieldOfView2 + v427
    spring:Update(a423)
    local fieldOfView3 = math.clamp(spring.value, 20, 110)
    local v429 = camera.CFrame

    if v61 then
        v61 = false
        local position2 = camera.Focus.Position
        local z = math.clamp((v429.Position - position2).Magnitude, 6, 40)
        v429 = CFrame.new(position2) * CFrame.fromEulerAnglesYXZ(v27, v26, 0) * CFrame.new(0, 0, z)
        camera.CFrame = v429
    else
        local lookVector = v429.LookVector
        v26 = math.atan2(-lookVector.X, -lookVector.Z)
        v27 = math.asin((math.clamp(lookVector.Y, -1, 1)))
    end

    if v64 < 1 and cFrame then
        if not humanoidRootPart or not position or not (40 < (humanoidRootPart.Position - position).Magnitude) then
            v64 = math.min(1, v64 + (a423 / 0.5))
            local clampedValue = math.clamp(v64, 0, 1)
            local alpha = clampedValue * clampedValue * (3 - (clampedValue * 2))
            local cFrame2 = cFrame:Lerp(v429, alpha)
            fieldOfView3 = fieldOfView + (fieldOfView3 - fieldOfView) * alpha
            camera.CFrame = cFrame2
        else
            v64 = 1
        end
    end

    local v436 = Smoothing.CameraOffset()

    if v436 ~= Vector3.new(0, 0, 0) then
        camera.CFrame += v436
        camera.Focus += v436
    end

    local cFrame3 = Occlusion.AboveWater(camera.CFrame)

    if cFrame3 ~= camera.CFrame then
        camera.CFrame = cFrame3
    end

    camera.FieldOfView = fieldOfView3
    v78 = cFrame3
    v79 = fieldOfView3
    v66 = true
end

local function update(a439: number)
    --[[
      name: update
      line: 1098
      upvalues:
        Guards (copy, index: 1)
        v34 (ref,  index: 2)
        firstPerson (ref,  index: 3)
        workspace (copy, index: 4)
        localPlayer (copy, index: 5)
        Finite (copy, index: 6)
        v71 (ref,  index: 7)
        Spectate (copy, index: 8)
        v56 (ref,  index: 9)
        v72 (ref,  index: 10)
        v78 (ref,  index: 11)
        v73 (ref,  index: 12)
        v79 (ref,  index: 13)
        v74 (ref,  index: 14)
        v335 (ref,  index: 15)
        v336 (ref,  index: 16)
        v28 (ref,  index: 17)
        v40 (copy, index: 18)
        v75 (ref,  index: 19)
        v76 (ref,  index: 20)
        v77 (ref,  index: 21)
        target4 (ref,  index: 22)
        v26 (ref,  index: 23)
        v27 (ref,  index: 24)
        v57 (ref,  index: 25)
        v21 (copy, index: 26)
        SpectateKeys (copy, index: 27)
        v64 (ref,  index: 28)
        v51 (copy, index: 29)
        v60 (ref,  index: 30)
        setLobby (copy, index: 31)
        updateLobby (copy, index: 32)
        Fades (copy, index: 33)
        Smoothing (copy, index: 34)
        applyMouseBehavior (copy, index: 35)
        unlockReasons (copy, index: 36)
        guiService (copy, index: 37)
        totalModifier (copy, index: 38)
        lookLocks (copy, index: 39)
        readLookInput (copy, index: 40)
        v68 (ref,  index: 41)
        spring (copy, index: 42)
        spring2 (copy, index: 43)
        spring3 (copy, index: 44)
        spring4 (copy, index: 45)
        spring5 (copy, index: 46)
        spring6 (copy, index: 47)
        v33 (copy, index: 48)
        fieldOfView2 (ref,  index: 49)
        clampedValue2 (ref,  index: 50)
        Shoulder (copy, index: 51)
        minValue (ref,  index: 52)
        maxValue (ref,  index: 53)
        deathView (copy, index: 54)
        v58 (ref,  index: 55)
        v59 (ref,  index: 56)
        Simulation (copy, index: 57)
        setCharacterFade (copy, index: 58)
        ignoreList (copy, index: 59)
        frameSubject (copy, index: 60)
        updateCharacterRotation (copy, index: 61)
        FirstPerson (copy, index: 62)
        applyShake (copy, index: 63)
        cFrame (ref,  index: 64)
        position (ref,  index: 65)
        fieldOfView (ref,  index: 66)
        v50 (ref,  index: 67)
        character (ref,  index: 68)
        v52 (ref,  index: 69)
        v54 (ref,  index: 70)
        v55 (ref,  index: 71)
        Occlusion (copy, index: 72)
        fovKickNow (copy, index: 73)
        v66 (ref,  index: 74)
        v48 (copy, index: 75)
        v209 (ref,  index: 76)
        updatePropFade (copy, index: 77)
        headCrowdsCrosshair (copy, index: 78)
        v49 (ref,  index: 79)
    ]]
    local humanoidRootPart, humanoid, character2
    local v443
    Guards.Step()

    if not v34 then
        firstPerson = false
        return
    end

    a439 = if a439 == a439 and 0 < a439 then math.min(a439, 0.1) else 0.016666666666666666
    local camera = workspace.CurrentCamera
    if not camera then
        return
    elseif const character3 = localPlayer and localPlayer.Character then
        local humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")
        local humanoid2 = character3:FindFirstChildOfClass("Humanoid")
        humanoidRootPart = humanoidRootPart2 and humanoidRootPart2:IsA("BasePart") and humanoidRootPart2 or nil
        humanoid, character2 = humanoid2, character3
    else
        humanoidRootPart, humanoid, character2 = nil, nil, nil
    end

    firstPerson = false
    local v448 = if humanoidRootPart then humanoidRootPart.Position else nil

    if v448 and not Finite.Vector(v448) then
        Finite.Say("own root")
        v448 = nil
    end

    local v449 = v71
    local step = Spectate.Step
    local v451 = v448 or v56
    v71 = step(v451)

    if v71 ~= v449 then
        if v71 == "death" then
            v72 = v78
            v73 = v79
            v74 = nil
            v335 = nil
            v336 = nil
            v28 = false
            table.clear(v40)
        elseif v71 == "follow" then
            v75 = v78
            v76 = v79
            v77 = 0
            target4 = nil
        else
            local v452

            if const character4 = localPlayer and localPlayer.Character then
                local humanoidRootPart3 = character4:FindFirstChild("HumanoidRootPart")
                character4:FindFirstChildOfClass("Humanoid")
                v452 = if humanoidRootPart3 and humanoidRootPart3:IsA("BasePart") and humanoidRootPart3 then v443 else nil
            else
                v452 = nil
            end

            if v452 then
                local lookVector = v452.CFrame.LookVector
                v26 = math.atan2(-lookVector.X, -lookVector.Z)
                v27 = -0.20943951023931956
            end

            v56 = nil
            v57 = nil
            v74 = nil
            v75 = nil
            v77 = 1
            target4 = nil
        end

        if v71 ~= "follow" then
            v21.PopMouseUnlock("Spectate")
        else
            v21.PushMouseUnlock("Spectate")
        end

        SpectateKeys.SetActive(v71 == "follow", v21.SpectateNext)
        v64 = 1
    end

    local v456 = false

    if v71 == "none" then
        local combatMode = localPlayer:GetAttribute("CombatMode")
        local v458 = if combatMode == nil then localPlayer:GetAttribute("State") == "Match" else combatMode == true
        v456 = not v458 and v51.target == 0 and v51.blend == 0
    end

    if v456 ~= v60 then
        setLobby(v456, camera, humanoid)
    end

    if v60 then
        updateLobby(a439, camera, humanoidRootPart, humanoid)
        Fades.ClearAllies()
        local v459 = Smoothing.DrawnModel() or character2
        local head = v459 and v459:FindFirstChild("Head")
        local updateDecor = Fades.UpdateDecor
        local position2 = camera.CFrame.Position
        v443 = if head and head:IsA("BasePart") then head.Position else nil
        updateDecor(position2, v443)

        return
    end

    local target2
    local target3
    local v465, v466, v467
    local v468, fieldOfView3

    if camera.CameraType ~= Enum.CameraType.Scriptable then
        camera.CameraType = Enum.CameraType.Scriptable
    end

    applyMouseBehavior()
    local v470 = next(unlockReasons) ~= nil or guiService.MenuIsOpen
    local v471, v472, v473, v474 = totalModifier()

    if v71 ~= "none" or next(lookLocks) ~= nil then
        v68 = Vector2.zero
    else
        readLookInput(a439, v470, v474)
    end

    if not Finite.Number(v26) then
        Finite.Say("yaw")
        v26 = 0
    end

    if not Finite.Number(v27) then
        Finite.Say("pitch")
        v27 = -0.20943951023931956
    end

    Finite.HealSpring(spring, 70, "fov")
    Finite.HealSpring(spring2, 10.5, "distance")
    Finite.HealSpring(spring3, Vector3.new(0, 0, 0), "pivot")
    local healSpring = Finite.HealSpring
    local v476 = not v448 and 0 or v448.Y
    healSpring(spring4, v476, "height")
    Finite.HealSpring(spring5, 0, "dip")
    Finite.HealSpring(spring6, Vector3.new(0, 0, 0), "recoil")
    Finite.HealSpring(v21.SlowRecoil, Vector3.new(0, 0, 0), "slow recoil")
    local v477 = v71 ~= "none"

    if v28 then
        target2 = v33.fovNow()
    else
        target2 = if v477 then fieldOfView2 else fieldOfView2 + v471
    end

    spring.target = target2

    if v28 then
        target3 = math.clamp(50 / v33.fovNow(), 1, 1.6) * 8 + v472
    else
        target3 = v477 and 10.5 or clampedValue2 + v472
    end

    spring2.target = target3
    spring3.target = v477 and Vector3.new(0, 0, 0) or v473
    spring:Update(a439)
    spring2:Update(a439)
    local step2 = Shoulder.Step
    local v479 = v28 and 2.8 or 2.9
    step2(a439, v479)
    spring3:Update(a439)
    spring5:Update(a439)
    spring6:Update(a439)
    local slowRecoil = v21.SlowRecoil
    slowRecoil.target *= math.exp(-a439 / v21.SLOW_RECOIL_FADE)
    slowRecoil:Update(a439)
    local slowRecoilStay = v21.SlowRecoilStay

    if not (1e-05 < slowRecoilStay.Magnitude) then
        v21.SlowRecoilStay = Vector3.new(0, 0, 0)
    else
        local v482 = slowRecoilStay * (1 - math.exp(-a439 * 14))
        v27 = math.clamp(v27 + v482.X, minValue, maxValue)
        v26 = (((v26 + v482.Y) + math.pi) % math.tau) - math.pi
        v21.SlowRecoilStay = slowRecoilStay - v482
    end

    if v71 == "death" then
        local v483, v484 = deathView(a439)
        v465 = v483
        v467 = v465.Position + v465.LookVector * 10
        v58 = false

        if v59 then
            Simulation.SetFacing(nil)
            v59 = false
        end

        setCharacterFade((Smoothing.DrawnModel() or character2), 0, 0)
        v466 = v484
    elseif v71 == "follow" then
        local target = Spectate.GetTarget()
        local humanoidRootPart4 = target and target:FindFirstChild("HumanoidRootPart")
        local v487, v488
        local v489, v490, v491, v492, v493 = false, false, false, false, false
        v58 = false

        if v59 then
            Simulation.SetFacing(nil)
            v59 = false
        end

        setCharacterFade((Smoothing.DrawnModel() or character2), 0, 0)

        if target then
            if humanoidRootPart4 then
                if humanoidRootPart4:IsA("BasePart") then
                    if Finite.Vector(humanoidRootPart4.Position) then
                        if Finite.Vector(humanoidRootPart4.CFrame.LookVector) then
                            v491 = true
                        else
                            v489 = true
                        end
                    else
                        v489 = true
                    end
                else
                    v490 = true
                end
            else
                v490 = true
            end
        else
            v490 = true
        end

        if v489 then
            if Finite.Say("follow root") then
                v491 = true
            else
                v490 = true
            end
        end

        if v490 then
            v487 = v78
            v488 = v79
            v467 = v487.Position + v487.LookVector * 10
        end

        if v491 then
            if target == target4 then
                v493 = true
            else
                if target4 ~= nil then
                    v75 = v78
                    v76 = v79
                    v77 = 0
                end

                v492 = true
            end
        end

        if v492 then
            target4 = target
            local lookVector = humanoidRootPart4.CFrame.LookVector
            v26 = math.atan2(-lookVector.X, -lookVector.Z)
            v27 = -0.17453292519943295
            v493 = true
        end

        if v493 then
            local v495 = v26
            local lookVector = humanoidRootPart4.CFrame.LookVector
            v26 = (((v495 + (((((math.atan2(-lookVector.X, -lookVector.Z) - v495) + math.pi) % math.tau) - math.pi) * (1 - math.exp(a439 * -4)))) + math.pi) % math.tau) - math.pi
            v27 += ((-0.17453292519943295 - v27) * (1 - math.exp(a439 * -3)))
            local v497 = ignoreList(target)
            v487, v467 = frameSubject(a439, target, humanoidRootPart4.Position, v497)
            v488 = math.clamp(spring.value, 20, 110)
        end

        if v77 < 1 and v75 then
            v77 = math.min(1, v77 + (a439 / 0.45))
            local clampedValue = math.clamp(v77, 0, 1)
            local alpha = clampedValue * clampedValue * (3 - (clampedValue * 2))
            v465 = v75:Lerp(v487, alpha)
            v466 = v76 + (v488 - v76) * alpha
        else
            v465, v466 = v487, v488
        end
    else
        if not humanoidRootPart or not character2 or not v448 then
            return
        end

        if humanoid then
            updateCharacterRotation(a439, humanoidRootPart, humanoid, v470)
        end

        local v500 = ignoreList(character2)
        local v501 = v448 + Finite.Offset(Smoothing)
        local startValue, startValue2 = frameSubject(a439, character2, v501, v500)
        local v504 = startValue
        local v505 = v51.target == 0 and v51.blend == 0 and humanoid ~= nil and 0 < humanoid.Health
        local v506 = FirstPerson.Step(a439, v505)
        firstPerson = 0.5 <= v506

        if not (0 < v506) then
            v467 = startValue2
        else
            local head
            local head2 = character2:FindFirstChild("Head")
            local stepBob = FirstPerson.StepBob
            local isNotAir = humanoid ~= nil and humanoid.FloorMaterial ~= Enum.Material.Air
            stepBob(a439, v501, isNotAir, character2:GetAttribute("Sliding") == true, humanoidRootPart.AssemblyLinearVelocity, v504)
            local v511, rotationX, rotationZ = FirstPerson.CameraBob()
            local eye = FirstPerson.Eye

            if not head2 or not head2:IsA("BasePart") then
                head = nil
            else
                head = head2
            end

            local v515 = eye(a439, v501, humanoidRootPart, head, startValue.LookVector) + Vector3.new(0, (spring5.value * 0.5) + v511, 0)
            local targetValue = CFrame.new(v515) * startValue.Rotation * CFrame.Angles(rotationX, 0, rotationZ)
            local alpha = FirstPerson.Eased()

            if not (1 <= alpha) then
                v504 = startValue:Lerp(targetValue, alpha)
            else
                v504 = targetValue
            end

            v467 = startValue2:Lerp(v515 + (v504.LookVector * 10), alpha)
        end

        local v518 = firstPerson and 0.6 or 1
        v465 = applyShake(v504, a439, v518)
        v466 = math.clamp(spring.value, 20, 110)

        if v64 < 1 and cFrame then
            if not position or not (40 < (humanoidRootPart.Position - position).Magnitude) then
                v64 = math.min(1, v64 + (a439 / 0.5))
                local clampedValue = math.clamp(v64, 0, 1)
                local alpha = clampedValue * clampedValue * (3 - (clampedValue * 2))
                v465 = cFrame:Lerp(v465, alpha)
                v466 = fieldOfView + (v466 - fieldOfView) * alpha
            else
                v64 = 1
            end
        end
    end

    if 0 < v51.target then
        local v521 = os.clock() - v51.startedAt
        local v522 = false

        if 0.5 < v521 then
            v522 = next(unlockReasons) == nil and not (v50 and v50.untilStopped)
        end

        local v523 = character ~= character2 or humanoid ~= nil and humanoid.Health <= 0

        if v522 or v523 or 120 < v521 then
            v51.target = 0
            v52 = 2.5
        end
    end

    local target = v51.target

    if v51.blend < target then
        v51.blend = math.min(v51.target, v51.blend + (a439 * v52))
    elseif v51.target < v51.blend then
        v51.blend = math.max(v51.target, v51.blend - (a439 * v52))
    end

    local v525 = v50
    if v525 then
        v54 = v525.cf
        v55 = v525.fov or v55
    end

    if not (0 < v51.blend) then
        if v51.target == 0 then
            v50 = nil
        end
    else
        local clampedValue = math.clamp(v51.blend, 0, 1)
        local alpha = clampedValue * clampedValue * (3 - (clampedValue * 2))
        v465 = v465:Lerp(v54, alpha)
        v466 += (v55 - v466) * alpha
    end

    if v51.blend <= 0 then
        v465 = Occlusion.AboveWater(v465)
    end

    local clampedValue = math.clamp(v466 + fovKickNow(), 20, 110)

    if not Finite.Vector(v465.Position)
        or not Finite.Vector(v465.LookVector)
        or not Finite.Number(clampedValue)
    then
        Finite.Say("view " .. v71)
        v468 = v78
        fieldOfView3 = v79
        v467 = v468.Position + v468.LookVector * 10
    elseif Finite.Vector(v467) then
        v468, fieldOfView3 = v465, clampedValue
    else
        v467 = v465.Position + v465.LookVector * 10
        v468, fieldOfView3 = v465, clampedValue
    end

    camera.CFrame = v468
    local newCFrame = CFrame.new
    local v530 = if 0.5 < v51.blend then v54.Position else v467
    camera.Focus = newCFrame(v530)
    camera.FieldOfView = fieldOfView3
    v78 = v468
    v79 = fieldOfView3
    v66 = true

    if v21.FrameLog then
        local v531 = v448 or Vector3.new(0, 0, 0)
        local v532 = v531 + Finite.Offset(Smoothing)
        local value = spring3.value
        local count = 0

        for _ in lookLocks do
            count += 1
        end

        local frameLog = v21.FrameLog
        local v537 = {os.clock(), a439, v468.X, v468.Y, v468.Z, v26, v27, fieldOfView3, v531.X, v531.Y, v531.Z, v532.X, v532.Y, v532.Z, spring2.value, (Shoulder.Value())}
        local x = value.X
        local y = value.Y
        local z = value.Z
        local value2 = spring4.value
        local value3 = spring5.value
        local value4 = spring.value
        local v544 = v64
        local v545 = v71 == "none" and 0 or v71 ~= "death" and 2 or 1
        local v546 = Shoulder.Get()
        local v547 = localPlayer:GetAttribute("Frozen") ~= true and 0 or 1
        v537[17], v537[18], v537[19], v537[20], v537[21], v537[22], v537[23], v537[24], v537[25], v537[26], v537[27], v537[28] = x, y, z, value2, value3, value4, v544, v545, count, v546, v547, spring6.value.Magnitude
        table.insert(frameLog, v537)
    end

    if v71 ~= "none" then
        v48.propFadeFrame += 1

        if v209 <= v48.propFadeFrame then
            v48.propFadeFrame = 0
            updatePropFade(v468.Position, v467, (ignoreList(character2)))
        end

        Fades.ClearAllies()
        Fades.UpdateDecor(v468.Position, v467)

        return
    end

    local v548
    local v549 = Smoothing.DrawnModel() or character2
    local v550 = v448 or v468.Position
    local v551 = v550 + Finite.Offset(Smoothing)
    local head = v549 and v549:FindFirstChild("Head")
    local v553 = if head and head:IsA("BasePart") then head.Position else v551 + Vector3.new(0, 1.5, 0)
    local magnitude = (v468.Position - v553).Magnitude
    local v555 = 0
    local v556 = if magnitude < 2.6 then math.clamp((2.6 - magnitude) / 1.6, 0, 0.85) else v555

    if v525 and v525.hide then
        v556 = math.max(v556, v51.blend)
    end

    local v557 = 0

    if character2 then
        if not (v51.blend < 0.5) then
            v548 = v557
        elseif firstPerson then
            v548 = v557
        else
            v548 = headCrowdsCrosshair(camera, v49) and 0.6 or v557
        end
    else
        v548 = v557
    end

    v49 = 0 < v548
    v48.headFade += ((v548 - v48.headFade) * (1 - math.exp(a439 * -12)))

    if v548 == 0 and v48.headFade < 0.02 then
        v48.headFade = 0
    end

    local v558 = firstPerson and 0 or v556
    setCharacterFade(v549, v558, v48.headFade, firstPerson)
    Fades.UpdateAllies(v468.Position, v553, character2)
    Fades.UpdateDecor(v468.Position, v553)
    v48.propFadeFrame += 1

    if v209 <= v48.propFadeFrame then
        v48.propFadeFrame = 0
        updatePropFade(v468.Position, v553, (ignoreList(character2)))
    end
end

do
    local function countTouches()
        --[[
          name: countTouches
          line: 1419
          upvalues:
            touches (copy, index: 1)
        ]]
        local count = 0

        for _ in touches do
            count += 1
        end

        return count
    end
end

local function inThumbstickArea(position: Vector3)
    --[[
      name: inThumbstickArea
      line: 1433
      upvalues:
        localPlayer (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
    local touchGui = playerGui and playerGui:FindFirstChild("TouchGui")
    local instance = if touchGui and touchGui:IsA("ScreenGui") and touchGui.Enabled then touchGui:FindFirstChild("TouchControlFrame") else nil
    local v567 = false

    for _, childName in {"DynamicThumbstickFrame", "ThumbstickFrame"} do
        if const child = instance and instance:FindFirstChild(childName) then
            if not child:IsA("GuiObject") then
                continue
            end
            if not child.Visible then
                continue
            end

            v567 = true
            local absolutePosition = child.AbsolutePosition
            local v572 = absolutePosition + child.AbsoluteSize
            local x = position.X

            if absolutePosition.X <= x then
                local y = position.Y

                if absolutePosition.Y <= y and position.X <= v572.X and position.Y <= v572.Y then
                    return true
                end
            end
        end
    end

    if v567 then
        return false
    end

    local camera = workspace.CurrentCamera
    local v576 = false

    if camera ~= nil then
        v576 = false

        if position.X < camera.ViewportSize.X * 0.4 then
            local y = position.Y
            v576 = camera.ViewportSize.Y / 3 < y
        end
    end

    return v576
end

local inputObject = nil

local function onInputBegan(input: InputObject, gameProcessedEvent: boolean)
    --[[
      name: onInputBegan
      line: 1457
      upvalues:
        inputObject (ref,  index: 1)
        inThumbstickArea (copy, index: 2)
        v47 (copy, index: 3)
        touches (copy, index: 4)
        magnitude (ref,  index: 5)
    ]]
    if input.UserInputType == Enum.UserInputType.Touch and not gameProcessedEvent then
        local userInputState = if inputObject then inputObject.UserInputState else nil

        if userInputState == Enum.UserInputState.End or userInputState == Enum.UserInputState.Cancel then
            inputObject = nil
        end

        if not inputObject then
            if inThumbstickArea(input.Position) then
                inputObject = input
                v47.touchesIgnored += 1

                return
            end
        end

        touches[input] = true
        magnitude = nil
    end
end

local function onInputChanged(input: InputObject, gameProcessedEvent: boolean)
    --[[
      name: onInputChanged
      line: 1476
      upvalues:
        touches (copy, index: 1)
        Guards (copy, index: 2)
        v68 (ref,  index: 3)
        magnitude (ref,  index: 4)
        clampedValue2 (ref,  index: 5)
        vector2 (ref,  index: 6)
    ]]
    if input.UserInputType ~= Enum.UserInputType.Touch then
        if input.KeyCode == Enum.KeyCode.Thumbstick2 then
            vector2 = Vector2.new(input.Position.X, input.Position.Y)
        end
    else
        if not touches[input] then
            return
        end

        Guards.PruneTouches(touches)
        local count = 0

        for _ in touches do
            count += 1
        end

        if count == 1 then
            v68 += Vector2.new(input.Delta.X, input.Delta.Y)
            return
        end

        if count == 2 then
            local v588
            local v589
            v588, v589 = nil, nil

            for v590 in touches do
                if v588 then
                    v589 = v590
                else
                    v588 = v590
                end
            end

            if v588 and v589 then
                local magnitude2 = (Vector2.new(v588.Position.X, v588.Position.Y) - Vector2.new(v589.Position.X, v589.Position.Y)).Magnitude

                if magnitude then
                    clampedValue2 = math.clamp(clampedValue2 - ((magnitude2 - magnitude) * 0.03), 7, 14)
                end

                magnitude = magnitude2
            end
        end
    end
end

local function onInputEnded(input: InputObject, gameProcessedEvent: boolean)
    --[[
      name: onInputEnded
      line: 1508
      upvalues:
        inputObject (ref,  index: 1)
        touches (copy, index: 2)
        magnitude (ref,  index: 3)
        vector2 (ref,  index: 4)
    ]]
    if input.UserInputType ~= Enum.UserInputType.Touch then
        if input.KeyCode == Enum.KeyCode.Thumbstick2 then
            vector2 = Vector2.zero
        end
    else
        if input == inputObject then
            inputObject = nil
        end

        touches[input] = nil
        magnitude = nil
    end
end

do
    local function start()
        --[[
          name: start
          line: 1520
          upvalues:
            v35 (ref,  index: 1)
            v24 (copy, index: 2)
            Spectate (copy, index: 3)
            Smoothing (copy, index: 4)
            localPlayer (copy, index: 5)
            v209 (ref,  index: 6)
            v208 (copy, index: 7)
            workspace (copy, index: 8)
            v26 (ref,  index: 9)
            players (copy, index: 10)
            markIgnoreDirty (copy, index: 11)
            v137 (ref,  index: 12)
            Fighters (copy, index: 13)
            userInputService (copy, index: 14)
            onInputBegan (copy, index: 15)
            onInputChanged (copy, index: 16)
            onInputEnded (copy, index: 17)
            Guards (copy, index: 18)
            v21 (copy, index: 19)
            Keybinds (copy, index: 20)
            contextActionService (copy, index: 21)
            v60 (ref,  index: 22)
            unlockReasons (copy, index: 23)
            guiService (copy, index: 24)
            Shoulder (copy, index: 25)
            v71 (ref,  index: 26)
            v51 (copy, index: 27)
            v50 (ref,  index: 28)
            v48 (copy, index: 29)
            v165 (ref,  index: 30)
            v157 (copy, index: 31)
            v159 (copy, index: 32)
            v158 (ref,  index: 33)
            v160 (ref,  index: 34)
            v161 (ref,  index: 35)
            v162 (ref,  index: 36)
            v56 (ref,  index: 37)
            v57 (ref,  index: 38)
            v58 (ref,  index: 39)
            v59 (ref,  index: 40)
            Simulation (copy, index: 41)
            v28 (ref,  index: 42)
            v40 (copy, index: 43)
            spring6 (copy, index: 44)
            spring5 (copy, index: 45)
            v64 (ref,  index: 46)
            v27 (ref,  index: 47)
            v61 (ref,  index: 48)
            lookLocks (copy, index: 49)
            touches (copy, index: 50)
            runService (copy, index: 51)
            v105 (ref,  index: 52)
            update (copy, index: 53)
            v47 (copy, index: 54)
        ]]
        if v35 or not v24 then
            return
        end

        v35 = true
        Spectate.Start()
        Smoothing.Start()

        pcall(
            function()
                --[[
                  line: 1530
                  upvalues:
                    localPlayer (copy, index: 1)
                ]]
                localPlayer.CameraMinZoomDistance = 6
                localPlayer.CameraMaxZoomDistance = 40
            end
        )

        task.spawn(
            function()
                --[[
                  line: 1534
                  upvalues:
                    localPlayer (copy, index: 1)
                    v209 (ref,  index: 2)
                    v208 (copy, index: 3)
                ]]
                local playerScripts = localPlayer:WaitForChild("PlayerScripts", 30)
                if not playerScripts then
                    return
                end

                local function readLevel()
                    --[[
                      name: readLevel
                      line: 1539
                      upvalues:
                        v209 (ref,  index: 1)
                        v208 (copy, index: 2)
                        playerScripts (copy, index: 3)
                    ]]
                    v209 = v208[playerScripts:GetAttribute("CharacterQualityLevel")] or 1
                end

                v209 = v208[playerScripts:GetAttribute("CharacterQualityLevel")] or 1
                playerScripts:GetAttributeChangedSignal("CharacterQualityLevel"):Connect(readLevel)
            end
        )

        if const camera = workspace.CurrentCamera then
            local cFrame = camera.CFrame
            local lookVector = cFrame.LookVector
            v26 = math.atan2(-lookVector.X, -lookVector.Z)
        end

        for _, player in players:GetPlayers() do
            player.CharacterAdded:Connect(markIgnoreDirty)
            player.CharacterRemoving:Connect(markIgnoreDirty)
        end

        players.PlayerAdded:Connect(
            function(player: Player)
                --[[
                  line: 1552
                  upvalues:
                    markIgnoreDirty (copy, index: 1)
                    v137 (ref,  index: 2)
                ]]
                player.CharacterAdded:Connect(markIgnoreDirty)
                player.CharacterRemoving:Connect(markIgnoreDirty)
                v137 = true
            end
        )

        players.PlayerRemoving:Connect(markIgnoreDirty)
        Fighters.OnTaggedChanged(markIgnoreDirty)
        userInputService.InputBegan:Connect(onInputBegan)
        userInputService.InputChanged:Connect(onInputChanged)
        userInputService.InputEnded:Connect(onInputEnded)

        task.spawn(
            function()
                --[[
                  line: 1562
                  upvalues:
                    Guards (copy, index: 1)
                    v21 (copy, index: 2)
                ]]
                local textChatService = game:GetService("TextChatService")
                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                    or textChatService:WaitForChild("ChatInputBarConfiguration", 10)

                if chatInputBarConfiguration and chatInputBarConfiguration:IsA("ChatInputBarConfiguration") then
                    Guards.SetChatConfig(chatInputBarConfiguration)

                    chatInputBarConfiguration:GetPropertyChangedSignal("IsFocused"):Connect(
                        function()
                            --[[
                              line: 1567
                              upvalues:
                                chatInputBarConfiguration (copy, index: 1)
                                v21 (copy, index: 2)
                            ]]
                            if chatInputBarConfiguration.IsFocused then
                                v21.PushMouseUnlock("ChatFocus")
                                return
                            end

                            v21.PopMouseUnlock("ChatFocus")
                        end
                    )
                end
            end
        )

        userInputService.TextBoxFocused:Connect(
            function()
                --[[
                  line: 1576
                  upvalues:
                    v21 (copy, index: 1)
                ]]
                v21.PushMouseUnlock("TextBox")
            end
        )
        userInputService.TextBoxFocusReleased:Connect(
            function()
                --[[
                  line: 1579
                  upvalues:
                    v21 (copy, index: 1)
                ]]
                v21.PopMouseUnlock("TextBox")
            end
        )

        local function bindKeys()
            --[[
              name: bindKeys
              line: 1589
              upvalues:
                Keybinds (copy, index: 1)
                contextActionService (copy, index: 2)
                Guards (copy, index: 3)
                v60 (ref,  index: 4)
                unlockReasons (copy, index: 5)
                v21 (copy, index: 6)
                guiService (copy, index: 7)
                Shoulder (copy, index: 8)
                v71 (ref,  index: 9)
            ]]
            local v607 = Keybinds.Inputs("FreeCursor")

            if #v607 ~= 0 then
                contextActionService:BindActionAtPriority(
                    "TribesFreeCursor",
                    function(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject)
                        --[[
                          line: 1594
                          upvalues:
                            Guards (copy, index: 1)
                            v60 (ref,  index: 2)
                            unlockReasons (copy, index: 3)
                            v21 (copy, index: 4)
                        ]]
                        if inputState ~= Enum.UserInputState.Begin then
                            if inputState ~= Enum.UserInputState.End then
                                Guards.FreeKeyCancel()
                            elseif Guards.FreeKeyUp() and not v60 then
                                if unlockReasons.FreeCursor then
                                    v21.PopMouseUnlock("FreeCursor")
                                else
                                    v21.PushMouseUnlock("FreeCursor")
                                end
                            end
                        else
                            Guards.FreeKeyDown(inputObject)
                        end

                        return Enum.ContextActionResult.Pass
                    end,
                    false,
                    Enum.ContextActionPriority.Low.Value,
                    table.unpack(v607)
                )
            else
                contextActionService:UnbindAction("TribesFreeCursor")
            end

            local function inputsOf(a612)
                --[[
                  name: inputsOf
                  line: 1613
                  upvalues:
                    Keybinds (copy, index: 1)
                ]]
                local v613 = Keybinds.Inputs(a612)

                for _, v615 in Keybinds.PadInputs(a612) do
                    table.insert(v613, v615)
                end

                return v613
            end

            local v616 = Keybinds.Inputs("Shoulder")

            for _, v618 in Keybinds.PadInputs("Shoulder") do
                table.insert(v616, v618)
            end

            local v619 = Keybinds.Inputs("View")

            for _, v621 in Keybinds.PadInputs("View") do
                table.insert(v619, v621)
            end

            contextActionService:UnbindAction("TribesShoulderSwap")
            contextActionService:UnbindAction("TribesFirstPerson")

            if 0 < #v616 then
                contextActionService:BindActionAtPriority(
                    "TribesShoulderSwap",
                    function(actionName: string, inputState: Enum.UserInputState)
                        --[[
                          line: 1624
                          upvalues:
                            unlockReasons (copy, index: 1)
                            guiService (copy, index: 2)
                            v60 (ref,  index: 3)
                            Shoulder (copy, index: 4)
                        ]]
                        if inputState == Enum.UserInputState.Begin then
                            local v624 = next(unlockReasons) ~= nil or guiService.MenuIsOpen

                            if not v624 and not v60 then
                                Shoulder.Toggle()
                            end
                        end

                        return Enum.ContextActionResult.Pass
                    end,
                    false,
                    Enum.ContextActionPriority.Low.Value,
                    table.unpack(v616)
                )
            end

            if 0 < #v619 then
                contextActionService:BindActionAtPriority(
                    "TribesFirstPerson",
                    function(actionName: string, inputState: Enum.UserInputState)
                        --[[
                          line: 1632
                          upvalues:
                            unlockReasons (copy, index: 1)
                            guiService (copy, index: 2)
                            v60 (ref,  index: 3)
                            v71 (ref,  index: 4)
                            v21 (copy, index: 5)
                        ]]
                        if inputState == Enum.UserInputState.Begin then
                            local v627 = next(unlockReasons) ~= nil or guiService.MenuIsOpen

                            if not v627 and not v60 and v71 == "none" then
                                v21.ToggleFirstPerson()
                            end
                        end

                        return Enum.ContextActionResult.Pass
                    end,
                    false,
                    Enum.ContextActionPriority.Low.Value,
                    table.unpack(v619)
                )
            end
        end

        bindKeys()

        local function rebindFor(a629)
            --[[
              name: rebindFor
              line: 1641
            ]]
            for _, v631 in a629 do
                if v631 == "FreeCursor" then
                    break
                end
                if v631 == "Shoulder" then
                    break
                end
                if v631 == "View" then
                    break
                end
            end
        end

        Keybinds.Changed:Connect(rebindFor)
        Keybinds.PadChanged:Connect(rebindFor)

        localPlayer.CharacterAdded:Connect(
            function(character: Model)
                --[[
                  line: 1651
                  upvalues:
                    v51 (copy, index: 1)
                    v50 (ref,  index: 2)
                    v48 (copy, index: 3)
                    v165 (ref,  index: 4)
                    v157 (copy, index: 5)
                    v159 (copy, index: 6)
                    v158 (ref,  index: 7)
                    v160 (ref,  index: 8)
                    v161 (ref,  index: 9)
                    v162 (ref,  index: 10)
                    v56 (ref,  index: 11)
                    v57 (ref,  index: 12)
                    v58 (ref,  index: 13)
                    v59 (ref,  index: 14)
                    Simulation (copy, index: 15)
                    v28 (ref,  index: 16)
                    v40 (copy, index: 17)
                    spring6 (copy, index: 18)
                    v21 (copy, index: 19)
                    spring5 (copy, index: 20)
                    v64 (ref,  index: 21)
                    v26 (ref,  index: 22)
                    v27 (ref,  index: 23)
                    v61 (ref,  index: 24)
                    v60 (ref,  index: 25)
                ]]
                v51.target = 0
                v51.blend = 0
                v50 = nil
                v48.headFade = 0
                local v633 = 0

                if v633 < 0.01 then
                    v633 = 0
                end

                local _ = math.max(v633, 0) < 0.01

                if v165 ~= nil then
                    for _, v636 in v157 do
                        local inst = v636.inst

                        if inst.Parent and inst.LocalTransparencyModifier ~= 0 then
                            inst.LocalTransparencyModifier = 0
                        end
                    end

                    for _, v639 in v159 do
                        v639:Disconnect()
                    end

                    table.clear(v159)
                    table.clear(v157)
                    v165 = nil
                    v158 = true
                    v160 = -1
                    v161 = -1
                    v162 = false
                end

                for _, descendant in character:GetDescendants() do
                    if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                        descendant.LocalTransparencyModifier = 0
                    end
                end

                v56 = nil
                v57 = nil
                v58 = false
                v59 = false
                Simulation.SetFacing(nil)
                v165 = nil
                v28 = false
                table.clear(v40)
                spring6:Snap(Vector3.new(0, 0, 0))
                v21.SlowRecoil:Snap(Vector3.new(0, 0, 0))
                v21.SlowRecoilStay = Vector3.new(0, 0, 0)
                spring5:Snap(0)
                v64 = 1
                v21.PopMouseUnlock("FreeCursor")
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)

                if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
                    local cFrame = humanoidRootPart.CFrame
                    local lookVector = cFrame.LookVector
                    v26 = math.atan2(-lookVector.X, -lookVector.Z)
                    v27 = -0.20943951023931956
                    v61 = v60
                    local timestamp = os.clock()
                    local position = humanoidRootPart.Position

                    task.spawn(
                        function()
                            --[[
                              line: 1686
                              upvalues:
                                timestamp (copy, index: 1)
                                humanoidRootPart (copy, index: 2)
                                position (ref,  index: 3)
                                v26 (ref,  index: 4)
                                v27 (ref,  index: 5)
                                v61 (ref,  index: 6)
                                v60 (ref,  index: 7)
                            ]]
                            local timestamp2
                            timestamp2 = timestamp

                            while os.clock() - timestamp2 < 1.5 and humanoidRootPart.Parent do
                                task.wait(0.05)

                                if 40 < (humanoidRootPart.Position - position).Magnitude then
                                    local cFrame = humanoidRootPart.CFrame
                                    local lookVector = cFrame.LookVector
                                    v26 = math.atan2(-lookVector.X, -lookVector.Z)
                                    v27 = -0.20943951023931956
                                    v61 = v60
                                end

                                position = humanoidRootPart.Position
                                timestamp2 = timestamp
                            end
                        end
                    )
                end
            end
        )

        Guards.Start(
            {
                lookLocks = lookLocks,
                unlockReasons = unlockReasons,
                touches = touches,
                popLookLock = (function(a650)
                    --[[
                      name: popLookLock
                      line: 1703
                      upvalues:
                        v21 (copy, index: 1)
                    ]]
                    v21.PopLookLock(a650)
                end),
                popUnlock = (function(a651)
                    --[[
                      name: popUnlock
                      line: 1706
                      upvalues:
                        v21 (copy, index: 1)
                    ]]
                    v21.PopMouseUnlock(a651)
                end),
                blockers = (function()
                    --[[
                      name: blockers
                      line: 1709
                      upvalues:
                        v21 (copy, index: 1)
                    ]]
                    return v21.GetLookBlockers()
                end)
            }
        )

        runService:BindToRenderStep(
            "TribesCamera",
            Enum.RenderPriority.Camera.Value + 1,
            function(deltaTime: number)
                --[[
                  line: 1713
                  upvalues:
                    v105 (ref,  index: 1)
                    update (copy, index: 2)
                    Simulation (copy, index: 3)
                    v26 (ref,  index: 4)
                    v47 (copy, index: 5)
                ]]
                local timestamp = os.clock()
                v105()
                update(deltaTime)
                Simulation.SetLook(v26)
                local elapsedTime = os.clock() - timestamp
                v47.time += elapsedTime
                v47.frames += 1
                v47.max = math.max(v47.max, elapsedTime)
            end
        )
    end

    function v21.SetAiming(a655, a656: number)
        --[[
          name: SetAiming
          line: 1734
          upvalues:
            v28 (ref, index: 1)
            v71 (ref, index: 2)
            clampedValue (ref, index: 3)
        ]]
        v28 = a655 == true and v71 == "none"

        if v28 then
            if typeof(a656) ~= "number" then
                clampedValue = 50
            else
                clampedValue = math.clamp(a656, 20, 90)
            end
        end
    end

    function v21.IsAiming()
        --[[
          name: IsAiming
          line: 1741
          upvalues:
            v28 (ref, index: 1)
        ]]
        return v28
    end

    function v21.GetAimRay()
        --[[
          name: GetAimRay
          line: 1747
          upvalues:
            workspace (copy, index: 1)
        ]]
        local camera = workspace.CurrentCamera
        if not camera then
            return Ray.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, -1))
        end

        local cFrame = camera.CFrame

        return Ray.new(cFrame.Position, cFrame.LookVector)
    end

    function v21.GetAimPoint(a659, a660)
        --[[
          name: GetAimPoint
          line: 1760
          upvalues:
            v21 (copy, index: 1)
            localPlayer (copy, index: 2)
            childNames (copy, index: 3)
            workspace (copy, index: 4)
        ]]
        local humanoidRootPart
        local aimRay = v21.GetAimRay()
        local character = localPlayer and localPlayer.Character
        local v664 = aimRay.Origin

        if const character2 = localPlayer and localPlayer.Character then
            local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")
            character2:FindFirstChildOfClass("Humanoid")
            humanoidRootPart = humanoidRootPart2 and humanoidRootPart2:IsA("BasePart") and humanoidRootPart2 or nil
        else
            humanoidRootPart = nil
        end

        if humanoidRootPart then
            local v667 = (humanoidRootPart.Position - v664):Dot(aimRay.Direction)

            if 0 < v667 then
                v664 += aimRay.Direction * math.max(0, v667 - 1.5)
            end
        end

        local filterDescendantsInstances = {}

        if character then
            table.insert(filterDescendantsInstances, character)
        end

        for _, childName in childNames do
            if const child = workspace:FindFirstChild(childName) then
                table.insert(filterDescendantsInstances, child)
            end
        end

        if a660 then
            for _, v673 in a660 do
                table.insert(filterDescendantsInstances, v673)
            end
        end

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = filterDescendantsInstances
        raycastParams.IgnoreWater = true
        local v675 = (a659 or 1000) - (v664 - aimRay.Origin).Magnitude

        if const raycastResult = workspace:Raycast(v664, aimRay.Direction * v675, raycastParams) then
            return raycastResult.Position, raycastResult
        end

        return v664 + (aimRay.Direction * v675), nil
    end

    function v21.FovKick(a677: number, a678, a679)
        --[[
          name: FovKick
          line: 1801
          upvalues:
            v115 (copy, index: 1)
        ]]
        if typeof(a677) ~= "number" or a677 ~= a677 then
            return
        end

        v115.amount = math.clamp(a677, -20, 20)
        v115.t0 = os.clock()
        v115.rise = math.max((a678 or 0.05), 0.01)
        v115.fall = math.max((a679 or 0.2), 0.01)
    end

    function v21.Shake(a680: number, a681: number)
        --[[
          name: Shake
          line: 1813
          upvalues:
            v40 (copy, index: 1)
        ]]
        if typeof(a680) ~= "number" or typeof(a681) ~= "number" then
            return
        end
        if a680 <= 0 or a681 <= 0 then
            return
        end

        if 24 < #v40 then
            table.remove(v40, 1)
        end

        table.insert(v40, {t = 0, intensity = math.min(a680, 3), duration = math.min(a681, 5)})
    end

    function v21.Recoil(a682: number, a683, a684)
        --[[
          name: Recoil
          line: 1827
          upvalues:
            spring6 (copy, index: 1)
        ]]
        spring6:Impulse(Vector3.new(math.rad(a682), math.rad((a683 or 0)), (math.rad((a684 or 0)))) * 12)
    end

    v21.SlowRecoil = Spring.new(Vector3.new(0, 0, 0), 8, 1)
    v21.SlowRecoilStay = Vector3.new(0, 0, 0)
    v21.SLOW_RECOIL_FADE = 0.3

    function v21.RecoilSlow(a685: number, a686, a687, a688)
        --[[
          name: RecoilSlow
          line: 1840
          upvalues:
            v21 (copy, index: 1)
        ]]
        local slowRecoil = v21.SlowRecoil
        local v690 = slowRecoil.target + Vector3.new(math.rad(a685), math.rad((a686 or 0)), 0)
        slowRecoil.target = Vector3.new(math.clamp(v690.X, -0.4363323129985824, 0.4363323129985824), math.clamp(v690.Y, -0.4363323129985824, 0.4363323129985824), 0)
        v21.SlowRecoilStay += Vector3.new(math.rad((a687 or 0)), math.rad((a688 or 0)), 0)
    end

    function v21.Dip(a691: number)
        --[[
          name: Dip
          line: 1849
          upvalues:
            spring5 (copy, index: 1)
        ]]
        if typeof(a691) ~= "number" then
            return
        end

        spring5:Impulse(-math.clamp(a691, -3, 3) * 6)
    end

    function v21.PushMouseUnlock(a692)
        --[[
          name: PushMouseUnlock
          line: 1856
          upvalues:
            unlockReasons (copy, index: 1)
            v35 (ref,  index: 2)
            applyMouseBehavior (copy, index: 3)
        ]]
        unlockReasons[tostring(a692)] = true

        if v35 then
            applyMouseBehavior()
        end
    end

    function v21.PopMouseUnlock(a693)
        --[[
          name: PopMouseUnlock
          line: 1863
          upvalues:
            unlockReasons (copy, index: 1)
            v35 (ref,  index: 2)
            applyMouseBehavior (copy, index: 3)
        ]]
        unlockReasons[tostring(a693)] = nil

        if v35 then
            applyMouseBehavior()
        end
    end

    function v21.PushLookLock(a694, a695)
        --[[
          name: PushLookLock
          line: 1876
          upvalues:
            lookLocks (copy, index: 1)
            Guards (copy, index: 2)
        ]]
        local text = tostring(a694)
        lookLocks[text] = true
        Guards.LockPushed(text, a695)
    end

    function v21.PopLookLock(a697)
        --[[
          name: PopLookLock
          line: 1882
          upvalues:
            lookLocks (copy, index: 1)
            Guards (copy, index: 2)
        ]]
        local text = tostring(a697)
        lookLocks[text] = nil
        Guards.LockPopped(text)
    end

    function v21.IsLookLocked()
        --[[
          name: IsLookLocked
          line: 1888
          upvalues:
            lookLocks (copy, index: 1)
        ]]
        return next(lookLocks) ~= nil
    end

    function v21.GetLookBlockers()
        --[[
          name: GetLookBlockers
          line: 1896
          upvalues:
            v34 (ref,  index: 1)
            v60 (ref,  index: 2)
            v71 (ref,  index: 3)
            v51 (copy, index: 4)
            lookLocks (copy, index: 5)
            unlockReasons (copy, index: 6)
            guiService (copy, index: 7)
        ]]
        local v699
        local v700 = {}

        if not v34 then
            table.insert(v700, "disabled")
        end

        if v60 then
            table.insert(v700, "lobby")
        end

        if v71 ~= "none" then
            table.insert(v700, "spectate:" .. v71)
        end

        if 0 < v51.target or 0 < v51.blend then
            table.insert(v700, "cinematic")
            v699 = v700
        else
            v699 = v700
        end

        for v701 in lookLocks do
            table.insert(v699, "lock:" .. v701)
        end

        for v702 in unlockReasons do
            table.insert(v699, "unlock:" .. v702)
        end

        if guiService.MenuIsOpen then
            table.insert(v699, "robloxMenu")
        end

        table.sort(v699)

        return v699
    end

    function v21.IsMouseUnlocked()
        --[[
          name: IsMouseUnlocked
          line: 1925
          upvalues:
            unlockReasons (copy, index: 1)
            guiService (copy, index: 2)
        ]]
        return next(unlockReasons) ~= nil or guiService.MenuIsOpen
    end

    function v21.GetMode()
        --[[
          name: GetMode
          line: 1931
          upvalues:
            v60 (ref, index: 1)
        ]]
        if v60 then
            return "lobby"
        end

        return "combat"
    end

    function v21.GetUnlockReasons()
        --[[
          name: GetUnlockReasons
          line: 1935
          upvalues:
            unlockReasons (copy, index: 1)
        ]]
        local v703 = {}

        for v704 in unlockReasons do
            table.insert(v703, v704)
        end

        return v703
    end

    function v21.GetShoulderSide()
        --[[
          name: GetShoulderSide
          line: 1944
          upvalues:
            Shoulder (copy, index: 1)
        ]]
        return Shoulder.Get()
    end

    v21.FirstPersonChanged = bindableEvent.Event

    function v21.SetFirstPerson(firstPerson)
        --[[
          name: SetFirstPerson
          line: 1952
          upvalues:
            FirstPerson (copy, index: 1)
            bindableEvent (copy, index: 2)
        ]]
        firstPerson = firstPerson == true

        if FirstPerson.Get() ~= firstPerson then
            FirstPerson.Set(firstPerson)
            bindableEvent:Fire(firstPerson)
        end
    end

    function v21.IsFirstPerson()
        --[[
          name: IsFirstPerson
          line: 1960
          upvalues:
            FirstPerson (copy, index: 1)
        ]]
        return FirstPerson.Get()
    end

    function v21.ToggleFirstPerson()
        --[[
          name: ToggleFirstPerson
          line: 1964
          upvalues:
            v21 (copy, index: 1)
            FirstPerson (copy, index: 2)
        ]]
        v21.SetFirstPerson(not FirstPerson.Get())
    end

    function v21.InFirstPerson()
        --[[
          name: InFirstPerson
          line: 1969
          upvalues:
            firstPerson (ref, index: 1)
        ]]
        return firstPerson
    end

    function v21.SetViewBobbing(viewBobbing)
        --[[
          name: SetViewBobbing
          line: 1975
          upvalues:
            FirstPerson (copy, index: 1)
        ]]
        FirstPerson.SetBobbing(viewBobbing)
    end

    function v21.GetViewBobbing()
        --[[
          name: GetViewBobbing
          line: 1979
          upvalues:
            FirstPerson (copy, index: 1)
        ]]
        return FirstPerson.GetBobbing()
    end

    function v21.GetViewBob()
        --[[
          name: GetViewBob
          line: 1985
          upvalues:
            FirstPerson (copy, index: 1)
        ]]
        return FirstPerson.Bob()
    end

    function v21.SetShoulderSide(shoulderSide)
        --[[
          name: SetShoulderSide
          line: 1991
          upvalues:
            Shoulder (copy, index: 1)
        ]]
        Shoulder.Set(shoulderSide)
    end

    function v21.SetModifier(key, value)
        --[[
          name: SetModifier
          line: 1996
          upvalues:
            v39 (copy, index: 1)
        ]]
        v39[key] = value
    end

    function v21.SuspendCharacterRotation(a710)
        --[[
          name: SuspendCharacterRotation
          line: 2001
          upvalues:
            v38 (copy, index: 1)
        ]]
        v38[tostring(a710)] = true
    end

    function v21.ResumeCharacterRotation(a711)
        --[[
          name: ResumeCharacterRotation
          line: 2005
          upvalues:
            v38 (copy, index: 1)
        ]]
        v38[tostring(a711)] = nil
    end

    function v21.FaceCamera()
        --[[
          name: FaceCamera
          line: 2011
          upvalues:
            localPlayer (copy, index: 1)
            v60 (ref,  index: 2)
            v59 (ref,  index: 3)
            Simulation (copy, index: 4)
            v26 (ref,  index: 5)
        ]]
        local humanoidRootPart, humanoid

        if const character = localPlayer and localPlayer.Character then
            local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
            local humanoid2 = character:FindFirstChildOfClass("Humanoid")
            humanoidRootPart = humanoidRootPart2 and humanoidRootPart2:IsA("BasePart") and humanoidRootPart2 or nil
            humanoid = humanoid2
        else
            humanoidRootPart, humanoid = nil, nil
        end

        if humanoidRootPart and humanoid and 0 < humanoid.Health and v60 == false then
            v59 = true
            Simulation.SetFacing(v26)
        end
    end

    function v21.GetAimAssistShot()
        --[[
          name: GetAimAssistShot
          line: 2029
          upvalues:
            AimAssist (copy, index: 1)
            localPlayer (copy, index: 2)
            ignoreList (copy, index: 3)
            v26 (ref,  index: 4)
            v27 (ref,  index: 5)
            v28 (ref,  index: 6)
            v33 (copy, index: 7)
            v39 (copy, index: 8)
        ]]
        if AimAssist.IsEnabled() then
            local combatMode = localPlayer:GetAttribute("CombatMode")
            local v718 = if combatMode == nil then localPlayer:GetAttribute("State") == "Match" else combatMode == true
            if v718 then
                local shot = AimAssist.Shot
                local v720 = ignoreList(localPlayer.Character)
                local v721 = v26
                local v722 = v27
                local v723 = v28
                local v724 = v33.fovNow()

                return shot(v720, v721, v722, v723, v724, v39.CombatDraw ~= nil)
            end
        end

        return nil
    end

    function v21.GetAimAssist(a725)
        --[[
          name: GetAimAssist
          line: 2036
          upvalues:
            v21 (copy, index: 1)
        ]]
        local aimAssistShot = v21.GetAimAssistShot()

        if aimAssistShot and (a725 == nil or not (a725 < aimAssistShot.deg)) then
            return aimAssistShot.model, aimAssistShot.part, aimAssistShot.deg
        end

        return nil, nil, nil
    end

    function v21.IsAssistedInput()
        --[[
          name: IsAssistedInput
          line: 2044
          upvalues:
            AimAssist (copy, index: 1)
        ]]
        return AimAssist.IsAssistedInput()
    end

    function v21.GetAimAssistInput()
        --[[
          name: GetAimAssistInput
          line: 2048
          upvalues:
            AimAssist (copy, index: 1)
        ]]
        return AimAssist.InputKind()
    end

    function v21.Nudge(a727, a728)
        --[[
          name: Nudge
          line: 2052
          upvalues:
            v26 (ref,  index: 1)
            AimAssist (copy, index: 2)
        ]]
        if typeof(a727) ~= "number" or a727 ~= a727 then
            return
        end

        if (a728 or 0) <= 0 then
            v26 = (((v26 + a727) + math.pi) % math.tau) - math.pi
            return
        end

        AimAssist.Nudge(a727, a728)
    end

    function v21.SetAimAssist(aimAssist)
        --[[
          name: SetAimAssist
          line: 2063
          upvalues:
            AimAssist (copy, index: 1)
        ]]
        AimAssist.SetEnabled(aimAssist)
    end

    function v21.GetAimAssistEnabled()
        --[[
          name: GetAimAssistEnabled
          line: 2067
          upvalues:
            AimAssist (copy, index: 1)
        ]]
        return AimAssist.IsEnabled()
    end

    function v21.AimAssistDebug(a730, ...)
        --[[
          name: AimAssistDebug
          line: 2071
          upvalues:
            AimAssist (copy, index: 1)
        ]]
        return AimAssist.Debug(a730, ...)
    end

    function v21.GetYaw()
        --[[
          name: GetYaw
          line: 2075
          upvalues:
            v26 (ref, index: 1)
        ]]
        return v26
    end

    function v21.GetPitch()
        --[[
          name: GetPitch
          line: 2079
          upvalues:
            v27 (ref, index: 1)
        ]]
        return v27
    end

    function v21.SetSensitivity(sensitivity: number)
        --[[
          name: SetSensitivity
          line: 2085
          upvalues:
            clampedValue3 (ref, index: 1)
        ]]
        if typeof(sensitivity) == "number" then
            clampedValue3 = math.clamp(sensitivity, 0.05, 5)
        end
    end

    function v21.AddTouchLook(a732)
        --[[
          name: AddTouchLook
          line: 2093
          upvalues:
            v68 (ref, index: 1)
        ]]
        v68 += a732
    end

    function v21.GetSensitivity()
        --[[
          name: GetSensitivity
          line: 2097
          upvalues:
            clampedValue3 (ref, index: 1)
        ]]
        return clampedValue3
    end

    function v21.SetFOV(fov: number)
        --[[
          name: SetFOV
          line: 2102
          upvalues:
            fieldOfView2 (ref, index: 1)
        ]]
        if typeof(fov) == "number" then
            fieldOfView2 = math.clamp(fov, 60, 100)
        end
    end

    function v21.GetFOV()
        --[[
          name: GetFOV
          line: 2108
          upvalues:
            fieldOfView2 (ref, index: 1)
        ]]
        return fieldOfView2
    end

    function v21.SetAimZoom(aimZoom: number)
        --[[
          name: SetAimZoom
          line: 2113
          upvalues:
            v33 (copy, index: 1)
        ]]
        if typeof(aimZoom) == "number" and aimZoom == aimZoom then
            v33.zoom = math.clamp(aimZoom, 0, 1)
        end
    end

    function v21.SetAimSensitivity(aimSensitivity: number)
        --[[
          name: SetAimSensitivity
          line: 2120
          upvalues:
            v33 (copy, index: 1)
        ]]
        if typeof(aimSensitivity) == "number" and aimSensitivity == aimSensitivity then
            v33.sens = math.clamp(aimSensitivity, 0.2, 3)
        end
    end

    function v21.SetZoom(zoom: number)
        --[[
          name: SetZoom
          line: 2127
          upvalues:
            clampedValue2 (ref, index: 1)
        ]]
        if typeof(zoom) == "number" then
            clampedValue2 = math.clamp(zoom, 7, 14)
        end
    end

    function v21.SpectateNext(a737)
        --[[
          name: SpectateNext
          line: 2134
          upvalues:
            Spectate (copy, index: 1)
        ]]
        local next = Spectate.Next
        local v739 = typeof(a737) == "number" and a737 < 0 and -1 or 1
        next(v739)
    end

    function v21.GetSpectateTarget()
        --[[
          name: GetSpectateTarget
          line: 2139
          upvalues:
            Spectate (copy, index: 1)
        ]]
        return Spectate.GetTarget()
    end

    function v21.GetSpectateMode()
        --[[
          name: GetSpectateMode
          line: 2144
          upvalues:
            Spectate (copy, index: 1)
        ]]
        return Spectate.GetMode()
    end

    function v21.GetKiller()
        --[[
          name: GetKiller
          line: 2149
          upvalues:
            Spectate (copy, index: 1)
        ]]
        return Spectate.GetKiller()
    end

    v21.SpectateChanged = Spectate.Changed

    function v21.PlayCinematic(cf, a741: number, options)
        --[[
          name: PlayCinematic
          line: 2162
          upvalues:
            v50 (ref,  index: 1)
            v51 (copy, index: 2)
            v52 (ref,  index: 3)
            character (ref,  index: 4)
            localPlayer (copy, index: 5)
            v55 (ref,  index: 6)
            workspace (copy, index: 7)
            fieldOfView2 (ref,  index: 8)
        ]]
        if typeof(cf) ~= "CFrame" then
            return
        end

        local v743 = options or {}
        local v744 = {cf = cf, fov = if typeof(a741) ~= "number" then nil else math.clamp(a741, 20, 100)}
        v744.hide = v743.hideCharacter ~= false
        v744.untilStopped = v743.untilStopped == true
        v50 = v744
        v51.target = 1
        v52 = 1 / math.max(0.05, v743.duration or 0.6)
        v51.startedAt = os.clock()
        character = localPlayer and localPlayer.Character

        if not v744.fov then
            v55 = workspace.CurrentCamera and workspace.CurrentCamera.FieldOfView or fieldOfView2
        end
    end

    function v21.StopCinematic(a745)
        --[[
          name: StopCinematic
          line: 2183
          upvalues:
            v51 (copy, index: 1)
            v52 (ref,  index: 2)
        ]]
        v51.target = 0
        v52 = 1 / math.max(0.05, (a745 or 0.5))
    end

    function v21.IsCinematic()
        --[[
          name: IsCinematic
          line: 2188
          upvalues:
            v51 (copy, index: 1)
        ]]
        return 0 < v51.target
    end

    function v21.SetEnabled(enabled)
        --[[
          name: SetEnabled
          line: 2193
          upvalues:
            v34 (ref,  index: 1)
            workspace (copy, index: 2)
            fieldOfView2 (ref,  index: 3)
            userInputService (copy, index: 4)
            localPlayer (copy, index: 5)
            v58 (ref,  index: 6)
            v59 (ref,  index: 7)
            Simulation (copy, index: 8)
            firstPerson (ref,  index: 9)
            FirstPerson (copy, index: 10)
            setCharacterFade (copy, index: 11)
            v165 (ref,  index: 12)
            v207 (copy, index: 13)
            Fades (copy, index: 14)
            v56 (ref,  index: 15)
        ]]
        v34 = enabled
        local camera = workspace.CurrentCamera

        if enabled then
            v56 = nil
            return
        end

        if camera then
            camera.CameraType = Enum.CameraType.Custom
            camera.FieldOfView = fieldOfView2
        end

        userInputService.MouseBehavior = Enum.MouseBehavior.Default
        userInputService.MouseIconEnabled = true

        if const character = localPlayer and localPlayer.Character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            character:FindFirstChildOfClass("Humanoid")

            if humanoidRootPart then
                humanoidRootPart:IsA("BasePart")
            end
        end

        v58 = false

        if v59 then
            Simulation.SetFacing(nil)
            v59 = false
        end

        firstPerson = false
        FirstPerson.Step(0, false)
        setCharacterFade(v165, 0, 0)

        for v750 in v207 do
            if v750.Parent then
                v750.LocalTransparencyModifier = 0
            end
        end

        table.clear(v207)
        Fades.ClearAllies()
        Fades.ClearDecor()
    end

    function v21.IsEnabled()
        --[[
          name: IsEnabled
          line: 2216
          upvalues:
            v34 (ref, index: 1)
        ]]
        return v34
    end

    function v21.DebugOcclusion(a751)
        --[[
          name: DebugOcclusion
          line: 2223
          upvalues:
            Occlusion (copy, index: 1)
        ]]
        return Occlusion.Debug(a751)
    end

    v21.FrameLog = nil

    function v21.DebugFrames(a752)
        --[[
          name: DebugFrames
          line: 2231
          upvalues:
            v21 (copy, index: 1)
        ]]
        local frameLog = v21.FrameLog
        v21.FrameLog = a752 and {} or nil

        if not a752 and frameLog then
            return (game:GetService("HttpService"):JSONEncode(frameLog))
        end

        return nil
    end

    function v21.GetDrawnRoot()
        --[[
          name: GetDrawnRoot
          line: 2244
          upvalues:
            Smoothing (copy, index: 1)
        ]]
        return Smoothing.DrawnCFrame()
    end

    function v21.Drawn(a754)
        --[[
          name: Drawn
          line: 2248
          upvalues:
            Smoothing (copy, index: 1)
        ]]
        return Smoothing.Drawn(a754)
    end

    function v21.GetDrawnModel()
        --[[
          name: GetDrawnModel
          line: 2252
          upvalues:
            Smoothing (copy, index: 1)
        ]]
        return Smoothing.DrawnModel()
    end

    v21.DrawnChanged = Smoothing.DrawnChanged

    function v21.SmoothingTrace(a755)
        --[[
          name: SmoothingTrace
          line: 2260
          upvalues:
            Smoothing (copy, index: 1)
        ]]
        return if const input = Smoothing.Trace(a755) then (game:GetService("HttpService"):JSONEncode(input)) else nil
    end

    function v21.DebugStats()
        --[[
          name: DebugStats
          line: 2265
          upvalues:
            v47 (copy, index: 1)
            Fades (copy, index: 2)
            AimAssist (copy, index: 3)
            Smoothing (copy, index: 4)
            Occlusion (copy, index: 5)
            Guards (copy, index: 6)
            runService (copy, index: 7)
            Simulation (copy, index: 8)
            firstPerson (ref,  index: 9)
        ]]
        local msPerFrame
        local timestamp = os.clock()
        local v759 = math.max(0.001, timestamp - v47.since)
        local v760 = {msPerSec = (v47.time * 1000) / v759}

        if not (0 < v47.frames) then
            msPerFrame = 0
        else
            msPerFrame = v47.time * 1000 / v47.frames
        end

        v760.msPerFrame = msPerFrame
        v760.maxFrameMs = v47.max * 1000
        v760.fps = v47.frames / v759
        v760.touchLookPx = v47.touchLookPx
        v760.touchesIgnored = v47.touchesIgnored
        v47.time = 0
        v47.max = 0
        v47.frames = 0
        v47.since = timestamp

        for v761, v762 in Fades.Stats() do
            v760[v761] = v762
        end

        for v763, v764 in AimAssist.Stats() do
            v760[v763] = v764
        end

        for v765, v766 in Smoothing.Stats() do
            v760[v765] = v766
        end

        for v767, v768 in Occlusion.Debug("stats") do
            v760["occ_" .. v767] = v768
        end

        for v769, v770 in Guards.Stats() do
            v760["guard_" .. v769] = v770
        end

        if runService:IsStudio() and Simulation.WriteGuardStats then
            for v771, v772 in Simulation.WriteGuardStats() do
                v760["wg_" .. v771] = v772
            end
        end

        v760.firstPerson = firstPerson
        v760.waterLifts = Occlusion.WaterLifts()

        return v760
    end

    if v24 and localPlayer then
        do
            local tribesCameraBridge2 = localPlayer:FindFirstChild("TribesCameraBridge")

            if tribesCameraBridge2 and tribesCameraBridge2:IsA("BindableFunction") then
                for v774, v775 in v21 do
                    if type(v775) == "function" then
                        v21[v774] = function(...)
                            --[[
                              line: 2313
                              upvalues:
                                tribesCameraBridge2 (copy, index: 1)
                                v774 (copy, index: 2)
                            ]]
                            return tribesCameraBridge2:Invoke(v774, ...)
                        end
                    end
                end
            else
                do
                    local tribesCameraBridge = Instance.new("BindableFunction")
                    tribesCameraBridge.Name = "TribesCameraBridge"

                    do
                        local values = table.clone(v21)

                        tribesCameraBridge.OnInvoke = function(valueKey, ...)
                            --[[
                              line: 2322
                              upvalues:
                                values (copy, index: 1)
                            ]]
                            local value = values[valueKey]

                            if type(value) ~= "function" then
                                return nil
                            end

                            return value(...)
                        end
                    end

                    tribesCameraBridge.Parent = localPlayer
                end

                start()
            end
        end
    end
end

return v21