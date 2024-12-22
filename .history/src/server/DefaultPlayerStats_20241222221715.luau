-- ServerScriptService/DefaultStatsModule.lua

local DefaultStatsModule = {}

-- Alles, was im Leaderboard ("leaderstats") angezeigt werden soll
DefaultStatsModule.DefaultStats = {
    Cash = 50,        -- Startgeld
    XP = 0,           -- Erfahrungspunkte
    Level = 1,        -- Spieler-Level
    SpeedLevel = 1,   -- (Beispiel) z. B. fürs Auto-Tuning
    NitroLevel = 1,   -- (Beispiel)
    DriftingSkill = 1 -- (Beispiel)
}

-- Alles, was *nicht* ins Leaderboard soll, aber du dennoch
-- pro Spieler tracken willst (Stamina, Health, etc.)
DefaultStatsModule.NonLeaderStats = {
    Stamina = 100,
    Health = 100
    -- ggf. weitere Stats
}

return DefaultStatsModule
