# GooSky S1 V3 Pro — EdgeTX Package (RadioMaster TX15 Max, Mode 2)

A beginner-friendly, **research-backed** EdgeTX package for the **GooSky S1
(ELRS / GTS)** helicopter on a **RadioMaster TX15 Max** with **internal
ExpressLRS**. It aims for a Bind-N-Fly-like experience **while staying safe,
documented, and verifiable**.

> ## ⚠️ Read before you fly
> The mandatory research phase ran in an environment where **the official GooSky
> PDF manual could not be opened** (all direct page fetches were blocked).
> Therefore **every flight-critical value here is either `[REPORTED]` (community-
> corroborated, verify) or `TBD – Verification Required`.** **Nothing
> flight-critical was invented.** This package is a **documented, importable
> template** — you must resolve the `TBD` items from the official GooSky manual /
> GOOSKY app and **bench-test with blades removed** before any flight.
> Start with [`docs/safety-checklist.md`](docs/safety-checklist.md).

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
the radio** — the flybarless GTS handles that. **Easy / Mild / Wild** are a
**transmitter-side** beginner-progression layer (CH5 state + head-speed curve +
rate limits); the GTS itself only exposes Self-level/3D on CH5. **Throttle Hold
(SF)** is the master motor cut and **defaults to HOLD** with a power-on warning.
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

## Open verification items (must resolve before flying)

1. Exact airframe/FC revision ("S1 V3 Pro" vs S1 V2 / New Edition).
2. Channel **reverse** directions (esp. CH2/CH3).
3. CH5 **Self-level / 3D** values (and whether a mid band exists).
4. **Rescue** function existence/behaviour.
5. Official **throttle curve + governor / head-speed RPM**.
6. Official **collective pitch curve / range (±°)**.
7. Official **failsafe** configuration (target: motor-off).
8. **Timer** alarm from your metered safe pack time.
9. Final **ELRS** packet rate / Telem ratio / TX power for your area.

See the [final report](docs/final-report.md) for the full validation results.

## Honest scope & disclaimer

This is a community aid, not an official GooSky/RadioMaster product. Flight-
critical settings must be confirmed against official documentation and your own
unit. RC helicopters are dangerous; you fly at your own risk. If any value is
still `TBD` when you go to fly — **don't fly; verify first.**
