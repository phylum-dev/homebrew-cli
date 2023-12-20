class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v6.0.1.tar.gz"
  sha256 "1734e6a708f5df6445d5659c4cccdec71f49e7a744534a1bb71311f8ac215500"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-6.0.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9bc325390b614a842e2dc94dab11f1112b972f4a4a805271816a58278fafb152"
    sha256 cellar: :any_skip_relocation, ventura:       "6994526b04c06278c231943ddddcdfe9f1aab3764f44e0f426ee0cabe658e5b5"
    sha256 cellar: :any_skip_relocation, monterey:      "bc6c173a5ec9d3cedd62623ea830213f0d9d62f4814b61737fbae1e6dfa0cbb0"
  end

  depends_on "rust" => :build
  depends_on "protobuf" => :build

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
