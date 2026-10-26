local CorePackages_1 = game:GetService("CorePackages")
local JestGlobals_1 = require(CorePackages_1.Packages.Dev.JestGlobals)
local expect_upv_1 = JestGlobals_1.expect
local it_upv_1 = JestGlobals_1.it
local waitForEvents_upv_1 = require(CorePackages_1.Workspace.Packages.TestUtils).DeferredLuaHelpers.waitForEvents
local CameraWrapper_upv_1 = require(script.Parent.CameraWrapper)
JestGlobals_1.describe(
    "CameraWrapper",
    function()
        --[[
          line: 12
          upvalues:
            it_upv_1 (copy, index: 1)
            CameraWrapper_upv_1 (copy, index: 2)
            expect_upv_1 (copy, index: 3)
            waitForEvents_upv_1 (copy, index: 4)
        ]]
        it_upv_1(
            "should instantiate",
            function()
                --[[
                  line: 13
                  upvalues:
                    CameraWrapper_upv_1 (copy, index: 1)
                    expect_upv_1 (copy, index: 2)
                ]]
                expect_upv_1(CameraWrapper_upv_1.new()).never.toBeNil()
            end
        )
        it_upv_1(
            "should return updated camera",
            function()
                --[[
                  line: 19
                  upvalues:
                    CameraWrapper_upv_1 (copy, index: 1)
                    expect_upv_1 (copy, index: 2)
                    waitForEvents_upv_1 (copy, index: 3)
                ]]
                local v1 = CameraWrapper_upv_1.new()
                v1:Enable()
                local v2 = Instance.new("Camera")
                v2.Parent = game.Workspace
                expect_upv_1(v1:getCamera()).toBe(game.Workspace.CurrentCamera)
                expect_upv_1(v1:getCamera()).never.toBe(v2)
                game.Workspace.CurrentCamera = v2
                waitForEvents_upv_1()
                expect_upv_1(v1:getCamera()).toBe(game.Workspace.CurrentCamera)
                expect_upv_1(v1:getCamera()).toBe(v2)
            end
        )
    end
)