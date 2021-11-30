defmodule Day20 do
	def part1(input) do
		size = input |> length |> :math.sqrt |> floor

		build(input, size) |> print
	end

	def part2(input) do
		input
	end

	def build(tiles, size, collection \\ [], count \\ 0)
	def build(_tiles, size, collection, count) when length(collection) == size * size, do: collection
	def build(tiles, size, collection, count) when count > length(tiles) do
		[{f_id, f_orientation, f_tile}|[{s_id, s_orientation, s_tile}|tail]] = tiles
		build([{s_id, s_orientation, s_tile}] ++ tail ++ [{f_id, f_orientation, f_tile}], size, collection, 0)
	end
	def build(tiles, size, collection, count) do
		[{f_id, f_orientation, f_tile}|[{s_id, s_orientation, s_tile}|tail]] = tiles
		# IO.inspect f_tile |> get_edge(:right)
		# IO.inspect  s_tile |> get_edge(:left)
		print(collection)
		case f_tile |> get_edge(:right) == s_tile |> get_edge(:left) do
			true  -> 
				IO.inspect "match"
				build([{s_id, s_orientation, s_tile}] ++ tail, size, collection ++ [{f_id, f_orientation, f_tile}], count)
			false ->
				IO.inspect "fail"
				s_tile = rotate(s_tile)

				case s_orientation < 3 do
					true  -> 
						s_orientation = s_orientation+1
						build([{f_id, f_orientation, f_tile}|[{s_id, s_orientation, s_tile}|tail]], size, collection, count)
					false ->
						s_orientation = 0
						build([{f_id, f_orientation, f_tile}] ++ tail ++ [{s_id, s_orientation, s_tile}], size, collection, count+1)
				end
		end
	end

	def print([]), do: nil
	def print(collection) do
		grid_size = collection |> length |> :math.sqrt |> floor
		tile_lines = collection |> hd |> elem(2) |> length

		for row <- 0..grid_size-1 do
			for line <- 0..tile_lines-1 do
				for col <- 0..grid_size-1 do 
					{_,_,tile} = Enum.at(collection, row+col)
					Enum.at(tile, line) |> Enum.join("")
				end
				|> Enum.join("   ")
			end
			|> Enum.join("\n")
			|> IO.puts

			IO.puts ""
		end
	end

	def rotate(tile) do
		for i <- 0..length(tile)-1 do
			for k <- length(tile)-1..0 do
				row = Enum.at(tile, k)
				Enum.at(row, i)
			end
		end
	end

	def get_edge(tile, side) do
		case side do
			:top -> Enum.at(tile, 0)
			:right -> Enum.map(tile, &Enum.at(&1, length(tile)-1))
			:bottom -> Enum.at(tile, length(tile)-1)
			:left -> Enum.map(tile, &Enum.at(&1, 0))
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				body
				|> String.split("\n\n", trim: true)
				|> Enum.map(fn tile -> 
					tile
					|> String.replace("Tile ", "")
					|> String.split(":\n", trim: true)
				end)
				|> Enum.reduce([], fn [id, tile], acc ->
					tile = tile
					|> String.split("\n", trim: true)
					|> Enum.map(&String.split(&1, "", trim: true))

					[{String.to_integer(id), 0, tile}|acc]
				end)

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day20.load("20.input.txt")

input |> Day20.part1 |> IO.inspect # 
#input |> Day20.part2 |> IO.inspect # 