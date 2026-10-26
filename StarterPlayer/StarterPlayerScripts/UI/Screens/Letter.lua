local GuiService_upv_1 = game:GetService("GuiService")
local RunService_upv_1 = game:GetService("RunService")
local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local StarterGui_upv_1 = game:GetService("StarterGui")
local TextChatService_upv_1 = game:GetService("TextChatService")
local Letters_1 = require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Letters"))
local tbl_1 = {}
local u1 = Color3.fromRGB(240, 228, 200)
local u2 = Color3.fromRGB(222, 202, 162)
local u3 = Color3.fromRGB(46, 34, 26)
local u4 = Font.fromEnum(Enum.Font.PatrickHand)
local u5 = Letters_1.Current()
local tbl_upv_2 = {}
tbl_upv_2.heading = u5.heading
tbl_upv_2.body = u5.body
tbl_upv_2.signature = u5.signature
local author_upv_1 = u5.author
local u6 = Color3.fromRGB(226, 208, 170)
local u7 = Color3.fromRGB(216, 196, 154)
local u8 = u6:Lerp(u3, 0.3)
local u9 = Color3.fromRGB(66, 50, 38)
local u10 = Color3.fromRGB(80, 62, 47)
local u11 = Color3.fromRGB(212, 158, 70)
local u12 = Color3.fromRGB(246, 234, 208)
local u13 = nil
local function hideChat()
    --[[
      name: hideChat
      line: 58
      upvalues:
        u13 (ref, index: 1)
    ]]
    if u13 then
        return
    end
    local tbl_3 = {}
    pcall(function() end)
    u13 = tbl_3
end
local function restoreChat()
    --[[
      name: restoreChat
      line: 79
      upvalues:
        u13 (ref, index: 1)
    ]]
    local v1 = u13
    if not v1 then
        return
    end
    u13 = nil
    pcall(function() end)
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 100
      upvalues:
        u2 (copy, index: 1)
        u1 (copy, index: 2)
        u4 (copy, index: 3)
        u3 (copy, index: 4)
        tbl_upv_2 (copy, index: 5)
        Players_upv_1 (copy, index: 6)
        author_upv_1 (copy, index: 7)
        u5 (copy, index: 8)
        u6 (copy, index: 9)
        u8 (copy, index: 10)
        ReplicatedStorage_upv_1 (copy, index: 11)
        u10 (ref,  index: 12)
        u9 (ref,  index: 13)
        u7 (copy, index: 14)
        u11 (ref,  index: 15)
        u12 (ref,  index: 16)
        RunService_upv_1 (copy, index: 17)
        GuiService_upv_1 (copy, index: 18)
        u13 (ref,  index: 19)
        TextChatService_upv_1 (copy, index: 20)
        StarterGui_upv_1 (copy, index: 21)
    ]]
    local UI_upv_1 = a1.UI
    local u14 = UI_upv_1.new("Frame", {Visible = false, Name = "Letter", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Menus})
    local tbl_4 = {Name = "Outside", AutoButtonColor = false, Selectable = false, Text = "", BackgroundTransparency = 1}
    tbl_4.Size = UDim2.fromScale(1, 1)
    tbl_4.Parent = u14
    UI_upv_1.new("TextButton", tbl_4).Activated:Connect(
        function()
            --[[
              line: 115
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.MenuManager.Close("Letter")
        end
    )
    local u15 = UI_upv_1.new("Frame", {Name = "Sheet", Rotation = -0.8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(640, 420), Parent = u14})
    UI_upv_1.new("Frame", {Name = "Shadow", Position = UDim2.fromOffset(10, 14), Size = UDim2.fromScale(1, 1), BackgroundColor3 = a1.Theme.Colors.Void, BackgroundTransparency = 0.55, [1] = UI_upv_1.Corner(UDim.new(0, 10)), Parent = u15})
    local tbl_5 = {}
    tbl_5.Name = "Paper"
    tbl_5.Size = UDim2.fromScale(1, 1)
    tbl_5.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_5.Text = ""
    tbl_5.AutoButtonColor = false
    tbl_5.Selectable = false
    tbl_5[1], tbl_5[2] = UI_upv_1.Corner(UDim.new(0, 10)), UI_upv_1.Stroke(u2, 2, 0.1)
    tbl_5.Parent = u15
    local v2 = UI_upv_1.new("TextButton", tbl_5)
    UI_upv_1.new("UIGradient", {Rotation = 70, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, u1), ColorSequenceKeypoint.new(0.7, u1:Lerp(u2, 0.25)), ColorSequenceKeypoint.new(1, u2)}), Parent = v2})
    v2.Activated:Connect(function()
        --[[
          line: 158
        ]]
    end)
    local u16 = UI_upv_1.new("Frame", {Name = "Body", Size = UDim2.fromScale(1, 1), [1] = UI_upv_1.Padding(40, 46, 30, 46), Parent = v2})
    UI_upv_1.new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 18), Parent = u16})
    local function line(a2, a3, a4, a5)
        --[[
          name: line
          line: 167
          upvalues:
            UI_upv_1 (copy, index: 1)
            u4 (copy, index: 2)
            u3 (copy, index: 3)
            u16 (copy, index: 4)
        ]]
        return UI_upv_1.new("TextLabel", {TextWrapped = true, Name = a2, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = a3, FontFace = u4, TextSize = a4, TextColor3 = u3, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = a5, Parent = u16})
    end
    line("Heading", tbl_upv_2.heading, 52, 1)
    for key_1, value_1 in tbl_upv_2.body do
        line("Para" .. key_1, value_1, 34, 1 + key_1)
    end
    local v3 = UI_upv_1.new("Frame", {LayoutOrder = 10, Name = "Signature", Size = UDim2.new(1, 0, 0, 72), Parent = u16})
    local v4 = UI_upv_1.new("Frame", {Name = "Sign", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(0, 72), AutomaticSize = Enum.AutomaticSize.X, Parent = v3})
    UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = v4})
    UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Name", TextSize = 46, Size = UDim2.fromOffset(0, 60), AutomaticSize = Enum.AutomaticSize.X, Text = tbl_upv_2.signature, FontFace = u4, TextColor3 = u3, Parent = v4})
    local tbl_6 = {}
    tbl_6.Name = "Headshot"
    tbl_6.Size = UDim2.fromOffset(68, 68)
    tbl_6.BackgroundColor3 = u2
    tbl_6.Image = ""
    tbl_6.LayoutOrder = 2
    tbl_6[1], tbl_6[2] = UI_upv_1.Corner(UDim.new(1, 0)), UI_upv_1.Stroke(u3, 2, 0.35)
    tbl_6.Parent = v4
    local u17 = UI_upv_1.new("ImageLabel", tbl_6)
    task.spawn(
        function()
            --[[
              line: 230
              upvalues:
                Players_upv_1 (copy, index: 1)
                author_upv_1 (copy, index: 2)
                u17 (copy, index: 3)
            ]]
            local success_1, v5 = pcall(
                function()
                    --[[
                      line: 231
                      upvalues:
                        Players_upv_1 (copy, index: 1)
                        author_upv_1 (copy, index: 2)
                    ]]
                    return Players_upv_1:GetUserThumbnailAsync(author_upv_1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                end
            )
            if not success_1 or type(v5) ~= "string" then
                return
            end
            u17.Image = v5
        end
    )
    local Remotes_upv_1 = a1.Remotes
    local State_upv_1 = a1.State
    local id_upv_1 = u5.id
    local u18 = u5.reactions ~= false
    local u19 = UI_upv_1.new("TextButton", {Name = "Reaction", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -8, 0.5, 0), Size = UDim2.fromOffset(0, 72), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Visible = u18, [1] = UI_upv_1.Padding(0, 8, 0, 8), Parent = v3})
    UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = u19})
    local u20 = UI_upv_1.new("Frame", {Name = "Pill", Size = UDim2.fromOffset(0, 54), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = u6, [1] = UI_upv_1.Corner(UDim.new(1, 0)), Parent = u19})
    local u21 = UI_upv_1.Stroke(u8, 1.5, 0)
    u21.Parent = u20
    local u22 = UI_upv_1.Padding(0, 18, 0, 14)
    u22.Parent = u20
    UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = u20})
    local u23 = UI_upv_1.GetScaleObj(u20, "HoverScale")
    local v6 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Icon", Text = "\240\159\145\141", TextSize = 34, Size = UDim2.fromOffset(38, 38), TextColor3 = u3, Parent = u20})
    local u24 = v6
    local u25 = UI_upv_1.GetScaleObj(u24, "PopScale")
    local u26 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "", Name = "Count", Visible = false, TextSize = 27, Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, FontFace = a1.Theme.Fonts.Bold, TextColor3 = u3, Parent = u20})
    local u27 = nil
    local u28 = false
    local u29 = false
    local u30 = -math.huge
    local u31 = false
    local u32 = false
    local u33 = nil
    local tbl_upv_7 = {}
    local u34 = nil
    local function valueObj()
        --[[
          name: valueObj
          line: 322
          upvalues:
            u33 (ref,  index: 1)
            ReplicatedStorage_upv_1 (copy, index: 2)
            id_upv_1 (copy, index: 3)
            tbl_upv_7 (ref,  index: 4)
            u34 (ref,  index: 5)
        ]]
        if u33 and u33.Parent then
            return u33
        end
        local LetterReactions_1 = ReplicatedStorage_upv_1:FindFirstChild("LetterReactions")
        local v7 = LetterReactions_1 and (LetterReactions_1:FindFirstChild(id_upv_1))
        if v7 and v7:IsA("IntValue") and v7 ~= u33 then
            u33 = v7
            for _, value_2 in tbl_upv_7 do
                value_2:Disconnect()
            end
            tbl_upv_7 = {
                LetterReactions_1.Changed:Connect(
                    function()
                        --[[
                          line: 334
                          upvalues:
                            u34 (ref, index: 1)
                        ]]
                        u34()
                    end
                ),
                LetterReactions_1:GetAttributeChangedSignal("Ready"):Connect(
                    function()
                        --[[
                          line: 337
                          upvalues:
                            u34 (ref, index: 1)
                        ]]
                        u34()
                    end
                )
            }
        end
        if u33 and u33.Parent then
            return u33
        end
        return nil
    end
    local function profileReacted()
        --[[
          name: profileReacted
          line: 345
          upvalues:
            State_upv_1 (copy, index: 1)
            id_upv_1 (copy, index: 2)
        ]]
        local v8 = State_upv_1.Profile and (State_upv_1.Profile.reactions)
        local v9 = false
        if type(v8) == "table" then
            v9 = v8[id_upv_1] == true
        end
        return v9
    end
    local function shownCount()
        --[[
          name: shownCount
          line: 351
          upvalues:
            valueObj (copy, index: 1)
            u27 (ref,  index: 2)
            u28 (ref,  index: 3)
        ]]
        local v10 = valueObj()
        local v11 = ((not v10) and 0) or (v10.Value)
        local v12 = (v10 ~= nil) and (v10:GetAttribute("Ready") == true)
        if u27 ~= nil and u28 ~= u27 then
            local _ = u28 and 1 or -1
            v11 = v11 + (u28 and 1 or -1)
        end
        return math.max(0, v11), v12
    end
    local function formatCount(a6)
        --[[
          name: formatCount
          line: 361
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        if a6 >= 1e+05 then
            return (UI_upv_1.FormatCompact(a6))
        end
        return (UI_upv_1.FormatNumber(a6))
    end
    u34 = function()
        --[[
          line: 365
          upvalues:
            valueObj (copy, index: 1)
            u27 (ref,  index: 2)
            u28 (ref,  index: 3)
            u26 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u22 (copy, index: 6)
            u20 (copy, index: 7)
            u32 (ref,  index: 8)
            u10 (ref,  index: 9)
            u9 (ref,  index: 10)
            u7 (copy, index: 11)
            u6 (copy, index: 12)
            u21 (copy, index: 13)
            u11 (ref,  index: 14)
            u8 (copy, index: 15)
            u12 (ref,  index: 16)
            u3 (copy, index: 17)
        ]]
        local v13 = valueObj()
        local v14 = ((not v13) and 0) or (v13.Value)
        local v15 = (v13 ~= nil) and (v13:GetAttribute("Ready") == true)
        if u27 ~= nil and u28 ~= u27 then
            local _ = u28 and 1 or -1
            v14 = v14 + (u28 and 1 or -1)
        end
        local v16 = math.max(0, v14)
        v13 = v15 and (v16 > 0)
        local v17
        if v16 >= 1e+05 then
            v17 = UI_upv_1.FormatCompact(v16)
        else
            v17 = UI_upv_1.FormatNumber(v16)
        end
        u26.Text = v17
        u26.Visible = v13
        local new_1 = UDim.new
        local v18
        if v13 then
            v18 = 18
        else
            v18 = 14
        end
        u22.PaddingRight = new_1(0, v18)
        local v19 = u28
        local v20
        if v19 then
            if u32 then
                v20 = u10
            else
                v20 = u9
            end
        elseif u32 then
            v20 = u7
        else
            v20 = u6
        end
        u20.BackgroundColor3 = v20
        local v21
        if u28 then
            v21 = u11
        else
            v21 = u8
        end
        u21.Color = v21
        u21.Thickness = (v19 and 2) or 1.5
        if u28 then
            v21 = u12
        else
            v21 = u3
        end
        u26.TextColor3 = v21
    end
    local u35 = nil
    u35 = function()
        --[[
          line: 379
          upvalues:
            u29 (ref,  index: 1)
            u18 (copy, index: 2)
            u27 (ref,  index: 3)
            u28 (ref,  index: 4)
            u30 (ref,  index: 5)
            u31 (ref,  index: 6)
            u35 (ref,  index: 7)
            Remotes_upv_1 (copy, index: 8)
            id_upv_1 (copy, index: 9)
            u34 (ref,  index: 10)
        ]]
        if (u29) or not u18 or u27 == nil then
            return
        end
        if u28 ~= u27 then
            local v22 = u30 + 0.25 - os.clock()
            if v22 > 0 then
                if not (u31) then
                    u31 = true
                    task.delay(
                        v22,
                        function()
                            --[[
                              line: 387
                              upvalues:
                                u31 (ref, index: 1)
                                u35 (ref, index: 2)
                            ]]
                            u31 = false
                            u35()
                        end
                    )
                end
            else
                u29 = true
                u30 = os.clock()
                local u36 = u28
                task.spawn(
                    function()
                        --[[
                          line: 397
                          upvalues:
                            Remotes_upv_1 (copy, index: 1)
                            id_upv_1 (copy, index: 2)
                            u36 (copy, index: 3)
                            u29 (ref,  index: 4)
                            u27 (ref,  index: 5)
                            u28 (ref,  index: 6)
                            u34 (ref,  index: 7)
                            u35 (ref,  index: 8)
                        ]]
                        local v23, v24, v25 = Remotes_upv_1.Invoke("LetterAction", "React", id_upv_1, u36)
                        u29 = false
                        if (v23) and type(v25) == "boolean" then
                            u27 = v25
                            if v24 ~= true and u28 == u36 then
                                u28 = v25
                            end
                        elseif u28 == u36 then
                            u28 = u27
                        end
                        u34()
                        u35()
                    end
                )
            end
        end
    end
    local function pop(a7)
        --[[
          name: pop
          line: 413
          upvalues:
            u25 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u26 (copy, index: 4)
        ]]
        if a7 then
            u25.Scale = 1
            local tbl_8 = {Scale = 1.45}
            UI_upv_1.Tween(u25, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_8)
            task.delay(
                0.08,
                function()
                    --[[
                      line: 417
                      upvalues:
                        UI_upv_1 (copy, index: 1)
                        u25 (copy, index: 2)
                    ]]
                    local tbl_9 = {Scale = 1}
                    UI_upv_1.Tween(u25, TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_9)
                end
            )
        else
            u25.Scale = 0.8
            UI_upv_1.Tween(u25, a1.Theme.Tween.PopSmall, {Scale = 1})
        end
        if not u26.Visible then
            return
        end
        UI_upv_1.Bump(u26, 0.16)
    end
    local function tap()
        --[[
          name: tap
          line: 429
          upvalues:
            u18 (copy, index: 1)
            u27 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            id_upv_1 (copy, index: 4)
            u28 (ref,  index: 5)
            a1 (copy, index: 6)
            u34 (ref,  index: 7)
            pop (copy, index: 8)
            u35 (ref,  index: 9)
        ]]
        if not u18 then
            return
        end
        if u27 == nil then
            local v26 = State_upv_1.Profile and (State_upv_1.Profile.reactions)
            local v27 = false
            if type(v26) == "table" then
                v27 = v26[id_upv_1] == true
            end
            u27 = v27
            u28 = u27
        end
        u28 = not u28
        a1.Sounds.Play("Click")
        u34()
        pop(u28)
        u35()
    end
    u19.Activated:Connect(tap)
    u19.MouseEnter:Connect(
        function()
            --[[
              line: 444
              upvalues:
                UI_upv_1 (copy, index: 1)
                u32 (ref,  index: 2)
                u23 (copy, index: 3)
                a1 (copy, index: 4)
                u34 (ref,  index: 5)
            ]]
            if UI_upv_1.Touch then
                return
            end
            u32 = true
            UI_upv_1.Tween(u23, a1.Theme.Tween.PopSmall, {Scale = 1.05})
            u34()
        end
    )
    u19.MouseLeave:Connect(
        function()
            --[[
              line: 452
              upvalues:
                u32 (ref,  index: 1)
                UI_upv_1 (copy, index: 2)
                u23 (copy, index: 3)
                a1 (copy, index: 4)
                u34 (ref,  index: 5)
            ]]
            u32 = false
            UI_upv_1.Tween(u23, a1.Theme.Tween.PopSmall, {Scale = 1})
            u34()
        end
    )
    u19.MouseButton1Down:Connect(
        function()
            --[[
              line: 457
              upvalues:
                UI_upv_1 (copy, index: 1)
                u23 (copy, index: 2)
                a1 (copy, index: 3)
            ]]
            UI_upv_1.Tween(u23, a1.Theme.Tween.Instant, {Scale = 0.93})
        end
    )
    u19.MouseButton1Up:Connect(
        function()
            --[[
              line: 460
              upvalues:
                UI_upv_1 (copy, index: 1)
                u23 (copy, index: 2)
                a1 (copy, index: 3)
                u32 (ref,  index: 4)
            ]]
            local Tween_1 = UI_upv_1.Tween
            local PopSmall_1 = a1.Theme.Tween.PopSmall
            local tbl_10 = {Scale = 0}
            tbl_10.Scale = (u32 and 1.05) or 1
            Tween_1(u23, PopSmall_1, tbl_10)
        end
    )
    task.spawn(
        function()
            --[[
              line: 464
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
                id_upv_1 (copy, index: 2)
                u34 (ref,  index: 3)
            ]]
            local v28 = ReplicatedStorage_upv_1:WaitForChild("LetterReactions", 30)
            if v28 then
                v28:WaitForChild(id_upv_1, 30)
            end
            u34()
        end
    )
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 471
              upvalues:
                u29 (ref,  index: 1)
                u28 (ref,  index: 2)
                u27 (ref,  index: 3)
                State_upv_1 (copy, index: 4)
                id_upv_1 (copy, index: 5)
                u34 (ref,  index: 6)
            ]]
            if (u29) then
                return
            end
            if u28 == u27 then
                local v29 = State_upv_1.Profile and (State_upv_1.Profile.reactions)
                local v30 = false
                if type(v29) == "table" then
                    v30 = v29[id_upv_1] == true
                end
                u27 = v30
                u28 = u27
                u34()
            end
        end
    )
    local v31 = nil
    if State_upv_1.HasProfile then
        v31 = State_upv_1.Profile and (State_upv_1.Profile.reactions)
        u27 = false
        if type(v31) == "table" then
            if v31[id_upv_1] == true then
                u27 = true
            else
                u27 = false
            end
        end
    else
        u27 = nil
    end
    if u27 == true then
        u28 = true
    else
        u28 = false
    end
    u34()
    local function watch(a8)
        --[[
          name: watch
          line: 484
          upvalues:
            u18 (copy, index: 1)
        ]]
        if not u18 then
            return
        end
        task.spawn(function() end)
    end
    a1.Debug.letter = function(a9, a10)
        --[[
          line: 498
          upvalues:
            u18 (copy, index: 1)
            u27 (ref,  index: 2)
            State_upv_1 (copy, index: 3)
            id_upv_1 (copy, index: 4)
            u28 (ref,  index: 5)
            a1 (copy, index: 6)
            u34 (ref,  index: 7)
            pop (copy, index: 8)
            u35 (ref,  index: 9)
            RunService_upv_1 (copy, index: 10)
            u9 (ref,  index: 11)
            u10 (ref,  index: 12)
            u11 (ref,  index: 13)
            u12 (ref,  index: 14)
            valueObj (copy, index: 15)
            u19 (copy, index: 16)
            u14 (copy, index: 17)
            u29 (ref,  index: 18)
            u26 (copy, index: 19)
            u24 (ref,  index: 20)
            u20 (copy, index: 21)
            UI_upv_1 (copy, index: 22)
        ]]
        if a9 ~= "tap" then
            if a9 == "palette" and RunService_upv_1:IsStudio() then
                local v32, v33, _, v34 = nil, nil, nil, nil
                if type(a10) == "table" then
                    local function c(a11, a12)
                        --[[
                          name: c
                          line: 503
                        ]]
                        if type(a11) ~= "table" then
                            return a12
                        end
                        return (Color3.fromRGB(a11[1], a11[2], a11[3]))
                    end
                    v32 = a10.on
                    local v35 = u9
                    local v36
                    if type(v32) ~= "table" then
                        v36 = v35
                    else
                        v36 = Color3.fromRGB(v32[1], v32[2], v32[3])
                    end
                    v33 = a10.hover
                    local v37 = u10
                    if type(v33) ~= "table" then
                        v32 = v37
                    else
                        v32 = Color3.fromRGB(v33[1], v33[2], v33[3])
                    end
                    u9 = v36
                    u10 = v32
                    v32 = a10.edge
                    local v38 = u11
                    local v39
                    if type(v32) ~= "table" then
                        v39 = v38
                    else
                        v39 = Color3.fromRGB(v32[1], v32[2], v32[3])
                    end
                    v34 = a10.text
                    local v40 = u12
                    if type(v34) ~= "table" then
                        v32 = v40
                    else
                        v32 = Color3.fromRGB(v34[1], v34[2], v34[3])
                    end
                    u11 = v39
                    u12 = v32
                    u34()
                end
            end
        elseif u18 then
            if u27 == nil then
                local v41 = State_upv_1.Profile and (State_upv_1.Profile.reactions)
                local v42 = false
                if type(v41) == "table" then
                    v42 = v41[id_upv_1] == true
                end
                u27 = v42
                u28 = u27
            end
            u28 = not u28
            a1.Sounds.Play("Click")
            u34()
            pop(u28)
            u35()
        end
        local v43 = valueObj()
        local tbl_11 = {visible = 0, inflight = 0, chip = 0, text = 0, scale = 0, pill = 0, hit = 0, reacted = 0, centre = 0, countVisible = 0, value = 0, ready = 0, icon = 0, confirmed = 0}
        tbl_11.id = id_upv_1
        tbl_11.chip = (u19.Parent ~= nil) and (u19.Visible)
        tbl_11.visible = u14.Visible
        tbl_11.reacted = u28
        tbl_11.confirmed = ((u27 == nil) and "unknown") or u27
        tbl_11.inflight = u29
        tbl_11.text = u26.Text
        tbl_11.countVisible = u26.Visible
        local v44, v45
        if v43 then
            v44 = v43.Value
            v45 = v43
        else
            v44, v45 = false, v43
        end
        tbl_11.value = v44
        v44 = (v43 ~= nil) and (v45:GetAttribute("Ready") == true)
        tbl_11.ready = v44
        local v46
        if u24:IsA("TextLabel") then
            v46 = u24.Text
        else
            v46 = u24.Image
        end
        tbl_11.icon = v46
        tbl_11.hit = {u19.AbsoluteSize.X, u19.AbsoluteSize.Y}
        tbl_11.pill = {u20.AbsoluteSize.X, u20.AbsoluteSize.Y}
        tbl_11.scale = UI_upv_1.Scale
        tbl_11.centre = {u19.AbsolutePosition.X + (u19.AbsoluteSize.X / 2), u19.AbsolutePosition.Y + (u19.AbsoluteSize.Y / 2)}
        return tbl_11
    end
    local tbl_12 = {IconName = "cross", IconScale = 0.4, Transparency = 0.15, Name = "Close", Sound = "Close"}
    tbl_12.AnchorPoint = Vector2.new(1, 0)
    tbl_12.Position = UDim2.new(1, -14, 0, 14)
    tbl_12.Size = UDim2.fromOffset(52, 52)
    tbl_12.Color = Color3.fromRGB(58, 44, 34)
    tbl_12.Parent = v2
    UI_upv_1.IconButton(tbl_12).Activated:Connect(
        function()
            --[[
              line: 542
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.MenuManager.Close("Letter")
        end
    )
    local u37 = 420
    local u38 = UI_upv_1.new("UIScale", {Parent = u15})
    local u39 = u16:FindFirstChildOfClass("UIListLayout")
    local function barButtonsRight()
        --[[
          name: barButtonsRight
          line: 554
          upvalues:
            UI_upv_1 (copy, index: 1)
            GuiService_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u14 (copy, index: 4)
        ]]
        local v47 = math.max(UI_upv_1.Scale, 0.01)
        if UI_upv_1.DebugDevice then
            return (UI_upv_1.TopInset() - 4) * 4.5
        end
        local success_2, v48 = pcall(
            function()
                --[[
                  line: 561
                  upvalues:
                    GuiService_upv_1 (copy, index: 1)
                ]]
                return GuiService_upv_1.TopbarInset
            end
        )
        local v49 = a1.TopbarSettings and (a1.TopbarSettings.Button)
        local v50 = v49 and (v49:FindFirstAncestorOfClass("ScreenGui"))
        if v50 then
            v49 = v50.AbsolutePosition.X - u14.AbsolutePosition.X
        else
            v49 = 0
        end
        if success_2 and v48 and not (v48.Width <= 0) then
            return ((v49 + v48.Min.X) / v47) + 8
        end
        return 0
    end
    local function layout()
        --[[
          name: layout
          line: 572
          upvalues:
            UI_upv_1 (copy, index: 1)
            u38 (copy, index: 2)
            u39 (copy, index: 3)
            u37 (ref,  index: 4)
            u15 (copy, index: 5)
            barButtonsRight (copy, index: 6)
            u19 (copy, index: 7)
        ]]
        local v51 = UI_upv_1.CanvasSize()
        local v52 = math.max(UI_upv_1.Scale * u38.Scale, 0.01)
        local v53 = (u39 and (u39.AbsoluteContentSize.Y / v52)) or 0
        if v53 > 50 then
            u37 = math.ceil(v53 + 78)
        end
        u15.Size = UDim2.fromOffset(640, u37)
        local v54 = math.min(1, (v51.Y - 24) / u37, (v51.X - 32) / 640)
        local v55 = ((barButtonsRight() < (v51.X - (v54 * 640)) / 2) and 12) or (UI_upv_1.TopInset())
        local v56 = math.min(v54, ((v51.Y - v55) - 12) / u37)
        u38.Scale = v56
        u15.Position = UDim2.fromOffset(v51.X / 2, math.max(v51.Y / 2, v55 + (u37 * v56 / 2)))
        local v57 = math.max(UI_upv_1.Scale * v56, 0.01)
        local v58 = ((not (UI_upv_1.Touch)) and 72) or (math.max(72, math.ceil(46 / v57)))
        u19.Size = UDim2.fromOffset(0, v58)
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    UI_upv_1.ScaleChanged:Connect(layout)
    UI_upv_1.TouchChanged:Connect(layout)
    if u39 then
        local u40 = false
        local AbsoluteContentSize_upv_1 = u39.AbsoluteContentSize
        local u41 = 0
        local u42 = 0
        u39:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                --[[
                  line: 606
                  upvalues:
                    u40 (ref,  index: 1)
                    u39 (copy, index: 2)
                    AbsoluteContentSize_upv_1 (ref,  index: 3)
                    u42 (ref,  index: 4)
                    u41 (ref,  index: 5)
                    layout (copy, index: 6)
                ]]
                if (u40) then
                    return
                end
                if not ((u39.AbsoluteContentSize - AbsoluteContentSize_upv_1).Magnitude < 0.5) then
                    local v59 = os.clock()
                    if v59 - u42 > 0.5 then
                        u41 = 0
                    end
                    if (u41 >= 6) then
                        return
                    end
                    u41 = u41 + 1
                    u42 = v59
                    u40 = true
                    task.delay(
                        0,
                        function()
                            --[[
                              line: 620
                              upvalues:
                                u40 (ref,  index: 1)
                                AbsoluteContentSize_upv_1 (ref,  index: 2)
                                u39 (copy, index: 3)
                                layout (copy, index: 4)
                            ]]
                            u40 = false
                            AbsoluteContentSize_upv_1 = u39.AbsoluteContentSize
                            layout()
                        end
                    )
                end
            end
        )
    end
    local function hideOthers(a13)
        --[[
          name: hideOthers
          line: 628
          upvalues:
            a1 (copy, index: 1)
            u13 (ref,  index: 2)
        ]]
        a1.SetHudHidden("Letter", a13)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("Letter", a13)
        end
        if a13 then
            if u13 then
                return
            end
            local tbl_13 = {}
            pcall(function() end)
            u13 = tbl_13
        else
            local v60 = u13
            if not v60 then
                return
            end
            u13 = nil
            pcall(function() end)
        end
    end
    local u43 = 0
    local tbl_14 = {}
    function tbl_14.open()
        --[[
          name: open
          line: 642
          upvalues:
            u43 (ref,  index: 1)
            a1 (copy, index: 2)
            u13 (ref,  index: 3)
            TextChatService_upv_1 (copy, index: 4)
            StarterGui_upv_1 (copy, index: 5)
            layout (copy, index: 6)
            u14 (copy, index: 7)
            u15 (copy, index: 8)
            UI_upv_1 (copy, index: 9)
            u18 (copy, index: 10)
        ]]
        u43 = u43 + 1
        a1.SetHudHidden("Letter", true)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("Letter", true)
        end
        if not (u13) then
            local tbl_upv_15 = {}
            pcall(
                function()
                    --[[
                      line: 63
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        tbl_upv_15 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v61 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v62 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v61 then
                        tbl_upv_15.window = v61.Enabled
                        v61.Enabled = false
                    end
                    if v62 then
                        tbl_upv_15.bar = v62.Enabled
                        v62.Enabled = false
                    end
                    tbl_upv_15.core = StarterGui_upv_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                end
            )
            u13 = tbl_upv_15
        end
        layout()
        u14.Visible = true
        u15.Rotation = -4
        local Position_1 = u15.Position
        u15.Position = Position_1 + UDim2.fromOffset(0, 40)
        UI_upv_1.Tween(u15, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -0.8, Position = Position_1})
        UI_upv_1.FadeIn(u15, TweenInfo.new(0.2))
        a1.Sounds.Play("Open")
        if not u18 then
            return
        end
        local _ = true
        task.spawn(function() end)
    end
    function tbl_14.close(a14)
        --[[
          name: close
          line: 655
          upvalues:
            u43 (ref,  index: 1)
            a1 (copy, index: 2)
            u13 (ref,  index: 3)
            TextChatService_upv_1 (copy, index: 4)
            StarterGui_upv_1 (copy, index: 5)
            u18 (copy, index: 6)
            Remotes_upv_1 (copy, index: 7)
            id_upv_1 (copy, index: 8)
            u29 (ref,  index: 9)
            u27 (ref,  index: 10)
            u28 (ref,  index: 11)
            u34 (ref,  index: 12)
            u14 (copy, index: 13)
            UI_upv_1 (copy, index: 14)
            u15 (copy, index: 15)
        ]]
        u43 = u43 + 1
        local u44 = u43
        a1.SetHudHidden("Letter", false)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("Letter", false)
        end
        local u45 = u13
        if u45 then
            u13 = nil
            pcall(
                function()
                    --[[
                      line: 85
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        u45 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v63 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v64 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v63 and u45.window ~= nil then
                        v63.Enabled = u45.window
                    end
                    if v64 and u45.bar ~= nil then
                        v64.Enabled = u45.bar
                    end
                    if u45.core == nil then
                        return
                    end
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, u45.core)
                end
            )
        end
        if u18 then
            local u46 = false
            task.spawn(
                function()
                    --[[
                      line: 488
                      upvalues:
                        Remotes_upv_1 (copy, index: 1)
                        id_upv_1 (copy, index: 2)
                        u46 (copy, index: 3)
                        u29 (ref,  index: 4)
                        u27 (ref,  index: 5)
                        u28 (ref,  index: 6)
                        u34 (ref,  index: 7)
                    ]]
                    local v65, v66, _, v67 = Remotes_upv_1.Invoke("LetterAction", "Watch", id_upv_1, u46)
                    if u46 and v65 and v66 == true and type(v67) == "boolean" and not (u29) and (u27 == nil or u28 == u27) then
                        u27 = v67
                        u28 = v67
                    end
                    u34()
                end
            )
        end
        if a14 then
            u14.Visible = false
        else
            UI_upv_1.FadeOut(u15, TweenInfo.new(0.16))
            task.delay(
                0.17,
                function()
                    --[[
                      line: 665
                      upvalues:
                        u44 (copy, index: 1)
                        u43 (ref,  index: 2)
                        u14 (copy, index: 3)
                    ]]
                    if u44 ~= u43 then
                        return
                    end
                    u14.Visible = false
                end
            )
        end
    end
    a1.MenuManager.Register("Letter", tbl_14)
end
return tbl_1