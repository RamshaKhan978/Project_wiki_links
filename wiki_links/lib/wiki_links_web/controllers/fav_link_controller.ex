defmodule WikiLinksWeb.FavLinkController do
alias WikiLinks.GeneratePdf.Pdf

  use WikiLinksWeb, :controller
  alias WikiLinks.Wiki_link
  alias WikiLinks.Wiki_link.Link


@doc """
show the list of link marked as faviourate
"""
  def index(conn, _params) do
    links = Wiki_link.list_fav_links()
    IO.inspect(links)
    render(conn, "index.html", links: links)
  end


@doc """
generate the PDF file through GenServer
"""
  def pdf(conn, _param) do
    links = Wiki_link.list_fav_links()
    html = Phoenix.View.render_to_string(WikiLinksWeb.FavLinkView,"pdf.html", links: links)

     case Pdf.generate_pdf(html)
     |> IO.inspect(label: "File Name")
      do
        {:ok,filename} ->
          :ok = File.rename(filename, Path.expand("~/Downloads/Favourite_links.pdf"))
      conn
      |> put_flash(:info, "PDF Saved")
      |> redirect(to: Routes.link_path(conn, :index))
     end



end



end
