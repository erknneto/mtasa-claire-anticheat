local tolerance               = tonumber(returnClaireSetting("godmodeTolerance")) or 3
local vehicleMinThreshold    = tonumber(returnClaireSetting("godmodeVehicleMinThreshold")) or 950
local eps                    = 0.05

local lastHealths            = {}
local lastVehicleHealths     = {}
local violationCounts        = {}
local vehicleViolationCounts = {}
local recentlyDamaged        = {}
local recentlyDamagedVehicle = {}

if returnClaireSetting("godmodeDetection") then

    local function resetPlayer(p)
        violationCounts[p]        = nil
        lastHealths[p]            = nil
        lastVehicleHealths[p]     = nil
        vehicleViolationCounts[p] = nil
    end

    local function punish(p, msg)
        clairePunish(p, msg)
        resetPlayer(p)
    end

    local function checkPlayer(p)
        local h = getElementHealth(p)
        if not h or h <= 0 then
            resetPlayer(p)
            return
        end

        if h > 200 then
            punish(p, "Claire: Godmode detected (health too high)")
            return
        end

        local last = lastHealths[p]
        if last and math.abs(h - last) < eps and h >= 100 and recentlyDamaged[p] then
            local v = (violationCounts[p] or 0) + 1
            if v >= tolerance then
                punish(p, "Claire: Godmode detected (health unchanged)")
            else
                violationCounts[p] = v
            end
        else
            violationCounts[p] = nil
        end

        lastHealths[p] = h
    end

    local function checkVehicle(p, v)
        local vh = getElementHealth(v)
        if not vh or vh <= 300 then
            resetPlayer(p)
            return
        end

        if vh < vehicleMinThreshold or vh >= 1000 then
            resetPlayer(p)
            return
        end

        local last = lastVehicleHealths[p]
        if last and math.abs(vh - last) < eps and recentlyDamagedVehicle[v] then
            local vCount = (vehicleViolationCounts[p] or 0) + 1
            if vCount >= tolerance then
                punish(p, "Claire: Vehicle godmode detected")
            else
                vehicleViolationCounts[p] = vCount
            end
        else
            vehicleViolationCounts[p] = nil
        end

        lastVehicleHealths[p] = vh
    end

    local function checkGodmode(p)
        if not isElement(p) or isSerialWhitelisted(getPlayerSerial(p)) then return end
        if isPedInVehicle(p) then
            local v = getPedOccupiedVehicle(p)
            if v then checkVehicle(p, v) end
        else
            checkPlayer(p)
        end
    end

    addEventHandler("onPlayerDamage", root, function()
        recentlyDamaged[source] = true
        setTimer(function(p) recentlyDamaged[p] = nil end, 2000, 1, source)
    end)

    addEventHandler("onVehicleDamage", root, function()
        recentlyDamagedVehicle[source] = true
        setTimer(function(v) recentlyDamagedVehicle[v] = nil end, 2000, 1, source)
    end)

    addEventHandler("onPlayerQuit", root, function()
        resetPlayer(source)
    end)

    setTimer(function()
        for _, p in ipairs(getElementsByType("player")) do
            checkGodmode(p)
        end
    end, 2000, 0)
end
