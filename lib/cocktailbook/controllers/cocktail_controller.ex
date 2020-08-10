defmodule Cocktailbook.CocktailController do
  @moduledoc false

  alias Cocktailbook.Repo
  alias Cocktailbook.Repo.Cocktail
  alias Cocktailbook.Scraper

  import Cocktailbook.View, only: [
    display_cocktails: 1,
    display_results: 1,
    ask_for_name: 1,
    ask_for_ingredients: 1,
    ask_for_index: 2,
    ask_for_search: 0
  ]

  def list do
    Repo.list_cocktails
    |> display_cocktails
  end

  def create do
    %Cocktail{}
    |> ask_for_name
    |> ask_for_ingredients
    |> Repo.add_cocktail
  end

  def destroy do
    Repo.list_cocktails
    |> display_cocktails
    |> ask_for_index(:remove)
    |> Repo.remove_cocktail
  end

  def import do
    results =
      ask_for_search()
      |> Scraper.fetch_cocktails
      |> display_results

    index = ask_for_index(results, :import)
    %{ name: _, href: path } = Enum.at(results, index)
    Scraper.fetch_cocktail(path)
    |> Repo.add_cocktail
  end
end