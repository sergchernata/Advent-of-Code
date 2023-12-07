defmodule Day do
  @replace %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def part1(input) do
    input
    |> Enum.map(&process_line/1)
    |> Enum.filter(& &1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(fn line ->
      String.graphemes(line)
      |> replace_first_occurance()
      |> String.graphemes()
      |> Enum.reverse()
      |> replace_first_occurance()
      |> String.graphemes()
      |> Enum.reverse()
      |> Enum.join()
    end)
    |> Enum.map(&process_line/1)
    |> Enum.sum()
  end

  def replace_first_occurance(list, acc \\ "")

  def replace_first_occurance([], acc), do: acc

  def replace_first_occurance([hd | tl], acc) do
    keys = Map.keys(@replace)
    find = keys ++ Enum.map(keys, &String.reverse/1)

    case Enum.find(find, &String.contains?(acc <> hd, &1)) do
      nil ->
        replace_first_occurance(tl, acc <> hd)

      found ->
        String.replace(acc <> hd, found, @replace[found] || @replace[String.reverse(found)]) <>
          Enum.join(tl)
    end
  end

  def process_line(line) do
    line
    |> String.replace(~r"\D", "")
    |> String.split("", trim: true)
    |> f_and_l_as_int()
  end

  def split(list) do
    len = round(length(list) / 2)
    Enum.split(list, len)
  end

  def f_and_l_as_int([]), do: nil

  def f_and_l_as_int(list), do: (List.first(list) <> List.last(list)) |> String.to_integer()

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n")
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("1.input.txt")

# 56397
input |> Day.part1() |> IO.inspect()
# not 55633, not 55694, 55725 is too high
input |> Day.part2() |> IO.inspect()
