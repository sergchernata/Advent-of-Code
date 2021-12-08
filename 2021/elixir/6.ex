defmodule Day do
  def part1(ages) do
    cycle_days(ages, 80)
  end

  def part2(ages) do
    cycle_days(ages, 256)
  end

  def cycle_days(ages, 0), do: Enum.map(ages, fn {_age, count} -> count end) |> Enum.sum()

  def cycle_days(ages, days) do
    num_new = Map.new(ages) |> Map.get(0, 0)

    Enum.map(ages, fn {age, count} ->
      case age - 1 do
        6 -> {6, count + num_new}
        -1 -> {8, num_new}
        age -> {age, count}
      end
    end)
    |> cycle_days(days - 1)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        ages = String.split(body, ",") |> Enum.map(&String.to_integer/1)
        Enum.to_list(0..8) |> Enum.map(&{&1, Map.get(Enum.frequencies(ages), &1, 0)})

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("6.input.txt")

# 363101
input |> Day.part1() |> IO.inspect()
# 1644286074024
input |> Day.part2() |> IO.inspect()
