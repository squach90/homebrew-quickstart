class Quickstart < Formula
  desc "Un CLI pour créer rapidement des projets HTML, Python, Node, etc."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "21749c869375878901ef9b360121a6179217df5aaf66c32213b99e1654892f8e"
  version "1.1.0"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

