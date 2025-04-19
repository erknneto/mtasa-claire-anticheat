claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("windowedModeDetection") then return end

    setTimer(function()
        if dxGetStatus().SettingWindowed then
            triggerServerEvent("clairePunish", localPlayer, "Claire: Windowed mode is not allowed")
        end
    end, 10000, 0)
end)
