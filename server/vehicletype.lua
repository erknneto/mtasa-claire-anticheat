if returnClaireSetting("vehicleTypeWhitelist") then
    local blockedVehicleModels = {
        [432] = true,
        [425] = true,
        [520] = true,
        [464] = true,
        [539] = true,
        [592] = true,
        [577] = true,
        [553] = true,
        [511] = true,
        [476] = true,
        [513] = true,
        [593] = true,
        [441] = true,
        [465] = true,
        [501] = true,
        [564] = true
    }

    addEventHandler("onPlayerVehicleEnter", root, function(vehicle, seat)
        if seat ~= 0 then return end
        if not isElement(vehicle) or getElementType(vehicle) ~= "vehicle" then return end
        if not isElement(source) or getElementType(source) ~= "player" then return end
        if isSerialWhitelisted(getPlayerSerial(source)) then return end

        local model = getElementModel(vehicle)
        if blockedVehicleModels[model] then
            clairePunish(source, "Claire: Blocked vehicle model (" .. tostring(model) .. ")")
            removePedFromVehicle(source)
        end
    end)
end
