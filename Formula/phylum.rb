class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.2.0.tar.gz"
  sha256 "844eab016e5827bdb182243bbaaacd21623983315a33e8f3091234215b2a45ec"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.1.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "452280a6a48ab5e1d188f3db923b46d9bfb5b4b21cb437499e15546572ade5b0"
    sha256 cellar: :any_skip_relocation, monterey:       "e3082ff90ff1090ee29da42afabf1db39209f1dfa086d475ef52d25c8c031bb6"
    sha256                               x86_64_linux:   "42443828356747a0fd58a58339c7fd3f0709d290d65853bf1f6a317a0b06afd7"
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
