defmodule EdsWeb.ChapterControllerTest do
  use EdsWeb.ConnCase

  alias Eds.Core

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:chapter) do
    {:ok, chapter} = Core.create_chapter(@create_attrs)
    chapter
  end

  defp create_chapter(_) do
    chapter = fixture(:chapter)
    {:ok, chapter: chapter}
  end
end
