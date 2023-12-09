defmodule Day do
  def part1({directions, structure}) do
    traverse(directions, directions, structure, 0, "AAA")
  end

  def part2(input) do
  end

  def traverse(_original_dirs, _dirs, _structure, count, "ZZZ"), do: count

  def traverse(original_dirs, [dir | dirs], structure, count, branch) do
    dirs = if dirs == [], do: original_dirs, else: dirs
    traverse(original_dirs, dirs, structure, count + 1, Enum.at(structure[branch], dir))
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        [directions, structure] = body |> String.split("\n\n")

        structure =
          String.split(structure, "\n")
          |> Enum.map(fn x ->
            [parent, children] = String.split(x, " = ")
            %{parent => String.replace(children, ["(", ")"], "") |> String.split(", ")}
          end)
          |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc) end)

        directions =
          String.graphemes(directions) |> Enum.map(fn x -> if x == "L", do: 0, else: 1 end)

        {directions, structure}

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("8.input.txt")

# 18157
input |> Day.part1() |> IO.inspect()
#
input |> Day.part2() |> IO.inspect()
