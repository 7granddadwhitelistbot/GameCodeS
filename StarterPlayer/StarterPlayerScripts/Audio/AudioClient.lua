local Players_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_1 = game:GetService("RunService")
local SoundService_upv_1 = game:GetService("SoundService")
local Shared_1 = ReplicatedStorage_upv_1:WaitForChild("Shared")
local Sfx_upv_1 = require(Shared_1:WaitForChild("Sfx"))
local Sounds_1 = require(Shared_1:WaitForChild("Sounds"))
local Director_upv_1 = require(script.Parent:WaitForChild("Director"))
local LocalPlayer_1 = Players_1.LocalPlayer
if RunService_1:IsStudio() then
    local function wanted()
        --[[
          name: wanted
          line: 32
        ]]
        local v1 = workspace:GetAttribute("StudioAudio") ~= true
        return v1
    end
    local u1 = nil
    local function muteSound(a1)
        --[[
          name: muteSound
          line: 35
        ]]
        if not a1:IsA("Sound") then
            return
        end
        if not (a1:FindFirstChild("StudioMute")) then
            local v2 = Instance.new("EqualizerSoundEffect")
            v2.Name = "StudioMute"
            v2.LowGain = -80
            v2.MidGain = -80
            v2.HighGain = -80
            v2.Priority = 10000
            v2.Parent = a1
        end
    end
    local function apply()
        --[[
          name: apply
          line: 45
          upvalues:
            u1 (ref,  index: 1)
            muteSound (copy, index: 2)
        ]]
        local v3 = workspace:GetAttribute("StudioAudio") ~= true
        if v3 then
            if u1 then
                return
            end
            local v4 = game.DescendantAdded:Connect(
                function(a1)
                    --[[
                      line: 48
                    ]]
                    if not a1:IsA("Sound") or not a1:IsA("Sound") then
                        return
                    end
                    if not (a1:FindFirstChild("StudioMute")) then
                        local v5 = Instance.new("EqualizerSoundEffect")
                        v5.Name = "StudioMute"
                        v5.LowGain = -80
                        v5.MidGain = -80
                        v5.HighGain = -80
                        v5.Priority = 10000
                        v5.Parent = a1
                    end
                end
            )
            u1 = v4
            for _, value_1 in game:GetDescendants() do
                pcall(muteSound, value_1)
            end
        else
            if u1 then
                u1:Disconnect()
                u1 = nil
            end
            for _, value_upv_2 in game:GetDescendants() do
                pcall(
                    function()
                        --[[
                          line: 63
                          upvalues:
                            value_upv_2 (copy, index: 1)
                        ]]
                        if value_upv_2.Name ~= "StudioMute" or not value_upv_2:IsA("EqualizerSoundEffect") then
                            return
                        end
                        value_upv_2:Destroy()
                    end
                )
            end
        end
    end
    apply()
    workspace:GetAttributeChangedSignal("StudioAudio"):Connect(apply)
end
local function hookGroup(a1)
    --[[
      name: hookGroup
      line: 76
      upvalues:
        SoundService_upv_1 (copy, index: 1)
        Sfx_upv_1 (copy, index: 2)
    ]]
    local u2 = SoundService_upv_1:WaitForChild(a1, 30)
    if u2 then
        local v6 = u2:GetAttribute("UserVolume")
        if type(v6) ~= "number" then
            Sfx_upv_1.ApplyGroups()
        else
            Sfx_upv_1.SetVolume(a1, v6)
        end
        u2:GetAttributeChangedSignal("UserVolume"):Connect(
            function()
                --[[
                  line: 88
                  upvalues:
                    u2 (copy, index: 1)
                    Sfx_upv_1 (copy, index: 2)
                    a1 (copy, index: 3)
                ]]
                local v7 = u2:GetAttribute("UserVolume")
                if type(v7) ~= "number" or not (math.abs(v7 - Sfx_upv_1.GetVolume(a1)) > 0.001) then
                    return
                end
                Sfx_upv_1.SetVolume(a1, v7)
            end
        )
    else
        warn("[Audio] SoundGroup " .. a1 .. " never arrived")
    end
end
for key_1 in Sounds_1.GROUPS do
    task.spawn(hookGroup, key_1)
end
SoundService_upv_1:GetAttributeChangedSignal("MasterVolume"):Connect(
    function()
        --[[
          line: 98
          upvalues:
            SoundService_upv_1 (copy, index: 1)
            Sfx_upv_1 (copy, index: 2)
        ]]
        local v8 = SoundService_upv_1:GetAttribute("MasterVolume")
        if type(v8) ~= "number" or not (math.abs(v8 - Sfx_upv_1.GetVolume("Master")) > 0.001) then
            return
        end
        Sfx_upv_1.SetVolume("Master", v8)
    end
)
task.spawn(
    function()
        --[[
          line: 106
          upvalues:
            ReplicatedStorage_upv_1 (copy, index: 1)
            Sfx_upv_1 (copy, index: 2)
        ]]
        local v9 = ReplicatedStorage_upv_1:WaitForChild("Remotes", 60)
        local v10 = v9 and (v9:WaitForChild("SfxPlay", 60))
        if not v10 or not v10:IsA("UnreliableRemoteEvent") then
            return
        end
        v10.OnClientEvent:Connect(
            function(a1, a2, a3, a4, a5)
                --[[
                  line: 112
                  upvalues:
                    Sfx_upv_1 (copy, index: 1)
                ]]
                if type(a1) ~= "string" then
                    return
                end
                local v11 = nil
                if typeof(a3) == "Instance" and (a3.Parent) then
                    v11 = a3
                elseif typeof(a2) == "Vector3" then
                    v11 = a2
                end
                local Play_1 = Sfx_upv_1.Play
                local tbl_1 = {pitch = 0, volume = 0}
                local v12
                if type(a4) ~= "number" then
                    v12 = nil
                else
                    v12 = a4
                end
                tbl_1.volume = v12
                if type(a5) ~= "number" then
                    v12 = nil
                else
                    v12 = a5
                end
                tbl_1.pitch = v12
                Play_1(a1, v11, tbl_1)
            end
        )
    end
)
Director_upv_1.Start(Sfx_upv_1)
local TextChatService_upv_1 = game:GetService("TextChatService")
local function escape(a1)
    --[[
      name: escape
      line: 137
    ]]
    return (string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end
local function clock(a1)
    --[[
      name: clock
      line: 140
    ]]
    local v13 = math.max(0, math.floor(a1))
    return string.format("%d:%02d", v13 // 60, v13 % 60)
end
local function chatLine(a1)
    --[[
      name: chatLine
      line: 144
      upvalues:
        TextChatService_upv_1 (copy, index: 1)
    ]]
    local TextChannels_1 = TextChatService_upv_1:FindFirstChild("TextChannels")
    local u3 = TextChannels_1 and (TextChannels_1:FindFirstChild("RBXSystem"))
    if not u3 or not u3:IsA("TextChannel") then
        return
    end
    pcall(
        function()
            --[[
              line: 148
              upvalues:
                u3 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            u3:DisplaySystemMessage((("<font color=\"#9FD8FF\"><b>\226\153\170</b></font> <font color=\"#E4E8F0\">%*</font>"):format(a1)))
        end
    )
end
local function nowPlaying()
    --[[
      name: nowPlaying
      line: 153
      upvalues:
        Director_upv_1 (copy, index: 1)
        chatLine (copy, index: 2)
    ]]
    local v14 = Director_upv_1.NowPlaying()
    if #v14 ~= 0 then
        local v15 = nil
        for key_2, value_3 in v14 do
            local v16 = string.gsub(string.gsub(string.gsub(value_3.src or (value_3.name), "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
            if value_3.length > 0 then
                local v17 = math.max(0, math.floor(value_3.at))
                local v18 = string.format("%d:%02d", v17 // 60, v17 % 60)
                local v19 = math.max(0, math.floor(value_3.length))
                v15 = (" \194\183 %* / %*"):format(v18, string.format("%d:%02d", v19 // 60, v19 % 60))
            else
                v15 = ""
            end
            local v20 = ((not (value_3.id)) and "") or ((", id %*"):format(value_3.id))
            chatLine((("%*: <b>%*</b>%* (%*%*)"):format(((key_2 ~= 1) and "Also") or "Now playing", v16, v15, string.gsub(string.gsub(string.gsub(value_3.name, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), v20)))
        end
    else
        chatLine("No music is playing right now.")
    end
end
if not (TextChatService_upv_1:FindFirstChild("TribesMusic")) then
    local v21 = Instance.new("TextChatCommand")
    v21.Name = "TribesMusic"
    v21.PrimaryAlias = "/music"
    v21.Triggered:Connect(
        function()
            --[[
              line: 170
              upvalues:
                nowPlaying (copy, index: 1)
            ]]
            nowPlaying()
        end
    )
    v21.Parent = TextChatService_upv_1
end
task.delay(
    3,
    function()
        --[[
          line: 178
          upvalues:
            Sfx_upv_1 (copy, index: 1)
        ]]
        Sfx_upv_1.Preload({"Hitmarker", "Hitmarker_Ranged", "Hitmarker_Headshot", "Kill_Confirm", "Kill_Confirm_Headshot", "Damage_Receive", "Damage_Receive_Heavy", "Match/Countdown_3", "Match/Countdown_2", "Match/Countdown_1", "Match/Fight", "Match/Fight_Drums", "Match/Elimination", "UI/Click", "UI/Hover", "UI/Open", "UI/Close"})
    end
)
if RunService_1:IsStudio() then
    local v22 = LocalPlayer_1:WaitForChild("PlayerScripts")
    local v23 = Instance.new("BindableFunction")
    v23.Name = "AudioDebug"
    v23.OnInvoke = function(a1, ...)
        --[[
          line: 191
          upvalues:
            Director_upv_1 (copy, index: 1)
            Sfx_upv_1 (copy, index: 2)
        ]]
        if a1 ~= "State" then
            local v24
            if a1 ~= "Play" then
                if a1 ~= "Stats" then
                    return nil
                end
                local v25 = Sfx_upv_1.Stats()
                return string.format("live3D=%d pooled=%d", v25.live3D, v25.pooled)
            end
            v24 = Sfx_upv_1.Play(...)
            if v24 then
                return (v24:GetFullName())
            end
            return "nil"
        end
        return Director_upv_1.State()
    end
    v23.Parent = v22
end