local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 19
      upvalues:
        Class (copy, index: 1)
    ]]
    local v2 = setmetatable({}, Class)
    v2.enabled = true
    return v2
end

function Class.initializeActions(a3)
    --[[
      name: initializeActions
      line: 26
    ]]
    a3.connectionUtil:trackConnection(
        "SERVER_AUTHORITY_CHANGED",
        a3.eventBus:subscribe("SERVER_AUTHORITY_CHANGED"):Connect(
            function()
                --[[
                  line: 29
                  upvalues:
                    a3 (copy, index: 1)
                ]]
                a3.controlModule.actions = {}
            end
        )
    )

    if a3.controlModule.actions.MoveAction and a3.controlModule.actions.JumpAction then
        return
    end
    if not a3.engineInterface.player then
        return
    end

    pcall(
        function()
            --[[
              line: 42
              upvalues:
                a3 (copy, index: 1)
            ]]
            local inputContexts = script.Parent.Parent.InputContexts

            if a3.isServerAuthority then
                inputContexts = a3.engineInterface.player.InputContexts
            end

            local characterContext = inputContexts.CharacterContext
            a3.controlModule.actions = {MoveAction = characterContext.MoveAction, JumpAction = characterContext.JumpAction}
            a3.eventBus:publish("ACTIONS_RELOADED")
        end
    )
end

function Class.update(a6)
    --[[
      name: update
      line: 58
    ]]
    if not a6.controlModule.actions.MoveAction or not a6.controlModule.actions.JumpAction then
        return
    end

    local controlModule = a6.playerModule.ControlModule
    a6.controlModule.actions.MoveAction.Enabled = controlModule.Enabled
    a6.controlModule.actions.JumpAction.Enabled = controlModule.Enabled
    a6.controlModule.moveVector = a6.controlModule.actions.MoveAction:GetState()
    a6.controlModule.isJumping = a6.controlModule.actions.JumpAction:GetState()
end

function Class.Enable(a8, a9)
    --[[
      name: Enable
      line: 72
    ]]
end

return Class