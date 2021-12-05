defmodule Day do
  def part1(lines) do
    Enum.map(lines, fn [[x1, y1], [x2, y2]] ->
      if x1 == x2 or y1 == y2 do
        for x <- x1..x2, y <- y1..y2, do: {x, y}
      end
    end)
    |> Enum.filter(&(&1 != nil))
    |> count_frequency_more_than(2)
  end

  def part2(lines) do
    Enum.map(lines, fn [[x1, y1], [x2, y2]] ->
      points = for x <- x1..x2, y <- y1..y2, do: {x, y}

      case x1 == x2 or y1 == y2 do
        true -> points
        false -> diagonalize(points, y1 < y2)
      end
    end)
    |> Enum.filter(&(length(&1) != 1))
    |> count_frequency_more_than(2)
  end

  def count_frequency_more_than(lines, limit) do
    List.flatten(lines)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.filter(&(&1 >= limit))
    |> length
  end

  def diagonalize(points, is_downward, final \\ [])

  def diagonalize([], _is_downward, final), do: final

  def diagonalize([point | points], is_downward, []),
    do: diagonalize(points, is_downward, [point])

  def diagonalize([{x2, y2} | points], is_downward, final) do
    {x1, y1} = hd(final)
    is_single_step = abs(x1 - x2) == 1 && abs(y1 - y2) == 1
    is_diagonal = x1 < x2 && ((is_downward && y2 > y1) || (!is_downward && y2 < y1))

    case is_single_step && is_diagonal do
      true -> diagonalize(points, is_downward, [{x2, y2} | final])
      false -> diagonalize(points, is_downward, final)
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        String.split(body, "\n")
        |> Enum.map(fn line ->
          String.split(line, [" -> ", ","])
          |> Enum.map(&String.to_integer/1)
          |> Enum.chunk_every(2)
          |> Enum.sort()
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("5.input.txt")

# 5698
input |> Day.part1() |> IO.inspect()
# 15463
input |> Day.part2() |> IO.inspect()
