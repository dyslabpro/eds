defmodule EdsWeb.ChapterController do
  use EdsWeb, :controller

  alias Eds.Core
  alias Eds.Core.Chapter

  def show(conn, %{"id" => id}) do
    chapter = Core.get_chapter!(id) |> Chapter.get_sections()
    course = Core.get_course!(chapter.course_id)
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
