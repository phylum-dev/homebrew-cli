class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.8.0.tar.gz"
  sha256 "3ee9a92951278c75ae998fb65617ca1f7448983e78e1aecdb0c459a06eb53064"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.7.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ed6d1917e1ce3e6ab19639a21e0799b248eda6432c8c684d0f797af9ebfd99f8"
    sha256 cellar: :any_skip_relocation, monterey:       "a9509d8eba211037492865b343825ae8ee4574cdc1bfc4c991a987e413fe7f20"
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
