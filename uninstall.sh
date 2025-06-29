#!/bin/bash

# AWDL Tool Uninstallation Script
# Author: ZiuChen

set -euo pipefail

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info "Uninstalling AWDL Command Line Tool..."

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    print_error "Please do not run this script as root"
    exit 1
fi

INSTALL_PATH="/usr/local/bin/awdl"

# Stop daemon if running
if [[ -x "$INSTALL_PATH" ]]; then
    print_info "Stopping AWDL daemon if running..."
    "$INSTALL_PATH" enable 2>/dev/null || true
fi

# Remove the binary
if [[ -f "$INSTALL_PATH" ]]; then
    print_info "Removing $INSTALL_PATH..."
    sudo rm "$INSTALL_PATH"
    print_success "Binary removed"
else
    print_warning "Binary not found at $INSTALL_PATH"
fi

# Clean up any remaining files
print_info "Cleaning up remaining files..."

# Remove daemon script if exists
sudo rm -f /tmp/awdl_disable_daemon.sh

# Remove plist if exists
sudo rm -f /Library/LaunchDaemons/com.awdl.disable.plist

# Kill any remaining processes
sudo pkill -f awdl_disable_daemon.sh 2>/dev/null || true

print_success "AWDL Command Line Tool has been completely uninstalled"
print_info "AWDL interface has been restored to normal operation"
