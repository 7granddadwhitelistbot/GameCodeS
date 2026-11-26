local players = game:GetService("Players")
require(script.Parent:WaitForChild("CommonUtils"))
require(script.Parent.Types)

return {
    update = (function(a2)
        --[[
          name: update
          line: 20
          upvalues:
            players (copy, index: 1)
        ]]
        local engineInterface = a2.engineInterface
        local localPlayer = players.LocalPlayer
        local model = if localPlayer then localPlayer.Character else nil
        local humanoid = if model then model:FindFirstChildOfClass("Humanoid") else nil

        if localPlayer ~= engineInterface.player
            or model ~= engineInterface.character
            or humanoid ~= engineInterface.humanoid
        then
            engineInterface.player = localPlayer
            engineInterface.character = model
            engineInterface.humanoid = humanoid
            engineInterface.characterChanged = true
        end
    end),
    cleanDirty = (function(a7)
        --[[
          name: cleanDirty
          line: 39
        ]]
        a7.engineInterface.characterChanged = false
    end)
}