local Players_1 = game:GetService("Players")
local StarterGui_upv_1 = game:GetService("StarterGui")
local tbl_1 = {}
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u1 = 0
local function apply()
    --[[
      name: apply
      line: 14
      upvalues:
        u1 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        StarterGui_upv_1 (copy, index: 3)
    ]]
    u1 = u1 + 1
    local u2 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
    for _ = 1, 40 do
        if u1 == u1
            and not (pcall(
                function()
                    --[[
                      line: 22
                      upvalues:
                        StarterGui_upv_1 (copy, index: 1)
                        u2 (copy, index: 2)
                    ]]
                    StarterGui_upv_1:SetCore("ResetButtonCallback", u2)
                end
            )) then
            task.wait(0.5)
            continue
        end
        return
    end
end
local u3 = false
function tbl_1.Start()
    --[[
      name: Start
      line: 33
      upvalues:
        u3 (ref,  index: 1)
        LocalPlayer_upv_1 (copy, index: 2)
        apply (copy, index: 3)
    ]]
    if u3 then
        return
    end
    u3 = true
    LocalPlayer_upv_1:GetAttributeChangedSignal("State"):Connect(
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
return tbl_1