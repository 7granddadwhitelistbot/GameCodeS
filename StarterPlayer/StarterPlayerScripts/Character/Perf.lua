local Players_1 = game:GetService("Players")
local tbl_1 = {}
local u1 = game:GetService("RunService"):IsStudio()
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local u2 = os.clock()
local function Begin()
    --[[
      name: Begin
      line: 16
      upvalues:
        u1 (copy, index: 1)
    ]]
    if u1 then
        return (os.clock())
    end
    return 0
end
tbl_1.Begin = Begin
function tbl_1.End(a1, a2)
    --[[
      name: End
      line: 20
      upvalues:
        u1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        tbl_upv_3 (copy, index: 3)
    ]]
    if not u1 then
        return
    end
    local v1 = os.clock() - a2
    tbl_upv_2[a1] = (tbl_upv_2[a1] or 0) + v1
    if not ((tbl_upv_3[a1] or 0) < v1) then
        return
    end
    tbl_upv_3[a1] = v1
end
if u1 and Players_1.LocalPlayer then
    local v2 = Instance.new("BindableFunction")
    v2.Name = "CharacterPerf"
    v2.OnInvoke = function()
        --[[
          line: 34
          upvalues:
            u2 (ref,  index: 1)
            tbl_upv_2 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
        ]]
        local v3 = math.max(0.001, os.clock() - u2)
        local tbl_4 = {}
        for key_1, value_1 in tbl_upv_2 do
            tbl_4[key_1] = string.format("%.3f ms/s (max %.3f ms)", (value_1 * 1000) / v3, (tbl_upv_3[key_1] or 0) * 1000)
        end
        table.clear(tbl_upv_2)
        table.clear(tbl_upv_3)
        u2 = os.clock()
        return tbl_4
    end
    v2.Parent = Players_1.LocalPlayer
end
return tbl_1