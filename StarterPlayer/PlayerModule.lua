local CommonUtils_1 = require(script:WaitForChild("CommonUtils"))
if CommonUtils_1.get("FlagUtil").getUserFlag("UserControlModuleEnabledAPI") then
    local tbl_1 = {}
    tbl_1.ControlModule = {Enabled = true}
    return tbl_1
else
    local RunService_upv_1 = game:GetService("RunService")
    local u1 = CommonUtils_1.get("CharacterUtil")
    local u2 = CommonUtils_1.get("ConnectionUtil")
    local u3 = CommonUtils_1.get("EventBus")
    local CameraModule_upv_1 = require(script:WaitForChild("CameraModule"))
    local ControlModule_upv_1 = require(script:WaitForChild("ControlModule"))
    local ServerAuthority_upv_1 = require(script:WaitForChild("ServerAuthority"))
    local tbl_upv_2 = {}
    tbl_upv_2.__index = tbl_upv_2
    function tbl_upv_2.new()
        --[[
          name: new
          line: 69
          upvalues:
            u2 (copy, index: 1)
            u3 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
        ]]
        return (setmetatable({data = {isServerAuthority = false, playerData = {}, connectionUtil = u2.new(), eventBus = u3.new()}}, tbl_upv_2))
    end
    function tbl_upv_2.start(a1)
        --[[
          name: start
          line: 82
          upvalues:
            u1 (copy, index: 1)
            ServerAuthority_upv_1 (copy, index: 2)
            ControlModule_upv_1 (copy, index: 3)
            RunService_upv_1 (copy, index: 4)
            CameraModule_upv_1 (copy, index: 5)
        ]]
        a1.data.connectionUtil:trackConnection(
            "ONLOCALPLAYER",
            u1.onLocalPlayer(
                function(a2)
                    --[[
                      line: 84
                      upvalues:
                        a1 (copy, index: 1)
                        ServerAuthority_upv_1 (copy, index: 2)
                        ControlModule_upv_1 (copy, index: 3)
                        RunService_upv_1 (copy, index: 4)
                        u1 (copy, index: 5)
                        CameraModule_upv_1 (copy, index: 6)
                    ]]
                    a1.data.playerData[a2] = {isJumping = false, moveVector = Vector2.new(), actions = {}, player = a2}
                    ServerAuthority_upv_1.initialize(a1.data)
                    ControlModule_upv_1:initialize(a1.data, a1.data.playerData[a2])
                    RunService_upv_1:BindToRenderStep(
                        "PLAYERMODULE_RENDERSTEPPED_INPUT",
                        Enum.RenderPriority.Input.Value,
                        function(a3)
                            --[[
                              line: 99
                              upvalues:
                                a1 (copy, index: 1)
                                u1 (copy, index: 2)
                                ControlModule_upv_1 (copy, index: 3)
                            ]]
                            for _, value_1 in pairs(a1.data.playerData) do
                                value_1.character = u1.getCharacter()
                                if value_1.character then
                                    ControlModule_upv_1:Update(a1.data, value_1, a3)
                                    continue
                                end
                                return
                            end
                        end
                    )
                    a1.data.connectionUtil:trackBoundFunction(
                        "PLAYERMODULE_RENDERSTEPPED_INPUT",
                        function()
                            --[[
                              line: 109
                              upvalues:
                                RunService_upv_1 (copy, index: 1)
                            ]]
                            RunService_upv_1:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_INPUT")
                        end
                    )
                    RunService_upv_1:BindToRenderStep(
                        "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                        Enum.RenderPriority.Camera.Value,
                        function(a4)
                            --[[
                              line: 114
                              upvalues:
                                a1 (copy, index: 1)
                                CameraModule_upv_1 (copy, index: 2)
                            ]]
                            for _, value_2 in pairs(a1.data.playerData) do
                                CameraModule_upv_1:Update(value_2, a4)
                            end
                        end
                    )
                    a1.data.connectionUtil:trackBoundFunction(
                        "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                        function()
                            --[[
                              line: 119
                              upvalues:
                                RunService_upv_1 (copy, index: 1)
                            ]]
                            RunService_upv_1:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_CAMERA")
                        end
                    )
                end
            )
        )
    end
    function tbl_upv_2.stop(a1)
        --[[
          name: stop
          line: 125
        ]]
        a1.data.connectionUtil:disconnectAll()
    end
    tbl_upv_2.new():start()
    return {}
end