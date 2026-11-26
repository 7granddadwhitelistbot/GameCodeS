local remotes
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local isServer = runService:IsServer()

if isServer then
    if const remotes2 = replicatedStorage:FindFirstChild("Remotes") then
        remotes = remotes2
    else
        remotes = Instance.new("Folder")
        remotes.Name = "Remotes"
        remotes.Parent = replicatedStorage
    end
else
    remotes = replicatedStorage:WaitForChild("Remotes")
end

local function get(a7: string, name: string)
    --[[
      name: get
      line: 26
      upvalues:
        remotes (ref,  index: 1)
        isServer (copy, index: 2)
    ]]
    if const child = remotes:FindFirstChild(name) then
        assert(child.ClassName == a7, (`Remote {name} is a {child.ClassName}, expected {a7}`))
        return child
    end

    if isServer then
        local instance = Instance.new(a7)
        instance.Name = name
        instance.Parent = remotes
        return instance
    end

    local child2 = remotes:WaitForChild(name, 15)
    if not child2 then
        warn((`[Net] still waiting for remote '{name}' (is its server module loaded?)`))
        child2 = remotes:WaitForChild(name)
    end

    return child2
end

return {
    Event = (function(name: string)
        --[[
          name: Event
          line: 48
          upvalues:
            get (copy, index: 1)
        ]]
        return (get("RemoteEvent", name))
    end),
    UnreliableEvent = (function(name: string)
        --[[
          name: UnreliableEvent
          line: 52
          upvalues:
            get (copy, index: 1)
        ]]
        return (get("UnreliableRemoteEvent", name))
    end),
    Function = (function(name: string)
        --[[
          name: Function
          line: 56
          upvalues:
            get (copy, index: 1)
        ]]
        return (get("RemoteFunction", name))
    end),
    RateLimiter = (function(a15, a16)
        --[[
          name: RateLimiter
          line: 63
        ]]
        local tokens = a16 or a15
        local v18 = {}
        game:GetService("Players").PlayerRemoving:Connect(
            function(player: Player)
                --[[
                  line: 66
                  upvalues:
                    v18 (copy, index: 1)
                ]]
                v18[player] = nil
            end
        )

        return function(key)
            --[[
              line: 69
              upvalues:
                v18 (copy, index: 1)
                tokens (copy, index: 2)
                a15 (copy, index: 3)
            ]]
            local timestamp = os.clock()
            local v22 = v18[key]
            if not v22 then
                v22 = {tokens = tokens, t = timestamp}
                v18[key] = v22
            end

            v22.tokens = math.min(tokens, v22.tokens + ((timestamp - v22.t) * a15))
            v22.t = timestamp

            if not (1 <= v22.tokens) then
                return false
            end

            v22.tokens -= 1

            return true
        end
    end)
}