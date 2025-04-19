if returnClaireSetting("elementDataProtection") then
    local protectedKeys = {
        money = true,
        admin = true,
        staff = true,
        vip = true,
        premium = true,
        godmode = true,
        speed = true,
        fly = true,
        noclip = true,
        superman = true,
        invisible = true,
        vanish = true
    }

    addEventHandler("onElementDataChange", root, function(key, old, new)
        if not client then return end
        if not isElement(client) or getElementType(client) ~= "player" then return end
        if isSerialWhitelisted(getPlayerSerial(client)) then return end

        local keyLower = key:lower()
        if protectedKeys[keyLower] then
            cancelEvent()
            clairePunish(client, "Claire: Unauthorized ElementData change (" .. tostring(key) .. ")")
        end
    end)
end
