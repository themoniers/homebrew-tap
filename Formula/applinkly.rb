# typed: false
# frozen_string_literal: true

# The AppLinkly Agent CLI (agent-cli plan D11), downloaded from the AppLinkly Edge's public release
# routes. Written by `make brew-formula` from release 0.31.0's manifest: regenerate it, never
# edit it — the copy in the tap themoniers/homebrew-applinkly is this file.
class Applinkly < Formula
  desc "Put the apps of this machine on their public AppLinkly addresses"
  homepage "https://applinkly.com"
  version "0.31.0"

  on_macos do
    on_arm do
      url "https://to.monier-michel.com/v1/releases/applinkly-0.31.0-darwin-arm64"
      sha256 "b2ba36177fd01b369832db259ecaea600c96d1ffbd4cc16dee76f2b7f82b1381"
    end
    on_intel do
      url "https://to.monier-michel.com/v1/releases/applinkly-0.31.0-darwin-amd64"
      sha256 "e5019976f66ba55a8e1647fe8e82036af3052144bd7ffce1fad0531244e454ed"
    end
  end

  on_linux do
    on_arm do
      url "https://to.monier-michel.com/v1/releases/applinkly-0.31.0-linux-arm64"
      sha256 "54c6d12625eafe98cae92310f55fa3512c1c34d5a98a5236987bc58a448abad2"
    end
    on_intel do
      url "https://to.monier-michel.com/v1/releases/applinkly-0.31.0-linux-amd64"
      sha256 "75bef241bdbbe08ce8b532723943a0cec36e8beae934f095798d8bf459fd1d1b"
    end
  end

  # One bare, self-contained executable per platform: no archive to unpack.
  def install
    binary = Dir["applinkly-*"].first
    chmod 0755, binary
    bin.install binary => "applinkly"
  end

  # `applinkly service install` delegates to `brew services`, which loads this as the launchd job
  # homebrew.mxcl.applinkly. Restarted unless it exits cleanly (exit 3, another Agent already
  # runs, is not clean either: launchd's throttle spaces the tries, as the app's own plist does).
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
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/applinkly --version").strip
  end
end
