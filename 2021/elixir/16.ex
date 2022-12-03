defmodule Day do
  def part1(input) do
    Enum.map(input, &string_to_binary(&1)) |> Enum.join() |> parse_packet()
  end

  def part2(_input) do
  end

  def parse_packet(packet) do
    {version, packet} = String.split_at(packet, 3)
    {type, packet} = String.split_at(packet, 3)

    case b_to_i(type) do
      4 ->
        {a, packet} = String.split_at(packet, 5)
        {b, packet} = String.split_at(packet, 5)
        {c, packet} = String.split_at(packet, 5)

        a = String.slice(a, 1, String.length(a))
        b = String.slice(b, 1, String.length(b))
        c = String.slice(c, 1, String.length(c))

        b_to_i(a <> b <> c)

      _ ->
        {length_type, packet} = String.split_at(packet, 1)

        case length_type do
          "1" ->
            {num_packets, packet} = String.split_at(packet, 11)
            num_packets = b_to_i(num_packets)

          _ ->
            {total_length, packet} = String.split_at(packet, 15)
            total_length = b_to_i(total_length)

            String.graphemes(packet)
            |> Enum.chunk_every(total_length)
            |> Enum.map(&Enum.join(&1))
            |> Enum.reverse()
            |> tl()
            |> Enum.reverse()
        end
    end
  end

  def b_to_i(value) do
    String.to_integer(value, 2)
  end

  def string_to_binary(string) do
    String.to_integer(string, 16) |> Integer.to_string(2) |> String.pad_leading(4, "0")
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} -> String.split(body, "", trim: true)
      {:error, _} -> IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("16.input.txt")

#
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
