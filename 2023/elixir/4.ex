defmodule Day do
  def part1(input) do
    input
    |> Enum.map(&process_card/1)
    |> Enum.map(fn count ->
      cond do
        count <= 1 ->
          if count == 1, do: 1, else: 0

        true ->
          Integer.pow(2, count - 1)
      end
    end)
    |> Enum.sum()
  end

  def part2(input) do
    into = List.duplicate(1, length(input)) |> Enum.with_index(1)

    input
    |> Enum.map(&process_card/1)
    |> Enum.with_index(1)
    |> Enum.reduce(into, fn {count, index}, acc ->
      Enum.map(acc, fn {acc_count, acc_index} ->
        if acc_index > index and acc_index <= index + count do
          count = Enum.at(acc, index - 1) |> elem(0)
          {acc_count + count, acc_index}
        else
          {acc_count, acc_index}
        end
      end)
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def process_card(card) do
    [actual, winning] =
      String.split(card, " | ")
      |> Enum.map(fn part -> String.split(part) |> Enum.map(&String.to_integer(&1)) end)

    length(actual -- actual -- winning)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body |> String.split("\n") |> Enum.map(&(String.split(&1, ": ") |> List.last()))

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("5.input.txt")

# 24733
input |> Day.part1() |> IO.inspect()
# 5422730
input |> Day.part2() |> IO.inspect()
