if returnClaireSetting("spoofCheckDetection") then

    local expectedClientScripts = {}

    local function loadExpectedClientScripts()
        local meta = xmlLoadFile(":" .. getResourceName(getThisResource()) .. "/meta.xml")
        if not meta then return end

        local i = 0
        while true do
            local node = xmlFindChild(meta, "script", i)
            if not node then break end

            local path = xmlNodeGetAttribute(node, "src")
            local scriptType = xmlNodeGetAttribute(node, "type")
            if path and scriptType == "client" then
                expectedClientScripts[path] = true
            end

            i = i + 1
        end

        xmlUnloadFile(meta)
    end

    loadExpectedClientScripts()

    addEvent("claireRequestExpectedScripts", true)
    addEventHandler("claireRequestExpectedScripts", root, function()
        if not isElement(source) or getElementType(source) ~= "player" then return end

        local scriptList = {}
        for script in pairs(expectedClientScripts) do
            table.insert(scriptList, script)
        end

        triggerClientEvent(source, "claireReceiveExpectedScripts", resourceRoot, scriptList)
    end)

    addEvent("claireReportClientScripts", true)
    addEventHandler("claireReportClientScripts", root, function(clientList)
        if type(clientList) ~= "table" then return end
        if not isElement(source) or getElementType(source) ~= "player" then return end

        local serial = getPlayerSerial(source)
        if isSerialWhitelisted(serial) then return end

        local clientReported = {}
        for _, script in ipairs(clientList) do
            if type(script) == "string" then
                clientReported[script] = true
            end
        end

        for expectedScript in pairs(expectedClientScripts) do
            if not clientReported[expectedScript] then
                clairePunish(source, "Claire: Missing client script (" .. expectedScript .. ")")
                return
            end
        end

        for script in pairs(clientReported) do
            if not expectedClientScripts[script] then
                clairePunish(source, "Claire: Unknown client script (" .. script .. ")")
                return
            end
        end
    end)
end
