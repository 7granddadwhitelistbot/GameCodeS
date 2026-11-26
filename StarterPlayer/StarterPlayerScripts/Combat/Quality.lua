local v1
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local v5 = {level = "High", particleScale = 1, nearRadius = 150, maxBursts = 40, maxFlying = 160, maxSounds = 20, highlights = true, decals = true, layers = true}
local v6 = {High = {particleScale = 1, nearRadius = 150, maxBursts = 40, maxFlying = 160, maxSounds = 20, highlights = true, decals = true, layers = true}, Medium = {particleScale = 0.7, nearRadius = 120, maxBursts = 25, maxFlying = 100, maxSounds = 14, highlights = true, decals = true, layers = true}, Low = {particleScale = 0.4, nearRadius = 80, maxBursts = 12, maxFlying = 50, maxSounds = 8, highlights = false, decals = false, layers = false}}
local v7 = {}

function v5.OnChanged(a8)
    --[[
      name: OnChanged
      line: 38
      upvalues:
        v7 (copy, index: 1)
    ]]
    table.insert(v7, a8)
end

local function apply(level)
    --[[
      name: apply
      line: 42
      upvalues:
        v5 (copy, index: 1)
        v6 (copy, index: 2)
        players (copy, index: 3)
        v7 (copy, index: 4)
    ]]
    if level == v5.level then
        return
    end

    v5.level = level

    for v11, v12 in v6[level] do
        v5[v11] = v12
    end

    if const playerScripts = players.LocalPlayer and players.LocalPlayer:FindFirstChildOfClass("PlayerScripts") then
        playerScripts:SetAttribute("CombatQualityLevel", level)
    end

    for _, v15 in v7 do
        task.spawn(v15, level)
    end
end

v5.Set = apply

local function savedLevel()
    --[[
      name: savedLevel
      line: 61
    ]]
    local success, savedQualityLevel = pcall(
        function()
            --[[
              line: 62
            ]]
            return UserSettings().GameSettings.SavedQualityLevel
        end
    )

    if success and typeof(savedQualityLevel) == "EnumItem" and savedQualityLevel ~= Enum.SavedQualitySetting.Automatic then
        return savedQualityLevel.Value
    end

    return nil
end

local function fromSaved(a20)
    --[[
      name: fromSaved
      line: 71
    ]]
    if a20 <= 3 then
        return "Low"
    end
    if a20 <= 6 then
        return "Medium"
    end

    return "High"
end

local v21 = 0
local v22 = 0

if userInputService.TouchEnabled then
    if userInputService.MouseEnabled then
        v1 = "High"
    else
        v1 = "Medium"
    end
else
    v1 = "High"
end

local function reevaluate()
    --[[
      name: reevaluate
      line: 78
      upvalues:
        players (copy, index: 1)
        apply (copy, index: 2)
        v21 (ref,  index: 3)
        runService (copy, index: 4)
        v22 (ref,  index: 5)
        v1 (ref,  index: 6)
    ]]
    local playerScripts = players.LocalPlayer and players.LocalPlayer:FindFirstChildOfClass("PlayerScripts")
    local combatQuality = playerScripts and playerScripts:GetAttribute("CombatQuality")

    if combatQuality == "Low" or combatQuality == "Medium" or combatQuality == "High" then
        apply(combatQuality)
        return
    end

    local value
    local success, savedQualityLevel = pcall(
        function()
            --[[
              line: 62
            ]]
            return UserSettings().GameSettings.SavedQualityLevel
        end
    )

    if not success or typeof(savedQualityLevel) ~= "EnumItem" or savedQualityLevel == Enum.SavedQualitySetting.Automatic then
        value = nil
    else
        value = savedQualityLevel.Value
    end

    if value then
        apply((value <= 3 and "Low" or value <= 6 and "Medium" or "High"))
        return
    end

    if 0 < v21 and not runService:IsStudio() then
        local v29 = v22 / v21 * 1000

        if not (28 < v29) then
            if v29 < 18 and v1 ~= "High" then
                v1 = v1 ~= "Low" and "High" or "Medium"
            end
        else
            v1 = v1 ~= "High" and "Low" or "Medium"
        end
    end

    apply(v1)
end

local hasRun = false

function v5.Start()
    --[[
      name: Start
      line: 103
      upvalues:
        hasRun (ref,  index: 1)
        v5 (copy, index: 2)
        apply (copy, index: 3)
        v1 (ref,  index: 4)
        reevaluate (copy, index: 5)
        runService (copy, index: 6)
        v21 (ref,  index: 7)
        v22 (ref,  index: 8)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    v5.level = "High"
    apply(v1)
    reevaluate()
    local timestamp = os.clock()

    runService.RenderStepped:Connect(
        function(deltaTime: number)
            --[[
              line: 112
              upvalues:
                v21 (ref,  index: 1)
                v22 (ref,  index: 2)
                timestamp (ref,  index: 3)
                reevaluate (copy, index: 4)
            ]]
            v21 += 1
            v22 += deltaTime
            local timestamp2 = os.clock()

            if 2 <= timestamp2 - timestamp then
                timestamp = timestamp2
                reevaluate()
                v21 = 0
                v22 = 0
            end
        end
    )
end

return v5