defmodule Cocktailbook do
  @moduledoc """
  Documentation for `Cocktailbook`.
  """

  alias Cocktailbook.Routes

  @doc """
  Starts the app.
  """
  def run do
    print_menu()
    ask_for_action()
  end

  defp print_menu do
    IO.puts """
      \n
      ========================\n
        Cocktail Concoctions\n
      ========================\n
      1. List Cocktails\n
      2. Add a Cocktail\n
      3. Remove a Cocktail\n
      4. Quit\n
    """
  end

  defp ask_for_action do
    IO.gets("\nWhich action? [1-4]\n> ")
    |> String.trim
    |> Integer.parse
    |> do_action
  end

  defp do_action({4, ""}) do
    IO.puts "\n\nGoobye!"
  end

  defp do_action({action, ""}) when action in 1..3 do
    Routes.route(action)
    run()
  end

  defp do_action(_) do
    IO.puts "Please type a valid option: [1-4]"
    ask_for_action()
  end
end
