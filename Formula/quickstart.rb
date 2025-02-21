class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.4.6.tar.gz"
  sha256 "66aff722f452c7a94e98a0a820fcdf5bb3dadaad22fd4dc78f00cda1aea02201"
  version "1.4.6"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

