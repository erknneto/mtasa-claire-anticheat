--[[ Claire AntiCheat – whitelist.lua
─────────────────────────────────────────────────────
This file contains the list of whitelisted serials.
These serials will be ignored by ALL Claire detections.

How it works:
Claire checks if a player's serial exists in this table.
If it does, the player is considered "trusted" and will bypass punishment logic.
Use this only for developers, testers, or admins you fully trust.

Risks:
- A whitelisted serial will not be punished by Claire, even if cheating.
- If a cheater gains access to a whitelisted machine, they can bypass all security.
- Keep this list extremely restricted and never share it publicly.

Best practices:
- Use only real MTA serials, like: "ABCD1234EFGH5678IJKL9012MNOP3456"
- NEVER whitelist entire ranges of players or unknown machines.
- Avoid using this in production unless strictly necessary.
─────────────────────────────────────────────────────]]

claireWhitelist = {
    {"ABC123DEF456GHI789JKL012MNO345PQ"}, -- Example serial
    {"XYZ987ZYX654WVU321TSR000QPO999LM"}, -- Example serial
}

function isSerialWhitelisted (serial)
    for i, data in ipairs(claireWhitelist) do
        if data[1] == serial then
            return true
        end
    end
    return false
end