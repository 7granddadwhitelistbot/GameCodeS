local MarketplaceService_upv_1 = game:GetService("MarketplaceService")
local Players_1 = game:GetService("Players")
local PolicyService_upv_1 = game:GetService("PolicyService")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local Shared_1 = ReplicatedStorage_upv_1:WaitForChild("Shared")
local Signal_1 = require(Shared_1:WaitForChild("Signal"))
local Unlocks_upv_1 = require(Shared_1:WaitForChild("Unlocks"))
local Ranks_upv_1 = require(Shared_1:WaitForChild("Ranks"))
local Products_upv_1 = require(Shared_1:WaitForChild("Products"))
local u1 = nil
local Shards_1 = Shared_1:FindFirstChild("Shards")
if Shards_1 then
    local v1 = Shards_1:IsA("ModuleScript")
    if v1 then
        local success_1, v2 = pcall(require, Shards_1)
        if (success_1) and type(v2) == "table" then
            u1 = v2
        else
            warn("[UI] Shared.Shards failed to load: " .. tostring(v2))
        end
    end
end
if not (u1) then
    local tbl_upv_1 = {}
    tbl_upv_1.small = {unlock = 10, up = {10, 20, 40, 80}}
    tbl_upv_1.medium = {unlock = 20, up = {20, 40, 80, 160}}
    tbl_upv_1.large = {unlock = 40, up = {40, 80, 160, 320}}
    tbl_upv_1.starter = {unlock = 0, up = {10, 20, 40, 80}}
    local tbl_upv_2 = {MAX_LEVEL = 5, FALLBACK = true, BONUS_PER_LEVEL = 0.02}
    function tbl_upv_2.Size(a1)
        --[[
          name: Size
          line: 101
          upvalues:
            Unlocks_upv_1 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        local success_2, v3 = pcall(Unlocks_upv_1.SizeOf, a1)
        if success_2 and type(v3) == "string" and tbl_upv_1[v3] then
            return v3
        elseif Unlocks_upv_1.IsStarter(a1) then
            return "starter"
        else
            return "medium"
        end
    end
    function tbl_upv_2.UnlockCost(a1)
        --[[
          name: UnlockCost
          line: 105
          upvalues:
            tbl_upv_1 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
        ]]
        return tbl_upv_1[tbl_upv_2.Size(a1)].unlock
    end
    function tbl_upv_2.UpgradeCost(a1, a2)
        --[[
          name: UpgradeCost
          line: 108
          upvalues:
            tbl_upv_2 (copy, index: 1)
            tbl_upv_1 (copy, index: 2)
        ]]
        if tbl_upv_2.MAX_LEVEL <= a2 then
            return nil
        end
        return tbl_upv_1[tbl_upv_2.Size(a1)].up[math.max(1, a2)]
    end
    function tbl_upv_2.Level(a1, a2)
        --[[
          name: Level
          line: 114
          upvalues:
            tbl_upv_2 (copy, index: 1)
            Unlocks_upv_1 (copy, index: 2)
        ]]
        local v4 = (type(a1) == "table") and (a1[a2])
        if type(v4) == "table" and type(v4.level) == "number" then
            return (math.clamp(math.floor(v4.level), 0, tbl_upv_2.MAX_LEVEL))
        elseif Unlocks_upv_1.IsStarter(a2) then
            return 1
        else
            return 0
        end
    end
    function tbl_upv_2.Owns(a1, a2)
        --[[
          name: Owns
          line: 121
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local v5 = tbl_upv_2.Level(a1, a2) >= 1
        return v5
    end
    function tbl_upv_2.Progress(a1, a2)
        --[[
          name: Progress
          line: 124
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local v6 = (type(a1) == "table") and (a1[a2])
        local v7
        if type(v6) == "table" and type(v6.shards) == "number" then
            v7 = v6.shards
        else
            v7 = 0
        end
        local v8 = tbl_upv_2.Level(a1, a2)
        if v8 <= 0 then
            return v7, tbl_upv_2.UnlockCost(a2), "unlock"
        end
        local v9 = tbl_upv_2.UpgradeCost(a2, v8)
        if v9 then
            return v7, v9, "upgrade"
        end
        return 0, 0, "max"
    end
    function tbl_upv_2.CanUpgrade(a1, a2)
        --[[
          name: CanUpgrade
          line: 137
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local v10, v11, v12 = tbl_upv_2.Progress(a1, a2)
        return (v12 == "upgrade") and (v11 <= v10)
    end
    function tbl_upv_2.Bonus(a1)
        --[[
          name: Bonus
          line: 141
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return 1 + (tbl_upv_2.BONUS_PER_LEVEL * (math.clamp(a1, 1, tbl_upv_2.MAX_LEVEL) - 1))
    end
    function tbl_upv_2.Odds()
        --[[
          name: Odds
          line: 144
        ]]
        return {}
    end
    u1 = tbl_upv_2
end
local tbl_upv_3 = {}
tbl_upv_3.Unlocks = Unlocks_upv_1
tbl_upv_3.Shards = u1
tbl_upv_3.ROBUX = utf8.char(57346)
tbl_upv_3.MAX_LEVEL = tonumber(u1.MAX_LEVEL) or 5
tbl_upv_3.BONUS_PER_LEVEL = tonumber(u1.BONUS_PER_LEVEL) or 0.02
tbl_upv_3.Changed = Signal_1.new()
tbl_upv_3.Event = Signal_1.new()
tbl_upv_3.Upgraded = Signal_1.new()
tbl_upv_3.Celebrate = Signal_1.new()
tbl_upv_3.CelebrationChanged = Signal_1.new()
tbl_upv_3.RevealChanged = Signal_1.new()
tbl_upv_3.ForceMock = false
tbl_upv_3.Mock = nil
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local u2 = RunService_1:IsStudio()
local fromRGB_1 = Color3.fromRGB
local tbl_upv_4 = {}
tbl_upv_4.ammo = Color3.fromRGB(240, 96, 48)
tbl_upv_4.bow = fromRGB_1(56, 189, 248)
tbl_upv_4.gun = fromRGB_1(251, 146, 60)
tbl_upv_4.melee = fromRGB_1(248, 113, 113)
tbl_upv_4.throwable = fromRGB_1(167, 139, 250)
tbl_upv_4.utility = fromRGB_1(250, 204, 21)
tbl_upv_4.healing = fromRGB_1(74, 222, 128)
tbl_upv_4.armor = fromRGB_1(148, 197, 255)
function tbl_upv_3.Init(a1)
    --[[
      name: Init
      line: 181
      upvalues:
        tbl_upv_4 (copy, index: 2)
        u1 (ref,  index: 3)
        Unlocks_upv_1 (copy, index: 4)
        Ranks_upv_1 (copy, index: 5)
        PolicyService_upv_1 (copy, index: 6)
        LocalPlayer_upv_1 (copy, index: 7)
        Workspace_upv_1 (copy, index: 8)
        ReplicatedStorage_upv_1 (copy, index: 9)
        Products_upv_1 (copy, index: 10)
        MarketplaceService_upv_1 (copy, index: 11)
        u2 (copy, index: 12)
    ]]
    local State_upv_1 = a1.State
    local WeaponInfo_upv_1 = a1.WeaponInfo
    a1.Economy = items
    local function profile()
        --[[
          name: profile
          line: 186
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        return State_upv_1.Profile
    end
    function items.CategoryColor(a2)
        --[[
          name: CategoryColor
          line: 190
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
            tbl_upv_4 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        local v13 = WeaponInfo_upv_1.Get(a2)
        return (v13 and (tbl_upv_4[v13.category])) or (a1.Theme.Colors.Accent)
    end
    local tbl_upv_5 = nil
    local u3 = nil
    local function items()
        --[[
          name: items
          line: 200
          upvalues:
            State_upv_1 (copy, index: 2)
            u3 (ref,  index: 3)
            tbl_upv_5 (ref,  index: 4)
        ]]
        local Mock_1 = tbl_upv_3.Mock
        if Mock_1 then
            return Mock_1.items
        end
        local Profile_1 = State_upv_1.Profile
        if type(Profile_1.items) == "table" then
            return Profile_1.items
        end
        local owned_1 = Profile_1.owned
        if type(owned_1) == "table" then
            if u3 ~= owned_1 then
                u3 = owned_1
                tbl_upv_5 = {}
                for key_1, value_1 in owned_1 do
                    if value_1 ~= true then
                        continue
                    end
                    if type(key_1) == "string" then
                        tbl_upv_5[key_1] = {level = 1, shards = 0}
                    end
                end
            end
            return tbl_upv_5
        end
        return {}
    end
    items.Items = items
    function items.HasData()
        --[[
          name: HasData
          line: 226
          upvalues:
            State_upv_1 (copy, index: 2)
        ]]
        if tbl_upv_3.Mock then
            return true
        end
        local Profile_2 = State_upv_1.Profile
        local HasProfile_1 = State_upv_1.HasProfile
        local v14
        if HasProfile_1 then
            v14 = true
            if type(Profile_2.items) ~= "table" then
                v14 = type(Profile_2.owned) == "table"
            end
        else
            v14 = HasProfile_1
        end
        return v14
    end
    function items.Level(a3)
        --[[
          name: Level
          line: 233
          upvalues:
            u1 (ref,  index: 1)
            items (copy, index: 2)
            items (copy, index: 3)
            State_upv_1 (copy, index: 4)
            Unlocks_upv_1 (copy, index: 5)
        ]]
        if type(a3) ~= "string" then
            return 0
        end
        local success_3, v15 = pcall(u1.Level, items(), a3)
        if not (success_3) or type(v15) ~= "number" then
            v15 = 0
        end
        if v15 <= 0 then
            local v16 = nil
            if not (tbl_upv_3.Mock) then
                v16 = State_upv_1.Profile.owned
                if type(v16) == "table" and v16[a3] == true then
                    v15 = 1
                else
                    v15 = (Unlocks_upv_1.IsStarter(a3) and 1) or v15
                end
            end
        end
        return (math.clamp(math.floor(v15), 0, tbl_upv_3.MAX_LEVEL))
    end
    function items.Owns(a4)
        --[[
          name: Owns
          line: 250
        ]]
        local v17 = tbl_upv_3.Level(a4) >= 1
        return v17
    end
    WeaponInfo_upv_1.OwnsAmmo = function(a5)
        --[[
          line: 254
        ]]
        return tbl_upv_3.Owns(a5)
    end
    function items.MaxLevel(a6)
        --[[
          name: MaxLevel
          line: 257
          upvalues:
            u1 (ref, index: 1)
        ]]
        if type(u1.MaxLevel) == "function" and type(a6) == "string" then
            local success_4, v18 = pcall(u1.MaxLevel, a6)
            if success_4 and type(v18) == "number" then
                return (math.clamp(math.floor(v18), 1, tbl_upv_3.MAX_LEVEL))
            end
        end
        return tbl_upv_3.MAX_LEVEL
    end
    function items.IsLocked(a7)
        --[[
          name: IsLocked
          line: 266
        ]]
        local v19 = (type(a7) == "string") and (not tbl_upv_3.Owns(a7))
        return v19
    end
    function items.RankBest()
        --[[
          name: RankBest
          line: 269
          upvalues:
            State_upv_1 (copy, index: 1)
            Ranks_upv_1 (copy, index: 2)
        ]]
        local Profile_3 = State_upv_1.Profile
        return (math.max(tonumber(Profile_3.rankBest) or 1, Ranks_upv_1.RankOf(tonumber(Profile_3.trophies) or 0)))
    end
    function items.ItemRank(a8)
        --[[
          name: ItemRank
          line: 273
          upvalues:
            Ranks_upv_1 (copy, index: 1)
        ]]
        return Ranks_upv_1.ItemRank(a8)
    end
    function items.RankAllows(a9)
        --[[
          name: RankAllows
          line: 276
          upvalues:
            Unlocks_upv_1 (copy, index: 1)
            Ranks_upv_1 (copy, index: 3)
        ]]
        if type(a9) ~= "string" then
            return false
        end
        local v20 = true
        if Unlocks_upv_1.EVERYTHING_OWNED ~= true then
            v20 = tbl_upv_3.Owns(a9) or (Ranks_upv_1.Allows(tbl_upv_3.RankBest(), a9))
        end
        return v20
    end
    function items.Progress(a10)
        --[[
          name: Progress
          line: 282
          upvalues:
            items (copy, index: 1)
            u1 (ref,  index: 2)
            items (copy, index: 3)
        ]]
        local v21 = tbl_upv_3.Level(a10)
        local success_5, v22, _, v26 = pcall(u1.Progress, items(), a10)
        if not (success_5) or type(v22) ~= "number" then
            v22 = 0
            _ = 0
            v26 = ((tbl_upv_3.MAX_LEVEL <= v21) and "max") or "unlock"
        end
        if v21 >= 1 then
            local v25 = nil
            if v26 ~= "unlock" then
                v26 = ((tbl_upv_3.MaxLevel(a10) <= v21) and "max") or v26
            else
                v25 = u1.UpgradeCost(a10, v21)
                if v25 then
                    _, v26 = v25, "upgrade"
                else
                    v22, _, v26 = 0, 0, "max"
                end
            end
        else
            v26 = ((tbl_upv_3.MaxLevel(a10) <= v21) and "max") or v26
        end
        return math.max(0, math.floor(v22)), math.max(0, math.floor(_ or 0)), v26
    end
    function items.CanUpgrade(a11)
        --[[
          name: CanUpgrade
          line: 301
        ]]
        if type(a11) ~= "string" then
            return false
        end
        local v26, v27, v28 = tbl_upv_3.Progress(a11)
        return (v28 == "upgrade") and ((v27 > 0) and (v27 <= v26))
    end
    function items.ReadyList()
        --[[
          name: ReadyList
          line: 308
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local tbl_6 = {}
        for _, value_2 in WeaponInfo_upv_1.AllItems() do
            if tbl_upv_3.CanUpgrade(value_2.id) then
                table.insert(tbl_6, value_2.id)
            end
        end
        return tbl_6
    end
    function items.UpgradesReady()
        --[[
          name: UpgradesReady
          line: 317
        ]]
        return #tbl_upv_3.ReadyList()
    end
    function items.Bonus(a12)
        --[[
          name: Bonus
          line: 320
          upvalues:
            u1 (ref, index: 1)
        ]]
        local success_6, v29 = pcall(u1.Bonus, a12)
        if success_6 and type(v29) == "number" then
            return v29
        end
        return 1 + (tbl_upv_3.BONUS_PER_LEVEL * (math.clamp(a12, 1, tbl_upv_3.MAX_LEVEL) - 1))
    end
    function items.BonusPercent(a13)
        --[[
          name: BonusPercent
          line: 327
        ]]
        if a13 <= 1 then
            return 0
        end
        return (math.floor(((tbl_upv_3.Bonus(a13) - 1) * 100) + 0.5))
    end
    function items.MaxBonusPercent()
        --[[
          name: MaxBonusPercent
          line: 333
        ]]
        return tbl_upv_3.BonusPercent(tbl_upv_3.MAX_LEVEL)
    end
    function items.StatWord(a14)
        --[[
          name: StatWord
          line: 336
          upvalues:
            u1 (ref,  index: 1)
            WeaponInfo_upv_1 (copy, index: 2)
        ]]
        if type(u1.Stat) == "function" then
            local v30 = nil
            if type(a14) == "string" then
                local success_7, v30 = pcall(u1.Stat, a14)
                if success_7 then
                    if type(v30) ~= "string" and v30 ~= false then
                        local v31 = WeaponInfo_upv_1.Get(a14)
                        if v31 and v31.category == "armor" then
                            return "armor"
                        elseif v31 and v31.category == "healing" then
                            return "healing"
                        else
                            return "damage"
                        end
                    end
                    return v30
                end
            end
        end
        local v31 = WeaponInfo_upv_1.Get(a14)
        if v31 and v31.category == "armor" then
            return "armor"
        elseif v31 and v31.category == "healing" then
            return "healing"
        else
            return "damage"
        end
    end
    function items.BonusText(a15, a16)
        --[[
          name: BonusText
          line: 351
          upvalues:
            u1 (ref, index: 1)
        ]]
        local v32 = nil
        if type(u1.BonusText) == "function" then
            local success_8, v32 = pcall(u1.BonusText, a15, a16)
            if success_8 and type(v32) == "string" then
                return v32
            end
        end
        local v33 = tbl_upv_3.StatWord(a15)
        if v33 then
            return (string.format("+%d%% %s", tbl_upv_3.BonusPercent(a16), v33))
        end
        return ""
    end
    function items.Reveals()
        --[[
          name: Reveals
          line: 362
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local reveals_1 = State_upv_1.Profile.reveals
        if type(reveals_1) ~= "table" then
            return {}
        end
        return reveals_1
    end
    local u4 = nil
    local function noteDrop(a17)
        --[[
          name: noteDrop
          line: 369
          upvalues:
            u4 (ref, index: 1)
        ]]
        if type(a17) ~= "table" or type(a17.stacks) ~= "table" then
            return
        end
        local v34 = nil
        for _, value_3 in a17.stacks do
            if type(value_3) ~= "table" or type(value_3.item) ~= "string" then
                continue
            end
            if value_3.unlocked ~= true then
                v34 = v34 or value_3.item
                continue
            else
                v34 = value_3.item
                break
            end
        end
        if v34 then
            u4 = v34
        end
    end
    function items.LastFound()
        --[[
          name: LastFound
          line: 388
          upvalues:
            u4 (ref,  index: 1)
            noteDrop (copy, index: 3)
        ]]
        if u4 then
            return u4
        end
        local v36 = tbl_upv_3.Reveals()
        local v37 = v36[#v36]
        if type(v37) == "table" then
            noteDrop(v37)
        end
        return u4
    end
    function items.Spotlight()
        --[[
          name: Spotlight
          line: 401
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local v38 = WeaponInfo_upv_1.AllItems()
        local v39 = nil
        local v40 = -1
        local v41 = math.huge
        local v42 = false
        v39, v42 = v39, v42
        for _, value_4 in v38 do
            local v43 = tbl_upv_3.IsLocked(value_4.id)
            if not (v43) then
                continue
            end
            local v44 = tbl_upv_3.RankAllows(value_4.id)
            if not (v44) then
                continue
            end
            local v45 = true
            local v46, v47 = tbl_upv_3.Progress(value_4.id)
            local v48 = v46 / math.max(v47, 1)
            if not (v46 > 0) then
                v42 = v45
                continue
            end
            if v40 < v48 then
                v40, v41, v39, v42 = v48, v47, value_4.id, v45
                continue
            end
            if v48 ~= v40 then
                v42 = v45
                continue
            end
            if v47 < v41 then
                v40, v41, v39, v42 = v48, v47, value_4.id, v45
            else
                v42 = v45
            end
        end
        if v39 then
            return v39, "unlock"
        end
        local v49 = tbl_upv_3.LastFound()
        if v49 and WeaponInfo_upv_1.Get(v49) and tbl_upv_3.RankAllows(v49) and (tbl_upv_3.IsLocked(v49) or tbl_upv_3.Progress(v49) > 0) then
            if tbl_upv_3.IsLocked(v49) then
                return v49, "unlock"
            end
            return v49, "found"
        end
        local v50 = nil
        if v42 then
            local v51 = nil
            local v52 = math.huge
            for _, value_5 in v38 do
                local v53 = tbl_upv_3.IsLocked(value_5.id)
                if not (v53) then
                    continue
                end
                local v54 = tbl_upv_3.RankAllows(value_5.id)
                if not (v54) then
                    continue
                end
                local v61, v55 = tbl_upv_3.Progress(value_5.id)
                if v55 < v52 then
                    v52, v51 = v55, value_5.id
                end
            end
            return v51, "unlock"
        else
            v50 = tbl_upv_3.ReadyList()
            if v50[1] then
                return v50[1], "ready"
            end
            local v56 = nil
            local v57 = -1
            for _, value_6 in v38 do
                local v58, v59, v60 = tbl_upv_3.Progress(value_6.id)
                if v60 ~= "upgrade" then
                    continue
                end
                if v57 < v58 / math.max(v59, 1) then
                    local id_1 = value_6.id
                    v57, v56 = v58 / math.max(v59, 1), id_1
                end
            end
            if v56 then
                return v39, "upgrade"
            end
            return v39, "max"
        end
    end
    local u5 = nil
    task.spawn(
        function()
            --[[
              line: 454
              upvalues:
                PolicyService_upv_1 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                u5 (ref,  index: 3)
            ]]
            local success_9, v61 = pcall(
                function()
                    --[[
                      line: 455
                      upvalues:
                        PolicyService_upv_1 (copy, index: 1)
                        LocalPlayer_upv_1 (copy, index: 2)
                    ]]
                    return PolicyService_upv_1:GetPolicyInfoForPlayerAsync(LocalPlayer_upv_1)
                end
            )
            if success_9 and type(v61) == "table" and type(v61.ArePaidRandomItemsRestricted) == "boolean" then
                u5 = v61.ArePaidRandomItemsRestricted
            else
                u5 = true
            end
            tbl_upv_3.Changed:Fire()
        end
    )
    local function payloadAllowed()
        --[[
          name: payloadAllowed
          line: 465
          upvalues:
            State_upv_1 (copy, index: 1)
        ]]
        local canBuyDrops_1 = State_upv_1.Profile.canBuyDrops
        if type(canBuyDrops_1) ~= "boolean" then
            return nil
        end
        return canBuyDrops_1
    end
    function items.DropsAllowed()
        --[[
          name: DropsAllowed
          line: 469
          upvalues:
            State_upv_1 (copy, index: 2)
            u5 (ref,  index: 3)
        ]]
        local v62 = tbl_upv_3.Mock
        if v62 and v62.restricted ~= nil then
            return v62.restricted ~= true
        end
        local canBuyDrops_2 = State_upv_1.Profile.canBuyDrops
        if type(canBuyDrops_2) ~= "boolean" then
            v62 = nil
        else
            v62 = canBuyDrops_2
        end
        if v62 ~= nil then
            return v62
        end
        local v63 = u5 == false
        return v63
    end
    function items.Odds(a18)
        --[[
          name: Odds
          line: 480
          upvalues:
            u1 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            items (copy, index: 3)
            items (copy, index: 4)
        ]]
        if type(u1.Odds) == "function" then
            local v64 = {}
            v64.loadout = State_upv_1.Loadout()
            if type(u1.Context) == "function" and not (tbl_upv_3.Mock) then
                local success_10, v65 = pcall(u1.Context, State_upv_1.Profile)
                if success_10 and type(v65) == "table" then
                    v64 = v65
                end
            end
            local success_11, v66 = pcall(u1.Odds, items(), a18 or "golden", v64)
            if success_11 and type(v66) == "table" then
                return v66
            end
        end
        return {}
    end
    local function serverNow()
        --[[
          name: serverNow
          line: 498
          upvalues:
            Workspace_upv_1 (copy, index: 1)
        ]]
        return Workspace_upv_1:GetServerTimeNow()
    end
    function items.GoldenOffer()
        --[[
          name: GoldenOffer
          line: 501
          upvalues:
            State_upv_1 (copy, index: 1)
            Workspace_upv_1 (copy, index: 3)
        ]]
        local goldenOffer_1 = State_upv_1.Profile.goldenOffer
        if type(goldenOffer_1) == "table" and tbl_upv_3.DropsAllowed() then
            if goldenOffer_1.state ~= "active" then
                if goldenOffer_1.state ~= "ready" then
                    return false
                end
                return goldenOffer_1
            elseif type(goldenOffer_1.endsAt) == "number" and Workspace_upv_1:GetServerTimeNow() < goldenOffer_1.endsAt then
                return goldenOffer_1
            else
                return false
            end
        end
        return false
    end
    function items.OfferLeft()
        --[[
          name: OfferLeft
          line: 511
          upvalues:
            Workspace_upv_1 (copy, index: 2)
        ]]
        local v67 = tbl_upv_3.GoldenOffer()
        if v67 and v67.state == "active" then
            return (math.max(0, v67.endsAt - Workspace_upv_1:GetServerTimeNow()))
        end
        return nil
    end
    function items.OfferDiscount()
        --[[
          name: OfferDiscount
          line: 515
          upvalues:
            Unlocks_upv_1 (copy, index: 2)
        ]]
        local v68 = tbl_upv_3.GoldenOffer()
        local v69 = (v68 and (v68.key)) or (Unlocks_upv_1.FIRST_DROP.key)
        local v70 = tbl_upv_3.Price("drop_golden")
        local v71 = tbl_upv_3.Price(v69)
        if v70 and v71 and not (v70 <= 0) and not (v70 <= v71) then
            return (math.floor(((1 - (v71 / v70)) * 100) + 0.5))
        end
        return nil
    end
    local u6 = -math.huge
    function items.OfferSeen()
        --[[
          name: OfferSeen
          line: 525
          upvalues:
            u6 (ref,  index: 2)
            ReplicatedStorage_upv_1 (copy, index: 3)
        ]]
        local v72 = tbl_upv_3.GoldenOffer()
        if not v72 or v72.state ~= "ready" or (os.clock() - u6 < 5) then
            return
        end
        u6 = os.clock()
        task.spawn(
            function()
                --[[
                  line: 531
                  upvalues:
                    ReplicatedStorage_upv_1 (copy, index: 1)
                ]]
                local v73 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 30)
                local u7 = v73 and (v73:WaitForChild("StoreAction", 30))
                if not u7 or not u7:IsA("RemoteFunction") then
                    return
                end
                pcall(
                    function()
                        --[[
                          line: 535
                          upvalues:
                            u7 (copy, index: 1)
                        ]]
                        return u7:InvokeServer("OfferSeen")
                    end
                )
            end
        )
    end
    function items.FormatLeft(a19)
        --[[
          name: FormatLeft
          line: 541
        ]]
        local v74 = math.max(0, math.floor(a19))
        local v75 = math.floor(v74 / 3600)
        local v76 = math.floor((v74 % 3600) / 60)
        local v77 = v74 % 60
        if v75 > 0 then
            return (string.format("%d:%02d:%02d", v75, v76, v77))
        end
        return (string.format("%d:%02d", v76, v77))
    end
    function items.DropKey(a20)
        --[[
          name: DropKey
          line: 547
        ]]
        local v78 = nil
        if a20 < 5 then
            v78 = tbl_upv_3.GoldenOffer()
            if v78 and v78.state == "active" then
                return v78.key
            end
        end
        if a20 >= 5 then
            return "drop_golden5"
        end
        return "drop_golden"
    end
    function items.DropInfo(a21)
        --[[
          name: DropInfo
          line: 557
          upvalues:
            u1 (ref, index: 1)
        ]]
        local DROPS_1 = u1.DROPS
        local v79 = a21 or "golden"
        local v80
        if type(DROPS_1) ~= "table" then
            v80 = nil
        else
            v80 = type(DROPS_1.kinds) == "table" and (DROPS_1.kinds[v79]) or DROPS_1[v79] or nil
        end
        if type(v80) ~= "table" then
            return {}
        end
        return v80
    end
    local tbl_upv_7 = {}
    local tbl_upv_8 = {}
    local tbl_upv_9 = {2, 5, 15, 30}
    items.ProductId = function(a22)
        --[[
          name: productId
          line: 572
          upvalues:
            Products_upv_1 (copy, index: 1)
        ]]
        local v81 = Products_upv_1.ids[a22]
        if type(v81) ~= "number" then
            return 0
        end
        return v81
    end
    local function fetch(a23)
        --[[
          name: fetch
          line: 577
          upvalues:
            Products_upv_1 (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
            tbl_upv_8 (copy, index: 3)
        ]]
        local v82 = Products_upv_1.ids[a23]
        local v83
        if type(v82) ~= "number" then
            v83 = 0
        else
            v83 = v82
        end
        if (v83 <= 0) or (tbl_upv_7[a23]) or (tbl_upv_8[a23]) then
            return
        end
        tbl_upv_8[a23] = true
        task.spawn(function() end)
    end
    function items.Price(a24)
        --[[
          name: Price
          line: 603
          upvalues:
            tbl_upv_7 (copy, index: 1)
            Products_upv_1 (copy, index: 2)
            tbl_upv_8 (copy, index: 3)
        ]]
        local v84 = tbl_upv_7[a24]
        if v84 then
            return v84
        end
        local v85 = Products_upv_1.ids[a24]
        if type(v85) ~= "number" then
            v84 = 0
        else
            v84 = v85
        end
        if not (v84 <= 0) and not (tbl_upv_7[a24]) and not (tbl_upv_8[a24]) then
            tbl_upv_8[a24] = true
            task.spawn(function() end)
        end
        return nil
    end
    function items.PriceAmount(a25)
        --[[
          name: PriceAmount
          line: 611
        ]]
        local v86 = tbl_upv_3.Price(a25)
        if v86 then
            return (tostring(v86))
        end
        return "\226\128\166"
    end
    function items.PriceText(a26)
        --[[
          name: PriceText
          line: 615
        ]]
        return tbl_upv_3.ROBUX .. " " .. tbl_upv_3.PriceAmount(a26)
    end
    function items.ItemKey(a27)
        --[[
          name: ItemKey
          line: 618
        ]]
        return "unlock_" .. a27
    end
    function items.CanBuy(a28)
        --[[
          name: CanBuy
          line: 622
          upvalues:
            Products_upv_1 (copy, index: 1)
            u2 (copy, index: 2)
        ]]
        local v87 = true
        local v88 = Products_upv_1.ids[a28]
        local v89
        if type(v88) ~= "number" then
            v89 = 0
        else
            v89 = v88
        end
        if not (v89 > 0) then
            v87 = u2
        end
        return v87
    end
    task.delay(
        3,
        function()
            --[[
              line: 626
              upvalues:
                Products_upv_1 (copy, index: 1)
                tbl_upv_7 (copy, index: 2)
                tbl_upv_8 (copy, index: 3)
                tbl_upv_9 (copy, index: 4)
                MarketplaceService_upv_1 (copy, index: 5)
            ]]
            local u8 = nil
            for key_upv_2 in Products_upv_1.ids do
                local v90 = Products_upv_1.ids[key_upv_2]
                if type(v90) ~= "number" then
                    u8 = 0
                else
                    u8 = v90
                end
                if u8 <= 0 or tbl_upv_7[key_upv_2] then
                    continue
                end
                if not (tbl_upv_8[key_upv_2]) then
                    tbl_upv_8[key_upv_2] = true
                    task.spawn(
                        function()
                            --[[
                              line: 583
                              upvalues:
                                tbl_upv_9 (copy, index: 1)
                                MarketplaceService_upv_1 (copy, index: 2)
                                u8 (copy, index: 3)
                                tbl_upv_7 (copy, index: 4)
                                key_upv_2 (copy, index: 5)
                                tbl_upv_8 (copy, index: 6)
                                tbl_upv_3 (copy, index: 7)
                            ]]
                            local v91 = nil
                            for n_1 = 1, #tbl_upv_9 + 1 do
                                local success_12, v91 = pcall(
                                    function()
                                        --[[
                                          line: 585
                                          upvalues:
                                            MarketplaceService_upv_1 (copy, index: 1)
                                            u8 (copy, index: 2)
                                        ]]
                                        return MarketplaceService_upv_1:GetProductInfo(u8, Enum.InfoType.Product)
                                    end
                                )
                                if not (success_12) or type(v91) ~= "table" or type(v91.PriceInRobux) ~= "number" then
                                    local v92 = tbl_upv_9[n_1]
                                    if v92 then
                                        task.wait(v92)
                                        continue
                                    else
                                        break
                                    end
                                end
                                tbl_upv_7[key_upv_2] = v91.PriceInRobux
                                tbl_upv_8[key_upv_2] = nil
                                tbl_upv_3.Changed:Fire()
                                return
                            end
                            tbl_upv_8[key_upv_2] = nil
                        end
                    )
                end
            end
        end
    )
    local tbl_upv_10 = {}
    function items.Pending(a29)
        --[[
          name: Pending
          line: 634
          upvalues:
            tbl_upv_10 (copy, index: 1)
        ]]
        if a29 then
            return tbl_upv_10[a29] ~= nil
        end
        local v93 = next(tbl_upv_10) ~= nil
        return v93
    end
    local function setPending(a30, a31)
        --[[
          name: setPending
          line: 640
          upvalues:
            tbl_upv_10 (copy, index: 1)
        ]]
        local v94
        if a31 then
            v94 = os.clock()
        else
            v94 = nil
        end
        tbl_upv_10[a30] = v94
        tbl_upv_3.Changed:Fire()
    end
    local u9 = nil
    task.spawn(
        function()
            --[[
              line: 645
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
                u9 (ref,  index: 2)
            ]]
            local v95 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 30)
            local v96 = v95 and (v95:WaitForChild("StoreAction", 30))
            if not v96 or not v96:IsA("RemoteFunction") then
                return
            end
            u9 = v96
        end
    )
    function items.Buy(a32)
        --[[
          name: Buy
          line: 653
          upvalues:
            tbl_upv_10 (copy, index: 1)
            Products_upv_1 (copy, index: 3)
            u2 (copy, index: 4)
            u9 (ref,  index: 5)
            a1 (copy, index: 6)
            MarketplaceService_upv_1 (copy, index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
        ]]
        if tbl_upv_10[a32] or string.sub(a32, 1, 5) == "drop_" and not (tbl_upv_3.DropsAllowed()) then
            return false
        end
        local v97 = Products_upv_1.ids[a32]
        local u10
        if type(v97) ~= "number" then
            u10 = 0
        else
            u10 = v97
        end
        if u2 then
            if u10 ~= 0 and game.GameId == Products_upv_1.universe and not (tbl_upv_3.ForceMock) then
                if u10 ~= 0 then
                    tbl_upv_10[a32] = os.clock()
                    tbl_upv_3.Changed:Fire()
                    local success_13, v98 = pcall(
                        function()
                            --[[
                              line: 686
                              upvalues:
                                MarketplaceService_upv_1 (copy, index: 1)
                                LocalPlayer_upv_1 (copy, index: 2)
                                u10 (copy, index: 3)
                            ]]
                            MarketplaceService_upv_1:PromptProductPurchase(LocalPlayer_upv_1, u10)
                        end
                    )
                    if success_13 then
                        return true
                    end
                    tbl_upv_10[a32] = nil
                    tbl_upv_3.Changed:Fire()
                    a1.Toast("Couldn't open the purchase: " .. tostring(v98), "error")
                else
                    a1.Toast("Not available yet", "warning")
                end
                return false
            end
            local u11 = u9
            if u11 then
                tbl_upv_10[a32] = os.clock()
                tbl_upv_3.Changed:Fire()
                task.spawn(
                    function()
                        --[[
                          line: 670
                          upvalues:
                            u11 (copy, index: 1)
                            a32 (copy, index: 2)
                            tbl_upv_10 (copy, index: 3)
                            tbl_upv_3 (copy, index: 4)
                            a1 (copy, index: 5)
                        ]]
                        local success_14, v99, v100 = pcall(
                            function()
                                --[[
                                  line: 671
                                  upvalues:
                                    u11 (copy, index: 1)
                                    a32 (copy, index: 2)
                                ]]
                                return u11:InvokeServer("Mock", a32)
                            end
                        )
                        tbl_upv_10[a32] = nil
                        tbl_upv_3.Changed:Fire()
                        if (success_14) and (v99) then
                            return
                        end
                        a1.Toast("(Studio) mock purchase failed: " .. tostring(v100 or v99), "error")
                    end
                )
                return true
            end
            a1.Toast("Store not ready yet", "error")
            return false
        end
        if u10 ~= 0 then
            tbl_upv_10[a32] = os.clock()
            tbl_upv_3.Changed:Fire()
            local success_13, v98 = pcall(
                function()
                    --[[
                      line: 686
                      upvalues:
                        MarketplaceService_upv_1 (copy, index: 1)
                        LocalPlayer_upv_1 (copy, index: 2)
                        u10 (copy, index: 3)
                    ]]
                    MarketplaceService_upv_1:PromptProductPurchase(LocalPlayer_upv_1, u10)
                end
            )
            if success_13 then
                return true
            end
            tbl_upv_10[a32] = nil
            tbl_upv_3.Changed:Fire()
            a1.Toast("Couldn't open the purchase: " .. tostring(v98), "error")
        else
            a1.Toast("Not available yet", "warning")
        end
        return false
    end
    MarketplaceService_upv_1.PromptProductPurchaseFinished:Connect(
        function(a33, a34, a35)
            --[[
              line: 696
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                tbl_upv_10 (copy, index: 2)
                Products_upv_1 (copy, index: 3)
                a1 (copy, index: 5)
            ]]
            if a33 == LocalPlayer_upv_1.UserId then
                local v101 = nil
                for key_upv_3 in tbl_upv_10 do
                    local v102 = Products_upv_1.ids[key_upv_3]
                    if type(v102) ~= "number" then
                        v101 = 0
                    else
                        v101 = v102
                    end
                    if v101 ~= a34 then
                        continue
                    end
                    if a35 then
                        task.delay(
                            20,
                            function()
                                --[[
                                  line: 704
                                  upvalues:
                                    tbl_upv_10 (copy, index: 1)
                                    key_upv_3 (copy, index: 2)
                                    tbl_upv_3 (copy, index: 3)
                                    a1 (copy, index: 4)
                                ]]
                                if not tbl_upv_10[key_upv_3] then
                                    return
                                end
                                tbl_upv_10[key_upv_3] = nil
                                tbl_upv_3.Changed:Fire()
                                a1.Toast("Your purchase is still processing: it will arrive shortly", "info")
                            end
                        )
                    else
                        tbl_upv_10[key_upv_3] = nil
                        tbl_upv_3.Changed:Fire()
                    end
                end
            end
        end
    )
    local function clearPendingFor(a36)
        --[[
          name: clearPendingFor
          line: 717
          upvalues:
            tbl_upv_10 (copy, index: 1)
        ]]
        for key_4 in tbl_upv_10 do
            if string.sub(key_4, 1, #a36) == a36 then
                tbl_upv_10[key_4] = nil
                tbl_upv_3.Changed:Fire()
            end
        end
    end
    task.spawn(
        function()
            --[[
              line: 724
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
                tbl_upv_10 (copy, index: 2)
                noteDrop (copy, index: 4)
            ]]
            local v103 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 30)
            local v104 = v103 and (v103:WaitForChild("EconomyEvent", 30))
            if not v104 or not v104:IsA("RemoteEvent") then
                return
            end
            v104.OnClientEvent:Connect(
                function(a37, a38)
                    --[[
                      line: 730
                      upvalues:
                        tbl_upv_10 (copy, index: 1)
                        tbl_upv_3 (copy, index: 2)
                        noteDrop (copy, index: 3)
                    ]]
                    if type(a37) ~= "string" then
                        return
                    end
                    if type(a38) ~= "table" then
                        local tbl_11 = {}
                        a38 = tbl_11
                    end
                    if a37 == "Unlocked" or a37 == "Credit" then
                        for key_5 in tbl_upv_10 do
                            if string.sub(key_5, 1, 7) == "unlock_" then
                                tbl_upv_10[key_5] = nil
                                tbl_upv_3.Changed:Fire()
                            end
                        end
                    elseif a37 == "Drop" then
                        for key_6 in tbl_upv_10 do
                            if string.sub(key_6, 1, 5) == "drop_" then
                                tbl_upv_10[key_6] = nil
                                tbl_upv_3.Changed:Fire()
                            end
                        end
                        noteDrop(a38)
                    elseif a37 == "StreakRestored" or a37 == "StreakCredit" then
                        for key_7 in tbl_upv_10 do
                            if string.sub(key_7, 1, 7) == "streak_" then
                                tbl_upv_10[key_7] = nil
                                tbl_upv_3.Changed:Fire()
                            end
                        end
                    elseif a37 == "TribePass" then
                        for key_8 in tbl_upv_10 do
                            if string.sub(key_8, 1, 6) == "tribe_" then
                                tbl_upv_10[key_8] = nil
                                tbl_upv_3.Changed:Fire()
                            end
                        end
                    end
                    tbl_upv_3.Event:Fire(a37, a38)
                    if a37 == "Unlocked" and type(a38.item) == "string" then
                        tbl_upv_3.Celebrate:Fire(a38.item)
                    end
                    tbl_upv_3.Changed:Fire()
                end
            )
        end
    )
    State_upv_1.MatchEvent:Connect(
        function(a39, a40)
            --[[
              line: 753
              upvalues:
                noteDrop (copy, index: 1)
            ]]
            if a39 ~= "MatchEnd" or type(a40) ~= "table" or type(a40.you) ~= "table" then
                return
            end
            noteDrop(a40.you.drop)
        end
    )
    local tbl_upv_12 = {}
    function items.Upgrading(a41)
        --[[
          name: Upgrading
          line: 761
          upvalues:
            tbl_upv_12 (copy, index: 1)
        ]]
        return tbl_upv_12[a41] == true
    end
    function items.Upgrade(a42, a43, a44)
        --[[
          name: Upgrade
          line: 764
          upvalues:
            tbl_upv_12 (copy, index: 1)
            items (copy, index: 2)
            State_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            items (copy, index: 5)
        ]]
        if not (tbl_upv_12[a42]) and tbl_upv_3.CanUpgrade(a42) then
            local v105 = tbl_upv_3.Level(a42)
            local v106, v107 = tbl_upv_3.Progress(a42)
            tbl_upv_12[a42] = true
            tbl_upv_3.Changed:Fire()
            local v108 = false
            local v109 = nil
            local v115 = nil
            if tbl_upv_3.Mock or State_upv_1.Mock then
                v108, v109 = true, v105 + 1
            else
                local v110, v112, v113
                v110, v115, v112, v113 = a1.Remotes.Invoke("ProfileAction", "Upgrade", a42, a43, a44)
                if v110 then
                    if v115 == true or type(v115) == "number" then
                        local v114 = true
                        if type(v115) == "number" then
                            v108, v109 = v114, v115
                        elseif type(v112) == "number" then
                            v108, v109 = v114, v112
                        elseif type(v113) ~= "number" then
                            v108, v109 = v114, v105 + 1
                        else
                            v108, v109 = v114, v113
                        end
                    else
                        a1.Toast(tostring(v112 or "Couldn't upgrade that"), "error")
                    end
                else
                    a1.Toast(tostring(v115 or "Server unavailable"), "error")
                end
                if v108 then
                    task.delay(0.6, State_upv_1.Refresh)
                end
            end
            tbl_upv_12[a42] = nil
            if v108 then
                local v116 = items()
                v115 = v116[a42]
                if type(v115) ~= "table" then
                    v115 = {}
                    v116[a42] = v115
                end
                v115.shards = math.max(0, v106 - v107)
                v115.level = v109
                tbl_upv_3.Upgraded:Fire(a42, v105, v109)
            end
            tbl_upv_3.Changed:Fire()
            return v108, v109
        end
        return false, nil
    end
    function items.StreakOffer()
        --[[
          name: StreakOffer
          line: 810
          upvalues:
            State_upv_1 (copy, index: 1)
            Unlocks_upv_1 (copy, index: 2)
            Workspace_upv_1 (copy, index: 3)
        ]]
        local streakRestore_1 = State_upv_1.Profile.streakRestore
        if type(streakRestore_1) == "table" and type(streakRestore_1.lost) == "number" and not (streakRestore_1.lost < Unlocks_upv_1.RESTORE_MIN_STREAK) then
            if type(streakRestore_1.expiresAt) == "number" and streakRestore_1.expiresAt <= Workspace_upv_1:GetServerTimeNow() then
                return false
            end
            return streakRestore_1
        end
        return false
    end
    local u12 = false
    function items.SetRevealShowing(a45)
        --[[
          name: SetRevealShowing
          line: 822
          upvalues:
            u12 (ref, index: 1)
        ]]
        if u12 == a45 then
            return
        end
        u12 = a45
        tbl_upv_3.RevealChanged:Fire(a45)
    end
    function items.RevealShowing()
        --[[
          name: RevealShowing
          line: 828
          upvalues:
            u12 (ref, index: 1)
        ]]
        return u12
    end
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 832
            ]]
            tbl_upv_3.Changed:Fire()
        end
    )
    local tbl_upv_13 = {mid = 0, maxed = 0, new = 0}
    function tbl_upv_13.new()
        --[[
          name: new
          line: 838
        ]]
        local tbl_14 = {restricted = false}
        tbl_14.items = {crossbow = {level = 0, shards = 6}}
        return tbl_14
    end
    function tbl_upv_13.mid()
        --[[
          name: mid
          line: 841
        ]]
        local tbl_15 = {restricted = false}
        tbl_15.items = {short_bow = {level = 3, shards = 40}, bronze_sword = {level = 2, shards = 12}, throwing_knives = {level = 1, shards = 10}, bandage = {level = 4, shards = 30}, war_club = {level = 1, shards = 3}, crossbow = {level = 1, shards = 8}, obsidian_dagger = {level = 5, shards = 0}, bear_trap = {level = 1, shards = 4}, spear = {level = 0, shards = 14}, longbow = {level = 0, shards = 30}, musket = {level = 0, shards = 4}, healing_herbs = {level = 0, shards = 9}}
        return tbl_15
    end
    function tbl_upv_13.maxed()
        --[[
          name: maxed
          line: 860
          upvalues:
            WeaponInfo_upv_1 (copy, index: 1)
        ]]
        local tbl_16 = {}
        for _, value_7 in WeaponInfo_upv_1.AllItems() do
            tbl_16[value_7.id] = {shards = 0, level = tbl_upv_3.MAX_LEVEL}
        end
        local tbl_17 = {restricted = false}
        tbl_17.items = tbl_16
        return tbl_17
    end
    tbl_upv_13.restricted = function()
        --[[
          line: 868
          upvalues:
            tbl_upv_13 (copy, index: 1)
        ]]
        local v117 = tbl_upv_13.mid()
        v117.restricted = true
        return v117
    end
    function items.SetMock(a46)
        --[[
          name: SetMock
          line: 873
          upvalues:
            tbl_upv_13 (copy, index: 1)
        ]]
        if type(a46) == "string" and (tbl_upv_13[a46]) then
            tbl_upv_3.Mock = tbl_upv_13[a46]()
        elseif type(a46) ~= "table" then
            tbl_upv_3.Mock = nil
        else
            local tbl_18 = {items = 0, restricted = 0}
            tbl_18.items = type(a46.items) ~= "table" and {} or a46.items
            tbl_18.restricted = a46.restricted
            tbl_upv_3.Mock = tbl_18
        end
        tbl_upv_3.Changed:Fire()
    end
    a1.Debug.store = function(a47, a48)
        --[[
          line: 884
          upvalues:
            tbl_upv_10 (copy, index: 2)
            u5 (ref,  index: 3)
            State_upv_1 (copy, index: 4)
            u1 (ref,  index: 5)
        ]]
        if a47 == "mock" then
            tbl_upv_3.ForceMock = a48 == true
        elseif a47 == "buy" then
            tbl_upv_3.Buy(a48)
        elseif a47 == "celebrate" then
            tbl_upv_3.Celebrate:Fire(a48)
        end
        local tbl_19 = {}
        for key_9 in tbl_upv_10 do
            table.insert(tbl_19, key_9)
        end
        local tbl_20 = {shards = 0, policy = 0, canBuyDrops = 0}
        tbl_20.mock = tbl_upv_3.ForceMock
        tbl_20.pending = tbl_19
        tbl_20.offer = tbl_upv_3.StreakOffer()
        tbl_20.dropsAllowed = tbl_upv_3.DropsAllowed()
        tbl_20.policy = ((u5 == nil) and "?") or u5
        local canBuyDrops_3 = State_upv_1.Profile.canBuyDrops
        local v119
        if type(canBuyDrops_3) ~= "boolean" then
            v119 = nil
        else
            v119 = canBuyDrops_3
        end
        local v120, v121 = nil, nil
        if v119 ~= nil then
            v120 = State_upv_1.Profile.canBuyDrops
            if type(v120) ~= "boolean" then
                v121 = nil
            else
                v121 = v120
            end
        else
            v121 = "none"
        end
        tbl_20.canBuyDrops = v121
        v121 = ((u1.FALLBACK) and "fallback") or "Shared.Shards"
        tbl_20.shards = v121
        return tbl_20
    end
end
return tbl_upv_3