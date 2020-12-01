defmodule Day1 do
	def part1(input) do		
		for x <- input, y <- input, x + y == 2020 do 
			x * y
		end
	end

	def part2(input) do		
		for x <- input, y <- input, z <- input, x + y + z == 2020 do 
			x * y * z
		end
	end

	def load(file) do
		case File.read(file) do
		  {:ok, body} -> body |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
		  {:error, _} -> IO.puts "Couldn't open the file."
		end
	end
end

input = Day1.load("1.input.txt")

input |> Day1.part1 |> IO.inspect # 703131
input |> Day1.part2 |> IO.inspect # 272423970