defmodule Day do
  @logic [
    %{name: "A", alias: "X", points: 1, beats: "C", loses: "B"},
    %{name: "B", alias: "Y", points: 2, beats: "A", loses: "C"},
    %{name: "C", alias: "Z", points: 3, beats: "B", loses: "A"}
  ]

  defp by_name(name), do: Enum.find(@logic, &(&1.name == name))
  defp by_alias(alias), do: Enum.find(@logic, &(&1.alias == alias))

  def part1(input) do
    input
    |> Enum.map(fn [opponent, me] ->
      opponent = by_name(opponent)
      me = by_alias(me)
      is_win = opponent.loses == me.name

      cond do
        opponent == me -> 3
        is_win -> 6
        true -> 0
      end
      |> Kernel.+(me.points)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> Enum.map(fn round ->
      case round do
        [opponent, "X"] ->
          (by_name(opponent) |> Map.get(:beats) |> by_name() |> Map.get(:points)) + 0

        [opponent, "Y"] ->
          (by_name(opponent) |> Map.get(:points)) + 3

        [opponent, "Z"] ->
          (by_name(opponent) |> Map.get(:loses) |> by_name() |> Map.get(:points)) + 6
      end
    end)
    |> Enum.sum()
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, " "))
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("2.input.txt")

# 11841
input |> Day.part1() |> IO.inspect()
# 13022
input |> Day.part2() |> IO.inspect()
