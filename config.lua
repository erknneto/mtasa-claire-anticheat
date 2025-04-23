--[[ Claire AntiCheat - config.lua
Each setting is explained using this format:

<setting_name> - <what it does>. Confiability: <percentage>. Risk: <false positive risk>. Recommended: <true/false>. <extra notes>.
For numeric values: Recommended range and impact of changes are described.
Do not change any setting name, only its value.
]]--

claireSettings = {
    -- Core Security
    {"eventSpamDetection", true}, -- enables detection of clients spamming events (invalid or over threshold). Confiability: 95%. Risk: very low false positives. Recommended: true.
    {"functionBlocker", true}, -- blocks execution of dangerous or hijacked Lua functions on the client-side. Confiability: 90%. Risk: low false positives. Recommended: true.
    {"elementDataProtection", true}, -- blocks unauthorized changes to sensitive element data keys like money, godmode, or staff flags. Confiability: 95%. Risk: low. Recommended: true.
    {"variableWatcher", true}, -- detects unauthorized changes to critical client-side ElementData values. Confiability: 90%. Risk: very low. Recommended: true.

    -- Combat / Weapons / Explosives
    {"weaponDetection", true}, -- blocks usage and possession of forbidden weapon IDs. Confiability: 100%. Risk: none. Recommended: true.
    {"projectileDetection", true}, -- detects unauthorized projectile creation (e.g., fire/rocket hacks). Confiability: 100%. Risk: none. Recommended: true.
    {"explosionDetection", true}, -- detects players creating excessive explosions. Confiability: 99%. Risk: none. Recommended: true.
    {"explosionMax", 10}, -- number of explosions allowed within the interval before punishment. Recommended: 8–15.
    {"explosionInterval", 5000}, -- time interval (ms) used to count recent explosions. Recommended: 3000–6000.
    {"jetpackDetection", true}, -- blocks players from using a jetpack without authorization. Confiability: 100%. Risk: none. Recommended: true.

    -- Aimbot / Accuracy
    {"aimbotDetection", true}, -- detects use of aimbot or silent aim based on player hit rate. Confiability: 95%. Risk: very low. Recommended: true.
    {"aimbotHitRateThreshold", 0.9}, -- minimum hit ratio (0.0–1.0) considered suspicious. Recommended: 0.85–0.95.
    {"aimbotMinShots", 50}, -- minimum number of shots before accuracy calculation. Recommended: 30–100.
    {"aimbotTolerance", 3}, -- number of aim violations allowed before punishment. Recommended: 2–4.

    -- Fast Fire / Abuse
    {"fastfireDetection", true}, -- detects weapons fired faster than allowed (considering ping). Confiability: 93%. Risk: low. Recommended: true.
    {"fastfireTolerance", 3}, -- number of fastfire violations allowed before punishment. Recommended: 2–4.

    -- Movement / Fly / Speed
    {"noclipDetection", true}, -- enables noclip detection based on air-time and unsupported movement. Confiability: 98%. Risk: very low. Recommended: true.
    {"noclipDetectionMinHeight", 5}, -- minimum ray depth for ground detection. Recommended: 5–10.
    {"noclipDetectionMaxScore", 5}, -- max score for floating idle detection. Recommended: 4–8.
    {"noclipDetectionMoveScore", 6}, -- max score for floating movement detection. Recommended: 5–8.

    {"godmodeDetection", true}, -- detects if players or vehicles do not lose health. Confiability: 100%. Risk: none. Recommended: true.
    {"godmodeTolerance", 3}, -- number of no-damage events allowed. Recommended: 2–4.
    {"godmodeVehicleMinThreshold", 950}, -- minimum vehicle HP to start detection. Recommended: 900–980.

    {"speedhackDetection", true}, -- detects abnormal player/vehicle speed. Confiability: 90%. Risk: low. Recommended: true.
    {"speedhackMaxSpeed", 30}, -- max speed on foot (units/s). Recommended: 25–35.
    {"speedhackVehicleMaxSpeed", 250}, -- max speed in vehicles (km/h). Recommended: 200–300.
    {"speedhackTolerance", 3}, -- number of speed violations before punishment. Recommended: 2–4.

    {"teleportDetection", true}, -- detects sudden illegitimate position changes. Confiability: 92%. Risk: very low. Recommended: true.
    {"teleportMaxDistance", 50}, -- max movement per tick before considered teleport. Recommended: 40–70.
    {"teleportTolerance", 2}, -- violations before punishment. Recommended: 2–3.
    {"teleportGraceAfterSpawn", 5000}, -- grace time (ms) after spawn. Recommended: 3000–6000.

    {"movementAnalyzer", true}, -- detects bunnyhop-style movement. Confiability: 95%. Risk: very low. Recommended: true.
    {"movementAnalyzerMaxScore", 6}, -- jump abuse score before punishment. Recommended: 4–8.
    {"movementAnalyzerJumpInterval", 800}, -- ms between jumps to consider abuse. Recommended: 600–1000.
    {"movementAnalyzerResetFrames", 5}, -- frames on ground to reset score. Recommended: 4–6.

    -- Network
    {"pingDetection", true}, -- detects players with high ping or packet loss. Confiability: 95%. Risk: very low. Recommended: true.
    {"pingMax", 350}, -- max ping in ms. Punish after 3 intervals. Recommended: 300–400.
    {"packetLossMax", 0.33}, -- max allowed packet loss ratio. Recommended: 0.25–0.35.

    -- World / Environment
    {"worldScanDetection", true}, -- restores world/game properties like gravity and game speed. Confiability: 98%. Risk: none. Recommended: true.
    {"wallScanDetection", true}, -- detects texture/model visibility exploits (e.g., invisible wall hacks). Confiability: 60%. Risk: low. Recommended: true.

    -- System Integrity
    {"serialSpoofDetection", true}, -- detects spoofed, duplicated, or malformed serials. Confiability: 97%. Risk: very low. Recommended: true.
    {"vpnDetection", true}, -- checks if IP is from VPN, proxy or hosting. Confiability: 85%. Risk: medium (may flag mobile IPs). Recommended: true.

    -- Display / UI
    {"windowedModeDetection", true}, -- detects if player is using windowed mode. Confiability: 100%. Risk: none. Recommended: true.
    {"screenshotCheck", true}, -- detects if player has disabled screenshot feature. Confiability: 98%. Risk: none. Recommended: true.

    -- Vehicles
    {"vehicleTypeWhitelist", true}, -- blocks usage of restricted vehicle models (e.g., tank, hydra). Confiability: 100%. Risk: none. Recommended: true.
}

function returnClaireSetting(setting)
    for _, data in ipairs(claireSettings) do
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
