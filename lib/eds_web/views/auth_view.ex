defmodule EdsWeb.AuthView do
  use EdsWeb, :public_view

  alias Eds.Accounts.User

  def auth_path(conn, user) do
    {:ok, encoded} = User.encoded_auth(user)
    Routes.sign_in_path(conn, :create, encoded)
  end

  def auth_url(conn, user) do
    {:ok, encoded} = User.encoded_auth(user)
    Routes.sign_in_url(conn, :create, encoded)
  end
end
