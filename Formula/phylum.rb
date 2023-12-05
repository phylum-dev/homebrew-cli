class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v5.9.0.tar.gz"
  sha256 "00c9cdfe1a8d7332fbd843c926107f60be511e22121fc2ecf5bb0d6d0e11c14e"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-5.9.0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3209b62fcbd534adf4edb0e378f86d55303b65c2f7dade73e7e9f74fadbb73c2"
    sha256 cellar: :any_skip_relocation, ventura:       "0f6f16fe24587137d6d3efeaea8d41373235182b55f06aadf7c4d9f9060cca49"
    sha256 cellar: :any_skip_relocation, monterey:      "7290436c9017968cd0b7c985a4f19230aca44fe017aa7eee8a265caf0e108c39"
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
