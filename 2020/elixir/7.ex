defmodule Day7 do
	def part1(input) do
		input |> count_containers(["shiny gold"])
	end

	def part2(input) do
		input |> count_required("shiny gold")
	end

	def count_containers(tree, search, containers \\ [])
	def count_containers(_, search, containers) when search == [],
		do: containers |> Enum.uniq() |> Enum.count()
	def count_containers(tree, search, containers) do
		found = tree
			|> Enum.map(fn [color | contents] -> 
				if String.contains?(contents |> List.first, search) do
					color
				end
			end)
			|> Enum.filter(&(&1))

		count_containers(tree, found, containers ++ found)
	end

	def count_required(_, search) when search == [], do: quantity
	def count_required(tree, search) do
		tree
		|> Enum.map(fn [color | contents] -> 
			#IO.inspect "Processing #{color}, looking for #{search}"

			if color == search do
				is_empty = contents == ["no other bags."]

				if !is_empty do
					contents
					|> List.first
					|> String.replace([".", " bags", "bag"], "")
					|> String.split(", ")
					|> Enum.map(fn bag ->	
						[child_count, child_color] = String.split(bag, " ", parts: 2)
						IO.inspect "Processing #{child_color} children"
						# num_children = count_required(tree, child_color, required)
						IO.inspect count_required(tree, child_color, quantity)
						# #IO.inspect "#{child_count} #{search} bags contain #{num_children} #{child_color} bags"
						# String.to_integer(child_count) + String.to_integer(child_count) * num_children
						child_count
					end)
				end
			end
		end)

		# |> List.flatten()
		# |> IO.inspect
		# |> Enum.reduce(fn x, acc -> x * acc end)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> body
				|> String.split("\n", trim: true)
				|> Enum.map(& String.split(&1, " bags contain "))
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day7.load("7.input.txt")

input |> Day7.part1 |> IO.inspect # 213
input |> Day7.part2 |> IO.inspect # 