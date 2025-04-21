if returnClaireSetting("fastfireDetection") then
    local tolerance     = tonumber(returnClaireSetting("fastfireTolerance")) or 3
    local resetDelay    = 10000
    local pingFactor    = 1.5

    local lastShots     = {}
    local violationCount = {}
    local recentShots   = {}

    local function clearPlayer(player)
        lastShots[player]       = nil
        violationCount[player]  = nil
        recentShots[player]     = nil
    end

    addEventHandler("onPlayerQuit", root, clearPlayer)

    setTimer(function()
        local now = getTickCount()
        for player, timestamp in pairs(recentShots) do
            if not isElement(player) or now - timestamp > resetDelay then
                clearPlayer(player)
            end
        end
    end, 2000, 0)

    addEventHandler("onPlayerWeaponFire", root, function(weapon)
        if not isElement(source) then return end
        if isSerialWhitelisted(getPlayerSerial(source)) then return end

        local interval = getWeaponProperty(weapon, "pro", "firing_speed")
        if not interval or interval <= 0 then return end

        interval = interval + (getPlayerPing(source) or 0) * pingFactor

        local now = getTickCount()
        recentShots[source] = now

        lastShots[source] = lastShots[source] or {}
        local elapsed = now - (lastShots[source][weapon] or 0)
        lastShots[source][weapon] = now

        if elapsed < interval then
            local v = (violationCount[source] or 0) + 1
            if v >= tolerance then
                clairePunish(source, "Claire: Fast fire detected (Weapon " .. weapon .. ")")
                v = 0
            end
            violationCount[source] = v
        end
    end)
end
