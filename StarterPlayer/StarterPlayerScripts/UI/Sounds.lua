local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local SoundService_upv_1 = game:GetService("SoundService")
local tbl_1 = {}
local tbl_upv_2 = {Hover = 0.2, Coin = 0.45, Close = 0.35, Select = 0.45, Notify = 0.35, Open = 0.4, Defeat = 0.5, LevelUp = 0.55, Fanfare = 0.6, Purchase = 0.55, Tick = 0.3, Whoosh = 0.5, Stinger = 0.5, Error = 0.5, Click = 0.45}
local u1 = nil
local u2 = 0
local function getSfx()
    --[[
      name: getSfx
      line: 31
      upvalues:
        u1 (ref,  index: 1)
        u2 (ref,  index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    if u1 then
        return u1
    end
    if os.clock() - u2 < 5 then
        return nil
    end
    u2 = os.clock()
    local Shared_1 = ReplicatedStorage_upv_1:FindFirstChild("Shared")
    local v1 = Shared_1 and (Shared_1:FindFirstChild("Sfx"))
    if v1 and v1:IsA("ModuleScript") then
        local success_1, v2 = pcall(require, v1)
        if success_1 and type(v2) == "table" and type(v2.PlayUI) == "function" then
            u1 = v2
        end
    end
    return u1
end
local function group()
    --[[
      name: group
      line: 59
      upvalues:
        SoundService_upv_1 (copy, index: 1)
    ]]
    local v3 = nil
    for _, value_1 in {"UI", "SFX"} do
        v3 = SoundService_upv_1:FindFirstChild(value_1)
        if not (v3) or not (v3:IsA("SoundGroup")) then
            continue
        end
        return v3
    end
    return nil
end
local tbl_upv_3 = {}
local function template(a1)
    --[[
      name: template
      line: 51
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
    ]]
    local Assets_1 = ReplicatedStorage_upv_1:FindFirstChild("Assets")
    local v4 = Assets_1 and (Assets_1:FindFirstChild("Sounds"))
    local v5 = v4 and (v4:FindFirstChild("UI"))
    local v6 = v5 and (v5:FindFirstChild(a1))
    if v6 and v6:IsA("Sound") then
        return v6
    end
    return nil
end
function tbl_1.Play(a1, a2)
    --[[
      name: Play
      line: 72
      upvalues:
        tbl_upv_3 (copy, index: 1)
        getSfx (copy, index: 2)
        template (copy, index: 3)
        tbl_upv_2 (copy, index: 4)
        group (copy, index: 5)
        SoundService_upv_1 (copy, index: 6)
    ]]
    local v7 = os.clock()
    local v8 = (a2 and (a2.minGap)) or (((a1 == "Hover") and 0.05) or (((a1 ~= "Tick") and 0) or 0.03))
    if v8 > 0 and tbl_upv_3[a1] and v7 - tbl_upv_3[a1] < v8 then
        return
    end
    tbl_upv_3[a1] = v7
    local v9 = getSfx()
    if v9 then
        local v10 = nil
        if a2 then
            if not (a2.volume) and not (a2.pitch) or type(v9.Play) ~= "function" then
                v10 = pcall(v9.PlayUI, "UI/" .. a1)
                if v10 then
                    return
                end
                local v11 = template(a1)
                if not v11 then
                    return
                end
                local u3 = v11:Clone()
                u3.Volume = (a2 and (a2.volume)) or (tbl_upv_2[a1] or 0.5)
                u3.PlaybackSpeed = (a2 and (a2.pitch)) or 1
                u3.SoundGroup = group()
                u3.Parent = SoundService_upv_1
                u3.Ended:Once(
                    function()
                        --[[
                          line: 100
                          upvalues:
                            u3 (copy, index: 1)
                        ]]
                        u3:Destroy()
                    end
                )
                u3:Play()
                task.delay(
                    math.max(u3.TimeLength, 1) + 2,
                    function()
                        --[[
                          line: 104
                          upvalues:
                            u3 (copy, index: 1)
                        ]]
                        if not u3.Parent then
                            return
                        end
                        u3:Destroy()
                    end
                )
                return
            end
            v10 = pcall(v9.Play, "UI/" .. a1, nil, {group = "UI", volume = a2.volume, pitch = a2.pitch})
        else
            v10 = pcall(v9.PlayUI, "UI/" .. a1)
        end
        if v10 then
            return
        end
    end
    local v11 = template(a1)
    if not v11 then
        return
    end
    local u3 = v11:Clone()
    u3.Volume = (a2 and (a2.volume)) or (tbl_upv_2[a1] or 0.5)
    u3.PlaybackSpeed = (a2 and (a2.pitch)) or 1
    u3.SoundGroup = group()
    u3.Parent = SoundService_upv_1
    u3.Ended:Once(
        function()
            --[[
              line: 100
              upvalues:
                u3 (copy, index: 1)
            ]]
            u3:Destroy()
        end
    )
    u3:Play()
    task.delay(
        math.max(u3.TimeLength, 1) + 2,
        function()
            --[[
              line: 104
              upvalues:
                u3 (copy, index: 1)
            ]]
            if not u3.Parent then
                return
            end
            u3:Destroy()
        end
    )
end
return tbl_1