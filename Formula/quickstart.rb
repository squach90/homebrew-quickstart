class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.5.4.tar.gz"
  sha256 "c4f9f87c48cefb7e47e71b28315b1d377819eb098a574288ababa04b1675afe7"
  version "1.5.4"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

