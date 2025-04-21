if returnClaireSetting("pingDetection") then
    local maxPing         = tonumber(returnClaireSetting("pingMax")) or 400
    local pingTolerance   = tonumber(returnClaireSetting("pingTolerance")) or 5
    local maxPacketLoss   = tonumber(returnClaireSetting("packetLossMax")) or 0.15
    local lossTolerance   = tonumber(returnClaireSetting("packetLossTolerance")) or 3
    local gracePeriod     = 10000
    local checkInterval   = 2000

    local joinTime        = {}
    local pingViolations  = {}
    local lossViolations  = {}

    addEventHandler("onPlayerJoin", root, function()
        joinTime[source] = getTickCount()
    end)

    addEventHandler("onPlayerQuit", root, function()
        joinTime[source]       = nil
        pingViolations[source] = nil
        lossViolations[source] = nil
    end)

    local function inGracePeriod(player)
        local t = joinTime[player]
        return t and (getTickCount() - t < gracePeriod)
    end

    local function checkPlayerPing(player)
        if inGracePeriod(player) then return end

        local ping = getPlayerPing(player)
        if ping and ping > maxPing then
            pingViolations[player] = (pingViolations[player] or 0) + 1
            if pingViolations[player] >= pingTolerance then
                clairePunish(player, "Claire: High ping (" .. ping .. " ms)")
                pingViolations[player] = nil
            end
        else
            pingViolations[player] = nil
        end
    end

    local function checkPlayerPacketLoss(player)
        if inGracePeriod(player) then return end

        local stats = getNetworkStats(player)
        if not stats or stats.packetlossLastSecond == nil then return end

        if stats.packetlossLastSecond > maxPacketLoss then
            lossViolations[player] = (lossViolations[player] or 0) + 1
            if lossViolations[player] >= lossTolerance then
                clairePunish(player, "Claire: High packet loss (" ..
                    math.floor(stats.packetlossLastSecond * 100) .. "%)")
                lossViolations[player] = nil
            end
        else
            lossViolations[player] = nil
        end
    end

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            if not isSerialWhitelisted(getPlayerSerial(player)) then
                checkPlayerPing(player)
                checkPlayerPacketLoss(player)
            end
        end
    end, checkInterval, 0)
end
