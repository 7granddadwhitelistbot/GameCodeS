local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_1 = game:GetService("UserInputService")
local tbl_upv_1 = {}
tbl_upv_1.level = "High"
tbl_upv_1.particleScale = 1
tbl_upv_1.nearRadius = 150
tbl_upv_1.maxBursts = 40
tbl_upv_1.maxFlying = 160
tbl_upv_1.maxSounds = 20
tbl_upv_1.highlights = true
tbl_upv_1.decals = true
tbl_upv_1.layers = true
local tbl_upv_2 = {}
tbl_upv_2.High = {maxFlying = 160, highlights = true, layers = true, nearRadius = 150, maxBursts = 40, decals = true, particleScale = 1, maxSounds = 20}
tbl_upv_2.Medium = {maxFlying = 100, highlights = true, layers = true, nearRadius = 120, maxBursts = 25, decals = true, particleScale = 0.7, maxSounds = 14}
tbl_upv_2.Low = {maxFlying = 50, highlights = false, layers = false, nearRadius = 80, maxBursts = 12, decals = false, particleScale = 0.4, maxSounds = 8}
local tbl_upv_3 = {}
function tbl_upv_1.OnChanged(a1)
    --[[
      name: OnChanged
      line: 38
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    table.insert(tbl_upv_3, a1)
end
local function apply(a1)
    --[[
      name: apply
      line: 42
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    if a1 == tbl_upv_1.level then
        return
    end
    tbl_upv_1.level = a1
    for key_1, value_1 in tbl_upv_2[a1] do
        tbl_upv_1[key_1] = value_1
    end
    local v1 = Players_upv_1.LocalPlayer and (Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerScripts"))
    if v1 then
        v1:SetAttribute("CombatQualityLevel", a1)
    end
    for _, value_2 in tbl_upv_3 do
        task.spawn(value_2, a1)
    end
end
tbl_upv_1.Set = apply
local function savedLevel()
    --[[
      name: savedLevel
      line: 61
    ]]
    local success_1, v2 = pcall(function() end)
    if success_1 and typeof(v2) == "EnumItem" and v2 ~= Enum.SavedQualitySetting.Automatic then
        return v2.Value
    end
    return nil
end
local function fromSaved(a1)
    --[[
      name: fromSaved
      line: 71
    ]]
    if a1 <= 3 then
        return "Low"
    elseif a1 <= 6 then
        return "Medium"
    else
        return "High"
    end
end
local u1 = 0
local u2 = 0
local u3
if not (UserInputService_1.TouchEnabled) or UserInputService_1.MouseEnabled then
    u3 = "High"
else
    u3 = "Medium"
end
local function reevaluate()
    --[[
      name: reevaluate
      line: 78
      upvalues:
        Players_upv_1 (copy, index: 1)
        apply (copy, index: 2)
        u1 (ref,  index: 3)
        RunService_upv_1 (copy, index: 4)
        u2 (ref,  index: 5)
        u3 (ref,  index: 6)
    ]]
    local v3 = Players_upv_1.LocalPlayer and (Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerScripts"))
    local v4 = v3 and (v3:GetAttribute("CombatQuality"))
    if v4 ~= "Low" and v4 ~= "Medium" and v4 ~= "High" then
        local success_2, v5 = pcall(
            function()
                --[[
                  line: 62
                ]]
                return UserSettings().GameSettings.SavedQualityLevel
            end
        )
        if success_2 and typeof(v5) == "EnumItem" and v5 ~= Enum.SavedQualitySetting.Automatic then
            v4 = v5.Value
        else
            v4 = nil
        end
        if v4 then
            apply(((v4 <= 3) and "Low") or (((v4 <= 6) and "Medium") or "High"))
        else
            if u1 > 0 and not (RunService_upv_1:IsStudio()) then
                v4 = u2 / u1 * 1000
                if v4 > 28 then
                    local v6 = u3 ~= "High" and "Low" or "Medium"
                    u3 = v6
                elseif v4 < 18 and u3 ~= "High" then
                    local v7 = u3 ~= "Low" and "High" or "Medium"
                    u3 = v7
                end
            end
            apply(u3)
        end
        return
    end
    apply(v3)
end
local u4 = false
function tbl_upv_1.Start()
    --[[
      name: Start
      line: 103
      upvalues:
        u4 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
        apply (copy, index: 3)
        u3 (ref,  index: 4)
        reevaluate (copy, index: 5)
        RunService_upv_1 (copy, index: 6)
        u1 (ref,  index: 7)
        u2 (ref,  index: 8)
    ]]
    if u4 then
        return
    end
    u4 = true
    tbl_upv_1.level = "High"
    apply(u3)
    reevaluate()
    local u5 = os.clock()
    RunService_upv_1.RenderStepped:Connect(
        function(a1)
            --[[
              line: 112
              upvalues:
                u1 (ref,  index: 1)
                u2 (ref,  index: 2)
                u5 (ref,  index: 3)
                reevaluate (copy, index: 4)
            ]]
            u1 = u1 + 1
            u2 = u2 + a1
            local v8 = os.clock()
            if not (v8 - u5 >= 2) then
                return
            end
            u5 = v8
            reevaluate()
            u1 = 0
            u2 = 0
        end
    )
end
return tbl_upv_1