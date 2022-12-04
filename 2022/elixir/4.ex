defmodule Day do
  def part1(input) do
    input
    |> Enum.map(fn [a, b] ->
      Enum.all?(a, fn x -> x in b end)
    end)
    |> Enum.filter(& &1)
    |> length()
  end

  def part2(input) do
    input
    |> Enum.map(fn [a, b] ->
      Enum.any?(a, fn x -> x in b end)
    end)
    |> Enum.filter(& &1)
    |> length()
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n", trim: true)
        |> Enum.map(&String.split(&1, ",", trim: true))
        |> Enum.map(fn [r1, r2] ->
          [r1a, r1b] = String.split(r1, "-") |> Enum.map(&String.to_integer(&1))
          [r2a, r2b] = String.split(r2, "-") |> Enum.map(&String.to_integer(&1))

          [Enum.to_list(r1a..r1b), Enum.to_list(r2a..r2b)] |> Enum.sort_by(&length/1)
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("4.input.txt")

# 
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
