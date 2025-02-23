require "formula_test_helper"

class QuickstartTest < FormulaTest
  def test_version
    assert_equal "1.5.3", shell_output("#{bin}/quickstart --version").chomp
  end

  def test_basic_functionality
    system "#{bin}/quickstart", "--help"
  end
end

