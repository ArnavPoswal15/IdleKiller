# IdleKiller

A lightweight anti-idle script that simulates natural human mouse activity — smooth random movements with random clicks — to keep productivity trackers (DeskTime, Hubstaff, ActivTrak, TimeDoctor) from marking you idle.

Works on **Windows** (PowerShell) and **macOS** (AppleScript).

---

## How It Works

- Moves mouse **smoothly** in random directions (80px radius)
- **40% chance to click** — mimics actual work behavior
- Returns mouse to original position after each cycle
- Random idle pauses between **10–20 seconds**
- Runs entirely in background — **no installation, no USB dongle**

---

## Why This Beats Mouse Jiggler Apps

| Mouse Jiggler Apps | IdleKiller |
|--------------------|------------|
| Install as standalone apps | Runs as a **script** — no separate app |
| Show up in DeskTime's "Apps" tracking | Shows as **PowerShell** or **Script Editor** — easily disguised |
| Detectable by IT as installed software | Just a file — **no installation footprint** |
| Fixed movement patterns | **Randomized** behavior |
| Can be blocked by company policy | Harder to block since it's just a system script |
| Usually costs money | **Free and open-source** |

### The Detection Problem with Jiggler Apps

Most mouse jiggler apps (like MoveMouse, Jiggler, etc.) install as **standalone applications**. DeskTime and similar trackers **log all open applications** — so your boss can see you were running "MouseJiggler.exe" for 8 hours.

**IdleKiller bypasses this** because:

- **Windows:** Runs inside `PowerShell.exe` — which looks like a normal system process (or you can rename the file to anything like `system-helper.ps1`)
- **macOS:** Runs inside **Script Editor** or as a background process — no separate app to track

---

## Quick Start

### Windows (PowerShell)

1. Download `idle-killer.ps1`
2. Right-click → **Run with PowerShell**
3. Or open PowerShell and run:

```powershell
.\idle-killer.ps1
```

4. Press `Ctrl + C` to stop

**To disguise it:** Rename the file to anything — e.g., `system-check.ps1` or `update-helper.ps1`

---

### macOS (AppleScript)

1. Download `anti-idle.applescript`
2. Open **Script Editor** (in `/Applications/Utilities/`)
3. Open the script and click **Run** ▶
4. Press `Cmd+Q` to stop

**Terminal method:**

```bash
osascript anti-idle.applescript
```

**To disguise it:** Save it as an **Application** in Script Editor → name it something like "System Helper"

---

## Customization

Edit these variables to adjust behavior:

| Variable | Effect | Default |
|----------|--------|---------|
| `$rand.Next(-80,81)` | Movement radius (pixels) | 80px |
| `$rand.Next(10,21)` | Idle delay (seconds) | 10–20s |
| `-le 40` | Click probability | 40% |

---

## Why Randomization Matters

DeskTime and similar trackers don't just check if you're moving the mouse — they look for **patterns**:

- Fixed intervals = suspicious
- Perfectly straight lines = suspicious
- No clicks ever = suspicious

**IdleKiller solves this:**

- Random movement direction & distance
- 40% chance to click (not too much, not too little)
- Smooth human-like curves (not teleporting)
- Random pauses between cycles

---

## Platform Support

| Feature | Windows | macOS |
|---------|---------|-------|
| Smooth movement | ✅ | ✅ |
| Random clicks | ✅ | ✅ |
| Returns to origin | ✅ | ✅ |
| Random delays | ✅ | ✅ |
| No installation | ✅ | ✅ |
| Undetectable as app | ✅ | ✅ |

---

## Disclaimer

> This tool is meant to combat **unfair productivity metrics** that measure keystrokes and mouse moves instead of actual output. Use at your own risk. Do not use if your contract explicitly forbids automation. This is a workaround for toxic surveillance culture, not a tool to cheat honest work.

---

## License

MIT — Free for personal and commercial use.

---

## Star ⭐

If this helps you, give it a star! 🚀
