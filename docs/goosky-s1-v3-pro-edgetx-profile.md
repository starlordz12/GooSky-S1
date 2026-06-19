# GooSky S1 V3 Pro — EdgeTX Model Profile

Human-readable description of the EdgeTX model in
[`/models/GOOSKY_S1_V3_PRO.otx`](../models/GOOSKY_S1_V3_PRO.otx) /
[`/models/GOOSKY_S1_V3_PRO_ELRS.yml`](../models/GOOSKY_S1_V3_PRO_ELRS.yml).

> ⚠️ **This model is a documented template, not a flight-validated profile.**
> It was built from research in which the **official GooSky manual could not be
> opened directly** (all fetches blocked). **Every flight-critical value is
> either `[REPORTED]` (verify) or `TBD – Verification Required`.** Import it into
> **EdgeTX Companion 2.10+**, review every page, set the `TBD` values from your
> official manual / GOOSKY app, and **bench-test with blades removed** before any
> flight. See [`safety-checklist.md`](./safety-checklist.md).

## Target

- **Radio:** RadioMaster TX15 Max — EdgeTX **3.0.0+** (Companion **2.10+** to edit)
- **Mode:** **2** (throttle left)
- **RF:** **Internal ELRS 2.4 GHz** (CRSF), 8-ch full-resolution, 333 Hz — see
  [`elrs-setup.md`](./elrs-setup.md)
- **Aircraft:** GooSky S1 (ELRS / GTS), flybarless, dual brushless

## Model summary

| Item | Value | Status |
|------|-------|--------|
| Model name | `GOOSKY S1` | — |
| Bitmap | `GOOSKY.bmp` (purple) | — |
| Throttle source | dedicated throttle curve on CH3 (not raw stick) | [REPORTED] |
| Swash type | **NONE** (FBL FC does its own mixing) | [VERIFIED principle] |
| Channel order | **AETR** + CH5 stability + CH6 collective | [REPORTED] |
| Flight modes | Easy / Mild / Wild (TX-side, on **SA**) | design (see flight-modes.md) |
| Stability (CH5) | on **SB** (or SA in single-switch scheme) | [REPORTED]/[TBD] |
| Throttle hold | **SF**, default HOLD, with throttle-warning | design (safety) |
| Timers | T1 = throttle-run countdown; see Timers below | values [TBD] |
| Failsafe | motor-off on link loss | [TBD] exact method |

## Inputs (Mode 2)

| Input | Stick | Notes |
|-------|-------|-------|
| Ail | right horizontal | rate/expo per flight mode |
| Ele | right vertical | rate/expo per flight mode; **reverse TBD** |
| Thr | left vertical | feeds throttle **and** pitch curves |
| Rud | left horizontal | rate/expo per flight mode |

## Mixers (channels)

| CH | Mix | Status |
|----|-----|--------|
| CH1 | Ail (weight/expo by FM) | [REPORTED] |
| CH2 | Ele (weight/expo by FM; reverse?) | reverse **[TBD]** |
| CH3 | **Throttle curve** by FM (Easy/Mild/Wild), cut by Throttle Hold (SF) | curve values **[TBD]** |
| CH4 | Rud (weight/expo by FM) | [REPORTED] |
| CH5 | Stability switch (SB or SA) → Self-level / 3D | value **[TBD]** |
| CH6 | **Pitch curve** by FM | curve values **[TBD]** |

> **No CCPM/swash mix is applied** — the GTS controller mixes the swash. Setting
> a swash mix in EdgeTX on a flybarless heli will cause incorrect control and is
> explicitly avoided.

## Curves

- `Thr Easy`, `Thr Mild`, `Thr Wild` — head-speed curves (CH3) — **values [TBD]**
- `Pit Easy`, `Pit Mild`, `Pit Wild` — collective pitch curves (CH6) — **values [TBD]**

Placeholder numbers are listed in [`flight-modes.md`](./flight-modes.md). They
are conservative examples, **not** verified GooSky settings.

## Logical switches & special functions

- **Throttle-hold warning:** if SF ≠ HOLD at power-on/model-select, EdgeTX shows
  the throttle warning (prevents starting live).
- **Voice/announcements:** flight-mode call-outs, throttle-hold call-out, timer
  call-outs, and telemetry-low warnings — see Voice section in
  [`/sdcard-layout/README.md`](../sdcard-layout/README.md). Sound files referenced
  but **not bundled** (use EdgeTX default voice pack); flagged where assumed.

## Telemetry

ELRS sensors auto-discovered after first link (run *Telemetry → Discover*):
`RSSI/1RSS/2RSS`, `RQly` (link quality), `TPWR`, `RSNR`, `RxBt` (if RX reports
pack voltage), etc. The Lua tool surfaces the key ones. **No telemetry value is
hard-coded** — all come from the live link. See
[`/lua/SCRIPTS/TOOLS/GooskyS1.lua`](../lua/SCRIPTS/TOOLS/GooskyS1.lua).

## Timers

| Timer | Purpose | Setting | Status |
|-------|---------|---------|--------|
| **T1** | Flight time (throttle-run) | counts when throttle hold OFF; **suggest 4:30 alarm** | **[TBD]** — base on your measured safe pack time |
| T2 | (optional) total power-on | off by default | — |

> **Why T1 is `TBD`:** official GooSky flight-time guidance found was the generic
> "≈8 min" figure for the original S1 pack. **Safe usable time depends on your
> battery, blades, and head-speed.** Set T1 from your own first metered packs
> (land at a measured voltage, then set the alarm a margin below that). Do **not**
> fly to an invented timer value. See [`first-flight-guide.md`](./first-flight-guide.md).

## What you must set before flying (TBD checklist)

1. CH2 / CH3 (and others) **reverse** directions — bench verify. **[TBD]**
2. **CH5** value for Self-level vs 3D. **[TBD]**
3. **Throttle curves** (head-speed) per mode — from GOOSKY app. **[TBD]**
4. **Pitch curves / range (±°)** — from GOOSKY app + pitch gauge. **[TBD]**
5. **Failsafe** = motor-off, method confirmed from manual. **[TBD]**
6. **Timer T1** alarm from your measured safe pack time. **[TBD]**
7. **ELRS** packet rate / Telem ratio / TX power for your area. **[TBD]**
