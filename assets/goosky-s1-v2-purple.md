# GooSky S1 V2 — Purple Image Asset

Describes the bundled model bitmap for the purple GooSky S1.

## File

- **Path:** [`/BITMAPS/GOOSKY.bmp`](../BITMAPS/GOOSKY.bmp)
- **Format:** Windows BMP, 24-bit, **160 × 96 px**
- **Theme:** GooSky **purple** — deep-violet → purple vertical gradient with a
  lavender diagonal highlight sweep and a dark frame.
- **Referenced by:** the EdgeTX model (`header.bitmap: "GOOSKY.bmp"`).

## Why this image (honest note)

This is a **generated, license-clean placeholder** in the GooSky purple colour
family. It is **not** an official GooSky product photo — to avoid shipping
copyrighted marketing imagery into the repository. It is intentionally simple so
it renders cleanly on the TX15 Max model-select/home screen.

## Using it on the RadioMaster TX15 Max

1. Copy `GOOSKY.bmp` to the radio SD card under **`/BITMAPS/`** (see
   [`/sdcard-layout/README.md`](../sdcard-layout/README.md)).
2. In the model: **Model Setup → Image → GOOSKY.bmp**.

> EdgeTX color radios accept BMP/PNG/JPG and rescale to fit. The TX15 Max has a
> 480×320 IPS screen; the model thumbnail area is small, so 160×96 is ample. If
> you prefer a larger splash, replace the file with up to ~192×114 and keep the
> same filename.

## Replacing with your own photo

Drop in any BMP/PNG/JPG named `GOOSKY.bmp` (or update `header.bitmap` in the
model). Keep it modest in size for fast loading. If you use a real photo of your
own purple S1, that's ideal — it's yours to use.

## Regenerating this placeholder

The bitmap was produced by a small raw-BMP writer (no external image libraries).
Palette used (R,G,B): deep `#4A146E`, purple `#7C3AAD`, lavender `#AB78DB`,
frame `#280C40`.
