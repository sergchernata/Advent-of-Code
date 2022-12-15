defmodule Day do
  def part1(input) do
    input
    |> parse()
    |> List.last()
    |> Enum.uniq()
    |> length()
  end

  def part2(input) do
    # input
  end

  defp parse(input, h \\ [[0, 0]], t \\ [[0, 0]])

  defp parse([], h, t), do: [h, t]

  defp parse([[dir, count] | tl], [[h_x, h_y] | _] = h, [[t_x, t_y] | _] = t) do
    {h_new, t_new} =
      for i <- 0..count do
        case dir do
          "U" ->
            h = [h_x, h_y + i]
            t = if abs(h_y + i - t_y) >= 2, do: [h_x, h_y + i - 1], else: [t_x, t_y]
            {h, t}

          "R" ->
            h = [h_x + i, h_y]
            t = if abs(h_x + i - t_x) >= 2, do: [h_x + i - 1, h_y], else: [t_x, t_y]
            {h, t}

          "D" ->
            h = [h_x, h_y - i]
            t = if abs(h_y - i - t_y) >= 2, do: [h_x, h_y - i + 1], else: [t_x, t_y]
            {h, t}

          "L" ->
            h = [h_x - i, h_y]
            t = if abs(h_x - i - t_x) >= 2, do: [h_x - i + 1, h_y], else: [t_x, t_y]
            {h, t}
        end
      end
      |> Enum.unzip()

    parse(tl, Enum.reverse(h_new) ++ h, Enum.reverse(t_new) ++ t)
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n", trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))
        |> Enum.map(fn [dir, count] -> [dir, String.to_integer(count)] end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("9.input.txt")

# 6391
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
