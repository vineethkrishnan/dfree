# dfree

![CI](https://github.com/vineeth/dfree/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**dfree** is a cross-platform, interactive CLI tool designed to safely analyze disk usage and clean system caches, Docker artifacts, and logs.

## Features

-   **Interactive & Safe**: No automatic deletion. You confirm every action.
-   **Cross-platform**: Works on Linux and macOS.
-   **Docker Awareness**: Detects and prunes Docker usage.
-   **Detailed Analysis**: Break down usage by category (System, Docker, Logs, Cache).
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

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to contribute.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
