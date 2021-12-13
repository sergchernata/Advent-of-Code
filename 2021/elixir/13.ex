defmodule Day do
  def part1([coordinates, [first_fold | _folds]]) do
    grid = coordinates_to_grid(coordinates)

    fold(grid, first_fold) |> List.flatten() |> Enum.filter(&(&1 == "#")) |> length
  end

  def part2([coordinates, folds]) do
    grid = coordinates_to_grid(coordinates)

    make_folds(grid, folds) |> Enum.map(&Enum.join(&1))
  end

  def make_folds(grid, []), do: grid

  def make_folds(grid, [first_fold | folds]) do
    fold(grid, first_fold) |> make_folds(folds)
  end

  def fold(grid, {axis, i}) do
    case axis do
      "y" ->
        {top, bottom} = Enum.split(grid, i)
        top_coordinates = grid_to_coordinates(top)
        bottom_coordinates = grid_to_coordinates(Enum.reverse(Enum.drop(bottom, 1)))
        all_coordinates = top_coordinates ++ bottom_coordinates

        Enum.uniq(all_coordinates) |> coordinates_to_grid()

      _ ->
        split = Enum.map(grid, fn row -> Enum.split(row, i) end)
        left = Enum.map(split, &elem(&1, 0))
        right = Enum.map(split, &(elem(&1, 1) |> Enum.drop(1) |> Enum.reverse()))
        left_coordinates = grid_to_coordinates(left)
        right_coordinates = grid_to_coordinates(right)
        all_coordinates = left_coordinates ++ right_coordinates

        Enum.uniq(all_coordinates) |> coordinates_to_grid()
    end
  end

  def grid_to_coordinates(grid) do
    for {row, row_index} <- Enum.with_index(grid) do
      for {col, col_index} <- Enum.with_index(row) do
        if col == "#", do: {col_index, row_index}, else: nil
      end
    end
    |> List.flatten()
    |> Enum.filter(& &1)
  end

  def coordinates_to_grid(coordinates) do
    {x_list, y_list} = Enum.unzip(coordinates)
    x_max = Enum.max(x_list)
    y_max = Enum.max(y_list)

    for y <- 0..y_max do
      for x <- 0..x_max do
        if {x, y} in coordinates, do: "#", else: " "
      end
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        [coordinates, folds] = String.split(body, "\n\n")

        coordinates =
          String.split(coordinates, "\n")
          |> Enum.map(fn row ->
            String.split(row, ",", trim: true)
            |> Enum.map(&String.to_integer/1)
            |> List.to_tuple()
          end)

        folds =
          String.split(folds, "\n")
          |> Enum.map(fn row ->
            String.replace(row, "fold along ", "") |> String.split("=", trim: true)
          end)
          |> Enum.map(fn [axis, i] -> {axis, String.to_integer(i)} end)

        [coordinates, folds]

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("13.input.txt")

# 716
input |> Day.part1() |> IO.inspect()
# RPCKFBLR
input |> Day.part2() |> IO.inspect()
