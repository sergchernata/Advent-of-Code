defmodule Day do
  def part1(input) do
    input
    |> parse_dirs()
    |> get_in(["/", :dirs, "/", :dirs])
    |> calc_total_sizes()
    |> unwrap()
    |> Map.values()
    |> Enum.filter(&(&1 < 100_000))
    |> Enum.sum()
  end

  def part2(input) do
    disk_size = 70_000_000
    required_space = 30_000_000

    dirs =
      input
      |> parse_dirs()
      |> calc_total_sizes()
      |> unwrap()

    current_total = Map.get(dirs, "/")
    min_to_free = required_space - (disk_size - current_total)

    dirs
    |> Map.values()
    |> Enum.sort()
    |> Enum.find(&(&1 >= min_to_free))
  end

  defp parse_dirs(input) do
    root = %{"/" => %{files: [], dirs: %{}}}

    input
    |> Enum.reduce({root, ["/"]}, fn line, {tree, path} ->
      case line do
        "$ cd " <> dir ->
          case dir do
            ".." ->
              path = path |> Enum.reverse() |> tl() |> tl() |> Enum.reverse()
              {tree, path}

            dir ->
              dir =
                case dir do
                  "/" -> dir
                  _ -> (path |> Enum.reject(&(&1 in ["/", :dirs])) |> Enum.join("")) <> dir
                end

              path = path ++ [:dirs] ++ [dir]

              tree =
                case get_in(tree, path) do
                  nil -> put_in(tree, path, %{files: [], dirs: %{}})
                  _ -> tree
                end

              {tree, path}
          end

        "$ ls" ->
          {tree, path}

        "dir " <> dir ->
          dir = (path |> Enum.reject(&(&1 in ["/", :dirs])) |> Enum.join("")) <> dir
          dirs = get_in(tree, path) |> Map.get(:dirs) |> Map.put(dir, %{files: [], dirs: %{}})
          tree = put_in(tree, path ++ [:dirs], dirs)
          {tree, path}

        file ->
          file = String.replace(file, ~r/[a-z .]/, "") |> String.to_integer()
          files = get_in(tree, path) |> Map.get(:files)
          tree = put_in(tree, path ++ [:files], files ++ [file])
          {tree, path}
      end
    end)
    |> elem(0)
  end

  defp calc_total_sizes(tree) do
    Enum.map(tree, fn {dir, subtree} ->
      case subtree.dirs |> map_size() do
        0 -> {dir, Enum.sum(subtree.files)}
        _ -> {dir, calc_total_sizes(subtree.dirs) ++ [Enum.sum(subtree.files)]}
      end
    end)
  end

  defp unwrap(tree, acc \\ %{}) do
    Enum.reduce(tree, acc, fn {dir, subtree}, acc ->
      case is_list(subtree) do
        true ->
          acc =
            Enum.filter(subtree, &is_tuple(&1))
            |> Enum.map(&unwrap(List.wrap(&1), acc))
            |> Enum.reduce(%{}, fn item, acc -> Map.merge(item, acc) end)

          Map.put(acc, dir, subtree |> clean_tuples() |> Enum.sum())

        false ->
          Map.put(acc, dir, subtree)
      end
    end)
  end

  defp clean_tuples(list) do
    for item <- List.flatten(list) do
      case item do
        {_, size} ->
          case is_list(size) do
            true -> clean_tuples(size)
            false -> size
          end

        item ->
          item
      end
    end
    |> List.flatten()
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body |> String.split("\n", trim: true)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("7.input.txt")

# 1513699
# input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
