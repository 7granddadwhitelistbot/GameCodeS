local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService"):IsServer()
local v1, Remotes_upv_1 = nil, nil
if u1 then
    v1 = ReplicatedStorage_1:FindFirstChild("Remotes")
    if v1 then
        Remotes_upv_1 = v1
    else
        local v2 = Instance.new("Folder")
        v2.Name = "Remotes"
        v2.Parent = ReplicatedStorage_1
        Remotes_upv_1 = v2
    end
else
    Remotes_upv_1 = ReplicatedStorage_1:WaitForChild("Remotes")
end
local function get(a1, a2)
    --[[
      name: get
      line: 26
      upvalues:
        Remotes_upv_1 (ref,  index: 1)
        u1 (copy, index: 2)
    ]]
    local v3 = Remotes_upv_1:FindFirstChild(a2)
    if v3 then
        assert(v3.ClassName == a1, (("Remote %* is a %*, expected %*"):format(a2, v3.ClassName, a1)))
        return v3
    elseif u1 then
        local v4 = Instance.new(a1)
        v4.Name = a2
        v4.Parent = Remotes_upv_1
        return v4
    else
        local v5 = Remotes_upv_1:WaitForChild(a2, 15)
        if not (v5) then
            warn((("[Net] still waiting for remote '%*' (is its server module loaded?)"):format(a2)))
            v5 = Remotes_upv_1:WaitForChild(a2)
        end
        return v5
    end
end
local tbl_1 = {}
function tbl_1.Event(a1)
    --[[
      name: Event
      line: 48
      upvalues:
        get (copy, index: 1)
    ]]
    return (get("RemoteEvent", a1))
end
function tbl_1.UnreliableEvent(a1)
    --[[
      name: UnreliableEvent
      line: 52
      upvalues:
        get (copy, index: 1)
    ]]
    return (get("UnreliableRemoteEvent", a1))
end
function tbl_1.Function(a1)
    --[[
      name: Function
      line: 56
      upvalues:
        get (copy, index: 1)
    ]]
    return (get("RemoteFunction", a1))
end
function tbl_1.RateLimiter(a1, a2)
    --[[
      name: RateLimiter
      line: 63
    ]]
    local u2 = a2 or a1
    local tbl_upv_2 = {}
    game:GetService("Players").PlayerRemoving:Connect(
        function(a3)
            --[[
              line: 66
              upvalues:
                tbl_upv_2 (copy, index: 1)
            ]]
            tbl_upv_2[a3] = nil
        end
    )
    return function(a4)
        --[[
          line: 69
          upvalues:
            tbl_upv_2 (copy, index: 1)
            u2 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        local v6 = os.clock()
        local v7 = tbl_upv_2[a4]
        if not (v7) then
            v7 = {tokens = u2, t = v6}
            tbl_upv_2[a4] = v7
        end
        v7.tokens = math.min(u2, v7.tokens + ((v6 - v7.t) * a1))
        v7.t = v6
        if v7.tokens >= 1 then
            v7.tokens = v7.tokens - 1
            return true
        end
        return false
    end
end
return tbl_1