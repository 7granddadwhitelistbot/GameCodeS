local v1 = {
    GAME_NAME = "Tribes",
    TEAM_SIZE = 3,
    DEFAULT_MODE = "3v3",
    MODES = {["3v3"] = {teamSize = 3, matchHumans = 6}, ["1v1"] = {teamSize = 1, matchHumans = 2}},
    DUEL_TROPHY_MULT = 0.65,
    DUEL_UNLOCK_MATCHES = 3,
    ROUNDS_TO_WIN = 3,
    INTRO_TIME = 3,
    INTRO_MAX_EXTRA = 4,
    PRE_ROUND_TIME = 8,
    LOADOUT_SWAP_CUTOFF = 0.3,
    ROUND_TIME = 60,
    OVERTIME_TIME = 25,
    OVERTIME_HOLD = 10,
    OVERTIME_DPS = 8,
    ROUND_END_TIME = 4,
    MATCH_END_TIME = 60,
    RESULTS_AUTO_REQUEUE = 20,
    REMATCH_GATHER = 5,
    RESULTS_SEARCH_HOLD = 60,
    CUSTOM_RESULTS_TIME = 15,
    MAX_HEALTH = 100,
    FALL_CREDIT_WINDOW = 8,
    ASSIST_MIN_DAMAGE = 20,
    ACTIVE_MIN_MOVE = 60,
    FORFEIT_MMR_FLOOR = 950,
    QUEUE_BOT_WAIT = 8,
    BOT_MOBILE_MULT = 0.75,
    FIRST_MATCH_MAP = "FrostfangPass",
    RANDOM_PICK_OFF = {OvergrownRuins = true},
    MATCH_BLOCKY = true,
    QUEUE_MIX_AFTER = 5,
    QUEUE_NEW_PLAYER_MATCHES = 1,
    QUEUE_FRIENDS_WAIT = 30,
    QUEUE_FOUND_LEAD = 1,
    QUEUE_TICK = 0.25,
    QUEUE_REVEAL_FROM = 0.1,
    QUEUE_REVEAL_TO = 0.75,
    MATCH_HUMANS = 6,
    WELCOME_CARD = true,
    FIRST_MATCH_LOCAL_CAP = 6,
    FIRST_MATCH_LOCAL_CAP_SLOW = 3,
    FIRST_MATCH_SLOW_MS = 22,
    FIRST_MATCH_ROUNDS_TO_WIN = 2,
    FIRST_MATCH_RESPAWN = 3,
    FIRST_MATCH_HURRY = 12,
    STAGING_PLACE_ID = 133642991978378,
    ARENA_ORIGIN = Vector3.new(5000, 0, 0),
    ARENA_SPACING = 2500,
    ARENA_COLUMNS = 4,
    MAX_ARENAS = 12,
    LOBBY_CENTER = Vector3.new(0, 0, 0),
    LOBBY_HALF_SIZE = 300,
    LOBBY_RESPAWN_TIME = 1,
    DATASTORE_NAME = "TribesProfile_v1",
    WINS_STORE_NAME = "TribesWins_v1",
    TROPHIES_STORE_NAME = "TribesTrophies_v1",
    AUTOSAVE_INTERVAL = 90,
    SAVE_CONCURRENCY = 8,
    STARTING_MMR = 1000,
    UPDATE_COUNTDOWN = {
        title = "RANKED UPDATE",
        at = 1792252800,
        skyHours = 12,
        goldenHours = 6,
        shipped = "Ranks",
        OUT_FOR = 172800,
        ranks = {
            {name = "BRONZE", hours = 40, color = Color3.fromRGB(214, 136, 78)},
            {name = "SILVER", hours = 34, color = Color3.fromRGB(206, 216, 232)},
            {name = "GOLD", hours = 28, color = Color3.fromRGB(255, 204, 64)},
            {name = "PLATINUM", hours = 22, color = Color3.fromRGB(120, 236, 214)},
            {name = "DIAMOND", hours = 16, color = Color3.fromRGB(86, 182, 255)},
            {name = "MASTER", hours = 10, color = Color3.fromRGB(176, 104, 255)},
            {name = "GRANDMASTER", hours = 4, color = Color3.fromRGB(255, 72, 84)},
            {name = "IMMORTAL", hours = 1, color = Color3.fromRGB(255, 220, 120)}
        }
    },
    TRIBES = {"Wolf", "Raven", "Bear", "Eagle", "Serpent", "Boar", "Stag", "Lynx"},
    ALLY_COLOR = Color3.fromRGB(70, 170, 255),
    ENEMY_COLOR = Color3.fromRGB(255, 72, 72)
}

function v1.Mode(modeKey)
    --[[
      name: Mode
      line: 178
      upvalues:
        v1 (copy, index: 1)
    ]]
    if type(modeKey) == "string" and v1.MODES[modeKey] then
        return modeKey
    end

    return v1.DEFAULT_MODE
end

function v1.ArenaSlotCenter(a3)
    --[[
      name: ArenaSlotCenter
      line: 182
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v4 = a3 - 1
    return v1.ARENA_ORIGIN + Vector3.new((v4 % v1.ARENA_COLUMNS) * v1.ARENA_SPACING, 0, (v4 // v1.ARENA_COLUMNS) * v1.ARENA_SPACING)
end

return v1