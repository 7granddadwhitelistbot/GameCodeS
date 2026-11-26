local starterGui = game:GetService("StarterGui")
local textChatService = game:GetService("TextChatService")

return {
    Init = (function(a3)
        --[[
          name: Init
          line: 24
          upvalues:
            textChatService (copy, index: 1)
            starterGui (copy, index: 2)
        ]]
        local ui = a3.UI
        local theme = a3.Theme
        local colors = theme.Colors
        local fonts = theme.Fonts
        local menuManager = a3.MenuManager
        local udim2FromOffset = UDim2.fromOffset
        local said = {}

        local function escape(text: string)
            --[[
              name: escape
              line: 33
            ]]
            return (string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
        end

        local function systemLine(text, a15: string?, a16: string?)
            --[[
              name: systemLine
              line: 36
              upvalues:
                textChatService (copy, index: 1)
                starterGui (copy, index: 2)
            ]]
            local textChannels = textChatService:FindFirstChild("TextChannels")
            local rbxSystem = textChannels and textChannels:FindFirstChild("RBXSystem")

            if rbxSystem and rbxSystem:IsA("TextChannel") then
                return (pcall(
                    function()
                        --[[
                          line: 40
                          upvalues:
                            rbxSystem (copy, index: 1)
                            a16 (copy, index: 2)
                            a15 (copy, index: 3)
                            text (copy, index: 4)
                        ]]
                        rbxSystem:DisplaySystemMessage((`<font color="{a16 or "#FF7A82"}"><b>[{a15 or "MOD"}]</b></font> <font color="#E4E8F0">{(string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))}</font>`))
                    end
                ))
            end

            return (pcall(
                function()
                    --[[
                      line: 46
                      upvalues:
                        starterGui (copy, index: 1)
                        text (copy, index: 2)
                    ]]
                    starterGui:SetCore("ChatMakeSystemMessage", {Text = "[MOD] " .. text, Color = Color3.fromRGB(255, 160, 165)})
                end
            ))
        end

        local function say(a20, a21, a22)
            --[[
              name: say
              line: 50
              upvalues:
                said (copy, index: 1)
                systemLine (copy, index: 2)
                a3 (copy, index: 3)
            ]]
            local v23 = false

            if type(a20) == "table" then
                for _, text in a20 do
                    if type(text) == "string" then
                        table.insert(said, text)
                        v23 = systemLine(text) or v23
                    end
                end

                while 30 < #said do
                    table.remove(said, 1)
                end
            end

            if type(a21) == "string" and a21 ~= "" then
                local v26
                local toast = a3.Toast

                if type(a22) ~= "string" then
                    v26 = "info"
                else
                    v26 = a22
                end

                toast(a21, v26)

                return
            end

            if not v23 and type(a20) == "table" and type(a20[1]) == "string" then
                local v28
                local toast = a3.Toast
                local v30 = a20[1]

                if type(a22) ~= "string" then
                    v28 = "info"
                else
                    v28 = a22
                end

                toast(v30, v28)
            end
        end

        local v31 = nil
        local v32 = {}
        local v33 = nil
        local v34 = false

        local function close()
            --[[
              name: close
              line: 76
              upvalues:
                menuManager (copy, index: 1)
            ]]
            menuManager.Close("ModBan")
        end

        local function text(a37)
            --[[
              name: text
              line: 80
              upvalues:
                colors (copy, index: 1)
                ui (copy, index: 2)
            ]]
            a37.BackgroundTransparency = 1
            a37.TextXAlignment = a37.TextXAlignment or Enum.TextXAlignment.Left
            a37.TextColor3 = a37.TextColor3 or colors.Text

            return ui.new("TextLabel", a37)
        end

        local function row(name: string, a40: number, text: string)
            --[[
              name: row
              line: 87
              upvalues:
                ui (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                colors (copy, index: 3)
                v31 (ref,  index: 4)
                fonts (copy, index: 5)
            ]]
            local parent = ui.new("Frame", {Name = name, Position = udim2FromOffset(0, a40), Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.25, (ui.Corner(12)), Parent = v31.Content})
            local v43 = {Name = "Title", TextSize = 14, Text = text, FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, Position = udim2FromOffset(18, 0), Size = UDim2.new(0, 110, 1, 0), Parent = parent, BackgroundTransparency = 1}
            v43.TextXAlignment = v43.TextXAlignment or Enum.TextXAlignment.Left
            v43.TextColor3 = v43.TextColor3 or colors.Text
            ui.new("TextLabel", v43)
            local v44 = {Name = "Value", Text = "", TextSize = 21, FontFace = fonts.Bold, Position = udim2FromOffset(128, 9), Size = UDim2.new(1, -146, 0, 24), TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent, BackgroundTransparency = 1}
            v44.TextXAlignment = v44.TextXAlignment or Enum.TextXAlignment.Left
            v44.TextColor3 = v44.TextColor3 or colors.Text
            local ui2 = ui.new("TextLabel", v44)
            local v46 = {Name = "Sub", Text = "", TextSize = 14, FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, Position = udim2FromOffset(128, 33), Size = UDim2.new(1, -146, 0, 16), Parent = parent, BackgroundTransparency = 1}
            v46.TextXAlignment = v46.TextXAlignment or Enum.TextXAlignment.Left
            v46.TextColor3 = v46.TextColor3 or colors.Text

            return parent, ui2, (ui.new("TextLabel", v46))
        end

        local function build()
            --[[
              name: build
              line: 103
              upvalues:
                v31 (ref,  index: 1)
                ui (copy, index: 2)
                udim2FromOffset (copy, index: 3)
                a3 (copy, index: 4)
                close (copy, index: 5)
                colors (copy, index: 6)
                theme (copy, index: 7)
                v32 (copy, index: 8)
                fonts (copy, index: 9)
                row (copy, index: 10)
                v34 (ref,  index: 11)
                v33 (ref,  index: 12)
                menuManager (copy, index: 13)
            ]]
            v31 = ui.Window({Name = "ModBan", Title = "BAN PLAYER", Subtitle = "Check it's the right account", HeaderHeight = 76, Size = udim2FromOffset(600, 466), Parent = a3.Canvas.Menus, OnCloseRequested = close})
            v31.Title.TextColor3 = colors.Danger
            ui.SelectionRing(v31.Root)
            local content = v31.Content
            local ui2 = ui.new("ImageLabel", {Name = "Head", Position = udim2FromOffset(0, 0), Size = udim2FromOffset(92, 92), BackgroundColor3 = colors.Raised, Image = "", (ui.Corner(theme.Radius.Pill)), Parent = content})
            ui.Stroke(colors.Stroke, 1.5, 0.85).Parent = ui2
            v32.head = ui2
            local v50 = {Name = "Name", Text = "", TextSize = 32, FontFace = fonts.Display, Position = udim2FromOffset(112, 2), Size = UDim2.new(1, -112, 0, 36), TextTruncate = Enum.TextTruncate.AtEnd, Parent = content, BackgroundTransparency = 1}
            v50.TextXAlignment = v50.TextXAlignment or Enum.TextXAlignment.Left
            v50.TextColor3 = v50.TextColor3 or colors.Text
            v32.name = ui.new("TextLabel", v50)
            local v51 = {Name = "Handle", Text = "", TextSize = 17, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, Position = udim2FromOffset(112, 40), Size = UDim2.new(1, -112, 0, 20), TextTruncate = Enum.TextTruncate.AtEnd, Parent = content, BackgroundTransparency = 1}
            v51.TextXAlignment = v51.TextXAlignment or Enum.TextXAlignment.Left
            v51.TextColor3 = v51.TextColor3 or colors.Text
            v32.handle = ui.new("TextLabel", v51)
            v32.whereHolder = ui.new("Frame", {Name = "Where", Position = udim2FromOffset(112, 66), Size = udim2FromOffset(300, 24), Parent = content})
            v32.already = ui.new("Frame", {Name = "Already", Position = udim2FromOffset(0, 106), Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = colors.Warning, BackgroundTransparency = 0.82, Visible = false, (ui.Corner(10)), Parent = content})
            ui.Stroke(colors.Warning, 1, 0.5).Parent = v32.already
            local v52 = {Name = "Text", Text = "", TextSize = 16, FontFace = fonts.Bold, TextColor3 = colors.Warning, Position = udim2FromOffset(14, 0), Size = UDim2.new(1, -28, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = v32.already, BackgroundTransparency = 1}
            v52.TextXAlignment = v52.TextXAlignment or Enum.TextXAlignment.Left
            v52.TextColor3 = v52.TextColor3 or colors.Text
            v32.alreadyText = ui.new("TextLabel", v52)
            local _, length, lengthSub = row("Length", 106, "LENGTH")
            local _, reason, reasonSub = row("Reason", 170, "REASON")
            v32.lengthRow = length.Parent
            v32.reasonRow = reason.Parent
            v32.length = length
            v32.lengthSub = lengthSub
            v32.reason = reason
            v32.reasonSub = reasonSub
            reasonSub.Text = "They see this when they try to join"
            local v59 = {Name = "Note", Text = "", TextSize = 15, TextWrapped = true, FontFace = fonts.SemiBold, TextColor3 = colors.TextMuted, TextYAlignment = Enum.TextYAlignment.Top, Position = udim2FromOffset(0, 240), Size = UDim2.new(1, 0, 0, 40), Parent = content, BackgroundTransparency = 1}
            v59.TextXAlignment = v59.TextXAlignment or Enum.TextXAlignment.Left
            v59.TextColor3 = v59.TextColor3 or colors.Text
            v32.note = ui.new("TextLabel", v59)
            v32.cancel = ui.Button({Name = "Cancel", Text = "CANCEL", TextSize = 20, Style = "Dark", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = udim2FromOffset(272, 58), Parent = content})
            v32.ban = ui.Button({Name = "Ban", Text = "BAN", TextSize = 20, Style = "Danger", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 1, 0), Size = udim2FromOffset(272, 58), Parent = content})
            v32.cancel.Activated:Connect(close)

            v32.ban.Activated:Connect(
                function()
                    --[[
                      line: 173
                      upvalues:
                        v34 (ref,  index: 1)
                        v33 (ref,  index: 2)
                        v32 (copy, index: 3)
                        a3 (copy, index: 4)
                        menuManager (copy, index: 5)
                    ]]
                    if v34 or not v33 then
                        return
                    end

                    v34 = true
                    v32.ban:SetText("BANNING…")
                    v32.ban:SetEnabled(false)
                    local token = v33.token

                    task.spawn(
                        function()
                            --[[
                              line: 181
                              upvalues:
                                a3 (copy, index: 1)
                                token (copy, index: 2)
                                v34 (ref,  index: 3)
                                v33 (ref,  index: 4)
                                menuManager (copy, index: 5)
                                v32 (copy, index: 6)
                            ]]
                            local v61
                            local v62, v63, text = a3.Remotes.Invoke("ModAction", "Ban", token)
                            v34 = false

                            if v62 and v63 then
                                local v65
                                v33 = nil
                                menuManager.Close("ModBan")
                                local toast = a3.Toast

                                if type(text) ~= "string" then
                                    v65 = "Banned"
                                else
                                    v65 = text
                                end

                                toast(v65, "success")

                                return
                            end

                            v32.ban:SetEnabled(true)
                            v32.ban:SetText("TRY AGAIN")
                            local toast = a3.Toast

                            if type(text) ~= "string" then
                                if type(v63) ~= "string" then
                                    v61 = "The ban didn't go through"
                                else
                                    v61 = v63
                                end
                            else
                                v61 = text
                            end

                            toast(v61, "error")

                            if type(text) == "string" and string.find(text, "expired", 1, true) then
                                v33 = nil
                                menuManager.Close("ModBan")
                            end
                        end
                    )
                end
            )
        end

        local function paint()
            --[[
              name: paint
              line: 201
              upvalues:
                v33 (ref,  index: 1)
                v32 (copy, index: 2)
                ui (copy, index: 3)
                colors (copy, index: 4)
                v31 (ref,  index: 5)
                udim2FromOffset (copy, index: 6)
            ]]
            local v69
            local text5
            local v71
            local v72 = v33
            if not v72 then
                return
            end

            local number = tonumber(v72.userId) or 0
            v32.head.Image = `rbxthumb://type=AvatarHeadShot&id={number}&w=150&h=150`
            local text = tostring((v72.display or v72.name or "?"))
            local text2 = tostring((v72.name or "?"))
            v32.name.Text = text
            v32.handle.Text = `@{text2}  ·  id {number}`
            v32.whereHolder:ClearAllChildren()
            local text3 = tostring((v72.where or "away"))

            if text3 ~= "here" then
                v69 = text3 == "away" and "Not in this server" or text3
            else
                v69 = "In this server"
            end

            local pill = ui.Pill
            local v78 = if text3 == "here" then colors.SuccessDark else colors.Raised
            pill(v69, v78, {Height = 24, TextSize = 13, Parent = v32.whereHolder})
            local visible = type(v72.already) == "string" and v72.already ~= ""
            v32.already.Visible = visible
            v32.alreadyText.Text = not visible and "" or `Already {v72.already}. Banning again replaces it.`
            local v80 = visible and 152 or 106
            local holder = v31.Holder
            local v82 = visible and 46 or 0
            holder.Size = udim2FromOffset(600, v82 + 466)
            v31.Refit()
            v32.lengthRow.Position = udim2FromOffset(0, v80)
            v32.reasonRow.Position = udim2FromOffset(0, v80 + 64)
            v32.note.Position = udim2FromOffset(0, v80 + 136)
            local v83 = (tonumber(v72.length) or -1) < 0
            local text4 = tostring((v72.lengthText or "permanent"))
            local length = v32.length

            if v83 then
                text5 = "Permanent"
            else
                text5 = string.upper((string.sub(text4, 1, 1))) .. string.sub(text4, 2)
            end

            length.Text = text5
            v32.length.TextColor3 = if v83 then colors.Danger else colors.Text
            v32.lengthSub.Text = v83 and "Until a moderator unbans them (/unban)" or "Then they can play again"
            v32.reason.Text = tostring((v72.reason or "Cheating"))
            local note = v32.note

            if v72.studio then
                v71 = "  Studio: a test ban, it never reaches the live game."
            else
                v71 = ""
            end

            note.Text = "Their alt accounts are banned too, and their device can't rejoin for 24 hours." .. v71
            local ban = v32.ban
            local v88 = v83 and "BAN PERMANENTLY" or `BAN FOR {(string.upper(text4))}`
            ban:SetText(v88)
            v32.ban:SetEnabled(true)
        end

        menuManager.Register(
            "ModBan",
            {
                open = (function()
                    --[[
                      name: open
                      line: 239
                      upvalues:
                        v31 (ref,  index: 1)
                        build (copy, index: 2)
                        v34 (ref,  index: 3)
                        paint (copy, index: 4)
                    ]]
                    if not v31 then
                        build()
                    end

                    v34 = false
                    paint()
                    v31:Open()
                end),
                close = (function(a89)
                    --[[
                      name: close
                      line: 247
                      upvalues:
                        v31 (ref, index: 1)
                    ]]
                    if v31 then
                        v31:Close(a89)
                    end
                end),
                select = (function()
                    --[[
                      name: select
                      line: 252
                      upvalues:
                        v32 (copy, index: 1)
                    ]]
                    if v32.cancel then
                        return v32.cancel.Instance
                    end

                    return nil
                end)
            }
        )

        a3.Remotes.On(
            "ModEvent",
            function(a90, a91, a92, a93)
                --[[
                  line: 257
                  upvalues:
                    say (copy, index: 1)
                    v33 (ref,  index: 2)
                    menuManager (copy, index: 3)
                    paint (copy, index: 4)
                    systemLine (copy, index: 5)
                    a3 (copy, index: 6)
                ]]
                if a90 == "Say" then
                    say(a91, a92, a93)
                    return
                end

                if a90 == "Confirm" and type(a91) == "table" then
                    v33 = a91

                    if menuManager.IsOpen("ModBan") then
                        paint()
                        return
                    end

                    menuManager.Open("ModBan")

                    return
                end

                if a90 == "Banned" and type(a91) == "string" then
                    local v94

                    if type(a92) == "string" and a92 ~= a91 then
                        v94 = `{a91} (@{a92})`
                    else
                        v94 = a91
                    end

                    systemLine(`{v94} was banned for cheating.`, "BANNED", "#FF5A5F")
                    a3.Toast(`{a91} was banned for cheating`, "success")
                end
            end
        )

        a3.Debug.mod = function(a95)
            --[[
              line: 275
              upvalues:
                v32 (copy, index: 1)
                menuManager (copy, index: 2)
                said (copy, index: 3)
            ]]
            if a95 == "ban" and v32.ban then
                v32.ban.Activated:Fire()
            end

            local v96 = {open = menuManager.IsOpen("ModBan"), name = if v32.name then v32.name.Text else false, length = if v32.length then v32.length.Text else false, reason = if v32.reason then v32.reason.Text else false}
            v96.said = said
            return v96
        end
    end)
}