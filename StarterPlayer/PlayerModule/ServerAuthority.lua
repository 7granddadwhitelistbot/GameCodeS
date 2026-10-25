local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local ControlModule_upv_1 = require(script.Parent:WaitForChild("ControlModule"))
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local CommonUtils_1 = require(script.Parent:WaitForChild("CommonUtils"))
local v1 = CommonUtils_1.get("FlagUtil")
local u1 = CommonUtils_1.get("PlayerModuleEventBus")
local u2 = v1.getUserFlag("UserDisableForceLocalHumanoidPrediction")
local u3 = false
function tbl_upv_1.PredictLocalHumanoid()
    --[[
      name: PredictLocalHumanoid
      line: 26
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    if Players_upv_1.LocalPlayer.Character then
        RunService_upv_1:SetPredictionMode(Players_upv_1.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), Enum.PredictionMode.On)
    else
        Players_upv_1.LocalPlayer.CharacterAdded:Connect(
            function(a1)
                --[[
                  line: 27
                  upvalues:
                    RunService_upv_1 (copy, index: 1)
                ]]
                RunService_upv_1:SetPredictionMode(a1:WaitForChild("HumanoidRootPart"), Enum.PredictionMode.On)
            end
        )
    end
end
function tbl_upv_1.initialize(a1)
    --[[
      name: initialize
      line: 38
      upvalues:
        u3 (ref, index: 1)
    ]]
    a1.isServerAuthority = u3
end
function tbl_upv_1.Initialize()
    --[[
      name: Initialize
      line: 42
      upvalues:
        u2 (copy, index: 1)
        RunService_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        u1 (copy, index: 4)
        ControlModule_upv_1 (copy, index: 5)
        u3 (ref,  index: 6)
    ]]
    if not (u2) and RunService_upv_1:IsClient() then
        tbl_upv_1.PredictLocalHumanoid()
    end
    if not (u1.data.inputsSetupComplete) and RunService_upv_1:IsServer() then
        u1:subscribe("INPUTS_SETUP"):Wait()
    end
    ControlModule_upv_1:InitializeServerAuthority()
    u3 = true
end
return tbl_upv_1