# First-Flight Guide — GooSky S1 V3 Pro

A calm, beginner-first walkthrough. **Do every bench step before the field.**

> ⚠️ A helicopter's spinning blades are dangerous. Treat the motor as live
> whenever a battery is connected. **Throttle Hold (SF) stays ON until you are
> ready and clear.** Several settings in this package are
> `TBD – Verification Required` — resolve them (per
> [`goosky-s1-v3-pro-edgetx-profile.md`](./goosky-s1-v3-pro-edgetx-profile.md))
> **before** flying. If unsure, stop.

## Part 1 — Bench setup (blades REMOVED)

1. **Import the model** into EdgeTX Companion 2.10+, review every page, write to
   the radio. Confirm **Mode 2**, **Swash = NONE**, throttle warning ON.
2. **ELRS bind & SBUS** — follow [`elrs-setup.md`](./elrs-setup.md). Confirm link
   (green/solid) and that **CH PROTOCOL = SBUS** on the RX.
3. **GOOSKY app** — connect over Bluetooth; set/confirm **servo directions, swash
   levelling, pitch range, governor/head-speed, gyro gains**. These live in the
   FC, not the radio. Resolve the model's `TBD` items here.
4. **Direction check (blades off):**
   - Aileron right → swash tilts right; Elevator → tilts fore/aft correctly;
     Rudder → tail pitch the right way. Fix any **reversed channel** in EdgeTX
     (CH2/CH3 reverse is a common `TBD`).
   - Collective: full-up stick → blades to positive pitch (with blades off, watch
     swash rise). Confirm symmetric in Wild.
5. **Stabilization check:** move **SB** (or SA) → confirm the FC changes between
   **Self-level** and **3D** (tilt the heli by hand: self-level should drive the
   swash to counter the tilt). Confirm **CH5** does what you expect.
6. **Throttle-hold test:** with SF in **HOLD**, throttle stick does nothing.
   Release hold only with the heli secured and blades **still off** for the first
   spin-up test; confirm the **governor spins up smoothly** and that **hold cuts
   it instantly**.
7. **Failsafe test (blades off):** link up, then **turn the TX off** → motor must
   **stop**. See [`elrs-setup.md`](./elrs-setup.md) §7.

## Part 2 — First power-up at the field

1. Open, flat area; no people/pets within a wide margin; nose pointed away.
2. **SF = HOLD**, **SA = Easy**, **SB = Self-level**, throttle stick **down**.
3. Power radio **first**, confirm correct model + **throttle-hold warning clears
   only when SF is HOLD**. Then power the heli. Wait for the FC to initialize
   (it must be **still** during gyro init — don't move it).
4. Confirm link/telemetry on the radio and in the Lua tool
   ([`GooskyS1.lua`](../lua/SCRIPTS/TOOLS/GooskyS1.lua)).

## Part 3 — First hover (EASY mode)

1. Stand **5+ m back**, blades now installed and double-checked tight.
2. Release **Throttle Hold (SF → LIVE)**; let the head spool to governed speed.
3. Smoothly add **collective** until the heli gets light, then lifts a few cm.
4. Tiny corrections only. If anything feels wrong → **SF to HOLD** immediately.
5. Hover 20–30 cm for short bursts; land; **SF HOLD**; breathe. Repeat.
6. Keep it in **Easy** for **many** packs before Mild. Land on the **timer**, not
   on "feel" (see below).

## Part 4 — Battery & timer discipline

- Official generic figure found: **≈8 min** for the original S1 2S 300 mAh pack —
  this is **[REPORTED]**, not a guarantee for your setup. **[TBD]**
- **Meter your first packs:** land early, measure resting pack voltage, and set
  EdgeTX **Timer T1** alarm a safe margin below your safe-time. Never deep-discharge.
- A LiPo should rest **≥3.7 V/cell** after flight as a conservative target;
  confirm your battery's spec.

## Part 5 — When to progress

- **Easy → Mild:** only after confident, stable hovering and gentle forward
  flight, nose-in included.
- **Mild → Wild (3D):** only with verified **pitch range** and a real reason to —
  3D is unforgiving. Re-read [`flight-modes.md`](./flight-modes.md).

## If something goes wrong

→ **Throttle Hold (SF) ON.** Then see
[`troubleshooting.md`](./troubleshooting.md) and
[`safety-checklist.md`](./safety-checklist.md).
