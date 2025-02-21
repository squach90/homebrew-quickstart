class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.4.5.tar.gz"
  sha256 "63a748b4a4ba3953beb7e77e27ae8f53b3ed14a877ecd1bbe6263733af2e0561"
  version "1.4.5"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

