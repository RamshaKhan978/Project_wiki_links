defmodule WikiLinks.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :link, :string
      add :tag, :string
      add :description, :string
      add :fav, :boolean, default: false, null: false

      timestamps()
    end
  end
end
