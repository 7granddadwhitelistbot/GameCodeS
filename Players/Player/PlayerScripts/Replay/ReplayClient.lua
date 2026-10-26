local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Net_1 = require(ReplicatedStorage_1:WaitForChild("Shared"):WaitForChild("Net"))
require(ReplicatedStorage_1.Shared:WaitForChild("Loc")).Install()
local Player_upv_1 = require(script.Parent:WaitForChild("Player"))
local Puppets_upv_1 = require(script.Parent:WaitForChild("Puppets"))
local ViewStream_upv_1 = require(script.Parent:WaitForChild("ViewStream"))
ViewStream_upv_1.Start()
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
local tbl_upv_1 = {}
Net_1.Event("MatchEvent").OnClientEvent:Connect(
    function(a1, a2)
        --[[
          line: 29
          upvalues:
            RunService_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
            Player_upv_1 (copy, index: 3)
            Puppets_upv_1 (copy, index: 4)
        ]]
        if a1 == "PlayOfTheGame" then
            if RunService_upv_1:IsStudio() then
                table.insert(tbl_upv_1, a2)
                if #tbl_upv_1 > 6 then
                    table.remove(tbl_upv_1, 1)
                end
            end
            local success_1, v1 = pcall(Player_upv_1.Play, a2)
            if (success_1) then
                return
            end
            warn("[Replay] play failed:", v1)
            pcall(Player_upv_1.Stop, "error")
        elseif a1 == "MatchStart" then
            Player_upv_1.Stop("new match")
            Puppets_upv_1.ClearCache()
        elseif a1 == "RoundStart" then
            task.delay(
                3,
                function()
                    --[[
                      line: 46
                      upvalues:
                        Puppets_upv_1 (copy, index: 1)
                    ]]
                    pcall(Puppets_upv_1.CacheMatch)
                end
            )
        end
    end
)
LocalPlayer_upv_1:GetAttributeChangedSignal("MatchId"):Connect(
    function()
        --[[
          line: 53
          upvalues:
            Player_upv_1 (copy, index: 1)
        ]]
        Player_upv_1.Stop("match changed")
    end
)
LocalPlayer_upv_1:GetAttributeChangedSignal("State"):Connect(
    function()
        --[[
          line: 56
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            Player_upv_1 (copy, index: 2)
            Puppets_upv_1 (copy, index: 3)
        ]]
        if LocalPlayer_upv_1:GetAttribute("State") == "Match" then
            return
        end
        Player_upv_1.Stop("left the match")
        Puppets_upv_1.ClearCache()
    end
)
if RunService_upv_1:IsStudio() then
    local v2 = Instance.new("BindableFunction")
    v2.Name = "ReplayDebug"
    v2.OnInvoke = function(a1, a2)
        --[[
          line: 66
          upvalues:
            Player_upv_1 (copy, index: 1)
            ViewStream_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            Puppets_upv_1 (copy, index: 4)
            RunService_upv_1 (copy, index: 5)
            Players_upv_1 (copy, index: 6)
        ]]
        if a1 == "skip" then
            Player_upv_1.Skip()
            return true
        elseif a1 == "stop" then
            Player_upv_1.Stop("debug")
            return true
        elseif a1 == "viewsent" then
            return ViewStream_upv_1.Sent()
        elseif a1 == "rate" then
            local DebugRate_1 = Player_upv_1.DebugRate
            local v3
            if type(a2) ~= "number" then
                v3 = nil
            else
                v3 = a2
            end
            DebugRate_1(v3)
            return true
        elseif a1 == "camlog" then
            local DebugCamLog_1 = Player_upv_1.DebugCamLog
            local v3
            if type(a2) ~= "boolean" then
                v3 = nil
            else
                v3 = a2
            end
            return DebugCamLog_1(v3)
        elseif a1 ~= "clips" then
            local v4 = nil
            if a1 == "replay" then
                local v5 = ((type(a2) ~= "number") and (#tbl_upv_1)) or a2
                v4 = tbl_upv_1[v5]
                if v4 then
                    Player_upv_1.Play(v4)
                    return true
                end
                return false
            elseif a1 == "frame" then
                local DebugFrame_1 = require(script.Parent:WaitForChild("Overlay")).DebugFrame
                local v5
                if type(a2) ~= "number" then
                    v5 = nil
                else
                    v5 = a2
                end
                return DebugFrame_1(v5)
            elseif a1 == "diag" then
                local v6, v7 = require(script.Parent:WaitForChild("Diag")).LastLine()
                local tbl_2 = {}
                tbl_2.line = v6
                tbl_2.hidden = v7
                return tbl_2
            elseif a1 == "cache" then
                Puppets_upv_1.CacheMatch()
                return true
            elseif a1 == "clearcache" then
                Puppets_upv_1.ClearCache()
                return true
            elseif a1 == "trace" then
                local PoseTrace_1 = require(script.Parent:WaitForChild("PoseTrace"))
                if a2 ~= false then
                    PoseTrace_1.Start()
                else
                    PoseTrace_1.Stop()
                end
                return PoseTrace_1.Active()
            elseif a1 == "freeze" then
                local DebugFreeze_1 = Player_upv_1.DebugFreeze
                local v3
                if type(a2) ~= "number" then
                    v3 = nil
                else
                    v3 = a2
                end
                DebugFreeze_1(v3)
                return true
            elseif a1 == "sidecam" then
                RunService_upv_1:UnbindFromRenderStep("TribesReplaySideCam")
                if type(a2) ~= "string" then
                    return false
                end
                local tbl_upv_3 = {40, -40, 90, -90, 140, -140, 0, 180}
                local u1 = 1
                local u2 = RaycastParams.new()
                u2.FilterType = Enum.RaycastFilterType.Exclude
                u2.IgnoreWater = true
                RunService_upv_1:BindToRenderStep(
                    "TribesReplaySideCam",
                    Enum.RenderPriority.Camera.Value + 10,
                    function()
                        --[[
                          line: 131
                          upvalues:
                            Player_upv_1 (copy, index: 1)
                            a2 (copy, index: 2)
                            Puppets_upv_1 (copy, index: 3)
                            Players_upv_1 (copy, index: 4)
                            u2 (copy, index: 5)
                            tbl_upv_3 (copy, index: 6)
                            u1 (ref,  index: 7)
                        ]]
                        local v8 = Player_upv_1.DebugPuppet(a2) or (Puppets_upv_1.FindLive(a2))
                        local v9 = v8 and (v8:FindFirstChild("HumanoidRootPart"))
                        if not v9 or not v9:IsA("BasePart") then
                            return
                        end
                        local tbl_4 = {v8}
                        for _, value_1 in {"Replay", "FX", "Projectiles"} do
                            local v10 = workspace:FindFirstChild(value_1)
                            if v10 then
                                table.insert(tbl_4, v10)
                            end
                        end
                        for _, value_2 in Players_upv_1:GetPlayers() do
                            if value_2.Character then
                                table.insert(tbl_4, value_2.Character)
                            end
                        end
                        u2.FilterDescendantsInstances = tbl_4
                        local u3 = select(2, v8.CFrame:ToEulerAnglesYXZ())
                        local u4 = v8.Position + Vector3.new(0, 1.2000000476837158, 0)
                        local function spot(a3)
                            --[[
                              name: spot
                              line: 152
                              upvalues:
                                u4 (copy, index: 1)
                                u3 (copy, index: 2)
                                tbl_upv_3 (copy, index: 3)
                            ]]
                            return u4 + CFrame.fromEulerAnglesYXZ(0, u3 + math.rad(tbl_upv_3[a3]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8))
                        end
                        if workspace:Spherecast(u4, 0.5, (u4 + CFrame.fromEulerAnglesYXZ(0, u3 + math.rad(tbl_upv_3[u1]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8))) - u4, u2) then
                            for n_1 = 1, #tbl_upv_3 do
                                local v11 = workspace:Spherecast(u4, 0.5, (u4 + CFrame.fromEulerAnglesYXZ(0, u3 + math.rad(tbl_upv_3[n_1]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8))) - u4, u2)
                                if not (v11) then
                                    u1 = n_1
                                    break
                                end
                            end
                        end
                        local CurrentCamera_1 = workspace.CurrentCamera
                        CurrentCamera_1.CameraType = Enum.CameraType.Scriptable
                        CurrentCamera_1.CFrame = CFrame.lookAt(u4 + CFrame.fromEulerAnglesYXZ(0, u3 + math.rad(tbl_upv_3[u1]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8)), v8.Position + Vector3.new(0, 0.6000000238418579, 0))
                        CurrentCamera_1.FieldOfView = 60
                    end
                )
                return true
            elseif a1 ~= "match" then
                if a1 ~= "anim" then
                    if a1 ~= "poses" then
                        return Player_upv_1.DebugState()
                    end
                    return require(script.Parent:WaitForChild("PoseTrace")).Report()
                end
                return Player_upv_1.DebugAnim()
            else
                local PoseTrace_2 = require(script.Parent:WaitForChild("PoseTrace"))
                if type(a2) ~= "table" then
                    return false
                end
                local v12 = Player_upv_1.DebugPuppet(a2[1])
                if not v12 then
                    return "no puppet"
                end
                local v13, v14, v15 = PoseTrace_2.BestMatch(a2[1], v12, a2[2], a2[3])
                local tbl_5 = {}
                tbl_5.t = v13
                tbl_5.meanDeg = v14
                tbl_5.joints = v15
                return tbl_5
            end
        else
            local tbl_6 = {}
            for key_1, value_3 in tbl_upv_1 do
                tbl_6[key_1] = {focusId = value_3.focusId, name = value_3.name, title = value_3.title, duration = value_3.duration, startTime = value_3.startTime, bytes = buffer.len(value_3.clip)}
            end
            return tbl_6
        end
    end
    v2.Parent = LocalPlayer_upv_1
end