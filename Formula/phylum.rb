class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.5.0.tar.gz"
  sha256 "1145b22b1f8fa42ce81c8b67d7e5122577432a600f1fbb091c02a8619e7ad90c"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.4.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ec3d4b4ac940756e8c6ff49cc2a612217ee5fb51915d557bf95b3549ed857152"
    sha256 cellar: :any_skip_relocation, monterey:       "eae06d6cd5f1fd9958a1a7d229ee25539d745b6044bfaa3f5408c2b009d95086"
    sha256                               x86_64_linux:   "ea4666fb837ea8cdfb363c168a1f0212cb5561fee4009415c0c441839c97c3b1"
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
