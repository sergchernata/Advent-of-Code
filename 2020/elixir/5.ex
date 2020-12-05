defmodule Day5 do
	def part1(input) do
		input |> Enum.max
	end

	def part2(input) do
		Enum.min(input)..Enum.max(input)
		|> Enum.to_list()
		|> Enum.filter(fn seat -> !Enum.member?(input, seat) end)
		|> List.first
	end

	def find([], [head | tail]) when length(tail) == 0, do: head
	def find([select | remaining_input], rows) when length(rows) > 1 do
		halves = Enum.split(rows, round(length(rows) / 2))
		remaining_rows = elem(halves, select)
		find(remaining_input, remaining_rows)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body 
				|> String.split("\n", trim: true)
				|> Enum.map(fn line ->
					{row_coords, col_coords} = String.split_at(line, 7)
					row_coords = row_coords
						|> String.codepoints()
						|> Enum.map(& case &1 do "F" -> 0; "B" -> 1 end)
					col_coords = col_coords
						|> String.codepoints()
						|> Enum.map(& case &1 do "L" -> 0; "R" -> 1 end)

					[row_coords, col_coords]
				end)
				|> Enum.map(fn [row_coords, col_coords] -> 
					row = find(row_coords, Enum.to_list(0..127))
					col = find(col_coords, Enum.to_list(0..7))
					row * 8 + col
				end)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day5.load("5.input.txt")

input |> Day5.part1 |> IO.inspect # 928
input |> Day5.part2 |> IO.inspect # 610