local v1
local marketplaceService = game:GetService("MarketplaceService")
local players = game:GetService("Players")
local policyService = game:GetService("PolicyService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local shared = replicatedStorage:WaitForChild("Shared")
local Signal = require(shared:WaitForChild("Signal"))
local v10 = "Unlocks"
local child = require(shared:WaitForChild(v10))
local Ranks = require(shared:WaitForChild("Ranks"))
local childName = "Products"
local child2 = require(shared:WaitForChild(childName))
local v15 = nil

if const shards = shared:FindFirstChild("Shards") then
    if shards:IsA("ModuleScript") then
        local success, result = pcall(require, shards)

        if not success or type(result) ~= "table" then
            warn("[UI] Shared.Shards failed to load: " .. tostring(result))
            v1 = v15
        else
            v1 = result
        end
    else
        v1 = v15
    end
else
    v1 = v15
end

if v1 then
    v10 = v1
else
    local v19 = {small = {unlock = 10, up = {10, 20, 40, 80}}, medium = {unlock = 20, up = {20, 40, 80, 160}}, large = {unlock = 40, up = {40, 80, 160, 320}}, starter = {unlock = 0, up = {10, 20, 40, 80}}}
    local v20 = {
        MAX_LEVEL = 5,
        BONUS_PER_LEVEL = 0.02,
        FALLBACK = true,
        Size = (function(a21)
            --[[
              name: Size
              line: 101
              upvalues:
                child (copy, index: 1)
                v19 (copy, index: 2)
            ]]
            local success, result = pcall(child.SizeOf, a21)

            if success and type(result) == "string" and v19[result] then
                return result
            end
            if child.IsStarter(a21) then
                return "starter"
            end

            return "medium"
        end)
    }

    function v20.UnlockCost(a24)
        --[[
          name: UnlockCost
          line: 105
          upvalues:
            v19 (copy, index: 1)
            v20 (copy, index: 2)
        ]]
        return v19[v20.Size(a24)].unlock
    end

    function v20.UpgradeCost(a25, a26: number)
        --[[
          name: UpgradeCost
          line: 108
          upvalues:
            v20 (copy, index: 1)
            v19 (copy, index: 2)
        ]]
        if v20.MAX_LEVEL <= a26 then
            return nil
        end

        return v19[v20.Size(a25)].up[math.max(1, a26)]
    end

    function v20.Level(a27, key)
        --[[
          name: Level
          line: 114
          upvalues:
            v20 (copy, index: 1)
            child (copy, index: 2)
        ]]
        local v29 = type(a27) == "table" and a27[key]

        if type(v29) == "table" then
            if type(v29.level) == "number" then
                return (math.clamp(math.floor(v29.level), 0, v20.MAX_LEVEL))
            end
        end

        if child.IsStarter(key) then
            return 1
        end

        return 0
    end

    function v20.Owns(a30, a31)
        --[[
          name: Owns
          line: 121
          upvalues:
            v20 (copy, index: 1)
        ]]
        return 1 <= v20.Level(a30, a31)
    end

    function v20.Progress(a32, key)
        --[[
          name: Progress
          line: 124
          upvalues:
            v20 (copy, index: 1)
        ]]
        local shards
        local v35 = type(a32) == "table" and a32[key]

        if type(v35) ~= "table" or type(v35.shards) ~= "number" then
            shards = 0
        else
            shards = v35.shards
        end

        local v36 = v20.Level(a32, key)

        if v36 <= 0 then
            return shards, v20.UnlockCost(key), "unlock"
        end

        local v37 = v20.UpgradeCost(key, v36)
        if not v37 then
            return 0, 0, "max"
        end

        return shards, v37, "upgrade"
    end

    function v20.CanUpgrade(a38, a39)
        --[[
          name: CanUpgrade
          line: 137
          upvalues:
            v20 (copy, index: 1)
        ]]
        local v40, v41, v42 = v20.Progress(a38, a39)
        return (v42 == "upgrade") and (v41 <= v40)
    end

    function v20.Bonus(a43: number)
        --[[
          name: Bonus
          line: 141
          upvalues:
            v20 (copy, index: 1)
        ]]
        return 1 + (v20.BONUS_PER_LEVEL * (math.clamp(a43, 1, v20.MAX_LEVEL) - 1))
    end

    function v20.Odds()
        --[[
          name: Odds
          line: 144
        ]]
        return {}
    end

    v10 = v20
end

local economy = {Unlocks = child, Shards = v10, ROBUX = utf8.char(57346), MAX_LEVEL = tonumber(v10.MAX_LEVEL) or 5, BONUS_PER_LEVEL = tonumber(v10.BONUS_PER_LEVEL)
    or 0.02, Changed = Signal.new(), Event = Signal.new(), Upgraded = Signal.new(), Celebrate = Signal.new(), CelebrationChanged = Signal.new(), RevealChanged = Signal.new(), ForceMock = false, Mock = nil}
local localPlayer = players.LocalPlayer
local isStudio = runService:IsStudio()
local color3FromRGB = Color3.fromRGB
local v48 = {ammo = Color3.fromRGB(240, 96, 48), bow = color3FromRGB(56, 189, 248), gun = color3FromRGB(251, 146, 60), melee = color3FromRGB(248, 113, 113), throwable = color3FromRGB(167, 139, 250), utility = color3FromRGB(250, 204, 21), healing = color3FromRGB(74, 222, 128), armor = color3FromRGB(148, 197, 255)}

function economy.Init(a49)
    --[[
      name: Init
      line: 181
      upvalues:
        economy (copy, index: 1)
        v48 (copy, index: 2)
        v10 (ref,  index: 3)
        child (copy, index: 4)
        Ranks (copy, index: 5)
        policyService (copy, index: 6)
        localPlayer (copy, index: 7)
        workspace (copy, index: 8)
        replicatedStorage (copy, index: 9)
        child2 (copy, index: 10)
        marketplaceService (copy, index: 11)
        isStudio (copy, index: 12)
    ]]
    local state = a49.State
    local weaponInfo = a49.WeaponInfo
    a49.Economy = economy

    local function profile()
        --[[
          name: profile
          line: 186
          upvalues:
            state (copy, index: 1)
        ]]
        return state.Profile
    end

    function economy.CategoryColor(a53)
        --[[
          name: CategoryColor
          line: 190
          upvalues:
            weaponInfo (copy, index: 1)
            v48 (copy, index: 2)
            a49 (copy, index: 3)
        ]]
        local v54 = weaponInfo.Get(a53)
        return v54 and v48[v54.category] or a49.Theme.Colors.Accent
    end

    local v55 = nil
    local owned = nil

    local function items()
        --[[
          name: items
          line: 200
          upvalues:
            economy (copy, index: 1)
            state (copy, index: 2)
            owned (ref,  index: 3)
            v55 (ref,  index: 4)
        ]]
        if const mock = economy.Mock then
            return mock.items
        end

        local profile = state.Profile

        if type(profile.items) == "table" then
            return profile.items
        end

        local owned2 = profile.owned

        if type(owned2) ~= "table" then
            return {}
        end

        if owned ~= owned2 then
            owned = owned2
            v55 = {}

            for v61, v62 in owned2 do
                if v62 == true and type(v61) == "string" then
                    v55[v61] = {shards = 0, level = 1}
                end
            end
        end

        return v55
    end

    economy.Items = items

    function economy.HasData()
        --[[
          name: HasData
          line: 226
          upvalues:
            economy (copy, index: 1)
            state (copy, index: 2)
        ]]
        if economy.Mock then
            return true
        end

        local profile = state.Profile

        return state.HasProfile and (type(profile.items) == "table" or type(profile.owned) == "table")
    end

    function economy.Level(key)
        --[[
          name: Level
          line: 233
          upvalues:
            v10 (ref,  index: 1)
            items (copy, index: 2)
            economy (copy, index: 3)
            state (copy, index: 4)
            child (copy, index: 5)
        ]]
        if type(key) ~= "string" then
            return 0
        end

        local success, result
        success, result = pcall(v10.Level, items(), key)

        if not success or type(result) ~= "number" then
            result = 0
        end

        if result <= 0 and not economy.Mock then
            local owned = state.Profile.owned

            if type(owned) == "table" and owned[key] == true then
                result = 1
            elseif child.IsStarter(key) then
                result = 1
            end
        end

        return (math.clamp(math.floor(result), 0, economy.MAX_LEVEL))
    end

    function economy.Owns(a68)
        --[[
          name: Owns
          line: 250
          upvalues:
            economy (copy, index: 1)
        ]]
        return 1 <= economy.Level(a68)
    end

    weaponInfo.OwnsAmmo = function(a69)
        --[[
          line: 254
          upvalues:
            economy (copy, index: 1)
        ]]
        return economy.Owns(a69)
    end

    function economy.MaxLevel(a70)
        --[[
          name: MaxLevel
          line: 257
          upvalues:
            v10 (ref,  index: 1)
            economy (copy, index: 2)
        ]]
        if type(v10.MaxLevel) == "function" and type(a70) == "string" then
            local success, result = pcall(v10.MaxLevel, a70)

            if success and type(result) == "number" then
                return (math.clamp(math.floor(result), 1, economy.MAX_LEVEL))
            end
        end

        return economy.MAX_LEVEL
    end

    function economy.IsLocked(a73)
        --[[
          name: IsLocked
          line: 266
          upvalues:
            economy (copy, index: 1)
        ]]
        return type(a73) == "string" and not economy.Owns(a73)
    end

    function economy.RankBest()
        --[[
          name: RankBest
          line: 269
          upvalues:
            state (copy, index: 1)
            Ranks (copy, index: 2)
        ]]
        local profile = state.Profile
        return (math.max((tonumber(profile.rankBest) or 1), Ranks.RankOf(tonumber(profile.trophies) or 0)))
    end

    function economy.ItemRank(a75)
        --[[
          name: ItemRank
          line: 273
          upvalues:
            Ranks (copy, index: 1)
        ]]
        return Ranks.ItemRank(a75)
    end

    function economy.RankAllows(a76)
        --[[
          name: RankAllows
          line: 276
          upvalues:
            child (copy, index: 1)
            economy (copy, index: 2)
            Ranks (copy, index: 3)
        ]]
        if type(a76) ~= "string" then
            return false
        end

        return child.EVERYTHING_OWNED == true or economy.Owns(a76) or Ranks.Allows(economy.RankBest(), a76)
    end

    function economy.Progress(a77)
        --[[
          name: Progress
          line: 282
          upvalues:
            economy (copy, index: 1)
            v10 (ref,  index: 2)
            items (copy, index: 3)
        ]]
        local success, result, v80, v81
        local v82 = economy.Level(a77)
        success, result, v80, v81 = pcall(v10.Progress, items(), a77)

        if not success or type(result) ~= "number" then
            result = 0
            v80 = 0
            v81 = not (economy.MAX_LEVEL <= v82) and "unlock" or "max"
        end

        if 1 <= v82 and v81 == "unlock" then
            if const v83 = v10.UpgradeCost(a77, v82) then
                v81 = "upgrade"
                v80 = v83
            else
                result = 0
                v80 = 0
                v81 = "max"
            end
        elseif economy.MaxLevel(a77) <= v82 then
            v81 = "max"
        end

        return math.max(0, (math.floor(result))), math.max(0, (math.floor((v80 or 0)))), v81
    end

    function economy.CanUpgrade(a84)
        --[[
          name: CanUpgrade
          line: 301
          upvalues:
            economy (copy, index: 1)
        ]]
        if type(a84) ~= "string" then
            return false
        end

        local v85, v86, v87 = economy.Progress(a84)

        return v87 == "upgrade" and 0 < v86 and (v86 <= v85)
    end

    function economy.ReadyList()
        --[[
          name: ReadyList
          line: 308
          upvalues:
            weaponInfo (copy, index: 1)
            economy (copy, index: 2)
        ]]
        local v88 = {}

        for _, v90 in weaponInfo.AllItems() do
            if economy.CanUpgrade(v90.id) then
                table.insert(v88, v90.id)
            end
        end

        return v88
    end

    function economy.UpgradesReady()
        --[[
          name: UpgradesReady
          line: 317
          upvalues:
            economy (copy, index: 1)
        ]]
        return #economy.ReadyList()
    end

    function economy.Bonus(a91: number)
        --[[
          name: Bonus
          line: 320
          upvalues:
            v10 (ref,  index: 1)
            economy (copy, index: 2)
        ]]
        local success, result = pcall(v10.Bonus, a91)

        if success and type(result) == "number" then
            return result
        end

        return 1 + (economy.BONUS_PER_LEVEL * (math.clamp(a91, 1, economy.MAX_LEVEL) - 1))
    end

    function economy.BonusPercent(a94)
        --[[
          name: BonusPercent
          line: 327
          upvalues:
            economy (copy, index: 1)
        ]]
        if a94 <= 1 then
            return 0
        end

        return (math.floor(((economy.Bonus(a94) - 1) * 100) + 0.5))
    end

    function economy.MaxBonusPercent()
        --[[
          name: MaxBonusPercent
          line: 333
          upvalues:
            economy (copy, index: 1)
        ]]
        return economy.BonusPercent(economy.MAX_LEVEL)
    end

    function economy.StatWord(a95)
        --[[
          name: StatWord
          line: 336
          upvalues:
            v10 (ref,  index: 1)
            weaponInfo (copy, index: 2)
        ]]
        if type(v10.Stat) == "function" and type(a95) == "string" then
            local success, result = pcall(v10.Stat, a95)

            if success and (type(result) == "string" or result == false) then
                return result
            end
        end

        local v98 = weaponInfo.Get(a95)

        if v98 and v98.category == "armor" then
            return "armor"
        end
        if v98 and v98.category == "healing" then
            return "healing"
        end

        return "damage"
    end

    function economy.BonusText(a99, a100)
        --[[
          name: BonusText
          line: 351
          upvalues:
            v10 (ref,  index: 1)
            economy (copy, index: 2)
        ]]
        if type(v10.BonusText) == "function" then
            local success, result = pcall(v10.BonusText, a99, a100)

            if success and type(result) == "string" then
                return result
            end
        end

        return if const v103 = economy.StatWord(a99) then (string.format("+%d%% %s", economy.BonusPercent(a100), v103)) else ""
    end

    function economy.Reveals()
        --[[
          name: Reveals
          line: 362
          upvalues:
            state (copy, index: 1)
        ]]
        local reveals = state.Profile.reveals

        if type(reveals) ~= "table" then
            return {}
        end

        return reveals
    end

    local item = nil

    local function noteDrop(a107)
        --[[
          name: noteDrop
          line: 369
          upvalues:
            item (ref, index: 1)
        ]]
        if type(a107) ~= "table" or type(a107.stacks) ~= "table" then
            return
        end

        local item2

        for _, stack in a107.stacks do
            if type(stack) == "table" then
                if type(stack.item) ~= "string" then
                    continue
                end

                if stack.unlocked == true then
                    item2 = stack.item
                    break
                end

                local item3 = item2 or stack.item
                item2 = item3
            end
        end

        if item2 then
            item = item2
        end
    end

    function economy.LastFound()
        --[[
          name: LastFound
          line: 388
          upvalues:
            item (ref,  index: 1)
            economy (copy, index: 2)
            noteDrop (copy, index: 3)
        ]]
        if not item then
            local v112 = economy.Reveals()
            local v113 = v112[#v112]

            if type(v113) == "table" then
                noteDrop(v113)
            end
        end

        return item
    end

    function economy.Spotlight()
        --[[
          name: Spotlight
          line: 401
          upvalues:
            weaponInfo (copy, index: 1)
            economy (copy, index: 2)
        ]]
        local id
        local v115 = weaponInfo.AllItems()
        local v116 = -1
        local v117 = math.huge
        local v118 = false

        for _, v120 in v115 do
            if economy.IsLocked(v120.id) then
                local v121, v122, v123, v124
                local v125 = false

                if economy.RankAllows(v120.id) then
                    v121 = true
                    v122, v123 = economy.Progress(v120.id)
                    v124 = v122 / math.max(v123, 1)

                    if not (0 < v122) then
                        v118 = v121
                    elseif v116 < v124 then
                        v125 = true
                    elseif v124 ~= v116 then
                        v118 = v121
                    elseif not (v123 < v117) then
                        v118 = v121
                    else
                        v125 = true
                    end
                end

                if v125 then
                    id = v120.id
                    v116, v117, v118 = v124, v123, v121
                end
            end
        end

        if id then
            return id, "unlock"
        end

        local v126 = economy.LastFound()

        if v126
            and weaponInfo.Get(v126)
            and economy.RankAllows(v126)
            and (economy.IsLocked(v126) or 0 < economy.Progress(v126))
        then
            local v127 = v126

            if economy.IsLocked(v126) then
                return v127, "unlock"
            end

            return v127, "found"
        end

        if v118 then
            local id2
            local v129 = math.huge

            for _, v131 in v115 do
                if economy.IsLocked(v131.id) then
                    if not economy.RankAllows(v131.id) then
                        continue
                    end

                    local _, v133 = economy.Progress(v131.id)

                    if not (v133 < v129) then
                        continue
                    end

                    id2 = v131.id
                    v129 = v133
                end
            end

            return id2, "unlock"
        end

        local id3
        local v135 = economy.ReadyList()

        if v135[1] then
            return v135[1], "ready"
        end

        local v136 = -1
        id3 = nil

        for _, v138 in v115 do
            local v139, v140, v141 = economy.Progress(v138.id)

            if v141 == "upgrade" and v136 < v139 / math.max(v140, 1) then
                local id4 = v138.id
                v136 = v139 / math.max(v140, 1)
                id3 = id4
            end
        end

        local id5 = id3

        if id3 then
            return id5, "upgrade"
        end

        return id5, "max"
    end

    local arePaidRandomItemsRestricted = nil

    task.spawn(
        function()
            --[[
              line: 454
              upvalues:
                policyService (copy, index: 1)
                localPlayer (copy, index: 2)
                arePaidRandomItemsRestricted (ref,  index: 3)
                economy (copy, index: 4)
            ]]
            local success, policyInfoForPlayerAsync = pcall(
                function()
                    --[[
                      line: 455
                      upvalues:
                        policyService (copy, index: 1)
                        localPlayer (copy, index: 2)
                    ]]
                    return policyService:GetPolicyInfoForPlayerAsync(localPlayer)
                end
            )

            if not success
                or type(policyInfoForPlayerAsync) ~= "table"
                or type(policyInfoForPlayerAsync.ArePaidRandomItemsRestricted) ~= "boolean"
            then
                arePaidRandomItemsRestricted = true
            else
                arePaidRandomItemsRestricted = policyInfoForPlayerAsync.ArePaidRandomItemsRestricted
            end

            economy.Changed:Fire()
        end
    )

    local function payloadAllowed()
        --[[
          name: payloadAllowed
          line: 465
          upvalues:
            state (copy, index: 1)
        ]]
        local canBuyDrops = state.Profile.canBuyDrops

        if type(canBuyDrops) ~= "boolean" then
            return nil
        end

        return canBuyDrops
    end

    function economy.DropsAllowed()
        --[[
          name: DropsAllowed
          line: 469
          upvalues:
            economy (copy, index: 1)
            state (copy, index: 2)
            arePaidRandomItemsRestricted (ref,  index: 3)
        ]]
        local canBuyDrops
        local mock = economy.Mock

        if mock and mock.restricted ~= nil then
            return mock.restricted ~= true
        end

        local canBuyDrops2 = state.Profile.canBuyDrops

        if type(canBuyDrops2) ~= "boolean" then
            canBuyDrops = nil
        else
            canBuyDrops = canBuyDrops2
        end

        if canBuyDrops ~= nil then
            return canBuyDrops
        end

        return arePaidRandomItemsRestricted == false
    end

    function economy.Odds(a152)
        --[[
          name: Odds
          line: 480
          upvalues:
            v10 (ref,  index: 1)
            state (copy, index: 2)
            economy (copy, index: 3)
            items (copy, index: 4)
        ]]
        if type(v10.Odds) == "function" then
            local v153
            local v154 = {loadout = state.Loadout()}

            if type(v10.Context) ~= "function" then
                v153 = v154
            elseif economy.Mock then
                v153 = v154
            else
                local success, result = pcall(v10.Context, state.Profile)

                if success then
                    if type(result) ~= "table" then
                        v153 = v154
                    else
                        v153 = result
                    end
                else
                    v153 = v154
                end
            end

            local success, result = pcall(v10.Odds, items(), (a152 or "golden"), v153)

            if success and type(result) == "table" then
                return result
            end
        end

        return {}
    end

    local function serverNow()
        --[[
          name: serverNow
          line: 498
          upvalues:
            workspace (copy, index: 1)
        ]]
        return workspace:GetServerTimeNow()
    end

    function economy.GoldenOffer()
        --[[
          name: GoldenOffer
          line: 501
          upvalues:
            state (copy, index: 1)
            economy (copy, index: 2)
            workspace (copy, index: 3)
        ]]
        local goldenOffer = state.Profile.goldenOffer

        if type(goldenOffer) == "table" and economy.DropsAllowed() then
            if goldenOffer.state == "active" then
                if type(goldenOffer.endsAt) ~= "number" or not (workspace:GetServerTimeNow() < goldenOffer.endsAt) then
                    goldenOffer = false
                end
            elseif goldenOffer.state ~= "ready" then
                goldenOffer = false
            end
        else
            goldenOffer = false
        end

        return goldenOffer
    end

    function economy.OfferLeft()
        --[[
          name: OfferLeft
          line: 511
          upvalues:
            economy (copy, index: 1)
            workspace (copy, index: 2)
        ]]
        local v161 = economy.GoldenOffer()

        if v161 and v161.state == "active" then
            return (math.max(0, v161.endsAt - workspace:GetServerTimeNow()))
        end

        return nil
    end

    function economy.OfferDiscount()
        --[[
          name: OfferDiscount
          line: 515
          upvalues:
            economy (copy, index: 1)
            child (copy, index: 2)
        ]]
        local v162 = economy.GoldenOffer()
        local key = v162 and v162.key or child.FIRST_DROP.key
        local v164 = economy.Price("drop_golden")
        local v165 = economy.Price(key)

        if v164 and v165 and not (v164 <= 0) and not (v164 <= v165) then
            return (math.floor(((1 - (v165 / v164)) * 100) + 0.5))
        end

        return nil
    end

    local timestamp = -math.huge

    function economy.OfferSeen()
        --[[
          name: OfferSeen
          line: 525
          upvalues:
            economy (copy, index: 1)
            timestamp (ref,  index: 2)
            replicatedStorage (copy, index: 3)
        ]]
        local v167 = economy.GoldenOffer()

        if not v167 or v167.state ~= "ready" or os.clock() - timestamp < 5 then
            return
        end

        timestamp = os.clock()

        task.spawn(
            function()
                --[[
                  line: 531
                  upvalues:
                    replicatedStorage (copy, index: 1)
                ]]
                local remotes = replicatedStorage:WaitForChild("Remotes", 30)
                local storeAction = remotes and remotes:WaitForChild("StoreAction", 30)

                if storeAction and storeAction:IsA("RemoteFunction") then
                    pcall(
                        function()
                            --[[
                              line: 535
                              upvalues:
                                storeAction (copy, index: 1)
                            ]]
                            return storeAction:InvokeServer("OfferSeen")
                        end
                    )
                end
            end
        )
    end

    function economy.FormatLeft(a170: number)
        --[[
          name: FormatLeft
          line: 541
        ]]
        local v171 = math.max(0, (math.floor(a170)))
        local flooredValue = math.floor(v171 / 3600)
        local flooredValue2 = math.floor((v171 % 3600) / 60)
        local v174 = v171 % 60

        if not (0 < flooredValue) then
            return (string.format("%d:%02d", flooredValue2, v174))
        end

        return (string.format("%d:%02d:%02d", flooredValue, flooredValue2, v174))
    end

    function economy.DropKey(a175)
        --[[
          name: DropKey
          line: 547
          upvalues:
            economy (copy, index: 1)
        ]]
        if a175 < 5 then
            local v176 = economy.GoldenOffer()

            if v176 and v176.state == "active" then
                return v176.key
            end
        end

        if 5 <= a175 then
            return "drop_golden5"
        end

        return "drop_golden"
    end

    function economy.DropInfo(a177)
        --[[
          name: DropInfo
          line: 557
          upvalues:
            v10 (ref, index: 1)
        ]]
        local v178
        local v179, v180 = false, false
        local drops = v10.DROPS
        local v182 = a177 or "golden"

        if type(drops) ~= "table" then
            v180 = true
        elseif type(drops.kinds) ~= "table" then
            v179 = true
        else
            v178 = drops.kinds[v182]

            if not v178 then
                v179 = true
            end
        end

        if v179 then
            v178 = drops[v182]

            if not v178 then
                v180 = true
            end
        end

        if v180 then
            v178 = nil
        end

        if type(v178) ~= "table" then
            return {}
        end

        return v178
    end

    local assetIds = {}
    local v184 = {}
    local v185 = {2, 5, 15, 30}

    economy.ProductId = function(key)
        --[[
          name: productId
          line: 572
          upvalues:
            child2 (copy, index: 1)
        ]]
        local v187 = child2.ids[key]

        if type(v187) ~= "number" then
            return 0
        end

        return v187
    end

    local function fetch(key)
        --[[
          name: fetch
          line: 577
          upvalues:
            child2 (copy, index: 1)
            assetIds (copy, index: 2)
            v184 (copy, index: 3)
            v185 (copy, index: 4)
            marketplaceService (copy, index: 5)
            economy (copy, index: 6)
        ]]
        local v190
        local v191 = child2.ids[key]

        if type(v191) ~= "number" then
            v190 = 0
        else
            v190 = v191
        end

        if v190 <= 0 or assetIds[key] or v184[key] then
            return
        end

        v184[key] = true

        task.spawn(
            function()
                --[[
                  line: 583
                  upvalues:
                    v185 (copy, index: 1)
                    marketplaceService (copy, index: 2)
                    v190 (copy, index: 3)
                    assetIds (copy, index: 4)
                    key (copy, index: 5)
                    v184 (copy, index: 6)
                    economy (copy, index: 7)
                ]]
                local productInfo

                for index = 1, #v185 + 1 do
                    local success
                    success, productInfo = pcall(
                        function()
                            --[[
                              line: 585
                              upvalues:
                                marketplaceService (copy, index: 1)
                                v190 (copy, index: 2)
                            ]]
                            return marketplaceService:GetProductInfo(v190, Enum.InfoType.Product)
                        end
                    )

                    if success and type(productInfo) == "table" and type(productInfo.PriceInRobux) == "number" then
                        assetIds[key] = productInfo.PriceInRobux
                        v184[key] = nil
                        economy.Changed:Fire()

                        return
                    end

                    local v195 = v185[index]
                    if not v195 then
                        break
                    end

                    task.wait(v195)
                end

                v184[key] = nil
            end
        )
    end

    function economy.Price(key)
        --[[
          name: Price
          line: 603
          upvalues:
            assetIds (copy, index: 1)
            child2 (copy, index: 2)
            v184 (copy, index: 3)
            v185 (copy, index: 4)
            marketplaceService (copy, index: 5)
            economy (copy, index: 6)
        ]]
        local v197
        local assetId = assetIds[key]
        if assetId then
            return assetId
        end

        local v199 = child2.ids[key]

        if type(v199) ~= "number" then
            v197 = 0
        else
            v197 = v199
        end

        if not (v197 <= 0) and not assetIds[key] and not v184[key] then
            v184[key] = true

            task.spawn(
                function()
                    --[[
                      line: 583
                      upvalues:
                        v185 (copy, index: 1)
                        marketplaceService (copy, index: 2)
                        assetId (copy, index: 3)
                        assetIds (copy, index: 4)
                        key (copy, index: 5)
                        v184 (copy, index: 6)
                        economy (copy, index: 7)
                    ]]
                    local productInfo

                    for index = 1, #v185 + 1 do
                        local success
                        success, productInfo = pcall(
                            function()
                                --[[
                                  line: 585
                                  upvalues:
                                    marketplaceService (copy, index: 1)
                                    assetId (copy, index: 2)
                                ]]
                                return marketplaceService:GetProductInfo(assetId, Enum.InfoType.Product)
                            end
                        )

                        if success and type(productInfo) == "table" and type(productInfo.PriceInRobux) == "number" then
                            assetIds[key] = productInfo.PriceInRobux
                            v184[key] = nil
                            economy.Changed:Fire()

                            return
                        end

                        local v203 = v185[index]
                        if not v203 then
                            break
                        end

                        task.wait(v203)
                    end

                    v184[key] = nil
                end
            )
        end

        return nil
    end

    function economy.PriceAmount(a204)
        --[[
          name: PriceAmount
          line: 611
          upvalues:
            economy (copy, index: 1)
        ]]
        return if const v205 = economy.Price(a204) then (tostring(v205)) else "…"
    end

    function economy.PriceText(a206)
        --[[
          name: PriceText
          line: 615
          upvalues:
            economy (copy, index: 1)
        ]]
        return economy.ROBUX .. " " .. economy.PriceAmount(a206)
    end

    function economy.ItemKey(a207)
        --[[
          name: ItemKey
          line: 618
        ]]
        return "unlock_" .. a207
    end

    function economy.CanBuy(key)
        --[[
          name: CanBuy
          line: 622
          upvalues:
            child2 (copy, index: 1)
            isStudio (copy, index: 2)
        ]]
        local v209
        local v210 = true
        local v211 = child2.ids[key]

        if type(v211) ~= "number" then
            v209 = 0
        else
            v209 = v211
        end

        if not (0 < v209) then
            return isStudio
        end

        return v210
    end

    task.delay(
        3,
        function()
            --[[
              line: 626
              upvalues:
                child2 (copy, index: 1)
                assetIds (copy, index: 2)
                v184 (copy, index: 3)
                v185 (copy, index: 4)
                marketplaceService (copy, index: 5)
                economy (copy, index: 6)
            ]]
            for v212 in child2.ids do
                local v213 = child2.ids[v212]

                if type(v213) ~= "number" then
                    v213 = 0
                end

                if not (v213 <= 0) then
                    if not assetIds[v212] and not v184[v212] then
                        v184[v212] = true

                        task.spawn(
                            function()
                                --[[
                                  line: 583
                                  upvalues:
                                    v185 (copy, index: 1)
                                    marketplaceService (copy, index: 2)
                                    v213 (copy, index: 3)
                                    assetIds (copy, index: 4)
                                    v212 (copy, index: 5)
                                    v184 (copy, index: 6)
                                    economy (copy, index: 7)
                                ]]
                                local productInfo

                                for index = 1, #v185 + 1 do
                                    local success
                                    success, productInfo = pcall(
                                        function()
                                            --[[
                                              line: 585
                                              upvalues:
                                                marketplaceService (copy, index: 1)
                                                v213 (copy, index: 2)
                                            ]]
                                            return marketplaceService:GetProductInfo(v213, Enum.InfoType.Product)
                                        end
                                    )

                                    if success
                                        and type(productInfo) == "table"
                                        and type(productInfo.PriceInRobux) == "number"
                                    then
                                        assetIds[v212] = productInfo.PriceInRobux
                                        v184[v212] = nil
                                        economy.Changed:Fire()

                                        return
                                    end

                                    local v217 = v185[index]
                                    if not v217 then
                                        break
                                    end

                                    task.wait(v217)
                                end

                                v184[v212] = nil
                            end
                        )
                    end
                end
            end
        end
    )

    local v218 = {}

    function economy.Pending(key)
        --[[
          name: Pending
          line: 634
          upvalues:
            v218 (copy, index: 1)
        ]]
        if key then
            return v218[key] ~= nil
        end

        return next(v218) ~= nil
    end

    local function setPending(key, a222)
        --[[
          name: setPending
          line: 640
          upvalues:
            v218 (copy, index: 1)
            economy (copy, index: 2)
        ]]
        v218[key] = if a222 then os.clock() else nil
        economy.Changed:Fire()
    end

    local storeAction = nil

    task.spawn(
        function()
            --[[
              line: 645
              upvalues:
                replicatedStorage (copy, index: 1)
                storeAction (ref,  index: 2)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 30)
            local storeAction2 = remotes and remotes:WaitForChild("StoreAction", 30)

            if storeAction2 and storeAction2:IsA("RemoteFunction") then
                storeAction = storeAction2
            end
        end
    )

    function economy.Buy(text: string)
        --[[
          name: Buy
          line: 653
          upvalues:
            v218 (copy, index: 1)
            economy (copy, index: 2)
            child2 (copy, index: 3)
            isStudio (copy, index: 4)
            storeAction (ref,  index: 5)
            a49 (copy, index: 6)
            marketplaceService (copy, index: 7)
            localPlayer (copy, index: 8)
        ]]
        if v218[text] then
            return false
        end
        if string.sub(text, 1, 5) == "drop_" and not economy.DropsAllowed() then
            return false
        end

        local v227
        local v228 = false
        local v229 = child2.ids[text]

        if type(v229) ~= "number" then
            v227 = 0
        else
            v227 = v229
        end

        if isStudio then
            if v227 ~= 0 and game.GameId == child2.universe and not economy.ForceMock then
                v228 = true
            end
        else
            v228 = true
        end

        if v228 then
            if v227 == 0 then
                a49.Toast("Not available yet", "warning")
                return false
            end

            v218[text] = os.clock()
            economy.Changed:Fire()
            local success, result = pcall(
                function()
                    --[[
                      line: 686
                      upvalues:
                        marketplaceService (copy, index: 1)
                        localPlayer (copy, index: 2)
                        v227 (copy, index: 3)
                    ]]
                    marketplaceService:PromptProductPurchase(localPlayer, v227)
                end
            )
            if success then
                return true
            end

            v218[text] = nil
            economy.Changed:Fire()
            a49.Toast("Couldn't open the purchase: " .. tostring(result), "error")

            return false
        end

        local storeAction2 = storeAction
        if not storeAction2 then
            a49.Toast("Store not ready yet", "error")
            return false
        end

        v218[text] = os.clock()
        economy.Changed:Fire()

        task.spawn(
            function()
                --[[
                  line: 670
                  upvalues:
                    storeAction2 (copy, index: 1)
                    text (copy, index: 2)
                    v218 (copy, index: 3)
                    economy (copy, index: 4)
                    a49 (copy, index: 5)
                ]]
                local success, result, v235 = pcall(
                    function()
                        --[[
                          line: 671
                          upvalues:
                            storeAction2 (copy, index: 1)
                            text (copy, index: 2)
                        ]]
                        return storeAction2:InvokeServer("Mock", text)
                    end
                )
                v218[text] = nil
                economy.Changed:Fire()

                if not success or not result then
                    a49.Toast("(Studio) mock purchase failed: " .. tostring((v235 or result)), "error")
                end
            end
        )

        return true
    end

    marketplaceService.PromptProductPurchaseFinished:Connect(
        function(userId: number, productId: number, isPurchased: boolean)
            --[[
              line: 696
              upvalues:
                localPlayer (copy, index: 1)
                v218 (copy, index: 2)
                child2 (copy, index: 3)
                economy (copy, index: 4)
                a49 (copy, index: 5)
            ]]
            if userId ~= localPlayer.UserId then
                return
            end

            for v239 in v218 do
                local v240 = child2.ids[v239]

                if type(v240) ~= "number" then
                    v240 = 0
                end

                if v240 == productId then
                    if isPurchased then
                        task.delay(
                            20,
                            function()
                                --[[
                                  line: 704
                                  upvalues:
                                    v218 (copy, index: 1)
                                    v239 (copy, index: 2)
                                    economy (copy, index: 3)
                                    a49 (copy, index: 4)
                                ]]
                                if v218[v239] then
                                    v218[v239] = nil
                                    economy.Changed:Fire()
                                    a49.Toast("Your purchase is still processing: it will arrive shortly", "info")
                                end
                            end
                        )
                    else
                        v218[v239] = nil
                        economy.Changed:Fire()
                    end
                end
            end
        end
    )

    local function clearPendingFor(a242)
        --[[
          name: clearPendingFor
          line: 717
          upvalues:
            v218 (copy, index: 1)
            economy (copy, index: 2)
        ]]
        for text in v218 do
            if string.sub(text, 1, #a242) == a242 then
                v218[text] = nil
                economy.Changed:Fire()
            end
        end
    end

    task.spawn(
        function()
            --[[
              line: 724
              upvalues:
                replicatedStorage (copy, index: 1)
                v218 (copy, index: 2)
                economy (copy, index: 3)
                noteDrop (copy, index: 4)
            ]]
            local remotes = replicatedStorage:WaitForChild("Remotes", 30)
            local economyEvent = remotes and remotes:WaitForChild("EconomyEvent", 30)

            if not economyEvent or not economyEvent:IsA("RemoteEvent") then
                return
            end

            economyEvent.OnClientEvent:Connect(
                function(a246, a247)
                    --[[
                      line: 730
                      upvalues:
                        v218 (copy, index: 1)
                        economy (copy, index: 2)
                        noteDrop (copy, index: 3)
                    ]]
                    if type(a246) ~= "string" then
                        return
                    end

                    local v248

                    if type(a247) ~= "table" then
                        v248 = {}
                    else
                        v248 = a247
                    end

                    if a246 == "Unlocked" or a246 == "Credit" then
                        for text in v218 do
                            if string.sub(text, 1, 7) == "unlock_" then
                                v218[text] = nil
                                economy.Changed:Fire()
                            end
                        end
                    elseif a246 ~= "Drop" then
                        if a246 == "StreakRestored" or a246 == "StreakCredit" then
                            for text in v218 do
                                if string.sub(text, 1, 7) == "streak_" then
                                    v218[text] = nil
                                    economy.Changed:Fire()
                                end
                            end
                        elseif a246 == "TribePass" then
                            for text in v218 do
                                if string.sub(text, 1, 6) == "tribe_" then
                                    v218[text] = nil
                                    economy.Changed:Fire()
                                end
                            end
                        end
                    else
                        for text in v218 do
                            if string.sub(text, 1, 5) == "drop_" then
                                v218[text] = nil
                                economy.Changed:Fire()
                            end
                        end

                        noteDrop(v248)
                    end

                    economy.Event:Fire(a246, v248)

                    if a246 == "Unlocked" and type(v248.item) == "string" then
                        economy.Celebrate:Fire(v248.item)
                    end

                    economy.Changed:Fire()
                end
            )
        end
    )

    state.MatchEvent:Connect(
        function(a253, a254)
            --[[
              line: 753
              upvalues:
                noteDrop (copy, index: 1)
            ]]
            if a253 == "MatchEnd" and type(a254) == "table" and type(a254.you) == "table" then
                noteDrop(a254.you.drop)
            end
        end
    )

    local v255 = {}

    function economy.Upgrading(key)
        --[[
          name: Upgrading
          line: 761
          upvalues:
            v255 (copy, index: 1)
        ]]
        return v255[key] == true
    end

    function economy.Upgrade(key, a258, a259)
        --[[
          name: Upgrade
          line: 764
          upvalues:
            v255 (copy, index: 1)
            economy (copy, index: 2)
            state (copy, index: 3)
            a49 (copy, index: 4)
            items (copy, index: 5)
        ]]
        if v255[key] or not economy.CanUpgrade(key) then
            return false, nil
        end

        local v260 = economy.Level(key)
        local v261, v262 = economy.Progress(key)
        v255[key] = true
        economy.Changed:Fire()
        local v263 = false
        local level = nil

        if economy.Mock then
            v263 = true
            level = v260 + 1
        elseif state.Mock then
            v263 = true
            level = v260 + 1
        else
            local v265, v266, v267, v268 = a49.Remotes.Invoke("ProfileAction", "Upgrade", key, a258, a259)

            if v265 then
                if v266 == true or type(v266) == "number" then
                    v263 = true

                    if type(v266) ~= "number" then
                        if type(v267) ~= "number" then
                            if type(v268) ~= "number" then
                                level = v260 + 1
                            else
                                level = v268
                            end
                        else
                            level = v267
                        end
                    else
                        level = v266
                    end
                else
                    a49.Toast(tostring((v267 or "Couldn't upgrade that")), "error")
                end
            else
                a49.Toast(tostring((v266 or "Server unavailable")), "error")
            end

            if v263 then
                task.delay(0.6, state.Refresh)
            end
        end

        v255[key] = nil

        if v263 then
            local v269 = items()
            local v270 = v269[key]

            if type(v270) ~= "table" then
                v270 = {}
                v269[key] = v270
            end

            v270.shards = math.max(0, v261 - v262)
            v270.level = level
            economy.Upgraded:Fire(key, v260, level)
        end

        economy.Changed:Fire()

        return v263, level
    end

    function economy.StreakOffer()
        --[[
          name: StreakOffer
          line: 810
          upvalues:
            state (copy, index: 1)
            child (copy, index: 2)
            workspace (copy, index: 3)
        ]]
        local streakRestore = state.Profile.streakRestore

        if type(streakRestore) == "table"
            and type(streakRestore.lost) == "number"
            and not (streakRestore.lost < child.RESTORE_MIN_STREAK)
        then
            if type(streakRestore.expiresAt) == "number" then
                local serverTimeNow = workspace:GetServerTimeNow()

                if streakRestore.expiresAt <= serverTimeNow then
                    streakRestore = false
                end
            end
        else
            streakRestore = false
        end

        return streakRestore
    end

    local v273 = false

    function economy.SetRevealShowing(revealShowing)
        --[[
          name: SetRevealShowing
          line: 822
          upvalues:
            v273 (ref,  index: 1)
            economy (copy, index: 2)
        ]]
        if v273 ~= revealShowing then
            v273 = revealShowing
            economy.RevealChanged:Fire(revealShowing)
        end
    end

    function economy.RevealShowing()
        --[[
          name: RevealShowing
          line: 828
          upvalues:
            v273 (ref, index: 1)
        ]]
        return v273
    end

    state.ProfileChanged:Connect(
        function()
            --[[
              line: 832
              upvalues:
                economy (copy, index: 1)
            ]]
            economy.Changed:Fire()
        end
    )
    local v275 = {
        new = (function()
            --[[
              name: new
              line: 838
            ]]
            return {restricted = false, items = {crossbow = {shards = 6, level = 0}}}
        end),
        mid = (function()
            --[[
              name: mid
              line: 841
            ]]
            return {
                restricted = false,
                items = {short_bow = {shards = 40, level = 3}, bronze_sword = {shards = 12, level = 2}, throwing_knives = {shards = 10, level = 1}, bandage = {shards = 30, level = 4}, war_club = {shards = 3, level = 1}, crossbow = {shards = 8, level = 1}, obsidian_dagger = {shards = 0, level = 5}, bear_trap = {shards = 4, level = 1}, spear = {shards = 14, level = 0}, longbow = {shards = 30, level = 0}, musket = {shards = 4, level = 0}, healing_herbs = {shards = 9, level = 0}}
            }
        end),
        maxed = (function()
            --[[
              name: maxed
              line: 860
              upvalues:
                weaponInfo (copy, index: 1)
                economy (copy, index: 2)
            ]]
            local items = {}

            for _, v278 in weaponInfo.AllItems() do
                items[v278.id] = {shards = 0, level = economy.MAX_LEVEL}
            end

            return {restricted = false, items = items}
        end)
    }

    v275.restricted = function()
        --[[
          line: 868
          upvalues:
            v275 (copy, index: 1)
        ]]
        local v279 = v275.mid()
        v279.restricted = true
        return v279
    end

    function economy.SetMock(mock)
        --[[
          name: SetMock
          line: 873
          upvalues:
            v275 (copy, index: 1)
            economy (copy, index: 2)
        ]]
        if type(mock) == "string" and v275[mock] then
            economy.Mock = v275[mock]()
        elseif type(mock) ~= "table" then
            economy.Mock = nil
        else
            local v281
            local mock2 = {}

            if type(mock.items) ~= "table" then
                v281 = {}
            else
                v281 = mock.items
            end

            mock2.items = v281
            mock2.restricted = mock.restricted
            economy.Mock = mock2
        end

        economy.Changed:Fire()
    end

    a49.Debug.store = function(a283, a284)
        --[[
          line: 884
          upvalues:
            economy (copy, index: 1)
            v218 (copy, index: 2)
            arePaidRandomItemsRestricted (ref,  index: 3)
            state (copy, index: 4)
            v10 (ref,  index: 5)
        ]]
        local arePaidRandomItemsRestricted2
        local canBuyDrops
        local v287

        if a283 == "mock" then
            economy.ForceMock = a284 == true
        elseif a283 == "buy" then
            economy.Buy(a284)
        elseif a283 == "celebrate" then
            economy.Celebrate:Fire(a284)
        end

        local pending = {}

        for v289 in v218 do
            table.insert(pending, v289)
        end

        local v290 = {mock = economy.ForceMock, pending = pending, offer = economy.StreakOffer(), dropsAllowed = economy.DropsAllowed()}

        if arePaidRandomItemsRestricted ~= nil then
            arePaidRandomItemsRestricted2 = arePaidRandomItemsRestricted
        else
            arePaidRandomItemsRestricted2 = "?"
        end

        v290.policy = arePaidRandomItemsRestricted2
        local canBuyDrops2 = state.Profile.canBuyDrops

        if type(canBuyDrops2) ~= "boolean" then
            canBuyDrops = nil
        else
            canBuyDrops = canBuyDrops2
        end

        if canBuyDrops ~= nil then
            local canBuyDrops3 = state.Profile.canBuyDrops

            if type(canBuyDrops3) ~= "boolean" then
                v287 = nil
            else
                v287 = canBuyDrops3
            end
        else
            v287 = "none"
        end

        v290.canBuyDrops = v287
        v290.shards = v10.FALLBACK and "fallback" or "Shared.Shards"

        return v290
    end
end

return economy