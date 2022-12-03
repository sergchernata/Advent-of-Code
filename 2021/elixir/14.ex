defmodule Day do
  def part1([template, insertions]) do
    frequencies = cycle(template, insertions, 10)
    Enum.max(frequencies) - Enum.min(frequencies)
  end

  def part2([template, insertions]) do
    frequencies = cycle(template, insertions, 40)
    Enum.max(frequencies) - Enum.min(frequencies)
  end

  def cycle(template, _insertions, 0) do
    template |> Enum.frequencies() |> Enum.map(fn {_char, count} -> count end)
  end

  def cycle(template, insertions, steps) do
    for {current, index} <- Enum.with_index(template) do
      next = Enum.at(template, index + 1, "")

      [_pair, insert] =
        Enum.find(insertions, ["", ""], fn [pair, _insert] -> pair == "#{current}#{next}" end)

      [current, insert]
    end
    |> List.flatten()
    |> Enum.filter(&(&1 != ""))
    |> cycle(insertions, steps - 1)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        [template, insertions] = String.split(body, "\n\n")

        template = String.split(template, "", trim: true)

        insertions =
          String.split(insertions, "\n")
          |> Enum.map(fn insert -> String.split(insert, " -> ") end)

        [template, insertions]

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("14.input.txt")

# 3342
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
