local RunService_upv_1 = game:GetService("RunService")
local CommonUtils_1 = require(script.Parent:WaitForChild("CommonUtils"))
local u1 = CommonUtils_1.get("CharacterUtil")
local u2 = CommonUtils_1.get("ConnectionUtil")
local u3 = CommonUtils_1.get("EventBus")
local Parent_upv_1 = require(script.Parent)
local CameraModule_upv_1 = require(script.Parent:WaitForChild("CameraModule"))
local ControlModule_upv_1 = require(script.Parent:WaitForChild("ControlModule"))
local ServerAuthority_upv_1 = require(script.Parent:WaitForChild("ServerAuthority"))
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
function tbl_upv_1.new()
    --[[
      name: new
      line: 63
      upvalues:
        Parent_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        u3 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    return (setmetatable({data = {isJumping = false, isServerAuthority = false, playerModule = Parent_upv_1, moveVector = Vector2.new(), worldMoveVector = Vector3.new(), actions = {}, connectionUtil = u2.new(), eventBus = u3.new()}}, tbl_upv_1))
end
function tbl_upv_1.start(a1)
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
                a1.data.player = a2
                ServerAuthority_upv_1.initialize(a1.data)
                ControlModule_upv_1:initialize(a1.data)
                RunService_upv_1:BindToRenderStep(
                    "PLAYERMODULE_RENDERSTEPPED_INPUT",
                    Enum.RenderPriority.Input.Value,
                    function(a3)
                        --[[
                          line: 91
                          upvalues:
                            a1 (copy, index: 1)
                            u1 (copy, index: 2)
                            ControlModule_upv_1 (copy, index: 3)
                        ]]
                        a1.data.character = u1.getCharacter()
                        if not a1.data.character then
                            return
                        end
                        ControlModule_upv_1:Update(a1.data, a3)
                    end
                )
                a1.data.connectionUtil:trackBoundFunction(
                    "PLAYERMODULE_RENDERSTEPPED_INPUT",
                    function()
                        --[[
                          line: 99
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
                          line: 104
                          upvalues:
                            CameraModule_upv_1 (copy, index: 1)
                            a1 (copy, index: 2)
                        ]]
                        CameraModule_upv_1:Update(a1.data, a4)
                    end
                )
                a1.data.connectionUtil:trackBoundFunction(
                    "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                    function()
                        --[[
                          line: 107
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
function tbl_upv_1.stop(a1)
    --[[
      name: stop
      line: 113
    ]]
    a1.data.connectionUtil:disconnectAll()
end
return tbl_upv_1