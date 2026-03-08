# TerraStudio Development History

Visual timeline of TerraStudio's development from first commit to v0.39.0 (Feb 19 – Mar 8, 2026).

## Structure

```
screenshots/
  input/       # Raw screenshots from each version
  output/      # Processed: resized + version header overlay
video/
  terrastudio-dev-history.mp4   # 4:54 slideshow with progress bar
scripts/
  process-screenshots.ps1       # Resize + add headers to screenshots
  make-video.py                 # Generate video from processed screenshots
mapping.md                      # Version → commit → summary mapping
```

## Usage

### 1. Process screenshots (resize + add headers)

```powershell
.\scripts\process-screenshots.ps1
```

Reads PNGs from `screenshots/input/`, normalizes to 2461×1570, adds a black header with version/date/summary, and writes to `screenshots/output/`.

### 2. Generate video

```bash
python scripts/make-video.py
```

Reads processed PNGs from `screenshots/output/`, generates an MP4 with 7s per image and a blue progress bar at the bottom. Outputs to `video/`.

### Requirements

- Python 3.10+ with `Pillow` and `numpy`
- `ffmpeg` in PATH
- PowerShell 5.1+ (for the screenshot processing script)
