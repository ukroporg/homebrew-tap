class Ukrop < Formula
  desc "Quick directory jumping and command execution with fuzzy TUI"
  homepage "https://github.com/gupalo/ukrop"
  url "https://github.com/gupalo/ukrop/archive/refs/tags/v0.15.tar.gz"
  sha256 "b18c2ac319edf736c5083363ca1e74da6872853fa432f2ee0160e0aeb8f834b6"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ukrop --version")
  end
end
