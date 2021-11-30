defmodule Day23 do
	def part1(input) do
		current = hd(input)
		destination = current - 1
		input |> crab_cups(current, destination, 100)
	end

	def part2(input) do
		current = hd(input)
		destination = current - 1
		input = input ++ Enum.to_list(10..1000000)
		input |> crab_cups(current, destination, 10000000)
	end

	def crab_cups(cups, current, destination, moves)
	def crab_cups(cups, _current, _destination, 0) do
		index_of_one = Enum.find_index(cups, &(&1==1))

		Enum.slice(cups, index_of_one+1..length(cups)) ++ Enum.slice(cups, 0, index_of_one)
		|> Enum.join()
	end
	def crab_cups(cups, current, destination, moves) do
		index = Enum.find_index(cups, &(&1==current))
		IO.inspect moves
		pickup = 
			case index+4 > length(cups) do
				true  -> Enum.slice(cups, index+1, 3) ++ Enum.slice(cups, 0, index+4 - length(cups))
				false -> Enum.slice(cups, index+1, 3)
			end

		remaining = cups -- pickup
		destination = if destination < Enum.min(cups), do: Enum.max(remaining), else: destination
		insert_index = Enum.find_index(remaining, &(&1==destination))

		case Enum.member?([current|pickup], destination) do
			true  -> crab_cups(cups, current, destination-1, moves)
			false ->
				cups = List.insert_at(remaining, insert_index+1, pickup) |> List.flatten
				
				cups = 
					case index != Enum.find_index(cups, &(&1==current)) do
						true ->
							rotate = Enum.find_index(cups, &(&1==current)) - index
							Enum.slice(cups, rotate..-1) ++ Enum.slice(cups, 0..rotate-1)
						false -> cups
					end

				current = if index == length(cups)-1, do: hd(cups), else: Enum.at(cups, index+1)

				crab_cups(cups, current, current-1, moves-1)
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} -> 
				body |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)

			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day23.load("23.input.txt")

input |> Day23.part1 |> IO.inspect # 96342875
input |> Day23.part2 |> IO.inspect # 