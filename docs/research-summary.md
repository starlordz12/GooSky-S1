# Research Summary

A consolidated, verification-tagged summary of everything learned in the
research phase. Read this alongside [`research-sources.md`](./research-sources.md).
Every claim below carries a status tag:

- **[VERIFIED]** – from an official source
- **[REPORTED]** – consistent across community/retailer sources; user must verify
- **[TBD]** – `TBD – Verification Required` (not confirmable from available sources)

> ⚠️ **Top-level caveat:** the official GooSky PDF manual could not be opened
> directly during research (all direct fetches returned HTTP 403). Treat every
> channel/curve/servo/governor/failsafe value as **provisional** until you have
> confirmed it against your own unit's official manual and the GOOSKY app.

---

## 1. The aircraft: GooSky S1 (ELRS / GTS)

- **[REPORTED]** GooSky S1 is a micro 3D flybarless helicopter with **dual
  direct-drive brushless motors** (one main, one tail) and the **GTS
  flight-control system** (configured over Bluetooth via the **GOOSKY mobile
  app**). (E5, E6, A6)
- **[REPORTED]** Physical specs (original S1): main rotor **290 mm**, length
  **278 mm**, height **88 mm**, width **54 mm**, tail rotor **53 mm**, take-off
  weight **≈107 g**. (E6)
- **[REPORTED]** Power: **7.4 V 2S 300 mAh** LiPo (60C), flight time
  **≈8 minutes**, charge time ≈30 min. (E6)
- **[REPORTED]** The **ELRS / New Edition** version exposes an **ELRS interface**
  on the GTS controller and accepts **SBUS** from an ELRS receiver. (E2, E5)
- **[TBD]** Exact identity "**S1 V3 Pro**": no retailer listing for that literal
  name was found. The user must confirm whether their unit is the S1 V2 / S1 New
  Edition / a later revision, since flight-control firmware and defaults can
  differ. (See open questions.)

## 2. Flight controller (GTS) modes

- **[VERIFIED/REPORTED]** The GTS controller provides **two stabilization
  states**, switched on **CH5**:
  - **Mode 1 – Self-stabilization (attitude / "POSE")** — strong self-levelling,
    for beginners. (A5, A6, E2)
  - **Mode 2 – 3D / Aerobatic** — self-levelling minimized, full 3D. (A6)
- **[REPORTED]** Mode selection is via a **transmitter switch assigned to CH5**;
  behaviour/limits are tuned in the **GOOSKY app**. (A5, E2)
- **[TBD]** Whether the GTS firmware exposes a **third / intermediate**
  stabilization state (e.g., a mid "rate+self-level" band on a 3-position CH5)
  could not be confirmed. **This directly affects the Easy/Mild/Wild design**
  (see §6).
- **[TBD]** A dedicated **"rescue"** (self-right / bail-out) function and its
  channel/behaviour could not be confirmed from available sources.

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

## 6. Flight modes: Easy / Mild / Wild (transmitter-side progression)

- **[VERIFIED constraint]** The **GTS controller itself exposes only the two
  stabilization states** described in §2 (on CH5). It does **not** natively
  publish three named modes "Easy/Mild/Wild". (A5, A6, E2)
- **Design decision (documented, not invented as a heli feature):** Easy / Mild /
  Wild are implemented **on the transmitter** as a beginner-progression layer
  that combines:
  1. **CH5 stabilization state** (self-level vs 3D),
  2. the **active throttle/head-speed curve** (low → high), and
  3. **cyclic/tail rate (expo/weight) limits**.
- This is a legitimate, common EdgeTX technique and does **not** add any
  capability the FC lacks — it only chooses among capabilities the FC already
  has. Specific curve/rate numbers are **[TBD]** and flagged in
  [`flight-modes.md`](./flight-modes.md).
- **[TBD]** Whether "Mild" should map to self-level-ON + higher head-speed, or to
  a true intermediate FC state, depends on whether the GTS firmware exposes a mid
  band (see §2). Until confirmed, "Mild" is defined as **self-level ON with a
  higher head-speed curve** and is clearly flagged.

## 7. Throttle / head-speed curves

- **[REPORTED — example only]** A community-reported S1/S2-family example:
  - Normal: `0 – 40 – 60 – 60 – 60`
  - Idle-Up 1: `65 – 65 – 65 – 65 – 65`
  - Idle-Up 2: `75 – 75 – 75 – 75 – 75`
  (E9) — **use only as a starting reference; verify head-speed against the GOOSKY
  app and your blades/battery.**
- **[TBD]** Official GooSky-recommended throttle curve and **governor / head-speed
  target (RPM)** for the S1 — not confirmable; **[TBD]**.

## 8. Pitch curve / collective

- **[TBD]** Official collective **pitch curve** and **end-points/pitch range
  (±°)** for the S1 — not confirmable from available sources; **[TBD]**. A
  symmetric beginner pitch curve is *suggested* (and flagged) in the model docs,
  but real pitch range must be set/limited in the GOOSKY app and bench-measured.

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

1. **Exact airframe/FC revision** ("S1 V3 Pro" vs S1 V2 / New Edition). **[TBD]**
2. **Channel reversing** for CH2/CH3 (and any others) — confirm by bench test. **[TBD]**
3. **Does CH5 support a 3rd/mid stabilization band?** (drives Easy/Mild/Wild). **[TBD]**
4. **Rescue function** existence, channel, and behaviour. **[TBD]**
5. **Official throttle curve + governor / head-speed RPM target.** **[TBD]**
6. **Official collective pitch curve / pitch range (±°).** **[TBD]**
7. **Official failsafe configuration** sanctioned by GooSky for the GTS. **[TBD]**
8. **Final ELRS packet rate / Telem ratio / TX power** for the user's conditions. **[TBD]**

These are restated in [`safety-checklist.md`](./safety-checklist.md) and in the
final validation report.
