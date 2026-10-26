local JestGlobals_1 = require(game:GetService("CorePackages").Packages.Dev.JestGlobals)
local expect_upv_1 = JestGlobals_1.expect
local it_upv_1 = JestGlobals_1.it
local VRCameraTeleportDetector_1 = require(script.Parent.VRCameraTeleportDetector)
local shouldRecenter_upv_1 = VRCameraTeleportDetector_1.shouldRecenter
local JUMP_STUDS_upv_1 = VRCameraTeleportDetector_1.JUMP_STUDS
local SETTLED_STUDS_upv_1 = VRCameraTeleportDetector_1.SETTLED_STUDS
local DEBOUNCE_SECONDS_upv_1 = VRCameraTeleportDetector_1.DEBOUNCE_SECONDS
JestGlobals_1.describe(
    "VRCameraTeleportDetector.shouldRecenter",
    function()
        --[[
          line: 14
          upvalues:
            it_upv_1 (copy, index: 1)
            expect_upv_1 (copy, index: 2)
            shouldRecenter_upv_1 (copy, index: 3)
            JUMP_STUDS_upv_1 (copy, index: 4)
            SETTLED_STUDS_upv_1 (copy, index: 5)
            DEBOUNCE_SECONDS_upv_1 (copy, index: 6)
        ]]
        it_upv_1(
            "fires on a discrete jump from rest (no prior step, never recentered)",
            function()
                --[[
                  line: 15
                  upvalues:
                    expect_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    JUMP_STUDS_upv_1 (copy, index: 3)
                ]]
                expect_upv_1(shouldRecenter_upv_1(nil, JUMP_STUDS_upv_1 + 10, nil, 100)).toBe(true)
            end
        )
        it_upv_1(
            "fires on a discrete jump preceded by a near-still frame",
            function()
                --[[
                  line: 19
                  upvalues:
                    expect_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    SETTLED_STUDS_upv_1 (copy, index: 3)
                    JUMP_STUDS_upv_1 (copy, index: 4)
                ]]
                expect_upv_1(shouldRecenter_upv_1(SETTLED_STUDS_upv_1 - 0.5, JUMP_STUDS_upv_1 + 10, nil, 100)).toBe(true)
            end
        )
        it_upv_1(
            "does not fire for sub-threshold motion",
            function()
                --[[
                  line: 23
                  upvalues:
                    expect_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    JUMP_STUDS_upv_1 (copy, index: 3)
                ]]
                expect_upv_1(shouldRecenter_upv_1(0, JUMP_STUDS_upv_1 - 0.1, nil, 100)).toBe(false)
                expect_upv_1(shouldRecenter_upv_1(0, 0, nil, 100)).toBe(false)
            end
        )
        it_upv_1(
            "does not fire when the previous frame was already moving (continuous motion)",
            function()
                --[[
                  line: 28
                  upvalues:
                    expect_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    SETTLED_STUDS_upv_1 (copy, index: 3)
                    JUMP_STUDS_upv_1 (copy, index: 4)
                ]]
                expect_upv_1(shouldRecenter_upv_1(SETTLED_STUDS_upv_1 + 0.1, JUMP_STUDS_upv_1 + 10, nil, 100)).toBe(false)
            end
        )
        it_upv_1(
            "does not fire within the debounce interval",
            function()
                --[[
                  line: 33
                  upvalues:
                    expect_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    JUMP_STUDS_upv_1 (copy, index: 3)
                    DEBOUNCE_SECONDS_upv_1 (copy, index: 4)
                ]]
                expect_upv_1(shouldRecenter_upv_1(nil, JUMP_STUDS_upv_1 + 10, 100, (100 + DEBOUNCE_SECONDS_upv_1) - 0.01)).toBe(false)
            end
        )
        it_upv_1(
            "fires again once the debounce interval has elapsed",
            function()
                --[[
                  line: 38
                  upvalues:
                    expect_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    JUMP_STUDS_upv_1 (copy, index: 3)
                    DEBOUNCE_SECONDS_upv_1 (copy, index: 4)
                ]]
                expect_upv_1(shouldRecenter_upv_1(nil, JUMP_STUDS_upv_1 + 10, 100, (100 + DEBOUNCE_SECONDS_upv_1) + 0.01)).toBe(true)
            end
        )
        it_upv_1(
            "does not retrigger every frame under continuous per-frame CFrame writes (oscillation guard)",
            function()
                --[[
                  line: 43
                  upvalues:
                    JUMP_STUDS_upv_1 (copy, index: 1)
                    shouldRecenter_upv_1 (copy, index: 2)
                    expect_upv_1 (copy, index: 3)
                ]]
                local v1 = 0
                local v2 = nil
                local v3 = nil
                local v4 = 0
                local v5 = JUMP_STUDS_upv_1 + 10
                for _ = 1, 120 do
                    local v6 = shouldRecenter_upv_1(v2, v5, v3, v1)
                    if v6 then
                        v4 = v4 + 1
                        v3 = v1
                    end
                    v1 = v1 + 0.016666666666666666
                    v2 = v5
                end
                expect_upv_1(v4).toBe(1)
            end
        )
    end
)