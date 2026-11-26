local drop
local attributeName
local runService = game:GetService("RunService")
local v4 = {}
local isStudio = runService:IsStudio()

if runService:IsServer() then
    attributeName = "DroppedServer"
else
    attributeName = "DroppedClient"
end

local patterns = {"^rbxassetid://%d+$", "^rbxasset://[%w_%-%./]+$", "^https?://www%.roblox%.com/[Aa]sset/?%?[Ii][Dd]=%d+$", "^https?://assetdelivery%.roblox%.com/v1/[Aa]sset/?%?[Ii][Dd]=%d+$"}

function v4.IsContentId(text: string)
    --[[
      name: IsContentId
      line: 48
      upvalues:
        patterns (copy, index: 1)
    ]]
    for _, pattern in patterns do
        if string.match(text, pattern) then
            return true
        end
    end

    return false
end

function v4.IsText(text: string)
    --[[
      name: IsText
      line: 57
    ]]
    return string.find(text, "://", 1, true) == nil
end

local v11 = setmetatable({}, {__mode = "k"})

local function idOf(a13)
    --[[
      name: idOf
      line: 63
    ]]
    local success, animationId = pcall(
        function()
            --[[
              line: 64
              upvalues:
                a13 (copy, index: 1)
            ]]
            local animation = a13.Animation
            return animation and animation.AnimationId
        end
    )

    if success and type(animationId) == "string" then
        return animationId
    end

    return nil
end

drop = function(a17)
    --[[
      name: drop
      line: 71
      upvalues:
        isStudio (copy, index: 1)
        attributeName (copy, index: 2)
    ]]
    if isStudio then
        script:SetAttribute(attributeName, (script:GetAttribute(attributeName) or 0) + 1)
    end

    pcall(
        function()
            --[[
              line: 75
              upvalues:
                a17 (copy, index: 1)
            ]]
            a17:Stop(0)
        end
    )
    pcall(
        function()
            --[[
              line: 78
              upvalues:
                a17 (copy, index: 1)
            ]]
            a17:Destroy()
        end
    )
end

function v4.Watch(key, callback)
    --[[
      name: Watch
      line: 83
      upvalues:
        v11 (copy, index: 1)
        v4 (copy, index: 2)
        drop (copy, index: 3)
    ]]
    if v11[key] then
        return
    end

    v11[key] = true

    for _, playingAnimationTrack in key:GetPlayingAnimationTracks() do
        local animationId

        local success, animationId2 = pcall(
            function()
                --[[
                  line: 64
                  upvalues:
                    playingAnimationTrack (copy, index: 1)
                ]]
                local animation = playingAnimationTrack.Animation
                return animation and animation.AnimationId
            end
        )

        if not success or type(animationId2) ~= "string" then
            animationId = nil
        else
            animationId = animationId2
        end

        if animationId then
            if not v4.IsText(animationId) then
                continue
            end

            drop(playingAnimationTrack)

            if not callback then
                continue
            end

            callback(playingAnimationTrack, "text id")
        end
    end

    key.AnimationPlayed:Connect(
        function(a26)
            --[[
              name: check
              line: 88
              upvalues:
                v4 (copy, index: 1)
                key (copy, index: 2)
                drop (copy, index: 3)
                callback (copy, index: 4)
            ]]
            local animationId
            local v28

            local success, animationId2 = pcall(
                function()
                    --[[
                      line: 64
                      upvalues:
                        a26 (copy, index: 1)
                    ]]
                    local animation = a26.Animation
                    return animation and animation.AnimationId
                end
            )

            if not success or type(animationId2) ~= "string" then
                animationId = nil
            else
                animationId = animationId2
            end

            local v32 = nil

            if animationId and v4.IsText(animationId) then
                v28 = "text id"
            elseif not (a26.WeightTarget <= 0.01) then
                v28 = v32
            else
                v28 = 48 < #key:GetPlayingAnimationTracks() and "over budget" or v32
            end

            if v28 then
                drop(a26)

                if callback then
                    callback(a26, v28)
                end
            end
        end
    )
end

return v4