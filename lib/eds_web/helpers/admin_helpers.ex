defmodule Eds.Helpers.AdminHelpers do
  alias Eds.Accounts.User
  alias Eds.Core.{Course}

  def get_user_courses(conn) do
    user =
      conn.assigns[:current_user]
      |> User.preload_courses_by_role(1)

    user.courses
    |> Course.preload_chapters_sections()
  end

  def active_class(active_ids, key, id, class) do
    if Map.get(active_ids, key) == id do
      class
    else
      ""
    end
  end


  def get_breadcrumbs(_conn) do
    breadcrumbs = [
      %{title: "Home", path: "/admin"}
    ]
    breadcrumbs
  end

end
