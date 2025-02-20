class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/releases/tag/v1.4.0"
  sha256 "306e0b111dee870da3206c2e9288d0d76c97a79d432a80fb433617d3c360e5ad"
  version "1.4.0"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

