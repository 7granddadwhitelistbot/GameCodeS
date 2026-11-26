local replicatedStorage = game:GetService("ReplicatedStorage")
local soundService = game:GetService("SoundService")
local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds = require(replicatedStorage.Shared:WaitForChild("Keybinds"))
local v5 = {
    Changed = Signal.new(),
    DEFAULTS = {sensitivity = 1, padSensitivity = 1, padInvertY = 0, fov = 70, aimZoom = 1, aimSensitivity = 1, music = 0.6, sfx = 1, firstPerson = 0, viewBobbing = 1, friendsOnlyInvites = 0, aimAssist = 1, attackAim = 1, mmNoBots = 0, mmAutoRegion = 1, mmRegions = 0, mmPremium = 0, mmRanked = 1, modeSel = 0},
    MEMORY = {modeSel = true},
    RANGES = {sensitivity = {0.05, 3}, padSensitivity = {0.2, 3}, padInvertY = {0, 1}, fov = {60, 100}, aimZoom = {0, 1}, aimSensitivity = {0.2, 3}, music = {0, 1}, sfx = {0, 1}, firstPerson = {0, 1}, viewBobbing = {0, 1}, friendsOnlyInvites = {0, 1}, aimAssist = {0, 1}, attackAim = {0, 1}, mmNoBots = {0, 1}, mmAutoRegion = {0, 1}, mmRegions = {0, 63}, mmPremium = {0, 1}, mmRanked = {0, 1}, modeSel = {0, 7}}
}
local values = table.clone(v5.DEFAULTS)
local v7 = false
local v8 = nil

local function shared(childName: string)
    --[[
      name: shared
      line: 51
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    local child = replicatedStorage.Shared:FindFirstChild(childName)

    if child and child:IsA("ModuleScript") then
        local success, result = pcall(require, child)

        if success and type(result) == "table" then
            return result
        end
    end

    return nil
end

local v14 = {}

local function setGroup(childName: string, a17)
    --[[
      name: setGroup
      line: 63
      upvalues:
        soundService (copy, index: 1)
        v14 (copy, index: 2)
    ]]
    local child = soundService:FindFirstChild(childName)

    if child and child:IsA("SoundGroup") then
        if not v14[child] then
            v14[child] = child.Volume
        end

        child.Volume = v14[child] * a17
    end
end

local function apply(valueKey)
    --[[
      name: apply
      line: 73
      upvalues:
        values (copy, index: 1)
        replicatedStorage (copy, index: 2)
        soundService (copy, index: 3)
        v14 (copy, index: 4)
    ]]
    local result
    local value = values[valueKey]

    if valueKey ~= "sensitivity" and valueKey ~= "fov" and valueKey ~= "aimZoom" and valueKey ~= "aimSensitivity" then
        local result2

        if valueKey ~= "padSensitivity" and valueKey ~= "padInvertY" then
            local result3

            if valueKey ~= "firstPerson" and valueKey ~= "viewBobbing" and valueKey ~= "aimAssist" then
                if valueKey == "attackAim" then
                    local localPlayer = game:GetService("Players").LocalPlayer
                    if not localPlayer then
                        return
                    end

                    local touchAttackLookOff = value < 0.5 or nil
                    localPlayer:SetAttribute("TouchAttackLookOff", touchAttackLookOff)

                    return
                end

                if valueKey ~= "music" and valueKey ~= "sfx" then
                    return
                end

                local result4

                if const sfx = replicatedStorage.Shared:FindFirstChild("Sfx") then
                    if sfx:IsA("ModuleScript") then
                        local success, result5 = pcall(require, sfx)

                        if not success or type(result5) ~= "table" then
                            result4 = nil
                        else
                            result4 = result5
                        end
                    else
                        result4 = nil
                    end
                else
                    result4 = nil
                end

                local childNames = valueKey ~= "music" and {"SFX", "UI", "Ambient"} or {"Music"}

                for _, childName in childNames do
                    if not result4 or type(result4.SetVolume) ~= "function" then
                        if const child = soundService:FindFirstChild(childName) then
                            if not child:IsA("SoundGroup") then
                                continue
                            end

                            if not v14[child] then
                                v14[child] = child.Volume
                            end

                            child.Volume = v14[child] * value
                        end
                    else
                        pcall(result4.SetVolume, childName, value)
                    end
                end

                return
            elseif const camera = replicatedStorage.Shared:FindFirstChild("Camera") then
                if camera:IsA("ModuleScript") then
                    local success, result6 = pcall(require, camera)

                    if not success or type(result6) ~= "table" then
                        result3 = nil
                    else
                        result3 = result6
                    end
                else
                    result3 = nil
                end
            else
                result3 = nil
            end

            local v38 = result3
            if v38 then
                if valueKey ~= "firstPerson" then
                    v38 = if valueKey == "aimAssist" then result3.SetAimAssist else result3.SetViewBobbing
                else
                    v38 = result3.SetFirstPerson
                end
            end

            if type(v38) ~= "function" then
                return
            end

            pcall(v38, 0.5 <= value)

            return
        elseif const camera = replicatedStorage.Shared:FindFirstChild("Camera") then
            if camera:IsA("ModuleScript") then
                local success, result7 = pcall(require, camera)

                if not success or type(result7) ~= "table" then
                    result2 = nil
                else
                    result2 = result7
                end
            else
                result2 = nil
            end
        else
            result2 = nil
        end

        local padLook = result2 and result2.PadLook

        if type(padLook) ~= "table" then
            return
        end

        if valueKey == "padSensitivity" then
            pcall(padLook.SetSensitivity, value)
            return
        end

        pcall(padLook.SetInvertY, 0.5 <= value)

        return
    end

    local camera = replicatedStorage.Shared:FindFirstChild("Camera")

    if not camera or not camera:IsA("ModuleScript") then
        result = nil
    else
        local success, result8 = pcall(require, camera)

        if not success or type(result8) ~= "table" then
            result = nil
        else
            result = result8
        end
    end

    local v46 = result
    if v46 then
        if valueKey == "sensitivity" then
            v46 = result.SetSensitivity
        elseif valueKey == "fov" then
            v46 = result.SetFOV
        else
            v46 = if valueKey == "aimZoom" then result.SetAimZoom else result.SetAimSensitivity
        end
    end

    if type(v46) ~= "function" then
        return
    end

    pcall(v46, value)
end

function v5.Get(defaultKey)
    --[[
      name: Get
      line: 118
      upvalues:
        values (copy, index: 1)
        v5 (copy, index: 2)
    ]]
    return values[defaultKey] or v5.DEFAULTS[defaultKey] or 0
end

local v48 = {}

function v5.Set(rangeKey, a50, a51)
    --[[
      name: Set
      line: 125
      upvalues:
        v5 (copy, index: 1)
        values (copy, index: 2)
        apply (copy, index: 3)
        v8 (ref,  index: 4)
        v48 (copy, index: 5)
    ]]
    if const range = v5.RANGES[rangeKey] then
        a50 = math.clamp(a50, range[1], range[2])
    end

    values[rangeKey] = a50
    apply(rangeKey)
    v5.Changed:Fire(rangeKey, a50)

    if a51 and v8 then
        v48[rangeKey] = (v48[rangeKey] or 0) + 1
        local v53 = v48[rangeKey]

        local function send()
            --[[
              name: send
              line: 136
              upvalues:
                v48 (copy, index: 1)
                rangeKey (copy, index: 2)
                v53 (copy, index: 3)
                v8 (ref,  index: 4)
                values (copy, index: 5)
            ]]
            if v48[rangeKey] == v53 and not v8.State.Mock then
                v8.Remotes.Invoke("ProfileAction", "SetSetting", rangeKey, math.floor((values[rangeKey] * 1000) + 0.5) / 1000)
            end
        end

        if a51 ~= "now" then
            task.delay(0.8, send)
        else
            task.spawn(send)
        end
    end
end

local v55 = {}
local v56 = false
local timestamp = -math.huge

local function flushKeybinds()
    --[[
      name: flushKeybinds
      line: 153
      upvalues:
        v56 (ref,  index: 1)
        v8 (ref,  index: 2)
        v55 (copy, index: 3)
        timestamp (ref,  index: 4)
        flushKeybinds (copy, index: 5)
        Keybinds (copy, index: 6)
    ]]
    v56 = false

    if not v8 or v8.State.Mock or next(v55) == nil then
        table.clear(v55)
        return
    end

    local v59 = 2.2 - (os.clock() - timestamp)

    if 0 < v59 then
        v56 = true
        task.delay(v59, flushKeybinds)

        return
    end

    local v60 = {}
    local v61 = {}

    for v62 in v55 do
        v60[v62] = Keybinds.SettingValueFor(v62)
        table.insert(v61, v62)

        if 24 <= #v61 then
            break
        end
    end

    for _, v64 in v61 do
        v55[v64] = nil
    end

    timestamp = os.clock()
    local v65, v66 = v8.Remotes.Invoke("ProfileAction", "SetSettings", v60)

    if next(v55) ~= nil and not v56 then
        v56 = true
        task.delay(2.3, flushKeybinds)
    end

    if not v65 or v66 ~= true then
        for _, v68 in v61 do
            v55[v68] = true
        end

        if not v56 then
            v56 = true
            task.delay(3, flushKeybinds)
        end
    end
end

local timestamp2 = -math.huge

local function queueKeys(a71, a72)
    --[[
      name: queueKeys
      line: 195
      upvalues:
        timestamp2 (ref,  index: 1)
        v55 (copy, index: 2)
        v56 (ref,  index: 3)
        flushKeybinds (copy, index: 4)
    ]]
    timestamp2 = os.clock()

    for _, v74 in a72 do
        v55[a71 .. v74] = true
    end

    if not v56 then
        v56 = true
        task.delay(0.6, flushKeybinds)
    end
end

function v5.SaveKeybinds(a75)
    --[[
      name: SaveKeybinds
      line: 205
      upvalues:
        Keybinds (copy, index: 1)
        timestamp2 (ref,  index: 2)
        v55 (copy, index: 3)
        v56 (ref,  index: 4)
        flushKeybinds (copy, index: 5)
    ]]
    local prefix = Keybinds.PREFIX
    timestamp2 = os.clock()

    for _, v78 in a75 do
        v55[prefix .. v78] = true
    end

    if not v56 then
        v56 = true
        task.delay(0.6, flushKeybinds)
    end
end

function v5.SavePadBinds(a79)
    --[[
      name: SavePadBinds
      line: 209
      upvalues:
        Keybinds (copy, index: 1)
        timestamp2 (ref,  index: 2)
        v55 (copy, index: 3)
        v56 (ref,  index: 4)
        flushKeybinds (copy, index: 5)
    ]]
    local padPrefix = Keybinds.PAD_PREFIX
    timestamp2 = os.clock()

    for _, v82 in a79 do
        v55[padPrefix .. v82] = true
    end

    if not v56 then
        v56 = true
        task.delay(0.6, flushKeybinds)
    end
end

function v5.PendingKeys()
    --[[
      name: PendingKeys
      line: 213
      upvalues:
        v55 (copy, index: 1)
    ]]
    local v83 = {}

    for v84 in v55 do
        table.insert(v83, v84)
    end

    table.sort(v83)

    return v83
end

function v5.Init(a85)
    --[[
      name: Init
      line: 222
      upvalues:
        v8 (ref,  index: 1)
        v7 (ref,  index: 2)
        Keybinds (copy, index: 3)
        v5 (copy, index: 4)
        values (copy, index: 5)
        apply (copy, index: 6)
        v55 (copy, index: 7)
        v56 (ref,  index: 8)
        timestamp2 (ref,  index: 9)
        replicatedStorage (copy, index: 10)
    ]]
    local result
    v8 = a85

    local function fromProfile(a88)
        --[[
          name: fromProfile
          line: 224
          upvalues:
            v7 (ref,  index: 1)
            Keybinds (copy, index: 2)
            v5 (copy, index: 3)
            values (copy, index: 4)
            apply (copy, index: 5)
        ]]
        if v7 or type(a88) ~= "table" or type(a88.settings) ~= "table" then
            return
        end

        v7 = true
        Keybinds.Load(a88.settings)

        for settingKey in v5.DEFAULTS do
            local setting = a88.settings[settingKey]

            if type(setting) == "number" then
                values[settingKey] = setting
            end
        end

        for valueKey in v5.DEFAULTS do
            apply(valueKey)
            v5.Changed:Fire(valueKey, values[valueKey])
        end
    end

    a85.State.ProfileChanged:Connect(fromProfile)

    if a85.State.HasProfile then
        fromProfile(a85.State.Profile)
    end

    a85.State.ProfileChanged:Connect(
        function(a92)
            --[[
              line: 247
              upvalues:
                v7 (ref,  index: 1)
                v55 (copy, index: 2)
                v56 (ref,  index: 3)
                timestamp2 (ref,  index: 4)
                Keybinds (copy, index: 5)
            ]]
            if v7
                and type(a92) == "table"
                and type(a92.settings) == "table"
                and next(v55) == nil
                and not v56
                and 6 < os.clock() - timestamp2
            then
                Keybinds.Load(a92.settings)
            end
        end
    )

    local camera = replicatedStorage.Shared:FindFirstChild("Camera")

    if not camera or not camera:IsA("ModuleScript") then
        result = nil
    else
        local success, result2 = pcall(require, camera)

        if not success or type(result2) ~= "table" then
            result = nil
        else
            result = result2
        end
    end

    if result and typeof(result.FirstPersonChanged) == "RBXScriptSignal" then
        result.FirstPersonChanged:Connect(
            function(a96)
                --[[
                  line: 257
                  upvalues:
                    v5 (copy, index: 1)
                ]]
                local v97 = 0.5 <= v5.Get("firstPerson")

                if v97 ~= a96 then
                    local set = v5.Set
                    local v99 = a96 and 1 or 0
                    set("firstPerson", v99, true)
                end
            end
        )
    end

    task.delay(
        3,
        function()
            --[[
              line: 264
              upvalues:
                v5 (copy, index: 1)
                apply (copy, index: 2)
            ]]
            for valueKey in v5.DEFAULTS do
                apply(valueKey)
            end
        end
    )
end

return v5