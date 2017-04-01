defmodule TrendspotterTest do
  use ExUnit.Case
  import Trendspotter
  doctest Trendspotter

  describe "Test get consecutive highs" do
    test "return first element" do
      assert [9] == get_consecutive_highs([9,7,4], 3)
    end

    test "return no element" do
      assert [] == get_consecutive_highs([2,7,4], 3)
    end

    test "return second element" do
      assert [9] == get_consecutive_highs([7,9,4,6], 3)
    end

    test "return two elements" do
      assert [9, 10] == get_consecutive_highs([9,7,4,6,3,10,1,2,4,5,9,7], 3) 
    end

    test "return all first elements" do
      assert [9, 10, 11] == get_consecutive_highs([9,1,2,10,1,2,11,1,2], 3)
    end

    test "should work for any n" do
      assert [18, 12, 6] == get_consecutive_highs(18..1, 6)
    end

    test "empty array" do
      assert [] == get_consecutive_highs([], 3)
    end

    test "zero consecutive" do
      assert [] == get_consecutive_highs([1,2,3], 0)
    end

    test "one consecutive" do
      assert [1,2,3] == get_consecutive_highs([1,2,3], 1)
    end
  end

  describe "Test get consecutive lows" do
    test "return first element" do
      assert [4] == get_consecutive_lows([4,7,9], 3)
    end

    test "return all first elements" do
      assert [1, 5, 7] == get_consecutive_lows([1,9,10,5,9,10,7,9,10], 3)
    end

    test "should work for any n" do
      assert [1, 7, 13] == get_consecutive_lows(1..18, 6)
    end

    test "empty array" do
      assert [] == get_consecutive_lows([], 3)
    end

    test "zero consecutive" do
      assert [] == get_consecutive_lows([1,2,3], 0)
    end

    test "one consecutive" do
      assert [1,2,3] == get_consecutive_lows([1,2,3], 1)
    end
  end
end
