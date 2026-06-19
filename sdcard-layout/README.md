# SD-Card Layout — GooSky S1 V2 package (RadioMaster TX15 Max / EdgeTX)

How to place the files from this repository onto the radio's SD card. This does
**not** replace your EdgeTX SD-card contents — you are **adding** a model, a
bitmap, a Lua tool, and (optionally) voice files into the existing EdgeTX folder
structure.

> Always back up your SD card before copying files. EdgeTX 3.0.0+ assumed.

## Where each file goes

| Repo file | Copy to (SD card) | Notes |
|-----------|-------------------|-------|
| `models/GOOSKY_S1_V2_ELRS.yml` | `/MODELS/modelNN.yml` | Authoritative model. Easiest path is to **import via EdgeTX Companion** instead of hand-placing. If placing manually, use the next free `modelNN.yml` and register it (see below). |
| `models/GOOSKY_S1_V2.otx` | *(not copied)* | Human-readable descriptor only — see the file's header. Use Companion to build a real binary if you want one. |
| `BITMAPS/GOOSKY.bmp` | `/BITMAPS/GOOSKY.bmp` | Model image (purple). |
| `lua/SCRIPTS/TOOLS/GooskyS1.lua` | `/SCRIPTS/TOOLS/GooskyS1.lua` | Appears under **SYS → Tools → GooSky S1**. |
| (voice files, optional) | `/SOUNDS/en/...` | See "Voice prompts" below. |

## Resulting tree (relevant parts)

```
SD CARD (EdgeTX)
├── MODELS/
│   ├── MODELS.TXT            <- registry of model files (if your build uses it)
│   └── modelNN.yml           <- GOOSKY_S1_V2_ELRS.yml goes here
├── BITMAPS/
│   └── GOOSKY.bmp
├── SCRIPTS/
│   └── TOOLS/
│       └── GooskyS1.lua
└── SOUNDS/
    └── en/
        ├── system/           <- EdgeTX default voice pack (numbers, words)
        └── (custom prompts: easy.wav, mild.wav, wild.wav, thrhold.wav, lowsignal.wav)
```

## Recommended install (Companion — fewest mistakes)

1. **EdgeTX Companion 2.10+** → open your radio profile.
2. **Models** → import `GOOSKY_S1_V2_ELRS.yml` into a free slot.
3. Review **every** page; resolve all `TBD – Verification Required` values from
   the official GooSky manual + GOOSKY app (see `/docs/`).
4. Copy `GOOSKY.bmp` to `/BITMAPS/` and `GooskyS1.lua` to `/SCRIPTS/TOOLS/`
   (Companion's SD-card tab, or a card reader).
5. **Write models & settings** to the radio.

## Manual install (no Companion)

1. Card reader → SD card.
2. `GOOSKY.bmp` → `/BITMAPS/`.
3. `GooskyS1.lua` → `/SCRIPTS/TOOLS/`.
4. `GOOSKY_S1_V2_ELRS.yml` → `/MODELS/` as the next `modelNN.yml`. If your
   EdgeTX build uses `/MODELS/MODELS.TXT` as a registry, add the new filename
   there (newer EdgeTX auto-discovers — check your version).
5. Eject, boot radio, select the model, review every page, resolve `TBD`s.

## Voice prompts — use EdgeTX's built-in voice tools (no custom WAVs bundled)

By design this package does **not** ship custom audio. Generate the few spoken
cues **on the radio with EdgeTX's own tools** (or EdgeTX Companion). EdgeTX's
**default voice pack already speaks all numbers and many words**, so the timer
call-out and most cues work out of the box.

The model's special functions reference these cues:

| Cue | When | How to provide it in EdgeTX |
|-----|------|------------------------------|
| Remaining flight time | SF → HOLD (and timer) | **Already covered** by the default voice pack (Play Value / number voices) — nothing to record |
| "Throttle hold" | SF → HOLD | Use the built-in word **`hold`** (or `thrhold.wav`) — see below |
| "Easy" / "Mild" / "Wild" | flight mode (SA) | Record/synthesize `easy.wav` / `mild.wav` / `wild.wav` |
| Link-quality warning | low RQly | Re-point to a built-in alert, or record `lowsignal.wav` |

### Make them on the radio (no PC needed)
1. **EdgeTX → SYS → Tools → (if present) Voice/Recorder**, or use a
   **Logical-Switch + Special Function → Play Track** and pick from the
   **System/voice pack** sounds already on the SD card.
2. To record your own: **Special Functions** can play any WAV you drop in
   `/SOUNDS/en/` — record a clip on the radio's mic (TX15 Max has a built-in mic)
   or generate one in Companion's sound tools, save as
   `easy.wav` / `mild.wav` / `wild.wav`, 16-bit PCM WAV.

### Or do nothing
A **missing WAV simply plays nothing** — no error, no safety impact. The radio
will still beep on switch changes. The flight-mode/throttle-hold call-outs are a
**nicety, not a flight-critical function.**

> Filenames/language depend on your installed voice pack. If you place files
> under a different name or `/SOUNDS/<lang>/`, point the model's Special
> Functions at the names you actually used (Model → Special Functions).

## After install — do not skip

Follow [`/docs/first-flight-guide.md`](../docs/first-flight-guide.md) and
[`/docs/safety-checklist.md`](../docs/safety-checklist.md). **Bench-test with
blades removed** and resolve every `TBD` before flight.
