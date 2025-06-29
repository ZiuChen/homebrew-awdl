class Awdl < Formula
  desc "Command line tool to manage Apple Wireless Direct Link (AWDL) interface"
  homepage "https://github.com/ZiuChen/homebrew-awdl"
  url "https://github.com/ZiuChen/homebrew-awdl/archive/v1.0.0.tar.gz"
  sha256 "9b1eafd71dcdc2b24e5cc2fcbc7973f46068181d79e952c77e2071e587ed1703"
  license "MIT"

  def install
    bin.install "awdl"
  end

  test do
    system "#{bin}/awdl", "help"
  end

  def caveats
    <<~EOS
      AWDL Command Line Tool has been installed.

      Usage:
        awdl status    # Check current AWDL status
        awdl disable   # Start persistent AWDL disabling
        awdl enable    # Re-enable AWDL and stop daemon
        awdl help      # Show all available commands

      Note: This tool requires sudo privileges to manage network interfaces.
      Disabling AWDL will affect AirDrop, AirPlay, and other Apple services.

      For more information, visit: https://github.com/ZiuChen/homebrew-awdl
    EOS
  end
end
