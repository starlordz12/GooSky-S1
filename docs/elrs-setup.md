# ExpressLRS Setup — GooSky S1 (GTS) on RadioMaster TX15 Max

How to bind and configure the **internal ELRS** of the TX15 Max to the ELRS
receiver feeding the GooSky GTS controller. Status tags: **[VERIFIED]** (official
ELRS/RadioMaster docs), **[REPORTED]** (verify), **[TBD]** (`Verification
Required`).

> The TX15 Max has **internal ELRS**, so the ELRS Lua script is at
> **SYS → Tools → ExpressLRS** (not an external module). **[VERIFIED]** (D1, C4)

## 0. Prerequisites

- TX15 Max on **EdgeTX 3.0.0+**. **[VERIFIED]**
- Internal ELRS and the heli's ELRS receiver on **compatible ELRS major
  versions** (both 3.x **or** both 4.x — mismatched majors will not bind).
  **[VERIFIED]** Check the RX firmware version printed by the vendor / WebUI.
- Receiver supports **SBUS output** (ELRS ≥ v3.3.0). **[VERIFIED]** (C8, E2)

## 1. Receiver protocol → SBUS  **[VERIFIED]** (E2)

The GTS reads **SBUS**. In the ELRS Lua script:
`SYS → Tools → ExpressLRS → (scroll to) Other Devices → [your RX] → PROTOCOL → SBUS`,
then **power-cycle the heli**. The GTS should detect SBUS on next boot.

> If your RX is a **PWM** receiver wired into the GTS instead, set per-channel
> outputs there. This package assumes **SBUS** (single-wire serial). **[REPORTED]**

## 2. Channel count / switch mode — use 8ch full-resolution  **[VERIFIED]** (C5, E2, E8)

Helicopters need **≥5 channels at full resolution**. Hybrid/Wide only give 4
full-res channels — **not enough**.

- Set switch mode to **"8ch" (full-resolution)**.
- The **maximum packet rate that supports 8-ch full-res is 333 Hz** → use
  **333 Hz**. **[VERIFIED]**

## 3. Bind  **[VERIFIED]** (C3)

**Preferred — Bind Phrase:**
1. Choose a unique phrase, e.g. `goosky-s1-<yourname>` (lowercase). **Keep it
   private — anyone with your phrase can bind to your model.**
2. Set the **same phrase** in the RX firmware (flashed or via its WebUI) **and**
   in the TX (ELRS Lua → *Bind Phrase*, or the radio's ELRS settings).
3. Power both — they auto-bind (no button press needed).

**Alternative — button/3×power-cycle bind** if your RX has no preset phrase: put
the RX in bind mode (per its manual), then TX ELRS Lua → **[Bind]**. **[VERIFIED]**

> **GTS side (for reference):** the official manual binds the *stock* radios to
> the GTS directly (GOOSKY T8: power heli on, **press BIND 3×**, solid-blue FC LED
> = bound; Futaba: **S-FHSS**, long-press BIND). For **this ELRS build you bind on
> the ELRS side** (above); the GTS just needs valid **SBUS** on its S-BUS input
> (manual p.18). **[VERIFIED — manual p.21]**

## 4. Model Match (recommended)  **[VERIFIED]** (C4, C6)

Enable **SYS → ExpressLRS → Model Match → ON** so the RX only links to *this*
EdgeTX model. Prevents flying the heli on the wrong model's mixes. **[VERIFIED]**

## 5. Telemetry  **[VERIFIED]**

ELRS returns link telemetry to EdgeTX. After first link:
*EdgeTX → Model → Telemetry → Discover new sensors.* Expect: `RSSI/1RSS/2RSS`,
`RQly` (Link Quality), `TPWR`, `RSNR`, and `RxBt`/voltage **if** your RX reports
it. **[VERIFIED]** The Lua tool displays the key ones.

> **[TBD]** Whether your specific RX forwards **pack voltage** to telemetry
> depends on the RX model / wiring. If absent, rely on the **timer** and a
> separate battery alarm.

## 6. TX power & Telem ratio — set conservatively  **[TBD]**

- **TX Power:** start **low** (e.g. 25–100 mW) for a small heli flown LOS close
  in; raise only if you see link-quality drops at your real distances. **[TBD]**
- **Telem ratio:** **Std** (auto) is fine to start; at 333 Hz a ratio like 1:8–1:16
  is typical. Tune later. **[TBD]**
- Respect your **local regulations** for power and LBT/region. **[TBD]**

## 7. Failsafe — motor-off (safety-critical)  **[TBD method]**

For a heli, link-loss must **stop the rotor**. Two common ways:
- **ELRS "no pulses"** → RX stops outputting; the GTS then runs *its own*
  failsafe (should cut motor — **confirm in GooSky manual**). **[TBD]**
- **Set position** → set **CH3 (throttle) to its motor-off value** as the failsafe
  position so the FC sees throttle-cut on loss. **[REPORTED best practice]**

**Test on the bench (blades OFF):** power both, then power the TX off — confirm
the motor **stops**. Do not skip this. The exact GooSky-sanctioned method is
**`TBD – Verification Required`.**

## 8. Quick checklist

- [ ] Both ELRS majors match (3.x/3.x or 4.x/4.x) **[VERIFIED need]**
- [ ] RX **PROTOCOL = SBUS**, heli power-cycled **[VERIFIED]**
- [ ] Switch mode **8ch full-res**, packet rate **333 Hz** **[VERIFIED]**
- [ ] Bound via **Bind Phrase**; **Model Match ON** **[VERIFIED]**
- [ ] Telemetry sensors discovered **[VERIFIED]**
- [ ] TX power low to start **[TBD]**
- [ ] **Failsafe = motor-off, bench-verified** **[TBD method]**

Sources: ExpressLRS official docs (C1–C8), RadioMaster TX15 Max specs (D1–D2),
OriginHobbies SBUS-heli guide (E2). See [`research-sources.md`](./research-sources.md).
