# Advent of code

forked from https://github.com/mhanberg/advent-of-code-elixir-starter

## Setup

1. clone this repo
2. enter your advent of code session key in config/secret.exs (check template below)
3. run mix deps.get && mix compile

## Usage

1. Write your implementation (you can copy the template from day_00.ex and adjust it)
2. run `mix aoc` with the current day and year to get your answers


`mix aoc` automatically defaults to the curreny year and day (only if in december). so during AOC, you can just call `mix aoc` to automatically run both problem parts of the day



## adding secrets

this fork is has the automatic input gathering from the original repo hardwired.
create the file `config/secret.exs` and paste the following code:
```elixir
import Config

config :advent_of_code, AdventOfCode.Input,
  session_cookie: "<your session cookie"

```
(obviously insert your own cookie here)
