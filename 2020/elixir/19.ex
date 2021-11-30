defmodule Day19 do
	def part1([rules,messages]) do
		a = Enum.find(rules, fn {_key, val} -> val == "a" end) |> elem(0)
		b = Enum.find(rules, fn {_key, val} -> val == "b" end) |> elem(0)
		rules = Map.drop(rules, [a, b])

		exp = make_exp(rules, a, b)

		Enum.filter(messages, fn m -> Regex.match?(exp, m) end) |> Enum.count
	end

	def part2(input) do
		input
	end

	def make_exp(rules, a, b) do
		exp = 
			Map.fetch!(rules, "0")
			|> String.split(" ", trim: true)
			|> Enum.map(fn rule_id ->
				cond do
					rule_id == a -> "a"
					rule_id == b -> "b"
					true -> traverse(rules, rule_id, a, b)			
				end
			end)
			|> Enum.join
		
		Regex.compile!("^#{exp}$")
	end

	def traverse(rules, rule_id, a, b) do
		cond do
			rule_id == a -> "a"
			rule_id == b -> "b"
			true ->
				rule = Map.fetch!(rules, rule_id)
				has_pipe = String.contains?(rule, "|")
				has_space = String.contains?(rule, " ")
	
				group = 
					cond do
						has_pipe  ->
							String.split(rule, " | ", trim: true) |> Enum.map(&String.split(&1, " ", trim: true))
						!has_pipe && has_space ->
							[String.split(rule, " ", trim: true)]
						!has_pipe && !has_space ->
							[[rule]]
					end
					|> Enum.map(fn rule ->
						rule |> Enum.map(fn rule_id -> traverse(rules, rule_id, a, b) end) |> Enum.join()
					end)
					|> Enum.join("|")

				"(#{group})"
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				[rules,messages] = String.split(body, "\n\n", trim: true)

				rules = rules
				|> String.split("\n", trim: true)
				|> Enum.map(fn rule -> 
					rule
					|> String.replace("\"", "")
					|> String.split(": ", trim: true)
				end)
				|> Enum.reduce(%{}, fn [i,r], acc ->
					Map.put(acc, i, r)
				end)

				messages = String.split(messages, "\n", trim: true)

				[rules,messages]

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day19.load("19.input.txt")

input |> Day19.part1 |> IO.inspect # 213
#input |> Day19.part2 |> IO.inspect # 