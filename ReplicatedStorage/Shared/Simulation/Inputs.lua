local v1 = {
    CONTEXT = "TribesInputs",
    ACTIONS = {
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
    },
    HOLD_SCALE = 8,
    HOLD_SLOTS = 7
}

function v1.Build(parent: Instance?)
    --[[
      name: Build
      line: 54
      upvalues:
        v1 (copy, index: 1)
    ]]
    local child = parent:FindFirstChild(v1.CONTEXT)

    if child and child:IsA("InputContext") then
        return child
    end

    local parent2 = Instance.new("InputContext")
    parent2.Name = v1.CONTEXT

    for _, action in v1.ACTIONS do
        local parent3 = Instance.new("InputAction")
        parent3.Name = action.name
        parent3.Type = action.kind

        for v8, keyCode in action.keys do
            local inputBinding = Instance.new("InputBinding")
            inputBinding.Name = "Key" .. v8
            inputBinding.KeyCode = keyCode
            inputBinding.Parent = parent3
        end

        local script = Instance.new("InputBinding")
        script.Name = "Script"
        script.Type = Enum.InputBindingType.Scriptable
        script.Parent = parent3
        parent3.Parent = parent2
    end

    parent2.Parent = parent

    return parent2
end

return v1