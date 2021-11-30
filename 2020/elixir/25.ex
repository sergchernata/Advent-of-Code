defmodule Day25 do
	def part1([card_public_key, door_public_key]) do
		card_loop_size = find_loop_size(1, 7, card_public_key, 1)
		transform(1, door_public_key, card_loop_size)
	end

	def find_loop_size(value, subject, target, loops) do
		product = rem(value * subject, 20201227)
		case product == target do
			true -> loops
			false -> find_loop_size(product, subject, target, loops+1)
		end
	end

	def transform(value, _subject, 0), do: value
	def transform(value, subject, loops) do
		rem(value * subject, 20201227)
		|> transform(subject, loops-1)
	end

	def part2(input) do
		input

	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				body
				|> String.split("\n", trim: true)
				|> Enum.map(&String.to_integer/1)

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day25.load("25.input.txt")

input |> Day25.part1 |> IO.inspect # 15467093
#input |> Day25.part2 |> IO.inspect # 