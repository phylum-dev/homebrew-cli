class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v6.1.1.tar.gz"
  sha256 "5eaf2036e2555303a9691bb591b4c99711f1e30be16a8fcfbef09184b1543e42"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-6.1.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f220c004752c81eef5a849503221639f1ddbf24ffca5077b978acb775084d1d2"
    sha256 cellar: :any_skip_relocation, ventura:       "0e4e9c057c7c3e59555016512c7f448f186be5b26f6603ab5ce0bf4b195e68eb"
    sha256 cellar: :any_skip_relocation, monterey:      "78e13753bc3d9e931f1f01b9db89c20d14bd3beaec9aa18a6a5e7ecc8d4f9e14"
  end

  deprecate! date: "2024-02-14",
    because: <<~EOS
      is available as `phylum-cli` in core tap!
      To migrate:

        brew uninstall phylum
        brew untap phylum-dev/cli
        brew install phylum-cli

    EOS

  depends_on "rust" => :build
  depends_on "protobuf" => :build

  conflicts_with "phylum-cli", because: "both install `phylum` binaries"

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
