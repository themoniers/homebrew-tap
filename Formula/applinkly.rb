# typed: false
# frozen_string_literal: true

class Applinkly < Formula
  desc "Put the apps of this machine on their public AppLinkly addresses"
  homepage "https://applinkly.com"
  version "0.32.1"

  on_macos do
    on_arm do
      url "https://applinkly.com/v1/releases/applinkly-0.32.1-darwin-arm64"
      sha256 "aed0c09cb322e3d025c6589d4217819c4e9ab068961a559824c13780539b0f73"
    end
    on_intel do
      url "https://applinkly.com/v1/releases/applinkly-0.32.1-darwin-amd64"
      sha256 "ee1cbc51ab4f5d7c02842ab9253aa24edb90f9f59911bdf6eec8660fa391d2ca"
    end
  end

  on_linux do
    on_arm do
      url "https://applinkly.com/v1/releases/applinkly-0.32.1-linux-arm64"
      sha256 "75bdf5e4c8de313dfdfc8c46909b6a2ea98055dc6e409a645e8adb3e9f01ed0a"
    end
    on_intel do
      url "https://applinkly.com/v1/releases/applinkly-0.32.1-linux-amd64"
      sha256 "0e323fc27d90cf83f3e43be5dbde7b6d00bbde06b3e9be4db38c605759e78d27"
    end
  end

  def install
    binary = Dir["applinkly-*"].first
    chmod 0755, binary
    bin.install binary => "applinkly"
  end

  service do
    run [opt_bin/"applinkly", "service", "run"]
    keep_alive successful_exit: false
    log_path var/"log/applinkly.log"
    error_log_path var/"log/applinkly.log"
  end

  def caveats
    <<~EOS
      Run it in a terminal:
        applinkly start
      Or in the background, as a service:
        applinkly service install   (the same as: brew services start applinkly)
        applinkly service login
      To remove it: first its service, its sign-in and its data, then the program:
        applinkly service uninstall
        brew uninstall applinkly
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/applinkly --version").strip
  end
end
