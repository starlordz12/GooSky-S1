# GooSky S1 V3 Pro — EdgeTX Package (RadioMaster TX15 Max, Mode 2)

A beginner-friendly, **research-backed** EdgeTX package for the **GooSky S1
(ELRS / GTS)** helicopter on a **RadioMaster TX15 Max** with **internal
ExpressLRS**. It aims for a Bind-N-Fly-like experience **while staying safe,
documented, and verifiable**.

> ## ⚠️ Read before you fly
> Flight-critical values here are now **verified against the official GOOSKY S1
> Instruction Manual** (throttle/pitch curves p.21, Pose/Manual stability p.27,
> binding, specs) — see [`docs/research-summary.md`](docs/research-summary.md).
> A few **ELRS-specific** items remain `TBD – Verification Required` (ELRS
> failsafe method/power tuning, the Normal-mode governor %, and confirming the
> GTS app pitch-range). **Nothing flight-critical was invented.** This is still a
> **template** — resolve the remaining `TBD`s, confirm values in the GOOSKY app,
> and **bench-test with blades removed** before any flight. Start with
> [`docs/safety-checklist.md`](docs/safety-checklist.md).

## What's inside

| Area | File |
|------|------|
| This overview | [`README.md`](README.md) |
| Model profile (human-readable) | [`docs/goosky-s1-v3-pro-edgetx-profile.md`](docs/goosky-s1-v3-pro-edgetx-profile.md) |
| First-flight guide | [`docs/first-flight-guide.md`](docs/first-flight-guide.md) |
| Switch table | [`docs/switch-table.md`](docs/switch-table.md) |
| Channel map | [`docs/channel-map.md`](docs/channel-map.md) |
| Flight modes (Easy/Mild/Wild) | [`docs/flight-modes.md`](docs/flight-modes.md) |
| Safety checklist | [`docs/safety-checklist.md`](docs/safety-checklist.md) |
| ExpressLRS setup | [`docs/elrs-setup.md`](docs/elrs-setup.md) |
| Troubleshooting | [`docs/troubleshooting.md`](docs/troubleshooting.md) |
| Research sources | [`docs/research-sources.md`](docs/research-sources.md) |
| Research summary | [`docs/research-summary.md`](docs/research-summary.md) |
| EdgeTX model (Companion descriptor) | [`models/GOOSKY_S1_V3_PRO.otx`](models/GOOSKY_S1_V3_PRO.otx) |
| EdgeTX model (on-radio YAML, authoritative) | [`models/GOOSKY_S1_V3_PRO_ELRS.yml`](models/GOOSKY_S1_V3_PRO_ELRS.yml) |
| Lua pre-flight tool (read-only) | [`lua/SCRIPTS/TOOLS/GooskyS1.lua`](lua/SCRIPTS/TOOLS/GooskyS1.lua) |
| Purple image asset notes | [`assets/goosky-s1-v3-pro-purple.md`](assets/goosky-s1-v3-pro-purple.md) |
| Model bitmap (purple) | [`BITMAPS/GOOSKY.bmp`](BITMAPS/GOOSKY.bmp) |
| SD-card install layout | [`sdcard-layout/README.md`](sdcard-layout/README.md) |
| Final validation report | [`docs/final-report.md`](docs/final-report.md) |

## Target hardware

- **Radio:** RadioMaster TX15 Max — EdgeTX **3.0.0+**, **Mode 2**, AG02 Hall
  gimbals, **internal ExpressLRS 2.4 GHz**, 3.5″ IPS touchscreen.
- **Aircraft:** GooSky S1 with **GTS flight controller** and an **ELRS receiver**
  set to **SBUS**. Flybarless (the FC mixes its own swash).

## How it works (one paragraph)

EdgeTX sends **8 channels at full resolution (333 Hz)** over internal ELRS to the
heli's receiver, which outputs **SBUS** to the **GTS** controller. Channel order
is **AETR + CH5 (stability) + CH6 (collective)**. **No swash mixing is done in
the radio** — the flybarless GTS handles that. **Easy / Mild / Wild** map 1:1 onto
the manual's official **General / IDLE 1 / IDLE 2** modes (verified throttle &
pitch curves); the separate **CH5** stability switch picks **Pose (self-level)**
or **Manual (3D)**. **Throttle Hold (SF)** is the master motor cut and
**defaults to HOLD** with a power-on warning.
A **read-only Lua tool** shows mode, timer, throttle-hold, telemetry, a checklist
and switch map — it **never arms the heli or changes any setting**.

## Quick start

1. **Read** [`docs/safety-checklist.md`](docs/safety-checklist.md) and
   [`docs/first-flight-guide.md`](docs/first-flight-guide.md).
2. **Install** files per [`sdcard-layout/README.md`](sdcard-layout/README.md)
   (Companion import recommended).
3. **Bind & configure ELRS** per [`docs/elrs-setup.md`](docs/elrs-setup.md)
   (SBUS, 8ch full-res @ 333 Hz, bind phrase, Model Match).
4. **Resolve every `TBD – Verification Required`** from the official GooSky
   manual + GOOSKY app (channel reversing, CH5 values, throttle/pitch curves,
   governor, failsafe, timer).
5. **Bench-test with blades removed** (directions, CH5, failsafe = motor-off).
6. **Easy mode, low hovers** first — progress slowly.

## Status of key items

**Verified from the official manual:** specs · flight modes (General/IDLE1/IDLE2)
· **pitch curves** · **IDLE throttle %** (60/70) · **Pose/Manual** stability ·
binding.

**Still resolve before flying (`TBD`):**
1. Exact airframe/FC revision ("S1 V3 Pro" naming vs the manual's "S1").
2. Channel **reverse** directions (esp. CH2/CH3) — bench check.
3. CH5 endpoint values for **Pose vs Manual**.
4. **Rescue / bail-out** function existence/behaviour.
5. **Normal-mode governor %** + confirm GTS app **pitch-range (±°)** with a gauge.
6. **ELRS failsafe** method (target: motor-off) + bench-test.
7. **Timer** alarm from your metered safe pack time.
8. Final **ELRS** packet rate / Telem ratio / TX power for your area.

See the [final report](docs/final-report.md) for the full validation results.

## Honest scope & disclaimer

This is a community aid, not an official GooSky/RadioMaster product. Flight-
critical settings must be confirmed against official documentation and your own
unit. RC helicopters are dangerous; you fly at your own risk. If any value is
still `TBD` when you go to fly — **don't fly; verify first.**
