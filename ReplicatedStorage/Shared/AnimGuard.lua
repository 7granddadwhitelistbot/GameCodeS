local RunService_1 = game:GetService("RunService")
local tbl_upv_1 = {}
local u1 = RunService_1:IsStudio()
local u2 = ((RunService_1:IsServer()) and "DroppedServer") or "DroppedClient"
local tbl_upv_2 = {"^rbxassetid://%d+$", "^rbxasset://[%w_%-%./]+$", "^https?://www%.roblox%.com/[Aa]sset/?%?[Ii][Dd]=%d+$", "^https?://assetdelivery%.roblox%.com/v1/[Aa]sset/?%?[Ii][Dd]=%d+$"}
function tbl_upv_1.IsContentId(a1)
    --[[
      name: IsContentId
      line: 48
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    for _, value_1 in tbl_upv_2 do
        if not (string.match(a1, value_1)) then
            continue
        end
        return true
    end
    return false
end
function tbl_upv_1.IsText(a1)
    --[[
      name: IsText
      line: 57
    ]]
    local v1 = string.find(a1, "://", 1, true) == nil
    return v1
end
local u3 = setmetatable({}, {__mode = "k"})
local function idOf(a1)
    --[[
      name: idOf
      line: 63
    ]]
    local success_1, v2 = pcall(function() end)
    if success_1 and type(v2) == "string" then
        return v2
    end
    return nil
end
local function drop(a1)
    --[[
      name: drop
      line: 71
      upvalues:
        u1 (copy, index: 1)
        u2 (copy, index: 2)
    ]]
    if u1 then
        script:SetAttribute(u2, (script:GetAttribute(u2) or 0) + 1)
    end
    pcall(
        function()
            --[[
              line: 75
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:Stop(0)
        end
    )
    pcall(
        function()
            --[[
              line: 78
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:Destroy()
        end
    )
end
function tbl_upv_1.Watch(a1, a2)
    --[[
      name: Watch
      line: 83
      upvalues:
        u3 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        drop (copy, index: 3)
    ]]
    if u3[a1] then
        return
    end
    u3[a1] = true
    local v3 = nil
    for _, value_upv_2 in a1:GetPlayingAnimationTracks() do
        local success_2, v4 = pcall(
            function()
                --[[
                  line: 64
                  upvalues:
                    value_upv_2 (copy, index: 1)
                ]]
                local Animation_1 = value_upv_2.Animation
                return Animation_1 and (Animation_1.AnimationId)
            end
        )
        if not (success_2) or type(v4) ~= "string" then
            v3 = nil
            if not (v3) then
                continue
            end
            local v5 = tbl_upv_1.IsText(v3)
            if not (v5) then
                continue
            end
            drop(value_upv_2)
            if a2 then
                a2(value_upv_2, "text id")
                continue
            end
        end
        v3 = v4
        if not (v3) then
            continue
        end
        local v5 = tbl_upv_1.IsText(v3)
        if not (v5) then
            continue
        end
        drop(value_upv_2)
        if a2 then
            a2(value_upv_2, "text id")
        end
    end
    local function check(a3)
        --[[
          name: check
          line: 88
          upvalues:
            tbl_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            drop (copy, index: 3)
            a2 (copy, index: 4)
        ]]
        local v6, v7 = pcall(function() end)
        local v8 = not (v6) or type(v7) ~= "string" or v7
        v6 = nil
        if (v8) and (tbl_upv_1.IsText(v8)) then
            v6 = "text id"
        elseif a3.WeightTarget <= 0.01 then
            v6 = ((#a1:GetPlayingAnimationTracks() > 48) and "over budget") or v6
        end
        if not v6 then
            return
        end
        drop(a3)
        if not a2 then
            return
        end
        a2(a3, v6)
    end
    a1.AnimationPlayed:Connect(check)
end
return tbl_upv_1