local replicatedStorage = game:GetService("ReplicatedStorage")
local v2 = {}
local instance = replicatedStorage:FindFirstChild("Remotes")
local v4 = {}
local v5 = {}
local v6 = {}

local function hookRemote(child: Instance?)
    --[[
      name: hookRemote
      line: 15
      upvalues:
        v5 (copy, index: 1)
        v6 (copy, index: 2)
    ]]
    local v9 = v5[child.Name]

    if not v9 or v6[child] then
        return
    end

    if child:IsA("RemoteEvent") or child:IsA("UnreliableRemoteEvent") then
        v6[child] = true

        child.OnClientEvent:Connect(
            function(...)
                --[[
                  line: 22
                  upvalues:
                    v9 (copy, index: 1)
                ]]
                for _, v11 in v9 do
                    task.spawn(v11, ...)
                end
            end
        )
    end
end

local function onFolder(instance2: Instance?)
    --[[
      name: onFolder
      line: 30
      upvalues:
        instance (ref,  index: 1)
        hookRemote (copy, index: 2)
        v4 (copy, index: 3)
    ]]
    instance = instance2

    for _, child in instance2:GetChildren() do
        hookRemote(child)
    end

    instance2.ChildAdded:Connect(hookRemote)

    for _, v17 in v4 do
        task.spawn(v17)
    end

    table.clear(v4)
end

if instance then
    onFolder(instance)
else
    local childAddedConnection = nil

    childAddedConnection = replicatedStorage.ChildAdded:Connect(
        function(child: Instance)
            --[[
              line: 46
              upvalues:
                instance (ref,  index: 1)
                childAddedConnection (ref,  index: 2)
                onFolder (copy, index: 3)
            ]]
            if child.Name == "Remotes" and not instance then
                childAddedConnection:Disconnect()
                onFolder(child)
            end
        end
    )
end

function v2.Get(childName: string, a21)
    --[[
      name: Get
      line: 55
      upvalues:
        instance (ref, index: 1)
    ]]
    local child
    local v23 = os.clock() + (a21 or 0)

    while true do
        local instance2 = instance
        child = instance2 and instance2:FindFirstChild(childName)

        if child then
            return child
        end
        if v23 <= os.clock() then
            return nil
        end

        task.wait(0.1)
    end
end

function v2.On(childName: string, a26)
    --[[
      name: On
      line: 71
      upvalues:
        v5 (copy, index: 1)
        instance (ref,  index: 2)
        hookRemote (copy, index: 3)
    ]]
    local v27 = v5[childName]
    if not v27 then
        v27 = {}
        v5[childName] = v27
    end

    table.insert(v27, a26)
    local instance2 = instance

    if const child = instance2 and instance2:FindFirstChild(childName) then
        hookRemote(child)
    end
end

function v2.Fire(a30, ...)
    --[[
      name: Fire
      line: 85
      upvalues:
        v2 (copy, index: 1)
    ]]
    local v31 = v2.Get(a30)

    if v31 and (v31:IsA("RemoteEvent") or v31:IsA("UnreliableRemoteEvent")) then
        v31:FireServer(...)
        return true
    end

    return false
end

v2.Timeouts = {QueueAction = 20, ProfileAction = 20}

function v2.Invoke(timeoutKey, ...)
    --[[
      name: Invoke
      line: 99
      upvalues:
        v2 (copy, index: 1)
    ]]
    local v33 = v2.Get(timeoutKey, 3)

    if not v33 or not v33:IsA("RemoteFunction") then
        return false, "Server not ready"
    end

    local values = table.pack(...)
    local v35 = false
    local v36 = {}
    local v37 = coroutine.running()
    local v38 = true

    task.spawn(
        function()
            --[[
              line: 109
              upvalues:
                v33 (copy, index: 1)
                values (copy, index: 2)
                v35 (ref,  index: 3)
                v36 (ref,  index: 4)
                v38 (ref,  index: 5)
                v37 (copy, index: 6)
            ]]
            local values2 = table.pack(
                pcall(
                    function()
                        --[[
                          line: 110
                          upvalues:
                            v33 (copy, index: 1)
                            values (copy, index: 2)
                        ]]
                        return v33:InvokeServer(table.unpack(values, 1, values.n))
                    end
                )
            )
            v35 = true
            v36 = values2

            if v38 then
                task.defer(v37)
            end
        end
    )

    if not v35 then
        local v40 = task.delay(
            (v2.Timeouts[timeoutKey] or 10),
            function()
                --[[
                  line: 120
                  upvalues:
                    v35 (ref,  index: 1)
                    v38 (ref,  index: 2)
                    v37 (copy, index: 3)
                ]]
                if not v35 then
                    v38 = false
                    task.defer(v37)
                end
            end
        )

        coroutine.yield()
        task.cancel(v40)
    end

    if not v35 then
        return false, "Request timed out"
    end

    if not v36[1] then
        local text = tostring(v36[2])
        return false, text
    end

    local n = v36.n
    local v43 = v36
    local tableUnpack = table.unpack

    return true, tableUnpack(v43, 2, n)
end

return v2