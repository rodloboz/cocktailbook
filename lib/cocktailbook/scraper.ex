defmodule Cocktailbook.Scraper do
  @moduledoc false

  @base_url "https://www.bbcgoodfood.com"

  alias Cocktailbook.Repo.Cocktail

  def fetch_cocktails(query, count \\ 5) do
    query =
      String.split(query, " ")
      |> Enum.join("+")
    HTTPoison.start
    response =
      @base_url <> "/search/recipes?query=#{query}"
      |> HTTPoison.get
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_recipes(body, count)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def fetch_cocktail(path \\ "/recipes/sherry-negroni") do
    HTTPoison.start
    response =
      @base_url <> path
      |> HTTPoison.get
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_cocktail(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp parse_cocktail(body) do
    %Cocktail{}
    |> parse_cocktail_name(body)
    |> parse_cocktail_ingredients(body)
  end

  defp parse_cocktail_name(%Cocktail{} = cocktail, body) do
    name =
      body
      |> Floki.parse_document!
      |> Floki.find("h1[itemprop=\"name\"]")
      |> Floki.text
      |> String.trim
    %{ cocktail | name: name }
  end

  defp parse_cocktail_ingredients(%Cocktail{} = cocktail, body) do
    ingredients =
      body
      |> Floki.parse_document!
      |> Floki.find(".ingredients-list ul > li")
      |> Enum.map(&Floki.attribute(&1, "content"))
      |> Enum.join(", ")
    %{ cocktail | ingredients: ingredients }
  end

  defp parse_recipes(body, count) do
    body
    |> Floki.parse_document!
    |> Floki.find(".view-content article")
    |> Enum.take(count)
    |> Enum.map(&parse_article/1)
  end

  defp parse_article(article) do
    article
    |> Floki.find("h3 a")
    |> parse_link
  end

  defp parse_link(link) do
    %{
      name: parse_name(link),
      href: parse_href(link)
    }
  end

  defp parse_name(link) do
    link
    |> Floki.text
    |> String.trim
  end

  defp parse_href(link) do
    link
    |> Floki.attribute("href")
    |> List.first
  end
end