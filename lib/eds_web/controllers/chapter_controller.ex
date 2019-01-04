defmodule EdsWeb.ChapterController do
  use EdsWeb, :controller

  alias Eds.Core
  alias Eds.Core.Chapter

  def show(conn, %{"id" => id}) do
    chapter = Core.get_chapter!(id) |> Chapter.get_sections()
    sections = chapter.sections
    render(conn, "show.html", chapter: chapter, sections: sections)
  end
end
