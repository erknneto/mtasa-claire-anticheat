claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("variableWatcher") then return end

    local watchedKeys = {
        godmode = true,
        superman = true,
        fly = true,
        noclip = true,
        invisible = true,
        staff = true,
        admin = true,
        speed = true
    }

    local lastValues = {}
    local violations = {}
    local lastTick = {}

    setTimer(function()
        for key, _ in pairs(watchedKeys) do
            local val = getElementData(localPlayer, key)

            if val == true then
                local count = violations[key] or 0
                violations[key] = count + 1
                lastTick[key] = getTickCount()

                if violations[key] >= 3 then
                    triggerServerEvent("clairePunish", localPlayer, "Claire: Client ElementData '" .. key .. "' modified")
                    violations[key] = 0
                end
            else
                if lastTick[key] and getTickCount() - lastTick[key] > 10000 then
                    violations[key] = 0
                    lastTick[key] = nil
                end
            end
        end
    end, 1000, 0)
end)
