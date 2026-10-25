local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local tbl_upv_1 = {}
local u1 = ReplicatedStorage_1:FindFirstChild("Remotes")
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local function hookRemote(a1)
    --[[
      name: hookRemote
      line: 15
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_4 (copy, index: 2)
    ]]
    local u2 = tbl_upv_3[a1.Name]
    if not u2 or (tbl_upv_4[a1]) then
        return
    end
    if a1:IsA("RemoteEvent") or a1:IsA("UnreliableRemoteEvent") then
        tbl_upv_4[a1] = true
        a1.OnClientEvent:Connect(
            function(...)
                --[[
                  line: 22
                  upvalues:
                    u2 (copy, index: 1)
                ]]
                for _, value_1 in u2 do
                    task.spawn(value_1, ...)
                end
            end
        )
    end
end
local function onFolder(a1)
    --[[
      name: onFolder
      line: 30
      upvalues:
        u1 (ref,  index: 1)
        hookRemote (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
    ]]
    u1 = a1
    for _, value_2 in a1:GetChildren() do
        hookRemote(value_2)
    end
    a1.ChildAdded:Connect(hookRemote)
    for _, value_3 in tbl_upv_2 do
        task.spawn(value_3)
    end
    table.clear(tbl_upv_2)
end
if u1 then
    onFolder(u1)
else
    local u3 = nil
    local v1 = ReplicatedStorage_1.ChildAdded:Connect(
        function(a1)
            --[[
              line: 46
              upvalues:
                u1 (ref,  index: 1)
                u3 (ref,  index: 2)
                onFolder (copy, index: 3)
            ]]
            if a1.Name ~= "Remotes" or (u1) then
                return
            end
            u3:Disconnect()
            onFolder(a1)
        end
    )
    u3 = v1
end
function tbl_upv_1.Get(a1, a2)
    --[[
      name: Get
      line: 55
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v2 = os.clock() + (a2 or 0)
    local v3 = nil
    while true do
        v3 = u1 and (u1:FindFirstChild(a1))
        if v3 then
            return v3
        end
        if v2 <= os.clock() then
            break
        end
        task.wait(0.1)
    end
    return nil
end
function tbl_upv_1.On(a1, a2)
    --[[
      name: On
      line: 71
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u1 (ref,  index: 2)
        hookRemote (copy, index: 3)
    ]]
    local v4 = tbl_upv_3[a1]
    if not (v4) then
        v4 = {}
        tbl_upv_3[a1] = v4
    end
    table.insert(v4, a2)
    local v5 = u1 and (u1:FindFirstChild(a1))
    if not v5 then
        return
    end
    hookRemote(v5)
end
function tbl_upv_1.Fire(a1, ...)
    --[[
      name: Fire
      line: 85
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v6 = tbl_upv_1.Get(a1)
    if v6 then
        if not (v6:IsA("RemoteEvent")) and not (v6:IsA("UnreliableRemoteEvent")) then
            return false
        end
        v6:FireServer(...)
        return true
    end
    return false
end
tbl_upv_1.Timeouts = {ProfileAction = 20, QueueAction = 20}
function tbl_upv_1.Invoke(a1, ...)
    --[[
      name: Invoke
      line: 99
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local u4 = tbl_upv_1.Get(a1, 3)
    if u4 and u4:IsA("RemoteFunction") then
        local u5 = table.pack(...)
        local u6 = false
        local u7 = {}
        local u8 = coroutine.running()
        local u9 = true
        task.spawn(
            function()
                --[[
                  line: 109
                  upvalues:
                    u4 (copy, index: 1)
                    u5 (copy, index: 2)
                    u6 (ref,  index: 3)
                    u7 (ref,  index: 4)
                    u9 (ref,  index: 5)
                    u8 (copy, index: 6)
                ]]
                local v7 = table.pack(
                    pcall(
                        function()
                            --[[
                              line: 110
                              upvalues:
                                u4 (copy, index: 1)
                                u5 (copy, index: 2)
                            ]]
                            return u4:InvokeServer(table.unpack(u5, 1, u5.n))
                        end
                    )
                )
                u6 = true
                u7 = v7
                if not u9 then
                    return
                end
                task.defer(u8)
            end
        )
        if not (u6) then
            local v8 = task.delay(
                tbl_upv_1.Timeouts[a1] or 10,
                function()
                    --[[
                      line: 120
                      upvalues:
                        u6 (ref,  index: 1)
                        u9 (ref,  index: 2)
                        u8 (copy, index: 3)
                    ]]
                    if (u6) then
                        return
                    end
                    u9 = false
                    task.defer(u8)
                end
            )
            coroutine.yield()
            task.cancel(v8)
        end
        if u6 then
            if u7[1] then
                local n_1 = u7.n
                local v9 = u7
                return true, table.unpack(v9, 2, n_1)
            else
                local str_1 = tostring(u7[2])
                return false, str_1
            end
        else
            return false, "Request timed out"
        end
    end
    return false, "Server not ready"
end
return tbl_upv_1