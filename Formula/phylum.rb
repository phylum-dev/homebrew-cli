class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.7.0.tar.gz"
  sha256 "0c4ffca800d461db2e935e6308ce336e24679dd5518689d8f0ecaba4f1f88946"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.6.1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4494e28d017ce5e35ebc0a0b7bcb4c638fb1aa3d13375f85296ad028a7047ad0"
    sha256 cellar: :any_skip_relocation, monterey:       "a2134599cf60c7ec6da3e7cca6419798400755d48e0791a5128d0d781598d040"
    sha256                               x86_64_linux:   "8fe1189e8afd24e485c60d5e74a1cc2c8b1a666db8df67a0d3868fc67ca89548"
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
