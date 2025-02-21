class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "ae073988bffca2a3a63c4931b0ffa20396c0bc96e32ed09027542802ddff8ca8"
  version "1.5.0"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

