
# **🔰 MTA:SA - Claire Anticheat**

Claire is a modular anticheat system for MTA:SA, designed to help improve the overall quality and fairness of multiplayer servers. The idea is simple: organize detections into clean, independent modules, make the system easy to configure, and open it up so more people can contribute.

The project started as a collaboration between a few developers — combining real server experience with support from AI to speed up development and keep things structured. From the start, the goal has been to build something useful not just for one server, but for the wider MTA community.

Claire is still in active development. It's not perfect — and it doesn’t try to be. But it’s open-source, easy to extend, and built with long-term maintainability in mind. Contributions, feedback, and constructive criticism are not only welcome, but essential to make this project better over time.

If you're running an MTA:SA server and looking for a solid base to start protecting it, Claire might be a good starting point.

# **❓ Why does it matter?**
Cheating has become increasingly common in MTA:SA, and there's a growing need for servers to protect themselves in a reliable and sustainable way. Claire was created to address that — not as a closed or private solution, but as something open to everyone.

By being fully open-source, Claire gives server owners an accessible and transparent tool to detect common exploits and improve their server environment. But more than that, it invites collaboration. The idea is that, together — through testing, feedback, improvements, and shared knowledge — we can create a more solid, trustworthy anticheat system that benefits the entire MTA community.

Security should not be a luxury or a mystery. It should be something we build together.

# **🛡️ Current features**

| Feature                        | Description                                                                                           | Confiability |
| :-----------------------------| :------------------------------------------------------------------------------------------------------| :------------|
| Event spam detection        | Detects abuse of client-triggered events by monitoring spam thresholds and invalid events.            | 95%          |
| Explosion spam detection    | Detects excessive explosions that could indicate abuse of projectile or weapon-based hacks.           | 99%          |
| Function blocker            | Blocks dangerous Lua functions (loadstring, setElementData, triggerEvent, etc.) used by cheats.| 90%         |
| Projectile detection        | Detects illegitimate projectile creation, including grenades and RPGs spawned via cheats.             | 100%         |
| Jetpack blocker             | Blocks unauthorized usage of jetpacks outside legal game mechanics or maps.                           | 100%         |
| Weapon whitelist enforcement| Blocks forbidden weapon IDs, especially weapons not meant for players or too powerful.                | 100%         |
| Spoofcheck (resource)       | Verifies that client loaded the correct meta.xml and that no spoofing occurred.                       | 95%          |
| Fast fire detection         | Detects weapons being fired faster than their allowed intervals (e.g., rapid-fire macros).            | 90%          |
| Aimbot detection            | Detects inhuman hit accuracy using heuristic analysis of damage and hit ratios.                       | 95%          |
| Ping monitoring             | Detects players with excessively high ping or unstable packet loss.                                   | 95%          |
| VPN/proxy detection         | Detects players using VPNs, proxies or hosting networks using external APIs.                          | 85%          |
| Serial spoof detection      | Heuristically detects fake or spoofed serials to bypass bans or impersonate others.                   | 85%          |
| Noclip detection            | Detects ghost-like movement or floating in air without legit ground support.                          | 95%          |
| Godmode detection           | Detects players who ignore damage or have infinite health, including in vehicles.                     | 100%         |
| Speedhack detection         | Detects abnormal foot or vehicle speeds exceeding configured thresholds.                              | 90%          |
| Movement analyzer           | Detects repetitive jump spam (bunnyhopping) based on intervals and scores.                            | 95%          |
| ElementData protection      | Prevents client from modifying sensitive element data such as godmode, admin, etc.                    | 95%          |
| Client variable watcher     | Detects modifications to known dangerous variables often toggled by cheats.                           | 90%          |
| World scanner               | Detects invisible models or replaced world elements that hide players or walls.                       | 90%          |
| Wallhack scanner            | Detects removal of collisions or wall models replaced with invisible versions.                        | 85%          |
| Vehicle type whitelist      | Prevents usage of absurd or abuse-prone vehicles (Hydra, Rhino, Andromada, etc.)                      | 100%         |
| Windowed mode detection     | Detects usage of windowed mode to block potential screen recorders or overlays.                       | 100%         |
| Screenshot blocker detection| Detects if the player has disabled MTA screenshots.                            | 100%         |

## 📦 Installation

1. Copy the `claire` resource folder to your MTA server’s `resources` directory.
2. Ensure `claire` is included in your `mtaserver.conf` or started via `start claire`.
3. Ensure `claire` is included in your `acl.xml` with `admin rights`.
4. Add your developer/admin serials in `whitelist.lua`.

## ⚙️ Configuration

Open `config.lua` to enable/disable modules and adjust tolerances, every setting is documented with reliability ratings and use recommendations.

## 👨‍💻 Contributing

Claire is aimed to be an open-source project. Feel free to contribute with PRs, reports, or suggestions.

<p align="center">
  <img src="https://i.imgur.com/Q5ixtO8.png" alt="MTA:SA - Claire Anticheat" width="500">
</p>
