# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-06-29

### Added
- Initial release of AWDL Command Line Tool
- Pure local implementation without network dependencies
- Persistent daemon mode for continuous AWDL management
- Temporary enable/disable commands
- Status monitoring with colored output
- Homebrew formula for easy installation
- Comprehensive documentation and help system
- Safe cleanup and error handling
- LaunchDaemon integration for system-level persistence

### Features
- `awdl status` - Show current AWDL and daemon status
- `awdl disable` - Start persistent AWDL disabling daemon
- `awdl enable` - Stop daemon and re-enable AWDL
- `awdl down` - Temporarily disable AWDL interface
- `awdl up` - Enable AWDL interface
- `awdl help` - Show detailed help information

### Technical Details
- Written in pure Bash for maximum compatibility
- Uses macOS LaunchDaemon for system-level integration
- Monitors `awdl0` interface status every second
- Automatic cleanup on uninstallation
- Cross-reboot persistence
- Comprehensive error handling and user feedback

### Documentation
- Complete README with usage examples
- Installation and uninstallation scripts
- Homebrew tap setup
- GitHub Actions for automated releases
- MIT License

[1.0.0]: https://github.com/ZiuChen/homebrew-awdl/releases/tag/v1.0.0
