local minHeight = returnClaireSetting("noclipDetectionMinHeight") or 7
local maxScore = returnClaireSetting("noclipDetectionMaxScore") or 5
local moveScoreLimit = returnClaireSetting("noclipDetectionMoveScore") or 6

local score = 0
local moveScore = 0
local lastSent = 0
local lastPosition = nil
local stillFrames = 0

claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("noclipDetection") then return end

    setTimer(function()
        local x, y, z = getElementPosition(localPlayer)
        local _, _, vz = getElementVelocity(localPlayer)

        local hasGroundSupport = isPedOnGround(localPlayer)
        if not hasGroundSupport then
            local hit, _, _, _, hitElement = processLineOfSight(x, y, z, x, y, z - 5, true, true, false, true, false, false, false)
            hasGroundSupport = hit and hitElement
        end

        local moving = false
        if lastPosition then
            local dx = x - lastPosition[1]
            local dy = y - lastPosition[2]
            local dist = math.sqrt(dx * dx + dy * dy)
            moving = dist > 0.1
        end
        lastPosition = {x, y}

        if not moving and math.abs(vz) < 0.01 and hasGroundSupport then
            stillFrames = stillFrames + 1
        else
            stillFrames = 0
        end

        if stillFrames >= 3 then
            score = 0
            moveScore = 0
            return
        end

        if isPedInVehicle(localPlayer) or isPedWearingJetpack(localPlayer) or isElementInWater(localPlayer) or hasGroundSupport then
            score = 0
            moveScore = 0
            return
        end

        local task = getPedSimplestTask(localPlayer)
        if task == "TASK_SIMPLE_CLIMB" then
            score = 0
            moveScore = 0
            return
        end

        if z < minHeight or vz < -0.05 then
            score = 0
            moveScore = 0
            return
        end

        if moving then
            moveScore = moveScore + 1
            score = 0
        else
            score = score + 1
            moveScore = 0
        end

        if (score >= maxScore or moveScore >= moveScoreLimit) and getTickCount() - lastSent > 1000 then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Noclip detected")
            lastSent = getTickCount()
        end
    end, 500, 0)
end)
