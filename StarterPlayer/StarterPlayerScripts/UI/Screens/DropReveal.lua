local Lighting_upv_1 = game:GetService("Lighting")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local ContextActionService_upv_1 = game:GetService("ContextActionService")
local ProximityPromptService_upv_1 = game:GetService("ProximityPromptService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local u1 = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold)
local fromRGB_upv_1 = Color3.fromRGB
local tbl_upv_2 = {}
tbl_upv_2.drop = {burst = 20, wiggle = 5, fit = 0.84, title = "DROP", model = "Drop", idle = 1.2, rays = 0.8, sparkle = 5, primary = fromRGB_upv_1(116, 158, 222), deep = fromRGB_upv_1(16, 28, 54), light = fromRGB_upv_1(186, 212, 246)}
tbl_upv_2.victory = {burst = 30, wiggle = 6, fit = 1, title = "VICTORY DROP", model = "Victory", idle = 1.2, rays = 0.68, sparkle = 8, primary = fromRGB_upv_1(40, 150, 255), deep = fromRGB_upv_1(8, 32, 84), light = fromRGB_upv_1(148, 206, 255)}
tbl_upv_2.golden = {burst = 54, legendary = true, wiggle = 8, fit = 0.98, title = "GOLDEN DROP", model = "Golden", idle = 1.55, rays = 0.52, sparkle = 16, primary = fromRGB_upv_1(255, 186, 46), deep = fromRGB_upv_1(92, 50, 4), light = fromRGB_upv_1(255, 226, 150)}
local tbl_upv_3 = {hold = 0.55, flip = 0.2, openCrouch = 0.1, bar = 0.5, newItem = 2, cardOut = 0.16, dwell = 0.45, count = 0.42, openHold = 0.6, toCards = 0.42, fall = 0.42, cardFly = 0.32, settle = 0.5}
tbl_upv_3.summaryAuto = {robux = 20, lobby = 20, match = 15}
local tbl_upv_4 = {chestCardScale = 0.46, promptY = 332, barW = 330, cardH = 322, chestCardY = 290, titleY = -335, barY = 128, cardW = 232, stageW = 1200, chestY = 20, cardY = -64, stageH = 780}
local tbl_upv_5 = {small = 10, starter = 0, large = 40, medium = 20}
local tbl_upv_6 = {}
tbl_upv_6.small = {10, 20, 40, 80}
tbl_upv_6.medium = {20, 40, 80, 160}
tbl_upv_6.large = {40, 80, 160, 320}
tbl_upv_6.starter = {10, 20, 40, 80}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 103
      upvalues:
        ReplicatedStorage_upv_1 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        tbl_upv_5 (copy, index: 3)
        tbl_upv_6 (copy, index: 4)
        TweenService_upv_1 (copy, index: 5)
        fromRGB_upv_1 (copy, index: 6)
        u1 (copy, index: 7)
        Lighting_upv_1 (copy, index: 8)
        tbl_upv_3 (copy, index: 9)
        tbl_upv_4 (copy, index: 10)
        Workspace_upv_1 (copy, index: 11)
        ProximityPromptService_upv_1 (copy, index: 12)
        tbl_upv_2 (copy, index: 13)
        RunService_upv_1 (copy, index: 14)
        ContextActionService_upv_1 (copy, index: 15)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local u2 = UI_upv_1.Assets.Fx or {}
    local Fx_upv_1 = require(script.Parent.Parent.Fx)
    local Signal_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Signal"))
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local tbl_upv_7 = {}
    tbl_upv_7.Changed = Signal_1.new()
    a1.DropReveal = tbl_upv_7
    local Shared_upv_1 = ReplicatedStorage_upv_1:WaitForChild("Shared")
    local u3 = nil
    local u4 = -math.huge
    local function shards()
        --[[
          name: shards
          line: 120
          upvalues:
            u3 (ref,  index: 1)
            u4 (ref,  index: 2)
            Shared_upv_1 (copy, index: 3)
        ]]
        if u3 then
            return u3
        end
        if os.clock() - u4 < 5 then
            return nil
        end
        u4 = os.clock()
        local Shards_1 = Shared_upv_1:FindFirstChild("Shards")
        if Shards_1 and Shards_1:IsA("ModuleScript") then
            local success_1, v1 = pcall(require, Shards_1)
            if success_1 and type(v1) == "table" then
                u3 = v1
            end
        end
        return u3
    end
    local u5 = nil
    local function sizeOf(a2)
        --[[
          name: sizeOf
          line: 138
          upvalues:
            u5 (ref,  index: 1)
            Shared_upv_1 (copy, index: 2)
        ]]
        if not (u5) then
            local success_2, v2 = pcall(require, Shared_upv_1:FindFirstChild("Unlocks"))
            local v3
            if (success_2) and type(v2) == "table" then
                v3 = v2
            else
                v3 = {}
            end
            u5 = v3
        end
        if type(u5.SizeOf) == "function" then
            local success_3, v4 = pcall(u5.SizeOf, a2)
            if success_3 and type(v4) == "string" then
                return v4
            end
        end
        return "medium"
    end
    local function unlockCost(a3)
        --[[
          name: unlockCost
          line: 152
          upvalues:
            shards (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
            sizeOf (copy, index: 3)
        ]]
        local v5 = shards()
        if v5 and type(v5.UnlockCost) == "function" then
            local success_4, v6 = pcall(v5.UnlockCost, a3)
            if success_4 and type(v6) == "number" then
                return v6
            end
        end
        return tbl_upv_5[sizeOf(a3)] or 20
    end
    local function catColor(a4)
        --[[
          name: catColor
          line: 173
          upvalues:
            a1 (copy, index: 1)
            WeaponInfo_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local Economy_1 = a1.Economy
        if Economy_1 then
            local v7 = nil
            if type(Economy_1.CategoryColor) == "function" then
                local success_5, v7 = pcall(Economy_1.CategoryColor, a4)
                if success_5 and typeof(v7) == "Color3" then
                    return v7
                end
            end
        end
        local v8 = WeaponInfo_upv_1.Get(a4)
        return ((v8 and (WeaponInfo_upv_1.CATEGORY_COLORS)) and (WeaponInfo_upv_1.CATEGORY_COLORS[v8.category])) or (Colors_upv_1.Accent)
    end
    local function catWord(a5)
        --[[
          name: catWord
          line: 184
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v9 = WeaponInfo_upv_1.Get(a5)
        return ((v9 and (WeaponInfo_upv_1.CATEGORY_SINGULAR)) and (WeaponInfo_upv_1.CATEGORY_SINGULAR[v9.category])) or "ITEM"
    end
    local function upgradeCost(a6, a7)
        --[[
          name: upgradeCost
          line: 162
          upvalues:
            shards (copy, index: 1)
            tbl_upv_6 (copy, index: 2)
            sizeOf (copy, index: 3)
        ]]
        local v10 = shards()
        if v10 and type(v10.UpgradeCost) == "function" then
            local success_6, v11 = pcall(v10.UpgradeCost, a6, a7)
            if success_6 then
                if type(v11) ~= "number" then
                    return nil
                end
                return v11
            end
        end
        local v12 = tbl_upv_6[sizeOf(a6)] or (tbl_upv_6.medium)
        return v12[a7]
    end
    local function normStack(a8)
        --[[
          name: normStack
          line: 203
          upvalues:
            shards (copy, index: 1)
            tbl_upv_5 (copy, index: 2)
            sizeOf (copy, index: 3)
            upgradeCost (copy, index: 4)
        ]]
        if type(a8) == "table" and type(a8.item) == "string" then
            local item_1 = a8.item
            local v13 = math.max(0, math.floor(tonumber(a8.shards) or 0))
            local v14 = math.max(0, math.floor(tonumber(a8.before) or 0))
            local v15 = math.max(0, math.floor(tonumber(a8.levelBefore) or 0))
            local tbl_8 = {bonus = 0, unlocked = false, surplus = 0, ready = false}
            tbl_8.item = item_1
            tbl_8.shards = v13
            tbl_8.before = v14
            tbl_8.levelBefore = v15
            tbl_8.total = v14 + v13
            tbl_8.bonus = a8.bonus == true
            local num_1 = tonumber(a8.need)
            local v16, v17 = nil, nil
            if v15 <= 0 then
                local v18
                if (num_1) and (num_1 > 0) then
                    v18 = num_1
                else
                    v17 = shards()
                    if v17 then
                        local v19 = nil
                        if type(v17.UnlockCost) ~= "function" then
                            v18 = tbl_upv_5[sizeOf(item_1)] or 20
                        else
                            local success_7, v19 = pcall(v17.UnlockCost, item_1)
                            if success_7 then
                                if type(v19) ~= "number" then
                                    v18 = tbl_upv_5[sizeOf(item_1)] or 20
                                else
                                    v18 = v19
                                end
                            else
                                v18 = tbl_upv_5[sizeOf(item_1)] or 20
                            end
                        end
                    else
                        v18 = tbl_upv_5[sizeOf(item_1)] or 20
                    end
                end
                tbl_8.need = math.max(1, v18)
                tbl_8.unlocked = true
                if tbl_8.unlocked then
                    tbl_8.surplus = math.max(0, tbl_8.total - tbl_8.need)
                    tbl_8.needAfter = upgradeCost(item_1, 1)
                    v17 = true
                    if a8.ready ~= true then
                        v17 = (tbl_8.needAfter ~= nil) and (tbl_8.needAfter <= tbl_8.surplus)
                    end
                    tbl_8.ready = v17
                    return tbl_8
                end
            else
                if num_1 == nil then
                    tbl_8.need = upgradeCost(item_1, v15)
                else
                    if num_1 > 0 then
                        v16 = num_1
                    else
                        v16 = nil
                    end
                    tbl_8.need = v16
                end
                v16 = tonumber(a8.after)
                if v16 and v14 <= v16 then
                    tbl_8.total = v16
                end
                v17 = true
                if a8.ready ~= true then
                    v17 = (tbl_8.need ~= nil) and (tbl_8.need <= tbl_8.total)
                end
                tbl_8.ready = v17
            end
            return tbl_8
        end
        return nil
    end
    local function normReveal(a9)
        --[[
          name: normReveal
          line: 238
          upvalues:
            normStack (copy, index: 1)
        ]]
        if type(a9) ~= "table" then
            return nil
        end
        local v20
        if a9.kind == "golden" or a9.kind == "victory" then
            v20 = a9.kind
        else
            v20 = "drop"
        end
        local tbl_9 = {}
        if type(a9.stacks) == "table" then
            for _, value_1 in a9.stacks do
                local v21 = normStack(value_1)
                if v21 then
                    table.insert(tbl_9, v21)
                end
            end
        end
        local tbl_10 = {raw = 0, stacks = 0, source = 0, xp = 0}
        tbl_10.id = tostring(a9.id or "")
        tbl_10.kind = v20
        tbl_10.source = type(a9.source) ~= "string" and "match" or a9.source
        tbl_10.stacks = tbl_9
        tbl_10.xp = tonumber(a9.xp)
        tbl_10.raw = a9
        return tbl_10
    end
    tbl_upv_7.Normalize = normReveal
    local u6 = nil
    local DropModels_1 = script.Parent.Parent:FindFirstChild("DropModels")
    if DropModels_1 then
        local success_8, v23 = pcall(require, DropModels_1)
        if success_8 and type(v23) == "table" then
            u6 = v23
        end
    end
    local u7 = 1
    local u8 = false
    local tbl_upv_11 = {}
    local u9 = nil
    local u10 = 0
    local u11 = false
    local function strokeFor(a10, a11)
        --[[
          name: strokeFor
          line: 285
        ]]
        local v24
        if a10:IsA("TextLabel") then
            v24 = a10:FindFirstChildWhichIsA("UIStroke")
        else
            v24 = nil
        end
        if not v24 then
            return nil, 1
        end
        local v25 = v24:GetAttribute("Authored")
        if type(v25) ~= "number" then
            local Transparency_1 = v24.Transparency
            v24:SetAttribute("Authored", Transparency_1)
            v25 = Transparency_1
        end
        if a11 >= 0.99 then
            return v24, 1
        end
        return v24, v25 + ((1 - v25) * a11)
    end
    local function setTT(a12, a13)
        --[[
          name: setTT
          line: 297
          upvalues:
            strokeFor (copy, index: 1)
        ]]
        a12.TextTransparency = a13
        local v26, v27 = strokeFor(a12, a13)
        if not v26 then
            return
        end
        v26.Transparency = v27
    end
    local function tw(a14, a15, a16, a17, a18, a19)
        --[[
          name: tw
          line: 304
          upvalues:
            u7 (ref,  index: 1)
            TweenService_upv_1 (copy, index: 2)
            u9 (ref,  index: 3)
            strokeFor (copy, index: 4)
        ]]
        local v28 = math.max(0, a15 * u7)
        local v29 = a17 or (Enum.EasingStyle.Quint)
        local v30 = TweenInfo.new(v28, v29, a18 or (Enum.EasingDirection.Out), 0, false, (a19 or 0) * u7)
        local v31 = TweenService_upv_1:Create(a14, v30, a16)
        v31:Play()
        if u9 and u9.group then
            table.insert(u9.group, {v31, a14, a16})
        end
        if a16.TextTransparency ~= nil then
            local v32, v33 = strokeFor(a14, a16.TextTransparency)
            if v32 then
                local tbl_12 = {}
                tbl_12.Transparency = v33
                TweenService_upv_1:Create(v32, v30, tbl_12):Play()
                if u9 and u9.group then
                    table.insert(u9.group, {nil, v32, tbl_12})
                end
            end
        end
        return v31
    end
    local function finishGroup()
        --[[
          name: finishGroup
          line: 324
          upvalues:
            u9 (ref, index: 1)
        ]]
        if not u9 or not u9.group then
            return
        end
        for _, value_upv_2 in u9.group do
            if value_upv_2[1] then
                value_upv_2[1]:Cancel()
            end
            for key_upv_1, value_upv_3 in value_upv_2[3] do
                pcall(
                    function()
                        --[[
                          line: 333
                          upvalues:
                            value_upv_2 (copy, index: 1)
                            key_upv_1 (copy, index: 2)
                            value_upv_3 (copy, index: 3)
                        ]]
                        value_upv_2[2][key_upv_1] = value_upv_3
                    end
                )
            end
        end
        table.clear(u9.group)
    end
    local tbl_upv_13 = {pitch = 0, glow = 0, s = 1, lid = 0, raysSpin = 8, y = 0, roll = 0, yaw = 0, sq = 0}
    local tbl_upv_14 = {}
    local tbl_upv_15 = {inQuad = 0, linear = 0, outQuad = 0, outCubic = 0, inOutSine = 0, outBack = 0}
    function tbl_upv_15.linear(a20)
        --[[
          name: linear
          line: 345
        ]]
        return a20
    end
    function tbl_upv_15.outQuad(a21)
        --[[
          name: outQuad
          line: 348
        ]]
        return 1 - ((1 - a21) * (1 - a21))
    end
    function tbl_upv_15.inQuad(a22)
        --[[
          name: inQuad
          line: 351
        ]]
        return a22 * a22
    end
    function tbl_upv_15.outCubic(a23)
        --[[
          name: outCubic
          line: 354
        ]]
        return 1 - ((1 - a23) ^ 3)
    end
    function tbl_upv_15.inOutSine(a24)
        --[[
          name: inOutSine
          line: 357
        ]]
        return -(math.cos(math.pi * a24) - 1) / 2
    end
    function tbl_upv_15.outBack(a25)
        --[[
          name: outBack
          line: 360
        ]]
        return (1 + (2.9 * ((a25 - 1) ^ 3))) + (1.9 * ((a25 - 1) ^ 2))
    end
    local function snapAnims()
        --[[
          name: snapAnims
          line: 373
          upvalues:
            tbl_upv_14 (copy, index: 1)
            tbl_upv_13 (copy, index: 2)
        ]]
        for key_2, value_4 in tbl_upv_14 do
            local v34 = value_4[#value_4]
            if v34 then
                tbl_upv_13[key_2] = v34.to
            end
        end
        table.clear(tbl_upv_14)
    end
    local tbl_upv_16 = {}
    local u12 = nil
    local u13 = CFrame.new()
    local u14 = CFrame.new()
    local u15 = CFrame.lookAt(Vector3.new(0, 4.800000190734863, -14), Vector3.new(0, 2.799999952316284, 0))
    local function build()
        --[[
          name: build
          line: 421
          upvalues:
            u8 (ref,  index: 1)
            a1 (copy, index: 3)
            tbl_upv_11 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u2 (copy, index: 6)
            Fx_upv_1 (copy, index: 7)
            fromRGB_upv_1 (copy, index: 8)
            u15 (copy, index: 9)
            Theme_upv_1 (copy, index: 10)
            Fonts_upv_1 (copy, index: 11)
            u1 (copy, index: 12)
        ]]
        if u8 then
            return
        end
        u8 = true
        local v35, v36 = img_1.Screen("TR_Reveal", 30, a1.PlayerGui, {fullBleed = true})
        v35.Enabled = true
        tbl_upv_11.gui = v35
        tbl_upv_11.canvas = v36
        local v37 = img_1.new("Frame", {Visible = false, Name = "Reveal", Size = UDim2.fromScale(1, 1), Parent = v36})
        tbl_upv_11.root = v37
        tbl_upv_11.dim = img_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = v37})
        tbl_upv_11.tint = img_1.new("ImageLabel", {Name = "Tint", ZIndex = 1, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.3, 1.6), Image = img_1.Assets.Icons.Glow or "", Parent = v37})
        tbl_upv_11.vignette = img_1.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, ZIndex = 2, Size = UDim2.fromScale(1, 1), Image = u2.Vignette or "", ImageColor3 = Colors_upv_1.Void, ScaleType = Enum.ScaleType.Stretch, Parent = v37})
        tbl_upv_11.flash = img_1.new("Frame", {Name = "Flash", BackgroundTransparency = 1, ZIndex = 20, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Accent, Parent = v37})
        tbl_upv_11.catcher = img_1.new("TextButton", {Name = "Input", Modal = true, Selectable = false, ZIndex = 3, Size = UDim2.fromScale(1, 1), Parent = v37})
        local v38 = img_1.new("Frame", {Name = "Stage", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 0), Parent = v37})
        tbl_upv_11.stage = v38
        tbl_upv_11.stageScale = img_1.new("UIScale", {Parent = v38})
        local u16 = img_1.new("Frame", {ZIndex = 4, Name = "Shaker", Size = UDim2.fromOffset(0, 0), Parent = v38})
        tbl_upv_11.shaker = u16
        local function img_1(a26, a27, a28, a29)
            --[[
              name: img
              line: 465
              upvalues:
                u16 (copy, index: 1)
            ]]
            local v39 = a29 or {}
            v39.Name = a26
            v39.AnchorPoint = v39.AnchorPoint or Vector2.new(0.5, 0.5)
            v39.Image = a27 or ""
            v39.ImageTransparency = ((v39.ImageTransparency == nil) and 1) or (v39.ImageTransparency)
            v39.ZIndex = a28
            v39.Parent = v39.Parent or u16
            return UI_upv_1.new("ImageLabel", v39)
        end
        tbl_upv_11.raysHolder = img_1.new("Frame", {ZIndex = 4, Name = "RaysHolder", Size = UDim2.fromOffset(0, 0), Parent = u16})
        tbl_upv_11.raysScale = img_1.new("UIScale", {Parent = tbl_upv_11.raysHolder})
        tbl_upv_11.raysA = img_1("RaysA", u2.Rays, 4, {Size = UDim2.fromOffset(1100, 1100), Parent = tbl_upv_11.raysHolder})
        tbl_upv_11.raysB = img_1("RaysB", u2.RaysThin, 4, {Size = UDim2.fromOffset(1250, 1250), Parent = tbl_upv_11.raysHolder})
        tbl_upv_11.halo = img_1("Halo", img_1.Assets.Icons.Glow, 5, {Size = UDim2.fromOffset(620, 620), Parent = tbl_upv_11.raysHolder})
        tbl_upv_11.backLayer = img_1.new("Frame", {ZIndex = 6, Name = "BackFx", Size = UDim2.fromOffset(0, 0), Parent = u16})
        tbl_upv_11.backPool = Fx_upv_1.Pool(tbl_upv_11.backLayer, 60, 6)
        tbl_upv_11.floorRing = img_1("FloorRing", u2.GlowRing, 6, {Size = UDim2.fromOffset(200, 50)})
        tbl_upv_11.shadow = img_1("Shadow", img_1.Assets.Icons.Glow, 6, {Size = UDim2.fromOffset(380, 76), ImageColor3 = Colors_upv_1.Void})
        tbl_upv_11.beam = img_1("Beam", u2.Beam, 7, {AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(220, 620)})
        tbl_upv_11.chestHolder = img_1.new("Frame", {Name = "Chest", ZIndex = 8, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(600, 600), Parent = u16})
        tbl_upv_11.chestScale = img_1.new("UIScale", {Parent = tbl_upv_11.chestHolder})
        tbl_upv_11.chestGlow = img_1("ChestGlow", img_1.Assets.Icons.Glow, 7, {Size = UDim2.fromOffset(540, 460), Position = UDim2.fromScale(0.5, 0.6), Parent = tbl_upv_11.chestHolder})
        local v42 = img_1.new("ViewportFrame", {LightDirection = Vector3.new(0.44999998807907104, -1, 0.550000011920929), Name = "View", ZIndex = 8, Size = UDim2.fromScale(1, 1), Ambient = fromRGB_upv_1(150, 146, 150), LightColor = fromRGB_upv_1(255, 244, 228), Parent = tbl_upv_11.chestHolder})
        tbl_upv_11.vpf = v42
        local v43 = Instance.new("Camera")
        v43.FieldOfView = 28
        v43.CFrame = u15
        v43.Parent = v42
        v42.CurrentCamera = v43
        tbl_upv_11.cam = v43
        tbl_upv_11.leak = img_1("Leak", img_1.Assets.Icons.Glow, 9, {Size = UDim2.fromOffset(300, 90), Parent = tbl_upv_11.chestHolder})
        tbl_upv_11.leakFlare = img_1("LeakFlare", u2.Flare, 9, {Size = UDim2.fromOffset(420, 44), Parent = tbl_upv_11.chestHolder})
        tbl_upv_11.counter = img_1.new("Frame", {Name = "Counter", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(74, 50), BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.05, Visible = false, ZIndex = 10, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = u16})
        tbl_upv_11.counterStroke = img_1.Stroke(Colors_upv_1.Accent, 2, 0.2)
        tbl_upv_11.counterStroke.Parent = tbl_upv_11.counter
        tbl_upv_11.counterText = img_1.new("TextLabel", {ZIndex = 11, Text = "x3", TextSize = 30, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = tbl_upv_11.counter})
        tbl_upv_11.frontLayer = img_1.new("Frame", {ZIndex = 14, Name = "FrontFx", Size = UDim2.fromOffset(0, 0), Parent = u16})
        tbl_upv_11.frontPool = Fx_upv_1.Pool(tbl_upv_11.frontLayer, 120, 14)
        local function headline_1(a30, a31, a32)
            --[[
              name: headline
              line: 535
              upvalues:
                u1 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                u16 (copy, index: 4)
            ]]
            return UI_upv_1.new("TextLabel", {TextTransparency = 1, Text = "", Name = a30, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(1200, a31 * 1.2), FontFace = u1, TextSize = a31, TextColor3 = Colors_upv_1.Text, ZIndex = a32, Parent = u16})
        end
        tbl_upv_11.titleShadow = headline_1("TitleShadow", 64, 15)
        tbl_upv_11.titleShadow.TextColor3 = Colors_upv_1.Void
        tbl_upv_11.title = headline_1("Title", 64, 16)
        tbl_upv_11.titleScale = img_1.new("UIScale", {Parent = tbl_upv_11.title})
        tbl_upv_11.titleShadowScale = img_1.new("UIScale", {Parent = tbl_upv_11.titleShadow})
        tbl_upv_11.titleGrad = img_1.new("UIGradient", {Rotation = 90, Parent = tbl_upv_11.title})
        tbl_upv_11.subtitle = img_1.new("TextLabel", {TextTransparency = 1, Text = "", Name = "Subtitle", ZIndex = 16, TextSize = 22, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(800, 30), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = u16})
        img_1.TextStroke(Colors_upv_1.Void, 1.5, 0.5).Parent = tbl_upv_11.subtitle
        local subtitle_1 = tbl_upv_11.subtitle
        subtitle_1.TextTransparency = 1
        if subtitle_1:IsA("TextLabel") then
            v43 = subtitle_1:FindFirstChildWhichIsA("UIStroke")
        else
            v43 = nil
        end
        local v44, v45
        if v43 then
            if type(v43:GetAttribute("Authored")) ~= "number" then
                v43:SetAttribute("Authored", v43.Transparency)
            end
            v44, v45 = v43, 1
        else
            v44 = nil
            v45 = 1
        end
        if v44 then
            v44.Transparency = v45
        end
        tbl_upv_11.prompt = img_1.new("Frame", {Name = "OpenPrompt", AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(190, 52), BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.15, Visible = false, ZIndex = 16, ClipsDescendants = true, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = u16})
        tbl_upv_11.promptScale = img_1.GetScaleObj(tbl_upv_11.prompt, "AnimScale")
        tbl_upv_11.promptStroke = img_1.Stroke(Colors_upv_1.Accent, 2, 0.25)
        tbl_upv_11.promptStroke.Parent = tbl_upv_11.prompt
        tbl_upv_11.promptFill = img_1.new("Frame", {Name = "Auto", BackgroundTransparency = 0.55, ZIndex = 16, Size = UDim2.fromScale(0, 1), BackgroundColor3 = Colors_upv_1.Accent, Parent = tbl_upv_11.prompt})
        tbl_upv_11.promptText = img_1.new("TextLabel", {ZIndex = 17, Text = "OPEN", TextSize = 26, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = tbl_upv_11.prompt})
        local v46 = img_1.new("Frame", {Name = "Card", ZIndex = 12, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(232, 322), Parent = u16})
        tbl_upv_11.card = v46
        tbl_upv_11.cardScale = img_1.new("UIScale", {Parent = v46})
        tbl_upv_11.cardGlow = img_1("CardGlow", img_1.Assets.Icons.Glow, 11, {Size = UDim2.fromOffset(487.20000000000005, 611.8), Position = UDim2.fromScale(0.5, 0.5), Parent = v46})
        local v47 = img_1.new("Frame", {Name = "Back", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 12, [1] = img_1.Corner(18), Parent = v46})
        tbl_upv_11.backGrad = img_1.new("UIGradient", {Rotation = 90, Parent = v47})
        tbl_upv_11.backStroke = img_1.Stroke(Colors_upv_1.Accent, 3, 0.1)
        tbl_upv_11.backStroke.Parent = v47
        tbl_upv_11.backArt = img_1("Art", u2.CardBack, 13, {ImageTransparency = 0.15, AnchorPoint = Vector2.zero, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Stretch, Parent = v47})
        tbl_upv_11.back = v47
        local v48 = img_1.new("Frame", {Name = "Face", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), Visible = false, ZIndex = 12, [1] = img_1.Corner(18), Parent = v46})
        tbl_upv_11.faceGrad = img_1.new("UIGradient", {Rotation = 90, Parent = v48})
        tbl_upv_11.faceStroke = img_1.Stroke(Colors_upv_1.Accent, 3, 0.05)
        tbl_upv_11.faceStroke.Parent = v48
        tbl_upv_11.face = v48
        local v49 = img_1.new("Frame", {Name = "Well", Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 206), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.45, ZIndex = 13, [1] = img_1.Corner(12), Parent = v48})
        tbl_upv_11.well = v49
        tbl_upv_11.wellGlow = img_1("WellGlow", img_1.Assets.Icons.Glow, 13, {ImageTransparency = 0.5, Size = UDim2.fromScale(1.1, 1.1), Position = UDim2.fromScale(0.5, 0.5), Parent = v49})
        tbl_upv_11.icon = img_1.new("Frame", {Name = "Icon", ZIndex = 14, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(196, 196), Parent = v49})
        tbl_upv_11.iconScale = img_1.new("UIScale", {Parent = tbl_upv_11.icon})
        tbl_upv_11.tag = img_1.new("Frame", {Name = "Tag", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 6), Size = UDim2.fromOffset(74, 26), BackgroundColor3 = Colors_upv_1.Gold, ZIndex = 15, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = v49})
        tbl_upv_11.tagText = img_1.new("TextLabel", {ZIndex = 16, Text = "NEW", TextSize = 16, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextDark, Parent = tbl_upv_11.tag})
        tbl_upv_11.cat = img_1.new("TextLabel", {Text = "BOW", Name = "Category", ZIndex = 16, TextSize = 14, Position = UDim2.fromOffset(10, 8), Size = UDim2.fromOffset(150, 22), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, Parent = v49})
        tbl_upv_11.name = img_1.new("TextLabel", {Text = "", Name = "ItemName", ZIndex = 14, TextSize = 26, Position = UDim2.fromOffset(12, 222), Size = UDim2.new(1, -24, 0, 30), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v48})
        img_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = tbl_upv_11.name
        tbl_upv_11.count = img_1.new("Frame", {Name = "Count", ZIndex = 14, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 258), Size = UDim2.fromOffset(160, 50), Parent = v48})
        tbl_upv_11.countScale = img_1.new("UIScale", {Parent = tbl_upv_11.count})
        tbl_upv_11.gem = img_1("Gem", u2.Gem, 15, {ImageTransparency = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(40, 40), Parent = tbl_upv_11.count})
        tbl_upv_11.countText = img_1.new("TextLabel", {Text = "x0", Name = "N", ZIndex = 15, TextSize = 40, Position = UDim2.fromOffset(54, 0), Size = UDim2.new(1, -54, 1, 0), FontFace = Fonts_upv_1.Display, TextXAlignment = Enum.TextXAlignment.Left, Parent = tbl_upv_11.count})
        img_1.TextStroke(Colors_upv_1.Void, 2, 0.35).Parent = tbl_upv_11.countText
        tbl_upv_11.sheen = img_1.new("Frame", {Name = "Sheen", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 17, [1] = img_1.Corner(18), Parent = v46})
        tbl_upv_11.sheenGrad = img_1.new("UIGradient", {Rotation = 25, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.42, 1), NumberSequenceKeypoint.new(0.5, 0.35), NumberSequenceKeypoint.new(0.58, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-1, 0), Parent = tbl_upv_11.sheen})
        tbl_upv_11.stamp = img_1.new("Frame", {Name = "Stamp", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0, 158), Size = UDim2.fromOffset(250, 52), BackgroundColor3 = Colors_upv_1.Success, Rotation = -8, Visible = false, ZIndex = 18, [1] = img_1.Corner(12), Parent = v46})
        img_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Success, 0.12), Colors_upv_1.SuccessDark, 90).Parent = tbl_upv_11.stamp
        img_1.Stroke(fromRGB_upv_1(200, 255, 214), 3, 0.15).Parent = tbl_upv_11.stamp
        tbl_upv_11.stampScale = img_1.new("UIScale", {Parent = tbl_upv_11.stamp})
        img_1.Icon("chevUp", 26, Colors_upv_1.Text, {ZIndex = 19, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, -1), Parent = tbl_upv_11.stamp})
        img_1.new("TextLabel", {ZIndex = 19, Text = "UPGRADE READY", TextSize = 25, Position = UDim2.fromOffset(40, 0), Size = UDim2.new(1, -46, 1, 0), FontFace = Fonts_upv_1.Display, Parent = tbl_upv_11.stamp})
        local v50 = img_1.new("Frame", {Name = "Bar", ZIndex = 12, Visible = false, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.fromOffset(330, 62), Parent = u16})
        tbl_upv_11.barBox = v50
        tbl_upv_11.barCaption = img_1.new("TextLabel", {RichText = true, Text = "", Name = "Caption", ZIndex = 12, TextSize = 17, Size = UDim2.new(1, 0, 0, 22), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, Parent = v50})
        img_1.TextStroke(Colors_upv_1.Void, 1.5, 0.45).Parent = tbl_upv_11.barCaption
        local v51 = {}
        v51.Name = "Track"
        v51.Position = UDim2.fromOffset(0, 28)
        v51.Size = UDim2.new(1, 0, 0, 30)
        v51.BackgroundColor3 = Colors_upv_1.Void
        v51.BackgroundTransparency = 0.2
        v51.ClipsDescendants = true
        v51.ZIndex = 12
        v51[1], v51[2] = img_1.Corner(Theme_upv_1.Radius.Pill), img_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.75)
        v51.Parent = v50
        local v52 = img_1.new("Frame", v51)
        tbl_upv_11.track = v52
        tbl_upv_11.barFill = img_1.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 13, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = v52})
        tbl_upv_11.barGrad = img_1.new("UIGradient", {Rotation = 90, Parent = tbl_upv_11.barFill})
        tbl_upv_11.barText = img_1.new("TextLabel", {Name = "N", ZIndex = 15, Text = "", TextSize = 20, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = v52})
        img_1.TextStroke(Colors_upv_1.Void, 2, 0.3).Parent = tbl_upv_11.barText
        tbl_upv_11.barHead = img_1("Head", u2.Sparkle, 14, {Position = UDim2.fromOffset(0, 43), Size = UDim2.fromOffset(54, 54), Parent = v50})
        tbl_upv_11.barFlash = img_1.new("Frame", {Name = "Flash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Gold, BackgroundTransparency = 1, ZIndex = 14, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = v52})
        local u17 = img_1.new("Frame", {Visible = false, Name = "NewItem", ZIndex = 13, Size = UDim2.fromOffset(0, 0), Parent = u16})
        tbl_upv_11.newRoot = u17
        tbl_upv_11.newDim = img_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, ZIndex = 20, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(6000, 4000), BackgroundColor3 = Colors_upv_1.Void, Parent = u17})
        tbl_upv_11.newRaysA = img_1("RaysA", u2.Rays, 21, {Size = UDim2.fromOffset(1300, 1300), Position = UDim2.fromOffset(0, -40), Parent = u17})
        tbl_upv_11.newRaysB = img_1("RaysB", u2.RaysThin, 21, {Size = UDim2.fromOffset(1500, 1500), Position = UDim2.fromOffset(0, -40), Parent = u17})
        tbl_upv_11.newGlow = img_1("Glow", img_1.Assets.Icons.Glow, 22, {Size = UDim2.fromOffset(760, 760), Position = UDim2.fromOffset(0, -40), Parent = u17})
        tbl_upv_11.newRing = img_1("Ring", u2.GlowRing, 22, {Size = UDim2.fromOffset(200, 200), Position = UDim2.fromOffset(0, -40), Parent = u17})
        tbl_upv_11.newFlare = img_1("Flare", u2.Flare, 25, {Size = UDim2.fromOffset(1400, 140), Position = UDim2.fromOffset(0, -270), Parent = u17})
        tbl_upv_11.newItem = img_1.new("Frame", {Name = "Item", ZIndex = 23, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, -40), Size = UDim2.fromOffset(400, 400), Parent = u17})
        tbl_upv_11.newItemScale = img_1.new("UIScale", {Parent = tbl_upv_11.newItem})
        local function newText_1(a33, a34, a35, a36)
            --[[
              name: newText
              line: 767
              upvalues:
                u1 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                u17 (copy, index: 4)
            ]]
            local new_1 = UI_upv_1.new
            local tbl_17 = {FontFace = 0, TextColor3 = 0, TextTransparency = 1, Text = "", Parent = 0, ZIndex = 0, TextSize = 0}
            tbl_17.Name = a33
            tbl_17.AnchorPoint = Vector2.new(0.5, 0.5)
            tbl_17.Size = UDim2.fromOffset(1400, a34 * 1.25)
            tbl_17.FontFace = a36 or u1
            tbl_17.TextSize = a34
            tbl_17.TextColor3 = Colors_upv_1.Text
            tbl_17.ZIndex = a35
            tbl_17.Parent = u17
            return new_1("TextLabel", tbl_17)
        end
        tbl_upv_11.newAura = newText_1("Aura", 104, 24)
        tbl_upv_11.newAuraScale = img_1.new("UIScale", {Parent = tbl_upv_11.newAura})
        tbl_upv_11.newShadow = newText_1("Shadow", 104, 24)
        tbl_upv_11.newShadow.TextColor3 = Colors_upv_1.Void
        tbl_upv_11.newShadowScale = img_1.new("UIScale", {Parent = tbl_upv_11.newShadow})
        tbl_upv_11.newHead = newText_1("Headline", 104, 26)
        tbl_upv_11.newHeadScale = img_1.new("UIScale", {Parent = tbl_upv_11.newHead})
        tbl_upv_11.newHeadGrad = img_1.new("UIGradient", {Rotation = 90, Parent = tbl_upv_11.newHead})
        tbl_upv_11.newName = newText_1("ItemName", 50, 26, Fonts_upv_1.Display)
        img_1.TextStroke(Colors_upv_1.Void, 2, 0.35).Parent = tbl_upv_11.newName
        tbl_upv_11.newSub = newText_1("Sub", 20, 26, Fonts_upv_1.Heavy)
        tbl_upv_11.newSub.TextColor3 = Colors_upv_1.TextDim
        img_1.TextStroke(Colors_upv_1.Void, 1.5, 0.45).Parent = tbl_upv_11.newSub
        local newName_1 = tbl_upv_11.newName
        newName_1.TextTransparency = 1
        if newName_1:IsA("TextLabel") then
            v44 = newName_1:FindFirstChildWhichIsA("UIStroke")
        else
            v44 = nil
        end
        local sumTotals_1
        if v44 then
            if type(v44:GetAttribute("Authored")) ~= "number" then
                v44:SetAttribute("Authored", v44.Transparency)
            end
            sumTotals_1, v51 = v44, 1
        else
            sumTotals_1 = nil
            v51 = 1
        end
        if sumTotals_1 then
            sumTotals_1.Transparency = v51
        end
        local newSub_1 = tbl_upv_11.newSub
        newSub_1.TextTransparency = 1
        if newSub_1:IsA("TextLabel") then
            v38 = newSub_1:FindFirstChildWhichIsA("UIStroke")
        else
            v38 = nil
        end
        if v38 then
            if type(v38:GetAttribute("Authored")) ~= "number" then
                v38:SetAttribute("Authored", v38.Transparency)
            end
            sumTotals_1, v51 = v38, 1
        else
            sumTotals_1, v51 = nil, 1
        end
        if sumTotals_1 then
            sumTotals_1.Transparency = v51
        end
        local v54 = img_1.new("Frame", {Visible = false, Name = "Summary", ZIndex = 12, Size = UDim2.fromOffset(0, 0), Parent = u16})
        tbl_upv_11.sumRoot = v54
        tbl_upv_11.sumRow = img_1.new("Frame", {Name = "Row", ZIndex = 12, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, -40), Size = UDim2.fromOffset(0, 0), Parent = v54})
        tbl_upv_11.sumTotals = img_1.new("TextLabel", {RichText = true, AutoLocalize = false, Text = "", Name = "Totals", ZIndex = 13, TextSize = 28, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, 150), Size = UDim2.fromOffset(900, 34), FontFace = Fonts_upv_1.Display, Parent = v54})
        img_1.TextStroke(Colors_upv_1.Void, 2, 0.35).Parent = tbl_upv_11.sumTotals
        sumTotals_1 = tbl_upv_11.sumTotals
        sumTotals_1.TextTransparency = 1
        local v55
        if sumTotals_1:IsA("TextLabel") then
            v55 = sumTotals_1:FindFirstChildWhichIsA("UIStroke")
        else
            v55 = nil
        end
        local v56
        if v55 then
            if type(v55:GetAttribute("Authored")) ~= "number" then
                v55:SetAttribute("Authored", v55.Transparency)
            end
            v51, v56 = v55, 1
        else
            v51 = nil
            v56 = 1
        end
        if v51 then
            v51.Transparency = v56
        end
        tbl_upv_11.cont = img_1.new("TextButton", {Name = "Continue", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(0, 236), Size = UDim2.fromOffset(280, 60), BackgroundColor3 = Colors_upv_1.Accent, ClipsDescendants = true, ZIndex = 16, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = v54})
        tbl_upv_11.contGrad = img_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Accent, 0.12), Colors_upv_1.AccentDark, 90)
        tbl_upv_11.contGrad.Parent = tbl_upv_11.cont
        tbl_upv_11.contScale = img_1.new("UIScale", {Parent = tbl_upv_11.cont})
        tbl_upv_11.contFill = img_1.new("Frame", {Name = "Auto", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.8, ZIndex = 16, [1] = img_1.Corner(Theme_upv_1.Radius.Pill), Parent = tbl_upv_11.cont})
        tbl_upv_11.contFillGrad = img_1.new("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.501, 1), NumberSequenceKeypoint.new(1, 1)}), Offset = Vector2.new(-0.5, 0), Parent = tbl_upv_11.contFill})
        img_1.new("TextLabel", {ZIndex = 17, Text = "CONTINUE", TextSize = 28, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, Parent = tbl_upv_11.cont})
        tbl_upv_11.tiles = {}
        local tbl_18 = {}
        tbl_18.Name = "Skip"
        tbl_18.AnchorPoint = Vector2.new(1, 1)
        tbl_18.Size = UDim2.fromOffset(128, 52)
        tbl_18.BackgroundColor3 = Colors_upv_1.Panel
        tbl_18.BackgroundTransparency = 0.12
        tbl_18.Text = ""
        tbl_18.Visible = false
        tbl_18.ZIndex = 30
        tbl_18.ClipsDescendants = true
        tbl_18[1], tbl_18[2] = img_1.Corner(10), img_1.Stroke(Colors_upv_1.Text, 1, 0.8)
        tbl_18.Parent = v37
        tbl_upv_11.skip = img_1.new("TextButton", tbl_18)
        tbl_upv_11.skipScale = img_1.new("UIScale", {Parent = tbl_upv_11.skip})
        tbl_upv_11.skipFill = img_1.new("Frame", {Name = "Hold", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Colors_upv_1.Text, BackgroundTransparency = 0.82, ZIndex = 30, [1] = img_1.Corner(10), Parent = tbl_upv_11.skip})
        img_1.new("TextLabel", {ZIndex = 31, Text = "SKIP  \226\128\186", TextSize = 22, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = tbl_upv_11.skip})
        tbl_upv_11.safe = img_1.new("ScreenGui", {ResetOnSpawn = false, IgnoreGuiInset = true, Name = "TR_RevealSafe", Parent = a1.PlayerGui})
        pcall(
            function()
                --[[
                  line: 865
                  upvalues:
                    tbl_upv_11 (copy, index: 1)
                ]]
                tbl_upv_11.safe.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
            end
        )
    end
    local function layout()
        --[[
          name: layout
          line: 871
          upvalues:
            u8 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_11 (copy, index: 3)
        ]]
        if not u8 then
            return
        end
        local v57 = UI_upv_1.CanvasSize()
        local v58 = UI_upv_1.TopInset()
        tbl_upv_11.stageScale.Scale = math.min(1, ((v57.Y - (v58 * 0.5)) - 6) / 780, (v57.X - 20) / 1200)
        tbl_upv_11.stage.Position = UDim2.new(0.5, 0, 0.5, math.floor(v58 * 0.25))
        local v59 = v57 * UI_upv_1.Scale
        if v59.Y < 560 then
            v58 = math.clamp(v59.Y / 620, 0.5, 1)
        else
            v58 = math.clamp(v59.Y / 900, 0.6, 1.4)
        end
        v57 = math.floor((v58 * 50) + 0.5) * 0.5
        local v60 = 0
        local v61 = 0
        if not UI_upv_1.DebugDevice and tbl_upv_11.safe.AbsoluteSize.X > 0 then
            local v62 = tbl_upv_11.gui.AbsolutePosition + tbl_upv_11.gui.AbsoluteSize
            local v63 = tbl_upv_11.safe.AbsolutePosition + tbl_upv_11.safe.AbsoluteSize
            v60, v61 = math.max(0, v62.X - v63.X), math.max(0, v62.Y - v63.Y)
        end
        tbl_upv_11.skip.Position = UDim2.new(1, -((v60 + math.floor(math.clamp(v59.X * 0.0225, 12, 44) + 0.5)) + v57) / UI_upv_1.Scale, 1, -((v61 + math.floor(math.clamp(v59.Y * 0.03, 10, 30) + 0.5)) + v57) / UI_upv_1.Scale)
        tbl_upv_11.skipScale.Scale = v58 / UI_upv_1.Scale
        local Compact_1 = UI_upv_1.Compact
        tbl_upv_11.subtitle.TextSize = (Compact_1 and 28) or 22
        tbl_upv_11.barCaption.TextSize = (Compact_1 and 23) or 17
        tbl_upv_11.barText.TextSize = (Compact_1 and 25) or 20
        tbl_upv_11.cat.TextSize = (Compact_1 and 18) or 14
        tbl_upv_11.tagText.TextSize = (Compact_1 and 19) or 16
        local tag_1 = tbl_upv_11.tag
        local v64
        if Compact_1 then
            v64 = UDim2.fromOffset(92, 30)
        else
            v64 = UDim2.fromOffset(74, 26)
        end
        tag_1.Size = v64
        tbl_upv_11.sumTotals.TextSize = (Compact_1 and 34) or 28
        tbl_upv_11.newSub.TextSize = (Compact_1 and 26) or 20
    end
    local function clearChest()
        --[[
          name: clearChest
          line: 911
          upvalues:
            tbl_upv_16 (copy, index: 1)
            u12 (ref,  index: 2)
        ]]
        for _, value_5 in tbl_upv_16 do
            value_5.part:Destroy()
        end
        table.clear(tbl_upv_16)
        u12 = nil
    end
    local function buildChest(a37, a38)
        --[[
          name: buildChest
          line: 918
          upvalues:
            tbl_upv_16 (copy, index: 1)
            u12 (ref,  index: 2)
            u6 (ref,  index: 3)
            u13 (ref,  index: 4)
            u14 (ref,  index: 5)
            fromRGB_upv_1 (copy, index: 6)
            tbl_upv_11 (copy, index: 7)
        ]]
        for _, value_6 in tbl_upv_16 do
            value_6.part:Destroy()
        end
        table.clear(tbl_upv_16)
        u12 = nil
        local v65 = u6 and (u6[a37])
        if not (v65) then
            local tbl_19 = {}
            tbl_19.size = {5, 3.6, 3.4}
            tbl_19.hinge = {0, 2.2, 1.7}
            tbl_19.parts = {{mesh = "", tex = "", material = "Wood", lid = false, size = {5, 2.2, 3.4}, scale = {1, 1, 1}, cf = {0, 1.1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1}, color = {150, 96, 52}}, {mesh = "", tex = "", material = "Wood", lid = true, size = {5.1, 1.4, 3.5}, scale = {1, 1, 1}, cf = {0, 2.9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1}, color = {172, 112, 60}}}
            v65 = tbl_19
        end
        u12 = v65
        u13 = CFrame.new(v65.hinge[1] * a38, v65.hinge[2] * a38, v65.hinge[3] * a38)
        u14 = u13:Inverse()
        local v66 = nil
        for _, value_upv_7 in v65.parts do
            local u18 = Instance.new("Part")
            u18.Anchored = true
            u18.CanCollide = false
            u18.CanQuery = false
            u18.CanTouch = false
            u18.CastShadow = false
            u18.Size = Vector3.new(value_upv_7.size[1] * a38, value_upv_7.size[2] * a38, value_upv_7.size[3] * a38)
            u18.Color = fromRGB_upv_1(value_upv_7.color[1], value_upv_7.color[2], value_upv_7.color[3])
            pcall(
                function()
                    --[[
                      line: 945
                      upvalues:
                        u18 (copy, index: 1)
                        value_upv_7 (copy, index: 2)
                    ]]
                    u18.Material = Enum.Material[value_upv_7.material]
                end
            )
            u18.TopSurface = Enum.SurfaceType.Smooth
            u18.BottomSurface = Enum.SurfaceType.Smooth
            local v67 = CFrame.new(table.unpack(value_upv_7.cf))
            local v68 = nil
            local v69 = Vector3.new(value_upv_7.scale[1], value_upv_7.scale[2], value_upv_7.scale[3]) * a38
            if value_upv_7.mesh == "" then
                v66 = v68
            else
                local v70 = Instance.new("SpecialMesh")
                v70.MeshType = Enum.MeshType.FileMesh
                v70.MeshId = value_upv_7.mesh
                v70.TextureId = value_upv_7.tex
                v70.Scale = v69
                v70.Parent = u18
                v66 = v70
            end
            u18.Parent = tbl_upv_11.vpf
            local tbl_20 = {lid = 0, scale = 0, size = 0}
            tbl_20.part = u18
            tbl_20.mesh = v66
            tbl_20.cf = v67.Rotation + (v67.Position * a38)
            tbl_20.lid = value_upv_7.lid == true
            tbl_20.scale = v69
            tbl_20.size = u18.Size
            table.insert(tbl_upv_16, tbl_20)
        end
    end
    local function applyPose()
        --[[
          name: applyPose
          line: 968
          upvalues:
            u12 (ref,  index: 1)
            tbl_upv_13 (copy, index: 2)
            tbl_upv_16 (copy, index: 3)
            u13 (ref,  index: 4)
            u14 (ref,  index: 5)
        ]]
        if not u12 then
            return
        end
        local sq_1 = tbl_upv_13.sq
        local v71 = (1 - sq_1) * tbl_upv_13.s
        local v72 = (1 + (sq_1 * 0.55)) * tbl_upv_13.s
        local v73 = CFrame.new(0, tbl_upv_13.y, 0) * CFrame.Angles(0, 0.4188790204786391 + tbl_upv_13.yaw, 0) * CFrame.Angles(tbl_upv_13.pitch, 0, tbl_upv_13.roll)
        local v74 = CFrame.Angles(math.rad(tbl_upv_13.lid), 0, 0)
        for _, value_8 in tbl_upv_16 do
            local cf_1 = value_8.cf
            cf_1 = ((value_8.lid) and ((u13 * v74) * u14 * cf_1)) or cf_1
            local Position_1 = cf_1.Position
            local Rotation_1 = cf_1.Rotation
            value_8.part.CFrame = v73 * (CFrame.new(Position_1.X * v72, Position_1.Y * v71, Position_1.Z * v72) * Rotation_1)
            local RightVector_1 = Rotation_1.RightVector
            local UpVector_1 = Rotation_1.UpVector
            local LookVector_1 = Rotation_1.LookVector
            local v75 = math.abs(RightVector_1.Y) * v71 + (1 - math.abs(RightVector_1.Y)) * v72
            local v76 = math.abs(UpVector_1.Y) * v71 + (1 - math.abs(UpVector_1.Y)) * v72
            local v77 = math.abs(LookVector_1.Y) * v71 + (1 - math.abs(LookVector_1.Y)) * v72
            if value_8.mesh then
                value_8.mesh.Scale = value_8.scale * Vector3.new(v75, v76, v77)
            else
                value_8.part.Size = value_8.size * Vector3.new(v75, v76, v77)
            end
        end
    end
    local function chestHeight()
        --[[
          name: chestHeight
          line: 1010
          upvalues:
            u12 (ref, index: 1)
            u9 (ref, index: 2)
        ]]
        if not u12 then
            return 4
        end
        local v78 = u12.size[2]
        local v79 = (u9 and (u9.look.fit)) or 1
        return v78 * v79
    end
    local function frontZ()
        --[[
          name: frontZ
          line: 1014
          upvalues:
            u12 (ref, index: 1)
            u9 (ref, index: 2)
        ]]
        local v80
        if u12 then
            local _ = u12.size[3]
            local v81 = u9 and u9.look.fit or 1
            v80 = u12.size[3] * (u9 and u9.look.fit or 1) / 2
        else
            v80 = 1.7
        end
        return -v80
    end
    local function seamPoint()
        --[[
          name: seamPoint
          line: 1019
          upvalues:
            u13 (ref, index: 1)
            u12 (ref, index: 2)
            u9 (ref, index: 3)
        ]]
        local Y_1 = u13.Position.Y
        local v81
        if u12 then
            local _ = u12.size[3]
            local v82 = u9 and u9.look.fit or 1
            v81 = u12.size[3] * (u9 and u9.look.fit or 1) / 2
        else
            v81 = 1.7
        end
        return (Vector3.new(0, Y_1, -v81))
    end
    local function mouthPoint()
        --[[
          name: mouthPoint
          line: 1022
          upvalues:
            u13 (ref, index: 1)
        ]]
        return (Vector3.new(0, u13.Position.Y + 0.2, 0))
    end
    local function project(a39)
        --[[
          name: project
          line: 998
          upvalues:
            tbl_upv_13 (copy, index: 1)
            u15 (copy, index: 2)
            tbl_upv_11 (copy, index: 3)
        ]]
        local v82 = u15:PointToObjectSpace((CFrame.new(0, tbl_upv_13.y, 0) * CFrame.Angles(0, 0.4188790204786391 + tbl_upv_13.yaw, 0)) * a39)
        local Size_1 = tbl_upv_11.chestHolder.Size
        local Offset_1 = Size_1.X.Offset
        local Offset_2 = Size_1.Y.Offset
        local v83 = math.max(-v82.Z, 0.1)
        return Vector2.new(((v82.X / ((v83 * 0.24932800284318068) * (Offset_1 / Offset_2))) * Offset_1) / 2, (-(v82.Y / (v83 * 0.24932800284318068)) * Offset_2) / 2)
    end
    local function stagePoint(a40, a41, a42)
        --[[
          name: stagePoint
          line: 1026
          upvalues:
            project (copy, index: 1)
            tbl_upv_11 (copy, index: 2)
        ]]
        local v84 = project(a40)
        local Position_2 = tbl_upv_11.chestHolder.Position
        local v85 = a42 or (tbl_upv_11.chestScale.Scale)
        return Vector2.new(Position_2.X.Offset + (v84.X * v85), (a41 or (Position_2.Y.Offset)) + (v84.Y * v85))
    end
    local u19 = nil
    local u20 = nil
    local function gradeIn(a43)
        --[[
          name: gradeIn
          line: 1036
          upvalues:
            u19 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            Lighting_upv_1 (copy, index: 3)
            u20 (ref,  index: 4)
            tw (copy, index: 5)
        ]]
        if not (u19) then
            local v86 = UI_upv_1.new("ColorCorrectionEffect", {Name = "TR_RevealCC", Parent = Lighting_upv_1})
            u19 = v86
        end
        if not (u20) then
            local v87 = UI_upv_1.new("BlurEffect", {Name = "TR_RevealBlur", Size = 0, Parent = Lighting_upv_1})
            u20 = v87
        end
        local v88 = Color3.new(1, 1, 1)
        u19.Brightness = 0
        u19.Contrast = 0
        u19.Saturation = 0
        u19.TintColor = v88
        local tbl_21 = {TintColor = 0, Brightness = -0.02, Saturation = 0, Contrast = 0.1}
        tbl_21.Saturation = ((a43.legendary) and 0.22) or 0.14
        tbl_21.TintColor = a43.light:Lerp(Color3.new(1, 1, 1), 0.85)
        tw(u19, 0.4, tbl_21)
        u20.Size = 0
        tw(u20, 0.45, {Size = 14})
    end
    local function gradePulse(a44)
        --[[
          name: gradePulse
          line: 1050
          upvalues:
            u19 (ref,  index: 1)
            tw (copy, index: 2)
        ]]
        if not u19 then
            return
        end
        u19.Saturation = a44
        tw(u19, 0.6, {Saturation = 0.16}, Enum.EasingStyle.Quad)
    end
    local function gradeOut(a45)
        --[[
          name: gradeOut
          line: 1057
          upvalues:
            u19 (ref,  index: 1)
            tw (copy, index: 2)
            u20 (ref,  index: 3)
        ]]
        if u19 then
            tw(u19, a45, {Brightness = 0, Saturation = 0, Contrast = 0, TintColor = Color3.new(1, 1, 1)}, Enum.EasingStyle.Quad)
        end
        if not u20 then
            return
        end
        tw(u20, a45, {Size = 0}, Enum.EasingStyle.Quad)
    end
    local function gradeOff()
        --[[
          name: gradeOff
          line: 1065
          upvalues:
            u19 (ref, index: 1)
            u20 (ref, index: 2)
        ]]
        if u19 then
            u19:Destroy()
            u19 = nil
        end
        if not u20 then
            return
        end
        u20:Destroy()
        u20 = nil
    end
    local u21 = nil
    local u22 = Random.new()
    local u23 = 0
    local u24 = 0
    local u25 = 0
    local function shake(a46, a47)
        --[[
          name: shake
          line: 1080
          upvalues:
            u23 (ref, index: 1)
            u24 (ref, index: 2)
            u25 (ref, index: 3)
        ]]
        u23 = a46
        u24 = 0
        u25 = a47
    end
    local tbl_upv_22 = {build = 0, wiggleT = -1, interval = 0.9, t = 0, on = false, nextWiggle = 0.5}
    local function stepAnims(a48)
        --[[
          name: stepAnims
          line: 382
          upvalues:
            tbl_upv_14 (copy, index: 1)
            tbl_upv_13 (copy, index: 2)
        ]]
        for key_3, value_9 in tbl_upv_14 do
            local v89 = value_9[1]
            if not (v89) then
                tbl_upv_14[key_3] = nil
                continue
            end
            if v89.delay > 0 then
                v89.delay = v89.delay - a48
                if v89.delay > 0 then
                    continue
                end
                local v90 = -v89.delay
                v89.delay = 0
                a48 = v90
                if v89.from == nil then
                    v89.from = tbl_upv_13[key_3]
                end
                v89.t = v89.t + a48
                local v91 = math.min(1, v89.t / v89.dur)
                tbl_upv_13[key_3] = v89.from + ((v89.to - v89.from) * v89.ease(v91))
                if not (v91 >= 1) then
                    continue
                end
                table.remove(value_9, 1)
                if #value_9 == 0 then
                    tbl_upv_14[key_3] = nil
                end
            else
                if v89.from == nil then
                    v89.from = tbl_upv_13[key_3]
                end
                v89.t = v89.t + a48
                local v91 = math.min(1, v89.t / v89.dur)
                tbl_upv_13[key_3] = v89.from + ((v89.to - v89.from) * v89.ease(v91))
                if not (v91 >= 1) then
                    continue
                end
                table.remove(value_9, 1)
                if #value_9 == 0 then
                    tbl_upv_14[key_3] = nil
                end
            end
        end
    end
    local function onRender(a49)
        --[[
          name: onRender
          line: 1084
          upvalues:
            u7 (ref,  index: 1)
            stepAnims (copy, index: 2)
            u9 (ref,  index: 3)
            tbl_upv_22 (copy, index: 4)
            a1 (copy, index: 5)
            u22 (copy, index: 6)
            tbl_upv_11 (copy, index: 7)
            u13 (ref,  index: 8)
            u12 (ref,  index: 9)
            project (copy, index: 10)
            tbl_upv_13 (copy, index: 11)
            applyPose (copy, index: 12)
            u23 (ref,  index: 13)
            u24 (ref,  index: 14)
            u25 (ref,  index: 15)
            tbl_upv_3 (copy, index: 16)
            tbl_upv_7 (copy, index: 17)
        ]]
        local v92 = a49 / u7
        stepAnims(v92)
        if not u9 then
            return
        end
        local look_1 = u9.look
        if tbl_upv_22.on then
            tbl_upv_22.t = tbl_upv_22.t + v92
            tbl_upv_22.build = math.min(1, tbl_upv_22.build + (v92 / math.max(look_1.idle, 0.1)))
            local v93 = math.sin(tbl_upv_22.t * 2.4) * 0.07
            local v94 = 0
            local v95 = 0
            local v99 = nil
            if tbl_upv_22.nextWiggle <= tbl_upv_22.t and tbl_upv_22.wiggleT < 0 then
                tbl_upv_22.wiggleT = 0
                a1.Sounds.Play("Drop_Rattle", {pitch = 0.95 + (u22:NextNumber() * 0.1) + (tbl_upv_22.build * 0.08)})
                v99 = tbl_upv_11.backPool
                local v96 = ((look_1.legendary) and 5) or 3
                local tbl_23 = {lifeMin = 0.45, speedMax = 220, dir = -90, lifeMax = 0.8, drag = 1.6, whiteChance = 0, grav = 120, at = 0, speedMin = 90, colors = 0, jitter = 60, kind = "sparkle", mode = "point", spread = 55, size = 26}
                local Y_2 = u13.Position.Y
                local v97
                if u12 then
                    local _ = u12.size[3]
                    local v107 = u9 and u9.look.fit or 1
                    v97 = u12.size[3] * (u9 and u9.look.fit or 1) / 2
                else
                    v97 = 1.7
                end
                local v98 = project(Vector3.new(0, Y_2, -v97))
                local Position_3 = tbl_upv_11.chestHolder.Position
                local Scale_1 = tbl_upv_11.chestScale.Scale
                tbl_23.at = Vector2.new(Position_3.X.Offset + (v98.X * Scale_1), Position_3.Y.Offset + (v98.Y * Scale_1))
                tbl_23.colors = {look_1.light, look_1.primary}
                v99:Burst(v96, tbl_23)
            end
            if tbl_upv_22.wiggleT >= 0 then
                tbl_upv_22.wiggleT = tbl_upv_22.wiggleT + v92
                v99 = tbl_upv_22.wiggleT / 0.36
                if v99 >= 1 then
                    tbl_upv_22.wiggleT = -1
                    tbl_upv_22.interval = not (look_1.legendary) and 0.9 or math.max(0.32, 0.9 - (tbl_upv_22.build * 0.6))
                    tbl_upv_22.nextWiggle = tbl_upv_22.t + tbl_upv_22.interval
                else
                    local v101 = math.rad(look_1.wiggle)
                    local build_2 = tbl_upv_22.build
                    v94 = math.sin((v99 * math.pi) * 5) * (1 - v99) * (v101 * (1 + (build_2 * (((look_1.legendary) and 0.8) or 0.2))))
                    local v102 = math.sin(v99 * math.pi)
                    v95 = v102 * (((look_1.legendary) and 9) or 5)
                end
            end
            tbl_upv_13.y = v93 + (((look_1.legendary) and (tbl_upv_22.build * 0.25)) or 0)
            tbl_upv_13.roll = v94
            tbl_upv_13.yaw = v94 * 0.6
            tbl_upv_13.lid = v95
            local Y_3 = u13.Position.Y
            local v103
            if u12 then
                local _ = u12.size[3]
                local v108 = u9 and u9.look.fit or 1
                v103 = u12.size[3] * (u9 and u9.look.fit or 1) / 2
            else
                v103 = 1.7
            end
            v94 = project(Vector3.new(0, Y_3, -v103))
            tbl_upv_11.leak.Position = UDim2.new(0.5, v94.X, 0.5, v94.Y)
            tbl_upv_11.leakFlare.Position = tbl_upv_11.leak.Position
            v94 = math.clamp(v95 / 9, 0, 1)
            tbl_upv_11.leak.ImageTransparency = 1 - (v94 * 0.75)
            tbl_upv_11.leakFlare.ImageTransparency = 1 - (v94 * 0.6)
            v95 = math.sin(tbl_upv_22.t * 4.2) * 0.5 + 0.5
            tbl_upv_11.chestGlow.ImageTransparency = 0.62 - (v95 * 0.14) - (tbl_upv_22.build * (((look_1.legendary) and 0.2) or 0.05))
            tbl_upv_11.promptScale.Scale = (v95 * 0.04) + 1
            if look_1.legendary then
                tbl_upv_11.raysA.ImageTransparency = 1 - (tbl_upv_22.build * 0.28)
                tbl_upv_11.raysB.ImageTransparency = 1 - (tbl_upv_22.build * 0.22)
            end
        end
        tbl_upv_11.raysA.Rotation = (tbl_upv_11.raysA.Rotation + (v92 * tbl_upv_13.raysSpin)) % 360
        tbl_upv_11.raysB.Rotation = (tbl_upv_11.raysB.Rotation - ((v92 * tbl_upv_13.raysSpin) * 0.6)) % 360
        if tbl_upv_11.newRoot.Visible then
            tbl_upv_11.newRaysA.Rotation = (tbl_upv_11.newRaysA.Rotation + ((v92 * tbl_upv_13.raysSpin) * 1.6)) % 360
            tbl_upv_11.newRaysB.Rotation = (tbl_upv_11.newRaysB.Rotation - (v92 * tbl_upv_13.raysSpin)) % 360
        end
        if tbl_upv_11.chestHolder.Visible then
            applyPose()
        end
        local v104 = nil
        if u23 > 0 then
            u24 = u24 + v92
            v104 = 1 - u24 / math.max(u25, 0.001)
            if v104 <= 0 then
                u23 = 0
                tbl_upv_11.shaker.Position = UDim2.new()
            else
                tbl_upv_11.shaker.Position = UDim2.fromOffset((u22:NextNumber(-1, 1) * u23) * v104, (u22:NextNumber(-1, 1) * u23) * v104)
            end
        end
        if u9.barNeed and tbl_upv_11.barBox.Visible then
            local v105 = math.clamp(math.floor((tbl_upv_11.barFill.Size.X.Scale * u9.barNeed) + 0.5), u9.barMin, u9.barMax)
            if v105 ~= u9.barShown then
                u9.barShown = v105
                tbl_upv_11.barText.Text = string.format("%d / %d", v105, u9.barNeed)
            end
        end
        if u9.fallOpts then
            local fallOpts_1 = u9.fallOpts
            fallOpts_1.at = Vector2.new(0, tbl_upv_11.chestHolder.Position.Y.Offset + 40)
        end
        if u9.headOpts then
            local headOpts_1 = u9.headOpts
            headOpts_1.at = Vector2.new(-165 + (tbl_upv_11.barFill.Size.X.Scale * 330), 171)
        end
        if u9.holdAt then
            local v106 = os.clock() - u9.holdAt
            tbl_upv_11.skipFill.Size = UDim2.fromScale(math.clamp(v106 / tbl_upv_3.hold, 0, 1), 1)
            if (tbl_upv_3.hold <= v106) and not u9.skip and u9.phase ~= "summary" then
                u9.holdAt = nil
                tbl_upv_11.skipFill.Size = UDim2.fromScale(0, 1)
                tbl_upv_7.Skip()
            end
        end
    end
    local function alive(a50)
        --[[
          name: alive
          line: 1185
          upvalues:
            u9 (ref, index: 1)
        ]]
        local v107 = (u9 ~= nil) and (u9.token == a50)
        return v107
    end
    local function sleep(a51, a52, a53)
        --[[
          name: sleep
          line: 1189
          upvalues:
            u7 (ref, index: 1)
            u9 (ref, index: 2)
        ]]
        local v108 = os.clock()
        local v109 = a52 * u7
        while os.clock() - v108 < v109 do
            local v110 = (u9 ~= nil) and (u9.token == a51)
            if not (v110) or u9.skip then
                return false
            elseif not (u9.hurry) or a53 == false then
                if not (a53) or not (u9.tapped) then
                    task.wait()
                    continue
                end
                u9.tapped = false
                return true
            else
                return true
            end
        end
        local v110 = (u9 ~= nil) and (u9.token == a51)
        if v110 then
            v110 = not u9.skip
        end
        return v110
    end
    local function titleIn(a54, a55)
        --[[
          name: titleIn
          line: 1231
          upvalues:
            tbl_upv_11 (copy, index: 1)
            tw (copy, index: 2)
        ]]
        tbl_upv_11.title.Visible = true
        tbl_upv_11.titleShadow.Visible = true
        tbl_upv_11.subtitle.Visible = true
        for _, value_10 in {tbl_upv_11.title, tbl_upv_11.titleShadow} do
            value_10.Text = a54
            value_10.TextTransparency = 1
        end
        tbl_upv_11.title.Position = UDim2.fromOffset(0, -335)
        tbl_upv_11.titleShadow.Position = UDim2.fromOffset(0, -330)
        tbl_upv_11.titleScale.Scale = 1.8
        tbl_upv_11.titleShadowScale.Scale = 1.8
        tw(tbl_upv_11.titleScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
        tw(tbl_upv_11.titleShadowScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
        tw(tbl_upv_11.title, 0.12, {TextTransparency = 0}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.titleShadow, 0.2, {TextTransparency = 0.55}, Enum.EasingStyle.Quad)
        tbl_upv_11.subtitle.Text = a55
        tbl_upv_11.subtitle.Position = UDim2.fromOffset(0, -279)
        local subtitle_2 = tbl_upv_11.subtitle
        subtitle_2.TextTransparency = 1
        local v111
        if subtitle_2:IsA("TextLabel") then
            v111 = subtitle_2:FindFirstChildWhichIsA("UIStroke")
        else
            v111 = nil
        end
        local v112, v113
        if v111 then
            if type(v111:GetAttribute("Authored")) ~= "number" then
                v111:SetAttribute("Authored", v111.Transparency)
            end
            v112, v113 = v111, 1
        else
            v112 = nil
            v113 = 1
        end
        if v112 then
            v112.Transparency = v113
        end
        tw(tbl_upv_11.subtitle, 0.3, {TextTransparency = 0, Position = UDim2.fromOffset(0, -289)}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0.15)
    end
    local function setCounter(a56, a57)
        --[[
          name: setCounter
          line: 1251
          upvalues:
            tbl_upv_11 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        tbl_upv_11.counter.Visible = a56 > 0
        tbl_upv_11.counterText.Text = "x" .. a56
        if not a57 then
            return
        end
        UI_upv_1.Pop(tbl_upv_11.counter, 1.35)
    end
    local function placeCounter()
        --[[
          name: placeCounter
          line: 1258
          upvalues:
            tbl_upv_11 (copy, index: 1)
        ]]
        tbl_upv_11.counter.Position = UDim2.fromOffset(128, 228)
    end
    local function animate(a58, a59)
        --[[
          name: animate
          line: 366
          upvalues:
            tbl_upv_15 (copy, index: 1)
            tbl_upv_14 (copy, index: 2)
        ]]
        local tbl_24 = {}
        for _, value_11 in a59 do
            local tbl_25 = {t = 0, ease = 0, delay = 0}
            tbl_25.to = value_11[1]
            tbl_25.dur = math.max(0.001, value_11[2])
            local v114 = tbl_upv_15[value_11[3] or "outQuad"]
            if not (v114) then
                local v115 = tbl_upv_15.outQuad
            end
            tbl_25.ease = v114
            tbl_25.delay = value_11[4] or 0
            table.insert(tbl_24, tbl_25)
        end
        tbl_upv_14[a58] = tbl_24
    end
    local function phaseLand(a60)
        --[[
          name: phaseLand
          line: 1264
          upvalues:
            u9 (ref,  index: 1)
            tbl_upv_13 (copy, index: 2)
            applyPose (copy, index: 3)
            tbl_upv_11 (copy, index: 4)
            tw (copy, index: 5)
            tbl_upv_3 (copy, index: 6)
            animate (copy, index: 7)
            a1 (copy, index: 8)
            project (copy, index: 9)
            sleep (copy, index: 10)
            u23 (ref,  index: 11)
            u24 (ref,  index: 12)
            u25 (ref,  index: 13)
            u12 (ref,  index: 14)
            Colors_upv_1 (copy, index: 15)
            titleIn (copy, index: 16)
        ]]
        local look_2 = u9.look
        u9.phase = "land"
        tbl_upv_13.y = 0
        tbl_upv_13.yaw = -0.24434609527920614
        tbl_upv_13.roll = 0
        tbl_upv_13.pitch = 0
        tbl_upv_13.sq = -0.16
        tbl_upv_13.lid = 0
        tbl_upv_13.s = 1
        applyPose()
        tbl_upv_11.chestHolder.Visible = true
        tbl_upv_11.chestHolder.Position = UDim2.fromOffset(0, -800)
        tbl_upv_11.chestScale.Scale = 1
        tw(tbl_upv_11.chestHolder, tbl_upv_3.fall, {Position = UDim2.fromOffset(0, 20)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        animate("yaw", {{0, tbl_upv_3.fall + 0.25, "outQuad"}})
        a1.Sounds.Play("Whoosh", {pitch = 0.75, volume = 0.3})
        u9.fallOpts = {lifeMin = 0.12, speedMax = 1700, base = 0.55, dir = -90, lifeMax = 0.22, drag = 0, whiteChance = 0, grav = 0, speedMin = 1100, jitter = 150, kind = "spark", mode = "point", spread = 3, size = 190, at = Vector2.new(0, -800), colors = {look_2.light}}
        local v115 = tbl_upv_11.backPool:Emit(40, u9.fallOpts)
        local v116 = project(Vector3.new(0, 0, 0))
        local v117 = Vector2.new(tbl_upv_11.chestHolder.Position.X.Offset + (v116.X * 1), 20 + (v116.Y * 1))
        tbl_upv_11.shadow.Position = UDim2.fromOffset(v117.X, v117.Y + 4)
        tbl_upv_11.shadow.Size = UDim2.fromOffset(120, 24)
        tbl_upv_11.shadow.ImageTransparency = 0.9
        tw(tbl_upv_11.shadow, tbl_upv_3.fall, {ImageTransparency = 0.35, Size = UDim2.fromOffset(420, 84)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local v118 = sleep(a60, tbl_upv_3.fall, false)
        v115()
        if u9 then
            u9.fallOpts = nil
        end
        if not v118 then
            return false
        end
        local Play_1 = a1.Sounds.Play
        local tbl_26 = {pitch = 0}
        tbl_26.pitch = ((look_2.legendary) and 0.9) or 1
        Play_1("Drop_Land", tbl_26)
        animate("sq", {{0.3, 0.06, "outQuad"}, {-0.12, 0.13, "inOutSine"}, {0.05, 0.12, "inOutSine"}, {0, 0.14, "outQuad"}})
        u23 = ((look_2.legendary) and 16) or 11
        u24 = 0
        u25 = 0.32
        local v119 = project(Vector3.new(0, 0.10000000149011612, 0))
        local Position_4 = tbl_upv_11.chestHolder.Position
        local Scale_2 = tbl_upv_11.chestScale.Scale
        local v120 = Vector2.new(Position_4.X.Offset + (v119.X * Scale_2), Position_4.Y.Offset + (v119.Y * Scale_2))
        local v121
        if u12 then
            local _ = u12.size[3]
            local v125 = u9 and u9.look.fit or 1
            v121 = u12.size[3] * (u9 and u9.look.fit or 1) / 2
        else
            v121 = 1.7
        end
        local v122 = project(Vector3.new(0, 0, -v121))
        local Position_5 = tbl_upv_11.chestHolder.Position
        local Scale_3 = tbl_upv_11.chestScale.Scale
        local v123 = Vector2.new(Position_5.X.Offset + (v122.X * Scale_3), Position_5.Y.Offset + (v122.Y * Scale_3))
        for _, value_12 in {180, 0} do
            local frontPool_1 = tbl_upv_11.frontPool
            local v124 = ((look_2.legendary) and 9) or 7
            local tbl_27 = {lifeMin = 0.5, speedMax = 480, grow = 2.6, dir = 0, lifeMax = 0.9, drag = 3.2, base = 0.6, color = 0, at = 0, speedMin = 180, grav = -40, jitter = 30, kind = "dust", mode = "point", spread = 14, size = 70}
            tbl_27.at = v123 + Vector2.new(((value_12 ~= 0) and -120) or 120, -6)
            tbl_27.dir = value_12
            tbl_27.color = look_2.light:Lerp(Colors_upv_1.TextDim, 0.55)
            frontPool_1:Burst(v124, tbl_27)
        end
        tbl_upv_11.frontPool:Burst(((look_2.legendary) and 16) or 9, {lifeMin = 0.4, speedMax = 620, dir = -90, lifeMax = 0.75, drag = 1.2, whiteChance = 0, grav = 900, speedMin = 260, jitter = 120, kind = "sparkle", mode = "point", spread = 70, size = 24, at = v120 + Vector2.new(0, -20), colors = {look_2.light, look_2.primary}})
        tbl_upv_11.floorRing.Position = UDim2.fromOffset(v120.X, v120.Y + 4)
        tbl_upv_11.floorRing.Size = UDim2.fromOffset(160, 40)
        tbl_upv_11.floorRing.ImageTransparency = 0.2
        tw(tbl_upv_11.floorRing, 0.55, {ImageTransparency = 1, Size = UDim2.fromOffset(900, 210)}, Enum.EasingStyle.Quart)
        tbl_upv_11.halo.ImageTransparency = 1
        tbl_upv_11.raysHolder.Position = UDim2.fromOffset(0, 0)
        tw(tbl_upv_11.halo, 0.5, {ImageTransparency = 0.55}, Enum.EasingStyle.Quad)
        titleIn(look_2.title, u9.subtitle)
        return (sleep(a60, tbl_upv_3.settle, false))
    end
    local function phaseIdle(a61)
        --[[
          name: phaseIdle
          line: 1314
          upvalues:
            u9 (ref,  index: 1)
            tbl_upv_22 (copy, index: 2)
            tbl_upv_11 (copy, index: 3)
            tw (copy, index: 4)
            u12 (ref,  index: 5)
            project (copy, index: 6)
            a1 (copy, index: 7)
            tbl_upv_13 (copy, index: 8)
            sleep (copy, index: 9)
            u7 (ref,  index: 10)
        ]]
        local look_3 = u9.look
        u9.phase = "idle"
        tbl_upv_22.on = true
        tbl_upv_22.t = 0
        tbl_upv_22.nextWiggle = 0.18
        tbl_upv_22.wiggleT = -1
        tbl_upv_22.build = 0
        tbl_upv_11.prompt.Visible = true
        tbl_upv_11.prompt.Position = UDim2.fromOffset(0, 332)
        tbl_upv_11.promptFill.Size = UDim2.fromScale(0, 1)
        local v125 = u9.opts.autoOpen == true
        local v126
        if v125 then
            v126 = look_3.idle
        else
            v126 = 86400
        end
        if v125 then
            tw(tbl_upv_11.promptFill, v126, {Size = UDim2.fromScale(1, 1)}, Enum.EasingStyle.Linear)
        end
        local v127 = u9
        local backPool_2 = tbl_upv_11.backPool
        local sparkle_1 = look_3.sparkle
        local tbl_28 = {lifeMin = 0.9, speedMax = 70, dir = -90, lifeMax = 1.6, drag = 0.2, whiteChance = 0, jitter = 170, at = 0, speedMin = 26, colors = 0, kind = "sparkle", grav = -30, mode = "point", spread = 15, size = 24}
        local v128
        if u12 then
            local _ = u12.size[2]
            local v131 = u9 and u9.look.fit or 1
            v128 = u12.size[2] * (u9 and u9.look.fit or 1)
        else
            v128 = 4
        end
        local v129 = project(Vector3.new(0, v128 * 0.5, 0))
        local Position_6 = tbl_upv_11.chestHolder.Position
        local Scale_4 = tbl_upv_11.chestScale.Scale
        tbl_28.at = Vector2.new(Position_6.X.Offset + (v129.X * Scale_4), Position_6.Y.Offset + (v129.Y * Scale_4))
        tbl_28.colors = {look_3.light, look_3.primary}
        v127.stopSparkles = backPool_2:Emit(sparkle_1, tbl_28)
        if look_3.legendary then
            a1.Sounds.Play("Drop_BuildUp")
            tbl_upv_11.raysHolder.Position = UDim2.fromOffset(0, 0)
            tbl_upv_11.raysScale.Scale = 0.75
            tw(tbl_upv_11.raysScale, look_3.idle, {Scale = 0.95}, Enum.EasingStyle.Quad)
            tbl_upv_13.raysSpin = 14
            tw(tbl_upv_11.vignette, look_3.idle, {ImageTransparency = 0.25, ImageColor3 = look_3.deep}, Enum.EasingStyle.Quad)
        end
        if u9.tapped then
            u9.tapped = false
            if sleep(a61, 0.15, false) == false then
                return false
            end
        else
            local v130 = sleep(a61, v126, true)
            if not (v130) then
                return false
            end
        end
        tbl_upv_22.on = false
        tbl_upv_13.roll = 0
        tbl_upv_13.yaw = 0
        tbl_upv_13.lid = 0
        tbl_upv_11.leak.ImageTransparency = 1
        tbl_upv_11.leakFlare.ImageTransparency = 1
        tw(tbl_upv_11.prompt, 0.15, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
        task.delay(
            u7 * 0.16,
            function()
                --[[
                  line: 1353
                  upvalues:
                    tbl_upv_11 (copy, index: 1)
                ]]
                if not tbl_upv_11.prompt then
                    return
                end
                tbl_upv_11.prompt.Visible = false
                tbl_upv_11.prompt.BackgroundTransparency = 0.15
            end
        )
        return true
    end
    local function phaseOpen(a62)
        --[[
          name: phaseOpen
          line: 1362
          upvalues:
            u9 (ref,  index: 1)
            animate (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
            sleep (copy, index: 4)
            a1 (copy, index: 5)
            u23 (ref,  index: 6)
            u24 (ref,  index: 7)
            u25 (ref,  index: 8)
            u19 (ref,  index: 9)
            tw (copy, index: 10)
            tbl_upv_11 (copy, index: 11)
            u13 (ref,  index: 12)
            project (copy, index: 13)
            tbl_upv_13 (copy, index: 14)
            Colors_upv_1 (copy, index: 15)
        ]]
        local look_4 = u9.look
        u9.phase = "open"
        animate("sq", {{0.2, tbl_upv_3.openCrouch, "outQuad"}})
        if not sleep(a62, tbl_upv_3.openCrouch, false) then
            return false
        end
        animate("sq", {{-0.14, 0.1, "outQuad"}, {0.06, 0.14, "inOutSine"}, {0, 0.2, "outQuad"}})
        animate("y", {{0.45, 0.12, "outQuad"}, {0, 0.26, "inQuad"}})
        animate("lid", {{((look_4.model ~= "Drop") and 118) or 140, 0.34, "outBack"}})
        animate("s", {{1.06, 0.1, "outQuad"}, {1, 0.3, "outQuad"}})
        a1.Sounds.Play("Drop_Open")
        if look_4.legendary then
            a1.Sounds.Play("Drop_Open_Golden")
        end
        u23 = ((look_4.legendary) and 20) or 13
        u24 = 0
        u25 = 0.4
        local v131 = ((look_4.legendary) and 0.45) or 0.32
        if u19 then
            u19.Saturation = v131
            tw(u19, 0.6, {Saturation = 0.16}, Enum.EasingStyle.Quad)
        end
        tbl_upv_11.flash.BackgroundTransparency = ((look_4.legendary) and 0.55) or 0.64
        tw(tbl_upv_11.flash, 0.45, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.dim, 0.3, {BackgroundTransparency = 0.12}, Enum.EasingStyle.Quad)
        tbl_upv_11.tint.ImageTransparency = 0.45
        tw(tbl_upv_11.tint, 1.2, {ImageTransparency = 0.72}, Enum.EasingStyle.Quad)
        local v132 = project(Vector3.new(0, u13.Position.Y + 0.2, 0))
        local Position_7 = tbl_upv_11.chestHolder.Position
        local Scale_5 = tbl_upv_11.chestScale.Scale
        local v133 = Vector2.new(Position_7.X.Offset + (v132.X * Scale_5), Position_7.Y.Offset + (v132.Y * Scale_5))
        tbl_upv_11.raysHolder.Position = UDim2.fromOffset(v133.X, v133.Y)
        tbl_upv_11.raysScale.Scale = ((look_4.legendary) and 0.8) or 0.25
        local raysScale_1 = tbl_upv_11.raysScale
        local tbl_29 = {Scale = 0}
        tbl_29.Scale = ((look_4.legendary) and 1.15) or 1
        tw(raysScale_1, 0.55, tbl_29, Enum.EasingStyle.Back)
        tbl_upv_11.raysA.ImageTransparency = ((look_4.legendary) and 0.3) or 0.5
        tbl_upv_11.raysB.ImageTransparency = ((look_4.legendary) and 0.4) or 0.6
        tw(tbl_upv_11.raysA, 1.1, {ImageTransparency = look_4.rays}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)
        tw(tbl_upv_11.raysB, 1.1, {ImageTransparency = math.min(0.92, look_4.rays + 0.12)}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.3)
        tbl_upv_13.raysSpin = ((look_4.legendary) and 60) or 40
        animate("raysSpin", {{((look_4.legendary) and 12) or 8, 1.4, "outQuad"}})
        tbl_upv_11.halo.ImageTransparency = 0.2
        tbl_upv_11.halo.Size = UDim2.fromOffset(380, 380)
        tw(tbl_upv_11.halo, 0.8, {ImageTransparency = 0.5, Size = UDim2.fromOffset(720, 720)}, Enum.EasingStyle.Quart)
        tbl_upv_11.beam.Position = UDim2.fromOffset(v133.X, v133.Y + 30)
        tbl_upv_11.beam.Size = UDim2.fromOffset(120, 300)
        tbl_upv_11.beam.ImageTransparency = 0.25
        tw(tbl_upv_11.beam, 0.25, {Size = UDim2.fromOffset(260, 760)}, Enum.EasingStyle.Quart)
        tw(tbl_upv_11.beam, 0.9, {ImageTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0.15)
        tbl_upv_11.floorRing.Position = UDim2.fromOffset(v133.X, v133.Y)
        tbl_upv_11.floorRing.Size = UDim2.fromOffset(160, 160)
        tbl_upv_11.floorRing.ImageTransparency = 0.15
        tw(tbl_upv_11.floorRing, 0.6, {ImageTransparency = 1, Size = UDim2.fromOffset(1500, 1500)}, Enum.EasingStyle.Quart)
        tbl_upv_11.frontPool:Burst(look_4.burst, {lifeMin = 0.5, drag = 1.5, speedMin = 700, sparkLen = 170, mode = "point", spread = 62, size = 26, speedMax = 1500, dir = -90, lifeMax = 1, whiteChance = 0.3, jitter = 50, grav = 900, sparkChance = 0.7, at = v133, colors = {look_4.primary, look_4.light}, white = look_4.light})
        tbl_upv_11.frontPool:Burst(math.floor(look_4.burst * 0.6), {lifeMin = 0.7, speedMax = 700, dir = -90, lifeMax = 1.3, drag = 1.4, whiteChance = 0, grav = 500, speedMin = 250, jitter = 70, kind = "sparkle", mode = "point", spread = 80, size = 32, at = v133, colors = {look_4.light, look_4.primary}})
        if look_4.legendary then
            tbl_upv_11.frontPool:Burst(24, {lifeMin = 0.6, speedMax = 1100, lifeMax = 1.2, drag = 1.2, whiteChance = 0, speedMin = 500, kind = "shard", jitter = 40, mode = "point", grav = 700, size = 26, at = v133, colors = {Colors_upv_1.Gold, look_4.light}})
        end
        tbl_upv_11.chestGlow.ImageTransparency = 0.25
        tw(tbl_upv_11.chestGlow, 0.9, {ImageTransparency = 0.55}, Enum.EasingStyle.Quad)
        if u9.stopSparkles then
            u9.stopSparkles()
            u9.stopSparkles = nil
        end
        if sleep(a62, tbl_upv_3.openHold, false) then
            return true
        end
        return false
    end
    local function paintBar(a63, a64, a65, a66, a67, a68)
        --[[
          name: paintBar
          line: 1437
          upvalues:
            tbl_upv_11 (copy, index: 1)
            u9 (ref,  index: 2)
            Colors_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            WeaponInfo_upv_1 (copy, index: 5)
        ]]
        if a65 then
            tbl_upv_11.barText.Text = string.format("%d / %d", a64, a65)
        else
            tbl_upv_11.barText.Text = "MAX"
        end
        if u9 then
            u9.barNeed = a65
            u9.barMin = a64
            u9.barMax = math.max(a64, a68 or a64)
            u9.barShown = a64
        end
        tbl_upv_11.barGrad.Color = ColorSequence.new(a67:Lerp(Color3.new(1, 1, 1), 0.18), a67:Lerp(Colors_upv_1.Void, 0.18))
        if a66 <= 0 then
            a1.Loc.Rich(tbl_upv_11.barCaption, string.format("<font color=\"#%s\">UNLOCK</font>  %s", Colors_upv_1.Gold:ToHex(), string.upper(WeaponInfo_upv_1.Name(a63.item))))
        elseif a65 then
            a1.Loc.Rich(tbl_upv_11.barCaption, string.format("LEVEL %d  <font color=\"#%s\">\226\128\186</font>  %d", a66, a67:Lerp(Color3.new(1, 1, 1), 0.3):ToHex(), a66 + 1))
        else
            a1.Loc.Rich(tbl_upv_11.barCaption, string.format("LEVEL %d  \194\183  MAX", a66))
        end
    end
    local function paintFace(a69)
        --[[
          name: paintFace
          line: 1470
          upvalues:
            catColor (copy, index: 1)
            tbl_upv_11 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            WeaponInfo_upv_1 (copy, index: 4)
        ]]
        local v134 = catColor(a69.item)
        tbl_upv_11.faceGrad.Color = ColorSequence.new(v134:Lerp(Color3.new(1, 1, 1), 0.1), v134:Lerp(Colors_upv_1.Void, 0.55))
        tbl_upv_11.faceStroke.Color = v134:Lerp(Color3.new(1, 1, 1), 0.45)
        tbl_upv_11.wellGlow.ImageColor3 = v134
        local cat_1 = tbl_upv_11.cat
        local v135
        if a69.bonus then
            local v136 = WeaponInfo_upv_1.Get(a69.item)
            v135 = (((v136 and (WeaponInfo_upv_1.CATEGORY_SINGULAR)) and (WeaponInfo_upv_1.CATEGORY_SINGULAR[v136.category])) or "ITEM") .. "  \194\183  MVP BONUS"
        else
            local v137 = WeaponInfo_upv_1.Get(a69.item)
            v135 = ((v137 and (WeaponInfo_upv_1.CATEGORY_SINGULAR)) and (WeaponInfo_upv_1.CATEGORY_SINGULAR[v137.category])) or "ITEM"
        end
        cat_1.Text = v135
        tbl_upv_11.name.Text = string.upper(WeaponInfo_upv_1.Name(a69.item))
        tbl_upv_11.countText.Text = "x0"
        tbl_upv_11.gem.ImageColor3 = v134:Lerp(Color3.new(1, 1, 1), 0.25)
        tbl_upv_11.cardGlow.ImageColor3 = v134
        if a69.levelBefore <= 0 then
            tbl_upv_11.tag.Visible = true
            tbl_upv_11.tag.BackgroundColor3 = Colors_upv_1.Raised
            tbl_upv_11.tagText.Text = "LOCKED"
            tbl_upv_11.tagText.TextColor3 = Colors_upv_1.TextDim
        else
            tbl_upv_11.tag.Visible = true
            tbl_upv_11.tag.BackgroundColor3 = Colors_upv_1.Raised
            tbl_upv_11.tagText.Text = "LV " .. a69.levelBefore
            tbl_upv_11.tagText.TextColor3 = Colors_upv_1.Text
        end
        tbl_upv_11.stamp.Visible = false
    end
    local function phaseNewItem(a70, a71)
        --[[
          name: phaseNewItem
          line: 1496
          upvalues:
            u9 (ref,  index: 1)
            catColor (copy, index: 2)
            tbl_upv_11 (copy, index: 3)
            tw (copy, index: 4)
            tbl_upv_13 (copy, index: 5)
            animate (copy, index: 6)
            u19 (ref,  index: 7)
            WeaponIcon_upv_1 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            WeaponInfo_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
            u7 (ref,  index: 12)
            sleep (copy, index: 13)
            u23 (ref,  index: 14)
            u24 (ref,  index: 15)
            u25 (ref,  index: 16)
            tbl_upv_3 (copy, index: 17)
        ]]
        u9.phase = "newitem"
        local v138 = catColor(a71.item)
        local v139 = v138:Lerp(Color3.new(1, 1, 1), 0.4)
        tbl_upv_11.newRoot.Visible = true
        tbl_upv_11.newRoot.Position = UDim2.fromOffset(0, 0)
        tbl_upv_11.card.Visible = false
        tbl_upv_11.barBox.Visible = false
        tbl_upv_11.counter.Visible = false
        tbl_upv_11.newDim.BackgroundTransparency = 1
        tw(tbl_upv_11.newDim, 0.25, {BackgroundTransparency = 0.18}, Enum.EasingStyle.Quad)
        tbl_upv_11.newRaysA.ImageColor3 = v139
        tbl_upv_11.newRaysB.ImageColor3 = v138
        tbl_upv_11.newRaysA.ImageTransparency = 0.25
        tbl_upv_11.newRaysB.ImageTransparency = 0.35
        tbl_upv_11.newRaysA.Size = UDim2.fromOffset(300, 300)
        tbl_upv_11.newRaysB.Size = UDim2.fromOffset(300, 300)
        tw(tbl_upv_11.newRaysA, 0.6, {ImageTransparency = 0.5, Size = UDim2.fromOffset(1300, 1300)}, Enum.EasingStyle.Back)
        tw(tbl_upv_11.newRaysB, 0.7, {ImageTransparency = 0.62, Size = UDim2.fromOffset(1500, 1500)}, Enum.EasingStyle.Back)
        tbl_upv_13.raysSpin = 70
        animate("raysSpin", {{10, 1.6, "outQuad"}})
        tbl_upv_11.newGlow.ImageColor3 = v138
        tbl_upv_11.newGlow.ImageTransparency = 0.4
        tbl_upv_11.newGlow.Size = UDim2.fromOffset(300, 300)
        tw(tbl_upv_11.newGlow, 0.7, {ImageTransparency = 0.55, Size = UDim2.fromOffset(820, 820)}, Enum.EasingStyle.Quart)
        tbl_upv_11.newRing.ImageColor3 = v138
        tbl_upv_11.newRing.Size = UDim2.fromOffset(200, 200)
        tbl_upv_11.newRing.ImageTransparency = 0.3
        tw(tbl_upv_11.newRing, 0.7, {ImageTransparency = 1, Size = UDim2.fromOffset(1700, 1700)}, Enum.EasingStyle.Quart)
        tbl_upv_11.flash.BackgroundColor3 = v138
        tbl_upv_11.flash.BackgroundTransparency = 0.7
        tw(tbl_upv_11.flash, 0.5, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
        if u19 then
            u19.Saturation = 0.5
            tw(u19, 0.6, {Saturation = 0.16}, Enum.EasingStyle.Quad)
        end
        WeaponIcon_upv_1.Set(tbl_upv_11.newItem, a71.item, {outline = true, spin = true, outlineTransparency = 0.4, outlineScale = 1.04, glow = false, outlineColor = v139})
        tbl_upv_11.newItemScale.Scale = 0.2
        tw(tbl_upv_11.newItemScale, 0.55, {Scale = 1}, Enum.EasingStyle.Back)
        for _, value_13 in {tbl_upv_11.newHead, tbl_upv_11.newShadow, tbl_upv_11.newAura} do
            value_13.Text = "NEW ITEM!"
            value_13.TextTransparency = 1
            value_13.Position = UDim2.fromOffset(0, -300)
        end
        tbl_upv_11.newShadow.Position = UDim2.fromOffset(0, -293)
        tbl_upv_11.newHeadGrad.Color = ColorSequence.new(Colors_upv_1.Text, v139)
        tbl_upv_11.newAura.TextColor3 = v139
        tbl_upv_11.newHeadScale.Scale = 2.2
        tbl_upv_11.newShadowScale.Scale = 2.2
        tw(tbl_upv_11.newHeadScale, 0.26, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.08)
        tw(tbl_upv_11.newShadowScale, 0.26, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.08)
        tw(tbl_upv_11.newHead, 0.1, {TextTransparency = 0}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.08)
        tw(tbl_upv_11.newShadow, 0.2, {TextTransparency = 0.5}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0.08)
        tbl_upv_11.newName.Text = string.upper(WeaponInfo_upv_1.Name(a71.item))
        tbl_upv_11.newName.Position = UDim2.fromOffset(0, 230)
        local v140 = tbl_upv_11.newName
        v140.TextTransparency = 1
        local v141
        if v140:IsA("TextLabel") then
            v141 = v140:FindFirstChildWhichIsA("UIStroke")
        else
            v141 = nil
        end
        local v142, v143
        if v141 then
            if type(v141:GetAttribute("Authored")) ~= "number" then
                v141:SetAttribute("Authored", v141.Transparency)
            end
            v142, v143 = v141, 1
        else
            v142 = nil
            v143 = 1
        end
        if v142 then
            v142.Transparency = v143
        end
        tw(tbl_upv_11.newName, 0.35, {TextTransparency = 0, Position = UDim2.fromOffset(0, 210)}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0.3)
        local newSub_2 = tbl_upv_11.newSub
        local v144 = WeaponInfo_upv_1.Get(a71.item)
        newSub_2.Text = string.format("%s  \194\183  UNLOCKED  \194\183  EQUIP IT IN YOUR LOADOUT", ((v144 and (WeaponInfo_upv_1.CATEGORY_SINGULAR)) and (WeaponInfo_upv_1.CATEGORY_SINGULAR[v144.category])) or "ITEM")
        tbl_upv_11.newSub.Position = UDim2.fromOffset(0, 272)
        local newSub_3 = tbl_upv_11.newSub
        newSub_3.TextTransparency = 1
        local v145
        if newSub_3:IsA("TextLabel") then
            v145 = newSub_3:FindFirstChildWhichIsA("UIStroke")
        else
            v145 = nil
        end
        if v145 then
            if type(v145:GetAttribute("Authored")) ~= "number" then
                v145:SetAttribute("Authored", v145.Transparency)
            end
            v142, v143 = v145, 1
        else
            v142 = nil
            v143 = 1
        end
        if v142 then
            v142.Transparency = v143
        end
        tw(tbl_upv_11.newSub, 0.35, {TextTransparency = 0, Position = UDim2.fromOffset(0, 256)}, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0.42)
        a1.Sounds.Play("NewItem_Fanfare")
        for _, value_14 in {tbl_upv_11.title, tbl_upv_11.titleShadow, tbl_upv_11.subtitle} do
            tw(value_14, 0.15, {TextTransparency = 1}, Enum.EasingStyle.Quad)
        end
        task.delay(
            u7 * 0.16,
            function()
                --[[
                  line: 1560
                  upvalues:
                    a70 (copy, index: 1)
                    u9 (ref,  index: 2)
                    tbl_upv_11 (copy, index: 3)
                ]]
                local v146 = (u9 ~= nil) and (u9.token == a70)
                if not v146 or u9.phase ~= "newitem" then
                    return
                end
                tbl_upv_11.title.Visible = false
                tbl_upv_11.titleShadow.Visible = false
                tbl_upv_11.subtitle.Visible = false
            end
        )
        if sleep(a70, 0.3, false) then
            u23 = 18
            u24 = 0
            u25 = 0.35
            tbl_upv_11.newHeadScale.Scale = 1.08
            tw(tbl_upv_11.newHeadScale, 0.22, {Scale = 1}, Enum.EasingStyle.Back)
            tbl_upv_11.newAura.TextTransparency = 0.3
            tbl_upv_11.newAuraScale.Scale = 1.02
            tw(tbl_upv_11.newAuraScale, 0.6, {Scale = 1.35}, Enum.EasingStyle.Quart)
            tw(tbl_upv_11.newAura, 0.6, {TextTransparency = 1}, Enum.EasingStyle.Quad)
            tbl_upv_11.newFlare.ImageColor3 = v139
            tbl_upv_11.newFlare.ImageTransparency = 0.2
            tbl_upv_11.newFlare.Size = UDim2.fromOffset(300, 120)
            tw(tbl_upv_11.newFlare, 0.5, {ImageTransparency = 1, Size = UDim2.fromOffset(1600, 150)}, Enum.EasingStyle.Quart)
            tbl_upv_11.frontPool:Burst(40, {sparkChance = 0.6, whiteChance = 0.3, speed = 1300, mode = "box", box = Vector2.new(560, 90), at = Vector2.new(0, -300), colors = {v138, v139}, white = v139})
            tbl_upv_11.frontPool:Burst(36, {lifeMin = 0.6, speedMax = 1300, lifeMax = 1.2, drag = 1.6, whiteChance = 0, sparkChance = 0.55, speedMin = 500, sparkLen = 150, jitter = 90, mode = "point", grav = 500, size = 26, at = Vector2.new(0, -40), colors = {v138, v139, Colors_upv_1.Gold}})
            tbl_upv_11.frontPool:Burst(20, {lifeMin = 1, speedMax = 260, lifeMax = 1.8, drag = 0.8, whiteChance = 0, speedMin = 60, kind = "sparkle", jitter = 160, mode = "point", grav = -60, size = 36, at = Vector2.new(0, -40), colors = {v139, Colors_upv_1.Gold}})
            if not sleep(a70, 0.5, false) then
                return false
            end
            u9.tapped = false
            sleep(a70, tbl_upv_3.newItem - 0.8, true)
            v140 = (u9 ~= nil) and (u9.token == a70)
            if not v140 or u9.skip then
                return false
            end
            tw(tbl_upv_11.newItemScale, 0.25, {Scale = 0}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            for _, value_15 in {tbl_upv_11.newHead, tbl_upv_11.newShadow, tbl_upv_11.newName, tbl_upv_11.newSub} do
                tw(value_15, 0.2, {TextTransparency = 1}, Enum.EasingStyle.Quad)
            end
            tw(tbl_upv_11.newRaysA, 0.3, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.newRaysB, 0.3, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.newGlow, 0.3, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.newDim, 0.3, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
            tbl_upv_11.title.Visible = true
            tbl_upv_11.titleShadow.Visible = true
            tbl_upv_11.subtitle.Visible = true
            tw(tbl_upv_11.title, 0.25, {TextTransparency = 0}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.titleShadow, 0.25, {TextTransparency = 0.55}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.subtitle, 0.25, {TextTransparency = 0}, Enum.EasingStyle.Quad)
            sleep(a70, 0.22, false)
            tbl_upv_11.newRoot.Visible = false
            WeaponIcon_upv_1.Set(tbl_upv_11.newItem, nil)
            tbl_upv_11.card.Visible = true
            tbl_upv_11.barBox.Visible = true
            v140 = #u9.reveal.stacks - (u9.cardIndex or 0)
            tbl_upv_11.counter.Visible = v140 > 0
            tbl_upv_11.counterText.Text = "x" .. v140
            tbl_upv_13.raysSpin = 8
            v140 = (u9 ~= nil) and (u9.token == a70)
            if v140 then
                v140 = not u9.skip
            end
            return v140
        end
        return false
    end
    local function setBar(a72, a73, a74)
        --[[
          name: setBar
          line: 1458
          upvalues:
            tbl_upv_11 (copy, index: 1)
            tw (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
        ]]
        local v147 = math.clamp(a72, 0, 1)
        if a73 then
            tbl_upv_11.barFill.Size = UDim2.fromScale(v147, 1)
            tbl_upv_11.barHead.Position = UDim2.fromOffset(v147 * 330, 43)
        else
            tw(tbl_upv_11.barFill, a74 or (tbl_upv_3.bar), {Size = UDim2.fromScale(v147, 1)}, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
            tw(tbl_upv_11.barHead, a74 or (tbl_upv_3.bar), {Position = UDim2.fromOffset(v147 * 330, 43)}, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        end
    end
    local function phaseCard(a75, a76, a77)
        --[[
          name: phaseCard
          line: 1615
          upvalues:
            u9 (ref,  index: 1)
            catColor (copy, index: 2)
            paintFace (copy, index: 3)
            u13 (ref,  index: 4)
            project (copy, index: 5)
            tbl_upv_11 (copy, index: 6)
            WeaponIcon_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
            u22 (copy, index: 9)
            UI_upv_1 (copy, index: 10)
            animate (copy, index: 11)
            tw (copy, index: 12)
            tbl_upv_3 (copy, index: 13)
            sleep (copy, index: 14)
            paintBar (copy, index: 15)
            tbl_upv_4 (copy, index: 16)
            u7 (ref,  index: 17)
            setBar (copy, index: 18)
            finishGroup (copy, index: 19)
            Colors_upv_1 (copy, index: 20)
            phaseNewItem (copy, index: 21)
            u23 (ref,  index: 22)
            u24 (ref,  index: 23)
            u25 (ref,  index: 24)
            Theme_upv_1 (copy, index: 25)
        ]]
        local look_5 = u9.look
        u9.phase = "card"
        u9.cardIndex = a76
        u9.hurry = false
        u9.tapped = false
        u9.group = {}
        local v148 = catColor(a77.item)
        paintFace(a77)
        local v149 = project(Vector3.new(0, u13.Position.Y + 0.2, 0))
        local v150 = Vector2.new(tbl_upv_11.chestHolder.Position.X.Offset + (v149.X * 0.46), 290 + (v149.Y * 0.46))
        local v151 = ((#u9.reveal.stacks >= 4) and 0.82) or 1
        local card_1 = tbl_upv_11.card
        card_1.Visible = true
        tbl_upv_11.back.Visible = true
        tbl_upv_11.face.Visible = false
        card_1.Size = UDim2.fromOffset(232, 322)
        card_1.Position = UDim2.fromOffset(v150.X, v150.Y)
        card_1.Rotation = ((a76 % 2 ~= 0) and 200) or -200
        tbl_upv_11.cardScale.Scale = 0.22799999999999998
        tbl_upv_11.cardGlow.ImageTransparency = 1
        tbl_upv_11.sheen.BackgroundTransparency = 1
        WeaponIcon_upv_1.Set(tbl_upv_11.icon, nil)
        a1.Sounds.Play("Card_Whoosh", {pitch = 0.95 + (u22:NextNumber() * 0.1)})
        local v152 = #u9.reveal.stacks - a76
        tbl_upv_11.counter.Visible = v152 > 0
        tbl_upv_11.counterText.Text = "x" .. v152
        UI_upv_1.Pop(tbl_upv_11.counter, 1.35)
        animate("sq", {{0.1, 0.06, "outQuad"}, {0, 0.16, "outQuad"}})
        tbl_upv_11.chestGlow.ImageTransparency = 0.3
        tw(tbl_upv_11.chestGlow, 0.5, {ImageTransparency = 0.6}, Enum.EasingStyle.Quad)
        tbl_upv_11.backPool:Burst(8, {lifeMin = 0.4, speedMax = 600, dir = -90, lifeMax = 0.8, drag = 1.3, whiteChance = 0, grav = 700, speedMin = 250, jitter = 30, kind = "sparkle", mode = "point", spread = 40, size = 26, at = v150, colors = {look_5.light, look_5.primary}})
        tw(card_1, tbl_upv_3.cardFly * v151, {Position = UDim2.fromOffset(0, -64)}, Enum.EasingStyle.Quint)
        tw(card_1, tbl_upv_3.cardFly * v151, {Rotation = 0}, Enum.EasingStyle.Quart)
        tw(tbl_upv_11.cardScale, tbl_upv_3.cardFly * v151, {Scale = 1.14}, Enum.EasingStyle.Back)
        tbl_upv_11.barBox.Visible = false
        if not sleep(a75, tbl_upv_3.cardFly * v151, true) then
            return false
        end
        a1.Sounds.Play("Card_Flip")
        tw(card_1, tbl_upv_3.flip / 2, {Size = UDim2.fromOffset(0, 322)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        tw(tbl_upv_11.cardScale, tbl_upv_3.flip / 2, {Scale = 1.254}, Enum.EasingStyle.Quad)
        if not sleep(a75, tbl_upv_3.flip / 2, true) then
            return false
        end
        tbl_upv_11.back.Visible = false
        tbl_upv_11.face.Visible = true
        tbl_upv_11.well.Visible = false
        tbl_upv_11.name.Visible = false
        tbl_upv_11.count.Visible = false
        tw(card_1, tbl_upv_3.flip / 2, {Size = UDim2.fromOffset(232, 322)}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.cardScale, 0.3, {Scale = 1.14}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, tbl_upv_3.flip / 2)
        tbl_upv_11.icon.Visible = false
        WeaponIcon_upv_1.Set(tbl_upv_11.icon, a77.item, {outline = true, spin = true, outlineTransparency = 0.45, outlineScale = 1.04, glow = false, outlineColor = v148:Lerp(Color3.new(1, 1, 1), 0.5)})
        if not sleep(a75, tbl_upv_3.flip / 2, true) then
            return false
        end
        tbl_upv_11.well.Visible = true
        tbl_upv_11.name.Visible = true
        tbl_upv_11.count.Visible = true
        tbl_upv_11.icon.Visible = true
        tbl_upv_11.iconScale.Scale = 0.6
        tw(tbl_upv_11.iconScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back)
        a1.Sounds.Play("Card_Reveal", {pitch = (math.min(a76 - 1, 4) * 0.04) + 1})
        tbl_upv_11.sheen.BackgroundTransparency = 0.55
        tbl_upv_11.sheenGrad.Offset = Vector2.new(-1, 0)
        tw(tbl_upv_11.sheenGrad, 0.45, {Offset = Vector2.new(1, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        tbl_upv_11.cardGlow.ImageTransparency = 0.35
        tw(tbl_upv_11.cardGlow, 0.8, {ImageTransparency = 0.62}, Enum.EasingStyle.Quad)
        tbl_upv_11.frontPool:Burst(14, {lifeMin = 0.4, speedMax = 700, lifeMax = 0.8, drag = 2, whiteChance = 0, sparkChance = 0.5, speedMin = 250, sparkLen = 110, jitter = 130, mode = "point", grav = 400, size = 20, at = Vector2.new(0, -64), colors = {v148, v148:Lerp(Color3.new(1, 1, 1), 0.4)}})
        local need_1 = a77.need
        paintBar(a77, a77.before, need_1, a77.levelBefore, v148, (math.min(a77.total, need_1 or (a77.total))))
        local v153 = math.clamp((need_1 and (a77.before / need_1)) or 1, 0, 1)
        tbl_upv_11.barFill.Size = UDim2.fromScale(v153, 1)
        tbl_upv_11.barHead.Position = UDim2.fromOffset(v153 * tbl_upv_4.barW, 43)
        tbl_upv_11.barBox.Visible = true
        tbl_upv_11.barBox.Position = UDim2.fromOffset(0, 128)
        UI_upv_1.FadeIn(tbl_upv_11.barBox, TweenInfo.new(u7 * 0.18))
        local shards_upv_2 = a77.shards
        task.spawn(
            function()
                --[[
                  line: 1693
                  upvalues:
                    shards_upv_2 (copy, index: 1)
                    tbl_upv_3 (copy, index: 2)
                    a75 (copy, index: 3)
                    u9 (ref,  index: 4)
                    tbl_upv_11 (copy, index: 5)
                    a1 (copy, index: 6)
                    u7 (ref,  index: 7)
                    tw (copy, index: 8)
                ]]
                local v154 = math.min(shards_upv_2, 12)
                local v155 = tbl_upv_3.count / math.max(v154, 1)
                for n_1 = 1, v154 do
                    if true or u9.hurry or u9.skip then
                        break
                    else
                        tbl_upv_11.countText.Text = "x" .. math.floor(((shards_upv_2 * n_1) / v154) + 0.5)
                        a1.Sounds.Play("Tick", {volume = 0.8, pitch = (n_1 * 0.045) + 1})
                        task.wait(v155 * u7)
                    end
                end
                local v156 = (u9 ~= nil) and (u9.token == a75)
                if not v156 then
                    return
                end
                tbl_upv_11.countText.Text = "x" .. shards_upv_2
                tbl_upv_11.countScale.Scale = 1.35
                tw(tbl_upv_11.countScale, 0.25, {Scale = 1}, Enum.EasingStyle.Back)
            end
        )
        a1.Sounds.Play("XP_Tick", {volume = 0.9})
        v153 = ((not need_1) and 1) or (math.min(1, a77.total / need_1))
        tbl_upv_11.barHead.ImageColor3 = v148:Lerp(Color3.new(1, 1, 1), 0.45)
        tbl_upv_11.barHead.ImageTransparency = 0.05
        setBar(v153, false)
        tw(tbl_upv_11.barHead, tbl_upv_3.bar + 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0.1)
        local tbl_30 = {lifeMin = 0.3, speedMax = 200, dir = -90, lifeMax = 0.6, drag = 1, whiteChance = 0, grav = 300, at = 0, speedMin = 60, colors = 0, jitter = 6, kind = "sparkle", mode = "point", spread = 70, size = 16}
        tbl_30.at = Vector2.new(-165 + (330 * ((need_1 and (a77.before / need_1)) or 0)), 171)
        tbl_30.colors = {v148:Lerp(Color3.new(1, 1, 1), 0.4)}
        u9.headOpts = tbl_30
        local v157 = tbl_upv_11.frontPool:Emit(34, u9.headOpts)
        local v158 = sleep(a75, math.max(tbl_upv_3.bar, tbl_upv_3.count) * v151, true)
        v157()
        if u9 then
            u9.headOpts = nil
        end
        if not v158 then
            return false
        end
        tbl_upv_11.countText.Text = "x" .. shards_upv_2
        finishGroup()
        u9.group = nil
        u9.hurry = false
        u9.tapped = false
        if a77.unlocked then
            tbl_upv_11.barFlash.BackgroundColor3 = Colors_upv_1.Gold
            tbl_upv_11.barFlash.BackgroundTransparency = 0.2
            tw(tbl_upv_11.barFlash, 0.4, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
            if not sleep(a75, 0.18, false) or not phaseNewItem(a75, a77) then
                return false
            end
            u9.phase = "card"
            tbl_upv_11.tag.BackgroundColor3 = Colors_upv_1.Gold
            tbl_upv_11.tagText.Text = "NEW"
            tbl_upv_11.tagText.TextColor3 = Colors_upv_1.TextDark
            UI_upv_1.Pop(tbl_upv_11.tag, 1.6)
            paintBar(a77, a77.surplus, a77.needAfter, 1, v148, a77.surplus)
            local v159 = math.clamp(((a77.needAfter) and (a77.surplus / a77.needAfter)) or 1, 0, 1)
            tbl_upv_11.barFill.Size = UDim2.fromScale(v159, 1)
            tbl_upv_11.barHead.Position = UDim2.fromOffset(v159 * tbl_upv_4.barW, 43)
        end
        if a77.ready then
            tbl_upv_11.stamp.Visible = true
            tbl_upv_11.stampScale.Scale = 2.4
            tbl_upv_11.stamp.Rotation = -18
            tw(tbl_upv_11.stampScale, 0.22, {Scale = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            tw(tbl_upv_11.stamp, 0.22, {Rotation = -8}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            a1.Sounds.Play("Upgrade_Ready")
            if sleep(a75, 0.22, false) then
                u23 = 8
                u24 = 0
                u25 = 0.2
                tbl_upv_11.barGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(Colors_upv_1.Success, 0.15), Colors_upv_1.SuccessDark)
                tbl_upv_11.barFlash.BackgroundColor3 = Colors_upv_1.Success
                tbl_upv_11.barFlash.BackgroundTransparency = 0.25
                tw(tbl_upv_11.barFlash, 0.4, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
                tbl_upv_11.frontPool:Burst(16, {lifeMin = 0.4, speedMax = 650, lifeMax = 0.8, drag = 1.8, whiteChance = 0, sparkChance = 0.5, speedMin = 250, sparkLen = 110, jitter = 110, mode = "point", grav = 500, size = 20, at = Vector2.new(0, -67.42), colors = {Colors_upv_1.Success, Theme_upv_1.Lighten(Colors_upv_1.Success, 0.4)}})
            else
                return false
            end
        end
        u9.hurry = false
        u9.tapped = false
        sleep(a75, tbl_upv_3.dwell * v151 + (((a77.ready) and 0.35) or 0), true)
        local v160 = (u9 ~= nil) and (u9.token == a75)
        if v160 and not (u9.skip) then
            local v161 = a76 == #u9.reveal.stacks
            if not (v161) then
                local cardOut_1 = tbl_upv_3.cardOut
                local tbl_31 = {Rotation = 0, Position = 0}
                tbl_31.Position = UDim2.fromOffset(((a76 % 2 ~= 0) and -520) or 520, -104)
                tbl_31.Rotation = ((a76 % 2 ~= 0) and -14) or 14
                tw(card_1, cardOut_1, tbl_31, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                tw(tbl_upv_11.cardScale, tbl_upv_3.cardOut, {Scale = 0.6839999999999999}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                UI_upv_1.FadeOut(tbl_upv_11.barBox, TweenInfo.new((tbl_upv_3.cardOut * 0.8) * u7))
                if sleep(a75, tbl_upv_3.cardOut, false) then
                    card_1.Visible = false
                    UI_upv_1.Unfade(tbl_upv_11.barBox)
                    tbl_upv_11.barBox.Visible = false
                else
                    return false
                end
            end
            return true
        end
        return false
    end
    local function tileFor(a78)
        --[[
          name: tileFor
          line: 1794
          upvalues:
            tbl_upv_11 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            Theme_upv_1 (copy, index: 5)
        ]]
        local v162 = tbl_upv_11.tiles[a78]
        if v162 then
            return v162
        end
        local v163 = {}
        v163.Name = "Tile" .. a78
        v163.AnchorPoint = Vector2.new(0.5, 0.5)
        v163.Size = UDim2.fromOffset(168, 236)
        v163.BackgroundColor3 = Color3.new(1, 1, 1)
        v163.ZIndex = 12
        v163[1] = UI_upv_1.Corner(14)
        v163.Parent = tbl_upv_11.sumRow
        local v164 = UI_upv_1.new("Frame", v163)
        local v165 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = v164})
        v163 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2.5, 0.1)
        v163.Parent = v164
        local v166 = UI_upv_1.new("UIScale", {Parent = v164})
        local tbl_32 = {}
        tbl_32.Position = UDim2.fromOffset(8, 8)
        tbl_32.Size = UDim2.new(1, -16, 0, 132)
        tbl_32.BackgroundColor3 = Colors_upv_1.Void
        tbl_32.BackgroundTransparency = 0.45
        tbl_32.ZIndex = 13
        tbl_32[1] = UI_upv_1.Corner(10)
        tbl_32.Parent = v164
        local v167 = UI_upv_1.new("Frame", tbl_32)
        local v168 = UI_upv_1.new("Frame", {ZIndex = 14, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(126, 126), Parent = v167})
        v167 = UI_upv_1.new("TextLabel", {ZIndex = 14, Text = "", TextSize = 17, Position = UDim2.fromOffset(8, 146), Size = UDim2.new(1, -16, 0, 22), FontFace = Fonts_upv_1.Heavy, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v164})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.45).Parent = v167
        tbl_32 = UI_upv_1.new("TextLabel", {ZIndex = 14, Text = "", TextSize = 28, Position = UDim2.fromOffset(8, 168), Size = UDim2.new(1, -16, 0, 30), FontFace = Fonts_upv_1.Display, Parent = v164})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = tbl_32
        local tbl_33 = {}
        tbl_33.Position = UDim2.fromOffset(12, 206)
        tbl_33.Size = UDim2.new(1, -24, 0, 12)
        tbl_33.BackgroundColor3 = Colors_upv_1.Void
        tbl_33.BackgroundTransparency = 0.25
        tbl_33.ClipsDescendants = true
        tbl_33.ZIndex = 14
        tbl_33[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_33.Parent = v164
        local v169 = UI_upv_1.new("Frame", tbl_33)
        local tbl_34 = {}
        tbl_34.Size = UDim2.fromScale(0, 1)
        tbl_34.BackgroundColor3 = Colors_upv_1.Accent
        tbl_34.ZIndex = 15
        tbl_34[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_34.Parent = v169
        local v170 = UI_upv_1.new("Frame", tbl_34)
        local tbl_35 = {}
        tbl_35.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_35.Position = UDim2.new(0.5, 0, 0, 8)
        tbl_35.Size = UDim2.fromOffset(120, 28)
        tbl_35.BackgroundColor3 = Colors_upv_1.Gold
        tbl_35.ZIndex = 16
        tbl_35[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_35.Parent = v164
        local v171 = UI_upv_1.new("Frame", tbl_35)
        local tbl_36 = {frame = v164, grad = v165, stroke = v163, scale = v166, icon = v168, name = v167, count = tbl_32, barFill = v170, tag = v171, tagText = UI_upv_1.new("TextLabel", {ZIndex = 17, Text = "NEW", TextSize = 16, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.TextDark, Parent = v171})}
        tbl_upv_11.tiles[a78] = tbl_36
        return tbl_36
    end
    local function phaseSummary(a79)
        --[[
          name: phaseSummary
          line: 1818
          upvalues:
            u9 (ref,  index: 1)
            tbl_upv_22 (copy, index: 2)
            tbl_upv_11 (copy, index: 3)
            WeaponIcon_upv_1 (copy, index: 4)
            tw (copy, index: 5)
            titleIn (copy, index: 6)
            tbl_upv_13 (copy, index: 7)
            tileFor (copy, index: 8)
            catColor (copy, index: 9)
            Colors_upv_1 (copy, index: 10)
            WeaponInfo_upv_1 (copy, index: 11)
            Theme_upv_1 (copy, index: 12)
            a1 (copy, index: 13)
            tbl_upv_3 (copy, index: 14)
            sleep (copy, index: 15)
        ]]
        local reveal_1 = u9.reveal
        local look_6 = u9.look
        u9.phase = "summary"
        u9.skip = false
        u9.hurry = false
        u9.tapped = false
        tbl_upv_22.on = false
        if u9.stopSparkles then
            u9.stopSparkles()
            u9.stopSparkles = nil
        end
        tbl_upv_11.card.Visible = false
        tbl_upv_11.barBox.Visible = false
        tbl_upv_11.newRoot.Visible = false
        WeaponIcon_upv_1.Set(tbl_upv_11.newItem, nil)
        WeaponIcon_upv_1.Set(tbl_upv_11.icon, nil)
        tbl_upv_11.prompt.Visible = false
        tbl_upv_11.counter.Visible = false
        tbl_upv_11.skip.Visible = false
        tbl_upv_11.leak.ImageTransparency = 1
        tbl_upv_11.leakFlare.ImageTransparency = 1
        tbl_upv_11.beam.ImageTransparency = 1
        if not (u9.summaryOnly) then
            tw(tbl_upv_11.chestHolder, 0.3, {Position = UDim2.fromOffset(0, 350)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            tw(tbl_upv_11.vpf, 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.chestGlow, 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
            tw(tbl_upv_11.shadow, 0.25, {ImageTransparency = 1}, Enum.EasingStyle.Quad)
        end
        if tbl_upv_11.title.TextTransparency > 0.5 then
            titleIn(look_6.title, u9.subtitle)
        end
        tw(tbl_upv_11.dim, 0.3, {BackgroundTransparency = 0.12}, Enum.EasingStyle.Quad)
        tbl_upv_11.raysHolder.Position = UDim2.fromOffset(0, -40)
        tbl_upv_11.raysScale.Scale = 1
        tw(tbl_upv_11.raysA, 0.4, {ImageTransparency = math.min(0.9, look_6.rays + 0.1)}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.raysB, 0.4, {ImageTransparency = math.min(0.94, look_6.rays + 0.2)}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.halo, 0.4, {ImageTransparency = 0.62, Size = UDim2.fromOffset(900, 700)}, Enum.EasingStyle.Quad)
        tbl_upv_13.raysSpin = 6
        local v172 = #reveal_1.stacks
        local v173 = math.min(1.14, 1040 / math.max(1, (v172 * 186) - 18))
        local v174, v175 = nil, nil
        for n_2 = 1, math.max(v172, #tbl_upv_11.tiles) do
            local v176 = reveal_1.stacks[n_2]
            if v176 then
                local v177 = tileFor(n_2)
                local v178 = catColor(v176.item)
                v177.frame.Visible = true
                v177.grad.Color = ColorSequence.new(v178:Lerp(Colors_upv_1.Void, 0.2), v178:Lerp(Colors_upv_1.Void, 0.7))
                v177.stroke.Color = v178:Lerp(Color3.new(1, 1, 1), 0.4)
                v177.name.Text = string.upper(WeaponInfo_upv_1.Name(v176.item))
                v177.count.Text = "x" .. v176.shards
                local levelBefore_1 = v176.levelBefore
                v175 = v176.total
                v174 = v176.need
                if v176.unlocked then
                    local _ = 1
                    v175 = v176.surplus
                    v174 = v176.needAfter
                end
                local barFill_1 = v177.barFill
                local v179
                if v174 then
                    v179 = math.clamp(v175 / v174, 0, 1)
                else
                    v179 = 1
                end
                barFill_1.Size = UDim2.fromScale(v179, 1)
                local barFill_2 = v177.barFill
                local v180
                if v176.ready then
                    v180 = Colors_upv_1.Success
                else
                    v180 = v178
                end
                barFill_2.BackgroundColor3 = v180
                if v176.unlocked then
                    v177.tag.Visible = true
                    v177.tag.BackgroundColor3 = Colors_upv_1.Gold
                    v177.tagText.Text = "NEW ITEM"
                    v177.tagText.TextColor3 = Colors_upv_1.TextDark
                    WeaponIcon_upv_1.Set(v177.icon, v176.item, {outline = false, glow = false})
                    v174 = ((n_2 - 1) - ((v172 - 1) / 2)) * 186 * v173
                    v177.frame.Position = UDim2.fromOffset(v174, 60)
                    v177.scale.Scale = 0
                    tw(v177.frame, 0.4, {Position = UDim2.fromOffset(v174, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((n_2 - 1) * 0.07) + 0.05)
                    tw(v177.scale, 0.4, {Scale = v173}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((n_2 - 1) * 0.07) + 0.05)
                    continue
                end
                if v176.ready then
                    v177.tag.Visible = true
                    v177.tag.BackgroundColor3 = Colors_upv_1.Success
                    v177.tagText.Text = "UPGRADE"
                    v177.tagText.TextColor3 = Colors_upv_1.Text
                    WeaponIcon_upv_1.Set(v177.icon, v176.item, {outline = false, glow = false})
                    v174 = ((n_2 - 1) - ((v172 - 1) / 2)) * 186 * v173
                    v177.frame.Position = UDim2.fromOffset(v174, 60)
                    v177.scale.Scale = 0
                    tw(v177.frame, 0.4, {Position = UDim2.fromOffset(v174, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((n_2 - 1) * 0.07) + 0.05)
                    tw(v177.scale, 0.4, {Scale = v173}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((n_2 - 1) * 0.07) + 0.05)
                    continue
                end
                if levelBefore_1 <= 0 then
                    v177.tag.Visible = true
                    v177.tag.BackgroundColor3 = Colors_upv_1.Raised
                    v177.tagText.Text = string.format("%d / %d", v175, v174 or 0)
                    v177.tagText.TextColor3 = Colors_upv_1.TextDim
                else
                    v177.tag.Visible = true
                    v177.tag.BackgroundColor3 = Colors_upv_1.Raised
                    v177.tagText.Text = "LV " .. levelBefore_1
                    v177.tagText.TextColor3 = Colors_upv_1.Text
                end
                WeaponIcon_upv_1.Set(v177.icon, v176.item, {outline = false, glow = false})
                v174 = ((n_2 - 1) - ((v172 - 1) / 2)) * 186 * v173
                v177.frame.Position = UDim2.fromOffset(v174, 60)
                v177.scale.Scale = 0
                tw(v177.frame, 0.4, {Position = UDim2.fromOffset(v174, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((n_2 - 1) * 0.07) + 0.05)
                tw(v177.scale, 0.4, {Scale = v173}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, ((n_2 - 1) * 0.07) + 0.05)
            else
                local v181 = tbl_upv_11.tiles[n_2]
                if v181 then
                    v181.frame.Visible = false
                    WeaponIcon_upv_1.Set(v181.icon, nil)
                end
            end
        end
        local v182 = 0
        local v183 = 0
        local v184 = 0
        local v185, v186, v187
        v185, v186, v187 = v182, v183, v184
        for _, value_16 in reveal_1.stacks do
            local v188 = v185 + value_16.shards
            local v189 = ((value_16.unlocked) and (v186 + 1)) or v186
            v187 = ((value_16.ready) and (v187 + 1)) or v187
            v185, v186 = v188, v189
        end
        v173 = {string.format("<font color=\"#%s\">+%d</font> SHARDS", look_6.light:ToHex(), v185)}
        if v186 > 0 then
            local v190 = Colors_upv_1.Gold:ToHex()
            table.insert(v173, string.format("<font color=\"#%s\">%d NEW ITEM%s</font>", v190, v186, ((v186 > 1) and "S") or ""))
        end
        if v187 > 0 then
            local v191 = Theme_upv_1.Lighten(Colors_upv_1.Success, 0.2):ToHex()
            table.insert(v173, string.format("<font color=\"#%s\">%d UPGRADE%s READY</font>", v191, v187, ((v187 > 1) and "S") or ""))
        end
        if v172 == 0 then
            local tbl_37 = {}
            tbl_37[1] = not (reveal_1.xp) and "EVERYTHING MAXED" or string.format("EVERYTHING MAXED  \194\183  +%d XP", reveal_1.xp)
            v173 = tbl_37
        end
        for key_4, value_17 in v173 do
            v173[key_4] = a1.Loc.T(value_17)
        end
        tbl_upv_11.sumTotals.Text = table.concat(v173, "   \194\183   ")
        local sumTotals_2 = tbl_upv_11.sumTotals
        sumTotals_2.TextTransparency = 1
        if sumTotals_2:IsA("TextLabel") then
            v187 = sumTotals_2:FindFirstChildWhichIsA("UIStroke")
        else
            v187 = nil
        end
        local v193, v194
        if v187 then
            if type(v187:GetAttribute("Authored")) ~= "number" then
                v187:SetAttribute("Authored", v187.Transparency)
            end
            v193, v194 = v187, 1
        else
            v193 = nil
            v194 = 1
        end
        if v193 then
            v193.Transparency = v194
        end
        tw(tbl_upv_11.sumTotals, 0.3, {TextTransparency = 0}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, (v172 * 0.07) + 0.25)
        tbl_upv_11.sumRoot.Visible = true
        tbl_upv_11.cont.Visible = true
        tbl_upv_11.contScale.Scale = 0
        tw(tbl_upv_11.contScale, 0.35, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out, (v172 * 0.07) + 0.35)
        a1.Sounds.Play("Reward")
        tbl_upv_11.frontPool:Burst(((look_6.legendary) and 34) or 20, {lifeMin = 0.9, speedMax = 180, lifeMax = 1.7, drag = 0.6, whiteChance = 0, speedMin = 40, kind = "sparkle", jitter = 380, mode = "point", grav = -40, size = 28, at = Vector2.new(0, -40), colors = {look_6.light, look_6.primary}})
        local v195 = u9.opts.autoContinue or (tbl_upv_3.summaryAuto[u9.source] or 6)
        tbl_upv_11.contFillGrad.Offset = Vector2.new(-0.5, 0)
        tw(tbl_upv_11.contFillGrad, v195, {Offset = Vector2.new(0.5, 0)}, Enum.EasingStyle.Linear)
        if not sleep(a79, 0.45, false) then
            return
        end
        sleep(a79, v195 - 0.45, true)
    end
    local function hideAll()
        --[[
          name: hideAll
          line: 1958
          upvalues:
            tbl_upv_11 (copy, index: 1)
            WeaponIcon_upv_1 (copy, index: 2)
            tbl_upv_16 (copy, index: 3)
            u12 (ref,  index: 4)
        ]]
        tbl_upv_11.root.Visible = false
        tbl_upv_11.card.Visible = false
        tbl_upv_11.barBox.Visible = false
        tbl_upv_11.newRoot.Visible = false
        tbl_upv_11.sumRoot.Visible = false
        tbl_upv_11.prompt.Visible = false
        tbl_upv_11.counter.Visible = false
        tbl_upv_11.skip.Visible = false
        tbl_upv_11.chestHolder.Visible = false
        WeaponIcon_upv_1.Set(tbl_upv_11.icon, nil)
        WeaponIcon_upv_1.Set(tbl_upv_11.newItem, nil)
        for _, value_18 in tbl_upv_11.tiles do
            WeaponIcon_upv_1.Set(value_18.icon, nil)
            value_18.frame.Visible = false
        end
        tbl_upv_11.backPool:Clear()
        tbl_upv_11.frontPool:Clear()
        for _, value_19 in tbl_upv_16 do
            value_19.part:Destroy()
        end
        table.clear(tbl_upv_16)
        u12 = nil
    end
    local tbl_upv_38 = {}
    local function cancelOut()
        --[[
          name: cancelOut
          line: 1981
          upvalues:
            tbl_upv_38 (copy, index: 1)
        ]]
        for _, value_20 in tbl_upv_38 do
            value_20:Cancel()
        end
        table.clear(tbl_upv_38)
    end
    local function snap(a80, a81)
        --[[
          name: snap
          line: 2017
          upvalues:
            TweenService_upv_1 (copy, index: 1)
        ]]
        TweenService_upv_1:Create(a80, TweenInfo.new(0), a81):Play()
        for key_5, value_21 in a81 do
            a80[key_5] = value_21
        end
    end
    local tbl_upv_39 = {BubbleChat = true, Chat = true, TR_TopbarSettings = true, CombatTouch = true, CharacterTouch = true, CombatHUD = true, TR_RevealSafe = true, TouchGui = true}
    local tbl_upv_40 = {TR_ReplayFrame = true, TR_Replay = true, TR_ReplayHud = true}
    local tbl_upv_41 = {}
    local tbl_upv_42 = {}
    local u26 = false
    local function hideCollector(a82)
        --[[
          name: hideCollector
          line: 2043
          upvalues:
            tbl_upv_11 (copy, index: 1)
            tbl_upv_39 (copy, index: 2)
            a1 (copy, index: 3)
            tbl_upv_40 (copy, index: 4)
            tbl_upv_41 (copy, index: 5)
            tbl_upv_42 (copy, index: 6)
        ]]
        if a82 == tbl_upv_11.gui then
            return
        end
        if not (tbl_upv_39[a82.Name]) then
            local v196 = a82:FindFirstAncestorWhichIsA("ScreenGui")
            if not v196 then
                if a82:IsA("ScreenGui") then
                    if a82.Parent == a1.PlayerGui and a82.Enabled then
                        a82.Enabled = false
                        if not (tbl_upv_40[a82.Name]) then
                            tbl_upv_41[a82] = true
                            return
                        end
                    end
                else
                    if not (a82:IsA("BillboardGui")) and not (a82:IsA("SurfaceGui")) or tbl_upv_42[a82] ~= nil then
                        return
                    end
                    pcall(
                        function()
                            --[[
                              line: 2059
                              upvalues:
                                a82 (copy, index: 1)
                                tbl_upv_42 (copy, index: 2)
                            ]]
                            local MaxDistance_1 = a82.MaxDistance
                            a82.MaxDistance = 0.001
                            tbl_upv_42[a82] = MaxDistance_1
                        end
                    )
                end
                return
            end
            if v196.Name ~= "Chat" and v196.Name ~= "BubbleChat" then
                if a82:IsA("ScreenGui") then
                    if a82.Parent == a1.PlayerGui and a82.Enabled then
                        a82.Enabled = false
                        if not (tbl_upv_40[a82.Name]) then
                            tbl_upv_41[a82] = true
                            return
                        end
                    end
                else
                    if not (a82:IsA("BillboardGui")) and not (a82:IsA("SurfaceGui")) or tbl_upv_42[a82] ~= nil then
                        return
                    end
                    pcall(
                        function()
                            --[[
                              line: 2059
                              upvalues:
                                a82 (copy, index: 1)
                                tbl_upv_42 (copy, index: 2)
                            ]]
                            local MaxDistance_1 = a82.MaxDistance
                            a82.MaxDistance = 0.001
                            tbl_upv_42[a82] = MaxDistance_1
                        end
                    )
                end
                return
            end
        end
    end
    local function sweepUi()
        --[[
          name: sweepUi
          line: 2066
          upvalues:
            a1 (copy, index: 1)
            hideCollector (copy, index: 2)
            Workspace_upv_1 (copy, index: 3)
        ]]
        for _, value_22 in a1.PlayerGui:GetDescendants() do
            if value_22:IsA("LayerCollector") then
                hideCollector(value_22)
            end
        end
        local TR_ContractDisplay_1 = Workspace_upv_1:FindFirstChild("TR_ContractDisplay")
        if not TR_ContractDisplay_1 then
            return
        end
        for _, value_23 in TR_ContractDisplay_1:GetDescendants() do
            if value_23:IsA("LayerCollector") then
                hideCollector(value_23)
            end
        end
    end
    local function setAllUiHidden(a83)
        --[[
          name: setAllUiHidden
          line: 2081
          upvalues:
            u26 (ref,  index: 1)
            sweepUi (copy, index: 2)
            ProximityPromptService_upv_1 (copy, index: 3)
            tbl_upv_41 (copy, index: 4)
            tbl_upv_42 (copy, index: 5)
            a1 (copy, index: 6)
        ]]
        if u26 == a83 then
            return
        end
        u26 = a83
        if a83 then
            sweepUi()
            ProximityPromptService_upv_1.Enabled = false
        else
            for key_6 in tbl_upv_41 do
                if key_6.Parent then
                    key_6.Enabled = true
                end
            end
            table.clear(tbl_upv_41)
            for key_upv_7, value_upv_24 in tbl_upv_42 do
                if key_upv_7.Parent then
                    pcall(
                        function()
                            --[[
                              line: 2098
                              upvalues:
                                key_upv_7 (copy, index: 1)
                                value_upv_24 (copy, index: 2)
                            ]]
                            key_upv_7.MaxDistance = value_upv_24
                        end
                    )
                end
            end
            table.clear(tbl_upv_42)
            ProximityPromptService_upv_1.Enabled = not a1.MenuManager.IsOpen()
        end
    end
    tbl_upv_7._SweepUi = function()
        --[[
          line: 2107
          upvalues:
            u26 (ref,  index: 1)
            sweepUi (copy, index: 2)
        ]]
        if not u26 then
            return
        end
        sweepUi()
    end
    local u28 = false
    local function setPlaying(a84)
        --[[
          name: setPlaying
          line: 2115
          upvalues:
            u11 (ref,  index: 1)
            a1 (copy, index: 2)
            u28 (ref,  index: 3)
            tbl_upv_7 (copy, index: 4)
            setAllUiHidden (copy, index: 5)
        ]]
        if u11 == a84 then
            return
        end
        u11 = a84
        a1.SetHudHidden("Reveal", a84)
        a1.MenuManager.HoldChat("Reveal", a84)
        if a84 then
            a1.MenuManager.PushMouse("DropReveal")
            if a1.Canvas.Menus.Visible then
                a1.Canvas.Menus.Visible = false
                u28 = true
            end
        else
            a1.MenuManager.PopMouse("DropReveal")
            if u28 then
                a1.Canvas.Menus.Visible = true
                u28 = false
            end
        end
        tbl_upv_7.Changed:Fire(a84)
        if a1.TopbarSettings and type(a1.TopbarSettings.SetHidden) == "function" then
            pcall(a1.TopbarSettings.SetHidden, "Reveal", a84)
        end
        setAllUiHidden(a84)
        local Economy_2 = a1.Economy
        if not Economy_2 then
            return
        end
        if type(Economy_2.SetRevealShowing) == "function" then
            pcall(Economy_2.SetRevealShowing, a84)
        end
    end
    local function fadeOut(a85)
        --[[
          name: fadeOut
          line: 1987
          upvalues:
            tbl_upv_38 (copy, index: 1)
            TweenService_upv_1 (copy, index: 2)
            tbl_upv_11 (copy, index: 3)
        ]]
        for _, value_25 in tbl_upv_38 do
            value_25:Cancel()
        end
        table.clear(tbl_upv_38)
        local u29 = TweenInfo.new(a85, Enum.EasingStyle.Quad)
        local function add_1(a86, a87)
            --[[
              name: add
              line: 1990
              upvalues:
                TweenService_upv_1 (copy, index: 1)
                u29 (copy, index: 2)
                tbl_upv_38 (copy, index: 3)
            ]]
            local v197 = TweenService_upv_1:Create(a86, u29, a87)
            v197:Play()
            table.insert(tbl_upv_38, v197)
        end
        local v198 = TweenService_upv_1:Create(tbl_upv_11.dim, u29, {BackgroundTransparency = 1})
        v198:Play()
        table.insert(tbl_upv_38, v198)
        local v199 = TweenService_upv_1:Create(tbl_upv_11.vignette, u29, {ImageTransparency = 1})
        v199:Play()
        table.insert(tbl_upv_38, v199)
        local v200 = TweenService_upv_1:Create(tbl_upv_11.tint, u29, {ImageTransparency = 1})
        v200:Play()
        table.insert(tbl_upv_38, v200)
        local v201 = TweenService_upv_1:Create(tbl_upv_11.flash, u29, {BackgroundTransparency = 1})
        v201:Play()
        table.insert(tbl_upv_38, v201)
        for _, value_26 in {tbl_upv_11.raysA, tbl_upv_11.raysB, tbl_upv_11.halo, tbl_upv_11.vpf, tbl_upv_11.chestGlow, tbl_upv_11.shadow} do
            local v202 = TweenService_upv_1:Create(value_26, u29, {ImageTransparency = 1})
            v202:Play()
            table.insert(tbl_upv_38, v202)
        end
        local v203, v204 = nil, nil
        for _, value_27 in {tbl_upv_11.title, tbl_upv_11.titleShadow, tbl_upv_11.subtitle, tbl_upv_11.sumTotals} do
            local v205 = TweenService_upv_1:Create(value_27, u29, {TextTransparency = 1})
            v205:Play()
            table.insert(tbl_upv_38, v205)
            if value_27:IsA("TextLabel") then
                v203 = value_27:FindFirstChildWhichIsA("UIStroke")
            else
                v203 = nil
            end
            if v203 then
                if type(v203:GetAttribute("Authored")) ~= "number" then
                    v203:SetAttribute("Authored", v203.Transparency)
                end
                v204 = v203
            else
                v204 = nil
            end
            if v204 then
                local v206 = TweenService_upv_1:Create(v204, u29, {Transparency = 1})
                v206:Play()
                table.insert(tbl_upv_38, v206)
            end
        end
        local v207 = TweenService_upv_1:Create(tbl_upv_11.contScale, u29, {Scale = 0})
        v207:Play()
        table.insert(tbl_upv_38, v207)
        local v208 = TweenService_upv_1:Create(tbl_upv_11.cardScale, u29, {Scale = 0})
        v208:Play()
        table.insert(tbl_upv_38, v208)
        local v209 = TweenService_upv_1:Create(tbl_upv_11.skip, u29, {BackgroundTransparency = 1})
        v209:Play()
        table.insert(tbl_upv_38, v209)
        for _, value_28 in tbl_upv_11.tiles do
            local v210 = TweenService_upv_1:Create(value_28.scale, u29, {Scale = 0})
            v210:Play()
            table.insert(tbl_upv_38, v210)
        end
    end
    local function u27(a88, a89)
        --[[
          name: finish
          line: 2150
          upvalues:
            u9 (ref,  index: 1)
            u10 (ref,  index: 2)
            tbl_upv_22 (copy, index: 3)
            tbl_upv_14 (copy, index: 4)
            u27 (ref,  index: 5)
            hideAll (copy, index: 6)
            u19 (ref,  index: 7)
            u20 (ref,  index: 8)
            u21 (ref,  index: 9)
            u7 (ref,  index: 10)
            fadeOut (copy, index: 11)
            gradeOut (copy, index: 12)
            setPlaying (copy, index: 13)
            tbl_upv_7 (copy, index: 14)
        ]]
        if not u9 then
            return
        end
        local v211 = u9
        u9 = nil
        u10 = u10 + 1
        local u30 = u10
        tbl_upv_22.on = false
        table.clear(tbl_upv_14)
        if u27 then
            u27()
            u27 = nil
        end
        local function tail_1()
            --[[
              name: tail
              line: 2164
              upvalues:
                u30 (copy, index: 1)
                u10 (ref,  index: 2)
                hideAll (copy, index: 3)
                u19 (ref,  index: 4)
                u20 (ref,  index: 5)
                u21 (ref,  index: 6)
                u7 (ref,  index: 7)
            ]]
            if u30 ~= u10 then
                return
            end
            hideAll()
            if u19 then
                u19:Destroy()
                u19 = nil
            end
            if u20 then
                u20:Destroy()
                u20 = nil
            end
            if u21 then
                u21:Disconnect()
                u21 = nil
            end
            u7 = 1
        end
        if a89 then
            if u30 == u10 then
                hideAll()
                if u19 then
                    u19:Destroy()
                    u19 = nil
                end
                if u20 then
                    u20:Destroy()
                    u20 = nil
                end
                if u21 then
                    u21:Disconnect()
                    u21 = nil
                end
                u7 = 1
            end
        else
            fadeOut(0.28)
            gradeOut(0.3)
            task.delay(
                0.3,
                function()
                    --[[
                      line: 2181
                      upvalues:
                        u30 (copy, index: 1)
                        u10 (ref,  index: 2)
                        hideAll (copy, index: 3)
                        u19 (ref,  index: 4)
                        u20 (ref,  index: 5)
                        u21 (ref,  index: 6)
                        u7 (ref,  index: 7)
                    ]]
                    if u30 ~= u10 or u30 ~= u10 then
                        return
                    end
                    hideAll()
                    if u19 then
                        u19:Destroy()
                        u19 = nil
                    end
                    if u20 then
                        u20:Destroy()
                        u20 = nil
                    end
                    if u21 then
                        u21:Disconnect()
                        u21 = nil
                    end
                    u7 = 1
                end
            )
        end
        setPlaying(false)
        if v211.opts.onDone then
            task.spawn(v211.opts.onDone, a88, v211.reveal.raw)
        end
        if a88 ~= "interrupted" and v211.reveal.id ~= "" and not (v211.summaryOnly) then
            tbl_upv_7._Seen(v211.reveal.id)
        end
        tbl_upv_7._Pump()
    end
    function tbl_upv_7.Skip()
        --[[
          name: Skip
          line: 2197
          upvalues:
            u9 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if not u9 or u9.phase == "summary" or (u9.skip) then
            return
        end
        u9.skip = true
        a1.Sounds.Play("Click")
    end
    local function tap()
        --[[
          name: tap
          line: 2203
          upvalues:
            u9 (ref,  index: 1)
            u7 (ref,  index: 2)
            finishGroup (copy, index: 3)
            tbl_upv_14 (copy, index: 4)
            tbl_upv_13 (copy, index: 5)
        ]]
        if not u9 then
            return
        end
        if u9.phase == "land" then
            u9.tapped = true
        elseif u9.phase == "summary" then
            local v212 = os.clock() - (u9.summaryAt or 0)
            if not (u7 * 0.35 < v212) then
                return
            end
            u9.tapped = true
        elseif u9.phase == "card" and not u9.hurry and u9.group then
            u9.hurry = true
            finishGroup()
            for key_8, value_29 in tbl_upv_14 do
                local v213 = value_29[#value_29]
                if v213 then
                    tbl_upv_13[key_8] = v213.to
                end
            end
            table.clear(tbl_upv_14)
        else
            u9.tapped = true
        end
    end
    tbl_upv_7.Tap = tap
    local function chestToCards()
        --[[
          name: chestToCards
          line: 1428
          upvalues:
            tw (copy, index: 1)
            tbl_upv_11 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
            project (copy, index: 4)
        ]]
        tw(tbl_upv_11.chestHolder, tbl_upv_3.toCards, {Position = UDim2.fromOffset(0, 290)})
        tw(tbl_upv_11.chestScale, tbl_upv_3.toCards, {Scale = 0.46})
        local v214 = project(Vector3.new(0, 0, 0))
        local v215 = Vector2.new(tbl_upv_11.chestHolder.Position.X.Offset + (v214.X * 0.46), 290 + (v214.Y * 0.46))
        tw(tbl_upv_11.shadow, tbl_upv_3.toCards, {Position = UDim2.fromOffset(v215.X, v215.Y + 3), Size = UDim2.fromOffset(250, 50)})
        tw(tbl_upv_11.raysHolder, tbl_upv_3.toCards + 0.1, {Position = UDim2.fromOffset(0, -64)})
        tw(tbl_upv_11.halo, tbl_upv_3.toCards, {ImageTransparency = 0.6}, Enum.EasingStyle.Quad)
    end
    local function paletteOf(a90)
        --[[
          name: paletteOf
          line: 1209
          upvalues:
            tbl_upv_11 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        tbl_upv_11.backGrad.Color = ColorSequence.new(a90.primary:Lerp(Colors_upv_1.Void, 0.25), a90.deep)
        tbl_upv_11.backStroke.Color = a90.light
        tbl_upv_11.backArt.ImageColor3 = a90.light
        tbl_upv_11.counterStroke.Color = a90.primary
        tbl_upv_11.promptStroke.Color = a90.primary
        tbl_upv_11.promptFill.BackgroundColor3 = a90.primary
        tbl_upv_11.cont.BackgroundColor3 = a90.primary
        tbl_upv_11.contGrad.Color = ColorSequence.new(a90.primary:Lerp(Color3.new(1, 1, 1), 0.08), a90.primary:Lerp(Colors_upv_1.Void, 0.35))
        tbl_upv_11.flash.BackgroundColor3 = a90.primary
        tbl_upv_11.tint.ImageColor3 = a90.primary
        tbl_upv_11.halo.ImageColor3 = a90.primary
        tbl_upv_11.raysA.ImageColor3 = a90.light:Lerp(a90.primary, 0.35)
        tbl_upv_11.raysB.ImageColor3 = a90.primary
        tbl_upv_11.chestGlow.ImageColor3 = a90.primary
        tbl_upv_11.leak.ImageColor3 = a90.light
        tbl_upv_11.leakFlare.ImageColor3 = a90.light
        tbl_upv_11.beam.ImageColor3 = a90.light
        tbl_upv_11.floorRing.ImageColor3 = a90.light
        tbl_upv_11.titleGrad.Color = ColorSequence.new(a90.light:Lerp(Color3.new(1, 1, 1), 0.3), a90.primary)
    end
    function tbl_upv_7.Play(a91, a92)
        --[[
          name: Play
          line: 2230
          upvalues:
            normReveal (copy, index: 1)
            a1 (copy, index: 2)
            tbl_upv_7 (copy, index: 3)
            u9 (ref,  index: 4)
            u27 (copy, index: 5)
            build (copy, index: 6)
            layout (copy, index: 7)
            u7 (ref,  index: 8)
            tbl_upv_11 (copy, index: 9)
            u10 (ref,  index: 10)
            tbl_upv_2 (copy, index: 11)
            tbl_upv_38 (copy, index: 12)
            tbl_upv_14 (copy, index: 13)
            tbl_upv_13 (copy, index: 14)
            TweenService_upv_1 (copy, index: 15)
            Colors_upv_1 (copy, index: 16)
            u23 (ref,  index: 17)
            paletteOf (copy, index: 18)
            buildChest (copy, index: 19)
            setPlaying (copy, index: 20)
            tw (copy, index: 21)
            gradeIn (copy, index: 22)
            u21 (ref,  index: 23)
            RunService_upv_1 (copy, index: 24)
            onRender (copy, index: 25)
            ContextActionService_upv_1 (copy, index: 26)
            tap (copy, index: 27)
            u27 (ref,  index: 28)
            titleIn (copy, index: 29)
            phaseSummary (copy, index: 30)
            phaseLand (copy, index: 31)
            phaseIdle (copy, index: 32)
            phaseOpen (copy, index: 33)
            chestToCards (copy, index: 34)
            tbl_upv_4 (copy, index: 35)
            sleep (copy, index: 36)
            tbl_upv_3 (copy, index: 37)
            phaseCard (copy, index: 38)
        ]]
        local u31 = normReveal(a91)
        if not u31 then
            return false
        end
        local u32 = a92 or {}
        if u31.source ~= "rank" or u32.rankShown == true then
            if u9 then
                finish("interrupted", true)
            end
        else
            if not (a1.RankUp) then
                a1.EnsureScreen("RankUp")
            end
            if a1.RankUp then
                u32 = table.clone(u32)
                u32.rankShown = true
                return a1.RankUp.Play(
                    a91,
                    function(a93)
                        --[[
                          line: 2244
                          upvalues:
                            u32 (copy, index: 1)
                            a91 (copy, index: 2)
                            tbl_upv_7 (copy, index: 3)
                        ]]
                        if a93 ~= "interrupted" then
                            tbl_upv_7.Play(a91, u32)
                        elseif u32.onDone then
                            u32.onDone("interrupted", a91)
                        end
                    end
                )
            elseif u9 then
                finish("interrupted", true)
            end
        end
        build()
        layout()
        local v216
        if type(u32.pace) == "number" and (u32.pace > 0) then
            v216 = u32.pace
        else
            v216 = 1
        end
        u7 = v216
        tbl_upv_11.backPool.Pace = u7
        tbl_upv_11.frontPool.Pace = u7
        u10 = u10 + 1
        local _ = u10
        local u33 = tbl_upv_2[u31.kind] or (tbl_upv_2.drop)
        if u31.source == "rank" then
            u33 = table.clone(u33)
            u33.title = "RANK REWARD"
        end
        local v217 = 0
        for v219, value_30 in u31.stacks do
            v217 = v217 + value_30.shards
        end
        local tbl_43 = {skip = false, subtitle = 0, source = 0, phase = "start", tapped = false, summaryOnly = 0, hurry = false}
        tbl_43.token = u10
        tbl_43.reveal = u31
        tbl_43.look = u33
        tbl_43.opts = u32
        tbl_43.source = u32.source or (u31.source or "lobby")
        tbl_43.summaryOnly = u32.summaryOnly == true
        tbl_43.subtitle = string.format("%d ITEM%s  \194\183  %d SHARDS", #u31.stacks, ((#u31.stacks ~= 1) and "S") or "", v217)
        u9 = tbl_43
        for v220, value_31 in tbl_upv_38 do
            value_31:Cancel()
        end
        table.clear(tbl_upv_38)
        table.clear(tbl_upv_14)
        tbl_upv_13.y = 0
        tbl_upv_13.yaw = 0
        tbl_upv_13.roll = 0
        tbl_upv_13.pitch = 0
        tbl_upv_13.sq = 0
        tbl_upv_13.lid = 0
        tbl_upv_13.s = 1
        tbl_upv_13.raysSpin = 8
        tbl_upv_11.backPool:Clear()
        tbl_upv_11.frontPool:Clear()
        tbl_upv_11.root.Visible = true
        local dim_1 = tbl_upv_11.dim
        local tbl_44 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(dim_1, TweenInfo.new(0), tbl_44):Play()
        for key_9, value_32 in tbl_44 do
            dim_1[key_9] = value_32
        end
        local flash_1 = tbl_upv_11.flash
        local tbl_45 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(flash_1, TweenInfo.new(0), tbl_45):Play()
        for key_10, value_33 in tbl_45 do
            flash_1[key_10] = value_33
        end
        local vignette_1 = tbl_upv_11.vignette
        local tbl_46 = {ImageTransparency = 1}
        tbl_46.ImageColor3 = Colors_upv_1.Void
        TweenService_upv_1:Create(vignette_1, TweenInfo.new(0), tbl_46):Play()
        for key_11, value_34 in tbl_46 do
            vignette_1[key_11] = value_34
        end
        local skip_1 = tbl_upv_11.skip
        local tbl_47 = {BackgroundTransparency = 0.12}
        TweenService_upv_1:Create(skip_1, TweenInfo.new(0), tbl_47):Play()
        for key_12, value_35 in tbl_47 do
            skip_1[key_12] = value_35
        end
        for v221, value_36 in {tbl_upv_11.tint, tbl_upv_11.raysA, tbl_upv_11.raysB, tbl_upv_11.halo, tbl_upv_11.beam, tbl_upv_11.floorRing, tbl_upv_11.shadow, tbl_upv_11.leak, tbl_upv_11.leakFlare, tbl_upv_11.chestGlow} do
            local tbl_48 = {ImageTransparency = 1}
            TweenService_upv_1:Create(value_36, TweenInfo.new(0), tbl_48):Play()
            for key_13, value_37 in tbl_48 do
                value_36[key_13] = value_37
            end
        end
        local vpf_1 = tbl_upv_11.vpf
        local tbl_49 = {ImageTransparency = 0}
        TweenService_upv_1:Create(vpf_1, TweenInfo.new(0), tbl_49):Play()
        for key_14, value_38 in tbl_49 do
            vpf_1[key_14] = value_38
        end
        local v218 = nil
        for v222, value_39 in {tbl_upv_11.title, tbl_upv_11.titleShadow, tbl_upv_11.subtitle, tbl_upv_11.sumTotals} do
            local tbl_50 = {TextTransparency = 1}
            TweenService_upv_1:Create(value_39, TweenInfo.new(0), tbl_50):Play()
            for key_15, value_40 in tbl_50 do
                value_39[key_15] = value_40
            end
            if value_39:IsA("TextLabel") then
                v218 = value_39:FindFirstChildWhichIsA("UIStroke")
            else
                v218 = nil
            end
            if v218 then
                if type(v218:GetAttribute("Authored")) ~= "number" then
                    v218:SetAttribute("Authored", v218.Transparency)
                end
                v217 = v218
            else
                v217 = nil
            end
            if not (v217) then
                continue
            end
            local tbl_51 = {Transparency = 1}
            TweenService_upv_1:Create(v217, TweenInfo.new(0), tbl_51):Play()
            for key_16, value_41 in tbl_51 do
                v217[key_16] = value_41
            end
        end
        local raysScale_2 = tbl_upv_11.raysScale
        local tbl_52 = {Scale = 1}
        TweenService_upv_1:Create(raysScale_2, TweenInfo.new(0), tbl_52):Play()
        for key_17, value_42 in tbl_52 do
            raysScale_2[key_17] = value_42
        end
        local contScale_1 = tbl_upv_11.contScale
        local tbl_53 = {Scale = 0}
        TweenService_upv_1:Create(contScale_1, TweenInfo.new(0), tbl_53):Play()
        for key_18, value_43 in tbl_53 do
            contScale_1[key_18] = value_43
        end
        local cardScale_1 = tbl_upv_11.cardScale
        local tbl_54 = {Scale = 1.14}
        TweenService_upv_1:Create(cardScale_1, TweenInfo.new(0), tbl_54):Play()
        for key_19, value_44 in tbl_54 do
            cardScale_1[key_19] = value_44
        end
        tbl_upv_11.card.Visible = false
        tbl_upv_11.barBox.Visible = false
        tbl_upv_11.newRoot.Visible = false
        tbl_upv_11.sumRoot.Visible = false
        tbl_upv_11.prompt.Visible = false
        tbl_upv_11.counter.Visible = false
        tbl_upv_11.shaker.Position = UDim2.new()
        u23 = 0
        tbl_upv_11.chestHolder.Visible = false
        paletteOf(u33)
        buildChest(u33.model, u33.fit)
        setPlaying(true)
        tw(tbl_upv_11.dim, 0.35, {BackgroundTransparency = 0.2}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.vignette, 0.4, {ImageTransparency = 0.25}, Enum.EasingStyle.Quad)
        tw(tbl_upv_11.tint, 0.6, {ImageTransparency = 0.8}, Enum.EasingStyle.Quad)
        gradeIn(u33)
        if not (u21) then
            u21 = RunService_upv_1.RenderStepped:Connect(onRender)
        end
        tbl_upv_11.skip.Visible = not u9.summaryOnly
        tbl_upv_11.skipFill.Size = UDim2.fromScale(0, 1)
        ContextActionService_upv_1:BindActionAtPriority(
            "TR_RevealKeys",
            function(a94, a95, a96)
                --[[
                  line: 2332
                  upvalues:
                    tbl_upv_7 (copy, index: 1)
                    tap (copy, index: 2)
                ]]
                if a95 == Enum.UserInputState.Begin then
                    if a96.KeyCode == Enum.KeyCode.ButtonB or a96.KeyCode == Enum.KeyCode.ButtonY then
                        tbl_upv_7.Skip()
                    else
                        tap()
                    end
                end
                return Enum.ContextActionResult.Sink
            end,
            false,
            Enum.ContextActionPriority.High.Value + 50,
            Enum.KeyCode.Space,
            Enum.KeyCode.Return,
            Enum.KeyCode.ButtonA,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.ButtonY
        )
        u27 = function()
            --[[
              line: 2343
              upvalues:
                ContextActionService_upv_1 (copy, index: 1)
            ]]
            ContextActionService_upv_1:UnbindAction("TR_RevealKeys")
        end
        task.spawn(
            xpcall,
            function()
                --[[
                  line: 2347
                  upvalues:
                    u9 (ref,  index: 1)
                    titleIn (copy, index: 2)
                    u33 (ref,  index: 3)
                    phaseSummary (copy, index: 4)
                    u10 (copy, index: 5)
                    finish (copy, index: 6)
                    phaseLand (copy, index: 7)
                    phaseIdle (copy, index: 8)
                    phaseOpen (copy, index: 9)
                    u31 (copy, index: 10)
                    chestToCards (copy, index: 11)
                    tbl_upv_11 (copy, index: 12)
                    tbl_upv_4 (copy, index: 13)
                    sleep (copy, index: 14)
                    tbl_upv_3 (copy, index: 15)
                    phaseCard (copy, index: 16)
                ]]
                if u9 and u9.summaryOnly then
                    titleIn(u33.title, u9.subtitle)
                    u9.summaryAt = os.clock()
                    phaseSummary(u10)
                    local v219 = (u9 ~= nil) and (u9.token == u10)
                    if v219 then
                        finish("done")
                    end
                    return
                end
                local v220 = phaseLand(u10) and (phaseIdle(u10))
                if v220 then
                    v220 = phaseOpen(u10)
                end
                if v220 and #u31.stacks > 0 then
                    chestToCards()
                    local v221 = #u31.stacks
                    tbl_upv_11.counter.Visible = v221 > 0
                    tbl_upv_11.counterText.Text = "x" .. v221
                    if u9 then
                        tbl_upv_11.counter.Position = UDim2.fromOffset(128, tbl_upv_4.chestCardY - 62)
                    end
                    if sleep(u10, tbl_upv_3.toCards * 0.6, false) then
                        for key_20, value_45 in u31.stacks do
                            if not (phaseCard(u10, key_20, value_45)) then
                                break
                            end
                        end
                    end
                end
                local v222 = (u9 ~= nil) and (u9.token == u10)
                if not v222 then
                    return
                end
                local skip_2 = u9.skip
                u9.summaryAt = os.clock()
                phaseSummary(u10)
                local v223 = (u9 ~= nil) and (u9.token == u10)
                if not v223 then
                    return
                end
                finish((skip_2 and "skipped") or "done")
            end,
            function(a97)
                --[[
                  line: 2392
                  upvalues:
                    u9 (ref,  index: 1)
                    u10 (copy, index: 2)
                    finish (copy, index: 3)
                ]]
                warn("[DropReveal] " .. tostring(a97) .. "\n" .. debug.traceback())
                if not u9 or u9.token ~= u10 then
                    return
                end
                finish("interrupted", true)
            end
        )
        return true
    end
    function tbl_upv_7.ShowSummary(a98, a99)
        --[[
          name: ShowSummary
          line: 2402
          upvalues:
            tbl_upv_7 (copy, index: 1)
        ]]
        local v224 = (a99 and (table.clone(a99))) or {}
        v224.summaryOnly = true
        return tbl_upv_7.Play(a98, v224)
    end
    function tbl_upv_7.Stop(a100)
        --[[
          name: Stop
          line: 2407
          upvalues:
            u9 (ref, index: 1)
        ]]
        if not u9 then
            return
        end
        finish("interrupted", a100 ~= false)
    end
    function tbl_upv_7.IsPlaying()
        --[[
          name: IsPlaying
          line: 2412
          upvalues:
            u9 (ref, index: 1)
        ]]
        local v225 = u9 ~= nil
        return v225
    end
    function tbl_upv_7.State()
        --[[
          name: State
          line: 2415
          upvalues:
            u9 (ref, index: 1)
            u7 (ref, index: 2)
        ]]
        local tbl_55 = {pace = 0, phase = 0, kind = 0, id = 0, playing = 0}
        tbl_55.playing = u9 ~= nil
        tbl_55.phase = u9 and u9.phase or nil
        tbl_55.id = u9 and u9.reveal.id or nil
        tbl_55.kind = u9 and u9.reveal.kind or nil
        tbl_55.pace = u7
        return tbl_55
    end
    local u34 = false
    local function wire()
        --[[
          name: wire
          line: 2421
          upvalues:
            u34 (ref,  index: 1)
            u8 (ref,  index: 2)
            tbl_upv_11 (copy, index: 3)
            u9 (ref,  index: 4)
            tap (copy, index: 5)
            tbl_upv_7 (copy, index: 6)
            UI_upv_1 (copy, index: 7)
            layout (copy, index: 8)
        ]]
        if (u34) or not u8 then
            return
        end
        u34 = true
        tbl_upv_11.catcher.InputBegan:Connect(
            function(a101)
                --[[
                  line: 2430
                  upvalues:
                    u9 (ref, index: 1)
                ]]
                local UserInputType_1 = a101.UserInputType
                if (UserInputType_1 == Enum.UserInputType.MouseButton1 or UserInputType_1 == Enum.UserInputType.Touch) and (u9) then
                    u9.holdAt = os.clock()
                end
            end
        )
        tbl_upv_11.catcher.InputEnded:Connect(
            function(a102)
                --[[
                  line: 2438
                  upvalues:
                    u9 (ref,  index: 1)
                    tbl_upv_11 (copy, index: 2)
                    tap (copy, index: 3)
                ]]
                local UserInputType_2 = a102.UserInputType
                if (UserInputType_2 == Enum.UserInputType.MouseButton1 or UserInputType_2 == Enum.UserInputType.Touch) and (u9) and (u9.holdAt) then
                    u9.holdAt = nil
                    tbl_upv_11.skipFill.Size = UDim2.fromScale(0, 1)
                    tap()
                end
            end
        )
        tbl_upv_11.skip.Activated:Connect(
            function()
                --[[
                  line: 2448
                  upvalues:
                    tbl_upv_7 (copy, index: 1)
                ]]
                tbl_upv_7.Skip()
            end
        )
        tbl_upv_11.cont.Activated:Connect(
            function()
                --[[
                  line: 2451
                  upvalues:
                    u9 (ref, index: 1)
                ]]
                if not u9 or u9.phase ~= "summary" then
                    return
                end
                u9.tapped = true
            end
        )
        UI_upv_1.ScaleChanged:Connect(layout)
        UI_upv_1.TopInsetChanged:Connect(layout)
        tbl_upv_11.safe:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)
    end
    local Play_upv_2 = tbl_upv_7.Play
    tbl_upv_7.Play = function(a103, a104)
        --[[
          line: 2461
          upvalues:
            Play_upv_2 (copy, index: 1)
            wire (copy, index: 2)
        ]]
        local v230 = Play_upv_2(a103, a104)
        if v230 then
            wire()
        end
        return v230
    end
    State_upv_1.MatchEvent:Connect(
        function(a105)
            --[[
              line: 2470
              upvalues:
                u9 (ref, index: 1)
            ]]
            if a105 ~= "MatchStart" or not u9 then
                return
            end
            finish("interrupted", true)
        end
    )
    local function blocked()
        --[[
          name: blocked
          line: 2475
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v231 = true
        if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
            v231 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
        end
        return v231
    end
    task.spawn(
        function()
            --[[
              line: 2478
              upvalues:
                u9 (ref,  index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                tbl_upv_7 (copy, index: 5)
            ]]
            task.wait(0.25)
            local v232 = nil
            if u9 then
                v232 = true
                if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                    v232 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                end
                if v232 then
                    finish("interrupted", true)
                elseif u9 then
                    tbl_upv_7._SweepUi()
                end
            elseif u9 then
                tbl_upv_7._SweepUi()
            end
        end
    )
    local tbl_upv_56 = {}
    local tbl_upv_57 = {}
    local tbl_upv_58 = {}
    local tbl_upv_59 = {}
    local u35 = ((State_upv_1.GetPlayerState() ~= "Lobby") and math.huge) or (os.clock())
    local function tryAck(a106)
        --[[
          name: tryAck
          line: 2495
          upvalues:
            tbl_upv_57 (copy, index: 1)
            tbl_upv_58 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            Players_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
        ]]
        if (tbl_upv_57[a106]) or ((tbl_upv_58[a106] or 0) >= 4) or (State_upv_1.Mock) or State_upv_1.GetPlayerState() ~= "Lobby" and ((tbl_upv_58[a106] or 0) > 0) then
            return
        end
        tbl_upv_58[a106] = (tbl_upv_58[a106] or 0) + 1
        task.spawn(
            function()
                --[[
                  line: 2503
                  upvalues:
                    Players_upv_1 (copy, index: 1)
                    a1 (copy, index: 2)
                    a106 (copy, index: 3)
                    tbl_upv_57 (copy, index: 4)
                ]]
                local v233 = Players_upv_1.LocalPlayer:FindFirstChild("PlayerScripts") and (Players_upv_1.LocalPlayer.PlayerScripts:FindFirstChild("Core"))
                local v234 = v233 and (v233:FindFirstChild("InputStats"))
                if (v234) and (v234:IsA("ModuleScript")) then
                    v233 = require(v234).Take()
                else
                    v233 = 0
                end
                local v235, v236 = a1.Remotes.Invoke("ProfileAction", "AckReveal", a106, v233)
                if not v235 or v236 ~= true then
                    return
                end
                tbl_upv_57[a106] = true
            end
        )
    end
    function tbl_upv_7._Seen(a107)
        --[[
          name: _Seen
          line: 2514
          upvalues:
            tbl_upv_56 (copy, index: 1)
            tryAck (copy, index: 2)
        ]]
        tbl_upv_56[a107] = true
        tryAck(a107)
    end
    local function canPlayLobby(a108)
        --[[
          name: canPlayLobby
          line: 2518
          upvalues:
            u9 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            u35 (ref,  index: 5)
        ]]
        if not (u9) and State_upv_1.GetPlayerState() == "Lobby" then
            local v237 = true
            if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                v237 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
            end
            if not (v237) then
                if a1.RankUp and a1.RankUp.IsPlaying() or a1.LossForgiven and a1.LossForgiven.IsPlaying() or a1.IsHudHiddenFor("MatchEnd") then
                    return false
                elseif not (a108) then
                    if not (a1.MenuManager.IsOpen()) and not (os.clock() - u35 < 1.5) and LocalPlayer_upv_1.Character then
                        if State_upv_1.Get("CombatMode") ~= true then
                            return true
                        end
                        return false
                    end
                    return false
                else
                    return true
                end
            end
        end
        return false
    end
    local function pump()
        --[[
          name: pump
          line: 2541
          upvalues:
            u9 (ref,  index: 1)
            tbl_upv_59 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            tbl_upv_7 (copy, index: 6)
            canPlayLobby (copy, index: 7)
            tbl_upv_56 (copy, index: 8)
            tbl_upv_57 (copy, index: 9)
            tryAck (copy, index: 10)
        ]]
        if u9 then
            return
        end
        if #tbl_upv_59 > 0 then
            local v238
            if u9 or State_upv_1.GetPlayerState() ~= "Lobby" then
                v238 = false
            else
                local v239 = true
                if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
                    v239 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
                end
                if v239 or (a1.RankUp) and (a1.RankUp.IsPlaying()) or (a1.LossForgiven) and (a1.LossForgiven.IsPlaying()) then
                    v238 = false
                else
                    v238 = not (a1.IsHudHiddenFor("MatchEnd"))
                end
            end
            if v238 then
                tbl_upv_7.Play(table.remove(tbl_upv_59, 1), {source = "robux"})
                return
            end
        end
        if not canPlayLobby(false) then
            return
        end
        local v240 = State_upv_1.Profile and (State_upv_1.Profile.reveals)
        if type(v240) ~= "table" then
            return
        end
        for _, value_46 in v240 do
            local v241 = ((type(value_46) == "table" and value_46.id ~= nil) and (tostring(value_46.id))) or nil
            if not (v241) or tbl_upv_56[v241] then
                if not (v241) or not (tbl_upv_56[v241]) then
                    continue
                end
                if not (tbl_upv_57[v241]) then
                    tryAck(v241)
                    continue
                end
            end
            tbl_upv_7.Play(value_46, {source = "lobby"})
            return
        end
    end
    tbl_upv_7._Pump = function()
        --[[
          line: 2567
          upvalues:
            pump (copy, index: 1)
        ]]
        task.delay(0.6, pump)
    end
    function tbl_upv_7.Queue(a109)
        --[[
          name: Queue
          line: 2570
          upvalues:
            tbl_upv_59 (copy, index: 1)
            pump (copy, index: 2)
        ]]
        if type(a109) ~= "table" then
            return
        end
        table.insert(tbl_upv_59, a109)
        pump()
    end
    State_upv_1.PlayerStateChanged:Connect(
        function(a110)
            --[[
              line: 2576
              upvalues:
                u35 (ref,  index: 1)
                pump (copy, index: 2)
            ]]
            local v242 = ((a110 ~= "Lobby") and math.huge) or (os.clock())
            u35 = v242
            if a110 ~= "Lobby" then
                return
            end
            task.delay(1.6, pump)
        end
    )
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 2582
              upvalues:
                pump (copy, index: 1)
            ]]
            task.defer(pump)
        end
    )
    a1.MenuManager.Changed:Connect(
        function()
            --[[
              line: 2585
              upvalues:
                pump (copy, index: 1)
            ]]
            task.defer(pump)
        end
    )
    task.spawn(
        function()
            --[[
              line: 2588
              upvalues:
                pump (copy, index: 1)
            ]]
            while true do
                task.wait(1)
                pump()
            end
        end
    )
    local function hookEconomy()
        --[[
          name: hookEconomy
          line: 2595
          upvalues:
            a1 (copy, index: 1)
        ]]
        local Economy_3 = a1.Economy
        if not Economy_3 or not Economy_3.Event then
            return
        end
        Economy_3.Event:Connect(function() end)
    end
    local Economy_4 = a1.Economy
    if Economy_4 and Economy_4.Event then
        Economy_4.Event:Connect(
            function(a111, a112)
                --[[
                  line: 2598
                  upvalues:
                    tbl_upv_7 (copy, index: 1)
                ]]
                if a111 ~= "Drop" or type(a112) ~= "table" then
                    return
                end
                if type(a112.reveals) ~= "table" then
                    tbl_upv_7.Queue(a112)
                else
                    for _, value_47 in a112.reveals do
                        tbl_upv_7.Queue(value_47)
                    end
                end
            end
        )
    end
    local tbl_upv_60 = {}
    tbl_upv_60.drop = {kind = "drop", stacks = {{before = 4, levelBefore = 0, item = "crossbow", shards = 6}, {before = 6, levelBefore = 1, item = "bronze_sword", shards = 4}}}
    tbl_upv_60.victory = {kind = "victory", stacks = {{before = 3, levelBefore = 0, item = "spear", shards = 8}, {before = 1, levelBefore = 2, item = "short_bow", shards = 7}, {before = 1, levelBefore = 1, item = "throwing_knives", shards = 5}}}
    tbl_upv_60.golden = {kind = "golden", stacks = {{before = 26, levelBefore = 0, item = "longbow", shards = 18}, {before = 2, levelBefore = 0, item = "battle_axe", shards = 16}, {before = 0, levelBefore = 0, item = "fire_bomb", shards = 14}, {before = 3, levelBefore = 1, item = "bandage", shards = 12}}}
    tbl_upv_60.newitem = {kind = "victory", stacks = {{before = 14, levelBefore = 0, item = "crossbow", shards = 9}, {before = 2, levelBefore = 1, item = "war_club", shards = 6}, {before = 12, levelBefore = 2, item = "sling", shards = 5}}}
    tbl_upv_7.Mock = function(a113)
        --[[
          line: 2649
          upvalues:
            tbl_upv_60 (copy, index: 1)
        ]]
        local v243 = tbl_upv_60[a113 or "victory"] or (tbl_upv_60.victory)
        local v244 = table.clone(v243)
        v244.id = "mock-" .. tostring(a113 or "victory") .. "-" .. tostring(math.floor(os.clock() * 1000))
        v244.source = "match"
        v244.stacks = table.clone(v243.stacks)
        for key_21, value_48 in v244.stacks do
            local v245 = table.clone(value_48)
            v245.after = v245.before + v245.shards
            v244.stacks[key_21] = v245
        end
        return v244
    end
    a1.Debug.reveal = function(a114, a115, a116)
        --[[
          line: 2662
          upvalues:
            tbl_upv_7 (copy, index: 1)
        ]]
        local v246
        if type(a114) ~= "table" then
            local Mock_1 = tbl_upv_7.Mock
            local v247
            if type(a114) ~= "string" then
                v247 = "victory"
            else
                v247 = a114
            end
            v246 = Mock_1(v247)
        else
            v246 = a114
        end
        local v247 = ((type(a116) ~= "table") and {}) or (table.clone(a116))
        v247.pace = tonumber(a115) or 1
        v247.source = v247.source or "lobby"
        return tbl_upv_7.Play(v246, v247)
    end
    a1.Debug.revealStop = function()
        --[[
          line: 2669
          upvalues:
            tbl_upv_7 (copy, index: 1)
        ]]
        tbl_upv_7.Stop(true)
        return true
    end
    a1.Debug.revealTap = function()
        --[[
          line: 2673
          upvalues:
            tap (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
        ]]
        tap()
        return tbl_upv_7.State()
    end
    a1.Debug.revealSkip = function()
        --[[
          line: 2677
          upvalues:
            tbl_upv_7 (copy, index: 1)
        ]]
        tbl_upv_7.Skip()
        return tbl_upv_7.State()
    end
    a1.Debug.revealState = function()
        --[[
          line: 2681
          upvalues:
            tbl_upv_7 (copy, index: 1)
            tbl_upv_59 (copy, index: 2)
            tbl_upv_56 (copy, index: 3)
        ]]
        local v248 = tbl_upv_7.State()
        v248.queue = #tbl_upv_59
        local tbl_61 = {}
        for key_22 in tbl_upv_56 do
            table.insert(tbl_61, key_22)
        end
        v248.seen = tbl_61
        return v248
    end
    a1.Debug.revealSummary = function(a117)
        --[[
          line: 2691
          upvalues:
            tbl_upv_7 (copy, index: 1)
        ]]
        local v249
        if type(a117) ~= "table" then
            local Mock_2 = tbl_upv_7.Mock
            local v250
            if type(a117) ~= "string" then
                v250 = "victory"
            else
                v250 = a117
            end
            v249 = Mock_2(v250)
        else
            v249 = a117
        end
        return tbl_upv_7.ShowSummary(v249, {source = "lobby"})
    end
end
return tbl_1