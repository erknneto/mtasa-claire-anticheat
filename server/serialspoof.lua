if returnClaireSetting("serialSpoofDetection") then
    local blacklistedSerialPatterns = {
        "^000+", "^FFF+", "^DEAD+", "^BEEF+", "^CCCC+"
    }

    function checkSerial(player)
        if not isElement(player) then return end

        local serial = getPlayerSerial(player)
        if isSerialWhitelisted(serial) then return end

        if not serial or #serial < 32 or not serial:match("^[A-F0-9]+$") then
            clairePunish(player, "Claire: Suspicious serial format detected")
            return
        end

        for _, pattern in ipairs(blacklistedSerialPatterns) do
            if serial:match(pattern) then
                clairePunish(player, "Claire: Blacklisted serial pattern detected")
                return
            end
        end

        local count = 0
        for _, p in ipairs(getElementsByType("player")) do
            if getPlayerSerial(p) == serial then
                count = count + 1
            end
        end

        if count > 1 then
            clairePunish(player, "Claire: Serial duplication detected")
        end
    end

    addEventHandler("onPlayerJoin", root, function()
        setTimer(checkSerial, 1000, 1, source)
    end)

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            checkSerial(player)
        end
    end, 30000, 0)
end
