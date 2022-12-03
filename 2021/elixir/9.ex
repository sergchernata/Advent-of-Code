defmodule Day do
  def part1(input) do
    for {row, row_index} <- Enum.with_index(input) do
      for {_col, col_index} <- Enum.with_index(row) do
        return_if_low_point(input, row_index, col_index)
      end
    end
    |> List.flatten()
    |> Enum.filter(& &1)
    |> Enum.reduce(0, fn n, acc -> acc + n + 1 end)
  end

  def part2(input) do
    for {row, row_index} <- Enum.with_index(input) do
      for {_col, col_index} <- Enum.with_index(row) do
        if return_if_low_point(input, row_index, col_index) != nil do
          {row_index, col_index}
        end
      end
    end
    |> List.flatten()
    |> Enum.filter(& &1)
    |> Enum.map(&(scan_basin(input, &1 |> IO.inspect()) |> length))
    |> Enum.sort(:desc)
    |> Enum.slice(0..2)
    |> Enum.reduce(fn n, acc -> n * acc end)
  end

  def return_if_low_point(input, row_index, col_index) do
    current = Enum.at(input, row_index, []) |> Enum.at(col_index)
    top = fetch_neighbor(input, row_index - 1, col_index)
    right = fetch_neighbor(input, row_index, col_index + 1)
    bottom = fetch_neighbor(input, row_index + 1, col_index)
    left = fetch_neighbor(input, row_index, col_index - 1)

    if current < top && current < right && current < bottom && current < left, do: current
  end

  def scan_basin(input, {row_index, col_index}) do
    updated_row = Enum.at(input, row_index) |> List.replace_at(col_index, 9)
    input = List.replace_at(input, row_index, updated_row)

    neighbors = [
      {row_index - 1, col_index},
      {row_index, col_index + 1},
      {row_index + 1, col_index},
      {row_index, col_index - 1}
    ]

    basin =
      for {r, c} <- neighbors do
        case fetch_neighbor(input, r, c) do
          9 -> {row_index, col_index}
          _ -> scan_basin(input, {r, c})
        end
      end

    [{row_index, col_index} | basin] |> List.flatten() |> Enum.uniq()
  end

  def fetch_neighbor(input, row_index, col_index) do
    num_rows = length(input)
    num_cols = length(hd(input))

    case row_index > -1 && col_index > -1 && row_index < num_rows && col_index < num_cols do
      true -> Enum.at(input, row_index) |> Enum.at(col_index)
      false -> 9
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n")
        |> Enum.map(fn row ->
          String.split(row, "", trim: true) |> Enum.map(&String.to_integer/1)
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("9.input.txt")

# 535
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
