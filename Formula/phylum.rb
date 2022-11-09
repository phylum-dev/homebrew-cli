class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v3.12.1.tar.gz"
  sha256 "631ecb17a8100facd0b9e82e597c737cd105c0734408b9f68dec1aea99205e57"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-3.12.1"
    sha256 cellar: :any_skip_relocation, monterey:     "cdfc6810f99b11b680115e89af4eb4044f19bbd7adf943bfd000203b66320301"
    sha256                               x86_64_linux: "a09a307592f3c3b6e83ecaf09d5e4a7769d659b5e9009de49697d934ad29831d"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
