defmodule Day do
  def part1(input) do
    for {char, index} <- hd(input) |> String.graphemes() |> Enum.with_index() do
      aggregate_by_index(input, index)
      |> Enum.map(&elem(&1, 0))
      |> List.to_tuple()
    end
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Enum.map(&(List.to_string(&1) |> Integer.parse(2) |> elem(0)))
    |> Enum.reduce(fn gamma, epsilon -> gamma * epsilon end)
  end

  def part2(input) do
    find_rating(1, input) * find_rating(0, input)
  end

  def aggregate_by_index(input, index) do
    for line <- input do
      String.graphemes(line) |> Enum.fetch!(index)
    end
    |> List.flatten()
    |> Enum.frequencies()
    |> Enum.sort_by(&elem(&1, 1))
  end

  def find_rating(type, input \\ [], index \\ 0)

  def find_rating(type, input, index) do
    selected =
      aggregate_by_index(input, index)
      |> Enum.at(type)
      |> elem(0)

    input =
      Enum.filter(input, fn line -> String.graphemes(line) |> Enum.fetch!(index) == selected end)

    case length(input) do
      1 -> hd(input) |> Integer.parse(2) |> elem(0)
      _ -> find_rating(type, input, index + 1)
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n", trim: true)
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("3.input.txt")

# 741950
input |> Day.part1() |> IO.inspect()
# 903810
input |> Day.part2() |> IO.inspect()
