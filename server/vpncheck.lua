if returnClaireSetting("vpnDetection") then
    local cacheTTL   = 3600
    local checkedIPs = {}
    local opt        = { queueName = "claireVPN", connectionAttempts = 1, connectTimeout = 8000 }

    local function checkVPN(player)
        if not isElement(player) then return end
        local ip = getPlayerIP(player)
        if not ip then return end

        local c = checkedIPs[ip]
        if c and c.expires > getTickCount() then
            if c.block then clairePunish(player, "Claire: VPN/Proxy usage detected (cached)") end
            return
        end

        local url = "http://ip-api.com/json/" .. ip .. "?fields=status,proxy,hosting"
        fetchRemote(url, opt, function(body, info)
            if not info.success or info.statusCode ~= 200 then return end

            local res = fromJSON(body)
            if not res or res.status ~= "success" then return end

            local block = res.proxy or res.hosting
            checkedIPs[ip] = { block = block, expires = getTickCount() + cacheTTL * 1000 }

            if block and isElement(player) then
                clairePunish(player, "Claire: VPN/Proxy usage detected")
            end
        end)
    end

    addEventHandler("onPlayerJoin", root, function() checkVPN(source) end)
    for _, p in ipairs(getElementsByType("player")) do checkVPN(p) end
end
