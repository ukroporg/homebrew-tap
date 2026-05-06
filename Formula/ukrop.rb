class Ukrop < Formula
  desc "Quick directory jumping and command execution with fuzzy TUI"
  homepage "https://github.com/ukroporg/ukrop"
  url "https://github.com/ukroporg/ukrop/archive/refs/tags/v0.17.tar.gz"
  sha256 "dc2f2f686900fa19a4ce1344a51772027066acd9b2f063909438cd836c838145"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      To activate ukrop, add the following to your shell config:

        # bash (~/.bashrc)
        eval "$(ukrop init bash)"

        # zsh (~/.zshrc)
        eval "$(ukrop init zsh)"

        # fish (~/.config/fish/config.fish)
        ukrop init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ukrop --version")
  end
end
