local tbl_upv_1 = {}
tbl_upv_1.REGIONS = {{id = "NA", name = "North America"}, {id = "SA", name = "South America"}, {id = "EU", name = "Europe"}, {id = "MEA", name = "Middle East & Africa"}, {id = "AS", name = "Asia"}, {id = "OC", name = "Oceania"}}
tbl_upv_1.DEFAULTS = {mmRanked = 1, mmAutoRegion = 1, mmPremium = 0, mmRegions = 0, mmNoBots = 0}
tbl_upv_1.RANGES = {mmNoBots = {0, 1}, mmAutoRegion = {0, 1}, mmRegions = {0, (2 ^ #tbl_upv_1.REGIONS) - 1}, mmPremium = {0, 1}, mmRanked = {0, 1}}
tbl_upv_1.PREMIUM_MIN_AGE = 7
tbl_upv_1.PREMIUM_ATTR = "PremiumQueue"
tbl_upv_1.PREMIUM_WANT_ATTR = "PremiumWant"
function tbl_upv_1.PremiumEligible(a1, a2)
    --[[
      name: PremiumEligible
      line: 41
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = (type(a1) == "number") and ((tbl_upv_1.PREMIUM_MIN_AGE < a1) and ((type(a2) == "number") and (a2 > 0)))
    return v1
end
local function flag(a1, a2)
    --[[
      name: flag
      line: 45
    ]]
    if a1 ~= true and a1 ~= 1 then
        if a1 ~= false and a1 ~= 0 then
            return a2
        end
        return false
    end
    return true
end
function tbl_upv_1.Has(a1, a2)
    --[[
      name: Has
      line: 54
    ]]
    local v2 = (type(a1) == "number") and ((a1 == a1) and (bit32.band(math.floor(math.clamp(a1, 0, 1048576)), bit32.lshift(1, a2 - 1)) ~= 0))
    return v2
end
function tbl_upv_1.With(a1, a2, a3)
    --[[
      name: With
      line: 58
    ]]
    local v3 = bit32.lshift(1, a2 - 1)
    if a3 then
        return (bit32.bor(a1, v3))
    end
    return (bit32.band(a1, bit32.bnot(v3)))
end
function tbl_upv_1.WantsPremium(a1)
    --[[
      name: WantsPremium
      line: 64
    ]]
    local v4 = false
    local v5 = nil
    if type(a1) == "table" then
        v5 = a1.mmPremium
        if v5 ~= true and v5 ~= 1 then
            if v5 ~= false and v5 ~= 0 then
                v4 = false
                return v4
            end
            return false
        end
        return true
    end
    return v4
end
function tbl_upv_1.Ranked(a1)
    --[[
      name: Ranked
      line: 69
    ]]
    local v6 = true
    local v7 = nil
    if type(a1) == "table" then
        v7 = a1.mmRanked
        if v7 ~= true and v7 ~= 1 then
            if v7 ~= false and v7 ~= 0 then
                v6 = true
                return v6
            end
            return false
        end
        return true
    end
    return v6
end
function tbl_upv_1.Read(a1)
    --[[
      name: Read
      line: 74
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a1) ~= "table" then
        return false, nil
    end
    local v8 = a1.mmNoBots
    local v9
    if v8 == true or v8 == 1 then
        v9 = true
    else
        v9 = false
    end
    local mmAutoRegion_1 = a1.mmAutoRegion
    if mmAutoRegion_1 ~= true and mmAutoRegion_1 ~= 1 and (mmAutoRegion_1 == false or mmAutoRegion_1 == 0) then
        v8 = false
    else
        v8 = true
    end
    if v8 then
        return v9, nil
    end
    v8 = {}
    for key_1, value_1 in tbl_upv_1.REGIONS do
        if tbl_upv_1.Has(a1.mmRegions, key_1) then
            table.insert(v8, value_1.id)
        end
    end
    if #v8 > 0 then
        return v9, v8
    end
    return v9, nil
end
return tbl_upv_1