class Ports < Formula
  desc "Project-aware lsof for macOS — listening ports with project context"
  homepage "https://portscli.com"
  url "https://github.com/erdemylmaz/ports-cli/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "83ae0a4ec35d386d769b89ac84d7417741b01284117ccc5290d4928c20db6673"
  license "MIT"
  head "https://github.com/erdemylmaz/ports-cli.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/ports"
  end

  test do
    assert_match "ports #{version}", shell_output("#{bin}/ports version")
  end
end
