if returnClaireSetting("explosionDetection") then
    local maxExplosions = tonumber(returnClaireSetting("explosionMax")) or 10
    local intervalLimit = tonumber(returnClaireSetting("explosionInterval")) or 5000

    local explosionLogs = {}

    local function resetPlayer(player)
        explosionLogs[player] = nil
    end

    addEventHandler("onPlayerQuit", root, resetPlayer)

    addEventHandler("onExplosion", root, function(_, _, _, _, _, creator)
        local player = isElement(creator) and getElementType(creator) == "player" and creator or nil
        if not player or isSerialWhitelisted(getPlayerSerial(player)) then return end

        local now = getTickCount()
        explosionLogs[player] = explosionLogs[player] or {}
        table.insert(explosionLogs[player], now)

        local threshold = now - intervalLimit
        while explosionLogs[player][1] and explosionLogs[player][1] < threshold do
            table.remove(explosionLogs[player], 1)
        end

        if #explosionLogs[player] >= maxExplosions then
            clairePunish(player, "Claire: Excessive explosions")
            explosionLogs[player] = {}
        end
    end)
end
