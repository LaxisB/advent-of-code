defmodule AdventOfCode.Year2021.Day01 do
  def part1(args) do
    prepare_input(args)
    |> List.foldl({nil, 0}, &aggregate/2)
    |> elem(1)
  end

  def part2(args) do
    items = prepare_input(args)

    thruple_sum =
      Enum.slice(items, 0..2)
      |> Enum.sum()

    aggregate_sliding_window(0, thruple_sum, tl(items))
  end

  defp aggregate(x, {last, count}) do
    case {x, last} do
      {_, nil} -> {x, 0}
      {x, y} when x > y -> {x, count + 1}
      _ -> {x, count}
    end
  end

  defp aggregate_sliding_window(count, _, rem) when length(rem) < 3, do: count

  defp aggregate_sliding_window(count, last_value, rem) do
    thruple_sum = Enum.slice(rem, 0..2) |> Enum.sum()

    case thruple_sum > last_value do
      true -> aggregate_sliding_window(count + 1, thruple_sum, tl(rem))
      false -> aggregate_sliding_window(count, thruple_sum, tl(rem))
    end
  end

  defp prepare_input(string) when is_binary(string) do
    String.split(string)
    |> Stream.map(&string_to_int(&1))
    |> Stream.filter(&(&1 != nil))
    |> Enum.to_list()
  end

  defp string_to_int(part) do
    case Integer.parse(part, 10) do
      {int, _rem} -> int
      :error -> nil
    end
  end
end
