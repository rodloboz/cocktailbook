defmodule Cocktailbook.CocktailController do
  @moduledoc false

  alias Cocktailbook.Repo

  import Cocktailbook.View, only: [display_cocktails: 1]

  def list do
    Repo.list_cocktails
    |> display_cocktails
  end
end