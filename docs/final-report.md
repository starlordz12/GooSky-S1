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

- **Official GooSky:** S1 download/manual/user-guide pages, GTS flight-control
  setting page, GTS & S1 manual mirrors. *(Pages could not be opened directly —
  all fetches returned HTTP 403; findings are from search-result summaries.)*
- **Official EdgeTX:** model-setup, throttle, and main manual.
- **Official ExpressLRS:** getting-started, binding, Lua-howto, switch-configs,
  model-matching, user-defines, SBUS-for-heli issue, v3.4.0 release.
- **Official/vendor RadioMaster:** TX15 Max V5.0 spec listings + manual mirror.
- **Community (corroboration only, non-authoritative):** New England RC setup
  guide, OriginHobbies ELRS-SBUS-heli guide, DeviationTX config thread, Banggood
  S1-New-Edition listing, HeliDirect/AMain/Pyrodrone spec pages, Oscar Liang &
  UAVMODEL ELRS guides, S2 flight-control settings (curve example).

## 4. Verified findings (`[VERIFIED]`)

- TX15 Max runs **EdgeTX 3.0.0+**, **internal ELRS 2.4 GHz**, AG02 Hall gimbals,
  3.5″ IPS, up to 16 ch. ELRS Lua at **SYS → Tools → ExpressLRS**.
- Helicopters need **≥5 full-resolution channels**; Hybrid/Wide give only 4 →
  use **8ch full-resolution**, whose **max packet rate is 333 Hz**.
- ELRS RX must be set to **SBUS** (≥ v3.3.0) for the GTS; power-cycle after.
- Binding via **Bind Phrase** (or button); **Model Match** available in ELRS Lua.
- ELRS exposes **RSSI/RQly/TPWR/RSNR** telemetry to EdgeTX.
- **Flybarless principle:** the GTS mixes its own swash → **EdgeTX Swash = NONE**.

## 5. Reported findings (`[REPORTED]` — corroborated, still verify)

- **Channel order AETR** with **CH5 = Stability/POSE** and **CH6 = Collective**.
- GTS exposes **two stabilization states** (Self-level / 3D) on **CH5**, tuned in
  the **GOOSKY app**.
- S1 physical/power figures: rotor **290 mm**, weight **≈107 g**, **2S 300 mAh**,
  flight time **≈8 min** (original S1).
- Community **example** throttle curves (S1/S2 family): `0-40-60-60-60`,
  `65×5`, `75×5`.

## 6. Open questions / **required user verification** (`TBD`)

1. **Exact airframe/FC revision** — is "S1 V3 Pro" the S1 V2 / New Edition / a
   later rev? No retailer listing for that literal name was found.
2. **Channel reversing** (esp. **CH2 elevator**, **CH3 throttle**) — bench-verify.
3. **CH5 values** for Self-level vs 3D, and whether a **mid band** exists (affects
   "Mild").
4. **Rescue / panic** function — existence, channel, behaviour.
5. **Official throttle curve + governor / head-speed RPM** target.
6. **Official collective pitch curve + pitch range (±°)** — measure with a gauge.
7. **Official failsafe** configuration (target **motor-off**) — bench-test.
8. **Timer T1 alarm** — set from *your* metered safe pack time, not the generic
   8-minute figure.
9. **ELRS packet rate / Telem ratio / TX power** for your environment/regulations.

## 7. Bottom line

The package is **structurally complete, internally consistent, syntax-valid, and
honestly scoped**. It does **not** invent flight-critical settings: anything not
confirmable from available sources is marked **`TBD – Verification Required`**.
**Resolve every TBD from official GooSky documentation + the GOOSKY app and
bench-test with blades removed before flight.** If a TBD is unresolved at the
field — **do not fly.**
