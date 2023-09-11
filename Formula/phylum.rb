class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.7.1.tar.gz"
  sha256 "7204be0af570c83f138f6db47d5d843479da4e34cf32e456ee02499dfbee5aed"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.7.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4b25d8f0c12693ef41be7b2ec3c842a3a543f6f1e13e874ab13b6116917c150c"
    sha256 cellar: :any_skip_relocation, ventura:       "d37e5b302e3299b671f82eda12173291ebcd9b1c4276c3f875308d7e570efab2"
    sha256 cellar: :any_skip_relocation, monterey:      "4bdbd2ab85e144cbe94ef17bfb71b7f99f5eebbc543a7e0deed9c77e37e61da7"
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
