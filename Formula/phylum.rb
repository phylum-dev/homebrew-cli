class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.3.0.tar.gz"
  sha256 "3dc5ace6e81a4c1a2f1b0c1ec464cdb539a0acbe5c519ed4a4a2bf6d5ae18fd2"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.3.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "efae4830e9a68a129d7d429cf7582630216d6f6f4f7e2c5fd4fbbb53a237da30"
    sha256 cellar: :any_skip_relocation, monterey:       "14fcea7cb6ee9be48be6025cb419f84426c7e6fae7423e0f8f1b45de46bfed4f"
    sha256                               x86_64_linux:   "979985ba7451415601578b290e936eb488dab83c856e7a6a4d00d17390ce1252"
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
