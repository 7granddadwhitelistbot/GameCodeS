local tbl_1 = {}
local tbl_upv_2 = {}
tbl_upv_2.__index = tbl_upv_2
local ClientChatModules_1 = game:GetService("Chat"):WaitForChild("ClientChatModules")
local CommandModules_upv_1 = ClientChatModules_1:WaitForChild("CommandModules")
local Util_upv_1 = require(CommandModules_upv_1:WaitForChild("Util"))
local ChatSettings_upv_1 = require(ClientChatModules_1:WaitForChild("ChatSettings"))
function tbl_upv_2.SetupCommandProcessors(a1)
    --[[
      name: SetupCommandProcessors
      line: 19
      upvalues:
        CommandModules_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    local v1 = CommandModules_upv_1:GetChildren()
    for n_1 = 1, #v1 do
        local v2 = v1[n_1]:IsA("ModuleScript")
        if not (v2) or v1[n_1].Name == "Util" then
            continue
        end
        local v3 = require(v1[n_1])
        local v4 = v3[Util_upv_1.KEY_COMMAND_PROCESSOR_TYPE]
        local v5 = v3[Util_upv_1.KEY_PROCESSOR_FUNCTION]
        if v4 == Util_upv_1.IN_PROGRESS_MESSAGE_PROCESSOR then
            table.insert(a1.InProgressMessageProcessors, v5)
            continue
        end
        if v4 == Util_upv_1.COMPLETED_MESSAGE_PROCESSOR then
            table.insert(a1.CompletedMessageProcessors, v5)
        end
    end
end
function tbl_upv_2.ProcessCompletedChatMessage(a1, a2, a3)
    --[[
      name: ProcessCompletedChatMessage
      line: 37
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    for n_2 = 1, #a1.CompletedMessageProcessors do
        local v6 = a1.CompletedMessageProcessors[n_2](a2, a3, ChatSettings_upv_1)
        if not (v6) then
            continue
        end
        return true
    end
    return false
end
function tbl_upv_2.ProcessInProgressChatMessage(a1, a2, a3, a4)
    --[[
      name: ProcessInProgressChatMessage
      line: 47
      upvalues:
        ChatSettings_upv_1 (copy, index: 1)
    ]]
    local v7 = nil
    for n_3 = 1, #a1.InProgressMessageProcessors do
        v7 = a1.InProgressMessageProcessors[n_3](a2, a3, a4, ChatSettings_upv_1)
        if not (v7) then
            continue
        end
        return v7
    end
    return nil
end
function tbl_1.new()
    --[[
      name: new
      line: 60
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v8 = setmetatable({}, tbl_upv_2)
    v8.CompletedMessageProcessors = {}
    v8.InProgressMessageProcessors = {}
    v8:SetupCommandProcessors()
    return v8
end
return tbl_1