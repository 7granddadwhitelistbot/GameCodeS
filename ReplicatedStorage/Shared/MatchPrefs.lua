local v1 = {REGIONS = {{id = "NA", name = "North America"}, {id = "SA", name = "South America"}, {id = "EU", name = "Europe"}, {id = "MEA", name = "Middle East & Africa"}, {id = "AS", name = "Asia"}, {id = "OC", name = "Oceania"}}, DEFAULTS = {mmNoBots = 0, mmAutoRegion = 1, mmRegions = 0, mmPremium = 0, mmRanked = 1}}
v1.RANGES = {mmNoBots = {0, 1}, mmAutoRegion = {0, 1}, mmRegions = {0, (2 ^ (function(...) return ... end)((#v1.REGIONS))) - 1}, mmPremium = {0, 1}, mmRanked = {0, 1}}
v1.PREMIUM_MIN_AGE = 7
v1.PREMIUM_ATTR = "PremiumQueue"
v1.PREMIUM_WANT_ATTR = "PremiumWant"

function v1.PremiumEligible(a2, a3)
    --[[
      name: PremiumEligible
      line: 41
      upvalues:
        v1 (copy, index: 1)
    ]]
    return type(a2) == "number" and v1.PREMIUM_MIN_AGE < a2 and type(a3) == "number" and 0 < a3
end

local function flag(a5, a6)
    --[[
      name: flag
      line: 45
    ]]
    if a5 == true or a5 == 1 then
        return true
    end
    if a5 ~= false and a5 ~= 0 then
        return a6
    end

    return false
end

function v1.Has(a7: number, a8)
    --[[
      name: Has
      line: 54
    ]]
    return type(a7) == "number"
        and a7 == a7
        and bit32.band(math.floor((math.clamp(a7, 0, 1048576))), (bit32.lshift(1, a8 - 1))) ~= 0
end

function v1.With(a9: number, a10, a11)
    --[[
      name: With
      line: 58
    ]]
    local v12 = bit32.lshift(1, a10 - 1)

    if a11 then
        return (bit32.bor(a9, v12))
    end

    return (bit32.band(a9, (bit32.bnot(v12))))
end

function v1.WantsPremium(a13)
    --[[
      name: WantsPremium
      line: 64
    ]]
    if type(a13) ~= "table" then
        return false
    end

    local mmPremium = a13.mmPremium

    if mmPremium == true or mmPremium == 1 then
        return true
    end
    if mmPremium ~= false and mmPremium ~= 0 then
        return false
    end

    return false
end

function v1.Ranked(a15)
    --[[
      name: Ranked
      line: 69
    ]]
    if type(a15) ~= "table" then
        return true
    end

    local mmRanked = a15.mmRanked

    if mmRanked == true or mmRanked == 1 then
        return true
    end
    if mmRanked ~= false and mmRanked ~= 0 then
        return true
    end

    return false
end

function v1.Read(a17)
    --[[
      name: Read
      line: 74
      upvalues:
        v1 (copy, index: 1)
    ]]
    if type(a17) ~= "table" then
        return false, nil
    end

    local mmNoBots = a17.mmNoBots
    local v19 = mmNoBots == true or mmNoBots == 1 or mmNoBots ~= false and mmNoBots ~= 0 and false
    local mmAutoRegion = a17.mmAutoRegion

    if mmAutoRegion == true or mmAutoRegion == 1 or (mmAutoRegion ~= false and mmAutoRegion ~= 0) then
        return v19, nil
    end

    local v21 = {}

    for v22, region in v1.REGIONS do
        if v1.Has(a17.mmRegions, v22) then
            table.insert(v21, region.id)
        end
    end

    local v24 = v19

    if 0 < #v21 then
        return v24, v21
    end

    return v24, nil
end

return v1