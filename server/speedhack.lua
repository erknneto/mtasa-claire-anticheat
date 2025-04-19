local maxSpeed = returnClaireSetting("speedhackMaxSpeed") or 30
local vehicleMaxSpeed = returnClaireSetting("speedhackVehicleMaxSpeed") or 250
local tolerance = returnClaireSetting("speedhackTolerance") or 3

local lastPositions = {}
local lastTicks = {}
local violationCounts = {}

if returnClaireSetting("speedhackDetection") then

    function checkPlayerSpeed(player)
        if not isElement(player) then return end

        local serial = getPlayerSerial(player)
        if isSerialWhitelisted(serial) then return end

        if isPedInVehicle(player) then
            local vehicle = getPedOccupiedVehicle(player)
            if vehicle and isElement(vehicle) then
                local velX, velY, velZ = getElementVelocity(vehicle)
                local speed = math.sqrt(velX * velX + velY * velY + velZ * velZ) * 180

                if speed > vehicleMaxSpeed then
                    local currentViolations = violationCounts[player] or 0
                    currentViolations = currentViolations + 1

                    if currentViolations >= tolerance then
                        clairePunish(player, "Claire: Vehicle speedhack detected")
                        violationCounts[player] = nil
                    else
                        violationCounts[player] = currentViolations
                    end
                else
                    violationCounts[player] = 0
                end
            end
        else
            if not isPedOnGround(player) then return end

            local x, y, z = getElementPosition(player)
            local now = getTickCount()

            local lastPos = lastPositions[player]
            local lastTick = lastTicks[player]

            if lastPos and lastTick then
                local dx = x - lastPos[1]
                local dy = y - lastPos[2]
                local dz = z - lastPos[3]
                local dist = math.sqrt(dx * dx + dy * dy + dz * dz)
                local dt = (now - lastTick) / 1000

                if dt > 0 then
                    local speed = dist / dt
                    if speed > maxSpeed then
                        local currentViolations = violationCounts[player] or 0
                        currentViolations = currentViolations + 1

                        if currentViolations >= tolerance then
                            clairePunish(player, "Claire: Speedhack detected")
                            violationCounts[player] = nil
                        else
                            violationCounts[player] = currentViolations
                        end
                    else
                        violationCounts[player] = 0
                    end
                end
            end

            lastPositions[player] = {x, y, z}
            lastTicks[player] = now
        end
    end

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            checkPlayerSpeed(player)
        end
    end, 1000, 0)
end
