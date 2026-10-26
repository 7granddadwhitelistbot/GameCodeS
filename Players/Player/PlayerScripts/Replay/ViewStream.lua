local Players_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Shared_upv_1 = ReplicatedStorage_1:WaitForChild("Shared")
local ReplayCodec_upv_1 = require(Shared_upv_1:WaitForChild("ReplayCodec"))
local Net_upv_1 = require(Shared_upv_1:WaitForChild("Net"))
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = 1 / ReplayCodec_upv_1.VIEW_HZ
local u2 = nil
task.spawn(
    function()
        --[[
          line: 28
          upvalues:
            Shared_upv_1 (copy, index: 1)
            u2 (ref,  index: 2)
        ]]
        local v1 = Shared_upv_1:WaitForChild("Camera", 20)
        if not v1 then
            return
        end
        if v1:IsA("ModuleScript") then
            local success_1, v2 = pcall(require, v1)
            if not success_1 or type(v2) ~= "table" then
                return
            end
            u2 = v2
        end
    end
)
local u3 = buffer.create(ReplayCodec_upv_1.VIEW_FORMAT_BYTES)
local u4 = 0
local u5 = 0
local u6 = 0
local u7 = 0
local u8 = -1
local u9 = -math.huge
local u10 = 0
local function live()
    --[[
      name: live
      line: 43
      upvalues:
        LocalPlayer_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
    ]]
    if LocalPlayer_upv_1:GetAttribute("State") == "Match" and LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
        if RunService_upv_1:IsStudio() and Workspace_upv_1:GetAttribute("ReplayViewOff") == true then
            return false
        end
        local Character_1 = LocalPlayer_upv_1.Character
        local v3 = Character_1 and (Character_1:FindFirstChildOfClass("Humanoid"))
        if v3 and not (v3.Health <= 0) and LocalPlayer_upv_1:GetAttribute("CombatMode") ~= false then
            if u2 then
                if u2.IsEnabled and not (u2.IsEnabled()) or u2.GetSpectateMode and u2.GetSpectateMode() ~= "none" then
                    return false
                end
                return true
            end
            return false
        end
        return false
    end
    return false
end
function tbl_1.Start()
    --[[
      name: Start
      line: 68
      upvalues:
        Net_upv_1 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        u10 (ref,  index: 3)
        u1 (copy, index: 4)
        live (copy, index: 5)
        u8 (ref,  index: 6)
        Workspace_upv_1 (copy, index: 7)
        u2 (ref,  index: 8)
        ReplayCodec_upv_1 (copy, index: 9)
        u5 (ref,  index: 10)
        u6 (ref,  index: 11)
        u7 (ref,  index: 12)
        u9 (ref,  index: 13)
        u3 (copy, index: 14)
        u4 (ref,  index: 15)
    ]]
    local u11 = Net_upv_1.UnreliableEvent("ReplayView")
    RunService_upv_1.Heartbeat:Connect(
        function(a1)
            --[[
              line: 70
              upvalues:
                u10 (ref,  index: 1)
                u1 (copy, index: 2)
                live (copy, index: 3)
                u8 (ref,  index: 4)
                Workspace_upv_1 (copy, index: 5)
                u2 (ref,  index: 6)
                ReplayCodec_upv_1 (copy, index: 7)
                u5 (ref,  index: 8)
                u6 (ref,  index: 9)
                u7 (ref,  index: 10)
                u9 (ref,  index: 11)
                u3 (copy, index: 12)
                u11 (copy, index: 13)
                u4 (ref,  index: 14)
            ]]
            u10 = u10 + a1
            if (u10 < u1) then
                return
            end
            u10 = 0
            if live() then
                local v4 = Workspace_upv_1.CurrentCamera
                if not v4 then
                    return
                end
                local v5 = v4.CFrame.LookVector
                local v6 = math.atan2(-v5.X, -v5.Z)
                local v7 = math.asin(math.clamp(v5.Y, -1, 1))
                local v8 = math.clamp(math.floor(v4.FieldOfView + 0.5), 20, 120)
                if u2.GetViewBobbing then
                    if u2.GetViewBobbing() ~= true then
                        v5 = v8
                    else
                        v5 = v8 + 128
                    end
                else
                    v5 = v8
                end
                local v9 = 0
                if u2.InFirstPerson then
                    if u2.InFirstPerson() ~= true then
                        v4 = v9
                    else
                        v4 = v9 + ReplayCodec_upv_1.F_FIRST
                    end
                else
                    v4 = v9
                end
                if u2.IsAiming and u2.IsAiming() == true then
                    v4 = v4 + ReplayCodec_upv_1.F_AIMCAM
                end
                if u2.GetShoulderSide then
                    v4 = ((u2.GetShoulderSide() < 0) and (v4 + ReplayCodec_upv_1.V_LEFT)) or v4
                end
                local v10 = os.clock()
                if math.abs((((v6 - u5) + math.pi) % math.tau) - math.pi) < 0.004363323129985824 and math.abs(v7 - u6) < 0.004363323129985824 and v5 == u7 and v4 == u8 and v10 - u9 < 0.4 then
                    return
                end
                u5 = v6
                u6 = v7
                u7 = v5
                u8 = v4
                u9 = v10
                buffer.writei16(u3, 0, ReplayCodec_upv_1.Q16(v6, ReplayCodec_upv_1.ROT_Q))
                buffer.writei16(u3, 2, ReplayCodec_upv_1.Q16(v7, ReplayCodec_upv_1.ROT_Q))
                buffer.writeu8(u3, 4, v5)
                buffer.writeu8(u3, 5, v4)
                u11:FireServer(u3)
                u4 = u4 + 1
            else
                u8 = -1
            end
        end
    )
end
function tbl_1.Sent()
    --[[
      name: Sent
      line: 117
      upvalues:
        u4 (ref, index: 1)
    ]]
    return u4
end
return tbl_1