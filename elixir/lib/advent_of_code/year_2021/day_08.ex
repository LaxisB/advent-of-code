defmodule AdventOfCode.Year2021.Day08 do
  @doc """
  segment mapping
    0:      1:      2:      3:      4:
   aaaa    ....    aaaa    aaaa    ....
  b    c  .    c  .    c  .    c  b    c
  b    c  .    c  .    c  .    c  b    c
   ....    ....    dddd    dddd    dddd
  e    f  .    f  e    .  .    f  .    f
  e    f  .    f  e    .  .    f  .    f
   gggg    ....    gggg    gggg    ....

    5:      6:      7:      8:      9:
   aaaa    aaaa    aaaa    aaaa    aaaa
  b    .  b    .  .    c  b    c  b    c
  b    .  b    .  .    c  b    c  b    c
   dddd    dddd    ....    dddd    dddd
  .    f  e    f  .    f  e    f  .    f
  .    f  e    f  .    f  e    f  .    f
   gggg    gggg    ....    gggg    gggg
  """

  def part1(args) do
    lines = parse_args(args)

    Enum.flat_map(lines, &solve_line/1)
    |> Enum.filter(&(&1 == 1 or &1 == 4 or &1 == 7 or &1 == 8))
    |> Enum.count()
  end

  def part2(args) do
    parse_args(args)
    |> Enum.map(&solve_line/1)
    |> Enum.map(&Integer.undigits(&1))
    |> Enum.sum()
  end

  def solve_line({patterns, output} = _line) do
    # returns sorted patterns and output
    {patterns, output}

    # 1 is the only number with 2 segments
    one = Enum.at(patterns, 0)
    # 4 only with 4
    four = Enum.at(patterns, 2)
    # 7 is only number with  3
    seven = Enum.at(patterns, 1)
    # and 8 is the only with all
    eight = Enum.at(patterns, 9)

    # at this point 2,3,5,6, and 9 are unknown

    # `7` and `1` only differ in the `a` segment

    # 0, 6 and 9 have 6 active segments
    zero_six_nine = Enum.filter(patterns, &(MapSet.size(&1) === 6))

    # we can get 6, because it's the one that doesn't overlap with 1
    six = Enum.filter(zero_six_nine, &(MapSet.subset?(one, &1) == false)) |> Enum.at(0)
    zero_nine = Enum.filter(zero_six_nine, &MapSet.subset?(one, &1))

    # and split [09] by checking overlap with 4
    nine = Enum.filter(zero_nine, &MapSet.subset?(four, &1)) |> Enum.at(0)
    zero = Enum.filter(zero_nine, &(MapSet.subset?(four, &1) == false)) |> Enum.at(0)

    # so now we know all wire mappings
    wire_for_a = MapSet.difference(seven, one)
    wire_for_d = MapSet.difference(eight, zero)
    wire_for_b = MapSet.difference(four, MapSet.union(one, wire_for_d))
    wire_for_c = MapSet.difference(eight, six)
    wire_for_e = MapSet.difference(eight, nine)
    wire_for_f = MapSet.difference(one, wire_for_c)

    all_but_g =
      wire_for_a
      |> MapSet.union(wire_for_b)
      |> MapSet.union(wire_for_c)
      |> MapSet.union(wire_for_d)
      |> MapSet.union(wire_for_e)
      |> MapSet.union(wire_for_f)

    wire_for_g = MapSet.difference(eight, all_but_g)

    wires_for_two = union_all([wire_for_a, wire_for_c, wire_for_d, wire_for_e, wire_for_g])
    wires_for_three = union_all([wire_for_a, wire_for_c, wire_for_d, wire_for_f, wire_for_g])
    wires_for_five = union_all([wire_for_a, wire_for_b, wire_for_d, wire_for_f, wire_for_g])

    # we already know 1,4,6,7,8,9,0
    two = Enum.filter(patterns, &MapSet.subset?(wires_for_two, &1)) |> Enum.at(0)
    three = Enum.filter(patterns, &MapSet.subset?(wires_for_three, &1)) |> Enum.at(0)
    five = Enum.filter(patterns, &MapSet.subset?(wires_for_five, &1)) |> Enum.at(0)

    lookup = [zero, one, two, three, four, five, six, seven, eight, nine]

    output
    |> Enum.map(&find_in_lookup(&1, lookup))
  end

  defp union_all(sets), do: Enum.reduce(sets, &MapSet.union(&1, &2))

  defp find_in_lookup(set, lookup), do: Enum.find_index(lookup, &MapSet.equal?(&1, set))

  def parse_args(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.filter(&String.length/1)
    |> Enum.map(&parse_line/1)
  end

  def parse_line(string) do
    [patterns, output] = String.split(string, "|", trim: true)

    # convert patterns into sorted list of sets
    patterns =
      String.split(patterns, " ", trim: true)
      |> Stream.map(&MapSet.new(String.split(&1, "")))
      |> Stream.map(&MapSet.delete(&1, ""))
      |> Enum.to_list()
      |> Enum.sort_by(&MapSet.size/1)

    # convert output into list of sets
    output =
      String.trim(output)
      |> String.split(" ", trim: true)
      |> Enum.map(fn x -> MapSet.new(String.split(x, "", trim: true)) end)

    {patterns, output}
  end
end
