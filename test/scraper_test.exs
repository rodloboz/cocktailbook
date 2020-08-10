defmodule ScraperTest do
  use ExUnit.Case, async: true

  alias Cocktailbook.Scraper
  alias Cocktailbook.Repo.Cocktail

  describe "#fetch_cocktails" do
    test "returns a list of 5 scraped cocktails" do
      result = Scraper.fetch_cocktails("mojito")

      assert result == [
        %{
          href: "/recipes/mojito-pitcher",
          name: "Mojito pitcher"
        },
        %{
          href: "/recipes/champagne-mojito",
          name: "Champagne mojito"
        },
        %{
          href: "/recipes/mojito-mocktail",
          name: "Mojito mocktail"
        },
        %{
          href: "/recipes/bergamot-mojito",
          name: "Bergamot mojito"
        },
        %{
          href: "/recipes/vietnamese-mojito",
          name: "Vietnamese mojito"
        }
      ]
    end
    test "accepts an optional number of cocktails to scrape argument" do
      result = Scraper.fetch_cocktails("negroni", 2)

      assert result == [
        %{
          href: "/recipes/classic-negroni",
          name: "Classic negroni"
        },
        %{
          href: "/recipes/sherry-negroni",
          name: "Sherry negroni"
        }
      ]
    end
  end

  describe "#fetch_cocktail" do
    test "returns aCocktail struct with scraped data" do
      result = Scraper.fetch_cocktail("/recipes/classic-negroni")

      assert result == %Cocktail{
        name: "Classic negroni",
        ingredients: "25ml gin, 25ml sweet vermouth (we used Antica formula), 25ml Campari, ice, slice of orange"
      }
    end
  end
end
