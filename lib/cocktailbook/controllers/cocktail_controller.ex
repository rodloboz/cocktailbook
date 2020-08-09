defmodule Cocktailbook.CocktailController do
  @moduledoc false

  alias Cocktailbook.Repo
  alias Cocktailbook.Repo.Cocktail

  import Cocktailbook.View, only: [
    display_cocktails: 1,
    ask_for_name: 1,
    ask_for_ingredients: 1,
    ask_for_index: 1
  ]

  def list do
    Repo.load_cocktails
    |> display_cocktails
  end

  def create do
    %Cocktail{}
    |> ask_for_name
    |> ask_for_ingredients
    |> Repo.add_cocktail
  end

  def destroy do
    Repo.load_cocktails
    |> display_cocktails
    |> ask_for_index
    |> Repo.remove_cocktail
  end
end