local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds = require(replicatedStorage.Shared:WaitForChild("Keybinds"))
local UI = require(script.Parent:WaitForChild("UI"))
local v11 = {}
local v12 = {}
local v13 = nil
local v14 = {}
local v15 = false
local result = nil
local timestamp = 0
v11.Changed = Signal.new()

function v11.Camera()
    --[[
      name: Camera
      line: 45
      upvalues:
        result (ref,  index: 1)
        timestamp (ref,  index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    if result then
        return result
    end
    if os.clock() - timestamp < 3 then
        return nil
    end

    timestamp = os.clock()
    local shared = replicatedStorage:FindFirstChild("Shared")
    local camera = shared and shared:FindFirstChild("Camera")

    if camera and camera:IsA("ModuleScript") then
        local success, result2 = pcall(require, camera)

        if success and type(result2) == "table" then
            result = result2
        end
    end

    return result
end

local function applyMouse()
    --[[
      name: applyMouse
      line: 64
      upvalues:
        v14 (copy, index: 1)
        v15 (ref,  index: 2)
        v11 (copy, index: 3)
        userInputService (copy, index: 4)
    ]]
    local mouseIconEnabled = next(v14) ~= nil

    if mouseIconEnabled == v15 then
        return
    end

    v15 = mouseIconEnabled

    if const v24 = v11.Camera() then
        local v25 = if mouseIconEnabled then v24.PushMouseUnlock else v24.PopMouseUnlock

        if type(v25) == "function" then
            pcall(v25, "UI")
        end
    end

    if mouseIconEnabled then
        userInputService.MouseIconEnabled = true
    end
end

function v11.PushMouse(key)
    --[[
      name: PushMouse
      line: 83
      upvalues:
        v14 (copy, index: 1)
        applyMouse (copy, index: 2)
    ]]
    v14[key] = true
    applyMouse()
end

function v11.PopMouse(key)
    --[[
      name: PopMouse
      line: 87
      upvalues:
        v14 (copy, index: 1)
        applyMouse (copy, index: 2)
    ]]
    v14[key] = nil
    applyMouse()
end

local blurEffect = nil

local function setBlur(blur: boolean)
    --[[
      name: setBlur
      line: 93
      upvalues:
        workspace (copy, index: 1)
        blurEffect (ref,  index: 2)
        tweenService (copy, index: 3)
    ]]
    local size
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    if not blurEffect or blurEffect.Parent ~= camera then
        if blurEffect then
            blurEffect:Destroy()
        end

        local tribesMenuBlur = Instance.new("BlurEffect")
        tribesMenuBlur.Name = "TribesMenuBlur"
        tribesMenuBlur.Size = 0
        tribesMenuBlur.Parent = camera
        blurEffect = tribesMenuBlur
    end

    local blurEffect2 = blurEffect
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
    local propertyTable = {}

    if blur then
        size = 12
    else
        size = 0
    end

    propertyTable.Size = size
    tweenService:Create(blurEffect2, tweenInfo, propertyTable):Play()
end

local v37 = nil

local function hideChat()
    --[[
      name: hideChat
      line: 117
      upvalues:
        v37 (ref, index: 1)
    ]]
    if v37 then
        return
    end

    local v39 = {}
    v37 = v39

    pcall(
        function()
            --[[
              line: 123
              upvalues:
                v39 (copy, index: 1)
            ]]
            local textChatService = game:GetService("TextChatService")
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration then
                v39.window = chatWindowConfiguration.Enabled
                chatWindowConfiguration.Enabled = false
            end

            if chatInputBarConfiguration then
                v39.bar = chatInputBarConfiguration.Enabled
                chatInputBarConfiguration.Enabled = false
            end
        end
    )

    pcall(
        function()
            --[[
              line: 136
              upvalues:
                v39 (copy, index: 1)
            ]]
            local starterGui = game:GetService("StarterGui")
            v39.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
            starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end
    )
end

local function restoreChat()
    --[[
      name: restoreChat
      line: 142
      upvalues:
        v37 (ref, index: 1)
    ]]
    local v45 = v37
    if not v45 then
        return
    end

    v37 = nil

    pcall(
        function()
            --[[
              line: 148
              upvalues:
                v45 (copy, index: 1)
            ]]
            local textChatService = game:GetService("TextChatService")
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration and v45.window ~= nil then
                chatWindowConfiguration.Enabled = v45.window
            end

            if chatInputBarConfiguration and v45.bar ~= nil then
                chatInputBarConfiguration.Enabled = v45.bar
            end
        end
    )

    pcall(
        function()
            --[[
              line: 159
              upvalues:
                v45 (copy, index: 1)
            ]]
            if v45.core ~= nil then
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v45.core)
            end
        end
    )
end

local v49 = {}

function v11.HoldChat(key, a51)
    --[[
      name: HoldChat
      line: 170
      upvalues:
        v49 (copy, index: 1)
        hideChat (copy, index: 2)
        restoreChat (copy, index: 3)
    ]]
    if a51 then
        v49[key] = true
        hideChat()

        return
    end

    v49[key] = nil

    if next(v49) == nil then
        restoreChat()
    end
end

local v52 = {}
local v53 = false
v11.FocusChanged = Signal.new()

local function topFocus()
    --[[
      name: topFocus
      line: 190
      upvalues:
        v52 (copy, index: 1)
    ]]
    return v52[#v52]
end

local function usable(a56)
    --[[
      name: usable
      line: 195
    ]]
    if typeof(a56) ~= "Instance" or not a56:IsA("GuiObject") or not a56:IsDescendantOf(game) or not a56.Selectable then
        return false
    end

    local v57
    v57 = a56

    while v57 and v57 ~= game do
        if v57:IsA("GuiObject") and not v57.Visible then
            return false
        end
        if v57:IsA("ScreenGui") and not v57.Enabled then
            return false
        end

        v57 = v57.Parent
    end

    return true
end

local function selectOwner(a59: boolean?)
    --[[
      name: selectOwner
      line: 210
      upvalues:
        UI (copy, index: 1)
        usable (copy, index: 2)
        guiService (copy, index: 3)
        v13 (ref,  index: 4)
        v12 (copy, index: 5)
        v52 (copy, index: 6)
    ]]
    local select

    if not UI.Gamepad then
        return
    end
    if a59 and usable(guiService.SelectedObject) then
        return
    end

    if v13 then
        local v61 = v12[v13]
        select = v61 and v61.select
    else
        local v62 = v52[#v52]
        select = v62 and v62.select
    end

    if not select then
        return
    end

    local success, result = pcall(select)

    if success and usable(result) then
        guiService.SelectedObject = result
    end
end

local v65 = false
local count = 0
local v67 = {}
local v68 = {}

local function characterContexts()
    --[[
      name: characterContexts
      line: 243
      upvalues:
        players (copy, index: 1)
    ]]
    local v70 = {}
    local playerModule = game:GetService("StarterPlayer"):FindFirstChild("PlayerModule")

    for _, instance in {players.LocalPlayer, playerModule} do
        local inputContexts = instance and instance:FindFirstChild("InputContexts")
        local characterContext = inputContexts and inputContexts:FindFirstChild("CharacterContext")

        if characterContext and characterContext:IsA("InputContext") then
            table.insert(v70, characterContext)
        end
    end

    return v70
end

local function setWalk(walk: boolean)
    --[[
      name: setWalk
      line: 255
      upvalues:
        v68 (copy, index: 1)
        characterContexts (copy, index: 2)
    ]]
    if walk then
        for v78 in v68 do
            if v78.Parent then
                v78.Enabled = true
            end
        end

        table.clear(v68)

        return
    end

    for _, instance in characterContexts() do
        if instance.Enabled then
            instance.Enabled = false
            v68[instance] = true
        end
    end
end

local function applyPadBlock(padMenu)
    --[[
      name: applyPadBlock
      line: 272
      upvalues:
        v65 (ref,  index: 1)
        Keybinds (copy, index: 2)
        setWalk (copy, index: 3)
        players (copy, index: 4)
    ]]
    if padMenu == v65 then
        return
    end

    v65 = padMenu
    Keybinds.SetPadBlocked(padMenu)
    setWalk(not padMenu)
    players.LocalPlayer:SetAttribute("PadMenu", padMenu)
end

local function refreshPadBlock()
    --[[
      name: refreshPadBlock
      line: 281
      upvalues:
        UI (copy, index: 1)
        v13 (ref,  index: 2)
        v52 (copy, index: 3)
        v53 (ref,  index: 4)
        count (ref,  index: 5)
        v65 (ref,  index: 6)
        Keybinds (copy, index: 7)
        characterContexts (copy, index: 8)
        v68 (copy, index: 9)
        players (copy, index: 10)
        v67 (copy, index: 11)
    ]]
    local v84 = UI.Gamepad and (v13 ~= nil or v52[#v52] ~= nil or v53)
    count += 1

    if not v84 then
        if not v65 then
            return
        end

        local v85 = count

        task.spawn(
            function()
                --[[
                  line: 292
                  upvalues:
                    v67 (copy, index: 1)
                    v85 (copy, index: 2)
                    count (ref,  index: 3)
                    v65 (ref,  index: 4)
                    Keybinds (copy, index: 5)
                    v68 (copy, index: 6)
                    players (copy, index: 7)
                ]]
                local timestamp = os.clock()

                while (v67[Enum.KeyCode.ButtonA] or v67[Enum.KeyCode.ButtonB]) and os.clock() - timestamp < 3 do
                    task.wait()
                end

                task.wait(0.05)

                if v85 == count then
                    if v65 == false then
                        return
                    end

                    v65 = false
                    Keybinds.SetPadBlocked(false)

                    for v87 in v68 do
                        if v87.Parent then
                            v87.Enabled = true
                        end
                    end

                    table.clear(v68)
                    players.LocalPlayer:SetAttribute("PadMenu", false)
                end
            end
        )

        return
    end

    if v65 == true then
        return
    end

    v65 = true
    Keybinds.SetPadBlocked(true)

    for _, instance in characterContexts() do
        if instance.Enabled then
            instance.Enabled = false
            v68[instance] = true
        end
    end

    players.LocalPlayer:SetAttribute("PadMenu", true)
end

function v11.PadBlocked()
    --[[
      name: PadBlocked
      line: 303
      upvalues:
        v65 (ref, index: 1)
    ]]
    return v65
end

local function endHudFocus(a91)
    --[[
      name: endHudFocus
      line: 307
      upvalues:
        v53 (ref,  index: 1)
        guiService (copy, index: 2)
        refreshPadBlock (copy, index: 3)
        v11 (copy, index: 4)
    ]]
    if not v53 then
        return
    end

    v53 = false

    if a91 then
        guiService.SelectedObject = nil
    end

    refreshPadBlock()
    v11.FocusChanged:Fire()
end

function v11.PushFocus(key, select, back)
    --[[
      name: PushFocus
      line: 321
      upvalues:
        v11 (copy, index: 1)
        v52 (copy, index: 2)
        v53 (ref,  index: 3)
        refreshPadBlock (copy, index: 4)
        v13 (ref,  index: 5)
        selectOwner (copy, index: 6)
    ]]
    v11.PopFocus(key, true)
    table.insert(v52, {key = key, select = select, back = back, at = os.clock()})

    if v53 then
        v53 = false
        refreshPadBlock()
        v11.FocusChanged:Fire()
    end

    if not v13 then
        selectOwner()
    end

    refreshPadBlock()
    v11.FocusChanged:Fire()
end

function v11.PopFocus(a95, a96)
    --[[
      name: PopFocus
      line: 331
      upvalues:
        v52 (copy, index: 1)
        v13 (ref,  index: 2)
        guiService (copy, index: 3)
        selectOwner (copy, index: 4)
        refreshPadBlock (copy, index: 5)
        v11 (copy, index: 6)
    ]]
    for v97, v98 in v52 do
        if v98.key == a95 then
            table.remove(v52, v97)

            if not a96 then
                if not v13 then
                    guiService.SelectedObject = nil
                    selectOwner()
                end

                refreshPadBlock()
                v11.FocusChanged:Fire()
            end

            return
        end
    end
end

function v11.HasFocus(a99)
    --[[
      name: HasFocus
      line: 347
      upvalues:
        v52 (copy, index: 1)
    ]]
    if a99 == nil then
        return v52[#v52] ~= nil
    end

    for _, v101 in v52 do
        if v101.key == a99 then
            return true
        end
    end

    return false
end

function v11.Reselect()
    --[[
      name: Reselect
      line: 359
      upvalues:
        v13 (ref,  index: 1)
        v52 (copy, index: 2)
        selectOwner (copy, index: 3)
    ]]
    if v13 or v52[#v52] then
        selectOwner(true)
    end
end

function v11.HudFocus(selectedObject: GuiObject?)
    --[[
      name: HudFocus
      line: 366
      upvalues:
        UI (copy, index: 1)
        v13 (ref,  index: 2)
        v52 (copy, index: 3)
        usable (copy, index: 4)
        v53 (ref,  index: 5)
        guiService (copy, index: 6)
        refreshPadBlock (copy, index: 7)
        v11 (copy, index: 8)
    ]]
    if not UI.Gamepad or v13 or v52[#v52] or not usable(selectedObject) then
        return false
    end

    v53 = true
    guiService.SelectedObject = selectedObject
    refreshPadBlock()
    v11.FocusChanged:Fire()

    return true
end

function v11.EndHudFocus()
    --[[
      name: EndHudFocus
      line: 376
      upvalues:
        v53 (ref,  index: 1)
        guiService (copy, index: 2)
        refreshPadBlock (copy, index: 3)
        v11 (copy, index: 4)
    ]]
    if not v53 then
        return
    end

    v53 = false
    guiService.SelectedObject = nil
    refreshPadBlock()
    v11.FocusChanged:Fire()
end

function v11.HudFocused()
    --[[
      name: HudFocused
      line: 379
      upvalues:
        v53 (ref, index: 1)
    ]]
    return v53
end

function v11.Register(key, value)
    --[[
      name: Register
      line: 383
      upvalues:
        v12 (copy, index: 1)
    ]]
    v12[key] = value
end

local v105 = nil

function v11.SetLoader(loader)
    --[[
      name: SetLoader
      line: 388
      upvalues:
        v105 (ref, index: 1)
    ]]
    v105 = loader
end

function v11.IsOpen(a107)
    --[[
      name: IsOpen
      line: 392
      upvalues:
        v13 (ref, index: 1)
    ]]
    if a107 == nil then
        return v13 ~= nil
    end

    return v13 == a107
end

function v11.Current()
    --[[
      name: Current
      line: 399
      upvalues:
        v13 (ref, index: 1)
    ]]
    return v13
end

local timestamp2 = -math.huge

function v11.RecentlyOpen(a109)
    --[[
      name: RecentlyOpen
      line: 405
      upvalues:
        v13 (ref, index: 1)
        timestamp2 (ref, index: 2)
    ]]
    return v13 ~= nil or os.clock() - timestamp2 < (a109 or 0.2)
end

function v11.Close(a110, a111)
    --[[
      name: Close
      line: 409
      upvalues:
        v13 (ref,  index: 1)
        v12 (copy, index: 2)
        timestamp2 (ref,  index: 3)
        v11 (copy, index: 4)
        setBlur (copy, index: 5)
        v14 (copy, index: 6)
        applyMouse (copy, index: 7)
        guiService (copy, index: 8)
        selectOwner (copy, index: 9)
        refreshPadBlock (copy, index: 10)
    ]]
    local v112 = a110 or v13

    if not v112 or v112 ~= v13 then
        return
    end

    local v113 = v12[v112]
    v13 = nil
    timestamp2 = os.clock()

    if v113 then
        local success, result = pcall(v113.close, a111)
        if not success then
            warn("[UI] menu " .. v112 .. " failed to close: " .. tostring(result))
        end
    end

    v11.HoldChat("menu", false)
    setBlur(false)
    v14.Menu = nil
    applyMouse()
    guiService.SelectedObject = nil
    selectOwner()
    refreshPadBlock()
    v11.Changed:Fire(nil)
end

function v11.Open(key, ...)
    --[[
      name: Open
      line: 436
      upvalues:
        v12 (copy, index: 1)
        v105 (ref,  index: 2)
        v13 (ref,  index: 3)
        v11 (copy, index: 4)
        v53 (ref,  index: 5)
        refreshPadBlock (copy, index: 6)
        guiService (copy, index: 7)
        setBlur (copy, index: 8)
        v14 (copy, index: 9)
        applyMouse (copy, index: 10)
        selectOwner (copy, index: 11)
    ]]
    local v117 = v12[key]

    if not v117 and v105 then
        v105(key)
        v117 = v12[key]
    end

    if not v117 then
        warn("[UI] unknown menu " .. key)
        return
    end

    if v13 == key then
        v117.open(...)
        return
    end

    v11.HoldChat("menu", true)

    if v13 then
        local v118 = v12[v13]
        v13 = nil

        if v118 then
            v118.close(true)
        end
    end

    v13 = key

    if v53 then
        v53 = false
        refreshPadBlock()
        v11.FocusChanged:Fire()
    end

    guiService.SelectedObject = nil
    v117.open(...)
    setBlur(v117.blur ~= false)
    v14.Menu = true
    applyMouse()
    selectOwner(true)
    refreshPadBlock()
    v11.Changed:Fire(key)
end

function v11.Toggle(a119, ...)
    --[[
      name: Toggle
      line: 471
      upvalues:
        v13 (ref,  index: 1)
        v11 (copy, index: 2)
    ]]
    if v13 == a119 then
        v11.Close(a119)
        return
    end

    v11.Open(a119, ...)
end

function v11.CloseAll(a120)
    --[[
      name: CloseAll
      line: 479
      upvalues:
        v13 (ref,  index: 1)
        v11 (copy, index: 2)
    ]]
    if v13 then
        v11.Close(v13, a120)
    end
end

function v11.Back()
    --[[
      name: Back
      line: 487
      upvalues:
        v13 (ref,  index: 1)
        v12 (copy, index: 2)
        v11 (copy, index: 3)
        v52 (copy, index: 4)
        v53 (ref,  index: 5)
        guiService (copy, index: 6)
        refreshPadBlock (copy, index: 7)
    ]]
    if v13 then
        local v121 = v12[v13]

        if v121 and v121.back then
            local success, result = pcall(v121.back)

            if success and result then
                return true
            end
        end

        v11.Close(v13)

        return true
    elseif const v124 = v52[#v52] then
        if v124.back then
            local success, result = pcall(v124.back)
            return success and (result == true)
        end

        return false
    end

    if not v53 then
        return false
    end

    if v53 then
        v53 = false
        guiService.SelectedObject = nil
        refreshPadBlock()
        v11.FocusChanged:Fire()
    end

    return true
end

Keybinds.OnInput(
    "Began",
    function(a127)
        --[[
          line: 514
          upvalues:
            v67 (copy, index: 1)
            v11 (copy, index: 2)
        ]]
        local keyCode = a127.KeyCode

        if keyCode == Enum.KeyCode.ButtonA or keyCode == Enum.KeyCode.ButtonB then
            v67[keyCode] = true
        end

        if keyCode == Enum.KeyCode.ButtonB then
            v11.Back()
        end
    end
)

Keybinds.OnInput(
    "Ended",
    function(a129)
        --[[
          line: 523
          upvalues:
            v67 (copy, index: 1)
        ]]
        local keyCode = a129.KeyCode

        if keyCode == Enum.KeyCode.ButtonA or keyCode == Enum.KeyCode.ButtonB then
            v67[keyCode] = nil
        end
    end
)

Keybinds.OnInput(
    "Changed",
    function(a131)
        --[[
          line: 530
          upvalues:
            v53 (ref,  index: 1)
            guiService (copy, index: 2)
            refreshPadBlock (copy, index: 3)
            v11 (copy, index: 4)
        ]]
        if v53 and a131.KeyCode == Enum.KeyCode.Thumbstick1 and 0.6 < a131.Position.Magnitude and v53 then
            v53 = false
            guiService.SelectedObject = nil
            refreshPadBlock()
            v11.FocusChanged:Fire()
        end
    end
)

guiService:GetPropertyChangedSignal("SelectedObject"):Connect(
    function()
        --[[
          line: 536
          upvalues:
            guiService (copy, index: 1)
            v53 (ref,  index: 2)
            refreshPadBlock (copy, index: 3)
            v11 (copy, index: 4)
            UI (copy, index: 5)
            v13 (ref,  index: 6)
            v52 (copy, index: 7)
        ]]
        if guiService.SelectedObject ~= nil then
            return
        end

        if not v53 then
            if UI.Gamepad and (v13 or v52[#v52]) then
                task.defer(v11.Reselect)
            end

            return
        end

        if not v53 then
            return
        end

        v53 = false
        refreshPadBlock()
        v11.FocusChanged:Fire()
    end
)

local v132 = 0

task.spawn(
    function()
        --[[
          line: 550
          upvalues:
            v53 (ref,  index: 1)
            usable (copy, index: 2)
            guiService (copy, index: 3)
            players (copy, index: 4)
            refreshPadBlock (copy, index: 5)
            v11 (copy, index: 6)
            v13 (ref,  index: 7)
            v52 (copy, index: 8)
            v132 (ref,  index: 9)
        ]]
        while true do
            local v133
            local v134, v135 = false, false
            task.wait(0.5)

            if v53 then
                if usable(guiService.SelectedObject) then
                    if players.LocalPlayer:GetAttribute("State") == "Match" then
                        v134 = true
                    end
                else
                    v134 = true
                end
            end

            if v134 and v53 then
                v53 = false
                guiService.SelectedObject = nil
                refreshPadBlock()
                v11.FocusChanged:Fire()
            end

            if v13 then
                v133 = nil
            else
                v133 = v52[#v52]
            end

            if v133 then
                local success, result = pcall(v133.select)

                if success then
                    if usable(result) then
                        v132 = 0
                    else
                        v135 = true
                    end
                else
                    v135 = true
                end
            else
                v132 = 0
            end

            if v135 then
                v132 += 1

                if 4 <= v132 then
                    v132 = 0
                    v11.PopFocus(v133.key)
                end
            end
        end
    end
)

UI.GamepadChanged:Connect(
    function(a138)
        --[[
          line: 575
          upvalues:
            selectOwner (copy, index: 1)
            v53 (ref,  index: 2)
            guiService (copy, index: 3)
            refreshPadBlock (copy, index: 4)
        ]]
        if a138 then
            selectOwner(true)
        else
            v53 = false
            guiService.SelectedObject = nil
        end

        refreshPadBlock()
    end
)

function v11.Reasons()
    --[[
      name: Reasons
      line: 586
      upvalues:
        v14 (copy, index: 1)
    ]]
    local v139 = {}

    for v140 in v14 do
        table.insert(v139, v140)
    end

    table.sort(v139)

    return v139
end

runService:BindToRenderStep(
    "TribesUIMouse",
    Enum.RenderPriority.Camera.Value + 5,
    function()
        --[[
          line: 597
          upvalues:
            v14 (copy, index: 1)
            v13 (ref,  index: 2)
            applyMouse (copy, index: 3)
            v15 (ref,  index: 4)
            v11 (copy, index: 5)
            userInputService (copy, index: 6)
        ]]
        if v14.Menu and v13 == nil then
            v14.Menu = nil
            applyMouse()
        end

        if v15 then
            if not v11.Camera() then
                userInputService.MouseBehavior = Enum.MouseBehavior.Default
            end

            userInputService.MouseIconEnabled = true
        end
    end
)

return v11