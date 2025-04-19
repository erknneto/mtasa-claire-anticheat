local blockedWeapons = {
    [35] = true, [36] = true, [37] = true, [38] = true,
    [39] = true, [40] = true, [43] = true, [44] = true,
    [45] = true, [47] = true, [49] = true, [50] = true,
    [51] = true, [52] = true, [53] = true, [54] = true
}

if returnClaireSetting("weaponDetection") then

    function checkPlayerWeapons(player)
        if not isElement(player) then return end

        local serial = getPlayerSerial(player)
        if isSerialWhitelisted(serial) then return end

        for slot = 0, 12 do
            local weapon = getPedWeapon(player, slot)
            if blockedWeapons[weapon] then
                takeWeapon(player, weapon)
                outputDebugString("[Claire] Blocked weapon removed from " .. getPlayerName(player) .. ": ID " .. weapon, 3)
            end
        end
    end

    addEventHandler("onPlayerSpawn", root, function()
        setTimer(function()
            checkPlayerWeapons(source)
        end, 1000, 1)
    end)

    addEventHandler("onPlayerWeaponSwitch", root, function(_, _)
        checkPlayerWeapons(source)
    end)

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            checkPlayerWeapons(player)
        end
    end, 15000, 0)

    addEventHandler("onPlayerWeaponFire", root, function(weapon, _, _, _, _, _)
        if blockedWeapons[weapon] then
            local serial = getPlayerSerial(source)
            if not isSerialWhitelisted(serial) then
                takeWeapon(source, weapon)
                cancelEvent()
                outputDebugString("[Claire] Blocked weapon fire prevented from " .. getPlayerName(source) .. ": ID " .. weapon, 3)
            end
        end
    end)
end
