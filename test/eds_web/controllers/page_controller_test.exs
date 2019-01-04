defmodule EdsWeb.PageControllerTest do
  use EdsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Добро пожаловать в Eds!"
  end

  @tag :as_admin
  test "home page for admin", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Панель преподователя"
  end

  @tag :as_student
  test "home page for student", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Мои курсы"
  end

  test "home page for anonimous", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Войти"
  end
end
