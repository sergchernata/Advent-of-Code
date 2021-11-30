defmodule Day15 do
	def part1(input) do
		input |> prep() |> play(length(input)+1, 2020+1)
	end

	def part2(input) do
		input |> prep() |> play(length(input)+1, 30000000+1)
	end

	def prep(input) do
		input
		|> Enum.with_index
		|> Enum.map(fn {v,k} -> {v, [k+1, nil]} end)
		|> Enum.reverse
	end

	def play([{answer,_}|_], turn, target) when turn == target, do: answer
	def play(hist, turn, target) when turn < target do
		IO.inspect turn 
		{_, prev} = hist |> List.first

		case prev do
			[_,nil] ->
				#prev_zero = Enum.find_index(hist, fn {n,_} -> 0 == n end)
				#hist = List.delete_at(hist, prev_zero)
				{_,[p_said|_]} = Enum.find(hist, fn {n,_} -> 0 == n end)
				play([{0,[turn,p_said]}] ++ hist, turn+1, target)
			[a,b] ->
				new = a-b

				case Enum.find(hist, fn {n,_} -> new == n end) do
					{_,[p_said|_]} -> [{new,[turn,p_said]}] ++ hist
					nil -> [{new,[turn, nil]}] ++ hist
				end
				|> play(turn+1, target)
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				body
				|> String.split(",", trim: true)
				|> Enum.map(&String.to_integer/1)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day15.load("15.input.txt")

input |> Day15.part1 |> IO.inspect # 468
input |> Day15.part2 |> IO.inspect # 