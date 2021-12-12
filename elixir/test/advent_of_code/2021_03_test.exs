defmodule AdventOfCode.Year2021.Day03.Test do
  use ExUnit.Case
  @input "00100
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

  test "part 1" do
    assert AdventOfCode.Year2021.Day03.part1(@input) == 198
  end

  test "part 2" do
    assert AdventOfCode.Year2021.Day03.part2(@input) == 230
  end
end
