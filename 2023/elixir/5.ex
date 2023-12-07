defmodule Day do
  def part1([seeds, instructions]) do
    seeds
    |> Enum.map(fn seed ->
      traverse(seed, instructions, "seed-to-soil")
      |> traverse(instructions, "soil-to-fertilizer")
      |> traverse(instructions, "fertilizer-to-water")
      |> traverse(instructions, "water-to-light")
      |> traverse(instructions, "light-to-temperature")
      |> traverse(instructions, "temperature-to-humidity")
      |> traverse(instructions, "humidity-to-location")
    end)
    |> List.flatten()
    |> Enum.min()
  end

  def part2(input) do
    # input
  end

  def traverse(target, instructions, step) do
    instructions[step]
    |> Enum.map(fn %{source: source, dest: dest} ->
      if target in source do
        Enum.at(dest, Enum.find_index(source, &(&1 == target)))
      end
    end)
    |> Enum.filter(&(&1 != nil))
    |> case do
      [] -> target
      found -> found |> hd()
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        [seeds | instructions] = body |> String.split("\n\n")

        seeds =
          seeds
          |> String.split(": ")
          |> List.last()
          |> String.split(" ")
          |> Enum.map(&String.to_integer/1)

        instructions =
          instructions
          |> Enum.map(fn i ->
            [label, maps] = String.split(i, " map:\n")

            maps =
              maps
              |> String.split("\n", trim: true)
              |> Enum.map(fn map ->
                [dest, source, length] =
                  String.split(map, " ", trim: true) |> Enum.map(&String.to_integer/1)

                %{dest: dest..(dest + length - 1), source: source..(source + length - 1)}
              end)

            %{label => maps}
          end)
          |> Enum.reduce(&Map.merge(&1, &2))

        [seeds, instructions]

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("5.input.txt")

# 322500873
input |> Day.part1() |> IO.inspect(charlists: :as_lists)
#
input |> Day.part2() |> IO.inspect(charlists: :as_lists)
