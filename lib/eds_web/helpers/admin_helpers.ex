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

  @spec get_breadcrumbs(any()) :: [%{path: <<_::48>>, title: <<_::32>>}, ...]
  def get_breadcrumbs(conn) do
    b = "conn.assigns[:breadcrumb]"
    breadcrumbs = [
      %{title: "Home", path: "/admin"}
    ]
    breadcrumbs
  end

end
