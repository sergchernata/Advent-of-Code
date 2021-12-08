defmodule Day do
  def part1(input) do
    Enum.flat_map(input, fn [signal, output] ->
      lengths =
        Enum.map(signal, &String.length/1)
        |> Enum.frequencies()
        |> Enum.filter(fn {_length, count} -> count == 1 end)
        |> Enum.map(fn {length, _count} -> length end)

      Enum.map(output, &String.length/1) |> Enum.filter(&Enum.member?(lengths, &1))
    end)
    |> length
  end

  def part2(input) do
    Enum.map(input, fn [signal, output] ->
      one = signal |> Enum.find(&(String.length(&1) == 2))
      four = signal |> Enum.find(&(String.length(&1) == 4))
      seven = signal |> Enum.find(&(String.length(&1) == 3))
      eight = signal |> Enum.find(&(String.length(&1) == 7))

      top = (split(seven) -- split(one)) |> Enum.join()
      nine = Enum.find(signal, fn s -> match(s, 6, four) && s != eight end)
      bottom = (split(nine) -- (split(four) ++ [top])) |> Enum.join()
      bottom_left = (split(eight) -- split(nine)) |> Enum.join()
      three = Enum.find(signal, fn s -> match(s, 5, one) end)
      two = Enum.find(signal, fn s -> match(s, 5, bottom_left) end)
      top_left = (split(nine) -- split(three)) |> Enum.join()
      middle = (split(nine) -- split(one) -- [top, bottom, top_left]) |> Enum.join()
      six = Enum.find(signal, fn s -> match(s, 6, Enum.join([middle, bottom_left])) end)
      five = Enum.find(signal, fn s -> match(s, 5, split(six) -- [bottom_left]) end)

      Enum.map(output, fn o ->
        case o do
          ^one -> 1
          ^two -> 2
          ^three -> 3
          ^four -> 4
          ^five -> 5
          ^six -> 6
          ^seven -> 7
          ^eight -> 8
          ^nine -> 9
          _ -> 0
        end
      end)
      |> Enum.join()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  def match(string, num_chars, overlap) when is_list(overlap),
    do: match(string, num_chars, Enum.join(overlap))

  def match(string, num_chars, overlap) do
    length_matches = String.length(string) == num_chars
    does_contain = split(overlap) -- split(string) == []

    length_matches && does_contain
  end

  def split(string), do: String.split(string, "", trim: true)

  def normalize(string), do: split(string) |> Enum.sort() |> Enum.join()

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split(["\n"])
        |> Enum.map(fn line ->
          String.split(line, [" | "])
          |> Enum.map(fn s -> String.split(s, " ") |> Enum.map(&normalize(&1)) end)
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("8.input.txt")

# 294
input |> Day.part1() |> IO.inspect()
# 973292
input |> Day.part2() |> IO.inspect()
