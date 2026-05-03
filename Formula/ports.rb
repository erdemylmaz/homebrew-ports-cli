class Ports < Formula
  desc "Project-aware lsof for macOS — listening ports with project context"
  homepage "https://github.com/erdemylmaz/ports-cli"
  url "https://github.com/erdemylmaz/ports-cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "8a3a3bf12567d3edc76e13d512e31e128fb48d8423697384cb52fddd026ed50d"
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
