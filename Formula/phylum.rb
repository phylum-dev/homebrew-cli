class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.0.0.tar.gz"
  sha256 "ffa03f99abd5702ea6d0cb959eaf3919b68e7e662dd55b1aeffe9c0ab7d3e72b"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.0.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "daafd41261909f2ff9ab0f55633e43e161c2098c76d819d3a9ff2ba92c3475f1"
    sha256 cellar: :any_skip_relocation, monterey:       "a68f25376d8a00bee792d4cf70f51e81b3f71fa363181d36713cdc3f4757db2b"
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
