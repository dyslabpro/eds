defmodule EdsWeb.Plug.RequireAdmin do
  import Plug.Conn
  import Phoenix.Controller

  alias EdsWeb.Router.Helpers

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user = conn.assigns[:current_user]

    if user && user.admin do
      conn
    else
      conn
      |> put_flash(:error, "Admins only!")
      |> redirect(to: Helpers.user_path(conn, :home_page))
      |> halt()
    end
  end
end
