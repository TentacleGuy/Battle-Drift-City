-- ServerScriptService/PlayerDataHandler.lua

local DefaultStatsModule = require(script.Parent.DefaultStatsModule)

local PlayerDataHandler = {}

-- Erzeugt leaderstats (für XP, Level, Cash, etc.)
-- und NonLeaderStats (für Stamina, Health, etc.)
function PlayerDataHandler.InitializePlayerData(player)
    -- 1) Ordner "leaderstats" anlegen
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- 2) Für jedes Element in DefaultStatsModule.DefaultStats
    --    eine IntValue ins leaderstats packen
    for statName, defaultValue in pairs(DefaultStatsModule.DefaultStats) do
        local statObject = Instance.new("IntValue")
        statObject.Name = statName
        statObject.Value = defaultValue
        statObject.Parent = leaderstats
    end

    -- 3) Für Werte, die NICHT ins Leaderboard sollen (Stamina usw.):
    local nonLeaderStats = Instance.new("Folder")
    nonLeaderStats.Name = "NonLeaderStats"
    nonLeaderStats.Parent = player

    for statName, defaultValue in pairs(DefaultStatsModule.NonLeaderStats) do
        local statObject = Instance.new("IntValue")
        statObject.Name = statName
        statObject.Value = defaultValue
        statObject.Parent = nonLeaderStats
    end
end

return PlayerDataHandler
