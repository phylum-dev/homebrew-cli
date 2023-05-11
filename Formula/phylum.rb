class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.2.0.tar.gz"
  sha256 "f30a5f9be783e3f410ed84caa3ce8b4172edd342038231179817ccc70044db56"
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
