defmodule Cocktailbook.Routes do
  @moduledoc false

  def route(1) do
    IO.puts "Listing cocktails"
  end

  def route(2) do
    IO.puts "Adding cocktail"
  end

  def route(3) do
    IO.puts "Removing cocktail"
  end
end