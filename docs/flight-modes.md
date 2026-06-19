# Flight Modes — Easy / Mild / Wild

> **Read this first.** The GooSky **GTS flight controller natively exposes only
> two stabilization states** on **CH5** (Self-level / "POSE" and 3D). It does
> **not** publish three modes called Easy/Mild/Wild. In this package, **Easy /
> Mild / Wild are a transmitter-side beginner-progression layer** built in
> EdgeTX. They only *select among capabilities the FC already has* (CH5 state +
> head-speed curve + rate limits). They add no new aircraft capability. See
> [`research-summary.md`](./research-summary.md) §6.
>
> **All curve and rate numbers below are `TBD – Verification Required`.** The
> values shown are conservative *placeholders/examples* so the model is complete
> and importable — **they are not verified GooSky settings and must not be flown
> without confirming head-speed and pitch against the GOOSKY app and a bench
> check.**

## The three modes

| Mode | Switch | CH5 stabilization | Head-speed (throttle curve) | Pitch range | Cyclic/tail rate | Who it's for |
|------|--------|-------------------|-----------------------------|-------------|------------------|--------------|
| **EASY** | SA ↑ | **Self-level ON** | **Low** | **Reduced** | **Reduced + more expo** | First hovers, learning orientation |
| **MILD** | SA — | Self-level ON* | **Medium** | Near-normal | Medium | Forward flight, gentle circuits |
| **WILD** | SA ↓ | **3D (self-level OFF)** | **High** | **Full** | **Full** | Aerobatic / 3D (experienced only) |

\* Whether "Mild" keeps self-level ON or uses a mid CH5 band is **[TBD]** —
depends on GTS firmware (see `research-summary.md` §2). This package keeps Mild =
self-level ON by default and flags it.

## Placeholder values used in the model file (NOT verified)

These mirror a community-reported S1/S2-family **example** and conservative
beginner choices. **Replace after verifying with the GOOSKY app + bench test.**

### Throttle / head-speed curves (CH3) — `TBD – Verification Required`

| Point (stick) | 0% | 25% | 50% | 75% | 100% |
|---------------|----|-----|-----|-----|------|
| **Easy** (Normal) | 0 | 40 | 60 | 60 | 60 |
| **Mild** (Idle-Up 1) | 65 | 65 | 65 | 65 | 65 |
| **Wild** (Idle-Up 2) | 75 | 75 | 75 | 75 | 75 |

> Flat curves (Mild/Wild) keep a **constant head speed** so the governor holds
> RPM while collective varies — standard for collective-pitch helis. **Actual
> RPM/governor target is set in the GOOSKY app and is `TBD`.**

### Collective pitch curves (CH6) — `TBD – Verification Required`

| Point (stick) | 0% | 25% | 50% | 75% | 100% |
|---------------|----|-----|-----|-----|------|
| **Easy** | 40 | 45 | 50 | 60 | 70 |
| **Mild** | 25 | 38 | 50 | 62 | 75 |
| **Wild** | 0 | 25 | 50 | 75 | 100 (symmetric ±) |

> Easy uses a **lifted, compressed** pitch curve (always positive-ish, gentle).
> Wild is **symmetric** for inverted/3D. **Real pitch range (±°) must be limited
> in the GOOSKY app and measured with a pitch gauge — `TBD`.**

### Rates / expo — `TBD – Verification Required`

| Mode | Cyclic weight | Cyclic expo | Tail weight | Tail expo |
|------|---------------|-------------|-------------|-----------|
| Easy | 60% | 30% | 60% | 25% |
| Mild | 80% | 20% | 80% | 15% |
| Wild | 100% | 10% | 100% | 0% |

## How the mode layer is wired in EdgeTX (conceptually)

- **SA** selects a **flight-mode number** (FM1=Easy, FM2=Mild, FM3=Wild) using
  EdgeTX **Flight Modes**.
- Each flight mode selects the matching **throttle curve** (CH3) and **pitch
  curve** (CH6), and applies the mode's **weight/expo** on cyclic & tail inputs.
- **CH5** (stabilization) is driven by **SB** (or by SA in the "Alternative"
  single-switch scheme — see `switch-table.md`). **CH5 value per state is `TBD`.**
- **Throttle Hold (SF)** overrides everything → CH3 to motor-off. **HOLD is the
  default at power-on** and is enforced by a throttle-state warning.

## Safe progression (beginner path)

1. **Bench only**, blades off: verify stick→FC directions and CH5 mode change.
2. **Easy**, self-level ON, low head-speed: short hovers ~30 cm, nose-in last.
3. Stay in **Easy** for many packs before trying **Mild**.
4. **Wild/3D** only after consistent, confident control and with verified pitch.

> If any value here is still `TBD` when you go to fly, **do not guess** — get it
> from the official GooSky manual / GOOSKY app first.
