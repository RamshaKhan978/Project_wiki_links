defmodule WikiLinks.Wiki_link.Link do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query


  schema "links" do
    field :description, :string
    field :fav, :boolean, default: false
    field :link, :string
    field :tag, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:link, :tag, :description, :fav])
    |> validate_required([:link, :tag, :description, :fav])
  end

  def search(query, search_term) do
    wildcard_search = "%#{search_term}%"

    from link in query,
    where: ilike(link.link, ^wildcard_search)
  end


  def search_tag(query, search_tag) do
    wildcard_search_tag = "%#{search_tag}%"
    from link in query,
    where: ilike(link.tag, ^wildcard_search_tag)
  end

  def search_link_tag(query,search_tag,search_link) do
    wildcard_tag = "%#{search_tag}%"
    wildcard_link = "%#{search_link}%"

    from link in query,
    where: ilike(link.tag, ^wildcard_tag),
    where: ilike(link.link, ^wildcard_link)
  end
end
