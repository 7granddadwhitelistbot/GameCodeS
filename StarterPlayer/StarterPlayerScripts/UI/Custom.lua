local Players_upv_1 = game:GetService("Players")
local v1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local Signal_upv_1 = require(v1:WaitForChild("Shared"):WaitForChild("Signal"))
local CustomMatch_upv_1 = require(v1.Shared:WaitForChild("CustomMatch"))
v1 = {}
function v1.Init(a1)
    --[[
      name: Init
      line: 33
      upvalues:
        Players_upv_1 (copy, index: 1)
        Signal_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        CustomMatch_upv_1 (copy, index: 4)
    ]]
    local Remotes_upv_1 = a1.Remotes
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = false
    local u2 = nil
    local tbl_upv_1 = {}
    tbl_upv_1.Changed = Signal_upv_1.new()
    tbl_upv_1.RevealChanged = Signal_upv_1.new()
    tbl_upv_1.MASK = "\226\128\162\226\128\162\226\128\162 \226\128\162\226\128\162\226\128\162"
    Remotes_upv_1.Timeouts.CustomAction = 25
    Remotes_upv_1.Timeouts.CustomHost = 15
    local function current()
        --[[
          name: current
          line: 46
          upvalues:
            u2 (ref, index: 1)
            u1 (ref, index: 2)
        ]]
        local v2 = u2 or u1
        return v2
    end
    function tbl_upv_1.IsServer()
        --[[
          name: IsServer
          line: 50
          upvalues:
            u2 (ref,  index: 1)
            Workspace_upv_1 (copy, index: 2)
        ]]
        local v3 = true
        if u2 == nil then
            v3 = Workspace_upv_1:GetAttribute("CustomServer") == true
        end
        return v3
    end
    function tbl_upv_1.State()
        --[[
          name: State
          line: 53
          upvalues:
            u2 (ref, index: 1)
            u1 (ref, index: 2)
        ]]
        local v4 = u2 or u1
        return v4
    end
    function tbl_upv_1.Code()
        --[[
          name: Code
          line: 56
          upvalues:
            u2 (ref,  index: 1)
            u1 (ref,  index: 2)
            Workspace_upv_1 (copy, index: 3)
        ]]
        local v5 = u2 or u1
        if v5 and type(v5.code) == "string" then
            return v5.code
        end
        local v6 = Workspace_upv_1:GetAttribute("CustomCode")
        if type(v6) ~= "string" then
            return ""
        end
        return v6
    end
    function tbl_upv_1.IsHost()
        --[[
          name: IsHost
          line: 64
          upvalues:
            u2 (ref,  index: 1)
            u1 (ref,  index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            tbl_upv_1 (copy, index: 4)
            Workspace_upv_1 (copy, index: 5)
        ]]
        local v7 = u2 or u1
        if v7 and v7.custom and type(v7.ownerId) == "number" then
            return v7.ownerId == LocalPlayer_upv_1.UserId
        end
        local v8 = tbl_upv_1.IsServer() and (Workspace_upv_1:GetAttribute("CustomOwner") == LocalPlayer_upv_1.UserId)
        return v8
    end
    function tbl_upv_1.IsPrivate()
        --[[
          name: IsPrivate
          line: 73
          upvalues:
            u2 (ref,  index: 1)
            u1 (ref,  index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        local v9 = u2 or u1
        local v10 = tbl_upv_1.IsServer() and ((type(v9) == "table") and (v9.public == false))
        return v10
    end
    local u3 = 0
    local u4 = false
    function tbl_upv_1.IsRevealed()
        --[[
          name: IsRevealed
          line: 79
          upvalues:
            u4 (ref, index: 1)
        ]]
        return u4
    end
    function tbl_upv_1.Reveal(a2)
        --[[
          name: Reveal
          line: 82
          upvalues:
            u3 (ref,  index: 1)
            u4 (ref,  index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        u3 = u3 + 1
        local u5 = u3
        if not (u4) then
            u4 = true
            tbl_upv_1.RevealChanged:Fire(true)
        end
        task.delay(
            a2 or 10,
            function()
                --[[
                  line: 89
                  upvalues:
                    u5 (copy, index: 1)
                    u3 (ref,  index: 2)
                    u4 (ref,  index: 3)
                    tbl_upv_1 (copy, index: 4)
                ]]
                if u5 ~= u3 or not u4 then
                    return
                end
                u4 = false
                tbl_upv_1.RevealChanged:Fire(false)
            end
        )
    end
    function tbl_upv_1.Hide()
        --[[
          name: Hide
          line: 96
          upvalues:
            u3 (ref,  index: 1)
            u4 (ref,  index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        u3 = u3 + 1
        if not u4 then
            return
        end
        u4 = false
        tbl_upv_1.RevealChanged:Fire(false)
    end
    function tbl_upv_1.CodeShown()
        --[[
          name: CodeShown
          line: 103
          upvalues:
            tbl_upv_1 (copy, index: 1)
            u4 (ref,  index: 2)
            CustomMatch_upv_1 (copy, index: 3)
        ]]
        if tbl_upv_1.IsPrivate() and not (u4) then
            return "\226\128\162\226\128\162\226\128\162 \226\128\162\226\128\162\226\128\162"
        end
        return CustomMatch_upv_1.FormatCode(tbl_upv_1.Code())
    end
    function tbl_upv_1.MaskDots(a3)
        --[[
          name: MaskDots
          line: 110
          upvalues:
            a1 (copy, index: 1)
        ]]
        local UI_1 = a1.UI
        local v11 = a3.Dot or 8
        local v12 = a3.Gap or 4
        local v13 = a3.GroupGap or 10
        local new_1 = UI_1.new
        local tbl_2 = {AnchorPoint = 0, Position = 0, Parent = 0, Size = 0}
        tbl_2.Name = a3.Name or "Mask"
        tbl_2.AnchorPoint = a3.AnchorPoint or Vector2.new(1, 0.5)
        tbl_2.Position = a3.Position or UDim2.new()
        tbl_2.Size = UDim2.fromOffset(((6 * v11) + (4 * v12)) + v13, v11)
        tbl_2.Parent = a3.Parent
        new_1 = new_1("Frame", tbl_2)
        for n_1 = 1, 6 do
            local v16 = ((n_1 > 3) and (v13 - v12)) or 0
            local new_2 = UI_1.new
            local tbl_3 = {}
            tbl_3.Name = "Dot" .. n_1
            tbl_3.Position = UDim2.fromOffset((n_1 - 1) * (v11 + v12) + v16, 0)
            tbl_3.Size = UDim2.fromOffset(v11, v11)
            tbl_3.BackgroundColor3 = a3.Color or (a1.Theme.Colors.TextDim)
            tbl_3[1] = UI_1.Corner(a1.Theme.Radius.Pill)
            tbl_3.Parent = new_1
            new_2("Frame", tbl_3)
        end
        return new_1
    end
    local function apply(a4)
        --[[
          name: apply
          line: 136
          upvalues:
            u1 (ref,  index: 1)
            u2 (ref,  index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        if type(a4) ~= "table" then
            return
        end
        if a4.custom ~= false then
            u1 = a4
        else
            u1 = false
        end
        if not (u2) then
            tbl_upv_1.Changed:Fire(u2 or u1)
        end
    end
    Remotes_upv_1.On("CustomState", apply)
    function tbl_upv_1.Host(a5, a6)
        --[[
          name: Host
          line: 151
          upvalues:
            u2 (ref,  index: 1)
            Remotes_upv_1 (copy, index: 2)
            u1 (ref,  index: 3)
            tbl_upv_1 (copy, index: 4)
        ]]
        if u2 then
            return true, u2
        end
        local v17, v18, v19 = Remotes_upv_1.Invoke("CustomHost", a5, a6)
        if v17 then
            if v18 == true then
                if type(v19) == "table" and type(v19) == "table" then
                    if v19.custom ~= false then
                        u1 = v19
                    else
                        u1 = false
                    end
                    if not (u2) then
                        tbl_upv_1.Changed:Fire(u2 or u1)
                    end
                end
                return true, v19
            else
                local v20 = false
                if type(v19) ~= "string" then
                    return v20, "Couldn't do that"
                end
                return v20, v19
            end
        else
            return false, (tostring(v18 or "Server unavailable"))
        end
    end
    function tbl_upv_1.Action(a7, a8)
        --[[
          name: Action
          line: 168
          upvalues:
            Remotes_upv_1 (copy, index: 1)
        ]]
        local v21, v22, v23 = Remotes_upv_1.Invoke("CustomAction", a7, a8)
        if not v21 then
            return false, (tostring(v22 or "Server unavailable"))
        end
        if v22 == true then
            return true, v23
        end
        local v24 = false
        if type(v23) ~= "string" then
            return v24, "Couldn't do that"
        end
        return v24, v23
    end
    local function fetch()
        --[[
          name: fetch
          line: 181
          upvalues:
            tbl_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
        ]]
        if not tbl_upv_1.IsServer() or (u1) then
            return
        end
        task.spawn(function() end)
    end
    Workspace_upv_1:GetAttributeChangedSignal("CustomServer"):Connect(
        function()
            --[[
              line: 191
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                u1 (ref,  index: 2)
                tbl_upv_1 (copy, index: 3)
                u2 (ref,  index: 4)
            ]]
            if Workspace_upv_1:GetAttribute("CustomServer") == true then
                if tbl_upv_1.IsServer() and not (u1) then
                    task.spawn(
                        function()
                            --[[
                              line: 183
                              upvalues:
                                tbl_upv_1 (copy, index: 1)
                                u1 (ref,  index: 2)
                                u2 (ref,  index: 3)
                            ]]
                            local v25, v26 = tbl_upv_1.Host("Get")
                            if not v25 or type(v26) ~= "table" or type(v26) ~= "table" then
                                return
                            end
                            if v26.custom ~= false then
                                u1 = v26
                            else
                                u1 = false
                            end
                            if (u2) then
                                return
                            end
                            tbl_upv_1.Changed:Fire(u2 or u1)
                        end
                    )
                end
            else
                u1 = false
                tbl_upv_1.Changed:Fire(u2 or u1)
            end
        end
    )
    Workspace_upv_1:GetAttributeChangedSignal("CustomOwner"):Connect(
        function()
            --[[
              line: 199
              upvalues:
                tbl_upv_1 (copy, index: 1)
                u2 (ref,  index: 2)
                u1 (ref,  index: 3)
            ]]
            tbl_upv_1.Changed:Fire(u2 or u1)
        end
    )
    task.delay(1, fetch)
    function tbl_upv_1.SetMock(a9)
        --[[
          name: SetMock
          line: 205
          upvalues:
            u2 (ref,  index: 1)
            tbl_upv_1 (copy, index: 2)
            u1 (ref,  index: 3)
        ]]
        local v27
        if type(a9) ~= "table" then
            v27 = nil
        else
            v27 = a9
        end
        u2 = v27
        tbl_upv_1.Changed:Fire(u2 or u1)
    end
    a1.Custom = tbl_upv_1
end
return v1