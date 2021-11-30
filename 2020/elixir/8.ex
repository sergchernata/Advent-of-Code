defmodule Day8 do
	def part1(input) do
		input |> traverse([], 0, 0) |> elem(0)
	end

	def part2(input) do
		#input |> replace("jmp", "nop", 1)
	end

	def replace(input, from, to, i) do

		count = 0

		result = input
		|> Enum.map(fn [command|quant] -> 
			IO.inspect count
			if command == from && count == i do
				[to,quant |> List.first]
			else
				count = count + 1
				[command,quant |> List.first]
			end
		end)
		|> IO.inspect
		|> traverse([], 0, 0)

		if result |> elem(1) |> Enum.max >= length(input) do
			result |> elem(0)
		else 
			input |> replace("nop", "jmp", count)
		end
	end

	def traverse(input, history, index, acc) do
		[command|quant] = Enum.at(input, index)
		quant = String.to_integer(quant |> List.first)

		history = [index|history]
		#IO.inspect "#{index} - #{command} #{quant}"
		next_index = if command == "jmp", do: index + quant, else: index + 1
		acc = if command == "acc", do: acc + quant, else: acc
		if Enum.member?(history, next_index) || next_index >= length(input) do
			IO.inspect next_index >= length(input)
			{acc, history}
		else
			traverse(input, history, next_index, acc)
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body
				|> String.split("\n", trim: true)
				|> Enum.map(& String.split(&1, " "))
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day8.load("8.input.txt")

input |> Day8.part1 |> IO.inspect # 2025
input |> Day8.part2 |> IO.inspect # 