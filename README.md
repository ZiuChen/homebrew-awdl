# AWDL Command Line Tool

A pure local command line tool to manage Apple Wireless Direct Link (AWDL) interface on macOS, helping resolve WiFi disconnection issues caused by AWDL interference.

## Background

AWDL (Apple Wireless Direct Link) is Apple's wireless peer-to-peer protocol used for AirDrop, AirPlay, and other services. However, it can cause WiFi instability and disconnections, especially on Apple Silicon Macs (M1, M2, etc.) in environments with many wireless access points.

This tool provides a local solution to manage AWDL without requiring network access.

## Features

- ✅ **Pure Local**: No network dependencies, works completely offline
- 🔄 **Persistent Control**: Daemon mode survives system reboots  
- ⚡ **Quick Actions**: Temporary enable/disable commands
- 📊 **Status Monitoring**: Check current AWDL and daemon status
- 🎨 **User Friendly**: Colored output with clear status indicators
- 🛡️ **Safe**: Proper cleanup and error handling

## Installation

### Via Homebrew (Recommended)

```bash
# Add the tap
brew tap ZiuChen/homebrew-awdl

# Install the tool
brew install awdl
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/ZiuChen/homebrew-awdl.git
cd homebrew-awdl

# Make executable and install
chmod +x awdl
sudo cp awdl /usr/local/bin/awdl
```

## Usage

### Basic Commands

```bash
# Check current status
awdl status

# Start persistent AWDL disabling (survives reboots)
awdl disable

# Re-enable AWDL and stop daemon
awdl enable

# Temporarily disable AWDL (may be re-enabled by system)
awdl down

# Enable AWDL interface
awdl up

# Show help
awdl help
```

### Example Workflow

1. **Check if AWDL is causing issues:**
   ```bash
   awdl status
   ```

2. **Disable AWDL persistently to fix WiFi issues:**
   ```bash
   awdl disable
   ```

3. **Temporarily enable AWDL for AirDrop:**
   ```bash
   awdl enable
   # Use AirDrop...
   awdl disable  # Disable again
   ```

## Commands Reference

| Command | Description | Persistence |
|---------|-------------|-------------|
| `status` | Show AWDL interface and daemon status | - |
| `disable` | Start daemon to continuously disable AWDL | ✅ Survives reboot |
| `enable` | Stop daemon and enable AWDL | ✅ Survives reboot |
| `down` | Disable AWDL interface once | ❌ Temporary |
| `up` | Enable AWDL interface once | ❌ Temporary |
| `help` | Show help message | - |

## How It Works

### Daemon Mode (`awdl disable`)
- Creates a LaunchDaemon that runs continuously
- Monitors AWDL interface every second
- Automatically disables AWDL when system tries to enable it
- Survives system reboots
- Logs activity to `/tmp/awdl_daemon.log`

### Temporary Mode (`awdl down`)
- Disables AWDL interface once
- System processes may re-enable it automatically
- Useful for quick testing

## Important Notes

⚠️ **Disabling AWDL will affect the following Apple services:**
- AirDrop
- AirPlay
- Handoff
- Continuity features
- Universal Clipboard

💡 **When to use this tool:**
- Experiencing frequent WiFi disconnections
- Working in environments with many access points
- Need stable network connection over Apple services

🔧 **Technical Details:**
- Works by managing the `awdl0` network interface
- Uses macOS LaunchDaemon for persistence
- Requires sudo privileges for interface control

## Troubleshooting

### Permission Issues
```bash
# Make sure the script is executable
chmod +x /usr/local/bin/awdl

# Check if you have sudo access
sudo -v
```

### Daemon Not Starting
```bash
# Check system logs
tail -f /tmp/awdl_daemon.log

# Manually check daemon status
sudo launchctl list | grep awdl
```

### AWDL Interface Not Found
This tool only works on macOS with AWDL support. Ensure you're running on a compatible Mac.

## Uninstallation

### Homebrew
```bash
brew uninstall awdl
brew untap ZiuChen/homebrew-awdl
```

### Manual
```bash
# Stop daemon if running
awdl enable

# Remove binary
sudo rm /usr/local/bin/awdl
```

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Based on scripts from [meterup/awdl_wifi_scripts](https://github.com/meterup/awdl_wifi_scripts)
- Inspired by the blog post: [解决由于 AWDL 导致 Mac 的断网问题](https://jiapan.me/2023/AWDL-Mac-disconnected/)

## Related Resources

- [Apple Technical Note: About AWDL](https://developer.apple.com/library/archive/technotes/tn2442/_index.html)
- [Understanding WiFi Issues on Apple Silicon Macs](https://support.apple.com/HT213504)
