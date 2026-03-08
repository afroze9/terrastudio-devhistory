"""
Generate a TerraStudio dev history video from processed screenshots.
Each image displays for 7 seconds with a progress bar at the bottom edge
that fills left-to-right, then resets for the next image.

Usage: python scripts/make-video.py  (run from repo root)
Requires: Pillow, numpy, ffmpeg in PATH
"""

import os
import subprocess
import sys
import numpy as np
from PIL import Image, ImageDraw

# Resolve paths relative to this script's location (scripts/ -> repo root)
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.dirname(SCRIPT_DIR)

INPUT_DIR = os.path.join(REPO_ROOT, "screenshots", "output")
OUTPUT_PATH = os.path.join(REPO_ROOT, "video", "terrastudio-dev-history.mp4")

FPS = 30
DURATION_SEC = 7
FRAMES_PER_IMAGE = FPS * DURATION_SEC

# Progress bar config
BAR_HEIGHT = 6
BAR_COLOR = (59, 130, 246)      # Blue (#3B82F6)
BAR_BG_COLOR = (40, 40, 40)     # Dark grey track

def main():
    files = sorted([f for f in os.listdir(INPUT_DIR) if f.endswith(".png")])
    if not files:
        print("No images found in", INPUT_DIR)
        sys.exit(1)

    # Read first image to get dimensions
    sample = Image.open(os.path.join(INPUT_DIR, files[0]))
    width, height = sample.size
    # h264 needs even dimensions
    enc_w = width if width % 2 == 0 else width - 1
    enc_h = height if height % 2 == 0 else height - 1

    total_frames = len(files) * FRAMES_PER_IMAGE
    total_secs = len(files) * DURATION_SEC
    print(f"Images: {len(files)}, FPS: {FPS}, Duration: {total_secs}s ({total_secs // 60}m {total_secs % 60}s)")
    print(f"Frame size: {enc_w}x{enc_h}, Total frames: {total_frames}")
    print()

    # Ensure output directory exists
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)

    # Launch ffmpeg, pipe raw RGB frames to stdin
    ffmpeg_cmd = [
        "ffmpeg", "-y",
        "-f", "rawvideo",
        "-vcodec", "rawvideo",
        "-pix_fmt", "rgb24",
        "-s", f"{enc_w}x{enc_h}",
        "-r", str(FPS),
        "-i", "-",
        "-c:v", "libx264",
        "-pix_fmt", "yuv420p",
        "-preset", "medium",
        "-crf", "18",
        OUTPUT_PATH
    ]

    proc = subprocess.Popen(ffmpeg_cmd, stdin=subprocess.PIPE, stderr=subprocess.PIPE)

    for img_idx, filename in enumerate(files):
        label = filename.replace(".png", "")
        print(f"  [{img_idx + 1:02d}/{len(files)}] {label}")

        img = Image.open(os.path.join(INPUT_DIR, filename)).convert("RGB")
        # Crop to even dimensions if needed
        if img.size != (enc_w, enc_h):
            img = img.crop((0, 0, enc_w, enc_h))

        base_arr = np.array(img)

        # Bar y position: bottom edge of the image
        bar_y_start = enc_h - BAR_HEIGHT

        for frame_idx in range(FRAMES_PER_IMAGE):
            frame = base_arr.copy()

            # Draw background track
            frame[bar_y_start:enc_h, :] = BAR_BG_COLOR

            # Draw filled portion
            progress = (frame_idx + 1) / FRAMES_PER_IMAGE
            fill_w = int(enc_w * progress)
            if fill_w > 0:
                frame[bar_y_start:enc_h, :fill_w] = BAR_COLOR

            proc.stdin.write(frame.tobytes())

    proc.stdin.close()
    stderr = proc.stderr.read().decode()
    proc.wait()

    if proc.returncode != 0:
        print("ffmpeg error:", stderr[-500:])
        sys.exit(1)

    size_mb = os.path.getsize(OUTPUT_PATH) / (1024 * 1024)
    print(f"\nDone! {OUTPUT_PATH} ({size_mb:.1f} MB)")


if __name__ == "__main__":
    main()
