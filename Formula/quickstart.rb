class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "86575024265839d8686c1344554aecb8f883236259df55ccf04ff0f1029e6ef4"
  version "1.2.0"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

