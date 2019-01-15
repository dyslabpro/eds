defmodule EdsWeb.SectionController do
  use EdsWeb, :controller

  alias Eds.Core
  alias Eds.Core.Section
  alias Eds.{Repo}

  def show(conn, %{"id" => id}) do
    section = Core.get_section!(id)

    chapter =
      Core.get_chapter!(section.chapter_id)
      |> Repo.preload(:sections)

    sections = chapter.sections
    course = Core.get_course!(chapter.course_id)
    prev = Section.get_prev_section(section, sections)
    next = Section.get_next_section(section, sections)

    render(
      conn,
      "show.html",
      course: course,
      chapter: chapter,
      section: section,
      sections: sections,
      next: next,
      prev: prev
    )
  end
end
