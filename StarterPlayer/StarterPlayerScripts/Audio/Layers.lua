local RunService_upv_1 = game:GetService("RunService")
local SoundService_upv_1 = game:GetService("SoundService")
local tbl_1 = {}
local tbl_upv_2 = {}
local u1 = nil
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 26
      upvalues:
        u1 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    u1 = a1
    RunService_upv_1.Heartbeat:Connect(
        function(a2)
            --[[
              line: 28
              upvalues:
                tbl_upv_2 (copy, index: 1)
            ]]
            for _, value_1 in tbl_upv_2 do
                value_1.current = value_1.current + ((value_1.target - value_1.current) * (1 - math.exp(-value_1.rate * a2)))
                if math.abs(value_1.target - value_1.current) < 0.002 then
                    value_1.current = value_1.target
                end
                local sound_1 = value_1.sound
                if not (value_1.current <= 0.001) or value_1.target ~= 0 then
                    if value_1.target > 0 and not (sound_1.IsPlaying) and not (value_1.ended) then
                        if value_1.started then
                            sound_1:Resume()
                        else
                            value_1.started = true
                            sound_1:Play()
                        end
                    end
                    local v1 = value_1.base * value_1.current
                    if math.abs(sound_1.Volume - v1) > 1e-04 then
                        sound_1.Volume = v1
                        continue
                    end
                end
                value_1.current = 0
                if sound_1.IsPlaying then
                    sound_1:Pause()
                end
                local v1 = value_1.base * value_1.current
                if math.abs(sound_1.Volume - v1) > 1e-04 then
                    sound_1.Volume = v1
                end
            end
        end
    )
end
function tbl_1.Get(a1, a2, a3)
    --[[
      name: Get
      line: 58
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u1 (ref,  index: 2)
        SoundService_upv_1 (copy, index: 3)
    ]]
    local v2 = tbl_upv_2[a1]
    if v2 and v2.name == a2 then
        return v2
    end
    if v2 then
        v2.sound:Destroy()
        tbl_upv_2[a1] = nil
    end
    local u2 = u1.Clone(a2)
    if not u2 then
        return nil
    end
    u2.Name = "Layer_" .. a1
    local Volume_1 = u2.Volume
    u2.Volume = 0
    u2.Parent = SoundService_upv_1
    local tbl_upv_3 = {current = 0, started = false, ended = false, target = 0}
    tbl_upv_3.key = a1
    tbl_upv_3.name = a2
    tbl_upv_3.sound = u2
    tbl_upv_3.base = Volume_1
    tbl_upv_3.rate = a3 or 0.8
    u2.Ended:Connect(
        function()
            --[[
              line: 76
              upvalues:
                u2 (copy, index: 1)
                tbl_upv_3 (copy, index: 2)
            ]]
            if (u2.Looped) then
                return
            end
            tbl_upv_3.ended = true
        end
    )
    tbl_upv_2[a1] = tbl_upv_3
    return tbl_upv_3
end
function tbl_1.Find(a1)
    --[[
      name: Find
      line: 85
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    return tbl_upv_2[a1]
end
function tbl_1.SetTarget(a1, a2, a3)
    --[[
      name: SetTarget
      line: 89
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v3 = tbl_upv_2[a1]
    if not v3 then
        return
    end
    v3.target = math.clamp(a2, 0, 2)
    if not a3 then
        return
    end
    v3.rate = a3
end
function tbl_1.Restart(a1, a2)
    --[[
      name: Restart
      line: 100
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v4 = tbl_upv_2[a1]
    if not v4 then
        return
    end
    v4.ended = false
    v4.started = true
    v4.sound.TimePosition = 0
    v4.sound:Play()
    v4.target = a2 or (v4.target)
end
function tbl_1.FadeAll(a1, a2)
    --[[
      name: FadeAll
      line: 113
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    for key_1, value_2 in tbl_upv_2 do
        if string.sub(key_1, 1, #a1) == a1 and (not (a2) or not (a2[key_1])) then
            value_2.target = 0
        end
    end
end
function tbl_1.Audible(a1)
    --[[
      name: Audible
      line: 122
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_4 = {}
    for key_2, value_3 in tbl_upv_2 do
        if string.sub(key_2, 1, #a1) ~= a1 or not (value_3.sound.IsPlaying) then
            continue
        end
        if value_3.current > 0.02 then
            table.insert(tbl_4, value_3)
        end
    end
    table.sort(
        tbl_4,
        function(a2, a3)
            --[[
              line: 129
            ]]
            return a3.current < a2.current
        end
    )
    return tbl_4
end
function tbl_1.Debug()
    --[[
      name: Debug
      line: 135
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local tbl_5 = {}
    for key_3, value_4 in tbl_upv_2 do
        table.insert(tbl_5, string.format("%s=%s %.2f/%.2f%s", key_3, value_4.name, value_4.current, value_4.target, ((value_4.sound.IsPlaying) and " playing") or ""))
    end
    table.sort(tbl_5)
    return tbl_5
end
return tbl_1