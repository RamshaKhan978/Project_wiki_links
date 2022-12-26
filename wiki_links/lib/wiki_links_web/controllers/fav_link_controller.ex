defmodule WikiLinksWeb.FavLinkController do
alias WikiLinks.GeneratePdf.Pdf

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
    html = Phoenix.View.render_to_string(WikiLinksWeb.FavLinkView,"pdf.html", links: links)

     case Pdf.generate_pdf(html)
     |> IO.inspect(label: "File Name")
      do
     {:ok,filename}  ->
      :ok = File.rename(filename, "./priv/static.pdf")
      conn
      |> put_resp_content_type("application/pdf", "utf-8")
      |> put_resp_header(
        "content-disposition",
        "attachment; filename=\"fav_link.pdf\""
        )
      |> put_flash(:info, "PDF Saved")
      |> redirect(to: Routes.link_path(conn, :index))
      |> send_file(200, filename)
     end




end



end
