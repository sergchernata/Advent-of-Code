defmodule Day do
  def part1(input) do
    input
    |> Enum.map(&run/1)

    # |> Enum.filter(& &1)
    # |> Enum.sum()
  end

  def part2(input) do
    # input
  end

  defp run({[left, right], index}) do
    comparisons =
      for {l, i} <- Enum.with_index(left) do
        r = Enum.at(right, i)

        if is_list(l) || is_list(r) do
          l = List.wrap(l)
          r = List.wrap(r)

          run({[l, r], index})
        else
          compare(l, r)
        end
      end
      |> IO.inspect()

    # check if true occurs before false
    if Enum.member?(comparisons, true) &&
         Enum.find_index(comparisons, &(&1 == true)) <
           Enum.find_index(comparisons, &(&1 == false)) do
      index
    else
      false
    end
  end

  defp compare(l, r) do
    cond do
      r == nil -> false
      l < r -> true
      l > r -> false
      true -> nil
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n\n", trim: true)
        |> Enum.map(
          &(String.split(&1, "\n")
            |> Enum.map(fn string -> Code.eval_string(string) |> elem(0) end))
        )
        |> Enum.with_index(1)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("13.input.txt")

# 3598 is too low
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
