if returnClaireSetting("vpnDetection") then
    local checkedIPs = {}

    function checkVPN(player)
        if not isElement(player) then return end
        local ip = getPlayerIP(player)
        if not ip or checkedIPs[ip] then return end

        fetchRemote("http://ip-api.com/json/" .. ip .. "?fields=status,message,query,isp,proxy,hosting",
            function(error, result)
                if not isElement(player) then return end
                if not result or result == "" then return end

                local data = fromJSON(result)
                if not data or data.status ~= "success" then return end

                if data.proxy or data.hosting then
                    checkedIPs[ip] = true
                    clairePunish(player, "Claire: VPN/Proxy usage detected")
                end
            end, "", false
        )
    end

    addEventHandler("onPlayerJoin", root, function()
        checkVPN(source)
    end)
end
