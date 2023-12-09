defmodule Day do
  def part1(input) do
    input
    |> Enum.map(fn sets ->
      calculate([sets]) |> Enum.map(&List.last(&1)) |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(fn sets ->
      calculate([sets])
      |> Enum.map(&List.first(&1))
      |> Enum.reverse()
      |> Enum.reduce(0, fn n, acc -> n - acc end)
    end)
    |> Enum.sum()
  end

  def calculate(sets) do
    set = List.last(sets)

    if Enum.all?(set, &(&1 == 0)) do
      sets
    else
      new_set = Enum.chunk_every(set, 2, 1, :discard) |> Enum.map(fn [a, b] -> b - a end)
      calculate(sets ++ [new_set])
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n")
        |> Enum.map(fn line ->
          String.split(line, " ", trim: true) |> Enum.map(&String.to_integer/1)
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("9.input.txt")

# 1743490457
input |> Day.part1() |> IO.inspect()
# 1053
input |> Day.part2() |> IO.inspect()
