defmodule Day do
  def part1(input) do
    input
    |> simulate_rounds(20)
    |> IO.inspect(charlists: :as_lists)
    |> Enum.map(&Map.get(&1, :count))
    |> Enum.sort()
    |> Enum.take(-2)
    |> Enum.product()
  end

  def part2(input) do
    # input
  end

  defp simulate_rounds(monkeys, 0), do: monkeys

  defp simulate_rounds(monkeys, num_rounds),
    do: do_round(monkeys) |> simulate_rounds(num_rounds - 1)

  defp do_round(monkeys, current \\ 0)

  defp do_round(monkeys, current) when current == length(monkeys), do: monkeys

  defp do_round(monkeys, current) do
    current_monkey = Enum.at(monkeys, current)

    case current_monkey.items do
      [] ->
        do_round(monkeys, current + 1)

      items ->
        monkeys =
          items
          |> Enum.map(&(current_monkey.operation.(&1) |> div(3) |> round()))
          |> Enum.with_index()
          |> Enum.reduce(monkeys, fn {item, index}, monkeys ->
            target_monkey_index =
              case current_monkey.test.(item) do
                true -> current_monkey.passed
                false -> current_monkey.failed
              end

            target_monkey = Enum.at(monkeys, target_monkey_index)

            current_monkey = Map.put(current_monkey, :items, [])

            target_monkey =
              target_monkey
              |> Map.put(:items, Map.get(target_monkey, :items) ++ [item])
              |> Map.put(:count, Map.get(target_monkey, :count) + 1)

            monkeys
            |> List.replace_at(current, current_monkey)
            |> List.replace_at(target_monkey_index, target_monkey)
          end)

        do_round(monkeys, current + 1)
    end
  end

  def load(file) do
    case File.read(file) do
      {:ok, body} ->
        body
        |> String.split("\n\n", trim: true)
        |> Enum.map(fn line ->
          [monkey, items, operation, test, passed, failed] =
            String.split(line, "\n") |> Enum.map(&String.trim(&1))

          items =
            String.replace(items, "Starting items: ", "")
            |> String.split(", ")
            |> Enum.map(&String.to_integer(&1))

          count = length(items)

          [operation, quant] =
            String.replace(operation, "Operation: new = old ", "") |> String.split(" ")

          operation =
            case quant do
              "old" ->
                case operation do
                  "+" -> fn old -> old + old end
                  "*" -> fn old -> old * old end
                end

              _ ->
                case operation do
                  "+" -> fn old -> old + String.to_integer(quant) end
                  "*" -> fn old -> old * String.to_integer(quant) end
                end
            end

          divisible_by = String.replace(test, "Test: divisible by ", "") |> String.to_integer()
          test = fn a -> rem(a, divisible_by) == 0 end

          passed = String.replace(passed, "If true: throw to monkey ", "") |> String.to_integer()
          failed = String.replace(failed, "If false: throw to monkey ", "") |> String.to_integer()

          %{
            items: items,
            count: count,
            operation: operation,
            test: test,
            passed: passed,
            failed: failed
          }
        end)

      {:error, _} ->
        IO.puts("Couldn't open the file.")
    end
  end
end

input = Day.load("11.input.txt")

# 
input |> Day.part1() |> IO.inspect()
# 
input |> Day.part2() |> IO.inspect()
