# Research Summary

A consolidated, verification-tagged summary of everything learned in the
research phase. Read this alongside [`research-sources.md`](./research-sources.md).
Every claim below carries a status tag:

- **[VERIFIED]** – from an official source
- **[REPORTED]** – consistent across community/retailer sources; user must verify
- **[TBD]** – `TBD – Verification Required` (not confirmable from available sources)

> ✅ **Update:** the **official GOOSKY S1 Instruction Manual** was later supplied
> by the user and **read directly** (source A0). This **verified** the specs,
> the throttle/pitch flight-parameter table, the flight modes, the Pose/Manual
> stability modes, throttle-hold, and binding. Items below are re-tagged
> accordingly. A few **ELRS-specific** items (packet-rate/power/failsafe tuning,
> and the Normal-mode governor %) remain `TBD`.

---

## 1. The aircraft: GooSky S1 (ELRS / GTS)

- **[VERIFIED — A0 p.6]** GooSky S1 is a micro flybarless helicopter with **dual
  brushless motors driving the main and tail rotors directly**, carbon-fibre
  fuselage + aviation-grade aluminium, the **GTS system** (Higher-Order Control
  Algorithms), **parameter adjustment by SmartPhone app (Bluetooth)**, and
  **upgradeable FBL firmware**.
- **[VERIFIED — A0 p.6]** Physical specs: length **278 mm**, height **88 mm**,
  **main blade 125 mm**, **main rotor 290 mm**, **tail rotor 53 mm**, flying
  weight **≈107 g**.
- **[VERIFIED/REPORTED]** Power: **2S LiPo 300 mAh** (GooSky GT030039 LiPo set,
  A0 p.24); flight time **≈8 min** is **[REPORTED]** (E6) — verify on your pack.
- **[REPORTED]** The **ELRS / New Edition** version exposes an **ELRS interface**
  on the GTS controller and accepts **SBUS** from an ELRS receiver. (E2, E5)
- **[TBD]** Exact identity "**S1 V3 Pro**": no retailer listing for that literal
  name was found. The user must confirm whether their unit is the S1 V2 / S1 New
  Edition / a later revision, since flight-control firmware and defaults can
  differ. (See open questions.)

## 2. Flight controller (GTS) modes

- **[VERIFIED — A0, manual p.27]** The GTS provides **two stabilization states**,
  selected by a transmitter switch (the stability channel, CH5):
  - **Pose mode** — self-stabilization / attitude self-levelling (beginner).
  - **Manual mode** — full manual / 3D (self-levelling off).
- **[VERIFIED — A0, manual p.21]** Separately, there are **three head-speed /
  collective "flight modes": General (Normal), IDLE 1, IDLE 2** — each with its
  own throttle and pitch curve (see §7–§8). These are the standard Normal +
  two Idle-Up modes and are **independent** of Pose/Manual.
- **[VERIFIED]** Parameter limits/behaviour are tuned in the **GOOSKY SmartPhone
  app** (Bluetooth); firmware (FBL) is upgradeable. (A0 p.6)
- **[TBD]** A dedicated **"rescue"** (self-right / bail-out) function — the manual
  shows transmitter labels incl. "Orientation"/"DIR" but does not document a
  bail-out rescue; existence/behaviour remains **`TBD`**.

## 3. Channel map (ELRS → SBUS → GTS)

- **[REPORTED]** Consistent across sources, channel **order is AETR** with
  collective separated out:

  | CH | Function | Notes |
  |----|----------|-------|
  | 1 | Aileron (roll cyclic) | |
  | 2 | Elevator (pitch cyclic) | may need reverse — **[TBD]** |
  | 3 | Throttle → **head speed** (via throttle curve / governor in FC) | |
  | 4 | Rudder (tail / yaw) | |
  | 5 | **Stability / POSE mode** (Mode 1 ↔ Mode 2) | switch channel |
  | 6 | **Collective pitch** | |

  (E2, E4, A6, and corroborated by multiple setup guides)
- **[VERIFIED]** The **GTS/FBL controller performs its own swash mixing**, so the
  **transmitter must NOT apply CCPM/swash mixing** (swash type = none; pass
  channels straight). This is standard for flybarless units. (heli-FBL principle;
  consistent with A6)
- **[TBD]** **Servo / channel reversing** (notably CH2 elevator and CH3 throttle
  are *sometimes* reported reversed on ELRS-SBUS setups) is **unit/config
  dependent** and must be confirmed by a bench direction-check, not assumed. (E2)
- **[TBD]** Exact **failsafe positions** per channel from the official manual.
  Heli best-practice = **motor stop on signal loss**; see §5.

## 4. ExpressLRS configuration (internal ELRS on the TX15 Max)

- **[VERIFIED]** Helicopters need **≥5 channels at full resolution**. The
  **Hybrid** and **Wide** switch modes only give **4 full-resolution channels**,
  which is **not enough**. (C5, E2)
- **[VERIFIED/REPORTED]** Use **"8ch full-resolution"** mode; the **max packet
  rate that supports 8-ch full-res is 333 Hz**. (C5, E8)
- **[VERIFIED]** Receiver **PROTOCOL must be set to SBUS** (ELRS ≥ v3.3.0) for the
  GTS controller to read it. After setting, power-cycle the heli. (E2, C8)
- **[VERIFIED]** Binding is via a **Bind Phrase** (preferred) set identically in
  the TX (ELRS Lua) and the RX firmware, or by button/3-power-cycle bind. (C3)
- **[VERIFIED]** **Model Match** can be enabled in the ELRS Lua script
  (SYS → ExpressLRS → Model Match → ON) so the RX only links to the intended
  model. (C4, C6)
- **[VERIFIED]** ELRS exposes telemetry sensors to EdgeTX including **RSSI / RQ
  (LQ) / TPWR / RSNR** etc. (C4)
- **[TBD]** Exact **TX power, Telem ratio, and final packet rate** appropriate to
  the user's flying environment (set conservatively, see `elrs-setup.md`).

## 5. Failsafe (safety-critical)

- **[VERIFIED principle]** ELRS supports **failsafe = "no pulses"** (RX stops
  outputting) and **set-position/hold** modes. (C-search, RX options)
- **[REPORTED best practice]** For a helicopter the safest behaviour on link loss
  is **rotor/motor stop** (do **not** hold throttle). The recommended setup is to
  ensure the FC enters its own failsafe and **cuts the motor**.
- **[TBD]** The exact, GooSky-sanctioned failsafe configuration for the GTS
  controller (no-pulse vs. set CH3 low) must be confirmed from the official
  manual. Until then this repo specifies **motor-off failsafe** and flags it.

## 6. Flight modes: Easy / Mild / Wild ← official General / IDLE1 / IDLE2

- **[VERIFIED]** The official manual (A0 p.21) defines **three** head-speed/pitch
  flight modes. This package maps its beginner-friendly names onto them **1:1**:

  | Package name | Official mode | Throttle (governor) | Pitch curve (°) |
  |--------------|---------------|---------------------|------------------|
  | **EASY** | **General / Normal** | TBD% (see §7) | +11.5 / +5.5 / +1.8 / -0.6 / -2.4 |
  | **MILD** | **IDLE 1** | **flat 60%** | +11.5 / +5.5 / 0 / -5.5 / -11.5 |
  | **WILD** | **IDLE 2** | **flat 70%** | +11.5 / +5.5 / 0 / -5.5 / -11.5 |

- For beginner safety this package additionally keeps **Pose mode (self-level) ON
  by default** in Easy/Mild and lets the pilot move to **Manual mode** for Wild —
  via the stability switch (CH5). Pose/Manual is **independent** of the
  General/IDLE selection (both verified, §2).
- **Honest note:** the *official* IDLE1 and IDLE2 both use **full symmetric
  ±11.5° collective** — that is not "gentle". Easy (General) is the genuinely
  beginner curve (reduced negative pitch). If you want a softer "Mild", reduce
  its pitch below the official ±11.5°; the table above is the **manufacturer
  value**, clearly labelled.

## 7. Throttle / head-speed curves  — **[VERIFIED (A0 p.21), partial]**

- **IDLE 1: flat 60%**, **IDLE 2: flat 70%** — verified from the flight-parameter
  table. Flat curves let the **governor** hold a constant head speed while
  collective varies (standard for CP helis).
- **General / Normal throttle %:** the manual's Normal-mode throttle figure did
  **not render cleanly** from the scanned table (the IDLE values did). So the
  **Normal governor %** is **`TBD`** — set it in the GOOSKY app (a value below
  IDLE1's 60% is typical for a calm beginner head speed).
- **[TBD]** Absolute **head-speed RPM** target is an app/governor setting; the
  manual specifies throttle **%**, not RPM.

## 8. Pitch curve / collective  — **[VERIFIED (A0 p.21)]**

- Official collective pitch (degrees), per mode:
  - **General/Normal (Easy):** `+11.5, +5.5, +1.8, -0.6, -2.4°` — asymmetric,
    mostly positive → beginner-safe.
  - **IDLE 1 (Mild) & IDLE 2 (Wild):** `+11.5, +5.5, 0, -5.5, -11.5°` — symmetric
    **±11.5°** for inverted/3D.
- **EdgeTX note:** EdgeTX collective is in **%**, the GTS app converts % → degrees
  via its **pitch-range** setting. If the app pitch range is set to **±11.5°**,
  the degrees above translate to the EdgeTX **%** curves used in the model file
  (Easy ≈ `-21/-5/16/48/100`, Mild/Wild ≈ `-100/-48/0/48/100`). **Confirm the
  app's pitch range and bench-measure with a pitch gauge** before flight.

## 8a. Binding (official) — **[VERIFIED (A0 p.21)]**

- **GOOSKY T8 transmitter:** power the heli on, **press BIND 3×**; blue LED
  flashes fast; keep TX <1 m; **solid blue = bound**.
- **Futaba transmitter:** set protocol **S-FHSS**, **long-press BIND** at
  power-on; solid blue = bound.
- **For this ELRS build:** binding is done on the **ELRS** side (bind phrase) as
  in [`elrs-setup.md`](./elrs-setup.md); the GTS only needs valid **SBUS** input
  (manual p.18 shows the FC's **S-BUS / DSMX / BIND / Data** connector).

## 9. RadioMaster TX15 Max (the radio)

- **[VERIFIED]** Runs **EdgeTX** (requires **v3.0.0+**). **AG02 CNC Hall
  gimbals**. **3.5″ IPS touchscreen** (480×320). **Up to 16 channels**.
  **Internal RF: ELRS 2.4 GHz** (LR1121-based; also Sub-GHz 900 MHz capable).
  Built-in gyro & mic, cooling fan. Size 178×168×81 mm, ≈672 g (no battery). (D1, D2)
- **[VERIFIED]** Because internal RF is ELRS, the **ELRS Lua script** lives under
  **SYS → Tools → ExpressLRS** on this radio. (C4, D1)
- **[TBD]** This package targets **Mode 2** as specified. Confirm the physical
  gimbal is the Mode 2 (self-centering elevator, ratcheted/free throttle per the
  user's preference) build.

---

## Open questions / required user verification (carried into the final report)

Resolved by the official manual (A0): specs ✅, flight modes ✅, **pitch curves**
✅, **IDLE throttle %** ✅, stability (Pose/Manual) ✅, binding ✅. **Still open:**

1. **Exact airframe/FC revision** ("S1 V3 Pro" naming vs the manual's "S1"). **[TBD]**
2. **Channel reversing** for CH2/CH3 (and any others) — confirm by bench test. **[TBD]**
3. **Rescue / bail-out function** existence, channel, behaviour. **[TBD]**
4. **Normal-mode governor %** (didn't render cleanly from the scan) + absolute
   **head-speed RPM** target — set in the GOOSKY app. **[TBD]**
5. **GTS app pitch-range (±°)** that the EdgeTX collective % maps to — confirm +
   pitch-gauge measure. **[TBD]**
6. **ELRS failsafe method** (no-pulse vs CH3-set-low) sanctioned for the GTS. **[TBD]**
7. **Final ELRS packet rate / Telem ratio / TX power** for the user's conditions. **[TBD]**
8. **Timer** alarm from the user's metered safe pack time. **[TBD]**

These are restated in [`safety-checklist.md`](./safety-checklist.md) and in the
final validation report.
