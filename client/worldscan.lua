claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("worldScanDetection") then return end

    local lockedProperties = {
        aircars = false,
        hovercars = false,
        extrabunny = false,
        extrajump = false,
        snipermoon = false,
        vehiclesunglare = false,
        coronaztest = true,
        burnflippedcars = true,
        fireballdestruct = true,
        randomfoliage = true,
        underworldwarp = true
    }

    setTimer(function()
        for property, expected in pairs(lockedProperties) do
            local state = isWorldSpecialPropertyEnabled(property)
            if state ~= expected then
                setWorldSpecialPropertyEnabled(property, expected)
                triggerServerEvent("clairePunish", localPlayer, "Claire: World property '" .. property .. "' was modified")
            end
        end

        local speed = getGameSpeed()
        if speed > 1 then
            setGameSpeed(1)
            triggerServerEvent("clairePunish", localPlayer, "Claire: Game speed modified (" .. tostring(speed) .. ")")
        end

        setOcclusionsEnabled(false)

        if getGravity() ~= 0.008 then
            setGravity(0.008)
        end
    end, 5000, 0)
end)
