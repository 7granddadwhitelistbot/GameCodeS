local players = game:GetService("Players")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local v4 = AvatarAbilitiesInterface.get(players.LocalPlayer)
local InputSlots = require(script.Parent:WaitForChild("InputSlots"))
local AbilityButton = require(script.Parent:WaitForChild("AbilityButton"))
local v7 = CommonUtils.get("FlagUtil")
local userFlag = v7.getUserFlag("UserAbilitiesUserInterfaceA")
local v9 = {{small = {72, 60, 60}, large = {92, 112, 112}}, {small = {44, 132, 132}, large = {56, 200, 200}}, {small = {44, 132, 16}, large = {56, 200, 60}}, {small = {44, 16, 132}, large = {56, 60, 200}}, {small = {44, 156, 74}, large = {56, 228, 130}}, {small = {44, 74, 156}, large = {56, 130, 228}}, {small = {44, 16, 16}, large = {56, 60, 60}}}
local Class = {}
Class.__index = Class

function Class.new(parentUiFrame)
    --[[
      name: new
      line: 52
      upvalues:
        Class (copy, index: 1)
    ]]
    local v12 = setmetatable({}, Class)
    v12.parentUIFrame = parentUiFrame
    v12.managedButtons = {}
    v12.connections = {}
    v12.created = false
    v12.enabled = false
    v12.enabledChangedEvent = Instance.new("BindableEvent")
    return v12
end

function Class.Enable(self, enabled)
    --[[
      name: Enable
      line: 66
    ]]
    if self.enabled == enabled then
        return
    end

    self.enabled = enabled

    if enabled and not self.created then
        self:Create()
        self.created = true
    end

    self.enabledChangedEvent:Fire()
end

function Class.Create(self)
    --[[
      name: Create
      line: 80
      upvalues:
        v4 (copy, index: 1)
        InputSlots (copy, index: 2)
        v9 (copy, index: 3)
        userFlag (copy, index: 4)
        AbilityButton (copy, index: 5)
    ]]
    if not self.parentUIFrame then
        return
    end

    local function CreateButtons()
        --[[
          name: CreateButtons
          line: 85
          upvalues:
            self (copy, index: 1)
            v4 (copy, index: 2)
            InputSlots (copy, index: 3)
            v9 (copy, index: 4)
            userFlag (copy, index: 5)
            AbilityButton (copy, index: 6)
        ]]
        for _, managedButton in self.managedButtons do
            managedButton:Destroy()
        end

        self.managedButtons = {}

        if v4:isEnabled() then
            local slotMap = InputSlots.GetSlotMap()

            for v20, v21 in slotMap do
                local actionInSlot = InputSlots.GetActionInSlot(v20)

                if v21 then
                    if not actionInSlot then
                        continue
                    end
                    if not (v20 <= #v9) then
                        continue
                    end

                    if userFlag or v20 == 1 then
                        local abilityConfig = v4:GetAbilityConfig(v21)
                        table.insert(self.managedButtons, AbilityButton.create(self, v21, abilityConfig, actionInSlot, v9[v20], false))
                    end
                end
            end
        end
    end

    CreateButtons()
    table.insert(self.connections, InputSlots.GetSlotMapChangedSignal():Connect(CreateButtons))
    table.insert(self.connections, v4:GetEnabledChangedSignal():Connect(CreateButtons))
end

function Class.Destroy(self)
    --[[
      name: Destroy
      line: 122
    ]]
    for _, connection in self.connections do
        connection:Disconnect()
    end

    self.connections = {}

    for _, managedButton in self.managedButtons do
        managedButton:Destroy()
    end

    self.managedButtons = {}
    self.enabledChangedEvent:Destroy()
    self.created = false
    self.enabled = false
end

return Class