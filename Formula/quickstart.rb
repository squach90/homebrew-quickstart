class Quickstart < Formula
  desc "Un CLI pour créer rapidement des projets HTML, Python, Node, etc."
  homepage "https://github.com/squach90/homebrew-quickstart"
  url "https://github.com/squach90/homebrew-quickstart/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "38c446f9a85aebaa44a8575aef623666b4b37f489a90c017ee13141563742964"
  version "1.0.0"

  def install
    bin.install "QuickStart.sh" => "quickstart"
  end
end

