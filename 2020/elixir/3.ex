defmodule Day3 do
	def part1(input) do
		traverse(0, 0, 3, 1, input, 0)
	end

	def part2(input) do
		slopes = [ {1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2} ]
		|> Enum.map(fn slope -> 
			x_move = elem(slope, 0)
			y_move = elem(slope, 1)
			traverse(0, 0, x_move, y_move, input, 0)
		end)
		|> Enum.reduce(fn x, acc -> x * acc end)
	end

	def traverse(_, y, _, _, input, count) when y >= length(input), do: count
	def traverse(x, y, x_move, y_move, input, count) when y < length(input) do
		line = Enum.at(input, y)
		position =
			cond do
				x > length(line) - 1 -> x - length(line)
				true -> x
			end
		count = 
			cond do
				Enum.at(line, position) == "#" -> count + 1
				true -> count
			end

		traverse(position + x_move, y + y_move, x_move, y_move, input, count)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body 
						   |> String.split("\n", trim: true)
						   |> Enum.map(& String.codepoints(&1))
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day3.load("3.input.txt")

input |> Day3.part1 |> IO.inspect # 203
input |> Day3.part2 |> IO.inspect # 3316272960