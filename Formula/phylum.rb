class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "0e11dd83cae44fe180691c681acfe4e783c9130eda79b89af0efb4ce8887c514"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-4.0.0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "52545927b97f386d3afee0d7966d93bf9a244daa8b622a193f252deba315b60b"
    sha256 cellar: :any_skip_relocation, monterey:       "02a934bcecf32b6a255d6f5d576d3fbe6cd1af282deda30d83137fbcfb72a729"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df3bb96ca6bbc9542e1ef2e1002b845fd0dd4140aaeb76d261bfdf235c71de20"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
