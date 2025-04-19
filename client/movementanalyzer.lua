local score = 0
local maxScore = returnClaireSetting("movementAnalyzerMaxScore") or 6
local jumpInterval = returnClaireSetting("movementAnalyzerJumpInterval") or 800
local resetFrames = returnClaireSetting("movementAnalyzerResetFrames") or 5

local lastJumpTick = 0
local lastSent = 0
local stillFrames = 0

claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("movementAnalyzer") then return end

    setTimer(function()
        local jumping = getPedControlState("jump")
        local onGround = isPedOnGround(localPlayer)
        local _, _, vz = getElementVelocity(localPlayer)

        if jumping and not onGround and vz > -0.3 and vz < 0.5 then
            local now = getTickCount()
            if now - lastJumpTick < jumpInterval then
                score = score + 1
            end
            lastJumpTick = now
        elseif onGround then
            score = 0
        end

        if not jumping and not onGround then
            stillFrames = stillFrames + 1
        else
            stillFrames = 0
        end

        if stillFrames >= resetFrames then
            score = 0
        end

        if score >= maxScore and getTickCount() - lastSent > 1000 then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Bunnyhop cheat detected")
            lastSent = getTickCount()
            score = 0
        end
    end, 150, 0)
end)
