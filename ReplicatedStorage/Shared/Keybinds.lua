local players = game:GetService("Players")
local runService = game:GetService("RunService")
local Signal = require(script.Parent:WaitForChild("Signal"))
local v4 = {PREFIX = "kb_", PAD_PREFIX = "gp_", MAX = 2}

local function A(id, label, keys, group, a10)
    --[[
      name: A
      line: 39
      upvalues:
        v4 (copy, index: 1)
    ]]
    return {id = id, label = label, keys = keys, max = a10 or v4.MAX, group = group}
end

local actions = {
    {id = "Jump", label = "JUMP", group = "move", keys = {"Space"}, max = v4.MAX},
    {id = "Slide", label = "SLIDE", group = "move", keys = {"C", "LeftControl"}, max = v4.MAX},
    {id = "Attack", label = "ATTACK", group = "combat", keys = {"MouseButton1"}, max = v4.MAX},
    {id = "Aim", label = "AIM / BLOCK", group = "combat", keys = {"MouseButton2"}, max = v4.MAX},
    {id = "Reload", label = "RELOAD", group = "combat", keys = {"R"}, max = v4.MAX},
    {id = "Ping", label = "PING", group = "combat", keys = {"MouseButton3", "G"}, max = v4.MAX},
    {id = "Item1", label = "ITEM 1", max = 1, group = "items", keys = {"One"}},
    {id = "Item2", label = "ITEM 2", max = 1, group = "items", keys = {"Two"}},
    {id = "Item3", label = "ITEM 3", max = 1, group = "items", keys = {"Three"}},
    {id = "Item4", label = "ITEM 4", max = 1, group = "items", keys = {"Four"}},
    {id = "Item5", label = "ITEM 5", max = 1, group = "items", keys = {"Five"}},
    {id = "Item6", label = "ITEM 6", max = 1, group = "items", keys = {"Six"}},
    {id = "LastItem", label = "LAST ITEM", group = "items", keys = {"Q"}, max = v4.MAX},
    {id = "NextLoadout", label = "NEXT LOADOUT", group = "items", keys = {"B"}, max = v4.MAX},
    {id = "View", label = "FIRST / THIRD PERSON", group = "camera", keys = {"V"}, max = v4.MAX},
    {id = "Shoulder", label = "SWITCH SHOULDER", group = "camera", keys = {"X"}, max = v4.MAX},
    {id = "FreeCursor", label = "FREE CURSOR", group = "camera", keys = {"LeftAlt", "RightAlt"}, max = v4.MAX},
    {id = "CustomMenu", label = "CUSTOM MATCH MENU", group = "menus", keys = {"H"}, max = v4.MAX},
    {id = "Scoreboard", label = "SCOREBOARD (HOLD)", group = "menus", keys = {"Tab"}, max = v4.MAX}
}
v4.ACTIONS = actions
local v12 = {}

for _, action in v4.ACTIONS do
    v12[action.id] = action
end

function v4.Action(key)
    --[[
      name: Action
      line: 76
      upvalues:
        v12 (copy, index: 1)
    ]]
    return v12[key]
end

local v16 = {MouseButton1 = true, MouseButton2 = true, MouseButton3 = true}
local reserved = {
    Escape = "Esc opens the Roblox menu",
    Slash = "/ opens chat",
    W = "W A S D move you",
    A = "W A S D move you",
    S = "W A S D move you",
    D = "W A S D move you",
    Up = "The arrow keys move you",
    Down = "The arrow keys move you",
    Left = "The arrow keys turn the camera",
    Right = "The arrow keys turn the camera",
    M = "M opens Settings",
    E = "E interacts with things",
    F9 = "F9 opens Roblox's console",
    F10 = "Reserved by Roblox",
    F11 = "Reserved by Roblox",
    F12 = "Reserved by Roblox",
    LeftSuper = "Reserved by your system",
    RightSuper = "Reserved by your system",
    Print = "Reserved by your system",
    Menu = "Reserved by your system"
}
v4.RESERVED = reserved
local v18 = {}

for _, part in string.split("B C F G H I J K L N O P Q R T U V X Y Z", " ") do
    v18[part] = part
end

for v21, v22 in {"Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"} do
    v18[v22] = tostring(v21 - 1)
    v18["Keypad" .. v22] = "NUM " .. tostring(v21 - 1)
end

v18["F" .. 1] = "F" .. 1
v18["F" .. 2] = "F" .. 2
v18["F" .. 3] = "F" .. 3
v18["F" .. 4] = "F" .. 4
v18["F" .. 5] = "F" .. 5
v18["F" .. 6] = "F" .. 6
v18["F" .. 7] = "F" .. 7
v18["F" .. 8] = "F" .. 8

for v23, v24 in {
    Space = "SPACE",
    Tab = "TAB",
    CapsLock = "CAPS",
    Return = "ENTER",
    Backspace = "BKSP",
    LeftShift = "SHIFT",
    RightShift = "R SHIFT",
    LeftControl = "CTRL",
    RightControl = "R CTRL",
    LeftAlt = "ALT",
    RightAlt = "R ALT",
    Insert = "INS",
    Delete = "DEL",
    Home = "HOME",
    End = "END",
    PageUp = "PG UP",
    PageDown = "PG DN",
    Backquote = "`",
    Minus = "-",
    Equals = "=",
    LeftBracket = "[",
    RightBracket = "]",
    BackSlash = "\\",
    Semicolon = ";",
    Quote = "'",
    Comma = ",",
    Period = ".",
    KeypadPeriod = "NUM .",
    KeypadDivide = "NUM /",
    KeypadMultiply = "NUM *",
    KeypadMinus = "NUM -",
    KeypadPlus = "NUM +",
    KeypadEnter = "NUM ENTER",
    MouseButton1 = "LEFT CLICK",
    MouseButton2 = "RIGHT CLICK",
    MouseButton3 = "MIDDLE CLICK"
} do
    v18[v23] = v24
end

function v4.Bindable(key)
    --[[
      name: Bindable
      line: 131
      upvalues:
        v18 (copy, index: 1)
        reserved (copy, index: 2)
    ]]
    if v18[key] then
        return true, nil
    end

    return false, reserved[key] or "That key can't be used"
end

function v4.Display(key)
    --[[
      name: Display
      line: 139
      upvalues:
        v18 (copy, index: 1)
    ]]
    if key then
        return v18[key] or key
    end

    return "—"
end

function v4.CapFor(key)
    --[[
      name: CapFor
      line: 144
      upvalues:
        v18 (copy, index: 1)
    ]]
    if not key then
        return nil
    end
    if key == "MouseButton1" then
        return "M1"
    end
    if key == "MouseButton2" then
        return "M2"
    end
    if key == "MouseButton3" then
        return "M3"
    end

    return v18[key] or key
end

function v4.Parse(key, text: string)
    --[[
      name: Parse
      line: 161
      upvalues:
        v12 (copy, index: 1)
        v18 (copy, index: 2)
    ]]
    local v30 = v12[key]

    if not v30 or type(text) ~= "string" or 64 < #text then
        return nil
    end
    if text == "-" then
        return {}
    end
    if text == "" then
        return nil
    end

    local parts = string.split(text, ",")
    local partCount = #parts

    if v30.max < partCount then
        return nil
    end

    local v33 = {}

    for _, part in parts do
        if #part == 0 then
            return nil
        end
        if 16 < #part then
            return nil
        end
        if not v18[part] or v33[part] then
            return nil
        end

        v33[part] = true
    end

    return parts
end

function v4.Encode(parts)
    --[[
      name: Encode
      line: 186
    ]]
    if #parts == 0 then
        return "-"
    end

    return (table.concat(parts, ","))
end

function v4.ValidSetting(text: string, a38)
    --[[
      name: ValidSetting
      line: 191
      upvalues:
        v4 (copy, index: 1)
        v12 (copy, index: 2)
    ]]
    if type(text) ~= "string" then
        return false
    end

    local substring = string.sub(text, 1, #v4.PAD_PREFIX)

    if substring == v4.PAD_PREFIX then
        local substring2 = string.sub(text, #v4.PAD_PREFIX + 1)

        if v4.PadAction(substring2) then
            return a38 == "" or v4.PadParse(substring2, a38) ~= nil
        end

        return false
    end

    local substring3 = string.sub(text, 1, #v4.PREFIX)

    if substring3 ~= v4.PREFIX then
        return false
    end

    local substring4 = string.sub(text, #v4.PREFIX + 1)

    if v12[substring4] then
        return a38 == "" or v4.Parse(substring4, a38) ~= nil
    end

    return false
end

function v4.IsKey(text: string)
    --[[
      name: IsKey
      line: 213
      upvalues:
        v4 (copy, index: 1)
    ]]
    local v44 = false

    if type(text) == "string" then
        v44 = true
        local substring = string.sub(text, 1, #v4.PREFIX)

        if substring ~= v4.PREFIX then
            local substring2 = string.sub(text, 1, #v4.PAD_PREFIX)
            v44 = substring2 == v4.PAD_PREFIX
        end
    end

    return v44
end

local function sameList(a48, a49)
    --[[
      name: sameList
      line: 218
    ]]
    if #a48 ~= #a49 then
        return false
    end

    for v50, v51 in a48 do
        if a49[v50] ~= v51 then
            return false
        end
    end

    return true
end

local v52 = {}
local v53 = {}
v4.Changed = Signal.new()

local function reindex()
    --[[
      name: reindex
      line: 238
      upvalues:
        v53 (copy, index: 1)
        v4 (copy, index: 2)
        v52 (copy, index: 3)
    ]]
    table.clear(v53)

    for _, action in v4.ACTIONS do
        for _, v58 in v52[action.id] do
            v53[v58] = action.id
        end
    end
end

local function resetAll()
    --[[
      name: resetAll
      line: 247
      upvalues:
        v4 (copy, index: 1)
        v52 (copy, index: 2)
        reindex (copy, index: 3)
    ]]
    for _, action in v4.ACTIONS do
        v52[action.id] = table.clone(action.keys)
    end

    reindex()
end

resetAll()

function v4.Get(key)
    --[[
      name: Get
      line: 255
      upvalues:
        v52 (copy, index: 1)
    ]]
    return table.clone((v52[key] or {}))
end

function v4.IsDefault(key)
    --[[
      name: IsDefault
      line: 259
      upvalues:
        v12 (copy, index: 1)
        v52 (copy, index: 2)
    ]]
    local v64 = v12[key]
    if v64 == nil then
        return false
    end

    local v65 = v52[key]
    local keys = v64.keys

    if #v65 ~= #keys then
        return false
    end

    for keyKey, v68 in v65 do
        if keys[keyKey] ~= v68 then
            return false
        end
    end

    return true
end

function v4.AllDefault()
    --[[
      name: AllDefault
      line: 264
      upvalues:
        v4 (copy, index: 1)
        v52 (copy, index: 2)
    ]]
    for _, action in v4.ACTIONS do
        local v71
        local v72 = v52[action.id]
        local keys = action.keys

        if #v72 == #keys then
            v71 = true

            for keyKey, v75 in v72 do
                if keys[keyKey] ~= v75 then
                    v71 = false
                    break
                end
            end
        else
            v71 = false
        end

        if not v71 then
            return false
        end
    end

    return true
end

function v4.OwnerOf(key)
    --[[
      name: OwnerOf
      line: 273
      upvalues:
        v53 (copy, index: 1)
    ]]
    return v53[key]
end

function v4.SettingValue(key)
    --[[
      name: SettingValue
      line: 278
      upvalues:
        v12 (copy, index: 1)
        v52 (copy, index: 2)
        v4 (copy, index: 3)
    ]]
    if const v78 = v12[key] then
        local v79
        local v80 = v52[key]
        local keys = v78.keys

        if #v80 == #keys then
            v79 = true

            for keyKey, v83 in v80 do
                if keys[keyKey] ~= v83 then
                    v79 = false
                    break
                end
            end
        else
            v79 = false
        end

        if not v79 then
            return v4.Encode(v52[key])
        end
    end

    return ""
end

function v4.Load(a84)
    --[[
      name: Load
      line: 289
      upvalues:
        v52 (copy, index: 1)
        v4 (copy, index: 2)
        reindex (copy, index: 3)
    ]]
    local v85

    if type(a84) ~= "table" then
        v85 = {}
    else
        v85 = a84
    end

    local v86 = {}

    for v87, v88 in v52 do
        v86[v87] = v88
    end

    local v89 = {}
    local v90 = {}

    for _, action in v4.ACTIONS do
        if const v93 = v4.Parse(action.id, v85[v4.PREFIX .. action.id]) then
            local v94 = {}

            for _, v96 in v93 do
                if not v89[v96] then
                    v89[v96] = true
                    table.insert(v94, v96)
                end
            end

            v52[action.id] = v94
            v90[action.id] = true
        end
    end

    for _, action in v4.ACTIONS do
        if not v90[action.id] then
            local v99 = {}

            for _, key in action.keys do
                if not v89[key] then
                    v89[key] = true
                    table.insert(v99, key)
                end
            end

            v52[action.id] = v99
        end
    end

    reindex()
    local v102 = {}

    for _, action in v4.ACTIONS do
        local v105
        local v106 = v86[action.id] or {}
        local v107 = v52[action.id]

        if #v106 == #v107 then
            v105 = true

            for v108, v109 in v106 do
                if v107[v108] ~= v109 then
                    v105 = false
                    break
                end
            end
        else
            v105 = false
        end

        if not v105 then
            table.insert(v102, action.id)
        end
    end

    if 0 < #v102 then
        v4.Changed:Fire(v102)
    end

    v4.PadLoad(v85)
end

function v4.Assign(key, a111: number, target)
    --[[
      name: Assign
      line: 339
      upvalues:
        v12 (copy, index: 1)
        v18 (copy, index: 2)
        v52 (copy, index: 3)
        v53 (copy, index: 4)
        reindex (copy, index: 5)
        v4 (copy, index: 6)
    ]]
    local v113 = v12[key]

    if not v113 or not v18[target] then
        return {}, nil, nil
    end

    local clampedValue = math.clamp(a111, 1, (math.min(v113.max, #v52[key] + 1)))
    local targets = v52[key]
    local target2 = targets[clampedValue]

    if target2 == target then
        return {}, nil, nil
    end

    local v117 = {key}
    local v118 = v53[target]
    local values = nil

    if v118 ~= key then
        if v118 then
            local v120 = v52[v118]
            local index = table.find(v120, target)

            if not target2 or table.find(v120, target2) then
                table.remove(v120, index)
            else
                v120[index] = target2
            end

            table.insert(v117, v118)
            values = table.clone(v120)
        end

        targets[clampedValue] = target
    else
        if target2 == nil then
            return {}, nil, nil
        end

        targets[table.find(targets, target)] = target2
        targets[clampedValue] = target
    end

    reindex()
    v4.Changed:Fire(v117)
    local v122 = v118 ~= key and v118 or nil

    return v117, v122, values
end

function v4.Clear(key, index)
    --[[
      name: Clear
      line: 381
      upvalues:
        v52 (copy, index: 1)
        reindex (copy, index: 2)
        v4 (copy, index: 3)
    ]]
    local v125 = v52[key]

    if not v125 or not v125[index] then
        return
    end

    table.remove(v125, index)
    reindex()
    v4.Changed:Fire({key})
end

function v4.ResetAll()
    --[[
      name: ResetAll
      line: 392
      upvalues:
        v4 (copy, index: 1)
        v52 (copy, index: 2)
        resetAll (copy, index: 3)
    ]]
    local v126 = {}

    for _, action in v4.ACTIONS do
        local v129
        local v130 = v52[action.id]
        local keys = action.keys

        if #v130 == #keys then
            v129 = true

            for keyKey, v133 in v130 do
                if keys[keyKey] ~= v133 then
                    v129 = false
                    break
                end
            end
        else
            v129 = false
        end

        if not v129 then
            table.insert(v126, action.id)
        end
    end

    resetAll()

    if 0 < #v126 then
        v4.Changed:Fire(v126)
    end

    return v126
end

function v4.ActionOf(a134)
    --[[
      name: ActionOf
      line: 407
      upvalues:
        v53 (copy, index: 1)
    ]]
    local userInputType = a134.UserInputType

    if userInputType == Enum.UserInputType.Keyboard then
        return v53[a134.KeyCode.Name]
    end
    if userInputType ~= Enum.UserInputType.MouseButton1
        and userInputType ~= Enum.UserInputType.MouseButton2
        and userInputType ~= Enum.UserInputType.MouseButton3
    then
        return nil
    end

    return v53[userInputType.Name]
end

function v4.Inputs(key)
    --[[
      name: Inputs
      line: 418
      upvalues:
        v52 (copy, index: 1)
        v16 (copy, index: 2)
    ]]
    local v137 = {}
    local v138 = v52[key] or {}

    for _, v140 in v138 do
        if v16[v140] then
            table.insert(v137, Enum.UserInputType[v140])
        else
            local success, result = pcall(
                function()
                    --[[
                      line: 424
                      upvalues:
                        v140 (copy, index: 1)
                    ]]
                    return Enum.KeyCode[v140]
                end
            )

            if success and result then
                table.insert(v137, result)
            end
        end
    end

    return v137
end

function v4.CapText(key)
    --[[
      name: CapText
      line: 436
      upvalues:
        v52 (copy, index: 1)
        v4 (copy, index: 2)
    ]]
    local v144 = v52[key]
    return v4.CapFor((v144 and v144[1]))
end

function v4.NameOf(a145)
    --[[
      name: NameOf
      line: 442
    ]]
    local userInputType = a145.UserInputType

    if userInputType == Enum.UserInputType.Keyboard then
        return a145.KeyCode.Name
    end
    if userInputType ~= Enum.UserInputType.MouseButton1
        and userInputType ~= Enum.UserInputType.MouseButton2
        and userInputType ~= Enum.UserInputType.MouseButton3
    then
        return nil
    end

    return userInputType.Name
end

local function P(id: string, label: string, desc: string, buttons, text: string, group: string, a154: number?)
    --[[
      name: P
      line: 479
    ]]
    local contexts = {}

    for _, part in string.split(text, " ") do
        contexts[part] = true
    end

    return {id = id, label = label, desc = desc, buttons = buttons, max = a154 or 1, contexts = contexts, group = group}
end

local buttons = {"ButtonL1", "ButtonB"}
local padActions = {
    P("Jump", "JUMP", "In the lobby and in matches", {"ButtonA"}, "lobby training match", "move"),
    P("Slide", "SLIDE", "While running", {"ButtonB"}, "lobby training match", "move"),
    P("Attack", "ATTACK", "Swing, fire, throw, use", {"ButtonR2"}, "training match", "combat"),
    P("Aim", "AIM / BLOCK", "Aim, zoom, block, heavy attack, lunge", {"ButtonL2"}, "training match", "combat"),
    P("Reload", "RELOAD", "Reload your weapon", {"ButtonX"}, "training match", "combat"),
    P("Ping", "PING", "Mark a spot for your team", {"ButtonL3"}, "match spectate", "combat"),
    P("NextItem", "NEXT ITEM", "The next hotbar slot", {"ButtonR1"}, "training match", "items"),
    P("PrevItem", "PREVIOUS ITEM", "The previous hotbar slot", {"ButtonL1"}, "training match", "items"),
    P("LastItem", "LAST ITEM", "Swap back to your last item", {"ButtonY"}, "training match", "items"),
    P("NextLoadout", "NEXT LOADOUT", "During the round countdown", {"DPadRight"}, "match", "items"),
    P("PrevLoadout", "PREVIOUS LOADOUT", "During the round countdown", {"DPadLeft"}, "match", "items"),
    P("View", "FIRST / THIRD PERSON", "Switch the camera view", {"DPadUp"}, "training match", "camera"),
    P("Shoulder", "SWITCH SHOULDER", "Look over the other shoulder", {"ButtonR3"}, "training match", "camera"),
    P("Scoreboard", "SCOREBOARD (HOLD)", "In a match", {"DPadDown"}, "match spectate", "menus"),
    P("SpectateNext", "SPECTATE NEXT", "While you're out of the round", {"ButtonR1", "ButtonA"}, "spectate", "spectate", 2),
    (P("SpectatePrev", "SPECTATE PREVIOUS", "While you're out of the round", buttons, "spectate", "spectate", 2))
}
local buttons2 = {"DPadDown"}
padActions[17], padActions[18] = P("Play", "PLAY / CANCEL", "Join or leave the queue in the lobby", {"ButtonY"}, "lobby", "menus"), (P("CustomMenu", "CUSTOM MATCH MENU", "In a custom match server's lobby", buttons2, "lobby", "menus"))
v4.PAD_ACTIONS = padActions
local v161 = {}

for _, padAction in v4.PAD_ACTIONS do
    v161[padAction.id] = padAction
end

function v4.PadAction(key)
    --[[
      name: PadAction
      line: 513
      upvalues:
        v161 (copy, index: 1)
    ]]
    return v161[key]
end

local padAllowed = {ButtonA = "A", ButtonB = "B", ButtonX = "X", ButtonY = "Y", ButtonL1 = "LB", ButtonR1 = "RB", ButtonL2 = "LT", ButtonR2 = "RT", ButtonL3 = "LS", ButtonR3 = "RS", DPadUp = "D-PAD UP", DPadDown = "D-PAD DOWN", DPadLeft = "D-PAD LEFT", DPadRight = "D-PAD RIGHT"}
v4.PAD_ALLOWED = padAllowed
local padReserved = {ButtonSelect = "That button opens Settings", ButtonStart = "That button opens Roblox's menu"}
v4.PAD_RESERVED = padReserved

local function isPadType(userInputType)
    --[[
      name: isPadType
      line: 531
    ]]
    return string.sub(userInputType.Name, 1, 7) == "Gamepad"
end

function v4.PadBindable(key)
    --[[
      name: PadBindable
      line: 536
      upvalues:
        padAllowed (copy, index: 1)
        padReserved (copy, index: 2)
    ]]
    if padAllowed[key] then
        return true, nil
    end

    return false, padReserved[key] or "That button can't be used"
end

function v4.PadDisplay(key)
    --[[
      name: PadDisplay
      line: 544
      upvalues:
        padAllowed (copy, index: 1)
    ]]
    if key then
        return padAllowed[key] or key
    end

    return "—"
end

function v4.PadParse(key, text: string)
    --[[
      name: PadParse
      line: 549
      upvalues:
        v161 (copy, index: 1)
        padAllowed (copy, index: 2)
    ]]
    local v173 = v161[key]

    if not v173 or type(text) ~= "string" or 64 < #text then
        return nil
    end
    if text == "-" then
        return {}
    end
    if text == "" then
        return nil
    end

    local parts = string.split(text, ",")
    local partCount = #parts

    if v173.max < partCount then
        return nil
    end

    local v176 = {}

    for _, part in parts do
        if #part == 0 then
            return nil
        end
        if 16 < #part then
            return nil
        end
        if not padAllowed[part] or v176[part] then
            return nil
        end

        v176[part] = true
    end

    return parts
end

local function overlap(a180, a181)
    --[[
      name: overlap
      line: 575
    ]]
    for contextKey in a180.contexts do
        if a181.contexts[contextKey] then
            return true
        end
    end

    return false
end

v4.PadOverlap = function(key, key2)
    --[[
      line: 583
      upvalues:
        v161 (copy, index: 1)
    ]]
    local v185 = v161[key]
    local v186 = v161[key2]

    if v185 == nil then
        return false
    end
    if v186 == nil then
        return false
    end

    for contextKey in v185.contexts do
        if v186.contexts[contextKey] then
            return true
        end
    end

    return false
end

local v188 = {}
local v189 = {}
local v190 = false
v4.PadChanged = Signal.new()

local function padReindex()
    --[[
      name: padReindex
      line: 594
      upvalues:
        v189 (copy, index: 1)
        v4 (copy, index: 2)
        v188 (copy, index: 3)
    ]]
    table.clear(v189)

    for _, padAction in v4.PAD_ACTIONS do
        for _, v195 in v188[padAction.id] do
            v189[v195] = v189[v195] or {}
            table.insert(v189[v195], padAction.id)
        end
    end
end

local function padResetAll()
    --[[
      name: padResetAll
      line: 603
      upvalues:
        v4 (copy, index: 1)
        v188 (copy, index: 2)
        padReindex (copy, index: 3)
    ]]
    for _, padAction in v4.PAD_ACTIONS do
        v188[padAction.id] = table.clone(padAction.buttons)
    end

    padReindex()
end

padResetAll()

local function padTaken(padAction, target, a202: nil)
    --[[
      name: padTaken
      line: 612
      upvalues:
        v189 (copy, index: 1)
        v161 (copy, index: 2)
    ]]
    local v203 = v189[target] or {}

    for _, v205 in v203 do
        if v205 ~= padAction.id then
            local v206

            if v205 == a202 then
                continue
            end

            local v207 = v161[v205]
            v206 = false

            for contextKey in padAction.contexts do
                if v207.contexts[contextKey] then
                    v206 = true
                    break
                end
            end

            if not v206 then
                continue
            end

            return v205
        end
    end

    return nil
end

function v4.PadGet(key)
    --[[
      name: PadGet
      line: 621
      upvalues:
        v188 (copy, index: 1)
    ]]
    return table.clone((v188[key] or {}))
end

function v4.PadCode(key)
    --[[
      name: PadCode
      line: 625
      upvalues:
        v188 (copy, index: 1)
    ]]
    local v211 = v188[key]
    local v212 = v211 and v211[1]
    if not v212 then
        return nil
    end

    local success, result = pcall(
        function()
            --[[
              line: 631
              upvalues:
                v212 (copy, index: 1)
            ]]
            return Enum.KeyCode[v212]
        end
    )
    if success then
        return result
    end

    return nil
end

function v4.PadInputs(key)
    --[[
      name: PadInputs
      line: 637
      upvalues:
        v188 (copy, index: 1)
    ]]
    local v216 = {}
    local v217 = v188[key] or {}

    for _, v219 in v217 do
        local success, result = pcall(
            function()
                --[[
                  line: 640
                  upvalues:
                    v219 (copy, index: 1)
                ]]
                return Enum.KeyCode[v219]
            end
        )

        if success and result then
            table.insert(v216, result)
        end
    end

    return v216
end

function v4.PadIsDefault(key)
    --[[
      name: PadIsDefault
      line: 649
      upvalues:
        v161 (copy, index: 1)
        v188 (copy, index: 2)
    ]]
    local v223 = v161[key]
    if v223 == nil then
        return false
    end

    local v224 = v188[key]
    local buttons = v223.buttons

    if #v224 ~= #buttons then
        return false
    end

    for buttonKey, v227 in v224 do
        if buttons[buttonKey] ~= v227 then
            return false
        end
    end

    return true
end

function v4.PadAllDefault()
    --[[
      name: PadAllDefault
      line: 653
      upvalues:
        v4 (copy, index: 1)
        v188 (copy, index: 2)
    ]]
    for _, padAction in v4.PAD_ACTIONS do
        local v230
        local v231 = v188[padAction.id]
        local buttons = padAction.buttons

        if #v231 == #buttons then
            v230 = true

            for buttonKey, v234 in v231 do
                if buttons[buttonKey] ~= v234 then
                    v230 = false
                    break
                end
            end
        else
            v230 = false
        end

        if not v230 then
            return false
        end
    end

    return true
end

function v4.PadSettingValue(key)
    --[[
      name: PadSettingValue
      line: 662
      upvalues:
        v161 (copy, index: 1)
        v188 (copy, index: 2)
        v4 (copy, index: 3)
    ]]
    if const v236 = v161[key] then
        local v237
        local v238 = v188[key]
        local buttons = v236.buttons

        if #v238 == #buttons then
            v237 = true

            for buttonKey, v241 in v238 do
                if buttons[buttonKey] ~= v241 then
                    v237 = false
                    break
                end
            end
        else
            v237 = false
        end

        if not v237 then
            return v4.Encode(v188[key])
        end
    end

    return ""
end

function v4.SettingValueFor(text: string)
    --[[
      name: SettingValueFor
      line: 670
      upvalues:
        v4 (copy, index: 1)
    ]]
    local substring = string.sub(text, 1, #v4.PAD_PREFIX)

    if substring ~= v4.PAD_PREFIX then
        return v4.SettingValue((string.sub(text, #v4.PREFIX + 1)))
    end

    return v4.PadSettingValue((string.sub(text, #v4.PAD_PREFIX + 1)))
end

local v244 = {}

function v4.PadActionsOf(a245)
    --[[
      name: PadActionsOf
      line: 680
      upvalues:
        v244 (copy, index: 1)
        v189 (copy, index: 2)
        isPadType (copy, index: 3)
    ]]
    if not isPadType(a245.UserInputType) then
        return v244
    end

    return v189[a245.KeyCode.Name] or v244
end

function v4.IsPad(a246, target)
    --[[
      name: IsPad
      line: 686
      upvalues:
        v4 (copy, index: 1)
    ]]
    return table.find(v4.PadActionsOf(a246), target) ~= nil
end

function v4.PadUsedIn(a248, contextKey)
    --[[
      name: PadUsedIn
      line: 690
      upvalues:
        v4 (copy, index: 1)
        v161 (copy, index: 2)
    ]]
    for _, v251 in v4.PadActionsOf(a248) do
        if v161[v251].contexts[contextKey] then
            return true
        end
    end

    return false
end

function v4.PadBlocked()
    --[[
      name: PadBlocked
      line: 699
      upvalues:
        v190 (ref, index: 1)
    ]]
    return v190
end

function v4.PadLoad(a252)
    --[[
      name: PadLoad
      line: 705
      upvalues:
        v188 (copy, index: 1)
        v161 (copy, index: 2)
        v4 (copy, index: 3)
        padReindex (copy, index: 4)
    ]]
    local v253

    if type(a252) ~= "table" then
        v253 = {}
    else
        v253 = a252
    end

    local v254 = {}

    for v255, v256 in v188 do
        v254[v255] = v256
    end

    local v257 = {}

    local function keep(padAction, a260)
        --[[
          name: keep
          line: 712
          upvalues:
            v257 (copy, index: 1)
            v161 (copy, index: 2)
        ]]
        local v261 = {}

        for _, v263 in a260 do
            local v264 = true
            local v265 = v257[v263] or {}

            for _, v267 in v265 do
                local v268
                local v269 = v161[v267]
                v268 = false

                for contextKey in padAction.contexts do
                    if v269.contexts[contextKey] then
                        v268 = true
                        break
                    end
                end

                if v268 then
                    v264 = false
                    break
                end
            end

            if v264 then
                v257[v263] = v257[v263] or {}
                table.insert(v257[v263], padAction.id)
                table.insert(v261, v263)
            end
        end

        return v261
    end

    local v271 = {}

    for _, padAction in v4.PAD_ACTIONS do
        if const v274 = v4.PadParse(padAction.id, v253[v4.PAD_PREFIX .. padAction.id]) then
            v188[padAction.id] = keep(padAction, v274)
            v271[padAction.id] = true
        end
    end

    for _, padAction in v4.PAD_ACTIONS do
        if not v271[padAction.id] then
            v188[padAction.id] = keep(padAction, padAction.buttons)
        end
    end

    padReindex()
    local v277 = {}

    for _, padAction in v4.PAD_ACTIONS do
        local v280
        local v281 = v254[padAction.id] or {}
        local v282 = v188[padAction.id]

        if #v281 == #v282 then
            v280 = true

            for v283, v284 in v281 do
                if v282[v283] ~= v284 then
                    v280 = false
                    break
                end
            end
        else
            v280 = false
        end

        if not v280 then
            table.insert(v277, padAction.id)
        end
    end

    if 0 < #v277 then
        v4.PadChanged:Fire(v277)
    end
end

function v4.PadAssign(key, a286: number, target)
    --[[
      name: PadAssign
      line: 761
      upvalues:
        v161 (copy, index: 1)
        padAllowed (copy, index: 2)
        v188 (copy, index: 3)
        padReindex (copy, index: 4)
        v4 (copy, index: 5)
        padTaken (copy, index: 6)
    ]]
    local v288 = v161[key]

    if not v288 or not padAllowed[target] then
        return {}, {}
    end

    local targets = v188[key]
    local clampedValue = math.clamp(a286, 1, (math.min(v288.max, #targets + 1)))
    local target2 = targets[clampedValue]

    if target2 == target then
        return {}, {}
    elseif const index2 = table.find(targets, target) then
        if target2 == nil then
            return {}, {}
        end

        targets[index2] = target2
        targets[clampedValue] = target
        padReindex()
        v4.PadChanged:Fire({key})

        return {key}, {}
    end

    targets[clampedValue] = target
    padReindex()
    local v293 = {key}
    local v294 = {}

    for _, padAction in v4.PAD_ACTIONS do
        if padAction.id ~= key then
            local v297
            v297 = false

            for contextKey in v288.contexts do
                if padAction.contexts[contextKey] then
                    v297 = true
                    break
                end
            end

            local v299, index
            local v301, v302 = false, false

            if v297 then
                v299 = v188[padAction.id]
                index = table.find(v299, target)

                if index then
                    if target2 then
                        if table.find(v299, target2) then
                            v301 = true
                        elseif padTaken(padAction, target2, nil) ~= nil then
                            v301 = true
                        else
                            v299[index] = target2
                            v302 = true
                        end
                    else
                        v301 = true
                    end
                end
            end

            if v301 then
                table.remove(v299, index)
                v302 = true
            end

            if v302 then
                padReindex()
                table.insert(v293, padAction.id)
                table.insert(v294, {id = padAction.id, now = table.clone(v299)})
            end
        end
    end

    v4.PadChanged:Fire(v293)

    return v293, v294
end

function v4.PadClear(key, index)
    --[[
      name: PadClear
      line: 809
      upvalues:
        v188 (copy, index: 1)
        padReindex (copy, index: 2)
        v4 (copy, index: 3)
    ]]
    local v305 = v188[key]

    if not v305 or not v305[index] then
        return
    end

    table.remove(v305, index)
    padReindex()
    v4.PadChanged:Fire({key})
end

function v4.PadResetAll()
    --[[
      name: PadResetAll
      line: 820
      upvalues:
        v4 (copy, index: 1)
        v188 (copy, index: 2)
        padResetAll (copy, index: 3)
    ]]
    local v306 = {}

    for _, padAction in v4.PAD_ACTIONS do
        local v309
        local v310 = v188[padAction.id]
        local buttons = padAction.buttons

        if #v310 == #buttons then
            v309 = true

            for buttonKey, v313 in v310 do
                if buttons[buttonKey] ~= v313 then
                    v309 = false
                    break
                end
            end
        else
            v309 = false
        end

        if not v309 then
            table.insert(v306, padAction.id)
        end
    end

    padResetAll()

    if 0 < #v306 then
        v4.PadChanged:Fire(v306)
    end

    return v306
end

v4.FakeInput = Signal.new()

function v4.OnInput(a314, callback)
    --[[
      name: OnInput
      line: 840
      upvalues:
        runService (copy, index: 1)
        v4 (copy, index: 2)
    ]]
    local rbxScriptSignal
    local userInputService = game:GetService("UserInputService")

    if a314 ~= "Began" then
        rbxScriptSignal = if a314 == "Ended" then userInputService.InputEnded else userInputService.InputChanged
    else
        rbxScriptSignal = userInputService.InputBegan
    end

    rbxScriptSignal:Connect(callback)

    if runService:IsStudio() then
        v4.FakeInput:Connect(
            function(a318, a319, a320)
                --[[
                  line: 845
                  upvalues:
                    a314 (copy, index: 1)
                    callback (copy, index: 2)
                ]]
                if a318 == a314 then
                    callback(a319, a320 == true)
                end
            end
        )
    end
end

local childNames = {"Slide", "Jump"}
local v322 = {MouseButton1 = Enum.KeyCode.MouseLeftButton, MouseButton2 = Enum.KeyCode.MouseRightButton, MouseButton3 = Enum.KeyCode.MouseMiddleButton}

local function isPadCode(keyCode)
    --[[
      name: isPadCode
      line: 863
    ]]
    local name = keyCode.Name
    return string.find(name, "^Button") ~= nil
        or string.find(name, "^DPad") ~= nil
        or string.find(name, "^Thumbstick") ~= nil
end

local v326 = {}

local function collectPadBindings(instance: Instance?)
    --[[
      name: collectPadBindings
      line: 873
      upvalues:
        childNames (copy, index: 1)
        v326 (copy, index: 2)
        isPadCode (copy, index: 3)
    ]]
    for _, childName in childNames do
        if const child2 = instance:FindFirstChild(childName) then
            if not child2:IsA("InputAction") then
                continue
            end

            for _, child in child2:GetChildren() do
                if child:IsA("InputBinding") then
                    if v326[child] ~= nil then
                        continue
                    end

                    if isPadCode(child.KeyCode) or string.find(child.Name, "^PadLocal") ~= nil then
                        v326[child] = true
                    end
                end
            end
        end
    end
end

local function applyPadBindings(instance: Instance?)
    --[[
      name: applyPadBindings
      line: 885
      upvalues:
        v326 (copy, index: 1)
        childNames (copy, index: 2)
        v188 (copy, index: 3)
        v190 (ref,  index: 4)
    ]]
    local compare = function(left: Instance, right: Instance)
        --[[
          line: 902
        ]]
        return left.Name < right.Name
    end

    for v339 in v326 do
        if not v339.Parent then
            v326[v339] = nil
        end
    end

    local _

    for _, childName in childNames do
        if const instance2 = instance:FindFirstChild(childName) then
            if not instance2:IsA("InputAction") then
                continue
            end

            local v344 = {}

            for _, child in instance2:GetChildren() do
                local child2 = child

                if child2:IsA("InputBinding") and v326[child2] then
                    table.insert(v344, child2)
                end
            end

            table.sort(v344, compare)
            local v348 = v188[childName] or {}

            for index = 1, math.max(#v344, #v348) do
                local instance3 = v344[index]
                local v351 = v348[index]

                if v351 and not instance3 then
                    local inputBinding = Instance.new("InputBinding")
                    inputBinding.Name = "PadLocal" .. index
                    inputBinding.KeyCode = Enum.KeyCode.None
                    v326[inputBinding] = true
                    inputBinding.Parent = instance2
                    instance3 = inputBinding
                end

                if instance3 then
                    local v353 = if v351 and not v190 then Enum.KeyCode[v351] else Enum.KeyCode.None
                    pcall(
                        function()
                            --[[
                              line: 919
                              upvalues:
                                instance3 (ref,  index: 1)
                                v353 (copy, index: 2)
                            ]]
                            instance3.KeyCode = v353
                        end
                    )
                end
            end
        end
    end
end

local function tribesInputs()
    --[[
      name: tribesInputs
      line: 926
      upvalues:
        players (copy, index: 1)
    ]]
    local localPlayer = players.LocalPlayer
    return localPlayer and localPlayer:FindFirstChild("TribesInputs")
end

function v4.SetPadBlocked(padBlocked)
    --[[
      name: SetPadBlocked
      line: 931
      upvalues:
        v190 (ref,  index: 1)
        players (copy, index: 2)
        collectPadBindings (copy, index: 3)
        applyPadBindings (copy, index: 4)
    ]]
    v190 = padBlocked
    local instance = players.LocalPlayer
    instance = instance and instance:FindFirstChild("TribesInputs")

    if instance then
        collectPadBindings(instance)
        applyPadBindings(instance)
    end
end

local function applyInputActions()
    --[[
      name: applyInputActions
      line: 940
      upvalues:
        players (copy, index: 1)
        collectPadBindings (copy, index: 2)
        applyPadBindings (copy, index: 3)
        childNames (copy, index: 4)
        v326 (copy, index: 5)
        v52 (copy, index: 6)
        v322 (copy, index: 7)
        isPadCode (copy, index: 8)
    ]]
    local compare = function(left: Instance, right: Instance)
        --[[
          line: 961
        ]]
        return left.Name < right.Name
    end

    local instance = players.LocalPlayer
    instance = instance and instance:FindFirstChild("TribesInputs")

    if not instance then
        return
    end

    collectPadBindings(instance)
    applyPadBindings(instance)
    local _

    for _, childName in childNames do
        if const instance2 = instance:FindFirstChild(childName) then
            if not instance2:IsA("InputAction") then
                continue
            end

            local v367 = {}

            for _, child in instance2:GetChildren() do
                local child2 = child

                if child2:IsA("InputBinding") then
                    if child2.Name == "Script" then
                        continue
                    end
                    if child2.Type == Enum.InputBindingType.Scriptable then
                        continue
                    end

                    if not isPadCode(child2.KeyCode) and v326[child2] == nil then
                        table.insert(v367, child2)
                    end
                end
            end

            table.sort(v367, compare)
            local v371 = v52[childName] or {}

            for index = 1, math.max(#v367, #v371) do
                local instance3 = v367[index]
                local v374 = v371[index]

                if v374 and not instance3 then
                    local inputBinding = Instance.new("InputBinding")
                    inputBinding.Name = "KeyLocal" .. index
                    inputBinding.Parent = instance2
                    instance3 = inputBinding
                end

                if instance3 then
                    local v376

                    if v374 then
                        v376 = v322[v374] or Enum.KeyCode[v374]
                    else
                        v376 = Enum.KeyCode.None
                    end

                    pcall(
                        function()
                            --[[
                              line: 976
                              upvalues:
                                instance3 (ref,  index: 1)
                                v376 (copy, index: 2)
                            ]]
                            instance3.KeyCode = v376
                        end
                    )
                end
            end
        end
    end
end

v4.ApplyInputActions = applyInputActions

if runService:IsClient() then
    local function onIds(a378)
        --[[
          name: onIds
          line: 986
        ]]
        for _, v380 in a378 do
            if v380 == "Slide" then
                break
            end
            if v380 == "Jump" then
                break
            end
        end
    end

    v4.Changed:Connect(onIds)
    v4.PadChanged:Connect(onIds)

    task.spawn(
        function()
            --[[
              line: 996
              upvalues:
                players (copy, index: 1)
                childNames (copy, index: 2)
                applyInputActions (copy, index: 3)
            ]]
            local instance = players.LocalPlayer
            instance = instance and instance:WaitForChild("TribesInputs", 120)

            if not instance then
                return
            end

            for _, childName in childNames do
                instance:WaitForChild(childName, 10)
            end

            applyInputActions()

            instance.DescendantAdded:Connect(
                function(descendant: Instance)
                    --[[
                      line: 1007
                      upvalues:
                        applyInputActions (copy, index: 1)
                    ]]
                    if descendant:IsA("InputBinding")
                        and not string.find(descendant.Name, "^KeyLocal")
                        and not string.find(descendant.Name, "^PadLocal")
                    then
                        task.defer(applyInputActions)
                    end
                end
            )
        end
    )
end

return v4