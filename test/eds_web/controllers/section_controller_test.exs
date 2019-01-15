defmodule EdsWeb.SectionControllerTest do
  use EdsWeb.ConnCase

  alias Eds.Core

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:section) do
    {:ok, section} = Core.create_section(@create_attrs)
    section
  end

  defp create_section(_) do
    section = fixture(:section)
    {:ok, section: section}
  end
end
