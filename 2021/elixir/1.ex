defmodule Day1 do
  def part1(input) do
    input |> compare_in_pairs()
  end

  def part2(input) do
    trios =
      for {current, index} <- Enum.with_index(input) do
        if index + 2 < length(input) do
          second = Enum.at(input, index + 1)
          third = Enum.at(input, index + 2)

          {current, second, third}
        end
      end

    trios
    |> Enum.filter(&(&1 != nil))
    |> Enum.map(fn {a, b, c} -> a + b + c end)
    |> compare_in_pairs()
  end

  def compare_in_pairs(input) do
    input
    |> Enum.map(&[&1, &1])
    |> List.flatten()
    |> tl()
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
    |> Enum.chunk_every(2)
    |> Enum.reduce(0, fn [a, b], acc -> if a < b, do: acc + 1, else: acc end)
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
