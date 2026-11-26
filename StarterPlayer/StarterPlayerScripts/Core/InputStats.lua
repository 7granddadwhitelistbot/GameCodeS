local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local v4 = {}
local v5 = {BodyVelocity = 1, BodyGyro = 2, BodyPosition = 4, BodyForce = 8, BodyThrust = 16, BodyAngularVelocity = 32, RocketPropulsion = 64}
local v6 = 0
local hasRun = false
local v8 = {}
local v9 = {}
local v10 = {}

local function note(a12: number)
    --[[
      name: note
      line: 70
      upvalues:
        v6 (ref, index: 1)
    ]]
    v6 = bit32.bor(v6, a12)
end

local function watch(character: Model?)
    --[[
      name: watch
      line: 74
      upvalues:
        v5 (copy, index: 1)
        v6 (ref,  index: 2)
    ]]
    local function look(descendant: Instance)
        --[[
          name: look
          line: 75
          upvalues:
            v5 (copy, index: 1)
            character (copy, index: 2)
            v6 (ref,  index: 3)
        ]]
        local v17 = v5[descendant.ClassName]
        local parent = descendant.Parent

        if v17 and parent and parent:IsA("BasePart") and parent.Parent == character then
            v6 = bit32.bor(v6, v17)
        end
    end

    for _, descendant in character:GetDescendants() do
        local v21 = v5[descendant.ClassName]
        local parent = descendant.Parent

        if v21 then
            if not parent then
                continue
            end

            if parent:IsA("BasePart") and parent.Parent == character then
                v6 = bit32.bor(v6, v21)
            end
        end
    end

    character.DescendantAdded:Connect(look)
end

function v4.Note(a23: number)
    --[[
      name: Note
      line: 89
      upvalues:
        v6 (ref, index: 1)
    ]]
    v6 = bit32.bor(v6, a23)
end

function v4.Watch(t, bit)
    --[[
      name: Watch
      line: 94
      upvalues:
        v8 (copy, index: 1)
    ]]
    for k, f in next, t do
        if type(f) == "function" then
            table.insert(v8, {t = t, k = k, f = f, bit = bit})
        end
    end
end

local random = Random.new()
v4.PROBE = {m = nil, ml = nil, at = nil, n = random:NextNumber(2e+06, 9e+06), s = string.format("%x%x", random:NextInteger(268435456, 2147483647), random:NextInteger(268435456, 2147483647)), t = {}, v = Vector3.new(random:NextNumber(2e+06, 9e+06), random:NextNumber(2e+06, 9e+06), random:NextNumber(2e+06, 9e+06)), k = random:NextNumber(1.25, 3.75), o = Vector3.new(random:NextNumber(-1.1, 1.1), random:NextNumber(0.9, 2.1), random:NextNumber(-1.1, 1.1))}

function v4.Hooked(f, ...)
    --[[
      name: Hooked
      line: 115
      upvalues:
        v9 (copy, index: 1)
    ]]
    table.insert(v9, {f = f, args = table.pack(...)})
end

local function ours(text: string)
    --[[
      name: ours
      line: 120
      upvalues:
        v10 (copy, index: 1)
    ]]
    local v32 = v10[text]
    if v32 == nil then
        local v33 = string.match(text, "^([%w_]+)%.")
        local success = false
        local service = nil

        if v33 then
            success, service = pcall(game.FindService, game, v33)
        end

        v32 = success and service ~= nil
        v10[text] = v32
    end

    return v32
end

function v4.Caller(a36: number)
    --[[
      name: Caller
      line: 134
      upvalues:
        v6 (ref,  index: 1)
        v10 (copy, index: 2)
    ]]
    if bit32.btest(v6, a36) then
        return
    end

    for index = 2, 12 do
        local text = debug.info(index, "s")
        if text == nil then
            return
        end

        if text ~= "[C]" then
            local v39
            local v40 = v10[text]

            if v40 == nil then
                local v41 = string.match(text, "^([%w_]+)%.")
                local success = false
                local service = nil

                if v41 then
                    success, service = pcall(game.FindService, game, v41)
                end

                v39 = success and service ~= nil
                v10[text] = v39
            else
                v39 = v40
            end

            if not v39 then
                v6 = bit32.bor(v6, a36)
                return
            end
        end
    end
end

function v4.Take()
    --[[
      name: Take
      line: 151
      upvalues:
        v8 (copy, index: 1)
        v6 (ref,  index: 2)
        v4 (copy, index: 3)
        v9 (copy, index: 4)
    ]]
    for _, v45 in v8 do
        local value = rawget(v45.t, v45.k)

        if value ~= v45.f then
            local bit = v45.bit
            v6 = bit32.bor(v6, bit)
        end
    end

    local probe = v4.PROBE

    if probe.m ~= nil then
        local value = rawget(probe.m, "lastSwing")

        if value ~= probe.ml then
            v6 = bit32.bor(v6, 256)
        end
    end

    for _, v51 in v9 do
        local success, result = pcall(v51.f, table.unpack(v51.args, 1, v51.args.n))

        if not success or result ~= v51.args[1] then
            v6 = bit32.bor(v6, 256)
        end
    end

    local v54 = v6
    v6 = 0

    return v54
end

function v4.Start()
    --[[
      name: Start
      line: 172
      upvalues:
        hasRun (ref,  index: 1)
        players (copy, index: 2)
        watch (copy, index: 3)
        v6 (ref,  index: 4)
        guiService (copy, index: 5)
        userInputService (copy, index: 6)
    ]]
    if hasRun then
        return
    end

    hasRun = true
    local localPlayer = players.LocalPlayer

    if localPlayer.Character then
        task.spawn(watch, localPlayer.Character)
    end

    localPlayer.CharacterAdded:Connect(watch)
    local shared = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
    local Simulation = require(shared:WaitForChild("Simulation"))
    Simulation.OnForeignWrite(
        function()
            --[[
              line: 185
              upvalues:
                v6 (ref, index: 1)
            ]]
            v6 = bit32.bor(v6, 2048)
        end
    )

    if guiService:IsTenFootInterface() or userInputService.VREnabled then
        return
    end

    task.spawn(
        function()
            --[[
              line: 192
              upvalues:
                localPlayer (copy, index: 1)
                v6 (ref,  index: 2)
            ]]
            local count, v59

            while true do
                local v60 = setmetatable({localPlayer:GetMouse()}, {__mode = "v"})
                count = 0
                v59 = math.huge

                repeat
                    local v61 = setmetatable({newproxy(true)}, {__mode = "v"})

                    repeat
                        task.wait()
                    until v61[1] == nil

                    if v60[1] ~= nil then
                        count += 1
                        v59 = math.min(v59, os.clock())
                    end
                until v60[1] == nil or 3 <= count and 20 <= os.clock() - v59

                if v60[1] ~= nil then
                    v6 = bit32.bor(v6, 4096)
                    task.wait(10)
                end
            end
        end
    )
end

return v4