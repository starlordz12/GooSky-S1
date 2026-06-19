# Research Sources

This document lists every source consulted during the **mandatory research phase**
for the GooSky S1 V3 Pro EdgeTX package. Research was performed **before** any
flight-critical file was generated, in accordance with the project rules.

## Research method & limitations (read this first)

- **Phase 1 (web):** initial research ran in a sandboxed environment where
  **direct page fetching (WebFetch) of every target URL returned HTTP 403**.
  Information was gathered through web-search result summaries of official,
  retailer, and community pages. At that point the official PDF could not be
  read, so flight-critical values were marked `TBD – Verification Required`.
- **Phase 2 (official manual):** the user then supplied the **official GOOSKY S1
  Instruction Manual** (PDF) and a photo of the airframe. The PDF **was read
  directly** — including reconstructing the flight-parameter table from text
  coordinates — which **verified** the specs, throttle/pitch curves, flight
  modes, stability modes, throttle-hold, binding, and connectors. The repository
  was then updated to convert those items from `TBD` to `[VERIFIED]`.
- **Still `TBD`:** items the manual does not cover for an **ELRS** build
  specifically (ELRS packet-rate/power tuning, ELRS failsafe method, and the
  Normal-mode governor % which did not render cleanly from the scan) remain
  `TBD – Verification Required`.
- **Nothing flight-critical was invented.** Verified values cite the official
  manual (source **A0**); anything still unconfirmed is labelled, not guessed.

## Model-name note

A retailer/product listing for a model literally named **"GooSky S1 V3 Pro"**
was **not** found during research. The GooSky S1 family that was found:

- **GooSky S1 / Legend S1** — original micro 3D heli (S-FHSS / DSMX RX).
- **GooSky S1 V2 / "S1 New Edition"** — adds an **ELRS interface** and the
  **GTS flight-control system** (BNF/RTF).

This package is built for the **ELRS / GTS-equipped GooSky S1** and uses the
name "GooSky S1 V3 Pro" as supplied by the user. **The exact version/revision
of the user's airframe and flight controller is an open verification item**
(see `research-summary.md`).

---

## A. Official GooSky sources

> **UPDATE — official manual obtained and read.** After the initial research
> pass, the user supplied the **official _GOOSKY S1 Instruction Manual_** (PDF,
> 31 pages) plus a photo of the actual purple airframe. The PDF was read directly
> (text extracted, including the flight-parameter table reconstructed from text
> coordinates). **This upgraded many `TBD` items to `[VERIFIED]`** — see source
> **A0** and `research-summary.md`.

| # | Source | URL / location | Used for |
|---|--------|----------------|----------|
| **A0** | **GOOSKY S1 Instruction Manual (official PDF, user-supplied)** | local upload `1b04f90c-c90f20.pdf` (ManualsLib-sourced GOOSKY S1 manual, ©2023 Guangdong Goosky) | **VERIFIED specs, flight-parameter table (throttle + pitch curves), flight modes (General/IDLE1/IDLE2), Pose/Manual stability, HOLD, binding, connectors (DSMX/S-BUS), T8 transmitter** |

| # | Source | URL | Used for |
|---|--------|-----|----------|
| A1 | GooSky official site – S1 download list | https://www.goo-sky.com/DownList/2.html | Locating official S1 manuals / user guides / setup files |
| A2 | GooSky official – S1 Manual | https://www.goo-sky.com/DownLoad/127302.html | Official S1 manual (could not be opened directly – 403) |
| A3 | GooSky official – S1 User Guide (Bilingual) | https://www.goo-sky.com/DownLoad/127303.html | Official bilingual user guide (not openable directly – 403) |
| A4 | GooSky official – S1 User Guide (Bilingual, mirror) | https://www.gooskyrc.com/DownLoad/127303.html | Mirror of A3 |
| A5 | GooSky official – Flight Control Setting | https://goo-sky.com/DownLoad/93257.html?a=download | GTS flight-control / stabilization setup reference |
| A6 | GooSky GTS flight-controller manual (ManualsLib mirror) | https://www.manualslib.com/manual/3170378/Goosky-Gts.html | GTS controller modes & channel behaviour |
| A7 | GooSky S1 instruction manual (ManualsLib mirror) | https://www.manualslib.com/manual/4143847/Goosky-S1.html | S1 assembly / specs / parameters |
| A8 | GooSky service & support | https://www.gooskyrc.com/Content/2117191.html | Support / firmware / app references |

## B. Official EdgeTX sources

| # | Source | URL | Used for |
|---|--------|-----|----------|
| B1 | EdgeTX User Manual – Model Setup | https://manual.edgetx.org/bw-radios/model-select/setup | Model name, timers, internal RF, telemetry |
| B2 | EdgeTX User Manual – Throttle | https://manual.edgetx.org/color-radios/model-settings/model-setup/throttle | Throttle source / warning / reverse behaviour |
| B3 | EdgeTX User Manual (root) | https://manual.edgetx.org/ | Mixes, curves, logical switches, special functions, Lua |

## C. Official ExpressLRS sources

| # | Source | URL | Used for |
|---|--------|-----|----------|
| C1 | ExpressLRS – Getting Started | https://www.expresslrs.org/quick-start/getting-started/ | Overview, workflow |
| C2 | ExpressLRS – Radio Preparation | https://www.expresslrs.org/quick-start/transmitters/tx-prep/ | Radio model / external module prep |
| C3 | ExpressLRS – Binding | https://www.expresslrs.org/quick-start/binding/ | Bind phrase vs button binding |
| C4 | ExpressLRS – The ELRS Lua Script | https://www.expresslrs.org/quick-start/transmitters/lua-howto/ | Packet rate / Telem ratio / TX power / model match |
| C5 | ExpressLRS – Switch Configs | https://www.expresslrs.org/software/switch-config/ | Hybrid/Wide/8ch full-res, channel resolution |
| C6 | ExpressLRS – Model Matching | https://www.expresslrs.org/software/model-config-match/ | Model match behaviour |
| C7 | ExpressLRS – User Defines | https://www.expresslrs.org/software/user-defines/ | Build options reference |
| C8 | ExpressLRS GitHub – SBUS output for helicopters (Issue #1190) | https://github.com/ExpressLRS/ExpressLRS/issues/1190 | SBUS-for-heli history |
| C9 | ExpressLRS v3.4.0 release | https://github.com/ExpressLRS/ExpressLRS/releases/tag/3.4.0 | Firmware feature reference |

## D. Official / vendor RadioMaster TX15 Max sources

| # | Source | URL | Used for |
|---|--------|-----|----------|
| D1 | RadioMaster TX15 Max V5.0 (Amazon listing, mfg specs) | https://www.amazon.com/RadioMaster-TX15-Gimbals-ExpressLRS-Transmitter/dp/B0FKGLDTNC | RF system, gimbals, firmware, screen, channels |
| D2 | RadioMaster TX15 Max (manuals.plus mirror of manual) | https://manuals.plus/asin/B0FMJVX69L | Dimensions, weight, features |
| D3 | RadioMaster TX15 Max Edition (AG02 gimbals listing) | https://www.amazon.com/RadioMaster-ExpressLRS-Gimbals-Touchscreen-Controller/dp/B0FWGVNFPT | Gimbal / touchscreen confirmation |

## E. Community & retailer references (NON-authoritative — used only to corroborate)

> These are **not** treated as flight-critical sources of truth. They are listed
> for transparency and to cross-check the official-source findings above.

| # | Source | URL | Used for |
|---|--------|-----|----------|
| E1 | New England RC – Goosky S1/S2 Binding, Setup & Factory Reset Guide | https://newenglandrc.us/pages/goosky-s1-s2-binding-factory-reset-guide | Binding / factory reset / channel corroboration |
| E2 | OriginHobbies – ELRS SBUS with OMPHobby/GooSky S1/S2 | https://originhobbies.com/expresslrs-sbus-with-omphobby-m1-m2-helicopter/ | SBUS protocol, 5-ch full-res requirement, CH5 arm/stability |
| E3 | Goosky S1 Radio Setup in EdgeTX (YouTube) | https://www.youtube.com/watch?v=DXHBSyQyhBQ | EdgeTX heli setup walkthrough |
| E4 | DeviationTX forum – Goosky S1 model config | https://www.deviationtx.com/forum/model-configs/9191-goosky-s1 | Channel order corroboration |
| E5 | Banggood – GOOSKY S1 New Edition (ELRS + GTS) | https://usa-m.banggood.com/GOOSKY-S1-New-Edition-...-p-2038601.html | Confirms ELRS interface + GTS, 6CH |
| E6 | HeliDirect / AMain / Pyrodrone S1 product pages | https://www.helidirect.com/ , https://www.amainhobbies.com/ , https://pyrodrone.com/ | Specs: rotor 290mm, weight 107g, 2S 300mAh, ~8 min |
| E7 | Oscar Liang – ExpressLRS 4.0 setup guide | https://oscarliang.com/setup-expresslrs-2-4ghz/ | ELRS workflow corroboration |
| E8 | UAVMODEL – ELRS packet rate & telemetry tuning (2026) | https://blog.uavmodel.com/expresslrs-packet-rate-and-telemetry-ratio-tuning-latency-vs-range-optimization-2026-guide/ | Packet rate vs switch-mode corroboration |
| E9 | Goosky S2 Flight Control Settings Guide (manuals.plus) | https://manuals.plus/m/806cc104251082236b9db6b9530cc6e65a4c4d8690c69b671e9443d4ea074cee | Throttle-curve example corroboration (S2 family) |

## Verification status legend (used throughout this repo)

- **Verified (official)** — confirmed from an official GooSky/EdgeTX/ExpressLRS/RadioMaster source.
- **Reported (community)** — consistent across community/retailer sources; **must be user-verified**.
- **TBD – Verification Required** — could not be confirmed; user must obtain from the
  official manual / GOOSKY app / their own unit before relying on it.
