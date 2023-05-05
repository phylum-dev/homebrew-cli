class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.1.0.tar.gz"
  sha256 "3b9d5dc33a44f937fb3c863125345826983227fede246c9a3ddd070824c382c8"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.1.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "438998859829f6e604d807b1769383f640256c46c09fdbfad9832416338708d5"
    sha256 cellar: :any_skip_relocation, monterey:       "e7580011a3df076e19dd341ae3135a190117c625e44312d9841397051c79606a"
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
