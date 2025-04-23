if returnClaireSetting("pingDetection") then
    local maxPing         = tonumber(returnClaireSetting("pingMax")) or 350
    local maxPacketLoss   = tonumber(returnClaireSetting("packetLossMax")) or 33

    local pingFails       = {}
    local packetFails     = {}
    local pingReset       = {}
    local packetReset     = {}

    addEventHandler("onPlayerQuit", root, function()
        pingFails[source]    = nil
        packetFails[source]  = nil
        if isTimer(pingReset[source]) then killTimer(pingReset[source]) end
        if isTimer(packetReset[source]) then killTimer(packetReset[source]) end
        pingReset[source]    = nil
        packetReset[source]  = nil
    end)

    local function checkPlayerPing(p)
        if getPlayerPing(p) >= maxPing then
            pingFails[p] = (pingFails[p] or 0) + 1

            if pingFails[p] >= 3 then
                clairePunish(p, "Claire: High ping")
                return
            end

            if not isTimer(pingReset[p]) then
                pingReset[p] = setTimer(function()
                    if isElement(p) then
                        pingFails[p] = 0
                    end
                end, 60000, 1)
            end
        else
            pingFails[p] = 0
        end
    end

    local function checkPlayerPacketLoss(p)
        local stats = getNetworkStats(p)
        if not stats or not stats.packetlossLastSecond then return end

        if stats.packetlossLastSecond > maxPacketLoss then
            packetFails[p] = (packetFails[p] or 0) + 1

            if packetFails[p] >= 3 then
                clairePunish(p, "Claire: High packet loss")
                return
            end

            if not isTimer(packetReset[p]) then
                packetReset[p] = setTimer(function()
                    if isElement(p) then
                        packetFails[p] = 0
                    end
                end, 60000, 1)
            end
        else
            packetFails[p] = 0
        end
    end

    setTimer(function()
        for _, p in ipairs(getElementsByType("player")) do
            if not isSerialWhitelisted(getPlayerSerial(p)) then
                checkPlayerPing(p)
                checkPlayerPacketLoss(p)
            end
        end
    end, 3000, 0)
end
