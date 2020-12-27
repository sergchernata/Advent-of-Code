defmodule Day24 do
	def part1(input) do
		input
		|> tile
		|> Enum.frequencies
		|> count_colors
		|> Map.fetch!(:black)
	end

	def part2(input) do
		input
		|> tile
		|> Enum.frequencies
		|> process(100)
		|> count_colors
		|> Map.fetch!(:black)
	end

	def gridify(tiles) do
		x = Enum.max_by(tiles, fn {{x, _y}, _rep} -> abs(x) end) |> elem(0) |> elem(0) |> abs |> round
		y = Enum.max_by(tiles, fn {{_x, y}, _rep} -> abs(y) end) |> elem(0) |> elem(1) |> abs |> round
		largest = (if x > y, do: x, else: y) + 1

		grid = 
			for x <- -largest..largest, y <- -largest..largest do
				[{{x/1,y/1}, 0}, {{x+0.5,y+0.5}, 0}, {{x+0.5,y-0.5}, 0}, {{x-0.5,y+0.5}, 0}, {{x-0.5,y-0.5}, 0}]
			end
			|> List.flatten
			|> Enum.uniq

		for {{x, y}, rep} <- grid do
			case Map.has_key?(tiles, {x, y}) do
				true  -> {{x, y}, Map.get(tiles, {x, y})}
				false -> {{x, y}, rep}
			end
		end
	end

	def process(tiles, 0), do: tiles
	def process(tiles, count) do
		tiles
		|> gridify
		|> Enum.reduce(%{}, fn {{x, y}, rep}, acc -> 
			neighbors = %{
				e: Map.has_key?(tiles, {x+1, y}) && rem(Map.get(tiles, {x+1, y}), 2) == 1,
				se: Map.has_key?(tiles, {x+0.5, y-0.5}) && rem(Map.get(tiles, {x+0.5, y-0.5}), 2) == 1,
				sw: Map.has_key?(tiles, {x-0.5, y-0.5}) && rem(Map.get(tiles, {x-0.5, y-0.5}), 2) == 1,
				w: Map.has_key?(tiles, {x-1, y}) && rem(Map.get(tiles, {x-1, y}), 2) == 1,
				nw: Map.has_key?(tiles, {x-0.5, y+0.5}) && rem(Map.get(tiles, {x-0.5, y+0.5}), 2) == 1,
				ne: Map.has_key?(tiles, {x+0.5, y+0.5}) && rem(Map.get(tiles,{x+0.5, y+0.5}), 2) == 1
			}
			|> Enum.map(fn {_k, v} -> v end)
			|> Enum.filter(&(&1))
			|> Enum.count

			rep = 
				cond do
					rem(rep, 2) == 0 && neighbors == 2 -> rep+1
					rem(rep, 2) == 1 && (neighbors > 2 || neighbors == 0) -> rep+1
					true -> rep
				end

			Map.put(acc, {x, y}, rep)
		end)
		|> process(count-1)
	end

	def tile(input) do
		Enum.map(input, fn tile ->
			Enum.reduce(tile, {0,0}, fn dir, {x,y} ->
				case dir do
					"e"  -> {x+1,y}
					"se" -> {x+0.5,y-0.5}
					"sw" -> {x-0.5,y-0.5}
					"w"  -> {x-1,y}
					"nw" -> {x-0.5,y+0.5}
					"ne" -> {x+0.5,y+0.5}
				end
			end)
		end)
	end

	def count_colors(tiles) do
		Enum.reduce(tiles, %{white: 0, black: 0}, fn {_coord, rep}, result -> 
			case rem(rep, 2) do
				0 -> %{white: result.white+1, black: result.black}
				1 -> %{white: result.white, black: result.black+1}
			end
		end)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				body
				|> String.split("\n", trim: true)
				|> Enum.map(&Regex.scan(~r/e|se|sw|w|nw|ne/, &1) |> List.flatten)

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day24.load("24.input.txt")

input |> Day24.part1 |> IO.inspect # 479
input |> Day24.part2 |> IO.inspect # 4135