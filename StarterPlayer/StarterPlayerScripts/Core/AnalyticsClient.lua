local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local function platform()
    --[[
      name: platform
      line: 20
      upvalues:
        GuiService_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
    ]]
    if GuiService_upv_1:IsTenFootInterface() then
        return "Console"
    end
    if not UserInputService_upv_1.TouchEnabled or UserInputService_upv_1.MouseEnabled then
        return "Desktop"
    end
    local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    local v1 = os.clock()
    while true do
        if CurrentCamera_1 and not (CurrentCamera_1.ViewportSize.X <= 1) or not (os.clock() - v1 < 5) then
            break
        end
        task.wait(0.1)
        CurrentCamera_1 = Workspace_upv_1.CurrentCamera
    end
    if CurrentCamera_1 then
        v1 = CurrentCamera_1.ViewportSize
    else
        v1 = Vector2.zero
    end
    if math.min(v1.X, v1.Y) >= 600 then
        return "Tablet"
    end
    return "Phone"
end
function tbl_1.Start()
    --[[
      name: Start
      line: 39
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
        platform (copy, index: 2)
        Players_upv_1 (copy, index: 3)
        RunService_upv_1 (copy, index: 4)
    ]]
    local Net_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Net"))
    local InputStats_upv_1 = require(script.Parent:WaitForChild("InputStats"))
    InputStats_upv_1.Start()
    local u1 = Net_1.Event("AnalyticsReport")
    u1:FireServer("Platform", (platform()))
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u2 = 0
    local u3 = 0
    RunService_upv_1.RenderStepped:Connect(
        function(a1)
            --[[
              line: 49
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u2 (ref,  index: 2)
                u3 (ref,  index: 3)
            ]]
            if LocalPlayer_upv_1:GetAttribute("State") ~= "Match" or LocalPlayer_upv_1:GetAttribute("Alive") ~= true or LocalPlayer_upv_1:GetAttribute("ReplayPlaying") == true then
                return
            end
            u2 = u2 + 1
            u3 = u3 + a1
        end
    )
    Net_1.Event("MatchEvent").OnClientEvent:Connect(
        function(a2)
            --[[
              line: 55
              upvalues:
                u2 (ref,  index: 1)
                u3 (ref,  index: 2)
                u1 (copy, index: 3)
                InputStats_upv_1 (copy, index: 4)
            ]]
            if a2 == "RoundStart" then
                u2 = 0
                u3 = 0
            elseif a2 == "RoundEnd" then
                if u3 >= 10 then
                    u1:FireServer("Fps", math.floor(((u2 / u3) * 10) + 0.5) / 10, InputStats_upv_1.Take())
                end
                u2 = 0
                u3 = 0
            end
        end
    )
end
return tbl_1