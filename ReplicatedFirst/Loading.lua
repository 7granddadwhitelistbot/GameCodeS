local ReplicatedFirst_upv_1 = game:GetService("ReplicatedFirst")
pcall(
    function()
        --[[
          line: 10
          upvalues:
            ReplicatedFirst_upv_1 (copy, index: 1)
        ]]
        ReplicatedFirst_upv_1:RemoveDefaultLoadingScreen()
    end
)
local u1 = os.clock()
local Players_1 = game:GetService("Players")
local TweenService_upv_1 = game:GetService("TweenService")
local RunService_upv_1 = game:GetService("RunService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local PlayerGui_upv_1 = LocalPlayer_upv_1:WaitForChild("PlayerGui")
pcall(
    function()
        --[[
          line: 23
          upvalues:
            PlayerGui_upv_1 (copy, index: 1)
        ]]
        PlayerGui_upv_1.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
    end
)
local tbl_upv_1 = {
    {"3V3 ARENA  \194\183  BEST OF 5", "ARENA 3V3  \194\183  AL MEJOR DE 5", "ARENA 3V3  \194\183  MELHOR DE 5", "\208\144\208\160\208\149\208\157\208\144 3 \208\157\208\144 3  \194\183  \208\148\208\158 3 \208\159\208\158\208\145\208\149\208\148", "\224\184\173\224\184\178\224\184\163\224\184\181\224\184\153\224\185\136\224\184\178 3V3  \194\183  \224\184\138\224\184\153\224\184\176 3 \224\185\131\224\184\153 5", "AR\195\136NE 3V3  \194\183  AU MEILLEUR DES 5"},
    {"TIP", "CONSEJO", "DICA", "\208\161\208\158\208\146\208\149\208\162", "\224\185\128\224\184\132\224\184\165\224\185\135\224\184\148\224\184\165\224\184\177\224\184\154", "ASTUCE"},
    {"LOADING\226\128\166", "CARGANDO\226\128\166", "CARREGANDO\226\128\166", "\208\151\208\144\208\147\208\160\208\163\208\151\208\154\208\144\226\128\166", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\130\224\184\171\224\184\165\224\184\148\226\128\166", "CHARGEMENT\226\128\166"},
    {"ALMOST THERE\226\128\166", "YA CASI\226\128\166", "QUASE L\195\129\226\128\166", "\208\159\208\158\208\167\208\162\208\152 \208\147\208\158\208\162\208\158\208\146\208\158\226\128\166", "\224\185\131\224\184\129\224\184\165\224\185\137\224\185\129\224\184\165\224\185\137\224\184\167\226\128\166", "PRESQUE PR\195\138T\226\128\166"},
    {"READY!", "\194\161LISTO!", "PRONTO!", "\208\147\208\158\208\162\208\158\208\146\208\158!", "\224\184\158\224\184\163\224\185\137\224\184\173\224\184\161\224\185\129\224\184\165\224\185\137\224\184\167!", "PR\195\138T !"},
    {"SKIP  \226\128\186", "SALTAR  \226\128\186", "PULAR  \226\128\186", "\208\159\208\160\208\158\208\159\208\163\208\161\208\162\208\152\208\162\208\172  \226\128\186", "\224\184\130\224\185\137\224\184\178\224\184\161  \226\128\186", "PASSER  \226\128\186"},
    {
        "Best of 5: win three rounds to take the match. One life per round.",
        "Al mejor de 5: gana tres rondas para llevarte la partida. Una vida por ronda.",
        "Melhor de 5: ven\195\167a tr\195\170s rodadas para levar a partida. Uma vida por rodada.",
        "\208\148\208\190 \209\130\209\128\209\145\209\133 \208\191\208\190\208\177\208\181\208\180: \208\178\209\139\208\184\208\179\209\128\208\176\208\185\209\130\208\181 \209\130\209\128\208\184 \209\128\208\176\209\131\208\189\208\180\208\176, \209\135\209\130\208\190\208\177\209\139 \208\178\208\183\209\143\209\130\209\140 \208\188\208\176\209\130\209\135. \208\158\208\180\208\189\208\176 \208\182\208\184\208\183\208\189\209\140 \208\189\208\176 \209\128\208\176\209\131\208\189\208\180.",
        "\224\184\138\224\184\153\224\184\176 3 \224\185\131\224\184\153 5: \224\184\138\224\184\153\224\184\176\224\184\170\224\184\178\224\184\161\224\184\163\224\184\173\224\184\154\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\184\132\224\184\167\224\185\137\224\184\178\224\185\129\224\184\161\224\184\149\224\184\138\224\185\140 \224\184\171\224\184\153\224\184\182\224\185\136\224\184\135\224\184\138\224\184\181\224\184\167\224\184\180\224\184\149\224\184\149\224\185\136\224\184\173\224\184\163\224\184\173\224\184\154",
        "Au meilleur des 5 : gagnez trois manches pour remporter la partie. Une vie par manche."
    },
    {
        "Arrows drop over distance. Aim a little high on far targets.",
        "Las flechas caen con la distancia. Apunta un poco m\195\161s alto a los blancos lejanos.",
        "As flechas caem com a dist\195\162ncia. Mire um pouco acima em alvos distantes.",
        "\208\161\209\130\209\128\208\181\208\187\209\139 \208\191\208\176\208\180\208\176\209\142\209\130 \208\189\208\176 \209\128\208\176\209\129\209\129\209\130\208\190\209\143\208\189\208\184\208\184. \208\159\208\190 \208\180\208\176\208\187\209\140\208\189\208\184\208\188 \209\134\208\181\208\187\209\143\208\188 \209\134\208\181\208\187\209\140\209\130\208\181\209\129\209\140 \209\135\209\131\209\130\209\140 \208\178\209\139\209\136\208\181.",
        "\224\184\165\224\184\185\224\184\129\224\184\152\224\184\153\224\184\185\224\184\136\224\184\176\224\184\149\224\184\129\224\184\149\224\184\178\224\184\161\224\184\163\224\184\176\224\184\162\224\184\176 \224\185\128\224\184\165\224\185\135\224\184\135\224\184\170\224\184\185\224\184\135\224\184\130\224\184\182\224\185\137\224\184\153\224\185\128\224\184\165\224\185\135\224\184\129\224\184\153\224\185\137\224\184\173\224\184\162\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\162\224\184\180\224\184\135\224\185\128\224\184\155\224\185\137\224\184\178\224\184\151\224\184\181\224\185\136\224\184\173\224\184\162\224\184\185\224\185\136\224\185\132\224\184\129\224\184\165",
        "Les fl\195\168ches retombent avec la distance. Visez un peu plus haut sur les cibles lointaines."
    },
    {
        "Headshots hit much harder. Aim for the head.",
        "Los tiros a la cabeza pegan mucho m\195\161s fuerte. Apunta a la cabeza.",
        "Tiros na cabe\195\167a causam muito mais dano. Mire na cabe\195\167a.",
        "\208\159\208\190\208\191\208\176\208\180\208\176\208\189\208\184\209\143 \208\178 \208\179\208\190\208\187\208\190\208\178\209\131 \208\177\209\140\209\142\209\130 \208\179\208\190\209\128\208\176\208\183\208\180\208\190 \209\129\208\184\208\187\209\140\208\189\208\181\208\181. \208\166\208\181\208\187\209\140\209\130\208\181\209\129\209\140 \208\178 \208\179\208\190\208\187\208\190\208\178\209\131.",
        "\224\184\129\224\184\178\224\184\163\224\184\162\224\184\180\224\184\135\224\185\130\224\184\148\224\184\153\224\184\171\224\184\177\224\184\167\224\185\129\224\184\163\224\184\135\224\184\129\224\184\167\224\185\136\224\184\178\224\184\161\224\184\178\224\184\129 \224\185\128\224\184\165\224\185\135\224\184\135\224\184\151\224\184\181\224\185\136\224\184\171\224\184\177\224\184\167",
        "Les tirs \195\160 la t\195\170te font bien plus mal. Visez la t\195\170te."
    },
    {
        "Slide into cover, then jump out swinging.",
        "Desl\195\173zate a cubierto y sal saltando al ataque.",
        "Deslize at\195\169 a cobertura e saia pulando no ataque.",
        "\208\159\208\190\208\180\208\186\208\176\209\130\208\190\208\188 \208\178 \209\131\208\186\209\128\209\139\209\130\208\184\208\181, \208\183\208\176\209\130\208\181\208\188 \208\178\209\139\208\191\209\128\209\139\208\179\208\184\208\178\208\176\208\185\209\130\208\181 \208\178 \208\176\209\130\208\176\208\186\209\131.",
        "\224\184\170\224\185\132\224\184\165\224\184\148\224\185\140\224\185\128\224\184\130\224\185\137\224\184\178\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\154\224\184\177\224\184\135 \224\185\129\224\184\165\224\185\137\224\184\167\224\184\129\224\184\163\224\184\176\224\185\130\224\184\148\224\184\148\224\184\173\224\184\173\224\184\129\224\184\161\224\184\178\224\185\130\224\184\136\224\184\161\224\184\149\224\184\181",
        "Glissez \195\160 couvert, puis jaillissez en frappant."
    },
    {
        "When the ring of fire closes in, fight in the middle or burn.",
        "Cuando el anillo de fuego se cierre, pelea en el centro o arde.",
        "Quando o anel de fogo fechar, lute no meio ou queime.",
        "\208\154\208\190\208\179\208\180\208\176 \208\190\208\179\208\189\208\181\208\189\208\189\208\190\208\181 \208\186\208\190\208\187\209\140\209\134\208\190 \209\129\208\182\208\184\208\188\208\176\208\181\209\130\209\129\209\143, \208\177\208\181\208\185\209\130\208\181\209\129\209\140 \208\178 \209\134\208\181\208\189\209\130\209\128\208\181 \208\184\208\187\208\184 \209\129\208\179\208\190\209\128\208\184\209\130\208\181.",
        "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\167\224\184\135\224\185\132\224\184\159\224\184\171\224\184\148\224\185\128\224\184\130\224\185\137\224\184\178\224\184\161\224\184\178 \224\184\170\224\184\185\224\185\137\224\184\149\224\184\163\224\184\135\224\184\129\224\184\165\224\184\178\224\184\135\224\184\171\224\184\163\224\184\183\224\184\173\224\185\132\224\184\161\224\185\136\224\184\129\224\185\135\224\185\130\224\184\148\224\184\153\224\185\132\224\184\159\224\185\128\224\184\156\224\184\178",
        "Quand l'anneau de feu se resserre, battez-vous au centre ou br\195\187lez."
    },
    {
        "Open LOADOUT and spend your gear points on any mix you like.",
        "Abre EQUIPAMIENTO y gasta tus puntos de equipo como quieras.",
        "Abra EQUIPAMENTO e gaste seus pontos de equipamento como quiser.",
        "\208\158\209\130\208\186\209\128\208\190\208\185\209\130\208\181 \208\161\208\157\208\144\208\160\208\175\208\150\208\149\208\157\208\152\208\149 \208\184 \209\130\209\128\208\176\209\130\209\140\209\130\208\181 \208\190\209\135\208\186\208\184 \209\129\208\189\208\176\209\128\209\143\208\182\208\181\208\189\208\184\209\143 \208\186\208\176\208\186 \209\131\208\179\208\190\208\180\208\189\208\190.",
        "\224\185\128\224\184\155\224\184\180\224\184\148 \224\184\138\224\184\184\224\184\148\224\184\173\224\184\184\224\184\155\224\184\129\224\184\163\224\184\147\224\185\140 \224\185\129\224\184\165\224\185\137\224\184\167\224\185\131\224\184\138\224\185\137\224\185\129\224\184\149\224\185\137\224\184\161\224\184\173\224\184\184\224\184\155\224\184\129\224\184\163\224\184\147\224\185\140\224\184\136\224\184\177\224\184\148\224\184\138\224\184\184\224\184\148\224\185\132\224\184\148\224\185\137\224\184\149\224\184\178\224\184\161\224\185\131\224\184\136",
        "Ouvrez \195\137QUIPEMENT et d\195\169pensez vos points d'\195\169quipement comme vous voulez."
    },
    {
        "Ammo is part of your loadout: bring enough arrows for the round.",
        "La munici\195\179n es parte de tu equipamiento: lleva flechas suficientes para la ronda.",
        "A muni\195\167\195\163o faz parte do seu equipamento: leve flechas suficientes para a rodada.",
        "\208\145\208\190\208\181\208\191\209\128\208\184\208\191\208\176\209\129\209\139 \208\178\209\133\208\190\208\180\209\143\209\130 \208\178 \209\129\208\189\208\176\209\128\209\143\208\182\208\181\208\189\208\184\208\181: \208\177\208\181\209\128\208\184\209\130\208\181 \208\180\208\190\209\129\209\130\208\176\209\130\208\190\209\135\208\189\208\190 \209\129\209\130\209\128\208\181\208\187 \208\189\208\176 \209\128\208\176\209\131\208\189\208\180.",
        "\224\184\129\224\184\163\224\184\176\224\184\170\224\184\184\224\184\153\224\185\128\224\184\155\224\185\135\224\184\153\224\184\170\224\185\136\224\184\167\224\184\153\224\184\171\224\184\153\224\184\182\224\185\136\224\184\135\224\184\130\224\184\173\224\184\135\224\184\138\224\184\184\224\184\148\224\184\173\224\184\184\224\184\155\224\184\129\224\184\163\224\184\147\224\185\140: \224\184\158\224\184\129\224\184\165\224\184\185\224\184\129\224\184\152\224\184\153\224\184\185\224\185\131\224\184\171\224\185\137\224\184\158\224\184\173\224\184\170\224\184\179\224\184\171\224\184\163\224\184\177\224\184\154\224\184\151\224\184\177\224\185\137\224\184\135\224\184\163\224\184\173\224\184\154",
        "Les munitions font partie de votre \195\169quipement : prenez assez de fl\195\168ches pour la manche."
    },
    {
        "Hold block with the Iron Sword to soften hits from the front.",
        "Mant\195\169n el bloqueo con la Espada de Hierro para amortiguar los golpes de frente.",
        "Segure o bloqueio com a Espada de Ferro para amortecer golpes de frente.",
        "\208\148\208\181\209\128\208\182\208\184\209\130\208\181 \208\177\208\187\208\190\208\186 \208\150\208\181\208\187\208\181\208\183\208\189\209\139\208\188 \208\188\208\181\209\135\208\190\208\188, \209\135\209\130\208\190\208\177\209\139 \209\129\208\188\209\143\208\179\209\135\208\176\209\130\209\140 \209\131\208\180\208\176\209\128\209\139 \209\129\208\191\208\181\209\128\208\181\208\180\208\184.",
        "\224\184\129\224\184\148\224\184\132\224\185\137\224\184\178\224\184\135\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153\224\184\148\224\185\137\224\184\167\224\184\162\224\184\148\224\184\178\224\184\154\224\185\128\224\184\171\224\184\165\224\185\135\224\184\129 \224\184\165\224\184\148\224\184\132\224\184\167\224\184\178\224\184\161\224\185\129\224\184\163\224\184\135\224\184\130\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\185\130\224\184\136\224\184\161\224\184\149\224\184\181\224\184\136\224\184\178\224\184\129\224\184\148\224\185\137\224\184\178\224\184\153\224\184\171\224\184\153\224\185\137\224\184\178",
        "Maintenez la parade avec l'\195\137p\195\169e de fer pour amortir les coups de face."
    },
    {
        "Throwing knives: 5 per round. Make them count.",
        "Cuchillos arrojadizos: 5 por ronda. Que cuenten.",
        "Facas de arremesso: 5 por rodada. Fa\195\167a valer.",
        "\208\156\208\181\209\130\208\176\209\130\208\181\208\187\209\140\208\189\209\139\208\181 \208\189\208\190\208\182\208\184: 5 \208\183\208\176 \209\128\208\176\209\131\208\189\208\180. \208\157\208\181 \209\130\209\128\208\176\209\130\209\140\209\130\208\181 \208\183\209\128\209\143.",
        "\224\184\161\224\184\181\224\184\148\224\184\130\224\184\167\224\185\137\224\184\178\224\184\135: 5 \224\185\128\224\184\165\224\185\136\224\184\161\224\184\149\224\185\136\224\184\173\224\184\163\224\184\173\224\184\154 \224\185\131\224\184\138\224\185\137\224\185\131\224\184\171\224\185\137\224\184\132\224\184\184\224\185\137\224\184\161",
        "Couteaux de lancer : 5 par manche. Ne les g\195\162chez pas."
    },
    {
        "Practise on the dummies in the lobby's training range.",
        "Practica con los mu\195\177ecos en la zona de entrenamiento del lobby.",
        "Pratique nos bonecos na \195\161rea de treino do lobby.",
        "\208\162\209\128\208\181\208\189\208\184\209\128\209\131\208\185\209\130\208\181\209\129\209\140 \208\189\208\176 \208\188\208\176\208\189\208\181\208\186\208\181\208\189\208\176\209\133 \208\189\208\176 \208\191\208\190\208\187\208\184\208\179\208\190\208\189\208\181 \208\178 \208\187\208\190\208\177\208\177\208\184.",
        "\224\184\157\224\184\182\224\184\129\224\184\129\224\184\177\224\184\154\224\184\171\224\184\184\224\185\136\224\184\153\224\185\131\224\184\153\224\184\165\224\184\178\224\184\153\224\184\157\224\184\182\224\184\129\224\184\130\224\184\173\224\184\135\224\184\165\224\185\135\224\184\173\224\184\154\224\184\154\224\184\181\224\185\137",
        "Entra\195\174nez-vous sur les mannequins du terrain d'entra\195\174nement du lobby."
    }
}
pcall(
    function()
        --[[
          line: 48
          upvalues:
            RunService_upv_1 (copy, index: 1)
            Workspace_upv_1 (copy, index: 2)
            tbl_upv_1 (copy, index: 3)
        ]]
        local LocalizationService_1 = game:GetService("LocalizationService")
        if LocalizationService_1:FindFirstChild("TribesLoading") then
            return
        end
        local tbl_2 = {"es", "pt", "ru", "th", "fr"}
        local v1
        if RunService_upv_1:IsStudio() then
            v1 = Workspace_upv_1:GetAttribute("LocTest")
        else
            v1 = nil
        end
        local tbl_3 = {}
        for _, value_1 in tbl_upv_1 do
            local tbl_4 = {}
            for key_1, value_2 in tbl_2 do
                tbl_4[value_2] = value_1[key_1 + 1]
                if value_2 == v1 then
                    tbl_4["en-us"] = value_1[key_1 + 1]
                end
            end
            table.insert(tbl_3, {Key = "", Example = "", Context = "", Source = value_1[1], Values = tbl_4})
        end
        local v2 = Instance.new("LocalizationTable")
        v2.Name = "TribesLoading"
        local v3
        if type(v1) == "string" and (table.find(tbl_2, v1)) then
            v3 = "zz-zz"
        else
            v3 = "en-us"
        end
        v2.SourceLocaleId = v3
        v2:SetEntries(tbl_3)
        v2.Parent = LocalizationService_1
    end
)
local function touchLayout()
    --[[
      name: touchLayout
      line: 74
      upvalues:
        UserInputService_upv_1 (copy, index: 1)
    ]]
    if UserInputService_upv_1.TouchEnabled then
        if UserInputService_upv_1.KeyboardEnabled and UserInputService_upv_1.MouseEnabled then
            local success_1, v4 = pcall(function() end)
            return success_1 and (v4 == true)
        end
        return true
    end
    return false
end
local u2
if UserInputService_upv_1.TouchEnabled then
    if (UserInputService_upv_1.KeyboardEnabled) and (UserInputService_upv_1.MouseEnabled) then
        local success_2, v5 = pcall(
            function()
                --[[
                  line: 81
                  upvalues:
                    UserInputService_upv_1 (copy, index: 1)
                ]]
                return UserInputService_upv_1.PreferredInput == Enum.PreferredInput.Touch
            end
        )
        u2 = success_2 and (v5 == true)
    else
        u2 = true
    end
else
    u2 = false
end
local v6 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local v7 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold)
local v8 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold)
local v9 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)
local v10 = Color3.fromRGB(6, 7, 10)
local v11 = Color3.fromRGB(40, 150, 255)
local v12 = Color3.fromRGB(236, 240, 247)
local function tween(a1, a2, a3, a4, a5)
    --[[
      name: tween
      line: 117
      upvalues:
        TweenService_upv_1 (copy, index: 1)
    ]]
    local v13 = a4 or (Enum.EasingStyle.Quint)
    local v14 = TweenService_upv_1:Create(a1, TweenInfo.new(a2, v13, a5 or (Enum.EasingDirection.Out)), a3)
    v14:Play()
    return v14
end
local tbl_5 = {Name = "TR_Loading", DisplayOrder = 100, ResetOnSpawn = false, IgnoreGuiInset = true}
tbl_5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
tbl_5.Parent = PlayerGui_upv_1
local v15 = Instance.new("ScreenGui")
for key_2, value_3 in tbl_5 do
    if key_2 ~= "Parent" then
        v15[key_2] = value_3
    end
end
if v15:IsA("GuiObject") then
    v15.BorderSizePixel = 0
end
if tbl_5.Parent then
    v15.Parent = tbl_5.Parent
end
v15.ScreenInsets = Enum.ScreenInsets.None
local tbl_upv_6 = {Active = true}
tbl_upv_6.Size = UDim2.fromScale(1, 1)
tbl_upv_6.BackgroundColor3 = Color3.new(1, 1, 1)
tbl_upv_6.Parent = v15
local tbl_upv_7 = {}
local tbl_8 = {Rotation = 90}
tbl_8.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 30, 40)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(14, 16, 22)), ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 7, 10))})
local v16 = Instance.new("UIGradient")
for key_3, value_4 in tbl_8 do
    if key_3 ~= "Parent" then
        v16[key_3] = value_4
    end
end
if v16:IsA("GuiObject") then
    v16.BorderSizePixel = 0
end
if tbl_8.Parent then
    v16.Parent = tbl_8.Parent
end
tbl_upv_7[1] = v16
local v19 = (function(a1, a2, a3)
    --[[
      line: 96
    ]]
    local v18 = Instance.new(a1)
    for key_4, value_5 in a2 do
        if key_4 ~= "Parent" then
            v18[key_4] = value_5
        end
    end
    if v18:IsA("GuiObject") then
        v18.BorderSizePixel = 0
    end
    if a3 then
        for _, value_6 in a3 do
            value_6.Parent = v18
        end
    end
    if a2.Parent then
        v18.Parent = a2.Parent
    end
    return v18
end)("Frame", tbl_upv_6, tbl_upv_7)
if u2 then
    local _ = Vector2.new(1280, 600)
else
    local u3 = Vector2.new(1600, 900)
end
tbl_upv_7 = {BackgroundTransparency = 1}
tbl_upv_7.Size = UDim2.fromScale(1, 1)
tbl_upv_7.Parent = v15
tbl_upv_6 = Instance.new("Frame")
for key_5, value_7 in tbl_upv_7 do
    if key_5 ~= "Parent" then
        tbl_upv_6[key_5] = value_7
    end
end
if tbl_upv_6:IsA("GuiObject") then
    tbl_upv_6.BorderSizePixel = 0
end
if tbl_upv_7.Parent then
    tbl_upv_6.Parent = tbl_upv_7.Parent
end
local tbl_9 = {}
tbl_9.Parent = tbl_upv_6
tbl_upv_7 = Instance.new("UIScale")
for key_6, value_8 in tbl_9 do
    if key_6 ~= "Parent" then
        tbl_upv_7[key_6] = value_8
    end
end
if tbl_upv_7:IsA("GuiObject") then
    tbl_upv_7.BorderSizePixel = 0
end
if tbl_9.Parent then
    tbl_upv_7.Parent = tbl_9.Parent
end
local u3
local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
local tbl_upv_10 = CurrentCamera_1 and CurrentCamera_1.ViewportSize or u3
local v20 = math.clamp(math.min(tbl_upv_10.X / u3.X, tbl_upv_10.Y / u3.Y), 0.4, 1.6)
tbl_upv_7.Scale = v20
tbl_upv_6.Size = UDim2.fromScale(1 / v20, 1 / v20)
local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
local function rescale()
    --[[
      name: rescale
      line: 152
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        u3 (copy, index: 2)
        tbl_upv_7 (copy, index: 3)
        tbl_upv_6 (copy, index: 4)
    ]]
    local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
    local v21 = CurrentCamera_3 and CurrentCamera_3.ViewportSize or u3
    local v22 = math.clamp(math.min(v21.X / u3.X, v21.Y / u3.Y), 0.4, 1.6)
    tbl_upv_7.Scale = v22
    tbl_upv_6.Size = UDim2.fromScale(1 / v22, 1 / v22)
end
local v23 = CurrentCamera_2 and (Workspace_upv_1.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rescale))
tbl_upv_10 = {BackgroundTransparency = 1}
tbl_upv_10.Size = UDim2.fromOffset(1, 1)
tbl_upv_10.Parent = tbl_upv_6
local u4 = Instance.new("Frame")
for key_7, value_9 in tbl_upv_10 do
    if key_7 ~= "Parent" then
        u4[key_7] = value_9
    end
end
if u4:IsA("GuiObject") then
    u4.BorderSizePixel = 0
end
if tbl_upv_10.Parent then
    u4.Parent = tbl_upv_10.Parent
end
local tbl_11 = {BackgroundTransparency = 1}
tbl_11.AnchorPoint = Vector2.new(0.5, 0.5)
tbl_11.Position = UDim2.fromScale(0.5, 0.4)
tbl_11.Size = UDim2.fromOffset(1100, 300)
tbl_11.Parent = tbl_upv_6
tbl_upv_10 = Instance.new("Frame")
for key_8, value_10 in tbl_11 do
    if key_8 ~= "Parent" then
        tbl_upv_10[key_8] = value_10
    end
end
if tbl_upv_10:IsA("GuiObject") then
    tbl_upv_10.BorderSizePixel = 0
end
if tbl_11.Parent then
    tbl_upv_10.Parent = tbl_11.Parent
end
local tbl_12 = {BackgroundTransparency = 1}
tbl_12.AnchorPoint = Vector2.new(0.5, 0)
tbl_12.Position = UDim2.fromScale(0.5, 0)
tbl_12.Size = UDim2.fromOffset(560, 116)
tbl_12.Parent = tbl_upv_10
local tbl_13 = Instance.new("Frame")
for key_9, value_11 in tbl_12 do
    if key_9 ~= "Parent" then
        tbl_13[key_9] = value_11
    end
end
if tbl_13:IsA("GuiObject") then
    tbl_13.BorderSizePixel = 0
end
if tbl_12.Parent then
    tbl_13.Parent = tbl_12.Parent
end
local tbl_14 = {Scale = 1.9}
tbl_14.Parent = tbl_13
tbl_12 = Instance.new("UIScale")
for key_10, value_12 in tbl_14 do
    if key_10 ~= "Parent" then
        tbl_12[key_10] = value_12
    end
end
if tbl_12:IsA("GuiObject") then
    tbl_12.BorderSizePixel = 0
end
if tbl_14.Parent then
    tbl_12.Parent = tbl_14.Parent
end
local tbl_15 = {AutoLocalize = false, TextTransparency = 0.7, Text = "TRIBES", BackgroundTransparency = 1, TextSize = 100}
tbl_15.Position = UDim2.fromOffset(4, 7)
tbl_15.Size = UDim2.fromScale(1, 1)
tbl_15.FontFace = v6
tbl_15.TextColor3 = Color3.new(0, 0, 0)
tbl_15.Parent = tbl_13
local v24 = Instance.new("TextLabel")
for key_11, value_13 in tbl_15 do
    if key_11 ~= "Parent" then
        v24[key_11] = value_13
    end
end
if v24:IsA("GuiObject") then
    v24.BorderSizePixel = 0
end
if tbl_15.Parent then
    v24.Parent = tbl_15.Parent
end
local v25 = nil
local v17 = v25
v17("TextLabel", {AutoLocalize = false, BackgroundTransparency = 1, Text = "TRIBES", TextSize = 100, Size = UDim2.fromScale(1, 1), FontFace = v6, TextColor3 = Color3.new(1, 1, 1), Parent = tbl_13}, {})
v25 = v17
v24 = "Frame"
local tbl_16 = {}
tbl_16.AnchorPoint = Vector2.new(0.5, 0)
tbl_16.Position = UDim2.new(0.5, 0, 0, 238)
tbl_16.Size = UDim2.fromOffset(180, 6)
tbl_16.BackgroundColor3 = v11
tbl_16.Parent = tbl_upv_10
local tbl_17 = {}
local tbl_18 = {}
tbl_18.CornerRadius = UDim.new(1, 0)
local v26 = Instance.new("UICorner")
for key_12, value_14 in tbl_18 do
    if key_12 ~= "Parent" then
        v26[key_12] = value_14
    end
end
if v26:IsA("GuiObject") then
    v26.BorderSizePixel = 0
end
if tbl_18.Parent then
    v26.Parent = tbl_18.Parent
end
v17 = v25
tbl_17[1] = v26
v25(v24, tbl_16, tbl_17)
local v44 = v17
v24 = "TextLabel"
local tbl_19 = {Text = "3V3 ARENA  \194\183  BEST OF 5", BackgroundTransparency = 1, TextSize = 28}
tbl_19.AnchorPoint = Vector2.new(0.5, 0)
tbl_19.Position = UDim2.new(0.5, 0, 0, 262)
tbl_19.Size = UDim2.fromOffset(900, 36)
tbl_19.FontFace = v7
tbl_19.TextColor3 = v12
tbl_19.Parent = tbl_upv_10
tbl_17 = {}
local tbl_20 = {Transparency = 0.3, Thickness = 2}
tbl_20.Color = v10
v26 = Instance.new("UIStroke")
for key_13, value_15 in tbl_20 do
    if key_13 ~= "Parent" then
        v26[key_13] = value_15
    end
end
if v26:IsA("GuiObject") then
    v26.BorderSizePixel = 0
end
if tbl_20.Parent then
    v26.Parent = tbl_20.Parent
end
tbl_17[1] = v26
v25(v24, tbl_16, tbl_17)
tbl_13 = {
    "Best of 5: win three rounds to take the match. One life per round.",
    "Arrows drop over distance. Aim a little high on far targets.",
    "Headshots hit much harder. Aim for the head.",
    "Slide into cover, then jump out swinging.",
    "When the ring of fire closes in, fight in the middle or burn.",
    "Open LOADOUT and spend your gear points on any mix you like.",
    "Ammo is part of your loadout: bring enough arrows for the round.",
    "Hold block with the Iron Sword to soften hits from the front.",
    "Throwing knives: 5 per round. Make them count.",
    "Practise on the dummies in the lobby's training range."
}
tbl_upv_10 = (u2 and 760) or 900
local tbl_21 = {BackgroundTransparency = 0.25}
tbl_21.AnchorPoint = Vector2.new(0.5, 1)
tbl_21.Position = UDim2.new(0.5, 0, 1, -112)
tbl_21.Size = UDim2.fromOffset(tbl_upv_10, 58)
tbl_21.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
tbl_21.Parent = tbl_upv_6
tbl_17 = {}
local tbl_22 = {}
tbl_22.CornerRadius = UDim.new(0, 12)
v26 = Instance.new("UICorner")
for key_14, value_16 in tbl_22 do
    if key_14 ~= "Parent" then
        v26[key_14] = value_16
    end
end
if v26:IsA("GuiObject") then
    v26.BorderSizePixel = 0
end
if tbl_22.Parent then
    v26.Parent = tbl_22.Parent
end
local tbl_23 = {Transparency = 0.7, Thickness = 2}
tbl_23.Color = v12
local v27 = Instance.new("UIStroke")
for key_15, value_17 in tbl_23 do
    if key_15 ~= "Parent" then
        v27[key_15] = value_17
    end
end
if v27:IsA("GuiObject") then
    v27.BorderSizePixel = 0
end
if tbl_23.Parent then
    v27.Parent = tbl_23.Parent
end
tbl_17[1], tbl_17[2] = v26, v27
local u5 = v17("Frame", tbl_21, tbl_17)
local tbl_24 = {BackgroundTransparency = 1, Text = "TIP", TextSize = 24}
tbl_24.Position = UDim2.fromOffset(18, 0)
tbl_24.Size = UDim2.new(0, 60, 1, 0)
tbl_24.FontFace = v6
tbl_24.TextColor3 = v11
tbl_24.Parent = u5
v24 = Instance.new("TextLabel")
for key_16, value_18 in tbl_24 do
    if key_16 ~= "Parent" then
        v24[key_16] = value_18
    end
end
if v24:IsA("GuiObject") then
    v24.BorderSizePixel = 0
end
if tbl_24.Parent then
    v24.Parent = tbl_24.Parent
end
tbl_24 = {TextWrapped = true, BackgroundTransparency = 1, TextSize = 19}
tbl_24.Position = UDim2.fromOffset(84, 0)
tbl_24.Size = UDim2.new(1, -102, 1, 0)
tbl_24.Text = tbl_13[math.random(1, #tbl_13)]
tbl_24.FontFace = v9
tbl_24.TextColor3 = v12
tbl_24.TextXAlignment = Enum.TextXAlignment.Left
tbl_24.Parent = u5
v24 = Instance.new("TextLabel")
for key_17, value_19 in tbl_24 do
    if key_17 ~= "Parent" then
        v24[key_17] = value_19
    end
end
if v24:IsA("GuiObject") then
    v24.BorderSizePixel = 0
end
if tbl_24.Parent then
    v24.Parent = tbl_24.Parent
end
v17 = v25
v24 = "Frame"
local tbl_25 = {BackgroundTransparency = 0.2}
tbl_25.AnchorPoint = Vector2.new(0.5, 1)
tbl_25.Position = UDim2.new(0.5, 0, 1, -62)
tbl_25.Size = UDim2.fromOffset(tbl_upv_10, 14)
tbl_25.BackgroundColor3 = v10
tbl_25.Parent = tbl_upv_6
local tbl_26 = {}
local tbl_27 = {}
tbl_27.CornerRadius = UDim.new(1, 0)
local tbl_28 = Instance.new("UICorner")
for key_18, value_20 in tbl_27 do
    if key_18 ~= "Parent" then
        tbl_28[key_18] = value_20
    end
end
if tbl_28:IsA("GuiObject") then
    tbl_28.BorderSizePixel = 0
end
if tbl_27.Parent then
    tbl_28.Parent = tbl_27.Parent
end
local tbl_29 = {Transparency = 0.6, Thickness = 2}
tbl_29.Color = v12
local v28 = Instance.new("UIStroke")
for key_19, value_21 in tbl_29 do
    if key_19 ~= "Parent" then
        v28[key_19] = value_21
    end
end
if v28:IsA("GuiObject") then
    v28.BorderSizePixel = 0
end
if tbl_29.Parent then
    v28.Parent = tbl_29.Parent
end
v17 = v25
tbl_26[1], tbl_26[2] = tbl_28, v28
local u6 = v17(v24, tbl_25, tbl_26)
v24 = "Frame"
tbl_25 = {}
tbl_25.Size = UDim2.fromScale(0.04, 1)
tbl_25.BackgroundColor3 = Color3.new(1, 1, 1)
tbl_25.Parent = u6
tbl_26 = {}
local tbl_30 = {}
tbl_30.CornerRadius = UDim.new(1, 0)
tbl_28 = Instance.new("UICorner")
for key_20, value_22 in tbl_30 do
    if key_20 ~= "Parent" then
        tbl_28[key_20] = value_22
    end
end
if tbl_28:IsA("GuiObject") then
    tbl_28.BorderSizePixel = 0
end
if tbl_30.Parent then
    tbl_28.Parent = tbl_30.Parent
end
local tbl_31 = {}
tbl_31.Color = ColorSequence.new(Color3.fromRGB(90, 180, 255), Color3.fromRGB(28, 132, 246))
local v29 = Instance.new("UIGradient")
for key_21, value_23 in tbl_31 do
    if key_21 ~= "Parent" then
        v29[key_21] = value_23
    end
end
if v29:IsA("GuiObject") then
    v29.BorderSizePixel = 0
end
if tbl_31.Parent then
    v29.Parent = tbl_31.Parent
end
tbl_26[1], tbl_26[2] = tbl_28, v29
local u7 = v17(v24, tbl_25, tbl_26)
local tbl_32 = {Text = "LOADING\226\128\166", BackgroundTransparency = 1, TextSize = 16}
tbl_32.AnchorPoint = Vector2.new(0.5, 1)
tbl_32.Position = UDim2.new(0.5, 0, 1, -28)
tbl_32.Size = UDim2.fromOffset(900, 24)
tbl_32.FontFace = v8
tbl_32.TextColor3 = Color3.fromRGB(130, 138, 156)
tbl_32.Parent = tbl_upv_6
local u8 = Instance.new("TextLabel")
for key_22, value_24 in tbl_32 do
    if key_22 ~= "Parent" then
        u8[key_22] = value_24
    end
end
if u8:IsA("GuiObject") then
    u8.BorderSizePixel = 0
end
if tbl_32.Parent then
    u8.Parent = tbl_32.Parent
end
local u9 = false
local u10 = false
tbl_28 = {Visible = false, FontFace = 0, TextColor3 = 0, TextTransparency = 1, Text = "SKIP  \226\128\186", AutoButtonColor = false, Parent = 0, Name = "Skip", Position = 0, BackgroundColor3 = 0, BackgroundTransparency = 1, TextScaled = true, Size = 0}
tbl_28.AnchorPoint = Vector2.new(1, 1)
local v30
if u2 then
    v30 = UDim2.new(1, -70, 1, -40)
else
    v30 = UDim2.new(1, -36, 1, -36)
end
tbl_28.Position = v30
local v31
if u2 then
    v31 = UDim2.fromOffset(210, 80)
else
    v31 = UDim2.fromOffset(180, 62)
end
tbl_28.Size = v31
tbl_28.BackgroundColor3 = Color3.fromRGB(28, 132, 246)
tbl_28.FontFace = v6
tbl_28.TextColor3 = v12
tbl_28.Parent = tbl_upv_6
local tbl_33 = {}
local tbl_34 = {}
tbl_34.CornerRadius = UDim.new(1, 0)
tbl_31 = Instance.new("UICorner")
for key_23, value_25 in tbl_34 do
    if key_23 ~= "Parent" then
        tbl_31[key_23] = value_25
    end
end
if tbl_31:IsA("GuiObject") then
    tbl_31.BorderSizePixel = 0
end
if tbl_34.Parent then
    tbl_31.Parent = tbl_34.Parent
end
local tbl_35 = {MaxTextSize = 0, MinTextSize = 14}
tbl_35.MaxTextSize = (u2 and 34) or 28
tbl_34 = Instance.new("UITextSizeConstraint")
for key_24, value_26 in tbl_35 do
    if key_24 ~= "Parent" then
        tbl_34[key_24] = value_26
    end
end
if tbl_34:IsA("GuiObject") then
    tbl_34.BorderSizePixel = 0
end
if tbl_35.Parent then
    tbl_34.Parent = tbl_35.Parent
end
local tbl_36 = {}
tbl_36.PaddingLeft = UDim.new(0, 14)
tbl_36.PaddingRight = UDim.new(0, 14)
tbl_35 = Instance.new("UIPadding")
for key_25, value_27 in tbl_36 do
    if key_25 ~= "Parent" then
        tbl_35[key_25] = value_27
    end
end
if tbl_35:IsA("GuiObject") then
    tbl_35.BorderSizePixel = 0
end
if tbl_36.Parent then
    tbl_35.Parent = tbl_36.Parent
end
tbl_33[1], tbl_33[2], tbl_33[3] = tbl_31, tbl_34, tbl_35
local u11 = v17("TextButton", tbl_28, tbl_33)
local tbl_37 = {Thickness = 3, Transparency = 1}
tbl_37.Color = v11
tbl_37.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tbl_37.Parent = u11
local u12 = Instance.new("UIStroke")
for key_26, value_28 in tbl_37 do
    if key_26 ~= "Parent" then
        u12[key_26] = value_28
    end
end
if u12:IsA("GuiObject") then
    u12.BorderSizePixel = 0
end
if tbl_37.Parent then
    u12.Parent = tbl_37.Parent
end
v17 = function()
    --[[
      name: footer
      line: 338
      upvalues:
        tbl_upv_7 (copy, index: 1)
        tbl_upv_6 (copy, index: 2)
        u11 (copy, index: 3)
        u2 (copy, index: 4)
        tbl_upv_10 (copy, index: 5)
        u5 (copy, index: 6)
        u6 (copy, index: 7)
        u8 (copy, index: 8)
    ]]
    local v32 = math.max(tbl_upv_7.Scale, 0.01)
    local v33 = tbl_upv_6.AbsoluteSize.X / v32
    if v33 < 10 then
        return
    end
    local v34 = (u11.AbsolutePosition.X - tbl_upv_6.AbsolutePosition.X) / v32
    if u11.AbsoluteSize.X < 1 then
        v34 = v33 - ((u2 and 280) or 216)
    end
    local v35 = math.min(v33 - 40, v34 - 16)
    v34 = math.min(tbl_upv_10, v35 - 40)
    local v36 = math.max((v34 / 2) + 40, math.min(v33 / 2, v35 - (v34 / 2)))
    u5.Size = UDim2.fromOffset(v34, 58)
    u5.Position = UDim2.new(0, v36, 1, -112)
    u6.Size = UDim2.fromOffset(v34, 14)
    u6.Position = UDim2.new(0, v36, 1, -62)
    u8.Size = UDim2.fromOffset(v34, 24)
    u8.Position = UDim2.new(0, v36, 1, -28)
end
v17()
tbl_upv_6:GetPropertyChangedSignal("AbsoluteSize"):Connect(v17)
u11:GetPropertyChangedSignal("AbsolutePosition"):Connect(v17)
task.delay(
    0.6,
    function()
        --[[
          line: 362
          upvalues:
            u10 (ref,  index: 1)
            u11 (copy, index: 2)
            TweenService_upv_1 (copy, index: 3)
            u12 (copy, index: 4)
        ]]
        if u10 then
            return
        end
        u11.Visible = true
        local tbl_38 = {BackgroundTransparency = 0.1, TextTransparency = 0}
        TweenService_upv_1:Create(u11, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_38):Play()
        local tbl_39 = {Transparency = 0}
        TweenService_upv_1:Create(u12, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_39):Play()
    end
)
u11.Activated:Connect(
    function()
        --[[
          line: 370
          upvalues:
            u9 (ref, index: 1)
        ]]
        u9 = true
    end
)
local v37 = UserInputService_upv_1.InputBegan:Connect(
    function(a1)
        --[[
          line: 373
          upvalues:
            u11 (copy, index: 1)
            u9 (ref,  index: 2)
        ]]
        if not u11.Visible or a1.KeyCode ~= Enum.KeyCode.Space and a1.KeyCode ~= Enum.KeyCode.Return and a1.KeyCode ~= Enum.KeyCode.ButtonA then
            return
        end
        u9 = true
    end
)
tbl_12.Scale = 2.4
local tbl_40 = {Scale = 1.9}
TweenService_upv_1:Create(tbl_12, TweenInfo.new(0.5, Enum.EasingStyle.Back or (Enum.EasingStyle.Quint), Enum.EasingDirection.Out), tbl_40):Play()
local function characterReady()
    --[[
      name: characterReady
      line: 384
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        LocalPlayer_upv_1 (copy, index: 3)
    ]]
    if RunService_upv_1:IsStudio() and Workspace_upv_1:GetAttribute("UIHoldLoading") == true then
        return false
    end
    return LocalPlayer_upv_1.Character ~= nil
end
local u13 = 0.04
local v38 = RunService_upv_1.RenderStepped:Connect(
    function(a1)
        --[[
          line: 392
          upvalues:
            u4 (copy, index: 1)
            u1 (copy, index: 2)
            RunService_upv_1 (copy, index: 3)
            Workspace_upv_1 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 5)
            u8 (copy, index: 6)
            u13 (ref,  index: 7)
            u7 (copy, index: 8)
        ]]
        u4.Rotation = (u4.Rotation + (a1 * 3)) % 360
        local v39 = os.clock() - u1
        local v40
        if (RunService_upv_1:IsStudio()) and Workspace_upv_1:GetAttribute("UIHoldLoading") == true then
            v40 = false
        else
            v40 = LocalPlayer_upv_1.Character ~= nil
        end
        local v41
        if v40 then
            v41 = 1
            u8.Text = "READY!"
            local v42 = LocalPlayer_upv_1:GetAttribute("CharacterAtMs")
            if not (v42) then
                LocalPlayer_upv_1:SetAttribute("CharacterAtMs", (math.floor(v39 * 1000)))
            end
        else
            v41 = (1 - math.exp(-v39 / 4)) * 0.75 + 0.1
            u8.Text = ((v39 < 2) and "LOADING\226\128\166") or "ALMOST THERE\226\128\166"
        end
        u13 = u13 + (v41 - u13) * math.min(1, a1 * 6)
        u7.Size = UDim2.fromScale(math.clamp(u13, 0.04, 1), 1)
    end
)
local v43
if (RunService_upv_1:IsStudio()) and Workspace_upv_1:GetAttribute("UIHoldLoading") == true then
    v43 = 120
else
    v43 = 25
end
while not (u9) do
    if not (RunService_upv_1:IsStudio()) or Workspace_upv_1:GetAttribute("UIHoldLoading") ~= true then
        v43 = LocalPlayer_upv_1.Character ~= nil
        if v43 then
            break
        end
        if os.clock() < u1 + v43 then
            task.wait()
            continue
        else
            break
        end
    end
    v43 = false
    if v43 then
        break
    end
    if os.clock() < u1 + v43 then
        task.wait()
        continue
    else
        break
    end
end
u10 = true
v38:Disconnect()
v37:Disconnect()
if v23 then
    v23:Disconnect()
end
LocalPlayer_upv_1:SetAttribute("LoadingShownMs", (math.floor((os.clock() - u1) * 1000)))
LocalPlayer_upv_1:SetAttribute("LoadingSkipped", u9)
v19.Active = false
for v45, value_29 in v15:GetDescendants() do
    if value_29:IsA("TextLabel") or value_29:IsA("TextButton") then
        tbl_36 = {TextTransparency = 1, BackgroundTransparency = 1}
        TweenService_upv_1:Create(value_29, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_36):Play()
        continue
    end
    if value_29:IsA("Frame") then
        tbl_36 = {BackgroundTransparency = 1}
        TweenService_upv_1:Create(value_29, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_36):Play()
        continue
    end
    if value_29:IsA("UIStroke") then
        tbl_36 = {Transparency = 1}
        TweenService_upv_1:Create(value_29, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_36):Play()
    end
end
task.wait(0.3)
v15:Destroy()