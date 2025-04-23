local punishedPlayers = {}

function clairePunish(player, reason)
    if not isElement(player) then return end

    local serial = getPlayerSerial(player)
    if isSerialWhitelisted(serial) then return end
    if punishedPlayers[player] then return end

    punishedPlayers[player] = true

    local kickReason = reason or "Claire: Rule violation"
    outputDebugString("[Claire] Player kicked: " .. getPlayerName(player) .. " | Reason: " .. kickReason, 3)
    kickPlayer(player, kickReason)
end

addEvent("clairePunish", true)
addEventHandler("clairePunish", root, function(reason)
    clairePunish(client, reason)
end)

addEventHandler("onPlayerQuit", root, function()
    punishedPlayers[source] = nil
end)
