class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/releases/tag/v1.4.2"
  sha256 "59244f4cdce87f64586330d16c41821e2c8d4cbb6e81df549be321f78e38da61"
  version "1.4.2"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

