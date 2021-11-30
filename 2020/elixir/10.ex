defmodule Day10 do
	def part1(input) do
		{one, three} = input |> traverse()
		one * three
	end

	def part2(input) do
		input
		|> find_permutations()
		|> IO.inspect
		|> flatten()
		|> Enum.uniq()
		|> Enum.count()
	end

	def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
	def flatten([]), do: []
	def flatten(element), do: [element]

	def find_permutations(input) do
		{min,max} = Enum.min_max(input)

		for item <- input do
			if item != min && item != max do
				perm = List.delete(input, item)
				if valid_permutation?(perm) do
					[Enum.join(perm, ",")|find_permutations(perm)]
				end
			end
		end
	end

	def valid_permutation?(input) do
		for {current, k} <- Enum.with_index(input) do
			next = Enum.at(input, k + 1)

			if next do
				next - current == 1 || next - current <= 3
			end
		end
		|> Enum.member?(false) |> Kernel.not
	end

	def traverse(input, index \\ 0, offset \\ 1, collector \\ {0,0})
	def traverse(input, index, _offset, {one, three}) when index == length(input) - 1, do: {one, three}
	def traverse(input, index, offset, {one, three}) do
		current = Enum.at(input, index)
		next = Enum.at(input, index + offset)

		cond do
			next - current == 1 -> traverse(input, index + 1, 1, {one + 1, three})
			next - current == 3 -> traverse(input, index + 1, 1, {one, three + 1})
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				data = body
				|> String.split("\n", trim: true)
				|> Enum.map(&String.to_integer/1)
				|> List.insert_at(0, 0)
				
				[Enum.max(data) + 3 | data] |> Enum.sort()
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day10.load("10.input.txt")

input |> Day10.part1 |> IO.inspect # 2263
input |> Day10.part2 |> IO.inspect # 