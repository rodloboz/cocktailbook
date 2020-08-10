defmodule Cocktailbook.Scraper do
  @moduledoc false

  @base_url "https://www.bbcgoodfood.com/search"

  def fetch_cocktails(query, count \\ 5) do
    HTTPoison.start
    response =
      @base_url <> "/recipes?query=#{query}"
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

  def fetch_cocktail(url \\ "") do
  end

  defp parse_recipes(body, count) do
    body
    |> Floki.find(".view-content article")
    |> Enum.take(count)
    |> Enum.map(&parse_article(&1))
    |> IO.inspect
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