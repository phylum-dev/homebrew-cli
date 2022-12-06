class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "0e11dd83cae44fe180691c681acfe4e783c9130eda79b89af0efb4ce8887c514"
  license "GPL-3.0-or-later"
  revision 1
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.0.0_1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8754ae58126931e50deb0271e567fa8047e71f45a1043ec479146cc1d23dbd75"
    sha256 cellar: :any_skip_relocation, monterey:       "be3ab2f1edd73028c601aea86619e4860d69d85355cbdbf44502dd80c10de289"
    sha256                               x86_64_linux:   "5b669ce7d483185f46df4787ba64e816ccdbf0a99fa00b2efdbfa031d5dfd047"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")

    system "cargo", "xtask", "gencomp"
    bash_completion.install "target/completions/phylum.bash"
    zsh_completion.install "target/completions/_phylum"
    fish_completion.install "target/completions/phylum.fish"
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
