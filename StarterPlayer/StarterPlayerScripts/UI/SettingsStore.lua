local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local SoundService_upv_1 = game:GetService("SoundService")
local Signal_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Signal"))
local Keybinds_upv_1 = require(ReplicatedStorage_upv_1.Shared:WaitForChild("Keybinds"))
local tbl_upv_1 = {}
tbl_upv_1.Changed = Signal_1.new()
tbl_upv_1.DEFAULTS = {padSensitivity = 1, aimSensitivity = 1, mmRanked = 1, padInvertY = 0, mmRegions = 0, sensitivity = 1, aimZoom = 1, modeSel = 0, aimAssist = 1, mmAutoRegion = 1, mmNoBots = 0, friendsOnlyInvites = 0, sfx = 1, fov = 70, mmPremium = 0, music = 0.6, viewBobbing = 1, firstPerson = 0}
tbl_upv_1.MEMORY = {modeSel = true}
tbl_upv_1.RANGES = {sensitivity = {0.05, 3}, padSensitivity = {0.2, 3}, padInvertY = {0, 1}, fov = {60, 100}, aimZoom = {0, 1}, aimSensitivity = {0.2, 3}, music = {0, 1}, sfx = {0, 1}, firstPerson = {0, 1}, viewBobbing = {0, 1}, friendsOnlyInvites = {0, 1}, aimAssist = {0, 1}, mmNoBots = {0, 1}, mmAutoRegion = {0, 1}, mmRegions = {0, 63}, mmPremium = {0, 1}, mmRanked = {0, 1}, modeSel = {0, 7}}
local u1 = table.clone(tbl_upv_1.DEFAULTS)
local u2 = false
local u3 = nil
local function shared(a1)
    --[[
      name: shared
      line: 49
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    local v1 = ReplicatedStorage_upv_1.Shared:FindFirstChild(a1)
    if v1 and v1:IsA("ModuleScript") then
        local success_1, v2 = pcall(require, v1)
        if success_1 and type(v2) == "table" then
            return v2
        end
    end
    return nil
end
local tbl_upv_2 = {}
local function setGroup(a1, a2)
    --[[
      name: setGroup
      line: 61
      upvalues:
        SoundService_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v3 = SoundService_upv_1:FindFirstChild(a1)
    if not v3 or not v3:IsA("SoundGroup") then
        return
    end
    if not (tbl_upv_2[v3]) then
        tbl_upv_2[v3] = v3.Volume
    end
    v3.Volume = tbl_upv_2[v3] * a2
end
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 111
      upvalues:
        u1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    return u1[a1] or (tbl_upv_1.DEFAULTS[a1] or 0)
end
local tbl_upv_3 = {}
local function apply(a1)
    --[[
      name: apply
      line: 71
      upvalues:
        u1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        SoundService_upv_1 (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
    ]]
    local v4 = u1[a1]
    if a1 == "sensitivity" or a1 == "fov" or a1 == "aimZoom" then
        local v5 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
        local v6
        if v5 then
            v5:IsA("ModuleScript")
        end
        v6 = nil
        if v6 then
            if a1 == "sensitivity" then
                v5 = v6.SetSensitivity
            elseif a1 == "fov" then
                v5 = v6.SetFOV
            elseif a1 ~= "aimZoom" then
                v5 = v6.SetAimSensitivity
            else
                v5 = v6.SetAimZoom
            end
        else
            v5 = v6
        end
        if type(v5) ~= "function" then
            return
        end
        pcall(v5, v4)
    else
        local v7 = nil
        if a1 == "aimSensitivity" then
            v7 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
            local v6
            if v7 then
                v7:IsA("ModuleScript")
            end
            v6 = nil
            if v6 then
                if a1 == "sensitivity" then
                    v7 = v6.SetSensitivity
                elseif a1 == "fov" then
                    v7 = v6.SetFOV
                elseif a1 ~= "aimZoom" then
                    v7 = v6.SetAimSensitivity
                else
                    v7 = v6.SetAimZoom
                end
            else
                v7 = v6
            end
            if type(v7) ~= "function" then
                return
            end
            pcall(v7, v4)
        elseif a1 == "padSensitivity" then
            v7 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
            local v8
            if v7 then
                v7:IsA("ModuleScript")
            end
            v8 = nil
            local v9 = v8 and (v8.PadLook)
            if type(v9) ~= "table" then
                return
            end
            if a1 ~= "padSensitivity" then
                pcall(v9.SetInvertY, v4 >= 0.5)
            else
                pcall(v9.SetSensitivity, v4)
            end
        else
            local v10 = nil
            if a1 == "padInvertY" then
                v7 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
                local v8
                if v7 then
                    v7:IsA("ModuleScript")
                end
                v8 = nil
                local v9 = v8 and (v8.PadLook)
                if type(v9) ~= "table" then
                    return
                end
                if a1 ~= "padSensitivity" then
                    pcall(v9.SetInvertY, v4 >= 0.5)
                else
                    pcall(v9.SetSensitivity, v4)
                end
            elseif a1 == "firstPerson" or a1 == "viewBobbing" then
                v10 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
                local v11
                if v10 then
                    v10:IsA("ModuleScript")
                end
                v11 = nil
                if v11 then
                    if a1 == "firstPerson" then
                        v10 = v11.SetFirstPerson
                    elseif a1 ~= "aimAssist" then
                        v10 = v11.SetViewBobbing
                    else
                        v10 = v11.SetAimAssist
                    end
                else
                    v10 = v11
                end
                if type(v10) ~= "function" then
                    return
                end
                pcall(v10, v4 >= 0.5)
            else
                local v12 = nil
                if a1 == "aimAssist" then
                    v10 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
                    local v11
                    if v10 then
                        v10:IsA("ModuleScript")
                    end
                    v11 = nil
                    if v11 then
                        if a1 == "firstPerson" then
                            v10 = v11.SetFirstPerson
                        elseif a1 ~= "aimAssist" then
                            v10 = v11.SetViewBobbing
                        else
                            v10 = v11.SetAimAssist
                        end
                    else
                        v10 = v11
                    end
                    if type(v10) ~= "function" then
                        return
                    end
                    pcall(v10, v4 >= 0.5)
                elseif a1 == "music" or a1 == "sfx" then
                    v12 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Sfx")
                    local v13
                    if v12 then
                        v12:IsA("ModuleScript")
                    end
                    for _, value_1 in ((a1 ~= "music") and {"SFX", "UI", "Ambient"}) or {"Music"} do
                        if not (v13) or type(v13.SetVolume) ~= "function" then
                            local v14 = SoundService_upv_1:FindFirstChild(value_1)
                            if not (v14) or not (v14:IsA("SoundGroup")) then
                                continue
                            end
                            if not (tbl_upv_2[v14]) then
                                tbl_upv_2[v14] = v14.Volume
                            end
                            v14.Volume = tbl_upv_2[v14] * v4
                        end
                        pcall(v13.SetVolume, value_1, v4)
                    end
                end
            end
        end
    end
end
function tbl_upv_1.Set(a1, a2, a3)
    --[[
      name: Set
      line: 118
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        apply (copy, index: 3)
        u3 (ref,  index: 4)
        tbl_upv_3 (copy, index: 5)
    ]]
    local v15 = tbl_upv_1.RANGES[a1]
    if v15 then
        a2 = math.clamp(a2, v15[1], v15[2])
    end
    u1[a1] = a2
    apply(a1)
    tbl_upv_1.Changed:Fire(a1, a2)
    if not a3 then
        return
    end
    if u3 then
        tbl_upv_3[a1] = (tbl_upv_3[a1] or 0) + 1
        local u4 = tbl_upv_3[a1]
        local function send()
            --[[
              name: send
              line: 129
              upvalues:
                tbl_upv_3 (copy, index: 1)
                a1 (copy, index: 2)
                u4 (copy, index: 3)
                u3 (ref,  index: 4)
                u1 (copy, index: 5)
            ]]
            if tbl_upv_3[a1] ~= u4 or (u3.State.Mock) then
                return
            end
            u3.Remotes.Invoke("ProfileAction", "SetSetting", a1, math.floor((u1[a1] * 1000) + 0.5) / 1000)
        end
        if a3 ~= "now" then
            task.delay(0.8, send)
        else
            task.spawn(send)
        end
    end
end
local tbl_upv_4 = {}
local u5 = false
local u6 = -math.huge
local function flushKeybinds()
    --[[
      name: flushKeybinds
      line: 146
      upvalues:
        u5 (ref,  index: 1)
        u3 (ref,  index: 2)
        tbl_upv_4 (copy, index: 3)
        u6 (ref,  index: 4)
        flushKeybinds (copy, index: 5)
        Keybinds_upv_1 (copy, index: 6)
    ]]
    u5 = false
    if u3 and not u3.State.Mock and next(tbl_upv_4) ~= nil then
        local v16 = 2.2 - (os.clock() - u6)
        if v16 > 0 then
            u5 = true
            task.delay(v16, flushKeybinds)
        else
            local tbl_5 = {}
            local tbl_6 = {}
            for key_1 in tbl_upv_4 do
                tbl_5[key_1] = Keybinds_upv_1.SettingValueFor(key_1)
                table.insert(tbl_6, key_1)
                if #tbl_6 >= 24 then
                    break
                end
            end
            for _, value_2 in tbl_6 do
                tbl_upv_4[value_2] = nil
            end
            u6 = os.clock()
            local v17, v18 = u3.Remotes.Invoke("ProfileAction", "SetSettings", tbl_5)
            if next(tbl_upv_4) ~= nil and not (u5) then
                u5 = true
                task.delay(2.3, flushKeybinds)
            end
            if not v17 or v18 ~= true then
                for _, value_3 in tbl_6 do
                    tbl_upv_4[value_3] = true
                end
                if not (u5) then
                    u5 = true
                    task.delay(3, flushKeybinds)
                end
            end
        end
    else
        table.clear(tbl_upv_4)
    end
end
local u7 = -math.huge
local function queueKeys(a1, a2)
    --[[
      name: queueKeys
      line: 188
      upvalues:
        u7 (ref,  index: 1)
        tbl_upv_4 (copy, index: 2)
        u5 (ref,  index: 3)
        flushKeybinds (copy, index: 4)
    ]]
    u7 = os.clock()
    for _, value_4 in a2 do
        tbl_upv_4[a1 .. value_4] = true
    end
    if (u5) then
        return
    end
    u5 = true
    task.delay(0.6, flushKeybinds)
end
function tbl_upv_1.SaveKeybinds(a1)
    --[[
      name: SaveKeybinds
      line: 198
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        u7 (ref,  index: 2)
        tbl_upv_4 (copy, index: 3)
        u5 (ref,  index: 4)
        flushKeybinds (copy, index: 5)
    ]]
    local PREFIX_1 = Keybinds_upv_1.PREFIX
    u7 = os.clock()
    for _, value_5 in a1 do
        tbl_upv_4[PREFIX_1 .. value_5] = true
    end
    if (u5) then
        return
    end
    u5 = true
    task.delay(0.6, flushKeybinds)
end
function tbl_upv_1.SavePadBinds(a1)
    --[[
      name: SavePadBinds
      line: 202
      upvalues:
        Keybinds_upv_1 (copy, index: 1)
        u7 (ref,  index: 2)
        tbl_upv_4 (copy, index: 3)
        u5 (ref,  index: 4)
        flushKeybinds (copy, index: 5)
    ]]
    local PAD_PREFIX_1 = Keybinds_upv_1.PAD_PREFIX
    u7 = os.clock()
    for _, value_6 in a1 do
        tbl_upv_4[PAD_PREFIX_1 .. value_6] = true
    end
    if (u5) then
        return
    end
    u5 = true
    task.delay(0.6, flushKeybinds)
end
function tbl_upv_1.PendingKeys()
    --[[
      name: PendingKeys
      line: 206
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    local tbl_7 = {}
    for key_2 in tbl_upv_4 do
        table.insert(tbl_7, key_2)
    end
    table.sort(tbl_7)
    return tbl_7
end
function tbl_upv_1.Init(a1)
    --[[
      name: Init
      line: 215
      upvalues:
        u3 (ref,  index: 1)
        u2 (ref,  index: 2)
        Keybinds_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        u1 (copy, index: 5)
        apply (copy, index: 6)
        tbl_upv_4 (copy, index: 7)
        u5 (ref,  index: 8)
        u7 (ref,  index: 9)
        ReplicatedStorage_upv_1 (copy, index: 10)
    ]]
    u3 = a1
    local function fromProfile(a2)
        --[[
          name: fromProfile
          line: 217
          upvalues:
            u2 (ref,  index: 1)
            Keybinds_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
            u1 (copy, index: 4)
            apply (copy, index: 5)
        ]]
        if u2 or type(a2) ~= "table" or type(a2.settings) ~= "table" then
            return
        end
        u2 = true
        Keybinds_upv_1.Load(a2.settings)
        for key_3 in tbl_upv_1.DEFAULTS do
            local v19 = a2.settings[key_3]
            if type(v19) == "number" then
                u1[key_3] = v19
            end
        end
        for key_4 in tbl_upv_1.DEFAULTS do
            apply(key_4)
            tbl_upv_1.Changed:Fire(key_4, u1[key_4])
        end
    end
    a1.State.ProfileChanged:Connect(fromProfile)
    if a1.State.HasProfile then
        fromProfile(a1.State.Profile)
    end
    a1.State.ProfileChanged:Connect(
        function(a3)
            --[[
              line: 240
              upvalues:
                u2 (ref,  index: 1)
                tbl_upv_4 (copy, index: 2)
                u5 (ref,  index: 3)
                u7 (ref,  index: 4)
                Keybinds_upv_1 (copy, index: 5)
            ]]
            if not u2 or type(a3) ~= "table" or type(a3.settings) ~= "table" or next(tbl_upv_4) ~= nil or (u5) or not (os.clock() - u7 > 6) then
                return
            end
            Keybinds_upv_1.Load(a3.settings)
        end
    )
    local Camera_1 = ReplicatedStorage_upv_1.Shared:FindFirstChild("Camera")
    if Camera_1 then
        Camera_1:IsA("ModuleScript")
    end
    fromProfile = nil
    if fromProfile and typeof(fromProfile.FirstPersonChanged) == "RBXScriptSignal" then
        fromProfile.FirstPersonChanged:Connect(
            function(a4)
                --[[
                  line: 250
                  upvalues:
                    tbl_upv_1 (copy, index: 1)
                ]]
                local v20 = tbl_upv_1.Get("firstPerson") >= 0.5
                if v20 == a4 then
                    return
                end
                tbl_upv_1.Set("firstPerson", (a4 and 1) or 0, true)
            end
        )
    end
    task.delay(
        3,
        function()
            --[[
              line: 257
              upvalues:
                tbl_upv_1 (copy, index: 1)
                apply (copy, index: 2)
            ]]
            for key_5 in tbl_upv_1.DEFAULTS do
                apply(key_5)
            end
        end
    )
end
return tbl_upv_1