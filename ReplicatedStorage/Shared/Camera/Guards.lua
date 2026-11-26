local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local v5 = {}
local v6 = nil
local localPlayer = players.LocalPlayer
local v8 = {}
local v9 = {}
local timestamp = 0
local text = nil
local v12 = nil
local v13 = {}
local v14 = {}
setmetatable(v14, {__mode = "k"})
local keyCode = nil
local userInputType = nil
local timestamp2 = 0
local v18 = false
local v19 = true

local function note(key)
    --[[
      name: note
      line: 64
      upvalues:
        v13 (copy, index: 1)
    ]]
    v13[key] = (v13[key] or 0) + 1
end

local function matchPhase()
    --[[
      name: matchPhase
      line: 69
      upvalues:
        localPlayer (copy, index: 1)
        workspace (copy, index: 2)
    ]]
    if localPlayer:GetAttribute("State") ~= "Match" then
        return "none"
    end

    local v23 = localPlayer:GetAttribute("MatchId")
    local arenas = workspace:FindFirstChild("Arenas")
    local instance = if arenas and type(v23) == "string" and v23 ~= "" then arenas:FindFirstChild(v23) else nil
    local phase = instance and instance:GetAttribute("Phase")

    if type(phase) ~= "string" then
        return nil
    end

    return phase
end

local function onScreen(a28)
    --[[
      name: onScreen
      line: 82
    ]]
    local success, result = pcall(
        function()
            --[[
              line: 83
              upvalues:
                a28 (copy, index: 1)
            ]]
            local v31, v32
            v31 = a28

            while v31 do
                if v31:IsA("GuiObject") and not v31.Visible then
                    return false
                end

                if v31:IsA("LayerCollector") then
                    v32 = v31.Enabled
                    v32 = v32 and v31.Parent ~= nil

                    return v32
                end

                v31 = v31.Parent
            end

            return false
        end
    )

    if success then
        return result == true
    end

    return true
end

local function clearTouches(a34)
    --[[
      name: clearTouches
      line: 99
      upvalues:
        v6 (ref,  index: 1)
        v13 (copy, index: 2)
    ]]
    local v35 = v6

    if v35 and next(v35.touches) ~= nil then
        table.clear(v35.touches)
        local v36 = "touches:" .. a34
        v13[v36] = (v13[v36] or 0) + 1
    end
end

function v5.PruneTouches(a37)
    --[[
      name: PruneTouches
      line: 108
      upvalues:
        v13 (copy, index: 1)
    ]]
    local count = 0

    for v39 in a37 do
        local userInputState = v39.UserInputState

        if userInputState == Enum.UserInputState.End or userInputState == Enum.UserInputState.Cancel then
            a37[v39] = nil
            v13["touches:ended"] = (v13["touches:ended"] or 0) + 1
        else
            count += 1
        end
    end

    return count
end

function v5.LockPushed(key, a42)
    --[[
      name: LockPushed
      line: 123
      upvalues:
        v8 (copy, index: 1)
        v9 (copy, index: 2)
    ]]
    local v43
    v8[key] = os.clock()

    if typeof(a42) ~= "number" then
        v43 = 10
    else
        v43 = a42
    end

    v9[key] = math.clamp(v43, 0.1, 10)
end

function v5.LockPopped(key)
    --[[
      name: LockPopped
      line: 128
      upvalues:
        v8 (copy, index: 1)
        v9 (copy, index: 2)
    ]]
    v8[key] = nil
    v9[key] = nil
end

function v5.SetChatConfig(chatConfig)
    --[[
      name: SetChatConfig
      line: 133
      upvalues:
        v12 (ref, index: 1)
    ]]
    v12 = chatConfig
end

function v5.FreeKeyDown(a46)
    --[[
      name: FreeKeyDown
      line: 138
      upvalues:
        keyCode (ref, index: 1)
        userInputType (ref, index: 2)
        timestamp2 (ref, index: 3)
        v18 (ref, index: 4)
        v19 (ref, index: 5)
    ]]
    local keyCode2 = a46.KeyCode
    local userInputType2 = a46.UserInputType
    local timestamp = os.clock()
    keyCode = keyCode2
    userInputType = userInputType2
    timestamp2 = timestamp
    v18 = v19
end

function v5.FreeKeyUp()
    --[[
      name: FreeKeyUp
      line: 142
      upvalues:
        keyCode (ref, index: 1)
        v18 (ref, index: 2)
        v19 (ref, index: 3)
        timestamp2 (ref, index: 4)
    ]]
    local v50 = keyCode ~= nil and v18 and v19 and os.clock() - timestamp2 <= 1
    keyCode = nil

    return v50
end

function v5.FreeKeyCancel()
    --[[
      name: FreeKeyCancel
      line: 148
      upvalues:
        keyCode (ref, index: 1)
    ]]
    keyCode = nil
end

function v5.Blockers()
    --[[
      name: Blockers
      line: 153
      upvalues:
        v6 (ref, index: 1)
    ]]
    return if const v51 = v6 then (v51.blockers()) else {}
end

local function pass(timestamp: number)
    --[[
      name: pass
      line: 158
      upvalues:
        v6 (ref,  index: 1)
        v8 (copy, index: 2)
        v5 (copy, index: 3)
        v9 (copy, index: 4)
        v13 (copy, index: 5)
        matchPhase (copy, index: 6)
        userInputService (copy, index: 7)
        v14 (copy, index: 8)
        v12 (ref,  index: 9)
        text (ref,  index: 10)
        localPlayer (copy, index: 11)
    ]]
    local v54 = v6
    local v55 = false
    local v56 = nil

    for v57 in v54.lookLocks do
        local v58
        local v59 = v8[v57]

        if v59 == nil then
            v5.LockPushed(v57)
            v58 = v8[v57]
        else
            v58 = v59
        end

        local v60 = timestamp - v58

        if (v9[v57] or 10) < v60 then
            local v61 = "lock:" .. v57 .. ":timeout"
            v13[v61] = (v13[v61] or 0) + 1
            v54.popLookLock(v57)
        elseif v57 == "Intro" then
            if not (0.5 < v60) then
                continue
            end

            if not v55 then
                v56 = matchPhase()
                v55 = true
            end

            if v56 ~= nil and v56 ~= "Intro" and v56 ~= "Loading" then
                local v62 = "lock:Intro:" .. tostring(v56)
                v13[v62] = (v13[v62] or 0) + 1
                v54.popLookLock(v57)
            end
        end
    end

    if v54.unlockReasons.TextBox then
        if const focusedTextBox = userInputService:GetFocusedTextBox() then
            local result

            local success, result2 = pcall(
                function()
                    --[[
                      line: 83
                      upvalues:
                        focusedTextBox (copy, index: 1)
                    ]]
                    local v67, v68
                    v67 = focusedTextBox

                    while v67 do
                        if v67:IsA("GuiObject") and not v67.Visible then
                            return false
                        end

                        if v67:IsA("LayerCollector") then
                            v68 = v67.Enabled
                            v68 = v68 and v67.Parent ~= nil

                            return v68
                        end

                        v67 = v67.Parent
                    end

                    return false
                end
            )

            if success then
                result = result2 == true
            else
                result = true
            end

            if not result then
                if 1 <= timestamp - (v14[focusedTextBox] or -math.huge) then
                    v14[focusedTextBox] = timestamp
                    pcall(
                        function()
                            --[[
                              line: 192
                              upvalues:
                                focusedTextBox (copy, index: 1)
                            ]]
                            focusedTextBox:ReleaseFocus()
                        end
                    )
                end

                local unlockTextBoxHidden = v13["unlock:TextBox:hidden"] or 0
                v13["unlock:TextBox:hidden"] = unlockTextBoxHidden + 1
                v54.popUnlock("TextBox")
            end
        else
            v13["unlock:TextBox:none"] = (v13["unlock:TextBox:none"] or 0) + 1
            v54.popUnlock("TextBox")
        end
    end

    if v54.unlockReasons.ChatFocus then
        local v70 = v12

        if v70 and v70.Parent and not v70.IsFocused then
            local unlockChatFocus = v13["unlock:ChatFocus"] or 0
            v13["unlock:ChatFocus"] = unlockChatFocus + 1
            v54.popUnlock("ChatFocus")
        end
    end

    v5.PruneTouches(v54.touches)
    local parts = v54.blockers()
    local cameraLookBlock = table.concat(parts, " ")

    if cameraLookBlock ~= text then
        text = cameraLookBlock
        localPlayer:SetAttribute("CameraLookBlock", cameraLookBlock)
    end
end

function v5.Step()
    --[[
      name: Step
      line: 219
      upvalues:
        v6 (ref,  index: 1)
        timestamp (ref,  index: 2)
        pass (copy, index: 3)
    ]]
    if not v6 then
        return
    end

    local timestamp2 = os.clock()

    if timestamp2 - timestamp < 0.25 then
        return
    end

    timestamp = timestamp2
    pass(timestamp2)
end

function v5.Stats()
    --[[
      name: Stats
      line: 232
      upvalues:
        v13 (copy, index: 1)
    ]]
    return table.clone(v13)
end

local hasRun = false

function v5.Start(a76)
    --[[
      name: Start
      line: 237
      upvalues:
        v6 (ref,  index: 1)
        hasRun (ref,  index: 2)
        userInputService (copy, index: 3)
        keyCode (ref,  index: 4)
        userInputType (ref,  index: 5)
        v18 (ref,  index: 6)
        v19 (ref,  index: 7)
        v13 (copy, index: 8)
        guiService (copy, index: 9)
    ]]
    v6 = a76

    if hasRun then
        return
    end

    hasRun = true

    userInputService.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 244
              upvalues:
                keyCode (ref, index: 1)
                userInputType (ref, index: 2)
                v18 (ref, index: 3)
            ]]
            if keyCode == nil then
                return
            end

            local userInputType2 = input.UserInputType

            if userInputType2 == userInputType then
                if userInputType2 ~= Enum.UserInputType.Keyboard then
                    return
                end
                if input.KeyCode == keyCode then
                    return
                end
            end

            if userInputType2 == Enum.UserInputType.Keyboard
                or userInputType2 == Enum.UserInputType.MouseButton1
                or userInputType2 == Enum.UserInputType.MouseButton2
                or userInputType2 == Enum.UserInputType.MouseButton3
            then
                v18 = false
            end
        end
    )

    userInputService.WindowFocusReleased:Connect(
        function()
            --[[
              line: 257
              upvalues:
                v19 (ref,  index: 1)
                keyCode (ref,  index: 2)
                v6 (ref,  index: 3)
                v13 (copy, index: 4)
            ]]
            v19 = false
            keyCode = nil
            local v79 = v6

            if v79 and next(v79.touches) ~= nil then
                table.clear(v79.touches)
                v13["touches:focus"] = (v13["touches:focus"] or 0) + 1
            end

            local v80 = v6

            if v80 and v80.unlockReasons.FreeCursor then
                v13["unlock:FreeCursor:focus"] = (v13["unlock:FreeCursor:focus"] or 0) + 1
                v80.popUnlock("FreeCursor")
            end
        end
    )

    userInputService.WindowFocused:Connect(
        function()
            --[[
              line: 267
              upvalues:
                v19 (ref, index: 1)
            ]]
            v19 = true
        end
    )

    guiService.MenuOpened:Connect(
        function()
            --[[
              line: 270
              upvalues:
                keyCode (ref,  index: 1)
                v6 (ref,  index: 2)
                v13 (copy, index: 3)
            ]]
            keyCode = nil
            local v81 = v6

            if v81 and next(v81.touches) ~= nil then
                table.clear(v81.touches)
                v13["touches:menu"] = (v13["touches:menu"] or 0) + 1
            end
        end
    )
end

return v5