-- ServerScriptService/Server/CarUpgradeManager.lua

local CarUpgradeManager = {}

function CarUpgradeManager.Init()
    print("CarUpgradeManager Init")
    -- Falls du hier Startup-Logik hast, kannst du sie ausführen
end

function CarUpgradeManager.UpgradeNitro(player, amount)
    -- Die "NitroLevel" wird als Attribut gehalten
    local oldValue = player:GetAttribute("NitroLevel") or 1
    local newValue = oldValue + amount
    player:SetAttribute("NitroLevel", newValue)

    print("NitroLevel für", player.Name, "erhöht auf", newValue)

    -- Falls du es auch im Leaderboard anzeigen willst, 
    -- könntest du stattdessen in leaderstats.NitroLevel schreiben.
end

return CarUpgradeManager
