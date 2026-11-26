local function parsePath(text)
    --[[
      name: parsePath
      line: 4
    ]]
    local parts = string.split(text, "/")

    for partKey = #parts, 1, -1 do
        if parts[partKey] == "" then
            table.remove(parts, partKey)
        end
    end

    return parts
end

local function isManifestResolved(a6, a7)
    --[[
      name: isManifestResolved
      line: 14
    ]]
    local count = 0

    for _ in pairs(a6) do
        count += 1
    end

    local v10 = count <= a7
    assert(v10, count)

    return count == a7
end

local function unbindNodeDescend(a12, a13)
    --[[
      name: unbindNodeDescend
      line: 24
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    if a12.instance == nil then
        return
    end

    a12.instance = nil

    if const connections = a12.connections then
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end

        table.clear(connections)
    end

    if a13 and a12.alias then
        a13[a12.alias] = nil
    end

    if const children = a12.children then
        for _, child in pairs(children) do
            unbindNodeDescend(child, a13)
        end
    end
end

local Class = {}
Class.__index = Class

function Class.new(a21, boundFn)
    --[[
      name: new
      line: 54
      upvalues:
        parsePath (copy, index: 1)
        Class (copy, index: 2)
    ]]
    local dtorMap = {}
    local connections = {}
    local rootInstToRootNode = {}
    local rootInstToManifest = {}
    local parsedManifest = {}
    local manifestSizeTarget = 1

    for key, text in pairs(a21) do
        parsedManifest[key] = parsePath(text)
        manifestSizeTarget += 1
    end

    return (setmetatable({_boundFn = boundFn, _parsedManifest = parsedManifest, _manifestSizeTarget = manifestSizeTarget, _dtorMap = dtorMap, _connections = connections, _rootInstToRootNode = rootInstToRootNode, _rootInstToManifest = rootInstToManifest}, Class))
end

function Class._startBoundFn(self, key, a33)
    --[[
      name: _startBoundFn
      line: 80
    ]]
    local boundFn = self._boundFn
    local dtorMap = self._dtorMap

    if const v36 = dtorMap[key] then
        v36()
        dtorMap[key] = nil
    end

    if const v37 = boundFn(a33) then
        dtorMap[key] = v37
    end
end

function Class._stopBoundFn(self, key)
    --[[
      name: _stopBoundFn
      line: 96
    ]]
    local dtorMap = self._dtorMap

    if const v41 = dtorMap[key] then
        v41()
        dtorMap[key] = nil
    end
end

function Class.bindRoot(self, instance)
    --[[
      name: bindRoot
      line: 106
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    debug.profilebegin("AtomicBinding:BindRoot")
    local parsedManifest = self._parsedManifest
    local rootInstToRootNode = self._rootInstToRootNode
    local rootInstToManifest = self._rootInstToManifest
    local manifestSizeTarget = self._manifestSizeTarget
    assert(rootInstToManifest[instance] == nil)
    local v48 = {}
    rootInstToManifest[instance] = v48
    debug.profilebegin("BuildTree")
    local v49 = {alias = "root", instance = instance}

    if next(parsedManifest) then
        v49.children = {}
        v49.connections = {}
    end

    rootInstToRootNode[instance] = v49

    for alias, v51 in pairs(parsedManifest) do
        local v52 = v49

        for index, childKey in ipairs(v51) do
            local v55 = index == #v51
            local v56 = v52.children[childKey] or {}

            if v55 then
                if v56.alias ~= nil then
                    error("Multiple aliases assigned to one instance")
                end

                v56.alias = alias
            else
                v56.children = v56.children or {}
                v56.connections = v56.connections or {}
            end

            v52.children[childKey] = v56
            v52 = v56
        end
    end

    debug.profileend()

    local function processNode(a58)
        --[[
          name: processNode
          line: 160
          upvalues:
            v48 (copy, index: 1)
            processNode (copy, index: 2)
            self (copy, index: 3)
            instance (copy, index: 4)
            unbindNodeDescend (copy, index: 5)
            manifestSizeTarget (copy, index: 6)
        ]]
        local v59 = assert(a58.instance)
        local children = a58.children
        local alias = a58.alias
        local v62 = not children

        if alias then
            v48[alias] = v59
        end

        if not v62 then
            for _, child in ipairs(v59:GetChildren()) do
                local child2 = children[child.Name]

                if child2 and child2.instance == nil then
                    child2.instance = child
                    processNode(child2)
                end
            end

            table.insert(
                a58.connections,
                v59.ChildAdded:Connect(
                    function(instance)
                        --[[
                          name: processAddChild
                          line: 172
                          upvalues:
                            children (copy, index: 1)
                            processNode (copy, index: 2)
                        ]]
                        local child = children[instance.Name]

                        if not child or child.instance ~= nil then
                            return
                        end

                        child.instance = instance
                        processNode(child)
                    end
                )
            )

            table.insert(
                a58.connections,
                v59.ChildRemoved:Connect(
                    function(a68)
                        --[[
                          name: processDeleteChild
                          line: 183
                          upvalues:
                            children (copy, index: 1)
                            self (copy, index: 2)
                            instance (copy, index: 3)
                            unbindNodeDescend (copy, index: 4)
                            v48 (copy, index: 5)
                            v59 (copy, index: 6)
                            processNode (copy, index: 7)
                        ]]
                        local name = a68.Name
                        local child = children[name]
                        if not child then
                            return
                        end
                        if child.instance ~= a68 then
                            return
                        end

                        self:_stopBoundFn(instance)
                        unbindNodeDescend(child, v48)
                        assert(child.instance == nil)

                        if const instance2 = v59:FindFirstChild(name) then
                            local child2 = children[instance2.Name]

                            if child2 and child2.instance == nil then
                                child2.instance = instance2
                                processNode(child2)
                            end
                        end
                    end
                )
            )
        end

        if v62 then
            local count = 0

            for _ in pairs(v48) do
                count += 1
            end

            local v75 = count <= manifestSizeTarget
            assert(v75, count)

            if count == manifestSizeTarget then
                self:_startBoundFn(instance, v48)
            end
        end
    end

    debug.profilebegin("ResolveTree")
    processNode(v49)
    debug.profileend()
    debug.profileend()
end

function Class.unbindRoot(self, key)
    --[[
      name: unbindRoot
      line: 236
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    local rootInstToRootNode = self._rootInstToRootNode
    local rootInstToManifest = self._rootInstToManifest
    self:_stopBoundFn(key)

    if const v80 = rootInstToRootNode[key] then
        local v81 = assert(rootInstToManifest[key])
        unbindNodeDescend(v80, v81)
        rootInstToRootNode[key] = nil
    end

    rootInstToManifest[key] = nil
end

function Class.destroy(self)
    --[[
      name: destroy
      line: 252
      upvalues:
        unbindNodeDescend (copy, index: 1)
    ]]
    debug.profilebegin("AtomicBinding:destroy")

    for _, v84 in pairs(self._dtorMap) do
        v84:destroy()
    end

    table.clear(self._dtorMap)

    for _, connection in ipairs(self._connections) do
        connection:Disconnect()
    end

    table.clear(self._connections)
    local rootInstToManifest = self._rootInstToManifest

    for key, v89 in pairs(self._rootInstToRootNode) do
        local v90 = assert(rootInstToManifest[key])
        unbindNodeDescend(v89, v90)
    end

    table.clear(self._rootInstToManifest)
    table.clear(self._rootInstToRootNode)
    debug.profileend()
end

return Class