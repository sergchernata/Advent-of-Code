defmodule Day do
  def part1(input) do
    starts = Enum.filter(input, &String.contains?(&1, "start"))
    connections = input -- starts

    Enum.map(starts, &find_paths(&1, connections, length(connections), []))
    |> List.flatten()
    |> Enum.uniq()
  end

  def part2(input) do
  end

  def find_paths(_start, _connections, 0, paths), do: paths

  def find_paths(start, connections, iterations, paths) do
    cave = String.replace(start, ["start", "-"], "")
    new_path = traverse(cave, ["start", cave], connections)
    [current | connections] = connections
    ends = Enum.filter(connections, &String.contains?(&1, "end"))
    rotate_connections = (connections -- ends) ++ [current] ++ ends

    find_paths(start, rotate_connections, iterations - 1, paths ++ [new_path])
  end

  def traverse(_cave, path, []), do: Enum.join(path, ",")

  def traverse(cave, path, [choice | choices]) do
    choice_parts = String.split(choice, "-")
    next_cave = Enum.filter(choice_parts, &(&1 != cave)) |> hd()
    valid_move = Enum.member?(choice_parts, cave)
    prev_cave = Enum.at(path, -1)
    not_previous = prev_cave != next_cave
    repeat_allowed = upcase?(next_cave) || (!Enum.member?(path, next_cave) && !upcase?(next_cave))
    is_end = next_cave == "end"
    choices = choices ++ [choice]

    IO.inspect(cave)
    IO.inspect(choice)
    IO.inspect(next_cave)
    IO.inspect(choices)
    IO.inspect(path)
    IO.inspect(valid_move)
    IO.inspect(not_previous)
    IO.inspect(repeat_allowed)
    IO.inspect("-------")

    if !is_end do
      case valid_move && not_previous && repeat_allowed do
        true -> traverse(next_cave, path ++ [next_cave], choices)
        false -> traverse(cave, path, choices)
      end
    else
      traverse(cave, path ++ [next_cave], [])
    end
  end

  def remove_dead_ends(connections) do
    all_except_ends = Enum.filter(connections, &(!String.contains?(&1, ["start", "end"])))

    Enum.filter(connections, fn connection ->
      if String.contains?(connection, ["start", "end"]) do
        true
      else
        [a, b] = String.split(connection, "-")
        a_more_than_once = Enum.count(all_except_ends, &String.contains?(&1, a))
        b_more_than_once = Enum.count(all_except_ends, &String.contains?(&1, b))
        both_not_lowercase = (!upcase?(a) && upcase?(b)) || (upcase?(a) && !upcase?(b))
        (a_more_than_once || b_more_than_once) && both_not_lowercase
      end
    end)
  end

  def upcase?(string), do: string == String.upcase(string)

  def load(file) do
    case File.read(file) do
      {:ok, body} -> body |> String.split("\n") |> remove_dead_ends()
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("12.input.txt")

# 
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
