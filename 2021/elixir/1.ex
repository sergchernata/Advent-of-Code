defmodule Day1 do
  def part1(input) do
    for {current, index} <- Enum.with_index(input) do
      if index + 1 < length(input) do
        current < Enum.at(input, index + 1)
      end
    end
    |> Enum.filter(& &1)
    |> length
  end

  def part2(input) do
    for {current, index} <- Enum.with_index(input) do
      if index + 3 < length(input) do
        second = Enum.at(input, index + 1)
        third = Enum.at(input, index + 2)
        fourth = Enum.at(input, index + 3)

        current + second + third < second + third + fourth
      end
    end
    |> Enum.filter(& &1)
    |> length
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day1.load("1.input.txt")

# 1548
input |> Day1.part1() |> IO.inspect()
# 1589
input |> Day1.part2() |> IO.inspect()
