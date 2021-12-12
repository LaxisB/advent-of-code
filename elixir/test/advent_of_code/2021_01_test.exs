defmodule AdventOfCode.Year2021.Day01.Test do
  use ExUnit.Case
  @input "199
200
208
210
200
207
240
269
260
263"

  test "part 1" do
    assert AdventOfCode.Year2021.Day01.part1(@input) == 7
  end

  test "part 2" do
    assert AdventOfCode.Year2021.Day01.part2(@input) == 5
  end
end
