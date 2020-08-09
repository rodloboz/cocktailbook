defmodule Cocktailbook.Repo.Cocktail do
  @moduledoc false

  alias Cocktailbook.Repo.Cocktail

  defstruct name: "", ingredients: ""

  @doc """
  Returns the number of ingredients in a cocktail.

   ## Examples
    iex> cocktail = %Cocktailbook.Repo.Cocktail{ name: "Negroni", ingredients: "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel" }
    iex> Cocktailbook.Repo.Cocktail.number_of_ingredients(cocktail)
    4
  """
  def number_of_ingredients(%Cocktail{} = cocktail) do
    cocktail.ingredients
    |> String.split(",")
    |> Enum.count
  end
end