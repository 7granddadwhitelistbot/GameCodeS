local tbl_upv_1 = {}
tbl_upv_1.GAME_NAME = "Tribes"
tbl_upv_1.TEAM_SIZE = 3
tbl_upv_1.DEFAULT_MODE = "3v3"
tbl_upv_1.MODES = {["3v3"] = {matchHumans = 6, teamSize = 3}, ["1v1"] = {matchHumans = 2, teamSize = 1}}
tbl_upv_1.DUEL_TROPHY_MULT = 0.65
tbl_upv_1.DUEL_UNLOCK_MATCHES = 3
tbl_upv_1.ROUNDS_TO_WIN = 3
tbl_upv_1.INTRO_TIME = 3
tbl_upv_1.INTRO_MAX_EXTRA = 4
tbl_upv_1.PRE_ROUND_TIME = 8
tbl_upv_1.LOADOUT_SWAP_CUTOFF = 0.3
tbl_upv_1.ROUND_TIME = 60
tbl_upv_1.OVERTIME_TIME = 25
tbl_upv_1.OVERTIME_HOLD = 10
tbl_upv_1.OVERTIME_DPS = 8
tbl_upv_1.ROUND_END_TIME = 4
tbl_upv_1.MATCH_END_TIME = 60
tbl_upv_1.RESULTS_AUTO_REQUEUE = 20
tbl_upv_1.REMATCH_GATHER = 5
tbl_upv_1.RESULTS_SEARCH_HOLD = 60
tbl_upv_1.CUSTOM_RESULTS_TIME = 15
tbl_upv_1.MAX_HEALTH = 100
tbl_upv_1.FALL_CREDIT_WINDOW = 8
tbl_upv_1.ASSIST_MIN_DAMAGE = 20
tbl_upv_1.ACTIVE_MIN_MOVE = 60
tbl_upv_1.FORFEIT_MMR_FLOOR = 950
tbl_upv_1.QUEUE_BOT_WAIT = 8
tbl_upv_1.BOT_MOBILE_MULT = 0.75
tbl_upv_1.FIRST_MATCH_MAP = "FrostfangPass"
tbl_upv_1.RANDOM_PICK_OFF = {OvergrownRuins = true}
tbl_upv_1.MATCH_BLOCKY = true
tbl_upv_1.QUEUE_MIX_AFTER = 5
tbl_upv_1.QUEUE_NEW_PLAYER_MATCHES = 1
tbl_upv_1.QUEUE_FRIENDS_WAIT = 30
tbl_upv_1.QUEUE_FOUND_LEAD = 1
tbl_upv_1.QUEUE_TICK = 0.25
tbl_upv_1.QUEUE_REVEAL_FROM = 0.1
tbl_upv_1.QUEUE_REVEAL_TO = 0.75
tbl_upv_1.MATCH_HUMANS = 6
tbl_upv_1.WELCOME_CARD = true
tbl_upv_1.FIRST_MATCH_LOCAL_CAP = 6
tbl_upv_1.FIRST_MATCH_LOCAL_CAP_SLOW = 3
tbl_upv_1.FIRST_MATCH_SLOW_MS = 22
tbl_upv_1.FIRST_MATCH_ROUNDS_TO_WIN = 2
tbl_upv_1.FIRST_MATCH_RESPAWN = 3
tbl_upv_1.FIRST_MATCH_HURRY = 12
tbl_upv_1.STAGING_PLACE_ID = 133642991978378
tbl_upv_1.ARENA_ORIGIN = Vector3.new(5000, 0, 0)
tbl_upv_1.ARENA_SPACING = 2500
tbl_upv_1.ARENA_COLUMNS = 4
tbl_upv_1.MAX_ARENAS = 12
tbl_upv_1.LOBBY_CENTER = Vector3.new(0, 0, 0)
tbl_upv_1.LOBBY_HALF_SIZE = 300
tbl_upv_1.LOBBY_RESPAWN_TIME = 1
tbl_upv_1.DATASTORE_NAME = "TribesProfile_v1"
tbl_upv_1.WINS_STORE_NAME = "TribesWins_v1"
tbl_upv_1.TROPHIES_STORE_NAME = "TribesTrophies_v1"
tbl_upv_1.AUTOSAVE_INTERVAL = 90
tbl_upv_1.SAVE_CONCURRENCY = 8
tbl_upv_1.STARTING_SHELLS = 200
tbl_upv_1.STARTING_MMR = 1000
tbl_upv_1.UPDATE_COUNTDOWN = {
    at = 1792252800,
    title = "RANKED UPDATE",
    skyHours = 12,
    OUT_FOR = 172800,
    shipped = "Ranks",
    goldenHours = 6,
    ranks = {
        {hours = 40, name = "BRONZE", color = Color3.fromRGB(214, 136, 78)},
        {hours = 34, name = "SILVER", color = Color3.fromRGB(206, 216, 232)},
        {hours = 28, name = "GOLD", color = Color3.fromRGB(255, 204, 64)},
        {hours = 22, name = "PLATINUM", color = Color3.fromRGB(120, 236, 214)},
        {hours = 16, name = "DIAMOND", color = Color3.fromRGB(86, 182, 255)},
        {hours = 10, name = "MASTER", color = Color3.fromRGB(176, 104, 255)},
        {hours = 4, name = "GRANDMASTER", color = Color3.fromRGB(255, 72, 84)},
        {hours = 1, name = "IMMORTAL", color = Color3.fromRGB(255, 220, 120)}
    }
}
tbl_upv_1.TRIBES = {"Wolf", "Raven", "Bear", "Eagle", "Serpent", "Boar", "Stag", "Lynx"}
tbl_upv_1.ALLY_COLOR = Color3.fromRGB(70, 170, 255)
tbl_upv_1.ENEMY_COLOR = Color3.fromRGB(255, 72, 72)
function tbl_upv_1.Mode(a1)
    --[[
      name: Mode
      line: 179
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a1) == "string" and tbl_upv_1.MODES[a1] then
        return a1
    end
    return tbl_upv_1.DEFAULT_MODE
end
function tbl_upv_1.ArenaSlotCenter(a1)
    --[[
      name: ArenaSlotCenter
      line: 183
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = a1 - 1
    return tbl_upv_1.ARENA_ORIGIN + Vector3.new((v1 % tbl_upv_1.ARENA_COLUMNS) * tbl_upv_1.ARENA_SPACING, 0, (v1 // tbl_upv_1.ARENA_COLUMNS) * tbl_upv_1.ARENA_SPACING)
end
return tbl_upv_1