local v1 = {}

function v1.Expt(a2, a3, a4, a5, a6)
    --[[
      name: Expt
      line: 5
      upvalues:
        v1 (copy, index: 1)
    ]]
    if math.abs(a4 - a3) < 0.01 then
        return a4
    end

    local v7 = v1:Expty(a3, a4, a5, a6)

    return a3 + ((a4 - a3) * v7)
end

function v1.Expty(a8, a9, a10, a11, a12)
    --[[
      name: Expty
      line: 17
    ]]
    return 1 - math.exp(-(-math.log(1 - a11)) * a12)
end

function v1.Sign(a13, a14)
    --[[
      name: Sign
      line: 24
    ]]
    if 0 < a14 then
        return 1
    end

    if a14 < 0 then
        return -1
    end

    return 0
end

function v1.BezierValForT(a15, a16, a17, a18, a19, a20)
    --[[
      name: BezierValForT
      line: 34
    ]]
    local v21 = (1 - a20) * (1 - a20) * (1 - a20)
    local v22 = (3 * a20) * (1 - a20) * (1 - a20)
    local v23 = (3 * a20) * a20 * (1 - a20)
    local v24 = a20 * a20 * a20

    return ((v21 * a16) + (v22 * a17)) + (v23 * a18) + (v24 * a19)
end

v1._BezierPt2ForT = {x = 0, y = 0}

function v1.BezierPt2ForT(a25, a26, a27, a28, a29, a30, a31, a32, a33, a34)
    --[[
      name: BezierPt2ForT
      line: 43
      upvalues:
        v1 (copy, index: 1)
    ]]
    v1._BezierPt2ForT.x = v1:BezierValForT(a26, a28, a30, a32, a34)
    v1._BezierPt2ForT.y = v1:BezierValForT(a27, a29, a31, a33, a34)

    return v1._BezierPt2ForT
end

function v1.YForPointOf2PtLine(a35, a36, a37, a38)
    --[[
      name: YForPointOf2PtLine
      line: 55
    ]]
    local v39 = (a36.y - a37.y) / (a36.x - a37.x)
    local v40 = a36.y - v39 * a36.x

    return (v39 * a38) + v40
end

function v1.DeltaTimeToTimescale(a41, a42)
    --[[
      name: DeltaTimeToTimescale
      line: 63
    ]]
    return a42 / 0.016666666666666666
end

function v1.SecondsToTick(a43, a44)
    --[[
      name: SecondsToTick
      line: 67
    ]]
    return 0.016666666666666666 / a44
end

function v1.ExptValueInSeconds(a45, a46, a47, a48)
    --[[
      name: ExptValueInSeconds
      line: 71
    ]]
    return 1 - math.pow(a46 / a47, 1 / (60 * a48))
end

function v1.NormalizedDefaultExptValueInSeconds(a49, a50)
    --[[
      name: NormalizedDefaultExptValueInSeconds
      line: 75
    ]]
    return a49:ExptValueInSeconds(0.01, 1, a50)
end

return v1