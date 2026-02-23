# dfree

![CI](https://github.com/vineeth/dfree/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**dfree** is a cross-platform, interactive CLI tool designed to safely analyze disk usage and clean system caches, Docker artifacts, and logs.

## Features

-   **Interactive & Safe**: No automatic deletion. You confirm every action.
-   **Cross-platform**: Works on Linux and macOS.
-   **Docker Awareness**: Detects and prunes Docker usage.
-   **Detailed Analysis**: Break down usage by category (System, Docker, Logs, Cache).
-   **Developer Caches**: Finds and cleans common caches (npm, yarn, pip, cargo).
-   **Custom Rules**: Supported via `~/.dfreerc` to customize targets and directories.
-   **Hexagonal Architecture**: Built for stability and testability.

## Installation

```bash
git clone https://github.com/vineeth/dfree.git
cd dfree
./install.sh
```

## Usage

```bash
dfree
```

Options:
-   `--simulate`: Run in simulation mode (no deletion).
-   `--help`: Show help message.

## Configuration (.dfreerc)

You can customize `dfree` behavior by creating a `~/.dfreerc` file. This is evaluated as a Bash script, allowing you to define paths to include or exclude from cleaning sequences.

```bash
# ~/.dfreerc
# Array of additional paths you want `dfree` to ask about cleaning
DFREE_CUSTOM_PATHS=("/path/to/my/custom/cache" "/var/tmp")

# Array of paths that should NEVER be deleted
DFREE_EXCLUDED_PATHS=("/path/to/my/custom/cache/keep")
```

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
