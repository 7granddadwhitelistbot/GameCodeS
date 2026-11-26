local players = game:GetService("Players")
local Parent = require(script.Parent)
local v3 = Parent.get("ConnectionUtil")
local v4 = {
    _connectionUtil = v3.new(),
    _boundEvents = {},
    getLocalPlayer = (function()
        --[[
          name: getLocalPlayer
          line: 55
          upvalues:
            players (copy, index: 1)
        ]]
        return players.LocalPlayer
    end)
}

function v4.onLocalPlayer(callback)
    --[[
      name: onLocalPlayer
      line: 59
      upvalues:
        v4 (copy, index: 1)
        players (copy, index: 2)
    ]]
    if const localPlayer = v4.getLocalPlayer() then
        callback(localPlayer)
    end

    v4._connectionUtil:trackConnection(
        "LOCAL_PLAYER",
        players:GetPropertyChangedSignal("LocalPlayer"):Connect(
            function()
                --[[
                  line: 68
                  upvalues:
                    v4 (copy, index: 1)
                ]]
                local localPlayer = v4.getLocalPlayer()
                assert(localPlayer)
                v4._getOrCreateBoundEvent("LOCAL_PLAYER"):Fire(localPlayer)
            end
        )
    )

    local orCreateBoundEvent = v4._getOrCreateBoundEvent("LOCAL_PLAYER")

    return orCreateBoundEvent.Event:Connect(callback)
end

function v4.getCharacter()
    --[[
      name: getCharacter
      line: 79
      upvalues:
        v4 (copy, index: 1)
    ]]
    return if const localPlayer = v4.getLocalPlayer() then localPlayer.Character else nil
end

function v4.onCharacter(callback)
    --[[
      name: onCharacter
      line: 87
      upvalues:
        v4 (copy, index: 1)
    ]]
    v4._connectionUtil:trackConnection(
        "ON_LOCAL_PLAYER",
        v4.onLocalPlayer(
            function(a11)
                --[[
                  line: 91
                  upvalues:
                    v4 (copy, index: 1)
                    callback (copy, index: 2)
                ]]
                if const character = v4.getCharacter() then
                    callback(character)
                end

                v4._connectionUtil:trackConnection(
                    "CHARACTER_ADDED",
                    a11.CharacterAdded:Connect(
                        function(a13)
                            --[[
                              line: 100
                              upvalues:
                                v4 (copy, index: 1)
                            ]]
                            assert(a13)
                            v4._getOrCreateBoundEvent("CHARACTER_ADDED"):Fire(a13)
                        end
                    )
                )
            end
        )
    )

    local orCreateBoundEvent = v4._getOrCreateBoundEvent("CHARACTER_ADDED")

    return orCreateBoundEvent.Event:Connect(callback)
end

function v4.getChild(a15, a16)
    --[[
      name: getChild
      line: 112
      upvalues:
        v4 (copy, index: 1)
    ]]
    local character = v4.getCharacter()
    if not character then
        return nil
    end

    local v18 = character:FindFirstChild(a15)

    if v18 and v18:IsA(a16) then
        return v18
    end

    return nil
end

function v4.onChild(a19, a20, callback)
    --[[
      name: onChild
      line: 124
      upvalues:
        v4 (copy, index: 1)
    ]]
    v4._connectionUtil:trackConnection(
        "ON_CHARACTER",
        v4.onCharacter(
            function(a22)
                --[[
                  line: 128
                  upvalues:
                    v4 (copy, index: 1)
                    a19 (copy, index: 2)
                    a20 (copy, index: 3)
                    callback (copy, index: 4)
                ]]
                if const child = v4.getChild(a19, a20) then
                    callback(child)
                end

                v4._connectionUtil:trackConnection(
                    "CHARACTER_CHILD_ADDED",
                    a22.ChildAdded:Connect(
                        function(a24)
                            --[[
                              line: 137
                              upvalues:
                                a19 (copy, index: 1)
                                a20 (copy, index: 2)
                                v4 (copy, index: 3)
                            ]]
                            if a24.Name == a19 and a24:IsA(a20) then
                                v4._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. a19 .. a20):Fire(a24)
                            end
                        end
                    )
                )
            end
        )
    )

    local orCreateBoundEvent = v4._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. a19 .. a20)

    return orCreateBoundEvent.Event:Connect(callback)
end

function v4._getOrCreateBoundEvent(boundEventKey)
    --[[
      name: _getOrCreateBoundEvent
      line: 151
      upvalues:
        v4 (copy, index: 1)
    ]]
    if not v4._boundEvents[boundEventKey] then
        v4._boundEvents[boundEventKey] = Instance.new("BindableEvent")
    end

    return v4._boundEvents[boundEventKey]
end

return v4