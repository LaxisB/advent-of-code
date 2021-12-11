defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @moduledoc """
  runs  the script for the advent of code for the given day and year

      mix aoc [--day DAY] [--year YEAR] [--part PART]

  A `--day` or `-d` option can be given to specify a specific day to run. If not set, it will default to:

   - the current day during december
   - the 1st otherwise

  A `--year` or `-y` option can be used to run years other than the current one.any()

  A `--part` or `-p` option can be used to reduce the parts to run to a specific one. By default both parts are executed
  """

  @shortdoc "Run a given Advent of Code problem"

  @impl Mix.Task
  def run(args) do
    {options, _argv, _errors} =
      OptionParser.parse(args,
        aliases: [d: :day, y: :year, p: :part],
        strict: [day: :integer, year: :integer, part: :integer]
      )

    today = DateTime.utc_now(Calendar.ISO)

    year = Keyword.get(options, :year, today.year)
    day = Keyword.get(options, :day, if(today.month == 12, do: today.day, else: 1))
    part = Keyword.get(options, :part, nil)

    with year_string <- "Year#{year}",
         day_string <- "Day" <> String.pad_leading("#{day}", 2, "0"),
         module <- Module.concat([AdventOfCode, year_string, day_string]),
         {:module, _} <- Code.ensure_compiled(module),
         input <- AdventOfCode.Input.get!(day, year) do
      parts =
        case part do
          1 -> [1]
          2 -> [2]
          _ -> [1, 2]
        end

      for part <- parts do
        run_part(module, input, part)
        |> IO.inspect(label: "Year #{year} Day #{day} Part #{part}")
      end
    else
      {:error, :nofile} ->
        IO.puts("the module for your given day/year combo does not exist. did you create it?")

      e ->
        IO.puts(e, label: "unhandled exit")
    end
  end

  defp run_part(module, input, part) do
    part_atom = String.to_atom("part#{part}")
    apply(module, part_atom, [input])
  end
end
