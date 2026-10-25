local RunService_upv_1 = game:GetService("RunService")
local tbl_1 = {}
local tbl_upv_2 = {dust = 4, shard = 2, spark = 1, sparkle = 3}
local u1 = nil
local function images()
    --[[
      name: images
      line: 77
      upvalues:
        u1 (ref, index: 1)
    ]]
    if not (u1) then
        local success_1, v1 = pcall(
            function()
                --[[
                  line: 79
                ]]
                return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("UIAssets")))
            end
        )
        local v2
        if (success_1) and type(v1) == "table" then
            v2 = v1
        else
            v2 = {}
            v2.Fx = {}
        end
        u1 = v2
    end
    local v3 = u1.Fx or {}
    return v3
end
local tbl_upv_3 = {}
tbl_upv_3.__index = tbl_upv_3
function tbl_1.Pool(a1, a2, a3)
    --[[
      name: Pool
      line: 104
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v4 = setmetatable({Pace = 1, Layer = a1, _free = {}, _live = {}, _spare = {}, _emitters = {}, _rng = Random.new()}, tbl_upv_3)
    for n_1 = 1, a2 do
        local v5 = Instance.new("ImageLabel")
        v5.Name = "P" .. n_1
        v5.AnchorPoint = Vector2.new(0.5, 0.5)
        v5.Size = UDim2.fromOffset(20, 20)
        v5.BackgroundTransparency = 1
        v5.BorderSizePixel = 0
        v5.ImageTransparency = 1
        v5.Visible = false
        if not (a3) then
            local _ = a1.ZIndex
        end
        v5.ZIndex = a3
        v5.Parent = a1
        v4._free[n_1] = v5
    end
    return v4
end
local function stepPool(a1, a2)
    --[[
      name: stepPool
      line: 131
    ]]
    local v6 = a2 / math.max(a1.Pace, 0.01)
    for n_2 = #a1._emitters, 1, -1 do
        local v7 = a1._emitters[n_2]
        if not (v7.alive) then
            a1._emitters[n_2] = a1._emitters[#a1._emitters]
            a1._emitters[#a1._emitters] = nil
            continue
        end
        v7.acc = v7.acc + (v7.rate * v6)
        if v7.acc >= 1 then
            local v8 = math.floor(v7.acc)
            v7.acc = v7.acc - v8
            a1:Burst(v8, v7.opts)
        end
    end
    local _live_1 = a1._live
    local v9 = 1
    local v10 = v9
    while v10 <= #_live_1 do
        local v11 = _live_1[v10]
        v11.age = v11.age + v6
        local v12 = v11.age / v11.life
        if v12 >= 1 then
            v11.img.Visible = false
            table.insert(a1._free, v11.img)
            table.insert(a1._spare, v11)
            _live_1[v10] = _live_1[#_live_1]
            _live_1[#_live_1] = nil
            v9 = v10
            v10 = v9
            continue
        end
        local v13 = math.max(0, 1 - (v11.drag * v6))
        v11.vx = v11.vx * v13
        v11.vy = (v11.vy * v13) + (v11.grav * v6)
        v11.px = v11.px + (v11.vx * v6)
        v11.py = v11.py + (v11.vy * v6)
        local img_1 = v11.img
        img_1.Position = UDim2.fromOffset(v11.px, v11.py)
        local kind_1 = v11.kind
        if kind_1 == 1 then
            img_1.Rotation = math.deg(math.atan2(v11.vy, v11.vx))
            img_1.Size = UDim2.fromOffset(v11.w * math.clamp(math.sqrt((v11.vx * v11.vx) + (v11.vy * v11.vy)) / 900, 0.35, 1.4), v11.h)
            img_1.ImageTransparency = v11.base + ((1 - v11.base) * (v12 * v12))
            v9 = v10 + 1
            v10 = v9
            continue
        end
        if kind_1 == 3 then
            local v14 = (1 - (v12 * v12)) * ((math.sin(v11.phase + (v11.age * 26)) * 0.25) + 0.75)
            img_1.Size = UDim2.fromOffset(v11.w * v14, v11.w * v14)
            v11.rot = v11.rot + (v11.spin * v6)
            img_1.Rotation = v11.rot
            img_1.ImageTransparency = v11.base + ((1 - v11.base) * (v12 ^ 3))
            v9 = v10 + 1
            v10 = v9
            continue
        end
        if kind_1 ~= 4 then
            v11.rot = v11.rot + (v11.spin * v6)
            img_1.Rotation = v11.rot
            img_1.ImageTransparency = v11.base + ((1 - v11.base) * (v12 * v12))
        else
            local v15 = 1 + (v11.grow - 1) * (1 - ((1 - v12) * (1 - v12)))
            img_1.Size = UDim2.fromOffset(v11.w * v15, v11.h * v15)
            img_1.ImageTransparency = v11.base + ((1 - v11.base) * v12)
        end
        v9 = v10 + 1
        v10 = v9
    end
    if #_live_1 ~= 0 or #a1._emitters ~= 0 or not a1._conn then
        return
    end
    a1._conn:Disconnect()
    a1._conn = nil
end
function tbl_upv_3.Burst(a1, a2, a3)
    --[[
      name: Burst
      line: 199
      upvalues:
        images (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
        stepPool (copy, index: 4)
    ]]
    local v16 = a3 or {}
    local v17 = images()
    local _rng_1 = a1._rng
    local v18 = v16.mode or (((v16.dir) and "point") or "box")
    local v19 = v16.box or (Vector2.zero)
    local v20 = v16.at or (Vector2.zero)
    local v21 = ((v16.whiteChance == nil) and 0.35) or (v16.whiteChance)
    local v22 = v16.white or (Color3.fromRGB(255, 244, 220))
    local v23, v24, v25, v26, v27, v28, v29, v30 = nil, nil, nil, nil, nil, nil, nil, nil
    for _ = 1, a2 do
        local v31 = table.remove(a1._free)
        if not (v31) then
            break
        end
        local v32
        if v16.kind then
            v32 = tbl_upv_2[v16.kind] or 2
        else
            v32 = ((_rng_1:NextNumber() < (v16.sparkChance or 0.55)) and 1) or 2
        end
        local v33
        if v18 ~= "box" then
            local v34 = _rng_1:NextNumber(0, math.tau)
            local v35 = (v16.jitter or 0) * math.sqrt(_rng_1:NextNumber())
            local v46 = v20.X + math.cos(v34) * v35
            local v36 = v20.Y + math.sin(v34) * v35
            local v37 = math.rad(v16.dir or 0)
            if v16.spread == nil then
                v30 = ((v16.dir) and 30) or 180
            else
                v30 = v16.spread
            end
            local v38 = math.rad(v30)
            v24 = v37 + _rng_1:NextNumber(-v38, v38)
            v23, v25, v33 = math.cos(v24), math.sin(v24), v36
        else
            v24 = _rng_1:NextNumber(-v19.X / 2, v19.X / 2)
            local v39 = _rng_1:NextNumber(-v19.Y / 2, v19.Y / 2)
            v23 = (v24 / math.max(v19.X / 2, 1)) * 1.3 + _rng_1:NextNumber(-0.4, 0.4)
            v25 = v39 / math.max(v19.Y / 2, 1) + _rng_1:NextNumber(-0.9, 0.9)
            v28 = v20.X + v24
            v33 = v20.Y + v39
        end
        v24 = math.sqrt((v23 * v23) + (v25 * v25))
        if v24 < 0.01 then
            v23, v24, v25 = 1, 1, 0
        end
        if not (v16.speedMin) or not (v16.speedMax) then
            v26 = (v16.speed or 600) * _rng_1:NextNumber(0.5, 1.15)
            local v40 = v16.size
            local v41
            if v32 == 1 then
                v29 = v16.sparkLen
                if not (v29) then
                    if v16.kind ~= "spark" then
                        v29 = nil
                    else
                        v29 = v40
                    end
                    v29 = v29 or 160
                end
                v41 = _rng_1:NextNumber(v29 * 0.7, v29 * 1.3)
                v27 = _rng_1:NextNumber(10, 16) * (v29 / 160) ^ 0.5
                v31.Image = v17.Spark or ""
            elseif v32 == 2 then
                local v42 = _rng_1:NextNumber(0.6, 1.4) * (v40 or 24)
                v31.Image = v17.Shard or ""
                v41, v27 = v42, v42
            elseif v32 ~= 3 then
                local v43 = _rng_1:NextNumber(0.7, 1.3) * (v40 or 60)
                local v44 = v43 * _rng_1:NextNumber(0.7, 0.9)
                v31.Image = v17.Dust or ""
                v41, v27 = v43, v44
            else
                local v45 = _rng_1:NextNumber(0.6, 1.3) * (v40 or 30)
                v31.Image = v17.Sparkle or ""
                v41, v27 = v45, v45
            end
            if not (v16.colors) or not (#v16.colors > 0) then
                v40 = v16.color or (Color3.fromRGB(255, 200, 80))
                if v32 == 4 or not (_rng_1:NextNumber() < v21) then
                    v30 = v40
                    v31.ImageColor3 = v30
                    v31.Size = UDim2.fromOffset(v41, v27)
                    v31.Position = UDim2.fromOffset(v28, v33)
                    v31.Rotation = 0
                    v31.ImageTransparency = v16.base or 0
                    v31.Visible = true
                    if not (v16.lifeMin) then
                        v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                        v29 = table.remove(a1._spare) or {}
                        v29.img = v31
                        v29.px = v28
                        v29.py = v33
                        v29.vx = v23 / v24 * v26
                        v29.vy = v25 / v24 * v26
                        v29.rot = _rng_1:NextNumber(0, 360)
                        v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                        v29.age = 0
                        v29.life = v40 * (v16.lifeMult or 1)
                        v29.w = v41
                        v29.h = v27
                        v29.kind = v32
                        v29.drag = v16.drag or 2.6
                        v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                        v29.base = v16.base or 0
                        v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                        v29.phase = _rng_1:NextNumber(0, 6.28)
                        table.insert(a1._live, v29)
                        continue
                    end
                    if v16.lifeMax then
                        v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
                    else
                        v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                    end
                    v29 = table.remove(a1._spare) or {}
                    v29.img = v31
                    v29.px = v28
                    v29.py = v33
                    v29.vx = v23 / v24 * v26
                    v29.vy = v25 / v24 * v26
                    v29.rot = _rng_1:NextNumber(0, 360)
                    v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                    v29.age = 0
                    v29.life = v40 * (v16.lifeMult or 1)
                    v29.w = v41
                    v29.h = v27
                    v29.kind = v32
                    v29.drag = v16.drag or 2.6
                    v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                    v29.base = v16.base or 0
                    v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                    v29.phase = _rng_1:NextNumber(0, 6.28)
                    table.insert(a1._live, v29)
                end
                v30 = v22
                v31.ImageColor3 = v30
                v31.Size = UDim2.fromOffset(v41, v27)
                v31.Position = UDim2.fromOffset(v28, v33)
                v31.Rotation = 0
                v31.ImageTransparency = v16.base or 0
                v31.Visible = true
                if not (v16.lifeMin) then
                    v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                    v29 = table.remove(a1._spare) or {}
                    v29.img = v31
                    v29.px = v28
                    v29.py = v33
                    v29.vx = v23 / v24 * v26
                    v29.vy = v25 / v24 * v26
                    v29.rot = _rng_1:NextNumber(0, 360)
                    v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                    v29.age = 0
                    v29.life = v40 * (v16.lifeMult or 1)
                    v29.w = v41
                    v29.h = v27
                    v29.kind = v32
                    v29.drag = v16.drag or 2.6
                    v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                    v29.base = v16.base or 0
                    v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                    v29.phase = _rng_1:NextNumber(0, 6.28)
                    table.insert(a1._live, v29)
                    continue
                end
                if v16.lifeMax then
                    v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
                else
                    v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                end
                v29 = table.remove(a1._spare) or {}
                v29.img = v31
                v29.px = v28
                v29.py = v33
                v29.vx = v23 / v24 * v26
                v29.vy = v25 / v24 * v26
                v29.rot = _rng_1:NextNumber(0, 360)
                v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                v29.age = 0
                v29.life = v40 * (v16.lifeMult or 1)
                v29.w = v41
                v29.h = v27
                v29.kind = v32
                v29.drag = v16.drag or 2.6
                v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                v29.base = v16.base or 0
                v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                v29.phase = _rng_1:NextNumber(0, 6.28)
                table.insert(a1._live, v29)
            end
            v40 = v16.colors[_rng_1:NextInteger(1, #v16.colors)]
            if v32 == 4 or not (_rng_1:NextNumber() < v21) then
                v30 = v40
                v31.ImageColor3 = v30
                v31.Size = UDim2.fromOffset(v41, v27)
                v31.Position = UDim2.fromOffset(v28, v33)
                v31.Rotation = 0
                v31.ImageTransparency = v16.base or 0
                v31.Visible = true
                if not (v16.lifeMin) then
                    v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                    v29 = table.remove(a1._spare) or {}
                    v29.img = v31
                    v29.px = v28
                    v29.py = v33
                    v29.vx = v23 / v24 * v26
                    v29.vy = v25 / v24 * v26
                    v29.rot = _rng_1:NextNumber(0, 360)
                    v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                    v29.age = 0
                    v29.life = v40 * (v16.lifeMult or 1)
                    v29.w = v41
                    v29.h = v27
                    v29.kind = v32
                    v29.drag = v16.drag or 2.6
                    v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                    v29.base = v16.base or 0
                    v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                    v29.phase = _rng_1:NextNumber(0, 6.28)
                    table.insert(a1._live, v29)
                    continue
                end
                if v16.lifeMax then
                    v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
                else
                    v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                end
                v29 = table.remove(a1._spare) or {}
                v29.img = v31
                v29.px = v28
                v29.py = v33
                v29.vx = v23 / v24 * v26
                v29.vy = v25 / v24 * v26
                v29.rot = _rng_1:NextNumber(0, 360)
                v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                v29.age = 0
                v29.life = v40 * (v16.lifeMult or 1)
                v29.w = v41
                v29.h = v27
                v29.kind = v32
                v29.drag = v16.drag or 2.6
                v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                v29.base = v16.base or 0
                v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                v29.phase = _rng_1:NextNumber(0, 6.28)
                table.insert(a1._live, v29)
            end
            v30 = v22
            v31.ImageColor3 = v30
            v31.Size = UDim2.fromOffset(v41, v27)
            v31.Position = UDim2.fromOffset(v28, v33)
            v31.Rotation = 0
            v31.ImageTransparency = v16.base or 0
            v31.Visible = true
            if not (v16.lifeMin) then
                v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                v29 = table.remove(a1._spare) or {}
                v29.img = v31
                v29.px = v28
                v29.py = v33
                v29.vx = v23 / v24 * v26
                v29.vy = v25 / v24 * v26
                v29.rot = _rng_1:NextNumber(0, 360)
                v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                v29.age = 0
                v29.life = v40 * (v16.lifeMult or 1)
                v29.w = v41
                v29.h = v27
                v29.kind = v32
                v29.drag = v16.drag or 2.6
                v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                v29.base = v16.base or 0
                v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                v29.phase = _rng_1:NextNumber(0, 6.28)
                table.insert(a1._live, v29)
                continue
            end
            if v16.lifeMax then
                v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
            else
                v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
            end
            v29 = table.remove(a1._spare) or {}
            v29.img = v31
            v29.px = v28
            v29.py = v33
            v29.vx = v23 / v24 * v26
            v29.vy = v25 / v24 * v26
            v29.rot = _rng_1:NextNumber(0, 360)
            v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
            v29.age = 0
            v29.life = v40 * (v16.lifeMult or 1)
            v29.w = v41
            v29.h = v27
            v29.kind = v32
            v29.drag = v16.drag or 2.6
            v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
            v29.base = v16.base or 0
            v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
            v29.phase = _rng_1:NextNumber(0, 6.28)
            table.insert(a1._live, v29)
        end
        v26 = _rng_1:NextNumber(v16.speedMin, v16.speedMax)
        local v40 = v16.size
        local v41
        if v32 == 1 then
            v29 = v16.sparkLen
            if not (v29) then
                if v16.kind ~= "spark" then
                    v29 = nil
                else
                    v29 = v40
                end
                v29 = v29 or 160
            end
            v41 = _rng_1:NextNumber(v29 * 0.7, v29 * 1.3)
            v27 = _rng_1:NextNumber(10, 16) * (v29 / 160) ^ 0.5
            v31.Image = v17.Spark or ""
        elseif v32 == 2 then
            local v42 = _rng_1:NextNumber(0.6, 1.4) * (v40 or 24)
            v31.Image = v17.Shard or ""
            v41, v27 = v42, v42
        elseif v32 ~= 3 then
            local v43 = _rng_1:NextNumber(0.7, 1.3) * (v40 or 60)
            local v44 = v43 * _rng_1:NextNumber(0.7, 0.9)
            v31.Image = v17.Dust or ""
            v41, v27 = v43, v44
        else
            local v45 = _rng_1:NextNumber(0.6, 1.3) * (v40 or 30)
            v31.Image = v17.Sparkle or ""
            v41, v27 = v45, v45
        end
        if not (v16.colors) or not (#v16.colors > 0) then
            v40 = v16.color or (Color3.fromRGB(255, 200, 80))
            if v32 == 4 or not (_rng_1:NextNumber() < v21) then
                v30 = v40
                v31.ImageColor3 = v30
                v31.Size = UDim2.fromOffset(v41, v27)
                v31.Position = UDim2.fromOffset(v28, v33)
                v31.Rotation = 0
                v31.ImageTransparency = v16.base or 0
                v31.Visible = true
                if not (v16.lifeMin) then
                    v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                    v29 = table.remove(a1._spare) or {}
                    v29.img = v31
                    v29.px = v28
                    v29.py = v33
                    v29.vx = v23 / v24 * v26
                    v29.vy = v25 / v24 * v26
                    v29.rot = _rng_1:NextNumber(0, 360)
                    v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                    v29.age = 0
                    v29.life = v40 * (v16.lifeMult or 1)
                    v29.w = v41
                    v29.h = v27
                    v29.kind = v32
                    v29.drag = v16.drag or 2.6
                    v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                    v29.base = v16.base or 0
                    v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                    v29.phase = _rng_1:NextNumber(0, 6.28)
                    table.insert(a1._live, v29)
                    continue
                end
                if v16.lifeMax then
                    v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
                else
                    v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                end
                v29 = table.remove(a1._spare) or {}
                v29.img = v31
                v29.px = v28
                v29.py = v33
                v29.vx = v23 / v24 * v26
                v29.vy = v25 / v24 * v26
                v29.rot = _rng_1:NextNumber(0, 360)
                v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                v29.age = 0
                v29.life = v40 * (v16.lifeMult or 1)
                v29.w = v41
                v29.h = v27
                v29.kind = v32
                v29.drag = v16.drag or 2.6
                v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                v29.base = v16.base or 0
                v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                v29.phase = _rng_1:NextNumber(0, 6.28)
                table.insert(a1._live, v29)
            end
            v30 = v22
            v31.ImageColor3 = v30
            v31.Size = UDim2.fromOffset(v41, v27)
            v31.Position = UDim2.fromOffset(v28, v33)
            v31.Rotation = 0
            v31.ImageTransparency = v16.base or 0
            v31.Visible = true
            if not (v16.lifeMin) then
                v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                v29 = table.remove(a1._spare) or {}
                v29.img = v31
                v29.px = v28
                v29.py = v33
                v29.vx = v23 / v24 * v26
                v29.vy = v25 / v24 * v26
                v29.rot = _rng_1:NextNumber(0, 360)
                v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                v29.age = 0
                v29.life = v40 * (v16.lifeMult or 1)
                v29.w = v41
                v29.h = v27
                v29.kind = v32
                v29.drag = v16.drag or 2.6
                v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                v29.base = v16.base or 0
                v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                v29.phase = _rng_1:NextNumber(0, 6.28)
                table.insert(a1._live, v29)
                continue
            end
            if v16.lifeMax then
                v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
            else
                v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
            end
            v29 = table.remove(a1._spare) or {}
            v29.img = v31
            v29.px = v28
            v29.py = v33
            v29.vx = v23 / v24 * v26
            v29.vy = v25 / v24 * v26
            v29.rot = _rng_1:NextNumber(0, 360)
            v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
            v29.age = 0
            v29.life = v40 * (v16.lifeMult or 1)
            v29.w = v41
            v29.h = v27
            v29.kind = v32
            v29.drag = v16.drag or 2.6
            v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
            v29.base = v16.base or 0
            v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
            v29.phase = _rng_1:NextNumber(0, 6.28)
            table.insert(a1._live, v29)
        end
        v40 = v16.colors[_rng_1:NextInteger(1, #v16.colors)]
        if v32 == 4 or not (_rng_1:NextNumber() < v21) then
            v30 = v40
            v31.ImageColor3 = v30
            v31.Size = UDim2.fromOffset(v41, v27)
            v31.Position = UDim2.fromOffset(v28, v33)
            v31.Rotation = 0
            v31.ImageTransparency = v16.base or 0
            v31.Visible = true
            if not (v16.lifeMin) then
                v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
                v29 = table.remove(a1._spare) or {}
                v29.img = v31
                v29.px = v28
                v29.py = v33
                v29.vx = v23 / v24 * v26
                v29.vy = v25 / v24 * v26
                v29.rot = _rng_1:NextNumber(0, 360)
                v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
                v29.age = 0
                v29.life = v40 * (v16.lifeMult or 1)
                v29.w = v41
                v29.h = v27
                v29.kind = v32
                v29.drag = v16.drag or 2.6
                v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
                v29.base = v16.base or 0
                v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
                v29.phase = _rng_1:NextNumber(0, 6.28)
                table.insert(a1._live, v29)
                continue
            end
            if v16.lifeMax then
                v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
            else
                v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
            end
            v29 = table.remove(a1._spare) or {}
            v29.img = v31
            v29.px = v28
            v29.py = v33
            v29.vx = v23 / v24 * v26
            v29.vy = v25 / v24 * v26
            v29.rot = _rng_1:NextNumber(0, 360)
            v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
            v29.age = 0
            v29.life = v40 * (v16.lifeMult or 1)
            v29.w = v41
            v29.h = v27
            v29.kind = v32
            v29.drag = v16.drag or 2.6
            v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
            v29.base = v16.base or 0
            v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
            v29.phase = _rng_1:NextNumber(0, 6.28)
            table.insert(a1._live, v29)
        end
        v30 = v22
        v31.ImageColor3 = v30
        v31.Size = UDim2.fromOffset(v41, v27)
        v31.Position = UDim2.fromOffset(v28, v33)
        v31.Rotation = 0
        v31.ImageTransparency = v16.base or 0
        v31.Visible = true
        if not (v16.lifeMin) then
            v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
            v29 = table.remove(a1._spare) or {}
            v29.img = v31
            v29.px = v28
            v29.py = v33
            v29.vx = v23 / v24 * v26
            v29.vy = v25 / v24 * v26
            v29.rot = _rng_1:NextNumber(0, 360)
            v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
            v29.age = 0
            v29.life = v40 * (v16.lifeMult or 1)
            v29.w = v41
            v29.h = v27
            v29.kind = v32
            v29.drag = v16.drag or 2.6
            v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
            v29.base = v16.base or 0
            v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
            v29.phase = _rng_1:NextNumber(0, 6.28)
            table.insert(a1._live, v29)
            continue
        end
        if v16.lifeMax then
            v40 = _rng_1:NextNumber(v16.lifeMin, v16.lifeMax)
        else
            v40 = (v16.life or 1) * _rng_1:NextNumber(0.55, 1)
        end
        v29 = table.remove(a1._spare) or {}
        v29.img = v31
        v29.px = v28
        v29.py = v33
        v29.vx = v23 / v24 * v26
        v29.vy = v25 / v24 * v26
        v29.rot = _rng_1:NextNumber(0, 360)
        v29.spin = _rng_1:NextNumber(-1, 1) * (v16.spin or 540)
        v29.age = 0
        v29.life = v40 * (v16.lifeMult or 1)
        v29.w = v41
        v29.h = v27
        v29.kind = v32
        v29.drag = v16.drag or 2.6
        v29.grav = ((v16.grav == nil) and 420) or (v16.grav)
        v29.base = v16.base or 0
        v29.grow = v16.grow or (((v32 ~= 4) and 1) or 2.2)
        v29.phase = _rng_1:NextNumber(0, 6.28)
        table.insert(a1._live, v29)
    end
    if (a1._conn) or not (#a1._live > 0) and not (#a1._emitters > 0) then
        return
    end
    a1._conn = RunService_upv_1.RenderStepped:Connect(
        function(a4)
            --[[
              line: 283
              upvalues:
                stepPool (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            stepPool(a1, a4)
        end
    )
end
function tbl_upv_3.Emit(a1, a2, a3)
    --[[
      name: Emit
      line: 290
      upvalues:
        RunService_upv_1 (copy, index: 1)
        stepPool (copy, index: 2)
    ]]
    local tbl_upv_4 = {alive = true, acc = 0, opts = 0}
    tbl_upv_4.rate = a2
    tbl_upv_4.opts = a3 or {}
    table.insert(a1._emitters, tbl_upv_4)
    if not (a1._conn) then
        a1._conn = RunService_upv_1.RenderStepped:Connect(
            function(a4)
                --[[
                  line: 294
                  upvalues:
                    stepPool (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                stepPool(a1, a4)
            end
        )
    end
    return function()
        --[[
          line: 298
          upvalues:
            tbl_upv_4 (copy, index: 1)
        ]]
        tbl_upv_4.alive = false
    end
end
function tbl_upv_3.Clear(a1)
    --[[
      name: Clear
      line: 303
    ]]
    for _, value_1 in a1._emitters do
        value_1.alive = false
    end
    table.clear(a1._emitters)
    for _, value_2 in a1._live do
        value_2.img.Visible = false
        table.insert(a1._free, value_2.img)
        table.insert(a1._spare, value_2)
    end
    table.clear(a1._live)
    if not a1._conn then
        return
    end
    a1._conn:Disconnect()
    a1._conn = nil
end
function tbl_upv_3.Count(a1)
    --[[
      name: Count
      line: 320
    ]]
    return #a1._live
end
return tbl_1