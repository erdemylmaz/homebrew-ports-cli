class Ports < Formula
  desc "Project-aware lsof for macOS — listening ports with project context"
  homepage "https://portscli.com"
  url "https://github.com/erdemylmaz/ports-cli/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "8edc9bcd33684aeef55b8fddb15b6f09a452440a18680a43f42ee6560ff21f6b"
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
