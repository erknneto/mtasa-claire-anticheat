if returnClaireSetting("explosionDetection") then
    local explosionLogs = {}

    addEventHandler("onExplosion", root, function()
        local player = source
        if not isElement(player) then return end

        explosionLogs[player] = explosionLogs[player] or {}
        local now = getTickCount()
        table.insert(explosionLogs[player], now)

        local threshold = now - 5000
        while explosionLogs[player][1] and explosionLogs[player][1] < threshold do
            table.remove(explosionLogs[player], 1)
        end

        if #explosionLogs[player] >= 10 then
            clairePunish(player, "Claire: Excessive explosions")
            explosionLogs[player] = {}
        end
    end)
end
