local tbl_upv_1 = {}
tbl_upv_1.CONTEXT = "TribesInputs"
tbl_upv_1.ACTIONS = {
    {name = "Slide", kind = Enum.InputActionType.Bool, keys = {Enum.KeyCode.C, Enum.KeyCode.LeftControl, Enum.KeyCode.ButtonB}},
    {name = "Jump", kind = Enum.InputActionType.Bool, keys = {Enum.KeyCode.Space, Enum.KeyCode.ButtonA}},
    {name = "Aim", kind = Enum.InputActionType.Bool, keys = {}},
    {name = "Charge", kind = Enum.InputActionType.Bool, keys = {}},
    {name = "Block", kind = Enum.InputActionType.Bool, keys = {}},
    {name = "Reload", kind = Enum.InputActionType.Bool, keys = {}},
    {name = "Use", kind = Enum.InputActionType.Bool, keys = {}},
    {name = "Lunge", kind = Enum.InputActionType.Bool, keys = {}},
    {name = "Facing", kind = Enum.InputActionType.Direction2D, keys = {}},
    {name = "Look", kind = Enum.InputActionType.Direction2D, keys = {}},
    {name = "Hold", kind = Enum.InputActionType.Direction1D, keys = {}}
}
tbl_upv_1.HOLD_SCALE = 8
tbl_upv_1.HOLD_SLOTS = 7
function tbl_upv_1.Build(a1)
    --[[
      name: Build
      line: 54
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = a1:FindFirstChild(tbl_upv_1.CONTEXT)
    if v1 and v1:IsA("InputContext") then
        return v1
    end
    local v2 = Instance.new("InputContext")
    v2.Name = tbl_upv_1.CONTEXT
    for _, value_1 in tbl_upv_1.ACTIONS do
        local v3 = Instance.new("InputAction")
        v3.Name = value_1.name
        v3.Type = value_1.kind
        for key_1, value_2 in value_1.keys do
            local v4 = Instance.new("InputBinding")
            v4.Name = "Key" .. key_1
            v4.KeyCode = value_2
            v4.Parent = v3
        end
        local v5 = Instance.new("InputBinding")
        v5.Name = "Script"
        v5.Type = Enum.InputBindingType.Scriptable
        v5.Parent = v3
        v3.Parent = v2
    end
    v2.Parent = a1
    return v2
end
return tbl_upv_1