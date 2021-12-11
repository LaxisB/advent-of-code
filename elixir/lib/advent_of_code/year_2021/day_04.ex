defmodule AdventOfCode.Year2021.Day04 do
  alias AdventOfCode.Year2021.Day04.BingoBoard

  def part1(args) do
    {input, boards} = parse_args(args)

    winning_board = bingo(input, boards)

    sum_of_unmarked =
      BingoBoard.get_unmarked(winning_board)
      |> Enum.sum()

    sum_of_unmarked * hd(winning_board.picks)
  end

  def part2(args) do
    {input, boards} = parse_args(args)

    losing_board = inverse_bingo(input, boards)

    sum_of_unmarked =
      BingoBoard.get_unmarked(losing_board)
      |> Enum.sum()

    sum_of_unmarked * hd(losing_board.picks)
  end

  defp parse_args(string) do
    res = String.split(string, "\n\n", trim: true)

    parsed_input =
      hd(res)
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    parsed_boards =
      tl(res)
      |> Stream.flat_map(&String.split/1)
      |> Stream.map(&String.to_integer/1)
      |> Stream.chunk_every(25)
      |> Enum.map(&BingoBoard.create/1)

    {parsed_input, parsed_boards}
  end

  defp inverse_bingo([move | input] = _, boards) do
    updated_boards =
      boards
      |> Enum.map(&BingoBoard.update(&1, move))

    losers = Enum.filter(updated_boards, fn x -> x.won == false end)

    case losers do
      [] -> Enum.at(updated_boards, 0)
      _ -> inverse_bingo(input, losers)
    end
  end

  defp bingo([move | input] = _, boards) do
    updated_boards =
      boards
      |> Enum.map(&BingoBoard.update(&1, move))

    wins = Enum.filter(updated_boards, &Map.get(&1, :won, false))

    case wins do
      [board] -> board
      [board | _] -> board
      _ -> bingo(input, updated_boards)
    end
  end
end

defmodule AdventOfCode.Year2021.Day04.BingoBoard do
  @win_conditions [
    # rows
    [0, 1, 2, 3, 4],
    [5, 6, 7, 8, 9],
    [10, 11, 12, 13, 14],
    [15, 16, 17, 18, 19],
    [20, 21, 22, 23, 24],
    # cols
    [0, 5, 10, 15, 20],
    [1, 6, 11, 16, 21],
    [2, 7, 12, 17, 22],
    [3, 8, 13, 18, 13],
    [4, 9, 14, 19, 24]
  ]
  defstruct bet: [], picks: [], won: false

  @spec create(any) :: %AdventOfCode.Year2021.Day04.BingoBoard{bet: any, picks: []}
  def create(board) when length(board) != 25 do
    raise "can only create bingo boards of a 5x5 grid"
  end

  def create(board) do
    %__MODULE__{bet: board, picks: [], won: false}
  end

  def update(board, new_number) do
    new_picks = [new_number | board.picks]
    %__MODULE__{board | picks: new_picks, won: won?(board.bet, new_picks)}
  end

  def get_unmarked(board) do
    board.bet
    |> Stream.filter(fn x -> Enum.member?(board.picks, x) == false end)
    |> Enum.to_list()
  end

  def won?(bet, picks) do
    Enum.any?(@win_conditions, &condition_met(&1, bet, picks))
  end

  defp condition_met(condition, bet, picks) do
    condition
    |> Enum.map(&Enum.at(bet, &1))
    |> Enum.all?(&Enum.member?(picks, &1))
  end
end
