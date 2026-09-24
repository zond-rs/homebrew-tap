# SPDX-License-Identifier: AGPL-3.0-or-later
class Zond < Formula
  desc "Network scanner that maps hosts, ports and services and what is wrong with them"
  homepage "https://github.com/zond-rs/zond"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/zond-rs/zond/releases/download/v0.17.0/zond-0.17.0-aarch64-apple-darwin.tar.gz"
      sha256 "f1f93a3405ef2a2330c03c1f4d5484e10bdf8983bc89fe7a77bc08dcfcf4dd11"
    end
    on_intel do
      url "https://github.com/zond-rs/zond/releases/download/v0.17.0/zond-0.17.0-x86_64-apple-darwin.tar.gz"
      sha256 "25b4341791f21045bddd3e9809f478d23e16199d23a3e7cf141366679fc829c5"
    end
  end

  def install
    bin.install "zond"
  end

  def caveats
    <<~EOS
      SYN, ARP and ICMPv6 probing need packet access. Either run zond with sudo,
      or join the access_bpf group so it can read /dev/bpf without it:
        brew install --cask wireshark-chmodbpf
      then log out and back in. Without either, zond scans by TCP connect.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zond --version")
  end
end
