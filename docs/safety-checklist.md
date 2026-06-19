# Safety Checklist — GooSky S1 V3 Pro

> Spinning helicopter blades cause serious injury. **Throttle Hold (SF) is your
> master cut — use it.** Do not skip the bench section. Items marked
> **`TBD – Verification Required`** must be resolved before flight.

## A. One-time verification

Verified from the official manual (already in the model): throttle **60/70%**
(Mild/Wild), pitch **+11.5…-2.4 / ±11.5°**, **Pose/Manual** stability, modes
**General/IDLE1/IDLE2**, specs. Still confirm:

- [ ] Confirmed airframe/FC revision matches the manual's "S1". **[TBD]**
- [ ] Channel **reverse** directions bench-verified (esp. CH2/CH3). **[TBD]**
- [ ] **CH5** Pose/Manual endpoint values correct and switch behaves. **[TBD]**
- [ ] **GTS app pitch-range (±°)** confirmed and pitch **measured with a gauge**
      (the EdgeTX % assume ±11.5°). **[TBD]**
- [ ] **Easy/Normal governor %** set in GOOSKY app (Mild/Wild verified 60/70). **[TBD]**
- [ ] **Failsafe = motor-off**, ELRS method confirmed and **bench-tested**. **[TBD]**
- [ ] **Timer T1** alarm set from *your* metered safe pack time. **[TBD]**
- [ ] **ELRS** packet rate (333 Hz/8ch full-res), bind phrase, Model Match,
      conservative TX power. **[VERIFIED steps / TBD power]**
- [ ] Swash type = **NONE** in EdgeTX (FBL FC mixes). **[VERIFIED principle]**

## B. Every-session pre-flight (blades ON, before spool-up)

- [ ] Area clear: no people/pets/obstacles within a wide margin; nose **away**.
- [ ] **SF = HOLD**, **SA = Easy**, **SB = Self-level**, throttle stick **down**.
- [ ] Blades, blade bolts, main/tail gears, canopy, frame screws — **tight**.
- [ ] Battery charged, undamaged (no puffing), strapped in securely.
- [ ] Power **radio first**; correct **model** loaded; **throttle warning** behaves.
- [ ] Power heli; keep it **still** for gyro init; do not move until initialized.
- [ ] **Link & telemetry OK** (RSSI/LQ healthy in the Lua tool / telemetry screen).
- [ ] **Failsafe sanity** (periodically, blades off): TX-off → motor stops.
- [ ] Stand back **5+ m** before releasing Throttle Hold.

## C. In-flight rules

- [ ] First sessions: **Easy** mode only, low hovers, short bursts.
- [ ] **Anything unexpected → SF to HOLD immediately.**
- [ ] Land on the **timer**, not on guesswork.
- [ ] Watch **LQ/RSSI**; if it degrades, bring the heli **closer** and land.
- [ ] Never fly over people; keep the tail/disc oriented safely.

## D. Post-flight

- [ ] **SF = HOLD**, then disconnect heli battery **before** powering the radio off.
- [ ] Let motors/ESC cool; inspect for heat, play, or damage.
- [ ] Store LiPos at storage charge; never charge unattended.

## E. Hard safety guarantees in this package

- The **Lua tool never arms the heli and never changes flight-critical
  settings** — it is read-only/informational.
- The model **defaults to Throttle Hold** and uses a **throttle-state warning**
  so you cannot start with a live motor by accident.
- **No flight-critical value was invented.** Anything not confirmable is labelled
  `TBD – Verification Required` for you to set from official sources.

## F. If a `TBD` is still unresolved

**Do not fly.** Get the value from the **official GooSky manual** / **GOOSKY app**
/ your unit. Guessing flight-critical settings on a CP heli risks injury and
damage.
