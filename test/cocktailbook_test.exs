defmodule CocktailbookTest do
  use ExUnit.Case
  doctest Cocktailbook

  test "greets the world" do
    assert Cocktailbook.hello() == :world
  end
end
