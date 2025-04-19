claireRegisterOnSettingsReady(function()
    if not returnClaireSetting("wallScanDetection") then return end

    local suspiciousModels = {
        1794,
        9833,
        10757,
        10828
    }

    setTimer(function()
        for _, model in ipairs(suspiciousModels) do
            local lod = engineGetModelLODDistance(model)
            if lod and lod > 300 then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Wallhack detection (LODDistance too high) for model " .. tostring(model))
                return
            end

            if engineGetModelTextureNames and engineGetModelTextureNames(model) then
                local textures = engineGetModelTextureNames(model)
                for _, name in ipairs(textures) do
                    if name:lower():find("invisible", 1, true) or name:lower():find("wall", 1, true) then
                        triggerServerEvent("clairePunish", localPlayer, "Claire: Wallhack detection (texture swap) on model " .. tostring(model))
                        return
                    end
                end
            end

            if engineGetModelNameFromID and not engineGetModelNameFromID(model) then
                triggerServerEvent("clairePunish", localPlayer, "Claire: Wallhack detection (model missing) - " .. tostring(model))
                return
            end
        end
    end, 5000, 0)
end)
