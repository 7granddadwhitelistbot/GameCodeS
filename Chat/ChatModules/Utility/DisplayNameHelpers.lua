local players = game:GetService("Players")
local chat = game:GetService("Chat")
local clientChatModules = chat:WaitForChild("ClientChatModules")
local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
local commandErrorCodes = {ChattingToSelf = 1, NoMatches = 2, MultipleMatches = 3}

return {
    CommandErrorCodes = commandErrorCodes,
    getUserNameFromChattedName = (function(text: string, a7, a8)
        --[[
          name: getUserNameFromChattedName
          line: 14
          upvalues:
            commandErrorCodes (copy, index: 1)
            players (copy, index: 2)
            ChatSettings (copy, index: 3)
        ]]
        if a7 == text then
            return a7, commandErrorCodes.ChattingToSelf
        end

        local players2 = players:GetPlayers()

        for _, player in pairs(players2) do
            if string.lower(player.Name) == string.lower(text) then
                return player.Name, nil
            end
        end

        local count = 0
        local name = nil

        if ChatSettings.PlayerDisplayNamesEnabled then
            for _, player in pairs(players2) do
                if player.Name ~= a7 and string.lower(player.DisplayName) == string.lower(text) then
                    count += 1
                    name = player.Name
                end
            end
        end

        if count == 1 then
            return name, nil
        end

        if count ~= 0 then
            if 2 <= count then
                return text, commandErrorCodes.MultipleMatches
            end

            return
        end

        if a8 == text then
            return a8, commandErrorCodes.ChattingToSelf
        end

        return text, commandErrorCodes.NoMatches
    end),
    getUsersWithDisplayNameString = (function(text: string, a17)
        --[[
          name: getUsersWithDisplayNameString
          line: 56
          upvalues:
            players (copy, index: 1)
        ]]
        local v18 = {}
        local v19 = ""
        local players2 = players:GetPlayers()

        for _, player in pairs(players2) do
            if player.Name ~= a17 and string.lower(player.DisplayName) == string.lower(text) then
                table.insert(v18, player.Name)
            end
        end

        for key, v24 in pairs(v18) do
            v19 = if key ~= #v18 then v19 .. "@" .. v24 .. ", " else v19 .. "@" .. v24
        end

        return v19
    end)
}