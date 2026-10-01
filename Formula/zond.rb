# SPDX-License-Identifier: AGPL-3.0-or-later
class Zond < Formula
  desc "Network scanner that maps hosts, ports and services and what is wrong with them"
  homepage "https://github.com/zond-rs/zond"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/zond-rs/zond/releases/download/v0.19.0/zond-0.19.0-aarch64-apple-darwin.tar.gz"
      sha256 "60e7e0bb2578dbee8cc9557a6ef6db5ca2ce90635041e71357cb4b338eae32f0"
    end
    on_intel do
      url "https://github.com/zond-rs/zond/releases/download/v0.19.0/zond-0.19.0-x86_64-apple-darwin.tar.gz"
      sha256 "96d0c3d8b81b9c774e9a3e19f49596855c8c5e44651807fb28c99ff5a022523e"
    end
  end

  def install
    bin.install "zond"
    doc.install "NOTICE.ubuntu-data"
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
