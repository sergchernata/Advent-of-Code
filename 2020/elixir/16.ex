defmodule Day16 do
	def part1([rules, _mine, nearby]) do
		find_invalid_tickets(rules, nearby)
		|> Enum.map(fn {_id, list} -> list |> hd end)
		|> List.flatten
		|> Enum.sum
	end

	def part2(input) do
		input
	end

	def find_invalid_tickets(rules, nearby) do
		nearby
		|> Enum.with_index
		|> Enum.map(fn {ticket, id} -> 
			invalid = ticket
			|> Enum.filter(fn value ->
				rules
				|> Enum.map(fn {_label, [[a_min,a_max],[b_min,b_max]]} ->
					(value >= a_min && value <= a_max) || (value >= b_min && value <= b_max)
				end)
				|> Enum.member?(true)
				|> Kernel.not
			end)

			{id, invalid}
		end)
		|> Enum.filter(fn {_id, list} -> list != [] end)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				raw = body
				|> String.split("\n\n", trim: true)

				rules = Enum.at(raw, 0)
				|> String.split("\n", trim: true)
				|> Enum.reduce(%{}, fn line, acc ->
					[label,ranges] = line
					|> String.split(": ", trim: true)

					ranges = ranges
					|> String.split(" or ", trim: true)
					|> Enum.map(fn range -> 
						range 
						|> String.split("-", trim: true) end)
						|> Enum.map(fn r -> Enum.map(r, &String.to_integer/1) end)

					Map.put(acc, label, ranges)
				end)

				mine = Enum.at(raw, 1)
				|> String.split("\n", trim: true)
				|> Enum.at(1)
				|> String.split(",", trim: true)
				|> Enum.map(&String.to_integer/1)

				nearby = Enum.at(raw, 2)
				|> String.split(":\n", trim: true)
				|> Enum.at(1)
				|> String.split("\n", trim: true)
				|> Enum.map(fn line -> 
					line
					|> String.split(",", trim: true)
					|> Enum.map(&String.to_integer/1)
 				end)

				[rules, mine, nearby]

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day16.load("16.input.txt")

input |> Day16.part1 |> IO.inspect # 22000
#input |> Day16.part2 |> IO.inspect # 