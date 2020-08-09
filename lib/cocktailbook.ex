defmodule Cocktailbook do
  @moduledoc """
  Documentation for `Cocktailbook`.
  """

  @doc """
  Starts the app.
  """
  def run do
    print_menu()
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
end
