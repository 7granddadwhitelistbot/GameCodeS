local Players_upv_1 = game:GetService("Players")
local tbl_upv_1 = {}
tbl_upv_1._connectionUtil = require(script.Parent).get("ConnectionUtil").new()
tbl_upv_1._boundEvents = {}
function tbl_upv_1.getLocalPlayer()
    --[[
      name: getLocalPlayer
      line: 55
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    return Players_upv_1.LocalPlayer
end
function tbl_upv_1.onLocalPlayer(a1)
    --[[
      name: onLocalPlayer
      line: 59
      upvalues:
        tbl_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
    ]]
    local v1 = tbl_upv_1.getLocalPlayer()
    if v1 then
        a1(v1)
    end
    tbl_upv_1._connectionUtil:trackConnection(
        "LOCAL_PLAYER",
        Players_upv_1:GetPropertyChangedSignal("LocalPlayer"):Connect(
            function()
                --[[
                  line: 68
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                ]]
                local v2 = tbl_upv_1.getLocalPlayer()
                assert(v2)
                tbl_upv_1._getOrCreateBoundEvent("LOCAL_PLAYER"):Fire(v2)
            end
        )
    )
    return tbl_upv_1._getOrCreateBoundEvent("LOCAL_PLAYER").Event:Connect(a1)
end
function tbl_upv_1.getCharacter()
    --[[
      name: getCharacter
      line: 79
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v3 = tbl_upv_1.getLocalPlayer()
    if v3 then
        return v3.Character
    end
    return nil
end
function tbl_upv_1.onCharacter(a1)
    --[[
      name: onCharacter
      line: 87
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    tbl_upv_1._connectionUtil:trackConnection(
        "ON_LOCAL_PLAYER",
        tbl_upv_1.onLocalPlayer(
            function(a2)
                --[[
                  line: 91
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                local v4 = tbl_upv_1.getCharacter()
                if v4 then
                    a1(v4)
                end
                tbl_upv_1._connectionUtil:trackConnection(
                    "CHARACTER_ADDED",
                    a2.CharacterAdded:Connect(
                        function(a3)
                            --[[
                              line: 100
                              upvalues:
                                tbl_upv_1 (copy, index: 1)
                            ]]
                            assert(a3)
                            tbl_upv_1._getOrCreateBoundEvent("CHARACTER_ADDED"):Fire(a3)
                        end
                    )
                )
            end
        )
    )
    return tbl_upv_1._getOrCreateBoundEvent("CHARACTER_ADDED").Event:Connect(a1)
end
function tbl_upv_1.getChild(a1, a2)
    --[[
      name: getChild
      line: 112
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v5 = tbl_upv_1.getCharacter()
    if not v5 then
        return nil
    end
    local v6 = v5:FindFirstChild(a1)
    if v6 and v6:IsA(a2) then
        return v6
    end
    return nil
end
function tbl_upv_1.onChild(a1, a2, a3)
    --[[
      name: onChild
      line: 124
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    tbl_upv_1._connectionUtil:trackConnection(
        "ON_CHARACTER",
        tbl_upv_1.onCharacter(
            function(a4)
                --[[
                  line: 128
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                    a1 (copy, index: 2)
                    a2 (copy, index: 3)
                    a3 (copy, index: 4)
                ]]
                local v7 = tbl_upv_1.getChild(a1, a2)
                if v7 then
                    a3(v7)
                end
                tbl_upv_1._connectionUtil:trackConnection(
                    "CHARACTER_CHILD_ADDED",
                    a4.ChildAdded:Connect(
                        function(a5)
                            --[[
                              line: 137
                              upvalues:
                                a1 (copy, index: 1)
                                a2 (copy, index: 2)
                                tbl_upv_1 (copy, index: 3)
                            ]]
                            if a5.Name ~= a1 or not a5:IsA(a2) then
                                return
                            end
                            tbl_upv_1._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. a1 .. a2):Fire(a5)
                        end
                    )
                )
            end
        )
    )
    return tbl_upv_1._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. a1 .. a2).Event:Connect(a3)
end
function tbl_upv_1._getOrCreateBoundEvent(a1)
    --[[
      name: _getOrCreateBoundEvent
      line: 151
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if not (tbl_upv_1._boundEvents[a1]) then
        tbl_upv_1._boundEvents[a1] = Instance.new("BindableEvent")
    end
    return tbl_upv_1._boundEvents[a1]
end
return tbl_upv_1