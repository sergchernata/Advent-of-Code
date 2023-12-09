defmodule Day do
  def part1(input) do
    {numbers, symbols} = plot_coordinates(input)

    delete =
      Enum.reject(numbers, fn set ->
        Enum.map(set, fn {x, y} ->
          for x <- (x - 1)..(x + 1), y <- (y - 1)..(y + 1), do: {x, y} in symbols
        end)
        |> List.flatten()
        |> Enum.any?()
      end)
      |> List.flatten()

    Enum.with_index(input)
    |> Enum.map(fn {line, y} ->
      Enum.with_index(line)
      |> Enum.map(fn {char, x} ->
        if {x, y} in delete, do: ".", else: char
      end)
      |> Enum.join()
    end)
    |> Enum.join(".")
    |> String.split(~r"\D", trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum()
  end

  def part2(input) do
    {numbers, symbols} = plot_coordinates(input, ~r"\*")

    Enum.map(symbols, fn {x, y} ->
      Enum.map(numbers, fn set ->
        for x <- (x - 1)..(x + 1), y <- (y - 1)..(y + 1), do: if({x, y} in set, do: set)
      end)
    end)
    |> Enum.map(fn sets ->
      Enum.map(sets, fn set -> Enum.uniq(set) |> List.flatten() |> Enum.filter(& &1) end)
      |> Enum.reject(&(&1 == []))
    end)
    |> Enum.filter(&(length(&1) > 1))
    |> Enum.map(fn coords ->
      Enum.map(coords, fn set ->
        Enum.map(set, fn {x, y} -> Enum.at(input, y) |> Enum.at(x) end)
        |> Enum.join()
        |> String.to_integer()
      end)
      |> Enum.product()
    end)
    |> Enum.sum()
  end

  def plot_coordinates(input, regex \\ ~r"[!@#$%^&*()_+=\-/]") do
    Enum.with_index(input)
    |> Enum.reduce({[], []}, fn {line, y}, {numbers, symbols} ->
      line = Enum.with_index(line)

      numbers =
        Enum.map(line, fn {char, x} -> if String.match?(char, ~r"\d"), do: {x, y} end)
        |> Enum.chunk_by(&(&1 != nil))
        |> Enum.filter(fn set -> Enum.all?(set) end)
        |> Enum.concat(numbers)

      symbols =
        Enum.map(line, fn {char, x} ->
          if String.match?(char, regex), do: {x, y}
        end)
        |> Enum.reject(&(&1 == nil))
        |> Enum.concat(symbols)

      {numbers, symbols}
    end)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n") |> Enum.map(&String.split(&1, "", trim: true))
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("3.input.txt")

# 559667
input |> Day.part1() |> IO.inspect()
# 86841457
input |> Day.part2() |> IO.inspect()
