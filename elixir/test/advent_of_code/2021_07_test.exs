defmodule AdventOfCode.Year2021.Day07.Test do
  use ExUnit.Case
  @input "16,1,2,0,4,2,7,1,2,14"

  test "part 1" do
    assert AdventOfCode.Year2021.Day07.part1(@input) == 37
  end

  test "part 2" do
    assert AdventOfCode.Year2021.Day07.part2(@input) == 168
  end
end
