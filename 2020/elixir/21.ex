defmodule Day21 do
	def part1(input) do
		questionable_ingredients = 
			Enum.reduce(input, [], fn [ingredients, allergens], sketchy ->
				ingredients 
				|> Enum.map(fn ingredient -> 
					input
					|> Enum.filter(fn [c_i, c_a] -> [c_i, c_a] != [ingredients, allergens] end)
					|> Enum.filter(fn [c_i, c_a] -> Enum.member?(c_i, ingredient) end)
					|> Enum.map(fn [c_i, c_a] ->
						if Enum.any?(allergens, fn a -> a in c_a end) do
							[ingredient|sketchy]
						end
					end)
					|> Enum.filter(&(&1))
					|> List.flatten
					|> Enum.uniq
				end)
				|> List.flatten
			end)
			|> Enum.uniq

		all_ingredients = Enum.map(input, fn [i, _a] -> i end) |> List.flatten |> Enum.frequencies

		ok_ingredients = all_ingredients -- questionable_ingredients
	end

	def part2(input) do
		input
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				body
				|> String.split("\n", trim: true)
				|> Enum.map(fn line ->
					[ingredients, allergens] = line
					|> String.split(" (contains ", trim: true)
					
					ingredients = String.split(ingredients, " ", trim: true)
					allergens = String.slice(allergens, 0..-2) |> String.split(" ", trim: true)

					[ingredients, allergens]
				end)

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day21.load("21.input.txt")

input |> Day21.part1 |> IO.inspect # 
#input |> Day21.part2 |> IO.inspect # 