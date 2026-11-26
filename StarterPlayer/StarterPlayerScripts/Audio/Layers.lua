local runService = game:GetService("RunService")
local soundService = game:GetService("SoundService")
local v3 = {}
local v4 = {}
local v5 = nil

function v3.Init(a6)
    --[[
      name: Init
      line: 26
      upvalues:
        v5 (ref,  index: 1)
        runService (copy, index: 2)
        v4 (copy, index: 3)
    ]]
    v5 = a6

    runService.Heartbeat:Connect(
        function(deltaTime: number)
            --[[
              line: 28
              upvalues:
                v4 (copy, index: 1)
            ]]
            for _, v9 in v4 do
                local v10 = 1 - math.exp(-v9.rate * deltaTime)
                v9.current += ((v9.target - v9.current) * v10)

                if math.abs(v9.target - v9.current) < 0.002 then
                    v9.current = v9.target
                end

                local sound = v9.sound

                if v9.current <= 0.001 and v9.target == 0 then
                    v9.current = 0

                    if sound.IsPlaying then
                        sound:Pause()
                    end
                elseif 0 < v9.target and not sound.IsPlaying and not v9.ended then
                    if v9.started then
                        sound:Resume()
                    else
                        v9.started = true
                        sound:Play()
                    end
                end

                local volume = v9.base * v9.current

                if 1e-04 < math.abs(sound.Volume - volume) then
                    sound.Volume = volume
                end
            end
        end
    )
end

function v3.Get(key, name, a15)
    --[[
      name: Get
      line: 58
      upvalues:
        v4 (copy, index: 1)
        v5 (ref,  index: 2)
        soundService (copy, index: 3)
    ]]
    local v16 = v4[key]

    if v16 and v16.name == name then
        return v16
    end

    if v16 then
        v16.sound:Destroy()
        v4[key] = nil
    end

    local sound = v5.Clone(name)
    if not sound then
        return nil
    end

    sound.Name = "Layer_" .. key
    local volume = sound.Volume
    sound.Volume = 0
    sound.Parent = soundService
    local v19 = {current = 0, target = 0, ended = false, started = false, key = key, name = name, sound = sound, base = volume, rate = a15
        or 0.8}

    sound.Ended:Connect(
        function()
            --[[
              line: 76
              upvalues:
                sound (copy, index: 1)
                v19 (copy, index: 2)
            ]]
            if not sound.Looped then
                v19.ended = true
            end
        end
    )

    v4[key] = v19

    return v19
end

function v3.Find(key)
    --[[
      name: Find
      line: 85
      upvalues:
        v4 (copy, index: 1)
    ]]
    return v4[key]
end

function v3.SetTarget(key, a22: number, rate)
    --[[
      name: SetTarget
      line: 89
      upvalues:
        v4 (copy, index: 1)
    ]]
    if const v24 = v4[key] then
        v24.target = math.clamp(a22, 0, 2)

        if rate then
            v24.rate = rate
        end
    end
end

function v3.Restart(key, a26)
    --[[
      name: Restart
      line: 100
      upvalues:
        v4 (copy, index: 1)
    ]]
    local v27 = v4[key]
    if not v27 then
        return
    end

    v27.ended = false
    v27.started = true
    v27.sound.TimePosition = 0
    v27.sound:Play()
    v27.target = a26 or v27.target
end

function v3.FadeAll(a28, a29)
    --[[
      name: FadeAll
      line: 113
      upvalues:
        v4 (copy, index: 1)
    ]]
    for text, v31 in v4 do
        if string.sub(text, 1, #a28) == a28 then
            if not a29 or not a29[text] then
                v31.target = 0
            end
        end
    end
end

function v3.Audible(a32)
    --[[
      name: Audible
      line: 122
      upvalues:
        v4 (copy, index: 1)
    ]]
    local v33 = {}

    for text, v35 in v4 do
        if string.sub(text, 1, #a32) == a32 then
            if v35.sound.IsPlaying and 0.02 < v35.current then
                table.insert(v33, v35)
            end
        end
    end

    table.sort(
        v33,
        function(left, right)
            --[[
              line: 129
            ]]
            local current = left.current
            return right.current < current
        end
    )

    return v33
end

function v3.Debug()
    --[[
      name: Debug
      line: 135
      upvalues:
        v4 (copy, index: 1)
    ]]
    local v39 = {}

    for v40, v41 in v4 do
        local stringFormat = string.format
        local name = v41.name
        local current = v41.current
        local target = v41.target
        local v46 = v41.sound.IsPlaying and " playing" or ""
        table.insert(v39, stringFormat("%s=%s %.2f/%.2f%s", v40, name, current, target, v46))
    end

    table.sort(v39)

    return v39
end

return v3