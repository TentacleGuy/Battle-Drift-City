-- ServerScriptService/Server/DefaultPlayerStats.lua

local DefaultPlayerStats = {}

DefaultPlayerStats.Stats = {
    Cash = 2000,
    XP = 0,
    Level = 1,
    SpeedLevel = 1,
    NitroLevel = 1,
    DriftingSkill = 1,
}

DefaultPlayerStats.Other = {
    Stamina = 100,
    Health = 100,
    Thirst = 100,
}

-- Du könntest hier auch eine praktische Funktion bereitstellen, 
-- um beide Tabellen zu einem Daten-Tabelle zu verschmelzen:
function DefaultPlayerStats.GetDefaultStats()
    local data = {}
    -- Leaderstats
    for statName, val in pairs(DefaultPlayerStats.Stats) do
        data[statName] = val
    end
    -- Andere Werte
    for statName, val in pairs(DefaultPlayerStats.Other) do
        data[statName] = val
    end
    return data
end

return DefaultPlayerStats
