defmodule Cocktailbook.Routes do
  @moduledoc false

  alias Cocktailbook.CocktailController

  def route(1) do
    CocktailController.list
  end

  def route(2) do
    CocktailController.create
  end

  def route(3) do
    CocktailController.destroy
  end

  def route(4) do
    CocktailController.import
  end
end