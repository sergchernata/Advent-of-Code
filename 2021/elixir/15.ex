defmodule Day do
  def part1(input) do
    [{0, 1}, {1, 0}]
    |> Enum.map(fn {next_y, next_x} ->
      traverse({next_y, next_x}, input)
    end)
    |> List.flatten()
    |> Enum.min()
  end

  def part2(_input) do
  end

  def traverse({curr_y, curr_x}, grid, path \\ []) do
    case curr_y != length(grid) && curr_x != length(hd(grid)) do
      true ->
        [
          {curr_y, curr_x + 1},
          {curr_y + 1, curr_x}
        ]
        |> Enum.map(fn {y, x} ->
          traverse({y, x}, grid, path ++ [{curr_y, curr_x}])
        end)

      false ->
        if Enum.member?(path, {length(grid) - 1, length(hd(grid)) - 1}) do
          path |> Enum.map(fn {y, x} -> Enum.at(grid, y) |> Enum.at(x) end) |> Enum.sum()
        else
          nil
        end
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        String.split(body, "\n")
        |> Enum.map(fn line ->
          String.split(line, "", trim: true) |> Enum.map(&String.to_integer/1)
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("15.input.txt")

#
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
