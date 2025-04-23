claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("noclipDetection") then return end
	
    local minHeight        = math.max(5, returnClaireSetting("noclipDetectionMinHeight") or 5)
    local maxScore         = returnClaireSetting("noclipDetectionMaxScore") or 5
    local moveScoreLimit   = returnClaireSetting("noclipDetectionMoveScore") or 6

    local score            = 0
    local moveScore        = 0
    local lastSent         = 0
    local lastPosition     = nil
    local stillFrames      = 0
    local noGroundFrames   = 0
    local airDistance      = 0.0

    setTimer(function()
        local x, y, z       = getElementPosition(localPlayer)
        local _, _, vz      = getElementVelocity(localPlayer)

        if isPedInVehicle(localPlayer) or isPedWearingJetpack(localPlayer) or isElementInWater(localPlayer) then
            score, moveScore, stillFrames, noGroundFrames, airDistance = 0, 0, 0, 0, 0.0
            return
        end

        local task = getPedSimplestTask(localPlayer)
        if task == "TASK_SIMPLE_CLIMB" then
            score, moveScore, stillFrames, noGroundFrames, airDistance = 0, 0, 0, 0, 0.0
            return
        end

        if vz < -0.05 then
            score, moveScore, stillFrames, noGroundFrames, airDistance = 0, 0, 0, 0, 0.0
            return
        end

        local hasGroundSupport = isPedOnGround(localPlayer)
        local groundZ = getGroundPosition(x, y, z)
        local heightDiff = groundZ and (z - groundZ) or 0

        if not hasGroundSupport then
            local hit, _, _, _, hitElement = processLineOfSight(x, y, z, x, y, z - minHeight, true, true, false, true, false, false, false)
            if hit then
                hasGroundSupport = true
            elseif groundZ and groundZ ~= 0 and heightDiff < minHeight then
                hasGroundSupport = true
            end
        end

        if not hasGroundSupport then
            noGroundFrames = noGroundFrames + 1
        else
            noGroundFrames = 0
            airDistance = 0.0
        end

        if noGroundFrames < 4 then
            score, moveScore, stillFrames = 0, 0, 0
            return
        end

        local moving = false
        local frameDist = 0
        if lastPosition then
            local dx = x - lastPosition[1]
            local dy = y - lastPosition[2]
            frameDist = math.sqrt(dx * dx + dy * dy)
            moving = frameDist > 0.1
        end
        lastPosition = {x, y}

        if not hasGroundSupport and frameDist > 0 then
            airDistance = airDistance + frameDist
        end

        if hasGroundSupport then
            score, moveScore, stillFrames, airDistance = 0, 0, 0, 0.0
            return
        end

        if not moving and math.abs(vz) < 0.01 and hasGroundSupport then
            stillFrames = stillFrames + 1
            if stillFrames >= 3 then
                score, moveScore, stillFrames = 0, 0, 0
                return
            end
        else
            stillFrames = 0
        end

        if noGroundFrames >= 4 then
            if moving then
                moveScore = moveScore + 1
                score = 0
            else
                score = score + 1
                moveScore = 0
            end
        end

        if (score >= maxScore or moveScore >= moveScoreLimit) and getTickCount() - lastSent > 1000 then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Noclip detected")
            lastSent = getTickCount()
            score, moveScore = 0, 0
        end
    end, 500, 0)
end)
