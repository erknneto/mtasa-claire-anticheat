
# **🔰 MTA:SA - Claire Anticheat**

Claire is a modular, lightweight anticheat system for MTA:SA, designed to improve the integrity and fairness of multiplayer servers. Its core philosophy is simple: organize detections into clean, independent modules, make them easy to configure, and build an open platform that others can expand and improve.

Claire runs silently in the background, acting as a guardian layer — constantly monitoring player behavior, network conditions, and client-side integrity without interfering with gameplay or degrading performance. Its design favors discretion and precision, targeting cheats without disrupting legitimate users.

But Claire is more than just a list of static rules — it’s a behavioral firewall. It combines heuristic analysis, score-based detection, environmental scanning, and execution monitoring to catch both common and sophisticated cheats in real-world conditions. Claire doesn't aim to be perfect — it aims to be useful. It’s still under active development, and while it’s not flawless, it’s fully open-source, extensible, and built with long-term maintainability in mind. Feedback, contributions, and constructive criticism are not only welcome — they’re essential.

The project began as a collaboration between developers with real-world server experience, combining human expertise with AI-assisted structure and speed. From day one, the goal has been to create something that benefits not just one server, but the broader MTA community.

If you're looking for a solid, customizable foundation to secure your MTA:SA server, Claire is ready to help.

# **❓ Why does it matter?**
Cheating has become increasingly common in MTA:SA, and there's a growing need for servers to protect themselves in a reliable and sustainable way. Claire was created to address that — not as a closed or private solution, but as something open to everyone.

By being fully open-source, Claire gives server owners an accessible and transparent tool to detect common exploits and improve their server environment. But more than that, it invites collaboration. The idea is that, together — through testing, feedback, improvements, and shared knowledge — we can create a more solid, trustworthy anticheat system that benefits the entire MTA community.

# **🛡️ Current features**

Claire currently includes over 20 independent detection modules, covering movement, combat, environment manipulation, network spoofing, and more. All detections are modular, configurable, and designed to operate silently in the background with minimal performance impact.

False positives are rare thanks to tolerance-based logic, score systems, and heuristic analysis. Overall reliability across all modules is around 95%, based on extensive stress simulations and edge case testing.

Below is a full list of current features and their real-world reliability:

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
