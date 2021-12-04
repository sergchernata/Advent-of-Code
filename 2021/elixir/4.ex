defmodule Day1 do
  def part1([numbers | boards]) do
    play_bingo(numbers, boards, false)
  end

  def part2([numbers | boards]) do
    play_bingo(numbers, boards, true)
  end

  def play_bingo([current | numbers], boards, last_only) do
    boards =
      Enum.map(boards, fn board ->
        Enum.map(board, fn cell -> if cell == current, do: "x", else: cell end)
      end)

    case bingo?(boards) do
      [false, boards] ->
        play_bingo(numbers, boards, last_only)

      [winner_sum, boards] ->
        if (last_only && boards == []) || !last_only do
          winner_sum * current
        else
          play_bingo(numbers, boards, last_only)
        end
    end
  end

  def bingo?(boards) do
    state =
      for board <- boards do
        rows = board |> Enum.chunk_every(5)

        cols =
          Enum.zip(rows) |> Enum.chunk_every(5) |> List.flatten() |> Enum.map(&Tuple.to_list/1)

        full_row = rows |> Enum.reject(fn row -> Enum.join(row) != "xxxxx" end) != []
        full_col = cols |> Enum.reject(fn row -> Enum.join(row) != "xxxxx" end) != []

        case full_row || full_col do
          true -> board |> Enum.reject(&(&1 == "x")) |> Enum.sum()
          false -> false
        end
      end

    winner_indexes =
      Enum.with_index(state)
      |> Enum.reject(fn {board_won, _index} -> !board_won end)
      |> Enum.map(&elem(&1, 1))

    updated_boards =
      Enum.reject(Enum.with_index(boards), fn {_board, index} ->
        Enum.member?(winner_indexes, index)
      end)
      |> Enum.map(&elem(&1, 0))

    case Enum.sort(state, :desc) |> Enum.dedup() do
      [false] -> [false, updated_boards]
      [false | sums] -> [hd(sums), updated_boards]
      [board_sum] -> [board_sum, []]
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        [numbers | boards] = String.split(body, "\n\n", trim: true)

        numbers = String.split(numbers, ",") |> Enum.map(&String.to_integer/1)

        boards =
          Enum.map(boards, fn board ->
            String.split(board, "\n")
            |> Enum.map(&String.split(&1, " ", trim: true))
            |> List.flatten()
            |> Enum.map(&String.to_integer/1)
          end)

        [numbers | boards]

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day1.load("4.input.txt")

# 31424
input |> Day1.part1() |> IO.inspect()
# 23042
input |> Day1.part2() |> IO.inspect()
