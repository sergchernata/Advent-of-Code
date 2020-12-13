defmodule Day12 do
	def part1(input) do
		input |> navigate_incorrectly()
	end

	def part2(input) do
		input |> navigate_correctly()
	end

	def navigate_correctly(directives, ship \\ {0,0}, waypoint \\ {10,1})
	def navigate_correctly([], {s_x,s_y}, _), do: abs(s_x)+abs(s_y)
	def navigate_correctly([{d,m} | directives], {s_x,s_y}, {w_x,w_y}) when d != nil do
		cond do
			d == "R" || d == "L" -> navigate_correctly(directives, {s_x,s_y}, rotate_waypoint({w_x,w_y}, m, d))
			d == "F" -> navigate_correctly(directives, {s_x+m*w_x,s_y+m*w_y}, {w_x,w_y})
			d == "N" -> navigate_correctly(directives, {s_x,s_y}, {w_x,w_y+m})
			d == "E" -> navigate_correctly(directives, {s_x,s_y}, {w_x+m,w_y})
			d == "S" -> navigate_correctly(directives, {s_x,s_y}, {w_x,w_y-m})
			d == "W" -> navigate_correctly(directives, {s_x,s_y}, {w_x-m,w_y})
		end
	end

	def rotate_waypoint({w_x,w_y}, measure, type) do
		case type do
			"R" -> rotate(floor(measure / 90), {w_x,w_y})
			"L" -> rotate(-floor(measure / 90), {w_x,w_y})
		end
	end

	def rotate(rotations, {w_x,w_y}) when rotations == 0, do: {w_x,w_y}
	def rotate(rotations, {w_x,w_y}) when rotations != 0 do
		cond do
			rotations < 0 -> rotate(rotations+1, {-w_y,w_x})
			rotations > 0 -> rotate(rotations-1, {w_y,-w_x})
		end
	end

	def navigate_incorrectly(directives, direction \\ 0, coordinates \\ {0,0})
	def navigate_incorrectly([], _, {x,y}), do: abs(x)+abs(y)
	def navigate_incorrectly([{d,m} | directives], direction, {x,y}) when d != nil do
		cond do
			d == "R" || d == "L" -> navigate_incorrectly(directives, rotate_ship(direction, m, d), {x,y})
			d == "F" -> navigate_incorrectly(directives, direction, forward({x,y}, direction, m))
			d == "N" -> navigate_incorrectly(directives, direction, {x,y+m})
			d == "E" -> navigate_incorrectly(directives, direction, {x+m,y})
			d == "S" -> navigate_incorrectly(directives, direction, {x,y-m})
			d == "W" -> navigate_incorrectly(directives, direction, {x-m,y})
		end
	end

	def rotate_ship(direction, measure, type) do
		directions = ["E","S","W","N"]
		rotations = floor(measure / 90)

		case type do
			"R" -> rem(direction+rotations, length(directions))
			"L" -> if direction-rotations < 0 do
				length(directions) - abs(direction-rotations)
			else
				rem(abs(direction-rotations), length(directions))
			end
		end
	end

	def forward({x,y}, direction, measure) do
		case direction do
			0 -> {x+measure,y}
			1 -> {x,y-measure}
			2 -> {x-measure,y}
			3 -> {x,y+measure}
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				body
				|> String.split("\n", trim: true)
				|> Enum.map(fn n ->
					{d,m} = String.split_at(n, 1)
					{d,String.to_integer(m)}
				end)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day12.load("12.input.txt")

input |> Day12.part1 |> IO.inspect # 1589
input |> Day12.part2 |> IO.inspect # 