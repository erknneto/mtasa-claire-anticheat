local function hasJetpack(player)
    return isPedWearingJetpack(player)
end

local function removeJetpackIfBlocked(player)
    if not isElement(player) then return end

    local serial = getPlayerSerial(player)
    if isSerialWhitelisted(serial) then return end

    if hasJetpack(player) then
        setPedWearingJetpack(player, false)
        outputDebugString("[Claire] Jetpack removed from " .. getPlayerName(player), 3)
    end
end

if returnClaireSetting("jetpackDetection") then

    addEventHandler("onPlayerSpawn", root, function()
        setTimer(function()
            removeJetpackIfBlocked(source)
        end, 1000, 1)
    end)

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            removeJetpackIfBlocked(player)
        end
    end, 15000, 0)
end
