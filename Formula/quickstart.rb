class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.5.1.tar.gz"
  sha256 "e65f2c76fb5a5090f6cc964dc4140d189800cd7afbdfecbd01fb89343ec4648c"
  version "1.5.1"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

