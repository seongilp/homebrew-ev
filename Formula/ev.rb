class Ev < Formula
  desc "Everything-style terminal file search with office-document extraction"
  homepage "https://github.com/seongilp/ev"
  url "https://github.com/seongilp/ev/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8faa3ea962acd6fefcfd0cd5ac5f20b59758c4eb8d25c35e413e0c567ee52037"
  license "MIT"
  head "https://github.com/seongilp/ev.git", branch: "main"

  depends_on "fd"
  depends_on "fzf"
  depends_on "ripgrep"

  # Optional but enhance functionality:
  #   bat     — syntax-highlighted preview pane
  #   poppler — pdftotext, enables PDF content search/extraction
  depends_on "bat" => :recommended
  depends_on "poppler" => :recommended

  def install
    # Keep the script's layout intact: ev resolves its helpers relative to
    # itself via ${0:A:h}, and ev-extract via ${0:A:h:h}. Install the whole
    # tree under libexec and symlink the entry point — :A follows the symlink
    # back to the real location, so sourcing still resolves correctly.
    libexec.install "ev", "lib", "libexec"
    bin.install_symlink libexec/"ev"
  end

  def caveats
    <<~EOS
      ev auto-installs missing required tools via Homebrew on first interactive
      run; with this formula rg/fzf/fd are already present, so set
      EV_AUTO_INSTALL=0 to opt out of that behavior entirely.

      Optional dependencies (install for full functionality):
        brew install bat       # syntax-highlighted preview
        brew install poppler   # PDF content search/extraction (pdftotext)
    EOS
  end

  test do
    # Non-interactive paths don't need a TTY. Plain-text extraction just
    # echoes the file, so it exercises the dispatcher + sourced helpers.
    (testpath/"hello.txt").write("liquidity report\n")
    assert_match "liquidity report", shell_output("#{bin}/ev -x #{testpath}/hello.txt")

    # File listing via fd should find the file we just created.
    assert_match "hello.txt", shell_output("#{bin}/ev -l #{testpath}")

    # Content search via rg should match a term inside the file.
    assert_match "liquidity", shell_output("#{bin}/ev -g liquidity #{testpath}")
  end
end
