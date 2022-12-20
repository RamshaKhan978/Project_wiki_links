defmodule WikiLinks.Repo do
  use Ecto.Repo,
    otp_app: :wiki_links,
    adapter: Ecto.Adapters.Postgres
end
