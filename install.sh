#!/bin/bash

# AWDL Tool Installation Script
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

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "This tool only works on macOS"
    exit 1
fi

# Check if awdl0 interface exists
if ! ifconfig awdl0 &>/dev/null; then
    print_error "AWDL interface not found. This tool requires a Mac with AWDL support."
    exit 1
fi

print_info "Installing AWDL Command Line Tool..."

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    print_error "Please do not run this script as root"
    exit 1
fi

# Install location
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="awdl"
INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Check if install directory exists
if [[ ! -d "$INSTALL_DIR" ]]; then
    print_info "Creating $INSTALL_DIR directory..."
    sudo mkdir -p "$INSTALL_DIR"
fi

# Copy the script
if [[ -f "$SCRIPT_NAME" ]]; then
    print_info "Installing $SCRIPT_NAME to $INSTALL_PATH..."
    sudo cp "$SCRIPT_NAME" "$INSTALL_PATH"
    sudo chmod +x "$INSTALL_PATH"
    print_success "Installation completed!"
else
    print_error "Script file '$SCRIPT_NAME' not found in current directory"
    exit 1
fi

# Verify installation
if [[ -x "$INSTALL_PATH" ]]; then
    print_success "AWDL tool installed successfully"
    print_info "You can now use the 'awdl' command"
    echo
    print_info "Quick start:"
    echo "  awdl status    # Check current status"
    echo "  awdl disable   # Disable AWDL persistently"
    echo "  awdl enable    # Re-enable AWDL"
    echo "  awdl help      # Show all commands"
else
    print_error "Installation failed"
    exit 1
fi
