class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "c7ebaa8576023ef377ffed9bcf458998fc9a55a3fa1255adbfaad94ed8187f1a"
  version "1.3.0"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

