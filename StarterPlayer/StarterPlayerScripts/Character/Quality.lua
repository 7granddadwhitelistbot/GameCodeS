local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local v3 = {}
local v4 = {High = {stepCap = 14, stepRadius = 90, maxSteps = 16, remoteHz = 20, remoteDust = true, dustScale = 1, twistRange = 70, propFadeEvery = 1}, Medium = {stepCap = 10, stepRadius = 70, maxSteps = 12, remoteHz = 15, remoteDust = true, dustScale = 0.75, twistRange = 45, propFadeEvery = 2}, Low = {stepCap = 6, stepRadius = 45, maxSteps = 8, remoteHz = 10, remoteDust = false, dustScale = 0.5, twistRange = 25, propFadeEvery = 4}}
local v5 = userInputService.TouchEnabled and not userInputService.MouseEnabled
v3.level = v5 and "Medium" or "High"
v3.budget = v4[v3.level]
local hasRun = false

local function refresh(playerScripts: Instance?)
    --[[
      name: refresh
      line: 38
      upvalues:
        v3 (copy, index: 1)
        v4 (copy, index: 2)
    ]]
    local characterQuality = playerScripts:GetAttribute("CharacterQuality")
    local combatQualityLevel = playerScripts:GetAttribute("CombatQualityLevel")
    local v11 = v3.level

    if characterQuality == "Low" then
        v11 = characterQuality
    elseif characterQuality == "Medium" or characterQuality == "High" then
        v11 = characterQuality
    elseif combatQualityLevel == "Low" or combatQualityLevel == "Medium" or combatQualityLevel == "High" then
        v11 = combatQualityLevel
    end

    v3.level = v11
    v3.budget = v4[v11]
    playerScripts:SetAttribute("CharacterQualityLevel", v11)
end

function v3.Start()
    --[[
      name: Start
      line: 52
      upvalues:
        hasRun (ref,  index: 1)
        players (copy, index: 2)
        refresh (copy, index: 3)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    local localPlayer = players.LocalPlayer
    local playerScripts = localPlayer:FindFirstChildOfClass("PlayerScripts")
        or localPlayer:WaitForChild("PlayerScripts", 10)
    if not playerScripts then
        return
    end

    refresh(playerScripts)
    playerScripts:GetAttributeChangedSignal("CharacterQuality"):Connect(
        function()
            --[[
              line: 63
              upvalues:
                refresh (copy, index: 1)
                playerScripts (copy, index: 2)
            ]]
            refresh(playerScripts)
        end
    )
    playerScripts:GetAttributeChangedSignal("CombatQualityLevel"):Connect(
        function()
            --[[
              line: 66
              upvalues:
                refresh (copy, index: 1)
                playerScripts (copy, index: 2)
            ]]
            refresh(playerScripts)
        end
    )
end

return v3