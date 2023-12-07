defmodule Day do
  def part1(input) do
    limit = %{
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }

    input
    |> Enum.with_index(1)
    |> Enum.map(fn {line, index} ->
      result =
        String.split(line, ":", trim: true)
        |> List.last()
        |> String.split(";", trim: true)
        |> Enum.map(fn x ->
          String.split(x, ",", trim: true)
          |> Enum.map(fn set ->
            [count, color] = String.split(set, " ", trim: true)
            limit[color] >= String.to_integer(count)
          end)
        end)
        |> List.flatten()

      {result, index}
    end)
    |> Enum.reject(fn {result, _} -> Enum.any?(result, &(&1 == false)) end)
    |> Enum.map(fn {_, index} -> index end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(fn line ->
      result =
        String.split(line, ":", trim: true)
        |> List.last()
        |> String.split(";", trim: true)
        |> Enum.reduce(%{"red" => 0, "green" => 0, "blue" => 0}, fn round, acc ->
          String.split(round, ",", trim: true)
          |> Enum.map(fn set ->
            [count, color] = String.split(set, " ", trim: true)

            if String.to_integer(count) > acc[color] do
              Map.put(acc, color, String.to_integer(count))
            else
              acc
            end
          end)
          |> Enum.reduce(fn map, acc ->
            Map.merge(map, acc, fn _k, v1, v2 ->
              if v1 > v2, do: v1, else: v2
            end)
          end)
        end)
        |> Map.values()
        |> Enum.product()
    end)
    |> Enum.sum()
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n")
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("2.input.txt")

# 2776
input |> Day.part1() |> IO.inspect()
# 68638
input |> Day.part2() |> IO.inspect()
