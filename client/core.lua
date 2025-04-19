claireSettings = {}
local claireModulesToTrigger = {}

function returnClaireSetting(setting)
    for i, data in ipairs(claireSettings) do
        if data[1] == setting then
            return data[2]
        end
    end
    return false
end

function claireRegisterOnSettingsReady(callback)
    if #claireSettings > 0 then
        callback()
    else
        table.insert(claireModulesToTrigger, callback)
    end
end

addEvent("claireReceiveSettings", true)
addEventHandler("claireReceiveSettings", resourceRoot, function(receivedSettings)
    if type(receivedSettings) ~= "table" then return end
    claireSettings = receivedSettings
    for _, callback in ipairs(claireModulesToTrigger) do
        callback()
    end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
    triggerServerEvent("claireRequestSettings", localPlayer)
end)
