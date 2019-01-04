defmodule EdsWeb.UserControllerTest do
  use EdsWeb.ConnCase

  alias Eds.Accounts

  @create_attrs %{
    admin: true,
    auth_token: "some auth_token",
    auth_token_expires_at: ~N[2010-04-17 14:00:00.000000],
    avatar: "some avatar",
    email: "some email",
    facebook_handle: "some facebook_handle",
    google_handle: "some google_handle",
    handle: "some handle",
    joined_at: ~N[2010-04-17 14:00:00.000000],
    name: "some name",
    signed_in_at: ~N[2010-04-17 14:00:00.000000],
    student: true,
    teacher: true,
    twitter_handle: "some twitter_handle",
    website: "some website"
  }
  @update_attrs %{
    admin: false,
    auth_token: "some updated auth_token",
    auth_token_expires_at: ~N[2011-05-18 15:01:01.000000],
    avatar: "some updated avatar",
    email: "some updated email",
    facebook_handle: "some updated facebook_handle",
    google_handle: "some updated google_handle",
    handle: "some updated handle",
    joined_at: ~N[2011-05-18 15:01:01.000000],
    name: "some updated name",
    signed_in_at: ~N[2011-05-18 15:01:01.000000],
    student: false,
    teacher: false,
    twitter_handle: "some updated twitter_handle",
    website: "some updated website"
  }
  @invalid_attrs %{
    admin: nil,
    auth_token: nil,
    auth_token_expires_at: nil,
    avatar: nil,
    email: nil,
    facebook_handle: nil,
    google_handle: nil,
    handle: nil,
    joined_at: nil,
    name: nil,
    signed_in_at: nil,
    student: nil,
    teacher: nil,
    twitter_handle: nil,
    website: nil
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
