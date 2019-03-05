defmodule EdsWeb.PageController do
  use EdsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def home(conn, _params) do
    render(conn, "home_page.html")
  end

  def category(conn, %{"id" => id}) do
    category = Eds.Core.Category.get_category_with_courses(id)

    render(conn, "index.html", courses: category.courses)
  end
end
