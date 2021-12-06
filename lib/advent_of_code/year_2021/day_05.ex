defmodule AdventOfCode.Year2021.Day05 do
  def part1(args) do
    {width, vectors} = parse_args(args)
    # looked at input

    vectors
    |> Stream.filter(fn {x1, y1, x2, y2} -> x1 == x2 or y1 == y2 end)
    |> Enum.flat_map(&vec_to_indexlist(&1, width))
    # use a map, because list access is way too slow
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, fn x -> x + 1 end))
    |> Map.to_list()
    |> Enum.filter(&(elem(&1, 1) >= 2))
    |> Enum.count()
  end

  def part2(args) do
    {width, vectors} = parse_args(args)
    # looked at input

    vectors
    |> Enum.flat_map(&vec_to_indexlist(&1, width))
    # use a map, because list access is way too slow
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, fn x -> x + 1 end))
    |> Map.to_list()
    |> Enum.filter(&(elem(&1, 1) >= 2))
    |> Enum.count()
  end

  defp parse_args(string) do
    coords =
      string
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&parse_vector/1)

    width = Enum.flat_map(coords, &[elem(&1, 0), elem(&1, 2)]) |> Enum.max()
    {width + 1, coords}
  end

  defp parse_vector(line) do
    [x1, y1, x2, y2] =
      line
      |> String.split("->", trim: true)
      |> Enum.flat_map(&String.split(&1, [",", " "], trim: true))
      |> Enum.map(&String.to_integer(&1, 10))

    {x1, y1, x2, y2}
  end

  defp vec_to_indexlist({x1, y1, x2, y2} = _vec, width) do
    dx = x2 - x1
    dy = y2 - y1

    inverted = dy == -dx

    case {dx, dy, inverted} do
      {a, a, _} ->
        for z <- 0..a do
          pos_to_index({x1 + z, y1 + z}, width)
        end

      {a, _b, true} ->
        for z <- 0..a do
          pos_to_index({x1 + z, y1 - z}, width)
        end

      {a, 0, _} ->
        for z <- 0..a do
          pos_to_index({x1 + z, y1}, width)
        end

      {0, a, _} ->
        for z <- 0..a do
          pos_to_index({x1, y1 + z}, width)
        end

      _ ->
        []
    end
  end

  defp pos_to_index({x, y} = _pos, width) do
    x + y * width
  end

  def print_area(area, width, label \\ nil) do
    IO.puts(label)
    IO.puts("---")

    area
    |> Enum.map(fn
      0 -> " . "
      a -> " #{Integer.to_string(a, 10)} "
    end)
    |> Enum.chunk_every(width)
    |> Enum.map(&Enum.reduce(&1, "", fn x, a -> a <> x end))
    |> Enum.map(&IO.puts(&1))

    area
  end
end
