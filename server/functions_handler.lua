for m, v in pairs(_G) do
    if not m then
        triggerServerEvent("JersonAC:Kick", localPlayer, "'.lua' error!")
    end
end

local tCount = 0
setTimer(function()
    tCount = 0
end, 3000, 0)

function onPreFunction(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
    if functionName == "addDebugHook" and sourceResource ~= getThisResource() then
        return "skip"
    end

    if functionName == "loadstring" or functionName == "load" or functionName == "pcall" then 
        triggerServerEvent("JersonAC:Kick", localPlayer, "Function not allowed!")
        return "skip"
    end 

    if functionName == "setElementOnFire" or functionName == "createProjectile" or functionName == "createExplosion" or functionName == "blowVehicle" then
        return "skip"
    end

    if functionName == "triggerServerEvent" or functionName == "triggerEvent" then 
        tCount = tCount + 1
        if tCount >= 50 then 
            triggerServerEvent("JersonAC:Kick", localPlayer, "Events not allowed!")
        end 
    end
end
Debug = addDebugHook("preFunction", onPreFunction)

if not Debug then
    triggerServerEvent("JersonAC:Kick", localPlayer, "'debug' error!")
end

local blockedFunctions = {
    'outputChatBox',
    'getAllElementData',
    'function',
    'triggerEvent',
    'triggerClientEvent',
    'triggerServerEvent',
    'setElementData',
    'addEvent',
    'addEventHandler',
    'addDebugHook',
    'createExplosion',
    'createProjectile',
    'setElementPosition',
    'createVehicle',
    'setElementHealth',
    'setPedArmor',
}

function antiInjection_onGUIChanged(element)
    local text = guiGetText(element)
    local injecting = false
    for _, funcName in ipairs(blockedFunctions) do
        if string.find(text, funcName) then
            injecting = true
            break
        end
    end
    if injecting then
        triggerServerEvent("JersonAC:Kick", localPlayer, "Injection type not allowed!")
        cancelEvent()
    end
end
addEventHandler("onClientGUIChanged", root, antiInjection_onGUIChanged)

function antiInjection_onPaste(text)
    for _, funcName in ipairs(blockedFunctions) do
        if text:find(funcName) then
            triggerServerEvent("JersonAC:Kick", localPlayer, "Injection paste not allowed!")
            break
        end
    end
end
addEventHandler("onClientPaste", root, antiInjection_onPaste)