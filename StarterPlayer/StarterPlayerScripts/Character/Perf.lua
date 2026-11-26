local players = game:GetService("Players")
local runService = game:GetService("RunService")
local v3 = {}
local isStudio = runService:IsStudio()
local v5 = {}
local v6 = {}
local timestamp = os.clock()

function v3.Begin()
    --[[
      name: Begin
      line: 16
      upvalues:
        isStudio (copy, index: 1)
    ]]
    if isStudio then
        return (os.clock())
    end

    return 0
end

function v3.End(key, a9)
    --[[
      name: End
      line: 20
      upvalues:
        isStudio (copy, index: 1)
        v5 (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    if not isStudio then
        return
    end

    local v10 = os.clock() - a9
    v5[key] = (v5[key] or 0) + v10

    if (v6[key] or 0) < v10 then
        v6[key] = v10
    end
end

if isStudio and players.LocalPlayer then
    local characterPerf = Instance.new("BindableFunction")
    characterPerf.Name = "CharacterPerf"

    characterPerf.OnInvoke = function()
        --[[
          line: 34
          upvalues:
            timestamp (ref,  index: 1)
            v5 (copy, index: 2)
            v6 (copy, index: 3)
        ]]
        local v12 = math.max(0.001, os.clock() - timestamp)
        local v13 = {}

        for v14, v15 in v5 do
            v13[v14] = string.format("%.3f ms/s (max %.3f ms)", (v15 * 1000) / v12, (v6[v14] or 0) * 1000)
        end

        table.clear(v5)
        table.clear(v6)
        timestamp = os.clock()

        return v13
    end

    characterPerf.Parent = players.LocalPlayer
end

return v3