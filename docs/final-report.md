# Final Validation Report — GooSky S1 V3 Pro EdgeTX Package

Generated at the end of the build. Summarizes what was created, the sources used,
what is verified, what remains open, and what **you must verify before flight**.

## 1. Files created

| # | File | Type | Status |
|---|------|------|--------|
| 1 | `README.md` | Docs | complete |
| 2 | `docs/goosky-s1-v3-pro-edgetx-profile.md` | Docs | complete (with TBDs flagged) |
| 3 | `docs/first-flight-guide.md` | Docs | complete |
| 4 | `docs/switch-table.md` | Docs | complete |
| 5 | `docs/channel-map.md` | Docs | complete (reverse/failsafe = TBD) |
| 6 | `docs/flight-modes.md` | Docs | complete (curve values = TBD) |
| 7 | `docs/safety-checklist.md` | Docs | complete |
| 8 | `docs/elrs-setup.md` | Docs | complete |
| 9 | `docs/troubleshooting.md` | Docs | complete |
| 10 | `docs/research-sources.md` | Research | complete |
| 11 | `docs/research-summary.md` | Research | complete |
| 12 | `models/GOOSKY_S1_V3_PRO.otx` | Model | human-readable descriptor (see file note) |
| 13 | `models/GOOSKY_S1_V3_PRO_ELRS.yml` | Model | importable template (TBD placeholders) |
| 14 | `lua/SCRIPTS/TOOLS/GooskyS1.lua` | Lua | complete, syntax-validated, read-only |
| 15 | `assets/goosky-s1-v3-pro-purple.md` | Asset docs | complete |
| 16 | `BITMAPS/GOOSKY.bmp` | Image | valid 24-bit BMP, 160×96, purple |
| 17 | `sdcard-layout/README.md` | Docs | complete |
| 18 | `docs/final-report.md` | Report | this file |

## 2. Validation performed

| Check | Method | Result |
|-------|--------|--------|
| Repository structure | all 17 deliverables present at required paths | ✅ pass |
| Lua syntax | `luac5.4 -p GooskyS1.lua` | ✅ pass |
| Lua safety property | manual review: no writes to channels/mixes/module/model; only `getValue`/`model.getTimer`/`lcd.*` | ✅ read-only |
| Model YAML well-formed | `yaml.safe_load` | ✅ parses |
| BMP validity | `file` → "PC bitmap, Windows 3.x, 160×96×24" | ✅ valid |
| Documentation cross-references | link-checker over all `*.md` | ✅ no broken internal links |
| Consistency (channel order/switches) | channel-map ↔ switch-table ↔ flight-modes ↔ model ↔ profile | ✅ consistent (AETR + CH5 + CH6; SF/SA/SB) |
| Assumptions labelled | every flight-critical value tagged `[VERIFIED]`/`[REPORTED]`/`TBD` | ✅ |

> **Important caveat:** "YAML parses" and "Lua compiles" do **not** mean the
> model will import byte-perfectly into EdgeTX Companion or that values are
> airworthy. The model is a **template**: review it in Companion 2.10+ and
> resolve all TBDs. A binary `.otx` could not be authored offline (see that
> file's header) — the `.yml` is authoritative.

## 3. Sources used (see `research-sources.md` for full list + URLs)

- **Official GOOSKY S1 Instruction Manual (PDF, user-supplied — source A0):**
  **read directly.** Provided VERIFIED specs, the flight-parameter table
  (throttle + pitch curves, p.21), flight modes (General/IDLE1/IDLE2),
  Pose/Manual stability (p.27), throttle-hold, binding, and FC connectors (p.18).
  A photo of the purple airframe was also supplied and matches.
- **Official GooSky (web):** S1 download/manual/user-guide pages, GTS flight-
  control setting page. *(Web pages were not directly fetchable — HTTP 403 — so
  Phase-1 findings came from search summaries; Phase 2 used the PDF above.)*
- **Official EdgeTX:** model-setup, throttle, and main manual.
- **Official ExpressLRS:** getting-started, binding, Lua-howto, switch-configs,
  model-matching, user-defines, SBUS-for-heli issue, v3.4.0 release.
- **Official/vendor RadioMaster:** TX15 Max V5.0 spec listings + manual mirror.
- **Community (corroboration only, non-authoritative):** New England RC setup
  guide, OriginHobbies ELRS-SBUS-heli guide, DeviationTX config thread, Banggood
  S1-New-Edition listing, HeliDirect/AMain/Pyrodrone spec pages, Oscar Liang &
  UAVMODEL ELRS guides, S2 flight-control settings (curve example).

## 4. Verified findings (`[VERIFIED]`)

**From the official manual (A0):**
- **Specs:** length 278 mm, height 88 mm, main blade 125 mm, **main rotor 290 mm**,
  tail rotor 53 mm, **≈107 g**, dual brushless, carbon fuselage, GTS, app-tuned,
  FBL firmware. **2S 300 mAh** LiPo.
- **Flight modes (p.21):** **General/Normal, IDLE 1, IDLE 2** → mapped to
  **Easy/Mild/Wild**.
- **Throttle (governor) %:** **IDLE 1 = 60%**, **IDLE 2 = 70%** (flat).
- **Collective pitch (degrees):** General `+11.5/+5.5/+1.8/-0.6/-2.4`,
  IDLE 1 & IDLE 2 `+11.5/+5.5/0/-5.5/-11.5` (±11.5).
- **Stability (p.27):** **Pose mode** (self-level) ↔ **Manual mode** (3D) +
  **HOLD** (throttle hold).
- **Binding (p.21):** GOOSKY T8 = BIND ×3; Futaba = S-FHSS long-press.
- **FC connectors (p.18):** S-BUS / DSMX / BIND / Data → confirms SBUS input and
  that the **FBL FC mixes the swash** → EdgeTX Swash = NONE.

**From official EdgeTX/ExpressLRS/RadioMaster:**
- TX15 Max: **EdgeTX 3.0.0+**, **internal ELRS 2.4 GHz**, AG02 Hall gimbals,
  3.5″ IPS, 16 ch. ELRS Lua at **SYS → Tools → ExpressLRS**.
- Heli needs **≥5 full-res channels** → **8ch full-res**, **max 333 Hz**.
- RX → **SBUS** (ELRS ≥ v3.3.0); **Bind Phrase** + **Model Match**;
  **RSSI/RQly/TPWR/RSNR** telemetry.

## 5. Reported findings (`[REPORTED]` — corroborated, still verify)

- **Channel order AETR** with **CH5 = Stability** and **CH6 = Collective**
  (consistent with the manual's CH1/CH2/CH3 + SBUS layout and stock-radio mixing).
- Flight time **≈8 min** (community figure; verify on your pack).

## 6. Open questions / **required user verification** (`TBD`)

1. **Exact airframe/FC revision** — the manual is titled "GOOSKY S1"; confirm the
   user's "V3 Pro" maps to it.
2. **Channel reversing** (esp. **CH2 elevator**, **CH3 throttle**) — bench-verify.
3. **CH5 endpoint values** for Pose vs Manual.
4. **Rescue / bail-out** function — existence, channel, behaviour.
5. **Normal-mode governor %** (scan-unreadable) + confirm GTS app **pitch-range
   (±°)** with a gauge (EdgeTX % assume ±11.5°).
6. **ELRS failsafe** method (target **motor-off**) — bench-test.
7. **Timer T1 alarm** — from *your* metered safe pack time, not the generic 8-min.
8. **ELRS packet rate / Telem ratio / TX power** for your environment/regulations.

## 7. Bottom line

The package is **structurally complete, internally consistent, syntax-valid, and
honestly scoped**, and its core flight-critical curves are now **verified against
the official GOOSKY S1 manual** (throttle %, pitch degrees, modes, stability,
binding). It does **not** invent settings: the remaining unconfirmable items
(ELRS failsafe/power tuning, Normal governor %, app pitch-range, timer) stay
marked **`TBD – Verification Required`**. **Resolve those, confirm values in the
GOOSKY app, and bench-test with blades removed before flight.** If a TBD is
unresolved at the field — **do not fly.**
