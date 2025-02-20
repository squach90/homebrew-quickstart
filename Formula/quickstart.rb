class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/releases/tag/v1.4.2"
  sha256 "5b379ec04734edb75717c4797abec36fc6b2355f5c7f6270bd8b5c303e4027dd"
  version "1.4.2"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

