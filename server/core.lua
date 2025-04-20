function clairePunish(player, reason)
    if not isElement(player) then return end

    local serial = getPlayerSerial(player)
    if isSerialWhitelisted(serial) then return end

    local kickReason = reason or "Claire: Rule violation"
    outputDebugString("[Claire] Player kicked: " .. getPlayerName(player) .. " | Reason: " .. kickReason, 3)
    kickPlayer(player, kickReason)
end

addEvent("clairePunish", true)
addEventHandler("clairePunish", root, function(reason)
    clairePunish(client, reason)
end)

setTimer(function()
	fetchRemote("https://raw.githubusercontent.com/erknneto/mtasa-claire-anticheat/refs/heads/main/meta.xml", function(responseCode, data)
		if responseCode == 200 then
			local remoteVersion = string.match(data, 'version="(.-)"')
			local localMeta = xmlLoadFile("meta.xml")
			local localVersion = localMeta and xmlNodeGetAttribute(xmlFindChild(localMeta, "info", 0), "version") or "unknown"
			if localMeta then xmlUnloadFile(localMeta) end

			if remoteVersion and localVersion and remoteVersion ~= localVersion then
				outputDebugString("[Claire] Update available! Local version: " .. tostring(localVersion) .. " | Latest: " .. remoteVersion, 3)
				outputDebugString("[Claire] Download latest at: https://github.com/erknneto/mtasa-claire-anticheat", 3)
				
				outputServerlog("[Claire] Update available! Local version: " .. tostring(localVersion) .. " | Latest: " .. remoteVersion, 3)
				outputServerlog("[Claire] Download latest at: https://github.com/erknneto/mtasa-claire-anticheat", 3)
			end
		end
	end, "", false)
end, 3600000, 0)
