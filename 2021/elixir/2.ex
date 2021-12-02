defmodule Day1 do
  def part1(input) do
    Enum.reduce(input, {0, 0}, fn line, {position, depth} ->
      [direction, amount] = String.split(line, " ", trim: true)
      amount = String.to_integer(amount)

      case [direction, amount] do
        ["forward", _] -> {position + amount, depth}
        ["down", _] -> {position, depth + amount}
        ["up", _] -> {position, depth - amount}
      end
    end)
    |> Tuple.to_list()
    |> Enum.reduce(fn d, p -> p * d end)
  end

  def part2(input) do
    Enum.reduce(input, {0, 0, 0}, fn line, {aim, position, depth} ->
      [direction, amount] = String.split(line, " ", trim: true)
      amount = String.to_integer(amount)

      case [direction, amount] do
        ["forward", _] -> {aim, position + amount, depth + aim * amount}
        ["down", _] -> {aim + amount, position, depth}
        ["up", _] -> {aim - amount, position, depth}
      end
    end)
    |> Tuple.to_list()
    |> tl()
    |> Enum.reduce(fn d, p -> p * d end)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n", trim: true)
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day1.load("2.input.txt")

# 2272262
input |> Day1.part1() |> IO.inspect()
# 2134882034
input |> Day1.part2() |> IO.inspect()
