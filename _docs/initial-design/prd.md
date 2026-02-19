# dfree -- Safe Disk Cleanup & Recovery CLI

## 1. Overview

**dfree** is a cross-platform, interactive CLI tool designed to:

-   Analyze disk usage
-   Detect safely cleanable system and software caches
-   Identify Docker storage bloat
-   Detect MySQL binary logs
-   Execute safe cleanup commands
-   Measure and display reclaimed disk space
-   Provide progress tracking and a final recovery report

The tool is intended for developers and server administrators managing
Docker-heavy and database-backed environments.

------------------------------------------------------------------------

## 2. Problem Statement

Modern systems accumulate disk usage from:

-   Docker images, containers, and volumes
-   npm, yarn, pip, composer caches
-   apt and Homebrew caches
-   System logs
-   MySQL binary logs
-   Temporary files

Manual cleanup is repetitive, risky, and does not provide structured
statistics or tracking.

------------------------------------------------------------------------

## 3. Goals

### Primary Goals

-   Show color-coded disk usage
-   Detect safely deletable data
-   Offer interactive cleanup
-   Measure reclaimed space per operation
-   Display cumulative progress
-   Generate a final summary report
-   Install via `./install.sh`
-   Require no external dependencies

### Secondary Goals

-   Modular architecture
-   OS detection (Linux/macOS)
-   MySQL binlog awareness
-   Docker awareness
-   Interrupt-safe execution
-   Simulation mode

------------------------------------------------------------------------

## 4. Non-Goals

-   No automatic deletion without confirmation
-   No raw `rm -rf` on arbitrary paths
-   No recursive scanning of `/`
-   No GUI
-   No background daemon

Restricted paths that must never be scanned:

-   `/`
-   `/bin`
-   `/usr`
-   `/etc`
-   `/boot`
-   `/System`

------------------------------------------------------------------------

## 5. Installation

``` bash
git clone https://github.com/<user>/dfree
cd dfree
./install.sh
```

Installs:

    /usr/local/bin/dfree

------------------------------------------------------------------------

## 6. Usage

``` bash
dfree
```

Optional flags:

``` bash
dfree --simulate
dfree --safe
dfree --watch
```

------------------------------------------------------------------------

## 7. Functional Requirements

### 7.1 Disk Usage Overview

-   Display disk usage using `df`
-   Show total, used, and available space
-   Color-code usage:

  Usage %   Color
  --------- --------
  0--50%    Green
  50--75%   Yellow
  75%+      Red

------------------------------------------------------------------------

### 7.2 Safe Cache & Directory Detection

Detect and calculate size of:

#### Linux

-   `/var/lib/docker`
-   `/var/cache/apt`
-   `/var/log`
-   `~/.npm`
-   `~/.cache`
-   `~/.local/share/Trash`

#### macOS

-   `~/Library/Caches`
-   `~/Library/Logs`
-   `~/.npm`
-   `~/.Trash`
-   Homebrew cache
-   Docker storage

Use official cleanup commands only.

------------------------------------------------------------------------

### 7.3 Docker Storage Analysis

-   Run `docker system df`
-   Detect reclaimable space
-   Offer:

``` bash
docker system prune -f
docker volume prune -f
```

------------------------------------------------------------------------

### 7.4 MySQL Binary Log Detection

-   Detect MySQL installation
-   Locate binary log directory
-   Calculate total binlog size
-   Use SQL purge command:

``` sql
PURGE BINARY LOGS BEFORE NOW() - INTERVAL X DAY;
```

Never delete binlogs manually.

------------------------------------------------------------------------

### 7.5 Interactive Cleanup Flow

For each cleanup action:

1.  Show description
2.  Show estimated reclaimable size
3.  Ask for confirmation
4.  Execute cleanup command
5.  Measure reclaimed space
6.  Update cumulative statistics

------------------------------------------------------------------------

### 7.6 Cleanup Measurement & Statistics

Measurement method:

``` bash
df -B1 /
```

Reclaimed calculation:

    reclaimed = used_before - used_after

------------------------------------------------------------------------

### 7.7 Progress Display

Show:

-   Step counter (e.g., 2/5)
-   Reclaimed space per step
-   Cumulative reclaimed space
-   Progress bar

------------------------------------------------------------------------

### 7.8 Final Report

Display:

-   Initial used space
-   Final used space
-   Total reclaimed
-   Updated disk usage percentage

------------------------------------------------------------------------

### 7.9 Interrupt Handling

-   Trap `SIGINT`
-   Exit safely
-   Display reclaimed space so far

------------------------------------------------------------------------

### 7.10 Simulation Mode

`dfree --simulate`

-   Show what would be cleaned
-   Estimate recoverable space
-   Do not execute commands

------------------------------------------------------------------------

## 8. Safety Requirements

-   Never use `rm -rf` on system directories
-   Only use official cleanup commands
-   Validate command existence before execution
-   Require explicit confirmation
-   Handle permission errors gracefully

------------------------------------------------------------------------

## 9. Technical Architecture

### Language

-   Bash (POSIX compliant)

### Repository Structure

    dfree/
    ├── install.sh
    ├── uninstall.sh
    ├── bin/dfree
    ├── lib/
    │   ├── colors.sh
    │   ├── disk.sh
    │   ├── scanner.sh
    │   ├── cleaners.sh
    │   ├── interactive.sh
    │   └── utils.sh
    ├── config/
    │   ├── linux.conf
    │   └── macos.conf
    ├── PRD.md
    └── README.md

------------------------------------------------------------------------

## 10. Acceptance Criteria

-   Installable via `./install.sh`
-   Runs via `dfree`
-   Displays color-coded disk usage
-   Detects safe cleanable locations
-   Executes interactive cleanup
-   Shows per-operation reclaimed space
-   Displays cumulative progress
-   Produces final summary report
-   Works on Ubuntu and macOS

------------------------------------------------------------------------

## 11. Future Enhancements

-   JSON output mode
-   Auto-clean mode
-   Cron integration
-   Large file finder (\>1GB)
-   Configurable thresholds
-   Compiled Go version

------------------------------------------------------------------------

## 12. Summary

dfree is a safe, interactive, statistics-driven disk cleanup CLI
designed for modern developer and server environments. It prioritizes
safety, transparency, and measurable disk recovery.
