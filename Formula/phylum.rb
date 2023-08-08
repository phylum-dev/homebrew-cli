class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.6.0.tar.gz"
  sha256 "e1a06ec78d35c3b607e8f6368fa47b75f02118e22762f431730dc991e9ddcde4"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.5.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2d5fe4371c54ab2cec168581e4c39e39ebab2ff388fc78d51ec1c67223f8b6a5"
    sha256 cellar: :any_skip_relocation, ventura:       "19c870df7c0164873b31ea6855cd96171812a0d8487c26ffc309099687d53683"
    sha256 cellar: :any_skip_relocation, monterey:      "1841cdc6fce8ac5c0ced53a9c4b0c945fd50defb8aa56e5f696c5532f7d79c2f"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")

    system "cargo", "run", "--package", "xtask", "gencomp"
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
