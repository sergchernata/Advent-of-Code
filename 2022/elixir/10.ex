defmodule Day do
  def part1(input) do
    select = [20, 60, 100, 140, 180, 220]

    input
    |> Enum.reduce({1, 0, []}, fn line, {signal, cycle, history} ->
      case line do
        ["noop"] ->
          {signal, cycle + 1, history ++ [[signal, cycle + 1]]}

        [_, strength] ->
          {signal + strength, cycle + 2, history ++ [[signal, cycle + 1], [signal, cycle + 2]]}
      end
    end)
    |> elem(2)
    |> Enum.filter(fn [_signal, cycle] -> cycle in select end)
    |> Enum.map(fn [signal, cycle] -> signal * cycle end)
    |> List.flatten()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.reduce({1, 0, []}, fn line, {signal, cycle, history} ->
      case line do
        ["noop"] ->
          pixel = if cycle >= signal - 1 && cycle <= signal + 1, do: "#", else: " "
          cycle = if cycle >= 39, do: 0, else: cycle + 1
          {signal, cycle, history ++ [pixel]}

        [_, strength] ->
          pixel1 = if cycle >= signal - 1 && cycle <= signal + 1, do: "#", else: " "
          cycle = if cycle >= 39, do: -1, else: cycle

          pixel2 =
            if cycle + 1 >= signal - 1 && cycle + 1 <= signal + 1,
              do: "#",
              else: " "

          cycle = if cycle + 2 >= 40, do: 0, else: cycle + 2

          {signal + strength, cycle, history ++ [pixel1, pixel2]}
      end
    end)
    |> elem(2)
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join(&1))
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n", trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))
        |> Enum.map(fn line ->
          if length(line) > 1,
            do: [List.first(line), String.to_integer(List.last(line))],
            else: line
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("10.input.txt")

# 13180
input |> Day.part1() |> IO.inspect()
# EZFCHJAB
input |> Day.part2() |> IO.inspect()
