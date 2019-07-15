defmodule Eds.Content.QuizQuestion do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eds.Content.{Node, QuizQuestion}
  alias Eds.{Repo}
  import Ecto.Query
  use Eds.Content

  schema "quiz_questions" do
    field(:title, :string)
    field(:position, Position)
    field(:question, :string)
    field(:options, :string)
    field(:weight, :integer)
    belongs_to(:node, Node)

    timestamps()
  end

  def create(attrs \\ %{}) do
    %QuizQuestion{}
    |> QuizQuestion.changeset(attrs)
    |> Repo.insert()
  end

  def change(%QuizQuestion{} = quiz_question) do
    QuizQuestion.changeset(quiz_question, %{})
  end

  def get!(id), do: Repo.get!(QuizQuestion, id)

  def update(%QuizQuestion{} = quiz_question, attrs) do
    quiz_question
    |> QuizQuestion.changeset(attrs)
    |> Repo.update()
  end

  def delete(%QuizQuestion{} = quiz_question) do
    Repo.delete(quiz_question)
  end

  @doc false
  def changeset(%QuizQuestion{} = quiz_question, attrs) do
    quiz_question
    |> cast(attrs, [:title, :node_id, :question, :options, :weight, :position])
    |> validate_required([:question, :options, :node_id, :position])
    |> validate_position()
  end
end
