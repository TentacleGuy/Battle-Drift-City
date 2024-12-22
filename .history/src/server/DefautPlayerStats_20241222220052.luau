local DefaultPlayerStats = {}

-- Standardwerte für neue Spieler
function DefaultPlayerStats.GetDefaultStats()
    return {
        Cash = 1000,
        XP = 0,
        Stamina = 100,       
        -- Weitere Werte hinzufügen
    }
end

return DefaultPlayerStats
