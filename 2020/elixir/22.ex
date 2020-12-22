defmodule Day22 do
	def part1(input) do
		input |> combat
	end

	def part2(input) do
		input |> recursive_combat
	end

	def recursive_combat(decks, history \\ [], is_subgame \\ false)
	def recursive_combat([[], _deck], _history, true), do: "p2"
	def recursive_combat([_deck, []], _history, true), do: "p1"
	def recursive_combat([[], deck], _history, false), do: score(deck)
	def recursive_combat([deck, []], _history, false), do: score(deck)
	def recursive_combat([[p1_card|p1_tail], [p2_card|p2_tail]], history, is_subgame) do
		signature = {[p1_card|p1_tail], [p2_card|p2_tail]}

		cond do
			Enum.member?(history, signature) -> "p1"
			p1_card <= length(p1_tail) and p2_card <= length(p2_tail) ->
				p1_subdeck = Enum.slice(p1_tail, 0, p1_card)
				p2_subdeck = Enum.slice(p2_tail, 0, p2_card)

				winner = recursive_combat([p1_subdeck, p2_subdeck], [], true)

				case winner do
					"p1" -> recursive_combat([p1_tail ++ [p1_card] ++ [p2_card], p2_tail], [signature|history], is_subgame)
					"p2" ->	recursive_combat([p1_tail, p2_tail ++ [p2_card] ++ [p1_card]], [signature|history], is_subgame)
					_ 	 -> winner
				end
			true ->
				case p1_card > p2_card do
					true  -> recursive_combat([p1_tail ++ [p1_card] ++ [p2_card], p2_tail], [signature|history], is_subgame)
					false -> recursive_combat([p1_tail, p2_tail ++ [p2_card] ++ [p1_card]], [signature|history], is_subgame)
				end
		end
	end

	def combat([deck, []]), do: score(deck)
	def combat([[], deck]), do: score(deck)
	def combat([[p1_card|p1_tail], [p2_card|p2_tail]]) do
		case p1_card > p2_card do
			true  -> combat([p1_tail ++ [p1_card] ++ [p2_card], p2_tail])
			false -> combat([p1_tail, p2_tail ++ [p2_card] ++ [p1_card]])
		end
	end

	def score(deck) do
		deck
		|> Enum.reverse
		|> Enum.with_index
		|> Enum.reduce(0, fn {v, k}, acc -> acc + (v * (k+1)) end)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				body
				|> String.split("\n\n", trim: true)
				|> Enum.map(fn player ->
					player
					|> String.split("\n")
					|> Enum.slice(1..-1)
					|> Enum.map(&String.to_integer/1)
				end)

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day22.load("22.input.txt")

input |> Day22.part1 |> IO.inspect # 34664
input |> Day22.part2 |> IO.inspect # 32018