defmodule Day2 do
	def part1(input) do
		input
		|> Enum.filter(fn [_, min, max, letter, password] ->
				String.match?(password, ~r/^([^#{letter}]*#{letter}[^#{letter}]*){#{min},#{max}}$/)
			end)
		|> Enum.count
	end

	def part2(input) do
		input
		|> Enum.filter(fn [_, min, max, letter, password] ->
				chars = String.codepoints(password)
				first = Enum.at(chars, String.to_integer(min) - 1)
				second = Enum.at(chars, String.to_integer(max) - 1)
				(first == letter && second != letter) || (first != letter && second == letter)
			end)
		|> Enum.count
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body 
						   |> String.split("\n", trim: true)
						   |> Enum.map(& Regex.run(~r/(\d+)-(\d+) ([a-z]): ([a-z]*)/, &1))
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day2.load("2.input.txt")

input |> Day2.part1 |> IO.inspect # 515
input |> Day2.part2 |> IO.inspect # 711