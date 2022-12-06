defmodule Day do
  def part1(input) do
    input |> find_unique_group(4, 4)
  end

  def part2(input) do
    input |> find_unique_group(14, 14)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body |> String.split("", trim: true)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end

  defp find_unique_group(input, num_unique, position) do
    {group, _} = Enum.split(input, num_unique)

    case Enum.uniq(group) |> length() == num_unique do
      true -> position
      false -> find_unique_group(Enum.slice(input, 1..length(input)), num_unique, position + 1)
    end
  end
end

input = Day.load("6.input.txt")

# 1655
input |> Day.part1() |> IO.inspect()
# 2665
input |> Day.part2() |> IO.inspect()
