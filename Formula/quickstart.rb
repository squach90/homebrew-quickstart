class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.5.3.tar.gz"
  sha256 "d41a8be659575dc019afab8e1d0d775739812af9c8654f9e4e051cfb3fe9dd1e"
  version "1.5.3"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

