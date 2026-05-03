class Ports < Formula
  desc "Project-aware lsof for macOS with kill-by-port and caffeinate support"
  homepage "https://portscli.com"
  url "https://github.com/erdemylmaz/ports-cli/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "7d76da152d6556209d8b4e5e5262b76040356ee008a3f36c74b3bf156f92565b"
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
