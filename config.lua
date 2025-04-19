--[[ Claire AntiCheat - config.lua
Each setting is explained using this format:

<setting_name> - <what it does>. Confiability: <percentage>. Risk: <false positive risk>. Recommended: <true/false>. <extra notes>.
For numeric values: Recommended range and impact of changes are described.
Do not change any setting name, only its value.
]]--

claireSettings = {
    -- Core Modules
    {"eventSpamDetection", true}, -- allows detection of events being spammed by clients. Confiability: 95%. Risk: very low false positives. Recommended: true.
    {"explosionDetection", true}, -- detects excessive explosion generation. Confiability: 99%. Risk: none. Recommended: true.
    {"functionBlocker", true}, -- blocks execution of dangerous Lua functions client-side. Confiability: 90%. Risk: low false positives. Recommended: true.
    {"projectileDetection", true}, -- detects unauthorized projectile creation. Confiability: 100%. Risk: none. Recommended: true.
    {"jetpackDetection", true}, -- blocks unauthorized jetpack usage. Confiability: 100%. Risk: none. Recommended: true.
    {"weaponDetection", true}, -- blocks forbidden weapons. Confiability: 100%. Risk: none. Recommended: true.
    {"spoofCheckDetection", true}, -- checks if the resource is correctly loaded by the client. Confiability: 95%. Risk: low. Recommended: true.

    -- Combat & Aim
    {"fastfireDetection", true}, -- detects unrealistic fire rates. Confiability: 90%. Risk: low with automatic weapons. Recommended: true.
    {"fastfireTolerance", 3}, -- how many times a player can shoot too fast before being punished. Recommended: 3-5. Higher = more tolerant.

    {"aimbotDetection", true}, -- detects aim assist (silent aim) by tracking hit accuracy. Confiability: 95%. Risk: very low if thresholds are well tuned. Recommended: true.
    {"aimbotHitRateThreshold", 0.9}, -- minimum hit ratio (0.0 - 1.0) to consider aimbot behavior. Recommended: 0.85 - 0.95.
    {"aimbotMinShots", 50}, -- minimum number of shots before calculating hit rate. Recommended: 30 - 100. Lower = faster detection, higher = more accurate.
    {"aimbotTolerance", 3}, -- number of allowed violations before punishment. Recommended: 2-4.

    -- Network
    {"pingDetection", true}, -- detects excessively high ping. Confiability: 95%. Risk: low. Recommended: true.
    {"pingMax", 400}, -- maximum allowed ping in ms. Recommended: 300 - 600.
    {"pingTolerance", 5}, -- number of bad ping intervals before punishment. Recommended: 3-6.
    {"packetLossMax", 0.15}, -- maximum packet loss ratio (0.0 - 1.0). Recommended: 0.10 - 0.20.
    {"packetLossTolerance", 3}, -- number of bad intervals allowed. Recommended: 2-5.

    -- Movement
    {"noclipDetection", true}, -- detects ghost/fly movement. Confiability: 95%. Risk: very low. Recommended: true.
    {"noclipDetectionTolerance", 3}, -- how many detections are tolerated before action. Recommended: 2-4.
    {"noclipDetectionMinHeight", 7}, -- minimum height (in units) to consider for noclip detection. Recommended: 5 - 10.
    {"noclipDetectionMaxScore", 5}, -- max air-idle score. Higher = more tolerant. Recommended: 4 - 8.
    {"noclipDetectionMoveScore", 6}, -- max air-movement score. Higher = more tolerant. Recommended: 5 - 8.

    {"godmodeDetection", true}, -- detects if players are not taking damage. Confiability: 100%. Risk: none. Recommended: true.
    {"godmodeTolerance", 3}, -- number of no-damage events allowed. Recommended: 2-4.
    {"godmodeVehicleMinThreshold", 950}, -- vehicle HP threshold to start detection. Recommended: 900 - 980.

    {"speedhackDetection", true}, -- detects abnormal player/vehicle speed. Confiability: 90%. Risk: low. Recommended: true.
    {"speedhackMaxSpeed", 30}, -- max speed on foot (units/tick). Recommended: 25 - 35.
    {"speedhackTolerance", 3}, -- number of violations before action. Recommended: 2-4.
    {"speedhackVehicleMaxSpeed", 250}, -- max speed in vehicles. Recommended: 200 - 300.

    {"teleportDetection", true}, -- detects sudden position changes or illegal vehicle warps. Confiability: 92%. Risk: low with tolerance. Recommended: true.
    {"teleportMaxDistance", 50}, -- distance in meters considered too large to be natural. Recommended: 40 - 70.
    {"teleportTolerance", 2}, -- how many violations before punishment. Recommended: 2-3.
    {"teleportGraceAfterSpawn", 5000}, -- delay after spawn before checks start. Recommended: 3000 - 6000.

    -- Heuristics & Behavior
    {"elementDataProtection", true}, -- blocks critical setElementData calls. Confiability: 95%. Risk: low. Recommended: true.
    {"variableWatcher", true}, -- monitors internal client variables known to be used by cheats. Confiability: 90%. Risk: minimal. Recommended: true.
    {"movementAnalyzer", true}, -- detects bunnyhop-style jump abuse. Confiability: 95%. Risk: very low. Recommended: true.
    {"movementAnalyzerMaxScore", 6}, -- score before action is taken. Recommended: 4 - 8.
    {"movementAnalyzerTolerance", 3}, -- tolerance before punishment. Recommended: 2-4.
    {"movementAnalyzerJumpInterval", 800}, -- max time between jumps to consider it suspicious (ms). Recommended: 600 - 1000.
    {"movementAnalyzerResetFrames", 5}, -- how many frames without jumping resets the score. Recommended: 4 - 6.

    -- Vehicles
    {"vehicleTypeWhitelist", true}, -- blocks access to forbidden vehicle types (e.g., tank, hydra). Confiability: 100%. Risk: none. Recommended: true.

    -- Visibility / World
    {"worldScanDetection", true}, -- detects invisible or invalid models. Confiability: 90%. Risk: low. Recommended: true.
    {"serialSpoofDetection", true}, -- detects serial spoof attempts via heuristics. Confiability: 85%. Risk: low. Recommended: true.
    {"wallScanDetection", true}, -- detects model invisibility used for wallhacks. Confiability: 60%. Risk: low. Recommended: true.
    {"vpnDetection", true}, -- checks if IP is from a known VPN/proxy/hosting. Confiability: 85%. Risk: medium (mobile IPs may be flagged). Recommended: true.

    -- UI / Display
    {"windowedModeDetection", true}, -- blocks windowed mode usage. Confiability: 100%. Risk: none. Recommended: true.
    {"screenshotCheck", true}, -- checks if screenshot capture is blocked. Confiability: 100%. Risk: none. Recommended: true.
}

function returnClaireSetting(setting)
    for i, data in ipairs(claireSettings) do
        if data[1] == setting then
            return data[2]
        end
    end
    return false
end

addEvent("claireRequestSettings", true)
addEventHandler("claireRequestSettings", root, function()
    if not isElement(source) then return end
    triggerClientEvent(source, "claireReceiveSettings", resourceRoot, claireSettings)
end)