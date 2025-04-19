if returnClaireSetting("screenshotCheck") then
    local function requestScreenshot(player)
        if not isElement(player) then return end
        local timestamp = getRealTime().timestamp
        local tag = "antiscreenshot_" .. getPlayerSerial(player) .. "_" .. timestamp
        takePlayerScreenShot(player, 300, 300, tag, 70, 5000, 500)
    end

    addEventHandler("onPlayerJoin", root, function()
        requestScreenshot(source)
    end)

    addEventHandler("onPlayerScreenShot", root, function(_, status, imageData, _, tag)
        if string.sub(tag, 1, 15) == "antiscreenshot_" then
            if status == "disabled" then
                clairePunish(source, "Claire: Screenshot feature is disabled")
            elseif status == "ok" then
                local file = fileCreate(tag .. ".jpg")
                if file then
                    fileWrite(file, imageData)
                    fileClose(file)
                    fileDelete(tag .. ".jpg")
                end
            end
        end
    end)
end
