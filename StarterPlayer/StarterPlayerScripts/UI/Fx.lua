local runService = game:GetService("RunService")
local v2 = {}
local v3 = {spark = 1, shard = 2, sparkle = 3, dust = 4}
local v4 = nil

local function images()
    --[[
      name: images
      line: 77
      upvalues:
        v4 (ref, index: 1)
    ]]
    if not v4 then
        local success, UIAssets = pcall(
            function()
                --[[
                  line: 79
                ]]
                return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("UIAssets")))
            end
        )

        if not success or type(UIAssets) ~= "table" then
            v4 = {Fx = {}}
        else
            v4 = UIAssets
        end
    end

    return v4.Fx or {}
end

local Class = {}
Class.__index = Class

function v2.Pool(instance: Instance?, endIndex: number, a11)
    --[[
      name: Pool
      line: 104
      upvalues:
        Class (copy, index: 1)
    ]]
    local v12 = setmetatable({Pace = 1, _conn = nil, Layer = instance, _free = {}, _live = {}, _spare = {}, _emitters = {}, _rng = Random.new()}, Class)

    for index = 1, endIndex do
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Name = "P" .. index
        imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        imageLabel.Size = UDim2.fromOffset(20, 20)
        imageLabel.BackgroundTransparency = 1
        imageLabel.BorderSizePixel = 0
        imageLabel.ImageTransparency = 1
        imageLabel.Visible = false
        imageLabel.ZIndex = a11 or instance.ZIndex
        imageLabel.Parent = instance
        v12._free[index] = imageLabel
    end

    return v12
end

local function stepPool(self, deltaTime: number)
    --[[
      name: stepPool
      line: 131
    ]]
    local v18 = deltaTime / math.max(self.Pace, 0.01)

    for emitterKey = #self._emitters, 1, -1 do
        local emitter = self._emitters[emitterKey]

        if emitter.alive then
            emitter.acc += (emitter.rate * v18)

            if 1 <= emitter.acc then
                local flooredValue = math.floor(emitter.acc)
                emitter.acc -= flooredValue
                self:Burst(flooredValue, emitter.opts)
            end
        else
            self._emitters[emitterKey] = self._emitters[#self._emitters]
            self._emitters[#self._emitters] = nil
        end
    end

    local live = self._live
    local index = 1

    while index <= #live do
        local v24 = live[index]
        v24.age += v18
        local v25 = v24.age / v24.life

        if not (1 <= v25) then
            local v26 = math.max(0, 1 - (v24.drag * v18))
            v24.vx *= v26
            v24.vy = v24.vy * v26 + (v24.grav * v18)
            v24.px += (v24.vx * v18)
            v24.py += (v24.vy * v18)
            local img = v24.img
            img.Position = UDim2.fromOffset(v24.px, v24.py)
            local kind = v24.kind

            if kind == 1 then
                img.Rotation = math.deg((math.atan2(v24.vy, v24.vx)))
                local clampedValue = math.clamp(math.sqrt(v24.vx * v24.vx + (v24.vy * v24.vy)) / 900, 0.35, 1.4)
                img.Size = UDim2.fromOffset(v24.w * clampedValue, v24.h)
                img.ImageTransparency = v24.base + ((1 - v24.base) * (v25 * v25))
            elseif kind == 3 then
                local v30 = (1 - (v25 * v25)) * ((math.sin(v24.phase + (v24.age * 26)) * 0.25) + 0.75)
                img.Size = UDim2.fromOffset(v24.w * v30, v24.w * v30)
                v24.rot += (v24.spin * v18)
                img.Rotation = v24.rot
                img.ImageTransparency = v24.base + ((1 - v24.base) * ((function(...) return (...) ^ 3 end)((v25))))
            elseif kind == 4 then
                local v31 = 1 + (v24.grow - 1) * (1 - ((1 - v25) * (1 - v25)))
                img.Size = UDim2.fromOffset(v24.w * v31, v24.h * v31)
                img.ImageTransparency = v24.base + ((1 - v24.base) * v25)
            else
                v24.rot += (v24.spin * v18)
                img.Rotation = v24.rot
                img.ImageTransparency = v24.base + ((1 - v24.base) * (v25 * v25))
            end

            index += 1
        else
            v24.img.Visible = false
            table.insert(self._free, v24.img)
            table.insert(self._spare, v24)
            live[index] = live[#live]
            live[#live] = nil
        end
    end

    if #live == 0 and #self._emitters == 0 and self._conn then
        self._conn:Disconnect()
        self._conn = nil
    end
end

function Class.Burst(self, a33: number, options)
    --[[
      name: Burst
      line: 199
      upvalues:
        images (copy, index: 1)
        v3 (copy, index: 2)
        runService (copy, index: 3)
        stepPool (copy, index: 4)
    ]]
    local v35 = options or {}
    local v36 = images()
    local rng = self._rng
    local v38 = v35.mode or v35.dir and "point" or "box"
    local v39 = v35.box or Vector2.zero
    local v40 = v35.at or Vector2.zero
    local speed = v35.speed or 600
    local v42 = v35.whiteChance == nil and 0.35 or v35.whiteChance
    local v43 = v35.white or Color3.fromRGB(255, 244, 220)
    local rng2 = rng

    for _ = 1, a33 do
        local kind
        local px, py, v49, v50
        local w, h
        local v53
        local img = table.remove(self._free)
        if not img then
            break
        end

        if v35.kind then
            kind = v3[v35.kind] or 2
        else
            kind = not (rng2:NextNumber() < (v35.sparkChance or 0.55)) and 2 or 1
        end

        if v38 == "box" then
            local v55 = rng2:NextNumber(-v39.X / 2, v39.X / 2)
            local v56 = rng2:NextNumber(-v39.Y / 2, v39.Y / 2)
            v49 = (v55 / math.max(v39.X / 2, 1)) * 1.3 + rng2:NextNumber(-0.4, 0.4)
            v50 = v56 / math.max(v39.Y / 2, 1) + rng2:NextNumber(-0.9, 0.9)
            px = v40.X + v55
            py = v40.Y + v56
        else
            local v57
            local jitter = v35.jitter or 0
            local v59 = rng2:NextNumber(0, math.tau)
            local v60 = jitter * math.sqrt((rng2:NextNumber()))
            px = v40.X + math.cos(v59) * v60
            py = v40.Y + math.sin(v59) * v60
            local v61 = math.rad((v35.dir or 0))

            if v35.spread == nil then
                v57 = v35.dir and 30 or 180
            else
                v57 = v35.spread
            end

            local v62 = math.rad(v57)
            local v63 = v61 + rng2:NextNumber(-v62, v62)
            v49 = math.cos(v63)
            v50 = math.sin(v63)
        end

        local v64 = math.sqrt((v49 * v49) + (v50 * v50))

        if v64 < 0.01 then
            v49 = 1
            v50 = 0
            v64 = 1
        end

        local v65 = v49 / v64
        local v66 = v50 / v64
        local v67 = if v35.speedMin and v35.speedMax then rng2:NextNumber(v35.speedMin, v35.speedMax) else speed * rng2:NextNumber(0.5, 1.15)
        local size = v35.size

        if kind == 1 then
            local v69

            if const sparkLen = v35.sparkLen then
                v69 = sparkLen
            else
                if v35.kind ~= "spark" then
                    size = nil
                end

                v69 = size or 160
            end

            w = rng2:NextNumber(v69 * 0.7, v69 * 1.3)
            h = rng2:NextNumber(10, 16) * (function(...) return (...) ^ 0.5 end)(((v69 / 160)))
            img.Image = v36.Spark or ""
        elseif kind == 2 then
            local v71 = rng2:NextNumber(0.6, 1.4) * (size or 24)
            img.Image = v36.Shard or ""
            w, h = v71, v71
        elseif kind == 3 then
            local v72 = rng2:NextNumber(0.6, 1.3) * (size or 30)
            img.Image = v36.Sparkle or ""
            w, h = v72, v72
        else
            w = rng2:NextNumber(0.7, 1.3) * (size or 60)
            h = w * rng2:NextNumber(0.7, 0.9)
            img.Image = v36.Dust or ""
        end

        if v35.colors and 0 < #v35.colors then
            v53 = v35.colors[rng2:NextInteger(1, #v35.colors)]
        else
            v53 = v35.color or Color3.fromRGB(255, 200, 80)
        end

        img.ImageColor3 = if kind ~= 4 and rng2:NextNumber() < v42 then v43 else v53
        img.Size = UDim2.fromOffset(w, h)
        img.Position = UDim2.fromOffset(px, py)
        img.Rotation = 0
        img.ImageTransparency = v35.base or 0
        img.Visible = true
        local v73 = if v35.lifeMin and v35.lifeMax then rng2:NextNumber(v35.lifeMin, v35.lifeMax) else (v35.life or 1) * rng2:NextNumber(0.55, 1)
        local v74 = table.remove(self._spare) or {}
        v74.img = img
        v74.px = px
        v74.py = py
        v74.vx, v74.vy = v65 * v67, v66 * v67
        v74.rot = rng2:NextNumber(0, 360)
        v74.spin = rng2:NextNumber(-1, 1) * (v35.spin or 540)
        v74.age = 0
        v74.life = v73 * (v35.lifeMult or 1)
        v74.w = w
        v74.h = h
        v74.kind = kind
        v74.drag = v35.drag or 2.6
        v74.grav = v35.grav == nil and 420 or v35.grav
        v74.base = v35.base or 0
        v74.grow = v35.grow or kind ~= 4 and 1 or 2.2
        v74.phase = rng2:NextNumber(0, 6.28)
        table.insert(self._live, v74)
    end

    if not (self._conn) and (0 < #self._live or 0 < #self._emitters) then
        self._conn = runService.RenderStepped:Connect(
            function(deltaTime: number)
                --[[
                  line: 283
                  upvalues:
                    stepPool (copy, index: 1)
                    self (copy, index: 2)
                ]]
                stepPool(self, deltaTime)
            end
        )
    end
end

function Class.Emit(self, rate, a78)
    --[[
      name: Emit
      line: 290
      upvalues:
        runService (copy, index: 1)
        stepPool (copy, index: 2)
    ]]
    local v79 = {acc = 0, alive = true, rate = rate, opts = a78 or {}}
    table.insert(self._emitters, v79)

    if not self._conn then
        self._conn = runService.RenderStepped:Connect(
            function(deltaTime: number)
                --[[
                  line: 294
                  upvalues:
                    stepPool (copy, index: 1)
                    self (copy, index: 2)
                ]]
                stepPool(self, deltaTime)
            end
        )
    end

    return function()
        --[[
          line: 298
          upvalues:
            v79 (copy, index: 1)
        ]]
        v79.alive = false
    end
end

function Class.Clear(self)
    --[[
      name: Clear
      line: 303
    ]]
    for _, emitter in self._emitters do
        emitter.alive = false
    end

    table.clear(self._emitters)

    for _, v85 in self._live do
        v85.img.Visible = false
        table.insert(self._free, v85.img)
        table.insert(self._spare, v85)
    end

    table.clear(self._live)

    if self._conn then
        self._conn:Disconnect()
        self._conn = nil
    end
end

function Class.Count(self)
    --[[
      name: Count
      line: 320
    ]]
    return #self._live
end

return v2