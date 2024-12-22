local PlayerDataHandler = {}

local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerDataStore")

-- Spieler-Daten laden
function PlayerDataHandler.LoadPlayerData(player)
    local data
    local success, err = pcall(function()
        data = playerDataStore:GetAsync(player.UserId)
    end)
    if success then
        return data
    else
        warn("Fehler beim Laden der Daten für " .. player.Name .. ": " .. err)
        return nil
    end
end

-- Spieler-Daten speichern
function PlayerDataHandler.SavePlayerData(player)
    local dataToSave = {
        Cash = player:GetAttribute("Cash") or 0,
        XP = player:GetAttribute("XP") or 0,
        -- Weitere Daten hinzufügen
    }
    local success, err = pcall(function()
        playerDataStore:SetAsync(player.UserId, dataToSave)
    end)
    if not success then
        warn("Fehler beim Speichern der Daten für " .. player.Name .. ": " .. err)
    end
end

-- Spieler-Daten anwenden
function PlayerDataHandler.ApplyPlayerData(player, data)
    player:SetAttribute("Cash", data.Cash or 0)
    player:SetAttribute("XP", data.XP or 0)
    -- Weitere Daten setzen
end

return PlayerDataHandler
