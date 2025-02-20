class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/releases/tag/v1.4.2"
  sha256 "677aef22a298063d1a162bee8b198ec0c41c7bb54583c24e78929493187150d6"
  version "1.4.2"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

