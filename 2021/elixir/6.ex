defmodule Day do
  def part1(fish) do
    cycle_days(80, fish) |> length
  end

  def part2(fish) do
    cycle_days(256, fish) |> length
  end

  def cycle_days(1, fish), do: fish

  def cycle_days(days, fish) do
    fish = Enum.map(fish, &(&1 - 1))
    num_births = Enum.count(fish, fn f -> f == 0 end)
    fish = Enum.map(fish, fn f -> if f < 0, do: 6, else: f end)
    cycle_days(days - 1, fish ++ List.duplicate(9, num_births))
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body |> String.split(["\n", ","], trim: true) |> Enum.map(&String.to_integer/1)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("6.input.txt")

# 363101
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
