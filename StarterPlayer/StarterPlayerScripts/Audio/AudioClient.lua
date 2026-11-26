local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local soundService = game:GetService("SoundService")
local shared = replicatedStorage:WaitForChild("Shared")
local Sfx = require(shared:WaitForChild("Sfx"))
local childName = "Sounds"
local child = require(shared:WaitForChild(childName))
local Director = require(script.Parent:WaitForChild("Director"))
local localPlayer = players.LocalPlayer

if runService:IsStudio() then
    local function wanted()
        --[[
          name: wanted
          line: 32
        ]]
        return workspace:GetAttribute("StudioAudio") ~= true
    end

    local function muteSound(parent: Instance)
        --[[
          name: muteSound
          line: 35
        ]]
        if parent:IsA("Sound") and not parent:FindFirstChild("StudioMute") then
            local studioMute = Instance.new("EqualizerSoundEffect")
            studioMute.Name = "StudioMute"
            studioMute.LowGain = -80
            studioMute.MidGain = -80
            studioMute.HighGain = -80
            studioMute.Priority = 10000
            studioMute.Parent = parent
        end
    end

    local descendantAddedConnection = nil

    local function apply()
        --[[
          name: apply
          line: 45
          upvalues:
            descendantAddedConnection (ref,  index: 1)
            muteSound (copy, index: 2)
        ]]
        if workspace:GetAttribute("StudioAudio") ~= true then
            if not descendantAddedConnection then
                descendantAddedConnection = game.DescendantAdded:Connect(
                    function(descendant: Instance)
                        --[[
                          line: 48
                        ]]
                        if descendant:IsA("Sound")
                            and descendant:IsA("Sound")
                            and not descendant:FindFirstChild("StudioMute")
                        then
                            local studioMute = Instance.new("EqualizerSoundEffect")
                            studioMute.Name = "StudioMute"
                            studioMute.LowGain = -80
                            studioMute.MidGain = -80
                            studioMute.HighGain = -80
                            studioMute.Priority = 10000
                            studioMute.Parent = descendant
                        end
                    end
                )

                for _, descendant in game:GetDescendants() do
                    pcall(muteSound, descendant)
                end
            end
        else
            if descendantAddedConnection then
                descendantAddedConnection:Disconnect()
                descendantAddedConnection = nil
            end

            for _, descendant in game:GetDescendants() do
                pcall(
                    function()
                        --[[
                          line: 63
                          upvalues:
                            descendant (copy, index: 1)
                        ]]
                        if descendant.Name == "StudioMute" and descendant:IsA("EqualizerSoundEffect") then
                            descendant:Destroy()
                        end
                    end
                )
            end
        end
    end

    apply()
    workspace:GetAttributeChangedSignal("StudioAudio"):Connect(apply)
end

for childName2 in child.GROUPS do
    task.spawn(
        function(childName)
            --[[
              name: hookGroup
              line: 76
              upvalues:
                soundService (copy, index: 1)
                Sfx (copy, index: 2)
            ]]
            local child = soundService:WaitForChild(childName, 30)
            if not child then
                warn("[Audio] SoundGroup " .. childName .. " never arrived")
                return
            end

            local userVolume = child:GetAttribute("UserVolume")

            if type(userVolume) ~= "number" then
                Sfx.ApplyGroups()
            else
                Sfx.SetVolume(childName, userVolume)
            end

            child:GetAttributeChangedSignal("UserVolume"):Connect(
                function()
                    --[[
                      line: 88
                      upvalues:
                        child (copy, index: 1)
                        Sfx (copy, index: 2)
                        childName (copy, index: 3)
                    ]]
                    local userVolume = child:GetAttribute("UserVolume")

                    if type(userVolume) == "number" and 0.001 < math.abs(userVolume - Sfx.GetVolume(childName)) then
                        Sfx.SetVolume(childName, userVolume)
                    end
                end
            )
        end,
        childName2
    )
end

soundService:GetAttributeChangedSignal("MasterVolume"):Connect(
    function()
        --[[
          line: 98
          upvalues:
            soundService (copy, index: 1)
            Sfx (copy, index: 2)
        ]]
        local masterVolume = soundService:GetAttribute("MasterVolume")

        if type(masterVolume) == "number" and 0.001 < math.abs(masterVolume - Sfx.GetVolume("Master")) then
            Sfx.SetVolume("Master", masterVolume)
        end
    end
)

task.spawn(
    function()
        --[[
          line: 106
          upvalues:
            replicatedStorage (copy, index: 1)
            Sfx (copy, index: 2)
        ]]
        local remotes = replicatedStorage:WaitForChild("Remotes", 60)
        local sfxPlay = remotes and remotes:WaitForChild("SfxPlay", 60)

        if not sfxPlay or not sfxPlay:IsA("UnreliableRemoteEvent") then
            return
        end

        sfxPlay.OnClientEvent:Connect(
            function(a31, a32, a33, a34, a35)
                --[[
                  line: 112
                  upvalues:
                    Sfx (copy, index: 1)
                ]]
                if type(a31) ~= "string" then
                    return
                end

                local volume
                local pitch
                local v38 = nil

                if typeof(a33) == "Instance" and a33.Parent then
                    v38 = a33
                elseif typeof(a32) == "Vector3" then
                    v38 = a32
                end

                local play = Sfx.Play
                local v40 = {}

                if type(a34) ~= "number" then
                    volume = nil
                else
                    volume = a34
                end

                v40.volume = volume

                if type(a35) ~= "number" then
                    pitch = nil
                else
                    pitch = a35
                end

                v40.pitch = pitch
                play(a31, v38, v40)
            end
        )
    end
)

Director.Start(Sfx)
local textChatService = game:GetService("TextChatService")

local function escape(text: string)
    --[[
      name: escape
      line: 137
    ]]
    return (string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end

local function clock(a45: number)
    --[[
      name: clock
      line: 140
    ]]
    local v46 = math.max(0, (math.floor(a45)))
    return string.format("%d:%02d", v46 // 60, v46 % 60)
end

local function chatLine(a48: string)
    --[[
      name: chatLine
      line: 144
      upvalues:
        textChatService (copy, index: 1)
    ]]
    local textChannels = textChatService:FindFirstChild("TextChannels")
    local rbxSystem = textChannels and textChannels:FindFirstChild("RBXSystem")

    if rbxSystem and rbxSystem:IsA("TextChannel") then
        pcall(
            function()
                --[[
                  line: 148
                  upvalues:
                    rbxSystem (copy, index: 1)
                    a48 (copy, index: 2)
                ]]
                rbxSystem:DisplaySystemMessage((`<font color="#9FD8FF"><b>♪</b></font> <font color="#E4E8F0">{a48}</font>`))
            end
        )
    end
end

local function nowPlaying()
    --[[
      name: nowPlaying
      line: 153
      upvalues:
        Director (copy, index: 1)
        chatLine (copy, index: 2)
    ]]
    local v52 = Director.NowPlaying()

    if #v52 == 0 then
        chatLine("No music is playing right now.")
        return
    end

    for v53, v54 in v52 do
        local formattedText
        local v56 = v54.src or v54.name
        local text = string.gsub(string.gsub(string.gsub(v56, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")

        if not (0 < v54.length) then
            formattedText = ""
        else
            local v58 = math.max(0, (math.floor(v54.at)))
            local formattedText2 = string.format("%d:%02d", v58 // 60, v58 % 60)
            local v60 = math.max(0, (math.floor(v54.length)))
            formattedText = ` · {formattedText2} / {(string.format("%d:%02d", v60 // 60, v60 % 60))}`
        end

        local v61 = not v54.id and "" or `, id {v54.id}`
        local v62 = v53 ~= 1 and "Also" or "Now playing"
        local name = v54.name
        chatLine((`{v62}: <b>{text}</b>{formattedText} ({string.gsub(string.gsub(string.gsub(name, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")}{v61})`))
    end
end

if not textChatService:FindFirstChild("TribesMusic") then
    local tribesMusic = Instance.new("TextChatCommand")
    tribesMusic.Name = "TribesMusic"
    tribesMusic.PrimaryAlias = "/music"
    tribesMusic.Triggered:Connect(
        function()
            --[[
              line: 170
              upvalues:
                nowPlaying (copy, index: 1)
            ]]
            nowPlaying()
        end
    )
    tribesMusic.Parent = textChatService
end

task.delay(
    3,
    function()
        --[[
          line: 178
          upvalues:
            Sfx (copy, index: 1)
        ]]
        Sfx.Preload({"Hitmarker", "Hitmarker_Ranged", "Hitmarker_Headshot", "Kill_Confirm", "Kill_Confirm_Headshot", "Damage_Receive", "Damage_Receive_Heavy", "Match/Countdown_3", "Match/Countdown_2", "Match/Countdown_1", "Match/Fight", "Match/Fight_Drums", "Match/Elimination", "UI/Click", "UI/Hover", "UI/Open", "UI/Close"})
    end
)

if runService:IsStudio() then
    local playerScripts = localPlayer:WaitForChild("PlayerScripts")
    local audioDebug = Instance.new("BindableFunction")
    audioDebug.Name = "AudioDebug"

    audioDebug.OnInvoke = function(a67, ...)
        --[[
          line: 191
          upvalues:
            Director (copy, index: 1)
            Sfx (copy, index: 2)
        ]]
        if a67 == "State" then
            return Director.State()
        end

        if a67 ~= "Play" then
            if a67 == "Stats" then
                local v68 = Sfx.Stats()
                return string.format("live3D=%d pooled=%d", v68.live3D, v68.pooled)
            end

            return nil
        elseif const v69 = Sfx.Play(...) then
            return (v69:GetFullName())
        end

        return "nil"
    end

    audioDebug.Parent = playerScripts
end