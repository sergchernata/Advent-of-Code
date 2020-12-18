defmodule Day18 do
	def part1(input) do
		input
		|> Enum.map(fn line -> 
			unwrap_parenthesis(line, true) |> do_math(["+","*"]) |> String.to_integer
		end)
		|> Enum.sum
	end

	def part2(input) do
		input
		|> Enum.map(fn line -> 
			unwrap_parenthesis(line, false) |> do_math("+") |> do_math("*") |> String.to_integer
		end)
		|> Enum.sum
	end

	def unwrap_parenthesis(line, sequential) do
		case String.match?(line, ~r/\([0-9\*\+ ]*\)/) do
			true  ->
				group = Regex.scan(~r/\([0-9\*\+ ]*\)/, line) |> List.flatten |> List.first
				stripped = String.slice(group, 1..-2)
				solved = 
					case sequential do
						true  -> do_math(stripped, ["+","*"])
						false -> do_math(stripped, "+") |> do_math("*")
					end
				
				unwrap_parenthesis(String.replace(line, group, "#{solved}"), sequential)
			false -> line
		end
	end

	def do_math(line, ops) do
		case String.contains?(line, ops) do
			true  ->
				expression = 
					case ops do
						[_,_] -> ~r/\d+ [\*\+] \d+/
						"*" -> ~r/\d+ \* \d+/
						"+" -> ~r/\d+ \+ \d+/
					end
				pair = Regex.scan(expression, " #{line} ") |> List.flatten |> List.first
				type = if String.contains?(pair,  "*"), do: "*", else: "+"
				[a,b] = String.split(pair, " #{type} ", trim: true) |> Enum.map(&String.to_integer/1)
				product = if type == "*", do: a*b, else: a+b
				line = String.replace(" #{line} ", " #{pair} ", " #{product} ", global: false)

				do_math(String.trim(line), ops)
			false -> line
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body |> String.split("\n", trim: true)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day18.load("18.input.txt")

input |> Day18.part1 |> IO.inspect # 1890866893020
input |> Day18.part2 |> IO.inspect # 34646237037193