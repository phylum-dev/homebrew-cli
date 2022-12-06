class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.0.1.tar.gz"
  sha256 "2167803fa383c48df818d739da7366fba022182dd3e20169272c24c2a863dfe5"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.0.1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "015f211bf3d8bbd921f0bd74757e9a24fc6aefbb0988a6246306635b994d707d"
    sha256 cellar: :any_skip_relocation, monterey:       "86b0e24441c091a9a1f3367555cd467ec6d5e1aeca3c2c75c82a30c84a669518"
    sha256                               x86_64_linux:   "19bb1f74b38e0ad4b0d99c200dcf7ad06a855e2f6816d73b1cdb4f72d74dbc09"
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
