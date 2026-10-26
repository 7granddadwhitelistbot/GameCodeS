local function isManifestResolved(a1, a2)
    --[[
      name: isManifestResolved
      line: 14
    ]]
    local v1 = 0
    for _ in pairs(a1) do
        v1 = v1 + 1
    end
    assert(v1 <= a2, v1)
    return v1 == a2
end
local function unbindNodeDescend(a1, a2)
    --[[
      name: unbindNodeDescend
      line: 24
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    if a1.instance == nil then
        return
    end
    a1.instance = nil
    local connections_1 = a1.connections
    if connections_1 then
        for _, value_1 in ipairs(connections_1) do
            value_1:Disconnect()
        end
        table.clear(connections_1)
    end
    if a2 and a1.alias then
        a2[a1.alias] = nil
    end
    local children_1 = a1.children
    if not children_1 then
        return
    end
    for _, value_2 in pairs(children_1) do
        unbindNodeDescend(value_2, a2)
    end
end
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
local function parsePath(a1)
    --[[
      name: parsePath
      line: 4
    ]]
    local v2 = string.split(a1, "/")
    for n_1 = #v2, 1, -1 do
        if v2[n_1] == "" then
            table.remove(v2, n_1)
        end
    end
    return v2
end
function tbl_upv_1.new(a1, a2)
    --[[
      name: new
      line: 54
      upvalues:
        parsePath (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local tbl_2 = {}
    local tbl_3 = {}
    local tbl_4 = {}
    local tbl_5 = {}
    local tbl_6 = {}
    local v3 = 1
    for key_1, value_3 in pairs(a1) do
        tbl_6[key_1] = parsePath(value_3)
        v3 = v3 + 1
    end
    return (setmetatable({_boundFn = a2, _parsedManifest = tbl_6, _manifestSizeTarget = v3, _dtorMap = tbl_2, _connections = tbl_3, _rootInstToRootNode = tbl_4, _rootInstToManifest = tbl_5}, tbl_upv_1))
end
function tbl_upv_1._startBoundFn(a1, a2, a3)
    --[[
      name: _startBoundFn
      line: 80
    ]]
    local _boundFn_1 = a1._boundFn
    local _dtorMap_1 = a1._dtorMap
    local v4 = _dtorMap_1[a2]
    if v4 then
        v4()
        _dtorMap_1[a2] = nil
    end
    local v5 = _boundFn_1(a3)
    if not v5 then
        return
    end
    _dtorMap_1[a2] = v5
end
function tbl_upv_1._stopBoundFn(a1, a2)
    --[[
      name: _stopBoundFn
      line: 96
    ]]
    local _dtorMap_2 = a1._dtorMap
    local v6 = _dtorMap_2[a2]
    if not v6 then
        return
    end
    v6()
    _dtorMap_2[a2] = nil
end
function tbl_upv_1.bindRoot(a1, a2)
    --[[
      name: bindRoot
      line: 106
    ]]
    debug.profilebegin("AtomicBinding:BindRoot")
    local _parsedManifest_1 = a1._parsedManifest
    local v7 = a1._rootInstToRootNode
    local _rootInstToManifest_1 = a1._rootInstToManifest
    local _manifestSizeTarget_upv_1 = a1._manifestSizeTarget
    assert(_rootInstToManifest_1[a2] == nil)
    local tbl_upv_7 = {}
    _rootInstToManifest_1[a2] = tbl_upv_7
    debug.profilebegin("BuildTree")
    local tbl_8 = {}
    tbl_8.alias = "root"
    tbl_8.instance = a2
    if next(_parsedManifest_1) then
        tbl_8.children = {}
        tbl_8.connections = {}
    end
    v7[a2] = tbl_8
    for key_2, value_4 in pairs(_parsedManifest_1) do
        v7 = tbl_8
        for key_3, value_5 in ipairs(value_4) do
            local v8 = key_3 == #value_4
            local v9 = v7.children[value_5] or {}
            if not (v8) then
                v9.children = v9.children or {}
                v9.connections = v9.connections or {}
                v7.children[value_5] = v9
                v7 = v9
                continue
            end
            if v9.alias ~= nil then
                error("Multiple aliases assigned to one instance")
            end
            v9.alias = key_2
            v7.children[value_5] = v9
            v7 = v9
        end
    end
    debug.profileend()
    local function processNode(a3)
        --[[
          name: processNode
          line: 160
          upvalues:
            tbl_upv_7 (copy, index: 1)
            processNode (copy, index: 2)
            a1 (copy, index: 3)
            a2 (copy, index: 4)
            processNode (copy, index: 5)
            _manifestSizeTarget_upv_1 (copy, index: 6)
        ]]
        local u1 = assert(a3.instance)
        local children_upv_2 = a3.children
        local alias_1 = a3.alias
        local v10 = not children_upv_2
        if alias_1 then
            tbl_upv_7[alias_1] = u1
        end
        if not (v10) then
            local function processDeleteChild_1(a4)
                --[[
                  name: processDeleteChild
                  line: 183
                  upvalues:
                    children_upv_2 (copy, index: 1)
                    a1 (copy, index: 2)
                    a2 (copy, index: 3)
                    unbindNodeDescend (copy, index: 4)
                    tbl_upv_7 (copy, index: 5)
                    u1 (copy, index: 6)
                    processNode (copy, index: 7)
                ]]
                local Name_1 = a4.Name
                local v11 = children_upv_2[Name_1]
                if not v11 or v11.instance ~= a4 then
                    return
                end
                a1:_stopBoundFn(a2)
                unbindNodeDescend(v11, tbl_upv_7)
                assert(v11.instance == nil)
                local v12 = u1:FindFirstChild(Name_1)
                if v12 then
                    local v13 = children_upv_2[v12.Name]
                    if not v13 or v13.instance ~= nil then
                        return
                    end
                    v13.instance = v12
                    processNode(v13)
                end
            end
            for _, value_6 in ipairs(u1:GetChildren()) do
                local v14 = children_upv_2[value_6.Name]
                if not (v14) then
                    continue
                end
                if v14.instance == nil then
                    v14.instance = value_6
                    processNode(v14)
                end
            end
            local function processAddChild_1(a5)
                --[[
                  name: processAddChild
                  line: 172
                  upvalues:
                    children_upv_2 (copy, index: 1)
                    processNode (copy, index: 2)
                ]]
                local v15 = children_upv_2[a5.Name]
                if not v15 or v15.instance ~= nil then
                    return
                end
                v15.instance = a5
                processNode(v15)
            end
            table.insert(a3.connections, u1.ChildAdded:Connect(processAddChild_1))
            table.insert(a3.connections, u1.ChildRemoved:Connect(processDeleteChild_1))
        end
        if v10 then
            local v16 = 0
            for _ in pairs(tbl_upv_7) do
                v16 = v16 + 1
            end
            assert(v16 <= _manifestSizeTarget_upv_1, v16)
            if v16 ~= _manifestSizeTarget_upv_1 then
                return
            end
            a1:_startBoundFn(a2, tbl_upv_7)
        end
    end
    debug.profilebegin("ResolveTree")
    processNode(tbl_8)
    debug.profileend()
    debug.profileend()
end
function tbl_upv_1.unbindRoot(a1, a2)
    --[[
      name: unbindRoot
      line: 236
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    local _rootInstToRootNode_1 = a1._rootInstToRootNode
    local _rootInstToManifest_2 = a1._rootInstToManifest
    a1:_stopBoundFn(a2)
    local v17 = _rootInstToRootNode_1[a2]
    if v17 then
        unbindNodeDescend(v17, (assert(_rootInstToManifest_2[a2])))
        _rootInstToRootNode_1[a2] = nil
    end
    _rootInstToManifest_2[a2] = nil
end
function tbl_upv_1.destroy(a1)
    --[[
      name: destroy
      line: 252
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    debug.profilebegin("AtomicBinding:destroy")
    for _, value_7 in pairs(a1._dtorMap) do
        value_7:destroy()
    end
    table.clear(a1._dtorMap)
    for _, value_8 in ipairs(a1._connections) do
        value_8:Disconnect()
    end
    table.clear(a1._connections)
    local _rootInstToManifest_3 = a1._rootInstToManifest
    for key_4, value_9 in pairs(a1._rootInstToRootNode) do
        unbindNodeDescend(value_9, (assert(_rootInstToManifest_3[key_4])))
    end
    table.clear(a1._rootInstToManifest)
    table.clear(a1._rootInstToRootNode)
    debug.profileend()
end
return tbl_upv_1