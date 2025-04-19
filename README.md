
# **🔰 MTA:SA - Claire Anticheat**

Claire is a modular, lightweight anticheat system for MTA:SA, designed to improve the integrity and fairness of multiplayer servers. Its core philosophy is simple: organize detections into clean, independent modules, make them easy to configure, and build an open platform that others can expand and improve.

Claire runs silently in the background, acting as a guardian layer — constantly monitoring player behavior, network conditions, and client-side integrity without interfering with gameplay or degrading performance. Its design favors discretion and precision, targeting cheats without disrupting legitimate users.

If you're looking for a solid, customizable foundation to secure your MTA:SA server, Claire is ready to help.

# **❓ Why does it matter?**
Cheating has become increasingly common in MTA:SA, and there's a growing need for servers to protect themselves in a reliable and sustainable way. Claire was created to address that — not as a closed or private solution, but as something open to everyone. By being fully open-source, Claire gives server owners an accessible and transparent tool to detect common exploits and improve their server environment. But more than that, it invites collaboration. The idea is that, together — through testing, feedback, improvements, and shared knowledge — we can create a more solid, trustworthy anticheat system that benefits the entire MTA community.

# **🛡️ Current features**

Claire currently includes over 20 independent detection modules, covering movement, combat, environment manipulation, network spoofing, and more. All detections are modular, configurable, and designed to operate silently in the background with minimal performance impact. False positives are rare thanks to tolerance-based logic, score systems, and heuristic analysis. Overall reliability across all modules is around 95%, based on extensive stress simulations and edge case testing.

Below is a full list of current features and their real-world reliability:

| Feature                      | Description                                                                                             | Confiability |
|-----------------------------|---------------------------------------------------------------------------------------------------------|--------------|
| Event spam detection         | Detects abuse of client-triggered events by monitoring spam thresholds and invalid events.             | 95%          |
| Explosion spam detection     | Detects excessive explosions that could indicate abuse of projectile or weapon-based hacks.            | 99%          |
| Function blocker             | Blocks dangerous Lua functions (e.g., `loadstring`, `triggerEvent`, `setElementData`) and prevents client tampering. | 90%          |
| GUI/Paste injection guard    | Detects pasting or typing of dangerous functions into GUI inputs or chatboxes.                         | 90%          |
| Lua environment integrity    | Detects corruption or tampering in the global `_G` environment (e.g., using exploit loaders).           | 98%          |
| Anti-loadstring trap         | Instantly intercepts attempts to execute Lua dynamically via `loadstring`, `load`, or `pcall`.          | 100%         |
| Resource shutdown detection  | Prevents attempts to stop Claire or other resources via malicious code.                                | 100%         |
| Fast fire detection          | Detects weapons being fired faster than allowed (macro or triggerbot).                                 | 90%          |
| Aimbot detection             | Uses heuristic analysis to detect inhuman aim accuracy (silent aim, lockbots).                         | 95%          |
| Godmode detection            | Detects infinite health, blocked damage, or unchanging HP even after hits (ped + vehicle).             | 100%         |
| Jetpack blocker              | Prevents unauthorized use of jetpacks not given by legitimate mechanics.                               | 100%         |
| Weapon whitelist enforcement | Blocks usage of forbidden weapon IDs not allowed on the server.                                        | 100%         |
| Projectile detection         | Detects client-side creation of explosives or rockets via cheats.                                     | 100%         |
| Spoofcheck (resource)        | Verifies that the client has loaded the correct meta.xml and scripts to prevent spoofing.              | 95%          |
| Teleport detection           | Detects sudden position changes, including vehicle warps or warps into distant vehicles.              | 93%          |
| Noclip / Fly detection       | Detects floating, hovering, or moving in the air without proper ground or task support.                | 95%          |
| Movement analyzer            | Detects repetitive jump abuse (bunnyhopping) using frame-based timing and jump frequency.              | 95%          |
| Ping monitoring              | Monitors for excessively high ping or severe packet loss over time.                                   | 95%          |
| VPN / Proxy detection        | Uses an external API to detect players using VPNs, proxies or hosting services.                        | 85%          |
| Serial spoof detection       | Heuristically detects invalid or spoofed serials based on system patterns.                             | 85%          |
| Screenshot blocker detection | Detects if the player has disabled screenshot functionality via `takePlayerScreenShot`.                | 100%         |
| Windowed mode detection      | Detects whether the player is running the game in windowed mode (if disallowed in config).             | 100%         |
| World property enforcement   | Resets and monitors `setWorldSpecialPropertyEnabled`, `setGameSpeed`, and `setGravity` for consistency. | 100%         |
| ElementData protection       | Prevents client from modifying sensitive server-only element data (e.g. godmode, admin, vip).           | 95%          |
| Client variable watcher      | Detects changes to known cheating-related `setElementData` variables on the client side.                | 90%          |
| Vehicle type whitelist       | Prevents usage of powerful or abuse-prone vehicles like Hydra, Rhino, Andromada, etc.                  | 100%         |
| Wallhack scanner             | Detects invisible models or missing collisions that may indicate wallhacks or map edits.               | 85%          |
| World scanner                | Detects altered game properties, occlusion flags, gravity manipulation, and speed hacks.               | 90%          |

## 📦 Installation

👉 download from MTA Community: [resource - updated 2025/04/19](https://community.multitheftauto.com/index.php?p=resources&s=details&id=18996)

👉 download from Google Drive: [resource - updated 2025/04/19](https://drive.google.com/file/d/1NQKBaii3_pZCexenCpIw_fqlFQ_CyEA_/view?usp=sharing)

👉 download from GitHub: [source-code - always up-to-date](https://github.com/erknneto/mtasa-claire-anticheat/archive/refs/heads/main.zip)

1. Copy the `claire` resource folder to your MTA server’s `resources` directory.
2. Ensure `claire` is included in your `mtaserver.conf` or started via `start claire`.
3. Ensure `claire` is included in your `acl.xml` with `admin rights`.
4. Add your developer/admin serials in `whitelist.lua`.

## ⚙️ Configuration

Open `config.lua` to enable/disable modules and adjust tolerances, every setting is documented with reliability ratings and use recommendations.

## 👨‍💻 Contributing

Claire is aimed to be an open-source project. Feel free to contribute with PRs, reports, or suggestions.

<p align="center">
  <img src="https://i.imgur.com/Q5ixtO8.png" alt="MTA:SA - Claire Anticheat" width="700">
</p>
