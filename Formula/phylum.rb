class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.6.1.tar.gz"
  sha256 "7081b0a0aba21c51ee3db0c804fb0128b086f03a87436c442cd65094daa37f45"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.6.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "be28620701153e328dd21e0a2b4c15805e1fa4417e4b0a9800bfd6f59ecceef3"
    sha256 cellar: :any_skip_relocation, monterey:       "ce134f4c1579d2eeb4dc7e15af5509ce422b2516dc7c89b84a5816c5c821668a"
    sha256                               x86_64_linux:   "ff793bf11dcc8f375a608b17424b1cf3cbfaa9a45fbb63c01c079adc414d389a"
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
