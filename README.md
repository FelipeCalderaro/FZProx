# HorizonProx

**HorizonProx** is a free tool that adds **proximity voice chat** to Forza Horizon. Just like in real life, you can hear your friends' audio fade in and out based on how close their car is to yours. The closer they are, the louder they sound — and if they race past you, you'll even hear the Doppler effect!

No subscriptions, no accounts needed. Just download, set it up once, and drive.

---

## What it does

- **Proximity Audio** — Friends sound louder when they're nearby and fade out as they drive away.
- **Stereo Panning** — Hear which *side* a friend is on: left, right, ahead, or behind.
- **Doppler Effect** — A car speeding past you will sound like it in real life (pitch shifts as they pass).
- **App Audio Sharing** — You can share audio from a specific app (like Spotify) instead of just your mic. Everybody in the session hears your music, and it fades with distance too!

---

## How It Works (Simple Explanation)

HorizonProx has two pieces:

| Piece | What it is | Who needs it |
|---|---|---|
| **Hub** | A "relay station" that passes audio between all players | **One person only** — usually the session host |
| **Client** | The app you run while playing | **Everyone**, including the hub host |

> **Only one Hub is needed per session.** One person in your group starts the Hub on their PC. Everyone else (and the hub host themselves) runs the Client and connects to that Hub. Think of the Hub like a game server — you only need one.

---

## Installation

### Step 1 — Download HorizonProx
1. Go to the **Releases** page of this project.
2. Download the latest `HorizonProx.zip` file.
3. Extract (unzip) it to any folder on your PC — for example, `C:\Games\HorizonProx`.
4. You'll see two executables inside:
   - `fzprox.exe` — **the Client** (everyone runs this)
   - `fzprox_hub.exe` — **the Hub** (only the host runs this)

> **Windows may show a security warning** the first time you run the app because it's not signed by a big corporation. Click **"More info" → "Run anyway"** to proceed. The app is open-source and safe.

---

### Step 2 — Enable Forza Telemetry

HorizonProx reads your car's position from Forza Horizon's built-in data output feature. You need to turn this on **once** in the game settings.

1. Launch **Forza Horizon** and go to the main menu.
2. Open **Settings** → **HUD and Gameplay** → **Data Out**.
3. Set the following:

| Setting | Value |
|---|---|
| Data out | **On** |
| Data out IP address | `127.0.0.1` |
| Data out IP port | `9988` |
| Data out format | **Car Dash** |

4. Save and exit the settings. You only need to do this once.

> `127.0.0.1` is just your own PC's address — this tells Forza to send your position data to HorizonProx running on the same machine.

---

## Connecting Everyone Together

Before playing, your group needs a way to reach the Hub. There are two options:

### Option A — Playing on the same local network (LAN)
If everyone is on the **same Wi-Fi or network** (e.g. a LAN party), this is the simplest option. No extra setup needed — everyone just connects to the Hub host's local IP address.

### Option B — Playing online with friends (Recommended: Tailscale)
If you're playing with friends **over the internet**, the easiest and safest approach is to use **Tailscale** — a free VPN tool that makes everyone's PCs appear as if they're on the same local network. No port-forwarding, no router configuration.

> Tailscale is not sponsored — it's just the simplest solution for this use case.

#### Setting up Tailscale (one-time setup)

**Everyone in the group must do this:**

1. Go to [tailscale.com](https://tailscale.com/) and download **Tailscale** for free.
2. Install it and sign up for a free account (Google, GitHub, or email).
3. Log in and let it run in the background. That's it for everyone except the host.

**The Hub host must also do this:**

4. Open the **Tailscale Admin Console** at [login.tailscale.com](https://login.tailscale.com/).
5. Go to the **Machines** tab.
6. Find your machine in the list, click the **"..."** menu on the right, and select **Share**.
7. Copy the sharing link and send it to your friends via Discord, chat, etc.

**Friends (clients) click the link:**

8. Each friend clicks the sharing link and accepts the invitation.
9. Your machine now appears in their Tailscale network.
10. They can see your **Tailscale IP address** — it looks like `100.x.y.z`. They'll need this to connect their client.

---

## Starting a Session (Step by Step)

### The Hub Host

> The hub host is the person whose PC will act as the relay. Everyone connects to them. **The host also needs to run the Client themselves** to participate in the proximity chat.

1. Open the extracted HorizonProx folder.
2. **Start the Hub first** by running `fzprox_hub.exe`. A window will appear confirming the hub is running on port `9200`. Leave it open.
3. **Then run** `fzprox.exe` (the Client) on the **same PC**.
4. When the Client asks for the **Hub address**, enter: `127.0.0.1:9200`
   - `127.0.0.1` means "connect to myself" — since the Hub is running on the same machine.
5. Follow the in-app setup to choose your microphone (or app audio) and your headphone output.
6. Create or join a **room** using a 4-character code (e.g. `FZRX`). Share this code with your friends.
7. Launch Forza Horizon and start driving!

---

### Everyone Else (Clients)

1. Open the HorizonProx folder and run **`fzprox.exe`** only (you don't need the hub).
2. When asked for the **Hub address**, enter the host's **Tailscale IP** followed by `:9200`.
   - Example: `100.64.0.5:9200`
   - *(The host should tell you their Tailscale IP — it's shown in the Tailscale app on their PC)*
3. Choose your **microphone** (or audio app) and **headphones** when prompted.
4. Enter the **same room code** the host shared with you (e.g. `FZRX`).
5. Launch Forza Horizon and start driving — you'll hear your friends as they get close!

---

## In-App Settings Explained

When you first launch the Client, it will ask you a few questions:

| Question | What to do |
|---|---|
| **Username** | Type your name as you want others to see it. |
| **Hub address** | The hub host's IP + `:9200`. If you're the host, type `127.0.0.1:9200`. |
| **Audio Input** | Choose your microphone, or pick "App" to share audio from a specific program like Spotify. |
| **Audio Output** | Choose your headphones or speakers. |
| **Near distance** | How close (in metres) someone needs to be for full volume. Default is fine. |
| **Far distance** | Beyond this distance, you can't hear them at all. Default is fine. |

---

## Troubleshooting

**I can't hear anyone / nobody can hear me**
- Make sure everyone is in the **same room** (same 4-character code).
- Check that the Hub is running before clients try to connect.
- Check that Forza telemetry is enabled (Step 2 above) — without it, HorizonProx doesn't know where your car is.

**The Client can't connect to the Hub**
- If you're the host connecting to yourself, make sure you typed `127.0.0.1:9200` (not your Tailscale IP).
- If you're a client, make sure Tailscale is running on both your PC and the host's PC, and that you accepted the sharing invitation.
- Check that the Hub window (`fzprox_hub.exe`) is still open.

**Forza Horizon is not detected**
- Double-check the **Data Out** settings in the game (Step 2).
- Make sure the IP is exactly `127.0.0.1` and the port is `9988`.
- Restart Forza Horizon after changing the settings.

**Windows blocked the app from running**
- Right-click `fzprox.exe`, choose **Properties**, and at the bottom check **Unblock**, then click OK.

---

## License

HorizonProx is distributed under a **dual license** model:

- **Open-Source (GNU GPL v3)** — Free to use, modify, and fork for personal and community purposes. Any modified version must also be distributed under GPL v3.
- **Commercial** — Using HorizonProx or any modified version in a commercial setting requires a separate written agreement with the original author. Only the original author may grant commercial licenses.
- Provided **"as is"** with no warranty.

See the full [LICENSE](LICENSE) file for details. For commercial licensing inquiries, contact the author.

---

## Disclaimer

HorizonProx is an **unofficial, independent community project**. It is not affiliated with, endorsed by, or connected to **Turn 10 Studios, Xbox Game Studios, or Microsoft Corporation** in any way. "Forza Horizon" is a registered trademark of Microsoft Corporation.

HorizonProx does **not** modify, patch, or reverse-engineer the game in any way. It only reads data through Forza Horizon's officially published "Data Out" UDP telemetry feature.
