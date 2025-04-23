
# **🔰 MTA:SA - Claire Anticheat**

Claire is a modular, lightweight anticheat system for MTA:SA, designed to improve the integrity and fairness of servers. Its core philosophy is simple: organize detections into clean, independent modules, make them easy to configure, and build an open platform that others can expand and improve.

Claire runs silently in the background, acting as a guardian layer — constantly monitoring player behavior, network conditions, and client-side integrity without interfering with gameplay or degrading performance. Its design favors discretion and precision, targeting cheats without disrupting legitimate users.

If you're looking for a solid, customizable way to secure your MTA:SA server, try out Claire.

# **❓ Why does it matter?**

Cheating has become a problem in MTA:SA, and there's a growing need for servers to expand their protection. Claire was created to address that — not as a closed or private solution, but as something open to everyone. By being fully open-source, Claire gives server owners an accessible and transparent tool to detect common exploits and improve their server environment. But more than that, it invites collaboration. The idea is that, together — through testing, feedback, improvements, and shared knowledge — we can create a more solid, trustworthy anticheat system that benefits the entire MTA community.

# **🛡️ Current features**

Claire currently includes over 20 independent detection modules, covering movement, combat, environment manipulation, network spoofing, and more. All detections are modular, configurable, and designed to operate silently in the background with minimal performance impact. False positives are rare thanks to tolerance-based logic, score systems, and heuristic analysis. Overall reliability across all modules is expected to be around 95%.

Below is a full list of current features and their expected reliability:

| Feature                      | Description                                                                                             | Confiability |
|-----------------------------|---------------------------------------------------------------------------------------------------------|--------------|
| Event spam detection         | Detects abuse of client-triggered events, including invalid or excessive triggers.                     | 95%          |
| Function blocker             | Blocks dangerous or hijacked Lua functions client-side (`loadstring`, `triggerServerEvent`, etc).       | 90%          |
| GUI/Paste injection guard    | Detects pasting or typing of dangerous functions into GUI inputs or chatboxes.                         | 90%          |
| Lua environment integrity    | Detects corruption or tampering in the global `_G` environment (e.g., using exploit loaders).           | 98%          |
| ElementData protection       | Blocks client-side attempts to modify sensitive ElementData keys (`godmode`, `vip`, `admin`, etc).      | 95%          |
| Client variable watcher      | Detects unauthorized setting of known cheat-related variables (e.g., `fly`, `superman`, `invisible`).   | 90%          |
| Weapon blocker               | Removes forbidden weapons such as minigun, flamethrower, satchel, etc.                                  | 100%         |
| Projectile detection         | Detects client-side creation of explosives, projectiles, or rockets.                                   | 100%         |
| Explosion spam detection     | Detects players creating too many explosions in a short time.                                          | 99%          |
| Jetpack blocker              | Prevents use of jetpack unless given through valid mechanics.                                          | 100%         |
| Aimbot detection             | Tracks hit rate over time to detect silent aim, triggerbot, or unnatural accuracy.                     | 95%          |
| Fast fire detection          | Detects weapons being fired faster than allowed, accounting for ping.                                 | 93%          |
| Noclip / Fly detection       | Detects floating or air movement without ground contact.                                               | 98%          |
| Godmode detection            | Detects players or vehicles that do not lose health after taking damage.                              | 100%         |
| Speedhack detection          | Detects players or vehicles moving faster than realistic speed limits.                                | 90%          |
| Teleport detection           | Detects sudden position changes, including entering distant vehicles.                                | 92%          |
| Movement analyzer            | Detects bunnyhop or jump spamming by tracking jump frequency and movement.                            | 95%          |
| Ping/Packet Loss detection   | Detects high ping or packet loss with timed tolerance logic.                                           | 95%          |
| Screenshot blocker detection | Detects clients that block the screenshot system using cheat loaders.                                 | 98%          |
| Windowed mode detection      | Detects if the game is running in windowed mode (if disallowed).                                      | 100%         |
| Serial spoof detection       | Detects spoofed, duplicated, or malformed serials.                                                    | 97%          |
| VPN / Proxy detection        | Uses external API to check if player is using VPN, proxy or hosting IP.                               | 85%          |
| World scanner                | Restores and monitors gravity, speed, occlusions, and other critical world settings.                   | 98%          |
| Wallhack scanner             | Detects invisible models or altered map visibility.                                                   | 60%          |
| Vehicle type blocker         | Blocks vehicles like Rhino, Hydra, Andromada, RC vehicles, etc.                                       | 100%         |

## **🏷️ Current version**

Claire's current version is `1.1.4`, released on `2025/04/22`, it brings a wide range of improvements and stability fixes across all modules, with a special focus on the noclip, aimbot, and teleport detection systems. This update enhances overall reliability, reduces false positives, and improves compatibility with legitimate server-side systems.

## **📦 Installation**

👉 download from MTA Community: [resource - updated 2025/04/22](https://community.multitheftauto.com/index.php?p=resources&s=details&id=18996)

👉 download from GitHub: [source-code - always up-to-date](https://github.com/erknneto/mtasa-claire-anticheat/archive/refs/heads/main.zip)

1. Copy the `claire` resource folder to your MTA server’s `resources` directory.
2. Ensure `claire` is included in your `mtaserver.conf` or started via `start claire`.
3. Ensure `claire` is included in your `acl.xml` with `admin rights`.
4. Add your developer/admin serials in `whitelist.lua`.

## **⚙️ Configuration**

Open `config.lua` to enable/disable modules and adjust tolerances, every setting is documented with reliability ratings and use recommendations.

## **👨‍💻 Contributing**

Claire is aimed to be an open-source project. Feel free to contribute with PRs, reports, or suggestions.

<p align="center">
  <img src="https://i.imgur.com/Q5ixtO8.png" alt="MTA:SA - Claire Anticheat" width="700">
</p>
