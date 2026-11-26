local players = game:GetService("Players")
local starterGui = game:GetService("StarterGui")
local v3 = {}
local localPlayer = players.LocalPlayer
local count = 0

local function apply()
    --[[
      name: apply
      line: 14
      upvalues:
        count (ref,  index: 1)
        localPlayer (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    count += 1
    local v7 = count
    local value = localPlayer:GetAttribute("State") ~= "Match"

    for _ = 1, 40 do
        if v7 ~= count then
            return
        end
        if pcall(
            function()
                --[[
                  line: 22
                  upvalues:
                    starterGui (copy, index: 1)
                    value (copy, index: 2)
                ]]
                starterGui:SetCore("ResetButtonCallback", value)
            end
        ) then
            return
        end

        task.wait(0.5)
    end
end

local hasRun = false

function v3.Start()
    --[[
      name: Start
      line: 33
      upvalues:
        hasRun (ref,  index: 1)
        localPlayer (copy, index: 2)
        apply (copy, index: 3)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    localPlayer:GetAttributeChangedSignal("State"):Connect(
        function()
            --[[
              line: 38
              upvalues:
                apply (copy, index: 1)
            ]]
            task.spawn(apply)
        end
    )
    task.spawn(apply)
end

return v3