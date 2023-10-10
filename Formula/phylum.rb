class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.7.2.tar.gz"
  sha256 "6c9cc2897b9b1ce69220296960ea52812c58a34b2dd882ace4216e990d2e2c68"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.7.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bbfcd3069d311b2fb770f8e57c6c1579d8e2b72685ab5d95f3fd3a7e35593799"
    sha256 cellar: :any_skip_relocation, ventura:       "0ddb6db66c4ff5fc1669ff5f14b2c036724d4207d48c76ac3d2a163c87ddb3ce"
    sha256 cellar: :any_skip_relocation, monterey:      "71408e1627a4822db8d829ac25ee07279714646ee379332c3b559c831e9e6a53"
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
