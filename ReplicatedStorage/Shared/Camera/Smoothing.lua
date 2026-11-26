local players = game:GetService("Players")
local runService = game:GetService("RunService")
local isStudio = runService:IsStudio()
local Simulation = require(script.Parent.Parent:WaitForChild("Simulation"))
local FrameClock = require(script.Parent:WaitForChild("FrameClock"))
local BodyProxy = require(script.Parent:WaitForChild("BodyProxy"))
local v7 = {}
local correctionMax = Simulation.CORRECTION_MAX or 20
local v9 = Vector3.new(0, 0, 0)
local v10 = Vector3.new(0, 0, 0)
local v11 = Vector3.new(0, 0, 0)
local timestamp = 0
local v13 = nil
local sTp = nil
local position = nil
local count = 0
local maxMagnitude = 0
local parts = {}
local v19 = {}
local frameClock = FrameClock.new()
local v21 = nil
local v22 = nil
local rotation = nil
local position2 = nil
local v25 = 0
local v26 = false
local count2 = 0
local total = 0
local interpAlphaMin = 1
local count3 = 0
local success = false
local smoothingBody = true
local cFrame = nil
local v34 = nil
local v35 = nil
local v36 = nil

local function r4(a38)
    --[[
      name: r4
      line: 89
    ]]
    return math.floor((a38 * 10000) + 0.5) / 10000
end

local function traceFrame(a40: number, a41, a42: number, a43: boolean, a44, a45, a46: boolean)
    --[[
      name: traceFrame
      line: 93
      upvalues:
        v36 (ref, index: 1)
        v9 (ref, index: 2)
        v11 (ref, index: 3)
    ]]
    local v47 = v36

    if not v47 or 20000 <= #v47 then
        return
    end

    local v48
    local v49
    local v50 = math.floor((os.clock() * 10000) + 0.5) / 10000
    local v51 = math.floor((a40 * 10000) + 0.5) / 10000
    local v52 = math.floor((a41 * 10000) + 0.5) / 10000

    if a43 then
        v48 = 1
    else
        v48 = 0
    end

    local v53 = math.floor((a44.X * 10000) + 0.5) / 10000
    local v54 = math.floor((a44.Y * 10000) + 0.5) / 10000
    local v55 = math.floor((a44.Z * 10000) + 0.5) / 10000
    local v56 = math.floor(((v9.X + v11.X) * 10000) + 0.5) / 10000
    local v57 = math.floor(((v9.Y + v11.Y) * 10000) + 0.5) / 10000
    local v58 = math.floor(((v9.Z + v11.Z) * 10000) + 0.5) / 10000
    local v59 = math.floor((a45.X * 10000) + 0.5) / 10000
    local v60 = math.floor((a45.Y * 10000) + 0.5) / 10000
    local v61 = math.floor((a45.Z * 10000) + 0.5) / 10000

    if a46 then
        v49 = 1
    else
        v49 = 0
    end

    table.insert(v47, {v50, v51, v52, a42, v48, v53, v54, v55, v56, v57, v58, v59, v60, v61, v49})
end

local function onStep(a63)
    --[[
      name: onStep
      line: 108
      upvalues:
        runService (copy, index: 1)
        v26 (ref,  index: 2)
        v25 (ref,  index: 3)
        frameClock (copy, index: 4)
        v21 (ref,  index: 5)
        rotation (ref,  index: 6)
        position2 (ref,  index: 7)
        v22 (ref,  index: 8)
    ]]
    if runService:IsResimulating() then
        v26 = true
    else
        v25 += 1
        frameClock:Step()
    end

    if const v64 = v21 then
        local cFrame = v64.CFrame
        local rotation2 = cFrame.Rotation
        local position = cFrame.Position
        rotation = rotation2
        position2 = position
        v22 = v64

        return
    end

    rotation = nil
    position2 = nil
    v22 = nil
end

local function localRoot()
    --[[
      name: localRoot
      line: 124
      upvalues:
        players (copy, index: 1)
    ]]
    local v69 = players.LocalPlayer
    v69 = v69 and v69.Character
    local humanoidRootPart = v69 and v69:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and humanoidRootPart:IsA("BasePart") and v69:IsDescendantOf(workspace) then
        return humanoidRootPart
    end

    return nil
end

local function noteCorrection(magnitude, timestamp: number, a74)
    --[[
      name: noteCorrection
      line: 134
      upvalues:
        count (ref,  index: 1)
        maxMagnitude (ref,  index: 2)
        v19 (copy, index: 3)
        isStudio (copy, index: 4)
        parts (copy, index: 5)
    ]]
    count += 1

    if maxMagnitude < magnitude then
        maxMagnitude = magnitude
    end

    table.insert(v19, {timestamp, a74.X, a74.Y, a74.Z})

    if 64 < #v19 then
        table.remove(v19, 1)
    end

    if isStudio then
        table.insert(parts, string.format("%.2f:%.2f", timestamp, magnitude))

        if 40 < #parts then
            table.remove(parts, 1)
        end
    end
end

local function clearFrame()
    --[[
      name: clearFrame
      line: 151
      upvalues:
        cFrame (ref, index: 1)
        v34 (ref, index: 2)
        v35 (ref, index: 3)
    ]]
    cFrame = nil
    v34 = nil
    v35 = nil
end

local function step(deltaTime: number)
    --[[
      name: step
      line: 156
      upvalues:
        players (copy, index: 1)
        isStudio (copy, index: 2)
        v21 (ref,  index: 3)
        Simulation (copy, index: 4)
        v25 (ref,  index: 5)
        v26 (ref,  index: 6)
        success (ref,  index: 7)
        frameClock (copy, index: 8)
        v13 (ref,  index: 9)
        position (ref,  index: 10)
        v9 (ref,  index: 11)
        v10 (ref,  index: 12)
        v11 (ref,  index: 13)
        cFrame (ref,  index: 14)
        v34 (ref,  index: 15)
        v35 (ref,  index: 16)
        BodyProxy (copy, index: 17)
        rotation (ref,  index: 18)
        position2 (ref,  index: 19)
        sTp (ref,  index: 20)
        count3 (ref,  index: 21)
        correctionMax (copy, index: 22)
        timestamp (ref,  index: 23)
        noteCorrection (copy, index: 24)
        smoothingBody (ref,  index: 25)
        v22 (ref,  index: 26)
        count2 (ref,  index: 27)
        total (ref,  index: 28)
        interpAlphaMin (ref,  index: 29)
        v36 (ref,  index: 30)
        traceFrame (copy, index: 31)
    ]]
    local alpha
    local v79 = players.LocalPlayer
    v79 = v79 and v79.Character
    local humanoidRootPart = v79 and v79:FindFirstChild("HumanoidRootPart")
    local v81 = if humanoidRootPart and humanoidRootPart:IsA("BasePart") and v79:IsDescendantOf(workspace) then humanoidRootPart else nil
    local camSmoothingOff = isStudio and workspace:GetAttribute("CamSmoothingOff") == true
    v21 = v81
    local v83 = Simulation.TakeCorrection()
    local v84 = v25
    local v85 = v26
    v25 = 0
    v26 = false

    if success then
        local timestamp2 = os.clock()
        local smoothingInterp = isStudio and workspace:GetAttribute("SmoothingInterp") == true
        alpha = frameClock:Alpha(timestamp2, smoothingInterp)
    else
        alpha = 1
    end

    if v81 and not camSmoothingOff then
        local cFrame2 = v81.CFrame

        if cFrame2.Position ~= cFrame2.Position or cFrame2.LookVector ~= cFrame2.LookVector then
            v13 = nil
            position = nil
            v9 = Vector3.new(0, 0, 0)
            v10 = Vector3.new(0, 0, 0)
            v11 = Vector3.new(0, 0, 0)
            rotation = nil
            position2 = nil
            cFrame = nil
            v34 = nil
            v35 = nil
            BodyProxy.Render(nil, nil)

            return
        end

        local sTp2 = v81:GetAttribute("STp")
        local v90 = v81 == v13 and sTp2 == sTp
        local v91 = false

        if v90 and v85 and v84 == 0 and position then
            local v92 = cFrame2.Position - position

            if 0.02 < v92.Magnitude then
                v83 += v92
                count3 += 1
                v91 = true
            end

            Simulation.RebaseCorrection()
        end

        local smoothingForceOffset, magnitude
        local v95
        local v96, v97, v98 = false, false, false
        local timestamp3 = os.clock()

        if v90 then
            if v83 ~= Vector3.new(0, 0, 0) then
                magnitude = v83.Magnitude

                if not (correctionMax < magnitude) then
                    if v11 == Vector3.new(0, 0, 0) then
                        timestamp = timestamp3
                    end

                    v96 = true
                else
                    v9 = Vector3.new(0, 0, 0)
                    v10 = Vector3.new(0, 0, 0)
                    v11 = Vector3.new(0, 0, 0)
                end
            end
        else
            v9 = Vector3.new(0, 0, 0)
            v10 = Vector3.new(0, 0, 0)
            v11 = Vector3.new(0, 0, 0)
            rotation = nil
            position2 = nil
            frameClock:Reset()
        end

        if v96 then
            v11 -= v83
            noteCorrection(magnitude, timestamp3, v83)
        end

        if v11 ~= Vector3.new(0, 0, 0) and 0.05 <= timestamp3 - timestamp then
            v9 += v11
            v11 = Vector3.new(0, 0, 0)
            local magnitude2 = v9.Magnitude

            if 1e-04 < magnitude2 then
                local v101 = v10:Dot(v9) / magnitude2

                if 0 < v101 then
                    v10 -= (v9 * (v101 / magnitude2))
                end
            end
        end

        local position3 = cFrame2.Position
        v13 = v81
        sTp = sTp2
        position = position3
        local v103 = math.min(deltaTime, 0.1)

        if v11 == Vector3.new(0, 0, 0) then
            v97 = true
        elseif 0 <= v11:Dot(v9) then
            v97 = true
        end

        if v97 then
            local v104 = math.exp(v103 * -16)
            local v105 = v10 + v9 * 16
            local v106 = (v9 + (v105 * v103)) * v104
            local v107 = (v10 - ((v105 * 16) * v103)) * v104
            v9 = v106
            v10 = v107

            if v9.Magnitude < 0.003 and v10.Magnitude < 0.05 then
                v9 = Vector3.new(0, 0, 0)
                v10 = Vector3.new(0, 0, 0)
            end
        end

        local cFrame3 = cFrame2
        local position4 = position2
        local rotation2 = rotation

        if smoothingBody then
            if not (alpha < 1) then
                v95 = cFrame3
            elseif v90 then
                if position4 then
                    if rotation2 then
                        if v22 ~= v81 then
                            v95 = cFrame3
                        else
                            local v111 = cFrame2.Position - position4

                            if not (v111.Magnitude < 6) then
                                v95 = cFrame3
                            else
                                v95 = CFrame.new(cFrame2.Position - (v111 * (1 - alpha))) * rotation2:Lerp(cFrame2.Rotation, alpha)
                                count2 += 1
                                total += alpha
                                interpAlphaMin = math.min(interpAlphaMin, alpha)
                            end
                        end
                    else
                        v95 = cFrame3
                    end
                else
                    v95 = cFrame3
                end
            else
                v95 = cFrame3
            end
        else
            v95 = cFrame3
        end

        local v112 = v9 + v11

        if isStudio then
            smoothingForceOffset = workspace:GetAttribute("SmoothingForceOffset")

            if typeof(smoothingForceOffset) == "Vector3" then
                v112 += smoothingForceOffset
            end
        end

        if v36 then
            traceFrame(v103, alpha, v84, v85, v83, cFrame2.Position - v95.Position, v91)
        end

        local v113 = v95.Position + v112

        if v113 ~= v113 then
            v98 = true
        elseif v95.LookVector ~= v95.LookVector then
            v98 = true
        end

        if v98 then
            v9 = Vector3.new(0, 0, 0)
            v10 = Vector3.new(0, 0, 0)
            v11 = Vector3.new(0, 0, 0)
            rotation = nil
            position2 = nil
            frameClock:Reset()
            v112 = Vector3.new(0, 0, 0)
            v95 = cFrame2
        end

        cFrame = cFrame2
        v35 = v95 + v112

        if smoothingBody then
            v34 = v35
        else
            v34 = nil
        end

        BodyProxy.Render(v81, v34)

        if not BodyProxy.IsShown() then
            v34 = nil
            v35 = cFrame2 + v112
        end

        return
    end

    v13 = nil
    position = nil
    v9 = Vector3.new(0, 0, 0)
    v10 = Vector3.new(0, 0, 0)
    v11 = Vector3.new(0, 0, 0)
    cFrame = nil
    v34 = nil
    v35 = nil

    if v81 then
        cFrame = v81.CFrame
        v35 = cFrame
    end

    BodyProxy.Render(nil, nil)
end

local v114 = false

function v7.Start()
    --[[
      name: Start
      line: 290
      upvalues:
        v114 (ref,  index: 1)
        runService (copy, index: 2)
        step (copy, index: 3)
        BodyProxy (copy, index: 4)
        Simulation (copy, index: 5)
        onStep (copy, index: 6)
        success (ref,  index: 7)
        isStudio (copy, index: 8)
    ]]
    if not v114 and runService:IsClient() then
        v114 = true
        runService:BindToRenderStep("TribesSmoothing", Enum.RenderPriority.First.Value, step)
        runService:BindToRenderStep("TribesDrawnBodyHide", Enum.RenderPriority.Last.Value + 1, BodyProxy.EnforceHidden)
        local success2, result = pcall(
            function()
                --[[
                  line: 298
                  upvalues:
                    Simulation (copy, index: 1)
                    onStep (copy, index: 2)
                ]]
                Simulation.BindStep(onStep, 0)
            end
        )
        success = success2

        if not success2 and isStudio then
            warn("[Smoothing] BindToSimulation unavailable, no interpolation (glide only): " .. tostring(result))
        end
    end
end

function v7.Offset()
    --[[
      name: Offset
      line: 309
      upvalues:
        v9 (ref, index: 1)
        v11 (ref, index: 2)
    ]]
    return v9 + v11
end

function v7.CameraOffset()
    --[[
      name: CameraOffset
      line: 315
      upvalues:
        v35 (ref, index: 1)
        cFrame (ref, index: 2)
    ]]
    local v117 = v35
    local cFrame2 = cFrame

    if v117 and cFrame2 then
        return v117.Position - cFrame2.Position
    end

    return Vector3.new(0, 0, 0)
end

function v7.DrawnCFrame()
    --[[
      name: DrawnCFrame
      line: 325
      upvalues:
        v35 (ref, index: 1)
    ]]
    return v35
end

function v7.Drawn(a119)
    --[[
      name: Drawn
      line: 331
      upvalues:
        BodyProxy (copy, index: 1)
    ]]
    return BodyProxy.Drawn(a119)
end

function v7.DrawnModel()
    --[[
      name: DrawnModel
      line: 336
      upvalues:
        BodyProxy (copy, index: 1)
    ]]
    return BodyProxy.Model()
end

v7.DrawnChanged = BodyProxy.Changed

function v7.SetBody(body)
    --[[
      name: SetBody
      line: 344
      upvalues:
        smoothingBody (ref,  index: 1)
        BodyProxy (copy, index: 2)
    ]]
    smoothingBody = body == true
    BodyProxy.SetEnabled(smoothingBody)
end

function v7.BodyOn()
    --[[
      name: BodyOn
      line: 348
      upvalues:
        smoothingBody (ref, index: 1)
    ]]
    return smoothingBody
end

function v7.CorrectionsSince(a121)
    --[[
      name: CorrectionsSince
      line: 353
      upvalues:
        v19 (copy, index: 1)
    ]]
    local v122 = {}

    for _, v124 in v19 do
        if a121 <= v124[1] then
            table.insert(v122, v124)
        end
    end

    return v122
end

function v7.SimCFrame(a125)
    --[[
      name: SimCFrame
      line: 365
    ]]
    return a125.CFrame
end

function v7.Trace(a126)
    --[[
      name: Trace
      line: 371
      upvalues:
        isStudio (copy, index: 1)
        v36 (ref,  index: 2)
    ]]
    if not isStudio then
        return nil
    end

    local v127 = v36
    v36 = a126 and {} or nil

    return v127
end

function v7.Reset()
    --[[
      name: Reset
      line: 380
      upvalues:
        v9 (ref,  index: 1)
        v10 (ref,  index: 2)
        v11 (ref,  index: 3)
        v13 (ref,  index: 4)
        position (ref,  index: 5)
        rotation (ref,  index: 6)
        position2 (ref,  index: 7)
        frameClock (copy, index: 8)
    ]]
    v9 = Vector3.new(0, 0, 0)
    v10 = Vector3.new(0, 0, 0)
    v11 = Vector3.new(0, 0, 0)
    v13 = nil
    position = nil
    rotation = nil
    position2 = nil
    frameClock:Reset()
end

function v7.Stats()
    --[[
      name: Stats
      line: 386
      upvalues:
        count (ref,  index: 1)
        maxMagnitude (ref,  index: 2)
        v9 (ref,  index: 3)
        v11 (ref,  index: 4)
        parts (copy, index: 5)
        smoothingBody (ref,  index: 6)
        success (ref,  index: 7)
        count3 (ref,  index: 8)
        count2 (ref,  index: 9)
        total (ref,  index: 10)
        interpAlphaMin (ref,  index: 11)
        BodyProxy (copy, index: 12)
    ]]
    local v128 = {smoothedCorrections = count, largestCorrection = maxMagnitude, smoothingOffset = (v9 + v11).Magnitude, recentCorrections = table.concat(parts, ","), smoothingBody = smoothingBody, smoothingStepHook = success, smoothingNoStepCorrections = count3, interpFrames = count2, interpAlphaAvg = if 0 < count2 then total / count2 else 1}
    v128.interpAlphaMin = interpAlphaMin

    for v129, v130 in BodyProxy.Stats() do
        v128[v129] = v130
    end

    return v128
end

return v7