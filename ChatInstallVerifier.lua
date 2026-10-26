local Players_1 = game:GetService("Players")
local StarterPlayer_1 = game:GetService("StarterPlayer")
local function waitForChildOfClass(a1, a2)
    --[[
      name: waitForChildOfClass
      line: 10
    ]]
    local v1 = a1:FindFirstChildOfClass(a2)
    while true do
        if not (v1) then
            v1 = a1.ChildAdded:Wait()
            continue
        end
        if v1.ClassName == a2 then
            break
        end
        v1 = a1.ChildAdded:Wait()
    end
    return v1
end
local u1 = waitForChildOfClass(Players_1.LocalPlayer, "PlayerScripts")
local u2 = waitForChildOfClass(StarterPlayer_1, "StarterPlayerScripts")
function VerifyScriptExistence()
    --[[
      name: VerifyScriptExistence
      line: 22
      upvalues:
        u1 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    local Value_1 = script:WaitForChild("ScriptToVerify").Value
    if not (u1:FindFirstChild(Value_1)) then
        local v2 = u2:FindFirstChild(Value_1)
        if v2 then
            local Archivable_1 = v2.Archivable
            v2.Archivable = true
            v2:Clone().Parent = u1
            v2.Archivable = Archivable_1
        end
    end
end
VerifyScriptExistence()
script:Destroy()