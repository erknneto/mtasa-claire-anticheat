claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("projectileDetection") then return end

    addEventHandler("onClientProjectileCreation", root, function(creator)
        if getElementType(creator) == "player" then
            local x, y, z = getElementPosition(source)
            setElementPosition(source, x, y, z - 5000)
            destroyElement(source)
            triggerServerEvent("clairePunish", localPlayer, "Claire: Projectile creation detected")
        end
    end)
end)
