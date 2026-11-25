# typed: false
# frozen_string_literal: true

class Applinkly < Formula
  desc "Put the apps of this machine on their public AppLinkly addresses"
  homepage "https://applinkly.com"
  version "0.35.0"

  on_macos do
    on_arm do
      url "https://api.applinkly.com/v1/releases/applinkly-0.35.0-darwin-arm64"
      sha256 "47579db24ce4ad5f27f554428f4f0cb4e5dc05b8d8f3633d1930649651a9f24d"
    end
    on_intel do
      url "https://api.applinkly.com/v1/releases/applinkly-0.35.0-darwin-amd64"
      sha256 "af1f9af7f80facf568aa6e2562bb0c867ac0006a78e6cec1bf9822fbe2a5c6e1"
    end
  end

  on_linux do
    on_arm do
      url "https://api.applinkly.com/v1/releases/applinkly-0.35.0-linux-arm64"
      sha256 "1aa3e4eeccdafe464fd0dbc4062068a39afda1fda69407ddac6e6110abf8157f"
    end
    on_intel do
      url "https://api.applinkly.com/v1/releases/applinkly-0.35.0-linux-amd64"
      sha256 "1941c5e89f8a273bb660fd3076926ceb3f37e22fa9d7e2f0787871667592dd93"
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
      Next, connect this Mac to your AppLinkly account:
        1. applinkly service install   runs it in the background, now and at every login
        2. applinkly service login     shows a link and a code: open the link on any device
                                       signed in to AppLinkly and approve the code
        3. applinkly service status    should say who is signed in and that it is connected
      Then give your apps their addresses in the console: https://console.applinkly.com

      Rather try it in this terminal first?  applinkly start   (signs in, serves until Ctrl-C)
      Started it with "brew services start applinkly"? It is not signed in yet: run step 2.

      To remove it: first its service, its sign-in and its data, then the program:
        applinkly service uninstall
        brew uninstall applinkly
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/applinkly --version").strip
  end
end
