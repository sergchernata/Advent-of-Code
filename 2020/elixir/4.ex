defmodule Day4 do
	def part1(input) do
		input
		|> Enum.count(fn passport -> has_required_fields(passport) end)
	end

	def part2(input) do
		input
		|> Enum.count(fn passport -> has_required_fields(passport) && fields_are_valid(passport) end)
	end

	def has_required_fields(passport) do
		Regex.match?(~r/.*(?=.*iyr)(?=.*eyr)(?=.*hcl)(?=.*pid)(?=.*hgt)(?=.*byr)(?=.*ecl).*/, passport)
	end

	def fields_are_valid(passport) do
		Regex.match?(~r/.*byr:(19[2-9]\d|200[0-2])/, passport) &&
		Regex.match?(~r/.*iyr:(201\d|2020)/, passport) &&
		Regex.match?(~r/.*eyr:(202\d|2030)/, passport) &&
		Regex.match?(~r/.*hgt:((1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in)/, passport) &&
		Regex.match?(~r/.*hcl:#[0-9a-f]{6}/, passport) &&
		Regex.match?(~r/.*ecl:(amb|blu|brn|gry|grn|hzl|oth)/, passport) &&
		Regex.match?(~r/.*pid:[0-9]{9}( |$)/, passport)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body 
						   |> String.split("\n\n", trim: true)
						   |> Enum.map(& String.replace(&1, "\n", " "))
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day4.load("4.input.txt")

input |> Day4.part1 |> IO.inspect # 226
input |> Day4.part2 |> IO.inspect # 160