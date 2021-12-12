defmodule AdventOfCode.Year2021.Day02.Test do
  use ExUnit.Case
  @input "forward 5
down 5
forward 8
up 3
down 8
forward 2"

  test "part 1" do
    assert AdventOfCode.Year2021.Day02.part1(@input) == 150
  end

  test "part 2" do
    assert AdventOfCode.Year2021.Day02.part2(@input) == 900
  end
end
