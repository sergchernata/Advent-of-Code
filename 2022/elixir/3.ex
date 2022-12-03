defmodule Day do
  def part1(input) do
    input
    |> Enum.map(fn rucksack ->
      [c1, c2] = Enum.chunk_every(rucksack, round(length(rucksack) / 2))
      Enum.filter(c1, &(&1 in c2)) |> list_to_char() |> char_to_pos()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, c] ->
      Enum.filter(a, &(&1 in b && &1 in c)) |> list_to_char() |> char_to_pos()
    end)
    |> Enum.sum()
  end

  defp list_to_char(list) do
    list
    |> Enum.uniq()
    |> List.first()
    |> String.to_charlist()
    |> List.first()
  end

  defp char_to_pos(char) do
    cond do
      char > 64 && char < 91 -> char - 38
      true -> Kernel.rem(char, 32)
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, "", trim: true))

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("3.input.txt")

# 7691
input |> Day.part1() |> IO.inspect()
# 2508
input |> Day.part2() |> IO.inspect()
