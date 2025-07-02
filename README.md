# Flutter SDK Cache Volumes Demo for Buildkite

This repository demonstrates how to:

- Download and install a pinned version of the Flutter SDK
- Cache the SDK across builds using [Buildkite Cache Volumes](https://buildkite.com/docs/pipelines/hosted-agents/cache-volumes)
- Handle ephemeral agents and cold-start scenarios gracefully

## How It Works

- `setup_flutter.sh` installs the specified Flutter SDK version if it's not already cached, and adds it to `PATH`
- `.buildkite/pipeline.yml` defines three sequential steps:
  1. Install dependencies
  2. Run tests
  3. Build a macOS app
- Each step sources the setup script, ensuring the correct Flutter version is available
- The `simple-flutter/` directory is mounted as a cache volume, preserving the SDK between builds

### First Build (No Cache)

![First Build](<CleanShot 2025-07-02 at 14.26.28.png>)

### Second Build (With Cache)

![Second Build](<CleanShot 2025-07-02 at 14.27.20.png>)

## Project Structure

```
flutter-sdk-cache-volumes-demo/
├── .buildkite/
│ └── pipeline.yml
├── setup_flutter.sh
├── README.md
```

## Requirements

- Buildkite macOS hosted agents

## Getting Started

1. Fork or clone this repository
2. Connect it to a Buildkite pipeline
3. Trigger a build — the first run will download the SDK, and subsequent runs will reuse it from cache

## Notes

- The Flutter version is controlled via the `FLUTTER_VERSION` environment variable in the pipeline file
- The script validates the version and skips reinstallation if the correct version is already cached
- This pattern helps reduce build times and avoid unnecessary downloads
