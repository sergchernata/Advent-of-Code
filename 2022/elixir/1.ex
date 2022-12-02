defmodule Day do
  def part1(input) do
    input |> Enum.max()
  end

  def part2(input) do
    input |> Enum.sort() |> Enum.reverse() |> Enum.slice(0..2) |> Enum.sum()
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n\n")
        |> Enum.map(&(String.split(&1, "\n") |> Enum.map(fn n -> String.to_integer(n) end)))
        |> Enum.map(&Enum.sum(&1))
        |> List.flatten()

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("1.input.txt")

# 74394
input |> Day.part1() |> IO.inspect()
# 212836
input |> Day.part2() |> IO.inspect()
