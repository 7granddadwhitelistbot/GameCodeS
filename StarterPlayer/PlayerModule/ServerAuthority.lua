local Class = {}
Class.__index = Class
local ControlModule = require(script.Parent:WaitForChild("ControlModule"))
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
local v6 = CommonUtils.get("FlagUtil")
local v7 = CommonUtils.get("PlayerModuleEventBus")
local userFlag = v6.getUserFlag("UserDisableForceLocalHumanoidPrediction")
local isServerAuthority = false

function Class.PredictLocalHumanoid()
    --[[
      name: PredictLocalHumanoid
      line: 27
      upvalues:
        runService (copy, index: 1)
        players (copy, index: 2)
    ]]
    if players.LocalPlayer.Character then
        local character = players.LocalPlayer.Character
        runService:SetPredictionMode(character:WaitForChild("HumanoidRootPart"), Enum.PredictionMode.On)

        return
    end

    players.LocalPlayer.CharacterAdded:Connect(
        function(character: Model)
            --[[
              line: 28
              upvalues:
                runService (copy, index: 1)
            ]]
            runService:SetPredictionMode(character:WaitForChild("HumanoidRootPart"), Enum.PredictionMode.On)
        end
    )
end

function Class.initialize(a12)
    --[[
      name: initialize
      line: 39
      upvalues:
        isServerAuthority (ref, index: 1)
    ]]
    a12.isServerAuthority = isServerAuthority
end

function Class.Initialize()
    --[[
      name: Initialize
      line: 43
      upvalues:
        userFlag (copy, index: 1)
        runService (copy, index: 2)
        Class (copy, index: 3)
        v7 (copy, index: 4)
        ControlModule (copy, index: 5)
        isServerAuthority (ref,  index: 6)
    ]]
    if not userFlag and runService:IsClient() then
        Class.PredictLocalHumanoid()
    end

    if not v7.data.inputsSetupComplete and runService:IsServer() then
        v7:subscribe("INPUTS_SETUP"):Wait()
    end

    ControlModule:InitializeServerAuthority()
    isServerAuthority = true
end

return Class