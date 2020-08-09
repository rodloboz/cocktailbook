defmodule Cocktailbook.View do
  @moduledoc false

  alias Cocktailbook.Repo.Cocktail

  def display_cocktails(cocktails) do
    IO.puts "\nHere's the list of cocktails:\n"
    for {cocktail, index} <- Enum.with_index(cocktails) do
      IO.puts "#{index + 1} - Name: #{cocktail.name}"
    end
    cocktails
  end

  def ask_for_index(cocktails) do
    index =
      IO.gets("\nWhat's the number of the cocktail to remove?\n> ")
      |> String.trim
      |> Integer.parse

    case index do
      {i, ""} when i in 1..length(cocktails) -> i - 1
      _ -> IO.puts("Pick a valid cocktail!"); ask_for_index(cocktails)
    end
  end

  def ask_for_name(%Cocktail{} = cocktail) do
    name =
      IO.gets("\nWhat's the name of the cocktail?\n> ")
      |> String.trim
    %{ cocktail | name: name }
  end

  def ask_for_ingredients(%Cocktail{} = cocktail) do
    ingredients =
      IO.gets("\nWhat are the ingredients of the cocktail?\n> ")
      |> String.trim
    %{ cocktail | ingredients: ingredients }
  end
end