# typed: false
# frozen_string_literal: true

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
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/applinkly --version").strip
  end
end
