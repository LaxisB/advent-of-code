defmodule AdventOfCode.Year2021.Day06 do
  def part1(args) do
    cells = parse_args(args)

    tick(cells, 80)
    |> Map.to_list()
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def part2(args) do
    cells = parse_args(args)

    tick(cells, 256)
    |> Map.to_list()
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp tick(cells, 0), do: cells

  @spec tick(list(integer()), integer()) :: list(integer())
  defp tick(cells, days_until_doom) do
    updated_cells =
      cells
      |> Enum.sort_by(&elem(&1, 1))
      |> Enum.flat_map(fn
        {0, x} -> [{8, x}, {6, x}]
        {a, x} -> [{a - 1, x}]
      end)
      |> Enum.reduce(%{}, &put_map/2)

    tick(updated_cells, days_until_doom - 1)
  end

  def put_map({key, count}, map) do
    Map.update(map, key, count, &(&1 + count))
  end

  @spec parse_args(String.t()) :: map()
  defp parse_args(string) do
    string
    |> String.replace("\n", "")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end
end
