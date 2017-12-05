require 'minitest/autorun'
require_relative "goldilocks.rb"

class GoldilocksTest < Minitest::Test
  def setup
    @goldilocks = Goldilocks.new
    @input = [[100, 80], [30, 50], [130, 75], [90,60], [150, 85], [120, 70], [200, 200], [110, 100]]
  end

  def test_goldi_calculator
    assert_equal([2, 5], @goldilocks.goldi_calculator(@input))
  end
end