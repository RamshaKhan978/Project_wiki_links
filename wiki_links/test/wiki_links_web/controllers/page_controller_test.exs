defmodule WikiLinksWeb.PageControllerTest do
  use WikiLinksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Wiki Links!"
  end
end
