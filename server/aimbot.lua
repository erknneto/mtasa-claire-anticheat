local hitRateThreshold = returnClaireSetting("aimbotHitRateThreshold") or 0.9
local minShots = returnClaireSetting("aimbotMinShots") or 50
local tolerance = returnClaireSetting("aimbotTolerance") or 3
local decayFactor = returnClaireSetting("aimbotDecayFactor") or 0.8
local decayInterval = returnClaireSetting("aimbotDecayInterval") or 60000

local playerStats = {}
local lastShotTime = {}

if returnClaireSetting("aimbotDetection") then

    function applyDecay(player)
        local stats = playerStats[player]
        if not stats then return end

        local last = lastShotTime[player]
        if last and (getTickCount() - last > decayInterval) then
            stats.shots = math.floor(stats.shots * decayFactor)
            stats.hits = math.floor(stats.hits * decayFactor)
            stats.violations = math.max(0, stats.violations - 1)
            stats.totalRecentShots = math.floor(stats.totalRecentShots * decayFactor)
            stats.recentSuspicious = false
        end
    end

    addEventHandler("onPlayerWeaponFire", root, function(_, _, _, _, _, _, hitElement)
        if not isElement(source) then return end
        local serial = getPlayerSerial(source)
        if isSerialWhitelisted(serial) then return end

        applyDecay(source)

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
