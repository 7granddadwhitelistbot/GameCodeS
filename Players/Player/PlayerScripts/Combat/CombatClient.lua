local Players_upv_1 = game:GetService("Players")
local RunService_1 = game:GetService("RunService")
require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Loc")).Install()
local Controller_upv_1 = require(script.Parent:WaitForChild("Controller"))
Controller_upv_1.Start()
local success_1, v1 = pcall(
    function()
        --[[
          line: 12
        ]]
        require(script.Parent:WaitForChild("Ping")).Start()
    end
)
if not (success_1) then
    warn("[Combat] Ping failed to start:", v1)
end
task.spawn(
    function()
        --[[
          line: 21
        ]]
        local v2 = game:GetService("ReplicatedStorage"):WaitForChild("Assets", 30)
        local v3 = v2 and (v2:WaitForChild("Weapons", 30))
        if not v3 then
            return
        end
        local tbl_upv_1 = {}
        for _, value_1 in v3:GetDescendants() do
            if value_1:IsA("MeshPart") then
                table.insert(tbl_upv_1, value_1)
            end
        end
        if not (#tbl_upv_1 > 0) then
            return
        end
        pcall(
            function()
                --[[
                  line: 34
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                ]]
                game:GetService("ContentProvider"):PreloadAsync(tbl_upv_1)
            end
        )
    end
)
if RunService_1:IsStudio() then
    local PlayerScripts_1 = Players_upv_1.LocalPlayer:WaitForChild("PlayerScripts")
    local v4 = Instance.new("BindableFunction")
    v4.Name = "CombatDebug"
    v4.OnInvoke = function(a1, ...)
        --[[
          line: 46
          upvalues:
            Controller_upv_1 (copy, index: 1)
            Players_upv_1 (copy, index: 2)
        ]]
        if a1 ~= "Dispatch" then
            if a1 == "State" then
                return Controller_upv_1.State()
            end
            if a1 ~= "Equip" then
                return nil
            end
            local v5 = ...
            local v6 = Players_upv_1.LocalPlayer:FindFirstChildOfClass("Backpack")
            if v6 then
                for _, value_2 in v6:GetChildren() do
                    if not (value_2:IsA("Tool")) or value_2:GetAttribute("SlotIndex") ~= v5 then
                        continue
                    end
                    return Controller_upv_1.Equip(value_2)
                end
            end
            return false
        else
            local v7, v8 = ...
            Controller_upv_1.Dispatch(v7, v8)
            return true
        end
    end
    v4.Parent = PlayerScripts_1
end