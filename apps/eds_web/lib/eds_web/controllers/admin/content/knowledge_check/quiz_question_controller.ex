defmodule EdsWeb.Admin.QuizQuestionController do
  use EdsWeb, :controller


  alias Eds.Content.{Node, QuizQuestion}

  def new(conn, params) do
    changeset = QuizQuestion.changeset(%QuizQuestion{}, %{})

    render(
      conn,
      "new.html",
      changeset: changeset,
      course_id: params["course_id"],
      node_id: params["node_id"]
    )
  end

  def create(conn, %{"quiz_question" => quiz_question_params}) do
    quiz_question_params = Map.put_new(quiz_question_params, "node_id", conn.params["node_id"])

    case QuizQuestion.create(quiz_question_params) do
      {:ok, quiz_question} ->
        conn
        |> put_flash(:info, "QuizQuestion created successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, 1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    quiz_question = QuizQuestion.get!(id)
    node = Node.get!(quiz_question.node_id)
    changeset = QuizQuestion.changeset(quiz_question, %{})

    render(
      conn,
      "edit.html",
      node_id: node.id,
      quiz_question: quiz_question,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "quiz_question" => quiz_question_params}) do
    quiz_question = QuizQuestion.get!(id)

    case QuizQuestion.update(quiz_question, quiz_question_params) do
      {:ok, quiz_question} ->
        conn
        |> put_flash(:info, "QuizQuestion updated successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, 1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quiz_question: quiz_question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quiz_question = QuizQuestion.get!(id)
    {:ok, _quiz_question} = QuizQuestion.delete(quiz_question)
    conn
    |> put_flash(:info, "QuizQuestion deleted successfully.")
    |> redirect(to: NavigationHistory.last_path(conn, 2))
  end

end
