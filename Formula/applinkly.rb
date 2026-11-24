# typed: false
# frozen_string_literal: true

class Applinkly < Formula
  desc "Put the apps of this machine on their public AppLinkly addresses"
  homepage "https://applinkly.com"
  version "0.34.0"

  on_macos do
    on_arm do
      url "https://api.applinkly.com/v1/releases/applinkly-0.34.0-darwin-arm64"
      sha256 "0600517a1dd7d54698864ee2f0f02c368c75dcc53ba86dab5ee1b29f76749007"
    end
    on_intel do
      url "https://api.applinkly.com/v1/releases/applinkly-0.34.0-darwin-amd64"
      sha256 "4933439320a4263b6eac864cc59b41725b21562f3017871c1780db2016fb7587"
    end
  end

  on_linux do
    on_arm do
      url "https://api.applinkly.com/v1/releases/applinkly-0.34.0-linux-arm64"
      sha256 "510e40dfcb917c95ffb911ae774cbdd3e0ad306070b286d1afffdc2908d38f6f"
    end
    on_intel do
      url "https://api.applinkly.com/v1/releases/applinkly-0.34.0-linux-amd64"
      sha256 "c6810565c2bc0c911632a94bbca05ae853bfecd214ae4642f6526349382142fd"
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
