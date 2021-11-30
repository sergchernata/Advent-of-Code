defmodule Day11 do
	def part1(input) do
		input
		|> simulate_adjacent_seating()
		|> List.flatten()
		|> Enum.frequencies()
		|> Map.get("#")
	end

	def part2(input) do
		input
		|> simulate_line_of_sight_seating()
		|> List.flatten()
		|> Enum.frequencies()
		|> Map.get("#")
	end

	def simulate_adjacent_seating(input) do
		
		new_arrangement =
			for {row, row_i} <- Enum.with_index(input) do
				for {seat, seat_i} <- Enum.with_index(row) do
					if seat != "." do

						slice_start = if seat_i==0, do: 0, else: seat_i-1
						slice_num = if seat_i==0, do: 2, else: 3

						prev_row_seats = 
							case row_i-1 >= 0 do
								true  -> Enum.at(input, row_i-1) |> Enum.slice(slice_start, slice_num)
								false -> []
							end

						next_row_seats = 
							case row_i+1 < length(input) do
								true  -> Enum.at(input, row_i+1) |> Enum.slice(slice_start, slice_num)
								false -> []
							end

						left_seat = 
							case seat_i-1 >= 0 do
								true  -> [Enum.at(row, seat_i-1)]
								false -> []
							end

						right_seat = 
							case seat_i+1 < length(row) do
								true  -> [Enum.at(row, seat_i+1)]
								false -> []
							end

						adjacent = prev_row_seats ++ next_row_seats ++ left_seat ++ right_seat
						seat_frequencies = Enum.frequencies(adjacent)
						taken_seats = seat_frequencies |> Map.get("#")
						has_sufficient_taken_seats = taken_seats != nil && taken_seats >= 4

						cond do
							seat == "L" && !Enum.member?(adjacent, "#") -> "#"
							seat == "#" && has_sufficient_taken_seats -> "L"
							true -> seat
						end
					else
						"."
					end
				end
			end

		if Enum.join(new_arrangement, ",") == Enum.join(input, ",") do
			new_arrangement
		else
			simulate_adjacent_seating(new_arrangement)
		end
	end

	def simulate_line_of_sight_seating(input) do
		rows = Enum.with_index(input)

		new_arrangement =
			for {row, row_i} <- rows do
				seats = Enum.with_index(row)
				num_rows = length(rows)
				for {seat, seat_i} <- seats do
					if seat != "." do

						n = 
							case row_i-1 >= 0 do
								true -> get_vertical_seats(input, row_i, seat_i, "n")
								false -> []
							end

						s = 
							case row_i+1 < length(input) do
								true -> get_vertical_seats(input, row_i, seat_i, "s")
								false -> []
							end
						
						w = 
							case seat_i-1 >= 0 do
								true -> get_horizontal_seats(row, seats, seat_i, "w")
								false -> []
							end

						e = 
							case seat_i+1 < length(row) do
								true -> get_horizontal_seats(row, seats, seat_i, "e")
								false -> []
							end

						ne = 
							case row_i-1 >= 0 && seat_i+1 < length(row) do
								true ->
									rows
									|> Enum.slice(0..row_i-1)
									|> Enum.map(fn {r,r_i} ->
										Enum.filter(Enum.with_index(r), fn {_,i} -> i == seat_i + (row_i - r_i) end)
										|> Enum.map(fn {v,_} -> v end)
									end)
									|> List.flatten()
									|> Enum.filter(&(&1 != "."))
									|> Enum.reverse()
									|> Enum.slice(0,1)
								false -> []
							end

						nw = 
							case row_i-1 >= 0 && seat_i-1 >= 0 do
								true ->
									rows
									|> Enum.slice(0..row_i-1)
									|> Enum.map(fn {r,r_i} -> 
										Enum.filter(Enum.with_index(r), fn {_,i} -> i == seat_i - (row_i - r_i) end)
										|> Enum.map(fn {v,_} -> v end)
									end)
									|> List.flatten()
									|> Enum.filter(&(&1 != "."))
									|> Enum.slice(-1,1)
								false -> []
							end

						se = 
							case row_i+1 < length(input) && seat_i+1 < length(row) do
								true ->
									input
									|> Enum.slice(row_i..num_rows)
									|> Enum.with_index()
									|> Enum.map(fn {r,r_i} -> 
										Enum.filter(Enum.with_index(r), fn {_,i} -> i == seat_i + 1 + r_i end)
										|> Enum.map(fn {v,_} -> v end)
									end)
									|> List.flatten()
									|> Enum.filter(&(&1 != "."))
									|> Enum.slice(0,1)
								false -> []
							end

						sw = 
							case row_i+1 < length(input) && seat_i-1 >= 0 do
								true ->
									input
									|> Enum.slice(row_i..num_rows)
									|> Enum.with_index()
									|> Enum.map(fn {r,r_i} -> 
										Enum.filter(Enum.with_index(r), fn {_,i} -> i == seat_i - 1 - r_i end)
										|> Enum.map(fn {v,_} -> v end)
									end)
									|> List.flatten()
									|> Enum.filter(&(&1 != "."))
									|> Enum.slice(0,1)
								false -> []
							end

						adjacent = n ++ s ++ w ++ e ++ ne ++ nw ++ se ++ sw
						seat_frequencies = Enum.frequencies(adjacent)
						taken_seats = seat_frequencies |> Map.get("#")
						has_sufficient_taken_seats = taken_seats != nil && taken_seats >= 5

						cond do
							seat == "L" && !Enum.member?(adjacent, "#") -> "#"
							seat == "#" && has_sufficient_taken_seats -> "L"
							true -> seat
						end
					else
						"."
					end
				end
			end

		if Enum.join(new_arrangement, ",") == Enum.join(input, ",") do
			new_arrangement
		else
			simulate_line_of_sight_seating(new_arrangement)
		end
	end

	def get_vertical_seats(input, row_index, seat_index, type) do
		range = if type == "n", do: 0..row_index-1, else: row_index+1..length(input) 

		seats = input
		|> Enum.slice(range)
		|> Enum.map(fn r -> 
			Enum.filter(Enum.with_index(r), fn {_,i} -> i == seat_index end)
			|> Enum.map(fn {v,_} -> v end)
		end)
		|> List.flatten()
		|> Enum.filter(&(&1 != "."))

		case type do
			"n" -> seats |> Enum.reverse()
			"s" -> seats
		end
		|> Enum.slice(0,1)
	end

	def get_horizontal_seats(row, seats, seat_index, type) do
		from = if type == "w", do: 0, else: seat_index+1
		to = if type == "w", do: seat_index, else: length(seats)-seat_index

		seats = row
		|> Enum.slice(from,to)
		|> Enum.filter(&(&1 != "."))

		case type do
			"w" -> seats |> Enum.reverse()
			"e" -> seats
		end
		|> Enum.slice(0,1)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				body
				|> String.split("\n", trim: true)
				|> Enum.map(& String.codepoints(&1))
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day11.load("11.input.txt")

input |> Day11.part1 |> IO.inspect # 2275
input |> Day11.part2 |> IO.inspect # 