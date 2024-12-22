-- ServerScriptService/PlayerDataHandler.lua

local DefaultStatsModule = require(script.Parent.DefaultStatsModule)

local PlayerDataHandler = {}

function PlayerDataHandler.InitializePlayerData(player)
    -- 1) Ordner "leaderstats" anlegen
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- 2) Für jeden Eintrag aus DefaultStatsModule.DefaultStats
    --    eine IntValue anlegen:
    for statName, defaultValue in pairs(DefaultStatsModule.DefaultStats) do
        local newStat = Instance.new("IntValue")
        newStat.Name = statName
        newStat.Value = defaultValue
        newStat.Parent = leaderstats
    end
end

return PlayerDataHandler
