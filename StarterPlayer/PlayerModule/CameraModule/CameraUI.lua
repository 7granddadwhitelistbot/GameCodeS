local starterGui = game:GetService("StarterGui")
local v2 = false
local v3 = {}

function v3.setCameraModeToastEnabled(cameraModeToastEnabled)
    --[[
      name: setCameraModeToastEnabled
      line: 10
      upvalues:
        v2 (ref,  index: 1)
        v3 (copy, index: 2)
    ]]
    if not cameraModeToastEnabled and not v2 then
        return
    end

    v2 = v2 or true

    if not cameraModeToastEnabled then
        v3.setCameraModeToastOpen(false)
    end
end

function v3.setCameraModeToastOpen(cameraModeToastOpen)
    --[[
      name: setCameraModeToastOpen
      line: 24
      upvalues:
        v2 (ref,  index: 1)
        starterGui (copy, index: 2)
    ]]
    assert(v2)

    if cameraModeToastOpen then
        starterGui:SetCore("SendNotification", {Title = "Camera Control Enabled", Text = "Right click to toggle", Duration = 3})
    end
end

return v3