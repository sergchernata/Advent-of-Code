defmodule Day14 do
	def part1(input) do
		input |> v1_decoder()
	end

	def part2(input) do
		input |> v2_decoder()
	end

	def v2_decoder(input, mask \\ "", mem \\ %{})
	def v2_decoder(input, _mask, mem) when input == [] do
		mem
		|> Map.to_list()
		|> Enum.map(fn {_,v} -> v end)
		|> Enum.reduce(&(&1+&2))
	end
	def v2_decoder([{cmd, val} | tail], mask, mem) do
		case cmd do
			"mask" -> v2_decoder(tail, val, mem)
			_ -> 
				addresses = find_addresses(mask, cmd)
				
				updates = Enum.reduce(addresses, %{}, fn x, acc ->
					Map.put(acc, x, val)
				end)

				v2_decoder(tail, mask, Map.merge(mem, updates))
		end
	end

	def v1_decoder(input, mask \\ "", mem \\ %{})
	def v1_decoder(input, _mask, mem) when input == [] do
		mem
		|> Map.to_list()
		|> Enum.map(fn {_,v} -> v end)
		|> Enum.reduce(&(&1+&2))
	end
	def v1_decoder([{cmd, val} | tail], mask, mem) do
		case cmd do
			"mask" -> v1_decoder(tail, val, mem)
			_ -> v1_decoder(tail, mask, Map.put(mem, cmd, apply_mask(mask, val)))
		end
	end

	def find_addresses(mask, val) do
		mask = Enum.reverse(mask)

		template = val
		|> Integer.to_string(2)
		|> String.pad_leading(36, "0")
		|> String.split("", trim: true)
		|> Enum.reverse()
		|> Enum.with_index()
		|> Enum.map(fn {v,k} -> 
			case Enum.at(mask,k) do
				"1" -> 1
				"0" -> v
				"X" -> "X"
			end
		end)

		template
		|> Enum.frequencies()
		|> Map.get("X")
		|> perms()
		|> Enum.map(&String.split(&1, "", trim: true))
		|> Enum.map(&perm_to_address(&1,template))
	end

	def perm_to_address([head|tail], template) do
		index = Enum.find_index(template, fn t -> t == "X" end)
		template = List.replace_at(template, index, head)

		case Enum.find(template, fn t -> t == "X" end) do
			nil -> template |> Enum.join |> String.reverse|> Integer.parse(2) |> elem(0)
			_ -> perm_to_address(tail, template)
		end
	end

	def perms(count) do
		for i <- 0..floor(:math.pow(2,count))-1 do
			Integer.to_string(i, 2)
			|> String.pad_leading(count, "0")
		end
	end

	def apply_mask(mask, val) do
		mask = Enum.reverse(mask)

		val
		|> Integer.to_string(2)
		|> String.pad_leading(36, "0")
		|> String.split("", trim: true)
		|> Enum.reverse()
		|> Enum.with_index()
		|> Enum.map(fn {v,k} -> 
			case Enum.at(mask,k) do
				"1" -> 1
				"0" -> 0
				"X" -> v
			end
		end)
		|> Enum.reverse()
		|> Enum.join()
		|> Integer.parse(2)
		|> elem(0)
	end

	def load(file) do
		case File.read(file) do
			{:ok, body} ->
				body
				|> String.split("\n", trim: true)
				|> Enum.map(fn i -> 
					[cmd,val] = String.split(i, " = ")
					case cmd == "mask" do
						true  -> {cmd, String.split(val, "", trim: true)}
						false -> {String.replace(cmd, ["mem[","]"], "") |> String.to_integer(), val |> String.to_integer()}
					end
				end)
			{:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day14.load("14.input.txt")

input |> Day14.part1 |> IO.inspect # 15403588588538
input |> Day14.part2 |> IO.inspect # 3260587250457