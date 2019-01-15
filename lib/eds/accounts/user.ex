defmodule Eds.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Eds.Accounts.{UserCourse, User}
  alias Timex.Duration
  alias Eds.Repo

  schema "users" do
    field(:admin, :boolean, default: false)
    field(:auth_token, :string)
    field(:auth_token_expires_at, :naive_datetime)
    field(:avatar, :string)
    field(:email, :string)
    field(:facebook_handle, :string)
    field(:google_handle, :string)
    field(:handle, :string)
    field(:joined_at, :naive_datetime)
    field(:name, :string)
    field(:signed_in_at, :naive_datetime)
    field(:student, :boolean, default: false)
    field(:teacher, :boolean, default: false)
    field(:twitter_handle, :string)
    field(:website, :string)
    has_many(:user_courses, UserCourse, on_delete: :delete_all)
    has_many(:courses, through: [:user_courses, :course])

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email,
      :handle,
      :facebook_handle,
      :google_handle,
      :twitter_handle,
      :website,
      :auth_token,
      :auth_token_expires_at,
      :joined_at,
      :signed_in_at,
      :admin,
      :teacher,
      :student,
      :avatar
    ])
    |> validate_required([:name, :email, :handle])
    |> cast_assoc(:user_courses)
  end

  def preload_courses(user) do
    user
    |> Repo.preload(:user_courses)
    |> Repo.preload(:courses)
  end

  def auth_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(auth_token auth_token_expires_at))
  end

  def refresh_auth_token(user, expires_in \\ 30) do
    auth_token = Base.encode16(:crypto.strong_rand_bytes(8))
    expires_at = Timex.add(Timex.now(), Duration.from_minutes(expires_in))
    changeset = auth_changeset(user, %{auth_token: auth_token, auth_token_expires_at: expires_at})
    {:ok, user} = Repo.update(changeset)
    user
  end

  def encoded_auth(user) do
    {:ok, Base.encode16("#{user.email}|#{user.auth_token}")}
  end

  def decoded_auth(encoded) do
    {:ok, decoded} = Base.decode16(encoded)
    String.split(decoded, "|")
  end

  def sign_in_changeset(user) do
    change(user, %{
      auth_token: nil,
      auth_token_expires_at: nil,
      signed_in_at: Timex.now(),
      joined_at: user.joined_at || Timex.now()
    })
  end

  def preload_courses_by_role(user, role) do
    query = from(u in UserCourse, where: u.role == ^role)

    user
    |> Repo.preload(user_courses: query)
    |> Repo.preload(:courses)
  end
end
