local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local Signal_1 = require(script.Parent:WaitForChild("Signal"))
local tbl_upv_1 = {}
tbl_upv_1.PREFIX = "kb_"
tbl_upv_1.PAD_PREFIX = "gp_"
tbl_upv_1.MAX = 2
local function A(a1, a2, a3, a4, a5)
    --[[
      name: A
      line: 39
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_2 = {group = 0, max = 0}
    tbl_2.id = a1
    tbl_2.label = a2
    tbl_2.keys = a3
    tbl_2.max = a5 or (tbl_upv_1.MAX)
    tbl_2.group = a4
    return tbl_2
end
local tbl_3 = {"Space"}
local tbl_4 = {"C", "LeftControl"}
local tbl_5 = {label = "SLIDE", id = "Slide", group = "move"}
tbl_5.keys = tbl_4
tbl_5.max = tbl_upv_1.MAX
local tbl_6 = {"MouseButton1"}
local tbl_7 = {"MouseButton2"}
local tbl_8 = {label = "AIM / BLOCK", id = "Aim", group = "combat"}
tbl_8.keys = tbl_7
tbl_8.max = tbl_upv_1.MAX
local tbl_9 = {"R"}
local tbl_10 = {"MouseButton3", "G"}
local tbl_11 = {label = "PING", id = "Ping", group = "combat"}
tbl_11.keys = tbl_10
tbl_11.max = tbl_upv_1.MAX
local tbl_12 = {"One"}
local tbl_13 = {"Two"}
local tbl_14 = {label = "ITEM 2", id = "Item2", group = "items", max = 1}
tbl_14.keys = tbl_13
local tbl_15 = {"Three"}
local tbl_16 = {"Four"}
local tbl_17 = {label = "ITEM 4", id = "Item4", group = "items", max = 1}
tbl_17.keys = tbl_16
local tbl_18 = {"Five"}
local tbl_19 = {"Six"}
local tbl_20 = {label = "ITEM 6", id = "Item6", group = "items", max = 1}
tbl_20.keys = tbl_19
local tbl_21 = {"Q"}
local tbl_22 = {"B"}
local tbl_23 = {label = "NEXT LOADOUT", id = "NextLoadout", group = "items"}
tbl_23.keys = tbl_22
tbl_23.max = tbl_upv_1.MAX
local tbl_24 = {"V"}
local tbl_25 = {"X"}
local tbl_26 = {label = "SWITCH SHOULDER", id = "Shoulder", group = "camera"}
tbl_26.keys = tbl_25
tbl_26.max = tbl_upv_1.MAX
local tbl_27 = {
    {label = "JUMP", id = "Jump", group = "move", keys = tbl_3, max = tbl_upv_1.MAX},
    tbl_5,
    {label = "ATTACK", id = "Attack", group = "combat", keys = tbl_6, max = tbl_upv_1.MAX},
    tbl_8,
    {label = "RELOAD", id = "Reload", group = "combat", keys = tbl_9, max = tbl_upv_1.MAX},
    tbl_11,
    {label = "ITEM 1", id = "Item1", group = "items", max = 1, keys = tbl_12},
    tbl_14,
    {label = "ITEM 3", id = "Item3", group = "items", max = 1, keys = tbl_15},
    tbl_17,
    {label = "ITEM 5", id = "Item5", group = "items", max = 1, keys = tbl_18},
    tbl_20,
    {label = "LAST ITEM", id = "LastItem", group = "items", keys = tbl_21, max = tbl_upv_1.MAX},
    tbl_23,
    {label = "FIRST / THIRD PERSON", id = "View", group = "camera", keys = tbl_24, max = tbl_upv_1.MAX},
    tbl_26
}
local tbl_28 = {"LeftAlt", "RightAlt"}
local tbl_29 = {"H"}
local tbl_30 = {label = "CUSTOM MATCH MENU", id = "CustomMenu", group = "menus"}
tbl_30.keys = tbl_29
tbl_30.max = tbl_upv_1.MAX
tbl_27[17], tbl_27[18], tbl_27[19] = {label = "FREE CURSOR", id = "FreeCursor", group = "camera", keys = tbl_28, max = tbl_upv_1.MAX}, tbl_30, {label = "SCOREBOARD (HOLD)", id = "Scoreboard", group = "menus", keys = {"Tab"}, max = tbl_upv_1.MAX}
tbl_upv_1.ACTIONS = tbl_27
local tbl_upv_31 = {}
for _, value_1 in tbl_upv_1.ACTIONS do
    tbl_upv_31[value_1.id] = value_1
end
function tbl_upv_1.Action(a1)
    --[[
      name: Action
      line: 76
      upvalues:
        tbl_upv_31 (copy, index: 1)
    ]]
    return tbl_upv_31[a1]
end
local tbl_upv_32 = {MouseButton1 = true, MouseButton3 = true, MouseButton2 = true}
local tbl_upv_33 = {
    A = "W A S D move you",
    E = "E interacts with things",
    D = "W A S D move you",
    Left = "The arrow keys turn the camera",
    F10 = "Reserved by Roblox",
    M = "M opens Settings",
    RightSuper = "Reserved by your system",
    S = "W A S D move you",
    Up = "The arrow keys move you",
    Escape = "Esc opens the Roblox menu",
    W = "W A S D move you",
    F11 = "Reserved by Roblox",
    Print = "Reserved by your system",
    LeftSuper = "Reserved by your system",
    Menu = "Reserved by your system",
    F12 = "Reserved by Roblox",
    Slash = "/ opens chat",
    Right = "The arrow keys turn the camera",
    Down = "The arrow keys move you",
    F9 = "F9 opens Roblox's console"
}
tbl_upv_1.RESERVED = tbl_upv_33
local tbl_upv_34 = {}
for _, value_2 in string.split("B C F G H I J K L N O P Q R T U V X Y Z", " ") do
    tbl_upv_34[value_2] = value_2
end
for key_1, value_3 in {"Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"} do
    tbl_upv_34[value_3] = tostring(key_1 - 1)
    tbl_upv_34["Keypad" .. value_3] = "NUM " .. tostring(key_1 - 1)
end
tbl_upv_34["F" .. 1] = "F" .. 1
tbl_upv_34["F" .. 2] = "F" .. 2
tbl_upv_34["F" .. 3] = "F" .. 3
tbl_upv_34["F" .. 4] = "F" .. 4
tbl_upv_34["F" .. 5] = "F" .. 5
tbl_upv_34["F" .. 6] = "F" .. 6
tbl_upv_34["F" .. 7] = "F" .. 7
tbl_upv_34["F" .. 8] = "F" .. 8
local tbl_35 = {}
tbl_35.Space = "SPACE"
tbl_35.Tab = "TAB"
tbl_35.CapsLock = "CAPS"
tbl_35.Return = "ENTER"
tbl_35.Backspace = "BKSP"
tbl_35.LeftShift = "SHIFT"
tbl_35.RightShift = "R SHIFT"
tbl_35.LeftControl = "CTRL"
tbl_35.RightControl = "R CTRL"
tbl_35.LeftAlt = "ALT"
tbl_35.RightAlt = "R ALT"
tbl_35.Insert = "INS"
tbl_35.Delete = "DEL"
tbl_35.Home = "HOME"
tbl_35.End = "END"
tbl_35.PageUp = "PG UP"
tbl_35.PageDown = "PG DN"
tbl_35.Backquote = "`"
tbl_35.Minus = "-"
tbl_35.Equals = "="
tbl_35.LeftBracket = "["
tbl_35.RightBracket = "]"
tbl_35.BackSlash = "\\"
tbl_35.Semicolon = ";"
tbl_35.Quote = "'"
tbl_35.Comma = ","
tbl_35.Period = "."
tbl_35.KeypadPeriod = "NUM ."
tbl_35.KeypadDivide = "NUM /"
tbl_35.KeypadMultiply = "NUM *"
tbl_35.KeypadMinus = "NUM -"
tbl_35.KeypadPlus = "NUM +"
tbl_35.KeypadEnter = "NUM ENTER"
tbl_35.MouseButton1 = "LEFT CLICK"
tbl_35.MouseButton2 = "RIGHT CLICK"
tbl_35.MouseButton3 = "MIDDLE CLICK"
for key_2, value_4 in tbl_35 do
    tbl_upv_34[key_2] = value_4
end
function tbl_upv_1.Bindable(a1)
    --[[
      name: Bindable
      line: 131
      upvalues:
        tbl_upv_34 (copy, index: 1)
        tbl_upv_33 (copy, index: 2)
    ]]
    if tbl_upv_34[a1] then
        return true, nil
    end
    return false, tbl_upv_33[a1] or "That key can't be used"
end
function tbl_upv_1.Display(a1)
    --[[
      name: Display
      line: 139
      upvalues:
        tbl_upv_34 (copy, index: 1)
    ]]
    if a1 then
        return tbl_upv_34[a1] or a1
    end
    return "\226\128\148"
end
function tbl_upv_1.CapFor(a1)
    --[[
      name: CapFor
      line: 144
      upvalues:
        tbl_upv_34 (copy, index: 1)
    ]]
    if a1 then
        if a1 ~= "MouseButton1" then
            if a1 ~= "MouseButton2" then
                if a1 ~= "MouseButton3" then
                    return tbl_upv_34[a1] or a1
                end
                return "M3"
            end
            return "M2"
        end
        return "M1"
    end
    return nil
end
function tbl_upv_1.Parse(a1, a2)
    --[[
      name: Parse
      line: 161
      upvalues:
        tbl_upv_31 (copy, index: 1)
        tbl_upv_34 (copy, index: 2)
    ]]
    local v1 = tbl_upv_31[a1]
    if not v1 or type(a2) ~= "string" or #a2 > 64 then
        return nil
    end
    if a2 == "-" then
        return {}
    end
    if a2 == "" then
        return nil
    end
    local v2 = string.split(a2, ",")
    if v1.max < #v2 then
        return nil
    end
    local tbl_36 = {}
    for _, value_5 in v2 do
        if #value_5 ~= 0 and not (#value_5 > 16) and tbl_upv_34[value_5] and not (tbl_36[value_5]) then
            tbl_36[value_5] = true
            continue
        end
        return nil
    end
    return v2
end
function tbl_upv_1.Encode(a1)
    --[[
      name: Encode
      line: 186
    ]]
    if #a1 ~= 0 then
        return (table.concat(a1, ","))
    end
    return "-"
end
function tbl_upv_1.ValidSetting(a1, a2)
    --[[
      name: ValidSetting
      line: 191
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_31 (copy, index: 2)
    ]]
    if type(a1) == "string" then
        local v3 = nil
        if string.sub(a1, 1, #tbl_upv_1.PAD_PREFIX) ~= tbl_upv_1.PAD_PREFIX then
            if string.sub(a1, 1, #tbl_upv_1.PREFIX) ~= tbl_upv_1.PREFIX then
                return false
            end
            local v4 = string.sub(a1, #tbl_upv_1.PREFIX + 1)
            if not tbl_upv_31[v4] then
                return false
            end
            local v5 = true
            if a2 ~= "" then
                v5 = tbl_upv_1.Parse(v4, a2) ~= nil
            end
            return v5
        else
            v3 = string.sub(a1, #tbl_upv_1.PAD_PREFIX + 1)
            if not tbl_upv_1.PadAction(v3) then
                return false
            end
            local v6 = true
            if a2 ~= "" then
                v6 = tbl_upv_1.PadParse(v3, a2) ~= nil
            end
            return v6
        end
    else
        return false
    end
end
function tbl_upv_1.IsKey(a1)
    --[[
      name: IsKey
      line: 213
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v7 = false
    local v8
    if type(a1) ~= "string" then
        v8 = v7
    else
        v8 = true
        if string.sub(a1, 1, #tbl_upv_1.PREFIX) ~= tbl_upv_1.PREFIX then
            v8 = string.sub(a1, 1, #tbl_upv_1.PAD_PREFIX) == tbl_upv_1.PAD_PREFIX
        end
    end
    return v8
end
local function sameList(a1, a2)
    --[[
      name: sameList
      line: 218
    ]]
    if #a1 == #a2 then
        for key_3, value_6 in a1 do
            if a2[key_3] == value_6 then
                continue
            end
            return false
        end
        return true
    end
    return false
end
local tbl_upv_37 = {}
local tbl_upv_38 = {}
tbl_upv_1.Changed = Signal_1.new()
local function reindex()
    --[[
      name: reindex
      line: 238
      upvalues:
        tbl_upv_38 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_37 (copy, index: 3)
    ]]
    table.clear(tbl_upv_38)
    for _, value_7 in tbl_upv_1.ACTIONS do
        for v1, value_8 in tbl_upv_37[value_7.id] do
            tbl_upv_38[value_8] = value_7.id
        end
    end
end
local function resetAll()
    --[[
      name: resetAll
      line: 247
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_37 (copy, index: 2)
        reindex (copy, index: 3)
    ]]
    for _, value_9 in tbl_upv_1.ACTIONS do
        tbl_upv_37[value_9.id] = table.clone(value_9.keys)
    end
    reindex()
end
resetAll()
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 255
      upvalues:
        tbl_upv_37 (copy, index: 1)
    ]]
    return table.clone(tbl_upv_37[a1] or {})
end
function tbl_upv_1.IsDefault(a1)
    --[[
      name: IsDefault
      line: 259
      upvalues:
        tbl_upv_31 (copy, index: 1)
        tbl_upv_37 (copy, index: 2)
    ]]
    local v9 = tbl_upv_31[a1]
    local v10 = false
    local v11, v12
    if v9 == nil then
        return v10
    end
    v11 = tbl_upv_37[a1]
    v12 = v9.keys
    if #v11 == #v12 then
        for key_4, value_10 in v11 do
            if v12[key_4] == value_10 then
                continue
            end
            return false
        end
        v10 = true
        return v10
    end
    return false
end
function tbl_upv_1.AllDefault()
    --[[
      name: AllDefault
      line: 264
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_37 (copy, index: 2)
    ]]
    local v13 = nil
    for _, value_11 in tbl_upv_1.ACTIONS do
        local v14 = tbl_upv_37[value_11.id]
        local keys_1 = value_11.keys
        if #v14 == #keys_1 then
            for key_5, value_12 in v14 do
                if keys_1[key_5] ~= value_12 then
                    v13 = false
                end
            end
        else
            v13 = false
        end
        if v13 then
            continue
        end
        return false
    end
    return true
end
function tbl_upv_1.OwnerOf(a1)
    --[[
      name: OwnerOf
      line: 273
      upvalues:
        tbl_upv_38 (copy, index: 1)
    ]]
    return tbl_upv_38[a1]
end
function tbl_upv_1.SettingValue(a1)
    --[[
      name: SettingValue
      line: 278
      upvalues:
        tbl_upv_31 (copy, index: 1)
        tbl_upv_37 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v15 = tbl_upv_31[a1]
    if not v15 then
        return ""
    end
    local v16 = tbl_upv_37[a1]
    local keys_2 = v15.keys
    local v17 = nil
    if #v16 == #keys_2 then
        for key_6, value_13 in v16 do
            if keys_2[key_6] ~= value_13 then
                v17 = false
            end
        end
    else
        v17 = false
    end
    if v17 then
        return ""
    end
    return tbl_upv_1.Encode(tbl_upv_37[a1])
end
function tbl_upv_1.Load(a1)
    --[[
      name: Load
      line: 289
      upvalues:
        tbl_upv_37 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        reindex (copy, index: 3)
    ]]
    local v18
    if type(a1) ~= "table" then
        local tbl_39 = {}
        v18 = tbl_39
    else
        v18 = a1
    end
    local tbl_40 = {}
    for key_7, value_14 in tbl_upv_37 do
        tbl_40[key_7] = value_14
    end
    local tbl_41 = {}
    local tbl_42 = {}
    local v19 = nil
    for _, value_15 in tbl_upv_1.ACTIONS do
        v19 = tbl_upv_1.Parse(value_15.id, v18[tbl_upv_1.PREFIX .. value_15.id])
        if not (v19) then
            continue
        end
        local tbl_43 = {}
        for v22, value_16 in v19 do
            if not (tbl_41[value_16]) then
                tbl_41[value_16] = true
                table.insert(tbl_43, value_16)
            end
        end
        tbl_upv_37[value_15.id] = tbl_43
        tbl_42[value_15.id] = true
    end
    for _, value_17 in tbl_upv_1.ACTIONS do
        if tbl_42[value_17.id] then
            continue
        end
        local tbl_44 = {}
        for v23, value_18 in value_17.keys do
            if not (tbl_41[value_18]) then
                tbl_41[value_18] = true
                table.insert(tbl_44, value_18)
            end
        end
        tbl_upv_37[value_17.id] = tbl_44
    end
    reindex()
    tbl_42 = {}
    for _, value_19 in tbl_upv_1.ACTIONS do
        local v20 = tbl_40[value_19.id] or {}
        local v21 = tbl_upv_37[value_19.id]
        if #v20 == #v21 then
            for key_8, value_20 in v20 do
                if v21[key_8] ~= value_20 then
                    v19 = false
                end
            end
        else
            v19 = false
        end
        if not (v19) then
            table.insert(tbl_42, value_19.id)
        end
    end
    if #tbl_42 > 0 then
        tbl_upv_1.Changed:Fire(tbl_42)
    end
    tbl_upv_1.PadLoad(v18)
end
function tbl_upv_1.Assign(a1, a2, a3)
    --[[
      name: Assign
      line: 339
      upvalues:
        tbl_upv_31 (copy, index: 1)
        tbl_upv_34 (copy, index: 2)
        tbl_upv_37 (copy, index: 3)
        tbl_upv_38 (copy, index: 4)
        reindex (copy, index: 5)
        tbl_upv_1 (copy, index: 6)
    ]]
    local v22 = tbl_upv_31[a1]
    if v22 and tbl_upv_34[a3] then
        local v23 = math.clamp(a2, 1, math.min(v22.max, #tbl_upv_37[a1] + 1))
        local v24 = tbl_upv_37[a1]
        local v25 = v24[v23]
        if v25 == a3 then
            return {}, nil, nil
        end
        local tbl_45 = {a1}
        local v26 = tbl_upv_38[a3]
        if v26 ~= a1 then
            if v26 then
                local v27 = tbl_upv_37[v26]
                local v28 = table.find(v27, a3)
                if not (v25) or table.find(v27, v25) then
                    table.remove(v27, v28)
                else
                    v27[v28] = v25
                end
                table.insert(tbl_45, v26)
                local _ = table.clone(v27)
            end
            v24[v23] = a3
        elseif v25 ~= nil then
            v24[table.find(v24, a3)] = v25
            v24[v23] = a3
        else
            return {}, nil, nil
        end
        reindex()
        tbl_upv_1.Changed:Fire(tbl_45)
        return tbl_45, ((v26 ~= a1) and v26) or nil, nil
    end
    return {}, nil, nil
end
function tbl_upv_1.Clear(a1, a2)
    --[[
      name: Clear
      line: 381
      upvalues:
        tbl_upv_37 (copy, index: 1)
        reindex (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v29 = tbl_upv_37[a1]
    if not v29 or not v29[a2] then
        return
    end
    table.remove(v29, a2)
    reindex()
    tbl_upv_1.Changed:Fire({a1})
end
function tbl_upv_1.ResetAll()
    --[[
      name: ResetAll
      line: 392
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_37 (copy, index: 2)
        resetAll (copy, index: 3)
    ]]
    local tbl_46 = {}
    local v30 = nil
    for _, value_21 in tbl_upv_1.ACTIONS do
        local v31 = tbl_upv_37[value_21.id]
        local keys_3 = value_21.keys
        if #v31 == #keys_3 then
            for key_9, value_22 in v31 do
                if keys_3[key_9] ~= value_22 then
                    v30 = false
                end
            end
        else
            v30 = false
        end
        if not (v30) then
            table.insert(tbl_46, value_21.id)
        end
    end
    resetAll()
    if #tbl_46 > 0 then
        tbl_upv_1.Changed:Fire(tbl_46)
    end
    return tbl_46
end
function tbl_upv_1.ActionOf(a1)
    --[[
      name: ActionOf
      line: 407
      upvalues:
        tbl_upv_38 (copy, index: 1)
    ]]
    local UserInputType_1 = a1.UserInputType
    if UserInputType_1 ~= Enum.UserInputType.Keyboard then
        if UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.MouseButton2 and UserInputType_1 ~= Enum.UserInputType.MouseButton3 then
            return nil
        end
        return tbl_upv_38[UserInputType_1.Name]
    end
    return tbl_upv_38[a1.KeyCode.Name]
end
function tbl_upv_1.Inputs(a1)
    --[[
      name: Inputs
      line: 418
      upvalues:
        tbl_upv_37 (copy, index: 1)
        tbl_upv_32 (copy, index: 2)
    ]]
    local tbl_47 = {}
    for _, value_upv_23 in tbl_upv_37[a1] or {} do
        if tbl_upv_32[value_upv_23] then
            table.insert(tbl_47, Enum.UserInputType[value_upv_23])
            continue
        end
        local success_1, v32 = pcall(
            function()
                --[[
                  line: 424
                  upvalues:
                    value_upv_23 (copy, index: 1)
                ]]
                return Enum.KeyCode[value_upv_23]
            end
        )
        if not (success_1) then
            continue
        end
        if v32 then
            table.insert(tbl_47, v32)
        end
    end
    return tbl_47
end
function tbl_upv_1.CapText(a1)
    --[[
      name: CapText
      line: 436
      upvalues:
        tbl_upv_37 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v33 = tbl_upv_37[a1]
    return tbl_upv_1.CapFor(v33 and (v33[1]))
end
function tbl_upv_1.NameOf(a1)
    --[[
      name: NameOf
      line: 442
    ]]
    local UserInputType_2 = a1.UserInputType
    if UserInputType_2 ~= Enum.UserInputType.Keyboard then
        if UserInputType_2 ~= Enum.UserInputType.MouseButton1 and UserInputType_2 ~= Enum.UserInputType.MouseButton2 and UserInputType_2 ~= Enum.UserInputType.MouseButton3 then
            return nil
        end
        return UserInputType_2.Name
    end
    return a1.KeyCode.Name
end
local tbl_48 = {"ButtonA"}
local tbl_49 = {"ButtonB"}
local tbl_50 = {"ButtonR2"}
local tbl_51 = {"ButtonL2"}
local tbl_52 = {"ButtonX"}
local tbl_53 = {"ButtonL3"}
local tbl_54 = {"ButtonR1"}
local tbl_55 = {"ButtonL1"}
local tbl_56 = {"ButtonY"}
local tbl_57 = {"DPadRight"}
local tbl_58 = {"DPadLeft"}
local tbl_59 = {"DPadUp"}
local tbl_60 = {"ButtonR3"}
local tbl_61 = {"DPadDown"}
local tbl_62 = {"ButtonR1", "ButtonA"}
local tbl_63 = {"ButtonL1", "ButtonB"}
local function P(a1, a2, a3, a4, a5, a6, a7)
    --[[
      name: P
      line: 479
    ]]
    local tbl_64 = {}
    for _, value_24 in string.split(a5, " ") do
        tbl_64[value_24] = true
    end
    local tbl_65 = {}
    tbl_65.id = a1
    tbl_65.label = a2
    tbl_65.desc = a3
    tbl_65.buttons = a4
    tbl_65.max = a7 or 1
    tbl_65.contexts = tbl_64
    tbl_65.group = a6
    return tbl_65
end
local tbl_66 = {
    P("Jump", "JUMP", "In the lobby and in matches", tbl_48, "lobby training match", "move"),
    P("Slide", "SLIDE", "While running", tbl_49, "lobby training match", "move"),
    P("Attack", "ATTACK", "Swing, fire, throw, use", tbl_50, "training match", "combat"),
    P("Aim", "AIM / BLOCK", "Aim, zoom, block, heavy attack, lunge", tbl_51, "training match", "combat"),
    P("Reload", "RELOAD", "Reload your weapon", tbl_52, "training match", "combat"),
    P("Ping", "PING", "Mark a spot for your team", tbl_53, "match spectate", "combat"),
    P("NextItem", "NEXT ITEM", "The next hotbar slot", tbl_54, "training match", "items"),
    P("PrevItem", "PREVIOUS ITEM", "The previous hotbar slot", tbl_55, "training match", "items"),
    P("LastItem", "LAST ITEM", "Swap back to your last item", tbl_56, "training match", "items"),
    P("NextLoadout", "NEXT LOADOUT", "During the round countdown", tbl_57, "match", "items"),
    P("PrevLoadout", "PREVIOUS LOADOUT", "During the round countdown", tbl_58, "match", "items"),
    P("View", "FIRST / THIRD PERSON", "Switch the camera view", tbl_59, "training match", "camera"),
    P("Shoulder", "SWITCH SHOULDER", "Look over the other shoulder", tbl_60, "training match", "camera"),
    P("Scoreboard", "SCOREBOARD (HOLD)", "In a match", tbl_61, "match spectate", "menus"),
    P("SpectateNext", "SPECTATE NEXT", "While you're out of the round", tbl_62, "spectate", "spectate", 2),
    P("SpectatePrev", "SPECTATE PREVIOUS", "While you're out of the round", tbl_63, "spectate", "spectate", 2)
}
local tbl_67 = {"ButtonY"}
local tbl_68 = {"DPadDown"}
tbl_66[17], tbl_66[18] = P("Play", "PLAY / CANCEL", "Join or leave the queue in the lobby", tbl_67, "lobby", "menus"), P("CustomMenu", "CUSTOM MATCH MENU", "In a custom match server's lobby", tbl_68, "lobby", "menus")
tbl_upv_1.PAD_ACTIONS = tbl_66
local tbl_upv_69 = {}
for _, value_25 in tbl_upv_1.PAD_ACTIONS do
    tbl_upv_69[value_25.id] = value_25
end
function tbl_upv_1.PadAction(a1)
    --[[
      name: PadAction
      line: 513
      upvalues:
        tbl_upv_69 (copy, index: 1)
    ]]
    return tbl_upv_69[a1]
end
local tbl_upv_70 = {DPadRight = "D-PAD RIGHT", DPadLeft = "D-PAD LEFT", ButtonX = "X", DPadDown = "D-PAD DOWN", DPadUp = "D-PAD UP", ButtonR3 = "RS", ButtonA = "A", ButtonR1 = "RB", ButtonL1 = "LB", ButtonR2 = "RT", ButtonL2 = "LT", ButtonL3 = "LS", ButtonB = "B", ButtonY = "Y"}
tbl_upv_1.PAD_ALLOWED = tbl_upv_70
local tbl_upv_71 = {ButtonStart = "That button opens Roblox's menu", ButtonSelect = "That button opens Settings"}
tbl_upv_1.PAD_RESERVED = tbl_upv_71
local function isPadType(a1)
    --[[
      name: isPadType
      line: 531
    ]]
    local v34 = string.sub(a1.Name, 1, 7) == "Gamepad"
    return v34
end
function tbl_upv_1.PadBindable(a1)
    --[[
      name: PadBindable
      line: 536
      upvalues:
        tbl_upv_70 (copy, index: 1)
        tbl_upv_71 (copy, index: 2)
    ]]
    if tbl_upv_70[a1] then
        return true, nil
    end
    return false, tbl_upv_71[a1] or "That button can't be used"
end
function tbl_upv_1.PadDisplay(a1)
    --[[
      name: PadDisplay
      line: 544
      upvalues:
        tbl_upv_70 (copy, index: 1)
    ]]
    if a1 then
        return tbl_upv_70[a1] or a1
    end
    return "\226\128\148"
end
function tbl_upv_1.PadParse(a1, a2)
    --[[
      name: PadParse
      line: 549
      upvalues:
        tbl_upv_69 (copy, index: 1)
        tbl_upv_70 (copy, index: 2)
    ]]
    local v35 = tbl_upv_69[a1]
    if not v35 or type(a2) ~= "string" or #a2 > 64 then
        return nil
    end
    if a2 == "-" then
        return {}
    end
    if a2 == "" then
        return nil
    end
    local v36 = string.split(a2, ",")
    if v35.max < #v36 then
        return nil
    end
    local tbl_72 = {}
    for _, value_26 in v36 do
        if #value_26 ~= 0 and not (#value_26 > 16) and tbl_upv_70[value_26] and not (tbl_72[value_26]) then
            tbl_72[value_26] = true
            continue
        end
        return nil
    end
    return v36
end
local function overlap(a1, a2)
    --[[
      name: overlap
      line: 575
    ]]
    for key_10 in a1.contexts do
        if not (a2.contexts[key_10]) then
            continue
        end
        return true
    end
    return false
end
tbl_upv_1.PadOverlap = function(a1, a2)
    --[[
      line: 583
      upvalues:
        tbl_upv_69 (copy, index: 1)
    ]]
    local v37 = tbl_upv_69[a1]
    local v38 = tbl_upv_69[a2]
    local v39 = false
    if v37 == nil then
        return v39
    end
    local v40 = false
    if v38 == nil then
        v39 = v40
    else
        for key_11 in v37.contexts do
            if not (v38.contexts[key_11]) then
                continue
            end
            return true
        end
        v39 = false
    end
    return v39
end
local tbl_upv_73 = {}
local tbl_upv_74 = {}
local u1 = false
tbl_upv_1.PadChanged = Signal_1.new()
local function padReindex()
    --[[
      name: padReindex
      line: 594
      upvalues:
        tbl_upv_74 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        tbl_upv_73 (copy, index: 3)
    ]]
    table.clear(tbl_upv_74)
    for _, value_27 in tbl_upv_1.PAD_ACTIONS do
        for v1, value_28 in tbl_upv_73[value_27.id] do
            tbl_upv_74[value_28] = tbl_upv_74[value_28] or {}
            table.insert(tbl_upv_74[value_28], value_27.id)
        end
    end
end
local function padResetAll()
    --[[
      name: padResetAll
      line: 603
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_73 (copy, index: 2)
        padReindex (copy, index: 3)
    ]]
    for _, value_29 in tbl_upv_1.PAD_ACTIONS do
        tbl_upv_73[value_29.id] = table.clone(value_29.buttons)
    end
    padReindex()
end
padResetAll()
function tbl_upv_1.PadGet(a1)
    --[[
      name: PadGet
      line: 621
      upvalues:
        tbl_upv_73 (copy, index: 1)
    ]]
    return table.clone(tbl_upv_73[a1] or {})
end
function tbl_upv_1.PadCode(a1)
    --[[
      name: PadCode
      line: 625
      upvalues:
        tbl_upv_73 (copy, index: 1)
    ]]
    local v41 = tbl_upv_73[a1]
    local u2 = v41 and (v41[1])
    if not u2 then
        return nil
    end
    local success_2, v42 = pcall(
        function()
            --[[
              line: 631
              upvalues:
                u2 (copy, index: 1)
            ]]
            return Enum.KeyCode[u2]
        end
    )
    if success_2 then
        return v42
    end
    return nil
end
function tbl_upv_1.PadInputs(a1)
    --[[
      name: PadInputs
      line: 637
      upvalues:
        tbl_upv_73 (copy, index: 1)
    ]]
    local tbl_75 = {}
    for _, value_upv_30 in tbl_upv_73[a1] or {} do
        local success_3, v43 = pcall(
            function()
                --[[
                  line: 640
                  upvalues:
                    value_upv_30 (copy, index: 1)
                ]]
                return Enum.KeyCode[value_upv_30]
            end
        )
        if not (success_3) then
            continue
        end
        if v43 then
            table.insert(tbl_75, v43)
        end
    end
    return tbl_75
end
function tbl_upv_1.PadIsDefault(a1)
    --[[
      name: PadIsDefault
      line: 649
      upvalues:
        tbl_upv_69 (copy, index: 1)
        tbl_upv_73 (copy, index: 2)
    ]]
    local v44 = tbl_upv_69[a1]
    local v45 = false
    local v46, v47
    if v44 == nil then
        return v45
    end
    v46 = tbl_upv_73[a1]
    v47 = v44.buttons
    if #v46 == #v47 then
        for key_12, value_31 in v46 do
            if v47[key_12] == value_31 then
                continue
            end
            return false
        end
        v45 = true
        return v45
    end
    return false
end
function tbl_upv_1.PadAllDefault()
    --[[
      name: PadAllDefault
      line: 653
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_73 (copy, index: 2)
    ]]
    local v48 = nil
    for _, value_32 in tbl_upv_1.PAD_ACTIONS do
        local v49 = tbl_upv_73[value_32.id]
        local buttons_1 = value_32.buttons
        if #v49 == #buttons_1 then
            for key_13, value_33 in v49 do
                if buttons_1[key_13] ~= value_33 then
                    v48 = false
                end
            end
        else
            v48 = false
        end
        if v48 then
            continue
        end
        return false
    end
    return true
end
function tbl_upv_1.PadSettingValue(a1)
    --[[
      name: PadSettingValue
      line: 662
      upvalues:
        tbl_upv_69 (copy, index: 1)
        tbl_upv_73 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v50 = tbl_upv_69[a1]
    if not v50 then
        return ""
    end
    local v51 = tbl_upv_73[a1]
    local buttons_2 = v50.buttons
    local v52 = nil
    if #v51 == #buttons_2 then
        for key_14, value_34 in v51 do
            if buttons_2[key_14] ~= value_34 then
                v52 = false
            end
        end
    else
        v52 = false
    end
    if v52 then
        return ""
    end
    return tbl_upv_1.Encode(tbl_upv_73[a1])
end
function tbl_upv_1.SettingValueFor(a1)
    --[[
      name: SettingValueFor
      line: 670
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if string.sub(a1, 1, #tbl_upv_1.PAD_PREFIX) ~= tbl_upv_1.PAD_PREFIX then
        return tbl_upv_1.SettingValue(string.sub(a1, #tbl_upv_1.PREFIX + 1))
    end
    return tbl_upv_1.PadSettingValue(string.sub(a1, #tbl_upv_1.PAD_PREFIX + 1))
end
local tbl_upv_76 = {}
function tbl_upv_1.PadActionsOf(a1)
    --[[
      name: PadActionsOf
      line: 680
      upvalues:
        tbl_upv_76 (copy, index: 1)
        tbl_upv_74 (copy, index: 2)
    ]]
    local v53 = string.sub(a1.UserInputType.Name, 1, 7) == "Gamepad"
    if v53 then
        v53 = tbl_upv_74[a1.KeyCode.Name] or tbl_upv_76
        return v53
    end
    return tbl_upv_76
end
function tbl_upv_1.IsPad(a1, a2)
    --[[
      name: IsPad
      line: 686
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v54 = table.find(tbl_upv_1.PadActionsOf(a1), a2) ~= nil
    return v54
end
function tbl_upv_1.PadUsedIn(a1, a2)
    --[[
      name: PadUsedIn
      line: 690
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_69 (copy, index: 2)
    ]]
    for _, value_35 in tbl_upv_1.PadActionsOf(a1) do
        if not (tbl_upv_69[value_35].contexts[a2]) then
            continue
        end
        return true
    end
    return false
end
function tbl_upv_1.PadBlocked()
    --[[
      name: PadBlocked
      line: 699
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.PadLoad(a1)
    --[[
      name: PadLoad
      line: 705
      upvalues:
        tbl_upv_73 (copy, index: 1)
        tbl_upv_69 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        padReindex (copy, index: 4)
    ]]
    local v55
    if type(a1) ~= "table" then
        local tbl_77 = {}
        v55 = tbl_77
    else
        v55 = a1
    end
    local tbl_78 = {}
    for key_15, value_36 in tbl_upv_73 do
        tbl_78[key_15] = value_36
    end
    local tbl_upv_79 = {}
    local tbl_80 = {}
    local v56 = nil
    local function keep(a2, a3)
        --[[
          name: keep
          line: 712
          upvalues:
            tbl_upv_79 (copy, index: 1)
            tbl_upv_69 (copy, index: 2)
        ]]
        local tbl_81 = {}
        local v57 = nil
        local v58 = nil
        for _, value_37 in a3 do
            v57 = true
            for v60, value_38 in tbl_upv_79[value_37] or {} do
                local v59 = tbl_upv_69[value_38]
                for key_16 in a2.contexts do
                    if v59.contexts[key_16] then
                        v58 = true
                    else
                        continue
                    end
                end
                if v58 then
                    v57 = false
                    break
                end
            end
            if v57 then
                tbl_upv_79[value_37] = tbl_upv_79[value_37] or {}
                table.insert(tbl_upv_79[value_37], a2.id)
                table.insert(tbl_81, value_37)
            end
        end
        return tbl_81
    end
    for _, value_39 in tbl_upv_1.PAD_ACTIONS do
        v56 = tbl_upv_1.PadParse(value_39.id, v55[tbl_upv_1.PAD_PREFIX .. value_39.id])
        if v56 then
            tbl_upv_73[value_39.id] = keep(value_39, v56)
            tbl_80[value_39.id] = true
        end
    end
    for _, value_40 in tbl_upv_1.PAD_ACTIONS do
        if not (tbl_80[value_40.id]) then
            tbl_upv_73[value_40.id] = keep(value_40, value_40.buttons)
        end
    end
    padReindex()
    tbl_80 = {}
    for _, value_41 in tbl_upv_1.PAD_ACTIONS do
        local v60 = tbl_78[value_41.id] or {}
        local v61 = tbl_upv_73[value_41.id]
        if #v60 == #v61 then
            for key_17, value_42 in v60 do
                if v61[key_17] ~= value_42 then
                    v56 = false
                end
            end
        else
            v56 = false
        end
        if not (v56) then
            table.insert(tbl_80, value_41.id)
        end
    end
    if not (#tbl_80 > 0) then
        return
    end
    tbl_upv_1.PadChanged:Fire(tbl_80)
end
local function padTaken(a1, a2, a3)
    --[[
      name: padTaken
      line: 612
      upvalues:
        tbl_upv_74 (copy, index: 1)
        tbl_upv_69 (copy, index: 2)
    ]]
    local v62 = nil
    for _, value_43 in tbl_upv_74[a2] or {} do
        if value_43 == a1.id or value_43 == a3 then
            continue
        end
        local v63 = tbl_upv_69[value_43]
        for key_18 in a1.contexts do
            if v63.contexts[key_18] then
                v62 = true
            else
                continue
            end
        end
        if not (v62) then
            continue
        end
        return value_43
    end
    return nil
end
function tbl_upv_1.PadAssign(a1, a2, a3)
    --[[
      name: PadAssign
      line: 761
      upvalues:
        tbl_upv_69 (copy, index: 1)
        tbl_upv_70 (copy, index: 2)
        tbl_upv_73 (copy, index: 3)
        padReindex (copy, index: 4)
        tbl_upv_1 (copy, index: 5)
        padTaken (copy, index: 6)
    ]]
    local v64 = tbl_upv_69[a1]
    if not v64 or not tbl_upv_70[a3] then
        return {}, {}
    end
    local v65 = tbl_upv_73[a1]
    local v66 = math.clamp(a2, 1, math.min(v64.max, #v65 + 1))
    local v67 = v65[v66]
    if v67 == a3 then
        return {}, {}
    end
    local v68 = table.find(v65, a3)
    if v68 then
        if v67 ~= nil then
            v65[v68] = v67
            v65[v66] = a3
            padReindex()
            tbl_upv_1.PadChanged:Fire({a1})
            return {a1}, {}
        end
        return {}, {}
    else
        v65[v66] = a3
        padReindex()
        local tbl_82 = {a1}
        local tbl_83 = {}
        local v69 = nil
        for _, value_44 in tbl_upv_1.PAD_ACTIONS do
            if value_44.id == a1 then
                continue
            end
            for key_19 in v64.contexts do
                if value_44.contexts[key_19] then
                    v69 = true
                else
                    continue
                end
            end
            if not (v69) then
                continue
            end
            v69 = tbl_upv_73[value_44.id]
            local v70 = table.find(v69, a3)
            if not (v70) then
                continue
            end
            if not (v67) or table.find(v69, v67) or padTaken(value_44, v67, nil) ~= nil then
                table.remove(v69, v70)
            else
                v69[v70] = v67
            end
            padReindex()
            table.insert(tbl_82, value_44.id)
            table.insert(tbl_83, {id = value_44.id, now = table.clone(v69)})
        end
        tbl_upv_1.PadChanged:Fire(tbl_82)
        return tbl_82, tbl_83
    end
end
function tbl_upv_1.PadClear(a1, a2)
    --[[
      name: PadClear
      line: 809
      upvalues:
        tbl_upv_73 (copy, index: 1)
        padReindex (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local v71 = tbl_upv_73[a1]
    if not v71 or not v71[a2] then
        return
    end
    table.remove(v71, a2)
    padReindex()
    tbl_upv_1.PadChanged:Fire({a1})
end
function tbl_upv_1.PadResetAll()
    --[[
      name: PadResetAll
      line: 820
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_73 (copy, index: 2)
        padResetAll (copy, index: 3)
    ]]
    local tbl_84 = {}
    local v72 = nil
    for _, value_45 in tbl_upv_1.PAD_ACTIONS do
        local v73 = tbl_upv_73[value_45.id]
        local buttons_3 = value_45.buttons
        if #v73 == #buttons_3 then
            for key_20, value_46 in v73 do
                if buttons_3[key_20] ~= value_46 then
                    v72 = false
                end
            end
        else
            v72 = false
        end
        if not (v72) then
            table.insert(tbl_84, value_45.id)
        end
    end
    padResetAll()
    if #tbl_84 > 0 then
        tbl_upv_1.PadChanged:Fire(tbl_84)
    end
    return tbl_84
end
tbl_upv_1.FakeInput = Signal_1.new()
function tbl_upv_1.OnInput(a1, a2)
    --[[
      name: OnInput
      line: 840
      upvalues:
        RunService_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local UserInputService_1 = game:GetService("UserInputService")
    local v74
    if a1 == "Began" then
        v74 = UserInputService_1.InputBegan
    elseif a1 ~= "Ended" then
        v74 = UserInputService_1.InputChanged
    else
        v74 = UserInputService_1.InputEnded
    end
    v74:Connect(a2)
    if not RunService_upv_1:IsStudio() then
        return
    end
    tbl_upv_1.FakeInput:Connect(
        function(a3, a4, a5)
            --[[
              line: 845
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            if a3 ~= a1 then
                return
            end
            a2(a4, a5 == true)
        end
    )
end
local tbl_upv_85 = {"Slide", "Jump"}
local tbl_upv_86 = {}
tbl_upv_86.MouseButton1 = Enum.KeyCode.MouseLeftButton
tbl_upv_86.MouseButton2 = Enum.KeyCode.MouseRightButton
tbl_upv_86.MouseButton3 = Enum.KeyCode.MouseMiddleButton
local function isPadCode(a1)
    --[[
      name: isPadCode
      line: 863
    ]]
    local Name_1 = a1.Name
    local v75 = true
    local v76
    if string.find(Name_1, "^Button") ~= nil then
        v76 = v75
    else
        v76 = true
        if string.find(Name_1, "^DPad") == nil then
            v76 = string.find(Name_1, "^Thumbstick") ~= nil
        end
    end
    return v76
end
local tbl_upv_87 = {}
local function applyPadBindings(a1)
    --[[
      name: applyPadBindings
      line: 885
      upvalues:
        tbl_upv_87 (copy, index: 1)
        tbl_upv_85 (copy, index: 2)
        tbl_upv_73 (copy, index: 3)
        u1 (ref,  index: 4)
    ]]
    for key_21 in tbl_upv_87 do
        if not (key_21.Parent) then
            tbl_upv_87[key_21] = nil
        end
    end
    local u3 = nil
    for _, value_47 in tbl_upv_85 do
        local v77 = a1:FindFirstChild(value_47)
        if not (v77) or not (v77:IsA("InputAction")) then
            continue
        end
        local tbl_88 = {}
        for v80, value_48 in v77:GetChildren() do
            if not (value_48:IsA("InputBinding")) then
                continue
            end
            if tbl_upv_87[value_48] then
                table.insert(tbl_88, value_48)
            end
        end
        table.sort(
            tbl_88,
            function(a2, a3)
                --[[
                  line: 902
                ]]
                return a2.Name < a3.Name
            end
        )
        local v78 = tbl_upv_73[value_47] or {}
        local u4 = math.max(#tbl_88, #v78)
        for n_1 = 1, u4 do
            u4 = tbl_88[n_1]
            local v79 = v78[n_1]
            if v79 and not (u4) then
                u3 = Instance.new("InputBinding")
                u3.Name = "PadLocal" .. n_1
                u3.KeyCode = Enum.KeyCode.None
                tbl_upv_87[u3] = true
                u3.Parent = v77
                u4 = u3
            end
            if not (u4) then
                continue
            end
            if not (v79) or u1 then
                u3 = Enum.KeyCode.None
            else
                u3 = Enum.KeyCode[v79]
            end
            pcall(
                function()
                    --[[
                      line: 919
                      upvalues:
                        u4 (ref,  index: 1)
                        u3 (copy, index: 2)
                    ]]
                    u4.KeyCode = u3
                end
            )
        end
    end
end
local function tribesInputs()
    --[[
      name: tribesInputs
      line: 926
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    local v80 = LocalPlayer_1 and (LocalPlayer_1:FindFirstChild("TribesInputs"))
    return v80
end
local function collectPadBindings(a1)
    --[[
      name: collectPadBindings
      line: 873
      upvalues:
        tbl_upv_85 (copy, index: 1)
        tbl_upv_87 (copy, index: 2)
    ]]
    local v81 = nil
    for _, value_49 in tbl_upv_85 do
        local v82 = a1:FindFirstChild(value_49)
        if not (v82) then
            continue
        end
        local v83 = v82:IsA("InputAction")
        if not (v83) then
            continue
        end
        for v86, value_50 in v82:GetChildren() do
            local v84 = value_50:IsA("InputBinding")
            if not (v84) or tbl_upv_87[value_50] ~= nil then
                continue
            end
            local Name_2 = value_50.KeyCode.Name
            local v85 = true
            if string.find(Name_2, "^Button") ~= nil then
                v81 = v85
            else
                v81 = true
                if string.find(Name_2, "^DPad") == nil then
                    v81 = string.find(Name_2, "^Thumbstick") ~= nil
                end
            end
            if v81 or string.find(value_50.Name, "^PadLocal") ~= nil then
                tbl_upv_87[value_50] = true
            end
        end
    end
end
function tbl_upv_1.SetPadBlocked(a1)
    --[[
      name: SetPadBlocked
      line: 931
      upvalues:
        u1 (ref,  index: 1)
        Players_upv_1 (copy, index: 2)
        collectPadBindings (copy, index: 3)
        applyPadBindings (copy, index: 4)
    ]]
    u1 = a1
    local LocalPlayer_2 = Players_upv_1.LocalPlayer
    local v86 = LocalPlayer_2 and (LocalPlayer_2:FindFirstChild("TribesInputs"))
    if not v86 then
        return
    end
    collectPadBindings(v86)
    applyPadBindings(v86)
end
local function applyInputActions()
    --[[
      name: applyInputActions
      line: 940
      upvalues:
        Players_upv_1 (copy, index: 1)
        collectPadBindings (copy, index: 2)
        applyPadBindings (copy, index: 3)
        tbl_upv_85 (copy, index: 4)
        tbl_upv_87 (copy, index: 5)
        tbl_upv_37 (copy, index: 6)
        tbl_upv_86 (copy, index: 7)
    ]]
    local LocalPlayer_3 = Players_upv_1.LocalPlayer
    local v87 = LocalPlayer_3 and (LocalPlayer_3:FindFirstChild("TribesInputs"))
    if v87 then
        collectPadBindings(v87)
        applyPadBindings(v87)
        local v88, None_upv_1 = nil, nil
        for _, value_51 in tbl_upv_85 do
            local v89 = LocalPlayer_3:FindFirstChild(value_51)
            if not (v89) or not (v89:IsA("InputAction")) then
                continue
            end
            local tbl_89 = {}
            for v93, value_52 in v89:GetChildren() do
                if not (value_52:IsA("InputBinding")) or value_52.Name == "Script" or value_52.Type == Enum.InputBindingType.Scriptable then
                    continue
                end
                local Name_3 = value_52.KeyCode.Name
                local v90 = true
                if string.find(Name_3, "^Button") ~= nil then
                    v88 = v90
                else
                    v88 = true
                    if string.find(Name_3, "^DPad") == nil then
                        v88 = string.find(Name_3, "^Thumbstick") ~= nil
                    end
                end
                if v88 then
                    continue
                end
                if tbl_upv_87[value_52] == nil then
                    table.insert(tbl_89, value_52)
                end
            end
            table.sort(
                tbl_89,
                function(a1, a2)
                    --[[
                      line: 961
                    ]]
                    return a1.Name < a2.Name
                end
            )
            local v91 = tbl_upv_37[value_51] or {}
            local u5 = math.max(#tbl_89, #v91)
            for n_2 = 1, u5 do
                u5 = tbl_89[n_2]
                local v92 = v91[n_2]
                if v92 and not (u5) then
                    None_upv_1 = Instance.new("InputBinding")
                    None_upv_1.Name = "KeyLocal" .. n_2
                    None_upv_1.Parent = v89
                    u5 = None_upv_1
                end
                if not (u5) then
                    continue
                end
                if v92 then
                    None_upv_1 = tbl_upv_86[v92] or (Enum.KeyCode[v92])
                else
                    None_upv_1 = Enum.KeyCode.None
                end
                pcall(
                    function()
                        --[[
                          line: 976
                          upvalues:
                            u5 (ref,  index: 1)
                            None_upv_1 (copy, index: 2)
                        ]]
                        u5.KeyCode = None_upv_1
                    end
                )
            end
        end
    end
end
tbl_upv_1.ApplyInputActions = applyInputActions
if RunService_upv_1:IsClient() then
    local function onIds(a1)
        --[[
          name: onIds
          line: 986
          upvalues:
            applyInputActions (copy, index: 1)
        ]]
        for _, value_53 in a1 do
            if value_53 == "Slide" or value_53 == "Jump" then
                applyInputActions()
                return
            end
        end
    end
    tbl_upv_1.Changed:Connect(onIds)
    tbl_upv_1.PadChanged:Connect(onIds)
    task.spawn(
        function()
            --[[
              line: 996
              upvalues:
                Players_upv_1 (copy, index: 1)
                tbl_upv_85 (copy, index: 2)
                applyInputActions (copy, index: 3)
            ]]
            local LocalPlayer_4 = Players_upv_1.LocalPlayer
            local v93 = LocalPlayer_4 and (LocalPlayer_4:WaitForChild("TribesInputs", 120))
            if not v93 then
                return
            end
            for _, value_54 in tbl_upv_85 do
                LocalPlayer_4:WaitForChild(value_54, 10)
            end
            applyInputActions()
            LocalPlayer_4.DescendantAdded:Connect(
                function(a1)
                    --[[
                      line: 1007
                      upvalues:
                        applyInputActions (copy, index: 1)
                    ]]
                    if not a1:IsA("InputBinding") or (string.find(a1.Name, "^KeyLocal")) or (string.find(a1.Name, "^PadLocal")) then
                        return
                    end
                    task.defer(applyInputActions)
                end
            )
        end
    )
end
return tbl_upv_1