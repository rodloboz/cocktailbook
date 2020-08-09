defmodule Cocktailbook.View do
  @moduledoc false

  def display_cocktails(cocktails) do
    IO.puts "\nHere's the list of cocktails:\n"
    for {cocktail, index} <- Enum.with_index(cocktails) do
      IO.puts "#{index + 1} - Name: #{cocktail.name}"
    end
  end
end