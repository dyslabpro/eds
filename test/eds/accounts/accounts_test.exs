defmodule Eds.AccountsTest do
  use Eds.DataCase

  alias Eds.Accounts

  describe "users" do
    alias Eds.Accounts.User

    @valid_attrs %{
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

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.admin == true
      assert user.auth_token == "some auth_token"
      assert user.auth_token_expires_at == ~N[2010-04-17 14:00:00.000000]
      assert user.avatar == "some avatar"
      assert user.email == "some email"
      assert user.facebook_handle == "some facebook_handle"
      assert user.google_handle == "some google_handle"
      assert user.handle == "some handle"
      assert user.joined_at == ~N[2010-04-17 14:00:00.000000]
      assert user.name == "some name"
      assert user.signed_in_at == ~N[2010-04-17 14:00:00.000000]
      assert user.student == true
      assert user.teacher == true
      assert user.twitter_handle == "some twitter_handle"
      assert user.website == "some website"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.admin == false
      assert user.auth_token == "some updated auth_token"
      assert user.auth_token_expires_at == ~N[2011-05-18 15:01:01.000000]
      assert user.avatar == "some updated avatar"
      assert user.email == "some updated email"
      assert user.facebook_handle == "some updated facebook_handle"
      assert user.google_handle == "some updated google_handle"
      assert user.handle == "some updated handle"
      assert user.joined_at == ~N[2011-05-18 15:01:01.000000]
      assert user.name == "some updated name"
      assert user.signed_in_at == ~N[2011-05-18 15:01:01.000000]
      assert user.student == false
      assert user.teacher == false
      assert user.twitter_handle == "some updated twitter_handle"
      assert user.website == "some updated website"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
