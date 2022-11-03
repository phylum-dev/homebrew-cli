class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v3.12.1.tar.gz"
  sha256 "631ecb17a8100facd0b9e82e597c737cd105c0734408b9f68dec1aea99205e57"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
