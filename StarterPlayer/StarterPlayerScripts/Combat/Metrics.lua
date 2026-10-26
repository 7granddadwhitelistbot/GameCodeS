local Players_upv_1 = game:GetService("Players")
local RunService_1 = game:GetService("RunService")
local tbl_upv_1 = {}
local tbl_upv_2 = {projTime = 0, fxTime = 0, fx = 0}
tbl_upv_1.projLive = 0
tbl_upv_1.sounds = 0
local tbl_upv_3 = {}
function tbl_upv_1.AddFx(a1, a2)
    --[[
      name: AddFx
      line: 18
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    tbl_upv_2.fx = tbl_upv_2.fx + 1
    tbl_upv_2.fxTime = tbl_upv_2.fxTime + a1
    if not a2 then
        return
    end
    tbl_upv_3[a2] = (tbl_upv_3[a2] or 0) + a1
end
function tbl_upv_1.AddProj(a1, a2)
    --[[
      name: AddProj
      line: 26
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    tbl_upv_2.projTime = tbl_upv_2.projTime + a1
    tbl_upv_1.projLive = a2
end
local u1 = 0
local u2 = 0
local u3 = 0
local u4 = os.clock()
RunService_1.RenderStepped:Connect(
    function(a1)
        --[[
          line: 33
          upvalues:
            u1 (ref,  index: 1)
            u2 (ref,  index: 2)
            u3 (ref,  index: 3)
            u4 (ref,  index: 4)
            Players_upv_1 (copy, index: 5)
            tbl_upv_2 (copy, index: 6)
            tbl_upv_1 (copy, index: 7)
            tbl_upv_3 (copy, index: 8)
        ]]
        u1 = u1 + 1
        u2 = u2 + a1
        u3 = math.max(u3, a1)
        local v1 = os.clock()
        if v1 - u4 < 1 then
            return
        end
        local v2 = v1 - u4
        u4 = v1
        local v3 = Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerScripts")
        if v3 then
            local FX_1 = workspace:FindFirstChild("FX")
            v3:SetAttribute("CombatFxPerSec", (math.floor((tbl_upv_2.fx / v2) + 0.5)))
            v3:SetAttribute("CombatFxMsPerSec", math.floor((((tbl_upv_2.fxTime / v2) * 1000) * 100) + 0.5) / 100)
            v3:SetAttribute("CombatProjMsPerSec", math.floor((((tbl_upv_2.projTime / v2) * 1000) * 100) + 0.5) / 100)
            v3:SetAttribute("CombatProjLive", tbl_upv_1.projLive)
            local v4 = (FX_1 and (#FX_1:GetChildren())) or 0
            v3:SetAttribute("CombatFxLive", v4)
            v3:SetAttribute("CombatSounds", tbl_upv_1.sounds)
            local v5 = ((u1 > 0) and (math.floor((((u2 / u1) * 1000) * 10) + 0.5) / 10)) or 0
            v3:SetAttribute("CombatFrameMsAvg", v5)
            v3:SetAttribute("CombatFrameMsMax", math.floor(((u3 * 1000) * 10) + 0.5) / 10)
            local tbl_4 = {}
            for key_1, value_1 in tbl_upv_3 do
                table.insert(tbl_4, string.format("%s=%.1f", key_1, (value_1 / v2) * 1000))
            end
            table.sort(tbl_4)
            v3:SetAttribute("CombatFxMsByKind", table.concat(tbl_4, " "))
        end
        table.clear(tbl_upv_3)
        tbl_upv_2.fx = 0
        tbl_upv_2.fxTime = 0
        tbl_upv_2.projTime = 0
        u1 = 0
        u2 = 0
        u3 = 0
    end
)
return tbl_upv_1