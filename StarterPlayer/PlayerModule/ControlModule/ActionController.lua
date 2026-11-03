local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 19
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.enabled = true
    return v1
end
function tbl_upv_1.initializeActions(a1)
    --[[
      name: initializeActions
      line: 27
    ]]
    a1.connectionUtil:trackConnection(
        "SERVER_AUTHORITY_CHANGED",
        a1.eventBus:subscribe("SERVER_AUTHORITY_CHANGED"):Connect(
            function()
                --[[
                  line: 29
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                a1.controlModule.actions = {}
            end
        )
    )
    if (not a1.controlModule.actions.MoveAction or not a1.controlModule.actions.JumpAction) and a1.player then
        pcall(
            function()
                --[[
                  line: 38
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                local InputContexts_1 = script.Parent.Parent.InputContexts
                if a1.isServerAuthority then
                    InputContexts_1 = a1.player.InputContexts
                end
                local CharacterContext_1 = InputContexts_1.CharacterContext
                a1.controlModule.actions = {MoveAction = CharacterContext_1.MoveAction, JumpAction = CharacterContext_1.JumpAction}
                a1.eventBus:publish("ACTIONS_RELOADED")
            end
        )
    end
end
function tbl_upv_1.update(a1)
    --[[
      name: update
      line: 54
    ]]
    if not a1.controlModule.actions.MoveAction or not a1.controlModule.actions.JumpAction then
        return
    end
    local ControlModule_1 = a1.playerModule.ControlModule
    a1.controlModule.actions.MoveAction.Enabled = ControlModule_1.Enabled
    a1.controlModule.actions.JumpAction.Enabled = ControlModule_1.Enabled
    a1.controlModule.moveVector = a1.controlModule.actions.MoveAction:GetState()
    a1.controlModule.isJumping = a1.controlModule.actions.JumpAction:GetState()
end
function tbl_upv_1.Enable(a1, a2)
    --[[
      name: Enable
      line: 68
    ]]
end
return tbl_upv_1