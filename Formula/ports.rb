class Ports < Formula
  desc "Project-aware lsof with AI session discovery and followable caffeinate"
  homepage "https://portscli.com"
  version "0.6.0"
  license "MIT"
  head "https://github.com/erdemylmaz/ports-cli.git", branch: "main"

  if Hardware::CPU.arm?
    url "https://github.com/erdemylmaz/ports-cli/releases/download/v0.6.0/ports-darwin-arm64"
    sha256 "0a06428458a91308a40195a05204f6cd91c528192760d9256374a9fdc22d03df"
  else
    url "https://github.com/erdemylmaz/ports-cli/releases/download/v0.6.0/ports-darwin-amd64"
    sha256 "b4544a55a446c1a0a0eb7a9c847028373e4a8ac23ec4f5023e45274eee08a420"
  end

  depends_on :macos

  def install
    binary = Hardware::CPU.arm? ? "ports-darwin-arm64" : "ports-darwin-amd64"
    bin.install binary => "ports"
  end

  test do
    assert_match "ports #{version}", shell_output("#{bin}/ports version")
  end
end
