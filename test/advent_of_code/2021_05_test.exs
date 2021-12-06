defmodule AdventOfCode.Year2021.Day04.Test do
  use ExUnit.Case
  @input "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"

  test "part 1" do
    res = AdventOfCode.Year2021.Day05.part1(@input)
    assert res == 5
  end

  @skip
  test "part 2" do
    res = AdventOfCode.Year2021.Day05.part2(@input)
    assert res == 12
  end
end
