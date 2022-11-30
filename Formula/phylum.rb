class Phylum < Formula
  desc "Software Supply Chain Security CLI"
  homepage "https://phylum.io"
  url "https://github.com/phylum-dev/cli/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "0e11dd83cae44fe180691c681acfe4e783c9130eda79b89af0efb4ce8887c514"
  license "GPL-3.0-or-later"
  head "https://github.com/phylum-dev/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/phylum-dev/homebrew-cli/releases/download/phylum-3.12.1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "870db7696c390e793c0cce4dedcefc7fb5b976b698d174a2d2d37119e438667a"
    sha256 cellar: :any_skip_relocation, monterey:       "1fa6e969ea3f85277be1458532abcbad76f6ba1947bd8be17dbf94e8c4a35286"
    sha256                               x86_64_linux:   "7b7ce5dab272db5fca5ec3352c6d3e3503ecd1aafbbb651a7a96524eb9ebfd33"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "cli")
  end

  test do
    system "#{bin}/phylum", "version"
  end
end
