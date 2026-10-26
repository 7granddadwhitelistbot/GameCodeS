local tbl_upv_1 = {}
function tbl_upv_1.Expt(a1, a2, a3, a4, a5)
    --[[
      name: Expt
      line: 5
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if math.abs(a3 - a2) < 0.01 then
        return a3
    end
    return a2 + ((a3 - a2) * tbl_upv_1:Expty(a2, a3, a4, a5))
end
function tbl_upv_1.Expty(a1, a2, a3, a4, a5)
    --[[
      name: Expty
      line: 17
    ]]
    return 1 - math.exp(-(-math.log(1 - a4)) * a5)
end
function tbl_upv_1.Sign(a1, a2)
    --[[
      name: Sign
      line: 24
    ]]
    if a2 > 0 then
        return 1
    elseif a2 < 0 then
        return -1
    else
        return 0
    end
end
function tbl_upv_1.BezierValForT(a1, a2, a3, a4, a5, a6)
    --[[
      name: BezierValForT
      line: 34
    ]]
    return ((((((1 - a6) * (1 - a6)) * (1 - a6)) * a2) + ((((3 * a6) * (1 - a6)) * (1 - a6)) * a3)) + ((((3 * a6) * a6) * (1 - a6)) * a4)) + (((a6 * a6) * a6) * a5)
end
tbl_upv_1._BezierPt2ForT = {y = 0, x = 0}
function tbl_upv_1.BezierPt2ForT(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
    --[[
      name: BezierPt2ForT
      line: 43
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    tbl_upv_1._BezierPt2ForT.x = tbl_upv_1:BezierValForT(a2, a4, a6, a8, a10)
    tbl_upv_1._BezierPt2ForT.y = tbl_upv_1:BezierValForT(a3, a5, a7, a9, a10)
    return tbl_upv_1._BezierPt2ForT
end
function tbl_upv_1.YForPointOf2PtLine(a1, a2, a3, a4)
    --[[
      name: YForPointOf2PtLine
      line: 55
    ]]
    local v1 = (a2.y - a3.y) / (a2.x - a3.x)
    return (v1 * a4) + (a2.y - (v1 * a2.x))
end
function tbl_upv_1.DeltaTimeToTimescale(a1, a2)
    --[[
      name: DeltaTimeToTimescale
      line: 63
    ]]
    return a2 / 0.016666666666666666
end
function tbl_upv_1.SecondsToTick(a1, a2)
    --[[
      name: SecondsToTick
      line: 67
    ]]
    return 0.016666666666666666 / a2
end
function tbl_upv_1.ExptValueInSeconds(a1, a2, a3, a4)
    --[[
      name: ExptValueInSeconds
      line: 71
    ]]
    return 1 - math.pow(a2 / a3, 1 / (60 * a4))
end
function tbl_upv_1.NormalizedDefaultExptValueInSeconds(a1, a2)
    --[[
      name: NormalizedDefaultExptValueInSeconds
      line: 75
    ]]
    return a1:ExptValueInSeconds(0.01, 1, a2)
end
return tbl_upv_1