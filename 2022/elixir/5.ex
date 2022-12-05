defmodule Day do
  def part1([stacks, procedure]) do
    restack(stacks, procedure, true)
    |> Enum.map(&List.first(&1))
    |> Enum.join("")
  end

  def part2([stacks, procedure]) do
    restack(stacks, procedure, false)
    |> Enum.map(&List.first(&1))
    |> Enum.join("")
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        [stacks, procedure] = body |> String.split("\n\n", trim: true)

        stacks =
          stacks
          |> String.split("\n", trim: true)
          |> Enum.reverse()
          |> tl()
          |> Enum.reverse()
          |> Enum.map(&(String.replace(&1, "   ", " [💩] ") |> String.split(" ", trim: true)))
          |> rotate()
          |> Enum.map(fn r ->
            Enum.reject(r, &(&1 == "[💩]"))
            |> Enum.map(&String.replace(&1, ["[", "]"], ""))
            |> Enum.reverse()
          end)

        procedure =
          procedure
          |> String.replace(~r"[a-z]", "")
          |> String.split("\n", trim: true)
          |> Enum.map(
            &(String.split(&1, " ", trim: true)
              |> Enum.map(fn x -> String.to_integer(x) end))
          )

        [stacks, procedure]

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end

  defp restack(stacks, [], _), do: stacks

  defp restack(stacks, [[move, from, to] | tl], reverse) do
    {target, origin} = Enum.split(Enum.at(stacks, from - 1), move)

    result =
      case reverse do
        true -> Enum.reverse(target) ++ Enum.at(stacks, to - 1)
        false -> target ++ Enum.at(stacks, to - 1)
      end

    stacks = stacks |> List.replace_at(from - 1, origin) |> List.replace_at(to - 1, result)
    restack(stacks, tl, reverse)
  end

  defp rotate(grid) do
    for i <- 0..length(grid) do
      for k <- (length(grid) - 1)..0 do
        row = Enum.at(grid, k)
        Enum.at(row, i)
      end
    end
  end
end

input = Day.load("5.input.txt")

# TBVFVDZPN
input |> Day.part1() |> IO.inspect()
# VLCWHTDSZ
input |> Day.part2() |> IO.inspect()
