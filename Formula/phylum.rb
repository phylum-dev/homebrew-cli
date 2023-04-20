class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.0.1.tar.gz"
  sha256 "063a5c9d16c670caff9c9607d5194887b46a6d5f47501d501381617e4cb43ecf"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.0.1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "410f34a6be6aba064db40a6d604106fcf637bd35842ada3db30a1fdfbf0b873a"
    sha256 cellar: :any_skip_relocation, monterey:       "900d85aabaedb6b8380c6682fe93ba728edac0d15c61731272445b470c1a48e0"
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
