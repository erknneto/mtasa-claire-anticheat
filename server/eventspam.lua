if returnClaireSetting("eventSpamDetection") then
    local invalidEventList = {}

    addEventHandler("onPlayerTriggerEventThreshold", root, function()
        clairePunish(source, "Claire: Event spam threshold exceeded")
    end)

    addEventHandler("onPlayerTriggerInvalidEvent", root, function(_, _, _)
        local player = source
        local count = invalidEventList[player] or 0
        count = count + 1

        if count >= 10 then
            clairePunish(player, "Claire: Excessive invalid events")
            invalidEventList[player] = 0
        else
            invalidEventList[player] = count
        end
    end)
end
