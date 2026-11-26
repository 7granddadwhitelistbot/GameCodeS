local v1 = {}
local Class = {}
Class.__index = Class
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local commandModules = clientChatModules:WaitForChild("CommandModules")
local childName = "Util"
local child = require(commandModules:WaitForChild(childName))
local _ = script.Parent
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))

function Class.SetupCommandProcessors(self)
    --[[
      name: SetupCommandProcessors
      line: 19
      upvalues:
        commandModules (copy, index: 1)
        child (copy, index: 2)
    ]]
    local children = commandModules:GetChildren()

    for childKey = 1, #children do
        if children[childKey]:IsA("ModuleScript") and children[childKey].Name ~= "Util" then
            local Module = require(children[childKey])
            local v14 = Module[child.KEY_COMMAND_PROCESSOR_TYPE]
            local v15 = Module[child.KEY_PROCESSOR_FUNCTION]

            if v14 == child.IN_PROGRESS_MESSAGE_PROCESSOR then
                table.insert(self.InProgressMessageProcessors, v15)
            elseif v14 == child.COMPLETED_MESSAGE_PROCESSOR then
                table.insert(self.CompletedMessageProcessors, v15)
            end
        end
    end
end

function Class.ProcessCompletedChatMessage(self, a17, a18)
    --[[
      name: ProcessCompletedChatMessage
      line: 37
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    for completedMessageProcessorKey = 1, #self.CompletedMessageProcessors do
        if self.CompletedMessageProcessors[completedMessageProcessorKey](a17, a18, ChatSettings) then
            return true
        end
    end

    return false
end

function Class.ProcessInProgressChatMessage(self, a21, a22, a23)
    --[[
      name: ProcessInProgressChatMessage
      line: 47
      upvalues:
        ChatSettings (copy, index: 1)
    ]]
    local v24

    for inProgressMessageProcessorKey = 1, #self.InProgressMessageProcessors do
        v24 = self.InProgressMessageProcessors[inProgressMessageProcessorKey](a21, a22, a23, ChatSettings)

        if v24 then
            return v24
        end
    end

    return nil
end

function v1.new()
    --[[
      name: new
      line: 60
      upvalues:
        Class (copy, index: 1)
    ]]
    local v26 = setmetatable({}, Class)
    v26.CompletedMessageProcessors = {}
    v26.InProgressMessageProcessors = {}
    v26:SetupCommandProcessors()

    return v26
end

return v1