local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local v7 = {}

local function platform()
    --[[
      name: platform
      line: 20
      upvalues:
        guiService (copy, index: 1)
        userInputService (copy, index: 2)
        workspace (copy, index: 3)
    ]]
    if guiService:IsTenFootInterface() then
        return "Console"
    end
    if not userInputService.TouchEnabled or userInputService.MouseEnabled then
        return "Desktop"
    end

    local camera = workspace.CurrentCamera
    local timestamp = os.clock()

    while (not camera or camera.ViewportSize.X <= 1) and os.clock() - timestamp < 5 do
        task.wait(0.1)
        camera = workspace.CurrentCamera
    end

    local vector2 = if camera then camera.ViewportSize else Vector2.zero

    if not (600 <= math.min(vector2.X, vector2.Y)) then
        return "Phone"
    end

    return "Tablet"
end

function v7.Start()
    --[[
      name: Start
      line: 39
      upvalues:
        replicatedStorage (copy, index: 1)
        platform (copy, index: 2)
        players (copy, index: 3)
        runService (copy, index: 4)
    ]]
    local Net = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Net"))
    local InputStats = require(script.Parent:WaitForChild("InputStats"))
    InputStats.Start()
    local v14 = Net.Event("AnalyticsReport")
    v14:FireServer("Platform", (platform()))
    local localPlayer = players.LocalPlayer
    local v16 = 0
    local v17 = 0

    runService.RenderStepped:Connect(
        function(deltaTime: number)
            --[[
              line: 49
              upvalues:
                localPlayer (copy, index: 1)
                v16 (ref,  index: 2)
                v17 (ref,  index: 3)
            ]]
            if localPlayer:GetAttribute("State") == "Match"
                and localPlayer:GetAttribute("Alive") == true
                and localPlayer:GetAttribute("ReplayPlaying") ~= true
            then
                v16 += 1
                v17 += deltaTime
            end
        end
    )

    Net.Event("MatchEvent").OnClientEvent:Connect(
        function(a19)
            --[[
              line: 55
              upvalues:
                v16 (ref,  index: 1)
                v17 (ref,  index: 2)
                v14 (copy, index: 3)
                InputStats (copy, index: 4)
            ]]
            if a19 == "RoundStart" then
                v16 = 0
                v17 = 0

                return
            end

            if a19 == "RoundEnd" then
                if 10 <= v17 then
                    v14:FireServer("Fps", math.floor(((v16 / v17) * 10) + 0.5) / 10, InputStats.Take())
                end

                v16 = 0
                v17 = 0
            end
        end
    )
end

return v7