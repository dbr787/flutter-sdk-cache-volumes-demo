# Flutter SDK Cache Volumes Demo for Buildkite

This repository demonstrates how to:

- Install the Flutter SDK from the official zip archive
- Cache the SDK between builds using Buildkite macOS cache volumes
- Pin to a specific Flutter version
- Handle ephemeral agent environments gracefully

## How It Works

- `setup_flutter.sh` installs the Flutter SDK if not already cached
- `.buildkite/pipeline.yml` defines the CI pipeline
- The `flutter/` directory is used as a cache volume mount point
- The pipeline sets `FLUTTER_VERSION` as an environment variable

This pattern avoids downloading and extracting the SDK on every build, while ensuring builds remain reproducible and resilient to cache misses.

## Project Structure

```
flutter-sdk-cache-volumes-demo/
├── .buildkite/
│   └── pipeline.yml
├── setup_flutter.sh
├── pubspec.yaml              # (optional) Flutter test project
├── lib/
│   └── main.dart             # (optional) example app entry
└── README.md
```

## Requirements

- Buildkite macOS hosted agents
- Cache volumes enabled for your cluster

## Getting Started

1. Fork or clone this repository
2. Connect it to a Buildkite pipeline
3. Run a build and watch the Flutter SDK cache kick in 🚀
