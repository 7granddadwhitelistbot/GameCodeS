local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local v3 = UserSettings():GetService("UserGameSettings")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
require(script.Parent.Types)
local v5 = CommonUtils.get("FlagUtil")
local userFlag = v5.getUserFlag("UserPlayerScriptsCCLIntegrationD")
    or v5.getUserFlag("UserPlayerScriptsCCLIntegrationDGA")
local userFlag2 = v5.getUserFlag("UserPlayerScriptsPlayerControlState2")
    or v5.getUserFlag("UserPlayerScriptsPlayerControlState2GA")
local userFlag3 = v5.getUserFlag("UserAbilitiesUserInterfaceB")
local userFlag4 = v5.getUserFlag("UserControlModuleDisabledUpdate")
local userFlag5 = v5.getUserFlag("UserPlayerModuleEngineAPI")
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("ControlModule"):WaitForChild("AvatarAbilitiesInterface"))
local v12 = if userFlag then AvatarAbilitiesInterface.get(players.LocalPlayer) else nil
local v13 = userFlag3 and "ControlState" or "PlayerControlState"
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 53
      upvalues:
        Class (copy, index: 1)
    ]]
    return (setmetatable({controlData = {enabled = true, isJumping = false, worldMoveVector = Vector3.new(0, 0, 0)}}, Class))
end

function Class.Update(self, a16)
    --[[
      name: Update
      line: 65
      upvalues:
        userFlag4 (copy, index: 1)
        userFlag2 (copy, index: 2)
        userFlag5 (copy, index: 3)
        userFlag3 (copy, index: 4)
        v13 (copy, index: 5)
        v3 (copy, index: 6)
        workspace (copy, index: 7)
        v12 (copy, index: 8)
    ]]
    if not userFlag4 then
        return
    end

    local player = a16.engineInterface.player
    if not player then
        return
    end

    if not userFlag2 then
        if a16.isServerAuthority then
            local inputContexts = player:FindFirstChild("InputContexts")
            if not inputContexts then
                return
            end

            local characterContext = inputContexts:FindFirstChild("CharacterContext")
            if not characterContext then
                return
            elseif const rotationAction = characterContext:FindFirstChild("RotationAction") then
                if const rotationScriptableBinding = rotationAction:FindFirstChild("RotationScriptableBinding") then
                    rotationScriptableBinding:Fire(v3.RotationType == Enum.RotationType.CameraRelative)
                end
            end
        end

        return
    end

    local vector3
    local character = if userFlag5 then a16.engineInterface.character else player.Character
    if not character then
        return
    end

    local v24 = if userFlag3 then character:FindFirstChildOfClass(v13) else character:FindFirstChild(v13)
    if not v24 then
        return
    end

    local humanoid = if userFlag5 then a16.engineInterface.humanoid else character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    local rotateToLookDirection = v3.RotationType == Enum.RotationType.CameraRelative
    local v27 = workspace.CurrentCamera and workspace.CurrentCamera.CFrame.LookVector
        or Vector3.new(0, 0, 1)
    local vector32 = Vector3.new(v27.X, 0, v27.Z)

    if not (0.001 < vector32.Magnitude) then
        vector3 = Vector3.new(0, 0, 1)
    else
        vector3 = vector32.Unit
    end

    local v29 = {RotateToLookDirection = rotateToLookDirection, LookDirection = vector3}

    if a16.controlModule.enabled or self.controlData.enabled then
        v29.Move = a16.controlModule.worldMoveVector

        if not v12 or not v12:isEnabled() then
            v29.Jump = a16.controlModule.isJumping
        end
    end

    self.controlData.enabled = a16.controlModule.enabled
    self.controlData.isJumping = a16.controlModule.isJumping
    self.controlData.worldMoveVector = a16.controlModule.worldMoveVector
    v24:UpdateFields(v29)
end

return Class