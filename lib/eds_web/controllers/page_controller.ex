defmodule EdsWeb.PageController do
  use EdsWeb, :controller
  alias Eds.Core.{Category}
  alias Eds.Repo

  def home(conn, _params) do
    render(conn, "home_page.html")
  end

  def category(conn, %{"id" => id}) do
    category = Repo.get!(Category, id) |> Category.preload_courses()

    render(conn, "index.html", courses: category.courses)
  end
end
