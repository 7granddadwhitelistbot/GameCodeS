local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local u1 = RunService_upv_1:IsStudio()
local Simulation_upv_1 = require(script.Parent.Parent:WaitForChild("Simulation"))
local FrameClock_1 = require(script.Parent:WaitForChild("FrameClock"))
local BodyProxy_upv_1 = require(script.Parent:WaitForChild("BodyProxy"))
local tbl_1 = {}
local u2 = Simulation_upv_1.CORRECTION_MAX or 20
local u3 = Vector3.new(0, 0, 0)
local u4 = Vector3.new(0, 0, 0)
local u5 = Vector3.new(0, 0, 0)
local u6 = 0
local u7 = nil
local u8 = nil
local u9 = nil
local u10 = 0
local u11 = 0
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u12 = FrameClock_1.new()
local u13 = nil
local u14 = nil
local u15 = nil
local u16 = nil
local u17 = 0
local u18 = false
local u19 = 0
local u20 = 0
local u21 = 1
local u22 = 0
local u23 = false
local u24 = true
local CFrame_upv_1 = nil
local u25 = nil
local u26 = nil
local u27 = nil
local function r4(a1)
    --[[
      name: r4
      line: 89
    ]]
    return math.floor((a1 * 10000) + 0.5) / 10000
end
local function traceFrame(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: traceFrame
      line: 93
      upvalues:
        u27 (ref, index: 1)
        u3 (ref, index: 2)
        u5 (ref, index: 3)
    ]]
    local v1 = u27
    if not v1 then
        return
    end
    if not (#v1 >= 20000) then
        local tbl_4 = {}
        local v2 = math.floor((os.clock() * 10000) + 0.5) / 10000
        local v3 = math.floor((a1 * 10000) + 0.5) / 10000
        local v4 = math.floor((a2 * 10000) + 0.5) / 10000
        local v5 = (a4 and 1) or 0
        local v6 = math.floor((a5.X * 10000) + 0.5) / 10000
        local v7 = math.floor((a5.Y * 10000) + 0.5) / 10000
        local v8 = math.floor((a5.Z * 10000) + 0.5) / 10000
        local v9 = math.floor(((u3.X + u5.X) * 10000) + 0.5) / 10000
        local v10 = math.floor(((u3.Y + u5.Y) * 10000) + 0.5) / 10000
        local v11 = math.floor(((u3.Z + u5.Z) * 10000) + 0.5) / 10000
        local v12 = math.floor((a6.X * 10000) + 0.5) / 10000
        local v13 = math.floor((a6.Y * 10000) + 0.5) / 10000
        local v14 = math.floor((a6.Z * 10000) + 0.5) / 10000
        tbl_4[1], tbl_4[2], tbl_4[3], tbl_4[4], tbl_4[5], tbl_4[6], tbl_4[7], tbl_4[8], tbl_4[9], tbl_4[10], tbl_4[11], tbl_4[12], tbl_4[13], tbl_4[14], tbl_4[15] = v2, v3, v4, a3, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, (a7 and 1) or 0
        table.insert(u27, tbl_4)
    end
end
local function onStep(a1)
    --[[
      name: onStep
      line: 108
      upvalues:
        RunService_upv_1 (copy, index: 1)
        u18 (ref,  index: 2)
        u17 (ref,  index: 3)
        u12 (copy, index: 4)
        u13 (ref,  index: 5)
        u15 (ref,  index: 6)
        u16 (ref,  index: 7)
        u14 (ref,  index: 8)
    ]]
    if RunService_upv_1:IsResimulating() then
        u18 = true
    else
        u17 = u17 + 1
        u12:Step()
    end
    if u13 then
        local CFrame_2 = u13.CFrame
        u15 = CFrame_2.Rotation
        u16 = CFrame_2.Position
        u14 = u13
    else
        u15 = nil
        u16 = nil
        u14 = nil
    end
end
local function localRoot()
    --[[
      name: localRoot
      line: 124
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local v15 = LocalPlayer_1 and (LocalPlayer_1.Character)
    LocalPlayer_1 = v15 and (v15:FindFirstChild("HumanoidRootPart"))
    if LocalPlayer_1 and LocalPlayer_1:IsA("BasePart") and LocalPlayer_1:IsDescendantOf(workspace) then
        return LocalPlayer_1
    end
    return nil
end
local function noteCorrection(a1, a2, a3)
    --[[
      name: noteCorrection
      line: 134
      upvalues:
        u10 (ref,  index: 1)
        u11 (ref,  index: 2)
        tbl_upv_3 (copy, index: 3)
        u1 (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
    ]]
    u10 = u10 + 1
    if u11 < a1 then
        u11 = a1
    end
    table.insert(tbl_upv_3, {a2, a3.X, a3.Y, a3.Z})
    if #tbl_upv_3 > 64 then
        table.remove(tbl_upv_3, 1)
    end
    if not u1 then
        return
    end
    table.insert(tbl_upv_2, string.format("%.2f:%.2f", a2, a1))
    if not (#tbl_upv_2 > 40) then
        return
    end
    table.remove(tbl_upv_2, 1)
end
local function clearFrame()
    --[[
      name: clearFrame
      line: 151
      upvalues:
        CFrame_upv_1 (ref, index: 1)
        u25 (ref, index: 2)
        u26 (ref, index: 3)
    ]]
    CFrame_upv_1 = nil
    u25 = nil
    u26 = nil
end
local function step(a1)
    --[[
      name: step
      line: 156
      upvalues:
        Players_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        Simulation_upv_1 (copy, index: 4)
        u17 (ref,  index: 5)
        u18 (ref,  index: 6)
        u23 (ref,  index: 7)
        u12 (copy, index: 8)
        u7 (ref,  index: 9)
        u9 (ref,  index: 10)
        u3 (ref,  index: 11)
        u4 (ref,  index: 12)
        u5 (ref,  index: 13)
        CFrame_upv_1 (ref,  index: 14)
        u25 (ref,  index: 15)
        u26 (ref,  index: 16)
        BodyProxy_upv_1 (copy, index: 17)
        u15 (ref,  index: 18)
        u16 (ref,  index: 19)
        u8 (ref,  index: 20)
        u22 (ref,  index: 21)
        u2 (copy, index: 22)
        u6 (ref,  index: 23)
        noteCorrection (copy, index: 24)
        u24 (ref,  index: 25)
        u14 (ref,  index: 26)
        u19 (ref,  index: 27)
        u20 (ref,  index: 28)
        u21 (ref,  index: 29)
        u27 (ref,  index: 30)
        traceFrame (copy, index: 31)
    ]]
    local LocalPlayer_2 = Players_upv_1.LocalPlayer
    local v16 = LocalPlayer_2 and (LocalPlayer_2.Character)
    LocalPlayer_2 = v16 and (v16:FindFirstChild("HumanoidRootPart"))
    local v17
    if LocalPlayer_2 and LocalPlayer_2:IsA("BasePart") and LocalPlayer_2:IsDescendantOf(workspace) then
        v17 = LocalPlayer_2
    else
        v17 = nil
    end
    local v18 = u1 and (workspace:GetAttribute("CamSmoothingOff") == true)
    _ = v17
    local v19 = Simulation_upv_1.TakeCorrection()
    u17 = 0
    u18 = false
    local v20
    if u23 then
        local v21 = os.clock()
        v20 = u12:Alpha(v21, u1)
    else
        v20 = 1
    end
    if v17 then
        local v22 = nil
        if not (v18) then
            v22 = v17.CFrame
            if v22.Position == v22.Position and v22.LookVector == v22.LookVector then
                local v23 = v17:GetAttribute("STp")
                local v24 = false
                if v17 == u7 then
                    if v23 == u8 then
                        v24 = true
                    else
                        v24 = false
                    end
                end
                local v25 = false
                if v24 and u18 and u17 == 0 then
                    local v26 = nil
                    if u9 then
                        v26 = v22.Position - u9
                        if v26.Magnitude > 0.02 then
                            v19 = v19 + v26
                            u22 = u22 + 1
                            v25 = true
                        end
                        Simulation_upv_1.RebaseCorrection()
                    end
                end
                local v27 = os.clock()
                if v24 then
                    local v28 = nil
                    if v19 ~= Vector3.new(0, 0, 0) then
                        v28 = v19.Magnitude
                        if u2 < v28 then
                            u3 = Vector3.new(0, 0, 0)
                            u4 = Vector3.new(0, 0, 0)
                            u5 = Vector3.new(0, 0, 0)
                        else
                            if u5 == Vector3.new(0, 0, 0) then
                                u6 = v27
                            end
                            u5 = u5 - v19
                            noteCorrection(v28, v27, v19)
                        end
                    end
                else
                    u3 = Vector3.new(0, 0, 0)
                    u4 = Vector3.new(0, 0, 0)
                    u5 = Vector3.new(0, 0, 0)
                    u15 = nil
                    u16 = nil
                    u12:Reset()
                end
                if u5 ~= Vector3.new(0, 0, 0) then
                    local v29 = nil
                    if v27 - u6 >= 0.05 then
                        u3 = u3 + u5
                        u5 = Vector3.new(0, 0, 0)
                        v29 = u3.Magnitude
                        if v29 > 1e-04 then
                            local v30 = u4:Dot(u3) / v29
                            if v30 > 0 then
                                u4 = u4 - (u3 * (v30 / v29))
                            end
                        end
                    end
                end
                u7 = v17
                u8 = v23
                u9 = v22.Position
                local v31 = math.min(a1, 0.1)
                if u5 == Vector3.new(0, 0, 0) or u5:Dot(u3) >= 0 then
                    local v32 = math.exp(v31 * -16)
                    local v33 = u4 + u3 * 16
                    u3 = (u3 + (v33 * v31)) * v32
                    u4 = (u4 - ((v33 * 16) * v31)) * v32
                    if u3.Magnitude < 0.003 and u4.Magnitude < 0.05 then
                        u3 = Vector3.new(0, 0, 0)
                        u4 = Vector3.new(0, 0, 0)
                    end
                end
                local v34 = u16
                local v35 = u15
                local v36
                local v39 = nil
                if u24 and v20 < 1 and v24 and v34 and v35 then
                    if u14 ~= v17 then
                        v36 = v22
                    else
                        v39 = v22.Position - v34
                        if v39.Magnitude < 6 then
                            v36 = CFrame.new(v22.Position - v39 * (1 - v20)) * v35:Lerp(v22.Rotation, v20)
                            u19 = u19 + 1
                            u20 = u20 + v20
                            u21 = math.min(u21, v20)
                        else
                            v36 = v22
                        end
                    end
                else
                    v36 = v22
                end
                local v38 = u3 + u5
                if u1 then
                    v39 = workspace:GetAttribute("SmoothingForceOffset")
                    if typeof(v39) == "Vector3" then
                        v38 = v38 + v39
                    end
                end
                if u27 then
                    traceFrame(v31, v20, u17, u18, v19, v22.Position - v36.Position, v25)
                end
                local v40 = v36.Position + v38
                if v40 ~= v40 or v36.LookVector ~= v36.LookVector then
                    u3 = Vector3.new(0, 0, 0)
                    u4 = Vector3.new(0, 0, 0)
                    u5 = Vector3.new(0, 0, 0)
                    u15 = nil
                    u16 = nil
                    u12:Reset()
                    v36, v38 = v22, Vector3.new(0, 0, 0)
                end
                CFrame_upv_1 = v22
                u26 = v36 + v38
                local v41
                if u24 then
                    v41 = u26
                else
                    v41 = nil
                end
                u25 = v41
                BodyProxy_upv_1.Render(v17, u25)
                if not (BodyProxy_upv_1.IsShown()) then
                    u25 = nil
                    u26 = v22 + v38
                end
                return
            end
            u7 = nil
            u9 = nil
            u3 = Vector3.new(0, 0, 0)
            u4 = Vector3.new(0, 0, 0)
            u5 = Vector3.new(0, 0, 0)
            u15 = nil
            u16 = nil
            CFrame_upv_1 = nil
            u25 = nil
            u26 = nil
            BodyProxy_upv_1.Render(nil, nil)
            return
        end
    end
    u7 = nil
    u9 = nil
    u3 = Vector3.new(0, 0, 0)
    u4 = Vector3.new(0, 0, 0)
    u5 = Vector3.new(0, 0, 0)
    CFrame_upv_1 = nil
    u25 = nil
    u26 = nil
    if v17 then
        CFrame_upv_1 = v17.CFrame
        u26 = CFrame_upv_1
    end
    BodyProxy_upv_1.Render(nil, nil)
end
local u28 = false
function tbl_1.Start()
    --[[
      name: Start
      line: 290
      upvalues:
        u28 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        step (copy, index: 3)
        BodyProxy_upv_1 (copy, index: 4)
        Simulation_upv_1 (copy, index: 5)
        onStep (copy, index: 6)
        u23 (ref,  index: 7)
        u1 (copy, index: 8)
    ]]
    if (u28) then
        return
    end
    if RunService_upv_1:IsClient() then
        u28 = true
        RunService_upv_1:BindToRenderStep("TribesSmoothing", Enum.RenderPriority.First.Value, step)
        RunService_upv_1:BindToRenderStep("TribesDrawnBodyHide", Enum.RenderPriority.Last.Value + 1, BodyProxy_upv_1.EnforceHidden)
        local success_1, v42 = pcall(
            function()
                --[[
                  line: 298
                  upvalues:
                    Simulation_upv_1 (copy, index: 1)
                    onStep (copy, index: 2)
                ]]
                Simulation_upv_1.BindStep(onStep, 0)
            end
        )
        u23 = success_1
        if not (success_1) and u1 then
            warn("[Smoothing] BindToSimulation unavailable, no interpolation (glide only): " .. tostring(v42))
        end
    end
end
function tbl_1.Offset()
    --[[
      name: Offset
      line: 309
      upvalues:
        u3 (ref, index: 1)
        u5 (ref, index: 2)
    ]]
    return u3 + u5
end
function tbl_1.CameraOffset()
    --[[
      name: CameraOffset
      line: 315
      upvalues:
        u26 (ref, index: 1)
        CFrame_upv_1 (ref, index: 2)
    ]]
    if u26 and CFrame_upv_1 then
        return u26.Position - CFrame_upv_1.Position
    end
    return Vector3.new(0, 0, 0)
end
function tbl_1.DrawnCFrame()
    --[[
      name: DrawnCFrame
      line: 325
      upvalues:
        u26 (ref, index: 1)
    ]]
    return u26
end
function tbl_1.Drawn(a1)
    --[[
      name: Drawn
      line: 331
      upvalues:
        BodyProxy_upv_1 (copy, index: 1)
    ]]
    return BodyProxy_upv_1.Drawn(a1)
end
function tbl_1.DrawnModel()
    --[[
      name: DrawnModel
      line: 336
      upvalues:
        BodyProxy_upv_1 (copy, index: 1)
    ]]
    return BodyProxy_upv_1.Model()
end
tbl_1.DrawnChanged = BodyProxy_upv_1.Changed
function tbl_1.SetBody(a1)
    --[[
      name: SetBody
      line: 344
      upvalues:
        u24 (ref,  index: 1)
        BodyProxy_upv_1 (copy, index: 2)
    ]]
    u24 = a1 == true
    BodyProxy_upv_1.SetEnabled(u24)
end
function tbl_1.BodyOn()
    --[[
      name: BodyOn
      line: 348
      upvalues:
        u24 (ref, index: 1)
    ]]
    return u24
end
function tbl_1.CorrectionsSince(a1)
    --[[
      name: CorrectionsSince
      line: 353
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local tbl_5 = {}
    for _, value_1 in tbl_upv_3 do
        if a1 <= value_1[1] then
            table.insert(tbl_5, value_1)
        end
    end
    return tbl_5
end
function tbl_1.SimCFrame(a1)
    --[[
      name: SimCFrame
      line: 365
    ]]
    return a1.CFrame
end
function tbl_1.Trace(a1)
    --[[
      name: Trace
      line: 371
      upvalues:
        u1 (copy, index: 1)
        u27 (ref,  index: 2)
    ]]
    if not u1 then
        return nil
    end
    local v43 = u27
    u27 = (a1 and {}) or nil
    return v43
end
function tbl_1.Reset()
    --[[
      name: Reset
      line: 380
      upvalues:
        u3 (ref,  index: 1)
        u4 (ref,  index: 2)
        u5 (ref,  index: 3)
        u7 (ref,  index: 4)
        u9 (ref,  index: 5)
        u15 (ref,  index: 6)
        u16 (ref,  index: 7)
        u12 (copy, index: 8)
    ]]
    u3 = Vector3.new(0, 0, 0)
    u4 = Vector3.new(0, 0, 0)
    u5 = Vector3.new(0, 0, 0)
    u7 = nil
    u9 = nil
    u15 = nil
    u16 = nil
    u12:Reset()
end
function tbl_1.Stats()
    --[[
      name: Stats
      line: 386
      upvalues:
        u10 (ref,  index: 1)
        u11 (ref,  index: 2)
        u3 (ref,  index: 3)
        u5 (ref,  index: 4)
        tbl_upv_2 (copy, index: 5)
        u24 (ref,  index: 6)
        u23 (ref,  index: 7)
        u22 (ref,  index: 8)
        u19 (ref,  index: 9)
        u20 (ref,  index: 10)
        u21 (ref,  index: 11)
        BodyProxy_upv_1 (copy, index: 12)
    ]]
    local tbl_6 = {interpAlphaMin = 0, interpAlphaAvg = 0}
    tbl_6.smoothedCorrections = u10
    tbl_6.largestCorrection = u11
    tbl_6.smoothingOffset = (u3 + u5).Magnitude
    tbl_6.recentCorrections = table.concat(tbl_upv_2, ",")
    tbl_6.smoothingBody = u24
    tbl_6.smoothingStepHook = u23
    tbl_6.smoothingNoStepCorrections = u22
    tbl_6.interpFrames = u19
    tbl_6.interpAlphaAvg = ((u19 > 0) and (u20 / u19)) or 1
    tbl_6.interpAlphaMin = u21
    for key_1, value_2 in BodyProxy_upv_1.Stats() do
        tbl_6[key_1] = value_2
    end
    return tbl_6
end
return tbl_1