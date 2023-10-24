class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.8.0.tar.gz"
  sha256 "a3dfc2840238c5c683ba650b4f4afb55aa31d209fd216b036e10d628fad6bd7e"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.8.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e48433ba9ba53e46b1a8c59fd90b01d6ccb70860ad921b3deb70870f9428acf2"
    sha256 cellar: :any_skip_relocation, ventura:       "66ee07afcb71f78e26189cd27a09b9e2ff521def57866f5930093dc2eca3ed3e"
    sha256 cellar: :any_skip_relocation, monterey:      "661cda9db97cff7c5cadaae307a3b6f2d99fefd3ee40f7a6257e62b5ec1bdd5c"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")

    system "cargo", "run", "--package", "xtask", "--no-default-features", "gencomp"
    bash_completion.install "target/completions/phylum.bash"
    zsh_completion.install "target/completions/_phylum"
    fish_completion.install "target/completions/phylum.fish"
  end

  def caveats
    <<~EOS
      No official extensions have been installed. For a list of official extensions
      with installation instructions, see:
        https://github.com/phylum-dev/cli/tree/main/extensions
    EOS
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
