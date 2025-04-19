local maxDistance = returnClaireSetting("teleportMaxDistance") or 50
local tolerance = returnClaireSetting("teleportTolerance") or 2
local graceAfterSpawn = returnClaireSetting("teleportGraceAfterSpawn") or 5000

local teleportScore = 0
local lastSent = 0
local lastPlayerPosition = nil
local lastVehiclePosition = nil
local lastSpawnTime = getTickCount()
local enteringDistantVehicle = false
local stillFrames = 0

local function resetTeleportState()
    teleportScore = 0
    lastPlayerPosition = nil
    lastVehiclePosition = nil
    enteringDistantVehicle = false
    stillFrames = 0
end
addEventHandler("onClientPlayerWasted", localPlayer, resetTeleportState)

addEventHandler("onClientPlayerSpawn", localPlayer, function()
    lastSpawnTime = getTickCount()
    resetTeleportState()
end)

addEventHandler("onClientVehicleStartEnter", root, function(player, seat)
    if player ~= localPlayer or seat ~= 0 then return end
    local px, py, pz = getElementPosition(localPlayer)
    local vehicles = getElementsWithinRange(px, py, pz, 26, "vehicle")
    if #vehicles == 0 then
        enteringDistantVehicle = true
    end
end)

setTimer(function()
    if not isElement(localPlayer) then return end

    local now = getTickCount()
    if now - lastSpawnTime < graceAfterSpawn then return end

    local inVehicle = isPedInVehicle(localPlayer)
    local x, y, z = getElementPosition(localPlayer)
    local _, _, vz = getElementVelocity(localPlayer)
    local falling = (vz < -0.3 and not isPedOnGround(localPlayer) and not inVehicle and not isPedWearingJetpack(localPlayer) and not isElementInWater(localPlayer))

    if falling or isPedWearingJetpack(localPlayer) or isElementInWater(localPlayer) then return end

    local distance = 0
    if lastPlayerPosition then
        local dx = x - lastPlayerPosition[1]
        local dy = y - lastPlayerPosition[2]
        local dz = z - lastPlayerPosition[3]
        distance = math.sqrt(dx * dx + dy * dy + dz * dz)

        if distance > maxDistance then
            teleportScore = teleportScore + 1
            stillFrames = 0
        else
            stillFrames = stillFrames + 1
            if stillFrames >= 3 then
                teleportScore = 0
                stillFrames = 0
            end
        end
    end
    lastPlayerPosition = {x, y, z}

    if inVehicle then
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if isElement(vehicle) then
            local vx, vy, vz = getElementPosition(vehicle)

            if lastVehiclePosition then
                local vdx = vx - lastVehiclePosition[1]
                local vdy = vy - lastVehiclePosition[2]
                local vdz = vz - lastVehiclePosition[3]
                local vDistance = math.sqrt(vdx * vdx + vdy * vdy + vdz * vdz)

                if vDistance > maxDistance then
                    teleportScore = teleportScore + 1
                end
            end
            lastVehiclePosition = {vx, vy, vz}
        end
    end

    if enteringDistantVehicle then
        teleportScore = teleportScore + 1
        enteringDistantVehicle = false
    end

    if teleportScore >= tolerance and now - lastSent > 1000 then
        triggerServerEvent("clairePunish", localPlayer, "Claire: Teleport detected")
        lastSent = now
        teleportScore = 0
    end
end, 1000, 0)
