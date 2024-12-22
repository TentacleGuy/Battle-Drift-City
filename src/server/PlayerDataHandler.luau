-- ServerScriptService/Server/PlayerDataHandler.lua

local PlayerDataHandler = {}

local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerDataStore")

-- Spieler-Daten laden
function PlayerDataHandler.LoadPlayerData(player)
    local data
    local success, err = pcall(function()
        data = playerDataStore:GetAsync(player.UserId)
    end)
    if success and data then
        return data
    else
        if err then
            warn("Fehler beim Laden der Daten für " .. player.Name .. ": " .. err)
        end
        return nil
    end
end

-- Spieler-Daten speichern
function PlayerDataHandler.SavePlayerData(player)
    -- Alle nötigen Daten aus den Attributen holen:
    local dataToSave = {
        Cash = player:GetAttribute("Cash") or 0,
        XP = player:GetAttribute("XP") or 0,
        -- Wenn du mehr Werte hast (Level, Thirst, etc.), hier hinzufügen:
        Level = player:GetAttribute("Level") or 1,
        SpeedLevel = player:GetAttribute("SpeedLevel") or 1,
        NitroLevel = player:GetAttribute("NitroLevel") or 1,
        DriftingSkill = player:GetAttribute("DriftingSkill") or 1,

        Stamina = player:GetAttribute("Stamina") or 100,
        Health = player:GetAttribute("Health") or 100,
        Thirst = player:GetAttribute("Thirst") or 100,
    }

    local success, err = pcall(function()
        playerDataStore:SetAsync(player.UserId, dataToSave)
    end)
    if not success then
        warn("Fehler beim Speichern der Daten für " .. player.Name .. ": " .. err)
    end
end

-- Anwenden der Daten: 
-- 1) Setze Attributes am Spieler 
-- 2) Erzeuge leaderstats mit Cash/XP (und ggf. mehr)
function PlayerDataHandler.ApplyPlayerData(player, data)
    -- 1) Attributes setzen (praktisch für Server/Client-Abfragen)
    for key, value in pairs(data) do
        player:SetAttribute(key, value)
    end

    -- 2) LEADERSTATS-Ordner erstellen (nur für die wichtigsten Stats wie Cash, XP)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    -- Cash
    local cashValue = Instance.new("IntValue")
    cashValue.Name = "Cash"
    cashValue.Value = data.Cash or 0
    cashValue.Parent = leaderstats

    -- XP
    local xpValue = Instance.new("IntValue")
    xpValue.Name = "XP"
    xpValue.Value = data.XP or 0
    xpValue.Parent = leaderstats

    -- Level (falls du es im Leaderboard anzeigen willst)
    local levelValue = Instance.new("IntValue")
    levelValue.Name = "Level"
    levelValue.Value = data.Level or 1
    levelValue.Parent = leaderstats

    -- Wenn du SpeedLevel, NitroLevel, DriftingSkill etc. NICHT im Leaderboard brauchst,
    -- dann lässt du sie einfach weg. Du könntest sie sonst ebenfalls als IntValue anlegen.

    -- 3) Stamina, Health, Thirst sind hier NICHT im Leaderboard,
    --    weil's eher "Other" Stats sind. Du hast sie aber als Attribute oben gesetzt.
end

return PlayerDataHandler
