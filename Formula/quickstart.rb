class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.5.2.tar.gz"
  sha256 "79587d6183e8cbb5167fb39268079dc00804806a69a9cf9f5093524261918b6a"
  version "1.5.2"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

