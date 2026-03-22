class Ukrop < Formula
  desc "Interactive fuzzy TUI for navigating recent directories and re-running commands"
  homepage "https://github.com/gupalo/ukrop"
  url "https://github.com/gupalo/ukrop/archive/refs/tags/v0.1.tar.gz"
  sha256 "ed75d825e9b44df1a3cacc7c7a104710fc4a33297aacedca0d0b338085d327cd"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ukrop --version")
  end
end
