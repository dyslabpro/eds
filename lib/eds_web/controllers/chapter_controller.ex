defmodule EdsWeb.ChapterController do
  use EdsWeb, :controller

  alias Eds.Core
  alias Eds.Core.{Course, Chapter}

  def show(conn, %{"id" => id}) do
    chapter =
      Chapter.get_chapter!(id)
      |> Chapter.get_sections
      |> Chapter.preload_nodes

    course = Course.get_course!(chapter.course_id)
    sections = chapter.sections

    render(
      conn,
      "show.html",
      course: course,
      chapter: chapter,
      sections: sections
    )
  end
end
