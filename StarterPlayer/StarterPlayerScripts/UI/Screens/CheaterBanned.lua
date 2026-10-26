local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local Ranks_upv_1 = require(ReplicatedStorage_1.Shared.Ranks)
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local Fx_upv_1 = require(script.Parent.Parent.Fx)
local tbl_1 = {}
local u1 = Color3.fromRGB(255, 206, 92)
local u2 = Color3.fromRGB(255, 236, 170)
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 32
      upvalues:
        Players_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        u2 (copy, index: 3)
        Fx_upv_1 (copy, index: 4)
        RankArt_upv_1 (copy, index: 5)
        Ranks_upv_1 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local MenuManager_upv_1 = a1.MenuManager
    local fromOffset_upv_1 = UDim2.fromOffset
    local Assets_upv_1 = UI_upv_1.Assets
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u3 = nil
    local tbl_upv_2 = {}
    local u4 = {trophies = 0, matches = 1}
    local u5 = nil
    local u6 = nil
    local u7 = nil
    local u8 = 0
    local function text(a2)
        --[[
          name: text
          line: 52
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        a2.BackgroundTransparency = 1
        return UI_upv_1.new("TextLabel", a2)
    end
    local function close()
        --[[
          name: close
          line: 48
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("CheaterBanned")
    end
    local function build()
        --[[
          name: build
          line: 57
          upvalues:
            u3 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            close (copy, index: 5)
            u1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            tbl_upv_2 (copy, index: 8)
            Assets_upv_1 (copy, index: 9)
            u2 (copy, index: 10)
            Fx_upv_1 (copy, index: 11)
            RankArt_upv_1 (copy, index: 12)
            Colors_upv_1 (copy, index: 13)
            Fonts_upv_1 (copy, index: 14)
        ]]
        local v1 = UI_upv_1.Window({HeaderHeight = 76, Subtitle = "A cheater in a recent match was banned", Name = "CheaterBanned", NoClose = true, Title = "LOSS FORGIVEN", Size = fromOffset_upv_1(540, 446), Parent = a1.Canvas.Menus, OnCloseRequested = close})
        u3 = v1
        u3.Title.TextColor3 = u1
        UI_upv_1.SelectionRing(u3.Root)
        local Content_1 = u3.Content
        local tbl_3 = {}
        tbl_3.Name = "Hero"
        tbl_3.Size = UDim2.new(1, 0, 0, 152)
        tbl_3.BackgroundColor3 = Color3.fromRGB(46, 36, 16)
        tbl_3.ClipsDescendants = true
        tbl_3[1], tbl_3[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Large), UI_upv_1.Gradient(ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 150)), nil, 90)
        tbl_3.Parent = Content_1
        local v2 = UI_upv_1.new("Frame", tbl_3)
        UI_upv_1.Stroke(u1, 1.5, 0.55).Parent = v2
        local v3 = UDim2.new(0.5, -88, 0.5, 0)
        tbl_upv_2.glow = UI_upv_1.Image(Assets_upv_1.Icons.Glow, {Name = "Glow", ImageTransparency = 0.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = v3, Size = fromOffset_upv_1(360, 360), ImageColor3 = u1, Parent = v2})
        tbl_upv_2.rays = UI_upv_1.Image(Assets_upv_1.Fx.Rays, {Name = "Rays", ImageTransparency = 0.82, AnchorPoint = Vector2.new(0.5, 0.5), Position = v3, Size = fromOffset_upv_1(420, 420), ImageColor3 = u2, Parent = v2})
        tbl_upv_2.fxLayer = UI_upv_1.new("Frame", {Name = "FxLayer", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = fromOffset_upv_1(0, 0), Parent = v2})
        tbl_upv_2.pool = Fx_upv_1.Pool(tbl_upv_2.fxLayer, 32, 4)
        local tbl_4 = {}
        tbl_4.Name = "Row"
        tbl_4.Size = UDim2.fromScale(1, 1)
        tbl_4.ZIndex = 3
        tbl_4[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 18, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
        tbl_4.Parent = v2
        local v4 = UI_upv_1.new("Frame", tbl_4)
        tbl_upv_2.trophyHolder = UI_upv_1.new("Frame", {LayoutOrder = 1, Name = "Trophy", ZIndex = 3, Size = fromOffset_upv_1(104, 104), Parent = v4})
        tbl_upv_2.trophyScale = UI_upv_1.new("UIScale", {Scale = 1, Parent = tbl_upv_2.trophyHolder})
        local v5 = RankArt_upv_1.Trophy(104, {ZIndex = 3, Parent = tbl_upv_2.trophyHolder})
        v5.Size = UDim2.fromScale(1, 1)
        local tbl_5 = {}
        tbl_5.Name = "Numbers"
        tbl_5.Size = fromOffset_upv_1(0, 100)
        tbl_5.AutomaticSize = Enum.AutomaticSize.X
        tbl_5.LayoutOrder = 2
        tbl_5.ZIndex = 3
        tbl_5[1] = UI_upv_1.List(Enum.FillDirection.Vertical, 0, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
        tbl_5.Parent = v4
        local v6 = UI_upv_1.new("Frame", tbl_5)
        tbl_upv_2.amount = UI_upv_1.DisplayText({LayoutOrder = 1, Text = "+0", StrokeThickness = 2, Name = "Amount", TextSize = 64, ZIndex = 3, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 66), TextColor3 = Colors_upv_1.Success, TextXAlignment = Enum.TextXAlignment.Left, Parent = v6})
        local tbl_6 = {}
        tbl_6.Name = "Returned"
        tbl_6.AutomaticSize = Enum.AutomaticSize.X
        tbl_6.Size = fromOffset_upv_1(0, 22)
        tbl_6.Text = "TROPHIES RETURNED"
        tbl_6.FontFace = Fonts_upv_1.Heavy
        tbl_6.TextSize = 18
        tbl_6.TextColor3 = u2
        tbl_6.TextXAlignment = Enum.TextXAlignment.Left
        tbl_6.LayoutOrder = 2
        tbl_6.ZIndex = 3
        tbl_6[1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.5)
        tbl_6.Parent = v6
        tbl_6.BackgroundTransparency = 1
        tbl_4 = UI_upv_1.new("TextLabel", tbl_6)
        tbl_upv_2.line = UI_upv_1.new("TextLabel", {Text = "", Name = "Line", TextWrapped = true, TextSize = 17, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 168), Size = UDim2.new(1, -16, 0, 44), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextYAlignment = Enum.TextYAlignment.Top, Parent = Content_1, BackgroundTransparency = 1})
        local tbl_7 = {}
        tbl_7.Name = "Rank"
        tbl_7.AnchorPoint = Vector2.new(0.5, 0)
        tbl_7.Position = UDim2.new(0.5, 0, 0, 222)
        tbl_7.Size = fromOffset_upv_1(0, 40)
        tbl_7.AutomaticSize = Enum.AutomaticSize.X
        tbl_7.BackgroundColor3 = Colors_upv_1.PanelHi
        tbl_7[1], tbl_7[2], tbl_7[3], tbl_7[4] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.86), UI_upv_1.Padding(0, 20, 0, 14), UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
        tbl_7.Parent = Content_1
        tbl_upv_2.rank = UI_upv_1.new("Frame", tbl_7)
        tbl_upv_2.emblem = RankArt_upv_1.Emblem(1, 28, {LayoutOrder = 1, Parent = tbl_upv_2.rank})
        tbl_upv_2.rankName = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Name = "Name", TextSize = 19, Text = "", AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 24), FontFace = Fonts_upv_1.Display, Parent = tbl_upv_2.rank, BackgroundTransparency = 1})
        RankArt_upv_1.Trophy(18, {LayoutOrder = 3, Parent = tbl_upv_2.rank})
        tbl_upv_2.rankTotal = UI_upv_1.new("TextLabel", {LayoutOrder = 4, Text = "", Name = "Total", TextSize = 19, AutomaticSize = Enum.AutomaticSize.X, Size = fromOffset_upv_1(0, 24), FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, Parent = tbl_upv_2.rank, BackgroundTransparency = 1})
        tbl_upv_2.ok = UI_upv_1.Button({Style = "Primary", Name = "Ok", Text = "NICE", TextSize = 20, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = fromOffset_upv_1(240, 56), Parent = Content_1})
        tbl_upv_2.ok.Activated:Connect(close)
    end
    local function paint()
        --[[
          name: paint
          line: 173
          upvalues:
            u4 (ref,  index: 1)
            tbl_upv_2 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            Ranks_upv_1 (copy, index: 4)
            RankArt_upv_1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            u8 (ref,  index: 7)
            a1 (copy, index: 8)
            u2 (copy, index: 9)
        ]]
        local u9 = math.max(0, math.floor(tonumber(u4.trophies) or 0))
        local v7 = math.max(1, math.floor(tonumber(u4.matches) or 1))
        local line_1 = tbl_upv_2.line
        line_1.Text = not (v7 > 1) and "A player who beat you in a recent match was banned for cheating. The trophies you lost to them have been returned." or ("A player who beat you in %* recent matches was banned for cheating. The trophies you lost to them have been returned."):format(v7)
        local v9 = tonumber(u4.total) or (tonumber((State_upv_1.Profile or {}).trophies) or 0)
        local u10 = math.floor(v9)
        local v10 = Ranks_upv_1.RankOf(u10)
        RankArt_upv_1.SetEmblem(tbl_upv_2.emblem, v10)
        tbl_upv_2.rankName.Text = string.upper(Ranks_upv_1.Get(v10).name)
        tbl_upv_2.rankName.TextColor3 = RankArt_upv_1.Color(v10)
        tbl_upv_2.rankTotal.Text = UI_upv_1.FormatNumber(u10)
        tbl_upv_2.amount.Text = "+0"
        u8 = u8 + 1
        u10 = u8
        tbl_upv_2.trophyScale.Scale = 0.75
        local tbl_8 = {Scale = 1}
        UI_upv_1.Tween(tbl_upv_2.trophyScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_8)
        task.spawn(
            function()
                --[[
                  line: 193
                  upvalues:
                    u9 (copy, index: 1)
                    u8 (ref,  index: 2)
                    u10 (copy, index: 3)
                    tbl_upv_2 (copy, index: 4)
                    a1 (copy, index: 5)
                    UI_upv_1 (copy, index: 6)
                    u2 (copy, index: 7)
                ]]
                task.wait(0.3)
                local v11 = math.clamp(u9, 1, 20)
                for n_1 = 1, v11 do
                    if u8 == u10 then
                        tbl_upv_2.amount.Text = ("+%*"):format(math.floor(((u9 * n_1) / v11) + 0.5))
                        task.wait(0.55 / v11)
                        continue
                    end
                    return
                end
                if u8 ~= u10 then
                    return
                end
                a1.Sounds.Play("Coin")
                UI_upv_1.Pop(tbl_upv_2.amount, 1.15)
                tbl_upv_2.pool:Burst(12, {drag = 2.2, life = 1.3, kind = "sparkle", speed = 200, mode = "point", grav = -30, size = 18, at = Vector2.new(-88, 0), color = u2})
            end
        )
    end
    local function stopLoops()
        --[[
          name: stopLoops
          line: 222
          upvalues:
            u8 (ref,  index: 1)
            u6 (ref,  index: 2)
            u7 (ref,  index: 3)
            tbl_upv_2 (copy, index: 4)
        ]]
        u8 = u8 + 1
        if u6 then
            u6:Disconnect()
            u6 = nil
        end
        if u7 then
            u7()
            u7 = nil
        end
        if not tbl_upv_2.pool then
            return
        end
        tbl_upv_2.pool:Clear()
    end
    local tbl_9 = {}
    local function hideOthers(a3)
        --[[
          name: hideOthers
          line: 214
          upvalues:
            a1 (copy, index: 1)
            MenuManager_upv_1 (copy, index: 2)
        ]]
        a1.SetHudHidden("LossForgiven", a3)
        MenuManager_upv_1.HoldChat("LossForgiven", a3)
        if not a1.TopbarSettings or type(a1.TopbarSettings.SetHidden) ~= "function" then
            return
        end
        pcall(a1.TopbarSettings.SetHidden, "LossForgiven", a3)
    end
    function tbl_9.open()
        --[[
          name: open
          line: 238
          upvalues:
            u3 (ref,  index: 1)
            build (copy, index: 2)
            paint (copy, index: 3)
            hideOthers (copy, index: 4)
            a1 (copy, index: 5)
            u6 (ref,  index: 6)
            RunService_upv_1 (copy, index: 7)
            tbl_upv_2 (copy, index: 8)
            u7 (ref,  index: 9)
            u2 (copy, index: 10)
        ]]
        if not (u3) then
            build()
        end
        paint()
        hideOthers(true)
        u3:Open()
        a1.Sounds.Play("Reward")
        local v12 = RunService_upv_1.RenderStepped:Connect(
            function(a4)
                --[[
                  line: 247
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                ]]
                tbl_upv_2.rays.Rotation = (tbl_upv_2.rays.Rotation + (a4 * 8)) % 360
            end
        )
        u6 = v12
        local v13 = tbl_upv_2.pool:Emit(3, {dir = -90, drag = 0.6, grav = -15, life = 1.8, jitter = 46, kind = "sparkle", speed = 60, mode = "point", spread = 35, size = 13, at = Vector2.new(-88, 20), color = u2})
        u7 = v13
    end
    function tbl_9.close(a5)
        --[[
          name: close
          line: 252
          upvalues:
            u8 (ref,  index: 1)
            u6 (ref,  index: 2)
            u7 (ref,  index: 3)
            tbl_upv_2 (copy, index: 4)
            hideOthers (copy, index: 5)
            u3 (ref,  index: 6)
        ]]
        u8 = u8 + 1
        if u6 then
            u6:Disconnect()
            u6 = nil
        end
        if u7 then
            u7()
            u7 = nil
        end
        if tbl_upv_2.pool then
            tbl_upv_2.pool:Clear()
        end
        hideOthers(false)
        if not u3 then
            return
        end
        u3:Close(a5)
    end
    function tbl_9.select()
        --[[
          name: select
          line: 259
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        if tbl_upv_2.ok then
            return tbl_upv_2.ok.Instance
        end
        return nil
    end
    MenuManager_upv_1.Register("CheaterBanned", tbl_9)
    local function blocked()
        --[[
          name: blocked
          line: 264
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v14 = true
        if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
            v14 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
        end
        return v14
    end
    local function canShow()
        --[[
          name: canShow
          line: 267
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            MenuManager_upv_1 (copy, index: 4)
        ]]
        local v15 = true
        if LocalPlayer_upv_1:GetAttribute("ReplayPlaying") ~= true then
            v15 = a1.IsHudHiddenFor("Intro") or (a1.IsHudHiddenFor("Celebrate"))
        end
        if not (v15) and State_upv_1.GetPlayerState() == "Lobby" and not (MenuManager_upv_1.IsOpen()) then
            if a1.RankUp and a1.RankUp.IsPlaying() or a1.DropReveal and type(a1.DropReveal.IsPlaying) == "function" and a1.DropReveal.IsPlaying() then
                return false
            end
            return true
        end
        return false
    end
    local function pump()
        --[[
          name: pump
          line: 280
          upvalues:
            u5 (ref,  index: 1)
            canShow (copy, index: 2)
            u4 (ref,  index: 3)
            MenuManager_upv_1 (copy, index: 4)
        ]]
        if not u5 or not canShow() then
            return
        end
        u4 = u5
        u5 = nil
        MenuManager_upv_1.Open("CheaterBanned")
    end
    task.spawn(
        function()
            --[[
              line: 287
              upvalues:
                u5 (ref,  index: 1)
                canShow (copy, index: 2)
                u4 (ref,  index: 3)
                MenuManager_upv_1 (copy, index: 4)
            ]]
            repeat
                task.wait(0.5)
            until u5
            if not canShow() then
                return
            end
            u4 = u5
            u5 = nil
            MenuManager_upv_1.Open("CheaterBanned")
        end
    )
    a1.Remotes.On(
        "CheaterBanned",
        function(a6)
            --[[
              line: 294
              upvalues:
                u5 (ref,  index: 1)
                canShow (copy, index: 2)
                u4 (ref,  index: 3)
                MenuManager_upv_1 (copy, index: 4)
            ]]
            if type(a6) ~= "table" then
                return
            end
            u5 = a6
            if not u5 or not canShow() then
                return
            end
            u4 = u5
            u5 = nil
            MenuManager_upv_1.Open("CheaterBanned")
        end
    )
    local tbl_10 = {}
    function tbl_10.IsPlaying()
        --[[
          name: IsPlaying
          line: 302
          upvalues:
            u5 (ref,  index: 1)
            MenuManager_upv_1 (copy, index: 2)
        ]]
        local v16 = true
        if u5 == nil then
            v16 = MenuManager_upv_1.IsOpen("CheaterBanned")
        end
        return v16
    end
    a1.LossForgiven = tbl_10
    a1.Debug.forgiven = function(a7, a8)
        --[[
          line: 307
          upvalues:
            u5 (ref,  index: 1)
            canShow (copy, index: 2)
            u4 (ref,  index: 3)
            MenuManager_upv_1 (copy, index: 4)
            tbl_upv_2 (copy, index: 5)
        ]]
        if a7 ~= nil then
            u5 = {trophies = a7, matches = a8}
            if u5 and canShow() then
                u4 = u5
                u5 = nil
                MenuManager_upv_1.Open("CheaterBanned")
            end
        end
        local tbl_11 = {rank = 0, line = 0, amount = 0}
        tbl_11.open = MenuManager_upv_1.IsOpen("CheaterBanned")
        local v17, v18
        if tbl_upv_2.amount then
            v17 = tbl_upv_2.amount.Text
            v18 = tbl_upv_2
        else
            v17, v18 = false, tbl_upv_2
        end
        tbl_11.amount = v17
        local v19
        if v18.line then
            v19 = v18.line.Text
        else
            v19 = false
        end
        tbl_11.line = v19
        tbl_11.rank = ((tbl_upv_2.rankName) and (v18.rankName.Text .. " " .. v18.rankTotal.Text)) or false
        return tbl_11
    end
end
return tbl_1