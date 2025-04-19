claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("functionBlocker") then return end

    local success, err = pcall(function()
        for m, _ in pairs(_G) do
            if m == nil then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Global environment corruption detected (_G nil key)")
                break
            end
        end

        for _, fn in ipairs({"loadstring", "load", "pcall", "dofile", "assert"}) do
            if type(_G[fn]) ~= "function" then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Global function tampered (" .. fn .. ")")
            end
        end
    end)

    if not success then
        triggerServerEvent("clairePunish", localPlayer, "Claire: Lua environment check failed (" .. tostring(err) .. ")")
    end

    local tCount = 0
    setTimer(function()
        tCount = 0
    end, 3000, 0)

    local blockedFunctions = {
        "outputChatBox", "getAllElementData", "function", "triggerEvent",
        "triggerClientEvent", "triggerServerEvent", "setElementData",
        "addEvent", "addEventHandler", "addDebugHook", "createExplosion",
        "createProjectile", "setElementPosition", "createVehicle",
        "setElementHealth", "setPedArmor", "loadstring", "load", "pcall",
        "dofile", "assert", "collectgarbage", "getfenv", "setfenv", "debug",
        "_G", "_ENV", "rawget", "rawset", "stopResource", "restartResource",
        "getResourceFromName", "getResourceState"
    }

    addDebugHook("preFunction", function(_, fn)
        if fn == "addDebugHook" then return "skip" end

        if fn == "loadstring" or fn == "load" or fn == "pcall" or fn == "dofile" or fn == "assert" or fn == "collectgarbage" then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Blocked function: " .. fn)
            return "skip"
        end

        if fn == "stopResource" or fn == "restartResource" or fn == "getResourceState" or fn == "getResourceFromName" then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Attempted to manipulate resource state (" .. fn .. ")")
            return "skip"
        end

        if fn == "setElementOnFire" or fn == "createProjectile" or fn == "createExplosion" or fn == "blowVehicle" then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Blocked function: " .. fn)
            return "skip"
        end

        if fn == "triggerServerEvent" or fn == "triggerEvent" then
            tCount = tCount + 1
            if tCount >= 50 then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Excessive event usage")
            end
        end
    end)

    addEventHandler("onClientPaste", root, function(text)
        for _, funcName in ipairs(blockedFunctions) do
            if string.find(text, funcName, 1, true) then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Injection paste detected")
                break
            end
        end
    end)

    addEventHandler("onClientGUIChanged", root, function(element)
        local text = guiGetText(element) or ""
        for _, funcName in ipairs(blockedFunctions) do
            if string.find(text, funcName, 1, true) then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Injection input detected")
                cancelEvent()
                break
            end
        end
    end)
end)
