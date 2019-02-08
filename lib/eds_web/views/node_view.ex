defmodule EdsWeb.NodeView do
  use EdsWeb, :public_view
  alias Eds.Content.Node
  alias EdsWeb.{TextView, ImageView}


  def prepare_content(node) do
    left =
      (Enum.filter(node.texts, fn text ->
         text.position == :left
       end) ++
         Enum.filter(node.images, fn image ->
           image.position == :left
         end))
      |> Enum.sort_by(& &1.weight)

    right =
      (Enum.filter(node.texts, fn text ->
         text.position == :right
       end) ++
         Enum.filter(node.images, fn image ->
           image.position == :right
         end))
      |> Enum.sort_by(& &1.weight)

    center =
      (Enum.filter(node.texts, fn text ->
         text.position == :center
       end) ++
         Enum.filter(node.images, fn image ->
           image.position == :center
         end))
      |> Enum.sort_by(& &1.weight)

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

end
