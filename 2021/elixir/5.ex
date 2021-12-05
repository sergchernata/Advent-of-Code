defmodule Day do
  def part1(lines) do
    Enum.map(lines, fn [[x1, y1], [x2, y2]] ->
      if x1 == x2 or y1 == y2 do
        for x <- x1..x2, y <- y1..y2, do: {x, y}
      end
    end)
    |> Enum.filter(&(&1 != nil))
    |> frequency_more_than(2)
  end

  def part2(lines) do
    Enum.map(lines, fn [[x1, y1], [x2, y2]] ->
      points = for x <- x1..x2, y <- y1..y2, do: {x, y}

      if x1 == x2 or y1 == y2 do
        points
      else
        dir = if y1 < y2, do: :down, else: :up
        diagonalize(points, dir)
      end
    end)
    |> Enum.filter(&(length(&1) != 1))
    |> frequency_more_than(2)
  end

  def frequency_more_than(lines, threshold) do
    List.flatten(lines)
    |> Enum.frequencies()
    |> Enum.filter(fn {_, c} -> c >= threshold end)
    |> length
  end

  def diagonalize(points, dir, final \\ [])

  def diagonalize([], _dir, final), do: final

  def diagonalize([point | points], dir, []), do: diagonalize(points, dir, [point])

  def diagonalize([{x2, y2} | points], dir, final) do
    {x1, y1} = hd(final)
    is_single_step = abs(x1 - x2) == 1 && abs(y1 - y2) == 1

    is_diagonal = x1 < x2 && ((dir == :down && y2 > y1) || (dir == :up && y2 < y1))

    case is_single_step && is_diagonal do
      true -> diagonalize(points, dir, [{x2, y2} | final])
      false -> diagonalize(points, dir, final)
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        String.split(body, "\n")
        |> Enum.map(fn line ->
          String.split(line, " -> ")
          |> Enum.map(&String.split(&1, ","))
          |> Enum.map(fn point -> Enum.map(point, &String.to_integer/1) end)
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
