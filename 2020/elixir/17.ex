defmodule Day17 do
	def part1(input) do
		input |> cycle(1)
	end

	def part2(input) do
		input
	end

	def cycle(cube, cycles, i \\ 0)
	def cycle(cube, cycles, i) when i == cycles do 
		cube |> List.flatten() |> List.flatten() |> Enum.frequencies |> Map.get("#")
	end
	def cycle(cube, cycles, i) when i < cycles do
		indexed = cube
			|> Enum.map(fn layer ->
				layer
				|> Enum.map(fn row -> Enum.with_index(row) end)
				|> Enum.with_index
			end)
			|> Enum.with_index

		for {layer, l_i} <- indexed do
			for {row, r_i} <- layer do
				for {cell, c_i} <- row do
					IO.inspect "layer #{l_i}, row #{r_i}, cell #{c_i}"
					num_active = cube 
					|> get_neighbors(l_i, r_i, c_i)
					#|> IO.inspect
					|> Enum.frequencies
					|> Map.get("#")
					if l_i == 1, do: IO.inspect cell
					if l_i == 1, do: IO.inspect num_active
					cond do
						cell == "#" && (num_active == 2 || num_active == 3) -> "."
						cell == "." && num_active == 3 -> "#"
						true -> cell
					end
				end
			end
		end
		#|> expand
		|> print_cube
		#|> cycle(cycles,i+1)
	end

	def get_neighbors(cube, l_i, r_i, c_i) do
		size = length(cube)
		l_range = if l_i==0, do: 0..l_i+1, else: l_i-1..l_i+1
		r_range = if r_i==0, do: 0..r_i+1, else: r_i-1..r_i+1
		c_range = if c_i==0, do: 0..c_i+1, else: c_i-1..c_i+1

		if l_i == 1, do: IO.inspect "#{l_i-1}-#{l_i+1}, #{r_i-1}-#{r_i+1}, #{c_i-1}-#{c_i+1}"

		for l <- l_range, r <- r_range, c <- c_range do
			#if l_i == 1, do: IO.inspect "#{l}, #{r}, #{c}"
			is_target = l == l_i && r == r_i && c == c_i
			layer = Enum.at(cube, l)
			cell_exists = layer != nil && (layer |> Enum.at(r)) != nil && (layer |> Enum.at(r) |> Enum.at(c)) != nil

			#if l_i == 1, do: IO.inspect layer |> Enum.at(-1)

			found = 
				case cell_exists && !is_target do
					true  -> layer |> Enum.at(r) |> Enum.at(c)
					false -> nil
				end

			# if l_i == 1, do: IO.inspect cell_exists
			# if l_i == 1, do: IO.inspect found

			found
		end
	end

	def expand(cube) do
		new_width = length(cube)+2
		new_layer = make_layer(new_width)

		cube = 
			for layer <- cube do
				row = List.duplicate(".", new_width)
				layer = Enum.map(layer, fn row -> ["."] ++ row ++ ["."] end)
				[row] ++ layer ++ [row]
			end

		[new_layer] ++ cube ++ [new_layer]
	end

	def print_cube(cube) do
		cube_width = length(cube)-1
		output = 
			for layer <- 0..cube_width do
				Enum.join(Enum.at(cube, layer), "\n")
			end
			|> Enum.join("\n\n")

		IO.puts output
		cube
	end

	def make_layer(grid_size) do
		row = List.duplicate(".", grid_size)
		List.duplicate(row, grid_size)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				grid = body
				|> String.split("\n", trim: true)
				|> Enum.map(&String.split(&1,"", trim: true))

				[grid]
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day17.load("17.input.txt")

input |> Day17.part1 |> IO.inspect # 
#input |> Day17.part2 |> IO.inspect # 