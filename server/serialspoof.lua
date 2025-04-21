if returnClaireSetting("serialSpoofDetection") then

    local blacklistChars = { ["0"] = true, ["F"] = true, ["C"] = true, ["B"] = true, ["D"] = true, ["E"] = true }
    local activeSerials = {}
    local disconnectBuffer = {}

    local function registerSerial(player, serial)
        if isSerialWhitelisted(serial) then return end
        if disconnectBuffer[serial] and getTickCount() < disconnectBuffer[serial] then return end
        activeSerials[serial] = (activeSerials[serial] or 0) + 1
        if activeSerials[serial] > 1 then
            clairePunish(player, "Claire: Serial duplication detected")
        end
    end

    local function unregisterSerial(serial)
        local count = activeSerials[serial]
        if count then
            if count <= 1 then
                activeSerials[serial] = nil
            else
                activeSerials[serial] = count - 1
            end
        end
    end

    local function validateSerial(player)
        if not isElement(player) then return end

        local serial = getPlayerSerial(player)
        if not serial then return end

        serial = serial:upper()
        if isSerialWhitelisted(serial) then return end

        if #serial ~= 32 or not serial:match("^[A-F0-9]+$") then
            clairePunish(player, "Claire: Suspicious serial format")
            return
        end

        local firstChar = serial:sub(1, 1)
        if blacklistChars[firstChar] and serial:gsub(firstChar, "") == "" then
            clairePunish(player, "Claire: Blacklisted serial pattern")
        end
    end

    addEventHandler("onPlayerJoin", root, function()
        local serial = getPlayerSerial(source)
        if serial then
            serial = serial:upper()
            registerSerial(source, serial)
            setTimer(validateSerial, 1000, 1, source)
        end
    end)

    addEventHandler("onPlayerQuit", root, function()
        local serial = getPlayerSerial(source)
        if serial then
            serial = serial:upper()
            disconnectBuffer[serial] = getTickCount() + 3000
            setTimer(function(serial)
                unregisterSerial(serial)
                disconnectBuffer[serial] = nil
            end, 3000, 1, serial)
        end
    end)

end
