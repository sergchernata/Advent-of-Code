defmodule Day do
  def part1(input) do
    Enum.map(input, &(remove_basic_pairs(&1) |> first_illegal() |> error_score())) |> Enum.sum()
  end

  def part2(input) do
    scores =
      Enum.map(input, &remove_basic_pairs(&1))
      |> Enum.filter(&(first_illegal(&1) == nil))
      |> Enum.map(fn line ->
        String.reverse(line) |> autocomplete_score()
      end)
      |> Enum.sort()

    Enum.at(scores, div(length(scores), 2))
  end

  def remove_basic_pairs(line) do
    basic_pairs = ["()", "[]", "{}", "<>"]

    if String.contains?(line, basic_pairs) do
      String.replace(line, basic_pairs, "") |> remove_basic_pairs()
    else
      line
    end
  end

  def first_illegal(line) do
    String.replace(line, ["(", "[", "{", "<"], "") |> String.at(0)
  end

  def error_score(char) do
    case char do
      ")" -> 3
      "]" -> 57
      "}" -> 1197
      ">" -> 25137
      _ -> 0
    end
  end

  def autocomplete_score(line, total \\ 0)

  def autocomplete_score(line, total) when line == "", do: total

  def autocomplete_score(line, total) do
    {char, line} = String.split_at(line, 1)

    points =
      case char do
        "(" -> 1
        "[" -> 2
        "{" -> 3
        "<" -> 4
      end

    autocomplete_score(line, total * 5 + points)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n")
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("10.input.txt")

# 318081
input |> Day.part1() |> IO.inspect()
# 4361305341
input |> Day.part2() |> IO.inspect()
