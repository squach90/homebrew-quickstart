class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/releases/tag/v1.4.1"
  sha256 "92e5d2add52f1b5a16e140ba7ec794265d543804822b01a465890824191885dd"
  version "1.4.1"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

