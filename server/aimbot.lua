if returnClaireSetting("aimbotDetection") then
    local hitRateThreshold   = tonumber(returnClaireSetting("aimbotHitRateThreshold")) or 0.9
    local minimumShots       = tonumber(returnClaireSetting("aimbotMinShots")) or 50
    local tolerance          = tonumber(returnClaireSetting("aimbotTolerance")) or 3
    local decayInterval      = tonumber(returnClaireSetting("aimbotDecayInterval")) or 60000

    local stats = {}

    local function resetPlayerStats(player)
        stats[player] = { shots = 0, hits = 0, strikes = 0, lastCheck = getTickCount() }
        return stats[player]
    end

    addEventHandler("onPlayerWeaponFire", root, function(_, weapon, _, _, _, _, hit)
        if isSerialWhitelisted(getPlayerSerial(source)) then return end
        if weapon >= 16 and weapon <= 19 then return end

        local now = getTickCount()
        local data = stats[source] or resetPlayerStats(source)

        if now - data.lastCheck > decayInterval then
            data.shots = math.floor(data.shots * 0.5)
            data.hits  = math.floor(data.hits  * 0.5)
            data.strikes = math.max(0, data.strikes - 1)
        end

        data.lastCheck = now
        data.shots = data.shots + 1

        if isElement(hit) then
            local hitType = getElementType(hit)
            if hitType == "player" then
                data.hits = data.hits + 1
            elseif hitType == "vehicle" then
                for i = 0, getVehicleMaxPassengers(hit) do
                    if getVehicleOccupant(hit, i) then
                        data.hits = data.hits + 1
                        break
                    end
                end
            end
        end

        if data.shots >= minimumShots then
            local rate = data.hits / data.shots

            if rate >= hitRateThreshold then
                data.strikes = data.strikes + 1
                if data.strikes >= tolerance then
                    clairePunish(source, "Claire: Aimbot detected (" .. math.floor(rate * 100) .. "%)")
                    data.strikes = 0
                end
            else
                data.strikes = math.max(0, data.strikes - 1)
            end

            data.shots = 0
            data.hits = 0
        end

        stats[source] = data
    end)

    addEventHandler("onPlayerQuit", root, function()
        stats[source] = nil
    end)
end
