# Flight Modes — Easy / Mild / Wild

> **Now backed by the official manual.** The GOOSKY S1 manual (p.21) defines
> **three** head-speed/pitch flight modes — **General (Normal), IDLE 1, IDLE 2**
> — each with an official throttle and pitch curve. This package maps its
> beginner-friendly names onto them **1:1**: **Easy = General**, **Mild = IDLE 1**,
> **Wild = IDLE 2**. Separately, the GTS has two **stabilization** states
> (manual p.27): **Pose mode** (self-level) and **Manual mode** (3D), selected on
> the stability channel **CH5**. The throttle/pitch values below are **verified
> from the manual**; the remaining `TBD`s are noted explicitly.

## The three modes

| Mode | Switch (SA) | Stability (CH5) | Official mode | Head-speed | Collective pitch | For |
|------|-------------|-----------------|---------------|------------|------------------|-----|
| **EASY** | ↑ | **Pose (self-level)** | **General/Normal** | Normal % (TBD) | +11.5 … **-2.4°** (reduced) | First hovers |
| **MILD** | — | **Pose (self-level)** | **IDLE 1** | **flat 60%** | **±11.5°** symmetric | Circuits |
| **WILD** | ↓ | **Manual (3D)** | **IDLE 2** | **flat 70%** | **±11.5°** symmetric | 3D (experienced) |

> Stability (Pose/Manual) is **independent** of the General/IDLE selection.
> This package's default pairs Pose with Easy/Mild and Manual with Wild via the
> stability switch (see [`switch-table.md`](./switch-table.md)); you can mix them.

## Official values (VERIFIED — GOOSKY S1 manual p.21)

### Throttle / head-speed curves (CH3)

| Stick → | 0% | 25% | 50% | 75% | 100% | Status |
|---------|----|-----|-----|-----|------|--------|
| **Easy** (General/Normal) | — | — | — | — | — | **[TBD]** governor % didn't render cleanly from the scan — set in GOOSKY app (typically < 60%) |
| **Mild** (IDLE 1) | 60 | 60 | 60 | 60 | 60 | **[VERIFIED]** flat 60% |
| **Wild** (IDLE 2) | 70 | 70 | 70 | 70 | 70 | **[VERIFIED]** flat 70% |

> Flat curves keep a **constant governed head speed** while collective varies.
> Absolute **RPM** is an app/governor setting (manual specifies **%**).

### Collective pitch — official degrees (CH6)

| Stick → | 0% | 25% | 50% | 75% | 100% | Status |
|---------|----|-----|-----|-----|------|--------|
| **Easy** (General) | **-2.4°** | -0.6° | +1.8° | +5.5° | **+11.5°** | **[VERIFIED]** asymmetric (beginner) |
| **Mild** (IDLE 1) | **-11.5°** | -5.5° | 0° | +5.5° | **+11.5°** | **[VERIFIED]** symmetric ±11.5 |
| **Wild** (IDLE 2) | **-11.5°** | -5.5° | 0° | +5.5° | **+11.5°** | **[VERIFIED]** symmetric ±11.5 |

### Collective pitch — EdgeTX **%** (what goes in the model file)

EdgeTX sends collective in **%**; the GTS app maps % → degrees via its
**pitch-range** setting. **Assuming the app pitch range = ±11.5°**, the official
degrees above become these EdgeTX curve points (stick 0→100%):

| Stick → | 0% | 25% | 50% | 75% | 100% |
|---------|----|-----|-----|-----|------|
| **Easy** | -21 | -5 | +16 | +48 | +100 |
| **Mild** | -100 | -48 | 0 | +48 | +100 |
| **Wild** | -100 | -48 | 0 | +48 | +100 |

> ⚠️ **Confirm the app's pitch range** and **measure with a pitch gauge**. If your
> app range is not ±11.5°, recompute (degree ÷ range × 100). The degrees are the
> manufacturer's truth; the % is a convenience translation.

> **Honest caveat:** IDLE 1 *and* IDLE 2 use **full ±11.5° collective** per the
> manual — i.e. "Mild" is not gentle on pitch, only on head-speed. The genuinely
> beginner curve is **Easy/General**. If you want a softer Mild, reduce its pitch
> below the official value (and note you've deviated from the manual).

### Rates / expo — `TBD – Verification Required` (not specified in manual)

| Mode | Cyclic weight | Cyclic expo | Tail weight | Tail expo |
|------|---------------|-------------|-------------|-----------|
| Easy | 60% | 30% | 60% | 25% |
| Mild | 80% | 20% | 80% | 15% |
| Wild | 100% | 10% | 100% | 0% |

## How the mode layer is wired in EdgeTX (conceptually)

- **SA** selects the EdgeTX **flight mode** (FM0=Easy/General, FM1=Mild/IDLE1,
  FM2=Wild/IDLE2).
- Each flight mode selects the matching **throttle curve** (CH3, verified %) and
  **pitch curve** (CH6, verified-degree → %), plus the mode's weight/expo on
  cyclic & tail.
- **CH5** (Pose ↔ Manual stability) is driven by **SB** (or by SA in the
  single-switch scheme — see `switch-table.md`). The **CH5 endpoint value (µs/%)
  for Pose vs Manual is `TBD`** — set/confirm so the GTS reads each state.
- **Throttle Hold (SF)** overrides everything → CH3 to motor-off. **HOLD is the
  default at power-on**, enforced by a throttle-state warning.

## Safe progression (beginner path)

1. **Bench only**, blades off: verify stick→FC directions and CH5 mode change.
2. **Easy**, self-level ON, low head-speed: short hovers ~30 cm, nose-in last.
3. Stay in **Easy** for many packs before trying **Mild**.
4. **Wild/3D** only after consistent, confident control and with verified pitch.

> If any value here is still `TBD` when you go to fly, **do not guess** — get it
> from the official GooSky manual / GOOSKY app first.
