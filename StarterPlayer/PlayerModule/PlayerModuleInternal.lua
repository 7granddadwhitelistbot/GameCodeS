local runService = game:GetService("RunService")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
require(script.Parent.Types)
local v3 = CommonUtils.get("CharacterUtil")
local v4 = CommonUtils.get("ConnectionUtil")
local v5 = CommonUtils.get("EventBus")
local v6 = CommonUtils.get("FlagUtil")
local userFlag = v6.getUserFlag("UserPlayerModuleEngineAPI")
v6 = require(script.Parent)
local CameraModule = require(script.Parent:WaitForChild("CameraModule"))
local ControlModule = require(script.Parent:WaitForChild("ControlModule"))
local EngineInterface = require(script.Parent:WaitForChild("EngineInterface"))
local InputSampler = require(script.Parent:WaitForChild("InputSampler"))
local ServerAuthority = require(script.Parent:WaitForChild("ServerAuthority"))
local Class = {}
Class.__index = Class

function Class.new()
    --[[
      name: new
      line: 51
      upvalues:
        v6 (copy, index: 1)
        v4 (copy, index: 2)
        v5 (copy, index: 3)
        InputSampler (copy, index: 4)
        Class (copy, index: 5)
    ]]
    return (setmetatable({data = {isServerAuthority = false, playerModule = v6, controlModule = {isJumping = false, enabled = true, moveVector = Vector2.new(), worldMoveVector = Vector3.new(), actions = {}}, engineInterface = {player = nil, character = nil, humanoid = nil, characterChanged = false}, connectionUtil = v4.new(), eventBus = v5.new()}, inputSampler = InputSampler.new()}, Class))
end

function Class.start(self)
    --[[
      name: start
      line: 78
      upvalues:
        v3 (copy, index: 1)
        userFlag (copy, index: 2)
        EngineInterface (copy, index: 3)
        ServerAuthority (copy, index: 4)
        ControlModule (copy, index: 5)
        runService (copy, index: 6)
        CameraModule (copy, index: 7)
    ]]
    self.data.connectionUtil:trackConnection(
        "ONLOCALPLAYER",
        v3.onLocalPlayer(
            function(player)
                --[[
                  line: 82
                  upvalues:
                    userFlag (copy, index: 1)
                    EngineInterface (copy, index: 2)
                    self (copy, index: 3)
                    ServerAuthority (copy, index: 4)
                    ControlModule (copy, index: 5)
                    runService (copy, index: 6)
                    CameraModule (copy, index: 7)
                    v3 (copy, index: 8)
                ]]
                if userFlag then
                    EngineInterface.update(self.data)
                    ServerAuthority.initialize(self.data)
                    ControlModule:initialize(self.data)

                    runService:BindToRenderStep(
                        "PLAYERMODULE_RENDERSTEPPED_INPUT",
                        Enum.RenderPriority.Input.Value,
                        function(deltaTime: number)
                            --[[
                              line: 92
                              upvalues:
                                EngineInterface (copy, index: 1)
                                self (copy, index: 2)
                                ControlModule (copy, index: 3)
                            ]]
                            EngineInterface.update(self.data)
                            ControlModule:Update(self.data, deltaTime)
                        end
                    )

                    runService:BindToRenderStep(
                        "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                        Enum.RenderPriority.Camera.Value,
                        function(deltaTime: number)
                            --[[
                              line: 102
                              upvalues:
                                CameraModule (copy, index: 1)
                                self (copy, index: 2)
                                EngineInterface (copy, index: 3)
                            ]]
                            CameraModule:Update(self.data, deltaTime)
                            self.inputSampler:Update(self.data)
                            EngineInterface.cleanDirty(self.data)
                        end
                    )

                    return
                end

                self.data.engineInterface.player = player
                ServerAuthority.initialize(self.data)
                ControlModule:initialize(self.data)

                runService:BindToRenderStep(
                    "PLAYERMODULE_RENDERSTEPPED_INPUT",
                    Enum.RenderPriority.Input.Value,
                    function(deltaTime: number)
                        --[[
                          line: 118
                          upvalues:
                            self (copy, index: 1)
                            v3 (copy, index: 2)
                            ControlModule (copy, index: 3)
                        ]]
                        self.data.engineInterface.character = v3.getCharacter()

                        if not self.data.engineInterface.character then
                            return
                        end

                        ControlModule:Update(self.data, deltaTime)
                    end
                )

                self.data.connectionUtil:trackBoundFunction(
                    "PLAYERMODULE_RENDERSTEPPED_INPUT",
                    function()
                        --[[
                          line: 127
                          upvalues:
                            runService (copy, index: 1)
                        ]]
                        runService:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_INPUT")
                    end
                )

                runService:BindToRenderStep(
                    "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                    Enum.RenderPriority.Camera.Value,
                    function(deltaTime: number)
                        --[[
                          line: 135
                          upvalues:
                            CameraModule (copy, index: 1)
                            self (copy, index: 2)
                        ]]
                        CameraModule:Update(self.data, deltaTime)
                        self.inputSampler:Update(self.data)
                    end
                )

                self.data.connectionUtil:trackBoundFunction(
                    "PLAYERMODULE_RENDERSTEPPED_CAMERA",
                    function()
                        --[[
                          line: 140
                          upvalues:
                            runService (copy, index: 1)
                        ]]
                        runService:UnbindFromRenderStep("PLAYERMODULE_RENDERSTEPPED_CAMERA")
                    end
                )
            end
        )
    )
end

if not userFlag then
    function Class.stop(self)
        --[[
          name: stop
          line: 149
        ]]
        self.data.connectionUtil:disconnectAll()
    end
end

return Class