local weaponFireIntervals = {
    [22] = 250, [23] = 250, [24] = 550,
    [25] = 900, [26] = 1000, [27] = 1000,
    [28] = 100, [29] = 120, [30] = 150,
    [31] = 120, [32] = 120, [33] = 700,
    [34] = 1000
}

local automaticWeapons = {
    [26] = true, [27] = true,
    [28] = true, [29] = true,
    [30] = true, [31] = true,
    [32] = true
}

local lastShotTime = {}
local violationCounts = {}
local lastActivity = {}

local tolerance = returnClaireSetting("fastfireTolerance") or 3
local resetDelay = 10000

if returnClaireSetting("fastfireDetection") then
    setTimer(function()
        local now = getTickCount()
        for player, last in pairs(lastActivity) do
            if isElement(player) and now - last > resetDelay then
                violationCounts[player] = 0
            end
        end
    end, 2000, 0)

    addEventHandler("onPlayerWeaponFire", root, function(weapon)
        if not weaponFireIntervals[weapon] then return end
        if automaticWeapons[weapon] then return end
        if not isElement(source) then return end

        local serial = getPlayerSerial(source)
        if isSerialWhitelisted(serial) then return end

        local now = getTickCount()
        lastActivity[source] = now

        lastShotTime[source] = lastShotTime[source] or {}
        local last = lastShotTime[source][weapon] or 0
        local interval = now - last
        lastShotTime[source][weapon] = now

        if interval < weaponFireIntervals[weapon] then
            local count = violationCounts[source] or 0
            count = count + 1

            if count >= tolerance then
                clairePunish(source, "Claire: Fast fire detected (Weapon ID: " .. weapon .. ")")
                violationCounts[source] = 0
            else
                violationCounts[source] = count
            end
        end
    end)
end
