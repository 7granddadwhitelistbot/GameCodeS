local ContextActionService_upv_1 = game:GetService("ContextActionService")
local Players_upv_1 = game:GetService("Players")
local Keybinds_upv_1 = require(script.Parent.Parent:WaitForChild("Keybinds"))
local tbl_1 = {}
local u1 = Enum.ContextActionPriority.High.Value + 100
local u2 = false
local u3 = nil
local function inputs()
    --[[
      name: inputs
      line: 42
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
    ]]
    local tbl_2 = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2}
    for _, value_1 in {"SpectateNext", "SpectatePrev"} do
        for v1, value_2 in Keybinds_upv_1.PadInputs(value_1) do
            if not (table.find(tbl_2, value_2)) then
                table.insert(tbl_2, value_2)
            end
        end
    end
    return tbl_2
end
tbl_1.Inputs = inputs
local function bind()
    --[[
      name: bind
      line: 55
      upvalues:
        ContextActionService_upv_1 (copy, index: 1)
        u1 (copy, index: 5)
        inputs (copy, index: 6)
    ]]
    ContextActionService_upv_1:BindActionAtPriority("TribesSpectateCycle", function() end, false, u1, table.unpack(inputs()))
end
function tbl_1.SetActive(a1, a2)
    --[[
      name: SetActive
      line: 85
      upvalues:
        u3 (ref,  index: 1)
        u2 (ref,  index: 2)
        ContextActionService_upv_1 (copy, index: 3)
        u1 (copy, index: 6)
        inputs (copy, index: 7)
    ]]
    u3 = a2
    if a1 == u2 then
        return
    end
    u2 = a1
    if a1 then
        ContextActionService_upv_1:BindActionAtPriority("TribesSpectateCycle", function() end, false, u1, table.unpack(inputs()))
    else
        ContextActionService_upv_1:UnbindAction("TribesSpectateCycle")
    end
end
local function overButton(a1)
    --[[
      name: overButton
      line: 27
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local v1 = Players_upv_1.LocalPlayer and (Players_upv_1.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
    if not v1 then
        return false
    end
    local Position_1 = a1.Position
    for _, value_3 in v1:GetGuiObjectsAtPosition(Position_1.X, Position_1.Y) do
        if not (value_3:IsA("GuiButton")) or not (value_3.Active) or not (value_3.Visible) then
            continue
        end
        return true
    end
    return false
end
Keybinds_upv_1.PadChanged:Connect(
    function(a1)
        --[[
          line: 99
          upvalues:
            u2 (ref,  index: 1)
            ContextActionService_upv_1 (copy, index: 2)
            overButton (copy, index: 3)
            Keybinds_upv_1 (copy, index: 4)
            u3 (ref,  index: 5)
            u1 (copy, index: 6)
            inputs (copy, index: 7)
        ]]
        if not u2 or not table.find(a1, "SpectateNext") and not table.find(a1, "SpectatePrev") then
            return
        end
        ContextActionService_upv_1:UnbindAction("TribesSpectateCycle")
        ContextActionService_upv_1:BindActionAtPriority(
            "TribesSpectateCycle",
            function(a2, a3, a4)
                --[[
                  line: 56
                  upvalues:
                    overButton (copy, index: 1)
                    Keybinds_upv_1 (copy, index: 2)
                    u3 (ref,  index: 3)
                ]]
                if a3 ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Pass
                end
                local v2 = true
                if a4.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    v2 = a4.UserInputType == Enum.UserInputType.MouseButton2
                end
                if v2 and overButton(a4) then
                    return Enum.ContextActionResult.Pass
                end
                local v3
                if v2 then
                    v3 = a4.UserInputType == Enum.UserInputType.MouseButton2
                else
                    if Keybinds_upv_1.PadBlocked() then
                        return Enum.ContextActionResult.Pass
                    end
                    local v4 = Keybinds_upv_1.IsPad(a4, "SpectateNext")
                    local v5 = Keybinds_upv_1.IsPad(a4, "SpectatePrev")
                    if not (v4) and not (v5) then
                        return Enum.ContextActionResult.Pass
                    end
                    v3 = v5 and not v4
                end
                if u3 then
                    u3((v3 and -1) or 1)
                end
                return Enum.ContextActionResult.Sink
            end,
            false,
            u1,
            table.unpack(inputs())
        )
    end
)
function tbl_1.IsActive()
    --[[
      name: IsActive
      line: 106
      upvalues:
        u2 (ref, index: 1)
    ]]
    return u2
end
return tbl_1