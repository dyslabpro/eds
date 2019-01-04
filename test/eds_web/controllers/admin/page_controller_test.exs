defmodule EdsWeb.Admin.PageControllerTest do
  use EdsWeb.ConnCase

  @tag :as_admin
  test "GET /admin", %{conn: conn} do
    conn = get(conn, "/admin")
    assert html_response(conn, 200) =~ "Dashboard"
  end
end
