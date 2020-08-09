defmodule Cocktailbook.Routes do
  @moduledoc false

  alias Cocktailbook.CocktailController

  def route(1) do
    CocktailController.list
  end

  def route(2) do
    IO.puts "Adding cocktail"
  end

  def route(3) do
    IO.puts "Removing cocktail"
  end
end