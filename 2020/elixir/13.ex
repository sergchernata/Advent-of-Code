defmodule Day13 do
	def part1(input) do
		input |> earliest_departure()
	end

	def part2({_,ids}) do
		[first|rest] = ids

		ids
		|> Enum.with_index()
		|> Enum.filter(fn {v,k} -> v != "x" end)
		#|> earliest_timestamp2(99999999999963, first)
		|> earliest_timestamp2(99999999999963)
	end

	def earliest_departure({timestamp,ids}) do
		{delta, index} = ids
			|> Enum.map(fn id ->
				case id do
					"x"  -> id
					_ -> (floor(timestamp / id) * id + id) - timestamp
				end
			end)
			|> Enum.with_index()
			|> Enum.min()

		Enum.at(ids, index) * delta
	end

	def earliest_timestamp(ids, counter, increment) do
		IO.inspect ids
		ids
		|> Enum.map(fn {v,k} -> 
			case v != increment do
				true  -> floor(counter / v) * v + v - counter == k
				false -> true
			end
		end)
		|> Enum.member?(false)
		|> case do
			true  -> earliest_timestamp(ids, counter + increment, increment)
			false -> counter
		end
	end

	def earliest_timestamp2(ids, iter) do
		{first_v,first_k} = List.first(ids)
		{last_v,last_k} = List.last(ids)
		IO.inspect iter
		if 1 == 22 * x == iter do

		else
			earliest_timestamp2(ids, iter + first_v)
		end
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				[timestamp|ids] = body
				|> String.split("\n", trim: true)

				timestamp = String.to_integer(timestamp)

				ids = ids
				|> List.first()
				|> String.split(",")
				|> Enum.map(fn i -> if i=="x", do: i, else: String.to_integer(i) end)

				{timestamp,ids}
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day13.load("13.input.txt")

input |> Day13.part1 |> IO.inspect # 3246
input |> Day13.part2 |> IO.inspect # 