class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v6.1.1.tar.gz"
  sha256 "5eaf2036e2555303a9691bb591b4c99711f1e30be16a8fcfbef09184b1543e42"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-6.1.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1066d454094db53ec9755f61a4a6980659054b2f3a1c86f46d904a90d522dfae"
    sha256 cellar: :any_skip_relocation, ventura:       "70fa68b89b1e8d1bed3bf514f7b63ce3020961f9831a64eea47858b7580c8be1"
    sha256 cellar: :any_skip_relocation, monterey:      "17eb0b62ca40ad5fb539fd26687c21f15fe348a2fc16c3b7d6d2efdb9a1a34c0"
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
