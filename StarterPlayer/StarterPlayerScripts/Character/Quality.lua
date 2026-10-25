local Players_upv_1 = game:GetService("Players")
local UserInputService_1 = game:GetService("UserInputService")
local tbl_upv_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.High = {remoteHz = 20, propFadeEvery = 1, maxSteps = 16, stepCap = 14, twistRange = 70, stepRadius = 90, dustScale = 1, remoteDust = true}
tbl_upv_2.Medium = {remoteHz = 15, propFadeEvery = 2, maxSteps = 12, stepCap = 10, twistRange = 45, stepRadius = 70, dustScale = 0.75, remoteDust = true}
tbl_upv_2.Low = {remoteHz = 10, propFadeEvery = 4, maxSteps = 8, stepCap = 6, twistRange = 25, stepRadius = 45, dustScale = 0.5, remoteDust = false}
tbl_upv_1.level = ((UserInputService_1.TouchEnabled and (not UserInputService_1.MouseEnabled)) and "Medium") or "High"
tbl_upv_1.budget = tbl_upv_2[tbl_upv_1.level]
local u1 = false
local function refresh(a1)
    --[[
      name: refresh
      line: 38
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v1 = a1:GetAttribute("CharacterQuality")
    local v2 = a1:GetAttribute("CombatQualityLevel")
    local v3 = tbl_upv_1.level
    if v1 == "Low" or v1 == "Medium" or v1 == "High" then
        v3 = v1
    elseif v2 == "Low" or v2 == "Medium" or v2 == "High" then
        v3 = v2
    end
    tbl_upv_1.level = v3
    tbl_upv_1.budget = tbl_upv_2[v3]
    a1:SetAttribute("CharacterQualityLevel", v3)
end
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 52
      upvalues:
        u1 (ref,  index: 1)
        Players_upv_1 (copy, index: 2)
        refresh (copy, index: 3)
    ]]
    if u1 then
        return
    end
    u1 = true
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local u2 = LocalPlayer_1:FindFirstChildOfClass("PlayerScripts") or (LocalPlayer_1:WaitForChild("PlayerScripts", 10))
    if not u2 then
        return
    end
    refresh(u2)
    u2:GetAttributeChangedSignal("CharacterQuality"):Connect(
        function()
            --[[
              line: 63
              upvalues:
                refresh (copy, index: 1)
                u2 (copy, index: 2)
            ]]
            refresh(u2)
        end
    )
    u2:GetAttributeChangedSignal("CombatQualityLevel"):Connect(
        function()
            --[[
              line: 66
              upvalues:
                refresh (copy, index: 1)
                u2 (copy, index: 2)
            ]]
            refresh(u2)
        end
    )
end
return tbl_upv_1