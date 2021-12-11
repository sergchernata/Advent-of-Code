defmodule Day do
  def part1(input) do
    simulate_steps(input, 100, 0)
  end

  def part2(input) do
    simulate_steps(input, 0, 0, List.flatten(input) |> length)
  end

  def simulate_steps(input, steps, flashes, input_length \\ false)

  def simulate_steps(_input, 0, flashes, false), do: flashes

  def simulate_steps(_input, steps, flashes, input_length) when input_length == flashes, do: steps

  def simulate_steps(input, steps, flashes, input_length) do
    input =
      Enum.map(input, fn row -> Enum.map(row, fn col -> col + 1 end) end)
      |> simulate_flashes()

    new_flashes = List.flatten(input) |> Enum.filter(&(&1 == 0)) |> length

    if input_length do
      simulate_steps(input, steps + 1, new_flashes, input_length)
    else
      simulate_steps(input, steps - 1, flashes + new_flashes)
    end
  end

  def simulate_flashes(input) do
    Enum.flat_map(Enum.with_index(input), fn {row, row_index} ->
      Enum.map(Enum.with_index(row), fn {col, col_index} -> {col, row_index, col_index} end)
    end)
    |> Enum.filter(&(elem(&1, 0) > 9 && is_integer(elem(&1, 0))))
    |> Enum.at(0, {nil, nil, nil})
    |> case do
      {nil, nil, nil} ->
        Enum.map(input, fn row ->
          Enum.map(row, fn col -> if !is_integer(col), do: 0, else: col end)
        end)

      {_col, row_index, col_index} ->
        update_neighbors(input, row_index, col_index) |> simulate_flashes()
    end
  end

  def update_neighbors(input, row_index, col_index) do
    updated_row = Enum.at(input, row_index) |> List.replace_at(col_index, "x")
    input = List.replace_at(input, row_index, updated_row)

    neighbors = [
      {row_index - 1, col_index},
      {row_index - 1, col_index + 1},
      {row_index, col_index + 1},
      {row_index + 1, col_index + 1},
      {row_index + 1, col_index},
      {row_index + 1, col_index - 1},
      {row_index, col_index - 1},
      {row_index - 1, col_index - 1}
    ]

    Enum.map(Enum.with_index(input), fn {row, row_index} ->
      Enum.map(Enum.with_index(row), fn {col, col_index} ->
        exists = Enum.member?(neighbors, {row_index, col_index})
        is_integer = is_integer(Enum.at(input, row_index) |> Enum.at(col_index))

        if exists && is_integer, do: col + 1, else: col
      end)
    end)
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

input = Day.load("11.input.txt")

# 1627
input |> Day.part1() |> IO.inspect()
# 329
input |> Day.part2() |> IO.inspect()
