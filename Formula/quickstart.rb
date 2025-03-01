class Quickstart < Formula
  desc "A CLI to quickly create HTML, Python, Node, etc. projects."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.5.5.tar.gz"
  sha256 "d66e3d5be2c370273ac0ffc49fd51be49a5ffe43418ec2c10dff70c5cb91df73"
  version "1.5.5"

  depends_on "gum"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

