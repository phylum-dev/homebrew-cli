class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.0.0.tar.gz"
  sha256 "ffa03f99abd5702ea6d0cb959eaf3919b68e7e662dd55b1aeffe9c0ab7d3e72b"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.0.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "beb4f101d3afea5004c6609c647dc5e0845314029c547f2941969ae0194b24d1"
    sha256 cellar: :any_skip_relocation, monterey:       "9702aa716734cc67cff537c838b5766c013be4a126ecc869d69c7765ed0b0417"
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
