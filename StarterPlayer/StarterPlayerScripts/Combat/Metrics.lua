local players = game:GetService("Players")
local runService = game:GetService("RunService")
local v3 = {}
local v4 = {fx = 0, fxTime = 0, projTime = 0}
v3.projLive = 0
v3.sounds = 0
local v5 = {}

function v3.AddFx(a6, key)
    --[[
      name: AddFx
      line: 18
      upvalues:
        v4 (copy, index: 1)
        v5 (copy, index: 2)
    ]]
    v4.fx += 1
    v4.fxTime += a6

    if key then
        v5[key] = (v5[key] or 0) + a6
    end
end

function v3.AddProj(a8, projLive)
    --[[
      name: AddProj
      line: 26
      upvalues:
        v4 (copy, index: 1)
        v3 (copy, index: 2)
    ]]
    v4.projTime += a8
    v3.projLive = projLive
end

local v10 = 0
local v11 = 0
local v12 = 0
local timestamp = os.clock()

runService.RenderStepped:Connect(
    function(deltaTime: number)
        --[[
          line: 33
          upvalues:
            v10 (ref,  index: 1)
            v11 (ref,  index: 2)
            v12 (ref,  index: 3)
            timestamp (ref,  index: 4)
            players (copy, index: 5)
            v4 (copy, index: 6)
            v3 (copy, index: 7)
            v5 (copy, index: 8)
        ]]
        v10 += 1
        v11 += deltaTime
        v12 = math.max(v12, deltaTime)
        local timestamp2 = os.clock()

        if timestamp2 - timestamp < 1 then
            return
        end

        local elapsedTime = timestamp2 - timestamp
        timestamp = timestamp2

        if const playerScripts = players.LocalPlayer:FindFirstChildOfClass("PlayerScripts") then
            local fx = workspace:FindFirstChild("FX")
            playerScripts:SetAttribute("CombatFxPerSec", (math.floor((v4.fx / elapsedTime) + 0.5)))
            playerScripts:SetAttribute("CombatFxMsPerSec", math.floor((((v4.fxTime / elapsedTime) * 1000) * 100) + 0.5) / 100)
            playerScripts:SetAttribute("CombatProjMsPerSec", math.floor((((v4.projTime / elapsedTime) * 1000) * 100) + 0.5) / 100)
            playerScripts:SetAttribute("CombatProjLive", v3.projLive)
            local combatFxLive = fx and #fx:GetChildren() or 0
            playerScripts:SetAttribute("CombatFxLive", combatFxLive)
            playerScripts:SetAttribute("CombatSounds", v3.sounds)
            local combatFrameMsAvg = not (0 < v10) and 0 or math.floor((((v11 / v10) * 1000) * 10) + 0.5) / 10
            playerScripts:SetAttribute("CombatFrameMsAvg", combatFrameMsAvg)
            playerScripts:SetAttribute("CombatFrameMsMax", math.floor(((v12 * 1000) * 10) + 0.5) / 10)
            local parts = {}

            for v22, v23 in v5 do
                table.insert(parts, string.format("%s=%.1f", v22, (v23 / elapsedTime) * 1000))
            end

            table.sort(parts)
            playerScripts:SetAttribute("CombatFxMsByKind", table.concat(parts, " "))
        end

        table.clear(v5)
        v4.fx = 0
        v4.fxTime = 0
        v4.projTime = 0
        v10 = 0
        v11 = 0
        v12 = 0
    end
)

return v3