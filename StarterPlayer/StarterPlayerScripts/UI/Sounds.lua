local replicatedStorage = game:GetService("ReplicatedStorage")
local soundService = game:GetService("SoundService")
local v3 = {}
local v4 = {Hover = 0.2, Click = 0.45, Select = 0.45, Open = 0.4, Close = 0.35, Error = 0.5, Purchase = 0.55, Notify = 0.35, Tick = 0.3, Whoosh = 0.5, Coin = 0.45, Fanfare = 0.6, LevelUp = 0.55, Defeat = 0.5, Stinger = 0.5}
local result = nil
local timestamp = 0

local function getSfx()
    --[[
      name: getSfx
      line: 31
      upvalues:
        result (ref,  index: 1)
        timestamp (ref,  index: 2)
        replicatedStorage (copy, index: 3)
    ]]
    if result then
        return result
    end
    if os.clock() - timestamp < 5 then
        return nil
    end

    timestamp = os.clock()
    local shared = replicatedStorage:FindFirstChild("Shared")
    local sfx = shared and shared:FindFirstChild("Sfx")

    if sfx and sfx:IsA("ModuleScript") then
        local success, result2 = pcall(require, sfx)

        if success and type(result2) == "table" and type(result2.PlayUI) == "function" then
            result = result2
        end
    end

    return result
end

local function template(childName: string)
    --[[
      name: template
      line: 51
      upvalues:
        replicatedStorage (copy, index: 1)
    ]]
    local instance = replicatedStorage:FindFirstChild("Assets")
    instance = instance and instance:FindFirstChild("Sounds")
    local ui = instance and instance:FindFirstChild("UI")
    local child = ui and ui:FindFirstChild(childName)

    if child and child:IsA("Sound") then
        return child
    end

    return nil
end

local function group()
    --[[
      name: group
      line: 59
      upvalues:
        soundService (copy, index: 1)
    ]]
    local child

    for _, childName in {"UI", "SFX"} do
        child = soundService:FindFirstChild(childName)

        if child and child:IsA("SoundGroup") then
            return child
        end
    end

    return nil
end

local v21 = {}

function v3.Play(key: string, a23)
    --[[
      name: Play
      line: 72
      upvalues:
        v21 (copy, index: 1)
        getSfx (copy, index: 2)
        template (copy, index: 3)
        v4 (copy, index: 4)
        group (copy, index: 5)
        soundService (copy, index: 6)
    ]]
    local timestamp = os.clock()
    local v25 = a23 and a23.minGap or key ~= "Hover" and (key ~= "Tick" and 0 or 0.03) or 0.05

    if 0 < v25 and v21[key] and timestamp - v21[key] < v25 then
        return
    end

    v21[key] = timestamp

    if const sfx = getSfx() then
        local success

        if not a23 or not a23.volume and not a23.pitch or type(sfx.Play) ~= "function" then
            success = pcall(sfx.PlayUI, "UI/" .. key)
        else
            success = pcall(sfx.Play, "UI/" .. key, nil, {group = "UI", volume = a23.volume, pitch = a23.pitch})
        end

        if success then
            return
        end
    end

    local instance = template(key)
    if not instance then
        return
    end

    local instance2 = instance:Clone()
    instance2.Volume = a23 and a23.volume or v4[key] or 0.5
    instance2.PlaybackSpeed = a23 and a23.pitch or 1
    instance2.SoundGroup = group()
    instance2.Parent = soundService
    instance2.Ended:Once(
        function()
            --[[
              line: 100
              upvalues:
                instance2 (copy, index: 1)
            ]]
            instance2:Destroy()
        end
    )
    instance2:Play()

    task.delay(
        math.max(instance2.TimeLength, 1) + 2,
        function()
            --[[
              line: 104
              upvalues:
                instance2 (copy, index: 1)
            ]]
            if instance2.Parent then
                instance2:Destroy()
            end
        end
    )
end

return v3