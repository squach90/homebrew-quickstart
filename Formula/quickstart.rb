class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.4.4.tar.gz"
  sha256 "d37d736eb8523caddc091883e3bc9acb33e72e1ca5abf55fce8d79c10b52feb5"
  version "1.4.4"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

