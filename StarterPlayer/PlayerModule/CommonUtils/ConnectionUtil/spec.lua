local CorePackages_1 = game:GetService("CorePackages")
local JestGlobals_1 = require(CorePackages_1.Packages.Dev.JestGlobals)
local expect_upv_1 = JestGlobals_1.expect
local it_upv_1 = JestGlobals_1.it
local Signal_upv_1 = require(CorePackages_1.Workspace.Packages.AppCommonLib).Signal
local ConnectionUtil_upv_1 = require(script.Parent.ConnectionUtil)
JestGlobals_1.describe(
    "ConnectionUtil",
    function()
        --[[
          line: 13
          upvalues:
            it_upv_1 (copy, index: 1)
            ConnectionUtil_upv_1 (copy, index: 2)
            expect_upv_1 (copy, index: 3)
            Signal_upv_1 (copy, index: 4)
        ]]
        it_upv_1(
            "should instantiate",
            function()
                --[[
                  line: 14
                  upvalues:
                    ConnectionUtil_upv_1 (copy, index: 1)
                    expect_upv_1 (copy, index: 2)
                ]]
                expect_upv_1(ConnectionUtil_upv_1.new()).never.toBeNil()
            end
        )
        it_upv_1(
            "should track a connection",
            function()
                --[[
                  line: 20
                  upvalues:
                    ConnectionUtil_upv_1 (copy, index: 1)
                    Signal_upv_1 (copy, index: 2)
                    expect_upv_1 (copy, index: 3)
                ]]
                local v1 = ConnectionUtil_upv_1.new()
                local v2 = Signal_upv_1.new()
                local u1 = ""
                v1:trackConnection(
                    "Signal",
                    v2:Connect(
                        function(a1)
                            --[[
                              line: 27
                              upvalues:
                                u1 (ref, index: 1)
                            ]]
                            u1 = a1
                        end
                    )
                )
                v2:fire("Testing")
                expect_upv_1(u1).toBe("Testing")
            end
        )
        it_upv_1(
            "should disconnect from signal",
            function()
                --[[
                  line: 36
                  upvalues:
                    ConnectionUtil_upv_1 (copy, index: 1)
                    Signal_upv_1 (copy, index: 2)
                    expect_upv_1 (copy, index: 3)
                ]]
                local v3 = ConnectionUtil_upv_1.new()
                local v4 = Signal_upv_1.new()
                local u2 = ""
                v3:trackConnection(
                    "Signal",
                    v4:Connect(
                        function(a2)
                            --[[
                              line: 43
                              upvalues:
                                u2 (ref, index: 1)
                            ]]
                            u2 = a2
                        end
                    )
                )
                v3:disconnect("Signal")
                v4:fire("Testing")
                expect_upv_1(u2).toBe("")
            end
        )
        it_upv_1(
            "should disconnect from all",
            function()
                --[[
                  line: 53
                  upvalues:
                    ConnectionUtil_upv_1 (copy, index: 1)
                    Signal_upv_1 (copy, index: 2)
                    expect_upv_1 (copy, index: 3)
                ]]
                local v5 = ConnectionUtil_upv_1.new()
                local v6 = Signal_upv_1.new()
                local v7 = Signal_upv_1.new()
                local v8 = Signal_upv_1.new()
                local u3 = ""
                local u4 = ""
                local u5 = ""
                v5:trackConnection(
                    "Signal",
                    v6:Connect(
                        function(a3)
                            --[[
                              line: 65
                              upvalues:
                                u3 (ref, index: 1)
                            ]]
                            u3 = a3
                        end
                    )
                )
                v5:trackConnection(
                    "Signal1",
                    v7:Connect(
                        function(a4)
                            --[[
                              line: 71
                              upvalues:
                                u4 (ref, index: 1)
                            ]]
                            u4 = a4
                        end
                    )
                )
                v5:trackConnection(
                    "Signal2",
                    v8:Connect(
                        function(a5)
                            --[[
                              line: 77
                              upvalues:
                                u5 (ref, index: 1)
                            ]]
                            u5 = a5
                        end
                    )
                )
                v5:disconnectAll()
                v6:fire("TestingPrimary")
                v6:fire("TestingSecondary")
                v6:fire("TestingTertiary")
                expect_upv_1(u3).toBe("")
                expect_upv_1(u4).toBe("")
                expect_upv_1(u5).toBe("")
            end
        )
        it_upv_1(
            "should call manual disconnect",
            function()
                --[[
                  line: 92
                  upvalues:
                    ConnectionUtil_upv_1 (copy, index: 1)
                    expect_upv_1 (copy, index: 2)
                ]]
                local v9 = ConnectionUtil_upv_1.new()
                local u6 = ""
                v9:trackBoundFunction(
                    "Manual",
                    function()
                        --[[
                          line: 96
                          upvalues:
                            u6 (ref, index: 1)
                        ]]
                        u6 = "Disconnected"
                    end
                )
                v9:disconnect("Manual")
                expect_upv_1(u6).toBe("Disconnected")
            end
        )
    end
)