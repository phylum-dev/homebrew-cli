class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "0e11dd83cae44fe180691c681acfe4e783c9130eda79b89af0efb4ce8887c514"
  license "GPL-3.0-or-later"
  revision 1
  head "https://github.com/phylum-dev/cli.git", branch: "main"

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
