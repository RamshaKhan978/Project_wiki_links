defmodule WikiLinks.Wiki_link.Link do
  use Ecto.Schema
  import Ecto.Changeset

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
end
