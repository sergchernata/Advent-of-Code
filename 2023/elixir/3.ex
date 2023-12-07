defmodule Day do
  def part1(input) do
    Enum.with_index(input)
    |> Enum.reduce(input, fn {line, y}, acc ->
      Enum.with_index(line)
      |> Enum.each(fn {char, x} ->
        String.match?(char, ~r"\d") |> IO.inspect()
      end)

      acc
    end)
  end

  def part2(input) do
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n") |> Enum.map(&String.split(&1, "", trim: true))
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("3.input.txt")

#
input |> Day.part1() |> IO.inspect()
#
input |> Day.part2() |> IO.inspect()
