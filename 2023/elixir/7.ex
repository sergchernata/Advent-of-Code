defmodule Day do
  def part1(input) do
    input
    |> Enum.map(fn [hand, bid] ->
      %{
        hand: hand,
        bid: bid,
        freq: Enum.frequencies(hand),
        count: Enum.frequencies(hand) |> Map.values() |> Enum.sort()
      }
    end)
    |> Enum.group_by(fn %{count: count} -> count end)
    |> Enum.to_list()
    |> Enum.sort_by(fn {count, hands} -> length(count) end)
    |> Enum.map(fn {_count, hands} ->
      hands
      |> Enum.sort_by(fn %{hand: hand} ->
        hand
        |> Enum.map(fn x ->
          case x do
            "A" -> "A"
            "K" -> "C"
            "Q" -> "D"
            "J" -> "E"
            "T" -> "F"
            "9" -> "G"
            "8" -> "H"
            "7" -> "I"
            "6" -> "J"
            "5" -> "K"
            "4" -> "L"
            "3" -> "M"
            "2" -> "N"
          end
        end)
      end)
    end)
    |> List.flatten()
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(fn {hand, index} -> hand.bid * index end)
    |> Enum.sum()
  end

  def part2(input) do
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n")
        |> Enum.map(fn x ->
          [hand, bid] = String.split(x, " ", trim: true)
          hand = String.graphemes(hand)
          bid = String.to_integer(bid)

          [hand, bid]
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("7.input.txt")

# 249638405
input |> Day.part1() |> IO.inspect()
#
input |> Day.part2() |> IO.inspect()
