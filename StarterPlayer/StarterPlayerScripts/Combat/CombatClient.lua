local players = game:GetService("Players")
local runService = game:GetService("RunService")
require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Loc")).Install()
local Controller = require(script.Parent:WaitForChild("Controller"))
Controller.Start()
local success, result = pcall(
    function()
        --[[
          line: 12
        ]]
        require(script.Parent:WaitForChild("Ping")).Start()
    end
)
if not success then
    warn("[Combat] Ping failed to start:", result)
end

task.spawn(
    function()
        --[[
          line: 21
        ]]
        local assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets", 30)
        local weapons = assets and assets:WaitForChild("Weapons", 30)
        if not weapons then
            return
        end

        local contentIdList = {}

        for _, descendant in weapons:GetDescendants() do
            if descendant:IsA("MeshPart") then
                table.insert(contentIdList, descendant)
            end
        end

        if 0 < #contentIdList then
            pcall(
                function()
                    --[[
                      line: 34
                      upvalues:
                        contentIdList (copy, index: 1)
                    ]]
                    game:GetService("ContentProvider"):PreloadAsync(contentIdList)
                end
            )
        end
    end
)

if runService:IsStudio() then
    local playerScripts = players.LocalPlayer:WaitForChild("PlayerScripts")
    local combatDebug = Instance.new("BindableFunction")
    combatDebug.Name = "CombatDebug"

    combatDebug.OnInvoke = function(a13, ...)
        --[[
          line: 46
          upvalues:
            Controller (copy, index: 1)
            players (copy, index: 2)
        ]]
        if a13 == "Dispatch" then
            local v14, v15 = ...
            Controller.Dispatch(v14, v15)

            return true
        end

        if a13 == "State" then
            return Controller.State()
        end
        if a13 ~= "Equip" then
            return nil
        end

        local v16 = ...

        if const backpack = players.LocalPlayer:FindFirstChildOfClass("Backpack") then
            for _, child in backpack:GetChildren() do
                if child:IsA("Tool") and child:GetAttribute("SlotIndex") == v16 then
                    return Controller.Equip(child)
                end
            end
        end

        return false
    end

    combatDebug.Parent = playerScripts
end