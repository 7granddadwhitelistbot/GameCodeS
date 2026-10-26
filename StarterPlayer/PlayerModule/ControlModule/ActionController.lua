local u1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserControlModuleEnabledAPI")
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 23
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = setmetatable({}, tbl_upv_1)
    v1.enabled = true
    return v1
end
function tbl_upv_1.initializeActions(a1, a2)
    --[[
      name: initializeActions
      line: 31
    ]]
    a1.connectionUtil:trackConnection(
        "SERVER_AUTHORITY_CHANGED",
        a1.eventBus:subscribe("SERVER_AUTHORITY_CHANGED"):Connect(
            function()
                --[[
                  line: 33
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                a2.actions = {}
            end
        )
    )
    if (not a2.actions.MoveAction or not a2.actions.JumpAction) and a2.player then
        pcall(
            function()
                --[[
                  line: 42
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                local InputContexts_1 = script.Parent.Parent.InputContexts
                if a1.isServerAuthority then
                    InputContexts_1 = a2.player.InputContexts
                end
                local CharacterContext_1 = InputContexts_1.CharacterContext
                a2.actions = {MoveAction = CharacterContext_1.MoveAction, JumpAction = CharacterContext_1.JumpAction}
                a1.eventBus:publish("ACTIONS_RELOADED")
            end
        )
    end
end
function tbl_upv_1.update(a1)
    --[[
      name: update
      line: 58
      upvalues:
        u1 (copy, index: 1)
    ]]
    if not u1 then
        a1.moveVector = a1.actions.MoveAction:GetState()
        a1.isJumping = a1.actions.JumpAction:GetState()
    end
    if a1.actions.MoveAction and a1.actions.JumpAction then
        local ControlModule_1 = a1.playerModule.ControlModule
        a1.actions.MoveAction.Enabled = ControlModule_1.Enabled
        a1.actions.JumpAction.Enabled = ControlModule_1.Enabled
        a1.moveVector = a1.actions.MoveAction:GetState()
        a1.isJumping = a1.actions.JumpAction:GetState()
        return
    end
end
function tbl_upv_1.Enable(a1, a2)
    --[[
      name: Enable
      line: 74
    ]]
end
return tbl_upv_1