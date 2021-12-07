defmodule Day do
  def part1([list, max]) do
    Enum.map(0..max, &Enum.reduce(list, 0, fn n, acc -> abs(n - &1) + acc end)) |> Enum.min()
  end

  def part2([list, max]) do
    Enum.map(0..max, &Enum.reduce(list, 0, fn n, acc -> fuel(n, &1) + acc end)) |> Enum.min()
  end

  def fuel(num, base), do: Enum.sum(Enum.to_list(1..abs(num - base)))

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        list = body |> String.split([","]) |> Enum.map(&String.to_integer/1)
        max = Enum.max(list)
        [list, max]

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("7.input.txt")

# 355592
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
