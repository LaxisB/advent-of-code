defmodule AdventOfCode.Year2021.Day02 do
  @doc "iterate over a list of movement and calculate the final position"
  def part1(args) do
    args
    |> parse_args
    |> Enum.reduce({0, 0}, &aggregate_position/2)
    |> (fn {x, y} -> x * y end).()
  end

  @doc "iterate over a list of movement and calculate the final position. measurements don't directly change the state"
  def part2(args) do
    args
    |> parse_args
    |> Enum.reduce({0, 0, 0}, &aggregate_position_part2/2)
    |> (fn {x, y, _} -> x * y end).()
  end

  def aggregate_position(change, {x, y} = _agg) do
    case change do
      {"forward", dx} -> {x + dx, y}
      {"down", dy} -> {x, y + dy}
      {"up", dy} -> {x, y - dy}
    end
  end

  def aggregate_position_part2(change, {x, y, a} = _agg) do
    case change do
      {"forward", dx} -> {x + dx, y + a * dx, a}
      {"down", da} -> {x, y, a + da}
      {"up", da} -> {x, y, a - da}
    end
  end

  def parse_args(input) do
    input
    |> String.split()
    |> Stream.chunk_every(2)
    |> Stream.map(fn [dir, amount] ->
      {dir, String.to_integer(amount)}
    end)
  end
end
