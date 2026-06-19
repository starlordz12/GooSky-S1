# Switch Table — GooSky S1 (ELRS / GTS) on RadioMaster TX15 Max

> **Verification status:** switch *assignments* below are this package's
> **design choice** for a safe beginner layout. The **effect** each position has
> on the GTS controller (especially the CH5 stabilization states) is
> **[REPORTED]/[TBD]** — confirm against the GOOSKY app and
> [`research-summary.md`](./research-summary.md).

## Quick reference

| Switch | Role in this model | Positions |
|--------|--------------------|-----------|
| **SF** (2-pos) | **THROTTLE HOLD** (motor cut / safety) | ↑ = HOLD (motor off) · ↓ = LIVE |
| **SA** (3-pos) | **FLIGHT MODE** → Easy / Mild / Wild | ↑ Easy · — Mild · ↓ Wild |
| **SB** (3-pos) | **STABILITY (CH5)** Self-level ↔ 3D | ↑ Self-level · — (mid*) · ↓ 3D |
| **SH** (momentary) | **RESCUE / panic** (if supported) | press = rescue — **TBD** |
| SC / SD | (reserved) | — |

\* Whether the CH5 **mid** position is meaningful depends on the GTS firmware —
**`TBD – Verification Required`** (see `flight-modes.md`).

> ⚠️ **Why two separate switches (SA + SB)?** SA picks the *transmitter*
> head-speed/rate package (Easy/Mild/Wild); SB drives the *flight-controller's*
> CH5 stabilization. They are kept separate so a beginner can keep **self-level
> ON (SB↑)** while still moving SA between Easy and Mild. Advanced pilots can
> later combine them. You may instead bind CH5 directly to SA — see "Alternative"
> below.

## RadioMaster TX15 Max switch inventory (verify on your unit)

The TX15 Max switch complement can vary by revision. **[TBD]** Confirm your exact
switches in *EdgeTX → Model → Inputs/Logical* or *Hardware*. Typical layout
assumed by this model:

- **SA, SB** – 3-position
- **SC, SD** – 3-position
- **SE** – 2/3-position
- **SF** – 2-position
- **SH** – 2-position **momentary** (spring return)

If a switch named here does not exist on your radio, reassign it in EdgeTX and
update this table. **Nothing in this package will arm the heli from a switch by
itself** — throttle hold defaults to **HOLD**.

## Critical safety behaviour

- **THROTTLE HOLD (SF) is the master motor cut.** It must be **ON/HOLD** whenever
  you are not actively flying: powering on, binding, picking up the heli, walking
  to/from it, and after any anomaly.
- On model load and at power-up, EdgeTX is configured to **warn** if SF is not in
  the **HOLD** position (throttle-state warning), so you cannot start with a live
  motor by accident.
- The **flight-mode switch (SA)** never bypasses throttle hold.

## Alternative simpler mapping (single-switch CH5)

If you prefer the simplest possible setup, bind **CH5 directly to SA** so flight
mode and stabilization move together:

- **SA↑ = Easy** → CH5 = Self-level, low head-speed, gentle rates
- **SA– = Mild** → CH5 = Self-level, higher head-speed
- **SA↓ = Wild** → CH5 = 3D, full head-speed

This is documented and supported by the model file's comments; pick **one**
scheme and keep `switch-table.md` and the model consistent. **The exact CH5
value (µs / %) for each state is `TBD – Verification Required`.**
