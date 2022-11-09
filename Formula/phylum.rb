class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v3.12.1.tar.gz"
  sha256 "631ecb17a8100facd0b9e82e597c737cd105c0734408b9f68dec1aea99205e57"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-3.12.1"
    sha256 cellar: :any_skip_relocation, monterey:     "fd03416447a582420387542e23a1c1a965c245e282a053c139e4ce22ed4d0337"
    sha256                               x86_64_linux: "e0e316b6ca6cce71ddd8bc84bc576e741a552cf7636d72b09da454bc5f1bac6a"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
