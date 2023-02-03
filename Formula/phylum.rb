class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.6.0.tar.gz"
  sha256 "44ca58b518eabc0966902fd93fef69bcdbfd8bb71e51a2a663443e92d0b68d76"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.5.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0df98cf2bbf4a88a6db9f7dab21242e94dfc40c0b5fadad09128b05207cc93af"
    sha256 cellar: :any_skip_relocation, monterey:       "271579e51b4efa27ac736913ddd7ccb1b9253b4a057f0addc027c891ca7b8e34"
    sha256                               x86_64_linux:   "9b7b7097480fe3b3ca7e2b67222c811b34da6c9e9139f1df2466da6359dfffed"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")

    system "cargo", "xtask", "gencomp"
    bash_completion.install "target/completions/phylum.bash"
    zsh_completion.install "target/completions/_phylum"
    fish_completion.install "target/completions/phylum.fish"
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
