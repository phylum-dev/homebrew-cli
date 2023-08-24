class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.7.0.tar.gz"
  sha256 "cf3a864ea9cffd26d9db316bcbde6b6b27c446f7b907a479abe721a4c2681cbe"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.6.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dddc7b899784eda325247769447128360726d2d96f43994524cc7f975e3ac37d"
    sha256 cellar: :any_skip_relocation, ventura:       "e94ce94dbef79270635498280608b973217b3a2eec39f398cfa9a6e657406358"
    sha256 cellar: :any_skip_relocation, monterey:      "7450beda7cf506be5db776f0c12872985fa4ec466e3965851a8c439e89270155"
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
