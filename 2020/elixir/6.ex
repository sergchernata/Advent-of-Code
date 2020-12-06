defmodule Day6 do
	def part1(input) do
		input
		|> Enum.map(fn group ->
			group
			|> String.replace("\n", "")
			|> String.codepoints()
			|> Enum.uniq()
			|> Enum.count()
		end)
		|> Enum.reduce(fn i, acc -> i + acc end)
	end

	def part2(input) do
		input
		|> Enum.map(fn group ->
			group
			|> String.split("\n")
			|> Enum.map(&String.codepoints/1)
			|> Enum.reduce(fn answers, acc ->
				MapSet.intersection(MapSet.new(answers), MapSet.new(acc))
			end)
			|> Enum.count()
		end)
		|> Enum.reduce(fn i, acc -> i + acc end)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body |> String.split("\n\n", trim: true)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day6.load("6.input.txt")

input |> Day6.part1 |> IO.inspect # 6530
input |> Day6.part2 |> IO.inspect # 3323