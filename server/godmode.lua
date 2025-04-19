local tolerance = returnClaireSetting("godmodeTolerance") or 3
local vehicleMinThreshold = returnClaireSetting("godmodeVehicleMinThreshold") or 950

local lastHealths = {}
local lastVehicleHealths = {}
local violationCounts = {}
local recentlyDamaged = {}

if returnClaireSetting("godmodeDetection") then

    function checkGodmode(player)
        if not isElement(player) then return end

        local serial = getPlayerSerial(player)
        if isSerialWhitelisted(serial) then return end

        if isPedInVehicle(player) then
            local vehicle = getPedOccupiedVehicle(player)
            if not isElement(vehicle) then return end

            local vHealth = getElementHealth(vehicle)
            if not vHealth or vHealth <= 300 then
                lastVehicleHealths[player] = nil
                violationCounts[player] = 0
                return
            end

            if vHealth >= vehicleMinThreshold and vHealth < 1000 then
                local lastVHealth = lastVehicleHealths[player]
                if lastVHealth and vHealth == lastVHealth then
                    local currentViolations = violationCounts[player] or 0
                    currentViolations = currentViolations + 1

                    if currentViolations >= tolerance then
                        clairePunish(player, "Claire: Vehicle godmode detected")
                        violationCounts[player] = nil
                    else
                        violationCounts[player] = currentViolations
                    end
                else
                    violationCounts[player] = 0
                end

                lastVehicleHealths[player] = vHealth
            else
                violationCounts[player] = 0
                lastVehicleHealths[player] = nil
            end

        else
            local health = getElementHealth(player)
            if not health or health <= 0 then
                lastHealths[player] = nil
                violationCounts[player] = 0
                return
            end

            if health > 200 then
                clairePunish(player, "Claire: Godmode detected (health too high)")
                return
            end

            local lastHealth = lastHealths[player]
            if lastHealth and health == lastHealth and health >= 100 then
                if recentlyDamaged[player] then
                    local currentViolations = violationCounts[player] or 0
                    currentViolations = currentViolations + 1

                    if currentViolations >= tolerance then
                        clairePunish(player, "Claire: Godmode detected (damaged but health unchanged)")
                        violationCounts[player] = nil
                    else
                        violationCounts[player] = currentViolations
                    end
                else
                    violationCounts[player] = 0
                end
            else
                violationCounts[player] = 0
            end

            lastHealths[player] = health
        end
    end

    addEventHandler("onPlayerDamage", root, function()
        recentlyDamaged[source] = true
        setTimer(function(player)
            recentlyDamaged[player] = nil
        end, 2000, 1, source)
    end)

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            checkGodmode(player)
        end
    end, 2000, 0)
end
