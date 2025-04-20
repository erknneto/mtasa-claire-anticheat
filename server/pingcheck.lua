local maxPing = returnClaireSetting("pingMax") or 400
local pingTolerance = returnClaireSetting("pingTolerance") or 5
local packetLossMax = returnClaireSetting("packetLossMax") or 0.15
local packetLossTolerance = returnClaireSetting("packetLossTolerance") or 3
local gracePeriod = 10000
local joinTimestamps = {}

local pingViolations = {}
local lossViolations = {}

if returnClaireSetting("pingDetection") then

    addEventHandler("onPlayerJoin", root, function()
        joinTimestamps[source] = getTickCount()
    end)

    function checkPlayerPing(player)
        if not isElement(player) then return end
        local serial = getPlayerSerial(player)
        if isSerialWhitelisted(serial) then return end

        local ping = getPlayerPing(player)
        if ping and ping > maxPing then
            local count = pingViolations[player] or 0
            count = count + 1

            if count >= pingTolerance then
                clairePunish(player, "Claire: High ping (" .. ping .. "ms)")
                pingViolations[player] = nil
            else
                pingViolations[player] = count
            end
        else
            pingViolations[player] = 0
        end
    end

    function checkPlayerPacketLoss(player)
        if not isElement(player) then return end
        local serial = getPlayerSerial(player)
        if isSerialWhitelisted(serial) then return end

        local joinTime = joinTimestamps[player]
        if joinTime and getTickCount() - joinTime < gracePeriod then return end

        local stats = getNetworkStats(player)
        if not stats then return end

        local loss = stats.packetlossLastSecond or 0
        if loss and loss > packetLossMax then
            local count = lossViolations[player] or 0
            count = count + 1

            if count >= packetLossTolerance then
                clairePunish(player, "Claire: High packet loss (" .. math.floor(loss * 100) .. "%)")
                lossViolations[player] = nil
            else
                lossViolations[player] = count
            end
        else
            lossViolations[player] = 0
        end
    end

    setTimer(function()
        for _, player in ipairs(getElementsByType("player")) do
            checkPlayerPing(player)
            checkPlayerPacketLoss(player)
        end
    end, 2000, 0)
end
