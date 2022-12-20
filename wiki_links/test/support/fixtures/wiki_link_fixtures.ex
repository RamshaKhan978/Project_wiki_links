defmodule WikiLinks.Wiki_linkFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WikiLinks.Wiki_link` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        description: "some description",
        fav: true,
        link: "some link",
        tag: "some tag"
      })
      |> WikiLinks.Wiki_link.create_link()

    link
  end
end
