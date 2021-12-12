defmodule AdventOfCode.Year2021.Day06.Test do
  use ExUnit.Case
  @input "3,4,3,1,2"

  test "part 1" do
    assert AdventOfCode.Year2021.Day06.part1(@input) == 5934
  end

  test "part 2" do
    assert AdventOfCode.Year2021.Day06.part2(@input) == 26_984_457_539
  end
end
