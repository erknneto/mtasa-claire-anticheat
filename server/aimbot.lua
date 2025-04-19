local hitRateThreshold = returnClaireSetting("aimbotHitRateThreshold") or 0.9
local minShots = returnClaireSetting("aimbotMinShots") or 50
local tolerance = returnClaireSetting("aimbotTolerance") or 3

local playerStats = {}
local lastShotTime = {}

if returnClaireSetting("aimbotDetection") then

    function resetIfIdle(player)
        local last = lastShotTime[player]
        if last and (getTickCount() - last > 60000) then
            playerStats[player] = nil
            lastShotTime[player] = nil
        end
    end

    addEventHandler("onPlayerWeaponFire", root, function(_, _, _, _, _, _, hitElement)
        if not isElement(source) then return end
        local serial = getPlayerSerial(source)
        if isSerialWhitelisted(serial) then return end

        resetIfIdle(source)

        local stats = playerStats[source] or {
            shots = 0, hits = 0,
            violations = 0,
            recentSuspicious = false,
            totalRecentShots = 0
        }

        stats.shots = stats.shots + 1
        stats.totalRecentShots = stats.totalRecentShots + 1

        if isElement(hitElement) then
            local type = getElementType(hitElement)
            if type == "player" then
                stats.hits = stats.hits + 1
            elseif type == "vehicle" and getVehicleOccupant(hitElement) then
                stats.hits = stats.hits + 1
            end
        end

        lastShotTime[source] = getTickCount()

        local effectiveMinShots = (stats.totalRecentShots > 100) and 30 or minShots
        if stats.shots >= effectiveMinShots then
            local hitRate = stats.hits / stats.shots

            if hitRate >= hitRateThreshold then
                stats.violations = stats.violations + 1
                if stats.violations >= tolerance then
                    clairePunish(source, "Claire: Aimbot detected (hit rate: " .. math.floor(hitRate * 100) .. "%)")
                    stats.violations = 0
                end
            elseif hitRate >= 0.85 then
                if stats.recentSuspicious then
                    stats.violations = stats.violations + 1
                end
                stats.recentSuspicious = true
            else
                stats.violations = math.max(0, stats.violations - 1)
                stats.recentSuspicious = false
            end

            stats.shots = 0
            stats.hits = 0
        end

        playerStats[source] = stats
    end)
end
