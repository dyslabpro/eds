defmodule EdsWeb.Admin.PageController do
  use EdsWeb, :controller
  alias Eds.Core.Course
  alias Eds.Accounts.User

  def index(conn, _params) do
    user =
      conn.assigns[:current_user]
      |> User.preload_courses_by_role(1)

    courses =
      user.courses
      |> Course.preload_chapters_sections()

    render(conn, :index, courses: courses)
  end
end
