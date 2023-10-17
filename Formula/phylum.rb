class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.7.3.tar.gz"
  sha256 "3bd14b4ad67b6124a6d8196ae451d47ed5c22a233634e722cfcd96817defda08"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.7.2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cfa9cb8ab2146c45ac525d19f8f63c18304ba96225ae18822478676288a58bb6"
    sha256 cellar: :any_skip_relocation, ventura:       "d401cab08978d2ea1c8092d3145b8c007584405ca3e8571e5e2237bc5bc9757a"
    sha256 cellar: :any_skip_relocation, monterey:      "0da0ba69a8552037b0c7a4257d11d0c20d797df5201ce5f55fc9238a338b9702"
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
