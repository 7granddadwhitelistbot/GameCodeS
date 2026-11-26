local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local childName = "ReplayCodec"
local child = require(shared:WaitForChild(childName))
local childName2 = "Net"
local child2 = require(shared:WaitForChild(childName2))
local v10 = {}
local localPlayer = players.LocalPlayer
local v12 = 1 / child.VIEW_HZ
local result = nil

task.spawn(
    function()
        --[[
          line: 28
          upvalues:
            shared (copy, index: 1)
            result (ref,  index: 2)
        ]]
        local camera = shared:WaitForChild("Camera", 20)

        if camera and camera:IsA("ModuleScript") then
            local success, result2 = pcall(require, camera)

            if success and type(result2) == "table" then
                result = result2
            end
        end
    end
)

local v17 = buffer.create(child.VIEW_FORMAT_BYTES)
local count = 0
local v19 = 0
local v20 = 0
local v21 = 0
local v22 = -1
local timestamp = -math.huge
local v24 = 0

local function live()
    --[[
      name: live
      line: 43
      upvalues:
        localPlayer (copy, index: 1)
        runService (copy, index: 2)
        workspace (copy, index: 3)
        result (ref,  index: 4)
    ]]
    if localPlayer:GetAttribute("State") ~= "Match" or localPlayer:GetAttribute("ReplayPlaying") == true then
        return false
    end
    if runService:IsStudio() and workspace:GetAttribute("ReplayViewOff") == true then
        return false
    end

    local instance = localPlayer.Character
    instance = instance and instance:FindFirstChildOfClass("Humanoid")

    if not instance or instance.Health <= 0 or localPlayer:GetAttribute("CombatMode") == false then
        return false
    end

    local result2 = result
    if not result2 then
        return false
    end
    if result2.IsEnabled and not result2.IsEnabled() then
        return false
    end
    if result2.GetSpectateMode and result2.GetSpectateMode() ~= "none" then
        return false
    end

    return true
end

function v10.Start()
    --[[
      name: Start
      line: 68
      upvalues:
        child2 (copy, index: 1)
        runService (copy, index: 2)
        v24 (ref,  index: 3)
        v12 (copy, index: 4)
        live (copy, index: 5)
        v22 (ref,  index: 6)
        workspace (copy, index: 7)
        result (ref,  index: 8)
        child (copy, index: 9)
        v19 (ref,  index: 10)
        v20 (ref,  index: 11)
        v21 (ref,  index: 12)
        timestamp (ref,  index: 13)
        v17 (copy, index: 14)
        count (ref,  index: 15)
    ]]
    local v28 = child2.UnreliableEvent("ReplayView")

    runService.Heartbeat:Connect(
        function(deltaTime: number)
            --[[
              line: 70
              upvalues:
                v24 (ref,  index: 1)
                v12 (copy, index: 2)
                live (copy, index: 3)
                v22 (ref,  index: 4)
                workspace (copy, index: 5)
                result (ref,  index: 6)
                child (copy, index: 7)
                v19 (ref,  index: 8)
                v20 (ref,  index: 9)
                v21 (ref,  index: 10)
                timestamp (ref,  index: 11)
                v17 (copy, index: 12)
                v28 (copy, index: 13)
                count (ref,  index: 14)
            ]]
            local v30
            v24 += deltaTime

            if v24 < v12 then
                return
            end

            v24 = 0

            if not live() then
                v22 = -1
                return
            end

            local camera = workspace.CurrentCamera
            if not camera then
                return
            end

            local lookVector = camera.CFrame.LookVector
            local v33 = math.atan2(-lookVector.X, -lookVector.Z)
            local v34 = math.asin((math.clamp(lookVector.Y, -1, 1)))
            local v35 = math.clamp(math.floor(camera.FieldOfView + 0.5), 20, 120)

            if result.GetViewBobbing and result.GetViewBobbing() == true then
                v35 += 128
            end

            local v36 = 0

            if result.InFirstPerson then
                v30 = if result.InFirstPerson() == true then v36 + child.F_FIRST else v36
            else
                v30 = v36
            end

            if result.IsAiming and result.IsAiming() == true then
                v30 += child.F_AIMCAM
            end

            if result.GetShoulderSide and result.GetShoulderSide() < 0 then
                v30 += child.V_LEFT
            end

            local timestamp2 = os.clock()

            if math.abs((((v33 - v19) + math.pi) % math.tau) - math.pi) < 0.004363323129985824
                and math.abs(v34 - v20) < 0.004363323129985824
                and v35 == v21
                and v30 == v22
            then
                if timestamp2 - timestamp < 0.4 then
                    return
                end
            end

            v19 = v33
            v20 = v34
            v21 = v35
            v22 = v30
            timestamp = timestamp2
            buffer.writei16(v17, 0, child.Q16(v33, child.ROT_Q))
            buffer.writei16(v17, 2, child.Q16(v34, child.ROT_Q))
            buffer.writeu8(v17, 4, v35)
            buffer.writeu8(v17, 5, v30)
            v28:FireServer(v17)
            count += 1
        end
    )
end

function v10.Sent()
    --[[
      name: Sent
      line: 117
      upvalues:
        count (ref, index: 1)
    ]]
    return count
end

return v10