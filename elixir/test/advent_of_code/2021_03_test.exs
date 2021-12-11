defmodule AdventOfCode.Year2021.Day03.Test do
  use ExUnit.Case

  test "part 1" do
    input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"
    res = AdventOfCode.Year2021.Day03.part1(input)

    assert res == 198
  end

  test "part 2" do
    input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"
    res = AdventOfCode.Year2021.Day03.part2(input)

    assert res == 230
  end
end
