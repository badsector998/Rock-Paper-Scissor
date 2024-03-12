defmodule RockPaperScissor do

  use Application

  def start(_type, _args) do
    RockPaperScissor.main()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  def main() do
    rps = [:Rock, :Paper, :Scissor]
    computer = Enum.random(rps)
    player = IO.gets("Bet on!\n")
      |> String.trim()
      |> String.to_existing_atom()
    check(computer, player)
  end

  def check(computer, player) do

    victories = %{
      Rock: :Paper,
      Paper: :Scissor,
      Scissor: :Rock,
    }

    cond do
      computer === player ->
        IO.puts("It's a tie!")
      computer === victories[player] ->
        IO.puts("Computer Wins!")
      true ->
        IO.puts("You won!")
    end

    again = IO.gets("Wanna Play Again?\n")
      |> String.trim()
    if again === "y" do
      main()
    else
      IO.puts("Thank You For Playing!")
      exit(:normal)
    end
  end

end
