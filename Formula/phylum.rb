class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.7.3.tar.gz"
  sha256 "3bd14b4ad67b6124a6d8196ae451d47ed5c22a233634e722cfcd96817defda08"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.7.3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bfbd6afdbea96bfe570fb2a984e0d2f0355e73c7c9eb3414e326c04fd95807f7"
    sha256 cellar: :any_skip_relocation, ventura:       "50cc45e9a29cdeada0f391ec1299ce67f6b80dc95b372479be243d45e7e910d1"
    sha256 cellar: :any_skip_relocation, monterey:      "4f16701e767cccbcd9118f567cb8204d6a01f6fb797deeb4f5d81ecb8bfd7fea"
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
