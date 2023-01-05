class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.2.0.tar.gz"
  sha256 "844eab016e5827bdb182243bbaaacd21623983315a33e8f3091234215b2a45ec"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.2.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "29aee5e1d25b82ea8a33749b0513504cbfe0f88793b265332ad022bb0f549b3b"
    sha256 cellar: :any_skip_relocation, monterey:       "20342f7badaaad4d2a10013933c221ca963117cdb49c377f219b83691a8218d8"
    sha256                               x86_64_linux:   "5734a132b8d6344ef45b1037b45c0749aa4a9545219cec056f42575b12f2fa33"
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
