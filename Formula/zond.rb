# SPDX-License-Identifier: AGPL-3.0-or-later
class Zond < Formula
  desc "Network scanner that maps hosts, ports and services and what is wrong with them"
  homepage "https://github.com/zond-rs/zond"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/zond-rs/zond/releases/download/v0.18.0/zond-0.18.0-aarch64-apple-darwin.tar.gz"
      sha256 "97ead51c168e346033769d4864d2bd37252cd06fc621544f14f36c97be74660f"
    end
    on_intel do
      url "https://github.com/zond-rs/zond/releases/download/v0.18.0/zond-0.18.0-x86_64-apple-darwin.tar.gz"
      sha256 "7298b3ae7346d7d69a69afa6d3b20bc9130f08415a6ea2e8ca53230b31372dd9"
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
