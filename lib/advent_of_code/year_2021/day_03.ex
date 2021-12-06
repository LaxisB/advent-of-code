defmodule AdventOfCode.Year2021.Day03 do
  def part1(args) do
    {items, lines, cols} = parse_args(args)
    rotated = rotate(items, lines, cols)

    gamma =
      Stream.map(rotated, &binary_mode/1)
      |> Enum.to_list()
      |> Integer.undigits(2)

    mask = round(:math.pow(2, cols)) - 1

    epsilon = Bitwise.bxor(gamma, mask)

    gamma * epsilon
  end

  def part2(args) do
    {items, _lines, _cols} = parse_args(args)

    oxy = incremental_filter(items, &max/2, "1", 0)
    co2 = incremental_filter(items, &min/2, "0", 0)

    oxy_int = String.to_integer(oxy, 2)
    co2_int = String.to_integer(co2, 2)

    oxy_int * co2_int
  end

  def calculate_ogygen(items), do: incremental_filter(items, &max/2, "1")

  def calculate_co2(items), do: incremental_filter(items, &min/2, "0")

  def incremental_filter(items, selector, default),
    do: incremental_filter(items, selector, default, 0)

  def incremental_filter(items, _, _, _) when length(items) == 1, do: hd(items)

  def incremental_filter(items, _, _, _) when length(items) == 0,
    do: raise("should've stopped earlier")

  def incremental_filter(items, selector, default, pos) do
    # calculate which bit value were interested in
    [f1 | [f2]] =
      items
      |> Enum.map(&String.at(&1, pos))
      |> Enum.frequencies()
      |> Map.to_list()

    bit_condition =
      cond do
        elem(f1, 1) == elem(f2, 1) -> default
        elem(f1, 1) == selector.(elem(f1, 1), elem(f2, 1)) -> elem(f1, 0)
        true -> elem(f2, 0)
      end

    filtered = Enum.filter(items, &(String.at(&1, pos) == bit_condition))

    incremental_filter(filtered, selector, default, pos + 1)
  end

  defp binary_mode(list) do
    avg = Enum.sum(list) / Enum.count(list)

    case avg >= 0.5 do
      true -> 1
      false -> 0
    end
  end

  @spec parse_args(String.t()) :: {list(integer()), integer(), integer()}
  defp parse_args(string) do
    lines =
      string
      |> String.split()

    # assume uniform row size
    cols = String.length(Enum.at(lines, 0))

    {lines, Enum.count(lines), cols}
  end

  @spec rotate(list(String.t()), integer, integer) :: list(list(integer))
  defp rotate(lines, rows, cols) do
    items =
      lines
      |> Stream.flat_map(&String.split(&1, "", trim: true))
      |> Stream.map(&String.to_integer/1)
      |> Enum.to_list()

    # rotate matrix
    rotated =
      for c <- 0..(cols - 1), r <- 0..(rows - 1) do
        Enum.at(items, r * cols + c)
      end

    Enum.chunk_every(rotated, rows)
  end
end
