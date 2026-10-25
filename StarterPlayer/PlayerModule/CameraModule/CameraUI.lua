local StarterGui_upv_1 = game:GetService("StarterGui")
local u1 = false
local tbl_upv_1 = {}
function tbl_upv_1.setCameraModeToastEnabled(a1)
    --[[
      name: setCameraModeToastEnabled
      line: 10
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if (a1) or (u1) then
        if not (u1) then
            u1 = true
        end
        if not (a1) then
            tbl_upv_1.setCameraModeToastOpen(false)
        end
    end
end
function tbl_upv_1.setCameraModeToastOpen(a1)
    --[[
      name: setCameraModeToastOpen
      line: 24
      upvalues:
        u1 (ref,  index: 1)
        StarterGui_upv_1 (copy, index: 2)
    ]]
    assert(u1)
    if not a1 then
        return
    end
    StarterGui_upv_1:SetCore("SendNotification", {Text = "Right click to toggle", Title = "Camera Control Enabled", Duration = 3})
end
return tbl_upv_1