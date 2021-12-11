defmodule AdventOfCode.Year2021.Day01 do
  def part1(args) do
    [h | t] = prepare_input(args)
    run(0, h, t)
  end

  def part2(args) do
    items = prepare_input(args)

    # pre-calc first sum
    thruple_sum =
      Enum.slice(items, 0..2)
      |> Enum.sum()

    run_sliding(0, thruple_sum, tl(items))
  end

  defp run(count, _, rem) when length(rem) < 1, do: count

  defp run(count, last_value, [head | tail] = _rem) do
    case head > last_value do
      true -> run(count + 1, head, tail)
      false -> run(count, head, tail)
    end
  end

  # stop when we can't build a full 3-item sum anymore
  defp run_sliding(count, _, rem) when length(rem) < 3, do: count

  defp run_sliding(count, last_value, rem) do
    thruple_sum = Enum.slice(rem, 0..2) |> Enum.sum()

    case thruple_sum > last_value do
      true -> run_sliding(count + 1, thruple_sum, tl(rem))
      false -> run_sliding(count, thruple_sum, tl(rem))
    end
  end

  @doc """
  convert a newline delimited string of integers to an int list
  """
  defp prepare_input(string) when is_binary(string) do
    String.split(string)
    |> Stream.map(&Integer.parse(&1, 10))
    |> Stream.filter(&(&1 != nil))
    |> Stream.map(&elem(&1, 0))
    |> Enum.to_list()
  end
end
