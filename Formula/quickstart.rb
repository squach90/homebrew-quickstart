class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/releases/tag/v1.4.1"
  sha256 "62ee6fa53fffff553e890ef24f3fba278b84e67ef46dee33a5f22d36c7e675cd"
  version "1.4.1"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

