local CarUpgradeManager = {}

-- Verfügbare Upgrades
CarUpgradeManager.Upgrades = {
    Engine = {
        { Level = 1, Price = 500, Effect = "Speed +10" },
        { Level = 2, Price = 1000, Effect = "Speed +20" },
        { Level = 3, Price = 2000, Effect = "Speed +30" },
    },
    Nitro = {
        { Level = 1, Price = 300, Effect = "Boost Duration +2s" },
        { Level = 2, Price = 600, Effect = "Boost Duration +4s" },
    },
    Tires = {
        { Level = 1, Price = 200, Effect = "Grip +10%" },
        { Level = 2, Price = 400, Effect = "Grip +20%" },
    },
}

-- Funktion: Upgrade-Daten abrufen
function CarUpgradeManager.GetUpgradesForType(upgradeType)
    return CarUpgradeManager.Upgrades[upgradeType] or {}
end

return CarUpgradeManager
