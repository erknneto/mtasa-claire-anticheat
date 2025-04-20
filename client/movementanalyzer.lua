claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("movementAnalyzer") then return end
	
    local score = 0
    local maxScore = returnClaireSetting("movementAnalyzerMaxScore") or 6
    local jumpInterval = returnClaireSetting("movementAnalyzerJumpInterval") or 800
    local resetFrames = returnClaireSetting("movementAnalyzerResetFrames") or 5

    local lastJumpTick = 0
    local lastSent = 0
    local stillFrames = 0
    local lastPosition = nil

    setTimer(function()
        local x, y, z = getElementPosition(localPlayer)
        local _, _, vz = getElementVelocity(localPlayer)
        local onGround = isPedOnGround(localPlayer)
        local now = getTickCount()

        if isElementInWater(localPlayer) then
            score = 0
            stillFrames = 0
            return
        end

        local jumping = getPedControlState("jump")
        local jumped = jumping and vz > 0.15 and not onGround

        local moving = false
        if lastPosition then
            local dx = x - lastPosition[1]
            local dy = y - lastPosition[2]
            local dist = math.sqrt(dx * dx + dy * dy)
            moving = dist > 0.2
        end
        lastPosition = {x, y}

        if jumped and moving then
            if now - lastJumpTick < jumpInterval then
                score = score + 1
            end
            lastJumpTick = now
        end

        if onGround and not jumping then
            stillFrames = stillFrames + 1
            if stillFrames >= resetFrames then
                score = 0
            end
        else
            stillFrames = 0
        end

        if score >= maxScore and now - lastSent > 1000 then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Bunnyhop cheat detected")
            lastSent = now
            score = 0
        end
    end, 150, 0)
end)
