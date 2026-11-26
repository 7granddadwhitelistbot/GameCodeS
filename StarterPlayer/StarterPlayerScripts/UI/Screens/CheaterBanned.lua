local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local Ranks = require(replicatedStorage.Shared.Ranks)
local RankArt = require(script.Parent.Parent.RankArt)
local Fx = require(script.Parent.Parent.Fx)
local v7 = {}
local color3 = Color3.fromRGB(255, 206, 92)
local color32 = Color3.fromRGB(255, 236, 170)

function v7.Init(a10)
    --[[
      name: Init
      line: 32
      upvalues:
        players (copy, index: 1)
        color3 (copy, index: 2)
        color32 (copy, index: 3)
        Fx (copy, index: 4)
        RankArt (copy, index: 5)
        Ranks (copy, index: 6)
        runService (copy, index: 7)
    ]]
    local ui = a10.UI
    local theme = a10.Theme
    local state = a10.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local menuManager = a10.MenuManager
    local udim2FromOffset = UDim2.fromOffset
    local assets = ui.Assets
    local localPlayer = players.LocalPlayer
    local v20 = nil
    local v21 = {}
    local v22 = {trophies = 0, matches = 1}
    local v23 = nil
    local renderSteppedConnection = nil
    local v25 = nil
    local count = 0

    local function close()
        --[[
          name: close
          line: 48
          upvalues:
            menuManager (copy, index: 1)
        ]]
        menuManager.Close("CheaterBanned")
    end

    local function text(a29)
        --[[
          name: text
          line: 52
          upvalues:
            ui (copy, index: 1)
        ]]
        a29.BackgroundTransparency = 1
        return ui.new("TextLabel", a29)
    end

    local function build()
        --[[
          name: build
          line: 57
          upvalues:
            v20 (ref,  index: 1)
            ui (copy, index: 2)
            udim2FromOffset (copy, index: 3)
            a10 (copy, index: 4)
            close (copy, index: 5)
            color3 (copy, index: 6)
            theme (copy, index: 7)
            v21 (copy, index: 8)
            assets (copy, index: 9)
            color32 (copy, index: 10)
            Fx (copy, index: 11)
            RankArt (copy, index: 12)
            colors (copy, index: 13)
            fonts (copy, index: 14)
        ]]
        v20 = ui.Window({Name = "CheaterBanned", Title = "LOSS FORGIVEN", Subtitle = "A cheater in a recent match was banned", HeaderHeight = 76, NoClose = true, Size = udim2FromOffset(540, 446), Parent = a10.Canvas.Menus, OnCloseRequested = close})
        v20.Title.TextColor3 = color3
        ui.SelectionRing(v20.Root)
        local content = v20.Content
        local parent = ui.new("Frame", {Name = "Hero", Size = UDim2.new(1, 0, 0, 152), BackgroundColor3 = Color3.fromRGB(46, 36, 16), ClipsDescendants = true, ui.Corner(theme.Radius.Large), (ui.Gradient(ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 150)), nil, 90)), Parent = content})
        ui.Stroke(color3, 1.5, 0.55).Parent = parent
        local position = UDim2.new(0.5, -88, 0.5, 0)
        v21.glow = ui.Image(assets.Icons.Glow, {Name = "Glow", ImageTransparency = 0.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = position, Size = udim2FromOffset(360, 360), ImageColor3 = color3, Parent = parent})
        v21.rays = ui.Image(assets.Fx.Rays, {Name = "Rays", ImageTransparency = 0.82, AnchorPoint = Vector2.new(0.5, 0.5), Position = position, Size = udim2FromOffset(420, 420), ImageColor3 = color32, Parent = parent})
        v21.fxLayer = ui.new("Frame", {Name = "FxLayer", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset(0, 0), Parent = parent})
        v21.pool = Fx.Pool(v21.fxLayer, 32, 4)
        local parent2 = ui.new("Frame", {Name = "Row", Size = UDim2.fromScale(1, 1), ZIndex = 3, (ui.List(Enum.FillDirection.Horizontal, 18, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent})
        v21.trophyHolder = ui.new("Frame", {Name = "Trophy", LayoutOrder = 1, ZIndex = 3, Size = udim2FromOffset(104, 104), Parent = parent2})
        v21.trophyScale = ui.new("UIScale", {Scale = 1, Parent = v21.trophyHolder})
        RankArt.Trophy(104, {ZIndex = 3, Parent = v21.trophyHolder}).Size = UDim2.fromScale(1, 1)
        local parent3 = ui.new("Frame", {Name = "Numbers", Size = udim2FromOffset(0, 100), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = 2, ZIndex = 3, (ui.List(Enum.FillDirection.Vertical, 0, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent2})
        v21.amount = ui.DisplayText({Name = "Amount", Text = "+0", TextSize = 64, LayoutOrder = 1, ZIndex = 3, StrokeThickness = 2, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 66), TextColor3 = colors.Success, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent3})
        local v36 = {Name = "Returned", AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 22), Text = "TROPHIES RETURNED", FontFace = fonts.Heavy, TextSize = 18, TextColor3 = color32, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 2, ZIndex = 3, (ui.TextStroke(colors.Void, 1.5, 0.5))}
        v36.Parent = parent3
        v36.BackgroundTransparency = 1
        ui.new("TextLabel", v36)
        local v37 = {Name = "Line", Text = "", TextSize = 17, TextWrapped = true, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 168), Size = UDim2.new(1, -16, 0, 44), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextYAlignment = Enum.TextYAlignment.Top, Parent = content, BackgroundTransparency = 1}
        v21.line = ui.new("TextLabel", v37)
        v21.rank = ui.new("Frame", {Name = "Rank", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 222), Size = udim2FromOffset(0, 40), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.PanelHi, ui.Corner(theme.Radius.Pill), ui.Stroke(colors.Stroke, 1, 0.86), ui.Padding(0, 20, 0, 14), (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = content})
        v21.emblem = RankArt.Emblem(1, 28, {LayoutOrder = 1, Parent = v21.rank})
        local v38 = {Name = "Name", Text = "", TextSize = 19, LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 24), FontFace = fonts.Display, Parent = v21.rank, BackgroundTransparency = 1}
        v21.rankName = ui.new("TextLabel", v38)
        RankArt.Trophy(18, {LayoutOrder = 3, Parent = v21.rank})
        local v39 = {Name = "Total", Text = "", TextSize = 19, LayoutOrder = 4, AutomaticSize = Enum.AutomaticSize.X, Size = udim2FromOffset(0, 24), FontFace = fonts.Display, TextColor3 = colors.Text, Parent = v21.rank, BackgroundTransparency = 1}
        v21.rankTotal = ui.new("TextLabel", v39)
        v21.ok = ui.Button({Name = "Ok", Text = "NICE", TextSize = 20, Style = "Primary", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = udim2FromOffset(240, 56), Parent = content})
        v21.ok.Activated:Connect(close)
    end

    local function paint()
        --[[
          name: paint
          line: 173
          upvalues:
            v22 (ref,  index: 1)
            v21 (copy, index: 2)
            state (copy, index: 3)
            Ranks (copy, index: 4)
            RankArt (copy, index: 5)
            ui (copy, index: 6)
            count (ref,  index: 7)
            a10 (copy, index: 8)
            color32 (copy, index: 9)
        ]]
        local formattedText
        local v42 = math.max(0, (math.floor((tonumber(v22.trophies) or 0))))
        local v43 = math.max(1, (math.floor((tonumber(v22.matches) or 1))))
        local line = v21.line

        if not (1 < v43) then
            formattedText = "A player who beat you in a recent match was banned for cheating. The trophies you lost to them have been returned."
        else
            formattedText = `A player who beat you in {v43} recent matches was banned for cheating. The trophies you lost to them have been returned.`
        end

        line.Text = formattedText
        local v45 = state.Profile or {}
        local number = tonumber(v22.total) or tonumber(v45.trophies) or 0
        local v47 = math.floor(number)
        local v48 = Ranks.RankOf(v47)
        RankArt.SetEmblem(v21.emblem, v48)
        v21.rankName.Text = string.upper(Ranks.Get(v48).name)
        v21.rankName.TextColor3 = RankArt.Color(v48)
        v21.rankTotal.Text = ui.FormatNumber(v47)
        v21.amount.Text = "+0"
        count += 1
        v47 = count
        v21.trophyScale.Scale = 0.75
        local v49 = {Scale = 1}
        ui.Tween(v21.trophyScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v49)

        task.spawn(
            function()
                --[[
                  line: 193
                  upvalues:
                    v42 (copy, index: 1)
                    count (ref,  index: 2)
                    v47 (copy, index: 3)
                    v21 (copy, index: 4)
                    a10 (copy, index: 5)
                    ui (copy, index: 6)
                    color32 (copy, index: 7)
                ]]
                task.wait(0.3)
                local clampedValue = math.clamp(v42, 1, 20)

                for index = 1, clampedValue do
                    if count ~= v47 then
                        return
                    end

                    v21.amount.Text = `+{(math.floor(((v42 * index) / clampedValue) + 0.5))}`
                    task.wait(0.55 / clampedValue)
                end

                if count ~= v47 then
                    return
                end

                a10.Sounds.Play("Coin")
                ui.Pop(v21.amount, 1.15)
                v21.pool:Burst(12, {mode = "point", kind = "sparkle", speed = 200, size = 18, life = 1.3, grav = -30, drag = 2.2, at = Vector2.new(-88, 0), color = color32})
            end
        )
    end

    local function hideOthers(a53: boolean)
        --[[
          name: hideOthers
          line: 214
          upvalues:
            a10 (copy, index: 1)
            menuManager (copy, index: 2)
        ]]
        a10.SetHudHidden("LossForgiven", a53)
        menuManager.HoldChat("LossForgiven", a53)

        if a10.TopbarSettings and type(a10.TopbarSettings.SetHidden) == "function" then
            pcall(a10.TopbarSettings.SetHidden, "LossForgiven", a53)
        end
    end

    local function stopLoops()
        --[[
          name: stopLoops
          line: 222
          upvalues:
            count (ref,  index: 1)
            renderSteppedConnection (ref,  index: 2)
            v25 (ref,  index: 3)
            v21 (copy, index: 4)
        ]]
        count += 1

        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end

        if v25 then
            v25()
            v25 = nil
        end

        if v21.pool then
            v21.pool:Clear()
        end
    end

    menuManager.Register(
        "CheaterBanned",
        {
            open = (function()
                --[[
                  name: open
                  line: 238
                  upvalues:
                    v20 (ref,  index: 1)
                    build (copy, index: 2)
                    paint (copy, index: 3)
                    hideOthers (copy, index: 4)
                    a10 (copy, index: 5)
                    renderSteppedConnection (ref,  index: 6)
                    runService (copy, index: 7)
                    v21 (copy, index: 8)
                    v25 (ref,  index: 9)
                    color32 (copy, index: 10)
                ]]
                if not v20 then
                    build()
                end

                paint()
                hideOthers(true)
                v20:Open()
                a10.Sounds.Play("Reward")
                renderSteppedConnection = runService.RenderStepped:Connect(
                    function(deltaTime: number)
                        --[[
                          line: 247
                          upvalues:
                            v21 (copy, index: 1)
                        ]]
                        v21.rays.Rotation = (v21.rays.Rotation + (deltaTime * 8)) % 360
                    end
                )
                v25 = v21.pool:Emit(3, {mode = "point", jitter = 46, kind = "sparkle", dir = -90, spread = 35, speed = 60, size = 13, life = 1.8, grav = -15, drag = 0.6, at = Vector2.new(-88, 20), color = color32})
            end),
            close = (function(a56)
                --[[
                  name: close
                  line: 252
                  upvalues:
                    count (ref,  index: 1)
                    renderSteppedConnection (ref,  index: 2)
                    v25 (ref,  index: 3)
                    v21 (copy, index: 4)
                    hideOthers (copy, index: 5)
                    v20 (ref,  index: 6)
                ]]
                count += 1

                if renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                if v25 then
                    v25()
                    v25 = nil
                end

                if v21.pool then
                    v21.pool:Clear()
                end

                hideOthers(false)

                if v20 then
                    v20:Close(a56)
                end
            end),
            select = (function()
                --[[
                  name: select
                  line: 259
                  upvalues:
                    v21 (copy, index: 1)
                ]]
                if v21.ok then
                    return v21.ok.Instance
                end

                return nil
            end)
        }
    )

    local function blocked()
        --[[
          name: blocked
          line: 264
          upvalues:
            localPlayer (copy, index: 1)
            a10 (copy, index: 2)
        ]]
        return localPlayer:GetAttribute("ReplayPlaying") == true
            or a10.IsHudHiddenFor("Intro")
            or a10.IsHudHiddenFor("Celebrate")
    end

    local function canShow()
        --[[
          name: canShow
          line: 267
          upvalues:
            localPlayer (copy, index: 1)
            a10 (copy, index: 2)
            state (copy, index: 3)
            menuManager (copy, index: 4)
        ]]
        local v59 = localPlayer:GetAttribute("ReplayPlaying") == true
            or a10.IsHudHiddenFor("Intro")
            or a10.IsHudHiddenFor("Celebrate")

        if v59 or state.GetPlayerState() ~= "Lobby" or menuManager.IsOpen() then
            return false
        end

        if a10.RankUp then
            if a10.RankUp.IsPlaying() then
                return false
            end
        end

        if a10.DropReveal and type(a10.DropReveal.IsPlaying) == "function" and a10.DropReveal.IsPlaying() then
            return false
        end

        return true
    end

    local function pump()
        --[[
          name: pump
          line: 280
          upvalues:
            v23 (ref,  index: 1)
            canShow (copy, index: 2)
            v22 (ref,  index: 3)
            menuManager (copy, index: 4)
        ]]
        if v23 and canShow() then
            v22 = v23
            v23 = nil
            menuManager.Open("CheaterBanned")
        end
    end

    task.spawn(
        function()
            --[[
              line: 287
              upvalues:
                v23 (ref,  index: 1)
                canShow (copy, index: 2)
                v22 (ref,  index: 3)
                menuManager (copy, index: 4)
            ]]
            while true do
                task.wait(0.5)

                if v23 then
                    if not canShow() then
                        continue
                    end

                    v22 = v23
                    v23 = nil
                    menuManager.Open("CheaterBanned")
                end
            end
        end
    )

    a10.Remotes.On(
        "CheaterBanned",
        function(a61)
            --[[
              line: 294
              upvalues:
                v23 (ref,  index: 1)
                canShow (copy, index: 2)
                v22 (ref,  index: 3)
                menuManager (copy, index: 4)
            ]]
            if type(a61) == "table" then
                v23 = a61

                if v23 and canShow() then
                    v22 = v23
                    v23 = nil
                    menuManager.Open("CheaterBanned")
                end
            end
        end
    )

    a10.LossForgiven = {
        IsPlaying = (function()
            --[[
              name: IsPlaying
              line: 302
              upvalues:
                v23 (ref,  index: 1)
                menuManager (copy, index: 2)
            ]]
            return v23 ~= nil or menuManager.IsOpen("CheaterBanned")
        end)
    }

    a10.Debug.forgiven = function(trophies, matches)
        --[[
          line: 307
          upvalues:
            v23 (ref,  index: 1)
            canShow (copy, index: 2)
            v22 (ref,  index: 3)
            menuManager (copy, index: 4)
            v21 (copy, index: 5)
        ]]
        if trophies ~= nil then
            v23 = {trophies = trophies, matches = matches}

            if v23 and canShow() then
                v22 = v23
                v23 = nil
                menuManager.Open("CheaterBanned")
            end
        end

        local v64 = {open = menuManager.IsOpen("CheaterBanned"), amount = if v21.amount then v21.amount.Text else false, line = if v21.line then v21.line.Text else false, rank = if v21.rankName then v21.rankName.Text .. " " .. v21.rankTotal.Text else false}
        return v64
    end
end

return v7