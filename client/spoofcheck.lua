claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("spoofCheckDetection") then return end
	
	local receivedExpectedScripts = {}
	local scriptsReady = false

    setTimer(function()
        if not scriptsReady then
            triggerServerEvent("claireRequestExpectedScripts", localPlayer)
        end
    end, 30000, 1)

    addEvent("claireReceiveExpectedScripts", true)
    addEventHandler("claireReceiveExpectedScripts", resourceRoot, function(scripts)
        if type(scripts) ~= "table" then return end

        receivedExpectedScripts = {}
        for k, v in pairs(scripts) do
            table.insert(receivedExpectedScripts, v)
        end

        if #receivedExpectedScripts == 0 then return end

        scriptsReady = true
        triggerServerEvent("claireReportClientScripts", localPlayer, receivedExpectedScripts)

        setTimer(function()
            if scriptsReady and type(receivedExpectedScripts) == "table" and #receivedExpectedScripts > 0 then
                triggerServerEvent("claireReportClientScripts", localPlayer, receivedExpectedScripts)
            end
        end, 60000, 0)
    end)
end)
