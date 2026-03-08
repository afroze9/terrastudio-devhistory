<#
.SYNOPSIS
    Process TerraStudio screenshots: resize to uniform dimensions, add version header overlay.

.DESCRIPTION
    1. Resize all PNGs to 2461x1570 (the most common dimension).
    2. Add a 120px black header above each image showing version, date, and summary.
    3. For versions without a screenshot, their summaries accumulate into the next version that has one.
    4. Outputs go to screenshots/output/.

.PARAMETER HeaderHeight
    Height of the header band in pixels (default 120).

.EXAMPLE
    .\process-screenshots.ps1
#>

param(
    [int]$HeaderHeight = 120
)

$ErrorActionPreference = "Stop"

# Resolve paths relative to this script's location (scripts/ -> repo root)
$ScriptDir = $PSScriptRoot
$RepoRoot = Split-Path -Parent $ScriptDir
$ScreenshotsDir = Join-Path $RepoRoot "screenshots\input"
$OutputDir = Join-Path $RepoRoot "screenshots\output"

# --- Version data: version, commit, date string, one-liner summary ---
$VersionData = @(
    @{ Version = "0.0.1"; Date = "Feb 19"; Summary = "First runnable app + Tauri CLI fix" }
    @{ Version = "0.0.2"; Date = "Feb 20"; Summary = "Container nodes, compute plugin" }
    @{ Version = "0.0.3"; Date = "Feb 20"; Summary = "Project system, terraform execution" }
    @{ Version = "0.0.4"; Date = "Feb 20"; Summary = "Export, undo/redo, validation" }
    @{ Version = "0.0.5"; Date = "Feb 20"; Summary = "Frameless UI, palette, tooltips" }
    @{ Version = "0.0.6"; Date = "Feb 20"; Summary = "Output bindings, acceptsOutputs" }
    @{ Version = "0.0.7"; Date = "Feb 20"; Summary = "Subscription, variables, tfvars" }
    @{ Version = "0.0.8"; Date = "Feb 20"; Summary = "Auto-CIDR, overlap detection" }
    @{ Version = "0.1.0"; Date = "Feb 20"; Summary = "Dark/light mode, 8 palettes, SVG export" }
    @{ Version = "0.1.1"; Date = "Feb 21"; Summary = "Storage resources, snap-to-grid, Azure icons" }
    @{ Version = "0.2.0"; Date = "Feb 21"; Summary = "12 new Azure resources across 3 plugins" }
    @{ Version = "0.2.1"; Date = "Feb 22"; Summary = "Project templates, auto-regenerate, RG containment" }
    @{ Version = "0.2.2"; Date = "Feb 23"; Summary = "Naming conventions, wizard" }
    @{ Version = "0.3.0"; Date = "Feb 24"; Summary = "Subscription Picker & UI Polish" }
    @{ Version = "0.3.4"; Date = "Feb 24"; Summary = "Shortcuts, QoL, Templates" }
    @{ Version = "0.4.0"; Date = "Feb 26"; Summary = "Edge Styling & New Resources" }
    @{ Version = "0.4.3"; Date = "Feb 26"; Summary = "Edge Refinements" }
    @{ Version = "0.5.0"; Date = "Feb 26"; Summary = "Cost Estimation" }
    @{ Version = "0.6.0"; Date = "Feb 27"; Summary = "MCP Server" }
    @{ Version = "0.7.0"; Date = "Feb 27"; Summary = "Structured Logging" }
    @{ Version = "0.8.0"; Date = "Feb 27"; Summary = "Canvas Layout Tools" }
    @{ Version = "0.9.0"; Date = "Feb 28"; Summary = "File Association" }
    @{ Version = "0.10.0"; Date = "Feb 28"; Summary = "Multi-Window" }
    @{ Version = "0.11.0"; Date = "Feb 28"; Summary = "MCP Multi-Window" }
    @{ Version = "0.12.0"; Date = "Feb 28"; Summary = "Security & UX" }
    @{ Version = "0.13.0"; Date = "Feb 28"; Summary = "MCP Enhancements" }
    @{ Version = "0.14.0"; Date = "Mar 1"; Summary = "Terraform Modules" }
    @{ Version = "0.15.0"; Date = "Mar 1"; Summary = "Module Templates" }
    @{ Version = "0.16.0"; Date = "Mar 3"; Summary = "Universal Variable Toggle" }
    @{ Version = "0.17.0"; Date = "Mar 5"; Summary = "13 New Azure Resources" }
    @{ Version = "0.18.0"; Date = "Mar 5"; Summary = "Visual Subnet & PEP" }
    @{ Version = "0.19.0"; Date = "Mar 5"; Summary = "Compact Node View" }
    @{ Version = "0.20.0"; Date = "Mar 6"; Summary = "7 New Azure Resources" }
    @{ Version = "0.21.0"; Date = "Mar 6"; Summary = "AWS Plugin" }
    @{ Version = "0.22.0"; Date = "Mar 6"; Summary = "Cost Estimation Coverage" }
    @{ Version = "0.23.0"; Date = "Mar 6"; Summary = "8 New AWS Resources" }
    @{ Version = "0.24.0"; Date = "Mar 6"; Summary = "6 More AWS Resources" }
    @{ Version = "0.25.0"; Date = "Mar 6"; Summary = "AWS Containers" }
    @{ Version = "0.26.0"; Date = "Mar 7"; Summary = "Canvas Search" }
    @{ Version = "0.27.0"; Date = "Mar 7"; Summary = "Connection Wizard" }
    @{ Version = "0.28.0"; Date = "Mar 7"; Summary = "Internationalization" }
    @{ Version = "0.29.0"; Date = "Mar 7"; Summary = "Validation Dashboard" }
    @{ Version = "0.30.0"; Date = "Mar 8"; Summary = "High Contrast & Themes" }
    @{ Version = "0.31.0"; Date = "Mar 8"; Summary = "Status Indicators" }
    @{ Version = "0.32.0"; Date = "Mar 8"; Summary = "Accessibility" }
    @{ Version = "0.33.0"; Date = "Mar 8"; Summary = "Dependency Graph" }
    @{ Version = "0.34.0"; Date = "Mar 8"; Summary = "Sticky Notes" }
    @{ Version = "0.35.0"; Date = "Mar 8"; Summary = "Smart Duplication" }
    @{ Version = "0.36.0"; Date = "Mar 8"; Summary = "Terraform Plan Visualization" }
    @{ Version = "0.37.0"; Date = "Mar 8"; Summary = "Cost Breakdown" }
    @{ Version = "0.38.0"; Date = "Mar 8"; Summary = "Connection UX" }
    @{ Version = "0.39.0"; Date = "Mar 8"; Summary = "Multi-Subscription & New Resources" }
)

# --- Target dimensions ---
$TargetWidth = 2461
$TargetHeight = 1570

# --- Build set of existing screenshots ---
$existingFiles = @{}
Get-ChildItem -Path $ScreenshotsDir -Filter "*.png" | ForEach-Object {
    $ver = $_.BaseName
    $existingFiles[$ver] = $_.FullName
}

# --- Build output list: accumulate summaries for versions without screenshots ---
$pendingSummaries = @()
$outputEntries = @()

foreach ($vd in $VersionData) {
    $ver = $vd.Version
    $pendingSummaries += $vd.Summary

    if ($existingFiles.ContainsKey($ver)) {
        # This version has a screenshot — flush accumulated summaries
        $combinedSummary = $pendingSummaries -join " | "
        # Determine the date range if summaries were accumulated
        $outputEntries += @{
            Version  = $ver
            Date     = $vd.Date
            Summary  = $combinedSummary
            FilePath = $existingFiles[$ver]
        }
        $pendingSummaries = @()
    }
}

# If there are trailing versions with no screenshot, warn
if ($pendingSummaries.Count -gt 0) {
    Write-Host "Warning: These summaries have no screenshot and were not accumulated:" -ForegroundColor Yellow
    $pendingSummaries | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
}

# --- Create output directory ---
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

Write-Host "`nProcessing $($outputEntries.Count) screenshots...`n" -ForegroundColor Cyan

# --- Generate Python script for image processing ---
$pythonScript = @"
import sys, os
from PIL import Image, ImageDraw, ImageFont

TARGET_W = $TargetWidth
TARGET_H = $TargetHeight
HEADER_H = $HeaderHeight
OUTPUT_DIR = r"$OutputDir"

# Try to find a good font
def get_font(size):
    font_paths = [
        r"C:\Windows\Fonts\segoeui.ttf",
        r"C:\Windows\Fonts\arial.ttf",
        r"C:\Windows\Fonts\calibri.ttf",
    ]
    for fp in font_paths:
        if os.path.exists(fp):
            return ImageFont.truetype(fp, size)
    return ImageFont.load_default()

def get_bold_font(size):
    font_paths = [
        r"C:\Windows\Fonts\segoeuib.ttf",
        r"C:\Windows\Fonts\arialbd.ttf",
        r"C:\Windows\Fonts\calibrib.ttf",
    ]
    for fp in font_paths:
        if os.path.exists(fp):
            return ImageFont.truetype(fp, size)
    return get_font(size)

font_version = get_bold_font(42)
font_summary = get_font(30)
font_date = get_font(28)

entries = [
"@

$counter = 1
foreach ($entry in $outputEntries) {
    $ver = $entry.Version
    $date = $entry.Date
    $summary = $entry.Summary -replace '"', '\"' -replace "'", "\'"
    $filePath = $entry.FilePath -replace '\\', '/'
    $seqNum = "{0:D2}" -f $counter
    $pythonScript += "    (`"$filePath`", `"$ver`", `"$date`", `"$summary`", `"$seqNum`"),`n"
    $counter++
}

$pythonScript += @"
]

for filepath, version, date, summary, seq_num in entries:
    print(f"  [{seq_num}] v{version} ({date}) - {summary[:60]}...")

    # Open and resize to target (fit inside, pad with black — never crop)
    img = Image.open(filepath)
    if img.size != (TARGET_W, TARGET_H):
        img_ratio = img.width / img.height
        target_ratio = TARGET_W / TARGET_H
        if img_ratio > target_ratio:
            # Image is wider — fit width, pad top/bottom
            new_w = TARGET_W
            new_h = int(TARGET_W / img_ratio)
        else:
            # Image is taller — fit height, pad left/right
            new_h = TARGET_H
            new_w = int(TARGET_H * img_ratio)
        img = img.resize((new_w, new_h), Image.LANCZOS)
        # Center on black background
        padded = Image.new("RGB", (TARGET_W, TARGET_H), (0, 0, 0))
        paste_x = (TARGET_W - new_w) // 2
        paste_y = (TARGET_H - new_h) // 2
        padded.paste(img, (paste_x, paste_y))
        img = padded

    # Create new image with header
    total_h = TARGET_H + HEADER_H
    canvas = Image.new("RGB", (TARGET_W, total_h), (0, 0, 0))

    # Draw header text
    draw = ImageDraw.Draw(canvas)

    # Version label (left side, bold)
    version_text = f"v{version}"
    draw.text((30, 18), version_text, fill=(255, 255, 255), font=font_version)

    # Date (right of version)
    vbox = draw.textbbox((0, 0), version_text, font=font_version)
    vw = vbox[2] - vbox[0]
    date_x = 30 + vw + 24
    draw.text((date_x, 26), date, fill=(160, 160, 160), font=font_date)

    # Summary (second line, slightly dimmer)
    # Truncate if too long to fit
    max_summary_w = TARGET_W - 60
    truncated = summary
    while True:
        sbox = draw.textbbox((0, 0), truncated, font=font_summary)
        if sbox[2] - sbox[0] <= max_summary_w or len(truncated) < 10:
            break
        truncated = truncated[:len(truncated)-4] + "..."
    draw.text((30, 68), truncated, fill=(200, 200, 200), font=font_summary)

    # Paste screenshot below header
    canvas.paste(img, (0, HEADER_H))

    # Save
    out_path = os.path.join(OUTPUT_DIR, f"{seq_num}_{version}.png")
    canvas.save(out_path, "PNG")

print(f"\nDone! {len(entries)} images saved to {OUTPUT_DIR}")
"@

# --- Run the Python script ---
$tempPy = Join-Path $env:TEMP "ts_process_screenshots.py"
$pythonScript | Out-File -FilePath $tempPy -Encoding utf8

Write-Host "Screenshots to process:" -ForegroundColor Green
python $tempPy

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Python script failed" -ForegroundColor Red
    exit 1
}

# Cleanup
Remove-Item $tempPy -ErrorAction SilentlyContinue

Write-Host "`nAll done! Output in: $OutputDir" -ForegroundColor Green
