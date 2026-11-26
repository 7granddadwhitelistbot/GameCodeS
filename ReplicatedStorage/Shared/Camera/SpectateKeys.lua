local contextActionService = game:GetService("ContextActionService")
local players = game:GetService("Players")
local Keybinds = require(script.Parent.Parent:WaitForChild("Keybinds"))
local v4 = {}
local priorityLevel = Enum.ContextActionPriority.High.Value + 100
local v6 = false
local v7 = nil

local function overButton(inputObject: InputObject)
    --[[
      name: overButton
      line: 27
      upvalues:
        players (copy, index: 1)
    ]]
    local playerGui = players.LocalPlayer and players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not playerGui then
        return false
    end

    local position = inputObject.Position

    for _, guiObject in playerGui:GetGuiObjectsAtPosition(position.X, position.Y) do
        if guiObject:IsA("GuiButton") and guiObject.Active and guiObject.Visible then
            return true
        end
    end

    return false
end

local function inputs()
    --[[
      name: inputs
      line: 42
      upvalues:
        Keybinds (copy, index: 1)
    ]]
    local v15 = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2}

    for _, v17 in {"SpectateNext", "SpectatePrev"} do
        for _, target in Keybinds.PadInputs(v17) do
            if not table.find(v15, target) then
                table.insert(v15, target)
            end
        end
    end

    return v15
end

v4.Inputs = inputs

local function bind()
    --[[
      name: bind
      line: 55
      upvalues:
        contextActionService (copy, index: 1)
        overButton (copy, index: 2)
        Keybinds (copy, index: 3)
        v7 (ref,  index: 4)
        priorityLevel (copy, index: 5)
        inputs (copy, index: 6)
    ]]
    contextActionService:BindActionAtPriority(
        "TribesSpectateCycle",
        function(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject)
            --[[
              line: 56
              upvalues:
                overButton (copy, index: 1)
                Keybinds (copy, index: 2)
                v7 (ref,  index: 3)
            ]]
            local v24

            if inputState ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass
            end

            local v25 = inputObject.UserInputType == Enum.UserInputType.MouseButton1
                or inputObject.UserInputType == Enum.UserInputType.MouseButton2

            if v25 and overButton(inputObject) then
                return Enum.ContextActionResult.Pass
            end

            if v25 then
                v24 = inputObject.UserInputType == Enum.UserInputType.MouseButton2
            else
                if Keybinds.PadBlocked() then
                    return Enum.ContextActionResult.Pass
                end

                local isPad = Keybinds.IsPad(inputObject, "SpectateNext")
                local isPad2 = Keybinds.IsPad(inputObject, "SpectatePrev")

                if not isPad and not isPad2 then
                    return Enum.ContextActionResult.Pass
                end

                v24 = isPad2 and not isPad
            end

            if v7 then
                local v28 = v7
                local v29 = v24 and -1 or 1
                v28(v29)
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        priorityLevel,
        table.unpack((inputs()))
    )
end

function v4.SetActive(a30, a31)
    --[[
      name: SetActive
      line: 85
      upvalues:
        v7 (ref,  index: 1)
        v6 (ref,  index: 2)
        contextActionService (copy, index: 3)
        overButton (copy, index: 4)
        Keybinds (copy, index: 5)
        priorityLevel (copy, index: 6)
        inputs (copy, index: 7)
    ]]
    v7 = a31

    if a30 == v6 then
        return
    end

    v6 = a30

    if not a30 then
        contextActionService:UnbindAction("TribesSpectateCycle")
        return
    end

    contextActionService:BindActionAtPriority(
        "TribesSpectateCycle",
        function(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject)
            --[[
              line: 56
              upvalues:
                overButton (copy, index: 1)
                Keybinds (copy, index: 2)
                v7 (ref,  index: 3)
            ]]
            local v35

            if inputState ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass
            end

            local v36 = inputObject.UserInputType == Enum.UserInputType.MouseButton1
                or inputObject.UserInputType == Enum.UserInputType.MouseButton2

            if v36 and overButton(inputObject) then
                return Enum.ContextActionResult.Pass
            end

            if v36 then
                v35 = inputObject.UserInputType == Enum.UserInputType.MouseButton2
            else
                if Keybinds.PadBlocked() then
                    return Enum.ContextActionResult.Pass
                end

                local isPad = Keybinds.IsPad(inputObject, "SpectateNext")
                local isPad2 = Keybinds.IsPad(inputObject, "SpectatePrev")

                if not isPad and not isPad2 then
                    return Enum.ContextActionResult.Pass
                end

                v35 = isPad2 and not isPad
            end

            if v7 then
                local v39 = v7
                local v40 = v35 and -1 or 1
                v39(v40)
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        priorityLevel,
        table.unpack((inputs()))
    )
end

Keybinds.PadChanged:Connect(
    function(a41)
        --[[
          line: 99
          upvalues:
            v6 (ref,  index: 1)
            contextActionService (copy, index: 2)
            overButton (copy, index: 3)
            Keybinds (copy, index: 4)
            v7 (ref,  index: 5)
            priorityLevel (copy, index: 6)
            inputs (copy, index: 7)
        ]]
        if v6 and (table.find(a41, "SpectateNext") or table.find(a41, "SpectatePrev")) then
            contextActionService:UnbindAction("TribesSpectateCycle")

            contextActionService:BindActionAtPriority(
                "TribesSpectateCycle",
                function(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject)
                    --[[
                      line: 56
                      upvalues:
                        overButton (copy, index: 1)
                        Keybinds (copy, index: 2)
                        v7 (ref,  index: 3)
                    ]]
                    local v45

                    if inputState ~= Enum.UserInputState.Begin then
                        return Enum.ContextActionResult.Pass
                    end

                    local v46 = inputObject.UserInputType == Enum.UserInputType.MouseButton1
                        or inputObject.UserInputType == Enum.UserInputType.MouseButton2

                    if v46 and overButton(inputObject) then
                        return Enum.ContextActionResult.Pass
                    end

                    if v46 then
                        v45 = inputObject.UserInputType == Enum.UserInputType.MouseButton2
                    else
                        if Keybinds.PadBlocked() then
                            return Enum.ContextActionResult.Pass
                        end

                        local isPad = Keybinds.IsPad(inputObject, "SpectateNext")
                        local isPad2 = Keybinds.IsPad(inputObject, "SpectatePrev")

                        if not isPad and not isPad2 then
                            return Enum.ContextActionResult.Pass
                        end

                        v45 = isPad2 and not isPad
                    end

                    if v7 then
                        local v49 = v7
                        local v50 = v45 and -1 or 1
                        v49(v50)
                    end

                    return Enum.ContextActionResult.Sink
                end,
                false,
                priorityLevel,
                table.unpack((inputs()))
            )
        end
    end
)

function v4.IsActive()
    --[[
      name: IsActive
      line: 106
      upvalues:
        v6 (ref, index: 1)
    ]]
    return v6
end

return v4