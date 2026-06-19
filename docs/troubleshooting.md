# Troubleshooting — GooSky S1 V2 (ELRS / EdgeTX)

> First rule when anything is wrong in the air: **Throttle Hold (SF) ON.**
> Status tags as elsewhere: **[VERIFIED] / [REPORTED] / [TBD]**.

## Binding / link

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Won't bind | ELRS **major versions mismatch** (3.x vs 4.x) | Match RX & internal-TX ELRS majors. **[VERIFIED]** |
| Won't bind | Different **bind phrase** | Set identical phrase on TX & RX, or use button bind. **[VERIFIED]** (C3) |
| Binds but no control | RX **not in SBUS**, or GTS not power-cycled | RX PROTOCOL = **SBUS**, power-cycle heli. **[VERIFIED]** (E2) |
| Links to wrong model | **Model Match** off | SYS → ExpressLRS → Model Match → ON. **[VERIFIED]** (C6) |
| Frequent LQ drops | TX power too low / antenna / range | Raise TX power modestly; check antennas; fly closer. **[TBD tuning]** |

## Controls / directions

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| A stick moves swash the wrong way | **Channel reversed** | Reverse that channel in EdgeTX (CH2/CH3 common). Bench, blades off. **[TBD]** |
| Swash tilts wrong / uneven | Swash levelling/servo dir in **FC** | Fix in **GOOSKY app** (not EdgeTX). **[TBD]** |
| Collective inverted | Pitch curve / FC pitch direction | Check CH6 curve + GOOSKY app pitch direction. **[TBD]** |
| Tail spins / won't hold | Gyro gain / rudder dir in **FC** | Tune tail gain in GOOSKY app; verify CH4 dir. **[TBD]** |
| No swash response to hand-tilt in Self-level | Wrong CH5 state / mode | Confirm SB/CH5 selects Self-level; check value. **[TBD]** |

## Motor / throttle / governor

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Motor won't spin | **Throttle Hold ON** (correct!) or throttle warning | Clear area, set SF LIVE only when ready. **[design]** |
| Throttle warning won't clear | SF not in HOLD at power-on | Set SF = HOLD, then power on. **[design]** |
| Head speed too high/low | Throttle curve / governor target | Adjust curve (CH3) + governor in GOOSKY app. **[TBD]** |
| RPM surges/hunts | Governor tune | Tune in GOOSKY app; flatten curve. **[TBD]** |

## Telemetry

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| No sensors | Not discovered / no link | Link first, then Telemetry → Discover. **[VERIFIED]** |
| No pack voltage | RX doesn't forward it | Use timer + standalone battery alarm. **[TBD]** |
| RSSI/LQ both low | End of range | Land; reduce distance; check power/antenna. **[VERIFIED meaning]** |

## Lua tool

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Tool not in SYS→Tools | File misplaced | Put `GooskyS1.lua` in `/SCRIPTS/TOOLS/` on the SD card. |
| Values show `---` | Sensor not present/discovered | Discover sensors; some fields are `TBD` if RX doesn't send them. |
| Script error | EdgeTX version / typo on edit | Use EdgeTX 2.8+/3.x; re-copy unmodified file. |

## Failsafe

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Motor keeps running on TX-off | Failsafe = hold | Set **motor-off** failsafe; bench-test. **[TBD method]** (see elrs-setup §7) |
| Heli "twitches" then stops | FC failsafe engaging | Expected if RX = no-pulses and FC cuts motor. Verify behaviour. **[TBD]** |

## Still stuck?

Re-check [`safety-checklist.md`](./safety-checklist.md) and the official sources
in [`research-sources.md`](./research-sources.md). If a flight-critical value is
still `TBD`, **do not fly** — get it from the official GooSky manual / GOOSKY app.
