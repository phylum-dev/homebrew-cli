class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v6.0.1.tar.gz"
  sha256 "1734e6a708f5df6445d5659c4cccdec71f49e7a744534a1bb71311f8ac215500"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-6.0.1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f81b7d7937950345f90a9dafcb3e68f03334d4258db3f946c3314c8e7cae4f09"
    sha256 cellar: :any_skip_relocation, ventura:       "1a5e297ef47b2faad271cd4adb21400dd34746fcfccf55ab2982b009f8c0eb34"
    sha256 cellar: :any_skip_relocation, monterey:      "2912e9321e05eeb398b4db4a5f4b70c0600a72cfaf815138a4c12dd3118fa99b"
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
