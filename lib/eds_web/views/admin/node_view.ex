defmodule EdsWeb.Admin.NodeView do
  use EdsWeb, :admin_view
  alias Eds.Content.Node
  alias EdsWeb.Admin.{TextView, ImageView}

  def node_layout(node) do
    case node.layout do
      :default_1_column ->
        "_default_1_column.html"

      :default_2_columns_50_50 ->
        "_default_2_columns_50_50.html"

      :default_2_columns_25_75 ->
        "_default_2_columns_25_75.html"

      :default_2_columns_75_25 ->
        "_default_2_columns_75_25.html"

      :default_3_columns_33_33_33 ->
        "_default_3_columns_33_33_33.html"

      _else ->
        "show.html"
    end
  end

  def prepare_content(node) do
    left =
      Enum.filter(node.texts, fn text ->
        text.position == :left
      end) ++
        Enum.filter(node.images, fn image ->
          image.position == :left
        end)|> Enum.sort_by(& &1.weight)

    right =
      Enum.filter(node.texts, fn text ->
        text.position == :right
      end) ++
        Enum.filter(node.images, fn image ->
          image.position == :right
        end)|> Enum.sort_by(& &1.weight)

    center =
      Enum.filter(node.texts, fn text ->
        text.position == :center
      end) ++
        Enum.filter(node.images, fn image ->
          image.position == :center
        end)|> Enum.sort_by(& &1.weight)

    node =
      case node.layout do
        :default_1_column ->
          Map.put_new(node, :content, %{center: center})

        :default_2_columns_50_50 ->
          Map.put_new(node, :content, %{left: left, right: right})

        :default_2_columns_25_75 ->
          Map.put_new(node, :content, %{left: left, right: right})

        :default_2_columns_75_25 ->
          Map.put_new(node, :content, %{left: left, right: right})

        :default_3_columns_33_33_33 ->
          Map.put_new(node, :content, %{left: left, center: center, right: right})
      end
  end

  def render_node_content(assigns, content) do
    case content.__meta__.source do
      "texts" ->
        render(TextView, "_show_item.html", Map.put(assigns, :text, content))

      "images" ->
        render(ImageView, "_show_item.html", Map.put(assigns, :image, content))
    end
  end

  def node_edit_path(node, conn) do
    path =
      cond do
        node.section_id ->
          Routes.admin_section_node_path(conn, :edit, node.section_id, node.id)

        node.chapter_id ->
          Routes.admin_chapter_node_path(conn, :edit, node.chapter_id, node.id)

          node.course_id ->
            Routes.admin_course_node_path(conn, :edit, node.course_id, node.id)

        true ->
          "/admin"
      end
  end
  def node_update_path(node, conn) do
    path =
      cond do
        node.section_id ->
          Routes.admin_section_node_path(conn, :update, node.section_id, node)

        node.chapter_id ->
          Routes.admin_chapter_node_path(conn, :update, node.chapter_id, node)

          node.course_id ->
            Routes.admin_course_node_path(conn, :update, node.course_id, node)

        true ->
          "/admin"
      end
  end

  def layout_options do
    Eds.Content.Node.Layout.__enum_map__()
    |> Enum.map(fn({k, _v}) -> {String.capitalize(Atom.to_string(k)), k} end)
  end
end
