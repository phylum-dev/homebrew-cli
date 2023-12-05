class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.9.0.tar.gz"
  sha256 "00c9cdfe1a8d7332fbd843c926107f60be511e22121fc2ecf5bb0d6d0e11c14e"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.8.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6c9e976d406336ac81cd04709de7e7477ec946b5c0409ed819368baf050ebc72"
    sha256 cellar: :any_skip_relocation, ventura:       "7102429b856409a8312ab33978b45e3aed4c586dc65241dff2331aab87eebe9f"
    sha256 cellar: :any_skip_relocation, monterey:      "0f909e0fbdfcbd2432c5b7dfe61554312f039ac8d8b99854a632ac806d08cac3"
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
