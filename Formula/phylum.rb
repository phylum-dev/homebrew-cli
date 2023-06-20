class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.3.0.tar.gz"
  sha256 "458d97aaee00beb093b6c22597505580078f265245b642084c248d8d493cedbc"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.3.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c78f11936dd87b22b767b6ed0d5b5e99ad4e1e9a1ade0a6a6e0830daffeba1e0"
    sha256 cellar: :any_skip_relocation, monterey:       "48480f21bf837a75929022f9278e9a3b56c2857d31727f17688fd14fbada17a0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")

    system "cargo", "xtask", "gencomp"
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
