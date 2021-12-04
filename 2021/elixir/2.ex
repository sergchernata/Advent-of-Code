defmodule Day do
  def part1(input) do
    Enum.reduce(input, {0, 0}, fn line, {position, depth} ->
      [direction, amount] = String.split(line, " ", trim: true)
      amount = String.to_integer(amount)

      case direction do
        "forward" -> {position + amount, depth}
        "down" -> {position, depth + amount}
        "up" -> {position, depth - amount}
      end
    end)
    |> Tuple.to_list()
    |> Enum.reduce(fn d, p -> p * d end)
  end

  def part2(input) do
    Enum.reduce(input, {0, 0, 0}, fn line, {aim, position, depth} ->
      [direction, amount] = String.split(line, " ", trim: true)
      amount = String.to_integer(amount)

      case direction do
        "forward" -> {aim, position + amount, depth + aim * amount}
        "down" -> {aim + amount, position, depth}
        "up" -> {aim - amount, position, depth}
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

input = Day.load("2.input.txt")

# 2272262
input |> Day.part1() |> IO.inspect()
# 2134882034
input |> Day.part2() |> IO.inspect()
