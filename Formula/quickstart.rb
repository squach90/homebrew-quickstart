class Projinit < Formula
  desc "Un CLI pour créer rapidement des projets HTML, Python, Node, etc."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "TON_SHA256"
  version "1.0.0"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

