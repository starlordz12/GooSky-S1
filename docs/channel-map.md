# Channel Map — GooSky S1 (ELRS / GTS) on RadioMaster TX15 Max

> **Verification status:** the channel **order/function** below is **[REPORTED]**
> (consistent across multiple setup guides and corroborated by the GTS
> references). **Channel reversing and failsafe values are
> `TBD – Verification Required`** and must be confirmed on *your* unit before
> flight. See [`research-summary.md`](./research-summary.md) §3.

## Transport chain

```
TX15 Max sticks/switches
   → EdgeTX mixer (CH1..CH8, NO swash mixing — FBL FC does its own)
   → Internal ELRS 2.4 GHz (8ch full-resolution, 333 Hz)
   → ELRS receiver on the heli  → set to SBUS protocol
   → GTS flight controller (swash mixing, governor, stabilization)
```

The GTS is a **flybarless** controller: it mixes the swashplate internally.
**EdgeTX must send straight channels — set Swash Type = NONE.**

## Channel table

| CH | EdgeTX source (Mode 2) | Function at the heli | Reverse? | Failsafe target |
|----|------------------------|----------------------|----------|-----------------|
| **1** | Aileron stick (right-horizontal) | **Aileron** (roll cyclic) | TBD – Verification Required | hold / centre — TBD |
| **2** | Elevator stick (right-vertical) | **Elevator** (pitch cyclic) | **REPORTED: reverse** (CH2 commonly reversed) — bench-confirm | hold / centre — TBD |
| **3** | Throttle stick (left-vertical) **via throttle curve** | **Throttle → head speed** (governor in FC) | **REPORTED: reverse** (CH3 commonly reversed) — bench-confirm | **MOTOR OFF / low** (see note) |
| **4** | Rudder stick (left-horizontal) | **Rudder** (yaw / tail) | TBD – Verification Required | hold / centre — TBD |
| **5** | **Stability switch** (see `switch-table.md`) | **Pose mode (self-level) ↔ Manual mode (3D)** [VERIFIED p.27] | n/a | safe state — TBD |
| **6** | **Collective pitch** (curve driven by flight mode + throttle stick) | **Collective pitch** | TBD – Verification Required | hold — TBD |
| 7 | (reserved / unused) | — | — | — |
| 8 | (reserved / unused) | — | — | — |

> **Failsafe note (safety-critical):** For a helicopter the safest link-loss
> behaviour is **rotor/motor stop**. This package specifies a **motor-off
> failsafe** on CH3 and relies on the GTS entering its own failsafe. The exact
> GooSky-sanctioned failsafe (ELRS "no pulses" vs. CH3-set-low) is
> **`TBD – Verification Required`** — confirm in the official manual. See
> [`elrs-setup.md`](./elrs-setup.md) and [`safety-checklist.md`](./safety-checklist.md).

## Collective vs. throttle (important for helis)

On a collective-pitch heli the **left stick (Mode 2)** does **two** jobs through
EdgeTX curves:

- **Throttle output (CH3):** a *throttle/head-speed curve* → the FC governor
  spins the head to a target RPM.
- **Collective output (CH6):** a *pitch curve* → how much lift the blades make.

Both curves are selected by the active **flight mode** (Easy/Mild/Wild). The
**throttle and pitch numbers are now VERIFIED** from the official manual (p.21) —
see [`flight-modes.md`](./flight-modes.md). The only remaining items are the
**Normal-mode governor %** and confirming the **GTS app pitch-range (±°)** that
the EdgeTX collective % maps to. **Still bench-verify before flight.**

## What is configured where

| Setting | Set in EdgeTX (TX15 Max)? | Set in GOOSKY app / GTS? |
|---------|---------------------------|--------------------------|
| Channel order (AETR + CH5/CH6) | ✅ | reads SBUS order |
| Swash mixing (CCPM) | ❌ (Swash = NONE) | ✅ (FBL does it) |
| Throttle / head-speed curve | ✅ (curve on CH3) | ✅ governor target |
| Collective pitch curve | ✅ (curve on CH6) | ✅ pitch range limit |
| Stabilization mode select | ✅ (CH5 switch) | ✅ mode behaviour/limits |
| Servo direction / sub-trim / swash levelling | ❌ | ✅ (GOOSKY app) |
| Gyro gains / tail gain | ❌ | ✅ (GOOSKY app) |
| Failsafe | ✅ (ELRS RX) | depends — verify |

> Reversing a **servo** is done in the **GOOSKY app**, not in EdgeTX. Reversing a
> **channel direction** (so a stick deflection matches what the FC expects) is
> done in EdgeTX. Get these right with the model **disarmed / blades off** first.
