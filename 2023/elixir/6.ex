defmodule Day do
  def part1(input) do
    List.zip(input)
    |> Enum.map(&simulate/1)
    |> Enum.map(&length/1)
    |> Enum.product()
  end

  def part2(input) do
    Enum.map(input, &(Enum.join(&1) |> String.to_integer()))
    |> List.to_tuple()
    |> simulate()
    |> length()
  end

  def simulate({time, distance}) do
    Enum.map(1..time, fn duration ->
      if (time - duration) * duration > distance, do: duration
    end)
    |> Enum.filter(&(&1 != nil))
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n")
        |> Enum.map(fn line ->
          String.split(line, " ", trim: true) |> tl() |> Enum.map(&String.to_integer/1)
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("6.input.txt")

# 170000
input |> Day.part1() |> IO.inspect()
# 20537782
input |> Day.part2() |> IO.inspect()
