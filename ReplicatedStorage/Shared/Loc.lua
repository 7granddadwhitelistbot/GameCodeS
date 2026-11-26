local players = game:GetService("Players")
local localizationService = game:GetService("LocalizationService")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local Signal = require(script.Parent:WaitForChild("Signal"))
local v6 = {LANGS = {"es", "pt", "ru", "th", "fr"}, Changed = Signal.new()}
local v7 = "en"
local localeId = "en-us"
local result = nil
local translator = nil
local v11 = false

local function langOf(a13)
    --[[
      name: langOf
      line: 52
      upvalues:
        v6 (copy, index: 1)
    ]]
    local lowercaseText = string.lower((string.sub((a13 or ""), 1, 2)))

    if table.find(v6.LANGS, lowercaseText) then
        return lowercaseText
    end

    return "en"
end

local function testLang()
    --[[
      name: testLang
      line: 57
      upvalues:
        runService (copy, index: 1)
        workspace (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    if not runService:IsStudio() then
        return nil
    end

    local locTest = workspace:GetAttribute("LocTest")

    if type(locTest) == "string" and table.find(v6.LANGS, locTest) then
        return locTest
    end

    return nil
end

local function build()
    --[[
      name: build
      line: 65
      upvalues:
        runService (copy, index: 1)
        workspace (copy, index: 2)
        v6 (copy, index: 3)
    ]]
    local locTest
    local sourceLocaleId
    local Strings = require(script:WaitForChild("Strings"))

    if runService:IsStudio() then
        local locTest2 = workspace:GetAttribute("LocTest")

        if type(locTest2) ~= "string" or not table.find(v6.LANGS, locTest2) then
            locTest = nil
        else
            locTest = locTest2
        end
    else
        locTest = nil
    end

    local entries = table.create(#Strings)
    local v23 = {}

    for _, string in Strings do
        local source = string[1]

        if type(source) == "string" then
            if source ~= "" and not v23[source] then
                v23[source] = true
                local values = {}

                for v28, lang in v6.LANGS do
                    local v30 = string[v28 + 1]

                    if type(v30) == "string" and v30 ~= "" then
                        values[lang] = v30
                    end
                end

                if locTest then
                    values["en-us"] = values[locTest] or source
                end

                table.insert(entries, {Key = "", Context = "", Example = "", Source = source, Values = values})
            end
        end
    end

    local tribesStrings = Instance.new("LocalizationTable")
    tribesStrings.Name = "TribesStrings"

    if locTest then
        sourceLocaleId = "zz-zz"
    else
        sourceLocaleId = "en-us"
    end

    tribesStrings.SourceLocaleId = sourceLocaleId
    tribesStrings:SetEntries(entries)

    return tribesStrings
end

local function retranslate(playerGui: PlayerGui?)
    --[[
      name: retranslate
      line: 96
    ]]
    for _, descendant in playerGui:GetDescendants() do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            if descendant.AutoLocalize then
                descendant.AutoLocalize = false
                descendant.AutoLocalize = true
            end
        end
    end
end

local function setLocale(locale)
    --[[
      name: setLocale
      line: 105
      upvalues:
        runService (copy, index: 1)
        workspace (copy, index: 2)
        v6 (copy, index: 3)
        localeId (ref,  index: 4)
        translator (ref,  index: 5)
        result (ref,  index: 6)
        v7 (ref,  index: 7)
    ]]
    local locTest
    local localeId2

    if runService:IsStudio() then
        local locTest2 = workspace:GetAttribute("LocTest")

        if type(locTest2) ~= "string" or not table.find(v6.LANGS, locTest2) then
            locTest = nil
        else
            locTest = locTest2
        end
    else
        locTest = nil
    end

    if locTest then
        localeId2 = "en-us"
    else
        localeId2 = locale
    end

    localeId = localeId2
    local v41 = locTest
    if not v41 then
        local localeId3 = localeId2
        local lowercaseText = string.lower((string.sub((localeId3 or ""), 1, 2)))

        if table.find(v6.LANGS, lowercaseText) then
            v41 = lowercaseText
        else
            v41 = "en"
        end
    end

    translator = nil

    if result then
        local success, translator2 = pcall(
            function()
                --[[
                  line: 114
                  upvalues:
                    result (ref, index: 1)
                    localeId2 (ref, index: 2)
                ]]
                return result:GetTranslator(localeId2)
            end
        )
        if success then
            translator = translator2
        end
    end

    if v41 ~= v7 then
        v7 = v41
        v6.Changed:Fire(v41)
    end
end

function v6.Install()
    --[[
      name: Install
      line: 127
      upvalues:
        v11 (ref,  index: 1)
        result (ref,  index: 2)
        runService (copy, index: 3)
        localizationService (copy, index: 4)
        build (copy, index: 5)
        players (copy, index: 6)
        setLocale (copy, index: 7)
        retranslate (copy, index: 8)
    ]]
    if v11 then
        return result
    end

    v11 = true

    if not runService:IsClient() then
        return nil
    end

    local tribesStrings = localizationService:FindFirstChild("TribesStrings")

    if not tribesStrings or not tribesStrings:IsA("LocalizationTable") then
        local success, result2 = pcall(build)
        if not success then
            warn("[Loc] table not built: " .. tostring(result2))
            return nil
        end

        result = result2
        result2.Parent = localizationService
    else
        result = tribesStrings
    end

    local localPlayer = players.LocalPlayer
    local localeId = localPlayer and localPlayer.LocaleId or "en-us"
    setLocale(localeId)

    if localPlayer then
        if const playerGui = localPlayer:FindFirstChildOfClass("PlayerGui") then
            retranslate(playerGui)
        end

        task.spawn(
            function()
                --[[
                  line: 155
                  upvalues:
                    localizationService (copy, index: 1)
                    localPlayer (copy, index: 2)
                    setLocale (copy, index: 3)
                ]]
                local success, translatorForPlayerAsync = pcall(
                    function()
                        --[[
                          line: 156
                          upvalues:
                            localizationService (copy, index: 1)
                            localPlayer (copy, index: 2)
                        ]]
                        return localizationService:GetTranslatorForPlayerAsync(localPlayer)
                    end
                )

                if success and translatorForPlayerAsync then
                    setLocale(translatorForPlayerAsync.LocaleId)
                    translatorForPlayerAsync:GetPropertyChangedSignal("LocaleId"):Connect(
                        function()
                            --[[
                              line: 161
                              upvalues:
                                setLocale (copy, index: 1)
                                translatorForPlayerAsync (copy, index: 2)
                            ]]
                            setLocale(translatorForPlayerAsync.LocaleId)
                        end
                    )
                end
            end
        )
    end

    return result
end

function v6.Lang()
    --[[
      name: Lang
      line: 170
      upvalues:
        v7 (ref, index: 1)
    ]]
    return v7
end

function v6.T(a54)
    --[[
      name: T
      line: 175
      upvalues:
        v7 (ref,  index: 1)
        runService (copy, index: 2)
        workspace (copy, index: 3)
        v6 (copy, index: 4)
        translator (ref,  index: 5)
    ]]
    if v7 == "en" then
        local locTest

        if runService:IsStudio() then
            local locTest2 = workspace:GetAttribute("LocTest")

            if type(locTest2) ~= "string" or not table.find(v6.LANGS, locTest2) then
                locTest = nil
            else
                locTest = locTest2
            end
        else
            locTest = nil
        end

        if not locTest then
            return a54
        end
    end

    local translator2 = translator
    if not translator2 then
        return a54
    end

    local success, result = pcall(
        function()
            --[[
              line: 183
              upvalues:
                translator2 (copy, index: 1)
                a54 (copy, index: 2)
            ]]
            return translator2:Translate(game, a54)
        end
    )

    if success and type(result) == "string" then
        return result
    end

    return a54
end

function v6.Pick(a60, a61)
    --[[
      name: Pick
      line: 193
      upvalues:
        v7 (ref,  index: 1)
        runService (copy, index: 2)
        workspace (copy, index: 3)
        v6 (copy, index: 4)
    ]]
    if v7 == "en" then
        local locTest

        if runService:IsStudio() then
            local locTest2 = workspace:GetAttribute("LocTest")

            if type(locTest2) ~= "string" or not table.find(v6.LANGS, locTest2) then
                locTest = nil
            else
                locTest = locTest2
            end
        else
            locTest = nil
        end

        if not locTest then
            return a61
        end
    end

    local v64 = v6.T(a60)

    if v64 == a60 then
        return a61
    end

    return v64
end

function v6.Rich(a65, a66)
    --[[
      name: Rich
      line: 204
      upvalues:
        v6 (copy, index: 1)
    ]]
    a65.AutoLocalize = false
    a65.Text = v6.T(a66)
end

function v6.Off(a67)
    --[[
      name: Off
      line: 211
    ]]
    a67.AutoLocalize = false
    return a67
end

function v6.Fit(parent: Instance?, a69, a70: number)
    --[[
      name: Fit
      line: 219
    ]]
    if not parent:FindFirstChild("LocFit") then
        local locFit = Instance.new("UITextSizeConstraint")
        locFit.Name = "LocFit"
        local textSize = parent.TextSize
        locFit.MaxTextSize = math.max(1, textSize)
        locFit.MinTextSize = math.min(textSize, (a69 or math.max(8, (math.floor(textSize * 0.6)))))
        locFit.Parent = parent
        parent.TextScaled = true

        parent:GetPropertyChangedSignal("TextSize"):Connect(
            function()
                --[[
                  name: cap
                  line: 226
                  upvalues:
                    parent (copy, index: 1)
                    locFit (copy, index: 2)
                    a69 (copy, index: 3)
                ]]
                local textSize = parent.TextSize
                locFit.MaxTextSize = math.max(1, textSize)
                locFit.MinTextSize = math.min(textSize, (a69 or math.max(8, (math.floor(textSize * 0.6)))))
            end
        )

        if a70 and 0 < a70 and not parent:FindFirstChildOfClass("UIPadding") then
            local uiPadding = Instance.new("UIPadding")
            uiPadding.PaddingLeft = UDim.new(a70, 0)
            uiPadding.PaddingRight = UDim.new(a70, 0)
            uiPadding.Parent = parent
        end
    end

    return parent
end

function v6.Missing(a75)
    --[[
      name: Missing
      line: 245
      upvalues:
        result (ref,  index: 1)
        runService (copy, index: 2)
        workspace (copy, index: 3)
        v6 (copy, index: 4)
        localeId (ref,  index: 5)
    ]]
    local locTest
    local v77 = {}

    if not result then
        return v77
    end

    local v78 = {}
    local result2 = result

    if runService:IsStudio() then
        local locTest2 = workspace:GetAttribute("LocTest")

        if type(locTest2) ~= "string" or not table.find(v6.LANGS, locTest2) then
            locTest = nil
        else
            locTest = locTest2
        end
    else
        locTest = nil
    end

    local v81 = locTest and "en-us" or localeId

    do
        local v82, tableMove, values = v78, table.move, table.pack(result2:GetTranslator(v81), result:GetTranslator("th"))
        tableMove(values, 1, values.n, 1, v82)
    end

    for _, descendant in a75:GetDescendants() do
        if not descendant:IsA("TextLabel") and not descendant:IsA("TextButton") then
            continue
        end

        if descendant.AutoLocalize then
            local parent

            if not descendant.Visible then
                continue
            end
            if descendant.Text == "" then
                continue
            end

            local text = descendant.Text

            if not string.find(text, "%a") then
                continue
            end

            local v89 = false

            for _, v91 in v78 do
                local success, result3 = pcall(
                    function()
                        --[[
                          line: 258
                          upvalues:
                            v91 (copy, index: 1)
                            descendant (copy, index: 2)
                            text (copy, index: 3)
                        ]]
                        return v91:Translate(descendant, text)
                    end
                )
                local v94 = v89 or success and result3 ~= text
                v89 = v94
            end

            if v89 then
                continue
            end

            local v95 = true
            parent = descendant.Parent

            while parent do
                if parent == a75 then
                    break
                end
                if parent:IsA("GuiObject") and not parent.Visible then
                    break
                end

                if parent:IsA("LayerCollector") and not parent.Enabled then
                    v95 = false
                    break
                end

                parent = parent.Parent
            end

            if not v95 then
                continue
            end

            local v96 = {descendant:GetFullName(), text}
            table.insert(v77, v96)
        end
    end

    return v77
end

return v6