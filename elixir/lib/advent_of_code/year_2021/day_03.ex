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

    oxy = calculate_oxygen(items)
    co2 = calculate_co2(items)

    oxy_int = String.to_integer(oxy, 2)
    co2_int = String.to_integer(co2, 2)

    oxy_int * co2_int
  end

  def calculate_oxygen(items), do: reduce(items, "", fn x -> if x >= 0, do: "1", else: "0" end)

  # remember that we need least often
  def calculate_co2(items), do: reduce(items, "", fn x -> if x >= 0, do: "0", else: "1" end)

  def reduce(items, _, _) when length(items) < 2, do: hd(items)

  def reduce(items, mask, sum_to_mask) do
    offset = String.length(mask)

    bit_sum =
      Enum.reduce(items, 0, fn x, agg ->
        if String.at(x, offset) == "1", do: agg + 1, else: agg - 1
      end)

    new_mask = mask <> sum_to_mask.(bit_sum)
    new_items = Enum.filter(items, &String.starts_with?(&1, new_mask))
    reduce(new_items, new_mask, sum_to_mask)
  end

  defp binary_mode(list) do
    avg = Enum.sum(list) / Enum.count(list)

    case avg >= 0.5 do
      true -> 1
      false -> 0
    end
  end

  defp parse_args(string) do
    lines =
      string
      |> String.split()

    # assume uniform row size
    cols = String.length(Enum.at(lines, 0))

    {lines, Enum.count(lines), cols}
  end

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
