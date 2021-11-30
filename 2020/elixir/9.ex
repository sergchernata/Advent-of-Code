defmodule Day9 do
	def part1(input) do
		input |> find_first_invalid(25, 25)
	end

	def part2(input) do
		{start,amount} = find_sum_range(input, 0, 1, 167829540)
		{min,max} = Enum.slice(input, start, amount) |> Enum.min_max()
		min + max
	end

	def find_first_invalid(input, index, tail_length) do
		num = Enum.at(input, index)

		tail_list = input
			|> Enum.slice(index-tail_length, tail_length)
			|> Enum.filter(fn v -> v < num end)

		case is_valid?(num, tail_list) do
			true  -> find_first_invalid(input, index + 1, tail_length)
			false -> num
		end
	end

	def is_valid?(num, tail_list) do
		permutations = for x <- tail_list, y <- tail_list, x != y, do: x + y
		Enum.member?(permutations, num)
	end

	def find_sum_range(input, index, range, target) do

		new_sum = input
			|> Enum.slice(index, range)
			|> Enum.reduce(fn x, acc -> x + acc end)
		
		cond do
			new_sum == target -> {index,range}
			new_sum > target -> find_sum_range(input, index + 1, 1, target)
			new_sum < target -> find_sum_range(input, index, range + 1, target)
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body
				|> String.split("\n", trim: true)
				|> Enum.map(&String.to_integer/1)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day9.load("9.input.txt")

input |> Day9.part1 |> IO.inspect # 167829540
input |> Day9.part2 |> IO.inspect # 28045630