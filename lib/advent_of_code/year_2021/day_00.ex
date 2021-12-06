defmodule AdventOfCode.Year2021.Day00 do
  def part1(args) do
    _ = parse_args(args)
  end

  def part2(args) do
    _ = parse_args(args)
  end

  defp parse_args(string) do
    string
    |> Stream.map(&String.to_integer/1)
  end
end
