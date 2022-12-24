defmodule WikiLinksWeb.FavLinkController do
  use WikiLinksWeb, :controller
  alias WikiLinks.Wiki_link
  alias WikiLinks.Wiki_link.Link

  def index(conn, _params) do
    links = Wiki_link.list_fav_links()
    IO.inspect(links)
    render(conn, "index.html", links: links)
  end

  def pdf(conn, _param) do
    links = Wiki_link.list_fav_links()
    IO.inspect(links)
    html = Phoenix.View.render_to_string(WikiLinksWeb.FavLinkView,"pdf.html", links: links)
    case PdfGenerator.generate(html, page_size: "A4", shell_params: ["--dpi", "300"]) do
          {:ok, filename} ->
            IO.inspect(filename)
            :ok = File.rename(filename, "./Favourite_links.pdf")
            conn
            |> put_flash(:info, "PDF Saved")
            |> redirect(to: Routes.link_path(conn, :index))
            {:error, _changeset} ->
                    conn
                 |> put_flash(:error, "PDF Failed")
                 |> redirect(to: Routes.link_path(conn, :index))
            end
end



end
