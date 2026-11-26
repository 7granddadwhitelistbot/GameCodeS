local players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local v3 = CommonUtils.get("FlagUtil")
local userFlag = v3.getUserFlag("UserRaycastUpdateAPI2")
local userFlag2 = v3.getUserFlag("UserPlayerModuleEngineAPI")
local v6 = {LIMBS = 2, MOVEMENT = 3, CORNERS = 4, CIRCLE1 = 5, CIRCLE2 = 6, LIMBMOVE = 7, SMART_CIRCLE = 8, CHAR_OUTLINE = 9}
local v7 = {Head = true, ["Left Arm"] = true, ["Right Arm"] = true, ["Left Leg"] = true, ["Right Leg"] = true, LeftLowerArm = true, RightLowerArm = true, LeftUpperLeg = true, RightUpperLeg = true}
local v8 = {Vector3.new(1, 1, -1), Vector3.new(1, -1, -1), Vector3.new(-1, -1, -1), Vector3.new(-1, 1, -1)}
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

local raycastParams2 = RaycastParams.new()
raycastParams2.FilterType = Enum.RaycastFilterType.Include

local function AssertTypes(mode, ...)
    --[[
      name: AssertTypes
      line: 75
    ]]
    local v13 = {}
    local v14 = ""

    for _, v16 in pairs({...}) do
        v13[v16] = true
        local v17 = v14 ~= "" and " or " or ""
        v14 ..= v17 .. v16
    end

    local valueType = type(mode)
    assert(v13[valueType], v14 .. " type expected, got: " .. valueType)
end

local function Det3x3(a20, a21, a22, a23, a24, a25, a26, a27, a28)
    --[[
      name: Det3x3
      line: 87
    ]]
    return (a20 * (a24 * a28 - (a25 * a27))) - (a21 * (a23 * a28 - (a25 * a26))) + (a22 * (a23 * a27 - (a24 * a26)))
end

local function RayIntersection(a30, unit, a32, a33)
    --[[
      name: RayIntersection
      line: 105
    ]]
    local v34 = unit:Cross(a33)
    local v35 = a32.X - a30.X
    local v36 = a32.Y - a30.Y
    local v37 = a32.Z - a30.Z
    local x = unit.X
    local v39 = -a33.X
    local x2 = v34.X
    local y = unit.Y
    local v42 = -a33.Y
    local y2 = v34.Y
    local z = unit.Z
    local v45 = -a33.Z
    local z2 = v34.Z
    local v47 = (x * (v42 * z2 - (y2 * v45))) - (v39 * (y * z2 - (y2 * z))) + x2 * (y * v45 - (v42 * z))

    if v47 == 0 then
        return Vector3.new(0, 0, 0)
    end

    local v48 = -a33.X
    local x3 = v34.X
    local v50 = -a33.Y
    local y3 = v34.Y
    local v52 = -a33.Z
    local z3 = v34.Z
    local v54 = ((v35 * (v50 * z3 - (y3 * v52))) - (v48 * (v36 * z3 - (y3 * v37))) + (x3 * (v36 * v52 - (v50 * v37)))) / v47
    local x4 = unit.X
    local x5 = v34.X
    local y4 = unit.Y
    local y5 = v34.Y
    local z4 = unit.Z
    local z5 = v34.Z
    local v61 = ((x4 * (v36 * z5 - (y5 * v37))) - (v35 * (y4 * z5 - (y5 * z4))) + (x5 * (y4 * v37 - (v36 * z4)))) / v47
    local v62 = a30 + v54 * unit
    local v63 = a32 + v61 * a33
    local v64 = v62 + (v63 - v62) * 0.5

    if (v63 - v62).Magnitude < 0.25 then
        return v64
    end

    return Vector3.new(0, 0, 0)
end

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"))
local v66 = setmetatable({}, BaseOcclusion)
v66.__index = v66

function v66.new()
    --[[
      name: new
      line: 137
      upvalues:
        BaseOcclusion (copy, index: 1)
        v66 (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    local v67 = setmetatable(BaseOcclusion.new(), v66)
    v67.char = nil
    v67.humanoidRootPart = nil
    v67.torsoPart = nil
    v67.headPart = nil
    v67.childAddedConn = nil
    v67.childRemovedConn = nil
    v67.behaviors = {}
    v67.behaviors[v6.LIMBS] = v67.LimbBehavior
    v67.behaviors[v6.MOVEMENT] = v67.MoveBehavior
    v67.behaviors[v6.CORNERS] = v67.CornerBehavior
    v67.behaviors[v6.CIRCLE1] = v67.CircleBehavior
    v67.behaviors[v6.CIRCLE2] = v67.CircleBehavior
    v67.behaviors[v6.LIMBMOVE] = v67.LimbMoveBehavior
    v67.behaviors[v6.SMART_CIRCLE] = v67.SmartCircleBehavior
    v67.behaviors[v6.CHAR_OUTLINE] = v67.CharacterOutlineBehavior
    v67.mode = v6.SMART_CIRCLE
    v67.behaviorFunction = v67.SmartCircleBehavior
    v67.savedHits = {}
    v67.trackedLimbs = {}
    v67.camera = game.Workspace.CurrentCamera
    v67.enabled = false

    return v67
end

function v66.Enable(a68, enabled)
    --[[
      name: Enable
      line: 170
    ]]
    a68.enabled = enabled

    if not enabled then
        a68:Cleanup()
    end
end

function v66.GetOcclusionMode(a70)
    --[[
      name: GetOcclusionMode
      line: 178
    ]]
    return Enum.DevCameraOcclusionMode.Invisicam
end

function v66.LimbBehavior(a71, a72)
    --[[
      name: LimbBehavior
      line: 184
    ]]
    for key, _ in pairs(a71.trackedLimbs) do
        a72[#a72 + 1] = key.Position
    end
end

function v66.MoveBehavior(a75, a76)
    --[[
      name: MoveBehavior
      line: 190
    ]]
    for index = 1, 3 do
        local position = a75.humanoidRootPart.Position
        local velocity = a75.humanoidRootPart.Velocity
        local v80 = Vector3.new(velocity.X, 0, velocity.Z).Magnitude / 2
        local v81 = (index - 1) * a75.humanoidRootPart.CFrame.lookVector * v80
        a76[#a76 + 1] = position + v81
    end
end

function v66.CornerBehavior(a82, a83)
    --[[
      name: CornerBehavior
      line: 199
      upvalues:
        v8 (copy, index: 1)
    ]]
    local cFrame = a82.humanoidRootPart.CFrame
    local position = cFrame.Position
    local v86 = cFrame - position
    local v87 = a82.char:GetExtentsSize() / 2
    a83[#a83 + 1] = position

    for index = 1, #v8 do
        a83[#a83 + 1] = position + (v86 * (v87 * v8[index]))
    end
end

function v66.CircleBehavior(a89, a90)
    --[[
      name: CircleBehavior
      line: 210
      upvalues:
        v6 (copy, index: 1)
    ]]
    local v91

    if a89.mode ~= v6.CIRCLE1 then
        local coordinateFrame = a89.camera.CoordinateFrame
        v91 = coordinateFrame - coordinateFrame.Position + a89.humanoidRootPart.Position
    else
        v91 = a89.humanoidRootPart.CFrame
    end

    a90[#a90 + 1] = v91.Position

    for index = 0, 9 do
        local v94 = 0.6283185307179586 * index
        local vector3 = Vector3.new(math.cos(v94), math.sin(v94), 0) * 3
        a90[#a90 + 1] = v91 * vector3
    end
end

function v66.LimbMoveBehavior(a96, a97)
    --[[
      name: LimbMoveBehavior
      line: 226
    ]]
    a96:LimbBehavior(a97)
    a96:MoveBehavior(a97)
end

function v66.CharacterOutlineBehavior(a98, a99)
    --[[
      name: CharacterOutlineBehavior
      line: 231
      upvalues:
        userFlag (copy, index: 1)
        raycastParams2 (copy, index: 2)
    ]]
    local unit = a98.torsoPart.CFrame.upVector.unit
    local unit2 = a98.torsoPart.CFrame.rightVector.unit
    a99[#a99 + 1] = a98.torsoPart.CFrame.Position
    a99[#a99 + 1] = a98.torsoPart.CFrame.Position + unit
    a99[#a99 + 1] = a98.torsoPart.CFrame.Position - unit
    a99[#a99 + 1] = a98.torsoPart.CFrame.Position + unit2
    a99[#a99 + 1] = a98.torsoPart.CFrame.Position - unit2

    if a98.headPart then
        a99[#a99 + 1] = a98.headPart.CFrame.Position
    end

    local cframe = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(a98.camera.CoordinateFrame.lookVector.X, 0, a98.camera.CoordinateFrame.lookVector.Z)))
    local position = a98.torsoPart and a98.torsoPart.Position or a98.humanoidRootPart.Position
    local whitelistDescendantsTable = {a98.torsoPart}

    if a98.headPart then
        whitelistDescendantsTable[#whitelistDescendantsTable + 1] = a98.headPart
    end

    for index = 1, 24 do
        local v106 = math.tau * index / 24
        local vector3 = cframe * (Vector3.new(math.cos(v106), math.sin(v106), 0) * 3)
        local vector32 = Vector3.new(vector3.X, math.max(vector3.Y, -2.25), vector3.Z)

        if userFlag then
            raycastParams2.FilterDescendantsInstances = whitelistDescendantsTable

            if const raycastResult = game.Workspace:Raycast(position + vector32, -3 * vector32, raycastParams2) then
                local position2 = raycastResult.Position
                a99[#a99 + 1] = position2 + (0.2 * (position - position2).unit)
            end
        else
            local ray = Ray.new(position + vector32, -3 * vector32)
            local partOnRay, v113 = game.Workspace:FindPartOnRayWithWhitelist(ray, whitelistDescendantsTable, false)
            if partOnRay then
                a99[#a99 + 1] = v113 + (0.2 * (position - v113).unit)
            end
        end
    end
end

function v66.SmartCircleBehavior(a114, a115)
    --[[
      name: SmartCircleBehavior
      line: 285
      upvalues:
        userFlag (copy, index: 1)
        raycastParams (copy, index: 2)
        RayIntersection (copy, index: 3)
    ]]
    local unit = a114.torsoPart.CFrame.upVector.unit
    local unit2 = a114.torsoPart.CFrame.rightVector.unit
    a115[#a115 + 1] = a114.torsoPart.CFrame.Position
    a115[#a115 + 1] = a114.torsoPart.CFrame.Position + unit
    a115[#a115 + 1] = a114.torsoPart.CFrame.Position - unit
    a115[#a115 + 1] = a114.torsoPart.CFrame.Position + unit2
    a115[#a115 + 1] = a114.torsoPart.CFrame.Position - unit2

    if a114.headPart then
        a115[#a115 + 1] = a114.headPart.CFrame.Position
    end

    local v118 = a114.camera.CFrame - a114.camera.CFrame.Position
    local position = a114.torsoPart and a114.torsoPart.Position or a114.humanoidRootPart.Position
    local origin = Vector3.new(0, 0.5, 0) + position

    for index = 1, 24 do
        local v122 = 0.2617993877991494 * index - 1.5707963267948966
        local v123 = origin + v118 * (Vector3.new(math.cos(v122), math.sin(v122), 0) * 2.5)
        local v124 = v123 - a114.camera.CFrame.Position

        if userFlag then
            local v125
            raycastParams.FilterDescendantsInstances = {a114.char}

            if const raycastResult = game.Workspace:Raycast(origin, v123 - origin, raycastParams) then
                local position2 = raycastResult.Position
                local normal = raycastResult.Normal
                v125 = position2 + 0.1 * normal.unit
                local v129 = v125 - origin
                local unit3 = v129:Cross(v124).unit
                local unit4 = unit3:Cross(normal).unit
                local unit5 = (v125 - a114.camera.CFrame.Position).unit

                if v129.unit:Dot(-unit4) < v129.unit:Dot(unit5) then
                    local v133 = RayIntersection(v125, unit4, v123, v124)

                    if 0 < v133.Magnitude then
                        v125 = if const raycastResult2 = game.Workspace:Raycast(v125, v133 - v125, raycastParams) then raycastResult2.Position + (0.1 * raycastResult2.Normal.Unit) else v133
                    end
                end

                if const raycastResult3 = game.Workspace:Raycast(origin, v125 - origin, raycastParams) then
                    v125 = raycastResult3.Position - (0.1 * (v125 - origin).unit)
                end
            else
                v125 = v123
            end

            a115[#a115 + 1] = v125
        else
            local v136
            local ray = Ray.new(origin, v123 - origin)
            local partOnRay, v139, v140 = game.Workspace:FindPartOnRayWithIgnoreList(ray, {a114.char}, false, false)

            if partOnRay then
                v136 = v139 + 0.1 * v140.unit
                local v141 = v136 - origin
                local unit6 = v141:Cross(v124).unit
                local unit7 = unit6:Cross(v140).unit
                local unit8 = (v136 - a114.camera.CFrame.Position).unit

                if v141.unit:Dot(-unit7) < v141.unit:Dot(unit8) then
                    local v145 = RayIntersection(v136, unit7, v123, v124)

                    if 0 < v145.Magnitude then
                        local ray2 = Ray.new(v136, v145 - v136)
                        local partOnRay2, v148, v149 = game.Workspace:FindPartOnRayWithIgnoreList(ray2, {a114.char}, false, false)
                        v136 = if partOnRay2 then v148 + (0.1 * v149.unit) else v145
                    end
                end

                local ray3 = Ray.new(origin, v136 - origin)
                local partOnRay3, v152 = game.Workspace:FindPartOnRayWithIgnoreList(ray3, {a114.char}, false, false)
                if partOnRay3 then
                    v136 = v152 - (0.1 * (v136 - origin).unit)
                end
            else
                v136 = v123
            end

            a115[#a115 + 1] = v136
        end
    end
end

function v66.CheckTorsoReference(a153)
    --[[
      name: CheckTorsoReference
      line: 421
    ]]
    if a153.char then
        a153.torsoPart = a153.char:FindFirstChild("Torso")

        if not a153.torsoPart then
            a153.torsoPart = a153.char:FindFirstChild("UpperTorso")

            if not a153.torsoPart then
                a153.torsoPart = a153.char:FindFirstChild("HumanoidRootPart")
            end
        end

        a153.headPart = a153.char:FindFirstChild("Head")
    end
end

function v66.CharacterAdded(a154, char, a156)
    --[[
      name: CharacterAdded
      line: 435
      upvalues:
        players (copy, index: 1)
        v7 (copy, index: 2)
    ]]
    if a156 ~= players.LocalPlayer then
        return
    end

    if a154.childAddedConn then
        a154.childAddedConn:Disconnect()
        a154.childAddedConn = nil
    end

    if a154.childRemovedConn then
        a154.childRemovedConn:Disconnect()
        a154.childRemovedConn = nil
    end

    a154.char = char
    a154.trackedLimbs = {}

    a154.childAddedConn = char.ChildAdded:Connect(
        function(a157)
            --[[
              name: childAdded
              line: 453
              upvalues:
                v7 (copy, index: 1)
                a154 (copy, index: 2)
            ]]
            if a157:IsA("BasePart") then
                if v7[a157.Name] then
                    a154.trackedLimbs[a157] = true
                end

                if a157.Name == "Torso" or a157.Name == "UpperTorso" then
                    a154.torsoPart = a157
                end

                if a157.Name == "Head" then
                    a154.headPart = a157
                end
            end
        end
    )

    a154.childRemovedConn = char.ChildRemoved:Connect(
        function(trackedLimbKey)
            --[[
              name: childRemoved
              line: 469
              upvalues:
                a154 (copy, index: 1)
            ]]
            a154.trackedLimbs[trackedLimbKey] = nil
            a154:CheckTorsoReference()
        end
    )

    for _, child in pairs(a154.char:GetChildren()) do
        if child:IsA("BasePart") then
            if v7[child.Name] then
                a154.trackedLimbs[child] = true
            end

            if child.Name == "Torso" or child.Name == "UpperTorso" then
                a154.torsoPart = child
            end

            if child.Name ~= "Head" then
                continue
            end

            a154.headPart = child
        end
    end
end

function v66.SetMode(mode2, mode)
    --[[
      name: SetMode
      line: 483
      upvalues:
        AssertTypes (copy, index: 1)
        v6 (copy, index: 2)
    ]]
    AssertTypes(mode, "number")

    for _, v164 in pairs(v6) do
        if v164 == mode then
            mode2.mode = mode
            mode2.behaviorFunction = mode2.behaviors[mode2.mode]

            return
        end
    end

    error("Invalid mode number")
end

function v66.GetObscuredParts(a165)
    --[[
      name: GetObscuredParts
      line: 495
    ]]
    return a165.savedHits
end

function v66.Cleanup(a166)
    --[[
      name: Cleanup
      line: 500
    ]]
    for key, localTransparencyModifier in pairs(a166.savedHits) do
        key.LocalTransparencyModifier = localTransparencyModifier
    end
end

function v66.Update(a169, a170, a171, a172, a173)
    --[[
      name: Update
      line: 506
      upvalues:
        userFlag2 (copy, index: 1)
    ]]
    local engineInterface = a173.engineInterface
    local player = engineInterface.player
    local character = engineInterface.character

    if userFlag2 and engineInterface.characterChanged and player and character then
        a169:CharacterAdded(character, player)
    end

    if not a169.enabled or not a169.char then
        return a171, a172
    end

    local v177
    a169.camera = game.Workspace.CurrentCamera

    if not a169.humanoidRootPart then
        local humanoid = a169.char:FindFirstChildOfClass("Humanoid")

        if not humanoid or not humanoid.RootPart then
            a169.humanoidRootPart = a169.char:FindFirstChild("HumanoidRootPart")

            if not a169.humanoidRootPart then
                return a171, a172
            end
        else
            a169.humanoidRootPart = humanoid.RootPart
        end

        local v179 = nil

        v179 = a169.humanoidRootPart.AncestryChanged:Connect(
            function(a180, a181)
                --[[
                  line: 539
                  upvalues:
                    a169 (copy, index: 1)
                    v179 (ref,  index: 2)
                ]]
                if a180 == a169.humanoidRootPart and not a181 then
                    a169.humanoidRootPart = nil

                    if v179 and v179.Connected then
                        v179:Disconnect()
                        v179 = nil
                    end
                end
            end
        )
    end

    if not a169.torsoPart then
        a169:CheckTorsoReference()

        if not a169.torsoPart then
            return a171, a172
        end
    end

    local v182 = {}
    a169.behaviorFunction(a169, v182)
    local v183 = {}
    local v184 = {a169.char}

    local function add(savedHitKey)
        --[[
          name: add
          line: 565
          upvalues:
            v183 (copy, index: 1)
            a169 (copy, index: 2)
        ]]
        v183[savedHitKey] = true

        if not a169.savedHits[savedHitKey] then
            a169.savedHits[savedHitKey] = savedHitKey.LocalTransparencyModifier
        end
    end

    local v187 = 0
    local v188 = {}
    local v189 = 0.75
    local v190 = 0.75
    local v191 = a169.headPart and a169.headPart.CFrame.Position or v182[1]
    local v192 = a169.torsoPart and a169.torsoPart.CFrame.Position or v182[2]
    local partsObscuringTarget = a169.camera:GetPartsObscuringTarget({v191, v192}, v184)
    v177 = v187

    for index = 1, #partsObscuringTarget do
        local v195 = partsObscuringTarget[index]
        v177 += 1
        v188[v195] = true

        for _, child in pairs(v195:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                v177 += 1
                break
            end
        end
    end

    if 0 < v177 then
        v189 = math.pow((0.375 / v177) + 0.375, 1 / v177)
        v190 = math.pow((0.25 / v177) + 0.25, 1 / v177)
    end

    local partsObscuringTarget2 = a169.camera:GetPartsObscuringTarget(v182, v184)
    local v199 = {}

    for index = 1, #partsObscuringTarget2 do
        local savedHitKey = partsObscuringTarget2[index]
        v199[savedHitKey] = v188[savedHitKey] and v189 or v190

        if savedHitKey.Transparency < v199[savedHitKey] then
            v183[savedHitKey] = true

            if not a169.savedHits[savedHitKey] then
                a169.savedHits[savedHitKey] = savedHitKey.LocalTransparencyModifier
            end
        end

        for _, savedHitKey2 in pairs(savedHitKey:GetChildren()) do
            if not savedHitKey2:IsA("Decal") and not savedHitKey2:IsA("Texture") then
                continue
            end

            if savedHitKey2.Transparency < v199[savedHitKey] then
                v199[savedHitKey2] = v199[savedHitKey]
                v183[savedHitKey2] = true

                if a169.savedHits[savedHitKey2] then
                    continue
                end

                a169.savedHits[savedHitKey2] = savedHitKey2.LocalTransparencyModifier
            end
        end
    end

    for savedHitKey, localTransparencyModifier in pairs(a169.savedHits) do
        if v183[savedHitKey] then
            savedHitKey.LocalTransparencyModifier = savedHitKey.Transparency < 1
                and (v199[savedHitKey] - savedHitKey.Transparency) / (1 - savedHitKey.Transparency)
                or 0
        else
            savedHitKey.LocalTransparencyModifier = localTransparencyModifier
            a169.savedHits[savedHitKey] = nil
        end
    end

    return a171, a172
end

return v66