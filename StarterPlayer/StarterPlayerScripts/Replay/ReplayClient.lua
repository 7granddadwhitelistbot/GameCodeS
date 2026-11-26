local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local Net = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Net"))
require(replicatedStorage.Shared:WaitForChild("Loc")).Install()
local Player = require(script.Parent:WaitForChild("Player"))
local Puppets = require(script.Parent:WaitForChild("Puppets"))
local ViewStream = require(script.Parent:WaitForChild("ViewStream"))
ViewStream.Start()
local localPlayer = players.LocalPlayer
local v9 = {}
local v10 = Net.Event("MatchEvent")

v10.OnClientEvent:Connect(
    function(a11, a12)
        --[[
          line: 29
          upvalues:
            runService (copy, index: 1)
            v9 (copy, index: 2)
            Player (copy, index: 3)
            Puppets (copy, index: 4)
        ]]
        if a11 ~= "PlayOfTheGame" then
            if a11 == "MatchStart" then
                Player.Stop("new match")
                Puppets.ClearCache()

                return
            end

            if a11 == "RoundStart" then
                task.delay(
                    3,
                    function()
                        --[[
                          line: 46
                          upvalues:
                            Puppets (copy, index: 1)
                        ]]
                        pcall(Puppets.CacheMatch)
                    end
                )
            end
        else
            if runService:IsStudio() then
                table.insert(v9, a12)

                if 6 < #v9 then
                    table.remove(v9, 1)
                end
            end

            local success, result = pcall(Player.Play, a12)
            if not success then
                warn("[Replay] play failed:", result)
                pcall(Player.Stop, "error")
            end
        end
    end
)

localPlayer:GetAttributeChangedSignal("MatchId"):Connect(
    function()
        --[[
          line: 53
          upvalues:
            Player (copy, index: 1)
        ]]
        Player.Stop("match changed")
    end
)

localPlayer:GetAttributeChangedSignal("State"):Connect(
    function()
        --[[
          line: 56
          upvalues:
            localPlayer (copy, index: 1)
            Player (copy, index: 2)
            Puppets (copy, index: 3)
        ]]
        if localPlayer:GetAttribute("State") ~= "Match" then
            Player.Stop("left the match")
            Puppets.ClearCache()
        end
    end
)

if runService:IsStudio() then
    local replayDebug = Instance.new("BindableFunction")
    replayDebug.Name = "ReplayDebug"

    replayDebug.OnInvoke = function(a16, a17)
        --[[
          line: 66
          upvalues:
            Player (copy, index: 1)
            ViewStream (copy, index: 2)
            v9 (copy, index: 3)
            Puppets (copy, index: 4)
            runService (copy, index: 5)
            players (copy, index: 6)
        ]]
        if a16 == "skip" then
            Player.Skip()
            return true
        end

        if a16 == "stop" then
            Player.Stop("debug")
            return true
        end

        if a16 == "viewsent" then
            return ViewStream.Sent()
        end

        if a16 == "rate" then
            local v18
            local debugRate = Player.DebugRate

            if type(a17) ~= "number" then
                v18 = nil
            else
                v18 = a17
            end

            debugRate(v18)

            return true
        end

        if a16 == "camlog" then
            local v20
            local debugCamLog = Player.DebugCamLog

            if type(a17) ~= "boolean" then
                v20 = nil
            else
                v20 = a17
            end

            return debugCamLog(v20)
        end

        if a16 == "clips" then
            local v22 = {}

            for v23, v24 in v9 do
                v22[v23] = {focusId = v24.focusId, name = v24.name, title = v24.title, duration = v24.duration, startTime = v24.startTime, bytes = buffer.len(v24.clip)}
            end

            return v22
        end

        if a16 == "replay" then
            local v25

            if type(a17) ~= "number" then
                v25 = #v9
            else
                v25 = a17
            end

            local v26 = v9[v25]
            if not v26 then
                return false
            end

            Player.Play(v26)

            return true
        end

        if a16 == "frame" then
            local v27
            local Overlay = require(script.Parent:WaitForChild("Overlay"))
            local debugFrame = Overlay.DebugFrame

            if type(a17) ~= "number" then
                v27 = nil
            else
                v27 = a17
            end

            return debugFrame(v27)
        end

        if a16 == "diag" then
            local Diag = require(script.Parent:WaitForChild("Diag"))
            local line, hidden = Diag.LastLine()

            return {line = line, hidden = hidden}
        end

        if a16 == "cache" then
            Puppets.CacheMatch()
            return true
        end

        if a16 == "clearcache" then
            Puppets.ClearCache()
            return true
        end

        if a16 == "trace" then
            local PoseTrace = require(script.Parent:WaitForChild("PoseTrace"))

            if a17 ~= false then
                PoseTrace.Start()
            else
                PoseTrace.Stop()
            end

            return PoseTrace.Active()
        end

        if a16 == "freeze" then
            local v34
            local debugFreeze = Player.DebugFreeze

            if type(a17) ~= "number" then
                v34 = nil
            else
                v34 = a17
            end

            debugFreeze(v34)

            return true
        end

        if a16 == "sidecam" then
            runService:UnbindFromRenderStep("TribesReplaySideCam")

            if type(a17) ~= "string" then
                return false
            end

            local v36 = {40, -40, 90, -90, 140, -140, 0, 180}
            local v37 = 1
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.IgnoreWater = true

            runService:BindToRenderStep(
                "TribesReplaySideCam",
                Enum.RenderPriority.Camera.Value + 10,
                function()
                    --[[
                      line: 131
                      upvalues:
                        Player (copy, index: 1)
                        a17 (copy, index: 2)
                        Puppets (copy, index: 3)
                        players (copy, index: 4)
                        params (copy, index: 5)
                        v36 (copy, index: 6)
                        v37 (ref,  index: 7)
                    ]]
                    local v39 = Player.DebugPuppet(a17) or Puppets.FindLive(a17)
                    local humanoidRootPart = v39 and v39:FindFirstChild("HumanoidRootPart")

                    if not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
                        return
                    end

                    local filterDescendantsInstances = {v39}

                    for _, childName in {"Replay", "FX", "Projectiles"} do
                        if const child = workspace:FindFirstChild(childName) then
                            table.insert(filterDescendantsInstances, child)
                        end
                    end

                    for _, player in players:GetPlayers() do
                        if player.Character then
                            table.insert(filterDescendantsInstances, player.Character)
                        end
                    end

                    params.FilterDescendantsInstances = filterDescendantsInstances
                    local v47 = select(2, humanoidRootPart.CFrame:ToEulerAnglesYXZ())
                    local position = humanoidRootPart.Position + Vector3.new(0, 1.2000000476837158, 0)

                    local function spot(key)
                        --[[
                          name: spot
                          line: 152
                          upvalues:
                            position (copy, index: 1)
                            v47 (copy, index: 2)
                            v36 (copy, index: 3)
                        ]]
                        return position + CFrame.fromEulerAnglesYXZ(0, v47 + math.rad(v36[key]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8))
                    end

                    if workspace:Spherecast(position, 0.5, (position + CFrame.fromEulerAnglesYXZ(0, v47 + math.rad(v36[v37]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8))) - position, params) then
                        for index = 1, #v36 do
                            if not workspace:Spherecast(position, 0.5, (position + CFrame.fromEulerAnglesYXZ(0, v47 + math.rad(v36[index]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8))) - position, params) then
                                v37 = index
                                break
                            end
                        end
                    end

                    local camera = workspace.CurrentCamera
                    camera.CameraType = Enum.CameraType.Scriptable
                    local cframeLookAt = CFrame.lookAt
                    local v54 = v37
                    camera.CFrame = cframeLookAt(position + CFrame.fromEulerAnglesYXZ(0, v47 + math.rad(v36[v54]), 0):VectorToWorldSpace(Vector3.new(0, 0.800000011920929, -8)), humanoidRootPart.Position + Vector3.new(0, 0.6000000238418579, 0))
                    camera.FieldOfView = 60
                end
            )

            return true
        end

        if a16 ~= "match" then
            if a16 == "anim" then
                return Player.DebugAnim()
            end

            if a16 == "poses" then
                local PoseTrace = require(script.Parent:WaitForChild("PoseTrace"))
                return PoseTrace.Report()
            end

            return Player.DebugState()
        end

        local PoseTrace = require(script.Parent:WaitForChild("PoseTrace"))

        if type(a17) ~= "table" then
            return false
        end

        local v57 = Player.DebugPuppet(a17[1])
        if not v57 then
            return "no puppet"
        end

        local t, meanDeg, joints = PoseTrace.BestMatch(a17[1], v57, a17[2], a17[3])

        return {t = t, meanDeg = meanDeg, joints = joints}
    end

    replayDebug.Parent = localPlayer
end