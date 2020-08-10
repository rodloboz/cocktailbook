defmodule Cocktailbook.Repo do
  @moduledoc false

  alias Cocktailbook.Repo.Cocktail

  @csv_path "../../../data/cocktails.csv"

  # def list_cocktails do
  #   [
  #     %Cocktail{ name: "Negroni", ingredients: "1 ounce gin, 1 ounce Campari, 1 ounce sweet vermouth, Garnish: orange peel" },
  #     %Cocktail{ name: "Manhattan", ingredients: "2 ounces bourbon or rye, 1 ounce sweet vermouth, 2 dashes Angostura bitters, 1 dash orange bitters Garnish: brandied cherry" },
  #     %Cocktail{ name: "Mojito", ingredients: "3 mint leaves, 2 ounces white rum, 3/4 ounce fresh lime juice, 1/2 ounce simple syrup, club soda, to top, Garnish: mint sprig, Garnish: lime wheel" },
  #     %Cocktail{ name: "Cuba Libre", ingredients: "1 ounce rum, 3 ounces Coca-Cola, Garnish: lime wedge" },
  #     %Cocktail{ name: "Vesper Martini", ingredients: "3 oz Gin, 1 oz Vodka, 1/2 oz Lillet blanc apéritif, Garnish: Lemon twist" },
  #     %Cocktail{ name: "Old Fashioned", ingredients: "1/2 teaspoon sugar, 3 dashes Angostura bitters, 1 teaspoon water, 2 ounces bourbon, Garnish: orange peel" }
  #   ]
  # end

  def list_cocktails do
    load_cocktails()
  end

  def add_cocktail(%Cocktail{} = cocktail) do
    load_cocktails()
    |> List.insert_at(-1, cocktail)
    |> save_cocktails
  end

  def remove_cocktail(index) do
    load_cocktails()
    |> List.delete_at(index)
    |> save_cocktails
  end

  defp load_cocktails do
    @csv_path
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode
    |> Enum.to_list
    |> Enum.map(fn {:ok, [name, ingredients]} -> Cocktail.build(name, ingredients) end)
  end

  defp save_cocktails(cocktails) do
    file =
      @csv_path
      |> Path.expand( __DIR__)
      |> File.open!([:write, :utf8])

    cocktails
    |> Enum.map(&Cocktail.to_list/1)
    |> CSV.encode
    |> Enum.each(&IO.write(file, &1))
  end
end