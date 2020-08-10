defmodule Cocktailbook.Repo.Cocktail do
  @moduledoc false

  alias Cocktailbook.Repo.Cocktail

  defstruct name: "", ingredients: ""

  @doc """
  Builds a cocktail struct.

   ## Examples
    iex> name = "Negroni"
    iex> ingredients = "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel"
    iex> Cocktailbook.Repo.Cocktail.build(name, ingredients)
    %Cocktailbook.Repo.Cocktail{ name: "Negroni", ingredients: "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel" }
  """
  def build(name, ingredients) do
    %Cocktail{name: name, ingredients: ingredients}
  end

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

  @doc """
  Converts a cocktail to a string.

   ## Examples
    iex> cocktail = %Cocktailbook.Repo.Cocktail{ name: "Negroni", ingredients: "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel" }
    iex> Cocktailbook.Repo.Cocktail.to_string(cocktail)
    "Name: Negroni (4 ingredients)"
  """
  def to_string(%Cocktail{} = cocktail) do
    "Name: #{cocktail.name} (#{number_of_ingredients(cocktail)} ingredients)"
  end

  @doc """
  Converts a cocktail to a list.

   ## Examples
    iex> cocktail = %Cocktailbook.Repo.Cocktail{ name: "Negroni", ingredients: "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel" }
    iex> Cocktailbook.Repo.Cocktail.to_list(cocktail)
    ["Negroni", "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel"]
  """
  def to_list(%Cocktail{} = cocktail) do
    [cocktail.name, cocktail.ingredients]
  end
end