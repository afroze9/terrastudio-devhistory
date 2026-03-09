#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Reads git history and appends commit data to docs/timeline.md as a markdown table.
.DESCRIPTION
    Extracts commits matching conventional commit types (feat, fix, chore, docs, refactor, test, merge, ci),
    parses their hash, datetime, type, and message, then appends them to the timeline markdown file.
    Skips commits already present in the file (by hash).
.PARAMETER BatchSize
    Number of commits per table batch. Default: 20.
#>
param(
    [int]$BatchSize = 20
)

$RepoRoot = git rev-parse --show-toplevel
$TimelineFile = Join-Path $RepoRoot "docs/timeline.md"

if (-not (Test-Path $TimelineFile)) {
    Write-Error "Timeline file not found: $TimelineFile"
    exit 1
}

# Read existing file to find already-recorded hashes
$existingContent = Get-Content $TimelineFile -Raw
$existingHashes = [System.Collections.Generic.HashSet[string]]::new()
# Match 7-char hashes in table rows: | # | hash | ...
[regex]::Matches($existingContent, '\|\s*\d+\s*\|\s*([0-9a-f]{7})\s*\|') | ForEach-Object {
    $existingHashes.Add($_.Groups[1].Value) | Out-Null
}

# Find the highest commit number already in the file
$maxNum = 0
[regex]::Matches($existingContent, '\|\s*(\d+)\s*\|') | ForEach-Object {
    $n = [int]$_.Groups[1].Value
    if ($n -gt $maxNum) { $maxNum = $n }
}

Write-Host "Found $($existingHashes.Count) existing commits (up to #$maxNum)"

# Commit type pattern
$typePattern = '^(feat|fix|chore|docs|refactor|test|merge|ci)(\(.+?\))?:\s*'

# Get all commits oldest-first: hash, ISO datetime, subject
$logLines = git log --reverse --format="%h|%aI|%s" | Where-Object { $_ -match '\|' }

$newCommits = @()
$commitNum = 0

foreach ($line in $logLines) {
    $parts = $line -split '\|', 3
    $hash = $parts[0]
    $datetime = $parts[1]
    $subject = $parts[2]

    # Only include conventional commit types
    if ($subject -notmatch $typePattern) { continue }

    $commitNum++

    # Skip if already recorded
    if ($existingHashes.Contains($hash)) { continue }

    $type = $Matches[1]
    # Clean message: remove the type prefix
    $message = ($subject -replace $typePattern, '').Trim()

    # Extract version if present (vX.Y.Z)
    $version = '-'
    if ($message -match '\(v(\d+\.\d+\.\d+)\)') {
        $version = $Matches[1]
    }

    # Truncate datetime to minute
    $dt = $datetime -replace ':\d{2}[+-]\d{2}:\d{2}$', ''
    # Also handle Z timezone
    $dt = $dt -replace ':\d{2}Z$', ''

    $newCommits += [PSCustomObject]@{
        Num      = $commitNum
        Hash     = $hash
        DateTime = $dt
        Type     = $type
        Message  = $message
        Version  = $version
    }
}

if ($newCommits.Count -eq 0) {
    Write-Host "No new commits to add."
    exit 0
}

Write-Host "Adding $($newCommits.Count) new commits (#$($newCommits[0].Num) to #$($newCommits[-1].Num))"

# Build rows to append (single flat table, no batch headers)
$sb = [System.Text.StringBuilder]::new()

foreach ($c in $newCommits) {
    $sb.AppendLine("| $($c.Num) | $($c.Hash) | $($c.DateTime) | $($c.Type) | $($c.Message) | $($c.Version) |") | Out-Null
}

# Read existing file, strip trailing blank lines, append new rows before final newline
$content = (Get-Content $TimelineFile -Raw).TrimEnd()
$content + "`n" + $sb.ToString().TrimEnd() + "`n" | Set-Content $TimelineFile -NoNewline -Encoding UTF8

Write-Host "Done. Timeline updated: $TimelineFile"
