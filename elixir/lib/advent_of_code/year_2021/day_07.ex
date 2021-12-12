defmodule AdventOfCode.Year2021.Day07 do
  def part1(args) do
    parse_args(args)
    |> run(&calculate_cost_constant/2)
  end

  def part2(args) do
    parse_args(args)
    |> run(&calculate_cost_nth_triangle/2)
  end

  defp run(positions, cb) do
    {min, max} = Enum.min_max(positions)

    min..max
    |> Enum.map(&Task.async(fn -> cb.(positions, &1) end))
    |> Task.await_many()
    |> Enum.min()
  end

  defp calculate_cost_constant(positions, target) do
    positions
    |> Stream.map(&abs(&1 - target))
    |> Enum.sum()
  end

  defp calculate_cost_nth_triangle(positions, target) do
    positions
    |> Stream.map(&abs(&1 - target))
    |> Stream.map(&nth_triangle/1)
    |> Enum.sum()
  end

  defp nth_triangle(n) do
    (:math.pow(n, 2) + n) / 2
  end

  defp parse_args(string) do
    string
    |> String.split([",", "\n"], trim: true)
    |> Stream.map(&String.to_integer/1)
  end
end
