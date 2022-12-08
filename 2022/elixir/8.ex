defmodule Day do
  def part1(input) do
    input
    |> inspect_visibility()
    |> List.flatten()
    |> Enum.filter(& &1)
    |> length()
  end

  def part2(input) do
    input
    |> measure_visibility()
    |> List.flatten()
    |> Enum.max()
  end

  defp inspect_visibility(grid) do
    for {row, y} <- Enum.with_index(grid) do
      for {col, x} <- Enum.with_index(row) do
        is_horizontal_edge = y == 0 || y == length(grid) - 1
        is_vertical_edge = x == 0 || x == length(row) - 1

        if is_horizontal_edge || is_vertical_edge do
          true
        else
          left = Enum.slice(row, 0..(x - 1)) |> Enum.max()
          right = Enum.slice(row, (x + 1)..(length(row) - 1)) |> Enum.max()

          top =
            Enum.slice(grid, 0..(y - 1))
            |> Enum.map(&Enum.at(&1, x))
            |> Enum.max()

          bottom =
            Enum.slice(grid, (y + 1)..(length(grid) - 1))
            |> Enum.map(&Enum.at(&1, x))
            |> Enum.max()

          col > left || col > right || col > top || col > bottom
        end
      end
    end
  end

  defp measure_visibility(grid) do
    for {row, y} <- Enum.with_index(grid) do
      for {col, x} <- Enum.with_index(row) do
        is_horizontal_edge = y == 0 || y == length(grid) - 1
        is_vertical_edge = x == 0 || x == length(row) - 1

        if is_horizontal_edge || is_vertical_edge do
          0
        else
          left =
            Enum.slice(row, 0..(x - 1))
            |> Enum.reverse()
            |> measure_visibility(col)

          right =
            Enum.slice(row, (x + 1)..(length(row) - 1))
            |> measure_visibility(col)

          top =
            Enum.slice(grid, 0..(y - 1))
            |> Enum.map(&Enum.at(&1, x))
            |> Enum.reverse()
            |> measure_visibility(col)

          bottom =
            Enum.slice(grid, (y + 1)..(length(grid) - 1))
            |> Enum.map(&Enum.at(&1, x))
            |> measure_visibility(col)

          left * right * top * bottom
        end
      end
    end
  end

  defp measure_visibility(list, max, score \\ 0)

  defp measure_visibility([], _max, score), do: score

  defp measure_visibility([hd | tl], max, score) do
    case hd < max do
      true -> measure_visibility(tl, max, score + 1)
      false -> score + 1
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n", trim: true)
        |> Enum.map(
          &(String.split(&1, "", trim: true)
            |> Enum.map(fn t -> String.to_integer(t) end))
        )

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("8.input.txt")

# 1684
input |> Day.part1() |> IO.inspect()
# 486540
input |> Day.part2() |> IO.inspect()
